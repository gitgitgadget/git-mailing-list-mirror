Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9421EB1A9
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 13:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739971431; cv=none; b=jHuA9RE4oJ8UDojk2QkP8EoV+1IVO2NZnjLhMfrRMOxlQ4jm7fUS6sqR4KJkYvFIJQOCLvj2782g5biW0/QwMYNtLr1yRNptk2mff4eJ9WgpBoON2IBLDrGgZR6BTOiVyNB2KfSp6jy64SF/0N3nH+V7hv0j9laOIMAHml1hyss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739971431; c=relaxed/simple;
	bh=FYBZPcomQIhgxO6TYOMBTkYbRlVeeJkskSN8K3nvq3o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XgAdRXyoziysiRxd+xSCR7GjLlSfWDrAAagqKWSpi1ALZWFuD8G9rCXgEUbuEfbRl6263EoAv+R0eHval74lSbNZYDoz65YrOpIE6bDzmWik2kW+2vT1gRR/AMZTgsIb+rf2C0Fw3O22ykvat/uykA02m+BDF2hpzVbto4gaPqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Cpxz8zh5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bu0Rq7cO; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Cpxz8zh5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bu0Rq7cO"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7A16825401B2;
	Wed, 19 Feb 2025 08:23:48 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Wed, 19 Feb 2025 08:23:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739971428;
	 x=1740057828; bh=QoX1lF/sni9Fu/tTkdgFlY42w2ET4Q+RlDHrhorL06c=; b=
	Cpxz8zh5Bcou2aeZUGZqWBktsIrSSMTIHQ3ooGS/yueMkTkCnZ4ob/IV1qnMFueZ
	nW9T5xq2O42e0uiMBqNQFdjaWDsNj9wYY/JwFkfr/BDP+8nrahSVTeswT3NSd4MF
	OOslJFt//hAq/i9RXGO/rI79frWijuOToJAt6pUBQEUZvV/qQfWJDKdcFQ+sEzdV
	rMKEL/Z4IssZPydLqsiPc5JKQm2UWY+MRVg0yo9bvn0B2xpcsZm1jhFXPKE9ZeZE
	WQS2lOHVRnmJPGa55rzE7jHr5lsKiTDOIXh8XgcrV/xpoRorKyvdyEbKfCzu0T4H
	OGfQRrzqTY0rEMYXkM39yQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739971428; x=
	1740057828; bh=QoX1lF/sni9Fu/tTkdgFlY42w2ET4Q+RlDHrhorL06c=; b=b
	u0Rq7cOBY+tInG0czprQatpLAyOAtTgEOCk4ysc9NehxFEisZUXyVuff1+EN1YaL
	4XqDc+TpHhSAGwngMBUxAqLNrKRusNfoWSaJUESoDSemKTKjUCaycm/SpWyZVLl1
	XRavvxamSf6QN/aI3NMEgBYLVQPlHJrqBh2mZbf31Baj6BGldaO6kBou/wMY/VTF
	zjAiJVNEYhcCOpxpFnpvvA337S+Yvf0x6dhWUfx/y1TmVgOmwUUvqjBlU/p9Mexg
	/KORD57Tp5gM0DJa/MywqPLQj+HEpETnMrNMl6pfUptMi0JiyBHwLlUlWj5ky/Mx
	f8vegBpa2QBDqPpzFScZQ==
X-ME-Sender: <xms:ZNu1Z8aWaxLSfWW3P2kTfIgVCJWfYfxoXIkDKOB_jjFIxSAtmrt6aA>
    <xme:ZNu1Z3Yyw3tIZ0-dz3exXWfwmBir0l7Ix2gNQfOl1gK0sLT6Yxj-pSEeFffyt9wDT
    oM8YYq4QJO-1w1aqw>
X-ME-Received: <xmr:ZNu1Z2_YmuGTdjJeSKlPBkdY-dH3MZew-IKZ_IRTs-L5-asSWlmlYDDtYeskm2rpgUpbnMwAFsEYFJwqhHjxiW_rMlKWCnrv3cXHx8scBZNhbDE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeigeefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghp
    thhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthhopehsrghnug
    grlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehpvghf
    fhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
    dprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:ZNu1Z2pNmTpNmRdPd-eDfS8jaZaZnmQ-XBH1KJW7FIdkV2eaDlUllw>
    <xmx:ZNu1Z3r2zjTg035Wbub7MzRwB2f8RT-IIJrAHvSNlN5UZV2L876MHA>
    <xmx:ZNu1Z0Qq7_IBMM72aj3TTLlvFZLMwxE7IG7LGsOSgrDWZhv4Bl5S3A>
    <xmx:ZNu1Z3qoG7E5z2KfH-me2QxEaYxYgS8AZO8il1OnWiJvXsJYqhNdEA>
    <xmx:ZNu1ZzJG1gJuDybnW7Nj85REnDI2T4FiK6vRVgOXbLyvuy5Fp7aLUozf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Feb 2025 08:23:46 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b09e7a0d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 19 Feb 2025 13:23:45 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 19 Feb 2025 14:23:38 +0100
Subject: [PATCH v2 11/16] refs/iterator: implement seeking for merged
 iterators
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250219-pks-update-ref-optimization-v2-11-e696e7220b22@pks.im>
References: <20250219-pks-update-ref-optimization-v2-0-e696e7220b22@pks.im>
In-Reply-To: <20250219-pks-update-ref-optimization-v2-0-e696e7220b22@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 shejialuo <shejialuo@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

Implement seeking on merged iterators. The implementation is rather
straight forward, with the only exception that we must not deallocate
the underlying iterators once they have been exhausted.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/iterator.c | 38 +++++++++++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/refs/iterator.c b/refs/iterator.c
index 757b105261a..63608ef9907 100644
--- a/refs/iterator.c
+++ b/refs/iterator.c
@@ -96,7 +96,8 @@ int is_empty_ref_iterator(struct ref_iterator *ref_iterator)
 struct merge_ref_iterator {
 	struct ref_iterator base;
 
-	struct ref_iterator *iter0, *iter1;
+	struct ref_iterator *iter0, *iter0_owned;
+	struct ref_iterator *iter1, *iter1_owned;
 
 	ref_iterator_select_fn *select;
 	void *cb_data;
@@ -160,13 +161,11 @@ static int merge_ref_iterator_advance(struct ref_iterator *ref_iterator)
 	if (!iter->current) {
 		/* Initialize: advance both iterators to their first entries */
 		if ((ok = ref_iterator_advance(iter->iter0)) != ITER_OK) {
-			ref_iterator_free(iter->iter0);
 			iter->iter0 = NULL;
 			if (ok == ITER_ERROR)
 				goto error;
 		}
 		if ((ok = ref_iterator_advance(iter->iter1)) != ITER_OK) {
-			ref_iterator_free(iter->iter1);
 			iter->iter1 = NULL;
 			if (ok == ITER_ERROR)
 				goto error;
@@ -177,7 +176,6 @@ static int merge_ref_iterator_advance(struct ref_iterator *ref_iterator)
 		 * entry:
 		 */
 		if ((ok = ref_iterator_advance(*iter->current)) != ITER_OK) {
-			ref_iterator_free(*iter->current);
 			*iter->current = NULL;
 			if (ok == ITER_ERROR)
 				goto error;
@@ -206,7 +204,6 @@ static int merge_ref_iterator_advance(struct ref_iterator *ref_iterator)
 
 		if (selection & ITER_SKIP_SECONDARY) {
 			if ((ok = ref_iterator_advance(*secondary)) != ITER_OK) {
-				ref_iterator_free(*secondary);
 				*secondary = NULL;
 				if (ok == ITER_ERROR)
 					goto error;
@@ -226,6 +223,28 @@ static int merge_ref_iterator_advance(struct ref_iterator *ref_iterator)
 	return ITER_ERROR;
 }
 
+static int merge_ref_iterator_seek(struct ref_iterator *ref_iterator,
+				   const char *prefix)
+{
+	struct merge_ref_iterator *iter =
+		(struct merge_ref_iterator *)ref_iterator;
+	int ret;
+
+	iter->current = NULL;
+	iter->iter0 = iter->iter0_owned;
+	iter->iter1 = iter->iter1_owned;
+
+	ret = ref_iterator_seek(iter->iter0, prefix);
+	if (ret < 0)
+		return ret;
+
+	ret = ref_iterator_seek(iter->iter1, prefix);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
 static int merge_ref_iterator_peel(struct ref_iterator *ref_iterator,
 				   struct object_id *peeled)
 {
@@ -242,12 +261,13 @@ static void merge_ref_iterator_release(struct ref_iterator *ref_iterator)
 {
 	struct merge_ref_iterator *iter =
 		(struct merge_ref_iterator *)ref_iterator;
-	ref_iterator_free(iter->iter0);
-	ref_iterator_free(iter->iter1);
+	ref_iterator_free(iter->iter0_owned);
+	ref_iterator_free(iter->iter1_owned);
 }
 
 static struct ref_iterator_vtable merge_ref_iterator_vtable = {
 	.advance = merge_ref_iterator_advance,
+	.seek = merge_ref_iterator_seek,
 	.peel = merge_ref_iterator_peel,
 	.release = merge_ref_iterator_release,
 };
@@ -268,8 +288,8 @@ struct ref_iterator *merge_ref_iterator_begin(
 	 */
 
 	base_ref_iterator_init(ref_iterator, &merge_ref_iterator_vtable);
-	iter->iter0 = iter0;
-	iter->iter1 = iter1;
+	iter->iter0 = iter->iter0_owned = iter0;
+	iter->iter1 = iter->iter1_owned = iter1;
 	iter->select = select;
 	iter->cb_data = cb_data;
 	iter->current = NULL;

-- 
2.48.1.683.gf705b3209c.dirty

