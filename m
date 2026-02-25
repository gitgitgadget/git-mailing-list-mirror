Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com [209.85.222.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4731F3BA4
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 00:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771978871; cv=none; b=F6tWw6uMSuWjarPH41yQg0sdDfF9OVy0ym39lgAv/QkzuGtFbyJzvRgUSAHBCgaMLGNzG9s/ONWuYyGYiw0XlLCU82LTROyWgDbK1xsopvYJ9BAAukcEhx+pF3kcAOz6XlKPM5gRjz5ITzrhp6Y2GpTcyZIqmAwdkC0HOuQY9Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771978871; c=relaxed/simple;
	bh=hNB6wI2F8H9x5AtSxMS/Ogwz+6x6Vz8L4e+RSU1Ldwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UgwVkOOskc6G7EabLReAPoyNL1R32QuUsnbv9VJHoD5xRPvotpLJEq0nBxNbGJ8qyqOApBhEKF3KESLadbp0ejg5MocZ7E99BJRgZEfIJFxBT48Cu2t9M57NAdvH/bc33GcJMFbv9Kxm/UsSaryFV1zbPaFq+0JEtbem8wSJc/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=OLljn4Jf; arc=none smtp.client-ip=209.85.222.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="OLljn4Jf"
Received: by mail-qk1-f195.google.com with SMTP id af79cd13be357-8cb3825b0fbso596038485a.0
        for <git@vger.kernel.org>; Tue, 24 Feb 2026 16:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1771978868; x=1772583668; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aTghkHf9h3CDr4+8JYtpg7KbLAh5Z+2uXsph1KGI6MY=;
        b=OLljn4Jf3qp6P/FQ1Vdc6X/B57Ol2z4bPcWhBreZEnOUtpMHGOWwlr1Vu+JTbbBaLd
         wS7iwElXpipy7mxJnDJA4lFBOaHwEC3ax3ycSO29j1DRAfNEoEPMRTEHFDPVFJw0k8V6
         eJglwKBE2YDframgKRWrI2bvg5Vr9/4mCg1eDSUllwQbX2Ai59fIHovf7XDHhhUXbf2T
         ilIGy4l/YaqZY8FY0FeIgbcrDlinv/JnhykmGckis5MiOe2n4eY0yZqaUZXkZNjqwGQr
         6JU560x22Nd2BDRejXeeboZEYC2m2jHZBO4uxSSlqRQ2VOaVpDoMMhHVHaNmO1wIpJDV
         T8GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771978868; x=1772583668;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aTghkHf9h3CDr4+8JYtpg7KbLAh5Z+2uXsph1KGI6MY=;
        b=jSAhHvjFKNjeoUAwFP9r/w4e6jGaEWTviGgNogbJ9DQMS6pwb1SlLvyuo/u+vyjECO
         DGsPC3NP4vErqnIVfQINUeVhnTNAw3FDLhjMh1Hpdu/fqWXQxk2H4yBtrosAFpbFpbeX
         BNH0qkJ8mDTTDnOQ6liPfMn29PlEfi9AjG8I17sI7IgEx3ToICRCIbx2cq+VbuFykA+t
         319QuA1zJ74CmEXRAPCAt4IyMr7Oq1GrNyh3Y1uQ61vPV2Bc+YGkXlordKdafSrKamYz
         q9OtHWD1Jor/5DurzGJRv2COi6gK3V0NukVqHIEb4OIySyTdz98Wrkx5jM+cGhqTszEJ
         /Y2g==
X-Gm-Message-State: AOJu0YxrghkMYHA+4uyY3Dx/WdiEzpHhqJ5j3NzrkOLWVZtdRO5XZBwS
	DQHacmxmqjFemOYxM6XGKQh53pyUG54pwJT+l18UpVeMyyFest/b6Ez8NRI3SBB2xgkHDsTzTxX
	URPdjzH/JnNAG
X-Gm-Gg: ATEYQzw5k4eqwLJtqG9mLpiJUL+yTiKaGT98sayVY+v9NiljRngInOUVLIucPJBpf9E
	AvCGZnBvQ0GmYes0+xqIS+S88bVBidryHeWp2XbmFBGZz6ic5jY7/ckcSRBURV5q4RnKTJlIzVP
	NO0dkZGZazsho0pVWoGVpEqLNwdFNIWR+JKLSmaTq7bDoGhto4/hq7RQpYqkg10HwUqtCprk34i
	qoX1/YRFaz0k+u8+KgsYpmkw91yqVZAbWWwgaK4EeGiKb/+21YyICx/GK+tzcFTb16zfKb/Kghj
	H46bxdI9PFcMv9o5kdjKJ2ThiNP9exxqOlm8nrztzth9UsPPQbPVGgBq1L0n7jEB55vtvxjyBRu
	kUbv9Vb5D/jeru+ZAUt/RWrINQNmkwKpTJkOtUv93zaoSz+i08HaAk7AEb8NQRKBdek7kxbgrps
	idbIRddPT3Zv9L1M3VLekjISdJJ3c9eLJ9lreRlQ3o11EGMoafdFbhaBNp8I5+I4uDJ4j0VDYT/
	MNxetbmNYUWzxEvMJG95GGwPoENOA==
X-Received: by 2002:a05:620a:708b:b0:8a2:3be9:1d79 with SMTP id af79cd13be357-8cb8c9fe273mr1654026785a.18.1771978868319;
        Tue, 24 Feb 2026 16:21:08 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d04498csm1277241785a.9.2026.02.24.16.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 16:21:07 -0800 (PST)
Date: Tue, 24 Feb 2026 19:21:05 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH 03/14] midx: use `strvec` for `keep_hashes`
Message-ID: <b2fffdfc8910308b6c816dfba9e04196a5aaf4ac.1771978829.git.me@ttaylorr.com>
References: <cover.1771978829.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1771978829.git.me@ttaylorr.com>

The `keep_hashes` array in `write_midx_internal()` accumulates the
checksums of MIDX files that should be retained when pruning stale
entries from the MIDX chain. For similar reasons as in a previous
commit, rewrite this using a strvec, requiring us to pass one fewer
parameter.

Unlike the aforementioned previous commit, use a `strvec` instead of a
`string_list`, which provides a more ergonomic interface to adjust the
values at a particular indice. The ordering is important here, as this
value is used to determine the contents of the resulting
`multi-pack-index-chain` file when writing with "--incremental".

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx-write.c | 51 ++++++++++++++++++++++++++-------------------------
 midx.c       | 20 ++++++++++----------
 2 files changed, 36 insertions(+), 35 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index 0ff2e45aa7a..7fdc4d31243 100644
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
@@ -1266,7 +1266,7 @@ static int write_midx_internal(struct write_midx_opts *opts)
 	int pack_name_concat_len = 0;
 	int dropped_packs = 0;
 	int result = -1;
-	const char **keep_hashes = NULL;
+	struct strvec keep_hashes = STRVEC_INIT;
 	size_t keep_hashes_nr = 0;
 	struct chunkfile *cf;
 
@@ -1721,7 +1721,7 @@ static int write_midx_internal(struct write_midx_opts *opts)
 	} else {
 		keep_hashes_nr = ctx.num_multi_pack_indexes_before + 1;
 	}
-	CALLOC_ARRAY(keep_hashes, keep_hashes_nr);
+	strvec_init_alloc(&keep_hashes, keep_hashes_nr);
 
 	if (ctx.incremental) {
 		FILE *chainf = fdopen_lock_file(&lk, "w");
@@ -1758,39 +1758,45 @@ static int write_midx_internal(struct write_midx_opts *opts)
 			for (i = 0; i < num_layers_before_from; i++) {
 				uint32_t j = num_layers_before_from - i - 1;
 
-				keep_hashes[j] = xstrdup(midx_get_checksum_hex(m));
+				keep_hashes.v[j] = xstrdup(midx_get_checksum_hex(m));
+				keep_hashes.nr++;
 				m = m->base_midx;
 			}
 
-			keep_hashes[i] = xstrdup(hash_to_hex_algop(midx_hash,
+			keep_hashes.v[i] = xstrdup(hash_to_hex_algop(midx_hash,
 								   r->hash_algo));
+			keep_hashes.nr++;
 
 			i = 0;
 			for (m = ctx.m;
 			     m && midx_hashcmp(m, ctx.compact_to, r->hash_algo);
 			     m = m->base_midx) {
-				keep_hashes[keep_hashes_nr - i - 1] =
+				keep_hashes.v[keep_hashes_nr - i - 1] =
 					xstrdup(midx_get_checksum_hex(m));
+				keep_hashes.nr++;
 				i++;
 			}
 		} else {
-			keep_hashes[ctx.num_multi_pack_indexes_before] =
+			keep_hashes.v[ctx.num_multi_pack_indexes_before] =
 				xstrdup(hash_to_hex_algop(midx_hash,
 							  r->hash_algo));
+			keep_hashes.nr++;
 
 			for (uint32_t i = 0; i < ctx.num_multi_pack_indexes_before; i++) {
 				uint32_t j = ctx.num_multi_pack_indexes_before - i - 1;
 
-				keep_hashes[j] = xstrdup(midx_get_checksum_hex(m));
+				keep_hashes.v[j] = xstrdup(midx_get_checksum_hex(m));
+				keep_hashes.nr++;
 				m = m->base_midx;
 			}
 		}
 
 		for (uint32_t i = 0; i < keep_hashes_nr; i++)
-			fprintf(get_lock_file_fp(&lk), "%s\n", keep_hashes[i]);
+			fprintf(get_lock_file_fp(&lk), "%s\n", keep_hashes.v[i]);
 	} else {
-		keep_hashes[ctx.num_multi_pack_indexes_before] =
+		keep_hashes.v[ctx.num_multi_pack_indexes_before] =
 			xstrdup(hash_to_hex_algop(midx_hash, r->hash_algo));
+		keep_hashes.nr++;
 	}
 
 	if (ctx.m || ctx.base_midx)
@@ -1799,8 +1805,7 @@ static int write_midx_internal(struct write_midx_opts *opts)
 	if (commit_lock_file(&lk) < 0)
 		die_errno(_("could not write multi-pack-index"));
 
-	clear_midx_files(opts->source, keep_hashes, keep_hashes_nr,
-			 ctx.incremental);
+	clear_midx_files(opts->source, &keep_hashes, ctx.incremental);
 	result = 0;
 
 cleanup:
@@ -1816,11 +1821,7 @@ static int write_midx_internal(struct write_midx_opts *opts)
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
index c5e3553e2bb..20732c256a6 100644
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
 
@@ -791,20 +791,20 @@ void clear_midx_files_ext(struct odb_source *source, const char *ext,
 }
 
 void clear_incremental_midx_files_ext(struct odb_source *source, const char *ext,
-				      char **keep_hashes,
-				      uint32_t hashes_nr)
+				      const struct strvec *keep_hashes)
 {
 	struct clear_midx_data data = {
 		.keep = STRING_LIST_INIT_NODUP,
 		.ext = ext,
 	};
-	uint32_t i;
 
-	for (i = 0; i < hashes_nr; i++)
-		string_list_append(&data.keep,
-				   xstrfmt("multi-pack-index-%s.%s",
-					   keep_hashes[i], ext));
-	string_list_sort(&data.keep);
+	if (keep_hashes) {
+		for (size_t i = 0; i < keep_hashes->nr; i++)
+			string_list_append(&data.keep,
+					   xstrfmt("multi-pack-index-%s.%s",
+						   keep_hashes->v[i], ext));
+		string_list_sort(&data.keep);
+	}
 
 	for_each_file_in_pack_subdir(source->path, "multi-pack-index.d",
 				     clear_midx_file_ext, &data);
-- 
2.53.0.185.g29bc4dff628

