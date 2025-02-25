Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368D0263C9E
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 08:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740473772; cv=none; b=aQqRjWOwl5dPieiR+LEfageSY9qtDjtXTSuuH+cdAndUXlsDlyoELc+FMUK/MIM8F6csHsjemrLoyPdbKrNOYort0znIm3ySYacnT4Be75Z7DFjfi96ue5mAbVMj5zSqI9fdpcVdUK6NmvEeBHOi/KeFrGPTeMCWnG5+LUcEbiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740473772; c=relaxed/simple;
	bh=5kOgx3i+PcR7fBiy5x6j0oXS8vRYhnvh5F3OTXIL13I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U7O/s008uvYsGcbqh1jEzGktuBj6z8ELD3buzEyOIxMEHr8fl3A+jl6bA9EfPlns6pIJcYs0GJOuOWI2JamJ/xxvYDad3Yho92Ca/vQrHhb7Sdofrlof7keyUVCjuAjLOiLZPg713mmTlHG3OwNFgVFc5utGp3OI5HHQFzeaYkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gKqgtki2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X1j6Q6kI; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gKqgtki2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X1j6Q6kI"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CAB012540175;
	Tue, 25 Feb 2025 03:56:08 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 25 Feb 2025 03:56:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1740473768;
	 x=1740560168; bh=oj4Vcr+ljcz7ft0h+7Rb+BaVJG8I37p7JvxMZ2r83K8=; b=
	gKqgtki24sXoMSHz53pjuO279kyrprUeFL8dMy6soBfueq0xObixSuo/7k7wl7Wh
	/mFv96H5oZhUXllUjwCqVLPLrbPC6bLDggEOZoRRxP3D3T9HvElR55YfyZTjMqSC
	1KtrSrhQJ273L9p5vdVhVezQVeHMlNfM4XbPG6A9ABVoi6dxNltReI8E9Svj2zUU
	ah/TyDlRNAxr0phmworH0npvgpsJZjso6A7SlR3hDNwg0AmFihT/3dxltsVwiiEU
	owUCCYWG+xgUNbtvfmlLFpTKM5FhddEQyuRH2TaJhBvuZ4E9m27Gul9OYi03FwMm
	P1iNkbHH8loGalz9O01ZyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740473768; x=
	1740560168; bh=oj4Vcr+ljcz7ft0h+7Rb+BaVJG8I37p7JvxMZ2r83K8=; b=X
	1j6Q6kIYkRvS712P2+ndZlG1nBZRRio3qDuD3VNNS0v2T+zLrI/aVexDe+fp6Smb
	USXSMchl0w+Ic/WPDKOxtCDFGwvH53W+oz9MhkgJwEN7GymDx2A0eU1iN2mNkNYl
	4O0eSzYihIjrN1gZF1RUmcM0SBcMrtmAfHcHWXpeZnDIdHEm9G9KlmtTdSkomCGu
	zAtduTMej0tKg3boydjnZpBcPfRc/m4a0oekWAisjVheXjSaDlcnFIX2z6HoUaIJ
	9VzT2d9EUbie9d7Sxa6uwDiGY1JwvLlMEqGnUY6lX1NFLEgFpsiIqOUFkwYiJi39
	52TFTW0RADk0hU1COc6zA==
X-ME-Sender: <xms:qIW9Z20Yq2Qyn3xebuPm2Q0dv81RJCtomkkykFNYTFpsKI-ZXIyUSg>
    <xme:qIW9Z5FwPeeMY55pU-4-xk2W5U4BPM9Az1oHZ6tOGavrPWPQ24VG-XiDzk_VhuBOz
    _wFoiLv88snmNCB4w>
X-ME-Received: <xmr:qIW9Z-6LVyOcSXyhqjBg6si3e848l0HSgZVldVtINUR3-iX4xMYWNCweCFoiteqfQobcSEWCVDIIcOzK0Au8-bbHdxm7d0_cXskOzpa9sRMWFA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekuddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtth
    hopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehshhgvjhhirghluhhosehg
    mhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhi
    drohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:qIW9Z33USVxzZd5Qg2VtWcVja5iIlVxWGJFSKHW6_pS8KMshdGQ_2g>
    <xmx:qIW9Z5GL1yVeuwSCteOwdHt3RF65vjTr0k1vHptTiToKPVxlbLAFBQ>
    <xmx:qIW9Zw9PvayRznhk-eF2N80ttDZBcwWDMlWKDnzBhYfAoL9ecs3ruQ>
    <xmx:qIW9Z-m0E_i3d-vTNglkkvxLO3Q7tHyUEaZJWha2F801PtlNiDIsdw>
    <xmx:qIW9Zw1BmIVdskP9r5EBLmjk2a09jRgPd93NVto7n5b0tEOYwUZhLnQp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Feb 2025 03:56:07 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f067772d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 25 Feb 2025 08:56:05 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 25 Feb 2025 09:55:56 +0100
Subject: [PATCH v3 10/16] refs/iterator: provide infrastructure to re-seek
 iterators
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-pks-update-ref-optimization-v3-10-77c3687cda75@pks.im>
References: <20250225-pks-update-ref-optimization-v3-0-77c3687cda75@pks.im>
In-Reply-To: <20250225-pks-update-ref-optimization-v3-0-77c3687cda75@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 shejialuo <shejialuo@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

Reftable iterators need to be scrapped after they have either been
exhausted or aren't useful to the caller anymore, and it is explicitly
not possible to reuse them for iterations. But enabling for reuse of
iterators may allow us to tune them by reusing internal state of an
iterator. The reftable iterators for example can already be reused
internally, but we're not able to expose this to any users outside of
the reftable backend.

Introduce a new `.seek` function in the ref iterator vtable that allows
callers to seek an iterator multiple times. It is expected to be
functionally the same as calling `refs_ref_iterator_begin()` with a
different (or the same) prefix.

Note that it is not possible to adjust parameters other than the seeked
prefix for now, so exclude patterns, trimmed prefixes and flags will
remain unchanged. We do not have a usecase for changing these parameters
right now, but if we ever find one we can adapt accordingly.

Implement the callback for trivial cases. The other iterators will be
implemented in subsequent commits.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/debug.c         | 11 +++++++++++
 refs/iterator.c      | 24 ++++++++++++++++++++++++
 refs/refs-internal.h | 24 ++++++++++++++++++++++++
 3 files changed, 59 insertions(+)

diff --git a/refs/debug.c b/refs/debug.c
index a9786da4ba1..5390fa9c187 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -169,6 +169,16 @@ static int debug_ref_iterator_advance(struct ref_iterator *ref_iterator)
 	return res;
 }
 
+static int debug_ref_iterator_seek(struct ref_iterator *ref_iterator,
+				   const char *prefix)
+{
+	struct debug_ref_iterator *diter =
+		(struct debug_ref_iterator *)ref_iterator;
+	int res = diter->iter->vtable->seek(diter->iter, prefix);
+	trace_printf_key(&trace_refs, "iterator_seek: %s: %d\n", prefix ? prefix : "", res);
+	return res;
+}
+
 static int debug_ref_iterator_peel(struct ref_iterator *ref_iterator,
 				   struct object_id *peeled)
 {
@@ -189,6 +199,7 @@ static void debug_ref_iterator_release(struct ref_iterator *ref_iterator)
 
 static struct ref_iterator_vtable debug_ref_iterator_vtable = {
 	.advance = debug_ref_iterator_advance,
+	.seek = debug_ref_iterator_seek,
 	.peel = debug_ref_iterator_peel,
 	.release = debug_ref_iterator_release,
 };
diff --git a/refs/iterator.c b/refs/iterator.c
index aaeff270437..757b105261a 100644
--- a/refs/iterator.c
+++ b/refs/iterator.c
@@ -15,6 +15,12 @@ int ref_iterator_advance(struct ref_iterator *ref_iterator)
 	return ref_iterator->vtable->advance(ref_iterator);
 }
 
+int ref_iterator_seek(struct ref_iterator *ref_iterator,
+		      const char *prefix)
+{
+	return ref_iterator->vtable->seek(ref_iterator, prefix);
+}
+
 int ref_iterator_peel(struct ref_iterator *ref_iterator,
 		      struct object_id *peeled)
 {
@@ -50,6 +56,12 @@ static int empty_ref_iterator_advance(struct ref_iterator *ref_iterator UNUSED)
 	return ITER_DONE;
 }
 
+static int empty_ref_iterator_seek(struct ref_iterator *ref_iterator UNUSED,
+				   const char *prefix UNUSED)
+{
+	return 0;
+}
+
 static int empty_ref_iterator_peel(struct ref_iterator *ref_iterator UNUSED,
 				   struct object_id *peeled UNUSED)
 {
@@ -62,6 +74,7 @@ static void empty_ref_iterator_release(struct ref_iterator *ref_iterator UNUSED)
 
 static struct ref_iterator_vtable empty_ref_iterator_vtable = {
 	.advance = empty_ref_iterator_advance,
+	.seek = empty_ref_iterator_seek,
 	.peel = empty_ref_iterator_peel,
 	.release = empty_ref_iterator_release,
 };
@@ -368,6 +381,16 @@ static int prefix_ref_iterator_advance(struct ref_iterator *ref_iterator)
 	return ok;
 }
 
+static int prefix_ref_iterator_seek(struct ref_iterator *ref_iterator,
+				    const char *prefix)
+{
+	struct prefix_ref_iterator *iter =
+		(struct prefix_ref_iterator *)ref_iterator;
+	free(iter->prefix);
+	iter->prefix = xstrdup_or_null(prefix);
+	return ref_iterator_seek(iter->iter0, prefix);
+}
+
 static int prefix_ref_iterator_peel(struct ref_iterator *ref_iterator,
 				    struct object_id *peeled)
 {
@@ -387,6 +410,7 @@ static void prefix_ref_iterator_release(struct ref_iterator *ref_iterator)
 
 static struct ref_iterator_vtable prefix_ref_iterator_vtable = {
 	.advance = prefix_ref_iterator_advance,
+	.seek = prefix_ref_iterator_seek,
 	.peel = prefix_ref_iterator_peel,
 	.release = prefix_ref_iterator_release,
 };
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 74e2c03cef1..8f18274a165 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -327,6 +327,22 @@ struct ref_iterator {
  */
 int ref_iterator_advance(struct ref_iterator *ref_iterator);
 
+/*
+ * Seek the iterator to the first reference with the given prefix.
+ * The prefix is matched as a literal string, without regard for path
+ * separators. If prefix is NULL or the empty string, seek the iterator to the
+ * first reference again.
+ *
+ * This function is expected to behave as if a new ref iterator with the same
+ * prefix had been created, but allows reuse of iterators and thus may allow
+ * the backend to optimize. Parameters other than the prefix that have been
+ * passed when creating the iterator will remain unchanged.
+ *
+ * Returns 0 on success, a negative error code otherwise.
+ */
+int ref_iterator_seek(struct ref_iterator *ref_iterator,
+		      const char *prefix);
+
 /*
  * If possible, peel the reference currently being viewed by the
  * iterator. Return 0 on success.
@@ -445,6 +461,13 @@ void base_ref_iterator_init(struct ref_iterator *iter,
  */
 typedef int ref_iterator_advance_fn(struct ref_iterator *ref_iterator);
 
+/*
+ * Seek the iterator to the first reference matching the given prefix. Should
+ * behave the same as if a new iterator was created with the same prefix.
+ */
+typedef int ref_iterator_seek_fn(struct ref_iterator *ref_iterator,
+				 const char *prefix);
+
 /*
  * Peels the current ref, returning 0 for success or -1 for failure.
  */
@@ -459,6 +482,7 @@ typedef void ref_iterator_release_fn(struct ref_iterator *ref_iterator);
 
 struct ref_iterator_vtable {
 	ref_iterator_advance_fn *advance;
+	ref_iterator_seek_fn *seek;
 	ref_iterator_peel_fn *peel;
 	ref_iterator_release_fn *release;
 };

-- 
2.48.1.683.gf705b3209c.dirty

