Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128E72FB0A0
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 15:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759938655; cv=none; b=c44NXdVrWndOTV7paO/K2dNcc5iHKlNxcBCycxYHMpCG8fhjV7+RJnH7yKrVKACZLfAPwWYldOdWVZL4TxzHjwZaTEjBvPBmiwMyhpIGZRpTnzm9vWi1cFtUiuLvrgwg1RlHP0iN/WRNtfzEGLYyPEVTY6EQRLwGHZ2JsLQC8sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759938655; c=relaxed/simple;
	bh=V6r0Z8uo5GN+JRewB7hWSUAPfb1ip13qZs6iqBS4iuk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MRCutBYIM2os3IKBaQtRogROkfBLMOl1bAQk4hTlkjc9qJ4MTjBMBAicJyflY205HUW7PTycYX4RB994mF+7gTxCSe2Ty9dCZZHy+uMjMGd2YNQy4INrMdsHQn/oUKRnl/ruL2LY8fpHnMffqfus/jdPRAu93kIm+mWAHXkiQ1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iHUFtMKG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fgn68P8W; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iHUFtMKG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fgn68P8W"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 176407A05B5;
	Wed,  8 Oct 2025 11:50:53 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 08 Oct 2025 11:50:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759938652;
	 x=1760025052; bh=5sgi0Ajcg2vLc097y8mu9mbtmiNJBaYcyZ3j1h6yhMU=; b=
	iHUFtMKGq0IGou2CvBHkKZu26bT83pZndW51wuXD33KIHw+h2tvBSs38gikTQrce
	STtjeOyBAPoCUyxCcPUGwwNEbHQP0qDGLpnU2MrSdaiSTSl12ohf7XyGjs35eHcE
	ZhCLU15BWgVoGY6c6vHZVKzsWmlHE9BhghPjQ6v8AdNGHqUCmhD8cuXj3cNFdzzG
	qzHYCEy9rZ0YNnkS3sTRktci9SYe+65hh4H3xRMLJ3bzwyLDzvyJyg9yCxHR9nIo
	h+4XBf40zl8YYO/vJ6TAMhQA9Tg9DYAapZ+TmFk43RUov1x1yYHTFTgqdpl/Mtp0
	NWSojVfr91kfzLDHxmxAJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759938652; x=
	1760025052; bh=5sgi0Ajcg2vLc097y8mu9mbtmiNJBaYcyZ3j1h6yhMU=; b=f
	gn68P8WdKd8O6MNzsWDFkCCHOFOYc+p0wC9JmR0PAlVTC2ie1+bpCW3J+W8Almpw
	s0OBnLwXRqhky9st3mKhm3kj1PS99IxbEdcVz5Zr/hhkEXwENjqTiHLej38lu3mc
	/UiQBuEoaZzv3tlf6HArAoD6sXw0+y5WyqujmC2hWVlJ7MSRLkop8RiyWI4eqwRA
	xccMO5MKiLKlcICVo1kRrTHxnX2EPuw5v6lY7lTTzM7f+Ym3WnEASiLwfxjiHm4u
	yO9zNoNPKpD94bGGmlLWW8ZWW84vASS4sWJT5zjbZP7wsKu78Z3DlpwDB+tlR3vF
	RLv5SbGTkJNKPQsTLi/MA==
X-ME-Sender: <xms:XIjmaMU162K1I3m9lkQcAIaMenPQrBqnYusYGc6CDY7hCQFrIcDM2Q>
    <xme:XIjmaEQkgs_Ezbic53nUNKk_gLY8UpXzZIhq9667j_Nz7bv9XusOihUoocLaldeZR
    LozWQ_gyGRpTs2FU2M01_wU-sROl9uu5W_Uxf7jai2wPQ37H0vsDBc>
X-ME-Received: <xmr:XIjmaKPjcfbWq_U0kLL76sw4OEUKj2Q-TQa0kosZCl5eF3luZmOBywmi8gSERXhyq-cy_YcPzyyRnZLrwOF_LeJtT0SSLvrJkopaJc6k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdefjedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepjhhlthhosghlvg
    hrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepkh
    grrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehkrhhishhtohhf
    fhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:XIjmaCTOM1lRNydFH05zLQUrn_5VqnLoqEuPS_TSeGeOPVxMfnsZGQ>
    <xmx:XIjmaIjs6C28wShHmz98Fjli56J0IGsjoIefdSSopI2VSKFw6noZpg>
    <xmx:XIjmaL8EP11sSrOCmqig8J9GuYVeUh51sCnPxrpk-L_eCCrBAsE2Sw>
    <xmx:XIjmaPEVNWK07ELe9GOXzrRAgaLr1GGrQjoyURas5otZSn_0Nn2wXw>
    <xmx:XIjmaKSsoFCZYJPDEn55iYcN4C1VRdoZjT1E6ZoN-oQpbsl4olwKE-jK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Oct 2025 11:50:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c0f7a8de (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 8 Oct 2025 15:50:51 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 08 Oct 2025 17:50:24 +0200
Subject: [PATCH v2 09/14] refs: drop `current_ref_iter` hack
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-b4-pks-ref-filter-skip-parsing-objects-v2-9-76e30d5c9542@pks.im>
References: <20251008-b4-pks-ref-filter-skip-parsing-objects-v2-0-76e30d5c9542@pks.im>
In-Reply-To: <20251008-b4-pks-ref-filter-skip-parsing-objects-v2-0-76e30d5c9542@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Karthik Nayak <karthik.188@gmail.com>, Taylor Blau <me@ttaylorr.com>, 
 Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.3

In preceding commits we have refactored all callers of
`peel_iterated_oid()` to instead use `reference_get_peeled_oid()`. This
allows us to thus get rid of the former function.

Getting rid of that function is nice, but even nicer is that this also
allows us to get rid of the `current_ref_iter` hack. This global
variable tracked the currently-active ref iterator so that we can use it
to peel an object ID. Now that the peeled object ID is propagated via
`struct reference` though we don't have to depend on this hack anymore,
which makes for a more robust and easier-to-understand infrastructure.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c               | 10 ----------
 refs/iterator.c      |  5 -----
 refs/refs-internal.h | 13 -------------
 3 files changed, 28 deletions(-)

diff --git a/refs.c b/refs.c
index 5002e56435..b0ceba8bc3 100644
--- a/refs.c
+++ b/refs.c
@@ -2323,16 +2323,6 @@ int refs_optimize(struct ref_store *refs, struct pack_refs_opts *opts)
 	return refs->be->optimize(refs, opts);
 }
 
-int peel_iterated_oid(struct repository *r, const struct object_id *base, struct object_id *peeled)
-{
-	if (current_ref_iter &&
-	    (current_ref_iter->ref.oid == base ||
-	     oideq(current_ref_iter->ref.oid, base)))
-		return ref_iterator_peel(current_ref_iter, peeled);
-
-	return peel_object(r, base, peeled) ? -1 : 0;
-}
-
 int reference_get_peeled_oid(struct repository *repo,
 			     const struct reference *ref,
 			     struct object_id *peeled_oid)
diff --git a/refs/iterator.c b/refs/iterator.c
index fe5980e1b6..072c6aacdb 100644
--- a/refs/iterator.c
+++ b/refs/iterator.c
@@ -458,15 +458,11 @@ struct ref_iterator *prefix_ref_iterator_begin(struct ref_iterator *iter0,
 	return ref_iterator;
 }
 
-struct ref_iterator *current_ref_iter = NULL;
-
 int do_for_each_ref_iterator(struct ref_iterator *iter,
 			     each_ref_fn fn, void *cb_data)
 {
 	int retval = 0, ok;
-	struct ref_iterator *old_ref_iter = current_ref_iter;
 
-	current_ref_iter = iter;
 	while ((ok = ref_iterator_advance(iter)) == ITER_OK) {
 		retval = fn(&iter->ref, cb_data);
 		if (retval)
@@ -474,7 +470,6 @@ int do_for_each_ref_iterator(struct ref_iterator *iter,
 	}
 
 out:
-	current_ref_iter = old_ref_iter;
 	if (ok == ITER_ERROR)
 		retval = -1;
 	ref_iterator_free(iter);
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index ed749d1657..f4f845bbea 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -376,19 +376,6 @@ struct ref_iterator_vtable {
 	ref_iterator_release_fn *release;
 };
 
-/*
- * current_ref_iter is a performance hack: when iterating over
- * references using the for_each_ref*() functions, current_ref_iter is
- * set to the reference iterator before calling the callback function.
- * If the callback function calls peel_ref(), then peel_ref() first
- * checks whether the reference to be peeled is the one referred to by
- * the iterator (it usually is) and if so, asks the iterator for the
- * peeled version of the reference if it is available. This avoids a
- * refname lookup in a common case. current_ref_iter is set to NULL
- * when the iteration is over.
- */
-extern struct ref_iterator *current_ref_iter;
-
 struct ref_store;
 
 /* refs backends */

-- 
2.51.0.764.g787ff6f08a.dirty

