Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90A529A9C9
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 20:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757968215; cv=none; b=Iv/RRS4ybatNJGt3e1PuT08EUMTNi1QFZiZLm+xg21asIDiS2v/0bJlf5XCMpfpie0s+ze+3QSDza1+VVxmgiRfnVgmE3qLZkSsyrxNbGtgl/2zrmTqT34IhGGCYGL216M843ox8T1QHnhZ4F6aLUoilEBLG3M4Y+IwXCkj+biA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757968215; c=relaxed/simple;
	bh=XCJDDVu35I2ImpD2Y1KiNfxQssFZf+JM/h/SIITLKws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V6BnbgxfIAQwVWZhNbnUU529MWOq/pJHjJVrhyLfXdE91jAFjetYu+8J/iq+Usyf4cG5xlb8JlD1wGjEWFKjbcFbOpYe6wTMWiOHgKzCZ0ueAc6KIIXguHOKifS10O/Y9EJITe6uQdme4e3jzsjcPZLS7cT+j+ZcQ6trW1+XRms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XzdogKTV; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XzdogKTV"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-750b77699b4so3757581a34.2
        for <git@vger.kernel.org>; Mon, 15 Sep 2025 13:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757968212; x=1758573012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SyWWHxL3YjgFp26Fg+2Z5Hnhv//zcQGy5CtTnxHltd8=;
        b=XzdogKTVYbn/Jru26rn1YhKvfjoJouJeNzTGjVr9I5pGsYjHnd1H4mAWYnt+AOeIjx
         4sdc0galmy7h6teCL1rhf2iaTjqchGgTYWC10q/vo1WGoNp6P6V1tFOAm6iejcs1Z7gk
         wvsv3kYUYaOi5amRf6zvUYlgYF9VACryYftW7zT8pGFHPPl/HO6Ztn3d+GA1MBAR/ul6
         VIwxelxmLQU38r9fl0l1k0Dmt0eWpXHowYfnEaqso2dxJoPRNn3X0IUZRFYp/KxIoQxK
         mAIP0L3RBy6TWFOLJPFVlUvvYn2uZBSt6qMQxfXjHHmnfSjrutbzdBoLBtVBRrvwdBZU
         qEog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757968212; x=1758573012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SyWWHxL3YjgFp26Fg+2Z5Hnhv//zcQGy5CtTnxHltd8=;
        b=J/MG0imw1J7DQZ9ASXO9y9o8HhMqjGsLPk1oGcxqiu7Doq7eOIXlo7bROr6tR/qKB+
         x62LKhg1WXe/jyx3klPUjWn95RPsRdx4XsEsfwoeOHdUYUJj0u4N0sIF73x7iDHQmEXZ
         Tdzt2R4Nd/qd1YoaZ+nnxBFz8nSPwKj41zgE32irCbFwkeob6b/KbRps1S5Hk048q04q
         MWn9+o90O5pcOGJDE2prIdqeGuxycM+PXS0UVCQRnkG5/AvNPASblkFWe2SJapUWSYfs
         laXuyDHAJXxWOStqSDBCPJ8oKJ+33RmgJpmGB6/KB84ZL+Zz6gpUCB3Ug7QBPuuioZGB
         yXcw==
X-Gm-Message-State: AOJu0YwCIx6cwnQrPUYQ68ZG8UPpSJDmbea2mX7CyCZPvgX1L6xbQ5Cu
	02vqs5XE0nwBDpvwucfT44S7UOURzgDtblYIEHVozJw6+vUfHXTkjQZTsdmh5Q==
X-Gm-Gg: ASbGncvr5SgujK65Nwt8kfKGHu1GUo9I8lhGsvdqSA3NvGB+g8tdNvj6DVchAJRUOcL
	p/4ILQdk4eA2I8oAdxt9D06AAD1zDE3xif/0RM23xQPj2JACNgKB9OLYDG+4nidFckXE9yklTa9
	qq8ivccDJ2G+82vrk9LA/ejE0VRI0n7nZutRodm5HPTOoMltsvVachnpQ2Q0HwRK2deHJ6x0BEl
	CdQdY/kIBu3A5VcuLRWuqkOn1pT1oAWqFD5+DqgwmnanjJuW9H7Iq/XPnc+weJ7RRbMWOEguIHf
	TnJ6t5FQ9GE46EL3Zw4JhSIlLA58SP2ZCWd2oSwwRPLqyjxcAuDAJWaRHR+pAGMh5Q+xxPJwiOX
	I5lGOM+KF5fuB3beYw6FJjhjfQMFIfhQzIMgF54LOXw==
X-Google-Smtp-Source: AGHT+IGdJcbJo4Rf6vo99wkEouMepQf/+S5VGS46R/gGBTzz4zdE6ONh8UZJ7FsoIXJxpHRQrvjwLw==
X-Received: by 2002:a05:6830:4d93:10b0:756:a322:2f8 with SMTP id 46e09a7af769-756a32206a2mr3529846a34.5.1757968212523;
        Mon, 15 Sep 2025 13:30:12 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7524c260735sm3114325a34.39.2025.09.15.13.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 13:30:12 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 6/6] odb: add transaction interface
Date: Mon, 15 Sep 2025 15:29:56 -0500
Message-ID: <20250915202956.3784935-7-jltobler@gmail.com>
X-Mailer: git-send-email 2.51.0.193.g4975ec3473b
In-Reply-To: <20250915202956.3784935-1-jltobler@gmail.com>
References: <20250909191134.555689-1-jltobler@gmail.com>
 <20250915202956.3784935-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Transactions are managed via the {begin,end}_odb_transaction() function
in the object-file subsystem and its implementation is specific to the
files object source. Introduce odb_transaction_{begin,commit}() in the
odb subsystem to provide an eventual object source agnostic means to
manage transactions.

Update call sites to instead manage transactions through the odb
subsystem. Also rename {begin,end}_odb_transaction() functions to
object_file_transaction_{begin,commit}() to clarify the object source it
supports.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 builtin/add.c            |  5 +++--
 builtin/unpack-objects.c |  4 ++--
 builtin/update-index.c   |  7 ++++---
 cache-tree.c             |  4 ++--
 object-file.c            | 12 +++++++-----
 object-file.h            |  6 +++---
 odb.c                    | 10 ++++++++++
 odb.h                    | 14 ++++++++++++++
 read-cache.c             |  4 ++--
 9 files changed, 47 insertions(+), 19 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 8294366d68..bf312c40be 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -15,6 +15,7 @@
 #include "pathspec.h"
 #include "run-command.h"
 #include "object-file.h"
+#include "odb.h"
 #include "parse-options.h"
 #include "path.h"
 #include "preload-index.h"
@@ -575,7 +576,7 @@ int cmd_add(int argc,
 		string_list_clear(&only_match_skip_worktree, 0);
 	}
 
-	transaction = begin_odb_transaction(repo->objects);
+	transaction = odb_transaction_begin(repo->objects);
 
 	ps_matched = xcalloc(pathspec.nr, 1);
 	if (add_renormalize)
@@ -594,7 +595,7 @@ int cmd_add(int argc,
 
 	if (chmod_arg && pathspec.nr)
 		exit_status |= chmod_pathspec(repo, &pathspec, chmod_arg[0], show_only);
-	end_odb_transaction(transaction);
+	odb_transaction_commit(transaction);
 
 finish:
 	if (write_locked_index(repo->index, &lock_file,
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 4596fff0da..ef79e43715 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -599,12 +599,12 @@ static void unpack_all(void)
 		progress = start_progress(the_repository,
 					  _("Unpacking objects"), nr_objects);
 	CALLOC_ARRAY(obj_list, nr_objects);
-	transaction = begin_odb_transaction(the_repository->objects);
+	transaction = odb_transaction_begin(the_repository->objects);
 	for (i = 0; i < nr_objects; i++) {
 		unpack_one(i);
 		display_progress(progress, i + 1);
 	}
-	end_odb_transaction(transaction);
+	odb_transaction_commit(transaction);
 	stop_progress(&progress);
 
 	if (delta_list)
diff --git a/builtin/update-index.c b/builtin/update-index.c
index ee01c4e423..8a5907767b 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -18,6 +18,7 @@
 #include "cache-tree.h"
 #include "tree-walk.h"
 #include "object-file.h"
+#include "odb.h"
 #include "refs.h"
 #include "resolve-undo.h"
 #include "parse-options.h"
@@ -1122,7 +1123,7 @@ int cmd_update_index(int argc,
 	 * Allow the object layer to optimize adding multiple objects in
 	 * a batch.
 	 */
-	transaction = begin_odb_transaction(the_repository->objects);
+	transaction = odb_transaction_begin(the_repository->objects);
 	while (ctx.argc) {
 		if (parseopt_state != PARSE_OPT_DONE)
 			parseopt_state = parse_options_step(&ctx, options,
@@ -1152,7 +1153,7 @@ int cmd_update_index(int argc,
 			 * a transaction.
 			 */
 			if (transaction && verbose) {
-				end_odb_transaction(transaction);
+				odb_transaction_commit(transaction);
 				transaction = NULL;
 			}
 
@@ -1220,7 +1221,7 @@ int cmd_update_index(int argc,
 	/*
 	 * By now we have added all of the new objects
 	 */
-	end_odb_transaction(transaction);
+	odb_transaction_commit(transaction);
 
 	if (split_index > 0) {
 		if (repo_config_get_split_index(the_repository) == 0)
diff --git a/cache-tree.c b/cache-tree.c
index 7ad3225a71..f4a8753e27 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -491,12 +491,12 @@ int cache_tree_update(struct index_state *istate, int flags)
 	trace2_region_enter("cache_tree", "update", the_repository);
 
 	if (!the_repository->objects->transaction)
-		transaction = begin_odb_transaction(the_repository->objects);
+		transaction = odb_transaction_begin(the_repository->objects);
 
 	i = update_one(istate->cache_tree, istate->cache, istate->cache_nr,
 		       "", 0, &skip, flags);
 
-	end_odb_transaction(transaction);
+	odb_transaction_commit(transaction);
 
 	trace2_region_leave("cache_tree", "update", the_repository);
 	trace_performance_leave("cache_tree_update");
diff --git a/object-file.c b/object-file.c
index 63195da2e8..0fc24b48da 100644
--- a/object-file.c
+++ b/object-file.c
@@ -691,7 +691,7 @@ static void prepare_loose_object_transaction(struct odb_transaction *transaction
 	 * We lazily create the temporary object directory
 	 * the first time an object might be added, since
 	 * callers may not know whether any objects will be
-	 * added at the time they call begin_odb_transaction.
+	 * added at the time they call object_file_transaction_begin.
 	 */
 	if (!transaction || transaction->objdir)
 		return;
@@ -1623,14 +1623,14 @@ int index_fd(struct index_state *istate, struct object_id *oid,
 		struct odb_transaction *transaction = NULL;
 
 		if (!the_repository->objects->transaction)
-			transaction = begin_odb_transaction(the_repository->objects);
+			transaction = odb_transaction_begin(the_repository->objects);
 
 		ret = index_blob_packfile_transaction(the_repository->objects->transaction,
 						      oid, fd,
 						      xsize_t(st->st_size),
 						      path, flags);
 
-		end_odb_transaction(transaction);
+		odb_transaction_commit(transaction);
 	}
 
 	close(fd);
@@ -1970,8 +1970,10 @@ int read_loose_object(struct repository *repo,
 	return ret;
 }
 
-struct odb_transaction *begin_odb_transaction(struct object_database *odb)
+struct odb_transaction *object_file_transaction_begin(struct odb_source *source)
 {
+	struct object_database *odb = source->odb;
+
 	if (odb->transaction)
 		BUG("ODB transaction already started");
 
@@ -1981,7 +1983,7 @@ struct odb_transaction *begin_odb_transaction(struct object_database *odb)
 	return odb->transaction;
 }
 
-void end_odb_transaction(struct odb_transaction *transaction)
+void object_file_transaction_commit(struct odb_transaction *transaction)
 {
 	if (!transaction)
 		return;
diff --git a/object-file.h b/object-file.h
index 5925563f83..965f437ada 100644
--- a/object-file.h
+++ b/object-file.h
@@ -222,17 +222,17 @@ struct odb_transaction;
 
 /*
  * Tell the object database to optimize for adding
- * multiple objects. end_odb_transaction must be called
+ * multiple objects. object_file_transaction_commit must be called
  * to make new objects visible. Only a single transaction
  * can be pending at a time and must be ended before
  * beginning another.
  */
-struct odb_transaction *begin_odb_transaction(struct object_database *odb);
+struct odb_transaction *object_file_transaction_begin(struct odb_source *source);
 
 /*
  * Tell the object database to make any objects from the
  * current transaction visible.
  */
-void end_odb_transaction(struct odb_transaction *transaction);
+void object_file_transaction_commit(struct odb_transaction *transaction);
 
 #endif /* OBJECT_FILE_H */
diff --git a/odb.c b/odb.c
index 2a92a018c4..af9534bfe1 100644
--- a/odb.c
+++ b/odb.c
@@ -1051,3 +1051,13 @@ void odb_clear(struct object_database *o)
 	hashmap_clear(&o->pack_map);
 	string_list_clear(&o->submodule_source_paths, 0);
 }
+
+struct odb_transaction *odb_transaction_begin(struct object_database *odb)
+{
+	return object_file_transaction_begin(odb->sources);
+}
+
+void odb_transaction_commit(struct odb_transaction *transaction)
+{
+	object_file_transaction_commit(transaction);
+}
diff --git a/odb.h b/odb.h
index a89b214390..48621f9402 100644
--- a/odb.h
+++ b/odb.h
@@ -185,6 +185,20 @@ struct object_database {
 struct object_database *odb_new(struct repository *repo);
 void odb_clear(struct object_database *o);
 
+/*
+ * Starts an ODB transaction. Subsequent objects are written to the transaction
+ * and not committed until odb_transaction_commit() is invoked on the
+ * transaction. Caller are responsible to ensure there is only a single ODB
+ * transaction pending at a time.
+ */
+struct odb_transaction *odb_transaction_begin(struct object_database *odb);
+
+/*
+ * Commits an ODB transaction making the written objects visible. If the
+ * specified transaction is NULL, the function is a no-op.
+ */
+void odb_transaction_commit(struct odb_transaction *transaction);
+
 /*
  * Find source by its object directory path. Dies in case the source couldn't
  * be found.
diff --git a/read-cache.c b/read-cache.c
index 00acd8c858..e9a0ddfeb1 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -3973,11 +3973,11 @@ int add_files_to_cache(struct repository *repo, const char *prefix,
 	 * may not have their own transaction active.
 	 */
 	if (!repo->objects->transaction)
-		transaction = begin_odb_transaction(repo->objects);
+		transaction = odb_transaction_begin(repo->objects);
 
 	run_diff_files(&rev, DIFF_RACY_IS_MODIFIED);
 
-	end_odb_transaction(transaction);
+	odb_transaction_commit(transaction);
 
 	release_revisions(&rev);
 	return !!data.add_errors;
-- 
2.51.0.193.g4975ec3473b

