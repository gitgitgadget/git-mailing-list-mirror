Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F21308F03
	for <git@vger.kernel.org>; Tue,  6 Jan 2026 06:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767682524; cv=none; b=CEZ8I5AdRezTFKoH5h0EI25/t7oTIM9+nu4cgdMaOKjbP9KfiG1Ql4NcqBcKYeqMpowU/r5hQ/74cnn9dxf6bJ5SmrFKN4m+zPaJWtlJ2Zh2jNRZ0or6UfYGiK4YJqEcMmvOT/l+lAmVHOb4d35azxHkz50ZnY96bR0wGPq/13I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767682524; c=relaxed/simple;
	bh=rnxal6iXdrwavDwCkDBnbn950i4d+MVKojQAcdbn7wU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fJt3YA6rAhv2NknBFd7UTvnciExQLsN2pKkFZP0c6xx1m4XBrgdsgRGf8Kdq6WGlDWnyMNvhxrUT+GQAGh7gMndcXQLd2heOmowmeyu4WzGxpNOa9o4tZLGdSg04fty2xOxG5zaOXr59ytPmYZDbHZita1Ho6tRtTVXSpnSn7VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bKhnfmA4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uWA9mpzN; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bKhnfmA4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uWA9mpzN"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4CCFB7A00E7;
	Tue,  6 Jan 2026 01:55:22 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 06 Jan 2026 01:55:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767682522;
	 x=1767768922; bh=utKtObeEMt1sgxrPdlcJM6gDBN++5qq1nwezh+83jH8=; b=
	bKhnfmA4mj3s82gAVsGlGf7elEx23obZBcaZoUq8+P3AcKq77lh5/igD8mFVMzaS
	xPF/LlotqmuTxYkaD7RjgxT13eXdwkcY87YQIuZOFeo2ctToSwrT15z+akru6EML
	0KmmxxvFuuBOTNUSICDqyusMuOAhJEPvcwCAxG9RWhZEOmGWfv0v2v4jVUj9/wUP
	rcsOFE6KUZLwFdePL/3CX5jOK8fZWpJkKWfpELlrP+bi/bQLvZXc8uyKH5jXvD3u
	jt/oRHjzhqKoAZhHtXT7PPnY8EH0ZZ0pUGj/cVraPOVcP3n78nVZs5FTLEPTCBH8
	FjBS5csn0FjirLX75I8d3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767682522; x=
	1767768922; bh=utKtObeEMt1sgxrPdlcJM6gDBN++5qq1nwezh+83jH8=; b=u
	WA9mpzNr1LXLWjVitxOvpIjXEHfpGJVRnwg1+ngkYVGLA3utlDsZUKAdT9ha8ti/
	wk0Wq6wwred9p4Y5oaf8NQKLyWSAoH5t0yutPqypnTEmHlQIg10QjWQqu0p3oPaQ
	sHcSoRATdTbxWLt6QlDKeGRiuqIiKinvs4BCSgZykGn43fpDRrT5VBDves2naABl
	SOMWt0xCbWTlTmcuok5dQLYh0v+XX28uyjTf4TwXJ6SMtcLPO1W1l4omHTjLnOXD
	PVTfjlfW7qmos/H4oCkghIk+HvbZCQ2s/CsP06Z8DgJ+v/+nrLOsdiA+iaoQ2X0j
	/L38QHvsTNoWDFbQdi/fQ==
X-ME-Sender: <xms:2rFcae-Cy39hyfqzdcC_I-_sFQvp_z4_P8cfRMOsKYkv4Rox4tR9bg>
    <xme:2rFcaVlgylIxW9zdR769tfq8ZBRT21CaMJBowPezoRinVKwGK9MkujrFBnNflJpci
    1e4i1HTO8fjD8tQ5iIzjDIuewODzvTVPkEICx0v_5bMhVI_F7_4aQ>
X-ME-Received: <xmr:2rFcacWO2bUpD2a344ICsclsqWin0ukFtSsKS673ZQqnORU0-ZL7nQVNnTiEzKBPZBC5dgYiZyaGvJxibQnRAuUPMrk12V5PQrqQHDvy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdelleehvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhr
    tghpthhtoheprghplhgrthhtnhgvrhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepkh
    hrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:2rFcaSHyI90spV7H_OzubOUewIde1v8uAabhaZJILAHK6D20PvwH1w>
    <xmx:2rFcaQd7WX0WyocG6QNFc4SXrpAzNmcjtdyfuIWfs6W3A6A7Mr0UQw>
    <xmx:2rFcabIFEkTD0oH6Z2YJp3RJnwChwJkCNWQveKkdWIF5vIPuKw-P0w>
    <xmx:2rFcadGgGx-6C2cQfqf_melr892hDoHjTZFcPrU827HCKzug-d1Mrg>
    <xmx:2rFcaQLcweNCaWPcZkY7KBUPbNHImPcpZVbKFmwxRmQXu_orY2Bw9Wki>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jan 2026 01:55:21 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1c935b78 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 6 Jan 2026 06:55:20 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 06 Jan 2026 07:55:03 +0100
Subject: [PATCH v3 7/7] packfile: drop repository parameter from
 `packed_object_info()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-b4-pks-odb-read-object-info-improvements-v3-7-b5e02fae1fb0@pks.im>
References: <20260106-b4-pks-odb-read-object-info-improvements-v3-0-b5e02fae1fb0@pks.im>
In-Reply-To: <20260106-b4-pks-odb-read-object-info-improvements-v3-0-b5e02fae1fb0@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Aaron Plattner <aplattner@nvidia.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.3

The function `packed_object_info()` takes a packfile and offset and
returns the object info for the corresponding object. Despite these two
parameters though it also takes a repository pointer. This is redundant
information though, as `struct packed_git` already has a repository
pointer that is always populated.

Drop the redundant parameter.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/cat-file.c     | 3 +--
 builtin/pack-objects.c | 4 ++--
 commit-graph.c         | 2 +-
 pack-bitmap.c          | 3 +--
 packfile.c             | 8 ++++----
 packfile.h             | 3 +--
 6 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 505ddaa12f..2ad712e9f8 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -487,8 +487,7 @@ static void batch_object_write(const char *obj_name,
 			data->info.sizep = &data->size;
 
 		if (pack)
-			ret = packed_object_info(the_repository, pack,
-						 offset, &data->info);
+			ret = packed_object_info(pack, offset, &data->info);
 		else
 			ret = odb_read_object_info_extended(the_repository->objects,
 							    &data->oid, &data->info,
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 1ce8d6ee21..85762f8c4f 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2411,7 +2411,7 @@ static void drop_reused_delta(struct object_entry *entry)
 
 	oi.sizep = &size;
 	oi.typep = &type;
-	if (packed_object_info(the_repository, IN_PACK(entry), entry->in_pack_offset, &oi) < 0) {
+	if (packed_object_info(IN_PACK(entry), entry->in_pack_offset, &oi) < 0) {
 		/*
 		 * We failed to get the info from this pack for some reason;
 		 * fall back to odb_read_object_info, which may find another copy.
@@ -3748,7 +3748,7 @@ static int add_object_entry_from_pack(const struct object_id *oid,
 		struct object_info oi = OBJECT_INFO_INIT;
 
 		oi.typep = &type;
-		if (packed_object_info(the_repository, p, ofs, &oi) < 0) {
+		if (packed_object_info(p, ofs, &oi) < 0) {
 			die(_("could not get type of object %s in pack %s"),
 			    oid_to_hex(oid), p->pack_name);
 		} else if (type == OBJ_COMMIT) {
diff --git a/commit-graph.c b/commit-graph.c
index 80be2ff2c3..f572670bd0 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1499,7 +1499,7 @@ static int add_packed_commits(const struct object_id *oid,
 		display_progress(ctx->progress, ++ctx->progress_done);
 
 	oi.typep = &type;
-	if (packed_object_info(ctx->r, pack, offset, &oi) < 0)
+	if (packed_object_info(pack, offset, &oi) < 0)
 		die(_("unable to get type of object %s"), oid_to_hex(oid));
 
 	if (type != OBJ_COMMIT)
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 8ca79725b1..972203f12b 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1876,8 +1876,7 @@ static unsigned long get_size_by_pos(struct bitmap_index *bitmap_git,
 			ofs = pack_pos_to_offset(pack, pos);
 		}
 
-		if (packed_object_info(bitmap_repo(bitmap_git), pack, ofs,
-				       &oi) < 0) {
+		if (packed_object_info(pack, ofs, &oi) < 0) {
 			struct object_id oid;
 			nth_bitmap_object_oid(bitmap_git, &oid,
 					      pack_pos_to_index(pack, pos));
diff --git a/packfile.c b/packfile.c
index a2ba237ce7..39899aec49 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1580,7 +1580,7 @@ static void add_delta_base_cache(struct packed_git *p, off_t base_offset,
 	hashmap_add(&delta_base_cache, &ent->ent);
 }
 
-int packed_object_info(struct repository *r, struct packed_git *p,
+int packed_object_info(struct packed_git *p,
 		       off_t obj_offset, struct object_info *oi)
 {
 	struct pack_window *w_curs = NULL;
@@ -1594,7 +1594,7 @@ int packed_object_info(struct repository *r, struct packed_git *p,
 	 * a "real" type later if the caller is interested.
 	 */
 	if (oi->contentp) {
-		*oi->contentp = cache_or_unpack_entry(r, p, obj_offset, oi->sizep,
+		*oi->contentp = cache_or_unpack_entry(p->repo, p, obj_offset, oi->sizep,
 						      &type);
 		if (!*oi->contentp)
 			type = OBJ_BAD;
@@ -1635,7 +1635,7 @@ int packed_object_info(struct repository *r, struct packed_git *p,
 
 	if (oi->typep) {
 		enum object_type ptot;
-		ptot = packed_to_object_type(r, p, obj_offset,
+		ptot = packed_to_object_type(p->repo, p, obj_offset,
 					     type, &w_curs, curpos);
 		if (oi->typep)
 			*oi->typep = ptot;
@@ -2170,7 +2170,7 @@ int packfile_store_read_object_info(struct packfile_store *store,
 	if (!oi)
 		return 0;
 
-	ret = packed_object_info(store->odb->repo, e.p, e.offset, oi);
+	ret = packed_object_info(e.p, e.offset, oi);
 	if (ret < 0) {
 		mark_bad_packed_object(e.p, oid);
 		return -1;
diff --git a/packfile.h b/packfile.h
index d7cce582af..33fed26362 100644
--- a/packfile.h
+++ b/packfile.h
@@ -382,8 +382,7 @@ extern int do_check_packed_object_crc;
  * Look up the object info for a specific offset in the packfile.
  * Returns zero on success, a negative error code otherwise.
  */
-int packed_object_info(struct repository *r,
-		       struct packed_git *pack,
+int packed_object_info(struct packed_git *pack,
 		       off_t offset, struct object_info *);
 
 void mark_bad_packed_object(struct packed_git *, const struct object_id *);

-- 
2.52.0.508.g883dcfc63e.dirty

