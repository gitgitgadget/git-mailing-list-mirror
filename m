Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673DE1EB5D4
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 13:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739971433; cv=none; b=WTTxzitrUzwzwS5HkdgjbmjKb3oEYuC3b4or9wQDrMsVZZ30f3ksfS2pvz7Lnn9/xi2rtqHFUoiXVgC3cQ/NYzOM4PI1srOI98ClTrWxyQ/5QZeyEYe4Qa4qZLnRRrMgNM7lv7TjSS2DY8CVqnRv4352wXdt1Z+5iqEhzrkyESY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739971433; c=relaxed/simple;
	bh=6wfc5qyL407yNIpenlfQ6REdyCy97HZhY2qVP3CseiI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LPH0W9DJX8DmKeR8YRvJOHK5tBhAopakoOtjLMCs6zcK982VyEj7wdfm8Nl/4ktItphniI7oLfHhtNxlKxDvJ77sEgwSJM3CNy4mm/S43P8CECQgHxESQgFkzGIHeG3fAg9k8V3KwRsgLMGv4/LE47KTHDH7eZtLnxuejDGQeAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=j+K9sX3a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fm2AC5Rt; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="j+K9sX3a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fm2AC5Rt"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6C84225401D8;
	Wed, 19 Feb 2025 08:23:50 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 19 Feb 2025 08:23:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739971430;
	 x=1740057830; bh=8rEoxWiWczrlwBrIFygamYX4wnELnvmf97swrB+U0bY=; b=
	j+K9sX3asO/zcRJsvjjrNJU413UuJe9m7Ak+i9j8Qq5xeVqI7QaF/Fub2RkYnKW1
	K9+yGxKxzzzSZpuD8FAJPjOww3bhHvdH244n2VSjC4mALtwKyqVSGDGBIxHflHsw
	K2AqF904vET2qaOwMLDIf6TYBREc33UMsgiXrqjGn0dzmnAlJFmzKE4Yn9ahZvte
	9H5n6LAmuNQoOof06GJTWMV8OvfEIqOCq8OXOXoes3dUR58FymAHpnykI/doPm7x
	OdFZV8sLSen3qKzkkjuCxHHcWUq14hLsjwLHcJbfUu/QkvuUyTqv16Pc0phMFLy4
	yDJUujNXRaNQCqyHplhIjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739971430; x=
	1740057830; bh=8rEoxWiWczrlwBrIFygamYX4wnELnvmf97swrB+U0bY=; b=f
	m2AC5Rtm7KoEa7mwfVo+pny42InTahj4+B07AA8Y75AqrPIWw7v78II52hzYrRfJ
	ShjsTJVl090FaDkl3YrkfPcNW4Z6NG3nsx0q9FkYSUxSNfufayn7iVxdJgK95Acn
	+SJmInRUWUt4KGjXZ5HPyUOE2ohgdUuzshUKsVAGOuKXZYh/IIFvRMZKOCe5E21G
	kw5F/v3lpDjwHOtxE8geR508qRJbJUF0JHrEH4Z2ipOmFGPAdDRNGFhrSET3n8Ma
	FacwUxEqIthviHxCgI//bA7o4gwNSu4tEtUnWHjY66nZt7gS6IYCsoOKQ+ayg2tj
	zcfl5aLMlKDuEhlq+dxrg==
X-ME-Sender: <xms:Ztu1Z2pyxV3UwREi5WDy1-XLGd1wHGTaOcHKrncy8acGwv6KRU6XMw>
    <xme:Ztu1Z0oPi_9x5MuSkNMRUDkQFvkYyEBwMPXM4sCUD5YwdKqTwOhG79k_23XhaaSIE
    z6STXk71TZrPthvSw>
X-ME-Received: <xmr:Ztu1Z7NWivnw3Gcycv89S46IKsDvXrxIw_nz1wIzAQ3ehJe4RoEmwErewljUwi3MZoJYGvGU3mKFQ587PLbK1KSuRUTyfP6E5cs0_PfXuTYSxRI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeigeefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    phgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthi
    htohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhmpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrgh
    dprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:Ztu1Z14os_UJquuIt7n07Y8q4zWH7lL_2fcHSLxc9DP575jJie023w>
    <xmx:Ztu1Z15oeIo-WAqIwwqWI8vH0cd57ZVNdnPS2e55qTDZHZknLSOUVA>
    <xmx:Ztu1Z1iAl14PfoXudKWTid9S6FAueuXNoyUkufh2GPe6R3ZHMQvWtQ>
    <xmx:Ztu1Z_5Gjnc6PzeZ4z8NwRsCsnoBHwU169fFyIekgnNtv0BFhmaPTA>
    <xmx:Ztu1ZwYAX5ikYo3msXJ44cv-IOUCCyhuSDnef7Ypn0DsuvjJwIaiz-e1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Feb 2025 08:23:48 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c63ce92c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 19 Feb 2025 13:23:47 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 19 Feb 2025 14:23:40 +0100
Subject: [PATCH v2 13/16] refs/iterator: implement seeking for ref-cache
 iterators
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250219-pks-update-ref-optimization-v2-13-e696e7220b22@pks.im>
References: <20250219-pks-update-ref-optimization-v2-0-e696e7220b22@pks.im>
In-Reply-To: <20250219-pks-update-ref-optimization-v2-0-e696e7220b22@pks.im>
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
2.48.1.683.gf705b3209c.dirty

