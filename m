Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCAE2C21E1
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 07:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755761978; cv=none; b=Ez4CQ5NZabEtxdDZvyoJkyBANN2e4aHtRpaYsCPYDRXhmemPQeRf1fkfmEC7PupJFLU2uVzlhtO21oVWhD3i8/M6Ts77j+eIuxKR+knjxcS/58HvQcKxQTrl/B1Is6oj0cRNBnBEeWyZzfjKQLYED30t/DngJjNjv+vg52MmXn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755761978; c=relaxed/simple;
	bh=g90p8fNDbv8slF1BueHu0gGt889X98YDV1ciNzV/ZMk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PX03GIkZyVnQxB6yN62/7Xa3q9roR0fnEdBqv+yv7e9IesUPD5c5+1wtmOa1AFx3DMyeHT9QEEooyftC48Ah+i7dH3AGlbgz8R/LF24UH/U15BGjKkVyCGJFDvKLYbiSVw3ekzu3CUOjGdzWSSg9Yaj7lCUiebCR4qSSlYy/MXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IPnf/Jlj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KIUJ6a9Z; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IPnf/Jlj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KIUJ6a9Z"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1072D14000B7;
	Thu, 21 Aug 2025 03:39:36 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 21 Aug 2025 03:39:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755761976;
	 x=1755848376; bh=iSsXl93ZVbGUQ9Ut6nYrCM4PIrijunGBLKHqvIRnp/Y=; b=
	IPnf/JljIy7ak+QH5J4bGf7atKuQHw7Sy8X3UNZK3GjqIbB4oI+MwsFvgTy/cP8w
	tSzlBOVNWl+fXrb62eRMQigmewErnf2t/IfnVGpo4ySAYVtSdxnwlXXF8nfqty2I
	V3xRHh+qPsxwsJJeyDj1W/zjneeNMcc6NetbCExjYk2kwz6fHdLH23eEiTMczkXX
	YW45N8bfYd8DpjFlPOz0OqffF0UmXV61pC2FYpKH4coF/kABgTTVpW5D+Fks5IDI
	M6WEZKbukGO4ibqYpJDFE2++Fz/mmszmw2/P09G0udYfl3pLnqVjhPWpY4fHSOHL
	oxYWk3KicDp9iAWrRGWX6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755761976; x=
	1755848376; bh=iSsXl93ZVbGUQ9Ut6nYrCM4PIrijunGBLKHqvIRnp/Y=; b=K
	IUJ6a9Z1SCVUntEL20XI9Fd7L2vlgoGJu8pEKKMZ2hJSIiWEKrKHQ5t/d2YGgyiy
	tdKy1R3s9ORfim3jzA5gvB2GtFk0BsamkDeuAAQyqbHr6JB6Dk3xxB7hYwwT6fGU
	BfGHlAU2gJiutf/MRmiVr9VwdaZ9SfagJbtNj4NeLQYpNDO8HAj4FS25yYvZrlAu
	vCBbifhhX0qYrZLqkI9CYokynn3oVLHWFKpailfaO5l7ha8Paz/Py/FF/Kt1JX4E
	XUHjmgqKaALtWWTIyBcMln+6IlMXkavrL3uF/prA/+4OPLnxaY/SGMSYPFC+1zny
	KzrVQ+pfBiMJ2yIQX2Ccg==
X-ME-Sender: <xms:N82maE_nch4PgDKPGrmCHdFfr80AE0vtay_x-IyQVD9hasfEGjlbJw>
    <xme:N82maP9-DybfRMOnKmLpZo8PvpXz5ExvIWjq1b1pJFat7pV1UA9vQeF--elkKZHax
    FeAqT9VTXtOiZlX9A>
X-ME-Received: <xmr:N82maDewkD4iCNdrDMBVtZrYsy6qluCZgAb02juznialatc1uOIm95kBTCsfTepqhSe5MWIb7qS03UBcZtbuTFgF67ScihT-2znlbmhWcw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedtieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfh
    hfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:N82maAHtATHBuEO4f1_6Apbnsa6SlOom4hoBLR6rEU6SLTe96VOy5w>
    <xmx:N82maJdQPv5AygxDET4MhCA5grlUSgeKwJkG_TcbQale7x-eetQRxQ>
    <xmx:N82maCEE9-dAUi6ha69fzzoKGUNKQ8EZrpU6g1V51Q4lEAM1K0VIbA>
    <xmx:N82maKUofYG0H5ATtlI0leuZFvZHPfGnVpzPNrHTaOpZbfwVY2nKIQ>
    <xmx:OM2maMl392traJOcBOWpdQolIgSzetWf3ppY5W9oVsqrux2_sbdtKkSX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Aug 2025 03:39:35 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8adb9a39 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 21 Aug 2025 07:39:34 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 21 Aug 2025 09:39:07 +0200
Subject: [PATCH v2 09/16] packfile: split up responsibilities of
 `reprepare_packed_git()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-b4-pks-packfiles-store-v2-9-d10623355e9f@pks.im>
References: <20250821-b4-pks-packfiles-store-v2-0-d10623355e9f@pks.im>
In-Reply-To: <20250821-b4-pks-packfiles-store-v2-0-d10623355e9f@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>
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
index 2e45a3a05f..8e446dda69 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1003,28 +1003,10 @@ static void packfile_store_prepare(struct packfile_store *store)
 	store->initialized = true;
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
-	r->objects->packfiles->initialized = false;
-	packfile_store_prepare(r->objects->packfiles);
-	obj_read_unlock();
+	store->initialized = false;
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
index 74cea1a4a9..e9e60ec21b 100644
--- a/packfile.h
+++ b/packfile.h
@@ -103,6 +103,14 @@ void packfile_store_free(struct packfile_store *store);
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
@@ -179,7 +187,6 @@ int for_each_packed_object(struct repository *repo, each_packed_object_fn cb,
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

