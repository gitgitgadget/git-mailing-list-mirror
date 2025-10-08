Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088542BD029
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 15:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759938638; cv=none; b=CsT/XArcMCCrIKjLUJIppdkP3JihGDudA8FymwzxzacmS3KX65OtDz/tENV6/JEjQIoXsaenwAVjDEmcBAVAFFnf0dHl/B0nDpTD5eYaGXgF1txyYJDbMLsCC8iQJUnsTcWebG6iovv7bnECnWxWvPyzUQOSCim7VyK7IR8nzz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759938638; c=relaxed/simple;
	bh=66FCJEvYqc6Jn17TTlu0WcYnmulP/uN54b11hrH+ORk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AR8ZE7slsk8VkJi0TMOKOx3YlBCv64gW+2E3OoXK9HaZuRylzEJsWQh+x6migpFs0c6mb5RUXxRgYTI2/z4jaY7wVVFkz8xXEr032vLK/k5JkCrO85PiHzKmy59yq5OH9exH0qTYMhI8TAO8Atb6tqR64A37kQJdxQ29o4HolrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YNcwgIt+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RVcYwC/Z; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YNcwgIt+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RVcYwC/Z"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 1ED1F1D00556;
	Wed,  8 Oct 2025 11:50:36 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 08 Oct 2025 11:50:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759938635;
	 x=1760025035; bh=fWG/JdWKg4Nite0P8m0/V3mzl5YOoj6GprAWsLKZiKU=; b=
	YNcwgIt+37+0rVPxsXjFfAmab+9KmcLa2Z0R5vLhqDwZPM4Onnmy5G+O0g3cNJkG
	8WFKv02eBxpEj3gimqCtbtploz8NUB2MTtHHN40LAfCOap0BOaa3JBvPVu2+RxM9
	yZfINOuCc5zSYSG2OYVhfWFq59gEmxI/NOjmBYNLPqs/jrwl6B1x33bc9vIKJJYt
	CQ5TkVUKSODLOeFqsyX5CzYlGWQPS+t8Ond7jEFRcbAUd5Nmijzyowaw2N7IDe+3
	J260m2edoh5bBZN+9FB46EHoREj+2/IHfAZgQkqg5K3z+yBPnC1OLoXALpMClfb4
	NCfkb03p97UnbWcpPVwF0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759938635; x=
	1760025035; bh=fWG/JdWKg4Nite0P8m0/V3mzl5YOoj6GprAWsLKZiKU=; b=R
	VcYwC/Zew+ayorgg8qfjozwIzxdlku7WbB8KQZqqykrzFaSKRz5m0C7LzPLDmjfH
	62ZaKId49mVJtsYBVdha6nJUoGXigMmMPpcW5coMpYXzvqob6+Sbm6B5bmoFBsIw
	MYSoO/RU8f0PRrgdEfujLwOLXYR+1o0Y1BjoDGOau9bNO7O0kMf2pSPXgFLPHJ1l
	Nyp8/Dv0wpM0yFEoBPooR8850PEWh+B5D3Bl9PU9M65gAPFT1jLswAWdsMZrV4oS
	Txb478yLDhAL+9uHx1OeLEnClfImNsUU7vAel/K1aXhywk0r1YsZ86SostEqtSQq
	Mfz4YAvnjzy0V5NJBjfrg==
X-ME-Sender: <xms:S4jmaOPWYLp1_8Gq1c45mKqaeT8ATQQKvJji_Nvrg61VPOKHpZo_Zw>
    <xme:S4jmaAqyAEcXpYE-TPt1QvnlvQ2CVjQShXTDs2am73v2l_7yrZ0YXIzNKlNsXTUUl
    JZamcKb2w-bDb25Cl1R7InTRLbcvRMl3Cjr4Yx0u99rsH9hg2fz8Q>
X-ME-Received: <xmr:S4jmaPEkPPHkZJf46lz0tG7LkIapsOypcOsS21_uJlG8HAafuuib4OKib61YvvzGOprc2w4DGcdjv7cN-4hMs5QRKJ6I0669FqcE2BIP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdefjedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpefgueduueefheehhfdtvedtudffuddttdetgeevffevieejvdfgfedugefgleeuffen
    ucffohhmrghinheprhgvfhdrnhgrmhgvpdhrvghfrdhtrghrghgvthenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhn
    sggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmvgesth
    htrgihlhhorhhrrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghi
    lhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrg
    hsthhmrghilhdrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:S4jmaFqw5a_Afu5dciddUGqkNAcJeAFvLbWWBuow48i2AaLAfVgGWA>
    <xmx:S4jmaIbBqkbgI5T-Xnue6Et8ma2YlEULk5XnuPPqRpEnOJcscWmqTQ>
    <xmx:S4jmaOXoSquv68Unwj3T5-g0oXy2eCOzBhjyMIApEz1tBc690It0Rg>
    <xmx:S4jmaB9eR5MYfrLps6-0Mif8fMN6KyVnR0gv44V6DfQAsZRjlImeMw>
    <xmx:S4jmaPNYv8niDrtv7FVCWqN0L-df07QFv53sQMYF8dSXlovsylZ2GaD0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Oct 2025 11:50:34 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0d1b140c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 8 Oct 2025 15:50:33 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 08 Oct 2025 17:50:18 +0200
Subject: [PATCH v2 03/14] refs: fully reset `struct ref_iterator::ref` on
 iteration
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-b4-pks-ref-filter-skip-parsing-objects-v2-3-76e30d5c9542@pks.im>
References: <20251008-b4-pks-ref-filter-skip-parsing-objects-v2-0-76e30d5c9542@pks.im>
In-Reply-To: <20251008-b4-pks-ref-filter-skip-parsing-objects-v2-0-76e30d5c9542@pks.im>
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
index 7987acdc96..711e07f832 100644
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
index 97555fa118..4726de430d 100644
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
index 7fbc77492e..1e047fddae 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -703,6 +703,7 @@ static int reftable_ref_iterator_advance(struct ref_iterator *ref_iterator)
 					    &iter->oid, flags))
 				continue;
 
+		memset(&iter->base.ref, 0, sizeof(iter->base.ref));
 		iter->base.ref.name = iter->ref.refname;
 		iter->base.ref.target = referent;
 		iter->base.ref.oid = &iter->oid;

-- 
2.51.0.764.g787ff6f08a.dirty

