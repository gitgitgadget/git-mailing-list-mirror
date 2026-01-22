Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C48438E5F3
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 12:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769083529; cv=none; b=UObnU+GsvtU+0BNwPAcHrZAkx0IGXZLYUa/52eL58r0V+vIkrmWa57RXHSB+b50cMA6r/JnHULLiaOZXfCUvw3fygeeWgarlBKv2AXstlZ7BGF7NhFiZNuAT4pxJy+HiWps6XbgXUqWWyzWs++3flNPYjHXJCSZPqkCAvMcptoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769083529; c=relaxed/simple;
	bh=mUw0osWrauMoRV2LbT2u4ai1pjyKhjNkBR86WXKflnY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WNyj0UlTqMWnvII5DN/wC0D2L4BeQto5rtiGDdrmGncSyNpddJDArn8ddJkFM1b6AKuR4FB/LAY7S0cRz2adEmiZ7qZeSYTp2LmKSrboWiBU9VCTfC6n4jQVmEsbgtEH7a370XkI2mWZh5SZq0uyoQhxocLr6r0tEbeBKEa81EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQNMiZzL; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQNMiZzL"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-432d2c96215so740571f8f.3
        for <git@vger.kernel.org>; Thu, 22 Jan 2026 04:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769083524; x=1769688324; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RyfcSpEP9FGiFI/wolCmRFJytAQUEBDX0gITcSUj2g4=;
        b=FQNMiZzLX0kmtsMnAp+laaXcT3MOS2GG1S7KR3XRLJg3y3gViTwLJz7j+YXEFD0ZfW
         OhAqA8+4hqynAZYz2SvdT+7btTIpa9i1t7Jcg/UvFlraoEl8A/hNRCjt0uUI1e7YoaE7
         +65QcYMd4OUKpLZ8etqhYr0vCWpoUm9WcBX0HNEWXjpoojv4VSc9QzRh2Rb0t2Bxyg2U
         0Sxyfsv9Z4mnZKCeqX2VZ4eCcrc3/seEEdfXOUkn0G3enoZTzCoXvx2yUQtghMiT17Hj
         zt+BYpbA+Pn72UlfuLJSVjCg4PFY5hr5/wP3hG5GYukUBWzh3mezsSRve5is0Xhcc7Ri
         NeEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769083524; x=1769688324;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RyfcSpEP9FGiFI/wolCmRFJytAQUEBDX0gITcSUj2g4=;
        b=TX+TjJatLpL/urDC3I3u/xVduNUQNOPoUdWWAGcoaBgNTYY648YTT7tL2aYQzJJguD
         AbXEKfJ7HVFoNc/ShSdZDsoSe3/KWQaiCkHmq6fF9e4l2k2ccGdiIVnhBsz2JS6qZNhw
         MDg7voWs1p2vx0afxArdZb+TnwtLEmO2S505Gl32MtRxy4Us0h79/NsbX7/OTKXHiwVw
         /ZEvNW2lIciisrsRqsKGWGXR2dXGU5z1dOy+VtgO4p3iWCkjyrQVl/0hzbsUloeeEmil
         ykkqOAKjd9q17eymfkmLjtvNgUv7msGUpw8iTU9IHGiO3IMK+3dcH44mYcMziJdsMrh0
         4mMA==
X-Gm-Message-State: AOJu0Ywl6lTof1hqe1JEknaBrc56QKpU86gllhRROrtlrG27r8kF1R7T
	5wzuvVdrSLqOTGxNP936DseHg9KTU98o4EtQT/FedypBQv3pqt892U0IsGKR+g==
X-Gm-Gg: AZuq6aIVh6snWBR7fSPNNmJpaKBWIfzj3C6zWPM1G002mnrqEYsitOeDbXxLG3sMl00
	LX3CYhW+XfxbMMzTBUXEKm9A2YjSPSXT7SmZ63BSl1oDVuxD3x4g8TJMfIy84R51kMXB+JsD0QV
	Iy0ogVWDPirGSLBTlR1fY0/Pt/bYtv2bHmyzQFMmFxPBs6xbKune4jWluvnr81z2uoBIlpdWw/y
	KjXQOu0XjNQd9rc/SEK5MZ4Isk/vDtslb6yOrTpRjwR7rNcdwGBlG+FU6GSwXWlYP0ZnT0ZHUUJ
	gdgLvySMk9SWgg6lnyguUhFAZMynKf6WvrBCwoqYpYM9MlV7qbdWSLHKhaWfVPbz4+y5L0bqhBd
	eWiqCMbP+18xjgiAhR3QtkciW/QOChcUhcVLgT2eh5/0yJxFvudLOIivTO1FZrtTpyjSCf4VnHZ
	M9RQ9GXFbbEKs8yTWQxw==
X-Received: by 2002:a05:600c:c4a4:b0:477:7bca:8b2b with SMTP id 5b1f17b1804b1-4801e2fef34mr330677465e9.15.1769083523816;
        Thu, 22 Jan 2026 04:05:23 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:ef49:411:ff92:1c50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-480470403d3sm64926445e9.5.2026.01.22.04.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 04:05:23 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 22 Jan 2026 13:04:55 +0100
Subject: [PATCH v4 1/6] refs: skip to next ref when current ref is rejected
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v4-1-2ddba0832440@gmail.com>
References: <20260122-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v4-0-2ddba0832440@gmail.com>
In-Reply-To: <20260122-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v4-0-2ddba0832440@gmail.com>
To: git@vger.kernel.org
Cc: peff@peff.net, newren@gmail.com, gitster@pobox.com, 
 phillip.wood123@gmail.com, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=8568; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=mUw0osWrauMoRV2LbT2u4ai1pjyKhjNkBR86WXKflnY=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGlyEoBr0kogjEDn3QT6pSzir10BNTV8JfjaN
 BR/cPURiBeBj4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpchKAAAoJED7VnySO
 Rox/zjQL/A4AolEQDjTN2OROzMP6DZF6urIBexj6SN5Uv+7X+u1xQ4yhufliq59B0oueFIUWBlv
 fRHiQy1s2d0CDot0X5fBVgk+r+hDJmWaxoPogjGzPH8xoyjGd0ngc975SQCGbI/cMvFaAyTjirg
 Mv57WJON8tSSbYbH+Kdm2R7zwgfCfZvPNdIk5XntsN/Gbs8dEVCNNYOe34O2T3EMHHT1z4OLfl2
 Xus+DfT7+tVKPogL14jcXnNLohtHSP1qv8ctKBHy0Lcvq1FG3v8gcWf5ZnMwjjzK2Ew8/+qnEWP
 OaTXEDpIkQqVCqGA/tcUWLAi5jPQzB6fCcsO5kx71eI5qzD9rCaQQUY3uM6KsJJogeu+lB3obUY
 acdFTF/XsrLqUaA2VkSyqtTiIjoJZCFKvJiM/KYPqXM7EpoYoPgsejhm+YReVUtfEdFcAIGe2dZ
 eNlSh83Pj2LKFSgILLkbyxZYr6LvdbhzZzVdzAHXxZwgBTT/xMf3bP4eFsUQJkSUsBcBd497756
 yI=
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
2.52.0

