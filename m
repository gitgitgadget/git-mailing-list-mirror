Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B295826F476
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 23:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755818577; cv=none; b=pZuWmbtERvdHpHk6al9VwmPgpQxnSulsdPWHqEX26Ee1NDJguHMSqt2QkhkCewbamHyGdP0mZ8BJ1ryFIbzvyc7dU4jDgSUfGPizAzfErrN76yFtN26MctQFo1X6NS08QavmstTgMq3tRMwf9phk71M2LfJqnxzK2h4/75TcuPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755818577; c=relaxed/simple;
	bh=IHd/HmShgmsVOK6lB4O1fFiKpvaQCMlIQ7KQOrkAqyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AWjU4HmkExupv01vBolAwmHnm+lxK9oclhB+5VvIJVFP8rTdlR5e7J/Y3mtdBCDIGeR9OpjcXl36JxStmou0IedGsh0LDgISZpCZMJn7LxfdjhJTeCOz7ZANC+chVdxTOA8zkylwzucI4AOgOx/kJeuOZx4+bn8/NGZmwczKisw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EgXJIQZX; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EgXJIQZX"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-30ccebab736so1194583fac.3
        for <git@vger.kernel.org>; Thu, 21 Aug 2025 16:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755818574; x=1756423374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=00q7yCY2kGGtf+iO2exF+gJHw+Glc0PgRVoL1VsrNnc=;
        b=EgXJIQZXgSo21rdfKIqMnMCx5bmXPKQxVCSaEcWavfvMY7ddcfRXyspVMRtx0Kr9LE
         iYYQMGqI+NXNh2x7XNpH2TDI17iohZ2lKVvanfxcQxyIX7bjMciGpyLUzBjENxCQLeeO
         A1LpCjmeb6akHloh8yFiUovot91rVqpB95uh5KU4538huH4n+wOoVIe4t4uAnzwM2lQG
         CTuAmz4oXU7kHRllJkmnm8x0rXfqDLyNa4lQ3YRZtj1nM4klQ+7qGH9ZRwLEUSHzf0zm
         n7Rd+ZXi4YUpD3V9vlBDuV1ghgsCLZdza/3dE8WIbcWtm1VBjkHhLPgUmhuHjsNeDdRF
         Yg5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755818574; x=1756423374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=00q7yCY2kGGtf+iO2exF+gJHw+Glc0PgRVoL1VsrNnc=;
        b=Rt2Q6ZrtkqPzSJ9bcG0RCOzC1lG3Rqm+DloxzY+HVfJYJHoXo2HEQkES6OUs58eH2l
         JDHzzNaM2JrZ/ik7DgEax0CqvN6n2pd5ZsGMDxckdUJH/o1yehnT2dzxulsMJ1icZ9/i
         lDr2YEao4acZB6mYGaoFfQe0Sf8kNB/hcq1q2r8gHJe7U7iieWiQ7h2eTvawADdJME9l
         7uo/LT+KomOODQTOSlj9sRCRkS6+Qt4N00aBWj3nA+crjfEn9mJtn7b40zetbcPlEedG
         b304ylht7I8K+lLH6uMPwTqpgDuI+ZYMiLYt1XU/pBxjS45Ir7p6/WDfqt69s4JBB2lw
         nJqA==
X-Gm-Message-State: AOJu0YwIZvXa+8+cQAjOlu6qV6BB08yvjIFL3K8PkZDb3rhGLLasyKMq
	o5z13VafWMy2vqJTB5MBDzirzOKXrmTG/utoTDwz+1HIN2loudoJw+W2aVbYPQ5O
X-Gm-Gg: ASbGnctyjg7znRus4M2dYxTnWVzV2c0WECPnmbsBapXxqcy3S4bL6PqupWUfS3c9dBu
	qlBIKtjCofS+qk+5Gdc26tCWbis48+eP7AIjc72pd4MaL6zaQHk59F+NTzU89F/Y6hYIGrau5N5
	9W8p8ZhAdHh7QlvCnbg5luvQQhXk1zTG+hcX4RFBy5KMM/mfxSxo1xI/BILCDfXEaSzzLRIygn1
	cVhPFigIyspt/URN88UUj165xnwlMH1DEiuekroAYehaAsTq3W0nwR+bO9Z5y/tJOedYIaD7QoL
	4bMwRp7VwlVyoYO8kIali1hgdwpq1yAXWhts3wmcQr1qR1+IoRZcEJuDUsvo22leZLSm2gTZzVO
	al3fgju05b1dnMfRNamiuFfXGccRodes=
X-Google-Smtp-Source: AGHT+IHa2P+WKPtD63KXE74qeAhuhzWP+w8zAq7T57xRMdtvCdzqpPigSueVOSmESKNlG/Acv5Jq8g==
X-Received: by 2002:a05:6871:8905:b0:2d5:4f4:e24d with SMTP id 586e51a60fabf-314dcad7d1amr501246fac.6.1755818574323;
        Thu, 21 Aug 2025 16:22:54 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7439204d621sm3759747a34.40.2025.08.21.16.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 16:22:53 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 0/4] bulk-checkin: remove global transaction state
Date: Thu, 21 Aug 2025 18:22:45 -0500
Message-ID: <20250821232249.319427-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250820225531.1212935-1-jltobler@gmail.com>
References: <20250820225531.1212935-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings,

The bulk-checkin subsystem provides an interface to write objects to the
object database in a bulk transaction. The state of an ongoing
transaction is stored across several global variables. This series aims
to remove this global transaction state in favor of storing state in in
`struct object_database`. This is done in preparation for a follow-up
change where the goal is to eventually move these transaction interfaces
into "odb.h".

Changes since V1:

- `index_blob_bulk_checkin()` now assumes that the caller always
  provides a setup `struct odb_transaction`. Callers are adjusted to
  ensure this.
- Functions in bulk-checkin.c now consistently access the repository
  through the provided `odb_transaction`.

Thanks,
-Justin

Justin Tobler (4):
  bulk-checkin: introduce object database transaction structure
  bulk-checkin: remove global transaction state
  bulk-checkin: require transaction for index_blob_bulk_checkin()
  bulk-checkin: use repository variable from transaction

 builtin/add.c            |   5 +-
 builtin/unpack-objects.c |   5 +-
 builtin/update-index.c   |   7 +-
 bulk-checkin.c           | 153 +++++++++++++++++++++------------------
 bulk-checkin.h           |  25 ++++---
 cache-tree.c             |   5 +-
 object-file.c            |  30 +++++---
 odb.h                    |   8 ++
 read-cache.c             |   5 +-
 9 files changed, 142 insertions(+), 101 deletions(-)

Range-diff against v1:
1:  5c9358e0b03 = 1:  5c9358e0b03 bulk-checkin: introduce object database transaction structure
2:  4a1b80a6baf = 2:  4a1b80a6baf bulk-checkin: remove global transaction state
-:  ----------- > 3:  ce329932fdd bulk-checkin: require transaction for index_blob_bulk_checkin()
3:  2ca78c8d343 ! 4:  08e26647915 bulk-checkin: wire repository variable
    @@ Metadata
     Author: Justin Tobler <jltobler@gmail.com>
     
      ## Commit message ##
    -    bulk-checkin: wire repository variable
    +    bulk-checkin: use repository variable from transaction
     
         The bulk-checkin subsystem depends on `the_repository`. Adapt functions
    -    and call sites to wire the repository variable where needed. The
    -    `USE_THE_REPOSITORY_VARIBALE` is still required as the
    +    and call sites to access the repository through `struct odb_transaction`
    +    instead. The `USE_THE_REPOSITORY_VARIBALE` is still required as the
         `pack_compression_level` and `pack_size_limit_cfg` globals are still
         used.
     
    @@ bulk-checkin.c: struct odb_transaction {
      };
      
     -static void finish_tmp_packfile(struct strbuf *basename,
    -+static void finish_tmp_packfile(struct repository *repo,
    +-				const char *pack_tmp_name,
    +-				struct pack_idx_entry **written_list,
    +-				uint32_t nr_written,
    +-				struct pack_idx_option *pack_idx_opts,
    ++static void finish_tmp_packfile(struct odb_transaction *transaction,
     +				struct strbuf *basename,
    - 				const char *pack_tmp_name,
    - 				struct pack_idx_entry **written_list,
    - 				uint32_t nr_written,
    -@@ bulk-checkin.c: static void finish_tmp_packfile(struct strbuf *basename,
    + 				unsigned char hash[])
      {
    ++	struct bulk_checkin_packfile *state = &transaction->packfile;
    ++	struct repository *repo = transaction->odb->repo;
      	char *idx_tmp_name = NULL;
      
     -	stage_tmp_packfiles(the_repository, basename, pack_tmp_name,
    -+	stage_tmp_packfiles(repo, basename, pack_tmp_name,
    - 			    written_list, nr_written, NULL, pack_idx_opts, hash,
    - 			    &idx_tmp_name);
    +-			    written_list, nr_written, NULL, pack_idx_opts, hash,
    +-			    &idx_tmp_name);
     -	rename_tmp_packfile_idx(the_repository, basename, &idx_tmp_name);
    ++	stage_tmp_packfiles(repo, basename, state->pack_tmp_name,
    ++			    state->written, state->nr_written, NULL,
    ++			    &state->pack_idx_opts, hash, &idx_tmp_name);
     +	rename_tmp_packfile_idx(repo, basename, &idx_tmp_name);
      
      	free(idx_tmp_name);
      }
      
     -static void flush_bulk_checkin_packfile(struct bulk_checkin_packfile *state)
    -+static void flush_bulk_checkin_packfile(struct bulk_checkin_packfile *state,
    -+					struct repository *repo)
    ++static void flush_bulk_checkin_packfile(struct odb_transaction *transaction)
      {
    ++	struct bulk_checkin_packfile *state = &transaction->packfile;
    ++	struct repository *repo = transaction->odb->repo;
      	unsigned char hash[GIT_MAX_RAWSZ];
      	struct strbuf packname = STRBUF_INIT;
    + 
     @@ bulk-checkin.c: static void flush_bulk_checkin_packfile(struct bulk_checkin_packfile *state)
      				  CSUM_HASH_IN_STREAM | CSUM_FSYNC | CSUM_CLOSE);
      	} else {
    @@ bulk-checkin.c: static void flush_bulk_checkin_packfile(struct bulk_checkin_pack
     -	strbuf_addf(&packname, "%s/pack/pack-%s.", repo_get_object_directory(the_repository),
     -		    hash_to_hex(hash));
     -	finish_tmp_packfile(&packname, state->pack_tmp_name,
    -+	strbuf_addf(&packname, "%s/pack/pack-%s.", repo_get_object_directory(repo),
    +-			    state->written, state->nr_written,
    +-			    &state->pack_idx_opts, hash);
    ++	strbuf_addf(&packname, "%s/pack/pack-%s.",
    ++		    transaction->odb->sources->path,
     +		    hash_to_hex_algop(hash, repo->hash_algo));
    -+	finish_tmp_packfile(repo, &packname, state->pack_tmp_name,
    - 			    state->written, state->nr_written,
    - 			    &state->pack_idx_opts, hash);
    ++
    ++	finish_tmp_packfile(transaction, &packname, hash);
      	for (uint32_t i = 0; i < state->nr_written; i++)
    + 		free(state->written[i]);
    + 
     @@ bulk-checkin.c: static void flush_bulk_checkin_packfile(struct bulk_checkin_packfile *state)
      
      	strbuf_release(&packname);
    @@ bulk-checkin.c: static void flush_batch_fsync(struct odb_transaction *transactio
      	 */
     -	strbuf_addf(&temp_path, "%s/bulk_fsync_XXXXXX", repo_get_object_directory(the_repository));
     +	strbuf_addf(&temp_path, "%s/bulk_fsync_XXXXXX",
    -+		    repo_get_object_directory(transaction->odb->repo));
    ++		    transaction->odb->sources->path);
      	temp = xmks_tempfile(temp_path.buf);
      	fsync_or_die(get_tempfile_fd(temp), get_tempfile_path(temp));
      	delete_tempfile(&temp);
    @@ bulk-checkin.c: static void flush_batch_fsync(struct odb_transaction *transactio
      }
      
     -static int already_written(struct bulk_checkin_packfile *state, struct object_id *oid)
    -+static int already_written(struct bulk_checkin_packfile *state,
    -+			   struct repository *repo, struct object_id *oid)
    ++static int already_written(struct odb_transaction *transaction,
    ++			   struct object_id *oid)
      {
      	/* The object may already exist in the repository */
     -	if (odb_has_object(the_repository->objects, oid,
    -+	if (odb_has_object(repo->objects, oid,
    ++	if (odb_has_object(transaction->odb, oid,
      			   HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))
      		return 1;
      
    + 	/* Might want to keep the list sorted */
    +-	for (uint32_t i = 0; i < state->nr_written; i++)
    +-		if (oideq(&state->written[i]->oid, oid))
    ++	for (uint32_t i = 0; i < transaction->packfile.nr_written; i++)
    ++		if (oideq(&transaction->packfile.written[i]->oid, oid))
    + 			return 1;
    + 
    + 	/* This is a new object we need to keep */
     @@ bulk-checkin.c: static int stream_blob_to_pack(struct bulk_checkin_packfile *state,
    + }
      
      /* Lazily create backing packfile for the state */
    - static void prepare_to_stream(struct bulk_checkin_packfile *state,
    -+			      struct repository *repo,
    +-static void prepare_to_stream(struct bulk_checkin_packfile *state,
    ++static void prepare_to_stream(struct odb_transaction *transaction,
      			      unsigned flags)
      {
    ++	struct bulk_checkin_packfile *state = &transaction->packfile;
      	if (!(flags & INDEX_WRITE_OBJECT) || state->f)
      		return;
      
     -	state->f = create_tmp_packfile(the_repository, &state->pack_tmp_name);
    -+	state->f = create_tmp_packfile(repo, &state->pack_tmp_name);
    ++	state->f = create_tmp_packfile(transaction->odb->repo,
    ++				       &state->pack_tmp_name);
      	reset_pack_idx_option(&state->pack_idx_opts);
      
      	/* Pretend we are going to write only one object */
     @@ bulk-checkin.c: static void prepare_to_stream(struct bulk_checkin_packfile *state,
    + 		die_errno("unable to write pack header");
      }
      
    - static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
    -+				struct repository *repo,
    - 				struct object_id *result_oid,
    - 				int fd, size_t size,
    - 				const char *path, unsigned flags)
    +-static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
    +-				struct object_id *result_oid,
    +-				int fd, size_t size,
    +-				const char *path, unsigned flags)
    ++int index_blob_bulk_checkin(struct odb_transaction *transaction,
    ++			    struct object_id *result_oid,
    ++			    int fd, size_t size,
    ++			    const char *path, unsigned flags)
    + {
    ++	struct bulk_checkin_packfile *state = &transaction->packfile;
    + 	off_t seekback, already_hashed_to;
    + 	struct git_hash_ctx ctx;
    + 	unsigned char obuf[16384];
     @@ bulk-checkin.c: static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
      
      	header_len = format_object_header((char *)obuf, sizeof(obuf),
      					  OBJ_BLOB, size);
     -	the_hash_algo->init_fn(&ctx);
    -+	repo->hash_algo->init_fn(&ctx);
    ++	transaction->odb->repo->hash_algo->init_fn(&ctx);
      	git_hash_update(&ctx, obuf, header_len);
      
      	/* Note: idx is non-NULL when we are writing */
    @@ bulk-checkin.c: static int deflate_blob_to_pack(struct bulk_checkin_packfile *st
      		CALLOC_ARRAY(idx, 1);
      
     -		prepare_to_stream(state, flags);
    -+		prepare_to_stream(state, repo, flags);
    ++		prepare_to_stream(transaction, flags);
      		hashfile_checkpoint_init(state->f, &checkpoint);
      	}
      
    @@ bulk-checkin.c: static int deflate_blob_to_pack(struct bulk_checkin_packfile *st
      
      	while (1) {
     -		prepare_to_stream(state, flags);
    -+		prepare_to_stream(state, repo, flags);
    ++		prepare_to_stream(transaction, flags);
      		if (idx) {
      			hashfile_checkpoint(state->f, &checkpoint);
      			idx->offset = state->offset;
    @@ bulk-checkin.c: static int deflate_blob_to_pack(struct bulk_checkin_packfile *st
      		hashfile_truncate(state->f, &checkpoint);
      		state->offset = checkpoint.offset;
     -		flush_bulk_checkin_packfile(state);
    -+		flush_bulk_checkin_packfile(state, repo);
    ++		flush_bulk_checkin_packfile(transaction);
      		if (lseek(fd, seekback, SEEK_SET) == (off_t) -1)
      			return error("cannot seek back");
      	}
    @@ bulk-checkin.c: static int deflate_blob_to_pack(struct bulk_checkin_packfile *st
      
      	idx->crc32 = crc32_end(state->f);
     -	if (already_written(state, result_oid)) {
    -+	if (already_written(state, repo, result_oid)) {
    ++	if (already_written(transaction, result_oid)) {
      		hashfile_truncate(state->f, &checkpoint);
      		state->offset = checkpoint.offset;
      		free(idx);
    @@ bulk-checkin.c: void fsync_loose_object_bulk_checkin(struct odb_transaction *tra
      }
      
     -int index_blob_bulk_checkin(struct odb_transaction *transaction,
    -+int index_blob_bulk_checkin(struct repository *repo,
    -+			    struct odb_transaction *transaction,
    - 			    struct object_id *oid, int fd, size_t size,
    - 			    const char *path, unsigned flags)
    +-			    struct object_id *oid, int fd, size_t size,
    +-			    const char *path, unsigned flags)
    +-{
    +-	return deflate_blob_to_pack(&transaction->packfile, oid, fd, size, path,
    +-				    flags);
    +-}
    +-
    + struct odb_transaction *begin_odb_transaction(struct object_database *odb)
      {
    - 	int status;
    - 
    - 	if (transaction) {
    --		status = deflate_blob_to_pack(&transaction->packfile, oid, fd,
    --					      size, path, flags);
    -+		status = deflate_blob_to_pack(&transaction->packfile,
    -+					      repo, oid, fd, size, path, flags);
    - 	} else {
    - 		struct bulk_checkin_packfile state = { 0 };
    - 
    --		status = deflate_blob_to_pack(&state, oid, fd, size, path, flags);
    --		flush_bulk_checkin_packfile(&state);
    -+		status = deflate_blob_to_pack(&state, repo, oid, fd, size, path, flags);
    -+		flush_bulk_checkin_packfile(&state, repo);
    - 	}
    - 
    - 	return status;
    + 	if (!odb->transaction) {
     @@ bulk-checkin.c: void flush_odb_transaction(struct odb_transaction *transaction)
      		return;
      
      	flush_batch_fsync(transaction);
     -	flush_bulk_checkin_packfile(&transaction->packfile);
    -+	flush_bulk_checkin_packfile(&transaction->packfile,
    -+				    transaction->odb->repo);
    ++	flush_bulk_checkin_packfile(transaction);
      }
      
      void end_odb_transaction(struct odb_transaction *transaction)
    -
    - ## bulk-checkin.h ##
    -@@ bulk-checkin.h: void fsync_loose_object_bulk_checkin(struct odb_transaction *transaction,
    -  * binary blobs, they generally do not want to get any conversion, and
    -  * callers should avoid this code path when filters are requested.
    -  */
    --int index_blob_bulk_checkin(struct odb_transaction *transaction,
    -+int index_blob_bulk_checkin(struct repository *repo,
    -+			    struct odb_transaction *transaction,
    - 			    struct object_id *oid, int fd, size_t size,
    - 			    const char *path, unsigned flags);
    - 
    -
    - ## object-file.c ##
    -@@ object-file.c: int index_fd(struct index_state *istate, struct object_id *oid,
    - 		ret = index_core(istate, oid, fd, xsize_t(st->st_size),
    - 				 type, path, flags);
    - 	else
    --		ret = index_blob_bulk_checkin(the_repository->objects->transaction,
    -+		ret = index_blob_bulk_checkin(the_repository,
    -+					      the_repository->objects->transaction,
    - 					      oid, fd, xsize_t(st->st_size),
    - 					      path, flags);
    - 	close(fd);

base-commit: c44beea485f0f2feaf460e2ac87fdd5608d63cf0
-- 
2.51.0

