Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199DE3A719C
	for <git@vger.kernel.org>; Thu, 21 May 2026 08:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779351772; cv=none; b=m2Jlzfyq2MQIRlGkk5ggmIC0efjHzQP+od1JJAygFXoUwlyKi6s84AlViyUNkimKM6HWDwj1EnVnkRBJMvNm8L57VLVvubcLe9UI6A3fq+L8Qdfw+C7YG7wWqJ1W/r71UZYHtrzzl5BuikuNKCCufuxzayZbaqqapfTGG3UilYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779351772; c=relaxed/simple;
	bh=6tWXIealgC7kFIDlfzN4npBrfxrPmmLgLq9i62yDXmo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o5cUGXZ2MD0kFip9jMYEZawvjGWMUCDbR/HDLPLz+pBZ4zO1paqpqiF3RJcCvXs7kyc/FgJfrmVnEM1aOtq+yKv7q9ajVi5OuMAOKlLZxex+2Tq13wq9+KUB/Pk+AhanPUbpfm2+38uUR9rZxwb0N+k7uN39w1COtTlghAW4/Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kooln5uu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AypOStbU; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kooln5uu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AypOStbU"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 7782BEC00A2
	for <git@vger.kernel.org>; Thu, 21 May 2026 04:22:49 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 21 May 2026 04:22:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779351769;
	 x=1779438169; bh=/bUWkFmNgSSMWTy7UtYeUuI+rdFIuEuC1amdpHNm8+Y=; b=
	kooln5uujD1wWQ8T7BrZlo7tVkjWEflr+OBu6wdDaW1KeqdzoHn12/WeJPBQXV+J
	b5SKA2w6mrLMuKRS4njklbvkM0EMUujVJ6lW/gZEgJvF+Dyk09FnRqJv80urzsw1
	fLzhAnPMSN7ZuLePhQ/Alwl7Z8ueuEH/h5p+BtuyeCt0xATkB0h0PFdBFi+dcQC0
	1Mp2ViigkauBpCBzBOtXGY/xnbQnSo4drFxlT9gxVex1rZlHlTHJGofpv43P3JQR
	66Ot5vn5GfLPNeH/yDNp3W1YCCp3KH5NC+qXrR7I1BVCFEXxqwFkTfhGqJQO/u8b
	fF2XGPdONz6xvBxHdZLQbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779351769; x=
	1779438169; bh=/bUWkFmNgSSMWTy7UtYeUuI+rdFIuEuC1amdpHNm8+Y=; b=A
	ypOStbUnmRCHFQYdj2kUE1kUMV2MUjLOsmLIgfyV23WoMGxS5JepGp1P1wuPs7I/
	CSuMOwPD50fE4GdPLAPXTN0E7fpXW2whOmSu0UupCOKHkVqFMDHNCbnFk11IzXgj
	RK+yj9FouNjOfy7/eGfgYwBmQ78nFf/ddeCW78i4nI+x89VmB68g3iAP7bHLCLBK
	6fT5V723PQ3DaFCIYbiF1sua0QnohNXNgDscj5MT1WjAn+qtreQmOb7a1yOzF5J/
	sfsV6yrpoLGxn+oKE5dKCUjtdRPrQkdzqwyzADAHF1HQf5sQiMMY6FSLkB3OIF2C
	sQOTkpLkNsMiVShj+6KxQ==
X-ME-Sender: <xms:2cAOak1pOvZNWIQQZVBqshXaIYdMrKbao7igWhH0Os7XazEvjXAfbw>
    <xme:2cAOamAYFtEvi3JN00JpWTsV9fivXOEy7dbiz7rfFTayt_L4PJCnPodiZ6PeFINBN
    E4M__ekhCUqyhyNMdsGVtrjLczluHlpDQngpv-LUSRGiCRjRiiLOA>
X-ME-Received: <xmr:2cAOaigM8RROgTfvWJKkT_GbOzcUBZumKygltDyrrKl-NUIgmayZZR0-bQRpq40woYrg8I6Njm1YAeAJOtnbKWi_96Y1Vgng_nWG_Y90Ye4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeejtddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:2cAOai-e48i5I6Cm8xzJk5AQanID1teojf1FbZWPvhlIH4DK5xXJFA>
    <xmx:2cAOam-JgT8dzbWOhgwpW9C_qpJwRRs45a7JoTkvZADhO4Iz_Kv7yg>
    <xmx:2cAOajAroCFQDuzZlt0-sxN21zSi07ouHtj1wZ8dTUYifCjOA4Iu0Q>
    <xmx:2cAOauyMPreaRrkhKr-fG-llRpyUvOQ2SOsNbbG64KNuyoNcguyRnA>
    <xmx:2cAOamHXR3h_747yilzmQXH0qK1MsHdBnkHdlqa9bi69UiXMMnQC3EID>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 21 May 2026 04:22:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fc13045b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 21 May 2026 08:22:47 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 21 May 2026 10:22:27 +0200
Subject: [PATCH 07/18] odb/source-loose: wire up `read_object_stream()`
 callback
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-b4-pks-odb-source-loose-v1-7-6553b399be2d@pks.im>
References: <20260521-b4-pks-odb-source-loose-v1-0-6553b399be2d@pks.im>
In-Reply-To: <20260521-b4-pks-odb-source-loose-v1-0-6553b399be2d@pks.im>
To: git@vger.kernel.org
Cc: 
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

