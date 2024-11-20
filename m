Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1083716DEB5
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 07:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732089110; cv=none; b=i57fwWt98FmsT0Szu4AE2XdUSD8kBLrTxMFIZgEX4lWBLB9UALjdz4AVIRjQATfFX0+I4/1/tQcQ7W51DhcE/yJLIR+qr90dRF+lm63JQVGedfVOMschNNA96XG5HZF2HGTwGCxFMfnFTvmPQyGtYgq6xUuNJIASBaQXE4EdFZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732089110; c=relaxed/simple;
	bh=Pepx3LH8U9ZVq0n6YoeUvhNy5SredBeyUUxP4yWPI+Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U/O6DbffWyQWBDWeOa5QEHXuO8QCzgauwAMvt9rFiPJsJcEBGRLyYS4ec7yqs8m8yc5AtEcBWnOQ83UDUcuzml/Jp7sBcuijQr9b4rz/0Wzz5cse1Y89eGzgOx2PwT8rOEZdnCLxo1o7Wnoy4WHEazV9rhqLmZ/2R0f9JbHjFMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=I/v2FtII; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gure185K; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="I/v2FtII";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gure185K"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id F37681380136;
	Wed, 20 Nov 2024 02:51:45 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 20 Nov 2024 02:51:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732089105;
	 x=1732175505; bh=dAnXvoJakfVI3IWQKT2gVz337cthZNPJ7oeEViv46+c=; b=
	I/v2FtII2JYMgWjiqBEKRwUyBX/tXPeOaJpr8Vr5pADdQKiDS8n4KCyym+pgo/sV
	8NpA2skFJtSDPS+a1K2PdNIiB02O5053xglrKUesLlxWD2l45/N9aQwYomig1EP4
	W0AdNN7Hha2Mc8C8kNwp+KQwDH4rw6iQVbF6KVuBdW+e/lFx80pt9j0yWr6nF96B
	26Md4AfwvADGqgxGUmIvIbFmEQFLAHQGW8J3gbd0kbqJtX/bcD5KNX+zViyFoN/c
	rhMiS8NSFEmb7QmgQJQIXO4bSF1oCAJIti4kwCPJ4HdFn6knRUumb9KfO85cvcBi
	MJAR714EKxyk5OsWgwlfCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732089105; x=
	1732175505; bh=dAnXvoJakfVI3IWQKT2gVz337cthZNPJ7oeEViv46+c=; b=G
	ure185KEDM7NRYnxEzDO7qrVvkWa2m4Uu8pN2L/k9VJdAZNcmhirnjINmIDyO1Yo
	BE44nKFujwVtK+dNyNnIOmy5cM3sDwXYrxeNfShBkcbs6CtTskUw1gV0bD6hqDl3
	3m4No48QrWtBvPxMIvCRiRTYkUbHuKxW9FKq0p0oiGMUcFyoLQ7IPEBikXU+0ioY
	rw3CGfWlYa3YrXlGKm3TclLP6rFuSjbBmwlXsMhv/+erAElLkoZvAr3AXgm3Mr/V
	RvhN0ybPdjnFOQGkNcBsh6Akl6D4NLuCZEldUlzHlxgIyhtVPxfp9xSl7LeSmfin
	SSCqEKG2qDaO2TR5V9RKQ==
X-ME-Sender: <xms:EZU9Z38S42xYP7Nf7rn7oBd0mvV4QSc1tekCpTdtV92O7SiXgpuhjg>
    <xme:EZU9ZzsWV9YIiq26dmU5qjCemDjJ66vG6bfjknNOxAv0nA5ZfyTqzfkXVDzhPzFeb
    0V1BuTvGHg0EyIRlQ>
X-ME-Received: <xmr:EZU9Z1DR0SBg5FEXGbAwM4lHEn1vTcbyEUgbBBHXAdEdbNx1oZMWHsh4jLhB50DSzB39a2MZSi5ps7sHEtW__8LNYusGBLnFmqxCjMPwLfH1lA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeefgdduuddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehkrghr
    thhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:EZU9ZzdrBxZ7e7cOF-3jw5DCcoJdISWHkK9_beD28QI4jqg5MIJfjQ>
    <xmx:EZU9Z8PUc9CkAnVg8gz5zIvF3SQ7MG81cq9pW_AleRx15BKCuklENA>
    <xmx:EZU9Z1llI5HgrmQVwKBNBFwm7yRfWUASYAa0VXMvw_buvsAsUlUiQg>
    <xmx:EZU9Z2uuyafRZpnXIadtG4rLpQO2QFEowvJO8GOEmrjL7CTkleyjfg>
    <xmx:EZU9Zxq9B4RWdrsebMMkS-gnRziS5sjlunT6Nu58yW63KCz-ZGWG3ajZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Nov 2024 02:51:45 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c5d93b5d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 20 Nov 2024 07:50:52 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 20 Nov 2024 08:51:31 +0100
Subject: [PATCH v2 02/10] refs/files: move logic to commit initial
 transaction
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241120-pks-refs-optimize-migrations-v2-2-a233374b7452@pks.im>
References: <20241120-pks-refs-optimize-migrations-v2-0-a233374b7452@pks.im>
In-Reply-To: <20241120-pks-refs-optimize-migrations-v2-0-a233374b7452@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
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
2.47.0.274.g962d0b743d.dirty

