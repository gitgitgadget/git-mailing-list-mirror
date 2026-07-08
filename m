Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5174B3B9D86
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 04:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783484072; cv=none; b=TYSWgwXueh9BtrValglZt43g2Rilu8pO7PteL4cMyoc0qsrmkvcNqn7F+k1wrAr14hN8W79BnuNEdUBfCKW9FeegE5YhKWFVd9ENn3smTp5dNvXq0sS8EGGYLidvI+3hgoFEUQSnRZLPx9G34QFQZLvEui3mFsyqRpV3Q2B9Tcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783484072; c=relaxed/simple;
	bh=YOBRBesrGg8S9pAriurDRLAQ4sI46GFYqGOZsV+cQl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VidR4NCP03BaLn1OlkLdXntnVrCdDh4gCSrGfQIevNHbuOyBEENdrfUwRNF5x5ZfLBJEkKRyne8Schw3OUxeg2TjlqUmFbGly7wZ0wLGzvJFqCJTZRD9QumAeTRp429Xln9GH9wKFZ3Gj7WRGGJ77cEUj3nRIrCGFvq1TkFdn18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ltm4sN2R; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ltm4sN2R"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-495b27007d0so168659b6e.1
        for <git@vger.kernel.org>; Tue, 07 Jul 2026 21:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783484069; x=1784088869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D6iJwB/8YlEWzCojE2dbEM2JmoS9HStIh03zd/GRlIY=;
        b=Ltm4sN2R4BdqbLPNlLgroEKlu5AX2EdK83qN4sorluNNOnJPCFWwZNTsjBmL0c5NgL
         zcwdmhhgBLIwL/7W7XfcH/YFYJQMbiBYD72rwfvCltwcZO3fqvkdjafydFy9s7JIgKfy
         7yn1TIQMaa/HUyHdnJLMEQRxwYaH9JQ5tmSV2CpkBToF0HASogLoDKsdZiUJt96zkrIw
         CxXi7KIh/YjMLd32ztZjx7ysQrTQzIkZBPl3xqskB89Zgvd2UfPyy1LumE5YZwxsTWIZ
         iQcoirM1moBiBCG8HYTqD6e4B9Bwg++vFZ8oekeAH3VNKAvKmnnLDcm86T7aBCIgYjLC
         lJQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783484069; x=1784088869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=D6iJwB/8YlEWzCojE2dbEM2JmoS9HStIh03zd/GRlIY=;
        b=PiB9dnBAiqCKzAymzOM3Ln8d5Kr4SNbR/1H7XvkEMgWmuDAlEomgx1oxtcOa+O9sEB
         6U20XevWkKxXgrRMjSOtuTlUwRcfGZR88If/JgJ9fGG3dmrXay05lL1WdYZt1LJLm6/O
         ea+cmvRZ1EEyOe7OQALssMblzYWEdQ/LAvzIk+3MdKz61oBM0GLZj041v0vh7Ncoip9G
         14lQTO8rLSx/+l/sjNrGoVhyLCmAUhL7thfWmZPiXp/bSmBJskon2nraqmwE4bVxFx7r
         SQtsJTBY3gWo7vblwo5hQCUPv+RrTvSxl8tgH/btIOf2Hv1Igv3bNFKLZOgDvDCfCDjO
         koCQ==
X-Gm-Message-State: AOJu0Yz6SCL45KnmWU4VJh3ZJkiaVvsTpocrK0bW3VtYmYMeEJWZX67g
	2tcYCJ9xDZM0ybpK8RHPy0wRDjZ12tAdbnRY/NCfjlqBYnSy7nKxuinCuvcqUA==
X-Gm-Gg: AfdE7clI+X0TSdDF/Qksf3OjM62lRF9Qq+7Z0SBchMnaMMowK4j6VWl8yZubzhxEpVA
	x7Ni/iBzhG/Oq72GDMinFAuz9Z1GLrxNnNBFULH+9SjfXKye2/r1OnewPuvn3qS79QEvMfXf1PZ
	T65c4VoYQKnQmszrheTMsjvrvCOVDLD7JgyKMWztxKcefY7zKYGxWL7wL0vcz0O25KnqlE53KLj
	WRVzXqoK121Hjhuf3Xfu7ObqOzQIILfUgLup1k++Ez29PfxLZ7bHEAYeIghdrh0wqUUB7z7zxKj
	HX92bdmZ9ijBPqEu3V2SWXBYWPXUpIFQ34BhAtDWkAt4I7itmTbF7aQ4cVigZYY6kmIoBOBGRhr
	gRAyZsv81MOQH7/sxXeW1lcYFuNGWBl2LPrF1L9ijIwjMB8ajZJr86t9zkILXuUzbwueh53EkFq
	zBexDiknBqnA0LtHjBLMOF
X-Received: by 2002:a05:6808:3189:b0:495:da3c:1aa with SMTP id 5614622812f47-4a202b91168mr614462b6e.16.1783484069085;
        Tue, 07 Jul 2026 21:14:29 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4a1acc83099sm931498b6e.2.2026.07.07.21.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 21:14:28 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 09/11] odb/transaction: introduce ODB transaction flags
Date: Tue,  7 Jul 2026 23:14:10 -0500
Message-ID: <20260708041412.1157499-10-jltobler@gmail.com>
X-Mailer: git-send-email 2.55.0.122.gf85a7e6620
In-Reply-To: <20260708041412.1157499-1-jltobler@gmail.com>
References: <20260624041920.2601961-1-jltobler@gmail.com>
 <20260708041412.1157499-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The temporary directory used by git-receive-pack(1) to write objects is
managed slightly differently than how it is done via ODB transactions:

  - The temporary directory is eagerly created upfront, instead of
    waiting for the first object write.

  - The prefix name of the temporary directory is "incoming" instead of
    "bulk-fsync".

In a subsequent commit, git-receive-pack(1) will use ODB transactions
instead of `tmp_objdir` directly. To provide a means to configure the
same transaction behavior, introduce `enum odb_transaction_flags` and
the ODB_TRANSACTION_RECEIVE flag intended as a signal for ODB
transactions using the "files" backend to be set up for
git-receive-pack(1). Transaction call sites are updated accordingly to
provide the required flag parameter.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 builtin/add.c            |  2 +-
 builtin/unpack-objects.c |  2 +-
 builtin/update-index.c   |  2 +-
 cache-tree.c             |  2 +-
 object-file.c            | 29 ++++++++++++++++++++++++++---
 object-file.h            |  4 +++-
 odb/source-files.c       |  5 +++--
 odb/source-inmemory.c    |  3 ++-
 odb/source-loose.c       |  3 ++-
 odb/source.h             |  9 ++++++---
 odb/transaction.c        |  5 +++--
 odb/transaction.h        | 15 +++++++++++----
 read-cache.c             |  2 +-
 13 files changed, 61 insertions(+), 22 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 3d5d9cfdb9..60ffbede2b 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -581,7 +581,7 @@ int cmd_add(int argc,
 		string_list_clear(&only_match_skip_worktree, 0);
 	}
 
-	odb_transaction_begin_or_die(repo->objects, &transaction);
+	odb_transaction_begin_or_die(repo->objects, &transaction, 0);
 
 	ps_matched = xcalloc(pathspec.nr, 1);
 	if (add_renormalize)
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index d0136cdd99..c3d0fc7507 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -598,7 +598,7 @@ static void unpack_all(void)
 		progress = start_progress(the_repository,
 					  _("Unpacking objects"), nr_objects);
 	CALLOC_ARRAY(obj_list, nr_objects);
-	odb_transaction_begin_or_die(the_repository->objects, &transaction);
+	odb_transaction_begin_or_die(the_repository->objects, &transaction, 0);
 	for (i = 0; i < nr_objects; i++) {
 		unpack_one(i);
 		display_progress(progress, i + 1);
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 17f3ea284c..bf6ea60ef4 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1124,7 +1124,7 @@ int cmd_update_index(int argc,
 	 * Allow the object layer to optimize adding multiple objects in
 	 * a batch.
 	 */
-	odb_transaction_begin_or_die(the_repository->objects, &transaction);
+	odb_transaction_begin_or_die(the_repository->objects, &transaction, 0);
 	while (ctx.argc) {
 		if (parseopt_state != PARSE_OPT_DONE)
 			parseopt_state = parse_options_step(&ctx, options,
diff --git a/cache-tree.c b/cache-tree.c
index 8eec1d4d52..99c6a0a7d0 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -492,7 +492,7 @@ int cache_tree_update(struct index_state *istate, int flags)
 	trace_performance_enter();
 	trace2_region_enter("cache_tree", "update", istate->repo);
 	if (!inflight)
-		odb_transaction_begin_or_die(the_repository->objects, &transaction);
+		odb_transaction_begin_or_die(the_repository->objects, &transaction, 0);
 	i = update_one(istate->cache_tree, istate->cache, istate->cache_nr,
 		       "", 0, &skip, flags);
 	if (!inflight)
diff --git a/object-file.c b/object-file.c
index 9b8ee6f36c..d95bdabba5 100644
--- a/object-file.c
+++ b/object-file.c
@@ -498,6 +498,7 @@ struct odb_transaction_files {
 
 	struct tmp_objdir *objdir;
 	struct transaction_packfile packfile;
+	const char *prefix;
 };
 
 static int odb_transaction_files_prepare(struct odb_transaction *base)
@@ -514,7 +515,7 @@ static int odb_transaction_files_prepare(struct odb_transaction *base)
 	if (!transaction || transaction->objdir)
 		return 0;
 
-	transaction->objdir = tmp_objdir_create(base->source->odb->repo, "bulk-fsync");
+	transaction->objdir = tmp_objdir_create(base->source->odb->repo, transaction->prefix);
 	if (!transaction->objdir)
 		return -1;
 
@@ -1359,7 +1360,7 @@ int index_fd(struct index_state *istate, struct object_id *oid,
 			int inflight = !!transaction;
 
 			if (!inflight)
-				odb_transaction_begin_or_die(odb, &transaction);
+				odb_transaction_begin_or_die(odb, &transaction, 0);
 			ret = odb_transaction_write_object_stream(transaction,
 								  &stream,
 								  xsize_t(st->st_size),
@@ -1701,7 +1702,8 @@ static int odb_transaction_files_env(struct odb_transaction *base,
 }
 
 int odb_transaction_files_begin(struct odb_source *source,
-				struct odb_transaction **out)
+				struct odb_transaction **out,
+				enum odb_transaction_flags flags)
 {
 	struct odb_transaction_files *transaction;
 
@@ -1710,6 +1712,27 @@ int odb_transaction_files_begin(struct odb_source *source,
 	transaction->base.commit = odb_transaction_files_commit;
 	transaction->base.write_object_stream = odb_transaction_files_write_object_stream;
 	transaction->base.env = odb_transaction_files_env;
+
+	transaction->prefix = "bulk-fsync";
+	if (flags & ODB_TRANSACTION_RECEIVE) {
+		/*
+		 * ODB transactions for git-receive-pack(1) eagerly create a
+		 * temporary directory and use a different temporary directory
+		 * prefix.
+		 *
+		 * NEEDSWORK: This transaction flag is only used by the "files"
+		 * backend to special case temporary directory set up and
+		 * handling. Ideally transaction users should not have to care
+		 * though. To avoid this, we could eagerly create the temporary
+		 * directory and use the same prefix name for all transactions.
+		 */
+		transaction->prefix = "incoming";
+		if (odb_transaction_files_prepare(&transaction->base)) {
+			free(transaction);
+			return -1;
+		}
+	}
+
 	*out = &transaction->base;
 
 	return 0;
diff --git a/object-file.h b/object-file.h
index 1a023226ac..bdd2d67a2e 100644
--- a/object-file.h
+++ b/object-file.h
@@ -5,6 +5,7 @@
 #include "object.h"
 #include "odb.h"
 #include "odb/source-loose.h"
+#include "odb/transaction.h"
 
 /* The maximum size for an object header. */
 #define MAX_HEADER_LEN 32
@@ -197,6 +198,7 @@ struct odb_transaction;
  * to make new objects visible.
  */
 int odb_transaction_files_begin(struct odb_source *source,
-				struct odb_transaction **out);
+				struct odb_transaction **out,
+				enum odb_transaction_flags flags);
 
 #endif /* OBJECT_FILE_H */
diff --git a/odb/source-files.c b/odb/source-files.c
index 2545bd81d4..534f48aad9 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -180,9 +180,10 @@ static int odb_source_files_write_object_stream(struct odb_source *source,
 }
 
 static int odb_source_files_begin_transaction(struct odb_source *source,
-					      struct odb_transaction **out)
+					      struct odb_transaction **out,
+					      enum odb_transaction_flags flags)
 {
-	return odb_transaction_files_begin(source, out);
+	return odb_transaction_files_begin(source, out, flags);
 }
 
 static int odb_source_files_read_alternates(struct odb_source *source,
diff --git a/odb/source-inmemory.c b/odb/source-inmemory.c
index e004566d76..9644d9d474 100644
--- a/odb/source-inmemory.c
+++ b/odb/source-inmemory.c
@@ -304,7 +304,8 @@ static int odb_source_inmemory_freshen_object(struct odb_source *source,
 }
 
 static int odb_source_inmemory_begin_transaction(struct odb_source *source UNUSED,
-						 struct odb_transaction **out UNUSED)
+						 struct odb_transaction **out UNUSED,
+						 enum odb_transaction_flags flags UNUSED)
 {
 	return error("in-memory source does not support transactions");
 }
diff --git a/odb/source-loose.c b/odb/source-loose.c
index 66e6bb8d3f..57c91986b4 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -638,7 +638,8 @@ static int odb_source_loose_write_object_stream(struct odb_source *source,
 }
 
 static int odb_source_loose_begin_transaction(struct odb_source *source UNUSED,
-					      struct odb_transaction **out UNUSED)
+					      struct odb_transaction **out UNUSED,
+					      enum odb_transaction_flags flags UNUSED)
 {
 	/* TODO: this is a known omission that we'll want to address eventually. */
 	return error("loose source does not support transactions");
diff --git a/odb/source.h b/odb/source.h
index 2192a101b8..3790d03ff2 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -3,6 +3,7 @@
 
 #include "object.h"
 #include "odb.h"
+#include "odb/transaction.h"
 
 enum odb_source_type {
 	/*
@@ -228,7 +229,8 @@ struct odb_source {
 	 * negative error code otherwise.
 	 */
 	int (*begin_transaction)(struct odb_source *source,
-				 struct odb_transaction **out);
+				 struct odb_transaction **out,
+				 enum odb_transaction_flags flags);
 
 	/*
 	 * This callback is expected to read the list of alternate object
@@ -467,9 +469,10 @@ static inline int odb_source_write_alternate(struct odb_source *source,
  * Returns 0 on success, a negative error code otherwise.
  */
 static inline int odb_source_begin_transaction(struct odb_source *source,
-					       struct odb_transaction **out)
+					       struct odb_transaction **out,
+					       enum odb_transaction_flags flags)
 {
-	return source->begin_transaction(source, out);
+	return source->begin_transaction(source, out, flags);
 }
 
 #endif
diff --git a/odb/transaction.c b/odb/transaction.c
index acb1c967e7..007ab73c0c 100644
--- a/odb/transaction.c
+++ b/odb/transaction.c
@@ -3,14 +3,15 @@
 #include "odb/transaction.h"
 
 int odb_transaction_begin(struct object_database *odb,
-			  struct odb_transaction **out)
+			  struct odb_transaction **out,
+			  enum odb_transaction_flags flags)
 {
 	int ret;
 
 	if (odb->transaction)
 		return -1;
 
-	ret = odb_source_begin_transaction(odb->sources, out);
+	ret = odb_source_begin_transaction(odb->sources, out, flags);
 	odb->transaction = *out;
 
 	return ret;
diff --git a/odb/transaction.h b/odb/transaction.h
index 1c6c97a53e..b19f180aee 100644
--- a/odb/transaction.h
+++ b/odb/transaction.h
@@ -4,7 +4,6 @@
 #include "git-compat-util.h"
 #include "gettext.h"
 #include "odb.h"
-#include "odb/source.h"
 
 /*
  * A transaction may be started for an object database prior to writing new
@@ -45,6 +44,12 @@ struct odb_transaction {
 	int (*env)(struct odb_transaction *transaction, struct strvec *env);
 };
 
+/* Flags used to configure an ODB transaction. */
+enum odb_transaction_flags {
+	/* Configures the transaction for use with git-receive-pack(1). */
+	ODB_TRANSACTION_RECEIVE = (1 << 0),
+};
+
 /*
  * Starts an ODB transaction and returns it via `out`. Subsequent objects are
  * written to the transaction and not committed until odb_transaction_commit()
@@ -53,12 +58,14 @@ struct odb_transaction {
  * ODB already has an inflight transaction pending.
  */
 int odb_transaction_begin(struct object_database *odb,
-			  struct odb_transaction **out);
+			  struct odb_transaction **out,
+			  enum odb_transaction_flags flags);
 
 static inline void odb_transaction_begin_or_die(struct object_database *odb,
-						struct odb_transaction **out)
+						struct odb_transaction **out,
+						enum odb_transaction_flags flags)
 {
-	if (odb_transaction_begin(odb, out))
+	if (odb_transaction_begin(odb, out, flags))
 		die(_("failed to start ODB transaction"));
 }
 
diff --git a/read-cache.c b/read-cache.c
index d511d25834..50e2320c8d 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -4044,7 +4044,7 @@ int add_files_to_cache(struct repository *repo, const char *prefix,
 	 * may not have their own transaction active.
 	 */
 	if (!inflight)
-		odb_transaction_begin_or_die(repo->objects, &transaction);
+		odb_transaction_begin_or_die(repo->objects, &transaction, 0);
 	run_diff_files(&rev, DIFF_RACY_IS_MODIFIED);
 	if (!inflight)
 		odb_transaction_commit(transaction);
-- 
2.55.0.122.gf85a7e6620

