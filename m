Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEAF1C2443
	for <git@vger.kernel.org>; Fri, 31 Jan 2025 12:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738328147; cv=none; b=js4qYDv+GlH1rvAOsgcEoZLjZRttAzxHWDepAb9XZbw4RZt3DKd0mzcbnNGb5wQB7i82AL2fiz4BDUvVy7qxheC7JA/yt+JMgED22sgmLijDoy8G22HdbiZq4+8cALWJTtH5HuXPcAB0U1HZOytphH4zv9KDz3Zzl7EQQX3tjow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738328147; c=relaxed/simple;
	bh=GU1YwqBCy0wsFcfNWFSTUKIeMoXCt8EaINVTSZI0fz4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ikoJFx5/+nlOllKbSyWD873DPIwhBypKXzGozRsgcLQETkKHjv21ZH1XupvWtAs07vNUkCXd8TSxGpcjqEqC54rHtoCLOcddEyn0kGO306SOLa9MaJD9ZLD+1DwUlA1DVRbRh2teParnPlBriulnAA+NeVL/qGCj7it932uBaRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qV/DoKh4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TQNs09C4; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qV/DoKh4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TQNs09C4"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5B47211401B4;
	Fri, 31 Jan 2025 07:55:44 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 31 Jan 2025 07:55:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738328144;
	 x=1738414544; bh=mLnx0aNDlusFFIlIhkd/B5+WvAqXYvZawDPf4g+VYDQ=; b=
	qV/DoKh4rTXz5PvfNctiHGRcs+KFf18DABFX02ubRxvoU+kIlgWjByTDx3z3sRFU
	aFLODQnLRg1vpkYNpEfcLZCkOm56PWeApNIKm9aEgBPOqBDIZmyrqCO3g5dnvMD7
	VuhlDfB4LGS7f3PoyaMEbaLMLhA79dAhN32CEM0mdXGem5BdZ1FEiOt0Kcs8adCN
	57JraD0sdrjS3Vj3jF5no467AKkh4uXc7+yRkrl540A6jPskNLYw9fw0SB/f+EfV
	9q6pPdqlJPDjP+LxlEnoihVBr3hoTXkR+MEHtJHj8C/nwcaKjUq8wXDtx5BAbOBw
	ZailwvApDBADahfzDx12kQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738328144; x=
	1738414544; bh=mLnx0aNDlusFFIlIhkd/B5+WvAqXYvZawDPf4g+VYDQ=; b=T
	QNs09C4sHD8ORp47TzMyfzvHs65aXqtMV13Ka6aH1lWRJTT/TYgIwZzUB5uc55lS
	bLcm+PELE1DeoKPOdab1406entozFQjBewckPmxT24lCo1YeYds6E+nLVrKFdSXx
	SZLhlAaT3iHVDVrPaaOuoXP5LmZZwrmNcvNXHPnoIo3xH5V5tXllgGVoAqBopA5l
	+gysAk9SvujC3HRDEaCkCkJft9FBjOMLrbFbfyFh9FKkt4UCKo5pffEU0sJjyFDx
	GQ7qwQ4U+v+oCsFupCuPZxq8sTGfz7mZry13Ju4A/KU3c1u6IV+yJMXAPRZg6vWb
	xL6m2CYXx38Tvk48ncj2A==
X-ME-Sender: <xms:UMicZ6uy0NhuSxd1dvOdSrJ-D4AsmVzkDefHnJknCYnXShaG6PUfhg>
    <xme:UMicZ_fQ-xgUBMDl-zesQ_1KRwOnSLhA6zSkxKc0X4NO4r-6DCR4k6zXHedqo6LZY
    PQQ7SfMdiPzZOwj4Q>
X-ME-Received: <xmr:UMicZ1w7Cq4NdGappIgb-e5XvyBwVfxOPeuI72fbl82MKJ7hvvnVcuviI8n46ZA3JjmozQrJyDH0I_ccNkcFlsaHmpvHKkcTMD_Cj15QFx94Aw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvseht
    thgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:UMicZ1NaYxGFz_40VqDYgfWT2k4jhsRD3QuVgH2Iem5qDP1mWBsWpg>
    <xmx:UMicZ6_LOyX1K_imJUkNjXysKuNbihT8z4OHlQY0R7nPE0ybq87kbA>
    <xmx:UMicZ9WPr5tZM1vLOtQA-8VcErjqvybcHGSqSiuWxQDqOaaQZU3PfA>
    <xmx:UMicZzct88Wps_xAkNb2j0z-qPqyOjF0sJYmMQQh3vNbg9ogBwelOw>
    <xmx:UMicZxY7aBaBUcI7n70b6lPUOhOTX6YXNYIovKQkhWYznUoFz_A-HXgW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Jan 2025 07:55:43 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ccf41404 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 31 Jan 2025 12:55:40 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 31 Jan 2025 13:55:30 +0100
Subject: [PATCH 3/4] hash: provide generic wrappers to update hash contexts
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250131-b4-pks-hash-context-direct-v1-3-67a6d3f49d6e@pks.im>
References: <20250131-b4-pks-hash-context-direct-v1-0-67a6d3f49d6e@pks.im>
In-Reply-To: <20250131-b4-pks-hash-context-direct-v1-0-67a6d3f49d6e@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

The hash context is supposed to be updated via the `git_hash_algo`
structure, which contains a list of function pointers to update, clone
or finalize a hashing context. This requires the callers to track which
algorithm was used to initialize the context and continue to use the
exact same algorithm. If they fail to do that correctly, it can happen
that we start to access context state of one hash algorithm with
functions of a different hash algorithm. The result would typically be a
segfault, as could be seen e.g. in the patches part of 98422943f0 (Merge
branch 'ps/weak-sha1-for-tail-sum-fix', 2025-01-01).

The situation was significantly improved starting with 04292c3796
(hash.h: drop unsafe_ function variants, 2025-01-23) and its parent
commits. These refactorings ensure that it is not possible to mix up
safe and unsafe variants of the same hash algorithm anymore. But in
theory, it is still possible to mix up different hash algorithms with
each other, even though this is a lot less likely to happen.

But still, we can do better: instead of asking the caller to remember
the hash algorithm used to initialize a context, we can instead make the
context itself remember which algorithm it has been initialized with. If
we do so, callers can use a set of generic helpers to update the context
and don't need to be aware of the hash algorithm at all anymore.

Adapt the context initialization functions to store the hash algorithm
in the hashing context and introduce these generic helpers. Callers will
be adapted in the subsequent commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 hash.h        | 21 +++++++++++++++++++++
 object-file.c |  6 ++++++
 2 files changed, 27 insertions(+)

diff --git a/hash.h b/hash.h
index 42b52c6dae..4367acfec5 100644
--- a/hash.h
+++ b/hash.h
@@ -235,6 +235,7 @@ enum get_oid_result {
 
 /* A suitably aligned type for stack allocations of hash contexts. */
 struct git_hash_ctx {
+	const struct git_hash_algo *algop;
 	union {
 		git_SHA_CTX sha1;
 		git_SHA_CTX_unsafe sha1_unsafe;
@@ -296,6 +297,26 @@ struct git_hash_algo {
 };
 extern const struct git_hash_algo hash_algos[GIT_HASH_NALGOS];
 
+static inline void git_hash_clone(struct git_hash_ctx *dst, const struct git_hash_ctx *src)
+{
+	src->algop->clone_fn(dst, src);
+}
+
+static inline void git_hash_update(struct git_hash_ctx *ctx, const void *in, size_t len)
+{
+	ctx->algop->update_fn(ctx, in, len);
+}
+
+static inline void git_hash_final(unsigned char *hash, struct git_hash_ctx *ctx)
+{
+	ctx->algop->final_fn(hash, ctx);
+}
+
+static inline void git_hash_final_oid(struct object_id *oid, struct git_hash_ctx *ctx)
+{
+	ctx->algop->final_oid_fn(oid, ctx);
+}
+
 /*
  * Return a GIT_HASH_* constant based on the name.  Returns GIT_HASH_UNKNOWN if
  * the name doesn't match a known algorithm.
diff --git a/object-file.c b/object-file.c
index 154bcfce78..b7f2af515f 100644
--- a/object-file.c
+++ b/object-file.c
@@ -88,11 +88,13 @@ static const struct object_id null_oid_sha256 = {
 
 static void git_hash_sha1_init(struct git_hash_ctx *ctx)
 {
+	ctx->algop = &hash_algos[GIT_HASH_SHA1];
 	git_SHA1_Init(&ctx->state.sha1);
 }
 
 static void git_hash_sha1_clone(struct git_hash_ctx *dst, const struct git_hash_ctx *src)
 {
+	dst->algop = src->algop;
 	git_SHA1_Clone(&dst->state.sha1, &src->state.sha1);
 }
 
@@ -115,11 +117,13 @@ static void git_hash_sha1_final_oid(struct object_id *oid, struct git_hash_ctx *
 
 static void git_hash_sha1_init_unsafe(struct git_hash_ctx *ctx)
 {
+	ctx->algop = unsafe_hash_algo(&hash_algos[GIT_HASH_SHA1]);
 	git_SHA1_Init_unsafe(&ctx->state.sha1_unsafe);
 }
 
 static void git_hash_sha1_clone_unsafe(struct git_hash_ctx *dst, const struct git_hash_ctx *src)
 {
+	dst->algop = src->algop;
 	git_SHA1_Clone_unsafe(&dst->state.sha1_unsafe, &src->state.sha1_unsafe);
 }
 
@@ -143,11 +147,13 @@ static void git_hash_sha1_final_oid_unsafe(struct object_id *oid, struct git_has
 
 static void git_hash_sha256_init(struct git_hash_ctx *ctx)
 {
+	ctx->algop = unsafe_hash_algo(&hash_algos[GIT_HASH_SHA256]);
 	git_SHA256_Init(&ctx->state.sha256);
 }
 
 static void git_hash_sha256_clone(struct git_hash_ctx *dst, const struct git_hash_ctx *src)
 {
+	dst->algop = src->algop;
 	git_SHA256_Clone(&dst->state.sha256, &src->state.sha256);
 }
 

-- 
2.48.1.502.g6dc24dfdaf.dirty

