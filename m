Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A06E2DE6F8
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 18:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758047391; cv=none; b=kHELv2j/dw/oKCQ/LFVllB7bJ2+LXFgrzHQXxhLU6LSQvbUK6S8RZjosssBGbQyQT9yAYFbKRbw8J4NoJCOdRkC0IMAN5W8Usz/jfQWJijsvJeB17fRL79PdHvFfWjPc+8dkUz1YK/pdAIKKw74R1oqm+hKlMlL6QmJrJx8/znQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758047391; c=relaxed/simple;
	bh=LrAlNKg/Gq+g9J7EdpLTo9D37e7x1huU4IJB1s0RVhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OgA3ZG50vEsv/op4QAG2o10VDrUjoqWoYLVa9k7/ho2TJ0jVTyhNtdw2fxhtrVFZJGJcKvDoQHAd2YAdKwUVF0YfupFlTPgxsI7eBpw2aqANqWubxiJoSRB2wYGT1QJyTSMkTC4B01bzFTwn0AasS0fAMNUhhLaoonVh2wg5YJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mF1PYWsv; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mF1PYWsv"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-3197f534179so4103241fac.2
        for <git@vger.kernel.org>; Tue, 16 Sep 2025 11:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758047389; x=1758652189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=67WKgHayTWBy3NmPWikb62L5Bb+DGAAX/0MvpXLDrKk=;
        b=mF1PYWsvvXlPmrsjHMTJTW6Zib4W9VPYKkos0VMxpbXa4MEKlAXD8Nt7m8O/2D+tyr
         7UqrW0E06wkT4qjE9xHbFW/bKVpCjOcqe7woJr2cNdV3rgGkAaGlsMGPmKSrw3nh7v8z
         fmMhZY3ZU1jdbctoNYmDev5a4S/Ie0XfRpmMpij6vQt5dmMAkXhxHP32Hbtt6K36vEjT
         81OyRa8dFP4PFhdNT3V+00Ga4MD5uJRrlXJWEfB4FRmm3SOanZflSiBiny+xJOg1Xs4Q
         hB8bf1xW8IsWPZraewdmBa/kYEWcO7nat0BQLHRFTdJenJ2dGRyM0sFqOXqhAGwIzYF6
         6a5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758047389; x=1758652189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=67WKgHayTWBy3NmPWikb62L5Bb+DGAAX/0MvpXLDrKk=;
        b=W6Cvd6wQQGwxuKsQwE5onRBHU+doU1F6Q2ShsGF3VdvRJgXGHjfC3J+Lr5DCGHt2Ti
         40y7zOMuWeWYb27vSx9QPctFeXVVYmbJtsWw6QzEZlC/hJkZmMs1ShDVuWvlmq7CZTk8
         BPfVkZze3tEd7l4yYBVWAosC5x9FKs4cmvUtIArYcNrCQAtDMrylO8Y+ekPZVPEhwi3h
         R1e3/Me1E9pXJnXS0RNYLsKVgz8xATZQxy8r2C2nUkiDz75sAFRpgbPuUfss1uaGT1jr
         gONt/rWcqWj6gZmhov8+hQaBDR0IsdaAcS8mgvlD/bQtM4FHDU1/KZiO4PIay4vGGPXa
         Ov9A==
X-Gm-Message-State: AOJu0Ywcrl6+DPHG91U3NfIFYu/H12LR5R156MFh1qEQGL5BxHf+Qb4w
	KnZFOUbs7hZt+/moV/neUVw/1IWmYi7MZUacw0cLYoEaMi9SYTnCO/BQ/wE42Q==
X-Gm-Gg: ASbGncvbi1SeT2BdNVekI2QsSYLbw90l02j2fPEQIjhGPf7DQXuQ1nZEFMT0fP2+pkd
	BlCvaVncGL0KxWZEhwTItmMUq27OeFI/v/+gdYppcDev6w/kCnaQj09ucNkGY/aeXW4yPGDm1Av
	SFo81MxEqRjZ9WKLK+MHNQDLlYsrSzOkm+I8YRQb4lxFafmPfo3NU7YNGVTwBDonYCQHJQagqJl
	UTtMgJAtgKbN5N9yB5GSjKVDEu22iSC5M+E1kIefW8cF9D8WAspyawi0x45FgItUFmLjZvklVWJ
	YCh7h45IAFEHwQgW62Ba9Eh4xwHk1zGz2mnyPVZp6fY9yna5kRqxYBj/hLwfugLdq0e8r6F+uh/
	inx/y9lEAvUui1aeg6E6gDnuCvq7L3dU=
X-Google-Smtp-Source: AGHT+IHueqCHdUu/jLduD7mZneohQIY+xb6xOye8KAHtZiBGCEV0Xk9KaKtq9GDQCDUOSCqa2rqWXQ==
X-Received: by 2002:a05:6871:738e:b0:315:9347:9260 with SMTP id 586e51a60fabf-32e58144acdmr7900896fac.32.1758047388731;
        Tue, 16 Sep 2025 11:29:48 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-32d32d5653fsm5003058fac.7.2025.09.16.11.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 11:29:48 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	me@ttaylorr.com,
	karthik.188@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 6/6] odb: add transaction interface
Date: Tue, 16 Sep 2025 13:29:38 -0500
Message-ID: <20250916182938.2193476-7-jltobler@gmail.com>
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
 odb.h                    | 13 +++++++++++++
 read-cache.c             |  4 ++--
 9 files changed, 46 insertions(+), 19 deletions(-)

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
index 79ddf6b727..2aba47060e 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -489,10 +489,10 @@ int cache_tree_update(struct index_state *istate, int flags)
 
 	trace_performance_enter();
 	trace2_region_enter("cache_tree", "update", the_repository);
-	transaction = begin_odb_transaction(the_repository->objects);
+	transaction = odb_transaction_begin(the_repository->objects);
 	i = update_one(istate->cache_tree, istate->cache, istate->cache_nr,
 		       "", 0, &skip, flags);
-	end_odb_transaction(transaction);
+	odb_transaction_commit(transaction);
 	trace2_region_leave("cache_tree", "update", the_repository);
 	trace_performance_leave("cache_tree_update");
 	if (i < 0)
diff --git a/object-file.c b/object-file.c
index 8103a2bf41..17a236d2fe 100644
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
@@ -1622,12 +1622,12 @@ int index_fd(struct index_state *istate, struct object_id *oid,
 	} else {
 		struct odb_transaction *transaction;
 
-		transaction = begin_odb_transaction(the_repository->objects);
+		transaction = odb_transaction_begin(the_repository->objects);
 		ret = index_blob_packfile_transaction(the_repository->objects->transaction,
 						      oid, fd,
 						      xsize_t(st->st_size),
 						      path, flags);
-		end_odb_transaction(transaction);
+		odb_transaction_commit(transaction);
 	}
 
 	close(fd);
@@ -1967,8 +1967,10 @@ int read_loose_object(struct repository *repo,
 	return ret;
 }
 
-struct odb_transaction *begin_odb_transaction(struct object_database *odb)
+struct odb_transaction *object_file_transaction_begin(struct odb_source *source)
 {
+	struct object_database *odb = source->odb;
+
 	if (odb->transaction)
 		return NULL;
 
@@ -1978,7 +1980,7 @@ struct odb_transaction *begin_odb_transaction(struct object_database *odb)
 	return odb->transaction;
 }
 
-void end_odb_transaction(struct odb_transaction *transaction)
+void object_file_transaction_commit(struct odb_transaction *transaction)
 {
 	if (!transaction)
 		return;
diff --git a/object-file.h b/object-file.h
index 6323d2e63c..3fd48dcafb 100644
--- a/object-file.h
+++ b/object-file.h
@@ -222,16 +222,16 @@ struct odb_transaction;
 
 /*
  * Tell the object database to optimize for adding
- * multiple objects. end_odb_transaction must be called
+ * multiple objects. object_file_transaction_commit must be called
  * to make new objects visible. If a transaction is already
  * pending, NULL is returned.
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
index a89b214390..82093753c8 100644
--- a/odb.h
+++ b/odb.h
@@ -185,6 +185,19 @@ struct object_database {
 struct object_database *odb_new(struct repository *repo);
 void odb_clear(struct object_database *o);
 
+/*
+ * Starts an ODB transaction. Subsequent objects are written to the transaction
+ * and not committed until odb_transaction_commit() is invoked on the
+ * transaction. If the ODB already has a pending transaction, NULL is returned.
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
index 80591eeced..94098a3861 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -3972,9 +3972,9 @@ int add_files_to_cache(struct repository *repo, const char *prefix,
 	 * This function is invoked from commands other than 'add', which
 	 * may not have their own transaction active.
 	 */
-	transaction = begin_odb_transaction(repo->objects);
+	transaction = odb_transaction_begin(repo->objects);
 	run_diff_files(&rev, DIFF_RACY_IS_MODIFIED);
-	end_odb_transaction(transaction);
+	odb_transaction_commit(transaction);
 
 	release_revisions(&rev);
 	return !!data.add_errors;
-- 
2.51.0.193.g4975ec3473b

