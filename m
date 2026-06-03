Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC11F3C768A
	for <git@vger.kernel.org>; Wed,  3 Jun 2026 16:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780503255; cv=none; b=LlnK37sGMPiKxux8fI6SutCuirlHPWAuxby0xCtoZrchSdR0WB98BDZanFBCTnnzZLip4jn2o6Y+CaLnRoPydnO948Xpf6mX58QHNZogSFaqnCKZMtgoJIe5lNu2EaI6guxk+aQ6slZiP68FxfXkXWmAiIhITHoFrO15LBnQNfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780503255; c=relaxed/simple;
	bh=fpM3c7/3+/8WIzaNxTjyOlOqzYB6kY5ob5l9j9R44zg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VCf+MKjNhL83m3PTuKT75Tn5FMxAxqE1MNCyJ6x8WgNurDirJQvqkLx4eaC1oszAlTl2/h87KGuCUJYze5VSkTkdX+DlRgPLMEKzTFW7zLozMhMFrEqoGKVfYGK0c+HWW5+Vd6kpAQikT0JCY4trVCQ/gMQP3n+Q83VYdUqTV74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=c8bCqeG/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ii89X8hi; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="c8bCqeG/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ii89X8hi"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 367901D000FA;
	Wed,  3 Jun 2026 12:14:13 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 03 Jun 2026 12:14:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780503253;
	 x=1780589653; bh=ndf+b1vTZOgBRRdNRMoUDZGZ18GvEp8ymKHdt6bQviI=; b=
	c8bCqeG/rneyujPf2ax/iFQ/c/otjiEdtR8LCoTX8p2QrFCBS8WkoobBlEIjE+jX
	hN4jz90X5RioYYk2QhnAjFkXNL5ZI6sIUCv7q/YmX9Wt36dV0mLLcQYKtSub12s5
	HYo4peGW2DCIL1rH/hwfqbLCUeSlJYptwAISb/QWT34B6e7obYj1i4oM0+FDQ158
	Gva6vPyEoLY76ExCtlvyj0/kZPELfac4mz27RGyerPlyckSp5twIrZeN7/cICbTj
	KmgiMbQEAEbpTNrhy3HVQ5ChrasK18ppWkcqJnZkoNc2tOmcG1YIuNXmK1ieeMMF
	ogU6vUqvZwiyG5b3VnupGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780503253; x=
	1780589653; bh=ndf+b1vTZOgBRRdNRMoUDZGZ18GvEp8ymKHdt6bQviI=; b=I
	i89X8hiijHDiVPCK4XGNlLs0B+UG7zCuql+ViPbdhiPY8oni8Q3D23CQ3mYyaL5b
	K9jUrFjV9LXAjAzRy9Yvacz+WSxxum7/GsGnnfDqafoAo4GUVIL7A+xgoUDTtEYt
	CvKVwojB7ZqDgoORJPvQZ11NKCP217HNa5SHGWt+dyuciW5d/HefbKF5vqc8Nh+2
	yqlwpMKROE4Y6Q0wcrAJOig7TA/dx4UR/XTNaWfrxuCtcCcZ0TTMez/UtR8EC8yW
	rFPfEJ8GfulfVRxtIJftBZcUvkQSNMynvGzrv8yJwyFYaA/PrS7zFwgmThma05KM
	HPhOE2F5RcJSQx6lg2e8w==
X-ME-Sender: <xms:1VIgam9P7CRC_vhb-Z0VCPEcb6RTiawox5kwcqin_I9X5bY1qgM3sA>
    <xme:1VIgauKDITYWzKBwZygksXUeVixYGjEWJUM-Uh2oURz1x8T9JVPngrH5UBmsM08aD
    T6imhsYBgb4lipNXnqtTKBIMC6s0zqthYrarfE2C925YULZSppAlQ>
X-ME-Received: <xmr:1VIgapY7mO2KLP-b4Wj1uRxGDmKrH6CnGquBN4Vg_KOqMlBfAGA6kdm9ZIde3oQGktKdgSYaemlrlaXqF_dPPBimk9vWo1Bj1pwZqCoGEMHG>
X-ME-Proxy-Cause: dmFkZTGdlIonfplKpFXa/+DN5l0Fb2humCV2KDAOVEKyP+YPvmRBKflqZmkwAq9rePEQEk
    tFWbGVHfEKLtOw94e3kwwUvfEq/biapgD0LFxEGjNoceagFbAdw8S44lP98A4A6KSEBzBI
    FK/Zaf4iM+7r9UuVe4A2HKmR8OR4YocvA/6wxorfK7uRUU2fV0yzyhSTCXmRlDtYfcUpDj
    W3y4seHxmmHClyvMTnpX7w52yD4rY/DK178Gw1HIPAoq8c0YVNdlYew0Ju9pKEwEpdY7jk
    aRnqh9h1yCWlfj/W0CqUM74g6F8iUs+FEHBRjFPLTPipkR6XYgqphPOg5F7L6g8vVu+vFK
    7rYgzOA95sNn9M9KZaow/dsz44D7EEVrHsw69qQOJHQnWZvzIPCF68yYb4Rf8dHN81poqD
    d56D6I85wvkvOxAFPiTiUy2BE3T/haQowWjiSNedykhI4SDveF7tVZ45RN9JQGoUn5ISce
    AqOhm/VN8FEjVdtZ99nHTIexOPLKl5PfIELi/PBAkraO1csCFN9TPTygcjqTY21uP/XX13
    Fxcaq7suXUgDgORwfVG8FAEzr4ShK4aIviAeMKOlcJjIh+bY3TZe8yBgIB98RBY6bhgJJH
    zsTE9tsb61gq7CtAzWeu6w5qnvYuYRX88jPQwwmxK+qeCddOl8b3/Vy3H4gg
X-ME-Proxy: <xmx:1VIgaoKmbNrPJ81e1IEFloryVmmRxW-3T5-1otNwXSbJOR_ZAWkI4Q>
    <xmx:1VIgavAsFUR-Q6dT-1ujMx1cgfhx24bPXSXY7nZG_eCjDhEr9oluSQ>
    <xmx:1VIgalpDNZvOS-2YQTOKFYJCw0mf5Xhg38w-VurfLKR8oxLf_vTOCA>
    <xmx:1VIgaiiT-4CN89lNXoEJOl5Z23NSMnqIb_lzIgo_s7xAyeNFZRD6Eg>
    <xmx:1VIgaqIcxPocLwoODPN7_1WDakgBu0oznCdPu9zAKmsgFvcGv_tjUzcr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jun 2026 12:14:12 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b5f88dde (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 3 Jun 2026 16:14:11 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 03 Jun 2026 18:14:02 +0200
Subject: [PATCH v2 3/9] reset: modernize flags passed to `reset_head()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-b4-pks-history-drop-v2-3-742cb5b5176d@pks.im>
References: <20260603-b4-pks-history-drop-v2-0-742cb5b5176d@pks.im>
In-Reply-To: <20260603-b4-pks-history-drop-v2-0-742cb5b5176d@pks.im>
To: git@vger.kernel.org
Cc: Pablo Sabater <pabloosabaterr@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

The flags passed to `reset_head()` are declared as defines. This has
fallen a bit out of practice nowadays, where we instead prefer to use
enums.

Modernize the code accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/rebase.c |  2 +-
 reset.c          |  4 ++--
 reset.h          | 30 ++++++++++++++++++------------
 sequencer.c      |  2 +-
 4 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index fa4f5d9306..6351a3aa32 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1876,7 +1876,7 @@ int cmd_rebase(int argc,
 		    options.reflog_action, options.onto_name);
 	ropts.oid = &options.onto->object.oid;
 	ropts.orig_head = &options.orig_head->object.oid;
-	ropts.flags = RESET_HEAD_DETACH | RESET_ORIG_HEAD |
+	ropts.flags = RESET_HEAD_DETACH | RESET_HEAD_ORIG_HEAD |
 			RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
 	ropts.head_msg = msg.buf;
 	ropts.default_reflog_action = options.reflog_action;
diff --git a/reset.c b/reset.c
index 3b3cb74dab..9ff14f5ed1 100644
--- a/reset.c
+++ b/reset.c
@@ -18,7 +18,7 @@ static int update_refs(struct repository *repo,
 {
 	unsigned detach_head = opts->flags & RESET_HEAD_DETACH;
 	unsigned run_hook = opts->flags & RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
-	unsigned update_orig_head = opts->flags & RESET_ORIG_HEAD;
+	unsigned update_orig_head = opts->flags & RESET_HEAD_ORIG_HEAD;
 	const struct object_id *orig_head = opts->orig_head;
 	const char *switch_to_branch = opts->branch;
 	const char *reflog_branch = opts->branch_msg;
@@ -91,7 +91,7 @@ int reset_head(struct repository *r, const struct reset_head_opts *opts)
 	const char *switch_to_branch = opts->branch;
 	unsigned reset_hard = opts->flags & RESET_HEAD_HARD;
 	unsigned refs_only = opts->flags & RESET_HEAD_REFS_ONLY;
-	unsigned update_orig_head = opts->flags & RESET_ORIG_HEAD;
+	unsigned update_orig_head = opts->flags & RESET_HEAD_ORIG_HEAD;
 	struct object_id *head = NULL, head_oid;
 	struct tree_desc desc[2] = { { NULL }, { NULL } };
 	struct lock_file lock = LOCK_INIT;
diff --git a/reset.h b/reset.h
index a28f81829d..97ced2601e 100644
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
+enum reset_head_flags {
+	/* Request a detached checkout */
+	RESET_HEAD_DETACH = (1 << 0),
+
+	/* Request a reset rather than a checkout */
+	RESET_HEAD_HARD = (1 << 1),
+
+	/* Run the post-checkout hook */
+	RESET_HEAD_RUN_POST_CHECKOUT_HOOK = (1 << 2),
+
+	/* Only update refs, do not touch the worktree */
+	RESET_HEAD_REFS_ONLY = (1 << 3),
+
+	/* Update ORIG_HEAD as well as HEAD */
+	RESET_HEAD_ORIG_HEAD = (1 << 4),
+};
 
 struct reset_head_opts {
 	/*
@@ -33,7 +39,7 @@ struct reset_head_opts {
 	/*
 	 * Flags defined above.
 	 */
-	unsigned flags;
+	enum reset_head_flags flags;
 	/*
 	 * Optional reflog message for branch, defaults to head_msg.
 	 */
@@ -45,7 +51,7 @@ struct reset_head_opts {
 	const char *head_msg;
 	/*
 	 * Optional reflog message for ORIG_HEAD, if this omitted and flags
-	 * contains RESET_ORIG_HEAD then default_reflog_action must be given.
+	 * contains RESET_HEAD_ORIG_HEAD then default_reflog_action must be given.
 	 */
 	const char *orig_head_msg;
 	/*
diff --git a/sequencer.c b/sequencer.c
index 1ee4b2875b..0b89a977b0 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4870,7 +4870,7 @@ static int checkout_onto(struct repository *r, struct replay_opts *opts,
 	struct reset_head_opts ropts = {
 		.oid = onto,
 		.orig_head = orig_head,
-		.flags = RESET_HEAD_DETACH | RESET_ORIG_HEAD |
+		.flags = RESET_HEAD_DETACH | RESET_HEAD_ORIG_HEAD |
 				RESET_HEAD_RUN_POST_CHECKOUT_HOOK,
 		.head_msg = reflog_message(opts, "start", "checkout %s",
 					   onto_name),

-- 
2.54.0.1064.gd145956f57.dirty

