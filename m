Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966562DCC08
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 18:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758047391; cv=none; b=i1Y0Uq8LMUXBnehFTqb2f8Wg5lzfhGKaV5WJx78AqZWk5Hu/3R8ei6wrvtqMxrcIpYjQr6kZa9Ax3MKfKW+0c7VIXkDvgtrDeCQV57CDWdNLkZqCkPwv+FaQ4DMbpbl4aszE74dQAVr/xUKpblQ8MO5l89msLWx2aWPp8LHI1GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758047391; c=relaxed/simple;
	bh=/ifnclESHl7ehpIOHYZvCMQ51uKpXi12wdGiqU+iKx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GFn+3Efg96q+gY8xDKsyXnee4bn/LbGay8ERIqTtdQVD3mQuTVoMga8Rib+ZUyG7ac316pDWnwDOl5oYDZUBqdTG1CTkZi+xGrd/L812v0yBNqMdQJ23pspT0rRRYF3ZfKiEGDxm7q3cQYP0H1gZlPORNIsoFYBW6qv+PqydhOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b5aCPMsV; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5aCPMsV"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-3326d9ee5edso1985484fac.3
        for <git@vger.kernel.org>; Tue, 16 Sep 2025 11:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758047388; x=1758652188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bdxhqr8hqFJSrhTHYW0j3V6S9GD1EomirDlaRyx/ZBs=;
        b=b5aCPMsVE1elLU1rRDndQdL+z2n1+OOiAUE1LnYxWit5BEb2i04vJMt1ms6/GjqcU8
         tAYqNPdZSkJRr7KytTVwrnYBo+VfK6guLkrW76WFKSMfnKHvbxK9FuYBUAypZR2c19II
         DcyOqtOtxM70KM+VLIzihmObEYtC2GStHiR4rOOMsABnx5gaj3rm1EkRqS1tHuNGu1fo
         JPxFMF2xKS0DEqAzUvllG6qaJQop3GfroIBRNcj03CgFp1CTgUNgiVWA4vlO2aT2sf2w
         8S+CxJhFcHGOfOeWK9O3TL17gK85jwTJEmEzBa7lvtolzNiWAAD2tUkrmeu9wETsMKIY
         CwZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758047388; x=1758652188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bdxhqr8hqFJSrhTHYW0j3V6S9GD1EomirDlaRyx/ZBs=;
        b=fpZ4+CtTUhILh4mkGOlmVt99rILzUXc/A5b/kw1sOjcTiWdVaAw3q6yUprye4rhTK+
         Hlp6J7EJ2UiO+7yIxk6fO25ubW09tV6O1HbLLmyX1p2RmBzemkbLlWUMqJqtaPoCMDVc
         VP5lpjqMKrKxxxd60/1Mr0U8syfHGcyFofC8ffKM2Z+wQU8k94q8fHkdSRkigiAFs1ym
         +z3uR7IVaoh68OFzP+BX3ev2N2sv7a+wLo6eqLHZsC7/64b51sqS7vhGTdq1e7bEdPdi
         zCxZ9V79UTteY/idVPdcuM245+i0DT6F+9AsUThzxWOup+XLG5cDqCKr7scdIX1SYsjN
         S7Xg==
X-Gm-Message-State: AOJu0YzvNFids5mmTJD7msuwfifjqyTQyZo838OWvHLuIF/xAX0uQJ8a
	L3LyFPJC/AdSl95adEH+6UfDjR/BgiRVpE+mTVTSJmQ8J6I2LsuqYI6muj9e/g==
X-Gm-Gg: ASbGncuCTbvwVgumQCNgDamQekv0Md6lnlF5pmiPnzEH6J4d8Ubqf3tOyie5KEPz/Nm
	yRYRLa1fw3XExz2dImRhKE8q81aZGG0Uol8Qv4YXD9p4TSUxfjiPBbEFztrDN5Ug40cXt5eTZQe
	k5HIQiRDptncIzB8QLzfskZK5zwAV/7oOgpnkZSVMAIUKupano2F7yU/NYBtS/u8jqUFCTrqSpC
	9UXg39nrgKdwoyeYBgymdMJaVN9r2yT7nqkvk11zURQC5Tp3UMFi5TVYA9u8biPHP0DvhrxyIs8
	6ezu0nanZTkYG1CGcS6I1kLOYLJ/s4Bimx1EptuLiZiD9Zf9Q9Ia5JJIAw1c1R7iXxhSeIoxNio
	6WUMZVt9St73zGmytQrhZKdE3iN5+Q2Y=
X-Google-Smtp-Source: AGHT+IEGhurGsWy+z7PDuf2BmmDyA2JKxLvDu6BIR/HBrjnmJeaD6JCYsgRUVqcbZx0fc5vHUNGzpA==
X-Received: by 2002:a05:6871:2c20:b0:331:8dc2:914f with SMTP id 586e51a60fabf-3318dc2ab14mr6111254fac.44.1758047388097;
        Tue, 16 Sep 2025 11:29:48 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-32d32d5653fsm5003058fac.7.2025.09.16.11.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 11:29:47 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	me@ttaylorr.com,
	karthik.188@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 5/6] object-file: update naming from bulk-checkin
Date: Tue, 16 Sep 2025 13:29:37 -0500
Message-ID: <20250916182938.2193476-6-jltobler@gmail.com>
X-Mailer: git-send-email 2.51.0.193.g4975ec3473b
In-Reply-To: <20250916182938.2193476-1-jltobler@gmail.com>
References: <20250915202956.3784935-1-jltobler@gmail.com>
 <20250916182938.2193476-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the names of several functions and types relocated from the
bulk-checkin subsystem for better clarity. Also drop
finish_tmp_packfile() as a standalone function in favor of embedding it
in flush_packfile_transaction() directly.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 object-file.c | 80 +++++++++++++++++++++++----------------------------
 1 file changed, 36 insertions(+), 44 deletions(-)

diff --git a/object-file.c b/object-file.c
index 03f9931b83..8103a2bf41 100644
--- a/object-file.c
+++ b/object-file.c
@@ -667,7 +667,7 @@ void hash_object_file(const struct git_hash_algo *algo, const void *buf,
 	write_object_file_prepare(algo, buf, len, type, oid, hdr, &hdrlen);
 }
 
-struct bulk_checkin_packfile {
+struct transaction_packfile {
 	char *pack_tmp_name;
 	struct hashfile *f;
 	off_t offset;
@@ -682,10 +682,10 @@ struct odb_transaction {
 	struct object_database *odb;
 
 	struct tmp_objdir *objdir;
-	struct bulk_checkin_packfile packfile;
+	struct transaction_packfile packfile;
 };
 
-static void prepare_loose_object_bulk_checkin(struct odb_transaction *transaction)
+static void prepare_loose_object_transaction(struct odb_transaction *transaction)
 {
 	/*
 	 * We lazily create the temporary object directory
@@ -701,7 +701,7 @@ static void prepare_loose_object_bulk_checkin(struct odb_transaction *transactio
 		tmp_objdir_replace_primary_odb(transaction->objdir, 0);
 }
 
-static void fsync_loose_object_bulk_checkin(struct odb_transaction *transaction,
+static void fsync_loose_object_transaction(struct odb_transaction *transaction,
 					   int fd, const char *filename)
 {
 	/*
@@ -722,7 +722,7 @@ static void fsync_loose_object_bulk_checkin(struct odb_transaction *transaction,
 /*
  * Cleanup after batch-mode fsync_object_files.
  */
-static void flush_batch_fsync(struct odb_transaction *transaction)
+static void flush_loose_object_transaction(struct odb_transaction *transaction)
 {
 	struct strbuf temp_path = STRBUF_INIT;
 	struct tempfile *temp;
@@ -733,7 +733,7 @@ static void flush_batch_fsync(struct odb_transaction *transaction)
 	/*
 	 * Issue a full hardware flush against a temporary file to ensure
 	 * that all objects are durable before any renames occur. The code in
-	 * fsync_loose_object_bulk_checkin has already issued a writeout
+	 * fsync_loose_object_transaction has already issued a writeout
 	 * request, but it has not flushed any writeback cache in the storage
 	 * hardware or any filesystem logs. This fsync call acts as a barrier
 	 * to ensure that the data in each new object file is durable before
@@ -762,7 +762,7 @@ static void close_loose_object(struct odb_source *source,
 		goto out;
 
 	if (batch_fsync_enabled(FSYNC_COMPONENT_LOOSE_OBJECT))
-		fsync_loose_object_bulk_checkin(source->odb->transaction, fd, filename);
+		fsync_loose_object_transaction(source->odb->transaction, fd, filename);
 	else if (fsync_object_files > 0)
 		fsync_or_die(fd, filename);
 	else
@@ -940,7 +940,7 @@ static int write_loose_object(struct odb_source *source,
 	static struct strbuf filename = STRBUF_INIT;
 
 	if (batch_fsync_enabled(FSYNC_COMPONENT_LOOSE_OBJECT))
-		prepare_loose_object_bulk_checkin(source->odb->transaction);
+		prepare_loose_object_transaction(source->odb->transaction);
 
 	odb_loose_path(source, &filename, oid);
 
@@ -1029,7 +1029,7 @@ int stream_loose_object(struct odb_source *source,
 	int hdrlen;
 
 	if (batch_fsync_enabled(FSYNC_COMPONENT_LOOSE_OBJECT))
-		prepare_loose_object_bulk_checkin(source->odb->transaction);
+		prepare_loose_object_transaction(source->odb->transaction);
 
 	/* Since oid is not determined, save tmp file to odb path. */
 	strbuf_addf(&filename, "%s/", source->path);
@@ -1349,10 +1349,10 @@ static int already_written(struct odb_transaction *transaction,
 }
 
 /* Lazily create backing packfile for the state */
-static void prepare_to_stream(struct odb_transaction *transaction,
-			      unsigned flags)
+static void prepare_packfile_transaction(struct odb_transaction *transaction,
+					 unsigned flags)
 {
-	struct bulk_checkin_packfile *state = &transaction->packfile;
+	struct transaction_packfile *state = &transaction->packfile;
 	if (!(flags & INDEX_WRITE_OBJECT) || state->f)
 		return;
 
@@ -1381,7 +1381,7 @@ static void prepare_to_stream(struct odb_transaction *transaction,
  * status before calling us just in case we ask it to call us again
  * with a new pack.
  */
-static int stream_blob_to_pack(struct bulk_checkin_packfile *state,
+static int stream_blob_to_pack(struct transaction_packfile *state,
 			       struct git_hash_ctx *ctx, off_t *already_hashed_to,
 			       int fd, size_t size, const char *path,
 			       unsigned flags)
@@ -1457,28 +1457,13 @@ static int stream_blob_to_pack(struct bulk_checkin_packfile *state,
 	return 0;
 }
 
-static void finish_tmp_packfile(struct odb_transaction *transaction,
-				struct strbuf *basename,
-				unsigned char hash[])
+static void flush_packfile_transaction(struct odb_transaction *transaction)
 {
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
+	struct transaction_packfile *state = &transaction->packfile;
 	struct repository *repo = transaction->odb->repo;
 	unsigned char hash[GIT_MAX_RAWSZ];
 	struct strbuf packname = STRBUF_INIT;
+	char *idx_tmp_name = NULL;
 
 	if (!state->f)
 		return;
@@ -1503,11 +1488,16 @@ static void flush_bulk_checkin_packfile(struct odb_transaction *transaction)
 		    repo_get_object_directory(transaction->odb->repo),
 		    hash_to_hex_algop(hash, repo->hash_algo));
 
-	finish_tmp_packfile(transaction, &packname, hash);
+	stage_tmp_packfiles(repo, &packname, state->pack_tmp_name,
+			    state->written, state->nr_written, NULL,
+			    &state->pack_idx_opts, hash, &idx_tmp_name);
+	rename_tmp_packfile_idx(repo, &packname, &idx_tmp_name);
+
 	for (uint32_t i = 0; i < state->nr_written; i++)
 		free(state->written[i]);
 
 clear_exit:
+	free(idx_tmp_name);
 	free(state->pack_tmp_name);
 	free(state->written);
 	memset(state, 0, sizeof(*state));
@@ -1535,11 +1525,12 @@ static void flush_bulk_checkin_packfile(struct odb_transaction *transaction)
  * binary blobs, they generally do not want to get any conversion, and
  * callers should avoid this code path when filters are requested.
  */
-static int index_blob_bulk_checkin(struct odb_transaction *transaction,
-			    struct object_id *result_oid, int fd, size_t size,
-			    const char *path, unsigned flags)
+static int index_blob_packfile_transaction(struct odb_transaction *transaction,
+					   struct object_id *result_oid, int fd,
+					   size_t size, const char *path,
+					   unsigned flags)
 {
-	struct bulk_checkin_packfile *state = &transaction->packfile;
+	struct transaction_packfile *state = &transaction->packfile;
 	off_t seekback, already_hashed_to;
 	struct git_hash_ctx ctx;
 	unsigned char obuf[16384];
@@ -1560,14 +1551,14 @@ static int index_blob_bulk_checkin(struct odb_transaction *transaction,
 	if ((flags & INDEX_WRITE_OBJECT) != 0) {
 		CALLOC_ARRAY(idx, 1);
 
-		prepare_to_stream(transaction, flags);
+		prepare_packfile_transaction(transaction, flags);
 		hashfile_checkpoint_init(state->f, &checkpoint);
 	}
 
 	already_hashed_to = 0;
 
 	while (1) {
-		prepare_to_stream(transaction, flags);
+		prepare_packfile_transaction(transaction, flags);
 		if (idx) {
 			hashfile_checkpoint(state->f, &checkpoint);
 			idx->offset = state->offset;
@@ -1585,7 +1576,7 @@ static int index_blob_bulk_checkin(struct odb_transaction *transaction,
 			BUG("should not happen");
 		hashfile_truncate(state->f, &checkpoint);
 		state->offset = checkpoint.offset;
-		flush_bulk_checkin_packfile(transaction);
+		flush_packfile_transaction(transaction);
 		if (lseek(fd, seekback, SEEK_SET) == (off_t)-1)
 			return error("cannot seek back");
 	}
@@ -1632,9 +1623,10 @@ int index_fd(struct index_state *istate, struct object_id *oid,
 		struct odb_transaction *transaction;
 
 		transaction = begin_odb_transaction(the_repository->objects);
-		ret = index_blob_bulk_checkin(the_repository->objects->transaction,
-					      oid, fd, xsize_t(st->st_size),
-					      path, flags);
+		ret = index_blob_packfile_transaction(the_repository->objects->transaction,
+						      oid, fd,
+						      xsize_t(st->st_size),
+						      path, flags);
 		end_odb_transaction(transaction);
 	}
 
@@ -1996,8 +1988,8 @@ void end_odb_transaction(struct odb_transaction *transaction)
 	 */
 	ASSERT(transaction == transaction->odb->transaction);
 
-	flush_batch_fsync(transaction);
-	flush_bulk_checkin_packfile(transaction);
+	flush_loose_object_transaction(transaction);
+	flush_packfile_transaction(transaction);
 	transaction->odb->transaction = NULL;
 	free(transaction);
 }
-- 
2.51.0.193.g4975ec3473b

