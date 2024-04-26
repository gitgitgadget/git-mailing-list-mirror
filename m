Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9D92E639
	for <git@vger.kernel.org>; Fri, 26 Apr 2024 15:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714145098; cv=none; b=oORrIjbLUTzpHJ/UWewv2xIDBTStjs2UKwQaLuh9dsKOZ/3Q2OD768w22s5pDRdm6Gyu39fUcF6EXlRvELVHh7wCiWJUgmMnH8kxIl9o7T3ziBoNuWgEqIKrHjinUu78BPDkD/sSY5o6zSydIwi1LE/B78cgea1ivE3HdD+IucI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714145098; c=relaxed/simple;
	bh=fOGkuS+FGuchGv5+LYRzZHD4p47kPebyakGkr9j8efY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JFsQc0m24Oxo4RWjk9YtpUtqD5+mQs3eTHHXMS9XldhtqHHY6bFk1x3B3WtRQO5tgPzmovIjN0mHfJ/52wwczw/osK6h7fjkKJGwQwr+iZ/WBkFC4UL4UMUOlKM74wXwMMvrO/RacWGRWu/eE7cASUQ/tsE1WAOEgI5dzpc06Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mzeZttmQ; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzeZttmQ"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a55b93f5540so302373166b.1
        for <git@vger.kernel.org>; Fri, 26 Apr 2024 08:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714145094; x=1714749894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+FcK+Y3WLNSwd70h2DIKeDgZjitKHjU45fhDHh4aEwc=;
        b=mzeZttmQ5Ovv+SYeztxj5dxPwl2jg0lkf1kbpppzTLfZZc7NHsYtLq0Do3NyIwW0t3
         K4q/Mtb2aS3mloFn1KbBjUHI/vL6sxkAtwpIxnCt8yUV/vrOkOrNx0tt+AXYhSULS0TF
         yGOSe4NwqmUDJveaCbN0J826N4inYouadYXzA2FqKmTKJM+KUQw+raf7/+YHE0chCjuo
         4GfiQu3LPwLmJg8aO5O49f2BulEy4+PUfu6NAo7Cm6F5AIVB0K8FW3yRH2jzh72sm5Eh
         0WZKmQ2LD/F8tAc3+1gdcqz/qtW95OTdZijg9VNyI6hWQ/mXplQ7vj/6DbCune1r0G37
         j82g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714145094; x=1714749894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+FcK+Y3WLNSwd70h2DIKeDgZjitKHjU45fhDHh4aEwc=;
        b=BbDoQ+Dt8cpzxJf29kd8OAU/s6zWLqPUCH2jhz578i1U3LkkCwyHwFA4NFZCpTHPDV
         cupdhdyxHi30178A9DNcKu/OYsz1jxmqfjDxIxWxPjTl6/pHxwSd/7mNuC9ioHmlyMB4
         GNI0po9jenszs0wRRR4BDEL3/INpbc74iQAj9a1DWLXYtx8jsaR4YrSkEZtHqyeWSAGW
         LxrNa28xBk/R5RxEvX/xk43cA4VmNTSilckQBMQxbUfWSjilgl35ABuoBGwSMa8m6T5+
         skRPMCMnE4t57o/ZgRZxSFV/NpqXjz3UL4c6hBlVjlVl4qpcOu2JqFbBEhz8xtbu3+VM
         YWCw==
X-Forwarded-Encrypted: i=1; AJvYcCWTwcF243JcUhFvGH52eBN0/nWNqavQz1WPlL7p5tr9cLxA7WxM0j/T7jIGJpyXy9EB6KfZojzyYTk/CefS4mM7BnTK
X-Gm-Message-State: AOJu0Yy2f/l1s/7JC5rpz6vvWSFOiT8bNgn6GMmI5/YYCpcDthcBz8Ds
	fNUb+aDhtNsq5/e7F3Nvd4dPtW2my97SJXAdadVpSuBUrPysVnkc
X-Google-Smtp-Source: AGHT+IF7gRxP64SOn4p1LRhKHIAIq3rpklMBXWShukC4r8j7ItHSWU8n8iQpDRhWZKA/F4m1Ja6BXA==
X-Received: by 2002:a17:906:3752:b0:a58:8d83:b527 with SMTP id e18-20020a170906375200b00a588d83b527mr2026956ejc.12.1714145094186;
        Fri, 26 Apr 2024 08:24:54 -0700 (PDT)
Received: from localhost.localdomain ([185.223.147.210])
        by smtp.gmail.com with ESMTPSA id z6-20020a170906434600b00a518c69c4e3sm10643868ejm.23.2024.04.26.08.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 08:24:53 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: christian.couder@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH v4 1/7] refs: accept symref values in `ref_transaction[_add]_update`
Date: Fri, 26 Apr 2024 17:24:43 +0200
Message-ID: <20240426152449.228860-2-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240426152449.228860-1-knayak@gitlab.com>
References: <20240423212818.574123-1-knayak@gitlab.com>
 <20240426152449.228860-1-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karthik Nayak <karthik.188@gmail.com>

The `ref_transaction[_add]_update` functions obtain ref information and
flags to create a `ref_update` and add it to the transaction at hand.

To extend symref support in transactions, we need to also accept the
old and new ref targets and process it. In this commit, let's add the
required parameters to the function and modify all call sites.

The two parameters added are `new_target` and `old_target`. The
`new_target` is used to denote what the reference should point to when
the transaction is applied.

The `old_target` denotes the value the reference must have before the
update. Some functions allow this parameter to be NULL, meaning that the
old value of the reference is not checked.

The handling logic of these parameters will be added in consequent
commits as we add symref commands to the '--stdin' mode of
'git-update-ref'.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 branch.c                |  2 +-
 builtin/fast-import.c   |  5 +++--
 builtin/fetch.c         |  2 +-
 builtin/receive-pack.c  |  1 +
 builtin/replace.c       |  2 +-
 builtin/tag.c           |  1 +
 builtin/update-ref.c    |  1 +
 refs.c                  | 22 +++++++++++++++++-----
 refs.h                  | 17 ++++++++++++++++-
 refs/files-backend.c    | 12 ++++++------
 refs/refs-internal.h    | 13 +++++++++++++
 refs/reftable-backend.c |  4 ++--
 sequencer.c             |  9 +++++----
 walker.c                |  2 +-
 14 files changed, 69 insertions(+), 24 deletions(-)

diff --git a/branch.c b/branch.c
index e4a738fc7b..48af4c3ceb 100644
--- a/branch.c
+++ b/branch.c
@@ -627,7 +627,7 @@ void create_branch(struct repository *r,
 	if (!transaction ||
 		ref_transaction_update(transaction, ref.buf,
 					&oid, forcing ? NULL : null_oid(),
-					0, msg, &err) ||
+					NULL, NULL, 0, msg, &err) ||
 		ref_transaction_commit(transaction, &err))
 		die("%s", err.buf);
 	ref_transaction_free(transaction);
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index dc5a9d32dd..297dfb91a1 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -1634,7 +1634,7 @@ static int update_branch(struct branch *b)
 	transaction = ref_transaction_begin(&err);
 	if (!transaction ||
 	    ref_transaction_update(transaction, b->name, &b->oid, &old_oid,
-				   0, msg, &err) ||
+				   NULL, NULL, 0, msg, &err) ||
 	    ref_transaction_commit(transaction, &err)) {
 		ref_transaction_free(transaction);
 		error("%s", err.buf);
@@ -1675,7 +1675,8 @@ static void dump_tags(void)
 		strbuf_addf(&ref_name, "refs/tags/%s", t->name);
 
 		if (ref_transaction_update(transaction, ref_name.buf,
-					   &t->oid, NULL, 0, msg, &err)) {
+					   &t->oid, NULL, NULL, NULL,
+					   0, msg, &err)) {
 			failure |= error("%s", err.buf);
 			goto cleanup;
 		}
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 5857d860db..66840b7c5b 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -668,7 +668,7 @@ static int s_update_ref(const char *action,
 
 	ret = ref_transaction_update(transaction, ref->name, &ref->new_oid,
 				     check_old ? &ref->old_oid : NULL,
-				     0, msg, &err);
+				     NULL, NULL, 0, msg, &err);
 	if (ret) {
 		ret = STORE_REF_ERROR_OTHER;
 		goto out;
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index e8d7df14b6..b150ef39a8 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1595,6 +1595,7 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 		if (ref_transaction_update(transaction,
 					   namespaced_name,
 					   new_oid, old_oid,
+					   NULL, NULL,
 					   0, "push",
 					   &err)) {
 			rp_error("%s", err.buf);
diff --git a/builtin/replace.c b/builtin/replace.c
index da59600ad2..7690687b0e 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -201,7 +201,7 @@ static int replace_object_oid(const char *object_ref,
 	transaction = ref_transaction_begin(&err);
 	if (!transaction ||
 	    ref_transaction_update(transaction, ref.buf, repl, &prev,
-				   0, NULL, &err) ||
+				   NULL, NULL, 0, NULL, &err) ||
 	    ref_transaction_commit(transaction, &err))
 		res = error("%s", err.buf);
 
diff --git a/builtin/tag.c b/builtin/tag.c
index 9a33cb50b4..40a65fdebc 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -660,6 +660,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	transaction = ref_transaction_begin(&err);
 	if (!transaction ||
 	    ref_transaction_update(transaction, ref.buf, &object, &prev,
+				   NULL, NULL,
 				   create_reflog ? REF_FORCE_CREATE_REFLOG : 0,
 				   reflog_msg.buf, &err) ||
 	    ref_transaction_commit(transaction, &err)) {
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index e46afbc46d..21fdbf6ac8 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -204,6 +204,7 @@ static void parse_cmd_update(struct ref_transaction *transaction,
 
 	if (ref_transaction_update(transaction, refname,
 				   &new_oid, have_old ? &old_oid : NULL,
+				   NULL, NULL,
 				   update_flags | create_reflog_flag,
 				   msg, &err))
 		die("%s", err.buf);
diff --git a/refs.c b/refs.c
index 55d2e0b2cb..060a31616d 100644
--- a/refs.c
+++ b/refs.c
@@ -1228,6 +1228,7 @@ struct ref_update *ref_transaction_add_update(
 		const char *refname, unsigned int flags,
 		const struct object_id *new_oid,
 		const struct object_id *old_oid,
+		const char *new_target, const char *old_target,
 		const char *msg)
 {
 	struct ref_update *update;
@@ -1235,6 +1236,11 @@ struct ref_update *ref_transaction_add_update(
 	if (transaction->state != REF_TRANSACTION_OPEN)
 		BUG("update called for transaction that is not open");
 
+	if (old_oid && !is_null_oid(old_oid) && old_target)
+		BUG("Only one of old_oid and old_target should be non NULL");
+	if (new_oid && !is_null_oid(new_oid) && new_target)
+		BUG("Only one of new_oid and new_target should be non NULL");
+
 	FLEX_ALLOC_STR(update, refname, refname);
 	ALLOC_GROW(transaction->updates, transaction->nr + 1, transaction->alloc);
 	transaction->updates[transaction->nr++] = update;
@@ -1253,6 +1259,8 @@ int ref_transaction_update(struct ref_transaction *transaction,
 			   const char *refname,
 			   const struct object_id *new_oid,
 			   const struct object_id *old_oid,
+			   const char *new_target,
+			   const char *old_target,
 			   unsigned int flags, const char *msg,
 			   struct strbuf *err)
 {
@@ -1280,7 +1288,8 @@ int ref_transaction_update(struct ref_transaction *transaction,
 	flags |= (new_oid ? REF_HAVE_NEW : 0) | (old_oid ? REF_HAVE_OLD : 0);
 
 	ref_transaction_add_update(transaction, refname, flags,
-				   new_oid, old_oid, msg);
+				   new_oid, old_oid, new_target,
+				   old_target, msg);
 	return 0;
 }
 
@@ -1295,7 +1304,8 @@ int ref_transaction_create(struct ref_transaction *transaction,
 		return 1;
 	}
 	return ref_transaction_update(transaction, refname, new_oid,
-				      null_oid(), flags, msg, err);
+				      null_oid(), NULL, NULL, flags,
+				      msg, err);
 }
 
 int ref_transaction_delete(struct ref_transaction *transaction,
@@ -1308,7 +1318,8 @@ int ref_transaction_delete(struct ref_transaction *transaction,
 		BUG("delete called with old_oid set to zeros");
 	return ref_transaction_update(transaction, refname,
 				      null_oid(), old_oid,
-				      flags, msg, err);
+				      NULL, NULL, flags,
+				      msg, err);
 }
 
 int ref_transaction_verify(struct ref_transaction *transaction,
@@ -1321,6 +1332,7 @@ int ref_transaction_verify(struct ref_transaction *transaction,
 		BUG("verify called with old_oid set to NULL");
 	return ref_transaction_update(transaction, refname,
 				      NULL, old_oid,
+				      NULL, NULL,
 				      flags, NULL, err);
 }
 
@@ -1335,8 +1347,8 @@ int refs_update_ref(struct ref_store *refs, const char *msg,
 
 	t = ref_store_transaction_begin(refs, &err);
 	if (!t ||
-	    ref_transaction_update(t, refname, new_oid, old_oid, flags, msg,
-				   &err) ||
+	    ref_transaction_update(t, refname, new_oid, old_oid, NULL, NULL,
+				   flags, msg, &err) ||
 	    ref_transaction_commit(t, &err)) {
 		ret = 1;
 		ref_transaction_free(t);
diff --git a/refs.h b/refs.h
index d278775e08..c792e13a64 100644
--- a/refs.h
+++ b/refs.h
@@ -648,6 +648,15 @@ struct ref_transaction *ref_transaction_begin(struct strbuf *err);
  *         before the update. A copy of this value is made in the
  *         transaction.
  *
+ *     new_target -- the target reference that the reference will be
+ *         update to point to. This takes precedence over new_oid when
+ *         set. If the reference is a regular reference, it will be
+ *         converted to a symbolic reference.
+ *
+ *     old_target -- the reference that the reference must be pointing to.
+ *         Will only be taken into account when the reference is a symbolic
+ *         reference.
+ *
  *     flags -- flags affecting the update, passed to
  *         update_ref_lock(). Possible flags: REF_NO_DEREF,
  *         REF_FORCE_CREATE_REFLOG. See those constants for more
@@ -713,7 +722,11 @@ struct ref_transaction *ref_transaction_begin(struct strbuf *err);
  * beforehand. The old value is checked after the lock is taken to
  * prevent races. If the old value doesn't agree with old_oid, the
  * whole transaction fails. If old_oid is NULL, then the previous
- * value is not checked.
+ * value is not checked. If `old_target` is not NULL, treat the reference
+ * as a symbolic ref and validate that its target before the update is
+ * `old_target`. If the `new_target` is not NULL, then the reference
+ * will be updated to a symbolic ref which targets `new_target`.
+ * Together, these allow us to update between regular refs and symrefs.
  *
  * See the above comment "Reference transaction updates" for more
  * information.
@@ -722,6 +735,8 @@ int ref_transaction_update(struct ref_transaction *transaction,
 			   const char *refname,
 			   const struct object_id *new_oid,
 			   const struct object_id *old_oid,
+			   const char *new_target,
+			   const char *old_target,
 			   unsigned int flags, const char *msg,
 			   struct strbuf *err);
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index a098d14ea0..e4d0aa3d41 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1198,7 +1198,7 @@ static void prune_ref(struct files_ref_store *refs, struct ref_to_prune *r)
 	ref_transaction_add_update(
 			transaction, r->name,
 			REF_NO_DEREF | REF_HAVE_NEW | REF_HAVE_OLD | REF_IS_PRUNING,
-			null_oid(), &r->oid, NULL);
+			null_oid(), &r->oid, NULL, NULL, NULL);
 	if (ref_transaction_commit(transaction, &err))
 		goto cleanup;
 
@@ -1292,7 +1292,7 @@ static int files_pack_refs(struct ref_store *ref_store,
 		 * packed-refs transaction:
 		 */
 		if (ref_transaction_update(transaction, iter->refname,
-					   iter->oid, NULL,
+					   iter->oid, NULL, NULL, NULL,
 					   REF_NO_DEREF, NULL, &err))
 			die("failure preparing to create packed reference %s: %s",
 			    iter->refname, err.buf);
@@ -2309,7 +2309,7 @@ static int split_head_update(struct ref_update *update,
 			transaction, "HEAD",
 			update->flags | REF_LOG_ONLY | REF_NO_DEREF,
 			&update->new_oid, &update->old_oid,
-			update->msg);
+			NULL, NULL, update->msg);
 
 	/*
 	 * Add "HEAD". This insertion is O(N) in the transaction
@@ -2372,7 +2372,7 @@ static int split_symref_update(struct ref_update *update,
 	new_update = ref_transaction_add_update(
 			transaction, referent, new_flags,
 			&update->new_oid, &update->old_oid,
-			update->msg);
+			NULL, NULL, update->msg);
 
 	new_update->parent_update = update;
 
@@ -2763,7 +2763,7 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 					packed_transaction, update->refname,
 					REF_HAVE_NEW | REF_NO_DEREF,
 					&update->new_oid, NULL,
-					NULL);
+					NULL, NULL, NULL);
 		}
 	}
 
@@ -3048,7 +3048,7 @@ static int files_initial_transaction_commit(struct ref_store *ref_store,
 		ref_transaction_add_update(packed_transaction, update->refname,
 					   update->flags & ~REF_HAVE_OLD,
 					   &update->new_oid, &update->old_oid,
-					   NULL);
+					   NULL, NULL, NULL);
 	}
 
 	if (packed_refs_lock(refs->packed_ref_store, 0, err)) {
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 56641aa57a..3040d4797c 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -124,6 +124,18 @@ struct ref_update {
 	 */
 	struct object_id old_oid;
 
+	/*
+	 * If set, point the reference to this value. This can also be
+	 * used to convert regular references to become symbolic refs.
+	 */
+	const char *new_target;
+
+	/*
+	 * If set and the reference is a symbolic ref, check that the
+	 * reference previously pointed to this value.
+	 */
+	const char *old_target;
+
 	/*
 	 * One or more of REF_NO_DEREF, REF_FORCE_CREATE_REFLOG,
 	 * REF_HAVE_NEW, REF_HAVE_OLD, or backend-specific flags.
@@ -173,6 +185,7 @@ struct ref_update *ref_transaction_add_update(
 		const char *refname, unsigned int flags,
 		const struct object_id *new_oid,
 		const struct object_id *old_oid,
+		const char *new_target, const char *old_target,
 		const char *msg);
 
 /*
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 1cda48c504..6104471199 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -829,7 +829,7 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 			new_update = ref_transaction_add_update(
 					transaction, "HEAD",
 					u->flags | REF_LOG_ONLY | REF_NO_DEREF,
-					&u->new_oid, &u->old_oid, u->msg);
+					&u->new_oid, &u->old_oid, NULL, NULL, u->msg);
 			string_list_insert(&affected_refnames, new_update->refname);
 		}
 
@@ -908,7 +908,7 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 				 */
 				new_update = ref_transaction_add_update(
 						transaction, referent.buf, new_flags,
-						&u->new_oid, &u->old_oid, u->msg);
+						&u->new_oid, &u->old_oid, NULL, NULL, u->msg);
 				new_update->parent_update = u;
 
 				/*
diff --git a/sequencer.c b/sequencer.c
index 2c19846385..af1b25692b 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -616,7 +616,7 @@ static int fast_forward_to(struct repository *r,
 	if (!transaction ||
 	    ref_transaction_update(transaction, "HEAD",
 				   to, unborn && !is_rebase_i(opts) ?
-				   null_oid() : from,
+				   null_oid() : from, NULL, NULL,
 				   0, sb.buf, &err) ||
 	    ref_transaction_commit(transaction, &err)) {
 		ref_transaction_free(transaction);
@@ -1248,7 +1248,7 @@ int update_head_with_reflog(const struct commit *old_head,
 	if (!transaction ||
 	    ref_transaction_update(transaction, "HEAD", new_head,
 				   old_head ? &old_head->object.oid : null_oid(),
-				   0, sb.buf, err) ||
+				   NULL, NULL, 0, sb.buf, err) ||
 	    ref_transaction_commit(transaction, err)) {
 		ret = -1;
 	}
@@ -3764,8 +3764,9 @@ static int do_label(struct repository *r, const char *name, int len)
 	} else if (repo_get_oid(r, "HEAD", &head_oid)) {
 		error(_("could not read HEAD"));
 		ret = -1;
-	} else if (ref_transaction_update(transaction, ref_name.buf, &head_oid,
-					  NULL, 0, msg.buf, &err) < 0 ||
+	} else if (ref_transaction_update(transaction, ref_name.buf,
+					  &head_oid, NULL, NULL, NULL,
+					  0, msg.buf, &err) < 0 ||
 		   ref_transaction_commit(transaction, &err)) {
 		error("%s", err.buf);
 		ret = -1;
diff --git a/walker.c b/walker.c
index c0fd632d92..1b3df43906 100644
--- a/walker.c
+++ b/walker.c
@@ -324,7 +324,7 @@ int walker_fetch(struct walker *walker, int targets, char **target,
 		strbuf_reset(&refname);
 		strbuf_addf(&refname, "refs/%s", write_ref[i]);
 		if (ref_transaction_update(transaction, refname.buf,
-					   oids + i, NULL, 0,
+					   oids + i, NULL, NULL, NULL, 0,
 					   msg ? msg : "fetch (unknown)",
 					   &err)) {
 			error("%s", err.buf);
-- 
2.43.GIT

