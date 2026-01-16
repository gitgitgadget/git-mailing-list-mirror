Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A433FFD
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 21:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768598835; cv=none; b=XQ0yn60g3pT3foExwWIQemXQbh1FCg3pytjAcO+MFuh54xkMNWnJe77nVcecgGYKzqoYm2ElH+2kZ8INeKVleWLVaMdH3MCP4kT4umGI2SWeqokvNvmmigAMPdIrZftF9gO9AZeao6n1lZHStWvYNmA9iiAe+i/H3v7/6caDZ9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768598835; c=relaxed/simple;
	bh=q9teHitVzH3iWQWdr/24LrI66qRP+WoO314w1y8KsiE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=QvTiD3vQ5MWNIpPg5z1v7XA9J2zZ8vY7L7BrxprNcrYPx7p+l6VteT1YOJ4dWxP5WZrOJH0+SBznXY9vMbIVhm5osInF9ka9KzRsZ7omQWBsM8JqgPXgHvQmWnFOjgeGzxZTv8mOD/C4JhP4+dFySAler2ri75cjvCbKSuh01p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zs6Gmnuf; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zs6Gmnuf"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4801c2fae63so13307855e9.2
        for <git@vger.kernel.org>; Fri, 16 Jan 2026 13:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768598831; x=1769203631; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n7irG7Pn8ppYB1yWEhkPfTqT/RPSyOKU9yE1qzgGEuY=;
        b=Zs6GmnufgFX0JAsubWb1BQbY32ATR3LNVQsZMuEe/OeUZTJzPYhusNwgub4mBzxa7j
         /+XhqiEvT80LUHZtUJPhfL9IzryDYZwRVxGYxeieh4msVAf03FKx9aVrdgVfm7b8lVs2
         ggIKbmwHlJPhOrOjsz419dXD71WRC9KjIyVpi7wKMLe3BSMk1/Fp+qkJdMn2fxpO3J9A
         zsZ2PwAfTUKHFKHvmFCezlklliTwZEURQ7jAvorEMlJJSS2p7jTlX9BeoCoWWkK5Y0q3
         nc0rV3PR9BTVc+Y2fSBK38sPGUpi6P7LpXPHRM3BQaEjnngTAi+7H8Ba1VpDmYAmryTG
         UVRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768598831; x=1769203631;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n7irG7Pn8ppYB1yWEhkPfTqT/RPSyOKU9yE1qzgGEuY=;
        b=Pldi+t+kaEMIXMyY3cqYjT6W8aO4sB37jHv3MPde6JnRvrKXU9dYPsJuRJK72Tj8iu
         vM8gZ8rD7EyRhB5eAvF/aOu6W9y4/byHi9Z6a/aCVuCRPneCh7bnZrb6QdeI5VDedF2t
         eQOqpM37ODonLVEsGKgJkTOPd3YGmcbu15oXUhvs7dqDirsis9266ka+H5GSq0OC386g
         4Runhl1WyqbuMLd3cEglrQVKCV0LlRmBRtWp+glrm9QZAX6CrY+94H5zHL9J3/kFTgOV
         hdyng0q7BuEdphTfohwivsUbvD1gXJYUb4K84Ya59kHKoL6YJ8oeUufCA0i6WYbkpSwK
         6p3A==
X-Gm-Message-State: AOJu0Yy/Sx+jJFCgVuD7WOdXeAnqvlCgKkPVPb9Ffmjfq2TWIwAZrtQG
	C9xICxY4kiybb9UynnEGFykI3utW+3Hfpv34x9pCRfBvr8ccqSfS6zmn25wuIw==
X-Gm-Gg: AY/fxX7ySRUSjfiBdr1vxvmIaLC2nOB/AZFmDkQUGWhb6GyRn2vuLqnJN7DKktIpy85
	/atmK74lyBHkcrpZRbwniQSbot0N8ImO6JStRVDlAOM7Xd75AylJ9NtKcAku2gSBy+FmWbGmGOQ
	LATFMlZh/3DFTgLB8AXAAURUUeag+lASsc2DYAr2rR+OHYpanmlhPvQQM175tD5oqOo5pD8N91x
	fwlkMcN4+0rJqDr359wuhmGbFaLigoOSyqqmhkbsuoRySF/qanDzpsBt2X4j8dXngxgp9+Q1ezJ
	toOe+wwvMOzk3rSxN6a/TDpLIIR7TJasmABMSX8i0VB/lQRlT1w7w4FA788K6knEOIkZ60gqR6l
	f+aQAjXGeIBZ6SGu9zC3hL45FKhgBwsFJ+LntVZXjH7ZMX+C4fFNpgn7AGvjrceQYuG5cY8OpBo
	0O/Ej9iIyA1rfDmvEJlp8=
X-Received: by 2002:a05:600c:3555:b0:47e:e20e:bb9c with SMTP id 5b1f17b1804b1-4801e2f8e63mr56241625e9.8.1768598830908;
        Fri, 16 Jan 2026 13:27:10 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:1edb:411c:5531:1628])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801fe67780sm23382025e9.16.2026.01.16.13.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 13:27:10 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 0/7] refs: provide detailed error messages when using
 batched update
Date: Fri, 16 Jan 2026 22:27:05 +0100
Message-Id: <20260116-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v2-0-925a0e9c7f32@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACmtamkC/7WOQXLCMAxFr8J4jRg7gSR01Xt0WDiOYqtDbMYyK
 QyTu6Ok0yN052+9L72XYsyErD52L5VxJqYUJVT7nXLBRo9Ag2RV6arRxtTQ1DVk9Bl5ReGauMB
 A1kd5kINJ/q20fgJGuN05UPQQBXRpmqhA6r/RFYaSZMvIENAODKZtu6avdHc+WiWnbzKjx6b1d
 fnNfN+aq8tKBOKS8nPzns3K/Ske/0dxNqBhPI1db9ranbT59JOl60FK6rIsyxvwwPNZSgEAAA=
 =
X-Change-ID: 20260113-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-17786b20894a
In-Reply-To: <20260114-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v1-0-f5f8b173c501@gmail.com>
References: <20260114-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v1-0-f5f8b173c501@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
 Elijah Newren <newren@gmail.com>, gitster@pobox.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=16419;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=q9teHitVzH3iWQWdr/24LrI66qRP+WoO314w1y8KsiE=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGlqrSzEs15n1w4dXFAhoUZdCLp2iP5c6AUCm
 ZUPtIjom3z0L4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpaq0sAAoJED7VnySO
 Rox/s54L/3Dx+CqsKUDPsefqRLJWEDt/0RC57JkskGAVb2COg9rpzu7+lIFLvc/1OJg+OdOkhV5
 LWzcUaLA9xRkLTFf2nihHhyCCML9aJoIEjJ3iRMxcAyx8wW427ECFD8LALLkOJG8yXt7Jw3rx3d
 Bei6sdrlBKZtaCTt7JMQtkKq4VsbjYswMEFb4Av7XfF/meVyozQu6tXcy8Q4BH8ZHsHFRAtqS14
 Vyo0XOoUrgQzHQ4Puz763+Akhj+Wq2BgL7tCBJL09rmQ3hbpd+4uU5ZitdOmIqpxVuEC0GiaaH4
 vZYxKfvtrhBZS50y0JwEMEhxkJ0ruYGO5NCYwX0MQGHTDughwzwZigqqrKHUdIvSsR3t9Ti1fqT
 wPNZfXsttUFv/gtjB3+6mH9qZam5dq5pCFkyN471AGFISBfXuVw79/+o0pCcK9mqXwOWN5oihpq
 CBSJDXTnl0PrfLxwV9l9Dw1Cub3/Db3Jy7pWd+KKaLrdMb6xe7hENtnv7rf/Cj96nbuAlH3eJB8
 yY=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The refs namespace uses an error buffer to capture details about failed
reference updates. However when we added batched update support to
reference transactions, these messages were never propagated, instead
only an error code pertaining to the type of failure was propagated.

Currently, there are three regions which utilize batched updates:

  - git update-ref --batch-updates
  - git fetch
  - git receive-pack

While 'git update-ref --batch-updates' was a newly introduced flag, both
'git fetch' and 'git receive-pack' were pre-existing. Before using
batched updates, they provided more detailed error messages to the user,
but this changed with the introduction of batched updates. This is a
regression in their workings.

This patch series fixes this, by passing the detailed error message and
utilizing it whenever available. The regression was reported by Elijah
Newren [1] and based on the patch submitted by Jeff King [2].

[1]: https://lore.kernel.org/all/CABPp-BGL2tJR4dPidQuFcp-X0_VkVTknCY-0Zgo=jHVGv_P=wA@mail.gmail.com/
[2]: https://lore.kernel.org/all/20251224081214.GA1879908@coredump.intra.peff.net/

---
Changes in v2:
- Updates to the commit messages to be more descriptive.
- Instead of passing the char pointer for the error description, pass
  the 'strbuf' itself. This makes the API a lot cleaner to deal with.
  Also avoids having to remember to reset the strbuf after usage.
- Chalk out a separate commit for using a 'goto next_ref' in
  `refs_verify_refnames_available()`. This makes the intention much
  clearer.
- For git-update-ref(1), keep the existing implementation as is and only
  output the detailed error message to stderr.
- For git-receive-pack(1), use 'rp_error()' for detailed error message
  while keeping the current implementation as is.
- Added a separate patch to handle missing information in git-fetch(1)'s
  status table. This involves delaying updates to the end, where update
  success/failure information is available. I'm not too confident about
  this approach though, we could also drop it from the series and I
  could pick that up independently. This is still 1.19 ± 0.02 times
  faster than non-batched version (v2.50.0) in the files backend.
- Link to v1: https://patch.msgid.link/20260114-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v1-0-f5f8b173c501@gmail.com

---
 builtin/fetch.c         | 188 ++++++++++++++++++++++++++++++++++++++++--------
 builtin/receive-pack.c  |   7 +-
 builtin/update-ref.c    |   7 +-
 refs.c                  |  48 +++++++------
 refs.h                  |   1 +
 refs/files-backend.c    |   5 +-
 refs/packed-backend.c   |  12 ++--
 refs/refs-internal.h    |   4 +-
 refs/reftable-backend.c |   5 +-
 t/t1400-update-ref.sh   |  71 ++++++++++--------
 t/t5510-fetch.sh        |   8 +--
 t/t5516-fetch-push.sh   |  16 +++++
 t/t5574-fetch-output.sh |  16 ++---
 13 files changed, 280 insertions(+), 108 deletions(-)

Karthik Nayak (7):
      refs: drop unnecessary header includes
      refs: skip to next ref when current ref is rejected
      refs: add rejection detail to the callback function
      update-ref: utilize rejected error details if available
      fetch: utilize rejected ref error details
      receive-pack: utilize rejected ref error details
      fetch: delay user information post committing of transaction

Range-diff versus v1:

1:  806ec3de6e ! 1:  75b7b2f83d refs: remove unused header
    @@ Metadata
     Author: Karthik Nayak <karthik.188@gmail.com>
     
      ## Commit message ##
    -    refs: remove unused header
    +    refs: drop unnecessary header includes
     
    -    Some of the headers in 'refs.c' are no longer required, let's remove
    -    them.
    +    The 'sigchain.h' header isn't being used and can be removed.
    +
    +    Similarly, 'run-command.h' serves no direct purpose here. While it gets pulled in transitively through 'hook.h', we can still drop the explicit include for clarity.
     
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
2:  6ba3b9da56 ! 2:  507906091c refs: attach rejection details to updates
    @@ Metadata
     Author: Karthik Nayak <karthik.188@gmail.com>
     
      ## Commit message ##
    -    refs: attach rejection details to updates
    +    refs: skip to next ref when current ref is rejected
     
    -    The implementation of batched updates in 23fc8e4f61 (refs: implement
    -    batch reference update support, 2025-04-08) added rejection error codes
    -    to each reference update. This allowed batching of updates, however
    -    while each rejection is linked to a rejection code, the already present
    -    user readable error message is simply dropped.
    +    In `refs_verify_refnames_available()` we have two nested loops: the
    +    outer loop iterates over all references to check, while the inner loop
    +    checks for filesystem conflicts for a given ref by breaking down its
    +    path.
     
    -    Make necessary changes to ensure that the rejection detail is also added
    -    to the reference update. In upcoming commits, we'll utilize this field
    -    to provide better error message to users, namely in:
    +    With batched updates, when we detect a filesystem conflict, we mark the
    +    update as rejected and execute 'continue'. However, this only skips to
    +    the next iteration of the inner loop, not the outer loop as intended.
    +    This causes the same reference to be repeatedly rejected. Fix this by
    +    using a goto statement to skip to the next reference in the outer loop.
     
    -      - git update-ref --batch-updates
    -      - git fetch
    -      - git receive-pack
    -
    -    We move the error message creation right above
    -    `ref_transaction_maybe_set_rejected()`, so that the error message is
    -    available and also reset the error message if utilized to avoid
    -    un-expected concatination.
    -
    -    Co-authored-by: Jeff King <peff@peff.net>
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
      ## refs.c ##
    @@ refs.c: void ref_transaction_free(struct ref_transaction *transaction)
      				       size_t update_idx,
     -				       enum ref_transaction_error err)
     +				       enum ref_transaction_error err,
    -+				       const char *details)
    ++				       struct strbuf *details)
      {
      	if (update_idx >= transaction->nr)
      		BUG("trying to set rejection on invalid update index");
    @@ refs.c: int ref_transaction_maybe_set_rejected(struct ref_transaction *transacti
      			   transaction->updates[update_idx]->refname, 0);
      
      	transaction->updates[update_idx]->rejection_err = err;
    -+	if (details)
    -+		transaction->updates[update_idx]->rejection_details = xstrdup(details);
    ++	transaction->updates[update_idx]->rejection_details = strbuf_detach(details, NULL);
      	ALLOC_GROW(transaction->rejections->update_indices,
      		   transaction->rejections->nr + 1,
      		   transaction->rejections->alloc);
    @@ refs.c: enum ref_transaction_error refs_verify_refnames_available(struct ref_sto
      				if (transaction && ref_transaction_maybe_set_rejected(
      					    transaction, *update_idx,
     -					    REF_TRANSACTION_ERROR_NAME_CONFLICT)) {
    -+					    REF_TRANSACTION_ERROR_NAME_CONFLICT, err->buf)) {
    ++					    REF_TRANSACTION_ERROR_NAME_CONFLICT, err)) {
      					strset_remove(&dirnames, dirname.buf);
      					strset_add(&conflicting_dirnames, dirname.buf);
     -					continue;
    -+					strbuf_reset(err);
    -+					goto next;
    ++					goto next_ref;
      				}
      
     -				strbuf_addf(err, _("'%s' exists; cannot create '%s'"),
    @@ refs.c: enum ref_transaction_error refs_verify_refnames_available(struct ref_sto
      				if (transaction && ref_transaction_maybe_set_rejected(
      					    transaction, *update_idx,
     -					    REF_TRANSACTION_ERROR_NAME_CONFLICT)) {
    -+					    REF_TRANSACTION_ERROR_NAME_CONFLICT, err->buf)) {
    ++					    REF_TRANSACTION_ERROR_NAME_CONFLICT, err)) {
      					strset_remove(&dirnames, dirname.buf);
     -					continue;
    -+					strbuf_reset(err);
    -+					goto next;
    ++					goto next_ref;
      				}
      
     -				strbuf_addf(err, _("cannot process '%s' and '%s' at the same time"),
    @@ refs.c: enum ref_transaction_error refs_verify_refnames_available(struct ref_sto
      			}
      		}
     @@ refs.c: enum ref_transaction_error refs_verify_refnames_available(struct ref_store *refs
    + 				if (skip &&
      				    string_list_has_string(skip, iter->ref.name))
      					continue;
    - 
     +				strbuf_addf(err, _("'%s' exists; cannot create '%s'"),
     +					    iter->ref.name, refname);
    -+
    + 
      				if (transaction && ref_transaction_maybe_set_rejected(
      					    transaction, *update_idx,
     -					    REF_TRANSACTION_ERROR_NAME_CONFLICT))
     -					continue;
    -+					    REF_TRANSACTION_ERROR_NAME_CONFLICT, err->buf)) {
    -+					strbuf_reset(err);
    -+					goto next;
    -+				}
    ++					    REF_TRANSACTION_ERROR_NAME_CONFLICT, err))
    ++					goto next_ref;
      
     -				strbuf_addf(err, _("'%s' exists; cannot create '%s'"),
     -					    iter->ref.name, refname);
    @@ refs.c: enum ref_transaction_error refs_verify_refnames_available(struct ref_sto
      				    transaction, *update_idx,
     -				    REF_TRANSACTION_ERROR_NAME_CONFLICT))
     -				continue;
    -+				    REF_TRANSACTION_ERROR_NAME_CONFLICT, err->buf)) {
    -+				strbuf_reset(err);
    -+				goto next;
    -+			}
    ++				    REF_TRANSACTION_ERROR_NAME_CONFLICT, err))
    ++				goto next_ref;
      
     -			strbuf_addf(err, _("cannot process '%s' and '%s' at the same time"),
     -				    refname, extra_refname);
      			goto cleanup;
      		}
    -+next:;
    ++next_ref:;
      	}
      
      	ret = 0;
    @@ refs/files-backend.c: static int files_transaction_prepare(struct ref_store *ref
      					  err);
      		if (ret) {
     -			if (ref_transaction_maybe_set_rejected(transaction, i, ret)) {
    +-				strbuf_reset(err);
     +			if (ref_transaction_maybe_set_rejected(transaction, i,
    -+							       ret, err->buf)) {
    - 				strbuf_reset(err);
    ++							       ret, err)) {
      				ret = 0;
    - 
    +-
    + 				continue;
    + 			}
    + 			goto cleanup;
     
      ## refs/packed-backend.c ##
     @@ refs/packed-backend.c: static enum ref_transaction_error write_with_updates(struct packed_ref_store *re
    @@ refs/packed-backend.c: static enum ref_transaction_error write_with_updates(stru
      					ret = REF_TRANSACTION_ERROR_CREATE_EXISTS;
      
     -					if (ref_transaction_maybe_set_rejected(transaction, i, ret)) {
    +-						strbuf_reset(err);
     +					if (ref_transaction_maybe_set_rejected(transaction, i,
    -+									       ret, err->buf)) {
    - 						strbuf_reset(err);
    ++									       ret, err)) {
      						ret = 0;
      						continue;
    + 					}
     @@ refs/packed-backend.c: static enum ref_transaction_error write_with_updates(struct packed_ref_store *re
      						    oid_to_hex(&update->old_oid));
      					ret = REF_TRANSACTION_ERROR_INCORRECT_OLD_VALUE;
      
     -					if (ref_transaction_maybe_set_rejected(transaction, i, ret)) {
    +-						strbuf_reset(err);
     +					if (ref_transaction_maybe_set_rejected(transaction, i,
    -+									       ret, err->buf)) {
    - 						strbuf_reset(err);
    ++									       ret, err)) {
      						ret = 0;
      						continue;
    + 					}
     @@ refs/packed-backend.c: static enum ref_transaction_error write_with_updates(struct packed_ref_store *re
      					    oid_to_hex(&update->old_oid));
      				ret = REF_TRANSACTION_ERROR_NONEXISTENT_REF;
      
     -				if (ref_transaction_maybe_set_rejected(transaction, i, ret)) {
    +-					strbuf_reset(err);
     +				if (ref_transaction_maybe_set_rejected(transaction, i,
    -+								       ret, err->buf)) {
    - 					strbuf_reset(err);
    ++								       ret, err)) {
      					ret = 0;
      					continue;
    + 				}
     
      ## refs/refs-internal.h ##
     @@ refs/refs-internal.h: struct ref_update {
    @@ refs/refs-internal.h: int refs_read_raw_ref(struct ref_store *ref_store, const c
      				       size_t update_idx,
     -				       enum ref_transaction_error err);
     +				       enum ref_transaction_error err,
    -+				       const char *details);
    ++				       struct strbuf *details);
      
      /*
       * Add a ref_update with the specified properties to transaction, and
    @@ refs/reftable-backend.c: static int reftable_be_transaction_prepare(struct ref_s
      					    &head_referent, &referent, err);
      		if (ret) {
     -			if (ref_transaction_maybe_set_rejected(transaction, i, ret)) {
    +-				strbuf_reset(err);
     +			if (ref_transaction_maybe_set_rejected(transaction, i,
    -+							       ret, err->buf)) {
    - 				strbuf_reset(err);
    ++							       ret, err)) {
      				ret = 0;
    - 
    +-
    + 				continue;
    + 			}
    + 			goto done;
3:  76f199b434 ! 3:  78d6220027 refs: add rejection detail to the callback function
    @@ Commit message
         field is unused, but will be integrated in the upcoming commits.
     
         Co-authored-by: Jeff King <peff@peff.net>
    +    Signed-off-by: Jeff King <peff@peff.net>
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
      ## builtin/fetch.c ##
4:  c05216bf9c < -:  ---------- update-ref: utilize rejected error details if available
-:  ---------- > 4:  6ca8a03f74 update-ref: utilize rejected error details if available
5:  bdfef1b20f = 5:  289282031d fetch: utilize rejected ref error details
6:  08b74e8077 ! 6:  d555777da0 receive-pack: utilize rejected ref error details
    @@ Commit message
         messages for failed referenced updates, the users were provided generic
         error messages based on the error type.
     
    -    Similar to the previous commit, switch to using detailed error messages
    -    if present for failed reference updates to fix this regression.
    -
    -    One downside of this is that the messages can be very verbose, for e.g.
    -    in the files backend, when trying to write a non-commit object to a
    -    branch, you would see:
    +    Now that the updates also contain detailed error message, propagate
    +    those to the client via 'rp_error'. The detailed error messages can be
    +    very verbose, for e.g. in the files backend, when trying to write a
    +    non-commit object to a branch, you would see:
     
            ! [remote rejected] 3eaec9ccf3a53f168362a6b3fdeb73426fb9813d ->
            branch (cannot update ref 'refs/heads/branch': trying to write
    @@ Commit message
     
         Reported-by: Elijah Newren <newren@gmail.com>
         Co-authored-by: Jeff King <peff@peff.net>
    +    Signed-off-by: Jeff King <peff@peff.net>
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
      ## builtin/receive-pack.c ##
    @@ builtin/receive-pack.c: static void ref_transaction_rejection_handler(const char
      {
      	struct strmap *failed_refs = cb_data;
      
    --	strmap_put(failed_refs, refname, (char *)ref_transaction_error_msg(err));
    -+	if (!details)
    -+		details = ref_transaction_error_msg(err);
    ++	if (details)
    ++		rp_error("%s", details);
     +
    -+	strmap_put(failed_refs, refname, (char *)details);
    + 	strmap_put(failed_refs, refname, (char *)ref_transaction_error_msg(err));
      }
      
    - static void execute_commands_non_atomic(struct command *commands,
     @@ builtin/receive-pack.c: static void execute_commands_non_atomic(struct command *commands,
      		}
      
-:  ---------- > 7:  640d09d408 fetch: delay user information post committing of transaction


base-commit: 8745eae506f700657882b9e32b2aa00f234a6fb6
change-id: 20260113-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-17786b20894a

Thanks
- Karthik

