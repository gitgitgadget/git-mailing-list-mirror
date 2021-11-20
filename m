Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A46C433F5
	for <git@archiver.kernel.org>; Sat, 20 Nov 2021 03:28:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235573AbhKTDb6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 22:31:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235034AbhKTDbv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 22:31:51 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFABC06173E
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 19:28:48 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id u1so21348358wru.13
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 19:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1QNEfRQysQCwUFE9vqbsWhUGx/QyvmPPiLjfE3Q2pTY=;
        b=murTXEquLlfvV+9kkSjCMe5UW+wSXQHBzHOU0BF1LUveGyOFBb4fxGjOP/aIqxELau
         FbzJxoOG4j3BGh3NDUudiLUO0v5PlzMQNVReABjAsrCsPR5SSXUWLBTbYKMWTdIOliI7
         V8VbL9AxS22TKTEc7bZxYyGno2wnAZj2KZrSKRq/sXWKur5aKpMOLmpJZMIBacuVUuQz
         yp3DAneG7aCRxdXXg69a4Q3iZAzUZbkjtDIsduASmgEFrsu8IM/B/3ryCKkIN/Y2pcvZ
         EIPTwlUTg7iK2WhRxaS8j2A98p285NF22q+P/ovlmCT8NY50BMQaNY0T3yKCA/nshVry
         VcNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1QNEfRQysQCwUFE9vqbsWhUGx/QyvmPPiLjfE3Q2pTY=;
        b=m6X4jlNBdrHCUSJNbtMQXVg9VvrLxPQNDa9dgmS4NsD2aUB9hbf9ZYEykNthKmpcDw
         h98IUbjYX1HghfbFPc/x/1e+M+fBgrf4UY2mR2FPKXG4aLqbkDdfibp6V6CBtPVQHneB
         Vo58bKhqQg0TPaekNgzozro03Ep+Svtirru9wqsUMNlkKUtXj7LQHs6V0YSmT9bF1+ct
         ErAn/7z9ksYVNOUUmcufPT+qv55LSgjlXbfW/YUNIrLlOGZSuFDIcgvU98UfNljBwHgj
         +IvDkK/KQVOQ9q69eMRqR7OjxTCjgDIprHxZYT/mkJsLDH1uy3Efvq4LWPFFuDRrxQO8
         k4qw==
X-Gm-Message-State: AOAM531J2iilFRdWQJQL//kZSxywPRC5GzDh7fO9X4eqoXbx8gcTLywu
        KXuitwGxYS1kytGoY/pvi89eaXVdnVk50A==
X-Google-Smtp-Source: ABdhPJyCOKEeHh4OVqSGhDXp99wI5qt3IZfa1k5xr5FDQPxIN70I8jkYc61ae2yGCe85zmLhIF7OEg==
X-Received: by 2002:adf:dd0a:: with SMTP id a10mr14258251wrm.60.1637378927113;
        Fri, 19 Nov 2021 19:28:47 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o12sm1560623wmq.12.2021.11.19.19.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 19:28:46 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Victoria Dye <vdye@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 5/6] CI: don't run "make test" twice in one job
Date:   Sat, 20 Nov 2021 04:28:35 +0100
Message-Id: <patch-v2-5.6-a113b8404ed-20211120T030848Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.823.gcc3243ae16c
In-Reply-To: <cover-v2-0.6-00000000000-20211120T030848Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20211119T135343Z-avarab@gmail.com> <cover-v2-0.6-00000000000-20211120T030848Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "linux-clang" and "linux-gcc" jobs both run "make test" twice, but
with different environment variables. Running these in sequence seems
to have been done to work around some constraint on Travis, see
ae59a4e44f3 (travis: run tests with GIT_TEST_SPLIT_INDEX, 2018-01-07).

By having these run in parallel we'll get jobs that finish much sooner
than they otherwise would have.

We can also simplify the control flow in "ci/run-build-and-tests.sh"
as a result, since we won't run "make test" twice we don't need to run
"make" twice at all, let's default to "make all test" after setting
the variables, and then override it to just "all" for the compile-only
tests.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .github/workflows/main.yml |  9 +++++++++
 ci/run-build-and-tests.sh  | 26 ++++++++++++--------------
 2 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 097be4c4405..63fff2744ad 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -226,11 +226,20 @@ jobs:
             cc: clang
             os: ubuntu
             pool: ubuntu-latest
+          - jobname: linux-sha256
+            cc: clang
+            os: ubuntu
+            pool: ubuntu-latest
           - jobname: linux-gcc
             cc: gcc
             os: ubuntu
             cc_package: gcc-8
             pool: ubuntu-latest
+          - jobname: linux-TEST-vars
+            cc: gcc
+            os: ubuntu
+            cc_package: gcc-8
+            pool: ubuntu-latest
           - jobname: osx-clang
             cc: clang
             os: osx
diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index cc62616d806..16840b2065d 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -10,16 +10,13 @@ windows*) cmd //c mklink //j t\\.prove "$(cygpath -aw "$cache_dir/.prove")";;
 *) ln -s "$cache_dir/.prove" t/.prove;;
 esac
 
-if test "$jobname" = "pedantic"
-then
-	export DEVOPTS=pedantic
-fi
+export MAKE_TARGETS="all test"
 
-make
 case "$jobname" in
 linux-gcc)
 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
-	make test
+	;;
+linux-TEST-vars)
 	export GIT_TEST_SPLIT_INDEX=yes
 	export GIT_TEST_MERGE_ALGORITHM=recursive
 	export GIT_TEST_FULL_IN_PACK_ARRAY=true
@@ -33,23 +30,24 @@ linux-gcc)
 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
 	export GIT_TEST_WRITE_REV_INDEX=1
 	export GIT_TEST_CHECKOUT_WORKERS=2
-	make test
 	;;
 linux-clang)
 	export GIT_TEST_DEFAULT_HASH=sha1
-	make test
+	;;
+linux-sha256)
 	export GIT_TEST_DEFAULT_HASH=sha256
-	make test
 	;;
-linux-gcc-4.8|pedantic)
-	# Don't run the tests; we only care about whether Git can be
-	# built with GCC 4.8 or with pedantic
+pedantic)
+	export DEVOPTS=pedantic
+	export MAKE_TARGETS=all
 	;;
-*)
-	make test
+linux-gcc-4.8)
+	export MAKE_TARGETS=all
 	;;
 esac
 
+make $MAKE_TARGETS
+
 check_unignored_build_artifacts
 
 save_good_tree
-- 
2.34.0.823.gcc3243ae16c

