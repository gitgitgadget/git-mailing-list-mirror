Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898B132039C
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 11:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757415804; cv=none; b=kyJjpyMPFC+wWOx1kN1vzp+Vbofey6MSJ7vF7NJrsPpfRYOKI8o3HQ0r2WsDuuoE+WsoLRFWGt4hGfG/Nw4YCpZQlSb3Qw6GA6droliQ3TW7dAuoDX2wyJT5iUWnIE3jxGRSkodnd7jxg01MVIW/t72nfwrOp25yLRTYUsBhBa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757415804; c=relaxed/simple;
	bh=/4cRCuyEZ+p/fNsKZVm1Mk4KRhDOyH2yDpMD82gR4qc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tQ8m1f1iTLnyT965Fd6QLh6cJuFrT/ZLTOeEdFMhf85g2i0JJuj5X7TQjEAvBgHer2rl0IL6uFFsCayNqXRWPZrvgVuFfmjS/gG0H7UQ5wkdf+zb/shHTUqpplMX4bZBXl5BxL3AtFIkU8WBuwmDjiQHdJzglSL+HULBCuAL6xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tlYEnan8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kOD5ooy8; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tlYEnan8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kOD5ooy8"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 92A97EC0F47;
	Tue,  9 Sep 2025 07:03:21 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 09 Sep 2025 07:03:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757415801;
	 x=1757502201; bh=xcVKi7P9CPFOmFnsJ1sNnAt6HFywRVRvZ5M7SnX2Wt8=; b=
	tlYEnan8JX0Q6CZVbJKv0Zg/IOYAR/HX+r4Fyjv+S3rboFJ3KlC+zsAA6NcR97kU
	YS2p8SuWDdOE5hZsdOtcMkjy6ut1xCirPHAwRrzqzcX4E9FW4McJY8Cof68k24/r
	jrDI6UuAkEgrj7kI9IPNDEXOXAPGCSxaukR30145EjtE7hUos9Lb3y8Orss4mzOK
	6lGssgaAOTa4nRNXCaaT9c9Ru411GH3ptwMmSgbHBBd2mcJ8erckF+/sywAxbTbA
	qS807kXKr2vjm7rqgAVeXyjfXrW7wQ7OHXa350DwHUkdW1ckmAisUzFVM914Eo4G
	a7Y25UacV21l+KYj88e16Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757415801; x=
	1757502201; bh=xcVKi7P9CPFOmFnsJ1sNnAt6HFywRVRvZ5M7SnX2Wt8=; b=k
	OD5ooy8z2wm7Hhq6O2ROsYIUZT36Sq6PKEK99Vpeutpj7ObPYqNuSR24bo1fNIPb
	ZIEBcIz3zeDtrkbR9n5dundC9nE29UIb69oT/cxlmPDHQouq1+uz0pfI2r3JQbnE
	Sckc1KPzNDeC629PfIWmvQNAaCU/ktJxuZM6CeqbUaG1meWG06khEUORNAcnP8KA
	cHk6GLvexB97f+sec9Gk64DgnRdWQq1yD1nPxL7mrdYnxauN4dKn3DxH0LXfsjYZ
	HymCzsE9io+eIx7csscuShIPU3/p9b/JPJg00lkLXXUH83vit+rTCdl0TYBZ4jXM
	05aJ/r68caFi4BVxiyATQ==
X-ME-Sender: <xms:eQnAaH0rK9-LvjQ2mwmrQOnSDJkpNc8eSPRiAaKNFFn-I8TjSSl16Q>
    <xme:eQnAaBllwu6Enm3Eo3ddjqh0iXHW9qw_2UC-9bHYMuocSp212juClLkvbc25an_fB
    0SLXwU6vMvDrbAyxQ>
X-ME-Received: <xmr:eQnAaOWrRrb20EQLB79P4G4z2S0C-3tM5Ro_IB4RvScQoE68c-8F4N_kp1znkYkTgTi4rCfJcf1QcBVGE8n5v3pDc3y7JAhQe4vuF9RG0VU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrdduke
    eksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoh
    epphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:eQnAaHuruFzFMbSo_Owzg9V5UZhK2vwCv_ENm-WV6FGuc6ObPdyV8g>
    <xmx:eQnAaBbfESgp7ygfcaxo7SI_z5EnwZ15bEb-EnpMdCnMsXLvAxDROA>
    <xmx:eQnAaGUIizA-epqQXfVVh3pnTAbeS99aIGi3Y2RUgS7Axydrxw1NOg>
    <xmx:eQnAaGSSSt8UAdOWGF6hU0Rk2f78_SBawWu41Spm_3-hosxHqtk6uw>
    <xmx:eQnAaK5TEFqUA0ta09FKnVB0OKLN_j64pVnbM1vDOLJ_9BkrJaDmhrB3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Sep 2025 07:03:20 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e8447541 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 9 Sep 2025 11:03:20 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 09 Sep 2025 13:03:04 +0200
Subject: [PATCH v4 05/15] odb: move MRU list of packfiles into `struct
 packfile_store`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-b4-pks-packfiles-store-v4-5-151c4ba3619f@pks.im>
References: <20250909-b4-pks-packfiles-store-v4-0-151c4ba3619f@pks.im>
In-Reply-To: <20250909-b4-pks-packfiles-store-v4-0-151c4ba3619f@pks.im>
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
index 9006a9ea67..b0bfe62b5d 100644
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

