Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468072D97BA
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 10:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759834764; cv=none; b=N1lrdPCqoammXtKyt8YTD4CKtaDtM6xfjcHFO2/R5S+54XRGFKbUnDRh6MrFnezofOUdypPTKZ+GPGugZ6pHBJZ5Znl+qQJskiUV3DgHx6mq76wBqI5XsVngdhiwjUzdgHaC+zilXgwn7FpVcFgMlhTa+Sube4J/u6QOGjDXhNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759834764; c=relaxed/simple;
	bh=V6r0Z8uo5GN+JRewB7hWSUAPfb1ip13qZs6iqBS4iuk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fhDrxMqfg1JD0Ped36tVZjmtK+Ref9KoaCuHXZAiLf6RYgawKANJs5rG2VO2SQBkstyWXcRqQ+0qKvLuqhdNEJQffsibT/aw6iE2RzmYct87gaQmR+vGNCRKGYCUQBY2Gh6rEzjGjVrWjBO8m/5kAQVUYGY4cygZN8vHCyPxdFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=m82n43ck; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C1QGH/XT; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="m82n43ck";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C1QGH/XT"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 82C197A0084
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 06:59:21 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 07 Oct 2025 06:59:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759834761;
	 x=1759921161; bh=5sgi0Ajcg2vLc097y8mu9mbtmiNJBaYcyZ3j1h6yhMU=; b=
	m82n43cklVrwa7imAAkXtepiixf0LaiIvVGQWcPbQs6MAN8l/rp4sxgDstc1O+35
	oWiQ18aiBVDuQ38aZnHDmavabyRZzsLiu4yGLAqx0v2V5VHKaPJ1JwawUdF/ekc3
	8M9SHkcK28vKooxjhKxghl5cbrTExgPmAsfHPtAKcByN22jTion51qpNVzR2pDBV
	xiOlgW9vKFAmHp5WNxDi5ZdCn3sDOw4et1HEPu60gxESQMvHR0D+TuNv1k0EFtT9
	2acnefZax0YljabRxjoQXwYPUDYEBe+xmkTZEgTq59pnXni0ti4fYOLCWdaqYmNp
	OjU4BQrMWpdWJqQ+S440Tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759834761; x=
	1759921161; bh=5sgi0Ajcg2vLc097y8mu9mbtmiNJBaYcyZ3j1h6yhMU=; b=C
	1QGH/XTfW9Zltx7wYxAyyYeNt9Twjbbg/5XdM6gqZ5wI/hAFfGoEoqtyNYeKfb3x
	Zzmmp92P13etVKfuAGYysti5TtSkGeItYLTMzeX/wciU0p3p196UbGfq+vuNQ4aG
	Dw4vaY7Sf6COKRk3mtg6MFcwYI8dqN5cEm9jMh2imzUFCfc3X8rGPtok23kdp4e5
	5wDfsm/cOLdrJX5RkyIXMvS5vDs2Thjm8ECp3IcaA0Q4cm3SokeXEyzJ7+58pMEH
	1tDBKHMkO2CvimLE5Hg137J3zPaMNWjjCuG8qNmhNZaUGlx/fYEktw0Lg8oy7KpR
	jWEkUq7yBQzUuxKSsCW9Q==
X-ME-Sender: <xms:ifLkaHhDWF4Zvw_ZQqUSGg1lLwsEOKUqi3qDapdtRzkIRQCJ2-dR0w>
    <xme:ifLkaK-ecmHJpiTZNCz67bHSqP1zqm4Ao3_S9njbikoTlf8GzsWQVd4plzLSyO6lX
    kpkeTBTDXvkg8w4ZyhuDN3_8zYJoFsb8ahgoHDrXUAwz-lQHHxb>
X-ME-Received: <xmr:ifLkaMs11f_DxmQa8kfHijVKr9IL88vfYRDtOPecQRwQbhnfMD4lBWcS99tcY6pXCfnNlzoJ0OgYGtnn7Kd5caxWZtv2K9jQ3OZzMQIO2Ic>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddtvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:ifLkaJbKtYXM2FX-RVZryNEhS8ouGYuvHBcDWI6Lci-A4rn-vbWrZw>
    <xmx:ifLkaEr71rks1ZgtZlBDWyyLhOr01Z3ZGhdRi7omBTPXGYb-OYYgWA>
    <xmx:ifLkaG9nMNzIk0YCIh2GUqWefwpSyGaLbQwtrHwxhXgf-4rysx13zg>
    <xmx:ifLkaL_N3Ogno-f1Mm1LHj5bqkHN6BQgVGa_0zMtdCsWvwCzs2Kllw>
    <xmx:ifLkaIjrqcyNWaTJAlQ6to4s_O6uv-Zn0P6gIWJQDXNkJm3aANRvPgi1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 7 Oct 2025 06:59:20 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 18cbab16 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Tue, 7 Oct 2025 10:59:19 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 07 Oct 2025 12:58:45 +0200
Subject: [PATCH 08/13] refs: drop `current_ref_iter` hack
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-8-916cc7c6886b@pks.im>
References: <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-0-916cc7c6886b@pks.im>
In-Reply-To: <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-0-916cc7c6886b@pks.im>
To: git@vger.kernel.org
Cc: 
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

