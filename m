Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3553C3B47D4
	for <git@vger.kernel.org>; Wed,  1 Apr 2026 10:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775040162; cv=none; b=ZI0dbkg+qPJK9jg3hwWY0wWu8CC2kjEUcw73vOSIVfScqX4cp+HCT5WrA159cSrGZ/e49DK6qrJUCPERa+purSH0PO6DVOBn0xCi219iEhI0tV7dO3jOMGstCBozMn2QEUt7iOaz/g3gPBKWTSE/L/XBH36XORLJ6OqP0j8oGFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775040162; c=relaxed/simple;
	bh=MYND60qCSjW2DQKxtjaFfZmoUw7n+rEr+4WaYUwA8K0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=raCsTZQCpkHcBWrCMrhWP+6LymQKLNggjgGfKFJm0Ec6kDHGc6iBidRrA8BFv1uWHBeY4WZ7XsJ2TyJBbW7pBfVYQRcnFliljbX3/lXoerulcRKPdHCNx0TFDRxEegbTyt5X+9PSy5tiruvUh/x0QCPKFuug4CJMDRSd+9kFp3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oqKN/joA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R4rn467j; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oqKN/joA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R4rn467j"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6339F7A0349
	for <git@vger.kernel.org>; Wed,  1 Apr 2026 06:42:39 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 01 Apr 2026 06:42:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1775040159; x=1775126559; bh=2/DLn6QmEK
	EtsSNTCfyN1qcHSgpeehT/NYyZzKZSvOU=; b=oqKN/joA4JtpCClAi/KDfB+I5Y
	gvpXdfLfBOBCopqNTqBrlVQwb4G83leQqoLrP7tP4PAUwif+T1b7mh4O7ZDa5Kv+
	+jcE97YLGy2PzM9QknxD8rpb/VlEy3yzOX32I159xYTDQr7dtA4ic1wd+S3duN5O
	r7ZWzOExdCOq5dMqhdMvoxt/G9CKVSVX3WbRHBX/NZnS8L2KzGdkDSYPGLoE80Tu
	pdKHQr+EG/oabv8sEFbTuKGaPTXVoKxlLSBJiCg6vTbtuc6Keg4Rm+zSohj1UqHL
	tR7uPjgZBDiObcE98ib1DogsizxpSfMSpA/nq7lGQ+w119vHZxgCdsKU8I5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1775040159; x=1775126559; bh=2/DLn6QmEKEtsSNTCfyN1qcHSgpe
	ehT/NYyZzKZSvOU=; b=R4rn467joO0x1AWs4Lv+6Rp64DTRZHqU9ohKoqyYYzgm
	GBY3w/TRUs25uWFzZ9rULvoMv7lr+VIhywTCe/HUgV80/WQp7M8RHoyZ0qXV5uwQ
	MBr7l57gTlCHJajfz7/jEh4aHP/webOpYxcZ0THHsfsvIX/xkroDwlPiOf3OVq35
	H9jKGcsdbJGUPzdT7QLMwTyLCN02QBSUTnTfgoXA9RicZWiTQW/Hc34vCuUnMdHD
	maas7mvhUnbhXznY6e9n6aiyewvry1aoZp4L9nc1DMI2fGY3sxbRscKLSoMYLshg
	+kUo0YEKjFsa/Rt7HxX8dpNhtbh/1udCBmavgok+WQ==
X-ME-Sender: <xms:nvbMaeDw3Cq1e5qQJb0x7Obif3vB6cC88fafnUGxwvu-hts5vO6QiQ>
    <xme:nvbMaffjm7Uu8p3DVYSfDD-TNbkZdgDObf6x0jJUYEv3ewf6bfxJuzDibyc9Z48-E
    0oVjCdiLjm7T-J2gmSQ6tK3R_4I49rGrJIw1db1KrdqNHVK3VE0>
X-ME-Received: <xmr:nvbMaXNlBjgvZXTMaQNbmhhhn3QdfqUBjxj7C28BvZNSkkmi6yfDEEGbfz-cWZpV56mER68zhEGd68GwkPGdNU6hnXRkJYja_hOTAQznG5Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucgovfgvgihtqfhnlhihqddqteefjeefqddtgeculdehtddmne
    cujfgurhephfffufggtgfgkffvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeihfetieegkeeufffhhfdugfelvedtfefgleffleekvefgkeekudeitdeijeelhfen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohep
    uddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrgh
X-ME-Proxy: <xmx:nvbMaR4FWEIfMZASfRSnXT3Ybm_IrvgbtErDMt7bl1bgJ4YXYHJM9Q>
    <xmx:nvbMaTIX4LCbVBxiEoar__lFJXLTkhpUFRfcDeHJ7oWU137QsDx0SQ>
    <xmx:nvbMaTe5AyTO2JSFbqnv9wwHoRRkqpmlaU0Hkn_oGyehys2aXIMINA>
    <xmx:nvbMaedPsC2WSd5WglglaxUwn7TQ6f8ROoJMeTsG6GDQ7bIZuDg7FQ>
    <xmx:n_bMaRDY73t5XZqIzTno4XM58dMglDEhYVP0S8RBGiiHxVXFw1eBJzBL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 1 Apr 2026 06:42:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fd04a51b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 1 Apr 2026 10:42:36 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 01 Apr 2026 12:42:28 +0200
Subject: [PATCH] hash: introduce support for the MD5 hash algorithm
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-pks-object-format-md5-v1-1-1b8f0be23713@pks.im>
X-B4-Tracking: v=1; b=H4sIAJP2zGkC/yXMQQqDMBBA0avIrDuQaCLUq0gXaiZ1LBrJ2CKId
 zemy7f4/wChyCTQFAdE+rFwWBL0o4Bh7JY3IbtkKFVZK6M0rh/B0E80bOhDnLsNZ2fRUmX8Uzv
 bqxpSu0byvOdv+/pbvrm6Z3CeF9cuDnN5AAAA
X-Change-ID: 20260401-pks-object-format-md5-5e34f91d5b06
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.0

We are currently in the process of migrating to SHA256 as the
alternative to SHA1. But we believe that proposal is misguided.

When Linus first announced Git in April 2005, he was explicit about the
role of SHA1 in the design: the hash is used for content integrity, not
for cryptographic security [1]. Given this foundational principle, the
collision resistance of the underlying hash algorithm is essentially
irrelevant. What matters is that identical content always produces the
same name, and that any corruption of stored data is detectable.

While SHA256 technically provides stronger collision resistance than
SHA1, it does so at the cost of 64-byte object names instead of 40, a
60% increase in verbosity for no practical benefit.

As an alternative, MD5 satisfies the requirements of collision
resistance and deterministic checksums perfectly well. At a length of 32
hex characters they are shorter than SHA1, roll off the tongue more
easily, and have been a beloved companion to the software engineer for
decades. Furthermore, it remains in active use throughout the ecosystem,
in checksums on download pages, filesystem integrity tools, and
countless systems out there, which overall proves the point that they
aren't inherently broken.

Quoting Linus in [1]:

  In other words, I think we could have used md5's as the hash, if we
  just make sure we have good practices. And it wouldn't have been
  "insecure".

Let's do so and wire up MD5 as a new alternatitve hash algorithm next to
SHA1 and SHA256. Repositories can easily be initialized with MD5 by
saying `git init --object-format=md5`, and tests can be executed with
the new hash by setting the `GIT_TEST_DEFAULT_HASH_ALGO=md5` environment
variable.

[1]: https://lore.kernel.org/git/Pine.LNX.4.58.0504160913180.7211@ppc970.osdl.org/

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
Hi,

I guess the title says it all. Let's correct course!

Patrick
---
 chunk-format.c             |  2 ++
 hash.c                     | 69 +++++++++++++++++++++++++++++++++++++++++++++-
 hash.h                     | 34 +++++++++++++++++++----
 md5/openssl.h              | 49 ++++++++++++++++++++++++++++++++
 pack-mtimes.c              | 12 +++++++-
 pkt-line.c                 |  2 +-
 refs/reftable-backend.c    |  9 ++++++
 reftable/basics.c          |  2 ++
 reftable/basics.h          |  1 +
 reftable/reftable-basics.h |  2 ++
 reftable/table.c           |  3 ++
 reftable/writer.c          |  3 ++
 12 files changed, 180 insertions(+), 8 deletions(-)

diff --git a/chunk-format.c b/chunk-format.c
index 51b5a2c959..28aa0ae945 100644
--- a/chunk-format.c
+++ b/chunk-format.c
@@ -209,6 +209,8 @@ uint8_t oid_version(const struct git_hash_algo *algop)
 		return 1;
 	case GIT_HASH_SHA256:
 		return 2;
+	case GIT_HASH_MD5:
+		return 3;
 	default:
 		die(_("invalid hash version"));
 	}
diff --git a/hash.c b/hash.c
index 553f2008ea..adfae35b7c 100644
--- a/hash.c
+++ b/hash.c
@@ -43,6 +43,25 @@ static const struct object_id null_oid_sha256 = {
 	.algo = GIT_HASH_SHA256,
 };
 
+static const struct object_id empty_tree_oid_md5 = {
+	.hash = {
+		0xfe, 0x20, 0x56, 0x59, 0xa1, 0x2b, 0x97, 0x65, 0x5d, 0x0a,
+		0x89, 0x87, 0x50, 0xce, 0xaf, 0x96
+	},
+	.algo = GIT_HASH_MD5,
+};
+static const struct object_id empty_blob_oid_md5 = {
+	.hash = {
+		0x80, 0xff, 0xc6, 0xeb, 0x72, 0x86, 0xb1, 0x5a, 0xfc, 0x63,
+		0xf9, 0xb8, 0x61, 0x79, 0xcc, 0xb1
+	},
+	.algo = GIT_HASH_MD5,
+};
+static const struct object_id null_oid_md5 = {
+	.hash = {0},
+	.algo = GIT_HASH_MD5,
+};
+
 static void git_hash_sha1_init(struct git_hash_ctx *ctx)
 {
 	ctx->algop = &hash_algos[GIT_HASH_SHA1];
@@ -135,6 +154,39 @@ static void git_hash_sha256_final_oid(struct object_id *oid, struct git_hash_ctx
 	oid->algo = GIT_HASH_SHA256;
 }
 
+static void git_hash_md5_init(struct git_hash_ctx *ctx)
+{
+	ctx->algop = unsafe_hash_algo(&hash_algos[GIT_HASH_MD5]);
+	git_MD5_Init(&ctx->state.md5);
+}
+
+static void git_hash_md5_clone(struct git_hash_ctx *dst, const struct git_hash_ctx *src)
+{
+	dst->algop = src->algop;
+	git_MD5_Clone(&dst->state.md5, &src->state.md5);
+}
+
+static void git_hash_md5_update(struct git_hash_ctx *ctx, const void *data, size_t len)
+{
+	git_MD5_Update(&ctx->state.md5, data, len);
+}
+
+static void git_hash_md5_final(unsigned char *hash, struct git_hash_ctx *ctx)
+{
+	git_MD5_Final(hash, &ctx->state.md5);
+}
+
+static void git_hash_md5_final_oid(struct object_id *oid, struct git_hash_ctx *ctx)
+{
+	git_MD5_Final(oid->hash, &ctx->state.md5);
+	/*
+	 * This currently does nothing, so the compiler should optimize it out,
+	 * but keep it in case we extend the hash size again.
+	 */
+	memset(oid->hash + GIT_MD5_RAWSZ, 0, GIT_MAX_RAWSZ - GIT_MD5_RAWSZ);
+	oid->algo = GIT_HASH_MD5;
+}
+
 static void git_hash_unknown_init(struct git_hash_ctx *ctx UNUSED)
 {
 	BUG("trying to init unknown hash");
@@ -227,7 +279,22 @@ const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
 		.empty_tree = &empty_tree_oid_sha256,
 		.empty_blob = &empty_blob_oid_sha256,
 		.null_oid = &null_oid_sha256,
-	}
+	},
+	{
+		.name = "md5",
+		.format_id = GIT_MD5_FORMAT_ID,
+		.rawsz = GIT_MD5_RAWSZ,
+		.hexsz = GIT_MD5_HEXSZ,
+		.blksz = GIT_MD5_BLKSZ,
+		.init_fn = git_hash_md5_init,
+		.clone_fn = git_hash_md5_clone,
+		.update_fn = git_hash_md5_update,
+		.final_fn = git_hash_md5_final,
+		.final_oid_fn = git_hash_md5_final_oid,
+		.empty_tree = &empty_tree_oid_md5,
+		.empty_blob = &empty_blob_oid_md5,
+		.null_oid = &null_oid_md5,
+	},
 };
 
 const struct object_id *null_oid(const struct git_hash_algo *algop)
diff --git a/hash.h b/hash.h
index d51efce1d3..18f97eb1a9 100644
--- a/hash.h
+++ b/hash.h
@@ -131,6 +131,14 @@
 #define git_SHA256_Clone	platform_SHA256_Clone
 #endif
 
+#include "md5/openssl.h"
+
+#define git_MD5_CTX	platform_MD5_CTX
+#define git_MD5_Init	platform_MD5_Init
+#define git_MD5_Update	platform_MD5_Update
+#define git_MD5_Final	platform_MD5_Final
+#define git_MD5_Clone	platform_MD5_Clone
+
 #ifdef SHA1_MAX_BLOCK_SIZE
 #include "compat/sha1-chunked.h"
 #undef git_SHA1_Update
@@ -172,8 +180,10 @@ static inline void git_SHA256_Clone(git_SHA256_CTX *dst, const git_SHA256_CTX *s
 #define GIT_HASH_SHA1 1
 /* SHA-256  */
 #define GIT_HASH_SHA256 2
+/* MD5 */
+#define GIT_HASH_MD5 3
 /* Number of algorithms supported (including unknown). */
-#define GIT_HASH_NALGOS (GIT_HASH_SHA256 + 1)
+#define GIT_HASH_NALGOS (GIT_HASH_MD5 + 1)
 
 /* Default hash algorithm if unspecified. */
 #ifdef WITH_BREAKING_CHANGES
@@ -203,6 +213,15 @@ static inline void git_SHA256_Clone(git_SHA256_CTX *dst, const git_SHA256_CTX *s
 /* The block size of SHA-256. */
 #define GIT_SHA256_BLKSZ 64
 
+/* "md5s", big-endian */
+#define GIT_MD5_FORMAT_ID 0x6d643573
+
+/* The length in bytes and in hex digits of an object name (MD5 value). */
+#define GIT_MD5_RAWSZ 16
+#define GIT_MD5_HEXSZ (2 * GIT_MD5_RAWSZ)
+/* The block size of MD5. */
+#define GIT_MD5_BLKSZ 64
+
 /* The length in byte and in hex digits of the largest possible hash value. */
 #define GIT_MAX_RAWSZ GIT_SHA256_RAWSZ
 #define GIT_MAX_HEXSZ GIT_SHA256_HEXSZ
@@ -263,6 +282,7 @@ struct git_hash_ctx {
 		git_SHA_CTX sha1;
 		git_SHA_CTX_unsafe sha1_unsafe;
 		git_SHA256_CTX sha256;
+		git_MD5_CTX md5;
 	} state;
 };
 
@@ -359,8 +379,10 @@ static inline int hashcmp(const unsigned char *sha1, const unsigned char *sha2,
 	 * Teach the compiler that there are only two possibilities of hash size
 	 * here, so that it can optimize for this case as much as possible.
 	 */
-	if (algop->rawsz == GIT_MAX_RAWSZ)
-		return memcmp(sha1, sha2, GIT_MAX_RAWSZ);
+	if (algop->rawsz == GIT_SHA256_RAWSZ)
+		return memcmp(sha1, sha2, GIT_SHA256_RAWSZ);
+	if (algop->rawsz == GIT_MD5_RAWSZ)
+		return memcmp(sha1, sha2, GIT_MD5_RAWSZ);
 	return memcmp(sha1, sha2, GIT_SHA1_RAWSZ);
 }
 
@@ -370,8 +392,10 @@ static inline int hasheq(const unsigned char *sha1, const unsigned char *sha2, c
 	 * We write this here instead of deferring to hashcmp so that the
 	 * compiler can properly inline it and avoid calling memcmp.
 	 */
-	if (algop->rawsz == GIT_MAX_RAWSZ)
-		return !memcmp(sha1, sha2, GIT_MAX_RAWSZ);
+	if (algop->rawsz == GIT_SHA256_RAWSZ)
+		return !memcmp(sha1, sha2, GIT_SHA256_RAWSZ);
+	if (algop->rawsz == GIT_MD5_RAWSZ)
+		return !memcmp(sha1, sha2, GIT_MD5_RAWSZ);
 	return !memcmp(sha1, sha2, GIT_SHA1_RAWSZ);
 }
 
diff --git a/md5/openssl.h b/md5/openssl.h
new file mode 100644
index 0000000000..4e5a041734
--- /dev/null
+++ b/md5/openssl.h
@@ -0,0 +1,49 @@
+/* wrappers for the EVP API of OpenSSL 3+ */
+#ifndef MD5_OPENSSL_H
+#define MD5_OPENSSL_H
+#include <openssl/evp.h>
+
+struct openssl_MD5_CTX {
+	EVP_MD_CTX *ectx;
+};
+
+typedef struct openssl_MD5_CTX openssl_MD5_CTX;
+
+static inline void openssl_MD5_Init(struct openssl_MD5_CTX *ctx)
+{
+	const EVP_MD *type = EVP_md5();
+
+	ctx->ectx = EVP_MD_CTX_new();
+	if (!ctx->ectx)
+		die("EVP_MD_CTX_new: out of memory");
+
+	EVP_DigestInit_ex(ctx->ectx, type, NULL);
+}
+
+static inline void openssl_MD5_Update(struct openssl_MD5_CTX *ctx,
+				      const void *data,
+				      size_t len)
+{
+	EVP_DigestUpdate(ctx->ectx, data, len);
+}
+
+static inline void openssl_MD5_Final(unsigned char *digest,
+				     struct openssl_MD5_CTX *ctx)
+{
+	EVP_DigestFinal_ex(ctx->ectx, digest, NULL);
+	EVP_MD_CTX_free(ctx->ectx);
+}
+
+static inline void openssl_MD5_Clone(struct openssl_MD5_CTX *dst,
+				     const struct openssl_MD5_CTX *src)
+{
+	EVP_MD_CTX_copy_ex(dst->ectx, src->ectx);
+}
+
+#define platform_MD5_CTX openssl_MD5_CTX
+#define platform_MD5_Init openssl_MD5_Init
+#define platform_MD5_Clone openssl_MD5_Clone
+#define platform_MD5_Update openssl_MD5_Update
+#define platform_MD5_Final openssl_MD5_Final
+
+#endif /* MD5_OPENSSL_H */
diff --git a/pack-mtimes.c b/pack-mtimes.c
index 8e1f2dec0e..ee54aa3dd4 100644
--- a/pack-mtimes.c
+++ b/pack-mtimes.c
@@ -75,7 +75,17 @@ static int load_pack_mtimes_file(char *mtimes_file,
 
 	expected_size = MTIMES_HEADER_SIZE;
 	expected_size = st_add(expected_size, st_mult(sizeof(uint32_t), num_objects));
-	expected_size = st_add(expected_size, 2 * (header.hash_id == 1 ? GIT_SHA1_RAWSZ : GIT_SHA256_RAWSZ));
+	switch (header.hash_id) {
+		case 1:
+			expected_size = st_add(expected_size, 2 * GIT_SHA1_RAWSZ);
+			break;
+		case 2:
+			expected_size = st_add(expected_size, 2 * GIT_SHA256_RAWSZ);
+			break;
+		case 3:
+			expected_size = st_add(expected_size, 2 * GIT_MD5_RAWSZ);
+			break;
+	}
 
 	if (mtimes_size != expected_size) {
 		ret = error(_("mtimes file %s is corrupt"), mtimes_file);
diff --git a/pkt-line.c b/pkt-line.c
index 3fc3e9ea70..4bc917c8d3 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -395,7 +395,7 @@ static const char *find_packfile_uri_path(const char *buffer)
 
 	len = strspn(buffer, "0123456789abcdefABCDEF");
 	/* size of SHA1 and SHA256 hash */
-	if (!(len == 40 || len == 64) || buffer[len] != ' ')
+	if (!(len == 40 || len == 64 || len == 32) || buffer[len] != ' ')
 		return NULL; /* required "<hash>SP" not seen */
 
 	path = strstr(buffer + len + 1, URI_MARK);
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index b124404663..7bb0a60f15 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -106,6 +106,9 @@ static int reftable_backend_read_ref(struct reftable_backend *be,
 		case REFTABLE_HASH_SHA256:
 			hash_id = GIT_HASH_SHA256;
 			break;
+		case REFTABLE_HASH_MD5:
+			hash_id = GIT_HASH_MD5;
+			break;
 		default:
 			BUG("unhandled hash ID %d", reftable_stack_hash_id(be->stack));
 		}
@@ -401,6 +404,9 @@ static struct ref_store *reftable_be_init(struct repository *repo,
 	case GIT_SHA256_FORMAT_ID:
 		refs->write_options.hash_id = REFTABLE_HASH_SHA256;
 		break;
+	case GIT_MD5_FORMAT_ID:
+		refs->write_options.hash_id = REFTABLE_HASH_MD5;
+		break;
 	default:
 		BUG("unknown hash algorithm %d", repo->hash_algo->format_id);
 	}
@@ -2788,6 +2794,9 @@ static int reftable_be_fsck(struct ref_store *ref_store, struct fsck_options *o,
 			case REFTABLE_HASH_SHA256:
 				hash_id = GIT_HASH_SHA256;
 				break;
+			case REFTABLE_HASH_MD5:
+				hash_id = GIT_HASH_MD5;
+				break;
 			default:
 				BUG("unhandled hash ID %d",
 				    reftable_stack_hash_id(backend->stack));
diff --git a/reftable/basics.c b/reftable/basics.c
index e969927b61..3b62c562cf 100644
--- a/reftable/basics.c
+++ b/reftable/basics.c
@@ -273,6 +273,8 @@ uint32_t hash_size(enum reftable_hash id)
 		return REFTABLE_HASH_SIZE_SHA1;
 	case REFTABLE_HASH_SHA256:
 		return REFTABLE_HASH_SIZE_SHA256;
+	case REFTABLE_HASH_MD5:
+		return REFTABLE_HASH_SIZE_MD5;
 	}
 	abort();
 }
diff --git a/reftable/basics.h b/reftable/basics.h
index e4b83b2b03..9f0e0b3fa5 100644
--- a/reftable/basics.h
+++ b/reftable/basics.h
@@ -287,5 +287,6 @@ uint32_t hash_size(enum reftable_hash id);
  */
 #define REFTABLE_FORMAT_ID_SHA1   ((uint32_t) 0x73686131)
 #define REFTABLE_FORMAT_ID_SHA256 ((uint32_t) 0x73323536)
+#define REFTABLE_FORMAT_ID_MD5    ((uint32_t) 0x6d643573)
 
 #endif
diff --git a/reftable/reftable-basics.h b/reftable/reftable-basics.h
index 6d73f19c85..8cc196f91e 100644
--- a/reftable/reftable-basics.h
+++ b/reftable/reftable-basics.h
@@ -27,9 +27,11 @@ struct reftable_buf {
 enum reftable_hash {
 	REFTABLE_HASH_SHA1   = 89,
 	REFTABLE_HASH_SHA256 = 247,
+	REFTABLE_HASH_MD5    = 104,
 };
 #define REFTABLE_HASH_SIZE_SHA1   20
 #define REFTABLE_HASH_SIZE_SHA256 32
+#define REFTABLE_HASH_SIZE_MD5    16
 #define REFTABLE_HASH_SIZE_MAX    REFTABLE_HASH_SIZE_SHA256
 
 /* Overrides the functions to use for memory management. */
diff --git a/reftable/table.c b/reftable/table.c
index 56362df0ed..5c463ade73 100644
--- a/reftable/table.c
+++ b/reftable/table.c
@@ -79,6 +79,9 @@ static int parse_footer(struct reftable_table *t, uint8_t *footer,
 		case REFTABLE_FORMAT_ID_SHA256:
 			t->hash_id = REFTABLE_HASH_SHA256;
 			break;
+		case REFTABLE_FORMAT_ID_MD5:
+			t->hash_id = REFTABLE_HASH_MD5;
+			break;
 		default:
 			err = REFTABLE_FORMAT_ERROR;
 			goto done;
diff --git a/reftable/writer.c b/reftable/writer.c
index 0133b64975..9499fd9a73 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -114,6 +114,9 @@ static int writer_write_header(struct reftable_writer *w, uint8_t *dest)
 		case REFTABLE_HASH_SHA256:
 			hash_id = REFTABLE_FORMAT_ID_SHA256;
 			break;
+		case REFTABLE_HASH_MD5:
+			hash_id = REFTABLE_FORMAT_ID_MD5;
+			break;
 		default:
 			return -1;
 		}

---
base-commit: 270e10ad6dda3379ea0da7efd11e4fbf2cd7a325
change-id: 20260401-pks-object-format-md5-5e34f91d5b06

