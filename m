Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2F12F361C
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 08:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757926486; cv=none; b=bkcygbdrXwRi2rgqQB8YmNz0FXrkhtp0LhZpu4eBVTxkF6cyJ0K/3IbIXCN8YiXUQckwFTHWFw9CZu+sCwYp51rCZqEUAIuqJqweyrEr/Pmns/wUvPJRU2FUXN+bl7DiiPdjF8tomet5nrrgDe5IMLix+bsxWPtFKd4JvoFhaCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757926486; c=relaxed/simple;
	bh=Hjz4/AiSA9qP7mzaPPMq07MItjg6HgKnkYOUJl/movI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bkFkJomnb4cg2MWpHgmLCeOEgRNPo7VgSDerRu/8uzPcII7zOEJ1Nw0n/ujhVPb0rz+THiPLQVYhTJphxvrtRqK8WOWkGJHYHO5NxpHQQnvOt2+eXJz+8XFBrikZtrNeLHE9E+zOmZkAdhE0aIQkSHXgOUYzfZonfEaMxEjTrJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oXn4mK7N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QLgxWpSy; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oXn4mK7N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QLgxWpSy"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 14D13140019C;
	Mon, 15 Sep 2025 04:54:44 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 15 Sep 2025 04:54:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757926484;
	 x=1758012884; bh=FQ/npMjpqDQVhET/bqEx3PcmNMGbfYcNbivuEpwenCM=; b=
	oXn4mK7NlKMbe4ckWMiHyF4/5ySb+r0xTeJWIsFCgjC77l+9BH7Spe+deinug/tc
	/tgR6T4apIybknZpFzwAKSAIb0joGV8IBQJZ800n5Fe4U3tjMdVfjdP8kVe8Mqoh
	f6HaLkxPg4lo42dmDQPpBbLke7Cehf/sHAgvw1NTmw1XwvXl5K4IqqOHNADwlay3
	AamFkuMw/QeTPlm3tt/DDvzk8oSvZcMn90389i2CaIbCvXZ+Bm7B2QDNWpeW7EBf
	aPwXBzmEQCUAFh28kStkRBwzhZLx0HHVe7XKzYKvms9D6Qf9TdK5+9hfmPCF5iSR
	EBHvHgSXEchvsaY25728Pg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757926484; x=
	1758012884; bh=FQ/npMjpqDQVhET/bqEx3PcmNMGbfYcNbivuEpwenCM=; b=Q
	LgxWpSyEr4P8HI+sK5+JyQP3fM/7k4T14vXF260pLzNrCwcTnADnOJJ2e7jdsuDk
	w/5WGx2Lf1xRGjxCmhSpXRPAerZUSkspkEm72im9idL6TeqOLal9c77lY3W67hzF
	3fpSP5NSq4pDvKdki28/KhsXS31a677P+rSBTXCx3qU96vZsdaNMjFx5w49ahejE
	W4zNbYlPP6fT5T+3YTqY7oISwpSdUuXia8qwGNK6dTJkoOFSlHTOOuND2dfS/abG
	32tA7HuBsXFc8YIwqCR+YtRDsulGQ5Q1yF0Cf2pb5lSl9EccGJ4qRbnc1eSk3RWA
	2FBJ3DbXyz8Wfxjgsaa7g==
X-ME-Sender: <xms:U9THaKue2LyoWyjdAtlv9vto8_fDa7kvmNTy259uHi5tuhIRLdaldQ>
    <xme:U9THaK_DfzmENgZi0oRcRFpMuaFzur3uHI1nIk2LWAeWY8cbKi1hhVDGfRc-nTJDW
    TeFh4G2NjRx07gbUA>
X-ME-Received: <xmr:U9THaMO1KvJroO55EQVrt6F7RFTQouoMYT1Yk6CEFPXVr6hNgq-yL6UxLTQL0Rc9MUaGG9ZVsyRmw3rLgyXCSyciBiU9mCMsF6r0yh2uTY4Wrg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefjedviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvgesthhtrg
    ihlhhorhhrrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:U9THaAFTVlo_J1s7-HITi_mZI12sjFM4_mdIB9SWF44T0wrcicuStQ>
    <xmx:U9THaCSXPGzLrMmYhvS4CxwXGIt4Zdmt96wJRldFWB6RtcFph1CK8w>
    <xmx:U9THaFv6_2ij6Io9YqVpxgxS4iM8abjU8_Nhb3d8PRsa4bUoL63CMQ>
    <xmx:U9THaCKcQF3hglfI_cq_Zqag744TnsfNjgxk7GZql0Al-w0GniQzzg>
    <xmx:VNTHaDTn5-wezy9nlYQj3Nh7JKxpdZPsjXF_fNp9JA4i18xGFwwaqgQI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 04:54:43 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d23f332d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 15 Sep 2025 08:54:42 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 15 Sep 2025 10:54:23 +0200
Subject: [PATCH v5 05/15] odb: move MRU list of packfiles into `struct
 packfile_store`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-b4-pks-packfiles-store-v5-5-d6340350934f@pks.im>
References: <20250915-b4-pks-packfiles-store-v5-0-d6340350934f@pks.im>
In-Reply-To: <20250915-b4-pks-packfiles-store-v5-0-d6340350934f@pks.im>
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
index 17e0b8ab27..861d7ffd6f 100644
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
2.51.0.450.g87641ccf93.dirty

