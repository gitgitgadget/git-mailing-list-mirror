Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C8F2EFD8A
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 06:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761115280; cv=none; b=WaXB7YsJywDXQllY5iUjjKCNZzoZaPoUim6egkqRg+l5q0Bv/SV1/85BZ1a6FQykTZwyDUU5Hca25pBYDWnM36prWTixlI35faAIu8EhqaA52NeW2eMMzOP/3DzRXu7CEaYO/b/ujRVCb7ONg8YL8oxmkt/X6xB7l+tvEilN39s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761115280; c=relaxed/simple;
	bh=h46sg99PPwFr6WAPEtGoT1S32QaV9IsAsj8SSXSbIYs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gKRXnog5mdYs8Iiu8yBzfHgTpBqoDviJivOD+uyNRq1KuXTtqOHfuhbyPWQ2V+SJa2IqSdP1soYVLukpbuGyiMEtb5g9PUiU+VC+75R9xIwrm1DKlbfdVRElYhARzgfCLaTZO1vPC//dMpItOzAZnHzkK2heF4O/62oPZ/6Ib7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Svm0oJzc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gz5mokVD; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Svm0oJzc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gz5mokVD"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 34D787A0073;
	Wed, 22 Oct 2025 02:41:17 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 22 Oct 2025 02:41:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761115277;
	 x=1761201677; bh=n7gqqoioGIPMUnthmuhEMhppMSs2cMIFGskHxIu+b4o=; b=
	Svm0oJzcvuRCU33Ev2nJErE2kutEGJC8F6b3viMOjbW6eHVU7jLjK7C4gtp7PY2n
	wzDSm0c8DczVTCKd/esm1voJY6Z/KCp3ot0d2qXHVjix9UXsEG02kKYSGOdmoY5d
	98OOhUt7iUI9/fmdzclT36KLBrKSX5I9Tp+fSe3vrInPm7lsTv9sJxheug1W1elP
	M3WDGUUJFIsi8AoTElVmlHVOrkNYD1v53Kcoa37fbMENAKiZMCZKWxo9kWVLUrga
	qQ50ZWZZifQo1iUhha6+gWQzHcYFS6T+AUemCMJOn2zDZSp+mI64A84VG+VnlYpw
	WzTbLKrMrcEOxJNnwJd7eQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761115277; x=
	1761201677; bh=n7gqqoioGIPMUnthmuhEMhppMSs2cMIFGskHxIu+b4o=; b=g
	z5mokVDFqjpDrYDYE1q3pelPpUg4/wbTbpON89NfD/3fOc9ljBHJhK6jc1dCFBTx
	t/U5Cn31gCCSWf2zeTcSLIYnt8Giek4m/oMSwxxuouJWFo28uJDBaTgKEiBXgj2Z
	cxidnuq6HADgs63liNJ/az1UQLQFUH8w+p7I/pWgXLM2PtnPEtNfa6QTofBlaJxw
	QeGUqnDZ52wAJBWcrMuhh2SJOwI608ioFrj1ScdRbO/vFTanwl5nm0BRoE3k6eTl
	NrYCKsTN9DIXy12kTZvsgoPpoIc8HOoBToB8wwkenjuFXlidr/dwhwLjFnPeczgC
	quDu61Y4r22QgN/woqvww==
X-ME-Sender: <xms:jHz4aDqZ01YsXhFkYYj8mx3PZutoKPLKIeCRCUTuRQ4-zbsFHxdUQw>
    <xme:jHz4aBWbq5h0SCp0CIYLKVajxV6W79iykUg6PGShZDW7wbBWSqvoCC-y3GFelsOyY
    x5opt-hc87snVeHryM3_zPq5oErMd-SU2Yse_eD53X73H-mNYN3Ng>
X-ME-Received: <xmr:jHz4aKBAhaRI-yjWqR31EFY-pOjHzZoaxA4ToaVjxn1ShsJcrDFOU62ySNAv8xtQtkDR4QjMl0B3sWhRzUD2TeBUuf14ZTjqXXPikLPHY8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedvkeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpefgueduueefheehhfdtvedtudffuddttdetgeevffevieejvdfgfedugefgleeuffen
    ucffohhmrghinheprhgvfhdrnhgrmhgvpdhrvghfrdhtrghrghgvthenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhn
    sggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthho
    pehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhlthhosg
    hlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:jHz4aN2zOfzJ2rE0zj0W-Mn1Wxf7t29hLkEo8CfbGm3EsusaEpezRw>
    <xmx:jHz4aE3yWxhNTbr8nr6ehcZNg0-GrP2lO52o4tPpP44rXpsUnV8BzQ>
    <xmx:jHz4aKB3A68cdysitco1CcU405p2XawHw7m4Zpm0t1IvE96tVB7n-g>
    <xmx:jHz4aL4lfLcyXr0MoQ8q0GDsrYpmu83yOTSmtAoU6dfqGN2gIfwihg>
    <xmx:jXz4aMlMjEr4HB9Ekw03liz6LydYLRpG2NbdzBbbeimO7F9keQDNrE0s>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Oct 2025 02:41:15 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 133a2f90 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 22 Oct 2025 06:41:15 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 22 Oct 2025 08:41:03 +0200
Subject: [PATCH v3 03/14] refs: fully reset `struct ref_iterator::ref` on
 iteration
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-b4-pks-ref-filter-skip-parsing-objects-v3-3-eb9f71985ef0@pks.im>
References: <20251022-b4-pks-ref-filter-skip-parsing-objects-v3-0-eb9f71985ef0@pks.im>
In-Reply-To: <20251022-b4-pks-ref-filter-skip-parsing-objects-v3-0-eb9f71985ef0@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Karthik Nayak <karthik.188@gmail.com>, Taylor Blau <me@ttaylorr.com>, 
 Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.3

With the introduction of the `struct ref_iterator::ref` field it now is
a whole lot easier to introduce new fields that become accessible to the
caller without having to adapt every single callsite. But there's a
downside: when a new field is introduced we always have to adapt all
backends to set that field.

This isn't something we can avoid in the general case: when the new
field is expected to be populated by all backends we of course cannot
avoid doing so. But new fields may be entirely optional, in which case
we'd still have such churn. And furthermore, it is very easy right now
to leak state from a previous iteration into the next iteration.

Address this issue by ensuring that the reference backends all fully
reset the field on every single iteration. This ensures that no state
from previous iterations can leak into the next one. And it ensures that
any newly introduced fields will be zeroed out by default.

Note that we don't have to explicitly adapt the "files" backend, as it
uses the `cache_ref_iterator` internally. Furthermore, other "wrapping"
iterators like for example the `prefix_ref_iterator` copy around the
whole reference, so these don't need to be adapted either.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/packed-backend.c   | 3 ++-
 refs/ref-cache.c        | 1 +
 refs/reftable-backend.c | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 7987acdc96a..711e07f8326 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -882,6 +882,7 @@ static int next_record(struct packed_ref_iterator *iter)
 {
 	const char *p, *eol;
 
+	memset(&iter->base.ref, 0, sizeof(iter->base.ref));
 	strbuf_reset(&iter->refname_buf);
 
 	/*
@@ -916,6 +917,7 @@ static int next_record(struct packed_ref_iterator *iter)
 	    !isspace(*p++))
 		die_invalid_line(iter->snapshot->refs->path,
 				 iter->pos, iter->eof - iter->pos);
+	iter->base.ref.oid = &iter->oid;
 
 	eol = memchr(p, '\n', iter->eof - p);
 	if (!eol)
@@ -1194,7 +1196,6 @@ static struct ref_iterator *packed_ref_iterator_begin(
 	iter->snapshot = snapshot;
 	acquire_snapshot(snapshot);
 	strbuf_init(&iter->refname_buf, 0);
-	iter->base.ref.oid = &iter->oid;
 	iter->repo = ref_store->repo;
 	iter->flags = flags;
 
diff --git a/refs/ref-cache.c b/refs/ref-cache.c
index f1abc396241..e427848879d 100644
--- a/refs/ref-cache.c
+++ b/refs/ref-cache.c
@@ -425,6 +425,7 @@ static int cache_ref_iterator_advance(struct ref_iterator *ref_iterator)
 			level->prefix_state = entry_prefix_state;
 			level->index = -1;
 		} else {
+			memset(&iter->base.ref, 0, sizeof(iter->base.ref));
 			iter->base.ref.name = entry->name;
 			iter->base.ref.target = entry->u.value.referent;
 			iter->base.ref.oid = &entry->u.value.oid;
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 0e47986cb5b..728886eafd3 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -704,6 +704,7 @@ static int reftable_ref_iterator_advance(struct ref_iterator *ref_iterator)
 					    &iter->oid, flags))
 				continue;
 
+		memset(&iter->base.ref, 0, sizeof(iter->base.ref));
 		iter->base.ref.name = iter->ref.refname;
 		iter->base.ref.target = referent;
 		iter->base.ref.oid = &iter->oid;

-- 
2.51.1.851.g4ebd6896fd.dirty

