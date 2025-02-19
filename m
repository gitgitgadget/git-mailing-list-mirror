Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821361E833F
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 13:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739971427; cv=none; b=TVKk3WUp8pOShJRefkx/Sbw4u6j1HRRTIwXuWCXdvSlDCS5HZsG3Gml3/f28Rbtlb/INpELJ/pZ7PiRkBnrv6JlKplF4nCarOmL80C0a/NVXyQyuMuV8hhkfMpUKrlvbw+A4DxXbitKcYHdc3gYf1tPuYDzlDLadlAQRXwsr/o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739971427; c=relaxed/simple;
	bh=KGTDvgzWCy7V387a7wy3u8LPigTMU8ilVO1TKMlmgU8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P0EC/ZW0XqydYksAr0HIGheBshSntJC76VJoaQ4X40PRFGAoutJH/6M58lDu6zStK8cqugH5m7Pcexwz+sdY+icFp7aDmUYBQjwhgNP2j8txgv3KNBAQBwdAtu5NcLQ4b3gR57jICJfL6/HYrLfIn/FVnAjbj+B7V3tVrEnLs5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pzb6k52S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ldxj4N4a; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pzb6k52S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ldxj4N4a"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6D7172540140;
	Wed, 19 Feb 2025 08:23:44 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 19 Feb 2025 08:23:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739971424;
	 x=1740057824; bh=xDmwmr6/7jhpS/UjG+ExVyaJO2nAf5QK1uRkK0aZvQI=; b=
	pzb6k52SipdFQvSA1yEm3bSr9VCLKBiWx2PO6feSudv1LGidrNzU+1QiUlC7xaE+
	YOdLyJ0Wet5xkOWULD4NQt++tQcEP3gFc+0cBvvAyZv+MnebXVwEfWMOt0X2d85i
	//AsSgexJXfT0Mroa/ZRuzYLMuLEcaErEjJ5tWsCzBXl2PhRWwTvSRzGraWKfgaK
	caB7rjcC/jcI1zLWs2tBQyDMJqJu3jOxIUGMSVZyw9WSTh4qRnazjNM0F+g/WQWV
	x+tNupY3LNppbhkrcepDoMfvZ9ohscXbTtHTTctCKTFB8BaC1Av8lfvg1Tma7qxg
	2Z2FNUz6I3IC7sLNyOKRtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739971424; x=
	1740057824; bh=xDmwmr6/7jhpS/UjG+ExVyaJO2nAf5QK1uRkK0aZvQI=; b=L
	dxj4N4abgnsOmjohWlJgDd4/QkUXGD5lQQeFfW5g6C0qP+KwRG0d0dBR12F+1M/j
	o6Ew1verLxa0LmGtptKAPPvQrKYh+iKjRxfGtSzl828XZW0fAipFoYIB2eAA3IGA
	F0mraQNdZNHLezmzLTzNv/8BmPwmpk8NqlUF9HCX/+IAn3ydrXlWLuw5zweaMWfY
	UZgIs/vbAfVhvN362umY2eYkV3NgAmLTC/D5paCoCsbAnHWcg4rvevGi6F/I0ZZL
	N9mqbjlttx/n5zM0KriqOZXDmX2t29VLpnJKiPT1txFwFrUFI8M3p2iu0ObYphhL
	ifEwz/HQU/nwGR4Qz/1mQ==
X-ME-Sender: <xms:YNu1Z9w-sGWfxCZwvhh8_EjPGLPml-FYEbsGUfVKLMcsQfLnQk25uw>
    <xme:YNu1Z9SHSqdLVwUdvdyEKJWTXhGQxuRmlGcfBafwkZK5BzUGj_G8rVTLQPydrKt9F
    RDE4coNzyvAyMDdqA>
X-ME-Received: <xmr:YNu1Z3WllDcKCx6DwRZgMP2cKhGICqI0_Q6nfc6MKJdWVF1qoyMYcLauvIvb8CiEt8g2Fv74bcEtsuYGp6PR6TmHbnx7_CbrEx-CSMP-J4N3CSw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeigeefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshhh
    vghjihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthhopegthhhrihhstghoohhlse
    htuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhm
    rghilhdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhph
    grshhtvgdrnhgvthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:YNu1Z_j8sHkeQ0XH3uXLgbBIy1ddfRTU1aTOWSFA4IRH5QBuomoihQ>
    <xmx:YNu1Z_BJhlQ9yhdF_y1979oS9IqQJg_ARK7NRc3nGIhAoxWYigLFGw>
    <xmx:YNu1Z4K3wW2DIFknawNuherAAfvVfCUIw4frLfub_qrCjM9GFVEO4A>
    <xmx:YNu1Z-B_zyD3qHOuXwug4C1tlEcmrHW4tdeklOR25wwr81SGY0NTKQ>
    <xmx:YNu1ZxCvdQ0kPAGFYTTtIsZ8_PFHb6BoNsF3ehI0dcWnl7Cx9sfdBxXm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Feb 2025 08:23:42 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1b217499 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 19 Feb 2025 13:23:40 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 19 Feb 2025 14:23:33 +0100
Subject: [PATCH v2 06/16] refs/files: batch refname availability checks for
 normal transactions
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250219-pks-update-ref-optimization-v2-6-e696e7220b22@pks.im>
References: <20250219-pks-update-ref-optimization-v2-0-e696e7220b22@pks.im>
In-Reply-To: <20250219-pks-update-ref-optimization-v2-0-e696e7220b22@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 shejialuo <shejialuo@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

Same as the "reftable" backend that we have adapted in the preceding
commit to use batched refname availability checks we can also do so for
the "files" backend. Things are a bit more intricate here though, as we
call `refs_verify_refname_available()` in a set of different contexts:

  1. `lock_raw_ref()` when it hits either EEXISTS or EISDIR when creating
     a new reference, mostly to create a nice, user-readable error
     message. This is nothing we have to care about too much, as we only
     hit this code path at most once when we hit a conflict.

  2. `lock_raw_ref()` when it _could_ create the lockfile to check
     whether it is conflicting with any packed refs. In the general case,
     this code path will be hit once for every (successful) reference
     update.

  3. `lock_ref_oid_basic()`, but it is only executed when copying or
     renaming references or when expiring reflogs. It will thus not be
     called in contexts where we have many references queued up.

  4. `refs_refname_ref_available()`, but again only when copying or
     renaming references. It is thus not interesting due to the same
     reason as the previous case.

  5. `files_transaction_finish_initial()`, which is only executed when
     creating a new repository or migrating references.

So out of these, only (2) and (5) are viable candidates to use the
batched checks.

Adapt `lock_raw_ref()` accordingly by queueing up reference names that
need to be checked for availability and then checking them after we have
processed all updates. This check is done before we (optionally) lock
the `packed-refs` file, which is somewhat flawed because it means that
the `packed-refs` could still change after the availability check and
thus create an undetected conflict. But unconditionally locking the file
would change semantics that users are likely to rely on, so we keep the
current locking sequence intact, even if it's suboptmial.

The refactoring of `files_transaction_finish_initial()` will be done in
the next commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/files-backend.c | 42 +++++++++++++++++++++++++++++++-----------
 1 file changed, 31 insertions(+), 11 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 29f08dced40..6ce79cf0791 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -678,6 +678,7 @@ static void unlock_ref(struct ref_lock *lock)
  */
 static int lock_raw_ref(struct files_ref_store *refs,
 			const char *refname, int mustexist,
+			struct string_list *refnames_to_check,
 			const struct string_list *extras,
 			struct ref_lock **lock_p,
 			struct strbuf *referent,
@@ -855,16 +856,11 @@ static int lock_raw_ref(struct files_ref_store *refs,
 		}
 
 		/*
-		 * If the ref did not exist and we are creating it,
-		 * make sure there is no existing packed ref that
-		 * conflicts with refname:
+		 * If the ref did not exist and we are creating it, we have to
+		 * make sure there is no existing packed ref that conflicts
+		 * with refname. This check is deferred so that we can batch it.
 		 */
-		if (refs_verify_refname_available(
-				    refs->packed_ref_store, refname,
-				    extras, NULL, 0, err)) {
-			ret = TRANSACTION_NAME_CONFLICT;
-			goto error_return;
-		}
+		string_list_insert(refnames_to_check, refname);
 	}
 
 	ret = 0;
@@ -2569,6 +2565,7 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 			       struct ref_update *update,
 			       struct ref_transaction *transaction,
 			       const char *head_ref,
+			       struct string_list *refnames_to_check,
 			       struct string_list *affected_refnames,
 			       struct strbuf *err)
 {
@@ -2597,7 +2594,7 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 		lock->count++;
 	} else {
 		ret = lock_raw_ref(refs, update->refname, mustexist,
-				   affected_refnames,
+				   refnames_to_check, affected_refnames,
 				   &lock, &referent,
 				   &update->type, err);
 		if (ret) {
@@ -2811,6 +2808,7 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 	size_t i;
 	int ret = 0;
 	struct string_list affected_refnames = STRING_LIST_INIT_NODUP;
+	struct string_list refnames_to_check = STRING_LIST_INIT_NODUP;
 	char *head_ref = NULL;
 	int head_type;
 	struct files_transaction_backend_data *backend_data;
@@ -2898,7 +2896,8 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 		struct ref_update *update = transaction->updates[i];
 
 		ret = lock_ref_for_update(refs, update, transaction,
-					  head_ref, &affected_refnames, err);
+					  head_ref, &refnames_to_check,
+					  &affected_refnames, err);
 		if (ret)
 			goto cleanup;
 
@@ -2930,6 +2929,26 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 		}
 	}
 
+	/*
+	 * Verify that none of the loose reference that we're about to write
+	 * conflict with any existing packed references. Ideally, we'd do this
+	 * check after the packed-refs are locked so that the file cannot
+	 * change underneath our feet. But introducing such a lock now would
+	 * probably do more harm than good as users rely on there not being a
+	 * global lock with the "files" backend.
+	 *
+	 * Another alternative would be to do the check after the (optional)
+	 * lock, but that would extend the time we spend in the globally-locked
+	 * state.
+	 *
+	 * So instead, we accept the race for now.
+	 */
+	if (refs_verify_refnames_available(refs->packed_ref_store, &refnames_to_check,
+					   &affected_refnames, NULL, 0, err)) {
+		ret = TRANSACTION_NAME_CONFLICT;
+		goto cleanup;
+	}
+
 	if (packed_transaction) {
 		if (packed_refs_lock(refs->packed_ref_store, 0, err)) {
 			ret = TRANSACTION_GENERIC_ERROR;
@@ -2972,6 +2991,7 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 cleanup:
 	free(head_ref);
 	string_list_clear(&affected_refnames, 0);
+	string_list_clear(&refnames_to_check, 0);
 
 	if (ret)
 		files_transaction_cleanup(refs, transaction);

-- 
2.48.1.683.gf705b3209c.dirty

