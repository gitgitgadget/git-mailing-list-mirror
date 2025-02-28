Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDC025DB15
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 09:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740734820; cv=none; b=gZELPLGxqJ/mCrpa25BfcIjFO5q5rnPXjZzBNnBrv1t5nqApoGp05iXbnKjLjHoyw7ebZAspahSOzaHDX1NfhHER/bLqh3f88GF/rzPxhf7E3P2VHdBdAygBauniztd6sTioI7VIv7Xm16wCG7cTUp5KouJCUGP/AQCsbKGIbEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740734820; c=relaxed/simple;
	bh=xadEoGhSOWNBU//v+2Envq4KmTRLvkzsq5RMmd6HiRQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NgVKw+ijucPjnGd7iKvFYKVYIlo9ypXV2f99UKrmWUtYImflmp8tozzeE3lTDbYoaa49MsXhLyvYg5ABrDGhC9F8NK7NFoioIBDjQkBPMWuFRLzsvqzP1g/0tP+1a/5UOpqruOVaigGnObemT7Ot5WvfA03HxLCyQnePZwUq7c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ptq7Ox8Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XOuQA6a4; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ptq7Ox8Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XOuQA6a4"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0089F11403F5;
	Fri, 28 Feb 2025 04:26:58 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 28 Feb 2025 04:26:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1740734817;
	 x=1740821217; bh=dd6sRNEQk/fYRpUpQzHDLxkXWPwerKYBNLm9ueDcQE8=; b=
	ptq7Ox8YeubAyCambiByVXPIBHqL9Lg4aCrN0PBghE809UdemXwctrdlM9LtgmxY
	cmdC38A2gVgl7ivt1DF2U0mjEVvz17wZWY3UecyIMpZO4nAwTZQtRwN2YNoE81xe
	pv7YatpdBBFi7eaZFvrVlDqjm5HjN3uzIn5jkF+OaU7cuW4tiWqvGw21mf3N0EtT
	Sj5bF1SbNg1bXaQFoPpmSybB/hCyUkpFLu0LNQXq7ZDmOP/cskEg+1vTgCiFi6GG
	lOWfH2P/vTRouvhBN9vEXPvu1f0H36JtYnqk1SgLbfkpChv8o+6GNOuI+TrvYNVi
	Up+2eIh0DySbjfabs+BD1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740734817; x=
	1740821217; bh=dd6sRNEQk/fYRpUpQzHDLxkXWPwerKYBNLm9ueDcQE8=; b=X
	OuQA6a4EwzzSyK1cmk0Lmvo6FZ3bdMGDX2BQb+H1d5r9pSZQkTOrtGI0N70ukOzS
	HgWTZs3D2dvyDgpSF/e7pfipTaqw70ytsa8FPAY54G+uta9+UfZAD2nHM5EP1G9g
	50eCAKJMvkRCx2tA6kslOw5DFL5x8siTGEkqmPrHgR4qKPjYXAfpsjYBd/gn2rBt
	bsw6ErBSFGZ4gm/sYug1tsf3/aAo0MFgmfKAZdO6BPWa7ZlSzO31dTS3v1cP0SQi
	3+bbuDoKSYGCdPIllM/OMERFqiKDqMu0HdyE9PB0+kaHxbdmfugu/ZEOgUpviRy0
	ot3c2rwRe5Jl+SHkPPayg==
X-ME-Sender: <xms:YYHBZ8kxtb0bzNvKs4o0CooTgd8j37XqBMp_EdoOUip2LbEIxIv1wg>
    <xme:YYHBZ73kIgwADGhUgjw8V8_sgljxpzwhq9KI3_QSPCnTzRJK-ArlR5YINfRzuWmyJ
    BVxN_opNCDCGXPUNQ>
X-ME-Received: <xmr:YYHBZ6qK-T9pPnNlhFvw5H-mDMJ02GjCHzlaPLrZAPMz5fgZtaJu9bO_gGGpvQji70MzMcTPXkZR1diBHGpVvzh8LoE1zsyzWpMFObVkKFxIYpym>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeltddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepgeenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgr
    rhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghm
    ihhlhidrohhrghdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhph
    grshhtvgdrnhgvthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:YYHBZ4kycPUPcwZa_V_KTMvn5IewfcqJyz1_jDEMxwVHWhcpTpaqOQ>
    <xmx:YYHBZ61evO7GY2ScG9EOturud1ZvPx7hyNsathsN5Iv1nhp2TgPX2Q>
    <xmx:YYHBZ_tZprHekYNOfj5H5snNMlmaQIqV4vp7pDl3pwIlKMkls9IflQ>
    <xmx:YYHBZ2VjrSjQmJjzWcm1zFDXS7xHwZWHU7nZZXu2m9-ZUXsCWUGUHA>
    <xmx:YYHBZ7JxKP5NyWB115UdB0nJupga3W7zjVdtVKMxsl9qQjp7r-A0dvMg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Feb 2025 04:26:56 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c87f5da2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 28 Feb 2025 09:26:55 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 28 Feb 2025 10:26:49 +0100
Subject: [PATCH v4 12/16] refs/iterator: implement seeking for reftable
 iterators
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-pks-update-ref-optimization-v4-12-6425c04268b5@pks.im>
References: <20250228-pks-update-ref-optimization-v4-0-6425c04268b5@pks.im>
In-Reply-To: <20250228-pks-update-ref-optimization-v4-0-6425c04268b5@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 shejialuo <shejialuo@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

Implement seeking of reftable iterators. As the low-level reftable
iterators already support seeking this change is straight-forward. Two
notes though:

  - We do not support seeking on reflog iterators. It is unclear what
    seeking would even look like in this context, as you typically would
    want to seek to a specific entry in the reflog for a specific ref.
    There is not currently a usecase for this, but if there ever is we
    can implement seeking in the future.

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
2.49.0.rc0.375.gae4b89d849.dirty

