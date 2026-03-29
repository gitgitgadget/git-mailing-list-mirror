Received: from mail-yx1-f65.google.com (mail-yx1-f65.google.com [74.125.224.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04387184540
	for <git@vger.kernel.org>; Sun, 29 Mar 2026 21:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774820464; cv=none; b=qYsc85Etsu4hc+nzKa6R8juWb2aXduUIb2FDvrvKUw2O9Kz3k7WX9uj5CZgrg9p5x+601fiClVcPeOcm6E0I8a0Vhv2wiXSKqllAebwkaV22HKLeyVEpe9wJgSPvbspBLFeltqaHLgZM6tUZCNMcype4VTwjsoDOvLkyB7JW2uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774820464; c=relaxed/simple;
	bh=qbsZ45m1vdK7QT/lucS0JBV6e3iZuki1+bUtwjrKuyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l2+bsqmvxV5z4ZElL8RDAct5AXkxyFxdyv/zskZvDzv9LBiMtPlM6l19LGBwraEfdGCrgTrgKQWezc9I3ACkzmIGrB/vaYP/KRyfp29gz3CviIo2on9SSPtgmpRXb/etImKd2HFg5YUFh/7x7SgOYO+76OsS2gLmzGXuDI/P6bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=iTIE6IlD; arc=none smtp.client-ip=74.125.224.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="iTIE6IlD"
Received: by mail-yx1-f65.google.com with SMTP id 956f58d0204a3-65003f40a22so2765874d50.2
        for <git@vger.kernel.org>; Sun, 29 Mar 2026 14:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1774820462; x=1775425262; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rfCDTzheppGnVbFd7GOCG9TngjYdZuB9hEWlwVicGpA=;
        b=iTIE6IlDOiHHSNSubTUgcKSSuYvN6X5XlEvlvcW2gZSaxg/YxMprESK7b/HnjexMDI
         GpKmXJG82qq2OohMuSOG8byc1NR0MDPitK1fvf0dkgbn/msK+siWdTEHBCCZJkI654R3
         07xPmAIPESRFleSrfyEbkKlF/U7AP8ieVQoLwFfmzGpoKaWwpK+zZ7+eppGTEt+gsLFn
         I5PyiewaMJEgVOPhA0VV+/l/w20DToEejAN8OBKksLSA9ksoG1U59O23yglLEKTaZdIL
         sveW3u8sGN3PPOUQvT9fo5BLjqSbsghsfDlEysXJ1aPJC8gi29gnPPAXQD0iZz3HBIHM
         8a4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774820462; x=1775425262;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rfCDTzheppGnVbFd7GOCG9TngjYdZuB9hEWlwVicGpA=;
        b=PZQySPqAcl0fyaE6R4fPVT+J1sJv5em5gM8zSO00oHdRpbx5BbLHR4P6w8sn/aoRp7
         fvHVLyjfpih6lwY/bHz7PTBkCom+vip4SV30KuM3SM8I+upJDZVR85nVEWN0wLl+ezfY
         WAgZrujJ7DOxwC2zrc8S8d1NQwMB0zpSF9HamWQqlGyPe7PelwYy+uOfhgXrn6Efn8W9
         dU/9vF/eoMw/tA5bS389EKgIiI/qxU9f/8lqftSh//aLb1NBIoF6wvCoyiUI1ESOBTC/
         c36YICU1xOxCz72i8BsPCxOiihMskUW5DoDGDHrdna8ivF7DWXOs07qaIAbrpTiGnn+Q
         WZPA==
X-Gm-Message-State: AOJu0YwZkdxBdZQ9PmtWA6jIThJcuDERM8ab7rT1XSzuqm1clI1ZB9TY
	L/3hC0+zNFZTr8qNziQJDCSQh+eO/t5uWoyDlH3D4oAVkPKOgY3o7ng0FX9uE6t9QW8OMSgGdRi
	hIn4PRsO+LUZ1
X-Gm-Gg: ATEYQzwZQlKT7aZuK8ImzHqCqr9tkFn2C7xnyJJ70O3uPAqqSMGqtvbcWJrfUu28eY9
	ZoceR8k2lquXX1NSrF/j9dJ1AipoexmdoqZk0UFB2U4l5mxW5pU3t1Zosp2UFNGzSHyrRfj3hsm
	HOg/ygh44RVM2Y2QCQnhLF22+MLv9QYsZHJgbCQi6ZigJHajVBCnuP+JvAR10bm4RIroWw1IPWx
	afJMVuuwV3UQ2/EGGooi+TwmX/NeZBmPZwwc4oH8gq+1yFUZrbV1fWT5d1RWAnlbDhWN3DB+Hm6
	q4L8A3xxahu7uTzvEPfgeIMoznGSl26KIjlDdxopaghB2nUqWszT7VjFn75OpxY0y4SVmS41q+/
	UoJvJwuiuNJLnrDNfMRCXj7iKofu+b9BQ78QRaoZRxblVPSYntZEhZIotWxp22KIJZEvgEmgSIq
	cdvE62XPenCGsuhwELEzGqkw0V5Ik2twmjo4RZC+22c9vLUj9nQhjpfnZQb55v7Jtx17l56xmqY
	ElaRJWt68xMAt/b9hdM/4RjKx1dpg==
X-Received: by 2002:a05:690c:e4ed:b0:79a:b409:b62c with SMTP id 00721157ae682-79bdded03bcmr101361877b3.22.1774820461878;
        Sun, 29 Mar 2026 14:41:01 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79cb7135bd2sm26518497b3.2.2026.03.29.14.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 14:41:01 -0700 (PDT)
Date: Sun, 29 Mar 2026 17:41:00 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 04/16] midx: use `strvec` for `keep_hashes`
Message-ID: <5fc72d5049a602ae5ede6bb243f44546f02d995d.1774820449.git.me@ttaylorr.com>
References: <cover.1774820449.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1774820449.git.me@ttaylorr.com>

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

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx-write.c | 51 ++++++++++++++++++++++++++-------------------------
 midx.c       | 28 +++++++++++++++++-----------
 2 files changed, 43 insertions(+), 36 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index d0351bde493..9f7d2bbf4cb 100644
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
@@ -1268,7 +1268,7 @@ static int write_midx_internal(struct write_midx_opts *opts)
 	int pack_name_concat_len = 0;
 	int dropped_packs = 0;
 	int result = -1;
-	const char **keep_hashes = NULL;
+	struct strvec keep_hashes = STRVEC_INIT;
 	size_t keep_hashes_nr = 0;
 	struct chunkfile *cf;
 
@@ -1723,7 +1723,7 @@ static int write_midx_internal(struct write_midx_opts *opts)
 	} else {
 		keep_hashes_nr = ctx.num_multi_pack_indexes_before + 1;
 	}
-	CALLOC_ARRAY(keep_hashes, keep_hashes_nr);
+	strvec_init_alloc(&keep_hashes, keep_hashes_nr);
 
 	if (ctx.incremental) {
 		FILE *chainf = fdopen_lock_file(&lk, "w");
@@ -1760,39 +1760,45 @@ static int write_midx_internal(struct write_midx_opts *opts)
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
@@ -1801,8 +1807,7 @@ static int write_midx_internal(struct write_midx_opts *opts)
 	if (commit_lock_file(&lk) < 0)
 		die_errno(_("could not write multi-pack-index"));
 
-	clear_midx_files(opts->source, keep_hashes, keep_hashes_nr,
-			 ctx.incremental);
+	clear_midx_files(opts->source, &keep_hashes, ctx.incremental);
 	result = 0;
 
 cleanup:
@@ -1818,11 +1823,7 @@ static int write_midx_internal(struct write_midx_opts *opts)
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
index d322743f2db..e6b1fbe37d7 100644
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
 
@@ -799,20 +799,26 @@ void clear_midx_files_ext(struct odb_source *source, const char *ext,
 }
 
 void clear_incremental_midx_files_ext(struct odb_source *source, const char *ext,
-				      char **keep_hashes,
-				      uint32_t hashes_nr)
+				      const struct strvec *keep_hashes)
 {
 	struct clear_midx_data data = {
-		.keep = STRING_LIST_INIT_NODUP,
+		.keep = STRING_LIST_INIT_DUP,
 		.ext = ext,
 	};
-	uint32_t i;
 
-	for (i = 0; i < hashes_nr; i++)
-		string_list_append(&data.keep,
-				   xstrfmt("multi-pack-index-%s.%s",
-					   keep_hashes[i], ext));
-	string_list_sort(&data.keep);
+	if (keep_hashes) {
+		struct strbuf buf = STRBUF_INIT;
+		for (size_t i = 0; i < keep_hashes->nr; i++) {
+			strbuf_reset(&buf);
+
+			strbuf_addf(&buf, "multi-pack-index-%s.%s",
+				    keep_hashes->v[i], ext);
+			string_list_append(&data.keep, buf.buf);
+		}
+
+		string_list_sort(&data.keep);
+		strbuf_release(&buf);
+	}
 
 	for_each_file_in_pack_subdir(source->path, "multi-pack-index.d",
 				     clear_midx_file_ext, &data);
-- 
2.53.0.729.g817728289e1.dirty

