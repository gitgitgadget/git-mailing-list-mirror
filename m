Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CB6B1F404
	for <e@80x24.org>; Mon, 11 Dec 2017 23:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752048AbdLKXfg (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Dec 2017 18:35:36 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:45232 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751612AbdLKXff (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Dec 2017 18:35:35 -0500
Received: by mail-wr0-f195.google.com with SMTP id h1so19274471wre.12
        for <git@vger.kernel.org>; Mon, 11 Dec 2017 15:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CS21P6krh+P0hMUyO6WJxN8UH9sQvnoMPfbrI0OQu4w=;
        b=jwb2cLEaqlObCwcUWiIpfUjWWzgbOpgoRmAgik6StasiI/UbD5lzC+X28bZL4OaclH
         9JPRZEgpuqImFCkugmDXsuAQnihMj6bMZINlkdNlLBc/9h/CjRutygR9huh/59iAoFir
         7RGYs9LIgrSS+uUZY6iH5tAPOr+48lUOKnWOro1X9oK38etk3B3xjG/uamQ9nCQlGnCM
         wE65vkeoCIXyOcfpSMIVKmjCftGHZ4iiz601oOvNwXzgW42lgpj6q1Bql0ak/kZCSLmb
         G5qkw3/jZ6TyTmgdOgugIvADHf3lEeYOaLQ1+tUYqcC0gNbyNCD6XCJpeLq4rxXyY4Hy
         yeIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CS21P6krh+P0hMUyO6WJxN8UH9sQvnoMPfbrI0OQu4w=;
        b=D54rs0tOPpEf4ZU5ySaWmrRaTKrDoQtTV2ncA1loPz25Hz/kGh2WYT+5BsT79DNM27
         f6mkpdDkvLS2nETrwz04QeBebSkxGR+WnOfCXvAYEQXeVPd1LHWd27I+VSk0kDgICiRq
         ZmPDCZRXx706vaq149FtSufya9lUh/0Y9j5XY+bGrbINTOrmfRmOjmnMdLySCh/+A9wE
         but0LRbNwVCSPdfSY21EHpEKNjB97snNMXFwF0sprm6P1nJPuY7Rz0raZIFRdd+K/dBw
         NTwYc2HSqQtVouGwjZOvEGFLGlZ8FufEbgjTlxySv+hlhbaTjYPwnI4S6uinXACDa4BH
         8oLA==
X-Gm-Message-State: AKGB3mJ3IojeIZnedtgGIdPs0i/XYYpJNjy96cGxzFyK3HbWJgX3TApq
        GQsnzCVjBcz9jugPWE47xl3izg==
X-Google-Smtp-Source: ACJfBouV2z1xEldKRcsx4LTcco7qDDVWZI5SN9juHRFf/KIFb+rhYGDjxn8wyYOBaw9X/BsSKx4Qrg==
X-Received: by 10.223.139.67 with SMTP id v3mr1852575wra.70.1513035333853;
        Mon, 11 Dec 2017 15:35:33 -0800 (PST)
Received: from localhost.localdomain (x590d9245.dyn.telefonica.de. [89.13.146.69])
        by smtp.gmail.com with ESMTPSA id h12sm15408811wre.52.2017.12.11.15.35.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 11 Dec 2017 15:35:33 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 3/4] travis-ci: move setting environment variables to 'ci/lib-travisci.sh'
Date:   Tue, 12 Dec 2017 00:34:45 +0100
Message-Id: <20171211233446.10596-4-szeder.dev@gmail.com>
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
index b60e93797..e85571298 100755
--- a/ci/lib-travisci.sh
+++ b/ci/lib-travisci.sh
@@ -32,10 +32,31 @@ then
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
2.15.1.421.gc469ca1de

