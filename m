Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2682E4257
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 23:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783555182; cv=none; b=ZJQ2219u0lITawwAQ8L8zW7Jma9aUZBXVkfpQKMJqeR350cqn2XuhYPVGFG3gu9MjGgbufpFKaBFXjrBimsinqGPPbBMoaRlHp2hsEdgc0/0gPqnlDsr6dXHsFs5f/lGjz45lP7cEiXrE9YStN41GLcNGUa0ryUgVf1Uz8ZJxds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783555182; c=relaxed/simple;
	bh=N0vZlmyDoHH71xPbKAQqH5lwmCMv5oPonNJZOXziXTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bDPvhTNs7dCIloKocl+YR6heWDmnERYhY1zRxzFrRWlzsfGTT6J6tiJN/nc3PneKcPHVBENzo4qZ+FrAliufdJxyGtRIuFdY8XNPvutAM15gr6vLXm9K0cAr8viLy/2UBsiaf+yB/6N02gXrHz4FpxGv45/KSu27OaR0oGq3OFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p+qLKTC0; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p+qLKTC0"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-448de0cc236so554999fac.2
        for <git@vger.kernel.org>; Wed, 08 Jul 2026 16:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783555179; x=1784159979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DyFYS1IYda1B99xQ25WwC6zuOzyS+2GObR7+KuY4AxU=;
        b=p+qLKTC0RF1l7RM1fDt4TQ0tqgch6r9eYxYOAIvz9anwIU9xlQ6mbPuyVhnB/MhcbI
         3bECzhaMruD4Xv4uKalB3JTSm43zOLQbJDzsURPyf1SY/BrG2qMA3bu4hTBVldzcoVPK
         UXTWTrFvTjP8InFenswpay63Q3D6GoSSmUdm4vyhftSL/YtAQABGyZVGT+xmWsA8KCkL
         ApWvYDK1zg3mi7le9lL/rN0eaH3M+3TFmCIe7n4wcG/j+oyIy1z1aUxE+MPdp3ynOCUV
         H+aWjk61B/g5IXBdUrEts3E1Ll6HVV4QzXDLNO/z34AnEyYHLS08waqkN5TnsccBXjrs
         7lWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783555179; x=1784159979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DyFYS1IYda1B99xQ25WwC6zuOzyS+2GObR7+KuY4AxU=;
        b=KYjhYXu6970a1aSiidoT62C2WNonuDijkCkkJTrricHNmGX4enkPzbLeOL/6xZqF4T
         yAKVbyCyE3x/FQACCgH4uZfidtIX5ntXNBCSQHiO9LakpVgX5vJUS8IWgkl6Lv3dBvCW
         3fXpPvxSEuSIWgs9U6hzd8m+D6fPs8LUL14Ze+SC8NEkyVKP7rNd3lDyvNYQ5j7L7Cji
         Xxe3Mh74ad2yR7MRWr0raG9QCcyZ7rNTS6SD+i/ypTDV7MNuAxSXDHWvciqsqsVaEM1S
         bWD2n+LRV/Uj19GOdpzBmIs31df4sfB7XJysqzpapS7RgBrWb+7cwt9sZoqbedHul/iG
         ekhQ==
X-Gm-Message-State: AOJu0YxtAKNkGunU3e3DC1B6FfD4WdYuGQ/TMvsckrpDmg6v2z/DuA5r
	yYhH8B/6SAy1QKTVY8P7bOYAwdjMACryKbpu/OrM9V3c6mpRqgMXuoG1PZB+gg==
X-Gm-Gg: AfdE7cl6dVju1fQ7zKxD65WofooD3nhIaYik1Yme/6piLhLyFNeTxe0Pg4BHCz2VxXD
	1gBUpUnYKGXIMThqbvxQsm2FGrepvkCJQEjfGNvNM2GFVtv0y2xCXugH0Jeud5bOVMjmN7A6rwq
	yf0n1kbFm2UMxRwzfvyoHjqd5CLmu4U+2+cGiXK2atYTh/LwUWUDQ8sF/08RHvdzYDDr4nttlqs
	nc0TAMyULhRZGh+FVx3lcmyEIWU2KXlV0d3b66twzMj/dtBwc0DEZyaCpBQ4yYvJE/svID8Vzjs
	ADq/yG3aTLnpohQO22rGLfGCgMwQf80BHtcJEwDO37j31M/T1Fp/qPlg+oj/LNC/MqgXlDdlg6Y
	T+0ks5dG4JCQhtaUUZaiS8CpO0xgfhmri7ot5FiovKUrsvUK1s9dCvDyDfWkIEBIuDiaCfUfevc
	QFX4aaZVtlVMtDMOkn3mwF
X-Received: by 2002:a05:6871:2ea8:b0:43d:5d22:4719 with SMTP id 586e51a60fabf-45163bfc3e8mr3289060fac.22.1783555179023;
        Wed, 08 Jul 2026 16:59:39 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-45191643994sm490110fac.9.2026.07.08.16.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 16:59:38 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 09/11] odb/transaction: introduce ODB transaction flags
Date: Wed,  8 Jul 2026 18:59:23 -0500
Message-ID: <20260708235925.3992097-10-jltobler@gmail.com>
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
index f0b066798a..d2508d148f 100644
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
 		return error(_("unable to create temporary object directory"));
 
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
index 7f1b30945d..edf5488c81 100644
--- a/odb/transaction.c
+++ b/odb/transaction.c
@@ -4,14 +4,15 @@
 #include "odb/transaction.h"
 
 int odb_transaction_begin(struct object_database *odb,
-			  struct odb_transaction **out)
+			  struct odb_transaction **out,
+			  enum odb_transaction_flags flags)
 {
 	int ret;
 
 	if (odb->transaction)
 		return error(_("object database transaction already pending"));
 
-	ret = odb_source_begin_transaction(odb->sources, out);
+	ret = odb_source_begin_transaction(odb->sources, out, flags);
 	odb->transaction = *out;
 
 	return ret;
diff --git a/odb/transaction.h b/odb/transaction.h
index 5e51ce5ca4..4cb2eafcbf 100644
--- a/odb/transaction.h
+++ b/odb/transaction.h
@@ -3,7 +3,6 @@
 
 #include "gettext.h"
 #include "odb.h"
-#include "odb/source.h"
 
 /*
  * A transaction may be started for an object database prior to writing new
@@ -44,6 +43,12 @@ struct odb_transaction {
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
@@ -52,12 +57,14 @@ struct odb_transaction {
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

