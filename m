Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1282A2F60A7
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 10:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756810153; cv=none; b=FlrYiu2p/z/+6wbcQl/3Ylv4cnreu1fDzQ2V8e6W7jwo8910WQlGeGvVDbtQc/jc5w1sHuLkKgL4RZJtPtkmqzLhJGzjdeEQdWjzSaxeu3qBXMrjUdpVChYkwlixoVvww3hsv3wVWhfWKf9yQQpqbKajo1J+veKVtaJtTcrWGx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756810153; c=relaxed/simple;
	bh=lPcvkCAh4i6Q9ZQaRE5f4+yWLzuQAHkednDAy5oXJ8c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EKLw0K8V3PDAeLkX62G+dsMSSlxcSaDnFXyO2Rsgx6fCpL+gQwVwEeiT1YRfXpIdvEUKPKzaH5v2jgvGiu9t69xJAKzEaKrddDa0FpFceAdevIOo9DjuG2v3e5GdZQ9kOqtfo0BZpxvANywq62a3uQfwqUTDU4xdNADS8aBptl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GlXM84Ys; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JHVNns7o; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GlXM84Ys";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JHVNns7o"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4662C1400217;
	Tue,  2 Sep 2025 06:49:10 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 02 Sep 2025 06:49:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756810150;
	 x=1756896550; bh=oA+F46RD5MfgyNaNuwirtrF7Zui8h85Mcwlv/qjlv+o=; b=
	GlXM84YsWzD4bRMuOGHh5F8q8FEyS7uC07DEyQt6hHj0g/UfvIlIBY57qtJv6rtK
	UWW12y0Eneb8XtLbYBbAE7eVlWf+WtjvrTy46lBuWIa5+EVXoOdo2Mi2qjtcVNWw
	xpznDDD3fQ+52i1F+Mt0c4e3BjQ5EjwSK/RCJyLQUZ0cmtUkr+cUF4gdE3qJRGF/
	PSOULgCwJXfTJfyw2pMi0e2GHDlWis6n6l4WDMowElq2mWC+jtEzR2sSCqdgbN1U
	+KaTp6e5JcPXEENKw3m2R9RYrgMuvaLuKH+BiTNr1OKlMmtOCposAB83TmIoH7N4
	WKmXJ/+iEVYk3JfLWLpgjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756810150; x=
	1756896550; bh=oA+F46RD5MfgyNaNuwirtrF7Zui8h85Mcwlv/qjlv+o=; b=J
	HVNns7op2uqHVCoTX4KUmLNsTi4BwmkWVyAygeibonAe+CzMg9aOYBVW5McqMv3N
	OGExUgaqgyLeiuvZ+2oaAhOf8pAofWP2p55Uo6/APkr6bTYcbSn25Q3Rf31gicfE
	GFFgdeCzGA7QButkSIou8TKN75c9Jo+jUu5Ufmmqxl7jIc6A74bHqzfALe0wavZM
	jJYrOgEJBTJB86+WpCL2rv/yy6Ahro+WG1wFLk3B7v2oP1qsLru0RZNOUg6SvZAS
	v/jlqYmNySdgMnKmksgVplIhjfULFyUpIS1ySFrzCsjMEgdM2Ieo7+obWjrUzIJb
	+euzS8lVOwgzOYkBjODCA==
X-ME-Sender: <xms:psu2aKfsQDpdwUMF1pDF1lH4ARs4a-_nMT2dZOZ3BX9oVlbL3Qzwjw>
    <xme:psu2aPtfScHlsy0HXFQ7wRceobhBZqcJ67yBs82bLgSvt9jmCKfcNnvPljw_fCDVZ
    IURSDJP97Uhj9eyAw>
X-ME-Received: <xmr:psu2aB-KfuOfIfrklVCrZMBqzHC77Q7yWPDlu-_YJj57Z-kgIdYZIFELSh1dmutwsVBJetT0J77BVxGjT3anwxxTPq2RwWREjNDry61vdXN7Qw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddtiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    fhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepff
    euiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehl
    uhhsthgvrhfuihiivgepheenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdr
    tghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepmhgvse
    htthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:psu2aC1movhJ_lcycuquuIwiep_3QpvQtrmm8tyD2p3VXNR9JgDnog>
    <xmx:psu2aOBIagBpKaQFe-7MsUhNlajsnrliM_JTbM0Mp5u72rZJwjwxlw>
    <xmx:psu2aGePc28oaa66R4GM0mXN6cC_tHj2c9lj90hd1yrViXewqMDYsA>
    <xmx:psu2aD7ab8N_D6bmd7NJuYGPUhsK4J63Nccbm14HUArL1m4F8sLJYg>
    <xmx:psu2aGASKmz7HaFMCGla6p6Ii6ciy9cxMy6CKMOiabGjBTwriE5RhcrO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Sep 2025 06:49:09 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 410ddca8 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 2 Sep 2025 10:49:08 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 02 Sep 2025 12:48:34 +0200
Subject: [PATCH v3 09/15] packfile: split up responsibilities of
 `reprepare_packed_git()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-b4-pks-packfiles-store-v3-9-6925278efeda@pks.im>
References: <20250902-b4-pks-packfiles-store-v3-0-6925278efeda@pks.im>
In-Reply-To: <20250902-b4-pks-packfiles-store-v3-0-6925278efeda@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
 Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
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
 odb.c                  | 27 ++++++++++++++++++++++++++-
 odb.h                  |  6 ++++++
 packfile.c             | 26 ++++----------------------
 packfile.h             |  9 ++++++++-
 transport-helper.c     |  2 +-
 13 files changed, 55 insertions(+), 35 deletions(-)

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
index 03ae4926b2..aeca06a08b 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1042,7 +1042,7 @@ int cmd_gc(int argc,
 		die(FAILED_RUN, "rerere");
 
 	report_garbage = report_pack_garbage;
-	reprepare_packed_git(the_repository);
+	odb_reprepare(the_repository->objects);
 	if (pack_garbage.nr > 0) {
 		close_object_store(the_repository->objects);
 		clean_pack_garbage();
@@ -1491,7 +1491,7 @@ static off_t get_auto_pack_size(void)
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
index c490a51e91..5ff27fc8e2 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -1685,7 +1685,7 @@ int cmd_repack(int argc,
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
index 6ed5662951..fe7a84bf2f 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1983,7 +1983,7 @@ static void update_shallow(struct fetch_pack_args *args,
 		 * remote is shallow, but this is a clone, there are
 		 * no objects in repo to worry about. Accept any
 		 * shallow points that exist in the pack (iow in repo
-		 * after get_pack() and reprepare_packed_git())
+		 * after get_pack() and odb_reprepare())
 		 */
 		struct oid_array extra = OID_ARRAY_INIT;
 		struct object_id *oid = si->shallow->oid;
@@ -2108,7 +2108,7 @@ struct ref *fetch_pack(struct fetch_pack_args *args,
 		ref_cpy = do_fetch_pack(args, fd, ref, sought, nr_sought,
 					&si, pack_lockfiles);
 	}
-	reprepare_packed_git(the_repository);
+	odb_reprepare(the_repository->objects);
 
 	if (!args->cloning && args->deepen) {
 		struct check_connected_options opt = CHECK_CONNECTED_INIT;
diff --git a/object-name.c b/object-name.c
index 732056ff5e..df9e0c5f02 100644
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
index 32e982bf0b..65a6cc67b6 100644
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
@@ -1040,3 +1040,28 @@ void odb_clear(struct object_database *o)
 
 	string_list_clear(&o->submodule_source_paths, 0);
 }
+
+void odb_reprepare(struct object_database *o)
+{
+	struct odb_source *source;
+
+	obj_read_lock();
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
index 1c998a2478..ef34132c58 100644
--- a/odb.h
+++ b/odb.h
@@ -163,6 +163,12 @@ struct object_database {
 struct object_database *odb_new(struct repository *repo);
 void odb_clear(struct object_database *o);
 
+/*
+ * Clear caches, reload alternates and then reload object sources so that new
+ * objects may become accessible.
+ */
+void odb_reprepare(struct object_database *o);
+
 /*
  * Find source by its object directory path. Returns a `NULL` pointer in case
  * the source could not be found.
diff --git a/packfile.c b/packfile.c
index 4564026658..edd5ecc9cf 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1002,28 +1002,10 @@ static void packfile_store_prepare(struct packfile_store *store)
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
@@ -1144,7 +1126,7 @@ unsigned long get_size_from_delta(struct packed_git *p,
 		 *
 		 * Other worrying sections could be the call to close_pack_fd(),
 		 * which can close packs even with in-use windows, and to
-		 * reprepare_packed_git(). Regarding the former, mmap doc says:
+		 * odb_reprepare(). Regarding the former, mmap doc says:
 		 * "closing the file descriptor does not unmap the region". And
 		 * for the latter, it won't re-open already available packs.
 		 */
diff --git a/packfile.h b/packfile.h
index bf66211986..a85ff607fe 100644
--- a/packfile.h
+++ b/packfile.h
@@ -112,6 +112,14 @@ void packfile_store_free(struct packfile_store *store);
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
@@ -188,7 +196,6 @@ int for_each_packed_object(struct repository *repo, each_packed_object_fn cb,
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
2.51.0.384.g4c02a37b29.dirty

