Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C56825D1F6
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 09:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740734816; cv=none; b=IogEXCD/qajbIDNnAj43lDfYRSYu2pyFz7+B0eerfymohSzKgAcz/uWAdX8phsgFPVabTOKvAa5AZnmok72+bdBBTIgS1L2TSH505jHnyPfHHV44uwxCCNfRW7anTf798fLfpFEypQ9wet6DR19tS2ircEGAvKFPTMI64iBvogM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740734816; c=relaxed/simple;
	bh=djR+dlgvvccXc2F9FSHhje/BoVAVZn0A2imEnF7DfQI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ydz1aRlIGmI4yclZTb7zkfFb+bD7Guz7Xg8bF6NOa9T/T7MP+9MNcudDUgwo0ZWnEvI9bh448f3wRw06Wnowa8efhpZEpKLEOf0RFE+OIcqQ0z5CAS9qFNsTvG8a/INZ9rTUPI3dCb0l3X5luuu7pJzjt8HhR7Vu1FkNHhLnuFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aBLlniSC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oJxMEoRL; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aBLlniSC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oJxMEoRL"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6F42B114039D;
	Fri, 28 Feb 2025 04:26:53 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 28 Feb 2025 04:26:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1740734813;
	 x=1740821213; bh=5hlnSTuqaHaHcOK/3q4xmf4Ir0bWgMepuDXmgy5XHGs=; b=
	aBLlniSCy8vFtkyjnJF/DNKaKYvO0wjvWvN6e8Uu91bb5hloF2QDqstZ6b7J3iin
	NnhhvxNRcVRDAZ/Do+k6zyJEslQzblVYqwzTrimYClSrdlIevQk72WIF26fi+bm4
	AdJzxFU+AupHeVFzf+nKjskj+OxuqRSYlSmdTAeJlh2/9Px9grckEQ8+PAtGlSRh
	y5AiAj2qAH01Ck7cQUHCaJ8/DGwsRRmNXoIbxFsfprfrTHLIqogYcAE4ILl6n9sl
	SgvVoFw+LbQ0McbDKD8N9eVYkyE2nGdqZs/nk1aZYJNRmB3KbiZDjk42G+/Nr40z
	BhXk+wKyDCDYiTYjPFR1Fg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740734813; x=
	1740821213; bh=5hlnSTuqaHaHcOK/3q4xmf4Ir0bWgMepuDXmgy5XHGs=; b=o
	JxMEoRL0CpAL45DqJMzM1SAcpMO7GZALm+sfU/69cibqmsolywlwr23Htx8DU8iX
	mOO6wbXnx3b67PscCcQhZgHeyF4DtqaA+3yx7tcSxjNY47yhWgdJyJe6A0XJv7SA
	S/7SGavXpg0ZMF+I8j+LCFkIzl8M9jIGCJKkFDCqZoPTBwfQ5SKh9OJSiZz1Aomq
	B1dyU+JJ3CrTJ/1I2lREP9F3Drij7CFfzIuIIMtsjtkZIPZuZu4KJGgSMZdVIfFW
	BLeDgfLF6BExIPfcpxUfH8n4QN7/HkNm0RUskHNnwagaCB3xiOWGDpSArvR8Kpht
	1HFHF+1Wz69+cCuhK+P7Q==
X-ME-Sender: <xms:XYHBZxm7i6TH8JtzDcYa39qsN5tJbl7mVltw1rZNbTm-m89p-Pu0ow>
    <xme:XYHBZ807mQrzkxPLM9kdD8K3F_w-ivhzCkt6DFVaHE5ZgdLsnaddvCgCoY8NTqblq
    tdVatVoYc1v_BmE1A>
X-ME-Received: <xmr:XYHBZ3r8VA0kIbxvCZQ9xZSlkOqjh25OViZzA-xruZxHV5CDjx6GoRTXuqufUEqaidalKyp_cA5mGGzDUev-xWP64QbANTz_cfukApfNZ8-LqFkG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeltddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthekredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepfefhueegleehfeejkedtffehvdfhvdetfefgtddu
    ffduveevteegueeutdekhfegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmh
    hilhihrdhorhhgpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhp
    rghsthgvrdhnvghtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtg
    homhdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:XYHBZxmIYNn54CK_TbKTqTLnkV1DSuZFhQgCFycxya3sbyjkG7NJLw>
    <xmx:XYHBZ_0ssKlztAtHwH4dDBPH2-Xr79fKsjjdgvLHFpDqXhO1CFkEHQ>
    <xmx:XYHBZwsSkej_VMGb2h2xBPTlJ942JhW_hywFLooY7itGCbEXbXv2Vg>
    <xmx:XYHBZzUivPqkQEBiagjTCtNCwh3hFZGLdA9VCCt_eQuUIpkGeKFazA>
    <xmx:XYHBZ0lTrc7FEZ8PTFrzVc3xoVt1BlVBPuJacSDlBFaLwWSiBRKyYMVQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Feb 2025 04:26:51 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e4bf3802 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 28 Feb 2025 09:26:51 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 28 Feb 2025 10:26:45 +0100
Subject: [PATCH v4 08/16] refs: stop re-verifying common prefixes for
 availability
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250228-pks-update-ref-optimization-v4-8-6425c04268b5@pks.im>
References: <20250228-pks-update-ref-optimization-v4-0-6425c04268b5@pks.im>
In-Reply-To: <20250228-pks-update-ref-optimization-v4-0-6425c04268b5@pks.im>
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
index 5a9b0f2fa1e..eaf41421f50 100644
--- a/refs.c
+++ b/refs.c
@@ -2476,6 +2476,7 @@ int refs_verify_refnames_available(struct ref_store *refs,
 {
 	struct strbuf dirname = STRBUF_INIT;
 	struct strbuf referent = STRBUF_INIT;
+	struct strset dirnames;
 	int ret = -1;
 
 	/*
@@ -2485,6 +2486,8 @@ int refs_verify_refnames_available(struct ref_store *refs,
 
 	assert(err);
 
+	strset_init(&dirnames);
+
 	for (size_t i = 0; i < refnames->nr; i++) {
 		const char *refname = refnames->items[i].string;
 		const char *extra_refname;
@@ -2514,6 +2517,14 @@ int refs_verify_refnames_available(struct ref_store *refs,
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
@@ -2574,6 +2585,7 @@ int refs_verify_refnames_available(struct ref_store *refs,
 cleanup:
 	strbuf_release(&referent);
 	strbuf_release(&dirname);
+	strset_clear(&dirnames);
 	return ret;
 }
 

-- 
2.49.0.rc0.375.gae4b89d849.dirty

