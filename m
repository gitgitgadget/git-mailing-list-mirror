Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9D641B36E
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 11:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782905749; cv=none; b=n37JHjUvHh4wF9Si5/Bt3GhHVdiivKly+BCA8JOClovFyCKOJHi5gU+zNbNxMOzJ0ljg5KO8IqYA5uj+EU7rQZ8diuvnC25wnbivqOR7lle8FsYLwpJKtdYYG3fXQhZHUVw5S0VWDWCyozMCmQZ4PaWtkgxFx+jIMDKHMfUlmCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782905749; c=relaxed/simple;
	bh=N9pd5ZgFqUnO1yr7PU3UKWEin4DbYNLhbzvum5/txmw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cr8WwLo8XUPkXK80AMEP1jn3vx8C/sGYprUncwx825HC7CFZ3imqvOaEDnE/mwSsdUNRsvFbNYSWH6U9O8x0w31jNhnxHmtQHZluaOC5/53/HL4YoAkJVWIfVU/O3y743Igbp4Qzf58j06utASCQxCqnIclSlcGoZNoDvyW9PfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qrRHBmhs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Pn54xB1I; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qrRHBmhs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Pn54xB1I"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id E5726EC01B7;
	Wed,  1 Jul 2026 07:35:46 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 01 Jul 2026 07:35:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782905746;
	 x=1782992146; bh=y9sSBIbYgrbNQQWl/6KoVx8Ibc5xnLmCzzrEgB7MS+c=; b=
	qrRHBmhspaWeyHhGYowF9qeesHJfMPiSnIqLUffAZuT3ig0dgqhPHTDqeaCCd8pX
	t97MgV2pPF1JIH2L0kCzKoaKFfI803tLWEGQLk4ICoPUVWsC/qJpd4twouo1wBap
	myto220RfFJX8S1u1d0HrvD4ybGbQpgzUkT/GbGv6Nv9cCsWw7EU/hlL4ImL3Gvl
	E+F0IvxEY+sKaju2UCCzUdeqokSAOLIHj+KFcBr1KlJCKXZ4KVcNTaujT5uDxBSD
	/xc+1LqKcoJ3QoX1qlFC3DhZNpSGDNhQCsJ004jqadxV+c8M54zg5rEfkEr1SOaH
	XFoEks6eVhjlgMSf7H6/Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782905746; x=
	1782992146; bh=y9sSBIbYgrbNQQWl/6KoVx8Ibc5xnLmCzzrEgB7MS+c=; b=P
	n54xB1IC8aklPhhC/tE89oer399ySk0vZN39faYgHn+65C7OksBgd4bD4BFj+wtx
	AtbMEx4uYl+LgNpVppkGIRBUnPEhZSVH8wTg5hiZzrayGL1CFgvb1+dpO8cqwSWa
	dR0RMbAnm2o6LpQ8+5hhvvslNz8vmp2ElY0C5HZnq7kxqxkOowt9/nTkspXDCz9c
	kODXR/Ije1cvNR5V6+Fr5piNiWgApBNFew6u3FLmjitPpSaoGoseW5+7w0op/m+Q
	RkKoLXqcob10OOpvMNj1SDVJGo90eOwUc9/rvTNJD43+n+wXyICxSYKBCTUzEFW8
	gcyUoJv/cW0RlZWFbo8jA==
X-ME-Sender: <xms:kvtEaixq1LH1fMMb__vJeicXmzjqlh9GkjPjnYPWUORxc_D26D6V5w>
    <xme:kvtEanksUnu26ex1MzjdfcM_paarS4ekrmFD6nGrIid2fqiGWOJqqM_QzTpmBYrsy
    RTV061203OPzlIgxNOw5ygn8g4xHnM-aFHOzOP7jpelW-uZblISSAY>
X-ME-Received: <xmr:kvtEarl086n7_tBtY3kYyyQtXfrpYbarbpSlKMBUqnTE5I16vQyAkIhsY6G04fn6DOz6feQVG6tIRfyNrcNno72RGdLqFUlaz1JsH23L5ME>
X-ME-Proxy-Cause: dmFkZTEZoO6HolNFiuzhqEVK1EXq4BbCn1tdQX7LTJIMJcT/+latCDErJzD4+CwgisT7ri
    qxkn+QB2VfpeBpgOV5q2sBGT63aEOuYhfWwjT+wgnaZ2qGTsJfaJHBVk347IlsaCNTe39N
    jrZm/FsYSWHGfvBlbmbsEFy/XtzODL8fdqiFNJeGFn2lrHVPGPL/Yr6cOMglYCr7uBXs7r
    aXJwkPam35tJtUVY8r7/VZg2IyQl/w9r8/QisqR4rjlYUkyluAeVVxaLcVOMBGocW1MGez
    Nwenq9cyAhPKHT6bW4GOhAoe1hp9EC68DfdP8WD4TQ3JQn6e5yBMnRKyOIrDWHKuIfRTDP
    qspVHYRmbkj5vepz0GqUTTGIXOnyj6uxiKTXLT8yUt+DcjjinnQLK74I+FcyaebOHxew74
    NQ/EC9QBgmrtz/dehdhZc0vCIOZO9JIko68EJGi+nUdhR/L9sHxPzEjqSLyXKt6bZQSdpU
    XhGl1i33amuTOdY6B96H/ylkIRFxZXUbhctBLPQDilldMtu0x90rL3tdHowyIkR42l3D9U
    SHvPOvghPza9BnjKzuUp3rQVKBwihcB9htjoXwDfFJQKtIvxVxrOKmw4XrvZyk8pZ4499E
    kJudU68CZlWfe77u0qGtbLFThWTz+8nNR9itxl1SQaSE8Y05bGGDSXB5kGOQ
X-ME-Proxy: <xmx:kvtEapwHQ69EB3NiQH03UFU7lA9cu4EpMpVHa89oikTRbFQBo2OkIQ>
    <xmx:kvtEagrcODK0WqZYTYsgUibSV_3klG7UXI3CCqKGJk14mTQdl2p-5A>
    <xmx:kvtEao6w7Pu5Y-PjF_Nlsc-2WSed1Bs4G9ZZTv8UOdqHiVlL4yIYnw>
    <xmx:kvtEaneckrxVb5wqpeDVs5YBZ_LekzF3yh81XWIVWZ4oRY8VcI86Wg>
    <xmx:kvtEanbtGJ1U9XG2e679E2r9Cg8y0IaTgO1-0Z1igRYxXMbMSzdMEosF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 07:35:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 99985e24 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 1 Jul 2026 11:35:45 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 01 Jul 2026 13:35:30 +0200
Subject: [PATCH v8 03/11] reset: rename `reset_head()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-b4-pks-history-drop-v8-3-19b5cdf1facd@pks.im>
References: <20260701-b4-pks-history-drop-v8-0-19b5cdf1facd@pks.im>
In-Reply-To: <20260701-b4-pks-history-drop-v8-0-19b5cdf1facd@pks.im>
To: git@vger.kernel.org
Cc: Pablo Sabater <pabloosabaterr@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>, 
 Christian Couder <chriscool@tuxfamily.org>
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
Signed-off-by: Patrick Steinhardt <ps@pks.im>
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
2.55.0.795.g602f6c329a.dirty

