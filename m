Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C3F3D1CDC
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 09:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768903180; cv=none; b=TsQYxrFtKo0EarDaDftUaB9HzdTKEQ3X9xIJkMiwsHC+Foa+Jynam9R+gCACGS9wYusqNVCPDsARUFaWqGotkZUiFekllop3mcQOPZl1d9eMPazF/O013+mk4FmMXRl8F4f9mcKYwkeidUf6rWsDWfZL+XHEUVp53zdn23AtjmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768903180; c=relaxed/simple;
	bh=wdcds6xE82jDkiS8Iuyt8novimIZwCWvEsTKL+cPdfc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PJgylkArwXXrjSCOf/UuoQdWjzamzYLqO1OSeixfcsQIW2pZo+4iuN/LchjSNDgSMrpEAuQEhi1tvl8of1nR34Y6oz4pFEpVWh+DaBnXnsx8/vUETex9yjbpeXq63SkQk2NmWItm7t7jfqRqvfCbUEjAtllVABbtsuhtuuzvUTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S8ufr/g2; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S8ufr/g2"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4801d1daf53so35651395e9.2
        for <git@vger.kernel.org>; Tue, 20 Jan 2026 01:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768903177; x=1769507977; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rKCJZGvGDcsdURT84ELEHVJ0fX3suOIM4krl+dSPOsU=;
        b=S8ufr/g2IrTyETLP5zza/5HnvNknH46iH3n9Yvds06b2dUJ8UeFOF6ok+wEKg34nNZ
         xXE7xqGcUZtOTSRrqNFmRzKxo9SJugT4V0RStpZHNNzU+ewYRoYODfRRaKkXeO/Djptf
         15UhVYJxJHzA8tROZ4TZJr8GaMX+okJ7qvFBc/5ZERZWWgSgJNQxPhmd/+0QbE5LTtw9
         +Qbu1ALNZCKr9Px/dzXm/9NOGRqdOSEkIe0h801NlkFmQ5knSk6cxc2hi4uTfJIgpu0v
         USSZKzndMl7ljj3BZLSH5o6lp41/g92ZhWsFs2BPORgwiYAflB7C38DWV8GuqGBAykud
         6QRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768903177; x=1769507977;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rKCJZGvGDcsdURT84ELEHVJ0fX3suOIM4krl+dSPOsU=;
        b=AvSxt1QZW4Hfwwta+lATGeILat5+YwS14MlOeVjje7EhqjR4S6wto3gM8BnIHxvsIB
         wMQrwrZYIp/ALeLMM3SL6/I1KgdqHVC4X2n0Cnc+XEyWivead1ZqpxrP+fl61QBIyC+B
         vh+1xKrhgxjEZ4EZXwH9lJM75n25fEQnORY3vOqy24Vwm6dvZRMSlZVGsG5AKAG/xkhG
         a+F9JU5Y5X8vmWHrw5kW8t0/Kl2wMgQ7gOrGpqjWS6dmq0uav9KBVba1C90q+5rNJZsn
         YD5I8d9zkwwil1rBWrjRxNr+KQlTbTzQBbk7aXms4A9PoBqM/CoYCi19P/yOS6AgGfAQ
         lVlQ==
X-Gm-Message-State: AOJu0YyWutzN8uom/lvnTYGpEU52N3pGp4QijZXQfY8JMgsdDOng9eam
	s5kbus6JTgVQRehYpqGPUI6uKkfuzvGZBOfhLrzMNqsDWPVsyFINv4wc
X-Gm-Gg: AZuq6aKltWLbPyqptzK2xd7g4mG+/9S2mOfodYYmuXhVhMDF1AHmbn7LdzXlVrPm94Y
	BFdlR09bg4cwfRjMs3veevgGMQsiZ8kK6lAUCRMGlKBfpqZau4l+rOetWyluEJN8qY7/5Cw8vMl
	J7xtzaYifS869Vnhnyf4U/Cj/N4R2MCG7096GM3GXCDLaPG+DuAAzXPv3TJnIqkeUAc3sFZdRDx
	qecHL5h2YWTr8JaxMVExJmeZwM7tX1bWQjO2j1MzMLGbUTc8Z+7FUYQsaXKhC9ERvRt31+Kxclo
	7AyPHyTy6tmNsehaC0/fogGmkHWW427wfTrIJxE7XcntUQ8GD6sXGch4Fibiq3DkWSelQoUVnAa
	KYWdegWTs2N+KwGsc3uRkhkCizXdUo1VTIzQskX6VDWxQA9i4FHNvwy8uTD+gFzJRCUDSCR8/v7
	UENaKsDD3005jnS6Zxqg==
X-Received: by 2002:a05:6000:240f:b0:432:db19:7dc7 with SMTP id ffacd0b85a97d-43569bd7008mr18723974f8f.61.1768903177019;
        Tue, 20 Jan 2026 01:59:37 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:9d17:c155:e8f0:9505])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43569921f6esm27879778f8f.4.2026.01.20.01.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 01:59:36 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 20 Jan 2026 10:59:19 +0100
Subject: [PATCH v3 1/6] refs: skip to next ref when current ref is rejected
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260120-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v3-1-e0edb29acbef@gmail.com>
References: <20260120-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v3-0-e0edb29acbef@gmail.com>
In-Reply-To: <20260120-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v3-0-e0edb29acbef@gmail.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>, 
 newren@gmail.com, gitster@pobox.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=8568; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=wdcds6xE82jDkiS8Iuyt8novimIZwCWvEsTKL+cPdfc=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGlvUgZ46RmO7AjL9Do++6z5XxyCSg1YTocia
 ytAq0EJtCW9dIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpb1IGAAoJED7VnySO
 Rox/WiEL/3gpCmX9rsmv5dOvNL3ZvMTp8h/mU9jWMwMH4suqVcZ9K2VYaMuVd9wN6xcymgRXOFE
 70JQUxdHwry7MK0vnyocVeIsm0JJks8jMhtWJU6FczDB1PyE2a+WGfLuiYNjUOGOUE1f99JwrhE
 C2m5X/nZ6iqG3rTzvVpS0LEOylJz2ruZdLghSpTKyDp2tq5A/VrIfQ3TCq//Wk9aVICKt3bhPJ0
 1+4MSbZq8+XNZjOW49K35DG0ABYfse8yGG1l8sI4JrPf2SQiy4t+gYeIJaalXPwj3Ux/eAkvYEf
 BeglxxC71+XJbm0Mofk2JODzSLDzCxIU1GXrTmbq7Ad5hC6p/D4tbELL7csyVTrA9/3sdLfs8x+
 +dA/l/vkvb7nqWIEI3dJ3CT8dydmasoOVSccveocbhJPk4YMvvpO4hvMTeGsJk49/lkWWZTKZbP
 iHbxK5kW7HZW47eJ44tjDYxa1ssGd7KmhD+UKMB4mvBLG70zE24IxS6NEurHkVlUCci4LXy4nP8
 Tc=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

In `refs_verify_refnames_available()` we have two nested loops: the
outer loop iterates over all references to check, while the inner loop
checks for filesystem conflicts for a given ref by breaking down its
path.

With batched updates, when we detect a filesystem conflict, we mark the
update as rejected and execute 'continue'. However, this only skips to
the next iteration of the inner loop, not the outer loop as intended.
This causes the same reference to be repeatedly rejected. Fix this by
using a goto statement to skip to the next reference in the outer loop.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c                  | 44 ++++++++++++++++++++++++++------------------
 refs/files-backend.c    |  5 ++---
 refs/packed-backend.c   | 12 ++++++------
 refs/refs-internal.h    |  4 +++-
 refs/reftable-backend.c |  5 ++---
 5 files changed, 39 insertions(+), 31 deletions(-)

diff --git a/refs.c b/refs.c
index e06e0cb072..53919c3d22 100644
--- a/refs.c
+++ b/refs.c
@@ -1224,6 +1224,7 @@ void ref_transaction_free(struct ref_transaction *transaction)
 		free(transaction->updates[i]->committer_info);
 		free((char *)transaction->updates[i]->new_target);
 		free((char *)transaction->updates[i]->old_target);
+		free((char *)transaction->updates[i]->rejection_details);
 		free(transaction->updates[i]);
 	}
 
@@ -1238,7 +1239,8 @@ void ref_transaction_free(struct ref_transaction *transaction)
 
 int ref_transaction_maybe_set_rejected(struct ref_transaction *transaction,
 				       size_t update_idx,
-				       enum ref_transaction_error err)
+				       enum ref_transaction_error err,
+				       struct strbuf *details)
 {
 	if (update_idx >= transaction->nr)
 		BUG("trying to set rejection on invalid update index");
@@ -1264,6 +1266,7 @@ int ref_transaction_maybe_set_rejected(struct ref_transaction *transaction,
 			   transaction->updates[update_idx]->refname, 0);
 
 	transaction->updates[update_idx]->rejection_err = err;
+	transaction->updates[update_idx]->rejection_details = strbuf_detach(details, NULL);
 	ALLOC_GROW(transaction->rejections->update_indices,
 		   transaction->rejections->nr + 1,
 		   transaction->rejections->alloc);
@@ -2659,30 +2662,33 @@ enum ref_transaction_error refs_verify_refnames_available(struct ref_store *refs
 			if (!initial_transaction &&
 			    (strset_contains(&conflicting_dirnames, dirname.buf) ||
 			     !refs_read_raw_ref(refs, dirname.buf, &oid, &referent,
-						       &type, &ignore_errno))) {
+						&type, &ignore_errno))) {
+
+				strbuf_addf(err, _("'%s' exists; cannot create '%s'"),
+					    dirname.buf, refname);
+
 				if (transaction && ref_transaction_maybe_set_rejected(
 					    transaction, *update_idx,
-					    REF_TRANSACTION_ERROR_NAME_CONFLICT)) {
+					    REF_TRANSACTION_ERROR_NAME_CONFLICT, err)) {
 					strset_remove(&dirnames, dirname.buf);
 					strset_add(&conflicting_dirnames, dirname.buf);
-					continue;
+					goto next_ref;
 				}
 
-				strbuf_addf(err, _("'%s' exists; cannot create '%s'"),
-					    dirname.buf, refname);
 				goto cleanup;
 			}
 
 			if (extras && string_list_has_string(extras, dirname.buf)) {
+				strbuf_addf(err, _("cannot process '%s' and '%s' at the same time"),
+					    refname, dirname.buf);
+
 				if (transaction && ref_transaction_maybe_set_rejected(
 					    transaction, *update_idx,
-					    REF_TRANSACTION_ERROR_NAME_CONFLICT)) {
+					    REF_TRANSACTION_ERROR_NAME_CONFLICT, err)) {
 					strset_remove(&dirnames, dirname.buf);
-					continue;
+					goto next_ref;
 				}
 
-				strbuf_addf(err, _("cannot process '%s' and '%s' at the same time"),
-					    refname, dirname.buf);
 				goto cleanup;
 			}
 		}
@@ -2712,14 +2718,14 @@ enum ref_transaction_error refs_verify_refnames_available(struct ref_store *refs
 				if (skip &&
 				    string_list_has_string(skip, iter->ref.name))
 					continue;
+				strbuf_addf(err, _("'%s' exists; cannot create '%s'"),
+					    iter->ref.name, refname);
 
 				if (transaction && ref_transaction_maybe_set_rejected(
 					    transaction, *update_idx,
-					    REF_TRANSACTION_ERROR_NAME_CONFLICT))
-					continue;
+					    REF_TRANSACTION_ERROR_NAME_CONFLICT, err))
+					goto next_ref;
 
-				strbuf_addf(err, _("'%s' exists; cannot create '%s'"),
-					    iter->ref.name, refname);
 				goto cleanup;
 			}
 
@@ -2729,15 +2735,17 @@ enum ref_transaction_error refs_verify_refnames_available(struct ref_store *refs
 
 		extra_refname = find_descendant_ref(dirname.buf, extras, skip);
 		if (extra_refname) {
+			strbuf_addf(err, _("cannot process '%s' and '%s' at the same time"),
+				    refname, extra_refname);
+
 			if (transaction && ref_transaction_maybe_set_rejected(
 				    transaction, *update_idx,
-				    REF_TRANSACTION_ERROR_NAME_CONFLICT))
-				continue;
+				    REF_TRANSACTION_ERROR_NAME_CONFLICT, err))
+				goto next_ref;
 
-			strbuf_addf(err, _("cannot process '%s' and '%s' at the same time"),
-				    refname, extra_refname);
 			goto cleanup;
 		}
+next_ref:;
 	}
 
 	ret = 0;
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 6f6f76a8d8..6790d8bf53 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2983,10 +2983,9 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 					  head_ref, &refnames_to_check,
 					  err);
 		if (ret) {
-			if (ref_transaction_maybe_set_rejected(transaction, i, ret)) {
-				strbuf_reset(err);
+			if (ref_transaction_maybe_set_rejected(transaction, i,
+							       ret, err)) {
 				ret = 0;
-
 				continue;
 			}
 			goto cleanup;
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 4ea0c12299..59b3ecb9d6 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1437,8 +1437,8 @@ static enum ref_transaction_error write_with_updates(struct packed_ref_store *re
 						    update->refname);
 					ret = REF_TRANSACTION_ERROR_CREATE_EXISTS;
 
-					if (ref_transaction_maybe_set_rejected(transaction, i, ret)) {
-						strbuf_reset(err);
+					if (ref_transaction_maybe_set_rejected(transaction, i,
+									       ret, err)) {
 						ret = 0;
 						continue;
 					}
@@ -1452,8 +1452,8 @@ static enum ref_transaction_error write_with_updates(struct packed_ref_store *re
 						    oid_to_hex(&update->old_oid));
 					ret = REF_TRANSACTION_ERROR_INCORRECT_OLD_VALUE;
 
-					if (ref_transaction_maybe_set_rejected(transaction, i, ret)) {
-						strbuf_reset(err);
+					if (ref_transaction_maybe_set_rejected(transaction, i,
+									       ret, err)) {
 						ret = 0;
 						continue;
 					}
@@ -1496,8 +1496,8 @@ static enum ref_transaction_error write_with_updates(struct packed_ref_store *re
 					    oid_to_hex(&update->old_oid));
 				ret = REF_TRANSACTION_ERROR_NONEXISTENT_REF;
 
-				if (ref_transaction_maybe_set_rejected(transaction, i, ret)) {
-					strbuf_reset(err);
+				if (ref_transaction_maybe_set_rejected(transaction, i,
+								       ret, err)) {
 					ret = 0;
 					continue;
 				}
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index c7d2a6e50b..191a25683f 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -128,6 +128,7 @@ struct ref_update {
 	 * was rejected.
 	 */
 	enum ref_transaction_error rejection_err;
+	const char *rejection_details;
 
 	/*
 	 * If this ref_update was split off of a symref update via
@@ -153,7 +154,8 @@ int refs_read_raw_ref(struct ref_store *ref_store, const char *refname,
  */
 int ref_transaction_maybe_set_rejected(struct ref_transaction *transaction,
 				       size_t update_idx,
-				       enum ref_transaction_error err);
+				       enum ref_transaction_error err,
+				       struct strbuf *details);
 
 /*
  * Add a ref_update with the specified properties to transaction, and
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 4319a4eacb..0e2648e36c 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1401,10 +1401,9 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 					    &refnames_to_check, head_type,
 					    &head_referent, &referent, err);
 		if (ret) {
-			if (ref_transaction_maybe_set_rejected(transaction, i, ret)) {
-				strbuf_reset(err);
+			if (ref_transaction_maybe_set_rejected(transaction, i,
+							       ret, err)) {
 				ret = 0;
-
 				continue;
 			}
 			goto done;

-- 
2.51.2

