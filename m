Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C823B5DED
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 10:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780914222; cv=none; b=VNnuzsd3eCacdgT2NQ50bEHHi07VnoMbzRGQI6nkvpv31s8akR4rwqsIqSOa51qlm8nldrdMfpZFNk7PR5xZVq37ZjDGm5pwmZBf2zcPu9LhxPSoM7qTuouBLT2ip/ZidUWB6fDp8HYdd2aZiyGF0ttUFpPJevx5R71LQae+KQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780914222; c=relaxed/simple;
	bh=DfIUlQq1ho/tqBV5EqpMrB0N+7WohDSiA9nLpjCiOdg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YzGQptjG2hNOTOSbYylut8pxO0Dov3lPmJIPLPNcwonBBnW0XfdEPXOiDpWA1r7bP7t/I8ols6veSt39Mw6Xe8mIGdP42p9fUHpaY8RRSz9zzM7OwgkMnwOnFNEdTV5rppjPBFCLVDkoFwZYM63Hcg4BhwfHGYhL7bSohzZjcFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=a0HpAx97; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K+uukClS; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="a0HpAx97";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K+uukClS"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id C23221D00095;
	Mon,  8 Jun 2026 06:23:39 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 08 Jun 2026 06:23:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780914219;
	 x=1781000619; bh=lgzwSYPubM1kcxeu+7O2nWUHGUs3Tr60ubq0oUrypuQ=; b=
	a0HpAx976xkuos3ETiqLnuhGLFoUw+91XzC3K1kYCv3Xxn8m85sFUNk2SE+N14Os
	2bB857DHN+BkhaRIs6qdaHGUYkh48MQ6xoIsfvPE0kq0vqx9fUvocWzlXwukNrNp
	5mA2LJNmBsu9V7HaSakUvj3UZl6/hEhswfW1HiLU/9OS1RsNmLP196vIn66JGeZA
	hriRXLYG1wEUcddvogyfmy+6HH33t9MTNVpvtCCtsLVAOTHjyWXGKUkwoGrfDOGJ
	qfhyv1yOtO8PSASP0ftsinfJVmU/UVA2MXqmH6J91e72GcXkZjWzTClpCTT+4xom
	z8Z5qRnewl1F97vDUlRD1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780914219; x=
	1781000619; bh=lgzwSYPubM1kcxeu+7O2nWUHGUs3Tr60ubq0oUrypuQ=; b=K
	+uukClSD/WxE7kai03UEbF9Tht8Q6yYCRpzBKcn07SDPikh5LnOrJbThYd5jy+SW
	VX4m8U8A6hc+iZPBTpBscW8OcNzT+c/eo079D5Vfhng4Stmzf4sbL+EkR7+eBBxd
	Z5+/hxOAEOcAIQGinLOMst9pHib8agVurgXN6xi9ft1mXkGuy+TBr9//Y9yoje7b
	rhUJ8QzXy1qRW/IfNFHgZ6/OvxDDedVHlVZmVyjSjF8XnzAo4lWYr6zPRSzZUuZ6
	+L92Ys3A7lXiSN4KihCepcPPknJy9WuNpYc3se4q897E1C6bF39+RYHn53eu6TXL
	J8wgzxDr5Y3limr3qkGPw==
X-ME-Sender: <xms:K5gmaqCDPTY3CQtIGNSChUROtgiR-LxUydIqs33yy8kPAtYalJYA-A>
    <xme:K5gmamD1k_n6Nxsk1Zh6YHYlHn2p5kV1v54g-b42OWGc9_VbIivWzJrz9bdoArdmA
    JcySd_gVC7NRQIFWdu8HMF4gzSTpgTsfOb1ilcRzGqXG8vg6FBk>
X-ME-Received: <xmr:K5gmatp2CdzDng0MeBPPJEX5L-2DJsNTa8-em2ohy2sp76yontMDfTlGuBX3cT3WSK2SfiaDshIdahF-Ov5PWCIcud54A04SaobbkLgDIA>
X-ME-Proxy-Cause: dmFkZTF/E0B6+8HbVI0EuzBQ3dK8cHD9k7zZhvtR4eGQVqhd3W4HTcOnifeC1qzKI3nsbE
    Nr9VNWSWcSFtS/UIV6gQwbKHmcbCLZQ5dEmWkSWzkCkUK8vkxjfNEdIFScQfFAYP5zawV8
    kuJkxbizX3zEJsOqszq2+IudRIc8Uq86mQ36+9qMWm2f62cSt69oypV8UuhbQr8RL6FlHi
    jgxr7RInSbFRodGxO7WuQWF/WG7dKUmnfBX95+D9IjM+5QwCHTGkAMls42CUbLZrRvniUT
    3lub+E8UcsLzA9W1abr8Tskkr7igIbaHvXdizdHbApsrCDDZaJOZp69gRz16mo276cOsT7
    oqpqcr0IClwWTKe+d8v/baGOmMzGqDumkd+xrrwvlM2cawCdwuZY+yThsV4ZHCnCm7vTRT
    fFTTrsOjQQ7725h3CeD4YMhJhc12o5K13cI/h3zRn2QBQs94+/GrZaINMkeAfIuC5YHI6D
    +aFEnJG8HB514uR0cv/0fGb/PsQT+YaQyKf8ECy2B/zrWaCQfYvvKpL44M5JE2AFf7BHIV
    BbFzB8sep2763MCCMufrhnQ4d5Xs0Enqhc/CqJBrICU6ejr+g0JnErhdxaaYhU9Duyr/9/
    BL9Ym8obMk0qcMtGNQWqkU5SPpWFZu/fjpTM2q9FscwnAFBzoxFHyrZCP5Sw
X-ME-Proxy: <xmx:K5gmaonQw9FR4xVEXqkv8r0rxA2ynb4yU1kU0F-HPvItWhd7NzHCcw>
    <xmx:K5gmalwoQKAnRLU811_DPFQ0D0b-YaZYiagD4NhaUwR-pIwdl3xMlA>
    <xmx:K5gmao8Y1dO0F1wT5osZQgAlPcI77g0jBe02tQ4Rn_--_kkBgIhR_w>
    <xmx:K5gmapJJY5ShA-g0_bMEmgyaGdtIUcvqP0aBf__QpZeAGLOS02NEcA>
    <xmx:K5gmar0M4MgeZ_9rNzmcVJy_Mh60BFiLeTs3GfwxLh8kMPusExFgCSVK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jun 2026 06:23:38 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e118c3d8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Jun 2026 10:23:38 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 08 Jun 2026 12:23:27 +0200
Subject: [PATCH v3 3/9] reset: modernize flags passed to `reset_head()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-b4-pks-history-drop-v3-3-84ca8e43e937@pks.im>
References: <20260608-b4-pks-history-drop-v3-0-84ca8e43e937@pks.im>
In-Reply-To: <20260608-b4-pks-history-drop-v3-0-84ca8e43e937@pks.im>
To: git@vger.kernel.org
Cc: Pablo Sabater <pabloosabaterr@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
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
index fa4f5d9306..4c20bd50cb 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1876,7 +1876,7 @@ int cmd_rebase(int argc,
 		    options.reflog_action, options.onto_name);
 	ropts.oid = &options.onto->object.oid;
 	ropts.orig_head = &options.orig_head->object.oid;
-	ropts.flags = RESET_HEAD_DETACH | RESET_ORIG_HEAD |
+	ropts.flags = RESET_HEAD_DETACH | RESET_HEAD_UPDATE_ORIG_HEAD |
 			RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
 	ropts.head_msg = msg.buf;
 	ropts.default_reflog_action = options.reflog_action;
diff --git a/reset.c b/reset.c
index 3b3cb74dab..228cad5f42 100644
--- a/reset.c
+++ b/reset.c
@@ -18,7 +18,7 @@ static int update_refs(struct repository *repo,
 {
 	unsigned detach_head = opts->flags & RESET_HEAD_DETACH;
 	unsigned run_hook = opts->flags & RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
-	unsigned update_orig_head = opts->flags & RESET_ORIG_HEAD;
+	unsigned update_orig_head = opts->flags & RESET_HEAD_UPDATE_ORIG_HEAD;
 	const struct object_id *orig_head = opts->orig_head;
 	const char *switch_to_branch = opts->branch;
 	const char *reflog_branch = opts->branch_msg;
@@ -91,7 +91,7 @@ int reset_head(struct repository *r, const struct reset_head_opts *opts)
 	const char *switch_to_branch = opts->branch;
 	unsigned reset_hard = opts->flags & RESET_HEAD_HARD;
 	unsigned refs_only = opts->flags & RESET_HEAD_REFS_ONLY;
-	unsigned update_orig_head = opts->flags & RESET_ORIG_HEAD;
+	unsigned update_orig_head = opts->flags & RESET_HEAD_UPDATE_ORIG_HEAD;
 	struct object_id *head = NULL, head_oid;
 	struct tree_desc desc[2] = { { NULL }, { NULL } };
 	struct lock_file lock = LOCK_INIT;
diff --git a/reset.h b/reset.h
index a28f81829d..0bf25c51de 100644
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
+	RESET_HEAD_UPDATE_ORIG_HEAD = (1 << 4),
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
+	 * contains RESET_HEAD_UPDATE_ORIG_HEAD then default_reflog_action must be given.
 	 */
 	const char *orig_head_msg;
 	/*
diff --git a/sequencer.c b/sequencer.c
index 1ee4b2875b..c46c606b3e 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4870,7 +4870,7 @@ static int checkout_onto(struct repository *r, struct replay_opts *opts,
 	struct reset_head_opts ropts = {
 		.oid = onto,
 		.orig_head = orig_head,
-		.flags = RESET_HEAD_DETACH | RESET_ORIG_HEAD |
+		.flags = RESET_HEAD_DETACH | RESET_HEAD_UPDATE_ORIG_HEAD |
 				RESET_HEAD_RUN_POST_CHECKOUT_HOOK,
 		.head_msg = reflog_message(opts, "start", "checkout %s",
 					   onto_name),

-- 
2.54.0.1136.gdb2ca164c4.dirty

