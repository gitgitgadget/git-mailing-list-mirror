Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEAE257AFE
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 15:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741794984; cv=none; b=dlk+f7krXB05MUOVA4OUl3I050qyDqiE34BXZslrcjvW4R5YoMhsjUswhxgWplm3+K9lcvkKvS9LUSXvdiM0MnBESeWS0jGv/jMki1n9suse6JsA9FRHjvwxIl0DsXehzkLGgrlgQ2hja7DPt3aTkQuAxzo0I5R1wTwzDRSLXPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741794984; c=relaxed/simple;
	bh=iLaJ3iVPCyvhpkTp+4LGCrn9MEugnEuY2pAYxiG3+7Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q8vFNDs5fWKrtCwjqcX1GZC0XRvSHHcTQxuIaTYDzZyk9rkXbEEhv0AooE53FQBSNZf4rWIYlmpR6lwblq2EpAaDnwqLYy7InRETiWmYjjaLe66EZfL8SlMc94m/SEA6ErOxXMiOJyaYYgM7WHY0lMDLUryri1TFrksq0+W0eWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gHbXT5Dj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q4J4HkLW; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gHbXT5Dj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q4J4HkLW"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 8C9F91140226;
	Wed, 12 Mar 2025 11:56:21 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Wed, 12 Mar 2025 11:56:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741794981;
	 x=1741881381; bh=gvhbxVPaOmGQyzRN5mSwiB2NzvhSzaeeZf0y+ELUFKY=; b=
	gHbXT5DjbQIhaVNpGLj3PWzQ3Dw6yVIPYIt7gMmYViW8CmIRBaEzELr4fli/J80Q
	DI51T/kFOrMRVBgU6o9G4IL4n81aPfgNclw+sderW7zqbgg0bOVnXRGThlYS27QZ
	//QD514w4kolcQeABZ/kQCMcu9YKRu++KOSAP1RowMCW9vLNiL/vmEaAh0qDtobd
	VDf4SVGcb2C4QM5IwHTPCZXwLx1S32utKgIHwEUZ6FluSzgfNMa17kIHB/YWu11l
	01tlMwq4lEIo9AUvf+q64tkesQfA4vxoSk71Ca1sUrY4wZGUKHRwK0bRLOv8dYv0
	N5PvNHe8EnH7EuQXJvRkJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741794981; x=
	1741881381; bh=gvhbxVPaOmGQyzRN5mSwiB2NzvhSzaeeZf0y+ELUFKY=; b=q
	4J4HkLWkrSwD3NVjlLRZaV/MF6KrQ49ZTs2Uvv2BWph+8FDHTYmck2ervalPsABB
	8HGnfNSSPHjPxgnlDDUKGVRxR6JXFcYFucfoHLLTBusqFCeAhcvRqxzFSeMH2pvk
	Y6AwT8sgBlrVRTu5pCkyHz+AHFCCiRPJ3cogzg7hmZHczGItUwSeTAoFb1nUPkkp
	oTDbIfKoBMfUFVu+a9DqTSDEJf7nARAEs3EoLf/k5js5ydfXYwhUN2JrjTGm3DAj
	RXTw7U0G1TxQg+QygYGD8QxiUQQ68tcPmQS3dT33W/XoHdLh44/MJgbdu7DEwawl
	c0I3knBDiER42jkcXq5tw==
X-ME-Sender: <xms:pa7RZ0n9GafGZKMctG0jKyvY6XOqLhQOlefTIpUaCO-k_ZvnuTLQig>
    <xme:pa7RZz2K4pTY5s2WABofYFkfhhYfw7tsbIbabzSx1epqIGq7Y_74xl8t40uNr34he
    j_OE0jWkjterBFV3w>
X-ME-Received: <xmr:pa7RZyoCRDrri5NTd33cX4yL6p9Ai5vwS-McgC7EigYyUACSHFMnOYcsdBexCb-MZQm_oq0Vb2gNYyBd9EqggtFq3iPZJcUfUaxlYkSreRvdP_hGtA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdehgeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeefhfeugeelheefjeektdffhedvhfdvteefgfdt
    udffudevveetgeeuuedtkefhgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilh
    ihrdhorhhgpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghs
    thgvrdhnvghtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    hshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:pa7RZwkUgpgFzyjDH8FbC7mKRu7KdZfCYJ283bn6J7RIPBd_J-7MuQ>
    <xmx:pa7RZy1i8k-X8o9_XSrZFuSytJS-usexXEXAbm2BxbKtp9b0GQXI1w>
    <xmx:pa7RZ3vXytaDcl8biuwAzwdv0LXjF2dgN_6zB5vFFiZrP1WoUA5uTA>
    <xmx:pa7RZ-XS93O0pkNPtHwP13FFWWuUHLyP2sgf9_njIposWf8Tseu4pQ>
    <xmx:pa7RZ7kdpwiBJGJb8NcauqGr-k0De_SoAamoOZI9Eva2MhrElmj5nae6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Mar 2025 11:56:19 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5837283a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Mar 2025 15:56:17 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 12 Mar 2025 16:56:14 +0100
Subject: [PATCH v6 08/16] refs: stop re-verifying common prefixes for
 availability
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250312-pks-update-ref-optimization-v6-8-f778e0414f55@pks.im>
References: <20250312-pks-update-ref-optimization-v6-0-f778e0414f55@pks.im>
In-Reply-To: <20250312-pks-update-ref-optimization-v6-0-f778e0414f55@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 shejialuo <shejialuo@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

One of the checks done by `refs_verify_refnames_available()` is whether
any of the prefixes of a reference already exists. For example, given a
reference "refs/heads/main", we'd check whether "refs/heads" or "refs"
already exist, and if so we'd abort the transaction.

When updating multiple references at once, this check is performed for
each of the references individually. Consequently, because references
tend to have common prefixes like "refs/heads/" or refs/tags/", we
evaluate the availability of these prefixes repeatedly. Naturally this
is a waste of compute, as the availability of those prefixes should in
general not change in the middle of a transaction. And if it would,
backends would notice at a later point in time.

Optimize this pattern by storing prefixes in a `strset` so that we can
trivially track those prefixes that we have already checked. This leads
to a significant speedup with the "reftable" backend when creating many
references that all share a common prefix:

    Benchmark 1: update-ref: create many refs (refformat = reftable, preexisting = 100000, new = 10000, revision = HEAD~)
      Time (mean ± σ):      63.1 ms ±   1.8 ms    [User: 41.0 ms, System: 21.6 ms]
      Range (min … max):    60.6 ms …  69.5 ms    38 runs

    Benchmark 2: update-ref: create many refs (refformat = reftable, preexisting = 100000, new = 10000, revision = HEAD)
      Time (mean ± σ):      40.0 ms ±   1.3 ms    [User: 29.3 ms, System: 10.3 ms]
      Range (min … max):    38.1 ms …  47.3 ms    61 runs

    Summary
      update-ref: create many refs (refformat = reftable, preexisting = 100000, new = 10000, revision = HEAD) ran
        1.58 ± 0.07 times faster than update-ref: create many refs (refformat = reftable, preexisting = 100000, new = 10000, revision = HEAD~)

For the "files" backend we see an improvement, but a much smaller one:

    Benchmark 1: update-ref: create many refs (refformat = files, preexisting = 100000, new = 10000, revision = HEAD~)
      Time (mean ± σ):     395.8 ms ±   5.3 ms    [User: 63.6 ms, System: 330.5 ms]
      Range (min … max):   387.0 ms … 404.6 ms    10 runs

    Benchmark 2: update-ref: create many refs (refformat = files, preexisting = 100000, new = 10000, revision = HEAD)
      Time (mean ± σ):     386.0 ms ±   4.0 ms    [User: 51.5 ms, System: 332.8 ms]
      Range (min … max):   380.8 ms … 392.6 ms    10 runs

    Summary
      update-ref: create many refs (refformat = files, preexisting = 100000, new = 10000, revision = HEAD) ran
        1.03 ± 0.02 times faster than update-ref: create many refs (refformat = files, preexisting = 100000, new = 10000, revision = HEAD~)

This change also leads to a modest improvement when writing references
with "initial" semantics, for example when migrating references. The
following benchmarks are migrating 1m references from the "reftable" to
the "files" backend:

    Benchmark 1: migrate reftable:files (refcount = 1000000, revision = HEAD~)
      Time (mean ± σ):     836.6 ms ±   5.6 ms    [User: 645.2 ms, System: 185.2 ms]
      Range (min … max):   829.6 ms … 845.9 ms    10 runs

    Benchmark 2: migrate reftable:files (refcount = 1000000, revision = HEAD)
      Time (mean ± σ):     759.8 ms ±   5.1 ms    [User: 574.9 ms, System: 178.9 ms]
      Range (min … max):   753.1 ms … 768.8 ms    10 runs

    Summary
      migrate reftable:files (refcount = 1000000, revision = HEAD) ran
        1.10 ± 0.01 times faster than migrate reftable:files (refcount = 1000000, revision = HEAD~)

And vice versa:

    Benchmark 1: migrate files:reftable (refcount = 1000000, revision = HEAD~)
      Time (mean ± σ):     870.7 ms ±   5.7 ms    [User: 735.2 ms, System: 127.4 ms]
      Range (min … max):   861.6 ms … 883.2 ms    10 runs

    Benchmark 2: migrate files:reftable (refcount = 1000000, revision = HEAD)
      Time (mean ± σ):     799.1 ms ±   8.5 ms    [User: 661.1 ms, System: 130.2 ms]
      Range (min … max):   787.5 ms … 812.6 ms    10 runs

    Summary
      migrate files:reftable (refcount = 1000000, revision = HEAD) ran
        1.09 ± 0.01 times faster than migrate files:reftable (refcount = 1000000, revision = HEAD~)

The impact here is significantly smaller given that we don't perform any
reference reads with "initial" semantics, so the speedup only comes from
us doing less string list lookups.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/refs.c b/refs.c
index d91a2184e06..111e3cf3aa9 100644
--- a/refs.c
+++ b/refs.c
@@ -2477,6 +2477,7 @@ int refs_verify_refnames_available(struct ref_store *refs,
 	struct strbuf dirname = STRBUF_INIT;
 	struct strbuf referent = STRBUF_INIT;
 	struct string_list_item *item;
+	struct strset dirnames;
 	int ret = -1;
 
 	/*
@@ -2486,6 +2487,8 @@ int refs_verify_refnames_available(struct ref_store *refs,
 
 	assert(err);
 
+	strset_init(&dirnames);
+
 	for_each_string_list_item(item, refnames) {
 		const char *refname = item->string;
 		const char *extra_refname;
@@ -2515,6 +2518,14 @@ int refs_verify_refnames_available(struct ref_store *refs,
 			if (skip && string_list_has_string(skip, dirname.buf))
 				continue;
 
+			/*
+			 * If we've already seen the directory we don't need to
+			 * process it again. Skip it to avoid checking checking
+			 * common prefixes like "refs/heads/" repeatedly.
+			 */
+			if (!strset_add(&dirnames, dirname.buf))
+				continue;
+
 			if (!initial_transaction &&
 			    !refs_read_raw_ref(refs, dirname.buf, &oid, &referent,
 					       &type, &ignore_errno)) {
@@ -2575,6 +2586,7 @@ int refs_verify_refnames_available(struct ref_store *refs,
 cleanup:
 	strbuf_release(&referent);
 	strbuf_release(&dirname);
+	strset_clear(&dirnames);
 	return ret;
 }
 

-- 
2.49.0.rc2.394.gf6994c5077.dirty

