Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC8F34A797
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 08:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767947610; cv=none; b=BSs1JDysFggeRkqc5p3A4ttJoKdLWHX3hDIi6rGyJVGSIDOaTimRm0EnUXKIHX9qekZnQ7Flud2d5ikhTUjApDP4eE80NLrYQ1MUdj0JBLcjMBFH6aIyCVXUXiQA5r+4iuy1TEVihLnaKMc4g67B/DaG2HC/E6vrcd0Z1Xqfx+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767947610; c=relaxed/simple;
	bh=p00Ic0FCdnwAkMplCpQehZfCIWD9vBUmO7khBUwdGwY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=juoQaW0yHbpv1LbQ28c508IQ5a1Qjmu3qUojedSnqwO37dca07Zrv17Zj8hUAcut88VFynP8p/hAzMXOsjXv5jVUk61Qor+yFLoFHB8a/sJbcQU9WDrvDW7lqbBUFY114HymTIMqogR8eZwKWHK9Ho+dvObfME0uhko1z/ZeBow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YLDqEvlK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LG0UAhX2; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YLDqEvlK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LG0UAhX2"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 87CA414000D0;
	Fri,  9 Jan 2026 03:33:27 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 09 Jan 2026 03:33:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767947607;
	 x=1768034007; bh=4zydxwNpouEilJxkehQqG+9rhikKSdWmLoDHRdLVssk=; b=
	YLDqEvlKIWeSiOSt2t/prKqxJ8RJihr1/9kVfRS3scrhE4Ej1hnqCqwDdohbvVzv
	uf/lLNauio1/9CkaA1pwqwl3P0BlBFXXpu1Ow5vh29ZkqgBvVgHHdN7QsolJuvBA
	6e12y7bRzr+s6Wm/LdWXqVBkwQfRsHFm9GA1xCoyLiP+xJvNYqaZ9bcYgeJFl2ro
	gVGFLUruEYgWknfBW8Q5ElnZnT6svwpSHnVottYDFWuBUwTvO6kfhx7nHdIg4r6n
	bvadib3hxXHGIQYf8/JN+uX1G9x0nAj9d8MTe5s47Y60q/xQtyqhzRINK13QAiua
	GqJDl8Ed1jOXG+k1V2uyzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767947607; x=
	1768034007; bh=4zydxwNpouEilJxkehQqG+9rhikKSdWmLoDHRdLVssk=; b=L
	G0UAhX2WgVZ05bvi5Rxllv9QfD5D5Ht0sWUtXoBt4Oncq7Q0U+xdldmKZPOkgVN+
	xyI2L/5BwAuOtJ2k7rUEwDJJ3dYXV5lXNIo4wUsgCuqhJ6kg1d5JGvEIrbgkEglH
	F7A5HoZnYlhYqN1yg+s2wQo9up5ABxNtuh+0UceegRaamCDdRb6ylS9h4k/Fm6bk
	Dh3t46aXIg57pqW5tMm1dnQXSepsGneWwck3xurTKZFdpRy/u07ycI/prC3Ufac7
	sTXJgjTXoVdrZqK+nz2ZfiNoDz8bcq5Os0zq5ZguqWVb51eo6N4tW8pZnoNLActo
	yfZf3h9ytyPvcUIk149wQ==
X-ME-Sender: <xms:V71gabZhPplh6ds_bKVu_tyBadwsP2nNz69NgbvedavLrpDit-SHMQ>
    <xme:V71gaRbfT5ZltSs1jq4LfgnEO4GJ6ywZY2UbH04VtbALsrYMJrFk0qeKW11nvuUDq
    N1RCUaggnUTaGMgxAgO_ZnsetmKJk4QaoYcf9Lz9zcOSMRNxx_x-g>
X-ME-Received: <xmr:V71gaS_OoexYT0Rzy28cF10cdBWTX7EBL6qTw41DbMQ-oXvEkdB6FGBuSiRhZFqh_fwuusgv-aVfYofiU9S40cLB9OXt3UJDKe3bcr73TA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdekfeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrh
    hhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrih
    hlrdgtohhm
X-ME-Proxy: <xmx:V71gaQgSl84s4m2VTdYRn7lG2_RejKbCCLkxuMpi2p4TPXD4yX97sw>
    <xmx:V71gaScTJ-1B5xJVcA3MYKuAkh1lUn5Ze-Xy0Rv5nv8jfIB4sHDQkQ>
    <xmx:V71gaXp_Yt3wwjL8YJJpkglLZ8cTn0SDMBRxQMaKALTG9ZMoOzk1bQ>
    <xmx:V71gaXD22pmgvJ52Lwpy-ixbn6cMLPZWK6w77QF9Uq9rV_oVMY1PWA>
    <xmx:V71gaX9idom5NArHJI5gVzzHOG-dME0Q4NsAohFvwYbdYoHkWxkhn695>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jan 2026 03:33:26 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ca46266e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 9 Jan 2026 08:33:26 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 09 Jan 2026 09:33:13 +0100
Subject: [PATCH v3 05/10] packfile: move packfile store into object source
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-b4-pks-pack-store-via-source-v3-5-877fd7b7bf81@pks.im>
References: <20260109-b4-pks-pack-store-via-source-v3-0-877fd7b7bf81@pks.im>
In-Reply-To: <20260109-b4-pks-pack-store-via-source-v3-0-877fd7b7bf81@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Toon Claes <toon@iotcl.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
X-Mailer: b4 0.14.3

The packfile store is a member of `struct object_database`, which means
that we have a single store per database. This doesn't really make much
sense though: each source connected to the database has its own set of
packfiles, so there is a conceptual mismatch here. This hasn't really
caused much of a problem in the past, but with the advent of pluggable
object databases this is becoming more of a problem because some of the
sources may not even use packfiles in the first place.

Move the packfile store down by one level from the object database into
the object database source. This ensures that each source now has its
own packfile store, and we can eventually start to abstract it away
entirely so that the caller doesn't even know what kind of store it
uses.

Note that we only need to adjust a relatively small number of callers,
way less than one might expect. This is because most callers are using
`repo_for_each_pack()`, which handles enumeration of all packfiles that
exist in the repository. So for now, none of these callers need to be
adapted. The remaining callers that iterate through the packfiles
directly and that need adjustment are those that are a bit more tangled
with packfiles. These will be adjusted over time.

Note that this patch only moves the packfile store, and there is still a
bunch of functions that seemingly operate on a packfile store but that
end up iterating over all sources. These will be adjusted in subsequent
commits.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fast-import.c  |  37 ++++++++------
 builtin/grep.c         |   6 ++-
 builtin/index-pack.c   |   2 +-
 builtin/pack-objects.c |  96 +++++++++++++++++++------------------
 http.c                 |   2 +-
 midx.c                 |   5 +-
 odb.c                  |  36 +++++++-------
 odb.h                  |   6 +--
 odb/streaming.c        |   9 ++--
 packfile.c             | 127 +++++++++++++++++++++++++++++++------------------
 packfile.h             |  62 ++++++++++++++++++++----
 11 files changed, 243 insertions(+), 145 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 7849005ccb..b8a7757cfd 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -900,7 +900,7 @@ static void end_packfile(void)
 		idx_name = keep_pack(create_index());
 
 		/* Register the packfile with core git's machinery. */
-		new_p = packfile_store_load_pack(pack_data->repo->objects->packfiles,
+		new_p = packfile_store_load_pack(pack_data->repo->objects->sources->packfiles,
 						 idx_name, 1);
 		if (!new_p)
 			die(_("core Git rejected index %s"), idx_name);
@@ -955,7 +955,7 @@ static int store_object(
 	struct object_id *oidout,
 	uintmax_t mark)
 {
-	struct packfile_store *packs = the_repository->objects->packfiles;
+	struct odb_source *source;
 	void *out, *delta;
 	struct object_entry *e;
 	unsigned char hdr[96];
@@ -979,7 +979,11 @@ static int store_object(
 	if (e->idx.offset) {
 		duplicate_count_by_type[type]++;
 		return 1;
-	} else if (packfile_list_find_oid(packfile_store_get_packs(packs), &oid)) {
+	}
+
+	for (source = the_repository->objects->sources; source; source = source->next) {
+		if (!packfile_list_find_oid(packfile_store_get_packs(source->packfiles), &oid))
+			continue;
 		e->type = type;
 		e->pack_id = MAX_PACK_ID;
 		e->idx.offset = 1; /* just not zero! */
@@ -1096,10 +1100,10 @@ static void truncate_pack(struct hashfile_checkpoint *checkpoint)
 
 static void stream_blob(uintmax_t len, struct object_id *oidout, uintmax_t mark)
 {
-	struct packfile_store *packs = the_repository->objects->packfiles;
 	size_t in_sz = 64 * 1024, out_sz = 64 * 1024;
 	unsigned char *in_buf = xmalloc(in_sz);
 	unsigned char *out_buf = xmalloc(out_sz);
+	struct odb_source *source;
 	struct object_entry *e;
 	struct object_id oid;
 	unsigned long hdrlen;
@@ -1179,24 +1183,29 @@ static void stream_blob(uintmax_t len, struct object_id *oidout, uintmax_t mark)
 	if (e->idx.offset) {
 		duplicate_count_by_type[OBJ_BLOB]++;
 		truncate_pack(&checkpoint);
+		goto out;
+	}
 
-	} else if (packfile_list_find_oid(packfile_store_get_packs(packs), &oid)) {
+	for (source = the_repository->objects->sources; source; source = source->next) {
+		if (!packfile_list_find_oid(packfile_store_get_packs(source->packfiles), &oid))
+			continue;
 		e->type = OBJ_BLOB;
 		e->pack_id = MAX_PACK_ID;
 		e->idx.offset = 1; /* just not zero! */
 		duplicate_count_by_type[OBJ_BLOB]++;
 		truncate_pack(&checkpoint);
-
-	} else {
-		e->depth = 0;
-		e->type = OBJ_BLOB;
-		e->pack_id = pack_id;
-		e->idx.offset = offset;
-		e->idx.crc32 = crc32_end(pack_file);
-		object_count++;
-		object_count_by_type[OBJ_BLOB]++;
+		goto out;
 	}
 
+	e->depth = 0;
+	e->type = OBJ_BLOB;
+	e->pack_id = pack_id;
+	e->idx.offset = offset;
+	e->idx.crc32 = crc32_end(pack_file);
+	object_count++;
+	object_count_by_type[OBJ_BLOB]++;
+
+out:
 	free(in_buf);
 	free(out_buf);
 }
diff --git a/builtin/grep.c b/builtin/grep.c
index 53cccf2d25..4855b871dd 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1213,8 +1213,12 @@ int cmd_grep(int argc,
 		 */
 		if (recurse_submodules)
 			repo_read_gitmodules(the_repository, 1);
+		/*
+		 * Note: `packfile_store_prepare()` prepares stores from all
+		 * sources. This will be fixed in a subsequent commit.
+		 */
 		if (startup_info->have_repository)
-			packfile_store_prepare(the_repository->objects->packfiles);
+			packfile_store_prepare(the_repository->objects->sources->packfiles);
 
 		start_threads(&opt);
 	} else {
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index a7e901e49c..b67fb0256c 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1638,7 +1638,7 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 			    hash, "idx", 1);
 
 	if (do_fsck_object && startup_info->have_repository)
-		packfile_store_load_pack(the_repository->objects->packfiles,
+		packfile_store_load_pack(the_repository->objects->sources->packfiles,
 					 final_index_name, 0);
 
 	if (!from_stdin) {
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index e86b8f387a..7fd90a9996 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1529,49 +1529,53 @@ static int want_cruft_object_mtime(struct repository *r,
 				   const struct object_id *oid,
 				   unsigned flags, uint32_t mtime)
 {
-	struct packed_git **cache = packfile_store_get_kept_pack_cache(r->objects->packfiles, flags);
+	struct odb_source *source;
 
-	for (; *cache; cache++) {
-		struct packed_git *p = *cache;
-		off_t ofs;
-		uint32_t candidate_mtime;
+	for (source = r->objects->sources; source; source = source->next) {
+		struct packed_git **cache = packfile_store_get_kept_pack_cache(source->packfiles, flags);
 
-		ofs = find_pack_entry_one(oid, p);
-		if (!ofs)
-			continue;
+		for (; *cache; cache++) {
+			struct packed_git *p = *cache;
+			off_t ofs;
+			uint32_t candidate_mtime;
 
-		/*
-		 * We have a copy of the object 'oid' in a non-cruft
-		 * pack. We can avoid packing an additional copy
-		 * regardless of what the existing copy's mtime is since
-		 * it is outside of a cruft pack.
-		 */
-		if (!p->is_cruft)
-			return 0;
-
-		/*
-		 * If we have a copy of the object 'oid' in a cruft
-		 * pack, then either read the cruft pack's mtime for
-		 * that object, or, if that can't be loaded, assume the
-		 * pack's mtime itself.
-		 */
-		if (!load_pack_mtimes(p)) {
-			uint32_t pos;
-			if (offset_to_pack_pos(p, ofs, &pos) < 0)
+			ofs = find_pack_entry_one(oid, p);
+			if (!ofs)
 				continue;
-			candidate_mtime = nth_packed_mtime(p, pos);
-		} else {
-			candidate_mtime = p->mtime;
-		}
 
-		/*
-		 * We have a surviving copy of the object in a cruft
-		 * pack whose mtime is greater than or equal to the one
-		 * we are considering. We can thus avoid packing an
-		 * additional copy of that object.
-		 */
-		if (mtime <= candidate_mtime)
-			return 0;
+			/*
+			 * We have a copy of the object 'oid' in a non-cruft
+			 * pack. We can avoid packing an additional copy
+			 * regardless of what the existing copy's mtime is since
+			 * it is outside of a cruft pack.
+			 */
+			if (!p->is_cruft)
+				return 0;
+
+			/*
+			 * If we have a copy of the object 'oid' in a cruft
+			 * pack, then either read the cruft pack's mtime for
+			 * that object, or, if that can't be loaded, assume the
+			 * pack's mtime itself.
+			 */
+			if (!load_pack_mtimes(p)) {
+				uint32_t pos;
+				if (offset_to_pack_pos(p, ofs, &pos) < 0)
+					continue;
+				candidate_mtime = nth_packed_mtime(p, pos);
+			} else {
+				candidate_mtime = p->mtime;
+			}
+
+			/*
+			 * We have a surviving copy of the object in a cruft
+			 * pack whose mtime is greater than or equal to the one
+			 * we are considering. We can thus avoid packing an
+			 * additional copy of that object.
+			 */
+			if (mtime <= candidate_mtime)
+				return 0;
+		}
 	}
 
 	return -1;
@@ -1749,13 +1753,15 @@ static int want_object_in_pack_mtime(const struct object_id *oid,
 		}
 	}
 
-	for (e = the_repository->objects->packfiles->packs.head; e; e = e->next) {
-		struct packed_git *p = e->pack;
-		want = want_object_in_pack_one(p, oid, exclude, found_pack, found_offset, found_mtime);
-		if (!exclude && want > 0)
-			packfile_list_prepend(&the_repository->objects->packfiles->packs, p);
-		if (want != -1)
-			return want;
+	for (source = the_repository->objects->sources; source; source = source->next) {
+		for (e = source->packfiles->packs.head; e; e = e->next) {
+			struct packed_git *p = e->pack;
+			want = want_object_in_pack_one(p, oid, exclude, found_pack, found_offset, found_mtime);
+			if (!exclude && want > 0)
+				packfile_list_prepend(&source->packfiles->packs, p);
+			if (want != -1)
+				return want;
+		}
 	}
 
 	if (uri_protocols.nr) {
diff --git a/http.c b/http.c
index 41f850db16..7815f144de 100644
--- a/http.c
+++ b/http.c
@@ -2544,7 +2544,7 @@ void http_install_packfile(struct packed_git *p,
 			   struct packfile_list *list_to_remove_from)
 {
 	packfile_list_remove(list_to_remove_from, p);
-	packfile_store_add_pack(the_repository->objects->packfiles, p);
+	packfile_store_add_pack(the_repository->objects->sources->packfiles, p);
 }
 
 struct http_pack_request *new_http_pack_request(
diff --git a/midx.c b/midx.c
index 24e1e72175..dbb2aa68ba 100644
--- a/midx.c
+++ b/midx.c
@@ -95,7 +95,7 @@ static int midx_read_object_offsets(const unsigned char *chunk_start,
 
 struct multi_pack_index *get_multi_pack_index(struct odb_source *source)
 {
-	packfile_store_prepare(source->odb->packfiles);
+	packfile_store_prepare(source->packfiles);
 	return source->midx;
 }
 
@@ -447,7 +447,6 @@ static uint32_t midx_for_pack(struct multi_pack_index **_m,
 int prepare_midx_pack(struct multi_pack_index *m,
 		      uint32_t pack_int_id)
 {
-	struct repository *r = m->source->odb->repo;
 	struct strbuf pack_name = STRBUF_INIT;
 	struct packed_git *p;
 
@@ -460,7 +459,7 @@ int prepare_midx_pack(struct multi_pack_index *m,
 
 	strbuf_addf(&pack_name, "%s/pack/%s", m->source->path,
 		    m->pack_names[pack_int_id]);
-	p = packfile_store_load_pack(r->objects->packfiles,
+	p = packfile_store_load_pack(m->source->packfiles,
 				     pack_name.buf, m->source->local);
 	strbuf_release(&pack_name);
 
diff --git a/odb.c b/odb.c
index 94144a69f5..f159fbdd99 100644
--- a/odb.c
+++ b/odb.c
@@ -155,6 +155,7 @@ static struct odb_source *odb_source_new(struct object_database *odb,
 	source->local = local;
 	source->path = xstrdup(path);
 	source->loose = odb_source_loose_new(source);
+	source->packfiles = packfile_store_new(source);
 
 	return source;
 }
@@ -373,6 +374,7 @@ static void odb_source_free(struct odb_source *source)
 {
 	free(source->path);
 	odb_source_loose_free(source->loose);
+	packfile_store_free(source->packfiles);
 	free(source);
 }
 
@@ -704,19 +706,19 @@ static int do_oid_object_info_extended(struct object_database *odb,
 	while (1) {
 		struct odb_source *source;
 
-		if (!packfile_store_read_object_info(odb->packfiles, real, oi, flags))
-			return 0;
-
 		/* Most likely it's a loose object. */
-		for (source = odb->sources; source; source = source->next)
-			if (!odb_source_loose_read_object_info(source, real, oi, flags))
+		for (source = odb->sources; source; source = source->next) {
+			if (!packfile_store_read_object_info(source->packfiles, real, oi, flags) ||
+			    !odb_source_loose_read_object_info(source, real, oi, flags))
 				return 0;
+		}
 
 		/* Not a loose object; someone else may have just packed it. */
 		if (!(flags & OBJECT_INFO_QUICK)) {
 			odb_reprepare(odb->repo->objects);
-			if (!packfile_store_read_object_info(odb->packfiles, real, oi, flags))
-				return 0;
+			for (source = odb->sources; source; source = source->next)
+				if (!packfile_store_read_object_info(source->packfiles, real, oi, flags))
+					return 0;
 		}
 
 		/*
@@ -975,13 +977,14 @@ int odb_freshen_object(struct object_database *odb,
 {
 	struct odb_source *source;
 
-	if (packfile_store_freshen_object(odb->packfiles, oid))
-		return 1;
-
 	odb_prepare_alternates(odb);
-	for (source = odb->sources; source; source = source->next)
+	for (source = odb->sources; source; source = source->next) {
+		if (packfile_store_freshen_object(source->packfiles, oid))
+			return 1;
+
 		if (odb_source_loose_freshen_object(source, oid))
 			return 1;
+	}
 
 	return 0;
 }
@@ -1064,7 +1067,6 @@ struct object_database *odb_new(struct repository *repo,
 	o->sources = odb_source_new(o, primary_source, true);
 	o->sources_tail = &o->sources->next;
 	o->alternate_db = xstrdup_or_null(secondary_sources);
-	o->packfiles = packfile_store_new(o->sources);
 
 	free(to_free);
 
@@ -1077,9 +1079,8 @@ void odb_close(struct object_database *o)
 {
 	struct odb_source *source;
 
-	packfile_store_close(o->packfiles);
-
 	for (source = o->sources; source; source = source->next) {
+		packfile_store_close(source->packfiles);
 		if (source->midx)
 			close_midx(source->midx);
 		source->midx = NULL;
@@ -1118,7 +1119,6 @@ void odb_free(struct object_database *o)
 		free((char *) o->cached_objects[i].value.buf);
 	free(o->cached_objects);
 
-	packfile_store_free(o->packfiles);
 	string_list_clear(&o->submodule_source_paths, 0);
 
 	chdir_notify_unregister(NULL, odb_update_commondir, o);
@@ -1141,13 +1141,13 @@ void odb_reprepare(struct object_database *o)
 	o->loaded_alternates = 0;
 	odb_prepare_alternates(o);
 
-	for (source = o->sources; source; source = source->next)
+	for (source = o->sources; source; source = source->next) {
 		odb_source_loose_reprepare(source);
+		packfile_store_reprepare(source->packfiles);
+	}
 
 	o->approximate_object_count_valid = 0;
 
-	packfile_store_reprepare(o->packfiles);
-
 	obj_read_unlock();
 }
 
diff --git a/odb.h b/odb.h
index 014cd9585a..c97b41c58c 100644
--- a/odb.h
+++ b/odb.h
@@ -51,6 +51,9 @@ struct odb_source {
 	/* Private state for loose objects. */
 	struct odb_source_loose *loose;
 
+	/* Should only be accessed directly by packfile.c and midx.c. */
+	struct packfile_store *packfiles;
+
 	/*
 	 * private data
 	 *
@@ -128,9 +131,6 @@ struct object_database {
 	struct commit_graph *commit_graph;
 	unsigned commit_graph_attempted : 1; /* if loading has been attempted */
 
-	/* Should only be accessed directly by packfile.c and midx.c. */
-	struct packfile_store *packfiles;
-
 	/*
 	 * This is meant to hold a *small* number of objects that you would
 	 * want odb_read_object() to be able to return, but yet you do not want
diff --git a/odb/streaming.c b/odb/streaming.c
index 745cd486fb..4a4474f891 100644
--- a/odb/streaming.c
+++ b/odb/streaming.c
@@ -185,13 +185,12 @@ static int istream_source(struct odb_read_stream **out,
 {
 	struct odb_source *source;
 
-	if (!packfile_store_read_object_stream(out, odb->packfiles, oid))
-		return 0;
-
 	odb_prepare_alternates(odb);
-	for (source = odb->sources; source; source = source->next)
-		if (!odb_source_loose_read_object_stream(out, source, oid))
+	for (source = odb->sources; source; source = source->next) {
+		if (!packfile_store_read_object_stream(out, source->packfiles, oid) ||
+		    !odb_source_loose_read_object_stream(out, source, oid))
 			return 0;
+	}
 
 	return open_istream_incore(out, odb, oid);
 }
diff --git a/packfile.c b/packfile.c
index 3700612465..a0225cb2cb 100644
--- a/packfile.c
+++ b/packfile.c
@@ -357,12 +357,14 @@ static void scan_windows(struct packed_git *p,
 
 static int unuse_one_window(struct object_database *odb)
 {
+	struct odb_source *source;
 	struct packfile_list_entry *e;
 	struct packed_git *lru_p = NULL;
 	struct pack_window *lru_w = NULL, *lru_l = NULL;
 
-	for (e = odb->packfiles->packs.head; e; e = e->next)
-		scan_windows(e->pack, &lru_p, &lru_w, &lru_l);
+	for (source = odb->sources; source; source = source->next)
+		for (e = source->packfiles->packs.head; e; e = e->next)
+			scan_windows(e->pack, &lru_p, &lru_w, &lru_l);
 
 	if (lru_p) {
 		munmap(lru_w->base, lru_w->len);
@@ -528,15 +530,18 @@ static void find_lru_pack(struct packed_git *p, struct packed_git **lru_p, struc
 
 static int close_one_pack(struct repository *r)
 {
+	struct odb_source *source;
 	struct packfile_list_entry *e;
 	struct packed_git *lru_p = NULL;
 	struct pack_window *mru_w = NULL;
 	int accept_windows_inuse = 1;
 
-	for (e = r->objects->packfiles->packs.head; e; e = e->next) {
-		if (e->pack->pack_fd == -1)
-			continue;
-		find_lru_pack(e->pack, &lru_p, &mru_w, &accept_windows_inuse);
+	for (source = r->objects->sources; source; source = source->next) {
+		for (e = source->packfiles->packs.head; e; e = e->next) {
+			if (e->pack->pack_fd == -1)
+				continue;
+			find_lru_pack(e->pack, &lru_p, &mru_w, &accept_windows_inuse);
+		}
 	}
 
 	if (lru_p)
@@ -987,7 +992,7 @@ static void prepare_pack(const char *full_name, size_t full_name_len,
 	if (strip_suffix_mem(full_name, &base_len, ".idx") &&
 	    !(data->source->midx && midx_contains_pack(data->source->midx, file_name))) {
 		char *trimmed_path = xstrndup(full_name, full_name_len);
-		packfile_store_load_pack(data->source->odb->packfiles,
+		packfile_store_load_pack(data->source->packfiles,
 					 trimmed_path, data->source->local);
 		free(trimmed_path);
 	}
@@ -1245,11 +1250,15 @@ void mark_bad_packed_object(struct packed_git *p, const struct object_id *oid)
 const struct packed_git *has_packed_and_bad(struct repository *r,
 					    const struct object_id *oid)
 {
-	struct packfile_list_entry *e;
+	struct odb_source *source;
+
+	for (source = r->objects->sources; source; source = source->next) {
+		struct packfile_list_entry *e;
+		for (e = source->packfiles->packs.head; e; e = e->next)
+			if (oidset_contains(&e->pack->bad_objects, oid))
+				return e->pack;
+	}
 
-	for (e = r->objects->packfiles->packs.head; e; e = e->next)
-		if (oidset_contains(&e->pack->bad_objects, oid))
-			return e->pack;
 	return NULL;
 }
 
@@ -2089,26 +2098,32 @@ static int find_pack_entry(struct repository *r,
 			   const struct object_id *oid,
 			   struct pack_entry *e)
 {
-	struct packfile_list_entry *l;
+	struct odb_source *source;
 
-	packfile_store_prepare(r->objects->packfiles);
+	/*
+	 * Note: `packfile_store_prepare()` prepares stores from all sources.
+	 * This will be fixed in a subsequent commit.
+	 */
+	packfile_store_prepare(r->objects->sources->packfiles);
 
-	for (struct odb_source *source = r->objects->sources; source; source = source->next)
+	for (source = r->objects->sources; source; source = source->next)
 		if (source->midx && fill_midx_entry(source->midx, oid, e))
 			return 1;
 
-	if (!r->objects->packfiles->packs.head)
-		return 0;
+	for (source = r->objects->sources; source; source = source->next) {
+		struct packfile_list_entry *l;
 
-	for (l = r->objects->packfiles->packs.head; l; l = l->next) {
-		struct packed_git *p = l->pack;
+		for (l = source->packfiles->packs.head; l; l = l->next) {
+			struct packed_git *p = l->pack;
 
-		if (!p->multi_pack_index && fill_pack_entry(oid, e, p)) {
-			if (!r->objects->packfiles->skip_mru_updates)
-				packfile_list_prepend(&r->objects->packfiles->packs, p);
-			return 1;
+			if (!p->multi_pack_index && fill_pack_entry(oid, e, p)) {
+				if (!source->packfiles->skip_mru_updates)
+					packfile_list_prepend(&source->packfiles->packs, p);
+				return 1;
+			}
 		}
 	}
+
 	return 0;
 }
 
@@ -2216,12 +2231,18 @@ int find_kept_pack_entry(struct repository *r,
 			 unsigned flags,
 			 struct pack_entry *e)
 {
-	struct packed_git **cache = packfile_store_get_kept_pack_cache(r->objects->packfiles, flags);
+	struct odb_source *source;
 
-	for (; *cache; cache++) {
-		struct packed_git *p = *cache;
-		if (fill_pack_entry(oid, e, p))
-			return 1;
+	for (source = r->objects->sources; source; source = source->next) {
+		struct packed_git **cache;
+
+		cache = packfile_store_get_kept_pack_cache(source->packfiles, flags);
+
+		for (; *cache; cache++) {
+			struct packed_git *p = *cache;
+			if (fill_pack_entry(oid, e, p))
+				return 1;
+		}
 	}
 
 	return 0;
@@ -2287,32 +2308,46 @@ int for_each_object_in_pack(struct packed_git *p,
 int for_each_packed_object(struct repository *repo, each_packed_object_fn cb,
 			   void *data, enum for_each_object_flags flags)
 {
-	struct packed_git *p;
+	struct odb_source *source;
 	int r = 0;
 	int pack_errors = 0;
 
-	repo->objects->packfiles->skip_mru_updates = true;
-	repo_for_each_pack(repo, p) {
-		if ((flags & FOR_EACH_OBJECT_LOCAL_ONLY) && !p->pack_local)
-			continue;
-		if ((flags & FOR_EACH_OBJECT_PROMISOR_ONLY) &&
-		    !p->pack_promisor)
-			continue;
-		if ((flags & FOR_EACH_OBJECT_SKIP_IN_CORE_KEPT_PACKS) &&
-		    p->pack_keep_in_core)
-			continue;
-		if ((flags & FOR_EACH_OBJECT_SKIP_ON_DISK_KEPT_PACKS) &&
-		    p->pack_keep)
-			continue;
-		if (open_pack_index(p)) {
-			pack_errors = 1;
-			continue;
+	odb_prepare_alternates(repo->objects);
+
+	for (source = repo->objects->sources; source; source = source->next) {
+		struct packfile_list_entry *e;
+
+		source->packfiles->skip_mru_updates = true;
+
+		for (e = packfile_store_get_packs(source->packfiles); e; e = e->next) {
+			struct packed_git *p = e->pack;
+
+			if ((flags & FOR_EACH_OBJECT_LOCAL_ONLY) && !p->pack_local)
+				continue;
+			if ((flags & FOR_EACH_OBJECT_PROMISOR_ONLY) &&
+			    !p->pack_promisor)
+				continue;
+			if ((flags & FOR_EACH_OBJECT_SKIP_IN_CORE_KEPT_PACKS) &&
+			    p->pack_keep_in_core)
+				continue;
+			if ((flags & FOR_EACH_OBJECT_SKIP_ON_DISK_KEPT_PACKS) &&
+			    p->pack_keep)
+				continue;
+			if (open_pack_index(p)) {
+				pack_errors = 1;
+				continue;
+			}
+
+			r = for_each_object_in_pack(p, cb, data, flags);
+			if (r)
+				break;
 		}
-		r = for_each_object_in_pack(p, cb, data, flags);
+
+		source->packfiles->skip_mru_updates = false;
+
 		if (r)
 			break;
 	}
-	repo->objects->packfiles->skip_mru_updates = false;
 
 	return r ? r : pack_errors;
 }
diff --git a/packfile.h b/packfile.h
index 410f85f03d..07f7cdbad1 100644
--- a/packfile.h
+++ b/packfile.h
@@ -5,6 +5,7 @@
 #include "object.h"
 #include "odb.h"
 #include "oidset.h"
+#include "repository.h"
 #include "strmap.h"
 
 /* in odb.h */
@@ -170,14 +171,65 @@ void packfile_store_reprepare(struct packfile_store *store);
 void packfile_store_add_pack(struct packfile_store *store,
 			     struct packed_git *pack);
 
+/*
+ * Get all packs managed by the given store, including packfiles that are
+ * referenced by multi-pack indices.
+ */
+struct packfile_list_entry *packfile_store_get_packs(struct packfile_store *store);
+
+struct repo_for_each_pack_data {
+	struct odb_source *source;
+	struct packfile_list_entry *entry;
+};
+
+static inline struct repo_for_each_pack_data repo_for_eack_pack_data_init(struct repository *repo)
+{
+	struct repo_for_each_pack_data data = { 0 };
+
+	odb_prepare_alternates(repo->objects);
+
+	for (struct odb_source *source = repo->objects->sources; source; source = source->next) {
+		struct packfile_list_entry *entry = packfile_store_get_packs(source->packfiles);
+		if (!entry)
+			continue;
+		data.source = source;
+		data.entry = entry;
+		break;
+	}
+
+	return data;
+}
+
+static inline void repo_for_each_pack_data_next(struct repo_for_each_pack_data *data)
+{
+	struct odb_source *source;
+
+	data->entry = data->entry->next;
+	if (data->entry)
+		return;
+
+	for (source = data->source->next; source; source = source->next) {
+		struct packfile_list_entry *entry = packfile_store_get_packs(source->packfiles);
+		if (!entry)
+			continue;
+		data->source = source;
+		data->entry = entry;
+		return;
+	}
+
+	data->source = NULL;
+	data->entry = NULL;
+}
+
 /*
  * Load and iterate through all packs of the given repository. This helper
  * function will yield packfiles from all object sources connected to the
  * repository.
  */
 #define repo_for_each_pack(repo, p) \
-	for (struct packfile_list_entry *e = packfile_store_get_packs(repo->objects->packfiles); \
-	     ((p) = (e ? e->pack : NULL)); e = e->next)
+	for (struct repo_for_each_pack_data eack_pack_data = repo_for_eack_pack_data_init(repo); \
+	     ((p) = (eack_pack_data.entry ? eack_pack_data.entry->pack : NULL)); \
+	     repo_for_each_pack_data_next(&eack_pack_data))
 
 int packfile_store_read_object_stream(struct odb_read_stream **out,
 				      struct packfile_store *store,
@@ -194,12 +246,6 @@ int packfile_store_read_object_info(struct packfile_store *store,
 				    struct object_info *oi,
 				    unsigned flags);
 
-/*
- * Get all packs managed by the given store, including packfiles that are
- * referenced by multi-pack indices.
- */
-struct packfile_list_entry *packfile_store_get_packs(struct packfile_store *store);
-
 /*
  * Open the packfile and add it to the store if it isn't yet known. Returns
  * either the newly opened packfile or the preexisting packfile. Returns a

-- 
2.52.0.542.g9473a8513b.dirty

