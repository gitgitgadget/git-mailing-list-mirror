Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34981AD24
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 10:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766055289; cv=none; b=BVKA/kvX7JUbl1/GE2Zs4rY9zxrAwuKkRIk63zjYCwvkUgnF7BVNL3YgOuSslwi8ppmfuL8TB2D5Yz9SyKhXc/L+yKAuEQvZA7nEoFXDKHjQ4yJQP7X4RSsZKiLyaZqVbKdduCD14sj3DqgrKIJZ2f8frm5ew5ILXcW/wF1wK6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766055289; c=relaxed/simple;
	bh=zrPCSaO08W291DTMmUsGoeayL0CevOvHxVIuWMIoo+k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ty8VimJcOgtQ7Qw/BzHI/ubp7d1B2ma1UktbnrY5DU705JE0tae8lgyd1993QSE82zaqvKdB2I954MLylQlFADsrt22iGz2sFnus3adRKzfgYMwx4rhZWGgjA9IYYE2ja/5Tm9jH7bbNUieArFrELurUyroh2AR+0vy9/QjO3Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tX0/GsLJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AWrLgmsQ; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tX0/GsLJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AWrLgmsQ"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F07A67A01A2;
	Thu, 18 Dec 2025 05:54:42 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 18 Dec 2025 05:54:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1766055282;
	 x=1766141682; bh=4d7Nsu6qkl3VwC92W77Z2QBWp0/0sAWxCZOzNfm9ye0=; b=
	tX0/GsLJouXXyKj2JwHeCYB2/PUaLglF3g9V0wXFArM93RkBxsWFGdWxfENfQ8Vr
	NUcyZs4xcAoSs48hy5PlyTLVTQI2h9w353jne+fU8Qz06zKYHRHZPvLR3d3L4fsb
	e74ih4ZzSGgJXgMUg9Ooqj+4JKBa9WXkYpTecXP5j5tSMQF4/9TqQZS9Rh5v/eoP
	36G0roujhx5BSYkd6u6x1H2v5QvS8S+BP7rDKSibh3mFwuTL5BqrOzEPmNR++63W
	HD+mgrl4gPRJunGZJ1HL1G448KuM9Jqi57roiDkYUuMveMCTTTnclVEqs/JKGwtB
	BTISMNJf41J0uC+CaslLpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766055282; x=
	1766141682; bh=4d7Nsu6qkl3VwC92W77Z2QBWp0/0sAWxCZOzNfm9ye0=; b=A
	WrLgmsQZg4iLSENyLn10zyPEsZRbcUfSnx59UJpT/h5Bs71l4TRpUiOsvYpOx6gk
	9qwV42AHXrvl/kaubXSn4mmXgnMNFC7qFTa48gSFreTlIn5ha/dm9v704h7ya8GX
	h+ZptE43huVS+s3c2mGWw1yhlI58FtY4MXYYfFn5wSupNfnnyXRWSlQUqTlCxe4a
	IMWhIKRcUnwzWfQhjoHT6QraWxpCRuBbuO6G4arnxYk26pES9MjH7Gv01thkzygY
	yX+ba42jLmN8Y/eyEeA6AMLLiRq3KFXm+SBPcGiJB4W1gLitI1oLc6yHbCNxe1c3
	CSwyyyYMs45CVpjz7QPXQ==
X-ME-Sender: <xms:ct1DaflJd9_JCjDQ2yheLUbe8IhhnovKbVZjWI14G46qz2a2T4leXQ>
    <xme:ct1DaaQsniMjCS8Q5sXl_hNTGi0HLWfQwPUeSpquWTVcYK6giWbCRflPIzUEL6BU6
    l5MpuDfGFObEU6hsqHQfooUAWuF8kw80nDkKyhCbe2Yh3hi8UCBIw>
X-ME-Received: <xmr:ct1DaTBiItrSK-52JHkWJ_QO3rE4Yy4sGAZ3ycvTIxahyqTSpxwGOGqpLAA0UrprUFYaFW99tR0CY5htvRZtrtkNiHQCowXcubieGa8Wjg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeghedvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrphhlrghtth
    hnvghrsehnvhhiughirgdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:ct1DaRRy5dFKzrlPHh2loKCVzLRA3Uyvm5nyCpl_a7BWrlk7IL1DLA>
    <xmx:ct1DaRoGAXA7Vkiv3I9zBadb4TyaahNDa6i0hBkFglEL02ex25vNgQ>
    <xmx:ct1DaTx2dNLzt_54fw8N7Y8Syr8LXZoM8YYOE0TSMFR8X8BhVxu59w>
    <xmx:ct1DaWJJ87K4j8AhmY4V7tD8IKb2ptIJmzC3-Ty7cinPuh5YXGg93Q>
    <xmx:ct1DaY6ZNYBPG5n3jEZsDeeGv9vz1Nb98RFcId5l2wP5ZPDim8HI0r0U>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Dec 2025 05:54:42 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 83de41f6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 18 Dec 2025 10:54:41 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 18 Dec 2025 11:54:19 +0100
Subject: [PATCH v2 7/7] packfile: drop repository parameter from
 `packed_object_info()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-b4-pks-odb-read-object-info-improvements-v2-7-62e3e49072bc@pks.im>
References: <20251218-b4-pks-odb-read-object-info-improvements-v2-0-62e3e49072bc@pks.im>
In-Reply-To: <20251218-b4-pks-odb-read-object-info-improvements-v2-0-62e3e49072bc@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Aaron Plattner <aplattner@nvidia.com>
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
index 07f5bfbc4f..573d06f6ba 100644
--- a/packfile.h
+++ b/packfile.h
@@ -382,8 +382,7 @@ extern int do_check_packed_object_crc;
  * Look up the object info for a specific offset in the packfile.
  * success, a negative error code otherwise.
  */
-int packed_object_info(struct repository *r,
-		       struct packed_git *pack,
+int packed_object_info(struct packed_git *pack,
 		       off_t offset, struct object_info *);
 
 void mark_bad_packed_object(struct packed_git *, const struct object_id *);

-- 
2.52.0.351.gbe84eed79e.dirty

