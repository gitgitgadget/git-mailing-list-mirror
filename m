Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E06F1EE7C6
	for <git@vger.kernel.org>; Sun,  9 Aug 2026 19:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786302074; cv=none; b=oNfaust8Zp55UGPdZm+qMbXnYDdWb6EipmR8+sNA3f0vZ+8/UHuLQWNrae/T2RegSU/IxCWUCnZlUPXZc8jpDPVPzJDc9s6MdQuluCw3tBiZOZnJDGlzeGx/ZYfnq94fMAy0+kpuPZAYAVFF6adqxi5RRVaDtzcO1TjW52Z1nBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786302074; c=relaxed/simple;
	bh=kLLX+0uKwsTQbTvfZd5KRH1jdhjUL/hRwS7o2CJYZ3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Us+EWI4mKPfiSa9ly3tsskeO5KnXBXRIvkqH2ZwTVqpFstEJCMf1FQjpWZXwhyza+c8i8lA74BxJWsiBlk8rXtMayXQk0dgKDgzJgXknkJq78MJww2/EC0W9wj4YZLwbzhEI5Mri0ZzSaL+3rp7/xdaMT9jIBv8IJpUBj1wDftU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tD8n6CEv; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tD8n6CEv"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-4b1bf68b387so255365b6e.2
        for <git@vger.kernel.org>; Sun, 09 Aug 2026 12:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786302072; x=1786906872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MIhQ5R/NYbbeHDopZxu1zYmIxOvH54rBlelYUbmNE3A=;
        b=tD8n6CEv8Ssq0Y4RKM5C0UDNvV18Mbs2bTFTKXYfQs5CTXNubBmIBZ0D3TDqwuVYeZ
         A9FUC5nb23o+edxAtjLEhLRO+1wzDy0JOSFamCnb9MfjmsYHYnDmuaHKE+8LhJGLIMje
         /AVo4nmTHzGV8UV6TwGBy0jKqTnn60GoWqmTI9LuQoXGnCzdpMJYIRx39i9XIj2xJfjk
         YRB3ZtwaQpOVXyIAm7knb9nd+wqn8nfI1RmBGEvuyRoa//zhOfSbPi3sy2wKN7Qj4N04
         ss8orNKpyJRSVMlr/mm5gr+18LzLA1gBzZ6heYgTrpi8kRA5fUO1taJiTDaW3n8pPgiL
         GQ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786302072; x=1786906872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MIhQ5R/NYbbeHDopZxu1zYmIxOvH54rBlelYUbmNE3A=;
        b=Up9USvd85/vP+d6+AbUgWBAvy+yWCnOLSbUpJB7pOhSeSoh6UnzehZgfIOsGEKDnqC
         sNisw4gtf/eG3hCNAKyf8xmxFbC2Vazsc+IMHwCqW2lPyijMzBoAT52x3p4HDImaABAV
         fEe8CaMraAsHonvH6g8L/PaNoSmVtWHcOKeQ8MHrs802DZRmE7sYkB1VbZD8RaBlK/TY
         c2In68ohaLfozOQNPGNB06e+wBL612zzlBh9O3LoEpNcMVxULX1EGogZRUViC+4Y9t7b
         ejUaSQznJeWnKlj2mmYgSZ9FqdXSD+KPyhIravKswthO8AHuWb0e4X67z8Uu2mZhyqnF
         7b+A==
X-Gm-Message-State: AOJu0YxdfrxHU4aeGOJXwsgHz8HjV0qUWuc/mV2QnJ4RAROaDqhffX9l
	xHXIii2593yFV6h9H/SJchqQzUCLxJHeL5betOXAgYSm0/E9U27Z36zIfFNGSw==
X-Gm-Gg: AR+sD124mYATKmbjNevfosIs6DnzCF09xYXZVXrO0jr8FstbIrs5MF4k6zy/jFzlAVF
	051qBqs4Q75WHreh+d5RlEDKDvUsexpSSjr/unnJP0K6DWtSy1bHxbZIhZuJiNiagzxuRzkY6Bf
	RLEXwPw/nhp+2g/XJi5fumMKDf41CFQdOQk0gtb3JRfEABGRvWThUq0EqqSrAu5xs57RBpmArAN
	qCf0LJkbKfUogNu9b6r4DScK7J6QCNKdUS1MUuEVF36iyNx5zUdWhlBAQpfbaMDJQqlC82Iqjo+
	iZIErTiwabltijqblj20vXvSn22thwOufz+/MZkEUelprSwhTGTPapSLqck5FLyiFIMLH+nll1f
	yc7NUGSiGh5zCs8JGPp2KTOU49cxyUaxr94brSif57HPZqaPqBU8l0WqBe2mbtydkapzovFIbui
	41VSFm/2wW0QmFc49uc5rjTZaEs+HKFwqWSVBwgqwaxW8bevanfqswPU2CFftIo2O5RJkd
X-Received: by 2002:a05:6808:10cc:b0:497:d371:21c8 with SMTP id 5614622812f47-4b1aba98aa9mr10227318b6e.19.1786302071675;
        Sun, 09 Aug 2026 12:01:11 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b1af5e7b77sm4872188b6e.10.2026.08.09.12.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 12:01:11 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 1/7] odb/transaction: add transaction finalize interface
Date: Sun,  9 Aug 2026 14:01:00 -0500
Message-ID: <20260809190106.1565882-2-jltobler@gmail.com>
X-Mailer: git-send-email 2.55.0.424.g13c7afec21
In-Reply-To: <20260809190106.1565882-1-jltobler@gmail.com>
References: <20260806213859.816157-1-jltobler@gmail.com>
 <20260809190106.1565882-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When committing an ODB transaction via `odb_transaction_commit()`, the
staged objects are made visible and the underlying transaction is freed
at the same time. Coupling these two steps does not leave room for any
post-commit transaction operations to be introduced though. Such a
capability is useful if an ODB transaction backend needs to hold on to
lockfiles after transaction commit until references are updated, as is
the case with the existing "files" backend in git-receive-pack(1).

Stop freeing the transaction in `odb_transaction_commit()` and introduce
`odb_transaction_finalize()` to explicitly clean up the transaction
accordingly. Note that the finalize interface also provides an optional
callback for any backend-specific deferred cleanup. In a subsequent
commit, the "files" transaction backend will use this to remove ".keep"
files generated for packfiles received via git-receive-pack(1) after
references have been updated. In preparation for this, the
`odb_transaction_finalize()` call site in git-receive-pack(1) is made
after the reference updates are finished.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 builtin/add.c            |  3 ++-
 builtin/receive-pack.c   |  1 +
 builtin/unpack-objects.c |  1 +
 builtin/update-index.c   |  2 ++
 cache-tree.c             |  4 +++-
 object-file.c            |  4 +++-
 odb/transaction.c        | 14 ++++++++++++++
 odb/transaction.h        | 15 +++++++++++++++
 read-cache.c             |  4 +++-
 9 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 60ffbede2b..501e114ed5 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -393,7 +393,7 @@ int cmd_add(int argc,
 	char *seen = NULL;
 	char *ps_matched = NULL;
 	struct lock_file lock_file = LOCK_INIT;
-	struct odb_transaction *transaction;
+	struct odb_transaction *transaction = NULL;
 
 	repo_config(repo, add_config, NULL);
 
@@ -610,5 +610,6 @@ int cmd_add(int argc,
 	free(ps_matched);
 	dir_clear(&dir);
 	clear_pathspec(&pathspec);
+	odb_transaction_finalize(transaction);
 	return exit_status;
 }
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 86933d8d7e..8720281250 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -2714,6 +2714,7 @@ int cmd_receive_pack(int argc,
 		use_keepalive = KEEPALIVE_ALWAYS;
 		execute_commands(commands, unpack_status, &si, transaction,
 				 &push_options);
+		odb_transaction_finalize(transaction);
 		delete_tempfile(&pack_lockfile);
 		sigchain_push(SIGPIPE, SIG_IGN);
 		if (report_status_v2)
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 4263edfbec..aee68dc42d 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -604,6 +604,7 @@ static void unpack_all(void)
 		display_progress(progress, i + 1);
 	}
 	odb_transaction_commit(transaction);
+	odb_transaction_finalize(transaction);
 	stop_progress(&progress);
 
 	if (delta_list)
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 241abd4332..e422342f52 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1157,6 +1157,7 @@ int cmd_update_index(int argc,
 			 */
 			if (transaction && verbose) {
 				odb_transaction_commit(transaction);
+				odb_transaction_finalize(transaction);
 				transaction = NULL;
 			}
 
@@ -1225,6 +1226,7 @@ int cmd_update_index(int argc,
 	 * By now we have added all of the new objects
 	 */
 	odb_transaction_commit(transaction);
+	odb_transaction_finalize(transaction);
 
 	if (split_index > 0) {
 		if (repo_config_get_split_index(the_repository) == 0)
diff --git a/cache-tree.c b/cache-tree.c
index d92f513286..cff1d4fd48 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -537,8 +537,10 @@ int cache_tree_update(struct index_state *istate, int flags)
 		odb_transaction_begin_or_die(the_repository->objects, &transaction, 0);
 	i = update_one(istate->cache_tree, istate->cache, istate->cache_nr,
 		       "", 0, &skip, flags);
-	if (!inflight)
+	if (!inflight) {
 		odb_transaction_commit(transaction);
+		odb_transaction_finalize(transaction);
+	}
 	trace2_region_leave("cache_tree", "update", istate->repo);
 	trace_performance_leave("cache_tree_update");
 	if (i < 0)
diff --git a/object-file.c b/object-file.c
index ec35c318bc..f993d58056 100644
--- a/object-file.c
+++ b/object-file.c
@@ -964,8 +964,10 @@ int index_fd(struct index_state *istate, struct object_id *oid,
 								  &stream,
 								  xsize_t(st->st_size),
 								  oid);
-			if (!inflight)
+			if (!inflight) {
 				odb_transaction_commit(transaction);
+				odb_transaction_finalize(transaction);
+			}
 		} else {
 			ret = hash_blob_stream(&stream,
 					       the_repository->hash_algo, oid,
diff --git a/odb/transaction.c b/odb/transaction.c
index dab7da6a9a..9e9a982778 100644
--- a/odb/transaction.c
+++ b/odb/transaction.c
@@ -33,6 +33,20 @@ int odb_transaction_commit(struct odb_transaction *transaction)
 
 	ret = transaction->commit(transaction);
 	transaction->source->odb->transaction = NULL;
+
+	return ret;
+}
+
+int odb_transaction_finalize(struct odb_transaction *transaction)
+{
+	int ret = 0;
+
+	if (!transaction)
+		return 0;
+
+	if (transaction->finalize)
+		ret = transaction->finalize(transaction);
+
 	free(transaction);
 
 	return ret;
diff --git a/odb/transaction.h b/odb/transaction.h
index 4cb2eafcbf..89f6902caf 100644
--- a/odb/transaction.h
+++ b/odb/transaction.h
@@ -22,6 +22,13 @@ struct odb_transaction {
 	 */
 	int (*commit)(struct odb_transaction *transaction);
 
+	/*
+	 * Optional ODB source specific callback invoked when the transaction
+	 * needs to perform any deferred cleanup after objects have been
+	 * committed. Returns 0 on success, a negative error code otherwise.
+	 */
+	int (*finalize)(struct odb_transaction *transaction);
+
 	/*
 	 * This callback is expected to write the given object stream into
 	 * the ODB transaction. Note that for now, only blobs support streaming.
@@ -75,6 +82,14 @@ static inline void odb_transaction_begin_or_die(struct object_database *odb,
  */
 int odb_transaction_commit(struct odb_transaction *transaction);
 
+/*
+ * Finalizes an ODB transaction, performing any deferred cleanup and freeing it.
+ * Must be called for every successfully started transaction. Note that, if the
+ * specified transaction is NULL, the function is a no-op. Returns 0 on success,
+ * a negative error code otherwise.
+ */
+int odb_transaction_finalize(struct odb_transaction *transaction);
+
 /*
  * Writes the object in the provided stream into the transaction. The resulting
  * object ID is written into the out pointer. Returns 0 on success, a negative
diff --git a/read-cache.c b/read-cache.c
index 6c449f393d..9a3ac4646f 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -4048,8 +4048,10 @@ int add_files_to_cache(struct repository *repo, const char *prefix,
 	if (!inflight)
 		odb_transaction_begin_or_die(repo->objects, &transaction, 0);
 	run_diff_files(&rev, DIFF_RACY_IS_MODIFIED);
-	if (!inflight)
+	if (!inflight) {
 		odb_transaction_commit(transaction);
+		odb_transaction_finalize(transaction);
+	}
 
 	release_revisions(&rev);
 	return !!data.add_errors;
-- 
2.55.0.424.g13c7afec21

