Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121262AEE4
	for <git@vger.kernel.org>; Sun, 12 Jul 2026 00:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783816747; cv=none; b=oybV7R5Q75gCmoSaSdKmgfO18b99cZaFwVDBAmNsCErEZbDcdhowhm2rTuBD2UIdv2+QPmBDN/t8kxiKsj4pX2U7RtzkUWKVASpQE2e1P4EJxCPoowFzMDOh3gQSHJQ1lS2TmHfAGJ9tEpFlpIbPJFkshUZBBUEMR17nDuZIvx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783816747; c=relaxed/simple;
	bh=DHASEIKGEz3rzLdfX5TaMq22TbFGxADvlfqrsqWNTNQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=SyrQFUodNT2mQvSGFMy/taSohoXJpK1/bCx+0bk2Gj9dOsxafiWcFdjgaiGZe7EJ+GjOvbMJrwSfzMZfilxpRNmRNJFlJJqa4JwflmD7TPZmy2uxV/Lc2i9uWbq+C4JmjH9VPyKTS7+8EtwjzvLIv7Vlhx4Agq2rt/fwYgKZsMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H0DHavRk; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0DHavRk"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cc891373e0so20158285ad.2
        for <git@vger.kernel.org>; Sat, 11 Jul 2026 17:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783816744; x=1784421544; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IQD5+olFBHnUXLzWImHwvAxymZeJbDHj1nOufWH0DO0=;
        b=H0DHavRk/Dps3btNs8McdP38of4okvLQV5uHjHXY+3aPwK91BJThfZSz9zk7pTLRzQ
         dtAvN+YvG1s1eiAnyKkY5HvF9vA7YATEsyp5GPGaT3Ql/HIzSPay749fQrNVizGbGehZ
         2+KQLh/upVWog9lpoMXx7DGYiytgtEonZZbG/mwvjbL+lUroBOSmdWQBtivYuGISzGsL
         IRF6npiFGUp2M9IFgCp+yGkmXMaJy8+C0dDLNRZu+14wDJAISC1uXA60kSbkZcdtYO+Y
         h4NEW8rGanq/mCp4vw8IOZJtEd8FR1qRGiQleMOeIbsrfVqVQUVmxoprhUdcEOv2wF1H
         A0Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783816744; x=1784421544;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=IQD5+olFBHnUXLzWImHwvAxymZeJbDHj1nOufWH0DO0=;
        b=lnWzTkn+zBEnJ3JRJ6vYj3IS8B8WhAlie06u7Eaef4dFPacw/vaXl/OnScIOcFMwjf
         d/1bZCeZFulqkWgCquCjsQhmsPE2kguUXY8fY7Buf8GC/ZaBa/E6W5yOgnUu5WFxT3xc
         xxs+OTMq1Brp56ItYHm1C53qx6MXDVYLfy96k8Qo7jXgKsOQ+9jOcjCDHzBtoKH5dqkB
         BY3KuTMLMrVO/T9LDvA8Kbc4cYbaJK6gt1an6gMbRdzxmSNise65yikrKakIArKY8/WJ
         V7qZS4tl2kkIOF2dDcSv527aUs2u5/oA1lG94ttdXql4HwsnnSQNXqNe7XKO4hVkP72S
         8JOw==
X-Gm-Message-State: AOJu0Yyx/FqKnvUmWx+wtvA72TGOVvpcMD0uS5UUHSQj0H2nZJ/0Zefl
	RXZYVjhWPvqLGnticujZoPNcXOAUtubOezpaVbkLcXeTiU4yG6U10egF2SPVcQ==
X-Gm-Gg: AfdE7cl535wzynr/GKukBPABI8LIhao1zabiK0IBiBPGzhPkI1f427MdeovhHvm7oCJ
	/jgT4Q2ui0zxtirhBAPA6CRiod+gjiPxJO5l2nsKhRKmdKsK6vxqbDLULmWK/+Ehu8/0YSNzmUZ
	aKYT+WzHGKDpY7f39QTC9W7Kt2y0Y7qyL3KJnQUp/5rzSQvm7YIZHO57KWB+5/WhqFxsjngv0Dd
	t6UkpXJj+1/Tni1N7MLHKEoHwms5lv854lqQxwPii9kuTUDf8r104LRms5JYx9Sekj1yao2hP6F
	Q2CG0gMmsaBpePU0Ug8Rzd+JiUKDuw211kcFgV9DUoNI6Jfz+xlDIp5jNl76rzHSnVGOJlcBpWo
	JbsEk1T/5c4hmGcQkHTjIYqopCm18gWE2bnwut+yBqx2OdJLt9X15mbhioUJ4J0z/s2PLkCkaX6
	SphZtT/vu3s8C1kEcd
X-Received: by 2002:a05:6a20:d10f:b0:3c0:ac0f:6558 with SMTP id adf61e73a8af0-3c110631fcdmr4407134637.2.1783816744115;
        Sat, 11 Jul 2026 17:39:04 -0700 (PDT)
Received: from [127.0.0.2] ([98.35.8.117])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31189cd8234sm46879257eec.9.2026.07.11.17.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 17:39:03 -0700 (PDT)
From: Farid Zakaria <farid.m.zakaria@gmail.com>
Date: Sat, 11 Jul 2026 17:38:26 -0700
Subject: [PATCH v3] sequencer: honor --empty when a fixup!/squash! empties
 its target
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260711-fz-autosquash-empty-v3-1-d227b63eb511@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAHiUmoC/6WOvQ6CMBRGX4V0tqY/WH4m38MwlHoLTYRiC41Ie
 HcLLg7GxfHc5JzvLsiDM+BRmSzIQTDe2D4CPyRItbJvAJtrZMQIEyQjBdZPLKfR+vskfYuhG8Y
 Z10IUTGkulCAomoMDbR579VJFbo0frZv3kcC26+9eoJjiPFV1WqSKC8rPTSfN7ahst+XfLiXfX
 RZdLSmwLANy0vmHu/0S6H/71bquLyiNwRk2AQAA
X-Change-ID: 20260709-fz-autosquash-empty-b6692cf36c60
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>, 
 Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>, 
 Junio C Hamano <gitster@pobox.com>, 
 Farid Zakaria <farid.m.zakaria@gmail.com>
X-Mailer: b4 0.14.3

When "git rebase --autosquash" melds a "fixup!" or "squash!" commit into
its target, the result can be a commit that no longer changes anything
relative to its parent, for example when the melded change reverts the
target.  Rather than dropping or keeping this empty commit, the rebase
stops with

	You asked to amend the most recent commit, but doing so would
	make it empty. ...

and the "--empty" option has no effect on it.  This makes backing a
change out of a series awkward: reverting a commit as a "fixup!" and
running "git rebase --autosquash --empty=drop" ought to remove both the
commit and its revert, but it halts instead.

A "fixup!" is applied by amending HEAD, so the melded commit has HEAD's
parent as its parent and is empty when the index matches the tree of that
parent, not of HEAD.  do_pick_commit() only compares against HEAD, so it
never notices that the meld cancelled the commit out and falls through to
"git commit --amend", which refuses to create an empty commit.

After melding a fixup or squash, check whether the amended commit is
empty -- its index matches the tree of HEAD's parent -- and, if so, honor
"--empty" just as for a commit that becomes empty when picked: keep it,
drop it, or halt.

When "--empty=drop" applies, the emptied commit has already been created
by the preceding "pick", so drop it by moving HEAD back to its parent.
The commit is dropped rather than rewritten, so discard the pending
rewrite records and do not record the fixup either, leaving nothing for
the post-rewrite machinery; a following "label" or "update-ref" then sees
HEAD at the parent.

Signed-off-by: Farid Zakaria <farid.m.zakaria@gmail.com>
---
At Meta we maintain a fork of LLVM that we regularly rebase onto
upstream.  A set of internal patches rides on top, and we keep each one
as a single commit by folding follow-up changes into it with autosquash
"fixup!" commits.  That works well for evolving a patch, but not for
retiring one: to back an internal patch out today we hand-edit the
interactive rebase todo list to delete the commit and its scattered
fixups, which is fiddly and easy to get wrong.  (The history is rewritten
either way, so a force-push is still needed; what this avoids is the
manual todo surgery.)

It would be nicer to retire a patch the same way we amend one: commit a
revert of it as a "fixup!" and let autosquash fold the two together.
The net change is empty, so the commit should just drop out of the
series.  Today it does not -- the rebase stops instead.

For example, starting from a commit we want to retire:

    $ git log --oneline
    4d5e6f7 add feature patch
    9a1b2c3 base

    # revert the feature and mark the revert as a fixup of it
    $ git revert --no-edit HEAD
    $ git commit --amend -m "fixup! add feature patch"

    $ git rebase -i --autosquash --empty=drop 9a1b2c3
    Rebasing (2/2)
    You asked to amend the most recent commit, but doing so would
    make it empty. You can repeat your command with --allow-empty [...]
    Could not apply 8e9f0a1... # fixup! add feature patch

The "--empty=drop" is ignored.  "--empty" only governs commits that are
picked empty, whereas a "fixup!" is applied by amending, and the
emptiness of an amended commit is measured against the wrong parent.  So
the rebase falls through to "git commit --amend", which refuses to
create an empty commit, and halts.

With this patch the emptied commit is recognized and handled according
to "--empty", the same as any other commit that becomes empty during a
rebase:

    $ git rebase -i --autosquash --empty=drop 9a1b2c3
    Rebasing (2/2)
    dropping 8e9f0a1... fixup! add feature patch -- resulting commit is empty
    Successfully rebased and updated refs/heads/main.

    $ git log --oneline
    9a1b2c3 base

"--empty=keep" retains it as an empty commit, and "--empty=stop" (the
default under "-i") halts so the user can decide -- matching how these
options already behave for commits that become empty when picked.

Changes in v3:
 * Switch the new tests' assertions from grep to test_grep for better
   diagnostics (per review).
 * Link to v2: https://lore.kernel.org/r/20260710-fz-autosquash-empty-v2-1-fa1e277e05f8@gmail.com

Changes in v2 (thanks to Phillip Wood's review):
 * An emptied fixup/squash now honors --empty in all cases, including
   when the commit it was folded into started out empty; v1 kept that
   case regardless of --empty.
 * On drop, the dropped commit and its fixup are no longer recorded as
   rewritten, so nothing spurious reaches the post-rewrite machinery.
 * Added tests for the empty-placeholder + fixup cases and for the
   not-recorded-as-rewritten behavior; adjusted t3415 "abort last squash".
 * Link to v1: https://lore.kernel.org/r/20260709-fz-autosquash-empty-v1-1-84cb494c3613@gmail.com
---
base-commit: f60db8d575adb79761d363e026fb49bddf330c73
---
 Documentation/git-rebase.adoc |  12 ++++
 sequencer.c                   | 148 +++++++++++++++++++++++++++++++++++-------
 t/t3415-rebase-autosquash.sh  | 140 ++++++++++++++++++++++++++++++++++++++-
 3 files changed, 276 insertions(+), 24 deletions(-)

diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
index f6c22d1598..7eb8bbe95f 100644
--- a/Documentation/git-rebase.adoc
+++ b/Documentation/git-rebase.adoc
@@ -282,6 +282,11 @@ by `git log --cherry-mark ...`) are detected and dropped as a
 preliminary step (unless `--reapply-cherry-picks` or `--keep-base` is
 passed).
 +
+A commit can also become empty as a result of `--autosquash`, when a
+`fixup!` or `squash!` commit cancels out all of the changes of the
+commit it is melded into.  Such a commit is treated the same way and is
+dropped, kept, or stopped at according to this option.
++
 See also INCOMPATIBLE OPTIONS below.
 
 --no-keep-empty::
@@ -591,6 +596,13 @@ changed from `pick` to `squash`, `fixup` or `fixup -C`, respectively, and they
 are moved right after the commit they modify.  The `--interactive` option can
 be used to review and edit the todo list before proceeding.
 +
+If melding a `fixup!` or `squash!` commit cancels out all of the changes of
+the commit it is applied to, the result is an empty commit.  The handling of
+these empty commits can be configured with the `--empty` option: the emptied
+commit is dropped, kept, or stopped at.  This makes it possible to back a
+change out of a series by committing a revert of it as a `fixup!` and letting
+`--autosquash --empty=drop` remove both.
++
 The recommended way to create commits with squash markers is by using the
 `--squash`, `--fixup`, `--fixup=amend:` or `--fixup=reword:` options of
 linkgit:git-commit[1], which take the target commit as an argument and
diff --git a/sequencer.c b/sequencer.c
index 0fe8fed6c3..bc24132c7c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1817,6 +1817,39 @@ static int allow_empty(struct repository *r,
 		return 0;
 }
 
+/*
+ * Melding a "fixup!"/"squash!" amends HEAD, so the resulting commit is empty
+ * when the index matches the tree of HEAD's parent (rather than of HEAD, as a
+ * plain pick would).  Returns 1 if the amended commit would be empty, 0 if not,
+ * and negative on error.
+ */
+static int amended_commit_is_empty(struct repository *r)
+{
+	struct object_id head_oid, *cache_tree_oid;
+	const struct object_id *parent_tree_oid;
+	struct commit *head_commit;
+
+	if (repo_get_oid(r, "HEAD", &head_oid))
+		return error(_("could not resolve HEAD commit"));
+	head_commit = lookup_commit_reference(r, &head_oid);
+	if (!head_commit || repo_parse_commit(r, head_commit))
+		return -1;
+
+	if (head_commit->parents) {
+		struct commit *parent = head_commit->parents->item;
+		if (repo_parse_commit(r, parent))
+			return -1;
+		parent_tree_oid = get_commit_tree_oid(parent);
+	} else {
+		parent_tree_oid = the_hash_algo->empty_tree;
+	}
+
+	if (!(cache_tree_oid = get_cache_tree_oid(r->index)))
+		return -1;
+
+	return oideq(cache_tree_oid, parent_tree_oid);
+}
+
 static struct {
 	char c;
 	const char *str;
@@ -2260,10 +2293,34 @@ static const char *reflog_message(struct replay_opts *opts,
 	return buf.buf;
 }
 
+/*
+ * A "fixup!"/"squash!" that melds into HEAD may empty it out.  In that case,
+ * with --empty=drop, we want to drop the commit entirely.  Since the commit
+ * being amended has already been created (by the preceding "pick"), and the
+ * index and worktree already match the tree of its parent, dropping it is a
+ * matter of moving HEAD back to that parent.
+ */
+static int reset_head_to_parent(struct repository *r, struct replay_opts *opts,
+				struct object_id *head)
+{
+	struct commit *head_commit = lookup_commit_reference(r, head);
+
+	if (!head_commit || repo_parse_commit(r, head_commit))
+		return error(_("could not parse HEAD commit"));
+	if (!head_commit->parents)
+		return error(_("cannot drop the root commit"));
+
+	return refs_update_ref(get_main_ref_store(r),
+			       reflog_message(opts, "fixup",
+					      "dropping emptied commit"),
+			       "HEAD", &head_commit->parents->item->object.oid,
+			       head, 0, UPDATE_REFS_MSG_ON_ERR);
+}
+
 static int do_pick_commit(struct repository *r,
 			  struct todo_item *item,
 			  struct replay_opts *opts,
-			  int final_fixup, int *check_todo)
+			  int final_fixup, int *check_todo, int *dropped)
 {
 	struct replay_ctx *ctx = opts->ctx;
 	unsigned int flags = should_edit(opts) ? EDIT_MSG : 0;
@@ -2277,6 +2334,9 @@ static int do_pick_commit(struct repository *r,
 	enum todo_command command = item->command;
 	struct commit *commit = item->commit;
 
+	if (dropped)
+		*dropped = 0;
+
 	if (is_rebase_i(opts))
 		reflog_action = reflog_message(
 			opts, command_to_string(item->command), NULL);
@@ -2493,23 +2553,67 @@ static int do_pick_commit(struct repository *r,
 	}
 
 	drop_commit = 0;
-	allow = allow_empty(r, opts, commit);
-	if (allow < 0) {
-		res = allow;
-		goto leave;
-	} else if (allow == 1) {
-		flags |= ALLOW_EMPTY;
-	} else if (allow == 2) {
-		drop_commit = 1;
-		refs_delete_ref(get_main_ref_store(r), "", "CHERRY_PICK_HEAD",
-				NULL, REF_NO_DEREF);
-		unlink(git_path_merge_msg(r));
-		refs_delete_ref(get_main_ref_store(r), "", "AUTO_MERGE",
-				NULL, REF_NO_DEREF);
-		fprintf(stderr,
-			_("dropping %s %s -- patch contents already upstream\n"),
-			oid_to_hex(&commit->object.oid), msg.subject);
-	} /* else allow == 0 and there's nothing special to do */
+	if (flags & AMEND_MSG) {
+		/*
+		 * A "fixup!"/"squash!" amends HEAD.  Separately from the usual
+		 * empty-commit handling, check whether applying it leaves the
+		 * commit empty and, if so, honor --empty (keep, drop, or -- when
+		 * neither is requested -- halt below in do_commit), just as for a
+		 * commit that becomes empty when picked.
+		 */
+		int melded_empty = amended_commit_is_empty(r);
+		if (melded_empty < 0) {
+			res = melded_empty;
+			goto leave;
+		} else if (melded_empty && opts->keep_redundant_commits) {
+			flags |= ALLOW_EMPTY;
+		} else if (melded_empty && opts->drop_redundant_commits) {
+			drop_commit = 1;
+			refs_delete_ref(get_main_ref_store(r), "", "CHERRY_PICK_HEAD",
+					NULL, REF_NO_DEREF);
+			unlink(git_path_merge_msg(r));
+			refs_delete_ref(get_main_ref_store(r), "", "AUTO_MERGE",
+					NULL, REF_NO_DEREF);
+			/*
+			 * The commit the fixup was melded into was already
+			 * created by the preceding "pick", so drop it by moving
+			 * HEAD back to its parent.  Since the commit is being
+			 * dropped rather than rewritten, discard the pending
+			 * rewrite records and tell our caller not to add one, so
+			 * that neither the dropped commit nor the fixup is
+			 * recorded as rewritten.
+			 */
+			res = reset_head_to_parent(r, opts, &head);
+			if (res)
+				goto leave;
+			unlink(rebase_path_rewritten_pending());
+			if (dropped)
+				*dropped = 1;
+			fprintf(stderr,
+				_("dropping %s %s -- resulting commit is empty\n"),
+				oid_to_hex(&commit->object.oid), msg.subject);
+		}
+		/* else the meld is non-empty, or empty but neither kept nor
+		 * dropped, in which case do_commit halts on the empty result. */
+	} else {
+		allow = allow_empty(r, opts, commit);
+		if (allow < 0) {
+			res = allow;
+			goto leave;
+		} else if (allow == 1) {
+			flags |= ALLOW_EMPTY;
+		} else if (allow == 2) {
+			drop_commit = 1;
+			refs_delete_ref(get_main_ref_store(r), "", "CHERRY_PICK_HEAD",
+					NULL, REF_NO_DEREF);
+			unlink(git_path_merge_msg(r));
+			refs_delete_ref(get_main_ref_store(r), "", "AUTO_MERGE",
+					NULL, REF_NO_DEREF);
+			fprintf(stderr,
+				_("dropping %s %s -- patch contents already upstream\n"),
+				oid_to_hex(&commit->object.oid), msg.subject);
+		} /* else allow == 0 and there's nothing special to do */
+	}
 	if (!opts->no_commit && !drop_commit) {
 		if (author || command == TODO_REVERT || (flags & AMEND_MSG))
 			res = do_commit(r, msg_file, author, reflog_action,
@@ -4958,12 +5062,12 @@ static int pick_one_commit(struct repository *r,
 			   struct replay_opts *opts,
 			   int *check_todo, int* reschedule)
 {
-	int res;
+	int res, dropped = 0;
 	struct todo_item *item = todo_list->items + todo_list->current;
 	const char *arg = todo_item_get_arg(todo_list, item);
 
 	res = do_pick_commit(r, item, opts, is_final_fixup(todo_list),
-			     check_todo);
+			     check_todo, &dropped);
 	if (is_rebase_i(opts) && res < 0) {
 		/* Reschedule */
 		*reschedule = 1;
@@ -4980,7 +5084,7 @@ static int pick_one_commit(struct repository *r,
 		return error_with_patch(r, commit,
 					arg, item->arg_len, opts, res, !res);
 	}
-	if (is_rebase_i(opts) && !res)
+	if (is_rebase_i(opts) && !res && !dropped)
 		record_in_rewritten(&item->commit->object.oid,
 				    peek_command(todo_list, 1));
 	if (res && is_fixup(item->command)) {
@@ -5545,7 +5649,7 @@ static int single_pick(struct repository *r,
 			TODO_PICK : TODO_REVERT;
 	item.commit = cmit;
 
-	return do_pick_commit(r, &item, opts, 0, &check_todo);
+	return do_pick_commit(r, &item, opts, 0, &check_todo, NULL);
 }
 
 int sequencer_pick_revisions(struct repository *r,
diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
index 5033411a43..d8085abf1d 100755
--- a/t/t3415-rebase-autosquash.sh
+++ b/t/t3415-rebase-autosquash.sh
@@ -461,13 +461,15 @@ test_expect_success 'abort last squash' '
 	git commit --allow-empty -m second &&
 	git commit --allow-empty --squash HEAD &&
 
+	: "squashing empty onto empty leaves an empty commit; --empty=keep" &&
+	: "keeps it so the squash still reaches the editor, which aborts" &&
 	test_must_fail git -c core.editor="grep -q ^pick" \
-		rebase -ki --autosquash HEAD~4 &&
+		rebase -ki --autosquash --empty=keep HEAD~4 &&
 	: do not finish the squash, but resolve it manually &&
 	git commit --allow-empty --amend -m edited-first &&
 	git rebase --skip &&
 	git show >actual &&
-	! grep first actual
+	test_grep ! first actual
 '
 
 test_expect_success 'fixup a fixup' '
@@ -510,4 +512,138 @@ test_expect_success 'pick and fixup respect commit.cleanup' '
 	test_commit_message HEAD -m "something"
 '
 
+test_expect_success 'fixup! that empties its target is dropped with --empty=drop' '
+	git reset --hard base &&
+	test_commit --no-tag addX fileX 1 &&
+	test_commit --no-tag changeX fileX 2 &&
+	test_commit --no-tag later fileW hello &&
+	echo 1 >fileX &&
+	git commit -m "fixup! changeX" fileX &&
+
+	git rebase -i --autosquash --empty=drop HEAD~4 &&
+
+	git log --format=%s >actual &&
+	test_grep ! changeX actual &&
+	test_grep addX actual &&
+	test_grep later actual &&
+	echo 1 >expect &&
+	test_cmp expect fileX &&
+	echo hello >expect &&
+	test_cmp expect fileW
+'
+
+test_expect_success 'fixup! that empties its target is kept with --empty=keep' '
+	git reset --hard base &&
+	test_commit --no-tag addY fileY 1 &&
+	test_commit --no-tag changeY fileY 2 &&
+	echo 1 >fileY &&
+	git commit -m "fixup! changeY" fileY &&
+
+	git rebase -i --autosquash --empty=keep HEAD~3 &&
+
+	git log --format=%s >actual &&
+	test_grep changeY actual &&
+	: "the retained commit is empty" &&
+	git diff --exit-code HEAD~1 HEAD &&
+	echo 1 >expect &&
+	test_cmp expect fileY
+'
+
+test_expect_success 'fixup! that empties its target stops with --empty=stop' '
+	git reset --hard base &&
+	test_commit --no-tag addZ fileZ 1 &&
+	test_commit --no-tag changeZ fileZ 2 &&
+	echo 1 >fileZ &&
+	git commit -m "fixup! changeZ" fileZ &&
+
+	test_when_finished "git rebase --abort" &&
+	test_must_fail git rebase -i --autosquash --empty=stop HEAD~3
+'
+
+test_expect_success 'squash! that empties its target is dropped with --empty=drop' '
+	git reset --hard base &&
+	test_commit --no-tag addS fileS 1 &&
+	test_commit --no-tag changeS fileS 2 &&
+	echo 1 >fileS &&
+	git commit -m "squash! changeS" fileS &&
+
+	git rebase -i --autosquash --empty=drop HEAD~3 &&
+
+	git log --format=%s >actual &&
+	test_grep ! changeS actual &&
+	test_grep addS actual &&
+	echo 1 >expect &&
+	test_cmp expect fileS
+'
+
+test_expect_success 'fixup! filling in an empty commit keeps a non-empty commit' '
+	git reset --hard base &&
+	git commit --allow-empty -m placeholder &&
+	test_commit --no-tag "fixup! placeholder" fileP content &&
+
+	git rebase -i --autosquash --empty=stop HEAD~2 &&
+
+	git log --format=%s >actual &&
+	test_grep placeholder actual &&
+	echo content >expect &&
+	test_cmp expect fileP &&
+	: "the once-empty placeholder is no longer empty" &&
+	test_must_fail git diff --exit-code HEAD~1 HEAD
+'
+
+test_expect_success 'fixup! leaving an empty commit empty stops with --empty=stop' '
+	git reset --hard base &&
+	git commit --allow-empty -m placeholder &&
+	git commit --allow-empty -m "fixup! placeholder" &&
+
+	test_when_finished "git rebase --abort" &&
+	test_must_fail git rebase -i --autosquash --empty=stop HEAD~2
+'
+
+test_expect_success 'fixup! leaving an empty commit empty is dropped with --empty=drop' '
+	git reset --hard base &&
+	git commit --allow-empty -m placeholder &&
+	git commit --allow-empty -m "fixup! placeholder" &&
+
+	git rebase -i --autosquash --empty=drop HEAD~2 &&
+
+	git log --format=%s >actual &&
+	test_grep ! placeholder actual
+'
+
+test_expect_success 'fixup! leaving an empty commit empty is kept with --empty=keep' '
+	git reset --hard base &&
+	git commit --allow-empty -m placeholder &&
+	git commit --allow-empty -m "fixup! placeholder" &&
+
+	git rebase -i --autosquash --empty=keep HEAD~2 &&
+
+	git log --format=%s >actual &&
+	test_grep placeholder actual &&
+	git diff --exit-code HEAD~1 HEAD
+'
+
+test_expect_success 'a dropped emptied fixup is not recorded as rewritten' '
+	git reset --hard base &&
+	test_commit --no-tag preR fileR 1 &&
+	test_commit --no-tag changeR fileR 2 &&
+	R=$(git rev-parse HEAD) &&
+	echo 1 >fileR &&
+	git commit -m "fixup! changeR" fileR &&
+	F=$(git rev-parse HEAD) &&
+	test_commit --no-tag keepR fileK keep &&
+
+	test_when_finished "rm -f .git/hooks/post-rewrite actual.rewrites" &&
+	write_script .git/hooks/post-rewrite <<-\EOF &&
+	cat >actual.rewrites
+	EOF
+
+	git rebase -i --autosquash --empty=drop HEAD~4 &&
+
+	: "changeR and its fixup were dropped, so must not be reported as" &&
+	: "rewritten, but the surviving keepR must be" &&
+	test_grep ! -e "$R" -e "$F" actual.rewrites &&
+	test_grep "$(git rev-parse HEAD)" actual.rewrites
+'
+
 test_done



