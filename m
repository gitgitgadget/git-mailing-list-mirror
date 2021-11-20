Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB9E1C433EF
	for <git@archiver.kernel.org>; Sat, 20 Nov 2021 03:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233856AbhKTDbu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 22:31:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233025AbhKTDbr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 22:31:47 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8FFDC061574
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 19:28:44 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id d24so21435868wra.0
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 19:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hLwseEUIVmSg64YrQZCuGcVrzAQbkJSeMI7KqpNJ50E=;
        b=TaMy6mk8Pg2NOh7wpMaIVWlJiWAd/WsnW261N9p25H5ZH3MVR/hbYxh9IEH3uEyDRG
         aKCFLXuFuVtOjspBy5bF9P5mPdPWBJBLzZteYd3WAg7Nhnsj6ESl01/hXO8FoKBr2znm
         1/XEo5MS7gRVpVrzPuJ5tmVxF8Ir10ohnPSZpyhBvA3H0i41rZ4uICa1bhro685+cgG9
         j/a9r+TMqpkkofu8CznET8Q+Kg1LWnlel/NeUkeWFLQBETluDz33+46qrL60SQZH3lRF
         Vp80q3j/HodVqP8KDlojHPupXwgCDeE52SIltEDK8bWT6BcGvGwILiwq/m45BjVVlySn
         RAnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hLwseEUIVmSg64YrQZCuGcVrzAQbkJSeMI7KqpNJ50E=;
        b=1R1pert8Wv64Dngpv9vTk2CUPArDPNvgT76dU0foXc0hAusX7X8XbUNyIXVV8ZwH/T
         GOUwil9pYBtne9J3r1nb+352clMocQzWS3/eK11M36dZJyaesXPN/DMflc1OB4Re3IeE
         0Z5nNeMM2WRArppN7VU08ucDM4EuOGg+FFLUoR8V6uKtJggE7zt2kWxv8GpdRprz0UJe
         aXZPRjVKQaWCgIAq6f+BZfAfkADqw6buA5TrybDQ2FmnfA5NyCjFYziu6MWOrp/Hoyb+
         L1p3ep+GAzksIavzYxYogWxeNw1+ON4Gsb+nL6ua1cqbZhtfLcuvnW8a3QR9L7dTe/2z
         bySQ==
X-Gm-Message-State: AOAM532lKPlKdmqS6MHJEyopwPor8rubIyQAJSq6ogEmRfKoPuCcjG36
        p2SB0pQclY+m6bE5IR+5m0MiI1vl2uQuvg==
X-Google-Smtp-Source: ABdhPJxklFJZYBsDRcAUqZSP5vZ9npJgvVm2Vi7ssbmwTUzCrZxX29xIEY/uQHuyB90Binkw3CT3hw==
X-Received: by 2002:a05:6000:1a41:: with SMTP id t1mr13837100wry.261.1637378922822;
        Fri, 19 Nov 2021 19:28:42 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o12sm1560623wmq.12.2021.11.19.19.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 19:28:42 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Victoria Dye <vdye@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/6] CI: remove Travis CI support
Date:   Sat, 20 Nov 2021 04:28:31 +0100
Message-Id: <patch-v2-1.6-cc94a353ccb-20211120T030848Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.823.gcc3243ae16c
In-Reply-To: <cover-v2-0.6-00000000000-20211120T030848Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20211119T135343Z-avarab@gmail.com> <cover-v2-0.6-00000000000-20211120T030848Z-avarab@gmail.com>
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

1. https://travis-ci.org/github/git/git/builds

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .travis.yml                | 60 --------------------------------------
 ci/install-dependencies.sh |  1 -
 ci/lib.sh                  | 37 ++---------------------
 ci/print-test-failures.sh  | 10 -------
 ci/run-docker-build.sh     |  9 ------
 ci/run-docker.sh           |  2 +-
 6 files changed, 4 insertions(+), 115 deletions(-)
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
index 1d0e48f4515..92e11c7198e 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -13,7 +13,6 @@ UBUNTU_COMMON_PKGS="make libssl-dev libcurl4-openssl-dev libexpat-dev
 
 case "$jobname" in
 linux-clang|linux-gcc|linux-leaks)
-	sudo apt-add-repository -y "ppa:ubuntu-toolchain-r/test"
 	sudo apt-get -q update
 	sudo apt-get -q -y install language-pack-is libsvn-perl apache2 \
 		$UBUNTU_COMMON_PKGS
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
2.34.0.823.gcc3243ae16c

