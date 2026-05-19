Received: from mail-yx1-f67.google.com (mail-yx1-f67.google.com [74.125.224.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC1D3AFCFA
	for <git@vger.kernel.org>; Tue, 19 May 2026 15:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779206274; cv=none; b=KogkVOwYUpZkglVgQS9LrCNwk28avc/KDsSW/BLszbTjTkRzvbOGBxD98MfRudsdv5RJXCzbOqg7niO1WkUKmWpe1yTzrrq9YDolmFmD4MqPNTgWuLtIphZycKiesm1uJ1JyghTIgji6M5PHakOWVlxd1QeZRUYzkWLch2OGrqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779206274; c=relaxed/simple;
	bh=nrSg9I614Xgu8PKDpKl+UDb0NLN4thT1XJR4Uw0EMm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gNk85fhUGEptRhk4H9vZUhyjaDZjvn13Jt0pk2jDuIFUrpf/jsFBlv7A7SXD+LZocN3Nl5SjYxs85UbI08yPh5zI/n29raCbXUlICRFBRoAZRNZgzZnqgRWPtm5qvXDpukCDRiHNy/bthVDUUKLNNy1pUzigIEv4VlYEm8TCgoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=PVcsXIrP; arc=none smtp.client-ip=74.125.224.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="PVcsXIrP"
Received: by mail-yx1-f67.google.com with SMTP id 956f58d0204a3-65890a6ca20so4179677d50.0
        for <git@vger.kernel.org>; Tue, 19 May 2026 08:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1779206270; x=1779811070; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zg3qqfEt9KRbMCzjSyNcf38n0fAxUv8RXAkRhn/PIdA=;
        b=PVcsXIrPyOHhfdO8YJrSuTJnwK51R6OG3y02ZNwP0RITRYqIHXI+1XutpYYAhWHfDH
         gfZ7lEcd115yRXJ2AHmhYeQY9tz8a/fvZx3qMZhJF4iuLmZhUcIU2kASIYKZTymy+791
         0QFtcOR33AYXh5bP59YFoWpn/HTcJ0J4Yul2VptrP7tOQdRGtdm6klzGFYyn3YD5skzn
         cqVaW8o4RhDAyQAbM/K6LZmg5XyKYRmr/zSKOSuntX+Plu+3KJuoxScEhyH9Q4unPcfv
         /aClBixfSo7K8vidEIYH6p6SMmvZ6IG9SdkicPUu1cwFp7H5U3SLvGHLXf8V79PIOkky
         iCvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779206270; x=1779811070;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zg3qqfEt9KRbMCzjSyNcf38n0fAxUv8RXAkRhn/PIdA=;
        b=lam+Iqt3/sP6BUDPZi/UdU9L6PPZ9cqWl0fGUFri+S2f/xlNZq51NgPPZUR+wEctka
         UKnzBphqAhnvuJMM2BkTsTlGmy12+kyw+ZR5/J2ptOLOezAyA6SYly0LTrsWWAis2WVs
         AXHU2vxCEuOh6Y4Iz5RPRSmlwmpDW8oSuZx7JftEiPR2DtOUwih7QWnXNYq+AzEE/OZ2
         ykSBKy7uEqGFTksdt5e8A8mUCgH6cmsnD5D5LPXT1aOeU/HHRwHxdFSkTizyW+oqCPOg
         URl0Un3cmUXgQ8BAYHsvzNX31QLRKk2w9Kt9YB30XC/cfOPy3tAqdrXlqdS4A00SyFxY
         pVIg==
X-Gm-Message-State: AOJu0YydhkUckTJSBMIc3pzHs0Fd2f4uL9ZbyBR9GMhBzQgpMFv6TPHU
	2o0fcaNzqZ6nUrKaHkTf281HnXnSoX9GRxcWE/mJeGZGsFaG5/fxPh5FPle8D8ak/6CKgcNnbfo
	tEUICXcoD9+F+
X-Gm-Gg: Acq92OH5h52jS6ky9hMyVrcFDpwBPBut1L8XRf92VCI50ycVCeoUIeQvX6twMNDwJw7
	wXip6BZIZo+DRoAKHsWBuQOtlQb2AjMBJNhttn4ZTXTXK02XmjbuRVuwMUfbhtxmP9Okd82OqOv
	FsaWNDMbGdIYRTsTNngpdkDsAWRsZOjcpKym4TwH7HDmd3VTb61DrE/twG2ZwdZTaiEy9LZyKKT
	NL7XZerBZQXNy7o5gRLU5auwCj2joLqM5c6YXXEKgk0WRUcDRP9qsdfNy76AzuT3OgugQwctuq7
	V1rT2NJ5Xu0VwyNv4t6//FoAwCkT8wZMKVRnj4lURhG6qeQtWlQVId31ksHYe9C6O1mWU2Q4Id2
	lxupoohELcQi4hXT3oV7YZFb8+8maBdNdvDSiHoc6O1LG/utIiLH6i7z5rz2Zob7fv66DHeHA59
	X9/n4rQ5ZRYng0CBE1p2IGOUtOcfkQxaXf9EsfAm5z+oibsUB2UTpAqV5j0nKe6VsFwy8dbNX7x
	FxQOLmaEAUHVceh8LbvBkBQ40yP89UIxJHB7uOJQAd1X6wrJOISibxlqtw1q13cCcyxWS+5Rj84
	0yNP8hdhWsLENQ9ZCHL7UT5V2qg=
X-Received: by 2002:a05:690e:1183:b0:65c:febd:c0e4 with SMTP id 956f58d0204a3-65e2281b893mr18991840d50.45.1779206269968;
        Tue, 19 May 2026 08:57:49 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65e0dbd101asm7959255d50.19.2026.05.19.08.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 08:57:49 -0700 (PDT)
Date: Tue, 19 May 2026 11:57:48 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 04/16] midx: use `strvec` for `keep_hashes`
Message-ID: <13b7c808860e18d7e70aea00d58bf8faaf0d3a36.1779206240.git.me@ttaylorr.com>
References: <cover.1774820449.git.me@ttaylorr.com>
 <cover.1779206239.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1779206239.git.me@ttaylorr.com>

The `keep_hashes` array in `write_midx_internal()` accumulates the
checksums of MIDX files that should be retained when pruning stale
entries from the MIDX chain. For similar reasons as in a previous
commit, rewrite this using a strvec, requiring us to pass one fewer
parameter.

Unlike the aforementioned previous commit, use a `strvec` instead of a
`string_list`, which provides a more ergonomic interface to adjust the
values at a particular index. The ordering is important here, as this
value is used to determine the contents of the resulting
`multi-pack-index-chain` file when writing with "--incremental".

Since the previous commit already builds the array in forward order, the
conversion is straightforward: replace indexed assignments with
`strvec_push()`, drop the pre-counting and `CALLOC_ARRAY()`, and
simplify cleanup via `strvec_clear()`.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx-write.c | 84 ++++++++++++++++++----------------------------------
 midx.c       | 20 ++++++-------
 2 files changed, 38 insertions(+), 66 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index 55c778a97cb..5d9409a9741 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -29,8 +29,7 @@ extern void clear_midx_files_ext(struct odb_source *source, const char *ext,
 				 const char *keep_hash);
 extern void clear_incremental_midx_files_ext(struct odb_source *source,
 					     const char *ext,
-					     const char **keep_hashes,
-					     uint32_t hashes_nr);
+					     const struct strvec *keep_hashes);
 extern int cmp_idx_or_pack_name(const char *idx_or_pack_name,
 				const char *idx_name);
 
@@ -1109,8 +1108,7 @@ static int link_midx_to_chain(struct multi_pack_index *m)
 }
 
 static void clear_midx_files(struct odb_source *source,
-			     const char **hashes, uint32_t hashes_nr,
-			     unsigned incremental)
+			     const struct strvec *hashes, unsigned incremental)
 {
 	/*
 	 * if incremental:
@@ -1124,13 +1122,15 @@ static void clear_midx_files(struct odb_source *source,
 	 */
 	struct strbuf buf = STRBUF_INIT;
 	const char *exts[] = { MIDX_EXT_BITMAP, MIDX_EXT_REV, MIDX_EXT_MIDX };
-	uint32_t i, j;
+	uint32_t i;
 
 	for (i = 0; i < ARRAY_SIZE(exts); i++) {
-		clear_incremental_midx_files_ext(source, exts[i],
-						 hashes, hashes_nr);
-		for (j = 0; j < hashes_nr; j++)
-			clear_midx_files_ext(source, exts[i], hashes[j]);
+		clear_incremental_midx_files_ext(source, exts[i], hashes);
+		if (hashes) {
+			for (size_t j = 0; j < hashes->nr; j++)
+				clear_midx_files_ext(source, exts[i],
+						     hashes->v[j]);
+		}
 	}
 
 	if (incremental)
@@ -1267,8 +1267,7 @@ static int write_midx_internal(struct write_midx_opts *opts)
 	int pack_name_concat_len = 0;
 	int dropped_packs = 0;
 	int result = -1;
-	const char **keep_hashes = NULL;
-	size_t keep_hashes_nr = 0;
+	struct strvec keep_hashes = STRVEC_INIT;
 	struct chunkfile *cf;
 
 	trace2_region_enter("midx", "write_midx_internal", r);
@@ -1708,32 +1707,12 @@ static int write_midx_internal(struct write_midx_opts *opts)
 	if (ctx.num_multi_pack_indexes_before == UINT32_MAX)
 		die(_("too many multi-pack-indexes"));
 
-	if (ctx.compact) {
-		struct multi_pack_index *m;
-
-		/*
-		 * Keep all MIDX layers excluding those in the range [from, to].
-		 */
-		for (m = ctx.base_midx; m; m = m->base_midx)
-			keep_hashes_nr++;
-		for (m = ctx.m;
-		     m && midx_hashcmp(m, ctx.compact_to, r->hash_algo);
-		     m = m->base_midx)
-			keep_hashes_nr++;
-
-		keep_hashes_nr++; /* include the compacted layer */
-	} else {
-		keep_hashes_nr = ctx.num_multi_pack_indexes_before + 1;
-	}
-	CALLOC_ARRAY(keep_hashes, keep_hashes_nr);
-
 	if (ctx.incremental) {
 		FILE *chainf = fdopen_lock_file(&lk, "w");
 		struct strbuf final_midx_name = STRBUF_INIT;
 		struct multi_pack_index *m = ctx.base_midx;
 		struct multi_pack_index **layers = NULL;
 		size_t layers_nr = 0, layers_alloc = 0;
-		size_t j = 0;
 
 		if (!chainf) {
 			error_errno(_("unable to open multi-pack-index chain file"));
@@ -1761,12 +1740,12 @@ static int write_midx_internal(struct write_midx_opts *opts)
 				layers[layers_nr++] = mp;
 			}
 			while (layers_nr)
-				keep_hashes[j++] =
-					xstrdup(midx_get_checksum_hex(layers[--layers_nr]));
+				strvec_push(&keep_hashes,
+					    midx_get_checksum_hex(layers[--layers_nr]));
 
-			keep_hashes[j++] =
-				xstrdup(hash_to_hex_algop(midx_hash,
-							  r->hash_algo));
+			strvec_push(&keep_hashes,
+				    hash_to_hex_algop(midx_hash,
+						     r->hash_algo));
 
 			for (mp = ctx.m;
 			     mp && midx_hashcmp(mp, ctx.compact_to,
@@ -1776,31 +1755,29 @@ static int write_midx_internal(struct write_midx_opts *opts)
 				layers[layers_nr++] = mp;
 			}
 			while (layers_nr)
-				keep_hashes[j++] =
-					xstrdup(midx_get_checksum_hex(layers[--layers_nr]));
+				strvec_push(&keep_hashes,
+					    midx_get_checksum_hex(layers[--layers_nr]));
 		} else {
 			for (; m; m = m->base_midx) {
 				ALLOC_GROW(layers, layers_nr + 1, layers_alloc);
 				layers[layers_nr++] = m;
 			}
 			while (layers_nr)
-				keep_hashes[j++] =
-					xstrdup(midx_get_checksum_hex(layers[--layers_nr]));
+				strvec_push(&keep_hashes,
+					    midx_get_checksum_hex(layers[--layers_nr]));
 
-			keep_hashes[j++] =
-				xstrdup(hash_to_hex_algop(midx_hash,
-							  r->hash_algo));
+			strvec_push(&keep_hashes,
+				    hash_to_hex_algop(midx_hash,
+						     r->hash_algo));
 		}
 
-		ASSERT(j == keep_hashes_nr);
-
 		free(layers);
 
-		for (uint32_t i = 0; i < j; i++)
-			fprintf(get_lock_file_fp(&lk), "%s\n", keep_hashes[i]);
+		for (size_t i = 0; i < keep_hashes.nr; i++)
+			fprintf(get_lock_file_fp(&lk), "%s\n", keep_hashes.v[i]);
 	} else {
-		keep_hashes[ctx.num_multi_pack_indexes_before] =
-			xstrdup(hash_to_hex_algop(midx_hash, r->hash_algo));
+		strvec_push(&keep_hashes,
+			    hash_to_hex_algop(midx_hash, r->hash_algo));
 	}
 
 	if (ctx.m || ctx.base_midx)
@@ -1809,8 +1786,7 @@ static int write_midx_internal(struct write_midx_opts *opts)
 	if (commit_lock_file(&lk) < 0)
 		die_errno(_("could not write multi-pack-index"));
 
-	clear_midx_files(opts->source, keep_hashes, keep_hashes_nr,
-			 ctx.incremental);
+	clear_midx_files(opts->source, &keep_hashes, ctx.incremental);
 	result = 0;
 
 cleanup:
@@ -1826,11 +1802,7 @@ static int write_midx_internal(struct write_midx_opts *opts)
 	free(ctx.entries);
 	free(ctx.pack_perm);
 	free(ctx.pack_order);
-	if (keep_hashes) {
-		for (uint32_t i = 0; i < keep_hashes_nr; i++)
-			free((char *)keep_hashes[i]);
-		free(keep_hashes);
-	}
+	strvec_clear(&keep_hashes);
 	strbuf_release(&midx_name);
 	close_midx(midx_to_free);
 
diff --git a/midx.c b/midx.c
index f75e3c9fa6d..bcb8c999015 100644
--- a/midx.c
+++ b/midx.c
@@ -12,6 +12,7 @@
 #include "chunk-format.h"
 #include "pack-bitmap.h"
 #include "pack-revindex.h"
+#include "strvec.h"
 
 #define MIDX_PACK_ERROR ((void *)(intptr_t)-1)
 
@@ -19,8 +20,7 @@ int midx_checksum_valid(struct multi_pack_index *m);
 void clear_midx_files_ext(struct odb_source *source, const char *ext,
 			  const char *keep_hash);
 void clear_incremental_midx_files_ext(struct odb_source *source, const char *ext,
-				      char **keep_hashes,
-				      uint32_t hashes_nr);
+				      const struct strvec *keep_hashes);
 int cmp_idx_or_pack_name(const char *idx_or_pack_name,
 			 const char *idx_name);
 
@@ -799,22 +799,22 @@ void clear_midx_files_ext(struct odb_source *source, const char *ext,
 }
 
 void clear_incremental_midx_files_ext(struct odb_source *source, const char *ext,
-				      char **keep_hashes,
-				      uint32_t hashes_nr)
+				      const struct strvec *keep_hashes)
 {
 	struct clear_midx_data data = {
 		.keep = STRSET_INIT,
 		.ext = ext,
 	};
 	struct strbuf buf = STRBUF_INIT;
-	uint32_t i;
 
-	for (i = 0; i < hashes_nr; i++) {
-		strbuf_reset(&buf);
-		strbuf_addf(&buf, "multi-pack-index-%s.%s", keep_hashes[i],
-			    ext);
+	if (keep_hashes) {
+		for (size_t i = 0; i < keep_hashes->nr; i++) {
+			strbuf_reset(&buf);
+			strbuf_addf(&buf, "multi-pack-index-%s.%s",
+				    keep_hashes->v[i], ext);
 
-		strset_add(&data.keep, buf.buf);
+			strset_add(&data.keep, buf.buf);
+		}
 	}
 
 	for_each_file_in_pack_subdir(source->path, "multi-pack-index.d",
-- 
2.54.0.175.g8bd0ec98dc3

