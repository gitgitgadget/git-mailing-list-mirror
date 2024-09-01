Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8183FC7
	for <git@vger.kernel.org>; Sun,  1 Sep 2024 16:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725206609; cv=none; b=UgvFL8cbpU4aLAflM2r+FE7lntNg6PqJ7/6ENhqLeT7LdA4AaluHv9kazcWM+jpAAegsr9hm5tACUkaoU29KqSFOKjB73VjGVivykU0W15OfX/PAC+Q828YoQL9R2fbfhFcb6g9jU+3FIL7+nU8qkLCwMasRssx4/TwWEO9LhCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725206609; c=relaxed/simple;
	bh=n6m/ooHFJiW946LrmVaeWObLfvksuS5JA72QxCSkbTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YDPWDlti3hDe/E8jasAj6L06VwR3r7Av9HN3Rps8qntP1chzbabVp/2TzjWteeqtWQ23xXzSMrnaaTU5oofL8Cqa7rT76zfh9N2tgl92rfg53G7tD77k2w4vy4WKz7DWn0FQIxbjjXeoKRcw9EngCkrT5A5zKDtcJnsYVdIk1hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=xxjqgatZ; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="xxjqgatZ"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e1651f48c31so3613617276.0
        for <git@vger.kernel.org>; Sun, 01 Sep 2024 09:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1725206607; x=1725811407; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h8JEotwuqYFfilVvomhWPuE3s5qThO28UMnzR5Rkdes=;
        b=xxjqgatZ/ozbQHaNNnKohldIZai9lPx6gwoRVYZPs+KqMk/3SPuqnTLf28on17tLpE
         T/7WFJjjKt3Zdn4rqI7yhpi8fvsiJYowp/hMnwna/FX+9cRXSx+IQ5oORWeT1YG87YuX
         rqm0qvfUgtNpuDHb8ANtsBQNrK6+1iNJrlASDArALdkmEUoQHPgjSCj1xTPV8hdLx99I
         13Yn5TYzfx8N0yiOBJev82DaAJLusvy4salbDzFShIXbzq43My8LeoeA3xrVDegmM0W4
         3eVzSsypYG9DBtZKWAAHEl6HHysKLYlN6rmOH3oX40ayrNt1oIsAUmwmaPdL52e3VMAS
         UpqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725206607; x=1725811407;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h8JEotwuqYFfilVvomhWPuE3s5qThO28UMnzR5Rkdes=;
        b=fmeZjiEf2GJpif6NCEZrWqXYUNnCCjvzu7j/YOimO0RvPBGHVnXGjM2+1EigJQIxQB
         wUKPtzq5/zzZrds5ScVV+US6478arMVsagk2jf650cXiFOAkoPKw2Yr4ywHZ52Qo5zCQ
         rsB/+X1xtkjDgdkhedX34c7x+RzOLG95wUetPN4ms4xPjj9sNTeuNr6AnoribuzICmX2
         gUn4p0iPT22/4PnGw3V/bgx0ciYbb1b0mmqYwCeBKLN6TBiyZW8ItewFjl10rYl6XZ82
         wVqm7OKqST+IftbR+uhPHWLLvib9B1rZ3LWuZBLyt7WtA3uOJ4VVQ8HxCYjyrDfTWcq8
         6bwA==
X-Gm-Message-State: AOJu0Yz1s+VtjfWW4ODhFVw+pHmMFIrDOj+gBef2BoPWnIi8Bo2ZDjVR
	0w5IuiQbxzzYdfL8Sle7cX/YLrpoiRUkrC/RWyrZMVR5y5ds4ILUAnc/K1yKpss7hEGg9shevYX
	r0dc=
X-Google-Smtp-Source: AGHT+IHSxA/n/Zo7rm2L9ferXOgxn1XJFEuETC/CsOPSObT25WtNrKwu0x0ecQf2tYwVbj/3aMV9Ag==
X-Received: by 2002:a05:690c:418f:b0:6d3:f400:81e1 with SMTP id 00721157ae682-6d40e17f6a2mr62712687b3.14.1725206606760;
        Sun, 01 Sep 2024 09:03:26 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6d53b206498sm6042007b3.8.2024.09.01.09.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 09:03:26 -0700 (PDT)
Date: Sun, 1 Sep 2024 12:03:24 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/4] hash.h: scaffolding for _fast hashing variants
Message-ID: <6ac6f934c32bdc600cdb8d2a08d4aa390c1f2994.1725206584.git.me@ttaylorr.com>
References: <cover.1725206584.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1725206584.git.me@ttaylorr.com>

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
index 72ffbc862e5..f255e5c1e8a 100644
--- a/hash.h
+++ b/hash.h
@@ -44,14 +44,32 @@
 #define platform_SHA1_Final    	SHA1_Final
 #endif
 
+#ifndef platform_SHA_CTX_fast
+#define platform_SHA_CTX_fast	  platform_SHA_CTX
+#define platform_SHA1_Init_fast	  platform_SHA1_Init
+#define platform_SHA1_Update_fast platform_SHA1_Update
+#define platform_SHA1_Final_fast  platform_SHA1_Final
+#ifdef platform_SHA1_Clone
+#define platform_SHA1_Clone_fast  platform_SHA1_Clone
+#endif
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
+#define git_SHA1_Clone_fast	platform_SHA1_Clone_fast
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
 
+	/* The fast hash initialization function. */
+	git_hash_init_fn fast_init_fn;
+
+	/* The fast hash context cloning function. */
+	git_hash_clone_fn fast_clone_fn;
+
+	/* The fast hash update function. */
+	git_hash_update_fn fast_update_fn;
+
+	/* The fast hash finalization function. */
+	git_hash_final_fn fast_final_fn;
+
+	/* The fast hash finalization function for object IDs. */
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
2.46.0.425.ge8f5cbd280c

