Return-Path: <SRS0=1Io1=D7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 523DEC4363A
	for <git@archiver.kernel.org>; Sat, 24 Oct 2020 10:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFA7224248
	for <git@archiver.kernel.org>; Sat, 24 Oct 2020 10:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WURrn4F4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761063AbgJXKtQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Oct 2020 06:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758404AbgJXKtO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Oct 2020 06:49:14 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9F2C0613CE
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 03:49:14 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id t14so3181581pgg.1
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 03:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=xLM6enuURBeJHIPSE49LE8IFBMYqqXUdTKoSurKZQNU=;
        b=WURrn4F4XWM6AJkpTK10XDskw9HQHPQbKZyeW1zJ88Bf/piAH9YFwuX2vTssgz6lBc
         QGnUPjiin4tEY0OPfmtS2eFPgy4/cN7iPNA9FUnqPiNNpgnlbAv44LoPNbS8p5jAgWKL
         OMe+t/OrQ4MS4CsUN8vhdLbn64dx/h4+/5a0WeL8h+sZ3jc26mJtkX3PMJtRKsOuMoVg
         LQZzLMOmkrqfRa3eybG0BKgi/curRaOLEt5QRa34i2dLWIcK4E3+ZQKvZjFKLjNfRCxQ
         0rrjZy02DKLi3/dwZgaq8M/kaDC9IXL7KYtpkypd+xeF714SCppd1+q6xcwPuifaKz3z
         3FzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=xLM6enuURBeJHIPSE49LE8IFBMYqqXUdTKoSurKZQNU=;
        b=COGGT9/RAXoXA7E0UNXc+Kkjk1rJkl8uLJ08zMEkuMc1knw82NDU8Elm4WbaUMhGov
         9EzPdB/kQyEr4R4OM8TuM+xvAIlK4zY0BGZ0SxGGWj3veZXUWKrm5eGG9R6J5bOfVfbD
         f8ELB0/I9I9FigvqzcEiRYo39oa+Fchl84u4R7tuKeCu5IF0r3NNiULxiyRTgmKVdPzo
         8aIZ2YpTtye6mHfHKTQ5URxddnKiMZr0VylXlYdhurES8Y/TNUyzPxYxRSGXDHtX/T3U
         rJ3Pb+A5DoImbkgFol2uj8OIr2NFd8y/PPTybiMBAJ3a1n3Z9JHmmv7iGVZxL4eRVubM
         26gg==
X-Gm-Message-State: AOAM533cpWPTkTEBk6oQegstUlQAcjo4yIMcMEF9rJWsE/tDZ/Cexnzg
        MCvKMV9ixX2NsZB1F+peSWM=
X-Google-Smtp-Source: ABdhPJwr/r/mvpd6C/3alMqBK7L50Si3yuq3f/v3ReATS+fMiUhX11jsb9JkF7EtNozmIUxSN9Y67A==
X-Received: by 2002:a63:5c5e:: with SMTP id n30mr5772828pgm.54.1603536553719;
        Sat, 24 Oct 2020 03:49:13 -0700 (PDT)
Received: from localhost ([2402:800:63a8:a664:a141:4d28:22d6:5590])
        by smtp.gmail.com with ESMTPSA id b16sm5229025pfp.195.2020.10.24.03.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2020 03:49:12 -0700 (PDT)
Date:   Sat, 24 Oct 2020 17:49:10 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/9] t/: new helper for tests that pass with ort but fail
 with recursive
Message-ID: <20201024104910.GA15823@danh.dev>
References: <pull.769.git.1603468885.gitgitgadget@gmail.com>
 <a8d4825a323d5c1e7b2dc1edc8621c51c030ae1e.1603468885.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a8d4825a323d5c1e7b2dc1edc8621c51c030ae1e.1603468885.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-10-23 16:01:16+0000, Elijah Newren via GitGitGadget <gitgitgadget@gmail.com> wrote:
> +test_expect_merge_algorithm () {
> +	status_for_recursive=$1
> +	shift
> +	status_for_ort=$1
> +	shift
> +
> +	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
> +	then
> +		test_expect_${status_for_ort} "$@"
> +	else
> +		test_expect_${status_for_recursive} "$@"
> -test_expect_failure 'check symlink modify/modify' '
> +test_expect_merge_algorithm failure success 'check symlink modify/modify' '

I find this series of "failure success" hard to decode without
understanding what it would be, then I need to keep rememberring which
status is corresponding with with algorithm.

Perhaps this patch is a bit easier to read. This is largely based on
your patch. (I haven't read other patches, yet).

What do you think?

-------------8<------------
From: =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?=
 <congdanhqx@gmail.com>
Date: Sat, 24 Oct 2020 17:41:02 +0700
Subject: [PATCH] t/: new helper for testing merge that allow failure for some
 algorithm

There are a number of tests that the "recursive" backend does not handle
correctly but which the redesign in "ort" will.

Add a new helper in lib-merge.sh for selecting a different test expectation
based on the setting of GIT_TEST_MERGE_ALGORITHM, and use it in various
testcases to document that we expect them to be success by default
but failure with certain algorithm.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 t/lib-merge.sh                         | 19 +++++++++++++++++++
 t/t6416-recursive-corner-cases.sh      | 11 ++++++-----
 t/t6422-merge-rename-corner-cases.sh   |  7 ++++---
 t/t6423-merge-rename-directories.sh    | 13 +++++++------
 t/t6426-merge-skip-unneeded-updates.sh |  3 ++-
 t/t6430-merge-recursive.sh             |  3 ++-
 6 files changed, 40 insertions(+), 16 deletions(-)
 create mode 100644 t/lib-merge.sh

diff --git a/t/lib-merge.sh b/t/lib-merge.sh
new file mode 100644
index 0000000000..efd8b9615c
--- /dev/null
+++ b/t/lib-merge.sh
@@ -0,0 +1,19 @@
+# Helper functions used by merge tests.
+
+test_expect_merge_success() {
+	exception="$1"
+	: "${GIT_TEST_MERGE_ALGORITHM:=recursive}"
+	case ",$exception," in
+	*,$GIT_TEST_MERGE_ALGORITHM=failure,*)
+		shift
+		test_expect_failure "$@" ;;
+	*,$GIT_TEST_MERGE_ALGORITHM=*)
+		BUG "exception must be failure only" ;;
+	*=failure,)
+		shift
+		test_expect_success "$@" ;;
+	*)
+		# No exception
+		test_expect_success "$@" ;;
+	esac
+}
diff --git a/t/t6416-recursive-corner-cases.sh b/t/t6416-recursive-corner-cases.sh
index fd98989b14..d13c1afb4a 100755
--- a/t/t6416-recursive-corner-cases.sh
+++ b/t/t6416-recursive-corner-cases.sh
@@ -3,6 +3,7 @@
 test_description='recursive merge corner cases involving criss-cross merges'
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-merge.sh
 
 #
 #  L1  L2
@@ -1069,7 +1070,7 @@ test_expect_success 'setup symlink modify/modify' '
 	)
 '
 
-test_expect_failure 'check symlink modify/modify' '
+test_expect_merge_success recursive=failure 'check symlink modify/modify' '
 	(
 		cd symlink-modify-modify &&
 
@@ -1135,7 +1136,7 @@ test_expect_success 'setup symlink add/add' '
 	)
 '
 
-test_expect_failure 'check symlink add/add' '
+test_expect_merge_success recursive=failure 'check symlink add/add' '
 	(
 		cd symlink-add-add &&
 
@@ -1223,7 +1224,7 @@ test_expect_success 'setup submodule modify/modify' '
 	)
 '
 
-test_expect_failure 'check submodule modify/modify' '
+test_expect_merge_success recursive=failure 'check submodule modify/modify' '
 	(
 		cd submodule-modify-modify &&
 
@@ -1311,7 +1312,7 @@ test_expect_success 'setup submodule add/add' '
 	)
 '
 
-test_expect_failure 'check submodule add/add' '
+test_expect_merge_success recursive=failure 'check submodule add/add' '
 	(
 		cd submodule-add-add &&
 
@@ -1386,7 +1387,7 @@ test_expect_success 'setup conflicting entry types (submodule vs symlink)' '
 	)
 '
 
-test_expect_failure 'check conflicting entry types (submodule vs symlink)' '
+test_expect_merge_success recursive=failure 'check conflicting entry types (submodule vs symlink)' '
 	(
 		cd submodule-symlink-add-add &&
 
diff --git a/t/t6422-merge-rename-corner-cases.sh b/t/t6422-merge-rename-corner-cases.sh
index 3375eaf4e7..0c8eb4df8a 100755
--- a/t/t6422-merge-rename-corner-cases.sh
+++ b/t/t6422-merge-rename-corner-cases.sh
@@ -4,6 +4,7 @@ test_description="recursive merge corner cases w/ renames but not criss-crosses"
 # t6036 has corner cases that involve both criss-cross merges and renames
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-merge.sh
 
 test_setup_rename_delete_untracked () {
 	test_create_repo rename-delete-untracked &&
@@ -878,7 +879,7 @@ test_setup_rad () {
 	)
 }
 
-test_expect_failure 'rad-check: rename/add/delete conflict' '
+test_expect_merge_success recursive=failure 'rad-check: rename/add/delete conflict' '
 	test_setup_rad &&
 	(
 		cd rad &&
@@ -951,7 +952,7 @@ test_setup_rrdd () {
 	)
 }
 
-test_expect_failure 'rrdd-check: rename/rename(2to1)/delete/delete conflict' '
+test_expect_merge_success recursive=failure 'rrdd-check: rename/rename(2to1)/delete/delete conflict' '
 	test_setup_rrdd &&
 	(
 		cd rrdd &&
@@ -1040,7 +1041,7 @@ test_setup_mod6 () {
 	)
 }
 
-test_expect_failure 'mod6-check: chains of rename/rename(1to2) and rename/rename(2to1)' '
+test_expect_merge_success recursive=failure 'mod6-check: chains of rename/rename(1to2) and rename/rename(2to1)' '
 	test_setup_mod6 &&
 	(
 		cd mod6 &&
diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
index 06b46af765..249fbb6853 100755
--- a/t/t6423-merge-rename-directories.sh
+++ b/t/t6423-merge-rename-directories.sh
@@ -26,6 +26,7 @@ test_description="recursive merge with directory renames"
 #                     files that might be renamed into each other's paths.)
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-merge.sh
 
 
 ###########################################################################
@@ -1339,7 +1340,7 @@ test_setup_6b1 () {
 	)
 }
 
-test_expect_failure '6b1: Same renames done on both sides, plus another rename' '
+test_expect_merge_success recursive=failure '6b1: Same renames done on both sides, plus another rename' '
 	test_setup_6b1 &&
 	(
 		cd 6b1 &&
@@ -1412,7 +1413,7 @@ test_setup_6b2 () {
 	)
 }
 
-test_expect_failure '6b2: Same rename done on both sides' '
+test_expect_merge_success recursive=failure '6b2: Same rename done on both sides' '
 	test_setup_6b2 &&
 	(
 		cd 6b2 &&
@@ -3471,7 +3472,7 @@ test_setup_10e () {
 	)
 }
 
-test_expect_failure '10e: Does git complain about untracked file that is not really in the way?' '
+test_expect_merge_success recursive=failure '10e: Does git complain about untracked file that is not really in the way?' '
 	test_setup_10e &&
 	(
 		cd 10e &&
@@ -4104,7 +4105,7 @@ test_setup_12b1 () {
 	)
 }
 
-test_expect_failure '12b1: Moving two directory hierarchies into each other' '
+test_expect_merge_success recursive=failure '12b1: Moving two directory hierarchies into each other' '
 	test_setup_12b1 &&
 	(
 		cd 12b1 &&
@@ -4272,7 +4273,7 @@ test_setup_12c1 () {
 	)
 }
 
-test_expect_failure '12c1: Moving one directory hierarchy into another w/ content merge' '
+test_expect_merge_success recursive=failure '12c1: Moving one directory hierarchy into another w/ content merge' '
 	test_setup_12c1 &&
 	(
 		cd 12c1 &&
@@ -4632,7 +4633,7 @@ test_setup_12f () {
 	)
 }
 
-test_expect_failure '12f: Trivial directory resolve, caching, all kinds of fun' '
+test_expect_merge_success recursive=failure '12f: Trivial directory resolve, caching, all kinds of fun' '
 	test_setup_12f &&
 	(
 		cd 12f &&
diff --git a/t/t6426-merge-skip-unneeded-updates.sh b/t/t6426-merge-skip-unneeded-updates.sh
index 699813671c..8510d4da8b 100755
--- a/t/t6426-merge-skip-unneeded-updates.sh
+++ b/t/t6426-merge-skip-unneeded-updates.sh
@@ -23,6 +23,7 @@ test_description="merge cases"
 #                     files that might be renamed into each other's paths.)
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-merge.sh
 
 
 ###########################################################################
@@ -666,7 +667,7 @@ test_setup_4a () {
 #   correct requires doing the merge in-memory first, then realizing that no
 #   updates to the file are necessary, and thus that we can just leave the path
 #   alone.
-test_expect_failure '4a: Change on A, change on B subset of A, dirty mods present' '
+test_expect_merge_success recursive=failure '4a: Change on A, change on B subset of A, dirty mods present' '
 	test_setup_4a &&
 	(
 		cd 4a &&
diff --git a/t/t6430-merge-recursive.sh b/t/t6430-merge-recursive.sh
index a328260d42..4795a7abd0 100755
--- a/t/t6430-merge-recursive.sh
+++ b/t/t6430-merge-recursive.sh
@@ -3,6 +3,7 @@
 test_description='merge-recursive backend test'
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-merge.sh
 
 test_expect_success 'setup 1' '
 
@@ -641,7 +642,7 @@ test_expect_success 'merge-recursive copy vs. rename' '
 	test_cmp expected actual
 '
 
-test_expect_failure 'merge-recursive rename vs. rename/symlink' '
+test_expect_merge_success recursive=failure 'merge-recursive rename vs. rename/symlink' '
 
 	git checkout -f rename &&
 	git merge rename-ln &&
-- 
2.29.0.rc1

