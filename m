Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA3EC0015E
	for <git@archiver.kernel.org>; Tue,  1 Aug 2023 15:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233213AbjHAPX4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Aug 2023 11:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233401AbjHAPXs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2023 11:23:48 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2AA213C
        for <git@vger.kernel.org>; Tue,  1 Aug 2023 08:23:40 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3178dd81ac4so4292235f8f.3
        for <git@vger.kernel.org>; Tue, 01 Aug 2023 08:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690903418; x=1691508218;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hhxNv+c61rXTFp0ucaqogvcouSv8PQNOyHLWceyno3Q=;
        b=PCoANMHulI1AirkSDkcyzjOUfvPX8zJyOgfx16BtshQhB/Pv41Mf0jcpKCP9MX3aHz
         9EU+3ETVEffnRDnU3wjzinkSK10f+J1XZIjCq9OlhgZxWC19/5DBqOIxvcsuCUsiXBFL
         2BUwk2FZRX7IrMGvJgL2QJDdq0fEI1iQMebZfWNMQrcY/rkMYiDLbokzk0/xCG3NPASy
         grvClSwoHNTbtLVZCInwWFpwH8RTQYCUmMjROPOvw/LOxaad0lrt92/5d/ZQ6RBuf8xq
         DbnFU+0qgkh8gnTkYLWHI+ckhj0z2yc7wngX8+XSTLL1J9fFmergzH7lu6D/1zeI9nWM
         dZcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690903418; x=1691508218;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hhxNv+c61rXTFp0ucaqogvcouSv8PQNOyHLWceyno3Q=;
        b=bv/9SVmjmtb1pVAdZKXnYUnxCJhpKEY3U6jOwZCoj9hIDfVXZaNYWsU3RyOnXkoOsm
         jcilXoRvIqgnSjisTO1TBW45eRajpU2IOjm34LwKhtbyP/dSSh3kWzReY+I7UcfVVBJ+
         h5GQXZIxArSnlKmGlW2JjgdAqMauUOfkFfuWLCCBkIpCX+QdP07HSGHe8oWOJyt7TRef
         zSgL6RBW3AdosLE5St3nLMDpx8gQ6ZTCA51LXLH/Woqfui10ydEJ4UiDIf1+A0LUdO1X
         fBkNfjhctlQrN2RMIRJEDzURtWX8O+83xXHVnb1e2hgxpZtn45MOzUmbdWW/Od+eAhxh
         V04Q==
X-Gm-Message-State: ABy/qLZVX7dy/7la1KffbiGjPO8p93NGBrX+GIH42gogSKFvswHMM0nv
        fHuJFtqNtyytS6tkvyZMnMdps5sR6Qs=
X-Google-Smtp-Source: APBJJlFGW03vJmJU6RdmXJjY+NBKJ8WRw0tW76qwFyY37aTNxBc/ArBVN3+i/7lWdR+mUNhfXqHkLg==
X-Received: by 2002:a5d:6905:0:b0:315:9fb7:bd9 with SMTP id t5-20020a5d6905000000b003159fb70bd9mr2600340wru.69.1690903418496;
        Tue, 01 Aug 2023 08:23:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l13-20020a5d560d000000b00313f9a0c521sm16264200wrv.107.2023.08.01.08.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 08:23:38 -0700 (PDT)
Message-ID: <df4019458665eccf2b16cdf1d6c1061186a62711.1690903412.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1492.v3.git.1690903412.gitgitgadget@gmail.com>
References: <pull.1492.v2.git.1682089074.gitgitgadget@gmail.com>
        <pull.1492.v3.git.1690903412.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Aug 2023 15:23:30 +0000
Subject: [PATCH v3 5/7] rebase: fix rewritten list for failed pick
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

To simplify writing REBASE_HEAD in this case pick_one_commit() is
modified to avoid duplicating the code that adds the failed command
back into the todo list.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c                   | 19 +++++---------
 t/t3404-rebase-interactive.sh |  6 +++++
 t/t3430-rebase-merges.sh      |  4 +--
 t/t5407-post-rewrite-hook.sh  | 48 +++++++++++++++++++++++++++++++++++
 4 files changed, 63 insertions(+), 14 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 62277e7bcc1..e25abfd2fb4 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4155,6 +4155,7 @@ static int do_merge(struct repository *r,
 	if (ret < 0) {
 		error(_("could not even attempt to merge '%.*s'"),
 		      merge_arg_len, arg);
+		unlink(git_path_merge_msg(r));
 		goto leave_merge;
 	}
 	/*
@@ -4645,7 +4646,7 @@ N_("Could not execute the todo command\n"
 static int pick_one_commit(struct repository *r,
 			   struct todo_list *todo_list,
 			   struct replay_opts *opts,
-			   int *check_todo)
+			   int *check_todo, int* reschedule)
 {
 	int res;
 	struct todo_item *item = todo_list->items + todo_list->current;
@@ -4658,12 +4659,8 @@ static int pick_one_commit(struct repository *r,
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
@@ -4763,7 +4760,8 @@ static int pick_commits(struct repository *r,
 			}
 		}
 		if (item->command <= TODO_SQUASH) {
-			res = pick_one_commit(r, todo_list, opts, &check_todo);
+			res = pick_one_commit(r, todo_list, opts, &check_todo,
+					      &reschedule);
 			if (!res && item->command == TODO_EDIT)
 				return 0;
 		} else if (item->command == TODO_EXEC) {
@@ -4817,10 +4815,7 @@ static int pick_commits(struct repository *r,
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

