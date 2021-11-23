Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0363DC433EF
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 16:29:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232982AbhKWQcq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 11:32:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhKWQcp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 11:32:45 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7BFC061574
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 08:29:37 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 133so19308483wme.0
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 08:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=230yaiZ2A2YGaPuKuo36yqyY8I2MSZU1XEoNXG+yo1A=;
        b=D6k2niVxQGamHjz0WFmGXvlaCjw3jJRPfO3tBad5FTdndShvPsFVV7qnkyohaicAhs
         9hWgRAUP/pjo1AU2zFmZSjOyyk0D2lNLaoM/G2B6g5m9nE69JnKpWcPsiahTFXfleYWl
         no6uMT0kQjlG9KL9cmm6Zd0QivmPdLgf4wEpBdV2jHyZqFn/d908fND5NeJ5TlHwjcmT
         bnzg1HUhUhuREV9fWuq/WfxH9V5aMO9WZwCAEHFt0OOnIvXeoDAj3ZVm958zPPAKBvxB
         JTahK9+ptNZYGHOktW7fgflOM7Tfn6QHaLvqG7Ghh/xKmRc+k63F+n2KAgRGkovXW4CO
         rvpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=230yaiZ2A2YGaPuKuo36yqyY8I2MSZU1XEoNXG+yo1A=;
        b=Kv3yD6Ih+XoZt2kHArc/QBzywdOCY1ryYS0OejnKZ+z3qFkh0ukKzc6yw0q0dKG+wr
         L8aWDgvTF+A5gZUMIJVscio4CSi4GziMAhCt1+KmjrjQvjalvKEUmotj2KN6z+OsAaJx
         W6oIuwQYJV91lgAP0f+GV31/PIbLHvYyJ6E3UCPWxR4LFvvowdeVqVZArKRbFg4+vtdx
         QR4EkJ52+lgrjf8rQgcWHVRIMNXYFoHgG5R9ubvD2xKq/1CvO/fGWz/9/48Q71jQZiow
         XR+bhy7vMqJdR2y6dRxyC8NIRKPFqfPAf00Tfpc5h4zeKZgeRtgmA7ZtdCq5wrAbwUW4
         JxeA==
X-Gm-Message-State: AOAM533RPlcBDC6oFW0AiHltNkSajfQD4OXKT5wrU2UWmPO90+R/7Thv
        5hNFYweSarTYhSUS4no2Lkx8kkvR2qpCBQ==
X-Google-Smtp-Source: ABdhPJzlRM2AncHJk79i5AUp1HW/gZOaG42IrIs8wrfFwKXOUJ1SMAVDi6NfsSK6TlIC3kO3lwlGeg==
X-Received: by 2002:a1c:4c19:: with SMTP id z25mr4604389wmf.177.1637684975481;
        Tue, 23 Nov 2021 08:29:35 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h22sm2059940wmq.14.2021.11.23.08.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 08:29:33 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Victoria Dye <vdye@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 1/5] CI: remove Travis CI support
Date:   Tue, 23 Nov 2021 17:29:08 +0100
Message-Id: <patch-v4-1.5-6a4f1961cd2-20211123T134300Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.830.g6387a5d107e
In-Reply-To: <cover-v4-0.5-00000000000-20211123T134300Z-avarab@gmail.com>
References: <cover-v3-0.5-00000000000-20211120T115414Z-avarab@gmail.com> <cover-v4-0.5-00000000000-20211123T134300Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove support for running the CI in travis. The last builds in it are
from 5 months ago[1] (as of 2021-11-19), and our documentation has
referred to GitHub CI instead since f003a91f5c5 (SubmittingPatches:
replace discussion of Travis with GitHub Actions, 2021-07-22).

We'll now run the "t9810 t9816" and tests on OSX. We didn't before, as
we'd carried the Travis exclusion of them forward from
522354d70f4 (Add Travis CI support, 2015-11-27). Let's hope whatever
issue there was with them was either Travis specific, or fixed since
then (I'm not sure).

The "apt-add-repository" invocation (which we were doing in GitHub CI)
isn't needed, it was another Travis-only case that was carried forward
into more general code. See 0f0c51181df (travis-ci: install packages
in 'ci/install-dependencies.sh', 2018-11-01).

Remove the "linux-gcc-4.8" job added in fb9d7431cf4 (travis-ci: build
with GCC 4.8 as well, 2019-07-18), it only ran in Travis CI.

1. https://travis-ci.org/github/git/git/builds

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .travis.yml                | 60 --------------------------------------
 ci/install-dependencies.sh |  3 +-
 ci/lib.sh                  | 37 ++---------------------
 ci/print-test-failures.sh  | 10 -------
 ci/run-build-and-tests.sh  |  4 +--
 ci/run-docker-build.sh     |  9 ------
 ci/run-docker.sh           |  2 +-
 7 files changed, 7 insertions(+), 118 deletions(-)
 delete mode 100644 .travis.yml

diff --git a/.travis.yml b/.travis.yml
deleted file mode 100644
index 908330a0a3d..00000000000
--- a/.travis.yml
+++ /dev/null
@@ -1,60 +0,0 @@
-language: c
-
-cache:
-  directories:
-    - $HOME/travis-cache
-
-os:
-  - linux
-  - osx
-
-osx_image: xcode10.1
-
-compiler:
-  - clang
-  - gcc
-
-matrix:
-  include:
-    - env: jobname=linux-gcc-default
-      os: linux
-      compiler:
-      addons:
-      before_install:
-    - env: jobname=linux-gcc-4.8
-      os: linux
-      dist: trusty
-      compiler:
-    - env: jobname=Linux32
-      os: linux
-      compiler:
-      addons:
-      services:
-        - docker
-      before_install:
-      script: ci/run-docker.sh
-    - env: jobname=linux-musl
-      os: linux
-      compiler:
-      addons:
-      services:
-        - docker
-      before_install:
-      script: ci/run-docker.sh
-    - env: jobname=StaticAnalysis
-      os: linux
-      compiler:
-      script: ci/run-static-analysis.sh
-      after_failure:
-    - env: jobname=Documentation
-      os: linux
-      compiler:
-      script: ci/test-documentation.sh
-      after_failure:
-
-before_install: ci/install-dependencies.sh
-script: ci/run-build-and-tests.sh
-after_failure: ci/print-test-failures.sh
-
-notifications:
-  email: false
diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 1d0e48f4515..49a4ae7a988 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -13,7 +13,6 @@ UBUNTU_COMMON_PKGS="make libssl-dev libcurl4-openssl-dev libexpat-dev
 
 case "$jobname" in
 linux-clang|linux-gcc|linux-leaks)
-	sudo apt-add-repository -y "ppa:ubuntu-toolchain-r/test"
 	sudo apt-get -q update
 	sudo apt-get -q -y install language-pack-is libsvn-perl apache2 \
 		$UBUNTU_COMMON_PKGS
@@ -77,7 +76,7 @@ Documentation)
 	test -n "$ALREADY_HAVE_ASCIIDOCTOR" ||
 	sudo gem install --version 1.5.8 asciidoctor
 	;;
-linux-gcc-default|linux-gcc-4.8)
+linux-gcc-default)
 	sudo apt-get -q update
 	sudo apt-get -q -y install $UBUNTU_COMMON_PKGS
 	;;
diff --git a/ci/lib.sh b/ci/lib.sh
index 82cb17f8eea..73d959e87f7 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -34,7 +34,7 @@ save_good_tree () {
 # successfully before (e.g. because the branch got rebased, changing only
 # the commit messages).
 skip_good_tree () {
-	if test "$TRAVIS_DEBUG_MODE" = true || test true = "$GITHUB_ACTIONS"
+	if test true = "$GITHUB_ACTIONS"
 	then
 		return
 	fi
@@ -60,7 +60,7 @@ skip_good_tree () {
 			cat <<-EOF
 			$(tput setaf 2)Skipping build job for commit $CI_COMMIT.$(tput sgr0)
 			This commit's tree has already been built and tested successfully in build job $prev_good_job_number for commit $prev_good_commit.
-			The log of that build job is available at $(url_for_job_id $prev_good_job_id)
+			The log of that build job is available at $SYSTEM_TASKDEFINITIONSURI$SYSTEM_TEAMPROJECT/_build/results?buildId=$prev_good_job_id
 			To force a re-build delete the branch's cache and then hit 'Restart job'.
 			EOF
 		fi
@@ -91,29 +91,7 @@ export MAKEFLAGS=
 # and installing dependencies.
 set -ex
 
-if test true = "$TRAVIS"
-then
-	CI_TYPE=travis
-	# When building a PR, TRAVIS_BRANCH refers to the *target* branch. Not
-	# what we want here. We want the source branch instead.
-	CI_BRANCH="${TRAVIS_PULL_REQUEST_BRANCH:-$TRAVIS_BRANCH}"
-	CI_COMMIT="$TRAVIS_COMMIT"
-	CI_JOB_ID="$TRAVIS_JOB_ID"
-	CI_JOB_NUMBER="$TRAVIS_JOB_NUMBER"
-	CI_OS_NAME="$TRAVIS_OS_NAME"
-	CI_REPO_SLUG="$TRAVIS_REPO_SLUG"
-
-	cache_dir="$HOME/travis-cache"
-
-	url_for_job_id () {
-		echo "https://travis-ci.org/$CI_REPO_SLUG/jobs/$1"
-	}
-
-	BREW_INSTALL_PACKAGES="git-lfs gettext"
-	export GIT_PROVE_OPTS="--timer --jobs 3 --state=failed,slow,save"
-	export GIT_TEST_OPTS="--verbose-log -x --immediate"
-	MAKEFLAGS="$MAKEFLAGS --jobs=2"
-elif test -n "$SYSTEM_COLLECTIONURI" || test -n "$SYSTEM_TASKDEFINITIONSURI"
+if test -n "$SYSTEM_COLLECTIONURI" || test -n "$SYSTEM_TASKDEFINITIONSURI"
 then
 	CI_TYPE=azure-pipelines
 	# We are running in Azure Pipelines
@@ -130,10 +108,6 @@ then
 	# among *all* phases)
 	cache_dir="$HOME/test-cache/$SYSTEM_PHASENAME"
 
-	url_for_job_id () {
-		echo "$SYSTEM_TASKDEFINITIONSURI$SYSTEM_TEAMPROJECT/_build/results?buildId=$1"
-	}
-
 	export GIT_PROVE_OPTS="--timer --jobs 10 --state=failed,slow,save"
 	export GIT_TEST_OPTS="--verbose-log -x --write-junit-xml"
 	MAKEFLAGS="$MAKEFLAGS --jobs=10"
@@ -214,11 +188,6 @@ osx-clang|osx-gcc)
 	else
 		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=$(which python2)"
 	fi
-
-	# t9810 occasionally fails on Travis CI OS X
-	# t9816 occasionally fails with "TAP out of sequence errors" on
-	# Travis CI OS X
-	export GIT_SKIP_TESTS="t9810 t9816"
 	;;
 linux-gcc-default)
 	;;
diff --git a/ci/print-test-failures.sh b/ci/print-test-failures.sh
index c70d6cdbf24..57277eefcd0 100755
--- a/ci/print-test-failures.sh
+++ b/ci/print-test-failures.sh
@@ -39,8 +39,6 @@ do
 		test_name="${test_name##*/}"
 		trash_dir="trash directory.$test_name"
 		case "$CI_TYPE" in
-		travis)
-			;;
 		azure-pipelines)
 			mkdir -p failed-test-artifacts
 			mv "$trash_dir" failed-test-artifacts
@@ -88,11 +86,3 @@ do
 		fi
 	fi
 done
-
-if [ $combined_trash_size -gt 0 ]
-then
-	echo "------------------------------------------------------------------------"
-	echo "Trash directories embedded in this log can be extracted by running:"
-	echo
-	echo "  curl https://api.travis-ci.org/v3/job/$TRAVIS_JOB_ID/log.txt |./ci/util/extract-trash-dirs.sh"
-fi
diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index cc62616d806..18056501ec2 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -41,9 +41,9 @@ linux-clang)
 	export GIT_TEST_DEFAULT_HASH=sha256
 	make test
 	;;
-linux-gcc-4.8|pedantic)
+pedantic)
 	# Don't run the tests; we only care about whether Git can be
-	# built with GCC 4.8 or with pedantic
+	# built.
 	;;
 *)
 	make test
diff --git a/ci/run-docker-build.sh b/ci/run-docker-build.sh
index 8d47a5fda3b..5d2764ad3a3 100755
--- a/ci/run-docker-build.sh
+++ b/ci/run-docker-build.sh
@@ -47,15 +47,6 @@ else
 	else
 		useradd -u $HOST_UID $CI_USER
 	fi
-
-	# Due to a bug the test suite was run as root in the past, so
-	# a prove state file created back then is only accessible by
-	# root.  Now that bug is fixed, the test suite is run as a
-	# regular user, but the prove state file coming from Travis
-	# CI's cache might still be owned by root.
-	# Make sure that this user has rights to any cached files,
-	# including an existing prove state file.
-	test -n "$cache_dir" && chown -R $HOST_UID:$HOST_UID "$cache_dir"
 fi
 
 # Build and test
diff --git a/ci/run-docker.sh b/ci/run-docker.sh
index 37fa372052d..b610dd4db84 100755
--- a/ci/run-docker.sh
+++ b/ci/run-docker.sh
@@ -25,7 +25,7 @@ docker pull "$CI_CONTAINER"
 # root@container:/# export jobname=<jobname>
 # root@container:/# /usr/src/git/ci/run-docker-build.sh <host-user-id>
 
-container_cache_dir=/tmp/travis-cache
+container_cache_dir=/tmp/container-cache
 
 docker run \
 	--interactive \
-- 
2.34.0.830.gb9cdc59c8af

