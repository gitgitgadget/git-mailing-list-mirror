Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AA4380FFB
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 04:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782274772; cv=none; b=Ynraz5sztePGMAMJRCQ5KjWmVkYUfI6c3gEKnlNIxODEu3z6N/LbJn57tu3ENXtiOBorf8Cd2wJmOj7TQyA5x4Vvremy2pHf1JB/Th08PLwe/SKia0ZDh8EYzRmaYNI0ASBMLqlaHfV9efK7dUCnqswcC/nwPL+sdmHAgWgeXuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782274772; c=relaxed/simple;
	bh=Vh2Rx5Fl5xoB4vfvibNzAf9CLn1aT/WiDaRxrRN2cTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=StfucY2npw1nlAeIioDk6c6OMtew3Yc2GEYcy+shYohKe9nCxX5OekzEFSARQz7ohYrnESoKJ38gPQQDPgzT0QdULCQDyYmsNnhJobOSSt87vhigal8Ksc+vHZ20n3HF4XyPoNbO8zhmBoATjX59Uia60x/ZbVdoZpFr/gKN+HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O+kGqkM9; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+kGqkM9"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-4877a7b451dso538483b6e.0
        for <git@vger.kernel.org>; Tue, 23 Jun 2026 21:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782274770; x=1782879570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cJzMNNH+ZvMpI8G722JhLHAASwdUc3r4eJqSFaYj4wM=;
        b=O+kGqkM9o3E2IXCa9FRPgDSBRyJsGHtsi+5AqI+RpQzUO5/PsmpFFLxf4+sZ+7Q0To
         mNz/ZKn9UCFpKssN3VywNYsyl+Phhp9gXZLI8/4imz5ntOH82FlbIZCOmMlAyKyTnrni
         J7O9kPwa7qDQun5NiYsU3TAzFKNyDHs2vb+ohqgmmWRgOghk1CIYOxZvJcrCA8WWTb4H
         cwIfyG6mOHhoJGuKC6TFyaacOikbfHcek1xEVmAJWPuxD+ygECY/NbhlxVtXFITk+C2P
         htrdNbMD0Vk4jjDNZGEakhKuqqEVZyAodV+vBQedT9DH2GaxrrIhKWIUbZ2clxOlALKu
         nrUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782274770; x=1782879570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cJzMNNH+ZvMpI8G722JhLHAASwdUc3r4eJqSFaYj4wM=;
        b=NL6mkIhawrnir+IgPgg+EJrBwIVDnMvPl+8XwpgX6+5TNySgl0vvJQqn10O9lhl0Lh
         E5eGhNShr/O98JrQtQjdQtiHxtzpnm7ydWjkSYecftOj1qJrz7ExyYVGsfE3OISzt0Rn
         2cFF3GzmA0+QKpD3ZwRrVpcXv0nOkpYOH3v89loiZpmHnDDmq3xkKfFRYufWeQ4/Hzx2
         sYC1I0Y3U8fqMzN0X+syuh5zId0jglDYPyjruz/KAPx45zxfjPMbso7JBjY5Y0qLvmil
         b0s+QzItCCIoTjBQOmerKtkmj7PzrGHe3jr6BpP316YXMUDPgysKcpL7RSHnHpR8yqqP
         qjNA==
X-Gm-Message-State: AOJu0Yx3IxSKBBR4gRNcir25XBeuZ96iYdZF0Cu5QCjjEzdCbcfcCtAU
	iUKxcIYcdS8fKMD5lBuGeyFKgG0AmEcYNzGPHMHMkJyijdOwVzMQ4lS+RWXwYw==
X-Gm-Gg: AfdE7clQlc0xI9Sy64iaz5WrUFkPD9fLsAy80ps5+fBZDK7+Kas/gwEbxUTYRwOgE84
	IGvLzB/O7sbMUp7pLV4loOmEtK67lyjwGHB8ULS1Y6Ypi1AIvjxsPbHuIgqPqWK7ZV1SCXwc+Zy
	pDK1apyPoB8jjS9/I48qu1fEBdNvSiqJU4KaF12oloqHXki98CV4RRGTcCZDPy0MaMZR4qZgBrO
	yTrhsVc/ZH2staFX3DR2vDxPVbmABFyoDXNoUJERPXLv2rphtAxOGp30YxdUe8OVh5JVv76yWMs
	uSqKQpmQDHLcsSQqoI2jpAPejhmcfT3AE83mW70tOviX4VpsnS3YIuo0cYadCBRGgoimr5hlyrY
	DxbuYfJ0Mo3TffasRr+UmrnBdToiDrc88ZXaeTMbLrRLNn5VS0yGAJu0Uu+4qh5npExAfCr7TMF
	zyYJpyVNn7Hs9A2XNcNRZ/
X-Received: by 2002:a05:6808:170c:b0:48a:3452:e8ef with SMTP id 5614622812f47-49073d66ffdmr1095876b6e.0.1782274769864;
        Tue, 23 Jun 2026 21:19:29 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-48aedf21f5fsm8111799b6e.12.2026.06.23.21.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 21:19:29 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 3/6] odb/transaction: propagate begin errors
Date: Tue, 23 Jun 2026 23:19:17 -0500
Message-ID: <20260624041920.2601961-4-jltobler@gmail.com>
X-Mailer: git-send-email 2.54.0.105.g59ff4886a5
In-Reply-To: <20260624041920.2601961-1-jltobler@gmail.com>
References: <20260624041920.2601961-1-jltobler@gmail.com>
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

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 builtin/add.c            |  2 +-
 builtin/unpack-objects.c |  2 +-
 builtin/update-index.c   |  2 +-
 cache-tree.c             |  2 +-
 object-file.c            |  3 ++-
 odb/transaction.c        | 16 +++++++++++-----
 odb/transaction.h        | 19 +++++++++++++++----
 read-cache.c             |  2 +-
 8 files changed, 33 insertions(+), 15 deletions(-)

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
index 184f7e2635..1a7dfed9cf 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -490,7 +490,7 @@ int cache_tree_update(struct index_state *istate, int flags)
 
 	trace_performance_enter();
 	trace2_region_enter("cache_tree", "update", istate->repo);
-	transaction = odb_transaction_begin(the_repository->objects);
+	odb_transaction_begin_or_die(the_repository->objects, &transaction);
 	i = update_one(istate->cache_tree, istate->cache, istate->cache_nr,
 		       "", 0, &skip, flags);
 	odb_transaction_commit(transaction);
diff --git a/object-file.c b/object-file.c
index 18c2df75fb..696f05dc2d 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1389,8 +1389,9 @@ int index_fd(struct index_state *istate, struct object_id *oid,
 
 		if (flags & INDEX_WRITE_OBJECT) {
 			struct object_database *odb = the_repository->objects;
-			struct odb_transaction *transaction = odb_transaction_begin(odb);
+			struct odb_transaction *transaction;
 
+			odb_transaction_begin_or_die(odb, &transaction);
 			ret = odb_transaction_write_object_stream(odb->transaction,
 								  &stream,
 								  xsize_t(st->st_size),
diff --git a/odb/transaction.c b/odb/transaction.c
index b16e07aebf..d3de01db50 100644
--- a/odb/transaction.c
+++ b/odb/transaction.c
@@ -2,14 +2,20 @@
 #include "odb/source.h"
 #include "odb/transaction.h"
 
-struct odb_transaction *odb_transaction_begin(struct object_database *odb)
+int odb_transaction_begin(struct object_database *odb,
+			  struct odb_transaction **out)
 {
-	if (odb->transaction)
-		return NULL;
+	int ret;
 
-	odb_source_begin_transaction(odb->sources, &odb->transaction);
+	if (odb->transaction) {
+		*out = NULL;
+		return 0;
+	}
 
-	return odb->transaction;
+	ret = odb_source_begin_transaction(odb->sources, out);
+	odb->transaction = *out;
+
+	return ret;
 }
 
 void odb_transaction_commit(struct odb_transaction *transaction)
diff --git a/odb/transaction.h b/odb/transaction.h
index f4c1ebfaaa..cd6d50f2e5 100644
--- a/odb/transaction.h
+++ b/odb/transaction.h
@@ -1,6 +1,8 @@
 #ifndef ODB_TRANSACTION_H
 #define ODB_TRANSACTION_H
 
+#include "git-compat-util.h"
+#include "gettext.h"
 #include "odb.h"
 #include "odb/source.h"
 
@@ -33,11 +35,20 @@ struct odb_transaction {
 };
 
 /*
- * Starts an ODB transaction. Subsequent objects are written to the transaction
- * and not committed until odb_transaction_commit() is invoked on the
- * transaction. If the ODB already has a pending transaction, NULL is returned.
+ * Starts an ODB transaction and returns it via `out`. Subsequent objects are
+ * written to the transaction and not committed until odb_transaction_commit()
+ * is invoked on the transaction. Returns 0 on success and a negative value on
+ * error. If the ODB already has a pending transaction, `out` is set to NULL.
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
index 21ca58beea..db0bfa60fe 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -4042,7 +4042,7 @@ int add_files_to_cache(struct repository *repo, const char *prefix,
 	 * This function is invoked from commands other than 'add', which
 	 * may not have their own transaction active.
 	 */
-	transaction = odb_transaction_begin(repo->objects);
+	odb_transaction_begin_or_die(repo->objects, &transaction);
 	run_diff_files(&rev, DIFF_RACY_IS_MODIFIED);
 	odb_transaction_commit(transaction);
 
-- 
2.54.0.105.g59ff4886a5

