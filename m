Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A54933556D
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 17:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786470868; cv=none; b=poa5si7LTF32FTZlNC3SMddEYozNHFYIb4cpw/WPYT+yxASDKzqPfQzg688XDJ1XPYUCanNSSFihTX9N8liSWmhtHAxRgmexSzi4u2ZYRPwxR4i/G/ZX7F0gxrxnsfQFE2SiM3BWK80x8A5xgyACwaTa6hInTjilpxpdZ0H5vmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786470868; c=relaxed/simple;
	bh=w19Zm1XBRwzZ4F5NgsFWvfCoCgAYBsHrghg4ar0vwyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ttqZt3cGna7MliIsHw8Nq8dbt3lw7e2/Byg06+SCN2r4nVCsaQxUynSHSMSNR20VBTL5U+a+ue1bheiZtqdE+4XcIj8hyI6b9aM1RUoC4veDkpLIxdV0FiXrkSvNXeyibtRRCafYYcSWKeGH2vtzcaqYstd8uLbfRVOOsSzn4lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kASU83wI; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kASU83wI"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-4a40bcc8d69so90485b6e.3
        for <git@vger.kernel.org>; Tue, 11 Aug 2026 10:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786470865; x=1787075665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tRsV31MRtIvpSeplN/BzqvYmVWkqZPGKB8JtrFMWzkw=;
        b=kASU83wImKtF4xzAAfrpY8eFA+hNi3OBjetUDTERis5sI+4R8t7iKrJIGh4EtB0OCM
         6BtIyIDWDdksraukEymvEj1piKNKAsfsgXjwq4sjGUIAA/2winwffrlpF6jC5EgW7U15
         PG/2ky6Vq8p67E1ibU/L51FaV8zDmLjY79E75VrE5B7LEYzQgR+LARGIbKRceR1V+TFa
         BPOyGw/s/I1n+dFPORnlUNUZ1QBoYuPOqALzp8B64oPrSJWNfbj0vVQF3k+++jdAQJpY
         +7V03mzH++rOq3pFYmrARYcaNvulMDiSYKbM8Razu+huwnp7OhA5dEhYisikoBtRPJR9
         LxTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786470865; x=1787075665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tRsV31MRtIvpSeplN/BzqvYmVWkqZPGKB8JtrFMWzkw=;
        b=BknwmEpCabbq0PoJisMZe+PdBlaK2q6SruRsySSzTMtISI6q/wr3o+HyQl2uFh9EWV
         8khIlJV0m3l2Ng/8T2oMJ8k9ndT/8bM9ZvGUaD1ipMmv2sEnyKgf3DX67mefFYvypr1l
         0BoU5YNd+bCmVDqm0UYJOLzpeYRjC5R0gJael9MbKDQqdUdX9GrAx9bOVh9ivvuatipt
         RJzR7sLSfjqoGvYNoE839YpSgUJNNR+IRDq/0BgrfgQQrvjwCOrAvXIDr7+4DreMSlfO
         L1axOeA9fy6TZG4Dr6A3infTCoYLQPhC77zZB2ZKwggQxsbyyK4fvu/NdyRgUv8YpeSZ
         jKfQ==
X-Gm-Message-State: AOJu0YwGxRSORAa/GCwE2QSnoKE+XjuJuY5FFS2TMRIDY8w5mnixLHiU
	tAXi7wcWM1HDz9QRQQ9X7zkTI3KBmIfOQKFCp6W2ntm9tegR5C/O2gze0Sf8eg==
X-Gm-Gg: AR+sD10s8GOw6g9SZ5jkLk31om9R5Inh/qo1gn3xX+h8bqgWZGWubw7SW02Mg7Q7ZT4
	EUEyePvpteyC6yX3p/6hzVmwW5RysJpw8pVJA32XX+KK6HjtNaREPX6QyHzJb0roVV9hX/TddRU
	wttjXTKSi9DLl00W9Rx+8CHgIcsT6Of/cBUGn2jt30z4Bpm3CG32ZxM/bL9l4sVrEil3WHEChnS
	77+kE/S5+4jLdJy0q/OBO9KwyIYVXVHESuncMfyX6HN3BWX2NG8BvJRuRz2nYLGDuFumrZijcQm
	jaxRcLBA0aM90y+d1zrwOzSxOAHYa9fH4deY4b1bF/py0JoERjfYhxop7yBDP9OIbL0uJAT25wl
	+8j5agQP3P4vuUSdA/IWppIaAHVOeejW/t41yqU0pmom16gtkS4HbSVIJ7kOe76zZnc/UEOv7HP
	VtLZBTt4GBGrqxpQ/VFSq1fFdq5xraBksV482OYw6ZYtvFDzB16RnNsjNqE2HrzKhwSnN2nN8fU
	VK0RkA=
X-Received: by 2002:a05:6808:1a04:b0:48b:5dcb:85ab with SMTP id 5614622812f47-4b209b388a5mr1184101b6e.8.1786470865126;
        Tue, 11 Aug 2026 10:54:25 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b2001331d2sm1241489b6e.11.2026.08.11.10.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 10:54:24 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 2/9] odb/transaction: add transaction finalize interface
Date: Tue, 11 Aug 2026 12:54:08 -0500
Message-ID: <20260811175415.2044235-3-jltobler@gmail.com>
X-Mailer: git-send-email 2.55.0.424.g13c7afec21
In-Reply-To: <20260811175415.2044235-1-jltobler@gmail.com>
References: <20260809190106.1565882-1-jltobler@gmail.com>
 <20260811175415.2044235-1-jltobler@gmail.com>
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

All other callers commit a transaction and immediately finalize it with
no work in between and cannot meaningfully recover should either step
fail, so introduce an `odb_transaction_commit_and_finalize_or_die()`
helper that performs both and dies on error. Call sites are updated
accordingly.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 builtin/add.c            |  4 ++--
 builtin/receive-pack.c   |  1 +
 builtin/unpack-objects.c |  2 +-
 builtin/update-index.c   |  4 ++--
 cache-tree.c             |  2 +-
 object-file.c            |  2 +-
 odb/transaction.c        | 14 ++++++++++++++
 odb/transaction.h        | 23 +++++++++++++++++++++++
 read-cache.c             |  2 +-
 9 files changed, 46 insertions(+), 8 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 60ffbede2b..ad418a5952 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -393,7 +393,7 @@ int cmd_add(int argc,
 	char *seen = NULL;
 	char *ps_matched = NULL;
 	struct lock_file lock_file = LOCK_INIT;
-	struct odb_transaction *transaction;
+	struct odb_transaction *transaction = NULL;
 
 	repo_config(repo, add_config, NULL);
 
@@ -600,7 +600,7 @@ int cmd_add(int argc,
 
 	if (chmod_arg && pathspec.nr)
 		exit_status |= chmod_pathspec(repo, &pathspec, chmod_arg[0], show_only);
-	odb_transaction_commit(transaction);
+	odb_transaction_commit_and_finalize_or_die(transaction);
 
 finish:
 	if (write_locked_index(repo->index, &lock_file,
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index d74b787148..ed1edcbe93 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -2720,6 +2720,7 @@ int cmd_receive_pack(int argc,
 		use_keepalive = KEEPALIVE_ALWAYS;
 		execute_commands(commands, unpack_status, &si, transaction,
 				 &push_options);
+		odb_transaction_finalize(transaction);
 		delete_tempfile(&pack_lockfile);
 		sigchain_push(SIGPIPE, SIG_IGN);
 		if (report_status_v2)
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 4263edfbec..d6a2d616d9 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -603,7 +603,7 @@ static void unpack_all(void)
 		unpack_one(i);
 		display_progress(progress, i + 1);
 	}
-	odb_transaction_commit(transaction);
+	odb_transaction_commit_and_finalize_or_die(transaction);
 	stop_progress(&progress);
 
 	if (delta_list)
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 241abd4332..b25d4ecb10 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1156,7 +1156,7 @@ int cmd_update_index(int argc,
 			 * a transaction.
 			 */
 			if (transaction && verbose) {
-				odb_transaction_commit(transaction);
+				odb_transaction_commit_and_finalize_or_die(transaction);
 				transaction = NULL;
 			}
 
@@ -1224,7 +1224,7 @@ int cmd_update_index(int argc,
 	/*
 	 * By now we have added all of the new objects
 	 */
-	odb_transaction_commit(transaction);
+	odb_transaction_commit_and_finalize_or_die(transaction);
 
 	if (split_index > 0) {
 		if (repo_config_get_split_index(the_repository) == 0)
diff --git a/cache-tree.c b/cache-tree.c
index d92f513286..a220372a42 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -538,7 +538,7 @@ int cache_tree_update(struct index_state *istate, int flags)
 	i = update_one(istate->cache_tree, istate->cache, istate->cache_nr,
 		       "", 0, &skip, flags);
 	if (!inflight)
-		odb_transaction_commit(transaction);
+		odb_transaction_commit_and_finalize_or_die(transaction);
 	trace2_region_leave("cache_tree", "update", istate->repo);
 	trace_performance_leave("cache_tree_update");
 	if (i < 0)
diff --git a/object-file.c b/object-file.c
index ec35c318bc..4d03c167d5 100644
--- a/object-file.c
+++ b/object-file.c
@@ -965,7 +965,7 @@ int index_fd(struct index_state *istate, struct object_id *oid,
 								  xsize_t(st->st_size),
 								  oid);
 			if (!inflight)
-				odb_transaction_commit(transaction);
+				odb_transaction_commit_and_finalize_or_die(transaction);
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
index 4cb2eafcbf..6ed39b3d0e 100644
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
@@ -75,6 +82,22 @@ static inline void odb_transaction_begin_or_die(struct object_database *odb,
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
+static inline void odb_transaction_commit_and_finalize_or_die(struct odb_transaction *transaction)
+{
+	if (odb_transaction_commit(transaction))
+		die(_("failed to commit ODB transaction"));
+	if (odb_transaction_finalize(transaction))
+		die(_("failed to finalize ODB transaction"));
+}
+
 /*
  * Writes the object in the provided stream into the transaction. The resulting
  * object ID is written into the out pointer. Returns 0 on success, a negative
diff --git a/read-cache.c b/read-cache.c
index 6c449f393d..0cd0ef85ec 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -4049,7 +4049,7 @@ int add_files_to_cache(struct repository *repo, const char *prefix,
 		odb_transaction_begin_or_die(repo->objects, &transaction, 0);
 	run_diff_files(&rev, DIFF_RACY_IS_MODIFIED);
 	if (!inflight)
-		odb_transaction_commit(transaction);
+		odb_transaction_commit_and_finalize_or_die(transaction);
 
 	release_revisions(&rev);
 	return !!data.add_errors;
-- 
2.55.0.424.g13c7afec21

