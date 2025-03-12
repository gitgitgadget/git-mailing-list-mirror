Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5E42580F0
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 15:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741794988; cv=none; b=ay7ijbKmbstrQ3xMUawv+iak3orqDux0k6urd0FPZgFboMw4BQBNx8JW30NEumDIsDZaKeNF6OlZcsvpHca/jnQF6QmWmyIx/cU67+G/bwLgOqizpGDnqm7IEV0PaHgETwrS8RXq83L3UPRnuwUJMYg/hIDV5UXbNQ5cx6qpJeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741794988; c=relaxed/simple;
	bh=bXASNitFs176Fox6XS/61l5fh2zndLjWHrIzTnkK8to=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BNXBii/s9OiexPAJQ0BTHhkr1leBjtpxmtx9+LEFkZ1L9DTQAKMY3mgvamGWiymrSq0EYfC/fYJmnpk0JlpbeK8PQG0ulbs/Bbkl684uRcsoFCVR0uZdbmYVX1mIMLixW8+HWMPf+acKrtpx63z6CNucyjZ1X9ePrF5ynuCcPuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=X0zkKVMT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KedLbHMa; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="X0zkKVMT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KedLbHMa"
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfout.stl.internal (Postfix) with ESMTP id 8A7081140213;
	Wed, 12 Mar 2025 11:56:25 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-13.internal (MEProxy); Wed, 12 Mar 2025 11:56:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741794985;
	 x=1741881385; bh=7zDBP21lJvED/SD8pZF73JifowXugfFlCjgTwRqI+W4=; b=
	X0zkKVMTiPbPnznmjsbxvLsflDC5OMgSK+lVG05FfEe6hUCeVSRIKQ/fke5ch1iF
	7vUd+qe9exbcgWoJegAGZ/qzhxVyzjhb8mXo0ZwpkI/pRTdew3kG6TEjV4nNVpRV
	Rh/ht6Kdczb1EmbS8OG25m6TR8aXTdKlNONRMzc1lLeEohh4OCPXT+wAEhbgxXLm
	1dcr0dJBGLAOgNFikb7O1553uJNNFSbucvOpeF2NNp4GXqNmjfbsXZi8hMsKTj8W
	TiuS/pYMu6Kz1NWGph/fx17CXYQqrUYPtwwQozt/mfr9XpmEp0BFbEF37LbYlkrr
	47WGWo09G9ElcDrncERAaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741794985; x=
	1741881385; bh=7zDBP21lJvED/SD8pZF73JifowXugfFlCjgTwRqI+W4=; b=K
	edLbHMa+bF9PaFbcrX30bJpZe3n1K/XZGlQ7ADOZVn1HplsgSjKbozckhi82DQNJ
	1e+bcahNCfL3dnuSzm17gmA7UIYl+SS47zq0c5/YirY0RH/TI4zKVrXEm8XJ2W4c
	j6zJg72DCJM+d1GPw4dDxox7Z2nAFBmIzFcS+mUX5/dZXOPkZOTC4ZsGKQNOE4Pw
	Xav5LT8f+cKhOcQCeWVWFQ64hDU0UXflYhMUqKjpQXms60uiGUeSOL/y835T5SSx
	EI0rcoQfCX6tl9uUgTUxq1h5RgCHfqilYIocESomOCHHU9jOe+kpx8BylfgOw8pl
	e4lAcZaHWTK17YEzDW7JA==
X-ME-Sender: <xms:qa7RZ-oBR_JixG2FLnw6LtwZQja5Pj-xZDtmoD0iLELkRmAU5tz5dw>
    <xme:qa7RZ8ooousKYW1za31SmG3K36jH031GC8NsNsIKEnS42RyxqGCNG51pTXJ1AtdAL
    wTvqffz6k5JphLM4w>
X-ME-Received: <xmr:qa7RZzMyScIWFE1w8Ht3Xxuvqc_ECkdLwxVaXyvpRCBe4XEh4ogU_j92cVFU2Ee8qiuZDgz6QFJbdjqnPzw0R8lEqpA8-twq-M6tknaqTp_UupKckA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdehgeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilh
    ihrdhorhhgpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgrnh
    gurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepphgv
    fhhfsehpvghffhdrnhgvthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:qa7RZ96dK0LdX9oaBFG9ch5IRPoop2ePxe_Avyq-Z7ZPqXVT3qqeCg>
    <xmx:qa7RZ95vU6UH8rx7LVMnTTkCxEt8UjvSMB2saWjIkgPTT6goQ_JFYQ>
    <xmx:qa7RZ9ixloAfDpGU38aMhQ9_6750dZ9FDYisJPPbxctls5a7ZC9CTw>
    <xmx:qa7RZ35ar9ktAUxrq-NIkncrraFhUoga8_I8Dm6Rz0seAGjXZyaPtw>
    <xmx:qa7RZ4Z5b0ZY6cnFm1mESDVEWb7SgCkKJIUVpYBIIUcagusWkD1r7Kn->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Mar 2025 11:56:24 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2ef55a39 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Mar 2025 15:56:21 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 12 Mar 2025 16:56:19 +0100
Subject: [PATCH v6 13/16] refs/iterator: implement seeking for ref-cache
 iterators
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-pks-update-ref-optimization-v6-13-f778e0414f55@pks.im>
References: <20250312-pks-update-ref-optimization-v6-0-f778e0414f55@pks.im>
In-Reply-To: <20250312-pks-update-ref-optimization-v6-0-f778e0414f55@pks.im>
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
2.49.0.rc2.394.gf6994c5077.dirty

