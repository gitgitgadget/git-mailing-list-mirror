Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C31C6C47247
	for <git@archiver.kernel.org>; Tue,  5 May 2020 11:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90F6D2073B
	for <git@archiver.kernel.org>; Tue,  5 May 2020 11:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bT1JHT9Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728868AbgEELnP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 07:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728624AbgEELnN (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 5 May 2020 07:43:13 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C41C061A0F
        for <git@vger.kernel.org>; Tue,  5 May 2020 04:43:13 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id q7so1892779qkf.3
        for <git@vger.kernel.org>; Tue, 05 May 2020 04:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pkcGdPBdua1X2EXqM/AoaTnD2RpZR5Ucx47Ou937swE=;
        b=bT1JHT9Q+zIqcEPeTbEZYg/T0d+usypoYRkfxOni4Ty92J1f8PwtcvflhR6LFEuU9j
         bhwNkYK+mMOFPJxiwNRj0je9vUQi/sDcCvj1t2Mc71WMWuI+sSvevsnvKt/WDUIz5pSR
         6nQYNdaib+Un/ghd2I1Hfmu+Bdz7sdKLbRKRbjEbEqwUxgXUOFcEjMQwA3bDYdy/eFO3
         rxlnVma9XSJXAmIbfMZ6Mu2Vrg/HT8/ufWGhe5zlszMkUi+/nNarbtJ+y0iDaGvZBURJ
         W3kzpr/a2ctpSZN7CcvNKX3jBK8t3HH9gPwqd5N8svNwf4Jdh/n4KX+1a42c7vT4PVCT
         FiTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pkcGdPBdua1X2EXqM/AoaTnD2RpZR5Ucx47Ou937swE=;
        b=fm59/QQzRA7BJiBUeW8rlObON+95KEgRuHVAcDQpYHCE0YruX7RBSGG6z0a7bDKWdw
         ywhEHU5BW7McYAN4TLpaN2gUA3sjDYGFnuBDayGhdr8xM71RzdDGWpSaT2F5GapLNIuJ
         B2Sj3ikQ4cDu0cdzQfU0C3Xxt4RIFXRn8BPSPTTvytLgbZ7uyJr10e0G6DOKC4/pyLqh
         HC3vjjfZxMIT+LdjkFbWqChca/SIsu8VuFavMhEOtv6HDcdVGCfLFenTkDiXuATmo5R5
         Z80U64XUNXZJvxeS9FcH0umOu/P9C0zUC1ZIwcwKPCjWv4nMcQjE72kzFPyGBDL7yW/h
         DGWw==
X-Gm-Message-State: AGi0PubILofUInMaGeorUqQ8+PwWkHCmcEiI8aCUxeGxE0h808YalZ+6
        RHc/2kbxvl8/dW4HJcFZ8v/u+icJ
X-Google-Smtp-Source: APiQypLAvIqYKM8hn+C3eOlMpvV6zjgfPracRX+E+bpeaXJ2rHmgiw2j/ZBAjLD/D2Tx6QAe3wI9ZQ==
X-Received: by 2002:a37:61d8:: with SMTP id v207mr3122279qkb.146.1588678991808;
        Tue, 05 May 2020 04:43:11 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id m33sm1470659qte.17.2020.05.05.04.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 04:43:10 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v1.2] lib-submodule-update: pass OVERWRITING_FAIL
Date:   Tue,  5 May 2020 07:43:02 -0400
Message-Id: <be2f55bbc86958154e63234945d0030f59c964be.1588678640.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.2.548.gbb00c8a0a9
In-Reply-To: <f0d8dcf7dc52fe5ad2f1e173cd744bfdeb55eb45.1588242122.git.liu.denton@gmail.com>
References: <f0d8dcf7dc52fe5ad2f1e173cd744bfdeb55eb45.1588242122.git.liu.denton@gmail.com>
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

This patch can be better viewed with `--ignore-all-space`.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
Changes since v1.1:

	* unset OVERWRITING_FAIL in more places that I missed earlier

	* clarify that the helper functions passed to
	  test_submodule_switch_func() are the ones that have been
	  modified (I'm not 100% if I understood your complaint with
	  the text so perhaps the commit message may still need further
	  refinement)

 t/lib-submodule-update.sh   | 33 +++++++++++++++++++++++++--------
 t/t3426-rebase-submodule.sh |  4 ++--
 t/t3513-revert-submodule.sh | 20 ++++++++++++--------
 t/t3906-stash-submodule.sh  | 15 +++++++++------
 t/t4137-apply-submodule.sh  |  6 ++++--
 t/t4255-am-submodule.sh     |  6 ++++--
 t/t5572-pull-submodule.sh   |  8 ++++----
 t/t6041-bisect-submodule.sh | 33 ++++++++++++++++++---------------
 8 files changed, 78 insertions(+), 47 deletions(-)

diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index cd80d77707..67d9d8615a 100644
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
index 95a7f64471..6c899db7e1 100755
--- a/t/t3513-revert-submodule.sh
+++ b/t/t3513-revert-submodule.sh
@@ -15,14 +15,18 @@ git_revert () {
 	git status -su >expect &&
 	ls -1pR * >>expect &&
 	tar cf "$TRASH_DIRECTORY/tmp.tar" * &&
-	git checkout "$1" &&
-	git revert HEAD &&
-	rm -rf * &&
-	tar xf "$TRASH_DIRECTORY/tmp.tar" &&
-	git status -su >actual &&
-	ls -1pR * >>actual &&
-	test_cmp expect actual &&
-	git revert HEAD
+	$OVERWRITING_FAIL git checkout "$1" &&
+	if test -z "$OVERWRITING_FAIL"
+	then
+		git checkout "$1" &&
+		git revert HEAD &&
+		rm -rf * &&
+		tar xf "$TRASH_DIRECTORY/tmp.tar" &&
+		git status -su >actual &&
+		ls -1pR * >>actual &&
+		test_cmp expect actual &&
+		git revert HEAD
+	fi
 }
 
 KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR=1
diff --git a/t/t3906-stash-submodule.sh b/t/t3906-stash-submodule.sh
index 6a7e801ca0..860940072d 100755
--- a/t/t3906-stash-submodule.sh
+++ b/t/t3906-stash-submodule.sh
@@ -8,12 +8,15 @@ test_description='stash can handle submodules'
 git_stash () {
 	git status -su >expect &&
 	ls -1pR * >>expect &&
-	git read-tree -u -m "$1" &&
-	git stash &&
-	git status -su >actual &&
-	ls -1pR * >>actual &&
-	test_cmp expect actual &&
-	git stash apply
+	$OVERWRITING_FAIL git read-tree -u -m "$1" &&
+	if test -z "$OVERWRITING_FAIL"
+	then
+		git stash &&
+		git status -su >actual &&
+		ls -1pR * >>actual &&
+		test_cmp expect actual &&
+		git stash apply
+	fi
 }
 
 KNOWN_FAILURE_STASH_DOES_IGNORE_SUBMODULE_CHANGES=1
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
index 0e0cdf638d..714d393899 100755
--- a/t/t6041-bisect-submodule.sh
+++ b/t/t6041-bisect-submodule.sh
@@ -10,21 +10,24 @@ git_bisect () {
 	ls -1pR * >>expect &&
 	tar cf "$TRASH_DIRECTORY/tmp.tar" * &&
 	GOOD=$(git rev-parse --verify HEAD) &&
-	git checkout "$1" &&
-	echo "foo" >bar &&
-	git add bar &&
-	git commit -m "bisect bad" &&
-	BAD=$(git rev-parse --verify HEAD) &&
-	git reset --hard HEAD^^ &&
-	git submodule update &&
-	git bisect start &&
-	git bisect good $GOOD &&
-	rm -rf * &&
-	tar xf "$TRASH_DIRECTORY/tmp.tar" &&
-	git status -su >actual &&
-	ls -1pR * >>actual &&
-	test_cmp expect actual &&
-	git bisect bad $BAD
+	$OVERWRITING_FAIL git checkout "$1" &&
+	if test -z "$OVERWRITING_FAIL"
+	then
+		echo "foo" >bar &&
+		git add bar &&
+		git commit -m "bisect bad" &&
+		BAD=$(git rev-parse --verify HEAD) &&
+		git reset --hard HEAD^^ &&
+		git submodule update &&
+		git bisect start &&
+		git bisect good $GOOD &&
+		rm -rf * &&
+		tar xf "$TRASH_DIRECTORY/tmp.tar" &&
+		git status -su >actual &&
+		ls -1pR * >>actual &&
+		test_cmp expect actual &&
+		git bisect bad $BAD
+	fi
 }
 
 test_submodule_switch_func "git_bisect"
-- 
2.26.2.548.gbb00c8a0a9

