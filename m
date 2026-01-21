Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A9448B397
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 12:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768999872; cv=none; b=KSWHUPW3fQVRG2Qnqky9M5E1cWgz0LVITVy7zfDfu8O0rOc7BvnqbmSu/qaQK+hHq1/KZ1GkyVQEsb2sLF7Y+BjFmKHLektINxnPba7u2FmLtSUWTXL5SvWrJiR6mkdvKRFtvvkUtxi/BXao1QtSGtWVLfyQbZp91bLacmRM6u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768999872; c=relaxed/simple;
	bh=PkiMfAggfhsE9YuaLO/GRK+LHKEv26O6ZeXUcb9r1eY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p7wFL6Zbyyyo1iWBThqq0jxndo0lwKhb3RLfwpwhLKIbFuQz8opd6R22wbylLu9lrOLFakj0RIWZfy+tFX5xxDNBico4Uqvz1mTLy+kcjPjpaYiC+kg7IMLzLAC0hqrKD3nMpjtX7Zrguy5Juwt4rykUUW5XmdTMUZ9cQW/RuXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Tj8qAeqs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NowZ99v2; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Tj8qAeqs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NowZ99v2"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7882D7A0031;
	Wed, 21 Jan 2026 07:51:09 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 21 Jan 2026 07:51:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768999868;
	 x=1769086268; bh=TCYVVvCUgS0wdsyjcELHK6KBmjbbAHKYgQDCjrKcJQw=; b=
	Tj8qAeqs6C7LhfBcRIMbZztNl4cjzHW4nrCzKHrEfsJ9Ix1vXgOR4IKB1HLp1ms5
	4slEaggAxHGZqv8d70J/X5sXzaXsSzm5H52c5WQG79wr2Y6CJJCtE8o+gdYYtIyt
	/Zgjp86nYnf4d9jH3YKWe5lOAXA1nPBGudqFJcS5RoPA50LRj0Dzyhsjpmb7YyAY
	0RULOeJ7iZqG7rQCSsEaTu2JhdbK1CMavgl4Z2e0O3G6PaI8eSzBj9DEIQik+hKQ
	n6Sj6QtX5WmAS15UwUZU7TCL4an7cRTKUpJiniCZvbFShMyN5IDJ/PJa2tT/Pbjn
	f4+X34bs0aGqafSe+qRXBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768999868; x=
	1769086268; bh=TCYVVvCUgS0wdsyjcELHK6KBmjbbAHKYgQDCjrKcJQw=; b=N
	owZ99v2PAYOZyyIViXmbyuva56LGBNiOkWZkL1afFNQuGSvxrdjQawhE7rkxrrg3
	Aj4L4BxuVz6GT0RuAJhawvajnPWUpbY1s6GQyo5uMt1aAKKhIUhCBWbz682nvz+z
	u/w7FVW5yCOiv0+tJ3i8N+cYngl/lLmwTOhtM0+w8gPXc4z2H9hHReSwqtIXHITy
	sLyYDJG7SZNk9ZVRRwc9+CxeewDAvyE56e1lvpauvoCv55GGvXVoE4qWXdnuZaMk
	sOV3NjYAYhnSXM9rwoTX52UajlLlzKj+oUteC9byFFA824M7yKjAHUGy7LLICPmV
	ixDoFCAostLF2aa5S2V/A==
X-ME-Sender: <xms:vMtwaZm2nTaHy_3dHZAuHTDM5DkWBx_gPnOM9G0ohAMICB7Ejvyo7A>
    <xme:vMtwab31blk0ILYywCY5Vw8xwjFFQ_cjwwjj-bOMcq0vazPOqMsAt55MimS9qeVY0
    g1xZAu0RULBbXcZI-mBxUogCCMk7CzD6WXkZRxSWmvFhoGKNfRsnA>
X-ME-Received: <xmr:vMtwaUp9LKMEMJvUAM-hMn256nodG1jc8AvdOdgIbqGkGOvkSRrZH-ho2QAatZ5zHU6HEBU6eaT_-e_5FS0QJIOPw0TtuKtFVLEXt28SkUI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeeffedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpeegnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthh
    hikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:vMtwaYfi2fdGLlFmiqw5ih9Ltr1-yQLKbQRRF52dxSeNWzmNqU8IRQ>
    <xmx:vMtwaTrz_9zxBZsLZWFcu-G5INS0GUlj2D5Q_zcITR3q-XPvlFMevA>
    <xmx:vMtwaZH5juHNMJgGHd9yGBrzIvjetyj8YVOC7TjqJDkewepYucbOgw>
    <xmx:vMtwaTucr9WvBSNZ1Lpduvl87FADxwRUMpxcKLH42tsouq-DtBiuNg>
    <xmx:vMtwaQJky-NIUvCdNASoVFh-oNUfwHNsEWnhrDH3fsBGTr-AqTLGUHhs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jan 2026 07:51:07 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b344e249 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 21 Jan 2026 12:51:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 21 Jan 2026 13:50:29 +0100
Subject: [PATCH v3 13/14] reachable: convert to use `odb_for_each_object()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-pks-odb-for-each-object-v3-13-12c4dfd24227@pks.im>
References: <20260121-pks-odb-for-each-object-v3-0-12c4dfd24227@pks.im>
In-Reply-To: <20260121-pks-odb-for-each-object-v3-0-12c4dfd24227@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.3

To figure out which objects expired objects we enumerate all loose and
packed objects individually so that we can figure out their respective
mtimes. Refactor the code to instead use `odb_for_each_object()` with a
request that ask for the object mtime instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reachable.c | 125 +++++++++++++++++-------------------------------------------
 1 file changed, 35 insertions(+), 90 deletions(-)

diff --git a/reachable.c b/reachable.c
index 82676b2668..101cfc2727 100644
--- a/reachable.c
+++ b/reachable.c
@@ -191,30 +191,27 @@ static int obj_is_recent(const struct object_id *oid, timestamp_t mtime,
 	return oidset_contains(&data->extra_recent_oids, oid);
 }
 
-static void add_recent_object(const struct object_id *oid,
-			      struct packed_git *pack,
-			      off_t offset,
-			      timestamp_t mtime,
-			      struct recent_data *data)
+static int want_recent_object(struct recent_data *data,
+			      const struct object_id *oid)
 {
-	struct object *obj;
-	enum object_type type;
+	if (data->ignore_in_core_kept_packs &&
+	    has_object_kept_pack(data->revs->repo, oid, KEPT_PACK_IN_CORE))
+		return 0;
+	return 1;
+}
 
-	if (!obj_is_recent(oid, mtime, data))
-		return;
+static int add_recent_object(const struct object_id *oid,
+			     struct object_info *oi,
+			     void *cb_data)
+{
+	struct recent_data *data = cb_data;
+	struct object *obj;
 
-	/*
-	 * We do not want to call parse_object here, because
-	 * inflating blobs and trees could be very expensive.
-	 * However, we do need to know the correct type for
-	 * later processing, and the revision machinery expects
-	 * commits and tags to have been parsed.
-	 */
-	type = odb_read_object_info(the_repository->objects, oid, NULL);
-	if (type < 0)
-		die("unable to get object info for %s", oid_to_hex(oid));
+	if (!want_recent_object(data, oid) ||
+	    !obj_is_recent(oid, *oi->mtimep, data))
+		return 0;
 
-	switch (type) {
+	switch (*oi->typep) {
 	case OBJ_TAG:
 	case OBJ_COMMIT:
 		obj = parse_object_or_die(the_repository, oid, NULL);
@@ -227,77 +224,22 @@ static void add_recent_object(const struct object_id *oid,
 		break;
 	default:
 		die("unknown object type for %s: %s",
-		    oid_to_hex(oid), type_name(type));
+		    oid_to_hex(oid), type_name(*oi->typep));
 	}
 
 	if (!obj)
 		die("unable to lookup %s", oid_to_hex(oid));
-
-	add_pending_object(data->revs, obj, "");
-	if (data->cb)
-		data->cb(obj, pack, offset, mtime);
-}
-
-static int want_recent_object(struct recent_data *data,
-			      const struct object_id *oid)
-{
-	if (data->ignore_in_core_kept_packs &&
-	    has_object_kept_pack(data->revs->repo, oid, KEPT_PACK_IN_CORE))
+	if (obj->flags & SEEN)
 		return 0;
-	return 1;
-}
 
-static int add_recent_loose(const struct object_id *oid,
-			    const char *path, void *data)
-{
-	struct stat st;
-	struct object *obj;
-
-	if (!want_recent_object(data, oid))
-		return 0;
-
-	obj = lookup_object(the_repository, oid);
-
-	if (obj && obj->flags & SEEN)
-		return 0;
-
-	if (stat(path, &st) < 0) {
-		/*
-		 * It's OK if an object went away during our iteration; this
-		 * could be due to a simultaneous repack. But anything else
-		 * we should abort, since we might then fail to mark objects
-		 * which should not be pruned.
-		 */
-		if (errno == ENOENT)
-			return 0;
-		return error_errno("unable to stat %s", oid_to_hex(oid));
+	add_pending_object(data->revs, obj, "");
+	if (data->cb) {
+		if (oi->whence == OI_PACKED)
+			data->cb(obj, oi->u.packed.pack, oi->u.packed.offset, *oi->mtimep);
+		else
+			data->cb(obj, NULL, 0, *oi->mtimep);
 	}
 
-	add_recent_object(oid, NULL, 0, st.st_mtime, data);
-	return 0;
-}
-
-static int add_recent_packed(const struct object_id *oid,
-			     struct packed_git *p,
-			     uint32_t pos,
-			     void *data)
-{
-	struct object *obj;
-	timestamp_t mtime = p->mtime;
-
-	if (!want_recent_object(data, oid))
-		return 0;
-
-	obj = lookup_object(the_repository, oid);
-
-	if (obj && obj->flags & SEEN)
-		return 0;
-	if (p->is_cruft) {
-		if (load_pack_mtimes(p) < 0)
-			die(_("could not load cruft pack .mtimes"));
-		mtime = nth_packed_mtime(p, pos);
-	}
-	add_recent_object(oid, p, nth_packed_object_offset(p, pos), mtime, data);
 	return 0;
 }
 
@@ -307,7 +249,13 @@ int add_unseen_recent_objects_to_traversal(struct rev_info *revs,
 					   int ignore_in_core_kept_packs)
 {
 	struct recent_data data;
-	enum odb_for_each_object_flags flags;
+	unsigned flags;
+	enum object_type type;
+	time_t mtime;
+	struct object_info oi = {
+		.mtimep = &mtime,
+		.typep = &type,
+	};
 	int r;
 
 	data.revs = revs;
@@ -318,16 +266,13 @@ int add_unseen_recent_objects_to_traversal(struct rev_info *revs,
 	oidset_init(&data.extra_recent_oids, 0);
 	data.extra_recent_oids_loaded = 0;
 
-	r = for_each_loose_object(the_repository->objects, add_recent_loose, &data,
-				  ODB_FOR_EACH_OBJECT_LOCAL_ONLY);
-	if (r)
-		goto done;
-
 	flags = ODB_FOR_EACH_OBJECT_LOCAL_ONLY | ODB_FOR_EACH_OBJECT_PACK_ORDER;
 	if (ignore_in_core_kept_packs)
 		flags |= ODB_FOR_EACH_OBJECT_SKIP_IN_CORE_KEPT_PACKS;
 
-	r = for_each_packed_object(revs->repo, add_recent_packed, &data, flags);
+	r = odb_for_each_object(revs->repo->objects, &oi, add_recent_object, &data, flags);
+	if (r)
+		goto done;
 
 done:
 	oidset_clear(&data.extra_recent_oids);

-- 
2.53.0.rc0.250.g0ac79233d6.dirty

