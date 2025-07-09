Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BC128D8EB
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 11:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752059873; cv=none; b=VmPyLmO9iQRo8XMA1dFsnOQ5MnweThZWPea4vUHdDTu1Rlf8inW4//fJvf2Rr7mx1V2/nn8anOx1oGQHbhjNs56Ju7Qr6HeZcSghf5wwHFXbmXU1A63ho5pmhcpeANskxN5evKPMrMaVkF6uci+zcSPEBhrBhfrbAm9gtXrPNZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752059873; c=relaxed/simple;
	bh=CT/Q1ZmRG43YVxWgoRTcY9BZDq7sUKohDUF+SlPXuWI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GOHBIq+CMxHBQdAon3IhzxXecXERbFOm3Oy82O5EalDHYH5mWRXcJ8P+ydI4OU5X8Q9JGQWMwozA2YoS8NVE5N3gaXxWXNb0BWahdHQ8Ag0dAgyh1mrVNmGNioEGCg8P8V2Gsn/ngD5Mp3cR/LkgQF4WVxAEM9Eud1STWxbbpiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AnLAQMzl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EEomxPtg; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AnLAQMzl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EEomxPtg"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 69BBD1400360
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 07:17:50 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 09 Jul 2025 07:17:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752059870;
	 x=1752146270; bh=OcrxVr09WrwwG9lP5Hf9lqWwjcF+DU+iUIfN2GksSgo=; b=
	AnLAQMzlvFQBEw2uLpVApmDlxXWf7RarsrnHYxsHXeouuRillZaMJyHzjoOp01bT
	H5Qiq1+EiKT9uaMgRvd7YPjozXV7RJ4tPaBvn0FOLLzJe+ArUv17iNycqV0wW1RM
	p69vdOz9YJOcN7expxcvSsGAYncNnLgnWbTDE0kc+rghdpp3JHg/u07WenDwKO4g
	S2laVdVXQkT9S8g4RvVG/Xk5adKXDokV4NxDtOtUcH+hwsfpSExklymfGI77Tc/P
	nqoTRFbIw4n97XjnkL0nay3xKAo8dQkUW9G1ZNOzyO+DJvQZ+4h984+zeQy2ctk4
	1s7/p5h2nYtwMy1SX+Lp3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752059870; x=
	1752146270; bh=OcrxVr09WrwwG9lP5Hf9lqWwjcF+DU+iUIfN2GksSgo=; b=E
	EomxPtgcqwWY7SRrNbdmqpK+9LMDKYQUsUGud6OgKykzv3wrVJOw2UC148R7iFMq
	/VQaI+dXwUJL/+BNilrTjHKdDHm5p/5/YImr7d1/EaJ2Zcpsb5BKYFzQIXgxBBRk
	8Y6uviqJ6gZJw+q2dsQ8mRY564ItzB3LyqgQEeF0JT1T2BDDdDzflE/SjW3X5koh
	wyGqa0+W366hKtMXDPZxJuRNg+KjzVpuZTNhYj45aTC3B0JJHm++Q+g9pJ6KdRLz
	Psgpx6XWNWrHSKdFqxcSefHYubVfZ9pRzTySB3Lxa1qycYsGhBgm+xQ56QaiDH/5
	hOyzpjunyu73pGuAR13YA==
X-ME-Sender: <xms:3k9uaA6xzzZTC-JD5IereHdKNWwLAMsCFqb5H2RE54RG6pqpqTw-OQ>
    <xme:3k9uaD5ii8gtrPbA7ATYec5j2gAgX8HlzI2erz-g0X95IkUxeTPBYaRtAndIYTZ8A
    2fPGEsF6P46MViXfA>
X-ME-Received: <xmr:3k9uaI0JOltaT_jhOy1Ux31yGHa8haA6TVAgaeusSg_klAUtDA6gBLsTWMw0DJBKg_ZQGsm0z0gUByurslSLxi9yRhERFmt-qHO2SMTmiDOXaw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefjeegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:3k9uaHW0a7HBnINHOgkS7YZo8pxjaV8wU30MnQGrIt_utJ-5eqEO6Q>
    <xmx:3k9uaL7gg-JfclDjvPBkrEX7wogadgTD6LhpKTxGcJw0MuPnfcsNUg>
    <xmx:3k9uaGJuOPCvB-IbilNjZYrXaGfCIXZ9AGhU1XZTCIT8DjVXrR84zg>
    <xmx:3k9uaEKrHpLsZtMK8R3KD_IKOmU_fF0AIcEf-qmG4yNHB5dW4GEE8Q>
    <xmx:3k9uaKTg8FpMbjz3ddtAy3s3X3CRkTQLgekFJK9du1vGZ7ojm__U077M>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 9 Jul 2025 07:17:49 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 781d1421 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Wed, 9 Jul 2025 11:17:49 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 09 Jul 2025 13:17:20 +0200
Subject: [PATCH 10/19] object-file: get rid of `the_repository` when
 writing objects
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-pks-object-file-wo-the-repository-v1-10-62627b55707f@pks.im>
References: <20250709-pks-object-file-wo-the-repository-v1-0-62627b55707f@pks.im>
In-Reply-To: <20250709-pks-object-file-wo-the-repository-v1-0-62627b55707f@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

The logic that writes loose objects still relies on `the_repository` to
decide where exactly the object shall be written to. Refactor it so that
the logic instead operates on a `struct odb_source` so that we can get
rid of this global dependency.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/unpack-objects.c |  3 +-
 object-file.c            | 96 +++++++++++++++++++++++++-----------------------
 object-file.h            |  6 ++-
 odb.c                    |  4 +-
 4 files changed, 58 insertions(+), 51 deletions(-)

diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 1a4fbef36f8..1d405d156e4 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -403,7 +403,8 @@ static void stream_blob(unsigned long size, unsigned nr)
 	data.zstream = &zstream;
 	git_inflate_init(&zstream);
 
-	if (stream_loose_object(&in_stream, size, &info->oid))
+	if (stream_loose_object(the_repository->objects->sources,
+				&in_stream, size, &info->oid))
 		die(_("failed to write object in stream"));
 
 	if (data.status != Z_STREAM_END)
diff --git a/object-file.c b/object-file.c
index 84ece01337e..fc061c37bb5 100644
--- a/object-file.c
+++ b/object-file.c
@@ -667,9 +667,10 @@ void hash_object_file(const struct git_hash_algo *algo, const void *buf,
 }
 
 /* Finalize a file on disk, and close it. */
-static void close_loose_object(int fd, const char *filename)
+static void close_loose_object(struct odb_source *source,
+			       int fd, const char *filename)
 {
-	if (the_repository->objects->sources->will_destroy)
+	if (source->will_destroy)
 		goto out;
 
 	if (batch_fsync_enabled(FSYNC_COMPONENT_LOOSE_OBJECT))
@@ -701,7 +702,8 @@ static inline int directory_size(const char *filename)
  * We want to avoid cross-directory filename renames, because those
  * can have problems on various filesystems (FAT, NFS, Coda).
  */
-static int create_tmpfile(struct strbuf *tmp, const char *filename)
+static int create_tmpfile(struct repository *repo,
+			  struct strbuf *tmp, const char *filename)
 {
 	int fd, dirlen = directory_size(filename);
 
@@ -720,7 +722,7 @@ static int create_tmpfile(struct strbuf *tmp, const char *filename)
 		strbuf_add(tmp, filename, dirlen - 1);
 		if (mkdir(tmp->buf, 0777) && errno != EEXIST)
 			return -1;
-		if (adjust_shared_perm(the_repository, tmp->buf))
+		if (adjust_shared_perm(repo, tmp->buf))
 			return -1;
 
 		/* Try again */
@@ -741,26 +743,26 @@ static int create_tmpfile(struct strbuf *tmp, const char *filename)
  * Returns a "fd", which should later be provided to
  * end_loose_object_common().
  */
-static int start_loose_object_common(struct strbuf *tmp_file,
+static int start_loose_object_common(struct odb_source *source,
+				     struct strbuf *tmp_file,
 				     const char *filename, unsigned flags,
 				     git_zstream *stream,
 				     unsigned char *buf, size_t buflen,
 				     struct git_hash_ctx *c, struct git_hash_ctx *compat_c,
 				     char *hdr, int hdrlen)
 {
-	struct repository *repo = the_repository;
-	const struct git_hash_algo *algo = repo->hash_algo;
-	const struct git_hash_algo *compat = repo->compat_hash_algo;
+	const struct git_hash_algo *algo = source->odb->repo->hash_algo;
+	const struct git_hash_algo *compat = source->odb->repo->compat_hash_algo;
 	int fd;
 
-	fd = create_tmpfile(tmp_file, filename);
+	fd = create_tmpfile(source->odb->repo, tmp_file, filename);
 	if (fd < 0) {
 		if (flags & WRITE_OBJECT_SILENT)
 			return -1;
 		else if (errno == EACCES)
 			return error(_("insufficient permission for adding "
 				       "an object to repository database %s"),
-				     repo_get_object_directory(the_repository));
+				     source->path);
 		else
 			return error_errno(
 				_("unable to create temporary file"));
@@ -790,14 +792,14 @@ static int start_loose_object_common(struct strbuf *tmp_file,
  * Common steps for the inner git_deflate() loop for writing loose
  * objects. Returns what git_deflate() returns.
  */
-static int write_loose_object_common(struct git_hash_ctx *c, struct git_hash_ctx *compat_c,
+static int write_loose_object_common(struct odb_source *source,
+				     struct git_hash_ctx *c, struct git_hash_ctx *compat_c,
 				     git_zstream *stream, const int flush,
 				     unsigned char *in0, const int fd,
 				     unsigned char *compressed,
 				     const size_t compressed_len)
 {
-	struct repository *repo = the_repository;
-	const struct git_hash_algo *compat = repo->compat_hash_algo;
+	const struct git_hash_algo *compat = source->odb->repo->compat_hash_algo;
 	int ret;
 
 	ret = git_deflate(stream, flush ? Z_FINISH : 0);
@@ -818,12 +820,12 @@ static int write_loose_object_common(struct git_hash_ctx *c, struct git_hash_ctx
  * - End the compression of zlib stream.
  * - Get the calculated oid to "oid".
  */
-static int end_loose_object_common(struct git_hash_ctx *c, struct git_hash_ctx *compat_c,
+static int end_loose_object_common(struct odb_source *source,
+				   struct git_hash_ctx *c, struct git_hash_ctx *compat_c,
 				   git_zstream *stream, struct object_id *oid,
 				   struct object_id *compat_oid)
 {
-	struct repository *repo = the_repository;
-	const struct git_hash_algo *compat = repo->compat_hash_algo;
+	const struct git_hash_algo *compat = source->odb->repo->compat_hash_algo;
 	int ret;
 
 	ret = git_deflate_end_gently(stream);
@@ -836,7 +838,8 @@ static int end_loose_object_common(struct git_hash_ctx *c, struct git_hash_ctx *
 	return Z_OK;
 }
 
-static int write_loose_object(const struct object_id *oid, char *hdr,
+static int write_loose_object(struct odb_source *source,
+			      const struct object_id *oid, char *hdr,
 			      int hdrlen, const void *buf, unsigned long len,
 			      time_t mtime, unsigned flags)
 {
@@ -851,9 +854,9 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 	if (batch_fsync_enabled(FSYNC_COMPONENT_LOOSE_OBJECT))
 		prepare_loose_object_bulk_checkin();
 
-	odb_loose_path(the_repository->objects->sources, &filename, oid);
+	odb_loose_path(source, &filename, oid);
 
-	fd = start_loose_object_common(&tmp_file, filename.buf, flags,
+	fd = start_loose_object_common(source, &tmp_file, filename.buf, flags,
 				       &stream, compressed, sizeof(compressed),
 				       &c, NULL, hdr, hdrlen);
 	if (fd < 0)
@@ -865,14 +868,14 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 	do {
 		unsigned char *in0 = stream.next_in;
 
-		ret = write_loose_object_common(&c, NULL, &stream, 1, in0, fd,
+		ret = write_loose_object_common(source, &c, NULL, &stream, 1, in0, fd,
 						compressed, sizeof(compressed));
 	} while (ret == Z_OK);
 
 	if (ret != Z_STREAM_END)
 		die(_("unable to deflate new object %s (%d)"), oid_to_hex(oid),
 		    ret);
-	ret = end_loose_object_common(&c, NULL, &stream, &parano_oid, NULL);
+	ret = end_loose_object_common(source, &c, NULL, &stream, &parano_oid, NULL);
 	if (ret != Z_OK)
 		die(_("deflateEnd on object %s failed (%d)"), oid_to_hex(oid),
 		    ret);
@@ -880,7 +883,7 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 		die(_("confused by unstable object source data for %s"),
 		    oid_to_hex(oid));
 
-	close_loose_object(fd, tmp_file.buf);
+	close_loose_object(source, fd, tmp_file.buf);
 
 	if (mtime) {
 		struct utimbuf utb;
@@ -891,7 +894,7 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 			warning_errno(_("failed utime() on %s"), tmp_file.buf);
 	}
 
-	return finalize_object_file_flags(the_repository, tmp_file.buf, filename.buf,
+	return finalize_object_file_flags(source->odb->repo, tmp_file.buf, filename.buf,
 					  FOF_SKIP_COLLISION_CHECK);
 }
 
@@ -921,10 +924,11 @@ static int freshen_packed_object(struct object_database *odb,
 	return 1;
 }
 
-int stream_loose_object(struct input_stream *in_stream, size_t len,
+int stream_loose_object(struct odb_source *source,
+			struct input_stream *in_stream, size_t len,
 			struct object_id *oid)
 {
-	const struct git_hash_algo *compat = the_repository->compat_hash_algo;
+	const struct git_hash_algo *compat = source->odb->repo->compat_hash_algo;
 	struct object_id compat_oid;
 	int fd, ret, err = 0, flush = 0;
 	unsigned char compressed[4096];
@@ -940,7 +944,7 @@ int stream_loose_object(struct input_stream *in_stream, size_t len,
 		prepare_loose_object_bulk_checkin();
 
 	/* Since oid is not determined, save tmp file to odb path. */
-	strbuf_addf(&filename, "%s/", repo_get_object_directory(the_repository));
+	strbuf_addf(&filename, "%s/", source->path);
 	hdrlen = format_object_header(hdr, sizeof(hdr), OBJ_BLOB, len);
 
 	/*
@@ -951,7 +955,7 @@ int stream_loose_object(struct input_stream *in_stream, size_t len,
 	 *  - Setup zlib stream for compression.
 	 *  - Start to feed header to zlib stream.
 	 */
-	fd = start_loose_object_common(&tmp_file, filename.buf, 0,
+	fd = start_loose_object_common(source, &tmp_file, filename.buf, 0,
 				       &stream, compressed, sizeof(compressed),
 				       &c, &compat_c, hdr, hdrlen);
 	if (fd < 0) {
@@ -971,7 +975,7 @@ int stream_loose_object(struct input_stream *in_stream, size_t len,
 			if (in_stream->is_finished)
 				flush = 1;
 		}
-		ret = write_loose_object_common(&c, &compat_c, &stream, flush, in0, fd,
+		ret = write_loose_object_common(source, &c, &compat_c, &stream, flush, in0, fd,
 						compressed, sizeof(compressed));
 		/*
 		 * Unlike write_loose_object(), we do not have the entire
@@ -994,18 +998,18 @@ int stream_loose_object(struct input_stream *in_stream, size_t len,
 	 */
 	if (ret != Z_STREAM_END)
 		die(_("unable to stream deflate new object (%d)"), ret);
-	ret = end_loose_object_common(&c, &compat_c, &stream, oid, &compat_oid);
+	ret = end_loose_object_common(source, &c, &compat_c, &stream, oid, &compat_oid);
 	if (ret != Z_OK)
 		die(_("deflateEnd on stream object failed (%d)"), ret);
-	close_loose_object(fd, tmp_file.buf);
+	close_loose_object(source, fd, tmp_file.buf);
 
-	if (freshen_packed_object(the_repository->objects, oid) ||
-	    freshen_loose_object(the_repository->objects, oid)) {
+	if (freshen_packed_object(source->odb, oid) ||
+	    freshen_loose_object(source->odb, oid)) {
 		unlink_or_warn(tmp_file.buf);
 		goto cleanup;
 	}
 
-	odb_loose_path(the_repository->objects->sources, &filename, oid);
+	odb_loose_path(source, &filename, oid);
 
 	/* We finally know the object path, and create the missing dir. */
 	dirlen = directory_size(filename.buf);
@@ -1013,7 +1017,7 @@ int stream_loose_object(struct input_stream *in_stream, size_t len,
 		struct strbuf dir = STRBUF_INIT;
 		strbuf_add(&dir, filename.buf, dirlen);
 
-		if (safe_create_dir_in_gitdir(the_repository, dir.buf) &&
+		if (safe_create_dir_in_gitdir(source->odb->repo, dir.buf) &&
 		    errno != EEXIST) {
 			err = error_errno(_("unable to create directory %s"), dir.buf);
 			strbuf_release(&dir);
@@ -1022,23 +1026,23 @@ int stream_loose_object(struct input_stream *in_stream, size_t len,
 		strbuf_release(&dir);
 	}
 
-	err = finalize_object_file_flags(the_repository, tmp_file.buf, filename.buf,
+	err = finalize_object_file_flags(source->odb->repo, tmp_file.buf, filename.buf,
 					 FOF_SKIP_COLLISION_CHECK);
 	if (!err && compat)
-		err = repo_add_loose_object_map(the_repository->objects->sources, oid, &compat_oid);
+		err = repo_add_loose_object_map(source, oid, &compat_oid);
 cleanup:
 	strbuf_release(&tmp_file);
 	strbuf_release(&filename);
 	return err;
 }
 
-int write_object_file(const void *buf, unsigned long len,
+int write_object_file(struct odb_source *source,
+		      const void *buf, unsigned long len,
 		      enum object_type type, struct object_id *oid,
 		      struct object_id *compat_oid_in, unsigned flags)
 {
-	struct repository *repo = the_repository;
-	const struct git_hash_algo *algo = repo->hash_algo;
-	const struct git_hash_algo *compat = repo->compat_hash_algo;
+	const struct git_hash_algo *algo = source->odb->repo->hash_algo;
+	const struct git_hash_algo *compat = source->odb->repo->compat_hash_algo;
 	struct object_id compat_oid;
 	char hdr[MAX_HEADER_LEN];
 	int hdrlen = sizeof(hdr);
@@ -1051,7 +1055,7 @@ int write_object_file(const void *buf, unsigned long len,
 			hash_object_file(compat, buf, len, type, &compat_oid);
 		else {
 			struct strbuf converted = STRBUF_INIT;
-			convert_object_file(the_repository, &converted, algo, compat,
+			convert_object_file(source->odb->repo, &converted, algo, compat,
 					    buf, len, type, 0);
 			hash_object_file(compat, converted.buf, converted.len,
 					 type, &compat_oid);
@@ -1063,13 +1067,13 @@ int write_object_file(const void *buf, unsigned long len,
 	 * it out into .git/objects/??/?{38} file.
 	 */
 	write_object_file_prepare(algo, buf, len, type, oid, hdr, &hdrlen);
-	if (freshen_packed_object(repo->objects, oid) ||
-	    freshen_loose_object(repo->objects, oid))
+	if (freshen_packed_object(source->odb, oid) ||
+	    freshen_loose_object(source->odb, oid))
 		return 0;
-	if (write_loose_object(oid, hdr, hdrlen, buf, len, 0, flags))
+	if (write_loose_object(source, oid, hdr, hdrlen, buf, len, 0, flags))
 		return -1;
 	if (compat)
-		return repo_add_loose_object_map(repo->objects->sources, oid, &compat_oid);
+		return repo_add_loose_object_map(source, oid, &compat_oid);
 	return 0;
 }
 
@@ -1101,7 +1105,7 @@ int force_object_loose(const struct object_id *oid, time_t mtime)
 				     oid_to_hex(oid), compat->name);
 	}
 	hdrlen = format_object_header(hdr, sizeof(hdr), type, len);
-	ret = write_loose_object(oid, hdr, hdrlen, buf, len, mtime, 0);
+	ret = write_loose_object(repo->objects->sources, oid, hdr, hdrlen, buf, len, mtime, 0);
 	if (!ret && compat)
 		ret = repo_add_loose_object_map(the_repository->objects->sources, oid, &compat_oid);
 	free(buf);
diff --git a/object-file.h b/object-file.h
index 8ee24b7d8f3..622e2b2bb7d 100644
--- a/object-file.h
+++ b/object-file.h
@@ -157,7 +157,8 @@ enum unpack_loose_header_result unpack_loose_header(git_zstream *stream,
 struct object_info;
 int parse_loose_header(const char *hdr, struct object_info *oi);
 
-int write_object_file(const void *buf, unsigned long len,
+int write_object_file(struct odb_source *source,
+		      const void *buf, unsigned long len,
 		      enum object_type type, struct object_id *oid,
 		      struct object_id *compat_oid_in, unsigned flags);
 
@@ -167,7 +168,8 @@ struct input_stream {
 	int is_finished;
 };
 
-int stream_loose_object(struct input_stream *in_stream, size_t len,
+int stream_loose_object(struct odb_source *source,
+			struct input_stream *in_stream, size_t len,
 			struct object_id *oid);
 
 int force_object_loose(const struct object_id *oid, time_t mtime);
diff --git a/odb.c b/odb.c
index 519df2fa497..2a92a018c42 100644
--- a/odb.c
+++ b/odb.c
@@ -980,14 +980,14 @@ void odb_assert_oid_type(struct object_database *odb,
 		    type_name(expect));
 }
 
-int odb_write_object_ext(struct object_database *odb UNUSED,
+int odb_write_object_ext(struct object_database *odb,
 			 const void *buf, unsigned long len,
 			 enum object_type type,
 			 struct object_id *oid,
 			 struct object_id *compat_oid,
 			 unsigned flags)
 {
-	return write_object_file(buf, len, type, oid, compat_oid, flags);
+	return write_object_file(odb->sources, buf, len, type, oid, compat_oid, flags);
 }
 
 struct object_database *odb_new(struct repository *repo)

-- 
2.50.1.327.g047016eb4a.dirty

