Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71063644C1
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 11:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768475137; cv=none; b=lLcYx8cXztob3S3oNdDyQpKMynbP1T3pRAYpqULN+1zTqCRosZDz5rseXZ89CafW744+exNo8Bv4wrc/EBpnX4DodjSB2n8y0BYB1raTB2xhbJlWvDYPh1/8Fu+RYaoLQYrWdvjyHJWGlvl4COBItdwHC37jwpEH166+t4cfcUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768475137; c=relaxed/simple;
	bh=1Rm0Joq4ml9zSXsrXSd/NBF1p1OieEbk5Ps+c6sRNyg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N+qq9tQ1kNvggsJkG81BIj8badxUwsym1VtdxXxoOhnQHKe8h8bbPFt9+ubXUgli5XS2Nal3iR8VONvaRRTgGc6P/F/prLO/GRfR2jnS7C/VWNNO99uTSi6vod/aDLtwN09xu26CpXS5oBq+ty/jgG3sNJXzuMXcb9y6mRs/aCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IrrAj05X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GqumSu0s; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IrrAj05X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GqumSu0s"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 958F67A00BE
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 06:05:30 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 15 Jan 2026 06:05:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768475130;
	 x=1768561530; bh=HKgaA5IdhIQcInJnD4WVlqly+unCY+kG7xw1r0/HxoA=; b=
	IrrAj05X+wlXzL31Qopg67odB4g6Eq2wui2t32+qaY0ZMWEH37OT4CGE/55cy/h1
	VRhx9UpgB8aXsNlRMu7a965Yu24pSPUwg6fNA1BUgn/Bu7REUF4fdEAzA43ZudKB
	691a+G/hU9AMltdmexlqtVT4PGNQn9YNoakdq+0YUTHdC1yH+3mTL64hPqYK9jY2
	p1YN/TMw8kbJeC1uNxPdn1r890otvAoFXHHw3Z25vHGlcK76CAiZa6txzy7eZmV9
	fYOJxOAXMnpQ8NN4Ckhb2Id5eaWN81bi4zTE+7+qUjF9hmbHbFLXIrtJRffSdr/M
	2Jzt4HUItqodeB8o8WGKRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768475130; x=
	1768561530; bh=HKgaA5IdhIQcInJnD4WVlqly+unCY+kG7xw1r0/HxoA=; b=G
	qumSu0sMIgA0C3/vtHrJJr4H8MHeUXjhzaWxAyRgqpeNJ+dY+4lDbIwAm8iMJn/j
	17OSV2aNJu/opddScdeWuIkN9arso8RupvNuRuvO59KTVClTCUMn11RzLk9Kso0g
	rwiwCAaM5bGeSqeyVdhwRtUFhwicHMr+q8D/nGYPRot+WnKkohNCBALHyPo2n2SJ
	MRKlIEM/l1WLS6ykrFJDYo//EwkzL7kPdpFWOReR+PhW6mJcjFLmGWhb0WsHat7Z
	Xd4qwdJGXuPycutFGnT7igcS3vktr/x+M2N4VZ9THNiflQJ26IHtGhVqRrMTMIJJ
	RN6/eH9OrcYK1h3Do9Mcg==
X-ME-Sender: <xms:-sloaSuaYXhpm5TLPG9BRv-KWK2OIAvukJEnEvNdaf8MOvnDU6f_Qw>
    <xme:-sloaeZaVQJ1FNCFj9b5fUbBhlIBL0Vy_lugNVCSFdlvXuBydEAGDYoPDpKpL5MDJ
    EGeYgEvY7dFnM2EaE7ZKNTDMk8t4N-sjcENCSTKc8vGryqnHi-I3Q>
X-ME-Received: <xmr:-sloaTbDLGpuQQlojSQhbKViLFF3h1FcFi7RYgv9qBn62LuyMQWo8pd3z4gmKMVXd9RYL-xTe33oHJBHAfpFBtBq8l2ZyWwo6MOxtKJ5V2fABw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdehkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepfeenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:-sloaSUjr55bes8xPqKYxrkBIP6Y3xabKffakbTMLEQ6QyvdFOhsIQ>
    <xmx:-sloaS0qZgdFWNLcNpntIOJyRqmE_ao4gCSYF4Uixet3IK1TY-RIxw>
    <xmx:-sloaRZQi5mj49twbskUq8ILHUJOxz1JHmAyELaOi14drvhAHCDicw>
    <xmx:-sloadrmi4G6-pH_2u4E6QqUccAYXx7cXtqA3Jk5jAwhj3MN_ttJ3Q>
    <xmx:-sloadeFdtcAhCe-sCZmyrBdtCN3oUZj6dUaveidEl03HwBPG2wKxA4V>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 15 Jan 2026 06:05:29 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6c9bd61b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 15 Jan 2026 11:05:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 15 Jan 2026 12:04:42 +0100
Subject: [PATCH 13/14] reachable: convert to use `odb_for_each_object()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-pks-odb-for-each-object-v1-13-5418a91d5d99@pks.im>
References: <20260115-pks-odb-for-each-object-v1-0-5418a91d5d99@pks.im>
In-Reply-To: <20260115-pks-odb-for-each-object-v1-0-5418a91d5d99@pks.im>
To: git@vger.kernel.org
Cc: 
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
2.52.0.660.gd05f3a8ea5.dirty

