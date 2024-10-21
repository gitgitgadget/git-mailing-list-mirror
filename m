Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C4A1E412A
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 09:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729504692; cv=none; b=dZwh07H66uEmo8G+eO22Yk4qo0EnWuKisQ6OiemSEGbxvvNqTW8PD/iA0jDB1jotFEbO72yd5dNgjqKctChwiVNiIehayta3NakaaYQcINeaILxL68KtQs3oH6b6NNLUg7Xu8GbIAJYelF9Vc+Jh0oe53w1w6UHcGAF1e/ru/Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729504692; c=relaxed/simple;
	bh=bRg5dVFdlNFx2jDhtZ+PgddSGOJ8lD+uT3ybcklHLxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tmI06aOjdVLPSaKh0Oi+3lqhxMxwxwcCUnoYcmhRxCnIL/U6WJqGW2b8ZCma23y/I+Xw1JRdxNhN9KYEKz3GbOQK+9CWX7pNXgVIQoSYo6rAsCOrhmau7cHtTZ/jh9u/p3665vLoo4U0m40PXjaELlfZxXNdbIjKHK6Gh0NsRSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ft5HqsRL; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ft5HqsRL"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c903f5bd0eso7777498a12.3
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 02:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729504688; x=1730109488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P/pjs4M75WsEJNlNvE4dxxkcX3CE3/y/C+80FusxHJI=;
        b=ft5HqsRLwKmqu3/OMhbuBxnbgyFF8sLyVpxcwrowEQ77s5pBF1k7ZT2HRspb7Z2h/x
         W9i+eB5NSVUDsGUZ87bnoaO0shPIwtb32PZ+tH8Le76B6a19CWvijUvpyNe+gXpeMR9I
         heol5G30FdWsbqexvkh8YqMhBiwub2gLZwY7J+NPMxuRn0lztcekia0sv74eW/4jKcvt
         YFF8nfuzsN3EnQtYRbCnXIzKc2Yhw8/AGxv9xfTsaQRB7NDG0lu12GxcbmxfMz6vwioy
         i2DTBg1vOLEfKihuFillxzGiKQbF3GS7KoJ8lXa76nxHR0/VGEbrFQPCjPTFyHbA/RRl
         QUQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729504688; x=1730109488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P/pjs4M75WsEJNlNvE4dxxkcX3CE3/y/C+80FusxHJI=;
        b=sUUgk56DmluaedqgnwuXD0d3kJsgenqb0lJceKTKWsJ6OUUfHIL8G6NM0U0Nh7Cfa0
         gTQOw59PH3pTmb1SVgFHYDrO80MgK2DUbTRWkQMCr3H6AwhNBoQTR0JToc17oPjeo8Ip
         kq1bp/1PqLSCEYxV/HsAjNEjzGc5YGWq2SPH2iUmuXyqK8O9GDe/zFcm6SIZdxn8+V+p
         PkaBSCgY2jWbKFtcClnR3C47h1L275ffCbyu/pNLN0/LjKcswYzdwQESCzL8tMfjaMJG
         cs5jSfubh2R/hIMK18RTRltKxTex42+Ybbtbhrc1R5tkuZrgKC+gBSoZ4xSUoEWgQdRC
         d0Yw==
X-Gm-Message-State: AOJu0Yy14hnkFRP+Hu3G9s0ePIkvnBaZgoesv/O7dI4N41wfm4GOzgnc
	MBwdV0oH7EIRWZwnrf38KcfgpezAlRhwJT/LD0tWbwLPCLTPmBeqaSbOsnVD
X-Google-Smtp-Source: AGHT+IF3rPsJPCzcCjGnxyOH45HCVx6Suci9HRpPFaPIQt5nOAzKIdVg9NcfXN+msJPCgjDGrAsnkQ==
X-Received: by 2002:a17:907:e8d:b0:a9a:3d5b:dc1a with SMTP id a640c23a62f3a-a9a69a76297mr1101219766b.15.1729504688258;
        Mon, 21 Oct 2024 02:58:08 -0700 (PDT)
Received: from archlinux.fritz.box ([2a02:2455:825d:6a00:6bb4:436f:5699:ff21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912d631dsm187122266b.17.2024.10.21.02.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 02:58:07 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org
Subject: [PATCH 03/20] packfile: pass down repository to `close_one_pack`
Date: Mon, 21 Oct 2024 11:57:46 +0200
Message-ID: <5160e79cbb67c0e7596bd0a48ecdedbf3e5236c9.1729504641.git.karthik.188@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729504640.git.karthik.188@gmail.com>
References: <cover.1729504640.git.karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function `close_one_pack` currently relies on the global variable
`the_repository`. To eliminate global variable usage in `packfile.c`, we
should progressively shift the dependency on the_repository to higher
layers. Let's remove its usage from this function and any related ones.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/pack-objects.c |  6 +++---
 midx.c                 |  2 +-
 pack-bitmap.c          |  4 ++--
 pack-check.c           |  2 +-
 packfile.c             | 24 ++++++++++++------------
 packfile.h             |  2 +-
 6 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 4dd6ada184..ec321da8dc 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1482,7 +1482,7 @@ static int want_found_object(const struct object_id *oid, int exclude,
 	if (incremental)
 		return 0;
 
-	if (!is_pack_valid(p))
+	if (!is_pack_valid(the_repository, p))
 		return -1;
 
 	/*
@@ -1560,7 +1560,7 @@ static int want_object_in_pack_one(struct packed_git *p,
 
 	if (offset) {
 		if (!*found_pack) {
-			if (!is_pack_valid(p))
+			if (!is_pack_valid(the_repository, p))
 				return -1;
 			*found_offset = offset;
 			*found_pack = p;
@@ -3513,7 +3513,7 @@ static void read_packs_list_from_stdin(void)
 		struct packed_git *p = item->util;
 		if (!p)
 			die(_("could not find pack '%s'"), item->string);
-		if (!is_pack_valid(p))
+		if (!is_pack_valid(the_repository, p))
 			die(_("packfile %s cannot be accessed"), p->pack_name);
 	}
 
diff --git a/midx.c b/midx.c
index 67e0d64004..4a05f74606 100644
--- a/midx.c
+++ b/midx.c
@@ -597,7 +597,7 @@ int fill_midx_entry(struct repository *r,
 	* answer, as it may have been deleted since the MIDX was
 	* loaded!
 	*/
-	if (!is_pack_valid(p))
+	if (!is_pack_valid(r, p))
 		return 0;
 
 	if (oidset_size(&p->bad_objects) &&
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 32b222a7af..067d1741d2 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -451,7 +451,7 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
 	}
 
 	preferred = bitmap_git->midx->packs[preferred_pack];
-	if (!is_pack_valid(preferred)) {
+	if (!is_pack_valid(the_repository, preferred)) {
 		warning(_("preferred pack (%s) is invalid"),
 			preferred->pack_name);
 		goto cleanup;
@@ -498,7 +498,7 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
 		return -1;
 	}
 
-	if (!is_pack_valid(packfile)) {
+	if (!is_pack_valid(the_repository, packfile)) {
 		close(fd);
 		return -1;
 	}
diff --git a/pack-check.c b/pack-check.c
index e4636e9897..bb649edbc1 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -64,7 +64,7 @@ static int verify_packfile(struct repository *r,
 	int err = 0;
 	struct idx_entry *entries;
 
-	if (!is_pack_valid(p))
+	if (!is_pack_valid(the_repository, p))
 		return error("packfile %s cannot be accessed", p->pack_name);
 
 	r->hash_algo->init_fn(&ctx);
diff --git a/packfile.c b/packfile.c
index b0a3bfcd72..4588004223 100644
--- a/packfile.c
+++ b/packfile.c
@@ -462,13 +462,13 @@ static void find_lru_pack(struct packed_git *p, struct packed_git **lru_p, struc
 	*accept_windows_inuse = has_windows_inuse;
 }
 
-static int close_one_pack(void)
+static int close_one_pack(struct repository *repo)
 {
 	struct packed_git *p, *lru_p = NULL;
 	struct pack_window *mru_w = NULL;
 	int accept_windows_inuse = 1;
 
-	for (p = the_repository->objects->packed_git; p; p = p->next) {
+	for (p = repo->objects->packed_git; p; p = p->next) {
 		if (p->pack_fd == -1)
 			continue;
 		find_lru_pack(p, &lru_p, &mru_w, &accept_windows_inuse);
@@ -535,7 +535,7 @@ const char *pack_basename(struct packed_git *p)
  * Do not call this directly as this leaks p->pack_fd on error return;
  * call open_packed_git() instead.
  */
-static int open_packed_git_1(struct packed_git *p)
+static int open_packed_git_1(struct repository *repo, struct packed_git *p)
 {
 	struct stat st;
 	struct pack_header hdr;
@@ -557,7 +557,7 @@ static int open_packed_git_1(struct packed_git *p)
 			pack_max_fds = 1;
 	}
 
-	while (pack_max_fds <= pack_open_fds && close_one_pack())
+	while (pack_max_fds <= pack_open_fds && close_one_pack(repo))
 		; /* nothing */
 
 	p->pack_fd = git_open(p->pack_name);
@@ -599,14 +599,14 @@ static int open_packed_git_1(struct packed_git *p)
 	if (read_result != hashsz)
 		return error("packfile %s signature is unavailable", p->pack_name);
 	idx_hash = ((unsigned char *)p->index_data) + p->index_size - hashsz * 2;
-	if (!hasheq(hash, idx_hash, the_repository->hash_algo))
+	if (!hasheq(hash, idx_hash, repo->hash_algo))
 		return error("packfile %s does not match index", p->pack_name);
 	return 0;
 }
 
-static int open_packed_git(struct packed_git *p)
+static int open_packed_git(struct repository *repo, struct packed_git *p)
 {
-	if (!open_packed_git_1(p))
+	if (!open_packed_git_1(repo, p))
 		return 0;
 	close_pack_fd(p);
 	return -1;
@@ -636,7 +636,7 @@ unsigned char *use_pack(struct repository *repo, struct packed_git *p,
 	 * hash, and the in_window function above wouldn't match
 	 * don't allow an offset too close to the end of the file.
 	 */
-	if (!p->pack_size && p->pack_fd == -1 && open_packed_git(p))
+	if (!p->pack_size && p->pack_fd == -1 && open_packed_git(repo, p))
 		die("packfile %s cannot be accessed", p->pack_name);
 	if (offset > (p->pack_size - the_hash_algo->rawsz))
 		die("offset beyond end of packfile (truncated pack?)");
@@ -654,7 +654,7 @@ unsigned char *use_pack(struct repository *repo, struct packed_git *p,
 			size_t window_align = packed_git_window_size / 2;
 			off_t len;
 
-			if (p->pack_fd == -1 && open_packed_git(p))
+			if (p->pack_fd == -1 && open_packed_git(repo, p))
 				die("packfile %s cannot be accessed", p->pack_name);
 
 			CALLOC_ARRAY(win, 1);
@@ -1994,7 +1994,7 @@ off_t find_pack_entry_one(const unsigned char *sha1,
 	return 0;
 }
 
-int is_pack_valid(struct packed_git *p)
+int is_pack_valid(struct repository *repo, struct packed_git *p)
 {
 	/* An already open pack is known to be valid. */
 	if (p->pack_fd != -1)
@@ -2012,7 +2012,7 @@ int is_pack_valid(struct packed_git *p)
 	}
 
 	/* Force the pack to open to prove its valid. */
-	return !open_packed_git(p);
+	return !open_packed_git(repo, p);
 }
 
 struct packed_git *find_sha1_pack(const unsigned char *sha1,
@@ -2049,7 +2049,7 @@ static int fill_pack_entry(const struct object_id *oid,
 	 * answer, as it may have been deleted since the index was
 	 * loaded!
 	 */
-	if (!is_pack_valid(p))
+	if (!is_pack_valid(the_repository, p))
 		return 0;
 	e->offset = offset;
 	e->p = p;
diff --git a/packfile.h b/packfile.h
index 90a1f2e1cf..b74d649c23 100644
--- a/packfile.h
+++ b/packfile.h
@@ -163,7 +163,7 @@ off_t nth_packed_object_offset(const struct packed_git *, uint32_t n);
  */
 off_t find_pack_entry_one(const unsigned char *sha1, struct packed_git *);
 
-int is_pack_valid(struct packed_git *);
+int is_pack_valid(struct repository *repo, struct packed_git *);
 void *unpack_entry(struct repository *r, struct packed_git *, off_t, enum object_type *, unsigned long *);
 unsigned long unpack_object_header_buffer(const unsigned char *buf, unsigned long len, enum object_type *type, unsigned long *sizep);
 unsigned long get_size_from_delta(struct packed_git *, struct pack_window **, off_t);
-- 
2.47.0

