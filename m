Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4B03B7745
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 21:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775165573; cv=none; b=jwJ93WKN4ATNWEqgq5ta0UYwYHQTooO0Fil0Qqaguz35/279MaYWGQ8DEacBXI1H/8huuxA9tVJJEUReMkjMZJpGL2KfOm058dmwiNKwRdHcYGwAUr9JV04w5yyvGEgWYUez0eU4ADyqK+JVLLXI/2TmQcfTZyy2P1kK7ILtnYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775165573; c=relaxed/simple;
	bh=tpsBDvuGuYBbKDzM/x6gE5yeQWmm9V1M5uSCeqeFmJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N1ltw6EAZeaJPYhxA+JvJ4exJPu1IGyChnyD2Hr+EwIZSMTOD5d4SqlSg9Uz5wX6twSya+YCbdblZ8ERYGRy2jZpv8Kkfx9B1hInjLegCvU23FwHWk+Zu3Ll3Oix2v9SxtXedJfdi0LLvJnYpZHP67cAGkIfWS5TkFJ3UjClQnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=krgPNKJw; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="krgPNKJw"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-40ede943bf0so772807fac.2
        for <git@vger.kernel.org>; Thu, 02 Apr 2026 14:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775165569; x=1775770369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FWHkFenu4JHIbvLfzKtPJ0XpA5jXC70bDQT0vuDttKk=;
        b=krgPNKJwlIXAXyMYOm5GsP7nbfNZOP9qJ5zBTcg2QhD1BHtblpkuSW9CKBQEk/3jIh
         FgD84ILIW1WQfXYCJvt/Jjqrb62+oc2Jc85nph/Rgnmmnj1+OIf9pZ7aTKpt9ClGZoM0
         F7ymXLzeR9UqF4uOGhr5+Eu02n7HuLM98HhdPvqUlLIfJYgkHovVuRWwLBdxCKeFt38M
         iwEMIgRIwCuSsBZwoGciJR0K+AEbQK7kJBDcw/3VespMbmNHNTM4ZotiL2DH8A/G6Ojl
         Pkgb11KsLZjwULut96C4Xji0LsF39WrkHSyJblbK03auVMF39raTma2RejXvkTBuAMdV
         JhQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775165569; x=1775770369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FWHkFenu4JHIbvLfzKtPJ0XpA5jXC70bDQT0vuDttKk=;
        b=Tbm5xaEXrugXgaXlbfWolXvXDPjfYihNqM343roXZ/qwBuL/Q8ePkd504O7zkC7T1C
         GUJmniJP4H60+ClA2Kv3JtVLbFJpf0S94IkVW29ZUN9KjA1hIr5J3ENiLF1i7tE8bqg8
         UHp5DtP/nSv1sg4FDQ2cMjDPeRS3PsGDgh8Pwp4mQLlFKfmoSBsPCtj0TRdaGHGtx+Fc
         xMVsLN1T34tL/QMf4ffJrjzeQMm7VfVjut0a67y4UAhTyCFCXDZW+XqEt+Fuo2j/ku+W
         WJNSXptrd0lsoVdZral8VtjfDWW7riD4MWFkvJ61icg3/GeOeJvKCxQukv6flrDIMtpI
         sOjw==
X-Gm-Message-State: AOJu0YyBK2nzBQA2NyTreWpsS9I3WxVJE8kCz1g6mDIUZJLEQeBAT27l
	hZf5L1LSHT96mF3rPx9bkPAn7WaKq6QE/KAWMJTWH7pyXfn2Y4o5xNVU2oMkiw==
X-Gm-Gg: AeBDievnfLjL6cD3lm7XONApqwiaQEFePM0EqBQmTL96kcWlHW2e0gsWzb5vrmEO21g
	hGkoK6k4GVTJCYMuk5ZzMtjXJR60y72VYDEt0c4DEay6TAAyorHgrCXbqg53kN+v8Yc701akCiM
	ZDXn7UjSzpaUb7LxL3trbEgGV+F2tTfHeCl3/Ed6ek5D5ouYnDA/ShevF3zodoqV9hi+6N3OKr9
	iR324vq3vgAn1CzHAACqX2ZyvyMbVdKGwumoUwXj5KfcDwdakADvD6tNsnj+jWM44fjq9fCOrOf
	RB3bPziy5SvGOHHmjPAJjbMG/CBSwM+1/UMJzdvRF0jKaCSAK+E4QVpW/ObGYC3BlQpacDWEIsW
	pFZLHdYZxs8EQK2dinBYZQgkXi2JmL2XKj0LCrX/i70UceMTmrxP+nULMV6kMCnI6N5kyZ/Mf6q
	1/rF8tgcbAylV4CcVCcec0QkWcABmAtkU=
X-Received: by 2002:a05:6871:799b:b0:409:57ae:54e4 with SMTP id 586e51a60fabf-4230fc10e22mr382016fac.9.1775165568953;
        Thu, 02 Apr 2026 14:32:48 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-422eaf2c780sm3325030fac.6.2026.04.02.14.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 14:32:48 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 0/7] odb: add write operation to ODB transaction interface
Date: Thu,  2 Apr 2026 16:32:13 -0500
Message-ID: <20260402213220.2651523-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.53.0.381.g628a66ccf6
In-Reply-To: <20260401030316.1847362-1-jltobler@gmail.com>
References: <20260401030316.1847362-1-jltobler@gmail.com>
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

Changes since V2:
- Renamed some variables to improve clarity
- Make `odb_write_stream_from_fd()` fully initialize the underlying
  `struct odb_write_stream`
- Move `struct odb_write_stream` to "odb/streaming.h"
- Make the `hash_blob_stream()` helper more generic by operating on a
  `struct odb_write_stream` instead of reading from an fd directly.
- Introduce an `odb_write_stream_release()` helper to free the
  underlying stream data.

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
 builtin/unpack-objects.c |  21 ++--
 builtin/update-index.c   |   1 +
 cache-tree.c             |   1 +
 meson.build              |   1 +
 object-file.c            | 237 ++++++++++++++++++++-------------------
 odb.c                    |  25 -----
 odb.h                    |  37 +-----
 odb/streaming.c          |  51 +++++++++
 odb/streaming.h          |  30 +++++
 odb/transaction.c        |  35 ++++++
 odb/transaction.h        |  57 ++++++++++
 read-cache.c             |   1 +
 14 files changed, 311 insertions(+), 188 deletions(-)
 create mode 100644 odb/transaction.c
 create mode 100644 odb/transaction.h

Range-diff against v2:
1:  eee372b426 = 1:  eee372b426 odb: split `struct odb_transaction` into separate header
2:  57ac075560 = 2:  57ac075560 odb/transaction: use pluggable `begin_transaction()`
3:  556f003d0a ! 3:  11321ad607 odb: update `struct odb_write_stream` read() callback
    @@ Commit message
     
         Update the interface to instead require the caller to provide a buffer,
         and have the callback return the number of bytes written to it or a
    -    negative value on error. Call sites are updated accordingly.
    +    negative value on error. While at it, also move the `struct
    +    odb_write_stream` definition to "odb/streaming.h". Call sites are
    +    updated accordingly.
     
         Signed-off-by: Justin Tobler <jltobler@gmail.com>
     
      ## builtin/unpack-objects.c ##
    +@@
    + #include "hex.h"
    + #include "object-file.h"
    + #include "odb.h"
    ++#include "odb/streaming.h"
    + #include "odb/transaction.h"
    + #include "object.h"
    + #include "delta.h"
     @@ builtin/unpack-objects.c: static void unpack_non_delta_entry(enum object_type type, unsigned long size,
      
      struct input_zstream_data {
    @@ object-file.c: int odb_source_loose_write_stream(struct odb_source *source,
     -			const void *in = in_stream->read(in_stream, &stream.avail_in);
     -			stream.next_in = (void *)in;
     -			in0 = (unsigned char *)in;
    -+			ssize_t read_len = in_stream->read(in_stream, buf, sizeof(buf));
    ++			ssize_t read_len = odb_write_stream_read(in_stream, buf,
    ++								 sizeof(buf));
     +			if (read_len < 0) {
     +				err = -1;
     +				goto cleanup;
    @@ object-file.c: int odb_source_loose_write_stream(struct odb_source *source,
     
      ## odb.h ##
     @@ odb.h: static inline int odb_write_object(struct object_database *odb,
    + 	return odb_write_object_ext(odb, buf, len, type, oid, NULL, 0);
      }
      
    - struct odb_write_stream {
    +-struct odb_write_stream {
     -	const void *(*read)(struct odb_write_stream *, unsigned long *len);
    -+	ssize_t (*read)(struct odb_write_stream *, unsigned char *, size_t len);
    - 	void *data;
    - 	int is_finished;
    - };
    +-	void *data;
    +-	int is_finished;
    +-};
    ++struct odb_write_stream;
    + 
    + int odb_write_object_stream(struct object_database *odb,
    + 			    struct odb_write_stream *stream, size_t len,
    +
    + ## odb/streaming.c ##
    +@@ odb/streaming.c: struct odb_read_stream *odb_read_stream_open(struct object_database *odb,
    + 	return st;
    + }
    + 
    ++ssize_t odb_write_stream_read(struct odb_write_stream *st, void *buf, size_t sz)
    ++{
    ++	return st->read(st, buf, sz);
    ++}
    ++
    + int odb_stream_blob_to_fd(struct object_database *odb,
    + 			  int fd,
    + 			  const struct object_id *oid,
    +
    + ## odb/streaming.h ##
    +@@ odb/streaming.h: int odb_read_stream_close(struct odb_read_stream *stream);
    +  */
    + ssize_t odb_read_stream_read(struct odb_read_stream *stream, void *buf, size_t len);
    + 
    ++/*
    ++ * A stream that provides an object to be written to the object database without
    ++ * loading all of it into memory.
    ++ */
    ++struct odb_write_stream {
    ++	ssize_t (*read)(struct odb_write_stream *, unsigned char *, size_t);
    ++	void *data;
    ++	int is_finished;
    ++};
    ++
    ++/*
    ++ * Read data from the stream into the buffer. Returns 0 when finished and the
    ++ * number of bytes read on success. Returns a negative error code in case
    ++ * reading from the stream fails.
    ++ */
    ++ssize_t odb_write_stream_read(struct odb_write_stream *stream, void *buf,
    ++			      size_t len);
    ++
    + /*
    +  * Look up the object by its ID and write the full contents to the file
    +  * descriptor. The object must be a blob, or the function will fail. When
4:  a9f0e5ad8a ! 4:  72d4656eee object-file: remove flags from transaction packfile writes
    @@ object-file.c: static void prepare_packfile_transaction(struct odb_transaction_f
     +	unsigned char buf[16384];
     +	struct git_hash_ctx ctx;
     +	unsigned header_len;
    -+	size_t total = 0;
    ++	size_t bytes_hashed = 0;
     +
     +	header_len = format_object_header((char *)buf, sizeof(buf),
     +					  OBJ_BLOB, size);
    @@ object-file.c: static void prepare_packfile_transaction(struct odb_transaction_f
     +	git_hash_update(&ctx, buf, header_len);
     +
     +	while (!stream->is_finished) {
    -+		ssize_t read_result = stream->read(stream, buf, sizeof(buf));
    ++		ssize_t read_result = odb_write_stream_read(stream, buf,
    ++							    sizeof(buf));
     +
     +		if (read_result < 0)
     +			return -1;
     +
     +		git_hash_update(&ctx, buf, read_result);
    -+		total += read_result;
    ++		bytes_hashed += read_result;
     +	}
     +
    -+	if (total != size)
    ++	if (bytes_hashed != size)
     +		return -1;
     +
     +	git_hash_final_oid(result_oid, &ctx);
    @@ object-file.c: int index_fd(struct index_state *istate, struct object_id *oid,
     -						      xsize_t(st->st_size),
     -						      path, flags);
     -		odb_transaction_commit(transaction);
    -+		struct odb_write_stream stream = { 0 };
    ++		struct odb_write_stream stream;
     +		odb_write_stream_from_fd(&stream, fd, xsize_t(st->st_size));
     +
     +		if (flags & INDEX_WRITE_OBJECT) {
    @@ object-file.c: int index_fd(struct index_state *istate, struct object_id *oid,
     +					       xsize_t(st->st_size));
     +		}
     +
    -+		free(stream.data);
    ++		odb_write_stream_release(&stream);
      	}
      
      	close(fd);
     
      ## odb/streaming.c ##
    +@@ odb/streaming.c: ssize_t odb_write_stream_read(struct odb_write_stream *st, void *buf, size_t sz)
    + 	return st->read(st, buf, sz);
    + }
    + 
    ++void odb_write_stream_release(struct odb_write_stream *st)
    ++{
    ++	free(st->data);
    ++}
    ++
    + int odb_stream_blob_to_fd(struct object_database *odb,
    + 			  int fd,
    + 			  const struct object_id *oid,
     @@ odb/streaming.c: int odb_stream_blob_to_fd(struct object_database *odb,
      	odb_read_stream_close(st);
      	return result;
    @@ odb/streaming.c: int odb_stream_blob_to_fd(struct object_database *odb,
     +
     +	stream->data = data;
     +	stream->read = read_object_fd;
    ++	stream->is_finished = 0;
     +}
     
      ## odb/streaming.h ##
    @@ odb/streaming.h
      
      struct object_database;
      struct odb_read_stream;
    +@@ odb/streaming.h: struct odb_write_stream {
    + ssize_t odb_write_stream_read(struct odb_write_stream *stream, void *buf,
    + 			      size_t len);
    + 
    ++/*
    ++ * Releases memory allocated for underlying stream data.
    ++ */
    ++void odb_write_stream_release(struct odb_write_stream *stream);
    ++
    + /*
    +  * Look up the object by its ID and write the full contents to the file
    +  * descriptor. The object must be a blob, or the function will fail. When
     @@ odb/streaming.h: int odb_stream_blob_to_fd(struct object_database *odb,
      			  struct stream_filter *filter,
      			  int can_seek);
      
     +/*
    -+ * Sets up an ODB write stream that reads from an fd. The caller is expected to
    -+ * free the underlying stream data.
    ++ * Sets up an ODB write stream that reads from an fd.
     + */
     +void odb_write_stream_from_fd(struct odb_write_stream *stream, int fd,
     +			      size_t size);
5:  b7ac82ed7e = 5:  e4896101ff object-file: avoid fd seekback by checking object size upfront
6:  d6c4187a0f ! 6:  b3cb0a707c object-file: generalize packfile writes to use odb_write_stream
    @@ object-file.c: static int hash_blob_stream(struct odb_write_stream *stream,
      	unsigned char obuf[16384];
      	unsigned hdrlen;
      	int status = Z_OK;
    -+	size_t total = 0;
    ++	size_t bytes_read = 0;
      
      	git_deflate_init(&s, pack_compression_level);
      
    @@ object-file.c: static void stream_blob_to_pack(struct transaction_packfile *stat
     -				die("failed to read %u bytes from '%s'",
     -				    (unsigned)rsize, path);
     +		if (!stream->is_finished && !s.avail_in) {
    -+			ssize_t rsize = stream->read(stream, ibuf, sizeof(ibuf));
    ++			ssize_t rsize = odb_write_stream_read(stream, ibuf,
    ++							      sizeof(ibuf));
     +
     +			if (rsize < 0)
     +				die("failed to read blob data");
    @@ object-file.c: static void stream_blob_to_pack(struct transaction_packfile *stat
      			s.next_in = ibuf;
      			s.avail_in = rsize;
     -			size -= rsize;
    -+			total += rsize;
    ++			bytes_read += rsize;
      		}
      
     -		status = git_deflate(&s, size ? 0 : Z_FINISH);
    @@ object-file.c: static void stream_blob_to_pack(struct transaction_packfile *stat
      		}
      	}
     +
    -+	if (total != size)
    ++	if (bytes_read != size)
     +		die("read %" PRIuMAX " bytes of blob data, but expected %" PRIuMAX " bytes",
    -+		    (uintmax_t)total, (uintmax_t)size);
    ++		    (uintmax_t)bytes_read, (uintmax_t)size);
     +
      	git_deflate_end(&s);
      }
7:  2b81e94677 ! 7:  e1d292a7ed odb/transaction: make `write_object_stream()` pluggable
    @@ Commit message
         How an ODB transaction handles writing objects is expected to vary
         between implementations. Introduce a new `write_object_stream()`
         callback in `struct odb_transaction` to make this function pluggable.
    -    Wire up `index_blob_packfile_transaction()` for use with `struct
    -    odb_transaction_files` accordingly.
    +    Rename `index_blob_packfile_transaction()` to
    +    `odb_transaction_files_write_object_stream()` and wire it up for use
    +    with `struct odb_transaction_files` accordingly.
     
         Signed-off-by: Justin Tobler <jltobler@gmail.com>
     

base-commit: 5361983c075154725be47b65cca9a2421789e410
-- 
2.53.0.381.g628a66ccf6

