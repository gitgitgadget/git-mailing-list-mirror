Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A373C481FCC
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 14:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787668230; cv=none; b=E9p1OEDkHTCSXRxHD6Dyyp/8u2QThhDmrLtHWeyLMdX/BYFs89KL5JSf33zE5CkUYht8AiIw2TmqAAwgRP3HFzOVqaMMkQ/696S2rIEartWOS1ARotC1Z80lTFiINEYHWb45EQYTikLNztNsHPs/61heOCxRDNcxWuYK53xNNrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787668230; c=relaxed/simple;
	bh=a4Dh4OrYxsQnR7wFETyDiVc6HY6OWRsSKtIYhdwvudQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RXyHnLEeZO1JlNaptRwznvLjeAeK4b2WFwJIrEKGLdEvzsyQJFnhsHnTUvtDxsrnvNcjR8eCd1P4AqybA9bys0HReuR2le+bB30q83Bo1LgLneWGiVjxkSTUPUFJb+QBkhVtWdjnfE5/RT4LXevYMdWVplWriuILNTpyUZk63gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OlfWj43l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eEVk7bbc; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OlfWj43l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eEVk7bbc"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 235F77A0124
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 10:30:26 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 25 Aug 2026 10:30:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787668225;
	 x=1787754625; bh=kG8kPWBCm0yYjlgcguPPmdpygcWi56vOnDamdW+zE6g=; b=
	OlfWj43lUApK1df3YfAKqM/GMfHV0gW4M+VXRoEXX1qeghrCeQZXMDjJCkHVK3fR
	/enw5jcyf7htrl5OpjAPBkg4MhLdNz6/CdNtZg5Xv25DVx/aiAbmjJ1DqYxCTNnO
	g27PiE9yUWMEWjmThTSe/cKet27B5wmhcRHDoRtgkX4DMXRZH9I97as6dEUkiQDs
	4yeNlnflijUU1egtWtxhHDiAdKOUooeFRR7G22TfRYhFIYHegVS49n62b8iJcgwT
	xCRo85kENzr8jaQzVBBaB4aG6CW0vWEoq8opmq1LYIr4e0Lif40KIXCDxahcYdx+
	VKCONh917/GwjX31H5zizw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787668225; x=
	1787754625; bh=kG8kPWBCm0yYjlgcguPPmdpygcWi56vOnDamdW+zE6g=; b=e
	EVk7bbcC744ct4CsmV4OfE01J/w3c3/8+qVOzJ6y/ewf0E45mZ7dGuUa8edihSh5
	iAzS0V7VSj32FufRCjrj7w0gk4qSwnoXvDUB71MUivQlNYiSaQPIMZDdtu3vQfKe
	ET8Y0FJ1YJ6v3e3Ga9P+4+RP3Z2IaOh6PQhilTu1t9KEL+uA9TUrus9OMfO4+QpS
	OPPkA76ciKlspuF2Q/axXAnp8kPd+h2Y3mLRbW2X+e+FSpir9S/xa8VzE7dfE9Vn
	uTqqg8NrbOdjVeHk2f/qp2hMrsrQeuD9TZdpTGYQH7B96lVnutx1rad+9Jq5f6Lv
	CLYl60BdH00vGB0cb3lmQ==
X-ME-Sender: <xms:AaeNat1pTxFRVl_5p6MgiyBwfFJ76MbZGb_t9rVE-hMBGiPce-n9gQ>
    <xme:AaeNarC1SJzJTdSWws2mvNva17dQ7128QfWtuUGyo7tNo2zgTF4SWZwNxtIX10gYY
    9RsUGkb95VYAuVklaz7tw_CPcPqf-3W87eEG1PwhW_pGj7fbLThlO0>
X-ME-Received: <xmr:AaeNajjnk3h00mONfygKXnjunrhSMiBydCZLaImHP6Hy5Zn9l5vDHv-K4kOSt_J7c8-NPaQTER1OFjWbMD79KzWo_iBcG3ixoIqx-8XZUw>
X-ME-Proxy-Cause: dmFkZTGOmSEoA9+neI+y6KiFqVXJj0lCm5MyPrg5bG3mwmIfeptIuZK7pOspHB6dr6A3jw
    0b/nHilbJLti9juHqkQtupslXwSfMeDhLeTytcgAkgbV5IYLLNRDfbNZwb8KKAtTqC7BGu
    RkE7+oesP2tvNj31/eakZnAWVEErj3M2qF0Lr2Tnt7Be2UkyMqYngT1/WrI2kQn2isyTAn
    XQBfDsHBrb4V+jW4kTy1dcwAq5rnGQeLikoGIjyTQHK8hFdW6U12c6P5gTTsozsE8NAAfa
    Z34rMM9NxT8cpJVaHMuMXC8bYMvWvlH7A/119w9iGKyCoQJIG7KBeAj1ZQLj0M5keapHfU
    psne5PK5nH8Cs7Yzlnqz5A1Yi0EMjpiTML5PFp8qwDbs/msxYfwk7CkKs/1yE6pLsUE+qo
    TjmM+pJJ9prerMlKmLytVoh7b6YT8Cf3uGWhFBAKU8k+Vmnmpc5sKIzPS/9k/4Sw50FqQT
    urLu5m5EPnJrmir7Uaeel9MB26calIXQfJdDWE17PLQ5ZyLAEtrqU9Elwq4colLUvhU7YR
    EUQxh73ZH+Wle2JI4yyZB3KYMJJSsJSUxjEct/xxp5EGhelYKHMzFu6vUWLlHPJp2eq9Ot
    2kctXsNMM4ZDvmNNhcc/DCRlM7Z5QbLZG3fujqVlj+vmrhb31d67/Po/inyQ
X-ME-Proxy: <xmx:AaeNav9Dy1jXL1mruqNe0ZERJlE4LTxV_nJfXiR3e8E7G-ZDuUZn6Q>
    <xmx:AaeNav8C3N9Lgk7BSwzFND6ZQeLDU-7VjIJVDJkN1dJoVjPHNk8bkA>
    <xmx:AaeNaoBNHaIbo4GgDqlI_FEPjHxHp5hCbOYKClpTm6oDHGeqdkaxMQ>
    <xmx:AaeNavwIGttIA3vSTLNZGPf6IFpvjezknLrtEvyx9O6sa_R3mTZKjg>
    <xmx:AaeNajGRpPMcXmtG1TRnvglUqcXotHzvliZ01NxI2UGUONa6a8agX9pF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 25 Aug 2026 10:30:25 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 981b2c56 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 25 Aug 2026 14:30:24 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 25 Aug 2026 16:30:07 +0200
Subject: [PATCH 05/10] odb: provide infrastructure for pluggable fsck
 checks
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-pks-odb-source-fsck-v1-5-b756de0bf24f@pks.im>
References: <20260825-pks-odb-source-fsck-v1-0-b756de0bf24f@pks.im>
In-Reply-To: <20260825-pks-odb-source-fsck-v1-0-b756de0bf24f@pks.im>
To: git@vger.kernel.org
Cc: 
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
 odb.c                 |  9 +++++++++
 odb.h                 | 23 +++++++++++++++++++++++
 odb/source-files.c    | 13 +++++++++++++
 odb/source-inmemory.c |  8 ++++++++
 odb/source-loose.c    |  7 +++++++
 odb/source-packed.c   |  8 ++++++++
 odb/source.h          | 21 +++++++++++++++++++++
 8 files changed, 100 insertions(+), 5 deletions(-)

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
index 1fe20808eb..766043b685 100644
--- a/odb.c
+++ b/odb.c
@@ -1177,3 +1177,12 @@ void odb_reprepare(struct object_database *o)
 {
 	odb_prepare(o, ODB_PREPARE_FLUSH_CACHES);
 }
+
+int odb_fsck(struct object_database *odb, struct odb_fsck_options *options)
+{
+	int ret = 0;
+	for (struct odb_source *source = odb->sources; source; source = source->next)
+		if ((options->flags & ODB_FSCK_FULL) || source->local)
+			ret |= odb_source_fsck(source, options);
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
index bd4fdf3a6c..f6fb560d2e 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -893,6 +893,18 @@ static int odb_source_files_generate_pack(struct odb_source *source UNUSED,
 	return 0;
 }
 
+static int odb_source_files_fsck(struct odb_source *source,
+				 struct odb_fsck_options *opts)
+{
+	struct odb_source_files *files = odb_source_files_downcast(source);
+	int ret = 0;
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
@@ -908,6 +920,7 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
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
2.55.0.822.g20453c30eb.dirty

