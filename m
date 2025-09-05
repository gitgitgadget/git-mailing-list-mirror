Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE03280CE5
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 19:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757100390; cv=none; b=fpuZQkwwa3v5xK7XQ+etnmwkulAlyb07Ys4dw53Rw9V6ALCkaiSlcGkgYO5cJQ4pgGobA8d+QL8p0SObm78grCYJoRDgVvawuyHqLnaV/TOcCOACifWb9OQbbR9QmIomwvZgxbMwJkMGGc5oevPIp2ONIHs0Xij5ygrrlI/3en8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757100390; c=relaxed/simple;
	bh=5m2HEzVw5T6ogr/P1GwUhNj1H4MfAWX4859cwg2x+90=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=eggPe4lF+XF9A0nHozqBPa3HUUWkkfYBfWEo7FmKDkicJrKIuf+Hi7gIF8cZiIIB1bdQT1hJNCUtaqO0XWW1XuV6cRKzy5VkKAJAcijsl2xdCeoJuPANb6gkFL0Q2ZPjk5W4eR2lxgtaLKycMKO8680LnBJzCVar5vymNa8v6D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IIDWP/sb; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IIDWP/sb"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-772481b2329so2651249b3a.2
        for <git@vger.kernel.org>; Fri, 05 Sep 2025 12:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757100388; x=1757705188; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f2u/5zq3AONOVfcUqYT6Yl06OEXlVuoQKivTu9bP1Ok=;
        b=IIDWP/sb86/vSBtoZuBstLfNHGzfAvQOYQXt1pJo7CH/fyj2gX4hKjVrhnwR83jfIh
         m8PEDakmCBZZZ7PS5kp98dulCQGvIY9lNRuBFmXtbeEQ/ZJRddXj6uQ2f3dMi4w3nUo8
         2qrJhgVaE2qytc8vDlgIAlmmWtUHBoYmWhH2K1laTYcRaH6Ou7RfzkFETnNXmoca4F6+
         KnTcVHWRdUXxxxToUH02Xsimh5I0dGgPGMy1kE9JfGh8Ue9tOLsKxdWVyreXQj0qb6IA
         dV932GmrnYy+4nieZomfD4J0N4ZFqaTmIoMqxERmcuP/orC/2CSx7NMBUySHqfl8myA0
         zhAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757100388; x=1757705188;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f2u/5zq3AONOVfcUqYT6Yl06OEXlVuoQKivTu9bP1Ok=;
        b=K2nUNL7ajqkVtZUw3rv498+x7bCLZq+g+ME5qTmpz40eY840e/cPv6yw9sjA/z8sQh
         RyfZgLlnS7Pt3t3VH5+LPdRsyE7G+BVpi9fZP1VQ+ZH9/lsjOGzXLlpQMsZD1W4jkzaQ
         p8k/vvVHlUe7+XqkhpWsMDv6dLsgNKfIi/IHNhywMVFcP069KgBtfnkuTFItTJ6q+i1B
         ZxhjKrcxZqSTSjei388SA6fVfygURIBi7ZkgB+NkF168ZzomLo8YpPfdPdIdris/2Gzi
         dn06HlcFOweWPyiI/eCmFtk6mTBHmQPmWzdSw1CtsdmVEVFly8sow1/fk21JYP47UITj
         usQQ==
X-Gm-Message-State: AOJu0Yw4I8+0904x17M1v3FQ5zhpirO5k69TFgkAMGQ1J8QHJbzmsWKl
	G0OdLzkWM8TzHrQPm9HEoVNIYzh7pToo0o5l5gZQzycmbp4mxNS5YHim9lMOow==
X-Gm-Gg: ASbGnctk8macQ1uvPyRIv1UlXHiE6w2TmSwvv331fQa6LzStCPJGlYCW4N0D1xNIKIo
	kF7kGICvy6of0xAI1E8RUyWfRwfe9PJZsJ6x/7VG1fq9mL6l/c6bljlb0CyBeDhDJMR0Bks4gN8
	UF7s3QbAolS1GNa74enTSaFOYhuUfSu77P4w1cNAUvhPOSI125YQYErqrMtlr6fGX4E2jEtLO3i
	Q44/PjcHH5PArLxLV1kBzdC731tVtwif+1YihTOPszJT0ZH5HvZFMpKlNBLYXxKGmfxVItNTYhV
	SjTSnSUkmlcTdDXOKJSxK1e4xA57whiiqP6fvUoeNSEarwohHS1ZHd2QhGhV+wOx+nXQw+XQbXB
	f7dFc1kRd5umCkWMMBSaosZGFzw==
X-Google-Smtp-Source: AGHT+IGAeKs/D8O8LTR3iGy8K+jgJVjdAYvxN6kIewW4Gm1sBslbQm+/Mjn+1W/A3oOKaZLqC8TNWQ==
X-Received: by 2002:a05:6a00:2381:b0:771:f69a:c426 with SMTP id d2e1a72fcca58-7723e276e5dmr34159674b3a.14.1757100387600;
        Fri, 05 Sep 2025 12:26:27 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.243.166])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4e5b44sm22301604b3a.88.2025.09.05.12.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 12:26:27 -0700 (PDT)
Message-Id: <7c68f2535cd5084ae796ef0e8767caecaf1c7c3f.1757100378.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1965.v3.git.1757100378.gitgitgadget@gmail.com>
References: <pull.1965.v2.git.1756589007.gitgitgadget@gmail.com>
	<pull.1965.v3.git.1757100378.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 05 Sep 2025 19:26:17 +0000
Subject: [PATCH v3 5/6] midx-write: reenable signed comparison errors
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: gitster@pobox.com,
    me@ttaylorr.com,
    Patrick Steinhardt <ps@pks.im>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

Remove the remaining signed comparison warnings in midx-write.c so that
they can be enforced as errors in the future. After the previous change,
the remaining errors are due to iterator variables named 'i'.

The strategy here involves defining the variable within the for loop
syntax to make sure we use the appropriate bitness for the loop
sentinel. This matters in at least one method where the variable was
compared to uint32_t in some loops and size_t in others.

While adjusting these loops, there were some where the loop boundary was
checking against a uint32_t value _plus one_. These were replaced with
non-strict comparisons, but also the value is checked to not be
UINT32_MAX. Since the value is the number of incremental multi-pack-
indexes, this is not a meaningful restriction. The new die() is about
defensive programming more than it being realistically possible.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 midx-write.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index 1822268ce2..cd7bf7554a 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -1,5 +1,3 @@
-#define DISABLE_SIGN_COMPARE_WARNINGS
-
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "config.h"
@@ -845,7 +843,7 @@ static int write_midx_bitmap(struct write_midx_context *ctx,
 			     uint32_t commits_nr,
 			     unsigned flags)
 {
-	int ret, i;
+	int ret;
 	uint16_t options = 0;
 	struct bitmap_writer writer;
 	struct pack_idx_entry **index;
@@ -873,7 +871,7 @@ static int write_midx_bitmap(struct write_midx_context *ctx,
 	 * this order).
 	 */
 	ALLOC_ARRAY(index, pdata->nr_objects);
-	for (i = 0; i < pdata->nr_objects; i++)
+	for (uint32_t i = 0; i < pdata->nr_objects; i++)
 		index[i] = &pdata->objects[i].idx;
 
 	bitmap_writer_init(&writer, ctx->repo, pdata,
@@ -894,7 +892,7 @@ static int write_midx_bitmap(struct write_midx_context *ctx,
 	 * happens between bitmap_writer_build_type_index() and
 	 * bitmap_writer_finish().
 	 */
-	for (i = 0; i < pdata->nr_objects; i++)
+	for (uint32_t i = 0; i < pdata->nr_objects; i++)
 		index[ctx->pack_order[i]] = &pdata->objects[i].idx;
 
 	bitmap_writer_select_commits(&writer, commits, commits_nr);
@@ -1038,7 +1036,7 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 {
 	struct strbuf midx_name = STRBUF_INIT;
 	unsigned char midx_hash[GIT_MAX_RAWSZ];
-	uint32_t i, start_pack;
+	uint32_t start_pack;
 	struct hashfile *f = NULL;
 	struct lock_file lk;
 	struct tempfile *incr;
@@ -1154,7 +1152,7 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 	if (preferred_pack_name) {
 		ctx.preferred_pack_idx = NO_PREFERRED_PACK;
 
-		for (i = 0; i < ctx.nr; i++) {
+		for (size_t i = 0; i < ctx.nr; i++) {
 			if (!cmp_idx_or_pack_name(preferred_pack_name,
 						  ctx.info[i].pack_name)) {
 				ctx.preferred_pack_idx = i;
@@ -1186,7 +1184,7 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 		 * pack-order has all of its objects selected from that pack
 		 * (and not another pack containing a duplicate)
 		 */
-		for (i = 1; i < ctx.nr; i++) {
+		for (size_t i = 1; i < ctx.nr; i++) {
 			struct packed_git *p = ctx.info[i].p;
 
 			if (!oldest->num_objects || p->mtime < oldest->mtime) {
@@ -1231,7 +1229,7 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 	compute_sorted_entries(&ctx, start_pack);
 
 	ctx.large_offsets_needed = 0;
-	for (i = 0; i < ctx.entries_nr; i++) {
+	for (size_t i = 0; i < ctx.entries_nr; i++) {
 		if (ctx.entries[i].offset > 0x7fffffff)
 			ctx.num_large_offsets++;
 		if (ctx.entries[i].offset > 0xffffffff)
@@ -1241,10 +1239,10 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 	QSORT(ctx.info, ctx.nr, pack_info_compare);
 
 	if (packs_to_drop && packs_to_drop->nr) {
-		int drop_index = 0;
+		size_t drop_index = 0;
 		int missing_drops = 0;
 
-		for (i = 0; i < ctx.nr && drop_index < packs_to_drop->nr; i++) {
+		for (size_t i = 0; i < ctx.nr && drop_index < packs_to_drop->nr; i++) {
 			int cmp = strcmp(ctx.info[i].pack_name,
 					 packs_to_drop->items[drop_index].string);
 
@@ -1275,7 +1273,7 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 	 * pack_perm[old_id] = new_id
 	 */
 	ALLOC_ARRAY(ctx.pack_perm, ctx.nr);
-	for (i = 0; i < ctx.nr; i++) {
+	for (size_t i = 0; i < ctx.nr; i++) {
 		if (ctx.info[i].expired) {
 			dropped_packs++;
 			ctx.pack_perm[ctx.info[i].orig_pack_int_id] = PACK_EXPIRED;
@@ -1284,7 +1282,7 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 		}
 	}
 
-	for (i = 0; i < ctx.nr; i++) {
+	for (size_t i = 0; i < ctx.nr; i++) {
 		if (ctx.info[i].expired)
 			continue;
 		pack_name_concat_len += strlen(ctx.info[i].pack_name) + 1;
@@ -1430,6 +1428,9 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 	 * have been freed in the previous if block.
 	 */
 
+	if (ctx.num_multi_pack_indexes_before == UINT32_MAX)
+		die(_("too many multi-pack-indexes"));
+
 	CALLOC_ARRAY(keep_hashes, ctx.num_multi_pack_indexes_before + 1);
 
 	if (ctx.incremental) {
@@ -1462,7 +1463,7 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 		keep_hashes[ctx.num_multi_pack_indexes_before] =
 			xstrdup(hash_to_hex_algop(midx_hash, r->hash_algo));
 
-		for (i = 0; i < ctx.num_multi_pack_indexes_before; i++) {
+		for (uint32_t i = 0; i < ctx.num_multi_pack_indexes_before; i++) {
 			uint32_t j = ctx.num_multi_pack_indexes_before - i - 1;
 
 			keep_hashes[j] = xstrdup(hash_to_hex_algop(get_midx_checksum(m),
@@ -1470,7 +1471,7 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 			m = m->base_midx;
 		}
 
-		for (i = 0; i < ctx.num_multi_pack_indexes_before + 1; i++)
+		for (uint32_t i = 0; i <= ctx.num_multi_pack_indexes_before; i++)
 			fprintf(get_lock_file_fp(&lk), "%s\n", keep_hashes[i]);
 	} else {
 		keep_hashes[ctx.num_multi_pack_indexes_before] =
@@ -1488,7 +1489,7 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 			 ctx.incremental);
 
 cleanup:
-	for (i = 0; i < ctx.nr; i++) {
+	for (size_t i = 0; i < ctx.nr; i++) {
 		if (ctx.info[i].p) {
 			close_pack(ctx.info[i].p);
 			free(ctx.info[i].p);
@@ -1501,7 +1502,7 @@ cleanup:
 	free(ctx.pack_perm);
 	free(ctx.pack_order);
 	if (keep_hashes) {
-		for (i = 0; i < ctx.num_multi_pack_indexes_before + 1; i++)
+		for (uint32_t i = 0; i <= ctx.num_multi_pack_indexes_before; i++)
 			free((char *)keep_hashes[i]);
 		free(keep_hashes);
 	}
-- 
gitgitgadget

