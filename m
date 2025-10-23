Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DBF2C1780
	for <git@vger.kernel.org>; Thu, 23 Oct 2025 07:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761203808; cv=none; b=dD7C1FVHuhnbIsDYB9+J6iyBkemHR77HuHW8s40tFTYmtv0pu6rj4cMGrdPoej7AIxVq4FUumW7P7/GwAW32iiaSYT2oWBQnCerod5rzQM+qbXm6idVeRaNtDBRYqP0rB5sWmqcdDVxorcFdxwBvdCNyll1XGHASC3ElCOFBFUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761203808; c=relaxed/simple;
	bh=8eU3KFyE9DKj1q6dvg+ounVcTojFG7U6l+v3SxBrHRE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q5nGG0fLYUWgLGnaavuCDrTMVYjuIVQUyr7657u4n5pv4/TpnMzX0m6JdF/UMiDg00xv5d4DccY4yPH/pPdUUZB/QSuufLbwum03cHJvlZqvHO6Ado2JEGTFuKQcn0RSQvtk0qOUBzZyqmFWkeIoxdbb/qlSKhP5AOQ+xCZVaoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HNotxnTj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=duFnG1XV; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HNotxnTj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="duFnG1XV"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 5652EEC01FA;
	Thu, 23 Oct 2025 03:16:46 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Thu, 23 Oct 2025 03:16:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761203806;
	 x=1761290206; bh=WF4193LLY1sDVv7InMLO/WTJ1g37RunUeMEKo8c/x1Y=; b=
	HNotxnTjNqjPnDtW4/eIt+aAkqJKAbnn337EVw3ZVZY2VzOFL8L6Zzdj+Fav1vIO
	rVranRgX+6PYwMR2Jz5CTORxOjFZb1N7Pguj3cHHPdylvUCeENVx6W/KVOl1aR88
	YBwqDE2OgvzusO5b6V7SDYaB8r3aHArpUFZBV5sgDKEDI0JDqyxuCDgjJSr09NX7
	14U7pw4AZpp3F0Z7vbakyy067JshI65NImElxgGXd78yCGpSPLt7UbACr//cMJP8
	hMBElG1d05KAtT3ycLI34cRfY4jIdvGIhSsLksvCPrgQ0mky/VLHHTrKzkSxHF2Q
	29Dy7wgOOdqcFYxRw0HSGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761203806; x=
	1761290206; bh=WF4193LLY1sDVv7InMLO/WTJ1g37RunUeMEKo8c/x1Y=; b=d
	uFnG1XVGf+T4e1U4WV6BrX/H9DuxC3EAoncTTnqqr0a2Y9lFtQm/jNHFPej+NNLI
	LkLHFHI86BUNS+Q2F4smHwRuJkw205hqXMTWivYCNyA7z+3ds6uDke0EC0zTZjgP
	nfXFARitQ1GENe563bmKP3vApgS1xm5R0xVTcayrd6TBFJ2ERCbdnwV6jXyM/L7t
	Nb8RBhtg+rtCFXUJzP+wvWj6wb8x6x6kIWrMKTFugdIsRMZl5XGHmqgYPkkKv6jp
	/D2YHY9XbmEGhkhBoR9mfmUOGqoGpCoDEsqZazFS82ZR7kN8RAy0r3pfVrEjuDJz
	iklmHzWZbZvSOsXc3G5bQ==
X-ME-Sender: <xms:Xtb5aDSMzjuNdxTx9m1v1l_f2-KU1ikx6PEvCfkIwlHGaITCp8pCwA>
    <xme:Xtb5aIerSVgJe2Tfaxa8zW6EoKQc0wW4kzrwDYHECA87uClYDy1hndXZ0ZvfjaRc2
    PS9qg1FhfEPOAtwvIUWwOyoGhnC0XAJCkaF4VErP1Osaq38jpEf5g>
X-ME-Received: <xmr:Xtb5aCqtsEK_rPBERLhBQpUbpXuPEArmqHmWq1tdau2ujXmzMCR3hvoRLwMicU73HJtfbTCvUXMYMXBZbb3YBjfy96yjNvNQY8k1Pk1SXfoSGQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeehkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslhgvrhesghhm
    rghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehkrhhishhtohhf
    fhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:Xtb5aJ_mchPD76cg6mKZ4d3o4at2vsdoZMovB8lHxeXU2DKAv1jC-A>
    <xmx:Xtb5aOfaKGay_EtgskacCAD2OAbTHrrbg7cFUJPqdxMRgN1zRzpR8A>
    <xmx:Xtb5aDLdNOLXDsnXepGCr1Nzgxggy6Gm18QdiuxWX4Nk8XLlxh-9uA>
    <xmx:Xtb5aOiQXSO7uH8Nr7FDYI3Y9iUhXz1sVVQT5h9hfIxMX1T0RBxtbw>
    <xmx:Xtb5aCM4rd6ongkAZPhLZM191kOwT3P2f80y2aOaOg_DEdTH2zP912y2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Oct 2025 03:16:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 98f41670 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 23 Oct 2025 07:16:44 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 23 Oct 2025 09:16:18 +0200
Subject: [PATCH v4 09/14] refs: drop `current_ref_iter` hack
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-b4-pks-ref-filter-skip-parsing-objects-v4-9-2be68ce82c9a@pks.im>
References: <20251023-b4-pks-ref-filter-skip-parsing-objects-v4-0-2be68ce82c9a@pks.im>
In-Reply-To: <20251023-b4-pks-ref-filter-skip-parsing-objects-v4-0-2be68ce82c9a@pks.im>
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
2.51.1.930.gacf6e81ea2.dirty

