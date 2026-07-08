Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73E93AB285
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 23:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783555180; cv=none; b=BiQeHGOW7aZ+GrKeY05+DElKSlTOoy3tB6ELZqx3gYsa/+L5NqXO+x7tv7yEXhWvmTUASMjXS5526oDOis9yodcxKKCBHyzUZ8FrIzEXLIMpX4O+FLVzRmtlpBvmtsRDP+DvHO0ttuIEdTPo4RX5+h7jAIpuzpRvewD7K8gbV00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783555180; c=relaxed/simple;
	bh=CxwAAMgHs4o6KsaCziQu+4xNkoI6RGImVrXvpA3dfik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CWzyiWyZiRRG8tErnxUrXGgEYT5MPtom0ayPPAr1+ncpxxKFIimn64/mEVXnF05ceqkwt/WyNgK5sF/EznmDw8kp+CO1/ycEDKmKxkhIuNjlXUSQhT56TXpR8EvmxsUuTG6B3r4loEAC9zx/JMxx+/zIWc0SC1q/FPtlboTKT0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U+6HbdlO; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+6HbdlO"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-69eb8b6bea8so606759eaf.3
        for <git@vger.kernel.org>; Wed, 08 Jul 2026 16:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783555177; x=1784159977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YnhCpFmka6sPSPCbQTB/axCVDjjJNybZSM7INSNjo5M=;
        b=U+6HbdlO3izEgpIX0MZ5bUDT7QYjt4FKZd1Zw6d4DA7BoMXG5TJrw+2go2qRKvVmSV
         88WblgJhCbO1XSfhCXqaE2FG139fuwYqyCc2jdH5MLicrD7JXNHcWodHQZsh7h38hunP
         472rTp3XdvugR2xCoDPEbBhIasfRUyGXEVG2nbHmLUfmz029SDdlNCmc6wj8fxRY1cH6
         SDMcdGmZW9ER7LeKPKMjfIVD3P7yQr4Ux/P9j1KrH3++FMokJcEIQYqj/er4uWTOXP0d
         lacWaYqD/c9mztCl2mWN6BkuQAEdFsG+6xUeDbaDhHUVhprVZ3WJ8XAYFXk4A5qXi/ra
         WNoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783555177; x=1784159977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YnhCpFmka6sPSPCbQTB/axCVDjjJNybZSM7INSNjo5M=;
        b=HpISlOtp7BCuExII3WQUgidJE8vQsvgBNkXNO/ei43/weSCkRiUML47LESHWzLVpiW
         fjP7eTE1Om/hKU0wlUqg3mhxEFLU2hV+tBBuypUJCWafISgyQWYGGyI4XB45XFdvD3mm
         og/WQ+quYSloWhX5h1tvQwzsrbaiv94foT9g8Uy+QzF1zt7JzA0751G3Y0jgqI63cw46
         54XGjCngdCQf5+vlUDbHOfjiP1Gp209bz99z2vPMoENT3UPGVKzZ7XR1SM9oqUqcdCIi
         jGBhZl0gEap2QynlpwELpb4W/2jTeiBPfijRYNwiQrO3sdyOdGgkO1WpGdUBAvw27sBj
         QB1w==
X-Gm-Message-State: AOJu0YzoV855QW6GM+e8829Z87iaw5GZ/1h7brFkNlm1C+oSeUZqFa2T
	mEbuO0mLe6HJhE7GZPrSSwQVNTKbjbCJoZqOKGucFDziT750wl0+t5C6+c1r7Q==
X-Gm-Gg: AfdE7cm9WWN3Kn6xCb2BLpX6XyUqikenIOzuwLSpCTwAv3+DL9Tr+qDHtu6Me5cTQsy
	HHsYIobiU5aAg2ebQFykexxqlqe+ugg2xfDUcHSO+72Xfx+sxS7xUNLoPC+lLWN8fVDoSWNqWWD
	6/GCy+9UVRhJtoGlYt2lB2mFpoWqx0oLhTJgjkBqSpV4+ZVMWf0bT5T3JE3XIIyg4sd9TMwIAbN
	DpD9rEerW2UYgY8WOn61aY9ClpReKWQ+Mgul+ODWrUp3Fht3GLvg2UFd3p+HBgLXT8k+EcDhfEY
	RikIee9nbXcDInvmoQkeAfGOfg8ysi8z92YepgyAuxowDETEgBEVFUIE1EbHZnte8oDUdC93SGK
	uRBR9IEzTmdCfbvABZfUVWtd2YQr/GvlnRhcR2imgGeHgxKwopqrj1n8S7HPiqSzax0yVsIaggU
	ovMiCM6kjyxOfKvb1zqtS0
X-Received: by 2002:a05:6820:138f:b0:6a1:50eb:d514 with SMTP id 006d021491bc7-6a36da8a6e6mr3319108eaf.69.1783555176630;
        Wed, 08 Jul 2026 16:59:36 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-45191643994sm490110fac.9.2026.07.08.16.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 16:59:36 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 06/11] odb/transaction: propagate begin errors
Date: Wed,  8 Jul 2026 18:59:20 -0500
Message-ID: <20260708235925.3992097-7-jltobler@gmail.com>
X-Mailer: git-send-email 2.55.0.122.gf85a7e6620
In-Reply-To: <20260708235925.3992097-1-jltobler@gmail.com>
References: <20260708041412.1157499-1-jltobler@gmail.com>
 <20260708235925.3992097-1-jltobler@gmail.com>
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
 odb/transaction.c        | 13 +++++++++----
 odb/transaction.h        | 19 +++++++++++++++----
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
index 3651605ea2..358684beae 100644
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
index b16e07aebf..a5fba7f908 100644
--- a/odb/transaction.c
+++ b/odb/transaction.c
@@ -1,15 +1,20 @@
 #include "git-compat-util.h"
+#include "gettext.h"
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
+		return error(_("object database transaction already pending"));
 
-	odb_source_begin_transaction(odb->sources, &odb->transaction);
+	ret = odb_source_begin_transaction(odb->sources, out);
+	odb->transaction = *out;
 
-	return odb->transaction;
+	return ret;
 }
 
 void odb_transaction_commit(struct odb_transaction *transaction)
diff --git a/odb/transaction.h b/odb/transaction.h
index d52f0533ce..f5c43187c9 100644
--- a/odb/transaction.h
+++ b/odb/transaction.h
@@ -1,6 +1,7 @@
 #ifndef ODB_TRANSACTION_H
 #define ODB_TRANSACTION_H
 
+#include "gettext.h"
 #include "odb.h"
 #include "odb/source.h"
 
@@ -36,11 +37,21 @@ struct odb_transaction {
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

