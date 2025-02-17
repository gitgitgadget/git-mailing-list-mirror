Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD8A23496B
	for <git@vger.kernel.org>; Mon, 17 Feb 2025 15:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739807439; cv=none; b=FzV27tMjr9tOxcwn7zbPCfI/egGIIKLaFyKjF+6UM5iK+GdT9uDXv7EdImSjXjq8u7vaRSskhtWXwEnvfldBZ8fmP41zUbtQFesHZ0A5eigcBcfy37vB9hznTUOwtdV4ldBHqU3foWY6G2TNZapkBhjB9Irb/EASQ4lWe7IFBcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739807439; c=relaxed/simple;
	bh=zXIFpULq0cvFfooG7wMGne/aY0RhwJmDV1nfUfGymaY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z5/MioOkNRb5mxQhZFVv+IRPSoTf93mB9Lq7sPInMn+8dKNzgMkEeFoy0VBHOYtRlpXTT2iv04E05Sx2w3x8FIc/W6in6EfyXgFVxHLShb3SA1jK5grPNHQVDqUhfFkbETK8uN6f8jLEdTi2ZsQdeJMjkVTzqkwMRQs3fzeU6TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EmbRzhxu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mmpn7NvO; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EmbRzhxu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mmpn7NvO"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D12D3254019A;
	Mon, 17 Feb 2025 10:50:36 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 17 Feb 2025 10:50:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739807436;
	 x=1739893836; bh=5gSR1Q9V11ebmZTwzsW+5r4buPtOeV46c/+QHKi9ZYw=; b=
	EmbRzhxuy1nROrn6MpyuJ9DDuM38GlPUTJS/YT5IWgLaIgJ+S4nNMAU5/zXuxwiY
	FDDEsTwUFjEVeP+FsmWDrX810xq+LUkA1nOcbr9tLGthZEb2z6y0cQupgYBHiHQ1
	BSQjBJYG/d+TlkGKy3iyud4jOiHUTay5dFdfaNzWmN6JCNzCxNn9bMLRlFRTiMGV
	inaVVkAG0inmv6vmaGOLH6afTXEOEp3XjXS5UtwsznydSbZRF2f5FZuO4zxhaT0M
	JjjvIzuFzVElNo4iDt0B1jUMs2N5MHye/sVpNudk9XF8ryUX2BFFVUmuX3GaIwNC
	bqmklySoQJZxYgFRjSz1dA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739807436; x=
	1739893836; bh=5gSR1Q9V11ebmZTwzsW+5r4buPtOeV46c/+QHKi9ZYw=; b=m
	mpn7NvOe+fQRnXnZfwiJzbtfxMz5O6oNHpO2y9R43G0FkLbeaFWaNd91QPS5Hf2B
	zgp+J+u9QhYTfw3cVgr5d3nKMpiZq7sGKrovAnEYrrvJg/pNwuugGNaA8Mh/TxtM
	THxocn8IZ1gs3Fr/ny1pF964uglBP5OX6txDW9IE+R1lCehGwSRi3OppAh59qpA2
	i7ez4FRRWdOs498I2LjPWKFNgytlkKPtSGSNd6GeXMT/RmpGpj1vE11VWQln7lAD
	NBlbqAwlADlwpK35RAzWMZwLbE+ihpg78RLJa1wrmY1+hdHa7d80zHttbjygZe3v
	wM29ZHswe9oNZS8Ewiy6g==
X-ME-Sender: <xms:zFqzZwm1CkbOdX4BYvNlNkIkTL-X57GHmMpwJnrKh8uxAOH1D243Gg>
    <xme:zFqzZ_1Gd2vg7lgFwgkyx14l5en5TBnnI0-2IwyTKRdsL51-p5WsGOPdPSdnCAEjY
    1tM4dis7ZHL0Pnb6Q>
X-ME-Received: <xmr:zFqzZ-rfLLp2IpiuiGVfoDV4lwsVkJq_htzA1Pvb8C5P6y5cvjRm10IIjh4nZbeRP0dq5W4b5QYj_-ThK2PSgDmMxXYOZXiSc9lWT0WAdxl8uA8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehkeekudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    tghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehsrghnug
    grlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnh
    gvth
X-ME-Proxy: <xmx:zFqzZ8n-4jLUxmIZ_AKoJQEx7FAbAp_1E96cjWuk8IolIfASdjlXSQ>
    <xmx:zFqzZ-3VHgd7xhRK5ZGpcNq6iwXWGuStJyL5epRfXRlTdQpMhP1iIQ>
    <xmx:zFqzZzugtvmt_3vsa1duPkk6vtl855XH3FjXXUEMBg04jV0zKBumgg>
    <xmx:zFqzZ6XMuLnJKccyFlNbp_NLK73n3gxFNYAWLpo1ewwF8XN-NAVpvQ>
    <xmx:zFqzZ4puo_HptU8DEamgxGfOZhaXQEqlTf0_CWAY90wl5kryYtaPmaRa>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Feb 2025 10:50:35 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c36f0167 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 17 Feb 2025 15:50:33 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 17 Feb 2025 16:50:25 +0100
Subject: [PATCH 11/14] refs/iterator: implement seeking for ref-cache
 iterators
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-pks-update-ref-optimization-v1-11-a2b6d87a24af@pks.im>
References: <20250217-pks-update-ref-optimization-v1-0-a2b6d87a24af@pks.im>
In-Reply-To: <20250217-pks-update-ref-optimization-v1-0-a2b6d87a24af@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

Implement seeking of ref-cache iterators. This is done by splitting most
of the logic to seek iterators out of `cache_ref_iterator_begin()` and
putting it into `cache_ref_iterator_seek()` so that we can reuse the
logic.

Note that we cannot use the optimization anymore where we return an
empty ref iterator when there aren't any references, as otherwise it
wouldn't be possible to reseek the iterator to a different prefix that
may exist. This shouldn't be much of a performance corncern though as we
now start to bail out early in case `advance()` sees that there are no
more directories to be searched.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/ref-cache.c | 74 ++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 48 insertions(+), 26 deletions(-)

diff --git a/refs/ref-cache.c b/refs/ref-cache.c
index 6457e02c1ea..b54547d71ee 100644
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
@@ -444,6 +448,40 @@ static int cache_ref_iterator_advance(struct ref_iterator *ref_iterator)
 	}
 }
 
+static int cache_ref_iterator_seek(struct ref_iterator *ref_iterator,
+				   const char *prefix)
+{
+	struct cache_ref_iterator *iter =
+		(struct cache_ref_iterator *)ref_iterator;
+	struct ref_dir *dir;
+
+	dir = get_ref_dir(iter->cache->root);
+	if (prefix && *prefix)
+		dir = find_containing_dir(dir, prefix);
+
+	if (dir) {
+		struct cache_ref_iterator_level *level;
+
+		if (iter->prime_dir)
+			prime_ref_dir(dir, prefix);
+		iter->levels_nr = 1;
+		level = &iter->levels[0];
+		level->index = -1;
+		level->dir = dir;
+
+		if (prefix && *prefix) {
+			iter->prefix = xstrdup(prefix);
+			level->prefix_state = PREFIX_WITHIN_DIR;
+		} else {
+			level->prefix_state = PREFIX_CONTAINS_DIR;
+		}
+	} else {
+		iter->levels_nr = 0;
+	}
+
+	return 0;
+}
+
 static int cache_ref_iterator_peel(struct ref_iterator *ref_iterator,
 				   struct object_id *peeled)
 {
@@ -462,6 +500,7 @@ static void cache_ref_iterator_release(struct ref_iterator *ref_iterator)
 
 static struct ref_iterator_vtable cache_ref_iterator_vtable = {
 	.advance = cache_ref_iterator_advance,
+	.seek = cache_ref_iterator_seek,
 	.peel = cache_ref_iterator_peel,
 	.release = cache_ref_iterator_release,
 };
@@ -471,39 +510,22 @@ struct ref_iterator *cache_ref_iterator_begin(struct ref_cache *cache,
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
2.48.1.666.gff9fcf71b7.dirty

