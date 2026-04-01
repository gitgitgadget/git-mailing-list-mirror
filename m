Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739B435C1B7
	for <git@vger.kernel.org>; Wed,  1 Apr 2026 03:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775012610; cv=none; b=sQRX6BgpK+YJPz5EAXOo3dppJau/Kfay1hglm7dMbVs0H3GdozcwDhGykGSXbW4ycn2yDhIAz2oZut+BYGb+F/Lvb/yHRc6Js1rN277WTHrvPNULmrcV0kgNFJNE/rrek9UoGUBd+o5OqKnEXNm2auLS3V7o/S8wrm9xQ/l+kTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775012610; c=relaxed/simple;
	bh=Djo9qPbvpHZkAAJ1lXjNtAtU6GcvPUQCz2kgfqe9/lY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K4tiEtNKJZvT0RmmBT9TdK3YN0g+y3jF5Z5PU0RSprBJhKYvAbJb/PENK8LaBptrD3y+ugkFUPHZ+qMP3GE8rKrZVSeaODCbMFEIZRIO+GSzTOyQS4e5+DmM6KEscyA3+jJfTi4PZlbCnvywVScoD5kBL0yF50cztg3t/QwYl3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mCQmb8n8; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCQmb8n8"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7d7e5e8c907so4099128a34.0
        for <git@vger.kernel.org>; Tue, 31 Mar 2026 20:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775012605; x=1775617405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3KmcBrbFrXeuUs63xUKHk005lcrjpjlVauqkLVTIqQc=;
        b=mCQmb8n80lPeLN0cvJtVf8923njoVjZCCb4EJnTiiuSkTBMjBwQCgL44fW7cYx8LVF
         JFrdXnnQITJXCTWnsluumL+brBwtNFClt4BuKVJomrttRIStJwjnO3zgGJxfQvK2ESyj
         PURt7Au2ufEc8jevCizsUNYnzBJ+5P/+piBbiTK/QF6agKfqPlWTkGlQ8sVsukbAeI1I
         Jt0oApGupQGxrxBKtvFeriAPdLGg9KvqPsZRfMKse/eNx1W6QZylnAIGZeqtbrf2khmO
         lNpi11knqz8Tyfc7NI4sFERCUdvuL5BPR6zaX8admwEpi28mQ0/j/Ny23a9LKog2TltA
         Euzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775012605; x=1775617405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3KmcBrbFrXeuUs63xUKHk005lcrjpjlVauqkLVTIqQc=;
        b=YtOE2tdnUl8npeGnGZj3tgOyli3troJiQT7LjH7KoBsB2evQRttqThKgagKbbdROMC
         MHp02fQbF39wTJ0/Ga20Ssbgd9gMCSOvMuHftPU/zjqgaSqs9SPZ4yb0Cr4gM4l2Gt4s
         Jepxvmrvyiwnu/JD8HHehd8SpO3uE3nqEJKem91C3FbDqjHdpz3N+7dpFDA4air/QjjM
         XVVIVT0XDP3COXuzPSik+W2q8Bz3re2TrFIXEvM2Tp7Su0Na1ojvVy2DP2av4Pomuyvm
         KQVord4HucRTLa0WaXcuKHcwzuPZUM9x48p/57TzSNWBv1zaAcvE83cS1eqpj7p1GfUc
         ra5Q==
X-Gm-Message-State: AOJu0Yzf2tFFtnF9Tm4zIOi5uI6x8q6IPviUJAIgboi5BirnEzAJ14F0
	xnFMOWYtMlwX3NuKhytdFLR1V4JVUwawvZLl5ukbA4tJf+9enXW/rERpY9NzAQ==
X-Gm-Gg: ATEYQzy6PSOMpdkssUpgF3DpGNGEjjkoZmsQQd2Drd4Hjik+t+l+yI4W+c8sEBsvkhA
	C1jHCiSROt1++ud3lPAjWZMksahvR7NNu50TmFcN2sP/n+b/S5E1FjqJZCuPqGRPRuyuZCdxS/o
	m/oTsMz7uhHZfhhjvwx52FLyjfoHgrc/EYbx3q/2wH2QwQqWQesLoaPPG0EuFzUh6jZKEwDBUW4
	pvKKfHVpgHWBqu4xqLgJUbwCApOR0k40Pdrvcq9Di3nYnB4EghB3pqGZ2YKDQNz5RpAo0H/wCCn
	rh3ZLY6HdFIZHociSjzOwX49g772OJJAOJGZxFNJ31OxFfFO1OgqxmXoDsORaXVTJrHnrN7K7Mu
	lZGyJdxxpeMmvkaU6GYjOvyV4HufDP7f3qUIc529NHspSwsDaSBx7HID/et7TTyP99ou1zCPhGo
	tj1cKsEb+oXL2Kx5+ijTChS9IKex6oxKw=
X-Received: by 2002:a05:6830:6d4b:b0:7d7:419a:7ac8 with SMTP id 46e09a7af769-7db993550d1mr1178257a34.15.1775012605606;
        Tue, 31 Mar 2026 20:03:25 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7da0a821746sm10266001a34.24.2026.03.31.20.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 20:03:25 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 6/7] object-file: generalize packfile writes to use odb_write_stream
Date: Tue, 31 Mar 2026 22:03:14 -0500
Message-ID: <20260401030316.1847362-7-jltobler@gmail.com>
X-Mailer: git-send-email 2.53.0.381.g628a66ccf6
In-Reply-To: <20260401030316.1847362-1-jltobler@gmail.com>
References: <20260331033835.2863514-1-jltobler@gmail.com>
 <20260401030316.1847362-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `index_blob_packfile_transaction()` function streams blob data
directly from an fd. This makes it difficult to reuse as part of a
generic transactional object writing interface.

Refactor the packfile write path to operate on a `struct
odb_write_stream`, allowing callers to supply data from arbitrary
sources.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 object-file.c | 55 +++++++++++++++++++++++++++------------------------
 1 file changed, 29 insertions(+), 26 deletions(-)

diff --git a/object-file.c b/object-file.c
index 23229fbd95..f7e830c4ec 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1444,18 +1444,19 @@ static int hash_blob_stream(struct odb_write_stream *stream,
 }
 
 /*
- * Read the contents from fd for size bytes, streaming it to the
+ * Read the contents from the stream provided, streaming it to the
  * packfile in state while updating the hash in ctx.
  */
 static void stream_blob_to_pack(struct transaction_packfile *state,
-				struct git_hash_ctx *ctx, int fd, size_t size,
-				const char *path)
+				struct git_hash_ctx *ctx, size_t size,
+				struct odb_write_stream *stream)
 {
 	git_zstream s;
 	unsigned char ibuf[16384];
 	unsigned char obuf[16384];
 	unsigned hdrlen;
 	int status = Z_OK;
+	size_t total = 0;
 
 	git_deflate_init(&s, pack_compression_level);
 
@@ -1464,23 +1465,20 @@ static void stream_blob_to_pack(struct transaction_packfile *state,
 	s.avail_out = sizeof(obuf) - hdrlen;
 
 	while (status != Z_STREAM_END) {
-		if (size && !s.avail_in) {
-			size_t rsize = size < sizeof(ibuf) ? size : sizeof(ibuf);
-			ssize_t read_result = read_in_full(fd, ibuf, rsize);
-			if (read_result < 0)
-				die_errno("failed to read from '%s'", path);
-			if ((size_t)read_result != rsize)
-				die("failed to read %u bytes from '%s'",
-				    (unsigned)rsize, path);
+		if (!stream->is_finished && !s.avail_in) {
+			ssize_t rsize = stream->read(stream, ibuf, sizeof(ibuf));
+
+			if (rsize < 0)
+				die("failed to read blob data");
 
 			git_hash_update(ctx, ibuf, rsize);
 
 			s.next_in = ibuf;
 			s.avail_in = rsize;
-			size -= rsize;
+			total += rsize;
 		}
 
-		status = git_deflate(&s, size ? 0 : Z_FINISH);
+		status = git_deflate(&s, stream->is_finished ? Z_FINISH : 0);
 
 		if (!s.avail_out || status == Z_STREAM_END) {
 			size_t written = s.next_out - obuf;
@@ -1500,6 +1498,11 @@ static void stream_blob_to_pack(struct transaction_packfile *state,
 			die("unexpected deflate failure: %d", status);
 		}
 	}
+
+	if (total != size)
+		die("read %" PRIuMAX " bytes of blob data, but expected %" PRIuMAX " bytes",
+		    (uintmax_t)total, (uintmax_t)size);
+
 	git_deflate_end(&s);
 }
 
@@ -1571,10 +1574,13 @@ static void flush_packfile_transaction(struct odb_transaction_files *transaction
  * binary blobs, they generally do not want to get any conversion, and
  * callers should avoid this code path when filters are requested.
  */
-static int index_blob_packfile_transaction(struct odb_transaction_files *transaction,
-					   struct object_id *result_oid, int fd,
-					   size_t size, const char *path)
+static int index_blob_packfile_transaction(struct odb_transaction *base,
+					   struct odb_write_stream *stream,
+					   size_t size, struct object_id *result_oid)
 {
+	struct odb_transaction_files *transaction = container_of(base,
+								 struct odb_transaction_files,
+								 base);
 	struct transaction_packfile *state = &transaction->packfile;
 	struct git_hash_ctx ctx;
 	unsigned char obuf[16384];
@@ -1608,7 +1614,7 @@ static int index_blob_packfile_transaction(struct odb_transaction_files *transac
 	hashfile_checkpoint(state->f, &checkpoint);
 	idx->offset = state->offset;
 	crc32_begin(state->f);
-	stream_blob_to_pack(state, &ctx, fd, size, path);
+	stream_blob_to_pack(state, &ctx, size, stream);
 	git_hash_final_oid(result_oid, &ctx);
 
 	idx->crc32 = crc32_end(state->f);
@@ -1652,15 +1658,12 @@ int index_fd(struct index_state *istate, struct object_id *oid,
 
 		if (flags & INDEX_WRITE_OBJECT) {
 			struct object_database *odb = the_repository->objects;
-			struct odb_transaction_files *files_transaction;
-			struct odb_transaction *transaction;
-
-			transaction = odb_transaction_begin(odb);
-			files_transaction = container_of(odb->transaction,
-							 struct odb_transaction_files,
-							 base);
-			ret = index_blob_packfile_transaction(files_transaction, oid, fd,
-						      xsize_t(st->st_size), path);
+			struct odb_transaction *transaction = odb_transaction_begin(odb);
+
+			ret = index_blob_packfile_transaction(odb->transaction,
+							      &stream,
+							      xsize_t(st->st_size),
+							      oid);
 			odb_transaction_commit(transaction);
 		} else {
 			ret = hash_blob_stream(&stream,
-- 
2.53.0.381.g628a66ccf6

