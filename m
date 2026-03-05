Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00ADD248873
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 14:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772720395; cv=none; b=J0nEsz4GHkHgq6wvzhiLqdqgn+eCoXJaJSIKy5A3A1UdYX3A+qsrrOANyKvAm7heSPUrI5XB1lLQd8YcCs7GKuIBLgk3aiXVsM8gFVtBdtY1R3AC8XfoktUFOI3pMvsMKOPY4F/Qhf9rMF3TmYGbTHK/h9jVM57jELzO5calTUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772720395; c=relaxed/simple;
	bh=tXl6ZFGT+/aH8yeTyDYI96tkaPMzTm6aDqYzPE+4s6E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pDdhBBxTNwZ4BZXguaeFY5puVAXPs6DJoClz5JMOmvEc5l5tU+NzVQhgcgWEQic95z621U9Zt3uxvuTj7FPeKaxEBRsTEk8IEzXZuAumK/HOb9L//hsBnSVZhfbkRe0Oiyapo8o2TOKGVXXWia/iDLWBfgdpI7rqRg0Ropze7UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FKenOpAb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=af+SSdgX; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FKenOpAb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="af+SSdgX"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4BC6F7A0017;
	Thu,  5 Mar 2026 09:19:53 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 05 Mar 2026 09:19:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1772720393;
	 x=1772806793; bh=82nPMyKA2eMzBqg7FjZcpxh55oiWNMuqJkAuNdQVGWE=; b=
	FKenOpAbYCdMHtT6sCJcqqV9/hQBwoZgba3rmOCJ0Agv2wY1LOfb42sDv+DUwL2P
	RoP8UIOk6vs9RbxHTHLd2WAFaz6+SB7ppQ1gBd79AaXCAnqkHIjThNJsMCJreaAd
	m4zjk5eCkb2ScNMhVzX9E2ne05/m6HcDclVCcr2Z/+ceMvMSuGszzAgFyaohQlrm
	UGxfTi7S2Vaj9PQwm7dF45Kke1zM3pGrcqIohwZueaCzfo4OPeget/18+N6WIK3b
	5Q9jtPOGeXoWJF0e0TG96OCUh/IbrubEarcKOG6X4AS4GSODnBorBowfgdJuVc48
	1In1YQWSathtM8y6l+vacA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772720393; x=
	1772806793; bh=82nPMyKA2eMzBqg7FjZcpxh55oiWNMuqJkAuNdQVGWE=; b=a
	f+SSdgXHw3doCEZhpAdf0B3C2xCFudho3JxlwM05jTMd2G00DPJJyai5aWVSDZha
	J/bO19L2/w/eHvyfIP9nws4pbUtVnep1Qtk+aczqDmdOUEUv8TzcTJ6kaWXxVJAu
	/d7z/tRyXpfTLKcl/7lgJ/EDR8+7r70k+9N6BY7+NMWqRad2KPyHJG4aYORpxeGx
	X+2Xeve1i7wPQSwsl7hRGsqm68BuAiJ4PwwsSaHsXpbaEoH0Q4jux21XpaJ8uSIA
	oacftVshkfg+0mjkTrD5+m2KBNnkHxUi8UhsjdQAYZcLb8cJrZLQW74Z2yGWCJeH
	tqjAorPzsTv9cRXjEO72w==
X-ME-Sender: <xms:CZGpaXSGe-6-i3cA9ujOTb6NBpu4ZuhRQsGNlWJTQuRt1fVcOD7OhQ>
    <xme:CZGpafw3g3NguU-EP2sJJmOCWfFacq6h3p0M-pKAayV6u17Xwxnhzgqw65Pi1LNzf
    L3l5kUqh3LC9LgFFMMXWdeXuVwAs-bHVHfHj4e_r4YUrfNQMUtsEg>
X-ME-Received: <xmr:CZGpaR1MZaUOSHAI1KUEC_cDS-5iygDIm-uVl_6C84LQuezyILz5fKOmV79vpsxvYRakuTH8Paqy2-y-MiJb1UWbrtFOMzMZ3ygZk4XJqngo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieeiiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeejkefgjeetueetffdttddujeeugedvgffflefhgfdvgfffhfeugfegieevfeevvden
    ucffohhmrghinheptgdukedqqddqqddqqddqqddqmhgvshhonhdrsghuihhlugenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdr
    ihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
    dprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:CZGpaV6EX5h-ATO6A31ZkSyLKsReLuM9hvu8BycLBQEWB-uTR2Xtlg>
    <xmx:CZGpacUFgenhiJPD8gMo0zyLjk4TEw_o7KnxVVEZxmN8QRSwDBkgqA>
    <xmx:CZGpacDAUM2MsrtkVQqKYZIOz1pr_kQKdHGXHmZtqeMUKN3a-OvO6A>
    <xmx:CZGpaT6lebH0b38LZlJtb6QhKJkBjf2qeNbmbE6_KWGw9dNYDyI2Ug>
    <xmx:CZGpaZXY2L7qsZIDLSwQeN6v1a4LAcgNPtnkANIvSnWFPL_TH5FFTkU8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Mar 2026 09:19:52 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b6da4cd2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Mar 2026 14:19:51 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 05 Mar 2026 15:19:42 +0100
Subject: [PATCH v2 02/17] odb: introduce "files" source
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260305-b4-pks-odb-source-pluggable-v2-2-3290bfd1f444@pks.im>
References: <20260305-b4-pks-odb-source-pluggable-v2-0-3290bfd1f444@pks.im>
In-Reply-To: <20260305-b4-pks-odb-source-pluggable-v2-0-3290bfd1f444@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

Introduce a new "files" object database source. This source encapsulates
access to both loose object files and the packfile store, similar to how
the "files" backend for refs encapsulates access to loose refs and the
packed-refs file.

Note that for now the "files" source is still a direct member of a
`struct odb_source`. This architecture will be reversed in the next
commit so that the files source contains a `struct odb_source`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile               |  1 +
 builtin/cat-file.c     |  2 +-
 builtin/fast-import.c  |  6 +++---
 builtin/grep.c         |  2 +-
 builtin/index-pack.c   |  2 +-
 builtin/pack-objects.c |  8 ++++----
 commit-graph.c         |  2 +-
 http.c                 |  2 +-
 loose.c                | 18 +++++++++---------
 meson.build            |  1 +
 midx.c                 | 18 +++++++++---------
 object-file.c          | 24 ++++++++++++------------
 odb.c                  | 12 ++++++------
 odb/source-files.c     | 23 +++++++++++++++++++++++
 odb/source-files.h     | 24 ++++++++++++++++++++++++
 odb/source.c           |  6 ++----
 odb/source.h           |  9 ++++-----
 odb/streaming.c        |  2 +-
 packfile.c             | 16 ++++++++--------
 packfile.h             |  4 ++--
 20 files changed, 114 insertions(+), 68 deletions(-)

diff --git a/Makefile b/Makefile
index 116358e484..c05285399c 100644
--- a/Makefile
+++ b/Makefile
@@ -1215,6 +1215,7 @@ LIB_OBJS += object-name.o
 LIB_OBJS += object.o
 LIB_OBJS += odb.o
 LIB_OBJS += odb/source.o
+LIB_OBJS += odb/source-files.o
 LIB_OBJS += odb/streaming.o
 LIB_OBJS += oid-array.o
 LIB_OBJS += oidmap.o
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 53ffe80c79..01a53f3f29 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -882,7 +882,7 @@ static void batch_each_object(struct batch_options *opt,
 		struct object_info oi = { 0 };
 
 		for (source = the_repository->objects->sources; source; source = source->next) {
-			int ret = packfile_store_for_each_object(source->packfiles, &oi,
+			int ret = packfile_store_for_each_object(source->files->packed, &oi,
 								 batch_one_object_oi, &payload, flags);
 			if (ret)
 				break;
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index b8a7757cfd..627dcbf4f3 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -900,7 +900,7 @@ static void end_packfile(void)
 		idx_name = keep_pack(create_index());
 
 		/* Register the packfile with core git's machinery. */
-		new_p = packfile_store_load_pack(pack_data->repo->objects->sources->packfiles,
+		new_p = packfile_store_load_pack(pack_data->repo->objects->sources->files->packed,
 						 idx_name, 1);
 		if (!new_p)
 			die(_("core Git rejected index %s"), idx_name);
@@ -982,7 +982,7 @@ static int store_object(
 	}
 
 	for (source = the_repository->objects->sources; source; source = source->next) {
-		if (!packfile_list_find_oid(packfile_store_get_packs(source->packfiles), &oid))
+		if (!packfile_list_find_oid(packfile_store_get_packs(source->files->packed), &oid))
 			continue;
 		e->type = type;
 		e->pack_id = MAX_PACK_ID;
@@ -1187,7 +1187,7 @@ static void stream_blob(uintmax_t len, struct object_id *oidout, uintmax_t mark)
 	}
 
 	for (source = the_repository->objects->sources; source; source = source->next) {
-		if (!packfile_list_find_oid(packfile_store_get_packs(source->packfiles), &oid))
+		if (!packfile_list_find_oid(packfile_store_get_packs(source->files->packed), &oid))
 			continue;
 		e->type = OBJ_BLOB;
 		e->pack_id = MAX_PACK_ID;
diff --git a/builtin/grep.c b/builtin/grep.c
index 5b8b87b1ac..c8d0e51415 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1219,7 +1219,7 @@ int cmd_grep(int argc,
 
 			odb_prepare_alternates(the_repository->objects);
 			for (source = the_repository->objects->sources; source; source = source->next)
-				packfile_store_prepare(source->packfiles);
+				packfile_store_prepare(source->files->packed);
 		}
 
 		start_threads(&opt);
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index b67fb0256c..f0cce534b2 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1638,7 +1638,7 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 			    hash, "idx", 1);
 
 	if (do_fsck_object && startup_info->have_repository)
-		packfile_store_load_pack(the_repository->objects->sources->packfiles,
+		packfile_store_load_pack(the_repository->objects->sources->files->packed,
 					 final_index_name, 0);
 
 	if (!from_stdin) {
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 242d1c68f0..0c3c01cdc9 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1531,7 +1531,7 @@ static int want_cruft_object_mtime(struct repository *r,
 	struct odb_source *source;
 
 	for (source = r->objects->sources; source; source = source->next) {
-		struct packed_git **cache = packfile_store_get_kept_pack_cache(source->packfiles, flags);
+		struct packed_git **cache = packfile_store_get_kept_pack_cache(source->files->packed, flags);
 
 		for (; *cache; cache++) {
 			struct packed_git *p = *cache;
@@ -1753,11 +1753,11 @@ static int want_object_in_pack_mtime(const struct object_id *oid,
 	}
 
 	for (source = the_repository->objects->sources; source; source = source->next) {
-		for (e = source->packfiles->packs.head; e; e = e->next) {
+		for (e = source->files->packed->packs.head; e; e = e->next) {
 			struct packed_git *p = e->pack;
 			want = want_object_in_pack_one(p, oid, exclude, found_pack, found_offset, found_mtime);
 			if (!exclude && want > 0)
-				packfile_list_prepend(&source->packfiles->packs, p);
+				packfile_list_prepend(&source->files->packed->packs, p);
 			if (want != -1)
 				return want;
 		}
@@ -4340,7 +4340,7 @@ static void add_objects_in_unpacked_packs(void)
 		if (!source->local)
 			continue;
 
-		if (packfile_store_for_each_object(source->packfiles, &oi,
+		if (packfile_store_for_each_object(source->files->packed, &oi,
 						   add_object_in_unpacked_pack, NULL,
 						   ODB_FOR_EACH_OBJECT_PACK_ORDER |
 						   ODB_FOR_EACH_OBJECT_LOCAL_ONLY |
diff --git a/commit-graph.c b/commit-graph.c
index d250a729b1..967eb77047 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1981,7 +1981,7 @@ static void fill_oids_from_all_packs(struct write_commit_graph_context *ctx)
 
 	odb_prepare_alternates(ctx->r->objects);
 	for (source = ctx->r->objects->sources; source; source = source->next)
-		packfile_store_for_each_object(source->packfiles, &oi, add_packed_commits_oi,
+		packfile_store_for_each_object(source->files->packed, &oi, add_packed_commits_oi,
 					       ctx, ODB_FOR_EACH_OBJECT_PACK_ORDER);
 
 	if (ctx->progress_done < ctx->approx_nr_objects)
diff --git a/http.c b/http.c
index 7815f144de..b44f493919 100644
--- a/http.c
+++ b/http.c
@@ -2544,7 +2544,7 @@ void http_install_packfile(struct packed_git *p,
 			   struct packfile_list *list_to_remove_from)
 {
 	packfile_list_remove(list_to_remove_from, p);
-	packfile_store_add_pack(the_repository->objects->sources->packfiles, p);
+	packfile_store_add_pack(the_repository->objects->sources->files->packed, p);
 }
 
 struct http_pack_request *new_http_pack_request(
diff --git a/loose.c b/loose.c
index 56cf64b648..c921d46b94 100644
--- a/loose.c
+++ b/loose.c
@@ -49,13 +49,13 @@ static int insert_loose_map(struct odb_source *source,
 			    const struct object_id *oid,
 			    const struct object_id *compat_oid)
 {
-	struct loose_object_map *map = source->loose->map;
+	struct loose_object_map *map = source->files->loose->map;
 	int inserted = 0;
 
 	inserted |= insert_oid_pair(map->to_compat, oid, compat_oid);
 	inserted |= insert_oid_pair(map->to_storage, compat_oid, oid);
 	if (inserted)
-		oidtree_insert(source->loose->cache, compat_oid);
+		oidtree_insert(source->files->loose->cache, compat_oid);
 
 	return inserted;
 }
@@ -65,11 +65,11 @@ static int load_one_loose_object_map(struct repository *repo, struct odb_source
 	struct strbuf buf = STRBUF_INIT, path = STRBUF_INIT;
 	FILE *fp;
 
-	if (!source->loose->map)
-		loose_object_map_init(&source->loose->map);
-	if (!source->loose->cache) {
-		ALLOC_ARRAY(source->loose->cache, 1);
-		oidtree_init(source->loose->cache);
+	if (!source->files->loose->map)
+		loose_object_map_init(&source->files->loose->map);
+	if (!source->files->loose->cache) {
+		ALLOC_ARRAY(source->files->loose->cache, 1);
+		oidtree_init(source->files->loose->cache);
 	}
 
 	insert_loose_map(source, repo->hash_algo->empty_tree, repo->compat_hash_algo->empty_tree);
@@ -125,7 +125,7 @@ int repo_read_loose_object_map(struct repository *repo)
 
 int repo_write_loose_object_map(struct repository *repo)
 {
-	kh_oid_map_t *map = repo->objects->sources->loose->map->to_compat;
+	kh_oid_map_t *map = repo->objects->sources->files->loose->map->to_compat;
 	struct lock_file lock;
 	int fd;
 	khiter_t iter;
@@ -231,7 +231,7 @@ int repo_loose_object_map_oid(struct repository *repo,
 	khiter_t pos;
 
 	for (source = repo->objects->sources; source; source = source->next) {
-		struct loose_object_map *loose_map = source->loose->map;
+		struct loose_object_map *loose_map = source->files->loose->map;
 		if (!loose_map)
 			continue;
 		map = (to == repo->compat_hash_algo) ?
diff --git a/meson.build b/meson.build
index 1018af17c3..8e1125a585 100644
--- a/meson.build
+++ b/meson.build
@@ -398,6 +398,7 @@ libgit_sources = [
   'object.c',
   'odb.c',
   'odb/source.c',
+  'odb/source-files.c',
   'odb/streaming.c',
   'oid-array.c',
   'oidmap.c',
diff --git a/midx.c b/midx.c
index a75ea99a0d..698d10a1c6 100644
--- a/midx.c
+++ b/midx.c
@@ -95,8 +95,8 @@ static int midx_read_object_offsets(const unsigned char *chunk_start,
 
 struct multi_pack_index *get_multi_pack_index(struct odb_source *source)
 {
-	packfile_store_prepare(source->packfiles);
-	return source->packfiles->midx;
+	packfile_store_prepare(source->files->packed);
+	return source->files->packed->midx;
 }
 
 static struct multi_pack_index *load_multi_pack_index_one(struct odb_source *source,
@@ -459,7 +459,7 @@ int prepare_midx_pack(struct multi_pack_index *m,
 
 	strbuf_addf(&pack_name, "%s/pack/%s", m->source->path,
 		    m->pack_names[pack_int_id]);
-	p = packfile_store_load_pack(m->source->packfiles,
+	p = packfile_store_load_pack(m->source->files->packed,
 				     pack_name.buf, m->source->local);
 	strbuf_release(&pack_name);
 
@@ -709,12 +709,12 @@ int prepare_multi_pack_index_one(struct odb_source *source)
 	if (!r->settings.core_multi_pack_index)
 		return 0;
 
-	if (source->packfiles->midx)
+	if (source->files->packed->midx)
 		return 1;
 
-	source->packfiles->midx = load_multi_pack_index(source);
+	source->files->packed->midx = load_multi_pack_index(source);
 
-	return !!source->packfiles->midx;
+	return !!source->files->packed->midx;
 }
 
 int midx_checksum_valid(struct multi_pack_index *m)
@@ -803,9 +803,9 @@ void clear_midx_file(struct repository *r)
 		struct odb_source *source;
 
 		for (source = r->objects->sources; source; source = source->next) {
-			if (source->packfiles->midx)
-				close_midx(source->packfiles->midx);
-			source->packfiles->midx = NULL;
+			if (source->files->packed->midx)
+				close_midx(source->files->packed->midx);
+			source->files->packed->midx = NULL;
 		}
 	}
 
diff --git a/object-file.c b/object-file.c
index 098b0541ab..db66ae5ebe 100644
--- a/object-file.c
+++ b/object-file.c
@@ -220,7 +220,7 @@ static void *odb_source_loose_map_object(struct odb_source *source,
 					 unsigned long *size)
 {
 	const char *p;
-	int fd = open_loose_object(source->loose, oid, &p);
+	int fd = open_loose_object(source->files->loose, oid, &p);
 
 	if (fd < 0)
 		return NULL;
@@ -423,7 +423,7 @@ static int read_object_info_from_path(struct odb_source *source,
 		struct stat st;
 
 		if ((!oi || (!oi->disk_sizep && !oi->mtimep)) && (flags & OBJECT_INFO_QUICK)) {
-			ret = quick_has_loose(source->loose, oid) ? 0 : -1;
+			ret = quick_has_loose(source->files->loose, oid) ? 0 : -1;
 			goto out;
 		}
 
@@ -1868,31 +1868,31 @@ struct oidtree *odb_source_loose_cache(struct odb_source *source,
 {
 	int subdir_nr = oid->hash[0];
 	struct strbuf buf = STRBUF_INIT;
-	size_t word_bits = bitsizeof(source->loose->subdir_seen[0]);
+	size_t word_bits = bitsizeof(source->files->loose->subdir_seen[0]);
 	size_t word_index = subdir_nr / word_bits;
 	size_t mask = (size_t)1u << (subdir_nr % word_bits);
 	uint32_t *bitmap;
 
 	if (subdir_nr < 0 ||
-	    (size_t) subdir_nr >= bitsizeof(source->loose->subdir_seen))
+	    (size_t) subdir_nr >= bitsizeof(source->files->loose->subdir_seen))
 		BUG("subdir_nr out of range");
 
-	bitmap = &source->loose->subdir_seen[word_index];
+	bitmap = &source->files->loose->subdir_seen[word_index];
 	if (*bitmap & mask)
-		return source->loose->cache;
-	if (!source->loose->cache) {
-		ALLOC_ARRAY(source->loose->cache, 1);
-		oidtree_init(source->loose->cache);
+		return source->files->loose->cache;
+	if (!source->files->loose->cache) {
+		ALLOC_ARRAY(source->files->loose->cache, 1);
+		oidtree_init(source->files->loose->cache);
 	}
 	strbuf_addstr(&buf, source->path);
 	for_each_file_in_obj_subdir(subdir_nr, &buf,
 				    source->odb->repo->hash_algo,
 				    append_loose_object,
 				    NULL, NULL,
-				    source->loose->cache);
+				    source->files->loose->cache);
 	*bitmap |= mask;
 	strbuf_release(&buf);
-	return source->loose->cache;
+	return source->files->loose->cache;
 }
 
 static void odb_source_loose_clear_cache(struct odb_source_loose *loose)
@@ -1905,7 +1905,7 @@ static void odb_source_loose_clear_cache(struct odb_source_loose *loose)
 
 void odb_source_loose_reprepare(struct odb_source *source)
 {
-	odb_source_loose_clear_cache(source->loose);
+	odb_source_loose_clear_cache(source->files->loose);
 }
 
 static int check_stream_oid(git_zstream *stream,
diff --git a/odb.c b/odb.c
index d318482d47..c9ebc7e741 100644
--- a/odb.c
+++ b/odb.c
@@ -691,7 +691,7 @@ static int do_oid_object_info_extended(struct object_database *odb,
 
 		/* Most likely it's a loose object. */
 		for (source = odb->sources; source; source = source->next) {
-			if (!packfile_store_read_object_info(source->packfiles, real, oi, flags) ||
+			if (!packfile_store_read_object_info(source->files->packed, real, oi, flags) ||
 			    !odb_source_loose_read_object_info(source, real, oi, flags))
 				return 0;
 		}
@@ -700,7 +700,7 @@ static int do_oid_object_info_extended(struct object_database *odb,
 		if (!(flags & OBJECT_INFO_QUICK)) {
 			odb_reprepare(odb->repo->objects);
 			for (source = odb->sources; source; source = source->next)
-				if (!packfile_store_read_object_info(source->packfiles, real, oi, flags))
+				if (!packfile_store_read_object_info(source->files->packed, real, oi, flags))
 					return 0;
 		}
 
@@ -962,7 +962,7 @@ int odb_freshen_object(struct object_database *odb,
 
 	odb_prepare_alternates(odb);
 	for (source = odb->sources; source; source = source->next) {
-		if (packfile_store_freshen_object(source->packfiles, oid))
+		if (packfile_store_freshen_object(source->files->packed, oid))
 			return 1;
 
 		if (odb_source_loose_freshen_object(source, oid))
@@ -992,7 +992,7 @@ int odb_for_each_object(struct object_database *odb,
 				return ret;
 		}
 
-		ret = packfile_store_for_each_object(source->packfiles, request,
+		ret = packfile_store_for_each_object(source->files->packed, request,
 						     cb, cb_data, flags);
 		if (ret)
 			return ret;
@@ -1091,7 +1091,7 @@ void odb_close(struct object_database *o)
 {
 	struct odb_source *source;
 	for (source = o->sources; source; source = source->next)
-		packfile_store_close(source->packfiles);
+		packfile_store_close(source->files->packed);
 	close_commit_graph(o);
 }
 
@@ -1149,7 +1149,7 @@ void odb_reprepare(struct object_database *o)
 
 	for (source = o->sources; source; source = source->next) {
 		odb_source_loose_reprepare(source);
-		packfile_store_reprepare(source->packfiles);
+		packfile_store_reprepare(source->files->packed);
 	}
 
 	o->approximate_object_count_valid = 0;
diff --git a/odb/source-files.c b/odb/source-files.c
new file mode 100644
index 0000000000..cbdaa6850f
--- /dev/null
+++ b/odb/source-files.c
@@ -0,0 +1,23 @@
+#include "git-compat-util.h"
+#include "object-file.h"
+#include "odb/source-files.h"
+#include "packfile.h"
+
+void odb_source_files_free(struct odb_source_files *files)
+{
+	if (!files)
+		return;
+	odb_source_loose_free(files->loose);
+	packfile_store_free(files->packed);
+	free(files);
+}
+
+struct odb_source_files *odb_source_files_new(struct odb_source *source)
+{
+	struct odb_source_files *files;
+	CALLOC_ARRAY(files, 1);
+	files->source = source;
+	files->loose = odb_source_loose_new(source);
+	files->packed = packfile_store_new(source);
+	return files;
+}
diff --git a/odb/source-files.h b/odb/source-files.h
new file mode 100644
index 0000000000..0b8bf773ca
--- /dev/null
+++ b/odb/source-files.h
@@ -0,0 +1,24 @@
+#ifndef ODB_SOURCE_FILES_H
+#define ODB_SOURCE_FILES_H
+
+struct odb_source_loose;
+struct odb_source;
+struct packfile_store;
+
+/*
+ * The files object database source uses a combination of loose objects and
+ * packfiles. It is the default backend used by Git to store objects.
+ */
+struct odb_source_files {
+	struct odb_source *source;
+	struct odb_source_loose *loose;
+	struct packfile_store *packed;
+};
+
+/* Allocate and initialize a new object source. */
+struct odb_source_files *odb_source_files_new(struct odb_source *source);
+
+/* Free the object source and release all associated resources. */
+void odb_source_files_free(struct odb_source_files *files);
+
+#endif
diff --git a/odb/source.c b/odb/source.c
index 7fc89806f9..9d7fd19f45 100644
--- a/odb/source.c
+++ b/odb/source.c
@@ -13,8 +13,7 @@ struct odb_source *odb_source_new(struct object_database *odb,
 	source->odb = odb;
 	source->local = local;
 	source->path = xstrdup(path);
-	source->loose = odb_source_loose_new(source);
-	source->packfiles = packfile_store_new(source);
+	source->files = odb_source_files_new(source);
 
 	return source;
 }
@@ -22,7 +21,6 @@ struct odb_source *odb_source_new(struct object_database *odb,
 void odb_source_free(struct odb_source *source)
 {
 	free(source->path);
-	odb_source_loose_free(source->loose);
-	packfile_store_free(source->packfiles);
+	odb_source_files_free(source->files);
 	free(source);
 }
diff --git a/odb/source.h b/odb/source.h
index 391d6d1e38..1c34265189 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -1,6 +1,8 @@
 #ifndef ODB_SOURCE_H
 #define ODB_SOURCE_H
 
+#include "odb/source-files.h"
+
 /*
  * The source is the part of the object database that stores the actual
  * objects. It thus encapsulates the logic to read and write the specific
@@ -19,11 +21,8 @@ struct odb_source {
 	/* Object database that owns this object source. */
 	struct object_database *odb;
 
-	/* Private state for loose objects. */
-	struct odb_source_loose *loose;
-
-	/* Should only be accessed directly by packfile.c and midx.c. */
-	struct packfile_store *packfiles;
+	/* The backend used to store objects. */
+	struct odb_source_files *files;
 
 	/*
 	 * Figure out whether this is the local source of the owning
diff --git a/odb/streaming.c b/odb/streaming.c
index 4a4474f891..26b0a1a0f5 100644
--- a/odb/streaming.c
+++ b/odb/streaming.c
@@ -187,7 +187,7 @@ static int istream_source(struct odb_read_stream **out,
 
 	odb_prepare_alternates(odb);
 	for (source = odb->sources; source; source = source->next) {
-		if (!packfile_store_read_object_stream(out, source->packfiles, oid) ||
+		if (!packfile_store_read_object_stream(out, source->files->packed, oid) ||
 		    !odb_source_loose_read_object_stream(out, source, oid))
 			return 0;
 	}
diff --git a/packfile.c b/packfile.c
index ce837f852a..4e1f6087ed 100644
--- a/packfile.c
+++ b/packfile.c
@@ -363,7 +363,7 @@ static int unuse_one_window(struct object_database *odb)
 	struct pack_window *lru_w = NULL, *lru_l = NULL;
 
 	for (source = odb->sources; source; source = source->next)
-		for (e = source->packfiles->packs.head; e; e = e->next)
+		for (e = source->files->packed->packs.head; e; e = e->next)
 			scan_windows(e->pack, &lru_p, &lru_w, &lru_l);
 
 	if (lru_p) {
@@ -537,7 +537,7 @@ static int close_one_pack(struct repository *r)
 	int accept_windows_inuse = 1;
 
 	for (source = r->objects->sources; source; source = source->next) {
-		for (e = source->packfiles->packs.head; e; e = e->next) {
+		for (e = source->files->packed->packs.head; e; e = e->next) {
 			if (e->pack->pack_fd == -1)
 				continue;
 			find_lru_pack(e->pack, &lru_p, &mru_w, &accept_windows_inuse);
@@ -990,10 +990,10 @@ static void prepare_pack(const char *full_name, size_t full_name_len,
 	size_t base_len = full_name_len;
 
 	if (strip_suffix_mem(full_name, &base_len, ".idx") &&
-	    !(data->source->packfiles->midx &&
-	      midx_contains_pack(data->source->packfiles->midx, file_name))) {
+	    !(data->source->files->packed->midx &&
+	      midx_contains_pack(data->source->files->packed->midx, file_name))) {
 		char *trimmed_path = xstrndup(full_name, full_name_len);
-		packfile_store_load_pack(data->source->packfiles,
+		packfile_store_load_pack(data->source->files->packed,
 					 trimmed_path, data->source->local);
 		free(trimmed_path);
 	}
@@ -1248,7 +1248,7 @@ const struct packed_git *has_packed_and_bad(struct repository *r,
 
 	for (source = r->objects->sources; source; source = source->next) {
 		struct packfile_list_entry *e;
-		for (e = source->packfiles->packs.head; e; e = e->next)
+		for (e = source->files->packed->packs.head; e; e = e->next)
 			if (oidset_contains(&e->pack->bad_objects, oid))
 				return e->pack;
 	}
@@ -2254,7 +2254,7 @@ int has_object_pack(struct repository *r, const struct object_id *oid)
 
 	odb_prepare_alternates(r->objects);
 	for (source = r->objects->sources; source; source = source->next) {
-		int ret = find_pack_entry(source->packfiles, oid, &e);
+		int ret = find_pack_entry(source->files->packed, oid, &e);
 		if (ret)
 			return ret;
 	}
@@ -2271,7 +2271,7 @@ int has_object_kept_pack(struct repository *r, const struct object_id *oid,
 	for (source = r->objects->sources; source; source = source->next) {
 		struct packed_git **cache;
 
-		cache = packfile_store_get_kept_pack_cache(source->packfiles, flags);
+		cache = packfile_store_get_kept_pack_cache(source->files->packed, flags);
 
 		for (; *cache; cache++) {
 			struct packed_git *p = *cache;
diff --git a/packfile.h b/packfile.h
index 224142fd34..e8de06ee86 100644
--- a/packfile.h
+++ b/packfile.h
@@ -192,7 +192,7 @@ static inline struct repo_for_each_pack_data repo_for_eack_pack_data_init(struct
 	odb_prepare_alternates(repo->objects);
 
 	for (struct odb_source *source = repo->objects->sources; source; source = source->next) {
-		struct packfile_list_entry *entry = packfile_store_get_packs(source->packfiles);
+		struct packfile_list_entry *entry = packfile_store_get_packs(source->files->packed);
 		if (!entry)
 			continue;
 		data.source = source;
@@ -212,7 +212,7 @@ static inline void repo_for_each_pack_data_next(struct repo_for_each_pack_data *
 		return;
 
 	for (source = data->source->next; source; source = source->next) {
-		struct packfile_list_entry *entry = packfile_store_get_packs(source->packfiles);
+		struct packfile_list_entry *entry = packfile_store_get_packs(source->files->packed);
 		if (!entry)
 			continue;
 		data->source = source;

-- 
2.53.0.797.g7842e34a66.dirty

