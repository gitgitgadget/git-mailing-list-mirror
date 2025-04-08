Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40AE264A8B
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 08:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744102293; cv=none; b=rKN7Jc1Sf1LtE8RVfCHfwgTf/Jd7hecla3wdZ37WXc3O4W5pHTChaWvEQ2JW8lwe1q+MieqbHWqD7KdkvKx6n0HH8BAtyPnqSxFLSMFMmvl6GyIqLthC6AQS1IvmPmiYwggfwS4XHgXEwGoxu4dFh1e+C3PrGPmSwLTFoBmCzYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744102293; c=relaxed/simple;
	bh=zPORovDfu2Q+t+woWjyTH0vcj4xQp8a5+ev8R4FbZNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hS712/SqKzwOGQwxQDNNwH4x4RyBk7o1HG0Vu7mUVB0vt4QzT1wPxMnu4w9qG8/Glr8JbV2t2wDDYgZff+dUbUjeWwYhATrL+mKQNgpyHKaees2ojnsJQOG7WNoxKsh/D9o3JX82PX6dfGVdY+t9L8v4R2e/ZNmk6EvF3cOS4dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ISDleBiL; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISDleBiL"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac339f53df9so924968366b.1
        for <git@vger.kernel.org>; Tue, 08 Apr 2025 01:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744102289; x=1744707089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aOX7frLCw5p3I1eGlhr6JFOzFxkbK48s8a9TN5yIP4E=;
        b=ISDleBiLNh7cUfJYuNaWcg9zdbsjM6zOl6LwBmv+xg+KWmeqzjDC98/ie4tAtHmPN7
         k0+vvh8LZ+P8CDYB1qiJ/tYevInaUrTuBouaDWVHBF1/b7snQx4jNzhiy+ipOJdHxERU
         PMTcZzEZfPXB6VO31GOOTsCiIq7ub8AE1vYcNFQB+8rs2MRBhOv/qhME05IRq+hndEhb
         8njld6+MWCp4ddRoTE2lHaIbbZ0L/ETGePsjH9/Me847dOaXpSVRcwCu2+CM0eBTkyRX
         kvxYdo4sbuGXowT78K7aOoJuENmFbYzdIVEqkhXt60uDKWq0GetAekpTsJ/0h6SORYSP
         KYog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744102289; x=1744707089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aOX7frLCw5p3I1eGlhr6JFOzFxkbK48s8a9TN5yIP4E=;
        b=vX9mbxpZDGnoBZOkfMBQIBNrNvHjqKKPklYB9Oy/Z+pNCpv60JaT1+s3ubrT2Rlscp
         8JZaGIhfPZ5+gC9IfraB+jvzF3dP/aHr0R9UQJHc2bOOlU1qm4jUX9+q5xicwkERZArT
         7N8E3SnjF55OlWjgRHAqTmPNLk48XprDb8jD6f2BZy++bJ5H8iYTDxe4nbeZkSbpJ7yr
         SnBaL7yfmzMIO6F0svepTl6F7MwklBk5RJW5KdxAKdomMY/uaS6vt5IBIcZ16TKNsinv
         DPrX5RSop3ZwK35m2qcqAOPwYUacPxTdxwd2XDjbt1o/2mqLPkNpwnIA5P//yiS6ch6A
         d0TQ==
X-Gm-Message-State: AOJu0Yw1QHuXLUQ/DX8FQG/7JL5usA6GhRkrOxXJAN2optTHrqx5DBoi
	P+bG1I1QCWCV/jNpPGCvwnWSOcLAc90do1k9aw42MjL/Ho9zJGF5lplmRTVJ
X-Gm-Gg: ASbGncscTuYpHEFutPGGXh9Vl+/8Mkru8WzEvPxtIE1wqY5+sZr5BmBTZ3xaDFWuwJO
	++uYPrAHP3FU06OgDwLJwShVGICDgvv242dDM2PXdCY0nHn2doE/PpbrKVU+LOnc/yrEcJMOxSA
	toJNtmp0Lho5wY97O930FRvSOJ9WEdfPcVBxbdof24pXHprKQGZqE6VutRJWpuc5VTFqeootiaM
	8lII01uLmDUq4MfnopqFSi2WGrA/Q4Ndx73qkhPNQ0K+zh2eYC5f9cykddobAXQee+VYs6CRBD6
	6heCxUJzMml8H/XkKlc4tqKBSZ+ts2XF9bCs68R+qlsDRjCkmIvfvcoFeA==
X-Google-Smtp-Source: AGHT+IEgsYFMkT86VjmE3smHqX+o7BxOXK8BM9EOg6/zvayGFID2BkfAv8AK19xIV7m3XiQsfRXpog==
X-Received: by 2002:a17:907:72d4:b0:ac7:b374:58dc with SMTP id a640c23a62f3a-ac7d191578bmr1374675866b.30.1744102288541;
        Tue, 08 Apr 2025 01:51:28 -0700 (PDT)
Received: from localhost.localdomain ([217.110.80.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7bfe5c804sm890801366b.15.2025.04.08.01.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 01:51:28 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	jltobler@gmail.com,
	ps@pks.im,
	jn.avila@free.fr,
	gitster@pobox.com
Subject: [PATCH v6 4/8] refs/reftable: extract code from the transaction preparation
Date: Tue,  8 Apr 2025 10:51:08 +0200
Message-ID: <20250408085120.614893-5-karthik.188@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250408085120.614893-1-karthik.188@gmail.com>
References: <20250207-245-partially-atomic-ref-updates-v1-0-e6a3690ff23a@gmail.com>
 <20250408085120.614893-1-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extract the core logic for preparing individual reference updates from
`reftable_be_transaction_prepare()` into `prepare_single_update()`. This
dedicated function now handles all validation and preparation steps for
each reference update in the transaction, including object ID
verification, HEAD reference handling, and symref processing.

The refactoring consolidates all reference update validation into a
single logical block, which improves code maintainability and
readability. More importantly, this restructuring lays the groundwork
for implementing batched reference update support in the reftable
backend, which will be introduced in a followup commit.

No functional changes are included in this commit - it is purely a code
reorganization to support future enhancements.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs/reftable-backend.c | 463 ++++++++++++++++++++--------------------
 1 file changed, 237 insertions(+), 226 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index a92c9a2f4f..786df11a03 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1069,6 +1069,239 @@ static int queue_transaction_update(struct reftable_ref_store *refs,
 	return 0;
 }
 
+static int prepare_single_update(struct reftable_ref_store *refs,
+				 struct reftable_transaction_data *tx_data,
+				 struct ref_transaction *transaction,
+				 struct reftable_backend *be,
+				 struct ref_update *u,
+				 struct string_list *refnames_to_check,
+				 unsigned int head_type,
+				 struct strbuf *head_referent,
+				 struct strbuf *referent,
+				 struct strbuf *err)
+{
+	struct object_id current_oid = {0};
+	const char *rewritten_ref;
+	int ret = 0;
+
+	/*
+	 * There is no need to reload the respective backends here as
+	 * we have already reloaded them when preparing the transaction
+	 * update. And given that the stacks have been locked there
+	 * shouldn't have been any concurrent modifications of the
+	 * stack.
+	 */
+	ret = backend_for(&be, refs, u->refname, &rewritten_ref, 0);
+	if (ret)
+		return ret;
+
+	/* Verify that the new object ID is valid. */
+	if ((u->flags & REF_HAVE_NEW) && !is_null_oid(&u->new_oid) &&
+	    !(u->flags & REF_SKIP_OID_VERIFICATION) &&
+	    !(u->flags & REF_LOG_ONLY)) {
+		struct object *o = parse_object(refs->base.repo, &u->new_oid);
+		if (!o) {
+			strbuf_addf(err,
+				    _("trying to write ref '%s' with nonexistent object %s"),
+				    u->refname, oid_to_hex(&u->new_oid));
+			return -1;
+		}
+
+		if (o->type != OBJ_COMMIT && is_branch(u->refname)) {
+			strbuf_addf(err, _("trying to write non-commit object %s to branch '%s'"),
+				    oid_to_hex(&u->new_oid), u->refname);
+			return -1;
+		}
+	}
+
+	/*
+	 * When we update the reference that HEAD points to we enqueue
+	 * a second log-only update for HEAD so that its reflog is
+	 * updated accordingly.
+	 */
+	if (head_type == REF_ISSYMREF &&
+	    !(u->flags & REF_LOG_ONLY) &&
+	    !(u->flags & REF_UPDATE_VIA_HEAD) &&
+	    !strcmp(rewritten_ref, head_referent->buf)) {
+		/*
+		 * First make sure that HEAD is not already in the
+		 * transaction. This check is O(lg N) in the transaction
+		 * size, but it happens at most once per transaction.
+		 */
+		if (string_list_has_string(&transaction->refnames, "HEAD")) {
+			/* An entry already existed */
+			strbuf_addf(err,
+				    _("multiple updates for 'HEAD' (including one "
+				      "via its referent '%s') are not allowed"),
+				    u->refname);
+			return TRANSACTION_NAME_CONFLICT;
+		}
+
+		ref_transaction_add_update(
+			transaction, "HEAD",
+			u->flags | REF_LOG_ONLY | REF_NO_DEREF,
+			&u->new_oid, &u->old_oid, NULL, NULL, NULL,
+			u->msg);
+	}
+
+	ret = reftable_backend_read_ref(be, rewritten_ref,
+					&current_oid, referent, &u->type);
+	if (ret < 0)
+		return ret;
+	if (ret > 0 && !ref_update_expects_existing_old_ref(u)) {
+		/*
+		 * The reference does not exist, and we either have no
+		 * old object ID or expect the reference to not exist.
+		 * We can thus skip below safety checks as well as the
+		 * symref splitting. But we do want to verify that
+		 * there is no conflicting reference here so that we
+		 * can output a proper error message instead of failing
+		 * at a later point.
+		 */
+		string_list_append(refnames_to_check, u->refname);
+
+		/*
+		 * There is no need to write the reference deletion
+		 * when the reference in question doesn't exist.
+		 */
+		if ((u->flags & REF_HAVE_NEW) && !ref_update_has_null_new_value(u)) {
+			ret = queue_transaction_update(refs, tx_data, u,
+						       &current_oid, err);
+			if (ret)
+				return ret;
+		}
+
+		return 0;
+	}
+	if (ret > 0) {
+		/* The reference does not exist, but we expected it to. */
+		strbuf_addf(err, _("cannot lock ref '%s': "
+
+
+				   "unable to resolve reference '%s'"),
+			    ref_update_original_update_refname(u), u->refname);
+		return -1;
+	}
+
+	if (u->type & REF_ISSYMREF) {
+		/*
+		 * The reftable stack is locked at this point already,
+		 * so it is safe to call `refs_resolve_ref_unsafe()`
+		 * here without causing races.
+		 */
+		const char *resolved = refs_resolve_ref_unsafe(&refs->base, u->refname, 0,
+							       &current_oid, NULL);
+
+		if (u->flags & REF_NO_DEREF) {
+			if (u->flags & REF_HAVE_OLD && !resolved) {
+				strbuf_addf(err, _("cannot lock ref '%s': "
+						   "error reading reference"), u->refname);
+				return -1;
+			}
+		} else {
+			struct ref_update *new_update;
+			int new_flags;
+
+			new_flags = u->flags;
+			if (!strcmp(rewritten_ref, "HEAD"))
+				new_flags |= REF_UPDATE_VIA_HEAD;
+
+			if (string_list_has_string(&transaction->refnames, referent->buf)) {
+				strbuf_addf(err,
+					    _("multiple updates for '%s' (including one "
+					      "via symref '%s') are not allowed"),
+					    referent->buf, u->refname);
+				return TRANSACTION_NAME_CONFLICT;
+			}
+
+			/*
+			 * If we are updating a symref (eg. HEAD), we should also
+			 * update the branch that the symref points to.
+			 *
+			 * This is generic functionality, and would be better
+			 * done in refs.c, but the current implementation is
+			 * intertwined with the locking in files-backend.c.
+			 */
+			new_update = ref_transaction_add_update(
+				transaction, referent->buf, new_flags,
+				u->new_target ? NULL : &u->new_oid,
+				u->old_target ? NULL : &u->old_oid,
+				u->new_target, u->old_target,
+				u->committer_info, u->msg);
+
+			new_update->parent_update = u;
+
+			/*
+			 * Change the symbolic ref update to log only. Also, it
+			 * doesn't need to check its old OID value, as that will be
+			 * done when new_update is processed.
+			 */
+			u->flags |= REF_LOG_ONLY | REF_NO_DEREF;
+			u->flags &= ~REF_HAVE_OLD;
+		}
+	}
+
+	/*
+	 * Verify that the old object matches our expectations. Note
+	 * that the error messages here do not make a lot of sense in
+	 * the context of the reftable backend as we never lock
+	 * individual refs. But the error messages match what the files
+	 * backend returns, which keeps our tests happy.
+	 */
+	if (u->old_target) {
+		if (!(u->type & REF_ISSYMREF)) {
+			strbuf_addf(err, _("cannot lock ref '%s': "
+					   "expected symref with target '%s': "
+					   "but is a regular ref"),
+				    ref_update_original_update_refname(u),
+				    u->old_target);
+			return -1;
+		}
+
+		if (ref_update_check_old_target(referent->buf, u, err)) {
+			return -1;
+		}
+	} else if ((u->flags & REF_HAVE_OLD) && !oideq(&current_oid, &u->old_oid)) {
+		if (is_null_oid(&u->old_oid)) {
+			strbuf_addf(err, _("cannot lock ref '%s': "
+					   "reference already exists"),
+				    ref_update_original_update_refname(u));
+			return TRANSACTION_CREATE_EXISTS;
+		}
+		else if (is_null_oid(&current_oid))
+			strbuf_addf(err, _("cannot lock ref '%s': "
+					   "reference is missing but expected %s"),
+				    ref_update_original_update_refname(u),
+				    oid_to_hex(&u->old_oid));
+		else
+			strbuf_addf(err, _("cannot lock ref '%s': "
+					   "is at %s but expected %s"),
+				    ref_update_original_update_refname(u),
+				    oid_to_hex(&current_oid),
+				    oid_to_hex(&u->old_oid));
+		return TRANSACTION_NAME_CONFLICT;
+	}
+
+	/*
+	 * If all of the following conditions are true:
+	 *
+	 *   - We're not about to write a symref.
+	 *   - We're not about to write a log-only entry.
+	 *   - Old and new object ID are different.
+	 *
+	 * Then we're essentially doing a no-op update that can be
+	 * skipped. This is not only for the sake of efficiency, but
+	 * also skips writing unneeded reflog entries.
+	 */
+	if ((u->type & REF_ISSYMREF) ||
+	    (u->flags & REF_LOG_ONLY) ||
+	    (u->flags & REF_HAVE_NEW && !oideq(&current_oid, &u->new_oid)))
+		return queue_transaction_update(refs, tx_data, u,
+					       &current_oid, err);
+
+	return 0;
+}
+
 static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 					   struct ref_transaction *transaction,
 					   struct strbuf *err)
@@ -1133,234 +1366,12 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 	ret = 0;
 
 	for (i = 0; i < transaction->nr; i++) {
-		struct ref_update *u = transaction->updates[i];
-		struct object_id current_oid = {0};
-		const char *rewritten_ref;
-
-		/*
-		 * There is no need to reload the respective backends here as
-		 * we have already reloaded them when preparing the transaction
-		 * update. And given that the stacks have been locked there
-		 * shouldn't have been any concurrent modifications of the
-		 * stack.
-		 */
-		ret = backend_for(&be, refs, u->refname, &rewritten_ref, 0);
+		ret = prepare_single_update(refs, tx_data, transaction, be,
+					    transaction->updates[i],
+					    &refnames_to_check, head_type,
+					    &head_referent, &referent, err);
 		if (ret)
 			goto done;
-
-		/* Verify that the new object ID is valid. */
-		if ((u->flags & REF_HAVE_NEW) && !is_null_oid(&u->new_oid) &&
-		    !(u->flags & REF_SKIP_OID_VERIFICATION) &&
-		    !(u->flags & REF_LOG_ONLY)) {
-			struct object *o = parse_object(refs->base.repo, &u->new_oid);
-			if (!o) {
-				strbuf_addf(err,
-					    _("trying to write ref '%s' with nonexistent object %s"),
-					    u->refname, oid_to_hex(&u->new_oid));
-				ret = -1;
-				goto done;
-			}
-
-			if (o->type != OBJ_COMMIT && is_branch(u->refname)) {
-				strbuf_addf(err, _("trying to write non-commit object %s to branch '%s'"),
-					    oid_to_hex(&u->new_oid), u->refname);
-				ret = -1;
-				goto done;
-			}
-		}
-
-		/*
-		 * When we update the reference that HEAD points to we enqueue
-		 * a second log-only update for HEAD so that its reflog is
-		 * updated accordingly.
-		 */
-		if (head_type == REF_ISSYMREF &&
-		    !(u->flags & REF_LOG_ONLY) &&
-		    !(u->flags & REF_UPDATE_VIA_HEAD) &&
-		    !strcmp(rewritten_ref, head_referent.buf)) {
-			/*
-			 * First make sure that HEAD is not already in the
-			 * transaction. This check is O(lg N) in the transaction
-			 * size, but it happens at most once per transaction.
-			 */
-			if (string_list_has_string(&transaction->refnames, "HEAD")) {
-				/* An entry already existed */
-				strbuf_addf(err,
-					    _("multiple updates for 'HEAD' (including one "
-					    "via its referent '%s') are not allowed"),
-					    u->refname);
-				ret = TRANSACTION_NAME_CONFLICT;
-				goto done;
-			}
-
-			ref_transaction_add_update(
-				transaction, "HEAD",
-				u->flags | REF_LOG_ONLY | REF_NO_DEREF,
-				&u->new_oid, &u->old_oid, NULL, NULL, NULL,
-				u->msg);
-		}
-
-		ret = reftable_backend_read_ref(be, rewritten_ref,
-						&current_oid, &referent, &u->type);
-		if (ret < 0)
-			goto done;
-		if (ret > 0 && !ref_update_expects_existing_old_ref(u)) {
-			/*
-			 * The reference does not exist, and we either have no
-			 * old object ID or expect the reference to not exist.
-			 * We can thus skip below safety checks as well as the
-			 * symref splitting. But we do want to verify that
-			 * there is no conflicting reference here so that we
-			 * can output a proper error message instead of failing
-			 * at a later point.
-			 */
-			string_list_append(&refnames_to_check, u->refname);
-
-			/*
-			 * There is no need to write the reference deletion
-			 * when the reference in question doesn't exist.
-			 */
-			 if ((u->flags & REF_HAVE_NEW) && !ref_update_has_null_new_value(u)) {
-				 ret = queue_transaction_update(refs, tx_data, u,
-								&current_oid, err);
-				 if (ret)
-					 goto done;
-			 }
-
-			continue;
-		}
-		if (ret > 0) {
-			/* The reference does not exist, but we expected it to. */
-			strbuf_addf(err, _("cannot lock ref '%s': "
-				    "unable to resolve reference '%s'"),
-				    ref_update_original_update_refname(u), u->refname);
-			ret = -1;
-			goto done;
-		}
-
-		if (u->type & REF_ISSYMREF) {
-			/*
-			 * The reftable stack is locked at this point already,
-			 * so it is safe to call `refs_resolve_ref_unsafe()`
-			 * here without causing races.
-			 */
-			const char *resolved = refs_resolve_ref_unsafe(&refs->base, u->refname, 0,
-								       &current_oid, NULL);
-
-			if (u->flags & REF_NO_DEREF) {
-				if (u->flags & REF_HAVE_OLD && !resolved) {
-					strbuf_addf(err, _("cannot lock ref '%s': "
-						    "error reading reference"), u->refname);
-					ret = -1;
-					goto done;
-				}
-			} else {
-				struct ref_update *new_update;
-				int new_flags;
-
-				new_flags = u->flags;
-				if (!strcmp(rewritten_ref, "HEAD"))
-					new_flags |= REF_UPDATE_VIA_HEAD;
-
-				if (string_list_has_string(&transaction->refnames, referent.buf)) {
-					strbuf_addf(err,
-						    _("multiple updates for '%s' (including one "
-						    "via symref '%s') are not allowed"),
-						    referent.buf, u->refname);
-					ret = TRANSACTION_NAME_CONFLICT;
-					goto done;
-				}
-
-				/*
-				 * If we are updating a symref (eg. HEAD), we should also
-				 * update the branch that the symref points to.
-				 *
-				 * This is generic functionality, and would be better
-				 * done in refs.c, but the current implementation is
-				 * intertwined with the locking in files-backend.c.
-				 */
-				new_update = ref_transaction_add_update(
-					transaction, referent.buf, new_flags,
-					u->new_target ? NULL : &u->new_oid,
-					u->old_target ? NULL : &u->old_oid,
-					u->new_target, u->old_target,
-					u->committer_info, u->msg);
-
-				new_update->parent_update = u;
-
-				/*
-				 * Change the symbolic ref update to log only. Also, it
-				 * doesn't need to check its old OID value, as that will be
-				 * done when new_update is processed.
-				 */
-				u->flags |= REF_LOG_ONLY | REF_NO_DEREF;
-				u->flags &= ~REF_HAVE_OLD;
-			}
-		}
-
-		/*
-		 * Verify that the old object matches our expectations. Note
-		 * that the error messages here do not make a lot of sense in
-		 * the context of the reftable backend as we never lock
-		 * individual refs. But the error messages match what the files
-		 * backend returns, which keeps our tests happy.
-		 */
-		if (u->old_target) {
-			if (!(u->type & REF_ISSYMREF)) {
-				strbuf_addf(err, _("cannot lock ref '%s': "
-					   "expected symref with target '%s': "
-					   "but is a regular ref"),
-					    ref_update_original_update_refname(u),
-					    u->old_target);
-				ret = -1;
-				goto done;
-			}
-
-			if (ref_update_check_old_target(referent.buf, u, err)) {
-				ret = -1;
-				goto done;
-			}
-		} else if ((u->flags & REF_HAVE_OLD) && !oideq(&current_oid, &u->old_oid)) {
-			ret = TRANSACTION_NAME_CONFLICT;
-			if (is_null_oid(&u->old_oid)) {
-				strbuf_addf(err, _("cannot lock ref '%s': "
-						   "reference already exists"),
-					    ref_update_original_update_refname(u));
-				ret = TRANSACTION_CREATE_EXISTS;
-			}
-			else if (is_null_oid(&current_oid))
-				strbuf_addf(err, _("cannot lock ref '%s': "
-						   "reference is missing but expected %s"),
-					    ref_update_original_update_refname(u),
-					    oid_to_hex(&u->old_oid));
-			else
-				strbuf_addf(err, _("cannot lock ref '%s': "
-						   "is at %s but expected %s"),
-					    ref_update_original_update_refname(u),
-					    oid_to_hex(&current_oid),
-					    oid_to_hex(&u->old_oid));
-			goto done;
-		}
-
-		/*
-		 * If all of the following conditions are true:
-		 *
-		 *   - We're not about to write a symref.
-		 *   - We're not about to write a log-only entry.
-		 *   - Old and new object ID are different.
-		 *
-		 * Then we're essentially doing a no-op update that can be
-		 * skipped. This is not only for the sake of efficiency, but
-		 * also skips writing unneeded reflog entries.
-		 */
-		if ((u->type & REF_ISSYMREF) ||
-		    (u->flags & REF_LOG_ONLY) ||
-		    (u->flags & REF_HAVE_NEW && !oideq(&current_oid, &u->new_oid))) {
-			ret = queue_transaction_update(refs, tx_data, u,
-						       &current_oid, err);
-			if (ret)
-				goto done;
-		}
 	}
 
 	ret = refs_verify_refnames_available(ref_store, &refnames_to_check,
-- 
2.48.1

