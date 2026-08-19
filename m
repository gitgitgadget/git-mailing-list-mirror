Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830E73CF039
	for <git@vger.kernel.org>; Wed, 19 Aug 2026 12:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787141874; cv=none; b=UJ2bQOm9OUillU2MW8pS4lEPo9bwH+6BXE5XIVyjYBvo1XL+91DXIeQi9Ufy8oGWzcTB4+yskvpuDRoUuhCrTsIptEHy18+zgvtSXjgx1xF7M0MLakKKg3c0/37nf+SDTarW7hymetfUtqa1AEFywLBm/TFhmkNuV5WwMa5Pqvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787141874; c=relaxed/simple;
	bh=U5q3dS1pJwsRoKYew4bO8RZoJo5esWt4fqqb1qBhXbw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kxG6y2m4H0Hg7Upfkpf7dSCCKQdT+v6mPBzk+XVTJnp6LipvZgceewZbEsPz+R76/fCr0OoPPymAq4oZoI32NScPw40ojHGMI+WJA9OicXVf1O2bD93632iui38q+DB8YhKQVWTf+0vhljVST96EktRS9UiUu71krvb72efo1oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=knF27nea; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IT7Q1Qm3; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="knF27nea";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IT7Q1Qm3"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id BB63CEC0175;
	Wed, 19 Aug 2026 08:17:51 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 19 Aug 2026 08:17:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787141871;
	 x=1787228271; bh=ColIpH4Ls6+TCPQ+C6Z8niy0ouD4+OZHl5Se6ASpVE0=; b=
	knF27neaNYZLhG5ehhyJ8nfWwA/ulZT3/kQjY9bL4GM1vibwVgw0IwWcvR1NVcc2
	IYkSeBj/1WmkHg0fR9hPJWrX3euycH9fnV6TXJrZ2as4c5lYz0JuyxnROPxQhJv0
	DaDrbja4acIJeOJ7EhwowQRvZk7B7/7wWsVPY+hbVeFm5MweopZo3I9xkPa5KCH8
	9rKX91ZA3weRGQh0ju7wNadqSjgyRECOfwE4+0y409SqxiMYRz8PGpVahPOsbVXK
	+ibJq9E4KEUsAmxE05O5Uz5ctjU5o4s8yT1lNHR4qHQGnP5abjdSGFGSEjc1dP/e
	8lbeCfQSam9zxdoYIRJGgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787141871; x=
	1787228271; bh=ColIpH4Ls6+TCPQ+C6Z8niy0ouD4+OZHl5Se6ASpVE0=; b=I
	T7Q1Qm35b1Z3OC/WSHka2tUKpEXEDzTQZevcNKpnZG4qlTZsh6/kf1JhiOyy8pdO
	+/cPPEY7jAPowSXcLdVcNdg1wtq+Ghvqf/vNAJU0Y8oeXJ/0l6K85NQwuI+OBOdl
	hgLVVvxRyzEoWym4OkBrTWrJX3H9WxF4Q7R69g3crdt3IWhySJ4GCOqGHJtXM7zV
	kcvH99EA3t/CnZSH8LJWSx5xbk1yj2oUcljVEYsQUP2nTlsKHWunay7S93DxX9mk
	f3AjvVk03iBWCSwGwwvdic+RekgfDMsjG12LeoMCsVLOyySufTO8HN6OdWoYsOLq
	nwahxLZjzm2kvI2lk94Yg==
X-ME-Sender: <xms:756Faq44Z7GdCDBCkq7FDUMA9PKSnhSCidOhzI9w0Rzd3bGhVMersg>
    <xme:756Fap4V20LblhJ7mVdufM9UAnSZO3h3mbo3QcCwWFXOrDiHqvchuV3HDVACW1ZG9
    PHzDlL8Rml62Bo2InTTOhkDlTQT0x0I2uD_IFcFYJ_Nv5JqauS3Qg>
X-ME-Received: <xmr:756FanEepXLzPbVpmf7BH5wg4DFIgcB6rzPq3EM4Pwpi28KCxW57jxm7zBImusJZCq8ddHveQjQpUar4XKheHceZHQeOWlORvG_ukPiK>
X-ME-Proxy-Cause: dmFkZTFt3KbsDQuBL7cFlReuI8sAuUXG1gDaCOmZir1zJuMHZiy99MhcYTSDjVTcjs4k+p
    OaeHKDAf4waq9z0KwfVNDjXq7SKVCHbtyhY6URXzzz/mbkLU5md4FwNSnpyeGLl3T/xaRC
    0TwIzFL+o6vUmA0j/iq01Wg+CMdFzetPi85mwEGxYmtyHy3Xp9U5TSxv+g839sV4gNCXEf
    Pv5k5EGXDNHpMTHb121ZZB7K2Cw89g2MkQgzvQL0RpvUH6WI4MzrO1mGvHHyVhnbWt2bnl
    SekELlC8gVrP5RVFYrzxJXeUMXnPspPKcWdKAxT/6PHFmFlkOcBLKXnyjO75NLnPc8gChE
    InYWia28yKajAYU9G076PmPDeP6LDHjymFfm7DEpAFjmHFirgLTLu/yhQ8k++EjPaNiM/V
    QKLy2OP+oFj/LDyVvWCzKu0jC4FOJM9CWzZVfiXQzdL+YDq/XUJkXf2WmVoOzBMN1+5KFG
    3pyLWDMliSmQkXY8JrgfRsu/QOvd5ERLVE5Ew8XexZQoj4w97s5qhrArNSOOLoWPlGdL25
    pps8lRWmyqpD8RxxeyTXnalt1sWWYFdqJbifLn8fLei1ZXxtqRz1DyrKrJMoh06JVeUe9S
    inv0AJINmmjfEelUHTKhCf0FMp862OAr08ir5MulpGjfOktT2t2BKCvoXksw
X-ME-Proxy: <xmx:756FaiTFrV9aQlWKI831ucPoc0MDKag_Oz0faLpF_FR-P-otmoDlXg>
    <xmx:756FagvGEbtwj_0YDXNXsp5-d6IhybXkjIPw0tFjqYMI9uF7iPZj2g>
    <xmx:756FahwgO1iL8vRJyb4oqfOdiom86aKigsc9xehvxnfK04JTkTBR0A>
    <xmx:756Faq6Gam3UIN_OKlZBFzQknBDR3g_Pynhyuq8PFb8G0auteQZiaw>
    <xmx:756FauQ13OAPwhR_wCk6URoTtaOdWmcPN-KaYaWkPIgQ4W2hSszfDCe7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Aug 2026 08:17:50 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 117814b4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 19 Aug 2026 12:17:49 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 19 Aug 2026 14:17:19 +0200
Subject: [PATCH v2 1/5] odb/source-packed: flag known-bad objects as
 corrupt and not missing
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-pks-odb-generic-corrupt-objects-v2-1-a984e3a0ad6f@pks.im>
References: <20260819-pks-odb-generic-corrupt-objects-v2-0-a984e3a0ad6f@pks.im>
In-Reply-To: <20260819-pks-odb-generic-corrupt-objects-v2-0-a984e3a0ad6f@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

When reading packed objects we know to tell apart missing objects and
corrupt objects by returning a positive error code in the former case,
and a negative one in the latter case. We do that by distinguishing
between errors returned by `find_pack_entry()`, which yields the offset
of the object, and `packed_object_info()`, which reads the object
contents.

But even though we already distinguish those cases when reading packed
objects, the logic is broken in case a caller tries to read an object
that has been marked as corrupt. In that case, `find_pack_entry()` will
tell us that the object in question does not exist, and consequently
we'll not flag the object as corrupt but as missing.

Fix this issue by bubbling up whether the object is corrupt and, if so,
which packfile contains the corrupted object.

Note that we don't yet need the information about the specific packfile,
so we could've just as well made this a `bool *corrupted` pointer. But
we'll need information about the containing packfile in a subsequent
commit so that we can generate a proper error message telling the user
which packfile contains the broken object.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/pack-objects.c    |  2 +-
 midx.c                    | 10 +++++++---
 midx.h                    |  3 ++-
 odb/source-packed.c       | 22 ++++++++++++++++------
 packfile.c                | 10 +++++++---
 packfile.h                |  3 ++-
 t/helper/test-read-midx.c |  2 +-
 7 files changed, 36 insertions(+), 16 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 1ec5b6f206..10c2471024 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1786,7 +1786,7 @@ static int want_object_in_pack_mtime(const struct object_id *oid,
 		struct multi_pack_index *m = get_multi_pack_index(files->packed);
 		struct pack_entry e;
 
-		if (m && fill_midx_entry(m, oid, &e)) {
+		if (m && fill_midx_entry(m, oid, &e, NULL)) {
 			want = want_object_in_pack_one(e.p, oid, exclude, found_pack, found_offset, found_mtime);
 			if (want != -1)
 				return want;
diff --git a/midx.c b/midx.c
index 76c3f92cc3..37f082dbdd 100644
--- a/midx.c
+++ b/midx.c
@@ -591,7 +591,8 @@ uint32_t nth_midxed_pack_int_id(struct multi_pack_index *m, uint32_t pos)
 
 int fill_midx_entry(struct multi_pack_index *m,
 		    const struct object_id *oid,
-		    struct pack_entry *e)
+		    struct pack_entry *e,
+		    struct packed_git **bad_pack)
 {
 	uint32_t pos;
 	uint32_t pack_int_id;
@@ -618,8 +619,11 @@ int fill_midx_entry(struct multi_pack_index *m,
 		return 0;
 
 	if (oidset_size(&p->bad_objects) &&
-	    oidset_contains(&p->bad_objects, oid))
+	    oidset_contains(&p->bad_objects, oid)) {
+		if (bad_pack && !*bad_pack)
+			*bad_pack = p;
 		return 0;
+	}
 
 	e->offset = nth_midxed_offset(m, pos);
 	e->p = p;
@@ -1028,7 +1032,7 @@ int verify_midx_file(struct odb_source_packed *source, unsigned flags)
 
 		nth_midxed_object_oid(&oid, m, pairs[i].pos);
 
-		if (!fill_midx_entry(m, &oid, &e)) {
+		if (!fill_midx_entry(m, &oid, &e, NULL)) {
 			midx_report(_("failed to load pack entry for oid[%d] = %s"),
 				    pairs[i].pos, oid_to_hex(&oid));
 			continue;
diff --git a/midx.h b/midx.h
index 939c18e588..1f2f2d5321 100644
--- a/midx.h
+++ b/midx.h
@@ -117,7 +117,8 @@ uint32_t nth_midxed_pack_int_id(struct multi_pack_index *m, uint32_t pos);
 struct object_id *nth_midxed_object_oid(struct object_id *oid,
 					struct multi_pack_index *m,
 					uint32_t n);
-int fill_midx_entry(struct multi_pack_index *m, const struct object_id *oid, struct pack_entry *e);
+int fill_midx_entry(struct multi_pack_index *m, const struct object_id *oid,
+		    struct pack_entry *e, struct packed_git **bad_pack);
 int midx_contains_pack(struct multi_pack_index *m,
 		       const char *idx_or_pack_name);
 int midx_layer_contains_pack(struct multi_pack_index *m,
diff --git a/odb/source-packed.c b/odb/source-packed.c
index 0890704e76..16fa4f5769 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -13,18 +13,19 @@
 
 static int find_pack_entry(struct odb_source_packed *store,
 			   const struct object_id *oid,
-			   struct pack_entry *e)
+			   struct pack_entry *e,
+			   struct packed_git **bad_pack)
 {
 	struct packfile_list_entry *l;
 
 	odb_source_prepare(&store->base, 0);
-	if (store->midx && fill_midx_entry(store->midx, oid, e))
+	if (store->midx && fill_midx_entry(store->midx, oid, e, bad_pack))
 		return 1;
 
 	for (l = store->packs.head; l; l = l->next) {
 		struct packed_git *p = l->pack;
 
-		if (!p->multi_pack_index && packfile_fill_entry(p, oid, e)) {
+		if (!p->multi_pack_index && packfile_fill_entry(p, oid, e, bad_pack)) {
 			if (!store->skip_mru_updates)
 				packfile_list_prepend(&store->packs, p);
 			return 1;
@@ -40,6 +41,7 @@ static int odb_source_packed_read_object_info(struct odb_source *source,
 					      enum object_info_flags flags)
 {
 	struct odb_source_packed *packed = odb_source_packed_downcast(source);
+	struct packed_git *bad_pack = NULL;
 	struct pack_entry e;
 	int ret;
 
@@ -51,8 +53,16 @@ static int odb_source_packed_read_object_info(struct odb_source *source,
 	if (flags & OBJECT_INFO_SECOND_READ)
 		odb_source_prepare(source, ODB_PREPARE_FLUSH_CACHES);
 
-	if (!find_pack_entry(packed, oid, &e))
+	if (!find_pack_entry(packed, oid, &e, &bad_pack)) {
+		/*
+		 * The lookup may have failed because the object is known to be
+		 * corrupt in one of the packfiles. Report the object as
+		 * corrupt instead of missing in that case.
+		 */
+		if (bad_pack)
+			return -1;
 		return 1;
+	}
 
 	/*
 	 * We know that the caller doesn't actually need the
@@ -77,7 +87,7 @@ static int odb_source_packed_read_object_stream(struct odb_read_stream **out,
 	struct odb_source_packed *packed = odb_source_packed_downcast(source);
 	struct pack_entry e;
 
-	if (!find_pack_entry(packed, oid, &e))
+	if (!find_pack_entry(packed, oid, &e, NULL))
 		return -1;
 
 	return packfile_read_object_stream(out, oid, e.p, e.offset);
@@ -583,7 +593,7 @@ static int odb_source_packed_freshen_object(struct odb_source *source,
 		timesp = &times;
 	}
 
-	if (!find_pack_entry(packed, oid, &e))
+	if (!find_pack_entry(packed, oid, &e, NULL))
 		return 0;
 	if (e.p->is_cruft)
 		return 0;
diff --git a/packfile.c b/packfile.c
index 0eee45055f..34e2f9bb8b 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1859,13 +1859,17 @@ int is_pack_valid(struct packed_git *p)
 
 int packfile_fill_entry(struct packed_git *p,
 			const struct object_id *oid,
-			struct pack_entry *e)
+			struct pack_entry *e,
+			struct packed_git **bad_pack)
 {
 	off_t offset;
 
 	if (oidset_size(&p->bad_objects) &&
-	    oidset_contains(&p->bad_objects, oid))
+	    oidset_contains(&p->bad_objects, oid)) {
+		if (bad_pack && !*bad_pack)
+			*bad_pack = p;
 		return 0;
+	}
 
 	offset = find_pack_entry_one(oid, p);
 	if (!offset)
@@ -1962,7 +1966,7 @@ int has_object_kept_pack(struct repository *r, const struct object_id *oid,
 
 		for (; *cache; cache++) {
 			struct packed_git *p = *cache;
-			if (packfile_fill_entry(p, oid, &e))
+			if (packfile_fill_entry(p, oid, &e, NULL))
 				return 1;
 		}
 	}
diff --git a/packfile.h b/packfile.h
index e1f77152b5..3229a6ed47 100644
--- a/packfile.h
+++ b/packfile.h
@@ -294,7 +294,8 @@ off_t find_pack_entry_one(const struct object_id *oid, struct packed_git *);
 
 int packfile_fill_entry(struct packed_git *p,
 			const struct object_id *oid,
-			struct pack_entry *e);
+			struct pack_entry *e,
+			struct packed_git **bad_pack);
 
 int is_pack_valid(struct packed_git *);
 void *unpack_entry(struct repository *r, struct packed_git *, off_t,
diff --git a/t/helper/test-read-midx.c b/t/helper/test-read-midx.c
index fb16ec0176..27a05da957 100644
--- a/t/helper/test-read-midx.c
+++ b/t/helper/test-read-midx.c
@@ -82,7 +82,7 @@ static int read_midx_file(const char *object_dir, const char *checksum,
 		for (i = 0; i < m->num_objects; i++) {
 			nth_midxed_object_oid(&oid, m,
 					      i + m->num_objects_in_base);
-			fill_midx_entry(m, &oid, &e);
+			fill_midx_entry(m, &oid, &e, NULL);
 
 			printf("%s %"PRIu64"\t%s\n",
 			       oid_to_hex(&oid), e.offset, e.p->pack_name);

-- 
2.55.0.822.g20453c30eb.dirty

