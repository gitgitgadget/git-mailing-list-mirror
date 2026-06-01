Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6630A25B082
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 15:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780328194; cv=none; b=PeIa2HjyZVvOBzVX/1ZIrYfomA6ogLXj4DxOOt5D8scokspKvmnvdtj4BfBKp4T9Pcvd4pysYGhoUEqJ2YDkr6dvL9qp2Hw8yh2WTyCLvgTLNBy2+nxh2nhYrGj3jB47Kpz//Mgh7GTjFH4hDQO0iBoPYdBpPCAoOFipB7LY230=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780328194; c=relaxed/simple;
	bh=6/gX9QbUwrnMD/nO9sP4typZxnOCN1jfOL7smNDPKSg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F1KMwq1tlBCaASa//jfySEK3Ztnd5e3BmN3wC4clEbaLSwpGWNOafNcshKpUVkboWaiMBpHaO6K0dunDNpNnTwRRUocBSpJrusxCEAc6aG3r+57XOX604uRUtg4hXyRL6O0KFYOaEt0QHEA+N6ZvAiJJVbbKGO52jJKCa+y4WHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ujisuyTr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MiDDNkC7; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ujisuyTr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MiDDNkC7"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id ACB431400108
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 11:36:31 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 01 Jun 2026 11:36:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780328191;
	 x=1780414591; bh=GxiDiy7d5sTHVgNvC0wxQt43FIpz+upkBpf9ZWJA1QQ=; b=
	ujisuyTr7Fywj9QtQFKAmLUXdEjY+MlH/8Ex8BdkOiLr0Z1iniscR44A2dgP/vqu
	7BK2gNXQh+FNzzeyAwXY8gtu/8iR7fH9gy5NHv3ZxeShVsOVfPFWThh4ytNGVXZb
	rhD+YnoqVpePnBs7H7pMlTpFsaNXWg+Upr28D8buF65l8s7gXVWrn845FEUrxFq5
	7cybj+rwBAMtehwJD4R+jSPMWo+x+aYzMU0NHs6fjFB9bRJzQ54s2OXHRIiNYkhv
	F/tPUWKoRW/TrXJ8P4VY7LaKiJXtLe0YfCPnVtEcUNm9dlq+PQ7ZfvZT6B7z4YGs
	M7Y6zlwxieKMQAHifOZ+xQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780328191; x=
	1780414591; bh=GxiDiy7d5sTHVgNvC0wxQt43FIpz+upkBpf9ZWJA1QQ=; b=M
	iDDNkC758YgNPTjchHoV5ttlpbdn+uncTAUy+78wEZpkdkfQv8QiO8JZwna1GbTF
	XjldNmedr6+CITUYAwfD35x0MGZshw2APHvXz6m6NVKvkUZR8pVxYYFQgKcj9/+9
	G2ulWf+ElH6YSFnEc9QJ0+H81XonRBTM3UODk985wzW5bAgKzfKXKomXPtGo1Nky
	H9iQjkDq+vgM4TdDh4tVxsEbDyJP2Ctw/lCINAAiOfatR1UKke+gIqPYWyiGmA6S
	UuCH2+0vpmGPXbrfCzIUoKu7SIyg/1OUfwTlGN+HrY0HKLbD3VJdv/wq8RBLaPpJ
	xVw33tJVkZTFIPc2spT/g==
X-ME-Sender: <xms:_6Ydav8b_KMc9ebCqSoKmsS-Bdz19nluWNpkRNNshEnloZK_s0bCVg>
    <xme:_6YdaioaM-tlmqYA9tPXY2bmzwwSwahRudgFG1rOtqUnqN6uXz7x3qubQjPFp5XBC
    LCdM3XW23m5zo2CClcIn0yfYOZBSLGHtLXdQUGes0s8ZtY0J8Mb>
X-ME-Received: <xmr:_6YdaipLHhXRl-LKW8wNBrRiXZCdNJFYhcxV4KfwD1M-MiFbp-LQL0SS-iEa8zMBWbG_iQ5-y92mDiwVkUcArPFEgKustBgJWBBH7Ex3Bz7W>
X-ME-Proxy-Cause: dmFkZTFkHzWC5i+5+kKJ+Xd0+ihbZxPxh5njuY7FmBapEVVWaZxbPraD7cNCeiEhB3JMp0
    KlemCvSjGZ+hU7wmpvKgHVnSlQ/0OLx2Xbi1wP28OP0502bWu++EhQ/uinvQEytJ9PoXcN
    yGcU/6ECLyXQDrMubtX0YGTKmlTc3Thvd1PDj40WJhJ8XIU80nFsunzBJa3c+P8/GHjrTu
    nb0f7u70DWYYkWDs4IzpJFIqFHJuRdoV8LuJUsSRvRqWiLLeylTLqNrJxLFeuT7y6V3TyX
    dM5YAeZgKWK6alPWxhn4gXkClGYU3oZnDP4GHzlVtvTtqKzw390qFDmoaOjEVn/y9ekxcH
    /94a6Nr39qgcXMcIEOcZesQgBqgZ8N/mC5u9zrP5fADtXaIVGzAW0ex9s+IYlnZG/uPIq4
    9mgxEMRNIxhM4P00qPuKOf1eQ1bImiUM7Veb7qwcjimOXVkLHYpmrtpZXeOsClGZbg0XCC
    EM87/talPJtibXWG+3pYew3qhIUO2oF0l+X9aGJPMUHqGGp7LxgR8Fx5SUcAIW8XflqGm9
    BUwdr4lXaEkH1qJa0eoYSJi7Ev1hsQrYGGUiiHYYHYjhcvfEI7EFMPIFE2NqQr6VJVDEkM
    a2ZiACbNfMpjamnvmMzPTo+nUgYFwfezzI7wnzP4wA/lX/TbnsDDE9M+T9tQ
X-ME-Proxy: <xmx:_6Ydagk-m1SETSHEDdOFwvwo52-tzpRusB5NgvgsL9k5EzjXKqtSJg>
    <xmx:_6YdakF1Rh8AVU-yOHD8KevmAndsLgtqvb-x4uIG3XWRVGWv0bpMAg>
    <xmx:_6Ydapo_79XUJUisAtZcYT_v9UVmawa4vhZn8HDJJfWJ59CvkUHaFQ>
    <xmx:_6Ydag56-UbZBSiXYFqWDmzpBV88HrtoFeiktqkUu2hZ4tX3WfJbOA>
    <xmx:_6Ydarsh74_F8BwOX86F0O6AluWL4ucuCLKETZAnzHFpLiX6QFPTCpo5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 1 Jun 2026 11:36:31 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5171cd55 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 1 Jun 2026 15:36:23 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 01 Jun 2026 17:36:14 +0200
Subject: [PATCH 2/2] builtin/history: implement "drop" subcommand
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-b4-pks-history-drop-v1-2-643e32340d55@pks.im>
References: <20260601-b4-pks-history-drop-v1-0-643e32340d55@pks.im>
In-Reply-To: <20260601-b4-pks-history-drop-v1-0-643e32340d55@pks.im>
To: git@vger.kernel.org
Cc: 
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
 builtin/history.c              | 231 +++++++++++++++++++
 t/meson.build                  |   1 +
 t/t3454-history-drop.sh        | 513 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 782 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-history.adoc b/Documentation/git-history.adoc
index 2ba8121795..4eac732fd2 100644
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
+$ git history drop def5678
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
index 4fadf38c32..12c27defbb 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -21,9 +21,12 @@
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
@@ -1001,12 +1004,239 @@ static int cmd_history_split(int argc,
 	return ret;
 }
 
+static int update_worktree(struct repository *repo,
+			   const struct commit *old_head,
+			   const struct commit *new_head,
+			   bool dry_run)
+{
+	struct index_state index = INDEX_STATE_INIT(repo);
+	struct unpack_trees_options opts = { 0 };
+	struct lock_file lock = LOCK_INIT;
+	struct tree_desc desc[2] = { 0 };
+	char *desc_buf[2] = { 0 };
+	int ret;
+
+	if (!dry_run &&
+	    repo_hold_locked_index(repo, &lock, LOCK_REPORT_ON_ERROR) < 0)
+		return -1;
+
+	if (read_index_from(&index, repo->index_file, repo->gitdir) < 0) {
+		ret = error(_("unable to read index"));
+		goto out;
+	}
+
+	setup_unpack_trees_porcelain(&opts, "history drop");
+	opts.head_idx = 1;
+	opts.src_index = &index;
+	opts.dst_index = &index;
+	opts.fn = twoway_merge;
+	opts.merge = 1;
+	opts.update = !dry_run;
+	opts.dry_run = dry_run;
+	opts.preserve_ignored = 0;
+	init_checkout_metadata(&opts.meta, NULL, &new_head->object.oid, NULL);
+
+	desc_buf[0] = fill_tree_descriptor(repo, &desc[0], &old_head->object.oid);
+	desc_buf[1] = fill_tree_descriptor(repo, &desc[1], &new_head->object.oid);
+
+	if (unpack_trees(2, desc, &opts)) {
+		ret = -1;
+		goto out;
+	}
+
+	if (!dry_run) {
+		cache_tree_free(&index.cache_tree);
+
+		if (write_locked_index(&index, &lock, COMMIT_LOCK)) {
+			ret = error(_("could not write index"));
+			goto out;
+		}
+	}
+
+	ret = 0;
+
+out:
+	clear_unpack_trees_porcelain(&opts);
+	rollback_lock_file(&lock);
+	release_index(&index);
+	free(desc_buf[0]);
+	free(desc_buf[1]);
+	return ret;
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
+		ret = error(_("cannot drop merge commit"));
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
+	if (!dry_run && !is_bare_repository()) {
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
+	if (head_moves && update_worktree(repo, old_head, new_head, false) < 0) {
+		ret = error(_("failed to update working tree; "
+			      "run `git checkout HEAD` to sync"));
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
@@ -1014,6 +1244,7 @@ int cmd_history(int argc,
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
index 0000000000..b320ff09b3
--- /dev/null
+++ b/t/t3454-history-drop.sh
@@ -0,0 +1,513 @@
+#!/bin/sh
+
+test_description='tests for git-history drop subcommand'
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY/lib-log-graph.sh"
+
+expect_graph () {
+	cat >expect &&
+	lib_test_cmp_graph --graph --format=%s "$@"
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
+	test_commit -C repo initial &&
+	test_commit -C repo second &&
+	test_must_fail git -C repo history drop --empty=bogus HEAD 2>err &&
+	test_grep "unrecognized.*--empty.*bogus" err
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
2.54.0.926.g75ba10bac6.dirty

