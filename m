Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6FD1E2842
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 13:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739971434; cv=none; b=cB7ZfU7oabjfquIv7rqdm7TkEVjvlaDmQ+95OMZ1ya1SI+8x36yLKvkvRb8AJ22R2No2NOwWjTRJM/IMCL/071jql/z6LbnoAYWyhjO9523ZLVwINdvYv8m9cl635i6YlIhVQTelzSz8xjKwFJtY8PyGV+cXfcaagvzm6tDNAqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739971434; c=relaxed/simple;
	bh=gf5XcntSHq4tygDKcASbHcosADwNd2ifuC/aSuPtvho=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KYcGyH9YZ0nqr5YiuriYnNgApHS394pj95hx/7eLSxZn2JnArgkhpYd8nNU1pU2kBTjUTwyKTi300ew3ro96PtZh130U1RKJUU6jV3+AYpdzRPR3JrFWqFmfWYZKBp7eGeh5ZNYsTFkt+PTQ+QgyHGzq1Tnr701PiQem6gtbgkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fWCfJfzd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M/ebpCuK; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fWCfJfzd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M/ebpCuK"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 66B88114014D;
	Wed, 19 Feb 2025 08:23:52 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 19 Feb 2025 08:23:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739971432;
	 x=1740057832; bh=pTNe9ddajIHL5/9XXPG1GUJ51x4aMkEBVV2IPVlXJMA=; b=
	fWCfJfzdnnW1W7AG5QKwSclUfGV4m4vAq41JyY119QiAJ5nY6HJncZdHZEO0gv/M
	aNcN977cuPoA3qUeNDceUb9lTGIFymnL9QDZrqwfRitqaQSDNz37VUW6XYTj9INU
	FSUsWpu3GCNiGMVMRq9giOVAocMRnKGUOWW6hZtUCRNCWM15kJnZ85FyoK6TH3NU
	XVK2h3B8My+7Y2326Ymst3hivXkZO8vM5MXSGoaAoLEANcUKqOOSPJLtlDNbyOGc
	y4qiGUKChNUR+XJY5XVe6EzeFz6QmRf/ewR7CVkKJDNcY8msLGlK0Hp0AfpDrc8Y
	Gun1SB3ilUsWzPrsF2imPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739971432; x=
	1740057832; bh=pTNe9ddajIHL5/9XXPG1GUJ51x4aMkEBVV2IPVlXJMA=; b=M
	/ebpCuKI8aEbacEIaoHC6uPpMLhmrEjtxvfi6CQIUEXvAXMuWmf+J8azseGG2KOe
	sslHisNmwM81XGiKNvwcPvFRKGDvkeQSswJ3EcKwW71TA8ZsNaY8eGdfdif/LoXq
	Lm10vOt7O32O++XHdhM6IHfcsLkJMHSBbzxk9EWuT8/ZODYFK/I9QoiW0KkPKqIo
	as/+sy/ODWGrGGiJ+lV7lSBc8bpYT8TT4VbnlIe0/DXH+X2jehJUOq0+uIu0rAcQ
	QVwfrIxDlQwGp9gZHCnFgcHZqRTIDPYNQP0KYh6EuZ/v/kZ9FfA2Yqj5jBF+02ns
	XfGJ7gCWcSVDlNmTyd3vA==
X-ME-Sender: <xms:aNu1Z6CE85A3YuIycwjdReyjrPaZ1uq5GB5vU4jCC3hANauk3ffx8Q>
    <xme:aNu1Z0hUTcxiB9J5do_XfZIsXQFTc3F6IhmALBp29iOkg8ZxI09eF6RO5c8UqAs_v
    EFYedsauGwZXcc-Hw>
X-ME-Received: <xmr:aNu1Z9nqZZAfmf6SMAA278dV6pZKRSmVA8feGLqqtSJugOkM9bbenkKw-sGw3w8AkCtbdYPXosWVoQDGQ0QtP6GGwG4NlQXuV5Xc9pva5AxDcv4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeigeefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthekredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepfefhueegleehfeejkedtffehvdfhvdetfefgtddu
    ffduveevteegueeutdekhfegnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthh
    hprghsthgvrdhnvghtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprh
    gtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhg
X-ME-Proxy: <xmx:aNu1Z4xgU_9k9c38nEOtrCx9wSSdAW6oOAny_tMtBypxjPr0tzgozQ>
    <xmx:aNu1Z_SnkUQat0VFWj2al0sRsB83uA-UwV1h1a9_CRbPBShBC6mm8A>
    <xmx:aNu1ZzZXwPwBF3O_zrRcUNflONfhNP_eumLrAp2FjOrA_ruqd8-mqg>
    <xmx:aNu1Z4Q3pRiu4OFGqJr6FNnYSLToQnOFj_ibMeHRnNwmBjXE1Gk-tQ>
    <xmx:aNu1Z4SAVJ1lZdryfdGsuOHT17uDvP3V30g8-hjtFPHWEEEwe1qH-pTc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Feb 2025 08:23:50 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id db9ceddd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 19 Feb 2025 13:23:50 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 19 Feb 2025 14:23:43 +0100
Subject: [PATCH v2 16/16] refs: reuse iterators when determining refname
 availability
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250219-pks-update-ref-optimization-v2-16-e696e7220b22@pks.im>
References: <20250219-pks-update-ref-optimization-v2-0-e696e7220b22@pks.im>
In-Reply-To: <20250219-pks-update-ref-optimization-v2-0-e696e7220b22@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 shejialuo <shejialuo@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

When verifying whether refnames are available we have to verify whether
any reference exists that is nested under the current reference. E.g.
given a reference "refs/heads/foo", we must make sure that there is no
other reference "refs/heads/foo/*".

This check is performed using a ref iterator with the prefix set to the
nested reference namespace. Until now it used to not be possible to
reseek iterators, so we always had to reallocate the iterator for every
single reference we're about to check. This keeps us from reusing state
that the iterator may have and that may make it work more efficiently.

Refactor the logic to reseek iterators. This leads to a sizeable speedup
with the "reftable" backend:

    Benchmark 1: update-ref: create many refs (refformat = reftable, preexisting = 100000, new = 10000, revision = HEAD~)
      Time (mean ± σ):      39.8 ms ±   0.9 ms    [User: 29.7 ms, System: 9.8 ms]
      Range (min … max):    38.4 ms …  42.0 ms    62 runs

    Benchmark 2: update-ref: create many refs (refformat = reftable, preexisting = 100000, new = 10000, revision = HEAD)
      Time (mean ± σ):      31.9 ms ±   1.1 ms    [User: 27.0 ms, System: 4.5 ms]
      Range (min … max):    29.8 ms …  34.3 ms    74 runs

    Summary
      update-ref: create many refs (refformat = reftable, preexisting = 100000, new = 10000, revision = HEAD) ran
        1.25 ± 0.05 times faster than update-ref: create many refs (refformat = reftable, preexisting = 100000, new = 10000, revision = HEAD~)

The "files" backend doesn't really show a huge impact:

    Benchmark 1: update-ref: create many refs (refformat = files, preexisting = 100000, new = 10000, revision = HEAD~)
      Time (mean ± σ):     392.3 ms ±   7.1 ms    [User: 59.7 ms, System: 328.8 ms]
      Range (min … max):   384.6 ms … 404.5 ms    10 runs

    Benchmark 2: update-ref: create many refs (refformat = files, preexisting = 100000, new = 10000, revision = HEAD)
      Time (mean ± σ):     387.7 ms ±   7.4 ms    [User: 54.6 ms, System: 329.6 ms]
      Range (min … max):   377.0 ms … 397.7 ms    10 runs

    Summary
      update-ref: create many refs (refformat = files, preexisting = 100000, new = 10000, revision = HEAD) ran
        1.01 ± 0.03 times faster than update-ref: create many refs (refformat = files, preexisting = 100000, new = 10000, revision = HEAD~)

This is mostly because it is way slower to begin with because it has to
create a separate file for each new reference, so the milliseconds we
shave off by reseeking the iterator doesn't really translate into a
significant relative improvement.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index 8eff60a2186..6cbb9decdb0 100644
--- a/refs.c
+++ b/refs.c
@@ -2555,8 +2555,13 @@ int refs_verify_refnames_available(struct ref_store *refs,
 		if (!initial_transaction) {
 			int ok;
 
-			iter = refs_ref_iterator_begin(refs, dirname.buf, NULL, 0,
-						       DO_FOR_EACH_INCLUDE_BROKEN);
+			if (!iter) {
+				iter = refs_ref_iterator_begin(refs, dirname.buf, NULL, 0,
+							       DO_FOR_EACH_INCLUDE_BROKEN);
+			} else if (ref_iterator_seek(iter, dirname.buf) < 0) {
+				goto cleanup;
+			}
+
 			while ((ok = ref_iterator_advance(iter)) == ITER_OK) {
 				if (skip &&
 				    string_list_has_string(skip, iter->refname))
@@ -2569,9 +2574,6 @@ int refs_verify_refnames_available(struct ref_store *refs,
 
 			if (ok != ITER_DONE)
 				BUG("error while iterating over references");
-
-			ref_iterator_free(iter);
-			iter = NULL;
 		}
 
 		extra_refname = find_descendant_ref(dirname.buf, extras, skip);

-- 
2.48.1.683.gf705b3209c.dirty

