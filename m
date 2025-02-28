Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982CF25CC77
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 09:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740734814; cv=none; b=uM0SC3mI0glsMddrVy2b3YxVLk0xhNUhSNCB6X/PLqDyKuPIPreKuKEgjm3Rds+UC6dn4HSlQPlw7HUgnrY3YXmznAfRi6u9NEKFNjOMZFt5LWOgDA0upk7I6XxG9z7fwzSfvt2gxIizxxM3QEeOCxifW4Pkyxne+Ree3+o6XPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740734814; c=relaxed/simple;
	bh=QCbdxk4xA/J3XSfvzRqUnSrUaILXLVAiVxjeVqAtQJk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g5oht/s3C3S4o2eQPnrkXYTy7dJ5SZqiHNePJFDGLfX90A3KNtycemnFrKa7P/Sb0wN6+FiFYlXLi0yxhE4MdJs4C2HWMoEBmL3DxXONFoQss9hwl3SAhLJk57NuoAXk1XvtVvc8XIx1fWHsk2Mwn9vRjljyil6G31YA/MssXS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RL+2mq/j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P87hWgfA; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RL+2mq/j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P87hWgfA"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id B5DED1382786;
	Fri, 28 Feb 2025 04:26:51 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Fri, 28 Feb 2025 04:26:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1740734811;
	 x=1740821211; bh=/tEGiS53C+c1dEIukqCQzWxGpCfQLDo2u1dS2ox8NC8=; b=
	RL+2mq/jlImiho4Iv2+v+lv3U+PFCe3pRy1q7wT4T/msR3VNcXUY4iWFoPj8oPV5
	djSImTniHUocYaxlzMt3Nwew+OJalv7iuZSt8h9bP9pbUP4cMulY1IlFRsQ10Cdv
	717sWFJ61Mnov1uGdwF9Eveg8kTldvgktvHl5jQ+nKBaSFBqPhIbvq/6OkzfZxjV
	pmyjPf+LqDlFt3NkkuJjBoHrGJy1Krq6wDdKNUWrIfVrrF4wZiJjoAjlgF25Sefq
	/vaplUBksJY5cns6I775dBU6TQRRPNYZbzJb+JDJw5A6lGE1Um47Pwa8gn7YJT6u
	moo2UEenhQypMn1qAN2yaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740734811; x=
	1740821211; bh=/tEGiS53C+c1dEIukqCQzWxGpCfQLDo2u1dS2ox8NC8=; b=P
	87hWgfACshUwiidW6FhKm4cRC/K3N0QxR7jPSBlYgdgwOtzpmpOh32/RpKX+3syD
	qYjgq6OzZXl7KC3Vn+S+E9sV3p+s5XSTYGyBgSV3i17HuroEfR3FEkv6NcYJbmq6
	cvSCs4Z1LOQBQIu2p2XFUOvOcW5i0qj4+d04DdHgo1BsyaHRcAXP3XOSY0rIWeDt
	FjNZ8ypXf2lGZwkASIOlUp6XLDY9DHzwDQdo/OzYHHvfNXOFoXhWyEZsUaYp6CRX
	9FWZwf1PGuE5udrcVVHYvb+5OVwqRg6ixmFzlRJFzb+56feTH5u1+qDFyvIHrofq
	U0Gz+GC0rAJljTi+TkpzQ==
X-ME-Sender: <xms:W4HBZ1TO9bJqxE0p5TYNXeq7X1QXel0wF2PzRRT2LEDmpu-IST4RzQ>
    <xme:W4HBZ-xtbl_hN9LoMzrqIF99o2dTP2UyrrQq553YSGYXce0dLnmNGMsmmbz0bI-nt
    iJEJQqxec4AOwbk4Q>
X-ME-Received: <xmr:W4HBZ60tt837nKY_SsM-5oTZz3GmrV0sc90UpkJp9qiGi2obvBCG0aDIgDYP_wL4k0UclCnTzyHxug1lWB1QJrGZRhutOhCbHuWfg1hUWjjZGZOG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeltddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhi
    drohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehsrghnuggrlhhsse
    gtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homhdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:W4HBZ9BMZ5DGhuFWpSZXXPsas7YBi0Etpiil73aPBKdGgE9Ut9FRXg>
    <xmx:W4HBZ-hYArfi4V-S-XG56iRjXcLQU8xSdEMWLScXgqjfDM59mLZ28Q>
    <xmx:W4HBZxrnpq6KxGVHZUiB5trdkHXyjnw4nqDx7Ru9ecWuJBqQcbokZg>
    <xmx:W4HBZ5hTR1v9gMAf0S_mQaEVFwzVdFwu0MNv2lqYPhiPVDfs7v695g>
    <xmx:W4HBZyhLP1nh95JlBhXWYTth2HdCttFpfoUbpCA20EjIW1pJ6A4ZNuWo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Feb 2025 04:26:50 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 58bf1332 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 28 Feb 2025 09:26:48 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 28 Feb 2025 10:26:42 +0100
Subject: [PATCH v4 05/16] refs/reftable: batch refname availability checks
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-pks-update-ref-optimization-v4-5-6425c04268b5@pks.im>
References: <20250228-pks-update-ref-optimization-v4-0-6425c04268b5@pks.im>
In-Reply-To: <20250228-pks-update-ref-optimization-v4-0-6425c04268b5@pks.im>
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
2.49.0.rc0.375.gae4b89d849.dirty

