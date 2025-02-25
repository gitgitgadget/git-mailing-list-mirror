Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D8D263886
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 08:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740473774; cv=none; b=M50HnAqUKO4uADG84/U0ISElL5XkLPNswDISjuk58pMSpM1oyfs70dFkqnBwKTfUHiFD3pVA7YwPZ+rjC1VeFLBWBQTpZcTjh7TxHuqsJhhUgob11LHV+r02reaOYu6bmPF3W+Ok6I3dOHDyJv8Hdjn9yXPo5J+KNT1L4Ib1lHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740473774; c=relaxed/simple;
	bh=/0IFBjka5RSKHN0lmTDzuZsfqgESV5sXl0oGulLXHZI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n1ho0iqA6qZcAE9K4gfRdWjyHU9BpQ8yVs2ZrXERbj7gQmVfG/uuugXgURov6uMYK9+32r3xCe7fwEatXCavBrfJs9Ksh34MJtegZDOfN++3v6kHH59+MvSWxhU+L21zfVvTM7KIdLBcOyV/4NOxtExF+NkXXLQPOaxYajV5qbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=R3NJwl+7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wdPs7a4d; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="R3NJwl+7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wdPs7a4d"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4BFA72540170;
	Tue, 25 Feb 2025 03:56:11 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 25 Feb 2025 03:56:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1740473771;
	 x=1740560171; bh=VfvnvaeRNnx9p7EKMFVlxRCbr6h/1hEIn5aWI/k40SY=; b=
	R3NJwl+7rQeC9PLoIejVh5nUGd+tt7y5MP3Cx+0PyCM9RatueDTwF1lOEMsrfGA8
	DaNpZX2comd85+hHvrzGkpl99qhFmMalCx6tPQx7zUpkt6FiHzsUquuoqwnZEzit
	Z7Len1yPFlXo7eTiVG/Rg3tYxjef3zFVJrFlh5VOOhoJcw+ciVyXnFthdLm1Fncs
	yvUMw0dCO59bPxoEqSq6d/9iAhIyEtQ3rXNY4w1Unm5rYUfT4rzmelNgX7bu0PJC
	JQ8gv8FBWa8njReday+b/udZP7vkpOBLqmrqzLnuMrDI4Apo/F4+zjEonlscWRyh
	QyrW8FKaO8H1LLkuQRuiTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740473771; x=
	1740560171; bh=VfvnvaeRNnx9p7EKMFVlxRCbr6h/1hEIn5aWI/k40SY=; b=w
	dPs7a4dbVBOSSZltSiuisgkn62xFw1F+5/H8DbsJtdZJXmRl/EL7krInYL2bDzDD
	7bk2r/UZNoZQfm3Qu6u9pgo9fA2WuYxLUBuOXZOiei+kaYhJFrTe9cebCXruSurU
	+P0bprcbLF2ixuGc7ykqMpa8G6NgK8+cM5q9Q3PNRaEdStu7fPJZ0XO3hUkYlRjp
	9TT6a8imDC+KTmIOYMyUK7j2ONBiprL3bZjgAECBKzgGJ0Ft1BDQ2VzRDDQfdyUp
	9nTJNfne+R5gzAImMH57jiZZ925IiSSzNoPnZggwyuCfxmPZCbVlzsUZ4LVhwg1k
	Xt9KIWC9lh+wWEkoxYbPA==
X-ME-Sender: <xms:qoW9Z2vJTHtCfSoxJiBtKu537yMGxDp1HzleI5KyZhyi7TklkhAxLA>
    <xme:qoW9Z7cAQj2vGfJfDJZ2A39unOfbl_O1w2sPJ2quYyLFAMCRgLjCVNzCrbYOmHTFk
    cZYUlKWnk_-0XOyVA>
X-ME-Received: <xmr:qoW9ZxwQ07MXjtDgpiWGm1iPdoklQvJ3PxmFeC8NlOG7UyA4F2Z_v9vUb321g9fR3DGX8dvJJvnHrfvsufFsxtfhV79QpfRE6f6tofdFhB6Vrw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekuddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehshhgvjhhirghluh
    hosehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgt
    phhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprh
    gtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhg
X-ME-Proxy: <xmx:qoW9ZxNwCpiWCL3KE2seWB1KbgFSR8--oDEzXEBkqL0al72CoKIqIw>
    <xmx:qoW9Z2-O6iS_irRqSnCaXXmcoWfR-VuS3YPN9syHnMDJqWNzsYfABg>
    <xmx:qoW9Z5X7EIU-RI3UGN5kFLE3_khsIjSgrn4i8lUZ314BfAs59VcUJQ>
    <xmx:qoW9Z_eNPIAIElPzvoXI3iG3UYq0pmPhNnhBNLym_Uw365_3kuSqtw>
    <xmx:qoW9Z7MmGfeIlraHvRlIXvKnSu07VzqpMvRq-defR1dnT9ZZpad-pWhg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Feb 2025 03:56:09 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b9e7c1fa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 25 Feb 2025 08:56:08 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 25 Feb 2025 09:55:59 +0100
Subject: [PATCH v3 13/16] refs/iterator: implement seeking for ref-cache
 iterators
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-pks-update-ref-optimization-v3-13-77c3687cda75@pks.im>
References: <20250225-pks-update-ref-optimization-v3-0-77c3687cda75@pks.im>
In-Reply-To: <20250225-pks-update-ref-optimization-v3-0-77c3687cda75@pks.im>
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
2.48.1.683.gf705b3209c.dirty

