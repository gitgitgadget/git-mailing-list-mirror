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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3DFBC433E0
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 20:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64C5921473
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 20:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmvcHCdt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391684AbgFWUf1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391666AbgFWUfX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 16:35:23 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461CBC061573
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 13:35:24 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id e2so34560qvw.7
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 13:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=OFN1cr427ElWZxQmTUov+oFt34qybmS48O6L5v8y0Rs=;
        b=GmvcHCdtXLrXjZ5oqWJGfQgrZU+i0y2HLueiYeBBwHfysHcmS/LoeutpZyFGIhCR42
         3LjS/5XLugk+jj1h+VQwhjuHNtWZR5cFwuz2AKzpS7X67DZ/46eFkw9c2OZBN/CQ8+Oo
         RdLfaTEtpwhED9bjBXFvpkpjdFe0V6ZGWrLw+2ViOWVoeOU2EbIOY8kjc5kAvpQKlFXx
         NQxJTk9lGzrWrrQCUKU7lh5yQl1Aicq8SvYH4rR8YA0mx11um4dydB/LYLJ6fgfOJeST
         bZEv38uUf/6VTBV8bL/oNJ0YCSOQl1h/lmu4Aj2r0DCZxjY0US1z3ZtYaWJje2EVmAp6
         mC/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OFN1cr427ElWZxQmTUov+oFt34qybmS48O6L5v8y0Rs=;
        b=bXFqxEqWXs72qn0wEMjsYV65toI9gelskGEQTvZ3hPivqfII77Oqabpup7NVlIxDIa
         wlCVuVwY95s20paqWEQtM5FHblQ86tmFYABERZ6KBCVvQxhSYx/63fxQs+8bzszx938X
         yd1BjeWUSaNcmtdGk0mYKB0x2u5VpNgc6mnxqcGV/AiCxyju3mocrlbVhUzgRB3C0d1O
         TAqCkdpIN48yVZ3fC73kxzUoKGYVH+B57L7Fn3H2LnwvuoMx/cI5TvOEHsAMLxffSLa8
         Ytnd4TDz7G2tZGOvmWtgMkj1718YZMYYjLOr9y+7y1ldLKiKopBDtRdwU7+S53jyEHHG
         a9kw==
X-Gm-Message-State: AOAM532p1q9QF1x9qkSqz7eBNOGFyt5Z9OwWJIDVmWN00rExRHRb/+6+
        JRLaS3ArO3ABiseQdTIuTp52HkrQ/cg=
X-Google-Smtp-Source: ABdhPJwFDi6gAhtOm4zcXQ13ZInNVxHLFvYJfdBoqiDA6tJsfqxDqiA2L2o347HakWCfJRjbreOVKQ==
X-Received: by 2002:ad4:4368:: with SMTP id u8mr27665199qvt.227.1592944522719;
        Tue, 23 Jun 2020 13:35:22 -0700 (PDT)
Received: from archbookpro.phub.net.cable.rogers.com (CPEc05627352ede-CM185933998587.cpe.net.cable.rogers.com. [174.112.146.193])
        by smtp.gmail.com with ESMTPSA id x144sm1446321qkb.93.2020.06.23.13.35.21
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 13:35:22 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH v5.1] lib-submodule-update: pass 'test_must_fail' as an argument
Date:   Tue, 23 Jun 2020 16:35:14 -0400
Message-Id: <7b9c19b3606f31b12a79591a41847dcb0a071751.1592942453.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.27.0.307.g7979e895e7
In-Reply-To: <cover.1592907663.git.liu.denton@gmail.com>
References: <cover.1592907663.git.liu.denton@gmail.com>
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

Instead of invoking `test_must_fail $command`, pass the string
"test_must_fail" as the second argument in case where the git command is
expected to fail.

When $command is a helper function, the parent function calling
test_submodule_switch_common() is test_submodule_switch_func(). For all
test_submodule_switch_func() invocations, increase the granularity of
the argument test helper function by prefixing the git invocation which is
meant to fail with the second argument like this:

	$2 git checkout "$1"

In the other cases, test_submodule_switch() and
test_submodule_forced_switch(), instead of passing in the git command
directly, wrap it using the git_test_func() and pass the git arguments
using the global variable $gitcmd. Unfortunately, since closures aren't
a thing in shell scripts, the global variable is necessary. Another
unfortunate result is that the "git_test_func" will used as the test
case name when $command is printed but it's worth it for the cleaner
code.

Finally, as an added bonus, `test_must_fail` will now only run on git
commands.

An alternate design was considered where the global variable,
$OVERWRITING_FAIL, is set from test_submodule_switch_common() and
exposed to the helper function. This would allow $command to be set to a
more sensible value. However this approach was considered too difficult
to understand due to the fact that using a signalling magical global
variable is too indirect and it's best to keep the magic confined to
within one file.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
[I dropped the CC list because I've already sent out two copies of this
patch but, for some reason, it isn't hitting the list. I don't want to
spam anyone while I'm experimenting.]

This patch replaces v5 4/4. Hopefully, this'll be the last iteration...

 t/lib-submodule-update.sh   | 49 +++++++++++++++++++++++++++----------
 t/t3426-rebase-submodule.sh |  4 +--
 t/t3513-revert-submodule.sh |  6 ++++-
 t/t3906-stash-submodule.sh  |  6 ++++-
 t/t4137-apply-submodule.sh  |  6 +++--
 t/t4255-am-submodule.sh     |  6 +++--
 t/t5572-pull-submodule.sh   |  8 +++---
 t/t6041-bisect-submodule.sh |  6 ++++-
 8 files changed, 65 insertions(+), 26 deletions(-)

diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index 7c3ba1be00..53c5374ea1 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -303,8 +303,12 @@ test_submodule_content () {
 # update" is run. And even then that command doesn't delete the work tree of
 # a removed submodule.
 #
+# The first argument of the callback function will be the name of the submodule.
+#
 # Removing a submodule containing a .git directory must fail even when forced
-# to protect the history!
+# to protect the history! If we are testing this case, the second argument of
+# the callback function will be 'test_must_fail', else it will be the empty
+# string.
 #
 
 # Internal function; use test_submodule_switch_func(), test_submodule_switch(),
@@ -443,7 +447,7 @@ test_submodule_switch_common () {
 		(
 			cd submodule_update &&
 			git branch -t replace_sub1_with_directory origin/replace_sub1_with_directory &&
-			test_must_fail $command replace_sub1_with_directory &&
+			$command replace_sub1_with_directory test_must_fail &&
 			test_superproject_content origin/add_sub1 &&
 			test_submodule_content sub1 origin/add_sub1
 		)
@@ -456,7 +460,7 @@ test_submodule_switch_common () {
 			cd submodule_update &&
 			git branch -t replace_sub1_with_directory origin/replace_sub1_with_directory &&
 			replace_gitfile_with_git_dir sub1 &&
-			test_must_fail $command replace_sub1_with_directory &&
+			$command replace_sub1_with_directory test_must_fail &&
 			test_superproject_content origin/add_sub1 &&
 			test_git_directory_is_unchanged sub1 &&
 			test_submodule_content sub1 origin/add_sub1
@@ -470,7 +474,7 @@ test_submodule_switch_common () {
 		(
 			cd submodule_update &&
 			git branch -t replace_sub1_with_file origin/replace_sub1_with_file &&
-			test_must_fail $command replace_sub1_with_file &&
+			$command replace_sub1_with_file test_must_fail &&
 			test_superproject_content origin/add_sub1 &&
 			test_submodule_content sub1 origin/add_sub1
 		)
@@ -484,7 +488,7 @@ test_submodule_switch_common () {
 			cd submodule_update &&
 			git branch -t replace_sub1_with_file origin/replace_sub1_with_file &&
 			replace_gitfile_with_git_dir sub1 &&
-			test_must_fail $command replace_sub1_with_file &&
+			$command replace_sub1_with_file test_must_fail &&
 			test_superproject_content origin/add_sub1 &&
 			test_git_directory_is_unchanged sub1 &&
 			test_submodule_content sub1 origin/add_sub1
@@ -559,12 +563,25 @@ test_submodule_switch_common () {
 # conditions, set the appropriate KNOWN_FAILURE_* variable used in the tests
 # below to 1.
 #
-# Use as follows:
+# The first argument of the callback function will be the name of the submodule.
+#
+# Removing a submodule containing a .git directory must fail even when forced
+# to protect the history! If we are testing this case, the second argument of
+# the callback function will be 'test_must_fail', else it will be the empty
+# string.
+#
+# The following example uses `git some-command` as an example command to be
+# tested. It updates the worktree and index to match a target, but not any
+# submodule directories.
 #
 # my_func () {
-#   target=$1
-#   # Do something here that updates the worktree and index to match target,
-#   # but not any submodule directories.
+#   ...prepare for `git some-command` to be run...
+#   $2 git some-command "$1" &&
+#   if test -n "$2"
+#   then
+#     return
+#   fi &&
+#   ...check the state after git some-command is run...
 # }
 # test_submodule_switch_func "my_func"
 test_submodule_switch_func () {
@@ -580,23 +597,29 @@ test_submodule_switch_func () {
 			cd submodule_update &&
 			git branch -t add_sub1 origin/add_sub1 &&
 			>sub1 &&
-			test_must_fail $command add_sub1 &&
+			$command add_sub1 test_must_fail &&
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
index 95a7f64471..f98e3301b9 100755
--- a/t/t3513-revert-submodule.sh
+++ b/t/t3513-revert-submodule.sh
@@ -15,7 +15,11 @@ git_revert () {
 	git status -su >expect &&
 	ls -1pR * >>expect &&
 	tar cf "$TRASH_DIRECTORY/tmp.tar" * &&
-	git checkout "$1" &&
+	$2 git checkout "$1" &&
+	if test -n "$2"
+	then
+		return
+	fi &&
 	git revert HEAD &&
 	rm -rf * &&
 	tar xf "$TRASH_DIRECTORY/tmp.tar" &&
diff --git a/t/t3906-stash-submodule.sh b/t/t3906-stash-submodule.sh
index 6a7e801ca0..61db4a9886 100755
--- a/t/t3906-stash-submodule.sh
+++ b/t/t3906-stash-submodule.sh
@@ -8,7 +8,11 @@ test_description='stash can handle submodules'
 git_stash () {
 	git status -su >expect &&
 	ls -1pR * >>expect &&
-	git read-tree -u -m "$1" &&
+	$2 git read-tree -u -m "$1" &&
+	if test -n "$2"
+	then
+		return
+	fi &&
 	git stash &&
 	git status -su >actual &&
 	ls -1pR * >>actual &&
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
index 0e0cdf638d..619f181032 100755
--- a/t/t6041-bisect-submodule.sh
+++ b/t/t6041-bisect-submodule.sh
@@ -10,7 +10,11 @@ git_bisect () {
 	ls -1pR * >>expect &&
 	tar cf "$TRASH_DIRECTORY/tmp.tar" * &&
 	GOOD=$(git rev-parse --verify HEAD) &&
-	git checkout "$1" &&
+	$2 git checkout "$1" &&
+	if test -n "$2"
+	then
+		return
+	fi &&
 	echo "foo" >bar &&
 	git add bar &&
 	git commit -m "bisect bad" &&
-- 
2.27.0.307.g7979e895e7

