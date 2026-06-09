Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C03E3F44F9
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 08:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780995114; cv=none; b=fonomRkWRylFujtzU/SFTGMKXXSW/SiG/Q76XSonsUX5mlxUmflQm2pXp1weZq1QXYqr2OT+dZUUL3BsPjXZGQ6ZI85BLPzDrYnSrnEsDeCBeIo0nwa6kayxqYQtFClUjVkFnXA+vN7o1nsLpbJO4xhmcfjoXXmgb6xPrMuZuI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780995114; c=relaxed/simple;
	bh=31BjxTezT5BGRPWpb7wEb9SXgz23ddwnIJMmPgoj4nY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RgTCtKF2h7BP1GY1A3W8a14pDzhgu6NFlXLgNNJW8Y2JnbgTtc9vZxDaMYR69ivDlitcrg2yrUvfckDhdtoH0pPpMlejsX1FPaf7KPSjbiPaV44bZiJG7IJu9ifgL0wkV5X8w0y8J8aNRqQKiaV++s1HPnBPgqDfYoyf8fifIw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oE2SZuNz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Mryq4PtG; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oE2SZuNz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Mryq4PtG"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 2C1401D00169;
	Tue,  9 Jun 2026 04:51:51 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 09 Jun 2026 04:51:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780995111;
	 x=1781081511; bh=aDt2Ey4Fvj5O476BsBq/9sItgNU67hnkVHexvOLFzXk=; b=
	oE2SZuNzUFPC2mvnODnyXgDSeEzz8uOKsx7HczDVxsYNT3wK09gZoM/QKy5yLvOG
	3aOqoLaH1mPYz5DJfg6JBp1/ys7i3L9yzXl11mPIq8KH7fiNssL8iK65xbU5Inmf
	69ikfFjXcjqEGbsgyWyX0ZCxosC8ghdLARA6cxm+03BUTTW7dmOJZvRZJYZskrj7
	ZHzyxg/Oh/L4y7FgR7koRqBMIsUfp9e1aOWDu8WjklVCne4dUvMhHgXUCP/XqLYy
	xrNa7WyUs56abosNYLUhmCpTjkbFjjizzAOzUByf9gh9BoCh9/J485r3cuCsiFBp
	Tt8Z68fiVFfShLlukF5bog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780995111; x=
	1781081511; bh=aDt2Ey4Fvj5O476BsBq/9sItgNU67hnkVHexvOLFzXk=; b=M
	ryq4PtGi5MB6/tpmGQEj7JIHU8soqgr5/A0s2W8hT7bIa9pXC1Kz0/sSuo/xAbMj
	g/D7xKAU5e5HcfEwwOwXiM44mUJO7ooS0ncmN92wMb0fINKIuaOV4+HhIIuHyZhZ
	yasMihwL6MvUXl8+aXZcm2MJX+O/pCBJ42aKC/klapboZa4HiVnacZyIYH/oYavt
	yTHIPEIMKya4y7zp6F6QJgkJxcXPrBv09yj2SB/129iXTVrxiRpY9NCpVp65ppw/
	LN+kg6aHHxZfqveGSbg+F4TGZElAL7c6tPQasvb3eqP2oCB1WtOv5LSX+gCBJbX0
	p7Tz4icypIdcrTvt3h6gg==
X-ME-Sender: <xms:JtQnaraOlBFidrX9XhFJZR2wrWyteYIdsCEhyVubG6gXBXHRvZ2aww>
    <xme:JtQnagbn0zBKYadhpcWW4IS4PTu9yJodMemOVTjuEP7_cHxH3kBpGDJRAoSawoVQ-
    hOnniyaPXzC5Dwb5s_aWyc9ldZ8UGxmbga7WD-zS-D7eTswhZXeJw>
X-ME-Received: <xmr:JtQnarm3mY0clmv5vKs_F1N4R1NVkj4lysAS-81i2eJdDR2QDtVrWq05PbzbKGg2xLhQ_SWV95nNYVHCbvsEKfuoudmkNeUVIZsmEK9_3Fg>
X-ME-Proxy-Cause: dmFkZTGHcLQNSpLSt/NXdkOaoJkTmvj04CJZqgn+zAvtnJsraJpdZ0ddSiSTFtEp0UEZbO
    /Wl8U+7383P89z8nu4XASlnQ0kEwbP0rvN/aGyp2/lJ60oOrnWlnHeg9FJVKkfykX6zHax
    e9cZL63tpGUrA2jT5KaI4nhsaz14vnFe8cHnENfZPuPThc3Ak/Uu7FrNhe5Unv1HQX9xMJ
    pBu6IPmTnfEwyXoirtywFzr6e0eFBa9JIGgo417lo6KFvgvzWWgi3TArqhDtqUygUobbk3
    ZRlDMR7g6RGBjmfVBDf2lq2Bs7vhbVY+ufr2Ex/bUSpOg8GNJp996m8x+U/hw4z4iOXXtT
    lRc+XJQOnuryvT6uLqDPxItG2oONoKzSFmtA6RDqBOMQR7eVlgx8RD6fxU4D7QfPrKpWCs
    eNDkH3q/DiMPmkDETi7ieoKQVQ+N7VwAHiyzBqoYhYYl1U7yr23uhvhNbzeV4F6vE+sSmM
    FKUHf9AroaBH5ez0UwgoT3o/+quDg2ScnbtN1WrdTwDVTxChhAoGf2QL02iM7Cv6f8sz/k
    0jHl0igZNyhylK0uSxdesCwU6A/6DcD0LjD6/FyeS30HiecqGfhvvlODhHxqVHIqbh30f+
    pNjbyF0H6TB/4NpbQe2GV3LuF1UnZxoj6cLhudyl0ZFssSvbSCwyDzOdFQ6g
X-ME-Proxy: <xmx:JtQnasy46VmXddZWC7ruo0ZJEHq3K9L8ZaMfNiTcsRk_iMBiGRbfjg>
    <xmx:JtQnapN0YXKDMTIzzkUZEIrfbFkxe9Dm10AgggcYsK0TcAXQixsAeA>
    <xmx:JtQnagSgVtF0MSwdEAwW8w7u0-4FcaDAzls6LCqgnBjNuzw-EbmbnQ>
    <xmx:JtQnanZs6sx3PtAYOdAtpid8eokQFHEe76APiBiapVwKU4fAWg-bsg>
    <xmx:J9QnahIFs5fEZ-84tMSdh17xcf5MEgugIpVbOhXQipZQczQkdtDzrGQN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Jun 2026 04:51:50 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 18d7b1a1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 9 Jun 2026 08:51:49 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 09 Jun 2026 10:51:10 +0200
Subject: [PATCH v2 17/17] odb/source-packed: drop pointer to "files" parent
 source
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-pks-odb-source-packed-v2-17-839089132c8b@pks.im>
References: <20260609-pks-odb-source-packed-v2-0-839089132c8b@pks.im>
In-Reply-To: <20260609-pks-odb-source-packed-v2-0-839089132c8b@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
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
index 9d4796261a..88994098c1 100644
--- a/odb/source-packed.h
+++ b/odb/source-packed.h
@@ -10,7 +10,6 @@
  */
 struct odb_source_packed {
 	struct odb_source base;
-	struct odb_source_files *files;
 
 	/*
 	 * The list of packfiles in the order in which they have been most
@@ -66,9 +65,11 @@ struct odb_source_packed {
 
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
index a577275d4f..59cee7925d 100644
--- a/packfile.c
+++ b/packfile.c
@@ -801,7 +801,7 @@ struct packed_git *packfile_store_load_pack(struct odb_source_packed *store,
 
 	p = strmap_get(&store->packs_by_path, key.buf);
 	if (!p) {
-		p = add_packed_git(store->files->base.odb->repo, idx_path,
+		p = add_packed_git(store->base.odb->repo, idx_path,
 				   strlen(idx_path), local);
 		if (p)
 			packfile_store_add_pack(store, p);

-- 
2.54.0.1136.gdb2ca164c4.dirty

