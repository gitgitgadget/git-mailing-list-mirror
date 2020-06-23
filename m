Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D6BC433E2
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 10:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA1C72072E
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 10:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ku0TWdT8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732242AbgFWK23 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 06:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732185AbgFWK2X (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 06:28:23 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36725C061755
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 03:28:23 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id z2so12880556qts.5
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 03:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FkL/WFpZK+4XbnO2A6iqjSg2Nt34poQlX00cRGXCT8g=;
        b=ku0TWdT8EvoAEtqY5zTr2W1PUIMEhzS3EZ2N19ubHnqu9Q0/6Do/enZSgMeGztokYk
         766XDl+dam4eLRv4OkYEjc7zjgZ3EuLODXE9Nq4D6W4o4a/Xe6bisnOVESLIY8Xj0GR9
         fRTvuuyNF14Tau4RXtxfBF5brFTbWkJfRqniKjHrxYGgEa61M+6N4Kmp1mELRLm00SnC
         cAhFcFUlU34BoxchqUUA2jPdehTqQ9dSXW+Ug45tV8PUpWlZDjsxrQu3GdbMtZv7/QHI
         yd5Wvr8MUYzxXVwsbHOKTmjsdL/QtGy7oMd68K/tm44ojVcLI5vtvqNcdg90AWTS4cP3
         SrbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FkL/WFpZK+4XbnO2A6iqjSg2Nt34poQlX00cRGXCT8g=;
        b=RfPFyNhslqH6t3MuEaHz54i1w70RGzDPC6qlm8mCgeCHWmCgSSgMzdmA7wPnISN3ks
         SjTN2vTI/xU8R9WRxPDrmVl5Janw/h/Z3Yn6OQ+Iok8Mg672JWK8ULy7AjWqXGf3pXHs
         TPLv4VIW0qNX38Fw0NDgiwx+jojXmbFlJiXRT7Zzh5BH6EXh9ItJyu3+IWAE5G+gk/c3
         GoBB0z/k08lsttdBiYGjeHcx/+ES5CGXvbjvRU8XW2AtnQc3Ro9fTWRmpsJe99AFOfVE
         GUw/Ct6gsYT2WKo+RQ02Z00ECgYuCguJvxKcjD/rvdyOJ1fVZfJ/d/07Jj+BfCXzoTZ0
         xk3g==
X-Gm-Message-State: AOAM531nkttMBkY6nAvuGeRnNRllGJpuT/mjUFIfAS2TL0mLJiMbX5FY
        qKY12NMMkLhIpQ1vAWlMaDsJhsoELog=
X-Google-Smtp-Source: ABdhPJziz3nPi/Hiegp6XopGu270CdfqXnEVdbypnjgfHXpzPhdqInD7k3I2Q9CRKasDvyEBKBF+cA==
X-Received: by 2002:ac8:895:: with SMTP id v21mr20707474qth.185.1592908102025;
        Tue, 23 Jun 2020 03:28:22 -0700 (PDT)
Received: from archbookpro.phub.net.cable.rogers.com (CPEc05627352ede-CM185933998587.cpe.net.cable.rogers.com. [174.112.146.193])
        by smtp.gmail.com with ESMTPSA id a126sm153795qkc.82.2020.06.23.03.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 03:28:21 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH v5 4/4] lib-submodule-update: use callbacks in test_submodule_switch_common()
Date:   Tue, 23 Jun 2020 06:28:05 -0400
Message-Id: <250eee1dd35485bec33b80a6c97ecc3c3f276280.1592907663.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.27.0.132.g321788e831
In-Reply-To: <cover.1592907663.git.liu.denton@gmail.com>
References: <cover.1592470068.git.liu.denton@gmail.com> <cover.1592907663.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we run a test helper function in test_submodule_switch_common(), we
sometimes specify a whole helper function as the $command. When we do
this, in some test cases, we just mark the whole function with
`test_must_fail`. However, it's possible that the helper function might
fail earlier or later than expected due to an introduced bug. If this
happens, then the test case will still report as passing but it should
really be marked as failing since it didn't actually display the
intended behaviour.

Instead of invoking $command as one monolithic helper function, break it
up into two parts:

	1. $command which is a function containing a git command.
	2. $after which is a callback function that runs just after
	   $command.

If the command requires a filename argument, it will be passed in as
the first arg.

The $after callback function will be passed the filename as the first
arg. This callback function is optional and, if missing, will be
replaced with `true`. Also, in the case where we have a `test_must_fail`
test, $after will not be executed, similar to how the helper functions
currently behave when the git command fails and exits the &&-chain.

Finally, as an added bonus, `test_must_fail` will now only run on git
commands.

An alternate design was considered where $OVERWRITING_FAIL is set from
test_submodule_switch_common() and exposed to the helper function. This
approach was considered too difficult to understand due to the fact that
using a signalling magic environment variable might be too indirect.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/lib-submodule-update.sh   | 89 +++++++++++++++++++++++++++----------
 t/t3426-rebase-submodule.sh |  4 +-
 t/t3513-revert-submodule.sh |  7 ++-
 t/t3906-stash-submodule.sh  |  7 ++-
 t/t4137-apply-submodule.sh  |  6 ++-
 t/t4255-am-submodule.sh     |  6 ++-
 t/t5572-pull-submodule.sh   |  8 ++--
 t/t6041-bisect-submodule.sh |  7 ++-
 8 files changed, 94 insertions(+), 40 deletions(-)

diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index 7c3ba1be00..104090b489 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -290,6 +290,17 @@ test_submodule_content () {
 	)
 }
 
+test_command () {
+	command="$1" after="$2" arg="$3" &&
+	$command "$arg" &&
+	$after "$arg"
+}
+
+test_command_fail () {
+	command="$1" arg="$2" &&
+	$command "$arg" test_must_fail
+}
+
 # Test that the following transitions are correctly handled:
 # - Updated submodule
 # - New submodule
@@ -306,11 +317,20 @@ test_submodule_content () {
 # Removing a submodule containing a .git directory must fail even when forced
 # to protect the history!
 #
+# $1: The function which contains the git command. It will be passed two
+# arguments. $1 will be the submodule being operated on. $2 will be
+# "test_must_fail" if the git command is expected to fail, else the empty
+# string.
+#
+# $2: The function that will run after $1. It will be passed the submodule
+# being operated on as the only argument. This argument is optional. It will
+# not be run when testing a case where the git command is expected to fail.
 
 # Internal function; use test_submodule_switch_func(), test_submodule_switch(),
 # or test_submodule_forced_switch() instead.
 test_submodule_switch_common () {
-	command="$1"
+	command="$1" after="${2:-true}"
+
 	######################### Appearing submodule #########################
 	# Switching to a commit letting a submodule appear creates empty dir ...
 	if test "$KNOWN_FAILURE_STASH_DOES_IGNORE_SUBMODULE_CHANGES" = 1
@@ -326,7 +346,7 @@ test_submodule_switch_common () {
 		(
 			cd submodule_update &&
 			git branch -t add_sub1 origin/add_sub1 &&
-			$command add_sub1 &&
+			test_command "$command" "$after" add_sub1 &&
 			test_superproject_content origin/add_sub1 &&
 			test_dir_is_empty sub1 &&
 			git submodule update --init --recursive &&
@@ -341,7 +361,7 @@ test_submodule_switch_common () {
 			cd submodule_update &&
 			mkdir sub1 &&
 			git branch -t add_sub1 origin/add_sub1 &&
-			$command add_sub1 &&
+			test_command "$command" "$after" add_sub1 &&
 			test_superproject_content origin/add_sub1 &&
 			test_dir_is_empty sub1 &&
 			git submodule update --init --recursive &&
@@ -356,7 +376,7 @@ test_submodule_switch_common () {
 		(
 			cd submodule_update &&
 			git branch -t replace_file_with_sub1 origin/replace_file_with_sub1 &&
-			$command replace_file_with_sub1 &&
+			test_command "$command" "$after" replace_file_with_sub1 &&
 			test_superproject_content origin/replace_file_with_sub1 &&
 			test_dir_is_empty sub1 &&
 			git submodule update --init --recursive &&
@@ -380,7 +400,7 @@ test_submodule_switch_common () {
 		(
 			cd submodule_update &&
 			git branch -t replace_directory_with_sub1 origin/replace_directory_with_sub1 &&
-			$command replace_directory_with_sub1 &&
+			test_command "$command" "$after" replace_directory_with_sub1 &&
 			test_superproject_content origin/replace_directory_with_sub1 &&
 			test_dir_is_empty sub1 &&
 			git submodule update --init --recursive &&
@@ -402,7 +422,7 @@ test_submodule_switch_common () {
 		(
 			cd submodule_update &&
 			git branch -t remove_sub1 origin/remove_sub1 &&
-			$command remove_sub1 &&
+			test_command "$command" "$after" remove_sub1 &&
 			test_superproject_content origin/remove_sub1 &&
 			test_submodule_content sub1 origin/add_sub1
 		)
@@ -415,7 +435,7 @@ test_submodule_switch_common () {
 			cd submodule_update &&
 			git branch -t remove_sub1 origin/remove_sub1 &&
 			replace_gitfile_with_git_dir sub1 &&
-			$command remove_sub1 &&
+			test_command "$command" "$after" remove_sub1 &&
 			test_superproject_content origin/remove_sub1 &&
 			test_git_directory_is_unchanged sub1 &&
 			test_submodule_content sub1 origin/add_sub1
@@ -443,7 +463,7 @@ test_submodule_switch_common () {
 		(
 			cd submodule_update &&
 			git branch -t replace_sub1_with_directory origin/replace_sub1_with_directory &&
-			test_must_fail $command replace_sub1_with_directory &&
+			test_command_fail "$command" replace_sub1_with_directory &&
 			test_superproject_content origin/add_sub1 &&
 			test_submodule_content sub1 origin/add_sub1
 		)
@@ -456,7 +476,7 @@ test_submodule_switch_common () {
 			cd submodule_update &&
 			git branch -t replace_sub1_with_directory origin/replace_sub1_with_directory &&
 			replace_gitfile_with_git_dir sub1 &&
-			test_must_fail $command replace_sub1_with_directory &&
+			test_command_fail "$command" replace_sub1_with_directory &&
 			test_superproject_content origin/add_sub1 &&
 			test_git_directory_is_unchanged sub1 &&
 			test_submodule_content sub1 origin/add_sub1
@@ -470,7 +490,7 @@ test_submodule_switch_common () {
 		(
 			cd submodule_update &&
 			git branch -t replace_sub1_with_file origin/replace_sub1_with_file &&
-			test_must_fail $command replace_sub1_with_file &&
+			test_command_fail "$command" replace_sub1_with_file &&
 			test_superproject_content origin/add_sub1 &&
 			test_submodule_content sub1 origin/add_sub1
 		)
@@ -484,7 +504,7 @@ test_submodule_switch_common () {
 			cd submodule_update &&
 			git branch -t replace_sub1_with_file origin/replace_sub1_with_file &&
 			replace_gitfile_with_git_dir sub1 &&
-			test_must_fail $command replace_sub1_with_file &&
+			test_command_fail "$command" replace_sub1_with_file &&
 			test_superproject_content origin/add_sub1 &&
 			test_git_directory_is_unchanged sub1 &&
 			test_submodule_content sub1 origin/add_sub1
@@ -508,7 +528,7 @@ test_submodule_switch_common () {
 		(
 			cd submodule_update &&
 			git branch -t modify_sub1 origin/modify_sub1 &&
-			$command modify_sub1 &&
+			test_command "$command" "$after" modify_sub1 &&
 			test_superproject_content origin/modify_sub1 &&
 			test_submodule_content sub1 origin/add_sub1 &&
 			git submodule update &&
@@ -523,7 +543,7 @@ test_submodule_switch_common () {
 		(
 			cd submodule_update &&
 			git branch -t invalid_sub1 origin/invalid_sub1 &&
-			$command invalid_sub1 &&
+			test_command "$command" "$after" invalid_sub1 &&
 			test_superproject_content origin/invalid_sub1 &&
 			test_submodule_content sub1 origin/add_sub1 &&
 			test_must_fail git submodule update &&
@@ -538,7 +558,7 @@ test_submodule_switch_common () {
 		(
 			cd submodule_update &&
 			git branch -t valid_sub1 origin/valid_sub1 &&
-			$command valid_sub1 &&
+			test_command "$command" "$after" valid_sub1 &&
 			test_superproject_content origin/valid_sub1 &&
 			test_dir_is_empty sub1 &&
 			git submodule update --init --recursive &&
@@ -559,17 +579,32 @@ test_submodule_switch_common () {
 # conditions, set the appropriate KNOWN_FAILURE_* variable used in the tests
 # below to 1.
 #
-# Use as follows:
+# $1: The function which contains the git command. It will be passed two
+# arguments. $1 will be the submodule being operated on. $2 will be
+# "test_must_fail" if the git command is expected to fail, else the empty
+# string.
+#
+# $2: The function that will run after $1. It will be passed the submodule
+# being operated on as the only argument. This argument is optional. It will
+# not be run when testing a case where the git command is expected to fail.
+#
+# The following example uses `git some-command` as an example command to be
+# tested. It updates the worktree and index to match a target, but not any
+# submodule directories.
 #
 # my_func () {
 #   target=$1
-#   # Do something here that updates the worktree and index to match target,
-#   # but not any submodule directories.
+#   $2 git some-command $target
 # }
-# test_submodule_switch_func "my_func"
+# my_func_after () {
+#   target=$1
+#   # Check the state after git some-command is run
+# }
+# test_submodule_switch_func "my_func" "my_func_after"
 test_submodule_switch_func () {
 	command="$1"
-	test_submodule_switch_common "$command"
+	after="$2"
+	test_submodule_switch_common "$command" "$after"
 
 	# An empty directory does not prevent the creation of a submodule of
 	# the same name, but a file does.
@@ -580,23 +615,29 @@ test_submodule_switch_func () {
 			cd submodule_update &&
 			git branch -t add_sub1 origin/add_sub1 &&
 			>sub1 &&
-			test_must_fail $command add_sub1 &&
+			test_command_fail "$command" add_sub1 &&
 			test_superproject_content origin/no_submodule &&
 			test_must_be_empty sub1
 		)
 	'
 }
 
+git_test_func () {
+	$2 git $gitcmd "$1"
+}
+
 test_submodule_switch () {
-	test_submodule_switch_func "git $1"
+	gitcmd="$1"
+	test_submodule_switch_func "git_test_func"
 }
 
 # Same as test_submodule_switch(), except that throwing away local changes in
 # the superproject is allowed.
 test_submodule_forced_switch () {
-	command="$1"
+	gitcmd="$1"
+	command="git_test_func"
 	KNOWN_FAILURE_FORCED_SWITCH_TESTS=1
-	test_submodule_switch_common "git $command"
+	test_submodule_switch_common "$command"
 
 	# When forced, a file in the superproject does not prevent creating a
 	# submodule of the same name.
@@ -607,7 +648,7 @@ test_submodule_forced_switch () {
 			cd submodule_update &&
 			git branch -t add_sub1 origin/add_sub1 &&
 			>sub1 &&
-			$command add_sub1 &&
+			test_command "$command" true add_sub1 &&
 			test_superproject_content origin/add_sub1 &&
 			test_dir_is_empty sub1
 		)
diff --git a/t/t3426-rebase-submodule.sh b/t/t3426-rebase-submodule.sh
index 788605ccc0..dd5daa53d3 100755
--- a/t/t3426-rebase-submodule.sh
+++ b/t/t3426-rebase-submodule.sh
@@ -17,7 +17,7 @@ git_rebase () {
 	git status -su >actual &&
 	ls -1pR * >>actual &&
 	test_cmp expect actual &&
-	git rebase "$1"
+	$2 git rebase "$1"
 }
 
 test_submodule_switch_func "git_rebase"
@@ -35,7 +35,7 @@ git_rebase_interactive () {
 	test_cmp expect actual &&
 	set_fake_editor &&
 	echo "fake-editor.sh" >.git/info/exclude &&
-	git rebase -i "$1"
+	$2 git rebase -i "$1"
 }
 
 test_submodule_switch_func "git_rebase_interactive"
diff --git a/t/t3513-revert-submodule.sh b/t/t3513-revert-submodule.sh
index 95a7f64471..7ac06731bd 100755
--- a/t/t3513-revert-submodule.sh
+++ b/t/t3513-revert-submodule.sh
@@ -15,7 +15,10 @@ git_revert () {
 	git status -su >expect &&
 	ls -1pR * >>expect &&
 	tar cf "$TRASH_DIRECTORY/tmp.tar" * &&
-	git checkout "$1" &&
+	$2 git checkout "$1"
+}
+
+git_revert_after () {
 	git revert HEAD &&
 	rm -rf * &&
 	tar xf "$TRASH_DIRECTORY/tmp.tar" &&
@@ -26,6 +29,6 @@ git_revert () {
 }
 
 KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR=1
-test_submodule_switch_func "git_revert"
+test_submodule_switch_func "git_revert" "git_revert_after"
 
 test_done
diff --git a/t/t3906-stash-submodule.sh b/t/t3906-stash-submodule.sh
index 6a7e801ca0..30bdc113cd 100755
--- a/t/t3906-stash-submodule.sh
+++ b/t/t3906-stash-submodule.sh
@@ -8,7 +8,10 @@ test_description='stash can handle submodules'
 git_stash () {
 	git status -su >expect &&
 	ls -1pR * >>expect &&
-	git read-tree -u -m "$1" &&
+	$2 git read-tree -u -m "$1"
+}
+
+git_stash_after () {
 	git stash &&
 	git status -su >actual &&
 	ls -1pR * >>actual &&
@@ -19,7 +22,7 @@ git_stash () {
 KNOWN_FAILURE_STASH_DOES_IGNORE_SUBMODULE_CHANGES=1
 KNOWN_FAILURE_CHERRY_PICK_SEES_EMPTY_COMMIT=1
 KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR=1
-test_submodule_switch_func "git_stash"
+test_submodule_switch_func "git_stash" "git_stash_after"
 
 setup_basic () {
 	test_when_finished "rm -rf main sub" &&
diff --git a/t/t4137-apply-submodule.sh b/t/t4137-apply-submodule.sh
index b645e303a0..5477d48ffd 100755
--- a/t/t4137-apply-submodule.sh
+++ b/t/t4137-apply-submodule.sh
@@ -6,13 +6,15 @@ test_description='git apply handling submodules'
 . "$TEST_DIRECTORY"/lib-submodule-update.sh
 
 apply_index () {
-	git diff --ignore-submodules=dirty "..$1" | git apply --index -
+	git diff --ignore-submodules=dirty "..$1" >diff &&
+	$2 git apply --index diff
 }
 
 test_submodule_switch_func "apply_index"
 
 apply_3way () {
-	git diff --ignore-submodules=dirty "..$1" | git apply --3way -
+	git diff --ignore-submodules=dirty "..$1" >diff
+	$2 git apply --3way diff
 }
 
 test_submodule_switch_func "apply_3way"
diff --git a/t/t4255-am-submodule.sh b/t/t4255-am-submodule.sh
index 1b179d5f45..8403124ac0 100755
--- a/t/t4255-am-submodule.sh
+++ b/t/t4255-am-submodule.sh
@@ -6,13 +6,15 @@ test_description='git am handling submodules'
 . "$TEST_DIRECTORY"/lib-submodule-update.sh
 
 am () {
-	git format-patch --stdout --ignore-submodules=dirty "..$1" | git am -
+	git format-patch --stdout --ignore-submodules=dirty "..$1" >patch &&
+	$2 git am patch
 }
 
 test_submodule_switch_func "am"
 
 am_3way () {
-	git format-patch --stdout --ignore-submodules=dirty "..$1" | git am --3way -
+	git format-patch --stdout --ignore-submodules=dirty "..$1" >patch &&
+	$2 git am --3way patch
 }
 
 KNOWN_FAILURE_NOFF_MERGE_ATTEMPTS_TO_MERGE_REMOVED_SUBMODULE_FILES=1
diff --git a/t/t5572-pull-submodule.sh b/t/t5572-pull-submodule.sh
index f911bf631e..cfa40b9251 100755
--- a/t/t5572-pull-submodule.sh
+++ b/t/t5572-pull-submodule.sh
@@ -13,7 +13,7 @@ reset_branch_to_HEAD () {
 
 git_pull () {
 	reset_branch_to_HEAD "$1" &&
-	git pull
+	$2 git pull
 }
 
 # pulls without conflicts
@@ -21,21 +21,21 @@ test_submodule_switch_func "git_pull"
 
 git_pull_ff () {
 	reset_branch_to_HEAD "$1" &&
-	git pull --ff
+	$2 git pull --ff
 }
 
 test_submodule_switch_func "git_pull_ff"
 
 git_pull_ff_only () {
 	reset_branch_to_HEAD "$1" &&
-	git pull --ff-only
+	$2 git pull --ff-only
 }
 
 test_submodule_switch_func "git_pull_ff_only"
 
 git_pull_noff () {
 	reset_branch_to_HEAD "$1" &&
-	git pull --no-ff
+	$2 git pull --no-ff
 }
 
 KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR=1
diff --git a/t/t6041-bisect-submodule.sh b/t/t6041-bisect-submodule.sh
index 0e0cdf638d..e213876fcd 100755
--- a/t/t6041-bisect-submodule.sh
+++ b/t/t6041-bisect-submodule.sh
@@ -10,7 +10,10 @@ git_bisect () {
 	ls -1pR * >>expect &&
 	tar cf "$TRASH_DIRECTORY/tmp.tar" * &&
 	GOOD=$(git rev-parse --verify HEAD) &&
-	git checkout "$1" &&
+	$2 git checkout "$1"
+}
+
+git_bisect_after () {
 	echo "foo" >bar &&
 	git add bar &&
 	git commit -m "bisect bad" &&
@@ -27,6 +30,6 @@ git_bisect () {
 	git bisect bad $BAD
 }
 
-test_submodule_switch_func "git_bisect"
+test_submodule_switch_func "git_bisect" "git_bisect_after"
 
 test_done
-- 
2.27.0.132.g321788e831

