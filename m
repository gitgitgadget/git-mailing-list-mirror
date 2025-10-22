Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43902F1FFC
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 06:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761115296; cv=none; b=NexWRKbylfe4aH4/sBeUNiaST3zS6fGBwvG2nh79dUSsGLnX7gAHQcBVF1R5G4Mh/bxMPEvVOmOWsbUGUAVgqTnmKpqAJv9Mkcaqo9Hd60uUZj2mSnQITU36QO1/gZDnqZUleXBsX12MPnogSVijts8Gxi5lwMYEBPAE2aYQSIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761115296; c=relaxed/simple;
	bh=jbj7jpsxxyI3ZJVJ7Rz+22FnYranHB17aocrQQmpfBI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZCqw7KTsqSvGq7tfFESl8RqTrWOXM7lhdFzpq+XDX0UGwDkjcTiY5gSa25o6OXauJTB6/c/A1Ya7h9gZTJ7ztO7wEg1o3RUyxxtbKYuZzvUfa7j6BxAw+SJE7l9vLyrgxyH5gCHNnzmSGuHpJER6Nd90mnX2xXaISDEGKNRnfas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qJRHGSZB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nlYPJU93; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qJRHGSZB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nlYPJU93"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C61967A0096;
	Wed, 22 Oct 2025 02:41:33 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 22 Oct 2025 02:41:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761115293;
	 x=1761201693; bh=13xq5buPbG9VcuxLkgEsovGjlnCUBsbrY4W34vFbxZU=; b=
	qJRHGSZBPT+gLfg+dBWyxbHqHw69Gz65kd9Iq3Z26HY/3LdhgFLPwm2iyap9viLh
	lGrqGXMrQUypf9IALuvFksQsjwGzl9aaIZ+28Vw/Vd5tNeC4PWR4QIFLLduoJIJl
	cSkFx6XQRnAU+lKSPJFIKOiTw8FaJz84CseymcRRPpdlX92L8ep/b0Gcv5KKAGPN
	cXB/YyuNFOInXhIAb1Glctq07g071mL0LSS6f9urGSvbpKjUxghno4ig9ai14gWM
	UdZkGX0HlKWV1LEajd2SA6Y/Yog26YQlG0cwRfkDF0icf3xgj8sIsGgMUv2pE8J4
	wIAIzbLxVu6cfWPb5ikZow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761115293; x=
	1761201693; bh=13xq5buPbG9VcuxLkgEsovGjlnCUBsbrY4W34vFbxZU=; b=n
	lYPJU93Dvq84Dyp8yqvcn1+pMQAY87pH0DWu/GGc10VuPTfHuBS6dMRHFjV0BrXx
	vtxloOTx3B5zObIxNXqpskPkVtxDfo13qR/WiAJb+8Ufa4SBkdgqgTDtdTRvIo0A
	snmHh59zzG1dDzBuGaPXYwJoyqCbq6Du+1UgRdgWae+BXFRmn5XSsDcXHasrB32F
	RQXDUrUarCUJ7tCRpePSrHkxv673IbIVBvBVWmeuOCmH5lWcpu4L9gifjpWUuU8c
	mfvKng6RskSyXwJOKh1lFHmg89NykIl9Jy4QdT7ehyQa2JaOSZ+sa9NEkauzrrY3
	gzE5y+yat4ricre+AjvPA==
X-ME-Sender: <xms:nXz4aJMJQyL5blAsDSLJQvYhv2OsUhCLjliLRIFb7mndJwrGiC6nyA>
    <xme:nXz4aPpmGhaab7rswkhbqtuc-lfQl_A2l3wJM3Bc66MCA7CWAbF71C9hJZp6aEw0-
    CWwGX5AkfdAL-pjHhlqfgG8siQadyyavGLNx_gp2ydTqG8OGSYl>
X-ME-Received: <xmr:nXz4aCHP_STwWGXgQxdG0y8vbiKlt58IRU5Bxy-Lpj1o8zuaRAs6Re0U52FzWFdRiFjDcjiy82CGKFlICzs4pLu2iTGghCmVx2PuLzdcihY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedvkeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepkhgr
    rhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdp
    rhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:nXz4aMpGgjxh3E9VQ_yIkL7slj4rpZWD5kcNX4hlq1Z7x4QHsGjizQ>
    <xmx:nXz4aDZvv6PM6O8oP75UiSoQqYM4vLCctxbzzS_OBaM3jVJqcGQ20Q>
    <xmx:nXz4aNX8ZJ-XqkhF0Yr463FN4PfPPbmfBS80jwzOCyaHyuIcMd_lQQ>
    <xmx:nXz4aE97i3HTDOLFBPmHIlWKH6tcB7h2cNf5wBadL2i8QjmNuBP4jw>
    <xmx:nXz4aJI7In4ZQjIvbh-FDm7ewlWky2egY049vnGB_QZFKJ2etRh2qXeE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Oct 2025 02:41:32 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d1c8fad4 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 22 Oct 2025 06:41:31 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 22 Oct 2025 08:41:09 +0200
Subject: [PATCH v3 09/14] refs: drop `current_ref_iter` hack
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-b4-pks-ref-filter-skip-parsing-objects-v3-9-eb9f71985ef0@pks.im>
References: <20251022-b4-pks-ref-filter-skip-parsing-objects-v3-0-eb9f71985ef0@pks.im>
In-Reply-To: <20251022-b4-pks-ref-filter-skip-parsing-objects-v3-0-eb9f71985ef0@pks.im>
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
index 1b1551f9814..9d8f0a9ca4a 100644
--- a/refs.c
+++ b/refs.c
@@ -2324,16 +2324,6 @@ int refs_optimize(struct ref_store *refs, struct pack_refs_opts *opts)
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
index fe5980e1b6c..072c6aacdb0 100644
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
index ed749d16572..f4f845bbeaf 100644
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
2.51.1.851.g4ebd6896fd.dirty

