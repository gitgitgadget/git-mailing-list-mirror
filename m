Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BAE2AE7A
	for <git@vger.kernel.org>; Wed, 19 Aug 2026 12:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787141883; cv=none; b=RkIjuPBMgPRThJNeMfLEh/tbGFNR/o1a3Fsqg+YocJ7/K5MRDvDLOoLtRxjTfrIprdccG4xNk1enMFXGrioCJRSTDWyQiGlAcNlRf3Ph8qlrbsNy8rZk54NtddOUNwbZeQ9xN8C9IxgUdiExRdErEyVmgwSS9RAKOY1EVW3uiwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787141883; c=relaxed/simple;
	bh=mts2i1R6icSDT8vALBQid2++1sNuG0kExAUb0sGCx60=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iNrOBGIFIQ7U8+6sxAj/GV/1BeO9Mq9KYTz1C1HPmc8lff2MPlZ/16dzze/SUNnIR8rc7mb3QF+fub42iv1+6dK7tHvnAViegxEB5vYJMTSiZEdfFtIqCeolb1C44CQYS/CW3nL7c05Clv0xTxwPLytsF7q6xerS2XMoV30sTcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VP7h722/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Vmv26/VQ; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VP7h722/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Vmv26/VQ"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5873E14001AD;
	Wed, 19 Aug 2026 08:18:00 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 19 Aug 2026 08:18:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787141880;
	 x=1787228280; bh=wh7FfhdiAW6Oexkjk8hi12OeRITD6yp7gP/d2JqWctM=; b=
	VP7h722/K62kMoj0ObfsjVg3OXIHuQw2QLL2um9DeGXmtu2Qqa1YkalIWVpjopuD
	oln70pvfsxILsCRs2JtOi+DCv6JpUSNxKFSUrOI+CqtD2FOMZTXV5SDFM6zPqUTi
	7XdLNFA1C+0KOzqvpiYabiPF6LXgv/s/a1Fgj5/K4BsAf2btQ5zHBUvM926qifzB
	9Vbd5p+R7qP/1D/0m7RX+7lER6ozKRgmt7IJdqoTm9I3+RIyEcqNKa1fqMFwXKt4
	65IK81knXtgvzqcqMUa3F0CIN91RKrNFC5P9/FmnHBbuJPDM2Zj6c008snsEiu7W
	5D12GvK3K+R7u2t+Uisqzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787141880; x=
	1787228280; bh=wh7FfhdiAW6Oexkjk8hi12OeRITD6yp7gP/d2JqWctM=; b=V
	mv26/VQwn+p8KYQlDv7Cf8xXIoNiryXV/f2H/J5j5nOJBLXV0TlAhZgzt4WFtn57
	PIr6WMGvi5pd/QquDkEezmolFR38kxPy87SpKc9TCOUJ2Txj6bX0v86qRD3bLfqT
	R6yW7BoYmJrtw6CT+U7/gFMdGNXdmKsCZRbpykNZIiSKVcskQPfCu/XTT5wOOHKm
	Uit9Ia7odSyTdrL8phCmk+DKVmhkc0YCBHG4TGvBpI7k3RIwNVrz6beidvhtV/cR
	pN2xbOPfI4Q/fHOBE5EXAFkf/hna8OI+oCj8mjjMnl/BrB+TFmDtw5PI+f/ZfckY
	VKHFSVXqUVhNaFoygqZ+A==
X-ME-Sender: <xms:-J6Faud-lj5rnNfOnaygbVduVlwfdYLHgwaDPUQ4BjhgH_zCn9CYlw>
    <xme:-J6FauMxnwO8H8nwqjVfgEXrUQC9U6qmy5B3sHAIceJjPzBtZqEUtK-rAsAN73oUT
    CXlTfqfWbPhYXNQ-AChTM5RwsF47hKx8KgqAYkfQlxhWxb5bk0U>
X-ME-Received: <xmr:-J6FatIlJ50w2gkqMY1Lven2uBt0yF7t3pWs-67w_dHKn12WGxYwWLdxp7abuYfNwhhCaegVGMgHaUV6YD5jGT_t9-PWWs1sAC3bmANI>
X-ME-Proxy-Cause: dmFkZTF5mvSyHAwZNZEJLvdRLYwrNd6nj3F/OPlsiVb/McU7FBZtMInkPMxcRjhwRSPFHL
    WUm0rG0cjgDwa2Gh6qh1SLgIou2chAX5ZgP/1gXUR1vcTnXZvTU9haB+ZjXfR8PqHoV0mT
    yFCQgjenzzujCx6/VUrwAF3/Qro1c+XMYk7AFBZaoY+ewAjIUq/HO0s5BtCKKXPFns/It8
    9sbenjmEVzlOv2FYEUi3TWaQBHwTcUixH6KM2lD6Gst0FYYVriPig0bbHUyLXvDoARD92l
    wnFFv5vVxy1k7xYdbg/KUyIUF72UNvwF6UgqIcOBqHw9pklODFjYS4gk3zOO4KzbW4WhO3
    DOB4GQmwZgIcAKF/hpmNEoWRlNys19s/1w46SNP6cHFeH2EZRbrn7/+eSJvxRjX4elT/Lf
    UxbKjpjAfigi25mSSu+qARaJ0lYSuXrgydcqqXmKaF3UsvGSIP/RPDUNdz7Q3Qqg50RfMh
    vBFRuxlG0/LjUabB/0yj2xmrfv/46VztVth1fFyvgN+fIyhCnTBSO3MBZZ3aHRftVJx0fn
    krLzzmDLbRPbMyrR+4cFvDVv68NMO+wkT0A3OaXH90417UZNL4/Zp3aJnv5WvN/yLfCZGz
    izSuBjEFPIsvWHq73WG910A9ZJxb91DlAKfGnyGGRC4Fzjy5CxuLXlT7rZKg
X-ME-Proxy: <xmx:-J6FanEPGDc9B4i9IRXUVSD5eGUpsfKRasB_nAMuoIAFvawxnuecrg>
    <xmx:-J6FatSWEDd3QZsywoyQCOFQPGGlDr_TpSRWM-yEdKwATzOGRHLVew>
    <xmx:-J6FarGbmtq9P0WsVYscF0fitCiLZkQ3J3ZxNfMmYZCX0ksufU9-1w>
    <xmx:-J6Fah8DdtzFG13oz0dMZvejUHEorPfS2QfmHBmM_i1V7-l4ErzZwg>
    <xmx:-J6Fap0M8LM3dvLptP7nPP3TLErP1k9s_g9aijJ5OOeMP77jUZNwiO3t>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Aug 2026 08:17:59 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0517b9cc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 19 Aug 2026 12:17:58 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 19 Aug 2026 14:17:22 +0200
Subject: [PATCH v2 4/5] odb/source: allow `read_object_info()` to bubble up
 error messages
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-pks-odb-generic-corrupt-objects-v2-4-a984e3a0ad6f@pks.im>
References: <20260819-pks-odb-generic-corrupt-objects-v2-0-a984e3a0ad6f@pks.im>
In-Reply-To: <20260819-pks-odb-generic-corrupt-objects-v2-0-a984e3a0ad6f@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

When reading an object fails even though it exists, the sources know
best what exactly went wrong and where the corrupt object is located.
This information is lost though when bubbling up the error to the object
database layer, which forces that layer to reconstruct it after the
fact. This is exactly what `do_oid_object_info_extended()` does via
`has_packed_and_bad()`, but that function only really knows to handle
the "files" backend by reaching into its internals.

Introduce a new `errmsg` parameter for the `read_object_info()` callback
that sources are expected to populate with a human-readable message in
case reading the object has failed. Adapt the packed and loose sources
to populate the buffer with the messages that we ultimately want to
surface to the user.

For now, all callers are adapted to pass a `NULL` pointer. We will add a
user of this new infrastructure in a subsequent commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/pack-objects.c        |  6 +++---
 odb.c                         |  7 ++++---
 odb/source-files.c            |  9 ++++++---
 odb/source-inmemory.c         |  3 ++-
 odb/source-loose.c            | 23 +++++++++++++++--------
 odb/source-packed.c           | 34 ++++++++++++++++++++++++++--------
 odb/source.h                  | 18 ++++++++++++++----
 packfile.c                    |  2 +-
 t/unit-tests/u-odb-inmemory.c |  4 ++--
 9 files changed, 73 insertions(+), 33 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 10c2471024..399acd0f22 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1759,7 +1759,7 @@ static int want_object_in_pack_mtime(const struct object_id *oid,
 		struct odb_source *source = the_repository->objects->sources->next;
 		for (; source; source = source->next) {
 			struct odb_source_files *files = odb_source_files_downcast(source);
-			if (!odb_source_read_object_info(&files->loose->base, oid, NULL, 0))
+			if (!odb_source_read_object_info(&files->loose->base, oid, NULL, 0, NULL))
 				return 0;
 		}
 	}
@@ -4171,7 +4171,7 @@ static void add_cruft_object_entry(const struct object_id *oid, enum object_type
 
 			for (; !found && source; source = source->next) {
 				struct odb_source_files *files = odb_source_files_downcast(source);
-				if (!odb_source_read_object_info(&files->loose->base, oid, NULL, 0))
+				if (!odb_source_read_object_info(&files->loose->base, oid, NULL, 0, NULL))
 					found = 1;
 			}
 
@@ -4637,7 +4637,7 @@ static int force_object_loose(struct odb_source *source,
 
 	for (struct odb_source *s = source->odb->sources; s; s = s->next) {
 		struct odb_source_files *files = odb_source_files_downcast(s);
-		if (!odb_source_read_object_info(&files->loose->base, oid, NULL, 0))
+		if (!odb_source_read_object_info(&files->loose->base, oid, NULL, 0, NULL))
 			return 0;
 	}
 
diff --git a/odb.c b/odb.c
index 1b37b26376..83a53f7f6b 100644
--- a/odb.c
+++ b/odb.c
@@ -560,7 +560,7 @@ static enum odb_read_status do_oid_object_info_extended(struct object_database *
 	if (is_null_oid(real))
 		return -1;
 
-	if (!odb_source_read_object_info(odb->inmemory_objects, oid, oi, flags))
+	if (!odb_source_read_object_info(odb->inmemory_objects, oid, oi, flags, NULL))
 		return 0;
 
 	odb_prepare_alternates(odb);
@@ -569,7 +569,7 @@ static enum odb_read_status do_oid_object_info_extended(struct object_database *
 		struct odb_source *source;
 
 		for (source = odb->sources; source; source = source->next)
-			if (!odb_source_read_object_info(source, real, oi, flags))
+			if (!odb_source_read_object_info(source, real, oi, flags, NULL))
 				return 0;
 
 		/*
@@ -580,7 +580,8 @@ static enum odb_read_status do_oid_object_info_extended(struct object_database *
 		if (!(flags & OBJECT_INFO_QUICK)) {
 			for (source = odb->sources; source; source = source->next)
 				if (!odb_source_read_object_info(source, real, oi,
-								 flags | OBJECT_INFO_SECOND_READ))
+								 flags | OBJECT_INFO_SECOND_READ,
+								 NULL))
 					return 0;
 		}
 
diff --git a/odb/source-files.c b/odb/source-files.c
index e88fd1d399..aafba358e4 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -62,16 +62,19 @@ static void odb_source_files_prepare(struct odb_source *source,
 static enum odb_read_status odb_source_files_read_object_info(struct odb_source *source,
 							      const struct object_id *oid,
 							      struct object_info *oi,
-							      enum object_info_flags flags)
+							      enum object_info_flags flags,
+							      struct strbuf *errmsg)
 {
 	struct odb_source_files *files = odb_source_files_downcast(source);
 	enum odb_read_status ret_packed, ret_loose;
 
-	ret_packed = odb_source_read_object_info(&files->packed->base, oid, oi, flags);
+	ret_packed = odb_source_read_object_info(&files->packed->base, oid, oi,
+						 flags, errmsg);
 	if (!ret_packed)
 		return 0;
 
-	ret_loose = odb_source_read_object_info(&files->loose->base, oid, oi, flags);
+	ret_loose = odb_source_read_object_info(&files->loose->base, oid, oi, flags,
+						ret_packed == ODB_READ_NOT_FOUND ? errmsg : NULL);
 	if (!ret_loose)
 		return 0;
 
diff --git a/odb/source-inmemory.c b/odb/source-inmemory.c
index 3f3bd12de3..12f91e594a 100644
--- a/odb/source-inmemory.c
+++ b/odb/source-inmemory.c
@@ -59,7 +59,8 @@ static void populate_object_info(struct odb_source_inmemory *source,
 static enum odb_read_status odb_source_inmemory_read_object_info(struct odb_source *source,
 								 const struct object_id *oid,
 								 struct object_info *oi,
-								 enum object_info_flags flags UNUSED)
+								 enum object_info_flags flags UNUSED,
+								 struct strbuf *errmsg UNUSED)
 {
 	struct odb_source_inmemory *inmemory = odb_source_inmemory_downcast(source);
 	const struct inmemory_object *object;
diff --git a/odb/source-loose.c b/odb/source-loose.c
index 3c942a1069..b57ee2701a 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -67,7 +67,8 @@ static int read_object_info_from_path(struct odb_source_loose *loose,
 				      const char *path,
 				      const struct object_id *oid,
 				      struct object_info *oi,
-				      enum object_info_flags flags)
+				      enum object_info_flags flags,
+				      struct strbuf *errmsg)
 {
 	int ret;
 	int fd;
@@ -191,9 +192,14 @@ static int read_object_info_from_path(struct odb_source_loose *loose,
 	ret = 0;
 
 out:
-	if (ret && ret != ODB_READ_NOT_FOUND && (flags & OBJECT_INFO_DIE_IF_CORRUPT))
-		die(_("loose object %s (stored in %s) is corrupt"),
-		    oid_to_hex(oid), path);
+	if (ret && ret != ODB_READ_NOT_FOUND) {
+		if ((flags & OBJECT_INFO_DIE_IF_CORRUPT))
+			die(_("loose object %s (stored in %s) is corrupt"),
+			    oid_to_hex(oid), path);
+		if (errmsg)
+			strbuf_addf(errmsg, _("loose object %s (stored in %s) is corrupt"),
+				    oid_to_hex(oid), path);
+	}
 
 	if (stream_to_end)
 		git_inflate_end(stream_to_end);
@@ -216,7 +222,8 @@ static int read_object_info_from_path(struct odb_source_loose *loose,
 static enum odb_read_status odb_source_loose_read_object_info(struct odb_source *source,
 							      const struct object_id *oid,
 							      struct object_info *oi,
-							      enum object_info_flags flags)
+							      enum object_info_flags flags,
+							      struct strbuf *errmsg)
 {
 	struct odb_source_loose *loose = odb_source_loose_downcast(source);
 	static struct strbuf buf = STRBUF_INIT;
@@ -231,7 +238,7 @@ static enum odb_read_status odb_source_loose_read_object_info(struct odb_source
 		return ODB_READ_NOT_FOUND;
 
 	odb_loose_path(loose, &buf, oid);
-	return read_object_info_from_path(loose, buf.buf, oid, oi, flags);
+	return read_object_info_from_path(loose, buf.buf, oid, oi, flags, errmsg);
 }
 
 /*
@@ -428,7 +435,7 @@ static int for_each_object_wrapper_cb(const struct object_id *oid,
 	if (data->request) {
 		struct object_info oi = *data->request;
 
-		if (read_object_info_from_path(data->loose, path, oid, &oi, 0) < 0)
+		if (read_object_info_from_path(data->loose, path, oid, &oi, 0, NULL) < 0)
 			return -1;
 
 		return data->cb(oid, &oi, data->cb_data);
@@ -446,7 +453,7 @@ static int for_each_prefixed_object_wrapper_cb(const struct object_id *oid,
 		struct object_info oi = *data->request;
 
 		if (odb_source_read_object_info(&data->loose->base,
-						oid, &oi, 0) < 0)
+						oid, &oi, 0, NULL) < 0)
 			return -1;
 
 		return data->cb(oid, &oi, data->cb_data);
diff --git a/odb/source-packed.c b/odb/source-packed.c
index 9b19405380..1a12a605db 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -2,7 +2,9 @@
 #include "abspath.h"
 #include "chdir-notify.h"
 #include "dir.h"
+#include "gettext.h"
 #include "git-zlib.h"
+#include "hex.h"
 #include "list-objects-filter-options.h"
 #include "mergesort.h"
 #include "midx.h"
@@ -10,6 +12,7 @@
 #include "odb/streaming.h"
 #include "packfile.h"
 #include "pack-bitmap.h"
+#include "strbuf.h"
 
 static int find_pack_entry(struct odb_source_packed *store,
 			   const struct object_id *oid,
@@ -38,7 +41,8 @@ static int find_pack_entry(struct odb_source_packed *store,
 static enum odb_read_status odb_source_packed_read_object_info(struct odb_source *source,
 							       const struct object_id *oid,
 							       struct object_info *oi,
-							       enum object_info_flags flags)
+							       enum object_info_flags flags,
+							       struct strbuf *errmsg)
 {
 	struct odb_source_packed *packed = odb_source_packed_downcast(source);
 	struct packed_git *bad_pack = NULL;
@@ -59,25 +63,39 @@ static enum odb_read_status odb_source_packed_read_object_info(struct odb_source
 		 * corrupt in one of the packfiles. Report the object as
 		 * corrupt instead of missing in that case.
 		 */
-		if (bad_pack)
-			return -1;
-		return ODB_READ_NOT_FOUND;
+		if (bad_pack) {
+			ret = -1;
+			goto out;
+		}
+
+		ret = ODB_READ_NOT_FOUND;
+		goto out;
 	}
 
 	/*
 	 * We know that the caller doesn't actually need the
 	 * information below, so return early.
 	 */
-	if (!oi)
-		return 0;
+	if (!oi) {
+		ret = 0;
+		goto out;
+	}
 
 	ret = packed_object_info(packed, e.p, e.offset, oi);
 	if (ret < 0) {
+		bad_pack = e.p;
 		mark_bad_packed_object(e.p, oid);
-		return -1;
+		goto out;
 	}
 
-	return 0;
+	ret = 0;
+
+out:
+	if (ret < 0 && bad_pack && errmsg)
+		strbuf_addf(errmsg, _("packed object %s (stored in %s) is corrupt"),
+			    oid_to_hex(oid), bad_pack->pack_name);
+
+	return ret;
 }
 
 static int odb_source_packed_read_object_stream(struct odb_read_stream **out,
diff --git a/odb/source.h b/odb/source.h
index 7b8ff3d19d..4d13e4cfaf 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -27,6 +27,7 @@ enum odb_source_type {
 
 struct object_id;
 struct odb_read_stream;
+struct strbuf;
 struct strvec;
 
 /*
@@ -111,12 +112,16 @@ struct odb_source {
 	 *     already surfaced the object without reloading any on-disk state.
 	 *
 	 * The callback is expected to return an `enum odb_read_status`. Please
-	 * refer to the individual values that can be returned.
+	 * refer to the individual values that can be returned. In case reading
+	 * the object has failed with a generic error and `errmsg` is non-NULL,
+	 * the callback is expected to populate it with a human-readable
+	 * message that describes the failure.
 	 */
 	enum odb_read_status (*read_object_info)(struct odb_source *source,
 						 const struct object_id *oid,
 						 struct object_info *oi,
-						 enum object_info_flags flags);
+						 enum object_info_flags flags,
+						 struct strbuf *errmsg);
 
 	/*
 	 * This callback is expected to create a new read stream that can be
@@ -341,13 +346,18 @@ static inline void odb_source_prepare(struct odb_source *source,
 /*
  * Read an object from the object database source identified by its object ID.
  * Please refer to `enum odb_read_status` for the individual error codes.
+ *
+ * In case reading the object has failed with a generic error and `errmsg` is
+ * non-NULL it will be populated with a human-readable message that describes
+ * the failure.
  */
 static inline enum odb_read_status odb_source_read_object_info(struct odb_source *source,
 							       const struct object_id *oid,
 							       struct object_info *oi,
-							       enum object_info_flags flags)
+							       enum object_info_flags flags,
+							       struct strbuf *errmsg)
 {
-	return source->read_object_info(source, oid, oi, flags);
+	return source->read_object_info(source, oid, oi, flags, errmsg);
 }
 
 /*
diff --git a/packfile.c b/packfile.c
index 34e2f9bb8b..3cde39a01c 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1945,7 +1945,7 @@ int has_object_pack(struct repository *r, const struct object_id *oid)
 	odb_prepare_alternates(r->objects);
 	for (source = r->objects->sources; source; source = source->next) {
 		struct odb_source_files *files = odb_source_files_downcast(source);
-		if (!odb_source_read_object_info(&files->packed->base, oid, NULL, 0))
+		if (!odb_source_read_object_info(&files->packed->base, oid, NULL, 0, NULL))
 			return 1;
 	}
 
diff --git a/t/unit-tests/u-odb-inmemory.c b/t/unit-tests/u-odb-inmemory.c
index 3e5068080c..095c20ba91 100644
--- a/t/unit-tests/u-odb-inmemory.c
+++ b/t/unit-tests/u-odb-inmemory.c
@@ -29,7 +29,7 @@ static void cl_assert_object_info(struct odb_source_inmemory *source,
 		.contentp = &actual_content,
 	};
 
-	cl_must_pass(odb_source_read_object_info(&source->base, oid, &oi, 0));
+	cl_must_pass(odb_source_read_object_info(&source->base, oid, &oi, 0, NULL));
 	cl_assert_equal_u(actual_size, strlen(expected_content));
 	cl_assert_equal_u(actual_type, expected_type);
 	cl_assert_equal_s((char *) actual_content, expected_content);
@@ -72,7 +72,7 @@ void test_odb_inmemory__read_missing_object(void)
 	const char *end;
 
 	cl_must_pass(parse_oid_hex_algop(RANDOM_OID, &oid, &end, repo.hash_algo));
-	cl_assert_equal_i(odb_source_read_object_info(&source->base, &oid, NULL, 0),
+	cl_assert_equal_i(odb_source_read_object_info(&source->base, &oid, NULL, 0, NULL),
 			  ODB_READ_NOT_FOUND);
 
 	odb_source_free(&source->base);

-- 
2.55.0.822.g20453c30eb.dirty

