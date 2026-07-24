Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C952E3D45EA
	for <git@vger.kernel.org>; Fri, 24 Jul 2026 21:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784927204; cv=none; b=OYH+XqzLGcqTg2/Ntg093lnVvbqXwyiXmdVaOIrwHqxDdZ+/MwMepDM0Q9oK/E4ePseDGEJPHuBP9t8KmMI/nvnjacMrk5PJSaouF8hWp+kBnr7Ok5IGx7Y8OG4in34qn3eNyQNt6cT5MMA5UHFok1STPAOwbuqVashVnIrpYRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784927204; c=relaxed/simple;
	bh=10qUxV21gdulCQVAdkku01/pf5S8kAc/G/L+Be5SRDs=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TonVKy5AYmD+r4YxTFR0Mu6UOkWV6UAnhymod8VDMPw2ZzUZz5f6q6j+/8PS70t3bPGbnxFWCGp22AhZmEmNN8r7knuU1GFKx8q/CNruNPEEx5XTGCLWXRwaXfPFtqtSfPY0iZTqoxkY0y840aSLxoMMtTuAlLR4zx8kQbqy+3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=AWAntq7B; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="AWAntq7B"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-81ed2a00f12so8491497b3.2
        for <git@vger.kernel.org>; Fri, 24 Jul 2026 14:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1784927188; x=1785531988; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:to:from:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D9276qHvckLvfeWOrEMTTmgOze/8NQRCzZBbnlihjcg=;
        b=AWAntq7Bdd7giD5aDHWbyHc3QGkNKSPffTarA4Ku1O+WmYVIf5oCHyQDLl80WEGGiO
         8ofnqn6873xgIqDwKfIjjmtIZckonQD50ISzbR3TTY3qXCyfAlX7cBtCqnjeLgxVCuCW
         ebQ/NY6KQHRkvAelcmHmCLlU/OFyU34a7Bz3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784927188; x=1785531988;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D9276qHvckLvfeWOrEMTTmgOze/8NQRCzZBbnlihjcg=;
        b=pqIyQiCR7cZ/dBruvuXKV2+X5104Sib06LhygphnnFzzlTGtsfGhIOW7ROx4fmidqZ
         J+OHL913SSTiTbsXvcY2lQNWgYRA7ZIr0F/DXeZyIxSj1elkbmxcqipGdopH0Ix/93DQ
         s5/y7MHpCALTPM2s8mmeJOJ7/bQNp5ck8afWV1clXZPbmtrIRqKOlI8TJ6Io9xRAj07x
         rswfnEOgwnGXfeJCD+sU/QG9v0ZzzZmgcMvgQDuSzQhT/fSPRF/8SWg1eCS01lnBXFyk
         iabFrHJccAUu9WlwbUCshRfKSD6X3rwci3VdkB+Ygkj7cvvpgjvEObkN7pjOwJYIkZcS
         72yA==
X-Gm-Message-State: AOJu0YyenIVWFZGsJKRnesAgokeeyxeH7pZmqu02/EtR0rpKN57gHLBP
	XE7L3a88y3DeUvTMNwF+Nr/MSwws0FI6L3MhcIKlrhUJ+IYSpZG5E9yEirAuFk2mXHf9Dn4X4oj
	rjKs1jbA=
X-Gm-Gg: AR+sD1171/mDDmDb0usfOji3L/FZ6BuyiBjsu1H2q7UhMDr9gwUibHQWNfLUgXLgwGl
	A6i+CN0tUcGTf/zSwY6ewD1scNp0cLBr4Jyo9klcxBqi5Qnl223yUaJ85Ddi2/LzORU44kbF1qT
	hbBHQWnWbcidli/73B31hPIsY448jWpnAEs3oJP7TcKRnQPifcEQAwMEWlp+CLNrET4oWitcguN
	OhzhiB1CMpoK6M04JmZGl88Yn+/qm47rDvqN4lxQL5xkPiDw8OYjVfAeHSlKvGm8TjEhkq0n3E9
	psdS6+uxlslJBApcNEjFFA7haCF4Iq9mbu/HvA1AKl4Zjsqh1DmFDVij5n6qtHhLPUt+i3mO7HS
	cmc+f11l9k9KOoNU4PrHNFAF0YnFZPKrMwJLsMRvrx36vU12RfUUiMLlio8N7GV8K2CxrknHRgC
	BKmps4t/aI+KLyFYkQ+z43zc4xAQK8IAszz6Cxc7ABk7gkNFBTmCCoFCMRR3rttgAc34OEQcA7g
	GHESCPG/fO5jIKND5MeEEVMFB686iAhVKKFE4bMSWnW
X-Received: by 2002:a05:690c:c93:b0:81f:3800:606 with SMTP id 00721157ae682-81f69d07289mr446437b3.16.1784927188283;
        Fri, 24 Jul 2026 14:06:28 -0700 (PDT)
Received: from com-79390 (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f6590119asm5348027b3.37.2026.07.24.14.06.26
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 14:06:27 -0700 (PDT)
Date: Fri, 24 Jul 2026 16:06:24 -0500
From: Taylor Blau <ttaylorr@openai.com>
To: git@vger.kernel.org
Subject: [PATCH 5/5] pack-bitmap: handle duplicate pack entries during MIDX
 reuse
Message-ID: <de07827a19dcab2dc3447017718f45cc51541b92.1784927134.git.ttaylorr@openai.com>
References: <cover.1784927134.git.ttaylorr@openai.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1784927134.git.ttaylorr@openai.com>

A MIDX pseudo-pack assigns one bit position to each selected OID. Its
preferred-pack fast paths handle duplicate OIDs across packs in the
MIDX, where the MIDX chooses one copy, but assume that each individual
pack contains one entry per OID.

Consider a preferred pack ordered [A, B, A, C]. The MIDX retains one
copy of A, leaving three pseudo-pack positions for four physical
entries. This creates two problems:

 - In MIDX-backed single-pack reuse, bitmap_nr came from
   pack->num_objects and therefore counted both copies of A. Read the
   selected count from the root MIDX layer BTMP chunk instead. If that
   layer has no BTMP chunk, skip pack reuse and let the ordinary packing
   path handle the bitmap-selected objects. MIDXs without BTMP lose
   preferred-pack reuse until rewritten, rather than requiring a scan of
   the entire pseudo-pack to retain an optional optimization.

 - Correcting the range length still does not align the two orderings.
   Once one copy of A is omitted, MIDX position N need not name physical
   pack entry N.

That mismatch matters during both selection and output. Whole-word
selection bypasses the per-object check that the exact physical base of
a delta is present. Verbatim reuse copies the first N pack entries for
the first N bits. The per-object writer likewise used each bit as a
physical pack position.

Use the direct mapping only when the range begins at zero and its
selected count equals the physical entry count. Since selected entries
remain in pack-offset order, equal counts mean that none was omitted and
the two positions coincide.

For every other MIDX range, let whole-word selection fall through to
the existing per-bit path, which resolves the selected MIDX offset to a
physical pack position before checking the delta base. Disable verbatim
prefix reuse, and perform the same translation in the per-object writer.

Leave classic single-pack bitmap handling unchanged. The production
writer creates those bitmaps only for the pack it just wrote, which has
one entry per OID. The test helper can target an existing pack, but
rejects duplicate OIDs.

Cover the A, B, A, C case in a MIDX-backed preferred pack. Check reuse
with BTMP, then hide BTMP and check that the optional reuse path is
skipped. Also make B a delta against the omitted copy of A and require
normal packing to handle it.

Signed-off-by: Taylor Blau <ttaylorr@openai.com>
---
 builtin/pack-objects.c      | 24 +++++-----
 pack-bitmap.c               | 27 ++++++++++-
 t/t5332-multi-pack-reuse.sh | 89 +++++++++++++++++++++++++++++++++++++
 3 files changed, 125 insertions(+), 15 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 3673b14b89..c333922961 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1182,12 +1182,12 @@ static size_t write_reused_pack_verbatim(struct bitmapped_pack *reuse_packfile,
 	size_t pos = 0;
 	size_t end;
 
-	if (reuse_packfile->bitmap_pos) {
+	if (reuse_packfile->bitmap_pos ||
+	    reuse_packfile->bitmap_nr != reuse_packfile->p->num_objects) {
 		/*
-		 * We can't reuse whole chunks verbatim out of
-		 * non-preferred packs since we can't guarantee that
-		 * all duplicate objects were resolved in favor of
-		 * that pack.
+		 * We can't reuse whole chunks verbatim from non-preferred
+		 * packs or packs with entries missing from the bitmap because
+		 * bitmap and pack positions may differ.
 		 *
 		 * Even if we have a whole eword_t worth of bits that
 		 * could be reused, there may be objects between the
@@ -1196,7 +1196,7 @@ static size_t write_reused_pack_verbatim(struct bitmapped_pack *reuse_packfile,
 		 * pack, causing us to send duplicate or unwanted
 		 * objects.
 		 *
-		 * Handle non-preferred packs from within
+		 * Handle these packs from within
 		 * write_reused_pack(), which inspects and reuses
 		 * individual bits.
 		 */
@@ -1263,20 +1263,18 @@ static void write_reused_pack(struct bitmapped_pack *reuse_packfile,
 			if (pos + offset >= reuse_packfile->bitmap_pos + reuse_packfile->bitmap_nr)
 				goto done;
 
-			if (reuse_packfile->bitmap_pos) {
+			if (reuse_packfile->bitmap_pos ||
+			    reuse_packfile->bitmap_nr != reuse_packfile->p->num_objects) {
 				/*
-				 * When doing multi-pack reuse on a
-				 * non-preferred pack, translate bit positions
-				 * from the MIDX pseudo-pack order back to their
-				 * pack-relative positions before attempting
-				 * reuse.
+				 * Translate MIDX bitmap positions which do not
+				 * correspond directly to physical pack positions.
 				 */
 				struct multi_pack_index *m = reuse_packfile->from_midx;
 				uint32_t midx_pos;
 				off_t pack_ofs;
 
 				if (!m)
-					BUG("non-zero bitmap position without MIDX");
+					BUG("cannot translate bitmap position without MIDX");
 
 				midx_pos = pack_pos_to_midx(m, pos + offset);
 				pack_ofs = nth_midxed_offset(m, midx_pos);
diff --git a/pack-bitmap.c b/pack-bitmap.c
index d8dc4ae8d1..8141290436 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -2383,7 +2383,8 @@ static void reuse_partial_packfile_from_bitmap_1(struct bitmap_index *bitmap_git
 	struct pack_window *w_curs = NULL;
 	size_t pos = pack->bitmap_pos / BITS_IN_EWORD;
 
-	if (!pack->bitmap_pos) {
+	if (!pack->bitmap_pos &&
+	    pack->bitmap_nr == pack->p->num_objects) {
 		/*
 		 * If we're processing the first (in the case of a MIDX, the
 		 * preferred pack) or the only (in the case of single-pack
@@ -2399,6 +2400,9 @@ static void reuse_partial_packfile_from_bitmap_1(struct bitmap_index *bitmap_git
 		 *   all ties are broken in favor of that pack (i.e. the one
 		 *   we're currently processing). So any duplicate bases will be
 		 *   resolved in favor of the pack we're processing.
+		 *
+		 * The range must also contain every physical pack entry so that
+		 * bitmap and pack positions correspond.
 		 */
 		while (pos < result->word_alloc &&
 		       pos < pack->bitmap_nr / BITS_IN_EWORD &&
@@ -2527,14 +2531,26 @@ void reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
 	} else {
 		struct packed_git *pack;
 		uint32_t pack_int_id;
+		uint32_t bitmap_nr;
 
 		if (bitmap_is_midx(bitmap_git)) {
+			struct bitmapped_pack bitmapped_pack;
 			struct multi_pack_index *m = bitmap_git->midx;
 			uint32_t preferred_pack_pos;
 
 			while (m->base_midx)
 				m = m->base_midx;
 
+			if (!m->chunk_bitmapped_packs) {
+				/*
+				 * Without BTMP, determining the preferred
+				 * pack's range requires scanning the pseudo-pack.
+				 * Skip reuse and leave the bitmap result for
+				 * normal packing.
+				 */
+				return;
+			}
+
 			if (midx_preferred_pack(m, &preferred_pack_pos) < 0) {
 				warning(_("unable to compute preferred pack, disabling pack-reuse"));
 				return;
@@ -2542,6 +2558,12 @@ void reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
 
 			pack = nth_midxed_pack(m, preferred_pack_pos);
 			pack_int_id = preferred_pack_pos;
+
+			if (nth_bitmapped_pack(m, &bitmapped_pack,
+					       pack_int_id) < 0)
+				return;
+			pack = bitmapped_pack.p;
+			bitmap_nr = bitmapped_pack.bitmap_nr;
 		} else {
 			pack = bitmap_git->pack;
 			/*
@@ -2554,13 +2576,14 @@ void reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
 			 * that we do not expect to read this field.
 			 */
 			pack_int_id = -1;
+			bitmap_nr = pack->num_objects;
 		}
 
 		if (is_pack_valid(pack)) {
 			ALLOC_GROW(packs, packs_nr + 1, packs_alloc);
 			packs[packs_nr].p = pack;
 			packs[packs_nr].pack_int_id = pack_int_id;
-			packs[packs_nr].bitmap_nr = pack->num_objects;
+			packs[packs_nr].bitmap_nr = bitmap_nr;
 			packs[packs_nr].bitmap_pos = 0;
 			packs[packs_nr].from_midx = bitmap_git->midx;
 			packs_nr++;
diff --git a/t/t5332-multi-pack-reuse.sh b/t/t5332-multi-pack-reuse.sh
index 881ce668e1..126ab9df99 100755
--- a/t/t5332-multi-pack-reuse.sh
+++ b/t/t5332-multi-pack-reuse.sh
@@ -4,6 +4,7 @@ test_description='pack-objects multi-pack reuse'
 
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-bitmap.sh
+. "$TEST_DIRECTORY"/lib-pack.sh
 
 GIT_TEST_MULTI_PACK_INDEX=0
 GIT_TEST_MULTI_PACK_INDEX_WRITE_INCREMENTAL=0
@@ -32,6 +33,14 @@ pack_position () {
 	grep "$1" objects | cut -d" " -f1
 }
 
+# B as an OFS_DELTA against A at the given one-byte distance.
+pack_obj_b_ofs_a () {
+	pack_obj "$B" "$A" >b-ref.tmp &&
+	printf "\145" &&
+	printf "\\$(printf "%03o" "$1")" &&
+	dd if=b-ref.tmp bs=1 skip=$((1 + $(test_oid rawsz))) 2>/dev/null
+}
+
 # test_pack_objects_reused_all <pack-reused> <packs-reused>
 test_pack_objects_reused_all () {
 	: >trace2.txt &&
@@ -288,4 +297,84 @@ test_expect_success 'duplicate objects with verbatim reuse' '
 	)
 '
 
+test_expect_success 'reuse with intra-pack duplicate objects' '
+	git init intra-pack-duplicate-objects &&
+	(
+		cd intra-pack-duplicate-objects &&
+
+		# Make enough objects to exercise whole-word reuse.
+		test_commit_bulk 20 &&
+		test_commit --printf A a "\7\0" &&
+		test_commit --printf B b "\7\76" &&
+
+		objects_nr=$(git rev-list --count --objects --all) &&
+		git rev-list --objects --all |
+		cut -d" " -f1 >objects &&
+		A=$(test_oid packlib_7_0) &&
+		B=$(test_oid packlib_7_76) &&
+		grep -v -e "^$A$" -e "^$B$" objects >rest &&
+		pack_obj "$A" >a-full &&
+		pack_obj "$B" >b-full &&
+		while read oid
+		do
+			pack_obj "$oid" || exit 1
+		done <rest >rest.entries &&
+		{
+			# Arrange the pack as A, B, A, C..., so that physical
+			# positions diverge from MIDX pseudo-pack order.
+			pack_header $((objects_nr + 1)) &&
+			cat a-full b-full a-full rest.entries
+		} >duplicate.pack &&
+		pack_trailer duplicate.pack &&
+		clear_packs &&
+		git index-pack --stdin <duplicate.pack &&
+
+		git multi-pack-index write --bitmap &&
+		git config pack.allowPackReuse single &&
+		test_pack_objects_reused_all "$objects_nr" 1 &&
+		rm -f got.idx &&
+		test_env GIT_TEST_MIDX_READ_BTMP=false \
+			test_pack_objects_reused_all 0 0
+	)
+'
+
+test_expect_success 'omit delta whose duplicate base is not selected' '
+	(
+		cd intra-pack-duplicate-objects &&
+
+		A=$(test_oid packlib_7_0) &&
+		B=$(test_oid packlib_7_76) &&
+		objects_nr=$(wc -l <objects) &&
+
+		a_size=$(wc -c <a-full) &&
+		test "$((2 * a_size))" -lt 128 &&
+
+		# The .idx order of duplicate OIDs is unspecified. Try a delta
+		# against each copy and keep the pack whose base was omitted.
+		for distance in "$((2 * a_size))" "$a_size"
+		do
+			base_offset=$((12 + 2 * a_size - distance)) &&
+			pack_obj_b_ofs_a "$distance" >b-delta &&
+			{
+				pack_header "$((objects_nr + 1))" &&
+				cat a-full a-full b-delta rest.entries
+			} >candidate.pack &&
+			pack_trailer candidate.pack &&
+			clear_packs &&
+			git index-pack --stdin <candidate.pack &&
+			git multi-pack-index write --bitmap || return 1
+
+			selected_offset=$(
+				test-tool read-midx --show-objects "$objdir" |
+				awk -v oid="$A" "\$1 == oid { print \$2 }"
+			) || return 1
+			test -n "$selected_offset" || return 1
+			test "$selected_offset" = "$base_offset" || break
+		done &&
+		test "$selected_offset" != "$base_offset" &&
+
+		test_pack_objects_reused_all "$((objects_nr - 1))" 1
+	)
+'
+
 test_done
-- 
2.55.0.383.gde07827a19
