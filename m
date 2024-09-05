Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88903F507
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 15:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725549137; cv=none; b=AmRDVv7812FJjmYKO2xRW4254US+PXY6zd2OByRVLmhaEBpXtHV4ypzD2kvpR4oOx01vGWGbgurli6KZQg3kdXv++8yyIJb/hyhpSDrXZymNVklZbYTDwVR9o7ddtF8DmuThfWDknBkngCW1oscRon8EsrVGXQNQNa3Y9mbnTA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725549137; c=relaxed/simple;
	bh=Q6nzMN5LrLvPA9g8I5i12FxfpkL8Dx0PFLaqc+yN/mU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NJKWWsx+bZtJuDH3P6AFV/lxOzKsTZCM5IEX+MnQKoIOKGbSEATUB3APq5IKtor7WdbAzE2BXaepHAU5xVs/dsrMnbc/Y4+fj80Gjt44hnQTVU19KN8y9mHhk1HE91n8AHmOypJOF0frz3UjeB9SwM5Nbm7nHd3jp23qeKF5vp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=UwnAxzCh; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="UwnAxzCh"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6d3f4218081so9416097b3.1
        for <git@vger.kernel.org>; Thu, 05 Sep 2024 08:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1725549134; x=1726153934; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YGLpK2lL9DeOAPxAqXCUA/Mgj4cQ1apZWdMXIW9lqJI=;
        b=UwnAxzChV256UlBH1dtFEq8JOpronQGlcsp4wiZPQ0y+WhTsLaAE66/dZuZV59AWo5
         84NSJ6aU60L0oUFLChrcXa5wDRmMuUldhWUCDRqcmMHvwFuuUGsXIn7bCVG/3rX4EtRk
         p+pb7sgxxjifvXleKADgfQ7Mf8SGEdkLghATDawJQ+ACcjJ7gNRRvuzMOqhMuaFX0JiU
         vuRfR2/61jzkNbzgUgCQqCJYzr/D8P9EtwocKMFVXmpELIKuvhbZJraWdUbRNogehHGH
         FAE91muwvfJlCNUUrwoCX9bLx550WQYTCBUusttKeGb3r7nYz0HQn+Mx4O/an7zAOVM+
         KalQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725549134; x=1726153934;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YGLpK2lL9DeOAPxAqXCUA/Mgj4cQ1apZWdMXIW9lqJI=;
        b=rjbmam8ewtoSr69ST2jHPYEGhhpeydmFoROSb8Is9Srm2FmwTrLxl12pXm2J4RVRWN
         DhX6TR00JqbrjM3eq8EzyOTSvY+BSKoufHCOo0+oYsmZwJIBhe52dfJO6coiqODcRRfw
         i6ocUoPPVpqIHpCeO8it8f1vUlKb1Vq0YmlZtldaphv7PwZw4XyYOGpqkinWyC8vBTSt
         Wzg/OpPVgpusTlKvqA8BacvUPnbIw+jndQyKXTmegkWycRyABFE2IxqFyQll4DK6OJXb
         b/bea4wcHJc8BVUqArMxZbCE06f6wUozeHQhl8CafyA3pNMCogaa2FuYBFaidxce7Pa1
         HX8g==
X-Gm-Message-State: AOJu0Yy48GsLcXqORzLCZEVRjuPh8VLCFBia30c4bVJWV/uM3SYS8mGa
	ZtfkfgiGZUHU9M9M0USNFmCCVCCI8mLtgKAB86sMiuYue0kVa5gHKFqAZ4X7QaKInPt0CDzJ0RE
	pMw0=
X-Google-Smtp-Source: AGHT+IFra3/rK7RWmGTrnsU94LvirclMPUOuCqwcBQO0ee+wqr7BS+cs3GV/FpkfFuPf5dH6xSj26A==
X-Received: by 2002:a05:690c:f90:b0:6d6:27af:ef73 with SMTP id 00721157ae682-6db23a39ae7mr85407567b3.37.1725549134062;
        Thu, 05 Sep 2024 08:12:14 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6d78d1e6901sm16700867b3.7.2024.09.05.08.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 08:12:13 -0700 (PDT)
Date: Thu, 5 Sep 2024 11:12:12 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/4] hash.h: scaffolding for _fast hashing variants
Message-ID: <3b5f21e4a620b0afd706ec3a3fbb71918f96198f.1725549065.git.me@ttaylorr.com>
References: <cover.1725206584.git.me@ttaylorr.com>
 <cover.1725549065.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1725549065.git.me@ttaylorr.com>

Git's default SHA-1 implementation is collision-detecting, which hardens
us against known SHA-1 attacks against Git objects. This makes Git
object writes safer at the expense of some speed when hashing through
the collision-detecting implementation, which is slower than
non-collision detecting alternatives.

Prepare for loading a separate "fast" SHA-1 implementation that can be
used for non-cryptographic purposes, like computing the checksum of
files that use the hashwrite() API.

This commit does not actually introduce any new compile-time knobs to
control which implementation is used as the fast SHA-1 variant, but does
add scaffolding so that the "git_hash_algo" structure has five new
function pointers which are "fast" variants of the five existing
hashing-related function pointers:

  - git_hash_init_fn fast_init_fn
  - git_hash_clone_fn fast_clone_fn
  - git_hash_update_fn fast_update_fn
  - git_hash_final_fn fast_final_fn
  - git_hash_final_oid_fn fast_final_oid_fn

The following commit will introduce compile-time knobs to specify which
SHA-1 implementation is used for non-cryptographic uses.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 hash.h        | 42 ++++++++++++++++++++++++++++++++++++++++++
 object-file.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+)

diff --git a/hash.h b/hash.h
index 72ffbc862e5..5e5b8205b58 100644
--- a/hash.h
+++ b/hash.h
@@ -44,14 +44,32 @@
 #define platform_SHA1_Final    	SHA1_Final
 #endif
 
+#ifndef platform_SHA_CTX_fast
+#  define platform_SHA_CTX_fast     platform_SHA_CTX
+#  define platform_SHA1_Init_fast   platform_SHA1_Init
+#  define platform_SHA1_Update_fast platform_SHA1_Update
+#  define platform_SHA1_Final_fast  platform_SHA1_Final
+#  ifdef platform_SHA1_Clone
+#    define platform_SHA1_Clone_fast platform_SHA1_Clone
+#  endif
+#endif
+
 #define git_SHA_CTX		platform_SHA_CTX
 #define git_SHA1_Init		platform_SHA1_Init
 #define git_SHA1_Update		platform_SHA1_Update
 #define git_SHA1_Final		platform_SHA1_Final
 
+#define git_SHA_CTX_fast	platform_SHA_CTX_fast
+#define git_SHA1_Init_fast	platform_SHA1_Init_fast
+#define git_SHA1_Update_fast	platform_SHA1_Update_fast
+#define git_SHA1_Final_fast	platform_SHA1_Final_fast
+
 #ifdef platform_SHA1_Clone
 #define git_SHA1_Clone	platform_SHA1_Clone
 #endif
+#ifdef platform_SHA1_Clone_fast
+#  define git_SHA1_Clone_fast platform_SHA1_Clone_fast
+#endif
 
 #ifndef platform_SHA256_CTX
 #define platform_SHA256_CTX	SHA256_CTX
@@ -81,6 +99,13 @@ static inline void git_SHA1_Clone(git_SHA_CTX *dst, const git_SHA_CTX *src)
 	memcpy(dst, src, sizeof(*dst));
 }
 #endif
+#ifndef SHA1_NEEDS_CLONE_HELPER_FAST
+static inline void git_SHA1_Clone_fast(git_SHA_CTX_fast *dst,
+				       const git_SHA_CTX_fast *src)
+{
+	memcpy(dst, src, sizeof(*dst));
+}
+#endif
 
 #ifndef SHA256_NEEDS_CLONE_HELPER
 static inline void git_SHA256_Clone(git_SHA256_CTX *dst, const git_SHA256_CTX *src)
@@ -178,6 +203,8 @@ enum get_oid_result {
 /* A suitably aligned type for stack allocations of hash contexts. */
 union git_hash_ctx {
 	git_SHA_CTX sha1;
+	git_SHA_CTX_fast sha1_fast;
+
 	git_SHA256_CTX sha256;
 };
 typedef union git_hash_ctx git_hash_ctx;
@@ -222,6 +249,21 @@ struct git_hash_algo {
 	/* The hash finalization function for object IDs. */
 	git_hash_final_oid_fn final_oid_fn;
 
+	/* The fast / non-cryptographic hash initialization function. */
+	git_hash_init_fn fast_init_fn;
+
+	/* The fast / non-cryptographic hash context cloning function. */
+	git_hash_clone_fn fast_clone_fn;
+
+	/* The fast / non-cryptographic hash update function. */
+	git_hash_update_fn fast_update_fn;
+
+	/* The fast / non-cryptographic hash finalization function. */
+	git_hash_final_fn fast_final_fn;
+
+	/* The fast / non-cryptographic hash finalization function. */
+	git_hash_final_oid_fn fast_final_oid_fn;
+
 	/* The OID of the empty tree. */
 	const struct object_id *empty_tree;
 
diff --git a/object-file.c b/object-file.c
index c5994202ba0..9691292ef5a 100644
--- a/object-file.c
+++ b/object-file.c
@@ -115,6 +115,33 @@ static void git_hash_sha1_final_oid(struct object_id *oid, git_hash_ctx *ctx)
 	oid->algo = GIT_HASH_SHA1;
 }
 
+static void git_hash_sha1_init_fast(git_hash_ctx *ctx)
+{
+	git_SHA1_Init_fast(&ctx->sha1_fast);
+}
+
+static void git_hash_sha1_clone_fast(git_hash_ctx *dst, const git_hash_ctx *src)
+{
+	git_SHA1_Clone_fast(&dst->sha1_fast, &src->sha1_fast);
+}
+
+static void git_hash_sha1_update_fast(git_hash_ctx *ctx, const void *data,
+				      size_t len)
+{
+	git_SHA1_Update_fast(&ctx->sha1_fast, data, len);
+}
+
+static void git_hash_sha1_final_fast(unsigned char *hash, git_hash_ctx *ctx)
+{
+	git_SHA1_Final_fast(hash, &ctx->sha1_fast);
+}
+
+static void git_hash_sha1_final_oid_fast(struct object_id *oid, git_hash_ctx *ctx)
+{
+	git_SHA1_Final_fast(oid->hash, &ctx->sha1_fast);
+	memset(oid->hash + GIT_SHA1_RAWSZ, 0, GIT_MAX_RAWSZ - GIT_SHA1_RAWSZ);
+	oid->algo = GIT_HASH_SHA1;
+}
 
 static void git_hash_sha256_init(git_hash_ctx *ctx)
 {
@@ -189,6 +216,11 @@ const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
 		.update_fn = git_hash_unknown_update,
 		.final_fn = git_hash_unknown_final,
 		.final_oid_fn = git_hash_unknown_final_oid,
+		.fast_init_fn = git_hash_unknown_init,
+		.fast_clone_fn = git_hash_unknown_clone,
+		.fast_update_fn = git_hash_unknown_update,
+		.fast_final_fn = git_hash_unknown_final,
+		.fast_final_oid_fn = git_hash_unknown_final_oid,
 		.empty_tree = NULL,
 		.empty_blob = NULL,
 		.null_oid = NULL,
@@ -204,6 +236,11 @@ const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
 		.update_fn = git_hash_sha1_update,
 		.final_fn = git_hash_sha1_final,
 		.final_oid_fn = git_hash_sha1_final_oid,
+		.fast_init_fn = git_hash_sha1_init_fast,
+		.fast_clone_fn = git_hash_sha1_clone_fast,
+		.fast_update_fn = git_hash_sha1_update_fast,
+		.fast_final_fn = git_hash_sha1_final_fast,
+		.fast_final_oid_fn = git_hash_sha1_final_oid_fast,
 		.empty_tree = &empty_tree_oid,
 		.empty_blob = &empty_blob_oid,
 		.null_oid = &null_oid_sha1,
@@ -219,6 +256,11 @@ const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
 		.update_fn = git_hash_sha256_update,
 		.final_fn = git_hash_sha256_final,
 		.final_oid_fn = git_hash_sha256_final_oid,
+		.fast_init_fn = git_hash_sha256_init,
+		.fast_clone_fn = git_hash_sha256_clone,
+		.fast_update_fn = git_hash_sha256_update,
+		.fast_final_fn = git_hash_sha256_final,
+		.fast_final_oid_fn = git_hash_sha256_final_oid,
 		.empty_tree = &empty_tree_oid_sha256,
 		.empty_blob = &empty_blob_oid_sha256,
 		.null_oid = &null_oid_sha256,
-- 
2.46.0.426.g82754d92509.dirty

