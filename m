Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F2F32E697
	for <git@vger.kernel.org>; Mon, 26 Jan 2026 09:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769421121; cv=none; b=dLcRBxERxvQgEMt98ap24IV7F21x5eRH/NhldAd6psQQ/Nj+kweYlZSW/U3oaB5tWesv+/vWomiKpbpK7L/dtinezDQDGMAMOJ4zU6Qc6e6ByLCAyhDd0HdP+nnpxw98Cd8ptmjB/FYjcXq9f9uq+23J5xbz8q79+aOMcVS1X3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769421121; c=relaxed/simple;
	bh=Naybh9ouKoHlvBxY96txO+iHE6OIAIT1Vy8RSLvITxk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QV37YNaJWunC0Mg9SS0akamgMOwqbhgifHqpn5a9uZOLCwh6fgBkhxb0SdoTr/UTHZmsbPpFrXNvGvSnfhH07BnU8fsvMSrvQqWTsZ0fVHNOY/xE/7UZ34zMD7qv8R483wKPFGoLv+KOGnawLu4Du7z5W1YJ1O7S2HeJcyor+8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bNJ+cPzq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QNNk4hJi; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bNJ+cPzq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QNNk4hJi"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id E82011D0009D;
	Mon, 26 Jan 2026 04:51:58 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 26 Jan 2026 04:51:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1769421118;
	 x=1769507518; bh=BrbD9ZF7wG4Ub2XU/n9aEfX36MsKRBSv6Ktur54WVXk=; b=
	bNJ+cPzq025cpgOpzvTztCaQFv46efRABPS1lcxIWG7KzxliW0MZlFmgCjYBIvml
	sdx3jc08HzNSHT1akm0ljTxOsRNwAsNtpGBzu3HWylK4Jyd4amxNrZZXivNGvInv
	s1WrNjIlYn2OsQMrE06X5eG5X/f2nRyuKj3kDnNZsxeIAoSqu4XndQSNwkq3UsDv
	5OxwIc56SNIsVjtNh2GM0dR4WqR1Gr20JSzZiI1nqR3BWK7H1T6Y7h8OCMv6tat4
	7HjYKky1LwVRQfFlFn1D+eeWV+hrnZyXrQyguKvBCP2TWMXOVlZHpUzSDXqwUmcg
	KW6D/qjUiw1gJ56T2SmQsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1769421118; x=
	1769507518; bh=BrbD9ZF7wG4Ub2XU/n9aEfX36MsKRBSv6Ktur54WVXk=; b=Q
	NNk4hJi3quFaMEdwNjFNDQHz7QLa4Ym9S/l6aqx1FYL/lquy+mRSgKAAQ1P8Kw63
	tG94HRDEiFLOXkz/91z9X40lUltknL31wDxdBiahdOBLX03WVn4PDa9j1Tn6YFZo
	Iil8z5pnCONNrWuNEbd82YLVtWScMT382y6rkB7RBdFLiPf2dzf056gEcosiCSSc
	7lPikNAMB6BxgDS7RLyA0xUu48Lo5wqoreUhVfB6A03TxHnl0KIO75IYoja3KHO/
	wBWVz1RbmcjrIUS73FLXHisQ5nmAKxSrRhaRR4ZrafKWz84swHjaPH1zrg4RZW+z
	IU2bKmrZJpopT4vQUwPug==
X-ME-Sender: <xms:Pjl3aR0wsen6OK95PlYKq95zYIJ9eJolQ6Dlm2Op8c0uX1_M3DZdCw>
    <xme:Pjl3afFKlpX5gdNZBgjQXit_P7HWGcfXnVg5fYh2Zyv-OP-6IHH_pkQk3Zsak9Z82
    tbVUJg6-4l0EUC4_V4o732cDTNGgG6XA8LmrsdffA82FkK2Oy8qNg>
X-ME-Received: <xmr:Pjl3aW58aDoGSu7eSxCT_bXnq1yplEUa1l-mk9h9j6XmYxKcIwUP4mFz8Z1xLvdcD9OyD8q470IONI4WRxMB3JDB7ZFNOfPFO7XDMks-8fRscg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheejfeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpeehnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepjhhlthhosghlvg
    hrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:Pjl3advcz7B0NHHgCHwY-FPsksuCq4_-3UPpGnLHlnOHLwiI3Rh_9A>
    <xmx:Pjl3af4AEzr0eTFqwFMy3eo1rdzwzwsOmHUv5YjkHRMV4X6uVHCLFQ>
    <xmx:Pjl3aQXuuUnONw_K5CXRCKRUMusovurJ_IapiUKNhD5UDtMMlIHGKw>
    <xmx:Pjl3aZ_pibo5ZN9TMDrG4so0asLzDQ5ztzUTPmu7MqLDcvGuDmaAMg>
    <xmx:Pjl3aSY4rCChIg0-CJLhyY2JUB3u37JRA7fmAA0zVmepjbNAxdSViLnE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Jan 2026 04:51:57 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 029af5fc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 26 Jan 2026 09:51:57 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 26 Jan 2026 10:51:29 +0100
Subject: [PATCH v4 13/14] reachable: convert to use `odb_for_each_object()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260126-pks-odb-for-each-object-v4-13-5a64a038c791@pks.im>
References: <20260126-pks-odb-for-each-object-v4-0-5a64a038c791@pks.im>
In-Reply-To: <20260126-pks-odb-for-each-object-v4-0-5a64a038c791@pks.im>
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
2.53.0.rc1.267.g6e3a78c723.dirty

