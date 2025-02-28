Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A5E25DAE5
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 09:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740734819; cv=none; b=s1a0XNlIMYbjNiyuEDrGx7GtvI85UVtYOGe7Varee31uq7lw9D5ED6lbPb8fSi3Qg9sPuPLESUB54sPmtwFuIw5FQ8cVCYxxYZRGNxNTTOAzYymCBaobRfLy7s7s/03lopms0AAGgVwjPg5nrzuV6AXctHk40BmNkto0TZcBPAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740734819; c=relaxed/simple;
	bh=twRr1c7C+MEnFck1jpcTVeeJGqdZ2mAWMqEW/zgugkU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XixhhKHl6+r66K+Cey5Go+a7c5TC1jSn0qTIQPhIpjLQnWCmdNyB4a2AMf8LrQz5gJufSQ9NltSw792tOSnxu8pSkUyBAAzW95KQ6PVcRfFeqbCjW8zBTylZmyEgQ1ehMgEC+MNEsmW2zvmqy0VkDMgywS7zC56vdsGTILRr6U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZPOk060Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=voPASfzR; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZPOk060Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="voPASfzR"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 72025138276C;
	Fri, 28 Feb 2025 04:26:56 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 28 Feb 2025 04:26:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1740734816;
	 x=1740821216; bh=95vUu9q2eX39menAOcg653ZI1i0zB5K+2BAwtDd0MNY=; b=
	ZPOk060YdR+tKj3YL6oVg5ePJ0XxHr7N/GvluBfhOTET5DSACcsW26vz4YtSzkZc
	096DXJ66iqEo+mUZmkHEERJULrr0UXW5DXnde8GYTAC3lt2z0WaSMMBC20nWg5Bh
	BrLTn6j56Y3Es5xSlIteUldtTGOYHjWd9GrAlgUlM7+o3dl67mjxu3vJ1nZHGHEK
	qyJHbwmAVsa0xWDYz88udo+RL2W4/pWbGLt61eGNX1tgoFuADpWNTdrxt3gZFBcB
	Mifjv7Pi/l+WogDW4Z3OrTcq5sh7DkXZPm5EjyI7bhXo7PNeBohC7yA8I/3V8fmD
	dnuvrtCt7UZIzdPJRxEdsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740734816; x=
	1740821216; bh=95vUu9q2eX39menAOcg653ZI1i0zB5K+2BAwtDd0MNY=; b=v
	oPASfzRmduD0nj+OjU0dxulKIZCJkmmC5gpvflFYqFpPRYZmoD1R3DvwWDBmP9lI
	3qtqy52rUZU97gu0NhueYIM7eAtHT7/XE4uDNmfc5PYPKGrteGBJ49dCbm2GK12w
	fSl/2VU+q+XlKmvQPfa/97U9AwKgnbZdhHBEG3+BfBa6Koxb4EHA3oQNTYeJOO+h
	Urekdd2ydUwiTjvjg3vZ2LVdQqCcQqeZrIwyv9TPMNOmE9NNtN0VdCqN1NpP25eH
	ibOEtiepRIgzeY3Y77UISmbFZnsbSvg5meMQj07Nu/euxynpkIW/aGIz0uvmD356
	BBBQbNGraxJKsbnnYlvBA==
X-ME-Sender: <xms:YIHBZ8HV15sEnVG-QIZMe7fxrPvOpFmiFWDtA1BqZBiItTIwRPBNQQ>
    <xme:YIHBZ1WF0_hB474WeBRNicLbGoff-y36Ffye6zxvmnqA6FfuZXKlBjb5GqgRqNMhc
    qdOeYLx5xY4J2p9vA>
X-ME-Received: <xmr:YIHBZ2J7lpM52qyoA7xQN4U8U3hcoIcE-iby67Ns9guUqC5Wf8wSiixL8RStMv_17qKFUq9oV0B0RkVUZwq39syz7UZQ9rIMWewGbNvqT-jGjQS3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeltddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtth
    hopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphht
    thhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhish
    gtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:YIHBZ-EAKAneya7HgLMwIUf0mEtOOdzx6lQbNM3DuskWrCdlX1QhHQ>
    <xmx:YIHBZyVKggAWqH7H5lVV1SE5NImXyTLUHblCoSEBuzv7ZtCGu4fAOQ>
    <xmx:YIHBZxNsGTccYE5uCzbJwXfE5mO1CgjtAFlnGqIrqv9d4WmOk2Dy1A>
    <xmx:YIHBZ52nDdup7LvFqy27kI1puhUcJpGiCsbX8mDnY6QZFzm9IR4K1Q>
    <xmx:YIHBZ9EOrREVn5Em3Wj5FdV2yXFs5nk73z9gqeI7cHGhQMSB3Uc7m0OZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Feb 2025 04:26:55 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2506db36 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 28 Feb 2025 09:26:54 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 28 Feb 2025 10:26:48 +0100
Subject: [PATCH v4 11/16] refs/iterator: implement seeking for merged
 iterators
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-pks-update-ref-optimization-v4-11-6425c04268b5@pks.im>
References: <20250228-pks-update-ref-optimization-v4-0-6425c04268b5@pks.im>
In-Reply-To: <20250228-pks-update-ref-optimization-v4-0-6425c04268b5@pks.im>
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
2.49.0.rc0.375.gae4b89d849.dirty

