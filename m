Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AFC6202A4
	for <e@80x24.org>; Sun, 10 Sep 2017 14:44:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751780AbdIJOog (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Sep 2017 10:44:36 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:45072 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751679AbdIJOoe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Sep 2017 10:44:34 -0400
Received: by mail-wm0-f44.google.com with SMTP id f199so25121600wme.0
        for <git@vger.kernel.org>; Sun, 10 Sep 2017 07:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/tICOmvlqdUk7vwHtC/ck4xflUdedXlB7dg9y0L/vyY=;
        b=fdiV6jpwFLmheLFZ+BG1UWm2BHu1zhzY/UzO3tx+Nho06xSHC6fK7/NtxrO9odHWz9
         /S7GjIXCT3toeenJ0Wsg7EgebGEmh/Yj7bUkpnTkGmlr8Y5d1z6uuPtbamQmfwKVZwu1
         g3Sl5oGdIlPK7d3V6hwcUe3o8cFdDFHYWZtg1PrP0pp20yyR6A7FJ3zcAu3XVZn7H4DW
         2GoegYnEf/epwP5gQCFv7xtqAc67ENfny/JKXFyGHiYYQUqC9dS3tRsqk/nIBcjVQbwS
         lNrGEgSbRWypREyP76kYR6TV+0ntl+gIdAOJmloDV83doNcJ0aphGT6xO0cYQSVhLhK6
         tDEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/tICOmvlqdUk7vwHtC/ck4xflUdedXlB7dg9y0L/vyY=;
        b=BOH0NC/2b/bN+UVGWC//Ebgkpq4Vu7zQWvhsX/+izPktbMKtMIULIa6Mm1OH1MoyHF
         urTvfxjcGGClFNJ0u+ZfXbErj+8Ys2fGt3P7JN6LBdoqBzj4d3CZv2k1BpmKiFoZecCx
         5gyiLVhQQNTHqe+2n3+MAZN3uKXUjd97pDMUUY1loH9eBOyl8+rFRE1iP+45t4GRXfkd
         jKWkhEJVbIpHSqihYaWF8MQ+rZIGzS42qzs2cgKfkd8AwiC1W0DhNU1SI6q3e7T8VySK
         FIA1JjgQ2Zzvk05UW0JozaeynN9HOzluzrb3G9eTPyA0ZGt6SxSOBifAlRmJhoT0yETZ
         JLPg==
X-Gm-Message-State: AHPjjUgNWBXj279fg006XJoR6tpz2YWhtaCaqxK4Oc4h81VJxbSFc8vM
        ttsyvHCjiF+6abVs
X-Google-Smtp-Source: AOwi7QDkBhvmENF1jGpANA1qB0uHJ4ZDpS8Lnivwjh4LZsXSADRtVBBQL631Asa/ho61LLcim5bKUw==
X-Received: by 10.28.63.134 with SMTP id m128mr3227594wma.137.1505054672531;
        Sun, 10 Sep 2017 07:44:32 -0700 (PDT)
Received: from slxBook4.fritz.box (p5DDB7AFE.dip0.t-ipconnect.de. [93.219.122.254])
        by smtp.gmail.com with ESMTPSA id 4sm6961223wmg.20.2017.09.10.07.44.31
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 10 Sep 2017 07:44:31 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v1 1/2] travis-ci: move Travis CI code into dedicated scripts
Date:   Sun, 10 Sep 2017 16:44:28 +0200
Message-Id: <20170910144429.47346-2-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20170910144429.47346-1-larsxschneider@gmail.com>
References: <20170910144429.47346-1-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Most of the Travis CI commands are in the '.travis.yml'. The yml format
does not support functions and therefore code duplication is necessary
to run commands across all builds.

To fix this, add a library for common CI functions. Move all Travis CI
code into dedicated scripts and make them call the library first.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 .travis.yml                | 88 +++++-----------------------------------------
 ci/install-dependencies.sh | 43 ++++++++++++++++++++++
 ci/lib-travisci.sh         |  5 +++
 ci/print-test-failures.sh  | 18 ++++++++++
 ci/run-build.sh            |  8 +++++
 ci/run-linux32-docker.sh   | 23 ++++++++++++
 ci/run-static-analysis.sh  |  8 +++++
 ci/run-tests.sh            | 10 ++++++
 ci/run-windows-build.sh    |  2 ++
 ci/test-documentation.sh   |  4 ++-
 10 files changed, 128 insertions(+), 81 deletions(-)
 create mode 100755 ci/install-dependencies.sh
 create mode 100755 ci/lib-travisci.sh
 create mode 100755 ci/print-test-failures.sh
 create mode 100755 ci/run-build.sh
 create mode 100755 ci/run-linux32-docker.sh
 create mode 100755 ci/run-static-analysis.sh
 create mode 100755 ci/run-tests.sh

diff --git a/.travis.yml b/.travis.yml
index 278943d14a..fead995edd 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -61,23 +61,8 @@ matrix:
       services:
         - docker
       before_install:
-        - docker pull daald/ubuntu32:xenial
       before_script:
-      script:
-        - >
-          docker run
-          --interactive
-          --env DEVELOPER
-          --env DEFAULT_TEST_TARGET
-          --env GIT_PROVE_OPTS
-          --env GIT_TEST_OPTS
-          --env GIT_TEST_CLONE_2GB
-          --volume "${PWD}:/usr/src/git"
-          daald/ubuntu32:xenial
-          /usr/src/git/ci/run-linux32-build.sh $(id -u $USER)
-        # Use the following command to debug the docker build locally:
-        # $ docker run -itv "${PWD}:/usr/src/git" --entrypoint /bin/bash daald/ubuntu32:xenial
-        # root@container:/# /usr/src/git/ci/run-linux32-build.sh
+      script: ci/run-linux32-docker.sh
     - env: Static Analysis
       os: linux
       compiler:
@@ -86,9 +71,8 @@ matrix:
           packages:
           - coccinelle
       before_install:
-      script:
-        # "before_script" that builds Git is inherited from base job
-        - make coccicheck
+      # "before_script" that builds Git is inherited from base job
+      script: ci/run-static-analysis.sh
       after_failure:
     - env: Documentation
       os: linux
@@ -99,70 +83,14 @@ matrix:
           - asciidoc
           - xmlto
       before_install:
-      before_script: gem install asciidoctor
+      before_script:
       script: ci/test-documentation.sh
       after_failure:
 
-before_install:
-  - >
-    case "${TRAVIS_OS_NAME:-linux}" in
-    linux)
-      export GIT_TEST_HTTPD=YesPlease
-
-      mkdir --parents custom/p4
-      pushd custom/p4
-        wget --quiet http://filehost.perforce.com/perforce/r$LINUX_P4_VERSION/bin.linux26x86_64/p4d
-        wget --quiet http://filehost.perforce.com/perforce/r$LINUX_P4_VERSION/bin.linux26x86_64/p4
-        chmod u+x p4d
-        chmod u+x p4
-        export PATH="$(pwd):$PATH"
-      popd
-      mkdir --parents custom/git-lfs
-      pushd custom/git-lfs
-        wget --quiet https://github.com/github/git-lfs/releases/download/v$LINUX_GIT_LFS_VERSION/git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz
-        tar --extract --gunzip --file "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz"
-        cp git-lfs-$LINUX_GIT_LFS_VERSION/git-lfs .
-        export PATH="$(pwd):$PATH"
-      popd
-      ;;
-    osx)
-      brew update --quiet
-      # Uncomment this if you want to run perf tests:
-      # brew install gnu-time
-      brew install git-lfs gettext
-      brew link --force gettext
-      brew install caskroom/cask/perforce
-      ;;
-    esac;
-    echo "$(tput setaf 6)Perforce Server Version$(tput sgr0)";
-    p4d -V | grep Rev.;
-    echo "$(tput setaf 6)Perforce Client Version$(tput sgr0)";
-    p4 -V | grep Rev.;
-    echo "$(tput setaf 6)Git-LFS Version$(tput sgr0)";
-    git-lfs version;
-
-before_script: make --jobs=2
-
-script:
-  - >
-    mkdir -p $HOME/travis-cache;
-    ln -s $HOME/travis-cache/.prove t/.prove;
-    make --quiet test;
-
-after_failure:
-  - >
-    : '<-- Click here to see detailed test output!                                                        ';
-    for TEST_EXIT in t/test-results/*.exit;
-    do
-      if [ "$(cat "$TEST_EXIT")" != "0" ];
-      then
-        TEST_OUT="${TEST_EXIT%exit}out";
-        echo "------------------------------------------------------------------------";
-        echo "$(tput setaf 1)${TEST_OUT}...$(tput sgr0)";
-        echo "------------------------------------------------------------------------";
-        cat "${TEST_OUT}";
-      fi;
-    done;
+before_install: ci/install-dependencies.sh
+before_script: ci/run-build.sh
+script: ci/run-tests.sh
+after_failure: ci/print-test-failures.sh
 
 notifications:
   email: false
diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
new file mode 100755
index 0000000000..067e6eb702
--- /dev/null
+++ b/ci/install-dependencies.sh
@@ -0,0 +1,43 @@
+#!/usr/bin/env bash
+#
+# Install dependencies required to build and test Git on Linux and macOS
+#
+
+. ${0%/*}/lib-travisci.sh
+
+case "${TRAVIS_OS_NAME:-linux}" in
+	linux)
+		export GIT_TEST_HTTPD=YesPlease
+
+		mkdir --parents custom/p4
+		pushd custom/p4
+			wget --quiet http://filehost.perforce.com/perforce/r$LINUX_P4_VERSION/bin.linux26x86_64/p4d
+			wget --quiet http://filehost.perforce.com/perforce/r$LINUX_P4_VERSION/bin.linux26x86_64/p4
+			chmod u+x p4d
+			chmod u+x p4
+			export PATH="$(pwd):$PATH"
+		popd
+		mkdir --parents custom/git-lfs
+		pushd custom/git-lfs
+			wget --quiet https://github.com/github/git-lfs/releases/download/v$LINUX_GIT_LFS_VERSION/git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz
+			tar --extract --gunzip --file "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz"
+			cp git-lfs-$LINUX_GIT_LFS_VERSION/git-lfs .
+			export PATH="$(pwd):$PATH"
+		popd
+	;;
+	osx)
+		brew update --quiet
+		# Uncomment this if you want to run perf tests:
+		# brew install gnu-time
+		brew install git-lfs gettext
+		brew link --force gettext
+		brew install caskroom/cask/perforce
+	;;
+esac
+
+echo "$(tput setaf 6)Perforce Server Version$(tput sgr0)"
+p4d -V | grep Rev.
+echo "$(tput setaf 6)Perforce Client Version$(tput sgr0)"
+p4 -V | grep Rev.
+echo "$(tput setaf 6)Git-LFS Version$(tput sgr0)"
+git-lfs version
diff --git a/ci/lib-travisci.sh b/ci/lib-travisci.sh
new file mode 100755
index 0000000000..44d6ba2dd2
--- /dev/null
+++ b/ci/lib-travisci.sh
@@ -0,0 +1,5 @@
+# Library of functions shared by all CI scripts
+
+# Set 'exit on error' for all CI scripts to let the caller know that
+# something went wrong
+set -e
diff --git a/ci/print-test-failures.sh b/ci/print-test-failures.sh
new file mode 100755
index 0000000000..8583e61839
--- /dev/null
+++ b/ci/print-test-failures.sh
@@ -0,0 +1,18 @@
+#!/bin/sh
+#
+# Print output of failing tests
+#
+
+. ${0%/*}/lib-travisci.sh
+
+for TEST_EXIT in t/test-results/*.exit
+	do
+		if [ "$(cat "$TEST_EXIT")" != "0" ]
+		then
+			TEST_OUT="${TEST_EXIT%exit}out"
+			echo "------------------------------------------------------------------------"
+			echo "$(tput setaf 1)${TEST_OUT}...$(tput sgr0)"
+			echo "------------------------------------------------------------------------"
+			cat "${TEST_OUT}"
+		fi
+done
diff --git a/ci/run-build.sh b/ci/run-build.sh
new file mode 100755
index 0000000000..4f940d1032
--- /dev/null
+++ b/ci/run-build.sh
@@ -0,0 +1,8 @@
+#!/bin/sh
+#
+# Build Git
+#
+
+. ${0%/*}/lib-travisci.sh
+
+make --jobs=2
diff --git a/ci/run-linux32-docker.sh b/ci/run-linux32-docker.sh
new file mode 100755
index 0000000000..0edf63acfa
--- /dev/null
+++ b/ci/run-linux32-docker.sh
@@ -0,0 +1,23 @@
+#!/bin/sh
+#
+# Download and run Docker image to build and test 32-bit Git
+#
+
+. ${0%/*}/lib-travisci.sh
+
+docker pull daald/ubuntu32:xenial
+
+# Use the following command to debug the docker build locally:
+# $ docker run -itv "${PWD}:/usr/src/git" --entrypoint /bin/bash daald/ubuntu32:xenial
+# root@container:/# /usr/src/git/ci/run-linux32-build.sh
+
+docker run \
+	--interactive \
+	--env DEVELOPER \
+	--env DEFAULT_TEST_TARGET \
+	--env GIT_PROVE_OPTS \
+	--env GIT_TEST_OPTS \
+	--env GIT_TEST_CLONE_2GB \
+	--volume "${PWD}:/usr/src/git" \
+	daald/ubuntu32:xenial \
+	/usr/src/git/ci/run-linux32-build.sh $(id -u $USER)
diff --git a/ci/run-static-analysis.sh b/ci/run-static-analysis.sh
new file mode 100755
index 0000000000..68dd0f080e
--- /dev/null
+++ b/ci/run-static-analysis.sh
@@ -0,0 +1,8 @@
+#!/bin/sh
+#
+# Perform various static code analysis checks
+#
+
+. ${0%/*}/lib-travisci.sh
+
+make coccicheck
diff --git a/ci/run-tests.sh b/ci/run-tests.sh
new file mode 100755
index 0000000000..f0c743de94
--- /dev/null
+++ b/ci/run-tests.sh
@@ -0,0 +1,10 @@
+#!/bin/sh
+#
+# Test Git
+#
+
+. ${0%/*}/lib-travisci.sh
+
+mkdir -p $HOME/travis-cache
+ln -s $HOME/travis-cache/.prove t/.prove
+make --quiet test
diff --git a/ci/run-windows-build.sh b/ci/run-windows-build.sh
index 2d98f6b2f9..8757b3a97c 100755
--- a/ci/run-windows-build.sh
+++ b/ci/run-windows-build.sh
@@ -6,6 +6,8 @@
 # supported) and a commit hash.
 #
 
+. ${0%/*}/lib-travisci.sh
+
 test $# -ne 2 && echo "Unexpected number of parameters" && exit 1
 test -z "$GFW_CI_TOKEN" && echo "GFW_CI_TOKEN not defined" && exit
 
diff --git a/ci/test-documentation.sh b/ci/test-documentation.sh
index 6214e6acb4..7a0a848e83 100755
--- a/ci/test-documentation.sh
+++ b/ci/test-documentation.sh
@@ -3,7 +3,9 @@
 # Perform sanity checks on documentation and build it.
 #
 
-set -e
+. ${0%/*}/lib-travisci.sh
+
+gem install asciidoctor
 
 make check-builtins
 make check-docs
-- 
2.14.1

