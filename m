Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBF942EEAA
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 12:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768999866; cv=none; b=W62yx4Juz5yyVemnCpbLMN9Vze2PLTnO2lwAUTlIf3O6FYaj6mLlTMmgpJ8BNRCdecq86nZs1Etz0qTYGTHYnF4WiyCSxKl7F3VZfsnx24QZdyAAbfWZ/r2SwiSTP9otutKfQyXzMZyucMT51uQ07ExXcp4Qc+ImvlAvaBFI64U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768999866; c=relaxed/simple;
	bh=cX22Lz59DOmBRlVpOFUKjU0Ua6j4TUQYO7IRTJSqNyI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vv9lrJ90w2C8JLrDB59hDaJXHx9jT6/LuW8EGgAekaBfSREtcyHZSeOrFu7OrrLSWCj6xNGLApgKP5O8bC5bo6zg7zgH0NG54WIZ/1caHuJVFz3Vb6fRGkO3LRvobQEoXvRMXLLJcpAmmF/g2Q7+Yo1GtKYnWW1VpT/mIFP4cak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SzC17Zb5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wuK/iati; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SzC17Zb5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wuK/iati"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7A62714001A9;
	Wed, 21 Jan 2026 07:51:03 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 21 Jan 2026 07:51:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768999863;
	 x=1769086263; bh=cqlC/0NUGCsvNBenwTEzqb37rOr0nOHgG6kpQRivtoI=; b=
	SzC17Zb5Fhg+UQfZGXu6uzU7E1mg0NRHXztSTIbDeXthuxNtQvn2ZbZglfT3VMKv
	LP/V+ONEfZY6TBCltkdGNOENqbBDnhISu+/3LrSbqPvkx8PbWahzxCyXRxytkSe+
	Hb/pzDcIaYOT8GYlGJA3k062SGNMpt/QvE4fjFz8WALzxojgqvol49brjbTE9lB6
	E1lZxzIbyrWkGJy/5z6Rox7VPDaEVxw2TkgBUvT8v0vgth5Uo01WfRx0Iu38JX+m
	F97s2c9/xJP1XaIixUEBq7O43/gd6PakKkw9gaR/POw+m+zY4YEBGQA2LGcBiQXl
	jWNWPttiYWWEBNRZH5jOyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768999863; x=
	1769086263; bh=cqlC/0NUGCsvNBenwTEzqb37rOr0nOHgG6kpQRivtoI=; b=w
	uK/iati07zRPGbMDkpDW2w0qRfx4XN8J5K9ICSOl1w0WOT6OfOa5YacOEKX780xc
	1yAlDBA0JbgvJKoEtjjz4prNEnDZouGvd9VqhN5d0eoDJHs+JjxgSe4covTUKpqS
	V3XVMVwlIk7BYI+AcKz6RK1uJIY2LJiahNl8ICWrpeioc51KHs5F6IaycjC25LaN
	SniQZ4Wfvuk5yohf8ZBPt9ovnvDuMcG45xzldXdfotQE4J+gKd8KksCnJH1Rw2SR
	UUfrvnf3eRsDLRfEpWyctUt42/2MdfXhmioyly8anytIePcTH1VeZC+PtwKkSfIv
	CgEUBSNmV178ziC2ih80A==
X-ME-Sender: <xms:tstwaaAEzCzIwdNet0WHGppnjJHGTA8fZfN3ebFmxqUVAV8FrV5iTw>
    <xme:tstwabh4tMVqe-Fq3cwRYx73rk64en4bexiFselAvJ1NyukV0PU0dBIwbavDpdoBW
    _4tCWWrnDQDeDFjThWJztQ0VM91E4syfQHBHrl_LBZR-VLxr8Ny>
X-ME-Received: <xmr:tstwaSnE1plH0f1-b3pH83skfE1CxR2HNdINNvUmQAe8sM8xeCgkHJhVKeOHxnruhDkKMw4ZbEzD-K9dNDhgDTCPppBgLa3w56ggWN2TO7k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeeffedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:tstwaXppmrHCjifVdxebJi-CNJsKjm5YTj9BAgsir5y-n--zqkts5w>
    <xmx:tstwabG6Ow8v5QPB4fCMHP0ZN4Z2FRrHeUEyAIXnEm_ehCn7gPKxfA>
    <xmx:tstwaTzR6w0V_hmk8LTuEQQ8uIvCHsAcmzffzGEBWgGuKLw7zrRsDA>
    <xmx:tstwaQoSnz67ILBWNV6sPA4FVcvG25EHLo-yxfcHEuTgq_j2-aPTQQ>
    <xmx:t8twaQp7ChIDpgBnidECO9Vi-1_aMGH0lvLKvarQ9dFoGCze0cmTIULj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jan 2026 07:51:01 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4b1fd30d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 21 Jan 2026 12:51:00 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 21 Jan 2026 13:50:27 +0100
Subject: [PATCH v3 11/14] odb: introduce mtime fields for object info
 requests
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-pks-odb-for-each-object-v3-11-12c4dfd24227@pks.im>
References: <20260121-pks-odb-for-each-object-v3-0-12c4dfd24227@pks.im>
In-Reply-To: <20260121-pks-odb-for-each-object-v3-0-12c4dfd24227@pks.im>
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

