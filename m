Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC6E31B839
	for <git@vger.kernel.org>; Wed,  7 Jan 2026 13:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767791315; cv=none; b=JiRksWitVSBXYdHcySnrvhb7XkhSe4qKJ05axBGMx/Z9qmLTDBk7KxfZau3iDSVNjC+0P624bAAhpDL0Vrz+ATyMiGGqhRpi+upEmTzgacH/nr97TGBKiVCi95I2KdCC6Jc1Ijekf+Cur4LNPbm1YFOQfHjmvgxLqqKkOmECZZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767791315; c=relaxed/simple;
	bh=moscZ0Q1TmHAQUPQeoeRi0xRXhqrbitSUhWf9Pt5Ew4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mMeTOxjSe8/TFY/UcNhBbJagRqgklaLjNQuk8X+ReociTY4B2qi9aZP6Mh9oc59JFFdq/VFeLkSqp4VphP9+5RrRYPhAJP/bAF1BnfOL5/2PPvClZsQMo/gQv19aMahuFxYmh6GIM5BqE/y/Ocfefw73LXQ8DXrUoIPSh/oO+c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WHJrzXp5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Fo/xhUmg; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WHJrzXp5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Fo/xhUmg"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 15D0014000F8;
	Wed,  7 Jan 2026 08:08:33 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 07 Jan 2026 08:08:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767791313;
	 x=1767877713; bh=h3W6vINkkulSWrlzwVRsZih4o5eNBM4OoOPbcs6SjmY=; b=
	WHJrzXp5+r1RApmg5YfQN0b5LxlhSIEPwGJ/5/NWfFCUkuMPRkma7+UgqX4ltsn/
	lWjdW7RquKzzAcn1Npiqy8Xg/mTviOsM3n922sLJy4plZGrR9cZx4wtemK/HdFAZ
	M5r4npTM3tTvTCOScih1YQPy43oyTIth3Zzg6P9QLEx9MkcYLZhlVNwuiuGm62yE
	zkSX6Xmad2hxPWQJ4p6W/uTO0qiuFq8XpLByC0YGU3yi9TWgyqhJQNrfcvUcc/vr
	zoZzMW5bLc4P+5zOWiBJl0bzPFbloveIyzOBelTdfFcNdZ9RgpArcD8Hs4CAKRLq
	Tgp4RVktWPyPOdALyFkFUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767791313; x=
	1767877713; bh=h3W6vINkkulSWrlzwVRsZih4o5eNBM4OoOPbcs6SjmY=; b=F
	o/xhUmg3p98EdoeeZ5zOsgVvtnBUp+ntviEpWuBq0jqgfbbe7mVmvvWQmJSq1XXP
	dW0MLzuB54VTWQ+KnIm5yiJtN3qfIyiNyZyrFfwj6BOzgzVLA21xYtMCE8+3FCRC
	qRWQKFlBgHmVv7LdRI7FChwGds2gy5+6N4T9de9kPW41elYVCRg7AeojP2zPDQkZ
	r+AR+c+sHfYNvXRB02OA6ZgbuTCHiWPvqCmKVb4YAtuBx/+OVyssW8ROOkvPf/lb
	7iqzIEM082FCsCLuFldUZmR1HN/inCKV4Y7kUGboyQGn4yqywJFqscM2K2+wWNTE
	dif4aq4TlBGdwdjJNOiaQ==
X-ME-Sender: <xms:0VpeacpAlvZwbwaeQY1iasW8WngINK5WjunIdKGEz5VldkEbWq2s-g>
    <xme:0VpeaWVT2NnyxarG-IZ0yFdSbSJgjWJkjyOHonhxP2hUEQjDjiY_hqLKI1MtmdqAr
    Ub0ZOSAQslP0eLN7TFwY5YvmgjXEH41MK3vCWXT8dWX0FmhTMdTPQ>
X-ME-Received: <xmr:0VpeabCa59uRkCuD1lQ_kpQxcBm7NZrEL3sz6noA6FRNXg9noZr8KYOSTESzoauNR61XUPkFbhirRuhcaCBbXO_FNl7m2-56BUypwlJBqJM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdefudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpeegnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegrphhlrghtthhnvghrsehnvhhiughirgdrtghomhdprhgtphhtthhopehtohhonh
    esihhothgtlhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggr
    khhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeekse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:0Vpeaa1sxNR6hHPnXKfOqltSuJ15qPjB83L-CcxE2-Su2mHEkd-8AQ>
    <xmx:0Vpead2CN63jl3qr1lNehbtNcAHy_-g1S6UIoSCmPqhUnpixILjy_A>
    <xmx:0VpeafBkIXktEXPhFqsPFLGtMYJpWE_d2cfT9Cxwb7cZ4jR1_b9uiw>
    <xmx:0Vpeac4QMM_yJ0UH9z55slOjtHDR5p0KhyhfykcNU44hlGbZ6UL6Fw>
    <xmx:0VpeaeIuRjV29BaScA_PLdPIIUpn5NnLHlrU9lQj2XPgYuB061rD4FfW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Jan 2026 08:08:31 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c0150b19 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 7 Jan 2026 13:08:31 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 07 Jan 2026 14:08:06 +0100
Subject: [PATCH v4 7/7] packfile: drop repository parameter from
 `packed_object_info()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-b4-pks-odb-read-object-info-improvements-v4-7-b5d55c47082a@pks.im>
References: <20260107-b4-pks-odb-read-object-info-improvements-v4-0-b5d55c47082a@pks.im>
In-Reply-To: <20260107-b4-pks-odb-read-object-info-improvements-v4-0-b5d55c47082a@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Aaron Plattner <aplattner@nvidia.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Toon Claes <toon@iotcl.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

The function `packed_object_info()` takes a packfile and offset and
returns the object info for the corresponding object. Despite these two
parameters though it also takes a repository pointer. This is redundant
information though, as `struct packed_git` already has a repository
pointer that is always populated.

Drop the redundant parameter.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/cat-file.c     | 3 +--
 builtin/pack-objects.c | 4 ++--
 commit-graph.c         | 2 +-
 pack-bitmap.c          | 3 +--
 packfile.c             | 8 ++++----
 packfile.h             | 3 +--
 6 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 505ddaa12f..2ad712e9f8 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -487,8 +487,7 @@ static void batch_object_write(const char *obj_name,
 			data->info.sizep = &data->size;
 
 		if (pack)
-			ret = packed_object_info(the_repository, pack,
-						 offset, &data->info);
+			ret = packed_object_info(pack, offset, &data->info);
 		else
 			ret = odb_read_object_info_extended(the_repository->objects,
 							    &data->oid, &data->info,
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 1ce8d6ee21..85762f8c4f 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2411,7 +2411,7 @@ static void drop_reused_delta(struct object_entry *entry)
 
 	oi.sizep = &size;
 	oi.typep = &type;
-	if (packed_object_info(the_repository, IN_PACK(entry), entry->in_pack_offset, &oi) < 0) {
+	if (packed_object_info(IN_PACK(entry), entry->in_pack_offset, &oi) < 0) {
 		/*
 		 * We failed to get the info from this pack for some reason;
 		 * fall back to odb_read_object_info, which may find another copy.
@@ -3748,7 +3748,7 @@ static int add_object_entry_from_pack(const struct object_id *oid,
 		struct object_info oi = OBJECT_INFO_INIT;
 
 		oi.typep = &type;
-		if (packed_object_info(the_repository, p, ofs, &oi) < 0) {
+		if (packed_object_info(p, ofs, &oi) < 0) {
 			die(_("could not get type of object %s in pack %s"),
 			    oid_to_hex(oid), p->pack_name);
 		} else if (type == OBJ_COMMIT) {
diff --git a/commit-graph.c b/commit-graph.c
index 80be2ff2c3..f572670bd0 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1499,7 +1499,7 @@ static int add_packed_commits(const struct object_id *oid,
 		display_progress(ctx->progress, ++ctx->progress_done);
 
 	oi.typep = &type;
-	if (packed_object_info(ctx->r, pack, offset, &oi) < 0)
+	if (packed_object_info(pack, offset, &oi) < 0)
 		die(_("unable to get type of object %s"), oid_to_hex(oid));
 
 	if (type != OBJ_COMMIT)
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 8ca79725b1..972203f12b 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1876,8 +1876,7 @@ static unsigned long get_size_by_pos(struct bitmap_index *bitmap_git,
 			ofs = pack_pos_to_offset(pack, pos);
 		}
 
-		if (packed_object_info(bitmap_repo(bitmap_git), pack, ofs,
-				       &oi) < 0) {
+		if (packed_object_info(pack, ofs, &oi) < 0) {
 			struct object_id oid;
 			nth_bitmap_object_oid(bitmap_git, &oid,
 					      pack_pos_to_index(pack, pos));
diff --git a/packfile.c b/packfile.c
index a2ba237ce7..39899aec49 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1580,7 +1580,7 @@ static void add_delta_base_cache(struct packed_git *p, off_t base_offset,
 	hashmap_add(&delta_base_cache, &ent->ent);
 }
 
-int packed_object_info(struct repository *r, struct packed_git *p,
+int packed_object_info(struct packed_git *p,
 		       off_t obj_offset, struct object_info *oi)
 {
 	struct pack_window *w_curs = NULL;
@@ -1594,7 +1594,7 @@ int packed_object_info(struct repository *r, struct packed_git *p,
 	 * a "real" type later if the caller is interested.
 	 */
 	if (oi->contentp) {
-		*oi->contentp = cache_or_unpack_entry(r, p, obj_offset, oi->sizep,
+		*oi->contentp = cache_or_unpack_entry(p->repo, p, obj_offset, oi->sizep,
 						      &type);
 		if (!*oi->contentp)
 			type = OBJ_BAD;
@@ -1635,7 +1635,7 @@ int packed_object_info(struct repository *r, struct packed_git *p,
 
 	if (oi->typep) {
 		enum object_type ptot;
-		ptot = packed_to_object_type(r, p, obj_offset,
+		ptot = packed_to_object_type(p->repo, p, obj_offset,
 					     type, &w_curs, curpos);
 		if (oi->typep)
 			*oi->typep = ptot;
@@ -2170,7 +2170,7 @@ int packfile_store_read_object_info(struct packfile_store *store,
 	if (!oi)
 		return 0;
 
-	ret = packed_object_info(store->odb->repo, e.p, e.offset, oi);
+	ret = packed_object_info(e.p, e.offset, oi);
 	if (ret < 0) {
 		mark_bad_packed_object(e.p, oid);
 		return -1;
diff --git a/packfile.h b/packfile.h
index d7cce582af..33fed26362 100644
--- a/packfile.h
+++ b/packfile.h
@@ -382,8 +382,7 @@ extern int do_check_packed_object_crc;
  * Look up the object info for a specific offset in the packfile.
  * Returns zero on success, a negative error code otherwise.
  */
-int packed_object_info(struct repository *r,
-		       struct packed_git *pack,
+int packed_object_info(struct packed_git *pack,
 		       off_t offset, struct object_info *);
 
 void mark_bad_packed_object(struct packed_git *, const struct object_id *);

-- 
2.52.0.542.g9473a8513b.dirty

