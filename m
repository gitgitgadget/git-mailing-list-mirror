Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A0228690
	for <git@vger.kernel.org>; Tue,  3 Feb 2026 00:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770077417; cv=none; b=SS9Wj48+DXhrDh64232TstY7Nkrv6s3kLa9oz5O5Yb+RLnoLvJJ/8YlcjcomXPntm2/ICzbbxI7tr3dXIS23lkY8IQCI7EG4vHTEOLH506ABHQomQdWDEsHhpy2c81LMepEpq4IR36Bvt3uo4biv+CGVAb5Ps8/mOSxw+usVVIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770077417; c=relaxed/simple;
	bh=s+yh6gpx1y2zBZDla5o4I2aiQL/9Y8VOULQAlcNRTs8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hUXVRDlMl7Js4sHEVaAqDz4+cFzQZ2lx8thUATWikcIm4Ke8fWXFYaJvRsxT3m2LqZRracwS49CPyUTO6H67gRRGExd07EMkrXbQ0TKdZqGcO1JTmJrP9vgeVAxZCFi+urlkmpIcBMzJv5fARi7csCxW0H91isv4Bq8WDAa6qnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y8rqOmBe; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8rqOmBe"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-45f0c1f1b54so3033271b6e.1
        for <git@vger.kernel.org>; Mon, 02 Feb 2026 16:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770077414; x=1770682214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sI0OnD8AM1K3Y50zmnaE8NqWik7wncV9nn1ZQraut9Y=;
        b=Y8rqOmBew93Vvkr5BlGJlMFro2AKoGK3iDUFj/E+z6dQtrfQgDRdjegufkbz50NOBu
         sD7Q+kebouBBIul0MFTyDH43nWwaP+LFleLpr9wWJEwgB6KiDDMN3UrKI/4J6Ky7F/Ru
         kXnK66S0J6iJ10w5gvJYesRUGs4k5w1G57+X26FKkghQTVAYJhCVmoeFAiq2oBcOT+6F
         xE8zj4Nabop861XWwkft766Fn+Yz7m0na78W+ZNl3EzyPsMpn2FIWbJehprrrytwPitw
         PXyJEB4WfxORwEXui2MliZrXfGk4Yrxwg+6bheQOVjAiQPLCHnKHmC7zPPavU25638OI
         b4Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770077414; x=1770682214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sI0OnD8AM1K3Y50zmnaE8NqWik7wncV9nn1ZQraut9Y=;
        b=DbY8E/gsoEH3JgQy0xwmV1XYiIMbjjY8dqwjh9UiXJ/ARkUyFd9VGAFrYJYhYv8FpV
         NSssNDpvtxK+0N/As+DduDm2D8iuYL6dSTuqtY3zCNHk5Oj9Ej/O7Wj/KcHGR0yFQlH/
         m7D1L3uHnRI490TBVUuXbMfiQTdR3R5N4bn7ryEvZPl6gW7zrZrZnK1g3q1d0koCIhcQ
         O5c8LGc/9EmOvEuKz2NTk0/VOBwGi++07XiuvCzzpATTAGbf1pgUtmmNFyHBxRSoPS6V
         TlQkFKzfykjtgzrGRaeVjhweUednSXP4uVaBAjVbsrmJTh78QcVvw1QhaLG3m/pLXFjM
         5zrg==
X-Gm-Message-State: AOJu0YzDgwGKeiP8Rh9uaNMH14s+98HeIR9USWNNyeclzv4nw0vdgjJB
	u9e7UNQ1FeiEu8KHvwMw7Rh9bgbUQf1ny65O7JjN/74KiOliySLt+WpY0/GFJQ==
X-Gm-Gg: AZuq6aLLx8Oo3mRyuVG6Dy/IUhHV+a/vANQjDTnrj1IBrErWgDObxHVG120xhw97Xac
	OarFZKkBLMw2VQCB/rnti10g8uuCRiLTRiV44q4rBiEE2ngJDiqTZ7obyWxw+SnlTSHgHlvCOC+
	cji5/3BlIVGnO0ETPhe0ysH3BblOckgD+JonAc2f+VyZEfFdmc4mChUK1weUHTG50ZbUXpx0STn
	bEO2jtqOl2lPSbi7/kzIxtcSeAVVv8Ln/7h+1N+ehp5BA/mp4aFZmhnNgUOIwIRM+sgiYqg+F3f
	2w2haUrptjFs/C3SNYkEOjMePVadmp7oOHpWpa6qU3FtnWrFOSBCUHLzircfc+39M9gbm/YPoJN
	llBUqw2BoLKyRIWN7clIB+z3GZ/Bk9shRCSW5sD7buK09BT/3cOpgAucLTQVyy0JdUrcgBUFgfa
	NEKjC4U6UgqNYVLt4fHlE=
X-Received: by 2002:a05:6808:6b8b:b0:45c:7b2c:10ca with SMTP id 5614622812f47-45f34b2feefmr7646674b6e.13.1770077414022;
        Mon, 02 Feb 2026 16:10:14 -0800 (PST)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45f08f6010esm9851179b6e.15.2026.02.02.16.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 16:10:13 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 3/4] odb: prepare `struct odb_transaction` to become generic
Date: Mon,  2 Feb 2026 18:10:01 -0600
Message-ID: <20260203001002.2500198-4-jltobler@gmail.com>
X-Mailer: git-send-email 2.52.0.373.g68cb7f9e92
In-Reply-To: <20260203001002.2500198-1-jltobler@gmail.com>
References: <20260128234519.2721179-1-jltobler@gmail.com>
 <20260203001002.2500198-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An ODB transaction handles how objects are stored temporarily and
eventually committed. Due to object storage being implemented
differently for a given ODB source, the ODB transactions must be
implemented in a manner specific to the source the objects are being
written to. To provide generic transactions, `struct odb_transaction` is
updated to store a commit callback that can be configured to support a
specific ODB source. For now `struct odb_transaction_files` is the
only transaction type and what is always returned when starting a
transaction.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 object-file.c | 80 ++++++++++++++++++++++++++++-----------------------
 object-file.h |  6 ----
 odb.c         |  5 +++-
 odb.h         | 17 +++++++++++
 4 files changed, 65 insertions(+), 43 deletions(-)

diff --git a/object-file.c b/object-file.c
index 7b34a2b274..d7e153c1b9 100644
--- a/object-file.c
+++ b/object-file.c
@@ -710,15 +710,17 @@ struct transaction_packfile {
 	uint32_t nr_written;
 };
 
-struct odb_transaction {
-	struct odb_source *source;
+struct odb_transaction_files {
+	struct odb_transaction base;
 
 	struct tmp_objdir *objdir;
 	struct transaction_packfile packfile;
 };
 
-static void prepare_loose_object_transaction(struct odb_transaction *transaction)
+static void prepare_loose_object_transaction(struct odb_transaction *base)
 {
+	struct odb_transaction_files *transaction = (struct odb_transaction_files *)base;
+
 	/*
 	 * We lazily create the temporary object directory
 	 * the first time an object might be added, since
@@ -728,14 +730,16 @@ static void prepare_loose_object_transaction(struct odb_transaction *transaction
 	if (!transaction || transaction->objdir)
 		return;
 
-	transaction->objdir = tmp_objdir_create(transaction->source->odb->repo, "bulk-fsync");
+	transaction->objdir = tmp_objdir_create(base->source->odb->repo, "bulk-fsync");
 	if (transaction->objdir)
 		tmp_objdir_replace_primary_odb(transaction->objdir, 0);
 }
 
-static void fsync_loose_object_transaction(struct odb_transaction *transaction,
+static void fsync_loose_object_transaction(struct odb_transaction *base,
 					   int fd, const char *filename)
 {
+	struct odb_transaction_files *transaction = (struct odb_transaction_files *)base;
+
 	/*
 	 * If we have an active ODB transaction, we issue a call that
 	 * cleans the filesystem page cache but avoids a hardware flush
@@ -754,7 +758,7 @@ static void fsync_loose_object_transaction(struct odb_transaction *transaction,
 /*
  * Cleanup after batch-mode fsync_object_files.
  */
-static void flush_loose_object_transaction(struct odb_transaction *transaction)
+static void flush_loose_object_transaction(struct odb_transaction_files *transaction)
 {
 	struct strbuf temp_path = STRBUF_INIT;
 	struct tempfile *temp;
@@ -772,7 +776,7 @@ static void flush_loose_object_transaction(struct odb_transaction *transaction)
 	 * the final name is visible.
 	 */
 	strbuf_addf(&temp_path, "%s/bulk_fsync_XXXXXX",
-		    repo_get_object_directory(transaction->source->odb->repo));
+		    repo_get_object_directory(transaction->base.source->odb->repo));
 	temp = xmks_tempfile(temp_path.buf);
 	fsync_or_die(get_tempfile_fd(temp), get_tempfile_path(temp));
 	delete_tempfile(&temp);
@@ -1340,11 +1344,11 @@ static int index_core(struct index_state *istate,
 	return ret;
 }
 
-static int already_written(struct odb_transaction *transaction,
+static int already_written(struct odb_transaction_files *transaction,
 			   struct object_id *oid)
 {
 	/* The object may already exist in the repository */
-	if (odb_has_object(transaction->source->odb, oid,
+	if (odb_has_object(transaction->base.source->odb, oid,
 			   HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))
 		return 1;
 
@@ -1358,14 +1362,14 @@ static int already_written(struct odb_transaction *transaction,
 }
 
 /* Lazily create backing packfile for the state */
-static void prepare_packfile_transaction(struct odb_transaction *transaction,
+static void prepare_packfile_transaction(struct odb_transaction_files *transaction,
 					 unsigned flags)
 {
 	struct transaction_packfile *state = &transaction->packfile;
 	if (!(flags & INDEX_WRITE_OBJECT) || state->f)
 		return;
 
-	state->f = create_tmp_packfile(transaction->source->odb->repo,
+	state->f = create_tmp_packfile(transaction->base.source->odb->repo,
 				       &state->pack_tmp_name);
 	reset_pack_idx_option(&state->pack_idx_opts);
 
@@ -1466,10 +1470,10 @@ static int stream_blob_to_pack(struct transaction_packfile *state,
 	return 0;
 }
 
-static void flush_packfile_transaction(struct odb_transaction *transaction)
+static void flush_packfile_transaction(struct odb_transaction_files *transaction)
 {
 	struct transaction_packfile *state = &transaction->packfile;
-	struct repository *repo = transaction->source->odb->repo;
+	struct repository *repo = transaction->base.source->odb->repo;
 	unsigned char hash[GIT_MAX_RAWSZ];
 	struct strbuf packname = STRBUF_INIT;
 	char *idx_tmp_name = NULL;
@@ -1494,7 +1498,7 @@ static void flush_packfile_transaction(struct odb_transaction *transaction)
 	}
 
 	strbuf_addf(&packname, "%s/pack/pack-%s.",
-		    repo_get_object_directory(transaction->source->odb->repo),
+		    repo_get_object_directory(transaction->base.source->odb->repo),
 		    hash_to_hex_algop(hash, repo->hash_algo));
 
 	stage_tmp_packfiles(repo, &packname, state->pack_tmp_name,
@@ -1534,7 +1538,7 @@ static void flush_packfile_transaction(struct odb_transaction *transaction)
  * binary blobs, they generally do not want to get any conversion, and
  * callers should avoid this code path when filters are requested.
  */
-static int index_blob_packfile_transaction(struct odb_transaction *transaction,
+static int index_blob_packfile_transaction(struct odb_transaction_files *transaction,
 					   struct object_id *result_oid, int fd,
 					   size_t size, const char *path,
 					   unsigned flags)
@@ -1553,7 +1557,7 @@ static int index_blob_packfile_transaction(struct odb_transaction *transaction,
 
 	header_len = format_object_header((char *)obuf, sizeof(obuf),
 					  OBJ_BLOB, size);
-	transaction->source->odb->repo->hash_algo->init_fn(&ctx);
+	transaction->base.source->odb->repo->hash_algo->init_fn(&ctx);
 	git_hash_update(&ctx, obuf, header_len);
 
 	/* Note: idx is non-NULL when we are writing */
@@ -1629,10 +1633,11 @@ int index_fd(struct index_state *istate, struct object_id *oid,
 		ret = index_core(istate, oid, fd, xsize_t(st->st_size),
 				 type, path, flags);
 	} else {
+		struct object_database *odb = the_repository->objects;
 		struct odb_transaction *transaction;
 
-		transaction = odb_transaction_begin(the_repository->objects);
-		ret = index_blob_packfile_transaction(the_repository->objects->transaction,
+		transaction = odb_transaction_begin(odb);
+		ret = index_blob_packfile_transaction((struct odb_transaction_files *)odb->transaction,
 						      oid, fd,
 						      xsize_t(st->st_size),
 						      path, flags);
@@ -1985,35 +1990,38 @@ int read_loose_object(struct repository *repo,
 	return ret;
 }
 
-struct odb_transaction *odb_transaction_files_begin(struct odb_source *source)
+static void odb_transaction_files_commit(struct odb_transaction *base)
 {
-	struct object_database *odb = source->odb;
-
-	if (odb->transaction)
-		return NULL;
-
-	CALLOC_ARRAY(odb->transaction, 1);
-	odb->transaction->source = source;
-
-	return odb->transaction;
-}
-
-void odb_transaction_files_commit(struct odb_transaction *transaction)
-{
-	if (!transaction)
-		return;
+	struct odb_transaction_files *transaction = (struct odb_transaction_files *)base;
 
 	/*
 	 * Ensure the transaction ending matches the pending transaction.
 	 */
-	ASSERT(transaction == transaction->source->odb->transaction);
+	ASSERT(base == base->source->odb->transaction);
 
 	flush_loose_object_transaction(transaction);
 	flush_packfile_transaction(transaction);
-	transaction->source->odb->transaction = NULL;
+	base->source->odb->transaction = NULL;
 	free(transaction);
 }
 
+struct odb_transaction *odb_transaction_files_begin(struct odb_source *source)
+{
+	struct odb_transaction_files *transaction;
+	struct object_database *odb = source->odb;
+
+	if (odb->transaction)
+		return NULL;
+
+	transaction = xcalloc(1, sizeof(*transaction));
+	transaction->base.source = source;
+	transaction->base.commit = odb_transaction_files_commit;
+
+	odb->transaction = &transaction->base;
+
+	return &transaction->base;
+}
+
 struct odb_source_loose *odb_source_loose_new(struct odb_source *source)
 {
 	struct odb_source_loose *loose;
diff --git a/object-file.h b/object-file.h
index b4a3341a89..a62d0de394 100644
--- a/object-file.h
+++ b/object-file.h
@@ -208,10 +208,4 @@ struct odb_transaction;
  */
 struct odb_transaction *odb_transaction_files_begin(struct odb_source *source);
 
-/*
- * Tell the object database to make any objects from the
- * current transaction visible.
- */
-void odb_transaction_files_commit(struct odb_transaction *transaction);
-
 #endif /* OBJECT_FILE_H */
diff --git a/odb.c b/odb.c
index a5e6fd01a9..349b4218a5 100644
--- a/odb.c
+++ b/odb.c
@@ -1158,5 +1158,8 @@ struct odb_transaction *odb_transaction_begin(struct object_database *odb)
 
 void odb_transaction_commit(struct odb_transaction *transaction)
 {
-	odb_transaction_files_commit(transaction);
+	if (!transaction)
+		return;
+
+	transaction->commit(transaction);
 }
diff --git a/odb.h b/odb.h
index bab07755f4..83d3a37805 100644
--- a/odb.h
+++ b/odb.h
@@ -77,7 +77,24 @@ struct odb_source {
 struct packed_git;
 struct packfile_store;
 struct cached_object_entry;
+
+/*
+ * A transaction may be started for an object database prior to writing new
+ * objects via odb_transaction_begin(). These objects are not committed until
+ * odb_transaction_commit() is invoked. Only a single transaction may be pending
+ * at a time.
+ *
+ * Each ODB source is expected to implement its own transaction handling.
+ */
 struct odb_transaction;
+typedef void (*odb_transaction_commit_fn)(struct odb_transaction *transaction);
+struct odb_transaction {
+	/* The ODB source the transaction is opened against. */
+	struct odb_source *source;
+
+	/* The ODB source specific callback invoked to commit a transaction. */
+	odb_transaction_commit_fn commit;
+};
 
 /*
  * The object database encapsulates access to objects in a repository. It
-- 
2.52.0.373.g68cb7f9e92

