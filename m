Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A6A12C499
	for <git@vger.kernel.org>; Fri,  8 Nov 2024 09:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731058508; cv=none; b=Z2vOEX7rHble9KHGCANjDCytlhjpCR0tH6XiSdqGBqWgW9SlHdaT+fyLwEJsHQhpjTOWrde1qO5xjnmNe5miz2knV2uuinWEQ3gQrWqVr2WhO0mvNd/OydOXDlDrlX6tHzWmjG1fPiGte846RZ8o4wSFWONxfN/WW33y+T+MkuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731058508; c=relaxed/simple;
	bh=5Sf8+GAO/ybuJ71f8/TyD8ET3rm66tqaWTZwJpLDeik=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oafrWJ+Of9iJK9b/Fpfr4LP6br1C0UaiQ+3xYRVOFERAg4rOu1hbMHIWaTMzZiOW2S1Ix2FP2oBc0ZiiEhv1CUxeEO7oO+flUBCAvBmKHGchm6sjLWnDRVf6nQW2w2vIZ0vpX05e756aX1a4RzNIneAzKrmHw9ZC9fCJsHlqjEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=wIFZrVnZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JEFkwSPx; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="wIFZrVnZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JEFkwSPx"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 768BD2540161
	for <git@vger.kernel.org>; Fri,  8 Nov 2024 04:35:05 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Fri, 08 Nov 2024 04:35:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731058505;
	 x=1731144905; bh=97UzccRSzctPzDNP2DGdAd0+iBWr3bGP6+89vfnURzE=; b=
	wIFZrVnZdW40Otss1+f030s5ZNk5KTWqOE8KLC0m8jpu4rVWlDpekxA0bIL/7fa2
	lIxO2bO/usvtN21qEAwVS9IuKSUVE97md1of0Ag6o+m1xCoQ9to8qEkJ2tSZ27xq
	B7EmpObC75uw/wh4AaKt/3xlSqP9t3+HXrqqgS3JkFbtrjfipYb+BeWWSmaF02t3
	eby7FKHpItI5QvyXozDf+JbE4HqeS0hDT5UsNXAj4Tdw597wFHNIWwKERBdpqGm6
	ILXhnrWsU8KBnnEfmJuvEjjCeQiUzsY2dWqhN1SOKC8j+We9IuNPXMp6Th4IJCIF
	LG7k2JQOOgaW+vQC7RLnzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731058505; x=
	1731144905; bh=97UzccRSzctPzDNP2DGdAd0+iBWr3bGP6+89vfnURzE=; b=J
	EFkwSPxRU1/p5lf2M9196moiqVk5yi+yhUISVDs9SbxHJNbmXdnbRj1PSEyVkBRF
	D7UISA8xeEvqwMA1OF944NwB4HS2I/FppH8OzjqsqUvZBiUqLaZd+2QD57mAOE2P
	K+xiqW/Si3igcYFndZweGpI/T4DgIscVcYWycuXbMOt+e7hQ3djbmY1l/ChNL+px
	qOMbqTPmj5GK1BbJOSFpAqvK0MNaRjREz1zFPYMUuNRRWsBXgGu+5yTcfda1uiF7
	ay6sZAbaBhnmYqdshKlMEJyoMdhA85YwRbELoU4EZePWf2oVyxYy8vlfWntuBHjM
	JNH89Ro0Nnvwp3qgPqajg==
X-ME-Sender: <xms:SdstZ0_EMOUSaMgJtf_XIc_0qbPNp3JVo-_wO5YlEiokVGNeM0IG8w>
    <xme:SdstZ8ur7ChMcDnKxKvpf8dQhfnjFoJBw0PLKiVbTxQ4e8ZAD9DYSeTPdeW4GVdi_
    nSy0bHROleZtMs5-w>
X-ME-Received: <xmr:SdstZ6DfoW9vjdy9im-r3uA9KfzzGINfQrWqTMJ1RJZjo8AuUPaOK7p4jIoXKyTtAHbfkzinASm9mqildvDVN7s_OEZFoiRGYS86z_Z7a8B7LcI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdeigddtvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffufggtg
    fgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvd
    ekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:SdstZ0djOSMatBBkg6ZMo43u1XK5s3wP6laRiLV02WDJ-SaRyz3XlQ>
    <xmx:SdstZ5PTWOJZDaBn2EWJXrgeHZ8_x9tdNuOoR2Io0k9dyEv7R3CAQw>
    <xmx:SdstZ-nDUjQ2xhglHnJGt75RKhV7lfmhox6vm-OtAHwIXgobulCm3Q>
    <xmx:SdstZ7tRqr4mF4XU5GWqWuuVGCFAlTTwxyQqcty5E_2QgJZGBi2ZiA>
    <xmx:SdstZ33wqLyRcOutCRaCNx3auBBLpjYGajA1xjIBj-63QecjcbyTT-61>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 8 Nov 2024 04:35:04 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2e0f93f6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 8 Nov 2024 09:34:33 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 08 Nov 2024 10:34:42 +0100
Subject: [PATCH 02/10] refs/files: move logic to commit initial transaction
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241108-pks-refs-optimize-migrations-v1-2-7fd37fa80e35@pks.im>
References: <20241108-pks-refs-optimize-migrations-v1-0-7fd37fa80e35@pks.im>
In-Reply-To: <20241108-pks-refs-optimize-migrations-v1-0-7fd37fa80e35@pks.im>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
X-Mailer: b4 0.14.2

Move the logic to commit initial transactions such that we can start to
call it in `files_transaction_finish()` in a subsequent commit without
requiring a separate function declaration.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/files-backend.c | 202 +++++++++++++++++++++++++--------------------------
 1 file changed, 101 insertions(+), 101 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index df61057c9f24972b72644407cc95057891338d96..f37c805a34167b3749fbe724788180975abdae90 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2975,6 +2975,107 @@ static int parse_and_write_reflog(struct files_ref_store *refs,
 	return 0;
 }
 
+static int ref_present(const char *refname, const char *referent UNUSED,
+		       const struct object_id *oid UNUSED,
+		       int flags UNUSED,
+		       void *cb_data)
+{
+	struct string_list *affected_refnames = cb_data;
+
+	return string_list_has_string(affected_refnames, refname);
+}
+
+static int files_initial_transaction_commit(struct ref_store *ref_store,
+					    struct ref_transaction *transaction,
+					    struct strbuf *err)
+{
+	struct files_ref_store *refs =
+		files_downcast(ref_store, REF_STORE_WRITE,
+			       "initial_ref_transaction_commit");
+	size_t i;
+	int ret = 0;
+	struct string_list affected_refnames = STRING_LIST_INIT_NODUP;
+	struct ref_transaction *packed_transaction = NULL;
+
+	assert(err);
+
+	if (transaction->state != REF_TRANSACTION_OPEN)
+		BUG("commit called for transaction that is not open");
+
+	/* Fail if a refname appears more than once in the transaction: */
+	for (i = 0; i < transaction->nr; i++)
+		string_list_append(&affected_refnames,
+				   transaction->updates[i]->refname);
+	string_list_sort(&affected_refnames);
+	if (ref_update_reject_duplicates(&affected_refnames, err)) {
+		ret = TRANSACTION_GENERIC_ERROR;
+		goto cleanup;
+	}
+
+	/*
+	 * It's really undefined to call this function in an active
+	 * repository or when there are existing references: we are
+	 * only locking and changing packed-refs, so (1) any
+	 * simultaneous processes might try to change a reference at
+	 * the same time we do, and (2) any existing loose versions of
+	 * the references that we are setting would have precedence
+	 * over our values. But some remote helpers create the remote
+	 * "HEAD" and "master" branches before calling this function,
+	 * so here we really only check that none of the references
+	 * that we are creating already exists.
+	 */
+	if (refs_for_each_rawref(&refs->base, ref_present,
+				 &affected_refnames))
+		BUG("initial ref transaction called with existing refs");
+
+	packed_transaction = ref_store_transaction_begin(refs->packed_ref_store,
+							 transaction->flags, err);
+	if (!packed_transaction) {
+		ret = TRANSACTION_GENERIC_ERROR;
+		goto cleanup;
+	}
+
+	for (i = 0; i < transaction->nr; i++) {
+		struct ref_update *update = transaction->updates[i];
+
+		if ((update->flags & REF_HAVE_OLD) &&
+		    !is_null_oid(&update->old_oid))
+			BUG("initial ref transaction with old_sha1 set");
+		if (refs_verify_refname_available(&refs->base, update->refname,
+						  &affected_refnames, NULL,
+						  err)) {
+			ret = TRANSACTION_NAME_CONFLICT;
+			goto cleanup;
+		}
+
+		/*
+		 * Add a reference creation for this reference to the
+		 * packed-refs transaction:
+		 */
+		ref_transaction_add_update(packed_transaction, update->refname,
+					   update->flags & ~REF_HAVE_OLD,
+					   &update->new_oid, &update->old_oid,
+					   NULL, NULL, NULL);
+	}
+
+	if (packed_refs_lock(refs->packed_ref_store, 0, err)) {
+		ret = TRANSACTION_GENERIC_ERROR;
+		goto cleanup;
+	}
+
+	if (initial_ref_transaction_commit(packed_transaction, err)) {
+		ret = TRANSACTION_GENERIC_ERROR;
+	}
+
+	packed_refs_unlock(refs->packed_ref_store);
+cleanup:
+	if (packed_transaction)
+		ref_transaction_free(packed_transaction);
+	transaction->state = REF_TRANSACTION_CLOSED;
+	string_list_clear(&affected_refnames, 0);
+	return ret;
+}
+
 static int files_transaction_finish(struct ref_store *ref_store,
 				    struct ref_transaction *transaction,
 				    struct strbuf *err)
@@ -3123,107 +3224,6 @@ static int files_transaction_abort(struct ref_store *ref_store,
 	return 0;
 }
 
-static int ref_present(const char *refname, const char *referent UNUSED,
-		       const struct object_id *oid UNUSED,
-		       int flags UNUSED,
-		       void *cb_data)
-{
-	struct string_list *affected_refnames = cb_data;
-
-	return string_list_has_string(affected_refnames, refname);
-}
-
-static int files_initial_transaction_commit(struct ref_store *ref_store,
-					    struct ref_transaction *transaction,
-					    struct strbuf *err)
-{
-	struct files_ref_store *refs =
-		files_downcast(ref_store, REF_STORE_WRITE,
-			       "initial_ref_transaction_commit");
-	size_t i;
-	int ret = 0;
-	struct string_list affected_refnames = STRING_LIST_INIT_NODUP;
-	struct ref_transaction *packed_transaction = NULL;
-
-	assert(err);
-
-	if (transaction->state != REF_TRANSACTION_OPEN)
-		BUG("commit called for transaction that is not open");
-
-	/* Fail if a refname appears more than once in the transaction: */
-	for (i = 0; i < transaction->nr; i++)
-		string_list_append(&affected_refnames,
-				   transaction->updates[i]->refname);
-	string_list_sort(&affected_refnames);
-	if (ref_update_reject_duplicates(&affected_refnames, err)) {
-		ret = TRANSACTION_GENERIC_ERROR;
-		goto cleanup;
-	}
-
-	/*
-	 * It's really undefined to call this function in an active
-	 * repository or when there are existing references: we are
-	 * only locking and changing packed-refs, so (1) any
-	 * simultaneous processes might try to change a reference at
-	 * the same time we do, and (2) any existing loose versions of
-	 * the references that we are setting would have precedence
-	 * over our values. But some remote helpers create the remote
-	 * "HEAD" and "master" branches before calling this function,
-	 * so here we really only check that none of the references
-	 * that we are creating already exists.
-	 */
-	if (refs_for_each_rawref(&refs->base, ref_present,
-				 &affected_refnames))
-		BUG("initial ref transaction called with existing refs");
-
-	packed_transaction = ref_store_transaction_begin(refs->packed_ref_store,
-							 transaction->flags, err);
-	if (!packed_transaction) {
-		ret = TRANSACTION_GENERIC_ERROR;
-		goto cleanup;
-	}
-
-	for (i = 0; i < transaction->nr; i++) {
-		struct ref_update *update = transaction->updates[i];
-
-		if ((update->flags & REF_HAVE_OLD) &&
-		    !is_null_oid(&update->old_oid))
-			BUG("initial ref transaction with old_sha1 set");
-		if (refs_verify_refname_available(&refs->base, update->refname,
-						  &affected_refnames, NULL,
-						  err)) {
-			ret = TRANSACTION_NAME_CONFLICT;
-			goto cleanup;
-		}
-
-		/*
-		 * Add a reference creation for this reference to the
-		 * packed-refs transaction:
-		 */
-		ref_transaction_add_update(packed_transaction, update->refname,
-					   update->flags & ~REF_HAVE_OLD,
-					   &update->new_oid, &update->old_oid,
-					   NULL, NULL, NULL);
-	}
-
-	if (packed_refs_lock(refs->packed_ref_store, 0, err)) {
-		ret = TRANSACTION_GENERIC_ERROR;
-		goto cleanup;
-	}
-
-	if (initial_ref_transaction_commit(packed_transaction, err)) {
-		ret = TRANSACTION_GENERIC_ERROR;
-	}
-
-	packed_refs_unlock(refs->packed_ref_store);
-cleanup:
-	if (packed_transaction)
-		ref_transaction_free(packed_transaction);
-	transaction->state = REF_TRANSACTION_CLOSED;
-	string_list_clear(&affected_refnames, 0);
-	return ret;
-}
-
 struct expire_reflog_cb {
 	reflog_expiry_should_prune_fn *should_prune_fn;
 	void *policy_cb;

-- 
2.47.0.229.g8f8d6eee53.dirty

