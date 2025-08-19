Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECC031194A
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 08:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755591593; cv=none; b=F0J71LvWgdcj14HkRZ8kb031a/09vPUMg4V8Zu1HElRes0RCmfPAEqNt2+Z6c8m7HK2HA2UY8HxmylgxAkP5MrNHTxaIdHOaLx3hSjJ29ZuEPVu6hCmzoKtORmQZlaco5Ji/9YmuqtyNgXLLH0Q8hL2qeeZ27UpI4bS9m9c3QOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755591593; c=relaxed/simple;
	bh=o+z0pBRH8h995otYVA/SPbUQdOA1avGC8Gm37M2EB98=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MiBIb0vljP7oKayJvnw9UyTFRE9v4w4WuWBQXXTandHTwhwOomgkzU5wx7aU3Ms42dTlVmphjcjklKnIVR4jVsoDWn4vFmOCJkkdaZ+Zn0JH/vedIU1L5ynlq6DwJpvHMMptn8J9cxHz3Br85xsyGipRYfyLBTyeTJqZXuqpESo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=btQgu8dq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MC6DV8Nh; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="btQgu8dq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MC6DV8Nh"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 79E8F1D00266
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 04:19:51 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 19 Aug 2025 04:19:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755591591;
	 x=1755677991; bh=AesHdV3JVW6VCjUoHUdni4kyS8U7HS+vEJTJE2RD0io=; b=
	btQgu8dqluK5gTA5K7KaLRsKkCJpcTt25ax7ouLeKRAi6bus9fi6lAuF4cQc5PgS
	p6jiEyWfy2pZZSZwSACJEhB93LCnw1yFWj+aubCSDWmijVyFDv4mrILErQIA76EA
	dZXJcO01QrHYliObl365lHG2lKeONBRtvyte7gkLlJtOw73oBCZMfNrI1w3hVEiq
	d6Zi0oDdcBFAJKZXuaKBsBA1dESHSKZZ0VEWDdcdR7NxrzMSkYvVODV0GukNg7Hg
	GC1IgWUNSrYatYZ08ipOK2MzL7xH8RMsj+QwxVBCSsPQbI17DzMwhcMEjPI8lnWv
	NYhFXF2kXRoTFDGidDO6UQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755591591; x=
	1755677991; bh=AesHdV3JVW6VCjUoHUdni4kyS8U7HS+vEJTJE2RD0io=; b=M
	C6DV8NhCM6D7oIPijMSD4k2sPc3+BWXUjtZ/iAaobxCMyDXL7vbKqGry57bhzfYr
	SQTubO6/ZgpMG5er7HgYPnEAgB0SRGdAU7FxpWNORMHRuHmGf/h9ZHXpek5gC+Cd
	FgqrYa7dc02TO8ErY9RWSMPXkln5fIKSpWq9S/Y1uXjGtPz1Ig3wLKRsji3+sIXF
	xTHXSL2sDZnzBtkxZ2//+mircot07q8qiftGCzBsYHwwKO7EXBbGOrX7s0DcPKHz
	fYk1rGLZD2kQ9KORxpBY2GkzG96ctIjLoailI2YanINebHOWokMPTCh+mlVZkLfi
	Tc3IScNyaYmB8LY+/Iobg==
X-ME-Sender: <xms:pzOkaCIdCkvScpklBOGsOTegYump7T3FigKheiDwCpWx8EqmCj0gag>
    <xme:pzOkaMJe9dx8uOlyV2DM_aEHxbgZoNo4jGSJfV_ewWnZWTonqY1bDIsxCO6xa1v5c
    0rEPkeqA8wKorQ68Q>
X-ME-Received: <xmr:pzOkaMEl6YZtje11nxcDT5kdsiVXHjsfSDrezO_pHEUgh11kfEZ31XPogkYSZiScQsXZ3vjl1-3lNVoS00fT4IU86AOo66CHAKfOeW8ea_E8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheegleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:pzOkaJluQbbZ0iLZPocYGzM1Whj9BEuO3HaLJfkBvdny9aGlyI8T6w>
    <xmx:pzOkaBJ68McdB8fd_Ii6NZy7ORyXeyLPlLBbUxxf8TMK8BuBGbpNvg>
    <xmx:pzOkaCYvp2JyDFLT0KfdXkecVBDTLapx9wBv8hbwh96Dd5t5pBFgOQ>
    <xmx:pzOkaLbWJnmcOsB98IfXK8p4KWKIhYaXbcfaHeYdMC2uz2Xd3cP8FQ>
    <xmx:pzOkaMhr-Riq0WLQ0PCwI2GMyVUwchcdQQI7I0TFh1jxmJ6jyK8SsxUf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 19 Aug 2025 04:19:50 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fd60e7bc (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Tue, 19 Aug 2025 08:19:49 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 19 Aug 2025 10:19:34 +0200
Subject: [PATCH 05/16] odb: move MRU list of packfiles into `struct
 packfile_store`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-b4-pks-packfiles-store-v1-5-1660842e125a@pks.im>
References: <20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im>
In-Reply-To: <20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im>
To: git@vger.kernel.org
Cc: 
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
index 99c1ba7b77..2dc3bdc79d 100644
--- a/odb.h
+++ b/odb.h
@@ -3,7 +3,6 @@
 
 #include "hashmap.h"
 #include "object.h"
-#include "list.h"
 #include "oidset.h"
 #include "oidmap.h"
 #include "string-list.h"
@@ -131,9 +130,6 @@ struct object_database {
 	 */
 	struct packfile_store *packfiles;
 
-	/* A most-recently-used ordered version of the packed_git list. */
-	struct list_head packed_git_mru;
-
 	struct {
 		struct packed_git **packs;
 		unsigned flags;
diff --git a/packfile.c b/packfile.c
index 6582b0a479..f82856c19e 100644
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
index 2f84d7d7e6..3022f3a19e 100644
--- a/packfile.h
+++ b/packfile.h
@@ -65,6 +65,9 @@ struct packfile_store {
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

