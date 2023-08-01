Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00719C0015E
	for <git@archiver.kernel.org>; Tue,  1 Aug 2023 15:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234109AbjHAPX7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Aug 2023 11:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234081AbjHAPXw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2023 11:23:52 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04046211E
        for <git@vger.kernel.org>; Tue,  1 Aug 2023 08:23:42 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fbc5d5742eso63017725e9.3
        for <git@vger.kernel.org>; Tue, 01 Aug 2023 08:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690903420; x=1691508220;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=utc86jQ450LQo2nvFbVNNJSteny3cBUQPuZfLdcUVXA=;
        b=APLiUF95XhTa+yWqA2IVRA6lQEzEAzhelFfIZQUqXBtZSnPAffewzjokUdE6V1S+HR
         2YmHNFoIlNaDSpPPcRIdt0KtkRdb29h10TYnl4Lc7UiUZ3kqsJsncwf/MFD9NRQmL5IW
         graHaK3krbtm/ukOpTdjEy7WOR/RxTEWwbfMYncU8b3liP726lhdVIrH1AHKEibt4NgP
         whh6M1cBS4zEvXiy/1tzFZW2dhpRNOf93sU+Wwld/o9WRouJMYV52BgHtrbn5ykSYEQW
         cW+m5SPnRrFZx27sziNRBVW+OcZO3yzTF43LnkPH5zOdk6HbdbePXIAYc+XsmHT4qQp/
         yNHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690903420; x=1691508220;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=utc86jQ450LQo2nvFbVNNJSteny3cBUQPuZfLdcUVXA=;
        b=XrlwSsDA+4KU74jD5FYq2/i5++vGeXIMCx/+f+d93uqNMy152PmfWWQ7blY2+AwODs
         2E2r/UAhbHK2NzR31H58kNHQqiBWHS3ji+b7/ExrfpgiuZo95srjSkETrlBqfec3fcEr
         qHNI6AWdL2tZ841ScSgfphcExQx+n12jEgyZSH7VxnyL00Wv2it+4bfl69Pi/bhaXM7o
         mRs+dKvJXAmljRYUUOS020vgM1kwEssphAEqNSE7TeoIk1vkdgXQqRIopzKL+1L66rdr
         UMz3G+iE++u0ueBmVekR/JJ+/hPhjsxPdBKES4/HPkiwBVasbDvh+lKePVNWbw4TrVpx
         2icg==
X-Gm-Message-State: ABy/qLZVbc7u4c8n9b8NBzpEJgke9qmufG+9VK8X/fVCOjved4580SrF
        t/rSklkTlkemmrhQyCgAjyO07DlmL9s=
X-Google-Smtp-Source: APBJJlFCLdAVNHPV/blspihhPW0dG0DyoNwrkbUeDIpToRXmMaJI/P0TOizbdd26DbDw5imHoRA6Jw==
X-Received: by 2002:a05:600c:11ce:b0:3fe:19cf:93ca with SMTP id b14-20020a05600c11ce00b003fe19cf93camr2806276wmi.8.1690903420193;
        Tue, 01 Aug 2023 08:23:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l27-20020a05600c1d1b00b003fe1b3e0852sm4364318wms.0.2023.08.01.08.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 08:23:39 -0700 (PDT)
Message-ID: <bbe0afde512c52bc818fd1d10d10b3af400246ba.1690903412.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1492.v3.git.1690903412.gitgitgadget@gmail.com>
References: <pull.1492.v2.git.1682089074.gitgitgadget@gmail.com>
        <pull.1492.v3.git.1690903412.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Aug 2023 15:23:32 +0000
Subject: [PATCH v3 7/7] rebase -i: fix adding failed command to the todo list
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

When rebasing commands are moved from the todo list in "git-rebase-todo"
to the "done" file (which is used by "git status" to show the recently
executed commands) just before they are executed. This means that if a
command fails because it would overwrite an untracked file it has to be
added back into the todo list before the rebase stops for the user to
fix the problem.

Unfortunately when a failed command is added back into the todo list the
command preceding it is erroneously appended to the "done" file.  This
means that when rebase stops after "pick B" fails the "done" file
contains

	pick A
	pick B
	pick A

instead of

	pick A
	pick B

This happens because save_todo() updates the "done" file with the
previous command whenever "git-rebase-todo" is updated. When we add the
failed pick back into "git-rebase-todo" we do not want to update
"done". Fix this by adding a "reschedule" parameter to save_todo() which
prevents the "done" file from being updated when adding a failed command
back into the "git-rebase-todo" file. A couple of the existing tests are
modified to improve their coverage as none of them trigger this bug or
check the "done" file.

Reported-by: Stefan Haller <lists@haller-berlin.de>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c                   | 12 ++++++------
 t/t3404-rebase-interactive.sh | 29 ++++++++++++++++++-----------
 t/t3430-rebase-merges.sh      | 22 ++++++++++++++++------
 3 files changed, 40 insertions(+), 23 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index a90b015e79c..4976d159745 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3397,7 +3397,8 @@ give_advice:
 	return -1;
 }
 
-static int save_todo(struct todo_list *todo_list, struct replay_opts *opts)
+static int save_todo(struct todo_list *todo_list, struct replay_opts *opts,
+		     int reschedule)
 {
 	struct lock_file todo_lock = LOCK_INIT;
 	const char *todo_path = get_todo_path(opts);
@@ -3407,7 +3408,7 @@ static int save_todo(struct todo_list *todo_list, struct replay_opts *opts)
 	 * rebase -i writes "git-rebase-todo" without the currently executing
 	 * command, appending it to "done" instead.
 	 */
-	if (is_rebase_i(opts))
+	if (is_rebase_i(opts) && !reschedule)
 		next++;
 
 	fd = hold_lock_file_for_update(&todo_lock, todo_path, 0);
@@ -3420,7 +3421,7 @@ static int save_todo(struct todo_list *todo_list, struct replay_opts *opts)
 	if (commit_lock_file(&todo_lock) < 0)
 		return error(_("failed to finalize '%s'"), todo_path);
 
-	if (is_rebase_i(opts) && next > 0) {
+	if (is_rebase_i(opts) && !reschedule && next > 0) {
 		const char *done = rebase_path_done();
 		int fd = open(done, O_CREAT | O_WRONLY | O_APPEND, 0666);
 		int ret = 0;
@@ -4730,7 +4731,7 @@ static int pick_commits(struct repository *r,
 		const char *arg = todo_item_get_arg(todo_list, item);
 		int check_todo = 0;
 
-		if (save_todo(todo_list, opts))
+		if (save_todo(todo_list, opts, reschedule))
 			return -1;
 		if (is_rebase_i(opts)) {
 			if (item->command != TODO_COMMENT) {
@@ -4811,8 +4812,7 @@ static int pick_commits(struct repository *r,
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
index a8ad398956a..71da9c465a1 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1277,19 +1277,24 @@ test_expect_success 'todo count' '
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
-	test_cmp_rev REBASE_HEAD I &&
-	rm file6 &&
+	test_cmp_rev HEAD B &&
+	test_cmp_rev REBASE_HEAD C &&
+	head -n3 todo >expect &&
+	test_cmp expect .git/rebase-merge/done &&
+	rm file2 &&
 	test_path_is_missing .git/rebase-merge/patch &&
 	echo changed >file1 &&
 	git add file1 &&
@@ -1297,7 +1302,9 @@ test_expect_success 'rebase -i commits that overwrite untracked files (pick)' '
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
index 804ff819782..0b0877b9846 100755
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
