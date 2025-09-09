Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF7935CED2
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 19:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757445114; cv=none; b=t+THs4l8MBDiprnKh8DJ3cNUw8vZWnsV6gsVVGG1vJfH3n3qZj8hD5VcU0tYg+gUDtA5q36CPSKMZLu8UHGHDkPyMcXPGiW3wRMnHZOBsTY9cWFdRayvK9mPYTX5VD+i22S2M0X1LtAhyfWVHN4Uk+p7sFkrbl0O0HFDJUbnvaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757445114; c=relaxed/simple;
	bh=TG7rTv10DzOIUw421UpOndCo6LJtstMxBAkWjWVi88g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FHcoWVceGMl85/kAp5dG7m/WfJ9w0SBBYSJgTtqPjcAnqGY0+YxlF3dqGVqm0X/yvLJd3fL29nH3UU7PSpBwxXRlyn4modR5phJxb/pcztG6Mdebc2H3q3WweH5NWpjQ97Vx+5TdGMDsbVd/qw56As8EFe3IqmeVw67OA41mxvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=in+UL/Mt; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="in+UL/Mt"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-74c1251df00so2126161a34.0
        for <git@vger.kernel.org>; Tue, 09 Sep 2025 12:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757445111; x=1758049911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cqzGFlnEFgzibkHioce9MzZSuIHkc0upnmGNYeD665g=;
        b=in+UL/MtSHoDiBod1fJE3ec4dHMgZ2pEv3qoG7vFpjuKM+YcHNb2DD7AegAut/mLGb
         UV1FWTefrlAw3V1C2LsjXbqBzSQv5HUzMPGJtsXFqmDtcIQeFcQsK4aGPn9T5Ba46EW3
         VLdbKxdl7uadItzVtEyXcCDnLis0bXpXM7hYYuiiqt2xP5CSa6iNdULEzkaJj5/Ajnrw
         2EWfr4I0nzGzIV6XRm2MmeKEa3IgZIO3JjgJxhEY+EekFqk3JH/Vjz0qibu+gibSwoFg
         FZmwF9eJsQ9oOXArpb1xEkT3bHsA5r2+gvmB0WQGNMATU2gdLpqhiPh9gXoYSYfMlZl5
         71Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757445111; x=1758049911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cqzGFlnEFgzibkHioce9MzZSuIHkc0upnmGNYeD665g=;
        b=H3lKltlixhFJSwysEKZmpNFTXFiuRGPhey0pmum7K9oz8KVNZnRbvvxgTGzIAjKrNh
         ZVUoY+GdmAvd2Fxq4Hy1rrteEqjhg5tTLBxNSnbA7WmrciqCFCRiAvvbjdmbGsoaTKJh
         C1q5WxfJ4orfzA6joF8zJrKTTSxi1TQUJrp2DrJWXfoJ3zW6KJUGqxgs3E/NKb5yNWER
         elamS+kFjEevYQkmQ1IsoEPouTlNPL9chpmtqHZ0O00AbCcc2ajBBPs0zmTwwK7INklG
         v0zChOgA6lZlbo/SZJ7HzyJv/6DvG9Ux/p848O4SEX8zV0Drm1Qw2Xvz0WxX8fWeiAB9
         KDYg==
X-Gm-Message-State: AOJu0YxgR6WHMIAxkLOWy5UlO900lRpGAGtMWa8/KGQHISw9H5Sm00ne
	Te+2h2sE+AMoQddmE9HRAFfcQCYLUaHWHKDqZSHdur+4Y/i0LFm95UJj3HL5Yg==
X-Gm-Gg: ASbGncspWKxc5A+/L3hZRlRy7qMCdIUrBbMY0/2A4Jf1yJXCWULpPL15rHZxE6IQG4f
	49ZZnUYrKdcOjUa8QYP4MAbMCk72rzDbwEUG2uHx9AlaIeqbEf4uHHe0ZsLworgm5FjFZdQqUVH
	n90f4KH1aff57gz2UDb0GeMJzJIcIfZep5wHHGTIZFxxjWABNvUHwooiKue7L+OgwHC3OQdQEmC
	XxXDfDxoAJm7ZwturxhEsa6/mJVV20YboaeGGWnMFlWiV04VrhgXDmYHd15bykBdcW9R5qKh/ol
	zml1NdGF/KRDOQZ9roW3xnTBk7K3vmv97nAeqW2pLM07yxFHRMHVPYG9+LaK9B3xZWKAG6P5nRs
	jQgL1gaAf0adWRzsi8hNrHFgAAK0ZCxpI74qOyYt6gQ==
X-Google-Smtp-Source: AGHT+IHK6yZIPTZXukrBsD+AG1JyX7xABdt6iUDH9LsnlZDGmGL+p9QyFxwpQSm8BqpcoOtAXDY9Mw==
X-Received: by 2002:a05:6830:7007:b0:746:dc05:85ee with SMTP id 46e09a7af769-74c74fbf6b6mr7627403a34.19.1757445110831;
        Tue, 09 Sep 2025 12:11:50 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-74cc5a69b95sm3062627a34.39.2025.09.09.12.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 12:11:50 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 5/6] object-file: update naming from bulk-checkin
Date: Tue,  9 Sep 2025 14:11:33 -0500
Message-ID: <20250909191134.555689-6-jltobler@gmail.com>
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

Update the names of several functions and types relocated from the
bulk-checkin subsystem for better clarity. Also drop
finish_tmp_packfile() as a standalone function in favor of embedding it
in flush_packfile_transaction() directly.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 object-file.c | 80 +++++++++++++++++++++++----------------------------
 1 file changed, 36 insertions(+), 44 deletions(-)

diff --git a/object-file.c b/object-file.c
index 2ef94d9d1f1..91fddfc4984 100644
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
@@ -1634,9 +1625,10 @@ int index_fd(struct index_state *istate, struct object_id *oid,
 		if (!the_repository->objects->transaction)
 			transaction = begin_odb_transaction(the_repository->objects);
 
-		ret = index_blob_bulk_checkin(the_repository->objects->transaction,
-					      oid, fd, xsize_t(st->st_size),
-					      path, flags);
+		ret = index_blob_packfile_transaction(the_repository->objects->transaction,
+						      oid, fd,
+						      xsize_t(st->st_size),
+						      path, flags);
 
 		if (transaction)
 			end_odb_transaction(transaction);
@@ -1992,8 +1984,8 @@ struct odb_transaction *begin_odb_transaction(struct object_database *odb)
 
 void end_odb_transaction(struct odb_transaction *transaction)
 {
-	flush_batch_fsync(transaction);
-	flush_bulk_checkin_packfile(transaction);
+	flush_loose_object_transaction(transaction);
+	flush_packfile_transaction(transaction);
 	transaction->odb->transaction = NULL;
 	free(transaction);
 }
-- 
2.51.0.193.g4975ec3473b

