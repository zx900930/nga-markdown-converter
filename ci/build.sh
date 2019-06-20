#!/bin/bash

main() {
	# Only push
	if [[ "$TRAVIS_EVENT_TYPE" != "push" ]];then
		echo -e "Not push, skip deploy www\n"
		return 0
	fi

	github_repo="GKD-OW/nga-markdown-converter"
	github_branch="gh-pages"

	# Build
	cd $TRAVIS_BUILD_DIR
	yarn
	yarn build

	# Copy all files
	cp $TRAVIS_BUILD_DIR/ci/www/* $TRAVIS_BUILD_DIR/build/

	# Upload
	cd $TRAVIS_BUILD_DIR/build/
	git init
	git config user.name "Deployment Bot"
	git config user.email "deploy@travis-ci.org"
	git add .
	git commit -m "Automatic deployment"
	git push --force --quiet "https://${GITHUB_TOKEN}@github.com/${github_repo}.git" master:$github_branch
}

main