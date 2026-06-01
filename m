Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D49538A736
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 08:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780302067; cv=none; b=ktxeCVvqqk2zT528I/Evj+E3qEqiewxHu9h1EAaiSBtWESFIsbsxqDwEZqCQRWLxgnrIue7qKkE8ph+ea0YC9ytdu0AzD+SNbkE9UFnhHKZKL0lJDAyHxDxXW76t9BF4AMp+2KDddEVc5diK3u+q2ACIVK6EeYlA/s6jABfAWgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780302067; c=relaxed/simple;
	bh=46WCSRzj8gFO0CciVqOltkypQ8vOUiT7WtdGFIaft0g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LDW/EkBFfzHBcHmJ69l0PNsa+sHe6JSK+FbcsUzZ2r4eepKHytUUi5RhTLE/HsZTBOxQaxMx3b9UBdUfperIbFmuen03EL54eGrj/MW882hAGkEKdZhrlA0EN5P3j0rbcRAAv4BJ+eSEOcH8vT9+vMsfowo5ps0EAEwJr+qKLVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tJWn/+gM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Cj841wE5; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tJWn/+gM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Cj841wE5"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 7E21FEC0090;
	Mon,  1 Jun 2026 04:21:05 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 01 Jun 2026 04:21:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780302065;
	 x=1780388465; bh=9xyHItLc4FMz3WraDsxPD7uaDI6fEn0VKuexvn2DbM4=; b=
	tJWn/+gMdoLJxAp9ho8oSa9iKzRn/7ZpmISSDBm4Vfg394vKNakblm6ghIjO/KRB
	BG389XlrKP9Dl/XTfXEw9bmdX/4IrWWPJqP/iUsWGz6X6mdpukSQuB8/KHBeTus5
	7fTwIclCduxUQYPa0BsV3OTEle7Kjql6c5DBaVekZ3h09TNpJcgrzStqKYGx/uMM
	6qR0gAZVehwUoy7a/javQdHxtkynDKEjqRAgsO5gE6m5j0I4mGlYHeqgJnOkxpiK
	NEQZkdX+Pw/jOtgjwcmVISG5mfKfIzg7QPTLZM9OwNlQQQ9LSZ0M/FruNTpDQVob
	cINKLyfPaUOaybw+l2ws+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780302065; x=
	1780388465; bh=9xyHItLc4FMz3WraDsxPD7uaDI6fEn0VKuexvn2DbM4=; b=C
	j841wE5VTnRSTnOdRApOP5BECkmxKOSsjjyrfGIfwGCcMa6Aq3SwMYwu5jUGozOj
	AI255OiO+AjrUAuVX4pooZEc8uWlGLoPSE6e6LaKk14kuvCD+FZy/WF6btNaeBKe
	KuMLRcKUIGgi3jITj89rhn75hRukX4Uswfk4t1M+UD2AhqxzWiewwTyKCPKeFXuc
	eyq86qzhZ6IOke9vYgsA1Nglz4PgR4NEYEUJfuCugAdnptM4pbgarJoP2YUDzSsP
	4pKbCNgczvyUqGWHvXUONdtCU1ucqmUljCoCF8bZ91DyZdeHq2tjfb5QOB3a0LZc
	ur4A2Ar9arixxwz+OMuNQ==
X-ME-Sender: <xms:8UAdahQpOuchfxzNyP4LAxK1Mpk33rlbC-NlLJVMQoyuQwLMRUVxTA>
    <xme:8UAdagwVr8M7ziFE7IQCCnSiWJGtjEPn2vA5KHAWgYa0MB3u7aSg461lmeRSyxB3K
    XfDOtXIMs0LFyUvojQJs-aa1hiElE1U_x6dZ04YQLAUbkAS7OjuEA>
X-ME-Received: <xmr:8UAdake0zaFpTTpbKaqRstdqCwa1x9TEVd4eR5T0E3SxeWltsdUG-3PFPvDoatVMQtq5vuHuhatlZTLTRgphAqCzIYZT8_vlGtGGcni0TOrg>
X-ME-Proxy-Cause: dmFkZTGoVC3PWkC/M98GLpgwKSp8+X2EEbK9QrLPRCVzfq6z8mGb2cg1WSKI0P1YF6K99Q
    xKY18KC2TzQ71gWxrLtHBcpqPwInMMILQwQmN+IaQps5jv2t4yhm/OcWnxr3PAuKdie/5H
    xdZiEXHfq3CyGlKpLwv2vL5myW19uyY8AtAnQMD9jV84wJQFe0QGymylYpZQO++m8ND1Hj
    j7fjS2tB+vIBobG7JpZXtzobTDeXEGy6yi7zeMBs162gs+xcsIodAA21pY4HTX/IAVCIU8
    kOLzJFDG9r9Lr/xlbzdlHVCtb2SlM1MPmdQV95SWFIB7kaTFV8arUy82aX0eqGVCnq+ET4
    Ld28+qOIFpN0OLDOS25ZIb6Xx1Whj7TJOWG2VqEf3W85AA+4qxdrwyCARGrvfDICXIUFu9
    3e9B7CvLD+i7MwybABVr9GdFc8u0GR18LgaMvdpPw4IK0uTPeyqY5WyGN+pZrrPdzZQIIh
    /4/X3TZ2RaZFJA+V5S5dbzMoZENuO6XxrfxuAb2K3BEpPjgq8Vmv3Wo51Pw91cRMI/guGk
    31UP5JCx0kqrksRRHNlS6rojqYUfjD/LOaqLwqSNqdiwU9UgEMt/xoBHVqDE9ePsR0uJhl
    y2g3XpqsSaDZXjVBwh7aKgbcxyi0dFhqb6ojkSduGIjyQoP8kXAGZFsKTMlQ
X-ME-Proxy: <xmx:8UAdakLV25_iAMOPq5d3vB3j0dWcY4aGA1fDuLt_NJsSJiWngPgc2A>
    <xmx:8UAdatGW0VCrPJWJJkkwVaBrX2LAoXQwT8lwB69pvqeE3lp53aGGzA>
    <xmx:8UAdamroAJsV9UeNAMtMJ5shYO1zFR-d5D4ML1vZ5t1Yp_If66YMzQ>
    <xmx:8UAdauTjftnfas9laqbm_fx80ECgZzCbs3_nCwAxbLZSEsbOG1riJw>
    <xmx:8UAdakpRXYXKsD9HikGWQSfe4Tsok7vIEJP1otUflYXHPqP55B8UCzZ5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 04:21:04 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4d75e6d5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 1 Jun 2026 08:21:03 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 01 Jun 2026 10:20:37 +0200
Subject: [PATCH v2 14/18] odb/source-loose: wire up `write_object()`
 callback
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-b4-pks-odb-source-loose-v2-14-90ff159430af@pks.im>
References: <20260601-b4-pks-odb-source-loose-v2-0-90ff159430af@pks.im>
In-Reply-To: <20260601-b4-pks-odb-source-loose-v2-0-90ff159430af@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

Move `odb_source_loose_write_object()` from "object-file.c" into
"odb/source-loose.c" and wire it up as the `write_object()` callback of
the loose source.

As in preceding commits, this requires us to expose a couple of generic
functions from "object-file.c" as they are used in both subsystems now.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c      | 58 ++++++++----------------------------------------------
 object-file.h      | 14 +++++++------
 odb/source-files.c |  5 +++--
 odb/source-loose.c | 44 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 63 insertions(+), 58 deletions(-)

diff --git a/object-file.c b/object-file.c
index fe24f00d1b..7bb5b31bca 100644
--- a/object-file.c
+++ b/object-file.c
@@ -326,10 +326,10 @@ static void hash_object_body(const struct git_hash_algo *algo, struct git_hash_c
 	git_hash_final_oid(oid, c);
 }
 
-static void write_object_file_prepare(const struct git_hash_algo *algo,
-				      const void *buf, unsigned long len,
-				      enum object_type type, struct object_id *oid,
-				      char *hdr, int *hdrlen)
+void write_object_file_prepare(const struct git_hash_algo *algo,
+			       const void *buf, unsigned long len,
+			       enum object_type type, struct object_id *oid,
+			       char *hdr, int *hdrlen)
 {
 	struct git_hash_ctx c;
 
@@ -746,10 +746,10 @@ static int end_loose_object_common(struct odb_source *source,
 	return Z_OK;
 }
 
-static int write_loose_object(struct odb_source *source,
-			      const struct object_id *oid, char *hdr,
-			      int hdrlen, const void *buf, unsigned long len,
-			      time_t mtime, unsigned flags)
+int write_loose_object(struct odb_source *source,
+		       const struct object_id *oid, char *hdr,
+		       int hdrlen, const void *buf, unsigned long len,
+		       time_t mtime, unsigned flags)
 {
 	int fd, ret;
 	unsigned char compressed[4096];
@@ -926,48 +926,6 @@ int odb_source_loose_write_stream(struct odb_source *source,
 	return err;
 }
 
-int odb_source_loose_write_object(struct odb_source *source,
-				  const void *buf, unsigned long len,
-				  enum object_type type, struct object_id *oid,
-				  struct object_id *compat_oid_in,
-				  enum odb_write_object_flags flags)
-{
-	struct odb_source_files *files = odb_source_files_downcast(source);
-	const struct git_hash_algo *algo = source->odb->repo->hash_algo;
-	const struct git_hash_algo *compat = source->odb->repo->compat_hash_algo;
-	struct object_id compat_oid;
-	char hdr[MAX_HEADER_LEN];
-	int hdrlen = sizeof(hdr);
-
-	/* Generate compat_oid */
-	if (compat) {
-		if (compat_oid_in)
-			oidcpy(&compat_oid, compat_oid_in);
-		else if (type == OBJ_BLOB)
-			hash_object_file(compat, buf, len, type, &compat_oid);
-		else {
-			struct strbuf converted = STRBUF_INIT;
-			convert_object_file(source->odb->repo, &converted, algo, compat,
-					    buf, len, type, 0);
-			hash_object_file(compat, converted.buf, converted.len,
-					 type, &compat_oid);
-			strbuf_release(&converted);
-		}
-	}
-
-	/* Normally if we have it in the pack then we do not bother writing
-	 * it out into .git/objects/??/?{38} file.
-	 */
-	write_object_file_prepare(algo, buf, len, type, oid, hdr, &hdrlen);
-	if (odb_freshen_object(source->odb, oid))
-		return 0;
-	if (write_loose_object(source, oid, hdr, hdrlen, buf, len, 0, flags))
-		return -1;
-	if (compat)
-		return repo_add_loose_object_map(files->loose, oid, &compat_oid);
-	return 0;
-}
-
 int force_object_loose(struct odb_source *source,
 		       const struct object_id *oid, time_t mtime)
 {
diff --git a/object-file.h b/object-file.h
index 1d90df9d98..2b32592de1 100644
--- a/object-file.h
+++ b/object-file.h
@@ -23,12 +23,6 @@ int index_path(struct index_state *istate, struct object_id *oid, const char *pa
 struct object_info;
 struct odb_source;
 
-int odb_source_loose_write_object(struct odb_source *source,
-				  const void *buf, unsigned long len,
-				  enum object_type type, struct object_id *oid,
-				  struct object_id *compat_oid_in,
-				  enum odb_write_object_flags flags);
-
 int odb_source_loose_write_stream(struct odb_source *source,
 				  struct odb_write_stream *stream, size_t len,
 				  struct object_id *oid);
@@ -129,6 +123,14 @@ int finalize_object_file_flags(struct repository *repo,
 void hash_object_file(const struct git_hash_algo *algo, const void *buf,
 		      unsigned long len, enum object_type type,
 		      struct object_id *oid);
+void write_object_file_prepare(const struct git_hash_algo *algo,
+			       const void *buf, unsigned long len,
+			       enum object_type type, struct object_id *oid,
+			       char *hdr, int *hdrlen);
+int write_loose_object(struct odb_source *source,
+		       const struct object_id *oid, char *hdr,
+		       int hdrlen, const void *buf, unsigned long len,
+		       time_t mtime, unsigned flags);
 
 /* Helper to check and "touch" a file */
 int check_and_freshen_file(const char *fn, int freshen);
diff --git a/odb/source-files.c b/odb/source-files.c
index ef548e6fe6..52ba04237a 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -164,8 +164,9 @@ static int odb_source_files_write_object(struct odb_source *source,
 					 struct object_id *compat_oid,
 					 enum odb_write_object_flags flags)
 {
-	return odb_source_loose_write_object(source, buf, len, type,
-					     oid, compat_oid, flags);
+	struct odb_source_files *files = odb_source_files_downcast(source);
+	return odb_source_write_object(&files->loose->base, buf, len, type,
+				       oid, compat_oid, flags);
 }
 
 static int odb_source_files_write_object_stream(struct odb_source *source,
diff --git a/odb/source-loose.c b/odb/source-loose.c
index e519365d23..c91018109e 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -5,6 +5,7 @@
 #include "hex.h"
 #include "loose.h"
 #include "object-file.h"
+#include "object-file-convert.h"
 #include "odb.h"
 #include "odb/source-files.h"
 #include "odb/source-loose.h"
@@ -588,6 +589,48 @@ static int odb_source_loose_freshen_object(struct odb_source *source,
 	return !!check_and_freshen_file(path.buf, 1);
 }
 
+static int odb_source_loose_write_object(struct odb_source *source,
+					 const void *buf, unsigned long len,
+					 enum object_type type, struct object_id *oid,
+					 struct object_id *compat_oid_in,
+					 enum odb_write_object_flags flags)
+{
+	struct odb_source_loose *loose = odb_source_loose_downcast(source);
+	const struct git_hash_algo *algo = source->odb->repo->hash_algo;
+	const struct git_hash_algo *compat = source->odb->repo->compat_hash_algo;
+	struct object_id compat_oid;
+	char hdr[MAX_HEADER_LEN];
+	int hdrlen = sizeof(hdr);
+
+	/* Generate compat_oid */
+	if (compat) {
+		if (compat_oid_in)
+			oidcpy(&compat_oid, compat_oid_in);
+		else if (type == OBJ_BLOB)
+			hash_object_file(compat, buf, len, type, &compat_oid);
+		else {
+			struct strbuf converted = STRBUF_INIT;
+			convert_object_file(source->odb->repo, &converted, algo, compat,
+					    buf, len, type, 0);
+			hash_object_file(compat, converted.buf, converted.len,
+					 type, &compat_oid);
+			strbuf_release(&converted);
+		}
+	}
+
+	/* Normally if we have it in the pack then we do not bother writing
+	 * it out into .git/objects/??/?{38} file.
+	 */
+	write_object_file_prepare(algo, buf, len, type, oid, hdr, &hdrlen);
+	if (odb_freshen_object(source->odb, oid))
+		return 0;
+	if (write_loose_object(source, oid, hdr, hdrlen, buf, len, 0, flags))
+		return -1;
+	if (compat)
+		return repo_add_loose_object_map(loose, oid, &compat_oid);
+	return 0;
+}
+
 static void odb_source_loose_clear_cache(struct odb_source_loose *loose)
 {
 	oidtree_clear(loose->cache);
@@ -647,6 +690,7 @@ struct odb_source_loose *odb_source_loose_new(struct odb_source_files *files)
 	loose->base.find_abbrev_len = odb_source_loose_find_abbrev_len;
 	loose->base.count_objects = odb_source_loose_count_objects;
 	loose->base.freshen_object = odb_source_loose_freshen_object;
+	loose->base.write_object = odb_source_loose_write_object;
 
 	if (!is_absolute_path(loose->base.path))
 		chdir_notify_register(NULL, odb_source_loose_reparent, loose);

-- 
2.54.0.926.g75ba10bac6.dirty

