Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DAB30E0F5
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 16:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771863490; cv=none; b=caPzmUddB4w7rCvOGi0rNTa57VT6x13O5mc9StQN5O56dnvPUZFYyTTZvLy5IV5tkeMfz600cZ18WyKstVTSylcsTtvvrpbn8hCc1MaWjsLD+imYcaLjlJZrl/bSTAXQaI+MKPM23Aqm6udyfvMyDnQBWcU3/sR5Xd1bkT+19Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771863490; c=relaxed/simple;
	bh=Ws89UkSQlW6xQ5+q3eRxnOXxyKapaGhBRzZn4Lwp8q0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VI4oNQOjZLWBa2HquI9U56WK4uifuhVjnEaemE1oUfbCKTBbKGNnhiqUEMhFnTJ/efodMsnSjBCvlB4ndSnD8aiBjNRv7QI9+uauGSaBiwIIvxjJA/QlAIsFvR/hO0qyk/hTRhV7+zk3tp4IKpxjyFb5KC0IHC+AXa2RWaCTiPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IUlL2Rw9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RxlPzqaM; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IUlL2Rw9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RxlPzqaM"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0601D1400219
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 11:18:08 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 23 Feb 2026 11:18:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771863488;
	 x=1771949888; bh=CGcvFax/VU2pcB3xWzuuz4YVN8eLjYWJBkbBa/9eyCY=; b=
	IUlL2Rw9I+AgfZF/8aS5yp7WyWrkpr88WiDiPagxkqn8Fesa19Ontg8UjKGxlVN1
	NocWOG3gyLqtQnHPyVxhAmYKsImo1wZZ5MpimWcNp5zRpFXCYBXRk99n/Alk7hEH
	EyCnw9n89uHGqFUmHxROZ3h2ZWhic0oINjTESQ2sFofj+HYmqGvb3vMULTjfceFM
	FyY+ywrxt/zztyGQyFSDtkua3CzM/Y7AzAhIH6pn7zmn9OSGYq4xwOTz5MBQ9rvc
	1kGwHwLH/X/2+J0cTrW9QYU4DWug9xccCx4Eik01dU96JRQoD462P6wqjp15H5nG
	qRiDr425UQCvnW5cA+gpYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771863488; x=
	1771949888; bh=CGcvFax/VU2pcB3xWzuuz4YVN8eLjYWJBkbBa/9eyCY=; b=R
	xlPzqaM2ZV+xQERCt+BvO3fP2DgaUmbHaE0VqK+/VAgIbTzqPZanabxzN0jlUoqz
	0Ml2DYKzHUdId8Me7U+hsISxyd++c1dWaR/N1A/SMtLpRVyJoJIe446mBs/leY9n
	YsX3v/KbTD8GaAQU9scnK/dn9U4XbyzZRxqHhm6NTsopp3b16qLy1DtmgNxSL8K9
	I9GlshipNpb0Ajb1tWya5fc8F3StL7YwhM6rdU0N1GlD4VelkBLuHOri+JjA97H6
	sAnjUz7iQYo6FhzSXrfNdl4DDd4tKLgPeOmUqGQ4+OtjrBN/HQ3Gl71kz9yAdh6Z
	eXIQEdg7qy3JT7liaVDFg==
X-ME-Sender: <xms:v32cadkfmg-tuvdMkYvwQRlMoaJN7ivcmMeM4c8XKtvr2-2V9aslKA>
    <xme:v32cafyZ6E3yOlu1_knq1-SnUiuC-CMf34vdT8XJyF6Fmm-Ndz9eQfGvLIbQKJaXK
    _sMn8AZG77FbaEI-cyzbAFxV3JRYsAr5aAiuHpte6epgDVwWFpZ>
X-ME-Received: <xmr:v32caZRj1B7UUcFHJ_Q1p8kEaZc-aiTF12GqIha0bCtennidiDJsGOz8fLOU4_cpDCeiHiT8QWeD-_CRQQ3D-dEm4wx9om29C_Tbc7-LXg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeejieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:v32caSvfyn7DiGkUasoHsNdHfNH1puO1F1sQ2AL0v7Q_32_7e47v0g>
    <xmx:v32cabucqudoZF-58KrZt8iFp719lhbZFmdaHGvo5FR0LUwWmth0ww>
    <xmx:v32caYyqg1S4KhLLM6aR91Cs1AtTV8td252vTAk5MUJkDfy8H0b1YQ>
    <xmx:v32caRhvWPdhj0k_tlCoyTiJES7lbhw-p_BQ_WPKVU77hDeu0pQdvw>
    <xmx:wH2caV1PsWg4qxTx_kV3YbXlkilmYJG206PmCfQv_P9Df2-pFpeZFHgq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 23 Feb 2026 11:18:07 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 684f8387 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 23 Feb 2026 16:18:06 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 23 Feb 2026 17:17:52 +0100
Subject: [PATCH 01/17] odb: split `struct odb_source` into separate header
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-b4-pks-odb-source-pluggable-v1-1-253bac1db598@pks.im>
References: <20260223-b4-pks-odb-source-pluggable-v1-0-253bac1db598@pks.im>
In-Reply-To: <20260223-b4-pks-odb-source-pluggable-v1-0-253bac1db598@pks.im>
To: git@vger.kernel.org
Cc: 
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
2.53.0.536.g309c995771.dirty

