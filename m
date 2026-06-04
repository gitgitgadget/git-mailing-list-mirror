Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C45409607
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 10:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780570283; cv=none; b=gvrBSEhL63bCMyxsy+ZzFWkCvsCBivw4iCplKUqN1e/SKnHy9YyTHmVsi/zKQUvx81Hm+5FpfI9JFH1jA/eb2LF/H511hQ2Pggk/dbru27dHCsbFpZCUxHBl2yXg51mM/OLAFEGhlEx68XBzrMk7ERuDXVlZTTQmszt+SFq9jUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780570283; c=relaxed/simple;
	bh=dyVNR+V2gM+vFetpKUlbK4VdPnpreMjpIaurnXdWTso=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ZfMqGLYmSdzpxJogbae9L+VpP5RZXb8Y3LoHSOSv2f8phqH/7yCCUFjs/78Zgjy+r5CfAifTg+rJMh4mzz/LFCPR2WAlXsxw9GZTuVumPjyCeKabCm+SpHs9cFRNXQnRKTruGAJvWwVJzN7edajc4o1NdS6az9zTJBXNdiMDtZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VVgINlfg; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVgINlfg"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-137f3cb3f46so487730c88.0
        for <git@vger.kernel.org>; Thu, 04 Jun 2026 03:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780570281; x=1781175081; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NMa0Nd3W8HH5T9A7ZPAtp4QkMilAyxUsm4kBqBMDqJM=;
        b=VVgINlfg80d0djOkSL6ucKve3Q1euTN5FNf59U3Ty4wG0fv4MoZNTfeFlkcmaxVhYg
         jxCckwy1B+hevhKa6ZxyeyEXpHzY4IIQBeQDOIG+GgT1D816VoCck+hNCz+/731QpuUq
         tw0ggsMG3ZN8FKI9CUYHuAgreJmB8avTIGL3oYAALdxUoR40ebuDkDMm1wTTyogdHg2f
         X/Dd1jlDrxZLaJ6iy3WD36bYGz0skdIwJxd7ptz/g7XUbASV5Kvvkt/CH0/Rt88bOoEz
         ctJynSvWj6D6Hv4u4VSnWunbh86+nXYGZQfx+OQagakPUU2YF5gXWJPNdj+rrA6UMPG0
         kuHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780570281; x=1781175081;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NMa0Nd3W8HH5T9A7ZPAtp4QkMilAyxUsm4kBqBMDqJM=;
        b=AowXwzWZff5MPT/qSeZUwURpZqGkdcV4oouQTPA693M1VzzW64zDApNRyryAacwthp
         FvJQPusphRTS84QhLP6OSO9iFfeNsoeYq3E8nxSIuKGwZxmeY9jYkZXHlUB6WBh43ErG
         ejOqm43SJau/BTDTa31fcf5X9HWx3t0WssFdMHFluPnv1l93swZVe9py0oTIBwQH3ApX
         95UQZ0SdEQLDxyFnec6E+ZRh+FJ915nXqULUaJ10SDTFBmpVsC+s55KTAeweepzJCbJg
         oOdwbsUvrh4KgI+qCL0zje1QS4Y6H6RO+1lZ4UQ3FHpSaqCaLTQAtnqjftvb/h0iWkLv
         E/gg==
X-Gm-Message-State: AOJu0Yx7dDWpekSMBPCDxkq17eZyELqS4ysFS6aiaTa3CJo+oA46ROtj
	A6DrzrEEtFil91YWNmOIJ838d/8JK9JI1OW4Mzyqjl5zI3YWb/w+Oy6UENZKiQ==
X-Gm-Gg: Acq92OH06A3nFBAWqHpdHk3M5gyZ2b0eT6BPtyIO4J/J0anXi04Tk4IT6LOy8/OyzpY
	sbM1R2s1/w5ZcElK088MyLjqlTx+xF9AIrF2wT04S/WYqfRqIodTln77QQ3LJAnXri3k1r8zLge
	xH3IxDiohqtMQ7NJ7xEUqSCnc3uYm3MVePpgsPfUdMrBrXqpi1MwJW/gLl/gCGMcIdu/S8aXoaM
	K/gKOskob3OtToDTKEAkFriQ8Jd2XGu805yVHbENtMXl5+SBQ7TuCriuRkAfTFEmPK57DFTjpc2
	SO2ZGj0ILQUpYbuUW3ykKi+44Y4LqMIqzes4nMUV13Aw3dewqjjJGyT9Pd5WfpO8GPSi2+uidyn
	YAeYTZ0xvaUIxTB8DMsq0Cg0i0tpRQ1SdiyQyUj8Xuac50IcOn3DvgxayDUHRr0re7vCsuNVly/
	nasXW59tDmo3eD5HerOiaif3ln9dRm4yLX1q4TcQ==
X-Received: by 2002:a05:7022:f95:b0:137:8921:4fe1 with SMTP id a92af1059eb24-137f6c3723amr3319991c88.37.1780570280813;
        Thu, 04 Jun 2026 03:51:20 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.209.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137f5550bcdsm3756759c88.14.2026.06.04.03.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 03:51:20 -0700 (PDT)
Message-Id: <bdebc36f21d1e2a13bc91d72a3ada1db3f7e184e.1780570273.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2137.git.1780570272.gitgitgadget@gmail.com>
References: <pull.2137.git.1780570272.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 04 Jun 2026 10:51:09 +0000
Subject: [PATCH 4/7] packfile: widen unpack_entry()'s size out-parameter to
 size_t
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Kristofer Karlsson <krka@spotify.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The topic `js/objects-larger-than-4gb-on-windows` widened the streaming,
index-pack and unpack-objects paths to `size_t` but deliberately stopped
at the in-memory `unpack_entry()` cascade, which still hands back the
unpacked size through `unsigned long *`.  On Windows that boundary
truncates above 4 GiB because that data type is only 32 bits wide on
that platform.

Widen the code path. Except `packed_object_info_with_index_pos()`: It
cannot yet pass `oi->sizep` directly because the field is still
`unsigned long *`; bridge it with a `size_t` temporary that narrows
back, and let a later commit drop the bridge once the field is wide
too. `gfi_unpack_entry()` keeps its narrow signature because fast-import
tracks sizes through `unsigned long` everywhere it crosses subsystem
boundaries, keeping its signature allows the scope of this commit to be
somewhat reasonable, still.

Assisted-by: Opus 4.7
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/fast-import.c |  7 ++++++-
 pack-check.c          |  5 ++---
 packfile.c            | 28 +++++++++++++++++-----------
 packfile.h            |  3 ++-
 4 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 82bc6dcc00..3dff898c43 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -1239,6 +1239,8 @@ static void *gfi_unpack_entry(
 	unsigned long *sizep)
 {
 	enum object_type type;
+	size_t size_st = 0;
+	void *data;
 	struct packed_git *p = all_packs[oe->pack_id];
 	if (p == pack_data && p->pack_size < (pack_size + the_hash_algo->rawsz)) {
 		/* The object is stored in the packfile we are writing to
@@ -1260,7 +1262,10 @@ static void *gfi_unpack_entry(
 		 */
 		p->pack_size = pack_size + the_hash_algo->rawsz;
 	}
-	return unpack_entry(the_repository, p, oe->idx.offset, &type, sizep);
+	data = unpack_entry(the_repository, p, oe->idx.offset, &type, &size_st);
+	if (sizep)
+		*sizep = cast_size_t_to_ulong(size_st);
+	return data;
 }
 
 static void load_tree(struct tree_entry *root)
diff --git a/pack-check.c b/pack-check.c
index 2792f34d25..5adfb3f272 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -143,9 +143,8 @@ static int verify_packfile(struct repository *r,
 			data = NULL;
 			data_valid = 0;
 		} else {
-			unsigned long sz;
-			data = unpack_entry(r, p, entries[i].offset, &type, &sz);
-			size = sz;
+			data = unpack_entry(r, p, entries[i].offset, &type,
+					    &size);
 			data_valid = 1;
 		}
 
diff --git a/packfile.c b/packfile.c
index e202f48837..dab0a9b16d 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1454,7 +1454,7 @@ struct delta_base_cache_entry {
 	struct delta_base_cache_key key;
 	struct list_head lru;
 	void *data;
-	unsigned long size;
+	size_t size;
 	enum object_type type;
 };
 
@@ -1525,7 +1525,7 @@ static void detach_delta_base_cache_entry(struct delta_base_cache_entry *ent)
 }
 
 static void *cache_or_unpack_entry(struct repository *r, struct packed_git *p,
-				   off_t base_offset, unsigned long *base_size,
+				   off_t base_offset, size_t *base_size,
 				   enum object_type *type)
 {
 	struct delta_base_cache_entry *ent;
@@ -1558,8 +1558,8 @@ void clear_delta_base_cache(void)
 }
 
 static void add_delta_base_cache(struct packed_git *p, off_t base_offset,
-				 void *base, unsigned long base_size,
-				 unsigned long delta_base_cache_limit,
+				 void *base, size_t base_size,
+				 size_t delta_base_cache_limit,
 				 enum object_type type)
 {
 	struct delta_base_cache_entry *ent;
@@ -1614,10 +1614,13 @@ static int packed_object_info_with_index_pos(struct packed_git *p, off_t obj_off
 	 * a "real" type later if the caller is interested.
 	 */
 	if (oi->contentp) {
-		*oi->contentp = cache_or_unpack_entry(p->repo, p, obj_offset, oi->sizep,
-						      &type);
+		size_t size_st = 0;
+		*oi->contentp = cache_or_unpack_entry(p->repo, p, obj_offset,
+						      &size_st, &type);
 		if (!*oi->contentp)
 			type = OBJ_BAD;
+		else if (oi->sizep)
+			*oi->sizep = cast_size_t_to_ulong(size_st);
 	} else if (oi->sizep || oi->typep || oi->delta_base_oid) {
 		type = unpack_object_header(p, &w_curs, &curpos, &size);
 	}
@@ -1735,7 +1738,7 @@ int packed_object_info(struct packed_git *p, off_t obj_offset,
 static void *unpack_compressed_entry(struct packed_git *p,
 				    struct pack_window **w_curs,
 				    off_t curpos,
-				    unsigned long size)
+				    size_t size)
 {
 	int st;
 	git_zstream stream;
@@ -1790,11 +1793,11 @@ int do_check_packed_object_crc;
 struct unpack_entry_stack_ent {
 	off_t obj_offset;
 	off_t curpos;
-	unsigned long size;
+	size_t size;
 };
 
 void *unpack_entry(struct repository *r, struct packed_git *p, off_t obj_offset,
-		   enum object_type *final_type, unsigned long *final_size)
+		   enum object_type *final_type, size_t *final_size)
 {
 	struct pack_window *w_curs = NULL;
 	off_t curpos = obj_offset;
@@ -1911,7 +1914,7 @@ void *unpack_entry(struct repository *r, struct packed_git *p, off_t obj_offset,
 		void *delta_data;
 		void *base = data;
 		void *external_base = NULL;
-		unsigned long delta_size, base_size = size;
+		size_t delta_size, base_size = size;
 		int i;
 		off_t base_obj_offset = obj_offset;
 
@@ -1928,6 +1931,7 @@ void *unpack_entry(struct repository *r, struct packed_git *p, off_t obj_offset,
 			struct object_id base_oid;
 			if (!(offset_to_pack_pos(p, obj_offset, &pos))) {
 				struct object_info oi = OBJECT_INFO_INIT;
+				unsigned long bsz_ul = 0;
 
 				nth_packed_object_id(&base_oid, p,
 						     pack_pos_to_index(p, pos));
@@ -1938,11 +1942,13 @@ void *unpack_entry(struct repository *r, struct packed_git *p, off_t obj_offset,
 				mark_bad_packed_object(p, &base_oid);
 
 				oi.typep = &type;
-				oi.sizep = &base_size;
+				oi.sizep = &bsz_ul;
 				oi.contentp = &base;
 				if (odb_read_object_info_extended(r->objects, &base_oid,
 								  &oi, 0) < 0)
 					base = NULL;
+				else
+					base_size = bsz_ul;
 
 				external_base = base;
 			}
diff --git a/packfile.h b/packfile.h
index 49d6bdecf6..0b5ae3f9fc 100644
--- a/packfile.h
+++ b/packfile.h
@@ -455,7 +455,8 @@ off_t nth_packed_object_offset(const struct packed_git *, uint32_t n);
 off_t find_pack_entry_one(const struct object_id *oid, struct packed_git *);
 
 int is_pack_valid(struct packed_git *);
-void *unpack_entry(struct repository *r, struct packed_git *, off_t, enum object_type *, unsigned long *);
+void *unpack_entry(struct repository *r, struct packed_git *, off_t,
+		   enum object_type *, size_t *);
 unsigned long unpack_object_header_buffer(const unsigned char *buf, unsigned long len, enum object_type *type, size_t *sizep);
 unsigned long get_size_from_delta(struct packed_git *, struct pack_window **, off_t);
 int unpack_object_header(struct packed_git *, struct pack_window **, off_t *, size_t *);
-- 
gitgitgadget

