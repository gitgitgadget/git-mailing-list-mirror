Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518683F5BFA
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 13:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781531714; cv=none; b=um/Do4LOG0CLV1pJVxkdLDD9kepnTNaPzBGldcXvhuo2NqRMnnkUkh2AHYuj/v1J4WBnhOrXqkdNKdyo6rWbZIK0FxFQAAcraaHaWvUnPDmnKVYOqBMr8R0ctCZvI9M4Fby9uRU2/K8+MAsJjTHpRiGN/e54f76y81dSGH5+agA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781531714; c=relaxed/simple;
	bh=9kl1p4Cwix4G0qaD+5j70hISV9wYJZWq5wcxfK/+8SQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LAi36kG9ey2pjKtvdolZvub6hVbm5c/IrWPSVJh+utBHBtnfWsSf01N6YUALNvxgpkktm4dSIx0IGuvpzk5vtzHT/VN9x68YkkDvT4pHf8KvSod+4S/PEfZKugN+DofeNCizfRnc6BofjofcerN3w7OzVz2P4moTGK4EkHgQGP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WBfW/wFi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hFCe37X2; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WBfW/wFi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hFCe37X2"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 8F495EC0256;
	Mon, 15 Jun 2026 09:55:12 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 15 Jun 2026 09:55:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781531712;
	 x=1781618112; bh=VXGr7wvGPiQ/KwZKfxfrqyslR18ayn1x2ebR7Wo0mow=; b=
	WBfW/wFibn5nPiaKszztMIw0VM/S6iQfa7TVthgdAaTwzokoXHbTkXMPdMPLEFEw
	Oi9aO1oGvziy/0oNAoETPBpouacU63sbnHse0I+1HTX8gJB2rTNwg2HikqmOHXpr
	XrM15bAFAz8zgC8PHce+jYD9XDLroFdLRCSMVPsu5BzqCxN+I0nK2KmLImSwScFJ
	TT0SRGXgD1jRhZgYh392a3QHGxl1ZLQx3YWq94YWg8nrKG4ptrxCyZEhqZT49ayA
	yvBYOU+bSCyoPvdVuBOT8YoAErLfW7iTTtp46kVfLErCWuoRiN+DAARZI2CBTyJa
	hke8+kwCMB2TezAgiKQ5wg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781531712; x=
	1781618112; bh=VXGr7wvGPiQ/KwZKfxfrqyslR18ayn1x2ebR7Wo0mow=; b=h
	FCe37X2NV2fYXUxMntaTg2H92SJAFRBidpmYl01bldWP9/LumQ7K9TrgD4uBFGmJ
	KB2m/KcK/4IOgEAkwly1f6Hd2XIvkmiIw1RKAmLZ2gSJoNvGDoKx6Hh4k2r2kdoF
	bgAbDdCzWQygP/i9uFbydlJ/KUvQVk/ZyuETLkgLrchS7p86bgItbkF3ONUYNwFv
	k3euGkP7BQslPinvqfpxUscq8ZV1XerkW0FD/iC20jZ09lVKpEYBFM4Z8pjv36f+
	DNtyMhBLYrDnrJoBjI0OSetcScPzQRLU4oK53C4aL65ESLstvdRcTa4h9qNMewcC
	28Gq/oR8acYBv9m0qXWpw==
X-ME-Sender: <xms:QAQwagGpHnVpcO1Wm53Strlr7zV-Z44Kqmzk7MrrakSAuel5nGvmzA>
    <xme:QAQwaq0FcpoLsJCf3-JE-ue0LX-ezrnKyCOnBgjgHm_jDoBq621vFj9Fo9cF0FrsO
    xgcBk4uzVwIO3HHvTQKTR-p-SH9-EGaG0-cAXa2-iG5FJ3i3F7e>
X-ME-Received: <xmr:QAQwaqOVN6rpSxswPIhAV5CYYD5ST1D0JSGCBz8Rbd9qim9VOiQbeRGjbXQtlWlIfxzVxx3vVQUjgRuk8bjdjL0gHp9Bnz4Wexoy6sYHvg>
X-ME-Proxy-Cause: dmFkZTEMPeD8zBW3DHtQEP5i93Acch+5rP0QNkH1cG/JXuA6+oEvHbtVmbD6clvJelgRZE
    1vBDsT7A7uQV6Gdj9OkjlqBCAnA412wemQtKwuPA/hvgcOh8CyRfV2AhtwfLNHTKQlwHQv
    oxhlnwtt/nGkegyVzC975GVhHt4uS6iBR/u/zU4/qV1aRi9gpkRnRhEG7H0vxr+9yXdWRU
    A8v/TL7rSWppNOMIvDS55f2AGwsqLpr5AvNVKzOZx9y2Ss5T1e/j4FoCcOGPCslmG/qDWP
    4JG1/aHeUY9Coy2vDLc1RvUk2C6XO8Fs5cA6VTVPI0cv+rNzSdKho8Uu7UNXJYJWmKwPCW
    8LR+/xxe0kmJf5S2nX3fQvPlNg8IcGVMIbbeewiA63l+hwZdAjuS+nmwyf9eaN0FQqEPOm
    Bdf5DWgWNLQrS9tBJlnqzyIFa2eLWGronRUvUTI8/ea1PCYFfkCRCa+wkn4ARY49fen/Lx
    ti6+SwMtBRt0uHJaf485K2YUMWJYpFildkVnUVCVcm7HgY0HhieB/YvqOHEc3bHjUFKpF0
    8HbHo08m4MX2leytDziGRdVsSsNmNz0R5ACBj50jkHaupYPVsgpFMNMdv1KTcBH62xuAfN
    JQ6DL0Ie6iKYLOyJdusj7Nl7L/m26sC4Um/+4PpF/ZqsJ7y3pUFvrA5fw9Aw
X-ME-Proxy: <xmx:QAQwah6CW7ofKoDDkUXQdI3neHEqeNX9nbkslOF5GNb6MDrDAGxThA>
    <xmx:QAQwas2ivt3iUDvBKxUhFuc7MLAhRX16_lwfkRXlZHxVn2jNvW5q_w>
    <xmx:QAQwaqzA3IJKaj11N8OPKLMKnA2jGEMskk72URK6o5_FFiRP_T_QhA>
    <xmx:QAQwauvraxzvRhCuWPJlivV7_koik8WL_0z6yTYNNsk_291aZYKZtA>
    <xmx:QAQwaiJmYnKlkQiq3jqmzJD1EeKe-Y6eW77kWBWFEUO1yh8_rvwgHHVc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jun 2026 09:55:11 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 06468108 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 15 Jun 2026 13:55:10 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 15 Jun 2026 15:54:56 +0200
Subject: [PATCH v6 06/10] reset: introduce ability to skip updating HEAD
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-b4-pks-history-drop-v6-6-2e329e536d78@pks.im>
References: <20260615-b4-pks-history-drop-v6-0-2e329e536d78@pks.im>
In-Reply-To: <20260615-b4-pks-history-drop-v6-0-2e329e536d78@pks.im>
To: git@vger.kernel.org
Cc: Pablo Sabater <pabloosabaterr@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.15.2

In a subsequent commit we'll introduce a new caller to
`reset_working_tree()` that really only wants to update the index and
working tree, without updating any references. Introduce a new flag that
makes the caller opt in to updating HEAD and adapt all callers to set
that flag.

Note that in a previous iteration we instead introduced a flag that made
callers opt out of updating any references. This was somewhat awkward
though because we already have the `UPDATE_ORIG_HEAD` flag, so the
result was somewhat inconsistent.

Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/rebase.c | 14 ++++++++++----
 reset.c          |  9 +++++++--
 reset.h          |  9 ++++++---
 sequencer.c      |  4 +++-
 4 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 06dcbaf5e8..10a306310c 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -607,7 +607,8 @@ static int move_to_original_branch(struct rebase_options *opts)
 	strbuf_addf(&head_reflog, "%s (finish): returning to %s",
 		    opts->reflog_action, opts->head_name);
 	ropts.branch = opts->head_name;
-	ropts.flags = RESET_WORKING_TREE_REFS_ONLY;
+	ropts.flags = RESET_WORKING_TREE_REFS_ONLY |
+		      RESET_WORKING_TREE_UPDATE_HEAD;
 	ropts.branch_msg = branch_reflog.buf;
 	ropts.head_msg = head_reflog.buf;
 	ret = reset_working_tree(the_repository, &ropts);
@@ -693,6 +694,7 @@ static int run_am(struct rebase_options *opts)
 		ropts.oid = &opts->orig_head->object.oid;
 		ropts.branch = opts->head_name;
 		ropts.default_reflog_action = opts->reflog_action;
+		ropts.flags = RESET_WORKING_TREE_UPDATE_HEAD;
 		reset_working_tree(the_repository, &ropts);
 		error(_("\ngit encountered an error while preparing the "
 			"patches to replay\n"
@@ -862,7 +864,8 @@ static int checkout_up_to_date(struct rebase_options *options)
 		    options->reflog_action, options->switch_to);
 	ropts.oid = &options->orig_head->object.oid;
 	ropts.branch = options->head_name;
-	ropts.flags = RESET_WORKING_TREE_RUN_POST_CHECKOUT_HOOK;
+	ropts.flags = RESET_WORKING_TREE_RUN_POST_CHECKOUT_HOOK |
+		      RESET_WORKING_TREE_UPDATE_HEAD;
 	if (!ropts.branch)
 		ropts.flags |=  RESET_WORKING_TREE_DETACH;
 	ropts.head_msg = buf.buf;
@@ -1384,7 +1387,8 @@ int cmd_rebase(int argc,
 
 		rerere_clear(the_repository, &merge_rr);
 		string_list_clear(&merge_rr, 1);
-		ropts.flags = RESET_WORKING_TREE_HARD;
+		ropts.flags = RESET_WORKING_TREE_HARD |
+			      RESET_WORKING_TREE_UPDATE_HEAD;
 		if (reset_working_tree(the_repository, &ropts) < 0)
 			die(_("could not discard worktree changes"));
 		remove_branch_state(the_repository, 0);
@@ -1409,7 +1413,8 @@ int cmd_rebase(int argc,
 		ropts.oid = &options.orig_head->object.oid;
 		ropts.head_msg = head_msg.buf;
 		ropts.branch = options.head_name;
-		ropts.flags = RESET_WORKING_TREE_HARD;
+		ropts.flags = RESET_WORKING_TREE_HARD |
+			      RESET_WORKING_TREE_UPDATE_HEAD;
 		if (reset_working_tree(the_repository, &ropts) < 0)
 			die(_("could not move back to %s"),
 			    oid_to_hex(&options.orig_head->object.oid));
@@ -1877,6 +1882,7 @@ int cmd_rebase(int argc,
 	ropts.oid = &options.onto->object.oid;
 	ropts.orig_head = &options.orig_head->object.oid;
 	ropts.flags = RESET_WORKING_TREE_DETACH |
+		      RESET_WORKING_TREE_UPDATE_HEAD |
 		      RESET_WORKING_TREE_UPDATE_ORIG_HEAD |
 		      RESET_WORKING_TREE_RUN_POST_CHECKOUT_HOOK;
 	ropts.head_msg = msg.buf;
diff --git a/reset.c b/reset.c
index 99f2c1b012..4bde5d8dc6 100644
--- a/reset.c
+++ b/reset.c
@@ -92,6 +92,7 @@ int reset_working_tree(struct repository *r,
 	const char *switch_to_branch = opts->branch;
 	unsigned reset_hard = opts->flags & RESET_WORKING_TREE_HARD;
 	unsigned refs_only = opts->flags & RESET_WORKING_TREE_REFS_ONLY;
+	unsigned update_head = opts->flags & RESET_WORKING_TREE_UPDATE_HEAD;
 	unsigned update_orig_head = opts->flags & RESET_WORKING_TREE_UPDATE_ORIG_HEAD;
 	unsigned dry_run = opts->flags & RESET_WORKING_TREE_DRY_RUN;
 	struct object_id *head = NULL, head_oid;
@@ -113,6 +114,9 @@ int reset_working_tree(struct repository *r,
 	if (opts->branch_msg && !opts->branch)
 		BUG("branch reflog message given without a branch");
 
+	if (update_orig_head && !update_head)
+		BUG("cannot update ORIG_HEAD without updating HEAD" );
+
 	if (!refs_only && !dry_run && repo_hold_locked_index(r, &lock, LOCK_REPORT_ON_ERROR) < 0) {
 		ret = -1;
 		goto leave_reset_head;
@@ -129,7 +133,7 @@ int reset_working_tree(struct repository *r,
 		oid = &head_oid;
 
 	if (refs_only) {
-		if (!dry_run)
+		if (!dry_run && update_head)
 			return update_refs(r, opts, oid, head);
 		return 0;
 	}
@@ -197,7 +201,8 @@ int reset_working_tree(struct repository *r,
 		goto leave_reset_head;
 	}
 
-	if (oid != &head_oid || update_orig_head || switch_to_branch)
+	if (update_head &&
+	    (oid != &head_oid || update_orig_head || switch_to_branch))
 		ret = update_refs(r, opts, oid, head);
 
 leave_reset_head:
diff --git a/reset.h b/reset.h
index 898e4a1e95..38b2891b53 100644
--- a/reset.h
+++ b/reset.h
@@ -19,14 +19,17 @@ enum reset_working_tree_flags {
 	/* Only update refs, do not touch the worktree */
 	RESET_WORKING_TREE_REFS_ONLY = (1 << 3),
 
-	/* Update ORIG_HEAD as well as HEAD */
-	RESET_WORKING_TREE_UPDATE_ORIG_HEAD = (1 << 4),
+	/* Update HEAD */
+	RESET_WORKING_TREE_UPDATE_HEAD = (1 << 4),
+
+	/* Update ORIG_HEAD */
+	RESET_WORKING_TREE_UPDATE_ORIG_HEAD = (1 << 5),
 
 	/*
 	 * Perform a dry-run by performing the operation without updating
 	 * any user-visible state.
 	 */
-	RESET_WORKING_TREE_DRY_RUN = (1 << 5),
+	RESET_WORKING_TREE_DRY_RUN = (1 << 6),
 };
 
 struct reset_working_tree_options {
diff --git a/sequencer.c b/sequencer.c
index 4efe831178..e905b1b2d9 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4678,7 +4678,8 @@ static void create_autostash_internal(struct repository *r,
 	    has_uncommitted_changes(r, 1)) {
 		struct child_process stash = CHILD_PROCESS_INIT;
 		struct reset_working_tree_options ropts = {
-			.flags = RESET_WORKING_TREE_HARD,
+			.flags = RESET_WORKING_TREE_HARD |
+				 RESET_WORKING_TREE_UPDATE_HEAD,
 		};
 		struct object_id oid;
 
@@ -4873,6 +4874,7 @@ static int checkout_onto(struct repository *r, struct replay_opts *opts,
 		.oid = onto,
 		.orig_head = orig_head,
 		.flags = RESET_WORKING_TREE_DETACH |
+			 RESET_WORKING_TREE_UPDATE_HEAD |
 			 RESET_WORKING_TREE_UPDATE_ORIG_HEAD |
 			 RESET_WORKING_TREE_RUN_POST_CHECKOUT_HOOK,
 		.head_msg = reflog_message(opts, "start", "checkout %s",

-- 
2.55.0.rc0.738.g0c8ab3ebcc.dirty

