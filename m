Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11C1177998
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 07:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732089110; cv=none; b=KhYASbmnDkuoetecGo1rUwzwN3syDgXEOJ+mk5c1EAuy8CvDlBgx8XUIWpwALT3+w/3CJMzIMBpZ27/604h5ePUkZF1CB8OwiDGDYx4O5m2uoApjG0Cx32Y8Kh+vn5KvQOc7f4z7OOgPph6xDF73J9bXIQ8qv3DzF/+cHdTHKIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732089110; c=relaxed/simple;
	bh=3J7uQFrO6gjysqbsK7BqMvQEgL/ArWPKbYRx0V0gw9c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E0pwy8PVVyZNnU5xdrne8bF27OhIUBP98NrATCNrtfp28tBwT1Q5nX9yQH08Rtx/ZrmJXjsJaV8klTyzkw6/WqX+FppTrDRrM1FbFiR9pW7E93c7QWlHPM3mynwGyve2zAujzYMhnCXRRGN5eWzLGK82T9t+VESLuYE+O1Oc+A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CuhoTv4k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XCLJOiVn; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CuhoTv4k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XCLJOiVn"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1E9501140127;
	Wed, 20 Nov 2024 02:51:48 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 20 Nov 2024 02:51:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732089108;
	 x=1732175508; bh=1sklWO3NEkz4dxsPXZC1eSFJKj3VtCjCBVaW4o5ulbM=; b=
	CuhoTv4k31xNB6AbD7b9nO/yDw4/+Bvp2MVNkoxtEiDRhFXZSZh8QRKTx3ucBXyF
	0pfecbDY6EoFsDWC1/ttJ4rB9AKVngHbRhdEr3DkOzAuau2tmUj+w6pY95Y+w3JD
	FIGx3LNcklCX1fXVntQ15eEzPKjomiTsLwDY8IU8oGiq+GvnOhObmGDrdXlZE6im
	kKZumFTot33xkYPYaWJz24AfkiENTJyM3UTlJ2dM5fn7KrAgYee4fdgz3Un7fZ+B
	fO7Bgas3yNYDQHneNPQc63FQ0bru733Q8v0YOjV2jhQgJZVtAn6+bNOa3KlIMX64
	M7IEUTUwbzIwvARooo4EIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732089108; x=
	1732175508; bh=1sklWO3NEkz4dxsPXZC1eSFJKj3VtCjCBVaW4o5ulbM=; b=X
	CLJOiVnsiDPvGLlkSgE+ATH3p0xPkhWl/dUZjeNs9CvtF1vcT5IhfnM4u4oaNuZv
	btz2rqe/+09qFhn8qHomrCEJPvHsZi1y19QUw5VXjb1cDmQIpqJGl2NO1SE7ZBiA
	uZP8hEAK6Xi2VNDP3TKoJhGPTHfH2mRHWVeY41AlKMqKqnGSptyGGJgjoZ6UibIN
	FdMnE+EIsForJWIg2lj1PE9NzCJaQccBVRXPzy4cw3ulLQDdDNrYofLMC1tJ8G5O
	fA6+kYNyTnXjs0l0vTm5rLKgaChtC2Dwl6BmjBnNs8wgtu088egz3FNzxLZOoeCr
	Z0LrPAYDj+KpumpD7w53w==
X-ME-Sender: <xms:E5U9Z9BRfwOw0pqQ5DwPjEqh9ysZndNHQAnE9_0Olnnw0Sr2eTDPpw>
    <xme:E5U9Z7jRbPRmjjss3YDD_ZoUr-Q2IlQddVkqm_7B5hzq7LC6WLxCSVa2JX5OViDYH
    SZ9KppNl-Kq5bRgXg>
X-ME-Received: <xmr:E5U9Z4nzwLPDGcmBlSOaNjmWHkkI1-c_Kr69V59TsA8MqVXv_Ro52grGHXvSanhdAxUfO7siyNnR39JEcrSyYjxWm7eC--nOxytB3jLK5adbyw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeefgddutdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghr
    thhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:FJU9Z3wzJHk5wHtIUgjxj87PmugkXu-NPt8P5R2nQbQMorbW7Q4gNg>
    <xmx:FJU9ZyQYP1V5VQ6G1qGKJE8xR1x32P-DSj0m1TU5N6CgAI5PihkXOg>
    <xmx:FJU9Z6Y7pPVCZRXCs1CQJInI6rs02DdMwSdwRF-_Mh7N2J-RKeBOmA>
    <xmx:FJU9ZzQbKojNSB9JjfRcDgg2pSv3erBUzBV-lCgI7WSo82xpi68flA>
    <xmx:FJU9Zwcw3kmjzsNAnK1DMyzXcV4McHz-FOwQf5jeG103b7oO4wKtoaqW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Nov 2024 02:51:47 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5cc8d89a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 20 Nov 2024 07:50:54 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 20 Nov 2024 08:51:33 +0100
Subject: [PATCH v2 04/10] refs/files: support symbolic and root refs in
 initial transaction
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241120-pks-refs-optimize-migrations-v2-4-a233374b7452@pks.im>
References: <20241120-pks-refs-optimize-migrations-v2-0-a233374b7452@pks.im>
In-Reply-To: <20241120-pks-refs-optimize-migrations-v2-0-a233374b7452@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

The "files" backend has implemented special logic when committing
the first transactions in an otherwise empty ref store: instead of
writing all refs as separate loose files, it instead knows to write them
all into a "packed-refs" file directly. This is significantly more
efficient than having to write each of the refs as separate "loose" ref.

The only user of this optimization is git-clone(1), which only uses this
mechanism to write regular refs. Consequently, the implementation does
not know how to handle both symbolic and root refs. While fine in the
context of git-clone(1), this keeps us from using the mechanism in more
cases.

Adapt the logic to also support symbolic and root refs by using a second
transaction that we use for all of the refs that need to be written as
loose refs.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/files-backend.c | 44 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 34 insertions(+), 10 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 3ed18475a72aa4798d15b2912c37b4caabd47aac..116d4259697b20583cb2db34ed47025e8781cd42 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2995,6 +2995,7 @@ static int files_transaction_finish_initial(struct files_ref_store *refs,
 	int ret = 0;
 	struct string_list affected_refnames = STRING_LIST_INIT_NODUP;
 	struct ref_transaction *packed_transaction = NULL;
+	struct ref_transaction *loose_transaction = NULL;
 
 	assert(err);
 
@@ -3040,6 +3041,7 @@ static int files_transaction_finish_initial(struct files_ref_store *refs,
 		if ((update->flags & REF_HAVE_OLD) &&
 		    !is_null_oid(&update->old_oid))
 			BUG("initial ref transaction with old_sha1 set");
+
 		if (refs_verify_refname_available(&refs->base, update->refname,
 						  &affected_refnames, NULL,
 						  err)) {
@@ -3048,26 +3050,48 @@ static int files_transaction_finish_initial(struct files_ref_store *refs,
 		}
 
 		/*
-		 * Add a reference creation for this reference to the
-		 * packed-refs transaction:
+		 * packed-refs don't support symbolic refs and root refs, so we
+		 * have to queue these references via the loose transaction.
 		 */
-		ref_transaction_add_update(packed_transaction, update->refname,
-					   update->flags & ~REF_HAVE_OLD,
-					   &update->new_oid, &update->old_oid,
-					   NULL, NULL, NULL);
+		if (update->new_target || is_root_ref(update->refname)) {
+			if (!loose_transaction) {
+				loose_transaction = ref_store_transaction_begin(&refs->base, 0, err);
+				if (!loose_transaction) {
+					ret = TRANSACTION_GENERIC_ERROR;
+					goto cleanup;
+				}
+			}
+
+			ref_transaction_add_update(loose_transaction, update->refname,
+						   update->flags & ~REF_HAVE_OLD,
+						   update->new_target ? NULL : &update->new_oid, NULL,
+						   update->new_target, NULL, NULL);
+		} else {
+			ref_transaction_add_update(packed_transaction, update->refname,
+						   update->flags & ~REF_HAVE_OLD,
+						   &update->new_oid, &update->old_oid,
+						   NULL, NULL, NULL);
+		}
 	}
 
-	if (packed_refs_lock(refs->packed_ref_store, 0, err)) {
+	if (packed_refs_lock(refs->packed_ref_store, 0, err) ||
+	    ref_transaction_commit(packed_transaction, err)) {
 		ret = TRANSACTION_GENERIC_ERROR;
 		goto cleanup;
 	}
+	packed_refs_unlock(refs->packed_ref_store);
 
-	if (ref_transaction_commit(packed_transaction, err)) {
-		ret = TRANSACTION_GENERIC_ERROR;
+	if (loose_transaction) {
+		if (ref_transaction_prepare(loose_transaction, err) ||
+		    ref_transaction_commit(loose_transaction, err)) {
+			ret = TRANSACTION_GENERIC_ERROR;
+			goto cleanup;
+		}
 	}
 
-	packed_refs_unlock(refs->packed_ref_store);
 cleanup:
+	if (loose_transaction)
+		ref_transaction_free(loose_transaction);
 	if (packed_transaction)
 		ref_transaction_free(packed_transaction);
 	transaction->state = REF_TRANSACTION_CLOSED;

-- 
2.47.0.274.g962d0b743d.dirty

