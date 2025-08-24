Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4A72D543E
	for <git@vger.kernel.org>; Sun, 24 Aug 2025 17:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756057426; cv=none; b=orGtQ5pxy4fEADWx1PSh/qAz8UMDqwmLME56zowYdCbXH3Q8SI/Qv08CkRrePY4KVDZ41bgs+3qGUy+0BWqP9JRbqyQT8FrJdZOt8nx391qgpnfGT2NgKffUuOk0c7xt3fqW9N4J8DroBz1UJS3CTEsGCvdPB2arvJXha5CMlIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756057426; c=relaxed/simple;
	bh=dUx/7vb+hUi2cjKxKrMioWgAI5PVLQtdZBnG6iNkszk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f8koOvCMNDFiWedH9nKhY6KzD0hb6ZIXKt+IWW9lcnhKZDbKQs0V7nbnZ1UyOr/LhuVi2a0x/vfTXr/vEkFHWhWJeFIFepG6ykDiNvnhIBWdDxdc70sBReuDZBhUez2rBIIyaUxCtCfC+/CHzkk68Nxwn3v7nwBvzyF2zWA9FU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EFVM3Isi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M4UV4Nwy; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EFVM3Isi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M4UV4Nwy"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 6682D1D00026;
	Sun, 24 Aug 2025 13:43:43 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Sun, 24 Aug 2025 13:43:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1756057423;
	 x=1756143823; bh=ke9kdq+UhrqsN+S1daSyxK0u0lJ6/qs54yvx2lNNG8s=; b=
	EFVM3IsizJu22TvFqZFtno/4muSYKKgSdP+buxP4OamZlB6r3O5kSpb+agElyh7M
	2WIwDmh3dggocSt8oDkwE8FJQrWqPw6BMxWRf6T5GxTu3tUQRN5/4Dz8vapIka4B
	iZGfQMPsLpyaCdFrRXhH9xJzWxQ+QibbLj+5Wza+fq8rG2LcQM5DRIYASFTBNnr+
	lbGZEcwf1JeFRAjpPzR2Uv6W8azW0f1uNh/9SKTSTKS9LsZS+BSjNqRWCqCNkS0E
	s4gYY4FLhcDpxJICjM+5GpXzDXyF3tEdGZf21pzITh4wIlKD5ZJRLUErehgGCynZ
	dwgRXJ332BXeJLLmlgLLtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1756057423; x=
	1756143823; bh=ke9kdq+UhrqsN+S1daSyxK0u0lJ6/qs54yvx2lNNG8s=; b=M
	4UV4Nwyd7PGThix7m4oM5qRJNzAub3gezQrVd9IV1FiTjzVa/+j1BIcQobQdg4s/
	czit954x4GNXJPfWdKqkmnQGCnZtQBSoBvsFG1AA75/CjkbgluZUdHPTrYGnFwIg
	PR/EZonRYcl0RBWADiJLXEAb0g0tH+4Iab26HdZvJEyTHLV337j0r7wMft0BOsW8
	4+AxTR1tMh7Vf1qvz6va2qoW05QcJckC0YaaH9fMXaaX61keQoCc4xK12GdRNvMK
	QSDOWXFi8yA04n/GRi0UMFwm6Q0E2s2Pd7iP+uCqbPlxAwoVsFwcTG5pAx5zK6Bo
	j5YhLaw6Hhuu7xGSprxMQ==
X-ME-Sender: <xms:T0-raHwiS9emNncGrz9rGnO4J2kMOu-9UHYXDKbrxveo-NtP_ee5wg>
    <xme:T0-raM3yjGneaEq47_IYirc9XDL4W-Wq5UdbuTF97dZWpydtGH689wEUVfqapr9rd
    EWl0jsn24Of7LbKzg>
X-ME-Received: <xmr:T0-raHz90rxtiW7v3dV-NBPFFJigWN2IN2wRJ5B2Jxpa730Yzfm_UDXbR82aELzJPl0kDwvdubomGpYwVab8MDVmQLAly4Mpv6cyVApo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujedtudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepkhhrihhsthhofh
    hfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepmhgr
    rhhtihhnvhhonhiisehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhnrdgrvhhilhgrse
    hfrhgvvgdrfhhrpdhrtghpthhtohepshhorhhgrghnohhvsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsvg
    hnrdhknhhosghlvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:T0-raDEqmHOIqgSqgAUONAi1M_AM1aKF0cvfbOb4tQDC4lH6iNPHJw>
    <xmx:T0-raKZcK6P9Osg1kHwwv7_bFE6bjI2fGuPjZH2kw-ItZRC9u1zEBw>
    <xmx:T0-raFDylT-6Vu4CiN54R4C0yq6lJpSlVRy8zw2HOGlfRq4JPzOBZQ>
    <xmx:T0-raCkHtRqdMT_flcUFS_zTze4N1N6frpQSqJ8tsaD6UENO5jW2sw>
    <xmx:T0-raCv3bPSOdj-fNC2v6kQ-kBQhIXsQysV4v92bhb8B0Vkr6b1AO-ZT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Aug 2025 13:43:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 67774b69 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Sun, 24 Aug 2025 17:43:38 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Sun, 24 Aug 2025 19:42:22 +0200
Subject: [PATCH RFC v2 09/16] builtin/history: implement "reorder"
 subcommand
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250824-b4-pks-history-builtin-v2-9-964ac12f65bd@pks.im>
References: <20250824-b4-pks-history-builtin-v2-0-964ac12f65bd@pks.im>
In-Reply-To: <20250824-b4-pks-history-builtin-v2-0-964ac12f65bd@pks.im>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
 =?utf-8?q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>, 
 Martin von Zweigbergk <martinvonz@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
X-Mailer: b4 0.14.2

When working in projects where having nice commits matters it's quite
common that developers end up reordering commits a lot. This is
typically done via interactive rebases, where they can then rearrange
commits in the instruction sheet.

Still, this operation is a frequent-enough operation to provide a more
direct way of doing this imperatively. As such, introduce a new
"reorder" subcommand where users can reorder a commit A to come after or
before another commit B:

    $ git log --oneline
    a978f73 fifth
    57594ee fourth
    04eb1c4 third
    d535e30 second
    bf7438d first

    $ git history reorder :/fourth --before=:/second
    $ git log --oneline
    1610fe0 fifth
    444f97d third
    2f90797 second
    b0ae659 fourth
    bf7438d first

    $ git history reorder :/fourth --after=:/second
    $ git log --oneline
    c48729d fifth
    f44a46e third
    26693b8 fourth
    8cb4171 second
    bf7438d first

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-history.adoc |  35 +++++-
 builtin/history.c              | 130 +++++++++++++++++++++++
 t/meson.build                  |   1 +
 t/t3452-history-reorder.sh     | 234 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 399 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-history.adoc b/Documentation/git-history.adoc
index db5b292994..b36cd925dd 100644
--- a/Documentation/git-history.adoc
+++ b/Documentation/git-history.adoc
@@ -12,6 +12,7 @@ git history abort
 git history continue
 git history quit
 git history drop <commit>
+git history reorder <commit> (--before=<following-commit>|--after=<preceding-commit>)
 
 DESCRIPTION
 -----------
@@ -39,12 +40,18 @@ rewrite history in different ways:
 `drop <commit>`::
 	Drop a commit from the history and reapply all children of that
 	commit on top of the commit's parent. The commit that is to be
-	dropped must be reachable from the current `HEAD` commit.
+	dropped must be reachable from the currently checked-out commit.
 +
 Dropping the root commit converts the child of that commit into the new
 root commit. It is invalid to drop a root commit that does not have any
 child commits, as that would lead to an empty branch.
 
+`reorder <commit> (--before=<following-commit>|--after=<preceding-commit>)`::
+	Move the commit so that it becomes either the parent of
+	<following-commit> or the child of <preceding-commit>. The commits must
+	be related to one another and must be reachable from the current `HEAD`
+	commit.
+
 The following commands are used to manage an interrupted history-rewriting
 operation:
 
@@ -78,6 +85,32 @@ b1bc1bd third
 e098c27 first
 ----------
 
+Reorder a commit
+~~~~~~~~~~~~~~~~
+
+----------
+$ git log --oneline
+a978f73 fifth
+57594ee fourth
+04eb1c4 third
+d535e30 second
+bf7438d first
+$ git history reorder :/fourth --before=:/second
+$ git log --oneline
+1610fe0 fifth
+444f97d third
+2f90797 second
+b0ae659 fourth
+bf7438d first
+$ git history reorder :/fourth --after=:/second
+$ git log --oneline
+c48729d fifth
+f44a46e third
+26693b8 fourth
+8cb4171 second
+bf7438d first
+----------
+
 CONFIGURATION
 -------------
 
diff --git a/builtin/history.c b/builtin/history.c
index 2132b6a441..16b516856e 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -182,6 +182,33 @@ static int collect_commits(struct repository *repo,
 	return ret;
 }
 
+static void replace_commits(struct strvec *commits,
+			    const struct object_id *commit_to_replace,
+			    const struct object_id *replacements,
+			    size_t replacements_nr)
+{
+	char commit_to_replace_oid[GIT_MAX_HEXSZ + 1];
+	struct strvec replacement_oids = STRVEC_INIT;
+	bool found = false;
+	size_t i;
+
+	oid_to_hex_r(commit_to_replace_oid, commit_to_replace);
+	for (i = 0; i < replacements_nr; i++)
+		strvec_push(&replacement_oids, oid_to_hex(&replacements[i]));
+
+	for (i = 0; i < commits->nr; i++) {
+		if (strcmp(commits->v[i], commit_to_replace_oid))
+			continue;
+		strvec_splice(commits, i, 1, replacement_oids.v, replacement_oids.nr);
+		found = true;
+		break;
+	}
+	if (!found)
+		BUG("could not find commit to replace");
+
+	strvec_clear(&replacement_oids);
+}
+
 static int apply_commits(struct repository *repo,
 			 const struct strvec *commits,
 			 struct commit *head,
@@ -389,6 +416,107 @@ static int cmd_history_drop(int argc,
 	return ret;
 }
 
+static int cmd_history_reorder(int argc,
+			       const char **argv,
+			       const char *prefix,
+			       struct repository *repo)
+{
+	const char * const usage[] = {
+		N_("git history reorder <commit> (--before=<following-commit>|--after=<preceding-commit>)"),
+		NULL,
+	};
+	const char *before = NULL, *after = NULL;
+	struct option options[] = {
+		OPT_STRING(0, "before", &before, N_("commit"), N_("reorder before this commit")),
+		OPT_STRING(0, "after", &after, N_("commit"), N_("reorder after this commit")),
+		OPT_END(),
+	};
+	struct commit *commit_to_reorder, *head, *anchor, *old;
+	struct strvec commits = STRVEC_INIT;
+	struct object_id replacement[2];
+	struct commit_list *list = NULL;
+	int ret;
+
+	argc = parse_options(argc, argv, prefix, options, usage, 0);
+	if (argc != 1)
+		die(_("command expects a single revision"));
+	if (!before && !after)
+		die(_("exactly one option of 'before' or 'after' must be given"));
+	die_for_incompatible_opt2(!!before, "before", !!after, "after");
+
+	repo_config(repo, git_default_config, NULL);
+
+	commit_to_reorder = lookup_commit_reference_by_name(argv[0]);
+	if (!commit_to_reorder)
+		die(_("commit to be reordered cannot be found: %s"), argv[0]);
+	if (commit_to_reorder->parents && commit_to_reorder->parents->next)
+		die(_("commit to be reordered must not be a merge commit"));
+
+	anchor = lookup_commit_reference_by_name(before ? before : after);
+	if (!commit_to_reorder)
+		die(_("anchor commit cannot be found: %s"), before ? before : after);
+
+	if (oideq(&commit_to_reorder->object.oid, &anchor->object.oid))
+		die(_("commit to reorder and anchor must not be the same"));
+
+	head = lookup_commit_reference_by_name("HEAD");
+	if (!head)
+		die(_("could not resolve HEAD to a commit"));
+
+	commit_list_append(commit_to_reorder, &list);
+	if (!repo_is_descendant_of(repo, commit_to_reorder, list))
+		die(_("reordered commit must be reachable from current HEAD commit"));
+
+	/*
+	 * There is no requirement for the user to have either one of the
+	 * provided commits be the parent or child. We thus have to figure out
+	 * ourselves which one is which.
+	*/
+	if (repo_is_descendant_of(repo, anchor, list))
+		old = commit_to_reorder;
+	else
+		old = anchor;
+
+	/*
+	 * Select the whole range of commits, including the boundary commit
+	 * itself. In case the old commit is the root commit we simply pass no
+	 * boundary.
+	*/
+	ret = collect_commits(repo, old->parents ? old->parents->item : NULL,
+			      head, &commits);
+	if (ret < 0)
+		goto out;
+
+	/*
+	 * Perform the reordering of commits in the strvec. This is done by:
+	 *
+	 *   - Deleting the to-be-reordered commit from the range of commits.
+	 *
+	 *   - Replacing the anchor commit with the anchor commit plus the
+	 *     to-be-reordered commit.
+	 */
+	if (before) {
+		replacement[0] = commit_to_reorder->object.oid;
+		replacement[1] = anchor->object.oid;
+	} else {
+		replacement[0] = anchor->object.oid;
+		replacement[1] = commit_to_reorder->object.oid;
+	}
+	replace_commits(&commits, &commit_to_reorder->object.oid, NULL, 0);
+	replace_commits(&commits, &anchor->object.oid, replacement, ARRAY_SIZE(replacement));
+
+	ret = apply_commits(repo, &commits, head, old, "reorder");
+	if (ret < 0)
+		goto out;
+
+	ret = 0;
+
+out:
+	free_commit_list(list);
+	strvec_clear(&commits);
+	return ret;
+}
+
 int cmd_history(int argc,
 		const char **argv,
 		const char *prefix,
@@ -399,6 +527,7 @@ int cmd_history(int argc,
 		N_("git history continue"),
 		N_("git history quit"),
 		N_("git history drop <commit>"),
+		N_("git history reorder <commit> (--before=<following-commit>|--after=<preceding-commit>)"),
 		NULL,
 	};
 	parse_opt_subcommand_fn *fn = NULL;
@@ -407,6 +536,7 @@ int cmd_history(int argc,
 		OPT_SUBCOMMAND("continue", &fn, cmd_history_continue),
 		OPT_SUBCOMMAND("quit", &fn, cmd_history_quit),
 		OPT_SUBCOMMAND("drop", &fn, cmd_history_drop),
+		OPT_SUBCOMMAND("reorder", &fn, cmd_history_reorder),
 		OPT_END(),
 	};
 
diff --git a/t/meson.build b/t/meson.build
index 8189c6c561..2bf7bcab5a 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -378,6 +378,7 @@ integration_tests = [
   't3438-rebase-broken-files.sh',
   't3450-history.sh',
   't3451-history-drop.sh',
+  't3452-history-reorder.sh',
   't3500-cherry.sh',
   't3501-revert-cherry-pick.sh',
   't3502-cherry-pick-merge.sh',
diff --git a/t/t3452-history-reorder.sh b/t/t3452-history-reorder.sh
new file mode 100755
index 0000000000..49a0784c29
--- /dev/null
+++ b/t/t3452-history-reorder.sh
@@ -0,0 +1,234 @@
+#!/bin/sh
+
+test_description='tests for git-history reorder subcommand'
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
+		test_must_fail git history reorder HEAD --before=HEAD~ 2>err &&
+		test_grep "commit to be reordered must not be a merge commit" err &&
+		test_must_fail git history reorder HEAD~ --after=HEAD 2>err &&
+		test_grep "cannot rearrange commit history with merges" err
+	)
+'
+
+test_expect_success 'refuses to work with changes in the worktree or index' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit initial &&
+		test_commit file file &&
+		echo foo >file &&
+		test_must_fail git history reorder HEAD --before=HEAD~ 2>err &&
+		test_grep "Your local changes to the following files would be overwritten" err &&
+		git add file &&
+		test_must_fail git history reorder HEAD --before=HEAD~ 2>err &&
+		test_grep "Your local changes to the following files would be overwritten" err
+	)
+'
+
+test_expect_success 'requires exactly one of --before or --after' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit first &&
+		test_commit second &&
+		test_must_fail git history reorder HEAD 2>err &&
+		test_grep "exactly one option of ${SQ}before${SQ} or ${SQ}after${SQ} must be given" err &&
+		test_must_fail git history reorder HEAD --before=a --after=b 2>err &&
+		test_grep "options ${SQ}before${SQ} and ${SQ}after${SQ} cannot be used together" err
+	)
+'
+
+test_expect_success 'refuses to reorder commit with itself' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit first &&
+		test_commit second &&
+		test_must_fail git history reorder HEAD --after=HEAD 2>err &&
+		test_grep "commit to reorder and anchor must not be the same" err
+	)
+'
+
+test_expect_success '--before can move commit back in history' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit first &&
+		test_commit second &&
+		test_commit third &&
+		test_commit fourth &&
+		test_commit fifth &&
+		git history reorder :/fourth --before=:/second &&
+		cat >expect <<-EOF &&
+		fifth
+		third
+		second
+		fourth
+		first
+		EOF
+		git log --format=%s >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success '--before can move commit forward in history' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit first &&
+		test_commit second &&
+		test_commit third &&
+		test_commit fourth &&
+		test_commit fifth &&
+		git history reorder :/second --before=:/fourth &&
+		cat >expect <<-EOF &&
+		fifth
+		fourth
+		second
+		third
+		first
+		EOF
+		git log --format=%s >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success '--before can make a commit a root commit' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit first &&
+		test_commit second &&
+		test_commit third &&
+		git history reorder :/third --before=:/first &&
+		cat >expect <<-EOF &&
+		second
+		first
+		third
+		EOF
+		git log --format=%s >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success '--after can move commit back in history' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit first &&
+		test_commit second &&
+		test_commit third &&
+		test_commit fourth &&
+		test_commit fifth &&
+		git history reorder :/fourth --after=:/second &&
+		cat >expect <<-EOF &&
+		fifth
+		third
+		fourth
+		second
+		first
+		EOF
+		git log --format=%s >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success '--after can move commit forward in history' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit first &&
+		test_commit second &&
+		test_commit third &&
+		test_commit fourth &&
+		test_commit fifth &&
+		git history reorder :/second --after=:/fourth &&
+		cat >expect <<-EOF &&
+		fifth
+		second
+		fourth
+		third
+		first
+		EOF
+		git log --format=%s >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success '--after can make commit the tip' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit first &&
+		test_commit second &&
+		test_commit third &&
+		git history reorder :/first --after=:/third &&
+		cat >expect <<-EOF &&
+		first
+		third
+		second
+		EOF
+		git log --format=%s >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'conflicts are detected' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		echo base >file &&
+		git add file &&
+		git commit -m base &&
+		echo "first edit" >file &&
+		git commit -am "first edit" &&
+		echo "second edit" >file &&
+		git commit -am "second edit" &&
+
+		git symbolic-ref HEAD >expect-head &&
+		test_must_fail git history reorder HEAD --before=HEAD~ &&
+		test_must_fail git symbolic-ref HEAD &&
+		echo "second edit" >file &&
+		git add file &&
+		test_must_fail git history continue &&
+		echo "first edit" >file &&
+		git add file &&
+		git history continue &&
+
+		cat >expect <<-EOF &&
+		first edit
+		second edit
+		base
+		EOF
+		git log --format=%s >actual &&
+		test_cmp expect actual &&
+
+		git symbolic-ref HEAD >actual-head &&
+		test_cmp expect-head actual-head
+	)
+'
+
+test_done

-- 
2.51.0.308.g032396e0da.dirty

