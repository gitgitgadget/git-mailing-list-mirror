Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28320346AE3
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 09:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768208488; cv=none; b=LK78WsnVmWg3GLN+n5Vz7dzG8f7daxpqWkoz7NGrjNxyswUuT0VQDKQIIctd6N/aMm3NfDqbYxsHQeNt6Ujv5ZuH0INGwfmKHRrCK240oKdcfVSQ09tW7GVz21Q5KrgVYFqUB6CaQ48EYpl2/YpxieEtJfi30NSa+RchONmPi6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768208488; c=relaxed/simple;
	bh=5DSZMYnsKQ4jgiM0aEDfaXQXSa2yEySMYQ7w55Hhyf8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hj3Ny0JEj5ku4YcnxegohUGz42VpwXAm0Nu7tmhzC7FutvgDKmVwId6vHaRAiW9Zduaq+lPhyVna5y7IPXrdlDesnGYbH7oQwKp5aHTengFNd3V1EA4n3D/rW7VVHKjE9E6KxUfTQ+d7bhwRz2fwby7XsA1LEYKTRMBl/t4mkrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XYWY6/bb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mYkcRPr5; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XYWY6/bb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mYkcRPr5"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EA9AD7A0040;
	Mon, 12 Jan 2026 04:01:15 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 12 Jan 2026 04:01:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768208475;
	 x=1768294875; bh=Uk2I4b5e5K7FStJKRTzHujEEvJHTzqXTB34wB6EZfLw=; b=
	XYWY6/bbHSISH5xKQfqY64aHIii5BgF4fetxsHJPjwNrGffQTJiulZxW1WoKX3SE
	2ls7ipENSIeB9nO4Ka0wXkhLOdi30FdGsLiXo9c0L+lqCPzokelwuqkc8kbNqk+K
	MTZK5TZNm+G82bhCYdWRBCOs5v6isSlb+juf3DqAAzusCy2BedvvA4ZsEoyc0rxq
	je1xojD5fVl/z5E6n33iDqCbRuW7j4Tv/Rg9E9IqeEmN6/J68t1FWDEwTv9qmhJk
	KqGnQaApmVYTrp7bRliJLU9Wz9BHYAhcirTVG/vApmwuEvw7ijclhW1GT482AF3k
	QGXWnCreBL0Pwq+/LI7zCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768208475; x=
	1768294875; bh=Uk2I4b5e5K7FStJKRTzHujEEvJHTzqXTB34wB6EZfLw=; b=m
	YkcRPr5YlbDqJlDNioMtDBMc9bDj1moUh23bxQSdke8xEzy5e20VpLj1tVFm+23I
	55SSzji0AhVs8gAl+E+PxfvY1tNX/sRslN7YNFX968xKHWKVcuB9h9S3pOjxMJM7
	0aIM5JWxddlFBgXiV92hwIvmnY1ylu+TMB8KPU02qfkBDDlSNyS0Mu7wrzT0IbdR
	L0HsRAnL+V/tvw46sCbeHoIF6ziU3UUcTpRBsMlPUFVWy4HDSuqqO94JoCJt9DJl
	oAJmoql16SfsqF+1Z+yR+A5JqSBHLQd930+SgwePCIo4ChGN+DRI/0fnyctMGapb
	Mw+uD1sM6NT06eZJnpOHA==
X-ME-Sender: <xms:W7hkaUXNRTDWL8Ua22oF0EmZ62Sl9DvGqIUmA4nDKJRGoGE5Z_X_xQ>
    <xme:W7hkacSlMU36FHLQD4sUVd-wTTl9gPR9tIrGtIXZxl1NCz5FtNF452-brYjesIBwk
    VmEsPmoSW1aNKqkCyu2DyF1Y2aBUKrE3PR2z3NEKh25Gpl258a5dw>
X-ME-Received: <xmr:W7hkaSMHhYov3LgYWV-_UdPEorYz_IL9kEJLutt_-ACxMf1yveVuz2D5DJE8QMg9AtG_mmZvlvFk_m5AYHqSm-41i95ArZ-lTOMthfglmw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudejtdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghplhgrth
    htnhgvrhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepthhoohhnsehiohhttghlrdgt
    ohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgt
    phhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:W7hkaaTrPlFNkO6KLhomw6Gomidireyd3n2hcFzp30_qH9GXDUtDrA>
    <xmx:W7hkaQh8JfknKHbMzvDnPLO496yiKMyWv9g_XI-0zSpr9tUgxU4ubg>
    <xmx:W7hkaT8e9Zj9jRYROQ4IEIf04MFQaYcOZc4OwWTdjylMWdWtqXvzIg>
    <xmx:W7hkaXHxputhlf66_iEYpDWI0fz4HP6ceyoCRxUzvOd_3laIPbUg2Q>
    <xmx:W7hkaTUHxNUBsb5lGEYaiILGGq1DheSk5qN5n1-4WntOkLE0zrC7DzAf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jan 2026 04:01:14 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7e99a2cc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 12 Jan 2026 09:01:13 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 12 Jan 2026 10:00:47 +0100
Subject: [PATCH v5 7/7] packfile: drop repository parameter from
 `packed_object_info()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-b4-pks-odb-read-object-info-improvements-v5-7-9a6124e95bf2@pks.im>
References: <20260112-b4-pks-odb-read-object-info-improvements-v5-0-9a6124e95bf2@pks.im>
In-Reply-To: <20260112-b4-pks-odb-read-object-info-improvements-v5-0-9a6124e95bf2@pks.im>
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
2.52.0.590.g1f87b77810.dirty

