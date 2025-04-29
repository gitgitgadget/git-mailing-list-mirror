Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DB9279908
	for <git@vger.kernel.org>; Tue, 29 Apr 2025 07:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745913150; cv=none; b=P6q3boAlXsjkQa5q98/MCF0PXa3tiVrbP7LH3z+TJN3nL+WWfOF3hfHHPCgMelAscrWzABjlq28ha3bbnJZHZnwKFUbvOuOjcNFGn0T25GebF6lBBJKVA2slearpeNc35lsYrD7KS3hu0B35djccGlfOBwqawrX8mMwnvSIUyfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745913150; c=relaxed/simple;
	bh=X3g8LYGuuPqscY48jdaqrSuKq8gc/M3AZ7ByO0yDPYU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Umfw6cvH+PCm1kVvw3aIzgWr9CirEuXMiRhBypmGUMG/tDwto/SIe2+aOGme7hjjaBNc7rEBA5KziDivq7eouW/PsfZwv+DtBSLH+7hmkA9fJxxqgQTGubj+fehSqF8swNsMfrKPh6plYXzBuVjodA3oFPTv1iIAdkBqqSmyZg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SV1OOVwS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DKXNFH5G; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SV1OOVwS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DKXNFH5G"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 45A6F114027F;
	Tue, 29 Apr 2025 03:52:27 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 29 Apr 2025 03:52:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1745913147;
	 x=1745999547; bh=PhPH767yG3Khvfu2lpw5FAWPKJQW/CC+2vQhjcV9FPU=; b=
	SV1OOVwS96oriee1jRDNKkMvfqteiuoSpdl9Yq76dYn7AJRRchJBwzuykHoNzEyq
	wLisLC0ZLJJo6XWbiayd9GPp5yMm8+bxJqxgvfna/WWQ6+5fK/2l3tpJKSOGGnUw
	sjVAhXaaDyZDokeq72XWIJG/5UYzeVgqPYtMiQeIYktabjDeA9+3ywnBgoON8Y0R
	V2k1XEWxUhlC/5X4JNfTeZKHRwKxsHOjT8yDvNig+BCxxSZ4hjw+OTGEVJ5KBIGR
	1wp+9hgORmdtlPO8y25yF0eAK2FmEdf51mQn4s7XQrgvKMMe2Fpms6/Wjk41tgi7
	pSdarF1cYXxUzpgv0jipdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1745913147; x=
	1745999547; bh=PhPH767yG3Khvfu2lpw5FAWPKJQW/CC+2vQhjcV9FPU=; b=D
	KXNFH5GbNGOpidDKhOc+H6ou9Fskfqixk7pSFlxYZqnOQe6ymPCIklEpQMl27R4i
	s1g0qu5C9yl8BPmIEOQdSuBGjgN7bZdptRganHaMWBjqYQEbGlD9r57iHvXQ4n1F
	v3YID/EbeDxXSPisZ0lDHTY3nABRtl4dy45Yvghhckp1mPwAij+B2SOz6WPlGJno
	SJUgFJcrJVUFJ4q7WeRMARnzkA3fhalXXoPzkzaX7umHWnh+BLHm4efeIxWMc2G7
	hoCmBxDCiCNJg9UT7szFHMLRrMLZX0HVbSf4bfqwqgQSxj+H0tCnuJHBJGj9nJp6
	8kYXSsuCOYbF0q1ikfigA==
X-ME-Sender: <xms:O4UQaKFZ9KdpFNl6mwgTYdNwtC_y4vl_OH3RPIsUqPoME4nQ-OeI2g>
    <xme:O4UQaLXr8pEx2b8zeWWK59gjd7XwPP8Li0761JfDXpZC9dJLoeQzMlXpYHnc_9GGq
    UyU8aqnQEzhUrocwQ>
X-ME-Received: <xmr:O4UQaEJSb5w1VbmkYhSy07VaRR_lb0uWxgtYTn9qdUueuSUOp6lPslxn6d2HYQTEXYXk1MqZFDISpczEoeBuh0UalN8ADeCzQXQd8xhkpI0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieefvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpd
    hrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:O4UQaEG-CPVggk4sYz2zzCTx0geUgIm5vTgn4JoWMfZC0GRfeJt40w>
    <xmx:O4UQaAUs1y1hheVBtVAb9eSs3PCaYtxZAH_JSyht5GHluxhoZ7PCEg>
    <xmx:O4UQaHPYrEEpkTm6FBmACcbrZIIBQgzb832BTCL84qS7m_9hF_maYA>
    <xmx:O4UQaH0MsffXn912BYaVLoGyHnM6Zk3atUURSBve9ZyjGqR0Gy9lHg>
    <xmx:O4UQaLArYV3KH1bkCtMe0q4GMLUCd4FuziJR3qahmMjPYupNqV9vmdHE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Apr 2025 03:52:26 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b177aad5 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 29 Apr 2025 07:52:20 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 29 Apr 2025 09:52:18 +0200
Subject: [PATCH v3 4/7] object-store: move function declarations to their
 respective subsystems
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250429-pks-object-store-cleanups-v3-4-42902bad09a1@pks.im>
References: <20250429-pks-object-store-cleanups-v3-0-42902bad09a1@pks.im>
In-Reply-To: <20250429-pks-object-store-cleanups-v3-0-42902bad09a1@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

We carry declarations for a couple of functions in "object-store.h" that
are not defined in "object-store.c", but in a different subsystem. Move
these declarations to the respective headers whose matching code files
carry the corresponding definition.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/count-objects.c |  2 +-
 builtin/gc.c            |  2 +-
 convert.c               |  2 +-
 diffcore-rename.c       |  2 +-
 dir.c                   |  2 +-
 log-tree.c              |  2 +-
 object-file.h           | 77 +++++++++++++++++++++++++++++++++++++++
 object-name.c           |  2 +-
 object-store.h          | 95 +------------------------------------------------
 packfile.h              | 19 ++++++++++
 prune-packed.c          |  2 +-
 reachable.c             |  2 +-
 12 files changed, 106 insertions(+), 103 deletions(-)

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
diff --git a/convert.c b/convert.c
index 8783e17941f..b5f7cf6306c 100644
--- a/convert.c
+++ b/convert.c
@@ -8,7 +8,7 @@
 #include "copy.h"
 #include "gettext.h"
 #include "hex.h"
-#include "object-store.h"
+#include "object-file.h"
 #include "attr.h"
 #include "run-command.h"
 #include "quote.h"
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 179731462b5..7723bc3334e 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -8,7 +8,7 @@
 #include "git-compat-util.h"
 #include "diff.h"
 #include "diffcore.h"
-#include "object-store.h"
+#include "object-file.h"
 #include "hashmap.h"
 #include "mem-pool.h"
 #include "oid-array.h"
diff --git a/dir.c b/dir.c
index 5c4675b4ac4..e11342e1366 100644
--- a/dir.c
+++ b/dir.c
@@ -17,7 +17,7 @@
 #include "environment.h"
 #include "gettext.h"
 #include "name-hash.h"
-#include "object-store.h"
+#include "object-file.h"
 #include "path.h"
 #include "refs.h"
 #include "repository.h"
diff --git a/log-tree.c b/log-tree.c
index a4d4ab59ca0..1d05dc1c701 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -9,7 +9,7 @@
 #include "environment.h"
 #include "hex.h"
 #include "object-name.h"
-#include "object-store.h"
+#include "object-file.h"
 #include "repository.h"
 #include "tmp-objdir.h"
 #include "commit.h"
diff --git a/object-file.h b/object-file.h
index 0a7b6b9f9d9..a85b2e5b494 100644
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
@@ -158,6 +231,10 @@ int finalize_object_file(const char *tmpfile, const char *filename);
 int finalize_object_file_flags(const char *tmpfile, const char *filename,
 			       enum finalize_object_file_flags flags);
 
+void hash_object_file(const struct git_hash_algo *algo, const void *buf,
+		      unsigned long len, enum object_type type,
+		      struct object_id *oid);
+
 /* Helper to check and "touch" a file */
 int check_and_freshen_file(const char *fn, int freshen);
 
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
index aa8fc63043e..9dc39a7c91e 100644
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
@@ -200,10 +187,6 @@ void *repo_read_object_file(struct repository *r,
 /* Read and unpack an object file into memory, write memory to an object file */
 int oid_object_info(struct repository *r, const struct object_id *, unsigned long *);
 
-void hash_object_file(const struct git_hash_algo *algo, const void *buf,
-		      unsigned long len, enum object_type type,
-		      struct object_id *oid);
-
 /*
  * Add an object file to the in-memory object store, without writing it
  * to disk.
@@ -340,56 +323,7 @@ static inline void obj_read_unlock(void)
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
@@ -409,33 +343,6 @@ enum for_each_object_flags {
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
2.49.0.967.g6a0df3ecc3.dirty

