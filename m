Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5923A14F9F7
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 06:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732516051; cv=none; b=GGDiaYCDj6rQz7JmB9z81SMrkE7wz5kxkM/CYjUBwUFmyT0nwLNluo9242rmwnnU/0Uoz/VIOwIdbvl2vTdg8Yp9HJuUC3K5KV+AXMo1aoVOO5E8pE6T0gccANtCZYzXux6CJ3K48ubLSdUCokdZ6gDAea8bkXjThhVKLht2O5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732516051; c=relaxed/simple;
	bh=3J7uQFrO6gjysqbsK7BqMvQEgL/ArWPKbYRx0V0gw9c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E1X5owAISvpzKedDW7/QHUDo52P9g0xau/4FCFenthaRz/POZr5U48xSeCPdJ8/8ql9v5bctwky8sfmc74MowqW4MtvfEFetLOdFrvc4ABrFhE3TdhBgOA0hecM+bEZy6ObIBhub5ZhNYC52YUXKi0Nmqn84IponV4HODIiiDuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=voBKRuFx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XJzwIMap; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="voBKRuFx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XJzwIMap"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 37AA32540181;
	Mon, 25 Nov 2024 01:27:29 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 25 Nov 2024 01:27:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732516049;
	 x=1732602449; bh=1sklWO3NEkz4dxsPXZC1eSFJKj3VtCjCBVaW4o5ulbM=; b=
	voBKRuFxlsiMyl11R3eYIX6+TtsortHQDJSIb13EYmtBSkgELpWj2VvqBSaqZSqw
	FKqyFXodNIp4TCzbR5LA3MZU2kPRJFwG+Vv/xDXsV4X2G5K9Yqw7mFqHVJci60D4
	UiK+egQa7sIv71pk4c3qzQH4a6/rX+fd0CsTCyt5QvGsPeQJ7VR2Bz8S+djJ1Y/W
	fpuW9l5imspXEieIYwmu8D7/NELfA8YcBg8a78tf/EHSeKN2h6uc1Mi6CGb1PIgd
	u8epw9VfuEqO/GXiL0S1KHNt/MlmbXPSCyVpDkl+4JcpkxYDT22mCZ5TiKQtAZIV
	J4MXogwACGrm/r+X7/n54Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732516049; x=
	1732602449; bh=1sklWO3NEkz4dxsPXZC1eSFJKj3VtCjCBVaW4o5ulbM=; b=X
	JzwIMapB61THhINLdkNdfJC2ObkthanZLESvaBbvYSlmpy+alP+OOsw6UChgNXGU
	xK5ydu1GYgTTY/pYUjYy0rsWMU49yTLCe+/wf4JFPikHvOJ32cnNtm7iWp8+JMCh
	NN/aww6JEN6uRQKnS8ULB1c876zm8eIUIEbosmkW+X4Aly6BEMmjK8UEdjI6kBpP
	q+BYssMQtvXatUN5mZ5wot+v38WaDy3elUbVF/42U85cZrYtxnuSFtYBq6qVA+jD
	lvEXQXkzH2DX5b3ppdbaIX/PMB09N02qjQvsR6gM/IC2sqaezKG94kdDWcpx8RBS
	yh63hDAyHmo3KDd8L+DOQ==
X-ME-Sender: <xms:0BhEZwgvYsG9nkf9Y0AT1e7jy1YSBTWR4aRokPNH3gvx8oHqbBSFgA>
    <xme:0BhEZ5BSZSDijuxtux8L2WFFe3FmpeC26HS17ob_ADrmNuNAJcTlocW5oxYsCCBF9
    _-7RRekPAkrO4Ydkg>
X-ME-Received: <xmr:0BhEZ4HfcceJIjmFTH3EDPnNH4GcKoaGV3IaBP2XWFIgc_hGnMNJ2PY4jNoC06REXZB4MW8pSRKx1tQ9zUxGkEA_XQfk9DZpnLJwhu_1hcGDDg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeggdelgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfh
    grshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhrihhs
    tghoohhlsehtuhigfhgrmhhilhihrdhorhhg
X-ME-Proxy: <xmx:0BhEZxR8GWi_8ZYJUm70yM1qWQZ4qnwEt0UJxrbf8HNdepnVrxmycA>
    <xmx:0BhEZ9yQBy_RQTaHIhLBJm19S72Z1r6xHSbqApR2BsTmXLBJBfs1bA>
    <xmx:0BhEZ_7xFKZVRJYk4x3aBoyrRrlT31J7WYevYbd-XPddOlwEvpkPjg>
    <xmx:0BhEZ6zOGlXHVtTd8Gjn7BEsE-RgC3MSoXKagJpxCdHJD1Gl8jZrpw>
    <xmx:0RhEZwpxqB-lFyK1Jx1YoO5xcz06Q6OgGb02ktyubeYzMMJr65Rv3M09>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Nov 2024 01:27:27 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 411eaa06 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Nov 2024 06:26:25 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 25 Nov 2024 07:27:09 +0100
Subject: [PATCH v3 04/10] refs/files: support symbolic and root refs in
 initial transaction
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-pks-refs-optimize-migrations-v3-4-17bc85e33ad7@pks.im>
References: <20241125-pks-refs-optimize-migrations-v3-0-17bc85e33ad7@pks.im>
In-Reply-To: <20241125-pks-refs-optimize-migrations-v3-0-17bc85e33ad7@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Christian Couder <chriscool@tuxfamily.org>
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

