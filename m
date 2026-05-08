Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B42363C43
	for <git@vger.kernel.org>; Fri,  8 May 2026 08:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778228219; cv=none; b=R+3OVRstOctsr+DB6y1KO7sm4ygBmGcQQwmNhzBITOnFCtTRteRG34EjpRl4crwep67gtkXgK4WjZ+leexNM0VUFNgIkYGRQkjP76Hf9e4cFTLgBOzxTsyHat+cWd/7ngBhf3LtXLugwZn08rl0XN7c/UoxtWvsrs9o+9uu+bOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778228219; c=relaxed/simple;
	bh=Tf+bxqmSmeCVc+aU45mo5iXD9WuROljxurXDao6MK80=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=JBpi9UqCyLMX/2grAB2/yvvoSoPVaWE929dSKwefQ6p4LiDnnhQxoENHs6VcUE98Ugg4SesiBhSt0BgPb17EpRmw5fYgVPAXWwN2sAfZKrFC0fsxzCl6PC8DNKUY5trHwpWOL4jBPAjnxA/LoZWeMA5Vm/KE6W/sgheLfP7b0Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KfwY3wVk; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KfwY3wVk"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8b3d6b215cfso30271586d6.3
        for <git@vger.kernel.org>; Fri, 08 May 2026 01:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778228216; x=1778833016; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VtENZnLO1kFe9WZuHyJe6HhYKS4Zn3PXqzhlJv1OcJs=;
        b=KfwY3wVk/8RkGffTZ4q+Xb5rTS8uyhFoJ7Ove4VcCWC9U6HvHl4GRNaFevXF/Z0qa7
         L5e/TVjAqnemRUdSOXhxn+rlP3+CqvkpJhFGo2rVjeSYXEea04+C2MfIvQI8PVaYLfOg
         Hx7pcmCz4VCcbfeVIPtZkg89rhtm9O0b4oz7GNWZ4zHi7NJj8DHpwluT1XvF8LswcufS
         a4cjRdfwXBkzrZqP3E7Q4dZjwhBh0q+GsPpOXrOQ9XwHGYf+x6q1+WgMxOeaeREFvAoc
         PFOoG0JMfk+OF0bSwXafL1k8eSpuCEGhPhjm9wd3SZHz7wF1kEdnGSjP6tz4WbGj/NKE
         4YJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778228216; x=1778833016;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VtENZnLO1kFe9WZuHyJe6HhYKS4Zn3PXqzhlJv1OcJs=;
        b=RdHwA6ZfrtwcaOeOXhDbHRPRv3A8QXstLhfRriRfvlIys1d60nsxwQ45txUUzQt8r/
         c57TqN1unxaHnSXKyCodBly7zlnhTQgCkMfJ3mmIq2tJtKCNUmhBz59InGc9W0Biaw+H
         YLd7opz+I6UoTRwd9nhJmlP1F1SGJ9O9qhaBRidb+BmXAmukCe2U+rersmmWvPx8dohE
         8L8SxvPnnJrmpBTBqS+1T7lqWPiZyHu/TFDroamx+Jti7jBYbs1u+37qHiurmQMmVX4o
         hS7hHp5M/GR5UiJU89Tih4shScY7BkB58wph6LIpSo8dPJbjQAr//umzOe9zPlNA0OZc
         K+pQ==
X-Gm-Message-State: AOJu0YwQENim3OB2U4jddcwtFsPS/fHHQNCXFLzDHVG1Mc1BIogMzwNP
	Ng0jXw3t8BXZsX8QETMqheoMX6AhfgraIaYWlrDK4Yptv6TpAPuTcmG/CM4Dww==
X-Gm-Gg: Acq92OF1nWxrkXQeXN8deA1ThSs2oLyf9wMlGofQc4G7XgoyrGYDENT4KFF0nns5D+w
	wuniHYSRobvwJIjulejm04/Xv/of3CnrSL3PznG4nIj8/IO5AfXQyukV816QepnwhX79gbUrB+Q
	8yc/n5PBKf91+cczpKKBuE1nsk0QK4PWKh9wC/oOwhD1QMQE8YOPS3Kea/TG5lPLtYowIktEkIH
	I1+R3QCFzK00iTbimonh6Y6KpzlqtZXQFzewXtosX0etaf4MbT0yfZETrfWii0re7MBoVx+89kf
	qhTXPE5F7f0MFo4Q/cInjEb46vqDEXAsrDuvm9BcdQGj5oBuulDCJuUXUaEDG56+0nPZqj2IVTN
	7o7m54JeZGQMPUjOJPP93i9B7n+WX/mOylRFMEQQzr/lv3i2LzfVN2UNxBXJC8CVe+DvdbIz2dR
	hdgxj4F/lESPMHIKIxsBFgd1mPvw==
X-Received: by 2002:a05:6214:130b:b0:89c:8a0f:55a0 with SMTP id 6a1803df08f44-8bc42f55059mr161452826d6.16.1778228216226;
        Fri, 08 May 2026 01:16:56 -0700 (PDT)
Received: from [127.0.0.1] ([40.76.117.241])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b53d450dcbsm230654476d6.45.2026.05.08.01.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 01:16:55 -0700 (PDT)
Message-Id: <b789f57de9dc21636db6dc6dd94ffebc2bbb351a.1778228209.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2102.v3.git.1778228209.gitgitgadget@gmail.com>
References: <pull.2102.v2.git.1777914508.gitgitgadget@gmail.com>
	<pull.2102.v3.git.1778228209.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 08 May 2026 08:16:41 +0000
Subject: [PATCH v3 03/11] odb, packfile: use size_t for streaming object sizes
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>,
    Torsten =?UTF-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
    Jeff King <peff@peff.net>,
    Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The odb_read_stream structure uses unsigned long for the size field,
which is 32-bit on Windows even in 64-bit builds. When streaming
objects larger than 4GB, the size would be truncated to zero or an
incorrect value, resulting in empty files being written to disk.

Change the size field in odb_read_stream to size_t and introduce
unpack_object_header_sz() to return sizes via size_t pointer. Since
object_info.sizep remains unsigned long for API compatibility, use
temporary variables where the types differ, with comments noting the
truncation limitation for code paths that still use unsigned long.

Widening the producers to size_t in this way introduces a handful of
silent size_t -> unsigned long narrowings on Windows, all in
builtin/pack-objects.c, where the consumers are still typed
unsigned long. Make those narrowings explicit with
cast_size_t_to_ulong() so they assert loudly the moment an object
actually exceeds ULONG_MAX bytes:

  - oe_get_size_slow() returns unsigned long but holds a size_t
    locally; cast at the return.
  - write_reuse_object() passes a size_t into check_pack_inflate(),
    whose expect parameter is unsigned long; cast at the call.
  - check_object() routes a size_t through SET_SIZE() and
    SET_DELTA_SIZE(), both of which take unsigned long via
    oe_set_size() / oe_set_delta_size(); cast at the three call
    sites in the OBJ_OFS_DELTA / OBJ_REF_DELTA branches and in the
    non-delta default arm.

The cast-only treatment is deliberately a stop-gap. Properly
widening oe_set_size, oe_get_size_slow's return type,
check_pack_inflate's expect parameter, object_info.sizep,
patch_delta, and the OE_SIZE_BITS bit-fields cascades into a series
that is too large to be reviewable, so the proper widening is
deferred to a follow-up topic. Until then,
cast_size_t_to_ulong() at least makes the truncation explicit at
the source: it documents the boundary, and on a 64-bit non-Windows
platform it is a no-op.

This was originally authored by LordKiRon <https://github.com/LordKiRon>,
who preferred not to reveal their real name and therefore agreed that I
take over authorship.

Helped-by: Torsten Bögershausen <tboegi@web.de>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/pack-objects.c       | 34 ++++++++++++++++++++++------------
 object-file.c                | 10 +++++++++-
 odb/streaming.c              | 13 ++++++++++++-
 odb/streaming.h              |  2 +-
 oss-fuzz/fuzz-pack-headers.c |  2 +-
 pack-bitmap.c                |  2 +-
 pack-check.c                 |  6 ++++--
 packfile.c                   | 24 +++++++++++++++---------
 packfile.h                   |  4 ++--
 9 files changed, 67 insertions(+), 30 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index dd2480a73d..480cc0bd8c 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -629,14 +629,21 @@ static off_t write_reuse_object(struct hashfile *f, struct object_entry *entry,
 	struct packed_git *p = IN_PACK(entry);
 	struct pack_window *w_curs = NULL;
 	uint32_t pos;
-	off_t offset;
+	off_t offset, cur;
 	enum object_type type = oe_type(entry);
+	enum object_type in_pack_type;
 	off_t datalen;
 	unsigned char header[MAX_PACK_OBJECT_HEADER],
 		      dheader[MAX_PACK_OBJECT_HEADER];
 	unsigned hdrlen;
 	const unsigned hashsz = the_hash_algo->rawsz;
-	unsigned long entry_size = SIZE(entry);
+	size_t entry_size;
+
+	cur = entry->in_pack_offset;
+	in_pack_type = unpack_object_header(p, &w_curs, &cur, &entry_size);
+	if (in_pack_type < 0)
+		die(_("write_reuse_object: unable to parse object header of %s"),
+		    oid_to_hex(&entry->idx.oid));
 
 	if (DELTA(entry))
 		type = (allow_ofs_delta && DELTA(entry)->idx.offset) ?
@@ -664,7 +671,8 @@ static off_t write_reuse_object(struct hashfile *f, struct object_entry *entry,
 	datalen -= entry->in_pack_header_size;
 
 	if (!pack_to_stdout && p->index_version == 1 &&
-	    check_pack_inflate(p, &w_curs, offset, datalen, entry_size)) {
+	    check_pack_inflate(p, &w_curs, offset, datalen,
+			       cast_size_t_to_ulong(entry_size))) {
 		error(_("corrupt packed object for %s"),
 		      oid_to_hex(&entry->idx.oid));
 		unuse_pack(&w_curs);
@@ -1087,7 +1095,7 @@ static void write_reused_pack_one(struct packed_git *reuse_packfile,
 {
 	off_t offset, next, cur;
 	enum object_type type;
-	unsigned long size;
+	size_t size;
 
 	offset = pack_pos_to_offset(reuse_packfile, pos);
 	next = pack_pos_to_offset(reuse_packfile, pos + 1);
@@ -2243,7 +2251,7 @@ static void check_object(struct object_entry *entry, uint32_t object_index)
 		off_t ofs;
 		unsigned char *buf, c;
 		enum object_type type;
-		unsigned long in_pack_size;
+		size_t in_pack_size;
 
 		buf = use_pack(p, &w_curs, entry->in_pack_offset, &avail);
 
@@ -2270,7 +2278,7 @@ static void check_object(struct object_entry *entry, uint32_t object_index)
 		default:
 			/* Not a delta hence we've already got all we need. */
 			oe_set_type(entry, entry->in_pack_type);
-			SET_SIZE(entry, in_pack_size);
+			SET_SIZE(entry, cast_size_t_to_ulong(in_pack_size));
 			entry->in_pack_header_size = used;
 			if (oe_type(entry) < OBJ_COMMIT || oe_type(entry) > OBJ_BLOB)
 				goto give_up;
@@ -2324,8 +2332,8 @@ static void check_object(struct object_entry *entry, uint32_t object_index)
 		if (have_base &&
 		    can_reuse_delta(&base_ref, entry, &base_entry)) {
 			oe_set_type(entry, entry->in_pack_type);
-			SET_SIZE(entry, in_pack_size); /* delta size */
-			SET_DELTA_SIZE(entry, in_pack_size);
+			SET_SIZE(entry, cast_size_t_to_ulong(in_pack_size)); /* delta size */
+			SET_DELTA_SIZE(entry, cast_size_t_to_ulong(in_pack_size));
 
 			if (base_entry) {
 				SET_DELTA(entry, base_entry);
@@ -2734,16 +2742,18 @@ unsigned long oe_get_size_slow(struct packing_data *pack,
 	struct pack_window *w_curs;
 	unsigned char *buf;
 	enum object_type type;
-	unsigned long used, avail, size;
+	unsigned long used, avail;
+	size_t size;
 
 	if (e->type_ != OBJ_OFS_DELTA && e->type_ != OBJ_REF_DELTA) {
+		unsigned long sz;
 		packing_data_lock(&to_pack);
 		if (odb_read_object_info(the_repository->objects,
-					 &e->idx.oid, &size) < 0)
+					 &e->idx.oid, &sz) < 0)
 			die(_("unable to get size of %s"),
 			    oid_to_hex(&e->idx.oid));
 		packing_data_unlock(&to_pack);
-		return size;
+		return sz;
 	}
 
 	p = oe_in_pack(pack, e);
@@ -2760,7 +2770,7 @@ unsigned long oe_get_size_slow(struct packing_data *pack,
 
 	unuse_pack(&w_curs);
 	packing_data_unlock(&to_pack);
-	return size;
+	return cast_size_t_to_ulong(size);
 }
 
 static int try_delta(struct unpacked *trg, struct unpacked *src,
diff --git a/object-file.c b/object-file.c
index 086b2b65ff..0be2981c7a 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2326,6 +2326,7 @@ int odb_source_loose_read_object_stream(struct odb_read_stream **out,
 	struct object_info oi = OBJECT_INFO_INIT;
 	struct odb_loose_read_stream *st;
 	unsigned long mapsize;
+	unsigned long size_ul;
 	void *mapped;
 
 	mapped = odb_source_loose_map_object(source, oid, &mapsize);
@@ -2349,11 +2350,18 @@ int odb_source_loose_read_object_stream(struct odb_read_stream **out,
 		goto error;
 	}
 
-	oi.sizep = &st->base.size;
+	/*
+	 * object_info.sizep is unsigned long* (32-bit on Windows), but
+	 * st->base.size is size_t (64-bit). Use temporary variable.
+	 * Note: loose objects >4GB would still truncate here, but such
+	 * large loose objects are uncommon (they'd normally be packed).
+	 */
+	oi.sizep = &size_ul;
 	oi.typep = &st->base.type;
 
 	if (parse_loose_header(st->hdr, &oi) < 0 || st->base.type < 0)
 		goto error;
+	st->base.size = size_ul;
 
 	st->mapped = mapped;
 	st->mapsize = mapsize;
diff --git a/odb/streaming.c b/odb/streaming.c
index 5927a12954..af2adf5ce7 100644
--- a/odb/streaming.c
+++ b/odb/streaming.c
@@ -157,15 +157,26 @@ static int open_istream_incore(struct odb_read_stream **out,
 		.base.read = read_istream_incore,
 	};
 	struct odb_incore_read_stream *st;
+	unsigned long size_ul;
 	int ret;
 
 	oi.typep = &stream.base.type;
-	oi.sizep = &stream.base.size;
+	/*
+	 * object_info.sizep is unsigned long* (32-bit on Windows), but
+	 * stream.base.size is size_t (64-bit). We use a temporary variable
+	 * because the types are incompatible. Note: this path still truncates
+	 * for >4GB objects, but large objects should use pack streaming
+	 * (packfile_store_read_object_stream) which handles size_t properly.
+	 * This incore fallback is only used for small objects or when pack
+	 * streaming is unavailable.
+	 */
+	oi.sizep = &size_ul;
 	oi.contentp = (void **)&stream.buf;
 	ret = odb_read_object_info_extended(odb, oid, &oi,
 					    OBJECT_INFO_DIE_IF_CORRUPT);
 	if (ret)
 		return ret;
+	stream.base.size = size_ul;
 
 	CALLOC_ARRAY(st, 1);
 	*st = stream;
diff --git a/odb/streaming.h b/odb/streaming.h
index c7861f7e13..517e2ea2d3 100644
--- a/odb/streaming.h
+++ b/odb/streaming.h
@@ -21,7 +21,7 @@ struct odb_read_stream {
 	odb_read_stream_close_fn close;
 	odb_read_stream_read_fn read;
 	enum object_type type;
-	unsigned long size; /* inflated size of full object */
+	size_t size; /* inflated size of full object */
 };
 
 /*
diff --git a/oss-fuzz/fuzz-pack-headers.c b/oss-fuzz/fuzz-pack-headers.c
index 150c0f5fa2..ef61ab577c 100644
--- a/oss-fuzz/fuzz-pack-headers.c
+++ b/oss-fuzz/fuzz-pack-headers.c
@@ -6,7 +6,7 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size);
 int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
 {
 	enum object_type type;
-	unsigned long len;
+	size_t len;
 
 	unpack_object_header_buffer((const unsigned char *)data,
 				    (unsigned long)size, &type, &len);
diff --git a/pack-bitmap.c b/pack-bitmap.c
index f6ec18d83a..f9af8a96bd 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -2270,7 +2270,7 @@ static int try_partial_reuse(struct bitmap_index *bitmap_git,
 {
 	off_t delta_obj_offset;
 	enum object_type type;
-	unsigned long size;
+	size_t size;
 
 	if (pack_pos >= pack->p->num_objects)
 		return -1; /* not actually in the pack */
diff --git a/pack-check.c b/pack-check.c
index 79992bb509..2792f34d25 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -110,7 +110,7 @@ static int verify_packfile(struct repository *r,
 		void *data;
 		struct object_id oid;
 		enum object_type type;
-		unsigned long size;
+		size_t size;
 		off_t curpos;
 		int data_valid;
 
@@ -143,7 +143,9 @@ static int verify_packfile(struct repository *r,
 			data = NULL;
 			data_valid = 0;
 		} else {
-			data = unpack_entry(r, p, entries[i].offset, &type, &size);
+			unsigned long sz;
+			data = unpack_entry(r, p, entries[i].offset, &type, &sz);
+			size = sz;
 			data_valid = 1;
 		}
 
diff --git a/packfile.c b/packfile.c
index b012d648ad..fdae91dd11 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1133,7 +1133,7 @@ out:
 }
 
 unsigned long unpack_object_header_buffer(const unsigned char *buf,
-		unsigned long len, enum object_type *type, unsigned long *sizep)
+		unsigned long len, enum object_type *type, size_t *sizep)
 {
 	unsigned shift;
 	size_t size, c;
@@ -1144,7 +1144,11 @@ unsigned long unpack_object_header_buffer(const unsigned char *buf,
 	size = c & 15;
 	shift = 4;
 	while (c & 0x80) {
-		if (len <= used || (bitsizeof(long) - 7) < shift) {
+		/*
+		 * Each continuation byte adds 7 bits. Ensure shift won't
+		 * overflow size_t (use size_t not long for 64-bit on Windows).
+		 */
+		if (len <= used || (bitsizeof(size_t) - 7) < shift) {
 			error("bad object header");
 			size = used = 0;
 			break;
@@ -1153,7 +1157,7 @@ unsigned long unpack_object_header_buffer(const unsigned char *buf,
 		size = st_add(size, st_left_shift(c & 0x7f, shift));
 		shift += 7;
 	}
-	*sizep = cast_size_t_to_ulong(size);
+	*sizep = size;
 	return used;
 }
 
@@ -1215,7 +1219,7 @@ unsigned long get_size_from_delta(struct packed_git *p,
 int unpack_object_header(struct packed_git *p,
 			 struct pack_window **w_curs,
 			 off_t *curpos,
-			 unsigned long *sizep)
+			 size_t *sizep)
 {
 	unsigned char *base;
 	unsigned long left;
@@ -1367,7 +1371,7 @@ static enum object_type packed_to_object_type(struct repository *r,
 
 	while (type == OBJ_OFS_DELTA || type == OBJ_REF_DELTA) {
 		off_t base_offset;
-		unsigned long size;
+		size_t size;
 		/* Push the object we're going to leave behind */
 		if (poi_stack_nr >= poi_stack_alloc && poi_stack == small_poi_stack) {
 			poi_stack_alloc = alloc_nr(poi_stack_nr);
@@ -1586,7 +1590,7 @@ static int packed_object_info_with_index_pos(struct packed_git *p, off_t obj_off
 					     uint32_t *maybe_index_pos, struct object_info *oi)
 {
 	struct pack_window *w_curs = NULL;
-	unsigned long size;
+	size_t size;
 	off_t curpos = obj_offset;
 	enum object_type type = OBJ_NONE;
 	uint32_t pack_pos;
@@ -1778,7 +1782,7 @@ void *unpack_entry(struct repository *r, struct packed_git *p, off_t obj_offset,
 	struct pack_window *w_curs = NULL;
 	off_t curpos = obj_offset;
 	void *data = NULL;
-	unsigned long size;
+	size_t size;
 	enum object_type type;
 	struct unpack_entry_stack_ent small_delta_stack[UNPACK_ENTRY_STACK_PREALLOC];
 	struct unpack_entry_stack_ent *delta_stack = small_delta_stack;
@@ -1943,8 +1947,10 @@ void *unpack_entry(struct repository *r, struct packed_git *p, off_t obj_offset,
 			      (uintmax_t)curpos, p->pack_name);
 			data = NULL;
 		} else {
+			unsigned long sz;
 			data = patch_delta(base, base_size, delta_data,
-					   delta_size, &size);
+					   delta_size, &sz);
+			size = sz;
 
 			/*
 			 * We could not apply the delta; warn the user, but
@@ -2929,7 +2935,7 @@ int packfile_read_object_stream(struct odb_read_stream **out,
 	struct odb_packed_read_stream *stream;
 	struct pack_window *window = NULL;
 	enum object_type in_pack_type;
-	unsigned long size;
+	size_t size;
 
 	in_pack_type = unpack_object_header(pack, &window, &offset, &size);
 	unuse_pack(&window);
diff --git a/packfile.h b/packfile.h
index 9b647da7dd..49d6bdecf6 100644
--- a/packfile.h
+++ b/packfile.h
@@ -456,9 +456,9 @@ off_t find_pack_entry_one(const struct object_id *oid, struct packed_git *);
 
 int is_pack_valid(struct packed_git *);
 void *unpack_entry(struct repository *r, struct packed_git *, off_t, enum object_type *, unsigned long *);
-unsigned long unpack_object_header_buffer(const unsigned char *buf, unsigned long len, enum object_type *type, unsigned long *sizep);
+unsigned long unpack_object_header_buffer(const unsigned char *buf, unsigned long len, enum object_type *type, size_t *sizep);
 unsigned long get_size_from_delta(struct packed_git *, struct pack_window **, off_t);
-int unpack_object_header(struct packed_git *, struct pack_window **, off_t *, unsigned long *);
+int unpack_object_header(struct packed_git *, struct pack_window **, off_t *, size_t *);
 off_t get_delta_base(struct packed_git *p, struct pack_window **w_curs,
 		     off_t *curpos, enum object_type type,
 		     off_t delta_obj_offset);
-- 
gitgitgadget

