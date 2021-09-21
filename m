Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0548EC433F5
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 23:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5FC1611C6
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 23:25:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbhIUX1T (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 19:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbhIUX1T (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 19:27:19 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20DB4C061574
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 16:25:50 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id ci14-20020a056214054e00b0037a75ff56f9so6404429qvb.23
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 16:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5SCzeBtqZ3FeRmljs0/4m/LrIsHGW0n/SEZdg0eGk+0=;
        b=rRa7WbCFV79Lcf8DUpHwhzz2GP3qEC73+NQ/d0CrLRf1Uei5sU0S3ej+VxCDF/Q+fM
         SR1BV7rRffs+2YcJXZNv/o92xLUWjF+ar4mkSp720UfDzWc/TRR4/bSA4LWWjX6f0PaR
         amJVddgDV0Gry+ZTGn5YwGAYIVTR6tv+kl4geXRfLpLwcFPA6ntbJuWrJpasffO3aUB0
         naLHtOZCltrgUzi0jsix641i71TrkjNfrzkikMdcyad/hfiLXxOSHJMNtmlJMR1iTLr/
         7Wd2vOj54bCKV2LLnJ7Y7xZZhRZrR6018QWbbb+L355PiEpZ2ftCiSilQSJWwJzgsFWd
         iB3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5SCzeBtqZ3FeRmljs0/4m/LrIsHGW0n/SEZdg0eGk+0=;
        b=NjjU1rItpudOCp32EgWsAb7a5jZ10VAwBVZ7e54uZ2BK/ZWj0W/26OAxJzqoxD698p
         9eTVeapcZMXZQ+rclJhyp5496ECR6wuyw4RNK9/LGaHmeytVqI0tKiFdsUXrpbrw8iyb
         913Tf5/ujMfUQdq/P410QGa4Mil1LDDLatgvRFbUKTp6ADtOLVvl3bG2kJqdTTNRO2r1
         krJtZ9kwzdMpx0MY+PgG9Pz4KFYsQAzsE0cayz5JR8gNxOp4taB42+Kg9Y7qJ8NMrSLR
         90Z0minqQ+tFYtDlQ87Y8giSkLx3g/x9k6ahzBucNvLt/InvY58Q3c+n94z/3w3db6gB
         rQsA==
X-Gm-Message-State: AOAM532oacXs4sc//3f06nEb4jNLQxCxwL0AMAbUd2uyr6crBANHA79L
        3Jdlnrx+sE+0c1IwuhKV7FAdqBVKoUzJUc3AOqzWtNotZufyMS2mtklj8ed4jG73Y23UvzciTEL
        XctWaY1icxirUkOHYGCQJBh4EcEVwG0SOqnxnHsM354MC6Jy0c7HkZibWSTT6sDI=
X-Google-Smtp-Source: ABdhPJygfsgXAygxFopyYp3Hfb9GeLeRAFggymTdTkjf7xizr/oO0V35HO6OPuyERc1mraCShSXzKbpAYju0fg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6214:44a:: with SMTP id
 cc10mr34232522qvb.58.1632266749150; Tue, 21 Sep 2021 16:25:49 -0700 (PDT)
Date:   Tue, 21 Sep 2021 16:25:28 -0700
In-Reply-To: <20210921232529.81811-1-chooglen@google.com>
Message-Id: <20210921232529.81811-2-chooglen@google.com>
Mime-Version: 1.0
References: <20210921232529.81811-1-chooglen@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [RFC PATCH 1/2] refs: pass struct repository *r through to write_ref_to_lockfile()
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In refs/files-backend.c, write_ref_to_lockfile() uses the_repository to
validate the oid of the ref being written. Thus, any function that
includes write_ref_to_lockfile() in its call chain has an implicit
dependence on the odb of the_repository. This is undesirable in the case
where we are using oids that are not in the_repository, e.g. when we are
updating refs in a submodule.

Let's fix this by passing struct repository * as a parameter through to
write_ref_to_lockfile().

To avoid breaking existing call sites, the existing function
signatures in refs.h are preserved. struct repository * is only passed
to new functions; these new functions have names prefixed with repo_.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 refs.c                    | 21 +++++++++++----------
 refs.h                    | 18 ++++++++++++++----
 refs/debug.c              | 14 ++++++++------
 refs/files-backend.c      | 30 +++++++++++++++---------------
 refs/packed-backend.c     |  7 ++++---
 refs/refs-internal.h      |  7 ++++---
 t/helper/test-ref-store.c |  2 +-
 7 files changed, 57 insertions(+), 42 deletions(-)

diff --git a/refs.c b/refs.c
index 8b9f7c3a80..c217512cd3 100644
--- a/refs.c
+++ b/refs.c
@@ -2105,7 +2105,7 @@ static int run_transaction_hook(struct ref_transaction *transaction,
 	return ret;
 }
 
-int ref_transaction_prepare(struct ref_transaction *transaction,
+int repo_ref_transaction_prepare(struct repository *r, struct ref_transaction *transaction,
 			    struct strbuf *err)
 {
 	struct ref_store *refs = transaction->ref_store;
@@ -2132,7 +2132,7 @@ int ref_transaction_prepare(struct ref_transaction *transaction,
 		return -1;
 	}
 
-	ret = refs->be->transaction_prepare(refs, transaction, err);
+	ret = refs->be->transaction_prepare(r, refs, transaction, err);
 	if (ret)
 		return ret;
 
@@ -2172,7 +2172,8 @@ int ref_transaction_abort(struct ref_transaction *transaction,
 	return ret;
 }
 
-int ref_transaction_commit(struct ref_transaction *transaction,
+int repo_ref_transaction_commit(struct repository *r,
+			   struct ref_transaction *transaction,
 			   struct strbuf *err)
 {
 	struct ref_store *refs = transaction->ref_store;
@@ -2181,7 +2182,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	switch (transaction->state) {
 	case REF_TRANSACTION_OPEN:
 		/* Need to prepare first. */
-		ret = ref_transaction_prepare(transaction, err);
+		ret = repo_ref_transaction_prepare(r, transaction, err);
 		if (ret)
 			return ret;
 		break;
@@ -2421,36 +2422,36 @@ int delete_refs(const char *msg, struct string_list *refnames,
 	return refs_delete_refs(get_main_ref_store(the_repository), msg, refnames, flags);
 }
 
-int refs_rename_ref(struct ref_store *refs, const char *oldref,
+int refs_rename_ref(struct repository *r, struct ref_store *refs, const char *oldref,
 		    const char *newref, const char *logmsg)
 {
 	char *msg;
 	int retval;
 
 	msg = normalize_reflog_message(logmsg);
-	retval = refs->be->rename_ref(refs, oldref, newref, msg);
+	retval = refs->be->rename_ref(r, refs, oldref, newref, msg);
 	free(msg);
 	return retval;
 }
 
 int rename_ref(const char *oldref, const char *newref, const char *logmsg)
 {
-	return refs_rename_ref(get_main_ref_store(the_repository), oldref, newref, logmsg);
+	return refs_rename_ref(the_repository, get_main_ref_store(the_repository), oldref, newref, logmsg);
 }
 
-int refs_copy_existing_ref(struct ref_store *refs, const char *oldref,
+int refs_copy_existing_ref(struct repository *r, struct ref_store *refs, const char *oldref,
 		    const char *newref, const char *logmsg)
 {
 	char *msg;
 	int retval;
 
 	msg = normalize_reflog_message(logmsg);
-	retval = refs->be->copy_ref(refs, oldref, newref, msg);
+	retval = refs->be->copy_ref(r, refs, oldref, newref, msg);
 	free(msg);
 	return retval;
 }
 
 int copy_existing_ref(const char *oldref, const char *newref, const char *logmsg)
 {
-	return refs_copy_existing_ref(get_main_ref_store(the_repository), oldref, newref, logmsg);
+	return refs_copy_existing_ref(the_repository, get_main_ref_store(the_repository), oldref, newref, logmsg);
 }
diff --git a/refs.h b/refs.h
index 48970dfc7e..157d14d7a3 100644
--- a/refs.h
+++ b/refs.h
@@ -524,13 +524,13 @@ char *refs_shorten_unambiguous_ref(struct ref_store *refs,
 char *shorten_unambiguous_ref(const char *refname, int strict);
 
 /** rename ref, return 0 on success **/
-int refs_rename_ref(struct ref_store *refs, const char *oldref,
+int refs_rename_ref(struct repository *r, struct ref_store *refs, const char *oldref,
 		    const char *newref, const char *logmsg);
 int rename_ref(const char *oldref, const char *newref,
 			const char *logmsg);
 
 /** copy ref, return 0 on success **/
-int refs_copy_existing_ref(struct ref_store *refs, const char *oldref,
+int refs_copy_existing_ref(struct repository *r, struct ref_store *refs, const char *oldref,
 		    const char *newref, const char *logmsg);
 int copy_existing_ref(const char *oldref, const char *newref,
 			const char *logmsg);
@@ -706,8 +706,13 @@ int ref_transaction_verify(struct ref_transaction *transaction,
  * Callers who don't need such fine-grained control over committing
  * reference transactions should just call `ref_transaction_commit()`.
  */
-int ref_transaction_prepare(struct ref_transaction *transaction,
+int repo_ref_transaction_prepare(struct repository *r, struct ref_transaction *transaction,
 			    struct strbuf *err);
+static inline int ref_transaction_prepare(struct ref_transaction *transaction,
+					  struct strbuf *err)
+{
+	return repo_ref_transaction_prepare(the_repository, transaction, err);
+}
 
 /*
  * Commit all of the changes that have been queued in transaction, as
@@ -716,8 +721,13 @@ int ref_transaction_prepare(struct ref_transaction *transaction,
  * transaction, write an error message to `err`, and return one of the
  * `TRANSACTION_*` constants
  */
-int ref_transaction_commit(struct ref_transaction *transaction,
+int repo_ref_transaction_commit(struct repository *r, struct ref_transaction *transaction,
 			   struct strbuf *err);
+static inline int ref_transaction_commit(struct ref_transaction *transaction,
+					 struct strbuf *err)
+{
+	return repo_ref_transaction_commit(the_repository, transaction, err);
+}
 
 /*
  * Abort `transaction`, which has been begun and possibly prepared,
diff --git a/refs/debug.c b/refs/debug.c
index 1a7a9e11cf..224ee76563 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -38,14 +38,15 @@ static int debug_init_db(struct ref_store *refs, struct strbuf *err)
 	return res;
 }
 
-static int debug_transaction_prepare(struct ref_store *refs,
+static int debug_transaction_prepare(struct repository *r,
+				     struct ref_store *refs,
 				     struct ref_transaction *transaction,
 				     struct strbuf *err)
 {
 	struct debug_ref_store *drefs = (struct debug_ref_store *)refs;
 	int res;
 	transaction->ref_store = drefs->refs;
-	res = drefs->refs->be->transaction_prepare(drefs->refs, transaction,
+	res = drefs->refs->be->transaction_prepare(r, drefs->refs, transaction,
 						   err);
 	trace_printf_key(&trace_refs, "transaction_prepare: %d\n", res);
 	return res;
@@ -153,23 +154,24 @@ static int debug_delete_refs(struct ref_store *ref_store, const char *msg,
 	return res;
 }
 
-static int debug_rename_ref(struct ref_store *ref_store, const char *oldref,
+static int debug_rename_ref(struct repository *r,
+			    struct ref_store *ref_store, const char *oldref,
 			    const char *newref, const char *logmsg)
 {
 	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
-	int res = drefs->refs->be->rename_ref(drefs->refs, oldref, newref,
+	int res = drefs->refs->be->rename_ref(r, drefs->refs, oldref, newref,
 					      logmsg);
 	trace_printf_key(&trace_refs, "rename_ref: %s -> %s \"%s\": %d\n", oldref, newref,
 		logmsg, res);
 	return res;
 }
 
-static int debug_copy_ref(struct ref_store *ref_store, const char *oldref,
+static int debug_copy_ref(struct repository *r, struct ref_store *ref_store, const char *oldref,
 			  const char *newref, const char *logmsg)
 {
 	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
 	int res =
-		drefs->refs->be->copy_ref(drefs->refs, oldref, newref, logmsg);
+		drefs->refs->be->copy_ref(r, drefs->refs, oldref, newref, logmsg);
 	trace_printf_key(&trace_refs, "copy_ref: %s -> %s \"%s\": %d\n", oldref, newref,
 		logmsg, res);
 	return res;
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 74c0385873..2bd6115484 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1308,14 +1308,14 @@ static int rename_tmp_log(struct files_ref_store *refs, const char *newrefname)
 	return ret;
 }
 
-static int write_ref_to_lockfile(struct ref_lock *lock,
+static int write_ref_to_lockfile(struct repository *r, struct ref_lock *lock,
 				 const struct object_id *oid, struct strbuf *err);
 static int commit_ref_update(struct files_ref_store *refs,
 			     struct ref_lock *lock,
 			     const struct object_id *oid, const char *logmsg,
 			     struct strbuf *err);
 
-static int files_copy_or_rename_ref(struct ref_store *ref_store,
+static int files_copy_or_rename_ref(struct repository *r, struct ref_store *ref_store,
 			    const char *oldrefname, const char *newrefname,
 			    const char *logmsg, int copy)
 {
@@ -1427,7 +1427,7 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
 	}
 	oidcpy(&lock->old_oid, &orig_oid);
 
-	if (write_ref_to_lockfile(lock, &orig_oid, &err) ||
+	if (write_ref_to_lockfile(r, lock, &orig_oid, &err) ||
 	    commit_ref_update(refs, lock, &orig_oid, logmsg, &err)) {
 		error("unable to write current sha1 into %s: %s", newrefname, err.buf);
 		strbuf_release(&err);
@@ -1448,7 +1448,7 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
 
 	flag = log_all_ref_updates;
 	log_all_ref_updates = LOG_REFS_NONE;
-	if (write_ref_to_lockfile(lock, &orig_oid, &err) ||
+	if (write_ref_to_lockfile(r, lock, &orig_oid, &err) ||
 	    commit_ref_update(refs, lock, &orig_oid, NULL, &err)) {
 		error("unable to write current sha1 into %s: %s", oldrefname, err.buf);
 		strbuf_release(&err);
@@ -1472,19 +1472,19 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
 	return ret;
 }
 
-static int files_rename_ref(struct ref_store *ref_store,
+static int files_rename_ref(struct repository *r, struct ref_store *ref_store,
 			    const char *oldrefname, const char *newrefname,
 			    const char *logmsg)
 {
-	return files_copy_or_rename_ref(ref_store, oldrefname,
+	return files_copy_or_rename_ref(r, ref_store, oldrefname,
 				 newrefname, logmsg, 0);
 }
 
-static int files_copy_ref(struct ref_store *ref_store,
+static int files_copy_ref(struct repository *r, struct ref_store *ref_store,
 			    const char *oldrefname, const char *newrefname,
 			    const char *logmsg)
 {
-	return files_copy_or_rename_ref(ref_store, oldrefname,
+	return files_copy_or_rename_ref(r, ref_store, oldrefname,
 				 newrefname, logmsg, 1);
 }
 
@@ -1683,14 +1683,14 @@ static int files_log_ref_write(struct files_ref_store *refs,
  * Write oid into the open lockfile, then close the lockfile. On
  * errors, rollback the lockfile, fill in *err and return -1.
  */
-static int write_ref_to_lockfile(struct ref_lock *lock,
+static int write_ref_to_lockfile(struct repository *r, struct ref_lock *lock,
 				 const struct object_id *oid, struct strbuf *err)
 {
 	static char term = '\n';
 	struct object *o;
 	int fd;
 
-	o = parse_object(the_repository, oid);
+	o = parse_object(r, oid);
 	if (!o) {
 		strbuf_addf(err,
 			    "trying to write ref '%s' with nonexistent object %s",
@@ -2390,7 +2390,7 @@ static int check_old_oid(struct ref_update *update, struct object_id *oid,
  * - If it is an update of head_ref, add a corresponding REF_LOG_ONLY
  *   update of HEAD.
  */
-static int lock_ref_for_update(struct files_ref_store *refs,
+static int lock_ref_for_update(struct repository *r, struct files_ref_store *refs,
 			       struct ref_update *update,
 			       struct ref_transaction *transaction,
 			       const char *head_ref,
@@ -2496,7 +2496,7 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 			 * The reference already has the desired
 			 * value, so we don't need to write it.
 			 */
-		} else if (write_ref_to_lockfile(lock, &update->new_oid,
+		} else if (write_ref_to_lockfile(r, lock, &update->new_oid,
 						 err)) {
 			char *write_err = strbuf_detach(err, NULL);
 
@@ -2577,7 +2577,7 @@ static void files_transaction_cleanup(struct files_ref_store *refs,
 	transaction->state = REF_TRANSACTION_CLOSED;
 }
 
-static int files_transaction_prepare(struct ref_store *ref_store,
+static int files_transaction_prepare(struct repository *r, struct ref_store *ref_store,
 				     struct ref_transaction *transaction,
 				     struct strbuf *err)
 {
@@ -2667,7 +2667,7 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 	for (i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = transaction->updates[i];
 
-		ret = lock_ref_for_update(refs, update, transaction,
+		ret = lock_ref_for_update(r, refs, update, transaction,
 					  head_ref, &affected_refnames, err);
 		if (ret)
 			goto cleanup;
@@ -2708,7 +2708,7 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 
 		if (is_packed_transaction_needed(refs->packed_ref_store,
 						 packed_transaction)) {
-			ret = ref_transaction_prepare(packed_transaction, err);
+			ret = repo_ref_transaction_prepare(r, packed_transaction, err);
 			/*
 			 * A failure during the prepare step will abort
 			 * itself, but not free. Do that now, and disconnect
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index f8aa97d799..e6aa1841ba 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1403,7 +1403,8 @@ static void packed_transaction_cleanup(struct packed_ref_store *refs,
 	transaction->state = REF_TRANSACTION_CLOSED;
 }
 
-static int packed_transaction_prepare(struct ref_store *ref_store,
+static int packed_transaction_prepare(struct repository *r,
+				      struct ref_store *ref_store,
 				      struct ref_transaction *transaction,
 				      struct strbuf *err)
 {
@@ -1577,14 +1578,14 @@ static int packed_create_symref(struct ref_store *ref_store,
 	BUG("packed reference store does not support symrefs");
 }
 
-static int packed_rename_ref(struct ref_store *ref_store,
+static int packed_rename_ref(struct repository *r, struct ref_store *ref_store,
 			    const char *oldrefname, const char *newrefname,
 			    const char *logmsg)
 {
 	BUG("packed reference store does not support renaming references");
 }
 
-static int packed_copy_ref(struct ref_store *ref_store,
+static int packed_copy_ref(struct repository *r, struct ref_store *ref_store,
 			   const char *oldrefname, const char *newrefname,
 			   const char *logmsg)
 {
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 3155708345..1b7a68db8c 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -530,7 +530,8 @@ typedef struct ref_store *ref_store_init_fn(const char *gitdir,
 
 typedef int ref_init_db_fn(struct ref_store *refs, struct strbuf *err);
 
-typedef int ref_transaction_prepare_fn(struct ref_store *refs,
+typedef int ref_transaction_prepare_fn(struct repository *r,
+				       struct ref_store *refs,
 				       struct ref_transaction *transaction,
 				       struct strbuf *err);
 
@@ -553,10 +554,10 @@ typedef int create_symref_fn(struct ref_store *ref_store,
 			     const char *logmsg);
 typedef int delete_refs_fn(struct ref_store *ref_store, const char *msg,
 			   struct string_list *refnames, unsigned int flags);
-typedef int rename_ref_fn(struct ref_store *ref_store,
+typedef int rename_ref_fn(struct repository *r, struct ref_store *ref_store,
 			  const char *oldref, const char *newref,
 			  const char *logmsg);
-typedef int copy_ref_fn(struct ref_store *ref_store,
+typedef int copy_ref_fn(struct repository *r, struct ref_store *ref_store,
 			  const char *oldref, const char *newref,
 			  const char *logmsg);
 
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index b314b81a45..ad47488e5b 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -99,7 +99,7 @@ static int cmd_rename_ref(struct ref_store *refs, const char **argv)
 	const char *newref = notnull(*argv++, "newref");
 	const char *logmsg = *argv++;
 
-	return refs_rename_ref(refs, oldref, newref, logmsg);
+	return refs_rename_ref(the_repository, refs, oldref, newref, logmsg);
 }
 
 static int each_ref(const char *refname, const struct object_id *oid,
-- 
2.33.0.464.g1972c5931b-goog

