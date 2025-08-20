Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280532DBF45
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 22:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755730551; cv=none; b=AdwTRqwdeqHG8vjgmxKi8/pKOEIGrGpgiOX4f2qLdTSGPMqGFRxA6NbDNGFiyDK3cV0LZld+bgvXpNQWL2xtpp+9BJQjlo6lc0NPqmxL+N0oP3fWsqFpD9J9u9tEYJUdbtWViTtWB54Glz5vaA9lSn2Nm3UrlUGomKabRHF1ufs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755730551; c=relaxed/simple;
	bh=9SJSm8PtKg/1vMQsQRgSkT0t1WyvGZxZGzA9yAm9qiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YK7Ptpm31o971Wipi0JtOBCL6p1cTIwwzOsswKUn5bqjomZmPtpyFgLbLyNlyc6O+/3x3rjx73iZddstvS0M/5CV7obcGKADHOCPYZKRD0zWeIkc7gCTJq8DymQTHHDuDLsSjHBfXN6FG8f0zCPD238TZWyjnSxOhAmG0LpdCzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dGMP1fxf; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGMP1fxf"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-30cceaaecd8so223107fac.2
        for <git@vger.kernel.org>; Wed, 20 Aug 2025 15:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755730549; x=1756335349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H2ELEgTl3bOmGXY+OruLhHGuqYwMxpCAMwAVQZNyy/A=;
        b=dGMP1fxf9ammp/sN59siSsWbZXXEMLR8A99/vvwpuBRD1uxy1woshjQ/7Uk8cx/Rch
         yHnS/Ng+uFcLbqJEEKszoG4Jyo8ke+c01lDqLW7KTgh2x40Tbagky0HGEGTz3i/Hu4mt
         C9Y9W3uabhuaD1ZZMbMkpnVIK+EzCLOob/GOM3p4qCwZkiTZ0R2y549hwhiZ2o6lZ/j1
         10bWfEWEHj5uDP8xCfRDVi7VZ2JH1FGTW8dNNd/qWNNBGnLf+VP5vFqDrSUyDHvNBEri
         3rFCuLsmq9+8eZdkdnSgNPOyEmnSKR2QoOQ1CjPvsJ5urYYU/kYssK4baDTpDzrC7LKO
         ZNpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755730549; x=1756335349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H2ELEgTl3bOmGXY+OruLhHGuqYwMxpCAMwAVQZNyy/A=;
        b=Hv4bzO7pfk2z4X2ZIuAynlanZsHQ1TDQj00Vwe0/G0R3CygfEQqSdiBShktC3vY9/p
         /6WAM4VWezEaZdHWv9xSjVV3+YGpcH1jVtv+pIEbQGrvrkH+Z0e1s0ixoBRPzmAw6r5g
         RcM66Q2G9B45bpecvKmI0JGdecaw/9OG67dvI5nEGcj1sioBTByjR/hSXUbRydBDh3am
         9l/oUZ6CnpBPOZ2m3y5HrjaBr6KYm5EPvNdj2mLMJZezB4BCmYSPxUbIrCQx1GbbpbXN
         oA1mrtnrPH5runeHaj78wCadJTtkF8WbeO7L4B9R6jWJS4faizGEdgSfaBlcNX2EMOeB
         u/7g==
X-Gm-Message-State: AOJu0YyYbkl+tZSHDre5dMPbt/pfkIVmRZm93HlipumejssoerjODp/d
	/h6FkTG6XgAiUVWTuspaw9w5JQwUzBE4pq5ifv5lmy2piZAZyETSnaVy5TCXORO/
X-Gm-Gg: ASbGncvl6nNHKF73JKM+7vBvY+aiUWMPWDh2DGtiqOhi6QSnpvviqtt5Og7dkMC/XUu
	MF7QywUoEUvXt+gsenej6VHWLwZD0Egfq0lWrQY9gFCWXu8NcWLryHJWHA1D/CxDPIP22MSuWcE
	ObMzuiFlKOB9jGMixR+nv96nQiYtXDnTAgjg1FxQDrU2Lhgz9WcEQd3wtIQwIsmYeZ6yx0M/LaQ
	lBaqCJh7+a4CiTczFfSTUN0EWaPajVr9LLk2GEFs372dHoehzKVe/dLXmb2iVIJwBMqEP8By2si
	XzrUrsbzZvHm8OY10PowqWSQ5c72qyIClHSDTimz4OCdbS6AcKPm0d57LvDw+dHEv7N9KqVV3Wu
	og1ymUYFMpD2Rnx7DFwFPKdR7wc2Js4guc+do97ZIzA==
X-Google-Smtp-Source: AGHT+IEDxZGO/1k95pyJEMnZpjwHvWUGB8wVm3bPJ4frhS0kH6btNcRFsnPtx5pLNIj+9i2XtGOFkw==
X-Received: by 2002:a05:6870:558e:b0:30b:cba0:31d2 with SMTP id 586e51a60fabf-314c659216fmr172412fac.31.1755730548829;
        Wed, 20 Aug 2025 15:55:48 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3111d32f9e8sm1175860fac.21.2025.08.20.15.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 15:55:48 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 3/3] bulk-checkin: wire repository variable
Date: Wed, 20 Aug 2025 17:55:31 -0500
Message-ID: <20250820225531.1212935-4-jltobler@gmail.com>
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

The bulk-checkin subsystem depends on `the_repository`. Adapt functions
and call sites to wire the repository variable where needed. The
`USE_THE_REPOSITORY_VARIBALE` is still required as the
`pack_compression_level` and `pack_size_limit_cfg` globals are still
used.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 bulk-checkin.c | 58 ++++++++++++++++++++++++++++----------------------
 bulk-checkin.h |  3 ++-
 object-file.c  |  3 ++-
 3 files changed, 37 insertions(+), 27 deletions(-)

diff --git a/bulk-checkin.c b/bulk-checkin.c
index 53a20a2d92f..a1185883837 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -38,7 +38,8 @@ struct odb_transaction {
 	struct bulk_checkin_packfile packfile;
 };
 
-static void finish_tmp_packfile(struct strbuf *basename,
+static void finish_tmp_packfile(struct repository *repo,
+				struct strbuf *basename,
 				const char *pack_tmp_name,
 				struct pack_idx_entry **written_list,
 				uint32_t nr_written,
@@ -47,15 +48,16 @@ static void finish_tmp_packfile(struct strbuf *basename,
 {
 	char *idx_tmp_name = NULL;
 
-	stage_tmp_packfiles(the_repository, basename, pack_tmp_name,
+	stage_tmp_packfiles(repo, basename, pack_tmp_name,
 			    written_list, nr_written, NULL, pack_idx_opts, hash,
 			    &idx_tmp_name);
-	rename_tmp_packfile_idx(the_repository, basename, &idx_tmp_name);
+	rename_tmp_packfile_idx(repo, basename, &idx_tmp_name);
 
 	free(idx_tmp_name);
 }
 
-static void flush_bulk_checkin_packfile(struct bulk_checkin_packfile *state)
+static void flush_bulk_checkin_packfile(struct bulk_checkin_packfile *state,
+					struct repository *repo)
 {
 	unsigned char hash[GIT_MAX_RAWSZ];
 	struct strbuf packname = STRBUF_INIT;
@@ -73,15 +75,15 @@ static void flush_bulk_checkin_packfile(struct bulk_checkin_packfile *state)
 				  CSUM_HASH_IN_STREAM | CSUM_FSYNC | CSUM_CLOSE);
 	} else {
 		int fd = finalize_hashfile(state->f, hash, FSYNC_COMPONENT_PACK, 0);
-		fixup_pack_header_footer(the_hash_algo, fd, hash, state->pack_tmp_name,
+		fixup_pack_header_footer(repo->hash_algo, fd, hash, state->pack_tmp_name,
 					 state->nr_written, hash,
 					 state->offset);
 		close(fd);
 	}
 
-	strbuf_addf(&packname, "%s/pack/pack-%s.", repo_get_object_directory(the_repository),
-		    hash_to_hex(hash));
-	finish_tmp_packfile(&packname, state->pack_tmp_name,
+	strbuf_addf(&packname, "%s/pack/pack-%s.", repo_get_object_directory(repo),
+		    hash_to_hex_algop(hash, repo->hash_algo));
+	finish_tmp_packfile(repo, &packname, state->pack_tmp_name,
 			    state->written, state->nr_written,
 			    &state->pack_idx_opts, hash);
 	for (uint32_t i = 0; i < state->nr_written; i++)
@@ -94,7 +96,7 @@ static void flush_bulk_checkin_packfile(struct bulk_checkin_packfile *state)
 
 	strbuf_release(&packname);
 	/* Make objects we just wrote available to ourselves */
-	reprepare_packed_git(the_repository);
+	reprepare_packed_git(repo);
 }
 
 /*
@@ -117,7 +119,8 @@ static void flush_batch_fsync(struct odb_transaction *transaction)
 	 * to ensure that the data in each new object file is durable before
 	 * the final name is visible.
 	 */
-	strbuf_addf(&temp_path, "%s/bulk_fsync_XXXXXX", repo_get_object_directory(the_repository));
+	strbuf_addf(&temp_path, "%s/bulk_fsync_XXXXXX",
+		    repo_get_object_directory(transaction->odb->repo));
 	temp = xmks_tempfile(temp_path.buf);
 	fsync_or_die(get_tempfile_fd(temp), get_tempfile_path(temp));
 	delete_tempfile(&temp);
@@ -131,10 +134,11 @@ static void flush_batch_fsync(struct odb_transaction *transaction)
 	transaction->objdir = NULL;
 }
 
-static int already_written(struct bulk_checkin_packfile *state, struct object_id *oid)
+static int already_written(struct bulk_checkin_packfile *state,
+			   struct repository *repo, struct object_id *oid)
 {
 	/* The object may already exist in the repository */
-	if (odb_has_object(the_repository->objects, oid,
+	if (odb_has_object(repo->objects, oid,
 			   HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))
 		return 1;
 
@@ -240,12 +244,13 @@ static int stream_blob_to_pack(struct bulk_checkin_packfile *state,
 
 /* Lazily create backing packfile for the state */
 static void prepare_to_stream(struct bulk_checkin_packfile *state,
+			      struct repository *repo,
 			      unsigned flags)
 {
 	if (!(flags & INDEX_WRITE_OBJECT) || state->f)
 		return;
 
-	state->f = create_tmp_packfile(the_repository, &state->pack_tmp_name);
+	state->f = create_tmp_packfile(repo, &state->pack_tmp_name);
 	reset_pack_idx_option(&state->pack_idx_opts);
 
 	/* Pretend we are going to write only one object */
@@ -255,6 +260,7 @@ static void prepare_to_stream(struct bulk_checkin_packfile *state,
 }
 
 static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
+				struct repository *repo,
 				struct object_id *result_oid,
 				int fd, size_t size,
 				const char *path, unsigned flags)
@@ -272,21 +278,21 @@ static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
 
 	header_len = format_object_header((char *)obuf, sizeof(obuf),
 					  OBJ_BLOB, size);
-	the_hash_algo->init_fn(&ctx);
+	repo->hash_algo->init_fn(&ctx);
 	git_hash_update(&ctx, obuf, header_len);
 
 	/* Note: idx is non-NULL when we are writing */
 	if ((flags & INDEX_WRITE_OBJECT) != 0) {
 		CALLOC_ARRAY(idx, 1);
 
-		prepare_to_stream(state, flags);
+		prepare_to_stream(state, repo, flags);
 		hashfile_checkpoint_init(state->f, &checkpoint);
 	}
 
 	already_hashed_to = 0;
 
 	while (1) {
-		prepare_to_stream(state, flags);
+		prepare_to_stream(state, repo, flags);
 		if (idx) {
 			hashfile_checkpoint(state->f, &checkpoint);
 			idx->offset = state->offset;
@@ -304,7 +310,7 @@ static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
 			BUG("should not happen");
 		hashfile_truncate(state->f, &checkpoint);
 		state->offset = checkpoint.offset;
-		flush_bulk_checkin_packfile(state);
+		flush_bulk_checkin_packfile(state, repo);
 		if (lseek(fd, seekback, SEEK_SET) == (off_t) -1)
 			return error("cannot seek back");
 	}
@@ -313,7 +319,7 @@ static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
 		return 0;
 
 	idx->crc32 = crc32_end(state->f);
-	if (already_written(state, result_oid)) {
+	if (already_written(state, repo, result_oid)) {
 		hashfile_truncate(state->f, &checkpoint);
 		state->offset = checkpoint.offset;
 		free(idx);
@@ -338,7 +344,7 @@ void prepare_loose_object_bulk_checkin(struct odb_transaction *transaction)
 	if (!transaction || transaction->objdir)
 		return;
 
-	transaction->objdir = tmp_objdir_create(the_repository, "bulk-fsync");
+	transaction->objdir = tmp_objdir_create(transaction->odb->repo, "bulk-fsync");
 	if (transaction->objdir)
 		tmp_objdir_replace_primary_odb(transaction->objdir, 0);
 }
@@ -361,20 +367,21 @@ void fsync_loose_object_bulk_checkin(struct odb_transaction *transaction,
 	}
 }
 
-int index_blob_bulk_checkin(struct odb_transaction *transaction,
+int index_blob_bulk_checkin(struct repository *repo,
+			    struct odb_transaction *transaction,
 			    struct object_id *oid, int fd, size_t size,
 			    const char *path, unsigned flags)
 {
 	int status;
 
 	if (transaction) {
-		status = deflate_blob_to_pack(&transaction->packfile, oid, fd,
-					      size, path, flags);
+		status = deflate_blob_to_pack(&transaction->packfile,
+					      repo, oid, fd, size, path, flags);
 	} else {
 		struct bulk_checkin_packfile state = { 0 };
 
-		status = deflate_blob_to_pack(&state, oid, fd, size, path, flags);
-		flush_bulk_checkin_packfile(&state);
+		status = deflate_blob_to_pack(&state, repo, oid, fd, size, path, flags);
+		flush_bulk_checkin_packfile(&state, repo);
 	}
 
 	return status;
@@ -398,7 +405,8 @@ void flush_odb_transaction(struct odb_transaction *transaction)
 		return;
 
 	flush_batch_fsync(transaction);
-	flush_bulk_checkin_packfile(&transaction->packfile);
+	flush_bulk_checkin_packfile(&transaction->packfile,
+				    transaction->odb->repo);
 }
 
 void end_odb_transaction(struct odb_transaction *transaction)
diff --git a/bulk-checkin.h b/bulk-checkin.h
index 16254ce6a70..ac8dbf3523f 100644
--- a/bulk-checkin.h
+++ b/bulk-checkin.h
@@ -28,7 +28,8 @@ void fsync_loose_object_bulk_checkin(struct odb_transaction *transaction,
  * binary blobs, they generally do not want to get any conversion, and
  * callers should avoid this code path when filters are requested.
  */
-int index_blob_bulk_checkin(struct odb_transaction *transaction,
+int index_blob_bulk_checkin(struct repository *repo,
+			    struct odb_transaction *transaction,
 			    struct object_id *oid, int fd, size_t size,
 			    const char *path, unsigned flags);
 
diff --git a/object-file.c b/object-file.c
index 1740aa2b2e3..35f33e466c2 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1263,7 +1263,8 @@ int index_fd(struct index_state *istate, struct object_id *oid,
 		ret = index_core(istate, oid, fd, xsize_t(st->st_size),
 				 type, path, flags);
 	else
-		ret = index_blob_bulk_checkin(the_repository->objects->transaction,
+		ret = index_blob_bulk_checkin(the_repository,
+					      the_repository->objects->transaction,
 					      oid, fd, xsize_t(st->st_size),
 					      path, flags);
 	close(fd);
-- 
2.51.0

