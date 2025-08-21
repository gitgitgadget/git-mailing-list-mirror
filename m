Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2DE2EACFF
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 23:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755818581; cv=none; b=pMhLQOQ63HetwjSmS8UqHnNrPeFhc1bgdI+N29YFu3c7oxpe+c7FRXnWMF7UdVm3Ry+Ms0jPRlLL4Eedl1EyLkxQGx843zYz2fDnw/znY5tP7p5V5q8xFOBbtIE/VtvScAIrf03cmOcOaSD5XZHGtVfifKEBZJjDmFROnFtxX98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755818581; c=relaxed/simple;
	bh=059X+lyEQaLs6NXDzhfZDmizQTSij7teDGko7BCRUYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HfNuRw8ale1jqrgrwVHwmSZViIe/PDEG/uQ/4fvKFvdSclmRPLpc5U181AkTrWABaQzy1TxVExzjFi2M6+EIOkS0W7CwLfhZTjXZZRsMUrSxXBWqFP9qaDbeWZbWGAT3QSQPM8rpY9e+3nYNw4w1Ir/3L8TbKerSvNLDCOwD9AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FMkXhnvT; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMkXhnvT"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-30cce86052cso864101fac.1
        for <git@vger.kernel.org>; Thu, 21 Aug 2025 16:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755818578; x=1756423378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tQZGGxWXuaHBCasqySIhlw2Y30sqmPkSjYxRccGU9C4=;
        b=FMkXhnvToFkw1WYXhBlRRDxTx19zCTlnou1nV/pmte/5MbJxFb7cc75PNjY8g78rb+
         VO0EmF/KFeF5lWJtYvOAqBTjOI7r1DO8TD9Vlnha9v+mZx48y46Fk7Yg/STO1KoZlWdu
         ImjiogSexUIxGyfIn1wlRFvm526fkEGvLCfW0GW/ps36WpdJb9z8rWX7dfApGK04uaqL
         MdIFwSnnxh6V5FvSnAejAh29MA41nUlhzRlVOrewN6+wJDEBbASm3zlOjltRVTVMtHhK
         Cv8m6lBK2+fFiSRASiOcFisnBUiPP8+hpOc1psM/IgxeunffTi1jq61bKwFLp1HFoE1L
         +/gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755818578; x=1756423378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tQZGGxWXuaHBCasqySIhlw2Y30sqmPkSjYxRccGU9C4=;
        b=NV62z93w+ADrGlbKFdbvJ36WoK0meQpenqr3VMSq+Mlv8uwwaocy718ZywuUY6zObP
         l6W3B6GdkvVVEarcP2QNFmBceTN53+t1IWQl/C5ioOQ9oGy4QvAxDtpoZHIeLD1ClqNx
         ItkAVFOmFO34Ip+7P41EvIHeWMqm5A1RIX0QnAEOXe8FTLtZJZ/FJhnZ2ANs4Cr3p5R9
         8NIFJ0odq/xRwfpPglY6ikNHODMzCj4DP6pYvYD+ghZdDE4VGTl3ZaIVHSPNIK4UWxvA
         9/5BNzW5zJSYpOLmZNknuH3ZkXWrTl7aBCqmwp1V1NixNFHDESzXy2tDU3fMYKlPbsvH
         GQDw==
X-Gm-Message-State: AOJu0YyCHg4n4zGtv8zjYJQiZRFRKdt3dPvAXJb6apkB9MrDF0Y8A928
	zP3HSdOZ1Mgn6hMmasmxuUfA6u34dPKaz/8aLGT4mOQdLv2ZZxPtw/OiEfNb8eGa
X-Gm-Gg: ASbGnctm8cGvOFhHLWMGSlE+o8YT3UrcU+eB8zHx4B2KOqQ2tJNDykNONa1eNw6P0pE
	UyXDyI2lhi9QaE4t1qH9n13WTGALsSQN+FjlF+WHONgWK93aF7zIrsJQHaLudSI+y1tODbpqmHE
	zjBh6RIjO+whiqr4prK8iG5rnsWz8+U1stzR1a9YPVsv95dyl/iqN1GbhjRgZ4W6Ot0GgRLugkP
	SaCn1fhiZhS934tScdrhRLFzZCit7pOeTwM3lAv3AsysH/z4w90klBZN9I+YpRrB+c83dYJIdP9
	AYhFBjeybfsKPvIPBbyDCjLgH4ME8FzYVrIOVDu+S6HOWw4xgVrNuxAdGBrtM8QlejlM0tZoMXG
	RhTAmeYFS7X6muO7B7W9bQSqLsnnydrk=
X-Google-Smtp-Source: AGHT+IHrYTMlVECAfpnZqD3fR4OzsxKiSFwmovuSQg6oor8t1Q5nLvpAT5R/geeL+ytqco6tPi/1Mg==
X-Received: by 2002:a05:6870:9c8d:b0:2c2:4090:9e8 with SMTP id 586e51a60fabf-314dcbb8b8fmr453758fac.22.1755818577812;
        Thu, 21 Aug 2025 16:22:57 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7439204d621sm3759747a34.40.2025.08.21.16.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 16:22:57 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 4/4] bulk-checkin: use repository variable from transaction
Date: Thu, 21 Aug 2025 18:22:49 -0500
Message-ID: <20250821232249.319427-5-jltobler@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250821232249.319427-1-jltobler@gmail.com>
References: <20250820225531.1212935-1-jltobler@gmail.com>
 <20250821232249.319427-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bulk-checkin subsystem depends on `the_repository`. Adapt functions
and call sites to access the repository through `struct odb_transaction`
instead. The `USE_THE_REPOSITORY_VARIBALE` is still required as the
`pack_compression_level` and `pack_size_limit_cfg` globals are still
used.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 bulk-checkin.c | 84 ++++++++++++++++++++++++--------------------------
 1 file changed, 41 insertions(+), 43 deletions(-)

diff --git a/bulk-checkin.c b/bulk-checkin.c
index 0e3747640b9..8402d9637c3 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -38,25 +38,26 @@ struct odb_transaction {
 	struct bulk_checkin_packfile packfile;
 };
 
-static void finish_tmp_packfile(struct strbuf *basename,
-				const char *pack_tmp_name,
-				struct pack_idx_entry **written_list,
-				uint32_t nr_written,
-				struct pack_idx_option *pack_idx_opts,
+static void finish_tmp_packfile(struct odb_transaction *transaction,
+				struct strbuf *basename,
 				unsigned char hash[])
 {
+	struct bulk_checkin_packfile *state = &transaction->packfile;
+	struct repository *repo = transaction->odb->repo;
 	char *idx_tmp_name = NULL;
 
-	stage_tmp_packfiles(the_repository, basename, pack_tmp_name,
-			    written_list, nr_written, NULL, pack_idx_opts, hash,
-			    &idx_tmp_name);
-	rename_tmp_packfile_idx(the_repository, basename, &idx_tmp_name);
+	stage_tmp_packfiles(repo, basename, state->pack_tmp_name,
+			    state->written, state->nr_written, NULL,
+			    &state->pack_idx_opts, hash, &idx_tmp_name);
+	rename_tmp_packfile_idx(repo, basename, &idx_tmp_name);
 
 	free(idx_tmp_name);
 }
 
-static void flush_bulk_checkin_packfile(struct bulk_checkin_packfile *state)
+static void flush_bulk_checkin_packfile(struct odb_transaction *transaction)
 {
+	struct bulk_checkin_packfile *state = &transaction->packfile;
+	struct repository *repo = transaction->odb->repo;
 	unsigned char hash[GIT_MAX_RAWSZ];
 	struct strbuf packname = STRBUF_INIT;
 
@@ -73,17 +74,17 @@ static void flush_bulk_checkin_packfile(struct bulk_checkin_packfile *state)
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
-			    state->written, state->nr_written,
-			    &state->pack_idx_opts, hash);
+	strbuf_addf(&packname, "%s/pack/pack-%s.",
+		    transaction->odb->sources->path,
+		    hash_to_hex_algop(hash, repo->hash_algo));
+
+	finish_tmp_packfile(transaction, &packname, hash);
 	for (uint32_t i = 0; i < state->nr_written; i++)
 		free(state->written[i]);
 
@@ -94,7 +95,7 @@ static void flush_bulk_checkin_packfile(struct bulk_checkin_packfile *state)
 
 	strbuf_release(&packname);
 	/* Make objects we just wrote available to ourselves */
-	reprepare_packed_git(the_repository);
+	reprepare_packed_git(repo);
 }
 
 /*
@@ -117,7 +118,8 @@ static void flush_batch_fsync(struct odb_transaction *transaction)
 	 * to ensure that the data in each new object file is durable before
 	 * the final name is visible.
 	 */
-	strbuf_addf(&temp_path, "%s/bulk_fsync_XXXXXX", repo_get_object_directory(the_repository));
+	strbuf_addf(&temp_path, "%s/bulk_fsync_XXXXXX",
+		    transaction->odb->sources->path);
 	temp = xmks_tempfile(temp_path.buf);
 	fsync_or_die(get_tempfile_fd(temp), get_tempfile_path(temp));
 	delete_tempfile(&temp);
@@ -131,16 +133,17 @@ static void flush_batch_fsync(struct odb_transaction *transaction)
 	transaction->objdir = NULL;
 }
 
-static int already_written(struct bulk_checkin_packfile *state, struct object_id *oid)
+static int already_written(struct odb_transaction *transaction,
+			   struct object_id *oid)
 {
 	/* The object may already exist in the repository */
-	if (odb_has_object(the_repository->objects, oid,
+	if (odb_has_object(transaction->odb, oid,
 			   HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))
 		return 1;
 
 	/* Might want to keep the list sorted */
-	for (uint32_t i = 0; i < state->nr_written; i++)
-		if (oideq(&state->written[i]->oid, oid))
+	for (uint32_t i = 0; i < transaction->packfile.nr_written; i++)
+		if (oideq(&transaction->packfile.written[i]->oid, oid))
 			return 1;
 
 	/* This is a new object we need to keep */
@@ -239,13 +242,15 @@ static int stream_blob_to_pack(struct bulk_checkin_packfile *state,
 }
 
 /* Lazily create backing packfile for the state */
-static void prepare_to_stream(struct bulk_checkin_packfile *state,
+static void prepare_to_stream(struct odb_transaction *transaction,
 			      unsigned flags)
 {
+	struct bulk_checkin_packfile *state = &transaction->packfile;
 	if (!(flags & INDEX_WRITE_OBJECT) || state->f)
 		return;
 
-	state->f = create_tmp_packfile(the_repository, &state->pack_tmp_name);
+	state->f = create_tmp_packfile(transaction->odb->repo,
+				       &state->pack_tmp_name);
 	reset_pack_idx_option(&state->pack_idx_opts);
 
 	/* Pretend we are going to write only one object */
@@ -254,11 +259,12 @@ static void prepare_to_stream(struct bulk_checkin_packfile *state,
 		die_errno("unable to write pack header");
 }
 
-static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
-				struct object_id *result_oid,
-				int fd, size_t size,
-				const char *path, unsigned flags)
+int index_blob_bulk_checkin(struct odb_transaction *transaction,
+			    struct object_id *result_oid,
+			    int fd, size_t size,
+			    const char *path, unsigned flags)
 {
+	struct bulk_checkin_packfile *state = &transaction->packfile;
 	off_t seekback, already_hashed_to;
 	struct git_hash_ctx ctx;
 	unsigned char obuf[16384];
@@ -272,21 +278,21 @@ static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
 
 	header_len = format_object_header((char *)obuf, sizeof(obuf),
 					  OBJ_BLOB, size);
-	the_hash_algo->init_fn(&ctx);
+	transaction->odb->repo->hash_algo->init_fn(&ctx);
 	git_hash_update(&ctx, obuf, header_len);
 
 	/* Note: idx is non-NULL when we are writing */
 	if ((flags & INDEX_WRITE_OBJECT) != 0) {
 		CALLOC_ARRAY(idx, 1);
 
-		prepare_to_stream(state, flags);
+		prepare_to_stream(transaction, flags);
 		hashfile_checkpoint_init(state->f, &checkpoint);
 	}
 
 	already_hashed_to = 0;
 
 	while (1) {
-		prepare_to_stream(state, flags);
+		prepare_to_stream(transaction, flags);
 		if (idx) {
 			hashfile_checkpoint(state->f, &checkpoint);
 			idx->offset = state->offset;
@@ -304,7 +310,7 @@ static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
 			BUG("should not happen");
 		hashfile_truncate(state->f, &checkpoint);
 		state->offset = checkpoint.offset;
-		flush_bulk_checkin_packfile(state);
+		flush_bulk_checkin_packfile(transaction);
 		if (lseek(fd, seekback, SEEK_SET) == (off_t) -1)
 			return error("cannot seek back");
 	}
@@ -313,7 +319,7 @@ static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
 		return 0;
 
 	idx->crc32 = crc32_end(state->f);
-	if (already_written(state, result_oid)) {
+	if (already_written(transaction, result_oid)) {
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
@@ -361,14 +367,6 @@ void fsync_loose_object_bulk_checkin(struct odb_transaction *transaction,
 	}
 }
 
-int index_blob_bulk_checkin(struct odb_transaction *transaction,
-			    struct object_id *oid, int fd, size_t size,
-			    const char *path, unsigned flags)
-{
-	return deflate_blob_to_pack(&transaction->packfile, oid, fd, size, path,
-				    flags);
-}
-
 struct odb_transaction *begin_odb_transaction(struct object_database *odb)
 {
 	if (!odb->transaction) {
@@ -387,7 +385,7 @@ void flush_odb_transaction(struct odb_transaction *transaction)
 		return;
 
 	flush_batch_fsync(transaction);
-	flush_bulk_checkin_packfile(&transaction->packfile);
+	flush_bulk_checkin_packfile(transaction);
 }
 
 void end_odb_transaction(struct odb_transaction *transaction)
-- 
2.51.0

