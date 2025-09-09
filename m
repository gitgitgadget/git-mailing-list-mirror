Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3055E3570D1
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 19:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757445114; cv=none; b=lDGVn0OQeuLo1MaPPJ4Xxa77CqPzmandob5Eskejd6zvS5ws5eNBpjpHf3QZ9MLFxGBjNSXlk3XQz36qrO6N8h6WUqlZwuPOBp/R3M0N1S8r14C8LJT99wR1/LTz2Ppgk8Sdxnj5rbnmjysOJB/UYdrrkoL/xvcfDSLJFkswrmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757445114; c=relaxed/simple;
	bh=D9LSRicg3abBReaTWpmFaOdsW8Sc8XnGn/qdl6NHkGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JFKHs54wVMtN8fn0mp9M2uQJoKK8t9COeNIGREOcY0ld3XiMjVBNlaEtfXcF7rchnzAlu7/62TGz96S5OS3ubLZZY8Rqk4WYjh/5nA6tjfh25voVeT/7/Qp7ImZLzhzVCBM/iplIfTbaa8abGfaP6veq2RaIwr0TotKbDJqavoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nOFsD1Re; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nOFsD1Re"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-746da717f35so2544042a34.1
        for <git@vger.kernel.org>; Tue, 09 Sep 2025 12:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757445110; x=1758049910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HpHeeLxv7EVHyLRc83RmjvU3jKtF1xiKNRfm6lCRvIQ=;
        b=nOFsD1Rel4ZLJxjsHWAkR9UKNXuutNQ30lpUc/+kDolkWUpeLUhJo7R24I5MzcwEJ6
         vk1ysLoWilEi6R/BiMyrT1l+Tq8B+1UzIqCMnj7gHUe0Goo2BZ0y3aIM/BGlcQ5+fgyY
         AFODCGtVAWOsOrj7bWqn3IfAgcSLpGtxNDUj7BQPbWufgDL/LCOZ7XZktaz6mhks4ULz
         HzPKhGYPL7jna9UNfPOPJ0a+5SEe6oNFHGiffBxwNjWch3Ko1QoJT4MFodq9j7XHObla
         ++sW52iV0NnspC4BZmP85D9BoyCv0LH3F+s6cCPHw10m1nLS4eRQFu4leT5dFdHM0Ozr
         PC0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757445110; x=1758049910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HpHeeLxv7EVHyLRc83RmjvU3jKtF1xiKNRfm6lCRvIQ=;
        b=IluQZuv8PG4NY9uiPI8cFnB3Rt/UDfvF1akFqFEA4W6fgm5VKc0/MzF6+8rW/s6d/x
         uMbw3uVIzRl3PQlRmGslXCYN1WiWf9gY0lW11j3SpTpY4pT5aoAKuGXkDSNAUuDHHJxc
         tIa0unRihyD8DoewCcMyc6X7uw8+jPCmzg6072EhJkaanMSCZ37vFiKvMPkjJeAwMtEA
         V+GjvqoCehhbNCLseKtUJjgLxX1Q3awcDCVDDIQS4wwqnJ3ssN1ckXvw4TXLB+2s++Hq
         Y3yvIbGmy11lU8YG3QvS8j6GeVO+eVH65OouFYaXIxj/RstnxHeQ+v2cEWrcdDBi1sCU
         /Q3A==
X-Gm-Message-State: AOJu0YyXoVWRMCypePCHogP+VwjE+00ZQWMiJtz3sZI8v5+WjNK3xeSp
	w26bJq1DxvpMhBkyv3/EV5xTH7AxlqVnLqnI//zErPQd+zzFoYEhK2d6Cff96A==
X-Gm-Gg: ASbGncvtnfO/3/7jfE5DjAvHg2B5nM1jc88FQJxZj7aZZXdxw3U8Ydvb73tVBYawm/1
	377v3dx6fAK8SGfEsWGyjImgn+lWfKEDDqP6t5g7iI0ljcmMojzfdK52G+x5gZVJzWF2mghUYXB
	DH30ONSHGRE3EGaQmhGa6rORYUHDsuuYs6beTN/NR/39rVWhSidhaeIaX6TIm9E3ICGyEkjnoYZ
	EqDNgfNPKl2q8QFXd2T/CkCzTupGAOZUH7gGixKJAvrL4JvassE7xx+a1lCSj5nQ/6bCR6699yR
	esV5e9SIr9QZJ40szGgL7EgGfsF839f+zuuBUYsLzHGcM3pCKX7qInqNhjolpgegF5mm4BmgVJP
	8uu38EyR13ACfeDyWlD0Z23G7tJZ2bEo3u99hwYiQJQ==
X-Google-Smtp-Source: AGHT+IE5okePCe44WJUDxH0vEUMVFs3T7Rj2tSPOYo8qxQPNAA/Nr/qikymkbycVC0A+MjnJA4rBMw==
X-Received: by 2002:a05:6830:700a:b0:746:d3f0:e948 with SMTP id 46e09a7af769-74c772aec2amr5816726a34.30.1757445109595;
        Tue, 09 Sep 2025 12:11:49 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-74cc5a69b95sm3062627a34.39.2025.09.09.12.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 12:11:49 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 4/6] object-file: relocate ODB transaction code
Date: Tue,  9 Sep 2025 14:11:32 -0500
Message-ID: <20250909191134.555689-5-jltobler@gmail.com>
X-Mailer: git-send-email 2.51.0.193.g4975ec3473b
In-Reply-To: <20250909191134.555689-1-jltobler@gmail.com>
References: <20250909191134.555689-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bulk-checkin subsystem provides various functions to manage ODB
transactions. Apart from {begin,end}_odb_transaction(), these functions
are only used by the object-file subsystem to manage aspects of a
transaction implementation specific to the files object source.

Relocate all the transaction code in in bulk-checkin to object-file.
This simplifies the exposed transaction interface by reducing it to only
{begin,end}_odb_transaction(). Function and type names are adjusted in
the subsequent commit to better fit the new location.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 Makefile                 |   1 -
 builtin/add.c            |   2 +-
 builtin/unpack-objects.c |   1 -
 builtin/update-index.c   |   1 -
 bulk-checkin.c           | 385 --------------------------------------
 bulk-checkin.h           |  53 ------
 cache-tree.c             |   1 -
 meson.build              |   1 -
 object-file.c            | 386 ++++++++++++++++++++++++++++++++++++++-
 object-file.h            |  17 ++
 read-cache.c             |   1 -
 11 files changed, 403 insertions(+), 446 deletions(-)
 delete mode 100644 bulk-checkin.c
 delete mode 100644 bulk-checkin.h

diff --git a/Makefile b/Makefile
index 4c95affadb5..d25d4255f8a 100644
--- a/Makefile
+++ b/Makefile
@@ -974,7 +974,6 @@ LIB_OBJS += blame.o
 LIB_OBJS += blob.o
 LIB_OBJS += bloom.o
 LIB_OBJS += branch.o
-LIB_OBJS += bulk-checkin.o
 LIB_OBJS += bundle-uri.o
 LIB_OBJS += bundle.o
 LIB_OBJS += cache-tree.o
diff --git a/builtin/add.c b/builtin/add.c
index 740c7c45817..8294366d68a 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -14,13 +14,13 @@
 #include "gettext.h"
 #include "pathspec.h"
 #include "run-command.h"
+#include "object-file.h"
 #include "parse-options.h"
 #include "path.h"
 #include "preload-index.h"
 #include "diff.h"
 #include "read-cache.h"
 #include "revision.h"
-#include "bulk-checkin.h"
 #include "strvec.h"
 #include "submodule.h"
 #include "add-interactive.h"
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 28124b324d2..4596fff0dad 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -2,7 +2,6 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "builtin.h"
-#include "bulk-checkin.h"
 #include "config.h"
 #include "environment.h"
 #include "gettext.h"
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 0129b14f447..632f2c9b6d9 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -8,7 +8,6 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "builtin.h"
-#include "bulk-checkin.h"
 #include "config.h"
 #include "environment.h"
 #include "gettext.h"
diff --git a/bulk-checkin.c b/bulk-checkin.c
deleted file mode 100644
index 6f0343feda3..00000000000
--- a/bulk-checkin.c
+++ /dev/null
@@ -1,385 +0,0 @@
-/*
- * Copyright (c) 2011, Google Inc.
- */
-
-#define USE_THE_REPOSITORY_VARIABLE
-
-#include "git-compat-util.h"
-#include "bulk-checkin.h"
-#include "environment.h"
-#include "gettext.h"
-#include "hex.h"
-#include "lockfile.h"
-#include "repository.h"
-#include "csum-file.h"
-#include "pack.h"
-#include "strbuf.h"
-#include "tmp-objdir.h"
-#include "packfile.h"
-#include "object-file.h"
-#include "odb.h"
-
-struct bulk_checkin_packfile {
-	char *pack_tmp_name;
-	struct hashfile *f;
-	off_t offset;
-	struct pack_idx_option pack_idx_opts;
-
-	struct pack_idx_entry **written;
-	uint32_t alloc_written;
-	uint32_t nr_written;
-};
-
-struct odb_transaction {
-	struct object_database *odb;
-
-	struct tmp_objdir *objdir;
-	struct bulk_checkin_packfile packfile;
-};
-
-static void finish_tmp_packfile(struct odb_transaction *transaction,
-				struct strbuf *basename,
-				unsigned char hash[])
-{
-	struct bulk_checkin_packfile *state = &transaction->packfile;
-	struct repository *repo = transaction->odb->repo;
-	char *idx_tmp_name = NULL;
-
-	stage_tmp_packfiles(repo, basename, state->pack_tmp_name,
-			    state->written, state->nr_written, NULL,
-			    &state->pack_idx_opts, hash, &idx_tmp_name);
-	rename_tmp_packfile_idx(repo, basename, &idx_tmp_name);
-
-	free(idx_tmp_name);
-}
-
-static void flush_bulk_checkin_packfile(struct odb_transaction *transaction)
-{
-	struct bulk_checkin_packfile *state = &transaction->packfile;
-	struct repository *repo = transaction->odb->repo;
-	unsigned char hash[GIT_MAX_RAWSZ];
-	struct strbuf packname = STRBUF_INIT;
-
-	if (!state->f)
-		return;
-
-	if (state->nr_written == 0) {
-		close(state->f->fd);
-		free_hashfile(state->f);
-		unlink(state->pack_tmp_name);
-		goto clear_exit;
-	} else if (state->nr_written == 1) {
-		finalize_hashfile(state->f, hash, FSYNC_COMPONENT_PACK,
-				  CSUM_HASH_IN_STREAM | CSUM_FSYNC | CSUM_CLOSE);
-	} else {
-		int fd = finalize_hashfile(state->f, hash, FSYNC_COMPONENT_PACK, 0);
-		fixup_pack_header_footer(repo->hash_algo, fd, hash, state->pack_tmp_name,
-					 state->nr_written, hash,
-					 state->offset);
-		close(fd);
-	}
-
-	strbuf_addf(&packname, "%s/pack/pack-%s.",
-		    repo_get_object_directory(transaction->odb->repo),
-		    hash_to_hex_algop(hash, repo->hash_algo));
-
-	finish_tmp_packfile(transaction, &packname, hash);
-	for (uint32_t i = 0; i < state->nr_written; i++)
-		free(state->written[i]);
-
-clear_exit:
-	free(state->pack_tmp_name);
-	free(state->written);
-	memset(state, 0, sizeof(*state));
-
-	strbuf_release(&packname);
-	/* Make objects we just wrote available to ourselves */
-	reprepare_packed_git(repo);
-}
-
-/*
- * Cleanup after batch-mode fsync_object_files.
- */
-static void flush_batch_fsync(struct odb_transaction *transaction)
-{
-	struct strbuf temp_path = STRBUF_INIT;
-	struct tempfile *temp;
-
-	if (!transaction->objdir)
-		return;
-
-	/*
-	 * Issue a full hardware flush against a temporary file to ensure
-	 * that all objects are durable before any renames occur. The code in
-	 * fsync_loose_object_bulk_checkin has already issued a writeout
-	 * request, but it has not flushed any writeback cache in the storage
-	 * hardware or any filesystem logs. This fsync call acts as a barrier
-	 * to ensure that the data in each new object file is durable before
-	 * the final name is visible.
-	 */
-	strbuf_addf(&temp_path, "%s/bulk_fsync_XXXXXX",
-		    repo_get_object_directory(transaction->odb->repo));
-	temp = xmks_tempfile(temp_path.buf);
-	fsync_or_die(get_tempfile_fd(temp), get_tempfile_path(temp));
-	delete_tempfile(&temp);
-	strbuf_release(&temp_path);
-
-	/*
-	 * Make the object files visible in the primary ODB after their data is
-	 * fully durable.
-	 */
-	tmp_objdir_migrate(transaction->objdir);
-	transaction->objdir = NULL;
-}
-
-static int already_written(struct odb_transaction *transaction,
-			   struct object_id *oid)
-{
-	/* The object may already exist in the repository */
-	if (odb_has_object(transaction->odb, oid,
-			   HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))
-		return 1;
-
-	/* Might want to keep the list sorted */
-	for (uint32_t i = 0; i < transaction->packfile.nr_written; i++)
-		if (oideq(&transaction->packfile.written[i]->oid, oid))
-			return 1;
-
-	/* This is a new object we need to keep */
-	return 0;
-}
-
-/*
- * Read the contents from fd for size bytes, streaming it to the
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
- */
-static int stream_blob_to_pack(struct bulk_checkin_packfile *state,
-			       struct git_hash_ctx *ctx, off_t *already_hashed_to,
-			       int fd, size_t size, const char *path,
-			       unsigned flags)
-{
-	git_zstream s;
-	unsigned char ibuf[16384];
-	unsigned char obuf[16384];
-	unsigned hdrlen;
-	int status = Z_OK;
-	int write_object = (flags & INDEX_WRITE_OBJECT);
-	off_t offset = 0;
-
-	git_deflate_init(&s, pack_compression_level);
-
-	hdrlen = encode_in_pack_object_header(obuf, sizeof(obuf), OBJ_BLOB, size);
-	s.next_out = obuf + hdrlen;
-	s.avail_out = sizeof(obuf) - hdrlen;
-
-	while (status != Z_STREAM_END) {
-		if (size && !s.avail_in) {
-			size_t rsize = size < sizeof(ibuf) ? size : sizeof(ibuf);
-			ssize_t read_result = read_in_full(fd, ibuf, rsize);
-			if (read_result < 0)
-				die_errno("failed to read from '%s'", path);
-			if ((size_t)read_result != rsize)
-				die("failed to read %u bytes from '%s'",
-				    (unsigned)rsize, path);
-			offset += rsize;
-			if (*already_hashed_to < offset) {
-				size_t hsize = offset - *already_hashed_to;
-				if (rsize < hsize)
-					hsize = rsize;
-				if (hsize)
-					git_hash_update(ctx, ibuf, hsize);
-				*already_hashed_to = offset;
-			}
-			s.next_in = ibuf;
-			s.avail_in = rsize;
-			size -= rsize;
-		}
-
-		status = git_deflate(&s, size ? 0 : Z_FINISH);
-
-		if (!s.avail_out || status == Z_STREAM_END) {
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
-			}
-			s.next_out = obuf;
-			s.avail_out = sizeof(obuf);
-		}
-
-		switch (status) {
-		case Z_OK:
-		case Z_BUF_ERROR:
-		case Z_STREAM_END:
-			continue;
-		default:
-			die("unexpected deflate failure: %d", status);
-		}
-	}
-	git_deflate_end(&s);
-	return 0;
-}
-
-/* Lazily create backing packfile for the state */
-static void prepare_to_stream(struct odb_transaction *transaction,
-			      unsigned flags)
-{
-	struct bulk_checkin_packfile *state = &transaction->packfile;
-	if (!(flags & INDEX_WRITE_OBJECT) || state->f)
-		return;
-
-	state->f = create_tmp_packfile(transaction->odb->repo,
-				       &state->pack_tmp_name);
-	reset_pack_idx_option(&state->pack_idx_opts);
-
-	/* Pretend we are going to write only one object */
-	state->offset = write_pack_header(state->f, 1);
-	if (!state->offset)
-		die_errno("unable to write pack header");
-}
-
-int index_blob_bulk_checkin(struct odb_transaction *transaction,
-			    struct object_id *result_oid, int fd, size_t size,
-			    const char *path, unsigned flags)
-{
-	struct bulk_checkin_packfile *state = &transaction->packfile;
-	off_t seekback, already_hashed_to;
-	struct git_hash_ctx ctx;
-	unsigned char obuf[16384];
-	unsigned header_len;
-	struct hashfile_checkpoint checkpoint;
-	struct pack_idx_entry *idx = NULL;
-
-	seekback = lseek(fd, 0, SEEK_CUR);
-	if (seekback == (off_t) -1)
-		return error("cannot find the current offset");
-
-	header_len = format_object_header((char *)obuf, sizeof(obuf),
-					  OBJ_BLOB, size);
-	transaction->odb->repo->hash_algo->init_fn(&ctx);
-	git_hash_update(&ctx, obuf, header_len);
-
-	/* Note: idx is non-NULL when we are writing */
-	if ((flags & INDEX_WRITE_OBJECT) != 0) {
-		CALLOC_ARRAY(idx, 1);
-
-		prepare_to_stream(transaction, flags);
-		hashfile_checkpoint_init(state->f, &checkpoint);
-	}
-
-	already_hashed_to = 0;
-
-	while (1) {
-		prepare_to_stream(transaction, flags);
-		if (idx) {
-			hashfile_checkpoint(state->f, &checkpoint);
-			idx->offset = state->offset;
-			crc32_begin(state->f);
-		}
-		if (!stream_blob_to_pack(state, &ctx, &already_hashed_to,
-					 fd, size, path, flags))
-			break;
-		/*
-		 * Writing this object to the current pack will make
-		 * it too big; we need to truncate it, start a new
-		 * pack, and write into it.
-		 */
-		if (!idx)
-			BUG("should not happen");
-		hashfile_truncate(state->f, &checkpoint);
-		state->offset = checkpoint.offset;
-		flush_bulk_checkin_packfile(transaction);
-		if (lseek(fd, seekback, SEEK_SET) == (off_t) -1)
-			return error("cannot seek back");
-	}
-	git_hash_final_oid(result_oid, &ctx);
-	if (!idx)
-		return 0;
-
-	idx->crc32 = crc32_end(state->f);
-	if (already_written(transaction, result_oid)) {
-		hashfile_truncate(state->f, &checkpoint);
-		state->offset = checkpoint.offset;
-		free(idx);
-	} else {
-		oidcpy(&idx->oid, result_oid);
-		ALLOC_GROW(state->written,
-			   state->nr_written + 1,
-			   state->alloc_written);
-		state->written[state->nr_written++] = idx;
-	}
-	return 0;
-}
-
-void prepare_loose_object_bulk_checkin(struct odb_transaction *transaction)
-{
-	/*
-	 * We lazily create the temporary object directory
-	 * the first time an object might be added, since
-	 * callers may not know whether any objects will be
-	 * added at the time they call begin_odb_transaction.
-	 */
-	if (!transaction || transaction->objdir)
-		return;
-
-	transaction->objdir = tmp_objdir_create(transaction->odb->repo, "bulk-fsync");
-	if (transaction->objdir)
-		tmp_objdir_replace_primary_odb(transaction->objdir, 0);
-}
-
-void fsync_loose_object_bulk_checkin(struct odb_transaction *transaction,
-				     int fd, const char *filename)
-{
-	/*
-	 * If we have an active ODB transaction, we issue a call that
-	 * cleans the filesystem page cache but avoids a hardware flush
-	 * command. Later on we will issue a single hardware flush
-	 * before renaming the objects to their final names as part of
-	 * flush_batch_fsync.
-	 */
-	if (!transaction || !transaction->objdir ||
-	    git_fsync(fd, FSYNC_WRITEOUT_ONLY) < 0) {
-		if (errno == ENOSYS)
-			warning(_("core.fsyncMethod = batch is unsupported on this platform"));
-		fsync_or_die(fd, filename);
-	}
-}
-
-struct odb_transaction *begin_odb_transaction(struct object_database *odb)
-{
-	if (odb->transaction)
-		BUG("ODB transaction already started");
-
-	CALLOC_ARRAY(odb->transaction, 1);
-	odb->transaction->odb = odb;
-
-	return odb->transaction;
-}
-
-void end_odb_transaction(struct odb_transaction *transaction)
-{
-	flush_batch_fsync(transaction);
-	flush_bulk_checkin_packfile(transaction);
-	transaction->odb->transaction = NULL;
-	free(transaction);
-}
diff --git a/bulk-checkin.h b/bulk-checkin.h
deleted file mode 100644
index 35e05640828..00000000000
--- a/bulk-checkin.h
+++ /dev/null
@@ -1,53 +0,0 @@
-/*
- * Copyright (c) 2011, Google Inc.
- */
-#ifndef BULK_CHECKIN_H
-#define BULK_CHECKIN_H
-
-#include "object.h"
-#include "odb.h"
-
-struct odb_transaction;
-
-void prepare_loose_object_bulk_checkin(struct odb_transaction *transaction);
-void fsync_loose_object_bulk_checkin(struct odb_transaction *transaction,
-				     int fd, const char *filename);
-
-/*
- * This writes the specified object to a packfile. Objects written here
- * during the same transaction are written to the same packfile. The
- * packfile is not flushed until the transaction is flushed. The caller
- * is expected to ensure a valid transaction is setup for objects to be
- * recorded to.
- *
- * This also bypasses the usual "convert-to-git" dance, and that is on
- * purpose. We could write a streaming version of the converting
- * functions and insert that before feeding the data to fast-import
- * (or equivalent in-core API described above). However, that is
- * somewhat complicated, as we do not know the size of the filter
- * result, which we need to know beforehand when writing a git object.
- * Since the primary motivation for trying to stream from the working
- * tree file and to avoid mmaping it in core is to deal with large
- * binary blobs, they generally do not want to get any conversion, and
- * callers should avoid this code path when filters are requested.
- */
-int index_blob_bulk_checkin(struct odb_transaction *transaction,
-			    struct object_id *oid, int fd, size_t size,
-			    const char *path, unsigned flags);
-
-/*
- * Tell the object database to optimize for adding
- * multiple objects. end_odb_transaction must be called
- * to make new objects visible. Only a single transaction
- * can be pending at a time and must be ended before
- * beginning another.
- */
-struct odb_transaction *begin_odb_transaction(struct object_database *odb);
-
-/*
- * Tell the object database to make any objects from the
- * current transaction visible.
- */
-void end_odb_transaction(struct odb_transaction *transaction);
-
-#endif
diff --git a/cache-tree.c b/cache-tree.c
index 5041639f99f..cc4008e7d61 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -8,7 +8,6 @@
 #include "tree.h"
 #include "tree-walk.h"
 #include "cache-tree.h"
-#include "bulk-checkin.h"
 #include "object-file.h"
 #include "odb.h"
 #include "read-cache-ll.h"
diff --git a/meson.build b/meson.build
index b3dfcc04972..fccb6d2eeca 100644
--- a/meson.build
+++ b/meson.build
@@ -287,7 +287,6 @@ libgit_sources = [
   'blob.c',
   'bloom.c',
   'branch.c',
-  'bulk-checkin.c',
   'bundle-uri.c',
   'bundle.c',
   'cache-tree.c',
diff --git a/object-file.c b/object-file.c
index 45f17a53a98..2ef94d9d1f1 100644
--- a/object-file.c
+++ b/object-file.c
@@ -10,7 +10,6 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "git-compat-util.h"
-#include "bulk-checkin.h"
 #include "convert.h"
 #include "dir.h"
 #include "environment.h"
@@ -28,6 +27,8 @@
 #include "read-cache-ll.h"
 #include "setup.h"
 #include "streaming.h"
+#include "tempfile.h"
+#include "tmp-objdir.h"
 
 /* The maximum size for an object header. */
 #define MAX_HEADER_LEN 32
@@ -666,6 +667,93 @@ void hash_object_file(const struct git_hash_algo *algo, const void *buf,
 	write_object_file_prepare(algo, buf, len, type, oid, hdr, &hdrlen);
 }
 
+struct bulk_checkin_packfile {
+	char *pack_tmp_name;
+	struct hashfile *f;
+	off_t offset;
+	struct pack_idx_option pack_idx_opts;
+
+	struct pack_idx_entry **written;
+	uint32_t alloc_written;
+	uint32_t nr_written;
+};
+
+struct odb_transaction {
+	struct object_database *odb;
+
+	struct tmp_objdir *objdir;
+	struct bulk_checkin_packfile packfile;
+};
+
+static void prepare_loose_object_bulk_checkin(struct odb_transaction *transaction)
+{
+	/*
+	 * We lazily create the temporary object directory
+	 * the first time an object might be added, since
+	 * callers may not know whether any objects will be
+	 * added at the time they call begin_odb_transaction.
+	 */
+	if (!transaction || transaction->objdir)
+		return;
+
+	transaction->objdir = tmp_objdir_create(transaction->odb->repo, "bulk-fsync");
+	if (transaction->objdir)
+		tmp_objdir_replace_primary_odb(transaction->objdir, 0);
+}
+
+static void fsync_loose_object_bulk_checkin(struct odb_transaction *transaction,
+					   int fd, const char *filename)
+{
+	/*
+	 * If we have an active ODB transaction, we issue a call that
+	 * cleans the filesystem page cache but avoids a hardware flush
+	 * command. Later on we will issue a single hardware flush
+	 * before renaming the objects to their final names as part of
+	 * flush_batch_fsync.
+	 */
+	if (!transaction || !transaction->objdir ||
+	    git_fsync(fd, FSYNC_WRITEOUT_ONLY) < 0) {
+		if (errno == ENOSYS)
+			warning(_("core.fsyncMethod = batch is unsupported on this platform"));
+		fsync_or_die(fd, filename);
+	}
+}
+
+/*
+ * Cleanup after batch-mode fsync_object_files.
+ */
+static void flush_batch_fsync(struct odb_transaction *transaction)
+{
+	struct strbuf temp_path = STRBUF_INIT;
+	struct tempfile *temp;
+
+	if (!transaction->objdir)
+		return;
+
+	/*
+	 * Issue a full hardware flush against a temporary file to ensure
+	 * that all objects are durable before any renames occur. The code in
+	 * fsync_loose_object_bulk_checkin has already issued a writeout
+	 * request, but it has not flushed any writeback cache in the storage
+	 * hardware or any filesystem logs. This fsync call acts as a barrier
+	 * to ensure that the data in each new object file is durable before
+	 * the final name is visible.
+	 */
+	strbuf_addf(&temp_path, "%s/bulk_fsync_XXXXXX",
+		    repo_get_object_directory(transaction->odb->repo));
+	temp = xmks_tempfile(temp_path.buf);
+	fsync_or_die(get_tempfile_fd(temp), get_tempfile_path(temp));
+	delete_tempfile(&temp);
+	strbuf_release(&temp_path);
+
+	/*
+	 * Make the object files visible in the primary ODB after their data is
+	 * fully durable.
+	 */
+	tmp_objdir_migrate(transaction->objdir);
+	transaction->objdir = NULL;
+}
+
 /* Finalize a file on disk, and close it. */
 static void close_loose_object(struct odb_source *source,
 			       int fd, const char *filename)
@@ -1243,6 +1331,283 @@ static int index_core(struct index_state *istate,
 	return ret;
 }
 
+static int already_written(struct odb_transaction *transaction,
+			   struct object_id *oid)
+{
+	/* The object may already exist in the repository */
+	if (odb_has_object(transaction->odb, oid,
+			   HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))
+		return 1;
+
+	/* Might want to keep the list sorted */
+	for (uint32_t i = 0; i < transaction->packfile.nr_written; i++)
+		if (oideq(&transaction->packfile.written[i]->oid, oid))
+			return 1;
+
+	/* This is a new object we need to keep */
+	return 0;
+}
+
+/* Lazily create backing packfile for the state */
+static void prepare_to_stream(struct odb_transaction *transaction,
+			      unsigned flags)
+{
+	struct bulk_checkin_packfile *state = &transaction->packfile;
+	if (!(flags & INDEX_WRITE_OBJECT) || state->f)
+		return;
+
+	state->f = create_tmp_packfile(transaction->odb->repo,
+				       &state->pack_tmp_name);
+	reset_pack_idx_option(&state->pack_idx_opts);
+
+	/* Pretend we are going to write only one object */
+	state->offset = write_pack_header(state->f, 1);
+	if (!state->offset)
+		die_errno("unable to write pack header");
+}
+
+/*
+ * Read the contents from fd for size bytes, streaming it to the
+ * packfile in state while updating the hash in ctx. Signal a failure
+ * by returning a negative value when the resulting pack would exceed
+ * the pack size limit and this is not the first object in the pack,
+ * so that the caller can discard what we wrote from the current pack
+ * by truncating it and opening a new one. The caller will then call
+ * us again after rewinding the input fd.
+ *
+ * The already_hashed_to pointer is kept untouched by the caller to
+ * make sure we do not hash the same byte when we are called
+ * again. This way, the caller does not have to checkpoint its hash
+ * status before calling us just in case we ask it to call us again
+ * with a new pack.
+ */
+static int stream_blob_to_pack(struct bulk_checkin_packfile *state,
+			       struct git_hash_ctx *ctx, off_t *already_hashed_to,
+			       int fd, size_t size, const char *path,
+			       unsigned flags)
+{
+	git_zstream s;
+	unsigned char ibuf[16384];
+	unsigned char obuf[16384];
+	unsigned hdrlen;
+	int status = Z_OK;
+	int write_object = (flags & INDEX_WRITE_OBJECT);
+	off_t offset = 0;
+
+	git_deflate_init(&s, pack_compression_level);
+
+	hdrlen = encode_in_pack_object_header(obuf, sizeof(obuf), OBJ_BLOB, size);
+	s.next_out = obuf + hdrlen;
+	s.avail_out = sizeof(obuf) - hdrlen;
+
+	while (status != Z_STREAM_END) {
+		if (size && !s.avail_in) {
+			size_t rsize = size < sizeof(ibuf) ? size : sizeof(ibuf);
+			ssize_t read_result = read_in_full(fd, ibuf, rsize);
+			if (read_result < 0)
+				die_errno("failed to read from '%s'", path);
+			if ((size_t)read_result != rsize)
+				die("failed to read %u bytes from '%s'",
+				    (unsigned)rsize, path);
+			offset += rsize;
+			if (*already_hashed_to < offset) {
+				size_t hsize = offset - *already_hashed_to;
+				if (rsize < hsize)
+					hsize = rsize;
+				if (hsize)
+					git_hash_update(ctx, ibuf, hsize);
+				*already_hashed_to = offset;
+			}
+			s.next_in = ibuf;
+			s.avail_in = rsize;
+			size -= rsize;
+		}
+
+		status = git_deflate(&s, size ? 0 : Z_FINISH);
+
+		if (!s.avail_out || status == Z_STREAM_END) {
+			if (write_object) {
+				size_t written = s.next_out - obuf;
+
+				/* would we bust the size limit? */
+				if (state->nr_written &&
+				    pack_size_limit_cfg &&
+				    pack_size_limit_cfg < state->offset + written) {
+					git_deflate_abort(&s);
+					return -1;
+				}
+
+				hashwrite(state->f, obuf, written);
+				state->offset += written;
+			}
+			s.next_out = obuf;
+			s.avail_out = sizeof(obuf);
+		}
+
+		switch (status) {
+		case Z_OK:
+		case Z_BUF_ERROR:
+		case Z_STREAM_END:
+			continue;
+		default:
+			die("unexpected deflate failure: %d", status);
+		}
+	}
+	git_deflate_end(&s);
+	return 0;
+}
+
+static void finish_tmp_packfile(struct odb_transaction *transaction,
+				struct strbuf *basename,
+				unsigned char hash[])
+{
+	struct bulk_checkin_packfile *state = &transaction->packfile;
+	struct repository *repo = transaction->odb->repo;
+	char *idx_tmp_name = NULL;
+
+	stage_tmp_packfiles(repo, basename, state->pack_tmp_name,
+			    state->written, state->nr_written, NULL,
+			    &state->pack_idx_opts, hash, &idx_tmp_name);
+	rename_tmp_packfile_idx(repo, basename, &idx_tmp_name);
+
+	free(idx_tmp_name);
+}
+
+static void flush_bulk_checkin_packfile(struct odb_transaction *transaction)
+{
+	struct bulk_checkin_packfile *state = &transaction->packfile;
+	struct repository *repo = transaction->odb->repo;
+	unsigned char hash[GIT_MAX_RAWSZ];
+	struct strbuf packname = STRBUF_INIT;
+
+	if (!state->f)
+		return;
+
+	if (state->nr_written == 0) {
+		close(state->f->fd);
+		free_hashfile(state->f);
+		unlink(state->pack_tmp_name);
+		goto clear_exit;
+	} else if (state->nr_written == 1) {
+		finalize_hashfile(state->f, hash, FSYNC_COMPONENT_PACK,
+				  CSUM_HASH_IN_STREAM | CSUM_FSYNC | CSUM_CLOSE);
+	} else {
+		int fd = finalize_hashfile(state->f, hash, FSYNC_COMPONENT_PACK, 0);
+		fixup_pack_header_footer(repo->hash_algo, fd, hash, state->pack_tmp_name,
+					 state->nr_written, hash,
+					 state->offset);
+		close(fd);
+	}
+
+	strbuf_addf(&packname, "%s/pack/pack-%s.",
+		    repo_get_object_directory(transaction->odb->repo),
+		    hash_to_hex_algop(hash, repo->hash_algo));
+
+	finish_tmp_packfile(transaction, &packname, hash);
+	for (uint32_t i = 0; i < state->nr_written; i++)
+		free(state->written[i]);
+
+clear_exit:
+	free(state->pack_tmp_name);
+	free(state->written);
+	memset(state, 0, sizeof(*state));
+
+	strbuf_release(&packname);
+	/* Make objects we just wrote available to ourselves */
+	reprepare_packed_git(repo);
+}
+
+/*
+ * This writes the specified object to a packfile. Objects written here
+ * during the same transaction are written to the same packfile. The
+ * packfile is not flushed until the transaction is flushed. The caller
+ * is expected to ensure a valid transaction is setup for objects to be
+ * recorded to.
+ *
+ * This also bypasses the usual "convert-to-git" dance, and that is on
+ * purpose. We could write a streaming version of the converting
+ * functions and insert that before feeding the data to fast-import
+ * (or equivalent in-core API described above). However, that is
+ * somewhat complicated, as we do not know the size of the filter
+ * result, which we need to know beforehand when writing a git object.
+ * Since the primary motivation for trying to stream from the working
+ * tree file and to avoid mmaping it in core is to deal with large
+ * binary blobs, they generally do not want to get any conversion, and
+ * callers should avoid this code path when filters are requested.
+ */
+static int index_blob_bulk_checkin(struct odb_transaction *transaction,
+			    struct object_id *result_oid, int fd, size_t size,
+			    const char *path, unsigned flags)
+{
+	struct bulk_checkin_packfile *state = &transaction->packfile;
+	off_t seekback, already_hashed_to;
+	struct git_hash_ctx ctx;
+	unsigned char obuf[16384];
+	unsigned header_len;
+	struct hashfile_checkpoint checkpoint;
+	struct pack_idx_entry *idx = NULL;
+
+	seekback = lseek(fd, 0, SEEK_CUR);
+	if (seekback == (off_t)-1)
+		return error("cannot find the current offset");
+
+	header_len = format_object_header((char *)obuf, sizeof(obuf),
+					  OBJ_BLOB, size);
+	transaction->odb->repo->hash_algo->init_fn(&ctx);
+	git_hash_update(&ctx, obuf, header_len);
+
+	/* Note: idx is non-NULL when we are writing */
+	if ((flags & INDEX_WRITE_OBJECT) != 0) {
+		CALLOC_ARRAY(idx, 1);
+
+		prepare_to_stream(transaction, flags);
+		hashfile_checkpoint_init(state->f, &checkpoint);
+	}
+
+	already_hashed_to = 0;
+
+	while (1) {
+		prepare_to_stream(transaction, flags);
+		if (idx) {
+			hashfile_checkpoint(state->f, &checkpoint);
+			idx->offset = state->offset;
+			crc32_begin(state->f);
+		}
+		if (!stream_blob_to_pack(state, &ctx, &already_hashed_to,
+					 fd, size, path, flags))
+			break;
+		/*
+		 * Writing this object to the current pack will make
+		 * it too big; we need to truncate it, start a new
+		 * pack, and write into it.
+		 */
+		if (!idx)
+			BUG("should not happen");
+		hashfile_truncate(state->f, &checkpoint);
+		state->offset = checkpoint.offset;
+		flush_bulk_checkin_packfile(transaction);
+		if (lseek(fd, seekback, SEEK_SET) == (off_t)-1)
+			return error("cannot seek back");
+	}
+	git_hash_final_oid(result_oid, &ctx);
+	if (!idx)
+		return 0;
+
+	idx->crc32 = crc32_end(state->f);
+	if (already_written(transaction, result_oid)) {
+		hashfile_truncate(state->f, &checkpoint);
+		state->offset = checkpoint.offset;
+		free(idx);
+	} else {
+		oidcpy(&idx->oid, result_oid);
+		ALLOC_GROW(state->written,
+			   state->nr_written + 1,
+			   state->alloc_written);
+		state->written[state->nr_written++] = idx;
+	}
+	return 0;
+}
+
 int index_fd(struct index_state *istate, struct object_id *oid,
 	     int fd, struct stat *st,
 	     enum object_type type, const char *path, unsigned flags)
@@ -1613,3 +1978,22 @@ int read_loose_object(struct repository *repo,
 		munmap(map, mapsize);
 	return ret;
 }
+
+struct odb_transaction *begin_odb_transaction(struct object_database *odb)
+{
+	if (odb->transaction)
+		BUG("ODB transaction already started");
+
+	CALLOC_ARRAY(odb->transaction, 1);
+	odb->transaction->odb = odb;
+
+	return odb->transaction;
+}
+
+void end_odb_transaction(struct odb_transaction *transaction)
+{
+	flush_batch_fsync(transaction);
+	flush_bulk_checkin_packfile(transaction);
+	transaction->odb->transaction = NULL;
+	free(transaction);
+}
diff --git a/object-file.h b/object-file.h
index 15d97630d3b..5925563f838 100644
--- a/object-file.h
+++ b/object-file.h
@@ -218,4 +218,21 @@ int read_loose_object(struct repository *repo,
 		      void **contents,
 		      struct object_info *oi);
 
+struct odb_transaction;
+
+/*
+ * Tell the object database to optimize for adding
+ * multiple objects. end_odb_transaction must be called
+ * to make new objects visible. Only a single transaction
+ * can be pending at a time and must be ended before
+ * beginning another.
+ */
+struct odb_transaction *begin_odb_transaction(struct object_database *odb);
+
+/*
+ * Tell the object database to make any objects from the
+ * current transaction visible.
+ */
+void end_odb_transaction(struct odb_transaction *transaction);
+
 #endif /* OBJECT_FILE_H */
diff --git a/read-cache.c b/read-cache.c
index 7e5501f0839..ac0655743f6 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -8,7 +8,6 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
-#include "bulk-checkin.h"
 #include "config.h"
 #include "date.h"
 #include "diff.h"
-- 
2.51.0.193.g4975ec3473b

