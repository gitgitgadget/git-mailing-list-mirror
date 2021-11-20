Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB5AC433F5
	for <git@archiver.kernel.org>; Sat, 20 Nov 2021 12:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236461AbhKTMN2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Nov 2021 07:13:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236489AbhKTMN1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Nov 2021 07:13:27 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51ABC061758
        for <git@vger.kernel.org>; Sat, 20 Nov 2021 04:10:23 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id u1so22955636wru.13
        for <git@vger.kernel.org>; Sat, 20 Nov 2021 04:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OpPTDI+4WzSB9vJFITyoOB4TQJNdLMpNBlmtvsRxNpk=;
        b=TLXFdX+DxNDOmHjQrEkQPr/7ROgmVDorJJfUqz6h4VIVUr6VGxVDDdWI0LoiEzteJV
         SJgSCir0dmlXlqlAAfr5XqbwyrpkxWgcudzIhb1cWHhnWuTTATnYtw365ZdOUWchOAsd
         K4O/cWezZg06Wa2SaJxRypEltNba7PZGj/h9tjb29XQVuH2r92VJRdchXESm8VfQmV38
         vxaehdXWDZE7Vz7ULFPzMCmFD1pyHot+Pzv6JTpHgdkVhi1yZyJ5nwYJkFaipdB8ADW0
         I3HcXMPnN5CiFvaHKc6ZQOv4QA8wEu7EPr3EvujDtgShFHyiSXxLB0lN9IQrHZoUjdIp
         431A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OpPTDI+4WzSB9vJFITyoOB4TQJNdLMpNBlmtvsRxNpk=;
        b=phUNWUFFQFISG/EEq51n9sXgKGHfOMrGqqbSxGr5tImIisN4f6jRsNAVErFaQ5t004
         rcSgqvpvZaUf7QurLQDu2ASaV6KXfP1zSyZ0ZSIY7egTFI6rxoCsSWVT/aLt2KUeyMYT
         uDrIZLIMeVvwYsvlGR/aktvh7WetalBqhaF0qLsUgWA5kKOAPEpMI+rnQVMxOmAwLs0F
         rIE1pR3ZRpyPQpppoA5okI2fvcRAOodtI+6Za4q+AEhrMShyZX6CXf5c1fEE/RixOKJ0
         ylh4gyT4xNhH3OK1P7BQ/jqbV2pP1qdqWQ6Nyw65ZkIqauVLbuSUVgnaks+2MsVHf9yj
         TUVQ==
X-Gm-Message-State: AOAM531Cbg9I39CLJuSN5qIubojt98BFlt+rHAlD2QXWtFVFKiPZUSjf
        vw5R9w0UKILqcJQCxqXv5OhrdO69NMxbWaM6
X-Google-Smtp-Source: ABdhPJzIOFZSt27a4Ln/WRVRxSpewFu/UkP/6n19Tw1ZOJevRTma4hEccuGRbFhVg9ev4KEhTTqX8A==
X-Received: by 2002:a5d:4cd1:: with SMTP id c17mr17215795wrt.31.1637410222032;
        Sat, 20 Nov 2021 04:10:22 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m36sm3128221wms.25.2021.11.20.04.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Nov 2021 04:10:21 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Victoria Dye <vdye@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 5/5] CI: don't run "make test" twice in one job
Date:   Sat, 20 Nov 2021 13:10:11 +0100
Message-Id: <patch-v3-5.5-877f27d847c-20211120T115414Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.818.g0f23a581583
In-Reply-To: <cover-v3-0.5-00000000000-20211120T115414Z-avarab@gmail.com>
References: <cover-v2-0.6-00000000000-20211120T030848Z-avarab@gmail.com> <cover-v3-0.5-00000000000-20211120T115414Z-avarab@gmail.com>
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
index d402402a18b..628bcbf495e 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -225,10 +225,19 @@ jobs:
           - jobname: linux-clang
             cc: clang
             pool: ubuntu-latest
+          - jobname: linux-sha256
+            cc: clang
+            os: ubuntu
+            pool: ubuntu-latest
           - jobname: linux-gcc
             cc: gcc
             cc_package: gcc-8
             pool: ubuntu-latest
+          - jobname: linux-TEST-vars
+            cc: gcc
+            os: ubuntu
+            cc_package: gcc-8
+            pool: ubuntu-latest
           - jobname: osx-clang
             cc: clang
             pool: macos-latest
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
2.34.0.818.g0f23a581583

