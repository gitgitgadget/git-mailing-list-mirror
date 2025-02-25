Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419D62641C7
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 08:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740473772; cv=none; b=X3IL7OXjsd7qnBJ1HtGkAQiwW1bw++pP5JR1Pv4KheTkwFt3F2k+HSpemaP7fAkBvuuIAcZjfbHRvdaIulevUu27EpTXFSX72jNh4JufZfVSE7eiMEKIcXUPHeVcZmBGMK/rLMRiZovPIpa7H8LkUlfe7NMh4s6BK3PrRQTSIqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740473772; c=relaxed/simple;
	bh=FYBZPcomQIhgxO6TYOMBTkYbRlVeeJkskSN8K3nvq3o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dls7RrQSRZOaE0celQG5Ad52vklChZA/De59HlrOJMB/XiO1eC8jCpuN5yGEOAAyR0x8F3kGasKtuhW398Vr/4qzTh2jNuohTZX4rCCt5zmMOK0cCiAUo/P3cdkJcKp7qyXDvbWlODK1UT/weOuLmyiB+Veez4MW4zJkCwZalwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Cua2ew2/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ybVUMcDJ; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Cua2ew2/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ybVUMcDJ"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id EBB39114013D;
	Tue, 25 Feb 2025 03:56:09 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 25 Feb 2025 03:56:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1740473769;
	 x=1740560169; bh=QoX1lF/sni9Fu/tTkdgFlY42w2ET4Q+RlDHrhorL06c=; b=
	Cua2ew2/JbzLPs1GDreUZWlnq8yASJxMwoFz3BtS4I4d5NUCByv5t7Dw1X3LvejH
	+4Wm6pJ38olhbLn37st8kFoLv5AgFXg4v8EASt8e0jc2Vo10gf7IPh/WwT6nroBQ
	vKHMjsnO36PJVsea3CDwvsKy+Grwy8TOiodnxAejkzX++g5/DSq9uytNsXy0fCME
	1DZqAWFB/CF4Sb0iSfBROVEIn0fiJQW9aU6mskrVI6to8SgIDq1h8aa5bGscsZCp
	B1q/btLtOrc4By68pnDqBiEZXBy9lC1e460k53jdyjxP4ct4woeMoCFQBY4ix8TU
	RStBRmYOJPczufaf2kVxag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740473769; x=
	1740560169; bh=QoX1lF/sni9Fu/tTkdgFlY42w2ET4Q+RlDHrhorL06c=; b=y
	bVUMcDJg+b7jiFNPlgF/awB4D7f7vE/E5TYIzJ+suwDPLItO2yCAYN/gCJvg/quR
	R65KnVJMQAr6+Lj6d+4ScPmdC4TCLQ9Y9duLiZsfnprzxGC9Nu/KmDLHAEvAlOof
	TVaTQW5V89X0mAuHxs5JZS/ZJ3rGxulYem3OuJFz0259rdjvnQRGtAmZOVYjSLAh
	k7vsmLUniUthy+xaMuibw3ukKkz7RfbsV+cJlmpM1qR+t//7TAk+hgv01bkG23h7
	hkDHpwhIvzPKQmUSM2KxX+zMwzdxAw+yR7sZgRUa1MBvkPzzuLdaYvpqRDJfIbZf
	+mqzjIc2wU55rrMfhCTLA==
X-ME-Sender: <xms:qYW9Z26wqm58mHs_fersGNalImh8kFBzKcUaD-WIXKKpoaIfoAI4mQ>
    <xme:qYW9Z_4OjsoPZUOGqXC4XSlb9vbZ1Co_F40AGaLXF2uFLjqrNIA1LQjaycIYOMiXp
    BchraZHuFv8jiOPEA>
X-ME-Received: <xmr:qYW9Z1fufO3edlpHBDk07hFvSSMr5ZoKKHVuDx9rJHes_A1WOHyrLak-AbQFOPgetQvAej4KAOrNFjLXVzsbn26m6deYx8vdW-XMg6p5AQ-mpw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekuddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtth
    hopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhi
    shgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehshhgvjhhirghluh
    hosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvg
    drnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:qYW9ZzIRa8tGHGU7QL4NWac91C1XXaN5A8VnlgvoOZKLHjl8JNyzPg>
    <xmx:qYW9Z6ICZUBDY_XZNRXbUYWqE3DQa-PR9YzW-1xHSiF5atRo2ip9yQ>
    <xmx:qYW9Z0xHnpV__M9SPWTNW2_ZIttcjKjVAoQ_hvP2QJnzZ8QxoPYOxg>
    <xmx:qYW9Z-I0IP0Py0ShdkoS9lJiQ4Ljptxg0btcKWtmPZ8fDv_Gi_RGOg>
    <xmx:qYW9Z7pUsYeR97qHgCW8sNvX4XYYAsmTW4czW2BNWPwSxG7KxDdicduu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Feb 2025 03:56:08 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ec2d8f4f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 25 Feb 2025 08:56:06 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 25 Feb 2025 09:55:57 +0100
Subject: [PATCH v3 11/16] refs/iterator: implement seeking for merged
 iterators
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-pks-update-ref-optimization-v3-11-77c3687cda75@pks.im>
References: <20250225-pks-update-ref-optimization-v3-0-77c3687cda75@pks.im>
In-Reply-To: <20250225-pks-update-ref-optimization-v3-0-77c3687cda75@pks.im>
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

