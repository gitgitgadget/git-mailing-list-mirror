Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54366233149
	for <git@vger.kernel.org>; Mon, 17 Feb 2025 15:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739807435; cv=none; b=gmAeOqX8G0D/uy7Tjp1tp3LezZQPNBdWbVqdReL7GL/A7UnSBaGoVHSzA8I9FqxPTFO8R2bed/6oW9PISfHPVIxFR4aAAacZXTWulgvQqXtBmN2L6TQHrXRRG9R2UcGGUWLNI+DlEQu0x0qVsjqFb1j/DCRZ8qWMi4AHJyeapCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739807435; c=relaxed/simple;
	bh=GRybU3ddo8jNa/e4H/h4o6w6c55Rs2sgp2EONBlIfSM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xr6FPE1xsjoADfHdYt6UrU60ZIu6nXu1YHYolLtQD81y0nt+I2lYAn2Nu07IrHqSiwo2SegZdcy2yMXgJVzqUzZAE/VXLO9MULx7y1qgo47TS/dWV8g+st3Wzww3vQGKA/74mF3SVpUhTVE+hKO31+PuwHNiC/LNkV+5f9jIqHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WiTzJ9/j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vuijySbN; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WiTzJ9/j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vuijySbN"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 65C58114018F;
	Mon, 17 Feb 2025 10:50:32 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 17 Feb 2025 10:50:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739807432;
	 x=1739893832; bh=gj8adUcl5mtfgWscozBKmUTV3R6tsqe6NsfpjkcikGA=; b=
	WiTzJ9/j6CVf7dy4nLRg4Lp0oLNq7QzdSLEUpfvFnXoemg+EzeAWePuFqOzk3Vwg
	LdkTN2IWsia24tGkjr2F+GChaY/5JoXbEIrg6eNTAu3d5o0l56j2/Ty5rJyunLNW
	0ouESr/cvPsWVMeITYMz5RFA5IDVsC5QB4znB7fZ5tTGByVw/OxSb/X/jO7h54WS
	h7PnYL2li8tCQM00/Lv2ULCFpOmDB097PRc1pjgmgquixedovyB0x4uBGVMUgEUN
	OLv2oj+9G0ifFtfFRjI1RyBkoRBNBJNIOmDCUNikP+jgQ/6ZOpDF3Ot/wueB3EMR
	bjc/DtDyzfvGLlFmdjOWgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739807432; x=
	1739893832; bh=gj8adUcl5mtfgWscozBKmUTV3R6tsqe6NsfpjkcikGA=; b=v
	uijySbNOCBqkK4QYKGu8DVRERH9FFBjOI8tboeqtv3u6l3i5ZbT6lgL+2lwwLN07
	1FlBWp+jvf/CdNhK6PVh5pvrgqg0JesmoqDflUQmIYBg+tfDEssW+8yw2N0UdQ1r
	OJUw5pFAzgLsiuqakhEj7okg5IBVqTP31IT55g5nZlZc9yP/DcX4cBsstw+fqwT/
	hLjPjX56fgwGsWmGEU5n/UCwv2pyJbNop4Um7EPn0UfWGibQhTocfMdx44AmWSJS
	enl+f3sYbtc7f66cSukx4lDIzxiFj5jq+CZisMghDekfuOaY12E/OiFRCsfyrD/R
	2o/P+2VLAtOl8T1YV+RgA==
X-ME-Sender: <xms:x1qzZ5pgc6rnRTVuiDTjEQA4CR8icoOkyfKE3tW3Nrm0RvUvrjQMJQ>
    <xme:x1qzZ7qZ2B3B1F_Un_yD6fo1rrpKyQ-v7CVw9DSsXMY_icowXa3YVIJog9c0xAyPF
    sVlKfXERDwNIn5TNg>
X-ME-Received: <xmr:x1qzZ2PoLkpMqkSP6X1c-wa0467sq2D9kzQNpBsUU8T63sBCpFnGHcwPHAOCtw62XYqBGZRLWaCUh2vgool9Ophajo4dgW3E20lHF3ZYgfw3i7Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehkeekudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthekredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepfefhueegleehfeejkedtffehvdfhvdetfefgtddu
    ffduveevteegueeutdekhfegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtg
    homhdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhr
    tghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpd
    hrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:x1qzZ05Q6RRuC-ViHxyCC8tjV4YX00o55rrb9F2CnuZ1Dyis1eQaug>
    <xmx:x1qzZ44JqW3JfteGnlAY-bvVjWHdICTVV4hmoy_HzLICS8NGyGyvNg>
    <xmx:x1qzZ8hBXQMlwp7xDfPJf-Bpk80fXey2WM_MuM5CVXF_aLco2IhhXg>
    <xmx:x1qzZ65DzL7EYmHlrCb6LS1-VzwSt5h9Y6APOhamJDlfl1SE-fFbxQ>
    <xmx:yFqzZ1sgQl_RaSXYK2sDXLdBgdKjMUlG6026GY5sw8umaOBxUspBTPc8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Feb 2025 10:50:30 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 660f2543 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 17 Feb 2025 15:50:28 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 17 Feb 2025 16:50:20 +0100
Subject: [PATCH 06/14] refs: stop re-verifying common prefixes for
 availability
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250217-pks-update-ref-optimization-v1-6-a2b6d87a24af@pks.im>
References: <20250217-pks-update-ref-optimization-v1-0-a2b6d87a24af@pks.im>
In-Reply-To: <20250217-pks-update-ref-optimization-v1-0-a2b6d87a24af@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 Christian Couder <chriscool@tuxfamily.org>
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
to a significant speedup when creating many references that all share a
common prefix:

    Benchmark 1: update-ref: create many refs (refformat = reftable, preexisting = 100000, new = 10000, revision = HEAD~)
      Time (mean ± σ):      63.1 ms ±   1.8 ms    [User: 41.0 ms, System: 21.6 ms]
      Range (min … max):    60.6 ms …  69.5 ms    38 runs

    Benchmark 2: update-ref: create many refs (refformat = reftable, preexisting = 100000, new = 10000, revision = HEAD)
      Time (mean ± σ):      40.0 ms ±   1.3 ms    [User: 29.3 ms, System: 10.3 ms]
      Range (min … max):    38.1 ms …  47.3 ms    61 runs

    Summary
      update-ref: create many refs (refformat = reftable, preexisting = 100000, new = 10000, revision = HEAD) ran
        1.58 ± 0.07 times faster than update-ref: create many refs (refformat = reftable, preexisting = 100000, new = 10000, revision = HEAD~)

Note that the same speedup cannot be observed for the "files" backend
because it still performs availability check per reference.

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
2.48.1.666.gff9fcf71b7.dirty

