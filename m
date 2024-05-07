Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1581615ECFA
	for <git@vger.kernel.org>; Tue,  7 May 2024 12:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715086757; cv=none; b=GLHoLaIERTRNuZ2v+N2KCzEJb44/yJjEDSHBKv2drtLnp9sTtUJYmYDahYN8ty4CwrJGHxyQfNnWTZIAe8PX2nHcWI6bt0CbocGAwKQIC4ESxzXrdUnCVcZvJ5uCQDYJHGwgQ+L6cniIEikEpCvsX1ww+D1ePFh5y8Ud7PFzTRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715086757; c=relaxed/simple;
	bh=SiAL/nCPudkaGvEhRXnkoZiDRE3nIEuRpWYAeOwF8Zg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WuU84eliu72C6bPHreTFc65QTvbXEWJ6fBDrFWu032yJYTgAkkQ68Iu1S5xQl4BP9mWe6v8ijgggK2k1/e00Fk9zNbQiEDkpmep4z+Radwgje6X8Dc/n19CGnFq1BS/ug+ZltGRcn0uL8WP+GyZzUl0znzWgQmFmESdFBfTYQ8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VFGcpRUj; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFGcpRUj"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-34da35cd01cso2844052f8f.2
        for <git@vger.kernel.org>; Tue, 07 May 2024 05:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715086753; x=1715691553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o1mAY+aiTrVLKnlG/J/aXReOEzVfDWvYMZ3tGDjenTE=;
        b=VFGcpRUjyMQFtB5jlyObt/hC9tFwklxsxC1Zicyx6aSCkmXTcXZOCHEZGln4JoBt3U
         FjDv0WGt99EEUJAYDFYlVqWNVoPBk8zr8eLaMA7RFpxg5MlrTT+JOashPGv8rLpAYDaC
         5qv/r4XRF3YkPyPdtP7bWI5FG1sJZ99egGHGCUSfn4kyzR/jUUgOp4CPc3FDufkj1fgh
         TrcWoVxfCV6JA5L5/LRnlccrX/0lpNGGV0o5Zx7YPx0X8zu9HyRp0Q4fODF/2G0pPxiF
         +l7kGVTSUWjI+mhLNFYuqXOxWOa+UsHDQHZi6yo4OzqCY5JXRVcm24tue6SXvOvtLWNW
         xyqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715086753; x=1715691553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o1mAY+aiTrVLKnlG/J/aXReOEzVfDWvYMZ3tGDjenTE=;
        b=JC6uydPZOfL6W2pnGtZVniVTI8VVAzmJt5cJS2Z8w3omYQ0wssuL4C151/dk4zJ4tK
         blzr7zukvBfYsrpvR/yG2VX5jxnZVDl4W1prMu9k2Rfq8U42SbEZkE8IvRNWQXZ94PFW
         2OqaSJTsb20rGUxrpvZlBFwjfXKcP278Q3HmcmkCPzMBCd3VfQyx4w/dDGQ5+EZzYZE1
         AiHrvRHWjxAcQG4LT5v26j640Yn2N/9gUfS3VqGIfltlggvFKpL5AVO99uzralXflYMx
         GSquO6rVanb8kv9OqzQg1jQ3LdlRaAd0U2dIDGhUR0QAItTnefqks1fM0BnVawQrgITs
         k3lg==
X-Gm-Message-State: AOJu0Yz+7202bN+1gMq/kXrvpQkZA25eU5j5aEseaSeFvq3GAf2+aWpf
	uMmUa6VIMOIkFjPpjqoZ6y4tTGZVuva5KHb5Lo/L8sbV1KASqpEz
X-Google-Smtp-Source: AGHT+IHWzjo7Hgy+5nozImvKxZNkCyv+pp+BxK8OI54DBfm2hWhnL0WKtNJ3aKSDsJ06Fs7DE9PDYg==
X-Received: by 2002:a5d:530d:0:b0:34c:e62a:db70 with SMTP id e13-20020a5d530d000000b0034ce62adb70mr10988447wrv.67.1715086753241;
        Tue, 07 May 2024 05:59:13 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:e6d6:a83d:4d4b:8baa])
        by smtp.gmail.com with ESMTPSA id q5-20020adff945000000b0034f5925edacsm3507566wrr.30.2024.05.07.05.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 05:59:12 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im,
	phillip.wood123@gmail.com
Subject: [PATCH v8 5/8] refs: add support for transactional symref updates
Date: Tue,  7 May 2024 14:58:56 +0200
Message-ID: <20240507125859.132116-6-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240507125859.132116-1-knayak@gitlab.com>
References: <20240507060035.28602-1-knayak@gitlab.com>
 <20240507125859.132116-1-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karthik Nayak <karthik.188@gmail.com>

The reference backends currently support transactional reference
updates. While this is exposed to users via 'git-update-ref' and its
'--stdin' mode, it is also used internally within various commands.

However, we do not support transactional updates of symrefs. This commit
adds support for symrefs in both the 'files' and the 'reftable' backend.

Here, we add and use `ref_update_has_null_new_value()`, a helper
function which is used to check if there is a new_value in a reference
update. The new value could either be a symref target `new_target` or a
OID `new_oid`.

We also add another common function `ref_update_check_old_target` which
will be used to check if the update's old_target corresponds to a
reference's current target.

Now transactional updates (verify, create, delete, update) can be used
for:
- regular refs
- symbolic refs
- conversion of regular to symbolic refs and vice versa

This also allows us to expose this to users via new commands in
'git-update-ref' in the future.

Note that a dangling symref update does not record a new reflog entry,
which is unchanged before and after this commit.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c                  |  36 ++++++++++++-
 refs/files-backend.c    | 113 ++++++++++++++++++++++++++++++++--------
 refs/refs-internal.h    |  16 ++++++
 refs/reftable-backend.c |  71 +++++++++++++++++++------
 4 files changed, 196 insertions(+), 40 deletions(-)

diff --git a/refs.c b/refs.c
index 8de43dc0fc..d0ea7573d8 100644
--- a/refs.c
+++ b/refs.c
@@ -1217,6 +1217,8 @@ void ref_transaction_free(struct ref_transaction *transaction)
 
 	for (i = 0; i < transaction->nr; i++) {
 		free(transaction->updates[i]->msg);
+		free((char *)transaction->updates[i]->new_target);
+		free((char *)transaction->updates[i]->old_target);
 		free(transaction->updates[i]);
 	}
 	free(transaction->updates);
@@ -1247,10 +1249,13 @@ struct ref_update *ref_transaction_add_update(
 
 	update->flags = flags;
 
-	if (flags & REF_HAVE_NEW)
+	update->new_target = xstrdup_or_null(new_target);
+	update->old_target = xstrdup_or_null(old_target);
+	if ((flags & REF_HAVE_NEW) && new_oid)
 		oidcpy(&update->new_oid, new_oid);
-	if (flags & REF_HAVE_OLD)
+	if ((flags & REF_HAVE_OLD) && old_oid)
 		oidcpy(&update->old_oid, old_oid);
+
 	update->msg = normalize_reflog_message(msg);
 	return update;
 }
@@ -1286,6 +1291,7 @@ int ref_transaction_update(struct ref_transaction *transaction,
 	flags &= REF_TRANSACTION_UPDATE_ALLOWED_FLAGS;
 
 	flags |= (new_oid ? REF_HAVE_NEW : 0) | (old_oid ? REF_HAVE_OLD : 0);
+	flags |= (new_target ? REF_HAVE_NEW : 0) | (old_target ? REF_HAVE_OLD : 0);
 
 	ref_transaction_add_update(transaction, refname, flags,
 				   new_oid, old_oid, new_target,
@@ -2823,3 +2829,29 @@ const char *ref_update_original_update_refname(struct ref_update *update)
 	return update->refname;
 }
 
+int ref_update_has_null_new_value(struct ref_update *update)
+{
+	return !update->new_target && is_null_oid(&update->new_oid);
+}
+
+int ref_update_check_old_target(const char *referent, struct ref_update *update,
+				struct strbuf *err)
+{
+	if (!update->old_target)
+		BUG("called without old_target set");
+
+	if (!strcmp(referent, update->old_target))
+		return 0;
+
+	if (!strcmp(referent, ""))
+		strbuf_addf(err, "verifying symref target: '%s': "
+			    "reference is missing but expected %s",
+			    ref_update_original_update_refname(update),
+			    update->old_target);
+	else
+		strbuf_addf(err, "verifying symref target: '%s': "
+			    "is at %s but expected %s",
+			    ref_update_original_update_refname(update),
+			    referent, update->old_target);
+	return -1;
+}
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 25e5d03496..2d1525b240 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2394,8 +2394,9 @@ static int split_symref_update(struct ref_update *update,
 
 	new_update = ref_transaction_add_update(
 			transaction, referent, new_flags,
-			&update->new_oid, &update->old_oid,
-			NULL, NULL, update->msg);
+			update->new_target ? NULL : &update->new_oid,
+			update->old_target ? NULL : &update->old_oid,
+			update->new_target, update->old_target, update->msg);
 
 	new_update->parent_update = update;
 
@@ -2483,7 +2484,7 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 
 	files_assert_main_repository(refs, "lock_ref_for_update");
 
-	if ((update->flags & REF_HAVE_NEW) && is_null_oid(&update->new_oid))
+	if ((update->flags & REF_HAVE_NEW) && ref_update_has_null_new_value(update))
 		update->flags |= REF_DELETING;
 
 	if (head_ref) {
@@ -2526,7 +2527,14 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 					ret = TRANSACTION_GENERIC_ERROR;
 					goto out;
 				}
-			} else if (check_old_oid(update, &lock->old_oid, err)) {
+			}
+
+			if (update->old_target) {
+				if (ref_update_check_old_target(referent.buf, update, err)) {
+					ret = TRANSACTION_GENERIC_ERROR;
+					goto out;
+				}
+			} else if  (check_old_oid(update, &lock->old_oid, err)) {
 				ret = TRANSACTION_GENERIC_ERROR;
 				goto out;
 			}
@@ -2547,7 +2555,17 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 	} else {
 		struct ref_update *parent_update;
 
-		if (check_old_oid(update, &lock->old_oid, err)) {
+		/*
+		 * Even if the ref is a regular ref, if `old_target` is set, we
+		 * check the referent value. Ideally `old_target` should only
+		 * be set for symrefs, but we're strict about its usage.
+		 */
+		if (update->old_target) {
+			if (ref_update_check_old_target(referent.buf, update, err)) {
+				ret = TRANSACTION_GENERIC_ERROR;
+				goto out;
+			}
+		} else if  (check_old_oid(update, &lock->old_oid, err)) {
 			ret = TRANSACTION_GENERIC_ERROR;
 			goto out;
 		}
@@ -2565,9 +2583,28 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 		}
 	}
 
-	if ((update->flags & REF_HAVE_NEW) &&
-	    !(update->flags & REF_DELETING) &&
-	    !(update->flags & REF_LOG_ONLY)) {
+	if (update->new_target && !(update->flags & REF_LOG_ONLY)) {
+		if (create_symref_lock(refs, lock, update->refname,
+				       update->new_target, err)) {
+			ret = TRANSACTION_GENERIC_ERROR;
+			goto out;
+		}
+
+		if (close_ref_gently(lock)) {
+			strbuf_addf(err, "couldn't close '%s.lock'",
+				    update->refname);
+			ret = TRANSACTION_GENERIC_ERROR;
+			goto out;
+		}
+
+		/*
+		 * Once we have created the symref lock, the commit
+		 * phase of the transaction only needs to commit the lock.
+		 */
+		update->flags |= REF_NEEDS_COMMIT;
+	} else if ((update->flags & REF_HAVE_NEW) &&
+		   !(update->flags & REF_DELETING) &&
+		   !(update->flags & REF_LOG_ONLY)) {
 		if (!(update->type & REF_ISSYMREF) &&
 		    oideq(&lock->old_oid, &update->new_oid)) {
 			/*
@@ -2830,6 +2867,43 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 	return ret;
 }
 
+static int parse_and_write_reflog(struct files_ref_store *refs,
+				  struct ref_update *update,
+				  struct ref_lock *lock,
+				  struct strbuf *err)
+{
+	if (update->new_target) {
+		/*
+		 * We want to get the resolved OID for the target, to ensure
+		 * that the correct value is added to the reflog.
+		 */
+		if (!refs_resolve_ref_unsafe(&refs->base, update->new_target,
+					     RESOLVE_REF_READING,
+					     &update->new_oid, NULL)) {
+			/*
+			 * TODO: currently we skip creating reflogs for dangling
+			 * symref updates. It would be nice to capture this as
+			 * zero oid updates however.
+			 */
+			return 0;
+		}
+	}
+
+	if (files_log_ref_write(refs, lock->ref_name, &lock->old_oid,
+				&update->new_oid, update->msg, update->flags, err)) {
+		char *old_msg = strbuf_detach(err, NULL);
+
+		strbuf_addf(err, "cannot update the ref '%s': %s",
+			    lock->ref_name, old_msg);
+		free(old_msg);
+		unlock_ref(lock);
+		update->backend_data = NULL;
+		return -1;
+	}
+
+	return 0;
+}
+
 static int files_transaction_finish(struct ref_store *ref_store,
 				    struct ref_transaction *transaction,
 				    struct strbuf *err)
@@ -2860,23 +2934,20 @@ static int files_transaction_finish(struct ref_store *ref_store,
 
 		if (update->flags & REF_NEEDS_COMMIT ||
 		    update->flags & REF_LOG_ONLY) {
-			if (files_log_ref_write(refs,
-						lock->ref_name,
-						&lock->old_oid,
-						&update->new_oid,
-						update->msg, update->flags,
-						err)) {
-				char *old_msg = strbuf_detach(err, NULL);
-
-				strbuf_addf(err, "cannot update the ref '%s': %s",
-					    lock->ref_name, old_msg);
-				free(old_msg);
-				unlock_ref(lock);
-				update->backend_data = NULL;
+			if (parse_and_write_reflog(refs, update, lock, err)) {
 				ret = TRANSACTION_GENERIC_ERROR;
 				goto cleanup;
 			}
 		}
+
+		/*
+		 * We try creating a symlink, if that succeeds we continue to the
+		 * next update. If not, we try and create a regular symref.
+		 */
+		if (update->new_target && prefer_symlink_refs)
+			if (!create_ref_symlink(lock, update->new_target))
+				continue;
+
 		if (update->flags & REF_NEEDS_COMMIT) {
 			clear_loose_ref_cache(refs);
 			if (commit_ref(lock)) {
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 617b93a6c8..819157256e 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -754,4 +754,20 @@ struct ref_store *maybe_debug_wrap_ref_store(const char *gitdir, struct ref_stor
  */
 const char *ref_update_original_update_refname(struct ref_update *update);
 
+/*
+ * Helper function to check if the new value is null, this
+ * takes into consideration that the update could be a regular
+ * ref or a symbolic ref.
+ */
+int ref_update_has_null_new_value(struct ref_update *update);
+
+/*
+ * Check whether the old_target values stored in update are consistent
+ * with the referent, which is the symbolic reference's current value.
+ * If everything is OK, return 0; otherwise, write an error message to
+ * err and return -1.
+ */
+int ref_update_check_old_target(const char *referent, struct ref_update *update,
+				struct strbuf *err);
+
 #endif /* REFS_REFS_INTERNAL_H */
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 8bba5d5096..3eab57cf95 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -846,7 +846,7 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 			 * There is no need to write the reference deletion
 			 * when the reference in question doesn't exist.
 			 */
-			 if (u->flags & REF_HAVE_NEW && !is_null_oid(&u->new_oid)) {
+			 if ((u->flags & REF_HAVE_NEW) && !ref_update_has_null_new_value(u)) {
 				 ret = queue_transaction_update(refs, tx_data, u,
 								&current_oid, err);
 				 if (ret)
@@ -897,8 +897,10 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 				 * intertwined with the locking in files-backend.c.
 				 */
 				new_update = ref_transaction_add_update(
-						transaction, referent.buf, new_flags,
-						&u->new_oid, &u->old_oid, NULL, NULL, u->msg);
+					transaction, referent.buf, new_flags,
+					&u->new_oid, &u->old_oid, u->new_target,
+					u->old_target, u->msg);
+
 				new_update->parent_update = u;
 
 				/*
@@ -928,7 +930,12 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 		 * individual refs. But the error messages match what the files
 		 * backend returns, which keeps our tests happy.
 		 */
-		if (u->flags & REF_HAVE_OLD && !oideq(&current_oid, &u->old_oid)) {
+		if (u->old_target) {
+			if (ref_update_check_old_target(referent.buf, u, err)) {
+				ret = -1;
+				goto done;
+			}
+		} else if ((u->flags & REF_HAVE_OLD) && !oideq(&current_oid, &u->old_oid)) {
 			if (is_null_oid(&u->old_oid))
 				strbuf_addf(err, _("cannot lock ref '%s': "
 						   "reference already exists"),
@@ -1033,7 +1040,9 @@ static int write_transaction_table(struct reftable_writer *writer, void *cb_data
 		 * - `core.logAllRefUpdates` tells us to create the reflog for
 		 *   the given ref.
 		 */
-		if (u->flags & REF_HAVE_NEW && !(u->type & REF_ISSYMREF) && is_null_oid(&u->new_oid)) {
+		if ((u->flags & REF_HAVE_NEW) &&
+		    !(u->type & REF_ISSYMREF) &&
+		    ref_update_has_null_new_value(u)) {
 			struct reftable_log_record log = {0};
 			struct reftable_iterator it = {0};
 
@@ -1074,24 +1083,52 @@ static int write_transaction_table(struct reftable_writer *writer, void *cb_data
 			   (u->flags & REF_FORCE_CREATE_REFLOG ||
 			    should_write_log(&arg->refs->base, u->refname))) {
 			struct reftable_log_record *log;
+			int create_reflog = 1;
+
+			if (u->new_target) {
+				if (!refs_resolve_ref_unsafe(&arg->refs->base, u->new_target,
+							     RESOLVE_REF_READING, &u->new_oid, NULL)) {
+					/*
+					 * TODO: currently we skip creating reflogs for dangling
+					 * symref updates. It would be nice to capture this as
+					 * zero oid updates however.
+					 */
+					create_reflog = 0;
+				}
+			}
 
-			ALLOC_GROW(logs, logs_nr + 1, logs_alloc);
-			log = &logs[logs_nr++];
-			memset(log, 0, sizeof(*log));
-
-			fill_reftable_log_record(log);
-			log->update_index = ts;
-			log->refname = xstrdup(u->refname);
-			memcpy(log->value.update.new_hash, u->new_oid.hash, GIT_MAX_RAWSZ);
-			memcpy(log->value.update.old_hash, tx_update->current_oid.hash, GIT_MAX_RAWSZ);
-			log->value.update.message =
-				xstrndup(u->msg, arg->refs->write_options.block_size / 2);
+			if (create_reflog) {
+				ALLOC_GROW(logs, logs_nr + 1, logs_alloc);
+				log = &logs[logs_nr++];
+				memset(log, 0, sizeof(*log));
+
+				fill_reftable_log_record(log);
+				log->update_index = ts;
+				log->refname = xstrdup(u->refname);
+				memcpy(log->value.update.new_hash,
+				       u->new_oid.hash, GIT_MAX_RAWSZ);
+				memcpy(log->value.update.old_hash,
+				       tx_update->current_oid.hash, GIT_MAX_RAWSZ);
+				log->value.update.message =
+					xstrndup(u->msg, arg->refs->write_options.block_size / 2);
+			}
 		}
 
 		if (u->flags & REF_LOG_ONLY)
 			continue;
 
-		if (u->flags & REF_HAVE_NEW && is_null_oid(&u->new_oid)) {
+		if (u->new_target) {
+			struct reftable_ref_record ref = {
+				.refname = (char *)u->refname,
+				.value_type = REFTABLE_REF_SYMREF,
+				.value.symref = (char *)u->new_target,
+				.update_index = ts,
+			};
+
+			ret = reftable_writer_add_ref(writer, &ref);
+			if (ret < 0)
+				goto done;
+		} else if ((u->flags & REF_HAVE_NEW) && ref_update_has_null_new_value(u)) {
 			struct reftable_ref_record ref = {
 				.refname = (char *)u->refname,
 				.update_index = ts,
-- 
2.43.GIT

