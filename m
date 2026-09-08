Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051663BB12A
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 20:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788900132; cv=none; b=duJTx0MpU5qAAQY7gS9KLI4WNM609J6fA42dIP19CJ61XGn9i9h2pKybyc0xxu1tVFXUXQWy/slAW+f/j48qZfWrJRrs/GVF5HKjreRV/QQlP7VUor5NLEohS3zsEEdQ6G8jDmGuSg9D2W8TxTVQZ3si30y36mXWBjQJtN9ermc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788900132; c=relaxed/simple;
	bh=yc3jpPkJm0ttjVbIC2VTulGnPyOYq1vWdWY4aCdc+KA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=p6KoX4Kvtuudr4qHJD50hue1eTm2gWCqTWdN1rVHhTj1aLIfUwcK4mTpl2bPMYbgiH1Hh5LrRdWaPI4lLocCpzdSMG9LksSRrFs4vN/3/CV3tdG7zj7IvK7EcAq0y7T6aiaXT6X7d2Sbv2ijLAoqsKb5485XER8XiLPThvkdUxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Om395rYv; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Om395rYv"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-90cc64570deso72153746d6.0
        for <git@vger.kernel.org>; Tue, 08 Sep 2026 13:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788900130; x=1789504930; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mSSB+rSYomHR8tAwlmtGtklFDi9f3F7doejqrcy56k4=;
        b=Om395rYvkg35QdxyQl0/yrM+nMqXVeU+bk2alaWGndMxdeTridDVGPMSatxPNqXpoP
         XA3MZJIIdibSPGm7unktkbRTWASnDYXBK6b+70GBiOK/Bsewt0pAC4gxtS4D7OBE+4oc
         tlxMRut2LtHPYRP16fC+P/9FHV8TvO1ht1FI4yVV071entWGFFRRYQdVcKTJ0rDyHejX
         CvY/51y8IgVMIGLobMQjM6y0BRx952crb01WO3qz6+yTVY7H4QPlQxo86kgYNZjM7CLo
         b2ahHjTJEOixGolPjLC/SWVPQim+yYCv8ITWBCcQpEmE4AhDLTuT+7+1plTxH3nzLiW7
         mA8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788900130; x=1789504930;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mSSB+rSYomHR8tAwlmtGtklFDi9f3F7doejqrcy56k4=;
        b=sipKrMqZeTN7S83DCui4WJ9LLv+i3OtCmeLnsOb0Y1L2sH9IBUtlTzj1kUtiaEtuIv
         G5w7OmfTnydaPF3psEixJhdZxTi47KC67qbxrYTDbyeVN1Z/fauFJ4kdJOpvoR0gwuhz
         4CKGeEHqeRv2WOpq2O/1RwPgk8CJ8mrhs5P3hL8YR5xXqKe/j//xDfOxb/X2No0CNVsA
         Et0vqXFzvy5+KwmX9p1Q0KuuNoF/rULMp64VyQhF+9g40KRRZKV5dqA/ahQ2HDgFuQNP
         VjTH29P7aUbrNiAwgDZ5ElVYsR1x8Yj6K7EUzFdaMAUSQAaRds4ZNso5mO7pzkkyKt98
         pIdw==
X-Gm-Message-State: AFuF++kczA4nQZ75oUXYJt1MehHIYy00FnQPOM/dPprmWwIonas5rguF
	8KkYlNfObRA5e8ZROhPfgt/3N1nizFoawGDs/dqf92cTzJpkd5GjW7Pef737u83A
X-Gm-Gg: AYBFou3e5oYso4ISRRrqqLDUMDsdyufVhtvAKd8V6GOWnVNbGrGhLRKt09GzFNLf3IW
	vjJqSK5Y+o8JgiS7NCalhw6uePwTqUz2CIiSMYrKX3eUr+PC6PZ07ZwaDQ6uxPcOzJhG508Gj5O
	ilZ4k6fugOh//B9XX4fp3w04lVpJlISWfBRsHW63rEASLbecwgVVVDhSfTSNEbZ6gnfqhT96CG+
	puuwA+2gYIbdcA7vdJWDcXKiiDLfIM5qy2Zpel5om7zsUecQSJ4srfQARfLdZ39hdyRoET8rNdQ
	K1njxGrftsyAIbVUR82KqymsJR+u0Ivw4h22CBrebRWNZBoXg3XmalGSVo5B5l55h2gok9SQUMY
	vKxLAMx+lkq6f+brtE5bhb6cSjsE6nWScUnVurdjqkJ3xqlK3fzfTOiff6bMkeHzkOyKiufiwKb
	BK8bhqkNI7Gr2oHOlfwUz4KH/uRe7YNQKRV822gjcbj09mXmtSvp+sNaxblOjJdX8l
X-Received: by 2002:ad4:5747:0:b0:910:3923:cc76 with SMTP id 6a1803df08f44-9103923d1admr348304826d6.31.1788900129585;
        Tue, 08 Sep 2026 13:42:09 -0700 (PDT)
Received: from [127.0.0.1] ([20.106.198.166])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91040646d59sm124882906d6.8.2026.09.08.13.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 13:42:09 -0700 (PDT)
Message-Id: <8da033364685e6b88aa4bc2b44cc2a93b34e97a8.1788900120.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2337.v15.git.git.1788900119.gitgitgadget@gmail.com>
References: <pull.2337.git.git.1781465141.gitgitgadget@gmail.com>
	<pull.2337.v15.git.git.1788900119.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 08 Sep 2026 20:41:59 +0000
Subject: [PATCH v15 8/8] history: support editing squashed commit messages
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Matt Hunter <m@lfurio.us>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Tuomas Ahola <taahol@utu.fi>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Open the editor by default when squashing and provide --no-edit as the
opt-out. Record the exact commits selected by the revision walk,
rearrange that todo list with the sequencer's autosquash machinery, and
build the message template from the resulting order.

Match interactive rebase's treatment of marker messages: comment out
fixup! messages, retain squash! bodies, and let amend! replace its target
unless a preceding squash! requires both bodies. This keeps message
editing aligned with the marker validation used by the no-edit path.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-history.adoc |  18 ++-
 builtin/history.c              |  97 +++++++++++++++-
 t/t3455-history-squash.sh      | 197 +++++++++++++++++++++++++++++++++
 3 files changed, 305 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-history.adoc b/Documentation/git-history.adoc
index fb04a67685..2e2e31f521 100644
--- a/Documentation/git-history.adoc
+++ b/Documentation/git-history.adoc
@@ -133,8 +133,9 @@ given, for example `HEAD~3..HEAD ^topic` to additionally exclude what is
 already on `topic`. Rev-list options may also be given, but any that would
 change how the range is walked are overridden with a warning.
 +
-With `--no-edit`, the oldest commit's message is preserved, except that an
-`amend!` commit targeting it replaces its message.
+An editor opens pre-filled with the messages of all the folded commits so you
+can combine them. With `--no-edit`, the oldest commit's message is preserved
+instead, except that an `amend!` commit targeting it replaces its message.
 +
 The selected commits must form a connected graph with a single tip and must
 not include a root commit. Every parent of a commit after the oldest one must
@@ -148,6 +149,13 @@ of markers for one target is combined into a single commit. With `--no-edit`,
 the last `amend!` message is used if there is one; a `squash!` or `amend!` is
 otherwise refused if folding it would discard its message.
 +
+The editor template mirrors `git rebase -i --autosquash`: each `fixup!`,
+`squash!`, or `amend!` is grouped under the commit it targets rather than
+shown in commit order. A `fixup!` message is dropped (commented out in full),
+a `squash!` keeps its body with only the marker subject commented, and an
+`amend!` replaces its target's message, unless a `squash!` folded into that
+target first, in which case it keeps its body like a `squash!`.
++
 A local branch descended from a selected commit but not from the range tip
 cannot be rewritten as a descendant of the result, so with the default
 `--update-refs=branches` the command refuses. Rerun with `--update-refs=head`
@@ -163,6 +171,12 @@ OPTIONS
 	objects will be written into the repository, so applying these printed
 	ref updates is generally safe.
 
+`--edit`::
+`--no-edit`::
+	For `squash`, open an editor to combine the messages of the folded commits.
+	This is the default; use `--no-edit` to keep the selected message without
+	opening an editor.
+
 `--reedit-message`::
 	Open an editor to modify the target commit's message.
 
diff --git a/builtin/history.c b/builtin/history.c
index 8176f6794e..2d88bc4352 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -1266,6 +1266,10 @@ static int squash_check_subject(struct repository *repo,
 	return ret;
 }
 
+static int build_squash_message(struct repository *repo,
+				const struct strbuf *todo_buf,
+				struct strbuf *out);
+
 static int setup_squash_revisions(struct repository *repo,
 				  int argc, const char **argv,
 				  struct rev_info *revs)
@@ -1319,6 +1323,7 @@ static int setup_squash_revisions(struct repository *repo,
  */
 static int resolve_squash_range(struct repository *repo,
 				bool update_branches,
+				bool edit_message,
 				int argc, const char **argv,
 				struct commit **oldest_out,
 				struct commit **tip_out,
@@ -1327,11 +1332,13 @@ static int resolve_squash_range(struct repository *repo,
 	struct rev_info revs;
 	struct subject_data subject_data = SUBJECT_DATA_INIT;
 	struct commit *commit, *oldest = NULL, *tip = NULL;
+	struct strbuf todo_buf = STRBUF_INIT;
 	int ret, tip_count = 0;
 	bool walk_started = false;
 	struct ref_filter filter = REF_FILTER_INIT;
 	struct ref_array refs = { 0 };
 
+	subject_data.edit_message = edit_message;
 	ret = setup_squash_revisions(repo, argc, argv, &revs);
 	if (ret < 0)
 		goto out;
@@ -1344,6 +1351,10 @@ static int resolve_squash_range(struct repository *repo,
 	while ((commit = get_revision(&revs))) {
 		struct commit_list *p;
 
+		if (edit_message)
+			strbuf_addf(&todo_buf, "pick %s\n",
+				    oid_to_hex(&commit->object.oid));
+
 		if (!commit->parents) {
 			ret = error(_("cannot squash down to root commit"));
 			goto out;
@@ -1457,6 +1468,13 @@ static int resolve_squash_range(struct repository *repo,
 		string_list_clear(&sorting_options, 0);
 		goto out;
 	}
+	if (edit_message) {
+		strbuf_reset(&subject_data.squash_message);
+		ret = build_squash_message(repo, &todo_buf,
+					   &subject_data.squash_message);
+		if (ret < 0)
+			goto out;
+	}
 
 	*oldest_out = oldest;
 	*tip_out = tip;
@@ -1464,6 +1482,7 @@ static int resolve_squash_range(struct repository *repo,
 	ret = 0;
 
 out:
+	strbuf_release(&todo_buf);
 	clear_object_flags(repo, SQUASH_SEEN | SQUASH_TIP |
 			   SQUASH_AMEND_TARGET);
 	if (walk_started)
@@ -1475,6 +1494,76 @@ out:
 	return ret;
 }
 
+static bool amend_replaces_target(struct todo_list *todo, int target)
+{
+	for (int i = target + 1; i < todo->nr &&
+				 todo->items[i].command != TODO_PICK; i++) {
+		if (todo->items[i].command == TODO_SQUASH)
+			return false;
+		if (todo->items[i].flags & TODO_REPLACE_FIXUP_MSG)
+			return true;
+	}
+	return false;
+}
+
+static int build_squash_message(struct repository *repo,
+				const struct strbuf *todo_buf,
+				struct strbuf *out)
+{
+	struct todo_list todo = TODO_LIST_INIT;
+	struct replay_opts opts = REPLAY_OPTS_INIT;
+	int nr_commits, ret;
+
+	if (todo_list_parse_insn_buffer(repo, &opts, todo_buf->buf, &todo) < 0 ||
+	    todo_list_rearrange_squash(&todo) < 0) {
+		ret = error(_("could not prepare the squash message"));
+		goto out;
+	}
+
+	nr_commits = todo.nr;
+	for (int i = 0; i < nr_commits; i++) {
+		struct todo_item *item = &todo.items[i];
+		const char *message, *body;
+		size_t commented_len;
+		bool skip, squashing;
+
+		squashing = item->command == TODO_SQUASH ||
+			    (item->flags & TODO_REPLACE_FIXUP_MSG);
+		if (item->command == TODO_PICK)
+			skip = amend_replaces_target(&todo, i);
+		else
+			skip = !squashing;
+
+		message = repo_logmsg_reencode(repo, item->commit, NULL, NULL);
+		find_commit_subject(message, &body);
+
+		if (skip)
+			commented_len = strlen(body);
+		else if (squashing)
+			commented_len = squash_subject_comment_len(body, 1);
+		else
+			commented_len = 0;
+
+		if (!i)
+			add_squash_combination_header(out, nr_commits);
+		strbuf_addch(out, '\n');
+		add_squash_message_header(out, i + 1, skip);
+		strbuf_addstr(out, "\n\n");
+		strbuf_add_commented_lines(out, body, commented_len, comment_line_str);
+		strbuf_addstr(out, body + commented_len);
+		strbuf_complete_line(out);
+
+		repo_unuse_commit_buffer(repo, item->commit, message);
+	}
+
+	ret = 0;
+
+out:
+	todo_list_release(&todo);
+	replay_opts_release(&opts);
+	return ret;
+}
+
 static int cmd_history_squash(int argc,
 			      const char **argv,
 			      const char *prefix,
@@ -1519,14 +1608,11 @@ static int cmd_history_squash(int argc,
 	strbuf_join_argv(&reflog_msg, argc - 1, argv + 1, ' ');
 
 	ret = resolve_squash_range(repo, action == REF_ACTION_BRANCHES,
+				   edit,
 				   argc, argv, &oldest, &tip,
 				   &message_template);
 	if (ret < 0)
 		goto out;
-	if (edit) {
-		ret = error(_("message editing is not supported yet; use '--no-edit'"));
-		goto out;
-	}
 
 	ret = setup_revwalk(repo, action, tip, &revs);
 	if (ret < 0)
@@ -1538,7 +1624,8 @@ static int cmd_history_squash(int argc,
 
 	ret = commit_tree_ext(repo, "squash", oldest, message_template,
 			      oldest->parents, base_tree_oid, tip_tree_oid,
-			      &rewritten, 0);
+			      &rewritten,
+			      edit ? COMMIT_TREE_EDIT_MESSAGE : 0);
 	if (ret < 0) {
 		ret = error(_("failed writing squashed commit"));
 		goto out;
diff --git a/t/t3455-history-squash.sh b/t/t3455-history-squash.sh
index fb06637aaf..d21e9d9fc4 100755
--- a/t/t3455-history-squash.sh
+++ b/t/t3455-history-squash.sh
@@ -381,6 +381,203 @@ test_expect_success 'squashing fixups into a merge' '
 	sed 1,2d msg | test_commit_message HEAD
 '
 
+test_expect_success 'edits every message and aborts on an empty result' '
+	git reset --hard start &&
+	stage_file b &&
+	git commit -m "re-one subject" -m "re-one body line" &&
+	test_commit --no-tag re-two file c &&
+	test_commit re-three file d &&
+	head_before=$(git rev-parse HEAD) &&
+
+	write_script empty-editor <<-\EOF &&
+	>"$1"
+	EOF
+	test_set_editor "$(pwd)/empty-editor" &&
+	test_must_fail git history squash start.. 2>err &&
+	test_grep "Aborting commit due to empty commit message" err &&
+	test_cmp_rev "$head_before" HEAD &&
+
+	write_script editor <<-\EOF &&
+	cat "$1" >edited &&
+	echo combined >"$1"
+	EOF
+	test_set_editor "$(pwd)/editor" &&
+	git history squash start.. &&
+
+	cat >expect <<-EOF &&
+	# This is a combination of 3 commits.
+	# This is the 1st commit message:
+
+	re-one subject
+
+	re-one body line
+
+	# This is the commit message #2:
+
+	re-two
+
+	# This is the commit message #3:
+
+	re-three
+
+	# Please enter the commit message for the squash changes. Lines starting
+	# with ${SQ}#${SQ} will be ignored, and an empty message aborts the commit.
+	# Changes to be committed:
+	#	modified:   file
+	#
+	EOF
+	test_cmp expect edited &&
+	check_log_subjects -1 <<-\EOF
+	combined
+	EOF
+'
+
+test_expect_success 'handles fixup!, squash! and amend! like rebase' '
+	git reset --hard start &&
+	test_commit --no-tag mark-base file b &&
+	stage_file c &&
+	commit_with_message "fixup! mark-base\n\nfixup body\n" &&
+	stage_file d &&
+	commit_with_message "squash! mark-base\n\nsquash remark\n" &&
+	stage_file e &&
+	commit_with_message "amend! mark-base\n\namended message\n" &&
+
+	write_script editor <<-\EOF &&
+	cat "$1" >edited
+	EOF
+	test_set_editor "$(pwd)/editor" &&
+	git history squash start.. &&
+
+	cat >expect <<-EOF &&
+	# This is a combination of 4 commits.
+	# This is the 1st commit message:
+
+	mark-base
+
+	# The commit message #2 will be skipped:
+
+	# fixup! mark-base
+	#
+	# fixup body
+
+	# This is the commit message #3:
+
+	# squash! mark-base
+
+	squash remark
+
+	# This is the commit message #4:
+
+	# amend! mark-base
+
+	amended message
+
+	# Please enter the commit message for the squash changes. Lines starting
+	# with ${SQ}#${SQ} will be ignored, and an empty message aborts the commit.
+	# Changes to be committed:
+	#	modified:   file
+	#
+	EOF
+	test_cmp expect edited &&
+	check_log_messages -1 <<-\EOF
+	mark-base
+
+	squash remark
+
+	amended message
+
+	EOF
+'
+
+test_expect_success 'groups fixups under their targets in the editor' '
+	git reset --hard start &&
+	test_commit --no-tag alpha file a1 &&
+	test_commit --no-tag beta file b1 &&
+	stage_file a2 &&
+	commit_with_message "fixup! alpha\n" &&
+	stage_file b2 &&
+	commit_with_message "fixup! beta\n" &&
+
+	write_script editor <<-\EOF &&
+	cat "$1" >edited
+	EOF
+	test_set_editor "$(pwd)/editor" &&
+	git history squash start.. &&
+
+	cat >expect <<-EOF &&
+	# This is a combination of 4 commits.
+	# This is the 1st commit message:
+
+	alpha
+
+	# The commit message #2 will be skipped:
+
+	# fixup! alpha
+
+	# This is the commit message #3:
+
+	beta
+
+	# The commit message #4 will be skipped:
+
+	# fixup! beta
+
+	# Please enter the commit message for the squash changes. Lines starting
+	# with ${SQ}#${SQ} will be ignored, and an empty message aborts the commit.
+	# Changes to be committed:
+	#	modified:   file
+	#
+	EOF
+	test_cmp expect edited
+'
+
+test_expect_success 'lets amend! replace its target message in the editor' '
+	git reset --hard start &&
+	test_commit --no-tag mark-base file b &&
+	stage_file c &&
+	commit_with_message "amend! mark-base\n\namended message\n" &&
+	stage_file d &&
+	commit_with_message "squash! mark-base\n\nsquash remark\n" &&
+
+	write_script editor <<-\EOF &&
+	cat "$1" >edited
+	EOF
+	test_set_editor "$(pwd)/editor" &&
+	git history squash start.. &&
+
+	cat >expect <<-EOF &&
+	# This is a combination of 3 commits.
+	# The 1st commit message will be skipped:
+
+	# mark-base
+
+	# This is the commit message #2:
+
+	# amend! mark-base
+
+	amended message
+
+	# This is the commit message #3:
+
+	# squash! mark-base
+
+	squash remark
+
+	# Please enter the commit message for the squash changes. Lines starting
+	# with ${SQ}#${SQ} will be ignored, and an empty message aborts the commit.
+	# Changes to be committed:
+	#	modified:   file
+	#
+	EOF
+	test_cmp expect edited &&
+	check_log_messages -1 <<-\EOF
+	amended message
+
+	squash remark
+
+	EOF
+'
+
 test_expect_success '--update-refs=head only moves HEAD' '
 	git reset --hard three &&
 	git branch -f other HEAD &&
-- 
gitgitgadget
