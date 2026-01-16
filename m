Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D91C29D27A
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 21:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768598836; cv=none; b=BJREZGJd5gN5Fha+qzG32A2PtcJ0MMD9viBwK9/bKTNeX1TFN8gA7/A2elHVT62PcpcmT0nSN+yV5AQEXoueySuGROJXZWj6ndaCdsYLHm6gCSMk8uqXCR6La+ENarQaRrD7FUl1VU7vLO8r0LpW3c1xjBkOyCO8KZ+zzEUuEjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768598836; c=relaxed/simple;
	bh=4UJhxa+O0MBFAkPxCJI3Yq5z50GuIcFBkI0bjZ8v+fc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MKgFT6axYGKAEr/trz3OcG0JhSj4OoSoQC/8pU5b9JAulAlXazcIusWeFe2N0MnSzSr2tbODKURdSFpXCcwd8mN3cDWCAm/f6IgsIWFHVfPTe0J/RytYqJK7gwI1oS+yP3j3L4lv21efEX2PbkyARa9xhJ9weOpdr/fWgXchr+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VrEhoRFS; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VrEhoRFS"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4801c1ad878so15708345e9.1
        for <git@vger.kernel.org>; Fri, 16 Jan 2026 13:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768598833; x=1769203633; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=petUc72WmwiRQaET2kaU0YBEh+cnRZVtNa088k75XJY=;
        b=VrEhoRFSLFCia4Tqy8sCAJPq8QNMrV1be9LWZgLAainwJSoa6uYXUATZkHhIS1OeSb
         pwYnzBGbSWlvBdPeODCk3ft6wJwAHduz0hGNRfx+gcivPDtuzrl0fH91K5cb9Hs6sDbz
         D8SDAkXqLaKPM50PPVAdMQE83exRg/mpkWD5/aTXYK5KIea9DGp76VYR49Iia+dzEHGf
         lepvtDB9ZuK219iWWArR5D16DLkuSjD/7xzk+RO4M+E4SX1rF0Q08Xni4ivymDOuxHah
         l5DcAbhJwxjugTuaDhoM34cgW8xojj3GldJ4psqQOhV4mjZ9dmDmMxk9jiann4Xvoq/N
         f5/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768598833; x=1769203633;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=petUc72WmwiRQaET2kaU0YBEh+cnRZVtNa088k75XJY=;
        b=oOHnd/QXkqeg5VkIuYDX5P+TxgyEm0fwzpuc0LJWtAuVoJIRcA95Zt8P06a6dN/QDv
         ZvQMigyAztz6lVwlluL1lXz7wmmMw5DmvHksyhpniSXkaAgMwCMO9+N7o974AhZ3gWFQ
         8sU3N2GvQa4eQ+eL97gS0p2Zreieud44R+86ItthHCzgJtW1edzSeeDLGZVkC8QdYlkw
         UV6NcHRoqyTHxPk0xcCTMs757siSqyGq0cHvtYNrPv20CJAdvWBs0+bIbl8E0DkPOvN3
         CB9e3zYB/6/ULLsRmvjNdeBS3vRpp297Dg1SfFB/3C3zlME0E+BShGqz4vQfSPdK5es4
         W9Lw==
X-Gm-Message-State: AOJu0YwnmEN/dYM7Fi+EQqV3DsIOBzAJRm+9lNX6P6lmCkJPhDZEjV/N
	E7uUipt9AoTwK9u8u8PiPPV2RQTOH10xYAeco8QtQ81tB0IyAsnSky/p
X-Gm-Gg: AY/fxX45kZKD6tJ49XfIUCQ4jt+Jb+J16eRWbUw/lgevGSgMsbU3DTCEVmPJ5FfgpDn
	HX6MPip6TqIp+ZCTrKorhU73MQMJRCW7fcKXOfeYqjYydH/WA6lkFHWtr+P0kps2Sl6vZSYKEho
	xbcLXZTdJQcUQifuT1Vg2XzBQDeI0xC+fttPgX5ExeAg4NCOv+0PjS7Tf0rpcgP/hDU+hGu44Vo
	9zCFQuPFiJpHKmS9Ww26ThIiJlIinXipO5rrKeVtXWj5z6aJn4awYZsHnNLhpZEX+SDoPMSwpFk
	Y7pczU+k4BZSaLUokSgfWEyJa2EJj6DU1EFAnT9L+YZ3sEl+VtkZevuoNCtMLhReXveeSMWKmci
	B9FKV1mbs09NP/AVfiuwmJgplydbxCiAjbpxONPyG4yPYHEIAvGTzjJzrid+72WbcuAegPRM46w
	DEcXt5eFhF/6YgdkQWPVR4XcvbLrKPQw==
X-Received: by 2002:a05:600c:8b08:b0:47d:5d27:2a7f with SMTP id 5b1f17b1804b1-4801e347d3amr56226725e9.26.1768598832718;
        Fri, 16 Jan 2026 13:27:12 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:1edb:411c:5531:1628])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801fe67780sm23382025e9.16.2026.01.16.13.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 13:27:12 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 16 Jan 2026 22:27:07 +0100
Subject: [PATCH v2 2/7] refs: skip to next ref when current ref is rejected
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260116-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v2-2-925a0e9c7f32@gmail.com>
References: <20260116-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v2-0-925a0e9c7f32@gmail.com>
In-Reply-To: <20260116-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v2-0-925a0e9c7f32@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
 Elijah Newren <newren@gmail.com>, gitster@pobox.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=8568; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=4UJhxa+O0MBFAkPxCJI3Yq5z50GuIcFBkI0bjZ8v+fc=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGlqrS0PqG1VTX4rNZC7Bi89bHxkNr7uESRPs
 JlXIx9CvqrgwIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpaq0tAAoJED7VnySO
 Rox/X7sMAIzaOj++Ym66sz9VnlNRpFuVOJ3PK8YgylVBhy+jA9TEXtfAYVExMT/MZDD0QV2MCQY
 VnNS8chTcyTb52im3T5XhEjY4mC2cxVlWcwdLz/EWkw1EWxFxd0Rb+b/pJj0xq2pSCHo1yUYgo6
 ftEbl7flBN9tbd0vcIHwsjFSCc7uWrffEQntNf7RWcl46TDNATRx3MMR+lLA1URKB+5Uy1TFeaR
 Quxz2MTz+n4KiGsmrcKDjXSiizK9JyfYo7uxdC5LRaXfdDqlXurWvjVoD+3BTz94kGZpVZkWH5q
 BNlptVBnG6TZH1rbPO2ymVxvfBc3iu8gw1v7nHvixbqF94k0Jqkw3HSXvomOF9+sHHMNHAOFiID
 gFYUym+C/jiyAZ+eqQsUMVC4g95pnHELWolYvQ+iZ557WNOjpZTKVMjacdn+flDPwZ9InSWPuWA
 6x8UethGX0IX99VPvlF7GFQ45kENFpilhjhObxx0QACbw3fYQXSh0n6UK+cQovz91J+tIPAAlq3
 1Q=
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
index 965b232a06..3459d0e4e5 100644
--- a/refs.c
+++ b/refs.c
@@ -1222,6 +1222,7 @@ void ref_transaction_free(struct ref_transaction *transaction)
 		free(transaction->updates[i]->committer_info);
 		free((char *)transaction->updates[i]->new_target);
 		free((char *)transaction->updates[i]->old_target);
+		free((char *)transaction->updates[i]->rejection_details);
 		free(transaction->updates[i]);
 	}
 
@@ -1236,7 +1237,8 @@ void ref_transaction_free(struct ref_transaction *transaction)
 
 int ref_transaction_maybe_set_rejected(struct ref_transaction *transaction,
 				       size_t update_idx,
-				       enum ref_transaction_error err)
+				       enum ref_transaction_error err,
+				       struct strbuf *details)
 {
 	if (update_idx >= transaction->nr)
 		BUG("trying to set rejection on invalid update index");
@@ -1262,6 +1264,7 @@ int ref_transaction_maybe_set_rejected(struct ref_transaction *transaction,
 			   transaction->updates[update_idx]->refname, 0);
 
 	transaction->updates[update_idx]->rejection_err = err;
+	transaction->updates[update_idx]->rejection_details = strbuf_detach(details, NULL);
 	ALLOC_GROW(transaction->rejections->update_indices,
 		   transaction->rejections->nr + 1,
 		   transaction->rejections->alloc);
@@ -2657,30 +2660,33 @@ enum ref_transaction_error refs_verify_refnames_available(struct ref_store *refs
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
@@ -2710,14 +2716,14 @@ enum ref_transaction_error refs_verify_refnames_available(struct ref_store *refs
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
 
@@ -2727,15 +2733,17 @@ enum ref_transaction_error refs_verify_refnames_available(struct ref_store *refs
 
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

