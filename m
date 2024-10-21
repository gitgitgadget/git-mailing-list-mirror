Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1651E3DFF
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 09:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729504691; cv=none; b=J4uqfwLwvuw1YH4eg9fBqv+O/RY6k6KdhsiAAKIEePIjDQoPsRILbPi7hz5zl9Z4lPgbfghtdqyYOpqI5eP6aLERzHNYgWXMt2CP4HjwiqpFln0iJ5XMq8QlDYcH6ge42AgR5WFx5Woft8UN9Q1wMBvL/cet6t1PL5ELdryfoQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729504691; c=relaxed/simple;
	bh=+IPMFTYMJo4dFOAzUebck09p0MRxXOxEyROrJt08l0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i84VWE0Ko54WVFkoYFqyvGPfX3Z9AqFMtoIRH0hAEHZ5BGhuDvF9wB05N8j/I/8l4zb8nugLURumhWveNDD4TSHEmfRAPeo3hgJTArhMDaM90sTag3c1IK5zEg2FzkCe+Qi0dzA0Fzm2lJrvHf6yeW6a+ZnXlKSxr6LvI13WWGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YzvYYlPp; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YzvYYlPp"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a99f3a5a44cso493032766b.3
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 02:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729504688; x=1730109488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JZz+6XO0ODupHR0Vy4M57AZG1ytUr+sb/Wm3taRqKtI=;
        b=YzvYYlPp8LiWnw5sKaeHoCr/lCQTA6oQcAmqQDLzSJiBZY5hCdfn2Ry/YtkH1thcVD
         PCCX1koIYj1BJAXOGELTjvk3T/EuPDkRd/vp8QR74vTvL/gR7qd4nuCNabkw/WvKatEG
         GvaJzQ1eTI7A338WwGbXAMPoYxoQMGnUdpCXPyfenefKlOz+yH+f/uRr68VNd6NFhBVl
         hKnqimNMi5rhOr+BaX5jICwVi8HKj7BcP7GrIepfHun85ofnuHuE/e+Htv8vYRj3B6oN
         yWouzKjaOUKGFQMBsQdCEiIh4ZecQn7y2MpFjsvF8s0pD3ByQFpsfzyA//VhxqDdn7DK
         438g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729504688; x=1730109488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JZz+6XO0ODupHR0Vy4M57AZG1ytUr+sb/Wm3taRqKtI=;
        b=azSS8DJ7lgolI8TKqc2hmfqfHog8BrOfTwYR/91mQgnMQZUr2fZBiErmTvAHLZNpOv
         IDR+AkoaAUx1pdNvm9d3hV8KYer5Coaz6W+wkLS4hKvzSTWoIzetD8evWwVGm3C847or
         +SOhk8ImEltJNiiTE49vIOkTMs/f1lWUOCrX5FdpveHs/LyOPSLgkTsYO4BZohaSt/RK
         DkBsT9j5LxkQTLTUNxOW+ihxL+nNKFHc0Xz0S98K/BmswegVymYE1rpBBbCDQIheOMAd
         0x8UVqlTF2uTqM3bT4pRtTOFJKowFikumU5ht6jNDKPJTWBtXaVy9MPyIMFgOxcLzSn0
         TEJw==
X-Gm-Message-State: AOJu0YxsTpx8mJ7Z3bOciFX6RSb5U9hL6mFNRDma/PJxZv5hsEcdU9Ic
	FKSVIBQ3whlWFoBl0JsYSU0gmaSn4S8DcA9ctgqgVULDWBKfca6sVGsusEzV
X-Google-Smtp-Source: AGHT+IEAa8DpzGJYb9/p7G9G5NHW/zrSnsl5VZ/IdUlOJCF/XHZWhX2rme69Qr3ZmoT6tGcTcPcM2Q==
X-Received: by 2002:a17:907:728b:b0:a8d:4631:83b0 with SMTP id a640c23a62f3a-a9a69969af5mr1222922866b.5.1729504687534;
        Mon, 21 Oct 2024 02:58:07 -0700 (PDT)
Received: from archlinux.fritz.box ([2a02:2455:825d:6a00:6bb4:436f:5699:ff21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912d631dsm187122266b.17.2024.10.21.02.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 02:58:07 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org
Subject: [PATCH 02/20] packfile: pass down repository to `unuse_one_window`
Date: Mon, 21 Oct 2024 11:57:45 +0200
Message-ID: <7ab2d08f354017ae20cc26c7078b7a38a7ab0ca5.1729504641.git.karthik.188@gmail.com>
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

The function `unuse_one_window` currently relies on the global variable
`the_repository`. To eliminate global variable usage in `packfile.c`, we
should progressively shift the dependency on the_repository to higher
layers. Let's remove its usage from this function and any related ones.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/pack-objects.c | 12 ++++++------
 pack-check.c           |  6 +++---
 packfile.c             | 25 +++++++++++++------------
 packfile.h             |  3 ++-
 streaming.c            |  2 +-
 5 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 0fc0680b40..4dd6ada184 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -401,7 +401,7 @@ static int check_pack_inflate(struct packed_git *p,
 	memset(&stream, 0, sizeof(stream));
 	git_inflate_init(&stream);
 	do {
-		in = use_pack(p, w_curs, offset, &stream.avail_in);
+		in = use_pack(the_repository, p, w_curs, offset, &stream.avail_in);
 		stream.next_in = in;
 		stream.next_out = fakebuf;
 		stream.avail_out = sizeof(fakebuf);
@@ -424,7 +424,7 @@ static void copy_pack_data(struct hashfile *f,
 	unsigned long avail;
 
 	while (len) {
-		in = use_pack(p, w_curs, offset, &avail);
+		in = use_pack(the_repository, p, w_curs, offset, &avail);
 		if (avail > len)
 			avail = (unsigned long)len;
 		hashwrite(f, in, avail);
@@ -2071,7 +2071,7 @@ static void check_object(struct object_entry *entry, uint32_t object_index)
 		enum object_type type;
 		unsigned long in_pack_size;
 
-		buf = use_pack(p, &w_curs, entry->in_pack_offset, &avail);
+		buf = use_pack(the_repository, p, &w_curs, entry->in_pack_offset, &avail);
 
 		/*
 		 * We want in_pack_type even if we do not reuse delta
@@ -2105,7 +2105,7 @@ static void check_object(struct object_entry *entry, uint32_t object_index)
 		case OBJ_REF_DELTA:
 			if (reuse_delta && !entry->preferred_base) {
 				oidread(&base_ref,
-					use_pack(p, &w_curs,
+					use_pack(the_repository, p, &w_curs,
 						 entry->in_pack_offset + used,
 						 NULL),
 					the_repository->hash_algo);
@@ -2114,7 +2114,7 @@ static void check_object(struct object_entry *entry, uint32_t object_index)
 			entry->in_pack_header_size = used + the_hash_algo->rawsz;
 			break;
 		case OBJ_OFS_DELTA:
-			buf = use_pack(p, &w_curs,
+			buf = use_pack(the_repository, p, &w_curs,
 				       entry->in_pack_offset + used, NULL);
 			used_0 = 0;
 			c = buf[used_0++];
@@ -2574,7 +2574,7 @@ unsigned long oe_get_size_slow(struct packing_data *pack,
 
 	packing_data_lock(&to_pack);
 	w_curs = NULL;
-	buf = use_pack(p, &w_curs, e->in_pack_offset, &avail);
+	buf = use_pack(the_repository, p, &w_curs, e->in_pack_offset, &avail);
 	used = unpack_object_header_buffer(buf, avail, &type, &size);
 	if (used == 0)
 		die(_("unable to parse object header of %s"),
diff --git a/pack-check.c b/pack-check.c
index e883dae3f2..e4636e9897 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -34,7 +34,7 @@ int check_pack_crc(struct packed_git *p, struct pack_window **w_curs,
 
 	do {
 		unsigned long avail;
-		void *data = use_pack(p, w_curs, offset, &avail);
+		void *data = use_pack(the_repository, p, w_curs, offset, &avail);
 		if (avail > len)
 			avail = len;
 		data_crc = crc32(data_crc, data, avail);
@@ -70,7 +70,7 @@ static int verify_packfile(struct repository *r,
 	r->hash_algo->init_fn(&ctx);
 	do {
 		unsigned long remaining;
-		unsigned char *in = use_pack(p, w_curs, offset, &remaining);
+		unsigned char *in = use_pack(the_repository, p, w_curs, offset, &remaining);
 		offset += remaining;
 		if (!pack_sig_ofs)
 			pack_sig_ofs = p->pack_size - r->hash_algo->rawsz;
@@ -79,7 +79,7 @@ static int verify_packfile(struct repository *r,
 		r->hash_algo->update_fn(&ctx, in, remaining);
 	} while (offset < pack_sig_ofs);
 	r->hash_algo->final_fn(hash, &ctx);
-	pack_sig = use_pack(p, w_curs, pack_sig_ofs, NULL);
+	pack_sig = use_pack(the_repository, p, w_curs, pack_sig_ofs, NULL);
 	if (!hasheq(hash, pack_sig, the_repository->hash_algo))
 		err = error("%s pack checksum mismatch",
 			    p->pack_name);
diff --git a/packfile.c b/packfile.c
index e4569ea29d..b0a3bfcd72 100644
--- a/packfile.c
+++ b/packfile.c
@@ -273,14 +273,14 @@ static void scan_windows(struct packed_git *p,
 	}
 }
 
-static int unuse_one_window(struct packed_git *current)
+static int unuse_one_window(struct repository *repo, struct packed_git *current)
 {
 	struct packed_git *p, *lru_p = NULL;
 	struct pack_window *lru_w = NULL, *lru_l = NULL;
 
 	if (current)
 		scan_windows(current, &lru_p, &lru_w, &lru_l);
-	for (p = the_repository->objects->packed_git; p; p = p->next)
+	for (p = repo->objects->packed_git; p; p = p->next)
 		scan_windows(p, &lru_p, &lru_w, &lru_l);
 	if (lru_p) {
 		munmap(lru_w->base, lru_w->len);
@@ -625,10 +625,9 @@ static int in_window(struct pack_window *win, off_t offset)
 		&& (offset + the_hash_algo->rawsz) <= (win_off + win->len);
 }
 
-unsigned char *use_pack(struct packed_git *p,
-		struct pack_window **w_cursor,
-		off_t offset,
-		unsigned long *left)
+unsigned char *use_pack(struct repository *repo, struct packed_git *p,
+			struct pack_window **w_cursor,
+			off_t offset, unsigned long *left)
 {
 	struct pack_window *win = *w_cursor;
 
@@ -666,7 +665,7 @@ unsigned char *use_pack(struct packed_git *p,
 			win->len = (size_t)len;
 			pack_mapped += win->len;
 			while (packed_git_limit < pack_mapped
-				&& unuse_one_window(p))
+				&& unuse_one_window(repo, p))
 				; /* nothing */
 			win->base = xmmap_gently(NULL, win->len,
 				PROT_READ, MAP_PRIVATE,
@@ -1129,7 +1128,7 @@ unsigned long get_size_from_delta(struct packed_git *p,
 
 	git_inflate_init(&stream);
 	do {
-		in = use_pack(p, w_curs, curpos, &stream.avail_in);
+		in = use_pack(the_repository, p, w_curs, curpos, &stream.avail_in);
 		stream.next_in = in;
 		/*
 		 * Note: the window section returned by use_pack() must be
@@ -1185,7 +1184,7 @@ int unpack_object_header(struct packed_git *p,
 	 * the maximum deflated object size is 2^137, which is just
 	 * insane, so we know won't exceed what we have been given.
 	 */
-	base = use_pack(p, w_curs, *curpos, &left);
+	base = use_pack(the_repository, p, w_curs, *curpos, &left);
 	used = unpack_object_header_buffer(base, left, &type, sizep);
 	if (!used) {
 		type = OBJ_BAD;
@@ -1217,7 +1216,7 @@ off_t get_delta_base(struct packed_git *p,
 		     enum object_type type,
 		     off_t delta_obj_offset)
 {
-	unsigned char *base_info = use_pack(p, w_curs, *curpos, NULL);
+	unsigned char *base_info = use_pack(the_repository, p, w_curs, *curpos, NULL);
 	off_t base_offset;
 
 	/* use_pack() assured us we have [base_info, base_info + 20)
@@ -1264,7 +1263,8 @@ static int get_delta_base_oid(struct packed_git *p,
 			      off_t delta_obj_offset)
 {
 	if (type == OBJ_REF_DELTA) {
-		unsigned char *base = use_pack(p, w_curs, curpos, NULL);
+		unsigned char *base = use_pack(the_repository, p, w_curs,
+					       curpos, NULL);
 		oidread(oid, base, the_repository->hash_algo);
 		return 0;
 	} else if (type == OBJ_OFS_DELTA) {
@@ -1636,7 +1636,8 @@ static void *unpack_compressed_entry(struct packed_git *p,
 
 	git_inflate_init(&stream);
 	do {
-		in = use_pack(p, w_curs, curpos, &stream.avail_in);
+		in = use_pack(the_repository, p, w_curs, curpos,
+			      &stream.avail_in);
 		stream.next_in = in;
 		/*
 		 * Note: we must ensure the window section returned by
diff --git a/packfile.h b/packfile.h
index 507ac602b5..90a1f2e1cf 100644
--- a/packfile.h
+++ b/packfile.h
@@ -110,7 +110,8 @@ uint32_t get_pack_fanout(struct packed_git *p, uint32_t value);
 
 struct raw_object_store;
 
-unsigned char *use_pack(struct packed_git *, struct pack_window **, off_t, unsigned long *);
+unsigned char *use_pack(struct repository *repo, struct packed_git *,
+			struct pack_window **, off_t, unsigned long *);
 void close_pack_windows(struct packed_git *);
 void close_pack(struct packed_git *);
 void close_object_store(struct raw_object_store *o);
diff --git a/streaming.c b/streaming.c
index 38839511af..58b3b3cff7 100644
--- a/streaming.c
+++ b/streaming.c
@@ -292,7 +292,7 @@ static ssize_t read_istream_pack_non_delta(struct git_istream *st, char *buf,
 		struct pack_window *window = NULL;
 		unsigned char *mapped;
 
-		mapped = use_pack(st->u.in_pack.pack, &window,
+		mapped = use_pack(the_repository, st->u.in_pack.pack, &window,
 				  st->u.in_pack.pos, &st->z.avail_in);
 
 		st->z.next_out = (unsigned char *)buf + total_read;
-- 
2.47.0

