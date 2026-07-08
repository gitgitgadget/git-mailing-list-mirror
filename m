Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B443B8D4A
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 04:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783484068; cv=none; b=NEJT3Q1HiKbfQQ+NGy+NENzuT36kuDBA0LxsZpkpCdMkT6cFWsN24rNm69uquuMmuVDjC/J7R7vaNndSdw1VY416FTizHq+FO4j8EvXV2MX5gbYsicrc5vXjI3D896JrChSWhXSjwgXXrKbUoh+QbhOJsQBOconR6rG7hFgajJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783484068; c=relaxed/simple;
	bh=PDgCSNS8nNDXCVYY83mduhKvp1faOTvArBpLu6QK0uQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vE5iIi2GwARWMxAt/7TZIxUSuak7tc57ICpTh8Juho+Su7r17lwtIQ0v3yJbKBoGZUDUPcttcL1ijLnp8xXOvLPiyw6LVGpzWJTchIWQABWP7A2Y3UxyKryclRPOujR9vH/sqDVcd43WX32fgRJhSBZiyLFRiQ10Pg4T1Z/wDoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jfwhw/OS; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jfwhw/OS"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-43cce8288c7so107165fac.3
        for <git@vger.kernel.org>; Tue, 07 Jul 2026 21:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783484065; x=1784088865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C2FH3PndeHEmmSo5Bs48UP2UsFVdbZeSm5qimL6RvIc=;
        b=Jfwhw/OSlLCU2M1fWBeNz2t3FExrxyOmQ6fl5UiGUizZnd2/R/zuNUCFOjC+F97VlP
         fq/wuv1gldu308V7uVqLEhUtY3rBC4Z3QswjmQEK/kG8664qK78UAHbgNTV4B/8gmtbC
         lULaOFQOk+JyRDniY46XymFTXDg1105NI6uJRVrzaGZDfu6WrDujgnWme4c6V/k5wsZf
         8CFNbCJRBrJlz6PV80zclNsRlG6OcRAbrl96I8kCGMp++trqcV1RMTz0kgNtE2MpifxC
         Qqlsj3G/k+U4RT2Sfj/gsZJaos/KwQmZeQZmDJfAq4qjhx11rWy6RYR/RvgMYr8h5VHU
         v8jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783484065; x=1784088865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C2FH3PndeHEmmSo5Bs48UP2UsFVdbZeSm5qimL6RvIc=;
        b=i9l1vqW/8nf0KWz3b0tYwW1EcFcsAiJ8g4v4llCLzjzSjI2RTrYAsIY9dyyYmMCzot
         gKOLctdygEYNEz5XDY4Bxhxo0TrZPQhFeULeGzda5FWDSW58UxSBcBP4ZqyqgOuLCMjd
         AIVrUDP4DZQjjK9v2iX5YX+UitPY1+PR6C9FQvQ/tvAm7Ui82C+0SpCOhxXyoNqZ+cgb
         8lEpayigjFL5UPDhclEH4V5duoT1Ro6NRegKBmgBlkWrm9IOSOnu1RLbXNwFxZk1iUpu
         h+X0hZ+t/iAZDxbhzCfhQ0c3pTGqoLTABCDF5HV58+rwyLJQAV0+JVjBYlXHQnfStxUX
         03gA==
X-Gm-Message-State: AOJu0Yy+4IInztK4vOhEucx5P+uJnr5C3TpohM8BD4pMmo3bS9KjFAJA
	J9gKZqFQsXBJPxeVpz0s8s1bBznM5AO1CwZDUxc6dHHmVXAIeV9dPEddBc5eGQ==
X-Gm-Gg: AfdE7cm1DAFChBrc1HqNPQgJU1IaAR/1B9F9KlZ2PNXQhCl3wJZg5Z9AwXZTkYvrICd
	W1MlSYiJnGEdtVis6vD7RqvMs9Dt4/xnj1s7jW8AL1nuiKeb6C7C3g1E2Zh/InuIws6l/51+57V
	sxKZQC9/dmfqufwPT54+YEjtCKpMceoimeM1wBeHcK0jdcRsxZj0Bg6PewkhMIyJXv+DXoHkxBh
	ru811z83GhaEWKWdOi2Qc0Qd992qwL6+dts0uCL0nfkZR9045EXhEYD5KXH6MqiDcdfaUBsDmhB
	2dYK98Y17BdxlBl9YH+tZ76wWzYoUo/qsdLuVwyY91kk7sP+STadVaP0HOk8iOlMM5SUELXGYZs
	OoJhI6YapOAsQbqOs2k1PBcSu6zbKGZ3sSWzgX9za/d3hIjoaI4+K5BkAYDXlUkSnjmh7Orh2z8
	8H0CSZ6QzYz3qyqPiT8wrTzSZkUO0/KEA=
X-Received: by 2002:a05:6808:5244:b0:496:10e6:f76e with SMTP id 5614622812f47-4a2030a3ef6mr765089b6e.4.1783484065291;
        Tue, 07 Jul 2026 21:14:25 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4a1acc83099sm931498b6e.2.2026.07.07.21.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 21:14:24 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 06/11] odb/transaction: propagate begin errors
Date: Tue,  7 Jul 2026 23:14:07 -0500
Message-ID: <20260708041412.1157499-7-jltobler@gmail.com>
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

When `odb_transaction_begin()` is invoked, the function returns the
transaction pointer directly. There is no way for the backend to
signal that it failed to set up its state, such as when creating the
temporary object directory backing the transaction.

In a subsequent commit, git-receive-pack(1) starts using ODB
transactions and needs to be able to report such failures rather
than silently ignore them. Refactor `odb_transaction_begin()` to
return an int error code and write the resulting transaction into an
out parameter. Also introduce `odb_transaction_begin_or_die()` as a
convenience for callsites that do not need to handle errors
explicitly.

Note that `odb_transaction_begin()` now returns an error when the ODB
already has an inflight transaction pending. ODB transaction call sites
that may encounter an inflight transaction are updated to explicitly
handle this case.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 builtin/add.c            |  2 +-
 builtin/unpack-objects.c |  2 +-
 builtin/update-index.c   |  2 +-
 cache-tree.c             |  7 +++++--
 object-file.c            | 10 +++++++---
 odb/transaction.c        | 12 ++++++++----
 odb/transaction.h        | 20 ++++++++++++++++----
 read-cache.c             |  7 +++++--
 8 files changed, 44 insertions(+), 18 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index c859f66519..3d5d9cfdb9 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -581,7 +581,7 @@ int cmd_add(int argc,
 		string_list_clear(&only_match_skip_worktree, 0);
 	}
 
-	transaction = odb_transaction_begin(repo->objects);
+	odb_transaction_begin_or_die(repo->objects, &transaction);
 
 	ps_matched = xcalloc(pathspec.nr, 1);
 	if (add_renormalize)
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index f3849bb654..d0136cdd99 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -598,7 +598,7 @@ static void unpack_all(void)
 		progress = start_progress(the_repository,
 					  _("Unpacking objects"), nr_objects);
 	CALLOC_ARRAY(obj_list, nr_objects);
-	transaction = odb_transaction_begin(the_repository->objects);
+	odb_transaction_begin_or_die(the_repository->objects, &transaction);
 	for (i = 0; i < nr_objects; i++) {
 		unpack_one(i);
 		display_progress(progress, i + 1);
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 3d6646c318..17f3ea284c 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1124,7 +1124,7 @@ int cmd_update_index(int argc,
 	 * Allow the object layer to optimize adding multiple objects in
 	 * a batch.
 	 */
-	transaction = odb_transaction_begin(the_repository->objects);
+	odb_transaction_begin_or_die(the_repository->objects, &transaction);
 	while (ctx.argc) {
 		if (parseopt_state != PARSE_OPT_DONE)
 			parseopt_state = parse_options_step(&ctx, options,
diff --git a/cache-tree.c b/cache-tree.c
index 184f7e2635..8eec1d4d52 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -474,6 +474,7 @@ static int update_one(struct cache_tree *it,
 
 int cache_tree_update(struct index_state *istate, int flags)
 {
+	int inflight = !!the_repository->objects->transaction;
 	struct odb_transaction *transaction;
 	int skip, i;
 
@@ -490,10 +491,12 @@ int cache_tree_update(struct index_state *istate, int flags)
 
 	trace_performance_enter();
 	trace2_region_enter("cache_tree", "update", istate->repo);
-	transaction = odb_transaction_begin(the_repository->objects);
+	if (!inflight)
+		odb_transaction_begin_or_die(the_repository->objects, &transaction);
 	i = update_one(istate->cache_tree, istate->cache, istate->cache_nr,
 		       "", 0, &skip, flags);
-	odb_transaction_commit(transaction);
+	if (!inflight)
+		odb_transaction_commit(transaction);
 	trace2_region_leave("cache_tree", "update", istate->repo);
 	trace_performance_leave("cache_tree_update");
 	if (i < 0)
diff --git a/object-file.c b/object-file.c
index 64cb874fe7..cd1aa36462 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1354,13 +1354,17 @@ int index_fd(struct index_state *istate, struct object_id *oid,
 
 		if (flags & INDEX_WRITE_OBJECT) {
 			struct object_database *odb = the_repository->objects;
-			struct odb_transaction *transaction = odb_transaction_begin(odb);
+			struct odb_transaction *transaction = odb->transaction;
+			int inflight = !!transaction;
 
-			ret = odb_transaction_write_object_stream(odb->transaction,
+			if (!inflight)
+				odb_transaction_begin_or_die(odb, &transaction);
+			ret = odb_transaction_write_object_stream(transaction,
 								  &stream,
 								  xsize_t(st->st_size),
 								  oid);
-			odb_transaction_commit(transaction);
+			if (!inflight)
+				odb_transaction_commit(transaction);
 		} else {
 			ret = hash_blob_stream(&stream,
 					       the_repository->hash_algo, oid,
diff --git a/odb/transaction.c b/odb/transaction.c
index b16e07aebf..df4275151b 100644
--- a/odb/transaction.c
+++ b/odb/transaction.c
@@ -2,14 +2,18 @@
 #include "odb/source.h"
 #include "odb/transaction.h"
 
-struct odb_transaction *odb_transaction_begin(struct object_database *odb)
+int odb_transaction_begin(struct object_database *odb,
+			  struct odb_transaction **out)
 {
+	int ret;
+
 	if (odb->transaction)
-		return NULL;
+		return -1;
 
-	odb_source_begin_transaction(odb->sources, &odb->transaction);
+	ret = odb_source_begin_transaction(odb->sources, out);
+	odb->transaction = *out;
 
-	return odb->transaction;
+	return ret;
 }
 
 void odb_transaction_commit(struct odb_transaction *transaction)
diff --git a/odb/transaction.h b/odb/transaction.h
index d52f0533ce..36032a5365 100644
--- a/odb/transaction.h
+++ b/odb/transaction.h
@@ -1,6 +1,8 @@
 #ifndef ODB_TRANSACTION_H
 #define ODB_TRANSACTION_H
 
+#include "git-compat-util.h"
+#include "gettext.h"
 #include "odb.h"
 #include "odb/source.h"
 
@@ -36,11 +38,21 @@ struct odb_transaction {
 };
 
 /*
- * Starts an ODB transaction. Subsequent objects are written to the transaction
- * and not committed until odb_transaction_commit() is invoked on the
- * transaction. If the ODB already has a pending transaction, NULL is returned.
+ * Starts an ODB transaction and returns it via `out`. Subsequent objects are
+ * written to the transaction and not committed until odb_transaction_commit()
+ * is invoked on the transaction. Returns 0 on success and a negative value on
+ * error. Note that it is considered an error to start a new transaction if the
+ * ODB already has an inflight transaction pending.
  */
-struct odb_transaction *odb_transaction_begin(struct object_database *odb);
+int odb_transaction_begin(struct object_database *odb,
+			  struct odb_transaction **out);
+
+static inline void odb_transaction_begin_or_die(struct object_database *odb,
+						struct odb_transaction **out)
+{
+	if (odb_transaction_begin(odb, out))
+		die(_("failed to start ODB transaction"));
+}
 
 /*
  * Commits an ODB transaction making the written objects visible. If the
diff --git a/read-cache.c b/read-cache.c
index 21ca58beea..d511d25834 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -4012,6 +4012,7 @@ int add_files_to_cache(struct repository *repo, const char *prefix,
 		       const struct pathspec *pathspec, char *ps_matched,
 		       int include_sparse, int flags, int ignored_too )
 {
+	int inflight = !!repo->objects->transaction;
 	struct odb_transaction *transaction;
 	struct update_callback_data data;
 	struct rev_info rev;
@@ -4042,9 +4043,11 @@ int add_files_to_cache(struct repository *repo, const char *prefix,
 	 * This function is invoked from commands other than 'add', which
 	 * may not have their own transaction active.
 	 */
-	transaction = odb_transaction_begin(repo->objects);
+	if (!inflight)
+		odb_transaction_begin_or_die(repo->objects, &transaction);
 	run_diff_files(&rev, DIFF_RACY_IS_MODIFIED);
-	odb_transaction_commit(transaction);
+	if (!inflight)
+		odb_transaction_commit(transaction);
 
 	release_revisions(&rev);
 	return !!data.add_errors;
-- 
2.55.0.122.gf85a7e6620

