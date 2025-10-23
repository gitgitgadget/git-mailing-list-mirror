Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94702D2398
	for <git@vger.kernel.org>; Thu, 23 Oct 2025 07:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761203788; cv=none; b=kl6dPrUQgE7IDioQdsoJ+yyhO3WJVQXi2+wNRR12z3U5I6UdPltmetF/7RJJy8gNDFF66mLQoGOTE85MLyvZA9NiL/OCvvQzmhsRKTtBlkBHQevE7BfMWsOuwG/eXH/FYcGU891OiTeLzBF+8+ytyYGtMeZC4rEuzW4x00E4KEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761203788; c=relaxed/simple;
	bh=NoJ+9qqJ6feCaBfPTrQuiVQJilouflHdnsTFuzWUQD8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t/RsIPQKpLHcokXUb9rOkWLFXpZxQSdkm0jJOtfglanigwPknjSxnP/RxWJjLSUqU2+HfW3um5rJdxj2gWHQzTnfYXNWXJXwux2+AE14Q8B8/QEE1Yl1rx8nvX0wv/JfKdPLR45uI3rMXxh3vxtW/6UJSCi+DGTH3HJHQo2utf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KnR6V1uX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HiN0yZA2; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KnR6V1uX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HiN0yZA2"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id D3C9FEC01FA;
	Thu, 23 Oct 2025 03:16:25 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 23 Oct 2025 03:16:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761203785;
	 x=1761290185; bh=2kqtsSl7RtDVVq+sc2LwVzVv7rs+mD361suwS5G0R3I=; b=
	KnR6V1uXQ/Uqr/pMZB2aDt9jzLbCYnvw3tGj5Y/M+uqInXKZ5vrC/Oy7EWctBrNJ
	xmemuwX4AuB+M4uT4V4QnKlJYt3a0dV8mFfhI6xpj/GU/LPMsSBov4mhu3BKjEDB
	BhMQN0P0vuRIctlwXzHIrboRWeZr33+zDZctlrGGq1cqMfxNjbc3lGqLht+j6oaV
	lJo+netr4dmxPijFTAIjfznAfhaovY94klMpK6mlHLN6f4FlELv81WBnJUug3qEY
	z/AKvuGaRTnptd2Y0swO340pjh1EoWtO5MjYty/U7yWaph1MeuelAQPv77gGrmMC
	YfQXXv5h6ANALR8LvM21eQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761203785; x=
	1761290185; bh=2kqtsSl7RtDVVq+sc2LwVzVv7rs+mD361suwS5G0R3I=; b=H
	iN0yZA2qviv5d6HnpcoNE2+xtmJzI/R5fOwrXrdMjJz8W+hp6DGI18IPtbBZ3f+7
	g4vAkad95dVe/0m8ikyRCFrDOHnmB59xyPD8i1nb2LcqHHk3GlzojJ7fpot2fmPP
	VvgBHEZsm1ZSzLyfTdNkda55HEP/jZfRm7bpfRE95Y3zy86u6vRxBftkajfmy+Zh
	6yh3FBhDBT7siFTQbVt0uqUVv5vAH+R/lqIF3o9HM8ec5w5hzd47EOl3lHaAgePr
	J8u+GAF+sAgjWMb84uIHR1qFS5gH9ysj0/3aRZ4DFa8p/CSO0fpHD2ZHHxsA+aPx
	od1dolUDkTBt/hL7Lb+gA==
X-ME-Sender: <xms:Sdb5aLECeyTzjrHv7dCmy2EwSiHDEH6Rng-0Bij1EKi306mU0gJciw>
    <xme:Sdb5aMBsaP3At3yETCZ7UVx8KaSh4EPNO3D6mkzHTUhOjENbSgsRM8xOGt7lc6Out
    _EvkpLZ2Wxf8YUfsH5Ocap0rLt_xvXHeyzdaKmeK0xs62ioE_yxpA>
X-ME-Received: <xmr:Sdb5aG8o7sCi-kXBlxtF-b4vG3b4lNcOfMSbAzale8J6MxD7Wr6PjkkJUhMpVgkouR464OwYXRIvnNkZmh5IpGbKxUDkoFsA7imF4r_mfRuLeQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeehkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpefgueduueefheehhfdtvedtudffuddttdetgeevffevieejvdfgfedugefgleeuffen
    ucffohhmrghinheprhgvfhdrnhgrmhgvpdhrvghfrdhtrghrghgvthenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhn
    sggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhr
    tghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrh
    hthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:Sdb5aABh_InRr0NmrqJc9-ZBeoPjb-u0Nxgee1IurOCgP8YM3Cye0A>
    <xmx:Sdb5aDQcEVIwg-WJ5vFicouvYzVBFgi7G-bAril9dwooLivumq_1Ag>
    <xmx:Sdb5aPvYv_dkEx41u_i4W4mfgQ_rPM1VQpFdH4w75uv4tVn37yNuSQ>
    <xmx:Sdb5aH1bDZml2RG41hGFWmYEc3vAIbZ4K3cKhbMDyU15zDryfEXHcw>
    <xmx:Sdb5aNDakKzJIiXGj6LPi_lHbsqI-RhkEOcoL92QbB4n-LMbXAjzQij5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Oct 2025 03:16:24 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3aa3dc62 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 23 Oct 2025 07:16:24 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 23 Oct 2025 09:16:12 +0200
Subject: [PATCH v4 03/14] refs: fully reset `struct ref_iterator::ref` on
 iteration
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-b4-pks-ref-filter-skip-parsing-objects-v4-3-2be68ce82c9a@pks.im>
References: <20251023-b4-pks-ref-filter-skip-parsing-objects-v4-0-2be68ce82c9a@pks.im>
In-Reply-To: <20251023-b4-pks-ref-filter-skip-parsing-objects-v4-0-2be68ce82c9a@pks.im>
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
2.51.1.930.gacf6e81ea2.dirty

