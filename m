Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C96403EBD
	for <git@vger.kernel.org>; Tue, 19 May 2026 16:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779207171; cv=none; b=VWrwwxIXVeoXYa67VTijTv4xZyZ5UBw5Eg7vL587d+KLEeFAZRtNDDJZMsvStwAXl4ZUy012ra+zvTzWLLvOqtY63E/esbO24Ip74lZ/CSbtkpAjiALizvDDXlehECM+iXaLdT8fdiGy/kPdso02ncURUxj3vWfnP1U9XAIDo1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779207171; c=relaxed/simple;
	bh=VsGG81FEV/Xl/3ZIiOjxqIz6zl0IPh5fswGFlZ0SMOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CIZ/OhZ6tgLMThpjIvBQIy36e7Re9bWwpdNs/tSpk9/fEtZvF4epgSxTbRhAxBUWj91D6iHeG+JCwOP6gGfoDqq8/H2uDjY5GwfKrdh8udNutsmKFb5CoC0yvJwmY6QiT/f5FzOB5TYuOTXgPBWxlqC6XA67SGDGKGFA4sD3aWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=I5rtWktQ; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="I5rtWktQ"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7bdec52f48dso30929357b3.0
        for <git@vger.kernel.org>; Tue, 19 May 2026 09:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1779207169; x=1779811969; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uX265uULxHAk/pZszVt9yxaTwFKo1rCP5Q3Ny1TR2rE=;
        b=I5rtWktQ1xsiyzTykNK5KjsPVjKXX0mBAF59eyTJc0+zXv5SE33LKDM7Ax80oYHdsh
         GxtvQixp3fcJl3mz5ngMIofyxgraDZ3X0ivHFClGSQBaOlNqPCt3899xymkKPEl4Umz8
         WymAoVSYosg8RBIwTMu09E5zJ6sPh6c3T1E/C5e/aAxXbHJVHbnIKAfXWzjKhHD1rHS4
         ANqAtFK37IQoeJ4IDoDUF7FjX0wEPrsEN1cAfG+CnRSQXK0umqPZauqUPI7lN50uBgB3
         95CtZ7/ZLsShtRScoyFkHEBV6y9q1mbbycBzEStlNRJvrWBdTpohgiiJla592fNshbzx
         mNVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779207169; x=1779811969;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uX265uULxHAk/pZszVt9yxaTwFKo1rCP5Q3Ny1TR2rE=;
        b=gA8BF/5n55lmgn2W8+ChKT22LLXE0zyE7C33yTU+1fcWYQf/q+oIuublDfQyHeHkcO
         j5FHbSH+3d7hiD488Y4oMJtfvpX4Naz/gEYV2nsFDKjBq0uQ7Fv0zrwI7A6ohEWRTMoK
         wEvDBOktBjTv7j/BSvCGZhbdsC8S03XseQFNc7FnETSwsA9C1mnVqPGaaeiGLv0GKKC+
         oicrfLGXesERVjdwB7li4UxQ4fYhPDVmSoM1gLFMERqrNTl6q8yStMM+d0amL8tT20tv
         /kUyv9yAZBQscGPhAccE7Tp219STrn3hR/2JkeoZ3TtEbOSd7dGPfZfCOPWZTfhoRd9E
         qOGg==
X-Gm-Message-State: AOJu0Yxo7Z+Kd1cQJD0vzSO512IJVbGzeTSVT4XqBh+9BfOgZZgzEuS8
	r9t4VVTgXM+4IFhZtDhagmPt5jqXP6ZIgS5Iiul/psvgkgBIAj7vVJ6pqCm2Rmc8ONH7YAeEE9o
	A+agjPRtuyQ==
X-Gm-Gg: Acq92OG7DhmoPKzg5TQ1Jw9Amx7urQOd8Mq1CXhEsYYZOfPADtUh8RQI8sYwV4YwRW4
	Dre2zkVWzUyGka6W/TxfkIki5K4dAIc8IeT5yZ47Q8+0utJHVpHeB3VbPZKb47MZzfTv8sH3Y4z
	iseJzV1zrl5Ao40q7MKpGXEcs7MIvr+7iIMyyXTDXlB+bGVCU3IaZ8bUvx9rXOTQp+IIJQIcPf/
	f7dWve+KeGQG+M2gKCxa94+YO9QsnuL83an1T3iDWymGdUuiklgIY41Plgoii52Z9jbaP4jSPgW
	+lFzNaBzSgjQxoa+KmmEBol+n9AVMBtDAWQPIm0U42/cYOW7sT9SLXcorqEjFhIli8IDnYLNquG
	lP6k/I63XglMLS8DDJUpUKkC95lM/BcfXeVvY5FxWs7UUnntAMmhEFEyvigZPXZrHOgW6cGdDXx
	c0MDxS5fLCqRF20OHMckc38oS7d2INEZdU0S4fl1peqP7dY83ydV3bBM0GE/CQNkaa+rjnvILqZ
	dvG+0GEBE5s10qYjjIx5fC9h1gKLzkF8J6J46seJHmquP8M7OwOVjJgXquVZX1pV8vaK8FJ5ZHg
	PL6tlgSVQmpQEE0xmEYvmoxZE+o=
X-Received: by 2002:a05:690c:c36b:b0:7ba:ded4:df69 with SMTP id 00721157ae682-7c9463a27d4mr154857767b3.1.1779207168852;
        Tue, 19 May 2026 09:12:48 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7cd0bfdc094sm34710807b3.32.2026.05.19.09.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 09:12:48 -0700 (PDT)
Date: Tue, 19 May 2026 12:12:47 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Derrick Stolee <stolee@gmail.com>
Subject: [PATCH 5/8] pack-bitmap: cache object positions during fill
Message-ID: <e43ef6a42d13578a6b7a4a346f491e51a6edfd14.1779207127.git.me@ttaylorr.com>
References: <cover.1779207127.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1779207127.git.me@ttaylorr.com>

The previous commits removed some redundant work from bitmap generation
by avoiding unnecessary tree recursion and by reusing selected bitmaps
that have already been computed.

Even with those changes in place, there is still an extremely hot path
from `fill_bitmap_commit()` and `fill_bitmap_tree()` to translate object
IDs into their corresponding bit positions in order to generate their
bitmaps.

In a small repository, this overhead is not significant. However, in a
very large repository (e.g., the one that we have been using as a
benchmark over the past several commits with ~57M total objects), the
overhead of locating object bit positions (often repeatedly) adds up
significantly.

Combat this by adding a small, direct-mapped cache to the bitmap writer
which maps object IDs to their corresponding bit positions. Size the
cache according to the number of objects being written, with fixed lower
and upper bounds so small repositories do not pay for a large table and
large repositories can avoid most repeated packlist and MIDX lookups.

On my machine with (a somewhat outdated) GCC 15.2.0, each entry in the
cache is 40 bytes wide:

    $ pahole -C bitmap_pos_cache_entry pack-bitmap-write.o
    struct bitmap_pos_cache_entry {
            struct object_id           oid;                  /*     0    36 */
            uint32_t                   pos;                  /*    36     4 */

            /* size: 40, cachelines: 1, members: 2 */
            /* last cacheline: 40 bytes */
    };

, and we will allocate up to 2^21 entries for a maximum total of 80 MiB
of cache overhead.

In our example repository from above and in earlier commits, this
results in a ~9.4% reduction in runtime relative to the previous commit:

    +------------------+-------------+-------------+---------------------+
    |                  | HEAD^       | HEAD        | Delta               |
    +------------------+-------------+-------------+---------------------+
    | elapsed          |   324.8 s   |   294.1 s   |    -30.7 s  (-9.4%) |
    | cycles           | 1,508.6 B   | 1,365.5 B   |   -143.0 B  (-9.5%) |
    | instructions     | 1,436.6 B   | 1,389.8 B   |    -46.9 B  (-3.3%) |
    | CPI              |     1.050   |     0.983   |   -0.068    (-6.4%) |
    +------------------+-------------+-------------+---------------------+

When generating bitmaps on this repository (to produce the above
timings), the cache grew to its maximum size of 80 MiB, and resulted in
1.024B cache hits and 59.957M cache misses.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap-write.c | 89 ++++++++++++++++++++++++++++++++++++++++++++-
 pack-bitmap.h       |  7 ++++
 2 files changed, 95 insertions(+), 1 deletion(-)

diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 6483fdc7daf..4b6fb07edd7 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -89,6 +89,7 @@ void bitmap_writer_free(struct bitmap_writer *writer)
 	ewah_free(writer->tags);
 
 	kh_destroy_oid_map(writer->bitmaps);
+	free(writer->pos_cache);
 
 	kh_foreach_value(writer->pseudo_merge_commits, idx,
 			 free_pseudo_merge_commit_idx(idx));
@@ -213,14 +214,92 @@ void bitmap_writer_push_commit(struct bitmap_writer *writer,
 	writer->selected_nr++;
 }
 
+struct bitmap_pos_cache_entry {
+	struct object_id oid;
+	uint32_t pos;
+};
+
+#define BITMAP_POS_MIN_CACHE_SIZE (1U << 10)
+#define BITMAP_POS_MAX_CACHE_SIZE (1U << 21)
+#define BITMAP_POS_CACHE_VALID    (1U << 31)
+
+static void bitmap_writer_init_pos_cache(struct bitmap_writer *writer)
+{
+	if (writer->pos_cache)
+		return;
+
+	writer->pos_cache_nr = BITMAP_POS_MIN_CACHE_SIZE;
+
+	while (writer->pos_cache_nr < writer->to_pack->nr_objects &&
+	       writer->pos_cache_nr < BITMAP_POS_MAX_CACHE_SIZE)
+		writer->pos_cache_nr <<= 1;
+
+	CALLOC_ARRAY(writer->pos_cache, writer->pos_cache_nr);
+}
+
+static size_t bitmap_writer_pos_cache_slot(struct bitmap_writer *writer,
+					   const struct object_id *oid)
+{
+	return oidhash(oid) & (writer->pos_cache_nr - 1);
+}
+
+static bool bitmap_writer_pos_cache_valid(struct bitmap_writer *writer,
+					  size_t slot)
+{
+	return !!(writer->pos_cache[slot].pos & BITMAP_POS_CACHE_VALID);
+}
+
+static int find_cached_object_pos(struct bitmap_writer *writer,
+				  const struct object_id *oid, uint32_t *pos)
+{
+	size_t slot = bitmap_writer_pos_cache_slot(writer, oid);
+
+	if (bitmap_writer_pos_cache_valid(writer, slot) &&
+	    oideq(&writer->pos_cache[slot].oid, oid)) {
+		writer->pos_cache_hits++;
+		*pos = writer->pos_cache[slot].pos & ~BITMAP_POS_CACHE_VALID;
+		return 1;
+	}
+
+	writer->pos_cache_misses++;
+	return 0;
+}
+
+static uint32_t store_cached_object_pos(struct bitmap_writer *writer,
+					const struct object_id *oid,
+					uint32_t pos)
+{
+	size_t slot;
+
+	if (pos & BITMAP_POS_CACHE_VALID)
+		return pos; /* too large to cache */
+
+	slot = bitmap_writer_pos_cache_slot(writer, oid);
+
+	oidcpy(&writer->pos_cache[slot].oid, oid);
+	writer->pos_cache[slot].pos = pos | BITMAP_POS_CACHE_VALID;
+
+	return pos;
+}
+
 static uint32_t find_object_pos(struct bitmap_writer *writer,
 				const struct object_id *oid, int *found)
 {
 	struct object_entry *entry;
+	uint32_t pos;
+
+	bitmap_writer_init_pos_cache(writer);
+
+	if (find_cached_object_pos(writer, oid, &pos)) {
+		if (found)
+			*found = 1;
+		return pos;
+	}
 
 	entry = packlist_find(writer->to_pack, oid);
 	if (entry) {
 		uint32_t base_objects = 0;
+
 		if (writer->midx)
 			base_objects = writer->midx->num_objects +
 				writer->midx->num_objects_in_base;
@@ -238,7 +317,7 @@ static uint32_t find_object_pos(struct bitmap_writer *writer,
 
 	if (found)
 		*found = 1;
-	return pos;
+	return store_cached_object_pos(writer, oid, pos);
 
 missing:
 	if (found)
@@ -661,6 +740,10 @@ int bitmap_writer_build(struct bitmap_writer *writer)
 		writer->progress = start_progress(writer->repo,
 						  "Building bitmaps",
 						  writer->selected_nr);
+
+	writer->pos_cache_hits = 0;
+	writer->pos_cache_misses = 0;
+
 	trace2_region_enter("pack-bitmap-write", "building_bitmaps_total",
 			    writer->repo);
 
@@ -725,6 +808,10 @@ int bitmap_writer_build(struct bitmap_writer *writer)
 	trace2_data_intmax("pack-bitmap-write", writer->repo,
 			   "fill_bitmap_commit_found_ancestor_nr",
 			   fill_bitmap_commit_found_ancestor_nr);
+	trace2_data_intmax("pack-bitmap-write", writer->repo,
+			   "bitmap_pos_cache_hits", writer->pos_cache_hits);
+	trace2_data_intmax("pack-bitmap-write", writer->repo,
+			   "bitmap_pos_cache_misses", writer->pos_cache_misses);
 
 	stop_progress(&writer->progress);
 
diff --git a/pack-bitmap.h b/pack-bitmap.h
index a95e1c2d115..19a86554579 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -132,6 +132,8 @@ int bitmap_has_oid_in_uninteresting(struct bitmap_index *, const struct object_i
 
 off_t get_disk_usage_from_bitmap(struct bitmap_index *, struct rev_info *);
 
+struct bitmap_pos_cache_entry;
+
 struct bitmap_writer {
 	struct repository *repo;
 	struct ewah_bitmap *commits;
@@ -143,6 +145,11 @@ struct bitmap_writer {
 	struct packing_data *to_pack;
 	struct multi_pack_index *midx; /* if appending to a MIDX chain */
 
+	struct bitmap_pos_cache_entry *pos_cache;
+	size_t pos_cache_nr;
+	uint64_t pos_cache_hits;
+	uint64_t pos_cache_misses;
+
 	struct bitmapped_commit *selected;
 	unsigned int selected_nr, selected_alloc;
 
-- 
2.54.0.rc1.84.g30ce254312c

