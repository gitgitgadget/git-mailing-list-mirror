Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D374246BD5
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 14:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772720393; cv=none; b=lB0rAUTr6B8KonGPfzaKhDXjLL5KdvcmbaonnzeLk0EiE7KSlBocdsbpyf+vNz1gW4Jf74y3znBRQ/WednrXrTJGKwr9swpjOia5+LzRfxFoZrftalDiPMBRAnm4IRdKMAYqpLGbNrW+dxb1O7gQEOEiu+klZOIx8ASTft0L02Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772720393; c=relaxed/simple;
	bh=mb6lBkrh5FcciXv580oy0uacW64xhwXbK8It/tzrin4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c3CdFflOGC/2S2IHmCJYz68hjNzBDnZSp5uxOdB+jioux+mbTix1GG4tjhe4fAK8ZTAflQtUWE03eYmePf6KK5Afprgw/orjjQgThu8eCHXZEbgBvtgLKts7lMDO4anuYdNAQgCGsmSdnvCXv4edY4x6dkF86gShKvjdC4Ghun8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DZ38ePri; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gbpiLKgA; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DZ38ePri";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gbpiLKgA"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id D8B111D0012B;
	Thu,  5 Mar 2026 09:19:50 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 05 Mar 2026 09:19:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1772720390;
	 x=1772806790; bh=w0g3nyyzwrLuhlbL4p1JVdt/xd2hrOTfu8Uq54c8XCo=; b=
	DZ38ePriXuJdAocPCEoMw+f4OEk+VdoM1q7r8PGsVPJViPG/0blNB7TW0fgkTLy0
	TRYrFWfRFZwK/jt6PVQ7kbsLh8D/Wxv+xtEm2oUSPoy9e5B4WEZkzIpAjQ0MM7zp
	Z4/ud8ctbTIXkX+dSHzl1IAXll6pUYlhE6uYFUKjY/fzKgBiWAut9gADr5YJvg1/
	LCWVGovp6adkUw1EHL0og4n/FR7PEL11zLsipnN3UbNo2q8/fJa0lj0nCHRsfYgr
	/xzCnCffzcKPy8MU6Ba+M+WKZzuYa+zjTJcgthgYa63Yuon7rFU6xpapjH9h7QwF
	vyKsn8ouHGD0s281wvfV2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772720390; x=
	1772806790; bh=w0g3nyyzwrLuhlbL4p1JVdt/xd2hrOTfu8Uq54c8XCo=; b=g
	bpiLKgAVWYV+i2mw/4xRGkyG60mcuqmc3zh+w3t9EtBrr6OmY3l8+Nn3gjxay1MK
	jYcYzjnuncmbz1T0+xqsmaFcq32IFr9yZ84FLTH/e9oehICtKPk34O66S4Y5YzIj
	4P7GvI/1xb+aBl18pTAaF/a3v+sFsis0y5ba+kRJ7ccQYAJwF0i8xNNYwmrsK6ve
	Pb2TSCwPvHWd3Z8m5ep31G2G3YSW12HWT8A8HMQuuuPkVVvlPm5iFEDsh+zCG90Z
	33J4qhabsnCsouDYnUsoNII2El/P++chu1cFC9a05+Q0Pd3N4Dd/TGJzImWGA2GD
	yxxcpa/8J6j+zj6xyw94A==
X-ME-Sender: <xms:BpGpabyYJvPV3dy5EbDSeMF0KcwjZRE1lBzVDQC-0cxqNlU3g6IXEw>
    <xme:BpGpaaSwJm3PaUZEgfzcg-KKyitjSsPBO5mwIUaQSa_4tJW39b_LCTQQrFwZyb7HF
    k6-EZ6T9PBjuBJk_5EWk-DxTYGJALG_YcnwTEso0GJNgvzhpyI>
X-ME-Received: <xmr:BpGpaaWbRrkKJ-mypKC_LFZdRQ4DJXkV2C9PM3kO66aMS-3o9cQIEmUkEOQbaYrtU8UM33TQrJkJELbMWG-gwqC75IkZETTVNG4JYn8B9xZ2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieeiiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhlth
    hosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:BpGpaUaRIr6KDwVtIbv9HLktofIikz71Dpbb12hsHJU2-uBRRKbdtQ>
    <xmx:BpGpaY30BVFqEjFl0eWMTKAPk8vTp9PNAJwop1NUalBWUgMqMJNh_Q>
    <xmx:BpGpaegb0t8DNtu209899fI7akghQvIvsZHEORE9DofBROC-lgzOlA>
    <xmx:BpGpaUZlU4P9Y9wQ301zUTwshNB1CXwLBWDT4EN0JL09IlewFCAgEw>
    <xmx:BpGpaZDS0xVu524ARo1nZg3Chnt5nFLlFGT9EphekAsbTQRUETD4hi5b>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Mar 2026 09:19:49 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4ea7425b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Mar 2026 14:19:48 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 05 Mar 2026 15:19:41 +0100
Subject: [PATCH v2 01/17] odb: split `struct odb_source` into separate
 header
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260305-b4-pks-odb-source-pluggable-v2-1-3290bfd1f444@pks.im>
References: <20260305-b4-pks-odb-source-pluggable-v2-0-3290bfd1f444@pks.im>
In-Reply-To: <20260305-b4-pks-odb-source-pluggable-v2-0-3290bfd1f444@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

Subsequent commits will expand the `struct odb_source` to become a
generic interface for accessing an object database source. As part of
these refactorings we'll add a set of function pointers that will
significantly expand the structure overall.

Prepare for this by splitting out the `struct odb_source` into a
separate header. This keeps the high-level object database interface
detached from the low-level object database sources.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile     |  1 +
 meson.build  |  1 +
 odb.c        | 25 -------------------------
 odb.h        | 45 +--------------------------------------------
 odb/source.c | 28 ++++++++++++++++++++++++++++
 odb/source.h | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 91 insertions(+), 69 deletions(-)

diff --git a/Makefile b/Makefile
index 47ed9fa7fd..116358e484 100644
--- a/Makefile
+++ b/Makefile
@@ -1214,6 +1214,7 @@ LIB_OBJS += object-file.o
 LIB_OBJS += object-name.o
 LIB_OBJS += object.o
 LIB_OBJS += odb.o
+LIB_OBJS += odb/source.o
 LIB_OBJS += odb/streaming.o
 LIB_OBJS += oid-array.o
 LIB_OBJS += oidmap.o
diff --git a/meson.build b/meson.build
index 3a1d12caa4..1018af17c3 100644
--- a/meson.build
+++ b/meson.build
@@ -397,6 +397,7 @@ libgit_sources = [
   'object-name.c',
   'object.c',
   'odb.c',
+  'odb/source.c',
   'odb/streaming.c',
   'oid-array.c',
   'oidmap.c',
diff --git a/odb.c b/odb.c
index 776de5356c..d318482d47 100644
--- a/odb.c
+++ b/odb.c
@@ -217,23 +217,6 @@ static void odb_source_read_alternates(struct odb_source *source,
 	free(path);
 }
 
-
-static struct odb_source *odb_source_new(struct object_database *odb,
-					 const char *path,
-					 bool local)
-{
-	struct odb_source *source;
-
-	CALLOC_ARRAY(source, 1);
-	source->odb = odb;
-	source->local = local;
-	source->path = xstrdup(path);
-	source->loose = odb_source_loose_new(source);
-	source->packfiles = packfile_store_new(source);
-
-	return source;
-}
-
 static struct odb_source *odb_add_alternate_recursively(struct object_database *odb,
 							const char *source,
 							int depth)
@@ -373,14 +356,6 @@ struct odb_source *odb_set_temporary_primary_source(struct object_database *odb,
 	return source->next;
 }
 
-static void odb_source_free(struct odb_source *source)
-{
-	free(source->path);
-	odb_source_loose_free(source->loose);
-	packfile_store_free(source->packfiles);
-	free(source);
-}
-
 void odb_restore_primary_source(struct object_database *odb,
 				struct odb_source *restore_source,
 				const char *old_path)
diff --git a/odb.h b/odb.h
index 68b8ec2289..e13b5b7c44 100644
--- a/odb.h
+++ b/odb.h
@@ -3,6 +3,7 @@
 
 #include "hashmap.h"
 #include "object.h"
+#include "odb/source.h"
 #include "oidset.h"
 #include "oidmap.h"
 #include "string-list.h"
@@ -30,50 +31,6 @@ extern int fetch_if_missing;
  */
 char *compute_alternate_path(const char *path, struct strbuf *err);
 
-/*
- * The source is the part of the object database that stores the actual
- * objects. It thus encapsulates the logic to read and write the specific
- * on-disk format. An object database can have multiple sources:
- *
- *   - The primary source, which is typically located in "$GIT_DIR/objects".
- *     This is where new objects are usually written to.
- *
- *   - Alternate sources, which are configured via "objects/info/alternates" or
- *     via the GIT_ALTERNATE_OBJECT_DIRECTORIES environment variable. These
- *     alternate sources are only used to read objects.
- */
-struct odb_source {
-	struct odb_source *next;
-
-	/* Object database that owns this object source. */
-	struct object_database *odb;
-
-	/* Private state for loose objects. */
-	struct odb_source_loose *loose;
-
-	/* Should only be accessed directly by packfile.c and midx.c. */
-	struct packfile_store *packfiles;
-
-	/*
-	 * Figure out whether this is the local source of the owning
-	 * repository, which would typically be its ".git/objects" directory.
-	 * This local object directory is usually where objects would be
-	 * written to.
-	 */
-	bool local;
-
-	/*
-	 * This object store is ephemeral, so there is no need to fsync.
-	 */
-	int will_destroy;
-
-	/*
-	 * Path to the source. If this is a relative path, it is relative to
-	 * the current working directory.
-	 */
-	char *path;
-};
-
 struct packed_git;
 struct packfile_store;
 struct cached_object_entry;
diff --git a/odb/source.c b/odb/source.c
new file mode 100644
index 0000000000..7fc89806f9
--- /dev/null
+++ b/odb/source.c
@@ -0,0 +1,28 @@
+#include "git-compat-util.h"
+#include "object-file.h"
+#include "odb/source.h"
+#include "packfile.h"
+
+struct odb_source *odb_source_new(struct object_database *odb,
+				  const char *path,
+				  bool local)
+{
+	struct odb_source *source;
+
+	CALLOC_ARRAY(source, 1);
+	source->odb = odb;
+	source->local = local;
+	source->path = xstrdup(path);
+	source->loose = odb_source_loose_new(source);
+	source->packfiles = packfile_store_new(source);
+
+	return source;
+}
+
+void odb_source_free(struct odb_source *source)
+{
+	free(source->path);
+	odb_source_loose_free(source->loose);
+	packfile_store_free(source->packfiles);
+	free(source);
+}
diff --git a/odb/source.h b/odb/source.h
new file mode 100644
index 0000000000..391d6d1e38
--- /dev/null
+++ b/odb/source.h
@@ -0,0 +1,60 @@
+#ifndef ODB_SOURCE_H
+#define ODB_SOURCE_H
+
+/*
+ * The source is the part of the object database that stores the actual
+ * objects. It thus encapsulates the logic to read and write the specific
+ * on-disk format. An object database can have multiple sources:
+ *
+ *   - The primary source, which is typically located in "$GIT_DIR/objects".
+ *     This is where new objects are usually written to.
+ *
+ *   - Alternate sources, which are configured via "objects/info/alternates" or
+ *     via the GIT_ALTERNATE_OBJECT_DIRECTORIES environment variable. These
+ *     alternate sources are only used to read objects.
+ */
+struct odb_source {
+	struct odb_source *next;
+
+	/* Object database that owns this object source. */
+	struct object_database *odb;
+
+	/* Private state for loose objects. */
+	struct odb_source_loose *loose;
+
+	/* Should only be accessed directly by packfile.c and midx.c. */
+	struct packfile_store *packfiles;
+
+	/*
+	 * Figure out whether this is the local source of the owning
+	 * repository, which would typically be its ".git/objects" directory.
+	 * This local object directory is usually where objects would be
+	 * written to.
+	 */
+	bool local;
+
+	/*
+	 * This object store is ephemeral, so there is no need to fsync.
+	 */
+	int will_destroy;
+
+	/*
+	 * Path to the source. If this is a relative path, it is relative to
+	 * the current working directory.
+	 */
+	char *path;
+};
+
+/*
+ * Allocate and initialize a new source for the given object database located
+ * at `path`. `local` indicates whether or not the source is the local and thus
+ * primary object source of the object database.
+ */
+struct odb_source *odb_source_new(struct object_database *odb,
+				  const char *path,
+				  bool local);
+
+/* Free the object database source, releasing all associated resources. */
+void odb_source_free(struct odb_source *source);
+
+#endif

-- 
2.53.0.797.g7842e34a66.dirty

