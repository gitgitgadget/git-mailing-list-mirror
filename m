Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41AA156F45
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 08:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782118088; cv=none; b=r5GLFXzc9LHNiW+ve32BqpMpWNcOn97Z19BjUHKk17TiWmYjognFu931UIwyIEcrlFYQNxE815ZcA9btC+FYcuMUEE5aPSya8iOnapfaDOUfR313IkohTSqg2mftJsfP84b8QxlYOIDepx0lzN4Yu9OTnSVB3I7SY1NjMCKO1ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782118088; c=relaxed/simple;
	bh=VYMopPwV8nSGSR+Wip0ZvR+b3EY75UzUfaSan1sxpxo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HwJ6vUqoK8pkVB0yCOlTeiBwIoCgAxc7RBbMEUlFjfQCvH259pTY0IiDIKyo8bUiVTcwNm/OBC6IKkzSue9VaK7yrfNJCSNrMYv+vtm5cxsntSS3QSx6njcB/5YkaO10Wm5ENHm8kW8aQTY1NHrbJcefTeZ+QBzv1vgtOY3uhwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EI1PVfh0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MUZFf354; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EI1PVfh0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MUZFf354"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 192697A0113
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 04:48:06 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 22 Jun 2026 04:48:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782118085;
	 x=1782204485; bh=uHXAcuBLoewq9zZFWG4Oal+N1qepyaB5WuKmuVbtOTg=; b=
	EI1PVfh0XjA8lLBMXmj6FfvH4Bd+mkNFkCMClVYcUlXnexe3SL0fVYc1w+ISSg++
	JHLHwVYVmJUkDOK/u6E3CpFBWtPCjVIH0IfBoRI3N6DxTvzEKLTd2EUxJNyvsntb
	yzGU8PoqZHYZA9NHdEr75DuuxTy8g2LupUMfnpNs30UeKXUJ1gOjkFJnDF7Nph7a
	yi9E3iSjto2ahg0fkvjNA16Ge9wS/Z4L9L+my3HqlA0GZwGMKiI6Gn914dST/bti
	0SlzuGbBwP94Q1Q29RGxhi7Ds/0JzupARiAxOHRiTE5vH8GMfkfdyGLNOX5kC86t
	ZCqpAo4M3vBOZ9XVbAiejA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782118085; x=
	1782204485; bh=uHXAcuBLoewq9zZFWG4Oal+N1qepyaB5WuKmuVbtOTg=; b=M
	UZFf354mUbbFXeK33K5L5EemsSkAb968mDNBmMHm1KRz4+d3TjVIqdzwcE2W4NXV
	/YFX8XCNiiyTDFF2lP9OFfGfr4plEwLCPaDEKr2XOT28AJTWnAMXnQmkX8CvAT3N
	aNpSSXlWARwN5zmK37bwC/T9D9KeXuxqEW76961SsDeTwc/bRRqWFW15o5Ao84Se
	frH8IBdqnMpWU4ipD2TQXHlu5LL0j+rORbGe+8+ynEe2tRvbFKfoixZsN7/aX4ni
	ecwORFdKY8Uw6fvr5g+wjI/n++vs9RywQxOkVpeeGHDSWkI/iqGfg7FNEewUoIjT
	g3hNtmuQvXurwu4HvhOCA==
X-ME-Sender: <xms:xfY4ausqnTz7vW__8ESAntBI5i8pB1xamHuXft4jXfQmzOUNICh7zQ>
    <xme:xfY4aqZ8vgTEnhp8MO_T1U2cPvXN60WekHLX43n11xK2JYcqgWgj-hCSwvXAlhVNe
    DVfbg8g95eRczAhvXYV99XuIgIpjAvyVsArWJgD6V26q9rXZrVFkQ>
X-ME-Received: <xmr:xfY4avahQoL176AW9xHfvtR4lenwCjBMtl6QHqjFFnhNOWpteMX9ysVWRBlM6ixJ3FFaijzJqKOk9H4_k87jgmPXQDsQvUzif9x2DDCRng>
X-ME-Proxy-Cause: dmFkZTEOnajbKOjPDvzPIuSD6qi/CT4lxSKsp/grLoo+rkJBbIcbiK4GoLKyEODVuxYFKg
    Ua9MbapOYi58Bwzv0rDKaK6aGXCi6K3Uz/d7bTlu9te/pFqeZJ5TRoWQGRmLd1dVxgWmZn
    Vgb5EZZVJvJ7qbDwBkxlUt+c3nBAZJfAOe1r5YwrQDC5mIEpZTlaU1wiLGLBIVUJjiNYCX
    2PYvpXpc1EhP64Lnq4+sbRWpC+xDeUMiWDfLVCnHJN89DHIvNVfAIOZrKlZEA9lL6kicKx
    eUU1+iMrHMbXepB5nnaTwyeDj8GM+uEqMUbUnRU83HO6B8ETa8cKoDaUfnYHdN+vdmxeYq
    kSV55hwvlOK+lHPW/08n8ZqwhNfnT8iwt8rOV4CBDZ4HNbgwNw6k8NjQ8WPQ1WvARNOMLw
    DpQ1af87/t7NC44484hRUzgYUshm6L+sfhPTO2Vmr8B91D2U6+som9/AC8clw+7dIyNSom
    XOKdWnWIMoPmGvAhNyYKb4zc73S9bsUJyvQ97N5oWaB0T8tmuEqtQbBbm7ne+o0ADHFa1D
    e9Xgr742jdkVh2BluNo1JNyxFqAMIDDqCRN1rZZuTsD5pnS+qDl3i4fdI3YJN2PNukaUPV
    TiacqUA8NMohv6ZBWP4fhsgFbXok5hnAMp7L6+EkH4j3VtKdVaCrh8l/3XEA
X-ME-Proxy: <xmx:xfY4auV6H1_u_T0u0ZKV1IHjbi7bi2ZpflRTEJtHrT9RjS0RDUtcrg>
    <xmx:xfY4au0GEku4U3TVdVdkA8kty-E5pw21W2HleAiYftiLyqALXvRXlA>
    <xmx:xfY4atbNDNMh0nBwgKpHrqFRZ-YC5hsLWtAxROVNyU5SLnM23lN1ig>
    <xmx:xfY4aprxqMGpq4e9gNgXPOOc1O3lYhG44XTba1c_iCeAABFr3E-mIw>
    <xmx:xfY4apdNrFceMs_lf9_ECyPDJLneDVQtyLqBmvuy-FkiEYMm6481DLri>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 22 Jun 2026 04:48:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 12c48e1d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 22 Jun 2026 08:48:05 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 22 Jun 2026 10:47:54 +0200
Subject: [PATCH 1/2] odb/source: generalize `reprepare()` callback
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-b4-pks-odb-generalize-prepare-v1-1-d2a5c5d13144@pks.im>
References: <20260622-b4-pks-odb-generalize-prepare-v1-0-d2a5c5d13144@pks.im>
In-Reply-To: <20260622-b4-pks-odb-generalize-prepare-v1-0-d2a5c5d13144@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

The `reprepare()` callback function can be used to flush caches of a
given object source and then prepare it anew. This is for example used
when a concurrent process may have written new objects. Ultimately, this
can be seen as doing two separate steps:

  1. We drop any caches.

  2. We prepare the source.

We have one callsite in git-grep(1) though that really only want to do
(2). This is done by reaching into the "files" backend directly and then
calling `odb_source_packed_prepare()`, which of course may not work with
alternate backends.

We could in theory just call `reprepare()` here, and that would likely
not have any significant downside. But this would certainly feel like a
code smell.

Instead, generalize the `reprepare()` callback to `prepare()` with a
flag that optionally instructs the backend to also flush the caches,
which allows us to drop the external `odb_source_packed_prepare()`
declaration.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/grep.c        |  9 +++------
 midx.c                |  2 +-
 odb.c                 |  2 +-
 odb.h                 |  8 ++++++++
 odb/source-files.c    |  9 +++++----
 odb/source-inmemory.c |  5 +++--
 odb/source-loose.c    |  8 +++++---
 odb/source-packed.c   | 34 ++++++++++++++++------------------
 odb/source-packed.h   |  9 ---------
 odb/source.h          | 16 +++++++++-------
 packfile.c            |  2 +-
 11 files changed, 52 insertions(+), 52 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 8080d1bf5e..7361bf071e 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -25,12 +25,11 @@
 #include "setup.h"
 #include "submodule.h"
 #include "submodule-config.h"
-#include "object-file.h"
 #include "object-name.h"
 #include "odb.h"
+#include "odb/source.h"
 #include "oid-array.h"
 #include "oidset.h"
-#include "packfile.h"
 #include "pager.h"
 #include "path.h"
 #include "promisor-remote.h"
@@ -1361,10 +1360,8 @@ int cmd_grep(int argc,
 			struct odb_source *source;
 
 			odb_prepare_alternates(the_repository->objects);
-			for (source = the_repository->objects->sources; source; source = source->next) {
-				struct odb_source_files *files = odb_source_files_downcast(source);
-				odb_source_packed_prepare(files->packed);
-			}
+			for (source = the_repository->objects->sources; source; source = source->next)
+				odb_source_prepare(source, 0);
 		}
 
 		start_threads(&opt);
diff --git a/midx.c b/midx.c
index cc6b94f9dd..76c3f92cc3 100644
--- a/midx.c
+++ b/midx.c
@@ -101,7 +101,7 @@ static int midx_read_object_offsets(const unsigned char *chunk_start,
 
 struct multi_pack_index *get_multi_pack_index(struct odb_source_packed *source)
 {
-	odb_source_packed_prepare(source);
+	odb_source_prepare(&source->base, 0);
 	return source->midx;
 }
 
diff --git a/odb.c b/odb.c
index 965ef68e4e..7b45390e12 100644
--- a/odb.c
+++ b/odb.c
@@ -1086,7 +1086,7 @@ void odb_reprepare(struct object_database *o)
 	odb_prepare_alternates(o);
 
 	for (source = o->sources; source; source = source->next)
-		odb_source_reprepare(source);
+		odb_source_prepare(source, ODB_PREPARE_FLUSH_CACHES);
 
 	o->object_count_valid = 0;
 
diff --git a/odb.h b/odb.h
index 0030467a52..c14c9030e4 100644
--- a/odb.h
+++ b/odb.h
@@ -124,6 +124,14 @@ void odb_free(struct object_database *o);
  */
 void odb_close(struct object_database *o);
 
+enum odb_prepare_flags {
+	/*
+	 * Flush caches, reload alternates and then re-prepare each object
+	 * source so that new objects may become accessible.
+	 */
+	ODB_PREPARE_FLUSH_CACHES = (1 << 0),
+};
+
 /*
  * Clear caches, reload alternates and then reload object sources so that new
  * objects may become accessible.
diff --git a/odb/source-files.c b/odb/source-files.c
index 3bc6419dd7..ad9e0b52f9 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -41,11 +41,12 @@ static void odb_source_files_close(struct odb_source *source)
 	odb_source_close(&files->packed->base);
 }
 
-static void odb_source_files_reprepare(struct odb_source *source)
+static void odb_source_files_prepare(struct odb_source *source,
+				     enum odb_prepare_flags flags)
 {
 	struct odb_source_files *files = odb_source_files_downcast(source);
-	odb_source_reprepare(&files->loose->base);
-	odb_source_reprepare(&files->packed->base);
+	odb_source_prepare(&files->loose->base, flags);
+	odb_source_prepare(&files->packed->base, flags);
 }
 
 static int odb_source_files_read_object_info(struct odb_source *source,
@@ -273,7 +274,7 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
 
 	files->base.free = odb_source_files_free;
 	files->base.close = odb_source_files_close;
-	files->base.reprepare = odb_source_files_reprepare;
+	files->base.prepare = odb_source_files_prepare;
 	files->base.read_object_info = odb_source_files_read_object_info;
 	files->base.read_object_stream = odb_source_files_read_object_stream;
 	files->base.for_each_object = odb_source_files_for_each_object;
diff --git a/odb/source-inmemory.c b/odb/source-inmemory.c
index e004566d76..cc5e9e62cb 100644
--- a/odb/source-inmemory.c
+++ b/odb/source-inmemory.c
@@ -325,7 +325,8 @@ static void odb_source_inmemory_close(struct odb_source *source UNUSED)
 {
 }
 
-static void odb_source_inmemory_reprepare(struct odb_source *source UNUSED)
+static void odb_source_inmemory_prepare(struct odb_source *source UNUSED,
+					enum odb_prepare_flags flags UNUSED)
 {
 }
 
@@ -365,7 +366,7 @@ struct odb_source_inmemory *odb_source_inmemory_new(struct object_database *odb)
 
 	source->base.free = odb_source_inmemory_free;
 	source->base.close = odb_source_inmemory_close;
-	source->base.reprepare = odb_source_inmemory_reprepare;
+	source->base.prepare = odb_source_inmemory_prepare;
 	source->base.read_object_info = odb_source_inmemory_read_object_info;
 	source->base.read_object_stream = odb_source_inmemory_read_object_stream;
 	source->base.for_each_object = odb_source_inmemory_for_each_object;
diff --git a/odb/source-loose.c b/odb/source-loose.c
index 7d7ea2fb84..af46316e35 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -672,10 +672,12 @@ static void odb_source_loose_clear_cache(struct odb_source_loose *loose)
 	       sizeof(loose->subdir_seen));
 }
 
-static void odb_source_loose_reprepare(struct odb_source *source)
+static void odb_source_loose_prepare(struct odb_source *source,
+				     enum odb_prepare_flags flags)
 {
 	struct odb_source_loose *loose = odb_source_loose_downcast(source);
-	odb_source_loose_clear_cache(loose);
+	if (flags & ODB_PREPARE_FLUSH_CACHES)
+		odb_source_loose_clear_cache(loose);
 }
 
 static void odb_source_loose_close(struct odb_source *source UNUSED)
@@ -716,7 +718,7 @@ struct odb_source_loose *odb_source_loose_new(struct object_database *odb,
 
 	loose->base.free = odb_source_loose_free;
 	loose->base.close = odb_source_loose_close;
-	loose->base.reprepare = odb_source_loose_reprepare;
+	loose->base.prepare = odb_source_loose_prepare;
 	loose->base.read_object_info = odb_source_loose_read_object_info;
 	loose->base.read_object_stream = odb_source_loose_read_object_stream;
 	loose->base.for_each_object = odb_source_loose_for_each_object;
diff --git a/odb/source-packed.c b/odb/source-packed.c
index 42c28fba0e..fa5a072488 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -15,7 +15,7 @@ static int find_pack_entry(struct odb_source_packed *store,
 {
 	struct packfile_list_entry *l;
 
-	odb_source_packed_prepare(store);
+	odb_source_prepare(&store->base, 0);
 	if (store->midx && fill_midx_entry(store->midx, oid, e))
 		return 1;
 
@@ -47,7 +47,7 @@ static int odb_source_packed_read_object_info(struct odb_source *source,
 	 * been added since the last time we have prepared the packfile store.
 	 */
 	if (flags & OBJECT_INFO_SECOND_READ)
-		odb_source_reprepare(source);
+		odb_source_prepare(source, ODB_PREPARE_FLUSH_CACHES);
 
 	if (!find_pack_entry(packed, oid, &e))
 		return 1;
@@ -668,27 +668,25 @@ static int sort_pack(const struct packfile_list_entry *a,
 	return -1;
 }
 
-void odb_source_packed_prepare(struct odb_source_packed *source)
+static void odb_source_packed_prepare(struct odb_source *source,
+				      enum odb_prepare_flags flags)
 {
-	if (source->initialized)
+	struct odb_source_packed *packed = odb_source_packed_downcast(source);
+
+	if (flags & ODB_PREPARE_FLUSH_CACHES)
+		packed->initialized = false;
+	if (packed->initialized)
 		return;
 
-	prepare_multi_pack_index_one(source);
-	prepare_packed_git_one(source);
+	prepare_multi_pack_index_one(packed);
+	prepare_packed_git_one(packed);
 
-	sort_packs(&source->packs.head, sort_pack);
-	for (struct packfile_list_entry *e = source->packs.head; e; e = e->next)
+	sort_packs(&packed->packs.head, sort_pack);
+	for (struct packfile_list_entry *e = packed->packs.head; e; e = e->next)
 		if (!e->next)
-			source->packs.tail = e;
+			packed->packs.tail = e;
 
-	source->initialized = true;
-}
-
-static void odb_source_packed_reprepare(struct odb_source *source)
-{
-	struct odb_source_packed *packed = odb_source_packed_downcast(source);
-	packed->initialized = false;
-	odb_source_packed_prepare(packed);
+	packed->initialized = true;
 }
 
 static void odb_source_packed_reparent(const char *name UNUSED,
@@ -744,7 +742,7 @@ struct odb_source_packed *odb_source_packed_new(struct object_database *odb,
 
 	packed->base.free = odb_source_packed_free;
 	packed->base.close = odb_source_packed_close;
-	packed->base.reprepare = odb_source_packed_reprepare;
+	packed->base.prepare = odb_source_packed_prepare;
 	packed->base.read_object_info = odb_source_packed_read_object_info;
 	packed->base.read_object_stream = odb_source_packed_read_object_stream;
 	packed->base.for_each_object = odb_source_packed_for_each_object;
diff --git a/odb/source-packed.h b/odb/source-packed.h
index 88994098c1..d5230ac68c 100644
--- a/odb/source-packed.h
+++ b/odb/source-packed.h
@@ -82,13 +82,4 @@ static inline struct odb_source_packed *odb_source_packed_downcast(struct odb_so
 	return container_of(source, struct odb_source_packed, base);
 }
 
-/*
- * Prepare the source by loading packfiles and multi-pack indices for
- * all alternates. This becomes a no-op if the source is already prepared.
- *
- * It shouldn't typically be necessary to call this function directly, as
- * functions that access the source know to prepare it.
- */
-void odb_source_packed_prepare(struct odb_source_packed *source);
-
 #endif
diff --git a/odb/source.h b/odb/source.h
index b9a7642b2c..bbf1da3819 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -83,11 +83,12 @@ struct odb_source {
 	void (*close)(struct odb_source *source);
 
 	/*
-	 * This callback is expected to clear underlying caches of the object
-	 * database source. The function is called when the repository has for
-	 * example just been repacked so that new objects will become visible.
+	 * This callback is expected to prepare the source so that it becomes
+	 * ready for use. It optionally clears underlying caches of the object
+	 * database source.
 	 */
-	void (*reprepare)(struct odb_source *source);
+	void (*prepare)(struct odb_source *source,
+			enum odb_prepare_flags flags);
 
 	/*
 	 * This callback is expected to read object information from the object
@@ -308,13 +309,14 @@ static inline void odb_source_close(struct odb_source *source)
 }
 
 /*
- * Reprepare the object database source and clear any caches. Depending on the
+ * Prepare the object database source and clear any caches. Depending on the
  * backend used this may have the effect that concurrently-written objects
  * become visible.
  */
-static inline void odb_source_reprepare(struct odb_source *source)
+static inline void odb_source_prepare(struct odb_source *source,
+				      enum odb_prepare_flags flags)
 {
-	source->reprepare(source);
+	source->prepare(source, flags);
 }
 
 /*
diff --git a/packfile.c b/packfile.c
index 59cee7925d..d78fae981a 100644
--- a/packfile.c
+++ b/packfile.c
@@ -855,7 +855,7 @@ void for_each_file_in_pack_dir(const char *objdir,
 
 struct packfile_list_entry *packfile_store_get_packs(struct odb_source_packed *store)
 {
-	odb_source_packed_prepare(store);
+	odb_source_prepare(&store->base, 0);
 
 	if (store->midx) {
 		struct multi_pack_index *m = store->midx;

-- 
2.55.0.rc1.745.g43192e7977.dirty

