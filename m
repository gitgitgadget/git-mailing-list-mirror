Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DB13B5854
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 06:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781678422; cv=none; b=VjU1RoaqSTlLv+5DdNYieqSZ1plGwXhMLGl4AwaKmhEu9Xr7hyrlgh4ux0A9LGQmk/izvHTyfVTSqGzXvTWV103cbae5JLnztDChnPgK6mtCyZ6e3/Y+ULX38UMbPSTYJyxz0p5jA9AcBLKsul5fK8CGpxQ9qhnK06izdO/KpmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781678422; c=relaxed/simple;
	bh=NohyS1epFahw18QCdkjFQCIRSiwqGJxE0ry60TCLEns=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RpPzjLlF0AsTAhuq58QVZf+ST3xpUSMeKW5doI1C9rLnVOAI4/Sibd9OL/CWxef/1EhRxNaaZicjq/JZwJytbcQ7zp0AP4XeCICUXHS69/SEgF/2xrdS50BInUVEAt4e4GUvIgapKZ/tIcFm8Ss+XM219GsX332A4EXQufMr/xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gpO33jkH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CBdq4PlC; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gpO33jkH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CBdq4PlC"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CCE4F7A0105;
	Wed, 17 Jun 2026 02:40:19 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 17 Jun 2026 02:40:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781678419;
	 x=1781764819; bh=B5Hu5iZ84f4AqYv8iE1xs+7zZkF+oyW0IVDea6wg6Ro=; b=
	gpO33jkHg6fiJjYVvZHVfgOAjPggfpetyWdZX0oY9E+Cl0hJGpUkh451D8M8sipL
	0sYNlMB5wnHpzRlmiNl5UTIWZX4JMiNpm+0qiqiiu4HTCeHsj0AmjE2E0BJNZg9H
	KTYHQaTGjSXO8Hon73imFKQ4P9em4DS9Q9bfOxf3jFmLuQbCU++RzF6XLlfD5EmY
	cuPSOurLPZFKRwmuLibD7xxy2buS8ezYz6n0Z3/bIbX6nw3YrHzCTI76D1Zk2w9l
	yQYctVGU+0WC2/B/j1seCOm6EFDKmQ5Y2M5S+vs+fn/ZU0QfmBMMIIxX40kinj7L
	400LRMxWiwsD9ph2OgIUlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781678419; x=
	1781764819; bh=B5Hu5iZ84f4AqYv8iE1xs+7zZkF+oyW0IVDea6wg6Ro=; b=C
	Bdq4PlCvpWeCxC/RqkhESewgG2ob+hObawyQ+t1TISicg/izxizTO04dymJfMZLa
	fl+7aWHfoWrXnrfDYSgf6PBczTTo6tdJHJKfDRK4vK0FqJFz98awirnQrVbeJQh4
	+ULdou23upMdkzNRrARkIYDHbllNdKe5ZaWksyePOxQ7klBILGl0muYEJfIfLYa5
	S7mb9lxreoD0InPRZ/HgRy7LqQF44M0e/8pCw5mhuGC6sN0ru8+wStqxCeVkcbL4
	97dMonxIuZk1ym1Rty3z+uyoBCh2xjWS0AEcr5b7+EAf2hi2BUYbJJuOsVBoYKlG
	li+WXF1LD/b99Lu4eB/8A==
X-ME-Sender: <xms:U0EyaqyQgQTIHh2tGiHKCwZ3xc2ICmTMEg3IT-wAVjhUFwJvRNvuSg>
    <xme:U0EyatsYh4uSZ4XIbL2yPTkLYKrHr2jMFq9pYELyBipXHmdS-vEubY6RKTkY71vdG
    ZXkdywYwUtAqGCHIK4RqggjcV37qDSXCBdTzFihN09ot3tkgciwfg>
X-ME-Received: <xmr:U0EyaptfPNH1izPdn0zUs127ooeDS63RnFHXHyJ1WxwQOa3KgytbdQQ_Q9t5hGGMxCl2nkPqLg6SABVo4v1Ryz2TIQOyUyHKo003QjI>
X-ME-Proxy-Cause: dmFkZTEnB39eLvyMgsk+d1zBATJAS2Dd09yZUP4TCe4zWysBccoWgY8Y+enBv1+9aJfPT8
    oVvaCC5MWGV30uZzKswgiCAK2gGSGYELp/F+QCNhRNY/bQx6x+ywijOIUW8TKDwAx48Lcx
    KhLHoOJu9m1Ux2Kfz7iOtjqmT/hnPJJkdtWT0xsGgHMCb1yqiVx9G0A93DDw8nseLTKulF
    USUks9qtFi47cv66z4EPIfMktSNXs9lIOpQJ4JZJ8Sqt4LT7yml6xL5bA1DQ7F1XoINCS5
    8+0eJLKjW+BUl0nBlxv0Wa8T6T4Bg1YQKal6uMYv+KeVZbCqw870pv0xnOpn9ZF3vGEMNT
    StwuP9Kb8m1htssOHv+W70uriGt2Z71qkgKj9iHp9FTMxEmUVa1lUs/os9WAv6T34KQtFh
    URq4dwZagmx0vaix/f9LK8PTrkPhDDKxeJNs+ALiFAlhds0Z0rUdmr1hRxvsJ1Z2lKhmAQ
    hLz19YoRixKnya4sg15fbsYdSRE/Gi/w/LXtfFPq5uJBg+GkM9NNJF8+uWdRP0ccTm/EdP
    5OI97NISe8yz6sdDZJ0rPNKGR+xRPRp/6qh+ZOL0Oe/cf4oXyDcU6OkR0l1AbTuTnHGShk
    8h2ZY6Yof5JhIbMipC+YKNcaIQ20hffKbNYJj8NJknAFpi/WJGQXvMyfmcjQ
X-ME-Proxy: <xmx:U0EyaqN6SMrX-VxwD48C7rY7yuAgThTL01bqN4JalwbiXXpS0HAkAw>
    <xmx:U0Eyav0ksBEFmatYtStWsN4gqCldKoGMTkEW65KyXXiR0_EHIyQ0ew>
    <xmx:U0EyauOOCFNJ8BUjmz4TIYOnJBvw4L05xKSPnL0RWA12BdueVtDk5w>
    <xmx:U0Eyan3SGwytkjudWKBeo9PvLFHWEEmBFELko0npdp3Kw5gJ34Oplg>
    <xmx:U0EyatLG6495xoCNIoePVjiVbt4mxxN92zMKOkUsrqOUMzOlm9HxJtCw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jun 2026 02:40:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 20ed497a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 17 Jun 2026 06:40:17 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 17 Jun 2026 08:39:52 +0200
Subject: [PATCH v3 09/17] odb/source-packed: wire up `read_object_info()`
 callback
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-pks-odb-source-packed-v3-9-b5c7583cd795@pks.im>
References: <20260617-pks-odb-source-packed-v3-0-b5c7583cd795@pks.im>
In-Reply-To: <20260617-pks-odb-source-packed-v3-0-b5c7583cd795@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

Move the logic to read object info from a "packed" source into
"odb/source-packed.c" and wire it up as the `read_object_info()`
callback.

Note that we also move around the supporting `find_pack_entry()`, but we
still have to expose it to other callers that exist in "packfile.c".
This will be fixed in subsequent commits though, where all callers in
"packfile.c" will have been moved into "odb/source-packed.c", and at
that point we'll be able to make `find_pack_entry()` file-local again.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-files.c  |  2 +-
 odb/source-packed.c | 60 +++++++++++++++++++++++++++++++++++++++++++
 odb/source-packed.h |  6 +++++
 packfile.c          | 74 ++++++-----------------------------------------------
 packfile.h          | 15 +++--------
 5 files changed, 79 insertions(+), 78 deletions(-)

diff --git a/odb/source-files.c b/odb/source-files.c
index 7b1e0ac565..8cae35d25e 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -55,7 +55,7 @@ static int odb_source_files_read_object_info(struct odb_source *source,
 {
 	struct odb_source_files *files = odb_source_files_downcast(source);
 
-	if (!packfile_store_read_object_info(files->packed, oid, oi, flags) ||
+	if (!odb_source_read_object_info(&files->packed->base, oid, oi, flags) ||
 	    !odb_source_read_object_info(&files->loose->base, oid, oi, flags))
 		return 0;
 
diff --git a/odb/source-packed.c b/odb/source-packed.c
index e8e2e5bb48..f71a194739 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -7,6 +7,65 @@
 #include "odb/source-packed.h"
 #include "packfile.h"
 
+int find_pack_entry(struct odb_source_packed *store,
+		    const struct object_id *oid,
+		    struct pack_entry *e)
+{
+	struct packfile_list_entry *l;
+
+	odb_source_packed_prepare(store);
+	if (store->midx && fill_midx_entry(store->midx, oid, e))
+		return 1;
+
+	for (l = store->packs.head; l; l = l->next) {
+		struct packed_git *p = l->pack;
+
+		if (!p->multi_pack_index && packfile_fill_entry(p, oid, e)) {
+			if (!store->skip_mru_updates)
+				packfile_list_prepend(&store->packs, p);
+			return 1;
+		}
+	}
+
+	return 0;
+}
+
+static int odb_source_packed_read_object_info(struct odb_source *source,
+					      const struct object_id *oid,
+					      struct object_info *oi,
+					      enum object_info_flags flags)
+{
+	struct odb_source_packed *packed = odb_source_packed_downcast(source);
+	struct pack_entry e;
+	int ret;
+
+	/*
+	 * In case the first read didn't surface the object, we have to reload
+	 * packfiles. This may cause us to discover new packfiles that have
+	 * been added since the last time we have prepared the packfile store.
+	 */
+	if (flags & OBJECT_INFO_SECOND_READ)
+		odb_source_reprepare(source);
+
+	if (!find_pack_entry(packed, oid, &e))
+		return 1;
+
+	/*
+	 * We know that the caller doesn't actually need the
+	 * information below, so return early.
+	 */
+	if (!oi)
+		return 0;
+
+	ret = packed_object_info(e.p, e.offset, oi);
+	if (ret < 0) {
+		mark_bad_packed_object(e.p, oid);
+		return -1;
+	}
+
+	return 0;
+}
+
 void (*report_garbage)(unsigned seen_bits, const char *path);
 
 static void report_helper(const struct string_list *list,
@@ -215,6 +274,7 @@ struct odb_source_packed *odb_source_packed_new(struct odb_source_files *parent)
 	packed->base.free = odb_source_packed_free;
 	packed->base.close = odb_source_packed_close;
 	packed->base.reprepare = odb_source_packed_reprepare;
+	packed->base.read_object_info = odb_source_packed_read_object_info;
 
 	if (!is_absolute_path(parent->base.path))
 		chdir_notify_register(NULL, odb_source_packed_reparent, packed);
diff --git a/odb/source-packed.h b/odb/source-packed.h
index 9d4796261a..f430ee0b94 100644
--- a/odb/source-packed.h
+++ b/odb/source-packed.h
@@ -90,4 +90,10 @@ static inline struct odb_source_packed *odb_source_packed_downcast(struct odb_so
  */
 void odb_source_packed_prepare(struct odb_source_packed *source);
 
+struct pack_entry;
+
+int find_pack_entry(struct odb_source_packed *store,
+		    const struct object_id *oid,
+		    struct pack_entry *e);
+
 #endif
diff --git a/packfile.c b/packfile.c
index b35afd7797..29530532ba 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1895,9 +1895,9 @@ int is_pack_valid(struct packed_git *p)
 	return !open_packed_git(p);
 }
 
-static int fill_pack_entry(const struct object_id *oid,
-			   struct pack_entry *e,
-			   struct packed_git *p)
+int packfile_fill_entry(struct packed_git *p,
+			const struct object_id *oid,
+			struct pack_entry *e)
 {
 	off_t offset;
 
@@ -1923,29 +1923,6 @@ static int fill_pack_entry(const struct object_id *oid,
 	return 1;
 }
 
-static int find_pack_entry(struct odb_source_packed *store,
-			   const struct object_id *oid,
-			   struct pack_entry *e)
-{
-	struct packfile_list_entry *l;
-
-	odb_source_packed_prepare(store);
-	if (store->midx && fill_midx_entry(store->midx, oid, e))
-		return 1;
-
-	for (l = store->packs.head; l; l = l->next) {
-		struct packed_git *p = l->pack;
-
-		if (!p->multi_pack_index && fill_pack_entry(oid, e, p)) {
-			if (!store->skip_mru_updates)
-				packfile_list_prepend(&store->packs, p);
-			return 1;
-		}
-	}
-
-	return 0;
-}
-
 int packfile_store_freshen_object(struct odb_source_packed *store,
 				  const struct object_id *oid)
 {
@@ -1962,41 +1939,6 @@ int packfile_store_freshen_object(struct odb_source_packed *store,
 	return 1;
 }
 
-int packfile_store_read_object_info(struct odb_source_packed *store,
-				    const struct object_id *oid,
-				    struct object_info *oi,
-				    enum object_info_flags flags)
-{
-	struct pack_entry e;
-	int ret;
-
-	/*
-	 * In case the first read didn't surface the object, we have to reload
-	 * packfiles. This may cause us to discover new packfiles that have
-	 * been added since the last time we have prepared the packfile store.
-	 */
-	if (flags & OBJECT_INFO_SECOND_READ)
-		odb_source_reprepare(&store->base);
-
-	if (!find_pack_entry(store, oid, &e))
-		return 1;
-
-	/*
-	 * We know that the caller doesn't actually need the
-	 * information below, so return early.
-	 */
-	if (!oi)
-		return 0;
-
-	ret = packed_object_info(e.p, e.offset, oi);
-	if (ret < 0) {
-		mark_bad_packed_object(e.p, oid);
-		return -1;
-	}
-
-	return 0;
-}
-
 static void maybe_invalidate_kept_pack_cache(struct odb_source_packed *store,
 					     unsigned flags)
 {
@@ -2053,7 +1995,7 @@ int has_object_pack(struct repository *r, const struct object_id *oid)
 	odb_prepare_alternates(r->objects);
 	for (source = r->objects->sources; source; source = source->next) {
 		struct odb_source_files *files = odb_source_files_downcast(source);
-		if (!packfile_store_read_object_info(files->packed, oid, NULL, 0))
+		if (!odb_source_read_object_info(&files->packed->base, oid, NULL, 0))
 			return 1;
 	}
 
@@ -2074,7 +2016,7 @@ int has_object_kept_pack(struct repository *r, const struct object_id *oid,
 
 		for (; *cache; cache++) {
 			struct packed_git *p = *cache;
-			if (fill_pack_entry(oid, &e, p))
+			if (packfile_fill_entry(p, oid, &e))
 				return 1;
 		}
 	}
@@ -2208,8 +2150,8 @@ static int for_each_prefixed_object_in_midx(
 			if (data->request) {
 				struct object_info oi = *data->request;
 
-				ret = packfile_store_read_object_info(store, current,
-								      &oi, 0);
+				ret = odb_source_read_object_info(&store->base, current,
+								  &oi, 0);
 				if (ret)
 					goto out;
 
@@ -2259,7 +2201,7 @@ static int for_each_prefixed_object_in_pack(
 		if (data->request) {
 			struct object_info oi = *data->request;
 
-			ret = packfile_store_read_object_info(store, &oid, &oi, 0);
+			ret = odb_source_read_object_info(&store->base, &oid, &oi, 0);
 			if (ret)
 				goto out;
 
diff --git a/packfile.h b/packfile.h
index 9674e573ae..25d458beb0 100644
--- a/packfile.h
+++ b/packfile.h
@@ -128,17 +128,6 @@ int packfile_store_read_object_stream(struct odb_read_stream **out,
 				      struct odb_source_packed *store,
 				      const struct object_id *oid);
 
-/*
- * Try to read the object identified by its ID from the object store and
- * populate the object info with its data. Returns 1 in case the object was
- * not found, 0 if it was and read successfully, and a negative error code in
- * case the object was corrupted.
- */
-int packfile_store_read_object_info(struct odb_source_packed *store,
-				    const struct object_id *oid,
-				    struct object_info *oi,
-				    enum object_info_flags flags);
-
 /*
  * Open the packfile and add it to the store if it isn't yet known. Returns
  * either the newly opened packfile or the preexisting packfile. Returns a
@@ -340,6 +329,10 @@ off_t nth_packed_object_offset(const struct packed_git *, uint32_t n);
  */
 off_t find_pack_entry_one(const struct object_id *oid, struct packed_git *);
 
+int packfile_fill_entry(struct packed_git *p,
+			const struct object_id *oid,
+			struct pack_entry *e);
+
 int is_pack_valid(struct packed_git *);
 void *unpack_entry(struct repository *r, struct packed_git *, off_t, enum object_type *, unsigned long *);
 unsigned long unpack_object_header_buffer(const unsigned char *buf, unsigned long len, enum object_type *type, size_t *sizep);

-- 
2.55.0.rc0.786.g65d90a0328.dirty

