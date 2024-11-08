Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905061E130F
	for <git@vger.kernel.org>; Fri,  8 Nov 2024 09:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731058509; cv=none; b=dgagqQCeXbNc0KUmUanLBu/2oXqe7B7RW+DToNR3mx/6FbRg62yuVJok780i0AmAHv2Rwt/8kLoHOSmN1P3XPOdEk3qjUZpEOh5UL7tzKljiKdOsnCGvPUMAs5ZVM8S9AgwFxiASKB+FAd6RbJ26efdlzVu+IRsP2vStambimJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731058509; c=relaxed/simple;
	bh=b24sB/ayPiDhUJXVWkrfSTpuqmHQ6Vj9mcPD+KBwDyM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mvOcnUvkFw9/NBp7Y2Ju0tRm96s6twjEpZZRZliGC6dQS4pFXswjfld/NEUfMLl0Mpj1axxtlg0LIIWEJzRadHE570JZV5+oigmWY4TG0gt5ezEIqj7FGQ4Vg04hoWEJfR9rsx20fJhL54LN0gbJUIh2L88uTPOTRfNy89STr5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=4Ly1V5oK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N5p22LSo; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="4Ly1V5oK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N5p22LSo"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 8519D114014E
	for <git@vger.kernel.org>; Fri,  8 Nov 2024 04:35:06 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 08 Nov 2024 04:35:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731058506;
	 x=1731144906; bh=+rHnhhcyCAD49M0kYbB3zhMdXTh4yxOKePn4YLg/MlQ=; b=
	4Ly1V5oK0WNIA274pYVP/Em7H3WWB7S9nlgzLjYZ2D6QGkJ4b3uxrd+HVXe9UFe9
	kNXPLq7GUvLQzvbWvc4DXmlhvLJgc+RfjQYJ63tYG4r8zqbVRV+ETmRGutpJ+aMO
	Jy0a7yBnGQgtJQcTieAE2QiPt8YnlEYFnAtwYZHMdUK7z7Cm7O8rp0YzYgUH7Db6
	mLXV5tKcndmdkl4HcWNZvi/sy9cA2G4u36cQKdl8NJn1nHp3vQFXbUGbpTymCgjB
	imVt4e6Ibk/AB1cjqtrVTTdvieK6b4jAhjIoPNCcWD1LptXEz0PWkr+h5SJ1tQpg
	uLdraY6SohvdMoBg/te8IQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731058506; x=
	1731144906; bh=+rHnhhcyCAD49M0kYbB3zhMdXTh4yxOKePn4YLg/MlQ=; b=N
	5p22LSoAAvHyI9EgkFldzFaAhjsUVx459WeMcgkidhn90MEJ/Kxij5QAnjueMW1s
	ZHjUnpX7EiHjPISdOC+gGdyg/Kih1FXAgGE9DWRPBT0TBCRCw90p5WQy/m9cBI4V
	b4gv6KDzxWm7qKNDJOAELeqopD7xAzDocxC6Cv34HzSrhGqfGvFTeb2jPXnUEN+T
	gg+sEHEGZNszc5xQrYK8rBwg59xvq3Vru9BoyMN/ZPtx1t0jLq4raGs/7PMlq7x8
	IjHONIlmJ5NFokRdrjjYFNcj+wgDBD3ylBeBUlos0dhrpwaZIufVUA6BPPpReNhe
	Kps6NVuOyiwFwglcRyh+A==
X-ME-Sender: <xms:StstZ3s3wrYn5BNfptT6XW8QeCV5SKtzFUOnkEBEPwB43eLmqDQtpQ>
    <xme:StstZ4c95GWbzL8EaFdXtbZyUxseXiThPEo3RVKnrJYqh3XORRb4VqFonJNJeBkj8
    PH7D6tn50sJUOCizg>
X-ME-Received: <xmr:StstZ6zUSTMvLevyQUPD-dBwMbPNc3ABDwVIpmW2L1z5ULwxtpA1v-oRxSg025WAe_Q7TqdpKXW7EgqkioeP9y88A7tadHJNJ3jEbUXp4F6M8pY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdeigddtvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffufggtg
    fgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvd
    ekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:StstZ2OB9aaRqpECBhz2AitDaHzPIzsLRGFC9z6-O97K29xqSJzETg>
    <xmx:StstZ3_NTgYZEmmeevxhzCMsipsn_LMdvHhqOI9TOILkjfkGzsJsEg>
    <xmx:StstZ2U1KJABiyT4qK58-O57gtkvulgrOoK2KmRMndSILAgAI3Dy_A>
    <xmx:StstZ4cL0cIqL3f2Qp7m0V1qBZJV6dTRoT8JpuoDH2FIchkJ2iJy2A>
    <xmx:StstZxk2qExIVsNJxyx1J70_akI8A6AiYTG6mGu0HUR6S9iqlgEBsICj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 8 Nov 2024 04:35:05 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0665eae7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 8 Nov 2024 09:34:35 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 08 Nov 2024 10:34:44 +0100
Subject: [PATCH 04/10] refs/files: support symbolic and root refs in
 initial transaction
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241108-pks-refs-optimize-migrations-v1-4-7fd37fa80e35@pks.im>
References: <20241108-pks-refs-optimize-migrations-v1-0-7fd37fa80e35@pks.im>
In-Reply-To: <20241108-pks-refs-optimize-migrations-v1-0-7fd37fa80e35@pks.im>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
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
2.47.0.229.g8f8d6eee53.dirty

