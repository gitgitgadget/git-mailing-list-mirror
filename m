Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C483BB40
	for <git@vger.kernel.org>; Sat,  6 Dec 2025 20:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765053070; cv=none; b=roCm4CEOSa49Y0bN3Ya7k9QDf95KvMJ30n7W+7Ilc7sAsKNsd7RF4y7IRCmrtRjQN/GVV1oCHtgQrgIRYJlI4f+TLtjqFK2+XxmBp6d0TyOia2Sp0KyPrYGlCVcfJTiQAmGRKQBUbXTJVky0wt1cgeWgP89P2L9ZMXbn5Y3OSGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765053070; c=relaxed/simple;
	bh=vuC6ITXnGUTJJDBKJlWKyks4rEA/8u1mTMJxKrELPz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pYjDbOu2nn7+YGvrBCdcfiX5j5g0Xp+20pQ0x8LD8Ac1objyucEHFYb8huZCTDCM+ZI5gXCYkfpEBGyu2S8Uwup3cPDdoruCBa7CwnvwmQ7paCQ7lJqM2KU2G81gxInSn74rBuT34QUp2UkIlAo0FgJCHFWoU/nNZsmqMlykGwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=WQgZLOdy; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="WQgZLOdy"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-786d1658793so27414947b3.1
        for <git@vger.kernel.org>; Sat, 06 Dec 2025 12:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1765053066; x=1765657866; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dt3H6zLktH3IZNZehfyPEunp5ASqxk/mgDWQ1ykeJK4=;
        b=WQgZLOdyrw1Ys8QWDzXcGMOtSQcBl6aow+fk/khPkjQI8V8GRY5l3KI3emM9qe5gOz
         VnGuJa9l7HTOn/u/vxORGVQXqVJwiaDeVBgC/HMpW8wyNx/inavlym0g+q8lEZZ1P/Ct
         m6V7O72lmu0orwII7n48ZRYGWPkxH35Gzs4ljzIzWbGATKOBqBvzNOSSTAuzHoan5aEb
         iWdeFiV3a1YoJe7tiYDBbCRnOAL6sOegqc0BbY6g89KHJABlAbjenxo1X6tdrIvq7HR4
         HQZjECNQ9Fy84YMdyfNzn1g6pRY3D0pSEbdCRicZ1td2dBE5Qn92J1FplrqTkpOlXk3b
         9J5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765053066; x=1765657866;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dt3H6zLktH3IZNZehfyPEunp5ASqxk/mgDWQ1ykeJK4=;
        b=TX0p/jqLpJkGdhKY/qGYBs0Ath9NTV/yuVM7i00GUFE66duvaxRFuOcu22JFnrPrjO
         gEJ3VK4w9PaGQN+zRf1wQMDcS1VZ0vylkQSTecxnwGDwMRqTxkKXQqKGYc0UF790qcdC
         p8mSsLUSxTYcTRdrwCRF3Lhduvl4CoitBINm8Or7W7ZmqpYggOXEdAMTmP9pvxPP70C8
         SsKsX4XZVvpiQnB2YxlB4383FZ74TScutE/DGkj7pBwCYkTefUl6LEbe4GDUHDvMoRJ6
         c2krEfS5XjqOHwR1lmBb2Db5eWAoWtK8gg66xOyzcNuqGPz6FTX9I0TPSjBPGQH7v7Wu
         CcUQ==
X-Gm-Message-State: AOJu0YxcbEAtwe6wbG74XVOvD4Ofgvf9NCPqT8ReFpVFQB6cEDC2kT3r
	EcJMoVgEMcBx9GQYGVLKFUeKYrjuDuol24jp/MaXhd7VGwBXoN6V5eyDGuSpofhxYixDxxCvMo+
	yxKYDgR8=
X-Gm-Gg: ASbGncvpVa+IGNnljdOzwZJgnk8q32r3ukQNv+vbzW7edMYF7o/I2ni1h63RYjvDT3p
	g5hNO6IxDlxuo0d/ciqz4e/U+feKLmBWeiEBxHPQ9IAZxZYM0J6xUkk3r1GnOTfck0mW3bLJ8V8
	/5N4+NtuV9AiRnik8P/5KaGKMd0gZxvbPd6lQUpnoNseo5Txi/N/Qywa6kpDQNMjk8aWiLzneJX
	H0KlqkX5aCKyR11J2wHANM9Hw4LaucPAeIcdNhvFFthn1/XnP8URIT78nl8Dt8a52RoY3kvMKOJ
	WQ7KlHU4aNgXyi4/b7QwVuvDqR2whjFC4CucuWg+x0D+f2NHAa0jgdi7lW4DpIup8bARvDIku1V
	ypoIM49XPQf5B5NBP1DmSimB8Pfe2tS1nHMIOvAK3A5qQsZssWBJrQuObATvF8MidcZnKXQaUjm
	fmzk27s53Du+jfMXNkE7+7PVH+4Y2RHLJfcFnmZ+NAsqW+/P592Mz894jY/R2Q06It4bXEMJPqB
	cHH7/VfKr/ofGPXuAkJODEQ4BNg
X-Google-Smtp-Source: AGHT+IG+GyNfSqKnAfa42SNnIiokbIZ/YfKB1FXW8U6MRjrU/5sR2J2NOeByYK3YevgIBhP9PweYWw==
X-Received: by 2002:a05:690c:46c7:b0:786:4459:cb84 with SMTP id 00721157ae682-78c33b7641emr54669697b3.29.1765053065961;
        Sat, 06 Dec 2025 12:31:05 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-78c1b7902e7sm30647897b3.46.2025.12.06.12.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Dec 2025 12:31:05 -0800 (PST)
Date: Sat, 6 Dec 2025 15:31:04 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 02/17] midx: split `get_midx_checksum()` by adding
 `get_midx_hash()`
Message-ID: <d583a169f08eea9d750622c6e3cf79774a2a68e7.1765053054.git.me@ttaylorr.com>
References: <cover.1765053054.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1765053054.git.me@ttaylorr.com>

When trying to print out, say, the hexadecimal representation of a
MIDX's hash, our code will do something like:

    hash_to_hex_algop(get_midx_checksum(m),
                      m->source->odb->repo->hash_algo);

, which is both cumbersome and repetitive. In fact, all but a handful of
callers to `get_midx_checksum()` do exactly the above. Reduce the
repetitive nature of calling `get_midx_checksum()` by having it return a
pointer into a static buffer containing the above result.

For the handful of callers that do need to compare the raw bytes and
don't want to deal with an encoded copy (e.g., because they are passing
it to hasheq() or similar), introduce `get_midx_hash()` which returns
the raw bytes.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx-write.c              | 8 +++-----
 midx.c                    | 8 +++++++-
 midx.h                    | 3 ++-
 pack-bitmap.c             | 9 ++++-----
 pack-revindex.c           | 4 ++--
 t/helper/test-read-midx.c | 4 ++--
 6 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index 23e61cb0001..73d24fabbc6 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -955,7 +955,7 @@ static int link_midx_to_chain(struct multi_pack_index *m)
 	}
 
 	for (i = 0; i < ARRAY_SIZE(midx_exts); i++) {
-		const unsigned char *hash = get_midx_checksum(m);
+		const unsigned char *hash = get_midx_hash(m);
 
 		get_midx_filename_ext(m->source, &from,
 				      hash, midx_exts[i].non_split);
@@ -1086,8 +1086,7 @@ static int write_midx_internal(struct odb_source *source,
 		while (m) {
 			if (flags & MIDX_WRITE_BITMAP && load_midx_revindex(m)) {
 				error(_("could not load reverse index for MIDX %s"),
-				      hash_to_hex_algop(get_midx_checksum(m),
-							m->source->odb->repo->hash_algo));
+				      get_midx_checksum(m));
 				goto cleanup;
 			}
 			ctx.num_multi_pack_indexes_before++;
@@ -1445,8 +1444,7 @@ static int write_midx_internal(struct odb_source *source,
 		for (uint32_t i = 0; i < ctx.num_multi_pack_indexes_before; i++) {
 			uint32_t j = ctx.num_multi_pack_indexes_before - i - 1;
 
-			keep_hashes[j] = xstrdup(hash_to_hex_algop(get_midx_checksum(m),
-								   r->hash_algo));
+			keep_hashes[j] = xstrdup(get_midx_checksum(m));
 			m = m->base_midx;
 		}
 
diff --git a/midx.c b/midx.c
index 6c01f0fa522..f9b11de9ca9 100644
--- a/midx.c
+++ b/midx.c
@@ -24,7 +24,13 @@ void clear_incremental_midx_files_ext(struct odb_source *source, const char *ext
 int cmp_idx_or_pack_name(const char *idx_or_pack_name,
 			 const char *idx_name);
 
-const unsigned char *get_midx_checksum(const struct multi_pack_index *m)
+const char *get_midx_checksum(const struct multi_pack_index *m)
+{
+	return hash_to_hex_algop(get_midx_hash(m),
+				 m->source->odb->repo->hash_algo);
+}
+
+const unsigned char *get_midx_hash(const struct multi_pack_index *m)
 {
 	return m->data + m->data_len - m->source->odb->repo->hash_algo->rawsz;
 }
diff --git a/midx.h b/midx.h
index 7c7e0b59121..e188ffeb578 100644
--- a/midx.h
+++ b/midx.h
@@ -85,7 +85,8 @@ struct multi_pack_index {
 #define MIDX_EXT_BITMAP "bitmap"
 #define MIDX_EXT_MIDX "midx"
 
-const unsigned char *get_midx_checksum(const struct multi_pack_index *m);
+const char *get_midx_checksum(const struct multi_pack_index *m) /* static buffer */;
+const unsigned char *get_midx_hash(const struct multi_pack_index *m);
 void get_midx_filename(struct odb_source *source, struct strbuf *out);
 void get_midx_filename_ext(struct odb_source *source, struct strbuf *out,
 			   const unsigned char *hash, const char *ext);
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 8ca79725b1d..f466ed2ddcb 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -441,11 +441,11 @@ char *midx_bitmap_filename(struct multi_pack_index *midx)
 	struct strbuf buf = STRBUF_INIT;
 	if (midx->has_chain)
 		get_split_midx_filename_ext(midx->source, &buf,
-					    get_midx_checksum(midx),
+					    get_midx_hash(midx),
 					    MIDX_EXT_BITMAP);
 	else
 		get_midx_filename_ext(midx->source, &buf,
-				      get_midx_checksum(midx),
+				      get_midx_hash(midx),
 				      MIDX_EXT_BITMAP);
 
 	return strbuf_detach(&buf, NULL);
@@ -502,7 +502,7 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
 	if (load_bitmap_header(bitmap_git) < 0)
 		goto cleanup;
 
-	if (!hasheq(get_midx_checksum(bitmap_git->midx), bitmap_git->checksum,
+	if (!hasheq(get_midx_hash(bitmap_git->midx), bitmap_git->checksum,
 		    bitmap_repo(bitmap_git)->hash_algo)) {
 		error(_("checksum doesn't match in MIDX and bitmap"));
 		goto cleanup;
@@ -2820,8 +2820,7 @@ void test_bitmap_walk(struct rev_info *revs)
 
 		if (bitmap_is_midx(found))
 			fprintf_ln(stderr, "Located via MIDX '%s'.",
-				   hash_to_hex_algop(get_midx_checksum(found->midx),
-						     revs->repo->hash_algo));
+				   get_midx_checksum(found->midx));
 		else
 			fprintf_ln(stderr, "Located via pack '%s'.",
 				   hash_to_hex_algop(found->pack->hash,
diff --git a/pack-revindex.c b/pack-revindex.c
index d0791cc4938..016195ceb93 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -390,11 +390,11 @@ int load_midx_revindex(struct multi_pack_index *m)
 
 	if (m->has_chain)
 		get_split_midx_filename_ext(m->source, &revindex_name,
-					    get_midx_checksum(m),
+					    get_midx_hash(m),
 					    MIDX_EXT_REV);
 	else
 		get_midx_filename_ext(m->source, &revindex_name,
-				      get_midx_checksum(m),
+				      get_midx_hash(m),
 				      MIDX_EXT_REV);
 
 	ret = load_revindex_from_disk(m->source->odb->repo->hash_algo,
diff --git a/t/helper/test-read-midx.c b/t/helper/test-read-midx.c
index 6de5d1665af..dee603b3cd0 100644
--- a/t/helper/test-read-midx.c
+++ b/t/helper/test-read-midx.c
@@ -34,7 +34,7 @@ static int read_midx_file(const char *object_dir, const char *checksum,
 		return 1;
 
 	if (checksum) {
-		while (m && strcmp(hash_to_hex(get_midx_checksum(m)), checksum))
+		while (m && strcmp(get_midx_checksum(m), checksum))
 			m = m->base_midx;
 		if (!m)
 			return 1;
@@ -94,7 +94,7 @@ static int read_midx_checksum(const char *object_dir)
 	m = setup_midx(object_dir);
 	if (!m)
 		return 1;
-	printf("%s\n", hash_to_hex(get_midx_checksum(m)));
+	printf("%s\n", get_midx_checksum(m));
 
 	close_midx(m);
 	return 0;
-- 
2.52.0.171.gd6a4e6b6955

