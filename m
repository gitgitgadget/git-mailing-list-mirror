Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9395934040E
	for <git@vger.kernel.org>; Tue, 19 May 2026 16:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779207177; cv=none; b=UXauBNzP3I/ccddvoS4GLC1w36R+uAQ5AR85HnhI41yfoFX6OwdYRaECOpEQVxmXpPX0LjC1CIPgNXFg7L/MpAz8vm/Rt6SC4yl2guF7oOvV9CXwsOnpwYOKsjFUx5IqmlTHUEjDBPOmn/aVDysrw/NgeTCd4bKrRnrFCLfMKc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779207177; c=relaxed/simple;
	bh=UZ4PsOoEN5BPY/S/fhvQoik/0bQRCIgA7pH9533UpRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YPtRca2FfsX5jMpXh4xC+LJr1Jp8Kk0eLuvHG1tJnSyP/Zu0pefqEs58t6n6jB0egjZU5/GEE46+CMbNbNQsSKWQcrNyUDzyGFY9a8rbj+9HmOjLNV3sfw0kMAThHMBaNrpU3mLyA14//Y1zVr/eGK/ZFdUIE8cQHoj9dS6bvDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=lP9vhLnv; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="lP9vhLnv"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7b6ae2ea4a1so34281147b3.2
        for <git@vger.kernel.org>; Tue, 19 May 2026 09:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1779207174; x=1779811974; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LsY+T51hvp4fGOuzVaYkMGO+IjcBDw6q/GPplWfqrvI=;
        b=lP9vhLnvRbMAx6CjDDFHtiWI6CeDGZoM25CNVJcaaMeFNU8wK49Avub1+46PpEyT58
         YpQ80ZGjcJFl5N9xL4gcpOhCkYhZ+MpHToQ5hjrzHV6Wqoq3yOAUjRuAbcptIymuPKJ8
         zA49HBWb5aEP/saSZME4MFLJAmUzIVPpQS0U0l1HUHpga/zD2H5+B+4F9W4CHtI8n6VA
         xkysGxQBrdU41wxzqTng5SdT6P+7IysYYhkH2Vpq+SPE6tj37dU0yKe7OEm4EDEp4nrM
         Ca1ui6Gr4xhQzrPeXOlRBGek9Mdjb0jyI0y2ZbDJEAzpxHntQBbY1yXQdO2DoSA7TiU6
         bEvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779207174; x=1779811974;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LsY+T51hvp4fGOuzVaYkMGO+IjcBDw6q/GPplWfqrvI=;
        b=PNfJmH8Mgec1hAwNLkgcOXII9AqF3LpXmsyNXtNa2B8KPp3vW4XeX5pdbYinuyImrT
         PpyCx3fuBordagcAYTsM7ajdYmyQ7ZxNWEiL0ftXynrp6ctPL7NRZoZUIy47b5O/Jh9h
         B6JNA1JWWth23oMo05FuZpKLTCw6gsG8VwGw2pgDW3c8im/b96brGjd8zXVTClruRnOV
         PGDcDVcjLm8kKRs2uNx9zpermT0Tiu0EHPQgh3UAqoLY09OKdH4XLrfeiRWEDm4jwEA5
         8+eA+JCqlW4v49RM5TNEPj0xRmAi8600c+GEZZmZcK2EDfkN/CzydC8U3nl6pHsX0sz5
         COOQ==
X-Gm-Message-State: AOJu0Yxd2d0YTxZh6JZuIuCJ1gB0mJ1zVh7Ng5SiCPniwTWQa7rX357M
	Gg2MV+OTFDOWAi49x/+kym1AujkqMTOnqPPqwHpECHFMLd8K83URcw3D7qvusv+gJu3f04jeosY
	DUI2AF8CBBQ==
X-Gm-Gg: Acq92OGsIPtwMB3HHDgZpPdGmhZp/GIJohXOGe9d2wS7brBdXS/oMS5ZQoObnzCLBPf
	Vr71t6h9g3r+Hy/MuOIg8OP+1KiZah8QsjtU3i9A5Q/XNVADX5HjnTc/TTeVNq8LnjEn37W4K1g
	hsyQ3L9ASaSVO+gr60UqS25+vl66O854Ug5Tt0QEAdyS7WZeVYDVXk+dMOZMyDnk5s3KYpsOioL
	9TW19PNLOvpzaQis7pJMfTBtn9ydQxz6bz0QcO4SqlQEQpFYNAvJILVB6l0TbWWDYfbVNfnA9qe
	EMx7gpWp/QnxF9VZCKKdYixm7mUYJanPpvD4mxzrO3vf205ygFcP88P8lbv2xNgxHFHVCSRydFK
	qJGPTVnOu/ej9GJgZ4/Symevkj0zzxms2ukdeU4+QeXg7ovRR462ZEwIPkSQHJD0IjKlcO6+kHF
	T3TjrRDYQFaRnpfHWhJniv4qj9J3ipRgLHeu4uBBqi6YIYlT1Gh9koOMDJ8Pc1BOrEZdGBSamp/
	aIrD+tbwGGrgUkp/26QLICMEi1BTajDY/qStKzCUnRrAAIpqmPHduMES0jueHYm3rNS8+Ih92AH
	iOnSEzSMEC6e3o7SfdfB+b1M+D0=
X-Received: by 2002:a05:690c:112:b0:7bd:9899:f916 with SMTP id 00721157ae682-7c95d2d08demr203451517b3.49.1779207174445;
        Tue, 19 May 2026 09:12:54 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7cc9cbb0404sm38667497b3.42.2026.05.19.09.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 09:12:54 -0700 (PDT)
Date: Tue, 19 May 2026 12:12:53 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Derrick Stolee <stolee@gmail.com>
Subject: [PATCH 7/8] pack-bitmap: remember pseudo-merge parents
Message-ID: <0bd88e6a096223f117d71dc248b61770178b178c.1779207127.git.me@ttaylorr.com>
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

write_pseudo_merges() currently builds an array of temporary bitmaps for
the parent set of each pseudo-merge, then serializes those bitmaps later
while writing the extension.

Move those parent bitmaps onto the corresponding bitmapped_commit
entries instead. This keeps the on-disk output unchanged, but gives the
parent bitmap the same lifetime and access pattern that later changes
will use when pseudo-merge object bitmaps are built before the write
step.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap-write.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 66282ea14b5..8200aed6101 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -32,6 +32,7 @@ struct bitmapped_commit {
 	struct commit *commit;
 	struct ewah_bitmap *bitmap;
 	struct ewah_bitmap *write_as;
+	struct ewah_bitmap *pseudo_merge_parents;
 	int flags;
 	int xor_offset;
 	uint32_t commit_pos;
@@ -102,6 +103,7 @@ void bitmap_writer_free(struct bitmap_writer *writer)
 		if (bc->write_as != bc->bitmap)
 			ewah_free(bc->write_as);
 		ewah_free(bc->bitmap);
+		ewah_free(bc->pseudo_merge_parents);
 	}
 	free(writer->selected);
 }
@@ -210,6 +212,7 @@ void bitmap_writer_push_commit(struct bitmap_writer *writer,
 	writer->selected[writer->selected_nr].write_as = NULL;
 	writer->selected[writer->selected_nr].flags = 0;
 	writer->selected[writer->selected_nr].pseudo_merge = pseudo_merge;
+	writer->selected[writer->selected_nr].pseudo_merge_parents = NULL;
 
 	writer->selected_nr++;
 }
@@ -1004,42 +1007,47 @@ static void write_pseudo_merges(struct bitmap_writer *writer,
 				struct hashfile *f)
 {
 	struct oid_array commits = OID_ARRAY_INIT;
-	struct bitmap **commits_bitmap = NULL;
 	off_t *pseudo_merge_ofs = NULL;
 	off_t start, table_start, next_ext;
 
 	uint32_t base = bitmap_writer_nr_selected_commits(writer);
 	size_t i, j = 0;
 
-	CALLOC_ARRAY(commits_bitmap, writer->pseudo_merges_nr);
 	CALLOC_ARRAY(pseudo_merge_ofs, writer->pseudo_merges_nr);
 
 	for (i = 0; i < writer->pseudo_merges_nr; i++) {
 		struct bitmapped_commit *merge = &writer->selected[base + i];
 		struct commit_list *p;
+		struct bitmap *parents = bitmap_new();
 
 		if (!merge->pseudo_merge)
 			BUG("found non-pseudo merge commit at %"PRIuMAX, (uintmax_t)i);
 
-		commits_bitmap[i] = bitmap_new();
-
 		for (p = merge->commit->parents; p; p = p->next)
-			bitmap_set(commits_bitmap[i],
+			bitmap_set(parents,
 				   find_object_pos(writer, &p->item->object.oid,
 						   NULL));
+
+		merge->pseudo_merge_parents = bitmap_to_ewah(parents);
+		bitmap_free(parents);
 	}
 
 	start = hashfile_total(f);
 
 	for (i = 0; i < writer->pseudo_merges_nr; i++) {
-		struct ewah_bitmap *commits_ewah = bitmap_to_ewah(commits_bitmap[i]);
+		struct bitmapped_commit *merge = &writer->selected[base + i];
+
+		if (!merge->pseudo_merge)
+			BUG("found non-pseudo merge commit at %"PRIuMAX, (uintmax_t)i);
+
+		if (!merge->pseudo_merge_parents)
+			BUG("missing pseudo-merge parents bitmap for commit %s",
+			    oid_to_hex(&merge->commit->object.oid));
 
 		pseudo_merge_ofs[i] = hashfile_total(f);
 
-		dump_bitmap(f, commits_ewah);
+		dump_bitmap(f, merge->pseudo_merge_parents);
 		dump_bitmap(f, writer->selected[base+i].write_as);
-
-		ewah_free(commits_ewah);
 	}
 
 	next_ext = st_add(hashfile_total(f),
@@ -1122,12 +1130,8 @@ static void write_pseudo_merges(struct bitmap_writer *writer,
 	hashwrite_be64(f, table_start - start);
 	hashwrite_be64(f, hashfile_total(f) - start + sizeof(uint64_t));
 
-	for (i = 0; i < writer->pseudo_merges_nr; i++)
-		bitmap_free(commits_bitmap[i]);
-
 	oid_array_clear(&commits);
 	free(pseudo_merge_ofs);
-	free(commits_bitmap);
 }
 
 static int table_cmp(const void *_va, const void *_vb, void *_data)
-- 
2.54.0.rc1.84.g30ce254312c

