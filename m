Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8EE14E2DF
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 21:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723755692; cv=none; b=FFzS416G9rFyaowV4/AN1gcPjNXN+zevEPZe22f4mOjUSkyFk7YfboidvYBGFrzhNXFXJQb+DDSOx0No4eDDsy/1E2qdjubWNon2p5ebKqwPdjwa9/NU5lSKb368WLEp0e9GVzqEdHE8LGD+FhQtraUo/VkfsqSMqvloIBFy16o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723755692; c=relaxed/simple;
	bh=0c1BLveCC0VTuedQ7gjhMnuviv9khlUd8jJuVt6QJGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X7U83VLiZyszOu4uEs/RAAa3by15TLvEowwnkNOlL7tUS6Y0DnjAS6sXa0Ny+joddd/MeA/N9ZeepF8+B7S/JjS9Z9U0CW7XTAxmrBjJ72op95uYdZ+uDzl8diG7FWFqMaiftZ8WUxW+k8ugziKO4b+JMHuXWH+fcpPVbUTLqI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=xklMKWIC; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="xklMKWIC"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-699ac6dbf24so13061837b3.3
        for <git@vger.kernel.org>; Thu, 15 Aug 2024 14:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1723755689; x=1724360489; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DYNYWrfBb9brsbTpEoKkvZqrdyZOZli6q8goV7oYNrU=;
        b=xklMKWICPlUuES3lizVAMBtlT004GIgrmPOk4vW+/kMlLgwVH68sVYjIs2iCBOHlhN
         IN+CiozRCrPg3GchiR7W2iE2bQn56LLUM36qo1/eNP/AcXOduay3JwyqBkBkDuKQKyu9
         AKllCaMACzXdT5Fq5h76vUp45pMoe0ytonM97iQ03oJ1Ocj7DzdRdyy3P0NADed8Wg/Q
         89My9XgKXL+RWVUFJ2k5Mv1+SzhqgsgOiq7fBYCQn4SKJ/0juKA7pSXcccCyQLvHuFMz
         tL7J5TYOoT+kHwY3TzKaSrqpqddXxEy4OuilsiLW4Kr0tNmy6v7ZDj5FT29ILDP6Imp5
         LU+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723755689; x=1724360489;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DYNYWrfBb9brsbTpEoKkvZqrdyZOZli6q8goV7oYNrU=;
        b=QrCsludjHA+9azTNVZU43Af+WVUVsBKfrhNu69BxW0U/HLDaKHsULnADfmItg07vFJ
         keBEzW8mYtvCtYgUs3deuPDkepjlcj47wO2pVtBLCMJJttjQgYNZelA1OsSK/3DafaDi
         U/+Ia7KpyG1ZMX5P/fnZD2unBaY+Z3vPRLjqTBlJHdB7SZYiHxGlW1psRcm+bs8xn096
         hlfgIyqzWscx8+kO2VeAqabQXf2AG4El7ESqGAJiyaiqv2jOHICYhBJ73f9XiGrpSFBI
         w9m8S7qtifs8fDkUeBfOnuMbe64F04Vwa/+q75btWUXLIKREPZdc+PNb2meQYLgCjLmj
         0/Tw==
X-Gm-Message-State: AOJu0YxjY5QGQ1PJ/noerO4LK1A963R4RMTTFrbYv6Os8w/5o/jA2gVn
	aHCkkaq37//0+hjTqgZKajAej6obdwq32+tqTOIi4zBlwsl68tBN+1fYL0Wo9cv3OKJrnY4Gk7s
	W
X-Google-Smtp-Source: AGHT+IHNXMxEzNGjL7N+ikicRhvqNC882VUkDeX7+9htt+VT51/62EusABcNVzZOoGQBFt/6Sbi+ZA==
X-Received: by 2002:a05:690c:2905:b0:6ad:feb0:e6c9 with SMTP id 00721157ae682-6b1b8906da8mr8707057b3.23.1723755689648;
        Thu, 15 Aug 2024 14:01:29 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6af9a28cd46sm3902497b3.36.2024.08.15.14.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 14:01:29 -0700 (PDT)
Date: Thu, 15 Aug 2024 17:01:28 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 03/13] pack-bitmap.c: open and store incremental bitmap layers
Message-ID: <43444efc21415b8817522cbd7b590e1ce38636d5.1723755667.git.me@ttaylorr.com>
References: <cover.1723755667.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1723755667.git.me@ttaylorr.com>

Prepare the pack-bitmap machinery to work with incremental MIDXs by
adding a new "base" field to keep track of the bitmap index associated
with the previous MIDX layer.

The changes in this commit are mostly boilerplate to open the correct
bitmap(s), add them to the chain bitmap layers along the "base" pointer,
ensures that the correct packs and their reverse indexes are loaded
across MIDX layers, etc.

While we're at it, keep track of a base_nr field to indicate how many
bitmap layers (including the current bitmap) exist. This will be used in
a future commit to allocate an array of 'struct ewah_bitmap' pointers to
collect all of the respective type bitmaps among all layers to
initialize a multi-EWAH iterator.

Subsequent commits will teach the functions within the pack-bitmap
machinery how to interact with these new fields.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 63 ++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 50 insertions(+), 13 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 0a7039d955..c27383c027 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -54,6 +54,13 @@ struct bitmap_index {
 	struct packed_git *pack;
 	struct multi_pack_index *midx;
 
+	/*
+	 * If using a multi-pack index chain, 'base' points to the
+	 * bitmap index corresponding to this bitmap's midx->base_midx.
+	 */
+	struct bitmap_index *base;
+	uint32_t base_nr;
+
 	/* mmapped buffer of the whole bitmap index */
 	unsigned char *map;
 	size_t map_size; /* size of the mmaped buffer */
@@ -377,8 +384,13 @@ static int load_bitmap_entries_v1(struct bitmap_index *index)
 char *midx_bitmap_filename(struct multi_pack_index *midx)
 {
 	struct strbuf buf = STRBUF_INIT;
-	get_midx_filename_ext(&buf, midx->object_dir, get_midx_checksum(midx),
-			      MIDX_EXT_BITMAP);
+	if (midx->has_chain)
+		get_split_midx_filename_ext(&buf, midx->object_dir,
+					    get_midx_checksum(midx),
+					    MIDX_EXT_BITMAP);
+	else
+		get_midx_filename_ext(&buf, midx->object_dir,
+				      get_midx_checksum(midx), MIDX_EXT_BITMAP);
 
 	return strbuf_detach(&buf, NULL);
 }
@@ -397,10 +409,17 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
 {
 	struct stat st;
 	char *bitmap_name = midx_bitmap_filename(midx);
-	int fd = git_open(bitmap_name);
+	int fd;
 	uint32_t i, preferred_pack;
 	struct packed_git *preferred;
 
+	fd = git_open(bitmap_name);
+	if (fd < 0 && errno == ENOENT) {
+		FREE_AND_NULL(bitmap_name);
+		bitmap_name = midx_bitmap_filename(midx);
+		fd = git_open(bitmap_name);
+	}
+
 	if (fd < 0) {
 		if (errno != ENOENT)
 			warning_errno("cannot open '%s'", bitmap_name);
@@ -446,7 +465,7 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
 		goto cleanup;
 	}
 
-	for (i = 0; i < bitmap_git->midx->num_packs; i++) {
+	for (i = 0; i < bitmap_git->midx->num_packs + bitmap_git->midx->num_packs_in_base; i++) {
 		if (prepare_midx_pack(the_repository, bitmap_git->midx, i)) {
 			warning(_("could not open pack %s"),
 				bitmap_git->midx->pack_names[i]);
@@ -459,13 +478,20 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
 		goto cleanup;
 	}
 
-	preferred = bitmap_git->midx->packs[preferred_pack];
+	preferred = nth_midxed_pack(bitmap_git->midx, preferred_pack);
 	if (!is_pack_valid(preferred)) {
 		warning(_("preferred pack (%s) is invalid"),
 			preferred->pack_name);
 		goto cleanup;
 	}
 
+	if (midx->base_midx) {
+		bitmap_git->base = prepare_midx_bitmap_git(midx->base_midx);
+		bitmap_git->base_nr = bitmap_git->base->base_nr + 1;
+	} else {
+		bitmap_git->base_nr = 1;
+	}
+
 	return 0;
 
 cleanup:
@@ -516,6 +542,7 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
 	bitmap_git->map_size = xsize_t(st.st_size);
 	bitmap_git->map = xmmap(NULL, bitmap_git->map_size, PROT_READ, MAP_PRIVATE, fd, 0);
 	bitmap_git->map_pos = 0;
+	bitmap_git->base_nr = 1;
 	close(fd);
 
 	if (load_bitmap_header(bitmap_git) < 0) {
@@ -535,8 +562,7 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
 static int load_reverse_index(struct repository *r, struct bitmap_index *bitmap_git)
 {
 	if (bitmap_is_midx(bitmap_git)) {
-		uint32_t i;
-		int ret;
+		struct multi_pack_index *m;
 
 		/*
 		 * The multi-pack-index's .rev file is already loaded via
@@ -545,10 +571,15 @@ static int load_reverse_index(struct repository *r, struct bitmap_index *bitmap_
 		 * But we still need to open the individual pack .rev files,
 		 * since we will need to make use of them in pack-objects.
 		 */
-		for (i = 0; i < bitmap_git->midx->num_packs; i++) {
-			ret = load_pack_revindex(r, bitmap_git->midx->packs[i]);
-			if (ret)
-				return ret;
+		for (m = bitmap_git->midx; m; m = m->base_midx) {
+			uint32_t i;
+			int ret;
+
+			for (i = 0; i < m->num_packs; i++) {
+				ret = load_pack_revindex(r, m->packs[i]);
+				if (ret)
+					return ret;
+			}
 		}
 		return 0;
 	}
@@ -574,6 +605,13 @@ static int load_bitmap(struct repository *r, struct bitmap_index *bitmap_git)
 	if (!bitmap_git->table_lookup && load_bitmap_entries_v1(bitmap_git) < 0)
 		goto failed;
 
+	if (bitmap_git->base) {
+		if (!bitmap_is_midx(bitmap_git))
+			BUG("non-MIDX bitmap has non-NULL base bitmap index");
+		if (load_bitmap(r, bitmap_git->base) < 0)
+			goto failed;
+	}
+
 	return 0;
 
 failed:
@@ -658,10 +696,9 @@ struct bitmap_index *prepare_bitmap_git(struct repository *r)
 
 struct bitmap_index *prepare_midx_bitmap_git(struct multi_pack_index *midx)
 {
-	struct repository *r = the_repository;
 	struct bitmap_index *bitmap_git = xcalloc(1, sizeof(*bitmap_git));
 
-	if (!open_midx_bitmap_1(bitmap_git, midx) && !load_bitmap(r, bitmap_git))
+	if (!open_midx_bitmap_1(bitmap_git, midx))
 		return bitmap_git;
 
 	free_bitmap_index(bitmap_git);
-- 
2.46.0.86.ge766d390f0.dirty

