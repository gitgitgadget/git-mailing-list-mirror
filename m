Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725F623507B
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 03:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774928345; cv=none; b=BEdIuDEbZQJDmbKWeteG8PMVU+wI22tw5OO/lvx3Tf3s04ruw+eJ/8O0jox8PQtyTyh+VXar94YSjYDAM09ngIgYZ6rFj/ssrUZ2+iOwy+8qn6dh5F55MnTbucqwmh9XQtIOdiirwYBGi7MPNc6ffLjOU6av2Vof0CSm3bm1ie4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774928345; c=relaxed/simple;
	bh=ZwxZMuVuQvIpfPYb9wVMhmqvLj4EoqNRU9f4jG/fWeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jk/W1CHlMy17BvzvQwXUV5HgBjzP7RrrQkJw3dKym6z5D8qB3xyavQiuCWOhtdcv8Hx0MkBKANqterhZtpw7zEnD1cERIOEyQrnEtnRhSIdtTAIrV7Jz3H3fe7FTGgwocKUrayiTRFAnuayIrqoF0uAsPiL2QQbS9e7iGL36XdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s5wI0bR1; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s5wI0bR1"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7d743cd9e5bso3450008a34.2
        for <git@vger.kernel.org>; Mon, 30 Mar 2026 20:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774928342; x=1775533142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQfBP7RonI5MtrUyh73Tpf8lyjTtFYIJ5w3fCCX9Y8U=;
        b=s5wI0bR1GBKfWxMSbJzHsDn7uBhK07yE5vrB3lxUQeG+nLgfqC47+RIpQA/FTdeW3c
         QMXdpDqrRaCWhhLuybUwVNgUtQHaSxQdfMyRkRHxsSf+yX3i3fbqAqQD11lu8GGekL6n
         W2C2f1fu4RAa5aVa0FvzrxmqhNNHtljE13XmR18lCPU9brhcccZ3y99IcsJlguPPrA1u
         1V2QZfgiMcr51PEmdmKiV/voTwbK25lg9+K1n1Ce5b+svUQRaMZdy2W3gUhNkxbDCbDV
         Y8rKJMofCN9TW21OBSXHsRLA/4jmeqBEKyem7QtJobm9aSSZq787si2m1Tk1IB6OIaJo
         C12Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774928342; x=1775533142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pQfBP7RonI5MtrUyh73Tpf8lyjTtFYIJ5w3fCCX9Y8U=;
        b=ph0br7q6Sao70Rshvpcl5H9mhbmPvnW4zarzHJKVnwAp8fZ2MUCEYbJ3rw74hIC7xp
         Bisx8Xex9vYpi3EW15mp5++M1Ojy1Pjyc0rlllXGnb99TT+mUe+tV8y/PfbXRj/w9M1g
         c1HF+Cwxk//iK/swkNaC2h1ImP/MqQx2ioxfNzHHQNNx9fm5fnPEaMlpjLBvRgouPAIH
         FLw7hKY2GORfPDeFkvVQplQTnnfnJXDjIgeEF/52CMr1+NPWzRECP5eBg/gqTc0PGq+p
         YEW0SM28fVQ4WoVhkpvQWRKlOzUX47ee8lw1fTew2u6XpJNDQZr9Kmwnq2fOR9NiD1Rz
         M3BQ==
X-Gm-Message-State: AOJu0YxVFU+aN+zLs3Rl+A73lDPAkWaq937IaXKQwKltoVIwiJXGYgj8
	FPVJ741B/DLTDkpwCcZBfkjffVoX8YNKyXkOT5t2DRFjRE5GzyZT5wuSf+s+dg==
X-Gm-Gg: ATEYQzyS3PdfC34Fz8Vr/nT/rhXKM1fveWOYM9oInkds6VFUoMP34eO/G7i0SLnHCr9
	b3WqwMGyK2iBQoqZZBI7H6kt8bw3ZWeO6jWtamoAbWzO8NqwIfDZklKONzFykyHUTRx7bYFdbHs
	sI1ZOJtUbMqbHa3Vv9aW8XP9eogvb/72U0ayphvpSY+8TpIkIhOVRieHO/ibYKQnGA7tNriGRIe
	3/S0L8HzZ701qRJe0Sy6uXPa8dKIcBqxIsfT/LhARdUWiO4zCJlQwmIXiSKB75NnQoTyWdo4h1m
	SKG+1DnKUQn710DX9jPkmDVi5EHS+lu4K61qM3TtS1P+VeRetwG0F0Pud+QymweyxFXyHt0IMiF
	021dW+lalffPMn1P1QrRmPvf4vCPt5oH48fxhH/Am/MZnUTPeZbZ8LgUX9IpcjFg34OWMB3MkVg
	NuAT/TmSw67p2aWluY+5R3+Bs4NK4ZSwo=
X-Received: by 2002:a05:6830:83a1:b0:7d9:f46b:8594 with SMTP id 46e09a7af769-7d9faf4664cmr8602848a34.26.1774928342088;
        Mon, 30 Mar 2026 20:39:02 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7da0a3b2e37sm7494665a34.10.2026.03.30.20.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 20:39:01 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 3/6] object-file: remove flags from transaction packfile writes
Date: Mon, 30 Mar 2026 22:38:32 -0500
Message-ID: <20260331033835.2863514-4-jltobler@gmail.com>
X-Mailer: git-send-email 2.53.0.381.g628a66ccf6
In-Reply-To: <20260331033835.2863514-1-jltobler@gmail.com>
References: <20260331033835.2863514-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `index_blob_packfile_transaction()` function handles streaming a
blob from an fd to compute its object ID and conditionally writes the
object directly to a packfile if the INDEX_WRITE_OBJECT flag is set. A
subsequent commit will make these packfile object writes part of the
transaction interface. Consequently, having the object write be
conditional on this flag is a bit awkward.

In preparation for this change, introduce a dedicated
`hash_blob_stream()` helper that only computes the OID from the fd. This
is invoked by `index_fd()` instead when the INDEX_WRITE_OBJECT is not
set. The object write performed via `index_blob_packfile_transaction()`
is made unconditional accordingly.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 object-file.c | 124 +++++++++++++++++++++++++++++---------------------
 1 file changed, 71 insertions(+), 53 deletions(-)

diff --git a/object-file.c b/object-file.c
index bfbb632cf8..493173eaf4 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1388,11 +1388,10 @@ static int already_written(struct odb_transaction_files *transaction,
 }
 
 /* Lazily create backing packfile for the state */
-static void prepare_packfile_transaction(struct odb_transaction_files *transaction,
-					 unsigned flags)
+static void prepare_packfile_transaction(struct odb_transaction_files *transaction)
 {
 	struct transaction_packfile *state = &transaction->packfile;
-	if (!(flags & INDEX_WRITE_OBJECT) || state->f)
+	if (state->f)
 		return;
 
 	state->f = create_tmp_packfile(transaction->base.source->odb->repo,
@@ -1405,6 +1404,34 @@ static void prepare_packfile_transaction(struct odb_transaction_files *transacti
 		die_errno("unable to write pack header");
 }
 
+static int hash_blob_stream(const struct git_hash_algo *hash_algo,
+			    struct object_id *result_oid, int fd, size_t size)
+{
+	unsigned char buf[16384];
+	struct git_hash_ctx ctx;
+	unsigned header_len;
+
+	header_len = format_object_header((char *)buf, sizeof(buf),
+					  OBJ_BLOB, size);
+	hash_algo->init_fn(&ctx);
+	git_hash_update(&ctx, buf, header_len);
+
+	while (size) {
+		size_t rsize = size < sizeof(buf) ? size : sizeof(buf);
+		ssize_t read_result = read_in_full(fd, buf, rsize);
+
+		if ((size_t)read_result != rsize)
+			return -1;
+
+		git_hash_update(&ctx, buf, rsize);
+		size -= read_result;
+	}
+
+	git_hash_final_oid(result_oid, &ctx);
+
+	return 0;
+}
+
 /*
  * Read the contents from fd for size bytes, streaming it to the
  * packfile in state while updating the hash in ctx. Signal a failure
@@ -1422,15 +1449,13 @@ static void prepare_packfile_transaction(struct odb_transaction_files *transacti
  */
 static int stream_blob_to_pack(struct transaction_packfile *state,
 			       struct git_hash_ctx *ctx, off_t *already_hashed_to,
-			       int fd, size_t size, const char *path,
-			       unsigned flags)
+			       int fd, size_t size, const char *path)
 {
 	git_zstream s;
 	unsigned char ibuf[16384];
 	unsigned char obuf[16384];
 	unsigned hdrlen;
 	int status = Z_OK;
-	int write_object = (flags & INDEX_WRITE_OBJECT);
 	off_t offset = 0;
 
 	git_deflate_init(&s, pack_compression_level);
@@ -1465,20 +1490,18 @@ static int stream_blob_to_pack(struct transaction_packfile *state,
 		status = git_deflate(&s, size ? 0 : Z_FINISH);
 
 		if (!s.avail_out || status == Z_STREAM_END) {
-			if (write_object) {
-				size_t written = s.next_out - obuf;
-
-				/* would we bust the size limit? */
-				if (state->nr_written &&
-				    pack_size_limit_cfg &&
-				    pack_size_limit_cfg < state->offset + written) {
-					git_deflate_abort(&s);
-					return -1;
-				}
-
-				hashwrite(state->f, obuf, written);
-				state->offset += written;
+			size_t written = s.next_out - obuf;
+
+			/* would we bust the size limit? */
+			if (state->nr_written &&
+			    pack_size_limit_cfg &&
+			    pack_size_limit_cfg < state->offset + written) {
+				git_deflate_abort(&s);
+				return -1;
 			}
+
+			hashwrite(state->f, obuf, written);
+			state->offset += written;
 			s.next_out = obuf;
 			s.avail_out = sizeof(obuf);
 		}
@@ -1566,8 +1589,7 @@ static void flush_packfile_transaction(struct odb_transaction_files *transaction
  */
 static int index_blob_packfile_transaction(struct odb_transaction_files *transaction,
 					   struct object_id *result_oid, int fd,
-					   size_t size, const char *path,
-					   unsigned flags)
+					   size_t size, const char *path)
 {
 	struct transaction_packfile *state = &transaction->packfile;
 	off_t seekback, already_hashed_to;
@@ -1575,7 +1597,7 @@ static int index_blob_packfile_transaction(struct odb_transaction_files *transac
 	unsigned char obuf[16384];
 	unsigned header_len;
 	struct hashfile_checkpoint checkpoint;
-	struct pack_idx_entry *idx = NULL;
+	struct pack_idx_entry *idx;
 
 	seekback = lseek(fd, 0, SEEK_CUR);
 	if (seekback == (off_t)-1)
@@ -1586,33 +1608,26 @@ static int index_blob_packfile_transaction(struct odb_transaction_files *transac
 	transaction->base.source->odb->repo->hash_algo->init_fn(&ctx);
 	git_hash_update(&ctx, obuf, header_len);
 
-	/* Note: idx is non-NULL when we are writing */
-	if ((flags & INDEX_WRITE_OBJECT) != 0) {
-		CALLOC_ARRAY(idx, 1);
-
-		prepare_packfile_transaction(transaction, flags);
-		hashfile_checkpoint_init(state->f, &checkpoint);
-	}
+	CALLOC_ARRAY(idx, 1);
+	prepare_packfile_transaction(transaction);
+	hashfile_checkpoint_init(state->f, &checkpoint);
 
 	already_hashed_to = 0;
 
 	while (1) {
-		prepare_packfile_transaction(transaction, flags);
-		if (idx) {
-			hashfile_checkpoint(state->f, &checkpoint);
-			idx->offset = state->offset;
-			crc32_begin(state->f);
-		}
+		prepare_packfile_transaction(transaction);
+		hashfile_checkpoint(state->f, &checkpoint);
+		idx->offset = state->offset;
+		crc32_begin(state->f);
+
 		if (!stream_blob_to_pack(state, &ctx, &already_hashed_to,
-					 fd, size, path, flags))
+					 fd, size, path))
 			break;
 		/*
 		 * Writing this object to the current pack will make
 		 * it too big; we need to truncate it, start a new
 		 * pack, and write into it.
 		 */
-		if (!idx)
-			BUG("should not happen");
 		hashfile_truncate(state->f, &checkpoint);
 		state->offset = checkpoint.offset;
 		flush_packfile_transaction(transaction);
@@ -1620,8 +1635,6 @@ static int index_blob_packfile_transaction(struct odb_transaction_files *transac
 			return error("cannot seek back");
 	}
 	git_hash_final_oid(result_oid, &ctx);
-	if (!idx)
-		return 0;
 
 	idx->crc32 = crc32_end(state->f);
 	if (already_written(transaction, result_oid)) {
@@ -1642,7 +1655,7 @@ int index_fd(struct index_state *istate, struct object_id *oid,
 	     int fd, struct stat *st,
 	     enum object_type type, const char *path, unsigned flags)
 {
-	int ret;
+	int ret = 0;
 
 	/*
 	 * Call xsize_t() only when needed to avoid potentially unnecessary
@@ -1659,18 +1672,23 @@ int index_fd(struct index_state *istate, struct object_id *oid,
 		ret = index_core(istate, oid, fd, xsize_t(st->st_size),
 				 type, path, flags);
 	} else {
-		struct object_database *odb = the_repository->objects;
-		struct odb_transaction_files *files_transaction;
-		struct odb_transaction *transaction;
-
-		transaction = odb_transaction_begin(odb);
-		files_transaction = container_of(odb->transaction,
-						 struct odb_transaction_files,
-						 base);
-		ret = index_blob_packfile_transaction(files_transaction, oid, fd,
-						      xsize_t(st->st_size),
-						      path, flags);
-		odb_transaction_commit(transaction);
+		if (flags & INDEX_WRITE_OBJECT) {
+			struct object_database *odb = the_repository->objects;
+			struct odb_transaction_files *files_transaction;
+			struct odb_transaction *transaction;
+
+			transaction = odb_transaction_begin(odb);
+			files_transaction = container_of(odb->transaction,
+							 struct odb_transaction_files,
+							 base);
+			ret = index_blob_packfile_transaction(files_transaction, oid, fd,
+						      xsize_t(st->st_size), path);
+			odb_transaction_commit(transaction);
+		} else {
+			if (hash_blob_stream(the_repository->hash_algo, oid, fd,
+					     xsize_t(st->st_size)))
+				die("failed to hash blob");
+		}
 	}
 
 	close(fd);
-- 
2.53.0.381.g628a66ccf6

