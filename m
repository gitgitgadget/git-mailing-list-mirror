Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D949631D754
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 11:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757415813; cv=none; b=VckHNs/A0tHa1MMikMdovblAq4pG7CVInKDXfgkvIT9q/BWq4lsyAXX5bqs4j0ZoqxzqX5uRPbQ1DgaC4MLo/AFinO9IyRE/MU+yaQtXXgKX8dTco5w6uBaPkRM8dA0sGR2nnshHxTx2outid6Ks2jt24nVKzvbBE9449rdL/l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757415813; c=relaxed/simple;
	bh=OjPXzsmThDW84lKEPoVwOZ8y3nochgtt80m9rE5LCg0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bnLv2hAEhducRnd97yTpoxO6tQVBBCdlX8W0+P0EenSjgXZkLXaNGT779WK8O+BKKgUpFJaVA9Nxoajjh+Hi2YQAYzashy5u9Ba+O22l64oLa2ATIA0tInzdGo9E5S58UA5bBQZA53JGCt2FfIzfQUHbzQchxxC1DmWZA5PQOSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gcPhsgy5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=arVyWAWE; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gcPhsgy5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="arVyWAWE"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4B623140019F;
	Tue,  9 Sep 2025 07:03:31 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 09 Sep 2025 07:03:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757415811;
	 x=1757502211; bh=Nzbc+I778L5pyYy5v4ILSEgGyScpREbSfa1w+rULYVc=; b=
	gcPhsgy5Q7mP9qd3UOrm7RzaUWrRuO5sSLfeWuCPFO1ztenJX+BzLO422SxGbaOj
	SjMt8W71Y47jlbE80sA/izjMtMjh9aYZ8N6x3jvaA599Hczy3dM9jQRyRRbmojTH
	hOR8NwG25cQ9Do1ou53Sr7l5lO9AoIzlL994Q5HZ1UfKDPu/RQH1RZNwxarMzo7k
	+rux4twywjCrLjNxJrDeLhPSqBPbEWtF1SZA+fbt6KG+UyXH+D1TH2ysLyMFs35r
	S6R6mqu1jOYcgl5wzh/pHsKw37OpSUA9AM/2Kbr+RQD28R8/McwuEkMvDYXXOzN8
	u9SDmWQeS6U7dmLYHEJJGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757415811; x=
	1757502211; bh=Nzbc+I778L5pyYy5v4ILSEgGyScpREbSfa1w+rULYVc=; b=a
	rVyWAWEMf+BIGcc2hkicE6tSv/M3B7ahPbU6ZDyg1VvfpguRkrvowTAa/qSQkLES
	pbXyTpE0tW4BvtgDxE2G0eHJkSVIico4BaTymTjg/esFdbhjTu+c2srkzrBGiZXv
	O/oDd8pwkhXSDtrToR4beHg7qmkaRxGfUQSyiVXHe+tFimc+ATXYVS0xaO+KJHDY
	z/ZevcyoMrke41DIxwC2nFxg9mdPn+r5vBlxhTBZtkzWkQmFyooapAb5TnqghNqp
	Tu/j5M+L0vkCBw/xrEfJ2HzYNs/zVSpPtnP/fpiw4FHxjyhl9dRGGz2p+AcKZ87T
	ThtzY6XsEJVwFeAtvjdIQ==
X-ME-Sender: <xms:gwnAaHUcXJn7Qg-aSlh1HzvP4R_-mB_dneudWqs6AH9h4W-DtDb1bw>
    <xme:gwnAaLHOt2IA4KCz9d7c-C0OxJPBW-PIe0q0r-b-OF2e9hb8jjgLY0E8W3Tgf3Caz
    y7yPLjO8o3p9Xe4VA>
X-ME-Received: <xmr:gwnAaJ0xw7o-zQlfiMGK0NsC0Z4dwatYF7qS3jEgBslCMLJe8Xh9loGbLypALvhcqdPYMZoc_mW8ww7Hf9RX6N5q_cSCpRj9Bp65Xbs-Qoo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepgeenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehkrghrthhhihhkrd
    dukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:gwnAaNPqgPt20yShehdgw5GHXBl7EXW5Xy5IUERSQOWmT8PBDZ1TEw>
    <xmx:gwnAaI7nXWFcRukS-9tj-FnIJadWVxs0hexkuR8m-L0vD0R4k6xFKg>
    <xmx:gwnAaH1zJsR1wpscZDSWHxdBD36BG6JYEy63ac4gU2l4CmFkUo0LuQ>
    <xmx:gwnAaJy7zuTY3lCXj2XayN3W5AuLOlfh-7rS5jUtTSbZI9dwKaob5w>
    <xmx:gwnAaAbDRnTtu05e38L9_PM_Tu7nz76Ym0C_w4CaJORFmu_Q81CW4CGH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Sep 2025 07:03:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 868e7428 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 9 Sep 2025 11:03:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 09 Sep 2025 13:03:07 +0200
Subject: [PATCH v4 08/15] packfile: refactor `prepare_packed_git()` to work
 on packfile store
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-b4-pks-packfiles-store-v4-8-151c4ba3619f@pks.im>
References: <20250909-b4-pks-packfiles-store-v4-0-151c4ba3619f@pks.im>
In-Reply-To: <20250909-b4-pks-packfiles-store-v4-0-151c4ba3619f@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
 Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

The `prepare_packed_git()` function and its friends are responsible for
loading packfiles as well as the multi-pack index for a given object
database. Refactor these functions to accept a packfile store instead of
a repository to clarify their scope.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 packfile.c | 41 ++++++++++++++++++-----------------------
 1 file changed, 18 insertions(+), 23 deletions(-)

diff --git a/packfile.c b/packfile.c
index 59bc02575f..87bd8c7864 100644
--- a/packfile.c
+++ b/packfile.c
@@ -974,37 +974,32 @@ static int sort_pack(const struct packed_git *a, const struct packed_git *b)
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
+	odb_prepare_alternates(store->odb);
+	for (source = store->odb->sources; source; source = source->next) {
 		prepare_multi_pack_index_one(source);
 		prepare_packed_git_one(source);
 	}
-	rearrange_packed_git(r);
+	sort_packs(&store->packs, sort_pack);
 
-	prepare_packed_git_mru(r);
-	r->objects->packfiles->initialized = true;
+	packfile_store_prepare_mru(store);
+	store->initialized = true;
 }
 
 void reprepare_packed_git(struct repository *r)
@@ -1027,25 +1022,25 @@ void reprepare_packed_git(struct repository *r)
 
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
@@ -1060,7 +1055,7 @@ struct packed_git *get_all_packs(struct repository *r)
 
 struct list_head *get_packed_git_mru(struct repository *r)
 {
-	prepare_packed_git(r);
+	packfile_store_prepare(r->objects->packfiles);
 	return &r->objects->packfiles->mru;
 }
 
@@ -1078,7 +1073,7 @@ unsigned long repo_approximate_object_count(struct repository *r)
 		unsigned long count = 0;
 		struct packed_git *p;
 
-		prepare_packed_git(r);
+		packfile_store_prepare(r->objects->packfiles);
 
 		for (source = r->objects->sources; source; source = source->next) {
 			struct multi_pack_index *m = get_multi_pack_index(source);
@@ -2068,7 +2063,7 @@ int find_pack_entry(struct repository *r, const struct object_id *oid, struct pa
 {
 	struct list_head *pos;
 
-	prepare_packed_git(r);
+	packfile_store_prepare(r->objects->packfiles);
 
 	for (struct odb_source *source = r->objects->sources; source; source = source->next)
 		if (source->midx && fill_midx_entry(source->midx, oid, e))

-- 
2.51.0.450.g87641ccf93.dirty

