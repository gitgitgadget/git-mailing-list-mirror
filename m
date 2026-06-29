Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6416F346A08
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 07:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782718511; cv=none; b=uXxvLekeWGwIsdPh92iTHe47T8OKAL2PA4v297MOfMyEDyuTpKH5+VLNPirvpElvxh+doG3o8TBm9pbtb9uDgVoaJg8kEy2VMEHwNJB2tZmGXUcLamm3QxBQ8CsP/xxXbqPN3ZNssTpb5Vg9HW11nflwSZEPIrM1mgXn22zzDJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782718511; c=relaxed/simple;
	bh=MUialoVpm0FzvgbX2Ha6bzFlgdrgmyCxAmxR8n1vPDw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nZZ3VcFQm3qpa051CxYkOU+jBEAtWDX105ATiWplunDxEYwXlGiIEDjxnVkfBC5lgi7xN6dJ5NeqbleDZXdHxzyjhaTDlenenueTsmJpd49okucqdoQX2KepeLVz6OYygCLgjtf2K1FXty01XLi2Ytitst+eT1O/3eKk249FUeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pWzLLxpY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GbdqN0hz; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pWzLLxpY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GbdqN0hz"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4A7107A0097;
	Mon, 29 Jun 2026 03:35:04 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 29 Jun 2026 03:35:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782718504;
	 x=1782804904; bh=a1rzvbMeaDs3+AxfNtt0jI/Sm85ZWqawRga0cbsGtO4=; b=
	pWzLLxpYzstB57l42SskczjpcWRRITK1KLGb3KFw8CDt0E9SAoxVSiosYBH8mKZZ
	+KVwR8KDFJ9jLrZKhpyr4K6ekmTEYCa4LAL8VzNeKTXLLk0nfNqNJknfvDz4m6Tj
	ebKbfewQ31PENcNWgydv7uczieiR4LoIfnqJ9a/Q7sp0KASTtYVBGjnVtcxjk9Ai
	hrkH0ZpteXZwyGI/bAOO6ScgpGFaw7fS6MuwgeleDvcisVqUoz4RtuhgBj70cpBt
	JOxrRRSx84SOk9DS0sjjx7hZ90rxpRaRQ80NkuP7gfz8wk+/aQ4A/FUHhsgxgIaB
	42iFhX9248nIsvofNAypyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782718504; x=
	1782804904; bh=a1rzvbMeaDs3+AxfNtt0jI/Sm85ZWqawRga0cbsGtO4=; b=G
	bdqN0hzP2x00059xx9Tj8+weiLjp//z1wtaTeWs789svMbhgS7vwil+3hHbFK6tK
	4lwKytyKIocn7A70YJUwPHXffWVzl9AxabbEUspyO8ZhIAJWhF1SHiWhgSS9nQB3
	8GbYxwHBr3shhf4X9TLKwwBP5MSJT1TEJolfJkCeKP5xaidGY/oOa8jR+F1Ov1vN
	TKYHOkzZtbuSRJ8YOEYRoN5VyJNHFdTLOVJQcpUJgsfxqfCwW+HksMyrlYbwZ40X
	SSRtIK7rcBQmm/1KBALwXtRWWqjzlCe/eukRKJ1An8ZB6bqhltvCGhU5LjjU71M2
	H2m5YfqmBJ/IM8eApRQFA==
X-ME-Sender: <xms:KCBCavPIgIKR9oba_CUZLqsgU62tnIus7TjG208i-MhSn5T42Te5Pg>
    <xme:KCBCajRRUSPtXmJHjiUULAbzgZbdpEYuZOWKBUW6s96mfi2w7Y3Tmct8fwH45GDQU
    -3V98AfIgvenyH1H_brhIx99_sYyndIcpxDSdK7-LenUy7upk3qPA>
X-ME-Received: <xmr:KCBCalga-nJQNfHfU2HXpX4wQxd2jiPs8ligAYZ-MM3iZacKS9pG1gNLANzI89d4I99qujyTGr-2aqFoQh56mR-Zau6ZRgh99SlA75dT-ckP>
X-ME-Proxy-Cause: dmFkZTGyeEoCWn7oQXRqvXJ+bZxqIqTOL3S2E+ymddnZRMCuoZMnTBxNPTv9FU3ZAKsmUf
    ymQbU2pqB2KDag7KXpZrBGyv7GvTf+bGtnVa5JkStbvlDnokm3PPFo3+F8WRY1Xq5PQTjl
    5nBGGt+5sgrYColnDD6Fad/NeqXia+f2fbrsrCPrXoz4qCIsKxE+7ci9IwmrimiQtiCN3x
    GAqyqRqT54B2oBUushVHBhpxPfe5S3D+nwMHupIaWrMiQ8TkTYxAoVjBHvOQ40nESn/V8v
    j80K3/FcizHzQzksg/aACPBBo9g+wRu8istcnQg4mEYs63vhILvKYFnCH7ZIURDepEfSCa
    Rhd1Y8gXA/LbchtqXzoMpCnGIce9t7K3LaEUSvKX627iHsV3mWfro6a7vxKDOZMBNDM7cr
    M6WMIrT3XToNqRWR1YBhbMabbfCXBi7FiqogabEv28EltN5SFwm4ixPQwvLYXrZyzg4pg+
    AIRWlV36jJnHi54WxmrdbrbkM1HZLCQo0S9n+thEm1/GHR9YK9n815LudlS0b78RYMeKiy
    kfi3oqV7I2U2NLku8CmCKN7rDabyCtVB1bB6h+zY6pBCsF7NYYjjeT4iV8py4rfNLJEB+Y
    qJGTBBll55sSgfKE2ZR3Nv/aCKbF8z+oPYcJukTByKMwmJB9RYnmsKlIo/kg
X-ME-Proxy: <xmx:KCBCak9meNDHPRt926hWSt2tmoVX05JsoTc5yZ7kThU5hHSfDCM8Dg>
    <xmx:KCBCakEAC9AdaaBUPYj9MW88g-z7de0CFEmsfLIRXgaN7f6WU46fBA>
    <xmx:KCBCavmFow-CNuhHQnDxBfAYSFpDeTevOToIi7ZWjQiAhJIoA3of-w>
    <xmx:KCBCagadze1i3n6e-UXERnL-CQi_lb-8JQhZ3irPkp7pdfQz2pvpnA>
    <xmx:KCBCaiGIuMX1HeIbt1OEBUJKZfI2Yq5N4LvQX9UcZcGoP5nDBGknTAKE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 03:35:00 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8786add9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 29 Jun 2026 07:35:00 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 29 Jun 2026 09:34:37 +0200
Subject: [PATCH v7 11/11] builtin/history: implement "drop" subcommand
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-b4-pks-history-drop-v7-11-6e9392a957d8@pks.im>
References: <20260629-b4-pks-history-drop-v7-0-6e9392a957d8@pks.im>
In-Reply-To: <20260629-b4-pks-history-drop-v7-0-6e9392a957d8@pks.im>
To: git@vger.kernel.org
Cc: Pablo Sabater <pabloosabaterr@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.15.2

A common operation when editing the commit history is to drop a specific
commit from the history entirely, but this operation is not currently
covered by git-history(1).

A couple of noteworthy bits:

  - This is the first git-history(1) command that will ultimately result
    in changes to both the index and the working tree. We thus have to
    add logic to merge resulting changes into those.

  - It is still not possible to replay merge commits, so this limitation
    is inherited for the new "drop" command.

  - For now we refuse to drop root commits. While we _can_ indeed drop
    root commits in the general case, there are edge cases where the
    resulting history would become completely empty. This is thus left
    to a subsequent patch series.

Other than that, most of the logic is rather straight-forward as we can
continue to build on the preexisting logic in git-history(1) for most of
the part.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-history.adoc |  38 ++-
 builtin/history.c              | 186 ++++++++++++++
 t/meson.build                  |   1 +
 t/t3454-history-drop.sh        | 537 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 761 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-history.adoc b/Documentation/git-history.adoc
index 2ba8121795..28b477cd37 100644
--- a/Documentation/git-history.adoc
+++ b/Documentation/git-history.adoc
@@ -8,6 +8,7 @@ git-history - EXPERIMENTAL: Rewrite history
 SYNOPSIS
 --------
 [synopsis]
+git history drop <commit> [--dry-run] [--update-refs=(branches|head)] [--empty=(drop|keep|abort)]
 git history fixup <commit> [--dry-run] [--update-refs=(branches|head)] [--reedit-message] [--empty=(drop|keep|abort)]
 git history reword <commit> [--dry-run] [--update-refs=(branches|head)]
 git history split <commit> [--dry-run] [--update-refs=(branches|head)] [--] [<pathspec>...]
@@ -51,13 +52,28 @@ be stateful operations. The limitation can be lifted once (if) Git learns about
 first-class conflicts.
 
 When using `fixup` with `--empty=drop`, dropping the root commit is not yet
-supported.
+supported. Likewise, `drop` cannot remove the root commit or a merge commit.
 
 COMMANDS
 --------
 
 The following commands are available to rewrite history in different ways:
 
+`drop <commit>`::
+	Remove the specified commit from the history. All descendants of the
+	commit are replayed directly onto its parent.
++
+The root commit cannot be dropped as that may lead to edge cases where refs
+end up with no commits anymore. Merge commits cannot be dropped either; see
+LIMITATIONS.
++
+If `HEAD` points at a commit that is to be rewritten, the index and working
+tree are updated to match the new `HEAD`. The command aborts before any
+references are updated in case local modifications would be overwritten.
++
+If replaying any descendant would result in a conflict, the command aborts
+with an error.
+
 `fixup <commit>`::
 	Apply the currently staged changes to the specified commit. This is
 	similar in nature to `git commit --fixup=<commit>` followed by `git
@@ -170,6 +186,26 @@ The staged addition of `unrelated.txt` has been incorporated into the `first`
 commit. All descendant commits have been replayed on top of the rewritten
 history.
 
+Drop a commit
+~~~~~~~~~~~~~
+
+----------
+$ git log --oneline
+abc1234 (HEAD -> main) third
+def5678 second
+ghi9012 first
+
+$ git history drop 'main^{/second}'
+
+$ git log --oneline
+jkl3456 (HEAD -> main) third
+ghi9012 first
+----------
+
+The `second` commit has been removed from the history, and `third` has been
+replayed directly on top of `first`. All branches that pointed at the dropped
+commit have been moved to its parent.
+
 Split a commit
 ~~~~~~~~~~~~~~
 
diff --git a/builtin/history.c b/builtin/history.c
index 22b9fcb4a4..7944207f38 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -17,13 +17,17 @@
 #include "read-cache.h"
 #include "refs.h"
 #include "replay.h"
+#include "reset.h"
 #include "revision.h"
 #include "sequencer.h"
 #include "strvec.h"
 #include "tree.h"
+#include "tree-walk.h"
 #include "unpack-trees.h"
 #include "wt-status.h"
 
+#define GIT_HISTORY_DROP_USAGE \
+	N_("git history drop <commit> [--dry-run] [--update-refs=(branches|head)] [--empty=(drop|keep|abort)]")
 #define GIT_HISTORY_FIXUP_USAGE \
 	N_("git history fixup <commit> [--dry-run] [--update-refs=(branches|head)] [--reedit-message] [--empty=(drop|keep|abort)]")
 #define GIT_HISTORY_REWORD_USAGE \
@@ -999,12 +1003,193 @@ static int cmd_history_split(int argc,
 	return ret;
 }
 
+static int update_worktree(struct repository *repo,
+			   const struct commit *old_head,
+			   const struct commit *new_head,
+			   bool dry_run)
+{
+	struct reset_working_tree_options opts = {
+		.oid_from = &old_head->object.oid,
+		.oid = &new_head->object.oid,
+	};
+	if (dry_run)
+		opts.flags |= RESET_WORKING_TREE_DRY_RUN;
+	return reset_working_tree(repo, &opts);
+}
+
+static int find_head_tree_change(struct repository *repo,
+				 const struct replay_result *result,
+				 struct commit **old_head,
+				 struct commit **new_head,
+				 bool *changed)
+{
+	const struct replay_ref_update *head_update = NULL;
+	struct commit *old_head_commit, *new_head_commit;
+	struct tree *old_head_tree, *new_head_tree;
+	const char *head_target;
+	int head_flags;
+
+	*changed = false;
+
+	head_target = refs_resolve_ref_unsafe(get_main_ref_store(repo),
+					      "HEAD", RESOLVE_REF_NO_RECURSE,
+					      NULL, &head_flags);
+	if (!head_target)
+		return error(_("cannot look up HEAD"));
+	if (!(head_flags & REF_ISSYMREF))
+		head_target = "HEAD";
+
+	for (size_t i = 0; i < result->updates_nr; i++) {
+		if (!strcmp(result->updates[i].refname, head_target)) {
+			head_update = &result->updates[i];
+			break;
+		}
+	}
+
+	if (!head_update)
+		return 0;
+
+	old_head_commit = lookup_commit_reference(repo, &head_update->old_oid);
+	new_head_commit = lookup_commit_reference(repo, &head_update->new_oid);
+	if (!old_head_commit || !new_head_commit)
+		return error(_("cannot resolve HEAD commit"));
+
+	old_head_tree = repo_get_commit_tree(repo, old_head_commit);
+	new_head_tree = repo_get_commit_tree(repo, new_head_commit);
+	if (!old_head_tree || !new_head_tree)
+		return error(_("cannot resolve tree for HEAD"));
+
+	if (oideq(&old_head_tree->object.oid, &new_head_tree->object.oid))
+		return 0;
+
+	*old_head = old_head_commit;
+	*new_head = new_head_commit;
+	*changed = true;
+
+	return 0;
+}
+
+static int cmd_history_drop(int argc,
+			    const char **argv,
+			    const char *prefix,
+			    struct repository *repo)
+{
+	const char * const usage[] = {
+		GIT_HISTORY_DROP_USAGE,
+		NULL,
+	};
+	enum replay_empty_commit_action empty = REPLAY_EMPTY_COMMIT_DROP;
+	enum ref_action action = REF_ACTION_DEFAULT;
+	int dry_run = 0;
+	struct option options[] = {
+		OPT_CALLBACK_F(0, "update-refs", &action, "(branches|head)",
+			       N_("control which refs should be updated"),
+			       PARSE_OPT_NONEG, parse_ref_action),
+		OPT_BOOL('n', "dry-run", &dry_run,
+			 N_("perform a dry-run without updating any refs")),
+		OPT_CALLBACK_F(0, "empty", &empty, "(drop|keep|abort)",
+			       N_("how to handle descendants that become empty"),
+			       PARSE_OPT_NONEG, parse_opt_empty),
+		OPT_END(),
+	};
+	struct strbuf reflog_msg = STRBUF_INIT;
+	struct commit *original, *rewritten;
+	struct rev_info revs = { 0 };
+	struct replay_result result = { 0 };
+	struct commit *old_head, *new_head;
+	bool head_moves = false;
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
+	original = lookup_commit_reference_by_name(argv[0]);
+	if (!original) {
+		ret = error(_("commit cannot be found: %s"), argv[0]);
+		goto out;
+	}
+
+	if (!original->parents) {
+		ret = error(_("cannot drop root commit %s: "
+			      "it has no parent to replay onto"),
+			    argv[0]);
+		goto out;
+	} else if (original->parents->next) {
+		ret = error(_("cannot drop merge commit: %s"), argv[0]);
+		goto out;
+	}
+
+	ret = setup_revwalk(repo, action, original, &revs);
+	if (ret)
+		goto out;
+
+	rewritten = original->parents->item;
+
+	ret = compute_pending_ref_updates(&revs, action, original, rewritten,
+					  empty, &result);
+	if (ret) {
+		ret = error(_("failed replaying descendants"));
+		goto out;
+	}
+
+	/*
+	 * If HEAD will move as a result of the rewrite then we'll have to
+	 * merge in the changes into the worktree and index. This merge can of
+	 * course conflict, which will cause the whole operation to abort.
+	 *
+	 * If we had already updated the refs at that point then we'd have an
+	 * inconsistent repository state. So we first perform a dry-run merge
+	 * here before updating refs.
+	 */
+	if (!is_bare_repository()) {
+		ret = find_head_tree_change(repo, &result, &old_head,
+					    &new_head, &head_moves);
+		if (ret < 0)
+			goto out;
+
+		if (head_moves && update_worktree(repo, old_head, new_head, true) < 0) {
+			ret = error(_("dropping this commit would "
+				      "overwrite local changes; aborting"));
+			goto out;
+		}
+	}
+
+	strbuf_addf(&reflog_msg, "drop: dropping %s", argv[0]);
+	ret = apply_pending_ref_updates(repo, &result, reflog_msg.buf, dry_run);
+	if (ret < 0) {
+		ret = error(_("failed to update references"));
+		goto out;
+	}
+
+	if (!dry_run && head_moves && update_worktree(repo, old_head, new_head, false) < 0) {
+		ret = error(_("could not update working tree to new commit %s"),
+			    oid_to_hex(&new_head->object.oid));
+		goto out;
+	}
+
+	ret = 0;
+
+out:
+	replay_result_release(&result);
+	strbuf_release(&reflog_msg);
+	release_revisions(&revs);
+	return ret;
+}
+
 int cmd_history(int argc,
 		const char **argv,
 		const char *prefix,
 		struct repository *repo)
 {
 	const char * const usage[] = {
+		GIT_HISTORY_DROP_USAGE,
 		GIT_HISTORY_FIXUP_USAGE,
 		GIT_HISTORY_REWORD_USAGE,
 		GIT_HISTORY_SPLIT_USAGE,
@@ -1012,6 +1197,7 @@ int cmd_history(int argc,
 	};
 	parse_opt_subcommand_fn *fn = NULL;
 	struct option options[] = {
+		OPT_SUBCOMMAND("drop", &fn, cmd_history_drop),
 		OPT_SUBCOMMAND("fixup", &fn, cmd_history_fixup),
 		OPT_SUBCOMMAND("reword", &fn, cmd_history_reword),
 		OPT_SUBCOMMAND("split", &fn, cmd_history_split),
diff --git a/t/meson.build b/t/meson.build
index 2af8d01279..d5e71056b2 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -399,6 +399,7 @@ integration_tests = [
   't3451-history-reword.sh',
   't3452-history-split.sh',
   't3453-history-fixup.sh',
+  't3454-history-drop.sh',
   't3500-cherry.sh',
   't3501-revert-cherry-pick.sh',
   't3502-cherry-pick-merge.sh',
diff --git a/t/t3454-history-drop.sh b/t/t3454-history-drop.sh
new file mode 100755
index 0000000000..0f33247212
--- /dev/null
+++ b/t/t3454-history-drop.sh
@@ -0,0 +1,537 @@
+#!/bin/sh
+
+test_description='tests for git-history drop subcommand'
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY/lib-log-graph.sh"
+
+expect_graph () {
+	cat >expect &&
+	lib_test_cmp_graph --format=%s "$@"
+}
+
+expect_log () {
+	git log --format="%s" "$@" >actual &&
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
+		test_must_fail git history drop 2>err &&
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
+		test_must_fail git history drop HEAD HEAD 2>err &&
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
+		test_must_fail git history drop does-not-exist 2>err &&
+		test_grep "commit cannot be found: does-not-exist" err
+	)
+'
+
+test_expect_success 'errors with invalid --empty= value' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit initial &&
+		test_commit second &&
+		test_must_fail git history drop --empty=bogus HEAD 2>err &&
+		test_grep "unrecognized.*--empty.*bogus" err
+	)
+'
+
+test_expect_success 'drops a commit in the middle and replays descendants' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit first &&
+		test_commit second &&
+		test_commit third &&
+
+		git symbolic-ref HEAD >expect &&
+		git history drop HEAD~ &&
+		git symbolic-ref HEAD >actual &&
+		test_cmp expect actual &&
+
+		expect_log <<-\EOF &&
+		third
+		first
+		EOF
+
+		test_must_fail git show HEAD:second.t &&
+		test_path_is_missing second.t &&
+
+		git reflog >reflog &&
+		test_grep "drop: dropping HEAD~" reflog
+	)
+'
+
+test_expect_success 'drops the HEAD commit' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit first &&
+		test_commit second &&
+
+		git history drop HEAD &&
+
+		expect_log <<-\EOF
+		first
+		EOF
+	)
+'
+
+test_expect_success 'drops a commit on detached HEAD' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit first &&
+		test_commit second &&
+		test_commit third &&
+		git checkout --detach HEAD &&
+
+		git history drop HEAD~ &&
+
+		expect_log <<-\EOF
+		third
+		first
+		EOF
+	)
+'
+
+# Note: in this case it would actually be fine to drop the root commit, as we
+# do have a descendant commit, and no reference points to the root commit
+# directly. So this is something that we may relax eventually.
+test_expect_success 'refuses to drop the root commit' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit first &&
+		test_commit second &&
+
+		test_must_fail git history drop HEAD~ 2>err &&
+		test_grep "cannot drop root commit" err
+	)
+'
+
+# In contrast to the above case, we actually don't want to drop the root commit
+# here as that would cause us to end up with an empty commit graph.
+test_expect_success 'refuses to drop the root commit when branch becomes empty' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit first &&
+
+		test_must_fail git history drop HEAD 2>err &&
+		test_grep "cannot drop root commit" err
+	)
+'
+
+test_expect_success 'refuses to drop a merge commit' '
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
+
+		test_must_fail git history drop HEAD 2>err &&
+		test_grep "cannot drop merge commit" err
+	)
+'
+
+test_expect_success 'refuses when descendants contain a merge commit' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit base &&
+		test_commit middle &&
+		git branch branch &&
+		test_commit ours &&
+		git switch branch &&
+		test_commit theirs &&
+		git switch - &&
+		git merge theirs &&
+
+		test_must_fail git history drop middle 2>err &&
+		test_grep "replaying merge commits is not supported yet" err
+	)
+'
+
+test_expect_success 'works in a bare repository' '
+	test_when_finished "rm -rf repo repo.git" &&
+
+	git init repo &&
+	test_commit -C repo first &&
+	test_commit -C repo second &&
+	test_commit -C repo third &&
+
+	git clone --bare repo repo.git &&
+	(
+		cd repo.git &&
+
+		git history drop HEAD~ &&
+		expect_log <<-\EOF
+		third
+		first
+		EOF
+	)
+'
+
+test_expect_success 'updates branches on other lines of descent' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit base &&
+		test_commit target &&
+		git branch theirs &&
+		test_commit ours &&
+		git switch theirs &&
+		test_commit theirs &&
+
+		expect_graph --branches <<-\EOF &&
+		* theirs
+		| * ours
+		|/
+		* target
+		* base
+		EOF
+
+		git history drop target &&
+
+		expect_graph --branches <<-\EOF
+		* ours
+		| * theirs
+		|/
+		* base
+		EOF
+	)
+'
+
+test_expect_success 'moves branch pointing at dropped commit to its parent' '
+	test_when_finished "rm -rf repo" &&
+	git init repo --initial-branch=main &&
+	(
+		cd repo &&
+		test_commit first &&
+		test_commit second &&
+		git branch points-at-second &&
+		test_commit third &&
+
+		git rev-parse first >expect &&
+		git history drop second &&
+		git rev-parse points-at-second >actual &&
+		test_cmp expect actual &&
+
+		expect_log --format="%s %D" --branches <<-\EOF
+		third HEAD -> main
+		first tag: first, points-at-second
+		EOF
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
+		test_commit middle &&
+		test_commit ours &&
+		git switch branch &&
+		test_commit theirs &&
+
+		git refs list >refs-expect &&
+		git history drop --dry-run main~ >updates &&
+		git refs list >refs-actual &&
+		test_cmp refs-expect refs-actual &&
+		test_grep "update refs/heads/main" updates &&
+
+		git update-ref --stdin <updates &&
+		expect_log main <<-\EOF
+		ours
+		base
+		EOF
+	)
+'
+
+test_expect_success '--dry-run detects conflicts with modified working tree' '
+	test_when_finished "rm -rf repo" &&
+	git init repo --initial-branch=main &&
+	(
+		cd repo &&
+		test_commit first &&
+		test_commit second modify-me &&
+		echo modified >modify-me &&
+
+		git refs list >refs-expect &&
+		git diff >diff-expect &&
+		test_must_fail git history drop --dry-run HEAD 2>err &&
+		test_grep "dropping this commit would overwrite local changes" err &&
+		git diff >diff-actual &&
+		git refs list >refs-actual &&
+
+		test_cmp diff-expect diff-actual &&
+		test_cmp refs-expect refs-actual
+	)
+'
+
+test_expect_success '--update-refs=head updates only HEAD' '
+	test_when_finished "rm -rf repo" &&
+	git init repo --initial-branch=main &&
+	(
+		cd repo &&
+		test_commit base &&
+		test_commit target &&
+		git branch theirs &&
+		test_commit ours &&
+		git switch theirs &&
+		test_commit theirs &&
+
+		# When told to update HEAD only, the command refuses to
+		# rewrite commits that are not an ancestor of HEAD.
+		test_must_fail git history drop --update-refs=head main 2>err &&
+		test_grep "rewritten commit must be an ancestor of HEAD" err &&
+
+		expect_graph --branches <<-\EOF &&
+		* theirs
+		| * ours
+		|/
+		* target
+		* base
+		EOF
+
+		git switch main &&
+		git history drop --update-refs=head target &&
+
+		expect_graph --branches <<-\EOF
+		* ours
+		| * theirs
+		| * target
+		|/
+		* base
+		EOF
+	)
+'
+
+test_expect_success 'conflict with replayed commit aborts cleanly' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit base &&
+		test_commit conflict-a file &&
+		test_commit conflict-b file &&
+
+		git refs list >refs-expect &&
+		test_must_fail git history drop HEAD~ 2>err &&
+		test_grep "failed replaying descendants" err &&
+		git refs list >refs-actual &&
+		test_cmp refs-expect refs-actual
+	)
+'
+
+# Build a history where a descendant of the drop target reverts the change
+# introduced by the drop target. After dropping, the descendant's diff applies
+# against a tree that already lacks the change, so it becomes empty.
+setup_empty_descendant_repo () {
+	git init "$1" &&
+	(
+		cd "$1" &&
+		echo C1 >file &&
+		git add file &&
+		git commit -m "base" &&
+		git tag base &&
+		echo C2 >file &&
+		git add file &&
+		git commit -m "drop-me" &&
+		git tag drop-me &&
+		test_commit middle &&
+		echo C1 >file &&
+		git add file &&
+		git commit -m "revert-drop-me" &&
+		git tag revert-drop-me
+	)
+}
+
+test_expect_success '--empty=drop drops descendants that become empty' '
+	test_when_finished "rm -rf repo" &&
+	setup_empty_descendant_repo repo &&
+	(
+		cd repo &&
+
+		git history drop --empty=drop drop-me &&
+
+		expect_log <<-\EOF
+		middle
+		base
+		EOF
+	)
+'
+
+test_expect_success '--empty=keep keeps descendants that become empty' '
+	test_when_finished "rm -rf repo" &&
+	setup_empty_descendant_repo repo &&
+	(
+		cd repo &&
+
+		git history drop --empty=keep drop-me &&
+
+		expect_log <<-\EOF &&
+		revert-drop-me
+		middle
+		base
+		EOF
+		git diff HEAD~ HEAD >diff &&
+		test_must_be_empty diff
+	)
+'
+
+test_expect_success '--empty=abort errors out when a descendant becomes empty' '
+	test_when_finished "rm -rf repo" &&
+	setup_empty_descendant_repo repo &&
+	(
+		cd repo &&
+
+		test_must_fail git history drop --empty=abort drop-me 2>err &&
+		test_grep "became empty after replay" err
+	)
+'
+
+test_expect_success 'updates index and worktree when HEAD moves' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit first &&
+		test_commit second &&
+		test_commit third &&
+
+		git history drop second &&
+
+		# Worktree should no longer contain second.t.
+		test_path_is_missing second.t &&
+		test_path_is_file first.t &&
+		test_path_is_file third.t &&
+
+		# Index and worktree should both match the new HEAD.
+		git status --porcelain --untracked-files=no >status &&
+		test_must_be_empty status
+	)
+'
+
+test_expect_success 'updates worktree when dropping HEAD itself' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit first &&
+		test_commit second &&
+
+		git history drop HEAD &&
+
+		test_path_is_missing second.t &&
+		test_path_is_file first.t &&
+
+		git status --porcelain --untracked-files=no >status &&
+		test_must_be_empty status
+	)
+'
+
+test_expect_success 'preserves unrelated unstaged modifications' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit first &&
+		echo first-content >unrelated.txt &&
+		git add unrelated.txt &&
+		git commit -m "add unrelated" &&
+		test_commit second &&
+		test_commit third &&
+
+		echo locally-modified >unrelated.txt &&
+
+		git diff >diff-expect &&
+		git history drop second &&
+		git diff >diff-actual &&
+		test_cmp diff-expect diff-actual &&
+		test_path_is_missing second.t
+	)
+'
+
+test_expect_success 'preserves unrelated staged changes' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit first &&
+		echo first-content >unrelated.txt &&
+		git add unrelated.txt &&
+		git commit -m "add unrelated" &&
+		test_commit second &&
+		test_commit third &&
+
+		echo staged-change >unrelated.txt &&
+		git add unrelated.txt &&
+
+		git diff --cached >diff-expect &&
+		git history drop second &&
+		git diff --cached >diff-actual &&
+		test_cmp diff-expect diff-actual &&
+		test_path_is_missing second.t
+	)
+'
+
+test_expect_success 'aborts when local modifications would be overwritten' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit base &&
+		test_commit conflict &&
+
+		echo local-edit >conflict.t &&
+		git diff >diff-expect &&
+		test_must_fail git history drop HEAD 2>err &&
+		test_grep "would overwrite local changes" err &&
+		git diff >diff-actual &&
+		test_cmp diff-expect diff-actual
+	)
+'
+
+test_done

-- 
2.55.0.rc2.803.g1fd1e6609c.dirty

