Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE102343B3
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 07:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738913835; cv=none; b=h6F5TJH3qIrsyg20Ou+05nl6p/AYz1zK9bXDRH5WRBw54huniUtdxFXnWDrWbp9bgaeRmryWadiVoaPCrm6N2HPJa7zXKGFfRGrSTS3Ia0YJ3Dh8z6oKwnw5k7QrPq0eXydLstm4MYLgQSYOdSzcW6KuImMaeJQm6Sn/l0uD72k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738913835; c=relaxed/simple;
	bh=gmDuid9pZZ+vsVgXtewSbqqp3CYMorAr0xWDnqVtqHw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=inQ6X1n0Oh6aDVUxblhrFJL70UDBPL5u0ijJI6zFT0P272QYdB1i8LEAQmIzBUJuM7CqC4iYW0TGag5E9qDYkbtKwVmtxBtCG8JV/kBga1eWYS3rL2lR86pwgC3J8y78UgJAM9Iv5NodtWkYk4yfgm2030nQZFgQ2PZpve1413Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TlsKu87M; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TlsKu87M"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2166360285dso32001475ad.1
        for <git@vger.kernel.org>; Thu, 06 Feb 2025 23:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738913832; x=1739518632; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z9ptp5AUmnHfbqn1TSEj+23gY/vjbG1oL+MNziJusaY=;
        b=TlsKu87Md4Mm2Ef9peaWNncn282iuNBEvdV8S13PVmSsqH2RUi+MDHcdTFRFMWl7E/
         YBztzERp9exHQx1ClOYwogI7DSmontvKfUdpZyFbl2vdqLku9sjlDi4prSAEJsE1SiI4
         C2B2KtI/8MIyaOVT/S8nCZC8to9vmsofk7cdMkNqRl7rvXIE0tMe0B70xYt/mNOPl9IE
         Hn+volLPZ8RncJV38qCd6Gvhp2uOVmllMak0oN9IPlqtbbxwgI2x3eICBZ6sOI/mKYPd
         OYQ5neC4BEiwsq0NRi2IjdDF0NqenhY5/YK3OUN8XVNIv6bZIyUsi5/7I/SBILBvzaQi
         tqrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738913832; x=1739518632;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z9ptp5AUmnHfbqn1TSEj+23gY/vjbG1oL+MNziJusaY=;
        b=NA5yb6DCVA13bfwL/sJgoUYV6z02YPPPsjwWZLqtQdKryOcTACCqE/EYp6IHbieMc3
         xTiA3z2FpNJEETCiX2KHPijcZLZ/lBPzzjxVYJTizPNaBVe5Ns1CxcIz5lCqK56zooZw
         KRA5LH7kwL7XEFB0S424SN1EJKqWcSo+uaaAgZ9Rlw/3S/PG42mdq2l5pBCPRc7mIoIr
         6zvWdG8xq066UyfzZHx7TPWkPqmAm2hKcN+GoxjJDqdF/iJezBsT2UP0l7UKNeqXoU/D
         Pbrtgki+OK5JJhj5lzzMWF00ttTZJJxqB4rZCni19JsPVBRbB2Quctjza/dqybtCUEV4
         YxUw==
X-Gm-Message-State: AOJu0Yz+BskRhE8afojsqmGsiZsQiqsQpTcsEZASitLbt57ciIZvsZpS
	hi190RBdXb5aHJoV77cmXvmYrNA0uT3lfInZE4EaPCZ9uVfLkGc5OuokYLZw
X-Gm-Gg: ASbGncuhs9vKowmLyMALQpHZPhivbMIwREPPYCjVQis74CvSvC4KpB12mn+8qHzXFVd
	KHvkez5mJ3Pxo+R9WjgGErikDA5jMwgHB1GdkBY1d41PnUTlM+XzfexPGcMLRBIV1nmGsrhFhoz
	efk9n9cdkADv4o9iUU5+nl/TOVFEBoIXg2Etx1FUhdf5KZL6PEH2JTyhXutg7wf3zJab9X0WWGq
	m1dcWp1OIzaLONj2d6lWLfs2y/DJM52WzTq2AfOPdTGFfXrTABjccpuMHuv+66mSLeK1R57SjLQ
	3qiqz8m8aBlzdAGbcFoo7g==
X-Google-Smtp-Source: AGHT+IGasue6tbgXGvrIufjPt7lVV8OUrfN+pwdaMAWtgDlGIHPie3J6LqGgmM5fz9Jmg0wEq0SGjA==
X-Received: by 2002:a05:6a21:170f:b0:1ea:eca7:10ee with SMTP id adf61e73a8af0-1ee03a21d5cmr4542732637.6.1738913831799;
        Thu, 06 Feb 2025 23:37:11 -0800 (PST)
Received: from [127.0.0.2] ([2401:4900:33b7:4cb0:4dd3:85f0:5c4b:b677])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad51aee79casm2115063a12.44.2025.02.06.23.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 23:37:11 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 07 Feb 2025 08:34:39 +0100
Subject: [PATCH 4/6] refs/reftable: extract code from the transaction
 preparation
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-245-partially-atomic-ref-updates-v1-4-e6a3690ff23a@gmail.com>
References: <20250207-245-partially-atomic-ref-updates-v1-0-e6a3690ff23a@gmail.com>
In-Reply-To: <20250207-245-partially-atomic-ref-updates-v1-0-e6a3690ff23a@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im, jltobler@gmail.com, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=17774;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=gmDuid9pZZ+vsVgXtewSbqqp3CYMorAr0xWDnqVtqHw=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGeluBtm6fk8Ey9Y7k94ZIglAEXruQIb1zzTj
 ykhppIxxHqYYIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJnpbgbAAoJED7VnySO
 Rox/BKQL/0HB4HHGdLCFkl0AYTtJgQy2gAxRvInb/9EtpkLg8jHVI6RjKcq0kFJqz7HP47BCVOO
 RR8/wJOnrSQbp4YaJrlDGRuQfJFB8S+MRaZG4oWbz79BSzlLDVOQoOTbGOHIydc9sXWayUehwe9
 7UINH4exfLIwrqMqvBJySb3qhWnBePr14gbo1vQBYyGAup92X3iUf6cv47dWDfIq43W9I7bKQJX
 rgRqxHhMCruOaKt7h6oC9OilJhSgdy3EVBGvht13JyElSeCw/0a/iT1q9esapXQwJ4K+wFDB3yh
 EfguD/syoeZkL/3w03PSPoTDp2ARE1ZeqIuOomdAniUkiNUR5GxA3bIgZfjxJwtwbpadNFlzaxx
 Jig6cXv2ILm3mK1Qx9/uBjGYlzd8a6iue1/KO262VjTe3coZMMEqLWpGFMGuJxhgjnjTD9Q16y9
 Mq/yKU/26iWoMM2dhHNCZ2qg/KWIwpbh6+VPFDid7JhowLbInZGSsXArUeL9EbySUZ/IBhOjXa5
 mQ=
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
 refs/reftable-backend.c | 471 ++++++++++++++++++++++++------------------------
 1 file changed, 240 insertions(+), 231 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index dd2099d94948a4f23fd9f7ddc06bf3d741229eba..5533acfaf9027765d5a270abfce96225e42cc823 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1061,6 +1061,242 @@ static int queue_transaction_update(struct reftable_ref_store *refs,
 	return 0;
 }
 
+static int prepare_single_update(struct ref_store *ref_store,
+				 struct reftable_ref_store *refs,
+				 struct reftable_transaction_data *tx_data,
+				 struct ref_transaction *transaction,
+				 struct reftable_backend *be,
+				 struct ref_update *u,
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
+		ret = refs_verify_refname_available(ref_store, u->refname,
+						    &transaction->refnames, NULL,
+						    transaction->flags & REF_TRANSACTION_FLAG_INITIAL,
+						    err);
+		if (ret < 0)
+			return ret;
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
@@ -1124,239 +1360,12 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
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
+		ret = prepare_single_update(ref_store, refs, tx_data,
+					    transaction, be,
+					    transaction->updates[i], head_type,
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
-			ret = refs_verify_refname_available(ref_store, u->refname,
-							    &transaction->refnames, NULL,
-							    transaction->flags & REF_TRANSACTION_FLAG_INITIAL,
-							    err);
-			if (ret < 0)
-				goto done;
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
 
 	transaction->backend_data = tx_data;

-- 
2.47.0

