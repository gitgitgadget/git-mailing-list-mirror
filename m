Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D7A1E5B97
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 13:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739971426; cv=none; b=KQEXXh8Ttq0fGn8j7viDJbZmFlPaKMPB2rwg8bvA4oVxD6RPiUvD02zsLHo8t2f+Y+NpSDjS58NwIYksFB2CoE2UmkEnL9FiplWXSN3dzzetmlutoTk3rB6X7Okgmm3sSoc7PFiuKggywiUaMG70Z07D/CBnIxt48g1O8Pf0PSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739971426; c=relaxed/simple;
	bh=QbK5tFNgKQbtu/1LRI+Dona96rcOn4/pGuxR404zum8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h9PFUl0BT7CJSaDZVUshhCCsKYXFnEjNUExMuupgt5/OBPjnW4hb8+Ck32+AG3hl4+Ngf4JxKgCaDCj0UxooZ6afitEvsJzSxDFZ7jwjShez19r7kmjfCLYb5IVuq7xgPANvvMKBLrE2kmI0FkMOGFVLkajt5RFJGPOrM+r0kQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=g5rNsc6x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fbD1i7t1; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="g5rNsc6x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fbD1i7t1"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 9EEDE114014D;
	Wed, 19 Feb 2025 08:23:43 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Wed, 19 Feb 2025 08:23:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739971423;
	 x=1740057823; bh=eRL7k4lOWqxoDtQJXZk6oE7yUxM/hrv6ZbD+OnGOWV4=; b=
	g5rNsc6xcgYPRpawDLopW9Gq6JPYg8UjMvfvhyfprsEZK4+NBRJGDlTC1nt6M62G
	TKQDf0Yxs93vZTFOU4uYzpuoQquWkN2aQSLirs0PorV7PqoZolZZO+KnQZDMCWn4
	EKdYrzmICwBQacIpn9hMDBcYzUqnf9dMBZ3PY9t/d5C5nu6cn1jO3wAF7NejHyvc
	bGbYPbfsImVQadsQht9V07BUr1PyHsmqF4QZvnoM4+pn7JmwRFLFE7sqwjwM2xlr
	B3/O/KuvW+DFiCqx5MyVix2V7lH0kmQP1fiaCoEpMidpunASOGDZMx1P6gn98Q+p
	nC9vaXe73imwHxgCyMrx1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739971423; x=
	1740057823; bh=eRL7k4lOWqxoDtQJXZk6oE7yUxM/hrv6ZbD+OnGOWV4=; b=f
	bD1i7t1iHRj83gYdqAFxoi3otwnN2I1/+S3KhaWtZVLiFYOhFENhoNvkDXPVz6Mm
	tyGRYDnyCRIZAO8PfOmRNu59+jBxADYWkKQtFGghiUKegSRSzrmpjP9+dSNM94LC
	zb9O9hT9TcVbwKsysqzGJDPlz8vmrcyM7TeMBizVYDW5zU8FYyihufRL55+bdEtA
	z4GX+Z9KSxaNX+1CaQQJ5r0O3V7DN9KseMx+WDtRvF7gR5aCxnS1WQAFaza+CTlR
	nVoL23e4yB+Sf8GbofMj1YMgXEJlpjerMnDDgkhYOcc68Izfe8ASjETBHRLXzwGX
	GipY3iPVSdEyyjBAW7wMg==
X-ME-Sender: <xms:X9u1Z652zUk2M09huKCV8EiA6jysO3dDD7WUmP7ps2Y96iQ3LgA1sg>
    <xme:X9u1Zz74eZmfUCTVhBpb6dsULvQuZVOph7RBhCkUtdkDvh_wyvieeWIQO4Y4kfyy2
    b1bVWqAS10FHxWCrQ>
X-ME-Received: <xmr:X9u1Z5e-foLcAN-NyRTM-JYydKDtJBdtrCGGBDzCK2lA0-ru69zNqVnt7kLT2X6Dj8lrXelwu3Vzv1jeCs7bVM-O0rvSXdLdEgftGl4xjJlenUA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeigeefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhi
    drohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehshhgvjhhirghluhhose
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohht
    hhhprghsthgvrdhnvghtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:X9u1Z3I8SlnBObN5twrYDL91kQWffRDufnnWDYmuC2llFQl71HL0OA>
    <xmx:X9u1Z-LsRYjKhJG2grVlZbWPoSiCd5NPlw2qfSRLyt64FnpQWBJMSQ>
    <xmx:X9u1Z4yE17V4Re4i_XuvVtnmiTkZQp0dVyjsyq1MLGMoXbNYNvnnvQ>
    <xmx:X9u1ZyLJhhkVtflvSCgXmkX8n4P-8JwYmv9PwGPPAcAHrsUV6ZByyA>
    <xmx:X9u1Z_oNapo46K9Qrlcn__W1YBfv_n0vIzOXvzINP-hf_qTe84L5CxzB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Feb 2025 08:23:41 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f3f0a9d7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 19 Feb 2025 13:23:39 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 19 Feb 2025 14:23:32 +0100
Subject: [PATCH v2 05/16] refs/reftable: batch refname availability checks
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250219-pks-update-ref-optimization-v2-5-e696e7220b22@pks.im>
References: <20250219-pks-update-ref-optimization-v2-0-e696e7220b22@pks.im>
In-Reply-To: <20250219-pks-update-ref-optimization-v2-0-e696e7220b22@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 shejialuo <shejialuo@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
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
2.48.1.683.gf705b3209c.dirty

