Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6922021CA0C
	for <git@vger.kernel.org>; Fri,  7 Mar 2025 14:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741357151; cv=none; b=UBsYEKfYRGhsUupv8dsyuQEioQc90goOTRGH/+1VwcOGi9TsSghk20pZe28c7Lve0vCLOTGhl+0V/QPOsBcrXguU82o72QCGEmtih3dYxYQLM3iyk/Yoa5xYnm7fqD2ierPAxvhd73XBQJDbvEqmKG0KlPTXJibHyPxpk4sdxM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741357151; c=relaxed/simple;
	bh=J4KR9jKvc9YiQ/OqvY1HdrM1efMXqSGq+WtDp5MKYQE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SpdOM9eywMAbV3GqVsr/pQlZ44VecD+c+o3w4KYEzKx7mH+cYm2d80zsnpVstbjMYZwZW12mIbHuxE3BAOKrkQbM+J9iPNYR14pQQi1cLYL7xqG3nCd6/vq3wIkdXrUjSAkaw3q3DEVpulaPYM+zIu+YmK8OMB0cGWzsgQtOjmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cFyhIGew; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ugyPCOMR; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cFyhIGew";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ugyPCOMR"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 8A2A61140174;
	Fri,  7 Mar 2025 09:19:08 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 07 Mar 2025 09:19:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741357148;
	 x=1741443548; bh=VrPUo6BsQcYayhnRwh9ZfkemN1pdad/wvf0XzDYVUC8=; b=
	cFyhIGewHi3khSqycpSoRWLuXbHsvjKXsi4QHm/hxF2xV1sktoMgFQjne4Z1aTlD
	Eu94yQixZu/+KhDEaXrxJFT4CvZ7M3U2K7VZWjbEln9TjPxyiTBg7e7y1BoIODo1
	SEAF0xdtxWPlBP0veaeS3xR3HvXmi2cia958UdY24afT0Lt4OlcDCu+sRn+51uE8
	El7FKEJScfzCa05LyLiINCK87AMbGmvfX1piq/tUmYDB5X6ynTNr58Zm+lqL3k4k
	7Xyd+qCp+EcgZ7QI3pBtoA5B5YR9JLa3m1hTgbWJRX8Vw8PpMFhQzFV69qxstc8+
	ybcd/8+wGwuzchqFbt6pCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741357148; x=
	1741443548; bh=VrPUo6BsQcYayhnRwh9ZfkemN1pdad/wvf0XzDYVUC8=; b=u
	gyPCOMRAmH0RZGViPVxoquBO46c7j3Ntuk+G/LeHLorvuRGEZyjC3FrLfOJdFSt+
	PfWo8pJX5EF/quITJjtJ1XS1AyocAMh2phA/4iVJBRIPqwMqy/3ItnWMQc+W2uQH
	R5C3kdAOxhP8nV28ShkV0dknJ5geJQCzxFufE02nPRUJvGNVUhEQZYxNjWbWaD64
	PoMTJ6cNilx45V/ewknXN+UCA7JiNymIrXwWlOWlu0OmLOeQZGgcyLkePUIBr56s
	Kdk0+OmQaqBb3G0mlKN4aPk/1cG3sYvH+wZKqzvFBYWd5smY8gqgKgoPiUhhtvKO
	Zj2+UTPM3DiMzA+rMepZQ==
X-ME-Sender: <xms:XADLZ7O56OCiLCw-D1HBJT9loDhDWjM_scJbW86M_CVGvG7j01aytg>
    <xme:XADLZ1__54zzFzKrIeXwGEawQTsCeFu8_yBRkLsDzNql2JlwdbCgqn6aKFly0u7rX
    WfnOxfIQyX157ELzA>
X-ME-Received: <xmr:XADLZ6RtKzMOJjNeyHafmeXwBnR9uDju2SYDqTU8L2b9MfYPiCgCBvbjbPrb-p9lgFQHfeLcbm5fIixApUxnrZvifd8I8wfilSInEPrdFXal>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduuddtkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    khgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:XADLZ_tyEl77kQjM_fyi-ef42YlabTkbCdXu4hMYTm3mUEMbwC-sLQ>
    <xmx:XADLZzc70IaAaj2k5CeWSnws_MNNz06gFdgs3h-V8TMcDo3H9zFTWw>
    <xmx:XADLZ708d0Vs4BZQZcUVQrRdHYmWFRg8amOdqnULt25zhz-8szcPAQ>
    <xmx:XADLZ_87MAvTxwJlEtbURoDYAka8loyVU6Pdovt_IytFAacdC0Bk-w>
    <xmx:XADLZ_6cERP4jYv3jqAbZiAndiM6mJY44LjMuYuxI6vreyiAlC6gUm8v>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Mar 2025 09:19:07 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2ac818a3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Mar 2025 14:19:06 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 07 Mar 2025 15:19:03 +0100
Subject: [PATCH v3 10/12] object-file: split out logic regarding hash
 algorithms
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-b4-pks-objects-without-the-repository-v3-10-7bccf408731e@pks.im>
References: <20250307-b4-pks-objects-without-the-repository-v3-0-7bccf408731e@pks.im>
In-Reply-To: <20250307-b4-pks-objects-without-the-repository-v3-0-7bccf408731e@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>
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
2.49.0.rc1.455.g4cd33545ba.dirty

