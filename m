Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E73726159E
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 09:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740475777; cv=none; b=JZzdEDkD0B3VWZuS9F1ANcGFvvD6ZCBHRwklXRUTH2XIFK/pQB4S/s7u5+s53X+/eKBqnn+nwv9hAndKBrg4tajp3HhVPUVJKnR+P94VbDlb5dpzvTmCKvXgpndN70GdR50wSWrSDAo7gs3lrkzJa/23KpqpU0n/uSoFKfzIaZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740475777; c=relaxed/simple;
	bh=5oYAAacciL00PIoOvUM6oBpdxVgGTcMiKpW//Vw32N8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U7lC2SBgA+cBQiyMErvQrV8h4RWLKWyb37yNQqAD0QUIvspZjNfk1w/wyqy/YJnmjbVPeTizHlIj6WBSl5VXBxRivN32LC3Bw5/fgZtfULHKBwzOFzYxFnhU+7BuodswxwE8hK3cypeeGhLbmcjFIDnnwa5J3IhswdYJNXleebI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TSG2EoX1; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TSG2EoX1"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-abb7520028bso714770866b.3
        for <git@vger.kernel.org>; Tue, 25 Feb 2025 01:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740475772; x=1741080572; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9/caIaIm7HXVyxI7p0shD7HAWJDb9UKbjiK2XbAz+RU=;
        b=TSG2EoX1dL0A8LVENBB4SvJUgdAdcocuXmlt0dWNkX1Of2vAYwKKLFfT+AvKLOCH2v
         VGIFCk6cTJwFet40Rhx/UOhEcJG9vucX7fk2iBxrMxJMkqMf4Ui5fVZI26OfaW1KVvDI
         h2jM21xLHhke7T5BTaSr0zgVwIWVqOsN302FTfffgNWI8oD6nd4Vkzz6F+c/iV2cHacF
         YjXZuzz4KsdQG2PETt8A3p7pTPGqTovqh+mNmDwBc+P+NzlUc5VZpdNZ5MNRetcBOfn1
         YxTPU5hcLkMlrRMHbcQTloGe+hWTvn6U4vTbzOj+EJCSWsUUtwQdWoRU6wykMYNmAHO4
         vDqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740475772; x=1741080572;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9/caIaIm7HXVyxI7p0shD7HAWJDb9UKbjiK2XbAz+RU=;
        b=n7TQNwg9I4kSfpWKET5pPfeeukN4MQwxnZ+YanLio7atOqXF2A9AKQ4BcvqwRLMHek
         XUQLaA2T8YqLh8DkbNk+1fHODNyCjIuyD3UXVUTefBcDayO41RuLLAQUihfwO0YXuLeL
         BKIXO4MvLoqituCYDZ4mluonRNnNjxztjNr6wg+gD6LcCMV+Gz6e/TD8sQsZC/2toKZS
         C++h0KYSmA6iyFRyogORMv3KjFb6zllnh1F7nVEBBNuP6Y51JLoxNLgAmiFLRfM62llk
         jLDXkwzIpSPHjG52sY3slbYao96GIwfznDU6Ko7zRoKvZwCkgGb4E+RK8BJCjJvWPGAK
         A4Eg==
X-Gm-Message-State: AOJu0YyPv7be3dKTpQDVuHVpdTGv9kuRc9yODQgouAgrjXgkoTzKUvI3
	vr+VaSgzI5QpmjCCpPT7wkJCXqOjfNEI0IO2KxIJszmi4qIddcPamDHmj1K/
X-Gm-Gg: ASbGncsLRy3cpx37WEWdFqMS00IthpWQyrFrsK0tlFxkAQYIMI4s+UU4yII9mofKoM2
	bnm6TWCRGshESFfoPApsYOiTEtbhcmVZBYnR9EBN+56wOEB12+im6gS70tzDgdV2uxtuWv/OPrB
	h88wdjVimVVO0tiCup8n3bKXR7aeBsSl1lxPEhfBOBZBghXakrQ6ZHQA7vJH6V77HgSOwMscLnI
	9y26fT/mVopNG0LP68BrrkCu/zPs5sCSQPrCnShDtKa/w4aU2BWnistKlQi55sUL7R04/aCuB8L
	KBOU8oGWpq+W/ERPH5fOGfPTfQf+1Htk
X-Google-Smtp-Source: AGHT+IHAWD/djqzDiN4TmjtFrscLWObcU/uPaBj63zkJuGNZ9LXej5nxl1OTo1Bjgaybun+G/IIVPQ==
X-Received: by 2002:a17:907:2dab:b0:ab7:e12a:4846 with SMTP id a640c23a62f3a-abc09a5ee8dmr1706353566b.19.1740475772247;
        Tue, 25 Feb 2025 01:29:32 -0800 (PST)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:20c2:4ab6:a193:5b8c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed1cd561esm111944466b.19.2025.02.25.01.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:29:31 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 25 Feb 2025 10:29:08 +0100
Subject: [PATCH v2 5/7] refs: introduce enum-based transaction error types
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-245-partially-atomic-ref-updates-v2-5-cfa3236895d7@gmail.com>
References: <20250225-245-partially-atomic-ref-updates-v2-0-cfa3236895d7@gmail.com>
In-Reply-To: <20250225-245-partially-atomic-ref-updates-v2-0-cfa3236895d7@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, jltobler@gmail.com, 
 phillip.wood123@gmail.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=28592;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=5oYAAacciL00PIoOvUM6oBpdxVgGTcMiKpW//Vw32N8=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGe9jXV7UQEwRWn/LYgxYLTw/TLFujd/yHMTz
 6jk7C/HlNYai4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJnvY11AAoJED7VnySO
 Rox/BtwL/0HoQ7OheHRJX4rsziowxmra9o3FMe6s5Od4rgg2yDpT0DI6WGIhen2e3faM4nzBBR2
 GSL4O3aHlVBUaCrTJ5D1mdWh3hOJcXO8LFDFxtQznGIXhuunI/GADCdov/21XgFf8HMMxZIfuLA
 DsYhziszzsM3nmlixPgm3NdZqSHFXNVrNMwOoEYXdpPuH9Mxg2S508zdgUdq1fdDpkhe9gpem2B
 4bgj5LOkovKf7LyjtBxwCzJNO+/eUZ1SDREA1oQe3yx2NFklzA0Twg7N6/4puYkWTcj+F6LRGW9
 OGVeOU0rAv7WavZ4ahu1xrCwpQN5ZRMFFvrI+TiAB6OAwxZO8l8PunIq4LtXOqAKNoRTeGEAbYU
 vB1EiVFJELk/ImEPe/LZSu0DdKgwfGPFziAnHoapQyMItL//VBCJ/CRMsreB4BNKT5Rp+hdyE0y
 tlPd+vbwlX6rqaTzwhykMSXjbsk0IQsNEfOQuRba7NeXyaGyNjSTSzaOPhNIIj7rz1eYTkYKHj4
 0g=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Replace preprocessor-defined transaction errors with a strongly-typed
enum `transaction_error`. This change:

  - Improves type safety and function signature clarity.
  - Makes error handling more explicit and discoverable.
  - Maintains existing error cases, while adding new error cases for
    common scenarios.

This refactoring paves the way for more comprehensive error handling
which we will utilize in the upcoming commits to add partial transaction
support.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c                  |  44 +++++++------
 refs.h                  |  56 ++++++++++------
 refs/files-backend.c    | 167 ++++++++++++++++++++++++------------------------
 refs/packed-backend.c   |  21 +++---
 refs/refs-internal.h    |   5 +-
 refs/reftable-backend.c |  59 +++++++++--------
 6 files changed, 191 insertions(+), 161 deletions(-)

diff --git a/refs.c b/refs.c
index 69f385f344..f989a46a5a 100644
--- a/refs.c
+++ b/refs.c
@@ -2497,18 +2497,18 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	return ret;
 }
 
-int refs_verify_refnames_available(struct ref_store *refs,
-				   const struct string_list *refnames,
-				   const struct string_list *extras,
-				   const struct string_list *skip,
-				   unsigned int initial_transaction,
-				   struct strbuf *err)
+enum transaction_error refs_verify_refnames_available(struct ref_store *refs,
+						      const struct string_list *refnames,
+						      const struct string_list *extras,
+						      const struct string_list *skip,
+						      unsigned int initial_transaction,
+						      struct strbuf *err)
 {
 	struct strbuf dirname = STRBUF_INIT;
 	struct strbuf referent = STRBUF_INIT;
 	struct ref_iterator *iter = NULL;
 	struct strset dirnames;
-	int ret = -1;
+	int ret = TRANSACTION_NAME_CONFLICT;
 
 	/*
 	 * For the sake of comments in this function, suppose that
@@ -2624,12 +2624,12 @@ int refs_verify_refnames_available(struct ref_store *refs,
 	return ret;
 }
 
-int refs_verify_refname_available(struct ref_store *refs,
-				  const char *refname,
-				  const struct string_list *extras,
-				  const struct string_list *skip,
-				  unsigned int initial_transaction,
-				  struct strbuf *err)
+enum transaction_error refs_verify_refname_available(struct ref_store *refs,
+						     const char *refname,
+						     const struct string_list *extras,
+						     const struct string_list *skip,
+						     unsigned int initial_transaction,
+						     struct strbuf *err)
 {
 	struct string_list_item item = { .string = (char *) refname };
 	struct string_list refnames = {
@@ -2817,26 +2817,28 @@ int ref_update_has_null_new_value(struct ref_update *update)
 	return !update->new_target && is_null_oid(&update->new_oid);
 }
 
-int ref_update_check_old_target(const char *referent, struct ref_update *update,
-				struct strbuf *err)
+enum transaction_error ref_update_check_old_target(const char *referent,
+					      struct ref_update *update,
+					      struct strbuf *err)
 {
 	if (!update->old_target)
 		BUG("called without old_target set");
 
 	if (!strcmp(referent, update->old_target))
-		return 0;
+		return TRANSACTION_OK;
 
-	if (!strcmp(referent, ""))
+	if (!strcmp(referent, "")) {
 		strbuf_addf(err, "verifying symref target: '%s': "
 			    "reference is missing but expected %s",
 			    ref_update_original_update_refname(update),
 			    update->old_target);
-	else
-		strbuf_addf(err, "verifying symref target: '%s': "
-			    "is at %s but expected %s",
+		return TRANSACTION_NONEXISTENT_REF;
+	}
+
+	strbuf_addf(err, "verifying symref target: '%s': is at %s but expected %s",
 			    ref_update_original_update_refname(update),
 			    referent, update->old_target);
-	return -1;
+	return TRANSACTION_INCORRECT_OLD_VALUE;
 }
 
 struct migration_data {
diff --git a/refs.h b/refs.h
index b14ba1f9ff..8e9ead174c 100644
--- a/refs.h
+++ b/refs.h
@@ -16,6 +16,31 @@ struct worktree;
 enum ref_storage_format ref_storage_format_by_name(const char *name);
 const char *ref_storage_format_to_name(enum ref_storage_format ref_storage_format);
 
+/*
+ * enum transaction_error represents the following return codes:
+ * TRANSACTION_OK: success code.
+ * TRANSACTION_GENERIC_ERROR error_code: default error code.
+ * TRANSACTION_NAME_CONFLICT error_code: ref name conflict like A vs A/B.
+ * TRANSACTION_CREATE_EXISTS error_code: ref to be created already exists.
+ * TRANSACTION_NONEXISTENT_REF error_code: ref expected but doesn't exist.
+ * TRANSACTION_INCORRECT_OLD_VALUE error_code: provided old_oid or old_target of
+ * reference doesn't match actual.
+ * TRANSACTION_INVALID_NEW_VALUE error_code: provided new_oid or new_target is
+ * invalid.
+ * TRANSACTION_EXPECTED_SYMREF error_code: expected ref to be symref, but is a
+ * regular ref.
+ */
+enum transaction_error {
+	TRANSACTION_OK = 0,
+	TRANSACTION_GENERIC_ERROR = -1,
+	TRANSACTION_NAME_CONFLICT = -2,
+	TRANSACTION_CREATE_EXISTS = -3,
+	TRANSACTION_NONEXISTENT_REF = -4,
+	TRANSACTION_INCORRECT_OLD_VALUE = -5,
+	TRANSACTION_INVALID_NEW_VALUE = -6,
+	TRANSACTION_EXPECTED_SYMREF = -7,
+};
+
 /*
  * Resolve a reference, recursively following symbolic references.
  *
@@ -117,24 +142,24 @@ int refs_read_symbolic_ref(struct ref_store *ref_store, const char *refname,
  *
  * extras and skip must be sorted.
  */
-int refs_verify_refname_available(struct ref_store *refs,
-				  const char *refname,
-				  const struct string_list *extras,
-				  const struct string_list *skip,
-				  unsigned int initial_transaction,
-				  struct strbuf *err);
+enum transaction_error refs_verify_refname_available(struct ref_store *refs,
+						     const char *refname,
+						     const struct string_list *extras,
+						     const struct string_list *skip,
+						     unsigned int initial_transaction,
+						     struct strbuf *err);
 
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
+enum transaction_error refs_verify_refnames_available(struct ref_store *refs,
+						      const struct string_list *refnames,
+						      const struct string_list *extras,
+						      const struct string_list *skip,
+						      unsigned int initial_transaction,
+						      struct strbuf *err);
 
 int refs_ref_exists(struct ref_store *refs, const char *refname);
 
@@ -830,13 +855,6 @@ int ref_transaction_verify(struct ref_transaction *transaction,
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
index 7c6a0b3478..3b0adf8bb2 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -676,19 +676,19 @@ static void unlock_ref(struct ref_lock *lock)
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
+static enum transaction_error lock_raw_ref(struct files_ref_store *refs,
+					   const char *refname, int mustexist,
+					   struct string_list *refnames_to_check,
+					   const struct string_list *extras,
+					   struct ref_lock **lock_p,
+					   struct strbuf *referent,
+					   unsigned int *type,
+					   struct strbuf *err)
 {
+	enum transaction_error ret = TRANSACTION_GENERIC_ERROR;
 	struct ref_lock *lock;
 	struct strbuf ref_file = STRBUF_INIT;
 	int attempts_remaining = 3;
-	int ret = TRANSACTION_GENERIC_ERROR;
 	int failure_errno;
 
 	assert(err);
@@ -728,6 +728,7 @@ static int lock_raw_ref(struct files_ref_store *refs,
 				strbuf_reset(err);
 				strbuf_addf(err, "unable to resolve reference '%s'",
 					    refname);
+				ret = TRANSACTION_NONEXISTENT_REF;
 			} else {
 				/*
 				 * The error message set by
@@ -788,6 +789,7 @@ static int lock_raw_ref(struct files_ref_store *refs,
 				/* Garden variety missing reference. */
 				strbuf_addf(err, "unable to resolve reference '%s'",
 					    refname);
+				ret = TRANSACTION_NONEXISTENT_REF;
 				goto error_return;
 			} else {
 				/*
@@ -820,6 +822,7 @@ static int lock_raw_ref(struct files_ref_store *refs,
 				/* Garden variety missing reference. */
 				strbuf_addf(err, "unable to resolve reference '%s'",
 					    refname);
+				ret = TRANSACTION_NONEXISTENT_REF;
 				goto error_return;
 			} else if (remove_dir_recursively(&ref_file,
 							  REMOVE_DIR_EMPTY_ONLY)) {
@@ -863,7 +866,7 @@ static int lock_raw_ref(struct files_ref_store *refs,
 		string_list_insert(refnames_to_check, refname);
 	}
 
-	ret = 0;
+	ret = TRANSACTION_OK;
 	goto out;
 
 error_return:
@@ -1517,10 +1520,10 @@ static int rename_tmp_log(struct files_ref_store *refs, const char *newrefname)
 	return ret;
 }
 
-static int write_ref_to_lockfile(struct files_ref_store *refs,
-				 struct ref_lock *lock,
-				 const struct object_id *oid,
-				 int skip_oid_verification, struct strbuf *err);
+static enum transaction_error write_ref_to_lockfile(struct files_ref_store *refs,
+						    struct ref_lock *lock,
+						    const struct object_id *oid,
+						    int skip_oid_verification, struct strbuf *err);
 static int commit_ref_update(struct files_ref_store *refs,
 			     struct ref_lock *lock,
 			     const struct object_id *oid, const char *logmsg,
@@ -1926,10 +1929,11 @@ static int files_log_ref_write(struct files_ref_store *refs,
  * Write oid into the open lockfile, then close the lockfile. On
  * errors, rollback the lockfile, fill in *err and return -1.
  */
-static int write_ref_to_lockfile(struct files_ref_store *refs,
-				 struct ref_lock *lock,
-				 const struct object_id *oid,
-				 int skip_oid_verification, struct strbuf *err)
+static enum transaction_error write_ref_to_lockfile(struct files_ref_store *refs,
+						    struct ref_lock *lock,
+						    const struct object_id *oid,
+						    int skip_oid_verification,
+						    struct strbuf *err)
 {
 	static char term = '\n';
 	struct object *o;
@@ -1943,7 +1947,7 @@ static int write_ref_to_lockfile(struct files_ref_store *refs,
 				"trying to write ref '%s' with nonexistent object %s",
 				lock->ref_name, oid_to_hex(oid));
 			unlock_ref(lock);
-			return -1;
+			return TRANSACTION_INVALID_NEW_VALUE;
 		}
 		if (o->type != OBJ_COMMIT && is_branch(lock->ref_name)) {
 			strbuf_addf(
@@ -1951,7 +1955,7 @@ static int write_ref_to_lockfile(struct files_ref_store *refs,
 				"trying to write non-commit object %s to branch '%s'",
 				oid_to_hex(oid), lock->ref_name);
 			unlock_ref(lock);
-			return -1;
+			return TRANSACTION_INVALID_NEW_VALUE;
 		}
 	}
 	fd = get_lock_file_fd(&lock->lk);
@@ -1962,9 +1966,9 @@ static int write_ref_to_lockfile(struct files_ref_store *refs,
 		strbuf_addf(err,
 			    "couldn't write '%s'", get_lock_file_path(&lock->lk));
 		unlock_ref(lock);
-		return -1;
+		return TRANSACTION_GENERIC_ERROR;
 	}
-	return 0;
+	return TRANSACTION_OK;
 }
 
 /*
@@ -2376,9 +2380,10 @@ static struct ref_iterator *files_reflog_iterator_begin(struct ref_store *ref_st
  * If update is a direct update of head_ref (the reference pointed to
  * by HEAD), then add an extra REF_LOG_ONLY update for HEAD.
  */
-static int split_head_update(struct ref_update *update,
-			     struct ref_transaction *transaction,
-			     const char *head_ref, struct strbuf *err)
+static enum transaction_error split_head_update(struct ref_update *update,
+						struct ref_transaction *transaction,
+						const char *head_ref,
+						struct strbuf *err)
 {
 	struct ref_update *new_update;
 
@@ -2386,10 +2391,10 @@ static int split_head_update(struct ref_update *update,
 	    (update->flags & REF_SKIP_CREATE_REFLOG) ||
 	    (update->flags & REF_IS_PRUNING) ||
 	    (update->flags & REF_UPDATE_VIA_HEAD))
-		return 0;
+		return TRANSACTION_OK;
 
 	if (strcmp(update->refname, head_ref))
-		return 0;
+		return TRANSACTION_OK;
 
 	/*
 	 * First make sure that HEAD is not already in the
@@ -2419,7 +2424,7 @@ static int split_head_update(struct ref_update *update,
 	if (strcmp(new_update->refname, "HEAD"))
 		BUG("%s unexpectedly not 'HEAD'", new_update->refname);
 
-	return 0;
+	return TRANSACTION_OK;
 }
 
 /*
@@ -2430,10 +2435,10 @@ static int split_head_update(struct ref_update *update,
  * Note that the new update will itself be subject to splitting when
  * the iteration gets to it.
  */
-static int split_symref_update(struct ref_update *update,
-			       const char *referent,
-			       struct ref_transaction *transaction,
-			       struct strbuf *err)
+static enum transaction_error split_symref_update(struct ref_update *update,
+						  const char *referent,
+						  struct ref_transaction *transaction,
+						  struct strbuf *err)
 {
 	struct ref_update *new_update;
 	unsigned int new_flags;
@@ -2482,7 +2487,7 @@ static int split_symref_update(struct ref_update *update,
 	update->flags |= REF_LOG_ONLY | REF_NO_DEREF;
 	update->flags &= ~REF_HAVE_OLD;
 
-	return 0;
+	return TRANSACTION_OK;
 }
 
 /*
@@ -2491,34 +2496,32 @@ static int split_symref_update(struct ref_update *update,
  * everything is OK, return 0; otherwise, write an error message to
  * err and return -1.
  */
-static int check_old_oid(struct ref_update *update, struct object_id *oid,
-			 struct strbuf *err)
+static enum transaction_error check_old_oid(struct ref_update *update,
+					    struct object_id *oid,
+					    struct strbuf *err)
 {
-	int ret = TRANSACTION_GENERIC_ERROR;
-
 	if (!(update->flags & REF_HAVE_OLD) ||
 		   oideq(oid, &update->old_oid))
-		return 0;
+		return TRANSACTION_OK;
 
 	if (is_null_oid(&update->old_oid)) {
 		strbuf_addf(err, "cannot lock ref '%s': "
 			    "reference already exists",
 			    ref_update_original_update_refname(update));
-		ret = TRANSACTION_CREATE_EXISTS;
-	}
-	else if (is_null_oid(oid))
+		return TRANSACTION_CREATE_EXISTS;
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
+		return TRANSACTION_NONEXISTENT_REF;
+	}
 
-	return ret;
+	strbuf_addf(err, "cannot lock ref '%s': is at %s but expected %s",
+		    ref_update_original_update_refname(update), oid_to_hex(oid),
+		    oid_to_hex(&update->old_oid));
+
+	return TRANSACTION_INCORRECT_OLD_VALUE;
 }
 
 struct files_transaction_backend_data {
@@ -2540,17 +2543,17 @@ struct files_transaction_backend_data {
  * - If it is an update of head_ref, add a corresponding REF_LOG_ONLY
  *   update of HEAD.
  */
-static int lock_ref_for_update(struct files_ref_store *refs,
-			       struct ref_update *update,
-			       struct ref_transaction *transaction,
-			       const char *head_ref,
-			       struct string_list *refnames_to_check,
-			       struct strbuf *err)
+static enum transaction_error lock_ref_for_update(struct files_ref_store *refs,
+						  struct ref_update *update,
+						  struct ref_transaction *transaction,
+						  const char *head_ref,
+						  struct string_list *refnames_to_check,
+						  struct strbuf *err)
 {
 	struct strbuf referent = STRBUF_INIT;
 	int mustexist = ref_update_expects_existing_old_ref(update);
 	struct files_transaction_backend_data *backend_data;
-	int ret = 0;
+	enum transaction_error ret = TRANSACTION_OK;
 	struct ref_lock *lock;
 
 	files_assert_main_repository(refs, "lock_ref_for_update");
@@ -2607,16 +2610,12 @@ static int lock_ref_for_update(struct files_ref_store *refs,
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
+			if (ret) {
+				goto out;
 			}
 		} else {
 			/*
@@ -2644,7 +2643,7 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 					   "but is a regular ref"),
 				    ref_update_original_update_refname(update),
 				    update->old_target);
-			ret = TRANSACTION_GENERIC_ERROR;
+			ret = TRANSACTION_EXPECTED_SYMREF;
 			goto out;
 		} else {
 			ret = check_old_oid(update, &lock->old_oid, err);
@@ -2693,25 +2692,27 @@ static int lock_ref_for_update(struct files_ref_store *refs,
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
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 3247871574..75e1ebf67d 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1323,10 +1323,11 @@ static int packed_ref_store_remove_on_disk(struct ref_store *ref_store,
  * The packfile must be locked before calling this function and will
  * remain locked when it is done.
  */
-static int write_with_updates(struct packed_ref_store *refs,
-			      struct string_list *updates,
-			      struct strbuf *err)
+static enum transaction_error write_with_updates(struct packed_ref_store *refs,
+						 struct string_list *updates,
+						 struct strbuf *err)
 {
+	enum transaction_error ret = TRANSACTION_GENERIC_ERROR;
 	struct ref_iterator *iter = NULL;
 	size_t i;
 	int ok;
@@ -1350,7 +1351,7 @@ static int write_with_updates(struct packed_ref_store *refs,
 		strbuf_addf(err, "unable to create file %s: %s",
 			    sb.buf, strerror(errno));
 		strbuf_release(&sb);
-		return -1;
+		return TRANSACTION_GENERIC_ERROR;
 	}
 	strbuf_release(&sb);
 
@@ -1406,6 +1407,7 @@ static int write_with_updates(struct packed_ref_store *refs,
 					strbuf_addf(err, "cannot update ref '%s': "
 						    "reference already exists",
 						    update->refname);
+					ret = TRANSACTION_CREATE_EXISTS;
 					goto error;
 				} else if (!oideq(&update->old_oid, iter->oid)) {
 					strbuf_addf(err, "cannot update ref '%s': "
@@ -1413,6 +1415,7 @@ static int write_with_updates(struct packed_ref_store *refs,
 						    update->refname,
 						    oid_to_hex(iter->oid),
 						    oid_to_hex(&update->old_oid));
+					ret = TRANSACTION_INCORRECT_OLD_VALUE;
 					goto error;
 				}
 			}
@@ -1449,6 +1452,7 @@ static int write_with_updates(struct packed_ref_store *refs,
 					    "reference is missing but expected %s",
 					    update->refname,
 					    oid_to_hex(&update->old_oid));
+				return TRANSACTION_NONEXISTENT_REF;
 				goto error;
 			}
 		}
@@ -1506,10 +1510,10 @@ static int write_with_updates(struct packed_ref_store *refs,
 			    strerror(errno));
 		strbuf_release(&sb);
 		delete_tempfile(&refs->tempfile);
-		return -1;
+		return TRANSACTION_GENERIC_ERROR;
 	}
 
-	return 0;
+	return TRANSACTION_OK;
 
 write_error:
 	strbuf_addf(err, "error writing to %s: %s",
@@ -1518,7 +1522,7 @@ static int write_with_updates(struct packed_ref_store *refs,
 error:
 	ref_iterator_free(iter);
 	delete_tempfile(&refs->tempfile);
-	return -1;
+	return ret;
 }
 
 int is_packed_transaction_needed(struct ref_store *ref_store,
@@ -1672,7 +1676,8 @@ static int packed_transaction_prepare(struct ref_store *ref_store,
 		data->own_lock = 1;
 	}
 
-	if (write_with_updates(refs, &transaction->refnames, err))
+	ret = write_with_updates(refs, &transaction->refnames, err);
+	if (ret)
 		goto failure;
 
 	transaction->state = REF_TRANSACTION_PREPARED;
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 4b7fc8f1ab..c97045fbed 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -769,8 +769,9 @@ int ref_update_has_null_new_value(struct ref_update *update);
  * If everything is OK, return 0; otherwise, write an error message to
  * err and return -1.
  */
-int ref_update_check_old_target(const char *referent, struct ref_update *update,
-				struct strbuf *err);
+enum transaction_error ref_update_check_old_target(const char *referent,
+					      struct ref_update *update,
+					      struct strbuf *err);
 
 /*
  * Check if the ref must exist, this means that the old_oid or
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 2c1e2995de..e1fd9c2de2 100644
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
+static enum transaction_error prepare_single_update(struct reftable_ref_store *refs,
+						    struct reftable_transaction_data *tx_data,
+						    struct ref_transaction *transaction,
+						    struct reftable_backend *be,
+						    struct ref_update *u,
+						    struct string_list *refnames_to_check,
+						    unsigned int head_type,
+						    struct strbuf *head_referent,
+						    struct strbuf *referent,
+						    struct strbuf *err)
 {
+	enum transaction_error ret = TRANSACTION_OK;
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
+		return TRANSACTION_GENERIC_ERROR;
 
 	/* Verify that the new object ID is valid. */
 	if ((u->flags & REF_HAVE_NEW) && !is_null_oid(&u->new_oid) &&
@@ -1104,13 +1104,13 @@ static int prepare_single_update(struct reftable_ref_store *refs,
 			strbuf_addf(err,
 				    _("trying to write ref '%s' with nonexistent object %s"),
 				    u->refname, oid_to_hex(&u->new_oid));
-			return -1;
+			return TRANSACTION_INVALID_NEW_VALUE;
 		}
 
 		if (o->type != OBJ_COMMIT && is_branch(u->refname)) {
 			strbuf_addf(err, _("trying to write non-commit object %s to branch '%s'"),
 				    oid_to_hex(&u->new_oid), u->refname);
-			return -1;
+			return TRANSACTION_INVALID_NEW_VALUE;
 		}
 	}
 
@@ -1147,7 +1147,7 @@ static int prepare_single_update(struct reftable_ref_store *refs,
 	ret = reftable_backend_read_ref(be, rewritten_ref,
 					&current_oid, referent, &u->type);
 	if (ret < 0)
-		return ret;
+		return TRANSACTION_GENERIC_ERROR;
 	if (ret > 0 && !ref_update_expects_existing_old_ref(u)) {
 		/*
 		 * The reference does not exist, and we either have no
@@ -1168,7 +1168,7 @@ static int prepare_single_update(struct reftable_ref_store *refs,
 			ret = queue_transaction_update(refs, tx_data, u,
 						       &current_oid, err);
 			if (ret)
-				return ret;
+				return TRANSACTION_GENERIC_ERROR;
 		}
 
 		return 0;
@@ -1180,7 +1180,7 @@ static int prepare_single_update(struct reftable_ref_store *refs,
 
 				   "unable to resolve reference '%s'"),
 			    ref_update_original_update_refname(u), u->refname);
-		return -1;
+		return TRANSACTION_NONEXISTENT_REF;
 	}
 
 	if (u->type & REF_ISSYMREF) {
@@ -1196,7 +1196,7 @@ static int prepare_single_update(struct reftable_ref_store *refs,
 			if (u->flags & REF_HAVE_OLD && !resolved) {
 				strbuf_addf(err, _("cannot lock ref '%s': "
 						   "error reading reference"), u->refname);
-				return -1;
+				return TRANSACTION_GENERIC_ERROR;
 			}
 		} else {
 			struct ref_update *new_update;
@@ -1255,11 +1255,12 @@ static int prepare_single_update(struct reftable_ref_store *refs,
 					   "but is a regular ref"),
 				    ref_update_original_update_refname(u),
 				    u->old_target);
-			return -1;
+			return TRANSACTION_EXPECTED_SYMREF;
 		}
 
-		if (ref_update_check_old_target(referent->buf, u, err)) {
-			return -1;
+		ret = ref_update_check_old_target(referent->buf, u, err);
+		if (ret) {
+			return ret;
 		}
 	} else if ((u->flags & REF_HAVE_OLD) && !oideq(&current_oid, &u->old_oid)) {
 		if (is_null_oid(&u->old_oid)) {
@@ -1268,18 +1269,21 @@ static int prepare_single_update(struct reftable_ref_store *refs,
 				    ref_update_original_update_refname(u));
 			return TRANSACTION_CREATE_EXISTS;
 		}
-		else if (is_null_oid(&current_oid))
+		else if (is_null_oid(&current_oid)) {
 			strbuf_addf(err, _("cannot lock ref '%s': "
 					   "reference is missing but expected %s"),
 				    ref_update_original_update_refname(u),
 				    oid_to_hex(&u->old_oid));
-		else
+			return TRANSACTION_NONEXISTENT_REF;
+
+		} else {
 			strbuf_addf(err, _("cannot lock ref '%s': "
 					   "is at %s but expected %s"),
 				    ref_update_original_update_refname(u),
 				    oid_to_hex(&current_oid),
 				    oid_to_hex(&u->old_oid));
-		return TRANSACTION_NAME_CONFLICT;
+			return TRANSACTION_INCORRECT_OLD_VALUE;
+		}
 	}
 
 	/*
@@ -1296,10 +1300,10 @@ static int prepare_single_update(struct reftable_ref_store *refs,
 	if ((u->type & REF_ISSYMREF) ||
 	    (u->flags & REF_LOG_ONLY) ||
 	    (u->flags & REF_HAVE_NEW && !oideq(&current_oid, &u->new_oid)))
-		return queue_transaction_update(refs, tx_data, u,
-					       &current_oid, err);
+		if (queue_transaction_update(refs, tx_data, u, &current_oid, err))
+			return TRANSACTION_GENERIC_ERROR;
 
-	return 0;
+	return TRANSACTION_OK;
 }
 
 static int reftable_be_transaction_prepare(struct ref_store *ref_store,
@@ -1386,7 +1390,6 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 	transaction->state = REF_TRANSACTION_PREPARED;
 
 done:
-	assert(ret != REFTABLE_API_ERROR);
 	if (ret < 0) {
 		free_transaction_data(tx_data);
 		transaction->state = REF_TRANSACTION_CLOSED;

-- 
2.47.2

