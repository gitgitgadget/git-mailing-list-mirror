Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BF83E833F
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 08:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780995093; cv=none; b=XOAIKnyKwg/Mw4VuCTB+b+cXijx4tZo8m50scvtqA6V/ryYDTKQNA9h+kklmGYXi6Uu1qzAdI+ZhVoXohdXh8gtMpUYCOD21OmnOO3w5LF+u94BWySVuvP/QGzKivG6gsz2n8D0wrUIK3LtrmxV5dCzSpcye9ZnN4aURGXaZdps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780995093; c=relaxed/simple;
	bh=/WbI2CJ48qeNXiOgL7+yWQcP1qV8OXyPqC29UcpYmtE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gre9GEfycx/2QkNHEspjLkZjROVUdu/EAnEecL/RM0PGK4maS54thVjRpu88BjiJ+aTJyseB+mQaeh5VMvKuj7O7yrInfp6oz6cml8i7oz5XJxWvDsn9A7vdyX8Mjkh4Si1F4Pj2NwvNznY4gOfSMsCIONgfR432fxHILEfqVFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=k0BfPqy6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L61I+G/X; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="k0BfPqy6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L61I+G/X"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 3CE301D0017B;
	Tue,  9 Jun 2026 04:51:31 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 09 Jun 2026 04:51:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780995091;
	 x=1781081491; bh=YpRWIkBh56kWaaEIn3WOOxDKfXcTXaoE+MR0xJzfM24=; b=
	k0BfPqy6BX27njBGXCCQnb3RV14SrQNCaqJy1vsHPwxX9U0uqlXp3fbPKnXztu5H
	pOs+KWkymNFc9SZjb7HpwbOVgC9RJ1FBR6nKT1mPYxmDtfmx4N2dqJxw9w1gjjRC
	nC1Ndc2rOqci5rJVuLfaqdPaBkXQyKEo6EPpQ17c+8P7qv28R2FnQE9/HqU1xmT4
	eN7xlKpYPD3YA5xYjgxC/qsnzdZLiPMpHShMaKSUj7fgGuWmejNOaD1TATCt2awI
	zOMCTxZkcz/RfVoZpNMyDSga0XW0nmt2mD/ruOxOKhHo08i0S60UvPEQyWCkcyl6
	P7lxnExkbmFRbU69n6QfKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780995091; x=
	1781081491; bh=YpRWIkBh56kWaaEIn3WOOxDKfXcTXaoE+MR0xJzfM24=; b=L
	61I+G/Xl/vWO09dfTrEgVwTQsHnj73WddZJldWAcMI1jBdBlnOvOwtoTwfL+/G2h
	k1wQnmlQUffEo3O+Op6wkkPiLPJTdcZDYv5t5JYM14Fo/r7HWhYMlM0R/CrlM0Gb
	M7uWgTG50zjsMOlP/EBKpq+oU6vlVuHpqBYoatfAXc2QEKGbnByEeLs5Y/rM6Qnb
	DADVfOC6Vkd/1B708ohbT1XPt8Qt2B/dNffxpFwraoYMK2Pc2OW9Rx7elIa8atBB
	hCilvJMxH5gv8e+7biGnNa3hOaqf38Zjer+i1AoBXZRqxNxI3hejIn6L+gXMRIim
	9BFhJJ6MV8c7ReDapuDoA==
X-ME-Sender: <xms:E9Qnas1tKlFZIDrVLiLeHUwDAqyiw41MiJCIwtHGuIo0qy6QXDdOWA>
    <xme:E9QnatGNRoXoQ8exFvDYz69hi9VXOxEEC0yXqU0FgBH5DG1HsTU0p8lNGIlE9isX7
    vwewSAgX-J1ke9Vu4iiRIlKZadWy9LUHSN9Ld_7NOooAc7UiuulAQ>
X-ME-Received: <xmr:E9QnaigeaVEyxoBHQgtO8IPUuTDIciAtWPzC5om8hiQ_S7RSFhlMdmLafbP7pfIgtkvE9ZZ8lxl_HE87315CPQk-5aeTJMJs1zIW-ryIrT0>
X-ME-Proxy-Cause: dmFkZTGSVhkd6OqOrrdpDI/wZGMgXcggnb/g0YwjX7XcRx0SSrPivqHJxrNm3rQu4rWEJZ
    nDumjzzkcjvzFk0IlMdwRpEJgptWcMVTJz4BCT7yktvekZPmh5NDDBz8IrF2ghgkAIPRWr
    RubFS1EFv2zt8K8KNVBUD3Kxo+6z3N5Uy7vAaFb2JH+NXPZx7/Br4bdYVBh6jEbARuZxSC
    VtxFXAFQ7FAPKziiC9vV5km2MudMHqmGnXAIhN2U+ny5953LOI2Dq2vqG1mfzuTvwbi6f5
    e22qZwVFDjJy7Knyl9mI7c3sBCVIbH1j+c1weBq0TRs0H3cpMz4TI7+xWlUlNUq+NUIiNe
    Z7+lzVI4mVMyaghuB1V7CzVqijFrkY44UpYlctcbvRVF9nrOHEDTwV2DZlHmuBxiMKRXvJ
    KCu/zxub2VZPcB2Ny+NroFxuV1QgjexwrAmhCFrZsIbe3jwmGJKNbK5MWlZQkC4IU+wWie
    vH801PDGCLU1TzOtP8JpLQWXcAcNzWMJCXwQ8Lp/IzvQBhdQt6x9KLTkMdrCNWDpGtdCth
    2zbmjZU6vyeFnRkeQUTxlQjF/SEkNHU4JeYuTivKUUiRFotfothDDtNLeJK3V9r7zBD3Ks
    +5yYRAIOCkQD11lrDfVIPpPP6qbtamb0tBcMqWZ7bi5JJHcje9PQFcyzE6aw
X-ME-Proxy: <xmx:E9Qnag8QlL83MFYqK8r7Oe1SHql09mSxOBWOXb_c2FgiYSI53qamlg>
    <xmx:E9QnahrOElKhY0EZdnmZUM9qAC3zAE-0poTVR8eakL8eAM0D_Oyo-Q>
    <xmx:E9Qnan8IvQAqKzoO5KVfoyyIDrhsyGiTWSrtG3d5aQevNZjaMKdprA>
    <xmx:E9QnatVqx_hKJY9s2Uv-16yEv-eJNZ1DHDYrjU0tmu9JkBE94n55aw>
    <xmx:E9Qnapm9jhl3_jOPy8qTxSbeVqmo0aGURarBg6olUddStpvTLcZ7UpDo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Jun 2026 04:51:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 44926995 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 9 Jun 2026 08:51:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 09 Jun 2026 10:51:02 +0200
Subject: [PATCH v2 09/17] odb/source-packed: wire up `read_object_info()`
 callback
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-pks-odb-source-packed-v2-9-839089132c8b@pks.im>
References: <20260609-pks-odb-source-packed-v2-0-839089132c8b@pks.im>
In-Reply-To: <20260609-pks-odb-source-packed-v2-0-839089132c8b@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
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
2.54.0.1136.gdb2ca164c4.dirty

