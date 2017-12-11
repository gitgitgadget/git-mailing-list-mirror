Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3C1E1F404
	for <e@80x24.org>; Mon, 11 Dec 2017 23:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751831AbdLKXfa (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Dec 2017 18:35:30 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:45217 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751492AbdLKXf3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Dec 2017 18:35:29 -0500
Received: by mail-wr0-f195.google.com with SMTP id h1so19274256wre.12
        for <git@vger.kernel.org>; Mon, 11 Dec 2017 15:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8vxIBT8lv1w6KFsMfn4j0yz6q+4rF8D5BX2DYDWV9Xo=;
        b=fsemowuGGZqmL1gSQFRexdEk5DoOOHSYEidjIeGFwm8gEN2MZ4Ia+MkiJ6qVbAUP6f
         Tifx59Wfhfv6hS3PsvubiWQxQsu8Ini+dgUSISuGTqcmW5cNYNUIqtgfJKVRpWO9LAqi
         VRJuwI4JvnC/cTfPmw5DIVFNMa2dMdeyiadYCPKTx08U6wZO0tXMeE9PIghjnP8Js7On
         NOGM/1XQff81Ho2Do/GoUW842C9X/8YBZ4kXxqR1LeeiCnziQx/K0fcvR/5SwcrPnOsZ
         Z1zspA2H9+TjjdtYuWl9AQVqogYYBCq1YShj26vfNyx7LPiii97gxOL5osVVo2SzNy9Y
         JK/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8vxIBT8lv1w6KFsMfn4j0yz6q+4rF8D5BX2DYDWV9Xo=;
        b=aXc7in+sbFij9QxZzmXWAZaeVDkB61x6rcAj9K9GkKI7CFnz2Yo8BYsJWVfr6xiiYV
         GlxeMdEDMDFdICAuTW+qlcvpq8M9guiI34VW8FzZlFQ0Dbhsp50DInXZxwpbN3QYNN8z
         37S3kc8+ZY+eP20OpXo9YVZgxnm2tD1ph9oX13Gzqv2UEAmo6CnrDcx35qtJzluxc3Ao
         TX6ZuMxan4v6VSStmkIoBHkuKgzsJcEhiqfyfP0VNCgPDiZr8EVEnyzQgtPTcTcy5lsc
         16fyJw/6SkI+UISx9STc5LjtIXB09Ez7Aus+0q4Enm7IibSIsYJFkdD5y9GRmwMmBSL8
         CZaw==
X-Gm-Message-State: AKGB3mKTFPhM6tLq7tkmCDoXEn9OVoyEV2Ut/taENpB0/KamifE8O+Gx
        yIPQNNgWNMTN6Z2YC4YWkHs9oA==
X-Google-Smtp-Source: ACJfBosHnxEknHwgMu0vWl3O2ys0Q3NOvlLC8Zcog/2YWg4SDA0Ba42CLBJNMK5yi+gMCzoD1dozYg==
X-Received: by 10.223.176.8 with SMTP id f8mr1733638wra.80.1513035328301;
        Mon, 11 Dec 2017 15:35:28 -0800 (PST)
Received: from localhost.localdomain (x590d9245.dyn.telefonica.de. [89.13.146.69])
        by smtp.gmail.com with ESMTPSA id h12sm15408811wre.52.2017.12.11.15.35.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 11 Dec 2017 15:35:27 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 2/4] travis-ci: introduce a $jobname variable for 'ci/*' scripts
Date:   Tue, 12 Dec 2017 00:34:44 +0100
Message-Id: <20171211233446.10596-3-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.15.1.421.gc469ca1de
In-Reply-To: <20171211233446.10596-1-szeder.dev@gmail.com>
References: <20171101115535.15074-1-szeder.dev@gmail.com>
 <20171211233446.10596-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A couple of 'ci/*' scripts are shared between different build jobs:
'ci/lib-travisci.sh', being a common library, is sourced from almost
every script, while 'ci/install-dependencies.sh', 'ci/run-build.sh'
and 'ci/run-tests.sh' are shared between the "regular" GCC and Clang
Linux and OSX build jobs, and the latter two scripts are used in the
GETTEXT_POISON Linux build job as well.

Our builds could benefit from these shared scripts being able to
easily tell which build job they are taking part in.  Now, it's
already quite easy to tell apart Linux vs OSX and GCC vs Clang build
jobs, but it gets trickier with all the additional Linux-based build
jobs included explicitly in the build matrix.

Unfortunately, Travis CI doesn't provide much help in this regard.
The closest we've got is the $TRAVIS_JOB_NUMBER variable, the value of
which is two dot-separated integers, where the second integer
indicates a particular build job.  While it would be possible to use
that second number to identify the build job in our shared scripts, it
doesn't seem like a good idea to rely on that:

  - Though the build job numbering sequence seems to be stable so far,
    Travis CI's documentation doesn't explicitly states that it is
    indeed stable and will remain so in the future.  And even if it
    were stable,

  - if we were to remove or insert a build job in the middle, then the
    job numbers of all subsequent build jobs would change accordingly.

So roll our own means of simple build job identification and introduce
the $jobname environment variable in our builds, setting it in the
environments of the explicitly included jobs in '.travis.yml', while
constructing one in 'ci/lib-travisci.sh' as the combination of the OS
and compiler name for the GCC and Clang Linux and OSX build jobs.  Use
$jobname instead of $TRAVIS_OS_NAME in scripts taking different
actions based on the OS and build job (when installing P4 and Git LFS
dependencies and including them in $PATH).  The following two patches
will also rely on $jobname.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 .travis.yml                | 10 +++++-----
 ci/install-dependencies.sh |  6 +++---
 ci/lib-travisci.sh         |  9 +++++++--
 3 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 281f101f3..88435e11c 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -39,12 +39,12 @@ env:
 
 matrix:
   include:
-    - env: GETTEXT_POISON=YesPlease
+    - env: jobname=GETTEXT_POISON GETTEXT_POSION=YesPlease
       os: linux
       compiler:
       addons:
       before_install:
-    - env: Windows
+    - env: jobname=Windows
       os: linux
       compiler:
       addons:
@@ -55,7 +55,7 @@ matrix:
           test "$TRAVIS_REPO_SLUG" != "git/git" ||
           ci/run-windows-build.sh $TRAVIS_BRANCH $(git rev-parse HEAD)
       after_failure:
-    - env: Linux32
+    - env: jobname=Linux32
       os: linux
       compiler:
       services:
@@ -63,7 +63,7 @@ matrix:
       before_install:
       before_script:
       script: ci/run-linux32-docker.sh
-    - env: Static Analysis
+    - env: jobname=StaticAnalysis
       os: linux
       compiler:
       addons:
@@ -74,7 +74,7 @@ matrix:
       before_script:
       script: ci/run-static-analysis.sh
       after_failure:
-    - env: Documentation
+    - env: jobname=Documentation
       os: linux
       compiler:
       addons:
diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 5bd06fe90..468788566 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -8,8 +8,8 @@
 P4WHENCE=http://filehost.perforce.com/perforce/r$LINUX_P4_VERSION
 LFSWHENCE=https://github.com/github/git-lfs/releases/download/v$LINUX_GIT_LFS_VERSION
 
-case "${TRAVIS_OS_NAME:-linux}" in
-linux)
+case "$jobname" in
+linux-clang|linux-gcc)
 	export GIT_TEST_HTTPD=YesPlease
 
 	mkdir --parents "$P4_PATH"
@@ -26,7 +26,7 @@ linux)
 		cp git-lfs-$LINUX_GIT_LFS_VERSION/git-lfs .
 	popd
 	;;
-osx)
+osx-clang|osx-gcc)
 	brew update --quiet
 	# Uncomment this if you want to run perf tests:
 	# brew install gnu-time
diff --git a/ci/lib-travisci.sh b/ci/lib-travisci.sh
index a0c8ae03f..b60e93797 100755
--- a/ci/lib-travisci.sh
+++ b/ci/lib-travisci.sh
@@ -27,8 +27,13 @@ set -ex
 
 skip_branch_tip_with_tag
 
-case "${TRAVIS_OS_NAME:-linux}" in
-linux)
+if test -z "$jobname"
+then
+	jobname="$TRAVIS_OS_NAME-$CC"
+fi
+
+case "$jobname" in
+linux-clang|linux-gcc)
 	P4_PATH="$(pwd)/custom/p4"
 	GIT_LFS_PATH="$(pwd)/custom/git-lfs"
 	export PATH="$GIT_LFS_PATH:$P4_PATH:$PATH"
-- 
2.15.1.421.gc469ca1de

