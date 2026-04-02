Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C05E3BD258
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 21:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775165577; cv=none; b=IXcoye4XkSwQR8YtJIFYrtxoRRYLaoOtEN1HJ09lans3N2KcZXDd6rYCGnQCWhOJlfzz/bSdBtB8P9dowQTh7Vhh4NAJ3YA/On2hQl9Xy/5hA370qm2dJ3hJJcRBByjpwEaF0HyXeRfXwgK8Yh7SitJCdmE76SfdwKB1Oh0HoXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775165577; c=relaxed/simple;
	bh=oP/bnYa+SmGlve8ZOILkWgvZOKNcvjWxOsopHz2Zj7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kVjehp74hCUV5Du762XUlfcPlxzbD31ICSZc63Km2cdTDdxKh480SSXLnWsrWpiJ1MnCOvbVdjyjoPRT17Q9MdVskR4XR5kxq06UDcdcvIx+mnnsWcPOKJNLgHZDLKVzlZv/YDJwbw3ixz0xbMaweyeqwOEhY8KhwfGXd17gaQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fQrsjCdz; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQrsjCdz"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-679f6ee3fb0so532592eaf.2
        for <git@vger.kernel.org>; Thu, 02 Apr 2026 14:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775165573; x=1775770373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X5qwyTphKEH37JiNuf3K3jMV3Ds5ZlRSTrMqj0lnXIg=;
        b=fQrsjCdzDVVM2spoVXgMIJy1ifb9AuXpwu5YJD98kJNuh1SuFd/8e48I6Pz3E+TnG0
         BtcmF4jcrUrF651lpC3pnq7oaOKeZ14zdDemKRsLKkbFM5Bjtz8beRzQn7qLDhZbqSY/
         N9M7YZwldqljORIEmh2xP47FLvxl5owZlTUiI5EOAGYkCuZx+AYrSY0XR7WYrEWJLrXX
         3LTWfYKMdDg/PdVcv9j78k1LhzbgGRz2FY9euqicFjyDC3nEOE+AiSPQRp9dsjkkWnNb
         T7k33H+eCD4A5svmtZENnzIOErzl8h2ETD8FD7+E2F+V87vqf+ve63GpgKiwYfYTT3qM
         qhfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775165573; x=1775770373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X5qwyTphKEH37JiNuf3K3jMV3Ds5ZlRSTrMqj0lnXIg=;
        b=UlI75WzHAuhQx9sQ3ZXBOLqeKXx3q5r2OnUZTfXFtjxOkqcJuRzPHwlP9/+gZTx7yC
         2iFirN6q+lYlEJ0nIbYvxSxkWwRE3A4c6Ihwd7NsCGoC1rZMk6XzA5p4giRYB4Jak+4J
         nIS/d2w6cwuXqCKk+P9Ys3lP112ZuXOjh8SXfQcm3haLj14nTQZu48JYFO4H5MjRIG8r
         FRmeDyL7DqrxXBFS8+N3KBJ0Iv2PrLn85GXd4NuVPRQPWPApb2ZglxeB06gkUh2nfnEt
         m/aYFUn213TgtXUEduaAmfmxsyv459bQ9WJwzdrDia2iVFG43JfzjD3OXPOzzKU59SPa
         OZbg==
X-Gm-Message-State: AOJu0YzuF9LXufkNqDo3I8LTpbeyM2OcgI96WWWLLn8YtqYwzq+l0c4O
	CVNByW6/14vw4Rot3oJIkYP969JNWqrjQlX0OWae2+7S4h5IyEjGQeSef3JGqA==
X-Gm-Gg: ATEYQzzNrLuaKGCKevCpGSWxwz+dV3qp1Ay/+vUDW5/izW5EzO+1xzKVgCfOciv6quO
	2wyWdvuQHcNE8PyxtGxDwzB6/V82EKgXn8oc6nyR5SeXcW5AReUk+GlufvJ9AZs50+r2CKELEN5
	Npf/yS9o1bbLOYn03Kj1cv3oe3cO6EeIGjNwjvef3uJf7VxwVPb+5Du3S2f8xmUVYWBiQEtZ63m
	/b3nOJweFSOYjXtWwGP2KdyDLDjg1WO9ehLZM3hysu1xQpI3R7i6RJE/a8e9pLUejwdDxBp9Tos
	IbdsqwpROztxk2YDUdpSqdzdESaaeMzgRUKL6vNwzVK4ZK/+0cwFuwGru61/3847HCcsYVmnbeu
	afb/dWQ0oMSJSarBSHAVI5sRv6IRr99HTx7HzJl2kHhFgo+X+WECVNMI5qmZbk2XfrzVFZHapOg
	Kli817Wh1eUZ0G0C0EkIYAcHfPaNTlwDg=
X-Received: by 2002:a05:6820:3087:b0:67e:21c9:ab55 with SMTP id 006d021491bc7-6821e8699famr424964eaf.3.1775165573457;
        Thu, 02 Apr 2026 14:32:53 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-422eaf2c780sm3325030fac.6.2026.04.02.14.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 14:32:53 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 5/7] object-file: avoid fd seekback by checking object size upfront
Date: Thu,  2 Apr 2026 16:32:18 -0500
Message-ID: <20260402213220.2651523-6-jltobler@gmail.com>
X-Mailer: git-send-email 2.53.0.381.g628a66ccf6
In-Reply-To: <20260402213220.2651523-1-jltobler@gmail.com>
References: <20260401030316.1847362-1-jltobler@gmail.com>
 <20260402213220.2651523-1-jltobler@gmail.com>
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
index 382d14c8c0..0284d5434b 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1447,29 +1447,17 @@ static int hash_blob_stream(struct odb_write_stream *stream,
 
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
 
@@ -1486,15 +1474,9 @@ static int stream_blob_to_pack(struct transaction_packfile *state,
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
@@ -1505,14 +1487,6 @@ static int stream_blob_to_pack(struct transaction_packfile *state,
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
@@ -1529,7 +1503,6 @@ static int stream_blob_to_pack(struct transaction_packfile *state,
 		}
 	}
 	git_deflate_end(&s);
-	return 0;
 }
 
 static void flush_packfile_transaction(struct odb_transaction_files *transaction)
@@ -1605,48 +1578,39 @@ static int index_blob_packfile_transaction(struct odb_transaction_files *transac
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

