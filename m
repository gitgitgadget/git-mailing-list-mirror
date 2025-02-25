Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B228926281A
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 08:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740473769; cv=none; b=HD/XOzzVAoRZCD4IfAUvqdVP7pZS/Ub3nCxLCbEYBPE151nmK5DpR6dGXEXB9YbnMkKWnRSIc7Zq6u1lwQ5+PIV9Xz945vV4TQC8bKOxSuxPRuYuzplLaoHOcL6KdJKAX3YlBv6qyHS3PIwh0+kmAf7E/VKSKhprqdAUAoGT9zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740473769; c=relaxed/simple;
	bh=0zHcZOxDb0Kb/F5yBUHz9NgAYrwJG5JWT9P62FZIbZk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nGD1SSW1Lthq6AO9+Hxef1Pta6cqY9KEdwEwguZ8x8lC0UE1WDJtR3ABzNN6rn6snpqbXme514GRtuOtc9Wq0+DxljhD6U9lk9M586OawCRopS3gL4OCJEYvVSpHVLv4UIX9tQybYpnxrMNRlkYb3IUel589VDkWHME2T+HcOIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Y4g2sLBE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OkG82SfC; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Y4g2sLBE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OkG82SfC"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6CB6D25401B1;
	Tue, 25 Feb 2025 03:56:06 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 25 Feb 2025 03:56:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1740473766;
	 x=1740560166; bh=F1CNDRJSF1Zu32KpuOClz6Hlv2XNcnlaoeYzhIGELbg=; b=
	Y4g2sLBEyp53LBpWtypkXlmshxL2T8ShBQWYpl7hYQXQgzWixa3wcIs5r/GvHehc
	clcNKrSx+2/MQU+Qf/iEje8PWcVQxXfXYeP+2NOimhRC7tuwQS2hlNpbDbSJ39Ii
	aq9zkNZVKvxPxKjxySGCcOGONdqNGasCRIpTAtVLn13exFCRI21Egi92iB0oFiXz
	EloTIeOJP+m2PNA4GYgeGMIj+A74SAnpJu9EwBo4vhXU2O3gqnDTEOMUoheBCZph
	q4pELDn5v/5VFpx0nnFlRSlzxvDSyrJnjsPIL2wxhjYVIQzMf6vgBD2A6KAS2fo6
	Jnxs8CNqbXlUBJad4meBqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740473766; x=
	1740560166; bh=F1CNDRJSF1Zu32KpuOClz6Hlv2XNcnlaoeYzhIGELbg=; b=O
	kG82SfCnqkuR2QJPCgqCA+sP4kKd+jimWr9S7Ot08qA/nH1NoWDjBRNA+wDMAHTe
	2SxueaG7GJ42J928w77foCIn0zxf8EroaGnhFpd1aYIy3vzhJuFj/RF6jeYP0Hf6
	L2cEGCSadGeLy4Tf8Y1izOUDTzYft8RD5ywd45pwvtFC+PiOYICYn37VQVolZiVJ
	F0b/m3kexkDcDQ9BLEnjwIb+7BeD6+mKlE/Bi3bxdmZKKr8ranyrxMxl7ty3RMb+
	5gwE/2mlSoXbwGcIorrK8iNdfs7NRdpKH8LrnkOzpcU1LzNqcU/dkHhlX6keXAb0
	vEVXx/qEZapPl6S/jkSow==
X-ME-Sender: <xms:pYW9Z61cypi5sl5WdvCPBtkcCDpfAykKIlJOKdWUDcxGlDape3hz7Q>
    <xme:pYW9Z9H_3pqeDyZBFm57ZXqHhE4Qswc3ukjb5vDPofvYfenHTESEJN5dwtNv6uZgw
    PGLQ-ajSO7J3OUtfg>
X-ME-Received: <xmr:pYW9Zy4K1VRAbUlb07-tZMySs7ogzR7qmKnK_VAlqXEOO1hPgr42I9EjlcFjA_aX1nSax_3R5dm2VDrMzIe9uZe3GofpFwjZKS4VwO32Uk4Djw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekuddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthht
    ohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpth
    htohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesgh
    hmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:pYW9Z70VJhGJaEGj0gx8k1yBXOL_T8K0mybvBVEkzyKqFF22qd8Hrg>
    <xmx:pYW9Z9HTPrHQMcdX86sUKxlXTFGLmdujwxMOLQJKxAPyWMd14ZXY7A>
    <xmx:pYW9Z0-SoO2JvxmB5K8cl4v0-34gjm1CfL1qS7Yhx0G0mRJjsfBEhg>
    <xmx:pYW9ZynXQkaIB5FoFm7SYt7PUqfXLw9kFzKq1AGUcid4xtw7YGreHA>
    <xmx:poW9Z00gvE0hS6UurVuPLarJ9S_w1EmQoMi7x1dhEg9AFxMzN2NUfLex>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Feb 2025 03:56:04 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 78f9867b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 25 Feb 2025 08:56:02 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 25 Feb 2025 09:55:53 +0100
Subject: [PATCH v3 07/16] refs/files: batch refname availability checks for
 initial transactions
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-pks-update-ref-optimization-v3-7-77c3687cda75@pks.im>
References: <20250225-pks-update-ref-optimization-v3-0-77c3687cda75@pks.im>
In-Reply-To: <20250225-pks-update-ref-optimization-v3-0-77c3687cda75@pks.im>
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

This doesn't yet have an effect on performance as the underlying
logic simply calls This will improve performance when cloning a repository with
many references or when migrating references from any format to the
"files" format.

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
2.48.1.683.gf705b3209c.dirty

