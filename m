Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945042AE8B
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 06:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732516050; cv=none; b=csSwfMSW/0NvfpMKAjs2XeRGKw0B8JqwTYe+ypafRJ7tBVNVe8fytffQ4kGTL4Z8Fj4vAvVHgrGGpkM5gTodI8j5m9ep/W5eoO8WK7huVUZ7V39xql3AyExcgLc6IsSZhBBPh+5jYiLjMiV0nV3Sb4rUkMaGrIxU2JG0b3lucU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732516050; c=relaxed/simple;
	bh=Pepx3LH8U9ZVq0n6YoeUvhNy5SredBeyUUxP4yWPI+Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nSg9bZhz5BK6O3KMCLbu7F2uGt+V8LEjxZdgis6KzvQt/iC5VHXg1grLVwmaYbF8b149eaP6/TOiBdh1zx6/YB0TzvdejxY3Bddi4WcbjrwH5WWjLWEyRv/T+Pkk+rD2tZ3MW97HLCz8Lv9zH4AF/NjtuZb/a9akM9k7YFJsK4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qAVPyztW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KTYtL0as; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qAVPyztW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KTYtL0as"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 94E54254017D;
	Mon, 25 Nov 2024 01:27:27 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 25 Nov 2024 01:27:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732516047;
	 x=1732602447; bh=dAnXvoJakfVI3IWQKT2gVz337cthZNPJ7oeEViv46+c=; b=
	qAVPyztW8ndE61B2rk9lR3/YSYkRq/7Wn4ev8IZU3mSguMd2VwygpZHtMixFi5zy
	w3byPL/z8rywHNfCYX1JO9lirczOzBw7RFqEIvsI1fJ/iwwhEfZXD2KHWpFHnlBC
	JcA7hklf/+bESgzu7XppbZiYdMrckAyewiY0robKemwMr4T3S8ekN+59QJwBwMXl
	+mVf0CmRiWkB/rJbsepo+iR4youcnJpTvJ7X31GR6BMf7JBTf/VL1dKVtAgY5oSu
	ngRqKaAvAnUnRfzAALn0zxmmX+qn0IMdCuZnXm8bU1Z33pmDVgSWff6epdi1rF8i
	bioWdqJyCccYgW1itK9Wxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732516047; x=
	1732602447; bh=dAnXvoJakfVI3IWQKT2gVz337cthZNPJ7oeEViv46+c=; b=K
	TYtL0aseeR6eqPmUfz9pwZBPoSd0oaDK6x+JR08NfmQ5N89R3AWsIAH45TKktRIW
	zsN3of2yh8BUFO/bJjhl0wHUClXxanbUMxO3Di9S6mat5AYwe4PnzZuRlyATQs4b
	0bulVPKKI5sreLhSUZJLWrfhS+/ABiN3Ny5ZHpIfypFKbQAQZzN5VVWqtefTQ/tq
	Z0OrwD2gq/ci1AdTLPXVPkJ5CxWRNom9EvIiu+dLejo2taI1T7L6KtGZ0PiOGZk2
	uSqeJCGs5gXSBKzft/Vr6pKMP0NjLArE+UVqP6GJX6PnLfOedNkbnvZcPOi9WVUK
	NRbb3ew/eV+W26hhpKImw==
X-ME-Sender: <xms:zhhEZ_B8OCoQCbPuNDkUJWx_Zls9Qdu10fCF7TIssrWY1c81l6rerg>
    <xme:zhhEZ1jugk-zfknvH2N7-iVxv8bSYez2ESEb8Shgx-A0zY_aCIDe6cQB3IKADcaY3
    ZTjUr4pmS4g57-4Vg>
X-ME-Received: <xmr:zhhEZ6njYn3n_QSJvaiC3j0c8Rbfeffpgz2NtefIJ9udpb2sEKy0fbWpY3qyqkLLGG37XdWjDff-3theOiuxshTONwdh88AD9H1KTNCuGjfW7g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeggdelfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidroh
    hrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohep
    khgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehkrhhishhtoh
    hffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:zxhEZxwxVO6OI5IHPf-mmoajUgja84jogz3RyUNchskd1nudCmd1wQ>
    <xmx:zxhEZ0TVC-joIBczVNSIQg8EHubkSKInoTGg9wxRy1d3cnm2PbbMMQ>
    <xmx:zxhEZ0aCO4IUO3XIwQaUaHS9Sj9QQeeUGSID7DeWdRsYAiLlX8AylA>
    <xmx:zxhEZ1TthikoY-7q0MpCZD76L9gDWCfL9CSLV6x9VXyQsdPA0BwZxQ>
    <xmx:zxhEZ5KXu927joXbyQLxFobj6KNvfpg2idlZbZH4p2k3vW-nD-Q51EjR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Nov 2024 01:27:25 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8c0ab0f3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Nov 2024 06:26:23 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 25 Nov 2024 07:27:07 +0100
Subject: [PATCH v3 02/10] refs/files: move logic to commit initial
 transaction
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-pks-refs-optimize-migrations-v3-2-17bc85e33ad7@pks.im>
References: <20241125-pks-refs-optimize-migrations-v3-0-17bc85e33ad7@pks.im>
In-Reply-To: <20241125-pks-refs-optimize-migrations-v3-0-17bc85e33ad7@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Christian Couder <chriscool@tuxfamily.org>
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

