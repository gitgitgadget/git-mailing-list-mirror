Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16431E47BD
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 09:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729504694; cv=none; b=iuM/bdaK3uIF5Oc2GkiJ9CLnBb4rAaT0h37z2w2JRHXi1VX+lDw12ioaoVVAW+Xrp7Tch/63eFmR2z66PgpQvqKCuA68R2w9Pt+s3PSLwo2EGiZr5flM0N6wJ4dlQcuPcNDHaJIKDOgC3TP06VoE5THjy7GnX3JlJKE3MnvnxC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729504694; c=relaxed/simple;
	bh=B0LPmqiQZmbIJ2g0ar0HuMFFvitzSjh1PgqH5XuHICs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uBgp7uSmHGdCMngajjKuC+Gs37CWzeoH6XPwbt3DvklBfTd7lBpSWuTmDftaq+A6X5WxQjFPg9rSkfo0pUTX6CiM5UJvpmQVxP4L7T+GgMu4He1fxz4anIv+DtA5oJq9n1b19enwuEpo8hvJ4QmFm+8JwAOP7A147PEERZVmXeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j9c6DPBl; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j9c6DPBl"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9a0f198d38so593295666b.1
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 02:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729504690; x=1730109490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fgOJLPuKYismiXzzTbTXEP0D3rDLowvO3vuFa975RDc=;
        b=j9c6DPBl5at+Omwsqc4vmvw8LyVD8xMJH9098NTXdLmQckVWxCv7/o2tlmHcqaGd38
         IRptd8Z6HSV015KFlOvsb7HcMk3Z+OCaysQI40JBPQIWBeo9mrbUjkhDbV0VWvvcthC3
         3qkcfgHheLIYPfmsP2LMIymXRVWZ441W9ZW6EKv+QUJ6kss2PvpciO6Ek/drcEfoQPOv
         tY1RO2fQtibg6hT/wLcdJf6sJNFXxn6cKsalX5bBIOmPFychla8a9cdPsjkvxfXR87ln
         W/DmSy+0B02+wKU0Zu8i2Vk+X7afXO6DoZ5GN0yW8Y0aWfd+zh+qJzoGdQIJhor9VHrT
         BUFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729504690; x=1730109490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fgOJLPuKYismiXzzTbTXEP0D3rDLowvO3vuFa975RDc=;
        b=e8paNeTFjlf7UC0l2RkBvE2/PAYs/bGaNNm1afE6xFKfjd8yMDBz493JUD23aUAPP1
         OHva8v29jrtz4qgXLyn9ZlG0x+2QC8q04Yl9V3bAFEDx4TQ/GGbhucQzbwV3uIyEaPf0
         4V38lTuA7PI0RF4X/ASCseBXOHSGeop9NHaHQSnjXoipyhbnYmzpXYjZ+ByrDFmGfT2S
         ClNG/TMKT/PfPGsSmMUqMSQYLeI3jSos6iDoB4abbkTkQlSGwFzS/Emzt4NRQ1WYjJUL
         nFnucZQm1nMK5RAc/pncLiK0Suh1JmKmb/Hzr2CnGgSDaTHMMVk+TaOEP84jufym4Ez7
         S2zw==
X-Gm-Message-State: AOJu0Yzl9qsPAkvLpMse9ePj/6UMiXAs74RpI4kyGhNren7dROpcTABa
	UqTzW3pANQ0Dx/pM0twYMRUfUuHrYmWF3kAKavkjN879SsEqTSpsZKpsLltu
X-Google-Smtp-Source: AGHT+IEF4+gVxipP89wtuRbu6Sl+DoaKt1OKI/cOG2EFA1s4ogeB+Eqq1FEwFZxz6KR2YUcSMPJAUA==
X-Received: by 2002:a17:907:6e89:b0:a7a:9144:e23a with SMTP id a640c23a62f3a-a9a69c687d8mr1223505366b.43.1729504689822;
        Mon, 21 Oct 2024 02:58:09 -0700 (PDT)
Received: from archlinux.fritz.box ([2a02:2455:825d:6a00:6bb4:436f:5699:ff21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912d631dsm187122266b.17.2024.10.21.02.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 02:58:09 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org
Subject: [PATCH 05/20] packfile: pass down repository to `unpack_object_header`
Date: Mon, 21 Oct 2024 11:57:48 +0200
Message-ID: <655cfebb9d56fe09835985657944f3550b608f3b.1729504641.git.karthik.188@gmail.com>
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

The function `unpack_object_header` currently relies on the global
variable `the_repository`. To eliminate global variable usage in
`packfile.c`, we should progressively shift the dependency on
the_repository to higher layers. Let's remove its usage from this
function and any related ones.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/pack-objects.c |  3 ++-
 pack-bitmap.c          |  3 ++-
 pack-check.c           |  3 ++-
 packfile.c             | 13 ++++++-------
 packfile.h             |  3 ++-
 streaming.c            |  4 ++--
 6 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 26e3090c85..3893135b59 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1033,7 +1033,8 @@ static void write_reused_pack_one(struct packed_git *reuse_packfile,
 			     offset - (hashfile_total(out) - pack_start));
 
 	cur = offset;
-	type = unpack_object_header(reuse_packfile, w_curs, &cur, &size);
+	type = unpack_object_header(the_repository, reuse_packfile, w_curs,
+				    &cur, &size);
 	assert(type >= 0);
 
 	if (type == OBJ_OFS_DELTA) {
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 067d1741d2..96c91a080e 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -2067,7 +2067,8 @@ static int try_partial_reuse(struct bitmap_index *bitmap_git,
 		return -1; /* not actually in the pack */
 
 	delta_obj_offset = offset;
-	type = unpack_object_header(pack->p, w_curs, &offset, &size);
+	type = unpack_object_header(the_repository, pack->p, w_curs, &offset,
+				    &size);
 	if (type < 0)
 		return -1; /* broken packfile, punt */
 
diff --git a/pack-check.c b/pack-check.c
index bb649edbc1..e2c3b264e7 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -127,7 +127,8 @@ static int verify_packfile(struct repository *r,
 		}
 
 		curpos = entries[i].offset;
-		type = unpack_object_header(p, w_curs, &curpos, &size);
+		type = unpack_object_header(the_repository, p, w_curs, &curpos,
+					    &size);
 		unuse_pack(w_curs);
 
 		if (type == OBJ_BLOB && big_file_threshold <= size) {
diff --git a/packfile.c b/packfile.c
index f300119bb1..7a0d1957e9 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1169,9 +1169,8 @@ unsigned long get_size_from_delta(struct repository *repo, struct packed_git *p,
 	return get_delta_hdr_size(&data, delta_head+sizeof(delta_head));
 }
 
-int unpack_object_header(struct packed_git *p,
-			 struct pack_window **w_curs,
-			 off_t *curpos,
+int unpack_object_header(struct repository *r, struct packed_git *p,
+			 struct pack_window **w_curs, off_t *curpos,
 			 unsigned long *sizep)
 {
 	unsigned char *base;
@@ -1185,7 +1184,7 @@ int unpack_object_header(struct packed_git *p,
 	 * the maximum deflated object size is 2^137, which is just
 	 * insane, so we know won't exceed what we have been given.
 	 */
-	base = use_pack(the_repository, p, w_curs, *curpos, &left);
+	base = use_pack(r, p, w_curs, *curpos, &left);
 	used = unpack_object_header_buffer(base, left, &type, sizep);
 	if (!used) {
 		type = OBJ_BAD;
@@ -1332,7 +1331,7 @@ static enum object_type packed_to_object_type(struct repository *r,
 		if (!base_offset)
 			goto unwind;
 		curpos = obj_offset = base_offset;
-		type = unpack_object_header(p, w_curs, &curpos, &size);
+		type = unpack_object_header(r, p, w_curs, &curpos, &size);
 		if (type <= OBJ_NONE) {
 			/* If getting the base itself fails, we first
 			 * retry the base, otherwise unwind */
@@ -1548,7 +1547,7 @@ int packed_object_info(struct repository *r, struct packed_git *p,
 		if (!*oi->contentp)
 			type = OBJ_BAD;
 	} else {
-		type = unpack_object_header(p, &w_curs, &curpos, &size);
+		type = unpack_object_header(r, p, &w_curs, &curpos, &size);
 	}
 
 	if (!oi->contentp && oi->sizep) {
@@ -1736,7 +1735,7 @@ void *unpack_entry(struct repository *r, struct packed_git *p, off_t obj_offset,
 			}
 		}
 
-		type = unpack_object_header(p, &w_curs, &curpos, &size);
+		type = unpack_object_header(r, p, &w_curs, &curpos, &size);
 		if (type != OBJ_OFS_DELTA && type != OBJ_REF_DELTA)
 			break;
 
diff --git a/packfile.h b/packfile.h
index 22d053a3af..488d78ae9f 100644
--- a/packfile.h
+++ b/packfile.h
@@ -169,7 +169,8 @@ void *unpack_entry(struct repository *r, struct packed_git *, off_t, enum object
 unsigned long unpack_object_header_buffer(const unsigned char *buf, unsigned long len, enum object_type *type, unsigned long *sizep);
 unsigned long get_size_from_delta(struct repository *repo, struct packed_git *,
 				  struct pack_window **, off_t);
-int unpack_object_header(struct packed_git *, struct pack_window **, off_t *, unsigned long *);
+int unpack_object_header(struct repository *repo, struct packed_git *,
+			 struct pack_window **, off_t *, unsigned long *);
 off_t get_delta_base(struct packed_git *p, struct pack_window **w_curs,
 		     off_t *curpos, enum object_type type,
 		     off_t delta_obj_offset);
diff --git a/streaming.c b/streaming.c
index 58b3b3cff7..56154349fa 100644
--- a/streaming.c
+++ b/streaming.c
@@ -334,7 +334,7 @@ static int close_istream_pack_non_delta(struct git_istream *st)
 }
 
 static int open_istream_pack_non_delta(struct git_istream *st,
-				       struct repository *r UNUSED,
+				       struct repository *r,
 				       const struct object_id *oid UNUSED,
 				       enum object_type *type UNUSED)
 {
@@ -343,7 +343,7 @@ static int open_istream_pack_non_delta(struct git_istream *st,
 
 	window = NULL;
 
-	in_pack_type = unpack_object_header(st->u.in_pack.pack,
+	in_pack_type = unpack_object_header(r, st->u.in_pack.pack,
 					    &window,
 					    &st->u.in_pack.pos,
 					    &st->size);
-- 
2.47.0

