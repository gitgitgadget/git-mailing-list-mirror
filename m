Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E433AD530
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 08:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781081565; cv=none; b=TRGK23PglMvBqWbHI/TWis+GNpseRFPs1Q97MwKTS0BZSV5hFy08etHSCcAoKdWSBxaCvvWlf4DMX/NoW9H5aHqme3FXbDydAFwjTaV7FsEs2PcC4B8tz0ByNZryT0G7Lc8lfsmqxGWP+xXcsNPEaSWgfDM7VNZ0MmOMNFiRR1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781081565; c=relaxed/simple;
	bh=bSf8iErqGbiZxw/zxiiYU9fq+L4q39GyxO0iN6s7bu0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wixfr/DEwK1pWjj0NccPukt+d3xeFB7HATBPpmYAc93PVsKkHSpLoxmF7Yi8zi61EAoSYBBEOoK0lpbdZ7wES0tkkaEes2nW9Wq96+gpTMKQ7EkOr3g3zKR8PvpI/t3P39E1gLys/MXQmbI76Wz4KjCiheXdgZjq6l/zPW7dtko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=vsMorPYp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CCS1ku0o; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="vsMorPYp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CCS1ku0o"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4C3657A0067;
	Wed, 10 Jun 2026 04:52:43 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 10 Jun 2026 04:52:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781081563;
	 x=1781167963; bh=XqGdYvpgUDtk8V4An2rKol9F75S2p48by6LmYxZ4B0I=; b=
	vsMorPYpJte2l9EF3nDNyDfUxEW6qa/JSQNI5BUdIzi0ElW+VXvOTG3kHGdPD/zN
	0gUnY8Zp3D3P/FhWHpFMBMGbGop+R0XRDyX00+elkHrxZtoKc+nNo5NOTfLGcKro
	rEasbMdBIG9Sz1Z/DtI7x02XAzax9Tu5jg7aSi0MXA/pEsWhjGMPVEVu6g5SEHMF
	2E1Df52CZOr3QHR/MqmfEbWlCWXM6FzVjrj1OBSWwQ+Eu9pAGgcwQFKU2SKqANvN
	8eT98vkS4INuCNbc1E0br1rbbag2YKAUBnVJQw7RkLspRrmCFU4hN4EgnA5egW1b
	4WpfPKKOyq2Een3Y5Skf2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781081563; x=
	1781167963; bh=XqGdYvpgUDtk8V4An2rKol9F75S2p48by6LmYxZ4B0I=; b=C
	CS1ku0o/ha28MZ06QtlzQFkaeku8+sedvhdfu84BvncYpuIOKlrgDxXXepu+jmUo
	eCAPpo69ByE0G7wrY3ABmbmc+91fFJ4uullG2JBEDvXybYXQ9DAe430rWjw7cTUh
	rkbUBt3uyYTkDmtRlO71HhCH4oDvho2VWIxUuA3WgWGxED0/lPvbeafMBgYhOY0J
	H7RpEDa0uZ0+r2mDmPpdfPb/vCqsz6vq3axTPf4pxGnnOzpJ8p4SoFbeWS4CHlXG
	zrxWrjUo/Gcamsc7NbHFXdwtrVbMxEvn/Wfx6mstYkIkXl18ur5aeE12o2hj8OEV
	znoXGgNWkxfsSXM353eUQ==
X-ME-Sender: <xms:2yUpam0cXFfj5aO9vmIp1X9rIbjI9QZSmc__YVtHpmPv0cqC4YzizQ>
    <xme:2yUpaqky3zNYa6ToEypz-AjFZozouyBkTrtBDB0S3GGVpDIhDt_ZvFKwh4P3h-imt
    AyPv6R3yXlDOtMaZVtkdbiaAzQazUuVJsQsH6iaUzBwIz3AZAPRzKQ>
X-ME-Received: <xmr:2yUpau8kbhRUCpvoDzji84bIR25w6M52b_Ke_NWDjhDRFAma31_PkQTgJ9VXZY31-FihzNGE_3phvc2wvZG2O0AdZL5vPb1Io_3n5KKGwQ>
X-ME-Proxy-Cause: dmFkZTE5orGA5proHaW7Mu8uqvCVIExIrc2eP/p2P5Lm+ca4fHgckoyg8H1FtO/I7wT2Aj
    nXYeRcsregd1VB/JFKht2uDDid/OrQSlnc1rqHixpgHWdGIhWP17+22VFQ0Y6OwEAagcoj
    j3h3elG5ybg8NK1JUgtfKMcMJO0hc7MBT/fQSZgmzrWwAwK1miB50XcHw7Yhzf8w1O5s6q
    Xg+5TZo5RxXTWuQ2D1I8EFmJPyzn8JA/uapOEANuLON+tT1nzkzucsw85WLhwcl+lLqh9w
    YTaz2KWmNElIawZywr8oaQfhcw0Kc8b74JeCKXq299mQ2+lJrLP2v9dXRRWz063lXrorVX
    52mqzyRF72EOQCsLU1HNBL4Yaq8KeDKD9G+PYnQLj5N7mTNCagwa6B10gFVF3551LE1DMA
    FWzo9+0nCgxmC+PrtkI4rikXhdY2e1ACLp6kERo7W/hN96s+rzeHLUs+nYH6syEbQkxrcE
    2R83a0Y8kwfopRZ458+GFBW2Kr5yDKSBeG60dcTSzjHHdH56H55P6VzshIAQuWrJvFCl7W
    ZnW+JAJENjM0pDT2NC+8stHJAoLXq7tGeOCu1WPzj2OpatL1TWZnc+fJHwLkvOpjXm5Ztg
    mrYAZhXTeMQEs6VuiNt4y0CBkzWQ476QTrEO9+HMYJ3WUCF6TjdHgzOU8RWg
X-ME-Proxy: <xmx:2yUpanrNZPpYQ1P9cwb2tfuuPseG4oeF9XtCU5bg3zhLgBef7i_V6Q>
    <xmx:2yUpavlgOLyXDRSW7zWrl9EQzJBhnkPvvYLzeaiR9Ix1NcW5hISO6A>
    <xmx:2yUpamhBHhYAWaNcQ02xmW2F5BUqSPIdXkNHsEPs7acDOEDA6SMm4Q>
    <xmx:2yUpavejSF7gFc3ePoP2Jk7qZiygq68G8rtX4tbjIP-MP16IInTFpA>
    <xmx:2yUpaj7FGtCXJ7A1Ki_6wf8Ng5Eg-ERYKkumPToprSr8JU7KZ5rvr62J>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 04:52:42 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 24fcb61c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 10 Jun 2026 08:52:41 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 10 Jun 2026 10:52:24 +0200
Subject: [PATCH v4 04/10] reset: modernize flags passed to
 `reset_working_tree()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-b4-pks-history-drop-v4-4-70d5f0ae8c25@pks.im>
References: <20260610-b4-pks-history-drop-v4-0-70d5f0ae8c25@pks.im>
In-Reply-To: <20260610-b4-pks-history-drop-v4-0-70d5f0ae8c25@pks.im>
To: git@vger.kernel.org
Cc: Pablo Sabater <pabloosabaterr@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.15.2

The flags passed to `reset_working_tree()` are declared as defines. This
has fallen a bit out of practice nowadays, where we instead prefer to
use enums. Furthermore, the prefix of those flags does not match the
function name anymore after the rename in the preceding commit.

Adapt the code to follow modern best practices and adapt the flag names.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/rebase.c | 15 ++++++++-------
 reset.c          | 12 ++++++------
 reset.h          | 31 +++++++++++++++++++------------
 sequencer.c      |  9 ++++++---
 4 files changed, 39 insertions(+), 28 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 22fbba3c62..06dcbaf5e8 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -607,7 +607,7 @@ static int move_to_original_branch(struct rebase_options *opts)
 	strbuf_addf(&head_reflog, "%s (finish): returning to %s",
 		    opts->reflog_action, opts->head_name);
 	ropts.branch = opts->head_name;
-	ropts.flags = RESET_HEAD_REFS_ONLY;
+	ropts.flags = RESET_WORKING_TREE_REFS_ONLY;
 	ropts.branch_msg = branch_reflog.buf;
 	ropts.head_msg = head_reflog.buf;
 	ret = reset_working_tree(the_repository, &ropts);
@@ -862,9 +862,9 @@ static int checkout_up_to_date(struct rebase_options *options)
 		    options->reflog_action, options->switch_to);
 	ropts.oid = &options->orig_head->object.oid;
 	ropts.branch = options->head_name;
-	ropts.flags = RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
+	ropts.flags = RESET_WORKING_TREE_RUN_POST_CHECKOUT_HOOK;
 	if (!ropts.branch)
-		ropts.flags |=  RESET_HEAD_DETACH;
+		ropts.flags |=  RESET_WORKING_TREE_DETACH;
 	ropts.head_msg = buf.buf;
 	if (reset_working_tree(the_repository, &ropts) < 0)
 		ret = error(_("could not switch to %s"), options->switch_to);
@@ -1384,7 +1384,7 @@ int cmd_rebase(int argc,
 
 		rerere_clear(the_repository, &merge_rr);
 		string_list_clear(&merge_rr, 1);
-		ropts.flags = RESET_HEAD_HARD;
+		ropts.flags = RESET_WORKING_TREE_HARD;
 		if (reset_working_tree(the_repository, &ropts) < 0)
 			die(_("could not discard worktree changes"));
 		remove_branch_state(the_repository, 0);
@@ -1409,7 +1409,7 @@ int cmd_rebase(int argc,
 		ropts.oid = &options.orig_head->object.oid;
 		ropts.head_msg = head_msg.buf;
 		ropts.branch = options.head_name;
-		ropts.flags = RESET_HEAD_HARD;
+		ropts.flags = RESET_WORKING_TREE_HARD;
 		if (reset_working_tree(the_repository, &ropts) < 0)
 			die(_("could not move back to %s"),
 			    oid_to_hex(&options.orig_head->object.oid));
@@ -1876,8 +1876,9 @@ int cmd_rebase(int argc,
 		    options.reflog_action, options.onto_name);
 	ropts.oid = &options.onto->object.oid;
 	ropts.orig_head = &options.orig_head->object.oid;
-	ropts.flags = RESET_HEAD_DETACH | RESET_ORIG_HEAD |
-			RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
+	ropts.flags = RESET_WORKING_TREE_DETACH |
+		      RESET_WORKING_TREE_UPDATE_ORIG_HEAD |
+		      RESET_WORKING_TREE_RUN_POST_CHECKOUT_HOOK;
 	ropts.head_msg = msg.buf;
 	ropts.default_reflog_action = options.reflog_action;
 	if (reset_working_tree(the_repository, &ropts)) {
diff --git a/reset.c b/reset.c
index 799596398b..4ca7f23a25 100644
--- a/reset.c
+++ b/reset.c
@@ -16,9 +16,9 @@ static int update_refs(struct repository *repo,
 		       const struct object_id *oid,
 		       const struct object_id *head)
 {
-	unsigned detach_head = opts->flags & RESET_HEAD_DETACH;
-	unsigned run_hook = opts->flags & RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
-	unsigned update_orig_head = opts->flags & RESET_ORIG_HEAD;
+	unsigned detach_head = opts->flags & RESET_WORKING_TREE_DETACH;
+	unsigned run_hook = opts->flags & RESET_WORKING_TREE_RUN_POST_CHECKOUT_HOOK;
+	unsigned update_orig_head = opts->flags & RESET_WORKING_TREE_UPDATE_ORIG_HEAD;
 	const struct object_id *orig_head = opts->orig_head;
 	const char *switch_to_branch = opts->branch;
 	const char *reflog_branch = opts->branch_msg;
@@ -90,9 +90,9 @@ int reset_working_tree(struct repository *r,
 {
 	const struct object_id *oid = opts->oid;
 	const char *switch_to_branch = opts->branch;
-	unsigned reset_hard = opts->flags & RESET_HEAD_HARD;
-	unsigned refs_only = opts->flags & RESET_HEAD_REFS_ONLY;
-	unsigned update_orig_head = opts->flags & RESET_ORIG_HEAD;
+	unsigned reset_hard = opts->flags & RESET_WORKING_TREE_HARD;
+	unsigned refs_only = opts->flags & RESET_WORKING_TREE_REFS_ONLY;
+	unsigned update_orig_head = opts->flags & RESET_WORKING_TREE_UPDATE_ORIG_HEAD;
 	struct object_id *head = NULL, head_oid;
 	struct tree_desc desc[2] = { { NULL }, { NULL } };
 	struct lock_file lock = LOCK_INIT;
diff --git a/reset.h b/reset.h
index f130152014..2e5826de99 100644
--- a/reset.h
+++ b/reset.h
@@ -6,16 +6,22 @@
 
 #define GIT_REFLOG_ACTION_ENVIRONMENT "GIT_REFLOG_ACTION"
 
-/* Request a detached checkout */
-#define RESET_HEAD_DETACH (1<<0)
-/* Request a reset rather than a checkout */
-#define RESET_HEAD_HARD (1<<1)
-/* Run the post-checkout hook */
-#define RESET_HEAD_RUN_POST_CHECKOUT_HOOK (1<<2)
-/* Only update refs, do not touch the worktree */
-#define RESET_HEAD_REFS_ONLY (1<<3)
-/* Update ORIG_HEAD as well as HEAD */
-#define RESET_ORIG_HEAD (1<<4)
+enum reset_working_tree_flags {
+	/* Request a detached checkout */
+	RESET_WORKING_TREE_DETACH = (1 << 0),
+
+	/* Request a reset rather than a checkout */
+	RESET_WORKING_TREE_HARD = (1 << 1),
+
+	/* Run the post-checkout hook */
+	RESET_WORKING_TREE_RUN_POST_CHECKOUT_HOOK = (1 << 2),
+
+	/* Only update refs, do not touch the worktree */
+	RESET_WORKING_TREE_REFS_ONLY = (1 << 3),
+
+	/* Update ORIG_HEAD as well as HEAD */
+	RESET_WORKING_TREE_UPDATE_ORIG_HEAD = (1 << 4),
+};
 
 struct reset_working_tree_options {
 	/*
@@ -33,7 +39,7 @@ struct reset_working_tree_options {
 	/*
 	 * Flags defined above.
 	 */
-	unsigned flags;
+	enum reset_working_tree_flags flags;
 	/*
 	 * Optional reflog message for branch, defaults to head_msg.
 	 */
@@ -45,7 +51,8 @@ struct reset_working_tree_options {
 	const char *head_msg;
 	/*
 	 * Optional reflog message for ORIG_HEAD, if this omitted and flags
-	 * contains RESET_ORIG_HEAD then default_reflog_action must be given.
+	 * contains RESET_WORKING_TREE_UPDATE_ORIG_HEAD then
+	 * default_reflog_action must be given.
 	 */
 	const char *orig_head_msg;
 	/*
diff --git a/sequencer.c b/sequencer.c
index d73ecf0384..4efe831178 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4677,7 +4677,9 @@ static void create_autostash_internal(struct repository *r,
 	if (has_unstaged_changes(r, 1) ||
 	    has_uncommitted_changes(r, 1)) {
 		struct child_process stash = CHILD_PROCESS_INIT;
-		struct reset_working_tree_options ropts = { .flags = RESET_HEAD_HARD };
+		struct reset_working_tree_options ropts = {
+			.flags = RESET_WORKING_TREE_HARD,
+		};
 		struct object_id oid;
 
 		strvec_pushl(&stash.args,
@@ -4870,8 +4872,9 @@ static int checkout_onto(struct repository *r, struct replay_opts *opts,
 	struct reset_working_tree_options ropts = {
 		.oid = onto,
 		.orig_head = orig_head,
-		.flags = RESET_HEAD_DETACH | RESET_ORIG_HEAD |
-				RESET_HEAD_RUN_POST_CHECKOUT_HOOK,
+		.flags = RESET_WORKING_TREE_DETACH |
+			 RESET_WORKING_TREE_UPDATE_ORIG_HEAD |
+			 RESET_WORKING_TREE_RUN_POST_CHECKOUT_HOOK,
 		.head_msg = reflog_message(opts, "start", "checkout %s",
 					   onto_name),
 		.default_reflog_action = sequencer_reflog_action(opts)

-- 
2.54.0.1189.g8c84645362.dirty

