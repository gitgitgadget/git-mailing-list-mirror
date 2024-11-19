Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D11A1D364C
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 22:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732054074; cv=none; b=GFNO+PgW8qNX4LgTbPtv/S6ldEs2MP8Yu/eG1qPuF84knuDDMpqU2Ut+ZrD57gh6/iYeCZ5d9OVrYHubbGavgRYg2vLSBe2uaa8cJY3fHpSAdV05geaMLglFuQ2d8X+d9w7/8qTp2wXBk3t0gVAajbhC6oP267Q2+Wm662MVVaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732054074; c=relaxed/simple;
	bh=Lc1FzVuNz+XZja7G7LBfv26KYZ6pJ98IseW+NkEDMZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pMwVVpu76gANIXV87lrc8bLcQ0lw2jUK30bkEklLFvTkC/HSV5hQrMTPgXjxr0iHaDV9X0G/l3+QO5dZFSX1OF2Q+ExdKKEPfrqbbdozaBg3bvNuG1Zp3hWdnFUErGAzv8Vqw6F/h8zPB9ABiA7SL39rpf5AQGwNUlhXoxSS5OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=y7ZafyHd; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="y7ZafyHd"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6ee7a400647so18572427b3.1
        for <git@vger.kernel.org>; Tue, 19 Nov 2024 14:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1732054072; x=1732658872; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3v660bK1rP4X2cNJW95bLJv8suwZ4TIVAmONXBCq9Uc=;
        b=y7ZafyHdltW0tw//Lq5ZCz4FkCMoXTf5crih5rQcFRfWNn+zEdgzWPYJ6Paorp/q41
         bhoR3FG5ediIANd76moLPCQ0eaeiAcZLuUX7WOzPrM/LMm+Vy17mYI2TpuJgcwMbsWpS
         R+yXF80dkpTekySX7Zd3BD+GwoIrQmLPDRjqleZxKkyXX8uPw3E0WXL950Nl9EcJfN18
         /THU63WgbCBz+vOnx2bnX63xAd+YrZqmGM7mZp0txZR0HUVpwrahogg/mNZSRD4uknUJ
         J7O6BabBdWkxFxyVwdH9B0Gf4fpyZGiYdumEd/FzunqgtMuzW1PYFgmXhnGom4/pqvLs
         XGFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732054072; x=1732658872;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3v660bK1rP4X2cNJW95bLJv8suwZ4TIVAmONXBCq9Uc=;
        b=ZUo4vhG67PtJxg35C5usMMzSmz78DnYysoGNaUjX6Ypqx9t0VS5SJIRwQ3F1Aw4ucW
         vbaSyOnGPjaqvqcmmYTPTVoG05GISASwohznOLVkPhCkanLoHvJ1WeOeAs5NBhvdMk7P
         OVfuEXqNq9Xsgp8E/Ve2Pa0IqqCYIVvkEhmOImZsOfsEsQw/K51m0ivuZ4k4OJC+LfRJ
         5U1FWODPLgkdq/cVDPSjHuYhnVxpuXQC9Q/UUoO0NK0pRl8R2MB0ZIHrmDlsblnQCLkW
         IufkNn6tnUjpciRr15aW39DkATlBUhxbF1dcE7vMLd10oo8/n5m58yyD+CdY2p8smci9
         e7Ww==
X-Gm-Message-State: AOJu0Yw1ihbDSSWhdPhTfubTuRGGJcN4FfEkdsuEGxPk5JVE4gMDfSDW
	rTH3zM8xCBRKC77AcEkKL2KJkG+0Y9rhNSvjIQ+Df9nIxJA+RbDNsbthr6JqcvxV4iezwrz7ag0
	v
X-Google-Smtp-Source: AGHT+IElPCzHQbydUe42fC1hhW4zFGk/riK3pHQ4mG4gvwBoHCqGz28i2C1ldG/c7+erjR0ynkCexg==
X-Received: by 2002:a05:690c:6f93:b0:6dd:bba1:b86d with SMTP id 00721157ae682-6eebd11aa56mr4868737b3.10.1732054072014;
        Tue, 19 Nov 2024 14:07:52 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ee71365675sm19171587b3.106.2024.11.19.14.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 14:07:51 -0800 (PST)
Date: Tue, 19 Nov 2024 17:07:50 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 11/13] pack-bitmap.c: keep track of each layer's type
 bitmaps
Message-ID: <9ab8fb472f48f42f7e0eebc6f0f986c6c74970e9.1732054032.git.me@ttaylorr.com>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1732054032.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1732054032.git.me@ttaylorr.com>

Prepare for reading the type-level bitmaps from previous bitmap layers
by maintaining an array for each type, where each element in that type's
array corresponds to one layer's bitmap for that type.

These fields will be used in a later commit to instantiate the 'struct
ewah_or_iterator' for each type.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 51 insertions(+), 4 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 570f6dbdad6..348488e2d9e 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -78,6 +78,24 @@ struct bitmap_index {
 	struct ewah_bitmap *blobs;
 	struct ewah_bitmap *tags;
 
+	/*
+	 * Type index arrays when this bitmap is associated with an
+	 * incremental multi-pack index chain.
+	 *
+	 * If n is the number of unique layers in the MIDX chain, then
+	 * commits_all[n-1] is this structs 'commits' field,
+	 * commits_all[n-2] is the commits field of this bitmap's
+	 * 'base', and so on.
+	 *
+	 * When either associated either with a non-incremental MIDX, or
+	 * a single packfile, these arrays each contain a single
+	 * element.
+	 */
+	struct ewah_bitmap **commits_all;
+	struct ewah_bitmap **trees_all;
+	struct ewah_bitmap **blobs_all;
+	struct ewah_bitmap **tags_all;
+
 	/* Map from object ID -> `stored_bitmap` for all the bitmapped commits */
 	kh_oid_map_t *bitmaps;
 
@@ -586,7 +604,29 @@ static int load_reverse_index(struct repository *r, struct bitmap_index *bitmap_
 	return load_pack_revindex(r, bitmap_git->pack);
 }
 
-static int load_bitmap(struct repository *r, struct bitmap_index *bitmap_git)
+static void load_all_type_bitmaps(struct bitmap_index *bitmap_git)
+{
+	struct bitmap_index *curr = bitmap_git;
+	size_t i = bitmap_git->base_nr - 1;
+
+	ALLOC_ARRAY(bitmap_git->commits_all, bitmap_git->base_nr);
+	ALLOC_ARRAY(bitmap_git->trees_all, bitmap_git->base_nr);
+	ALLOC_ARRAY(bitmap_git->blobs_all, bitmap_git->base_nr);
+	ALLOC_ARRAY(bitmap_git->tags_all, bitmap_git->base_nr);
+
+	while (curr) {
+		bitmap_git->commits_all[i] = curr->commits;
+		bitmap_git->trees_all[i] = curr->trees;
+		bitmap_git->blobs_all[i] = curr->blobs;
+		bitmap_git->tags_all[i] = curr->tags;
+
+		curr = curr->base;
+		i -= 1;
+	}
+}
+
+static int load_bitmap(struct repository *r, struct bitmap_index *bitmap_git,
+		       int recursing)
 {
 	assert(bitmap_git->map);
 
@@ -608,10 +648,13 @@ static int load_bitmap(struct repository *r, struct bitmap_index *bitmap_git)
 	if (bitmap_git->base) {
 		if (!bitmap_is_midx(bitmap_git))
 			BUG("non-MIDX bitmap has non-NULL base bitmap index");
-		if (load_bitmap(r, bitmap_git->base) < 0)
+		if (load_bitmap(r, bitmap_git->base, 1) < 0)
 			goto failed;
 	}
 
+	if (!recursing)
+		load_all_type_bitmaps(bitmap_git);
+
 	return 0;
 
 failed:
@@ -687,7 +730,7 @@ struct bitmap_index *prepare_bitmap_git(struct repository *r)
 {
 	struct bitmap_index *bitmap_git = xcalloc(1, sizeof(*bitmap_git));
 
-	if (!open_bitmap(r, bitmap_git) && !load_bitmap(r, bitmap_git))
+	if (!open_bitmap(r, bitmap_git) && !load_bitmap(r, bitmap_git, 0))
 		return bitmap_git;
 
 	free_bitmap_index(bitmap_git);
@@ -2042,7 +2085,7 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
 	 * from disk. this is the point of no return; after this the rev_list
 	 * becomes invalidated and we must perform the revwalk through bitmaps
 	 */
-	if (load_bitmap(revs->repo, bitmap_git) < 0)
+	if (load_bitmap(revs->repo, bitmap_git, 0) < 0)
 		goto cleanup;
 
 	if (!use_boundary_traversal)
@@ -2961,6 +3004,10 @@ void free_bitmap_index(struct bitmap_index *b)
 	ewah_pool_free(b->trees);
 	ewah_pool_free(b->blobs);
 	ewah_pool_free(b->tags);
+	free(b->commits_all);
+	free(b->trees_all);
+	free(b->blobs_all);
+	free(b->tags_all);
 	if (b->bitmaps) {
 		struct stored_bitmap *sb;
 		kh_foreach_value(b->bitmaps, sb, {
-- 
2.47.0.301.g77ddd1170f9

