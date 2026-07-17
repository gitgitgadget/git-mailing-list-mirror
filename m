Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780F23C1F5E
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 09:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784280753; cv=none; b=oSBqFDQ6bsVR+dfIxoRJM56P5Lqy6yP5z9b4M4GRw9M+aGjK2Nuz/MiQqf9iX3u/uFQCxxlqigl7F/rp1aQU9B5sg1xryYc8Lgml09OK4s67hyNCwMWlkJtYHiEKu0jRu/ihsm9diuqLnYVz3gjZaJqWYyHkF6KmlJ7pzipL3ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784280753; c=relaxed/simple;
	bh=Blyc6ZzH0yH6yiijHIQoJwsNpLuf/Q1MSCFBoWS27ZM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fM8mpUzDTYqaGR981Gi1PP/VEqu3NS+uq/fKqIpSQWCp/OMYJkc+7UbDWznp2mGuQnLvvupgoc1yAUq9hCgGdt8Lr+GCatLRr+EV6rP+QTFBbAkyvU8Y1LSJZvEqqPAhn5FLJIlurAM7wrgRh2+UO1kAoWsTM79zL/XkWoGnZ9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GM+V8dr4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L8sgHmdO; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GM+V8dr4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L8sgHmdO"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id B93951D000C5;
	Fri, 17 Jul 2026 05:32:30 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 17 Jul 2026 05:32:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1784280750;
	 x=1784367150; bh=qflD6EYz7D+yGSQDUzfYkHgvsUejZtnIJIBvoRRVaZ0=; b=
	GM+V8dr4RKuEYWpLo1MfeDRk8dQGJPtIQ5PRP5vUCK/1vTy7q32yoWEZuloAYlhT
	ArZ3uqMQS0coxvJsfx1fhuPCprWamk7OVYuBD6o6xoTiCjEQjRyHdHAHke6ueICr
	5kG7J6L+uxp69fv2HfSim+Hxpcp+RD9Z3xqv7cK7pG7opWj5i+CDlsbzjZNct9Na
	9DbmdOWn6Lrt1repLD8eAx/CjVgVlIj8bTKoCpNb08O3Gfd5B345QyxZFHzX62MM
	Pao72DDXFq29Z2K0U9bnTONlT2SelpWUBcD9lediMxhSAhZuTzWd8Hcl5URWr2hH
	PvJLZFtz9VqHKPSuySoUfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784280750; x=
	1784367150; bh=qflD6EYz7D+yGSQDUzfYkHgvsUejZtnIJIBvoRRVaZ0=; b=L
	8sgHmdOC/RiUpzC7meSe7JIigLQ0dZkUKuU2kIE8qTIQTH36vghx9tHGTrOwgNv4
	eXqGl8epGZf944YTr2VnnSVGNCRsNOdwlOSiCDWJAxDrI7755Y+um9EFIl38Or2f
	qWAYOvgPAMAbq1fjakGXeJUaGBjfIFAKMyFKI1id0u8zU0sQJhsRC2XcK6PldT9/
	rcs4Uq+eOpY/mcpelDsqwwkIaPILr8G7texYEqZJiNWsGpmPWg9XEY1zuLOgnhbp
	qYi4Uf5rGVpDGzISRjDI+cZnSXs6WDEfoKVk1VYSjWe4O028+QEh9QkoMYuSRFBP
	idQnHjaq5RSkKk0RiWDwA==
X-ME-Sender: <xms:rvZZanWYOzEoBIUZUMaMEp2gBAVbm-W3B1gh-KzToCDXX0NAIes7uA>
    <xme:rvZZalmnyFtSleG5RCdMdv0QFPgJjAe64Jn6fBWY6kKmfbzXPDLFXj_DMhIklLxz1
    Bi9eYo8XB2BCkIlIb-UqP1dea59_ZSeBTn76CzAngkbhIjemYa->
X-ME-Received: <xmr:rvZZahAtHgMQQpkHLgPTBbYCKi8zCTfc6bxuXNuU7l0lNSFIBRp5UM8hu9GLHRWOCF0VwiD-SdRyUzeiJVJdWVRNh9vc1B47w7T5pA6LeR0>
X-ME-Proxy-Cause: dmFkZTGIjSPLf/Mwl0QPqmALa5oCTSDSu6dlMRo6UNFljZET7f914LM5eRQHubQngUk90X
    94dHLidCVt6h7xljvq4mBrFJh0Nj+E9FSgNV5oZ8KvjjUbFeMCNs4Is8mQgwZmLuyxKygM
    l1KcDER//ShooRGQd4dSEeHsMS9NQSdHQyHSN1ybTRvHwWuYTXvo/UxVt10hzL58Zs0xfN
    TrQkCgLnWFrdAUoNcBSxfze+YjR7waIYoFwNnPE7LFOjnCTd6JSQXdZAsVO0+UplsNX1c7
    Ie87agcdeiJDEmcLHCOFr88OO/S20j9J6eRCBI8mnZmNQ2uvOwqDicARZLAOUTf1BsbdtL
    WLfJsT1pz79Ooh+oVA3/pdeRjzrlx5X4D8TXNJoZHyZ6my6KWlv/4szS3AKNOTVv0oCct6
    DnDGVHJaK86HjL/2DTXPfpL44DIssHyFSzrwRGXFO9JprAmeqsIcUZ3ESKu2Rmloj1JFpA
    4dQBtdaVNUlqx2SvVCD8f3H3jknjYVSttfBUolYHy0HJrqmvfmCPC2JQazaGNC2GVS4NkK
    xa+f2kAFdDHXHXVcmkJkqxGIlOMkRkG/gENfW8L4n3ZinG3sqs8halY66xqa+SmW8cuq9t
    SfuhFIW9TASlAHhZUBmRSQ4s+Pnkj0dzgmhMIBkj4NbMbU3R7vTblerSoawQ
X-ME-Proxy: <xmx:rvZZatfY7wK75eTKr425oO4U-6yrSuUj3_Zgd9cbudwtLE_kK4EKVA>
    <xmx:rvZZakL76v4G6m7CCDT3RGje04mLV1TsDEeKw_6hoBgQD96UjL_o7g>
    <xmx:rvZZaocyOiI5DEcIq4LQeDaL_4LILj9KDcbOj7QXleaNAZhiUcbZSQ>
    <xmx:rvZZaj2ANV7xdcOnmAAOCfBebj0pht-9Zn6J_lEqxLoqfkIIgTuKvw>
    <xmx:rvZZasFSnIpkgY4x6P5l9loQsYkQ9KutzMDgEhogaKMethLB5-WXMAgJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jul 2026 05:32:29 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f423d94e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 17 Jul 2026 09:32:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 17 Jul 2026 11:32:13 +0200
Subject: [PATCH 5/9] odb: support setting mtime when writing objects
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260717-pks-odb-move-loose-object-writing-v1-5-46446a3cb5b7@pks.im>
References: <20260717-pks-odb-move-loose-object-writing-v1-0-46446a3cb5b7@pks.im>
In-Reply-To: <20260717-pks-odb-move-loose-object-writing-v1-0-46446a3cb5b7@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

The function `force_object_loose()` is used to loosen packed objects
before repacking. It passes the pack's mtime along so that the newly
written loose object inherits the same timestamp. This matters for
object pruning, which uses the mtime to determine whether an object is
old enough to be pruned.

In a subsequent commit, `force_object_loose()` will be converted to use
the generic `odb_source_write_object()` interface instead of calling
`write_loose_object()` directly. But the generic interface doesn't yet
support setting a specific mtime, which makes it impossible to implement
the logic as of now.

Prepare for the change by introducing a new `mtime` parameter to this
function that we plumb through the stack. If set, the backends are
instructed to set the object's mtime accordingly. If unset, the backends
are expected to use the current time instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/pack-objects.c        |  2 +-
 object-file.c                 | 29 ++++++++++++++++++++---------
 object-file.h                 |  8 +++++---
 odb.c                         |  6 +++---
 odb/source-files.c            | 10 ++++++----
 odb/source-inmemory.c         |  6 ++++--
 odb/source-loose.c            |  8 +++++---
 odb/source-packed.c           | 13 +++++++++++--
 odb/source.h                  | 12 ++++++++----
 read-cache.c                  |  2 +-
 t/unit-tests/u-odb-inmemory.c |  6 +++---
 11 files changed, 67 insertions(+), 35 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index ea5eab4cf8..e64a96f1a7 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4642,7 +4642,7 @@ static void loosen_unused_packed_objects(void)
 			    !has_sha1_pack_kept_or_nonlocal(&oid) &&
 			    !loosened_object_can_be_discarded(&oid, p->mtime)) {
 				if (force_object_loose(the_repository->objects->sources,
-						       &oid, p->mtime))
+						       &oid, &p->mtime))
 					die(_("unable to force loose object"));
 				loosened_objects_nr++;
 			}
diff --git a/object-file.c b/object-file.c
index 9ca14f484d..5b07530950 100644
--- a/object-file.c
+++ b/object-file.c
@@ -67,9 +67,17 @@ const char *odb_loose_path(struct odb_source_loose *loose,
 }
 
 /* Returns 1 if we have successfully freshened the file, 0 otherwise. */
-static int freshen_file(const char *fn)
+static int freshen_file(const char *fn, const time_t *mtime)
 {
-	return !utime(fn, NULL);
+	struct utimbuf times, *timesp = NULL;
+
+	if (mtime) {
+		times.actime = *mtime;
+		times.modtime = *mtime;
+		timesp = &times;
+	}
+
+	return !utime(fn, timesp);
 }
 
 /*
@@ -79,11 +87,12 @@ static int freshen_file(const char *fn)
  * either does not exist on disk, or has a stale mtime and may be subject to
  * pruning).
  */
-int check_and_freshen_file(const char *fn, int freshen)
+int check_and_freshen_file(const char *fn, int freshen,
+			   const time_t *mtime)
 {
 	if (access(fn, F_OK))
 		return 0;
-	if (freshen && !freshen_file(fn))
+	if (freshen && !freshen_file(fn, mtime))
 		return 0;
 	return 1;
 }
@@ -706,7 +715,7 @@ static int end_loose_object_common(struct odb_source_loose *loose,
 int write_loose_object(struct odb_source_loose *loose,
 		       const struct object_id *oid, char *hdr,
 		       int hdrlen, const void *buf, unsigned long len,
-		       time_t mtime, unsigned flags)
+		       const time_t *mtime, unsigned flags)
 {
 	int fd, ret;
 	unsigned char compressed[4096];
@@ -751,9 +760,11 @@ int write_loose_object(struct odb_source_loose *loose,
 	close_loose_object(loose, fd, tmp_file.buf);
 
 	if (mtime) {
-		struct utimbuf utb;
-		utb.actime = mtime;
-		utb.modtime = mtime;
+		struct utimbuf utb = {
+			.actime = *mtime,
+			.modtime = *mtime,
+		};
+
 		if (utime(tmp_file.buf, &utb) < 0 &&
 		    !(flags & ODB_WRITE_OBJECT_SILENT))
 			warning_errno(_("failed utime() on %s"), tmp_file.buf);
@@ -883,7 +894,7 @@ int odb_source_loose_write_stream(struct odb_source_loose *loose,
 }
 
 int force_object_loose(struct odb_source *source,
-		       const struct object_id *oid, time_t mtime)
+		       const struct object_id *oid, const time_t *mtime)
 {
 	struct odb_source_files *files = odb_source_files_downcast(source);
 	const struct git_hash_algo *compat = source->odb->repo->compat_hash_algo;
diff --git a/object-file.h b/object-file.h
index 08aafcda0d..9fd540afb6 100644
--- a/object-file.h
+++ b/object-file.h
@@ -99,7 +99,8 @@ int format_object_header(char *str, size_t size, enum object_type type,
 			 size_t objsize);
 
 int force_object_loose(struct odb_source *source,
-		       const struct object_id *oid, time_t mtime);
+		       const struct object_id *oid,
+		       const time_t *mtime);
 
 /**
  * With in-core object data in "buf", rehash it to make sure the
@@ -137,10 +138,11 @@ void hash_object_file(const struct git_hash_algo *algo, const void *buf,
 int write_loose_object(struct odb_source_loose *loose,
 		       const struct object_id *oid, char *hdr,
 		       int hdrlen, const void *buf, unsigned long len,
-		       time_t mtime, unsigned flags);
+		       const time_t *mtime, unsigned flags);
 
 /* Helper to check and "touch" a file */
-int check_and_freshen_file(const char *fn, int freshen);
+int check_and_freshen_file(const char *fn, int freshen,
+			   const time_t *mtime);
 
 /*
  * Open the loose object at path, check its hash, and return the contents,
diff --git a/odb.c b/odb.c
index bfeca76f4e..dabd481f57 100644
--- a/odb.c
+++ b/odb.c
@@ -738,7 +738,7 @@ int odb_pretend_object(struct object_database *odb,
 		return 0;
 
 	return odb_source_write_object(odb->inmemory_objects,
-				       buf, len, type, oid, NULL, 0);
+				       buf, len, type, oid, NULL, NULL, 0);
 }
 
 void *odb_read_object(struct object_database *odb,
@@ -829,7 +829,7 @@ int odb_freshen_object(struct object_database *odb,
 	struct odb_source *source;
 	odb_prepare_alternates(odb);
 	for (source = odb->sources; source; source = source->next)
-		if (odb_source_freshen_object(source, oid))
+		if (odb_source_freshen_object(source, oid, NULL))
 			return 1;
 	return 0;
 }
@@ -1024,7 +1024,7 @@ int odb_write_object_ext(struct object_database *odb,
 	}
 
 	return odb_source_write_object(odb->sources, buf, len, type,
-				       oid, compat_oid_p, flags);
+				       oid, compat_oid_p, NULL, flags);
 }
 
 int odb_write_object_stream(struct object_database *odb,
diff --git a/odb/source-files.c b/odb/source-files.c
index 06dfc8dd78..4df4e1af6c 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -150,11 +150,12 @@ static int odb_source_files_find_abbrev_len(struct odb_source *source,
 }
 
 static int odb_source_files_freshen_object(struct odb_source *source,
-					   const struct object_id *oid)
+					   const struct object_id *oid,
+					   const time_t *mtime)
 {
 	struct odb_source_files *files = odb_source_files_downcast(source);
-	if (odb_source_freshen_object(&files->packed->base, oid) ||
-	    odb_source_freshen_object(&files->loose->base, oid))
+	if (odb_source_freshen_object(&files->packed->base, oid, mtime) ||
+	    odb_source_freshen_object(&files->loose->base, oid, mtime))
 		return 1;
 	return 0;
 }
@@ -164,11 +165,12 @@ static int odb_source_files_write_object(struct odb_source *source,
 					 enum object_type type,
 					 const struct object_id *oid,
 					 const struct object_id *compat_oid,
+					 const time_t *mtime,
 					 enum odb_write_object_flags flags)
 {
 	struct odb_source_files *files = odb_source_files_downcast(source);
 	return odb_source_write_object(&files->loose->base, buf, len, type,
-				       oid, compat_oid, flags);
+				       oid, compat_oid, mtime, flags);
 }
 
 static int odb_source_files_write_object_stream(struct odb_source *source,
diff --git a/odb/source-inmemory.c b/odb/source-inmemory.c
index 963d520317..3e71611b8e 100644
--- a/odb/source-inmemory.c
+++ b/odb/source-inmemory.c
@@ -232,6 +232,7 @@ static int odb_source_inmemory_write_object(struct odb_source *source,
 					    enum object_type type,
 					    const struct object_id *oid,
 					    const struct object_id *compat_oid UNUSED,
+					    const time_t *mtime UNUSED,
 					    enum odb_write_object_flags flags UNUSED)
 {
 	struct odb_source_inmemory *inmemory = odb_source_inmemory_downcast(source);
@@ -286,7 +287,7 @@ static int odb_source_inmemory_write_object_stream(struct odb_source *source,
 	hash_object_file(source->odb->repo->hash_algo, data, total_read, OBJ_BLOB, oid);
 
 	ret = odb_source_inmemory_write_object(source, data, len, OBJ_BLOB, oid,
-					       NULL, 0);
+					       NULL, NULL, 0);
 	if (ret < 0)
 		goto out;
 
@@ -296,7 +297,8 @@ static int odb_source_inmemory_write_object_stream(struct odb_source *source,
 }
 
 static int odb_source_inmemory_freshen_object(struct odb_source *source,
-					      const struct object_id *oid)
+					      const struct object_id *oid,
+					      const time_t *mtime UNUSED)
 {
 	struct odb_source_inmemory *inmemory = odb_source_inmemory_downcast(source);
 	if (find_cached_object(inmemory, oid))
diff --git a/odb/source-loose.c b/odb/source-loose.c
index 04af1a54a3..520a30157c 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -574,12 +574,13 @@ static int odb_source_loose_count_objects(struct odb_source *source,
 }
 
 static int odb_source_loose_freshen_object(struct odb_source *source,
-					   const struct object_id *oid)
+					   const struct object_id *oid,
+					   const time_t *mtime)
 {
 	struct odb_source_loose *loose = odb_source_loose_downcast(source);
 	static struct strbuf path = STRBUF_INIT;
 	odb_loose_path(loose, &path, oid);
-	return !!check_and_freshen_file(path.buf, 1);
+	return !!check_and_freshen_file(path.buf, 1, mtime);
 }
 
 static int odb_source_loose_write_object(struct odb_source *source,
@@ -587,6 +588,7 @@ static int odb_source_loose_write_object(struct odb_source *source,
 					 enum object_type type,
 					 const struct object_id *oid,
 					 const struct object_id *compat_oid,
+					 const time_t *mtime,
 					 enum odb_write_object_flags flags)
 {
 	struct odb_source_loose *loose = odb_source_loose_downcast(source);
@@ -595,7 +597,7 @@ static int odb_source_loose_write_object(struct odb_source *source,
 
 	hdrlen = format_object_header(hdr, sizeof(hdr), type, len);
 
-	if (write_loose_object(loose, oid, hdr, hdrlen, buf, len, 0, flags))
+	if (write_loose_object(loose, oid, hdr, hdrlen, buf, len, mtime, flags))
 		return -1;
 
 	if (compat_oid)
diff --git a/odb/source-packed.c b/odb/source-packed.c
index f7f1706447..5e5da9bc54 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -507,18 +507,26 @@ static int odb_source_packed_find_abbrev_len(struct odb_source *source,
 }
 
 static int odb_source_packed_freshen_object(struct odb_source *source,
-					    const struct object_id *oid)
+					    const struct object_id *oid,
+					    const time_t *mtime)
 {
 	struct odb_source_packed *packed = odb_source_packed_downcast(source);
+	struct utimbuf times, *timesp = NULL;
 	struct pack_entry e;
 
+	if (mtime) {
+		times.actime = *mtime;
+		times.modtime = *mtime;
+		timesp = &times;
+	}
+
 	if (!find_pack_entry(packed, oid, &e))
 		return 0;
 	if (e.p->is_cruft)
 		return 0;
 	if (e.p->freshened)
 		return 1;
-	if (utime(e.p->pack_name, NULL))
+	if (utime(e.p->pack_name, timesp))
 		return 0;
 	e.p->freshened = 1;
 
@@ -531,6 +539,7 @@ static int odb_source_packed_write_object(struct odb_source *source UNUSED,
 					  enum object_type type UNUSED,
 					  const struct object_id *oid UNUSED,
 					  const struct object_id *compat_oid UNUSED,
+					  const time_t *mtime UNUSED,
 					  unsigned flags UNUSED)
 {
 	return error("packed backend cannot write objects");
diff --git a/odb/source.h b/odb/source.h
index c4e94c9d0d..fc04dd5cda 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -190,7 +190,8 @@ struct odb_source {
 	 * has been freshened.
 	 */
 	int (*freshen_object)(struct odb_source *source,
-			      const struct object_id *oid);
+			      const struct object_id *oid,
+			      const time_t *mtime);
 
 	/*
 	 * This callback is expected to persist the given object into the
@@ -208,6 +209,7 @@ struct odb_source {
 			    enum object_type type,
 			    const struct object_id *oid,
 			    const struct object_id *compat_oid,
+			    const time_t *mtime,
 			    enum odb_write_object_flags flags);
 
 	/*
@@ -403,9 +405,10 @@ static inline int odb_source_find_abbrev_len(struct odb_source *source,
  * not exist.
  */
 static inline int odb_source_freshen_object(struct odb_source *source,
-					    const struct object_id *oid)
+					    const struct object_id *oid,
+					    const time_t *mtime)
 {
-	return source->freshen_object(source, oid);
+	return source->freshen_object(source, oid, mtime);
 }
 
 /*
@@ -418,10 +421,11 @@ static inline int odb_source_write_object(struct odb_source *source,
 					  enum object_type type,
 					  const struct object_id *oid,
 					  const struct object_id *compat_oid,
+					  const time_t *mtime,
 					  enum odb_write_object_flags flags)
 {
 	return source->write_object(source, buf, len, type, oid,
-				    compat_oid, flags);
+				    compat_oid, mtime, flags);
 }
 
 /*
diff --git a/read-cache.c b/read-cache.c
index 3510b49edf..c67930177f 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2342,7 +2342,7 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
  */
 static void freshen_shared_index(const char *shared_index, int warn)
 {
-	if (!check_and_freshen_file(shared_index, 1) && warn)
+	if (!check_and_freshen_file(shared_index, 1, NULL) && warn)
 		warning(_("could not freshen shared index '%s'"), shared_index);
 }
 
diff --git a/t/unit-tests/u-odb-inmemory.c b/t/unit-tests/u-odb-inmemory.c
index 28a69fc244..ddf2db5c81 100644
--- a/t/unit-tests/u-odb-inmemory.c
+++ b/t/unit-tests/u-odb-inmemory.c
@@ -45,7 +45,7 @@ static void cl_assert_write_object(struct odb_source_inmemory *source,
 	size_t content_len = strlen(content);
 	hash_object_file(repo.hash_algo, content, content_len, type, oid);
 	cl_must_pass(odb_source_write_object(&source->base, content, content_len,
-					     type, oid, NULL, 0));
+					     type, oid, NULL, NULL, 0));
 }
 
 void test_odb_inmemory__initialize(void)
@@ -256,11 +256,11 @@ void test_odb_inmemory__freshen_object(void)
 	const char *end;
 
 	cl_must_pass(parse_oid_hex_algop(RANDOM_OID, &oid, &end, repo.hash_algo));
-	cl_assert_equal_i(odb_source_freshen_object(&source->base, &oid), 0);
+	cl_assert_equal_i(odb_source_freshen_object(&source->base, &oid, NULL), 0);
 
 	cl_assert_write_object(source, "foobar", OBJ_BLOB, &written_oid);
 	cl_assert_equal_i(odb_source_freshen_object(&source->base,
-						    &written_oid), 1);
+						    &written_oid, NULL), 1);
 
 	odb_source_free(&source->base);
 }

-- 
2.55.0.407.g700c83d4f3.dirty

