Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BE026139E
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 08:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740473768; cv=none; b=ENgWmy+tTxqUqRE8BEMQmhWg2fV0DykGEMtPX9zL/nFREt7Xsta2A+sJLGCvs+ozOZduHYSyd6KSzFxevevM6M5ykKXwPnD5Oy2iCIvN0q0glotyg7Q5WfsS2BhR5XrImJkCZnjHERmLoWEVgzW1Q6w1S1NojlIHTM+d9JwiLls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740473768; c=relaxed/simple;
	bh=QbK5tFNgKQbtu/1LRI+Dona96rcOn4/pGuxR404zum8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lC+fK3z5vyy6b/heDKIW8pV5wR/+MGnwjZz+QZdWfmDdnDxxtfOMRkbCo/FKtQN11/2PpoXkwmi7MPVnoZhiRZWW51sll/pTlDMR6ySrKleYWw3NlGGz+G42Oj6vpPwyWEquEkAtXLOUfTnFNKuZv7KR6aK/x19NdPK3Tnyyq5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OiOj4B7c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RuO4Imag; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OiOj4B7c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RuO4Imag"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 262B51140180;
	Tue, 25 Feb 2025 03:56:05 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 25 Feb 2025 03:56:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1740473764;
	 x=1740560164; bh=eRL7k4lOWqxoDtQJXZk6oE7yUxM/hrv6ZbD+OnGOWV4=; b=
	OiOj4B7c2lneQ7/z4YYGTImlYU41PT0GWNK2Ggnd8c7ntPdkX5sb/GO6yraBfPKp
	CkhT47+F+c6GWBuw6kWEjzLMc189nBWxRuv3QzmvH0H84KRnqZw0b3yLu0TSwDbn
	lI0c+gjaS+etbeztZpnBMeQ2OTG8k/v1J2n4hzjOo1D2yLqqeri6By3Aosuota6v
	Yh0O9isf+xFKU98AS7yPjZnMCRk0WWSYONbtd0iOaBjEpoVlzFBN67SPCppe3aWj
	e3Lo5ntp/VAZ515EI3F4Owl+KKSYhwIYZ7//k+bmA66WHpKhEP2FUdo1To/t3PML
	DumR8xrzLlG0UmuA4rdirA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740473764; x=
	1740560164; bh=eRL7k4lOWqxoDtQJXZk6oE7yUxM/hrv6ZbD+OnGOWV4=; b=R
	uO4ImagBBdB4QH6HlhfnMxtzrBLmt/B5ht4TZQSRoB/PIaVh2xM21Po+DbsfbCKt
	QfYJ1V+084iXJalKynBX2pFWdqdxvE/HGVoPgO0WfMV4nXNKeNZLDeE1xpUv2gbN
	+BdWJ0juGqgNgw1wPNBGMHUA9mHB/8Pt/EnhpPijuzzEXDZbjHhU1korFhwLgqFW
	qPKSwgiNP7a/63GWmUT3br0PV2Id9a/hiscLvgQ7bhvfPTG9U/ikmMHwRBUTDzaa
	Qak8+FP2yqehy3LOlpVwg3Jht/DmgmZqeuSSzcjCPvuEJoM7dqj3730Zeut4lM2h
	XKLlWe0OdemImgqdGBCgA==
X-ME-Sender: <xms:pIW9Z9uoxLnszIo1XaR70QITGBVOeymxuxmkZxNzagVD1eyr5w50uQ>
    <xme:pIW9Z2fDSqRyI7B-XofQW1ZTNLoMyz3FhdG0vQSBtyJbxvf7yW77QS7hpX8gwpZmZ
    U0FYGHcNT7G3kUm7w>
X-ME-Received: <xmr:pIW9ZwwVuIutgSu3FhUzlJltzj18KJAsi8xk_reA0yEADeG2mGQ9xJMPBNxk0Qxg5rIW8XdMNr_MiTUsDO71mo20IXDvD4SpKqQ2_yPUcq3XtQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekuddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhi
    drohhrghdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehsrg
    hnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:pIW9Z0MqPfTEaX52weKzUS6_IAd5nh3LuvJPuc00X7MDyt0gsaa9vA>
    <xmx:pIW9Z9_0Cj7UW8Ycexwi4yQ_7yfouQ5Ripq0clFGJwsbE9RTFPgiPw>
    <xmx:pIW9Z0U5JePijX-bj6zt-IpvX3fTIM-3fdb-tcFOiVYiOtKAsI5O4A>
    <xmx:pIW9Z-fxhjz-805r548coQ9a7e_o-srVsmDg0pBijZ_FUXqoIuHBTg>
    <xmx:pIW9Z2P1l2nDQVlAQ_XMCpLvZqJ5CmNH0CTzOHAuzPuBR0tyZWVZtIzO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Feb 2025 03:56:03 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ff70a324 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 25 Feb 2025 08:56:00 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 25 Feb 2025 09:55:51 +0100
Subject: [PATCH v3 05/16] refs/reftable: batch refname availability checks
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-pks-update-ref-optimization-v3-5-77c3687cda75@pks.im>
References: <20250225-pks-update-ref-optimization-v3-0-77c3687cda75@pks.im>
In-Reply-To: <20250225-pks-update-ref-optimization-v3-0-77c3687cda75@pks.im>
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

