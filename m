Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0469232E72B
	for <git@vger.kernel.org>; Mon, 26 Jan 2026 09:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769421115; cv=none; b=FcE1rYUdEos5Ofu/SQ/Nu5hXKSgwWG4U0+f8ov1Xa/JTJkXaMvi5MqvhwGXGBTaC9movMPLM+0R6t1dNkUNme46owGEluz/XKFZda1szkbKHlbznr9j2CTsiVLIBy2S6mZVdI4LCygPj9y5eC5UoSScP9dAI5b4g/jNCzC4FKPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769421115; c=relaxed/simple;
	bh=pT2DUmUTdbzrIza1CcQa+QuXxn8Ago+57m8YriqvuZY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CxJbw2zKZrfsWEASJE9yB5ORse3xnFWtublpSc9XlsXec0fPS76jnclMg+C467x63hr/4TP8K1OmcPFdmmboOdkarlSK7pBXdL8RTyrQEQyBV8pDguN+iWa13lMV+trKsjfOumWdl2xHRcXRMgV9xdTiaEoiHCs3gj3OYRkByuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bNnbCTzz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VONsKMZR; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bNnbCTzz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VONsKMZR"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 27B661D00097;
	Mon, 26 Jan 2026 04:51:53 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 26 Jan 2026 04:51:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1769421113;
	 x=1769507513; bh=jr2uWHAhZOYhKBIANZb2hNWM7v3cdkpk3GcztQW7J00=; b=
	bNnbCTzzoqAPHY6DUANNGR5WnXvcr2bW6XZ/i93JX7SIzjYQPhjKVcceEHxhG2XB
	C3UahTuKVxLXkwwQeu10bDLPU1pOodDjUlVRRISLWQfwOjzVkAjMaZ21SS/8AZpp
	d2JI6Ae6rpW2K1yzR7Qh4D/SVLC09dB7LGXKvpH0fkmtSWO22xYJiSqZVRkqQmEK
	Q7SolShacs98GSjNx40CnkWNwUCqZncvmqLaBgsMaDSOIM7yV2CnFIb1h9/lJEoX
	MDeqplzwwWT7KZ3j0mQeT2NorhMRziC8TA5+zrJXg8a4nBWJ3mDibOYWwSzyXBqf
	17X68OCzDOB/foGWbYYlhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1769421113; x=
	1769507513; bh=jr2uWHAhZOYhKBIANZb2hNWM7v3cdkpk3GcztQW7J00=; b=V
	ONsKMZRbDQP5HuRthLtgRlC1sMMCUujmqD3UducVImWHE1g6NQ05s5A0s+XZpbR1
	hTzG6bLSP+qrJve5gG02mVzAtGZ1Kv/yH0swr3bZs60PGDUUV1j8Bu71CRB+O0Q9
	bsF8if0Ull3XFXHHwYoaH4xg+1klf1SZlQJO+SeEBJsqhKdqMHA5CRflEqAFzuy6
	kr5cl9f5OFY8zi4RFKBzmnzXzziXvZm0dDGMnGqLZTJMm/9oU1LrN9cg1a6qXbha
	OuWQNdEg7KZhYOKa9Cab6PsT0Ek9wGF4ZOnkuFHyrOygoPpBzVM3EG+brt+i9Yu0
	NvkJAGxYF6bpWRH7egCrQ==
X-ME-Sender: <xms:ODl3aUmxG6vKF-C139LuIGsvEqKUE-OUjF8dszMf-H7tYq_kBJNvug>
    <xme:ODl3aa3SjNyn_naoi-xGZ9vhfr8bkGsN49At0L4z8AxOxGryWhGk3BJoYPhnRcIPE
    3SteP3fxXbx6Q---f4u2N525UTASJqwxsfj5UDoF9WHkbnMJnQDYlk>
X-ME-Received: <xmr:ODl3aXovoxiQ7ahGpL4F3aaXEVHFTMKUG-_wHXgP6LAbpFY6-Lhwm_kkuqwuYog6kycmUHBLY__0CfsNDGVt6K48xdTUb1JNBu9pvv9iLCtiWA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheejfeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpeegnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhih
    hkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ODl3affguoNZ6kaOzCU0E3RgmSlPcH9zvSvnb0p4JM1jxFIXw0zRHA>
    <xmx:ODl3aeropD9vV7bUfSlTDQrWs0uzcDxUf4y2pyUqi5MdAhse5keMHg>
    <xmx:ODl3aYG1xzTSL1mAccSEtJ4u9BgGPXD8e-4SRoVVm-mmdvj_YDA2lQ>
    <xmx:ODl3aWtB8Z5o7xSpjweH-nP_gsQNl4LswhOLNamvrZPniXEwnBezUg>
    <xmx:OTl3aTKylN3os8jbXJmcL8dn1_z1rPLCgpgp7BHl2ycuszwB06aYE0Ns>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Jan 2026 04:51:52 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fa3d2e44 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 26 Jan 2026 09:51:51 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 26 Jan 2026 10:51:27 +0100
Subject: [PATCH v4 11/14] odb: introduce mtime fields for object info
 requests
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260126-pks-odb-for-each-object-v4-11-5a64a038c791@pks.im>
References: <20260126-pks-odb-for-each-object-v4-0-5a64a038c791@pks.im>
In-Reply-To: <20260126-pks-odb-for-each-object-v4-0-5a64a038c791@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.3

There are some use cases where we need to figure out the mtime for
objects. Most importantly, this is the case when we want to prune
unreachable objects. But getting at that data requires users to manually
derive the info either via the loose object's mtime, the packfiles'
mtime or via the ".mtimes" file.

Introduce a new `struct object_info::mtimep` pointer that allows callers
to request an object's mtime. This new field will be used in a
subsequent commit.

Note that the concept of "mtime" is ambiguous: given an object, it may
be stored multiple times in the object database, and each of these
instances may have a different mtime. Disambiguating these mtimes is
nothing that can happen on the generic ODB layer: the caller may search
for the oldest object, the newest object, or even the relation of object
mtimes depending on the specific source they are located in. As such, it
is the responsibility of the caller to disambiguate mtimes.

A consequence of this is that it's most likely incorrect to look up the
mtime via `odb_read_object_info()`, as this interface does not give us
enough information to disambiguate the mtime. Document this accordingly
and tell users to use `odb_for_each_object()` instead.

Even with this gotcha though it's sensible to have this request as part
of the object info, as the mtime is a property of the object storage
format. If we for example had a "black-box" storage backend, we'd still
need to be able to query it for the mtime info in a generic way.

We could introduce a safety mechanism that for example calls `BUG()` in
case we look up the mtime outside of `odb_for_each_object()`. But that
feels somewhat heavy-handed.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c | 29 +++++++++++++++++++++++++----
 odb.c         |  2 ++
 odb.h         | 13 +++++++++++++
 packfile.c    | 41 ++++++++++++++++++++++++++++++++++-------
 4 files changed, 74 insertions(+), 11 deletions(-)

diff --git a/object-file.c b/object-file.c
index ef2c7618c1..5537ab2c37 100644
--- a/object-file.c
+++ b/object-file.c
@@ -409,6 +409,7 @@ static int read_object_info_from_path(struct odb_source *source,
 	char hdr[MAX_HEADER_LEN];
 	unsigned long size_scratch;
 	enum object_type type_scratch;
+	struct stat st;
 
 	/*
 	 * If we don't care about type or size, then we don't
@@ -421,7 +422,7 @@ static int read_object_info_from_path(struct odb_source *source,
 	if (!oi || (!oi->typep && !oi->sizep && !oi->contentp)) {
 		struct stat st;
 
-		if ((!oi || !oi->disk_sizep) && (flags & OBJECT_INFO_QUICK)) {
+		if ((!oi || (!oi->disk_sizep && !oi->mtimep)) && (flags & OBJECT_INFO_QUICK)) {
 			ret = quick_has_loose(source->loose, oid) ? 0 : -1;
 			goto out;
 		}
@@ -431,8 +432,12 @@ static int read_object_info_from_path(struct odb_source *source,
 			goto out;
 		}
 
-		if (oi && oi->disk_sizep)
-			*oi->disk_sizep = st.st_size;
+		if (oi) {
+			if (oi->disk_sizep)
+				*oi->disk_sizep = st.st_size;
+			if (oi->mtimep)
+				*oi->mtimep = st.st_mtime;
+		}
 
 		ret = 0;
 		goto out;
@@ -446,7 +451,21 @@ static int read_object_info_from_path(struct odb_source *source,
 		goto out;
 	}
 
-	map = map_fd(fd, path, &mapsize);
+	if (fstat(fd, &st)) {
+		close(fd);
+		ret = -1;
+		goto out;
+	}
+
+	mapsize = xsize_t(st.st_size);
+	if (!mapsize) {
+		close(fd);
+		ret = error(_("object file %s is empty"), path);
+		goto out;
+	}
+
+	map = xmmap(NULL, mapsize, PROT_READ, MAP_PRIVATE, fd, 0);
+	close(fd);
 	if (!map) {
 		ret = -1;
 		goto out;
@@ -454,6 +473,8 @@ static int read_object_info_from_path(struct odb_source *source,
 
 	if (oi->disk_sizep)
 		*oi->disk_sizep = mapsize;
+	if (oi->mtimep)
+		*oi->mtimep = st.st_mtime;
 
 	stream_to_end = &stream;
 
diff --git a/odb.c b/odb.c
index 13a415c2c3..9d9a3fad62 100644
--- a/odb.c
+++ b/odb.c
@@ -702,6 +702,8 @@ static int do_oid_object_info_extended(struct object_database *odb,
 				oidclr(oi->delta_base_oid, odb->repo->hash_algo);
 			if (oi->contentp)
 				*oi->contentp = xmemdupz(co->buf, co->size);
+			if (oi->mtimep)
+				*oi->mtimep = 0;
 			oi->whence = OI_CACHED;
 		}
 		return 0;
diff --git a/odb.h b/odb.h
index b5d28bc188..8ad0fcc02f 100644
--- a/odb.h
+++ b/odb.h
@@ -318,6 +318,19 @@ struct object_info {
 	struct object_id *delta_base_oid;
 	void **contentp;
 
+	/*
+	 * The time the given looked-up object has been last modified.
+	 *
+	 * Note: the mtime may be ambiguous in case the object exists multiple
+	 * times in the object database. It is thus _not_ recommended to use
+	 * this field outside of contexts where you would read every instance
+	 * of the object, like for example with `odb_for_each_object()`. As it
+	 * is impossible to say at the ODB level what the intent of the caller
+	 * is (e.g. whether to find the oldest or newest object), it is the
+	 * responsibility of the caller to disambiguate the mtimes.
+	 */
+	time_t *mtimep;
+
 	/* Response */
 	enum {
 		OI_CACHED,
diff --git a/packfile.c b/packfile.c
index c54deabd64..845633139f 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1578,13 +1578,14 @@ static void add_delta_base_cache(struct packed_git *p, off_t base_offset,
 	hashmap_add(&delta_base_cache, &ent->ent);
 }
 
-int packed_object_info(struct packed_git *p,
-		       off_t obj_offset, struct object_info *oi)
+static int packed_object_info_with_index_pos(struct packed_git *p, off_t obj_offset,
+					     uint32_t *maybe_index_pos, struct object_info *oi)
 {
 	struct pack_window *w_curs = NULL;
 	unsigned long size;
 	off_t curpos = obj_offset;
 	enum object_type type = OBJ_NONE;
+	uint32_t pack_pos;
 	int ret;
 
 	/*
@@ -1619,16 +1620,35 @@ int packed_object_info(struct packed_git *p,
 		}
 	}
 
-	if (oi->disk_sizep) {
-		uint32_t pos;
-		if (offset_to_pack_pos(p, obj_offset, &pos) < 0) {
+	if (oi->disk_sizep || (oi->mtimep && p->is_cruft)) {
+		if (offset_to_pack_pos(p, obj_offset, &pack_pos) < 0) {
 			error("could not find object at offset %"PRIuMAX" "
 			      "in pack %s", (uintmax_t)obj_offset, p->pack_name);
 			ret = -1;
 			goto out;
 		}
+	}
+
+	if (oi->disk_sizep)
+		*oi->disk_sizep = pack_pos_to_offset(p, pack_pos + 1) - obj_offset;
+
+	if (oi->mtimep) {
+		if (p->is_cruft) {
+			uint32_t index_pos;
+
+			if (load_pack_mtimes(p) < 0)
+				die(_("could not load .mtimes for cruft pack '%s'"),
+				    pack_basename(p));
+
+			if (maybe_index_pos)
+				index_pos = *maybe_index_pos;
+			else
+				index_pos = pack_pos_to_index(p, pack_pos);
 
-		*oi->disk_sizep = pack_pos_to_offset(p, pos + 1) - obj_offset;
+			*oi->mtimep = nth_packed_mtime(p, index_pos);
+		} else {
+			*oi->mtimep = p->mtime;
+		}
 	}
 
 	if (oi->typep) {
@@ -1681,6 +1701,12 @@ int packed_object_info(struct packed_git *p,
 	return ret;
 }
 
+int packed_object_info(struct packed_git *p, off_t obj_offset,
+		       struct object_info *oi)
+{
+	return packed_object_info_with_index_pos(p, obj_offset, NULL, oi);
+}
+
 static void *unpack_compressed_entry(struct packed_git *p,
 				    struct pack_window **w_curs,
 				    off_t curpos,
@@ -2378,7 +2404,8 @@ static int packfile_store_for_each_object_wrapper(const struct object_id *oid,
 		off_t offset = nth_packed_object_offset(pack, index_pos);
 		struct object_info oi = *data->request;
 
-		if (packed_object_info(pack, offset, &oi) < 0) {
+		if (packed_object_info_with_index_pos(pack, offset,
+						      &index_pos, &oi) < 0) {
 			mark_bad_packed_object(pack, oid);
 			return -1;
 		}

-- 
2.53.0.rc1.267.g6e3a78c723.dirty

