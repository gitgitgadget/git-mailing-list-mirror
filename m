Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE57048095F
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 11:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782905757; cv=none; b=HlAprlDFC7E4Sf/r094+jsS/XVhIGyjvtwFuoiqlO2REVpKSC0nKwQnpu+wlM5T1fs1KEN78V1R7m73EeJ6+M49IiNOGk2qJkvZK9E5ao8y8TeL/aSI6p6qp2xLn3nDgGMivK2HPtofxEoyJpZdzYcSC+JpMB/z8zft5W1jDvDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782905757; c=relaxed/simple;
	bh=OhZz45cOxMCdrRgQKwseoyw3KIIpz8NUqYTiV5O9Ixc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QZcOx6MNJc0s+UxXIjLuBXTY+dbDNqrl3KTKYL+LIzadCNW3gSvP/qt7NzHdlF0o94sl7JlMrsQY7grg2uc8TnXML+htrOJJrinzF1S/5ayiR4XipQ0eHjo1DdPRdx4p+VjntSCtCW5EUYp6SVbAVRMdfRHS1RXfCSSwvevUwok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=R4X028An; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NaCWLeC5; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="R4X028An";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NaCWLeC5"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 0AE77EC0113;
	Wed,  1 Jul 2026 07:35:55 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 01 Jul 2026 07:35:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782905755;
	 x=1782992155; bh=ulNvTq9QgGTlRFDbz1ORElFeiXrpwdr6H+hkxRvXD9I=; b=
	R4X028AnGeMvkDBFv3sFlMRdE1ft9WGo672VNWRqogLJo7HGgM8r+MSfgTK7Bpr3
	vh31brwn/U3DdWmRLHwnZjGLmDCNfojZ9G+Faf+0d2qIdmLC/UdcnrqOhUJL6o1y
	KVXRbungyBqcoXPCoaX67gvBjoFoenzJ48dikcC1gkBZVmryrDcKU4F62zmaGRHK
	32kua/1RACZPtbFzUtgunlAd/wehsABniMUuO8+FWD0vj64NRh6B7/mWN75yIrn3
	Qk9hW3smvGgNen2gjUEgPWVowiuVaw+yKiWaOwzuvYHQYDCnHxiQR92cQy7gxc4N
	nYA+fl0eJ8jTnklKJ6I6ZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782905755; x=
	1782992155; bh=ulNvTq9QgGTlRFDbz1ORElFeiXrpwdr6H+hkxRvXD9I=; b=N
	aCWLeC5MOen/XDpkLrHxMNbyy4ejOs+uv63PIvC9ruj8zyg0SZ9ugHrZU97rDdV2
	GPixzNe1omYd0aSfnQdpBpA5Fnenm12n3pXlGQj7c+FYgHWf3sjoyXN51I5a55Ez
	gijdICmeH0pt3x4VogyyKAiehif8R/rqSKyBAlAlB9l58h64qVBfO2QNUPSC2JKX
	ueT8ZtK8gCz5JooQwL6Zi2ByFqFm3xb4JKbIzUDAyecqJaTJ1FYzen0jB/OwXWBj
	YhHiegfdH+w8r7SXvne6RtU5GjXh3shG4WAxZdFB3DWZ4H3vhneXKPrcWTp0WebI
	4lAQM9jSCNzIfeRHdY9/w==
X-ME-Sender: <xms:mvtEarB0O0q5KBJ9il3vp3ZXzwRrmuaZi5AYrDp_ZnOQH39uhrxbPg>
    <xme:mvtEaq0-VBxY2r72KUDneWJOrjc8CNXab9QgBMXF4XWXDVboc3w8F6WkYgbknf5b7
    GxYvgPumvMIO3OUdu2aW4_X-7Z9Ve2HxP7gtoGHlptxf7BEWQ0M>
X-ME-Received: <xmr:mvtEat3sH_RyWLZOXvioRSbiwliWpXU2tVSP6UFqK4f82w6Y0J8nXZ20olwG_yPrLD5yPgCY2HLumcjYNaD8hQShOon1nPBY39QbP69TkA0>
X-ME-Proxy-Cause: dmFkZTEDwynJ1bWuWnWJw5AQqBftfQURsy+UVeouW2JRFJajFjy8eVmp9g7o3m9xEvIKse
    QLMrVJa9HjrvmdMpr+by//9rK+K008P00zRatTganIRwXjg12oTj0h7WOGqR+8qBY14RIg
    dXIn4MAz3cICIizjl7bCDvPMQvbFFAenQAvd4rptJrU4oK4bBz+DIh9VOL66PjaltloaL6
    wp6U8ZWDnucC44AEmQK3npMEo2KNmfZPf2P1juV1f0aeLnAb9wh0x95IGbq/AsZfPUdVQS
    936PjP14YCiY8uUIc3zCF4/Q17BylNvxijgUReIicfXzM30V490lKc14HuPgYPyEL9toRE
    2uBye6LCG1sqAuDUs32LhMbP6X432tW7QmRyrfaR8Ynrm/JeJh2HHqzxMxWamBtRiGXK7i
    jQG9iPMS/iyB15e41it6t8Me48VQBtTZaq2EgLNBEWw02FbqAJJ9Fq/8tpu5zYO/yX61ci
    6iQg9sCobKHvieEoC5T2ofcgMvExx/xFqryHgbkYare9A+iqWcSeJMDfxxbloaVvXFZsh4
    migdEXUgB8v6W0F/YNb3Ein9y4v/PfUBgqjXhHOl5eKmpcVIYAVCLGVWDJ734t93A9vQ1O
    1oYHdYkcvt0MleByR/yp37Ecn1XkWn9u73XxgQ8IA9qZuloONGV1WZcJsZJg
X-ME-Proxy: <xmx:mvtEavCGUjH0FkMxkcAxL8z7g12lhmd0EZJjzfdNAToE0NfO4UTkrQ>
    <xmx:mvtEas6Kp7h__VOCR3tGjZMeAWCaPodlZHhOpcQTNFaiYww12DEthg>
    <xmx:mvtEagIywb4Rk1TdHKc0DwWiTyDqV46jHmayIQ-eITjFUFG4NU0kvA>
    <xmx:mvtEatvyS4xRnm4IzNUUe2NvsbT6BMBoIXles70Xun8rt_RwwnxTug>
    <xmx:m_tEaldV31TbXQBW5zhuEcw7aPLPNjtuETMy0EXy2cEwDsaeX-lRUlrK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 07:35:53 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fd7ee0df (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 1 Jul 2026 11:35:53 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 01 Jul 2026 13:35:33 +0200
Subject: [PATCH v8 06/11] reset: introduce ability to skip updating HEAD
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-b4-pks-history-drop-v8-6-19b5cdf1facd@pks.im>
References: <20260701-b4-pks-history-drop-v8-0-19b5cdf1facd@pks.im>
In-Reply-To: <20260701-b4-pks-history-drop-v8-0-19b5cdf1facd@pks.im>
To: git@vger.kernel.org
Cc: Pablo Sabater <pabloosabaterr@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>, 
 Christian Couder <chriscool@tuxfamily.org>
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
2.55.0.795.g602f6c329a.dirty

