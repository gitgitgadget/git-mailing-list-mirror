Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3D92571A6
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 15:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741794983; cv=none; b=FG2l055Di8dpW48M3cuWb/K4r8kvbolgs9+iUW3HypQKQGMYE5qW1nmd2iEMkHWgfcciOtLD4zjWyt+wlmD6LxPJOqxtgmPkOV0e487zhYs42jPye4Y7+xRZWwJKaf1JmHXrAWrWhMW8tBv+5hPcgu/NnKOxGn+Ts8yobmOiWIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741794983; c=relaxed/simple;
	bh=ydhf6faLjUx358ZKxeoqdO6qcM0iDhSqsLPHqNc8N9Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pJVUGe2BsPrj0MjPeHdhyRQPshikJEcxqBhMX2WrZ2BGsMv/F865UCm7CLCI4VFSLjaAgHlpnG9DLWIEHTFhhPdF7AF1DW7+T6BTRWneJEA95H32iIxLvZ6Q3eYIJN50gVrYmHEZK9jqJPOMOIPNlYofWVKj1w0FTnA411ViK/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Hxh0wD3c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m4/ycQVo; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Hxh0wD3c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m4/ycQVo"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6DA442540278;
	Wed, 12 Mar 2025 11:56:21 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Wed, 12 Mar 2025 11:56:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741794981;
	 x=1741881381; bh=dDLePwdbVU1ZlvsNM94bf6NVDVXMvKfsV5EV+vtUfUs=; b=
	Hxh0wD3cgBM+EUhqi1JbWls/oZUYgRCvJHtmIuOvbYPorvWrFQ97LhSVOXdttytx
	CeFfaKYzyuPzoVs/ojvjJQGfizj2rphMlNpS4lw1b7ycyeGj1wfNKkDUdwRJ0kP/
	npO3qJYL7FstFqVK3JxwQjwrSyK3Uk6mNb+y+M59j5k6aGQWyObMgnBsxy2l9NqN
	NzldL/5+917gsMwsq/khiOjAJGMUXXMXW0Ct+zxbBm5+1vQnJCNTtx7jf6jvphFa
	ASI+rV6CNJ/M5xJJbUBboKtlceXUiVYg1mjwl57B4LPJ1qiZMdKtE1Pg1c/WPdWb
	Kkxde7Lbq5Dc5A+pbE39Zw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741794981; x=
	1741881381; bh=dDLePwdbVU1ZlvsNM94bf6NVDVXMvKfsV5EV+vtUfUs=; b=m
	4/ycQVosV2IdXiVkQ0Rv7MvcDcAoQtFkg3kolqkdborbbr27b0dNmXNXgWm+yotO
	Gf4DDnaoq64NjqxJDzea0oLamroRjzfgsgV6k1z5Eug758c+UYri7WSxnHw1RVi4
	mxUIYPak7D2iRA8JWWGXrW1kZhy6CnDC7nt7VwzR1DBwk0mX5slk55kODr7VbIcv
	KktRLUWhweaKcl9GWbm+JZWs1in1JBUlS21ceDU6/blpZh8VDsFfllK67e/qfkHk
	xkYL/+uHG/40cXH+Suc6HhVVVpiglr9NjurdKnDl525sIGx/V+c2sGogMqx+9DzA
	Xb/NxW7OAqlzMa5HNeamg==
X-ME-Sender: <xms:pa7RZ3KNYVTtmnojhJ63Fg2BeiFEp90weQhMy-1Npqw3a3CN3kHHMg>
    <xme:pa7RZ7LBqxsH0DGWszXXev2i5PyR0PT1AJRF_iHcHPExgCMXvyKJMJYMilYM53mLV
    xVziX3RUxGAwS1mmg>
X-ME-Received: <xmr:pa7RZ_u8n_tcc0A-kIwMlA7WyvGF12IAKoJ-X402K3hwQnGd0OU3zdiY3fNm9PoHRhM97r7U5n3Ge5iDgvSDqmW1Rui00dLDKF9X_b_Bm9-V9dHZPw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdehgeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgt
    phhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepshhhvghjihgrlhhuoh
    esghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtth
    hopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:pa7RZwZlFM1PisLm9RoDVeumPFtX1pxp55Zw1rxdyeeZtzVtI03fsw>
    <xmx:pa7RZ-YrPjbthN7n15gn8Ybb7w6clG3A3rnBt8GS2iAJQ9UEYVMN1w>
    <xmx:pa7RZ0Dx12BRtqZcUNYsux1DZ7fYrG6L_F-JF8Qa9V0p2x2-VrY8sg>
    <xmx:pa7RZ8bJTpi5jPJSEIW8s2AhjEW--MTMZVO7NRc5JRdsAKhdQNebxg>
    <xmx:pa7RZ24cMdUdmv0Cg3XzpKCswzW3VyxFZ44kjfR3_fPLENkbuRBrjDmZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Mar 2025 11:56:19 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 38399114 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Mar 2025 15:56:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 12 Mar 2025 16:56:13 +0100
Subject: [PATCH v6 07/16] refs/files: batch refname availability checks for
 initial transactions
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-pks-update-ref-optimization-v6-7-f778e0414f55@pks.im>
References: <20250312-pks-update-ref-optimization-v6-0-f778e0414f55@pks.im>
In-Reply-To: <20250312-pks-update-ref-optimization-v6-0-f778e0414f55@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 shejialuo <shejialuo@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

The "files" backend explicitly carves out special logic for its initial
transaction so that it can avoid writing out every single reference as
a loose reference. While the assumption is that there shouldn't be any
preexisting references, we still have to verify that none of the newly
written references will conflict with any other new reference in the
same transaction.

Refactor the initial transaction to use batched refname availability
checks. This does not yet have an effect on performance as we still call
`refs_verify_refname_available()` in a loop. But this will change in
subsequent commits and then impact performance when cloning a repository
with many references or when migrating references to the "files" format.

This will improve performance when cloning a repository with many
references or when migrating references from any format to the "files"
format once the availability checks have learned to optimize checks for
many references in a subsequent commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/files-backend.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index f798d8dae37..ab6f0af5502 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3056,6 +3056,7 @@ static int files_transaction_finish_initial(struct files_ref_store *refs,
 	size_t i;
 	int ret = 0;
 	struct string_list affected_refnames = STRING_LIST_INIT_NODUP;
+	struct string_list refnames_to_check = STRING_LIST_INIT_NODUP;
 	struct ref_transaction *packed_transaction = NULL;
 	struct ref_transaction *loose_transaction = NULL;
 
@@ -3105,11 +3106,7 @@ static int files_transaction_finish_initial(struct files_ref_store *refs,
 		    !is_null_oid(&update->old_oid))
 			BUG("initial ref transaction with old_sha1 set");
 
-		if (refs_verify_refname_available(&refs->base, update->refname,
-						  &affected_refnames, NULL, 1, err)) {
-			ret = TRANSACTION_NAME_CONFLICT;
-			goto cleanup;
-		}
+		string_list_append(&refnames_to_check, update->refname);
 
 		/*
 		 * packed-refs don't support symbolic refs, root refs and reflogs,
@@ -3145,8 +3142,19 @@ static int files_transaction_finish_initial(struct files_ref_store *refs,
 		}
 	}
 
-	if (packed_refs_lock(refs->packed_ref_store, 0, err) ||
-	    ref_transaction_commit(packed_transaction, err)) {
+	if (packed_refs_lock(refs->packed_ref_store, 0, err)) {
+		ret = TRANSACTION_GENERIC_ERROR;
+		goto cleanup;
+	}
+
+	if (refs_verify_refnames_available(&refs->base, &refnames_to_check,
+					   &affected_refnames, NULL, 1, err)) {
+		packed_refs_unlock(refs->packed_ref_store);
+		ret = TRANSACTION_NAME_CONFLICT;
+		goto cleanup;
+	}
+
+	if (ref_transaction_commit(packed_transaction, err)) {
 		ret = TRANSACTION_GENERIC_ERROR;
 		goto cleanup;
 	}
@@ -3167,6 +3175,7 @@ static int files_transaction_finish_initial(struct files_ref_store *refs,
 		ref_transaction_free(packed_transaction);
 	transaction->state = REF_TRANSACTION_CLOSED;
 	string_list_clear(&affected_refnames, 0);
+	string_list_clear(&refnames_to_check, 0);
 	return ret;
 }
 

-- 
2.49.0.rc2.394.gf6994c5077.dirty

