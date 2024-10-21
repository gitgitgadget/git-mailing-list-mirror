Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D131E4929
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 09:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729504695; cv=none; b=lhVCxgsUK2J/u8AigbisF3TyTmHPivDBZZrNRKr3Ig1BURZhnXGJrSHaKKeZHqjwnggmQAR1HzVKBKLjfVZz4cC0JsXW7Jq42pXd4j/jpGcLbDUXmuVwRTmYtfEFuShXyZ93f8JysmEDBmj0bpWtF2Wtc/9EL8koDLZXPueGw8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729504695; c=relaxed/simple;
	bh=niUINvO1vNuxjzBti+OmNsuy/SGu7NurEpumxp14UgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nPxl78lp4DxCNRkcCMYobv/wflIZs0oe9whJzsLhR+qOYvCnJZqP+ihpMWjvNusibJFJYj5yK3oqabsYY1YZDQOg5iiQ2oYvnO2UAACE+0l9qggWcAfulvUhybzV1fuowbOHE4C9tp2j/3kDkR1cSn3R+E+HG2YP8C3byZTUT6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lqgvs0is; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lqgvs0is"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c9709c9b0cso5632164a12.1
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 02:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729504691; x=1730109491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q7jiJAi81XdzHW64+d9MwKxMmLDfXaobr0ej0UgT+EA=;
        b=Lqgvs0isyycuKzhMdbA74wLEHKPOPP6YYdf/Yf4SbywgwTm/Fd5NhXSMNosAg+f1jJ
         bDP82QI4BcEr+xHrxIkfU2wjuJbFJG/Pcc7g217qGUCcBNab4zGdyTkSYmgwbU4IG0ew
         HJWrqjhrBc7Z6TcN9sko+OpO81Or4h4E40hOt2U1vlKvGqO1Eas6eLW1fAuwwS3eSTnp
         ZkAzP6ghtDOapCUAO/02TZ53qSkRvqZZu6LAX3yeq9tv6Nr9HsgpH6g/qN4kPtzDlARV
         6eQULEUFf21HW1Dr+kklJQRJKf2h7u5mA66U6i6OWLJVx3X8TMLUmEzGPNWUha8/RCwl
         b7+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729504691; x=1730109491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q7jiJAi81XdzHW64+d9MwKxMmLDfXaobr0ej0UgT+EA=;
        b=Q4g6e4jsYvfq6UfUaL7iu79qfD6eX1DBLjeEowqvm1UfGIlQGzhVicBK/nm/Pjaa2D
         GvJGqHj2nxZVDeHn44NZ2yCS9lMwiD+Dw6RUvoW1JWzNkDx/jCEpNMIs2QZzEqO7kwFd
         XNm3Z99fe4R11xz5Y4xsJ0IyjJTBi8ISly3sp1/M3acv8khZFlsTi2XKLlOn3iDRRtCa
         iHgl55gfdXY0Z5tVBNBuS1E+e0G1oKIweDTacI+JkoG4tetyvc7dP+gqLLZobS/5FYCb
         LGECVqcrWCxr9nLw+nn2RFF8l7X0gxupyDoGAVe4+4cBbRg5kje9IoKwE74KfZl58r7q
         jLmA==
X-Gm-Message-State: AOJu0YxtK2dzXPedWLSdu7sETNzmWOxbK6lwK7FIZbe5PSHt1WiwLZaD
	eyDw/LPRh2Nm4WAtiaHqUlXToO23jLYmf6gcGmMG+UdzSS7dwtkLh3+5aMpN
X-Google-Smtp-Source: AGHT+IFCpylEsgZch27huftmmCAzNC/oJkGbSyky4HaYkf/1sjJZu7Bx5vEDdrvexma7IXxSiHpVww==
X-Received: by 2002:a17:907:3d88:b0:a99:f8a2:cd8f with SMTP id a640c23a62f3a-a9a69cdcacamr904314766b.64.1729504690953;
        Mon, 21 Oct 2024 02:58:10 -0700 (PDT)
Received: from archlinux.fritz.box ([2a02:2455:825d:6a00:6bb4:436f:5699:ff21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912d631dsm187122266b.17.2024.10.21.02.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 02:58:10 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org
Subject: [PATCH 06/20] packfile: pass down repository to `get_delta_base`
Date: Mon, 21 Oct 2024 11:57:49 +0200
Message-ID: <18fa001e3a8c1ffa75b818d9918e8c8bbea261cf.1729504641.git.karthik.188@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729504640.git.karthik.188@gmail.com>
References: <cover.1729504640.git.karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function `get_delta_base` currently relies on the global variable
`the_repository`. To eliminate global variable usage in `packfile.c`, we
should progressively shift the dependency on the_repository to higher
layers. Let's remove its usage from this function and any related ones.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/pack-objects.c |  3 ++-
 pack-bitmap.c          |  4 ++--
 packfile.c             | 42 ++++++++++++++++++++----------------------
 packfile.h             |  6 +++---
 4 files changed, 27 insertions(+), 28 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 3893135b59..a10eae239e 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1044,7 +1044,8 @@ static void write_reused_pack_one(struct packed_git *reuse_packfile,
 		unsigned char header[MAX_PACK_OBJECT_HEADER];
 		unsigned len;
 
-		base_offset = get_delta_base(reuse_packfile, w_curs, &cur, type, offset);
+		base_offset = get_delta_base(the_repository, reuse_packfile,
+					     w_curs, &cur, type, offset);
 		assert(base_offset != 0);
 
 		/* Convert to REF_DELTA if we must... */
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 96c91a080e..d959e30682 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -2085,8 +2085,8 @@ static int try_partial_reuse(struct bitmap_index *bitmap_git,
 		 * and the normal slow path will complain about it in
 		 * more detail.
 		 */
-		base_offset = get_delta_base(pack->p, w_curs, &offset, type,
-					     delta_obj_offset);
+		base_offset = get_delta_base(the_repository, pack->p, w_curs,
+					     &offset, type, delta_obj_offset);
 		if (!base_offset)
 			return 0;
 
diff --git a/packfile.c b/packfile.c
index 7a0d1957e9..ee46898b35 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1210,13 +1210,11 @@ const struct packed_git *has_packed_and_bad(struct repository *r,
 	return NULL;
 }
 
-off_t get_delta_base(struct packed_git *p,
-		     struct pack_window **w_curs,
-		     off_t *curpos,
-		     enum object_type type,
-		     off_t delta_obj_offset)
+off_t get_delta_base(struct repository *repo, struct packed_git *p,
+		     struct pack_window **w_curs, off_t *curpos,
+		     enum object_type type, off_t delta_obj_offset)
 {
-	unsigned char *base_info = use_pack(the_repository, p, w_curs, *curpos, NULL);
+	unsigned char *base_info = use_pack(repo, p, w_curs, *curpos, NULL);
 	off_t base_offset;
 
 	/* use_pack() assured us we have [base_info, base_info + 20)
@@ -1243,7 +1241,7 @@ off_t get_delta_base(struct packed_git *p,
 	} else if (type == OBJ_REF_DELTA) {
 		/* The base entry _must_ be in the same pack */
 		base_offset = find_pack_entry_one(base_info, p);
-		*curpos += the_hash_algo->rawsz;
+		*curpos += repo->hash_algo->rawsz;
 	} else
 		die("I am totally screwed");
 	return base_offset;
@@ -1255,22 +1253,19 @@ off_t get_delta_base(struct packed_git *p,
  * the final object lookup), but more expensive for OFS deltas (we
  * have to load the revidx to convert the offset back into a sha1).
  */
-static int get_delta_base_oid(struct packed_git *p,
-			      struct pack_window **w_curs,
-			      off_t curpos,
-			      struct object_id *oid,
-			      enum object_type type,
+static int get_delta_base_oid(struct repository *repo, struct packed_git *p,
+			      struct pack_window **w_curs, off_t curpos,
+			      struct object_id *oid, enum object_type type,
 			      off_t delta_obj_offset)
 {
 	if (type == OBJ_REF_DELTA) {
-		unsigned char *base = use_pack(the_repository, p, w_curs,
-					       curpos, NULL);
-		oidread(oid, base, the_repository->hash_algo);
+		unsigned char *base = use_pack(repo, p, w_curs, curpos, NULL);
+		oidread(oid, base, repo->hash_algo);
 		return 0;
 	} else if (type == OBJ_OFS_DELTA) {
 		uint32_t base_pos;
-		off_t base_offset = get_delta_base(p, w_curs, &curpos,
-						   type, delta_obj_offset);
+		off_t base_offset = get_delta_base(repo, p, w_curs, &curpos, type,
+						   delta_obj_offset);
 
 		if (!base_offset)
 			return -1;
@@ -1327,7 +1322,8 @@ static enum object_type packed_to_object_type(struct repository *r,
 		}
 		poi_stack[poi_stack_nr++] = obj_offset;
 		/* If parsing the base offset fails, just unwind */
-		base_offset = get_delta_base(p, w_curs, &curpos, type, obj_offset);
+		base_offset = get_delta_base(r, p, w_curs, &curpos, type,
+					     obj_offset);
 		if (!base_offset)
 			goto unwind;
 		curpos = obj_offset = base_offset;
@@ -1553,8 +1549,9 @@ int packed_object_info(struct repository *r, struct packed_git *p,
 	if (!oi->contentp && oi->sizep) {
 		if (type == OBJ_OFS_DELTA || type == OBJ_REF_DELTA) {
 			off_t tmp_pos = curpos;
-			off_t base_offset = get_delta_base(p, &w_curs, &tmp_pos,
-							   type, obj_offset);
+			off_t base_offset = get_delta_base(r, p, &w_curs,
+							   &tmp_pos, type,
+							   obj_offset);
 			if (!base_offset) {
 				type = OBJ_BAD;
 				goto out;
@@ -1600,7 +1597,7 @@ int packed_object_info(struct repository *r, struct packed_git *p,
 
 	if (oi->delta_base_oid) {
 		if (type == OBJ_OFS_DELTA || type == OBJ_REF_DELTA) {
-			if (get_delta_base_oid(p, &w_curs, curpos,
+			if (get_delta_base_oid(r, p, &w_curs, curpos,
 					       oi->delta_base_oid,
 					       type, obj_offset) < 0) {
 				type = OBJ_BAD;
@@ -1739,7 +1736,8 @@ void *unpack_entry(struct repository *r, struct packed_git *p, off_t obj_offset,
 		if (type != OBJ_OFS_DELTA && type != OBJ_REF_DELTA)
 			break;
 
-		base_offset = get_delta_base(p, &w_curs, &curpos, type, obj_offset);
+		base_offset = get_delta_base(r, p, &w_curs, &curpos, type,
+					     obj_offset);
 		if (!base_offset) {
 			error("failed to validate delta base reference "
 			      "at offset %"PRIuMAX" from %s",
diff --git a/packfile.h b/packfile.h
index 488d78ae9f..050dc516b1 100644
--- a/packfile.h
+++ b/packfile.h
@@ -171,9 +171,9 @@ unsigned long get_size_from_delta(struct repository *repo, struct packed_git *,
 				  struct pack_window **, off_t);
 int unpack_object_header(struct repository *repo, struct packed_git *,
 			 struct pack_window **, off_t *, unsigned long *);
-off_t get_delta_base(struct packed_git *p, struct pack_window **w_curs,
-		     off_t *curpos, enum object_type type,
-		     off_t delta_obj_offset);
+off_t get_delta_base(struct repository *repo, struct packed_git *p,
+		     struct pack_window **w_curs, off_t *curpos,
+		     enum object_type type, off_t delta_obj_offset);
 
 void release_pack_memory(size_t);
 
-- 
2.47.0

