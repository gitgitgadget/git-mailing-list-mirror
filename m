Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA58A263886
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 08:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740473770; cv=none; b=ngE+HtYCycnJXR3gBtgpyQIHukIsXBhdmcLstDIiBYCSnNITjepB3i8U1m5iuoySjK11hKM/3I5sqyWxhHNpfJ8UenLmR76GesXng8aJ/r5I3WrKPNPiztnIvks5S+lw9ieWnHPKs8TYXaWQepettIEgdlMnY6JGYMOKo1hOTOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740473770; c=relaxed/simple;
	bh=DWF/hlQLvJwOUtGOy7XvVvAfrlp4qBhn/8d2diuDvdQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cB+HFK716N6Pvv9bs7OHHGMe/tvtMx2/IsGhf2Ho7F8jE3AhJ7j1TdNIvksGe++Bw0I6sYNM4G1n++ZJiA7v3Mj6toHenUxYtrL93Lmwjban66mELcirukmmEzeX8yS4Uk3FFhDLpwz9tgGgpAOaF/TyVSi3+JOx/ZbQWYA0kxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dXPh5cQ4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sF9S90Q7; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dXPh5cQ4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sF9S90Q7"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 9F0DC114018E;
	Tue, 25 Feb 2025 03:56:07 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 25 Feb 2025 03:56:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1740473767;
	 x=1740560167; bh=V2hYn8hPRi4PRIbMCQMxe8dtw/GwKodOAx+ZrfpcqPg=; b=
	dXPh5cQ4kb2cVYd2gvhguxMCdSB4B46aVosVD9IhGKJUDQYQm/KNu2M4WNef3AD+
	/vzbk4PVIJRFaLU1Tsf64usliazJxwc8WweqsgsqbyX4Kda3ouWBSxmCckDn2JyU
	QIKjxb2oBRGssSTmPowFLe9Bu1mgmsI8sMn18swOL1HGeyU7QnrnQ5aR+BJe1qFg
	fPmc8e9AzBRxazkppftT1/8THPYp1xC4J2gGSplIrWnhvISRl6ZHecVxbpTvAOO7
	exaDyQS3TLFOuWopWu9tH9PoZAMXi7wBUfQcef4UznXwdXyCLmcSZ9BbIZ4+r4ps
	buKbgRFjqYMrpnq20QLONg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740473767; x=
	1740560167; bh=V2hYn8hPRi4PRIbMCQMxe8dtw/GwKodOAx+ZrfpcqPg=; b=s
	F9S90Q7Vjsq/enRZRmqOebqMymTLcxPa5Xerh5HIlIEJPpbKqwIHSI7B62Ni/Avo
	mIt4/wlqHQ5RxmcxZiFsJVenzAQM02bBS7GblINPPU4m0OhlfhYFjpco1w1WZ8Xt
	IvLUn5gIxfiFIUUA0Dao92+7LjM27vldw6Q0UyZAuFDCXysO5QaexPDOeunkELny
	ZYA3Gt3rJpNn89GGUf7n2SVKCih4U1csLF4/7rls8TGYew5IBJdrfYPX7sgWaXZ5
	qxKGol+f5g07w/wdEqRy6Uhg2HYW1183wdWoyRUo59rMQcUKwoRSMfGJUuFxlyn3
	2qLhaTOpEr76OeKVjvRsA==
X-ME-Sender: <xms:p4W9Z5LI8GLzqtQFYnkBmTDmoA3WnsN-qaX55lDFJ9irbCk4Yu5qww>
    <xme:p4W9Z1KuRj9jcnLMljJiTQihi0Tz21waEVxV-KeL1mhInM7pyN4tE1SWRM7EvGt7b
    wfr6XQzw6dyeTel3w>
X-ME-Received: <xmr:p4W9Zxs9rjhWf6FPwC0caXz0bOWNc0ljV6m6vsP7L7cCrfS4x1b6nYOQQtffSxvoTnvIL5J4zRUIBsz32jG9yy-035dQfMeOnx02xm1-miRqew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekuddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthekredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepfefhueegleehfeejkedtffehvdfhvdetfefgtddu
    ffduveevteegueeutdekhfegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtth
    hopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdp
    rhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvth
    dprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:p4W9Z6ay3bAelLWHWocf8icNifuTblptNKVqrCD5S7UpZh3Ear1tcQ>
    <xmx:p4W9Zwb5MV6tdH_4iGQQgQ3rabArzHoCvi-HLVJM9u_Tki14sioiSg>
    <xmx:p4W9Z-AHcUdnItqk2kWKsXj-JQOTQf9sf2ElmtqJnxsKC_8YW3QZBg>
    <xmx:p4W9Z-YrUe0VZWoFtfJvgYfln4l73tIChAoFQjQ7EmQpgVHwytjJGQ>
    <xmx:p4W9Zw5x4E0Yc9w-0MLYqvtKQXUdQQJ04GjmH1BTNdWNYzis28nBUpES>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Feb 2025 03:56:05 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a1569010 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 25 Feb 2025 08:56:03 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 25 Feb 2025 09:55:54 +0100
Subject: [PATCH v3 08/16] refs: stop re-verifying common prefixes for
 availability
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250225-pks-update-ref-optimization-v3-8-77c3687cda75@pks.im>
References: <20250225-pks-update-ref-optimization-v3-0-77c3687cda75@pks.im>
In-Reply-To: <20250225-pks-update-ref-optimization-v3-0-77c3687cda75@pks.im>
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
2.48.1.683.gf705b3209c.dirty

