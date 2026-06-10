Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9842F3C1096
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 08:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781081563; cv=none; b=L+wm+t1UN6//XzWL8GA9dvQDbSSGKj5/e2QFeUM18fR2V9hyvPxoFQM53RyFPZXmriqoWO6v8oWMQniwGadQ2/ypPaWVOZDwde4llrCsIjT77741iVchT9/lMDI/acZ6XrVUBeMUDElSK7xOid3c2hAABKm5KWJ5ZNVoPPSserk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781081563; c=relaxed/simple;
	bh=vl4v0npmAK7aynY7mzbvd1hINV3PVRwQKxAdMku+D70=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NJYLLP0GaZGO09UTt6PfPSREI0Iw9sKcsN38N367qFE2M0XNGi/Gt3wUk3bvyekJxUhWGWLDAkNqUSVkecL+x59OT3Wy+v+Yo3y4C/IT2Nzs+6iI3tGo/lNHHyOVXUFow+2+xmqq0JnUaI4YaZCnFaSR7TT5t+32O7UD2g70R30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jiiDw0HC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ga8ObzXn; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jiiDw0HC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ga8ObzXn"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id C26311D000A9;
	Wed, 10 Jun 2026 04:52:40 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 10 Jun 2026 04:52:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781081560;
	 x=1781167960; bh=5S6CmnefYUHMVfmoviMiuHQJJ0Mlx0fbRPq53F8P/eQ=; b=
	jiiDw0HCbUmPeNqdjJAMjL2L12Gs2KCjiVrPLOWLp6oysSbfSj0XjPiuQa28G38A
	43yEIYLCsSn3nBmebyKeTmtiBjWwOFaX1SOWJbyPtp+yMG4IWo/FxJQAvqUPopph
	LpZ8ey75Qc5rs9JbuJ4Wdwd8LIN6m5Lxh9rp09vR3hP86ERPA3mv78/zZAk9R26R
	uUJEcp+54AqvsBT7AqhgOHs5QHUuZUQ+8AUlL3HP7oANLfBjuIFbE9oqQMWt+kQU
	QZNJf/NAPN58rh/94hjRDt89fi16s35nm3f8vqqW+u0LyTQZTFPVpkGMkTaUVRJb
	3czwxOAxhTi9OMyzf08cFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781081560; x=
	1781167960; bh=5S6CmnefYUHMVfmoviMiuHQJJ0Mlx0fbRPq53F8P/eQ=; b=g
	a8ObzXnJyvqB9OSGFeEVc5lSeyx1RoKG8/ZqOmiQ0L0IcFQ5ngZW4Y8nDocJ97L4
	iNaQekw0KTa6Obv6HZvTkAyXvOZeXCgVEFWcO/B3iOvCEZGzYk2g+UYPbet28AcO
	xmAeccrN61HVrnpN3Kjgx7TQBjfBKWypLKmKlXyMmJ8N/8f6w3yRcnmAbFVJ76aA
	z/qZfR93Bsa9Sw4f+ZjjnFiGCfezRoMw9qZYxUpTqs7hfKCWzGMdNUJvYV4/iIDL
	lFj0wkfoiABaTqvQnUCgDmDucDUp9W7wfY5bSnQWvM+Vgl+cRFpPPjU100Aiq1HI
	UKBrfamTRHD7Ig1qpPriQ==
X-ME-Sender: <xms:2CUparOQpCdSDJsMrFlYjc-RjnSHbSlxESAXos7550DXh49Qjg81Pw>
    <xme:2CUpaneYt990LkXrtS-vGqMKg72ex2vmt0c9I7M2_atwoJZxeX5S3RnMyX9lcnsiJ
    RdmIgSvIBdy-SJdC73JCGE7ZbjYbys7VQujDvFGlosqm5-YqS6Tqg>
X-ME-Received: <xmr:2CUpaqWR8CjEddbhiO_Zp3bbwTk3Uj2KwLhp7H-j6FD_CbH1QnCu1SOfIkoAMyUJtajN8mUJdTBOrDTIcqVlwc8rd1Xe-MG6JPmk7cYlwQ>
X-ME-Proxy-Cause: dmFkZTF+2VdknJdj8ZOu+QNsFFL2Cp4b8MqxYtg2L4k2lvcdsh9YrzSboE6bPt4KoDjGwC
    6qElUpuMdHcBesalKO5yqWKug91R08Ywpa4ms3332VV8ZUZovufNOt6cKxX+PDS4N5TOlh
    UkArHXbI5L+hKOXl+CtfdlZZjrWx66Fz//JhA/5xtF3/vAXeWCf3FpCs+sPLHHPIfvphj3
    vnmi+RddKNPLB2ik3E4aLRriPZHJaWRwXmwXbswq7zGuiiduIG4/L0Ut90WbLe4URCzcUF
    VVeXIIybjrzhYBZ2WLlFI1H1Mz/pN6DdD+zzryFnw/IR2vHeFP0fSf5P1EeJPM80Et84IV
    AR45xO1WT4VTU8dnpnwCbZo31kLcb7hDOYIckJ3xK5UE2DjOAGg3v4UaFLLOwf4HMlZ5Jb
    cOBroZCs6AP3WvwHsVCXoIRnZFIDLIyyYgkLVqp7WCA5Dt9SgE+pYJpgdLTqNVyJECQdAZ
    3dPkMHJibOcvFj3R9Ln+rcCAniCECkQ/ZQ2YKkWJIlvvhVhkpiTGfZ9MFHpjTs6S7e+z7b
    JRNO/5pzXay6TabM3hgd9YFWbE+CLnBIvZCMixFCD1RXCmJzGSRiSa4jCoRDGbUuZYBWSX
    GK6mgDqiB0meeJ2cKQe0JSEPqLWb1LGcCuJJualXl9roqmX9dS9+ULU2CSLg
X-ME-Proxy: <xmx:2CUpaviaYO9xuzVh0VqIPwRi_Asodr2xRV8YKgY1sM7Tg25kDhd6Gw>
    <xmx:2CUpap8TNvoi3oostlbQAFOQ-I6FjSYwZjK-O4ZCtu4Bxo4bAvsv-Q>
    <xmx:2CUpahZ2rA6cTekA-pp6tmbYPa1H9tk0k5CTki9Kyc7iW8RVTxmlqg>
    <xmx:2CUpag1mkWohjDWoyfQkRt4I7gOwY4hlBsyqMgfOByHkVvOHKhfK9A>
    <xmx:2CUpapzBkrev1USehGwTq6XCUdaK7QovcNt6gJeBsqOPlesdq666pCa7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 04:52:39 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1140e565 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 10 Jun 2026 08:52:39 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 10 Jun 2026 10:52:23 +0200
Subject: [PATCH v4 03/10] reset: rename `reset_head()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-b4-pks-history-drop-v4-3-70d5f0ae8c25@pks.im>
References: <20260610-b4-pks-history-drop-v4-0-70d5f0ae8c25@pks.im>
In-Reply-To: <20260610-b4-pks-history-drop-v4-0-70d5f0ae8c25@pks.im>
To: git@vger.kernel.org
Cc: Pablo Sabater <pabloosabaterr@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.15.2

In a subsequent commit we're about to adapt `reset_head()` so that the
reference update to HEAD is optional, only. At this point the function
starts to feel misnamed, as it doesn't necessarily have anything to do
with the HEAD reference anymore. The gist of the function then is that
we reset the working tree to a specific new commit, updating both the
index and the checked-out files.

Rename it to `reset_working_tree()` to better reflect that.

Note that we don't adjust the flags yet. This will happen in a
subsequent commit.

Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
---
 builtin/rebase.c | 20 ++++++++++----------
 reset.c          |  5 +++--
 reset.h          |  4 ++--
 sequencer.c      |  8 ++++----
 4 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index fa4f5d9306..22fbba3c62 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -592,7 +592,7 @@ static int finish_rebase(struct rebase_options *opts)
 static int move_to_original_branch(struct rebase_options *opts)
 {
 	struct strbuf branch_reflog = STRBUF_INIT, head_reflog = STRBUF_INIT;
-	struct reset_head_opts ropts = { 0 };
+	struct reset_working_tree_options ropts = { 0 };
 	int ret;
 
 	if (!opts->head_name)
@@ -610,7 +610,7 @@ static int move_to_original_branch(struct rebase_options *opts)
 	ropts.flags = RESET_HEAD_REFS_ONLY;
 	ropts.branch_msg = branch_reflog.buf;
 	ropts.head_msg = head_reflog.buf;
-	ret = reset_head(the_repository, &ropts);
+	ret = reset_working_tree(the_repository, &ropts);
 
 	strbuf_release(&branch_reflog);
 	strbuf_release(&head_reflog);
@@ -685,7 +685,7 @@ static int run_am(struct rebase_options *opts)
 
 	status = run_command(&format_patch);
 	if (status) {
-		struct reset_head_opts ropts = { 0 };
+		struct reset_working_tree_options ropts = { 0 };
 		unlink(rebased_patches);
 		free(rebased_patches);
 		child_process_clear(&am);
@@ -693,7 +693,7 @@ static int run_am(struct rebase_options *opts)
 		ropts.oid = &opts->orig_head->object.oid;
 		ropts.branch = opts->head_name;
 		ropts.default_reflog_action = opts->reflog_action;
-		reset_head(the_repository, &ropts);
+		reset_working_tree(the_repository, &ropts);
 		error(_("\ngit encountered an error while preparing the "
 			"patches to replay\n"
 			"these revisions:\n"
@@ -855,7 +855,7 @@ static int rebase_config(const char *var, const char *value,
 static int checkout_up_to_date(struct rebase_options *options)
 {
 	struct strbuf buf = STRBUF_INIT;
-	struct reset_head_opts ropts = { 0 };
+	struct reset_working_tree_options ropts = { 0 };
 	int ret = 0;
 
 	strbuf_addf(&buf, "%s: checkout %s",
@@ -866,7 +866,7 @@ static int checkout_up_to_date(struct rebase_options *options)
 	if (!ropts.branch)
 		ropts.flags |=  RESET_HEAD_DETACH;
 	ropts.head_msg = buf.buf;
-	if (reset_head(the_repository, &ropts) < 0)
+	if (reset_working_tree(the_repository, &ropts) < 0)
 		ret = error(_("could not switch to %s"), options->switch_to);
 	strbuf_release(&buf);
 
@@ -1116,7 +1116,7 @@ int cmd_rebase(int argc,
 	int reschedule_failed_exec = -1;
 	int allow_preemptive_ff = 1;
 	int preserve_merges_selected = 0;
-	struct reset_head_opts ropts = { 0 };
+	struct reset_working_tree_options ropts = { 0 };
 	struct option builtin_rebase_options[] = {
 		OPT_STRING(0, "onto", &options.onto_name,
 			   N_("revision"),
@@ -1385,7 +1385,7 @@ int cmd_rebase(int argc,
 		rerere_clear(the_repository, &merge_rr);
 		string_list_clear(&merge_rr, 1);
 		ropts.flags = RESET_HEAD_HARD;
-		if (reset_head(the_repository, &ropts) < 0)
+		if (reset_working_tree(the_repository, &ropts) < 0)
 			die(_("could not discard worktree changes"));
 		remove_branch_state(the_repository, 0);
 		if (read_basic_state(&options))
@@ -1410,7 +1410,7 @@ int cmd_rebase(int argc,
 		ropts.head_msg = head_msg.buf;
 		ropts.branch = options.head_name;
 		ropts.flags = RESET_HEAD_HARD;
-		if (reset_head(the_repository, &ropts) < 0)
+		if (reset_working_tree(the_repository, &ropts) < 0)
 			die(_("could not move back to %s"),
 			    oid_to_hex(&options.orig_head->object.oid));
 		strbuf_release(&head_msg);
@@ -1880,7 +1880,7 @@ int cmd_rebase(int argc,
 			RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
 	ropts.head_msg = msg.buf;
 	ropts.default_reflog_action = options.reflog_action;
-	if (reset_head(the_repository, &ropts)) {
+	if (reset_working_tree(the_repository, &ropts)) {
 		ret = error(_("Could not detach HEAD"));
 		goto cleanup_autostash;
 	}
diff --git a/reset.c b/reset.c
index 3b3cb74dab..799596398b 100644
--- a/reset.c
+++ b/reset.c
@@ -12,7 +12,7 @@
 #include "hook.h"
 
 static int update_refs(struct repository *repo,
-		       const struct reset_head_opts *opts,
+		       const struct reset_working_tree_options *opts,
 		       const struct object_id *oid,
 		       const struct object_id *head)
 {
@@ -85,7 +85,8 @@ static int update_refs(struct repository *repo,
 	return ret;
 }
 
-int reset_head(struct repository *r, const struct reset_head_opts *opts)
+int reset_working_tree(struct repository *r,
+		       const struct reset_working_tree_options *opts)
 {
 	const struct object_id *oid = opts->oid;
 	const char *switch_to_branch = opts->branch;
diff --git a/reset.h b/reset.h
index a28f81829d..f130152014 100644
--- a/reset.h
+++ b/reset.h
@@ -17,7 +17,7 @@
 /* Update ORIG_HEAD as well as HEAD */
 #define RESET_ORIG_HEAD (1<<4)
 
-struct reset_head_opts {
+struct reset_working_tree_options {
 	/*
 	 * The commit to checkout/reset to. Defaults to HEAD.
 	 */
@@ -55,6 +55,6 @@ struct reset_head_opts {
 	const char *default_reflog_action;
 };
 
-int reset_head(struct repository *r, const struct reset_head_opts *opts);
+int reset_working_tree(struct repository *r, const struct reset_working_tree_options *opts);
 
 #endif
diff --git a/sequencer.c b/sequencer.c
index 1ee4b2875b..d73ecf0384 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4677,7 +4677,7 @@ static void create_autostash_internal(struct repository *r,
 	if (has_unstaged_changes(r, 1) ||
 	    has_uncommitted_changes(r, 1)) {
 		struct child_process stash = CHILD_PROCESS_INIT;
-		struct reset_head_opts ropts = { .flags = RESET_HEAD_HARD };
+		struct reset_working_tree_options ropts = { .flags = RESET_HEAD_HARD };
 		struct object_id oid;
 
 		strvec_pushl(&stash.args,
@@ -4707,7 +4707,7 @@ static void create_autostash_internal(struct repository *r,
 
 		if (!silent)
 			printf(_("Created autostash: %s\n"), buf.buf);
-		if (reset_head(r, &ropts) < 0)
+		if (reset_working_tree(r, &ropts) < 0)
 			die(_("could not reset --hard"));
 		discard_index(r->index);
 		if (repo_read_index(r) < 0)
@@ -4867,7 +4867,7 @@ static int checkout_onto(struct repository *r, struct replay_opts *opts,
 			 const char *onto_name, const struct object_id *onto,
 			 const struct object_id *orig_head)
 {
-	struct reset_head_opts ropts = {
+	struct reset_working_tree_options ropts = {
 		.oid = onto,
 		.orig_head = orig_head,
 		.flags = RESET_HEAD_DETACH | RESET_ORIG_HEAD |
@@ -4876,7 +4876,7 @@ static int checkout_onto(struct repository *r, struct replay_opts *opts,
 					   onto_name),
 		.default_reflog_action = sequencer_reflog_action(opts)
 	};
-	if (reset_head(r, &ropts)) {
+	if (reset_working_tree(r, &ropts)) {
 		apply_autostash(rebase_path_autostash());
 		sequencer_remove_state(opts);
 		return error(_("could not detach HEAD"));

-- 
2.54.0.1189.g8c84645362.dirty

