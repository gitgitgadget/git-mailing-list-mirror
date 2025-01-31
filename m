Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC3D1C07FC
	for <git@vger.kernel.org>; Fri, 31 Jan 2025 12:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738328146; cv=none; b=PgJwYg/9uUE0ArAz5bDIM4mHcRGEyK9Cn0XXjlp+b3CwA8+VkRob3aU/paGoBO+CsWlvoeif6Th66Xx/ZAp4vsNUq9wUPecm8iI6c+o65DoadGCguw968AzcKiw1hXPdbEFCOOFW1WsegzK7CaJs97vaSAL2Tp1E5wR3N5lUfXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738328146; c=relaxed/simple;
	bh=raqOBpj+Y4rpV+41yFbt1XrCUD1pRshBdiM8kSR5P3Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GPFQhRyCOK0zoXSjfSdiklXjzAaA/uh8Fn8XREQ63zAlJjhUOVT4VovcoYQtLq6HG4bNt32/LFgvvPdfvWtIbb73me9OWpY6lxU0wdiFwXv4d2d7a8G9UK9Sn1T55hpHqzqcDjZ039WJuSxNUJtAxz1XgVhx9lL46nJrrbaUmH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KXsB2T6A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Itucw5gX; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KXsB2T6A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Itucw5gX"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 3635B13801DB;
	Fri, 31 Jan 2025 07:55:43 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 31 Jan 2025 07:55:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738328143;
	 x=1738414543; bh=OMXpzZhj0QhVkf6Af7YtejfUQHBn4VCGZEt8eNHORRI=; b=
	KXsB2T6AaGyhyw79P21X8ocaVHr1R3SCAH3Hh4fSx6K2YanNVzzcw8WwJtKGffsX
	xdkbLMzQ0uUs6TipJ+hC4473CVvf6SOVikMvXusf8rhPu+hnfvuXD/aUEKTP8BMb
	XL+WSbTw0KCNrycsN2kg3HdSi+z1xB5d20XibFpEVUUMQdZ7qVevU9rcKNL4XEqS
	/WU20FNzAgOfK4qT++lNm3mTNQ+PlYYskB134L2lIBGd/PXUOrewtlVOh2fvogRH
	WPNAeiGo5bOwYtqqK02aMGzTbWTCwSTRIiopRjOb3Sif4P2t5Mdc24ibICQTyfP5
	2M51+P4x98t0ska58LFj0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738328143; x=
	1738414543; bh=OMXpzZhj0QhVkf6Af7YtejfUQHBn4VCGZEt8eNHORRI=; b=I
	tucw5gX8tQgo1NXgAzJTNR75LdtlAI2c58x/oWx25WQ2SwOlUtlRvoUjaj+stpP3
	wvxYQva4bueagL2PT/KxmbkYWtNOdsi/SHWOedc5YkfdV6RwlOXzXO+1kkdf6kvj
	Cv5mKv5uDa7hjLzww02/CzQsHPGqShXMumnHJb0AXs1uRPCGgp9Qig/NxOzBJL5C
	fVWPE34YKcBhRBWT+CJwCt/EF5C57eIQNBMqOugHscFAA5+JCKBCZIuj46z/dLY7
	pkrQEXw+/xHca/dgDkbNbmL4yHs00JmhWcIOyuiJHloh7dWkSnn91DPY3KLfGgQc
	vuB6s6RHPjd7e3PLaKNdw==
X-ME-Sender: <xms:T8icZ2NOADMP6ttWWxPLMXUxtmv7OD_bbUbNHJm_XvhLu7NB0DFQAw>
    <xme:T8icZ09uyGLmOrDADsOdcuQGinwMFYaoZGr_0biJHZBkeCB8ddbzZ-Wb_1peJcYgu
    O5FkvdzP5m2yArauQ>
X-ME-Received: <xmr:T8icZ9RJpkwjb2nWrgYDArHQckS_OK7he9uZaRfh42Ru8KquGpQ_q4Slu4Lbtgr2jtqMbnJkJk_9lePm2ZV-2C3qJg691aCKP5mrUp17mk8fRQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:T8icZ2tTdTVMjcl-hzS8m9aEpCCo_NHmOpp3X0dEzLaZzouwnXxA1w>
    <xmx:T8icZ-dqzhjqk5A89uVhc7DWx6o6ohXevQYBp7zmMBxzn6bhOk9kRw>
    <xmx:T8icZ62qyWM-MMX7FLtSx0zjfEQfgAmXI7JZAfQB3JP0hTA3811Pag>
    <xmx:T8icZy-rTnwz9AFtoA4NAxCFOMKvzgBM-ahC8LJ5-viSgzaI675ibw>
    <xmx:T8icZ-7YqSHhwoMptNwFRIjdIoU-hHitMJCSPLVt50SqtWP0IVbcxnWg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Jan 2025 07:55:42 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5decfed3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 31 Jan 2025 12:55:39 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 31 Jan 2025 13:55:28 +0100
Subject: [PATCH 1/4] hash: convert hashing context to a structure
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250131-b4-pks-hash-context-direct-v1-1-67a6d3f49d6e@pks.im>
References: <20250131-b4-pks-hash-context-direct-v1-0-67a6d3f49d6e@pks.im>
In-Reply-To: <20250131-b4-pks-hash-context-direct-v1-0-67a6d3f49d6e@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

The `git_hash_context` is a union containing the different hash-specific
states for SHA1, its unsafe variant as well as SHA256. We know that only
one of these states will ever be in use at the same time because hash
contexts cannot be used for multiple different hashes at the same point
in time.

We're about to extend the structure though to keep track of the hash
algorithm used to initialize the context, which is impossible to do
while the context is a union. Refactor it to instead be a structure that
contains the union of context states.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 hash.h        | 13 +++++++------
 object-file.c | 30 +++++++++++++++---------------
 2 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/hash.h b/hash.h
index ad2c919991..5b88d9b714 100644
--- a/hash.h
+++ b/hash.h
@@ -234,13 +234,14 @@ enum get_oid_result {
 #endif
 
 /* A suitably aligned type for stack allocations of hash contexts. */
-union git_hash_ctx {
-	git_SHA_CTX sha1;
-	git_SHA_CTX_unsafe sha1_unsafe;
-
-	git_SHA256_CTX sha256;
+struct git_hash_ctx {
+	union {
+		git_SHA_CTX sha1;
+		git_SHA_CTX_unsafe sha1_unsafe;
+		git_SHA256_CTX sha256;
+	} state;
 };
-typedef union git_hash_ctx git_hash_ctx;
+typedef struct git_hash_ctx git_hash_ctx;
 
 typedef void (*git_hash_init_fn)(git_hash_ctx *ctx);
 typedef void (*git_hash_clone_fn)(git_hash_ctx *dst, const git_hash_ctx *src);
diff --git a/object-file.c b/object-file.c
index 6ce1caacae..7505aa6b60 100644
--- a/object-file.c
+++ b/object-file.c
@@ -88,82 +88,82 @@ static const struct object_id null_oid_sha256 = {
 
 static void git_hash_sha1_init(git_hash_ctx *ctx)
 {
-	git_SHA1_Init(&ctx->sha1);
+	git_SHA1_Init(&ctx->state.sha1);
 }
 
 static void git_hash_sha1_clone(git_hash_ctx *dst, const git_hash_ctx *src)
 {
-	git_SHA1_Clone(&dst->sha1, &src->sha1);
+	git_SHA1_Clone(&dst->state.sha1, &src->state.sha1);
 }
 
 static void git_hash_sha1_update(git_hash_ctx *ctx, const void *data, size_t len)
 {
-	git_SHA1_Update(&ctx->sha1, data, len);
+	git_SHA1_Update(&ctx->state.sha1, data, len);
 }
 
 static void git_hash_sha1_final(unsigned char *hash, git_hash_ctx *ctx)
 {
-	git_SHA1_Final(hash, &ctx->sha1);
+	git_SHA1_Final(hash, &ctx->state.sha1);
 }
 
 static void git_hash_sha1_final_oid(struct object_id *oid, git_hash_ctx *ctx)
 {
-	git_SHA1_Final(oid->hash, &ctx->sha1);
+	git_SHA1_Final(oid->hash, &ctx->state.sha1);
 	memset(oid->hash + GIT_SHA1_RAWSZ, 0, GIT_MAX_RAWSZ - GIT_SHA1_RAWSZ);
 	oid->algo = GIT_HASH_SHA1;
 }
 
 static void git_hash_sha1_init_unsafe(git_hash_ctx *ctx)
 {
-	git_SHA1_Init_unsafe(&ctx->sha1_unsafe);
+	git_SHA1_Init_unsafe(&ctx->state.sha1_unsafe);
 }
 
 static void git_hash_sha1_clone_unsafe(git_hash_ctx *dst, const git_hash_ctx *src)
 {
-	git_SHA1_Clone_unsafe(&dst->sha1_unsafe, &src->sha1_unsafe);
+	git_SHA1_Clone_unsafe(&dst->state.sha1_unsafe, &src->state.sha1_unsafe);
 }
 
 static void git_hash_sha1_update_unsafe(git_hash_ctx *ctx, const void *data,
 				      size_t len)
 {
-	git_SHA1_Update_unsafe(&ctx->sha1_unsafe, data, len);
+	git_SHA1_Update_unsafe(&ctx->state.sha1_unsafe, data, len);
 }
 
 static void git_hash_sha1_final_unsafe(unsigned char *hash, git_hash_ctx *ctx)
 {
-	git_SHA1_Final_unsafe(hash, &ctx->sha1_unsafe);
+	git_SHA1_Final_unsafe(hash, &ctx->state.sha1_unsafe);
 }
 
 static void git_hash_sha1_final_oid_unsafe(struct object_id *oid, git_hash_ctx *ctx)
 {
-	git_SHA1_Final_unsafe(oid->hash, &ctx->sha1_unsafe);
+	git_SHA1_Final_unsafe(oid->hash, &ctx->state.sha1_unsafe);
 	memset(oid->hash + GIT_SHA1_RAWSZ, 0, GIT_MAX_RAWSZ - GIT_SHA1_RAWSZ);
 	oid->algo = GIT_HASH_SHA1;
 }
 
 static void git_hash_sha256_init(git_hash_ctx *ctx)
 {
-	git_SHA256_Init(&ctx->sha256);
+	git_SHA256_Init(&ctx->state.sha256);
 }
 
 static void git_hash_sha256_clone(git_hash_ctx *dst, const git_hash_ctx *src)
 {
-	git_SHA256_Clone(&dst->sha256, &src->sha256);
+	git_SHA256_Clone(&dst->state.sha256, &src->state.sha256);
 }
 
 static void git_hash_sha256_update(git_hash_ctx *ctx, const void *data, size_t len)
 {
-	git_SHA256_Update(&ctx->sha256, data, len);
+	git_SHA256_Update(&ctx->state.sha256, data, len);
 }
 
 static void git_hash_sha256_final(unsigned char *hash, git_hash_ctx *ctx)
 {
-	git_SHA256_Final(hash, &ctx->sha256);
+	git_SHA256_Final(hash, &ctx->state.sha256);
 }
 
 static void git_hash_sha256_final_oid(struct object_id *oid, git_hash_ctx *ctx)
 {
-	git_SHA256_Final(oid->hash, &ctx->sha256);
+	git_SHA256_Final(oid->hash, &ctx->state.sha256);
 	/*
 	 * This currently does nothing, so the compiler should optimize it out,
 	 * but keep it in case we extend the hash size again.

-- 
2.48.1.502.g6dc24dfdaf.dirty

