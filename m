Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFA0389E05
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 08:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780302069; cv=none; b=YRG0331PiUySyXjaLE5khnWFThUz18UBK3zbjyw3vkoT2N49eIMvYxEDy0FjX4Y5e6OZumMQRYvFHCdW+EpIYSFWBHYK+mN8heWvMvwow11PR8WkO7lC2AbCRtrYEq447XmAU875383tdn/Z0ITZ0Nks+YPXDVJgmXpMxpnuiZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780302069; c=relaxed/simple;
	bh=00jzoebX4s5vu6j9tFtBuHxrIIqaBcYsETw2Sp30L7c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hH2WqIudq0w/QeGcF05AlrY0G0IAFrXVchPesilUF1RPVO1KM6BxgYRf21l3IYcCXHo/QChoC1gcfkv5DDGDvBlTiPH9ToLi34Ol2uE7nMbg7MbIhE3VZGhhDwFVxeRdSVmTAQme4nfzZPwj3Lv4klikKxFJssOVLKA1jpO/s9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Anay+jUN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fb+5nQQa; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Anay+jUN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fb+5nQQa"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 631601400040;
	Mon,  1 Jun 2026 04:21:07 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 01 Jun 2026 04:21:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780302067;
	 x=1780388467; bh=qjQJFSU6o90HyazZb+8JEqXzZVWKeMeKQ8KfBl1Ay6Y=; b=
	Anay+jUN1LiGrWnKgmp7+lbtTZ6lb+Hplo2VMiE1GPiodqYsenNyPvuZGb2U58jl
	69EWjDBngQNhtuAHpzqjP9maW3d27vmyF+uQD+M4KUcSC1iVc40mfa0sZWhFI220
	UwN3ag1f8v01l6FAP/9OeOSYRuNWvQ/v5oQmBhONZKyhxiSAaCs9PrZzXFE6fqBp
	wlNR3QB0u6ma8VfiykA54rijj5EOudQZQiWQDgI5DYMIh9dLrh2JcpcbzWGjRD5H
	Deu/ZAUm/wswHkoofx51Lc28y9kUHq7R21aT/39ujb+9OMX+esMrB9XOuZ9iwWcp
	rSDTlgvkL8Pr9gEgASiLGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780302067; x=
	1780388467; bh=qjQJFSU6o90HyazZb+8JEqXzZVWKeMeKQ8KfBl1Ay6Y=; b=f
	b+5nQQaPuudxxR77bm8PBD0YtVJFylUV44mAEP+ENj+5c2/cJ9kPlZkUakBK1x43
	W2A/fKJbqcdLpBL7neAi9nFVTZJeQEhJr45WlyEes6jpbXXfngIeURy+RPLoXhlS
	hcufIqD2XGNZZV1mCA1uwbmXP8ighKGmTiSlnIZrmYIXyak+KBAXr48xH3SxkG9n
	xigfQcHUf6LbisdfotAKh46Ffbg2Ql5qQzCaPwSiqUBUzdLY7IjjCRnWHMV7dAjm
	ytJRWj/bBEPFX3QzJxpY7JU3ZK/vaq34quQoYH7WjKrJ/GdBNqoYJ8cNsSk/9eI+
	tneXIg6plLA/WgtnWzwdA==
X-ME-Sender: <xms:80AdaqR119UrMjiSBPO5lyvRSgJAbt7rK5HI2tyB1uE1_RekYkLIGQ>
    <xme:80AdalwOMiRbFZlUh7EmQIjO2bLTwv4ZTEhAG92u-ji9bNAFNa5CuTkGFHxnPAPQv
    _8UQBSjKO0C3t_Vv9FQx0bL2NbT4E2IBch4yy9yW_Fv4b0G5VzNwQ>
X-ME-Received: <xmr:80Adale7T5t9NwGNq1Oy2AnwLpjzY-5FQX1dch7LNKv7jn92O70QBmoN9gwf1gofihDn1ouf4Xp83fcNOVQEH59zSX21JizySrURZpxyJula>
X-ME-Proxy-Cause: dmFkZTF/3lZmQQwRdo6r+/fq8Smu+TwPVjvusxOBlavDLDIKjOJTF0mhx0PG3iRklQkuoR
    KybjvCZPyO5SLx+jbyhiK1BxFKgNdbR2k8ZGSaFuyqUYHwVzjbLxF0siLqxUSPxUbv4eNJ
    fV/lE4dC1z3Tys8YDo8tTlPo9a+DjaLVlDKReCXCDnes3wavR6RxAtxK9bLYxNNBcfChN0
    cv/ue+bQVlwkgxRxjHtpGk+YIdLNR9QVvw+cXDwukaHE/D4I3Jh3nQWCnkzs/U/zZw2aq1
    zOcyNk7IpwfHg3hcwEvbyg47DbUpdh0sWb1JmQTGPiTRGnO0qJer5wnPycvCGDmaBWnDk+
    /DZOo6MMX5+gRPmLWR46gOUoGw06ZPKo86j+zWTfzUMV9CL1rhb23bBGEl3zBMUvZCf583
    knheWX9iS+dsKAVrh+eUE7QVuJGqH/t4JQlBlV5BVSxGZRDat0h7VsUpUiW2VIX9rUjDai
    cqiZHhIXN/Lg37EthaZBRPE/UoJelZLeHhcKhPdkNzjCLQvS6MejMHBUCkBe+HREHw1U5E
    p+Lr4oC64CfXewCqQRJcHxRxeP52dxPOjjPwZ7EEiqqikZlF8VDzslHtgKPLshFmoVGUKm
    IqUqcJ46UV3nLzhm4cppn5VjLW5u0/lw9ChO5W9ITy2ks1rLicAQid9I4bhA
X-ME-Proxy: <xmx:80AdahI3URGmqBPsY1_KQMT9WtHjbGzski4aX5NF_Nk6UWrEWieiUQ>
    <xmx:80AdamEcbaFZzan7vw9iiwl5XOC4NLyJsE8IKmffKNVjztdy4NkLrw>
    <xmx:80Adarom-KdeSHkAqX05D2g2I3vYHLw0uLNiSJs89W9NvHj61PlDvQ>
    <xmx:80AdavRLgFKFesK6VAXDQakpWZBWKlWJPg-CBlrwp3ndvhxDmrlxFg>
    <xmx:80Adatol7I2RguwwvA1bOpLtIxSCTKdi7EcBajmwkqq_tSNsB7FawRkN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 04:21:06 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fcfb4525 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 1 Jun 2026 08:21:06 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 01 Jun 2026 10:20:38 +0200
Subject: [PATCH v2 15/18] object-file: refactor writing objects to use
 loose source
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-b4-pks-odb-source-loose-v2-15-90ff159430af@pks.im>
References: <20260601-b4-pks-odb-source-loose-v2-0-90ff159430af@pks.im>
In-Reply-To: <20260601-b4-pks-odb-source-loose-v2-0-90ff159430af@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
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

