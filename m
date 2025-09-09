Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE24635A29C
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 19:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757445115; cv=none; b=QfG/YP5zCeWLSvO4SgmVacZBA9gCUlQjzUOEqL9Rr6BYg0ETCAeoryGg0vMD3SGACLY8LfukEuqrH37JM2dzdLKOWuMSOaALZ3fkg4GTF4wiu/Zxh474Ik8KdKCndJpzxiWtcN7PwrfZWV7IQzCqpJyrGguWGt2k7ir0LhgB4rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757445115; c=relaxed/simple;
	bh=9EHt5Euoeeih2vj2HBFJUEQymzjaFLVR66b7smEa4OM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z8Jcqzwp9k+1qJ6d1zEqfCYiP6yJaG7yaQiiW1Ha977n7YndYP6DcujzFOdow/bztSMC2wZdm8rJU0fBLEkUL+2ob1rAxt+orIiFh20yXuPXntruWkH/gYvAgzNbNg6XJSHm3d1F3qLNqcT9taemhOBjHkUBXtGtnlomz6zXKoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fJT8Q1kn; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJT8Q1kn"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-61e783a1e00so3931275eaf.1
        for <git@vger.kernel.org>; Tue, 09 Sep 2025 12:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757445111; x=1758049911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rEFHt690erM3KOgnP/5WCRb2w2sxhmGwFmbeVgSLSBg=;
        b=fJT8Q1knRFIWSOUAptbs0WvypUwyKMlhNat7gHYgCVF6LZP/Qdda+3tIJrTC4B9b33
         OjVU6AgvesGLySvz4m+EtAkaJ2aYxIQDDY9f8ROexus8AQfjdzHCimlSgB/HrVU/nBUy
         ua0XjqMjrG13Ram8h0LO6RIl6YHVR6xNA8A1UwMO/49aIBNyfHUX2TgppuuOBNeOuIXz
         EB1j7u7gkOzpWicg+xxnkoEV+4Dy6OEC3v5KiJz3gbc+5SOO7F85wEe4BLZwUsxXsF5u
         8p1IdwK9iOai3VfoQDCtg5kN9GlClbRzEaUs/nQiP6AgwtXXPCYqcIwypr2wnZ58bl8B
         Bfrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757445111; x=1758049911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rEFHt690erM3KOgnP/5WCRb2w2sxhmGwFmbeVgSLSBg=;
        b=Viz7AZ0FqFtTFlpKvmXoczbUsEOxJv05ZK3tW4b9GPbmySZQXp/RRNRwopkxxJaN7j
         z00iDjWsipj4XKElD3/CTs+rIDp03i/CRdm7RCh+FTlx4i4jSvhF8g5qLm4ofXAeJPyX
         S4jQ9jEy1VQzGVN9fF8n9V1sDrgGxC/DvJJ5NWxtd326sm5QL/QQJg3q0OQeiskC3FfO
         QOE/qEqP6kNbT67NrEo0hW5vIknm8IyvPNDMkRxlTnH7bz7WBlo2+3rnOkTR9nRSL2Q6
         jl9CPi6MA5E1T6Vb1+t1LKFDQ9kyRQQ5sgnP8s18teFtUt/PdbXl2z3bk+L2rYaaH8EP
         tFQA==
X-Gm-Message-State: AOJu0YzPibvHJMmAW3bml4R5VTXdzq9SxwhMjSFsaBGqFA+qdD+RBjKT
	GqoBUucLOIqkWt/2OPVO6aEnw83rzLJJM14cIlWDGngVY/ab3IGmvR/Jb3jdKw==
X-Gm-Gg: ASbGncsa3VPBO75iDrNhzxa/X3wZEBHGKuk3VFESaHpKpTqGG429TkKr3UajEE9Xws1
	YMNGHh+Z2eU7SI0gpsJsrVBYrLeXr6OIOBdYylM6z93giY54LnJVN067mzz29yx6ypn0CdeReAr
	aEIwXSqSpbCOVv8V+Rr8L+RJA/4wFG9TkJsCa0hj7fO8AX5WB3NH1SVSr5fpnIh26G1eF0qjGy5
	VCXTWvys+rNqUyoavksOS6E3lRceS5qlH7NIsO6P86cOeOfnfvT7KIxmoMsepeQ1yAzuZBT7fGH
	KHQCj141ec/oXn4zUxpwk80HzCp2OLzwCLrDwX81mdI9fgHLtmzzOp88P/DsUKx2Nkev5886nBX
	zkvcFN0NHK7sYsYU/2Ymb3tos78+CzGVLVo69XgcEVg==
X-Google-Smtp-Source: AGHT+IGmA7A/8Mu74XHvbOIeYbhZJtrPvRbMPMCiiF0x/n0AOv1bj2yAMkAg3aD6KXffV4UGK6zGYQ==
X-Received: by 2002:a05:6808:1899:b0:43b:2829:e642 with SMTP id 5614622812f47-43b29ad4f52mr4299499b6e.24.1757445111417;
        Tue, 09 Sep 2025 12:11:51 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-74cc5a69b95sm3062627a34.39.2025.09.09.12.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 12:11:51 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 6/6] odb: add transaction interface
Date: Tue,  9 Sep 2025 14:11:34 -0500
Message-ID: <20250909191134.555689-7-jltobler@gmail.com>
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

Transactions are managed via the {begin,end}_odb_transaction() function
in the object-file subsystem and its implementation is specific to the
files object source. Introduce odb_transaction_{begin,commit}() in the
odb subsystem to provide an eventual object source agnostic means to
manage transactions.

Update call sites to instead manage transactions through the odb
subsystem. Also rename {begin,end}_odb_transaction() functions to
object_file_transaction_{begin,end}() to clarify the object source it
supports.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 builtin/add.c            |  5 +++--
 builtin/unpack-objects.c |  4 ++--
 builtin/update-index.c   |  7 ++++---
 cache-tree.c             |  4 ++--
 object-file.c            | 10 +++++-----
 object-file.h            |  6 +++---
 odb.c                    | 10 ++++++++++
 odb.h                    |  3 +++
 read-cache.c             |  4 ++--
 9 files changed, 34 insertions(+), 19 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 8294366d68a..bf312c40be9 100644
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
index 4596fff0dad..ef79e43715d 100644
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
index 632f2c9b6d9..cf97baa8a02 100644
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
 
@@ -1221,7 +1222,7 @@ int cmd_update_index(int argc,
 	 * By now we have added all of the new objects
 	 */
 	if (transaction)
-		end_odb_transaction(transaction);
+		odb_transaction_commit(transaction);
 
 	if (split_index > 0) {
 		if (repo_config_get_split_index(the_repository) == 0)
diff --git a/cache-tree.c b/cache-tree.c
index cc4008e7d61..43fa0d9ba99 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -491,13 +491,13 @@ int cache_tree_update(struct index_state *istate, int flags)
 	trace2_region_enter("cache_tree", "update", the_repository);
 
 	if (!the_repository->objects->transaction)
-		transaction = begin_odb_transaction(the_repository->objects);
+		transaction = odb_transaction_begin(the_repository->objects);
 
 	i = update_one(istate->cache_tree, istate->cache, istate->cache_nr,
 		       "", 0, &skip, flags);
 
 	if (transaction)
-		end_odb_transaction(transaction);
+		odb_transaction_commit(transaction);
 
 	trace2_region_leave("cache_tree", "update", the_repository);
 	trace_performance_leave("cache_tree_update");
diff --git a/object-file.c b/object-file.c
index 91fddfc4984..aff6c6c6dbb 100644
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
@@ -1623,7 +1623,7 @@ int index_fd(struct index_state *istate, struct object_id *oid,
 		struct odb_transaction *transaction = NULL;
 
 		if (!the_repository->objects->transaction)
-			transaction = begin_odb_transaction(the_repository->objects);
+			transaction = odb_transaction_begin(the_repository->objects);
 
 		ret = index_blob_packfile_transaction(the_repository->objects->transaction,
 						      oid, fd,
@@ -1631,7 +1631,7 @@ int index_fd(struct index_state *istate, struct object_id *oid,
 						      path, flags);
 
 		if (transaction)
-			end_odb_transaction(transaction);
+			odb_transaction_commit(transaction);
 	}
 
 	close(fd);
@@ -1971,7 +1971,7 @@ int read_loose_object(struct repository *repo,
 	return ret;
 }
 
-struct odb_transaction *begin_odb_transaction(struct object_database *odb)
+struct odb_transaction *object_file_transaction_begin(struct object_database *odb)
 {
 	if (odb->transaction)
 		BUG("ODB transaction already started");
@@ -1982,7 +1982,7 @@ struct odb_transaction *begin_odb_transaction(struct object_database *odb)
 	return odb->transaction;
 }
 
-void end_odb_transaction(struct odb_transaction *transaction)
+void object_file_transaction_end(struct odb_transaction *transaction)
 {
 	flush_loose_object_transaction(transaction);
 	flush_packfile_transaction(transaction);
diff --git a/object-file.h b/object-file.h
index 5925563f838..82e24fd4629 100644
--- a/object-file.h
+++ b/object-file.h
@@ -222,17 +222,17 @@ struct odb_transaction;
 
 /*
  * Tell the object database to optimize for adding
- * multiple objects. end_odb_transaction must be called
+ * multiple objects. object_file_transaction_end must be called
  * to make new objects visible. Only a single transaction
  * can be pending at a time and must be ended before
  * beginning another.
  */
-struct odb_transaction *begin_odb_transaction(struct object_database *odb);
+struct odb_transaction *object_file_transaction_begin(struct object_database *odb);
 
 /*
  * Tell the object database to make any objects from the
  * current transaction visible.
  */
-void end_odb_transaction(struct odb_transaction *transaction);
+void object_file_transaction_end(struct odb_transaction *transaction);
 
 #endif /* OBJECT_FILE_H */
diff --git a/odb.c b/odb.c
index 2a92a018c42..2cd954a1040 100644
--- a/odb.c
+++ b/odb.c
@@ -1051,3 +1051,13 @@ void odb_clear(struct object_database *o)
 	hashmap_clear(&o->pack_map);
 	string_list_clear(&o->submodule_source_paths, 0);
 }
+
+struct odb_transaction *odb_transaction_begin(struct object_database *odb)
+{
+	return object_file_transaction_begin(odb);
+}
+
+void odb_transaction_commit(struct odb_transaction *transaction)
+{
+	object_file_transaction_end(transaction);
+}
diff --git a/odb.h b/odb.h
index a89b2143909..c7725b3df00 100644
--- a/odb.h
+++ b/odb.h
@@ -185,6 +185,9 @@ struct object_database {
 struct object_database *odb_new(struct repository *repo);
 void odb_clear(struct object_database *o);
 
+struct odb_transaction *odb_transaction_begin(struct object_database *odb);
+void odb_transaction_commit(struct odb_transaction *transaction);
+
 /*
  * Find source by its object directory path. Dies in case the source couldn't
  * be found.
diff --git a/read-cache.c b/read-cache.c
index ac0655743f6..100fe805a69 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -3973,12 +3973,12 @@ int add_files_to_cache(struct repository *repo, const char *prefix,
 	 * may not have their own transaction active.
 	 */
 	if (!repo->objects->transaction)
-		transaction = begin_odb_transaction(repo->objects);
+		transaction = odb_transaction_begin(repo->objects);
 
 	run_diff_files(&rev, DIFF_RACY_IS_MODIFIED);
 
 	if (transaction)
-		end_odb_transaction(transaction);
+		odb_transaction_commit(transaction);
 
 	release_revisions(&rev);
 	return !!data.add_errors;
-- 
2.51.0.193.g4975ec3473b

