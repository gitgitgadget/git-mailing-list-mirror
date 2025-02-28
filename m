Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B52D25DCF0
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 09:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740734822; cv=none; b=M/LT/dA7iPFJlzBRhvmB/cgtkoUEATCTqkLu94yH9XfuwHobDFuhdQZsrD5GuuYoQwojyHsNBBJ+4VmjhHhFamd40dnPUlROOaAfJ9hRavpSCkC1wcGSVWQYNvz39T/LV2Fj4ntvOgowRHI29eZcAVIWausWqaKAnFqIYb6T42A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740734822; c=relaxed/simple;
	bh=dWrkJrINkg0rFM5nkOOnGMbHc3V850lYP1w3pi47Wrw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RfcrKOvAD65zAGNg8YJrdaMe0NA90J9iC6Q7iEsgjBSUk4ZR2j8C43ft0C2xAbvCrybn6sbkLxLtQtyzQ62mdSmDayh7KEIuKpRSLDNeAsRP6A3lDhzCOzjTNu9GDUB6S8O5bFtpnDECYQP2HlbxIfif9pM9Z2d1N6BUUHIIxVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AQjC9Pu3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Co4ndWvy; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AQjC9Pu3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Co4ndWvy"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 76DC01382785;
	Fri, 28 Feb 2025 04:26:59 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 28 Feb 2025 04:26:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1740734819;
	 x=1740821219; bh=fZza6ORuoLN29wXDIK6k5dPN0aLxuCJWeLE9XJpIB0w=; b=
	AQjC9Pu3AEquIEcQcz9bH7qnbUHjlf8wU5U9UjJTV3UkZGkJWKjxoRqQ3WiuYkgz
	AvFEitufiLH8aSYB9HSFvlbkdulcxxsGhGnT9er1PnO/LdIcgfQVrZENbrMSyCgp
	xcFNYfnEqoIK6mHc3KNRU4hTNiTmmfpYDpw8yJLEWLrTk0RWyL+Yln8TkcbNBReX
	SJpOKplHc1kL5Xdibi0wDqyzVhOiR1gF3+pKFw7x0X+0lq5AvJ+4zzdPPcgPb5eF
	KZ+JeM5Gf0IEe6xTC0Sc6Dihr75e1Ai4VnOoQ08KG+6Sj/QLzaAKZkzLTI8/+ASm
	+PLjCdysbwnQR+18HyDixg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740734819; x=
	1740821219; bh=fZza6ORuoLN29wXDIK6k5dPN0aLxuCJWeLE9XJpIB0w=; b=C
	o4ndWvyCUIGJJl4oKcQL7JWs6ALEJRJdPFM6H4fVSj3omovOKEV0gjdpySFroeim
	DX4apXxtjiZQwgTiEqzv92cO2EZ+6QZ1R65zF6XNof5WCFBBiRZUA+BcLLUw6xRf
	Rqr8JKLYM938BgZcpoIdbHkera5yuXff257z0a9jstoc+kVzmaAmfqoEmw3GzRxc
	4uv9Xm8XKCMFkKn0/3UXzTIBKZHZh1NiogB6Zw+TXb2RERpvPCSdtejzTi7fgCHS
	BT52KQ2RirQ+01Vh0z6MXMZ5qAg43HHmHnRzkvpQRb+foDpaf4OeD3EjtBgFNSFJ
	68QBoiZy9E4qT/DpDgmBg==
X-ME-Sender: <xms:Y4HBZ378Cna0GRClq3oJLFPtykxg_PukOFEBkwgapTPpyfh4I7yNHg>
    <xme:Y4HBZ87RpHHQCcU-5ey0jQx6tADSg6GxMDwrfXgSAdLzwuZ-ppd1y5vZJWN-XyIF3
    jaRNTuLWKSQInaV_Q>
X-ME-Received: <xmr:Y4HBZ-fA9HzTdnoWdBDoqe9psUjnKohkphZk0YPKV2hgzYBP_t_sD-0G1-TiYnv9PuFsq7J8j1jfPQzox-tYwo8fX3RzTRgdP6OJlFsIyGw4fEZS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeltddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtg
    homhdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehpvghffhesphgvfh
    hfrdhnvghtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghs
    thgvrdhnvghtpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidroh
    hrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Y4HBZ4IYXYUttU47Gyx0VmmvVickWnYiHJ0KDGivHGt03F9o5gGy-Q>
    <xmx:Y4HBZ7L_w_zoi28QyiHH5QbPsgtQmNR51QppX-I6MwXaj5X0dmkA2A>
    <xmx:Y4HBZxxnLEy4m2hMph9nMAORdl3laBKEHx_Ae9cY_G60M4CnYZSW_w>
    <xmx:Y4HBZ3Kg-BtHcMlQRx3mV2eENi2Jqj_JymOpSOW_ioDQhWUZ4jMnqA>
    <xmx:Y4HBZ4prPmhM8eHtHASjSFKp2RHr_oFrLkpwA8g9BzCVGyxbJgaOSw_W>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Feb 2025 04:26:58 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 519a629e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 28 Feb 2025 09:26:56 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 28 Feb 2025 10:26:50 +0100
Subject: [PATCH v4 13/16] refs/iterator: implement seeking for ref-cache
 iterators
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-pks-update-ref-optimization-v4-13-6425c04268b5@pks.im>
References: <20250228-pks-update-ref-optimization-v4-0-6425c04268b5@pks.im>
In-Reply-To: <20250228-pks-update-ref-optimization-v4-0-6425c04268b5@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 shejialuo <shejialuo@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

Implement seeking of ref-cache iterators. This is done by splitting most
of the logic to seek iterators out of `cache_ref_iterator_begin()` and
putting it into `cache_ref_iterator_seek()` so that we can reuse the
logic.

Note that we cannot use the optimization anymore where we return an
empty ref iterator when there aren't any references, as otherwise it
wouldn't be possible to reseek the iterator to a different prefix that
may exist. This shouldn't be much of a performance concern though as we
now start to bail out early in case `advance()` sees that there are no
more directories to be searched.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/ref-cache.c | 79 ++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 51 insertions(+), 28 deletions(-)

diff --git a/refs/ref-cache.c b/refs/ref-cache.c
index 6457e02c1ea..c1f1bab1d50 100644
--- a/refs/ref-cache.c
+++ b/refs/ref-cache.c
@@ -362,9 +362,7 @@ struct cache_ref_iterator {
 	struct ref_iterator base;
 
 	/*
-	 * The number of levels currently on the stack. This is always
-	 * at least 1, because when it becomes zero the iteration is
-	 * ended and this struct is freed.
+	 * The number of levels currently on the stack.
 	 */
 	size_t levels_nr;
 
@@ -376,7 +374,7 @@ struct cache_ref_iterator {
 	 * The prefix is matched textually, without regard for path
 	 * component boundaries.
 	 */
-	const char *prefix;
+	char *prefix;
 
 	/*
 	 * A stack of levels. levels[0] is the uppermost level that is
@@ -389,6 +387,9 @@ struct cache_ref_iterator {
 	struct cache_ref_iterator_level *levels;
 
 	struct repository *repo;
+	struct ref_cache *cache;
+
+	int prime_dir;
 };
 
 static int cache_ref_iterator_advance(struct ref_iterator *ref_iterator)
@@ -396,6 +397,9 @@ static int cache_ref_iterator_advance(struct ref_iterator *ref_iterator)
 	struct cache_ref_iterator *iter =
 		(struct cache_ref_iterator *)ref_iterator;
 
+	if (!iter->levels_nr)
+		return ITER_DONE;
+
 	while (1) {
 		struct cache_ref_iterator_level *level =
 			&iter->levels[iter->levels_nr - 1];
@@ -444,6 +448,41 @@ static int cache_ref_iterator_advance(struct ref_iterator *ref_iterator)
 	}
 }
 
+static int cache_ref_iterator_seek(struct ref_iterator *ref_iterator,
+				   const char *prefix)
+{
+	struct cache_ref_iterator *iter =
+		(struct cache_ref_iterator *)ref_iterator;
+	struct cache_ref_iterator_level *level;
+	struct ref_dir *dir;
+
+	dir = get_ref_dir(iter->cache->root);
+	if (prefix && *prefix)
+		dir = find_containing_dir(dir, prefix);
+	if (!dir) {
+		iter->levels_nr = 0;
+		return 0;
+	}
+
+	if (iter->prime_dir)
+		prime_ref_dir(dir, prefix);
+	iter->levels_nr = 1;
+	level = &iter->levels[0];
+	level->index = -1;
+	level->dir = dir;
+
+	if (prefix && *prefix) {
+		free(iter->prefix);
+		iter->prefix = xstrdup(prefix);
+		level->prefix_state = PREFIX_WITHIN_DIR;
+	} else {
+		FREE_AND_NULL(iter->prefix);
+		level->prefix_state = PREFIX_CONTAINS_DIR;
+	}
+
+	return 0;
+}
+
 static int cache_ref_iterator_peel(struct ref_iterator *ref_iterator,
 				   struct object_id *peeled)
 {
@@ -456,12 +495,13 @@ static void cache_ref_iterator_release(struct ref_iterator *ref_iterator)
 {
 	struct cache_ref_iterator *iter =
 		(struct cache_ref_iterator *)ref_iterator;
-	free((char *)iter->prefix);
+	free(iter->prefix);
 	free(iter->levels);
 }
 
 static struct ref_iterator_vtable cache_ref_iterator_vtable = {
 	.advance = cache_ref_iterator_advance,
+	.seek = cache_ref_iterator_seek,
 	.peel = cache_ref_iterator_peel,
 	.release = cache_ref_iterator_release,
 };
@@ -471,39 +511,22 @@ struct ref_iterator *cache_ref_iterator_begin(struct ref_cache *cache,
 					      struct repository *repo,
 					      int prime_dir)
 {
-	struct ref_dir *dir;
 	struct cache_ref_iterator *iter;
 	struct ref_iterator *ref_iterator;
-	struct cache_ref_iterator_level *level;
-
-	dir = get_ref_dir(cache->root);
-	if (prefix && *prefix)
-		dir = find_containing_dir(dir, prefix);
-	if (!dir)
-		/* There's nothing to iterate over. */
-		return empty_ref_iterator_begin();
-
-	if (prime_dir)
-		prime_ref_dir(dir, prefix);
 
 	CALLOC_ARRAY(iter, 1);
 	ref_iterator = &iter->base;
 	base_ref_iterator_init(ref_iterator, &cache_ref_iterator_vtable);
 	ALLOC_GROW(iter->levels, 10, iter->levels_alloc);
 
-	iter->levels_nr = 1;
-	level = &iter->levels[0];
-	level->index = -1;
-	level->dir = dir;
+	iter->repo = repo;
+	iter->cache = cache;
+	iter->prime_dir = prime_dir;
 
-	if (prefix && *prefix) {
-		iter->prefix = xstrdup(prefix);
-		level->prefix_state = PREFIX_WITHIN_DIR;
-	} else {
-		level->prefix_state = PREFIX_CONTAINS_DIR;
+	if (cache_ref_iterator_seek(&iter->base, prefix) < 0) {
+		ref_iterator_free(&iter->base);
+		return NULL;
 	}
 
-	iter->repo = repo;
-
 	return ref_iterator;
 }

-- 
2.49.0.rc0.375.gae4b89d849.dirty

