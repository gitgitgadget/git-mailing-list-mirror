Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A4524292A
	for <git@vger.kernel.org>; Wed,  5 Mar 2025 17:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741196362; cv=none; b=bKXxgWi2R/tkLi3xY6JEXnE1Hos0Gtx0bT2QgqTpWEVHFCCpBZZEDFnufOZ6PVLFjCK/fIUVQn1V+XEEmFfq9rs7oG3OFzSFvHNMdLqE+VbyocVbscB4h6Kjp3q3dVjETaYyY3NOzi/vtp7SW1GtsUP6ON9XZQBHLptTC6BzicU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741196362; c=relaxed/simple;
	bh=hq8go0Ycc9CHgydnJXhyVX3uRQdNtmvpHOpz8TsjZHw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hB8+gZc/W4/vo54Leokqn7VsI6G/c45PYJJLqPOjTrb2X3FDBFJijyFyi1zC316P4CsG44rN15nuTCxv+KYLB1puXgWB4+B0Y9gXqreIJUmMaJ936IQM5EBoxxP24x0I/Rzcuu1Vqht4N09YI1Yv7VZBxsqu4OWlypWl6cF5Vmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DmirU8ER; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DmirU8ER"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ac202264f9cso310023366b.0
        for <git@vger.kernel.org>; Wed, 05 Mar 2025 09:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741196358; x=1741801158; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4WoqLWnPCw0oE6c9586Fu0OJyx+S8HDzSFUKpGjakzs=;
        b=DmirU8ER2BVy85lONCVLa9+7Wv1GwN27uza4oWECgB6bjcEUW3xQvtuvPEV+8ph9Hw
         4ODlb+vPuhaWS8VCVyUFBFvVPeTu3Ga3TBjCG74smnmtnTfiul8lBHMSY8oBFHBIkGeU
         odhfVGrZtEarGto9gcuRvgmP1hhuf7Q7ng1xWmqgFB+dKc5tyIPMR3XURtbbIqe6/JN7
         y6hkeF6aFjBZFGl7XLcyquG8+3j7oWfvyofNT/C8SvTx0gUGK+MMrFljAhO0/z6wIAmj
         44BkuAI7Jxog27soY+5Vd3D1X5XRl2AtGTo4dZ434x41IcBS3HVtsjXx/z7G7x9cUDgT
         IkiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741196358; x=1741801158;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4WoqLWnPCw0oE6c9586Fu0OJyx+S8HDzSFUKpGjakzs=;
        b=URJiNVa+OTYw+48tYpN177G/ydTgvrC7mFKdt4bOkGJpPPzTcYx8qimNyK87IpbXvC
         /40Hj+ULTCZNWNeMdLvxzIOJHH70TrSEX108XLzmCfVHedCcFxxEjKMpjZqZqSCX7KQA
         /qgk5+JRVzidtDtsh3lXlsWINHa+Tu+EHB2QC1CBVB83PC/Sl/1QvHUeSko+W0zj7HE1
         HPAi7zav/HLMLAhWf8DiHFPUmjKpVsFRelOzE1UIszRZQ8tB/gcyDS3dkK/L2lHoBjNi
         9OfNNQY8DwTJ5+tNlc32gBPklRcY+fboSa/rYV29lf3I6dWNCuQGJWBxMiRLAJ8jwlJx
         4XzQ==
X-Gm-Message-State: AOJu0Yxj3v40KDG9gQlXJ9+8id6BqgECCvKlKJPq8aBaYmVtsYF4wdqd
	iXwpj6PllJwypBmmvr5Tp4FH8Gi4/9d4jcoBFxjWz4nx8azgSIbQ5Ov0Z5Io
X-Gm-Gg: ASbGncuWTk02FTjb6NJyGa0hq9EO2rjBT+LZS7ybSzeBh+ioPTKxkWqXPUj/M8IfcDL
	JtQkCcxO1aD4DGFfJZfjXR3LJn3eB2t/cnFEBER4yh6ihGhLnsl6ck4cddeiTiR1zUlZFvWzcMr
	vTP4vAIH5nH9j6ot96gDbqTi6Cr3ap3fXQ9ntxWG4tyuFvH/W4hrV/4wwzNhqJ/dYHOYQsqwvSu
	Xt067Q4/be3H4zkwCZBrLTHrURHyx3H4hIb6bELXkGx7GEevzkF5XFsF0m61DKa4JovXndh2XTN
	9H6ZDmRZt1sItUfsp3Vd2gNraOAPUE+zMjG7SdrOPfMKuJRJLQ==
X-Google-Smtp-Source: AGHT+IGiX5PwVW/atJrAsgBdwNrAhpkQ1iD3gQvr9KpFLKAyEXENeOyW4yHijk4s9xtn261xS5D8QQ==
X-Received: by 2002:a17:907:8b97:b0:ac1:d8a9:f853 with SMTP id a640c23a62f3a-ac20e1db11amr466739066b.48.1741196357429;
        Wed, 05 Mar 2025 09:39:17 -0800 (PST)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:8a90:b290:3a5b:4dd])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf3a8e2f53sm946851866b.115.2025.03.05.09.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 09:39:17 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 05 Mar 2025 18:38:59 +0100
Subject: [PATCH v3 4/8] refs/reftable: extract code from the transaction
 preparation
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-245-partially-atomic-ref-updates-v3-4-0c64e3052354@gmail.com>
References: <20250305-245-partially-atomic-ref-updates-v3-0-0c64e3052354@gmail.com>
In-Reply-To: <20250305-245-partially-atomic-ref-updates-v3-0-0c64e3052354@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, jltobler@gmail.com, 
 phillip.wood123@gmail.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=17407;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=hq8go0Ycc9CHgydnJXhyVX3uRQdNtmvpHOpz8TsjZHw=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGfIjEDPDdvQTgdPzXTP2UkKIfXKOUHd+Wt8W
 kekzKpMFTnLaYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJnyIxAAAoJED7VnySO
 Rox/Y44L/19gTjYvNFX4Q8cD7pAjYDlUJYw4rEHmN3VohT8rJOOV6y1jnRCk6dlJZsNWoh6nPFd
 5PgqMwoh0SjOHKqsq2eIafMtH3R5jBtdw2TnEQEYU4xchPeVQOKcB5fphR1VAv3B0OIIggnLcit
 IeUofqPhx1r2ivk57xZXOvhYfHLRjf5YQxA8cmuLPLoAanU/ErIvpnaYYT3xdQyaKH1RgUviYXk
 dOkq7qQP1kLlUO7oBXXOwbY16TfiyYVwuI7ro43d7WWV4O1cCewpIrcHOMQfivM8LJ7GKVa3goS
 s2i9W9W6rN+KHNZ4FNfAcvBvMKLSwBUCejnazA6+/Pc7b+xjhWWJhmyZgYRd/f3V9xdUSRgNGKw
 B1HrqhXzG4fPrQDoVUZaRectrYCynOxJxeX9ol/QjdBKR8At/JHab1Nfm4+NfEpHeZUS6bl47xM
 81sTSFtBzNH4/Pst0ZJYMLP1VUX97px1vKJVPZgCQcJwdOAf0w31vj21oVBzBV82wSnG2v2/lB4
 0M=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Extract the core logic for preparing individual reference updates from
`reftable_be_transaction_prepare()` into `prepare_single_update()`. This
dedicated function now handles all validation and preparation steps for
each reference update in the transaction, including object ID
verification, HEAD reference handling, and symref processing.

The refactoring consolidates all reference update validation into a
single logical block, which improves code maintainability and
readability. More importantly, this restructuring lays the groundwork
for implementing partial transaction support in the reftable backend,
which will be introduced in the following commit.

No functional changes are included in this commit - it is purely a code
reorganization to support future enhancements.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs/reftable-backend.c | 463 +++++++++++++++++++++++++-----------------------
 1 file changed, 237 insertions(+), 226 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index f616d9aabe..2c1e2995de 100644
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
 
 	string_list_sort(&refnames_to_check);

-- 
2.48.1

