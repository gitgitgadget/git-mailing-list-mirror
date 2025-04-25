Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D224723535C
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 07:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745564945; cv=none; b=sQu/0aeDHzOUNtSxhUu3SbKCnkUiP2Ou8GhN/gP20ekevpOeww+vws0+S6o+a6W5BVcPoZC7qmaDdMOaUnY0I4OaQgFQDQfBRSIqYMLZKSjal8lu5Bz9zTf8e/YroqdSogoRIfiTnitXcJdGPbz08ztTim6u8Ng/keDHUwRt0yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745564945; c=relaxed/simple;
	bh=gti8hXk6z4PZRVMpDn5ZgDKgruCQM2lLtz/b6IeqoKQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TxDwNmgZJFPx1HhoJr69Oj668UzUFEww84AEiDQTKiC5NWQ5onigyvTDePG0i5wqGiVKwEgcv4DzTzxQtEjvbr/m5Lfv4UHkVWRymYkIro+XqCTM9I53c9Su7oUJHELWXw7UwVrNPxU3YUzQhwbQKiNusuPvdiSbw4BH2ZA4uZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YAw9Sosx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tm1/TIaS; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YAw9Sosx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tm1/TIaS"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id ED16411401DD;
	Fri, 25 Apr 2025 03:09:01 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 25 Apr 2025 03:09:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1745564941;
	 x=1745651341; bh=aOFYBdthQoB2pYd2AOe/3yksAIG5k1Fk+Hg5Ikz03s8=; b=
	YAw9SosxLnlAFUtFYvUuXEIVnQTxxRbYdPkyfANtN8ytVFVaoHrWCI4hNxb3LYuF
	pxkO57V9bTBdoG4+SJiv/kDM/X1GFxP6O7AUSt11/Lpv+eJ1T1fL6gei9XhHTHVc
	cVONFSFI8WJGtvHtxn0VnWsLDqZBE4ZMEq3WlAANdXQ36UPf/KaJe4/1AjVUXoug
	1McWWQq82mf1LrN0jQQqrQOM2qJxAbR6aj3eL5JcxXYKO7AXzj2PFeejzVIUxR6W
	pmsZFohQs+Ewo48WtzO/91o7an2tJUWJzAAXjJHjM9B72So/zjqWfwYpgl9RpF/Z
	afkmULE1mz3u2GsB4nwqIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1745564941; x=
	1745651341; bh=aOFYBdthQoB2pYd2AOe/3yksAIG5k1Fk+Hg5Ikz03s8=; b=t
	m1/TIaSJr878/8v8rKHMTOUnWy5bS4wrQonQEAzvEtw7jhnA1vz68RO4VCPZ982g
	iXgSyhpCdP90iFYvX8truz4SjibnZcy1HqskUWtep4mzERn8TrUua20RH5nStj1c
	rtL607lf5fYoZRYw2eSqd1E11nUU8QED94tZx+n9Arr9DgsSZ47ccfNsMxZSNMUl
	nwPFTFGKGeWRJDcrFnu21YdnrZoekXb0ckYpkT8L6IcokEpnM4WcN64PWX9Ygab1
	TyxxPcAZwB7bx994gs8slZIalU3rWdNnolZaPIbRPVK1sfp+ISOj/+Gw9ElFvSOB
	vlV/92oYedIt2hvPcrpzQ==
X-ME-Sender: <xms:DTULaOz8TdNsr5m_ABnXCHOgfy9f2DNyzdhQacUFMyYhb9mKuT9Yhw>
    <xme:DTULaKTU9iJnQOeU0yk7LPHEAwORSSIuNUjMljXQ7QbNoJUEwZ7Tv_i7WTElo73YF
    zHlRBFxsQ1sP8a1yA>
X-ME-Received: <xmr:DTULaAU6tNyWktjp27h3PTTENuPbY0p5uI7kDBjd-QW6PBOmiBGHZExPxLGFbS2jyPT7AH7wfvaOd-pwcW9OAobLm_wm2jlvBSpU0hjK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvhedujedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:DTULaEieXPyxoL6WksatYnpIEl_G-uOSjwT0uD_8imoFt8EGA5Wwxg>
    <xmx:DTULaADZR0DECndZEsUqVQrNzDQfsFKTJaAr5dEQnjXJovRIR5LXrg>
    <xmx:DTULaFIBdHgwfaK0dXun6t16birJK3vrHzu5F7VTvFNAg1yYNWDJCw>
    <xmx:DTULaHDNyUiCRsrxzAUdC6AQc1VX6J38eloADf16KwBa2z7wyEnJrQ>
    <xmx:DTULaHfBoPOdQ10MfVh9_9UkWRlLXdi-aFH-_UyU4PKJ5WxZeNYmRWZI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Apr 2025 03:09:01 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 575219fb (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 25 Apr 2025 07:09:00 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 25 Apr 2025 09:08:55 +0200
Subject: [PATCH v2 04/13] object-store: move function declarations to their
 respective subsystems
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250425-pks-object-store-cleanups-v2-4-63f1695b7700@pks.im>
References: <20250425-pks-object-store-cleanups-v2-0-63f1695b7700@pks.im>
In-Reply-To: <20250425-pks-object-store-cleanups-v2-0-63f1695b7700@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.2

We carry declarations for a couple of functions in "object-store.h" that
are not defined in "object-store.c", but in a different subsystem. Move
these declarations to the respective headers whose matching code files
carry the corresponding definition.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/count-objects.c |  2 +-
 builtin/gc.c            |  2 +-
 object-file.h           | 73 +++++++++++++++++++++++++++++++++++++++
 object-name.c           |  2 +-
 object-store.h          | 91 +------------------------------------------------
 packfile.h              | 19 +++++++++++
 prune-packed.c          |  2 +-
 reachable.c             |  2 +-
 8 files changed, 98 insertions(+), 95 deletions(-)

diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index 0bb5360b2f2..a88c0c9c09a 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -12,7 +12,7 @@
 #include "parse-options.h"
 #include "quote.h"
 #include "packfile.h"
-#include "object-store.h"
+#include "object-file.h"
 
 static unsigned long garbage;
 static off_t size_garbage;
diff --git a/builtin/gc.c b/builtin/gc.c
index b5ce1d32766..4d428f3253d 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -28,7 +28,7 @@
 #include "commit.h"
 #include "commit-graph.h"
 #include "packfile.h"
-#include "object-store.h"
+#include "object-file.h"
 #include "pack.h"
 #include "pack-objects.h"
 #include "path.h"
diff --git a/object-file.h b/object-file.h
index 0a7b6b9f9d9..de6dd205ed8 100644
--- a/object-file.h
+++ b/object-file.h
@@ -3,6 +3,7 @@
 
 #include "git-zlib.h"
 #include "object.h"
+#include "object-store.h"
 
 struct index_state;
 
@@ -25,6 +26,16 @@ int index_path(struct index_state *istate, struct object_id *oid, const char *pa
 
 struct object_directory;
 
+/*
+ * Populate and return the loose object cache array corresponding to the
+ * given object ID.
+ */
+struct oidtree *odb_loose_cache(struct object_directory *odb,
+				const struct object_id *oid);
+
+/* Empty the loose object cache for the specified object directory. */
+void odb_clear_loose_cache(struct object_directory *odb);
+
 /*
  * Put in `buf` the name of the file in the local object database that
  * would be used to store a loose object with the specified oid.
@@ -42,6 +53,68 @@ int has_loose_object_nonlocal(const struct object_id *);
 
 int has_loose_object(const struct object_id *);
 
+void *map_loose_object(struct repository *r, const struct object_id *oid,
+		       unsigned long *size);
+
+/*
+ * Iterate over the files in the loose-object parts of the object
+ * directory "path", triggering the following callbacks:
+ *
+ *  - loose_object is called for each loose object we find.
+ *
+ *  - loose_cruft is called for any files that do not appear to be
+ *    loose objects. Note that we only look in the loose object
+ *    directories "objects/[0-9a-f]{2}/", so we will not report
+ *    "objects/foobar" as cruft.
+ *
+ *  - loose_subdir is called for each top-level hashed subdirectory
+ *    of the object directory (e.g., "$OBJDIR/f0"). It is called
+ *    after the objects in the directory are processed.
+ *
+ * Any callback that is NULL will be ignored. Callbacks returning non-zero
+ * will end the iteration.
+ *
+ * In the "buf" variant, "path" is a strbuf which will also be used as a
+ * scratch buffer, but restored to its original contents before
+ * the function returns.
+ */
+typedef int each_loose_object_fn(const struct object_id *oid,
+				 const char *path,
+				 void *data);
+typedef int each_loose_cruft_fn(const char *basename,
+				const char *path,
+				void *data);
+typedef int each_loose_subdir_fn(unsigned int nr,
+				 const char *path,
+				 void *data);
+int for_each_file_in_obj_subdir(unsigned int subdir_nr,
+				struct strbuf *path,
+				each_loose_object_fn obj_cb,
+				each_loose_cruft_fn cruft_cb,
+				each_loose_subdir_fn subdir_cb,
+				void *data);
+int for_each_loose_file_in_objdir(const char *path,
+				  each_loose_object_fn obj_cb,
+				  each_loose_cruft_fn cruft_cb,
+				  each_loose_subdir_fn subdir_cb,
+				  void *data);
+int for_each_loose_file_in_objdir_buf(struct strbuf *path,
+				      each_loose_object_fn obj_cb,
+				      each_loose_cruft_fn cruft_cb,
+				      each_loose_subdir_fn subdir_cb,
+				      void *data);
+
+/*
+ * Iterate over all accessible loose objects without respect to
+ * reachability. By default, this includes both local and alternate objects.
+ * The order in which objects are visited is unspecified.
+ *
+ * Any flags specific to packs are ignored.
+ */
+int for_each_loose_object(each_loose_object_fn, void *,
+			  enum for_each_object_flags flags);
+
+
 /**
  * format_object_header() is a thin wrapper around s xsnprintf() that
  * writes the initial "<type> <obj-len>" part of the loose object
diff --git a/object-name.c b/object-name.c
index 2c751a5352a..9288b2dd245 100644
--- a/object-name.c
+++ b/object-name.c
@@ -19,7 +19,7 @@
 #include "oidtree.h"
 #include "packfile.h"
 #include "pretty.h"
-#include "object-store.h"
+#include "object-file.h"
 #include "read-cache-ll.h"
 #include "repo-settings.h"
 #include "repository.h"
diff --git a/object-store.h b/object-store.h
index aa8fc63043e..5bbdaba92d1 100644
--- a/object-store.h
+++ b/object-store.h
@@ -82,16 +82,6 @@ struct object_directory *set_temporary_primary_odb(const char *dir, int will_des
  */
 void restore_primary_odb(struct object_directory *restore_odb, const char *old_path);
 
-/*
- * Populate and return the loose object cache array corresponding to the
- * given object ID.
- */
-struct oidtree *odb_loose_cache(struct object_directory *odb,
-				  const struct object_id *oid);
-
-/* Empty the loose object cache for the specified object directory. */
-void odb_clear_loose_cache(struct object_directory *odb);
-
 struct packed_git;
 struct multi_pack_index;
 struct cached_object_entry;
@@ -189,9 +179,6 @@ void raw_object_store_clear(struct raw_object_store *o);
  */
 int odb_mkstemp(struct strbuf *temp_filename, const char *pattern);
 
-void *map_loose_object(struct repository *r, const struct object_id *oid,
-		       unsigned long *size);
-
 void *repo_read_object_file(struct repository *r,
 			    const struct object_id *oid,
 			    enum object_type *type,
@@ -340,56 +327,7 @@ static inline void obj_read_unlock(void)
 	if(obj_read_use_lock)
 		pthread_mutex_unlock(&obj_read_mutex);
 }
-
-/*
- * Iterate over the files in the loose-object parts of the object
- * directory "path", triggering the following callbacks:
- *
- *  - loose_object is called for each loose object we find.
- *
- *  - loose_cruft is called for any files that do not appear to be
- *    loose objects. Note that we only look in the loose object
- *    directories "objects/[0-9a-f]{2}/", so we will not report
- *    "objects/foobar" as cruft.
- *
- *  - loose_subdir is called for each top-level hashed subdirectory
- *    of the object directory (e.g., "$OBJDIR/f0"). It is called
- *    after the objects in the directory are processed.
- *
- * Any callback that is NULL will be ignored. Callbacks returning non-zero
- * will end the iteration.
- *
- * In the "buf" variant, "path" is a strbuf which will also be used as a
- * scratch buffer, but restored to its original contents before
- * the function returns.
- */
-typedef int each_loose_object_fn(const struct object_id *oid,
-				 const char *path,
-				 void *data);
-typedef int each_loose_cruft_fn(const char *basename,
-				const char *path,
-				void *data);
-typedef int each_loose_subdir_fn(unsigned int nr,
-				 const char *path,
-				 void *data);
-int for_each_file_in_obj_subdir(unsigned int subdir_nr,
-				struct strbuf *path,
-				each_loose_object_fn obj_cb,
-				each_loose_cruft_fn cruft_cb,
-				each_loose_subdir_fn subdir_cb,
-				void *data);
-int for_each_loose_file_in_objdir(const char *path,
-				  each_loose_object_fn obj_cb,
-				  each_loose_cruft_fn cruft_cb,
-				  each_loose_subdir_fn subdir_cb,
-				  void *data);
-int for_each_loose_file_in_objdir_buf(struct strbuf *path,
-				      each_loose_object_fn obj_cb,
-				      each_loose_cruft_fn cruft_cb,
-				      each_loose_subdir_fn subdir_cb,
-				      void *data);
-
-/* Flags for for_each_*_object() below. */
+/* Flags for for_each_*_object(). */
 enum for_each_object_flags {
 	/* Iterate only over local objects, not alternates. */
 	FOR_EACH_OBJECT_LOCAL_ONLY = (1<<0),
@@ -409,33 +347,6 @@ enum for_each_object_flags {
 	FOR_EACH_OBJECT_SKIP_ON_DISK_KEPT_PACKS = (1<<4),
 };
 
-/*
- * Iterate over all accessible loose objects without respect to
- * reachability. By default, this includes both local and alternate objects.
- * The order in which objects are visited is unspecified.
- *
- * Any flags specific to packs are ignored.
- */
-int for_each_loose_object(each_loose_object_fn, void *,
-			  enum for_each_object_flags flags);
-
-/*
- * Iterate over all accessible packed objects without respect to reachability.
- * By default, this includes both local and alternate packs.
- *
- * Note that some objects may appear twice if they are found in multiple packs.
- * Each pack is visited in an unspecified order. By default, objects within a
- * pack are visited in pack-idx order (i.e., sorted by oid).
- */
-typedef int each_packed_object_fn(const struct object_id *oid,
-				  struct packed_git *pack,
-				  uint32_t pos,
-				  void *data);
-int for_each_object_in_pack(struct packed_git *p,
-			    each_packed_object_fn, void *data,
-			    enum for_each_object_flags flags);
-int for_each_packed_object(struct repository *repo, each_packed_object_fn cb,
-			   void *data, enum for_each_object_flags flags);
 
 void *read_object_with_reference(struct repository *r,
 				 const struct object_id *oid,
diff --git a/packfile.h b/packfile.h
index 05499382397..3a3c77cf05a 100644
--- a/packfile.h
+++ b/packfile.h
@@ -3,6 +3,7 @@
 
 #include "list.h"
 #include "object.h"
+#include "object-store.h"
 #include "oidset.h"
 
 /* in object-store.h */
@@ -117,6 +118,24 @@ void for_each_file_in_pack_dir(const char *objdir,
 			       each_file_in_pack_dir_fn fn,
 			       void *data);
 
+/*
+ * Iterate over all accessible packed objects without respect to reachability.
+ * By default, this includes both local and alternate packs.
+ *
+ * Note that some objects may appear twice if they are found in multiple packs.
+ * Each pack is visited in an unspecified order. By default, objects within a
+ * pack are visited in pack-idx order (i.e., sorted by oid).
+ */
+typedef int each_packed_object_fn(const struct object_id *oid,
+				  struct packed_git *pack,
+				  uint32_t pos,
+				  void *data);
+int for_each_object_in_pack(struct packed_git *p,
+			    each_packed_object_fn, void *data,
+			    enum for_each_object_flags flags);
+int for_each_packed_object(struct repository *repo, each_packed_object_fn cb,
+			   void *data, enum for_each_object_flags flags);
+
 /* A hook to report invalid files in pack directory */
 #define PACKDIR_FILE_PACK 1
 #define PACKDIR_FILE_IDX 2
diff --git a/prune-packed.c b/prune-packed.c
index c1d95a519d7..92fb4fbb0ed 100644
--- a/prune-packed.c
+++ b/prune-packed.c
@@ -2,7 +2,7 @@
 
 #include "git-compat-util.h"
 #include "gettext.h"
-#include "object-store.h"
+#include "object-file.h"
 #include "packfile.h"
 #include "progress.h"
 #include "prune-packed.h"
diff --git a/reachable.c b/reachable.c
index e5f56f40181..9dc748f0b9a 100644
--- a/reachable.c
+++ b/reachable.c
@@ -14,7 +14,7 @@
 #include "list-objects.h"
 #include "packfile.h"
 #include "worktree.h"
-#include "object-store.h"
+#include "object-file.h"
 #include "pack-bitmap.h"
 #include "pack-mtimes.h"
 #include "config.h"

-- 
2.49.0.901.g37484f566f.dirty

