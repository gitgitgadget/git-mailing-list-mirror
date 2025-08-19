Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDBB32A3C2
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 10:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755600984; cv=none; b=N7cHNM/9Lvkw66UyFyHS3DJQ/KsFeNqAiaE6iDPL3nyifRlLsW/2sFxYHhDECMHceJTVWFhB9RlpcB0Hx9XptMdG+LibBoFLigniMc8nJzRVJ3K9aNd1QVMDLQzSOc3WCcFOwj9fDT+NOY35G0DH/ntK202jY57B5rJQeodaMUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755600984; c=relaxed/simple;
	bh=LjtzLdzn4/4qPE1TD0v1k84c8/lUCS9miSBgxk/HrMA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b1C+Sn9fK994M7CrLpqWDB6cqzV7a634HQW2UX6sSPLQct7DRvICs/Og4mgo+e34LPRJM+gmXfYL2uHiiBNprhQ3E2lKEjJgVtdKC9g9pXXGLDIKP8X70QMQwIQkGexS1KLT0jx+WvIT2rpNBDkrzTyARzm2mf6PR2C5xrirKvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZSm0dE4D; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Nsv31l9b; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZSm0dE4D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Nsv31l9b"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id D2D8F1D0020A
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 06:56:21 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 19 Aug 2025 06:56:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755600981;
	 x=1755687381; bh=p3kO8cyJA7x43DPlaOA5NDQVwM4D5f1AYIH+n5SiGL4=; b=
	ZSm0dE4DlHNqQQLHt+SEVJXHXefuxeD1nRTvDvq7XEvTeg25Rs10ONFjyp4nFSW4
	81iX8C1/FmTKT6laSpojootQEpju4xIZs8Gyd97d0AO+8T0oS7YFVRxveiQovlzD
	KiFwD+9ccE+Ypxa/hHMMhpxh9scMqzEubleSfwsUnI9kVMGb9b4pgV/TkR1i08Kk
	Ox8EOy9zOlU3M4RIQFXTIShF0WYuvX3GY7UtCBJ5kXc8g0qQjbz5KMllLNZb2wcp
	Mik4Eu76DNqIMn9gKKOqyFsvBLunSMghS52qxTkuDQlF/9EPnrnQcdPnUGoopH/i
	L46gbdC93okAF2xyiVr3EA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755600981; x=
	1755687381; bh=p3kO8cyJA7x43DPlaOA5NDQVwM4D5f1AYIH+n5SiGL4=; b=N
	sv31l9b8tAXRbUwQqVDYmyaYUUwTi7HUG70omn31qQI3Q4FFoezJleuOy56W5OXr
	rCY2aRbQtcEr/AawivK7jcyI1LkelA2UiVvLsFGMj9nRKRIkbIgCaF64D0Vc6Gf8
	2HFciDp+CHZScR4WnlMVMG0Nx0+2LGtJUNtUKt4W2ksSG+2H9COoi44Kzho4P72L
	pUFAYx0ecqIyeSV3VudTcwJJYH1Y7Xnmdrt3PmkIm7iXvh1dkJwYFdl5Hr33XwoN
	6Dc21y+Su9ZgTytcyCT1vlGEGSac2Ootuh43RmgnHN1py1UPLyiKJo6I06i0iv89
	vDqdcPwiQkoyYrt7UI5tw==
X-ME-Sender: <xms:VVikaB5-lJyEUU0SLbA1YPKFgmo2NFlKnUru-znAvGt3Uraldwu1Nw>
    <xme:VVikaA4SU9hEL4EffvVZsv1DK8i2SxV01PW9nTV8ihqVDLgqRL5DxkSDxxSmxXW-d
    9ARS3GujgDVBLgNFg>
X-ME-Received: <xmr:VVikaB3F9O5qkFAXEJmrM-GaHxqq7KFXUT6iy77Mc4_8zswAf5h0hgaB6m3sCBILNdrsRjzRg5ylPvjeBnvNqURzhOeDjHj0-AaDd2F0YT5e>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheehfeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:VVikaMXwMCVq0mJSDJngDtronx8eO_ghVCnFPcI3zT6szQ5zaYaOmg>
    <xmx:VVikaM5ublsPZm2daKXfSHoggEFUfeAngTnNBU8633Y_59F00TRhvQ>
    <xmx:VVikaDJLef6Pr6_RRUsiTHeIuJ3qbMWs_OeBLJ_RtqRyttmi5zxI9w>
    <xmx:VVikaNKP39mHckLUd2cKFFwigBQU3V6EHUCGRHOKSwcVJKs3ZroY2w>
    <xmx:VVikaPTQvZ4l-tHq0kUF3qBI60UBq2toEMVQARoGfLePqXpuaqhEE2Dj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 19 Aug 2025 06:56:21 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7eece166 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Tue, 19 Aug 2025 10:56:20 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 19 Aug 2025 12:56:02 +0200
Subject: [PATCH RFC 06/11] builtin/history: implement "reorder" subcommand
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-b4-pks-history-builtin-v1-6-9b77c32688fe@pks.im>
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
In-Reply-To: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

When working in projects where having nice commits matters it's quite
common that developers end up reordering commits a lot. Tihs is
typically done via interactive rebases, where they can then rearrange
commits in the instruction sheet.

Still, this operation is a frequent-enough operation to provide a more
direct of doing this imperatively. As such, introduce a new "reorder"
subcommand where users can reorder a commit A to come after or before
another commit B:

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
 Documentation/git-history.adoc |  32 ++++++
 builtin/history.c              | 135 +++++++++++++++++++++++++
 t/meson.build                  |   1 +
 t/t3451-history-reorder.sh     | 218 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 386 insertions(+)

diff --git a/Documentation/git-history.adoc b/Documentation/git-history.adoc
index 3012445ddc..6e8b4e1326 100644
--- a/Documentation/git-history.adoc
+++ b/Documentation/git-history.adoc
@@ -9,6 +9,7 @@ SYNOPSIS
 --------
 [synopsis]
 git history drop [<options>] <revision>
+git history reorder [<options>] <revision> --(before|after)=<revision>
 
 DESCRIPTION
 -----------
@@ -40,6 +41,12 @@ Dropping the root commit converts the child of that commit into the new
 root commit. It is invalid to drop a root commit that does not have any
 child commits, as that would lead to an empty branch.
 
+reorder <revision> (--before=<revision>|--after=<revision>)::
+	Reorder the commit so that it becomes either the parent
+	(`--before=`) or child (`--after=`) of the other specified
+	commit. The commits must be related to one another and must be
+	reachable from the current `HEAD` commit.
+
 EXAMPLES
 --------
 
@@ -56,6 +63,31 @@ b1bc1bd third
 e098c27 first
 ----------
 
+* Reorder a commit.
++
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
index 183ab9d5f7..de6073f557 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -83,6 +83,33 @@ static int collect_commits(struct repository *repo,
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
@@ -291,6 +318,112 @@ static int cmd_history_drop(int argc,
 	return ret;
 }
 
+static int cmd_history_reorder(int argc,
+			       const char **argv,
+			       const char *prefix,
+			       struct repository *repo)
+{
+	const char * const usage[] = {
+		N_("git history reorder [<options>] <revision> (--before=<commit>|--after=<commit>)"),
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
+	/*
+	 * And now we pick commits in the new order on top of either the root
+	 * commit or on top the old commit's parent.
+	 */
+	ret = apply_commits(repo, &commits, head,
+			    old->parents ? old->parents->item : NULL, "reorder");
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
@@ -298,11 +431,13 @@ int cmd_history(int argc,
 {
 	const char * const usage[] = {
 		N_("git history drop [<options>] <revision>"),
+		N_("git history reorder [<options>] <revision> --(before|after)=<revision>"),
 		NULL,
 	};
 	parse_opt_subcommand_fn *fn = NULL;
 	struct option options[] = {
 		OPT_SUBCOMMAND("drop", &fn, cmd_history_drop),
+		OPT_SUBCOMMAND("reorder", &fn, cmd_history_reorder),
 		OPT_END(),
 	};
 
diff --git a/t/meson.build b/t/meson.build
index 859c388987..8eded9ec1b 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -377,6 +377,7 @@ integration_tests = [
   't3437-rebase-fixup-options.sh',
   't3438-rebase-broken-files.sh',
   't3450-history-drop.sh',
+  't3451-history-reorder.sh',
   't3500-cherry.sh',
   't3501-revert-cherry-pick.sh',
   't3502-cherry-pick-merge.sh',
diff --git a/t/t3451-history-reorder.sh b/t/t3451-history-reorder.sh
new file mode 100755
index 0000000000..cc311ba190
--- /dev/null
+++ b/t/t3451-history-reorder.sh
@@ -0,0 +1,218 @@
+#!/bin/sh
+
+test_description='tests for git-history reorder subcommand'
+
+. ./test-lib.sh
+
+test_expect_success 'reorder refuses to work with merge commits' '
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
+test_expect_success 'reorder requires exactly one of --before or --after' '
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
+test_expect_success 'reorder refuses to reorder commit with itself' '
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
+		test_must_fail git cherry-pick --continue &&
+		echo "first edit" >file &&
+		git add file &&
+		git cherry-pick --continue &&
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
2.51.0.261.g7ce5a0a67e.dirty

