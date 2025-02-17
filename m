Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3AA23535E
	for <git@vger.kernel.org>; Mon, 17 Feb 2025 15:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739807442; cv=none; b=RTKTiWDyClkDqhZMZUQkvJFN2+U4cqdV0INWpeyPGqQ1TYzC+gWKox8GB4IqgeitnilSjBj8hepD0mE7lPxe670I0ygEKZLh0nquF/nblKn9k1wiY13Mwi1xes9DeHpxSjKI3M5aKvLicxL1vP3kMUrdN0VHm+iCKPT2a/YppJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739807442; c=relaxed/simple;
	bh=9OeAJA2kLpYwq/IN5OzeZUEwPB5n+vXE4JtQVW77iV4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JsIoV3p6tPwga1h8PY31vHnygfaSGW8PziFhwS2AgAe5ac8IHPo+FkR3Br5tD+a0ptJmn0LZf3rOlyH6XSXW0BDULzgojtWbztT+YpqLoG+2nTqHpyCnM/dxK8uODp46nSPBhs354BF2u7P4VskDkeL6PAPjVF8dviE7dESUb+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gl6jpbCc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jRFx0s5q; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gl6jpbCc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jRFx0s5q"
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfout.stl.internal (Postfix) with ESMTP id 0B72E1140186;
	Mon, 17 Feb 2025 10:50:40 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-13.internal (MEProxy); Mon, 17 Feb 2025 10:50:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739807439;
	 x=1739893839; bh=NsLZuRcf9Q5id3sIlSaSf0EBH5X4YWl3g1hSxQFr638=; b=
	gl6jpbCcqTSgMPFTCbMJuwROY+EaUFb+8ehl3hnBimR+MSXpNkfYFelUDWQ762Jg
	ORfBbtLuOf71xAGmWPc38/Sr+TOI7Co9vyFymO7ecygc2kXHHt6nozO4GAL2FnFE
	NeD6jMigxpe/4J2MNg5n61u1q2gJ60wuIgWi9F0flRmhU7nicTMi0Z83aRiVflU4
	a83/0bJvW2fknDnUYF5sa3qz+rzlBpgYWy5GEYffRxrSW8ulGCQl0L2D9gsLwsUE
	I64uFiBbbreTNx3+z+er9xEqIL82EHQp9Q2PGHu+zV3rwC+kNOruiykA/OYT4qYJ
	SbPjXWA/4diCb6sWE7Evwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739807439; x=
	1739893839; bh=NsLZuRcf9Q5id3sIlSaSf0EBH5X4YWl3g1hSxQFr638=; b=j
	RFx0s5qBV7gNZjQvd8GUbF/R4PhsM5RO9mln1sRDEtjlt9lh7bGER3GTq9nA1n4N
	Eq573KmkYw2+mvA3Qct08kyeLt1IoGdjUxP1jVRjsogmrH2SKn9VaS/2sFb5pUL8
	3i8LPduPHK+ywDlTckmUIIOYjCW138BeeoS8Pv7hEjN0hbCUvyWw77nu6ImGx/c2
	aEvdNaymNCtv0cHopmDD1LJ2WqUtzbJ0h7YXsY1WIEjg5a13XGyzPcch+ch9QiU3
	OYRwIxBIsyDW1YvSQos1nq5NutvzrXm5srQkTmG3nuk0w54QM2aHc5C1C655oMRw
	yQo2Z4uy10KNv7l26+Ogw==
X-ME-Sender: <xms:z1qzZ2lHujg7mnZt6SY_gwTry0SREPGUkmt7umqyl2Rk50TjDFX42A>
    <xme:z1qzZ93ZOq6gD8Nk6nJvtH8fYo1wsWV062cNCdgNPAyrEQsnvLOcWNcNvIT22TgoW
    clbJHdVWCoX0gN3Ng>
X-ME-Received: <xmr:z1qzZ0qp54PTVxe6knIiB-L9iVZDwkjWfIivEiOqqmVN4nQDFoQrRxbymOe0u7dSTeUfDJU0WoCQ6U8y9Lq9wE4AfU_PKTZmiT2oq77UCML-jI0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehkeektdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthekredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepfefhueegleehfeejkedtffehvdfhvdetfefgtddu
    ffduveevteegueeutdekhfegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopegthhhrihhstghoohhlsehtuh
    igfhgrmhhilhihrdhorhhgpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthho
    ohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:z1qzZ6n81szhBuwaoqKxxRer2TGEJJzu04Es3fdJW0HXCF93I8iAig>
    <xmx:z1qzZ00umRSlpNTdakA80i-jLe_WeHeyZ3-yS4BQL3--kwabor1BGw>
    <xmx:z1qzZxuBtFpL4iOQ1gkz47KcPTwy3GZPTpYP_lagn3PFdMyKP-eeqQ>
    <xmx:z1qzZwXMWqznMbOUB-hqq-IW6TmCMqen9d8lhuQLTgtoJVeWhceAHg>
    <xmx:z1qzZ-pY3EIWOWRwtM8mqZaW43cT7vc_TrVyIztY7d78XQcycvfR1ssW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Feb 2025 10:50:38 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id da13434d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 17 Feb 2025 15:50:36 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 17 Feb 2025 16:50:28 +0100
Subject: [PATCH 14/14] refs: reuse iterators when determining refname
 availability
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250217-pks-update-ref-optimization-v1-14-a2b6d87a24af@pks.im>
References: <20250217-pks-update-ref-optimization-v1-0-a2b6d87a24af@pks.im>
In-Reply-To: <20250217-pks-update-ref-optimization-v1-0-a2b6d87a24af@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 Christian Couder <chriscool@tuxfamily.org>
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

Refactor the logic to reseek iterators. This leads to a speedup with the
reftable backend, which is the only backend that knows to batch refname
availability checks:

    Benchmark 1: update-ref: create many refs (refformat = reftable, preexisting = 100000, new = 10000, revision = HEAD~)
      Time (mean ± σ):      39.8 ms ±   0.9 ms    [User: 29.7 ms, System: 9.8 ms]
      Range (min … max):    38.4 ms …  42.0 ms    62 runs

    Benchmark 2: update-ref: create many refs (refformat = reftable, preexisting = 100000, new = 10000, revision = HEAD)
      Time (mean ± σ):      31.9 ms ±   1.1 ms    [User: 27.0 ms, System: 4.5 ms]
      Range (min … max):    29.8 ms …  34.3 ms    74 runs

    Summary
      update-ref: create many refs (refformat = reftable, preexisting = 100000, new = 10000, revision = HEAD) ran
        1.25 ± 0.05 times faster than update-ref: create many refs (refformat = reftable, preexisting = 100000, new = 10000, revision = HEAD~)

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
2.48.1.666.gff9fcf71b7.dirty

