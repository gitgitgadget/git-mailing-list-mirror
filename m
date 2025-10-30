Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7601634D936
	for <git@vger.kernel.org>; Thu, 30 Oct 2025 10:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761820754; cv=none; b=dbAhavlFNxc8waRSiEB9m2juK8Oqa6ejBneDi9YcqtNl9qcYWZ5KWCPng6Hp/hkz6WNFAtIMfNvts/fcMZZWAn9QYxcLioAwIno/Rk1a3CMedXqH/4dw5sRCUUw39Dzitt4xVVCqigcG6P1bS6YruwD2VkYEz9nTYGXYVvxICJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761820754; c=relaxed/simple;
	bh=d8ngBONJxaP12Js0pjhfmWvWk43ougccXg7NbNBwEb0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CYakMmtXDCZ3EpeWeTOinSlQkPPmDYrSauzp60p5twb/fo8bLa/lv5XmroD1OFzBL09NxdKipHv9QdZ50OnBCbXzHNUhsin2g0iOJpKNafhW8zbNbGQI8n05Ha9YSHTGla+fohFcOkGaXHh/BlW8EUNgSpHwGjhsXp5NSZQoif4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mVB+1eyO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hu94ZPJA; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mVB+1eyO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hu94ZPJA"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 964E914000C3;
	Thu, 30 Oct 2025 06:39:09 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 30 Oct 2025 06:39:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1761820749;
	 x=1761907149; bh=Zy/LqwDwfRdovhvHTG58hSeQNdUgjuJlX+Nx4fw+4pQ=; b=
	mVB+1eyOkiWOX9a67MRNs6JZZeNxSnjRJ6MD2/043nzWyLCGUMjFjkSyW1K+DpjA
	iKSOHit5C4/CL2w5f0dwWnxchGEnpUTmIiX+CDnxpugLZZd3h/t+gIuO6u6HSyOu
	Nku+kfbyuc5Gc7eAFIxyksQ9C7pTasjEvyzLQfQ3g0G2szQZBRb2HTHxAcve8K39
	ocyYwWVLLoWNwH2+1xT5t5axp3bjgq89IYlIKpZkjQw6+RDkvLoP36TcMwb3NniK
	/VqsNS3mZdS7nwXdxFkf4Z61D/qncMnWV830Ox8/2pTs1c1RGoCxJIbt8UcOBhsD
	Ba9Ho0gE3iBGWqbbdFmUtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761820749; x=
	1761907149; bh=Zy/LqwDwfRdovhvHTG58hSeQNdUgjuJlX+Nx4fw+4pQ=; b=h
	u94ZPJAIfiWHPRAlBUbSxrR2tjWnoUo8ITN8OvfEvcDh6GrGPRaE3qx7QPG3KiHO
	pmhQOWMJR5m1lHNRDz8knu5nYHleS/lpWoTvNIdLDxC3rf3ecyKsDvIK1JLVZMwu
	gPUtbNi2RlJpWbQvgpuEEkKzDGpDJ7UfASNgUPc/Ge0MwL37Zcs59UkNusuakFyy
	5by+GP8BqgGEJIxg89nVDkwP4Upf2P2RwVRakS4dwh6xzSbue7NA/HQnbZ3MnVem
	MJB40QRpSlan5XxhtCKq5XIx/xUT8tmgVReT+VXHTJz0QALhe18guqK7T0G/6ejm
	6Bl1+mEVcGesz5ikBrdYw==
X-ME-Sender: <xms:TUADaUX5hHMt8B_mp6K7Sr88pHb4kmErbL5kZWSc_dwBh_ha9R_XiQ>
    <xme:TUADafngXKx8JR3iu_boVeCITkzdJUwZlWl_cWoJ8zTPKzyq75Yhg4Nu1dloTaNE1
    7d5hz5ElieWxHsXzzFWfwrlWkG24hoZCkqZ-E9qHfzdpFPu4ebI>
X-ME-Received: <xmr:TUADadaNIZeoA9pbSMOSTqgzBZNZkb9BMJzSXyzE_9pk-PHScjAA-Eeu8iWESR7wDkWObQ2OEz-chaGX_VPzk8MnFpQQbVS1XIxD6h4nRA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieeifeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvsehtth
    grhihlohhrrhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghp
    thhtohepthhoohhnsehiohhttghlrdgtohhm
X-ME-Proxy: <xmx:TUADaSO2H60-kSw-nDKQ90Esk8znyGn6kadvmvHiGxAoZMsNG8Gogg>
    <xmx:TUADaaY0qSPjxXNhXRngSQUXSTwy7ROcAC1lmUN9j_5ufJdAm0fg3A>
    <xmx:TUADaY3c9v81ekIi3yoxc65PuB-OxlqIkP_g15O2SLxSx09UKfExkg>
    <xmx:TUADaYepKebNNYRj1kGH9ppg1TNzRE2rw25n2xrxDy2jY2NKoSURyg>
    <xmx:TUADaY4benadlYVo8mHqLdXE8HW5jlbN_qMIOcZmFWh5muAFt78pV-Or>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Oct 2025 06:39:08 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d933b3be (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 30 Oct 2025 10:39:08 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 30 Oct 2025 11:38:45 +0100
Subject: [PATCH v2 8/8] packfile: track packs via the MRU list exclusively
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-pks-packfiles-store-drop-list-v2-8-84654f080cc0@pks.im>
References: <20251030-pks-packfiles-store-drop-list-v2-0-84654f080cc0@pks.im>
In-Reply-To: <20251030-pks-packfiles-store-drop-list-v2-0-84654f080cc0@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>, 
 Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.3

We track packfiles via two different lists:

  - `struct packfile_store::packs` is a list that sorts local packs
    first. In addition, these packs are sorted so that younger packs are
    sorted towards the front.

  - `struct packfile_store::mru` is a list that sorts packs so that
    most-recently used packs are at the front.

The reasoning behind the ordering in the `packs` list is that younger
objects stored in the local object store tend to be accessed more
frequently, and that is certainly true for some cases. But there are
going to be lots of cases where that isn't true. Especially when
traversing history it is likely that one needs to access many older
objects, and due to our housekeeping it is very likely that almost all
of those older objects will be contained in one large pack that is
oldest.

So whether or not the ordering makes sense really depends on the use
case at hand. A flexible approach like our MRU list addresses that need,
as it will sort packs towards the front that are accessed all the time.
Intuitively, this approach is thus able to satisfy more use cases more
efficiently.

This reasoning casts some doubt on whether or not it really makes sense
to track packs via two different lists. It causes confusion, and it is
not clear whether there are use cases where the `packs` list really is
such an obvious choice.

Merge these two lists into one most-recently-used list.

Note that there is one important edge case: `for_each_packed_object()`
uses the MRU list to iterate through packs, and then it lists each
object in those packs. This would have the effect that we now sort the
current pack towards the front, thus modifying the list of packfiles we
are iterating over, with the consequence that we'll see an infinite
loop. This edge case is worked around by introducing a new field that
allows us to skip updating the MRU.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/pack-objects.c |  4 ++--
 packfile.c             | 27 +++++++--------------------
 packfile.h             | 27 +++++++++++++++++----------
 3 files changed, 26 insertions(+), 32 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index b83eb8ead14..0e4e9f80682 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1748,11 +1748,11 @@ static int want_object_in_pack_mtime(const struct object_id *oid,
 		}
 	}
 
-	for (e = the_repository->objects->packfiles->mru.head; e; e = e->next) {
+	for (e = the_repository->objects->packfiles->packs.head; e; e = e->next) {
 		struct packed_git *p = e->pack;
 		want = want_object_in_pack_one(p, oid, exclude, found_pack, found_offset, found_mtime);
 		if (!exclude && want > 0)
-			packfile_list_prepend(&the_repository->objects->packfiles->mru, p);
+			packfile_list_prepend(&the_repository->objects->packfiles->packs, p);
 		if (want != -1)
 			return want;
 	}
diff --git a/packfile.c b/packfile.c
index 60f2e42876a..378b0b1920d 100644
--- a/packfile.c
+++ b/packfile.c
@@ -870,9 +870,7 @@ void packfile_store_add_pack(struct packfile_store *store,
 	if (pack->pack_fd != -1)
 		pack_open_fds++;
 
-	packfile_list_prepend(&store->packs, pack);
-	packfile_list_append(&store->mru, pack);
-
+	packfile_list_append(&store->packs, pack);
 	strmap_put(&store->packs_by_path, pack->pack_name, pack);
 }
 
@@ -1077,14 +1075,6 @@ static int sort_pack(const struct packfile_list_entry *a,
 	return -1;
 }
 
-static void packfile_store_prepare_mru(struct packfile_store *store)
-{
-	packfile_list_clear(&store->mru);
-
-	for (struct packfile_list_entry *e = store->packs.head; e; e = e->next)
-		packfile_list_append(&store->mru, e->pack);
-}
-
 void packfile_store_prepare(struct packfile_store *store)
 {
 	struct odb_source *source;
@@ -1103,7 +1093,6 @@ void packfile_store_prepare(struct packfile_store *store)
 		if (!e->next)
 			store->packs.tail = e;
 
-	packfile_store_prepare_mru(store);
 	store->initialized = true;
 }
 
@@ -1128,12 +1117,6 @@ struct packfile_list_entry *packfile_store_get_packs(struct packfile_store *stor
 	return store->packs.head;
 }
 
-struct packfile_list_entry *packfile_store_get_packs_mru(struct packfile_store *store)
-{
-	packfile_store_prepare(store);
-	return store->mru.head;
-}
-
 /*
  * Give a fast, rough count of the number of objects in the repository. This
  * ignores loose objects completely. If you have a lot of them, then either
@@ -2134,11 +2117,12 @@ int find_pack_entry(struct repository *r, const struct object_id *oid, struct pa
 	if (!r->objects->packfiles->packs.head)
 		return 0;
 
-	for (l = r->objects->packfiles->mru.head; l; l = l->next) {
+	for (l = r->objects->packfiles->packs.head; l; l = l->next) {
 		struct packed_git *p = l->pack;
 
 		if (!p->multi_pack_index && fill_pack_entry(oid, e, p)) {
-			packfile_list_prepend(&r->objects->packfiles->mru, p);
+			if (!r->objects->packfiles->skip_mru_updates)
+				packfile_list_prepend(&r->objects->packfiles->packs, p);
 			return 1;
 		}
 	}
@@ -2270,6 +2254,7 @@ int for_each_packed_object(struct repository *repo, each_packed_object_fn cb,
 	int r = 0;
 	int pack_errors = 0;
 
+	repo->objects->packfiles->skip_mru_updates = true;
 	repo_for_each_pack(repo, p) {
 		if ((flags & FOR_EACH_OBJECT_LOCAL_ONLY) && !p->pack_local)
 			continue;
@@ -2290,6 +2275,8 @@ int for_each_packed_object(struct repository *repo, each_packed_object_fn cb,
 		if (r)
 			break;
 	}
+	repo->objects->packfiles->skip_mru_updates = false;
+
 	return r ? r : pack_errors;
 }
 
diff --git a/packfile.h b/packfile.h
index d95275e666c..27ba607e7c5 100644
--- a/packfile.h
+++ b/packfile.h
@@ -79,8 +79,8 @@ struct packfile_store {
 	struct object_database *odb;
 
 	/*
-	 * The list of packfiles in the order in which they are being added to
-	 * the store.
+	 * The list of packfiles in the order in which they have been most
+	 * recently used.
 	 */
 	struct packfile_list packs;
 
@@ -98,9 +98,6 @@ struct packfile_store {
 		unsigned flags;
 	} kept_cache;
 
-	/* A most-recently-used ordered version of the packs list. */
-	struct packfile_list mru;
-
 	/*
 	 * A map of packfile names to packed_git structs for tracking which
 	 * packs have been loaded already.
@@ -112,6 +109,21 @@ struct packfile_store {
 	 * packs.
 	 */
 	bool initialized;
+
+	/*
+	 * Usually, packfiles will be reordered to the front of the `packs`
+	 * list whenever an object is looked up via them. This has the effect
+	 * that packs that contain a lot of accessed objects will be located
+	 * towards the front.
+	 *
+	 * This is usually desireable, but there are exceptions. One exception
+	 * is when the looking up multiple objects in a loop for each packfile.
+	 * In that case, we may easily end up with an infinite loop as the
+	 * packfiles get reordered to the front repeatedly.
+	 *
+	 * Setting this field to `true` thus disables these reorderings.
+	 */
+	bool skip_mru_updates;
 };
 
 /*
@@ -171,11 +183,6 @@ void packfile_store_add_pack(struct packfile_store *store,
  */
 struct packfile_list_entry *packfile_store_get_packs(struct packfile_store *store);
 
-/*
- * Get all packs in most-recently-used order.
- */
-struct packfile_list_entry *packfile_store_get_packs_mru(struct packfile_store *store);
-
 /*
  * Open the packfile and add it to the store if it isn't yet known. Returns
  * either the newly opened packfile or the preexisting packfile. Returns a

-- 
2.51.2.997.g839fc31de9.dirty

