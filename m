Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A585E485923
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 13:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789133270; cv=none; b=ctLyoK4Tp6CTC4wBqdmnVL2qXOh4jpn43IYtd03X2fNIVhhRXoZoVdNUfLwRSRvXpjNRt0mhvj84+fSg9h99Gb7n9CQrg4rIQoCa66HnApwr4u8V2dDrNzfTQS6W06+KsFWrgWGlhpFEUDE+8q+w27T1+D9LVAxHQ9ndQa2o9u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789133270; c=relaxed/simple;
	bh=M+uaGYNL0QWbmY4MFczP5swV2E1L24B3ACICNG8O1u0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QWyvvXX4aadxP7IX5TDHzPAA5U6k7DoNF5nU/loivFCHXnw/w7RQqvyNbJPB1GW2R4f31He7Cq0+t71umrBqqjC6kbRqcOmtZTIbtjOXaOBzju8jVob7I4iKRQg8mZszwjmkOirkuI6vUaJyiJSFoSo/ivSYzym7xrM8+NOotbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=wYmpRmai; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HURBlo9L; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="wYmpRmai";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HURBlo9L"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 660601400105;
	Fri, 11 Sep 2026 09:27:42 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 11 Sep 2026 09:27:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1789133262;
	 x=1789219662; bh=KvY9NupOSC8cTOhmEdzGZ0SHzhLSpVI7bm0GNW1C5F4=; b=
	wYmpRmai9DlEBPwu+E4ou5XXNEo29N7P1D7c3Y3wMSPGwlTF05IdRQqWazC1bDQ/
	lIzurxcOLqJt/MPakMLm9ZbvtdRrVSdleqri3OfuqlYear5AhFdq9vrX3JFQKCDc
	qnzDXFZHT3atLkZgrWIrOg6SIsmKPEnWBknf2SQSM/5HlQWqafm1DlvFhU5NniHu
	cHleyZESlDqPw7P3Wry3EkAlkNAtyRqto69yO50isXIvVGOeC2NouMwoJsIlLxEW
	KKe48LmVkLGIYgalQX/jskVvgOx2FLSYbrKHjdJUfXTOM2RvWG5OhntvbPgN4cGu
	6p23LEtf6QDB0iC8wKIJGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789133262; x=
	1789219662; bh=KvY9NupOSC8cTOhmEdzGZ0SHzhLSpVI7bm0GNW1C5F4=; b=H
	URBlo9LnqeVCDFhvEfutlshPuDPdUn/ekls/Ex/l7SvOLikyeEWVgoNRPQ4ESjMY
	Qa3Do3L1gi9DXv3siaF9A+4+g91cJLsbpTItWdB1unDB6ulnJ1z4FgZkqoTnzBZJ
	HICV7CegCZ25oE/tKfLU/+06xRdhIS1JZslKJDfknrx2mMixgpQD8oLNm73tpViJ
	SuqNsl/uGjmCHPMdaQyxS7FZCASyfrJJB3T17rfQW5mnfpFSt6rN8QIkwhCoKsdG
	47Ip9vJui7c1mIK1XqfEN5wsQwUAbO0knG5qCOJYWMACHtzwDv6VsGZ8qLI6npms
	dg3Cl4FmaW4m79zXW80Ug==
X-ME-Sender: <xms:zgGkakwM56126VPZQJJkLoLGOAsVpVxktJt3fr-theqU_Y52KMz_dA>
    <xme:zgGkavt7TpAqgusJnc1QxZkIUQI78ddouSZz3RSgyhD5ua9_eDFfw3YP1pFTBAXm6
    gQ3WS5HSB9QB_9KFztsRczQTv1HyWmBMB_P50zLRWGzm88lfKALdQ>
X-ME-Received: <xmr:zgGkajtUsB7xvXghW96ig2yxcHoE-4h_RjO9APi1xABx_2J8DpKCXrbFa021MYqd0kfgtQ>
X-ME-Proxy-Cause: dmFkZTFhKNTY4gaJzL8unHorI0O2mIjovbOSn/bb4FfWdQC69pOMNnSpJupj+k3b5RRAEh
    CKbErTW3WczRhRJwwrJkvaRsvQIzXEXE2C+BN/DKoL4Gbfz/Eo1tEu7eUCGtvI2UYkaIkN
    pdzF4Cl414GlPSVfplCLhQTY1vxDPnsAjpUCtDjPcnIgviIidiwFFMtURzMpzxs3Vu7cEM
    3nEkQWJ43K7d/I7qMYYZ6hxKZuNC1lSeitb76YKd6w//fOV1p7l3EElcNKMWcMdULICz/K
    NpH5skcEvh10Ou1QeaUv5hQYKlpJ4gF4a0EGGL8oCdZIc9NRujjRUNoZU+qfCLCaHmP9hT
    VV1ITpRayVpF8dyHJpbxnXGnysZg1sIjh5epY6dIuxtRwZ/mKtybC2eaR3aW8N8FoHkkjN
    TF4Sda0+WyaAR9ELxC6msP2ITqikVwmeKDWWdvcPy6CPqqUtG5Sl+TclzEae/hvkXLIO+X
    0Sw2eoWx28Nn7Tx/jG9CSa3zgjHaSkeaDscESdpQiza1BQaByF7sWYhafFCJ6+oojn38Ml
    874WJbhxwgttOTEzAIxtt9i7gquRrDwIvE+wU8XsP/GUMGVGNm+SOTTwl5uBcFcU0cpx8z
    vBp8LEUsuK4rQEr+v9lix7e4Khff1nxrbq1iH5isK9evxjmSrGipVlnareJA
X-ME-Proxy: <xmx:zgGkasNi7zXVwQ_FDsWiMT18Hv_kbnJHwE6IsSom238wFbd-asROHg>
    <xmx:zgGkap26zZm83egkOXJbhplJWUX4IvCZfzyDA0B4gt3D3qHkf6l34w>
    <xmx:zgGkagMEj4sm6n96OY_PVkPwg8SSA6RP8-KB-s4n-Z1CvFoK2mvcfw>
    <xmx:zgGkah1xFqRwGxnK-XNAd-rWsF807Jn_c8tOmFvyPZSJ6f47WR-aYw>
    <xmx:zgGkavvNFViTyZtfXUzUDQjcBLn22kijPsBlKz0Hoz2PkEPiRvFebXa1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Sep 2026 09:27:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1f13a8d0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 11 Sep 2026 13:27:41 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 11 Sep 2026 15:27:29 +0200
Subject: [PATCH v3 05/10] odb: provide infrastructure for pluggable fsck
 checks
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-pks-odb-source-fsck-v3-5-ef2fdc085e38@pks.im>
References: <20260911-pks-odb-source-fsck-v3-0-ef2fdc085e38@pks.im>
In-Reply-To: <20260911-pks-odb-source-fsck-v3-0-ef2fdc085e38@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.15.2

The on-disk consistency checks in git-fsck(1) are conceptually
backend-specific: while connectivity checks and object-level parsing
checks are generic, verifying the physical integrity of packfiles and
loose objects is meaningful only to backends that use these formats:
Having these checks live in "builtin/fsck.c" violates that layering,
because it forces the command to reach directly into format-specific
internals.

Provide new infrastructure to make these format-specific checks
pluggable and implement stubs for the different source types we already
have. In subsequent commits we'll move functionality over piece by
piece.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fsck.c        | 16 +++++++++++-----
 odb.c                 |  8 ++++++++
 odb.h                 | 23 +++++++++++++++++++++++
 odb/source-files.c    | 16 ++++++++++++++++
 odb/source-inmemory.c |  8 ++++++++
 odb/source-loose.c    |  7 +++++++
 odb/source-packed.c   |  8 ++++++++
 odb/source.h          | 21 +++++++++++++++++++++
 8 files changed, 102 insertions(+), 5 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 3f6056535f..adbe192e56 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -965,7 +965,9 @@ int cmd_fsck(int argc,
 	     const char *prefix,
 	     struct repository *repo)
 {
-	int check_full = 1;
+	struct odb_fsck_options odb_fsck_opts = {
+		.flags = ODB_FSCK_FULL,
+	};
 	int keep_cache_objects = 0;
 	int name_objects = 0;
 	int check_references = 1;
@@ -977,7 +979,8 @@ int cmd_fsck(int argc,
 		OPT_BOOL(0, "root", &show_root, N_("report root nodes")),
 		OPT_BOOL(0, "cache", &keep_cache_objects, N_("make index objects head nodes")),
 		OPT_BOOL(0, "reflogs", &include_reflogs, N_("make reflogs head nodes (default)")),
-		OPT_BOOL(0, "full", &check_full, N_("also consider packs and alternate objects")),
+		OPT_BIT(0, "full", &odb_fsck_opts.flags,
+			N_("also consider packs and alternate objects"), ODB_FSCK_FULL),
 		OPT_BOOL(0, "connectivity-only", &connectivity_only, N_("check only connectivity")),
 		OPT_BOOL(0, "strict", &check_strict, N_("enable more strict checking")),
 		OPT_BOOL(0, "lost-found", &write_lost_and_found,
@@ -1018,7 +1021,7 @@ int cmd_fsck(int argc,
 		show_progress = 0;
 
 	if (write_lost_and_found) {
-		check_full = 1;
+		odb_fsck_opts.flags |= ODB_FSCK_FULL;
 		include_reflogs = 0;
 	}
 
@@ -1047,10 +1050,13 @@ int cmd_fsck(int argc,
 				    mark_object_for_connectivity, repo, 0);
 	} else {
 		for (source = repo->objects->sources; source; source = source->next)
-			if (check_full || source->local)
+			if ((odb_fsck_opts.flags & ODB_FSCK_FULL) || source->local)
 				fsck_source(repo, source);
 
-		if (check_full) {
+		if (odb_fsck(repo->objects, &odb_fsck_opts) < 0)
+			errors_found |= ERROR_OBJECT;
+
+		if (odb_fsck_opts.flags & ODB_FSCK_FULL) {
 			struct packed_git *p;
 			uint32_t total = 0, count = 0;
 			struct progress *progress = NULL;
diff --git a/odb.c b/odb.c
index 1fe20808eb..1c40da4cad 100644
--- a/odb.c
+++ b/odb.c
@@ -1177,3 +1177,11 @@ void odb_reprepare(struct object_database *o)
 {
 	odb_prepare(o, ODB_PREPARE_FLUSH_CACHES);
 }
+
+int odb_fsck(struct object_database *odb, struct odb_fsck_options *options)
+{
+	int ret = 0;
+	for (struct odb_source *source = odb->sources; source; source = source->next)
+		ret |= odb_source_fsck(source, options);
+	return ret;
+}
diff --git a/odb.h b/odb.h
index e60174070f..76c15e48f5 100644
--- a/odb.h
+++ b/odb.h
@@ -206,6 +206,29 @@ void odb_prepare(struct object_database *o, enum odb_prepare_flags flags);
 /* Equivalent to `odb_prepare(o, ODB_PREPARE_FLUSH_CACHES)`. */
 void odb_reprepare(struct object_database *o);
 
+enum odb_fsck_flags {
+	/*
+	 * If set, perform a full consistency check for the full object
+	 * database, including all of its sources and the contents of their
+	 * optimized formats. Otherwise, only check the local source, and
+	 * restrict checks of its optimized formats to cheap structural
+	 * verification of their metadata.
+	 */
+	ODB_FSCK_FULL = (1 << 0),
+};
+
+/* Options that shall be passed to `odb_fsck()`. */
+struct odb_fsck_options {
+	enum odb_fsck_flags flags;
+};
+
+/*
+ * Run backend-specific integrity checks on all object sources. Each source
+ * performs the checks appropriate to its type. Returns 0 on success, a
+ * negative error code otherwise.
+ */
+int odb_fsck(struct object_database *odb, struct odb_fsck_options *opts);
+
 /*
  * Find source by its object directory path. Returns a `NULL` pointer in case
  * the source could not be found.
diff --git a/odb/source-files.c b/odb/source-files.c
index bd4fdf3a6c..66a95e2b48 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -893,6 +893,21 @@ static int odb_source_files_generate_pack(struct odb_source *source UNUSED,
 	return 0;
 }
 
+static int odb_source_files_fsck(struct odb_source *source,
+				 struct odb_fsck_options *opts)
+{
+	struct odb_source_files *files = odb_source_files_downcast(source);
+	int ret = 0;
+
+	if (!(opts->flags & ODB_FSCK_FULL) && !source->local)
+		return 0;
+
+	ret |= odb_source_fsck(&files->loose->base, opts);
+	ret |= odb_source_fsck(&files->packed->base, opts);
+
+	return ret;
+}
+
 struct odb_source_files *odb_source_files_new(struct object_database *odb,
 					      const char *path,
 					      bool local)
@@ -908,6 +923,7 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
 	files->base.close = odb_source_files_close;
 	files->base.create_on_disk = odb_source_files_create_on_disk;
 	files->base.prepare = odb_source_files_prepare;
+	files->base.fsck = odb_source_files_fsck;
 	files->base.read_object_info = odb_source_files_read_object_info;
 	files->base.read_object_stream = odb_source_files_read_object_stream;
 	files->base.for_each_object = odb_source_files_for_each_object;
diff --git a/odb/source-inmemory.c b/odb/source-inmemory.c
index 795672adf2..ba0f86da26 100644
--- a/odb/source-inmemory.c
+++ b/odb/source-inmemory.c
@@ -1,6 +1,7 @@
 #include "git-compat-util.h"
 #include "object-file.h"
 #include "odb.h"
+#include "fsck.h"
 #include "odb/source-inmemory.h"
 #include "odb/streaming.h"
 #include "oidtree.h"
@@ -368,6 +369,12 @@ static void odb_source_inmemory_free(struct odb_source *source)
 	free(inmemory);
 }
 
+static int odb_source_inmemory_fsck(struct odb_source *source UNUSED,
+				    struct odb_fsck_options *opts UNUSED)
+{
+	return 0;
+}
+
 struct odb_source_inmemory *odb_source_inmemory_new(struct object_database *odb)
 {
 	struct odb_source_inmemory *source;
@@ -378,6 +385,7 @@ struct odb_source_inmemory *odb_source_inmemory_new(struct object_database *odb)
 	source->base.free = odb_source_inmemory_free;
 	source->base.close = odb_source_inmemory_close;
 	source->base.prepare = odb_source_inmemory_prepare;
+	source->base.fsck = odb_source_inmemory_fsck;
 	source->base.read_object_info = odb_source_inmemory_read_object_info;
 	source->base.read_object_stream = odb_source_inmemory_read_object_stream;
 	source->base.for_each_object = odb_source_inmemory_for_each_object;
diff --git a/odb/source-loose.c b/odb/source-loose.c
index bb3455dfbd..f68d3c4d6c 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -1031,6 +1031,12 @@ static void odb_source_loose_free(struct odb_source *source)
 	free(loose);
 }
 
+static int odb_source_loose_fsck(struct odb_source *source UNUSED,
+				 struct odb_fsck_options *opts UNUSED)
+{
+	return 0;
+}
+
 struct odb_source_loose *odb_source_loose_new(struct object_database *odb,
 					      const char *path,
 					      bool local)
@@ -1043,6 +1049,7 @@ struct odb_source_loose *odb_source_loose_new(struct object_database *odb,
 	loose->base.free = odb_source_loose_free;
 	loose->base.close = odb_source_loose_close;
 	loose->base.prepare = odb_source_loose_prepare;
+	loose->base.fsck = odb_source_loose_fsck;
 	loose->base.read_object_info = odb_source_loose_read_object_info;
 	loose->base.read_object_stream = odb_source_loose_read_object_stream;
 	loose->base.for_each_object = odb_source_loose_for_each_object;
diff --git a/odb/source-packed.c b/odb/source-packed.c
index 630d955585..7aacf4bc45 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -2,6 +2,7 @@
 #include "abspath.h"
 #include "chdir-notify.h"
 #include "dir.h"
+#include "fsck.h"
 #include "git-zlib.h"
 #include "list-objects-filter-options.h"
 #include "mergesort.h"
@@ -826,6 +827,12 @@ static void odb_source_packed_free(struct odb_source *source)
 	free(packed);
 }
 
+static int odb_source_packed_fsck(struct odb_source *source UNUSED,
+				  struct odb_fsck_options *opts UNUSED)
+{
+	return 0;
+}
+
 struct odb_source_packed *odb_source_packed_new(struct object_database *odb,
 						const char *path,
 						bool local)
@@ -839,6 +846,7 @@ struct odb_source_packed *odb_source_packed_new(struct object_database *odb,
 	packed->base.free = odb_source_packed_free;
 	packed->base.close = odb_source_packed_close;
 	packed->base.prepare = odb_source_packed_prepare;
+	packed->base.fsck = odb_source_packed_fsck;
 	packed->base.read_object_info = odb_source_packed_read_object_info;
 	packed->base.read_object_stream = odb_source_packed_read_object_stream;
 	packed->base.for_each_object = odb_source_packed_for_each_object;
diff --git a/odb/source.h b/odb/source.h
index 559e2ea2e9..10a5dd5194 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -320,6 +320,17 @@ struct odb_source {
 	int (*generate_pack)(struct odb_source *source,
 			     struct odb_pack_generator **out,
 			     const struct odb_generate_pack_options *opts);
+
+	/*
+	 * This callback is expected to check the integrity of the object source
+	 * and report any errors found via the fsck options. The checks performed
+	 * are backend-specific.
+	 *
+	 * The callback is expected to return 0 on success, a negative error
+	 * code otherwise.
+	 */
+	int (*fsck)(struct odb_source *source,
+		    struct odb_fsck_options *options);
 };
 
 /*
@@ -588,4 +599,14 @@ static inline int odb_source_generate_pack(struct odb_source *source,
 	return source->generate_pack(source, out, opts);
 }
 
+/*
+ * Check the integrity of the object database source. The checks performed
+ * are backend-specific. Returns 0 on success, a negative error code otherwise.
+ */
+static inline int odb_source_fsck(struct odb_source *source,
+				  struct odb_fsck_options *opts)
+{
+	return source->fsck(source, opts);
+}
+
 #endif

-- 
2.55.0.1074.ge7621b4bad.dirty

