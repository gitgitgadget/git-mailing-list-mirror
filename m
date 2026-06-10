Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8359D3C9881
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 08:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781081570; cv=none; b=hNRG9bH/IMRpnAXmY7xc1EomIz42/6g947j9tQT+xatEwZ+bb+RIWzhineHWJMoTElCsxKYSh0vbvBxhCuCj8LvNVRwMKJu4K+epXxfK6mET5+kpvpkF4U87h/Vy+acbYuAj5zOhYhi7vgaAJOP0aSC6SRpwikSuVz59FTZ807E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781081570; c=relaxed/simple;
	bh=NhN+NLZ+kKs7/r5E2sMWZ6CgADfGDDMcC5f+M+UBoVk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X0q0uR7BJDG2sInH7zicezvh084vXMPc1jgpOYbgtZTRAx0cAA1F5X4vAW8Mxrlz6Z88zOrtb7AFq6TUbwnS6MRt3wJ6mhWTtz0oHR7JPbTKVFzgKIuwK9UIR5GYpLwp6TLRl22Dr3lYK74ePFdUymN66qNW1XOj7T6FJ8V6OBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=vg1kodx4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bTY1cQnQ; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="vg1kodx4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bTY1cQnQ"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id C8FC91D0009D;
	Wed, 10 Jun 2026 04:52:48 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 10 Jun 2026 04:52:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781081568;
	 x=1781167968; bh=gzivA+TrIX0V3SqskJPc05vj3uZu0SBYi9ugd7Jm8Sw=; b=
	vg1kodx4NuzhN7E7M4mBm513D49d513gkxJ+n/7wONwPDPd37iKOAd7StOpHQpih
	35vdZ8BbhyDFGsXuXH5rBkFCbJEtZHDvC+ut8IYzK/fEHYf8HrSJOnHlwG9PUDmB
	Qza//za6gilnUaRMGnk54204px0W/+fSGHJKHhqL2LmdlqsXgY6VhFKxSuPvYfP5
	nIlhUfAjKvztqGCFhZjRiJnMJVlUXBdC45a2gSgsVRaZPqiBalD3AQbqxnuO7uup
	osJOm3nyVztbin21WKyRoNTLqni6/VTZDQUXSALbXFgS4x8st1Rl4AN5y0Pdr7zZ
	DIGWz+03AumEqcZd5cuGPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781081568; x=
	1781167968; bh=gzivA+TrIX0V3SqskJPc05vj3uZu0SBYi9ugd7Jm8Sw=; b=b
	TY1cQnQ44WIe4kqAnEf4yGq4kaVq12Y1BG+TITKldsP5RTUKe4dGYqRT1U9Jv6Os
	oVL9YGOh/RYZFgI/oJtvx1UHtYJDQMJPPZ2yA26XZDs6q/LtBg5PsGd3Vi/XF3PC
	iIJUw27PXfJMVp5sRTNt8FsQmB+3g0JKbhE4BYsCODslEWZAYBFz+Oqpp3h9I8KL
	M3Kikbm4OhN+0T6Kk20NwFHboSj4WfjcltZpH2sijWAlI0rv6Et+XX/2M8KLKv3b
	y5kumZ5rieiwWa5pv8iYKiuwEXkA+ABbt09crpmNoJtohYHro6DohRfUpTqRAUef
	AoF9Gl0TyhD1wulkjTjsA==
X-ME-Sender: <xms:4CUpakwMqlniOAmL2TF_ebM61roWTV_GVnT382iO_YlNWaTuySfi1g>
    <xme:4CUpapyuJLiAsdM8MEnAjsu_--WHDyjZW1ZvGccGL3g-sKBl-DuhySSkXt2SXiTk6
    oUs7Cu0Gvrl42nLmqfFCDu6x37QzCaiCTEYBFlCuQTu8NUGTlj62A>
X-ME-Received: <xmr:4CUpamY9ZNEQgROM5iUU4WdtTWttaKemapERcw1d70mItpbpIQgB4WOcTy485-8HIznSdlLTLjk25AbwuPeF9i4_wioWI9IUIm6OkuzeVA>
X-ME-Proxy-Cause: dmFkZTE5orGA5proHaW7Mu8uqvCVIExIrc2eP/p2P5Lm+ca4fHgckoyg8H1FtO/I7wT2Aj
    nXYeRcsregd1VB/JFKht2uDDid/OrQSlnc1rqHixpgHWdGIhWP17+22VFQ0Y6OwEAagcoj
    j3h3elG5ybg8NK1JUgtfKMcMJO0hc7MBT/fQSZgmzrWwAwK1miB50XcHw7Yhzf8w1O5s6q
    Xg+5TZo5RxXTWuQ2D1I8EFmJPyzn8JA/uapOEANuLON+tT1nzkzucsw85WLhwcl+lLqh9w
    YTaz2KWmNElIawZywr8oaQfhcw0Kc8b74JeCKXq299mQ2+lJrLP2v9dXRRWz063lXrorrn
    uuOEJO/vwn9Tx7qSfFsLNOLlgsOIlOGyTBz6PcyS1yJB0XRBrUZ8VbbG9Vxdt+aSziWbDj
    55JfWUUMGGjHXrIy2b9tvivgx8cL/d7cA9eO7b61d1mYuuD4QbUg+9JWDdoGNFTzZhpIJy
    vRUNDhjXrFaz8pq7HKkEDo5dBhsRL4wx8TXBWX5rauO2J7cgWCophWqxeH0VZJq+JyXeyV
    48vIu/d5bJ2uLurntenbTkp85QoA+BTe7oy4rSF/yc0Nm/L0hjwuMI3hfW2ixBZmnMgG4E
    t5O0/mLuUXNfuyCy3OKn/XJtyTEFal+nwPFL2IzUFeG21ZheiqC4lBTHu7Yw
X-ME-Proxy: <xmx:4CUpaiUi3Ehp7ZgKDZ6bAN2-zoHUjQWQtLw5WxuvUTT0q0KNDu5yvg>
    <xmx:4CUpasgPvbIL3yNr0QgDOxqjLTHHAzRY9zul7LmHHQlE-OxBjPGAVQ>
    <xmx:4CUpaoupfupCdFlL4roBLJ98KdjOZP2kFrd1hKmGbig4HsFI3mBzOg>
    <xmx:4CUpat5sKMNupHknmj-PrutgbX390qfSdxjO9GqtS3EeI65hFYKv2A>
    <xmx:4CUpahn2_ybc5UFzKqCfVzdfE30zX-aNLFwyofVrxciEFBRFVFTDeOPJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 04:52:47 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 29ed0924 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 10 Jun 2026 08:52:46 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 10 Jun 2026 10:52:26 +0200
Subject: [PATCH v4 06/10] reset: introduce ability to skip updating HEAD
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-b4-pks-history-drop-v4-6-70d5f0ae8c25@pks.im>
References: <20260610-b4-pks-history-drop-v4-0-70d5f0ae8c25@pks.im>
In-Reply-To: <20260610-b4-pks-history-drop-v4-0-70d5f0ae8c25@pks.im>
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
 reset.c          |  6 ++++--
 reset.h          |  9 ++++++---
 sequencer.c      |  4 +++-
 4 files changed, 23 insertions(+), 10 deletions(-)

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
index 99f2c1b012..3ac99a51c0 100644
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
@@ -129,7 +130,7 @@ int reset_working_tree(struct repository *r,
 		oid = &head_oid;
 
 	if (refs_only) {
-		if (!dry_run)
+		if (update_head)
 			return update_refs(r, opts, oid, head);
 		return 0;
 	}
@@ -197,7 +198,8 @@ int reset_working_tree(struct repository *r,
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
2.54.0.1189.g8c84645362.dirty

