Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FB141B34D
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 11:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780572350; cv=none; b=idPx0TA9NJb9/L41Udxam0ECxwNgJau32BE0xeFeqNILU41w/fJ7hDKoAbFIidNe3KuI3wWk5T5BHroMo+rO8OG/CyKbbttX4AwpVfpLegMtBijenmN9lRA2F8bLspP7gT7ezTU/CmUY45aO4AjZncfXMEx/5g1u6Ywxgc7GtQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780572350; c=relaxed/simple;
	bh=0WE23Am7zLtfuWMl+hufYGfPxq5ABgFPBSn7+M4fXeA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pXMHUX8fMABodUw/ruVP3sagoHCbtVP9W/S8us8y1BgN3UfMgHY0W/jyymG4RcBhKYzsjElumnpd+wW029pp3H2OKcTiYOnODhjPuzT9XBG9d/CAmd7+e9WbIPLjoiL/buCieapKwl9Q/rE/hcA/B26tOFAwvKIvzsN+o4hvci8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jdBtBMOE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bmtGxwhz; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jdBtBMOE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bmtGxwhz"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 169001400130
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 07:25:48 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 04 Jun 2026 07:25:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780572348;
	 x=1780658748; bh=f1WNTdRR9Hxtjdz0Eh3608QEhZtzboyBcJfhcxughhU=; b=
	jdBtBMOEPIUuzrjGPzDa4riuP4NuJ3SyPKWi0nWF7NKji+MCwuHrqczKsd8d8Z9T
	zhSSdqnyTJy2agLZ4YOSMTSYU2goN6UeOkAiYd54kPTK0tN1IMvoEqZtYcMcA+JT
	VFg143qfevodnSeJJaUA4vv+m8XRzS50HjAgCi/FC5y3z8HE49YKocI3WOvcHIXD
	staOL5NO8gHG22lS0xSQqrgCsfpxebs6W8YOy65s38EY53wrbgCyi56n6w6zZy1E
	mumqD68gicG5Wzto1FHTWI5Nl9kfmvxRG+Yt+mzBN8skL97C+D1gnuklk8zBw0XQ
	y3akOAB6PGNq9pQMW6+gcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780572348; x=
	1780658748; bh=f1WNTdRR9Hxtjdz0Eh3608QEhZtzboyBcJfhcxughhU=; b=b
	mtGxwhzS5UbLZO0fvZEJIrP2K+CSbTCwoB0yT0eGkW2F93AL7Q30baAdsY8JPSyz
	xuXQxeyBds7zCwZaU6xaFe5y3Cs0O+H4E+mCftjw3ghUr2MUEsFzEjr0XMVZfZC8
	htL5lWqtI6p7HdPtzgVtiD8hOICz89zpd3cVoPRMjJvkKTV5M9IWcqPAQ6aM1ibq
	5Y4Zv7gkaejHRRg6s5mYe3nAeJfutnRv/omk0fG7WBmljNMM4moeDy6KANaPUCo1
	YduNc02sV/dTpeWu2XEeQSdcYT4ZxN6gc9IJVCO7ni6JkJRDrRefmfrUNlriNv6I
	0X+43L18wVTHxspv1xvJQ==
X-ME-Sender: <xms:vGAhap9oqangEPgRiAnG3rUo9EyU5NhIdyZL5mT_fBmjRMVCOQ6Yfw>
    <xme:vGAhakp6VGwgEQSE6uS7b_InHc1q-c34le2ioMIXoCPcJ9en-2K-Z2brAsiiw8RAO
    EYutVu8S6pOSv8EaQ7pvRfsR094FzziT3NTNTf8vxk3HYAuh8yl>
X-ME-Received: <xmr:vGAhasr4MGqqxh2GfoP35sga540PqESxVA0mF-wCw9UlPh0uK2qJRiezK99tUE5VwwMHwRZBRbqcwr4mW9KXz-ffAyJgbELP5rHCJbGrtoY>
X-ME-Proxy-Cause: dmFkZTG1ZbTSTCt+QGOBx/ozxIEQhARBqr0/SlqS3JC3+zb5glHSVG1aoMYIj9aqeIu0zy
    sFSu/10DzZ9FxuAnUcFX6wAMbP9bcQrm5ozYikXKxnDFDplVWXkO3AcE+a89ybngC3lrIz
    /GVY5rm27PVrHphkJl/OHdHOPrCII5MKB9fWDnt3CbmEK2TBDSFR2xtzwFeqzHWM4uomo5
    7XY5VmmSTadEWmtllR1d1OawV3IdNUcjNTdgTRjA6Zegw5qOpq6fI/Dca+wbibUmVoNStb
    renMzkGmdPq7kqvux3p6g6SuTVtljNZSpQco4BML6yeKWNkQha+6iZyZlP37J3M3wlioi0
    iuuse+I7tv3Fqsk9vCKMKTh8z2YowuhKiwmV8VsiPGSeqq9AIq/+tVtmR9NbiINUFKsxoR
    oSQ3hweVCIICpRy47TqrFbAmtFZic9tguEPefCK3r42Iwgs2yAxstCydJtKI1ihJ94HxOi
    WKMmDxodyX9Y4rKhwNcsAa3uT4wEx/vEDvowjNRAgCrzjGj6bJW09EcHXtvITIJuJg3QT4
    T1m0gKSggz/qWCiiRxagBnrkDRDwQATj9WVwhrQLrNnQ0zK+/sQwV9K1qUhHe+COE/RxR8
    vkR54uW264C0d6f8zqrh/2oc/HcEhK5Vtb0L1P7O/moiNOSkenUL0C9KufCg
X-ME-Proxy: <xmx:vGAhainrDCVYKyOSi-OURRUHq5gp-ICIBDOPvbU-PQzCRdAUQ69Byg>
    <xmx:vGAhauHrt1oPBjcrQiadpe1S7RQq5rVL4ZaHq9OL8BCGhzds1p4N-g>
    <xmx:vGAharqBUjHB2HLEVehF2R2LOwPBFz6QNx5bIuV8Q3JJ1ISF831YHA>
    <xmx:vGAhaq5hJRPK7Y1pufRJBKNqWiCfmaucZjGu9IgIlQ4UMUj_7K96pg>
    <xmx:vGAhahDLqYzLXPUCZ2Zc2r_YCMs4gQSuVOMJusRFkqu5vzq1Ueb78OwM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 4 Jun 2026 07:25:47 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b6c02ca1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 4 Jun 2026 11:25:46 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 04 Jun 2026 13:25:30 +0200
Subject: [PATCH 03/16] odb/source-packed: store pointer to "files" instead
 of generic source
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-pks-odb-source-packed-v1-3-2e7ab31b4b5c@pks.im>
References: <20260604-pks-odb-source-packed-v1-0-2e7ab31b4b5c@pks.im>
In-Reply-To: <20260604-pks-odb-source-packed-v1-0-2e7ab31b4b5c@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

The `struct odb_source_packed` holds a pointer to its owning parent
source. The way that Git is currently structured, this parent is always
the "files" source. In subsequent commits we're going to detangle that
so that the "packed" source doesn't have any owning parent source at
all, which makes it usable as a completely standalone source.

Detangling this mess is somewhat intricate though, and is made even more
intricate because it's not always clear which kind of source one is
holding at a specific point in time -- either the parent "files" source,
or the child "packed" source.

Make this relationship more explicit by storing a pointer to the "files"
source instead of storing a pointer to a generic `struct odb_source`.
This will help make subsequent steps a bit clearer.

Note that this is a temporary step, only. At the end of this series
we will have dropped the parent pointer completely.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-files.c  |  2 +-
 odb/source-packed.c |  4 ++--
 odb/source-packed.h |  4 ++--
 packfile.c          | 12 ++++++------
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/odb/source-files.c b/odb/source-files.c
index 191562f316..e04525fb08 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -269,7 +269,7 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
 	CALLOC_ARRAY(files, 1);
 	odb_source_init(&files->base, odb, ODB_SOURCE_FILES, path, local);
 	files->loose = odb_source_loose_new(odb, path, local);
-	files->packed = odb_source_packed_new(&files->base);
+	files->packed = odb_source_packed_new(files);
 
 	files->base.free = odb_source_files_free;
 	files->base.close = odb_source_files_close;
diff --git a/odb/source-packed.c b/odb/source-packed.c
index 1e94b47ea0..12e785be48 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -1,11 +1,11 @@
 #include "git-compat-util.h"
 #include "odb/source-packed.h"
 
-struct odb_source_packed *odb_source_packed_new(struct odb_source *source)
+struct odb_source_packed *odb_source_packed_new(struct odb_source_files *parent)
 {
 	struct odb_source_packed *store;
 	CALLOC_ARRAY(store, 1);
-	store->source = source;
+	store->files = parent;
 	strmap_init(&store->packs_by_path);
 	return store;
 }
diff --git a/odb/source-packed.h b/odb/source-packed.h
index c17068a4f1..6e5c79a77a 100644
--- a/odb/source-packed.h
+++ b/odb/source-packed.h
@@ -17,7 +17,7 @@ struct packfile_list_entry {
  * A store that manages packfiles for a given object database.
  */
 struct odb_source_packed {
-	struct odb_source *source;
+	struct odb_source_files *files;
 
 	/*
 	 * The list of packfiles in the order in which they have been most
@@ -75,6 +75,6 @@ struct odb_source_packed {
  * Allocate and initialize a new empty packfile store for the given object
  * database source.
  */
-struct odb_source_packed *odb_source_packed_new(struct odb_source *source);
+struct odb_source_packed *odb_source_packed_new(struct odb_source_files *parent);
 
 #endif
diff --git a/packfile.c b/packfile.c
index f2b27df66e..2af07f5e1a 100644
--- a/packfile.c
+++ b/packfile.c
@@ -885,7 +885,7 @@ struct packed_git *packfile_store_load_pack(struct odb_source_packed *store,
 
 	p = strmap_get(&store->packs_by_path, key.buf);
 	if (!p) {
-		p = add_packed_git(store->source->odb->repo, idx_path,
+		p = add_packed_git(store->files->base.odb->repo, idx_path,
 				   strlen(idx_path), local);
 		if (p)
 			packfile_store_add_pack(store, p);
@@ -1073,8 +1073,8 @@ void packfile_store_prepare(struct odb_source_packed *store)
 	if (store->initialized)
 		return;
 
-	prepare_multi_pack_index_one(store->source);
-	prepare_packed_git_one(store->source);
+	prepare_multi_pack_index_one(&store->files->base);
+	prepare_packed_git_one(&store->files->base);
 
 	sort_packs(&store->packs.head, sort_pack);
 	for (struct packfile_list_entry *e = store->packs.head; e; e = e->next)
@@ -1112,7 +1112,7 @@ int packfile_store_count_objects(struct odb_source_packed *store,
 	unsigned long count = 0;
 	int ret;
 
-	m = get_multi_pack_index(store->source);
+	m = get_multi_pack_index(&store->files->base);
 	if (m)
 		count += m->num_objects + m->num_objects_in_base;
 
@@ -2533,7 +2533,7 @@ static int packfile_store_for_each_prefixed_object(
 
 	store->skip_mru_updates = true;
 
-	m = get_multi_pack_index(store->source);
+	m = get_multi_pack_index(&store->files->base);
 	if (m) {
 		ret = for_each_prefixed_object_in_midx(store, m, opts, data);
 		if (ret)
@@ -2715,7 +2715,7 @@ int packfile_store_find_abbrev_len(struct odb_source_packed *store,
 	struct packfile_list_entry *e;
 	struct multi_pack_index *m;
 
-	m = get_multi_pack_index(store->source);
+	m = get_multi_pack_index(&store->files->base);
 	if (m)
 		find_abbrev_len_for_midx(m, oid, min_len, &min_len);
 

-- 
2.54.0.1064.gd145956f57.dirty

