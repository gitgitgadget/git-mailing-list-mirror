Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D2A26D4E9
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 08:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755591605; cv=none; b=o6q2crdBNUg6RFoAQ6wvEyi+gR0WuiEIxKyS5muyWLXvRPqPdjz4/vus2hEEkb1hnnjd8hu/d2hjFCoGTooOKSn8N4oo0lJIFz2Mu6+5yR6R2QeBFdzIvtIEtTZcje9QmZwYaph1A3qp11p65RtJKAUPcM/IM+VUEfN4psqXKNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755591605; c=relaxed/simple;
	bh=h+gwKfg6eXLGd16pDliGCG57T3as/YIcFyn5RU3ay7k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I6FRnA93HIMa5cMJLyAvGpUwJO2vslsQAH8ktwpV05TS2fsFNPDGDFLGV/sp4x+6s63KR1Z6AkHFWvZRTBP/lrxkj/2VCu4qrpxMwXk5CK6JDbdvfnpdyQd7lwfRoHNMt0pEuPCcrZ/F05LI1xbTqUX78+AxlCLgz9z7jZqdyTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gKZUJBvP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=liqyY25J; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gKZUJBvP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="liqyY25J"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 91C957A027C
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 04:20:03 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 19 Aug 2025 04:20:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755591603;
	 x=1755678003; bh=rWc2ZqeFvGyRwLCsM4mqmGY5SUjm39ajRq0xQiVqbHA=; b=
	gKZUJBvP9f0jqK8LGipkWlxNnHXvIvZtMyy+8SXJq+zwevmtKB7xlwqX1X52PaeP
	jn/n/AWB5hqWd95LW3DGsWsK9KQLknaClSJGwwwH/w12R3Zady8cR+nzIGrXBVT4
	I2FoaDsh9UcY5CJFxKGiQZalsN5QF7JjSbw0jWL7cGyL6C9iOdxBNUtb+8xt6VPL
	h1pAUS4vXqpgAsENd3L6ZkUCs36YnwMI1kIaXN0qq2NKSjtyF5AkKdGRb0HJ47qP
	P+atAMh+xif3estuUGqAGaiU5Nf6ELFQBERDcUt5i6YBIJV/ka9i4CXMGPpXWm3x
	zmIv0mqfxMH7Tt+nSnzvMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755591603; x=
	1755678003; bh=rWc2ZqeFvGyRwLCsM4mqmGY5SUjm39ajRq0xQiVqbHA=; b=l
	iqyY25JxzkPUsjRjau7lRlp7B4XpmduUr0aUBwi5d1s0N15+SWkGSCH+ypq5W/et
	QwpViMIttqhmO4MlTGnfD2vvsuIoSmcn6Gdw5XHeeUcjHR14Nj82w6erLNA1aVBk
	z2+t9QHwqMTZalTi5hbUFfGgHEh5MC20MMcYyeW6/8sfJfBugjdUsRGa1rG+zCli
	So+NDz4USd1AV+/ugiTEJQPqvQMxKFEuxMyY3ar3RAvz1MF6Ss0Q7Ds/nS6x7MC/
	cujmmtiuYPnYsuEbw/mpWfoHDYtJO6p775tktbz0Q+r04RWUehaXff2HbKez4mir
	nREYvscElrEHVtsK8yj8Q==
X-ME-Sender: <xms:szOkaIVFWXLAijxS60JXa2G_LONEYLnDyY0IliNlkPlEoBr7iQUO4g>
    <xme:szOkaOmCNs2lxTNDXdbCY0qoEH9TRAcsyAdpTomzTXSotQKVxs8QZj1BTJPom7pYf
    ePvOz6HUZsPkUzCAA>
X-ME-Received: <xmr:szOkaFyUFH-7z3wSEYsSK-Euv7AwLy0YQcu-3vrF373i1fL8RqlAxefZo_9zCU_chlyr8XfHe372_EJ7r90plfLuYnp4tUKx4ui-BqDOsC3A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheegleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:szOkaJjIAscisGxKjtz-aDPw-PmPIwZXhUYgT1H396njF6IMG4uJZw>
    <xmx:szOkaKXlMrr-LK3j4rzqQBZtP6OiBXddA5vUIQTLHlw6VWfezmr6gw>
    <xmx:szOkaL0OGdvuoUqTD9qdHw_1rW4JWxnzpgaR1dq4tmuAku2gjf5ghA>
    <xmx:szOkaAG0uCG0gt57JvG443fFyemkXZEVy9y7YsF7HSBMMKoqID3ZSg>
    <xmx:szOkaIdDUUToD3xyS9kmQVPGhUA4UmZKWU1wUH0aZNE5nvmqGHkwTV47>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 19 Aug 2025 04:20:02 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 64a97e77 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Tue, 19 Aug 2025 08:20:01 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 19 Aug 2025 10:19:38 +0200
Subject: [PATCH 09/16] packfile: split up responsibilities of
 `reprepare_packed_git()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-b4-pks-packfiles-store-v1-9-1660842e125a@pks.im>
References: <20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im>
In-Reply-To: <20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

In `reprepare_packed_git()` we perform a couple of operations:

  - We reload alternate object directories.

  - We clear the loose object cache.

  - We reprepare packfiles.

While the logic is hosted in "packfile.c", it clearly reaches into other
subsystems that aren't related to packfiles.

Split up the responsibility and introduce `odb_reprepare()` which now
becomes responsible for repreparing the whole object database. The
existing `reprepare_packed_git()` function is refactored accordingly and
only cares about reloading the packfile store now.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/backfill.c     |  2 +-
 builtin/gc.c           |  4 ++--
 builtin/receive-pack.c |  2 +-
 builtin/repack.c       |  2 +-
 bulk-checkin.c         |  2 +-
 connected.c            |  2 +-
 fetch-pack.c           |  4 ++--
 object-name.c          |  2 +-
 odb.c                  | 25 ++++++++++++++++++++++++-
 odb.h                  |  6 ++++++
 packfile.c             | 26 ++++----------------------
 packfile.h             |  9 ++++++++-
 transport-helper.c     |  2 +-
 13 files changed, 53 insertions(+), 35 deletions(-)

diff --git a/builtin/backfill.c b/builtin/backfill.c
index 80056abe47..e80fc1b694 100644
--- a/builtin/backfill.c
+++ b/builtin/backfill.c
@@ -53,7 +53,7 @@ static void download_batch(struct backfill_context *ctx)
 	 * We likely have a new packfile. Add it to the packed list to
 	 * avoid possible duplicate downloads of the same objects.
 	 */
-	reprepare_packed_git(ctx->repo);
+	odb_reprepare(ctx->repo->objects);
 }
 
 static int fill_missing_blobs(const char *path UNUSED,
diff --git a/builtin/gc.c b/builtin/gc.c
index 0edd94a76f..1d30d1af2c 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1041,7 +1041,7 @@ int cmd_gc(int argc,
 		die(FAILED_RUN, "rerere");
 
 	report_garbage = report_pack_garbage;
-	reprepare_packed_git(the_repository);
+	odb_reprepare(the_repository->objects);
 	if (pack_garbage.nr > 0) {
 		close_object_store(the_repository->objects);
 		clean_pack_garbage();
@@ -1490,7 +1490,7 @@ static off_t get_auto_pack_size(void)
 	struct packed_git *p;
 	struct repository *r = the_repository;
 
-	reprepare_packed_git(r);
+	odb_reprepare(r->objects);
 	for (p = get_all_packs(r); p; p = p->next) {
 		if (p->pack_size > max_size) {
 			second_largest_size = max_size;
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 1113137a6f..c9288a9c7e 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -2389,7 +2389,7 @@ static const char *unpack(int err_fd, struct shallow_info *si)
 		status = finish_command(&child);
 		if (status)
 			return "index-pack abnormal exit";
-		reprepare_packed_git(the_repository);
+		odb_reprepare(the_repository->objects);
 	}
 	return NULL;
 }
diff --git a/builtin/repack.c b/builtin/repack.c
index a4def39197..ee8c80cd95 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -1684,7 +1684,7 @@ int cmd_repack(int argc,
 			goto cleanup;
 	}
 
-	reprepare_packed_git(the_repository);
+	odb_reprepare(the_repository->objects);
 
 	if (delete_redundant) {
 		int opts = 0;
diff --git a/bulk-checkin.c b/bulk-checkin.c
index b2809ab039..f65439a748 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -90,7 +90,7 @@ static void flush_bulk_checkin_packfile(struct bulk_checkin_packfile *state)
 
 	strbuf_release(&packname);
 	/* Make objects we just wrote available to ourselves */
-	reprepare_packed_git(the_repository);
+	odb_reprepare(the_repository->objects);
 }
 
 /*
diff --git a/connected.c b/connected.c
index 18c13245d8..d6e9682fd9 100644
--- a/connected.c
+++ b/connected.c
@@ -72,7 +72,7 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 		 * Before checking for promisor packs, be sure we have the
 		 * latest pack-files loaded into memory.
 		 */
-		reprepare_packed_git(the_repository);
+		odb_reprepare(the_repository->objects);
 		do {
 			struct packed_git *p;
 
diff --git a/fetch-pack.c b/fetch-pack.c
index 46c39f85c4..3b8960608c 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1982,7 +1982,7 @@ static void update_shallow(struct fetch_pack_args *args,
 		 * remote is shallow, but this is a clone, there are
 		 * no objects in repo to worry about. Accept any
 		 * shallow points that exist in the pack (iow in repo
-		 * after get_pack() and reprepare_packed_git())
+		 * after get_pack() and odb_reprepare())
 		 */
 		struct oid_array extra = OID_ARRAY_INIT;
 		struct object_id *oid = si->shallow->oid;
@@ -2107,7 +2107,7 @@ struct ref *fetch_pack(struct fetch_pack_args *args,
 		ref_cpy = do_fetch_pack(args, fd, ref, sought, nr_sought,
 					&si, pack_lockfiles);
 	}
-	reprepare_packed_git(the_repository);
+	odb_reprepare(the_repository->objects);
 
 	if (!args->cloning && args->deepen) {
 		struct check_connected_options opt = CHECK_CONNECTED_INIT;
diff --git a/object-name.c b/object-name.c
index 11aa0e6afc..44b0d416ac 100644
--- a/object-name.c
+++ b/object-name.c
@@ -596,7 +596,7 @@ static enum get_oid_result get_short_oid(struct repository *r,
 	 * or migrated from loose to packed.
 	 */
 	if (status == MISSING_OBJECT) {
-		reprepare_packed_git(r);
+		odb_reprepare(r->objects);
 		find_short_object_filename(&ds);
 		find_short_packed_object(&ds);
 		status = finish_object_disambiguation(&ds, oid);
diff --git a/odb.c b/odb.c
index 80ec6fc1fa..37ed21f53b 100644
--- a/odb.c
+++ b/odb.c
@@ -694,7 +694,7 @@ static int do_oid_object_info_extended(struct object_database *odb,
 
 		/* Not a loose object; someone else may have just packed it. */
 		if (!(flags & OBJECT_INFO_QUICK)) {
-			reprepare_packed_git(odb->repo);
+			odb_reprepare(odb->repo->objects);
 			if (find_pack_entry(odb->repo, real, &e))
 				break;
 		}
@@ -1039,3 +1039,26 @@ void odb_clear(struct object_database *o)
 
 	string_list_clear(&o->submodule_source_paths, 0);
 }
+
+void odb_reprepare(struct object_database *o)
+{
+	struct odb_source *source;
+
+	/*
+	 * Reprepare alt odbs, in case the alternates file was modified
+	 * during the course of this process. This only _adds_ odbs to
+	 * the linked list, so existing odbs will continue to exist for
+	 * the lifetime of the process.
+	 */
+	o->loaded_alternates = 0;
+	odb_prepare_alternates(o);
+
+	for (source = o->sources; source; source = source->next)
+		odb_clear_loose_cache(source);
+
+	o->approximate_object_count_valid = 0;
+
+	packfile_store_reprepare(o->packfiles);
+
+	obj_read_unlock();
+}
diff --git a/odb.h b/odb.h
index f1736b067c..9810ec60a0 100644
--- a/odb.h
+++ b/odb.h
@@ -155,6 +155,12 @@ struct object_database {
 struct object_database *odb_new(struct repository *repo);
 void odb_clear(struct object_database *o);
 
+/*
+ * Clear caches, reload alternates and then reload object sources so that new
+ * objects may become accessible.
+ */
+void odb_reprepare(struct object_database *o);
+
 /*
  * Find source by its object directory path. Dies in case the source couldn't
  * be found.
diff --git a/packfile.c b/packfile.c
index 58e50d7b30..180c95ec1c 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1003,28 +1003,10 @@ static void packfile_store_prepare(struct packfile_store *store)
 	store->initialized = 1;
 }
 
-void reprepare_packed_git(struct repository *r)
+void packfile_store_reprepare(struct packfile_store *store)
 {
-	struct odb_source *source;
-
-	obj_read_lock();
-
-	/*
-	 * Reprepare alt odbs, in case the alternates file was modified
-	 * during the course of this process. This only _adds_ odbs to
-	 * the linked list, so existing odbs will continue to exist for
-	 * the lifetime of the process.
-	 */
-	r->objects->loaded_alternates = 0;
-	odb_prepare_alternates(r->objects);
-
-	for (source = r->objects->sources; source; source = source->next)
-		odb_clear_loose_cache(source);
-
-	r->objects->approximate_object_count_valid = 0;
-	r->objects->packfiles->initialized = 0;
-	packfile_store_prepare(r->objects->packfiles);
-	obj_read_unlock();
+	store->initialized = 0;
+	packfile_store_prepare(store);
 }
 
 struct packed_git *get_packed_git(struct repository *r)
@@ -1145,7 +1127,7 @@ unsigned long get_size_from_delta(struct packed_git *p,
 		 *
 		 * Other worrying sections could be the call to close_pack_fd(),
 		 * which can close packs even with in-use windows, and to
-		 * reprepare_packed_git(). Regarding the former, mmap doc says:
+		 * odb_reprepare(). Regarding the former, mmap doc says:
 		 * "closing the file descriptor does not unmap the region". And
 		 * for the latter, it won't re-open already available packs.
 		 */
diff --git a/packfile.h b/packfile.h
index f46ea9ceec..75672c808a 100644
--- a/packfile.h
+++ b/packfile.h
@@ -104,6 +104,14 @@ void packfile_store_free(struct packfile_store *store);
  */
 void packfile_store_close(struct packfile_store *store);
 
+/*
+ * Clear the packfile caches and try to look up any new packfiles that have
+ * appeared since last preparing the packfiles store.
+ *
+ * This function must be called under the `odb_read_lock()`.
+ */
+void packfile_store_reprepare(struct packfile_store *store);
+
 struct pack_window {
 	struct pack_window *next;
 	unsigned char *base;
@@ -180,7 +188,6 @@ int for_each_packed_object(struct repository *repo, each_packed_object_fn cb,
 #define PACKDIR_FILE_GARBAGE 4
 extern void (*report_garbage)(unsigned seen_bits, const char *path);
 
-void reprepare_packed_git(struct repository *r);
 void install_packed_git(struct repository *r, struct packed_git *pack);
 
 struct packed_git *get_packed_git(struct repository *r);
diff --git a/transport-helper.c b/transport-helper.c
index 0789e5bca5..4d95d84f9e 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -450,7 +450,7 @@ static int fetch_with_fetch(struct transport *transport,
 	}
 	strbuf_release(&buf);
 
-	reprepare_packed_git(the_repository);
+	odb_reprepare(the_repository->objects);
 	return 0;
 }
 

-- 
2.51.0.261.g7ce5a0a67e.dirty

