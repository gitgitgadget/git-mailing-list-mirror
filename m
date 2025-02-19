Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27B21EB1BE
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 13:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739971432; cv=none; b=RyK7ud/vTlnfFMIwTjAui1Xy799yiR60VS0cNG4eqUS5RsdKon/NczCrtwUsKEw/76NMWrM+Y/MqJq/TytE1FrYGtyQ0MT1eS1LfQNR4yDu4GVAR4zxpY+B98yjsWSRpQDoBVjp/+PH6bPeMtrrdBcCZnZyS9cjXBbkpsj5qOHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739971432; c=relaxed/simple;
	bh=psbMAHpK4wAddoulcMdsp/OagM39ZiLJnARdcn3lo9k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MnfYwAQKNNzLAbB2rWd7E7TRtFJ2mRZ0LywCkX646QaWT7yFyzKOxcC3vXNaYMz5gF6EC/bYHiwYlruLyazpl3V9qLGBaw0Oekfp1VgyE1pU1amZytQSKtoCrOIzeTgwSR1b8r1coeUeNaKunbmOoG5EoK94mpYSV4jPckSfa48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SpNWUjP5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=u2IW9N1I; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SpNWUjP5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="u2IW9N1I"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A96BE25401C4;
	Wed, 19 Feb 2025 08:23:49 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Wed, 19 Feb 2025 08:23:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739971429;
	 x=1740057829; bh=jUE1hmvtpwR3ov9qcaGHSmgcgdhQbfMWDgSh8in/rZw=; b=
	SpNWUjP5LiWlT5jOXK9feg7b36zvw7epCHYw7RoQ1CnYuM7szcVtP28GOBqv6XSc
	pM6VHQYolKS2rZYxwPU70sr/qahcnNVlmV0/6m02YA5l1QMvzCcU4xamTEn1hnvx
	Zh8qaih65SYFVruCne+YZxW0gm04UU7kAB+9kpHLFo0xEmIRm7wDzfnC/BSzjAKh
	rrg+ZXwijNmwUXO0UMG7KBdeyzZ/hvuLXe5bxQ7FIK4fVXVtJS2d/EjYwu4zxtn+
	fBJpxyBAoHRQz+G2UxTyeXtJjSeE8cywoNlPbcxh32eQdlJg9sXgTpx4PjLGpDPR
	BgYHn1s2nSUiOCovwaWa8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739971429; x=
	1740057829; bh=jUE1hmvtpwR3ov9qcaGHSmgcgdhQbfMWDgSh8in/rZw=; b=u
	2IW9N1IZXrY43+hgkxYhuNwh6EgU2PqanN3/N0LC2Nd7PgZLrf24VL+uJGS0n9IN
	+CKclzZ5Zr1j3xjNsg7WYAC+YdX+b7c72v3d2ZEU8cH1q8+95r17zE5WawydvTIn
	PkchJIg/sFxaCNvx4xk2iKhNpUIjo9nx8PhkzsiW3yYUs/rvgY7v7QvOwikRXhn5
	bby7tfxCLr57ulKTM9gFeb8l7eOOOLxDqczUpwl8ThtxG5sWu8S4eyJ2mY5p7edV
	pkEbhbm3zZ9L8KeChNAHaqIHxXsReX3bmXdMb5Yo3qTIMSRJUyQB0gZqMOuuf2RP
	v+40pni1YxBkCPPMCj99w==
X-ME-Sender: <xms:Zdu1Z2M35I6om7CYAsb0dzObnqvVReeuGjyhQNkckQxdM-Et3doOxA>
    <xme:Zdu1Z0-jKBJlWqQruqKKSqd016_ViwEhruZvtp-9qeIOzmnK_l1SPs-6dm91P9zhx
    n2xrK2buWWR24_jXA>
X-ME-Received: <xmr:Zdu1Z9TaOkT4vW_wZIR9YGaKlkjaA7ShNGn6x6ko6yyhv6hZx5aLJIdL6dlFFKDTutfVcE1rZX3u1uC8yT9NgJA3a70VxeOkKvKUZzz4pAvJHhY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeigeefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthhopehsrghnuggrlh
    hssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhg
X-ME-Proxy: <xmx:Zdu1Z2sQ_cWB8TVyzrzupuNuAAOyWDBXGe7tCrnEwA6nv453rlR39Q>
    <xmx:Zdu1Z-fjZ9L_a4zR_0w6YZ7EOLbRZcc7lKm1B0ZZK2PWscz4dVpfBA>
    <xmx:Zdu1Z60v2Nj5_gudmCo2uyBwX81rac6e7DbrySMOXaAc252wHF2_qw>
    <xmx:Zdu1Zy9M-_pLUFovFhlMtUJFO16JunncHmENUatcjZ2e6e4vz19U5A>
    <xmx:Zdu1Z0ufzX9AmtTIQG-GWqDtiGFjsu5SuuNJJwfTGcvdBHam1x4htd4i>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Feb 2025 08:23:48 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 22dd66e1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 19 Feb 2025 13:23:46 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 19 Feb 2025 14:23:39 +0100
Subject: [PATCH v2 12/16] refs/iterator: implement seeking for reftable
 iterators
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250219-pks-update-ref-optimization-v2-12-e696e7220b22@pks.im>
References: <20250219-pks-update-ref-optimization-v2-0-e696e7220b22@pks.im>
In-Reply-To: <20250219-pks-update-ref-optimization-v2-0-e696e7220b22@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 shejialuo <shejialuo@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

Implement seeking of reftable iterators. As the low-level reftable
iterators already support seeking this change is straight-forward. Two
notes though:

  - We do not support seeking on reflog iterators.

  - We start to check whether `reftable_stack_init_ref_iterator()` is
    successful.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/reftable-backend.c | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 06543f79c64..b0c09f34433 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -547,7 +547,7 @@ struct reftable_ref_iterator {
 	struct reftable_ref_record ref;
 	struct object_id oid;
 
-	const char *prefix;
+	char *prefix;
 	size_t prefix_len;
 	char **exclude_patterns;
 	size_t exclude_patterns_index;
@@ -718,6 +718,20 @@ static int reftable_ref_iterator_advance(struct ref_iterator *ref_iterator)
 	return ITER_OK;
 }
 
+static int reftable_ref_iterator_seek(struct ref_iterator *ref_iterator,
+				      const char *prefix)
+{
+	struct reftable_ref_iterator *iter =
+		(struct reftable_ref_iterator *)ref_iterator;
+
+	free(iter->prefix);
+	iter->prefix = xstrdup_or_null(prefix);
+	iter->prefix_len = prefix ? strlen(prefix) : 0;
+	iter->err = reftable_iterator_seek_ref(&iter->iter, prefix);
+
+	return iter->err;
+}
+
 static int reftable_ref_iterator_peel(struct ref_iterator *ref_iterator,
 				      struct object_id *peeled)
 {
@@ -744,10 +758,12 @@ static void reftable_ref_iterator_release(struct ref_iterator *ref_iterator)
 			free(iter->exclude_patterns[i]);
 		free(iter->exclude_patterns);
 	}
+	free(iter->prefix);
 }
 
 static struct ref_iterator_vtable reftable_ref_iterator_vtable = {
 	.advance = reftable_ref_iterator_advance,
+	.seek = reftable_ref_iterator_seek,
 	.peel = reftable_ref_iterator_peel,
 	.release = reftable_ref_iterator_release,
 };
@@ -806,8 +822,6 @@ static struct reftable_ref_iterator *ref_iterator_for_stack(struct reftable_ref_
 
 	iter = xcalloc(1, sizeof(*iter));
 	base_ref_iterator_init(&iter->base, &reftable_ref_iterator_vtable);
-	iter->prefix = prefix;
-	iter->prefix_len = prefix ? strlen(prefix) : 0;
 	iter->base.oid = &iter->oid;
 	iter->flags = flags;
 	iter->refs = refs;
@@ -821,8 +835,11 @@ static struct reftable_ref_iterator *ref_iterator_for_stack(struct reftable_ref_
 	if (ret)
 		goto done;
 
-	reftable_stack_init_ref_iterator(stack, &iter->iter);
-	ret = reftable_iterator_seek_ref(&iter->iter, prefix);
+	ret = reftable_stack_init_ref_iterator(stack, &iter->iter);
+	if (ret)
+		goto done;
+
+	ret = reftable_ref_iterator_seek(&iter->base, prefix);
 	if (ret)
 		goto done;
 
@@ -2015,6 +2032,13 @@ static int reftable_reflog_iterator_advance(struct ref_iterator *ref_iterator)
 	return ITER_OK;
 }
 
+static int reftable_reflog_iterator_seek(struct ref_iterator *ref_iterator UNUSED,
+					 const char *prefix UNUSED)
+{
+	BUG("reftable reflog iterator cannot be seeked");
+	return -1;
+}
+
 static int reftable_reflog_iterator_peel(struct ref_iterator *ref_iterator UNUSED,
 					 struct object_id *peeled UNUSED)
 {
@@ -2033,6 +2057,7 @@ static void reftable_reflog_iterator_release(struct ref_iterator *ref_iterator)
 
 static struct ref_iterator_vtable reftable_reflog_iterator_vtable = {
 	.advance = reftable_reflog_iterator_advance,
+	.seek = reftable_reflog_iterator_seek,
 	.peel = reftable_reflog_iterator_peel,
 	.release = reftable_reflog_iterator_release,
 };

-- 
2.48.1.683.gf705b3209c.dirty

