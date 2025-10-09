Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23352D73A7
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 08:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759996923; cv=none; b=BfENtrADNlDrfn84d/b8IiA/NC5DbsV4QxRTupZMKwD8t9qjV+OdF0ha4knFgsPZh10JJhHDPLRO2PNvSgd9qxdwAPvFR2TrmtOoHVQ2N0ikqNa787+WRIFcUrNDqcmjgMhv5wM/r0YyLXDXRlkz6I7xzI/q/ho/Mj7kENxfulw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759996923; c=relaxed/simple;
	bh=7hCGe3dRVqXMjdq/mFVP77OxAC2iC2WVjYEK8nAh1QQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U0QYaZMnOb5rZcIRZE5GDNPAg92UdqvL6ZufVqF1QB+B1yUZFaGxOm/ciX+hl07tSx8ZFz0Nc/oAaswcMIcuue4ZM99rz6P09z8uK0Hqh8FvbxT2jyzZqo7E3P7rM79yhLt/bvbrnHQWHeOZQ6mfUbg2MGa5JMHkz7ulx4MEgrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=H/C5diAf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vkfDuTUk; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="H/C5diAf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vkfDuTUk"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 8ABEE1D00120;
	Thu,  9 Oct 2025 04:01:59 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 09 Oct 2025 04:01:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759996919;
	 x=1760083319; bh=Fog5B//8rRkiiikLblG+aetlBJxPjrSKhJ/TEdxURoE=; b=
	H/C5diAfmA4S2HZCSF/EoEn8TRYOiJjCW1Y3No9k+vk2++pWNoQQdlHx7zP9NL+c
	ogX4vMyv8AJbv2QtSp/mdv1PWneLAw6H+ZijptbF1GyFzt3AvKquIZMrBxIe2UYc
	vaaEZZNf1ZMllPk0bm8ofdMjiP6aDOg8Rgm20as7fGwuHD86rkOLFEs7dcTJnQ7+
	hyKLtFSpg2l6189hoeXKKyv84lQuHGS5mORwkZa0AIFnkA/pGy+x3FL8/JGYkz/c
	H+aMgJct8rRRiIApsJHwCGCS3gs5UwWexy99ysf7Ylk2cGVfCN81Std1XZvPLk7I
	hKy3QjWg6qnJo53Q/Tmi7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759996919; x=
	1760083319; bh=Fog5B//8rRkiiikLblG+aetlBJxPjrSKhJ/TEdxURoE=; b=v
	kfDuTUkSiUeF8J81MuoDhnTOJflaNOVJIJGS9BX+qpbNxnibMLKPA/HYfizrL95I
	pjXhcLTUzmD2qEun89wruNofqYG1tiI5/FsXRkEls5HoX7CXDwzRdrK9pRnADbY6
	xYJQ5cbfqpvIVtnVrf8sFqJ4Ppz9dFKysz+i3OhToeAjXakfFySPOzfLFYBh2Vrl
	wP1xAmqckYpiRj9QBE7PQnB31pTs7/UlXA2gASQolIXF96Et7glQcmMtE6rUxRvj
	yJk09x3FBpb2buZ5PAtkdZpKXRyaNoVo00ZgiZ7esfEzB5RQtyE0lP0gwk2lDgPo
	kx1nA3RVyeLqx5dcx9HTQ==
X-ME-Sender: <xms:92vnaDyTfVg0jkoF65hWgTFyRiPznloq3id9-rqaqwMYHZHEMFfOUA>
    <xme:92vnaBQ4oxtET7iKUpinAY-Zx6e0L5XtVzUxqjhfQAFp2_WmyNbB7E6FsCRjumG_9
    r7RgYcj9FeWwxpvErD8TcaF-JV7fuKq3jcZ27anLPI9t8j4HIrdVjY>
X-ME-Received: <xmr:92vnaK_Omadl1MA-Um2k9mWkRdvusc6IKhjkUzuoFIPUh5IPPJgfjHecU5VqmkPpyX74rvJtqNRalSJPakjfhgzfo3-uugsBxrV_ay3O8Qs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdehieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:92vnaIqDXP8wrcEWlzy1MEBxwN-_2jT0M1hSeJUyLk_MBZbN2asb9w>
    <xmx:92vnaHl7kLEOe2rcODAF9Hwa4FI-jQlbKMuOdERUw52BN-apRni7tA>
    <xmx:92vnaPIzl8gwTWM1NldkePSpzWGw6YM-GVGDKSDW_SSsLEBKl_FXfA>
    <xmx:92vnaMw8udumCqv7BM6BSFguWoobz02fY8hJttDbtOMQ8B7ZirH5cw>
    <xmx:92vnaK7q9vEl6X1lRTmrnJF4A_qSXSkoj9-3rkNWPb2KN_nWBX4esHIw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Oct 2025 04:01:58 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d10e7128 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 9 Oct 2025 08:01:58 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 09 Oct 2025 10:01:39 +0200
Subject: [PATCH v2 5/6] packfile: introduce macro to iterate through packs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251009-pks-packfiles-convert-get-all-v2-5-0d73b87ce711@pks.im>
References: <20251009-pks-packfiles-convert-get-all-v2-0-0d73b87ce711@pks.im>
In-Reply-To: <20251009-pks-packfiles-convert-get-all-v2-0-0d73b87ce711@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
X-Mailer: b4 0.14.3

We have a bunch of different sites that want to iterate through all
packs of a given `struct packfile_store`. This pattern is somewhat
verbose and repetitive, which makes it somewhat cumbersome.

Introduce a new macro `repo_for_each_pack()` that removes some of the
boilerplate.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/cat-file.c          |  3 +--
 builtin/count-objects.c     |  3 +--
 builtin/fsck.c              | 15 ++++++---------
 builtin/gc.c                | 16 +++++++---------
 builtin/pack-objects.c      | 22 +++++++---------------
 builtin/pack-redundant.c    | 14 ++++----------
 connected.c                 |  3 +--
 http-backend.c              |  5 ++---
 http.c                      |  3 +--
 object-name.c               |  8 +++++---
 pack-bitmap.c               |  6 +++---
 pack-objects.c              |  5 ++---
 packfile.c                  |  4 ++--
 packfile.h                  |  8 ++++++++
 repack-cruft.c              |  3 +--
 repack-geometry.c           |  3 +--
 repack.c                    |  3 +--
 server-info.c               |  3 +--
 t/helper/test-find-pack.c   |  3 ++-
 t/helper/test-pack-mtimes.c |  2 +-
 20 files changed, 57 insertions(+), 75 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index ee6715fa52..0ab076aeb3 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -852,10 +852,9 @@ static void batch_each_object(struct batch_options *opt,
 
 	if (bitmap && !for_each_bitmapped_object(bitmap, &opt->objects_filter,
 						 batch_one_object_bitmapped, &payload)) {
-		struct packfile_store *packs = the_repository->objects->packfiles;
 		struct packed_git *pack;
 
-		for (pack = packfile_store_get_all_packs(packs); pack; pack = pack->next) {
+		repo_for_each_pack(the_repository, pack) {
 			if (bitmap_index_contains_pack(bitmap, pack) ||
 			    open_pack_index(pack))
 				continue;
diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index f2f407c2a7..18f6e33b6f 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -122,7 +122,6 @@ int cmd_count_objects(int argc,
 				      count_loose, count_cruft, NULL, NULL);
 
 	if (verbose) {
-		struct packfile_store *packs = the_repository->objects->packfiles;
 		struct packed_git *p;
 		unsigned long num_pack = 0;
 		off_t size_pack = 0;
@@ -130,7 +129,7 @@ int cmd_count_objects(int argc,
 		struct strbuf pack_buf = STRBUF_INIT;
 		struct strbuf garbage_buf = STRBUF_INIT;
 
-		for (p = packfile_store_get_all_packs(packs); p; p = p->next) {
+		repo_for_each_pack(the_repository, p) {
 			if (!p->pack_local)
 				continue;
 			if (open_pack_index(p))
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 8ee95e0d67..b1a650c673 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -867,20 +867,20 @@ static int mark_packed_for_connectivity(const struct object_id *oid,
 
 static int check_pack_rev_indexes(struct repository *r, int show_progress)
 {
-	struct packfile_store *packs = r->objects->packfiles;
 	struct progress *progress = NULL;
+	struct packed_git *p;
 	uint32_t pack_count = 0;
 	int res = 0;
 
 	if (show_progress) {
-		for (struct packed_git *p = packfile_store_get_all_packs(packs); p; p = p->next)
+		repo_for_each_pack(r, p)
 			pack_count++;
 		progress = start_delayed_progress(the_repository,
 						  "Verifying reverse pack-indexes", pack_count);
 		pack_count = 0;
 	}
 
-	for (struct packed_git *p = packfile_store_get_all_packs(packs); p; p = p->next) {
+	repo_for_each_pack(r, p) {
 		int load_error = load_pack_revindex_from_disk(p);
 
 		if (load_error < 0) {
@@ -1000,8 +1000,6 @@ int cmd_fsck(int argc,
 		for_each_packed_object(the_repository,
 				       mark_packed_for_connectivity, NULL, 0);
 	} else {
-		struct packfile_store *packs = the_repository->objects->packfiles;
-
 		odb_prepare_alternates(the_repository->objects);
 		for (source = the_repository->objects->sources; source; source = source->next)
 			fsck_source(source);
@@ -1012,8 +1010,7 @@ int cmd_fsck(int argc,
 			struct progress *progress = NULL;
 
 			if (show_progress) {
-				for (p = packfile_store_get_all_packs(packs); p;
-				     p = p->next) {
+				repo_for_each_pack(the_repository, p) {
 					if (open_pack_index(p))
 						continue;
 					total += p->num_objects;
@@ -1022,8 +1019,8 @@ int cmd_fsck(int argc,
 				progress = start_progress(the_repository,
 							  _("Checking objects"), total);
 			}
-			for (p = packfile_store_get_all_packs(packs); p;
-			     p = p->next) {
+
+			repo_for_each_pack(the_repository, p) {
 				/* verify gives error messages itself */
 				if (verify_pack(the_repository,
 						p, fsck_obj_buffer,
diff --git a/builtin/gc.c b/builtin/gc.c
index ab6d6d3bd1..541d7471f1 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -487,10 +487,9 @@ static int too_many_loose_objects(struct gc_config *cfg)
 static struct packed_git *find_base_packs(struct string_list *packs,
 					  unsigned long limit)
 {
-	struct packfile_store *packfiles = the_repository->objects->packfiles;
 	struct packed_git *p, *base = NULL;
 
-	for (p = packfile_store_get_all_packs(packfiles); p; p = p->next) {
+	repo_for_each_pack(the_repository, p) {
 		if (!p->pack_local || p->is_cruft)
 			continue;
 		if (limit) {
@@ -509,14 +508,13 @@ static struct packed_git *find_base_packs(struct string_list *packs,
 
 static int too_many_packs(struct gc_config *cfg)
 {
-	struct packfile_store *packs = the_repository->objects->packfiles;
 	struct packed_git *p;
-	int cnt;
+	int cnt = 0;
 
 	if (cfg->gc_auto_pack_limit <= 0)
 		return 0;
 
-	for (cnt = 0, p = packfile_store_get_all_packs(packs); p; p = p->next) {
+	repo_for_each_pack(the_repository, p) {
 		if (!p->pack_local)
 			continue;
 		if (p->pack_keep)
@@ -1425,9 +1423,9 @@ static int incremental_repack_auto_condition(struct gc_config *cfg UNUSED)
 	if (incremental_repack_auto_limit < 0)
 		return 1;
 
-	for (p = packfile_store_get_all_packs(the_repository->objects->packfiles);
-	     count < incremental_repack_auto_limit && p;
-	     p = p->next) {
+	repo_for_each_pack(the_repository, p) {
+		if (count >= incremental_repack_auto_limit)
+			break;
 		if (!p->multi_pack_index)
 			count++;
 	}
@@ -1494,7 +1492,7 @@ static off_t get_auto_pack_size(void)
 	struct repository *r = the_repository;
 
 	odb_reprepare(r->objects);
-	for (p = packfile_store_get_all_packs(r->objects->packfiles); p; p = p->next) {
+	repo_for_each_pack(r, p) {
 		if (p->pack_size > max_size) {
 			second_largest_size = max_size;
 			max_size = p->pack_size;
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index fe987fbb8b..50618e1073 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3831,12 +3831,10 @@ static int pack_mtime_cmp(const void *_a, const void *_b)
 
 static void read_packs_list_from_stdin(struct rev_info *revs)
 {
-	struct packfile_store *packs = the_repository->objects->packfiles;
 	struct strbuf buf = STRBUF_INIT;
 	struct string_list include_packs = STRING_LIST_INIT_DUP;
 	struct string_list exclude_packs = STRING_LIST_INIT_DUP;
 	struct string_list_item *item = NULL;
-
 	struct packed_git *p;
 
 	while (strbuf_getline(&buf, stdin) != EOF) {
@@ -3856,7 +3854,7 @@ static void read_packs_list_from_stdin(struct rev_info *revs)
 	string_list_sort(&exclude_packs);
 	string_list_remove_duplicates(&exclude_packs, 0);
 
-	for (p = packfile_store_get_all_packs(packs); p; p = p->next) {
+	repo_for_each_pack(the_repository, p) {
 		const char *pack_name = pack_basename(p);
 
 		if ((item = string_list_lookup(&include_packs, pack_name)))
@@ -4077,7 +4075,6 @@ static void enumerate_cruft_objects(void)
 
 static void enumerate_and_traverse_cruft_objects(struct string_list *fresh_packs)
 {
-	struct packfile_store *packs = the_repository->objects->packfiles;
 	struct packed_git *p;
 	struct rev_info revs;
 	int ret;
@@ -4107,7 +4104,7 @@ static void enumerate_and_traverse_cruft_objects(struct string_list *fresh_packs
 	 * Re-mark only the fresh packs as kept so that objects in
 	 * unknown packs do not halt the reachability traversal early.
 	 */
-	for (p = packfile_store_get_all_packs(packs); p; p = p->next)
+	repo_for_each_pack(the_repository, p)
 		p->pack_keep_in_core = 0;
 	mark_pack_kept_in_core(fresh_packs, 1);
 
@@ -4124,7 +4121,6 @@ static void enumerate_and_traverse_cruft_objects(struct string_list *fresh_packs
 
 static void read_cruft_objects(void)
 {
-	struct packfile_store *packs = the_repository->objects->packfiles;
 	struct strbuf buf = STRBUF_INIT;
 	struct string_list discard_packs = STRING_LIST_INIT_DUP;
 	struct string_list fresh_packs = STRING_LIST_INIT_DUP;
@@ -4145,7 +4141,7 @@ static void read_cruft_objects(void)
 	string_list_sort(&discard_packs);
 	string_list_sort(&fresh_packs);
 
-	for (p = packfile_store_get_all_packs(packs); p; p = p->next) {
+	repo_for_each_pack(the_repository, p) {
 		const char *pack_name = pack_basename(p);
 		struct string_list_item *item;
 
@@ -4440,13 +4436,12 @@ static int loosened_object_can_be_discarded(const struct object_id *oid,
 
 static void loosen_unused_packed_objects(void)
 {
-	struct packfile_store *packs = the_repository->objects->packfiles;
 	struct packed_git *p;
 	uint32_t i;
 	uint32_t loosened_objects_nr = 0;
 	struct object_id oid;
 
-	for (p = packfile_store_get_all_packs(packs); p; p = p->next) {
+	repo_for_each_pack(the_repository, p) {
 		if (!p->pack_local || p->pack_keep || p->pack_keep_in_core)
 			continue;
 
@@ -4747,13 +4742,12 @@ static void get_object_list(struct rev_info *revs, struct strvec *argv)
 
 static void add_extra_kept_packs(const struct string_list *names)
 {
-	struct packfile_store *packs = the_repository->objects->packfiles;
 	struct packed_git *p;
 
 	if (!names->nr)
 		return;
 
-	for (p = packfile_store_get_all_packs(packs); p; p = p->next) {
+	repo_for_each_pack(the_repository, p) {
 		const char *name = basename(p->pack_name);
 		int i;
 
@@ -5191,10 +5185,9 @@ int cmd_pack_objects(int argc,
 
 	add_extra_kept_packs(&keep_pack_list);
 	if (ignore_packed_keep_on_disk) {
-		struct packfile_store *packs = the_repository->objects->packfiles;
 		struct packed_git *p;
 
-		for (p = packfile_store_get_all_packs(packs); p; p = p->next)
+		repo_for_each_pack(the_repository, p)
 			if (p->pack_local && p->pack_keep)
 				break;
 		if (!p) /* no keep-able packs found */
@@ -5206,10 +5199,9 @@ int cmd_pack_objects(int argc,
 		 * want to unset "local" based on looking at packs, as
 		 * it also covers non-local objects
 		 */
-		struct packfile_store *packs = the_repository->objects->packfiles;
 		struct packed_git *p;
 
-		for (p = packfile_store_get_all_packs(packs); p; p = p->next) {
+		repo_for_each_pack(the_repository, p) {
 			if (!p->pack_local) {
 				have_non_local_packs = 1;
 				break;
diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index dd28171f0a..fca7f195d6 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -566,29 +566,23 @@ static struct pack_list * add_pack(struct packed_git *p)
 
 static struct pack_list * add_pack_file(const char *filename)
 {
-	struct packfile_store *packs = the_repository->objects->packfiles;
-	struct packed_git *p = packfile_store_get_all_packs(packs);
+	struct packed_git *p;
 
 	if (strlen(filename) < 40)
 		die("Bad pack filename: %s", filename);
 
-	while (p) {
+	repo_for_each_pack(the_repository, p)
 		if (strstr(p->pack_name, filename))
 			return add_pack(p);
-		p = p->next;
-	}
 	die("Filename %s not found in packed_git", filename);
 }
 
 static void load_all(void)
 {
-	struct packfile_store *packs = the_repository->objects->packfiles;
-	struct packed_git *p = packfile_store_get_all_packs(packs);
+	struct packed_git *p;
 
-	while (p) {
+	repo_for_each_pack(the_repository, p)
 		add_pack(p);
-		p = p->next;
-	}
 }
 
 int cmd_pack_redundant(int argc, const char **argv, const char *prefix UNUSED, struct repository *repo UNUSED) {
diff --git a/connected.c b/connected.c
index b288a18b17..79403108dd 100644
--- a/connected.c
+++ b/connected.c
@@ -74,10 +74,9 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 		 */
 		odb_reprepare(the_repository->objects);
 		do {
-			struct packfile_store *packs = the_repository->objects->packfiles;
 			struct packed_git *p;
 
-			for (p = packfile_store_get_all_packs(packs); p; p = p->next) {
+			repo_for_each_pack(the_repository, p) {
 				if (!p->pack_promisor)
 					continue;
 				if (find_pack_entry_one(oid, p))
diff --git a/http-backend.c b/http-backend.c
index 9084058f1e..52f0483dd3 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -603,19 +603,18 @@ static void get_head(struct strbuf *hdr, char *arg UNUSED)
 static void get_info_packs(struct strbuf *hdr, char *arg UNUSED)
 {
 	size_t objdirlen = strlen(repo_get_object_directory(the_repository));
-	struct packfile_store *packs = the_repository->objects->packfiles;
 	struct strbuf buf = STRBUF_INIT;
 	struct packed_git *p;
 	size_t cnt = 0;
 
 	select_getanyfile(hdr);
-	for (p = packfile_store_get_all_packs(packs); p; p = p->next) {
+	repo_for_each_pack(the_repository, p) {
 		if (p->pack_local)
 			cnt++;
 	}
 
 	strbuf_grow(&buf, cnt * 53 + 2);
-	for (p = packfile_store_get_all_packs(packs); p; p = p->next) {
+	repo_for_each_pack(the_repository, p) {
 		if (p->pack_local)
 			strbuf_addf(&buf, "P %s\n", p->pack_name + objdirlen + 6);
 	}
diff --git a/http.c b/http.c
index 7e3af1e72f..17130823f0 100644
--- a/http.c
+++ b/http.c
@@ -2416,7 +2416,6 @@ static char *fetch_pack_index(unsigned char *hash, const char *base_url)
 static int fetch_and_setup_pack_index(struct packed_git **packs_head,
 	unsigned char *sha1, const char *base_url)
 {
-	struct packfile_store *packs = the_repository->objects->packfiles;
 	struct packed_git *new_pack, *p;
 	char *tmp_idx = NULL;
 	int ret;
@@ -2425,7 +2424,7 @@ static int fetch_and_setup_pack_index(struct packed_git **packs_head,
 	 * If we already have the pack locally, no need to fetch its index or
 	 * even add it to list; we already have all of its objects.
 	 */
-	for (p = packfile_store_get_all_packs(packs); p; p = p->next) {
+	repo_for_each_pack(the_repository, p) {
 		if (hasheq(p->hash, sha1, the_repository->hash_algo))
 			return 0;
 	}
diff --git a/object-name.c b/object-name.c
index 4e62bfa330..766c757042 100644
--- a/object-name.c
+++ b/object-name.c
@@ -213,9 +213,11 @@ static void find_short_packed_object(struct disambiguate_state *ds)
 			unique_in_midx(m, ds);
 	}
 
-	for (p = packfile_store_get_all_packs(ds->repo->objects->packfiles); p && !ds->ambiguous;
-	     p = p->next)
+	repo_for_each_pack(ds->repo, p) {
+		if (ds->ambiguous)
+			break;
 		unique_in_pack(p, ds);
+	}
 }
 
 static int finish_object_disambiguation(struct disambiguate_state *ds,
@@ -805,7 +807,7 @@ static void find_abbrev_len_packed(struct min_abbrev_data *mad)
 			find_abbrev_len_for_midx(m, mad);
 	}
 
-	for (p = packfile_store_get_all_packs(mad->repo->objects->packfiles); p; p = p->next)
+	repo_for_each_pack(mad->repo, p)
 		find_abbrev_len_for_pack(p, mad);
 }
 
diff --git a/pack-bitmap.c b/pack-bitmap.c
index ac71035d77..291e1a9cf4 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -664,7 +664,7 @@ static int open_pack_bitmap(struct repository *r,
 	struct packed_git *p;
 	int ret = -1;
 
-	for (p = packfile_store_get_all_packs(r->objects->packfiles); p; p = p->next) {
+	repo_for_each_pack(r, p) {
 		if (open_pack_bitmap_1(bitmap_git, p) == 0) {
 			ret = 0;
 			/*
@@ -3347,6 +3347,7 @@ static int verify_bitmap_file(const struct git_hash_algo *algop,
 int verify_bitmap_files(struct repository *r)
 {
 	struct odb_source *source;
+	struct packed_git *p;
 	int res = 0;
 
 	odb_prepare_alternates(r->objects);
@@ -3362,8 +3363,7 @@ int verify_bitmap_files(struct repository *r)
 		free(midx_bitmap_name);
 	}
 
-	for (struct packed_git *p = packfile_store_get_all_packs(r->objects->packfiles);
-	     p; p = p->next) {
+	repo_for_each_pack(r, p) {
 		char *pack_bitmap_name = pack_bitmap_filename(p);
 		res |= verify_bitmap_file(r->hash_algo, pack_bitmap_name);
 		free(pack_bitmap_name);
diff --git a/pack-objects.c b/pack-objects.c
index d8eb679735..d6adf0759c 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -86,7 +86,6 @@ struct object_entry *packlist_find(struct packing_data *pdata,
 
 static void prepare_in_pack_by_idx(struct packing_data *pdata)
 {
-	struct packfile_store *packs = pdata->repo->objects->packfiles;
 	struct packed_git **mapping, *p;
 	int cnt = 0, nr = 1U << OE_IN_PACK_BITS;
 
@@ -96,13 +95,13 @@ static void prepare_in_pack_by_idx(struct packing_data *pdata)
 	 * (i.e. in_pack_idx also zero) should return NULL.
 	 */
 	mapping[cnt++] = NULL;
-	for (p = packfile_store_get_all_packs(packs); p; p = p->next, cnt++) {
+	repo_for_each_pack(pdata->repo, p) {
 		if (cnt == nr) {
 			free(mapping);
 			return;
 		}
 		p->index = cnt;
-		mapping[cnt] = p;
+		mapping[cnt++] = p;
 	}
 	pdata->in_pack_by_idx = mapping;
 }
diff --git a/packfile.c b/packfile.c
index db748b0bd4..ab5859518d 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2099,7 +2099,7 @@ struct packed_git **kept_pack_cache(struct repository *r, unsigned flags)
 		 * covers, one kept and one not kept, but the midx returns only
 		 * the non-kept version.
 		 */
-		for (p = packfile_store_get_all_packs(r->objects->packfiles); p; p = p->next) {
+		repo_for_each_pack(r, p) {
 			if ((p->pack_keep && (flags & ON_DISK_KEEP_PACKS)) ||
 			    (p->pack_keep_in_core && (flags & IN_CORE_KEEP_PACKS))) {
 				ALLOC_GROW(packs, nr + 1, alloc);
@@ -2196,7 +2196,7 @@ int for_each_packed_object(struct repository *repo, each_packed_object_fn cb,
 	int r = 0;
 	int pack_errors = 0;
 
-	for (p = packfile_store_get_all_packs(repo->objects->packfiles); p; p = p->next) {
+	repo_for_each_pack(repo, p) {
 		if ((flags & FOR_EACH_OBJECT_LOCAL_ONLY) && !p->pack_local)
 			continue;
 		if ((flags & FOR_EACH_OBJECT_PROMISOR_ONLY) &&
diff --git a/packfile.h b/packfile.h
index 3f38c63476..49484a9b09 100644
--- a/packfile.h
+++ b/packfile.h
@@ -136,6 +136,14 @@ void packfile_store_reprepare(struct packfile_store *store);
 void packfile_store_add_pack(struct packfile_store *store,
 			     struct packed_git *pack);
 
+/*
+ * Load and iterate through all packs of the given repository. This helper
+ * function will yield packfiles from all object sources connected to the
+ * repository.
+ */
+#define repo_for_each_pack(repo, p) \
+	for (p = packfile_store_get_all_packs(repo->objects->packfiles); p; p = p->next)
+
 /*
  * Get all packs managed by the given store, including packfiles that are
  * referenced by multi-pack indices.
diff --git a/repack-cruft.c b/repack-cruft.c
index accb98bcdb..544a6f2df3 100644
--- a/repack-cruft.c
+++ b/repack-cruft.c
@@ -7,12 +7,11 @@
 static void combine_small_cruft_packs(FILE *in, off_t combine_cruft_below_size,
 				      struct existing_packs *existing)
 {
-	struct packfile_store *packs = existing->repo->objects->packfiles;
 	struct packed_git *p;
 	struct strbuf buf = STRBUF_INIT;
 	size_t i;
 
-	for (p = packfile_store_get_all_packs(packs); p; p = p->next) {
+	repo_for_each_pack(existing->repo, p) {
 		if (!(p->is_cruft && p->pack_local))
 			continue;
 
diff --git a/repack-geometry.c b/repack-geometry.c
index 56d651c9ce..4e51003ecc 100644
--- a/repack-geometry.c
+++ b/repack-geometry.c
@@ -29,11 +29,10 @@ void pack_geometry_init(struct pack_geometry *geometry,
 			struct existing_packs *existing,
 			const struct pack_objects_args *args)
 {
-	struct packfile_store *packs = existing->repo->objects->packfiles;
 	struct packed_git *p;
 	struct strbuf buf = STRBUF_INIT;
 
-	for (p = packfile_store_get_all_packs(packs); p; p = p->next) {
+	repo_for_each_pack(existing->repo, p) {
 		if (args->local && !p->pack_local)
 			/*
 			 * When asked to only repack local packfiles we skip
diff --git a/repack.c b/repack.c
index 1982a48165..d690e68718 100644
--- a/repack.c
+++ b/repack.c
@@ -124,11 +124,10 @@ int finish_pack_objects_cmd(const struct git_hash_algo *algop,
 void existing_packs_collect(struct existing_packs *existing,
 			    const struct string_list *extra_keep)
 {
-	struct packfile_store *packs = existing->repo->objects->packfiles;
 	struct packed_git *p;
 	struct strbuf buf = STRBUF_INIT;
 
-	for (p = packfile_store_get_all_packs(packs); p; p = p->next) {
+	repo_for_each_pack(existing->repo, p) {
 		size_t i;
 		const char *base;
 
diff --git a/server-info.c b/server-info.c
index 1d33de821e..b9a710544a 100644
--- a/server-info.c
+++ b/server-info.c
@@ -287,13 +287,12 @@ static int compare_info(const void *a_, const void *b_)
 
 static void init_pack_info(struct repository *r, const char *infofile, int force)
 {
-	struct packfile_store *packs = r->objects->packfiles;
 	struct packed_git *p;
 	int stale;
 	int i;
 	size_t alloc = 0;
 
-	for (p = packfile_store_get_all_packs(packs); p; p = p->next) {
+	repo_for_each_pack(r, p) {
 		/* we ignore things on alternate path since they are
 		 * not available to the pullers in general.
 		 */
diff --git a/t/helper/test-find-pack.c b/t/helper/test-find-pack.c
index e001dc3066..fc4b8a77b3 100644
--- a/t/helper/test-find-pack.c
+++ b/t/helper/test-find-pack.c
@@ -39,11 +39,12 @@ int cmd__find_pack(int argc, const char **argv)
 	if (repo_get_oid(the_repository, argv[0], &oid))
 		die("cannot parse %s as an object name", argv[0]);
 
-	for (p = packfile_store_get_all_packs(the_repository->objects->packfiles); p; p = p->next)
+	repo_for_each_pack(the_repository, p) {
 		if (find_pack_entry_one(&oid, p)) {
 			printf("%s\n", p->pack_name);
 			actual_count++;
 		}
+	}
 
 	if (count > -1 && count != actual_count)
 		die("bad packfile count %d instead of %d", actual_count, count);
diff --git a/t/helper/test-pack-mtimes.c b/t/helper/test-pack-mtimes.c
index 7c428c1601..7a8ee1de24 100644
--- a/t/helper/test-pack-mtimes.c
+++ b/t/helper/test-pack-mtimes.c
@@ -37,7 +37,7 @@ int cmd__pack_mtimes(int argc, const char **argv)
 	if (argc != 2)
 		usage(pack_mtimes_usage);
 
-	for (p = packfile_store_get_all_packs(the_repository->objects->packfiles); p; p = p->next) {
+	repo_for_each_pack(the_repository, p) {
 		strbuf_addstr(&buf, basename(p->pack_name));
 		strbuf_strip_suffix(&buf, ".pack");
 		strbuf_addstr(&buf, ".mtimes");

-- 
2.51.0.764.g787ff6f08a.dirty

