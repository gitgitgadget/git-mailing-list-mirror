Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CEC20A5C3
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 15:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741273735; cv=none; b=jzqvS2wrOiA42xDrQn13+oTcTtiaiMnkP3Nea/z+Wg9niqd4mUk79gbZX4gc/t6fiRKNt+SsCnK5mNCbWNE1kNv5QXXd6UpOucGyTvtW937sPqY9yh3BhWlXLKKYQhjRHXPEHkgvfn9P97daqrn8gYjqpJoZ4x+FI9anvfU8V30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741273735; c=relaxed/simple;
	bh=g309z4lpPFfc92DHQgf0Sr0PWz90aVgPHX5MIkrcPOk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B+JNSucRT7NDWAoOySuAErtamF7H9ASi96yDfyWI+gfLzigDAhLcp3eGs8wZd96rT+vUzr8iVFjU5AE+CWYPCd+D0JkdRXaefuatNXQzNMaUWgMwwT/lnQmaFIIAS/607nTJpOnr8k4egBvbeOvmUdESRDw9Jr1EeW1HNCyD5hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kC/uRoaC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MCNb6QcK; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kC/uRoaC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MCNb6QcK"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1169D25401EA;
	Thu,  6 Mar 2025 10:08:51 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 06 Mar 2025 10:08:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741273730;
	 x=1741360130; bh=6RbOaUK9X4EFI0P6ELntM3L/LLIBGOffzWAmhyNn4mo=; b=
	kC/uRoaCNMlKJqW5+teluBoDj8Sg13PISXau3JGdgkW2yO6sy86P4RjxetZwPMDK
	kjterVHhnjPHOJPH/6yFnLV3WvzMB5i2IhHzlzHR1SYKtBJjZLgA2tRT9fmMDPk+
	IXjlw5STgn6EHSQP//+gbE6l/LtBYcJS5h5jMfD0O37WYe8g0QgYOUgefUbzOoKU
	68yTd3ktmYV50uqPmwqMmqJn0UKoQMwOHbemNTUR0TvKRNapPYatfgxlSo5uHvOH
	o5MFHFkCBY8Etyoitx7kgK0xs2OjN9/iJdQre2Uf8lERiR61l8uUBUZccEArZFkM
	wLTDDiGk8KTMbvAQhZhcGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741273730; x=
	1741360130; bh=6RbOaUK9X4EFI0P6ELntM3L/LLIBGOffzWAmhyNn4mo=; b=M
	CNb6QcKQ5+LpGDeT1ZLXcQ5wssXSIcBzrYZXHc0z8qtjcI/vug2pdWsAZzW0PH8w
	Bnqeei5HEaqIJhLyMg+0orv9yEQPff949CZnBZ4V2rBgAFP++Bq9nfiW/rzcxJt7
	5QjPvqVX73u7L0Dg9XW4HAfcrATaSA0dMT5sdVRbwlLxZSQOnpVDXrJoTekzFwPT
	mmUDKtT0QOCzJb9CrcBjNW484GfHVySYUkNX2AuCtdntCC0kyQ44IbVYnYeQ+0oW
	p7d4HOJRby3aQB118E/u5QbfRzKc0xiBUXRxBdndKg4oUjUsIcZhwrd2rkE5SBBb
	vdLb4Ud0GcDHv6Yf1jA0Q==
X-ME-Sender: <xms:grrJZ1lbWauV0LB2GGW8VQe-YW3d2XKsh6W_H-yRGTnOWGkl158sGQ>
    <xme:grrJZw33H-k07IBn1XIdzr_A7JwD56sYGdLceErgz1UQ2H7KBwVOYuof48bdWWJYd
    7KF4CdTs_G2Ie4O4g>
X-ME-Received: <xmr:grrJZ7o27vd45YhyohuSZM-WBIZ_bQiSvRxO7EOdIljMyUYfiO_d575KNxWQst6JnW8HzL7mV7siMhCSbiYvY9Go-lyJjoxKfUPTEYpKkpBQEg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdektdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeefhfeugeelheefjeektdffhedvhfdvteefgfdt
    udffudevveetgeeuuedtkefhgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtoh
    hmpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgt
    phhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepph
    gvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:grrJZ1nV85nOy749U-vAErUlcwQMNjr42aq_ma7W-CNN3ImCR3qM4w>
    <xmx:grrJZz2Rz7YiOMTkTRz2yWpqywZAun4zSiuPD9hu0dcq5zSwYh_QNA>
    <xmx:grrJZ0tBAJ7IsLNjHtqA5pIY9l2vntJXBUjpi7XrU_wGQBelH8LbCw>
    <xmx:grrJZ3XAhi4WeEuN5qs4g9H5qgvX3rSIhyR2EH3NIcy3SpfXXfZbTA>
    <xmx:grrJZ4leWTUt3DhGqvv-rzyvGIBlOZa--ZcTFDmEvpOf_YllzRvj6dZH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Mar 2025 10:08:49 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 99a4d734 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Mar 2025 15:08:46 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 06 Mar 2025 16:08:39 +0100
Subject: [PATCH v5 08/16] refs: stop re-verifying common prefixes for
 availability
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250306-pks-update-ref-optimization-v5-8-dcb2ee037e97@pks.im>
References: <20250306-pks-update-ref-optimization-v5-0-dcb2ee037e97@pks.im>
In-Reply-To: <20250306-pks-update-ref-optimization-v5-0-dcb2ee037e97@pks.im>
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
2.49.0.rc0.416.g627208d89d.dirty

