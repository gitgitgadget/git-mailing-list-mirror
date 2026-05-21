Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59543A545C
	for <git@vger.kernel.org>; Thu, 21 May 2026 08:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779351792; cv=none; b=UIfIKZtOsOmOhoYHToNIHHb0Y3AT7d+ARxZWDEBQbXTpNaIuATjgHlnJYO1F/IGEd1Dx/RTKtYScZKJhL0HSSBiS42sUrbd0QHq2/yb2UiHpwefR1hBLI4gL0tB/4QgLjqbdLcJ/leDdHRbtk7xz8NjjzBj309fvwX9tY1GbacM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779351792; c=relaxed/simple;
	bh=00jzoebX4s5vu6j9tFtBuHxrIIqaBcYsETw2Sp30L7c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M1TzRFluw0rpL0vk87jzxxZ8THmlImduNdvvM+LVGVWeaJK2XyfNyf5V+wVY5m6zDgkUgCYvU8zud8YbB/f8D/AfSNVnbyAh9FKaMcJWfj+M1AUkJTq2g/SriFDOCHkpyDzkoh8hFuy1h13My4/zsPBJP798cODgQyiYZdPHrg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oVst3BVX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lPgiGh5o; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oVst3BVX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lPgiGh5o"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 352BA140007D
	for <git@vger.kernel.org>; Thu, 21 May 2026 04:23:10 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 21 May 2026 04:23:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779351790;
	 x=1779438190; bh=qjQJFSU6o90HyazZb+8JEqXzZVWKeMeKQ8KfBl1Ay6Y=; b=
	oVst3BVXX4ClDUq8DDR5h2vK1XIqMMQeIiiWbimpv0pziZhXH9MdHvEKdYW4A9z+
	OvpvyEEjXVkXSByMWIm8w2t+l1RLAPzYCwW2ZoBCzzUnmxBXiO2OB81meVLbjLY3
	JswsIy8lbgVlXkZYSv19jg8jqu94xVP4Sn4rThuNNJi2yst6T/VSOI4OOMKKgdTd
	Qa2yyDgQjkUCd8n8VCm34pIkiHYg2ea7JQn+/r4ffDjwB3RhlYIcsvAEfK5bTHPY
	X3GqIPrqAEMq4uEj14A15FbawKwnH4erQhQL2hsrFED/T1YbTpfYT1LWInInxXxi
	aqhhk4Bje4EzY9rOJcGcaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779351790; x=
	1779438190; bh=qjQJFSU6o90HyazZb+8JEqXzZVWKeMeKQ8KfBl1Ay6Y=; b=l
	PgiGh5onGbcprpZ3v0G5yC59X/glavZ/8p7m8mZKlpKq2v7mqmrgQmsm0o6Yp0sI
	rVc98MKmQnOKOrqojpajqUJvvi1kMFQc+JtEd13WXrHCAIOwZ82z1QeORGXae3m2
	OswLgNooEd+05jhniLf1XwLQvtxqZkEm98OTqQ0ez8ZhbbaW3NMRmwodnvPLxUsX
	qJvHVfvwA80Lc8tN9x/RrWyXAHgs7Xb53RNHHnuC38lymvuddyAmAH2XPEqH41rd
	iIeT2XhSO7NSA4kxQz3eeZHYqx1kOWc6Pxly7tJqCIdB7EP9UDx8+CBWFlm5+GvC
	MjuKNA0SOyqWNXziubmKA==
X-ME-Sender: <xms:7sAOapg2g33xQ8VR33r4ut0xGlZ0wueb922BummYCDjU34W8wyognQ>
    <xme:7sAOak_jqh5RK9E6YHLyYsGOJzTkjuLollICVI6gjs73kMzmaom-UrT2Mj1kklJfp
    f4TVjl17qT52iTzphVU1i5mdsI4T2ew5nx2siYL5du-kDQRswOK5A>
X-ME-Received: <xmr:7sAOaust8iGzM2XH-MdTBwLHhTfYQEMR22omcWY1ZoOEVrixlUaV3q3LGvyXp46rZtnAB5IwGfo7Y__ftzcp5JGTQNaSmxaP5KsNlGyiKqM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeejtddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:7sAOajYweJAiX6YGWNKHA331UnjVZhTzjFbAEAUY1FcvWNJ-ONfW_Q>
    <xmx:7sAOamoAamVwEwqs5YbzPDQw2uTEdr7eOr7EwM6HbLBm66CPzrnN0w>
    <xmx:7sAOag9W5HlP4dWp4Z8ZOhSwEhIycx7z9R9NXbKNel9QAyHqzBcltg>
    <xmx:7sAOat8nXXLeQ2ucj2Ri_WX73k2CtZDUMD-Zen7SeQF3MEdvK2bXDQ>
    <xmx:7sAOaij5UBlNUpGawe57US7tc7LepZ78kpVu9y3e_TgiEUj9K8sR0x_H>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 21 May 2026 04:23:09 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9fc0d561 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 21 May 2026 08:23:09 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 21 May 2026 10:22:35 +0200
Subject: [PATCH 15/18] object-file: refactor writing objects to use loose
 source
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-b4-pks-odb-source-loose-v1-15-6553b399be2d@pks.im>
References: <20260521-b4-pks-odb-source-loose-v1-0-6553b399be2d@pks.im>
In-Reply-To: <20260521-b4-pks-odb-source-loose-v1-0-6553b399be2d@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

The "object-file" subsystem still hosts the majority of logic used to
write loose objects. Eventually, we'll want to move this logic into
"odb/source-loose.c", but this isn't yet easily possible because a lot
of the writing logic is still being shared with `force_object_loose()`.

We will eventually detangle this logic so that we can indeed move all of
it into the "loose" source. Meanwhile though, refactor the code so that
it operates on a `struct odb_source_loose` directly to already make the
dependency explicit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 http-walker.c      |  3 ++-
 http.c             |  6 +++--
 object-file.c      | 75 +++++++++++++++++++++++++++---------------------------
 object-file.h      |  6 ++---
 odb/source-files.c |  3 ++-
 odb/source-loose.c |  9 ++++---
 6 files changed, 53 insertions(+), 49 deletions(-)

diff --git a/http-walker.c b/http-walker.c
index 1b6d496548..435a726540 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -539,8 +539,9 @@ static int fetch_object(struct walker *walker, const struct object_id *oid)
 	} else if (!oideq(&obj_req->oid, &req->real_oid)) {
 		ret = error("File %s has bad hash", hex);
 	} else if (req->rename < 0) {
+		struct odb_source_files *files = odb_source_files_downcast(the_repository->objects->sources);
 		struct strbuf buf = STRBUF_INIT;
-		odb_loose_path(the_repository->objects->sources, &buf, &req->oid);
+		odb_loose_path(files->loose, &buf, &req->oid);
 		ret = error("unable to write sha1 filename %s", buf.buf);
 		strbuf_release(&buf);
 	}
diff --git a/http.c b/http.c
index ea9b16861b..3fcc012233 100644
--- a/http.c
+++ b/http.c
@@ -2826,6 +2826,7 @@ static size_t fwrite_sha1_file(char *ptr, size_t eltsize, size_t nmemb,
 struct http_object_request *new_http_object_request(const char *base_url,
 						    const struct object_id *oid)
 {
+	struct odb_source_files *files = odb_source_files_downcast(the_repository->objects->sources);
 	char *hex = oid_to_hex(oid);
 	struct strbuf filename = STRBUF_INIT;
 	struct strbuf prevfile = STRBUF_INIT;
@@ -2840,7 +2841,7 @@ struct http_object_request *new_http_object_request(const char *base_url,
 	oidcpy(&freq->oid, oid);
 	freq->localfile = -1;
 
-	odb_loose_path(the_repository->objects->sources, &filename, oid);
+	odb_loose_path(files->loose, &filename, oid);
 	strbuf_addf(&freq->tmpfile, "%s.temp", filename.buf);
 
 	strbuf_addf(&prevfile, "%s.prev", filename.buf);
@@ -2966,6 +2967,7 @@ void process_http_object_request(struct http_object_request *freq)
 
 int finish_http_object_request(struct http_object_request *freq)
 {
+	struct odb_source_files *files = odb_source_files_downcast(the_repository->objects->sources);
 	struct stat st;
 	struct strbuf filename = STRBUF_INIT;
 
@@ -2992,7 +2994,7 @@ int finish_http_object_request(struct http_object_request *freq)
 		unlink_or_warn(freq->tmpfile.buf);
 		return -1;
 	}
-	odb_loose_path(the_repository->objects->sources, &filename, &freq->oid);
+	odb_loose_path(files->loose, &filename, &freq->oid);
 	freq->rename = finalize_object_file(the_repository, freq->tmpfile.buf, filename.buf);
 	strbuf_release(&filename);
 
diff --git a/object-file.c b/object-file.c
index 7bb5b31bca..bce941874e 100644
--- a/object-file.c
+++ b/object-file.c
@@ -54,14 +54,14 @@ static void fill_loose_path(struct strbuf *buf,
 	}
 }
 
-const char *odb_loose_path(struct odb_source *source,
+const char *odb_loose_path(struct odb_source_loose *loose,
 			   struct strbuf *buf,
 			   const struct object_id *oid)
 {
 	strbuf_reset(buf);
-	strbuf_addstr(buf, source->path);
+	strbuf_addstr(buf, loose->base.path);
 	strbuf_addch(buf, '/');
-	fill_loose_path(buf, oid, source->odb->repo->hash_algo);
+	fill_loose_path(buf, oid, loose->base.odb->repo->hash_algo);
 	return buf->buf;
 }
 
@@ -575,14 +575,14 @@ static void flush_loose_object_transaction(struct odb_transaction_files *transac
 }
 
 /* Finalize a file on disk, and close it. */
-static void close_loose_object(struct odb_source *source,
+static void close_loose_object(struct odb_source_loose *loose,
 			       int fd, const char *filename)
 {
-	if (source->will_destroy)
+	if (loose->base.will_destroy)
 		goto out;
 
 	if (batch_fsync_enabled(FSYNC_COMPONENT_LOOSE_OBJECT))
-		fsync_loose_object_transaction(source->odb->transaction, fd, filename);
+		fsync_loose_object_transaction(loose->base.odb->transaction, fd, filename);
 	else if (fsync_object_files > 0)
 		fsync_or_die(fd, filename);
 	else
@@ -651,7 +651,7 @@ static int create_tmpfile(struct repository *repo,
  * Returns a "fd", which should later be provided to
  * end_loose_object_common().
  */
-static int start_loose_object_common(struct odb_source *source,
+static int start_loose_object_common(struct odb_source_loose *loose,
 				     struct strbuf *tmp_file,
 				     const char *filename, unsigned flags,
 				     git_zstream *stream,
@@ -659,18 +659,18 @@ static int start_loose_object_common(struct odb_source *source,
 				     struct git_hash_ctx *c, struct git_hash_ctx *compat_c,
 				     char *hdr, int hdrlen)
 {
-	const struct git_hash_algo *algo = source->odb->repo->hash_algo;
-	const struct git_hash_algo *compat = source->odb->repo->compat_hash_algo;
+	const struct git_hash_algo *algo = loose->base.odb->repo->hash_algo;
+	const struct git_hash_algo *compat = loose->base.odb->repo->compat_hash_algo;
 	int fd;
 
-	fd = create_tmpfile(source->odb->repo, tmp_file, filename);
+	fd = create_tmpfile(loose->base.odb->repo, tmp_file, filename);
 	if (fd < 0) {
 		if (flags & ODB_WRITE_OBJECT_SILENT)
 			return -1;
 		else if (errno == EACCES)
 			return error(_("insufficient permission for adding "
 				       "an object to repository database %s"),
-				     source->path);
+				     loose->base.path);
 		else
 			return error_errno(
 				_("unable to create temporary file"));
@@ -700,14 +700,14 @@ static int start_loose_object_common(struct odb_source *source,
  * Common steps for the inner git_deflate() loop for writing loose
  * objects. Returns what git_deflate() returns.
  */
-static int write_loose_object_common(struct odb_source *source,
+static int write_loose_object_common(struct odb_source_loose *loose,
 				     struct git_hash_ctx *c, struct git_hash_ctx *compat_c,
 				     git_zstream *stream, const int flush,
 				     unsigned char *in0, const int fd,
 				     unsigned char *compressed,
 				     const size_t compressed_len)
 {
-	const struct git_hash_algo *compat = source->odb->repo->compat_hash_algo;
+	const struct git_hash_algo *compat = loose->base.odb->repo->compat_hash_algo;
 	int ret;
 
 	ret = git_deflate(stream, flush ? Z_FINISH : 0);
@@ -728,12 +728,12 @@ static int write_loose_object_common(struct odb_source *source,
  * - End the compression of zlib stream.
  * - Get the calculated oid to "oid".
  */
-static int end_loose_object_common(struct odb_source *source,
+static int end_loose_object_common(struct odb_source_loose *loose,
 				   struct git_hash_ctx *c, struct git_hash_ctx *compat_c,
 				   git_zstream *stream, struct object_id *oid,
 				   struct object_id *compat_oid)
 {
-	const struct git_hash_algo *compat = source->odb->repo->compat_hash_algo;
+	const struct git_hash_algo *compat = loose->base.odb->repo->compat_hash_algo;
 	int ret;
 
 	ret = git_deflate_end_gently(stream);
@@ -746,7 +746,7 @@ static int end_loose_object_common(struct odb_source *source,
 	return Z_OK;
 }
 
-int write_loose_object(struct odb_source *source,
+int write_loose_object(struct odb_source_loose *loose,
 		       const struct object_id *oid, char *hdr,
 		       int hdrlen, const void *buf, unsigned long len,
 		       time_t mtime, unsigned flags)
@@ -760,11 +760,11 @@ int write_loose_object(struct odb_source *source,
 	static struct strbuf filename = STRBUF_INIT;
 
 	if (batch_fsync_enabled(FSYNC_COMPONENT_LOOSE_OBJECT))
-		prepare_loose_object_transaction(source->odb->transaction);
+		prepare_loose_object_transaction(loose->base.odb->transaction);
 
-	odb_loose_path(source, &filename, oid);
+	odb_loose_path(loose, &filename, oid);
 
-	fd = start_loose_object_common(source, &tmp_file, filename.buf, flags,
+	fd = start_loose_object_common(loose, &tmp_file, filename.buf, flags,
 				       &stream, compressed, sizeof(compressed),
 				       &c, NULL, hdr, hdrlen);
 	if (fd < 0)
@@ -776,14 +776,14 @@ int write_loose_object(struct odb_source *source,
 	do {
 		unsigned char *in0 = stream.next_in;
 
-		ret = write_loose_object_common(source, &c, NULL, &stream, 1, in0, fd,
+		ret = write_loose_object_common(loose, &c, NULL, &stream, 1, in0, fd,
 						compressed, sizeof(compressed));
 	} while (ret == Z_OK);
 
 	if (ret != Z_STREAM_END)
 		die(_("unable to deflate new object %s (%d)"), oid_to_hex(oid),
 		    ret);
-	ret = end_loose_object_common(source, &c, NULL, &stream, &parano_oid, NULL);
+	ret = end_loose_object_common(loose, &c, NULL, &stream, &parano_oid, NULL);
 	if (ret != Z_OK)
 		die(_("deflateEnd on object %s failed (%d)"), oid_to_hex(oid),
 		    ret);
@@ -791,7 +791,7 @@ int write_loose_object(struct odb_source *source,
 		die(_("confused by unstable object source data for %s"),
 		    oid_to_hex(oid));
 
-	close_loose_object(source, fd, tmp_file.buf);
+	close_loose_object(loose, fd, tmp_file.buf);
 
 	if (mtime) {
 		struct utimbuf utb;
@@ -802,16 +802,15 @@ int write_loose_object(struct odb_source *source,
 			warning_errno(_("failed utime() on %s"), tmp_file.buf);
 	}
 
-	return finalize_object_file_flags(source->odb->repo, tmp_file.buf, filename.buf,
+	return finalize_object_file_flags(loose->base.odb->repo, tmp_file.buf, filename.buf,
 					  FOF_SKIP_COLLISION_CHECK);
 }
 
-int odb_source_loose_write_stream(struct odb_source *source,
+int odb_source_loose_write_stream(struct odb_source_loose *loose,
 				  struct odb_write_stream *in_stream, size_t len,
 				  struct object_id *oid)
 {
-	struct odb_source_files *files = odb_source_files_downcast(source);
-	const struct git_hash_algo *compat = source->odb->repo->compat_hash_algo;
+	const struct git_hash_algo *compat = loose->base.odb->repo->compat_hash_algo;
 	struct object_id compat_oid;
 	int fd, ret, err = 0, flush = 0;
 	unsigned char compressed[4096];
@@ -825,10 +824,10 @@ int odb_source_loose_write_stream(struct odb_source *source,
 	int hdrlen;
 
 	if (batch_fsync_enabled(FSYNC_COMPONENT_LOOSE_OBJECT))
-		prepare_loose_object_transaction(source->odb->transaction);
+		prepare_loose_object_transaction(loose->base.odb->transaction);
 
 	/* Since oid is not determined, save tmp file to odb path. */
-	strbuf_addf(&filename, "%s/", source->path);
+	strbuf_addf(&filename, "%s/", loose->base.path);
 	hdrlen = format_object_header(hdr, sizeof(hdr), OBJ_BLOB, len);
 
 	/*
@@ -839,7 +838,7 @@ int odb_source_loose_write_stream(struct odb_source *source,
 	 *  - Setup zlib stream for compression.
 	 *  - Start to feed header to zlib stream.
 	 */
-	fd = start_loose_object_common(source, &tmp_file, filename.buf, 0,
+	fd = start_loose_object_common(loose, &tmp_file, filename.buf, 0,
 				       &stream, compressed, sizeof(compressed),
 				       &c, &compat_c, hdr, hdrlen);
 	if (fd < 0) {
@@ -867,7 +866,7 @@ int odb_source_loose_write_stream(struct odb_source *source,
 			if (in_stream->is_finished)
 				flush = 1;
 		}
-		ret = write_loose_object_common(source, &c, &compat_c, &stream, flush, in0, fd,
+		ret = write_loose_object_common(loose, &c, &compat_c, &stream, flush, in0, fd,
 						compressed, sizeof(compressed));
 		/*
 		 * Unlike write_loose_object(), we do not have the entire
@@ -890,16 +889,16 @@ int odb_source_loose_write_stream(struct odb_source *source,
 	 */
 	if (ret != Z_STREAM_END)
 		die(_("unable to stream deflate new object (%d)"), ret);
-	ret = end_loose_object_common(source, &c, &compat_c, &stream, oid, &compat_oid);
+	ret = end_loose_object_common(loose, &c, &compat_c, &stream, oid, &compat_oid);
 	if (ret != Z_OK)
 		die(_("deflateEnd on stream object failed (%d)"), ret);
-	close_loose_object(source, fd, tmp_file.buf);
+	close_loose_object(loose, fd, tmp_file.buf);
 
-	if (odb_freshen_object(source->odb, oid)) {
+	if (odb_freshen_object(loose->base.odb, oid)) {
 		unlink_or_warn(tmp_file.buf);
 		goto cleanup;
 	}
-	odb_loose_path(source, &filename, oid);
+	odb_loose_path(loose, &filename, oid);
 
 	/* We finally know the object path, and create the missing dir. */
 	dirlen = directory_size(filename.buf);
@@ -907,7 +906,7 @@ int odb_source_loose_write_stream(struct odb_source *source,
 		struct strbuf dir = STRBUF_INIT;
 		strbuf_add(&dir, filename.buf, dirlen);
 
-		if (safe_create_dir_in_gitdir(source->odb->repo, dir.buf) &&
+		if (safe_create_dir_in_gitdir(loose->base.odb->repo, dir.buf) &&
 		    errno != EEXIST) {
 			err = error_errno(_("unable to create directory %s"), dir.buf);
 			strbuf_release(&dir);
@@ -916,10 +915,10 @@ int odb_source_loose_write_stream(struct odb_source *source,
 		strbuf_release(&dir);
 	}
 
-	err = finalize_object_file_flags(source->odb->repo, tmp_file.buf, filename.buf,
+	err = finalize_object_file_flags(loose->base.odb->repo, tmp_file.buf, filename.buf,
 					 FOF_SKIP_COLLISION_CHECK);
 	if (!err && compat)
-		err = repo_add_loose_object_map(files->loose, oid, &compat_oid);
+		err = repo_add_loose_object_map(loose, oid, &compat_oid);
 cleanup:
 	strbuf_release(&tmp_file);
 	strbuf_release(&filename);
@@ -957,7 +956,7 @@ int force_object_loose(struct odb_source *source,
 				     oid_to_hex(oid), compat->name);
 	}
 	hdrlen = format_object_header(hdr, sizeof(hdr), type, len);
-	ret = write_loose_object(source, oid, hdr, hdrlen, buf, len, mtime, 0);
+	ret = write_loose_object(files->loose, oid, hdr, hdrlen, buf, len, mtime, 0);
 	if (!ret && compat)
 		ret = repo_add_loose_object_map(files->loose, oid, &compat_oid);
 	free(buf);
diff --git a/object-file.h b/object-file.h
index 2b32592de1..d30f1b10b2 100644
--- a/object-file.h
+++ b/object-file.h
@@ -23,7 +23,7 @@ int index_path(struct index_state *istate, struct object_id *oid, const char *pa
 struct object_info;
 struct odb_source;
 
-int odb_source_loose_write_stream(struct odb_source *source,
+int odb_source_loose_write_stream(struct odb_source_loose *loose,
 				  struct odb_write_stream *stream, size_t len,
 				  struct object_id *oid);
 
@@ -31,7 +31,7 @@ int odb_source_loose_write_stream(struct odb_source *source,
  * Put in `buf` the name of the file in the local object database that
  * would be used to store a loose object with the specified oid.
  */
-const char *odb_loose_path(struct odb_source *source,
+const char *odb_loose_path(struct odb_source_loose *source,
 			   struct strbuf *buf,
 			   const struct object_id *oid);
 
@@ -127,7 +127,7 @@ void write_object_file_prepare(const struct git_hash_algo *algo,
 			       const void *buf, unsigned long len,
 			       enum object_type type, struct object_id *oid,
 			       char *hdr, int *hdrlen);
-int write_loose_object(struct odb_source *source,
+int write_loose_object(struct odb_source_loose *loose,
 		       const struct object_id *oid, char *hdr,
 		       int hdrlen, const void *buf, unsigned long len,
 		       time_t mtime, unsigned flags);
diff --git a/odb/source-files.c b/odb/source-files.c
index 52ba04237a..2ba1def776 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -174,7 +174,8 @@ static int odb_source_files_write_object_stream(struct odb_source *source,
 						size_t len,
 						struct object_id *oid)
 {
-	return odb_source_loose_write_stream(source, stream, len, oid);
+	struct odb_source_files *files = odb_source_files_downcast(source);
+	return odb_source_loose_write_stream(files->loose, stream, len, oid);
 }
 
 static int odb_source_files_begin_transaction(struct odb_source *source,
diff --git a/odb/source-loose.c b/odb/source-loose.c
index c91018109e..da8a60dba1 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -220,7 +220,7 @@ static int odb_source_loose_read_object_info(struct odb_source *source,
 	if (flags & OBJECT_INFO_SECOND_READ)
 		return -1;
 
-	odb_loose_path(source, &buf, oid);
+	odb_loose_path(loose, &buf, oid);
 	return read_object_info_from_path(loose, buf.buf, oid, oi, flags);
 }
 
@@ -238,7 +238,7 @@ static int open_loose_object(struct odb_source_loose *loose,
 	static struct strbuf buf = STRBUF_INIT;
 	int fd;
 
-	*path = odb_loose_path(&loose->base, &buf, oid);
+	*path = odb_loose_path(loose, &buf, oid);
 	fd = git_open(*path);
 	if (fd >= 0)
 		return fd;
@@ -584,8 +584,9 @@ static int odb_source_loose_count_objects(struct odb_source *source,
 static int odb_source_loose_freshen_object(struct odb_source *source,
 					   const struct object_id *oid)
 {
+	struct odb_source_loose *loose = odb_source_loose_downcast(source);
 	static struct strbuf path = STRBUF_INIT;
-	odb_loose_path(source, &path, oid);
+	odb_loose_path(loose, &path, oid);
 	return !!check_and_freshen_file(path.buf, 1);
 }
 
@@ -624,7 +625,7 @@ static int odb_source_loose_write_object(struct odb_source *source,
 	write_object_file_prepare(algo, buf, len, type, oid, hdr, &hdrlen);
 	if (odb_freshen_object(source->odb, oid))
 		return 0;
-	if (write_loose_object(source, oid, hdr, hdrlen, buf, len, 0, flags))
+	if (write_loose_object(loose, oid, hdr, hdrlen, buf, len, 0, flags))
 		return -1;
 	if (compat)
 		return repo_add_loose_object_map(loose, oid, &compat_oid);

-- 
2.54.0.926.g75ba10bac6.dirty

