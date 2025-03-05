Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CD12512D4
	for <git@vger.kernel.org>; Wed,  5 Mar 2025 17:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741196363; cv=none; b=JjnA/09q7p08c1qgzdrpIexhYS0D/6ScbxQKU5wHT2Zw0SYivZz9c3ls15RftlZ31Rxo+Z2Gqp8zJITIXkpmkdzIay+BiGx4Bb9JmfUmqSPuJ7/KFTO/ivvnWj9xrUG0UzCsn6If+vG87VH9x27LPO/wmlSDdTeiwstHv4BdxWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741196363; c=relaxed/simple;
	bh=U8Peyoymbx7+FOMg1pKxw/cUwNKBN7NEcfJPYBEdfoc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KjPiqYZM8KOXokVjNduP0b4Eb0FcaUAz6hHhEtNWcSm4/WdslIYx3xJR2nelJnzYMCf954PkKx3z1rEO/xitiaLkRn9ezsz9MjBKVlW6BmLuVEDcjhvwN1SCtB/TIQlu8r6yH1GCjIiT3+zuGbJGyTVUZCRhmov89chBzSgGbMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jn6dvN2W; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jn6dvN2W"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-abf42913e95so794859566b.2
        for <git@vger.kernel.org>; Wed, 05 Mar 2025 09:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741196359; x=1741801159; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L2M0AUq0E5vuNWtsmUZgnwXx0ROzakQ9pEZkPcQ1c8E=;
        b=jn6dvN2WfYItM1vzhyyr9RJgPH2Vxenu/3m79CQp0/+nj2475UHmNyeTTPOhYCjAk+
         Rgl94EmE2d1Au3nItl+TtyGTrpD64Eqg0BHW5MnM8U1+F+V64P+nxNqNCOrptiB3Y4rA
         yaBB3vKOAvbFQ/t271yVGYvbYvD2/vQr6Ur2GL8Ktl15jywL9h+a7UsGb9ftdHYE2yvn
         jqbi12RnvCLC9bjCL29Fps1b3YX1noeQ1Orc2SMRZgoBk72uvOQYUxaR20IXOBiifDX2
         OB25SuXm+hNu33aiYWp+vtts1m8ptUnE8v1CkGuL6RvCz+dQr1bk04A/QVCOUK71YhOc
         Blcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741196359; x=1741801159;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L2M0AUq0E5vuNWtsmUZgnwXx0ROzakQ9pEZkPcQ1c8E=;
        b=SIDCFdP9vTeBR07LmZFNUshwXDXVdjnKd+sjRaO+14TUG0xDEdEvEMEEGP5v4/86eD
         9Fu2txKsydYIV0babJfOPwdUhBTCjQg9hob+nfRoEfLCC0MhpiSHMQYqMmW0lSoAtU+8
         cHxQ4hTd8tWjuEaaiXQh4FNGyi4dBxrfZ08V8tJUtrgOdGEpdsp+Gb0Uk+WhKGVv2KqX
         p32Xp5h5j2Wg2QTQ6h+kBav6K+CL1kTvFpDPxPNqpf2WmrlTwZCaWoJElioCifDqQB0U
         sipu15fUoT9lhvfGwtK+pc1fn/8UGwhU1XMMKIeZTB9UgnWP99Z8LSHXuAPLQeydXdSR
         3pww==
X-Gm-Message-State: AOJu0YzLg1RZ6feDLGxu/1rRWypvXxByI32fqdkNJpamAfJi5pOsWA0N
	y5QkC+LeQ+TynF/SaTyVd9M6mL7xyd8npQ9ZHnJ9lQklSf36KY5A21fJGUOO
X-Gm-Gg: ASbGncsg5Nb2S05fMt9rrvDRZC38J40MGFr7zttinE+Eoi1H5DnEWK08sMvjDZSzqje
	fAd/uPMXpIgTstfK+P58K5et6xgTvhUR+J8ZbZLhP74LdcVOGynmaodppBlwHys/fPREN7mACWb
	kFhQbAwaPdGp6TfhHRSl4iIxKfAw+pgnY8fN+MtHCUdo+FWAWdMYN/RHadyNUXOBJXajbTgvBJ1
	HiHwJN6WwkzzpjLlKpcMCHkW3F7qKXALhB/lMYkVkf+9fN7TshJYeJvzOmrGQTUmqfQLvlK4b7R
	v7eklg54K2TmPK6i8rOMdnrqyiHGa/wpnFr80NSwmyogggn1Qw==
X-Google-Smtp-Source: AGHT+IGQ0B8RF3DSIlnwaeGwvRZ6Ur0zz2AqQQQkB5S5gW0Je66KRQZdn/8UR7NqJMqyki3iJ3Utrw==
X-Received: by 2002:a17:907:c018:b0:abf:7964:f9e5 with SMTP id a640c23a62f3a-ac20e03b1d0mr445383666b.56.1741196358200;
        Wed, 05 Mar 2025 09:39:18 -0800 (PST)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:8a90:b290:3a5b:4dd])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf3a8e2f53sm946851866b.115.2025.03.05.09.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 09:39:17 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 05 Mar 2025 18:39:00 +0100
Subject: [PATCH v3 5/8] refs: introduce enum-based transaction error types
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-245-partially-atomic-ref-updates-v3-5-0c64e3052354@gmail.com>
References: <20250305-245-partially-atomic-ref-updates-v3-0-0c64e3052354@gmail.com>
In-Reply-To: <20250305-245-partially-atomic-ref-updates-v3-0-0c64e3052354@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, jltobler@gmail.com, 
 phillip.wood123@gmail.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=37459;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=U8Peyoymbx7+FOMg1pKxw/cUwNKBN7NEcfJPYBEdfoc=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGfIjEByVDIhlYQlI2I4dTeH9qH36RQiH2oN/
 7YvU+4PT5Rv0YkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJnyIxAAAoJED7VnySO
 Rox/u7UMAJ0mVktWOsqhClFyPFtFa+c3DVkXA4BsUWjgu4i8NvlU2XedM+CgORyck02Za4EdqBe
 +Jl3jlTsPy+PGCp4ntgOIYpjdKoqQWDdYQ5vPVXOBUssRA/R0Tm3fTb3e+KfzN63P8hIuOFdjLO
 WHev5d/P/7g0Xox4v8ClLYhdR0wYQsukqBS0Ui2U8B1ZOjRRAzaneLlezSHuexb9dBwpNPP4EaJ
 jkXwFWSqfsSI94VjXYx1r7cqz/DODGYwHitUUGVB5j+lm5GCcoKEJlu8TiG7FPP9KQdMWQaH3q9
 8zfuBuvHjXkbWm0UEK+Zn5xY/lq5TEONUbONC3iEo3vJCrF66jN4spNVvCfLOxSdGRLm2c2lRLH
 TVdJVUr9Zhr3/o57QJyAchce3sk3nmRLmA197wJLYaQfPGgdTlkeOktfBJiC1IRl6GdMl/VKY8j
 WWW4b7TYElCMJtot7m+aKENcJYLPpjEyva4vMg3HxP84ppsw0DIw/+WhPZLmmuHAFQwYNqOsDS4
 Wg=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Replace preprocessor-defined transaction errors with a strongly-typed
enum `ref_transaction_error`. This change:

  - Improves type safety and function signature clarity.
  - Makes error handling more explicit and discoverable.
  - Maintains existing error cases, while adding new error cases for
    common scenarios.

This refactoring paves the way for more comprehensive error handling
which we will utilize in the upcoming commits to add partial transaction
support.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/fetch.c         |   2 +-
 refs.c                  |  49 ++++++------
 refs.h                  |  54 ++++++++-----
 refs/files-backend.c    | 202 ++++++++++++++++++++++++------------------------
 refs/packed-backend.c   |  23 +++---
 refs/refs-internal.h    |   5 +-
 refs/reftable-backend.c |  64 +++++++--------
 7 files changed, 213 insertions(+), 186 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 1c740d5aac..52c913d28a 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -687,7 +687,7 @@ static int s_update_ref(const char *action,
 		switch (ref_transaction_commit(our_transaction, &err)) {
 		case 0:
 			break;
-		case TRANSACTION_NAME_CONFLICT:
+		case REF_TRANSACTION_ERROR_NAME_CONFLICT:
 			ret = STORE_REF_ERROR_DF_CONFLICT;
 			goto out;
 		default:
diff --git a/refs.c b/refs.c
index 69f385f344..63b8050ce2 100644
--- a/refs.c
+++ b/refs.c
@@ -2271,7 +2271,7 @@ int refs_update_symref_extended(struct ref_store *refs, const char *ref,
 					   REF_NO_DEREF, logmsg, &err))
 			goto error_return;
 		prepret = ref_transaction_prepare(transaction, &err);
-		if (prepret && prepret != TRANSACTION_CREATE_EXISTS)
+		if (prepret && prepret != REF_TRANSACTION_ERROR_CREATE_EXISTS)
 			goto error_return;
 	} else {
 		if (ref_transaction_update(transaction, ref, NULL, NULL,
@@ -2289,7 +2289,7 @@ int refs_update_symref_extended(struct ref_store *refs, const char *ref,
 		}
 	}
 
-	if (prepret == TRANSACTION_CREATE_EXISTS)
+	if (prepret == REF_TRANSACTION_ERROR_CREATE_EXISTS)
 		goto cleanup;
 
 	if (ref_transaction_commit(transaction, &err))
@@ -2425,7 +2425,7 @@ int ref_transaction_prepare(struct ref_transaction *transaction,
 
 	string_list_sort(&transaction->refnames);
 	if (ref_update_reject_duplicates(&transaction->refnames, err))
-		return TRANSACTION_GENERIC_ERROR;
+		return REF_TRANSACTION_ERROR_GENERIC;
 
 	ret = refs->be->transaction_prepare(refs, transaction, err);
 	if (ret)
@@ -2497,18 +2497,18 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	return ret;
 }
 
-int refs_verify_refnames_available(struct ref_store *refs,
-				   const struct string_list *refnames,
-				   const struct string_list *extras,
-				   const struct string_list *skip,
-				   unsigned int initial_transaction,
-				   struct strbuf *err)
+enum ref_transaction_error refs_verify_refnames_available(struct ref_store *refs,
+					  const struct string_list *refnames,
+					  const struct string_list *extras,
+					  const struct string_list *skip,
+					  unsigned int initial_transaction,
+					  struct strbuf *err)
 {
 	struct strbuf dirname = STRBUF_INIT;
 	struct strbuf referent = STRBUF_INIT;
 	struct ref_iterator *iter = NULL;
 	struct strset dirnames;
-	int ret = -1;
+	int ret = REF_TRANSACTION_ERROR_NAME_CONFLICT;
 
 	/*
 	 * For the sake of comments in this function, suppose that
@@ -2624,12 +2624,13 @@ int refs_verify_refnames_available(struct ref_store *refs,
 	return ret;
 }
 
-int refs_verify_refname_available(struct ref_store *refs,
-				  const char *refname,
-				  const struct string_list *extras,
-				  const struct string_list *skip,
-				  unsigned int initial_transaction,
-				  struct strbuf *err)
+enum ref_transaction_error refs_verify_refname_available(
+	struct ref_store *refs,
+	const char *refname,
+	const struct string_list *extras,
+	const struct string_list *skip,
+	unsigned int initial_transaction,
+	struct strbuf *err)
 {
 	struct string_list_item item = { .string = (char *) refname };
 	struct string_list refnames = {
@@ -2817,8 +2818,9 @@ int ref_update_has_null_new_value(struct ref_update *update)
 	return !update->new_target && is_null_oid(&update->new_oid);
 }
 
-int ref_update_check_old_target(const char *referent, struct ref_update *update,
-				struct strbuf *err)
+enum ref_transaction_error ref_update_check_old_target(const char *referent,
+						       struct ref_update *update,
+						       struct strbuf *err)
 {
 	if (!update->old_target)
 		BUG("called without old_target set");
@@ -2826,17 +2828,18 @@ int ref_update_check_old_target(const char *referent, struct ref_update *update,
 	if (!strcmp(referent, update->old_target))
 		return 0;
 
-	if (!strcmp(referent, ""))
+	if (!strcmp(referent, "")) {
 		strbuf_addf(err, "verifying symref target: '%s': "
 			    "reference is missing but expected %s",
 			    ref_update_original_update_refname(update),
 			    update->old_target);
-	else
-		strbuf_addf(err, "verifying symref target: '%s': "
-			    "is at %s but expected %s",
+		return REF_TRANSACTION_ERROR_NONEXISTENT_REF;
+	}
+
+	strbuf_addf(err, "verifying symref target: '%s': is at %s but expected %s",
 			    ref_update_original_update_refname(update),
 			    referent, update->old_target);
-	return -1;
+	return REF_TRANSACTION_ERROR_INCORRECT_OLD_VALUE;
 }
 
 struct migration_data {
diff --git a/refs.h b/refs.h
index b14ba1f9ff..1b9213f9ce 100644
--- a/refs.h
+++ b/refs.h
@@ -16,6 +16,29 @@ struct worktree;
 enum ref_storage_format ref_storage_format_by_name(const char *name);
 const char *ref_storage_format_to_name(enum ref_storage_format ref_storage_format);
 
+/*
+ * enum ref_transaction_error represents the following return codes:
+ * REF_TRANSACTION_ERROR_GENERIC error_code: default error code.
+ * REF_TRANSACTION_ERROR_NAME_CONFLICT error_code: ref name conflict like A vs A/B.
+ * REF_TRANSACTION_ERROR_CREATE_EXISTS error_code: ref to be created already exists.
+ * REF_TRANSACTION_ERROR_NONEXISTENT_REF error_code: ref expected but doesn't exist.
+ * REF_TRANSACTION_ERROR_INCORRECT_OLD_VALUE error_code: provided old_oid or old_target of
+ * reference doesn't match actual.
+ * REF_TRANSACTION_ERROR_INVALID_NEW_VALUE error_code: provided new_oid or new_target is
+ * invalid.
+ * REF_TRANSACTION_ERROR_EXPECTED_SYMREF error_code: expected ref to be symref, but is a
+ * regular ref.
+ */
+enum ref_transaction_error {
+	REF_TRANSACTION_ERROR_GENERIC = -1,
+	REF_TRANSACTION_ERROR_NAME_CONFLICT = -2,
+	REF_TRANSACTION_ERROR_CREATE_EXISTS = -3,
+	REF_TRANSACTION_ERROR_NONEXISTENT_REF = -4,
+	REF_TRANSACTION_ERROR_INCORRECT_OLD_VALUE = -5,
+	REF_TRANSACTION_ERROR_INVALID_NEW_VALUE = -6,
+	REF_TRANSACTION_ERROR_EXPECTED_SYMREF = -7,
+};
+
 /*
  * Resolve a reference, recursively following symbolic references.
  *
@@ -117,24 +140,24 @@ int refs_read_symbolic_ref(struct ref_store *ref_store, const char *refname,
  *
  * extras and skip must be sorted.
  */
-int refs_verify_refname_available(struct ref_store *refs,
-				  const char *refname,
-				  const struct string_list *extras,
-				  const struct string_list *skip,
-				  unsigned int initial_transaction,
-				  struct strbuf *err);
+enum ref_transaction_error refs_verify_refname_available(struct ref_store *refs,
+						 const char *refname,
+						 const struct string_list *extras,
+						 const struct string_list *skip,
+						 unsigned int initial_transaction,
+						 struct strbuf *err);
 
 /*
  * Same as `refs_verify_refname_available()`, but checking for a list of
  * refnames instead of only a single item. This is more efficient in the case
  * where one needs to check multiple refnames.
  */
-int refs_verify_refnames_available(struct ref_store *refs,
-				   const struct string_list *refnames,
-				   const struct string_list *extras,
-				   const struct string_list *skip,
-				   unsigned int initial_transaction,
-				   struct strbuf *err);
+enum ref_transaction_error refs_verify_refnames_available(struct ref_store *refs,
+					  const struct string_list *refnames,
+					  const struct string_list *extras,
+					  const struct string_list *skip,
+					  unsigned int initial_transaction,
+					  struct strbuf *err);
 
 int refs_ref_exists(struct ref_store *refs, const char *refname);
 
@@ -830,13 +853,6 @@ int ref_transaction_verify(struct ref_transaction *transaction,
 			   unsigned int flags,
 			   struct strbuf *err);
 
-/* Naming conflict (for example, the ref names A and A/B conflict). */
-#define TRANSACTION_NAME_CONFLICT -1
-/* When only creation was requested, but the ref already exists. */
-#define TRANSACTION_CREATE_EXISTS -2
-/* All other errors. */
-#define TRANSACTION_GENERIC_ERROR -3
-
 /*
  * Perform the preparatory stages of committing `transaction`. Acquire
  * any needed locks, check preconditions, etc.; basically, do as much
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 7c6a0b3478..1e1663f44b 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -663,7 +663,7 @@ static void unlock_ref(struct ref_lock *lock)
  * broken, lock the reference anyway but clear old_oid.
  *
  * Return 0 on success. On failure, write an error message to err and
- * return TRANSACTION_NAME_CONFLICT or TRANSACTION_GENERIC_ERROR.
+ * return REF_TRANSACTION_ERROR_NAME_CONFLICT or REF_TRANSACTION_ERROR_GENERIC.
  *
  * Implementation note: This function is basically
  *
@@ -676,19 +676,20 @@ static void unlock_ref(struct ref_lock *lock)
  *   avoided, namely if we were successfully able to read the ref
  * - Generate informative error messages in the case of failure
  */
-static int lock_raw_ref(struct files_ref_store *refs,
-			const char *refname, int mustexist,
-			struct string_list *refnames_to_check,
-			const struct string_list *extras,
-			struct ref_lock **lock_p,
-			struct strbuf *referent,
-			unsigned int *type,
-			struct strbuf *err)
-{
+static enum ref_transaction_error lock_raw_ref(struct files_ref_store *refs,
+					       const char *refname,
+					       int mustexist,
+					       struct string_list *refnames_to_check,
+					       const struct string_list *extras,
+					       struct ref_lock **lock_p,
+					       struct strbuf *referent,
+					       unsigned int *type,
+					       struct strbuf *err)
+{
+	enum ref_transaction_error ret = REF_TRANSACTION_ERROR_GENERIC;
 	struct ref_lock *lock;
 	struct strbuf ref_file = STRBUF_INIT;
 	int attempts_remaining = 3;
-	int ret = TRANSACTION_GENERIC_ERROR;
 	int failure_errno;
 
 	assert(err);
@@ -728,13 +729,14 @@ static int lock_raw_ref(struct files_ref_store *refs,
 				strbuf_reset(err);
 				strbuf_addf(err, "unable to resolve reference '%s'",
 					    refname);
+				ret = REF_TRANSACTION_ERROR_NONEXISTENT_REF;
 			} else {
 				/*
 				 * The error message set by
 				 * refs_verify_refname_available() is
 				 * OK.
 				 */
-				ret = TRANSACTION_NAME_CONFLICT;
+				ret = REF_TRANSACTION_ERROR_NAME_CONFLICT;
 			}
 		} else {
 			/*
@@ -788,6 +790,7 @@ static int lock_raw_ref(struct files_ref_store *refs,
 				/* Garden variety missing reference. */
 				strbuf_addf(err, "unable to resolve reference '%s'",
 					    refname);
+				ret = REF_TRANSACTION_ERROR_NONEXISTENT_REF;
 				goto error_return;
 			} else {
 				/*
@@ -820,6 +823,7 @@ static int lock_raw_ref(struct files_ref_store *refs,
 				/* Garden variety missing reference. */
 				strbuf_addf(err, "unable to resolve reference '%s'",
 					    refname);
+				ret = REF_TRANSACTION_ERROR_NONEXISTENT_REF;
 				goto error_return;
 			} else if (remove_dir_recursively(&ref_file,
 							  REMOVE_DIR_EMPTY_ONLY)) {
@@ -830,7 +834,7 @@ static int lock_raw_ref(struct files_ref_store *refs,
 					 * The error message set by
 					 * verify_refname_available() is OK.
 					 */
-					ret = TRANSACTION_NAME_CONFLICT;
+					ret = REF_TRANSACTION_ERROR_NAME_CONFLICT;
 					goto error_return;
 				} else {
 					/*
@@ -1517,10 +1521,11 @@ static int rename_tmp_log(struct files_ref_store *refs, const char *newrefname)
 	return ret;
 }
 
-static int write_ref_to_lockfile(struct files_ref_store *refs,
-				 struct ref_lock *lock,
-				 const struct object_id *oid,
-				 int skip_oid_verification, struct strbuf *err);
+static enum ref_transaction_error write_ref_to_lockfile(struct files_ref_store *refs,
+							struct ref_lock *lock,
+							const struct object_id *oid,
+							int skip_oid_verification,
+							struct strbuf *err);
 static int commit_ref_update(struct files_ref_store *refs,
 			     struct ref_lock *lock,
 			     const struct object_id *oid, const char *logmsg,
@@ -1926,10 +1931,11 @@ static int files_log_ref_write(struct files_ref_store *refs,
  * Write oid into the open lockfile, then close the lockfile. On
  * errors, rollback the lockfile, fill in *err and return -1.
  */
-static int write_ref_to_lockfile(struct files_ref_store *refs,
-				 struct ref_lock *lock,
-				 const struct object_id *oid,
-				 int skip_oid_verification, struct strbuf *err)
+static enum ref_transaction_error write_ref_to_lockfile(struct files_ref_store *refs,
+							struct ref_lock *lock,
+							const struct object_id *oid,
+							int skip_oid_verification,
+							struct strbuf *err)
 {
 	static char term = '\n';
 	struct object *o;
@@ -1943,7 +1949,7 @@ static int write_ref_to_lockfile(struct files_ref_store *refs,
 				"trying to write ref '%s' with nonexistent object %s",
 				lock->ref_name, oid_to_hex(oid));
 			unlock_ref(lock);
-			return -1;
+			return REF_TRANSACTION_ERROR_INVALID_NEW_VALUE;
 		}
 		if (o->type != OBJ_COMMIT && is_branch(lock->ref_name)) {
 			strbuf_addf(
@@ -1951,7 +1957,7 @@ static int write_ref_to_lockfile(struct files_ref_store *refs,
 				"trying to write non-commit object %s to branch '%s'",
 				oid_to_hex(oid), lock->ref_name);
 			unlock_ref(lock);
-			return -1;
+			return REF_TRANSACTION_ERROR_INVALID_NEW_VALUE;
 		}
 	}
 	fd = get_lock_file_fd(&lock->lk);
@@ -1962,7 +1968,7 @@ static int write_ref_to_lockfile(struct files_ref_store *refs,
 		strbuf_addf(err,
 			    "couldn't write '%s'", get_lock_file_path(&lock->lk));
 		unlock_ref(lock);
-		return -1;
+		return REF_TRANSACTION_ERROR_GENERIC;
 	}
 	return 0;
 }
@@ -2376,9 +2382,10 @@ static struct ref_iterator *files_reflog_iterator_begin(struct ref_store *ref_st
  * If update is a direct update of head_ref (the reference pointed to
  * by HEAD), then add an extra REF_LOG_ONLY update for HEAD.
  */
-static int split_head_update(struct ref_update *update,
-			     struct ref_transaction *transaction,
-			     const char *head_ref, struct strbuf *err)
+static enum ref_transaction_error split_head_update(struct ref_update *update,
+						    struct ref_transaction *transaction,
+						    const char *head_ref,
+						    struct strbuf *err)
 {
 	struct ref_update *new_update;
 
@@ -2402,7 +2409,7 @@ static int split_head_update(struct ref_update *update,
 			    "multiple updates for 'HEAD' (including one "
 			    "via its referent '%s') are not allowed",
 			    update->refname);
-		return TRANSACTION_NAME_CONFLICT;
+		return REF_TRANSACTION_ERROR_NAME_CONFLICT;
 	}
 
 	new_update = ref_transaction_add_update(
@@ -2430,10 +2437,10 @@ static int split_head_update(struct ref_update *update,
  * Note that the new update will itself be subject to splitting when
  * the iteration gets to it.
  */
-static int split_symref_update(struct ref_update *update,
-			       const char *referent,
-			       struct ref_transaction *transaction,
-			       struct strbuf *err)
+static enum ref_transaction_error split_symref_update(struct ref_update *update,
+						      const char *referent,
+						      struct ref_transaction *transaction,
+						      struct strbuf *err)
 {
 	struct ref_update *new_update;
 	unsigned int new_flags;
@@ -2450,7 +2457,7 @@ static int split_symref_update(struct ref_update *update,
 			    "multiple updates for '%s' (including one "
 			    "via symref '%s') are not allowed",
 			    referent, update->refname);
-		return TRANSACTION_NAME_CONFLICT;
+		return REF_TRANSACTION_ERROR_NAME_CONFLICT;
 	}
 
 	new_flags = update->flags;
@@ -2491,11 +2498,10 @@ static int split_symref_update(struct ref_update *update,
  * everything is OK, return 0; otherwise, write an error message to
  * err and return -1.
  */
-static int check_old_oid(struct ref_update *update, struct object_id *oid,
-			 struct strbuf *err)
+static enum ref_transaction_error check_old_oid(struct ref_update *update,
+						struct object_id *oid,
+						struct strbuf *err)
 {
-	int ret = TRANSACTION_GENERIC_ERROR;
-
 	if (!(update->flags & REF_HAVE_OLD) ||
 		   oideq(oid, &update->old_oid))
 		return 0;
@@ -2504,21 +2510,20 @@ static int check_old_oid(struct ref_update *update, struct object_id *oid,
 		strbuf_addf(err, "cannot lock ref '%s': "
 			    "reference already exists",
 			    ref_update_original_update_refname(update));
-		ret = TRANSACTION_CREATE_EXISTS;
-	}
-	else if (is_null_oid(oid))
+		return REF_TRANSACTION_ERROR_CREATE_EXISTS;
+	} else if (is_null_oid(oid)) {
 		strbuf_addf(err, "cannot lock ref '%s': "
 			    "reference is missing but expected %s",
 			    ref_update_original_update_refname(update),
 			    oid_to_hex(&update->old_oid));
-	else
-		strbuf_addf(err, "cannot lock ref '%s': "
-			    "is at %s but expected %s",
-			    ref_update_original_update_refname(update),
-			    oid_to_hex(oid),
-			    oid_to_hex(&update->old_oid));
+		return REF_TRANSACTION_ERROR_NONEXISTENT_REF;
+	}
 
-	return ret;
+	strbuf_addf(err, "cannot lock ref '%s': is at %s but expected %s",
+		    ref_update_original_update_refname(update), oid_to_hex(oid),
+		    oid_to_hex(&update->old_oid));
+
+	return REF_TRANSACTION_ERROR_INCORRECT_OLD_VALUE;
 }
 
 struct files_transaction_backend_data {
@@ -2540,17 +2545,17 @@ struct files_transaction_backend_data {
  * - If it is an update of head_ref, add a corresponding REF_LOG_ONLY
  *   update of HEAD.
  */
-static int lock_ref_for_update(struct files_ref_store *refs,
-			       struct ref_update *update,
-			       struct ref_transaction *transaction,
-			       const char *head_ref,
-			       struct string_list *refnames_to_check,
-			       struct strbuf *err)
+static enum ref_transaction_error lock_ref_for_update(struct files_ref_store *refs,
+						      struct ref_update *update,
+						      struct ref_transaction *transaction,
+						      const char *head_ref,
+						      struct string_list *refnames_to_check,
+						      struct strbuf *err)
 {
 	struct strbuf referent = STRBUF_INIT;
 	int mustexist = ref_update_expects_existing_old_ref(update);
 	struct files_transaction_backend_data *backend_data;
-	int ret = 0;
+	enum ref_transaction_error ret = 0;
 	struct ref_lock *lock;
 
 	files_assert_main_repository(refs, "lock_ref_for_update");
@@ -2602,22 +2607,17 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 					strbuf_addf(err, "cannot lock ref '%s': "
 						    "error reading reference",
 						    ref_update_original_update_refname(update));
-					ret = TRANSACTION_GENERIC_ERROR;
+					ret = REF_TRANSACTION_ERROR_GENERIC;
 					goto out;
 				}
 			}
 
-			if (update->old_target) {
-				if (ref_update_check_old_target(referent.buf, update, err)) {
-					ret = TRANSACTION_GENERIC_ERROR;
-					goto out;
-				}
-			} else {
+			if (update->old_target)
+				ret = ref_update_check_old_target(referent.buf, update, err);
+			else
 				ret = check_old_oid(update, &lock->old_oid, err);
-				if  (ret) {
-					goto out;
-				}
-			}
+			if (ret)
+				goto out;
 		} else {
 			/*
 			 * Create a new update for the reference this
@@ -2644,7 +2644,7 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 					   "but is a regular ref"),
 				    ref_update_original_update_refname(update),
 				    update->old_target);
-			ret = TRANSACTION_GENERIC_ERROR;
+			ret = REF_TRANSACTION_ERROR_EXPECTED_SYMREF;
 			goto out;
 		} else {
 			ret = check_old_oid(update, &lock->old_oid, err);
@@ -2668,14 +2668,14 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 
 	if (update->new_target && !(update->flags & REF_LOG_ONLY)) {
 		if (create_symref_lock(lock, update->new_target, err)) {
-			ret = TRANSACTION_GENERIC_ERROR;
+			ret = REF_TRANSACTION_ERROR_GENERIC;
 			goto out;
 		}
 
 		if (close_ref_gently(lock)) {
 			strbuf_addf(err, "couldn't close '%s.lock'",
 				    update->refname);
-			ret = TRANSACTION_GENERIC_ERROR;
+			ret = REF_TRANSACTION_ERROR_GENERIC;
 			goto out;
 		}
 
@@ -2693,25 +2693,27 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 			 * The reference already has the desired
 			 * value, so we don't need to write it.
 			 */
-		} else if (write_ref_to_lockfile(
-				   refs, lock, &update->new_oid,
-				   update->flags & REF_SKIP_OID_VERIFICATION,
-				   err)) {
-			char *write_err = strbuf_detach(err, NULL);
-
-			/*
-			 * The lock was freed upon failure of
-			 * write_ref_to_lockfile():
-			 */
-			update->backend_data = NULL;
-			strbuf_addf(err,
-				    "cannot update ref '%s': %s",
-				    update->refname, write_err);
-			free(write_err);
-			ret = TRANSACTION_GENERIC_ERROR;
-			goto out;
 		} else {
-			update->flags |= REF_NEEDS_COMMIT;
+			ret = write_ref_to_lockfile(
+				refs, lock, &update->new_oid,
+				update->flags & REF_SKIP_OID_VERIFICATION,
+				err);
+			if (ret) {
+				char *write_err = strbuf_detach(err, NULL);
+
+				/*
+				 * The lock was freed upon failure of
+				 * write_ref_to_lockfile():
+				 */
+				update->backend_data = NULL;
+				strbuf_addf(err,
+					    "cannot update ref '%s': %s",
+					    update->refname, write_err);
+				free(write_err);
+				goto out;
+			} else {
+				update->flags |= REF_NEEDS_COMMIT;
+			}
 		}
 	}
 	if (!(update->flags & REF_NEEDS_COMMIT)) {
@@ -2723,7 +2725,7 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 		if (close_ref_gently(lock)) {
 			strbuf_addf(err, "couldn't close '%s.lock'",
 				    update->refname);
-			ret = TRANSACTION_GENERIC_ERROR;
+			ret = REF_TRANSACTION_ERROR_GENERIC;
 			goto out;
 		}
 	}
@@ -2865,7 +2867,7 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 						refs->packed_ref_store,
 						transaction->flags, err);
 				if (!packed_transaction) {
-					ret = TRANSACTION_GENERIC_ERROR;
+					ret = REF_TRANSACTION_ERROR_GENERIC;
 					goto cleanup;
 				}
 
@@ -2897,13 +2899,13 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 	 */
 	if (refs_verify_refnames_available(refs->packed_ref_store, &refnames_to_check,
 					   &transaction->refnames, NULL, 0, err)) {
-		ret = TRANSACTION_NAME_CONFLICT;
+		ret = REF_TRANSACTION_ERROR_NAME_CONFLICT;
 		goto cleanup;
 	}
 
 	if (packed_transaction) {
 		if (packed_refs_lock(refs->packed_ref_store, 0, err)) {
-			ret = TRANSACTION_GENERIC_ERROR;
+			ret = REF_TRANSACTION_ERROR_GENERIC;
 			goto cleanup;
 		}
 		backend_data->packed_refs_locked = 1;
@@ -2934,7 +2936,7 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 			 */
 			backend_data->packed_transaction = NULL;
 			if (ref_transaction_abort(packed_transaction, err)) {
-				ret = TRANSACTION_GENERIC_ERROR;
+				ret = REF_TRANSACTION_ERROR_GENERIC;
 				goto cleanup;
 			}
 		}
@@ -3035,7 +3037,7 @@ static int files_transaction_finish_initial(struct files_ref_store *refs,
 	packed_transaction = ref_store_transaction_begin(refs->packed_ref_store,
 							 transaction->flags, err);
 	if (!packed_transaction) {
-		ret = TRANSACTION_GENERIC_ERROR;
+		ret = REF_TRANSACTION_ERROR_GENERIC;
 		goto cleanup;
 	}
 
@@ -3058,7 +3060,7 @@ static int files_transaction_finish_initial(struct files_ref_store *refs,
 			if (!loose_transaction) {
 				loose_transaction = ref_store_transaction_begin(&refs->base, 0, err);
 				if (!loose_transaction) {
-					ret = TRANSACTION_GENERIC_ERROR;
+					ret = REF_TRANSACTION_ERROR_GENERIC;
 					goto cleanup;
 				}
 			}
@@ -3083,19 +3085,19 @@ static int files_transaction_finish_initial(struct files_ref_store *refs,
 	}
 
 	if (packed_refs_lock(refs->packed_ref_store, 0, err)) {
-		ret = TRANSACTION_GENERIC_ERROR;
+		ret = REF_TRANSACTION_ERROR_GENERIC;
 		goto cleanup;
 	}
 
 	if (refs_verify_refnames_available(&refs->base, &refnames_to_check,
 					   &affected_refnames, NULL, 1, err)) {
 		packed_refs_unlock(refs->packed_ref_store);
-		ret = TRANSACTION_NAME_CONFLICT;
+		ret = REF_TRANSACTION_ERROR_NAME_CONFLICT;
 		goto cleanup;
 	}
 
 	if (ref_transaction_commit(packed_transaction, err)) {
-		ret = TRANSACTION_GENERIC_ERROR;
+		ret = REF_TRANSACTION_ERROR_GENERIC;
 		goto cleanup;
 	}
 	packed_refs_unlock(refs->packed_ref_store);
@@ -3103,7 +3105,7 @@ static int files_transaction_finish_initial(struct files_ref_store *refs,
 	if (loose_transaction) {
 		if (ref_transaction_prepare(loose_transaction, err) ||
 		    ref_transaction_commit(loose_transaction, err)) {
-			ret = TRANSACTION_GENERIC_ERROR;
+			ret = REF_TRANSACTION_ERROR_GENERIC;
 			goto cleanup;
 		}
 	}
@@ -3152,7 +3154,7 @@ static int files_transaction_finish(struct ref_store *ref_store,
 		if (update->flags & REF_NEEDS_COMMIT ||
 		    update->flags & REF_LOG_ONLY) {
 			if (parse_and_write_reflog(refs, update, lock, err)) {
-				ret = TRANSACTION_GENERIC_ERROR;
+				ret = REF_TRANSACTION_ERROR_GENERIC;
 				goto cleanup;
 			}
 		}
@@ -3171,7 +3173,7 @@ static int files_transaction_finish(struct ref_store *ref_store,
 				strbuf_addf(err, "couldn't set '%s'", lock->ref_name);
 				unlock_ref(lock);
 				update->backend_data = NULL;
-				ret = TRANSACTION_GENERIC_ERROR;
+				ret = REF_TRANSACTION_ERROR_GENERIC;
 				goto cleanup;
 			}
 		}
@@ -3227,7 +3229,7 @@ static int files_transaction_finish(struct ref_store *ref_store,
 				strbuf_reset(&sb);
 				files_ref_path(refs, &sb, lock->ref_name);
 				if (unlink_or_msg(sb.buf, err)) {
-					ret = TRANSACTION_GENERIC_ERROR;
+					ret = REF_TRANSACTION_ERROR_GENERIC;
 					goto cleanup;
 				}
 			}
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 19220d2e99..5458952624 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1326,10 +1326,11 @@ static int packed_ref_store_remove_on_disk(struct ref_store *ref_store,
  * The packfile must be locked before calling this function and will
  * remain locked when it is done.
  */
-static int write_with_updates(struct packed_ref_store *refs,
-			      struct string_list *updates,
-			      struct strbuf *err)
+static enum ref_transaction_error write_with_updates(struct packed_ref_store *refs,
+						     struct string_list *updates,
+						     struct strbuf *err)
 {
+	enum ref_transaction_error ret = REF_TRANSACTION_ERROR_GENERIC;
 	struct ref_iterator *iter = NULL;
 	size_t i;
 	int ok;
@@ -1353,7 +1354,7 @@ static int write_with_updates(struct packed_ref_store *refs,
 		strbuf_addf(err, "unable to create file %s: %s",
 			    sb.buf, strerror(errno));
 		strbuf_release(&sb);
-		return -1;
+		return REF_TRANSACTION_ERROR_GENERIC;
 	}
 	strbuf_release(&sb);
 
@@ -1409,6 +1410,7 @@ static int write_with_updates(struct packed_ref_store *refs,
 					strbuf_addf(err, "cannot update ref '%s': "
 						    "reference already exists",
 						    update->refname);
+					ret = REF_TRANSACTION_ERROR_CREATE_EXISTS;
 					goto error;
 				} else if (!oideq(&update->old_oid, iter->oid)) {
 					strbuf_addf(err, "cannot update ref '%s': "
@@ -1416,6 +1418,7 @@ static int write_with_updates(struct packed_ref_store *refs,
 						    update->refname,
 						    oid_to_hex(iter->oid),
 						    oid_to_hex(&update->old_oid));
+					ret = REF_TRANSACTION_ERROR_INCORRECT_OLD_VALUE;
 					goto error;
 				}
 			}
@@ -1452,6 +1455,7 @@ static int write_with_updates(struct packed_ref_store *refs,
 					    "reference is missing but expected %s",
 					    update->refname,
 					    oid_to_hex(&update->old_oid));
+				return REF_TRANSACTION_ERROR_NONEXISTENT_REF;
 				goto error;
 			}
 		}
@@ -1509,7 +1513,7 @@ static int write_with_updates(struct packed_ref_store *refs,
 			    strerror(errno));
 		strbuf_release(&sb);
 		delete_tempfile(&refs->tempfile);
-		return -1;
+		return REF_TRANSACTION_ERROR_GENERIC;
 	}
 
 	return 0;
@@ -1521,7 +1525,7 @@ static int write_with_updates(struct packed_ref_store *refs,
 error:
 	ref_iterator_free(iter);
 	delete_tempfile(&refs->tempfile);
-	return -1;
+	return ret;
 }
 
 int is_packed_transaction_needed(struct ref_store *ref_store,
@@ -1654,7 +1658,7 @@ static int packed_transaction_prepare(struct ref_store *ref_store,
 			REF_STORE_READ | REF_STORE_WRITE | REF_STORE_ODB,
 			"ref_transaction_prepare");
 	struct packed_transaction_backend_data *data;
-	int ret = TRANSACTION_GENERIC_ERROR;
+	enum ref_transaction_error ret = REF_TRANSACTION_ERROR_GENERIC;
 
 	/*
 	 * Note that we *don't* skip transactions with zero updates,
@@ -1675,7 +1679,8 @@ static int packed_transaction_prepare(struct ref_store *ref_store,
 		data->own_lock = 1;
 	}
 
-	if (write_with_updates(refs, &transaction->refnames, err))
+	ret = write_with_updates(refs, &transaction->refnames, err);
+	if (ret)
 		goto failure;
 
 	transaction->state = REF_TRANSACTION_PREPARED;
@@ -1707,7 +1712,7 @@ static int packed_transaction_finish(struct ref_store *ref_store,
 			ref_store,
 			REF_STORE_READ | REF_STORE_WRITE | REF_STORE_ODB,
 			"ref_transaction_finish");
-	int ret = TRANSACTION_GENERIC_ERROR;
+	int ret = REF_TRANSACTION_ERROR_GENERIC;
 	char *packed_refs_path;
 
 	clear_snapshot(refs);
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 6d3770d0cc..3f1d19abd9 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -770,8 +770,9 @@ int ref_update_has_null_new_value(struct ref_update *update);
  * If everything is OK, return 0; otherwise, write an error message to
  * err and return -1.
  */
-int ref_update_check_old_target(const char *referent, struct ref_update *update,
-				struct strbuf *err);
+enum ref_transaction_error ref_update_check_old_target(const char *referent,
+						       struct ref_update *update,
+						       struct strbuf *err);
 
 /*
  * Check if the ref must exist, this means that the old_oid or
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 2c1e2995de..0132b8b06a 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1069,20 +1069,20 @@ static int queue_transaction_update(struct reftable_ref_store *refs,
 	return 0;
 }
 
-static int prepare_single_update(struct reftable_ref_store *refs,
-				 struct reftable_transaction_data *tx_data,
-				 struct ref_transaction *transaction,
-				 struct reftable_backend *be,
-				 struct ref_update *u,
-				 struct string_list *refnames_to_check,
-				 unsigned int head_type,
-				 struct strbuf *head_referent,
-				 struct strbuf *referent,
-				 struct strbuf *err)
+static enum ref_transaction_error prepare_single_update(struct reftable_ref_store *refs,
+							struct reftable_transaction_data *tx_data,
+							struct ref_transaction *transaction,
+							struct reftable_backend *be,
+							struct ref_update *u,
+							struct string_list *refnames_to_check,
+							unsigned int head_type,
+							struct strbuf *head_referent,
+							struct strbuf *referent,
+							struct strbuf *err)
 {
+	enum ref_transaction_error ret = 0;
 	struct object_id current_oid = {0};
 	const char *rewritten_ref;
-	int ret = 0;
 
 	/*
 	 * There is no need to reload the respective backends here as
@@ -1093,7 +1093,7 @@ static int prepare_single_update(struct reftable_ref_store *refs,
 	 */
 	ret = backend_for(&be, refs, u->refname, &rewritten_ref, 0);
 	if (ret)
-		return ret;
+		return REF_TRANSACTION_ERROR_GENERIC;
 
 	/* Verify that the new object ID is valid. */
 	if ((u->flags & REF_HAVE_NEW) && !is_null_oid(&u->new_oid) &&
@@ -1104,13 +1104,13 @@ static int prepare_single_update(struct reftable_ref_store *refs,
 			strbuf_addf(err,
 				    _("trying to write ref '%s' with nonexistent object %s"),
 				    u->refname, oid_to_hex(&u->new_oid));
-			return -1;
+			return REF_TRANSACTION_ERROR_INVALID_NEW_VALUE;
 		}
 
 		if (o->type != OBJ_COMMIT && is_branch(u->refname)) {
 			strbuf_addf(err, _("trying to write non-commit object %s to branch '%s'"),
 				    oid_to_hex(&u->new_oid), u->refname);
-			return -1;
+			return REF_TRANSACTION_ERROR_INVALID_NEW_VALUE;
 		}
 	}
 
@@ -1134,7 +1134,7 @@ static int prepare_single_update(struct reftable_ref_store *refs,
 				    _("multiple updates for 'HEAD' (including one "
 				      "via its referent '%s') are not allowed"),
 				    u->refname);
-			return TRANSACTION_NAME_CONFLICT;
+			return REF_TRANSACTION_ERROR_NAME_CONFLICT;
 		}
 
 		ref_transaction_add_update(
@@ -1147,7 +1147,7 @@ static int prepare_single_update(struct reftable_ref_store *refs,
 	ret = reftable_backend_read_ref(be, rewritten_ref,
 					&current_oid, referent, &u->type);
 	if (ret < 0)
-		return ret;
+		return REF_TRANSACTION_ERROR_GENERIC;
 	if (ret > 0 && !ref_update_expects_existing_old_ref(u)) {
 		/*
 		 * The reference does not exist, and we either have no
@@ -1168,7 +1168,7 @@ static int prepare_single_update(struct reftable_ref_store *refs,
 			ret = queue_transaction_update(refs, tx_data, u,
 						       &current_oid, err);
 			if (ret)
-				return ret;
+				return REF_TRANSACTION_ERROR_GENERIC;
 		}
 
 		return 0;
@@ -1180,7 +1180,7 @@ static int prepare_single_update(struct reftable_ref_store *refs,
 
 				   "unable to resolve reference '%s'"),
 			    ref_update_original_update_refname(u), u->refname);
-		return -1;
+		return REF_TRANSACTION_ERROR_NONEXISTENT_REF;
 	}
 
 	if (u->type & REF_ISSYMREF) {
@@ -1196,7 +1196,7 @@ static int prepare_single_update(struct reftable_ref_store *refs,
 			if (u->flags & REF_HAVE_OLD && !resolved) {
 				strbuf_addf(err, _("cannot lock ref '%s': "
 						   "error reading reference"), u->refname);
-				return -1;
+				return REF_TRANSACTION_ERROR_GENERIC;
 			}
 		} else {
 			struct ref_update *new_update;
@@ -1211,7 +1211,7 @@ static int prepare_single_update(struct reftable_ref_store *refs,
 					    _("multiple updates for '%s' (including one "
 					      "via symref '%s') are not allowed"),
 					    referent->buf, u->refname);
-				return TRANSACTION_NAME_CONFLICT;
+				return REF_TRANSACTION_ERROR_NAME_CONFLICT;
 			}
 
 			/*
@@ -1255,31 +1255,32 @@ static int prepare_single_update(struct reftable_ref_store *refs,
 					   "but is a regular ref"),
 				    ref_update_original_update_refname(u),
 				    u->old_target);
-			return -1;
+			return REF_TRANSACTION_ERROR_EXPECTED_SYMREF;
 		}
 
-		if (ref_update_check_old_target(referent->buf, u, err)) {
-			return -1;
-		}
+		ret = ref_update_check_old_target(referent->buf, u, err);
+		if (ret)
+			return ret;
 	} else if ((u->flags & REF_HAVE_OLD) && !oideq(&current_oid, &u->old_oid)) {
 		if (is_null_oid(&u->old_oid)) {
 			strbuf_addf(err, _("cannot lock ref '%s': "
 					   "reference already exists"),
 				    ref_update_original_update_refname(u));
-			return TRANSACTION_CREATE_EXISTS;
-		}
-		else if (is_null_oid(&current_oid))
+			return REF_TRANSACTION_ERROR_CREATE_EXISTS;
+		} else if (is_null_oid(&current_oid)) {
 			strbuf_addf(err, _("cannot lock ref '%s': "
 					   "reference is missing but expected %s"),
 				    ref_update_original_update_refname(u),
 				    oid_to_hex(&u->old_oid));
-		else
+			return REF_TRANSACTION_ERROR_NONEXISTENT_REF;
+		} else {
 			strbuf_addf(err, _("cannot lock ref '%s': "
 					   "is at %s but expected %s"),
 				    ref_update_original_update_refname(u),
 				    oid_to_hex(&current_oid),
 				    oid_to_hex(&u->old_oid));
-		return TRANSACTION_NAME_CONFLICT;
+			return REF_TRANSACTION_ERROR_INCORRECT_OLD_VALUE;
+		}
 	}
 
 	/*
@@ -1296,8 +1297,8 @@ static int prepare_single_update(struct reftable_ref_store *refs,
 	if ((u->type & REF_ISSYMREF) ||
 	    (u->flags & REF_LOG_ONLY) ||
 	    (u->flags & REF_HAVE_NEW && !oideq(&current_oid, &u->new_oid)))
-		return queue_transaction_update(refs, tx_data, u,
-					       &current_oid, err);
+		if (queue_transaction_update(refs, tx_data, u, &current_oid, err))
+			return REF_TRANSACTION_ERROR_GENERIC;
 
 	return 0;
 }
@@ -1386,7 +1387,6 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 	transaction->state = REF_TRANSACTION_PREPARED;
 
 done:
-	assert(ret != REFTABLE_API_ERROR);
 	if (ret < 0) {
 		free_transaction_data(tx_data);
 		transaction->state = REF_TRANSACTION_CLOSED;

-- 
2.48.1

