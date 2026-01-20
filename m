Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459E347DF96
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 15:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768922814; cv=none; b=uVC/0EZIyCAC8l2DaCTagvf9xKbTpapdUei/sBroDn7idiC8h4mizQlJ1gxjrVY2LtJmC8nVLFQ5kSoKpjfYhMB7dsMXuCqTm6FmKSrazE/Q8PfjuChFgX6SR5hSohT8r0lhJxmzjbMJ+Yv8MyMDqHitZPxF3n5tceEi2piyGU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768922814; c=relaxed/simple;
	bh=PkiMfAggfhsE9YuaLO/GRK+LHKEv26O6ZeXUcb9r1eY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ze4yN7rdoJcjO+e4G2UJTY0YL64O74lRvrZnm9MxHSSwh2WcdPBvOgK6qL+WIrdusX9GkuuBcvfioE8jvkJYnLtfVr8EoR/r3By1laxb2lADgSg2/0z9D6QDM9u2miuNi56l/aD08CI7RIZ8H/n8pS4qGNiY4+ovlzGIdOvOKFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EnEPzxo6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C+LVwpiE; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EnEPzxo6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C+LVwpiE"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A92F07A006C;
	Tue, 20 Jan 2026 10:26:51 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 20 Jan 2026 10:26:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768922811;
	 x=1769009211; bh=TCYVVvCUgS0wdsyjcELHK6KBmjbbAHKYgQDCjrKcJQw=; b=
	EnEPzxo6W/lcfGw8vZxjbAJ9C+lGPLZsjxS+LTfSkED6SO5WQIthkcRyzlw85ut4
	dCgYWnYx4lLjn758sCxqFBh4vhReAr8bJDpDJZA3ww7u4nSf/EXa4EuVOXlxRMMW
	9Lqp6TtrdS1LXDYqzqzGCyiXD+TY0lr2bfh0V7TVY+haEEjSHqZ3ywOqVcvC5Ur/
	6k/bxXz9Y3YvzBkrD+lIJAfHWqLYSX7d8K/BDzNaCajCm8Zem6oiNoSElVQaVZtX
	iwo4rfhCTiJBNpdyB7gClnT44klFuUzdnF/4DCLiIk8mJnG4pFmBb5kiJ8JlsAGy
	0wiGPtvzEctiNjIQba6rHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768922811; x=
	1769009211; bh=TCYVVvCUgS0wdsyjcELHK6KBmjbbAHKYgQDCjrKcJQw=; b=C
	+LVwpiEEG9Zst5alnaicr07JOZ6UqsQUqS13tmDfZxW1PNZyQlDm+6GK65pkLPql
	tXVWCGwI+FYE26ZgkQI6NhIGqOBT2CcUBkGK4nZxpncnXUjnnIoAheqQwwZPO+5z
	uzt8VMLM+7geVbC3M/6S6cRWyHT8Ob7tckqFt+Z2LrmHRbnjToSzTzGhklj+yDk9
	77CprKl5H2ltqVkXwkbHedF3XUyRma7vaybdogGv50lTaJruAVrN64lAAI0JxcUR
	47Yg5THOQhcBOPaZXbn+07xRCWdYHxnkc519W+XH/TM0dqqL8ShhRlT/rQYh9hXJ
	JUYxsCx6ss8cdiGzm5Tjw==
X-ME-Sender: <xms:u55vaR9m1hab77T2z1mJlFYdHEQKp6ZdggE-yKCQzh9LH3xda1zVqw>
    <xme:u55vacsVzMJXCW_ou9yLNsloxeOXHuDmK-98t_9KlVv1oh_ZkNkIYwxIT2I6shDJ1
    oz7ln82yBEdU_lF5eZcjjXdTaG2vmNNgA5ICq48O7GtLLarbe6y8A>
X-ME-Received: <xmr:u55vaUC3h9vpXtYW4wZSm38-YB_ZwA4hXmvKDc-jvy3qoMrrLCqXdfOOi4aBapobmjlAYcMg2wGTxM400Y0mVaXS7TrudoIP8yf8rRLDvg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugedtjeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:u55vaUWUjK_il2iX4QTqtjcBZD-ojIt8GdOpl2Pw8ZxqalSvKqEA8g>
    <xmx:u55vaSBV7j7_kVlbVAF2ZLguH9yg81QEF7sHshgvEWNYNmBVkd338Q>
    <xmx:u55vaX9MC3SZ6Y_iwlqc7jrTX6xxRPZ9zbA6DnSy7f_hqcB4FEdNfA>
    <xmx:u55vaZG_iL5RWR1FzJklNvCVVtqvxB51D0-yLHFffohnXOLEfSlw8g>
    <xmx:u55vaXhtAEnAiQzsSFrarxCL0FER9WAVnjC1Q5K6vo1OufrfeaXepk_u>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jan 2026 10:26:50 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id af8a4bc8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 20 Jan 2026 15:26:50 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 20 Jan 2026 16:26:09 +0100
Subject: [PATCH v2 13/14] reachable: convert to use `odb_for_each_object()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260120-pks-odb-for-each-object-v2-13-d05cbfd3d6f8@pks.im>
References: <20260120-pks-odb-for-each-object-v2-0-d05cbfd3d6f8@pks.im>
In-Reply-To: <20260120-pks-odb-for-each-object-v2-0-d05cbfd3d6f8@pks.im>
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

