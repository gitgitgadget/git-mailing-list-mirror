Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212B2346AFB
	for <git@vger.kernel.org>; Wed,  1 Apr 2026 03:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775012606; cv=none; b=RcoipumrgSPT3CjJ4evbwRjssaRuDA3DwR5OJEvPsNdeb0wb9RVyRMYQ8lujmzm42ynHcTMipTSAF3cFGm50TdzH58mf9b8Uq0IpAtLgKkCTCHBlPp82JdyTlmvleE5xuCRoZRpW+0otHIw/uCmenOeNdpx5QSrEAycmAVEPEe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775012606; c=relaxed/simple;
	bh=IF6ZfrrE5ewEFHPJQDQaMQj8lCIZZvmNtW3L5G0ndAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NY+wBFTTV99nKVZBxG9e4FaaCbaBhOBc0yjDxKzs2iJs86e0dVul/g4ypIxh1PZRDVnnhodrvpVpYHWds4NcHlbQB/J2EOMmZJvpsH+4FEQx2nN35mN+otY3coRj9MrPK/V7+ZxIWpbBbEl8Ko8H+J8gB6g7lrApUYEloD/ZyGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OKixkOBS; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKixkOBS"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7d74aa6bcdbso3571595a34.2
        for <git@vger.kernel.org>; Tue, 31 Mar 2026 20:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775012601; x=1775617401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hppL8SyC/xjT0D5S/T5IIzb9O3Sl9pkNHuOVj0bTqTg=;
        b=OKixkOBSjj5VgVhyEYXarPXXQ8ylBuAtJPMTj0qkmvWKDCVtCZIVgbvPlOSglZncDP
         RqsrdHAb+SDojEes6GVjqh/ed/czHF/4/WTsv9nBenj8aEklDcWlOb+aOEXokXmmeJNb
         us9N3rOZleZq0WWXwyBNYN3PSd9Xfbufdo/Yr8w+MSEUW2OKIAe8QeySDFES0OlhEBqx
         6oGyRmwVOMqulD2PvYdpE2zQ0eAZGePHT3aoiuYiix6ktSFJZ5HZNKnTmUCeV2cZe+eb
         kOFnULYIdANBOPKO3GjbbLghrRFxv9BinI+TLqHXZIQB+aktoam+JXtVyAJkciGziut9
         3gSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775012601; x=1775617401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hppL8SyC/xjT0D5S/T5IIzb9O3Sl9pkNHuOVj0bTqTg=;
        b=jKBZAjm84ekXlyPNkoOKJP2z5W5YMW3vsXUrPC+RBXaNwa/wE8euo0iM4SgZKY8n1m
         vi5/BEETxNQrtVZbUOJl80ouBg+mOavAN2QIXIAslkODBCcw2NCE2JjWk/Bn4+ou/m9j
         cMD1WzZ0N1YPFTQExn3c5krDcUjsO6S/PLErj0QZmhxqoCzhoIqK9o06YwYoUY0DBJ/R
         5W89As94WsZOy4oSpWlGQQRQBAg0j8pi8B9QdI0Txzac//ckqi3YvfGOS0jE+n/fwnKi
         g1XgbK96TECoyISorRw1/tNN1aJbZW0NGvWUI9Rl0V9eFCwKzISfR/lRf3TFFrR1Nkfc
         zZ/Q==
X-Gm-Message-State: AOJu0YzE3EO1Zsy0TSOzhPhpMLWHgD3ABckHDT7h70j3+S2XM0XGbz3W
	xgkoRipr+ms/QRSoLlIR8l9x6aP5KJLdGl7pQwgF/CIQBb6uSgQgVWtElU63EA==
X-Gm-Gg: ATEYQzxu1YHTizoVBNZ2E3myLx/8nOPZwv+XYh+KsD/LXYqm4YYwXC3/Thb+26b4jDw
	covnykI3cA/OhulvRmeTTOEi/yCjvQju7zYsUssqirGKLnE8WW2RDZTrskE81wL8SmNxdusQ2BR
	8C08bumYa+LQ/nW8X42qz9CcLi8XYLnQDkpghn9iDXERha2KO+mBFNb86NatV+x4OlwX5pT6Nci
	O10paxpOAZSRrhad2L9wtMT0EN89xP5wRqYHEeKww2JfdKGeIfDULuwQPgwP7Vs7Tychpvg13rF
	bri591L+aWxNCItMbrVjSQqEC9NTode2IrNvRwwR6T5UUrQVcKhF+7Bm1cVDazXiit7WTKdoqSR
	7QLjGGwzSCxgWiEfzndx4+s03b7tJGMLISZ9fySmIU7HfusAW4lTYquPy5ynBjAy8F7e++M/p3V
	jmV3sxIwr36/eTJPLdrCo2TrakS1rgbq8=
X-Received: by 2002:a05:6830:210c:b0:7d9:4bb3:1e6a with SMTP id 46e09a7af769-7db99429f8dmr1367099a34.26.1775012601339;
        Tue, 31 Mar 2026 20:03:21 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7da0a821746sm10266001a34.24.2026.03.31.20.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 20:03:20 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 0/7] odb: add write operation to ODB transaction interface
Date: Tue, 31 Mar 2026 22:03:08 -0500
Message-ID: <20260401030316.1847362-1-jltobler@gmail.com>
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

Greetings,

This series lays the groundwork for introducing write operations to the
ODB transaction interface. The eventual goal is for all object writes
performed within a transaction to go through this interface explicitly,
rather than implicitly relying on the transaction to reconfigure ODB
sources so that writes are redirected to a temporary location.

For now, only `odb_transaction_write_object_stream()` is implemented and
wires up the existing logic for streaming "large" blobs directly into a
packfile as part of the transaction.

Most of the patches are structural refactorings to enable this, but
patch 4 introduces a behavioral change in how packfiles that would
exceed "pack.packSizeLimit" are handled.

Changes since V1:
- Fixed some typos
- Improved error handling
- Removed unnecessary guard statement
- Documented in comments why inflated object size is used to approximate
  if object write will exceed "pack.packSizeLimit".
- Updated `struct odb_write_stream` read() callback to support returning
  errors and using caller provided buffer
- Updated the `hash_blob_stream()` function signature to operate on a
  `struct odb_write_stream` instead of an fd directly
- Renamed some variables/functions for better clarity

Thanks,
-Justin

Justin Tobler (7):
  odb: split `struct odb_transaction` into separate header
  odb/transaction: use pluggable `begin_transaction()`
  odb: update `struct odb_write_stream` read() callback
  object-file: remove flags from transaction packfile writes
  object-file: avoid fd seekback by checking object size upfront
  object-file: generalize packfile writes to use odb_write_stream
  odb/transaction: make `write_object_stream()` pluggable

 Makefile                 |   1 +
 builtin/add.c            |   1 +
 builtin/unpack-objects.c |  20 ++--
 builtin/update-index.c   |   1 +
 cache-tree.c             |   1 +
 meson.build              |   1 +
 object-file.c            | 234 ++++++++++++++++++++-------------------
 odb.c                    |  25 -----
 odb.h                    |  33 +-----
 odb/streaming.c          |  40 +++++++
 odb/streaming.h          |   8 ++
 odb/transaction.c        |  35 ++++++
 odb/transaction.h        |  57 ++++++++++
 read-cache.c             |   1 +
 14 files changed, 274 insertions(+), 184 deletions(-)
 create mode 100644 odb/transaction.c
 create mode 100644 odb/transaction.h

Range-diff against v1:
1:  65cb557a5a ! 1:  eee372b426 odb: split `struct odb_transaction` into separate header
    @@ Metadata
      ## Commit message ##
         odb: split `struct odb_transaction` into separate header
     
    -    The current ODB transaction interface is collocated with other ODB
    +    The current ODB transaction interface is colocated with other ODB
         interfaces in "odb.{c,h}". Subsequent commits will expand `struct
         odb_transaction` to support write operations on the transaction
         directly. To keep things organized and prevent "odb.{c,h}" from becoming
2:  b009d08f3e = 2:  57ac075560 odb/transaction: use pluggable `begin_transaction()`
-:  ---------- > 3:  556f003d0a odb: update `struct odb_write_stream` read() callback
3:  ceb44a7d25 ! 4:  a9f0e5ad8a object-file: remove flags from transaction packfile writes
    @@ Commit message
         conditional on this flag is a bit awkward.
     
         In preparation for this change, introduce a dedicated
    -    `hash_blob_stream()` helper that only computes the OID from the fd. This
    -    is invoked by `index_fd()` instead when the INDEX_WRITE_OBJECT is not
    -    set. The object write performed via `index_blob_packfile_transaction()`
    -    is made unconditional accordingly.
    +    `hash_blob_stream()` helper that only computes the OID from a `struct
    +    odb_write_stream`. This is invoked by `index_fd()` instead when the
    +    INDEX_WRITE_OBJECT is not set. The object write performed via
    +    `index_blob_packfile_transaction()` is made unconditional accordingly.
     
         Signed-off-by: Justin Tobler <jltobler@gmail.com>
     
    @@ object-file.c: static void prepare_packfile_transaction(struct odb_transaction_f
      		die_errno("unable to write pack header");
      }
      
    -+static int hash_blob_stream(const struct git_hash_algo *hash_algo,
    -+			    struct object_id *result_oid, int fd, size_t size)
    ++static int hash_blob_stream(struct odb_write_stream *stream,
    ++			    const struct git_hash_algo *hash_algo,
    ++			    struct object_id *result_oid, size_t size)
     +{
     +	unsigned char buf[16384];
     +	struct git_hash_ctx ctx;
     +	unsigned header_len;
    ++	size_t total = 0;
     +
     +	header_len = format_object_header((char *)buf, sizeof(buf),
     +					  OBJ_BLOB, size);
     +	hash_algo->init_fn(&ctx);
     +	git_hash_update(&ctx, buf, header_len);
     +
    -+	while (size) {
    -+		size_t rsize = size < sizeof(buf) ? size : sizeof(buf);
    -+		ssize_t read_result = read_in_full(fd, buf, rsize);
    ++	while (!stream->is_finished) {
    ++		ssize_t read_result = stream->read(stream, buf, sizeof(buf));
     +
    -+		if ((size_t)read_result != rsize)
    ++		if (read_result < 0)
     +			return -1;
     +
    -+		git_hash_update(&ctx, buf, rsize);
    -+		size -= read_result;
    ++		git_hash_update(&ctx, buf, read_result);
    ++		total += read_result;
     +	}
     +
    ++	if (total != size)
    ++		return -1;
    ++
     +	git_hash_final_oid(result_oid, &ctx);
     +
     +	return 0;
    @@ object-file.c: static int index_blob_packfile_transaction(struct odb_transaction
      
      	idx->crc32 = crc32_end(state->f);
      	if (already_written(transaction, result_oid)) {
    -@@ object-file.c: int index_fd(struct index_state *istate, struct object_id *oid,
    - 	     int fd, struct stat *st,
    - 	     enum object_type type, const char *path, unsigned flags)
    - {
    --	int ret;
    -+	int ret = 0;
    - 
    - 	/*
    - 	 * Call xsize_t() only when needed to avoid potentially unnecessary
     @@ object-file.c: int index_fd(struct index_state *istate, struct object_id *oid,
      		ret = index_core(istate, oid, fd, xsize_t(st->st_size),
      				 type, path, flags);
    @@ object-file.c: int index_fd(struct index_state *istate, struct object_id *oid,
     -						      xsize_t(st->st_size),
     -						      path, flags);
     -		odb_transaction_commit(transaction);
    ++		struct odb_write_stream stream = { 0 };
    ++		odb_write_stream_from_fd(&stream, fd, xsize_t(st->st_size));
    ++
     +		if (flags & INDEX_WRITE_OBJECT) {
     +			struct object_database *odb = the_repository->objects;
     +			struct odb_transaction_files *files_transaction;
    @@ object-file.c: int index_fd(struct index_state *istate, struct object_id *oid,
     +						      xsize_t(st->st_size), path);
     +			odb_transaction_commit(transaction);
     +		} else {
    -+			if (hash_blob_stream(the_repository->hash_algo, oid, fd,
    -+					     xsize_t(st->st_size)))
    -+				die("failed to hash blob");
    ++			ret = hash_blob_stream(&stream,
    ++					       the_repository->hash_algo, oid,
    ++					       xsize_t(st->st_size));
     +		}
    ++
    ++		free(stream.data);
      	}
      
      	close(fd);
    +
    + ## odb/streaming.c ##
    +@@ odb/streaming.c: int odb_stream_blob_to_fd(struct object_database *odb,
    + 	odb_read_stream_close(st);
    + 	return result;
    + }
    ++
    ++struct read_object_fd_data {
    ++	int fd;
    ++	size_t remaining;
    ++};
    ++
    ++static ssize_t read_object_fd(struct odb_write_stream *stream,
    ++			      unsigned char *buf, size_t len)
    ++{
    ++	struct read_object_fd_data *data = stream->data;
    ++	ssize_t read_result;
    ++	size_t count;
    ++
    ++	if (stream->is_finished)
    ++		return 0;
    ++
    ++	count = data->remaining < len ? data->remaining : len;
    ++	read_result = read_in_full(data->fd, buf, count);
    ++	if (read_result < 0 || (size_t)read_result != count)
    ++		return -1;
    ++
    ++	data->remaining -= count;
    ++	if (!data->remaining)
    ++		stream->is_finished = 1;
    ++
    ++	return read_result;
    ++}
    ++
    ++void odb_write_stream_from_fd(struct odb_write_stream *stream, int fd,
    ++			      size_t size)
    ++{
    ++	struct read_object_fd_data *data;
    ++
    ++	CALLOC_ARRAY(data, 1);
    ++	data->fd = fd;
    ++	data->remaining = size;
    ++
    ++	stream->data = data;
    ++	stream->read = read_object_fd;
    ++}
    +
    + ## odb/streaming.h ##
    +@@
    + #define STREAMING_H 1
    + 
    + #include "object.h"
    ++#include "odb.h"
    + 
    + struct object_database;
    + struct odb_read_stream;
    +@@ odb/streaming.h: int odb_stream_blob_to_fd(struct object_database *odb,
    + 			  struct stream_filter *filter,
    + 			  int can_seek);
    + 
    ++/*
    ++ * Sets up an ODB write stream that reads from an fd. The caller is expected to
    ++ * free the underlying stream data.
    ++ */
    ++void odb_write_stream_from_fd(struct odb_write_stream *stream, int fd,
    ++			      size_t size);
    ++
    + #endif /* STREAMING_H */
4:  8849b805e9 ! 5:  b7ac82ed7e object-file: avoid fd seekback by checking object size upfront
    @@ Commit message
         object-file: avoid fd seekback by checking object size upfront
     
         In certain scenarios, Git handles writing blobs that exceed
    -    "core.bigFilesThreshold" differently by streaming the object directly
    +    "core.bigFileThreshold" differently by streaming the object directly
         into a packfile. When there is an active ODB transaction, these blobs
         are streamed to the same packfile instead of using a separate packfile
         for each. If "pack.packSizeLimit" is configured and streaming another
    @@ Commit message
         because the inflated size of the object is known and can be used to
         approximate whether writing the object would cause the packfile to
         exceed the configured limit prior to writing anything. These blobs
    -    written to the packfile are never deltafied thus the size difference
    +    written to the packfile are never deltified thus the size difference
         between what is written versus the inflated size is due to zlib
         compression. While this does prevent packfiles from being filled to the
         potential maximum is some cases, it should be good enough and still
    @@ Commit message
         Signed-off-by: Justin Tobler <jltobler@gmail.com>
     
      ## object-file.c ##
    -@@ object-file.c: static int hash_blob_stream(const struct git_hash_algo *hash_algo,
    +@@ object-file.c: static int hash_blob_stream(struct odb_write_stream *stream,
      
      /*
       * Read the contents from fd for size bytes, streaming it to the
    @@ object-file.c: static int stream_blob_to_pack(struct transaction_packfile *state
     -				*already_hashed_to = offset;
     -			}
     +
    -+			if (rsize)
    -+				git_hash_update(ctx, ibuf, rsize);
    ++			git_hash_update(ctx, ibuf, rsize);
     +
      			s.next_in = ibuf;
      			s.avail_in = rsize;
    @@ object-file.c: static int index_blob_packfile_transaction(struct odb_transaction
     +	 * If writing another object to the packfile could result in it
     +	 * exceeding the configured size limit, flush the current packfile
     +	 * transaction.
    ++	 *
    ++	 * Note that this uses the inflated object size as an approximation.
    ++	 * Blob objects written in this manner are not delta-compressed, so
    ++	 * the difference between the inflated and on-disk size is limited
    ++	 * to zlib compression and is sufficient for this check.
     +	 */
     +	if (state->nr_written && pack_size_limit_cfg &&
     +	    pack_size_limit_cfg < state->offset + size)
5:  a25e5a2451 ! 6:  d6c4187a0f object-file: generalize packfile writes to use odb_write_stream
    @@ Commit message
         Signed-off-by: Justin Tobler <jltobler@gmail.com>
     
      ## object-file.c ##
    -@@ object-file.c: static int hash_blob_stream(const struct git_hash_algo *hash_algo,
    +@@ object-file.c: static int hash_blob_stream(struct odb_write_stream *stream,
      }
      
      /*
    @@ object-file.c: static int hash_blob_stream(const struct git_hash_algo *hash_algo
     +				struct odb_write_stream *stream)
      {
      	git_zstream s;
    --	unsigned char ibuf[16384];
    + 	unsigned char ibuf[16384];
      	unsigned char obuf[16384];
      	unsigned hdrlen;
      	int status = Z_OK;
    @@ object-file.c: static void stream_blob_to_pack(struct transaction_packfile *stat
     -				die("failed to read %u bytes from '%s'",
     -				    (unsigned)rsize, path);
     +		if (!stream->is_finished && !s.avail_in) {
    -+			unsigned long rsize;
    -+			unsigned const char *buf = stream->read(stream, &rsize);
    ++			ssize_t rsize = stream->read(stream, ibuf, sizeof(ibuf));
    ++
    ++			if (rsize < 0)
    ++				die("failed to read blob data");
      
    - 			if (rsize)
    --				git_hash_update(ctx, ibuf, rsize);
    -+				git_hash_update(ctx, buf, rsize);
    + 			git_hash_update(ctx, ibuf, rsize);
      
    --			s.next_in = ibuf;
    -+			s.next_in = (unsigned char *)buf;
    + 			s.next_in = ibuf;
      			s.avail_in = rsize;
     -			size -= rsize;
     +			total += rsize;
    @@ object-file.c: static void stream_blob_to_pack(struct transaction_packfile *stat
      	}
     +
     +	if (total != size)
    -+		die("unexpected number of bytes read");
    ++		die("read %" PRIuMAX " bytes of blob data, but expected %" PRIuMAX " bytes",
    ++		    (uintmax_t)total, (uintmax_t)size);
     +
      	git_deflate_end(&s);
      }
      
    -@@ object-file.c: static void flush_packfile_transaction(struct odb_transaction_files *transaction
    - 	odb_reprepare(repo->objects);
    - }
    - 
    -+struct read_object_fd_data {
    -+	int fd;
    -+	size_t size;
    -+	unsigned char buf[16384];
    -+};
    -+
    -+static const void *read_object_fd(struct odb_write_stream *stream,
    -+				  unsigned long *len)
    -+{
    -+	struct read_object_fd_data *data = stream->data;
    -+	ssize_t read_result;
    -+	size_t rsize;
    -+
    -+	if (stream->is_finished) {
    -+		*len = 0;
    -+		return NULL;
    -+	}
    -+
    -+	rsize = data->size < sizeof(data->buf) ? data->size : sizeof(data->buf);
    -+	read_result = read_in_full(data->fd, data->buf, rsize);
    -+	if (read_result < 0)
    -+		die_errno("failed to read blob data");
    -+	if ((size_t)read_result != rsize)
    -+		die("failed to read %u bytes of blob data", (unsigned)rsize);
    -+
    -+	data->size -= rsize;
    -+	if (!data->size)
    -+		stream->is_finished = 1;
    -+
    -+	*len = rsize;
    -+
    -+	return data->buf;
    -+}
    -+
    - /*
    -  * This writes the specified object to a packfile. Objects written here
    -  * during the same transaction are written to the same packfile. The
     @@ object-file.c: static void flush_packfile_transaction(struct odb_transaction_files *transaction
       * binary blobs, they generally do not want to get any conversion, and
       * callers should avoid this code path when filters are requested.
    @@ object-file.c: static int index_blob_packfile_transaction(struct odb_transaction
      
      	idx->crc32 = crc32_end(state->f);
     @@ object-file.c: int index_fd(struct index_state *istate, struct object_id *oid,
    - 	} else {
    + 
      		if (flags & INDEX_WRITE_OBJECT) {
      			struct object_database *odb = the_repository->objects;
     -			struct odb_transaction_files *files_transaction;
    @@ object-file.c: int index_fd(struct index_state *istate, struct object_id *oid,
     -			ret = index_blob_packfile_transaction(files_transaction, oid, fd,
     -						      xsize_t(st->st_size), path);
     +			struct odb_transaction *transaction = odb_transaction_begin(odb);
    -+			struct read_object_fd_data data = {
    -+				.fd = fd,
    -+				.size = xsize_t(st->st_size),
    -+			};
    -+			struct odb_write_stream in_stream = {
    -+				.read = read_object_fd,
    -+				.data = &data,
    -+			};
     +
     +			ret = index_blob_packfile_transaction(odb->transaction,
    -+							      &in_stream,
    ++							      &stream,
     +							      xsize_t(st->st_size),
     +							      oid);
      			odb_transaction_commit(transaction);
      		} else {
    - 			if (hash_blob_stream(the_repository->hash_algo, oid, fd,
    + 			ret = hash_blob_stream(&stream,
6:  bbc62ec512 ! 7:  2b81e94677 odb/transaction: make `write_object_stream()` pluggable
    @@ Commit message
         Signed-off-by: Justin Tobler <jltobler@gmail.com>
     
      ## object-file.c ##
    +@@ object-file.c: static void flush_packfile_transaction(struct odb_transaction_files *transaction
    +  * binary blobs, they generally do not want to get any conversion, and
    +  * callers should avoid this code path when filters are requested.
    +  */
    +-static int index_blob_packfile_transaction(struct odb_transaction *base,
    +-					   struct odb_write_stream *stream,
    +-					   size_t size, struct object_id *result_oid)
    ++static int odb_transaction_files_write_object_stream(struct odb_transaction *base,
    ++						     struct odb_write_stream *stream,
    ++						     size_t size,
    ++						     struct object_id *result_oid)
    + {
    + 	struct odb_transaction_files *transaction = container_of(base,
    + 								 struct odb_transaction_files,
     @@ object-file.c: int index_fd(struct index_state *istate, struct object_id *oid,
    - 				.data = &data,
    - 			};
    + 			struct object_database *odb = the_repository->objects;
    + 			struct odb_transaction *transaction = odb_transaction_begin(odb);
      
     -			ret = index_blob_packfile_transaction(odb->transaction,
    --							      &in_stream,
    +-							      &stream,
     -							      xsize_t(st->st_size),
     -							      oid);
     +			ret = odb_transaction_write_object_stream(odb->transaction,
    -+								  &in_stream,
    ++								  &stream,
     +								  xsize_t(st->st_size),
     +								  oid);
      			odb_transaction_commit(transaction);
      		} else {
    - 			if (hash_blob_stream(the_repository->hash_algo, oid, fd,
    + 			ret = hash_blob_stream(&stream,
     @@ object-file.c: struct odb_transaction *odb_transaction_files_begin(struct odb_source *source)
      	transaction = xcalloc(1, sizeof(*transaction));
      	transaction->base.source = source;
      	transaction->base.commit = odb_transaction_files_commit;
    -+	transaction->base.write_object_stream = index_blob_packfile_transaction;
    ++	transaction->base.write_object_stream = odb_transaction_files_write_object_stream;
      
      	return &transaction->base;
      }
    @@ odb/transaction.h
     +
     +	/*
     +	 * This callback is expected to write the given object stream into
    -+	 * the ODB transaction.
    ++	 * the ODB transaction. Note that for now, only blobs support streaming.
     +	 *
     +	 * The resulting object ID shall be written into the out pointer. The
     +	 * callback is expected to return 0 on success, a negative error code

base-commit: 5361983c075154725be47b65cca9a2421789e410
-- 
2.53.0.381.g628a66ccf6

