Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036BB1F0E38
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 08:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740991668; cv=none; b=ALJBBmDXCUU5vvkDRpxIXUBm76XEv/IT7Wu3vLtIoyoR1OFzI+aqLb2N8P7oML4vl72HOq+LcILEHcLz7BsfgrIXNqfK3YLolC70SRAEUHGA7Xh1jAEtY134Vt7Y/vVevtUlARc7ElCr37EG7jVhU7uh6mk39fpme0tcpZalLRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740991668; c=relaxed/simple;
	bh=un1ed+CmieoOay03BYBIJ5Uwoa68vUeYHI02NvWe3e0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oz/4G+u6NdBFGijYVBYn9TF0WkSqHZ/A3Se3wZw92NJdZcdjcL2VDUq6+KCAwrYeZpE9ty0IdvCLHv7oUey6ojMR4f/unk4VkBV7FKfZPjoXrccmR3w87Jl0vZ4fDW53uo9RvMSiAHUlmm/AsS706fsVjvEOtjOR19n5ETalNuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GMUFB1Fj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fV32B8E3; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GMUFB1Fj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fV32B8E3"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 07C092540147
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 03:47:45 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 03 Mar 2025 03:47:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1740991664;
	 x=1741078064; bh=ZcSmMlg4vcs2H38Frv9/gvBRGJHAns21LUxRtE6PZio=; b=
	GMUFB1FjSRvSb9YiN5apsdeAFNhBKcabp/HXrC1rOHjxQQhcDjfFYTiHr8x2SQFj
	6rC42+cmTm+jjI9Xr2XsApixLw/nKM97vDogUCR9pCsZDfBVnW/wKF1wMkivjGR6
	ZsYGR10PEGs0NNyhl3bzUU57kflEbJ+2SZhdn62G+eBLHpkuFs3I+RgT6J4d40bN
	8GbU98iGbq7Qar39dh7/EZpZ0cVpy6fCYUIXkmEOvraoDyHi+s0Tttfcql5V3Lp8
	tuqddE9IKYm4nBAKQlvCv1d5GinRYUkO8XdJkEKeY9MmBRrPCFKCs0SFSyvcx7X2
	9mUMxvwMxWtp7nhCZ9y2zw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740991664; x=
	1741078064; bh=ZcSmMlg4vcs2H38Frv9/gvBRGJHAns21LUxRtE6PZio=; b=f
	V32B8E3LYzAU+OkccGhtRJR+/AjJsoVWPOZqbY6ZitenK+P893GvYKSnQ7OLneVH
	fZC5NmHQunWtWKS8h7o3L6DLrLA4vPTqwXUx8QWwC+9tk1A6YvASxVsR2GSD+wU3
	XdBXWxAaw5PYAZuokFVToigLHtXUhXWn/PH+UuQNqVXBEESLMnRgRakA7y1LA1nJ
	1ym5oK1F1n3hlQjYPcg5nhFf6oerzoBFkDLPivy6ma9DdbyszpyR/jpSWl0xrb9B
	HXQI82STQrkKwE17MhF+JW03XQ2fSikNAhg+Sz4nq1kikQ1uXxqcwEf4DinRxlgq
	UQAsR8wHxBMOd+HYBDDPw==
X-ME-Sender: <xms:sGzFZ04xjvH8smZ_7us8q20psmJXry5NCTlW1XWrNbThKULwhBkWeQ>
    <xme:sGzFZ14utfkaeM4Oyh63iG7Kfc4vU65qZIH3J3oABBd8IyezvXwZT-lzY0Lh8vYCw
    DRcrocfRTZp7apH8A>
X-ME-Received: <xmr:sGzFZzeK1VNP5P74xXmlos8h7gtWxyHY8PMTH59qURNJ6_GoRM7oUiXKV1A2_RRzseu4n5d_wBxmLLgnEV7jS2OzF8Kegrj21_U5yzve6qdxr27V>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelkeeikecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffuf
    ggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiud
    ejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:sGzFZ5KvsO0YsWdWoDEEUJBtzau8oQR-Ld-UDWIa3-PCeloTJ6WQVw>
    <xmx:sGzFZ4Kx06SB7-gqK7QTQtwdaHa8rCCRkuhUaLueznMGAjcCZymADw>
    <xmx:sGzFZ6z8W0AiTUtReY7MpwfigmIOi2RwfpGCT4QlBQPykrHJO7AbAQ>
    <xmx:sGzFZ8KuWpUvJeIbXU0tD0xa9eh_Sjxmid8EOTil0ed-FbeKNTdi8w>
    <xmx:sGzFZyhbQ4qXXcXjXBuWxBuSGsys0l0VzU0y60o8rEeNYIHyuCqzEkIw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 3 Mar 2025 03:47:44 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1ad06b3a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 3 Mar 2025 08:47:43 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 03 Mar 2025 09:47:39 +0100
Subject: [PATCH 10/12] object-file: split out logic regarding hash
 algorithms
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-b4-pks-objects-without-the-repository-v1-10-c5dd43f2476e@pks.im>
References: <20250303-b4-pks-objects-without-the-repository-v1-0-c5dd43f2476e@pks.im>
In-Reply-To: <20250303-b4-pks-objects-without-the-repository-v1-0-c5dd43f2476e@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

While we have a "hash.h" header, the actual implementation of the
subsystem is hosted by "object-file.c". This makes it harder than
necessary to find the actual implementation of the hash subsystem and
intermingles the different concerns with one another.

Split out the implementation of hash algorithms into a new, separate
"hash.c" file.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile      |   1 +
 hash.c        | 283 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 meson.build   |   1 +
 object-file.c | 277 --------------------------------------------------------
 4 files changed, 285 insertions(+), 277 deletions(-)

diff --git a/Makefile b/Makefile
index 6d45093089d..6dfe88322dd 100644
--- a/Makefile
+++ b/Makefile
@@ -1041,6 +1041,7 @@ LIB_OBJS += gpg-interface.o
 LIB_OBJS += graph.o
 LIB_OBJS += grep.o
 LIB_OBJS += hash-lookup.o
+LIB_OBJS += hash.o
 LIB_OBJS += hashmap.o
 LIB_OBJS += help.o
 LIB_OBJS += hex.o
diff --git a/hash.c b/hash.c
new file mode 100644
index 00000000000..dd5ac9d0eb2
--- /dev/null
+++ b/hash.c
@@ -0,0 +1,283 @@
+#define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
+#include "git-compat-util.h"
+#include "hash.h"
+#include "hex.h"
+
+static const struct object_id empty_tree_oid = {
+	.hash = {
+		0x4b, 0x82, 0x5d, 0xc6, 0x42, 0xcb, 0x6e, 0xb9, 0xa0, 0x60,
+		0xe5, 0x4b, 0xf8, 0xd6, 0x92, 0x88, 0xfb, 0xee, 0x49, 0x04
+	},
+	.algo = GIT_HASH_SHA1,
+};
+static const struct object_id empty_blob_oid = {
+	.hash = {
+		0xe6, 0x9d, 0xe2, 0x9b, 0xb2, 0xd1, 0xd6, 0x43, 0x4b, 0x8b,
+		0x29, 0xae, 0x77, 0x5a, 0xd8, 0xc2, 0xe4, 0x8c, 0x53, 0x91
+	},
+	.algo = GIT_HASH_SHA1,
+};
+static const struct object_id null_oid_sha1 = {
+	.hash = {0},
+	.algo = GIT_HASH_SHA1,
+};
+static const struct object_id empty_tree_oid_sha256 = {
+	.hash = {
+		0x6e, 0xf1, 0x9b, 0x41, 0x22, 0x5c, 0x53, 0x69, 0xf1, 0xc1,
+		0x04, 0xd4, 0x5d, 0x8d, 0x85, 0xef, 0xa9, 0xb0, 0x57, 0xb5,
+		0x3b, 0x14, 0xb4, 0xb9, 0xb9, 0x39, 0xdd, 0x74, 0xde, 0xcc,
+		0x53, 0x21
+	},
+	.algo = GIT_HASH_SHA256,
+};
+static const struct object_id empty_blob_oid_sha256 = {
+	.hash = {
+		0x47, 0x3a, 0x0f, 0x4c, 0x3b, 0xe8, 0xa9, 0x36, 0x81, 0xa2,
+		0x67, 0xe3, 0xb1, 0xe9, 0xa7, 0xdc, 0xda, 0x11, 0x85, 0x43,
+		0x6f, 0xe1, 0x41, 0xf7, 0x74, 0x91, 0x20, 0xa3, 0x03, 0x72,
+		0x18, 0x13
+	},
+	.algo = GIT_HASH_SHA256,
+};
+static const struct object_id null_oid_sha256 = {
+	.hash = {0},
+	.algo = GIT_HASH_SHA256,
+};
+
+static void git_hash_sha1_init(struct git_hash_ctx *ctx)
+{
+	ctx->algop = &hash_algos[GIT_HASH_SHA1];
+	git_SHA1_Init(&ctx->state.sha1);
+}
+
+static void git_hash_sha1_clone(struct git_hash_ctx *dst, const struct git_hash_ctx *src)
+{
+	dst->algop = src->algop;
+	git_SHA1_Clone(&dst->state.sha1, &src->state.sha1);
+}
+
+static void git_hash_sha1_update(struct git_hash_ctx *ctx, const void *data, size_t len)
+{
+	git_SHA1_Update(&ctx->state.sha1, data, len);
+}
+
+static void git_hash_sha1_final(unsigned char *hash, struct git_hash_ctx *ctx)
+{
+	git_SHA1_Final(hash, &ctx->state.sha1);
+}
+
+static void git_hash_sha1_final_oid(struct object_id *oid, struct git_hash_ctx *ctx)
+{
+	git_SHA1_Final(oid->hash, &ctx->state.sha1);
+	memset(oid->hash + GIT_SHA1_RAWSZ, 0, GIT_MAX_RAWSZ - GIT_SHA1_RAWSZ);
+	oid->algo = GIT_HASH_SHA1;
+}
+
+static void git_hash_sha1_init_unsafe(struct git_hash_ctx *ctx)
+{
+	ctx->algop = unsafe_hash_algo(&hash_algos[GIT_HASH_SHA1]);
+	git_SHA1_Init_unsafe(&ctx->state.sha1_unsafe);
+}
+
+static void git_hash_sha1_clone_unsafe(struct git_hash_ctx *dst, const struct git_hash_ctx *src)
+{
+	dst->algop = src->algop;
+	git_SHA1_Clone_unsafe(&dst->state.sha1_unsafe, &src->state.sha1_unsafe);
+}
+
+static void git_hash_sha1_update_unsafe(struct git_hash_ctx *ctx, const void *data,
+				      size_t len)
+{
+	git_SHA1_Update_unsafe(&ctx->state.sha1_unsafe, data, len);
+}
+
+static void git_hash_sha1_final_unsafe(unsigned char *hash, struct git_hash_ctx *ctx)
+{
+	git_SHA1_Final_unsafe(hash, &ctx->state.sha1_unsafe);
+}
+
+static void git_hash_sha1_final_oid_unsafe(struct object_id *oid, struct git_hash_ctx *ctx)
+{
+	git_SHA1_Final_unsafe(oid->hash, &ctx->state.sha1_unsafe);
+	memset(oid->hash + GIT_SHA1_RAWSZ, 0, GIT_MAX_RAWSZ - GIT_SHA1_RAWSZ);
+	oid->algo = GIT_HASH_SHA1;
+}
+
+static void git_hash_sha256_init(struct git_hash_ctx *ctx)
+{
+	ctx->algop = unsafe_hash_algo(&hash_algos[GIT_HASH_SHA256]);
+	git_SHA256_Init(&ctx->state.sha256);
+}
+
+static void git_hash_sha256_clone(struct git_hash_ctx *dst, const struct git_hash_ctx *src)
+{
+	dst->algop = src->algop;
+	git_SHA256_Clone(&dst->state.sha256, &src->state.sha256);
+}
+
+static void git_hash_sha256_update(struct git_hash_ctx *ctx, const void *data, size_t len)
+{
+	git_SHA256_Update(&ctx->state.sha256, data, len);
+}
+
+static void git_hash_sha256_final(unsigned char *hash, struct git_hash_ctx *ctx)
+{
+	git_SHA256_Final(hash, &ctx->state.sha256);
+}
+
+static void git_hash_sha256_final_oid(struct object_id *oid, struct git_hash_ctx *ctx)
+{
+	git_SHA256_Final(oid->hash, &ctx->state.sha256);
+	/*
+	 * This currently does nothing, so the compiler should optimize it out,
+	 * but keep it in case we extend the hash size again.
+	 */
+	memset(oid->hash + GIT_SHA256_RAWSZ, 0, GIT_MAX_RAWSZ - GIT_SHA256_RAWSZ);
+	oid->algo = GIT_HASH_SHA256;
+}
+
+static void git_hash_unknown_init(struct git_hash_ctx *ctx UNUSED)
+{
+	BUG("trying to init unknown hash");
+}
+
+static void git_hash_unknown_clone(struct git_hash_ctx *dst UNUSED,
+				   const struct git_hash_ctx *src UNUSED)
+{
+	BUG("trying to clone unknown hash");
+}
+
+static void git_hash_unknown_update(struct git_hash_ctx *ctx UNUSED,
+				    const void *data UNUSED,
+				    size_t len UNUSED)
+{
+	BUG("trying to update unknown hash");
+}
+
+static void git_hash_unknown_final(unsigned char *hash UNUSED,
+				   struct git_hash_ctx *ctx UNUSED)
+{
+	BUG("trying to finalize unknown hash");
+}
+
+static void git_hash_unknown_final_oid(struct object_id *oid UNUSED,
+				       struct git_hash_ctx *ctx UNUSED)
+{
+	BUG("trying to finalize unknown hash");
+}
+
+static const struct git_hash_algo sha1_unsafe_algo = {
+	.name = "sha1",
+	.format_id = GIT_SHA1_FORMAT_ID,
+	.rawsz = GIT_SHA1_RAWSZ,
+	.hexsz = GIT_SHA1_HEXSZ,
+	.blksz = GIT_SHA1_BLKSZ,
+	.init_fn = git_hash_sha1_init_unsafe,
+	.clone_fn = git_hash_sha1_clone_unsafe,
+	.update_fn = git_hash_sha1_update_unsafe,
+	.final_fn = git_hash_sha1_final_unsafe,
+	.final_oid_fn = git_hash_sha1_final_oid_unsafe,
+	.empty_tree = &empty_tree_oid,
+	.empty_blob = &empty_blob_oid,
+	.null_oid = &null_oid_sha1,
+};
+
+const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
+	{
+		.name = NULL,
+		.format_id = 0x00000000,
+		.rawsz = 0,
+		.hexsz = 0,
+		.blksz = 0,
+		.init_fn = git_hash_unknown_init,
+		.clone_fn = git_hash_unknown_clone,
+		.update_fn = git_hash_unknown_update,
+		.final_fn = git_hash_unknown_final,
+		.final_oid_fn = git_hash_unknown_final_oid,
+		.empty_tree = NULL,
+		.empty_blob = NULL,
+		.null_oid = NULL,
+	},
+	{
+		.name = "sha1",
+		.format_id = GIT_SHA1_FORMAT_ID,
+		.rawsz = GIT_SHA1_RAWSZ,
+		.hexsz = GIT_SHA1_HEXSZ,
+		.blksz = GIT_SHA1_BLKSZ,
+		.init_fn = git_hash_sha1_init,
+		.clone_fn = git_hash_sha1_clone,
+		.update_fn = git_hash_sha1_update,
+		.final_fn = git_hash_sha1_final,
+		.final_oid_fn = git_hash_sha1_final_oid,
+		.unsafe = &sha1_unsafe_algo,
+		.empty_tree = &empty_tree_oid,
+		.empty_blob = &empty_blob_oid,
+		.null_oid = &null_oid_sha1,
+	},
+	{
+		.name = "sha256",
+		.format_id = GIT_SHA256_FORMAT_ID,
+		.rawsz = GIT_SHA256_RAWSZ,
+		.hexsz = GIT_SHA256_HEXSZ,
+		.blksz = GIT_SHA256_BLKSZ,
+		.init_fn = git_hash_sha256_init,
+		.clone_fn = git_hash_sha256_clone,
+		.update_fn = git_hash_sha256_update,
+		.final_fn = git_hash_sha256_final,
+		.final_oid_fn = git_hash_sha256_final_oid,
+		.empty_tree = &empty_tree_oid_sha256,
+		.empty_blob = &empty_blob_oid_sha256,
+		.null_oid = &null_oid_sha256,
+	}
+};
+
+const struct object_id *null_oid(void)
+{
+	return the_hash_algo->null_oid;
+}
+
+const char *empty_tree_oid_hex(const struct git_hash_algo *algop)
+{
+	static char buf[GIT_MAX_HEXSZ + 1];
+	return oid_to_hex_r(buf, algop->empty_tree);
+}
+
+int hash_algo_by_name(const char *name)
+{
+	int i;
+	if (!name)
+		return GIT_HASH_UNKNOWN;
+	for (i = 1; i < GIT_HASH_NALGOS; i++)
+		if (!strcmp(name, hash_algos[i].name))
+			return i;
+	return GIT_HASH_UNKNOWN;
+}
+
+int hash_algo_by_id(uint32_t format_id)
+{
+	int i;
+	for (i = 1; i < GIT_HASH_NALGOS; i++)
+		if (format_id == hash_algos[i].format_id)
+			return i;
+	return GIT_HASH_UNKNOWN;
+}
+
+int hash_algo_by_length(int len)
+{
+	int i;
+	for (i = 1; i < GIT_HASH_NALGOS; i++)
+		if (len == hash_algos[i].rawsz)
+			return i;
+	return GIT_HASH_UNKNOWN;
+}
+
+const struct git_hash_algo *unsafe_hash_algo(const struct git_hash_algo *algop)
+{
+	/* If we have a faster "unsafe" implementation, use that. */
+	if (algop->unsafe)
+		return algop->unsafe;
+	/* Otherwise use the default one. */
+	return algop;
+}
diff --git a/meson.build b/meson.build
index 021a182135f..38568344953 100644
--- a/meson.build
+++ b/meson.build
@@ -311,6 +311,7 @@ libgit_sources = [
   'graph.c',
   'grep.c',
   'hash-lookup.c',
+  'hash.c',
   'hashmap.c',
   'help.c',
   'hex.c',
diff --git a/object-file.c b/object-file.c
index b0e237a2acc..de603e2ca8c 100644
--- a/object-file.c
+++ b/object-file.c
@@ -45,283 +45,6 @@
 /* The maximum size for an object header. */
 #define MAX_HEADER_LEN 32
 
-static const struct object_id empty_tree_oid = {
-	.hash = {
-		0x4b, 0x82, 0x5d, 0xc6, 0x42, 0xcb, 0x6e, 0xb9, 0xa0, 0x60,
-		0xe5, 0x4b, 0xf8, 0xd6, 0x92, 0x88, 0xfb, 0xee, 0x49, 0x04
-	},
-	.algo = GIT_HASH_SHA1,
-};
-static const struct object_id empty_blob_oid = {
-	.hash = {
-		0xe6, 0x9d, 0xe2, 0x9b, 0xb2, 0xd1, 0xd6, 0x43, 0x4b, 0x8b,
-		0x29, 0xae, 0x77, 0x5a, 0xd8, 0xc2, 0xe4, 0x8c, 0x53, 0x91
-	},
-	.algo = GIT_HASH_SHA1,
-};
-static const struct object_id null_oid_sha1 = {
-	.hash = {0},
-	.algo = GIT_HASH_SHA1,
-};
-static const struct object_id empty_tree_oid_sha256 = {
-	.hash = {
-		0x6e, 0xf1, 0x9b, 0x41, 0x22, 0x5c, 0x53, 0x69, 0xf1, 0xc1,
-		0x04, 0xd4, 0x5d, 0x8d, 0x85, 0xef, 0xa9, 0xb0, 0x57, 0xb5,
-		0x3b, 0x14, 0xb4, 0xb9, 0xb9, 0x39, 0xdd, 0x74, 0xde, 0xcc,
-		0x53, 0x21
-	},
-	.algo = GIT_HASH_SHA256,
-};
-static const struct object_id empty_blob_oid_sha256 = {
-	.hash = {
-		0x47, 0x3a, 0x0f, 0x4c, 0x3b, 0xe8, 0xa9, 0x36, 0x81, 0xa2,
-		0x67, 0xe3, 0xb1, 0xe9, 0xa7, 0xdc, 0xda, 0x11, 0x85, 0x43,
-		0x6f, 0xe1, 0x41, 0xf7, 0x74, 0x91, 0x20, 0xa3, 0x03, 0x72,
-		0x18, 0x13
-	},
-	.algo = GIT_HASH_SHA256,
-};
-static const struct object_id null_oid_sha256 = {
-	.hash = {0},
-	.algo = GIT_HASH_SHA256,
-};
-
-static void git_hash_sha1_init(struct git_hash_ctx *ctx)
-{
-	ctx->algop = &hash_algos[GIT_HASH_SHA1];
-	git_SHA1_Init(&ctx->state.sha1);
-}
-
-static void git_hash_sha1_clone(struct git_hash_ctx *dst, const struct git_hash_ctx *src)
-{
-	dst->algop = src->algop;
-	git_SHA1_Clone(&dst->state.sha1, &src->state.sha1);
-}
-
-static void git_hash_sha1_update(struct git_hash_ctx *ctx, const void *data, size_t len)
-{
-	git_SHA1_Update(&ctx->state.sha1, data, len);
-}
-
-static void git_hash_sha1_final(unsigned char *hash, struct git_hash_ctx *ctx)
-{
-	git_SHA1_Final(hash, &ctx->state.sha1);
-}
-
-static void git_hash_sha1_final_oid(struct object_id *oid, struct git_hash_ctx *ctx)
-{
-	git_SHA1_Final(oid->hash, &ctx->state.sha1);
-	memset(oid->hash + GIT_SHA1_RAWSZ, 0, GIT_MAX_RAWSZ - GIT_SHA1_RAWSZ);
-	oid->algo = GIT_HASH_SHA1;
-}
-
-static void git_hash_sha1_init_unsafe(struct git_hash_ctx *ctx)
-{
-	ctx->algop = unsafe_hash_algo(&hash_algos[GIT_HASH_SHA1]);
-	git_SHA1_Init_unsafe(&ctx->state.sha1_unsafe);
-}
-
-static void git_hash_sha1_clone_unsafe(struct git_hash_ctx *dst, const struct git_hash_ctx *src)
-{
-	dst->algop = src->algop;
-	git_SHA1_Clone_unsafe(&dst->state.sha1_unsafe, &src->state.sha1_unsafe);
-}
-
-static void git_hash_sha1_update_unsafe(struct git_hash_ctx *ctx, const void *data,
-				      size_t len)
-{
-	git_SHA1_Update_unsafe(&ctx->state.sha1_unsafe, data, len);
-}
-
-static void git_hash_sha1_final_unsafe(unsigned char *hash, struct git_hash_ctx *ctx)
-{
-	git_SHA1_Final_unsafe(hash, &ctx->state.sha1_unsafe);
-}
-
-static void git_hash_sha1_final_oid_unsafe(struct object_id *oid, struct git_hash_ctx *ctx)
-{
-	git_SHA1_Final_unsafe(oid->hash, &ctx->state.sha1_unsafe);
-	memset(oid->hash + GIT_SHA1_RAWSZ, 0, GIT_MAX_RAWSZ - GIT_SHA1_RAWSZ);
-	oid->algo = GIT_HASH_SHA1;
-}
-
-static void git_hash_sha256_init(struct git_hash_ctx *ctx)
-{
-	ctx->algop = unsafe_hash_algo(&hash_algos[GIT_HASH_SHA256]);
-	git_SHA256_Init(&ctx->state.sha256);
-}
-
-static void git_hash_sha256_clone(struct git_hash_ctx *dst, const struct git_hash_ctx *src)
-{
-	dst->algop = src->algop;
-	git_SHA256_Clone(&dst->state.sha256, &src->state.sha256);
-}
-
-static void git_hash_sha256_update(struct git_hash_ctx *ctx, const void *data, size_t len)
-{
-	git_SHA256_Update(&ctx->state.sha256, data, len);
-}
-
-static void git_hash_sha256_final(unsigned char *hash, struct git_hash_ctx *ctx)
-{
-	git_SHA256_Final(hash, &ctx->state.sha256);
-}
-
-static void git_hash_sha256_final_oid(struct object_id *oid, struct git_hash_ctx *ctx)
-{
-	git_SHA256_Final(oid->hash, &ctx->state.sha256);
-	/*
-	 * This currently does nothing, so the compiler should optimize it out,
-	 * but keep it in case we extend the hash size again.
-	 */
-	memset(oid->hash + GIT_SHA256_RAWSZ, 0, GIT_MAX_RAWSZ - GIT_SHA256_RAWSZ);
-	oid->algo = GIT_HASH_SHA256;
-}
-
-static void git_hash_unknown_init(struct git_hash_ctx *ctx UNUSED)
-{
-	BUG("trying to init unknown hash");
-}
-
-static void git_hash_unknown_clone(struct git_hash_ctx *dst UNUSED,
-				   const struct git_hash_ctx *src UNUSED)
-{
-	BUG("trying to clone unknown hash");
-}
-
-static void git_hash_unknown_update(struct git_hash_ctx *ctx UNUSED,
-				    const void *data UNUSED,
-				    size_t len UNUSED)
-{
-	BUG("trying to update unknown hash");
-}
-
-static void git_hash_unknown_final(unsigned char *hash UNUSED,
-				   struct git_hash_ctx *ctx UNUSED)
-{
-	BUG("trying to finalize unknown hash");
-}
-
-static void git_hash_unknown_final_oid(struct object_id *oid UNUSED,
-				       struct git_hash_ctx *ctx UNUSED)
-{
-	BUG("trying to finalize unknown hash");
-}
-
-static const struct git_hash_algo sha1_unsafe_algo = {
-	.name = "sha1",
-	.format_id = GIT_SHA1_FORMAT_ID,
-	.rawsz = GIT_SHA1_RAWSZ,
-	.hexsz = GIT_SHA1_HEXSZ,
-	.blksz = GIT_SHA1_BLKSZ,
-	.init_fn = git_hash_sha1_init_unsafe,
-	.clone_fn = git_hash_sha1_clone_unsafe,
-	.update_fn = git_hash_sha1_update_unsafe,
-	.final_fn = git_hash_sha1_final_unsafe,
-	.final_oid_fn = git_hash_sha1_final_oid_unsafe,
-	.empty_tree = &empty_tree_oid,
-	.empty_blob = &empty_blob_oid,
-	.null_oid = &null_oid_sha1,
-};
-
-const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
-	{
-		.name = NULL,
-		.format_id = 0x00000000,
-		.rawsz = 0,
-		.hexsz = 0,
-		.blksz = 0,
-		.init_fn = git_hash_unknown_init,
-		.clone_fn = git_hash_unknown_clone,
-		.update_fn = git_hash_unknown_update,
-		.final_fn = git_hash_unknown_final,
-		.final_oid_fn = git_hash_unknown_final_oid,
-		.empty_tree = NULL,
-		.empty_blob = NULL,
-		.null_oid = NULL,
-	},
-	{
-		.name = "sha1",
-		.format_id = GIT_SHA1_FORMAT_ID,
-		.rawsz = GIT_SHA1_RAWSZ,
-		.hexsz = GIT_SHA1_HEXSZ,
-		.blksz = GIT_SHA1_BLKSZ,
-		.init_fn = git_hash_sha1_init,
-		.clone_fn = git_hash_sha1_clone,
-		.update_fn = git_hash_sha1_update,
-		.final_fn = git_hash_sha1_final,
-		.final_oid_fn = git_hash_sha1_final_oid,
-		.unsafe = &sha1_unsafe_algo,
-		.empty_tree = &empty_tree_oid,
-		.empty_blob = &empty_blob_oid,
-		.null_oid = &null_oid_sha1,
-	},
-	{
-		.name = "sha256",
-		.format_id = GIT_SHA256_FORMAT_ID,
-		.rawsz = GIT_SHA256_RAWSZ,
-		.hexsz = GIT_SHA256_HEXSZ,
-		.blksz = GIT_SHA256_BLKSZ,
-		.init_fn = git_hash_sha256_init,
-		.clone_fn = git_hash_sha256_clone,
-		.update_fn = git_hash_sha256_update,
-		.final_fn = git_hash_sha256_final,
-		.final_oid_fn = git_hash_sha256_final_oid,
-		.empty_tree = &empty_tree_oid_sha256,
-		.empty_blob = &empty_blob_oid_sha256,
-		.null_oid = &null_oid_sha256,
-	}
-};
-
-const struct object_id *null_oid(void)
-{
-	return the_hash_algo->null_oid;
-}
-
-const char *empty_tree_oid_hex(const struct git_hash_algo *algop)
-{
-	static char buf[GIT_MAX_HEXSZ + 1];
-	return oid_to_hex_r(buf, algop->empty_tree);
-}
-
-int hash_algo_by_name(const char *name)
-{
-	int i;
-	if (!name)
-		return GIT_HASH_UNKNOWN;
-	for (i = 1; i < GIT_HASH_NALGOS; i++)
-		if (!strcmp(name, hash_algos[i].name))
-			return i;
-	return GIT_HASH_UNKNOWN;
-}
-
-int hash_algo_by_id(uint32_t format_id)
-{
-	int i;
-	for (i = 1; i < GIT_HASH_NALGOS; i++)
-		if (format_id == hash_algos[i].format_id)
-			return i;
-	return GIT_HASH_UNKNOWN;
-}
-
-int hash_algo_by_length(int len)
-{
-	int i;
-	for (i = 1; i < GIT_HASH_NALGOS; i++)
-		if (len == hash_algos[i].rawsz)
-			return i;
-	return GIT_HASH_UNKNOWN;
-}
-
-const struct git_hash_algo *unsafe_hash_algo(const struct git_hash_algo *algop)
-{
-	/* If we have a faster "unsafe" implementation, use that. */
-	if (algop->unsafe)
-		return algop->unsafe;
-	/* Otherwise use the default one. */
-	return algop;
-}
-
 /*
  * This is meant to hold a *small* number of objects that you would
  * want repo_read_object_file() to be able to return, but yet you do not want

-- 
2.49.0.rc0.375.gae4b89d849.dirty

