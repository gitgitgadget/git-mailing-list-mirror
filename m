Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF8E413D96
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 11:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780572347; cv=none; b=G0s1RWgyHjr0vPDQ62Nrf4JR4iRFyWssd1L3lUO/izr4v+efE3iktx8Ibke/GrVaBtaVeSHvcmPLXXh2n6vHuKl3JHtf7M7a5t/cuyY+VUJnAn1dhzRQgo1hASNQ0DdRLwlpr/Iik/xAZANXat+df/wM+EVB3L4X4owi+rhc8A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780572347; c=relaxed/simple;
	bh=5iYkzR6EQrxltxGBB9TGjJ6fidJkoglgRXdorMn75x4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dOM+00vWV6JNdDJHKJFTNAd0h+vmBGB9m3ND/H0/cWXSwYC3YSApCHHaSOjrhW2lOk6IOXWtNAHRK8cNAadXzBfzb8Dfo5SSs2v97rW5aCunjKiy6zRmBzKOHnYMbf6amHQFzdIpv2J88RwLhAVBJueAJNj6cuzakuRpV84kmog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oGwEjcXu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OAmu75wf; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oGwEjcXu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OAmu75wf"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 62649EC00DB
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 07:25:45 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 04 Jun 2026 07:25:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780572345;
	 x=1780658745; bh=rVJCZmaIqVlG7yB4XwN5sg4oyNnetAqGZkBnfrmvZBQ=; b=
	oGwEjcXuPtW6bUDnmiM80WNah5GWwUarHfCmeCtwtK+1LfEZY427McL6l+smNGTR
	jste0G5vaNCJCd8uSqcETMm8aMwXNlnCCORxx3bqqZgl/S4o747g5lanzmKUJr7i
	uKpeB02HC8qWbFYg+aWsAMt9Sbf/+jSOZHSRO7GQ/338faAj+3QaiB6UAKDa+vk2
	gJW01xR7e4s5+bUb3Uuu8Y2hbqTGGp5bqxpBAjiVAknzTo7x06/YjjfJcFvp9K2C
	USqO3CM3UQUfIDXo8h5e5u/Tg3reVqGiY642+5/HvnHEJeiYjN49ewXZqQHQIEEk
	goDHIu6eZaLRz3/JYUeocA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780572345; x=
	1780658745; bh=rVJCZmaIqVlG7yB4XwN5sg4oyNnetAqGZkBnfrmvZBQ=; b=O
	Amu75wfrAV2cdz5MlzazEfDbZPieXADbeNCB3QzO0W+xObsmjyEwMEtYDSHSYkrt
	mcLWtamOFbkwOwN0Zg1jk71UzcQ02mEF+YCMxIUqFwgPBnoaCNfgBsiWZnkyoJfy
	sasZI1WN8Py8EswGNj4YHPdOr6mWSo7/yD0CASPkO44Ncv2L8BpaDTR+y2P6fUj8
	H0YV6SNqlNC+pKMRUsf0oIK6jfMYj1sN9YXPdMaMjS9vLV+e90L4MYqARoZ8M3dZ
	ne4/QTlmWtc+fff6Rq6mlbbHbbY9Qto2p765uJQpKetVP1Be/ICxnHdOJfV564ml
	ibUPwFFQRv9Uh+PoP/QZA==
X-ME-Sender: <xms:uWAhaiPeGBPBRWKe-f5OaB2cI6TxWwOFqtv0BL1_lRDh0Yy2pQFQBw>
    <xme:uWAhan4bDkLN7U0MrGFHwocmGyJaEmzemn75Ji6waG-N0yYVIF-cM3udJRdqAxcEO
    HLcF8QqIzIDH-HLUiZZ5pTj-nqD81C5sf937dEeAm5evmyw59TShKU>
X-ME-Received: <xmr:uWAhau5T_-RLvr2OHCUedSbcZSKCa5kzE4CAMFuRVzBgUuWKFI0EK0g6rSoRQ7eyJR1VySFnpmQVpwQd_w-5bqP7MrUYba2XAWYLIEurqd8>
X-ME-Proxy-Cause: dmFkZTG1ZbTSTCt+QGOBx/ozxIEQhARBqr0/SlqS3JC3+zb5glHSVG1aoMYIj9aqeIu0zy
    sFSu/10DzZ9FxuAnUcFX6wAMbP9bcQrm5ozYikXKxnDFDplVWXkO3AcE+a89ybngC3lrIz
    /GVY5rm27PVrHphkJl/OHdHOPrCII5MKB9fWDnt3CbmEK2TBDSFR2xtzwFeqzHWM4uomo5
    7XY5VmmSTadEWmtllR1d1OawV3IdNUcjNTdgTRjA6Zegw5qOpq6fI/Dca+wbibUmVoNStb
    renMzkGmdPq7kqvux3p6g6SuTVtljNZSpQco4BML6yeKWNkQha+6iZyZlP37J3M3wliomO
    8ZmU9rYD4FuJBbbutOdsdqhvsP42sKpxMluiLutNMW76nrvO8hQxmci4uAkqwwU4l/cXzl
    44Y/j+O11hiBwkozidJb7RCcZn6n954q7HZI30Q8OW7onJnGB3fDZ0nENVWrL9nCEq9ByR
    7zlMZlDP2peP5GhwGAWo63JsxCK3PE+wODidICvU2ujRQa8I138chjAC/HlBkwRfqI10lI
    DN4McaBNbobAND4fO97J8v0ZAuwdnBxvWpFa/w7oGZcpfbz+9vAUd69//2eNP/oc0PTxLN
    +GOE1iNhsjFwRjxEbM12LcKNILSIPqDVk90WcPplaMAGm2XhvxTh4w5m8bVg
X-ME-Proxy: <xmx:uWAhan0R_BHflW7M1hNZhF-lvHJz2XtVjm7e07zFgcFY--I8MD6oRw>
    <xmx:uWAhaqW1akaBhWdtgTidVFkkAsAED2MRYq0mwyHkc0ZS5jBDiTAJQg>
    <xmx:uWAhai6CaCbhWyga-URPbYY2gD5TjXYX7tczDP9R84R570IcWcCJTg>
    <xmx:uWAhahLL2zRPw5nwiSj1Dcoy9-_uU9EVpGBvByjWVX1cSKLJ1aKJ-w>
    <xmx:uWAhai-6u7e4KydoC6N_NO7PvvMCzxpokcAZyeeQ32ZyU4pCaSRy-PSe>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 4 Jun 2026 07:25:44 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d5ae73af (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 4 Jun 2026 11:25:44 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 04 Jun 2026 13:25:29 +0200
Subject: [PATCH 02/16] packfile: move packed source into "odb/" subsystem
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-pks-odb-source-packed-v1-2-2e7ab31b4b5c@pks.im>
References: <20260604-pks-odb-source-packed-v1-0-2e7ab31b4b5c@pks.im>
In-Reply-To: <20260604-pks-odb-source-packed-v1-0-2e7ab31b4b5c@pks.im>
To: git@vger.kernel.org
Cc: 
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
 odb/source-packed.h | 80 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 packfile.c          |  9 ------
 packfile.h          | 75 +------------------------------------------------
 7 files changed, 95 insertions(+), 84 deletions(-)

diff --git a/Makefile b/Makefile
index 0976a69b4c..e3381b8857 100644
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
index 3247697f74..1976024008 100644
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
index 0000000000..c17068a4f1
--- /dev/null
+++ b/odb/source-packed.h
@@ -0,0 +1,80 @@
+#ifndef ODB_SOURCE_PACKED_H
+#define ODB_SOURCE_PACKED_H
+
+#include "odb/source.h"
+#include "strmap.h"
+
+struct packfile_list {
+	struct packfile_list_entry *head, *tail;
+};
+
+struct packfile_list_entry {
+	struct packfile_list_entry *next;
+	struct packed_git *pack;
+};
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
index a2d768d0ae..f2b27df66e 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2832,15 +2832,6 @@ int parse_pack_header_option(const char *in, unsigned char *out, unsigned int *l
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
index 9cec15bc50..6f76df3589 100644
--- a/packfile.h
+++ b/packfile.h
@@ -5,9 +5,9 @@
 #include "object.h"
 #include "odb.h"
 #include "odb/source-files.h"
+#include "odb/source-packed.h"
 #include "oidset.h"
 #include "repository.h"
-#include "strmap.h"
 
 /* in odb.h */
 struct object_info;
@@ -54,15 +54,6 @@ struct packed_git {
 	char pack_name[FLEX_ARRAY]; /* more */
 };
 
-struct packfile_list {
-	struct packfile_list_entry *head, *tail;
-};
-
-struct packfile_list_entry {
-	struct packfile_list_entry *next;
-	struct packed_git *pack;
-};
-
 void packfile_list_clear(struct packfile_list *list);
 void packfile_list_remove(struct packfile_list *list, struct packed_git *pack);
 void packfile_list_prepend(struct packfile_list *list, struct packed_git *pack);
@@ -76,70 +67,6 @@ void packfile_list_append(struct packfile_list *list, struct packed_git *pack);
 struct packed_git *packfile_list_find_oid(struct packfile_list_entry *packs,
 					  const struct object_id *oid);
 
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
2.54.0.1064.gd145956f57.dirty

