Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3472F38399A
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 11:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780572381; cv=none; b=Yb2z7TZP8elVQcPZ28IIkDf2A30pt83aKDzIY3IvwHiv2D+BwxWtNwZQf4kWSF3IvgiLr5debuKQVAQijMtG2BQ4gI0gM0Mt8uOgmE1WZ6hL8C+APA8DhAX5qmTltMkEDc8Gd40zAfTOtf47A67xWMaNYjxbbMwpSjhu1K0+jzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780572381; c=relaxed/simple;
	bh=8NzfB8xzCaqRQIdczlHDGbPMEFcBcdtdbv3Lv8XZhlg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HUbkYzK69YE3sH8kuerBI0/ffNsc6Cw5XLoA4tBs0MXpld9+yHTdC2Kmy/5NQes9i2nkGFNNOyuCgFQazXzeInmQOBKD3Ua6OwUVbDAq5hj1Anu7Ibj2vnhunsva/6J1QkHurVw/qmy7+K/36nRMqjStyY7b+Mhpt+WqmD1lXJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qcvzeW25; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j9hTsB05; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qcvzeW25";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j9hTsB05"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 843C81400133
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 07:26:19 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 04 Jun 2026 07:26:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780572379;
	 x=1780658779; bh=mCn6L6wb9IwPsfzKQaG9X8JCk1Z41lZtQr+imwxIkTU=; b=
	qcvzeW25NOKjPJgiY3j/wZTzMaWAIqMw2v0aAzJic2XM73NDObj4vqMEbcAD0973
	f2Lr5+BYGb/efJOsi70mRwO9QwxiJel26Ockjh8dcc6OHUPz93cj/EJJrR+A+rLj
	pARbrnFQmuLkKMZ7xtQEidEODYULiGr7deYe8kuZ5WIx/N92eoWHKa6X8U3/ZGMa
	aKznsBHwmNFV30Y5iBy0fiTn99XGoGPOu9d09UUKb4Ov78NVE9gq2Cb/P4N75Jry
	zH92GQBpEVR1KTCNOZG+jzbmqeNeOOTwdO6w33QFhajRjKpwuJ/d0A8zbNaA8Dpk
	tpvyqboMeNa4iBhxGYGj+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780572379; x=
	1780658779; bh=mCn6L6wb9IwPsfzKQaG9X8JCk1Z41lZtQr+imwxIkTU=; b=j
	9hTsB05yhMvxthM4S7xPPV71KzQZXcNMmmoMSTZcUGQujCS6TUyCi95IYq+RILPu
	kLd0gIkn7ETAIqJ/2gSg18qoYaLCDSKfzmM540UIMc7Cg8nc5+62VPas2KwF4Tso
	Gt6OWUV8/iCTVl7CRdmlwhutVTJCQuvR7cYXPcmLe9JcRwb22wnHqwkhTCPqXjwg
	lupfeiI7VJftAOKteFXhR+k27O2Bg6C6HcnlWQbvT/vJ20Du2Po51tH6mvA10W+Z
	EcANZFXJhQDNgYGmmp+IXHgfbQv/KO8OpR6p5c91mIWo8A5AvOi6Xls8sWs1cW/d
	puMrczSTBex938HlPVBhQ==
X-ME-Sender: <xms:22AhaqcVfkAobEvWM44BiUkQG7PzU0vkGOTtCTCkgX0dHXf05DaTgw>
    <xme:22AharJWtyuR34t9ipigp-kk0zIhZxxD5DysAMFjs4rt4W6RRyRZhyJQZcNzoeWaN
    -YjaR7GmLH39L_6eERY5BQAzO4T1QzPK7PZqES7GItgo73wS7V3>
X-ME-Received: <xmr:22AhahJBLhmJDUVmlLYclEvBWnIBTEfczr_1KOLJszmZr6VKKfbSEIc6Bz9USj_ba-mK5lbG6rBCraieRAweoHMBArAQ97uwK-X-hhYdcgs>
X-ME-Proxy-Cause: dmFkZTEAGus+32/ZT7GePV+IbXzwXZJbXLOmhp2tErhVIVsfiW4U6p2fBFtWTaP/C0Df/X
    6AjERsdF4g82DcqriqbgOzdgxgFn5Mw+gGKSeI0czvDCuhLleNDOXtw+lzwjZmn8ALr78Z
    tTwCGGKrlEP85V4cxKUEUBH0i9QuNTCa8O/izt8k4taMsQJD1wt/9XH0v9bVUfHDxyWFIH
    fNPs2T8Nelktzaejw6Sx0r23PTJlFXakuzDbDlxmRi8I6dzV0NJ0K9d9E9yrbRYa1fyV0J
    kcT1GBFXggmgPP4xm1z5hq05sXOZJqmQFusYMv5+ZtI6LHMrWf5Gyjt9PkDeczWqzbDueD
    QkDEbATJBfV0x/HzBPuU0Xe6adh5K9iBgA6kFKeBxsNvpewezhAT2k1AuHK3qgapg3ZaTx
    eVrVzSX1+NV3t+a1fb8+nD+ch4KS90E3s6uh/9x0he9DYrI5L4jUkLT3KtYAoW9F10BoTU
    OSzNVEULd9O47jx4/xDkDpumhnnppmtCh+MFK0QlEC908dZvnYmCxLMxiGCiu656aKn7YN
    YfxR4Z0PS4kpnzAF6zlOsouSgNKaZpE1kCkluVeSYHFZ2p+Tyfi9BBNO52gca+/2YON4cs
    c5Ws8pjrjgcgIEvBZC/OvcGG1cS00Pb5rFjJrWPBYlUUyrd4f39igSym3tuA
X-ME-Proxy: <xmx:22AhatFhNUg3ElMvIPG5bejMdzVLUoXjL0D1-doj53jQrJVqAE9MnA>
    <xmx:22AhamlhbcDKnxI1E5_Wc61qdVnIoeZuAsKCO9qEcHy018XL4gfJQg>
    <xmx:22AhaqK8jdALg580pBN1ANKl8bGNjp6hsoxbhj3Bx7h0aK2LTQ1oKQ>
    <xmx:22AhanbmKZS9RkzSvFv-AbUM8LjMXbUqkld6UF9Yfh9PNgL-itKAFQ>
    <xmx:22AhaoPH-dTwWnLqtV7oMJZHhiO8hr0AeyMA9TLsgx3iEKKQR_-723hl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 4 Jun 2026 07:26:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 75d178b1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 4 Jun 2026 11:26:18 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 04 Jun 2026 13:25:43 +0200
Subject: [PATCH 16/16] odb/source-packed: drop pointer to "files" parent
 source
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-pks-odb-source-packed-v1-16-2e7ab31b4b5c@pks.im>
References: <20260604-pks-odb-source-packed-v1-0-2e7ab31b4b5c@pks.im>
In-Reply-To: <20260604-pks-odb-source-packed-v1-0-2e7ab31b4b5c@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Over the last commits we have turned the packfile store into a proper
object database source that can be used as a standalone backend. As
such, it is no longer necessary to have it coupled to the "files" parent
source.

Remove the pointer to the owning "files" source so that the "packed"
source can be used as a standalone entity.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-files.c  |  2 +-
 odb/source-packed.c | 27 +++++++++++++--------------
 odb/source-packed.h |  7 ++++---
 packfile.c          |  2 +-
 4 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/odb/source-files.c b/odb/source-files.c
index fa2e18e71b..3bc6419dd7 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -269,7 +269,7 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
 	CALLOC_ARRAY(files, 1);
 	odb_source_init(&files->base, odb, ODB_SOURCE_FILES, path, local);
 	files->loose = odb_source_loose_new(odb, path, local);
-	files->packed = odb_source_packed_new(files);
+	files->packed = odb_source_packed_new(odb, path, local);
 
 	files->base.free = odb_source_files_free;
 	files->base.close = odb_source_files_close;
diff --git a/odb/source-packed.c b/odb/source-packed.c
index d513b3efc3..42c28fba0e 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -585,7 +585,7 @@ static void report_pack_garbage(struct string_list *list)
 }
 
 struct prepare_pack_data {
-	struct odb_source *source;
+	struct odb_source_packed *source;
 	struct string_list *garbage;
 };
 
@@ -593,15 +593,14 @@ static void prepare_pack(const char *full_name, size_t full_name_len,
 			 const char *file_name, void *_data)
 {
 	struct prepare_pack_data *data = (struct prepare_pack_data *)_data;
-	struct odb_source_files *files = odb_source_files_downcast(data->source);
 	size_t base_len = full_name_len;
 
 	if (strip_suffix_mem(full_name, &base_len, ".idx") &&
-	    !(files->packed->midx &&
-	      midx_contains_pack(files->packed->midx, file_name))) {
+	    !(data->source->midx &&
+	      midx_contains_pack(data->source->midx, file_name))) {
 		char *trimmed_path = xstrndup(full_name, full_name_len);
-		packfile_store_load_pack(files->packed,
-					 trimmed_path, data->source->local);
+		packfile_store_load_pack(data->source,
+					 trimmed_path, data->source->base.local);
 		free(trimmed_path);
 	}
 
@@ -626,7 +625,7 @@ static void prepare_pack(const char *full_name, size_t full_name_len,
 		report_garbage(PACKDIR_FILE_GARBAGE, full_name);
 }
 
-static void prepare_packed_git_one(struct odb_source *source)
+static void prepare_packed_git_one(struct odb_source_packed *source)
 {
 	struct string_list garbage = STRING_LIST_INIT_DUP;
 	struct prepare_pack_data data = {
@@ -634,7 +633,7 @@ static void prepare_packed_git_one(struct odb_source *source)
 		.garbage = &garbage,
 	};
 
-	for_each_file_in_pack_dir(source->path, prepare_pack, &data);
+	for_each_file_in_pack_dir(source->base.path, prepare_pack, &data);
 
 	report_pack_garbage(data.garbage);
 	string_list_clear(data.garbage, 0);
@@ -675,7 +674,7 @@ void odb_source_packed_prepare(struct odb_source_packed *source)
 		return;
 
 	prepare_multi_pack_index_one(source);
-	prepare_packed_git_one(&source->files->base);
+	prepare_packed_git_one(source);
 
 	sort_packs(&source->packs.head, sort_pack);
 	for (struct packfile_list_entry *e = source->packs.head; e; e = e->next)
@@ -733,14 +732,14 @@ static void odb_source_packed_free(struct odb_source *source)
 	free(packed);
 }
 
-struct odb_source_packed *odb_source_packed_new(struct odb_source_files *parent)
+struct odb_source_packed *odb_source_packed_new(struct object_database *odb,
+						const char *path,
+						bool local)
 {
 	struct odb_source_packed *packed;
 
 	CALLOC_ARRAY(packed, 1);
-	odb_source_init(&packed->base, parent->base.odb, ODB_SOURCE_PACKED,
-			parent->base.path, parent->base.local);
-	packed->files = parent;
+	odb_source_init(&packed->base, odb, ODB_SOURCE_PACKED, path, local);
 	strmap_init(&packed->packs_by_path);
 
 	packed->base.free = odb_source_packed_free;
@@ -758,7 +757,7 @@ struct odb_source_packed *odb_source_packed_new(struct odb_source_files *parent)
 	packed->base.read_alternates = odb_source_packed_read_alternates;
 	packed->base.write_alternate = odb_source_packed_write_alternate;
 
-	if (!is_absolute_path(parent->base.path))
+	if (!is_absolute_path(path))
 		chdir_notify_register(NULL, odb_source_packed_reparent, packed);
 
 	return packed;
diff --git a/odb/source-packed.h b/odb/source-packed.h
index 6645f4f943..ef5a10b224 100644
--- a/odb/source-packed.h
+++ b/odb/source-packed.h
@@ -18,7 +18,6 @@ struct packfile_list_entry {
  */
 struct odb_source_packed {
 	struct odb_source base;
-	struct odb_source_files *files;
 
 	/*
 	 * The list of packfiles in the order in which they have been most
@@ -74,9 +73,11 @@ struct odb_source_packed {
 
 /*
  * Allocate and initialize a new empty packfile store for the given object
- * database source.
+ * database.
  */
-struct odb_source_packed *odb_source_packed_new(struct odb_source_files *parent);
+struct odb_source_packed *odb_source_packed_new(struct object_database *odb,
+						const char *path,
+						bool local);
 
 /*
  * Cast the given object database source to the packed backend. This will cause
diff --git a/packfile.c b/packfile.c
index d7de0412ff..478f00ce02 100644
--- a/packfile.c
+++ b/packfile.c
@@ -884,7 +884,7 @@ struct packed_git *packfile_store_load_pack(struct odb_source_packed *store,
 
 	p = strmap_get(&store->packs_by_path, key.buf);
 	if (!p) {
-		p = add_packed_git(store->files->base.odb->repo, idx_path,
+		p = add_packed_git(store->base.odb->repo, idx_path,
 				   strlen(idx_path), local);
 		if (p)
 			packfile_store_add_pack(store, p);

-- 
2.54.0.1064.gd145956f57.dirty

