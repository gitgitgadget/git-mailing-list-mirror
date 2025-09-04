Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA893164D3
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 14:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756996092; cv=none; b=MpQeB0fbPt5Vw7O7uzWVCjhC01WrWjs6tj+/8OFYI8Bm9qiH9363Py9yNWXR7+JURl5XLKV42H7dNABGGwLrAUt8znNu5EKN22n4OuExEGli0UxzS7ULeEsbXCSRfFuJrBEHk47DidAyibHwAe5i8/1EledZWXQBfo52hmy6eI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756996092; c=relaxed/simple;
	bh=o7ApqTtUk6BocLR2+DZS209PhE5eppJR1C0HMZhwd7k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E6nqAMDLbYSDyiVCzFTk+9B3dGrCBNv2RTm/iy9qtS2F3ubKf0GaILYTbEht87HFSrSvHvpgMmgpsUK/zMX8EoueyWHpGTfLi+F7N6vf0nubhqwV6XT0TQ0Xrsos0pCDrNU+7aUNSFlRC1BKE9yJl9ZSsn4yIFP6ijIF47j9QUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tOpcm2yw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XDZNPScx; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tOpcm2yw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XDZNPScx"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F22FC7A034B;
	Thu,  4 Sep 2025 10:28:09 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 04 Sep 2025 10:28:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756996089;
	 x=1757082489; bh=HT+CxQqjKYkLthyLjCAoSfyuqOZNzcAsNkFqb558erw=; b=
	tOpcm2ywYEOs7QgHfUjF7xnexFH+mLpffZrZHXVa858JX7EMLt/sNRF1H0IOsK2l
	us0IB/b0x7qEtB6BjS5JeWF7eMssE5dDX5rZ6LQvbiDTLU1bXN1cQnqNEu0AwY9X
	pQbFPgIbtczM3MMlJZ7a/jYW7Jj2F/2RN7kWnxu+Cm9UD1ocRRddeunvBKmhsslN
	z4Ha1WWW6VfGiIzT2uDsAexTW4xajct8L6VmTJ6It/ez0kHn8C9H5rzylRBqfWhd
	nyaK0Rl5TkHRVa3L5ZvnFkJ7rr8II1A1ORSFeRgOPlwh9hBrD+oYTewOLyu6WF/P
	SxgKQePPDJ/oa7xi965ffA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756996089; x=
	1757082489; bh=HT+CxQqjKYkLthyLjCAoSfyuqOZNzcAsNkFqb558erw=; b=X
	DZNPScxjkdmt1bY9iAqthihT41NH0HNpPSSSYiaOEUTKdjRGZ9+rSw88EElvQlUh
	WIb1JWbY4903HCKczZzrExRXvFLwTnIo2gTECk+NeMziTMeDWJxyyy1qVwQwAxMo
	IKCkTzJcC2Jd/aVaU/lYerPWIgEwgjJqLz+f//ovgBuQyDIZa4W+11XdHogJInbe
	tq6nAPCs1rroXWz5ZwTp5i1Zz5AivNdCSGCM2LdMxgt1p2Tlmm3MDy2vb+eNRtS8
	C3QbE84+1xdTN1FrV6Y+1eDnYGrbD2/JB/iiu1t/GAAc0V8nLWdGhU8Fg+J+LfWh
	W1JnCpouecs5Q0aL69zaA==
X-ME-Sender: <xms:-aG5aGnzTQattETdrI5ACLD2_KFd6Pye_T9uBKx4lrkw0xam8Y9DCg>
    <xme:-aG5aLbV8BX2eyg_QMXC4XONcB1g53s6Ho_058dicNgwqLhyHURaAZUDJmdvqOwWE
    vQwbIDknj4uSEn9PA>
X-ME-Received: <xmr:-aG5aLHwAx4GJKphl8cTt9Ch_ZkXInpYqxQSacoMDwxlrE261o9P0zsKdaGP16gYz_ArpftQCPcNkMYRHs0xdnNyeSsiG9Jp_yR_x5Zzp4vrqA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeivdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehkrhhishhtoh
    hffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehj
    nhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepshhorhhgrghnohhvsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepmhgrrhhtihhnvhhonhiisehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:-aG5aMJVzfoFjrjWPR3RdIeLGt_96lROBVe9_QdY6B8_Zt922vmQ1Q>
    <xmx:-aG5aGMvn-GQz5tAT4IctVutC0mqdj7kMQ_OCA49a4D2NBguVXaxQw>
    <xmx:-aG5aMl6eBK_VAO3DqIqZ4uCX9yR0bSpTEQwWDdXvQq9Q21O5f8tbA>
    <xmx:-aG5aK7YUSnO_IDbRho_Or_-IW5hqCI3UB5WWIgL1wT-SMfRxfxR4g>
    <xmx:-aG5aJSTDTNQLBJw6ceKmTe_ge81ydZ0fJK7Iwgvgt_tsDvm5YQMoj9T>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Sep 2025 10:28:08 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ead5b02e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 4 Sep 2025 14:28:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 04 Sep 2025 16:27:40 +0200
Subject: [PATCH RFC v3 10/18] builtin/history: implement "reorder"
 subcommand
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-b4-pks-history-builtin-v3-10-509053514755@pks.im>
References: <20250904-b4-pks-history-builtin-v3-0-509053514755@pks.im>
In-Reply-To: <20250904-b4-pks-history-builtin-v3-0-509053514755@pks.im>
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
 Documentation/git-history.adoc |  33 +++++
 builtin/history.c              | 130 +++++++++++++++++++
 t/meson.build                  |   1 +
 t/t3452-history-reorder.sh     | 278 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 442 insertions(+)

diff --git a/Documentation/git-history.adoc b/Documentation/git-history.adoc
index 39c9f1e25e..b36cd925dd 100644
--- a/Documentation/git-history.adoc
+++ b/Documentation/git-history.adoc
@@ -12,6 +12,7 @@ git history abort
 git history continue
 git history quit
 git history drop <commit>
+git history reorder <commit> (--before=<following-commit>|--after=<preceding-commit>)
 
 DESCRIPTION
 -----------
@@ -45,6 +46,12 @@ Dropping the root commit converts the child of that commit into the new
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
index 0000000000..2e9d64a9fd
--- /dev/null
+++ b/t/t3452-history-reorder.sh
@@ -0,0 +1,278 @@
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
+		git history reorder :/third --before=:/second &&
+		cat >expect <<-EOF &&
+		second
+		third
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
+		$(git rev-parse third) $(git rev-parse HEAD~)
+		$(git rev-parse second) $(git rev-parse HEAD)
+		EOF
+		test_cmp expect hooks.log
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
2.51.0.417.g1ba7204a04.dirty

