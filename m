Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F6C322A2D
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 14:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756996117; cv=none; b=uFZgGcfQM2A50ckCKc4pn+gUNmgssmLDVOBIhuB4rwRyGqqy3uEo0xAjMwOnYASPAZs9s1KFBCid5g3vebR8IdYq5Ta+QS3TDV1pz2ZTmvDLqIn5UpPMa64RFrANRY1azW1PIL2OhNsKRt7MnJRxlnQtoeddaMFZb7CU6YHY2+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756996117; c=relaxed/simple;
	bh=dxnsYJ0QBOfJ3Oe31p+srljVxI9UiXeWIDHoCzKIreY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u7aPR0f8tXL1T7+SpKLfLF/DWCJUAEdDqeuPUclIjBEGxjot+Vvoqw2dCCK/WEOs4FJ8ykReS/5QQ/nF+1JZbxN5afwQ+4amvGUmOIXExEaZViMaNMqDT0A6nMZ/fqAqIzpfoT3xhxCRa2AmJBLIo6TgDsI5nClaNBwgq+ikI2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QsP884jO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=afHljg2G; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QsP884jO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="afHljg2G"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EC9F87A018A;
	Thu,  4 Sep 2025 10:28:34 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 04 Sep 2025 10:28:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756996114;
	 x=1757082514; bh=hQQJtjfYhT7/1qR/PwE1qrXIIxBUwjSR6t7QZUrF+hE=; b=
	QsP884jOtArUUy6C9VqP3Xsq+8C4fPzp4b+iPgJFzv/zxZT02tTC8RWqbiCtOxf/
	sFxaGCOeIz5BxQfJrrNZdfa5dWCHwq5MpQPCZkAga4BGGy+X50UM+UIEMe1Y/1su
	jZ+vP6dUzJm46kB4ZICztGleYcf4XGy66NUdewxQuz9ZVnRDkY3Hf+Jj0WRFmgGv
	rdXegNwyC0SoAGX2sOba/9B5noUU7Csy4KlHPychXV0HAvmJzUeLm9h1qfNDw1HZ
	xNutDWuCLZlNPtBO4UwzDp57Kx6UE+nOP6Ud/TPj+5PtnCsHG5EOyVncXwXmkt3T
	bbCnrX5L2CyqwoMtRjK98A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756996114; x=
	1757082514; bh=hQQJtjfYhT7/1qR/PwE1qrXIIxBUwjSR6t7QZUrF+hE=; b=a
	fHljg2G49FPnTpw2M0/ddxMoE22ben146unnakAVOc2jq9qSVNcO0fP+srESXp7n
	0sDh9GOjNeYpMbkH00T4ga4OvfOzuYKSQFF2ByHOIrkeCKD/toQiD3lQjrgukpWy
	bKmQ+0uuxkTLQigZlIe5yw1v8kyjA2EfWjyJEfSqowMYfFh2Q6lqfxtumwcnC2+5
	zbKNwA6txDo5KEBReUiTW4qTS27B/DjIU4CDEpbQfylj1gw2iWc2eTNBFqodRXzq
	Vtk8teFgLRMHhfKW0iAjk6r2UCqIU2eHUaXpsIUOLHP79wsB2cbUitQrY4F0rTJo
	dtrR6MZiNnQloMhwTIalg==
X-ME-Sender: <xms:EqK5aNgykzEPbc3uMw6svM3-F7mPWkgxFUSDZVfQxAunXp58VMVV4Q>
    <xme:EqK5aPmRvnVERmCzD4cxFogxroExArI8e4YXMxPJB1cd61-_BrXGiMA2Ndq_utzM2
    hDMQfkBjEdD-uyHeg>
X-ME-Received: <xmr:EqK5aDhLhWemH4ovBV83msxsY9NgiXXDFp4D8jUBEmR6IvSW5ESvEyBkmnWYCZ07QJOCVM5rZeSM9PgVzqhZDybm4aHUiSiHCgc57A3YBnFDAg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeivdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucev
    lhhushhtvghrufhiiigvpeeinecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehmrghrthhinhhvohhniiesghhmrghilhdrtghomhdprhgtphhtthhopehkrhhishhtoh
    hffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhnrdgrvhhilhgrse
    hfrhgvvgdrfhhrpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgt
    phhtthhopehsohhrghgrnhhovhesghhmrghilhdrtghomhdprhgtphhtthhopegsvghnrd
    hknhhosghlvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:EqK5aD0rqgRLiQseJHadJmlUdEJv7LRTqbblJasY1gXl641Jgb-ZMw>
    <xmx:EqK5aMKW1vNm1H3Ia2SDBCOsN0_E9o3CHQfT4JNOX0J9L3ND-kSt8A>
    <xmx:EqK5aDzYgkjLL0fVvlePXlQkbdxPh27y8Oxnr3h3__yqAXRvO0jp0w>
    <xmx:EqK5aKX0tFvX651HhDelu6FbZmOtCph-JgM5OamE6cbcVQ5R9XhXQA>
    <xmx:EqK5aFeoALm96xut8zePAUv9B-u1rTRTew6_Pwqq7UCTWD7EFy3cPIa8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Sep 2025 10:28:33 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id eae0ef17 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 4 Sep 2025 14:28:33 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 04 Sep 2025 16:27:48 +0200
Subject: [PATCH RFC v3 18/18] builtin/history: implement "reword"
 subcommand
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-b4-pks-history-builtin-v3-18-509053514755@pks.im>
References: <20250904-b4-pks-history-builtin-v3-0-509053514755@pks.im>
In-Reply-To: <20250904-b4-pks-history-builtin-v3-0-509053514755@pks.im>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
 =?utf-8?q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>, 
 Martin von Zweigbergk <martinvonz@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
X-Mailer: b4 0.14.2

Implement a new "reword" subcommand for git-history(1). This subcommand
is essentially the same as if a user performed an interactive rebase
with a single commit changed to use the "reword" verb.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-history.adoc |   5 +
 builtin/history.c              | 104 +++++++++++++++++++++
 t/meson.build                  |   1 +
 t/t3454-history-reword.sh      | 202 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 312 insertions(+)

diff --git a/Documentation/git-history.adoc b/Documentation/git-history.adoc
index 6f0c64b90e..cbbcef3582 100644
--- a/Documentation/git-history.adoc
+++ b/Documentation/git-history.adoc
@@ -13,6 +13,7 @@ git history continue
 git history quit
 git history drop <commit>
 git history reorder <commit> (--before=<following-commit>|--after=<preceding-commit>)
+git history reword [<options>] <commit>
 git history split [<options>] <commit> [--] [<pathspec>...]
 
 DESCRIPTION
@@ -53,6 +54,10 @@ child commits, as that would lead to an empty branch.
 	be related to one another and must be reachable from the current `HEAD`
 	commit.
 
+`reword <commit> [--message=<message>]`::
+	Rewrite the commit message of the specified commit. All the other
+	details of this commit remain unchanged.
+
 `split [--message=<message>] <commit> [--] [<pathspec>...]`::
 	Interactively split up <commit> into two commits by choosing
 	hunks introduced by it that will be moved into the new split-out
diff --git a/builtin/history.c b/builtin/history.c
index df04b8dfc6..39acf4df28 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -723,6 +723,108 @@ static int split_commit(struct repository *repo,
 	return ret;
 }
 
+static int cmd_history_reword(int argc,
+			      const char **argv,
+			      const char *prefix,
+			      struct repository *repo)
+{
+	const char * const usage[] = {
+		N_("git history reword [<options>] <commit>"),
+		NULL,
+	};
+	const char *commit_message = NULL;
+	struct option options[] = {
+		OPT_STRING('m', "message", &commit_message, N_("message"), N_("commit message")),
+		OPT_END(),
+	};
+	struct strbuf final_message = STRBUF_INIT;
+	struct commit *original_commit, *head;
+	struct strvec commits = STRVEC_INIT;
+	struct object_id parent_tree_oid, original_commit_tree_oid;
+	struct object_id rewritten_commit;
+	const char *original_message, *original_body, *ptr;
+	struct oidmap rewritten_commits = OIDMAP_INIT;
+	struct replay_oid_mapping mapping = { 0 };
+	char *original_author = NULL;
+	size_t len;
+	int ret;
+
+	argc = parse_options(argc, argv, prefix, options, usage, 0);
+	if (argc != 1) {
+		ret = error(_("command expects a single revision"));
+		goto out;
+	}
+	repo_config(repo, git_default_config, NULL);
+
+	original_commit = lookup_commit_reference_by_name(argv[0]);
+	if (!original_commit) {
+		ret = error(_("commit to be reworded cannot be found: %s"), argv[0]);
+		goto out;
+	}
+
+	head = lookup_commit_reference_by_name("HEAD");
+	if (!head) {
+		ret = error(_("could not resolve HEAD to a commit"));
+		goto out;
+	}
+
+	/*
+	 * Collect the list of commits that we'll have to reapply now already.
+	 * This ensures that we'll abort early on in case the range of commits
+	 * contains merges, which we do not yet handle.
+	 */
+	ret = collect_commits(repo, original_commit->parents ? original_commit->parents->item : NULL,
+			      head, &commits);
+	if (ret < 0)
+		goto out;
+
+	/* We retain authorship of the original commit. */
+	original_message = repo_logmsg_reencode(repo, original_commit, NULL, NULL);
+	ptr = find_commit_header(original_message, "author", &len);
+	if (ptr)
+		original_author = xmemdupz(ptr, len);
+	find_commit_subject(original_message, &original_body);
+
+	if (original_commit->parents)
+		parent_tree_oid = *get_commit_tree_oid(original_commit->parents->item);
+	else
+		oidcpy(&parent_tree_oid, repo->hash_algo->empty_tree);
+	original_commit_tree_oid = *get_commit_tree_oid(original_commit);
+
+	ret = fill_commit_message(repo, &parent_tree_oid, &original_commit_tree_oid,
+				  original_body, commit_message, "reworded", &final_message);
+	if (ret < 0)
+		goto out;
+
+	ret = commit_tree(final_message.buf, final_message.len,
+			  &repo_get_commit_tree(repo, original_commit)->object.oid,
+			  original_commit->parents, &rewritten_commit, original_author, NULL);
+	if (ret < 0) {
+		ret = error(_("failed writing reworded commit"));
+		goto out;
+	}
+
+	replace_commits(&commits, &original_commit->object.oid, &rewritten_commit, 1);
+
+	mapping.entry.oid = rewritten_commit;
+	mapping.rewritten_oid = original_commit->object.oid;
+	oidmap_put(&rewritten_commits, &mapping);
+
+	ret = apply_commits(repo, &commits, head, original_commit,
+			    &rewritten_commits, "reword");
+	if (ret < 0)
+		goto out;
+
+	ret = 0;
+
+out:
+	oidmap_clear(&rewritten_commits, 0);
+	strbuf_release(&final_message);
+	strvec_clear(&commits);
+	free(original_author);
+	return ret;
+}
+
 static int cmd_history_split(int argc,
 			     const char **argv,
 			     const char *prefix,
@@ -835,6 +937,7 @@ int cmd_history(int argc,
 		N_("git history quit"),
 		N_("git history drop <commit>"),
 		N_("git history reorder <commit> (--before=<following-commit>|--after=<preceding-commit>)"),
+		N_("git history reword [<options>] <commit>"),
 		N_("git history split [<options>] <commit> [--] [<pathspec>...]"),
 		NULL,
 	};
@@ -845,6 +948,7 @@ int cmd_history(int argc,
 		OPT_SUBCOMMAND("quit", &fn, cmd_history_quit),
 		OPT_SUBCOMMAND("drop", &fn, cmd_history_drop),
 		OPT_SUBCOMMAND("reorder", &fn, cmd_history_reorder),
+		OPT_SUBCOMMAND("reword", &fn, cmd_history_reword),
 		OPT_SUBCOMMAND("split", &fn, cmd_history_split),
 		OPT_END(),
 	};
diff --git a/t/meson.build b/t/meson.build
index b3d33c8588..948223f453 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -380,6 +380,7 @@ integration_tests = [
   't3451-history-drop.sh',
   't3452-history-reorder.sh',
   't3453-history-split.sh',
+  't3454-history-reword.sh',
   't3500-cherry.sh',
   't3501-revert-cherry-pick.sh',
   't3502-cherry-pick-merge.sh',
diff --git a/t/t3454-history-reword.sh b/t/t3454-history-reword.sh
new file mode 100755
index 0000000000..97bdd755fa
--- /dev/null
+++ b/t/t3454-history-reword.sh
@@ -0,0 +1,202 @@
+#!/bin/sh
+
+test_description='tests for git-history reword subcommand'
+
+. ./test-lib.sh
+
+test_expect_success 'refuses to work with merge commits' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit base &&
+		git branch branch &&
+		test_commit ours &&
+		git switch branch &&
+		test_commit theirs &&
+		git switch - &&
+		git merge theirs &&
+		test_must_fail git history reword HEAD~ 2>err &&
+		test_grep "cannot rearrange commit history with merges" err &&
+		test_must_fail git history reword HEAD 2>err &&
+		test_grep "cannot rearrange commit history with merges" err
+	)
+'
+
+test_expect_success 'refuses to work with changes in the worktree or index' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit base file &&
+		echo foo >file &&
+		test_must_fail git history reword HEAD 2>err &&
+		test_grep "Your local changes to the following files would be overwritten" err &&
+		git add file &&
+		test_must_fail git history reword HEAD 2>err &&
+		test_grep "Your local changes to the following files would be overwritten" err
+	)
+'
+
+test_expect_success 'can reword tip of a branch' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit first &&
+		test_commit second &&
+		test_commit third &&
+
+		git symbolic-ref HEAD >expect &&
+		git history reword -m "third reworded" HEAD &&
+		git symbolic-ref HEAD >actual &&
+		test_cmp expect actual &&
+
+		cat >expect <<-EOF &&
+		third reworded
+		second
+		first
+		EOF
+		git log --format=%s >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'can reword commit in the middle' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit first &&
+		test_commit second &&
+		test_commit third &&
+
+		git symbolic-ref HEAD >expect &&
+		git history reword -m "second reworded" HEAD~ &&
+		git symbolic-ref HEAD >actual &&
+		test_cmp expect actual &&
+
+		cat >expect <<-EOF &&
+		third
+		second reworded
+		first
+		EOF
+		git log --format=%s >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'can reword root commit' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit first &&
+		test_commit second &&
+		test_commit third &&
+		git history reword -m "first reworded" HEAD~2 &&
+
+		cat >expect <<-EOF &&
+		third
+		second
+		first reworded
+		EOF
+		git log --format=%s >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'can use editor to rewrite commit message' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit first &&
+
+		write_script fake-editor.sh <<-\EOF &&
+		cp "$1" . &&
+		printf "\namend a comment\n" >>"$1"
+		EOF
+		test_set_editor "$(pwd)"/fake-editor.sh &&
+		git history reword HEAD &&
+
+		cat >expect <<-EOF &&
+		first
+
+		# Please enter the commit message for the reworded changes. Lines starting
+		# with ${SQ}#${SQ} will be kept; you may remove them yourself if you want to.
+		# Changes to be committed:
+		#	new file:   first.t
+		#
+		EOF
+		test_cmp expect COMMIT_EDITMSG &&
+
+		cat >expect <<-EOF &&
+		first
+
+		amend a comment
+
+		EOF
+		git log --format=%B >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'hooks are executed for rewritten commits' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit first &&
+		test_commit second &&
+		test_commit third &&
+
+		write_script .git/hooks/prepare-commit-msg <<-EOF &&
+		echo "prepare-commit-msg: \$@" >>"$(pwd)/hooks.log"
+		EOF
+		write_script .git/hooks/post-commit <<-EOF &&
+		echo "post-commit" >>"$(pwd)/hooks.log"
+		EOF
+		write_script .git/hooks/post-rewrite <<-EOF &&
+		{
+			echo "post-rewrite: \$@"
+			cat
+		} >>"$(pwd)/hooks.log"
+		EOF
+
+		git history reword -m "second reworded" HEAD~ &&
+
+		cat >expect <<-EOF &&
+		third
+		second reworded
+		first
+		EOF
+		git log --format=%s >actual &&
+		test_cmp expect actual &&
+
+		cat >expect <<-EOF &&
+		prepare-commit-msg: .git/COMMIT_EDITMSG message
+		post-commit
+		prepare-commit-msg: .git/COMMIT_EDITMSG message
+		post-commit
+		post-rewrite: history
+		$(git rev-parse second) $(git rev-parse HEAD~)
+		$(git rev-parse third) $(git rev-parse HEAD)
+		EOF
+		test_cmp expect hooks.log
+	)
+'
+
+test_expect_success 'aborts with empty commit message' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit first &&
+
+		test_must_fail git history reword -m "" HEAD 2>err &&
+		test_grep "Aborting commit due to empty commit message." err
+	)
+'
+
+test_done

-- 
2.51.0.417.g1ba7204a04.dirty

