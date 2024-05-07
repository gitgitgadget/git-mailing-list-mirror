Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F217173C
	for <git@vger.kernel.org>; Tue,  7 May 2024 06:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715061652; cv=none; b=M7u18wZ7MQY6dW6mAkiHCrOyNvO6Vvc9o38o25wR9kAaEScCeQhAFnZtnnXsbIz77ckbeTTKS9/tr+7YVIWK4tAI75uMswFKE/3XL3yQ1gckcAx0ut9zWuD1eW+0F6JkPXGGxXCyNV7GEEAX9RnZmKNJkh6n4wDOpGYFTh4FbMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715061652; c=relaxed/simple;
	bh=7cJsSwyMkKuXm1xzPHJYuZTWvnNfnS1CSRaFMBaIqWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FRjl9DJLESdsKW3NK8WjjK7Li6jz1u0jnk9U/Az4T0esh93iPCoZOMSXFLwV64LbOuULgl5qOtWPO+QYkhtuXPl3+tkQUqTKUSUbWAGBgFXEP0z5vv1v/U2wCsMHjYTtgBEAZkj7HTFEZJE+44gx9bVzVh58nZORR1pwp0E1eZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jKG/9aNP; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKG/9aNP"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a59b49162aeso544870266b.3
        for <git@vger.kernel.org>; Mon, 06 May 2024 23:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715061649; x=1715666449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aLFqoNvj9+ALOinCqHFXtGzqODaIuuOrMT33qZrfTDw=;
        b=jKG/9aNPck5bbuQ+YMRC1FJiYCAyQp922tJY+yHxhHfppY5jMhrTSWomhh5GIg3WcD
         +OMbPgwzhVz/IumJpsJy5Kt9GTJUPslaxVrBHLFUJXELT3kvonegU+c3AjmodltfQ++j
         jNyg+a9O1EeYtr8WGseMZxk/Jf4/m/iZcCD57Vfu4Umc4pT1sGSw5X8iWq4lpbr7sL14
         ak3qqHgAWXaLhgnkbd+SRHeSssdQ2fLHUyzb/9ytiZPCBM9OY/IgbmPLTdP7WxVbAgmO
         2DWqUCgt8vsaxA/3tTv1PEivV5KRpqJ6gAq/xOeYgsm+fxsMPOjNvpO6XDhQ32peHj9F
         NAnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715061649; x=1715666449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aLFqoNvj9+ALOinCqHFXtGzqODaIuuOrMT33qZrfTDw=;
        b=txYaN70Iy4xyqXCfeYRWfEgT3Y37kJCJl5F37+3r/DH84qigRaG/E/cMT+kjjXn/50
         ad9NIRCc4VH0yZnvl7wpbbTJEQDD/BcUJjrk0TOaFcQi1w+Or4oU9mGP3UuQST1ykvJO
         g28H/xrNFfuTXWC3bsMYtNA39i8kVPcfoCMAoBYzNmgSlJWglHZ6KrK9h9Pnx4MTx65/
         a6Bx3prk5hvosT9rgJ89ym0V029vzU545gZwfAau1AfuxezendYG3Qn6BXXtMdCn4BKp
         GVormpAKQ+sLcpfFR0U5Dl835OXCMWSQUtAY8QkZbM+nyMbbQBGSvV0gpwVmIHevLfGZ
         B6sw==
X-Forwarded-Encrypted: i=1; AJvYcCWg70dDnZOexj4IYHCv2BDA6atxXP3t1Znofa650kDnAE5xKgElxwmo2BDUiEbX3bHuq5TQVv3K8M4vewroMiMzwZAO
X-Gm-Message-State: AOJu0YxADQXR05moWg9Ix04od0rsmKxD7Z5frhhu6lnmdLDIxH8v0ztV
	+Lh5gR4ZLT5S418+MjA+rhbKIQwkbNcBSgtU2SdGttbymx1QkIWo
X-Google-Smtp-Source: AGHT+IGd9nqIjTQegPCpy4TQFj0ksuZtSjTR6KK0iyWYjiSv8kWK2VDUzBOXAe9GxEF57ramuyChKw==
X-Received: by 2002:a17:907:7e8c:b0:a59:ad15:6133 with SMTP id qb12-20020a1709077e8c00b00a59ad156133mr5646021ejc.71.1715061648857;
        Mon, 06 May 2024 23:00:48 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:1aa1:adf2:4cd1:ebdc])
        by smtp.gmail.com with ESMTPSA id y27-20020a1709060a9b00b00a59baca79basm3066691ejf.60.2024.05.06.23.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 23:00:48 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: christian.couder@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im,
	phillip.wood123@gmail.com
Subject: [PATCH v7 5/8] refs: add support for transactional symref updates
Date: Tue,  7 May 2024 08:00:32 +0200
Message-ID: <20240507060035.28602-6-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240507060035.28602-1-knayak@gitlab.com>
References: <20240503124115.252413-1-knayak@gitlab.com>
 <20240507060035.28602-1-knayak@gitlab.com>
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
index d65e4cc41e..f3d6b3b8e3 100644
--- a/refs.c
+++ b/refs.c
@@ -1257,6 +1257,8 @@ void ref_transaction_free(struct ref_transaction *transaction)
 
 	for (i = 0; i < transaction->nr; i++) {
 		free(transaction->updates[i]->msg);
+		free((char *)transaction->updates[i]->new_target);
+		free((char *)transaction->updates[i]->old_target);
 		free(transaction->updates[i]);
 	}
 	free(transaction->updates);
@@ -1287,10 +1289,13 @@ struct ref_update *ref_transaction_add_update(
 
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
@@ -1333,6 +1338,7 @@ int ref_transaction_update(struct ref_transaction *transaction,
 	flags &= REF_TRANSACTION_UPDATE_ALLOWED_FLAGS;
 
 	flags |= (new_oid ? REF_HAVE_NEW : 0) | (old_oid ? REF_HAVE_OLD : 0);
+	flags |= (new_target ? REF_HAVE_NEW : 0) | (old_target ? REF_HAVE_OLD : 0);
 
 	ref_transaction_add_update(transaction, refname, flags,
 				   new_oid, old_oid, new_target,
@@ -2839,3 +2845,29 @@ const char *ref_update_original_update_refname(struct ref_update *update)
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
index 64d2a50e97..1d4650b7cb 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2393,8 +2393,9 @@ static int split_symref_update(struct ref_update *update,
 
 	new_update = ref_transaction_add_update(
 			transaction, referent, new_flags,
-			&update->new_oid, &update->old_oid,
-			NULL, NULL, update->msg);
+			update->new_target ? NULL : &update->new_oid,
+			update->old_target ? NULL : &update->old_oid,
+			update->new_target, update->old_target, update->msg);
 
 	new_update->parent_update = update;
 
@@ -2482,7 +2483,7 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 
 	files_assert_main_repository(refs, "lock_ref_for_update");
 
-	if ((update->flags & REF_HAVE_NEW) && is_null_oid(&update->new_oid))
+	if ((update->flags & REF_HAVE_NEW) && ref_update_has_null_new_value(update))
 		update->flags |= REF_DELETING;
 
 	if (head_ref) {
@@ -2525,7 +2526,14 @@ static int lock_ref_for_update(struct files_ref_store *refs,
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
@@ -2546,7 +2554,17 @@ static int lock_ref_for_update(struct files_ref_store *refs,
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
@@ -2564,9 +2582,28 @@ static int lock_ref_for_update(struct files_ref_store *refs,
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
@@ -2829,6 +2866,43 @@ static int files_transaction_prepare(struct ref_store *ref_store,
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
@@ -2859,23 +2933,20 @@ static int files_transaction_finish(struct ref_store *ref_store,
 
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
index 0988f59ed4..4817dc2f0b 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -887,7 +887,7 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 			 * There is no need to write the reference deletion
 			 * when the reference in question doesn't exist.
 			 */
-			 if (u->flags & REF_HAVE_NEW && !is_null_oid(&u->new_oid)) {
+			 if ((u->flags & REF_HAVE_NEW) && !ref_update_has_null_new_value(u)) {
 				 ret = queue_transaction_update(refs, tx_data, u,
 								&current_oid, err);
 				 if (ret)
@@ -938,8 +938,10 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
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
@@ -969,7 +971,12 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
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
@@ -1080,7 +1087,9 @@ static int write_transaction_table(struct reftable_writer *writer, void *cb_data
 		 * - `core.logAllRefUpdates` tells us to create the reflog for
 		 *   the given ref.
 		 */
-		if (u->flags & REF_HAVE_NEW && !(u->type & REF_ISSYMREF) && is_null_oid(&u->new_oid)) {
+		if ((u->flags & REF_HAVE_NEW) &&
+		    !(u->type & REF_ISSYMREF) &&
+		    ref_update_has_null_new_value(u)) {
 			struct reftable_log_record log = {0};
 			struct reftable_iterator it = {0};
 
@@ -1121,24 +1130,52 @@ static int write_transaction_table(struct reftable_writer *writer, void *cb_data
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
-			fill_reftable_log_record(log, &committer_ident);
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
+				fill_reftable_log_record(log, &committer_ident);
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

