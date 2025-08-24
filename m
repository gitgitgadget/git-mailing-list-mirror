Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F5F2DC355
	for <git@vger.kernel.org>; Sun, 24 Aug 2025 17:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756057464; cv=none; b=uvyj9m8CkteIik6kPVXNegYDaN/Zyb39QmVebR1gSp4SJa7gFUfH0yRbzs5hs10M7jGTdKFpIMK9o/45sw4KAK0obJ162/Xo3Mb02a2JWCK7YWNf9NnsUh9+IKXDwO8ETg2eSl6ixX08iLABGOYOl6WvhXCFgJZM9q3YOEV4N9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756057464; c=relaxed/simple;
	bh=i5oqRXVDvbaxyQe6s9FN3dKSAWu+fGqXAWbVz7MY1mE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aOaS3wLN4IRDtJxOu2br5viiffq8OhCYj72vVUlx3x3uIoTxPMhy0AkH2MuN/yku3rZzgYWO3FS+NolEqDIRiBRtIVgQ/JDIy9KQPHCJTqHDZrHeZUOlxDhz6fafVOYeCtTuwe3dh9JXI0PaFu/I3hMqTO9pZJyuPvX9XRop+oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=l98IdMjx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Oddu5SmU; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="l98IdMjx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Oddu5SmU"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6C2D17A00DF;
	Sun, 24 Aug 2025 13:44:21 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Sun, 24 Aug 2025 13:44:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1756057461;
	 x=1756143861; bh=zD+peqbAwWyztk6RCNCyQfNUArFUaA/GB8sVCBYkQoI=; b=
	l98IdMjx+QQxQg1JHkNI+wireokry2THQQyE4CIJSYFXXV2ucC9Af5SvsLtKXaDd
	6aGkebmoZnd6rWZRgGQPtJXhxRd/p18lV8PJVsnQW13vWGMWvTsg33i+DkcO4eyv
	FN5Ew/sl9gJ5wH1F+c/WP31KN7dylyvDqVAMRR0JHNF7e3JM0RN7fnwsXnUcfvMt
	WC1XXjEes1zHf7nqhwRGbnax9ZO782+i1Se5A5vPH6rbHLrafoTfA4KT1LEJsbjl
	HtrQBTuGi5x/ZeDPzh0eaTAQhvdNsKbNk/lcrx8O24n0+pOlCvzK0i8o/j42MXyW
	W7ziZicq6JXpahP51dvG3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1756057461; x=
	1756143861; bh=zD+peqbAwWyztk6RCNCyQfNUArFUaA/GB8sVCBYkQoI=; b=O
	ddu5SmUqpslZjCVs5eNu5s5rRL1BwLXLA2fQg7mMU8RCuohYsTREhuJ+rjbVY3vU
	tgzlGrE9MArsaSsqIjF1KVZRzy+TZwFkaaCQz5g1rmEL6qbHfl3nX+geClPcn2US
	+N/htaP8coRyC0dAvS+uzItYfVryFGCLTUKT48nQUr5ep/BHSXCsBikXHCKntmXf
	+khKd+V/GQWWV5HqpIRotiS74ELinGbHryefolvn7cpiMZRj+u7+RTfXp+N26DFD
	4LnT/YSMYkCwYduYLsDdMa32dvjREXBQuYuKtExjG8+FCi/uP/XA0ID8IcV/vbQK
	STF4jZXfqC8Nyjdw1jFQQ==
X-ME-Sender: <xms:dU-raF_zS7_aguQlY0N4UnXnSZf9kofUZWYFjmFeDFIv5rY-jTs5DQ>
    <xme:dU-raHTV1Vie7VUJhps37W4QSedvQYLy-O4L3JBfwuOtY_QYGNWJ7vIde8ii3jFO9
    6kZUZrgKfIkwWSoFg>
X-ME-Received: <xmr:dU-raJeIcd6dX8W2EDS9lQEoFC-dwwxKMM6d2MsUZ738W6XUkefk-yIuBGmbn2y8LHcOQ80ocgFh_vXrsVvErch_LAlaxPvvbxRpyizr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujedtudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehsohhrghgrnhhovhesghhmrghilhdrtghomhdprhgtphhtthhopehkrhhishhtoh
    hffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehj
    nhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopehmrghrthhinhhvohhniiesgh
    hmrghilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:dU-raLCm99sWUaLsyobByQgbLrHQrZgQMhNXf_U03v9DmR5xvVdp9Q>
    <xmx:dU-raLl4wcSaCDFGADQ0JVn5rjLwuoCaUYIrtNe8I6p4aX5WihK44g>
    <xmx:dU-raGf4PMX6cDBfJuBibKKgYWAmGqoMGKaj5hrktsU0zc-qhHcWLA>
    <xmx:dU-raPRIf6EJSf3BwK_gTiF4xdpW-XMXO1vsNkMPtp5B4rHXwXvxXQ>
    <xmx:dU-raFI4y-xjw-m-eOr6vP68Q7yoM9THOQ2CSolK0xgghuqW8K39-qAF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Aug 2025 13:44:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id aabd7da6 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Sun, 24 Aug 2025 17:44:19 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Sun, 24 Aug 2025 19:42:29 +0200
Subject: [PATCH RFC v2 16/16] builtin/history: implement "reword"
 subcommand
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250824-b4-pks-history-builtin-v2-16-964ac12f65bd@pks.im>
References: <20250824-b4-pks-history-builtin-v2-0-964ac12f65bd@pks.im>
In-Reply-To: <20250824-b4-pks-history-builtin-v2-0-964ac12f65bd@pks.im>
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
 Documentation/git-history.adoc |   5 ++
 builtin/history.c              |  96 +++++++++++++++++++++++++
 t/meson.build                  |   1 +
 t/t3454-history-reword.sh      | 158 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 260 insertions(+)

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
index 6d3f44152c..cdc93a1cbd 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -716,6 +716,100 @@ static int split_commit(struct repository *repo,
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
+		ret = error(_("commit to be split cannot be found: %s"), argv[0]);
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
+	ret = apply_commits(repo, &commits, head, original_commit, "reword");
+	if (ret < 0)
+		goto out;
+
+	ret = 0;
+
+out:
+	strbuf_release(&final_message);
+	strvec_clear(&commits);
+	free(original_author);
+	return ret;
+}
+
 static int cmd_history_split(int argc,
 			     const char **argv,
 			     const char *prefix,
@@ -817,6 +911,7 @@ int cmd_history(int argc,
 		N_("git history quit"),
 		N_("git history drop <commit>"),
 		N_("git history reorder <commit> (--before=<following-commit>|--after=<preceding-commit>)"),
+		N_("git history reword [<options>] <commit>"),
 		N_("git history split [<options>] <commit> [--] [<pathspec>...]"),
 		NULL,
 	};
@@ -827,6 +922,7 @@ int cmd_history(int argc,
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
index 0000000000..9822c0336a
--- /dev/null
+++ b/t/t3454-history-reword.sh
@@ -0,0 +1,158 @@
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
+
+test_done

-- 
2.51.0.308.g032396e0da.dirty

