Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D213DB337
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 09:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783674418; cv=none; b=mXWRuFWametfotTWNzX8qydW5UsXK8R2mVrdxO8/dm//N43pQAeBkCtWDFARh1p2C75CnvMyygUJoGkJRX8b+uLI6gZ3HurUKWvMWBt2xqJH2QK7EFnP+4teCSdh+wrkhXIg3hLhwJ7WRYSFUqN23mTul4lpYG3RHVZeklLOLAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783674418; c=relaxed/simple;
	bh=0GsdGa5JphLnEfjGkmER2S+NLaxURD7xKOGk/ecS1ks=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=UOy4I7VlTz7o25MKUN2DxG8fceBdrMq2fVSU9M681JwrabkUS6/ueA/3Yfk3BRJCaicR6qEU20imh4rXbo1Meg4ptEu0Wxx0ffhY26w8hReIHis8yK6Pa+YdgosT1RewA7gweQ5p+RT6cQCzHSy99M0XJgvD6GxfSUknmKr8DrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PPCNBfD/; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPCNBfD/"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-4a416619cb2so231391b6e.3
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 02:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783674415; x=1784279215; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sNZ8NNlB8MujmetBy3a8qwhpLRFL4jadAIx1lxkBmHU=;
        b=PPCNBfD/IAHGDmDlHIJ27+HZl7T08M7SZvGfXnODDC6Tofepz0iFFwxx3fhhh6CxDn
         9Rqfp+pkj89fcn+0ogg+70Mkw4IxDizgOJHpzU5WoC7wvyW/xTLoDAfK+YCpm2A90Tvx
         NjOhMQP3aaPGjP0wuJ3G+TBSerlIKoASkSsZaTPKb5Z8DKHDYEeGQs8VJyFVxNGAFYy7
         zv0ZEMGmozYK/KiR7DDVC6687xslwl3/w1im1j+jNaZWFraqQGyFIm+UhKN/LJJ0fkuD
         wbGrjXuD/CceC1sMcedlj5Di4hs6q3NJYoB0H+TDfzWVFVSXeXNiyjmXj2HeXmHEBnSm
         p7CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783674415; x=1784279215;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sNZ8NNlB8MujmetBy3a8qwhpLRFL4jadAIx1lxkBmHU=;
        b=JkL8MljwvGMD7nlaDjW/z6aOsSuLHLGo04wQsNSSq1aq/1d2jmVEcjuy+h1Zln5UjC
         dMWraHObYrUtfqYsQS9tWfRaDR+8pBEp62vIwle5+uJXjPHPYutSA/N+3sQAEiOs1mj+
         K7AOZeADqEdN7hMH7wysh49uWgIv8+f7Ct6K7Cp/ATCw73TeY6UK4anhal989NaX9EkH
         ZGoUUPsGP/IAUgYLM691Nw1GcUPwqlRv2nZnLhqniq487++tUGlL21BtX4JGWKoKTTWd
         wjVU1S2qTSMOlqs2um/1yIfAHo4UZmmps65CbXH/ujs/1x4zQB37z+0h3/u/W2iHoSrx
         C86w==
X-Gm-Message-State: AOJu0Yz1bhrICCdJwhKjScpaGpLbOKwcR7+OuHinZcQO11aTzWJxxtKH
	TiJuRyyvfMHj2D4HdacccKvrMGG+uyVWxwi+VHldIWC52XNVXzaYd2kT/ifbXg==
X-Gm-Gg: AfdE7cnwax0R7oGauK6zVHh8M9ejUmfEoaC8QjZjGm83o/kNt6ttoiWHnMwYijFX1LZ
	08ITWEk16p381c6cyBFTV2sJKVdUI3QV91UdQkOFnSFEq30vek+a5ukaH/jKUolHhXLokWaDZDO
	IGrh32X1FCe6mdyPahM5WtjXz/ecdKcltU8sRnV79s6MKtmlqY6/q61kvvhhGYPshl5UcfLRLyR
	F54fEsmqUm0i2lnjGmTkCI8MEUH+JOY4WdqApQu9Vrlwfk0T6rJV3lZFRJSYvT75KLeemweBaX5
	9w3l8ZguDSg1ywECgw7EyNYQikamPxyS8EwHlyXF3lAZTcRSDaRbBskHgz8aFxu25FsYh5bO56/
	dL8k0IYAzr9knpUBaDnxYHVHbdSTGMvs0sdrm2Hmi+aqK99GOKNvWqCauJsXxoqzTuTexLVo62h
	orKwbCaUWyLHi4S2I=
X-Received: by 2002:a05:6809:390:20b0:4a3:cea7:4ab2 with SMTP id 5614622812f47-4a3cea76b86mr2520029b6e.6.1783674415384;
        Fri, 10 Jul 2026 02:06:55 -0700 (PDT)
Received: from [127.0.0.1] ([52.154.20.197])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4a1afbfbb6esm5814773b6e.9.2026.07.10.02.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 02:06:53 -0700 (PDT)
Message-Id: <baf7e6f0a6a901d4d5ca144e9f2906d4907ec1c9.1783674396.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2337.v8.git.git.1783674396.gitgitgadget@gmail.com>
References: <pull.2337.v7.git.git.1783327849.gitgitgadget@gmail.com>
	<pull.2337.v8.git.git.1783674396.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 10 Jul 2026 09:06:36 +0000
Subject: [PATCH v8 5/5] history: re-edit a squash with every message
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
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

By default "git history squash" reuses the oldest commit's message.
When --reedit-message is given it only reopened that one message, so the
messages of the other commits in the range were lost.

Gather the message of every commit in the range and build the same editor
template that "git rebase -i --autosquash" shows for a squash, reusing
add_squash_combination_header(), add_squash_message_header() and
squash_subject_comment_len(). Feed the range through
todo_list_rearrange_squash() so that each fixup!, squash! or amend! is
grouped under the commit it targets rather than shown in commit order,
exactly as autosquash would arrange them.

Only the message text differs, the changes are always folded in. A fixup!
message is commented out in full under a "will be skipped" header, a
squash! keeps its body with only the marker subject commented, and an
amend! replaces its target's message unless a squash! already folded into
that target, in which case it behaves like a squash!.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-history.adoc |  15 ++-
 builtin/history.c              | 107 ++++++++++++++++-
 t/t3455-history-squash.sh      | 210 +++++++++++++++++++++++++++++++++
 3 files changed, 328 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-history.adoc b/Documentation/git-history.adoc
index ad921ac2be..697155f5d8 100644
--- a/Documentation/git-history.adoc
+++ b/Documentation/git-history.adoc
@@ -117,8 +117,9 @@ given, for example `HEAD~3..HEAD ^topic` to additionally exclude what is
 already on `topic`. Rev-list options may also be given, but any that would
 change how the range is walked are overridden with a warning.
 +
-The oldest commit's message and authorship are preserved by default,
-unless you specify `--reedit-message`. A merge commit inside the range is
+The oldest commit's message and authorship are preserved by default. With
+`--reedit-message`, an editor opens pre-filled with the messages of all the
+folded commits so you can combine them. A merge commit inside the range is
 folded like any other, but the range must have a single base, so a range
 that reaches more than one entry point (for example a side branch that
 forked before the range and was later merged into it) is rejected.
@@ -127,7 +128,15 @@ A `fixup!`, `squash!`, or `amend!` commit is refused unless the commit it
 targets is also in the range, so the fold does not silently absorb a
 marker meant for a commit outside it. As an exception, a range made up
 entirely of markers for one target is combined into a single commit,
-keeping the last `amend!` message if there is one.
+keeping the last `amend!` message if there is one. The changes from every
+commit in the range are always folded in. Only the message text differs.
+With `--reedit-message` the template mirrors `git rebase -i --autosquash`:
+each `fixup!`, `squash!`, or `amend!` is grouped under the commit it
+targets rather than shown in commit order. A `fixup!` message is dropped
+(commented out in full), a `squash!` keeps its body with only the marker
+subject commented, and an `amend!` replaces its target's message, unless
+a `squash!` folded into that target first, in which case it keeps its
+body like a `squash!`.
 +
 A branch or tag that points at a commit inside the range would be left
 dangling once those commits are folded away, so with the default
diff --git a/builtin/history.c b/builtin/history.c
index d3f535ded9..f82001508d 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -1211,6 +1211,102 @@ static int find_interior_ref(const struct reference *ref, void *cb_data)
 	return 0;
 }
 
+static bool amend_replaces_target(struct todo_list *todo, int target)
+{
+	int i;
+
+	for (i = target + 1; i < todo->nr &&
+			     todo->items[i].command != TODO_PICK; i++) {
+		if (todo->items[i].command == TODO_SQUASH)
+			return false;
+		if (todo->items[i].flags & TODO_REPLACE_FIXUP_MSG)
+			return true;
+	}
+	return false;
+}
+
+static int build_squash_message(struct repository *repo,
+				struct commit *base,
+				struct commit *tip,
+				struct strbuf *out)
+{
+	struct rev_info revs;
+	struct commit *commit;
+	struct strvec args = STRVEC_INIT;
+	struct todo_list todo = TODO_LIST_INIT;
+	struct replay_opts opts = REPLAY_OPTS_INIT;
+	int i, nr_commits, ret;
+
+	repo_init_revisions(repo, &revs, NULL);
+	strvec_push(&args, "ignored");
+	strvec_push(&args, "--reverse");
+	strvec_push(&args, "--topo-order");
+	strvec_pushf(&args, "%s..%s", oid_to_hex(&base->object.oid),
+		     oid_to_hex(&tip->object.oid));
+	setup_revisions_from_strvec(&args, &revs, NULL);
+
+	if (prepare_revision_walk(&revs) < 0) {
+		ret = error(_("error preparing revisions"));
+		goto out;
+	}
+
+	while ((commit = get_revision(&revs)))
+		strbuf_addf(&todo.buf, "pick %s\n",
+			    oid_to_hex(&commit->object.oid));
+
+	if (todo_list_parse_insn_buffer(repo, &opts, todo.buf.buf, &todo) < 0 ||
+	    todo_list_rearrange_squash(&todo) < 0) {
+		ret = error(_("could not prepare the squash message"));
+		goto out;
+	}
+
+	nr_commits = todo.nr;
+	for (i = 0; i < nr_commits; i++) {
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
+	reset_revision_walk();
+	release_revisions(&revs);
+	strvec_clear(&args);
+	return ret;
+}
+
 static int cmd_history_squash(int argc,
 			      const char **argv,
 			      const char *prefix,
@@ -1235,6 +1331,7 @@ static int cmd_history_squash(int argc,
 		OPT_END(),
 	};
 	struct strbuf reflog_msg = STRBUF_INIT;
+	struct strbuf message = STRBUF_INIT;
 	struct oidset interior = OIDSET_INIT;
 	struct commit *base, *oldest, *tip, *rewritten, *msg_source;
 	const struct object_id *base_tree_oid, *tip_tree_oid;
@@ -1279,6 +1376,12 @@ static int cmd_history_squash(int argc,
 		}
 	}
 
+	if (flags & COMMIT_TREE_EDIT_MESSAGE) {
+		ret = build_squash_message(repo, base, tip, &message);
+		if (ret < 0)
+			goto out;
+	}
+
 	ret = setup_revwalk(repo, action, tip, &revs);
 	if (ret < 0)
 		goto out;
@@ -1287,7 +1390,8 @@ static int cmd_history_squash(int argc,
 	tip_tree_oid = &repo_get_commit_tree(repo, tip)->object.oid;
 	commit_list_append(base, &parents);
 
-	ret = commit_tree_ext(repo, "squash", msg_source, NULL, parents,
+	ret = commit_tree_ext(repo, "squash", msg_source,
+			      message.len ? message.buf : NULL, parents,
 			      base_tree_oid, tip_tree_oid, &rewritten, flags);
 	if (ret < 0) {
 		ret = error(_("failed writing squashed commit"));
@@ -1308,6 +1412,7 @@ static int cmd_history_squash(int argc,
 
 out:
 	strbuf_release(&reflog_msg);
+	strbuf_release(&message);
 	oidset_clear(&interior);
 	commit_list_free(parents);
 	release_revisions(&revs);
diff --git a/t/t3455-history-squash.sh b/t/t3455-history-squash.sh
index 6bc0a89ebc..9b24f546e0 100755
--- a/t/t3455-history-squash.sh
+++ b/t/t3455-history-squash.sh
@@ -250,6 +250,216 @@ test_expect_success 'preserves authorship of the oldest commit' '
 	test_cmp expect actual
 '
 
+test_expect_success '--reedit-message offers every folded-in message' '
+	git reset --hard start &&
+	echo b >file &&
+	git add file &&
+	git commit -m "re-one subject" -m "re-one body line" &&
+	test_commit --no-tag re-two file c &&
+	test_commit re-three file d &&
+
+	write_script editor <<-\EOF &&
+	cat "$1" >edited &&
+	echo combined >"$1"
+	EOF
+	test_set_editor "$(pwd)/editor" &&
+	git history squash --reedit-message start.. &&
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
+	echo combined >expect &&
+	git log --format="%s" -1 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--reedit-message handles fixup!, squash! and amend! like rebase' '
+	git reset --hard start &&
+	test_commit --no-tag mark-base file b &&
+	printf "fixup! mark-base\n\nfixup body\n" >msg &&
+	echo c >file &&
+	git add file &&
+	git commit -qF msg &&
+	printf "squash! mark-base\n\nsquash remark\n" >msg &&
+	echo d >file &&
+	git add file &&
+	git commit -qF msg &&
+	printf "amend! mark-base\n\namended message\n" >msg &&
+	echo e >file &&
+	git add file &&
+	git commit -qF msg &&
+
+	write_script editor <<-\EOF &&
+	cat "$1" >edited
+	EOF
+	test_set_editor "$(pwd)/editor" &&
+	git history squash --reedit-message start.. &&
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
+	git log -1 --format="%B" >final &&
+	test_grep ! "fixup body" final &&
+	test_grep "squash remark" final &&
+	test_grep "amended message" final
+'
+
+test_expect_success '--reedit-message groups fixups under their targets' '
+	git reset --hard start &&
+	test_commit --no-tag alpha file a1 &&
+	test_commit --no-tag beta file b1 &&
+	printf "fixup! alpha\n" >msg &&
+	echo a2 >file &&
+	git add file &&
+	git commit -qF msg &&
+	printf "fixup! beta\n" >msg &&
+	echo b2 >file &&
+	git add file &&
+	git commit -qF msg &&
+
+	write_script editor <<-\EOF &&
+	cat "$1" >edited
+	EOF
+	test_set_editor "$(pwd)/editor" &&
+	git history squash --reedit-message start.. &&
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
+test_expect_success '--reedit-message lets amend! replace its target message' '
+	git reset --hard start &&
+	test_commit --no-tag mark-base file b &&
+	printf "amend! mark-base\n\namended message\n" >msg &&
+	echo c >file &&
+	git add file &&
+	git commit -qF msg &&
+	printf "squash! mark-base\n\nsquash remark\n" >msg &&
+	echo d >file &&
+	git add file &&
+	git commit -qF msg &&
+
+	write_script editor <<-\EOF &&
+	cat "$1" >edited
+	EOF
+	test_set_editor "$(pwd)/editor" &&
+	git history squash --reedit-message start.. &&
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
+	git log -1 --format="%B" >final &&
+	test_grep ! "mark-base" final &&
+	test_grep "amended message" final &&
+	test_grep "squash remark" final
+'
+
+test_expect_success '--reedit-message aborts on an empty message' '
+	git reset --hard three &&
+	head_before=$(git rev-parse HEAD) &&
+
+	write_script editor <<-\EOF &&
+	>"$1"
+	EOF
+	test_set_editor "$(pwd)/editor" &&
+	test_must_fail git history squash --reedit-message start.. &&
+
+	test_cmp_rev "$head_before" HEAD
+'
+
 test_expect_success '--update-refs=head only moves HEAD' '
 	git reset --hard three &&
 	git branch -f other HEAD &&
-- 
gitgitgadget
