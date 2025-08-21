Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13F12E9756
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 07:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755761975; cv=none; b=nDGFoXUiactgZ+01R9ZOqwKK56oPm9UrKuR8L/W29cG4i4m6rUlK/r3+VzQKEi/71Z+Vk+yWj3XmM+jsw49EOhEYqgmMxnAvdQF54xkDURQAfkTiMVp60auJ3XQ+FLlveU/JMHyVaSo3uTKlobouwCFi0j9J4ZAIcEGiwchXc34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755761975; c=relaxed/simple;
	bh=aXtWc6vPuRPEerEjaMZFolbeSV37OTaixajyAOuXdCQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F/Cl1Uobvzyw8YB65jBDGSnEOcq13GNs4HBAT2A3pBZjPMFyXvhVjOArrQ58Fc4sOH1KM9LuzKqvB7lTG+/ccb/StZMGfVxQ2/CxRRieWdXkZJ3+rlb2vybAQbiBNweHLRV4rkBBB6Gy45aJ04S3AD8m1b0Pi/IIM37knKbgyWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=D/kz0nsE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SIzDSJC7; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="D/kz0nsE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SIzDSJC7"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 12E97EC009D;
	Thu, 21 Aug 2025 03:39:33 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 21 Aug 2025 03:39:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755761973;
	 x=1755848373; bh=qssl4EJ85cPpnlqnPD3Kvyck2Z/et6wPyTyCGueC8AQ=; b=
	D/kz0nsEYqwRQoVopWBA3+fwoisP6VejdedtnZHNCEi/Y7LEs6i4qzaScBSnZroS
	sje2FERPFsqFr/tR4QctLNdre4agOz3y//h6EQ69A3jdRrQbuo1EdtkXNjtQZTwn
	0V/QLsrUlHl8zz7nAJ5XUcc9jQzbj8Y8rgxAR+xi9hCJLiC/duXz+ydyr8Rh8N1q
	2GPLL3XtVCQsZIdqhClyTlnI9Ix8JfQ7RXgwnUYe6opccMwc2+pftHnRyaKvm0k/
	BHtypWRqcTSPwPni/tqai3RBJfhWTESpU1oq7hZiBRZJjAvtxuLP1mZ8AKw9xouX
	3/BysKtPvoz0J3O767MP7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755761973; x=
	1755848373; bh=qssl4EJ85cPpnlqnPD3Kvyck2Z/et6wPyTyCGueC8AQ=; b=S
	IzDSJC7iG9PSOv1DIPKIPHIQVpRkN4j+e1CS5n5KZJZxv7ExShgW7TlRgIC8X22w
	XAvFUQxY0LsfnS5xj5BX2HH9IeYLPH3nuV/rnMCI0Vsx0X0CYNKRYu6hpofPOw5C
	4DijMnw+D59LNXd9ZDybzC5c9uBevk1KqmNQSok8IGj85QEG/kCJ34MKeIwnipy3
	wnFLx5sd/1t0WVApQyZqw097/PjhS2gn7W6OUVFr7H6uPca2VR33zs/PTpiA8tN9
	y0gLLOJ7QKjjR6CEweaB2s8KBuVVi9sMwZvgzJAl6it1rvUGlt4Q/N7rmVg2Dcrs
	gAfbC2U2ur+sG2+vib2Lg==
X-ME-Sender: <xms:NM2maAD2JzKdMW4reTkZclhchF7us_RxhoGUy6_Sf1aLzgCt4b2h_A>
    <xme:NM2maFzGhT6MDmubXemQIM3XWdSLiqi68m1EqXCNNTlCIYqXtu6ZUzkcBsuYCmmKi
    y5OOw84VJVXB3OQlw>
X-ME-Received: <xmr:NM2maNCgxlwvkNQ37bX-_tSK-us_tLhD2eLvfa84dj3gbfeoZSZpK1CXGWJN8zGQIY4K8424kvgHeaigDzjcppDPg-i-_-c-LZEzJz9s6A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedtieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepkhgrrhhthhhikhdrudekke
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:NM2maCbULv_BC7-gvxkUR1jhHrPooOp2Cr7t4Ea-h0bmum71Y6haxA>
    <xmx:NM2maFj5I0tSoq_2OMO4Gq0TH67QfCNmXyO9Pw-6kiMow_fixsYvwQ>
    <xmx:NM2maE5ESescWhY9SaDsvK90tgeKw5kk-H1JeQkqfUm6tVZoaHKqXA>
    <xmx:NM2maM7ppgD-H0KEnwwsDQYylFVwYmXvEaRTtOk15d4_8IAvHmcVlw>
    <xmx:Nc2maA1Yaw1r7MiKvSpIMq8S5LDXrOzReHouvNyvUsfgE5xmcX9FP3nN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Aug 2025 03:39:32 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fa00cc3c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 21 Aug 2025 07:39:31 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 21 Aug 2025 09:39:06 +0200
Subject: [PATCH v2 08/16] packfile: refactor `prepare_packed_git()` to work
 on packfile store
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-b4-pks-packfiles-store-v2-8-d10623355e9f@pks.im>
References: <20250821-b4-pks-packfiles-store-v2-0-d10623355e9f@pks.im>
In-Reply-To: <20250821-b4-pks-packfiles-store-v2-0-d10623355e9f@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.14.2

The `prepare_packed_git()` function and its friends are responsible for
loading packfiles as well as the multi-pack index for a given object
database. Refactor these functions to accept a packfile store instead of
a repository to clarify their scope.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 packfile.c | 43 +++++++++++++++++++------------------------
 1 file changed, 19 insertions(+), 24 deletions(-)

diff --git a/packfile.c b/packfile.c
index 90f15b0c20..2e45a3a05f 100644
--- a/packfile.c
+++ b/packfile.c
@@ -974,38 +974,33 @@ static int sort_pack(const struct packed_git *a, const struct packed_git *b)
 	return -1;
 }
 
-static void rearrange_packed_git(struct repository *r)
-{
-	sort_packs(&r->objects->packfiles->packs, sort_pack);
-}
-
-static void prepare_packed_git_mru(struct repository *r)
+static void packfile_store_prepare_mru(struct packfile_store *store)
 {
 	struct packed_git *p;
 
-	INIT_LIST_HEAD(&r->objects->packfiles->mru);
+	INIT_LIST_HEAD(&store->mru);
 
-	for (p = r->objects->packfiles->packs; p; p = p->next)
-		list_add_tail(&p->mru, &r->objects->packfiles->mru);
+	for (p = store->packs; p; p = p->next)
+		list_add_tail(&p->mru, &store->mru);
 }
 
-static void prepare_packed_git(struct repository *r)
+static void packfile_store_prepare(struct packfile_store *store)
 {
 	struct odb_source *source;
 
-	if (r->objects->packfiles->initialized)
+	if (store->initialized)
 		return;
 
-	odb_prepare_alternates(r->objects);
-	for (source = r->objects->sources; source; source = source->next) {
-		int local = (source == r->objects->sources);
+	odb_prepare_alternates(store->odb);
+	for (source = store->odb->sources; source; source = source->next) {
+		int local = (source == store->odb->sources);
 		prepare_multi_pack_index_one(source, local);
 		prepare_packed_git_one(source, local);
 	}
-	rearrange_packed_git(r);
+	sort_packs(&store->packs, sort_pack);
 
-	prepare_packed_git_mru(r);
-	r->objects->packfiles->initialized = true;
+	packfile_store_prepare_mru(store);
+	store->initialized = true;
 }
 
 void reprepare_packed_git(struct repository *r)
@@ -1028,25 +1023,25 @@ void reprepare_packed_git(struct repository *r)
 
 	r->objects->approximate_object_count_valid = 0;
 	r->objects->packfiles->initialized = false;
-	prepare_packed_git(r);
+	packfile_store_prepare(r->objects->packfiles);
 	obj_read_unlock();
 }
 
 struct packed_git *get_packed_git(struct repository *r)
 {
-	prepare_packed_git(r);
+	packfile_store_prepare(r->objects->packfiles);
 	return r->objects->packfiles->packs;
 }
 
 struct multi_pack_index *get_multi_pack_index(struct odb_source *source)
 {
-	prepare_packed_git(source->odb->repo);
+	packfile_store_prepare(source->odb->packfiles);
 	return source->midx;
 }
 
 struct packed_git *get_all_packs(struct repository *r)
 {
-	prepare_packed_git(r);
+	packfile_store_prepare(r->objects->packfiles);
 
 	for (struct odb_source *source = r->objects->sources; source; source = source->next) {
 		struct multi_pack_index *m = source->midx;
@@ -1061,7 +1056,7 @@ struct packed_git *get_all_packs(struct repository *r)
 
 struct list_head *get_packed_git_mru(struct repository *r)
 {
-	prepare_packed_git(r);
+	packfile_store_prepare(r->objects->packfiles);
 	return &r->objects->packfiles->mru;
 }
 
@@ -1079,7 +1074,7 @@ unsigned long repo_approximate_object_count(struct repository *r)
 		unsigned long count = 0;
 		struct packed_git *p;
 
-		prepare_packed_git(r);
+		packfile_store_prepare(r->objects->packfiles);
 
 		for (source = r->objects->sources; source; source = source->next) {
 			struct multi_pack_index *m = get_multi_pack_index(source);
@@ -2069,7 +2064,7 @@ int find_pack_entry(struct repository *r, const struct object_id *oid, struct pa
 {
 	struct list_head *pos;
 
-	prepare_packed_git(r);
+	packfile_store_prepare(r->objects->packfiles);
 
 	for (struct odb_source *source = r->objects->sources; source; source = source->next)
 		if (source->midx && fill_midx_entry(r, oid, e, source->midx))

-- 
2.51.0.261.g7ce5a0a67e.dirty

