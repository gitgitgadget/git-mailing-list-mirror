Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC66C83003
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 12:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58F0321D7E
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 12:22:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzN49Fct"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgD2MW4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 08:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726884AbgD2MWz (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Apr 2020 08:22:55 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E011C03C1AE
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 05:22:55 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id c63so1690408qke.2
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 05:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=76PB75nIBhBE2MbIhStiM2OhnO0J07/ADaU+U7aZSbI=;
        b=DzN49FctTNRMzWsq3GzUlsQpi8gApuXGhoXG6jB7xWRfdqf/0NylDzB5ghkBkaE2Ms
         l3O2rFuxmiDG8e4XIBDp6il8dvaWwZZSWVI6imQtQVrwH2WPrpTFEybDqkx0qX0YxmdH
         I31CcxqzXRHevYWiWdDAWTL+hW89S+CjA6v1BDnJj8F90Tfb/3ZPEV7ikUgwsptGbrTg
         lF7ywr9fkqvQLfqO5pn5muzxMgU7ER4qnKbkJqaloVEio2EL+4O/UB67Yd1xSt52kCO6
         njGI6O13VoxB4x9MlRFhocydzvf47XphS1PXQ79f4/30w8jViHKUlAVbrFXJtdwUwQqj
         XN6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=76PB75nIBhBE2MbIhStiM2OhnO0J07/ADaU+U7aZSbI=;
        b=AE0Dc8NkkBz7QHH48E4qjuQoqbrjfFGcxWEgFZ6Ye+PhllQArrq5zTOZLIKN6OVvQX
         0MbQYYKQhSjw86P0vQhgncmat9epcQRQvHjRlsrwEhectXt/sob6woDxMCXuTB9sGrJV
         wDtZOEhJGdGgowhN8DQRdLu9gKvk5tQTt8A4Na/EfptvziMOnYN956AtUX//wHSYShaW
         meBMqD+fYwvS5cUjb6PF/IH9yKvhsOm/f/C4JVx8qzYx76W5nzBpuKc/I/6U2wz3TbHS
         z/hw+tJfvDOOSfMMvlaKLXV7rC82IxdAo6afa14MWpVYpsvmKl3z7Dop8gZCBEbk7Yy1
         I7Rw==
X-Gm-Message-State: AGi0PuZbF6Ws/bWIATdYNrzcBlGr8lsEVTwcJo+r5QOVJRUFlQ1jW7KY
        efcaWm9HdMBTvsP0bRR9PqrJ/uME
X-Google-Smtp-Source: APiQypLVerWD6Q7B7I3jpauCSvxzGMVPOyUXGGv9tBx0nTCVlEGvdz49FIl1bo73dqzNDrJ89O406Q==
X-Received: by 2002:a05:620a:487:: with SMTP id 7mr20016049qkr.438.1588162973890;
        Wed, 29 Apr 2020 05:22:53 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id t27sm15389383qkg.4.2020.04.29.05.22.52
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 05:22:53 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 3/4] lib-submodule-update: prepend "git" to $command
Date:   Wed, 29 Apr 2020 08:22:25 -0400
Message-Id: <86eb9c5a8ad8dc0836f3a612a45a86bbd8cece24.1588162842.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.2.548.gbb00c8a0a9
In-Reply-To: <cover.1588162842.git.liu.denton@gmail.com>
References: <cover.1588162842.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since all invocations of test_submodule_forced_switch() are git
commands, automatically prepend "git" before invoking
test_submodule_switch_common().

Similarly, many invocations of test_submodule_switch() are also git
commands so automatically prepend "git" before invoking
test_submodule_switch_common() as well.

Finally, for invocations of test_submodule_switch() that invoke a custom
function, rename the old function to test_submodule_switch_func().

This is necessary because in a future commit, we will be adding some
logic that needs to distinguish between an invocation of a plain git
comamnd and an invocation of a test helper function.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/lib-submodule-update.sh        | 14 +++++++++-----
 t/t1013-read-tree-submodule.sh   |  4 ++--
 t/t2013-checkout-submodule.sh    |  4 ++--
 t/t3426-rebase-submodule.sh      |  4 ++--
 t/t3512-cherry-pick-submodule.sh |  2 +-
 t/t3513-revert-submodule.sh      |  2 +-
 t/t3906-stash-submodule.sh       |  2 +-
 t/t4137-apply-submodule.sh       |  4 ++--
 t/t4255-am-submodule.sh          |  4 ++--
 t/t5572-pull-submodule.sh        |  8 ++++----
 t/t6041-bisect-submodule.sh      |  2 +-
 t/t7112-reset-submodule.sh       |  6 +++---
 t/t7613-merge-submodule.sh       |  8 ++++----
 13 files changed, 34 insertions(+), 30 deletions(-)

diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index 81457b4c31..cd80d77707 100644
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -307,8 +307,8 @@ test_submodule_content () {
 # to protect the history!
 #
 
-# Internal function; use test_submodule_switch() or
-# test_submodule_forced_switch() instead.
+# Internal function; use test_submodule_switch_func(), test_submodule_switch_func(),
+# or test_submodule_forced_switch() instead.
 test_submodule_switch_common () {
 	command="$1"
 	######################### Appearing submodule #########################
@@ -566,8 +566,8 @@ test_submodule_switch_common () {
 #   # Do something here that updates the worktree and index to match target,
 #   # but not any submodule directories.
 # }
-# test_submodule_switch "my_func"
-test_submodule_switch () {
+# test_submodule_switch_func "my_func"
+test_submodule_switch_func () {
 	command="$1"
 	test_submodule_switch_common "$command"
 
@@ -587,12 +587,16 @@ test_submodule_switch () {
 	'
 }
 
+test_submodule_switch () {
+	test_submodule_switch_func "git $1"
+}
+
 # Same as test_submodule_switch(), except that throwing away local changes in
 # the superproject is allowed.
 test_submodule_forced_switch () {
 	command="$1"
 	KNOWN_FAILURE_FORCED_SWITCH_TESTS=1
-	test_submodule_switch_common "$command"
+	test_submodule_switch_common "git $command"
 
 	# When forced, a file in the superproject does not prevent creating a
 	# submodule of the same name.
diff --git a/t/t1013-read-tree-submodule.sh b/t/t1013-read-tree-submodule.sh
index 91a6fafcb4..b6df7444c0 100755
--- a/t/t1013-read-tree-submodule.sh
+++ b/t/t1013-read-tree-submodule.sh
@@ -12,8 +12,8 @@ test_submodule_switch_recursing_with_args "read-tree -u -m"
 
 test_submodule_forced_switch_recursing_with_args "read-tree -u --reset"
 
-test_submodule_switch "git read-tree -u -m"
+test_submodule_switch "read-tree -u -m"
 
-test_submodule_forced_switch "git read-tree -u --reset"
+test_submodule_forced_switch "read-tree -u --reset"
 
 test_done
diff --git a/t/t2013-checkout-submodule.sh b/t/t2013-checkout-submodule.sh
index 8f86b5f4b2..b2bdd1fcb4 100755
--- a/t/t2013-checkout-submodule.sh
+++ b/t/t2013-checkout-submodule.sh
@@ -68,8 +68,8 @@ test_submodule_switch_recursing_with_args "checkout"
 
 test_submodule_forced_switch_recursing_with_args "checkout -f"
 
-test_submodule_switch "git checkout"
+test_submodule_switch "checkout"
 
-test_submodule_forced_switch "git checkout -f"
+test_submodule_forced_switch "checkout -f"
 
 test_done
diff --git a/t/t3426-rebase-submodule.sh b/t/t3426-rebase-submodule.sh
index a2bba04ba9..788605ccc0 100755
--- a/t/t3426-rebase-submodule.sh
+++ b/t/t3426-rebase-submodule.sh
@@ -20,7 +20,7 @@ git_rebase () {
 	git rebase "$1"
 }
 
-test_submodule_switch "git_rebase"
+test_submodule_switch_func "git_rebase"
 
 git_rebase_interactive () {
 	git status -su >expect &&
@@ -38,7 +38,7 @@ git_rebase_interactive () {
 	git rebase -i "$1"
 }
 
-test_submodule_switch "git_rebase_interactive"
+test_submodule_switch_func "git_rebase_interactive"
 
 test_expect_success 'rebase interactive ignores modified submodules' '
 	test_when_finished "rm -rf super sub" &&
diff --git a/t/t3512-cherry-pick-submodule.sh b/t/t3512-cherry-pick-submodule.sh
index bd78287841..6ece1d8573 100755
--- a/t/t3512-cherry-pick-submodule.sh
+++ b/t/t3512-cherry-pick-submodule.sh
@@ -7,7 +7,7 @@ test_description='cherry-pick can handle submodules'
 
 KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR=1
 KNOWN_FAILURE_NOFF_MERGE_ATTEMPTS_TO_MERGE_REMOVED_SUBMODULE_FILES=1
-test_submodule_switch "git cherry-pick"
+test_submodule_switch "cherry-pick"
 
 test_expect_success 'unrelated submodule/file conflict is ignored' '
 	test_create_repo sub &&
diff --git a/t/t3513-revert-submodule.sh b/t/t3513-revert-submodule.sh
index 5e39fcdb66..95a7f64471 100755
--- a/t/t3513-revert-submodule.sh
+++ b/t/t3513-revert-submodule.sh
@@ -26,6 +26,6 @@ git_revert () {
 }
 
 KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR=1
-test_submodule_switch "git_revert"
+test_submodule_switch_func "git_revert"
 
 test_done
diff --git a/t/t3906-stash-submodule.sh b/t/t3906-stash-submodule.sh
index b93d1d74da..6a7e801ca0 100755
--- a/t/t3906-stash-submodule.sh
+++ b/t/t3906-stash-submodule.sh
@@ -19,7 +19,7 @@ git_stash () {
 KNOWN_FAILURE_STASH_DOES_IGNORE_SUBMODULE_CHANGES=1
 KNOWN_FAILURE_CHERRY_PICK_SEES_EMPTY_COMMIT=1
 KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR=1
-test_submodule_switch "git_stash"
+test_submodule_switch_func "git_stash"
 
 setup_basic () {
 	test_when_finished "rm -rf main sub" &&
diff --git a/t/t4137-apply-submodule.sh b/t/t4137-apply-submodule.sh
index a9bd40a6d0..b645e303a0 100755
--- a/t/t4137-apply-submodule.sh
+++ b/t/t4137-apply-submodule.sh
@@ -9,12 +9,12 @@ apply_index () {
 	git diff --ignore-submodules=dirty "..$1" | git apply --index -
 }
 
-test_submodule_switch "apply_index"
+test_submodule_switch_func "apply_index"
 
 apply_3way () {
 	git diff --ignore-submodules=dirty "..$1" | git apply --3way -
 }
 
-test_submodule_switch "apply_3way"
+test_submodule_switch_func "apply_3way"
 
 test_done
diff --git a/t/t4255-am-submodule.sh b/t/t4255-am-submodule.sh
index 0ba8194403..1b179d5f45 100755
--- a/t/t4255-am-submodule.sh
+++ b/t/t4255-am-submodule.sh
@@ -9,14 +9,14 @@ am () {
 	git format-patch --stdout --ignore-submodules=dirty "..$1" | git am -
 }
 
-test_submodule_switch "am"
+test_submodule_switch_func "am"
 
 am_3way () {
 	git format-patch --stdout --ignore-submodules=dirty "..$1" | git am --3way -
 }
 
 KNOWN_FAILURE_NOFF_MERGE_ATTEMPTS_TO_MERGE_REMOVED_SUBMODULE_FILES=1
-test_submodule_switch "am_3way"
+test_submodule_switch_func "am_3way"
 
 test_expect_success 'setup diff.submodule' '
 	test_commit one &&
diff --git a/t/t5572-pull-submodule.sh b/t/t5572-pull-submodule.sh
index f916729a12..f911bf631e 100755
--- a/t/t5572-pull-submodule.sh
+++ b/t/t5572-pull-submodule.sh
@@ -17,21 +17,21 @@ git_pull () {
 }
 
 # pulls without conflicts
-test_submodule_switch "git_pull"
+test_submodule_switch_func "git_pull"
 
 git_pull_ff () {
 	reset_branch_to_HEAD "$1" &&
 	git pull --ff
 }
 
-test_submodule_switch "git_pull_ff"
+test_submodule_switch_func "git_pull_ff"
 
 git_pull_ff_only () {
 	reset_branch_to_HEAD "$1" &&
 	git pull --ff-only
 }
 
-test_submodule_switch "git_pull_ff_only"
+test_submodule_switch_func "git_pull_ff_only"
 
 git_pull_noff () {
 	reset_branch_to_HEAD "$1" &&
@@ -40,7 +40,7 @@ git_pull_noff () {
 
 KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR=1
 KNOWN_FAILURE_NOFF_MERGE_ATTEMPTS_TO_MERGE_REMOVED_SUBMODULE_FILES=1
-test_submodule_switch "git_pull_noff"
+test_submodule_switch_func "git_pull_noff"
 
 test_expect_success 'pull --recurse-submodule setup' '
 	test_create_repo child &&
diff --git a/t/t6041-bisect-submodule.sh b/t/t6041-bisect-submodule.sh
index 62b8a2e7bb..0e0cdf638d 100755
--- a/t/t6041-bisect-submodule.sh
+++ b/t/t6041-bisect-submodule.sh
@@ -27,6 +27,6 @@ git_bisect () {
 	git bisect bad $BAD
 }
 
-test_submodule_switch "git_bisect"
+test_submodule_switch_func "git_bisect"
 
 test_done
diff --git a/t/t7112-reset-submodule.sh b/t/t7112-reset-submodule.sh
index 67346424a5..19830d9036 100755
--- a/t/t7112-reset-submodule.sh
+++ b/t/t7112-reset-submodule.sh
@@ -12,10 +12,10 @@ test_submodule_switch_recursing_with_args "reset --keep"
 
 test_submodule_forced_switch_recursing_with_args "reset --hard"
 
-test_submodule_switch "git reset --keep"
+test_submodule_switch "reset --keep"
 
-test_submodule_switch "git reset --merge"
+test_submodule_switch "reset --merge"
 
-test_submodule_forced_switch "git reset --hard"
+test_submodule_forced_switch "reset --hard"
 
 test_done
diff --git a/t/t7613-merge-submodule.sh b/t/t7613-merge-submodule.sh
index d1e9fcc781..04bf4be7d7 100755
--- a/t/t7613-merge-submodule.sh
+++ b/t/t7613-merge-submodule.sh
@@ -6,14 +6,14 @@ test_description='merge can handle submodules'
 . "$TEST_DIRECTORY"/lib-submodule-update.sh
 
 # merges without conflicts
-test_submodule_switch "git merge"
+test_submodule_switch "merge"
 
-test_submodule_switch "git merge --ff"
+test_submodule_switch "merge --ff"
 
-test_submodule_switch "git merge --ff-only"
+test_submodule_switch "merge --ff-only"
 
 KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR=1
 KNOWN_FAILURE_NOFF_MERGE_ATTEMPTS_TO_MERGE_REMOVED_SUBMODULE_FILES=1
-test_submodule_switch "git merge --no-ff"
+test_submodule_switch "merge --no-ff"
 
 test_done
-- 
2.26.2.548.gbb00c8a0a9

