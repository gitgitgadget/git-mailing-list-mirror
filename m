Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B88B3254A8
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 12:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782303572; cv=none; b=Vnh+Q0hMY2rflvguyP+bAsWItgixLEDRVkJh/69xKAVD4P8+FXWQR1lKuUA2NMYS/h6NVeGhU6AAb4itQNJrLsUFT/SW6kIRmZQWS0iYk76ddPIZHCSu99ZHG1ESwLYkdCjOkbbtcVoKfOdV0z9hDt0o86QzQeMyuEeYtxWtz78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782303572; c=relaxed/simple;
	bh=JWF3rag5ZlKzIPnVHNK515+6gfsF9Kb1g3weak2W6cI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oMM5B+A5qKYZsJuW+sV8VtEKK5jxvxjOY2RZYvlgYsN4QUeLYR92TW+WIltFgRXD3fMTTra8dhZXESYfArqgViRr+bWg1dcu/sVOpK4XwTx9ooz/V7usiEN/lPM+EEVRvNoRxZLY16xFT36MvKs6UeJMYACMaUoDXzOAlocpgAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IPeeLB9b; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J2BHXdqC; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IPeeLB9b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J2BHXdqC"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E79EC7A01E3
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 08:19:30 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 24 Jun 2026 08:19:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782303570;
	 x=1782389970; bh=+1J9M4kdwgxy2hkQnyHSuQh88Ccwy7DE+j9qA6QSFvE=; b=
	IPeeLB9b7xehtk4xxe1MbafcN0HzHIM2iUFnIas3MZQVuj6rOHHySH1/liQOuPln
	pKWzWCvfsb5UeefoEpJTf903G+VMU//fngbwFfamKBrU+EEaLacvFVhXvU2Pwpqv
	ctiaJvHsPP/R5Os9fQhQ8HgXXNM6aqOFE7yDr/j9sf4WFfeibcH2yFuTrUqIfvjy
	EeTBp7lnx4mF1KG4ut2MMmG2qrnsksWKoniDTSXm65nmqeXrAMK62bGY/wchc6sy
	YAecrr+spsDTXwl8Ql5gu14iCJVYX7CHpUeW8VoZfCu2GXJoJSsuNb4jaehJAnzi
	cABfO+fUWUoSCxPQz6Xnvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782303570; x=
	1782389970; bh=+1J9M4kdwgxy2hkQnyHSuQh88Ccwy7DE+j9qA6QSFvE=; b=J
	2BHXdqCcrQiTg2wb/RuE2tz9e5sM969IBJNr+qmUaFBCT6s/SlvmD9FLf2WGBzRh
	iXfWR2fY7M74iuZRbVzeRrhGPSGCALMYj2p0rRImyvAepyMQlN+7/wLxS4cWs92a
	SJX5uAxpZS+OKhvnJEk9wWXJdvwrBezcyACiULNyGBevBG49QKOZtfnQDcUCRrQv
	PyDo3zunobN4IyXIQ6HZYJdoCLlqWN00C03RLgYv+kaQU6PsFa9/MDecpL8kX23B
	HCKTOo501aaoiRaKIb8XNMn2v05jLGMHUSXhAv38n6W8kBFB+Crv2nBsFWNvSrkk
	dwqWbtdCDS4KAsQHSNfZg==
X-ME-Sender: <xms:Uss7aj6FfWJQeIGsk-cpYkob3RpWYc_jF3jOzIZ4vQdc3Ez0J6rPaQ>
    <xme:Uss7av2D7_Rg8WmBLOIaAOpdCq9cR0JsENg1sbCvK9ErOidEbWuVP97gBwYrXo0jd
    YoYU2jerIqEnO9w-TXEDyrPvp03JrSthihO7-9iTvhfzXBF2Yr9sA>
X-ME-Received: <xmr:Uss7agHs7gkWQVuYvU8j1Ip9F_PzgZZG5i3orBf01YEVQ_FUV4dQsT3GEdx4GJSe5HNobgcmXXjRvIbR64BtDkO_bZYBwSXNlk51MLP4>
X-ME-Proxy-Cause: dmFkZTFVh6D862S6VBqcmVEy3LZT7X9Dr9ZcbcC/r8onMxjGBYgXIw+F7qGLbxWtDokSKW
    36bwteS+dolUZGiHwhtiTXHExEhDcH+KBaBCil9fvQttZIR4sCOcDYkkT0XQGnpmcn00IW
    7NYKzieVn9HUx3sKMOsnU60EphryJUs+jHV19qp+IMhJIi0tvGM70CIdqutmp14uptQxRP
    8KzDOfcSer466MfnPRk0k5MUfMdL/nYXPsLQ5HMaS2mgW5VLpddw2xSvwepfJRkqn/IBoU
    4uYP1/q0QT79F7b07nXu1Sw4s78EKUcbnRz0dVpvzCrOY0BrG6BEHRnAihnrK4Tx37yOAD
    f7WQ694RFjbWZ5UCDiwOYTTfYoaXQSpj7zStAtCLlsjIRutPahHTED5Lc/LmxLU+JsTZ2I
    VSKM4uej6lTyOHpnIADH21iaVaHkGY/7X3FXxIN2R4YGml6GqUxhUbJEwuv9JLWe6kxROD
    dbkyYm0ng4f36auF7UwyDxVogeiOGU0V3l0cCY9R7HRBEcyO3h5LNOi4JxvN2VJWHPeDiG
    vzggA+GzdnYEzepcrUwi5Qb/emayZlIuCde9qHF5/+0lzkPlOkHGuj3fk5L6wGWSy2s1BT
    zXqc3xChILNfkjlb91pYdYA2EgX/lKY10b+u0dWWojGYjeP4zSeWFG+M4w4Q
X-ME-Proxy: <xmx:Uss7apTjJLrMYV_GV0JTLhp1MVhrAtVPnm6MF9eAAT9XjoZJ9yh67Q>
    <xmx:Uss7anDTwCvnvAuNvPnjvV3mh0QV_YJ11EDW9rUywiNMSMwlZxbh_Q>
    <xmx:Uss7ap2T-6sxaZiDu3Z72TzuRa6qfRFRcwqhkstpCfCALB9WFQnusw>
    <xmx:Uss7alXxd4qz8k3IcO5MkDHKLTJjKxrJhwMIfbDBJiYqR5RvV24jEA>
    <xmx:Uss7agZAKY5YhCnCoV_8ZvEhFtqDeZlMO6eTqDEorWaUXBUrj13hXTMJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 24 Jun 2026 08:19:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id adc782f9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 24 Jun 2026 12:19:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 24 Jun 2026 14:19:14 +0200
Subject: [PATCH 1/6] packfile: thread odb_source_packed through
 packed_object_info()
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260624-b4-pks-odb-drop-whence-v1-1-8d1877b790ac@pks.im>
References: <20260624-b4-pks-odb-drop-whence-v1-0-8d1877b790ac@pks.im>
In-Reply-To: <20260624-b4-pks-odb-drop-whence-v1-0-8d1877b790ac@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Add an optional `struct odb_source_packed *source` parameter to
`packed_object_info()` and `packed_object_info_with_index_pos()`. This
parameter is unused at this point in time, but it will be used in a
follow-up commit so that we can record the source of a specific object.

Note that callers in "odb/source-packed.c" pass the already-available
source, but all other callers pass `NULL` instead. This is fine though,
as we only care about populating this info when called via the packed
store.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/cat-file.c     | 2 +-
 builtin/pack-objects.c | 4 ++--
 commit-graph.c         | 2 +-
 odb/source-packed.c    | 4 ++--
 pack-bitmap.c          | 2 +-
 packfile.c             | 8 +++++---
 packfile.h             | 6 ++++--
 t/helper/test-bitmap.c | 2 +-
 8 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 0f3dbd9850..8726485f1f 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -497,7 +497,7 @@ static void batch_object_write(const char *obj_name,
 			data->info.sizep = &data->size;
 
 		if (pack)
-			ret = packed_object_info(pack, offset, &data->info);
+			ret = packed_object_info(NULL, pack, offset, &data->info);
 		else
 			ret = odb_read_object_info_extended(the_repository->objects,
 							    &data->oid, &data->info,
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index bc5f9ef321..620d9ce085 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2463,7 +2463,7 @@ static void drop_reused_delta(struct object_entry *entry)
 
 	oi.sizep = &size;
 	oi.typep = &type;
-	if (packed_object_info(IN_PACK(entry), entry->in_pack_offset, &oi) < 0) {
+	if (packed_object_info(NULL, IN_PACK(entry), entry->in_pack_offset, &oi) < 0) {
 		/*
 		 * We failed to get the info from this pack for some reason;
 		 * fall back to odb_read_object_info, which may find another copy.
@@ -3804,7 +3804,7 @@ static int add_object_entry_from_pack(const struct object_id *oid,
 	ofs = nth_packed_object_offset(p, pos);
 
 	oi.typep = &type;
-	if (packed_object_info(p, ofs, &oi) < 0) {
+	if (packed_object_info(NULL, p, ofs, &oi) < 0) {
 		die(_("could not get type of object %s in pack %s"),
 		    oid_to_hex(oid), p->pack_name);
 	} else if (type == OBJ_COMMIT) {
diff --git a/commit-graph.c b/commit-graph.c
index c6d9c5c740..9dc8bd5eee 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1538,7 +1538,7 @@ static int add_packed_commits(const struct object_id *oid,
 	struct object_info oi = OBJECT_INFO_INIT;
 
 	oi.typep = &type;
-	if (packed_object_info(pack, offset, &oi) < 0)
+	if (packed_object_info(NULL, pack, offset, &oi) < 0)
 		die(_("unable to get type of object %s"), oid_to_hex(oid));
 
 	return add_packed_commits_oi(oid, &oi, data);
diff --git a/odb/source-packed.c b/odb/source-packed.c
index 42c28fba0e..43fb53b72d 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -59,7 +59,7 @@ static int odb_source_packed_read_object_info(struct odb_source *source,
 	if (!oi)
 		return 0;
 
-	ret = packed_object_info(e.p, e.offset, oi);
+	ret = packed_object_info(packed, e.p, e.offset, oi);
 	if (ret < 0) {
 		mark_bad_packed_object(e.p, oid);
 		return -1;
@@ -99,7 +99,7 @@ static int odb_source_packed_for_each_object_wrapper(const struct object_id *oid
 		off_t offset = nth_packed_object_offset(pack, index_pos);
 		struct object_info oi = *data->request;
 
-		if (packed_object_info_with_index_pos(pack, offset,
+		if (packed_object_info_with_index_pos(data->store, pack, offset,
 						      &index_pos, &oi) < 0) {
 			mark_bad_packed_object(pack, oid);
 			return -1;
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 83eb47a28b..35774b6f0c 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1877,7 +1877,7 @@ static unsigned long get_size_by_pos(struct bitmap_index *bitmap_git,
 			ofs = pack_pos_to_offset(pack, pos);
 		}
 
-		if (packed_object_info(pack, ofs, &oi) < 0) {
+		if (packed_object_info(NULL, pack, ofs, &oi) < 0) {
 			struct object_id oid;
 			nth_bitmap_object_oid(bitmap_git, &oid,
 					      pack_pos_to_index(pack, pos));
diff --git a/packfile.c b/packfile.c
index 1d1b23b6cc..2b741d7a76 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1324,7 +1324,8 @@ static void add_delta_base_cache(struct packed_git *p, off_t base_offset,
 	hashmap_add(&delta_base_cache, &ent->ent);
 }
 
-int packed_object_info_with_index_pos(struct packed_git *p, off_t obj_offset,
+int packed_object_info_with_index_pos(struct odb_source_packed *source UNUSED,
+				      struct packed_git *p, off_t obj_offset,
 				      uint32_t *maybe_index_pos, struct object_info *oi)
 {
 	struct pack_window *w_curs = NULL;
@@ -1446,10 +1447,11 @@ int packed_object_info_with_index_pos(struct packed_git *p, off_t obj_offset,
 	return ret;
 }
 
-int packed_object_info(struct packed_git *p, off_t obj_offset,
+int packed_object_info(struct odb_source_packed *source,
+		       struct packed_git *p, off_t obj_offset,
 		       struct object_info *oi)
 {
-	return packed_object_info_with_index_pos(p, obj_offset, NULL, oi);
+	return packed_object_info_with_index_pos(source, p, obj_offset, NULL, oi);
 }
 
 static void *unpack_compressed_entry(struct packed_git *p,
diff --git a/packfile.h b/packfile.h
index 2329a69701..e1f77152b5 100644
--- a/packfile.h
+++ b/packfile.h
@@ -320,9 +320,11 @@ extern int do_check_packed_object_crc;
  * Look up the object info for a specific offset in the packfile.
  * Returns zero on success, a negative error code otherwise.
  */
-int packed_object_info(struct packed_git *pack,
+int packed_object_info(struct odb_source_packed *source,
+		       struct packed_git *pack,
 		       off_t offset, struct object_info *);
-int packed_object_info_with_index_pos(struct packed_git *p, off_t obj_offset,
+int packed_object_info_with_index_pos(struct odb_source_packed *source,
+				      struct packed_git *p, off_t obj_offset,
 				      uint32_t *maybe_index_pos, struct object_info *oi);
 
 void mark_bad_packed_object(struct packed_git *, const struct object_id *);
diff --git a/t/helper/test-bitmap.c b/t/helper/test-bitmap.c
index b130832b81..8547ef67e2 100644
--- a/t/helper/test-bitmap.c
+++ b/t/helper/test-bitmap.c
@@ -52,7 +52,7 @@ static int add_packed_object(const struct object_id *oid,
 
 	entry = packlist_alloc(packed, oid);
 	entry->idx.offset = nth_packed_object_offset(pack, pos);
-	if (packed_object_info(pack, entry->idx.offset, &oi) < 0)
+	if (packed_object_info(NULL, pack, entry->idx.offset, &oi) < 0)
 		die("could not get type of object %s",
 		    oid_to_hex(oid));
 	oe_set_type(entry, type);

-- 
2.55.0.rc1.745.g43192e7977.dirty

