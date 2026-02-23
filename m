Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133D2309DB5
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 16:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771863496; cv=none; b=ht7/q4q5W4gQp76eqb1ipBuzWdkxghh/ZGrZBO5fr1Kfq2rzADsmUo9pySWvu4IeDTHKrm/a6jB4UrZfmdr6AhGqYqtoON5m7jkQ4GKjGt8PrWsXWTM0RYxJeAzpLCoXm98lqyJBcwx3KNLBxqNxBateUpyMJUREX+Sz2/YJmlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771863496; c=relaxed/simple;
	bh=8TWd8qpvJeHsin+WcjHVSWKZgxjwRApH3ESH+rDjU/o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i0pECzj6xcqilRXQ3gKbLVilG63MZ3Jl3ELdAqPLZ8PzGZP58H+VWvYOXD3DXOwmqzeeqTe0BkUf8VD2n/BVfYNr3TGZedtDd6pxhNjPAcXsxX8tMSVfn3rqn8/DVVvFfYKoJ+JsrAEUgXlsmAZ5qTIuWMVucN2+eczlbS2sPcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VtAafDev; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qkpr5b6R; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VtAafDev";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qkpr5b6R"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8298B14001D8
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 11:18:13 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 23 Feb 2026 11:18:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771863493;
	 x=1771949893; bh=5yhrKTAZ/MugYlwr0v7az8nkNDyqxvZbW/OUEbPxD2U=; b=
	VtAafDevYxgsZRKlgZNHbAUVK82ydcR+Uww9nur1kR0enjfq9JnJOUYBtX5FTX3x
	jgQNtwrFYa3wkicgSZvoQr4P2COi2fU59BBG4escyZ/TeOQCY0cZB1JZdtbBT3O7
	d4A2TId8s2mw6BOSLiT1y2fLHcmaBoJOeazvR+Bwh6lDC7VbAZcC1wc4jTEtmECL
	wFi1Sk6fFOkH6YLb8Ftl4ZTccR00WHRMVmC+7cDiNo4g8hDmV7MvLh1POPUFKY57
	U05gxRBbdW7zMd8GzVnXpNbJbuRmW0MxC29Y4OSal8pRbW8aJj+U6uXNteVpgQsN
	+X/WtZXf9aFRuv+j1LxKwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771863493; x=
	1771949893; bh=5yhrKTAZ/MugYlwr0v7az8nkNDyqxvZbW/OUEbPxD2U=; b=Q
	kpr5b6RgV82HBm5e5DgqFh7EA0VtQeCcKYQphJ6+r919+M5GFm2EoaLeA5pIiQyy
	DcRSipzgYU37kxTmkxy5TeW62Mkv26GLiCXC3cIOwjuWk6RjH+wp1154apwCYkMS
	RLRC2RvKPZpM5e0bRKTsLknCvgesE/HdUHzhEuxLf6YzEbxoKVuZ2jOzqcJadZ0P
	X3asX12JXGhHnjy++jAQjb9TwS6BmBFE+fe8qpgG1SFszlc6fhp9mJYgiQu1Z7Uf
	mxEX0GAIV9AAg/F6njcSBzWzTmV3Ei8s2ckzjDaJ/jTIkrM8tEImr6wiCOU6VGhs
	6GF4vmNa0eRLSVjbNwDLg==
X-ME-Sender: <xms:xX2caSQcshMv4rb5SboRlHJI8_4YCP_cR9_xcXZtpACOSBLvAMdg-g>
    <xme:xX2caetn7jc6Wjms6GGzJoolsbL7o23DmsaQ5CcI8woa5xTuDIomazrLFyNShPTYW
    ij0uUu3MAmPi03VLsG5sYBpDKIle3mk9wcAeijMZ4vzgn6L4m9-5bA>
X-ME-Received: <xmr:xX2caVfMpRTk_eyOM8YQ3lKx1aj6y71HWf0a01GIlUknxOebXotxNzamxrlKABiGvjzPLBXt1Htlxl0NuNcTvoKChvytiSA2AaSzCombvw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeejjedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:xX2caTKs1_rn2Wnd0R2EV4_hKTwUrjFkJyDsJDZqtAjkyP6it2-Jgw>
    <xmx:xX2cabYyxk20VC4aLyw_73wKswkFws9-gZilCUVK0guxGfCTneEnBw>
    <xmx:xX2caWsIZoQUHMXfPKvf77qbYkmrEljiIQ6niEaHN_tnYv-D4JgbVw>
    <xmx:xX2caQvBpKYfB5P_PMljkoGDqNRbXHn-eD-BxBT9TT_MfE444-luWA>
    <xmx:xX2caSRst4jsv64LlCbqvCptioaO71G8uA8ZGDETqb-Ku1s4iIt3B1A7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 23 Feb 2026 11:18:12 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3d2de183 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 23 Feb 2026 16:18:12 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 23 Feb 2026 17:17:54 +0100
Subject: [PATCH 03/17] odb: embed base source in the "files" backend
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-b4-pks-odb-source-pluggable-v1-3-253bac1db598@pks.im>
References: <20260223-b4-pks-odb-source-pluggable-v1-0-253bac1db598@pks.im>
In-Reply-To: <20260223-b4-pks-odb-source-pluggable-v1-0-253bac1db598@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

The "files" backend is implemented as a pointer in the `struct
odb_source`. This contradicts our typical pattern for pluggable backends
like we use it for example in the ref store or for object database
streams, where we typically embed the generic base structure in the
specialized implementation. This pattern has a couple of small benefits:

  - We avoid an extra allocation.

  - We hide implementation details in the generic structure.

  - We can easily downcast from a generic backend to the specialized
    structure and vice versa because the offsets are known at compile
    time.

  - It becomes trivial to identify locations where we depend on backend
    specific logic because the cast needs to be explicit.

Refactor our "files" object database source to do the same and embed the
`struct odb_source` in the `struct odb_source_files`.

There are still a bunch of sites in our code base where we do have to
access internals of the "files" backend. The intent is that those will
go away over time, but this will certainly take a while. Meanwhile,
provide a `odb_source_files_downcast()` function that can convert a
generic source into a "files" source.

As we only have a single source the downcast succeeds unconditionally
for now. Eventually though the intent is to make the cast `BUG()` in
case the caller requests to downcast a non-"files" backend to a "files"
backend.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/cat-file.c     |  3 ++-
 builtin/fast-import.c  | 12 ++++++++----
 builtin/grep.c         |  6 ++++--
 builtin/index-pack.c   |  8 +++++---
 builtin/pack-objects.c | 13 +++++++++----
 commit-graph.c         |  6 ++++--
 http.c                 |  3 ++-
 loose.c                | 23 ++++++++++++++---------
 midx.c                 | 26 +++++++++++++++-----------
 object-file.c          | 28 ++++++++++++++++------------
 odb.c                  | 26 ++++++++++++++++++--------
 odb/source-files.c     | 14 ++++++++++----
 odb/source-files.h     | 18 +++++++++++++++---
 odb/source.c           | 26 +++++++++++++++++++-------
 odb/source.h           | 31 +++++++++++++++++++++++++------
 odb/streaming.c        |  3 ++-
 packfile.c             | 26 +++++++++++++++++---------
 packfile.h             |  7 +++++--
 18 files changed, 190 insertions(+), 89 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 01a53f3f29..0c68d61b91 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -882,7 +882,8 @@ static void batch_each_object(struct batch_options *opt,
 		struct object_info oi = { 0 };
 
 		for (source = the_repository->objects->sources; source; source = source->next) {
-			int ret = packfile_store_for_each_object(source->files->packed, &oi,
+			struct odb_source_files *files = odb_source_files_downcast(source);
+			int ret = packfile_store_for_each_object(files->packed, &oi,
 								 batch_one_object_oi, &payload, flags);
 			if (ret)
 				break;
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 627dcbf4f3..a41f95191e 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -875,6 +875,7 @@ static void end_packfile(void)
 	running = 1;
 	clear_delta_base_cache();
 	if (object_count) {
+		struct odb_source_files *files = odb_source_files_downcast(pack_data->repo->objects->sources);
 		struct packed_git *new_p;
 		struct object_id cur_pack_oid;
 		char *idx_name;
@@ -900,8 +901,7 @@ static void end_packfile(void)
 		idx_name = keep_pack(create_index());
 
 		/* Register the packfile with core git's machinery. */
-		new_p = packfile_store_load_pack(pack_data->repo->objects->sources->files->packed,
-						 idx_name, 1);
+		new_p = packfile_store_load_pack(files->packed, idx_name, 1);
 		if (!new_p)
 			die(_("core Git rejected index %s"), idx_name);
 		all_packs[pack_id] = new_p;
@@ -982,7 +982,9 @@ static int store_object(
 	}
 
 	for (source = the_repository->objects->sources; source; source = source->next) {
-		if (!packfile_list_find_oid(packfile_store_get_packs(source->files->packed), &oid))
+		struct odb_source_files *files = odb_source_files_downcast(source);
+
+		if (!packfile_list_find_oid(packfile_store_get_packs(files->packed), &oid))
 			continue;
 		e->type = type;
 		e->pack_id = MAX_PACK_ID;
@@ -1187,7 +1189,9 @@ static void stream_blob(uintmax_t len, struct object_id *oidout, uintmax_t mark)
 	}
 
 	for (source = the_repository->objects->sources; source; source = source->next) {
-		if (!packfile_list_find_oid(packfile_store_get_packs(source->files->packed), &oid))
+		struct odb_source_files *files = odb_source_files_downcast(source);
+
+		if (!packfile_list_find_oid(packfile_store_get_packs(files->packed), &oid))
 			continue;
 		e->type = OBJ_BLOB;
 		e->pack_id = MAX_PACK_ID;
diff --git a/builtin/grep.c b/builtin/grep.c
index c8d0e51415..61379909b8 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1218,8 +1218,10 @@ int cmd_grep(int argc,
 			struct odb_source *source;
 
 			odb_prepare_alternates(the_repository->objects);
-			for (source = the_repository->objects->sources; source; source = source->next)
-				packfile_store_prepare(source->files->packed);
+			for (source = the_repository->objects->sources; source; source = source->next) {
+				struct odb_source_files *files = odb_source_files_downcast(source);
+				packfile_store_prepare(files->packed);
+			}
 		}
 
 		start_threads(&opt);
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index f0cce534b2..d1e47279a8 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1637,9 +1637,11 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 	rename_tmp_packfile(&final_index_name, curr_index_name, &index_name,
 			    hash, "idx", 1);
 
-	if (do_fsck_object && startup_info->have_repository)
-		packfile_store_load_pack(the_repository->objects->sources->files->packed,
-					 final_index_name, 0);
+	if (do_fsck_object && startup_info->have_repository) {
+		struct odb_source_files *files =
+			odb_source_files_downcast(the_repository->objects->sources);
+		packfile_store_load_pack(files->packed, final_index_name, 0);
+	}
 
 	if (!from_stdin) {
 		printf("%s\n", hash_to_hex(hash));
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 0c3c01cdc9..63fea80b08 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1531,7 +1531,8 @@ static int want_cruft_object_mtime(struct repository *r,
 	struct odb_source *source;
 
 	for (source = r->objects->sources; source; source = source->next) {
-		struct packed_git **cache = packfile_store_get_kept_pack_cache(source->files->packed, flags);
+		struct odb_source_files *files = odb_source_files_downcast(source);
+		struct packed_git **cache = packfile_store_get_kept_pack_cache(files->packed, flags);
 
 		for (; *cache; cache++) {
 			struct packed_git *p = *cache;
@@ -1753,11 +1754,13 @@ static int want_object_in_pack_mtime(const struct object_id *oid,
 	}
 
 	for (source = the_repository->objects->sources; source; source = source->next) {
-		for (e = source->files->packed->packs.head; e; e = e->next) {
+		struct odb_source_files *files = odb_source_files_downcast(source);
+
+		for (e = files->packed->packs.head; e; e = e->next) {
 			struct packed_git *p = e->pack;
 			want = want_object_in_pack_one(p, oid, exclude, found_pack, found_offset, found_mtime);
 			if (!exclude && want > 0)
-				packfile_list_prepend(&source->files->packed->packs, p);
+				packfile_list_prepend(&files->packed->packs, p);
 			if (want != -1)
 				return want;
 		}
@@ -4337,10 +4340,12 @@ static void add_objects_in_unpacked_packs(void)
 
 	odb_prepare_alternates(to_pack.repo->objects);
 	for (source = to_pack.repo->objects->sources; source; source = source->next) {
+		struct odb_source_files *files = odb_source_files_downcast(source);
+
 		if (!source->local)
 			continue;
 
-		if (packfile_store_for_each_object(source->files->packed, &oi,
+		if (packfile_store_for_each_object(files->packed, &oi,
 						   add_object_in_unpacked_pack, NULL,
 						   ODB_FOR_EACH_OBJECT_PACK_ORDER |
 						   ODB_FOR_EACH_OBJECT_LOCAL_ONLY |
diff --git a/commit-graph.c b/commit-graph.c
index 967eb77047..f8e24145a5 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1980,9 +1980,11 @@ static void fill_oids_from_all_packs(struct write_commit_graph_context *ctx)
 			ctx->approx_nr_objects);
 
 	odb_prepare_alternates(ctx->r->objects);
-	for (source = ctx->r->objects->sources; source; source = source->next)
-		packfile_store_for_each_object(source->files->packed, &oi, add_packed_commits_oi,
+	for (source = ctx->r->objects->sources; source; source = source->next) {
+		struct odb_source_files *files = odb_source_files_downcast(source);
+		packfile_store_for_each_object(files->packed, &oi, add_packed_commits_oi,
 					       ctx, ODB_FOR_EACH_OBJECT_PACK_ORDER);
+	}
 
 	if (ctx->progress_done < ctx->approx_nr_objects)
 		display_progress(ctx->progress, ctx->approx_nr_objects);
diff --git a/http.c b/http.c
index b44f493919..8ea1b9d1f6 100644
--- a/http.c
+++ b/http.c
@@ -2543,8 +2543,9 @@ int finish_http_pack_request(struct http_pack_request *preq)
 void http_install_packfile(struct packed_git *p,
 			   struct packfile_list *list_to_remove_from)
 {
+	struct odb_source_files *files = odb_source_files_downcast(the_repository->objects->sources);
 	packfile_list_remove(list_to_remove_from, p);
-	packfile_store_add_pack(the_repository->objects->sources->files->packed, p);
+	packfile_store_add_pack(files->packed, p);
 }
 
 struct http_pack_request *new_http_pack_request(
diff --git a/loose.c b/loose.c
index c921d46b94..07333be696 100644
--- a/loose.c
+++ b/loose.c
@@ -3,6 +3,7 @@
 #include "path.h"
 #include "object-file.h"
 #include "odb.h"
+#include "odb/source-files.h"
 #include "hex.h"
 #include "repository.h"
 #include "wrapper.h"
@@ -49,27 +50,29 @@ static int insert_loose_map(struct odb_source *source,
 			    const struct object_id *oid,
 			    const struct object_id *compat_oid)
 {
-	struct loose_object_map *map = source->files->loose->map;
+	struct odb_source_files *files = odb_source_files_downcast(source);
+	struct loose_object_map *map = files->loose->map;
 	int inserted = 0;
 
 	inserted |= insert_oid_pair(map->to_compat, oid, compat_oid);
 	inserted |= insert_oid_pair(map->to_storage, compat_oid, oid);
 	if (inserted)
-		oidtree_insert(source->files->loose->cache, compat_oid);
+		oidtree_insert(files->loose->cache, compat_oid);
 
 	return inserted;
 }
 
 static int load_one_loose_object_map(struct repository *repo, struct odb_source *source)
 {
+	struct odb_source_files *files = odb_source_files_downcast(source);
 	struct strbuf buf = STRBUF_INIT, path = STRBUF_INIT;
 	FILE *fp;
 
-	if (!source->files->loose->map)
-		loose_object_map_init(&source->files->loose->map);
-	if (!source->files->loose->cache) {
-		ALLOC_ARRAY(source->files->loose->cache, 1);
-		oidtree_init(source->files->loose->cache);
+	if (!files->loose->map)
+		loose_object_map_init(&files->loose->map);
+	if (!files->loose->cache) {
+		ALLOC_ARRAY(files->loose->cache, 1);
+		oidtree_init(files->loose->cache);
 	}
 
 	insert_loose_map(source, repo->hash_algo->empty_tree, repo->compat_hash_algo->empty_tree);
@@ -125,7 +128,8 @@ int repo_read_loose_object_map(struct repository *repo)
 
 int repo_write_loose_object_map(struct repository *repo)
 {
-	kh_oid_map_t *map = repo->objects->sources->files->loose->map->to_compat;
+	struct odb_source_files *files = odb_source_files_downcast(repo->objects->sources);
+	kh_oid_map_t *map = files->loose->map->to_compat;
 	struct lock_file lock;
 	int fd;
 	khiter_t iter;
@@ -231,7 +235,8 @@ int repo_loose_object_map_oid(struct repository *repo,
 	khiter_t pos;
 
 	for (source = repo->objects->sources; source; source = source->next) {
-		struct loose_object_map *loose_map = source->files->loose->map;
+		struct odb_source_files *files = odb_source_files_downcast(source);
+		struct loose_object_map *loose_map = files->loose->map;
 		if (!loose_map)
 			continue;
 		map = (to == repo->compat_hash_algo) ?
diff --git a/midx.c b/midx.c
index 698d10a1c6..ab8e2611d1 100644
--- a/midx.c
+++ b/midx.c
@@ -95,8 +95,9 @@ static int midx_read_object_offsets(const unsigned char *chunk_start,
 
 struct multi_pack_index *get_multi_pack_index(struct odb_source *source)
 {
-	packfile_store_prepare(source->files->packed);
-	return source->files->packed->midx;
+	struct odb_source_files *files = odb_source_files_downcast(source);
+	packfile_store_prepare(files->packed);
+	return files->packed->midx;
 }
 
 static struct multi_pack_index *load_multi_pack_index_one(struct odb_source *source,
@@ -447,6 +448,7 @@ static uint32_t midx_for_pack(struct multi_pack_index **_m,
 int prepare_midx_pack(struct multi_pack_index *m,
 		      uint32_t pack_int_id)
 {
+	struct odb_source_files *files = odb_source_files_downcast(m->source);
 	struct strbuf pack_name = STRBUF_INIT;
 	struct packed_git *p;
 
@@ -457,10 +459,10 @@ int prepare_midx_pack(struct multi_pack_index *m,
 	if (m->packs[pack_int_id])
 		return 0;
 
-	strbuf_addf(&pack_name, "%s/pack/%s", m->source->path,
+	strbuf_addf(&pack_name, "%s/pack/%s", files->base.path,
 		    m->pack_names[pack_int_id]);
-	p = packfile_store_load_pack(m->source->files->packed,
-				     pack_name.buf, m->source->local);
+	p = packfile_store_load_pack(files->packed,
+				     pack_name.buf, files->base.local);
 	strbuf_release(&pack_name);
 
 	if (!p) {
@@ -703,18 +705,19 @@ int midx_preferred_pack(struct multi_pack_index *m, uint32_t *pack_int_id)
 
 int prepare_multi_pack_index_one(struct odb_source *source)
 {
+	struct odb_source_files *files = odb_source_files_downcast(source);
 	struct repository *r = source->odb->repo;
 
 	prepare_repo_settings(r);
 	if (!r->settings.core_multi_pack_index)
 		return 0;
 
-	if (source->files->packed->midx)
+	if (files->packed->midx)
 		return 1;
 
-	source->files->packed->midx = load_multi_pack_index(source);
+	files->packed->midx = load_multi_pack_index(source);
 
-	return !!source->files->packed->midx;
+	return !!files->packed->midx;
 }
 
 int midx_checksum_valid(struct multi_pack_index *m)
@@ -803,9 +806,10 @@ void clear_midx_file(struct repository *r)
 		struct odb_source *source;
 
 		for (source = r->objects->sources; source; source = source->next) {
-			if (source->files->packed->midx)
-				close_midx(source->files->packed->midx);
-			source->files->packed->midx = NULL;
+			struct odb_source_files *files = odb_source_files_downcast(source);
+			if (files->packed->midx)
+				close_midx(files->packed->midx);
+			files->packed->midx = NULL;
 		}
 	}
 
diff --git a/object-file.c b/object-file.c
index ec04d3572a..25c1146849 100644
--- a/object-file.c
+++ b/object-file.c
@@ -219,8 +219,9 @@ static void *odb_source_loose_map_object(struct odb_source *source,
 					 const struct object_id *oid,
 					 unsigned long *size)
 {
+	struct odb_source_files *files = odb_source_files_downcast(source);
 	const char *p;
-	int fd = open_loose_object(source->files->loose, oid, &p);
+	int fd = open_loose_object(files->loose, oid, &p);
 
 	if (fd < 0)
 		return NULL;
@@ -401,6 +402,7 @@ static int read_object_info_from_path(struct odb_source *source,
 				      struct object_info *oi,
 				      enum object_info_flags flags)
 {
+	struct odb_source_files *files = odb_source_files_downcast(source);
 	int ret;
 	int fd;
 	unsigned long mapsize;
@@ -423,7 +425,7 @@ static int read_object_info_from_path(struct odb_source *source,
 		struct stat st;
 
 		if ((!oi || (!oi->disk_sizep && !oi->mtimep)) && (flags & OBJECT_INFO_QUICK)) {
-			ret = quick_has_loose(source->files->loose, oid) ? 0 : -1;
+			ret = quick_has_loose(files->loose, oid) ? 0 : -1;
 			goto out;
 		}
 
@@ -1866,33 +1868,34 @@ static int append_loose_object(const struct object_id *oid,
 struct oidtree *odb_source_loose_cache(struct odb_source *source,
 				       const struct object_id *oid)
 {
+	struct odb_source_files *files = odb_source_files_downcast(source);
 	int subdir_nr = oid->hash[0];
 	struct strbuf buf = STRBUF_INIT;
-	size_t word_bits = bitsizeof(source->files->loose->subdir_seen[0]);
+	size_t word_bits = bitsizeof(files->loose->subdir_seen[0]);
 	size_t word_index = subdir_nr / word_bits;
 	size_t mask = (size_t)1u << (subdir_nr % word_bits);
 	uint32_t *bitmap;
 
 	if (subdir_nr < 0 ||
-	    (size_t) subdir_nr >= bitsizeof(source->files->loose->subdir_seen))
+	    (size_t) subdir_nr >= bitsizeof(files->loose->subdir_seen))
 		BUG("subdir_nr out of range");
 
-	bitmap = &source->files->loose->subdir_seen[word_index];
+	bitmap = &files->loose->subdir_seen[word_index];
 	if (*bitmap & mask)
-		return source->files->loose->cache;
-	if (!source->files->loose->cache) {
-		ALLOC_ARRAY(source->files->loose->cache, 1);
-		oidtree_init(source->files->loose->cache);
+		return files->loose->cache;
+	if (!files->loose->cache) {
+		ALLOC_ARRAY(files->loose->cache, 1);
+		oidtree_init(files->loose->cache);
 	}
 	strbuf_addstr(&buf, source->path);
 	for_each_file_in_obj_subdir(subdir_nr, &buf,
 				    source->odb->repo->hash_algo,
 				    append_loose_object,
 				    NULL, NULL,
-				    source->files->loose->cache);
+				    files->loose->cache);
 	*bitmap |= mask;
 	strbuf_release(&buf);
-	return source->files->loose->cache;
+	return files->loose->cache;
 }
 
 static void odb_source_loose_clear_cache(struct odb_source_loose *loose)
@@ -1905,7 +1908,8 @@ static void odb_source_loose_clear_cache(struct odb_source_loose *loose)
 
 void odb_source_loose_reprepare(struct odb_source *source)
 {
-	odb_source_loose_clear_cache(source->files->loose);
+	struct odb_source_files *files = odb_source_files_downcast(source);
+	odb_source_loose_clear_cache(files->loose);
 }
 
 static int check_stream_oid(git_zstream *stream,
diff --git a/odb.c b/odb.c
index c9ebc7e741..e5aa8deb88 100644
--- a/odb.c
+++ b/odb.c
@@ -691,7 +691,8 @@ static int do_oid_object_info_extended(struct object_database *odb,
 
 		/* Most likely it's a loose object. */
 		for (source = odb->sources; source; source = source->next) {
-			if (!packfile_store_read_object_info(source->files->packed, real, oi, flags) ||
+			struct odb_source_files *files = odb_source_files_downcast(source);
+			if (!packfile_store_read_object_info(files->packed, real, oi, flags) ||
 			    !odb_source_loose_read_object_info(source, real, oi, flags))
 				return 0;
 		}
@@ -699,9 +700,11 @@ static int do_oid_object_info_extended(struct object_database *odb,
 		/* Not a loose object; someone else may have just packed it. */
 		if (!(flags & OBJECT_INFO_QUICK)) {
 			odb_reprepare(odb->repo->objects);
-			for (source = odb->sources; source; source = source->next)
-				if (!packfile_store_read_object_info(source->files->packed, real, oi, flags))
+			for (source = odb->sources; source; source = source->next) {
+				struct odb_source_files *files = odb_source_files_downcast(source);
+				if (!packfile_store_read_object_info(files->packed, real, oi, flags))
 					return 0;
+			}
 		}
 
 		/*
@@ -962,7 +965,9 @@ int odb_freshen_object(struct object_database *odb,
 
 	odb_prepare_alternates(odb);
 	for (source = odb->sources; source; source = source->next) {
-		if (packfile_store_freshen_object(source->files->packed, oid))
+		struct odb_source_files *files = odb_source_files_downcast(source);
+
+		if (packfile_store_freshen_object(files->packed, oid))
 			return 1;
 
 		if (odb_source_loose_freshen_object(source, oid))
@@ -982,6 +987,8 @@ int odb_for_each_object(struct object_database *odb,
 
 	odb_prepare_alternates(odb);
 	for (struct odb_source *source = odb->sources; source; source = source->next) {
+		struct odb_source_files *files = odb_source_files_downcast(source);
+
 		if (flags & ODB_FOR_EACH_OBJECT_LOCAL_ONLY && !source->local)
 			continue;
 
@@ -992,7 +999,7 @@ int odb_for_each_object(struct object_database *odb,
 				return ret;
 		}
 
-		ret = packfile_store_for_each_object(source->files->packed, request,
+		ret = packfile_store_for_each_object(files->packed, request,
 						     cb, cb_data, flags);
 		if (ret)
 			return ret;
@@ -1090,8 +1097,10 @@ struct object_database *odb_new(struct repository *repo,
 void odb_close(struct object_database *o)
 {
 	struct odb_source *source;
-	for (source = o->sources; source; source = source->next)
-		packfile_store_close(source->files->packed);
+	for (source = o->sources; source; source = source->next) {
+		struct odb_source_files *files = odb_source_files_downcast(source);
+		packfile_store_close(files->packed);
+	}
 	close_commit_graph(o);
 }
 
@@ -1148,8 +1157,9 @@ void odb_reprepare(struct object_database *o)
 	odb_prepare_alternates(o);
 
 	for (source = o->sources; source; source = source->next) {
+		struct odb_source_files *files = odb_source_files_downcast(source);
 		odb_source_loose_reprepare(source);
-		packfile_store_reprepare(source->files->packed);
+		packfile_store_reprepare(files->packed);
 	}
 
 	o->approximate_object_count_valid = 0;
diff --git a/odb/source-files.c b/odb/source-files.c
index cbdaa6850f..a43a197157 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -1,5 +1,6 @@
 #include "git-compat-util.h"
 #include "object-file.h"
+#include "odb/source.h"
 #include "odb/source-files.h"
 #include "packfile.h"
 
@@ -9,15 +10,20 @@ void odb_source_files_free(struct odb_source_files *files)
 		return;
 	odb_source_loose_free(files->loose);
 	packfile_store_free(files->packed);
+	odb_source_release(&files->base);
 	free(files);
 }
 
-struct odb_source_files *odb_source_files_new(struct odb_source *source)
+struct odb_source_files *odb_source_files_new(struct object_database *odb,
+					      const char *path,
+					      bool local)
 {
 	struct odb_source_files *files;
+
 	CALLOC_ARRAY(files, 1);
-	files->source = source;
-	files->loose = odb_source_loose_new(source);
-	files->packed = packfile_store_new(source);
+	odb_source_init(&files->base, odb, path, local);
+	files->loose = odb_source_loose_new(&files->base);
+	files->packed = packfile_store_new(&files->base);
+
 	return files;
 }
diff --git a/odb/source-files.h b/odb/source-files.h
index 0b8bf773ca..58753d40de 100644
--- a/odb/source-files.h
+++ b/odb/source-files.h
@@ -1,8 +1,9 @@
 #ifndef ODB_SOURCE_FILES_H
 #define ODB_SOURCE_FILES_H
 
+#include "odb/source.h"
+
 struct odb_source_loose;
-struct odb_source;
 struct packfile_store;
 
 /*
@@ -10,15 +11,26 @@ struct packfile_store;
  * packfiles. It is the default backend used by Git to store objects.
  */
 struct odb_source_files {
-	struct odb_source *source;
+	struct odb_source base;
 	struct odb_source_loose *loose;
 	struct packfile_store *packed;
 };
 
 /* Allocate and initialize a new object source. */
-struct odb_source_files *odb_source_files_new(struct odb_source *source);
+struct odb_source_files *odb_source_files_new(struct object_database *odb,
+					      const char *path,
+					      bool local);
 
 /* Free the object source and release all associated resources. */
 void odb_source_files_free(struct odb_source_files *files);
 
+/*
+ * Cast the given object database source to the files backend. This will cause
+ * a BUG in case the source doesn't use this backend.
+ */
+static inline struct odb_source_files *odb_source_files_downcast(struct odb_source *source)
+{
+	return container_of(source, struct odb_source_files, base);
+}
+
 #endif
diff --git a/odb/source.c b/odb/source.c
index 9d7fd19f45..d8b2176a94 100644
--- a/odb/source.c
+++ b/odb/source.c
@@ -1,5 +1,6 @@
 #include "git-compat-util.h"
 #include "object-file.h"
+#include "odb/source-files.h"
 #include "odb/source.h"
 #include "packfile.h"
 
@@ -7,20 +8,31 @@ struct odb_source *odb_source_new(struct object_database *odb,
 				  const char *path,
 				  bool local)
 {
-	struct odb_source *source;
+	return &odb_source_files_new(odb, path, local)->base;
+}
 
-	CALLOC_ARRAY(source, 1);
+void odb_source_init(struct odb_source *source,
+		     struct object_database *odb,
+		     const char *path,
+		     bool local)
+{
 	source->odb = odb;
 	source->local = local;
 	source->path = xstrdup(path);
-	source->files = odb_source_files_new(source);
-
-	return source;
 }
 
 void odb_source_free(struct odb_source *source)
 {
+	struct odb_source_files *files;
+	if (!source)
+		return;
+	files = odb_source_files_downcast(source);
+	odb_source_files_free(files);
+}
+
+void odb_source_release(struct odb_source *source)
+{
+	if (!source)
+		return;
 	free(source->path);
-	odb_source_files_free(source->files);
-	free(source);
 }
diff --git a/odb/source.h b/odb/source.h
index 1c34265189..e6698b73a3 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -1,8 +1,6 @@
 #ifndef ODB_SOURCE_H
 #define ODB_SOURCE_H
 
-#include "odb/source-files.h"
-
 /*
  * The source is the part of the object database that stores the actual
  * objects. It thus encapsulates the logic to read and write the specific
@@ -21,9 +19,6 @@ struct odb_source {
 	/* Object database that owns this object source. */
 	struct object_database *odb;
 
-	/* The backend used to store objects. */
-	struct odb_source_files *files;
-
 	/*
 	 * Figure out whether this is the local source of the owning
 	 * repository, which would typically be its ".git/objects" directory.
@@ -53,7 +48,31 @@ struct odb_source *odb_source_new(struct object_database *odb,
 				  const char *path,
 				  bool local);
 
-/* Free the object database source, releasing all associated resources. */
+/*
+ * Initialize the source for the given object database located at `path`.
+ * `local` indicates whether or not the source is the local and thus primary
+ * object source of the object database.
+ *
+ * This function is only supposed to be called by specific object source
+ * implementations.
+ */
+void odb_source_init(struct odb_source *source,
+		     struct object_database *odb,
+		     const char *path,
+		     bool local);
+
+/*
+ * Free the object database source, releasing all associated resources and
+ * freeing the structure itself.
+ */
 void odb_source_free(struct odb_source *source);
 
+/*
+ * Release the object database source, releasing all associated resources.
+ *
+ * This function is only supposed to be called by specific object source
+ * implementations.
+ */
+void odb_source_release(struct odb_source *source);
+
 #endif
diff --git a/odb/streaming.c b/odb/streaming.c
index 26b0a1a0f5..19cda9407d 100644
--- a/odb/streaming.c
+++ b/odb/streaming.c
@@ -187,7 +187,8 @@ static int istream_source(struct odb_read_stream **out,
 
 	odb_prepare_alternates(odb);
 	for (source = odb->sources; source; source = source->next) {
-		if (!packfile_store_read_object_stream(out, source->files->packed, oid) ||
+		struct odb_source_files *files = odb_source_files_downcast(source);
+		if (!packfile_store_read_object_stream(out, files->packed, oid) ||
 		    !odb_source_loose_read_object_stream(out, source, oid))
 			return 0;
 	}
diff --git a/packfile.c b/packfile.c
index 4e1f6087ed..da1c0dfa39 100644
--- a/packfile.c
+++ b/packfile.c
@@ -362,9 +362,11 @@ static int unuse_one_window(struct object_database *odb)
 	struct packed_git *lru_p = NULL;
 	struct pack_window *lru_w = NULL, *lru_l = NULL;
 
-	for (source = odb->sources; source; source = source->next)
-		for (e = source->files->packed->packs.head; e; e = e->next)
+	for (source = odb->sources; source; source = source->next) {
+		struct odb_source_files *files = odb_source_files_downcast(source);
+		for (e = files->packed->packs.head; e; e = e->next)
 			scan_windows(e->pack, &lru_p, &lru_w, &lru_l);
+	}
 
 	if (lru_p) {
 		munmap(lru_w->base, lru_w->len);
@@ -537,7 +539,8 @@ static int close_one_pack(struct repository *r)
 	int accept_windows_inuse = 1;
 
 	for (source = r->objects->sources; source; source = source->next) {
-		for (e = source->files->packed->packs.head; e; e = e->next) {
+		struct odb_source_files *files = odb_source_files_downcast(source);
+		for (e = files->packed->packs.head; e; e = e->next) {
 			if (e->pack->pack_fd == -1)
 				continue;
 			find_lru_pack(e->pack, &lru_p, &mru_w, &accept_windows_inuse);
@@ -987,13 +990,14 @@ static void prepare_pack(const char *full_name, size_t full_name_len,
 			 const char *file_name, void *_data)
 {
 	struct prepare_pack_data *data = (struct prepare_pack_data *)_data;
+	struct odb_source_files *files = odb_source_files_downcast(data->source);
 	size_t base_len = full_name_len;
 
 	if (strip_suffix_mem(full_name, &base_len, ".idx") &&
-	    !(data->source->files->packed->midx &&
-	      midx_contains_pack(data->source->files->packed->midx, file_name))) {
+	    !(files->packed->midx &&
+	      midx_contains_pack(files->packed->midx, file_name))) {
 		char *trimmed_path = xstrndup(full_name, full_name_len);
-		packfile_store_load_pack(data->source->files->packed,
+		packfile_store_load_pack(files->packed,
 					 trimmed_path, data->source->local);
 		free(trimmed_path);
 	}
@@ -1247,8 +1251,10 @@ const struct packed_git *has_packed_and_bad(struct repository *r,
 	struct odb_source *source;
 
 	for (source = r->objects->sources; source; source = source->next) {
+		struct odb_source_files *files = odb_source_files_downcast(source);
 		struct packfile_list_entry *e;
-		for (e = source->files->packed->packs.head; e; e = e->next)
+
+		for (e = files->packed->packs.head; e; e = e->next)
 			if (oidset_contains(&e->pack->bad_objects, oid))
 				return e->pack;
 	}
@@ -2254,7 +2260,8 @@ int has_object_pack(struct repository *r, const struct object_id *oid)
 
 	odb_prepare_alternates(r->objects);
 	for (source = r->objects->sources; source; source = source->next) {
-		int ret = find_pack_entry(source->files->packed, oid, &e);
+		struct odb_source_files *files = odb_source_files_downcast(source);
+		int ret = find_pack_entry(files->packed, oid, &e);
 		if (ret)
 			return ret;
 	}
@@ -2269,9 +2276,10 @@ int has_object_kept_pack(struct repository *r, const struct object_id *oid,
 	struct pack_entry e;
 
 	for (source = r->objects->sources; source; source = source->next) {
+		struct odb_source_files *files = odb_source_files_downcast(source);
 		struct packed_git **cache;
 
-		cache = packfile_store_get_kept_pack_cache(source->files->packed, flags);
+		cache = packfile_store_get_kept_pack_cache(files->packed, flags);
 
 		for (; *cache; cache++) {
 			struct packed_git *p = *cache;
diff --git a/packfile.h b/packfile.h
index e8de06ee86..64a31738c0 100644
--- a/packfile.h
+++ b/packfile.h
@@ -4,6 +4,7 @@
 #include "list.h"
 #include "object.h"
 #include "odb.h"
+#include "odb/source-files.h"
 #include "oidset.h"
 #include "repository.h"
 #include "strmap.h"
@@ -192,7 +193,8 @@ static inline struct repo_for_each_pack_data repo_for_eack_pack_data_init(struct
 	odb_prepare_alternates(repo->objects);
 
 	for (struct odb_source *source = repo->objects->sources; source; source = source->next) {
-		struct packfile_list_entry *entry = packfile_store_get_packs(source->files->packed);
+		struct odb_source_files *files = odb_source_files_downcast(source);
+		struct packfile_list_entry *entry = packfile_store_get_packs(files->packed);
 		if (!entry)
 			continue;
 		data.source = source;
@@ -212,7 +214,8 @@ static inline void repo_for_each_pack_data_next(struct repo_for_each_pack_data *
 		return;
 
 	for (source = data->source->next; source; source = source->next) {
-		struct packfile_list_entry *entry = packfile_store_get_packs(source->files->packed);
+		struct odb_source_files *files = odb_source_files_downcast(source);
+		struct packfile_list_entry *entry = packfile_store_get_packs(files->packed);
 		if (!entry)
 			continue;
 		data->source = source;

-- 
2.53.0.536.g309c995771.dirty

