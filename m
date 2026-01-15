Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A4C37417F
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 11:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768475132; cv=none; b=sx3aLEEjtIOkGMzIBz6V3fmXQJjk002v09ATobaGh/h77r1aqOWoLGvF92dYkKmbnKroiQeXjaO+wPRKR8WAtuGZcYDTqy3Gk3GI2R19UIfSBGlJEbi1pnwbIe1nrlFRha6dSC78oXDnZgvVnGqdwh2irfZN2XHZbm2F8QOnQaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768475132; c=relaxed/simple;
	bh=4JQKQT2GBPuDiiIDw61mx8PTNAyuNyBehmryjPSHTng=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FvXFIzbMFijhxe+bwSzZ8ELgjZURgVCQPHf/S+2vMb2U8SHqWfi71qCUP2p347JGfsAuFW9lZpLvmVzw6XxIR3aqRnwREOXFqn+hPUtkKeSDm+RDNuImPQ05mMDLibD8CqT9zlaMpDNU/pg/h16iUc8HrHY9h5lJjg0yA3vTuJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FnT73qvA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MFeR/i47; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FnT73qvA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MFeR/i47"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id B35321D000EE
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 06:05:24 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 15 Jan 2026 06:05:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768475124;
	 x=1768561524; bh=gXH8HWfMrAjRq9r3ewKH5yG18paiqwZvApWEjt4X/2Y=; b=
	FnT73qvAKYfdwbWVvOBAX0BgFNTEuzhLG1avNoLrcwUXJyaK5d4AjEPdMyzCu2LV
	+NFm3fwDDk1gZAUSDr9xjQu5kiKFUPhD5OlLSLdJLfY9yRo5mmdiob3Q66kcqNQY
	NwFp6Cq+YKt0n+frtZvWWQI5oiW1V5F3nqHzjm50PM9tNwHd/QWEonuxKGdNOdvA
	znbJ6/vNVP9tVbYUmVAF0o76xBZnUv/WQ2U7L2guVbhR8GcF6NZ6l3LgLk3bdzY0
	qaEmF3RQc1nXofhDlGv4Bog9EH0PDTl3nTpLbGImcr69UN7tlJ09n7wCkbXoswFt
	OGpNgiT7A3UkvYp6dcZZ0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768475124; x=
	1768561524; bh=gXH8HWfMrAjRq9r3ewKH5yG18paiqwZvApWEjt4X/2Y=; b=M
	FeR/i47Ij3S1we8A24W+Zd+Mc6KfKCT9XqwpeJQqJOLZMGD6uUanXqf5lQAxqsUC
	ldw5DIMLxWTx+cQeEEkCi2ZdtqoNjkWwPK98H6SiZPLjosByL7KbBj5gEVKrQX5p
	ytM8h+wuvivtVs7yTos5XRhkLLOuKfMX5yCK2mF8yj+KdpRs2xA6aOnHW+59vmS6
	waeWW2oANHK7aAGS6g8jvzLW9RZI7BF2xeqcZYkf0yTlKbQaVkm3fPib8GyakitB
	RRxvPuehLgPc+FRW1xp6jzLJq2v8YD9oi1mmx6b8TJGTrazis25R10lw7N5IHano
	ufSoohSnklLetw2yVdE+A==
X-ME-Sender: <xms:9MloaR0POGQwWYL7ypvnA-9_uyD-XNqVAhZpunqE7Cr-oNnDBWQusQ>
    <xme:9MloafCRzsQMaeRxJYEpKqLy1VaBvbgEzaEqwX1gLx7kEqnMqPYRtS0ti8fwj78xw
    2pUQzhSw-Z3jgvS9c9-9n1Z0ePNfBCLX_6u9IFmHdlXvgYMojzEIA>
X-ME-Received: <xmr:9MloaXgudIgYsu0e3W9emeK7fLyykT4OAinyNFvV56ASpKPcLe8-HfaS92waERESo4_8bB49AmeIeJUPBHNFKikH292dl8UoURBt2rQuP2Sa3A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdehkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:9MloaT8aTcpMJZGJNhJwYqJYECqT84c6ffL5C6T-dCoTxr-HDmYcAQ>
    <xmx:9MloaT-8od1UAGlF6LYKsUFiqAAuLvF4auxeUhmrSd1p-6XzgkPzuw>
    <xmx:9MloacCtvJrKx1jtW6qgEUFi79EfX42NV31JK-s7-ZyF3gfnVKgXKg>
    <xmx:9MloaTyEbyKM3PT46BYuARmC2NfPnSGptSm99DMvefNMbW1ePdfKzw>
    <xmx:9MloaXF3SN5KRz5EhgBcMjEllELue_pQwFwf8xCBfBw0-SzjIYNf7Lz4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 15 Jan 2026 06:05:24 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6014637e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 15 Jan 2026 11:05:23 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 15 Jan 2026 12:04:40 +0100
Subject: [PATCH 11/14] odb: introduce mtime fields for object info requests
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-pks-odb-for-each-object-v1-11-5418a91d5d99@pks.im>
References: <20260115-pks-odb-for-each-object-v1-0-5418a91d5d99@pks.im>
In-Reply-To: <20260115-pks-odb-for-each-object-v1-0-5418a91d5d99@pks.im>
To: git@vger.kernel.org
Cc: 
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
index 8f6d95aee5..9e22f79172 100644
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
2.52.0.660.gd05f3a8ea5.dirty

