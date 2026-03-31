Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D7A29C35A
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 03:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774928346; cv=none; b=MSL2LKAUEJiQRW70btOc/dYPaTa727fK+zXD8v12IIgsPK2J6twdYpEnOMfRKSiwLrJOV17XEvPBgz4yWDMP4pVdXYh/j1t9yfYemXUbohyDEWqZ0ujynX8BT+N0YgULqO0CplU24JqnEIYD0u0eXR+/OKc2lBxV0P0wTNRBLz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774928346; c=relaxed/simple;
	bh=UkI2EwiMHl/LucslPvzTBVeHBqtMahrH7UU74ivRJlg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ls3jxLag9h05fD4HGoD/1gv4S+yWVYj+l4kDcL1Vkho8lwKt9CnamWV4k+/1pW0EuS2uTEWxXbVxdxDWhlAiW5C0ndgSJO1UzGj67SIMe6moiQ3prGjjYfw6qXR3X3k+wZKtRZYfMHW8qCfKrMpihFw2DtWvZ518pwXzCXPb+Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZvfTqWq; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZvfTqWq"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7d9c98e437cso4405986a34.0
        for <git@vger.kernel.org>; Mon, 30 Mar 2026 20:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774928343; x=1775533143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NYdTX+Etjk2Z5Va9NU5rCoQD1QikWgwO7XvfX89pFpI=;
        b=eZvfTqWq0K4N9amaKdbcOlQ0zpbyg7tNsMEjOH67UKZDoVnsdVyM4Ml4oR36bGmufQ
         V4Ivave3r0ZVIz9/HeSm+VIVhTCTt2DGPUWP/oWZx+ZCRjsFgoG+C7vm97bRFwJfEeSL
         sB0/nbvKlncKYFf+TOUm4FvZzAeuuEI6FVmYFiCwYfWp1YwsU+coFeZW5Oim4S+Rtdpp
         055aAnYlbY0GoWI0RRDRaTI+lV0ZASPXiwMXdYBlbO/WHEqTXdPvKyKc+vIN1nTRBDMl
         Reh1IyX2K/0Cil46kVk/s6nnOcYgaYEAuFmoKu1wgEslVL/ik0+H3uhMTXd0f93fa6QA
         7M+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774928343; x=1775533143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NYdTX+Etjk2Z5Va9NU5rCoQD1QikWgwO7XvfX89pFpI=;
        b=WZRlMDAGBj7L0guqamZXe+C8g/Yn6xQX1WKa8Tb8hNApIu11SzxwnHkWrWHRvIXYFr
         ugIKHNl54mizBR+Shr0/vcZe+6x+D8xPJ6w1WudIYeeTkcKjRu4STWLmf62OIokr2N84
         H+LKK6K1b6r70oXXPKMfYGzNzdfAMnzvqvrUuciU1kep7p2iw+Y4eKSePy/msUDwizYf
         gT9Rxzeh6dfWo3RcB8AAZ1SfLuHjqqTKYuK1Ez574S1CnVdzCBVIG8aZ4qDa6OupkEdS
         qmD4Wy1NYAXHLIACDUqPesdnOR66zKYBe8LurLeoNnycPYTF4MvYIYxh0KJBwPPt+dmN
         wAtA==
X-Gm-Message-State: AOJu0Yzxxq9FISQtqG6/pbv38jtVvaHPeD1g6/ZI4IJwpP9E58h2zOVW
	w0PGbrs2GLyvKnNb6d7WCzybdgi9Ikswgt7VB+DElW1guWps/e3s2BrTddeVAg==
X-Gm-Gg: ATEYQzysGG/Tq1Jo+5kheO7hX7WO0GBQNgbIeZ1ySTfiz6iVtKWy8ZV9p9yJ6UWJ+vw
	ogMrqJffEhkj6xHpHDBIC0/k441EjYcZe061gtFVbImer4bmxiFqWLl04pUXL+sXXKWjkzQf7Nf
	z5XQSCSRCNaIVCKji5cM0cWRLx0U8Sw1xcmIw+1x+oXfCtAWHnvDNWdLY7LSLCN+WxCP3MZbybu
	opwPJHwvvTQppPuun3HReNwniDRGBu5fadE5sQ/oBdKRYgnBJxG/fzi6QZJxxYqWDOmD6cLhIfA
	OT0TbKMJfdIS1rkldDucngKvNUmVUCFmNamvzuJWdhnytrLLQ29Zcq2QzgphWh7+2t7ZqC7zeWA
	X9dsiuUjBRmgwkC028oG710o/kc2cElUNxH+80GnRwTCXAAejJccB+O+vlGWs0vPMO3zlDb+uBV
	TIG8LKSwYhk+lyTY0+k7WEkl4FmdCT/Ik=
X-Received: by 2002:a05:6830:6f90:b0:7d9:f50f:96cc with SMTP id 46e09a7af769-7d9fad9a5e0mr8693774a34.2.1774928343047;
        Mon, 30 Mar 2026 20:39:03 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7da0a3b2e37sm7494665a34.10.2026.03.30.20.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 20:39:02 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 4/6] object-file: avoid fd seekback by checking object size upfront
Date: Mon, 30 Mar 2026 22:38:33 -0500
Message-ID: <20260331033835.2863514-5-jltobler@gmail.com>
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

In certain scenarios, Git handles writing blobs that exceed
"core.bigFilesThreshold" differently by streaming the object directly
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
written to the packfile are never deltafied thus the size difference
between what is written versus the inflated size is due to zlib
compression. While this does prevent packfiles from being filled to the
potential maximum is some cases, it should be good enough and still
prevents the packfile from exceeding any configured limit.

Use the inflated blob size to determine whether writing an object to a
packfile will exceed the configured "pack.packSizeLimit".

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 object-file.c | 82 +++++++++++++--------------------------------------
 1 file changed, 21 insertions(+), 61 deletions(-)

diff --git a/object-file.c b/object-file.c
index 493173eaf4..1de2244ac5 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1434,29 +1434,17 @@ static int hash_blob_stream(const struct git_hash_algo *hash_algo,
 
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
 
@@ -1473,15 +1461,10 @@ static int stream_blob_to_pack(struct transaction_packfile *state,
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
+			if (rsize)
+				git_hash_update(ctx, ibuf, rsize);
+
 			s.next_in = ibuf;
 			s.avail_in = rsize;
 			size -= rsize;
@@ -1492,14 +1475,6 @@ static int stream_blob_to_pack(struct transaction_packfile *state,
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
@@ -1516,7 +1491,6 @@ static int stream_blob_to_pack(struct transaction_packfile *state,
 		}
 	}
 	git_deflate_end(&s);
-	return 0;
 }
 
 static void flush_packfile_transaction(struct odb_transaction_files *transaction)
@@ -1592,48 +1566,34 @@ static int index_blob_packfile_transaction(struct odb_transaction_files *transac
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

