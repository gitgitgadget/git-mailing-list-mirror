Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF4141C313
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 11:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780572361; cv=none; b=NG/Dm9mnjybOg4viZbX8SlbqlkT0CBTNS/P/W683AkmliRIc3/4YKBIISrqSN24WRAdHvyoVf7+O4y/swqbfkN59tFo3KsSxDJ1fFwQDFs9ALpYg1OvAcKJ1d2V+cJNYOGCmnsV1q1x/6hcGFEH3iiKxXn9Eqv9/fuB9lvTz2kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780572361; c=relaxed/simple;
	bh=btVC+scn13REloMs0aIvKs2F+zqF53ggbjsVPT38SHg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cVC5PFCOEwPDh1rKpLpkTAfT44PcJ87InGz67imkCyXmIRxLMLQvsMqsRNhtqtM0bQ7UqJnG41Vgy46hswRdTEGx/u+P7JWQIgITuz9ClA/u5DHwrZLII7NfmVIRItfoxo0Qj2V/bTVUbWe/XvZP39GmijKVy0Hmmpj483r88aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UifgYbxo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TYKQBJj/; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UifgYbxo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TYKQBJj/"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9A71C1400130
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 07:25:59 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 04 Jun 2026 07:25:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780572359;
	 x=1780658759; bh=wdyCEzkldvSYIZOYhyor2FHXkHxxY8I85OYEQZ7U7Oc=; b=
	UifgYbxoQByNk7nP9HKByRk7sa5t7VJ+e8wjsYIVO/7RaDTJbMUncpo5FKobR6br
	4e7NjrpTCzP8ZOHptn6bXW9rbCu7Qcm6RGYo2sgG84Cqza6XNc2T4IX2GzEjoPQG
	JjluZq6gSloTzq7ZqOI3VfDpBNnr3JksdCJzSv6eCPvmBYbSyViprbD6O7kwMxNS
	i6ptBlwk3NehYDwx60kYgSIvXREvaAR1T+L7zmh/2UNUbKICEgdVpRGDB5xfEPoC
	5V3TqyTKBVF98/5QKlYclrvf0wfdmZ0li53tugkmgI9G7pYVbqvLsG5Q2H3iTnPs
	REFfEmdnKLCBZp8dkZ8y7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780572359; x=
	1780658759; bh=wdyCEzkldvSYIZOYhyor2FHXkHxxY8I85OYEQZ7U7Oc=; b=T
	YKQBJj/hTURRFH+nbrKhuxBiUxejs0cgSe96TIDwyR5E12oKfuDY/IpI33w3hG6Z
	uvKDOXHzilP0B8K7gwSxDUk4B49tJ+bXY4iuiCXNBMLrb7HpJNtQ/RMzhsyYo562
	CaaDcddlavsDY+e1mfuhIPZRIKku4zzrBSXOQzSh5Ja8fu9Tb3fzACB6ejcYM43S
	EDKjHVH9dreOYJjir46sSF1hFs+rTJGUtUEgXCej4rWuffzWR79A5RXaGGHKwRnv
	dapxfnPlJTm9BFJFf9K/D8QEtdiT+Vq80mlvA595NOE8errEV7lFCsOZHr7GnC+P
	9Kjk0ngpe4rqux/mv9BrQ==
X-ME-Sender: <xms:x2AhalfdtT9uECmviDBrAdodWuyQAIQm15xo_tFTkjvnsDR17I6y3w>
    <xme:x2AhaqJ8H6oWhcPBm8edMww3vqMTCAkLQSOiy1naIv5he99bkq73iYSijrjBv3rgt
    7Oc8-oa0y4roywfxqDGMsksDuUMmCePa1gciNbZrIm3itXer_GA>
X-ME-Received: <xmr:x2AhakII3JZLtMKOPqLa6bVTW1mYDOVgNFYrPN_inzV2roE59TpwCl9IvFKLSAbkhRG0imZSP0kg9g7pu1SKK3LXWEzLaY9ep41TYGJj5bg>
X-ME-Proxy-Cause: dmFkZTEgCyScvAHJZtwScmArpd3MPVD65pRFEMle7OxDyvGrBgzCBJpJZt/i/e/55qfMB2
    OZ+A4mOijyyVR7BQZ8gApb6Lys3WwA/DRBZO1Z6gq18/NjHv9k/YmqxGulaGbdjpGbGIe8
    TR7oy8jORNRJjZkYPAiPkwIOcJg76HwsAVLzInKh/aA4zWo5I7a3yFoBSrwplR1bXvqyzb
    7cwWjx66LW0j/HaZcKLdC3JWI1rUB6+uoj5Ia8HwsvfkXaZepnJEy9rr0yADWxKwm6t/hJ
    h4TWvBlU4kw/rB+rZbM4p/EdiFJ50OcReCBplYqL1Hq7W/DA0KsY8Jaj3WslUYFsjaCmgp
    SN+YcK0zWarT/Om0LO78ueYs0SXqAz9QX4kOxTUetzAKO27M25KPQXs0ti8zr9o6f6JAvI
    +Wsq+Toq/9YnlFoEr2hHXDdY0s87Ksj2NOnA7DjqIm3QcEqE/pYVO9IHPfvnxN3KovinfN
    2VBBxcTxi9TG0AlH+L58kQlqEoPUY5+0eQqA3hjAyQDO/DhMEs1hcUlWje30v1FBCSAvTs
    PW6V+G0imdC4tRqtFTSe439ce80i8uGs94Z5du6UWOQdOyI8OeP8bcuj0Ciu3q5dtbmspx
    Tzgut3nP9lQ5pKYZRwMt89UCpBCgLHDHipBc9gpjmEaRvVa3C5Mo2KGOfTTw
X-ME-Proxy: <xmx:x2AhakFRaCwi2F_sMTGOGwLuQ-W-iIYwmJz6CPRbLhlnfJ4rmQozgQ>
    <xmx:x2Ahahn0e4g0hZBlMIydLE4l9MUs5LmUQKzM7ZyD85V8tFglgVdx1g>
    <xmx:x2AhapJRzPDvhvMYofNywMen1RyFd1pXsJ4GgfAbXvK2sYeUpnJI5A>
    <xmx:x2Ahaqbw3vV1Ql8WR7BoRn9Z7vw5DKt3Tvrqlyl5fK3gddZncwuMXA>
    <xmx:x2AhavNyh6o5S3Pgg8T2UnXTqHIMbPirIc6A4PgaEho3giIPh-yOChph>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 4 Jun 2026 07:25:59 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9e832c21 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 4 Jun 2026 11:25:58 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 04 Jun 2026 13:25:35 +0200
Subject: [PATCH 08/16] odb/source-packed: wire up `read_object_info()`
 callback
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-pks-odb-source-packed-v1-8-2e7ab31b4b5c@pks.im>
References: <20260604-pks-odb-source-packed-v1-0-2e7ab31b4b5c@pks.im>
In-Reply-To: <20260604-pks-odb-source-packed-v1-0-2e7ab31b4b5c@pks.im>
To: git@vger.kernel.org
Cc: 
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
index 6645f4f943..aa2e80281b 100644
--- a/odb/source-packed.h
+++ b/odb/source-packed.h
@@ -98,4 +98,10 @@ static inline struct odb_source_packed *odb_source_packed_downcast(struct odb_so
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
index 3ee71d7f71..565186e9c7 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1978,9 +1978,9 @@ int is_pack_valid(struct packed_git *p)
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
 
@@ -2006,29 +2006,6 @@ static int fill_pack_entry(const struct object_id *oid,
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
@@ -2045,41 +2022,6 @@ int packfile_store_freshen_object(struct odb_source_packed *store,
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
@@ -2136,7 +2078,7 @@ int has_object_pack(struct repository *r, const struct object_id *oid)
 	odb_prepare_alternates(r->objects);
 	for (source = r->objects->sources; source; source = source->next) {
 		struct odb_source_files *files = odb_source_files_downcast(source);
-		if (!packfile_store_read_object_info(files->packed, oid, NULL, 0))
+		if (!odb_source_read_object_info(&files->packed->base, oid, NULL, 0))
 			return 1;
 	}
 
@@ -2157,7 +2099,7 @@ int has_object_kept_pack(struct repository *r, const struct object_id *oid,
 
 		for (; *cache; cache++) {
 			struct packed_git *p = *cache;
-			if (fill_pack_entry(oid, &e, p))
+			if (packfile_fill_entry(p, oid, &e))
 				return 1;
 		}
 	}
@@ -2291,8 +2233,8 @@ static int for_each_prefixed_object_in_midx(
 			if (data->request) {
 				struct object_info oi = *data->request;
 
-				ret = packfile_store_read_object_info(store, current,
-								      &oi, 0);
+				ret = odb_source_read_object_info(&store->base, current,
+								  &oi, 0);
 				if (ret)
 					goto out;
 
@@ -2342,7 +2284,7 @@ static int for_each_prefixed_object_in_pack(
 		if (data->request) {
 			struct object_info oi = *data->request;
 
-			ret = packfile_store_read_object_info(store, &oid, &oi, 0);
+			ret = odb_source_read_object_info(&store->base, &oid, &oi, 0);
 			if (ret)
 				goto out;
 
diff --git a/packfile.h b/packfile.h
index 1bce805f74..2bb6656c3b 100644
--- a/packfile.h
+++ b/packfile.h
@@ -140,17 +140,6 @@ int packfile_store_read_object_stream(struct odb_read_stream **out,
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
@@ -352,6 +341,10 @@ off_t nth_packed_object_offset(const struct packed_git *, uint32_t n);
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
2.54.0.1064.gd145956f57.dirty

