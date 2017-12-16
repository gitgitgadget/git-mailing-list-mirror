Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E64301F406
	for <e@80x24.org>; Sat, 16 Dec 2017 12:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756796AbdLPM5N (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Dec 2017 07:57:13 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:45339 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756321AbdLPM5I (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Dec 2017 07:57:08 -0500
Received: by mail-wm0-f68.google.com with SMTP id 9so21882098wme.4
        for <git@vger.kernel.org>; Sat, 16 Dec 2017 04:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N7lLdFk69ouqZHF6ESJyuNgEoiOi2Bcr4oBxgnzFtHc=;
        b=aPAEbepvdtnlCt6abFX2rtCBkPYi+2i4xbkjW95tyTpJ9K5d9AcBuK2s9agypWOyAV
         IliX3z2qiymnFDozGAojk+2oPingdheUJQp8CRU+tGPPBC31CGEA5lyCInVGRVcXqx+R
         enTP6C2edqxU+yjZNPNL7iqqh992rb20UN9RYzjSl89tJ6eidupBdq3ZZlLK1hmbB8wd
         p8CtLky2mtfhJOtZEhHO7fwMgQMfeBfri3PM2jFF9gcN1CSCej/PBZ6rUzX4YFUlO51r
         h8Aa5kbRWid65Rai72JgBn+zDG1Z9FYyBt9HITGpj6ILPphlNP8Hj/TfaSnPs8d+VK+L
         BDWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N7lLdFk69ouqZHF6ESJyuNgEoiOi2Bcr4oBxgnzFtHc=;
        b=bM4XC3kQFz983w3vDN8CJsA6maSW7Oke5LRWIVYELxLNZw9QYN9oGClX1hsKczBa5L
         hjijzbMTBpNnbtrXO7A3txzgGemxHVMrKcR7T0H9v/Eu9olMf0ugvE+zXpEfKv3fKsSf
         kRvBM/4qtj5YZcAJh34Gsm4552ZwgXOK3cJn0viKCQmDehDsj/fgX/iQRI27qGVW8/l0
         n6i9F6HP3e5FShPGXWeyVH39w/DNyEys9zwQUsMD/DZPy/09ppZ+T6O8t0OPEfqGP9jg
         J4FO5YoM6yn9pftjYIuIwZqVQ+SZ1u+Be8KzvfwIQCmC3wKFqcCpUJt2MgOIz0M+0WZH
         0jSQ==
X-Gm-Message-State: AKGB3mLmW8ZujTKhj65PaU0KSv8FgIMN5GzWJGXZmLwohIkQ4tIFg25F
        IoXUaFe0vPMKU/+dWKQapRA=
X-Google-Smtp-Source: ACJfBoveL3p4DggiKL+L8x+Ktd4LPvbZ4C/E8FMXy1WpOSgQXOYALgq6yrjdR/aScMhTu5QycgkE3A==
X-Received: by 10.28.137.80 with SMTP id l77mr8039399wmd.24.1513429027295;
        Sat, 16 Dec 2017 04:57:07 -0800 (PST)
Received: from localhost.localdomain (x590e5997.dyn.telefonica.de. [89.14.89.151])
        by smtp.gmail.com with ESMTPSA id f42sm3218065wrf.46.2017.12.16.04.57.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 16 Dec 2017 04:57:06 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 3/8] travis-ci: move setting environment variables to 'ci/lib-travisci.sh'
Date:   Sat, 16 Dec 2017 13:57:02 +0100
Message-Id: <20171216125702.10901-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.15.1.429.ga000dd9c7
In-Reply-To: <20171216125418.10743-2-szeder.dev@gmail.com>
References: <20171216125418.10743-2-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Our '.travis.yml's 'env.global' section sets a bunch of environment
variables for all build jobs, though none of them actually affects all
build jobs.  It's convenient for us, and in most cases it works just
fine, because irrelevant environment variables are simply ignored.

However, $GIT_SKIP_TESTS is an exception: it tells the test harness to
skip the two test scripts that are prone to occasional failures on
OSX, but as it's set for all build jobs those tests are not run in any
of the build jobs that are capable to run them reliably, either.

Therefore $GIT_SKIP_TESTS should only be set in the OSX build jobs,
but those build jobs are included in the build matrix implicitly (i.e.
by combining the matrix keys 'os' and 'compiler'), and there is no way
to set an environment variable only for a subset of those implicit
build jobs.  (Unless we were to add new scriptlets to '.travis.yml',
which is exactly the opposite direction that we took with commit
657343a60 (travis-ci: move Travis CI code into dedicated scripts,
2017-09-10)).

So move setting $GIT_SKIP_TESTS to 'ci/lib-travisci.sh', where it can
trivially be set only for the OSX build jobs.

Furthermore, move setting all other environment variables from
'.travis.yml' to 'ci/lib-travisci.sh', too, because a couple of
environment variables are already set there, and this way all
environment variables will be set in the same place.  All the logic
controlling our builds is already in the 'ci/*' scripts anyway, so
there is really no good reason to keep the environment variables
separately.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 .travis.yml        | 18 +-----------------
 ci/lib-travisci.sh | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 88435e11c..7c9aa0557 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -21,25 +21,9 @@ addons:
     - git-svn
     - apache2
 
-env:
-  global:
-    - DEVELOPER=1
-    # The Linux build installs the defined dependency versions below.
-    # The OS X build installs the latest available versions. Keep that
-    # in mind when you encounter a broken OS X build!
-    - LINUX_P4_VERSION="16.2"
-    - LINUX_GIT_LFS_VERSION="1.5.2"
-    - DEFAULT_TEST_TARGET=prove
-    - GIT_PROVE_OPTS="--timer --jobs 3 --state=failed,slow,save"
-    - GIT_TEST_OPTS="--verbose-log"
-    - GIT_TEST_CLONE_2GB=YesPlease
-    # t9810 occasionally fails on Travis CI OS X
-    # t9816 occasionally fails with "TAP out of sequence errors" on Travis CI OS X
-    - GIT_SKIP_TESTS="t9810 t9816"
-
 matrix:
   include:
-    - env: jobname=GETTEXT_POISON GETTEXT_POSION=YesPlease
+    - env: jobname=GETTEXT_POISON
       os: linux
       compiler:
       addons:
diff --git a/ci/lib-travisci.sh b/ci/lib-travisci.sh
index 4b3c5fdd0..c5c5cb1bf 100755
--- a/ci/lib-travisci.sh
+++ b/ci/lib-travisci.sh
@@ -34,10 +34,31 @@ then
 	jobname="$TRAVIS_OS_NAME-$CC"
 fi
 
+export DEVELOPER=1
+export DEFAULT_TEST_TARGET=prove
+export GIT_PROVE_OPTS="--timer --jobs 3 --state=failed,slow,save"
+export GIT_TEST_OPTS="--verbose-log"
+export GIT_TEST_CLONE_2GB=YesPlease
+
 case "$jobname" in
 linux-clang|linux-gcc)
+	# The Linux build installs the defined dependency versions below.
+	# The OS X build installs the latest available versions. Keep that
+	# in mind when you encounter a broken OS X build!
+	export LINUX_P4_VERSION="16.2"
+	export LINUX_GIT_LFS_VERSION="1.5.2"
+
 	P4_PATH="$(pwd)/custom/p4"
 	GIT_LFS_PATH="$(pwd)/custom/git-lfs"
 	export PATH="$GIT_LFS_PATH:$P4_PATH:$PATH"
 	;;
+osx-clang|osx-gcc)
+	# t9810 occasionally fails on Travis CI OS X
+	# t9816 occasionally fails with "TAP out of sequence errors" on
+	# Travis CI OS X
+	export GIT_SKIP_TESTS="t9810 t9816"
+	;;
+GETTEXT_POISON)
+	export GETTEXT_POISON=YesPlease
+	;;
 esac
-- 
2.15.1.429.ga000dd9c7

