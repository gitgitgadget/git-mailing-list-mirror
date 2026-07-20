Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688613CCFDE
	for <git@vger.kernel.org>; Mon, 20 Jul 2026 08:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784536034; cv=none; b=KxA1SjonyW6Vkn90ImQogUwV7ROAbDwuHjyh1FhowkwzUv+qONO9HfyhGYmu1v/BMh3Z+9JtU6NVKTHP/4OuMm3G6ZEIa0yhc0jLergb4lPPK5M5PdFLXHZlDvK7oiBl9MFojVBE7nC8iHrLOCicqn2O2kqGp6U7XC0uj/zGu18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784536034; c=relaxed/simple;
	bh=nPRCYph5Su2wJATlnq3OeKArTNKAeqnxXI9GZqxSZus=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=TGDhuKwVAtaVlBsiI/7s8PMQszy/Qmecu+X5b217zSkvf08z7PVYn126Pjysw9l/Jdpx7FBOYES25JfO6/WQ6RDq/9X6nmKcWwlNy1McmW9hmSMjL68dUJ0quUojfIXmPf6qepl771DD+R64lRGUoKBW8Cy9aKO2lW7MIuoKFJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rEnp0TVG; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rEnp0TVG"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-92e6c4a867cso415084685a.0
        for <git@vger.kernel.org>; Mon, 20 Jul 2026 01:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784536031; x=1785140831; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zxmLPSk38YC0Lbxy9KbO300zHqV8UoNPShvoLnBDZII=;
        b=rEnp0TVGbbrvYXgFnGbaDOfkWokR/x5r1zwlWpyyCi+e9MylF5V9kZ1gAh7Nqn3/Ek
         IKmloeCOCidml4prRu4Itvn2tf1tpPElIoeH2yICeDtY+18xU8CMvdrM/iba+ghn94q0
         EI8sDBckhEMkqLnndthQoIFMBca4p+T/lR3xNKszDzTiPPzdd/vG866TqiVkoOBur5JE
         m37KBhCXCQRkDHHECYpv5byuL1FVlQg/GDKp2TnlO0mPpT65K3A+uawVpxCDn5Ou4VgI
         7/R5+VWCnLMIMGgrqenPM3yFIt/J7zSz/pX6AEpP3Z9WyiEl0R2Z+yiRs27Li0Gsw/nu
         r0MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784536031; x=1785140831;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zxmLPSk38YC0Lbxy9KbO300zHqV8UoNPShvoLnBDZII=;
        b=n/LWBI2PBxDDimdZI56OSuq0lGHNjPjaiB48zTNayeXNyb0WRw51+fN8um1cH+YnFE
         6rf5t/kyTC1GqkxCixHZ0WOPdECABl3Bj9UAsaLjC65igCBF1x+fYjgraSS3Fnf8EV5Y
         bgH2BqSQH4jnz9/3wqRPryPc7L7jWyND41ycmQrWF5HsCl1iWZS07c4VywQqwizJzSEB
         GAO3Vz7A/H5Kpz5gATAHSUaxdB2P7D0KcoWo4u18Mezq9XEjCzp3/Fo7c9tYtyAriB04
         XMcORc+DAAouXtObXQQhMQsYkelFKCCeuK0pH4/wcvImU/xAxR5oZZpDnNE2NNTFWA02
         CXww==
X-Gm-Message-State: AOJu0YwY1TJ1AII6GY8HSMWPdofntLQs/RRpovnzEv0Jogb63dsJeGnF
	LB41aBwFLwJYEiL5+f/COl2TTwidasogw9ZjTN1nQWgCANoGLw27FKc2lFlzWA==
X-Gm-Gg: AfdE7cm3tOz7dpr8ILPO11xHHf3gOa3IukYMjfvK92AHlKihNW7LwqacIX/OQ079AVj
	YltWMvUzPOFTQW/0AolLMTSJObs3XN8P5srtBj/AJxftZkVtQkhYJyt7ZLmoh3UmAMmgU1RLfIg
	QYsiJbuaYJ4n4we9IMR60ZkmAgkBC3IUmeNGzAgcJuFsbBfYo8pQSfvocFDz48unTn4IvWz1zhC
	5DVO3DSITRrlFqGj6oy+7nNdc9AL2QmqTP5hZl0tzFV241djkKL1sIwpN8DEB4zqIu2lHIXGEZO
	Uj+bkXwp/CRDOM4EfDbUCKqYJv1kwn0S1C5j6mA+x1jgZy4ASNUGY81mf27DnTZVpymgTlaLUMY
	cLHaI76ZODNKazVH1BCr6qWhsOUvmbJ79OoS7D8m70djIIhXmxzErkhjpGcqKDgC+SoN+EIZhWV
	+1Bt+2r0I=
X-Received: by 2002:a05:620a:4109:b0:927:620f:d0b0 with SMTP id af79cd13be357-930b3e9a77fmr1191922185a.22.1784536031053;
        Mon, 20 Jul 2026 01:27:11 -0700 (PDT)
Received: from [127.0.0.1] ([172.174.110.128])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b52fa8dfsm827819285a.11.2026.07.20.01.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 01:27:10 -0700 (PDT)
Message-Id: <cdbc183428509b130bd303b8962aa06d578cf2e9.1784536024.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2337.v10.git.git.1784536024.gitgitgadget@gmail.com>
References: <pull.2337.v9.git.git.1784128573.gitgitgadget@gmail.com>
	<pull.2337.v10.git.git.1784536024.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 20 Jul 2026 08:27:04 +0000
Subject: [PATCH v10 5/5] history: re-edit a squash with every message
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

By default "git history squash" reuses the oldest commit's message, or
the replacement body from an amend! commit targeting it. When
--reedit-message is given it only reopened that selected message, so the
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
 Documentation/git-history.adoc |  22 +++-
 builtin/history.c              | 104 +++++++++++++++++
 t/t3455-history-squash.sh      | 201 +++++++++++++++++++++++++++++++++
 3 files changed, 321 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-history.adoc b/Documentation/git-history.adoc
index e1e930f355..6f3b031d2a 100644
--- a/Documentation/git-history.adoc
+++ b/Documentation/git-history.adoc
@@ -134,11 +134,12 @@ already on `topic`. Rev-list options may also be given, but any that would
 change how the range is walked are overridden with a warning.
 +
 The oldest commit's message is preserved by default, except that an `amend!`
-commit targeting it replaces its message. Specify `--reedit-message` to edit
-the resulting message. A merge commit inside the range is folded like any
-other, but the range must have a single base, so a range that reaches more
-than one entry point (for example a side branch that forked before the range
-and was later merged into it) is rejected.
+commit targeting it replaces its message. With `--reedit-message`, an editor
+opens pre-filled with the messages of all the folded commits so you can
+combine them. A merge commit inside the range is folded like any other, but
+the range must have a single base, so a range that reaches more than one entry
+point (for example a side branch that forked before the range and was later
+merged into it) is rejected.
 +
 A `fixup!`, `squash!`, or `amend!` commit is refused unless the commit it
 targets is also in the range, so the fold does not silently absorb a
@@ -146,6 +147,14 @@ marker meant for a commit outside it. As an exception, a range made up entirely
 of markers for one target is combined into a single commit, keeping the last
 `amend!` message if there is one.
 +
+With `--reedit-message` the template mirrors `git rebase -i --autosquash`:
+each `fixup!`, `squash!`, or `amend!` is grouped under the commit it
+targets rather than shown in commit order. A `fixup!` message is dropped
+(commented out in full), a `squash!` keeps its body with only the marker
+subject commented, and an `amend!` replaces its target's message, unless
+a `squash!` folded into that target first, in which case it keeps its
+body like a `squash!`.
++
 A branch or tag that points at a commit inside the range would be left
 dangling once those commits are folded away, so with the default
 `--update-refs=branches` the command refuses. Rerun with
@@ -162,7 +171,8 @@ OPTIONS
 	ref updates is generally safe.
 
 `--reedit-message`::
-	Open an editor to modify the rewritten commit's message.
+	Open an editor to modify the rewritten commit's message. For `squash`
+	the editor is pre-filled with the messages of all the folded commits.
 
 `--empty=(drop|keep|abort)`::
 	Control what happens when a commit becomes empty as a result of the
diff --git a/builtin/history.c b/builtin/history.c
index 423c8beaaf..2542ea33a0 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -1255,6 +1255,102 @@ static int find_interior_ref(const struct reference *ref, void *cb_data)
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
@@ -1338,6 +1434,14 @@ static int cmd_history_squash(int argc,
 		}
 	}
 
+	if (flags & COMMIT_TREE_EDIT_MESSAGE) {
+		strbuf_reset(&message);
+		ret = build_squash_message(repo, base, tip, &message);
+		if (ret < 0)
+			goto out;
+		message_template = message.buf;
+	}
+
 	ret = setup_revwalk(repo, action, tip, &revs);
 	if (ret < 0)
 		goto out;
diff --git a/t/t3455-history-squash.sh b/t/t3455-history-squash.sh
index 9c362f3094..6fce924327 100755
--- a/t/t3455-history-squash.sh
+++ b/t/t3455-history-squash.sh
@@ -271,6 +271,207 @@ test_expect_success 'preserves authorship of the oldest commit' '
 	test_cmp expect actual
 '
 
+test_expect_success '--reedit-message offers every folded-in message' '
+	git reset --hard start &&
+	stage_file b &&
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
+	check_log_subjects -1 <<-\EOF
+	combined
+	EOF
+'
+
+test_expect_success '--reedit-message handles fixup!, squash! and amend! like rebase' '
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
+test_expect_success '--reedit-message groups fixups under their targets' '
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
+	stage_file c &&
+	commit_with_message "amend! mark-base\n\namended message\n" &&
+	stage_file d &&
+	commit_with_message "squash! mark-base\n\nsquash remark\n" &&
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
+	check_log_messages -1 <<-\EOF
+	amended message
+
+	squash remark
+
+	EOF
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
