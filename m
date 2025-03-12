Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7327F258CC2
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 15:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741794990; cv=none; b=ZaeOLXO5N5dElT1ulC2MrIp5aK2q0TUdGstIiTzyXbIr42e4djTmHaXtKOul83KyLZU8itH0TJW7eHf3Uhjby+VqcFr9+CFWSHtRhvX254qDB6ObTAPKwBrzjaM5r5joCnALpQvGp+qYLuDvfC22h1Iq8e5A+yj1ZQsJW8vj6Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741794990; c=relaxed/simple;
	bh=5tg+G2Clnt85TH+wt7ymKR0AYZTAOvK1o6buBp2mvCs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jGNRelKdLOS4A3a0BPRobd4HIqQ8WOoWcdVoKkJs/PGVS3jwfzyeemMc555P3YGtZVnZEU6qnQqNnsLuaEjXKRCDuyTa+skgUvBbVS+t385Z7GNhw9LbvW/92z3xy38droJi/Bk6sE7fFh/nkv6DiVmrUAv4pxBcSwypvY3fHwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=h1LmyMzy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wURCI9t6; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="h1LmyMzy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wURCI9t6"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 81F462540313;
	Wed, 12 Mar 2025 11:56:27 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Wed, 12 Mar 2025 11:56:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741794987;
	 x=1741881387; bh=IIKO4UwfFdArCIOPXfyULgZLN5Z5tkYDFn8j16KhbNk=; b=
	h1LmyMzy7v6qjksY1xhuILf1GB/IlKlryCdrvV/w41xysu61r5xyvaRYK7OxXTS4
	hZYOq/qPclmANa+rFGJ4Z7of9SMKoxAjdTd5/m5ZoFtYxMGTAGXnhpQETKCdHhVq
	7rEpFW3IM/q+aem1MrUvmq8WWNz1USb6/apf+QzTvYIjKpPRO4mOxiO26UhH7/V0
	jWapKr67BmcZjRLE57GlS6y7Shrj+sLZYFPICDR/GvCM0QpdXBuMhWCQtXP1kzSB
	1JPQzWzubGgvdFI6mCKV1Mc+iltkY+ejV6D8Qg5eKBbgvo7XBUAJNY1I+TP5IuUa
	/BeVWowDgrzs50ot0qVbRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741794987; x=
	1741881387; bh=IIKO4UwfFdArCIOPXfyULgZLN5Z5tkYDFn8j16KhbNk=; b=w
	URCI9t6OXYojvoKRZI7vQFqPwS0qdhUJtrO7CKc2Vgyl5nxE1oU5iPPBW94PJfeO
	m+KjHax1QchvmMZwyBX4iC7VWiw50ozYRg//CjRyHLcxeceLg2asBII5sFJe8b4H
	Fa3ioSueY1UjkERiMCVvwIXnRwjZal7ivKIFrcz+cttV3hl+HqGTO4aD1z+Gw74z
	x5fVJRPpaVuydA7E/cXdWDduPsPp24rYCE3gv3P4FiYZizzhpgBL5Ig753+SV+k2
	YfRtJxmh2Z0xRPHmEgmNrShAh//dv81mvkLrKof/payfwv0F/drS3C3X5ydPMvx/
	0SMC2/oj6RxhexNcnA8Bw==
X-ME-Sender: <xms:q67RZ5PCd1IEM7a2_8Z0nhAeN0GfsgU75ZnGtJF-Ap4fi7QFuO-URw>
    <xme:q67RZ78GSNfSK22xB7cK55NYjgPqGRs234onIWC6XDG8L7eQ0RHD8mv-JxNQxXDzc
    e53wm0ccIYU1fGfkg>
X-ME-Received: <xmr:q67RZ4TRLjG6bV8iWzj9B58W1Sj77dccPwZhuHjAV0lvAcv6jluwQnPbMAhIpaUWH7U8hxErJPCvR1RUTmHExM4AB7GH_K230PZHZtGr9q3YsYSlcQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdehgeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeefhfeugeelheefjeektdffhedvhfdvteefgfdt
    udffudevveetgeeuuedtkefhgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpd
    hrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthho
    pehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgrnhgurghlsh
    estghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtoheptghhrhhishgt
    ohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrd
    hnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:q67RZ1s5v-OX9B37tho_CL8OK6K4ahHldN8xPEEVfLYwlgVZes8_2Q>
    <xmx:q67RZxfyGszC2ZdMAQreb15gdg30OfYIjSCowdk-v6aW5_srNohUvA>
    <xmx:q67RZx1aFL1naLEOLVCP-Ld8Jpr8gsTXh-cmrktm7lWq2rDpKvU7nQ>
    <xmx:q67RZ9_9-XXkixaxKUdNhQxJr-wTzlU0F5L1Ol8gzgxkwJ9ZmDQ9NQ>
    <xmx:q67RZ7u-TNrpXcMphV6uHzQn4MYi7SFarig5UniWzLKOMkotaGI9oBZM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Mar 2025 11:56:25 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 298ff104 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Mar 2025 15:56:24 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 12 Mar 2025 16:56:22 +0100
Subject: [PATCH v6 16/16] refs: reuse iterators when determining refname
 availability
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250312-pks-update-ref-optimization-v6-16-f778e0414f55@pks.im>
References: <20250312-pks-update-ref-optimization-v6-0-f778e0414f55@pks.im>
In-Reply-To: <20250312-pks-update-ref-optimization-v6-0-f778e0414f55@pks.im>
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
index 3e65ccad7ac..5f0dbee3aff 100644
--- a/refs.c
+++ b/refs.c
@@ -2556,8 +2556,13 @@ int refs_verify_refnames_available(struct ref_store *refs,
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
@@ -2570,9 +2575,6 @@ int refs_verify_refnames_available(struct ref_store *refs,
 
 			if (ok != ITER_DONE)
 				BUG("error while iterating over references");
-
-			ref_iterator_free(iter);
-			iter = NULL;
 		}
 
 		extra_refname = find_descendant_ref(dirname.buf, extras, skip);

-- 
2.49.0.rc2.394.gf6994c5077.dirty

