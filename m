Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114612E92DC
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 07:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755761965; cv=none; b=UTx7GFBQD23C4su+fd53nAsRxPtuPE4TvTSYfcxKnLozy74utZ+z/5aQAJSnP55E464iPrpyFN1RQQTBN1kdqKLjBGmhD0MysmTQ62tAqQvKolCb4z9TsMGUmgbp0/w8bH/3xzAoc6l3sugPhVaIElpGg1AmljsGmN9IlppN6I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755761965; c=relaxed/simple;
	bh=KYE5pFhsQak00ICO8AG1jFt9Q5aJbowreXsvjqFxEOg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=age8VYO4baMk4vEtL8sHPaHZiRuDWQ4CYmstLnqhwo2PHLk02scwTDyqpVdnbL6djNenM0znQhP4SbDIHeHFoBryMdTQZObqOerqVwbf0Z7sCjnS5sr9x5rYUS6PXZz3lAgprRMJMo7AZq/f111VA6T/H3U9NgGNNY1euaPtk9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fbXvB8N6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PPdTXiI6; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fbXvB8N6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PPdTXiI6"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 17D4014000B8;
	Thu, 21 Aug 2025 03:39:23 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 21 Aug 2025 03:39:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755761963;
	 x=1755848363; bh=ZBk4MeVLbmxExAmdohdDKvOPdkuvH1HRQ5it0oD3i3U=; b=
	fbXvB8N60r0i6EyYCvnLoZSZmGDez1ZmHwtIIKwWR0ZQz5Xj5E8Obgm46mIfDR7e
	pUtGxmhFAWdCopveUpZfykhktv4BXoIXJsZF2ueoZxfXIih4HfzBAEr5Y+bu6RWj
	FchYt0oxJiuAA5JTAt/aes1QDfJ/cBX9H05UdrcOtYEN3UZTbYI2hk9CKwdGQsws
	SbiNzazWf87JNoIfwvrwCfy5WY8AeQV7RwMI6QRf0dMxvCYnk7LuUAB9wJfyFaAE
	4XscbWQoqcG7L+pCT+6J/HOAcwESf/dnD1mAw0Out5C8gNrRyVKMFkF7KLQN18pG
	CiMFkjtcrzStRtmtNuHDnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755761963; x=
	1755848363; bh=ZBk4MeVLbmxExAmdohdDKvOPdkuvH1HRQ5it0oD3i3U=; b=P
	PdTXiI6xDoCYwXD0rEcrYxwNbhl9LieXmiTc98w9sWc4G3G+vKvxsMZW/6SAfbW/
	tR/9yDmsNcYhBnUKHrp88aAh5KZ6srC+2Abh44wO+Rz/R75VOWwlkDJIabQHQrMR
	vruPOKi1dAi8SVtAJjEB0XKvXBImHAHJ5+47LLSInhZCedo68deoYPXo9DCV7Gkn
	Kuwjxts+tVADOgDuxnMjUbIaoTTsXQzjc6qbTbRJh78rFGXA2smKF6kn30AiskXT
	CWzcOPjpcLgn9BSjJtCRORhMnaL2aaiZROl29Hkr40+HlNoMZGE4LSH9XSXi0kkn
	51wF+EzlUNhk1Am662sdA==
X-ME-Sender: <xms:Ks2maF4q6l7R8PU4yXURb0B0z3SmxUnbme3pXIT5iitgODxi6CYgBw>
    <xme:Ks2maGKG6pLCV0rWmPK7HvEdK8fXHiM9G8At8QvrhkTfM41hYNAmnOykflx_cak3e
    YpQeni4-f_xfhRWpw>
X-ME-Received: <xmr:Ks2maF7HuQkABMUA5c5Lf1yYiC1ieaW5ED6VVzf-bjbd_AyvLlcLneH2D1Q3w7uH0AW1ZTVVJ2iwmrsQYWFs0Uf93R8z5DYdEFK7iTk-pg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedtieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfse
    hpvghffhdrnhgvthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgt
    ohhm
X-ME-Proxy: <xmx:K82maJzSQcZEIhHyfcQNywYLn_U3VyQtYe7Y_BtF9Blqv6dnsy-ekA>
    <xmx:K82maJZVoAeqEfWAKV4quj_i9k7XiD380veAz1tfsOnRQKX8v_7F4A>
    <xmx:K82maLQ-RLRotGbSxHsUGgoOtEfaE6rgmc_5dMvFomVzhK2TVTCcMQ>
    <xmx:K82maDwrg1poKtMAUVH8_446aTPgtz_sNcDoMY19YpU3ExW-yRqJdQ>
    <xmx:K82maLz8irThYEAwMWmlZDgp0UliCiRGNmVccHDjBtLJt-uPBCdXilv_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Aug 2025 03:39:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 714579c3 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 21 Aug 2025 07:39:21 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 21 Aug 2025 09:39:03 +0200
Subject: [PATCH v2 05/16] odb: move MRU list of packfiles into `struct
 packfile_store`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-b4-pks-packfiles-store-v2-5-d10623355e9f@pks.im>
References: <20250821-b4-pks-packfiles-store-v2-0-d10623355e9f@pks.im>
In-Reply-To: <20250821-b4-pks-packfiles-store-v2-0-d10623355e9f@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.14.2

The object database tracks the list of packfiles in most-recently-used
order, which is mostly used to favor reading from packfiles that contain
most of the objects that we're currently accessing. With the
introduction of the `struct packfile_store` we have a better place to
host this list though.

Move the list accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 midx.c     |  2 +-
 odb.c      |  2 --
 odb.h      |  4 ----
 packfile.c | 11 ++++++-----
 packfile.h |  3 +++
 5 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/midx.c b/midx.c
index 7f3f74ef2b..7fa2b8473a 100644
--- a/midx.c
+++ b/midx.c
@@ -478,7 +478,7 @@ int prepare_midx_pack(struct repository *r, struct multi_pack_index *m,
 		p = add_packed_git(r, pack_name.buf, pack_name.len, m->local);
 		if (p) {
 			install_packed_git(r, p);
-			list_add_tail(&p->mru, &r->objects->packed_git_mru);
+			list_add_tail(&p->mru, &r->objects->packfiles->mru);
 		}
 	}
 
diff --git a/odb.c b/odb.c
index 568c820ef8..80ec6fc1fa 100644
--- a/odb.c
+++ b/odb.c
@@ -997,7 +997,6 @@ struct object_database *odb_new(struct repository *repo)
 	memset(o, 0, sizeof(*o));
 	o->repo = repo;
 	o->packfiles = packfile_store_new(o);
-	INIT_LIST_HEAD(&o->packed_git_mru);
 	pthread_mutex_init(&o->replace_mutex, NULL);
 	string_list_init_dup(&o->submodule_source_paths);
 	return o;
@@ -1035,7 +1034,6 @@ void odb_clear(struct object_database *o)
 		free((char *) o->cached_objects[i].value.buf);
 	FREE_AND_NULL(o->cached_objects);
 
-	INIT_LIST_HEAD(&o->packed_git_mru);
 	close_object_store(o);
 	packfile_store_free(o->packfiles);
 
diff --git a/odb.h b/odb.h
index fb37c6ebce..1505e39729 100644
--- a/odb.h
+++ b/odb.h
@@ -3,7 +3,6 @@
 
 #include "hashmap.h"
 #include "object.h"
-#include "list.h"
 #include "oidset.h"
 #include "oidmap.h"
 #include "string-list.h"
@@ -130,9 +129,6 @@ struct object_database {
 	 * should only be accessed directly by packfile.c
 	 */
 	struct packfile_store *packfiles;
-	/* A most-recently-used ordered version of the packed_git list. */
-	struct list_head packed_git_mru;
-
 	struct {
 		struct packed_git **packs;
 		unsigned flags;
diff --git a/packfile.c b/packfile.c
index 752a0cee8d..91a7a4064f 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1017,10 +1017,10 @@ static void prepare_packed_git_mru(struct repository *r)
 {
 	struct packed_git *p;
 
-	INIT_LIST_HEAD(&r->objects->packed_git_mru);
+	INIT_LIST_HEAD(&r->objects->packfiles->mru);
 
 	for (p = r->objects->packfiles->packs; p; p = p->next)
-		list_add_tail(&p->mru, &r->objects->packed_git_mru);
+		list_add_tail(&p->mru, &r->objects->packfiles->mru);
 }
 
 static void prepare_packed_git(struct repository *r)
@@ -1096,7 +1096,7 @@ struct packed_git *get_all_packs(struct repository *r)
 struct list_head *get_packed_git_mru(struct repository *r)
 {
 	prepare_packed_git(r);
-	return &r->objects->packed_git_mru;
+	return &r->objects->packfiles->mru;
 }
 
 unsigned long unpack_object_header_buffer(const unsigned char *buf,
@@ -2079,10 +2079,10 @@ int find_pack_entry(struct repository *r, const struct object_id *oid, struct pa
 	if (!r->objects->packfiles->packs)
 		return 0;
 
-	list_for_each(pos, &r->objects->packed_git_mru) {
+	list_for_each(pos, &r->objects->packfiles->mru) {
 		struct packed_git *p = list_entry(pos, struct packed_git, mru);
 		if (!p->multi_pack_index && fill_pack_entry(oid, e, p)) {
-			list_move(&p->mru, &r->objects->packed_git_mru);
+			list_move(&p->mru, &r->objects->packfiles->mru);
 			return 1;
 		}
 	}
@@ -2348,6 +2348,7 @@ struct packfile_store *packfile_store_new(struct object_database *odb)
 	struct packfile_store *store;
 	CALLOC_ARRAY(store, 1);
 	store->odb = odb;
+	INIT_LIST_HEAD(&store->mru);
 	hashmap_init(&store->map, pack_map_entry_cmp, NULL, 0);
 	return store;
 }
diff --git a/packfile.h b/packfile.h
index 9bbef51164..d48d46cc1b 100644
--- a/packfile.h
+++ b/packfile.h
@@ -64,6 +64,9 @@ struct packfile_store {
 	 */
 	struct packed_git *packs;
 
+	/* A most-recently-used ordered version of the packs list. */
+	struct list_head mru;
+
 	/*
 	 * A map of packfile names to packed_git structs for tracking which
 	 * packs have been loaded already.

-- 
2.51.0.261.g7ce5a0a67e.dirty

