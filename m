Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A109CC77B71
	for <git@archiver.kernel.org>; Fri, 21 Apr 2023 14:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232698AbjDUO6U (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Apr 2023 10:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233093AbjDUO6J (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2023 10:58:09 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2884413FAE
        for <git@vger.kernel.org>; Fri, 21 Apr 2023 07:58:02 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f192c23fffso5089505e9.3
        for <git@vger.kernel.org>; Fri, 21 Apr 2023 07:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682089080; x=1684681080;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X6ZTi5DbeqtQ0CXMRhXm8T2Is7n6iq4nnCg5hmP9vXI=;
        b=PbwurQHiB4O1cp1PSCn9VPm02sm3XOddBUSrPTJwyglh2AQGiYhBcAUsxaEiTESqBU
         wnfPjHy2XlyQJ5ZypwxslZUtjFS16L3cTt0eHLlQfOA2lHWLn2gIcDPbhTZmc30V2wJn
         VKhQTmrVqSHnXns6/LUAxIJAvXCyhkGS+bVNaAJnBzHs0SDQYrbTqvqbVq+5ZrPIoM73
         Um8gC2ZVKb4Kf4VDsZiZrMEMT2yFFmR9k6MG4AwuEugLmx6v+d+hIeAmPOXZFM/9a/uo
         ywFuhRlFiow0IkLAHdUyOShWcfdRVE9cHzjLWF9c8r+XV/Fa49qyIS2RVN3yTn/4ME1Z
         681g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682089080; x=1684681080;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X6ZTi5DbeqtQ0CXMRhXm8T2Is7n6iq4nnCg5hmP9vXI=;
        b=knnN1JaW5pQh6oGAbP7xO9X7EXd3uA28F7kHlDA6wLAveYjrhmBgrSVB1rOo1f3mQg
         Vi6eYj8e0fN9l272joNbqt5/OneV3Tq/gRy7AldnUyMqdF96zeHjF0KK2OVVB3I97CAl
         rQgE31FqTR0NbUeRQBDjSWwlkjUelz/driVJNS7kNgYAPv/E1AtKZQOFveGkwwPwleiu
         IC5qbRdZM2n2Dpxv/xxVtocb+AEDiwD30yPm9uYl1lNGvT9ckgM9yTRVFt5P3pmq/f79
         HLPpt+fiMKh4lksl/ZzOEO7tFZUtVWlk7ikAItUJwRPuXC9KsRjZCqGB2CtM5zITijbJ
         yzwg==
X-Gm-Message-State: AAQBX9diIJN7HDBPEfsL/PSif2Hy9dAcZYR3VqjUHuVcUexFTvhRA+V6
        uopaXv6pPLSO18SE5ridS0LC/zYrLhY=
X-Google-Smtp-Source: AKy350YMW6IIX+ahmj9FM3v/b31gujc17VuC0Gdj0DNJSp2hHnygoXzs4FvoAbet/V8hTsDw8pFpwA==
X-Received: by 2002:a7b:c3d8:0:b0:3f1:7972:429d with SMTP id t24-20020a7bc3d8000000b003f17972429dmr2189650wmj.18.1682089080339;
        Fri, 21 Apr 2023 07:58:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o10-20020a05600c510a00b003ee443bf0c7sm8482007wms.16.2023.04.21.07.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 07:57:59 -0700 (PDT)
Message-Id: <f8e64c1b631116367e6e68fcfde711b507a03a94.1682089075.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1492.v2.git.1682089074.gitgitgadget@gmail.com>
References: <pull.1492.git.1679237337683.gitgitgadget@gmail.com>
        <pull.1492.v2.git.1682089074.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Apr 2023 14:57:53 +0000
Subject: [PATCH v2 5/6] rebase: fix rewritten list for failed pick
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Haller <lists@haller-berlin.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

When rebasing commands are moved from the todo list in "git-rebase-todo"
to the "done" file just before they are executed. This means that if a
command fails because it would overwrite an untracked file it has to be
added back into the todo list before the rebase stops for the user to
fix the problem. Unfortunately the way this is done results in the
failed pick being recorded as rewritten.

Fix this by not calling error_with_patch() for failed commands. The pick
has failed so there is nothing to commit and therefore we do not want to
set up the message file for committing staged changes when the rebase
continues. This change means we no-longer write a patch for the failed
command or display the error message printed by error_with_patch(). As
the command has failed the patch isn't really useful in that case and
REBASE_HEAD is still written so the user can inspect the commit
associated with the failed command. Unless the user has disabled it we
print an advice message that is more helpful than the message from
error_with_patch(). If the advice is disabled the user will still see
the messages from the merge machinery detailing the problem.

To simplify writing REBASE_HEAD in this case pick_one_commit() is
modified to avoid duplicating the code that adds the failed command back
into the todo list.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c                   | 19 +++++++------------
 t/t3404-rebase-interactive.sh | 12 ++++++++++++
 t/t3430-rebase-merges.sh      | 11 ++++++++---
 t/t5407-post-rewrite-hook.sh  | 11 +++++++++++
 4 files changed, 38 insertions(+), 15 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 55bf0a72c3a..db2daecb23e 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4141,6 +4141,7 @@ static int do_merge(struct repository *r,
 		error(_("could not even attempt to merge '%.*s'"),
 		      merge_arg_len, arg);
 		unlink(rebase_path_author_script());
+		unlink(git_path_merge_msg(r));
 		goto leave_merge;
 	}
 	/*
@@ -4631,7 +4632,7 @@ N_("Could not execute the todo command\n"
 static int pick_one_commit(struct repository *r,
 			   struct todo_list *todo_list,
 			   struct replay_opts *opts,
-			   int *check_todo)
+			   int *check_todo, int* reschedule)
 {
 	int res;
 	struct todo_item *item = todo_list->items + todo_list->current;
@@ -4644,12 +4645,8 @@ static int pick_one_commit(struct repository *r,
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
@@ -4749,7 +4746,8 @@ static int pick_commits(struct repository *r,
 			}
 		}
 		if (item->command <= TODO_SQUASH) {
-			res = pick_one_commit(r, todo_list, opts, &check_todo);
+			res = pick_one_commit(r, todo_list, opts, &check_todo,
+					      &reschedule);
 			if (!res && item->command == TODO_EDIT)
 				return 0;
 		} else if (item->command == TODO_EXEC) {
@@ -4803,10 +4801,7 @@ static int pick_commits(struct repository *r,
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
index c1fe55dc2c1..a657167befd 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1289,6 +1289,10 @@ test_expect_success 'rebase -i commits that overwrite untracked files (pick)' '
 	test_cmp_rev HEAD F &&
 	rm file6 &&
 	test_path_is_missing .git/rebase-merge/author-script &&
+	test_path_is_missing .git/rebase-merge/patch &&
+	test_path_is_missing .git/MERGE_MSG &&
+	test_path_is_missing .git/rebase-merge/message &&
+	test_path_is_missing .git/rebase-merge/stopped-sha &&
 	echo changed >file1 &&
 	git add file1 &&
 	test_must_fail git rebase --continue 2>err &&
@@ -1313,6 +1317,10 @@ test_expect_success 'rebase -i commits that overwrite untracked files (squash)'
 	test_cmp_rev HEAD F &&
 	rm file6 &&
 	test_path_is_missing .git/rebase-merge/author-script &&
+	test_path_is_missing .git/rebase-merge/patch &&
+	test_path_is_missing .git/MERGE_MSG &&
+	test_path_is_missing .git/rebase-merge/message &&
+	test_path_is_missing .git/rebase-merge/stopped-sha &&
 	git rebase --continue &&
 	test $(git cat-file commit HEAD | sed -ne \$p) = I &&
 	git reset --hard original-branch2
@@ -1332,6 +1340,10 @@ test_expect_success 'rebase -i commits that overwrite untracked files (no ff)' '
 	test $(git cat-file commit HEAD | sed -ne \$p) = F &&
 	rm file6 &&
 	test_path_is_missing .git/rebase-merge/author-script &&
+	test_path_is_missing .git/rebase-merge/patch &&
+	test_path_is_missing .git/MERGE_MSG &&
+	test_path_is_missing .git/rebase-merge/message &&
+	test_path_is_missing .git/rebase-merge/stopped-sha &&
 	git rebase --continue &&
 	test $(git cat-file commit HEAD | sed -ne \$p) = I
 '
diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index 360ec787ffd..18a0bc8fafb 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -167,16 +167,21 @@ test_expect_success 'failed `merge -C` writes patch (may be rescheduled, too)' '
 	test_must_fail git rebase -ir HEAD &&
 	grep "^merge -C .* G$" .git/rebase-merge/done &&
 	grep "^merge -C .* G$" .git/rebase-merge/git-rebase-todo &&
-	test_path_is_file .git/rebase-merge/patch &&
+	test_path_is_missing .git/rebase-merge/patch &&
 	test_path_is_missing .git/rebase-merge/author-script &&
+	test_path_is_missing .git/MERGE_MSG &&
+	test_path_is_missing .git/rebase-merge/message &&
+	test_path_is_missing .git/rebase-merge/stopped-sha &&
 
 	: fail because of merge conflict &&
-	rm G.t .git/rebase-merge/patch &&
 	git reset --hard conflicting-G &&
 	test_must_fail git rebase --continue &&
 	! grep "^merge -C .* G$" .git/rebase-merge/git-rebase-todo &&
 	test_path_is_file .git/rebase-merge/patch &&
-	test_path_is_file .git/rebase-merge/author-script
+	test_path_is_file .git/rebase-merge/author-script &&
+	test_path_is_file .git/MERGE_MSG &&
+	test_path_is_file .git/rebase-merge/message &&
+	test_path_is_file .git/rebase-merge/stopped-sha
 '
 
 test_expect_success 'failed `merge <branch>` does not crash' '
diff --git a/t/t5407-post-rewrite-hook.sh b/t/t5407-post-rewrite-hook.sh
index 5f3ff051ca2..c490a5137fe 100755
--- a/t/t5407-post-rewrite-hook.sh
+++ b/t/t5407-post-rewrite-hook.sh
@@ -173,6 +173,17 @@ test_fail_interactive_rebase () {
 	)
 }
 
+test_expect_success 'git rebase with failed pick' '
+	test_fail_interactive_rebase "exec_>bar pick 1" --onto C A E &&
+	rm bar &&
+	git rebase --continue &&
+	echo rebase >expected.args &&
+	cat >expected.data <<-EOF &&
+	$(git rev-parse E) $(git rev-parse HEAD)
+	EOF
+	verify_hook_input
+'
+
 test_expect_success 'git rebase -i (unchanged)' '
 	git reset --hard D &&
 	clear_hook_input &&
-- 
gitgitgadget

