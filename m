Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257B433E34E
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 08:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780302053; cv=none; b=M5nW/T0qR0vXLTpd5zqP0Ur6iPipKYZxiAcKuY7/8zsmcW+X0vUrq761x+9J0jGlfqpCU/x+JJ0cbeIye5KPQLACzZId/crZ8pNf+GapLGg/lOL+cyq/N4e+4BKgCaOxmtOPmUtYut4hMBZz1p8Is7AIL/oJkz1oLn2WChe6w3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780302053; c=relaxed/simple;
	bh=4klYrJYhsAXqGk8rjIMSxEQo3Ejx7M4enxlL3BZxIQI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PwRgNGDmCoenjrN6Q7I/N90V2Tiy55/yBnrCg5oc+jgHmhDayuEtLwvpFeewsmPNG20zsYzESjfC2FCeILEgRml/B/AqDgw4j810fEKcx5H3U0brFnJGl1aG5jiSH3oQnCW2tDgVIejZ9la9NCYPVpc3i3JR0iv5+W/cHzPPedk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VpCXvNGM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JlRCCsuq; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VpCXvNGM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JlRCCsuq"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 72895140004E;
	Mon,  1 Jun 2026 04:20:50 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 01 Jun 2026 04:20:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780302050;
	 x=1780388450; bh=yd/oOdvbX4r0DnzjpmkmH4JsLNrv1Yk82s3aN9Iy8pA=; b=
	VpCXvNGMPbEKEAo65OXVyxuhcwaQ46AOU1q9Mb77W2eQgRqgBuoOgh5vYDAVKFQS
	i90pdKtqpCPYh6oHmHks4Tyy8MWFGOZi48Cshk+eQlvD4WB85ONeWgilZXuqooD5
	LflYkqRVo12feHRkOMghJ0sf61aPqKYmMNNQTnSR62QyEupgJS41ojqlaSdfurUW
	AheaVJRyt2iNZpY+imLfsBHwwm3hNI+TDKbMk0lWch13uD8uUvcbQmQqSHhF7KsA
	pKR1zDn6NOSIRcGJxH2Zhlt+/LZlPjXqH3AcFJXELLRlg7BqO+SZ8+B5WZspm5AE
	KqkgRECjvhlDwsOhBT377g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780302050; x=
	1780388450; bh=yd/oOdvbX4r0DnzjpmkmH4JsLNrv1Yk82s3aN9Iy8pA=; b=J
	lRCCsuqbGXJi0vVdPnng851ctM42swNfSWbqEIrcSXcYQrNwzkTftgfWByBiOPeq
	dcgVuHZyYmkZmy1kmRQOJ3cM50sk8uyL9bElIJZc9JdFS5S7QnTPUm3uiw5DXq/F
	zMYTvqy2D9LBnPSuMD4bA/w6L6mqtNKz1sbxA7hP1agJqCQPvQLDZmwXZ9mloE9G
	9cPIP3jkJrGrvohFMVxiJniLaT1zNc+ifKIbqav13WiI7VLHysgqKTD0o+3kaJ2x
	750qgsK7REPtKThDriovZVxCXv1HrCujNNOOTHF5Bsv08A8cyfguLT+7Ia6yVi/J
	UURW1EGigRQifThIwtG5g==
X-ME-Sender: <xms:4kAdaqyRfPX80ICUAiL7kTtFiQq_Ph2z0e-lVlkh6HS5Kl-Og6nFew>
    <xme:4kAdasQtDrxm78ZybPZfh1dbQ2Hg2FeuujsYMigE-QAWU629BB_Cqtcvyw7mntiQA
    8D7n4uulv3Mte75mC58Egk0myDqWl1bBFGruTOx232JynbLALoWFQ>
X-ME-Received: <xmr:4kAdap-KICxyzw83-R3_OiZ8NYIhkyrmIzPHJfH_voSNEmJsM_3RGTDEHC34Rl6aWgktn54bJKptF9E5-okpnexXo7ysu7vJIoLDNVOUu75B>
X-ME-Proxy-Cause: dmFkZTGoVC3PWkC/M98GLpgwKSp8+X2EEbK9QrLPRCVzfq6z8mGb2cg1WSKI0P1YF6K99Q
    xKY18KC2TzQ71gWxrLtHBcpqPwInMMILQwQmN+IaQps5jv2t4yhm/OcWnxr3PAuKdie/5H
    xdZiEXHfq3CyGlKpLwv2vL5myW19uyY8AtAnQMD9jV84wJQFe0QGymylYpZQO++m8ND1Hj
    j7fjS2tB+vIBobG7JpZXtzobTDeXEGy6yi7zeMBs162gs+xcsIodAA21pY4HTX/IAVCIU8
    kOLzJFDG9r9Lr/xlbzdlHVCtb2SlM1MPmdQV95SWFIB7kaTFV8arUy82aX0eqGVCnq+Edv
    vIvZvzOyuBXNqtmer0PiHhOwxxYv8ntPN/559uEZAA1cEQFwtw5eqbiGIJHLCWg4fH6G6E
    mj/eSC4UwCRlcDD0nFqF0VTGlrtSzfMjVa5eMTs9A4OB9hpwRfvuPs3uItoSsYhKMcZDuv
    Ogrg1VyQ82wkx6188BZAv6y/Fq3hqW7TWN76dVm/7aHY/Mei15Gp/laQjt9/hfL7VDb+cz
    91+6aO/uaCDYLLuqyVijsDV+mFzaBq1ZV9cm36DB3wLPuFkAJsE2nr3vBtJABJ9mLQtj7Y
    pQC18WfGZEMFTbTuvOIvWivlrtuaPeqo8z/agSVhvhIrOgEg+nOJcL02vHYA
X-ME-Proxy: <xmx:4kAdaroo1NqBOaxbIgxJGcpGe77_oj-nT3fg0k-bJUp87L97beB7iQ>
    <xmx:4kAdaunwKooRsvOT9iyrQslyrHHFxkopiS_6HR5LVEF4i8NHUP7ITw>
    <xmx:4kAdaqLUHSuQWII2mwMFjnN2PzlN9xA5c9qvJ5sDhuvTdOsTcdEFDg>
    <xmx:4kAdarzHqYVOyrQSwAa1mXi21iZpEKc1OHQBcVjjIO3bu8imljmYZg>
    <xmx:4kAdauLlt6mhed_yigqU9R6XsJs6JEcoqx9I0eTA1YuaF-I7ok0QUixN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 04:20:49 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bdc44e61 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 1 Jun 2026 08:20:48 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 01 Jun 2026 10:20:31 +0200
Subject: [PATCH v2 08/18] odb/source-loose: wire up `for_each_object()`
 callback
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-b4-pks-odb-source-loose-v2-8-90ff159430af@pks.im>
References: <20260601-b4-pks-odb-source-loose-v2-0-90ff159430af@pks.im>
In-Reply-To: <20260601-b4-pks-odb-source-loose-v2-0-90ff159430af@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

Move `odb_source_loose_for_each_object()` and its associated helpers
from "object-file.c" into "odb/source-loose.c" and wire it up as the
`for_each_object()` callback of the loose source.

Again, as in the preceding commit, we are forced to expose a couple of
functions from "object-file.c" that are now used by both subsystems.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/cat-file.c |   5 +-
 object-file.c      | 299 +++--------------------------------------------------
 object-file.h      |  32 +++---
 odb/source-files.c |   2 +-
 odb/source-loose.c | 264 ++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 297 insertions(+), 305 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index d9fbad5358..2958fc5357 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -862,8 +862,9 @@ static void batch_each_object(struct batch_options *opt,
 	 */
 	odb_prepare_alternates(the_repository->objects);
 	for (source = the_repository->objects->sources; source; source = source->next) {
-		int ret = odb_source_loose_for_each_object(source, NULL, batch_one_object_oi,
-							   &payload, &opts);
+		struct odb_source_files *files = odb_source_files_downcast(source);
+		int ret = odb_source_for_each_object(&files->loose->base, NULL, batch_one_object_oi,
+						     &payload, &opts);
 		if (ret)
 			break;
 	}
diff --git a/object-file.c b/object-file.c
index adfb672493..157ecad3ea 100644
--- a/object-file.c
+++ b/object-file.c
@@ -22,7 +22,6 @@
 #include "odb.h"
 #include "odb/streaming.h"
 #include "odb/transaction.h"
-#include "oidtree.h"
 #include "pack.h"
 #include "packfile.h"
 #include "path.h"
@@ -31,12 +30,6 @@
 #include "tempfile.h"
 #include "tmp-objdir.h"
 
-/* The maximum size for an object header. */
-#define MAX_HEADER_LEN 32
-
-static struct oidtree *odb_source_loose_cache(struct odb_source *source,
-					      const struct object_id *oid);
-
 static int get_conv_flags(unsigned flags)
 {
 	if (flags & INDEX_RENORMALIZE)
@@ -164,12 +157,6 @@ int stream_object_signature(struct repository *r,
 	return !oideq(oid, &real_oid) ? -1 : 0;
 }
 
-static int quick_has_loose(struct odb_source_loose *loose,
-			   const struct object_id *oid)
-{
-	return !!oidtree_contains(odb_source_loose_cache(&loose->files->base, oid), oid);
-}
-
 /*
  * Map and close the given loose object fd. The path argument is used for
  * error reporting.
@@ -227,9 +214,9 @@ enum unpack_loose_header_result unpack_loose_header(git_zstream *stream,
 	return ULHR_TOO_LONG;
 }
 
-static void *unpack_loose_rest(git_zstream *stream,
-			       void *buffer, unsigned long size,
-			       const struct object_id *oid)
+void *unpack_loose_rest(git_zstream *stream,
+			void *buffer, unsigned long size,
+			const struct object_id *oid)
 {
 	size_t bytes = strlen(buffer) + 1, n;
 	unsigned char *buf = xmallocz(size);
@@ -343,149 +330,6 @@ int parse_loose_header(const char *hdr, struct object_info *oi)
 	return 0;
 }
 
-int read_object_info_from_path(struct odb_source_loose *loose,
-			       const char *path,
-			       const struct object_id *oid,
-			       struct object_info *oi,
-			       enum object_info_flags flags)
-{
-	int ret;
-	int fd;
-	unsigned long mapsize;
-	void *map = NULL;
-	git_zstream stream, *stream_to_end = NULL;
-	char hdr[MAX_HEADER_LEN];
-	unsigned long size_scratch;
-	enum object_type type_scratch;
-	struct stat st;
-
-	/*
-	 * If we don't care about type or size, then we don't
-	 * need to look inside the object at all. Note that we
-	 * do not optimize out the stat call, even if the
-	 * caller doesn't care about the disk-size, since our
-	 * return value implicitly indicates whether the
-	 * object even exists.
-	 */
-	if (!oi || (!oi->typep && !oi->sizep && !oi->contentp)) {
-		struct stat st;
-
-		if ((!oi || (!oi->disk_sizep && !oi->mtimep)) && (flags & OBJECT_INFO_QUICK)) {
-			ret = quick_has_loose(loose, oid) ? 0 : -1;
-			goto out;
-		}
-
-		if (lstat(path, &st) < 0) {
-			ret = -1;
-			goto out;
-		}
-
-		if (oi) {
-			if (oi->disk_sizep)
-				*oi->disk_sizep = st.st_size;
-			if (oi->mtimep)
-				*oi->mtimep = st.st_mtime;
-		}
-
-		ret = 0;
-		goto out;
-	}
-
-	fd = git_open(path);
-	if (fd < 0) {
-		if (errno != ENOENT)
-			error_errno(_("unable to open loose object %s"), oid_to_hex(oid));
-		ret = -1;
-		goto out;
-	}
-
-	if (fstat(fd, &st)) {
-		close(fd);
-		ret = -1;
-		goto out;
-	}
-
-	mapsize = xsize_t(st.st_size);
-	if (!mapsize) {
-		close(fd);
-		ret = error(_("object file %s is empty"), path);
-		goto out;
-	}
-
-	map = xmmap(NULL, mapsize, PROT_READ, MAP_PRIVATE, fd, 0);
-	close(fd);
-	if (!map) {
-		ret = -1;
-		goto out;
-	}
-
-	if (oi->disk_sizep)
-		*oi->disk_sizep = mapsize;
-	if (oi->mtimep)
-		*oi->mtimep = st.st_mtime;
-
-	stream_to_end = &stream;
-
-	switch (unpack_loose_header(&stream, map, mapsize, hdr, sizeof(hdr))) {
-	case ULHR_OK:
-		if (!oi->sizep)
-			oi->sizep = &size_scratch;
-		if (!oi->typep)
-			oi->typep = &type_scratch;
-
-		if (parse_loose_header(hdr, oi) < 0) {
-			ret = error(_("unable to parse %s header"), oid_to_hex(oid));
-			goto corrupt;
-		}
-
-		if (*oi->typep < 0)
-			die(_("invalid object type"));
-
-		if (oi->contentp) {
-			*oi->contentp = unpack_loose_rest(&stream, hdr, *oi->sizep, oid);
-			if (!*oi->contentp) {
-				ret = -1;
-				goto corrupt;
-			}
-		}
-
-		break;
-	case ULHR_BAD:
-		ret = error(_("unable to unpack %s header"),
-			    oid_to_hex(oid));
-		goto corrupt;
-	case ULHR_TOO_LONG:
-		ret = error(_("header for %s too long, exceeds %d bytes"),
-			    oid_to_hex(oid), MAX_HEADER_LEN);
-		goto corrupt;
-	}
-
-	ret = 0;
-
-corrupt:
-	if (ret && (flags & OBJECT_INFO_DIE_IF_CORRUPT))
-		die(_("loose object %s (stored in %s) is corrupt"),
-		    oid_to_hex(oid), path);
-
-out:
-	if (stream_to_end)
-		git_inflate_end(stream_to_end);
-	if (map)
-		munmap(map, mapsize);
-	if (oi) {
-		if (oi->sizep == &size_scratch)
-			oi->sizep = NULL;
-		if (oi->typep == &type_scratch)
-			oi->typep = NULL;
-		if (oi->delta_base_oid)
-			oidclr(oi->delta_base_oid, loose->base.odb->repo->hash_algo);
-		if (!ret)
-			oi->whence = OI_LOOSE;
-	}
-
-	return ret;
-}
-
 static void hash_object_body(const struct git_hash_algo *algo, struct git_hash_ctx *c,
 			     const void *buf, unsigned long len,
 			     struct object_id *oid,
@@ -1667,13 +1511,13 @@ int read_pack_header(int fd, struct pack_header *header)
 	return 0;
 }
 
-static int for_each_file_in_obj_subdir(unsigned int subdir_nr,
-				       struct strbuf *path,
-				       const struct git_hash_algo *algop,
-				       each_loose_object_fn obj_cb,
-				       each_loose_cruft_fn cruft_cb,
-				       each_loose_subdir_fn subdir_cb,
-				       void *data)
+int for_each_file_in_obj_subdir(unsigned int subdir_nr,
+				struct strbuf *path,
+				const struct git_hash_algo *algop,
+				each_loose_object_fn obj_cb,
+				each_loose_cruft_fn cruft_cb,
+				each_loose_subdir_fn subdir_cb,
+				void *data)
 {
 	size_t origlen, baselen;
 	DIR *dir;
@@ -1758,78 +1602,6 @@ int for_each_loose_file_in_source(struct odb_source *source,
 	return r;
 }
 
-struct for_each_object_wrapper_data {
-	struct odb_source_loose *loose;
-	const struct object_info *request;
-	odb_for_each_object_cb cb;
-	void *cb_data;
-};
-
-static int for_each_object_wrapper_cb(const struct object_id *oid,
-				      const char *path,
-				      void *cb_data)
-{
-	struct for_each_object_wrapper_data *data = cb_data;
-
-	if (data->request) {
-		struct object_info oi = *data->request;
-
-		if (read_object_info_from_path(data->loose, path, oid, &oi, 0) < 0)
-			return -1;
-
-		return data->cb(oid, &oi, data->cb_data);
-	} else {
-		return data->cb(oid, NULL, data->cb_data);
-	}
-}
-
-static int for_each_prefixed_object_wrapper_cb(const struct object_id *oid,
-					       void *node_data UNUSED,
-					       void *cb_data)
-{
-	struct for_each_object_wrapper_data *data = cb_data;
-	if (data->request) {
-		struct object_info oi = *data->request;
-
-		if (odb_source_read_object_info(&data->loose->base,
-						oid, &oi, 0) < 0)
-			return -1;
-
-		return data->cb(oid, &oi, data->cb_data);
-	} else {
-		return data->cb(oid, NULL, data->cb_data);
-	}
-}
-
-int odb_source_loose_for_each_object(struct odb_source *source,
-				     const struct object_info *request,
-				     odb_for_each_object_cb cb,
-				     void *cb_data,
-				     const struct odb_for_each_object_options *opts)
-{
-	struct odb_source_files *files = odb_source_files_downcast(source);
-	struct for_each_object_wrapper_data data = {
-		.loose = files->loose,
-		.request = request,
-		.cb = cb,
-		.cb_data = cb_data,
-	};
-
-	/* There are no loose promisor objects, so we can return immediately. */
-	if ((opts->flags & ODB_FOR_EACH_OBJECT_PROMISOR_ONLY))
-		return 0;
-	if ((opts->flags & ODB_FOR_EACH_OBJECT_LOCAL_ONLY) && !source->local)
-		return 0;
-
-	if (opts->prefix)
-		return oidtree_each(odb_source_loose_cache(source, opts->prefix),
-				    opts->prefix, opts->prefix_hex_len,
-				    for_each_prefixed_object_wrapper_cb, &data);
-
-	return for_each_loose_file_in_source(source, for_each_object_wrapper_cb,
-					     NULL, NULL, &data);
-}
-
 static int count_loose_object(const struct object_id *oid UNUSED,
 			      struct object_info *oi UNUSED,
 			      void *payload)
@@ -1843,6 +1615,7 @@ int odb_source_loose_count_objects(struct odb_source *source,
 				   enum odb_count_objects_flags flags,
 				   unsigned long *out)
 {
+	struct odb_source_files *files = odb_source_files_downcast(source);
 	const unsigned hexsz = source->odb->repo->hash_algo->hexsz - 2;
 	char *path = NULL;
 	DIR *dir = NULL;
@@ -1878,8 +1651,8 @@ int odb_source_loose_count_objects(struct odb_source *source,
 	} else {
 		struct odb_for_each_object_options opts = { 0 };
 		*out = 0;
-		ret = odb_source_loose_for_each_object(source, NULL, count_loose_object,
-						       out, &opts);
+		ret = odb_source_for_each_object(&files->loose->base, NULL, count_loose_object,
+						 out, &opts);
 	}
 
 out:
@@ -1910,6 +1683,7 @@ int odb_source_loose_find_abbrev_len(struct odb_source *source,
 				     unsigned min_len,
 				     unsigned *out)
 {
+	struct odb_source_files *files = odb_source_files_downcast(source);
 	struct odb_for_each_object_options opts = {
 		.prefix = oid,
 		.prefix_hex_len = min_len,
@@ -1920,54 +1694,13 @@ int odb_source_loose_find_abbrev_len(struct odb_source *source,
 	};
 	int ret;
 
-	ret = odb_source_loose_for_each_object(source, NULL, find_abbrev_len_cb,
-					       &data, &opts);
+	ret = odb_source_for_each_object(&files->loose->base, NULL, find_abbrev_len_cb,
+					 &data, &opts);
 	*out = data.len;
 
 	return ret;
 }
 
-static int append_loose_object(const struct object_id *oid,
-			       const char *path UNUSED,
-			       void *data)
-{
-	oidtree_insert(data, oid, NULL);
-	return 0;
-}
-
-static struct oidtree *odb_source_loose_cache(struct odb_source *source,
-					      const struct object_id *oid)
-{
-	struct odb_source_files *files = odb_source_files_downcast(source);
-	int subdir_nr = oid->hash[0];
-	struct strbuf buf = STRBUF_INIT;
-	size_t word_bits = bitsizeof(files->loose->subdir_seen[0]);
-	size_t word_index = subdir_nr / word_bits;
-	size_t mask = (size_t)1u << (subdir_nr % word_bits);
-	uint32_t *bitmap;
-
-	if (subdir_nr < 0 ||
-	    (size_t) subdir_nr >= bitsizeof(files->loose->subdir_seen))
-		BUG("subdir_nr out of range");
-
-	bitmap = &files->loose->subdir_seen[word_index];
-	if (*bitmap & mask)
-		return files->loose->cache;
-	if (!files->loose->cache) {
-		ALLOC_ARRAY(files->loose->cache, 1);
-		oidtree_init(files->loose->cache);
-	}
-	strbuf_addstr(&buf, source->path);
-	for_each_file_in_obj_subdir(subdir_nr, &buf,
-				    source->odb->repo->hash_algo,
-				    append_loose_object,
-				    NULL, NULL,
-				    files->loose->cache);
-	*bitmap |= mask;
-	strbuf_release(&buf);
-	return files->loose->cache;
-}
-
 static int check_stream_oid(git_zstream *stream,
 			    const char *hdr,
 			    unsigned long size,
diff --git a/object-file.h b/object-file.h
index d93b7ffad7..9ee5649220 100644
--- a/object-file.h
+++ b/object-file.h
@@ -6,6 +6,9 @@
 #include "odb.h"
 #include "odb/source-loose.h"
 
+/* The maximum size for an object header. */
+#define MAX_HEADER_LEN 32
+
 struct index_state;
 
 enum {
@@ -85,19 +88,13 @@ int for_each_loose_file_in_source(struct odb_source *source,
 				  each_loose_cruft_fn cruft_cb,
 				  each_loose_subdir_fn subdir_cb,
 				  void *data);
-
-/*
- * Iterate through all loose objects in the given object database source and
- * invoke the callback function for each of them. If an object info request is
- * given, then the object info will be read for every individual object and
- * passed to the callback as if `odb_source_loose_read_object_info()` was
- * called for the object.
- */
-int odb_source_loose_for_each_object(struct odb_source *source,
-				     const struct object_info *request,
-				     odb_for_each_object_cb cb,
-				     void *cb_data,
-				     const struct odb_for_each_object_options *opts);
+int for_each_file_in_obj_subdir(unsigned int subdir_nr,
+				struct strbuf *path,
+				const struct git_hash_algo *algop,
+				each_loose_object_fn obj_cb,
+				each_loose_cruft_fn cruft_cb,
+				each_loose_subdir_fn subdir_cb,
+				void *data);
 
 /*
  * Count the number of loose objects in this source.
@@ -188,12 +185,6 @@ int read_loose_object(struct repository *repo,
 		      void **contents,
 		      struct object_info *oi);
 
-int read_object_info_from_path(struct odb_source_loose *loose,
-			       const char *path,
-			       const struct object_id *oid,
-			       struct object_info *oi,
-			       enum object_info_flags flags);
-
 enum unpack_loose_header_result {
 	ULHR_OK,
 	ULHR_BAD,
@@ -217,6 +208,9 @@ enum unpack_loose_header_result unpack_loose_header(git_zstream *stream,
 						    unsigned long mapsize,
 						    void *buffer,
 						    unsigned long bufsiz);
+void *unpack_loose_rest(git_zstream *stream,
+			void *buffer, unsigned long size,
+			const struct object_id *oid);
 
 int parse_loose_header(const char *hdr, struct object_info *oi);
 
diff --git a/odb/source-files.c b/odb/source-files.c
index 90806ddf86..676a641739 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -82,7 +82,7 @@ static int odb_source_files_for_each_object(struct odb_source *source,
 	int ret;
 
 	if (!(opts->flags & ODB_FOR_EACH_OBJECT_PROMISOR_ONLY)) {
-		ret = odb_source_loose_for_each_object(source, request, cb, cb_data, opts);
+		ret = odb_source_for_each_object(&files->loose->base, request, cb, cb_data, opts);
 		if (ret)
 			return ret;
 	}
diff --git a/odb/source-loose.c b/odb/source-loose.c
index 4b82c6f316..4e8b923498 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -2,6 +2,7 @@
 #include "abspath.h"
 #include "chdir-notify.h"
 #include "gettext.h"
+#include "hex.h"
 #include "loose.h"
 #include "object-file.h"
 #include "odb.h"
@@ -9,8 +10,198 @@
 #include "odb/source-loose.h"
 #include "odb/streaming.h"
 #include "oidtree.h"
+#include "repository.h"
 #include "strbuf.h"
 
+static int append_loose_object(const struct object_id *oid,
+			       const char *path UNUSED,
+			       void *data)
+{
+	oidtree_insert(data, oid, NULL);
+	return 0;
+}
+
+static struct oidtree *odb_source_loose_cache(struct odb_source_loose *loose,
+					      const struct object_id *oid)
+{
+	int subdir_nr = oid->hash[0];
+	struct strbuf buf = STRBUF_INIT;
+	size_t word_bits = bitsizeof(loose->subdir_seen[0]);
+	size_t word_index = subdir_nr / word_bits;
+	size_t mask = (size_t)1u << (subdir_nr % word_bits);
+	uint32_t *bitmap;
+
+	if (subdir_nr < 0 ||
+	    (size_t) subdir_nr >= bitsizeof(loose->subdir_seen))
+		BUG("subdir_nr out of range");
+
+	bitmap = &loose->subdir_seen[word_index];
+	if (*bitmap & mask)
+		return loose->cache;
+	if (!loose->cache) {
+		ALLOC_ARRAY(loose->cache, 1);
+		oidtree_init(loose->cache);
+	}
+	strbuf_addstr(&buf, loose->base.path);
+	for_each_file_in_obj_subdir(subdir_nr, &buf,
+				    loose->base.odb->repo->hash_algo,
+				    append_loose_object,
+				    NULL, NULL,
+				    loose->cache);
+	*bitmap |= mask;
+	strbuf_release(&buf);
+	return loose->cache;
+}
+
+static int quick_has_loose(struct odb_source_loose *loose,
+			   const struct object_id *oid)
+{
+	return !!oidtree_contains(odb_source_loose_cache(loose, oid), oid);
+}
+
+static int read_object_info_from_path(struct odb_source_loose *loose,
+				      const char *path,
+				      const struct object_id *oid,
+				      struct object_info *oi,
+				      enum object_info_flags flags)
+{
+	int ret;
+	int fd;
+	unsigned long mapsize;
+	void *map = NULL;
+	git_zstream stream, *stream_to_end = NULL;
+	char hdr[MAX_HEADER_LEN];
+	unsigned long size_scratch;
+	enum object_type type_scratch;
+	struct stat st;
+
+	/*
+	 * If we don't care about type or size, then we don't
+	 * need to look inside the object at all. Note that we
+	 * do not optimize out the stat call, even if the
+	 * caller doesn't care about the disk-size, since our
+	 * return value implicitly indicates whether the
+	 * object even exists.
+	 */
+	if (!oi || (!oi->typep && !oi->sizep && !oi->contentp)) {
+		struct stat st;
+
+		if ((!oi || (!oi->disk_sizep && !oi->mtimep)) && (flags & OBJECT_INFO_QUICK)) {
+			ret = quick_has_loose(loose, oid) ? 0 : -1;
+			goto out;
+		}
+
+		if (lstat(path, &st) < 0) {
+			ret = -1;
+			goto out;
+		}
+
+		if (oi) {
+			if (oi->disk_sizep)
+				*oi->disk_sizep = st.st_size;
+			if (oi->mtimep)
+				*oi->mtimep = st.st_mtime;
+		}
+
+		ret = 0;
+		goto out;
+	}
+
+	fd = git_open(path);
+	if (fd < 0) {
+		if (errno != ENOENT)
+			error_errno(_("unable to open loose object %s"), oid_to_hex(oid));
+		ret = -1;
+		goto out;
+	}
+
+	if (fstat(fd, &st)) {
+		close(fd);
+		ret = -1;
+		goto out;
+	}
+
+	mapsize = xsize_t(st.st_size);
+	if (!mapsize) {
+		close(fd);
+		ret = error(_("object file %s is empty"), path);
+		goto out;
+	}
+
+	map = xmmap(NULL, mapsize, PROT_READ, MAP_PRIVATE, fd, 0);
+	close(fd);
+	if (!map) {
+		ret = -1;
+		goto out;
+	}
+
+	if (oi->disk_sizep)
+		*oi->disk_sizep = mapsize;
+	if (oi->mtimep)
+		*oi->mtimep = st.st_mtime;
+
+	stream_to_end = &stream;
+
+	switch (unpack_loose_header(&stream, map, mapsize, hdr, sizeof(hdr))) {
+	case ULHR_OK:
+		if (!oi->sizep)
+			oi->sizep = &size_scratch;
+		if (!oi->typep)
+			oi->typep = &type_scratch;
+
+		if (parse_loose_header(hdr, oi) < 0) {
+			ret = error(_("unable to parse %s header"), oid_to_hex(oid));
+			goto corrupt;
+		}
+
+		if (*oi->typep < 0)
+			die(_("invalid object type"));
+
+		if (oi->contentp) {
+			*oi->contentp = unpack_loose_rest(&stream, hdr, *oi->sizep, oid);
+			if (!*oi->contentp) {
+				ret = -1;
+				goto corrupt;
+			}
+		}
+
+		break;
+	case ULHR_BAD:
+		ret = error(_("unable to unpack %s header"),
+			    oid_to_hex(oid));
+		goto corrupt;
+	case ULHR_TOO_LONG:
+		ret = error(_("header for %s too long, exceeds %d bytes"),
+			    oid_to_hex(oid), MAX_HEADER_LEN);
+		goto corrupt;
+	}
+
+	ret = 0;
+
+corrupt:
+	if (ret && (flags & OBJECT_INFO_DIE_IF_CORRUPT))
+		die(_("loose object %s (stored in %s) is corrupt"),
+		    oid_to_hex(oid), path);
+
+out:
+	if (stream_to_end)
+		git_inflate_end(stream_to_end);
+	if (map)
+		munmap(map, mapsize);
+	if (oi) {
+		if (oi->sizep == &size_scratch)
+			oi->sizep = NULL;
+		if (oi->typep == &type_scratch)
+			oi->typep = NULL;
+		if (oi->delta_base_oid)
+			oidclr(oi->delta_base_oid, loose->base.odb->repo->hash_algo);
+		if (!ret)
+			oi->whence = OI_LOOSE;
+	}
+
+	return ret;
+}
+
 static int odb_source_loose_read_object_info(struct odb_source *source,
 					     const struct object_id *oid,
 					     struct object_info *oi,
@@ -218,6 +409,78 @@ static int odb_source_loose_read_object_stream(struct odb_read_stream **out,
 	return -1;
 }
 
+struct for_each_object_wrapper_data {
+	struct odb_source_loose *loose;
+	const struct object_info *request;
+	odb_for_each_object_cb cb;
+	void *cb_data;
+};
+
+static int for_each_object_wrapper_cb(const struct object_id *oid,
+				      const char *path,
+				      void *cb_data)
+{
+	struct for_each_object_wrapper_data *data = cb_data;
+
+	if (data->request) {
+		struct object_info oi = *data->request;
+
+		if (read_object_info_from_path(data->loose, path, oid, &oi, 0) < 0)
+			return -1;
+
+		return data->cb(oid, &oi, data->cb_data);
+	} else {
+		return data->cb(oid, NULL, data->cb_data);
+	}
+}
+
+static int for_each_prefixed_object_wrapper_cb(const struct object_id *oid,
+					       void *node_data UNUSED,
+					       void *cb_data)
+{
+	struct for_each_object_wrapper_data *data = cb_data;
+	if (data->request) {
+		struct object_info oi = *data->request;
+
+		if (odb_source_read_object_info(&data->loose->base,
+						oid, &oi, 0) < 0)
+			return -1;
+
+		return data->cb(oid, &oi, data->cb_data);
+	} else {
+		return data->cb(oid, NULL, data->cb_data);
+	}
+}
+
+static int odb_source_loose_for_each_object(struct odb_source *source,
+					    const struct object_info *request,
+					    odb_for_each_object_cb cb,
+					    void *cb_data,
+					    const struct odb_for_each_object_options *opts)
+{
+	struct odb_source_loose *loose = odb_source_loose_downcast(source);
+	struct for_each_object_wrapper_data data = {
+		.loose = loose,
+		.request = request,
+		.cb = cb,
+		.cb_data = cb_data,
+	};
+
+	/* There are no loose promisor objects, so we can return immediately. */
+	if ((opts->flags & ODB_FOR_EACH_OBJECT_PROMISOR_ONLY))
+		return 0;
+	if ((opts->flags & ODB_FOR_EACH_OBJECT_LOCAL_ONLY) && !source->local)
+		return 0;
+
+	if (opts->prefix)
+		return oidtree_each(odb_source_loose_cache(loose, opts->prefix),
+				    opts->prefix, opts->prefix_hex_len,
+				    for_each_prefixed_object_wrapper_cb, &data);
+
+	return for_each_loose_file_in_source(source, for_each_object_wrapper_cb,
+					     NULL, NULL, &data);
+}
+
 static void odb_source_loose_clear_cache(struct odb_source_loose *loose)
 {
 	oidtree_clear(loose->cache);
@@ -273,6 +536,7 @@ struct odb_source_loose *odb_source_loose_new(struct odb_source_files *files)
 	loose->base.reprepare = odb_source_loose_reprepare;
 	loose->base.read_object_info = odb_source_loose_read_object_info;
 	loose->base.read_object_stream = odb_source_loose_read_object_stream;
+	loose->base.for_each_object = odb_source_loose_for_each_object;
 
 	if (!is_absolute_path(loose->base.path))
 		chdir_notify_register(NULL, odb_source_loose_reparent, loose);

-- 
2.54.0.926.g75ba10bac6.dirty

