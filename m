Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143311494A8
	for <git@vger.kernel.org>; Tue, 21 May 2024 19:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716318199; cv=none; b=gtbcXCcFteX0/a30T1wRu3qbUefjL+jpD9NyFJVMsT+o9d5rtrRVCG6GH0Bicy06pXs854G5lz93EvZpcyfzXFLSR3Qb9h1WQj5ixMnZK9zxx1IM62Db8KDQhRAkXb7aRHjcNw+aKtffhMiLDWLGzhXbqtjiAYIQ0nuxL7Ad4RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716318199; c=relaxed/simple;
	bh=R775myxDJ2a/Bjt+zbdzTtsD1I50QRDSXuM/YmxVnaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T3D1lvJkAev4f7KOgbt30YG0/G5B11wUFzyBve30mno7UUvg8WbjU+WHag7OcKcIMQn5owmsFF0OXT/Jv+n82l0OyBVgIuv7PvOeAKcLfga/DXqII8VqPj3aC0N7EcdRXEGWCxm7RXaabunrcwPTPqUjuPRsewWRyJaWXRjJNFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=cCGxfTp2; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="cCGxfTp2"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3c999d53e04so2780311b6e.2
        for <git@vger.kernel.org>; Tue, 21 May 2024 12:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1716318196; x=1716922996; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JxSBRCRT7r2wVAdYg/vfLSPh2bkl2kJpGHC6pnStocY=;
        b=cCGxfTp2EbpYe5XAtWcHvaGAFoSy0tCTM1IjIK8WuJAczNrrY7M5uTPnKUt/eGFWAQ
         eufVJQz2Tl+tha+72eXeCu3xFSDAHdj6zQ88tiaZVfMh3FI0OSz+YDr9Xf4pDQ60Exzh
         YQ8cXShuIImxQ9h5n6U7yY8KBJQN02qkbMVv9Y8DZjF82zBzKpch27z7tpgrwmdy2Blw
         KppNgNbNr61IP8q8muvkQ0jcMwFcTx+Qv1opRpMufCqt0S9XSIfFRlR1JdY2EErvW8uo
         Xz3HDTfGtM76puPXhR7iTaYSGkMawZxGQWXge5jdlQMDLUEFp/+jetad3qHfRNxVpJ76
         /oRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716318196; x=1716922996;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JxSBRCRT7r2wVAdYg/vfLSPh2bkl2kJpGHC6pnStocY=;
        b=H5SzN8mmeKt6HoLdJ3PGDocLFpX6Vlibkjrvjm4YwzEl41lDQsJ5IzqIdKNV+3NnR8
         /EE1VMw5TigmTMTD3bpJAWeoGsduMIWGQNmXQGwr2Mzj0wSilk6gUvxPmOazFXAzwT0h
         /mpYoH0YOYynl+CuqcuFd/aTqrWAHs+jY1d3BCv3bNg9J3808gK2z+CCh7dHIgWneTkP
         8wzgd2Qo4xD/bKcPmZGQ+4yCdY2vRSvMY8hpe+DkiVJgGwJWHpzaKRjQ930t/Y56+OPq
         d7wkMmcqih/WDWdw26ir+d0PBn3Poq8GtpfeLlhDXWmZXVK68DFvMuW9TLEw9pckEobR
         JxNg==
X-Gm-Message-State: AOJu0YwoyqpX9vL/TZpfl0Cm1HQBgTTZ4rGYoFPCGgg79Pj1VHIL5l3H
	lx1DayLASP0L1+1xPi5WQw1MhaCbHaDG+6l/YztjnY4IPDjA4vMs+Y8bepyR4FYgOljl6h7VFQW
	Z
X-Google-Smtp-Source: AGHT+IHIFdWR0woO2xKa1JXH8/wCJUS4jlI00LhbnWNI+ot3XLSX2elK2eE9FKqAlN7z35XwOWvH8w==
X-Received: by 2002:a05:6808:116:b0:3c8:47a3:3cb5 with SMTP id 5614622812f47-3cdb432fc1fmr10910b6e.24.1716318196235;
        Tue, 21 May 2024 12:03:16 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79484010bcdsm231672785a.133.2024.05.21.12.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 12:03:15 -0700 (PDT)
Date: Tue, 21 May 2024 15:03:14 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 29/30] pseudo-merge: implement support for finding
 existing merges
Message-ID: <ff21247281ff1c1bd1bb83947cae819e7fc92589.1716318089.git.me@ttaylorr.com>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1716318088.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1716318088.git.me@ttaylorr.com>

This patch implements support for reusing existing pseudo-merge commits
when writing bitmaps when there is an existing pseudo-merge bitmap which
has exactly the same set of parents as one that we are about to write.

Note that unstable pseudo-merges are likely to change between
consecutive repacks, and so are generally poor candidates for reuse.
However, stable pseudo-merges (see the configuration option
'bitmapPseudoMerge.<name>.stableThreshold') are by definition unlikely
to change between runs (as they represent long-running branches).

Because there is no index from a *set* of pseudo-merge parents to a
matching pseudo-merge bitmap, we have to construct the bitmap
corresponding to the set of parents for each pending pseudo-merge commit
and see if a matching bitmap exists.

This is technically quadratic in the number of pseudo-merges, but is OK
in practice for a couple of reasons:

  - non-matching pseudo-merge bitmaps are rejected quickly as soon as
    they differ in a single bit

  - already-matched pseudo-merge bitmaps are discarded from subsequent
    rounds of search

  - the number of pseudo-merges is generally small, even for large
    repositories

In order to do this, implement (a) a function that finds a matching
pseudo-merge given some uncompressed bitset describing its parents, (b)
a function that computes the bitset of parents for a given pseudo-merge
commit, and (c) call that function before computing the set of reachable
objects for some pending pseudo-merge.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap-write.c             | 15 ++++++--
 pack-bitmap.c                   | 32 +++++++++++++++++
 pack-bitmap.h                   |  2 ++
 pseudo-merge.c                  | 55 ++++++++++++++++++++++++++++
 pseudo-merge.h                  |  7 ++++
 t/t5333-pseudo-merge-bitmaps.sh | 64 +++++++++++++++++++++++++++++++++
 6 files changed, 173 insertions(+), 2 deletions(-)

diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 47250398aa2..6e8060f8a0b 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -19,6 +19,10 @@
 #include "tree-walk.h"
 #include "pseudo-merge.h"
 #include "oid-array.h"
+#include "config.h"
+#include "alloc.h"
+#include "refs.h"
+#include "strmap.h"
 
 struct bitmapped_commit {
 	struct commit *commit;
@@ -465,6 +469,7 @@ static int fill_bitmap_tree(struct bitmap_writer *writer,
 }
 
 static int reused_bitmaps_nr;
+static int reused_pseudo_merge_bitmaps_nr;
 
 static int fill_bitmap_commit(struct bitmap_writer *writer,
 			      struct bb_commit *ent,
@@ -490,7 +495,7 @@ static int fill_bitmap_commit(struct bitmap_writer *writer,
 			struct bitmap *remapped = bitmap_new();
 
 			if (commit->object.flags & BITMAP_PSEUDO_MERGE)
-				old = NULL;
+				old = pseudo_merge_bitmap_for_commit(old_bitmap, c);
 			else
 				old = bitmap_for_commit(old_bitmap, c);
 			/*
@@ -501,7 +506,10 @@ static int fill_bitmap_commit(struct bitmap_writer *writer,
 			if (old && !rebuild_bitmap(mapping, old, remapped)) {
 				bitmap_or(ent->bitmap, remapped);
 				bitmap_free(remapped);
-				reused_bitmaps_nr++;
+				if (commit->object.flags & BITMAP_PSEUDO_MERGE)
+					reused_pseudo_merge_bitmaps_nr++;
+				else
+					reused_bitmaps_nr++;
 				continue;
 			}
 			bitmap_free(remapped);
@@ -631,6 +639,9 @@ int bitmap_writer_build(struct bitmap_writer *writer,
 			    the_repository);
 	trace2_data_intmax("pack-bitmap-write", the_repository,
 			   "building_bitmaps_reused", reused_bitmaps_nr);
+	trace2_data_intmax("pack-bitmap-write", the_repository,
+			   "building_bitmaps_pseudo_merge_reused",
+			   reused_pseudo_merge_bitmaps_nr);
 
 	stop_progress(&writer->progress);
 
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 1966b3b95f1..70230e26479 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1316,6 +1316,37 @@ static struct bitmap *find_boundary_objects(struct bitmap_index *bitmap_git,
 	return cb.base;
 }
 
+struct ewah_bitmap *pseudo_merge_bitmap_for_commit(struct bitmap_index *bitmap_git,
+						   struct commit *commit)
+{
+	struct commit_list *p;
+	struct bitmap *parents;
+	struct pseudo_merge *match = NULL;
+
+	if (!bitmap_git->pseudo_merges.nr)
+		return NULL;
+
+	parents = bitmap_new();
+
+	for (p = commit->parents; p; p = p->next) {
+		int pos = bitmap_position(bitmap_git, &p->item->object.oid);
+		if (pos < 0 || pos >= bitmap_num_objects(bitmap_git))
+			goto done;
+
+		bitmap_set(parents, pos);
+	}
+
+	match = pseudo_merge_for_parents(&bitmap_git->pseudo_merges,
+						parents);
+
+done:
+	bitmap_free(parents);
+	if (match)
+		return pseudo_merge_bitmap(&bitmap_git->pseudo_merges, match);
+
+	return NULL;
+}
+
 static void unsatisfy_all_pseudo_merges(struct bitmap_index *bitmap_git)
 {
 	uint32_t i;
@@ -2809,6 +2840,7 @@ void free_bitmap_index(struct bitmap_index *b)
 		 */
 		close_midx_revindex(b->midx);
 	}
+	free_pseudo_merge_map(&b->pseudo_merges);
 	free(b);
 }
 
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 4466b5ad0fb..1171e6d9893 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -142,6 +142,8 @@ int rebuild_bitmap(const uint32_t *reposition,
 		   struct bitmap *dest);
 struct ewah_bitmap *bitmap_for_commit(struct bitmap_index *bitmap_git,
 				      struct commit *commit);
+struct ewah_bitmap *pseudo_merge_bitmap_for_commit(struct bitmap_index *bitmap_git,
+						   struct commit *commit);
 void bitmap_writer_select_commits(struct bitmap_writer *writer,
 				  struct commit **indexed_commits,
 				  unsigned int indexed_commits_nr);
diff --git a/pseudo-merge.c b/pseudo-merge.c
index 0f50ac6183e..36a617f64e6 100644
--- a/pseudo-merge.c
+++ b/pseudo-merge.c
@@ -695,3 +695,58 @@ int cascade_pseudo_merges(const struct pseudo_merge_map *pm,
 
 	return ret;
 }
+
+struct pseudo_merge *pseudo_merge_for_parents(const struct pseudo_merge_map *pm,
+					      struct bitmap *parents)
+{
+	struct pseudo_merge *match = NULL;
+	size_t i;
+
+	if (!pm->nr)
+		return NULL;
+
+	/*
+	 * NOTE: this loop is quadratic in the worst-case (where no
+	 * matching pseudo-merge bitmaps are found), but in practice
+	 * this is OK for a few reasons:
+	 *
+	 *   - Rejecting pseudo-merge bitmaps that do not match the
+	 *     given commit is done quickly (i.e. `bitmap_equals_ewah()`
+	 *     returns early when we know the two bitmaps aren't equal.
+	 *
+	 *   - Already matched pseudo-merge bitmaps (which we track with
+	 *     the `->satisfied` bit here) are skipped as potential
+	 *     candidates.
+	 *
+	 *   - The number of pseudo-merges should be small (in the
+	 *     hundreds for most repositories).
+	 *
+	 * If in the future this semi-quadratic behavior does become a
+	 * problem, another approach would be to keep track of which
+	 * pseudo-merges are still "viable" after enumerating the
+	 * pseudo-merge commit's parents:
+	 *
+	 *   - A pseudo-merge bitmap becomes non-viable when the bit(s)
+	 *     corresponding to one or more parent(s) of the given
+	 *     commit are not set in a candidate pseudo-merge's commits
+	 *     bitmap.
+	 *
+	 *   - After processing all bits, enumerate the remaining set of
+	 *     viable pseudo-merge bitmaps, and check that their
+	 *     popcount() matches the number of parents in the given
+	 *     commit.
+	 */
+	for (i = 0; i < pm->nr; i++) {
+		struct pseudo_merge *candidate = use_pseudo_merge(pm, &pm->v[i]);
+		if (!candidate || candidate->satisfied)
+			continue;
+		if (!bitmap_equals_ewah(parents, candidate->commits))
+			continue;
+
+		match = candidate;
+		match->satisfied = 1;
+		break;
+	}
+
+	return match;
+}
diff --git a/pseudo-merge.h b/pseudo-merge.h
index c00b622be4b..62fde979015 100644
--- a/pseudo-merge.h
+++ b/pseudo-merge.h
@@ -206,4 +206,11 @@ int cascade_pseudo_merges(const struct pseudo_merge_map *pm,
 			  struct bitmap *result,
 			  struct bitmap *roots);
 
+/*
+ * Returns a pseudo-merge which contains the exact set of commits
+ * listed in the "parents" bitamp, or NULL if none could be found.
+ */
+struct pseudo_merge *pseudo_merge_for_parents(const struct pseudo_merge_map *pm,
+					      struct bitmap *parents);
+
 #endif
diff --git a/t/t5333-pseudo-merge-bitmaps.sh b/t/t5333-pseudo-merge-bitmaps.sh
index 3a7dc7278a7..7ae4b7a35b7 100755
--- a/t/t5333-pseudo-merge-bitmaps.sh
+++ b/t/t5333-pseudo-merge-bitmaps.sh
@@ -22,6 +22,10 @@ test_pseudo_merges_cascades () {
 	test_trace2_data bitmap pseudo_merges_cascades "$1"
 }
 
+test_pseudo_merges_reused () {
+	test_trace2_data pack-bitmap-write building_bitmaps_pseudo_merge_reused "$1"
+}
+
 tag_everything () {
 	git rev-list --all --no-object-names >in &&
 	perl -lne '
@@ -320,4 +324,64 @@ test_expect_success 'pseudo-merge overlap stale traversal' '
 	)
 '
 
+test_expect_success 'pseudo-merge reuse' '
+	git init pseudo-merge-reuse &&
+	(
+		cd pseudo-merge-reuse &&
+
+		stable="1641013200" && # 2022-01-01
+		unstable="1672549200" && # 2023-01-01
+
+		for date in $stable $unstable
+		do
+			test_commit_bulk --date "$date +0000" 128 &&
+			test_tick || return 1
+		done &&
+
+		tag_everything &&
+
+		git \
+			-c bitmapPseudoMerge.test.pattern="refs/tags/" \
+			-c bitmapPseudoMerge.test.maxMerges=1 \
+			-c bitmapPseudoMerge.test.threshold=now \
+			-c bitmapPseudoMerge.test.stableThreshold=$(($unstable - 1)) \
+			-c bitmapPseudoMerge.test.stableSize=512 \
+			repack -adb &&
+
+		test_pseudo_merges >merges &&
+		test_line_count = 2 merges &&
+
+		test_pseudo_merge_commits 0 >stable-oids.before &&
+		test_pseudo_merge_commits 1 >unstable-oids.before &&
+
+		: >trace2.txt &&
+		GIT_TRACE2_EVENT=$PWD/trace2.txt git \
+			-c bitmapPseudoMerge.test.pattern="refs/tags/" \
+			-c bitmapPseudoMerge.test.maxMerges=2 \
+			-c bitmapPseudoMerge.test.threshold=now \
+			-c bitmapPseudoMerge.test.stableThreshold=$(($unstable - 1)) \
+			-c bitmapPseudoMerge.test.stableSize=512 \
+			repack -adb &&
+
+		test_pseudo_merges_reused 1 <trace2.txt &&
+
+		test_pseudo_merges >merges &&
+		test_line_count = 3 merges &&
+
+		test_pseudo_merge_commits 0 >stable-oids.after &&
+		for i in 1 2
+		do
+			test_pseudo_merge_commits $i || return 1
+		done >unstable-oids.after &&
+
+		sort -u <stable-oids.before >expect &&
+		sort -u <stable-oids.after >actual &&
+		test_cmp expect actual &&
+
+		sort -u <unstable-oids.before >expect &&
+		sort -u <unstable-oids.after >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_done
-- 
2.45.1.175.gbea44add9db

