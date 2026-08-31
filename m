Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C979E3BFAD0
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 06:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788158796; cv=none; b=NcXltKlbSb1nUP9SKYa+2Hrfoi6bQGwMRBl++B19vbR/55o1NvPYZaFKXVEkfYdflcRnaZM9uS9kUCxRB32qvN8m+z4jgmyULSBbbDyWnZdL3oNrD3QHkO3fqp077Rt0DGgTSUnk26X/hdNY/ZxaRg+5VFtTMi23LRfu5EgwP9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788158796; c=relaxed/simple;
	bh=diVPuW2NXe94kB8eW/IA+fxDCAAlZD8XdK+PBOZ1wBk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wn1Or0wPEZd3e1Y58sicfM5n7WtbGBdv0kwNdEIUhFysP4O43PFs+gP3fT/pPYm/ys4TYi+FtidakyTM5M6uyZ1B16T6lnlmWY6sgiwbx+L34mjax2+kWbzsXedrMFcaZbNaGvEavRxh/HEprfkymJCCSGYG1yZK/uBz80PMl34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LAh8R8u6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gEoGt4ld; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LAh8R8u6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gEoGt4ld"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1CE617A013C;
	Mon, 31 Aug 2026 02:46:34 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 31 Aug 2026 02:46:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788158793;
	 x=1788245193; bh=4L+RVihv1uDeyOshmkdCSsnvo+wh6u8LsKJLnSuHuzw=; b=
	LAh8R8u64CqkS5YQ10b0eMCSzhxYibHv8vCGf7NLmIH5U6T+L8Wvy21MKBnWVrJN
	KpZ/IfxFoyu8pOIzvL9cUGDaBArJQcp3XGdYe+IPuDuPLcGhn7Ceh0rN6FwZvVjm
	z3ZIJ2rjqlOg+Rs4D8wX2/5xo0OYBPSnmcNDeXyibO8325ZT2ejHh2WhQGpmuqFE
	kaFP8kvSQadBhuXYUcBJZGZQu0R+tAy6kRcSDUIN2geoeaREfVmIfR/NbS58HR8b
	E9d2fb/ytdYGAZL38r7lpg34+a4Bc6S6kKkqoLvSvijj3ifd70WRyZc8Lgtt6wF7
	5MOrRe0IjEXdW+rqYBGeqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1788158793; x=
	1788245193; bh=4L+RVihv1uDeyOshmkdCSsnvo+wh6u8LsKJLnSuHuzw=; b=g
	EoGt4ldAbvHJMEsz3Aq4MsgUgOgv+qWoY2ID0X5/0PXFOY9lA3PAkytttqww4pWu
	bgz74romCJ/Kn+H6LUi2vcgtEM6ZHwZ6+WFfLp391+dWIAs4qG5jDt/SspnkbU7u
	HtvZKtOeFytOZ3pQt/A+t1bvXo5nrP4pQr1ge5+CmZ+lIqdk7D2PpBIe7Fd+YmVr
	lohU9qRy12J33yV+hudraoJvq+JUJWvp7LFq7lRDz6/pjODnC/noMn83nI4MfGMD
	ddYt4lKnCS9O99Wm4a5Dc22Ny6KJq9J1Y/CfwuO1Yg2AXet3R3f9G3qZY94cNfRS
	Vv6bIJ+9/55dOeaqAHRuw==
X-ME-Sender: <xms:SSOVajfYf6-1c113MRzzNyLRq_Y6R9wyAL4tycsI8BNLtLoS11OXUw>
    <xme:SSOVavMY-HLWjTuBa4DNnF5iteSnXvJts4aPIXcUH8WtawgI_V0spqcsuuhj3Yf0l
    gXcCHFf_WTOun-T6GguhlZOklhMg_WlDS4M93eyHTtpOioZXmvyoiE>
X-ME-Received: <xmr:SSOVaqLnWcg3MqTeXneI8frnt9bG1Uy6dgxchiWK7DjkuBnEE2UQ7Kb7Js7B55DJx6VDMQ>
X-ME-Proxy-Cause: dmFkZTEYVf0dL7UGrcJrZICBDSB3LjjfPaqozSE//v2Uk+wmrGGsN1vPAxnqAgkLBIQ8YH
    jkGm/0q2QCpTLzGMeN0PR1MeaTkM5EPaoEuoMhHzPGrgkrrahxb2HsmJ1bVk4UiWR43FR+
    opCeq8ZwOupZwyvgFz/5EO1rlWMX9ymY395FZ4JB8b6N4ddSX0Lf/ccWyhtowb9unYs78i
    q65B8tbD9ISvvMC186S9fuYl1A66bWAlIet37pjlPsFSIH2y9YQw83JMBRERaOog6/NRAV
    yj9dTKgCGRxgJt3f7+n8VX5/0i3r6oQenmQAn+SILo/sIBIqcd93oq/gzZ6ziXimOnALhD
    myPnjjZDX20PBBcHrO0sMZxn1jii5epY+0wT5Jpix+3HQcsalT3WBfnM8xKPIW4N6aL3sB
    fE1oObp3TZMrpy2RtjZpf6JtNTcedo6T7vfIRLnsMjozLXzfWIkzw/UxOnq8Hx0mwoiHLr
    I3GfcmKzusy6+h4vZSeEAnX29czrARZYyg2x3vx1rN8ul2YCXJmOuY0bBhEQypOritOQD+
    WILRY+Uo6ZgRBaU8hkumb31crc+8nDpIxauGVUe4l4hn4hrqB4xqo4KjTYU3nKY7aR2oY7
    KDI0TVaxe58c0Yo+w6XrZ0KZ0TlB+j3+muova3gJjxQsKXVMRA75btWJC/6w
X-ME-Proxy: <xmx:SSOVagF1lUFTgIQc6rr9vPwybyvUJxYyzkVQNa2j5JzWeRGtcMZL4g>
    <xmx:SSOVaiQ1dNh0zKiGN2qlv6mL2K0qkexS57jL32txRcR2JJiGoHIooQ>
    <xmx:SSOVasHjAGT_e6IHdAcpt5oxAuSV6L-cVjsqlpWgaQpwPehdQlwkYg>
    <xmx:SSOVau8RgZAwnM9BVvjSVqNAw2Z7j_7NjjvM_9K1nKhY1lllO01HNA>
    <xmx:SSOVaqM-H8INwViOl1KYApczuXNRFumfEE-QN8oZIL2rPyaAljhsDnr0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 02:46:33 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d132b99d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 31 Aug 2026 06:46:39 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 31 Aug 2026 08:46:19 +0200
Subject: [PATCH v2 05/10] odb: provide infrastructure for pluggable fsck
 checks
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-pks-odb-source-fsck-v2-5-f9b16ef4957b@pks.im>
References: <20260831-pks-odb-source-fsck-v2-0-f9b16ef4957b@pks.im>
In-Reply-To: <20260831-pks-odb-source-fsck-v2-0-f9b16ef4957b@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
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
2.55.0.979.g7e5102b832.dirty

