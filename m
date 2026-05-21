Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC2635E1AF
	for <git@vger.kernel.org>; Thu, 21 May 2026 08:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779351775; cv=none; b=g6B/Vf3s/e/fewb4PTP1c+PSPgYP6hXwt8Hg2VOKSjLmpDsKzcoQsO6SrRyKjDfVSKdvDdcE6DUsEkDH6a9I056mBSmcQeIVMyhWqtCC5SOxS39pqaoD7ADR5kV+Pw3hc2YORQVnB9GXrag5rT3fi7nmB0C2KTusIJE0tv9VvoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779351775; c=relaxed/simple;
	bh=4klYrJYhsAXqGk8rjIMSxEQo3Ejx7M4enxlL3BZxIQI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GwxYibPJGdVtBq5w4uW74bEYCF2/8zK/uoEakJxDRXpZH6NYLpQrddpOEbKKzclLCSZJGmjXDXYqbtX65YRJIUKLBeZqXkPI/Y8kIIt5gCWIDA66GBHxyhlTGlnC3mBchMYmcTq07UJcdL263Ou04rnpdjgs16FvEenoeIxJUBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kZPBLcKM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eUAGH8hK; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kZPBLcKM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eUAGH8hK"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 36C501400075
	for <git@vger.kernel.org>; Thu, 21 May 2026 04:22:52 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 21 May 2026 04:22:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779351772;
	 x=1779438172; bh=yd/oOdvbX4r0DnzjpmkmH4JsLNrv1Yk82s3aN9Iy8pA=; b=
	kZPBLcKMqezQhH3V//yd3U45nZn/rH5S4P0rJhhaP15RsK8kafJhTbY5lYEIaxtr
	8r0SfyVGBgOmozU+eedGhioHXaVILizncX5lAsFoq/HW0CK6jr+LE39pD3OK9jrq
	6rOV5hitYqGBEqcwteUy9VRsLDhpNl/RVTpJK9US6lhl4X0x6sJb4KG5prq0l/Ep
	mrMKjbGWE4irZqPEaUF7hrcCL3JtMy5jd8wcBJs8mcw6SkCbLQYhtI5wL3bKhu3j
	/HNQjXvYvcMybmHvOAtpwt23iqBsFEYFcKUaWRC4+R2Xj+G74vVu55KZ4dqCN/G6
	JfY/has+9JRqBjFC+WV8rQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779351772; x=
	1779438172; bh=yd/oOdvbX4r0DnzjpmkmH4JsLNrv1Yk82s3aN9Iy8pA=; b=e
	UAGH8hKakngSVhQhQLOtjqgjAy3RDH3x7lGF0DjdwN5W8Pikix/C8A1OzjdvwZ9f
	KwbqFEX1SAG0Y1sxTwDcpTuB39Ahxu0zG1Xe2aE6h4stZaTmEsWrpiKwmuqJy6Zf
	qHX+zlMJJesGutCOxIthtArWvfJSj3NeGHWSzCodfXCdKclC9hGT1wqRSbFmVb7T
	JQCHL7tmmkUPxfV2HRePLjXOpyZTLVBvdFgYYfFTaA1cM5OiGGvwVEKKAsHrGJXi
	u4labIKU3GCjJO6Ezrgd9qqjDVz3gwmuLyAH2grvYXytMZcF/3V1Qj6+ooXat8T4
	wovo1F5bHPqb27E25koew==
X-ME-Sender: <xms:3MAOatiN5XtU8ScdVYMX67J_etHwQahJ6EsRPweHMlyz6ZFoD4Jk4A>
    <xme:3MAOao-J7bfYQDeyLCg5bFLWLrq8Otv5ZNOudT8Nsy92Vbk_4jpemHMeL38-SLol6
    aQr9jmADMUMmyrR9Nrb2NeWezRiuKoYC7wkoo3pDkWx8fz8Yj1ANQ>
X-ME-Received: <xmr:3MAOait3sAdrh2xir_OeXU9TvWgIyng4_eVDN9D60J0rFKQspqBZzdfuU-HgHLSK8MtRj46PLDhxmsSkwtM81_7wtCxfauG3M2Sa9ltp9io>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeejtddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:3MAOanbgTF8cT3TocNdzYG0loVVee3Q7ehuKRX4KtiWJx0VMeLOz4A>
    <xmx:3MAOaqqLUodp_NtEieJV9-fEwBrLIR2nPdao1yj5DPE-eaVN22PFyA>
    <xmx:3MAOak8gA7Z5HgTqpq_yP-6h3n2IxkFskJcH76wFZP0LreTc9xALEQ>
    <xmx:3MAOah_FLqgoi9MYO4RGBMmiHMZnvX2tRGmDqtITAnZ4LipuxtvoqQ>
    <xmx:3MAOamg5siP9hFybnMWYu2eUxffwJEpSV62Pn-Rc61-Ei6tDsmoRQgVk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 21 May 2026 04:22:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 265d4bcb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 21 May 2026 08:22:50 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 21 May 2026 10:22:28 +0200
Subject: [PATCH 08/18] odb/source-loose: wire up `for_each_object()`
 callback
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-b4-pks-odb-source-loose-v1-8-6553b399be2d@pks.im>
References: <20260521-b4-pks-odb-source-loose-v1-0-6553b399be2d@pks.im>
In-Reply-To: <20260521-b4-pks-odb-source-loose-v1-0-6553b399be2d@pks.im>
To: git@vger.kernel.org
Cc: 
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

