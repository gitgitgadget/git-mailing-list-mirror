Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB621EA7EB
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 13:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739971429; cv=none; b=iQ/awRN9Kz3fFMA01DkzPC2So28NM/k4wYsvUnYxjaAtkikK2sX3GyFh5ncbyyAq9b84uS4yTPSquyddno5J2mdEJd4hAIydPhUfmds5YB1wD2Jg5AgyMrYsZsUvK7D3jIcNtOIFD4a+n1m83NxTDvCwIryiYIMWa51GwP/yAw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739971429; c=relaxed/simple;
	bh=DWF/hlQLvJwOUtGOy7XvVvAfrlp4qBhn/8d2diuDvdQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RQFI7q6sQux02qwffUJMlwkH3Nwm87GUZI5K3Jhw4WQSKMtiWEYrqunfe7ibV4fb0thjFVNvKs9PQahsxAIEWjewppz1rF7YcTfZQuaZ/idcS3Q4N7ytUxK+n62b5u3/g3PkyYCBwKo/a7F0YC8P+hBghWSJ3B1kMwtMELZZUuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Si6YuOtT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0kC5PZjB; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Si6YuOtT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0kC5PZjB"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 6258D114015B;
	Wed, 19 Feb 2025 08:23:46 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Wed, 19 Feb 2025 08:23:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739971426;
	 x=1740057826; bh=V2hYn8hPRi4PRIbMCQMxe8dtw/GwKodOAx+ZrfpcqPg=; b=
	Si6YuOtTcWdVk0QyV2BmX7N2CE5g9bHWIJ8hmGrww1THqzwLkIxgBlJ4QSQggE4l
	i/gO9c3KgQGdOYk2UN++6YdwUDmhS6aBcOUd727kmeM5W6njS+TQiBPRGY0RyFOW
	XZgt+DuVsvHDyyUkfQNr4MYiWM0kQ2uIFBtEOGG02pJ6PM/8xYP/P1AyIe/zwt0g
	wh9NalRt6s4N1fI+QxpEb0fuDEssBNaFuQIwJq4Gv8CpaP24pH52wvjTp6Nzp5yd
	0dcQQkB+mbFBnGf88lq36RX1Y0w7dc8dt9vAEQSN6xKPT9h0tv1c0lIHGtr9lD7f
	izRRM5ng/gjtloG1L4ziDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739971426; x=
	1740057826; bh=V2hYn8hPRi4PRIbMCQMxe8dtw/GwKodOAx+ZrfpcqPg=; b=0
	kC5PZjBiCy19/s76Q0LlPEnyjc4lNropyrQX6ypzOp3IJKCbwFyRdvFAVk5peEbd
	7AeCQXye/VH94L/kI67NGSlLUYovH+c3z8Psly9/A/F9c4PyllaQNA0aSew+eYy0
	Yjk9jYnc/MiNUKLsjod6tboLJ3Evui6zPQzuvOHsHjepxYfc/YX4LgIl0jhnSolr
	zribCeR+uJT1v0/KWu/EjgguhcnZSPTWeS4BKpbMEIIVjeOFarR5jabGN0r97QA5
	9HQOA1yZ/zAqKbEbL+gno95VEZ9HbQn5sYa3Omj4dao8iCrRXT6xJBa7xQ8jKyHP
	JgdauokBH5/fFUssXEXjw==
X-ME-Sender: <xms:Ytu1Z16mC376kQdA7mYow1S1RjWaai8Pyl5rS7PYy84ADp5uMdeNqA>
    <xme:Ytu1Zy5mDE1w5CuwhdTa-Yu3lj-ezl3LPh63rRrYtVolKtpk23tYzV6ZKqO3bcv-m
    WbqLsWtIQrVRol8GA>
X-ME-Received: <xmr:Ytu1Z8ct3f_LO0h4PPS6Vn6lrQ9Ka-fVgoeJo4zNJQFecQy-pKgy6UQKkUNtdQrvOvr3X1KdpVDfA3J5RBO6Y56tTW15bma1eoa-wlP8K12A9Fc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeigeefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthekredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepfefhueegleehfeejkedtffehvdfhvdetfefgtddu
    ffduveevteegueeutdekhfegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthh
    hprghsthgvrdhnvghtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdr
    tghomhdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpd
    hrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffh
    drnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Ytu1Z-KzpLIIpED07uGitJiLPf4ehHBTiWYFyHd2Bx7oMnl_ItzsEg>
    <xmx:Ytu1Z5JnWRYcVSaZMqyE1rkumZmLmaGbLJ1GyIikKApn_jqVE5yPJA>
    <xmx:Ytu1Z3zhnG4Bp6bL-kz9uKB_s0Y9oKcd4s5UVMlRdaIfy5nHbDit5w>
    <xmx:Ytu1Z1L7TuSq1lDFw4nJ7U2dNTvPAhhkTiRuSsXYVOXnKKD6iiPJ-w>
    <xmx:Ytu1Z-rXMyiwx-xCdLDoWUsC0IKKzvqVEdPZsyarkpid-mMkoh3Pd1eH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Feb 2025 08:23:44 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6c1e8182 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 19 Feb 2025 13:23:42 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 19 Feb 2025 14:23:35 +0100
Subject: [PATCH v2 08/16] refs: stop re-verifying common prefixes for
 availability
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250219-pks-update-ref-optimization-v2-8-e696e7220b22@pks.im>
References: <20250219-pks-update-ref-optimization-v2-0-e696e7220b22@pks.im>
In-Reply-To: <20250219-pks-update-ref-optimization-v2-0-e696e7220b22@pks.im>
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

