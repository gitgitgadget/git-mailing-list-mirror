Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4FC17ADF7
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 07:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732089113; cv=none; b=uP3IU67jilcAwFe3vmoHlb5BE86zpl8pomDA2xEpPLuLKUk5TmN9UHTlOVgzGIDPOR7GzZ4t2ZwlI4bVf5N7gWUnF3lSu8YfC1qvMff60i1PjHEU27LVQsKkIHn+QAEaSxXmv656XJDomH0/70mBYHZIt1N7MLzOFUbAmTbLh1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732089113; c=relaxed/simple;
	bh=rV/ayJMQqy1VTZNLTAYHf5RlmRVTZkqkO0R+WZT58kQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MZ7+NUvqas8cG3eMrhr2pDoKPy+3Ij5ZNLkCKikj6KatJcqh7M78dAFklVpxcK1smHvseJtYYE4tCvUkIaixnOCoEHm+IdTplYiesH4OHLfzu8RlCNCMAVZn7sZksxjTI1GTWP6QsB9Tpu86Xk/886ghMJIsfKih6X8EzlUnyXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=yd8J6or7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=4hcxVmrr; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="yd8J6or7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="4hcxVmrr"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 870661140161;
	Wed, 20 Nov 2024 02:51:50 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Wed, 20 Nov 2024 02:51:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732089110;
	 x=1732175510; bh=4WRYV6VkDRVG10Mre7cofsGY2beUvcfYEv2hjp7qS0c=; b=
	yd8J6or7XmzgdGt/6Wd7BSJnGlEAL8ozVDft+xXMB1DtsyoPXo4dpwy9l+VaN9yG
	DGeHB+nzMfICBFTJyaXMLdEhezHLLR+r4LtikaJ4ywOvPvw7X9269SVhRWsseugJ
	v9ZIRgsPu3UASY+6zrmLvMR7bEV5Xw8CAoLZD5GaLjWC3RZiQsN7GPk0XWJTnERS
	/gopnuk8xXweEV2qLk+P7xQRTwHc4Sh8shfKn1ZGLdj0CS4MpCoS0I08ItvRNT1J
	7aZqbuvHPJ3FtJxDRn/WRUQ63zKGnevA1ULjVUgtlDumZGWT0PU9mv4Au+xKBtev
	LnP6ljD29IXO6ay43otsSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732089110; x=
	1732175510; bh=4WRYV6VkDRVG10Mre7cofsGY2beUvcfYEv2hjp7qS0c=; b=4
	hcxVmrrOquzUSMb7Z7chYqAqmUKCcC5vBtVdKtB4ByV9UZqhNZJc5aRfblLs9lXX
	/Tw88nWIbpqksUcQmHJrzH//HDe8O7T6MHiNZyoTVVxtKICca/aJ6FkSbh4D0goT
	Wo7kvnnQmxwobTvrS1g5VQTDeUpgcbyTW4BdkUolFLZ8dlqzJfurr7miGuwb/Q5q
	x6uyNJopRbmigDE1raRIXUx2TrOIj0xLRxr+WXIAfd5VbamxTCxA12YqOXXOugW5
	VeT+N9xn8aSZfBr6d/pB5CYZ8KAcaIAd0hBpaLce0mHV6QqBwsWa9C94jgyQJ4cA
	ArtNF/+IuPd2Sy+fg516w==
X-ME-Sender: <xms:FpU9Z17JfKX-XGrxkyAF51gXzw0DdiFvjip_1Yx3dmUpmSkHXoWE9A>
    <xme:FpU9Zy5NqgG0P5txQoY3K4E17VzyCDBY4PX6NNIAA6xLaB1tn57lQOdT7irQuMlZ4
    1K7_CnjBfMlACu43Q>
X-ME-Received: <xmr:FpU9Z8eIorijZKiZjKnrw8Cu6GDXz87rGcdGHELxLvoIZs1MwNQ7-R6kGjpHqdV--Sy_CMdCsRNHetRSK7bTaCZHOkYje6q-aTXWN0Wz-Mu82w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeefgddutdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeefhfeugeelheefjeektdffhedvhfdvteefgfdtudff
    udevveetgeeuuedtkefhgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:FpU9Z-JybpJtxnWqgNRUeWp2hZJkLcfOqfbt0jPA6TASAv3kuziA9g>
    <xmx:FpU9Z5K62bSWQ3VN4cUqEpWkxevXrVh4mYGilymX9eMjgT4_eZBf-w>
    <xmx:FpU9Z3w40rlcKxIiCM7mWzEQKE6XbrYBNtL0Tp5ESR0oRj_6tlNH6g>
    <xmx:FpU9Z1IGLwotnXT7c9-1tmFWm0UXAi9mImD9tET6yyJX_v3RFHNWyA>
    <xmx:FpU9Z52xwpgEvXo-b_qwiMPAiXhbe9jFeoGYeNXuXq7al2meLqrPdyiy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Nov 2024 02:51:49 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id fca3c0d9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 20 Nov 2024 07:50:56 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 20 Nov 2024 08:51:35 +0100
Subject: [PATCH v2 06/10] refs: skip collision checks in initial
 transactions
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241120-pks-refs-optimize-migrations-v2-6-a233374b7452@pks.im>
References: <20241120-pks-refs-optimize-migrations-v2-0-a233374b7452@pks.im>
In-Reply-To: <20241120-pks-refs-optimize-migrations-v2-0-a233374b7452@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Reference transactions use `refs_verify_refname_available()` to check
for colliding references. This check consists of two parts:

  - Checks for whether multiple ref updates in the same transaction
    conflict with each other.

  - Checks for whether existing refs conflict with any refs part of the
    transaction.

While we generally cannot avoid the first check, the second check is
superfluous in cases where the transaction is an initial one in an
otherwise empty ref store. The check results in multiple ref reads as
well as the creation of a ref iterator for every ref we're checking,
which adds up quite fast when performing the check for many refs.

Introduce a new flag that allows us to skip this check and wire it up in
such that the backends pass it when running an initial transaction. This
leads to significant speedups when migrating ref storage backends. From
"files" to "reftable":

    Benchmark 1: migrate files:reftable (refcount = 100000, revision = HEAD~)
      Time (mean ± σ):     472.4 ms ±   6.7 ms    [User: 175.9 ms, System: 285.2 ms]
      Range (min … max):   463.5 ms … 483.2 ms    10 runs

    Benchmark 2: migrate files:reftable (refcount = 100000, revision = HEAD)
      Time (mean ± σ):      86.1 ms ±   1.9 ms    [User: 67.9 ms, System: 16.0 ms]
      Range (min … max):    82.9 ms …  90.9 ms    29 runs

    Summary
      migrate files:reftable (refcount = 100000, revision = HEAD) ran
        5.48 ± 0.15 times faster than migrate files:reftable (refcount = 100000, revision = HEAD~)

And from "reftable" to "files":

    Benchmark 1: migrate reftable:files (refcount = 100000, revision = HEAD~)
      Time (mean ± σ):     452.7 ms ±   3.4 ms    [User: 209.9 ms, System: 235.4 ms]
      Range (min … max):   445.9 ms … 457.5 ms    10 runs

    Benchmark 2: migrate reftable:files (refcount = 100000, revision = HEAD)
      Time (mean ± σ):      95.2 ms ±   2.2 ms    [User: 73.6 ms, System: 20.6 ms]
      Range (min … max):    91.7 ms … 100.8 ms    28 runs

    Summary
      migrate reftable:files (refcount = 100000, revision = HEAD) ran
        4.76 ± 0.11 times faster than migrate reftable:files (refcount = 100000, revision = HEAD~)

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c                    | 37 +++++++++++++++++++++----------------
 refs.h                    |  5 ++++-
 refs/files-backend.c      | 13 ++++++-------
 refs/reftable-backend.c   |  6 ++++--
 t/helper/test-ref-store.c |  2 +-
 5 files changed, 36 insertions(+), 27 deletions(-)

diff --git a/refs.c b/refs.c
index 0f10c565bbb4e0d91210c52a3221a224e4264d28..d690eb19b3fd7083a5309deb98738547e4f48040 100644
--- a/refs.c
+++ b/refs.c
@@ -2324,6 +2324,7 @@ int refs_verify_refname_available(struct ref_store *refs,
 				  const char *refname,
 				  const struct string_list *extras,
 				  const struct string_list *skip,
+				  int initial_transaction,
 				  struct strbuf *err)
 {
 	const char *slash;
@@ -2332,8 +2333,6 @@ int refs_verify_refname_available(struct ref_store *refs,
 	struct strbuf referent = STRBUF_INIT;
 	struct object_id oid;
 	unsigned int type;
-	struct ref_iterator *iter;
-	int ok;
 	int ret = -1;
 
 	/*
@@ -2363,7 +2362,8 @@ int refs_verify_refname_available(struct ref_store *refs,
 		if (skip && string_list_has_string(skip, dirname.buf))
 			continue;
 
-		if (!refs_read_raw_ref(refs, dirname.buf, &oid, &referent,
+		if (!initial_transaction &&
+		    !refs_read_raw_ref(refs, dirname.buf, &oid, &referent,
 				       &type, &ignore_errno)) {
 			strbuf_addf(err, _("'%s' exists; cannot create '%s'"),
 				    dirname.buf, refname);
@@ -2388,21 +2388,26 @@ int refs_verify_refname_available(struct ref_store *refs,
 	strbuf_addstr(&dirname, refname + dirname.len);
 	strbuf_addch(&dirname, '/');
 
-	iter = refs_ref_iterator_begin(refs, dirname.buf, NULL, 0,
-				       DO_FOR_EACH_INCLUDE_BROKEN);
-	while ((ok = ref_iterator_advance(iter)) == ITER_OK) {
-		if (skip &&
-		    string_list_has_string(skip, iter->refname))
-			continue;
+	if (!initial_transaction) {
+		struct ref_iterator *iter;
+		int ok;
 
-		strbuf_addf(err, _("'%s' exists; cannot create '%s'"),
-			    iter->refname, refname);
-		ref_iterator_abort(iter);
-		goto cleanup;
-	}
+		iter = refs_ref_iterator_begin(refs, dirname.buf, NULL, 0,
+					       DO_FOR_EACH_INCLUDE_BROKEN);
+		while ((ok = ref_iterator_advance(iter)) == ITER_OK) {
+			if (skip &&
+			    string_list_has_string(skip, iter->refname))
+				continue;
 
-	if (ok != ITER_DONE)
-		BUG("error while iterating over references");
+			strbuf_addf(err, _("'%s' exists; cannot create '%s'"),
+				    iter->refname, refname);
+			ref_iterator_abort(iter);
+			goto cleanup;
+		}
+
+		if (ok != ITER_DONE)
+			BUG("error while iterating over references");
+	}
 
 	extra_refname = find_descendant_ref(dirname.buf, extras, skip);
 	if (extra_refname)
diff --git a/refs.h b/refs.h
index 024a370554e013d66febee635e4c0415ba061fe6..980bd20cf24e15144aeff991eeba8b27a936d386 100644
--- a/refs.h
+++ b/refs.h
@@ -101,13 +101,16 @@ int refs_read_symbolic_ref(struct ref_store *ref_store, const char *refname,
  * both "foo" and with "foo/bar/baz" but not with "foo/bar" or
  * "foo/barbados".
  *
+ * If `initial_transaction` is truish, then all collision checks with
+ * preexisting refs are skipped.
+ *
  * extras and skip must be sorted.
  */
-
 int refs_verify_refname_available(struct ref_store *refs,
 				  const char *refname,
 				  const struct string_list *extras,
 				  const struct string_list *skip,
+				  int initial_transaction,
 				  struct strbuf *err);
 
 int refs_ref_exists(struct ref_store *refs, const char *refname);
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 116d4259697b20583cb2db34ed47025e8781cd42..d27806c02c272f8bddc789b509e3c3c7af4f75aa 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -706,7 +706,7 @@ static int lock_raw_ref(struct files_ref_store *refs,
 		 * reason to expect this error to be transitory.
 		 */
 		if (refs_verify_refname_available(&refs->base, refname,
-						  extras, NULL, err)) {
+						  extras, NULL, 0, err)) {
 			if (mustexist) {
 				/*
 				 * To the user the relevant error is
@@ -813,7 +813,7 @@ static int lock_raw_ref(struct files_ref_store *refs,
 							  REMOVE_DIR_EMPTY_ONLY)) {
 				if (refs_verify_refname_available(
 						    &refs->base, refname,
-						    extras, NULL, err)) {
+						    extras, NULL, 0, err)) {
 					/*
 					 * The error message set by
 					 * verify_refname_available() is OK.
@@ -850,7 +850,7 @@ static int lock_raw_ref(struct files_ref_store *refs,
 		 */
 		if (refs_verify_refname_available(
 				    refs->packed_ref_store, refname,
-				    extras, NULL, err)) {
+				    extras, NULL, 0, err)) {
 			ret = TRANSACTION_NAME_CONFLICT;
 			goto error_return;
 		}
@@ -1159,7 +1159,7 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 	 */
 	if (is_null_oid(&lock->old_oid) &&
 	    refs_verify_refname_available(refs->packed_ref_store, refname,
-					  NULL, NULL, err))
+					  NULL, NULL, 0, err))
 		goto error_return;
 
 	lock->ref_name = xstrdup(refname);
@@ -1538,7 +1538,7 @@ static int refs_rename_ref_available(struct ref_store *refs,
 
 	string_list_insert(&skip, old_refname);
 	ok = !refs_verify_refname_available(refs, new_refname,
-					    NULL, &skip, &err);
+					    NULL, &skip, 0, &err);
 	if (!ok)
 		error("%s", err.buf);
 
@@ -3043,8 +3043,7 @@ static int files_transaction_finish_initial(struct files_ref_store *refs,
 			BUG("initial ref transaction with old_sha1 set");
 
 		if (refs_verify_refname_available(&refs->base, update->refname,
-						  &affected_refnames, NULL,
-						  err)) {
+						  &affected_refnames, NULL, 1, err)) {
 			ret = TRANSACTION_NAME_CONFLICT;
 			goto cleanup;
 		}
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 8e914afc817f198bed3199630b430e179cabc740..bbc779ab410b41f00759a3a41a76dd708f115c90 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1097,7 +1097,9 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 			 * at a later point.
 			 */
 			ret = refs_verify_refname_available(ref_store, u->refname,
-							    &affected_refnames, NULL, err);
+							    &affected_refnames, NULL,
+							    transaction->flags & REF_TRANSACTION_FLAG_INITIAL,
+							    err);
 			if (ret < 0)
 				goto done;
 
@@ -1584,7 +1586,7 @@ static int write_copy_table(struct reftable_writer *writer, void *cb_data)
 	if (arg->delete_old)
 		string_list_insert(&skip, arg->oldname);
 	ret = refs_verify_refname_available(&arg->refs->base, arg->newname,
-					    NULL, &skip, &errbuf);
+					    NULL, &skip, 0, &errbuf);
 	if (ret < 0) {
 		error("%s", errbuf.buf);
 		goto done;
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index 65346dee551ccd781a88786f0c8465f60b286cde..240f6fc29d7f1bb20658deee467bcb46ac3407b2 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -199,7 +199,7 @@ static int cmd_verify_ref(struct ref_store *refs, const char **argv)
 	struct strbuf err = STRBUF_INIT;
 	int ret;
 
-	ret = refs_verify_refname_available(refs, refname, NULL, NULL, &err);
+	ret = refs_verify_refname_available(refs, refname, NULL, NULL, 0, &err);
 	if (err.len)
 		puts(err.buf);
 	return ret;

-- 
2.47.0.274.g962d0b743d.dirty

