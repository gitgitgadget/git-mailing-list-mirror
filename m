Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C424944D6BC
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 15:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768922811; cv=none; b=uNMjWM8QG2lOyhh4he3UO2H+zIwT1VBn5Qf6T53tHS246ScJv/F5MJUCda28mYg1iY8lPErNyaraotId+o5yS5jEOFl6d5QpXkaEci65jI0v01wroxBclJW+Oe9x3Tg4KG7xdar53/ViZDf8oqeUaDwUtWwDopcEzeHUwF0DfqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768922811; c=relaxed/simple;
	bh=cX22Lz59DOmBRlVpOFUKjU0Ua6j4TUQYO7IRTJSqNyI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GOOAotmj/EHo/PpC9qMldL+HTMGnwkGiWkLhOScD9DkcJxu2l13d6ibVXNHQ70fY8EPG50s39QxxUcTuCHZTnLIQ9K1y8H9ffJvK1aGa5KuYO6v1rfNl7MBtHbTybsHFF1dXXb6m++wVd5SO5bhT727H87+b9nDwHT2sLwsjJ8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=f1U0HfDd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vjUsdkGS; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="f1U0HfDd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vjUsdkGS"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F07E77A00D1;
	Tue, 20 Jan 2026 10:26:46 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 20 Jan 2026 10:26:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768922806;
	 x=1769009206; bh=cqlC/0NUGCsvNBenwTEzqb37rOr0nOHgG6kpQRivtoI=; b=
	f1U0HfDdF9vtcdVDXeRPzL1nEqBATqEDSMBSf2LJDiT/jh5wLG6S8g/6qFhMxd/z
	rXyXZXTa1Hgzl6kzVPyp3XuiKxUf8VGNuDBgjmSO3m3jV3kAVb4VG6EnbVwZcFKO
	4Qt231pqiMYUJQsIsLOkl9pc/vhVZ9IJPaYZI88cufBGJLcLu6TggG4NAqVrnQ83
	XHzPcMe4+4CHJZCxpyaBJUbH4x3+2U8K9vZw9rMClAI9A3FLb0o1iEYZ3sEUMZjS
	9IWrfqWBWVoKXjKR3yjdWJun7k9rDGucB+c/39zon1sUGPEn7AIbBZ+95mKgKAXw
	w/Pix5f3sAqMjgk4rZMybg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768922806; x=
	1769009206; bh=cqlC/0NUGCsvNBenwTEzqb37rOr0nOHgG6kpQRivtoI=; b=v
	jUsdkGS4yu9fyC+J3Vhxic47SfYgIrD7kkp2t0uqWfbIcLjLZx7XzHit3107HJsB
	7PXt2OENXKs1soYil+ZvUm+OinE2ihyzn0Ta2c3Tga2g+I9/77NLGksewMWxgQ8F
	PvlxGO2ItYJlOBBW6bwGUdNOO2gzc5LSZnmJYO2lLY0I8MXZI04pZTvDQeDpGY7D
	A2R/yGeWibanu1jpuIh8bOINDWRCyfNVSqVJhVzA+fBsrSJ7G5T3//AMEUzjiKCd
	flp0e5EXeHt+trcVliSW3bG4LbVIDDtzodgIE/oufQeuDfxJjp/aIGb4vVaMWQip
	zr6ZOiyKjS4GTECqQcd4A==
X-ME-Sender: <xms:tp5vaa6Nshet9aFDdseF5vm68yFcwNm3w54WLggOE_cNoG8-s9XBiQ>
    <xme:tp5vaa5n52WpdIOGfh_yD4qFeDEIhtNMHvY4qdtoq_zYVtewfiwvbThqH4xlVjpUZ
    J_8I4yNcfbnBFbPd1Q70n85n2M74FHvUh34Ey52g2mMcUzWFCHc2w>
X-ME-Received: <xmr:tp5vaeeG_zDIx8vBf7MrigLdLvEXtk74klRG5ywCDMg7tq93VC_qVWwisdp7YGpoBJi2W_wr4iTlKME-pvxi0HEye663H7iejtPSqls3DA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugedtjeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpeejnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:tp5vaWAIFPhwEok5TGSV89lfsCtNzC80bElsPiEaz99Koz8vUgCPQg>
    <xmx:tp5vaZ8Gz0Uj9eENNBV9zBzquDS5AlBy0o-SYnKcuflgscxDsr4fbA>
    <xmx:tp5vaZL5QgRw8HUY8Ba2Fto5l62XXKOYbU5RG-TNXfFdekgT6O6PCA>
    <xmx:tp5vaaiCQDPbbPDfwUCDlQnCST9-icFMDVdZFdkpuCy3Fs2_FBlUBQ>
    <xmx:tp5vad-zcq4UgrfKPKvDuyYEqeBYo_qBU6ZMP0j1O9Oj-iu7e88hkaQN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jan 2026 10:26:45 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 09c8069a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 20 Jan 2026 15:26:44 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 20 Jan 2026 16:26:07 +0100
Subject: [PATCH v2 11/14] odb: introduce mtime fields for object info
 requests
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260120-pks-odb-for-each-object-v2-11-d05cbfd3d6f8@pks.im>
References: <20260120-pks-odb-for-each-object-v2-0-d05cbfd3d6f8@pks.im>
In-Reply-To: <20260120-pks-odb-for-each-object-v2-0-d05cbfd3d6f8@pks.im>
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

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c | 29 +++++++++++++++++++++++++----
 odb.c         |  2 ++
 odb.h         |  1 +
 packfile.c    | 40 +++++++++++++++++++++++++++++++++-------
 4 files changed, 61 insertions(+), 11 deletions(-)

diff --git a/object-file.c b/object-file.c
index 65e730684b..c0f896673b 100644
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
index 65f0447aa5..67decd3908 100644
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
index 8a37fe08e0..68336d2730 100644
--- a/odb.h
+++ b/odb.h
@@ -317,6 +317,7 @@ struct object_info {
 	off_t *disk_sizep;
 	struct object_id *delta_base_oid;
 	void **contentp;
+	time_t *mtimep;
 
 	/* Response */
 	enum {
diff --git a/packfile.c b/packfile.c
index 4f84bc19d9..c96ec21f86 100644
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
@@ -1619,16 +1620,34 @@ int packed_object_info(struct packed_git *p,
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
+				die(_("could not load cruft pack .mtimes"));
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
@@ -1681,6 +1700,12 @@ int packed_object_info(struct packed_git *p,
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
@@ -2377,7 +2402,8 @@ static int packfile_store_for_each_object_wrapper(const struct object_id *oid,
 	if (data->oi) {
 		off_t offset = nth_packed_object_offset(pack, index_pos);
 
-		if (packed_object_info(pack, offset, data->oi) < 0) {
+		if (packed_object_info_with_index_pos(pack, offset,
+						      &index_pos, data->oi) < 0) {
 			mark_bad_packed_object(pack, oid);
 			return -1;
 		}

-- 
2.53.0.rc0.250.g0ac79233d6.dirty

