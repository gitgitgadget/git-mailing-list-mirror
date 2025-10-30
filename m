Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A5233B955
	for <git@vger.kernel.org>; Thu, 30 Oct 2025 10:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761820732; cv=none; b=rd5cyWd01R11JnmPahgiejxOkLrKZ2r5v4/LYXDywkgnNATKAfcJp+LOma1e+1E7qhWYaXCzqVZFHtCokLf2YVAwn0y38ElEzZlsz8jnFDQkCvat592hC7vykBctQy2eDe0p9z67gL0FzmZqRRRTROEJ9j5J2+Rd2Qf33NgsCRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761820732; c=relaxed/simple;
	bh=xT4T2gbB7bP8OncISphtiFZ/HsyPQyb7tK6h1AcZvtk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UK14gFQZe7N54FWa1U4AcCj6r/sIyIW7YIY9KzFEJja5Mc36igrA9b/Id4+11jn6rZZTEnG5eDkgy4z91z5YPVknCd6hsKs64x27mU8qT7cOqunt6HXAi2zbELq4bzF23KIJ7L6198RF5KMokCIrA0pIxHYebPa+GZLP9DQGNco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KXIkzPSe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ajwH3jS4; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KXIkzPSe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ajwH3jS4"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 299D814000FA;
	Thu, 30 Oct 2025 06:38:49 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Thu, 30 Oct 2025 06:38:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1761820729;
	 x=1761907129; bh=c9Z/ODrIpzvlHZi+RBDndmKDwnhq54VJzhMqHq+a7JM=; b=
	KXIkzPSeeQp/lrYwfp5fI8E2fElxXdhGGl5KUGs1v3euBCTawzD/gnPRsqJn3O8u
	iJ3iDx9Gsys3kNK2Y1LkKfbyVisZlCaFRNIWmLTKHgaMsGR66TS3kQlTJEBIm0cD
	z3MbRAGhCDlEewsjwWKMruHfeWnClCrcZq+JAydhM+HTxM0y67aP/MfCaSmKT3I+
	7cZ6Oes2Rkgj0zNb2BtN7BlfMaMwhD6In9HY2UwxvzxrxdL5twry/ybC4/lRCZ87
	9vm9K3hfFpTa4GgVgEGML6emJ2VM2+h490hJ6Am9xpOk+KAkki38ChcemkeT+k/k
	eKZRvSxDNRuphdR4M0mLYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761820729; x=
	1761907129; bh=c9Z/ODrIpzvlHZi+RBDndmKDwnhq54VJzhMqHq+a7JM=; b=a
	jwH3jS413wW47pbSu67ndFZBdRLHDBECbZ/2qig6L9JC45YQzH+iPHsO4V3ereNM
	bjzeG7IyJbscbdMBQYEsNS3gg1M5pbdjP3ghgIZ+g8G9CpTdXi9LDTXTZxChXhaF
	0GOcKDfzyZt3GNLR28INbkhiHo1Fl0X5ykntRlu9wrcRYHWV4BT2Vm+aUfsmdvmA
	Xnvg16gl6vaJ8cbnCagAsXVyTBtfQl/KP1gBptCEXD6rV/N6ZCKbgYZTati6MzAo
	7fadTwbJn9ZJlt8M2ITV4M0rP3hYn0do6+4npakHlhlnWAkzAKC850cXbj4DcuRH
	4F9k5TDjJW/lSMVw5y5Yg==
X-ME-Sender: <xms:OEADaQDZ4W3yQNW7Kx-fZfNQlKCY6BqpyDJBS5GgfG1IxkZmWe6uvg>
    <xme:OEADaZglTiGf743ef8Lb7cLaUBYeyslcINAHuMeR0u6_A58YC5_Ys_GQ-ifdRmJt8
    DOnlFZkoKrF22l3nF8YHHchjLjoNIMBjruPmpCLbS93WtBcKLi_1w>
X-ME-Received: <xmr:OEADaYmfFkrzdS6Klex2FWqqu1Ka_Ew9LwX3aIR0WHDtXg3r6Vhv31LkKbBw1ouuMZssEiV3AxBUI-tOu7o-eu-xWVZJDDWTQFtPS9pw2w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieeifeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrh
    drtghomhdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:OEADaVoRY5gisDoA76igGFAQnhk467eHqXog4_4IZez6kM93GvyasQ>
    <xmx:OEADaRF1_ptwLt3ovmhko7xFHceQWXpK11Df_foRzS7CUzcNyO_GrA>
    <xmx:OEADaRxsxwDO0M44tgPBI2Ls7B4rA1DGQ-r48Ml9Qdj6f1gyXX41Bw>
    <xmx:OEADaWpDxflXc8bntjOhGrXPq5CeWyAHsMaqYwgDCAtJ7GbTGyVuRg>
    <xmx:OUADaQErQOAuO52OBqlvutW2ynFoXCINN5LoJquZyxFEfY0SWIeK01m6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Oct 2025 06:38:47 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 52e596f8 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 30 Oct 2025 10:38:46 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 30 Oct 2025 11:38:38 +0100
Subject: [PATCH v2 1/8] packfile: use a `strmap` to store packs by name
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-pks-packfiles-store-drop-list-v2-1-84654f080cc0@pks.im>
References: <20251030-pks-packfiles-store-drop-list-v2-0-84654f080cc0@pks.im>
In-Reply-To: <20251030-pks-packfiles-store-drop-list-v2-0-84654f080cc0@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>, 
 Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.3

To allow fast lookups of a packfile by name we use a hashmap that has
the packfile name as key and the pack itself as value. But while this is
the perfect use case for a `strmap`, we instead use `struct hashmap` and
store the hashmap entry in the packfile itself.

Simplify the code by using a `strmap` instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 packfile.c | 24 ++++--------------------
 packfile.h |  4 ++--
 2 files changed, 6 insertions(+), 22 deletions(-)

diff --git a/packfile.c b/packfile.c
index 1ae2b2fe1ed..04649e52920 100644
--- a/packfile.c
+++ b/packfile.c
@@ -788,8 +788,7 @@ void packfile_store_add_pack(struct packfile_store *store,
 	pack->next = store->packs;
 	store->packs = pack;
 
-	hashmap_entry_init(&pack->packmap_ent, strhash(pack->pack_name));
-	hashmap_add(&store->map, &pack->packmap_ent);
+	strmap_put(&store->packs_by_path, pack->pack_name, pack);
 }
 
 struct packed_git *packfile_store_load_pack(struct packfile_store *store,
@@ -806,8 +805,7 @@ struct packed_git *packfile_store_load_pack(struct packfile_store *store,
 	strbuf_strip_suffix(&key, ".idx");
 	strbuf_addstr(&key, ".pack");
 
-	p = hashmap_get_entry_from_hash(&store->map, strhash(key.buf), key.buf,
-					struct packed_git, packmap_ent);
+	p = strmap_get(&store->packs_by_path, key.buf);
 	if (!p) {
 		p = add_packed_git(store->odb->repo, idx_path,
 				   strlen(idx_path), local);
@@ -2311,27 +2309,13 @@ int parse_pack_header_option(const char *in, unsigned char *out, unsigned int *l
 	return 0;
 }
 
-static int pack_map_entry_cmp(const void *cmp_data UNUSED,
-			      const struct hashmap_entry *entry,
-			      const struct hashmap_entry *entry2,
-			      const void *keydata)
-{
-	const char *key = keydata;
-	const struct packed_git *pg1, *pg2;
-
-	pg1 = container_of(entry, const struct packed_git, packmap_ent);
-	pg2 = container_of(entry2, const struct packed_git, packmap_ent);
-
-	return strcmp(pg1->pack_name, key ? key : pg2->pack_name);
-}
-
 struct packfile_store *packfile_store_new(struct object_database *odb)
 {
 	struct packfile_store *store;
 	CALLOC_ARRAY(store, 1);
 	store->odb = odb;
 	INIT_LIST_HEAD(&store->mru);
-	hashmap_init(&store->map, pack_map_entry_cmp, NULL, 0);
+	strmap_init(&store->packs_by_path);
 	return store;
 }
 
@@ -2341,7 +2325,7 @@ void packfile_store_free(struct packfile_store *store)
 		next = p->next;
 		free(p);
 	}
-	hashmap_clear(&store->map);
+	strmap_clear(&store->packs_by_path, 0);
 	free(store);
 }
 
diff --git a/packfile.h b/packfile.h
index c9d0b93446b..9da7f14317b 100644
--- a/packfile.h
+++ b/packfile.h
@@ -5,12 +5,12 @@
 #include "object.h"
 #include "odb.h"
 #include "oidset.h"
+#include "strmap.h"
 
 /* in odb.h */
 struct object_info;
 
 struct packed_git {
-	struct hashmap_entry packmap_ent;
 	struct packed_git *next;
 	struct list_head mru;
 	struct pack_window *windows;
@@ -85,7 +85,7 @@ struct packfile_store {
 	 * A map of packfile names to packed_git structs for tracking which
 	 * packs have been loaded already.
 	 */
-	struct hashmap map;
+	struct strmap packs_by_path;
 
 	/*
 	 * Whether packfiles have already been populated with this store's

-- 
2.51.2.997.g839fc31de9.dirty

