Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3793769F0
	for <git@vger.kernel.org>; Tue, 19 May 2026 16:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779207160; cv=none; b=cYeXYn87MhzhgxPONVyg1CNZlD4EIuwMA/Qm3YYIFB7aoU2YzcYKIUMeJW48WBeAgNDMvOGQwgTybJerJIXAzbkyHeRzi7vkHeMtXk20TKhLkr9CECVybFeqkRBkbGCXbjZYVPC+Dd4HbMIJ5fkxopxHsrP4QF9tByDXl+zIRLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779207160; c=relaxed/simple;
	bh=MdFaJH5XunxWJk95oZFF8ComNXAw6Io3/6q1Qd7hRw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rFjZ1NWJ/ZAF4ETH1SaW/3KUGC8iQlIwh8DrTSUyduhydn8sQMlJVbaD6bWXGUtcw2rRzegIvj6zhmGS+Be3WnzenrWnUkSmdBDaoRC0AgvEZNgeiommcbjopK4cl52DKk3yTQcj03quGmbIkMLlCDnYJIsD5qdTQ+MOdwKc2TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=LuVxDGx5; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="LuVxDGx5"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7bf0b1a47b1so34712237b3.0
        for <git@vger.kernel.org>; Tue, 19 May 2026 09:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1779207157; x=1779811957; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ejFP0Kj21EjfIgt8F66zxGWWCnqOqrdeuDCZFtQ/vZw=;
        b=LuVxDGx5yV8fq58n1coOtM+69o6JqzMVRsVc/pkYzx+vVYP60RQcG5rOVffZHvJDKx
         +M290IiUnIxn2VPfo4ySfp+kAMyMW0OELwX0khzzyee3qrEaALw/zxKeB3z0qjUDKLE9
         fdzyMpyp9O0jdNJkfHAt2gAHxJm+Wzl2+9olgeuhbxh3DqEWd7mrXlXfQEsuYAMs2nbM
         xbDDBjMQCVmfNeF9MmaTWY9+WFhMxA+wtID9DqFt2YtIg9jTQQPFmKXjaNgtnUto/jJz
         qEVSlRlAkLDL3o6x1U5rPj+0O2nSSb1a754duI7ZNAMCuj1EnpyB54h5PNrvdcvkHZAa
         82uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779207157; x=1779811957;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ejFP0Kj21EjfIgt8F66zxGWWCnqOqrdeuDCZFtQ/vZw=;
        b=ow48EGP69c4T27Q7CdQ6hWGdSowNQ9xYESqI/7ARTF86tAacpBCITuAX3w2NwUtbT5
         PzdK1/EC1quY5ughRzd24IedYnwmA7fzRJS/WHLRJQkVPhdjJq50Nat0pvzXM0zjnyke
         yRVOmgIT7/Cx/eIgP/9MfgDB/jCHMUjMYEZC2VFQHWIxg12PeVi3/He2yJtBSZtmA199
         nd3h6gqNPu95mmnjGlU3Ur7iT3SfwKWZ4yYZftfq80AeGK9lLb3/hsRIsNpJyaR0uQv3
         /gTRrt5RWf5+i+DGhzSFuj1bGz3EIJ6HlCX8//mdNRnBjYp63lKTZPXtxlGrvEm4/l+N
         HOuA==
X-Gm-Message-State: AOJu0Yz1ecsBgcKdzpnlxtjOympaM7j0+2yCc+jFIwtJWk+rWMT7QrRX
	hVpIaHcVRkr+vyjKziiJOqi8q2Qaz7/RIQXMED0eULu7mMrDqr9J3n4Cwf1rjppfngj9+9NMuA7
	9xPiuu6ag5Q==
X-Gm-Gg: Acq92OH/hGr/SE3blhdCHaJlsYuyv3Oxd1RGzZcLXaAIk3MN5cnwB6/diXrWtdEvDSN
	WBVXo6VZWbKbw/twlRWAPq4khpBefJf910YAR9n0pml9oviXlAoFgLNaT5QueYV43vDgUT4z3bV
	LUnmVFlCAZl/NMsnXRneCKA6i8NergqNAsvsZw+VrC7Gxvfh+8NKyOhEi1xlVQtKMMOjNgIyobR
	2mihGieeUE7JrVa/KGadRkelEDZFI8+ppxd8Wt8nKMy8asvkJ/H7URvIf/z6eOjyPCM09DtzdyN
	TTb8eZ/QNEMrio0uJVPbv4ih9TeFd4D4GlQwM2K7+cM5CqFKiZHRYiBBYy5YrcfktKHxQUeJems
	oBG0rnGRneJ7dlHwzeHuE0uGxGw44OjZwE81KT4cpAqMJEatb3OVTZKD+Mvop6wqnClYs375/vM
	XptISJg4C8hZHiVKUy4FxKmf9xLgIxQzPjngKL0cSiJ8b/6hMf0kF9M4Pz78kUVRLpUwiTmXSDm
	3BOelHr0j3zsXqdZfFnkmi5L4d3nqq/JVlhbewNJPUsXa1ePRhxJtbmECn8/xNJe34V5+k7pigE
	qZQeg4ytv3iB6P6E2mecAWjsBU0=
X-Received: by 2002:a05:690c:4:b0:7b8:c19c:ee9a with SMTP id 00721157ae682-7c95c1feddemr218274097b3.32.1779207157438;
        Tue, 19 May 2026 09:12:37 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7cc996b4badsm39616697b3.11.2026.05.19.09.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 09:12:37 -0700 (PDT)
Date: Tue, 19 May 2026 12:12:36 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Derrick Stolee <stolee@gmail.com>
Subject: [PATCH 1/8] pack-bitmap: pass object position to `fill_bitmap_tree()`
Message-ID: <13191c19b91bc3f5d671b7016b97f2309f12737d.1779207127.git.me@ttaylorr.com>
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

In the following commit, callers of `fill_bitmap_tree()` will be
required to check the bit corresponding to their tree before calling
that function. That change will reduce the overhead of setting up and
tearing down stack frames for trees whose bits are already set.

To prepare for that change, have callers pass in the tree's bit position
in `fill_bitmap_tree()`, which will make the next commit easier to read.

In the meantime, this change has a surprising and measurable benefit
during bitmap generation, particularly on very large repositories.

When processing sub-trees within `fill_bitmap_tree()`, the preimage of
this patch did the following:

    while (tree_entry(&desc, entry)) {
        switch (object_type(entry.mode)) {
        case OBJ_TREE:
            if (fill_bitmap_tree(writer, bitmap,
                                 lookup_tree(writer->repo,
                                             &entry.oid)) < 0) {
                /* ... */
            }
            /* ... */
        }
    }

, first performing the object lookup via `lookup_tree()`, and then
locating its bit position within the recursive call. This patch
effectively reorders those two calls so that we first discover the
sub-tree's bit position, *then* load its tree.

By reordering these two operations, we spend fewer CPU cycles per
instruction, likely due to improved CPU dependency/cache/pipeline
behavior. Comparing the results of: running `perf stat` before and after
this commit, we have:

    +--------------+-------------+-------------+-------------------+
    |              | HEAD^       | HEAD        | Delta             |
    +--------------+-------------+-------------+-------------------+
    | elapsed      |   612.5 s   |   582.4 s   |  -30.1 s  (-4.9%) |
    | cycles       | 2,857.3 B   | 2,713.3 B   | -144.0 B  (-5.0%) |
    | instructions | 2,413.2 B   | 2,415.5 B   |   +2.3 B  (+0.1%) |
    | CPI          |     1.184   |     1.123   |  -0.061   (-5.1%) |
    +--------------+-------------+-------------+-------------------+

In a large repository with ~4.8M commit, and ~37.1M tree objects this
change improves timing from ~612.5 seconds down to ~582.4 seconds, or a
~4.9% improvement. More importantly, the number of CPU cycles spent
dropped off significantly as a result of this commit, lowering our
cycles-per-instruction ratio by about ~5.1%.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap-write.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 1c8070f99c0..2d5ff8fd406 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -456,10 +456,10 @@ static void bitmap_builder_clear(struct bitmap_builder *bb)
 
 static int fill_bitmap_tree(struct bitmap_writer *writer,
 			    struct bitmap *bitmap,
-			    struct tree *tree)
+			    struct tree *tree,
+			    uint32_t pos)
 {
 	int found;
-	uint32_t pos;
 	struct tree_desc desc;
 	struct name_entry entry;
 
@@ -467,9 +467,6 @@ static int fill_bitmap_tree(struct bitmap_writer *writer,
 	 * If our bit is already set, then there is nothing to do. Both this
 	 * tree and all of its children will be set.
 	 */
-	pos = find_object_pos(writer, &tree->object.oid, &found);
-	if (!found)
-		return -1;
 	if (bitmap_get(bitmap, pos))
 		return 0;
 	bitmap_set(bitmap, pos);
@@ -482,8 +479,12 @@ static int fill_bitmap_tree(struct bitmap_writer *writer,
 	while (tree_entry(&desc, &entry)) {
 		switch (object_type(entry.mode)) {
 		case OBJ_TREE:
+			pos = find_object_pos(writer, &entry.oid, &found);
+			if (!found)
+				return -1;
 			if (fill_bitmap_tree(writer, bitmap,
-					     lookup_tree(writer->repo, &entry.oid)) < 0)
+					     lookup_tree(writer->repo,
+							 &entry.oid), pos) < 0)
 				return -1;
 			break;
 		case OBJ_BLOB:
@@ -575,8 +576,14 @@ static int fill_bitmap_commit(struct bitmap_writer *writer,
 	}
 
 	while (tree_queue->nr) {
-		if (fill_bitmap_tree(writer, ent->bitmap,
-				     prio_queue_get(tree_queue)) < 0)
+		struct tree *t = prio_queue_get(tree_queue);
+		int found;
+
+		pos = find_object_pos(writer, &t->object.oid, &found);
+		if (!found)
+			return -1;
+
+		if (fill_bitmap_tree(writer, ent->bitmap, t, pos) < 0)
 			return -1;
 	}
 	return 0;
-- 
2.54.0.rc1.84.g30ce254312c

