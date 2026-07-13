Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E70321A434
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 01:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783905128; cv=none; b=nW1xCXqJv/RXcqvMrXXIFxS55ZXD5wZjryORcKB+yNGodoDhwHN9sLBU20OKS1CS/JdKL2AW2ATU6mkbQVv37ZuVIZ801r72O/HxWLQAcVY/jtuIdgYWOFdaU72pqoaNCQ8gS321MmWGM197p7Pbv9ZxKNxiam57XL0Uc2mGXws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783905128; c=relaxed/simple;
	bh=B1ovYGWK4q3peor0DzwsXqdcXdhlY5BUg/emBI6wg2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VDtSc8iZbqkdmoJbnE2lSl54Hy5m307vMB6tRUwPbkGTSohDUPhcksl44gSGDMOzXC1xfSnYnLJ/a4gXup0F7xHkFlIBEDT9eV/mhdPUpthfNN3k3MJZaG1xjQVkGqz1HfcHhfdjO7IbuVxgSIyVn2erTaNHGA05uXhtvmwVvCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=cpP363HY; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="cpP363HY"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-81eaf3709b4so917497b3.0
        for <git@vger.kernel.org>; Sun, 12 Jul 2026 18:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1783905126; x=1784509926; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2IqlWyPs3UNub2LCqLDtvCCnQZrNwEjlBHGgNHp5slg=;
        b=cpP363HYg5PUD8fir+3UKycrxlOVEocYhlIbnLL+mwh/mTJD0Mas7SxjPa4R788KM8
         h5VysOS/kj+kNM8LPxr/OIJPAYgIh9tAWWeChy9ZFG3kSH/GPJw+vpNT3/ELQI6ZR+lI
         jLb0hZaQjwyH11hBrJOs0Rqw/M5sKIsdIdWKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783905126; x=1784509926;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2IqlWyPs3UNub2LCqLDtvCCnQZrNwEjlBHGgNHp5slg=;
        b=mpUQ2UxJGNHWM5rloKoT2R12qHZvErnplOaWbpALp30rHMTH+gJqi1CrwRIoe6k3pc
         wUdHdJ8bV6B2Dtls5pDyzjG9R9rGnJ51bYCAKkqNKsqFmUp1j/2dHweO0tmNtb6TYGhF
         8bYXSJflwyLq1EYmukP2p2Fnv5HVCa0snrVk3mrS5/ZdJgJWqV1qdoZ1qETyiNUjOJo+
         5RC4Scldv+xRgYb6OjhVLzJViM5N9XCXcEmW1ytOlPZdZG7iidf6aUnvNrH0GPATxeD+
         cDBmVPKnlczfj/YPG1+iFR/8or6IzQTKhb1xl///bLBzevisZpoVLdRZzbHJt6Yri0bB
         yrIA==
X-Gm-Message-State: AOJu0YzuGA3MeJiGn/uDZ7E6Sec9fv7irzPmKlHMBM8uVeSnxwz+o9Bs
	cKMN9Q+ytocf46VzjahUaN9J4JB8vHK+l3kar606evAc4mt++dkBJzZuSNPU+b8PjjjUJsy8pKP
	sdOSzwXJg/w==
X-Gm-Gg: AfdE7ck9LtYTAs4+as/gvbEaldjKxunx95unnWDr63PtBoxznY+rLaPrU4jfT6TGfcZ
	L9WVJSx/o7sGCVt2VGFvBjNP+4hw+L52CaEKcbhEalyciYIzbdRi9eihGr/XuVjBt7kR8melrXk
	yF2/5MYB5kF3MErgf1bA1za9zxQvzWmKL2YCbsvxEhYTRDPdUjXZgNrgf+dnwKCKXRk59Q9nSoE
	0kWAGpf7+xiAbl4klmwFSA5sBUTrrmSwDP46MDOTDbeavTQxRnSQKCjlnxTHJAojsFfN8j2Bewd
	ZgqK52hFmhV60NjUCdNWLQrQwix0tQs/RyGayIhxxzP2ozmPR/NjFArR/HqxM2NTObphrakHIHJ
	kibgnkoNyiu1fmdSPKtc5Dx4NKrOOlqnfvvksdnwEuO+guLMlsTl0w2rG/dYKTsMVYX4iWS8NcV
	QX6LKGBuMFIluFDczOa05+tg==
X-Received: by 2002:a05:690c:d91:b0:81e:782b:72dd with SMTP id 00721157ae682-81e900069c2mr55161437b3.13.1783905126045;
        Sun, 12 Jul 2026 18:12:06 -0700 (PDT)
Received: from com-79390 ([12.187.141.7])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81e6c22441csm103029907b3.43.2026.07.12.18.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 18:12:05 -0700 (PDT)
Date: Sun, 12 Jul 2026 18:12:02 -0700
From: Taylor Blau <ttaylorr@openai.com>
To: git@vger.kernel.org, git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/4] pack-objects: support reuse with `--no-ref-delta`
Message-ID: <alQ7YmnVeEjYG6Wt@com-79390>
References: <cover.1783905084.git.ttaylorr@openai.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1783905084.git.ttaylorr@openai.com>

The previous commit disables delta- and bitmap-reuse entirely whenever
pack-objects is given '--no-ref-delta' for the sake of simplicity. This
is overly pessimistic.

When '--delta-base-offset' is also given, delta reuse can remain
enabled. A reused delta whose base is written earlier in the output can
be encoded as an `OFS_DELTA`, even when its source copy was encoded as a
`REF_DELTA`.

Preferred bases and external thin-pack bases are different: neither
appears in the output, so deltas against either still require encoding
the object as a `REF_DELTA`, and thus cannot be reused.

Without '--delta-base-offset', delta reuse remains disabled, since no
delta representation remains.

Bitmap reuse follows a different path, since selected entries may be
copied without passing through the code which chooses a delta
representation. When given '--no-ref-delta', we must inspect candidate
objects individually, and leave `REF_DELTA` entries to the normal object
path outside of pack-reuse.

We must likewise avoid the special-case for reusing either the single or
preferred pack corresponding to the bitmap by whole `eword_t`'s at a
time.

Signed-off-by: Taylor Blau <ttaylorr@openai.com>
---
 builtin/pack-objects.c      | 17 +++++++++++++----
 pack-bitmap.c               | 30 ++++++++++++++++++++----------
 pack-bitmap.h               |  3 ++-
 t/t5300-pack-object.sh      | 21 ++++++++++++++++++++-
 t/t5332-multi-pack-reuse.sh | 16 ++++++++++++++++
 5 files changed, 71 insertions(+), 16 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index c3574fcb8a..43cd4be2e5 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2207,6 +2207,13 @@ static int can_reuse_delta(const struct object_id *base_oid,
 	 */
 	base = packlist_find(&to_pack, base_oid);
 	if (base) {
+		/*
+		 * A preferred base is omitted from the resulting pack, so it
+		 * can only be referenced by object ID.
+		 */
+		if (base->preferred_base && !allow_ref_delta)
+			return 0;
+
 		if (!in_same_island(&delta->idx.oid, &base->idx.oid))
 			return 0;
 		*base_out = base;
@@ -2218,7 +2225,8 @@ static int can_reuse_delta(const struct object_id *base_oid,
 	 * even if it was buried too deep in history to make it into the
 	 * packing list.
 	 */
-	if (thin && bitmap_has_oid_in_uninteresting(bitmap_git, base_oid)) {
+	if (allow_ref_delta && thin &&
+	    bitmap_has_oid_in_uninteresting(bitmap_git, base_oid)) {
 		if (use_delta_islands) {
 			if (!in_same_island(&delta->idx.oid, base_oid))
 				return 0;
@@ -4668,7 +4676,7 @@ static int pack_options_allow_reuse(void)
 	       !ignore_packed_keep_on_disk &&
 	       !ignore_packed_keep_in_core &&
 	       (!local || !have_non_local_packs) &&
-	       !incremental && allow_ref_delta;
+	       !incremental && (allow_ref_delta || allow_ofs_delta);
 }
 
 static int get_object_list_from_bitmap(struct rev_info *revs)
@@ -4690,7 +4698,8 @@ static int get_object_list_from_bitmap(struct rev_info *revs)
 						   &reuse_packfiles,
 						   &reuse_packfiles_nr,
 						   &reuse_packfile_bitmap,
-						   allow_pack_reuse == MULTI_PACK_REUSE);
+						   allow_pack_reuse == MULTI_PACK_REUSE,
+						   allow_ref_delta);
 
 	if (reuse_packfiles) {
 		reuse_packfile_objects = bitmap_popcount(reuse_packfile_bitmap);
@@ -5317,7 +5326,7 @@ int cmd_pack_objects(int argc,
 	if (unpack_unreachable || keep_unreachable || pack_loose_unreachable)
 		use_internal_rev_list = 1;
 
-	if (!reuse_object || !allow_ref_delta)
+	if (!reuse_object || (!allow_ref_delta && !allow_ofs_delta))
 		reuse_delta = 0;
 	if (cfg->pack_compression_level == -1)
 		cfg->pack_compression_level = Z_DEFAULT_COMPRESSION;
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 83eb47a28b..36cb02e374 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -2267,7 +2267,8 @@ static int try_partial_reuse(struct bitmap_index *bitmap_git,
 			     uint32_t pack_pos,
 			     off_t offset,
 			     struct bitmap *reuse,
-			     struct pack_window **w_curs)
+			     struct pack_window **w_curs,
+			     int allow_ref_delta)
 {
 	off_t delta_obj_offset;
 	enum object_type type;
@@ -2286,6 +2287,9 @@ static int try_partial_reuse(struct bitmap_index *bitmap_git,
 		uint32_t base_pos;
 		uint32_t base_bitmap_pos;
 
+		if (type == OBJ_REF_DELTA && !allow_ref_delta)
+			return 0;
+
 		/*
 		 * Find the position of the base object so we can look it up
 		 * in our bitmaps. If we can't come up with an offset, or if
@@ -2358,20 +2362,19 @@ static int try_partial_reuse(struct bitmap_index *bitmap_git,
 
 static void reuse_partial_packfile_from_bitmap_1(struct bitmap_index *bitmap_git,
 						 struct bitmapped_pack *pack,
-						 struct bitmap *reuse)
+						 struct bitmap *reuse,
+						 int allow_ref_delta)
 {
 	struct bitmap *result = bitmap_git->result;
 	struct pack_window *w_curs = NULL;
 	size_t pos = pack->bitmap_pos / BITS_IN_EWORD;
 
-	if (!pack->bitmap_pos) {
+	if (allow_ref_delta && !pack->bitmap_pos) {
 		/*
 		 * If we're processing the first (in the case of a MIDX, the
 		 * preferred pack) or the only (in the case of single-pack
-		 * bitmaps) pack, then we can reuse whole words at a time.
-		 *
-		 * This is because we know that any deltas in this range *must*
-		 * have their bases chosen from the same pack, since:
+		 * bitmaps) pack, then any delta in this range must have its
+		 * base chosen from the same pack:
 		 *
 		 * - In the single pack case, there is no other pack to choose
 		 *   them from.
@@ -2380,6 +2383,10 @@ static void reuse_partial_packfile_from_bitmap_1(struct bitmap_index *bitmap_git
 		 *   all ties are broken in favor of that pack (i.e. the one
 		 *   we're currently processing). So any duplicate bases will be
 		 *   resolved in favor of the pack we're processing.
+		 *
+		 * When REF_DELTAs are allowed, we can therefore reuse whole
+		 * words at a time without inspecting object headers. Otherwise,
+		 * inspect each object below to avoid reusing a REF_DELTA entry.
 		 */
 		while (pos < result->word_alloc &&
 		       pos < pack->bitmap_nr / BITS_IN_EWORD &&
@@ -2429,7 +2436,8 @@ static void reuse_partial_packfile_from_bitmap_1(struct bitmap_index *bitmap_git
 			}
 
 			if (try_partial_reuse(bitmap_git, pack, bit_pos,
-					      pack_pos, ofs, reuse, &w_curs) < 0) {
+					      pack_pos, ofs, reuse, &w_curs,
+					      allow_ref_delta) < 0) {
 				/*
 				 * try_partial_reuse indicated we couldn't reuse
 				 * any bits, so there is no point in trying more
@@ -2464,7 +2472,8 @@ void reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
 					struct bitmapped_pack **packs_out,
 					size_t *packs_nr_out,
 					struct bitmap **reuse_out,
-					int multi_pack_reuse)
+					int multi_pack_reuse,
+					int allow_ref_delta)
 {
 	struct repository *r = bitmap_repo(bitmap_git);
 	struct bitmapped_pack *packs = NULL;
@@ -2559,7 +2568,8 @@ void reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
 	reuse = bitmap_word_alloc(word_alloc);
 
 	for (i = 0; i < packs_nr; i++)
-		reuse_partial_packfile_from_bitmap_1(bitmap_git, &packs[i], reuse);
+		reuse_partial_packfile_from_bitmap_1(bitmap_git, &packs[i], reuse,
+						     allow_ref_delta);
 
 	if (bitmap_is_empty(reuse)) {
 		free(packs);
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 19a8655457..39b6309736 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -116,7 +116,8 @@ void reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
 					struct bitmapped_pack **packs_out,
 					size_t *packs_nr_out,
 					struct bitmap **reuse_out,
-					int multi_pack_reuse);
+					int multi_pack_reuse,
+					int allow_ref_delta);
 int rebuild_existing_bitmaps(struct bitmap_index *, struct packing_data *mapping,
 			     kh_oid_map_t *reused_bitmaps, int show_progress);
 void free_bitmap_index(struct bitmap_index *);
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index b9e36044b9..02c09e3f7d 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -229,6 +229,20 @@ test_expect_success 'pack without REF_DELTA with OFS_DELTA' '
 	test_grep ! " REF_DELTA " deltas
 '
 
+test_expect_success 'pack without REF_DELTA reuses deltas as OFS_DELTA' '
+	# Install the REF_DELTA pack above and disable delta search, so any
+	# output delta must be a reused REF_DELTA rewritten as OFS_DELTA.
+	test_when_finished "rm -f .git/objects/pack/pack-$packname_2.*" &&
+	git index-pack --stdin <test-2-${packname_2}.pack >/dev/null &&
+
+	git pack-objects --window=0 --delta-base-offset \
+		--no-ref-delta --stdout <obj-list >reused.pack &&
+	git index-pack -o reused.idx reused.pack &&
+	test-tool pack-deltas --list-deltas reused.idx >deltas &&
+	test_grep " OFS_DELTA " deltas &&
+	test_grep ! " REF_DELTA " deltas
+'
+
 test_expect_success 'pack without REF_DELTA skips excluded delta bases' '
 	test_when_finished "git read-tree $tree" &&
 
@@ -253,7 +267,12 @@ test_expect_success 'pack without REF_DELTA skips excluded delta bases' '
 	test_grep ! " OFS_DELTA " deltas &&
 	test_grep " REF_DELTA " deltas &&
 
-	git pack-objects --thin --stdout --revs \
+	# Store the REF_DELTA entries above and disable delta search below,
+	# so any output delta would have to reuse an excluded-base
+	# REF_DELTA.
+	git index-pack --stdin <thin-fixed.pack >/dev/null &&
+
+	git pack-objects --thin --window=0 --stdout --revs \
 		--delta-base-offset --no-ref-delta \
 		<thin-revs >no-ref-thin.pack &&
 	git index-pack --fix-thin --stdin no-ref-thin-fixed.pack \
diff --git a/t/t5332-multi-pack-reuse.sh b/t/t5332-multi-pack-reuse.sh
index 881ce668e1..bc479653ec 100755
--- a/t/t5332-multi-pack-reuse.sh
+++ b/t/t5332-multi-pack-reuse.sh
@@ -111,6 +111,22 @@ test_expect_success 'reuse all objects from all packs' '
 	test_pack_objects_reused_all 9 3
 '
 
+test_expect_success '--no-ref-delta reuses REF_DELTA-free bitmapped packs' '
+	# Whole-word reuse is unavailable under --no-ref-delta, so reusing
+	# every object below exercises the per-object bitmap path.
+	: >trace2.txt &&
+	GIT_TRACE2_EVENT="$PWD/trace2.txt" \
+		git pack-objects --stdout --revs --all --delta-base-offset \
+		--no-ref-delta >got.pack &&
+
+	test_pack_reused 9 <trace2.txt &&
+	test_packs_reused 3 <trace2.txt &&
+
+	git index-pack --strict -o got.idx got.pack &&
+	test-tool pack-deltas --list-deltas got.idx >deltas &&
+	test_grep ! " REF_DELTA " deltas
+'
+
 test_expect_success 'reuse objects from first pack with middle gap' '
 	for i in D E F
 	do
-- 
2.55.0

