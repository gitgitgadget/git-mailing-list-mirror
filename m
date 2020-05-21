Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DEDEC433E1
	for <git@archiver.kernel.org>; Thu, 21 May 2020 00:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76FF8205CB
	for <git@archiver.kernel.org>; Thu, 21 May 2020 00:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTizk0Wz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbgEUAYv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 May 2020 20:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726737AbgEUAYu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 May 2020 20:24:50 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525D7C061A0E
        for <git@vger.kernel.org>; Wed, 20 May 2020 17:24:50 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id t25so4224025qtc.0
        for <git@vger.kernel.org>; Wed, 20 May 2020 17:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H+0hlYKuSJ3bI5x+Hs+Oun0jr5jAoOyysBhudmdYTcU=;
        b=LTizk0WzQR5jKFH1cF6o9yK5F0LlTfxL9wG82ze6by3B46SxFAQwOAOGZTFxHgI9Bl
         2oUziH9jVMmmdIHAAcodhbhTdsMJS6EQEAMaEXK2KMrPS3ozDH+uzUwZiHlC7gfPIj+u
         qdUyY5WjScjfjM8Hq6RGdiZ+pB6n9TtM1JlsgQISg0AVGg9pj9/KKUGuAF3uVI5dFDh9
         X+OzRJywhaVla/0WiWLzJh5KTmYaG6qW/SGSSgDMpBRm/IrBG+MC64p8qCaaByRSNqP/
         QistHurdz/mtBCfJk72dBCtOmHf16wjZUyd+1Fp1pP6PCUs1Z/Qhs3oy+x3LORw1rESv
         /WDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H+0hlYKuSJ3bI5x+Hs+Oun0jr5jAoOyysBhudmdYTcU=;
        b=C55lLD7gEsSrPlUACH/LHL4klhnRbM2S2cQWdrfAoyKMFQnXlITbW65+yQsSunG9XY
         pgVzHdiBozpHJqDHIHj4Bhv5m/UCVophzUeQgFSrE+FqeRFm7MM3IGtdM2a2aVLONPG8
         TkmVSToQlSsOro4FViHRASzCj96J+kP//8d5w9F19tCFrBQMEvJrpsWUUw7P3/7Qlhra
         /S2kq8uv9UEeoNO7P266YoEQcxBsFuRn8FnnQXl53FJLSk6v5VOANUTkZxNBjwzOMwlu
         isEDhAHC/ha7mDdUd1C40j1KIrLpbrAVsxn16tPvBCWUdZUzaS6DpKLvaaD6esAs/FyX
         7F4w==
X-Gm-Message-State: AOAM532wBhB1Cf3FUtc+pxTO8XUk+lhuxXILACPydEVo4NY6YXIpV8nJ
        K9q/fEjSqVXJjla2CTh6fN61EjK3
X-Google-Smtp-Source: ABdhPJy3QFHvUElHAnqxMftf+Dnm7fuyrzKMBwwK6i8qcSsAxNIaLkcnLpTaBLCnjBjrXpc0pqLgQA==
X-Received: by 2002:ac8:3782:: with SMTP id d2mr8128242qtc.74.1590020689068;
        Wed, 20 May 2020 17:24:49 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id w67sm3539023qkb.102.2020.05.20.17.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 17:24:48 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 4/4] lib-submodule-update: pass OVERWRITING_FAIL
Date:   Wed, 20 May 2020 20:24:18 -0400
Message-Id: <48598e3f9859dc525ec878cd7f3eaadee8bb61b1.1590019226.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.27.0.rc0.114.g141fe7d276
In-Reply-To: <cover.1590019226.git.liu.denton@gmail.com>
References: <cover.1588162842.git.liu.denton@gmail.com> <cover.1590019226.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We are using `test_must_fail $command`. However, $command is not
necessarily a git command; it could be a test helper function.

In an effort to stop using test_must_fail with non-git commands, instead
of invoking `test_must_fail $command`, run
`OVERWRITING_FAIL=test_must_fail $command` instead in
test_submodule_switch_common().

In the case where $command is a git command,
test_submodule_switch_common() is called by one of
test_submodule_switch() or test_submodule_forced_switch(). In those two
functions, pass $command like this:

	test_submodule_switch_common "eval \$OVERWRITING_FAIL git $command"

When $command is a helper function, the parent function calling
test_submodule_switch_common() is test_submodule_switch_func(). For all
test_submodule_switch_func() invocations, increase the granularity of
the argument test helper function by prefixing the git invocation which is
meant to fail with $OVERWRITING_FAIL like this:

	$OVERWRITING_FAIL git checkout "$1"

This is useful because currently, when we run a test helper function, we
just mark the whole thing as `test_must_fail`. However, it's possible
that the helper function might fail earlier or later than expected due
to an introduced bug. If this happens, then the test case will still
report as passing but it should really be marked as failing since it
didn't actually display the intended behaviour.

While we're at it, some helper functions have git commands piping into
another git command. Break these pipes up into two separate invocations
with a file buffer so that the return code of the first command is not
lost.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/lib-submodule-update.sh   | 33 +++++++++++++++++++++++++--------
 t/t3426-rebase-submodule.sh |  4 ++--
 t/t3513-revert-submodule.sh |  5 +++++
 t/t3906-stash-submodule.sh  |  6 +++++-
 t/t4137-apply-submodule.sh  |  6 ++++--
 t/t4255-am-submodule.sh     |  6 ++++--
 t/t5572-pull-submodule.sh   |  8 ++++----
 t/t6041-bisect-submodule.sh |  6 +++++-
 8 files changed, 54 insertions(+), 20 deletions(-)

diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index fb6c0f3d4f..a0274c03de 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -304,12 +304,15 @@ test_submodule_content () {
 # a removed submodule.
 #
 # Removing a submodule containing a .git directory must fail even when forced
-# to protect the history!
+# to protect the history! If we are testing this case,
+# OVERWRITING_FAIL=test_must_fail, otherwise OVERWRITING_FAIL will be the empty
+# string.
 #
 
 # Internal function; use test_submodule_switch_func(), test_submodule_switch_func(),
 # or test_submodule_forced_switch() instead.
 test_submodule_switch_common () {
+	OVERWRITING_FAIL=
 	command="$1"
 	######################### Appearing submodule #########################
 	# Switching to a commit letting a submodule appear creates empty dir ...
@@ -443,7 +446,9 @@ test_submodule_switch_common () {
 		(
 			cd submodule_update &&
 			git branch -t replace_sub1_with_directory origin/replace_sub1_with_directory &&
-			test_must_fail $command replace_sub1_with_directory &&
+			OVERWRITING_FAIL=test_must_fail &&
+			$command replace_sub1_with_directory &&
+			OVERWRITING_FAIL= &&
 			test_superproject_content origin/add_sub1 &&
 			test_submodule_content sub1 origin/add_sub1
 		)
@@ -456,7 +461,9 @@ test_submodule_switch_common () {
 			cd submodule_update &&
 			git branch -t replace_sub1_with_directory origin/replace_sub1_with_directory &&
 			replace_gitfile_with_git_dir sub1 &&
-			test_must_fail $command replace_sub1_with_directory &&
+			OVERWRITING_FAIL=test_must_fail &&
+			$command replace_sub1_with_directory &&
+			OVERWRITING_FAIL= &&
 			test_superproject_content origin/add_sub1 &&
 			test_git_directory_is_unchanged sub1 &&
 			test_submodule_content sub1 origin/add_sub1
@@ -470,7 +477,9 @@ test_submodule_switch_common () {
 		(
 			cd submodule_update &&
 			git branch -t replace_sub1_with_file origin/replace_sub1_with_file &&
-			test_must_fail $command replace_sub1_with_file &&
+			OVERWRITING_FAIL=test_must_fail &&
+			$command replace_sub1_with_file &&
+			OVERWRITING_FAIL= &&
 			test_superproject_content origin/add_sub1 &&
 			test_submodule_content sub1 origin/add_sub1
 		)
@@ -484,7 +493,9 @@ test_submodule_switch_common () {
 			cd submodule_update &&
 			git branch -t replace_sub1_with_file origin/replace_sub1_with_file &&
 			replace_gitfile_with_git_dir sub1 &&
-			test_must_fail $command replace_sub1_with_file &&
+			OVERWRITING_FAIL=test_must_fail &&
+			$command replace_sub1_with_file &&
+			OVERWRITING_FAIL= &&
 			test_superproject_content origin/add_sub1 &&
 			test_git_directory_is_unchanged sub1 &&
 			test_submodule_content sub1 origin/add_sub1
@@ -559,6 +570,11 @@ test_submodule_switch_common () {
 # conditions, set the appropriate KNOWN_FAILURE_* variable used in the tests
 # below to 1.
 #
+# Removing a submodule containing a .git directory must fail even when forced
+# to protect the history! If we are testing this case,
+# OVERWRITING_FAIL=test_must_fail, otherwise OVERWRITING_FAIL will be the empty
+# string.
+#
 # Use as follows:
 #
 # my_func () {
@@ -568,6 +584,7 @@ test_submodule_switch_common () {
 # }
 # test_submodule_switch_func "my_func"
 test_submodule_switch_func () {
+	OVERWRITING_FAIL=
 	command="$1"
 	test_submodule_switch_common "$command"
 
@@ -580,7 +597,7 @@ test_submodule_switch_func () {
 			cd submodule_update &&
 			git branch -t add_sub1 origin/add_sub1 &&
 			>sub1 &&
-			test_must_fail $command add_sub1 &&
+			OVERWRITING_FAIL=test_must_fail $command add_sub1 &&
 			test_superproject_content origin/no_submodule &&
 			test_must_be_empty sub1
 		)
@@ -588,7 +605,7 @@ test_submodule_switch_func () {
 }
 
 test_submodule_switch () {
-	test_submodule_switch_func "git $1"
+	test_submodule_switch_func "eval \$OVERWRITING_FAIL git $1"
 }
 
 # Same as test_submodule_switch(), except that throwing away local changes in
@@ -596,7 +613,7 @@ test_submodule_switch () {
 test_submodule_forced_switch () {
 	command="$1"
 	KNOWN_FAILURE_FORCED_SWITCH_TESTS=1
-	test_submodule_switch_common "git $command"
+	test_submodule_switch_common "eval \$OVERWRITING_FAIL git $command"
 
 	# When forced, a file in the superproject does not prevent creating a
 	# submodule of the same name.
diff --git a/t/t3426-rebase-submodule.sh b/t/t3426-rebase-submodule.sh
index 788605ccc0..c6a7f584ed 100755
--- a/t/t3426-rebase-submodule.sh
+++ b/t/t3426-rebase-submodule.sh
@@ -17,7 +17,7 @@ git_rebase () {
 	git status -su >actual &&
 	ls -1pR * >>actual &&
 	test_cmp expect actual &&
-	git rebase "$1"
+	$OVERWRITING_FAIL git rebase "$1"
 }
 
 test_submodule_switch_func "git_rebase"
@@ -35,7 +35,7 @@ git_rebase_interactive () {
 	test_cmp expect actual &&
 	set_fake_editor &&
 	echo "fake-editor.sh" >.git/info/exclude &&
-	git rebase -i "$1"
+	$OVERWRITING_FAIL git rebase -i "$1"
 }
 
 test_submodule_switch_func "git_rebase_interactive"
diff --git a/t/t3513-revert-submodule.sh b/t/t3513-revert-submodule.sh
index 95a7f64471..e41f0f2009 100755
--- a/t/t3513-revert-submodule.sh
+++ b/t/t3513-revert-submodule.sh
@@ -15,6 +15,11 @@ git_revert () {
 	git status -su >expect &&
 	ls -1pR * >>expect &&
 	tar cf "$TRASH_DIRECTORY/tmp.tar" * &&
+	$OVERWRITING_FAIL git checkout "$1" &&
+	if test -n "$OVERWRITING_FAIL"
+	then
+		return
+	fi &&
 	git checkout "$1" &&
 	git revert HEAD &&
 	rm -rf * &&
diff --git a/t/t3906-stash-submodule.sh b/t/t3906-stash-submodule.sh
index 6a7e801ca0..6e8dac9669 100755
--- a/t/t3906-stash-submodule.sh
+++ b/t/t3906-stash-submodule.sh
@@ -8,7 +8,11 @@ test_description='stash can handle submodules'
 git_stash () {
 	git status -su >expect &&
 	ls -1pR * >>expect &&
-	git read-tree -u -m "$1" &&
+	$OVERWRITING_FAIL git read-tree -u -m "$1" &&
+	if test -n "$OVERWRITING_FAIL"
+	then
+		return
+	fi &&
 	git stash &&
 	git status -su >actual &&
 	ls -1pR * >>actual &&
diff --git a/t/t4137-apply-submodule.sh b/t/t4137-apply-submodule.sh
index b645e303a0..dd08d9e1a4 100755
--- a/t/t4137-apply-submodule.sh
+++ b/t/t4137-apply-submodule.sh
@@ -6,13 +6,15 @@ test_description='git apply handling submodules'
 . "$TEST_DIRECTORY"/lib-submodule-update.sh
 
 apply_index () {
-	git diff --ignore-submodules=dirty "..$1" | git apply --index -
+	git diff --ignore-submodules=dirty "..$1" >diff &&
+	$OVERWRITING_FAIL git apply --index - <diff
 }
 
 test_submodule_switch_func "apply_index"
 
 apply_3way () {
-	git diff --ignore-submodules=dirty "..$1" | git apply --3way -
+	git diff --ignore-submodules=dirty "..$1" >diff &&
+	$OVERWRITING_FAIL git apply --3way - <diff
 }
 
 test_submodule_switch_func "apply_3way"
diff --git a/t/t4255-am-submodule.sh b/t/t4255-am-submodule.sh
index 1b179d5f45..b0fe78a956 100755
--- a/t/t4255-am-submodule.sh
+++ b/t/t4255-am-submodule.sh
@@ -6,13 +6,15 @@ test_description='git am handling submodules'
 . "$TEST_DIRECTORY"/lib-submodule-update.sh
 
 am () {
-	git format-patch --stdout --ignore-submodules=dirty "..$1" | git am -
+	git format-patch --stdout --ignore-submodules=dirty "..$1" >patch &&
+	$OVERWRITING_FAIL git am - <patch
 }
 
 test_submodule_switch_func "am"
 
 am_3way () {
-	git format-patch --stdout --ignore-submodules=dirty "..$1" | git am --3way -
+	git format-patch --stdout --ignore-submodules=dirty "..$1" >patch &&
+	$OVERWRITING_FAIL git am --3way - <patch
 }
 
 KNOWN_FAILURE_NOFF_MERGE_ATTEMPTS_TO_MERGE_REMOVED_SUBMODULE_FILES=1
diff --git a/t/t5572-pull-submodule.sh b/t/t5572-pull-submodule.sh
index f911bf631e..4dd9913b6b 100755
--- a/t/t5572-pull-submodule.sh
+++ b/t/t5572-pull-submodule.sh
@@ -13,7 +13,7 @@ reset_branch_to_HEAD () {
 
 git_pull () {
 	reset_branch_to_HEAD "$1" &&
-	git pull
+	$OVERWRITING_FAIL git pull
 }
 
 # pulls without conflicts
@@ -21,21 +21,21 @@ test_submodule_switch_func "git_pull"
 
 git_pull_ff () {
 	reset_branch_to_HEAD "$1" &&
-	git pull --ff
+	$OVERWRITING_FAIL git pull --ff
 }
 
 test_submodule_switch_func "git_pull_ff"
 
 git_pull_ff_only () {
 	reset_branch_to_HEAD "$1" &&
-	git pull --ff-only
+	$OVERWRITING_FAIL git pull --ff-only
 }
 
 test_submodule_switch_func "git_pull_ff_only"
 
 git_pull_noff () {
 	reset_branch_to_HEAD "$1" &&
-	git pull --no-ff
+	$OVERWRITING_FAIL git pull --no-ff
 }
 
 KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR=1
diff --git a/t/t6041-bisect-submodule.sh b/t/t6041-bisect-submodule.sh
index 0e0cdf638d..759890b721 100755
--- a/t/t6041-bisect-submodule.sh
+++ b/t/t6041-bisect-submodule.sh
@@ -10,7 +10,11 @@ git_bisect () {
 	ls -1pR * >>expect &&
 	tar cf "$TRASH_DIRECTORY/tmp.tar" * &&
 	GOOD=$(git rev-parse --verify HEAD) &&
-	git checkout "$1" &&
+	$OVERWRITING_FAIL git checkout "$1" &&
+	if test -n "$OVERWRITING_FAIL"
+	then
+		return
+	fi &&
 	echo "foo" >bar &&
 	git add bar &&
 	git commit -m "bisect bad" &&
-- 
2.27.0.rc0.114.g141fe7d276

