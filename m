Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976603B4E8F
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 06:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781678409; cv=none; b=O9jLDvbdDvyMC1Xf9ho6DqRW3LF5Oi+i2MxyDXCoUhRxUqsDIW9py9bNzqkrC02SXYulgna6M0FeoB8ag52uDBKtSOZl65eAolmc8dHW+7QaHeFhBGBD9qS2ygZtS2Yq3lIjdM9XMPqknTW8BRzhpNiEyS8WPeN8xb9NlmyY0ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781678409; c=relaxed/simple;
	bh=FcqIHqmRZw7BXbhN/vOZsK2WyIv+Oz5De5OFrik4ux4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D8Ok4UJl5IBTHJNRXItLFWO1jtKfTnfO5ssMHFuJBFms8fymSL2RERl6BzLQcaeubaAeX6oHy1SvW+COR9V9dAztFu8DqQWssKPw9PTOkoEtfGBHV+kCpQao0u167RpjlxX2BPKs4iNOX8wLuFer2swBi/maCfxK4DQr0LFWcCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FZ2xCWyj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AD54G7fo; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FZ2xCWyj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AD54G7fo"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id F11DD1D00129;
	Wed, 17 Jun 2026 02:40:06 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 17 Jun 2026 02:40:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781678406;
	 x=1781764806; bh=CFH6PBVUkJIYddlGuDZ0/3LAUvvrbDIiK6pjgDyC+Bw=; b=
	FZ2xCWyjUi0bb8+1MKx/j1pnEANuDtExvkneQULoK2TDJ4NomjHrGseKEVOvgXhw
	WE+ILhtJmssLO3NW4AJ4c0BUXqHLlhaDrT1EKKZ1BAj9J2ETJ/kC4/+mXkogm61s
	uasNLGHe1uLFy4srkoCbwtOIgoIZyjdyDw5/7YL2nzbBDNQRQ+31F2L1VsvGY/zY
	0TyIjJW2s5Kw1zpQiI/2VLG51YSuzWS4FWJnHYovvOwWiJyOPV04vBZv8tMZ1r+6
	JcNZE0Y3p6V+WZsMv83g4qnnDpubfSEIEyURoLdNKCwsmgTMR9FBkLd4eS+SeruX
	UY3PzBcASyzfDnxLtilY3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781678406; x=
	1781764806; bh=CFH6PBVUkJIYddlGuDZ0/3LAUvvrbDIiK6pjgDyC+Bw=; b=A
	D54G7foM5IEPZre1CNadKwwLJ8CpCpoSAIOIJPZ+Xb5yqCmUtZSAljxBs4yzq1U6
	pFAPCPhVoXVjrym1U85TN52Jgvfhe78R34cS51EXZaSwABi6H8giG83f1PNigjtC
	G/LOsHTz4hXW47EFRqhUwu3UDks8PgzUVh7FsCtazqvqJmTIih9edP/CLfydiEhU
	xQuWnR0hhrIF0PqZn4cNWVga5ehrYJjLY6qJkJ9ulYm0pNsUSyqM66bv7c/7EJcK
	UxG2NvAAnSMCrjneA5TA6V/8GiZK6XUJ3nTI5xZ+6WqIS5v24O1qInhH5f+nQi4i
	pzxFkavP9whINBok1WR5g==
X-ME-Sender: <xms:RkEyat-DoyTghP7JoavcBP44GILNimhwqEKmMaEjNe4BUqhoZ28VtA>
    <xme:RkEyak-IK6qpWRrRduSORw39tS3yRZiNMa_bF7Hiz6_aS2PxnBWGpi9Y3qPHHcVEF
    _EUcfzIiq_9rpt-mDF40ra48z4uTZVKBRc7axF7UgMYFnLIjOhu>
X-ME-Received: <xmr:RkEyakeHnqSdXyllj_Tw3fKdsvcePePTEvHpmxoszBqXQmOYsdXvBKcSNIkGGgeWiKokfKvSF16Lua74MrnxXz9qoKim69H84bsF9h4>
X-ME-Proxy-Cause: dmFkZTEnB39eLvyMgsk+d1zBATJAS2Dd09yZUP4TCe4zWysBccoWgY8Y+enBv1+9aJfPT8
    oVvaCC5MWGV30uZzKswgiCAK2gGSGYELp/F+QCNhRNY/bQx6x+ywijOIUW8TKDwAx48Lcx
    KhLHoOJu9m1Ux2Kfz7iOtjqmT/hnPJJkdtWT0xsGgHMCb1yqiVx9G0A93DDw8nseLTKulF
    USUks9qtFi47cv66z4EPIfMktSNXs9lIOpQJ4JZJ8Sqt4LT7yml6xL5bA1DQ7F1XoINCS5
    8+0eJLKjW+BUl0nBlxv0Wa8T6T4Bg1YQKal6uMYv+KeVZbCqw870pv0xnOpn9ZF3vGEMlf
    7TzSeYKy5885b5/+J2mY6DGZKie4RbR5GKT3Bhky8Ov7raIHPzTOG67f/mnbYHQbvVf07p
    jNB2k+cBjg/0e1ILYTDkcWVelf/GYQYywieCXylnatCnmhW+hUIW1H0ByLzJ3tDSh+0Dfa
    JiGbRjwXA0+8McXkheC5dxW28FEL9K8cFFYiPuARlq5/gOURMKN9hZGwvdtj/nyyPO8Nng
    rfmIr0sbJaJ2WUDy8CsCOW2W6p2g90j2mNWqLemKeSVxojlONqsOLT9yOGYJ2lp3tRWNc9
    ISIBMnovOw7vtz3thy4oJYlb5Bf++IcWznIZ1o1LawP9WF3LdFDc24Xp8usg
X-ME-Proxy: <xmx:RkEyatHe3jbpPIWW7aUIPqFZ33t-PL_Gu9QCsEpsAtX6RUQkUVM3mw>
    <xmx:RkEyaicmUkrBJtnlhR1yLjMpwDkqxfwZwkH1H8GlbPLQ-8muPuF0Qw>
    <xmx:RkEyanFSCN_2ItduilTxLOWG625rG8Tq2TzcF9RwnJcFLsCTxel5OA>
    <xmx:RkEyarVg99FuoK2T98C9JfTEJbf2Hfd3J1ginwPxApZTcuSacORQfg>
    <xmx:RkEyam5vht630LEmsXxXBtvHDWiTphUaffv3o6Rf3xZu4f0mtepX-HGC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jun 2026 02:40:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1664318c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 17 Jun 2026 06:40:02 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 17 Jun 2026 08:39:46 +0200
Subject: [PATCH v3 03/17] packfile: move packed source into "odb/"
 subsystem
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-pks-odb-source-packed-v3-3-b5c7583cd795@pks.im>
References: <20260617-pks-odb-source-packed-v3-0-b5c7583cd795@pks.im>
In-Reply-To: <20260617-pks-odb-source-packed-v3-0-b5c7583cd795@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

In subsequent patches we'll be turning `struct odb_source_packed` into a
proper `struct odb_source`. As a first step towards this goal, move its
struct out of "packfile.{c,h}" and into "odb/source-packed.{c,h}".

This detaches the implementation of the packfile object source from the
generic packfile code, following the same convention already used by the
"files" and "in-memory" sources.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile            |  1 +
 meson.build         |  1 +
 odb/source-files.c  |  2 +-
 odb/source-packed.c | 11 ++++++++
 odb/source-packed.h | 72 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 packfile.c          |  9 -------
 packfile.h          | 66 +-----------------------------------------------
 7 files changed, 87 insertions(+), 75 deletions(-)

diff --git a/Makefile b/Makefile
index ed1731548e..113fa45993 100644
--- a/Makefile
+++ b/Makefile
@@ -1218,6 +1218,7 @@ LIB_OBJS += odb/source.o
 LIB_OBJS += odb/source-files.o
 LIB_OBJS += odb/source-inmemory.o
 LIB_OBJS += odb/source-loose.o
+LIB_OBJS += odb/source-packed.o
 LIB_OBJS += odb/streaming.o
 LIB_OBJS += odb/transaction.o
 LIB_OBJS += oid-array.o
diff --git a/meson.build b/meson.build
index 12913fc948..ca235801cf 100644
--- a/meson.build
+++ b/meson.build
@@ -406,6 +406,7 @@ libgit_sources = [
   'odb/source-files.c',
   'odb/source-inmemory.c',
   'odb/source-loose.c',
+  'odb/source-packed.c',
   'odb/streaming.c',
   'odb/transaction.c',
   'oid-array.c',
diff --git a/odb/source-files.c b/odb/source-files.c
index 5bdd042922..191562f316 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -269,7 +269,7 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
 	CALLOC_ARRAY(files, 1);
 	odb_source_init(&files->base, odb, ODB_SOURCE_FILES, path, local);
 	files->loose = odb_source_loose_new(odb, path, local);
-	files->packed = packfile_store_new(&files->base);
+	files->packed = odb_source_packed_new(&files->base);
 
 	files->base.free = odb_source_files_free;
 	files->base.close = odb_source_files_close;
diff --git a/odb/source-packed.c b/odb/source-packed.c
new file mode 100644
index 0000000000..1e94b47ea0
--- /dev/null
+++ b/odb/source-packed.c
@@ -0,0 +1,11 @@
+#include "git-compat-util.h"
+#include "odb/source-packed.h"
+
+struct odb_source_packed *odb_source_packed_new(struct odb_source *source)
+{
+	struct odb_source_packed *store;
+	CALLOC_ARRAY(store, 1);
+	store->source = source;
+	strmap_init(&store->packs_by_path);
+	return store;
+}
diff --git a/odb/source-packed.h b/odb/source-packed.h
new file mode 100644
index 0000000000..327be4ad65
--- /dev/null
+++ b/odb/source-packed.h
@@ -0,0 +1,72 @@
+#ifndef ODB_SOURCE_PACKED_H
+#define ODB_SOURCE_PACKED_H
+
+#include "odb/source.h"
+#include "packfile-list.h"
+#include "strmap.h"
+
+/*
+ * A store that manages packfiles for a given object database.
+ */
+struct odb_source_packed {
+	struct odb_source *source;
+
+	/*
+	 * The list of packfiles in the order in which they have been most
+	 * recently used.
+	 */
+	struct packfile_list packs;
+
+	/*
+	 * Cache of packfiles which are marked as "kept", either because there
+	 * is an on-disk ".keep" file or because they are marked as "kept" in
+	 * memory.
+	 *
+	 * Should not be accessed directly, but via
+	 * `packfile_store_get_kept_pack_cache()`. The list of packs gets
+	 * invalidated when the stored flags and the flags passed to
+	 * `packfile_store_get_kept_pack_cache()` mismatch.
+	 */
+	struct {
+		struct packed_git **packs;
+		unsigned flags;
+	} kept_cache;
+
+	/* The multi-pack index that belongs to this specific packfile store. */
+	struct multi_pack_index *midx;
+
+	/*
+	 * A map of packfile names to packed_git structs for tracking which
+	 * packs have been loaded already.
+	 */
+	struct strmap packs_by_path;
+
+	/*
+	 * Whether packfiles have already been populated with this store's
+	 * packs.
+	 */
+	bool initialized;
+
+	/*
+	 * Usually, packfiles will be reordered to the front of the `packs`
+	 * list whenever an object is looked up via them. This has the effect
+	 * that packs that contain a lot of accessed objects will be located
+	 * towards the front.
+	 *
+	 * This is usually desireable, but there are exceptions. One exception
+	 * is when the looking up multiple objects in a loop for each packfile.
+	 * In that case, we may easily end up with an infinite loop as the
+	 * packfiles get reordered to the front repeatedly.
+	 *
+	 * Setting this field to `true` thus disables these reorderings.
+	 */
+	bool skip_mru_updates;
+};
+
+/*
+ * Allocate and initialize a new empty packfile store for the given object
+ * database source.
+ */
+struct odb_source_packed *odb_source_packed_new(struct odb_source *source);
+
+#endif
diff --git a/packfile.c b/packfile.c
index 27ea4a8436..99be5789ef 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2749,15 +2749,6 @@ int parse_pack_header_option(const char *in, unsigned char *out, unsigned int *l
 	return 0;
 }
 
-struct odb_source_packed *packfile_store_new(struct odb_source *source)
-{
-	struct odb_source_packed *store;
-	CALLOC_ARRAY(store, 1);
-	store->source = source;
-	strmap_init(&store->packs_by_path);
-	return store;
-}
-
 void packfile_store_free(struct odb_source_packed *store)
 {
 	for (struct packfile_list_entry *e = store->packs.head; e; e = e->next)
diff --git a/packfile.h b/packfile.h
index 4e3d701a3a..2d0bb7adbe 100644
--- a/packfile.h
+++ b/packfile.h
@@ -5,10 +5,10 @@
 #include "object.h"
 #include "odb.h"
 #include "odb/source-files.h"
+#include "odb/source-packed.h"
 #include "oidset.h"
 #include "packfile-list.h"
 #include "repository.h"
-#include "strmap.h"
 
 /* in odb.h */
 struct object_info;
@@ -55,70 +55,6 @@ struct packed_git {
 	char pack_name[FLEX_ARRAY]; /* more */
 };
 
-/*
- * A store that manages packfiles for a given object database.
- */
-struct odb_source_packed {
-	struct odb_source *source;
-
-	/*
-	 * The list of packfiles in the order in which they have been most
-	 * recently used.
-	 */
-	struct packfile_list packs;
-
-	/*
-	 * Cache of packfiles which are marked as "kept", either because there
-	 * is an on-disk ".keep" file or because they are marked as "kept" in
-	 * memory.
-	 *
-	 * Should not be accessed directly, but via
-	 * `packfile_store_get_kept_pack_cache()`. The list of packs gets
-	 * invalidated when the stored flags and the flags passed to
-	 * `packfile_store_get_kept_pack_cache()` mismatch.
-	 */
-	struct {
-		struct packed_git **packs;
-		unsigned flags;
-	} kept_cache;
-
-	/* The multi-pack index that belongs to this specific packfile store. */
-	struct multi_pack_index *midx;
-
-	/*
-	 * A map of packfile names to packed_git structs for tracking which
-	 * packs have been loaded already.
-	 */
-	struct strmap packs_by_path;
-
-	/*
-	 * Whether packfiles have already been populated with this store's
-	 * packs.
-	 */
-	bool initialized;
-
-	/*
-	 * Usually, packfiles will be reordered to the front of the `packs`
-	 * list whenever an object is looked up via them. This has the effect
-	 * that packs that contain a lot of accessed objects will be located
-	 * towards the front.
-	 *
-	 * This is usually desireable, but there are exceptions. One exception
-	 * is when the looking up multiple objects in a loop for each packfile.
-	 * In that case, we may easily end up with an infinite loop as the
-	 * packfiles get reordered to the front repeatedly.
-	 *
-	 * Setting this field to `true` thus disables these reorderings.
-	 */
-	bool skip_mru_updates;
-};
-
-/*
- * Allocate and initialize a new empty packfile store for the given object
- * database source.
- */
-struct odb_source_packed *packfile_store_new(struct odb_source *source);
-
 /*
  * Free the packfile store and all its associated state. All packfiles
  * tracked by the store will be closed.

-- 
2.55.0.rc0.786.g65d90a0328.dirty

