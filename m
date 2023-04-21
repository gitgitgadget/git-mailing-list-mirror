Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9854C77B76
	for <git@archiver.kernel.org>; Fri, 21 Apr 2023 14:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbjDUO6X (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Apr 2023 10:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233099AbjDUO6K (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2023 10:58:10 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334B510271
        for <git@vger.kernel.org>; Fri, 21 Apr 2023 07:58:03 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f178da21b2so19508365e9.1
        for <git@vger.kernel.org>; Fri, 21 Apr 2023 07:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682089081; x=1684681081;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W9xmzU9qdl4RThmwjjggxusqHV1EPaesxJDrUbfabqc=;
        b=S2vF5wdHms24wsJiEHu6SLHENtpXijIKTR3+xIYn64VHgIXTkfc7ZW1Bdif0ouQepd
         Ss0qXI5ZLBiTbWPsMU5vG77YH/LlVaytIJaGgKzSH0Uua2lGvZMDrT5//twTzH/z0Bxt
         RFxniqi0kxiFQTQPXYuYOWvzyiMeL8S+2ukA8a5OblK3wXV4jMCjEEWEQrmfkWLSliEQ
         QdKlhLGDmt9WvlhYiFZDHZTcP0EDGY6NsL2fzu5YKdJzUT6NB/Vxo7imAqE+LSbM+3On
         oyBOHFiG+P0LriWpKwjCfpk5cD3AbV0fReu4ocHGbzPJdbUdye8Zof+VRRqViVv8A3CV
         20eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682089081; x=1684681081;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W9xmzU9qdl4RThmwjjggxusqHV1EPaesxJDrUbfabqc=;
        b=YpPbqBPetzH7KEHyrOy5yAXcVQ65EBIuX0tF7VWqSZc6VWvSRuPrka+at7AI8cPiht
         ZUQetU4BA+rrkQZMNCes5uj2KcBh/vjOn7NJDuYsYLRghFN2JRCeMXMQUzs8z4EO3xb/
         wYCkvTP91RxSjebsFr5ahAM/kryisbg7jsmh9zG7+vT2s3tEr6eVD9SRRejHO6PKl4t5
         8O06RGSDlXKBfbfswxH3a/Li9qLYW2hPkspZxKZfe+AKA86SsXrR+LmIf1WVvMqgGjzr
         ZXgGKDT5OHvwElreU6/4/AkZRDaCIidfB9Il4cjlud4kODmD1ejmbi5dh9smkm7b3LXZ
         a3QA==
X-Gm-Message-State: AAQBX9c0KhXCswuhnPHkBg0MeMHIROmWNNbeSgZ4Vqai+ziioER/sv5J
        IqH5UTW3Xhw6TnaBAaoDZk5sqR+sUbg=
X-Google-Smtp-Source: AKy350Z2jg666TbKXOXvI/TpddQdMla1bM2wtjYtCow8N5sPznYZ91pOsFuT9VIywuaszCWT5LQLRA==
X-Received: by 2002:a1c:7908:0:b0:3f1:6ead:e389 with SMTP id l8-20020a1c7908000000b003f16eade389mr2087078wme.30.1682089081078;
        Fri, 21 Apr 2023 07:58:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n16-20020adfe350000000b002c71b4d476asm4532611wrj.106.2023.04.21.07.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 07:58:00 -0700 (PDT)
Message-Id: <a836b049b900fa9d7c03ed5426a28b5cc754d4c5.1682089075.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1492.v2.git.1682089074.gitgitgadget@gmail.com>
References: <pull.1492.git.1679237337683.gitgitgadget@gmail.com>
        <pull.1492.v2.git.1682089074.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Apr 2023 14:57:54 +0000
Subject: [PATCH v2 6/6] rebase -i: fix adding failed command to the todo list
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
to the "done" file (which is used by "git status" to show the recently
executed commands) just before they are executed. This means that if a
command fails because it would overwrite an untracked file it has to be
added back into the todo list before the rebase stops for the user to
fix the problem.

Unfortunately when a failed command is added back into the todo list
the command preceding it is erroneously appended to the "done" file.
This means that when rebase stops after "pick B" fails the "done"
file contains

	pick A
	pick B
	pick A

instead of

	pick A
	pick B

Fix this by not updating the "done" file when adding a failed command
back into the "git-rebase-todo" file. A couple of the existing tests are
modified to improve their coverage as none of them trigger this bug or
check the "done" file.

Reported-by: Stefan Haller <lists@haller-berlin.de>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c                   | 12 ++++++------
 t/t3404-rebase-interactive.sh | 27 +++++++++++++++++----------
 t/t3430-rebase-merges.sh      | 22 ++++++++++++++++------
 3 files changed, 39 insertions(+), 22 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index db2daecb23e..9769dde00e8 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3379,7 +3379,8 @@ give_advice:
 	return -1;
 }
 
-static int save_todo(struct todo_list *todo_list, struct replay_opts *opts)
+static int save_todo(struct todo_list *todo_list, struct replay_opts *opts,
+		     int reschedule)
 {
 	struct lock_file todo_lock = LOCK_INIT;
 	const char *todo_path = get_todo_path(opts);
@@ -3389,7 +3390,7 @@ static int save_todo(struct todo_list *todo_list, struct replay_opts *opts)
 	 * rebase -i writes "git-rebase-todo" without the currently executing
 	 * command, appending it to "done" instead.
 	 */
-	if (is_rebase_i(opts))
+	if (is_rebase_i(opts) && !reschedule)
 		next++;
 
 	fd = hold_lock_file_for_update(&todo_lock, todo_path, 0);
@@ -3402,7 +3403,7 @@ static int save_todo(struct todo_list *todo_list, struct replay_opts *opts)
 	if (commit_lock_file(&todo_lock) < 0)
 		return error(_("failed to finalize '%s'"), todo_path);
 
-	if (is_rebase_i(opts) && next > 0) {
+	if (is_rebase_i(opts) && !reschedule && next > 0) {
 		const char *done = rebase_path_done();
 		int fd = open(done, O_CREAT | O_WRONLY | O_APPEND, 0666);
 		int ret = 0;
@@ -4716,7 +4717,7 @@ static int pick_commits(struct repository *r,
 		const char *arg = todo_item_get_arg(todo_list, item);
 		int check_todo = 0;
 
-		if (save_todo(todo_list, opts))
+		if (save_todo(todo_list, opts, reschedule))
 			return -1;
 		if (is_rebase_i(opts)) {
 			if (item->command != TODO_COMMENT) {
@@ -4797,8 +4798,7 @@ static int pick_commits(struct repository *r,
 			       get_item_line_length(todo_list,
 						    todo_list->current),
 			       get_item_line(todo_list, todo_list->current));
-			todo_list->current--;
-			if (save_todo(todo_list, opts))
+			if (save_todo(todo_list, opts, reschedule))
 				return -1;
 			if (item->commit)
 				write_rebase_head(&item->commit->object.oid);
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index a657167befd..653c19bc9c8 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1276,18 +1276,23 @@ test_expect_success 'todo count' '
 '
 
 test_expect_success 'rebase -i commits that overwrite untracked files (pick)' '
-	git checkout --force branch2 &&
+	git checkout --force A &&
 	git clean -f &&
+	cat >todo <<-EOF &&
+	exec >file2
+	pick $(git rev-parse B) B
+	pick $(git rev-parse C) C
+	pick $(git rev-parse D) D
+	exec cat .git/rebase-merge/done >actual
+	EOF
 	(
-		set_fake_editor &&
-		FAKE_LINES="edit 1 2" git rebase -i A
+		set_replace_editor todo &&
+		test_must_fail git rebase -i A
 	) &&
-	test_cmp_rev HEAD F &&
-	test_path_is_missing file6 &&
-	>file6 &&
-	test_must_fail git rebase --continue &&
-	test_cmp_rev HEAD F &&
-	rm file6 &&
+	test_cmp_rev HEAD B &&
+	head -n3 todo >expect &&
+	test_cmp expect .git/rebase-merge/done &&
+	rm file2 &&
 	test_path_is_missing .git/rebase-merge/author-script &&
 	test_path_is_missing .git/rebase-merge/patch &&
 	test_path_is_missing .git/MERGE_MSG &&
@@ -1299,7 +1304,9 @@ test_expect_success 'rebase -i commits that overwrite untracked files (pick)' '
 	grep "error: you have staged changes in your working tree" err &&
 	git reset --hard HEAD &&
 	git rebase --continue &&
-	test_cmp_rev HEAD I
+	test_cmp_rev HEAD D &&
+	tail -n3 todo >>expect &&
+	test_cmp expect actual
 '
 
 test_expect_success 'rebase -i commits that overwrite untracked files (squash)' '
diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index 18a0bc8fafb..86f4e0e4d6f 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -128,14 +128,24 @@ test_expect_success 'generate correct todo list' '
 '
 
 test_expect_success '`reset` refuses to overwrite untracked files' '
-	git checkout -b refuse-to-reset &&
+	git checkout B &&
 	test_commit dont-overwrite-untracked &&
-	git checkout @{-1} &&
-	: >dont-overwrite-untracked.t &&
-	echo "reset refs/tags/dont-overwrite-untracked" >script-from-scratch &&
+	cat >script-from-scratch <<-EOF &&
+	exec >dont-overwrite-untracked.t
+	pick $(git rev-parse B) B
+	reset refs/tags/dont-overwrite-untracked
+	pick $(git rev-parse C) C
+	exec cat .git/rebase-merge/done >actual
+	EOF
 	test_config sequence.editor \""$PWD"/replace-editor.sh\" &&
-	test_must_fail git rebase -ir HEAD &&
-	git rebase --abort
+	test_must_fail git rebase -ir A &&
+	test_cmp_rev HEAD B &&
+	head -n3 script-from-scratch >expect &&
+	test_cmp expect .git/rebase-merge/done &&
+	rm dont-overwrite-untracked.t &&
+	git rebase --continue &&
+	tail -n3 script-from-scratch >>expect &&
+	test_cmp expect actual
 '
 
 test_expect_success '`reset` rejects trees' '
-- 
gitgitgadget
