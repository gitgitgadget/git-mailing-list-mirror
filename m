Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84DC7604F
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 06:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727159585; cv=none; b=rgwHFksDJnmP+U3vty5z5XZQ5eMhwgyPPXjkvt3PqqZKc5Y+HLuu62nv5gEFWq+INOviVSwnACnFSHNuUJ6L9eQ2U5SEeOSXXpabxSmSy562xH4Yc9zRGVc5hUZF2utnz884uEwZh6+cxiqFlS/ArOoTFuJ0jylRRdMrHg+kZBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727159585; c=relaxed/simple;
	bh=iiei/XYewOEuB6UqcZJPhGhEil7VsuSUTckifB/BgrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t8BGBWlI5DNpE6kAFLfN756NL2p3CuSBtnqcY9fFWOjAmmKxyrVJGxOal6hbdw1sIXFtjZqMvkHxdvMgWD5Phc8IAULv2mtFTg+2xvXNcKUgVgVjm9ASPvX38NNEUuYTNM+BQkYF1i5u87Z1TWQubjcLkqh3XP5F1ZaziUTVAhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=E1VswPZC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QuW5sB0F; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="E1VswPZC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QuW5sB0F"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 10C041140317;
	Tue, 24 Sep 2024 02:33:03 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 24 Sep 2024 02:33:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727159583; x=1727245983; bh=6QGbLLApFc
	3EWXwVj6NlyTxyhsPEYyPuZ3jUs2aFrmA=; b=E1VswPZCT60Oz7ZInHGqY0II8J
	lLZC6WDSsvQg3+RpQIzf9Q02/GitERTJIH0jvIQbvyUFH4CuxqDOLEexoASMCke0
	a7GXCtdWWPU7pXzZNxmvBVNRcQDJ4hO96XU01+sZhSAiAFWwRsjkYH1xX1d+iwDA
	zHLn25hlUJPirQ5ZEnjjcVeLBBNZHC3Jf3JAvVFjU46iTEJOSnUhhp+TJZy2BgXZ
	e/OUnbr6IlMvkCBqiCbhxSN+iaP4WJ2M2SWViRM2FlWx+1U9klm+RSel/q+VzK8g
	Mg6H+CFqBlG44Q7BlI+YFsDIniHMhG3NHoxsLkRGQdwg7XbCFkuDjkj4qe7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727159583; x=1727245983; bh=6QGbLLApFc3EWXwVj6NlyTxyhsPE
	YyPuZ3jUs2aFrmA=; b=QuW5sB0FAVrMITBJBRWnFu1cFX9/52iB6yUg1TLfRLFC
	tQCZyUNBB+0jGS1l+hpF8B4wR5qdYi4+Z5hnhNOw+6jsWP+ePor7i4ddCVrJDRbQ
	VqLdyzRgeoQT/GiGJXgEI3b+A5LfRUGnB5NWYzDhYQ/rlKItQbG4rxemQASGrNBj
	lNYpldB0CezFaCt0LLIfWfGXrq4XQE1G26R5u1J53LnBzTA/s3RfoCcsm0sZ2B/U
	G+pcbc7qeYBUK/CnrVphbfQN1/QvEAs86EmsWrZBPG2k0NBgkSBblUefL6V7e4YN
	GkTwDY7P1WK7mA/Y/z4E9V96zeNIzfcJ3UlipQyRig==
X-ME-Sender: <xms:Hl3yZpupHLIF-VDZ5tV-8C9EvKhUU9ZA4G6kW7oQKaIWQy4t6FYj1A>
    <xme:Hl3yZieVb6NuFNGZl97Ef2fAqBOzQBpcrkUyZ2IgkV_lh57ywV3FQCWKR1RsHJUdE
    fVhscfg01LCOpXggA>
X-ME-Received: <xmr:Hl3yZszj1x9UoF0pJ14JiD8SunuZgYx6zmY57vv_Xi43FX-8B4y-r7EKfc56YuJPfgxHqu3SdPnp89eBOnvxGelOG_W1uCdTDBNwFEva6VJAmw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtuddgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvghthhho
    mhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhm
X-ME-Proxy: <xmx:Hl3yZgOyiLLXrjPDaTh5XM9Pm4cKyzVStjDR9TN5t8cdg-pdlpnpuw>
    <xmx:Hl3yZp9BKsW0x2Sxos1F0RFEJ4UBDsvJsosVcIcKY4Cyi4FwQG2oaw>
    <xmx:Hl3yZgVnbcv-DO8DAm1VQ2zPgMifGjbrX8m1n9Ca3KzfwzkTcIrVtw>
    <xmx:Hl3yZqfsXKmbrH0RE8807dCFyq2sTsna4YvTFAE9oOaQfBIvBCoU0g>
    <xmx:H13yZkbIdxBaAbl5qrjwI4sOIpPtbx40xxYs9SCcHOufmDzNU2V9Galt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Sep 2024 02:33:01 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 08ecb1f1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Sep 2024 06:32:29 +0000 (UTC)
Date: Tue, 24 Sep 2024 08:32:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 20/22] reftable/pq: handle allocation failures when adding
 entries
Message-ID: <445daf9464dbc6c7d6c4de31944c6a6b733a1a8b.1727158127.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
 <cover.1727158127.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727158127.git.ps@pks.im>

Handle allocation failures when adding entries to the pqueue. Adapt its
only caller accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/merged.c | 5 ++++-
 reftable/pq.c     | 7 ++++++-
 reftable/pq.h     | 2 +-
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/reftable/merged.c b/reftable/merged.c
index 741f62ea638..2c20845d624 100644
--- a/reftable/merged.c
+++ b/reftable/merged.c
@@ -54,7 +54,10 @@ static int merged_iter_advance_subiter(struct merged_iter *mi, size_t idx)
 	if (err)
 		return err;
 
-	merged_iter_pqueue_add(&mi->pq, &e);
+	err = merged_iter_pqueue_add(&mi->pq, &e);
+	if (err)
+		return err;
+
 	return 0;
 }
 
diff --git a/reftable/pq.c b/reftable/pq.c
index 2b5b7d1c0e2..03b99122829 100644
--- a/reftable/pq.c
+++ b/reftable/pq.c
@@ -8,6 +8,7 @@ license that can be found in the LICENSE file or at
 
 #include "pq.h"
 
+#include "reftable-error.h"
 #include "reftable-record.h"
 #include "system.h"
 #include "basics.h"
@@ -44,11 +45,13 @@ struct pq_entry merged_iter_pqueue_remove(struct merged_iter_pqueue *pq)
 	return e;
 }
 
-void merged_iter_pqueue_add(struct merged_iter_pqueue *pq, const struct pq_entry *e)
+int merged_iter_pqueue_add(struct merged_iter_pqueue *pq, const struct pq_entry *e)
 {
 	size_t i = 0;
 
 	REFTABLE_ALLOC_GROW(pq->heap, pq->len + 1, pq->cap);
+	if (!pq->heap)
+		return REFTABLE_OUT_OF_MEMORY_ERROR;
 	pq->heap[pq->len++] = *e;
 
 	i = pq->len - 1;
@@ -59,6 +62,8 @@ void merged_iter_pqueue_add(struct merged_iter_pqueue *pq, const struct pq_entry
 		SWAP(pq->heap[j], pq->heap[i]);
 		i = j;
 	}
+
+	return 0;
 }
 
 void merged_iter_pqueue_release(struct merged_iter_pqueue *pq)
diff --git a/reftable/pq.h b/reftable/pq.h
index 707bd26767b..83c062eecac 100644
--- a/reftable/pq.h
+++ b/reftable/pq.h
@@ -23,7 +23,7 @@ struct merged_iter_pqueue {
 };
 
 struct pq_entry merged_iter_pqueue_remove(struct merged_iter_pqueue *pq);
-void merged_iter_pqueue_add(struct merged_iter_pqueue *pq, const struct pq_entry *e);
+int merged_iter_pqueue_add(struct merged_iter_pqueue *pq, const struct pq_entry *e);
 void merged_iter_pqueue_release(struct merged_iter_pqueue *pq);
 int pq_less(struct pq_entry *a, struct pq_entry *b);
 
-- 
2.46.0.551.gc5ee8f2d1c.dirty

