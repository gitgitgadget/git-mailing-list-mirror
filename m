Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B893EFFB7
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 08:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780995077; cv=none; b=OS6OXqhfj9km8+8OGkXJGHKoL0lpDhmXLp2EBXVbEEHHNMfhFdURTtB6LNcAvOmf8+1b/piAIS9i35sq7Ukza4gXsuzooqnSP7ufI7dU6k0UnMfjPd74hr2l6lRC53mFk5nS4BZckGmbcV//nXKi7aZ7bmPdWl1s67et4AKvEWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780995077; c=relaxed/simple;
	bh=K5yaTHTc6VdC0ADdnJbpIg/xmKtwzub1oB8Y9hJ/Kpg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nlW2wsIyoAR+Ufk+4vIoMIl5Kr8hM4IMnxnvNO2lCH7mAFswDNvJNclL7SQI1uG0G0yA+wT7Fsxq+uoj1P8B7OQWriCx9zU97bO00yJsomJSp2kPddotkYt26TGwjgkq2tUxM2mFy6NW7n1ovYbpFbUH5EdJUY/2G5OzmcX4LqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iIAHd+Je; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZvAMpnZR; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iIAHd+Je";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZvAMpnZR"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B74607A01B7;
	Tue,  9 Jun 2026 04:51:15 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 09 Jun 2026 04:51:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780995075;
	 x=1781081475; bh=us/2DLgUeznCn08LOYha3ggS71Cfgq8TAvQeHXdEfIw=; b=
	iIAHd+JeFvtMzBnqcPzRIbNZ9VqX8GtVGBn24BFld5uDgzj4OKqE+FBc1NHqovjq
	vA+Wtlzs7QNMYSF9CMhiSTN1YykQ9w965oZAoQ4Dpi97q9r8KISC2iwA7yIyD8hQ
	yzw/4m+F3gak1e3adMd1V2CcN7VgOAbwdboJZ5NVw1rmrHrmivxvUvlMTTPKQEz8
	WVAxb+8vP00D06VMrzMEOJ2hogALdTR1O3VnZIo5r+ka3IUkUSF0SUOcSmDTpiHp
	/Nfas/Ia9adqewcoPS4amoQ7dWNUz19ETLXhBwVaC4WDWygsGNZg6INEAlkdJoJ6
	ATk7QGfvyYl1dNW3j/l3jg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780995075; x=
	1781081475; bh=us/2DLgUeznCn08LOYha3ggS71Cfgq8TAvQeHXdEfIw=; b=Z
	vAMpnZR8+rHgSnT0pPxOQVG0X73h13+8QdFIZLvkdk1bVL7pDxeUjo6yDQHSOYQA
	b6pBvlJBWZXgbr/yz2DUY1kHbJblcVKVv7C0RgYDaflhZPWJiAdrIIkFcf5YMBAD
	yRs3IOTPD5j813QEhEN8/UWhe5crFR7ntHz/v/rpCynVEPWUC5Xz/aMqTlVqt2be
	1jmGweEFO+w/4tXmtNfAvIOMsL02keiLQE3AcyMRv8Yy2SDFMus/dScgJbIeEsUw
	kSfjo9IiSwHhW1lCUQXWSyxQWi4YmkeogvJsAqgZxdZrjD9LrPsuwQu7k3fMVJKa
	qgn2ImeUIV9wKPHWhkE6g==
X-ME-Sender: <xms:A9QnaoX-yzaoIVEHEWRQndjOzdR8p60YQTDoytp5Dtgi5_DJ2uzDGA>
    <xme:A9Qnail8tmxPNFt6lfY66ell9HuitgnkIPnGy6rjFmVQGpYEuv6haOkYVdVmgnQ8v
    8EKOb3bAeUey3boHQg3D7UBF1f6Hs6CSHKqqNM8GjJqDdpYQc_How>
X-ME-Received: <xmr:A9QnaqCpVHVBKPL-9fxCGSicnmq9X3PrSC7fXb2yNE6VUqFULPjbPiSKx8Dvb5UQXAOu4k83zrpSie9xMtu140ip3MHmin19TR-s11tLvXE>
X-ME-Proxy-Cause: dmFkZTGj8XdmJ5+YFOKcKCr/PQjtoS31kmVFBcBBMXBn9g4dcT2itNqRFQ6tT26fp0L/ke
    L9jBWAKPmiaTtvSIqZvkXdlrjGPnZvkli/ene235VDRC/kBepsTNypTdxTRg3BOgMrsFsE
    SA2a/4pN2q/LfCqjRK0o3V8NU2YESK7s1bQGdvxXT3Lbw9/qDIa+X9cU8dYVFtyp2Zdm/m
    XLuCPCGsOmwQjLX7tELpb0BgcO3xN3L3fIClRiuTpZ+VuiaRApj/QQfCUe9C4LoCAMlta1
    6XWv5B1t/eLDY9+IJLZ9mddbnJZu+dqgh1ffXXwbYjC7tEFPumTSnfkClxYn/WcG0GknmS
    76SjP/FT2Eu9noRSUApfWm8li1AY+IwcYRLB5DyeL5kVjwWee29EeXZoLufJY85SGdDE2V
    dd9maXJtZMl0cdfKWHUC7kXJ5ldVKUhXDm6VcxcHO0wXqDJXcDCdi9mTWw6rNQci1pV8kv
    NoTQ0KJBi2SXeuINEvvVrzOEmlihXM3tpBslgJMDo0D78mJXSFfaCyWmAYdoJHwb8McsWX
    kzJFeRXHnQYbG4ZL7U7xExkI3nsQ+QEtv9OljUO/7zXgsOkCWOjjj+/koLSfMXHOpl3+vf
    haR6BXbXBFwgQAa2p6tPZf7a3McxQkg06/250aeIDG7jWDanff7xByz3tHSg
X-ME-Proxy: <xmx:A9QnaidCzEwiK82QvgLM3N761aAlMXkA3wbx9rGo0baFtbkCowI9jg>
    <xmx:A9QnalKyIe4MMg6uoDkFwLBR5iwo8WmPntaDtQu5NxeNQXxRQs25iQ>
    <xmx:A9QnaleEvsdn5aodbCihBile_vBemLb3VOFBqSHzFpzuWWRdRKQHFg>
    <xmx:A9Qnas01zYToYrK6glvs-xc96_3Pwrwi5OJsxAdR9BRlgTlauZ7AXA>
    <xmx:A9QnatGZyMSIOxrb2_tFACQxC9RYh731c7B4Hq1Fas8SXa4kRlaTtBv_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Jun 2026 04:51:14 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d2b09982 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 9 Jun 2026 08:51:14 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 09 Jun 2026 10:50:56 +0200
Subject: [PATCH v2 03/17] packfile: move packed source into "odb/"
 subsystem
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-pks-odb-source-packed-v2-3-839089132c8b@pks.im>
References: <20260609-pks-odb-source-packed-v2-0-839089132c8b@pks.im>
In-Reply-To: <20260609-pks-odb-source-packed-v2-0-839089132c8b@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
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
2.54.0.1136.gdb2ca164c4.dirty

