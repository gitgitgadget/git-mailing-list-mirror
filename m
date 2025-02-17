Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312DF2327A1
	for <git@vger.kernel.org>; Mon, 17 Feb 2025 15:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739807433; cv=none; b=Jmsrfsozv/H78W6SdJcR0sTy/7MezMU4F3DbgitMKnjLwFY8XzY50BzDzM/YZVnUpn8ylMSSjeGB5ZS8dwm9ecid0PmVhM7cV93aQanGlics+bLSPL9ZwZ5fSwXIzgVFnyzXVVAFqL8WSJYr2Bp//eKAWTxVZ5xCDKPDuBO/9t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739807433; c=relaxed/simple;
	bh=/QjHUxYfq1u4c6AQa1kSj63F2wRyztyNm3Fcc1Ohkgc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oqJx1YvJAeCklc+sjiIDS3cG+9hfMOcasTstQ/tD9gcLgV2UJmGH09nQ7v0swx2mCh0U9eTu4DvScXXpCvSTxnkJGK9drzVbSSg5z0i1ecB8Fgj/xA3JwlnodKvivL6ASDQEKHlcWzoyq13IC2mkqUoY5xZV7JTBgQFLGKM/iR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jm3lC32S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jAtOq5Cb; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jm3lC32S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jAtOq5Cb"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 122DA114018C;
	Mon, 17 Feb 2025 10:50:31 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 17 Feb 2025 10:50:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739807430;
	 x=1739893830; bh=5jnUOKOxc/qWmsir5F3qRrC8u/gkNvtLHHZHbFfcHp8=; b=
	jm3lC32SXxL27VE5PTZDEf3l9j7ARaQtcdShFlSSAxjsKYt6weguIX48J3p3dcR+
	U0+jiZ+OIjdhb5ZauxGlEiA8Qoa9ozL4T0fvGDCMVTxw0gfpnMhwaVUI1Xlpqy7X
	NPo/VtmxiqbiqTgZxYwTIwy/OQluWuMzbM//a7+kC0UYYDsIgkaQrrq1nsSZnbml
	TPBODV90N+sDQhKzwrRxEb1+2fS8U871TrHve80JSV2vwtTFLqCV26aA/G5fWZnr
	3Yxf4eprLzku/Az6KVgZrUH0taUKFPUrhuern3Zr6D7AakS72oqsBxayd+UjcX5j
	hHogOQ0KLtmFvKHfVuVEEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739807430; x=
	1739893830; bh=5jnUOKOxc/qWmsir5F3qRrC8u/gkNvtLHHZHbFfcHp8=; b=j
	AtOq5CbI5zH24mrW2sudvECsXIwXuWU5LxurEC4wAohAZvtk+VcLrKJsdkaO7G6R
	GTir8FyC4UOdqFFk3JOPSHX6qbXRaJCCUndmf4XAuCA9jEOpkdHM0VekUsjdJGr0
	QR/gXpzeXjwltEIg6JMi0HvCMdEd4HuCCNMj9OZDYtCvZAcnbn2wHhVEfnpIC6vK
	OkksxO81MbjE1os4Hf+qsgsYuBq4VzhKDr/jG7DTC1iPGjSGwXasYDmMuPnFEW7Z
	lLl6KOvruZBGeUT0pxfJXWvABEEkbdi6gFYl9kaLP7yUnQ7rHsObx96eQmM8/Zl2
	Fc0A4TZvel7tVxV6VEtXQ==
X-ME-Sender: <xms:xlqzZ8OfjeGWWdl32SYkd7xZG8Dj9cMrkbsjO-HH89eRkx_3OnlwAQ>
    <xme:xlqzZy9UkPD3EoQ2ttoad6TAvUGKETAGCDFG5TgEIqZ4dJOqEsKMTeX-_BLj0EL1y
    3Xca8L2wfWUCh_uEA>
X-ME-Received: <xmr:xlqzZzRqym2Iv-evjEfs1m-bMreGn7YFDVzdx4zQ6g64vsiw7lHsKOTBFEABfzOSVJTu3stQnVosoMlczUt2wvNIrHlX9GOd7yFclTpuhELOW9s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehkeekudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    tghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehsrghnug
    grlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehpvghf
    fhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:xlqzZ0tcbd_qsn08y1lUVgejyUEKzDH6E9hhSjHcIMBKjYrWoRm_BA>
    <xmx:xlqzZ0dy471kCSV7qM6cxA6CSh28oQprAiqXkPQx3iWULIgJqoaAxA>
    <xmx:xlqzZ40O3p7umL-jn7d04AiitdMA607dgj0jCy5bmM5BJBfkqTRceA>
    <xmx:xlqzZ49xOEiuixZk1mo3sHUjbzULCgo5_IPvPIdqNuuBXxLwQGthNw>
    <xmx:xlqzZ8R7_o8PHtDV9FdkDzH_8UTXaIExKnm0utgdC6j0ASW38Fzx08_9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Feb 2025 10:50:29 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8f51f704 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 17 Feb 2025 15:50:27 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 17 Feb 2025 16:50:19 +0100
Subject: [PATCH 05/14] refs/reftable: start using
 `refs_verify_refnames_available()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-pks-update-ref-optimization-v1-5-a2b6d87a24af@pks.im>
References: <20250217-pks-update-ref-optimization-v1-0-a2b6d87a24af@pks.im>
In-Reply-To: <20250217-pks-update-ref-optimization-v1-0-a2b6d87a24af@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

Refactor the "reftable" backend to batch the availability check for
refnames. This does not yet have an effect on performance as we
essentially still call `refs_verify_refname_available()` in a loop, but
this will change in subsequent commits.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/reftable-backend.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index d39a14c5a46..2a90e7cb391 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1069,6 +1069,7 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 		reftable_be_downcast(ref_store, REF_STORE_WRITE|REF_STORE_MAIN, "ref_transaction_prepare");
 	struct strbuf referent = STRBUF_INIT, head_referent = STRBUF_INIT;
 	struct string_list affected_refnames = STRING_LIST_INIT_NODUP;
+	struct string_list refnames_to_check = STRING_LIST_INIT_NODUP;
 	struct reftable_transaction_data *tx_data = NULL;
 	struct reftable_backend *be;
 	struct object_id head_oid;
@@ -1224,12 +1225,7 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 			 * can output a proper error message instead of failing
 			 * at a later point.
 			 */
-			ret = refs_verify_refname_available(ref_store, u->refname,
-							    &affected_refnames, NULL,
-							    transaction->flags & REF_TRANSACTION_FLAG_INITIAL,
-							    err);
-			if (ret < 0)
-				goto done;
+			string_list_append(&refnames_to_check, u->refname);
 
 			/*
 			 * There is no need to write the reference deletion
@@ -1379,6 +1375,13 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 		}
 	}
 
+	string_list_sort(&refnames_to_check);
+	ret = refs_verify_refnames_available(ref_store, &refnames_to_check, &affected_refnames, NULL,
+					     transaction->flags & REF_TRANSACTION_FLAG_INITIAL,
+					     err);
+	if (ret < 0)
+		goto done;
+
 	transaction->backend_data = tx_data;
 	transaction->state = REF_TRANSACTION_PREPARED;
 
@@ -1394,6 +1397,7 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 	string_list_clear(&affected_refnames, 0);
 	strbuf_release(&referent);
 	strbuf_release(&head_referent);
+	string_list_clear(&refnames_to_check, 0);
 
 	return ret;
 }

-- 
2.48.1.666.gff9fcf71b7.dirty

