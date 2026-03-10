Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E212E9749
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 15:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773155911; cv=none; b=aKMf9kAMvRbk3UjACvETFRQbA+2bna0L5XLayKyWuwL3BANNDLwnBEWrsKaeoOGalaNBJqfDsNYiesm37pjqdj5v19OJe6iKMbrYTSOJW7gq6Cu+PEbwdRAGSvjlQ72TOTYB8n8ekJDCgn4uKE0sfgN5JX2yMMK0gtJfOY63fas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773155911; c=relaxed/simple;
	bh=OjQsIinfZq7+Nr0ouqotS06YQuPvuOuovYh63bQNkzU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qocYQlWS0cHoWDzZEZcBhin82FxSH9AYgSG2tOFm/jOWlASsvo6B41leyxiHJFHYr/usGCPSPVMElwhIbLvkQ8a0vExMcHvKnKjb0g7RHHld+S4PlltQv/Y3Z3isvMYnGvnBONGAKacPfcoiwQBIGUkVImdqnIEcusaudoGeAUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gnCks66F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A84a2fWl; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gnCks66F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A84a2fWl"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 9C3BFEC0ADD;
	Tue, 10 Mar 2026 11:18:29 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 10 Mar 2026 11:18:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773155909;
	 x=1773242309; bh=YbXSJIyVQhJr1aS9ZJ/Hm3CIGH+CLneHwLvUhJtnKMc=; b=
	gnCks66FtlKhJf0DivMFEWqCtwnFuMWN3d8oajaD0zrKyzehO2Mt3M/O4oYGKpeD
	KyuOFybOxxRvJ9rIL55QHigZAMORwMj2r73LIJUF01tYBBJ6sweH9mSeD4Ms1Z8i
	HoxbNou4a8DNC6nzKLOkV3FoyMRMKuM+Y6bIrQmiSbQJdAEKfeMzgkt6V/rGt7Zk
	WX9Q7T2lUdmJ8O0blyXVvPhCfbD6nNyoUw/rqM/tqEiacJEC0aNq7KA6IVDvE0ja
	k5HNXwA3OAaNsKEyHVcaoeYNlQD88RmE8/vdyJ5K+UgWsFDHavqn8G6B812XvV2o
	T3T7SNkcmYGUPl7FiSJaUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773155909; x=
	1773242309; bh=YbXSJIyVQhJr1aS9ZJ/Hm3CIGH+CLneHwLvUhJtnKMc=; b=A
	84a2fWlFVCaCr1/u1K8XTePs1XDCUq5YGW2fZ/kmhjGj1HDVw5+Tn53wN9atQ/td
	vd3ZOfpBODQb96SYN4y1+ajU3iXLwzBQ8LN17Mwy8Me17jYNp/7zgqfBgQ3jHZTJ
	RNb9mvIdwOGX8MdgxL37qGV9KfUnGaTG0bVNpfuPR6q+MO82kr5q1SO8IcaJK+hS
	HIYVcjq7crsA8F0g0nUlG2QKHPESoEwErYtubIM996rh/IHMkiKMTf7fo8o430I1
	MMJDqn91/hpQe8aUWeGKqUNOyG3I968aDPkpxBY5ChtfVnbQvpkFwq84vSGJYbX/
	ow4igtQ2GRAYaEym7NkhA==
X-ME-Sender: <xms:RTawaS_IPYNQ1myaRnZ0LauWZnE137T2cb4bHD11tvzpvjcmwo7b0w>
    <xme:RTawaYsVEIllttan2_Vrl-kXU4GOsvKvSGeiNP413nwp15ptzPFBWF-VdmR0x2BXK
    pJIl96k5g1qtG2aXT44cp3D79Po4VNsl2oqfrPQElfCO4vVHdgOLg>
X-ME-Received: <xmr:RTawaVoEoWlIN7uhObtSQbfG87PNy40CeY-OIIcgBwapYRgpdHJ8Uad7clbE7a9FbBTVckTwZD4bm0JzEIyZfn8JHutM9JZIeU_n6ZL9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkedufeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlthhosg
    hlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:RTawaVn_SdpfbJOBwHIS_7sJU0Nh0D85_MIQn1uAmnG6GlLJgaRY3w>
    <xmx:RTawaZwsvuqXBemReObB3QcVm2SJw0yajpHA_xqUo86bn9Eg5A5RmQ>
    <xmx:RTawadkRddQHdxKVzGrLmEPvKMzDfTzQOv4ZicvgOIrn49ULdrR9tw>
    <xmx:RTawaSdCgiG0JH8UCCQV7sXD0kcEjVXLlAs-3rYVEv6JiIoiumWddA>
    <xmx:RTawaRtu-ZehD2vKWTDBJnIyQODXqIPDjIbALn_0zqmDvFUR7lUPi1Wh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Mar 2026 11:18:28 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5a49b11c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 10 Mar 2026 15:18:27 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 10 Mar 2026 16:18:21 +0100
Subject: [PATCH 1/6] odb: stop including "odb/source.h"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-b4-pks-odb-source-count-objects-v1-1-109e07d425f4@pks.im>
References: <20260310-b4-pks-odb-source-count-objects-v1-0-109e07d425f4@pks.im>
In-Reply-To: <20260310-b4-pks-odb-source-count-objects-v1-0-109e07d425f4@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.3

The "odb.h" header currently includes the "odb/source.h" file. This is
somewhat roundabout though: most callers shouldn't have to care about
the `struct odb_source`, but should rather use the ODB-level functions.
Furthermore, it means that a couple of definitions have to live on the
source level even though they should be part of the generic interface.

Reverse the relation between "odb/source.h" and "odb.h" and move the
enums and typedefs that relate to the generic interfaces back into
"odb.h". Add the necessary includes to all files that rely on the
transitive include.

Suggested-by: Justin Tobler <jltobler@gmail.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/multi-pack-index.c  |  1 +
 builtin/submodule--helper.c |  1 +
 odb.h                       | 50 ++++++++++++++++++++++++++++++++++++++++++-
 odb/source.h                | 52 +--------------------------------------------
 odb/streaming.c             |  1 +
 repository.c                |  1 +
 submodule-config.c          |  1 +
 tmp-objdir.c                |  1 +
 8 files changed, 56 insertions(+), 52 deletions(-)

diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 5f364aa816..3fcb207f1a 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -9,6 +9,7 @@
 #include "strbuf.h"
 #include "trace2.h"
 #include "odb.h"
+#include "odb/source.h"
 #include "replace-object.h"
 #include "repository.h"
 
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 143f7cb3cc..4957487536 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -29,6 +29,7 @@
 #include "object-file.h"
 #include "object-name.h"
 #include "odb.h"
+#include "odb/source.h"
 #include "advice.h"
 #include "branch.h"
 #include "list-objects-filter-options.h"
diff --git a/odb.h b/odb.h
index 86e0365c24..7a583e3873 100644
--- a/odb.h
+++ b/odb.h
@@ -3,7 +3,6 @@
 
 #include "hashmap.h"
 #include "object.h"
-#include "odb/source.h"
 #include "oidset.h"
 #include "oidmap.h"
 #include "string-list.h"
@@ -12,6 +11,7 @@
 struct oidmap;
 struct oidtree;
 struct strbuf;
+struct strvec;
 struct repository;
 struct multi_pack_index;
 
@@ -339,6 +339,42 @@ struct object_info {
  */
 #define OBJECT_INFO_INIT { 0 }
 
+/* Flags that can be passed to `odb_read_object_info_extended()`. */
+enum object_info_flags {
+	/* Invoke lookup_replace_object() on the given hash. */
+	OBJECT_INFO_LOOKUP_REPLACE = (1 << 0),
+
+	/* Do not reprepare object sources when the first lookup has failed. */
+	OBJECT_INFO_QUICK = (1 << 1),
+
+	/*
+	 * Do not attempt to fetch the object if missing (even if fetch_is_missing is
+	 * nonzero).
+	 */
+	OBJECT_INFO_SKIP_FETCH_OBJECT = (1 << 2),
+
+	/* Die if object corruption (not just an object being missing) was detected. */
+	OBJECT_INFO_DIE_IF_CORRUPT = (1 << 3),
+
+	/*
+	 * We have already tried reading the object, but it couldn't be found
+	 * via any of the attached sources, and are now doing a second read.
+	 * This second read asks the individual sources to also evaluate
+	 * whether any on-disk state may have changed that may have caused the
+	 * object to appear.
+	 *
+	 * This flag is for internal use, only. The second read only occurs
+	 * when `OBJECT_INFO_QUICK` was not passed.
+	 */
+	OBJECT_INFO_SECOND_READ = (1 << 4),
+
+	/*
+	 * This is meant for bulk prefetching of missing blobs in a partial
+	 * clone. Implies OBJECT_INFO_SKIP_FETCH_OBJECT and OBJECT_INFO_QUICK.
+	 */
+	OBJECT_INFO_FOR_PREFETCH = (OBJECT_INFO_SKIP_FETCH_OBJECT | OBJECT_INFO_QUICK),
+};
+
 /*
  * Read object info from the object database and populate the `object_info`
  * structure. Returns 0 on success, a negative error code otherwise.
@@ -432,6 +468,18 @@ enum odb_for_each_object_flags {
 	ODB_FOR_EACH_OBJECT_SKIP_ON_DISK_KEPT_PACKS = (1<<4),
 };
 
+/*
+ * A callback function that can be used to iterate through objects. If given,
+ * the optional `oi` parameter will be populated the same as if you would call
+ * `odb_read_object_info()`.
+ *
+ * Returning a non-zero error code will cause iteration to abort. The error
+ * code will be propagated.
+ */
+typedef int (*odb_for_each_object_cb)(const struct object_id *oid,
+				      struct object_info *oi,
+				      void *cb_data);
+
 /*
  * Iterate through all objects contained in the object database. Note that
  * objects may be iterated over multiple times in case they are either stored
diff --git a/odb/source.h b/odb/source.h
index caac558149..a1fd9dd920 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -2,6 +2,7 @@
 #define ODB_SOURCE_H
 
 #include "object.h"
+#include "odb.h"
 
 enum odb_source_type {
 	/*
@@ -14,61 +15,10 @@ enum odb_source_type {
 	ODB_SOURCE_FILES,
 };
 
-/* Flags that can be passed to `odb_read_object_info_extended()`. */
-enum object_info_flags {
-	/* Invoke lookup_replace_object() on the given hash. */
-	OBJECT_INFO_LOOKUP_REPLACE = (1 << 0),
-
-	/* Do not reprepare object sources when the first lookup has failed. */
-	OBJECT_INFO_QUICK = (1 << 1),
-
-	/*
-	 * Do not attempt to fetch the object if missing (even if fetch_is_missing is
-	 * nonzero).
-	 */
-	OBJECT_INFO_SKIP_FETCH_OBJECT = (1 << 2),
-
-	/* Die if object corruption (not just an object being missing) was detected. */
-	OBJECT_INFO_DIE_IF_CORRUPT = (1 << 3),
-
-	/*
-	 * We have already tried reading the object, but it couldn't be found
-	 * via any of the attached sources, and are now doing a second read.
-	 * This second read asks the individual sources to also evaluate
-	 * whether any on-disk state may have changed that may have caused the
-	 * object to appear.
-	 *
-	 * This flag is for internal use, only. The second read only occurs
-	 * when `OBJECT_INFO_QUICK` was not passed.
-	 */
-	OBJECT_INFO_SECOND_READ = (1 << 4),
-
-	/*
-	 * This is meant for bulk prefetching of missing blobs in a partial
-	 * clone. Implies OBJECT_INFO_SKIP_FETCH_OBJECT and OBJECT_INFO_QUICK.
-	 */
-	OBJECT_INFO_FOR_PREFETCH = (OBJECT_INFO_SKIP_FETCH_OBJECT | OBJECT_INFO_QUICK),
-};
-
 struct object_id;
-struct object_info;
 struct odb_read_stream;
-struct odb_transaction;
-struct odb_write_stream;
 struct strvec;
 
-/*
- * A callback function that can be used to iterate through objects. If given,
- * the optional `oi` parameter will be populated the same as if you would call
- * `odb_read_object_info()`.
- *
- * Returning a non-zero error code will cause iteration to abort. The error
- * code will be propagated.
- */
-typedef int (*odb_for_each_object_cb)(const struct object_id *oid,
-				      struct object_info *oi,
-				      void *cb_data);
-
 /*
  * The source is the part of the object database that stores the actual
  * objects. It thus encapsulates the logic to read and write the specific
diff --git a/odb/streaming.c b/odb/streaming.c
index a4355cd245..5927a12954 100644
--- a/odb/streaming.c
+++ b/odb/streaming.c
@@ -7,6 +7,7 @@
 #include "environment.h"
 #include "repository.h"
 #include "odb.h"
+#include "odb/source.h"
 #include "odb/streaming.h"
 #include "replace-object.h"
 
diff --git a/repository.c b/repository.c
index e7fa42c14f..05c26bdbc3 100644
--- a/repository.c
+++ b/repository.c
@@ -2,6 +2,7 @@
 #include "abspath.h"
 #include "repository.h"
 #include "odb.h"
+#include "odb/source.h"
 #include "config.h"
 #include "object.h"
 #include "lockfile.h"
diff --git a/submodule-config.c b/submodule-config.c
index 1f19fe2077..72a46b7a54 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -14,6 +14,7 @@
 #include "strbuf.h"
 #include "object-name.h"
 #include "odb.h"
+#include "odb/source.h"
 #include "parse-options.h"
 #include "thread-utils.h"
 #include "tree-walk.h"
diff --git a/tmp-objdir.c b/tmp-objdir.c
index e436eed07e..d199d39e7c 100644
--- a/tmp-objdir.c
+++ b/tmp-objdir.c
@@ -11,6 +11,7 @@
 #include "strvec.h"
 #include "quote.h"
 #include "odb.h"
+#include "odb/source.h"
 #include "repository.h"
 
 struct tmp_objdir {

-- 
2.53.0.880.g73c4285caa.dirty

