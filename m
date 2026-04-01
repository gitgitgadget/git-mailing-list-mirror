Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1FB3630B0
	for <git@vger.kernel.org>; Wed,  1 Apr 2026 03:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775012609; cv=none; b=G9+18pgyzuDUE9vFOU7HFR3tlIvqRznF3HUFJj7kTofx5VRlEJAWgidpurm7PqbBlsUp2yv/r3RWPTyJ3vKHm4st4fis0CX/i9are+8koXkegiADERhT5vzoVKsjHcsHSlC6vSv14pcCJxy0O3VDregClMT2O29x1L/xO1zfhUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775012609; c=relaxed/simple;
	bh=1VGGWtqQypj7MLrt3vyT8PRmf8GXTGQ8+lGmaYbyh+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U+Hzyp1eJibBsIoZrJwQFRuz/RK/4XOb0HPbQJRwr5TxIjcyjTgvhUuTlals6sEjCiy+b44B8VDd7NU7eOFUaz5qOd1EIpez31Qf3nI9bFl9gAsV5ECD76+IPiiEMRereWkC6fDgFFPBHAOjnjNDgJtoHnwS9o/0QdxFSy4qi64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XRHwtR8v; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XRHwtR8v"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7d75ed779bfso6571555a34.2
        for <git@vger.kernel.org>; Tue, 31 Mar 2026 20:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775012605; x=1775617405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=In5fiUo8jE55s9vl+YLOjlKKZKYdVUcKoLKA5LjP/4c=;
        b=XRHwtR8vLyR/m3wZYUx/zv1rmKl0LBsqYvqtkz8HMIxNp9HBsDvdYwokPsvNfIZ7yH
         /WXYg2IaZAsA4P+F/I43ag827b8Qb3OhYvf+zN1T1SmgvfI7QGminyPqU3fP9znlOtZJ
         bz8F1J6VzTm5qPZfkjJdRtllxowfj3sJMA7VRJXiTm3+e9iUR3RdFNakeU3ER06xqFg8
         vhULXyEfgGMFVBtOH97aM11Z572W3hUloRDUQrmM5E81VxxjQv9ZO/CjyKUWzq6NhOUu
         OZ208Xo/8f/EKhh8EGo927esTkZ7N0LbIwpmx1/f1fUGzdaaLS07+pCRcqXtYvSjFZSn
         794Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775012605; x=1775617405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=In5fiUo8jE55s9vl+YLOjlKKZKYdVUcKoLKA5LjP/4c=;
        b=htUPTAPYqZc7KK0XKnqVVoP6oaAY2+vzgLOJ5mjQ3tMkAobF0ksGzGwagW/hKzQcgc
         rDcgSHZQCisOX1Z09Lnv8VidZ3Q1zHDXRNJ2SpgFdHpWLxat6S8+xMS1B/DFw+I1wzb9
         pCC1pSfMPLPeKFrYE2H1cylfGvD5C9fijhV4Gdf7sR8DG++B5pwSsuaLc1hbUPEM4n9t
         X6buKov0qBGHjWz39za7Znte0nSXLZPXlWUA8VRpBejFpOR9Gev79XDHIKeuxRrMwn4H
         Ya+QsBp3cCLCg2Lwg4EzRo68eyAy49NSk9RUzesDqZL1zd/cWtgRGTHazG94bqvuIFJR
         Uyew==
X-Gm-Message-State: AOJu0YzbU1CkFb81EUeWqINx3zpuH4MjbYRvLVsVs5wTVoV9e/KPO4MN
	otIrjqC0UuuIVV7P0c7voJZ7uwHAp3C1tV4bz7NW7MuBWRcQ2hgOu7yXGAtnzw==
X-Gm-Gg: ATEYQzxzcN1q8BSvHrkTTBCmDVW8RPcjjjj3C2c+OtRPWpkRtctngU77R8vNcGGjqOD
	Fw0uuJmf5Sgig4O8sXv650cYTEzMX/016oJRsaalVXx6dPlMddX8EFVxpD4dO6KbC1WQXSLBYnd
	HwEGdlSfPDOwG2t0tbcYFplZC1KricXhzk2phlE/JcbOX7D/HsKGOcPoRNweUpRX8FrpzmTo6QT
	oh9z19eEN32XFuu4qz4O6q7gNcUZGI/LqcETOT8lmwnHyxMH0/MTIQG7jNz9URZQAjL8ka16lKP
	wCYL08g2c9s41ZSescY+ceTr7pu97tFFY+8bLvUFSk8jTOePmhvgE9nct/7q0T67eD//tiMEfM/
	CS5U1HvCukqeWaH+Tqr1Q2Mp189UQbUXYzmnT24v9MNNuesFhVNn3cccBSexCc6aVufYggccCZB
	v75BwszXW1pL5C+wNWhvdVdsg3MD4wzTzTya0ckJzxzw==
X-Received: by 2002:a05:6830:82b8:b0:7d7:d1e1:6987 with SMTP id 46e09a7af769-7db993469admr1230552a34.21.1775012604976;
        Tue, 31 Mar 2026 20:03:24 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7da0a821746sm10266001a34.24.2026.03.31.20.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 20:03:24 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 5/7] object-file: avoid fd seekback by checking object size upfront
Date: Tue, 31 Mar 2026 22:03:13 -0500
Message-ID: <20260401030316.1847362-6-jltobler@gmail.com>
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

In certain scenarios, Git handles writing blobs that exceed
"core.bigFileThreshold" differently by streaming the object directly
into a packfile. When there is an active ODB transaction, these blobs
are streamed to the same packfile instead of using a separate packfile
for each. If "pack.packSizeLimit" is configured and streaming another
object causes the packfile to exceed the configured limit, the packfile
is truncated back to the previous object and the object write is
restarted in a new packfile.

This works fine, but requires the fd being read from to save a
checkpoint so it becomes possible to rewind the input source via seeking
back to a known offset at the beginning. In a subsequent commit, blob
streaming is converted to use `struct odb_write_stream` as a more
generic input source instead of an fd which doesn't provide a mechanism
for rewinding.

For this use case though, rewinding the fd is not strictly necessary
because the inflated size of the object is known and can be used to
approximate whether writing the object would cause the packfile to
exceed the configured limit prior to writing anything. These blobs
written to the packfile are never deltified thus the size difference
between what is written versus the inflated size is due to zlib
compression. While this does prevent packfiles from being filled to the
potential maximum is some cases, it should be good enough and still
prevents the packfile from exceeding any configured limit.

Use the inflated blob size to determine whether writing an object to a
packfile will exceed the configured "pack.packSizeLimit".

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 object-file.c | 86 +++++++++++++++------------------------------------
 1 file changed, 25 insertions(+), 61 deletions(-)

diff --git a/object-file.c b/object-file.c
index f317a24ccf..23229fbd95 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1445,29 +1445,17 @@ static int hash_blob_stream(struct odb_write_stream *stream,
 
 /*
  * Read the contents from fd for size bytes, streaming it to the
- * packfile in state while updating the hash in ctx. Signal a failure
- * by returning a negative value when the resulting pack would exceed
- * the pack size limit and this is not the first object in the pack,
- * so that the caller can discard what we wrote from the current pack
- * by truncating it and opening a new one. The caller will then call
- * us again after rewinding the input fd.
- *
- * The already_hashed_to pointer is kept untouched by the caller to
- * make sure we do not hash the same byte when we are called
- * again. This way, the caller does not have to checkpoint its hash
- * status before calling us just in case we ask it to call us again
- * with a new pack.
+ * packfile in state while updating the hash in ctx.
  */
-static int stream_blob_to_pack(struct transaction_packfile *state,
-			       struct git_hash_ctx *ctx, off_t *already_hashed_to,
-			       int fd, size_t size, const char *path)
+static void stream_blob_to_pack(struct transaction_packfile *state,
+				struct git_hash_ctx *ctx, int fd, size_t size,
+				const char *path)
 {
 	git_zstream s;
 	unsigned char ibuf[16384];
 	unsigned char obuf[16384];
 	unsigned hdrlen;
 	int status = Z_OK;
-	off_t offset = 0;
 
 	git_deflate_init(&s, pack_compression_level);
 
@@ -1484,15 +1472,9 @@ static int stream_blob_to_pack(struct transaction_packfile *state,
 			if ((size_t)read_result != rsize)
 				die("failed to read %u bytes from '%s'",
 				    (unsigned)rsize, path);
-			offset += rsize;
-			if (*already_hashed_to < offset) {
-				size_t hsize = offset - *already_hashed_to;
-				if (rsize < hsize)
-					hsize = rsize;
-				if (hsize)
-					git_hash_update(ctx, ibuf, hsize);
-				*already_hashed_to = offset;
-			}
+
+			git_hash_update(ctx, ibuf, rsize);
+
 			s.next_in = ibuf;
 			s.avail_in = rsize;
 			size -= rsize;
@@ -1503,14 +1485,6 @@ static int stream_blob_to_pack(struct transaction_packfile *state,
 		if (!s.avail_out || status == Z_STREAM_END) {
 			size_t written = s.next_out - obuf;
 
-			/* would we bust the size limit? */
-			if (state->nr_written &&
-			    pack_size_limit_cfg &&
-			    pack_size_limit_cfg < state->offset + written) {
-				git_deflate_abort(&s);
-				return -1;
-			}
-
 			hashwrite(state->f, obuf, written);
 			state->offset += written;
 			s.next_out = obuf;
@@ -1527,7 +1501,6 @@ static int stream_blob_to_pack(struct transaction_packfile *state,
 		}
 	}
 	git_deflate_end(&s);
-	return 0;
 }
 
 static void flush_packfile_transaction(struct odb_transaction_files *transaction)
@@ -1603,48 +1576,39 @@ static int index_blob_packfile_transaction(struct odb_transaction_files *transac
 					   size_t size, const char *path)
 {
 	struct transaction_packfile *state = &transaction->packfile;
-	off_t seekback, already_hashed_to;
 	struct git_hash_ctx ctx;
 	unsigned char obuf[16384];
 	unsigned header_len;
 	struct hashfile_checkpoint checkpoint;
 	struct pack_idx_entry *idx;
 
-	seekback = lseek(fd, 0, SEEK_CUR);
-	if (seekback == (off_t)-1)
-		return error("cannot find the current offset");
-
 	header_len = format_object_header((char *)obuf, sizeof(obuf),
 					  OBJ_BLOB, size);
 	transaction->base.source->odb->repo->hash_algo->init_fn(&ctx);
 	git_hash_update(&ctx, obuf, header_len);
 
+	/*
+	 * If writing another object to the packfile could result in it
+	 * exceeding the configured size limit, flush the current packfile
+	 * transaction.
+	 *
+	 * Note that this uses the inflated object size as an approximation.
+	 * Blob objects written in this manner are not delta-compressed, so
+	 * the difference between the inflated and on-disk size is limited
+	 * to zlib compression and is sufficient for this check.
+	 */
+	if (state->nr_written && pack_size_limit_cfg &&
+	    pack_size_limit_cfg < state->offset + size)
+		flush_packfile_transaction(transaction);
+
 	CALLOC_ARRAY(idx, 1);
 	prepare_packfile_transaction(transaction);
 	hashfile_checkpoint_init(state->f, &checkpoint);
 
-	already_hashed_to = 0;
-
-	while (1) {
-		prepare_packfile_transaction(transaction);
-		hashfile_checkpoint(state->f, &checkpoint);
-		idx->offset = state->offset;
-		crc32_begin(state->f);
-
-		if (!stream_blob_to_pack(state, &ctx, &already_hashed_to,
-					 fd, size, path))
-			break;
-		/*
-		 * Writing this object to the current pack will make
-		 * it too big; we need to truncate it, start a new
-		 * pack, and write into it.
-		 */
-		hashfile_truncate(state->f, &checkpoint);
-		state->offset = checkpoint.offset;
-		flush_packfile_transaction(transaction);
-		if (lseek(fd, seekback, SEEK_SET) == (off_t)-1)
-			return error("cannot seek back");
-	}
+	hashfile_checkpoint(state->f, &checkpoint);
+	idx->offset = state->offset;
+	crc32_begin(state->f);
+	stream_blob_to_pack(state, &ctx, fd, size, path);
 	git_hash_final_oid(result_oid, &ctx);
 
 	idx->crc32 = crc32_end(state->f);
-- 
2.53.0.381.g628a66ccf6

