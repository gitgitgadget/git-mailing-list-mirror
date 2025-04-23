Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B49E265CDC
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 07:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745394511; cv=none; b=cd5N7URe01dZMtDEzMiJv9osk5M7lzoRT3fXSKMZfz8maKktj5hU3bRg4ofmJp8CKsAc2ty8DaHIbwT5YF6iFL6sEvl5Jy9eoNxp4vBZ44+oQEirE6xrTUctCNiM5rtO4XbqzQz3R1YzVhjbuHFDdtlXMhE1NGw08tGE8/DJjZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745394511; c=relaxed/simple;
	bh=gti8hXk6z4PZRVMpDn5ZgDKgruCQM2lLtz/b6IeqoKQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UCi55iMStjI/HVboPO61cnO3dzYxlYc8pst2lb1+uBySWHR3BXlSZ8gvb6f1NH8EclJHtSDMH52aXYOA8y5RC6WirtBmjPzZn8Nd2pu7aRiA50YSYTarAGHwB0jB5XwMfWh2cfC58ZFP3Jhko9Fi+kch5BDNU1S/ST3qpsuF4O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rH8XLBpO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fkf4ygNj; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rH8XLBpO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fkf4ygNj"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3A51211402F0
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 03:48:28 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 23 Apr 2025 03:48:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1745394508;
	 x=1745480908; bh=aOFYBdthQoB2pYd2AOe/3yksAIG5k1Fk+Hg5Ikz03s8=; b=
	rH8XLBpOYEuuVQPWTHEhGurf5qYNRPaIc202cl8lq6HV0Tw2W1wxEUK2HhwdRRet
	iTxm9DUnuLIx0w4SL3VKbM23Z4VmBVn/v1OD3kTPFo3mfTBNjTx/JqsVDO3aQP6F
	M0gka2tkTtA9xD5qzncbuwKYFgomRpLoUtl9YZQRBE/SAbnznwdQTuwGzaY9LHEu
	sUps3ajqKYI2DQF6dDFyE7Jv0a0PF8IlHYXQng6vPvp3/uBYn9MVJfJdJMVYiS6o
	dt44UZwRF8uiyra45yyiZe7E+LB5IMcrFvhenOfQZ+qr0amdrNEYN+GEtg6/rtFp
	N5Nba9Ex1dJHQhg+wfbbsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1745394508; x=
	1745480908; bh=aOFYBdthQoB2pYd2AOe/3yksAIG5k1Fk+Hg5Ikz03s8=; b=f
	kf4ygNjZ46gsg0/u3ry4feLUunsZalIIxRIrCDCoDg6b+au2TO8J3FFfGwtzDLpp
	8JxA77PFITXT3RwYL6RUAGHtoEyH22/taBBcCotrAfIjJAqvYrYf4iPKYP6IEiqM
	rthnrcBW35kKS2zeFQk5L1U1meK1zDag8fkhnuyiBVqjqDO/UjAIJVEdKHCOobJn
	q/zXTOcqLT3OsL8/8mA4LLqDuxSZFtHR77MVrVPtr2Z7ppNl4pL0lbSDtsKRIVOf
	m4CVCqO47nmd4TuQxbcxnDoZMFbfOilpOjFMn8zgOrxSkRAjQeWXuLhxKovIYLC9
	/iOoAmBOpZbxR0fOc44ew==
X-ME-Sender: <xms:S5sIaBnUIg4NqpF-SneBsRN1JuwzIrYf5Q0ZccALnn3w85JF3443Fg>
    <xme:S5sIaM3gZMx0Et50CXGVI4qkn01EcykyhxCUEo5GUmEdP_GOixVwMUg1yFKu_hTg3
    g7t0pStZXrNNrCpzw>
X-ME-Received: <xmr:S5sIaHo9SKMSC0Gdg4PXy3p85Mw3YTf3kvVCOE4P1eMeaFheVzUMw03Jo99SyRnicycIPtcGp1neF43_EmS9v7ZpUdfkpZ4xpik80sS3Sw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeeitdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhff
    fugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufht
    vghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuie
    dujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
    dpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:TJsIaBk1WSpjqtToCuQ986WSKvEg7ChpePYv3ZxaP2U5o7_txMZdQg>
    <xmx:TJsIaP3V_wqshvPmaArUJ9XKfRWqs5jWUoJYdoLnKXZsmtHon0MUxg>
    <xmx:TJsIaAsHUrX_PLb9Nj13G1CmLfJ21u_o_PDQEN7dc1sDZ8c96uho0w>
    <xmx:TJsIaDVzAmE_s7_O59SGc5ej0wt1QwLPm2qDnr4ncdF2NIGD6ZqJfQ>
    <xmx:TJsIaBzOef9oMMJ-kr_6xzpAIYk8ypIXZO63Mf4lCXouTD9JyPbhHn85>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 23 Apr 2025 03:48:27 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 436c8816 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Wed, 23 Apr 2025 07:48:26 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 23 Apr 2025 09:48:14 +0200
Subject: [PATCH 04/13] object-store: move function declarations to their
 respective subsystems
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250423-pks-object-store-cleanups-v1-4-81f8411a5d08@pks.im>
References: <20250423-pks-object-store-cleanups-v1-0-81f8411a5d08@pks.im>
In-Reply-To: <20250423-pks-object-store-cleanups-v1-0-81f8411a5d08@pks.im>
To: git@vger.kernel.org
Cc: 
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

