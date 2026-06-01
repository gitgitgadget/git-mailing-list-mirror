Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9D5389DF3
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 08:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780302039; cv=none; b=EdR118KfdBOcFgx9zvVhbnTk2xhlasnvMWsYD8suFymcUKilrOfhIyTAMtlxuG1OW+ncA9Y1rfB+udRaar8s7FPLlV3hSrfLYGsKLlVOmPFknC6JP27VEV3GKS+x51jSANMINW+YWHp6kt3T+Nt3OCL9APV6b41QyYzSekX0kf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780302039; c=relaxed/simple;
	bh=3hwqv4ta04pAgICTRAnEGf9eZ7+FBuEKtT9TDWAeGdw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=osUBWJ9brP2TFL3PcECZtqwF2cWGNgGubf3a6+r5yXet04vYwfVUGDfllNL2hD1y9tXkwWrQBYVmnxK96pyiEF4cKQ5fnsNwmdTxciFqJAYwDS9sK6uEAdqMHyUOJNG2xHVVln0QdwyIHpC8eMlpsREpNhc9xlKbsV7EA9iF8FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Zi/C6/x9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N0P1w99V; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Zi/C6/x9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N0P1w99V"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 04C1A140006D;
	Mon,  1 Jun 2026 04:20:37 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 01 Jun 2026 04:20:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780302037;
	 x=1780388437; bh=rFPRbujjn+KmK8Z09x56Hz6eYJK8MC0Y6fsqVF1RAWE=; b=
	Zi/C6/x9cKEy4aWzLK1odFzlB5WS6lwuFQVVJ19RcRXOm62SiPgRcXCXBTosqMF8
	PWocJwBqhnkbcj54DMZE1P9d6XDA+O4W5L6Hj4PGASrPHfWl/AequI7Vdx4oDQrD
	AI64PBIczSeiGAxN/VAvY8EFVKSzd2F/CXoZapeMbgBDFGRIS9LaBBSWBKu3Q5VH
	jjeuJ0V1zh1Gh1c0WCpOIfb4LOuuK4OiRFHMHPcpe2DDxtz9HzLi2i7ZgLDpPVjm
	ooYBFK+V/iBq1k3L8bagbcCtdveuxQbZa60U0KftFwNXLP+xGnxCqrFEUrbRgfZs
	8zk1iC4zi/+QjtnmiEOGfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780302037; x=
	1780388437; bh=rFPRbujjn+KmK8Z09x56Hz6eYJK8MC0Y6fsqVF1RAWE=; b=N
	0P1w99VjJFGrjfvjo7UlUUVb5WDFFlYSpjQemZGO4vPsLUVcVGWsS2CEgsfkhyQa
	JcWY8TU1Ec7izWCgk7I1zKTnsadegmFATWT3JDYgRfmWz0Z3UKEjQYaTEFPGggGK
	Hei35PLTgcO+6C38n5RyM4SsDr4orwM0oMxT8IFK8sRaCLQFzmx5+D5BHNZITqHi
	HKfUUgjnc+W1ZJe3a7QkJE8/VvSbdQRjbPogzfq8AAGCxiBkgOXBdCEE6OE25xno
	RoPV/QLVNGdFBg2pOa5Z5OwxiOQNZFD5Fo+pJ5JJD6r5soOcW54rhKMwq4PNyiiO
	6VTZGywCpOPIcrSr1fYqg==
X-ME-Sender: <xms:1EAdapQ-srvusjI1NEg0uBOjnuv-I-tN56iB5CrswO97isgcvQh4PA>
    <xme:1EAdaow8IfA9_ARs24kSlFa_jDnWbtWRCrPc4Umu5fCmimeXP-GCBxPVWf2KOsT8c
    CvHZ0GIcjqrOMdup3uTAh-WoXyXMqH5STPK_6osQtBd-R9cMdg>
X-ME-Received: <xmr:1EAdaseF5YfLGbAFB06nmqhK9E0Rg5RLpjZ3IpY4m8-PUsW0p79CGTNHWPD__NtoDhOfBnTZz-CGxcOs0zZtVX0i3b03BFsWi1EEG0M73IV8>
X-ME-Proxy-Cause: dmFkZTGoVC3PWkC/M98GLpgwKSp8+X2EEbK9QrLPRCVzfq6z8mGb2cg1WSKI0P1YF6K99Q
    xKY18KC2TzQ71gWxrLtHBcpqPwInMMILQwQmN+IaQps5jv2t4yhm/OcWnxr3PAuKdie/5H
    xdZiEXHfq3CyGlKpLwv2vL5myW19uyY8AtAnQMD9jV84wJQFe0QGymylYpZQO++m8ND1Hj
    j7fjS2tB+vIBobG7JpZXtzobTDeXEGy6yi7zeMBs162gs+xcsIodAA21pY4HTX/IAVCIU8
    kOLzJFDG9r9Lr/xlbzdlHVCtb2SlM1MPmdQV95SWFIB7kaTFV8arUy82aX0eqGVCnq+EB/
    o+I4NDetbS6yyVarrECxd96XrWWAZpKRdLac7zFxLiGwudsdSDlEWB5d2nJso25MGgIVo2
    IitysYKlNiKJWspFC/hlc6yJXBL5qTFMh601oqrtTiAvYS6RUG+3d1VdEXOboD/xwn/F2p
    HtNi+B0qYZ2lQygeLEstJG4kKLVP87gT/bMFJaY/59xXCUImNf+z9NX+l7wiReZ/pXnEXK
    Z6RjGvct+u4VOROmQ6TibhfH+Y+fgvPU+LwiGWm3Cn2WoVhBb7IEt3Wh+C3SvPriU8c5WA
    kxPmXpmpTBjSpzeLf+SnaGbhRqxjOZbiLtPlPZhWLtRtPSrwkBkC9C2xVRIQ
X-ME-Proxy: <xmx:1EAdasIIOSBDFDNuF8nqRIeuumHf3aglskCse5lTHtXxUFpG6e4gmg>
    <xmx:1EAdalGExS738J81ZCaQmq_Kha8BWIXkC94cB6mbJ_8kGuvaX_MJiQ>
    <xmx:1EAdauoHPjWrtwFEf_JN1Mi0r7_Yex-nuvMLbCLQAW6zwzJCXmRnVQ>
    <xmx:1EAdamRN0nmCKsVg7JewnxdP24kWNA8CQhZZ524l7ZJBIGdwXpcF6A>
    <xmx:1UAdasomDt-mQDTq_eiMr-UXNhFPzItpbjGUo6nVTpyy9wKUIlbZOphG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 04:20:36 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 801a323c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 1 Jun 2026 08:20:36 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 01 Jun 2026 10:20:26 +0200
Subject: [PATCH v2 03/18] odb/source-loose: start converting to a proper
 `struct odb_source`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-b4-pks-odb-source-loose-v2-3-90ff159430af@pks.im>
References: <20260601-b4-pks-odb-source-loose-v2-0-90ff159430af@pks.im>
In-Reply-To: <20260601-b4-pks-odb-source-loose-v2-0-90ff159430af@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

Start converting `struct odb_source_loose` into a proper pluggable
`struct odb_source` by embedding the base struct and assigning it the
new `ODB_SOURCE_LOOSE` type. Furthermore, wire up lifecycle management
of this source by implementing the `free` callback and taking ownership
of the chdir notifications.

Note that the loose source is not yet functional as a standalone `struct
odb_source`, as it's missing all of the callback implementations. These
will be wired up in subsequent commits.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c      | 17 -----------------
 object-file.h      |  2 --
 odb/source-files.c |  2 +-
 odb/source-loose.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 odb/source-loose.h | 14 ++++++++++++++
 odb/source.h       |  3 +++
 6 files changed, 63 insertions(+), 20 deletions(-)

diff --git a/object-file.c b/object-file.c
index 7a1908bfc0..977d959d33 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2041,14 +2041,6 @@ static struct oidtree *odb_source_loose_cache(struct odb_source *source,
 	return files->loose->cache;
 }
 
-static void odb_source_loose_clear_cache(struct odb_source_loose *loose)
-{
-	oidtree_clear(loose->cache);
-	FREE_AND_NULL(loose->cache);
-	memset(&loose->subdir_seen, 0,
-	       sizeof(loose->subdir_seen));
-}
-
 void odb_source_loose_reprepare(struct odb_source *source)
 {
 	struct odb_source_files *files = odb_source_files_downcast(source);
@@ -2205,15 +2197,6 @@ struct odb_transaction *odb_transaction_files_begin(struct odb_source *source)
 	return &transaction->base;
 }
 
-void odb_source_loose_free(struct odb_source_loose *loose)
-{
-	if (!loose)
-		return;
-	odb_source_loose_clear_cache(loose);
-	loose_object_map_clear(&loose->map);
-	free(loose);
-}
-
 struct odb_loose_read_stream {
 	struct odb_read_stream base;
 	git_zstream z;
diff --git a/object-file.h b/object-file.h
index 1d8312cf7f..02c9680980 100644
--- a/object-file.h
+++ b/object-file.h
@@ -21,8 +21,6 @@ struct object_info;
 struct odb_read_stream;
 struct odb_source;
 
-void odb_source_loose_free(struct odb_source_loose *loose);
-
 /* Reprepare the loose source by emptying the loose object cache. */
 void odb_source_loose_reprepare(struct odb_source *source);
 
diff --git a/odb/source-files.c b/odb/source-files.c
index 185cc6903e..ccc637311b 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -27,7 +27,7 @@ static void odb_source_files_free(struct odb_source *source)
 {
 	struct odb_source_files *files = odb_source_files_downcast(source);
 	chdir_notify_unregister(NULL, odb_source_files_reparent, files);
-	odb_source_loose_free(files->loose);
+	odb_source_free(&files->loose->base);
 	packfile_store_free(files->packed);
 	odb_source_release(&files->base);
 	free(files);
diff --git a/odb/source-loose.c b/odb/source-loose.c
index c9e7414814..92e18f5adb 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -1,10 +1,55 @@
 #include "git-compat-util.h"
+#include "abspath.h"
+#include "chdir-notify.h"
+#include "loose.h"
+#include "odb.h"
+#include "odb/source-files.h"
 #include "odb/source-loose.h"
+#include "oidtree.h"
+
+void odb_source_loose_clear_cache(struct odb_source_loose *loose)
+{
+	oidtree_clear(loose->cache);
+	FREE_AND_NULL(loose->cache);
+	memset(&loose->subdir_seen, 0,
+	       sizeof(loose->subdir_seen));
+}
+
+static void odb_source_loose_reparent(const char *name UNUSED,
+				      const char *old_cwd,
+				      const char *new_cwd,
+				      void *cb_data)
+{
+	struct odb_source_loose *loose = cb_data;
+	char *path = reparent_relative_path(old_cwd, new_cwd,
+					    loose->base.path);
+	free(loose->base.path);
+	loose->base.path = path;
+}
+
+static void odb_source_loose_free(struct odb_source *source)
+{
+	struct odb_source_loose *loose = odb_source_loose_downcast(source);
+	odb_source_loose_clear_cache(loose);
+	loose_object_map_clear(&loose->map);
+	chdir_notify_unregister(NULL, odb_source_loose_reparent, loose);
+	odb_source_release(&loose->base);
+	free(loose);
+}
 
 struct odb_source_loose *odb_source_loose_new(struct odb_source_files *files)
 {
 	struct odb_source_loose *loose;
+
 	CALLOC_ARRAY(loose, 1);
+	odb_source_init(&loose->base, files->base.odb, ODB_SOURCE_LOOSE,
+			files->base.path, files->base.local);
 	loose->files = files;
+
+	loose->base.free = odb_source_loose_free;
+
+	if (!is_absolute_path(loose->base.path))
+		chdir_notify_register(NULL, odb_source_loose_reparent, loose);
+
 	return loose;
 }
diff --git a/odb/source-loose.h b/odb/source-loose.h
index bf61e767c8..bd989f0728 100644
--- a/odb/source-loose.h
+++ b/odb/source-loose.h
@@ -12,6 +12,7 @@ struct oidtree;
  * file per object. This source is part of the files source.
  */
 struct odb_source_loose {
+	struct odb_source base;
 	struct odb_source_files *files;
 
 	/*
@@ -32,4 +33,17 @@ struct odb_source_loose {
 
 struct odb_source_loose *odb_source_loose_new(struct odb_source_files *files);
 
+/*
+ * Cast the given object database source to the loose backend. This will cause
+ * a BUG in case the source doesn't use this backend.
+ */
+static inline struct odb_source_loose *odb_source_loose_downcast(struct odb_source *source)
+{
+	if (source->type != ODB_SOURCE_LOOSE)
+		BUG("trying to downcast source of type '%d' to loose", source->type);
+	return container_of(source, struct odb_source_loose, base);
+}
+
+void odb_source_loose_clear_cache(struct odb_source_loose *loose);
+
 #endif
diff --git a/odb/source.h b/odb/source.h
index 0a440884e4..8bcb67787e 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -14,6 +14,9 @@ enum odb_source_type {
 	/* The "files" backend that uses loose objects and packfiles. */
 	ODB_SOURCE_FILES,
 
+	/* The "loose" backend that uses loose objects, only. */
+	ODB_SOURCE_LOOSE,
+
 	/* The "in-memory" backend that stores objects in memory. */
 	ODB_SOURCE_INMEMORY,
 };

-- 
2.54.0.926.g75ba10bac6.dirty

