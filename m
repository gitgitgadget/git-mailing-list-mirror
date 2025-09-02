Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD672F530E
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 10:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756810142; cv=none; b=qs1kFnnxihBLgRwBltjyEqssbuQubJ+hC7KH7UoK/aR8fUWSvKbE32B6ZJRF6hApQdxMqcqXtrvj4189lVaTKN4ZBoh0C1sq9/TMM/tUAZX0N9rdSMmDq2P4qIYOe/YCOb/33dywmJ5RqLXfdGChTIt/kAneEczV2kYQIivVIro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756810142; c=relaxed/simple;
	bh=YDwzC4jaDrJfsj81AFdIE4DkmlMYHmX4dRHmj3R1Lh0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mu4ckVcaQCdmtVynRkDbVZA52Hk8EQ6ToA4zZe/2oAgD3MTtkKIJg6CzIlv1UDE4YuQE9znkl8cXF1WicNvs9xSxdiwyNsTb4SztuZx9nXxun2fN52j4H05l36yAlrdyfX+eu/b1Cr7OS5zv13ir4aWOQlO8855iF6ohF07Oh9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=p0ToVEbd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=imt/VzcM; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="p0ToVEbd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="imt/VzcM"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 6FC1AEC047F;
	Tue,  2 Sep 2025 06:48:59 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 02 Sep 2025 06:48:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756810139;
	 x=1756896539; bh=VO6yaCZ2e3nNttsqzINp4hhHmhqIvP1W4pjggyejZYQ=; b=
	p0ToVEbdepoc3QfPvqvPEe7QpHNBgYPDExZsC6qOGTBVv17rmSZR5GaxiXb8ehLw
	N8/iusSsDR1awwoeUjS7N5QK3EPldAPmjN8b1FTlV4P79ZNu7rWWiO8nRDZ9yCSe
	iJZZpIyc8kE0rXE/mbU7L2nWFFWVBRpFlPCe7i9gr4SNkHS4MOgVD+Nx1uq0LFso
	mge9K02KPnUMOezpbZNVA9SPbEK2MjafPAJuEf2BE5+cQJ5JPEZBLV9PZiIZFLXD
	bKT3LrgNveoGgI65lFw8W4S8ymAUkzmlWhc0Bo4epSH8U1I8shBNGhqUV+xGNkGC
	ICrjpHh79JkJm1EpiufCRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756810139; x=
	1756896539; bh=VO6yaCZ2e3nNttsqzINp4hhHmhqIvP1W4pjggyejZYQ=; b=i
	mt/VzcM6luR+6fY09CFjVjKTmF7vkHr7tD4i/jrPZGpeHW/UO7TFQVWqjtLmq7VY
	VlecCPdVRyaluws+0mYltup6TkYt0EvZJSM6h7Et+5xsUaDxtbfD78UJUVJhleNg
	EW8W0W3QrPnunKzxUFVY+2s4o+Pvy2H6+WSwlnHEJU96WVjOZwoHkY2BlLaS7aKu
	B/YlkvISol6iPtAedSIHsZAQ1dZO1adVj8CmSAyxiDTKYch95dMuvvz4m30lRNU9
	Jy7SyLOhYMb5RVrmdQLbNWDlmhcSiL18v8JTdx5J6Cgj4QQ0Wk7BiUsExpknMa0w
	BZoRB9ztGkgbu+Awummqg==
X-ME-Sender: <xms:m8u2aCj3oc3flhmYFAZd4hs4tE8Hkiq87Tklb55XwI2pwPy1ThYarw>
    <xme:m8u2aOi-9j2So6hPbiKPpu614KM82gnjjGniu9CGlZmTIvIteT13cnV_J4QXDF_X1
    m8WoHyWEYBt1wNTMw>
X-ME-Received: <xmr:m8u2aAjjFMXE636IXcUSYwiyjPuz85oWhnD2MmZa1B3eq7FT3RchiC6-kACeAMkc37GOM3l4jBbb7hLXtYlwDxgDHXHsLjaZS6WKeQbeOV8Gfg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddtiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    fhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepff
    euiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehl
    uhhsthgvrhfuihiivgepgeenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdr
    tghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepmhgvse
    htthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:m8u2aGKXUx4aXg3fvw5MKhxYQ5hDHWJIW9WPx9G2u-yPVoDVJCUwCw>
    <xmx:m8u2aHHa7ZGqgVfgS5vNhzTsjTWbROT1rtEweLTnxueSP8ZOvcnIgQ>
    <xmx:m8u2aCTQ7IgJqTF2tQyqUwL4_WnAEJeJ33fPPi-zVNU-SLCQKkNmzA>
    <xmx:m8u2aLc4diCspS3HQPL5x3xSuV6dD5DfIRRhMjdg89UvGoKvCjYXFQ>
    <xmx:m8u2aJcVGK-dzFD9CZQYGMPoN8CUoAhPzTBpcOmZPWflQXI2NGzAM3CK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Sep 2025 06:48:58 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4ea683cb (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 2 Sep 2025 10:48:57 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 02 Sep 2025 12:48:30 +0200
Subject: [PATCH v3 05/15] odb: move MRU list of packfiles into `struct
 packfile_store`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-b4-pks-packfiles-store-v3-5-6925278efeda@pks.im>
References: <20250902-b4-pks-packfiles-store-v3-0-6925278efeda@pks.im>
In-Reply-To: <20250902-b4-pks-packfiles-store-v3-0-6925278efeda@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
 Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
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
index e96970efbf..91c7b3917d 100644
--- a/midx.c
+++ b/midx.c
@@ -468,7 +468,7 @@ int prepare_midx_pack(struct multi_pack_index *m,
 				   m->source->local);
 		if (p) {
 			install_packed_git(r, p);
-			list_add_tail(&p->mru, &r->objects->packed_git_mru);
+			list_add_tail(&p->mru, &r->objects->packfiles->mru);
 		}
 	}
 
diff --git a/odb.c b/odb.c
index 737d98c911..32e982bf0b 100644
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
 	o->packfiles = NULL;
diff --git a/odb.h b/odb.h
index 73a669b993..8ee1f8bb43 100644
--- a/odb.h
+++ b/odb.h
@@ -3,7 +3,6 @@
 
 #include "hashmap.h"
 #include "object.h"
-#include "list.h"
 #include "oidset.h"
 #include "oidmap.h"
 #include "string-list.h"
@@ -138,9 +137,6 @@ struct object_database {
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
index 60ccdfaafb..98207aa380 100644
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
@@ -1095,7 +1095,7 @@ struct packed_git *get_all_packs(struct repository *r)
 struct list_head *get_packed_git_mru(struct repository *r)
 {
 	prepare_packed_git(r);
-	return &r->objects->packed_git_mru;
+	return &r->objects->packfiles->mru;
 }
 
 unsigned long unpack_object_header_buffer(const unsigned char *buf,
@@ -2078,10 +2078,10 @@ int find_pack_entry(struct repository *r, const struct object_id *oid, struct pa
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
@@ -2347,6 +2347,7 @@ struct packfile_store *packfile_store_new(struct object_database *odb)
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
2.51.0.384.g4c02a37b29.dirty

