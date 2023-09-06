Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9022EE14A8
	for <git@archiver.kernel.org>; Wed,  6 Sep 2023 15:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242586AbjIFPXS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Sep 2023 11:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242567AbjIFPXM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2023 11:23:12 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36D31986
        for <git@vger.kernel.org>; Wed,  6 Sep 2023 08:23:00 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2bd6611873aso58474971fa.1
        for <git@vger.kernel.org>; Wed, 06 Sep 2023 08:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694013779; x=1694618579; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g2QmTux5NHmE+K2ap2mKnjYaZ6Rf9PEs8HqsiLwir48=;
        b=GRZljln3v7hsxtxXuUSUOPaTmrHEnY3Kd5IycCZYXr8g6lKjmDPHTaNgp80v+KzDp8
         QjdAjZpD3diE7vEqpfjhFzGK83rFJyHI1c5tXdJ2hqsE5wbHSKIboBvXNXFlLcVw59dy
         JWH41M8n9CoThaQV+phbd/KmfuMHxnaPx7ZPoQqgMdP1+dTSVaR8XzT1qV3Ykxp+4Z84
         XiPJ0QePqcUQk6wx058HZxZje9D4vVt0aSaireAMSpIy5ceajbPPyIv/YTrRX0HawebS
         2v0loMudn1B16b9bJG2kgQpefoZSJzk7PFlp4+NFkO7e+GYpnOTdMLe2BOVfZipztv29
         3Lxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694013779; x=1694618579;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g2QmTux5NHmE+K2ap2mKnjYaZ6Rf9PEs8HqsiLwir48=;
        b=KhoHFirBYt0a2ofGB1uCKsuilglxqGyuevsjx+yx2nJUU9YUtywcE9EKYZqR4aZMYt
         XCjHwRHAZlT7eD/TUm0xU1CeA+AaMDsmvl5is1Nj4RXEQ9jTenJ535QuWOPchcD/9jzb
         gKwlUiko3FmiIk3gAWwWfjHSOhfH7ai+GMT8Nu0T5bHuNvmUmn4pYvM1pNrNrgrTrDW0
         oB3BvJ9z6reJsAwB+oPa0xKzct+asHe+oVNBJ1yQiRH15nAr+vzQfV9/p+azBbhWnZYi
         8UyqpsPMmoDVeYruixLlGzvt2JwTXBBOE4y3qaa8YsQDoSS775vc7A14hkeGLiC+vQAR
         Faaw==
X-Gm-Message-State: AOJu0Yy7Cb0XHODsPZUolFByuZVMjDQL2RqZbuknLARjyIxHzpnmi6hT
        aY6dg1QcrbGwtwPwDajPuWM9WyvsOlM=
X-Google-Smtp-Source: AGHT+IGx0KkkNCcqzzzosM5Ojven2mQY3S+zIomhjDbkbK3GkELUy3PPxAYhzVAeNbjseeGLUBo1Kw==
X-Received: by 2002:a2e:86c5:0:b0:2bc:eea7:834e with SMTP id n5-20020a2e86c5000000b002bceea7834emr2472008ljj.40.1694013778601;
        Wed, 06 Sep 2023 08:22:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t12-20020a7bc3cc000000b003fef19bb55csm20032932wmj.34.2023.09.06.08.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 08:22:58 -0700 (PDT)
Message-ID: <f6f330f706310f7b1f0232b228455f635196acdb.1694013772.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1492.v4.git.1694013771.gitgitgadget@gmail.com>
References: <pull.1492.v3.git.1690903412.gitgitgadget@gmail.com>
        <pull.1492.v4.git.1694013771.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 06 Sep 2023 15:22:49 +0000
Subject: [PATCH v4 5/7] rebase: fix rewritten list for failed pick
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Haller <lists@haller-berlin.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Glen Choo <chooglen@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

git rebase keeps a list that maps the OID of each commit before it was
rebased to the OID of the equivalent commit after the rebase.  This list
is used to drive the "post-rewrite" hook that is called at the end of a
successful rebase. When a rebase stops for the user to resolve merge
conflicts the OID of the commit being picked is written to
".git/rebase-merge/stopped-sha". Then when the rebase is continued that
OID is added to the list of rewritten commits. Unfortunately if a commit
cannot be picked because it would overwrite an untracked file we still
write the "stopped-sha1" file. This means that when the rebase is
continued the commit is added into the list of rewritten commits even
though it has not been picked yet.

Fix this by not calling error_with_patch() for failed commands. The pick
has failed so there is nothing to commit and therefore we do not want to
set up the state files for committing staged changes when the rebase
continues. This change means we no-longer write a patch for the failed
command or display the error message printed by error_with_patch(). As
the command has failed the patch isn't really useful and in any case the
user can inspect the commit associated with the failed command by
inspecting REBASE_HEAD. Unless the user has disabled it we already print
an advice message that is more helpful than the message from
error_with_patch() which the user will still see. Even if the advice is
disabled the user will see the messages from the merge machinery
detailing the problem.

The code to add a failed command back into the todo list is duplicated
between pick_one_commit() and the loop in pick_commits(). Both sites
print advice about the command being rescheduled, decrement the current
item and save the todo list. To avoid duplicating this code
pick_one_commit() is modified to set a flag to indicate that the command
should be rescheduled in the main loop. This simplifies things as only
the remaining copy of the code needs to be modified to set REBASE_HEAD
rather than calling error_with_patch().

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c                   | 19 +++++---------
 t/t3404-rebase-interactive.sh |  6 +++++
 t/t3430-rebase-merges.sh      |  4 +--
 t/t5407-post-rewrite-hook.sh  | 48 +++++++++++++++++++++++++++++++++++
 4 files changed, 63 insertions(+), 14 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index b434c5a2570..76932ab7b23 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4158,6 +4158,7 @@ static int do_merge(struct repository *r,
 	if (ret < 0) {
 		error(_("could not even attempt to merge '%.*s'"),
 		      merge_arg_len, arg);
+		unlink(git_path_merge_msg(r));
 		goto leave_merge;
 	}
 	/*
@@ -4648,7 +4649,7 @@ N_("Could not execute the todo command\n"
 static int pick_one_commit(struct repository *r,
 			   struct todo_list *todo_list,
 			   struct replay_opts *opts,
-			   int *check_todo)
+			   int *check_todo, int* reschedule)
 {
 	int res;
 	struct todo_item *item = todo_list->items + todo_list->current;
@@ -4661,12 +4662,8 @@ static int pick_one_commit(struct repository *r,
 			     check_todo);
 	if (is_rebase_i(opts) && res < 0) {
 		/* Reschedule */
-		advise(_(rescheduled_advice),
-		       get_item_line_length(todo_list, todo_list->current),
-		       get_item_line(todo_list, todo_list->current));
-		todo_list->current--;
-		if (save_todo(todo_list, opts))
-			return -1;
+		*reschedule = 1;
+		return -1;
 	}
 	if (item->command == TODO_EDIT) {
 		struct commit *commit = item->commit;
@@ -4766,7 +4763,8 @@ static int pick_commits(struct repository *r,
 			}
 		}
 		if (item->command <= TODO_SQUASH) {
-			res = pick_one_commit(r, todo_list, opts, &check_todo);
+			res = pick_one_commit(r, todo_list, opts, &check_todo,
+					      &reschedule);
 			if (!res && item->command == TODO_EDIT)
 				return 0;
 		} else if (item->command == TODO_EXEC) {
@@ -4820,10 +4818,7 @@ static int pick_commits(struct repository *r,
 			if (save_todo(todo_list, opts))
 				return -1;
 			if (item->commit)
-				return error_with_patch(r,
-							item->commit,
-							arg, item->arg_len,
-							opts, res, 0);
+				write_rebase_head(&item->commit->object.oid);
 		} else if (is_rebase_i(opts) && check_todo && !res &&
 			   reread_todo_if_changed(r, todo_list, opts)) {
 			return -1;
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index ff0afad63e2..6d3788c588b 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1287,7 +1287,9 @@ test_expect_success 'rebase -i commits that overwrite untracked files (pick)' '
 	>file6 &&
 	test_must_fail git rebase --continue &&
 	test_cmp_rev HEAD F &&
+	test_cmp_rev REBASE_HEAD I &&
 	rm file6 &&
+	test_path_is_missing .git/rebase-merge/patch &&
 	git rebase --continue &&
 	test_cmp_rev HEAD I
 '
@@ -1305,7 +1307,9 @@ test_expect_success 'rebase -i commits that overwrite untracked files (squash)'
 	>file6 &&
 	test_must_fail git rebase --continue &&
 	test_cmp_rev HEAD F &&
+	test_cmp_rev REBASE_HEAD I &&
 	rm file6 &&
+	test_path_is_missing .git/rebase-merge/patch &&
 	git rebase --continue &&
 	test $(git cat-file commit HEAD | sed -ne \$p) = I &&
 	git reset --hard original-branch2
@@ -1323,7 +1327,9 @@ test_expect_success 'rebase -i commits that overwrite untracked files (no ff)' '
 	>file6 &&
 	test_must_fail git rebase --continue &&
 	test $(git cat-file commit HEAD | sed -ne \$p) = F &&
+	test_cmp_rev REBASE_HEAD I &&
 	rm file6 &&
+	test_path_is_missing .git/rebase-merge/patch &&
 	git rebase --continue &&
 	test $(git cat-file commit HEAD | sed -ne \$p) = I
 '
diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index 96ae0edf1e1..4938ebb1c17 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -165,12 +165,12 @@ test_expect_success 'failed `merge -C` writes patch (may be rescheduled, too)' '
 	test_config sequence.editor \""$PWD"/replace-editor.sh\" &&
 	test_tick &&
 	test_must_fail git rebase -ir HEAD &&
+	test_cmp_rev REBASE_HEAD H^0 &&
 	grep "^merge -C .* G$" .git/rebase-merge/done &&
 	grep "^merge -C .* G$" .git/rebase-merge/git-rebase-todo &&
-	test_path_is_file .git/rebase-merge/patch &&
+	test_path_is_missing .git/rebase-merge/patch &&
 
 	: fail because of merge conflict &&
-	rm G.t .git/rebase-merge/patch &&
 	git reset --hard conflicting-G &&
 	test_must_fail git rebase --continue &&
 	! grep "^merge -C .* G$" .git/rebase-merge/git-rebase-todo &&
diff --git a/t/t5407-post-rewrite-hook.sh b/t/t5407-post-rewrite-hook.sh
index 5f3ff051ca2..ad7f8c6f002 100755
--- a/t/t5407-post-rewrite-hook.sh
+++ b/t/t5407-post-rewrite-hook.sh
@@ -17,6 +17,12 @@ test_expect_success 'setup' '
 	git checkout A^0 &&
 	test_commit E bar E &&
 	test_commit F foo F &&
+	git checkout B &&
+	git merge E &&
+	git tag merge-E &&
+	test_commit G G &&
+	test_commit H H &&
+	test_commit I I &&
 	git checkout main &&
 
 	test_hook --setup post-rewrite <<-EOF
@@ -173,6 +179,48 @@ test_fail_interactive_rebase () {
 	)
 }
 
+test_expect_success 'git rebase with failed pick' '
+	clear_hook_input &&
+	cat >todo <<-\EOF &&
+	exec >bar
+	merge -C merge-E E
+	exec >G
+	pick G
+	exec >H 2>I
+	pick H
+	fixup I
+	EOF
+
+	(
+		set_replace_editor todo &&
+		test_must_fail git rebase -i D D 2>err
+	) &&
+	grep "would be overwritten" err &&
+	rm bar &&
+
+	test_must_fail git rebase --continue 2>err &&
+	grep "would be overwritten" err &&
+	rm G &&
+
+	test_must_fail git rebase --continue 2>err &&
+	grep "would be overwritten" err &&
+	rm H &&
+
+	test_must_fail git rebase --continue 2>err &&
+	grep "would be overwritten" err &&
+	rm I &&
+
+	git rebase --continue &&
+	echo rebase >expected.args &&
+	cat >expected.data <<-EOF &&
+	$(git rev-parse merge-E) $(git rev-parse HEAD~2)
+	$(git rev-parse G) $(git rev-parse HEAD~1)
+	$(git rev-parse H) $(git rev-parse HEAD)
+	$(git rev-parse I) $(git rev-parse HEAD)
+	EOF
+	verify_hook_input
+'
+
 test_expect_success 'git rebase -i (unchanged)' '
 	git reset --hard D &&
 	clear_hook_input &&
-- 
gitgitgadget

