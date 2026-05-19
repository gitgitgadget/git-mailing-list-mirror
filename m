Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5806C403EAA
	for <git@vger.kernel.org>; Tue, 19 May 2026 16:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779207165; cv=none; b=KKDxNugpKwtv4S0ofa28PurXAzfNUz3or8vDAS2OEkQ6gpSj/Ye0II5UmrrhJh5c4n5XTfQ7bOC+O1e4WVdRrU3DB7DRM5oZFp4PkqKVfwwQHhpXRW0RF6VhtptMfXG1SIw+jCtM86NiA+qNOkVDc7xVVeDRZyvRdV6NcjZ6gkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779207165; c=relaxed/simple;
	bh=KI6xAhEc1+xiWqwdyD4NXxxabi3WPyhV2H45mxS2JbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a2zyae+ETlcnPohw/9D1dYB/TVwIQnhhKzcoOpuayI+AEJ+vw2RnyJw1Wpld9P9TxAY/cTrQ+4ks69XwVPfZs/AhJipv0va1EvMbDRIoImu463K5JFGV3/ROrWytI09v9ZoeRKW1waEnmSFZG5GO5Iz2TTAUrUOGIJfu2Cgjshs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=SSCXvmAK; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="SSCXvmAK"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7bd5e373d07so35366147b3.2
        for <git@vger.kernel.org>; Tue, 19 May 2026 09:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1779207163; x=1779811963; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JpS9BcDFk1Y4z4PkiYB7qTANd6jJcMA0dQTGMEaRyQo=;
        b=SSCXvmAKJEOPKOT6zxtF4bWtlnbaNLDwxqIvlU26sjtDTcMdvx+b33xQfwHXRjk0TW
         SgzPOgphjXsSe3NPSVYaC30KN74Q2qKztakSmAZI6rLAGRjNDEOJ37ruGhWz0/QQ2dv+
         KztWnPtPMX7KkpYdTEHf/OTn/rWowLx/v+SxytJ9Z/98msgSUSeZibEv6RCHHhsTb4pD
         0tE9XRosEb1wh8Qwefylx4hj62s+o7LeJWuIsTqLkwrOjp4T2JkzVKVDNkzBcNnI/YxL
         b2CrcXeL4ut3vV4GyXOYJg07TMTjB6TxOr/Z4AjbUqDc+WHlMlIxOFIL6yPvMZso0BnE
         IynQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779207163; x=1779811963;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JpS9BcDFk1Y4z4PkiYB7qTANd6jJcMA0dQTGMEaRyQo=;
        b=QzsGNi4vxheRHU06PJLaEkk5bYH6Dbqu0qWAOibdDVjuPVTLP6xLIpcpr3Pvpa1p7n
         iWXWL+9IZjhE7aoJWeTzQ03zipcjlQnDYha8+jBo5Ju+d7Pm7ANXZPs4xZS6FE74J8c9
         nBrPtd/qdYO2XRpo91LN7qhhLUVHQGdA2bBXi16odOp6Q9+Ar9Wxj+klwM00BDJ9XZx+
         aAuddluIV/Up4sWVgJLx9H3Owh0sa1k8nbXGtlTHDUXZWk/5kaHS16t0skUnAjEjUUUH
         B+yaMxIexZeEbK17NsUSTfufNEpXgQw5I/3X6vae2UQL+jJLjNRiwXrsTXrSCnMoNmcS
         7S7g==
X-Gm-Message-State: AOJu0YwzisYWMaXpZSaABdob5KawnsOjHxd4uk7AnD7c6ZjcmUjVAHY8
	h0R7A09Fg+MTGPW7+Orcoppgb9km/hr+6FIV3AarH0G/zln6fU3g1q0c50PcHOjX78x21pYcVNV
	FmY7nfLnb4A==
X-Gm-Gg: Acq92OEE3QT5ZfWvNrRsUpwpi03LvOMX7e9oqsP61AyXwZmpMeTBGzOT265NjaHkdQ0
	N+wUP/G554HzTebDjzOiZZJIHs1Hc3Sw6zX624HUy9TlD6ULC8BV/Qh1PnZEDz6UIJE8rN7L5we
	+uMMNngoandMMptWgENG8qnW9laixIHqhkscNjz7v6ykBhoXAxUE9eOxgNfO/qTxhW6BfKspih5
	VVQ3z3ZJ0m9oMMInNWtJsdYJtBeI0wK728z77uwxMU+v5S4lQFSj3y8ncXDX0Kre7glLmvEI0Ur
	2logaHG6SoBOQvfVZEHoG9K4qdAHGtoyaIglwfakCUImHHEmWQtpdhxWz6PntalQ6ve3XqV7dkN
	sS07iPKM82wCu0QdZdtGr/WMbp6WFVbhZO6flmf8re3zmYFW1FtFRguOxO9c8z5H4T0zSGppAbV
	Ft2xsIGtk8ORWqQFKVb1Rm7FQRTkU/yE9Cev5HPoZUgxYKCY+BCr+pNe6JlvI7uXgIsqwx7O6u8
	00cS0AGYsLcPOEtd0fxxVMZBSefowv2Aq4vxx0RZiVNA/nZ2Y/6f+Lid0DBZzhWAwExtJUw4IoX
	GL2mMn1cUNB+yE4JayN5QfKyQdI=
X-Received: by 2002:a05:690c:86:b0:7b6:cd36:84af with SMTP id 00721157ae682-7c95b33f08cmr211464017b3.32.1779207163167;
        Tue, 19 May 2026 09:12:43 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7cc9bc0e213sm38649937b3.26.2026.05.19.09.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 09:12:42 -0700 (PDT)
Date: Tue, 19 May 2026 12:12:41 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Derrick Stolee <stolee@gmail.com>
Subject: [PATCH 3/8] pack-bitmap: reuse stored selected bitmaps
Message-ID: <6e1f6bef5f641481a6a875bc215b35fc56cef80c.1779207127.git.me@ttaylorr.com>
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

When `fill_bitmap_commit()` reaches an ancestor that was selected for
its own bitmap and processed earlier, its object closure is already
stored in `writer->bitmaps` as an EWAH bitmap. As a result, walking
through that commit's tree and parents again is redundant.

Teach `fill_bitmap_commit()` to notice that case. For non-root commits in
the walk, look for a stored selected bitmap and OR it into the bitmap
being built. If one exists, skip the commit, its tree, and its parents.

Building bitmaps from scratch on the same test repository from the
previous commits yields a significant speed-up:

    +------------------+-------------+-------------+---------------------+
    |                  | HEAD^       | HEAD        | Delta               |
    +------------------+-------------+-------------+---------------------+
    | elapsed          |   562.8 s   |   324.8 s   |   -237.9 s (-42.3%) |
    | cycles           | 2,621.3 B   | 1,508.6 B   | -1,112.7 B (-42.4%) |
    | instructions     | 2,348.9 B   | 1,436.6 B   |   -912.3 B (-38.8%) |
    | CPI              |     1.116   |     1.050   |   -0.066    (-5.9%) |
    +------------------+-------------+-------------+---------------------+

In our testing repository, there are 1,261 commits selected for bitmap
coverage, and 1,382 maximal commits induced as a result of that. Of the
1,382 calls made to `fill_bitmap_commit()` (one per maximal commit), 131
of them can be short-circuited at some point during their traversal as a
consequence of this change.

In large repositories where the cost of filling the bitmap for any
individual commit is large, being able to short-circuit even ~9.5% of
the calls to `fill_bitmap_commit()` results in a significant savings.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap-write.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 72610397020..651ad467469 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -509,6 +509,9 @@ static int fill_bitmap_tree(struct bitmap_writer *writer,
 static int reused_bitmaps_nr;
 static int reused_pseudo_merge_bitmaps_nr;
 
+static int fill_bitmap_commit_calls_nr;
+static int fill_bitmap_commit_found_ancestor_nr;
+
 static int fill_bitmap_commit(struct bitmap_writer *writer,
 			      struct bb_commit *ent,
 			      struct commit *commit,
@@ -519,6 +522,9 @@ static int fill_bitmap_commit(struct bitmap_writer *writer,
 {
 	int found;
 	uint32_t pos;
+
+	fill_bitmap_commit_calls_nr++;
+
 	if (!ent->bitmap)
 		ent->bitmap = bitmap_new();
 
@@ -553,6 +559,28 @@ static int fill_bitmap_commit(struct bitmap_writer *writer,
 			bitmap_free(remapped);
 		}
 
+		/*
+		 * If we encounter an ancestor for which we have already
+		 * computed a bitmap during this build (i.e. a regular
+		 * selected commit processed earlier in topo order), we can
+		 * short-circuit the walk: its stored bitmap already covers
+		 * the commit itself, its tree, and all of its ancestors.
+		 */
+		if (c != commit) {
+			khiter_t hash_pos = kh_get_oid_map(writer->bitmaps,
+							   c->object.oid);
+			if (hash_pos != kh_end(writer->bitmaps)) {
+				struct bitmapped_commit *stored =
+					kh_value(writer->bitmaps, hash_pos);
+				if (stored && stored->bitmap) {
+					fill_bitmap_commit_found_ancestor_nr++;
+					bitmap_or_ewah(ent->bitmap,
+						       stored->bitmap);
+					continue;
+				}
+			}
+		}
+
 		/*
 		 * Mark ourselves and queue our tree. The commit
 		 * walk ensures we cover all parents.
@@ -692,6 +720,12 @@ int bitmap_writer_build(struct bitmap_writer *writer)
 	trace2_data_intmax("pack-bitmap-write", writer->repo,
 			   "building_bitmaps_pseudo_merge_reused",
 			   reused_pseudo_merge_bitmaps_nr);
+	trace2_data_intmax("pack-bitmap-write", writer->repo,
+			   "fill_bitmap_commit_calls_nr",
+			   fill_bitmap_commit_calls_nr);
+	trace2_data_intmax("pack-bitmap-write", writer->repo,
+			   "fill_bitmap_commit_found_ancestor_nr",
+			   fill_bitmap_commit_found_ancestor_nr);
 
 	stop_progress(&writer->progress);
 
-- 
2.54.0.rc1.84.g30ce254312c

