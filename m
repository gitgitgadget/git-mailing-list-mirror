Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B243C37BA
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 09:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784280764; cv=none; b=bZWceFQC8Kul6HuSDibcq8Py55HbPjfaUJq9+3+8h5/rOLfIuLvtov+ZrG8+dqLXxYCQOBTjoUrzx/nBb2VrH/rG7LL7ilKzxr+zIcL5KhOuzwRCkcojQl8rJZ0gUN8XIxLJLUBpAKpd5T49HJ8wFAO+YBviqXZvU15yFCSx7ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784280764; c=relaxed/simple;
	bh=jFFT9icvaj8WOcy7KEQNs07nGi4qVGErMnb0OF12yBw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=koervnFJgOAbjlIqiBbBrnPfpuWC4lUeeuQjAgoS0m0ueVc7QXilT9EGlRkjKqIRr/85TC7r++S8UhcLC7VWQHemSOzcyY0yYBZBEp/0CQhJeQWuGEyaRUIKBlI23EGpPfbYWOCDZWGS7Tf5oIZJ3JWuzRnD2EF3/414zJGq0dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nFmQRdl6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HARowRxi; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nFmQRdl6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HARowRxi"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id BF3BB1D000C5;
	Fri, 17 Jul 2026 05:32:41 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Fri, 17 Jul 2026 05:32:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1784280761;
	 x=1784367161; bh=F7czGiYXNKNeLsbjdIToOGgKnPNL9JI0pbLxWhh5UfM=; b=
	nFmQRdl6gy6enu8piX1cljI4SirfM0I8bSRI9NqUZSTWOd9Eao2DBhfUbiQddKww
	7/QlFo3KXnDcpgvzmu1ikY59ZKHcET4a6Hnz0CDdiSbTgEmVkOjgiBulP2Ldo1NV
	PaSnVm+sRUAqIc9XB+WQBBgOkSNTHE3SMnNwCSuX3zgnqwiXDUb8PSdQ5oktmL0T
	T7kGi51JSzJmBFUX9hPfE40iIaqjB2Q71FLLnOQpK6XLyXOgwgTWmLSq/SIWYukv
	4dn6tS9Ag6bRkBnsk2oW4POPfpiqHzAv2/HjVoTsSmvDQG1T3uVVGhI7/A7cijeL
	52mgRKWXTljYUnWkiuJaYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784280761; x=
	1784367161; bh=F7czGiYXNKNeLsbjdIToOGgKnPNL9JI0pbLxWhh5UfM=; b=H
	ARowRxiL/1GodEj1wipbUzl9/ItBn3jNJwebD4n/OOJH8epLV4XnFCyplKnxwdYS
	irgbfwtdUiN166SDo1xOn/YxeozZRwy+NOhsdBI5HPn+o5JdAvOqSvZ5NB0NJ7gq
	9ImhWvc3PnGF3wio+i/R08h0gFTld1wG8j4AjdV/Pw1F658X4SeiEfewZVTbj0uV
	KEclDEJEPrCUw1HQ4/wgS6eGJs0kcYd3PUSCo8gp5PsGYRqWztqG4Skrd1ceeTDG
	h1XaP1LBfv1I4YcmHQzFBeNjkvpwZA+ckIb06xzCxkbbGzHq/KbNOLay7dmmkDO5
	g1oPZKL5XK8bTpr5reokA==
X-ME-Sender: <xms:ufZZaj8yWWFZy7YFDhTVtOjSSdtI1Yk071BcfYChd1gUiZWPUH1uEQ>
    <xme:ufZZaluexmJ0_RDYOkO0HeVmu3fHGFHzXwXDDXBt6i3c3N-LeVzUyiRHy1vDIunBK
    v_0XY6XcEBqg5vhcHY8XktLDZNnahx58TojnyMeb03rKNo6Vv1_Sw>
X-ME-Received: <xmr:ufZZauokBJsNXrdV2wfy7DsIJxGwOxaak2nrtm8x2jcWG-d3Lg2b0XLny3KFQjvjzLdvDAWol32DpN0J1zKsev48A9nZyTk4HU_5CkLzq_8>
X-ME-Proxy-Cause: dmFkZTEPgWsCPQv+zxSWEft837Na6Ert1SlmN3P5ZmZ6YVgwDD0i8FWTKtTHRWTsiWlqAf
    Ee3/fhnAtu7H1tpfszCQ9TpTtYDRq9/Ej+1toGtU2M4Btlsq1pdMD6WQ1yGfoiLr4szbCI
    waU9J+ehUfgAu5Wanq56c7n6wqTMKgid98yVYjCsZ3lgk6w6eA2/c75Y8tf8tburLwkElo
    WIveSLuviSET+E2Li1iK4PFXEMXOIYmHGdAPQjQZ/ZM4k+MBe94Ic0rS1bAkMoxhgnze0d
    MvjikpHRu8nDYV0sOz9NDUBG04xBQks3AtbvI4iyZ3NLFDV9y0pp6sScxFsmkkVul8Tkey
    jUi4xJMmpU4dr18CAxyDfRAcW/zKnrtjVp0fkrprINXE5ZKuQVal3iy8apG82b9/TaPYHs
    lZrhnoCM5KK8Yz91FfPaQdM3cZ8R72g8SHMRKA62UzXEQuEJmlUJ+w5QJuQeG4cQLUzTI+
    H8/lzFVDa+MiUOzktQFtUBATwFEJ1bIQCEovpvFr7nCHGLY1DHyxnmBckP0avc3JaP1B/e
    vU4HfqQhIaLX70JMpxKJAorPO6B1xJ9HDZoKOsvdhWRf5uEfiHyoaIu/v18Hn9Pz7egulO
    +r35WqhRdU88ee2/FDr59uqhWH1wS0vZNa9urHSO3xQ6LoWq5ESktF0lwQXw
X-ME-Proxy: <xmx:ufZZaqk8gNVEbminy_FPoKneb_aBL5CwHrZoyO8fsaKuEGxKB9gd5g>
    <xmx:ufZZaqwnrIE8EWfCs6hXfju4bLBo-Udb6kOZIuG5fmfdxlkkUreHeQ>
    <xmx:ufZZaqlXGTqFkVPsxswTexPX_iDE4pArFNAiNlI63z6otONNLvB33A>
    <xmx:ufZZarfb7LpXJl1FHI2GbHBFmumIIBvK8c9YJgxaXy64BiOqcVOghg>
    <xmx:ufZZaiv5wBybILONrybHp2scFGO2ciVVGHbp3PoXu9V7qpMOHMSchB4Z>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jul 2026 05:32:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9356c55d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 17 Jul 2026 09:32:39 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 17 Jul 2026 11:32:17 +0200
Subject: [PATCH 9/9] object-file: move logic to write loose objects
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260717-pks-odb-move-loose-object-writing-v1-9-46446a3cb5b7@pks.im>
References: <20260717-pks-odb-move-loose-object-writing-v1-0-46446a3cb5b7@pks.im>
In-Reply-To: <20260717-pks-odb-move-loose-object-writing-v1-0-46446a3cb5b7@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

The logic to write loose objects is split up across "object-file.c" and
"odb/source-loose.c". This split is somewhat weird, but it is the result
of two things:

  - `force_object_loose()` used to reach into internals of how exactly
    we write objects.

  - The logic of writing objects is intertwined with potentially
    starting a transaction.

We have refactored `force_object_loose()` over preceding commits to work
via generic interfaces now, so this reason doesn't exist anymore. But
the second reason still does, as our management of "files" transactions
and their ad-hoc creation is still very messy. This area definitely
requires further work, and that work is indeed ongoing.

That being said, we can already move the writing logic into the "loose"
backend rather easily. All we have to do is to expose two functions that
relate to the transactions.

Expose these two functions and move the writing logic into the "loose"
backend accordingly so that it becomes more self-contained. Note that
this requires us to drop a reference to `the_repository` in favor of
using the source's repository in `start_loose_object_common()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c      | 360 +----------------------------------------------------
 object-file.h      |  22 +---
 odb/source-loose.c | 354 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 357 insertions(+), 379 deletions(-)

diff --git a/object-file.c b/object-file.c
index b867d8d9de..bdc97d7943 100644
--- a/object-file.c
+++ b/object-file.c
@@ -491,7 +491,7 @@ struct odb_transaction_files {
 	const char *prefix;
 };
 
-static int odb_transaction_files_prepare(struct odb_transaction *base)
+int odb_transaction_files_prepare(struct odb_transaction *base)
 {
 	struct odb_transaction_files *transaction =
 		container_of_or_null(base, struct odb_transaction_files, base);
@@ -514,8 +514,8 @@ static int odb_transaction_files_prepare(struct odb_transaction *base)
 	return 0;
 }
 
-static void odb_transaction_files_fsync(struct odb_transaction *base,
-					int fd, const char *filename)
+void odb_transaction_files_fsync(struct odb_transaction *base,
+				 int fd, const char *filename)
 {
 	struct odb_transaction_files *transaction =
 		container_of_or_null(base, struct odb_transaction_files, base);
@@ -539,360 +539,6 @@ static void odb_transaction_files_fsync(struct odb_transaction *base,
 	}
 }
 
-/* Finalize a file on disk, and close it. */
-static void close_loose_object(struct odb_source_loose *loose,
-			       int fd, const char *filename)
-{
-	if (loose->base.will_destroy)
-		goto out;
-
-	if (batch_fsync_enabled(FSYNC_COMPONENT_LOOSE_OBJECT))
-		odb_transaction_files_fsync(loose->base.odb->transaction, fd, filename);
-	else if (fsync_object_files > 0)
-		fsync_or_die(fd, filename);
-	else
-		fsync_component_or_die(FSYNC_COMPONENT_LOOSE_OBJECT, fd,
-				       filename);
-
-out:
-	if (close(fd) != 0)
-		die_errno(_("error when closing loose object file"));
-}
-
-/* Size of directory component, including the ending '/' */
-static inline int directory_size(const char *filename)
-{
-	const char *s = strrchr(filename, '/');
-	if (!s)
-		return 0;
-	return s - filename + 1;
-}
-
-/*
- * This creates a temporary file in the same directory as the final
- * 'filename'
- *
- * We want to avoid cross-directory filename renames, because those
- * can have problems on various filesystems (FAT, NFS, Coda).
- */
-static int create_tmpfile(struct repository *repo,
-			  struct strbuf *tmp, const char *filename)
-{
-	int fd, dirlen = directory_size(filename);
-
-	strbuf_reset(tmp);
-	strbuf_add(tmp, filename, dirlen);
-	strbuf_addstr(tmp, "tmp_obj_XXXXXX");
-	fd = git_mkstemp_mode(tmp->buf, 0444);
-	if (fd < 0 && dirlen && errno == ENOENT) {
-		/*
-		 * Make sure the directory exists; note that the contents
-		 * of the buffer are undefined after mkstemp returns an
-		 * error, so we have to rewrite the whole buffer from
-		 * scratch.
-		 */
-		strbuf_reset(tmp);
-		strbuf_add(tmp, filename, dirlen - 1);
-		if (mkdir(tmp->buf, 0777) && errno != EEXIST)
-			return -1;
-		if (adjust_shared_perm(repo, tmp->buf))
-			return -1;
-
-		/* Try again */
-		strbuf_addstr(tmp, "/tmp_obj_XXXXXX");
-		fd = git_mkstemp_mode(tmp->buf, 0444);
-	}
-	return fd;
-}
-
-/**
- * Common steps for loose object writers to start writing loose
- * objects:
- *
- * - Create tmpfile for the loose object.
- * - Setup zlib stream for compression.
- * - Start to feed header to zlib stream.
- *
- * Returns a "fd", which should later be provided to
- * end_loose_object_common().
- */
-static int start_loose_object_common(struct odb_source_loose *loose,
-				     struct strbuf *tmp_file,
-				     const char *filename, unsigned flags,
-				     git_zstream *stream,
-				     unsigned char *buf, size_t buflen,
-				     struct git_hash_ctx *c, struct git_hash_ctx *compat_c,
-				     char *hdr, int hdrlen)
-{
-	const struct git_hash_algo *algo = loose->base.odb->repo->hash_algo;
-	const struct git_hash_algo *compat = loose->base.odb->repo->compat_hash_algo;
-	int fd;
-	struct repo_config_values *cfg = repo_config_values(the_repository);
-
-	fd = create_tmpfile(loose->base.odb->repo, tmp_file, filename);
-	if (fd < 0) {
-		if (flags & ODB_WRITE_OBJECT_SILENT)
-			return -1;
-		else if (errno == EACCES)
-			return error(_("insufficient permission for adding "
-				       "an object to repository database %s"),
-				     loose->base.path);
-		else
-			return error_errno(
-				_("unable to create temporary file"));
-	}
-
-	/*  Setup zlib stream for compression */
-	git_deflate_init(stream, cfg->zlib_compression_level);
-	stream->next_out = buf;
-	stream->avail_out = buflen;
-	git_hash_init(c, algo);
-	if (compat && compat_c)
-		git_hash_init(compat_c, compat);
-
-	/*  Start to feed header to zlib stream */
-	stream->next_in = (unsigned char *)hdr;
-	stream->avail_in = hdrlen;
-	while (git_deflate(stream, 0) == Z_OK)
-		; /* nothing */
-	git_hash_update(c, hdr, hdrlen);
-	if (compat && compat_c)
-		git_hash_update(compat_c, hdr, hdrlen);
-
-	return fd;
-}
-
-/**
- * Common steps for the inner git_deflate() loop for writing loose
- * objects. Returns what git_deflate() returns.
- */
-static int write_loose_object_common(struct odb_source_loose *loose,
-				     struct git_hash_ctx *c, struct git_hash_ctx *compat_c,
-				     git_zstream *stream, const int flush,
-				     unsigned char *in0, const int fd,
-				     unsigned char *compressed,
-				     const size_t compressed_len)
-{
-	const struct git_hash_algo *compat = loose->base.odb->repo->compat_hash_algo;
-	int ret;
-
-	ret = git_deflate(stream, flush ? Z_FINISH : 0);
-	git_hash_update(c, in0, stream->next_in - in0);
-	if (compat && compat_c)
-		git_hash_update(compat_c, in0, stream->next_in - in0);
-	if (write_in_full(fd, compressed, stream->next_out - compressed) < 0)
-		die_errno(_("unable to write loose object file"));
-	stream->next_out = compressed;
-	stream->avail_out = compressed_len;
-
-	return ret;
-}
-
-/**
- * Common steps for loose object writers to end writing loose objects:
- *
- * - End the compression of zlib stream.
- * - Get the calculated oid to "oid".
- */
-static int end_loose_object_common(struct odb_source_loose *loose,
-				   struct git_hash_ctx *c, struct git_hash_ctx *compat_c,
-				   git_zstream *stream, struct object_id *oid,
-				   struct object_id *compat_oid)
-{
-	const struct git_hash_algo *compat = loose->base.odb->repo->compat_hash_algo;
-	int ret;
-
-	ret = git_deflate_end_gently(stream);
-	if (ret != Z_OK)
-		return ret;
-	git_hash_final_oid(oid, c);
-	if (compat && compat_c)
-		git_hash_final_oid(compat_oid, compat_c);
-
-	return Z_OK;
-}
-
-int write_loose_object(struct odb_source_loose *loose,
-		       const struct object_id *oid, char *hdr,
-		       int hdrlen, const void *buf, unsigned long len,
-		       const time_t *mtime, unsigned flags)
-{
-	int fd, ret;
-	unsigned char compressed[4096];
-	git_zstream stream;
-	struct git_hash_ctx c;
-	struct object_id parano_oid;
-	static struct strbuf tmp_file = STRBUF_INIT;
-	static struct strbuf filename = STRBUF_INIT;
-
-	if (batch_fsync_enabled(FSYNC_COMPONENT_LOOSE_OBJECT))
-		odb_transaction_files_prepare(loose->base.odb->transaction);
-
-	odb_loose_path(loose, &filename, oid);
-
-	fd = start_loose_object_common(loose, &tmp_file, filename.buf, flags,
-				       &stream, compressed, sizeof(compressed),
-				       &c, NULL, hdr, hdrlen);
-	if (fd < 0)
-		return -1;
-
-	/* Then the data itself.. */
-	stream.next_in = (void *)buf;
-	stream.avail_in = len;
-	do {
-		unsigned char *in0 = stream.next_in;
-
-		ret = write_loose_object_common(loose, &c, NULL, &stream, 1, in0, fd,
-						compressed, sizeof(compressed));
-	} while (ret == Z_OK);
-
-	if (ret != Z_STREAM_END)
-		die(_("unable to deflate new object %s (%d)"), oid_to_hex(oid),
-		    ret);
-	ret = end_loose_object_common(loose, &c, NULL, &stream, &parano_oid, NULL);
-	if (ret != Z_OK)
-		die(_("deflateEnd on object %s failed (%d)"), oid_to_hex(oid),
-		    ret);
-	if (!oideq(oid, &parano_oid))
-		die(_("confused by unstable object source data for %s"),
-		    oid_to_hex(oid));
-
-	close_loose_object(loose, fd, tmp_file.buf);
-
-	if (mtime) {
-		struct utimbuf utb = {
-			.actime = *mtime,
-			.modtime = *mtime,
-		};
-
-		if (utime(tmp_file.buf, &utb) < 0 &&
-		    !(flags & ODB_WRITE_OBJECT_SILENT))
-			warning_errno(_("failed utime() on %s"), tmp_file.buf);
-	}
-
-	return finalize_object_file_flags(loose->base.odb->repo, tmp_file.buf, filename.buf,
-					  FOF_SKIP_COLLISION_CHECK);
-}
-
-int odb_source_loose_write_stream(struct odb_source_loose *loose,
-				  struct odb_write_stream *in_stream, size_t len,
-				  struct object_id *oid)
-{
-	const struct git_hash_algo *compat = loose->base.odb->repo->compat_hash_algo;
-	struct object_id compat_oid;
-	int fd, ret, err = 0, flush = 0;
-	unsigned char compressed[4096];
-	git_zstream stream;
-	struct git_hash_ctx c, compat_c;
-	struct strbuf tmp_file = STRBUF_INIT;
-	struct strbuf filename = STRBUF_INIT;
-	unsigned char buf[8192];
-	int dirlen;
-	char hdr[MAX_HEADER_LEN];
-	int hdrlen;
-
-	if (batch_fsync_enabled(FSYNC_COMPONENT_LOOSE_OBJECT))
-		odb_transaction_files_prepare(loose->base.odb->transaction);
-
-	/* Since oid is not determined, save tmp file to odb path. */
-	strbuf_addf(&filename, "%s/", loose->base.path);
-	hdrlen = format_object_header(hdr, sizeof(hdr), OBJ_BLOB, len);
-
-	/*
-	 * Common steps for write_loose_object and stream_loose_object to
-	 * start writing loose objects:
-	 *
-	 *  - Create tmpfile for the loose object.
-	 *  - Setup zlib stream for compression.
-	 *  - Start to feed header to zlib stream.
-	 */
-	fd = start_loose_object_common(loose, &tmp_file, filename.buf, 0,
-				       &stream, compressed, sizeof(compressed),
-				       &c, &compat_c, hdr, hdrlen);
-	if (fd < 0) {
-		err = -1;
-		goto cleanup;
-	}
-
-	/* Then the data itself.. */
-	do {
-		unsigned char *in0 = stream.next_in;
-
-		if (!stream.avail_in && !in_stream->is_finished) {
-			ssize_t read_len = odb_write_stream_read(in_stream, buf,
-								 sizeof(buf));
-			if (read_len < 0) {
-				close(fd);
-				err = -1;
-				goto cleanup;
-			}
-
-			stream.avail_in = read_len;
-			stream.next_in = buf;
-			in0 = buf;
-			/* All data has been read. */
-			if (in_stream->is_finished)
-				flush = 1;
-		}
-		ret = write_loose_object_common(loose, &c, &compat_c, &stream, flush, in0, fd,
-						compressed, sizeof(compressed));
-		/*
-		 * Unlike write_loose_object(), we do not have the entire
-		 * buffer. If we get Z_BUF_ERROR due to too few input bytes,
-		 * then we'll replenish them in the next input_stream->read()
-		 * call when we loop.
-		 */
-	} while (ret == Z_OK || ret == Z_BUF_ERROR);
-
-	if (stream.total_in != len + hdrlen)
-		die(_("write stream object %"PRIuMAX" != %"PRIuMAX), (uintmax_t)stream.total_in,
-		    (uintmax_t)len + hdrlen);
-
-	/*
-	 * Common steps for write_loose_object and stream_loose_object to
-	 * end writing loose object:
-	 *
-	 *  - End the compression of zlib stream.
-	 *  - Get the calculated oid.
-	 */
-	if (ret != Z_STREAM_END)
-		die(_("unable to stream deflate new object (%d)"), ret);
-	ret = end_loose_object_common(loose, &c, &compat_c, &stream, oid, &compat_oid);
-	if (ret != Z_OK)
-		die(_("deflateEnd on stream object failed (%d)"), ret);
-	close_loose_object(loose, fd, tmp_file.buf);
-
-	if (odb_freshen_object(loose->base.odb, oid)) {
-		unlink_or_warn(tmp_file.buf);
-		goto cleanup;
-	}
-	odb_loose_path(loose, &filename, oid);
-
-	/* We finally know the object path, and create the missing dir. */
-	dirlen = directory_size(filename.buf);
-	if (dirlen) {
-		struct strbuf dir = STRBUF_INIT;
-		strbuf_add(&dir, filename.buf, dirlen);
-
-		if (safe_create_dir_in_gitdir(loose->base.odb->repo, dir.buf) &&
-		    errno != EEXIST) {
-			err = error_errno(_("unable to create directory %s"), dir.buf);
-			strbuf_release(&dir);
-			goto cleanup;
-		}
-		strbuf_release(&dir);
-	}
-
-	err = finalize_object_file_flags(loose->base.odb->repo, tmp_file.buf, filename.buf,
-					 FOF_SKIP_COLLISION_CHECK);
-	if (!err && compat)
-		err = repo_add_loose_object_map(loose, oid, &compat_oid);
-cleanup:
-	strbuf_release(&tmp_file);
-	strbuf_release(&filename);
-	return err;
-}
-
 /*
  * We can't use the normal fsck_error_function() for index_mem(),
  * because we don't yet have a valid oid for it to report. Instead,
diff --git a/object-file.h b/object-file.h
index 31781a9c53..805f2cfa28 100644
--- a/object-file.h
+++ b/object-file.h
@@ -24,20 +24,6 @@ int index_path(struct index_state *istate, struct object_id *oid, const char *pa
 struct object_info;
 struct odb_source;
 
-/*
- * Write the given stream into the loose object source. The only difference
- * from the generic implementation of this function is that we don't perform an
- * object existence check here.
- *
- * TODO: We should stop exposing this function altogether and move it into
- * "odb/source-loose.c". This requires a couple of refactorings though to make
- * `force_object_loose()` generic and is thus postponed to a later point in
- * time.
- */
-int odb_source_loose_write_stream(struct odb_source_loose *source,
-				  struct odb_write_stream *stream, size_t len,
-				  struct object_id *oid);
-
 /*
  * Put in `buf` the name of the file in the local object database that
  * would be used to store a loose object with the specified oid.
@@ -131,10 +117,6 @@ int finalize_object_file_flags(struct repository *repo,
 void hash_object_file(const struct git_hash_algo *algo, const void *buf,
 		      size_t len, enum object_type type,
 		      struct object_id *oid);
-int write_loose_object(struct odb_source_loose *loose,
-		       const struct object_id *oid, char *hdr,
-		       int hdrlen, const void *buf, unsigned long len,
-		       const time_t *mtime, unsigned flags);
 
 /* Helper to check and "touch" a file */
 int check_and_freshen_file(const char *fn, int freshen,
@@ -195,4 +177,8 @@ int odb_transaction_files_begin(struct odb_source *source,
 				struct odb_transaction **out,
 				enum odb_transaction_flags flags);
 
+int odb_transaction_files_prepare(struct odb_transaction *base);
+void odb_transaction_files_fsync(struct odb_transaction *base,
+				 int fd, const char *filename);
+
 #endif /* OBJECT_FILE_H */
diff --git a/odb/source-loose.c b/odb/source-loose.c
index 520a30157c..ef0e919277 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -11,8 +11,11 @@
 #include "odb/source-loose.h"
 #include "odb/streaming.h"
 #include "oidtree.h"
+#include "path.h"
 #include "repository.h"
 #include "strbuf.h"
+#include "tempfile.h"
+#include "write-or-die.h"
 
 static int append_loose_object(const struct object_id *oid,
 			       const char *path UNUSED,
@@ -583,6 +586,241 @@ static int odb_source_loose_freshen_object(struct odb_source *source,
 	return !!check_and_freshen_file(path.buf, 1, mtime);
 }
 
+/* Finalize a file on disk, and close it. */
+static void close_loose_object(struct odb_source_loose *loose,
+			       int fd, const char *filename)
+{
+	if (loose->base.will_destroy)
+		goto out;
+
+	if (batch_fsync_enabled(FSYNC_COMPONENT_LOOSE_OBJECT))
+		odb_transaction_files_fsync(loose->base.odb->transaction, fd, filename);
+	else if (fsync_object_files > 0)
+		fsync_or_die(fd, filename);
+	else
+		fsync_component_or_die(FSYNC_COMPONENT_LOOSE_OBJECT, fd,
+				       filename);
+
+out:
+	if (close(fd) != 0)
+		die_errno(_("error when closing loose object file"));
+}
+
+/* Size of directory component, including the ending '/' */
+static inline int directory_size(const char *filename)
+{
+	const char *s = strrchr(filename, '/');
+	if (!s)
+		return 0;
+	return s - filename + 1;
+}
+
+/*
+ * This creates a temporary file in the same directory as the final
+ * 'filename'
+ *
+ * We want to avoid cross-directory filename renames, because those
+ * can have problems on various filesystems (FAT, NFS, Coda).
+ */
+static int create_tmpfile(struct repository *repo,
+			  struct strbuf *tmp, const char *filename)
+{
+	int fd, dirlen = directory_size(filename);
+
+	strbuf_reset(tmp);
+	strbuf_add(tmp, filename, dirlen);
+	strbuf_addstr(tmp, "tmp_obj_XXXXXX");
+	fd = git_mkstemp_mode(tmp->buf, 0444);
+	if (fd < 0 && dirlen && errno == ENOENT) {
+		/*
+		 * Make sure the directory exists; note that the contents
+		 * of the buffer are undefined after mkstemp returns an
+		 * error, so we have to rewrite the whole buffer from
+		 * scratch.
+		 */
+		strbuf_reset(tmp);
+		strbuf_add(tmp, filename, dirlen - 1);
+		if (mkdir(tmp->buf, 0777) && errno != EEXIST)
+			return -1;
+		if (adjust_shared_perm(repo, tmp->buf))
+			return -1;
+
+		/* Try again */
+		strbuf_addstr(tmp, "/tmp_obj_XXXXXX");
+		fd = git_mkstemp_mode(tmp->buf, 0444);
+	}
+	return fd;
+}
+
+/**
+ * Common steps for loose object writers to start writing loose
+ * objects:
+ *
+ * - Create tmpfile for the loose object.
+ * - Setup zlib stream for compression.
+ * - Start to feed header to zlib stream.
+ *
+ * Returns a "fd", which should later be provided to
+ * end_loose_object_common().
+ */
+static int start_loose_object_common(struct odb_source_loose *loose,
+				     struct strbuf *tmp_file,
+				     const char *filename, unsigned flags,
+				     git_zstream *stream,
+				     unsigned char *buf, size_t buflen,
+				     struct git_hash_ctx *c, struct git_hash_ctx *compat_c,
+				     char *hdr, int hdrlen)
+{
+	const struct git_hash_algo *algo = loose->base.odb->repo->hash_algo;
+	const struct git_hash_algo *compat = loose->base.odb->repo->compat_hash_algo;
+	int fd;
+	struct repo_config_values *cfg = repo_config_values(loose->base.odb->repo);
+
+	fd = create_tmpfile(loose->base.odb->repo, tmp_file, filename);
+	if (fd < 0) {
+		if (flags & ODB_WRITE_OBJECT_SILENT)
+			return -1;
+		else if (errno == EACCES)
+			return error(_("insufficient permission for adding "
+				       "an object to repository database %s"),
+				     loose->base.path);
+		else
+			return error_errno(
+				_("unable to create temporary file"));
+	}
+
+	/*  Setup zlib stream for compression */
+	git_deflate_init(stream, cfg->zlib_compression_level);
+	stream->next_out = buf;
+	stream->avail_out = buflen;
+	git_hash_init(c, algo);
+	if (compat && compat_c)
+		git_hash_init(compat_c, compat);
+
+	/*  Start to feed header to zlib stream */
+	stream->next_in = (unsigned char *)hdr;
+	stream->avail_in = hdrlen;
+	while (git_deflate(stream, 0) == Z_OK)
+		; /* nothing */
+	git_hash_update(c, hdr, hdrlen);
+	if (compat && compat_c)
+		git_hash_update(compat_c, hdr, hdrlen);
+
+	return fd;
+}
+
+/**
+ * Common steps for the inner git_deflate() loop for writing loose
+ * objects. Returns what git_deflate() returns.
+ */
+static int write_loose_object_common(struct odb_source_loose *loose,
+				     struct git_hash_ctx *c, struct git_hash_ctx *compat_c,
+				     git_zstream *stream, const int flush,
+				     unsigned char *in0, const int fd,
+				     unsigned char *compressed,
+				     const size_t compressed_len)
+{
+	const struct git_hash_algo *compat = loose->base.odb->repo->compat_hash_algo;
+	int ret;
+
+	ret = git_deflate(stream, flush ? Z_FINISH : 0);
+	git_hash_update(c, in0, stream->next_in - in0);
+	if (compat && compat_c)
+		git_hash_update(compat_c, in0, stream->next_in - in0);
+	if (write_in_full(fd, compressed, stream->next_out - compressed) < 0)
+		die_errno(_("unable to write loose object file"));
+	stream->next_out = compressed;
+	stream->avail_out = compressed_len;
+
+	return ret;
+}
+
+/**
+ * Common steps for loose object writers to end writing loose objects:
+ *
+ * - End the compression of zlib stream.
+ * - Get the calculated oid to "oid".
+ */
+static int end_loose_object_common(struct odb_source_loose *loose,
+				   struct git_hash_ctx *c, struct git_hash_ctx *compat_c,
+				   git_zstream *stream, struct object_id *oid,
+				   struct object_id *compat_oid)
+{
+	const struct git_hash_algo *compat = loose->base.odb->repo->compat_hash_algo;
+	int ret;
+
+	ret = git_deflate_end_gently(stream);
+	if (ret != Z_OK)
+		return ret;
+	git_hash_final_oid(oid, c);
+	if (compat && compat_c)
+		git_hash_final_oid(compat_oid, compat_c);
+
+	return Z_OK;
+}
+
+static int write_loose_object(struct odb_source_loose *loose,
+			      const struct object_id *oid, char *hdr,
+			      int hdrlen, const void *buf, unsigned long len,
+			      const time_t *mtime, unsigned flags)
+{
+	int fd, ret;
+	unsigned char compressed[4096];
+	git_zstream stream;
+	struct git_hash_ctx c;
+	struct object_id parano_oid;
+	static struct strbuf tmp_file = STRBUF_INIT;
+	static struct strbuf filename = STRBUF_INIT;
+
+	if (batch_fsync_enabled(FSYNC_COMPONENT_LOOSE_OBJECT))
+		odb_transaction_files_prepare(loose->base.odb->transaction);
+
+	odb_loose_path(loose, &filename, oid);
+
+	fd = start_loose_object_common(loose, &tmp_file, filename.buf, flags,
+				       &stream, compressed, sizeof(compressed),
+				       &c, NULL, hdr, hdrlen);
+	if (fd < 0)
+		return -1;
+
+	/* Then the data itself.. */
+	stream.next_in = (void *)buf;
+	stream.avail_in = len;
+	do {
+		unsigned char *in0 = stream.next_in;
+
+		ret = write_loose_object_common(loose, &c, NULL, &stream, 1, in0, fd,
+						compressed, sizeof(compressed));
+	} while (ret == Z_OK);
+
+	if (ret != Z_STREAM_END)
+		die(_("unable to deflate new object %s (%d)"), oid_to_hex(oid),
+		    ret);
+	ret = end_loose_object_common(loose, &c, NULL, &stream, &parano_oid, NULL);
+	if (ret != Z_OK)
+		die(_("deflateEnd on object %s failed (%d)"), oid_to_hex(oid),
+		    ret);
+	if (!oideq(oid, &parano_oid))
+		die(_("confused by unstable object source data for %s"),
+		    oid_to_hex(oid));
+
+	close_loose_object(loose, fd, tmp_file.buf);
+
+	if (mtime) {
+		struct utimbuf utb = {
+			.actime = *mtime,
+			.modtime = *mtime,
+		};
+
+		if (utime(tmp_file.buf, &utb) < 0 &&
+		    !(flags & ODB_WRITE_OBJECT_SILENT))
+			warning_errno(_("failed utime() on %s"), tmp_file.buf);
+	}
+
+	return finalize_object_file_flags(loose->base.odb->repo, tmp_file.buf, filename.buf,
+					  FOF_SKIP_COLLISION_CHECK);
+}
+
 static int odb_source_loose_write_object(struct odb_source *source,
 					 const void *buf, size_t len,
 					 enum object_type type,
@@ -611,12 +849,120 @@ static int odb_source_loose_write_object_stream(struct odb_source *source,
 						size_t len,
 						struct object_id *oid)
 {
+	struct odb_source_loose *loose = odb_source_loose_downcast(source);
+	const struct git_hash_algo *compat = loose->base.odb->repo->compat_hash_algo;
+	struct object_id compat_oid;
+	int fd, ret, err = 0, flush = 0;
+	unsigned char compressed[4096];
+	git_zstream stream;
+	struct git_hash_ctx c, compat_c;
+	struct strbuf tmp_file = STRBUF_INIT;
+	struct strbuf filename = STRBUF_INIT;
+	unsigned char buf[8192];
+	int dirlen;
+	char hdr[MAX_HEADER_LEN];
+	int hdrlen;
+
+	if (batch_fsync_enabled(FSYNC_COMPONENT_LOOSE_OBJECT))
+		odb_transaction_files_prepare(loose->base.odb->transaction);
+
+	/* Since oid is not determined, save tmp file to odb path. */
+	strbuf_addf(&filename, "%s/", loose->base.path);
+	hdrlen = format_object_header(hdr, sizeof(hdr), OBJ_BLOB, len);
+
 	/*
-	 * TODO: the implementation should be moved here, see the comment on
-	 * the called function in "object-file.h".
+	 * Common steps for write_loose_object and stream_loose_object to
+	 * start writing loose objects:
+	 *
+	 *  - Create tmpfile for the loose object.
+	 *  - Setup zlib stream for compression.
+	 *  - Start to feed header to zlib stream.
 	 */
-	struct odb_source_loose *loose = odb_source_loose_downcast(source);
-	return odb_source_loose_write_stream(loose, in_stream, len, oid);
+	fd = start_loose_object_common(loose, &tmp_file, filename.buf, 0,
+				       &stream, compressed, sizeof(compressed),
+				       &c, &compat_c, hdr, hdrlen);
+	if (fd < 0) {
+		err = -1;
+		goto cleanup;
+	}
+
+	/* Then the data itself.. */
+	do {
+		unsigned char *in0 = stream.next_in;
+
+		if (!stream.avail_in && !in_stream->is_finished) {
+			ssize_t read_len = odb_write_stream_read(in_stream, buf,
+								 sizeof(buf));
+			if (read_len < 0) {
+				close(fd);
+				err = -1;
+				goto cleanup;
+			}
+
+			stream.avail_in = read_len;
+			stream.next_in = buf;
+			in0 = buf;
+			/* All data has been read. */
+			if (in_stream->is_finished)
+				flush = 1;
+		}
+		ret = write_loose_object_common(loose, &c, &compat_c, &stream, flush, in0, fd,
+						compressed, sizeof(compressed));
+		/*
+		 * Unlike write_loose_object(), we do not have the entire
+		 * buffer. If we get Z_BUF_ERROR due to too few input bytes,
+		 * then we'll replenish them in the next input_stream->read()
+		 * call when we loop.
+		 */
+	} while (ret == Z_OK || ret == Z_BUF_ERROR);
+
+	if (stream.total_in != len + hdrlen)
+		die(_("write stream object %"PRIuMAX" != %"PRIuMAX), (uintmax_t)stream.total_in,
+		    (uintmax_t)len + hdrlen);
+
+	/*
+	 * Common steps for write_loose_object and stream_loose_object to
+	 * end writing loose object:
+	 *
+	 *  - End the compression of zlib stream.
+	 *  - Get the calculated oid.
+	 */
+	if (ret != Z_STREAM_END)
+		die(_("unable to stream deflate new object (%d)"), ret);
+	ret = end_loose_object_common(loose, &c, &compat_c, &stream, oid, &compat_oid);
+	if (ret != Z_OK)
+		die(_("deflateEnd on stream object failed (%d)"), ret);
+	close_loose_object(loose, fd, tmp_file.buf);
+
+	if (odb_freshen_object(loose->base.odb, oid)) {
+		unlink_or_warn(tmp_file.buf);
+		goto cleanup;
+	}
+	odb_loose_path(loose, &filename, oid);
+
+	/* We finally know the object path, and create the missing dir. */
+	dirlen = directory_size(filename.buf);
+	if (dirlen) {
+		struct strbuf dir = STRBUF_INIT;
+		strbuf_add(&dir, filename.buf, dirlen);
+
+		if (safe_create_dir_in_gitdir(loose->base.odb->repo, dir.buf) &&
+		    errno != EEXIST) {
+			err = error_errno(_("unable to create directory %s"), dir.buf);
+			strbuf_release(&dir);
+			goto cleanup;
+		}
+		strbuf_release(&dir);
+	}
+
+	err = finalize_object_file_flags(loose->base.odb->repo, tmp_file.buf, filename.buf,
+					 FOF_SKIP_COLLISION_CHECK);
+	if (!err && compat)
+		err = repo_add_loose_object_map(loose, oid, &compat_oid);
+cleanup:
+	strbuf_release(&tmp_file);
+	strbuf_release(&filename);
+	return err;
 }
 
 static int odb_source_loose_begin_transaction(struct odb_source *source UNUSED,

-- 
2.55.0.407.g700c83d4f3.dirty

