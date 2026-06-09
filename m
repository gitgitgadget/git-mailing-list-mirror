Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F493EFFBA
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 08:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780995080; cv=none; b=ZP2I2kPT9VXI3g2rnNFaijk3wnnPbdNCy5CRqeG9aaxwPBJs0XP5tnBSaR7czcVYMlXEnEUCsb5BrfNti4spX2qmk9yEOKAGa7GGv4xg0eY00wmXMQl+ElG/OF3ISjwBHF1aqh85lrgSSA4T2UvZsspXdOOrTXlNg88JddhOs20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780995080; c=relaxed/simple;
	bh=QhlkfYex7ei7VHuVSjrQCI58xB9Ce/d2coJhG6pIp64=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pxMyw8ozqFFaxOwoGgOJky2dXJcaMh5tasFo5+9p96ZuQqwXpztaDF73ncCpYkMDzSkPW7C0jdsroSxaWhdHJfzVqFJJslG6EOS39Xyt72EYtTXrms9gTSGohblXQqHkdclKQLgBVQSgsU+6E5nU7X1cNig3cd4ZNvlBEAErExg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Fvm1VhwC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dTHhoBQ4; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Fvm1VhwC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dTHhoBQ4"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CB01D7A01C3;
	Tue,  9 Jun 2026 04:51:18 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 09 Jun 2026 04:51:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780995078;
	 x=1781081478; bh=gjijTX5U9trZAgL/Ykmx+oTVy7V6Pf0XU07Tj7GaQk0=; b=
	Fvm1VhwCFvuwCZoVVo8gV2SV4j4oe55kP2binACIkvRIbvTy9sOZwPxKlDU+umkr
	icBu41NhwdbGwblQaLc6umK99vF49jbOU9fU3d0TC/SJDZnX6al9o1w7Njahr7v8
	nLgFbw2CV8JtVZlq0u7jx2nDQffDE9qj0ScjOyeaMjmeDgAbbdL4jdXAHggrJKfZ
	pJM9eUFOXd1XnyJDLSsabSboENy6KM+mRkjItzPOAj7ZqUF9Jtirvm4I7N4BPsCr
	h3RcDqF23Ceo6MgP4VIVCaCb/ctOZtDWWaHBPwqcE2N155FODJiOWPeqlj280axJ
	13S7mwjNWVwiB/e/5dmm/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780995078; x=
	1781081478; bh=gjijTX5U9trZAgL/Ykmx+oTVy7V6Pf0XU07Tj7GaQk0=; b=d
	THhoBQ4+kRywVFD7Cb0PaVfa3miag7ayRnUgvxInxbjRKmJE+Woz0lnpC0p0I+os
	eBp6g8uSHYwndkEXTK7022+raPNMXZg514Dt49AuxEry/yNdNvA+WeOZmSFC2XVe
	MuYqBt0DAmGA1lYMriZZPI734kxfNOYnQ6X2JPmMqQYLrnSEqKUN8Q0K1OIfn0U3
	+1X8dx+oQy08OFq3RguhLzdw+ZM+ViD97w0l5sXOewlIMUyZB/7ukq2ZCD55lPsP
	lEMtqpcFirMvTo1PxhzDX5hQ2JSCD3tSIe+Pc/0Ni2Un0B941UrheFxfMwHOxA0K
	AiU/RO28yndWU6tg9z/EQ==
X-ME-Sender: <xms:BtQnasfGKuAcfjEaaDRxxLUrB9V_B0XntoXRYDinA5wMYHiJfcn19g>
    <xme:BtQnakMM1YqtDSURYSKr4FoyQSZskH35_RyIARqqowtcytK0GI4YM_oTMhfgMAkf6
    YPv9SzaKbqA5AkkZ4DMGzqehgvdUtWYXGpaiQiaTSzt1HmYNR-ArQ>
X-ME-Received: <xmr:BtQnarJgxyGcCWD8q2Y5swPV42oYhwIKLtz6DVEQSKNtm-vviETHF678xMjDOe4Ll9idGMGjNTMK4uIUkAGfAp_6o2l-oLEDbY5wG75pP00>
X-ME-Proxy-Cause: dmFkZTFScmXmBNtXOl4rqVqM8DAc19fyHinqrfJGsNjV/CE2oHckwvnGyvDfLnNUuwKybL
    TXXNE7zDSLzm9sqK7QnFjZefXQ77hB0yUpUORZINqHtbw80x5HeASQHzHrphN1o87wLUDo
    o+b2Dx90Cc3HLmwbZsks1v5Qe3wgVjPUMwX4Epw71mRv/T8ItHrE8RkWZrv81HY9CRlc3Z
    /OiNXFOpQwrN765XqADbyILD80acXbo1GJdpcquKP94bmw57TBOmknCC1tOk25qwSfgaav
    egwmPIOD8ZPaE7+A6cnzDiyYUxaYdFHC73rr/JrclTuz03BNq0lnxnglgQ3GRx5+ugY1s7
    zL5faEWL+Y7rjrAewAmeSgB1Dx9U3qYJX0YvlEpUacTf7ZnC/jveIa6cY7sI168ePFOeH5
    +xZ/soS/L8m4IiTs9IWGKGMUImiRqG+U+DyIEB7e6M2WcmgmxZOeNQHijmLm/Y2Jiivcx4
    oiX8VOzotZoCsjiOJNDbci9TYVaf2x8581Az8nWXRiucZL77TEfp4G2L8sjqdAJrAVFZSA
    dGYJ1UCm89ptQEdPrsO4giLbk1cN9YpyglWAnswbeEz5r9rif9jVokxaygEwhAqM9Je9zD
    HuxLZX+7L71gZVeB1NfTdIpoahdFtT8VT5JPmOxnYLcSwhbKZGFcux7lCh+g
X-ME-Proxy: <xmx:BtQnatFgtioclXSA5IVlMmUXpbhuCp0VskpcwxdbbKQryzylt0F-Wg>
    <xmx:BtQnarR8FXP_-4cSqmNNbWUdvTHMNOKZhpwtG_6vlZgT0vPVByUUxg>
    <xmx:BtQnahG8t_nhNXhS2mwlB6jsJGIJbYkUPA4d8s7Zvg-ywH495Jb8Ug>
    <xmx:BtQnav8Lc1-ceZ_yNecFuGy7v0szZROoGBg_CDQobGnQI650Q5f8KA>
    <xmx:BtQnajOW-nttaWmtrgvg0gyPTwH7qT-CoMh-BgAHsuEI1_BtEGvD20P0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Jun 2026 04:51:17 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2f8045d8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 9 Jun 2026 08:51:17 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 09 Jun 2026 10:50:57 +0200
Subject: [PATCH v2 04/17] odb/source-packed: store pointer to "files"
 instead of generic source
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-pks-odb-source-packed-v2-4-839089132c8b@pks.im>
References: <20260609-pks-odb-source-packed-v2-0-839089132c8b@pks.im>
In-Reply-To: <20260609-pks-odb-source-packed-v2-0-839089132c8b@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
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
index 327be4ad65..3c2d229a17 100644
--- a/odb/source-packed.h
+++ b/odb/source-packed.h
@@ -9,7 +9,7 @@
  * A store that manages packfiles for a given object database.
  */
 struct odb_source_packed {
-	struct odb_source *source;
+	struct odb_source_files *files;
 
 	/*
 	 * The list of packfiles in the order in which they have been most
@@ -67,6 +67,6 @@ struct odb_source_packed {
  * Allocate and initialize a new empty packfile store for the given object
  * database source.
  */
-struct odb_source_packed *odb_source_packed_new(struct odb_source *source);
+struct odb_source_packed *odb_source_packed_new(struct odb_source_files *parent);
 
 #endif
diff --git a/packfile.c b/packfile.c
index 99be5789ef..862a24ad49 100644
--- a/packfile.c
+++ b/packfile.c
@@ -802,7 +802,7 @@ struct packed_git *packfile_store_load_pack(struct odb_source_packed *store,
 
 	p = strmap_get(&store->packs_by_path, key.buf);
 	if (!p) {
-		p = add_packed_git(store->source->odb->repo, idx_path,
+		p = add_packed_git(store->files->base.odb->repo, idx_path,
 				   strlen(idx_path), local);
 		if (p)
 			packfile_store_add_pack(store, p);
@@ -990,8 +990,8 @@ void packfile_store_prepare(struct odb_source_packed *store)
 	if (store->initialized)
 		return;
 
-	prepare_multi_pack_index_one(store->source);
-	prepare_packed_git_one(store->source);
+	prepare_multi_pack_index_one(&store->files->base);
+	prepare_packed_git_one(&store->files->base);
 
 	sort_packs(&store->packs.head, sort_pack);
 	for (struct packfile_list_entry *e = store->packs.head; e; e = e->next)
@@ -1029,7 +1029,7 @@ int packfile_store_count_objects(struct odb_source_packed *store,
 	unsigned long count = 0;
 	int ret;
 
-	m = get_multi_pack_index(store->source);
+	m = get_multi_pack_index(&store->files->base);
 	if (m)
 		count += m->num_objects + m->num_objects_in_base;
 
@@ -2450,7 +2450,7 @@ static int packfile_store_for_each_prefixed_object(
 
 	store->skip_mru_updates = true;
 
-	m = get_multi_pack_index(store->source);
+	m = get_multi_pack_index(&store->files->base);
 	if (m) {
 		ret = for_each_prefixed_object_in_midx(store, m, opts, data);
 		if (ret)
@@ -2632,7 +2632,7 @@ int packfile_store_find_abbrev_len(struct odb_source_packed *store,
 	struct packfile_list_entry *e;
 	struct multi_pack_index *m;
 
-	m = get_multi_pack_index(store->source);
+	m = get_multi_pack_index(&store->files->base);
 	if (m)
 		find_abbrev_len_for_midx(m, oid, min_len, &min_len);
 

-- 
2.54.0.1136.gdb2ca164c4.dirty

