Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CAC326D65
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 08:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773304990; cv=none; b=IPY+TqYNf+w0oSfb0PXqZeucawLJ6yPV43yvAS/wxdUei4mLZoVmH9mzcLiPuaPmQdmFPdxr56NR0zGQESVFV7RvF9Yqvfa5db1nCtu7mvsuUiZv88/Qv0slREAebwkOVezqLjzeuENZPgxUAyfMBINbV/+O2AKuKbu28ODKRZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773304990; c=relaxed/simple;
	bh=OjQsIinfZq7+Nr0ouqotS06YQuPvuOuovYh63bQNkzU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gvt63gL/JwOPVLZaDXruUZyEdqnpHbIVSWZBluOK0Zrcapax6bdIwd45UmeniYM/3mzcTjtYXC+zlgnqF4wE6Bp0IKbzjn5XsVqeWFosXnFWIpy2kj6c+TCDVbmX/NoqE8nP8M7eNz1PDL1Cw2c9Jt1xNLbRGPL/q9Y5h5pBP3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZPscrJlL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KznoLOaw; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZPscrJlL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KznoLOaw"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 5A99CEC05B1;
	Thu, 12 Mar 2026 04:43:06 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 12 Mar 2026 04:43:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773304986;
	 x=1773391386; bh=YbXSJIyVQhJr1aS9ZJ/Hm3CIGH+CLneHwLvUhJtnKMc=; b=
	ZPscrJlLDbfY8FOCYcLLfvwaFGG4+OCzOfALtbUhxuvEHrzUlPQ68uiIf90gVp8F
	GzyqLcFsTzXDyK5o5E98kumKqyv8lz40MM8h2PTOFlwWO76eQ8iGJS9HlpPqyg95
	ubY62hLXXFEbKHnRekQ1sPjSL+6gSPiHzbG25V+vRk9SnPLvZ4B/rnF3Y6l1j84x
	3KY+ME02Tp31kdrQ8z+zZlOmoF0rzbZ5FdmhBJLZu/OK9vw32p0gl3SAF94HjHK0
	jKQBE0TJOIwLoNJ/b1LR+0OTTXRwamC3waX5Qldai5pW58zjm9PMdi8lCpdUcYsS
	/yfTooRHeAmSHJ+cfVsXUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773304986; x=
	1773391386; bh=YbXSJIyVQhJr1aS9ZJ/Hm3CIGH+CLneHwLvUhJtnKMc=; b=K
	znoLOaw7kG29cnJmvbZsODPLr8Qs5nWhHB2nR+6yT7aOu1+mbLgiCr75BMxpU/bm
	HYIUeGIgzYFYL+rFesYUsmiaDLZC+R+/Bd6QyfkSH5MTqgjF97Ytqg+HzGu4LHKx
	xtxuOO7+BLS03KZI7Ioh/9sD6/WMfL37QSC11kCU1UEHES/w6skyW/Ik1m7QzW+q
	EpEwclR6lkwNkl+Y75uQQJT1ZHRQ8AxgyuvhnNp2RNmUBLUDnE4Grn8jQks28rq9
	hNb97v0bTS/BWtmxIRohhlb96qe69QkEse+NwzwXMordmCisH1XMZOgwWgd7x+tY
	5EPLrMR2WiINjvZYOlzCA==
X-ME-Sender: <xms:mnyyafCO6bqFcDb-b6FFaxJm3xXWscO_zt-WAw8wPZnl7vUPUbSBXQ>
    <xme:mnyyacg8TLTfTB2Z8KPCVK0775mI69qQd5K7LTqyBqNZTsmHqnlArlPRjWZMOKaNM
    3FRUEoYaq0janPK_RoNsC-7fqPPOK9yXmq_3aDn3t-JLSCf6FDswQ>
X-ME-Received: <xmr:mnyyafmeWynLpoBMOVzPxnJjdXV6eDGI9Na1ZzJbzzQqd2P6ter4Hm2jf5Bl5li-HOX7d6q4vtU-QImvFXjWiy91Nm1D0REtHTQY7yyYUtLDEw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeeifeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepthhoohhnsehioh
    httghlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:mnyyaQp0gkFhSDypZiJ3KCSzAvMlDPwyTHRdg21NsAHgUsLnVdT7YA>
    <xmx:mnyyaQGaRWtEy3HTlm_iV783FfKva_-Ed9lnTOHp1FZVPLm7H1nzog>
    <xmx:mnyyaUzGgVp1lKiuuAXFta3v7uG1PiHK--FdhtPJb34LTgM5JpyurQ>
    <xmx:mnyyadrJZF8arYIs4GVg4-le-mgjyo8DPD8-mdNxX3SgqXNw0Z5V_A>
    <xmx:mnyyaamxsHJqvmU4PlgQaJMVXrKFb5QQDWV__NQKIv3bhua7clL2LSnf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 04:43:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 70bbf6a9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 12 Mar 2026 08:43:04 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 12 Mar 2026 09:42:56 +0100
Subject: [PATCH v2 1/6] odb: stop including "odb/source.h"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260312-b4-pks-odb-source-count-objects-v2-1-5914f69256bf@pks.im>
References: <20260312-b4-pks-odb-source-count-objects-v2-0-5914f69256bf@pks.im>
In-Reply-To: <20260312-b4-pks-odb-source-count-objects-v2-0-5914f69256bf@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Junio C Hamano <gitster@pobox.com>, 
 Justin Tobler <jltobler@gmail.com>
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

