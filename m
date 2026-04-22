Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D993CAE92
	for <git@vger.kernel.org>; Wed, 22 Apr 2026 10:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776853752; cv=none; b=mybe2T3dvqgeJOeA5poLKN+Tk3n/8qUcDeqrgHApYsmvwWCcY6TlqVxxq+P2t0cdfvkQUEwuFX/LQt3SIJZMAFeKX+N1H2AsYoiPBvdOUyvUigvxQUvwkira763Ijx98hKjlRX3vREhFK7M4X/nYQwl5GJueGlsykHfvMSjtg3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776853752; c=relaxed/simple;
	bh=iJkRxup6czB+BKbaWFdLDPH5lqUp5kl1QJn4cPgDUJU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pYzkyORGItKTIxxAEOIBvf5PVDgZwciaQSSQgQLSGPLBrGXo02gEMH79v4Wq9e3+HW7jv3mIUJGHcIymScw58ZY7yd6dmRVFRrnN+qljN6pGSzrupq3UkZx5edDUubha7WIq5MEFbnTEYWfBqSNc4npgmzlY5wWVZ6QklJ+v8+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=b/oVYNz4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cuYsdFSt; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="b/oVYNz4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cuYsdFSt"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AA8E97A0184;
	Wed, 22 Apr 2026 06:29:09 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 22 Apr 2026 06:29:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776853749;
	 x=1776940149; bh=bU9soRBJlSXRdcSq2010lDLvbnyE4eBXEEksQs+kPgQ=; b=
	b/oVYNz4TxKT/NYK6UJe4o70JWEHZel2nfHBIOd6c/jDc4gOKZwOXn6KGmnph9Mx
	Nj2H8CfU7aC9rlt9b9iULg+C6mfUEziG7GfJmhLMxgS53YRGuU/UNiMYHuJYvwwl
	CPIRxcM8WiE9aS8jNtIYNT3RZ9AUGYztkxEuxmRKHvTy1e69JP0nlYPoGRJPsJPv
	6bbBuH9N4Ry/muzvidK3U89KtkVvBm6R14faOda9j26axq/XqcVU5AWcvJm9wknL
	9kk8HpGenXwxen3QUPc0OmMR+Iq3QK5FVmDONG2VqoRXbHv0g9lv2H4pzxn1OSP1
	SrL3TRJkCnFszmgaKJAvbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776853749; x=
	1776940149; bh=bU9soRBJlSXRdcSq2010lDLvbnyE4eBXEEksQs+kPgQ=; b=c
	uYsdFStsuRD2VM4t0rchPRqvqpbtNmjirwQBPDnzApiVfC3LbKyLg9i+UMWp7qHU
	BvWz9C+sQ1gEzK472L2tRugDFv9THVxA6NDfe/3ZNJ8/BOEdQSWL6MKliFJQrU2V
	nSTMXN9F0JsLcyRRhkl10XBL6/rksRDgGES9pAwWxBc+iWG27tYmCWs4YmGHgPxX
	GvKvJju7e6TXGi/9nqG2sQ/QoQkZ/PTHpUNGl//WVBEjavS55R478WyDrOeWVeZn
	kYPSpBPsVXJebfK45JcAzidQA6yrg0f4cWZtfyZ7Fm7JgNP0VdVm7H3Rew76VjJy
	pBOypdtiPx+1eJoBZGhzA==
X-ME-Sender: <xms:9aLoaVxc51V2EzUsyVDlvRUDz8Ud1oucCq-HIEruejmaihBoAWMcmg>
    <xme:9aLoabSa4DV0Rj9-ZbWOVc5LV9hoLG_NHuPFWdRA2aCaliBctcmIq-vHa9VJGPUXD
    kcD9MtENfFJBevDG1AqgQABfOsIVzo_aXl0e6pOYcoUThWwfFv3hA>
X-ME-Received: <xmr:9aLoac-M2KWyuOOJvKxPU-2IuAyi1900RZxTnxzBUcwrDukN2ohIMV7Mm9B2109FLUtxjcJX3NuF_lHM5_OljMaqw97bFySHZyh-qikBtZI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeigedtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:9aLoaSo3ZKQ9OsSFPUhMR8-NZbTN3HnAUook4TYk_5rwB_PQ_9snsA>
    <xmx:9aLoaZm2uTjeZkzZGZJoUSmBi7NAaN1WR_WPGU-vwnbzLTkZ9Fdfzg>
    <xmx:9aLoaZIgxKG8TFL6pXeOd_gZmOsf9ZTdfu3DZJgGbtlGu-yx2rh58g>
    <xmx:9aLoaey88ZOl27V2N0-Fl2HWkxbzli9jhQkigjvT6EKtcsTkMptRTg>
    <xmx:9aLoaRi9E1hcGxIvPMapjLByqSyUOnDtdt_n3Gh94e6N_PAdYcPQaZTH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Apr 2026 06:29:08 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f3879355 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 22 Apr 2026 10:29:08 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 22 Apr 2026 12:28:59 +0200
Subject: [PATCH 2/2] builtin/history: introduce "fixup" subcommand
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-b4-pks-history-fixup-v1-2-48d4484243de@pks.im>
References: <20260422-b4-pks-history-fixup-v1-0-48d4484243de@pks.im>
In-Reply-To: <20260422-b4-pks-history-fixup-v1-0-48d4484243de@pks.im>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>
X-Mailer: b4 0.15.2

The newly introduced git-history(1) command provides functionality to
easily edit commit history while also rebasing dependent branches. The
functionality exposed by this command is still somewhat limited though.

One common use case when editing commit history that is not yet covered
is fixing up a specific commit. Introduce a new subcommand that allows
the user to do exactly that by performing a three-way merge into the
target's commit tree, using HEAD's tree as the merge base. The flow is
thus essentially:

    $ echo changes >file
    $ git add file
    $ git history fixup HEAD~

Like with the other commands, this will automatically rebase dependent
branches, as well. Unlike the other commands though:

  - The command does not work in a bare repository as it interacts with
    the index.

  - The command may run into merge conflicts. If so, the command will
    simply abort.

Especially the second item limits the usefulness of this command a bit.
But there are plans to introduce first-class conflicts into Git, which
will help use cases like this one.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-history.adoc |  52 ++++-
 builtin/history.c              | 153 +++++++++++++
 t/meson.build                  |   1 +
 t/t3453-history-fixup.sh       | 500 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 704 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-history.adoc b/Documentation/git-history.adoc
index 24dc907033..3cdfc8ba02 100644
--- a/Documentation/git-history.adoc
+++ b/Documentation/git-history.adoc
@@ -8,6 +8,7 @@ git-history - EXPERIMENTAL: Rewrite history
 SYNOPSIS
 --------
 [synopsis]
+git history fixup <commit> [--dry-run] [--update-refs=(branches|head)] [--reedit-message]
 git history reword <commit> [--dry-run] [--update-refs=(branches|head)]
 git history split <commit> [--dry-run] [--update-refs=(branches|head)] [--] [<pathspec>...]
 
@@ -22,8 +23,9 @@ THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
 This command is related to linkgit:git-rebase[1] in that both commands can be
 used to rewrite history. There are a couple of major differences though:
 
-* linkgit:git-history[1] can work in a bare repository as it does not need to
-  touch either the index or the worktree.
+* Most subcommands of linkgit:git-history[1] can work in a bare repository as
+  they do not need to touch either the index or the worktree. The `fixup`
+  subcommand is an exception to this, as it reads staged changes from the index.
 * linkgit:git-history[1] does not execute any linkgit:githooks[5] at the
   current point in time. This may change in the future.
 * linkgit:git-history[1] by default updates all branches that are descendants
@@ -53,6 +55,19 @@ COMMANDS
 
 The following commands are available to rewrite history in different ways:
 
+`fixup <commit>`::
+	Apply the currently staged changes to the specified commit. The staged
+	changes are incorporated into the target commit's tree via a three-way
+	merge, using HEAD's tree as the merge base, which is equivalent to
+	linkgit:git-cherry-pick[1].
++
+The commit message and authorship of the target commit are preserved by
+default, unless you specify `--reedit-message`.
++
+If applying the staged changes would result in a conflict, the command
+aborts with an error. All branches that are descendants of the original
+commit are updated to point to the rewritten history.
+
 `reword <commit>`::
 	Rewrite the commit message of the specified commit. All the other
 	details of this commit remain unchanged. This command will spawn an
@@ -87,6 +102,9 @@ OPTIONS
 	objects will be written into the repository, so applying these printed
 	ref updates is generally safe.
 
+`--reedit-message`::
+	Open an editor to modify the target commit's message.
+
 `--update-refs=(branches|head)`::
 	Control which references will be updated by the command, if any. With
 	`branches`, all local branches that point to commits which are
@@ -96,6 +114,36 @@ OPTIONS
 EXAMPLES
 --------
 
+Fixup a commit
+~~~~~~~~~~~~~~
+
+----------
+$ git log --oneline --stat
+abc1234 (HEAD -> main) third
+ third.txt | 1 +
+def5678 second
+ second.txt | 1 +
+ghi9012 first
+ first.txt | 1 +
+
+$ echo "change" >>unrelated.txt
+$ git add unrelated.txt
+$ git history fixup ghi9012
+
+$ git log --oneline --stat
+jkl3456 (HEAD -> main) third
+ third.txt | 1 +
+mno7890 second
+ second.txt | 1 +
+pqr1234 first
+ first.txt     | 1 +
+ unrelated.txt | 1 +
+----------
+
+The staged addition of `unrelated.txt` has been incorporated into the `first`
+commit. All descendant commits have been replayed on top of the rewritten
+history.
+
 Split a commit
 ~~~~~~~~~~~~~~
 
diff --git a/builtin/history.c b/builtin/history.c
index 549e352c74..6299f0dfa9 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -10,6 +10,7 @@
 #include "gettext.h"
 #include "hex.h"
 #include "lockfile.h"
+#include "merge-ort.h"
 #include "oidmap.h"
 #include "parse-options.h"
 #include "path.h"
@@ -23,6 +24,8 @@
 #include "unpack-trees.h"
 #include "wt-status.h"
 
+#define GIT_HISTORY_FIXUP_USAGE \
+	N_("git history fixup <commit> [--dry-run] [--update-refs=(branches|head)] [--reedit-message]")
 #define GIT_HISTORY_REWORD_USAGE \
 	N_("git history reword <commit> [--dry-run] [--update-refs=(branches|head)]")
 #define GIT_HISTORY_SPLIT_USAGE \
@@ -434,6 +437,154 @@ static int handle_reference_updates(struct rev_info *revs,
 	return ret;
 }
 
+static int cmd_history_fixup(int argc,
+			     const char **argv,
+			     const char *prefix,
+			     struct repository *repo)
+{
+	const char * const usage[] = {
+		GIT_HISTORY_FIXUP_USAGE,
+		NULL,
+	};
+	enum ref_action action = REF_ACTION_DEFAULT;
+	int dry_run = 0;
+	enum commit_tree_flags flags = 0;
+	struct option options[] = {
+		OPT_CALLBACK_F(0, "update-refs", &action, "(branches|head)",
+			       N_("control which refs should be updated"),
+			       PARSE_OPT_NONEG, parse_ref_action),
+		OPT_BOOL('n', "dry-run", &dry_run,
+			 N_("perform a dry-run without updating any refs")),
+		OPT_BIT(0, "reedit-message", &flags,
+			N_("open an editor to modify the commit message"),
+			COMMIT_TREE_EDIT_MESSAGE),
+		OPT_END(),
+	};
+	struct merge_result merge_result = { 0 };
+	struct merge_options merge_opts = { 0 };
+	struct strbuf reflog_msg = STRBUF_INIT;
+	struct commit *head_commit, *original, *rewritten;
+	struct tree *head_tree, *original_tree, *index_tree;
+	struct rev_info revs = { 0 };
+	int ret;
+
+	argc = parse_options(argc, argv, prefix, options, usage, 0);
+	if (argc != 1) {
+		ret = error(_("command expects a single revision"));
+		goto out;
+	}
+	repo_config(repo, git_default_config, NULL);
+
+	if (action == REF_ACTION_DEFAULT)
+		action = REF_ACTION_BRANCHES;
+
+	if (is_bare_repository()) {
+		ret = error(_("cannot run fixup in a bare repository"));
+		goto out;
+	}
+
+	/* Resolve the original commit, which is the one we want to fix up. */
+	original = lookup_commit_reference_by_name(argv[0]);
+	if (!original) {
+		ret = error(_("commit cannot be found: %s"), argv[0]);
+		goto out;
+	}
+
+	/*
+	 * Resolve HEAD so we can use its tree as the merge base: the staged
+	 * changes are expressed as a diff from HEAD's tree to the index tree.
+	 */
+	head_commit = lookup_commit_reference_by_name("HEAD");
+	if (!head_commit) {
+		ret = error(_("cannot look up HEAD"));
+		goto out;
+	}
+
+	head_tree = repo_get_commit_tree(repo, head_commit);
+	if (!head_tree) {
+		ret = error(_("cannot get tree for HEAD"));
+		goto out;
+	}
+
+	if (repo_read_index(repo) < 0) {
+		ret = error(_("unable to read index"));
+		goto out;
+	}
+
+	if (!repo_index_has_changes(repo, head_tree, NULL)) {
+		ret = error(_("nothing to fixup: no staged changes"));
+		goto out;
+	}
+
+	/*
+	 * Write the index as a tree object. This is the "theirs" side of the
+	 * three-way merge: it is HEAD's tree with the staged changes applied.
+	 */
+	index_tree = write_in_core_index_as_tree(repo, repo->index);
+	if (!index_tree) {
+		ret = error(_("unable to write index as a tree"));
+		goto out;
+	}
+
+	original_tree = repo_get_commit_tree(repo, original);
+	if (!original_tree) {
+		ret = error(_("cannot get tree for commit %s"), argv[0]);
+		goto out;
+	}
+
+	/*
+	 * Perform the three-way merge to reapply changes in the index onto the
+	 * target commit. This is using basically the same logic as a
+	 * cherry-pick, where the base commit is our HEAD, ours is the original
+	 * tree and theirs is the index tree.
+	 */
+	init_basic_merge_options(&merge_opts, repo);
+	merge_opts.ancestor = "HEAD";
+	merge_opts.branch1 = argv[0];
+	merge_opts.branch2 = "staged";
+	merge_incore_nonrecursive(&merge_opts, head_tree,
+				  original_tree, index_tree, &merge_result);
+
+	if (merge_result.clean < 0) {
+		ret = error(_("merge failed while applying fixup"));
+		goto out;
+	}
+
+	if (!merge_result.clean) {
+		ret = error(_("fixup would produce conflicts; aborting"));
+		goto out;
+	}
+
+	ret = setup_revwalk(repo, action, original, &revs);
+	if (ret)
+		goto out;
+
+	ret = commit_tree_ext(repo, "fixup", original, original->parents,
+			      &original_tree->object.oid, &merge_result.tree->object.oid,
+			      &rewritten, flags);
+	if (ret < 0) {
+		ret = error(_("failed writing fixed-up commit"));
+		goto out;
+	}
+
+	strbuf_addf(&reflog_msg, "fixup: updating %s", argv[0]);
+
+	ret = handle_reference_updates(&revs, action, original, rewritten,
+				       reflog_msg.buf, dry_run);
+	if (ret < 0) {
+		ret = error(_("failed replaying descendants"));
+		goto out;
+	}
+
+	ret = 0;
+
+out:
+	merge_finalize(&merge_opts, &merge_result);
+	strbuf_release(&reflog_msg);
+	release_revisions(&revs);
+	return ret;
+}
+
 static int cmd_history_reword(int argc,
 			      const char **argv,
 			      const char *prefix,
@@ -745,12 +896,14 @@ int cmd_history(int argc,
 		struct repository *repo)
 {
 	const char * const usage[] = {
+		GIT_HISTORY_FIXUP_USAGE,
 		GIT_HISTORY_REWORD_USAGE,
 		GIT_HISTORY_SPLIT_USAGE,
 		NULL,
 	};
 	parse_opt_subcommand_fn *fn = NULL;
 	struct option options[] = {
+		OPT_SUBCOMMAND("fixup", &fn, cmd_history_fixup),
 		OPT_SUBCOMMAND("reword", &fn, cmd_history_reword),
 		OPT_SUBCOMMAND("split", &fn, cmd_history_split),
 		OPT_END(),
diff --git a/t/meson.build b/t/meson.build
index 7528e5cda5..f502ad8ec9 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -397,6 +397,7 @@ integration_tests = [
   't3450-history.sh',
   't3451-history-reword.sh',
   't3452-history-split.sh',
+  't3453-history-fixup.sh',
   't3500-cherry.sh',
   't3501-revert-cherry-pick.sh',
   't3502-cherry-pick-merge.sh',
diff --git a/t/t3453-history-fixup.sh b/t/t3453-history-fixup.sh
new file mode 100755
index 0000000000..0012b1f052
--- /dev/null
+++ b/t/t3453-history-fixup.sh
@@ -0,0 +1,500 @@
+#!/bin/sh
+
+test_description='tests for git-history fixup subcommand'
+
+. ./test-lib.sh
+
+fixup_with_message () {
+	cat >message &&
+	write_script fake-editor.sh <<-\EOF &&
+	cp message "$1"
+	EOF
+	test_set_editor "$(pwd)"/fake-editor.sh &&
+	git history fixup --reedit-message "$@" &&
+	rm fake-editor.sh message
+}
+
+expect_changes () {
+	git log --format="%s" --numstat "$@" >actual.raw &&
+	sed '/^$/d' <actual.raw >actual &&
+	cat >expect &&
+	test_cmp expect actual
+}
+
+test_expect_success 'errors on missing commit argument' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit initial &&
+		test_must_fail git history fixup 2>err &&
+		test_grep "command expects a single revision" err
+	)
+'
+
+test_expect_success 'errors on too many arguments' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit initial &&
+		test_must_fail git history fixup HEAD HEAD 2>err &&
+		test_grep "command expects a single revision" err
+	)
+'
+
+test_expect_success 'errors on unknown revision' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit initial &&
+		test_must_fail git history fixup does-not-exist 2>err &&
+		test_grep "commit cannot be found: does-not-exist" err
+	)
+'
+
+test_expect_success 'errors when nothing is staged' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit initial &&
+		test_must_fail git history fixup HEAD 2>err &&
+		test_grep "nothing to fixup: no staged changes" err
+	)
+'
+
+test_expect_success 'errors in a bare repository' '
+	test_when_finished "rm -rf repo repo.git" &&
+	git init repo &&
+	test_commit -C repo initial &&
+	git clone --bare repo repo.git &&
+	test_must_fail git -C repo.git history fixup HEAD 2>err &&
+	test_grep "cannot run fixup in a bare repository" err
+'
+
+test_expect_success 'can fixup the tip commit' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit initial &&
+		echo content >file.txt &&
+		git add file.txt &&
+		git commit -m "add file" &&
+
+		echo fix >>file.txt &&
+		git add file.txt &&
+
+		expect_changes <<-\EOF &&
+		add file
+		1	0	file.txt
+		initial
+		1	0	initial.t
+		EOF
+
+		git symbolic-ref HEAD >branch-expect &&
+		git history fixup HEAD &&
+		git symbolic-ref HEAD >branch-actual &&
+		test_cmp branch-expect branch-actual &&
+
+		expect_changes <<-\EOF &&
+		add file
+		2	0	file.txt
+		initial
+		1	0	initial.t
+		EOF
+
+		# Verify the fix is in the tip commit tree
+		git show HEAD:file.txt >actual &&
+		printf "content\nfix\n" >expect &&
+		test_cmp expect actual &&
+
+		git reflog >reflog &&
+		test_grep "fixup: updating HEAD" reflog
+	)
+'
+
+test_expect_success 'can fixup a commit in the middle of history' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit first &&
+		echo content >file.txt &&
+		git add file.txt &&
+		git commit -m "add file" &&
+		test_commit third &&
+
+		echo fix >>file.txt &&
+		git add file.txt &&
+
+		expect_changes <<-\EOF &&
+		third
+		1	0	third.t
+		add file
+		1	0	file.txt
+		first
+		1	0	first.t
+		EOF
+
+		git history fixup HEAD~ &&
+
+		expect_changes <<-\EOF &&
+		third
+		1	0	third.t
+		add file
+		2	0	file.txt
+		first
+		1	0	first.t
+		EOF
+
+		# Verify the fix landed in the "add file" commit.
+		git show HEAD~:file.txt >actual &&
+		printf "content\nfix\n" >expect &&
+		test_cmp expect actual &&
+
+		# And verify that the replayed commit also has the change.
+		git show HEAD:file.txt >actual &&
+		printf "content\nfix\n" >expect &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'can fixup root commit' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		echo initial >root.txt &&
+		git add root.txt &&
+		git commit -m "root" &&
+		test_commit second &&
+
+		expect_changes <<-\EOF &&
+		second
+		1	0	second.t
+		root
+		1	0	root.txt
+		EOF
+
+		echo fix >>root.txt &&
+		git add root.txt &&
+		git history fixup HEAD~ &&
+
+		expect_changes <<-\EOF &&
+		second
+		1	0	second.t
+		root
+		2	0	root.txt
+		EOF
+
+		git show HEAD~:root.txt >actual &&
+		printf "initial\nfix\n" >expect &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'preserves commit message and authorship' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit initial &&
+		echo content >file.txt &&
+		git add file.txt &&
+		git commit --author="Original <original@example.com>" -m "original message" &&
+
+		echo fix >>file.txt &&
+		git add file.txt &&
+		git history fixup HEAD &&
+
+		# Message preserved
+		git log -1 --format="%s" >actual &&
+		echo "original message" >expect &&
+		test_cmp expect actual &&
+
+		# Authorship preserved
+		git log -1 --format="%an <%ae>" >actual &&
+		echo "Original <original@example.com>" >expect &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'updates all descendant branches by default' '
+	test_when_finished "rm -rf repo" &&
+	git init repo --initial-branch=main &&
+	(
+		cd repo &&
+		test_commit base &&
+		git branch branch &&
+		test_commit ours &&
+		git switch branch &&
+		test_commit theirs &&
+		git switch main &&
+
+		echo fix >fix.txt &&
+		git add fix.txt &&
+		git history fixup base &&
+
+		expect_changes --branches <<-\EOF &&
+		theirs
+		1	0	theirs.t
+		ours
+		1	0	ours.t
+		base
+		1	0	base.t
+		1	0	fix.txt
+		EOF
+
+		# Both branches should have the fix in the base
+		git show main~:fix.txt >actual &&
+		echo fix >expect &&
+		test_cmp expect actual &&
+		git show branch~:fix.txt >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'can fixup commit on a different branch' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit base &&
+		git branch theirs &&
+		test_commit ours &&
+		git switch theirs &&
+		test_commit theirs &&
+
+		# Stage a change while on "theirs"
+		echo fix >fix.txt &&
+		git add fix.txt &&
+
+		# Ensure that "ours" does not change, as it does not contain
+		# the commit in question.
+		git rev-parse ours >ours-before &&
+		git history fixup theirs &&
+		git rev-parse ours >ours-after &&
+		test_cmp ours-before ours-after &&
+
+		git show HEAD:fix.txt >actual &&
+		echo fix >expect &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success '--dry-run prints ref updates without modifying repo' '
+	test_when_finished "rm -rf repo" &&
+	git init repo --initial-branch=main &&
+	(
+		cd repo &&
+		test_commit base &&
+		git branch branch &&
+		test_commit main-tip &&
+		git switch branch &&
+		test_commit branch-tip &&
+		git switch main &&
+
+		echo fix >fix.txt &&
+		git add fix.txt &&
+
+		git refs list >refs-before &&
+		git history fixup --dry-run base >updates &&
+		git refs list >refs-after &&
+		test_cmp refs-before refs-after &&
+
+		test_grep "update refs/heads/main" updates &&
+		test_grep "update refs/heads/branch" updates &&
+
+		expect_changes --branches <<-\EOF &&
+		branch-tip
+		1	0	branch-tip.t
+		main-tip
+		1	0	main-tip.t
+		base
+		1	0	base.t
+		EOF
+
+		git update-ref --stdin <updates &&
+		expect_changes --branches <<-\EOF
+		branch-tip
+		1	0	branch-tip.t
+		main-tip
+		1	0	main-tip.t
+		base
+		1	0	base.t
+		1	0	fix.txt
+		EOF
+	)
+'
+
+test_expect_success '--update-refs=head updates only HEAD' '
+	test_when_finished "rm -rf repo" &&
+	git init repo --initial-branch=main &&
+	(
+		cd repo &&
+		test_commit base &&
+		git branch branch &&
+		test_commit main-tip &&
+		git switch branch &&
+		test_commit branch-tip &&
+
+		echo fix >fix.txt &&
+		git add fix.txt &&
+
+		# Only HEAD (branch) should be updated
+		git history fixup --update-refs=head base &&
+
+		# The main branch should be unaffected.
+		expect_changes main <<-\EOF &&
+		main-tip
+		1	0	main-tip.t
+		base
+		1	0	base.t
+		EOF
+
+		# But the currently checked out branch should be modified.
+		expect_changes branch <<-\EOF
+		branch-tip
+		1	0	branch-tip.t
+		base
+		1	0	base.t
+		1	0	fix.txt
+		EOF
+	)
+'
+
+test_expect_success '--update-refs=head refuses to rewrite commits not in HEAD ancestry' '
+	test_when_finished "rm -rf repo" &&
+	git init repo --initial-branch=main &&
+	(
+		cd repo &&
+		test_commit base &&
+		git branch other &&
+		test_commit main-tip &&
+		git switch other &&
+		test_commit other-tip &&
+
+		echo fix >fix.txt &&
+		git add fix.txt &&
+
+		test_must_fail git history fixup --update-refs=head main-tip 2>err &&
+		test_grep "rewritten commit must be an ancestor of HEAD" err
+	)
+'
+
+test_expect_success 'aborts when fixup would produce conflicts' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		echo "line one" >file.txt &&
+		git add file.txt &&
+		git commit -m "first" &&
+
+		echo "line two" >file.txt &&
+		git add file.txt &&
+		git commit -m "second" &&
+
+		echo "conflicting change" >file.txt &&
+		git add file.txt &&
+
+		git refs list >refs-before &&
+		test_must_fail git history fixup HEAD~ 2>err &&
+		test_grep "fixup would produce conflicts" err &&
+		git refs list >refs-after &&
+		test_cmp refs-before refs-after
+	)
+'
+
+test_expect_success '--reedit-message opens editor for the commit message' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit initial &&
+		echo content >file.txt &&
+		git add file.txt &&
+		git commit -m "add file" &&
+
+		echo fix >>file.txt &&
+		git add file.txt &&
+
+		fixup_with_message HEAD <<-\EOF &&
+		add file with fix
+		EOF
+
+		expect_changes --branches <<-\EOF
+		add file with fix
+		2	0	file.txt
+		initial
+		1	0	initial.t
+		EOF
+	)
+'
+
+test_expect_success 'retains unstaged working tree changes after fixup' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		touch a b &&
+		git add . &&
+		git commit -m "initial commit" &&
+		echo staged >a &&
+		echo unstaged >b &&
+		git add a &&
+		git history fixup HEAD &&
+
+		# b is still modified in the worktree but not staged
+		cat >expect <<-\EOF &&
+		 M b
+		EOF
+		git status --porcelain --untracked-files=no >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'index is clean after fixup when target is HEAD' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		test_commit initial &&
+		echo fix >fix.txt &&
+		git add fix.txt &&
+		git history fixup HEAD &&
+
+		git status --porcelain --untracked-files=no >actual &&
+		test_must_be_empty actual
+	)
+'
+
+test_expect_success 'index is unchanged on conflict' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		echo base >file.txt &&
+		git add file.txt &&
+		git commit -m base &&
+		echo change >file.txt &&
+		git add file.txt &&
+		git commit -m change &&
+
+		echo conflict >file.txt &&
+		git add file.txt &&
+
+		git diff --cached >index-before &&
+		test_must_fail git history fixup HEAD~ &&
+		git diff --cached >index-after &&
+		test_cmp index-before index-after
+	)
+'
+
+test_done

-- 
2.54.0.545.g6539524ca2.dirty

