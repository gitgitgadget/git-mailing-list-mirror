Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D12A20F075
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 15:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741273733; cv=none; b=kSMya6RLfn7hRPhy7SLeIRmvCW+lyIl2+cEH68yRi5deHFysTR4wgi5pcZzxad/q0OfLjM5hfMWIFFWCnaeVw+Esfwc2OiT65TJogOQiODaoQWRheJjIjQ23MvYn8m0Y8P5RjAg5+9APh4Dy+yy3sH7tSql+iFuiHpSFp6stD7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741273733; c=relaxed/simple;
	bh=+JLNqljak4qfGe2JPwUAvupebX0+qYevELT7CjUuBYY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DS5gQCxWUQ0KBBY0UocgY/RP2q9LauZjRDmL/8M0FeXQkYdMl2qnE0+/NKLbGoMBW4OiaE3XaXcG6bgq6cL/51zg/BGlcs0BS8bz/wLpN9QubDYoVFQEwltNZtkfmi0Wk/p7fRIlLbE6sdptQV3Q0ANGNeZTTdYP45OrbrfXt2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SdWpDAvv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T+XKm5Sg; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SdWpDAvv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T+XKm5Sg"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 60D01254016F;
	Thu,  6 Mar 2025 10:08:50 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 06 Mar 2025 10:08:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741273730;
	 x=1741360130; bh=ReK4dza0+5uQcJ0poVZRvn7ljPsV38euQD7J8wj4uWU=; b=
	SdWpDAvvCQplF6doYWdq2pC3up8cKqNwC1nwMRsTQ1Eu+kS/IGPC8rJNHw+n8Qvq
	q3bBRTsSIKh/+Ci5cr52ICo7Qtg1jNPGKE1vw03q/e6wt++8B6rfqnKlfJ7msbsz
	6EvTC8YmmyybV1oZfnwpmFSUeE1UNG8bX1BOLvetp15J914GkImWVxjmBbP2GYtb
	EkJU5c66Bhlso6lMCP3eT1eS6cezFVOmWLm9V4tahv4me3/uRV3N2YhhYygodyY3
	13C4GrsrmmdiBahVb/+DeyWaJ8XbMZAyx2brMkeXxAfpOeECwpwK+NluJQvOJ5ab
	bePZdOaL8eXlia5+EKiwZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741273730; x=
	1741360130; bh=ReK4dza0+5uQcJ0poVZRvn7ljPsV38euQD7J8wj4uWU=; b=T
	+XKm5SgNr3QpSrJhgS19/ovfVfu2dmVtBnZqYVDWK30HQYQ91tEE5/CfWi/HfAUK
	NqUWij38y5fU9Qq80Rgg8UsMQA3Y1OWG0SiA2gdq37ozf8rs/IjAUmyl8pBr9ReY
	CrDHVbQ7SfLVrb//czikj34okqp8Flb1S8D6QqCeKKWxwLHlafM65qNo7Q0tbHqH
	xLcFDh6T8cepnRyRWxWeMmn7EyPYeVfgTBM450cKD5HDB+1oE+et9w/g8vVP2Vgb
	Z0mZMJCJWPMjKrZgQhWO7o134CMHPh+a6aAOIcwBcl22/sBXGV9hZf17Qk7tnQCV
	dz0AG7grb8b0nO2lyGgjw==
X-ME-Sender: <xms:grrJZ-zMrId130gU6OmyP49MMCcRUUP3mj_Pwz-9sr2TLTqmxbDqCg>
    <xme:grrJZ6RkNd7LHy7K3wtp2arRpOu3kQuhWMkGuKpSPeeaIqFeMfhOomkwhAmuKbCZx
    0SE-dLZ4ww1Z5LzDg>
X-ME-Received: <xmr:grrJZwWKt4uwHyuvwUxlFZ1CqteRrOqBEAqOpQbLQlJvs7cEtzctKHuajgLAtnzijL8dSr5bA4DNhFs7aFHLb8AhT9yXFLMPgs7h5UcKE0E76g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdektdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoheptghhrhhishgtohholh
    esthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
    pdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtth
    hopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:grrJZ0iupTpfK0Unnn5KQ3dsWYGRIFBR2dCJGJYbuRjzPzSrbvLkWA>
    <xmx:grrJZwCpwymbtJG6S5VIGHV22plTq3W-a4o3_2FxIjfIIlhUwJn6tA>
    <xmx:grrJZ1KRC9_378ELmV3es9aROAQPm5PYrQ3ZiH0NPQFCP7vRgvQvrA>
    <xmx:grrJZ3AdsuKOgRWZzFlSzHRpyfA4MSQPqzUyTJpCYmEUKA-_k_vZpg>
    <xmx:grrJZ-BfEeMzoh4E_26MML85ZRMyFVLx8wPx2ldBVYTQzTRqyYjovhcj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Mar 2025 10:08:48 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 03b7f417 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Mar 2025 15:08:45 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 06 Mar 2025 16:08:38 +0100
Subject: [PATCH v5 07/16] refs/files: batch refname availability checks for
 initial transactions
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-pks-update-ref-optimization-v5-7-dcb2ee037e97@pks.im>
References: <20250306-pks-update-ref-optimization-v5-0-dcb2ee037e97@pks.im>
In-Reply-To: <20250306-pks-update-ref-optimization-v5-0-dcb2ee037e97@pks.im>
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
index 6ce79cf0791..11a620ea11a 100644
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
2.49.0.rc0.416.g627208d89d.dirty

