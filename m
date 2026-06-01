Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B7138AC6A
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 08:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780302051; cv=none; b=G20UwqW31JZtxvJPV4hE1HRBNmt2pzDJjb0nszBzcRWH9SizJzPnlPJCA0LGop0cP/go1a0uu+umRlukXhd7tgE9pyM8qjhXOAbACdUxh10hSukIspSGuPoQvIW2GfYJfbqTvGgykNeT5HZaRSXcDKUDtcdFD4UvzMALFeWUH3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780302051; c=relaxed/simple;
	bh=6tWXIealgC7kFIDlfzN4npBrfxrPmmLgLq9i62yDXmo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nEO+gzuMxt0Hm7gcfHmngRN2fN5ZNhXmM+A1SZW80rLI/5kX4XJ7zYxgF2F6kyXZbVgQJwrnoJd/sbyeSEs+IzLFHCTgN9gqRBBrdBUCnY+HaUIVIvUW0uTXJu4rvxNRZDB06aP00PQg/O+JMJdzx8grmt84DrNJ2yEOCBc8GTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=vM9TFObR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kLNlGy9K; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="vM9TFObR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kLNlGy9K"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 86DFF1400082;
	Mon,  1 Jun 2026 04:20:47 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 01 Jun 2026 04:20:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780302047;
	 x=1780388447; bh=/bUWkFmNgSSMWTy7UtYeUuI+rdFIuEuC1amdpHNm8+Y=; b=
	vM9TFObRinVaVZ5HlpqPU4+duMfnNLgzaOsikdscAznnqb5Wal8LeX++f05VV4GD
	ZGzbWFkFVH4R+0nisp0kpoNvkqnVmFzVYrPNHBV4S8xv1pnozNtvG8lgqH5kCIjG
	8svBbYNo10ORrW1IbNyXmV4L3eUoO4F6hez7ipyZrI9ZmXOKPqUasrW9qrGwQsLr
	4Q98yX+90dLgTJ0SlgyxGc+L9RuDLZbQNSU5UPNF5M2eAc8ZBvCIJ+uRSYmxfcpc
	m1HIlVVDHGPf58MH4NTusV0/2NBvdzizXeBQcKXF2i7Mv8Hn5tCcAdNiGcjYHFd5
	MLaAoCtUmXNWB1IdQafzOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780302047; x=
	1780388447; bh=/bUWkFmNgSSMWTy7UtYeUuI+rdFIuEuC1amdpHNm8+Y=; b=k
	LNlGy9KSPRgJIEaUGPW0ml9uul9j8BGMx6wEtMIto/IvPmiRQ4S08QBsssHLPDCG
	H9FRE3cVBxTlgZR1ylH3OeXRUfbQq+9kviuFBI6HYUo7SUsPspnZUyNSs/rNu9JM
	qdoNIJ4AhbVRfZ5/qU5dZ2/zqSu3zwwMHSAxwE3WYd5tABTWOKTUZG3uP5rX+GD4
	CJwF0vpwA5Cl70LYI54kBxbRUDknPAm2L44VCfYRAibY4UeVhnu7TE6NvbiEbLa0
	8RUekQzL/JIOuvDZlgD1hUgeFyT//yp7Nv9kmM6ptfwnLH0yH4lzByy/s+8OxCec
	GQTQwgrWcfBVIKp65CUhA==
X-ME-Sender: <xms:30AdarxvhtLI4WoQ0Vn6sa-5Mqm-3CHbJGQKnjgemT7ZIvM-dSu8dg>
    <xme:30AdapQahE2aBiLpAUXe4qEkX7rW7GWziu3PFXPZs2y_5BjqblEGU154B6Yj5svZR
    TBglezUgk3lN6_lXtmpuj9nn86AZFr_SXEkLdv9Ji84WTK50O0>
X-ME-Received: <xmr:30Adai8_2b1o3CRVP3vIILvb2cdXLc5proWUt73n4oF1hnfpqyATDosNDFuy_-gyT3OxeY2tCD5TPDbwVlQzmVzJfIVzEfJxfGiwFDnoVZTt>
X-ME-Proxy-Cause: dmFkZTGMavhG2wq0jIIx4Z9fpJ7SWU4287r52kyZjBri7FU3ikyy1OWMGhoR5V3D51ljK9
    lhHzPs57OdYeulBavUlZ6jztEphzt0JLYZFwWnMYivsF+9rVBf0HTIlwrRN3/vvoI01lE+
    IIOALdfGOcWcRa6OceRP8/4VYaeW6MzCpodqhnwzlYhwWcVbQpJ6FF+7SHRnqqJBTXZCdk
    dqfxTu13i3Y1wM62VADlbIexbmbqm6iuWiaPpCIVKETdi0dzYk/Hv4Nh4Wy1U6pVGNEGx0
    xDgzFQwnNxX16CikY5ben40siPV8AY3IjEJyeSvTcYkeFIAPi2sqT+wec2c58Zs1YGKlp6
    cJjCfOx6ZmzH6kvNsX8eFJgm18b58fKUNeqJJFCGNFqBrjhJYXOaVGrxazJnbroWzJtKjl
    +Mw8wNA2fg27ZYLDTD7p3yX2LJH5QiJY2t+ORSAqpWs5iG6LYQvutn/J31257gWOjJepCJ
    KQPM/nmheqiNdy5iHMWgaf54g+V6/rIgYP8PFUieU4hSeXRVqkS7SBmvVd9N1on4WKhyxN
    eFWdputnEj0ejcmD+XMb4XW5RHMCYJmtqaPGUoJ//NoIbB0yVRvHbzEXuXk36M5rJ9TfB5
    Ar4+Yd70HQdoo3oaIqoXyVeBAon7+jJ2aGAYcX+yMB0serl+KoJBIINfSEqg
X-ME-Proxy: <xmx:30Adagpqci29FbJcQdtJfPxZJ4ioVNKBGJugwqnj37H5hKlPFJ0ufQ>
    <xmx:30Adavmf-nsGXJE5MK-40Y0OMF2wBxf32Wd00m5wRVza9_FyEY6ldA>
    <xmx:30AdanK-k_rAdr4RLn08J4RSH1D6Tzb4fJjE2imjovr4s5X030GuRg>
    <xmx:30Adakw1r7Zi8-AZJpTbF_yOeLSHG9tnUi5fhdiiKkZOCclnFv1LCQ>
    <xmx:30AdavIL2gUue0vI18JhwQANAHETgQYrTEXT31OHOzvOPS6Ufkt-FpKk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 04:20:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 593973b1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 1 Jun 2026 08:20:46 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 01 Jun 2026 10:20:30 +0200
Subject: [PATCH v2 07/18] odb/source-loose: wire up `read_object_stream()`
 callback
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-b4-pks-odb-source-loose-v2-7-90ff159430af@pks.im>
References: <20260601-b4-pks-odb-source-loose-v2-0-90ff159430af@pks.im>
In-Reply-To: <20260601-b4-pks-odb-source-loose-v2-0-90ff159430af@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

Move `odb_source_loose_read_object_stream()` and its associated helpers
from "object-file.c" into "odb/source-loose.c" and wire it up as the
`read_object_stream()` callback of the loose source.

As part of the move we are also forced to expose a couple of functions
from "object-file.h" that parse object headers in a somewhat-generic
way, as those functions are now used by both subsystems.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c      | 200 ++---------------------------------------------------
 object-file.h      |  31 +++++++--
 odb/source-files.c |   2 +-
 odb/source-loose.c | 189 ++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 222 insertions(+), 200 deletions(-)

diff --git a/object-file.c b/object-file.c
index fa174512a4..adfb672493 100644
--- a/object-file.c
+++ b/object-file.c
@@ -164,28 +164,6 @@ int stream_object_signature(struct repository *r,
 	return !oideq(oid, &real_oid) ? -1 : 0;
 }
 
-/*
- * Find "oid" as a loose object in given source, open the object and return its
- * file descriptor. Returns the file descriptor on success, negative on failure.
- *
- * The "path" out-parameter will give the path of the object we found (if any).
- * Note that it may point to static storage and is only valid until another
- * call to stat_loose_object().
- */
-static int open_loose_object(struct odb_source_loose *loose,
-			     const struct object_id *oid, const char **path)
-{
-	static struct strbuf buf = STRBUF_INIT;
-	int fd;
-
-	*path = odb_loose_path(&loose->files->base, &buf, oid);
-	fd = git_open(*path);
-	if (fd >= 0)
-		return fd;
-
-	return -1;
-}
-
 static int quick_has_loose(struct odb_source_loose *loose,
 			   const struct object_id *oid)
 {
@@ -215,42 +193,11 @@ static void *map_fd(int fd, const char *path, unsigned long *size)
 	return map;
 }
 
-static void *odb_source_loose_map_object(struct odb_source *source,
-					 const struct object_id *oid,
-					 unsigned long *size)
-{
-	struct odb_source_files *files = odb_source_files_downcast(source);
-	const char *p;
-	int fd = open_loose_object(files->loose, oid, &p);
-
-	if (fd < 0)
-		return NULL;
-	return map_fd(fd, p, size);
-}
-
-enum unpack_loose_header_result {
-	ULHR_OK,
-	ULHR_BAD,
-	ULHR_TOO_LONG,
-};
-
-/**
- * unpack_loose_header() initializes the data stream needed to unpack
- * a loose object header.
- *
- * Returns:
- *
- * - ULHR_OK on success
- * - ULHR_BAD on error
- * - ULHR_TOO_LONG if the header was too long
- *
- * It will only parse up to MAX_HEADER_LEN bytes.
- */
-static enum unpack_loose_header_result unpack_loose_header(git_zstream *stream,
-							   unsigned char *map,
-							   unsigned long mapsize,
-							   void *buffer,
-							   unsigned long bufsiz)
+enum unpack_loose_header_result unpack_loose_header(git_zstream *stream,
+						    unsigned char *map,
+						    unsigned long mapsize,
+						    void *buffer,
+						    unsigned long bufsiz)
 {
 	int status;
 
@@ -340,7 +287,7 @@ static void *unpack_loose_rest(git_zstream *stream,
  * too permissive for what we want to check. So do an anal
  * object header parse by hand.
  */
-static int parse_loose_header(const char *hdr, struct object_info *oi)
+int parse_loose_header(const char *hdr, struct object_info *oi)
 {
 	const char *type_buf = hdr;
 	size_t size;
@@ -2170,138 +2117,3 @@ struct odb_transaction *odb_transaction_files_begin(struct odb_source *source)
 
 	return &transaction->base;
 }
-
-struct odb_loose_read_stream {
-	struct odb_read_stream base;
-	git_zstream z;
-	enum {
-		ODB_LOOSE_READ_STREAM_INUSE,
-		ODB_LOOSE_READ_STREAM_DONE,
-		ODB_LOOSE_READ_STREAM_ERROR,
-	} z_state;
-	void *mapped;
-	unsigned long mapsize;
-	char hdr[32];
-	int hdr_avail;
-	int hdr_used;
-};
-
-static ssize_t read_istream_loose(struct odb_read_stream *_st, char *buf, size_t sz)
-{
-	struct odb_loose_read_stream *st =
-		container_of(_st, struct odb_loose_read_stream, base);
-	size_t total_read = 0;
-
-	switch (st->z_state) {
-	case ODB_LOOSE_READ_STREAM_DONE:
-		return 0;
-	case ODB_LOOSE_READ_STREAM_ERROR:
-		return -1;
-	default:
-		break;
-	}
-
-	if (st->hdr_used < st->hdr_avail) {
-		size_t to_copy = st->hdr_avail - st->hdr_used;
-		if (sz < to_copy)
-			to_copy = sz;
-		memcpy(buf, st->hdr + st->hdr_used, to_copy);
-		st->hdr_used += to_copy;
-		total_read += to_copy;
-	}
-
-	while (total_read < sz) {
-		int status;
-
-		st->z.next_out = (unsigned char *)buf + total_read;
-		st->z.avail_out = sz - total_read;
-		status = git_inflate(&st->z, Z_FINISH);
-
-		total_read = st->z.next_out - (unsigned char *)buf;
-
-		if (status == Z_STREAM_END) {
-			git_inflate_end(&st->z);
-			st->z_state = ODB_LOOSE_READ_STREAM_DONE;
-			break;
-		}
-		if (status != Z_OK && (status != Z_BUF_ERROR || total_read < sz)) {
-			git_inflate_end(&st->z);
-			st->z_state = ODB_LOOSE_READ_STREAM_ERROR;
-			return -1;
-		}
-	}
-	return total_read;
-}
-
-static int close_istream_loose(struct odb_read_stream *_st)
-{
-	struct odb_loose_read_stream *st =
-		container_of(_st, struct odb_loose_read_stream, base);
-
-	if (st->z_state == ODB_LOOSE_READ_STREAM_INUSE)
-		git_inflate_end(&st->z);
-	munmap(st->mapped, st->mapsize);
-	return 0;
-}
-
-int odb_source_loose_read_object_stream(struct odb_read_stream **out,
-					struct odb_source *source,
-					const struct object_id *oid)
-{
-	struct object_info oi = OBJECT_INFO_INIT;
-	struct odb_loose_read_stream *st;
-	unsigned long mapsize;
-	unsigned long size_ul;
-	void *mapped;
-
-	mapped = odb_source_loose_map_object(source, oid, &mapsize);
-	if (!mapped)
-		return -1;
-
-	/*
-	 * Note: we must allocate this structure early even though we may still
-	 * fail. This is because we need to initialize the zlib stream, and it
-	 * is not possible to copy the stream around after the fact because it
-	 * has self-referencing pointers.
-	 */
-	CALLOC_ARRAY(st, 1);
-
-	switch (unpack_loose_header(&st->z, mapped, mapsize, st->hdr,
-				    sizeof(st->hdr))) {
-	case ULHR_OK:
-		break;
-	case ULHR_BAD:
-	case ULHR_TOO_LONG:
-		goto error;
-	}
-
-	/*
-	 * object_info.sizep is unsigned long* (32-bit on Windows), but
-	 * st->base.size is size_t (64-bit). Use temporary variable.
-	 * Note: loose objects >4GB would still truncate here, but such
-	 * large loose objects are uncommon (they'd normally be packed).
-	 */
-	oi.sizep = &size_ul;
-	oi.typep = &st->base.type;
-
-	if (parse_loose_header(st->hdr, &oi) < 0 || st->base.type < 0)
-		goto error;
-	st->base.size = size_ul;
-
-	st->mapped = mapped;
-	st->mapsize = mapsize;
-	st->hdr_used = strlen(st->hdr) + 1;
-	st->hdr_avail = st->z.total_out;
-	st->z_state = ODB_LOOSE_READ_STREAM_INUSE;
-	st->base.close = close_istream_loose;
-	st->base.read = read_istream_loose;
-
-	*out = &st->base;
-
-	return 0;
-error:
-	git_inflate_end(&st->z);
-	munmap(mapped, mapsize);
-	free(st);
-	return -1;
-}
diff --git a/object-file.h b/object-file.h
index 8ac2832dac..d93b7ffad7 100644
--- a/object-file.h
+++ b/object-file.h
@@ -18,13 +18,8 @@ int index_fd(struct index_state *istate, struct object_id *oid, int fd, struct s
 int index_path(struct index_state *istate, struct object_id *oid, const char *path, struct stat *st, unsigned flags);
 
 struct object_info;
-struct odb_read_stream;
 struct odb_source;
 
-int odb_source_loose_read_object_stream(struct odb_read_stream **out,
-					struct odb_source *source,
-					const struct object_id *oid);
-
 /*
  * Return true iff an object database source has a loose object
  * with the specified name.  This function does not respect replace
@@ -199,6 +194,32 @@ int read_object_info_from_path(struct odb_source_loose *loose,
 			       struct object_info *oi,
 			       enum object_info_flags flags);
 
+enum unpack_loose_header_result {
+	ULHR_OK,
+	ULHR_BAD,
+	ULHR_TOO_LONG,
+};
+
+/**
+ * unpack_loose_header() initializes the data stream needed to unpack
+ * a loose object header.
+ *
+ * Returns:
+ *
+ * - ULHR_OK on success
+ * - ULHR_BAD on error
+ * - ULHR_TOO_LONG if the header was too long
+ *
+ * It will only parse up to MAX_HEADER_LEN bytes.
+ */
+enum unpack_loose_header_result unpack_loose_header(git_zstream *stream,
+						    unsigned char *map,
+						    unsigned long mapsize,
+						    void *buffer,
+						    unsigned long bufsiz);
+
+int parse_loose_header(const char *hdr, struct object_info *oi);
+
 struct odb_transaction;
 
 /*
diff --git a/odb/source-files.c b/odb/source-files.c
index 8d6924755f..90806ddf86 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -67,7 +67,7 @@ static int odb_source_files_read_object_stream(struct odb_read_stream **out,
 {
 	struct odb_source_files *files = odb_source_files_downcast(source);
 	if (!packfile_store_read_object_stream(out, files->packed, oid) ||
-	    !odb_source_loose_read_object_stream(out, source, oid))
+	    !odb_source_read_object_stream(out, &files->loose->base, oid))
 		return 0;
 	return -1;
 }
diff --git a/odb/source-loose.c b/odb/source-loose.c
index 50f387ecf3..4b82c6f316 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -1,11 +1,13 @@
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "chdir-notify.h"
+#include "gettext.h"
 #include "loose.h"
 #include "object-file.h"
 #include "odb.h"
 #include "odb/source-files.h"
 #include "odb/source-loose.h"
+#include "odb/streaming.h"
 #include "oidtree.h"
 #include "strbuf.h"
 
@@ -30,6 +32,192 @@ static int odb_source_loose_read_object_info(struct odb_source *source,
 	return read_object_info_from_path(loose, buf.buf, oid, oi, flags);
 }
 
+/*
+ * Find "oid" as a loose object in given source, open the object and return its
+ * file descriptor. Returns the file descriptor on success, negative on failure.
+ *
+ * The "path" out-parameter will give the path of the object we found (if any).
+ * Note that it may point to static storage and is only valid until another
+ * call to open_loose_object().
+ */
+static int open_loose_object(struct odb_source_loose *loose,
+			     const struct object_id *oid, const char **path)
+{
+	static struct strbuf buf = STRBUF_INIT;
+	int fd;
+
+	*path = odb_loose_path(&loose->base, &buf, oid);
+	fd = git_open(*path);
+	if (fd >= 0)
+		return fd;
+
+	return -1;
+}
+
+static void *odb_source_loose_map_object(struct odb_source_loose *loose,
+					 const struct object_id *oid,
+					 unsigned long *size)
+{
+	const char *p;
+	int fd = open_loose_object(loose, oid, &p);
+	void *map = NULL;
+	struct stat st;
+
+	if (fd < 0)
+		return NULL;
+
+	if (!fstat(fd, &st)) {
+		*size = xsize_t(st.st_size);
+		if (!*size) {
+			/* mmap() is forbidden on empty files */
+			error(_("object file %s is empty"), p);
+			goto out;
+		}
+
+		map = xmmap(NULL, *size, PROT_READ, MAP_PRIVATE, fd, 0);
+	}
+
+out:
+	close(fd);
+	return map;
+}
+
+struct odb_loose_read_stream {
+	struct odb_read_stream base;
+	git_zstream z;
+	enum {
+		ODB_LOOSE_READ_STREAM_INUSE,
+		ODB_LOOSE_READ_STREAM_DONE,
+		ODB_LOOSE_READ_STREAM_ERROR,
+	} z_state;
+	void *mapped;
+	unsigned long mapsize;
+	char hdr[32];
+	int hdr_avail;
+	int hdr_used;
+};
+
+static ssize_t read_istream_loose(struct odb_read_stream *_st, char *buf, size_t sz)
+{
+	struct odb_loose_read_stream *st =
+		container_of(_st, struct odb_loose_read_stream, base);
+	size_t total_read = 0;
+
+	switch (st->z_state) {
+	case ODB_LOOSE_READ_STREAM_DONE:
+		return 0;
+	case ODB_LOOSE_READ_STREAM_ERROR:
+		return -1;
+	default:
+		break;
+	}
+
+	if (st->hdr_used < st->hdr_avail) {
+		size_t to_copy = st->hdr_avail - st->hdr_used;
+		if (sz < to_copy)
+			to_copy = sz;
+		memcpy(buf, st->hdr + st->hdr_used, to_copy);
+		st->hdr_used += to_copy;
+		total_read += to_copy;
+	}
+
+	while (total_read < sz) {
+		int status;
+
+		st->z.next_out = (unsigned char *)buf + total_read;
+		st->z.avail_out = sz - total_read;
+		status = git_inflate(&st->z, Z_FINISH);
+
+		total_read = st->z.next_out - (unsigned char *)buf;
+
+		if (status == Z_STREAM_END) {
+			git_inflate_end(&st->z);
+			st->z_state = ODB_LOOSE_READ_STREAM_DONE;
+			break;
+		}
+		if (status != Z_OK && (status != Z_BUF_ERROR || total_read < sz)) {
+			git_inflate_end(&st->z);
+			st->z_state = ODB_LOOSE_READ_STREAM_ERROR;
+			return -1;
+		}
+	}
+	return total_read;
+}
+
+static int close_istream_loose(struct odb_read_stream *_st)
+{
+	struct odb_loose_read_stream *st =
+		container_of(_st, struct odb_loose_read_stream, base);
+
+	if (st->z_state == ODB_LOOSE_READ_STREAM_INUSE)
+		git_inflate_end(&st->z);
+	munmap(st->mapped, st->mapsize);
+	return 0;
+}
+
+static int odb_source_loose_read_object_stream(struct odb_read_stream **out,
+					       struct odb_source *source,
+					       const struct object_id *oid)
+{
+	struct odb_source_loose *loose = odb_source_loose_downcast(source);
+	struct object_info oi = OBJECT_INFO_INIT;
+	struct odb_loose_read_stream *st;
+	unsigned long mapsize;
+	unsigned long size_ul;
+	void *mapped;
+
+	mapped = odb_source_loose_map_object(loose, oid, &mapsize);
+	if (!mapped)
+		return -1;
+
+	/*
+	 * Note: we must allocate this structure early even though we may still
+	 * fail. This is because we need to initialize the zlib stream, and it
+	 * is not possible to copy the stream around after the fact because it
+	 * has self-referencing pointers.
+	 */
+	CALLOC_ARRAY(st, 1);
+
+	switch (unpack_loose_header(&st->z, mapped, mapsize, st->hdr,
+				    sizeof(st->hdr))) {
+	case ULHR_OK:
+		break;
+	case ULHR_BAD:
+	case ULHR_TOO_LONG:
+		goto error;
+	}
+
+	/*
+	 * object_info.sizep is unsigned long* (32-bit on Windows), but
+	 * st->base.size is size_t (64-bit). Use temporary variable.
+	 * Note: loose objects >4GB would still truncate here, but such
+	 * large loose objects are uncommon (they'd normally be packed).
+	 */
+	oi.sizep = &size_ul;
+	oi.typep = &st->base.type;
+
+	if (parse_loose_header(st->hdr, &oi) < 0 || st->base.type < 0)
+		goto error;
+	st->base.size = size_ul;
+
+	st->mapped = mapped;
+	st->mapsize = mapsize;
+	st->hdr_used = strlen(st->hdr) + 1;
+	st->hdr_avail = st->z.total_out;
+	st->z_state = ODB_LOOSE_READ_STREAM_INUSE;
+	st->base.close = close_istream_loose;
+	st->base.read = read_istream_loose;
+
+	*out = &st->base;
+
+	return 0;
+error:
+	git_inflate_end(&st->z);
+	munmap(mapped, mapsize);
+	free(st);
+	return -1;
+}
+
 static void odb_source_loose_clear_cache(struct odb_source_loose *loose)
 {
 	oidtree_clear(loose->cache);
@@ -84,6 +272,7 @@ struct odb_source_loose *odb_source_loose_new(struct odb_source_files *files)
 	loose->base.close = odb_source_loose_close;
 	loose->base.reprepare = odb_source_loose_reprepare;
 	loose->base.read_object_info = odb_source_loose_read_object_info;
+	loose->base.read_object_stream = odb_source_loose_read_object_stream;
 
 	if (!is_absolute_path(loose->base.path))
 		chdir_notify_register(NULL, odb_source_loose_reparent, loose);

-- 
2.54.0.926.g75ba10bac6.dirty

