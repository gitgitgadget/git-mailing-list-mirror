Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45827298CBA
	for <git@vger.kernel.org>; Fri, 11 Apr 2025 09:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744363807; cv=none; b=j806sRiZG6jI3px0l42HxFA/uGdnZO6dXxbv8naIcRGipPHIUeZ0hJv3sRZ1QJL5Q+hocJeyJSUg6ABTeLNC6sL2lP9r0sPsCMiTJAvFwZMwuMoUYOz1kgBwjswAO3NrGf1ej00QparQNM6o4JinGlztQwX5X/ebCpA0ytMu0j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744363807; c=relaxed/simple;
	bh=q6pisB3zJNoNTskf6U+0xtI4oDiKVFqV8H5VhR0XXA0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ozpIPd7JHKE+dRcoE0JrICa5ZlbzrGAMy9nA3+dVd3LKeCa0kUEiMicad8RvgVcC739F6kInbq3m7XVusgAe5/qMog0oTHD3P9GTL45J2/hUKmMtw+EjQAVsDt97p1RvHlLzsskNjp4O+O/WQy76ZtKPwzun6uTTXfNnhxtyk84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=R75OaPQt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=syVll7OJ; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="R75OaPQt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="syVll7OJ"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 554BA11402DC;
	Fri, 11 Apr 2025 05:30:04 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 11 Apr 2025 05:30:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744363804;
	 x=1744450204; bh=5+PeBW9jsIoIzdfye3tW7MV1ajwtxtOt/caDdRr6/+s=; b=
	R75OaPQtSugXWzH/9I1LwCQOU5y4i5qd1OaOn4EQwWQQ7BY/+Mi9vgR8juWm7ZRn
	pk48h04UzhraBfLDLQTD79+OYY5xOmTlBCFt0kcTCMjAS4HV2e5dsakwbGwnFrYm
	/n38xMVQG9jXxqdIntGdnTF9HCTWb9izxDBE1bJxnoHXboS3gmNVpCNxAEzx31Tr
	3TuBP6kRQDrCsMS0u+O8Kj/g0mmXfAXOBPWd7CJwx/PbLcMaDyT0A4ygFhMDCiZY
	wL1EhpOFUoSYBEAmGxyIm5FehBobpHKneIXDM0/KXbxnHT6zWnWLKEBIsctCFhr+
	wizwmXICeZZT9HwPe3fs6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744363804; x=
	1744450204; bh=5+PeBW9jsIoIzdfye3tW7MV1ajwtxtOt/caDdRr6/+s=; b=s
	yVll7OJFkDMEr2HpSCBsM9tqKoqOTd5yfxyxxk/cB+885fIrK+Q2MK0DjPZS31A3
	AC2rBSGFXVw3qlpx0sHoJdgf1+raQcQHcmUSqL2yjn7IF3gq8695m7SjKR/MMr7I
	AHgLyvdWfLdvruDru7c0KTeI0ltNxsPQxNqM6ZcUPuKJGUStdBz7TGneFN7BF7Up
	nJQD35LEQEMaAAj6bRD9ldUyVox/fO0RxZufzcEKT3GDaG0zp0s/tF/7zBZc7E20
	xy5Dzk6tSi70Qs7kDfInQg9AKupB8UPaCQn+iRegtta1sYdYJTQd2qa5EOSowPS7
	qLS8/fPsRpz/46ajTk9ng==
X-ME-Sender: <xms:HOH4Zw2NPm7A-gBubqeDYnS2e7CiVwAHjUH1RFdNiJvaStPEuiZ0HA>
    <xme:HOH4Z7HYTbntps9xoZ_9hXU04tlDmfYAnXBOP3rXafLmF674A1xjL6auffz8FCsua
    Tk4EDC3UebSavbyJA>
X-ME-Received: <xmr:HOH4Z46hYA-vKigqarT0Jyfnex8MPvG374frI37BjzEn3ORmFnwSdVpWG-vfEyUOqBGad41F5KUCTlEuKLxXUZjK4SNQgO12AsSUOebQICixhCg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvuddugeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehn
    vgifrhgvnhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:HOH4Z53JFbX8d04G6u1gjdYPuvqZvhNwkgEYK7u5wKj2Z7oYu2ayJg>
    <xmx:HOH4ZzGqaexrfHf-YG9pomXxdCEiK4Xib14r57BKRAijDRVjqyzR9w>
    <xmx:HOH4Zy8Z-HuM0BXhJrbFIicKUdB3fEs27lLGIuFXnwO0JQWwaDBrgw>
    <xmx:HOH4Z4mENBsFs1L9WPifQFnr06dL1U24KWZpliLewJN_8mkhWvd65w>
    <xmx:HOH4Z6yrS6h-hhOA0XTkutBp9d-NALfH3a0KJgngDDeCwWt1w-XZBJuL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Apr 2025 05:30:03 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2315f3a9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 11 Apr 2025 09:30:02 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 11 Apr 2025 11:29:54 +0200
Subject: [PATCH v2 5/9] object-file: split up concerns of `HASH_*` flags
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250411-pks-split-object-file-v2-5-2bea0c9033ae@pks.im>
References: <20250411-pks-split-object-file-v2-0-2bea0c9033ae@pks.im>
In-Reply-To: <20250411-pks-split-object-file-v2-0-2bea0c9033ae@pks.im>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

The functions `hash_object_file()`, `write_object_file()` and
`index_fd()` reuse the same set of flags to alter their behaviour. This
not only adds confusion, but given that every function only supports a
subset of the flags it becomes very hard to see which flags can be
passed to what function. Last but not least, this entangles the
implementation of all three function families.

Split up concerns by creating separate flags for each of the function
families.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/hash-object.c  | 23 +++++++++++++++++------
 builtin/replace.c      |  2 +-
 builtin/update-index.c |  2 +-
 bulk-checkin.c         |  6 +++---
 cache-tree.c           |  2 +-
 notes-merge.c          |  2 +-
 object-file.c          | 18 +++++++++---------
 object-file.h          | 25 +++++++++++++++++++++----
 read-cache.c           |  4 ++--
 9 files changed, 56 insertions(+), 28 deletions(-)

diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index a25f0403f44..e7c0d6afdef 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -19,6 +19,11 @@
 #include "strbuf.h"
 #include "write-or-die.h"
 
+enum {
+	HASH_OBJECT_CHECK = (1 << 0),
+	HASH_OBJECT_WRITE = (1 << 1),
+};
+
 /*
  * This is to create corrupt objects for debugging and as such it
  * needs to bypass the data conversion performed by, and the type
@@ -33,7 +38,7 @@ static int hash_literally(struct object_id *oid, int fd, const char *type, unsig
 		ret = -1;
 	else
 		ret = write_object_file_literally(buf.buf, buf.len, type, oid,
-						 flags);
+						  (flags & HASH_OBJECT_WRITE) ? WRITE_OBJECT_FILE_PERSIST : 0);
 	close(fd);
 	strbuf_release(&buf);
 	return ret;
@@ -42,15 +47,21 @@ static int hash_literally(struct object_id *oid, int fd, const char *type, unsig
 static void hash_fd(int fd, const char *type, const char *path, unsigned flags,
 		    int literally)
 {
+	unsigned int index_flags = 0;
 	struct stat st;
 	struct object_id oid;
 
+	if (flags & HASH_OBJECT_WRITE)
+		index_flags |= INDEX_WRITE_OBJECT;
+	if (flags & HASH_OBJECT_CHECK)
+		index_flags |= INDEX_FORMAT_CHECK;
+
 	if (fstat(fd, &st) < 0 ||
 	    (literally
 	     ? hash_literally(&oid, fd, type, flags)
 	     : index_fd(the_repository->index, &oid, fd, &st,
-			type_from_string(type), path, flags)))
-		die((flags & HASH_WRITE_OBJECT)
+			type_from_string(type), path, index_flags)))
+		die((flags & HASH_OBJECT_WRITE)
 		    ? "Unable to add %s to database"
 		    : "Unable to hash %s", path);
 	printf("%s\n", oid_to_hex(&oid));
@@ -102,13 +113,13 @@ int cmd_hash_object(int argc,
 	int no_filters = 0;
 	int literally = 0;
 	int nongit = 0;
-	unsigned flags = HASH_FORMAT_CHECK;
+	unsigned flags = HASH_OBJECT_CHECK;
 	const char *vpath = NULL;
 	char *vpath_free = NULL;
 	const struct option hash_object_options[] = {
 		OPT_STRING('t', NULL, &type, N_("type"), N_("object type")),
 		OPT_BIT('w', NULL, &flags, N_("write the object into the object database"),
-			HASH_WRITE_OBJECT),
+			HASH_OBJECT_WRITE),
 		OPT_COUNTUP( 0 , "stdin", &hashstdin, N_("read the object from stdin")),
 		OPT_BOOL( 0 , "stdin-paths", &stdin_paths, N_("read file names from stdin")),
 		OPT_BOOL( 0 , "no-filters", &no_filters, N_("store file as is without filters")),
@@ -122,7 +133,7 @@ int cmd_hash_object(int argc,
 	argc = parse_options(argc, argv, prefix, hash_object_options,
 			     hash_object_usage, 0);
 
-	if (flags & HASH_WRITE_OBJECT)
+	if (flags & HASH_OBJECT_WRITE)
 		prefix = setup_git_directory();
 	else
 		prefix = setup_git_directory_gently(&nongit);
diff --git a/builtin/replace.c b/builtin/replace.c
index 15ec0922ce1..2b4fc9a68b3 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -305,7 +305,7 @@ static int import_object(struct object_id *oid, enum object_type type,
 		strbuf_release(&result);
 	} else {
 		struct stat st;
-		int flags = HASH_FORMAT_CHECK | HASH_WRITE_OBJECT;
+		int flags = INDEX_FORMAT_CHECK | INDEX_WRITE_OBJECT;
 
 		if (fstat(fd, &st) < 0) {
 			error_errno(_("unable to fstat %s"), filename);
diff --git a/builtin/update-index.c b/builtin/update-index.c
index b2f6b1a3fbb..f0cf964294d 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -304,7 +304,7 @@ static int add_one_path(const struct cache_entry *old, const char *path, int len
 	ce->ce_mode = ce_mode_from_stat(old, st->st_mode);
 
 	if (index_path(the_repository->index, &ce->oid, path, st,
-		       info_only ? 0 : HASH_WRITE_OBJECT)) {
+		       info_only ? 0 : INDEX_WRITE_OBJECT)) {
 		discard_cache_entry(ce);
 		return -1;
 	}
diff --git a/bulk-checkin.c b/bulk-checkin.c
index 23ac00ea0a6..309201a76a6 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -171,7 +171,7 @@ static int stream_blob_to_pack(struct bulk_checkin_packfile *state,
 	unsigned char obuf[16384];
 	unsigned hdrlen;
 	int status = Z_OK;
-	int write_object = (flags & HASH_WRITE_OBJECT);
+	int write_object = (flags & INDEX_WRITE_OBJECT);
 	off_t offset = 0;
 
 	git_deflate_init(&s, pack_compression_level);
@@ -241,7 +241,7 @@ static int stream_blob_to_pack(struct bulk_checkin_packfile *state,
 static void prepare_to_stream(struct bulk_checkin_packfile *state,
 			      unsigned flags)
 {
-	if (!(flags & HASH_WRITE_OBJECT) || state->f)
+	if (!(flags & INDEX_WRITE_OBJECT) || state->f)
 		return;
 
 	state->f = create_tmp_packfile(the_repository, &state->pack_tmp_name);
@@ -275,7 +275,7 @@ static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
 	git_hash_update(&ctx, obuf, header_len);
 
 	/* Note: idx is non-NULL when we are writing */
-	if ((flags & HASH_WRITE_OBJECT) != 0) {
+	if ((flags & INDEX_WRITE_OBJECT) != 0) {
 		CALLOC_ARRAY(idx, 1);
 
 		prepare_to_stream(state, flags);
diff --git a/cache-tree.c b/cache-tree.c
index bcbcad3d61a..4c8167ea927 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -452,7 +452,7 @@ static int update_one(struct cache_tree *it,
 				 OBJ_TREE, &it->oid);
 	} else if (write_object_file_flags(buffer.buf, buffer.len, OBJ_TREE,
 					   &it->oid, NULL, flags & WRITE_TREE_SILENT
-					   ? HASH_SILENT : 0)) {
+					   ? WRITE_OBJECT_FILE_SILENT : 0)) {
 		strbuf_release(&buffer);
 		return -1;
 	}
diff --git a/notes-merge.c b/notes-merge.c
index 5008faef450..d9f2914c819 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -729,7 +729,7 @@ int notes_merge_commit(struct notes_merge_options *o,
 		/* write file as blob, and add to partial_tree */
 		if (stat(path.buf, &st))
 			die_errno("Failed to stat '%s'", path.buf);
-		if (index_path(o->repo->index, &blob_oid, path.buf, &st, HASH_WRITE_OBJECT))
+		if (index_path(o->repo->index, &blob_oid, path.buf, &st, INDEX_WRITE_OBJECT))
 			die("Failed to write blob object from '%s'", path.buf);
 		if (add_note(partial_tree, &obj_oid, &blob_oid, NULL))
 			die("Failed to add resolved note '%s' to notes tree",
diff --git a/object-file.c b/object-file.c
index 1c74aa239fb..dea5a70a331 100644
--- a/object-file.c
+++ b/object-file.c
@@ -33,9 +33,9 @@
 
 static int get_conv_flags(unsigned flags)
 {
-	if (flags & HASH_RENORMALIZE)
+	if (flags & INDEX_RENORMALIZE)
 		return CONV_EOL_RENORMALIZE;
-	else if (flags & HASH_WRITE_OBJECT)
+	else if (flags & INDEX_WRITE_OBJECT)
 		return global_conv_flags_eol | CONV_WRITE_OBJECT;
 	else
 		return 0;
@@ -835,7 +835,7 @@ static int start_loose_object_common(struct strbuf *tmp_file,
 
 	fd = create_tmpfile(tmp_file, filename);
 	if (fd < 0) {
-		if (flags & HASH_SILENT)
+		if (flags & WRITE_OBJECT_FILE_SILENT)
 			return -1;
 		else if (errno == EACCES)
 			return error(_("insufficient permission for adding "
@@ -967,7 +967,7 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 		utb.actime = mtime;
 		utb.modtime = mtime;
 		if (utime(tmp_file.buf, &utb) < 0 &&
-		    !(flags & HASH_SILENT))
+		    !(flags & WRITE_OBJECT_FILE_SILENT))
 			warning_errno(_("failed utime() on %s"), tmp_file.buf);
 	}
 
@@ -1178,7 +1178,7 @@ int write_object_file_literally(const void *buf, unsigned long len,
 	write_object_file_prepare_literally(the_hash_algo, buf, len, type,
 					    oid, header, &hdrlen);
 
-	if (!(flags & HASH_WRITE_OBJECT))
+	if (!(flags & WRITE_OBJECT_FILE_PERSIST))
 		goto cleanup;
 	if (freshen_packed_object(oid) || freshen_loose_object(oid))
 		goto cleanup;
@@ -1249,7 +1249,7 @@ static int index_mem(struct index_state *istate,
 {
 	struct strbuf nbuf = STRBUF_INIT;
 	int ret = 0;
-	int write_object = flags & HASH_WRITE_OBJECT;
+	int write_object = flags & INDEX_WRITE_OBJECT;
 
 	if (!type)
 		type = OBJ_BLOB;
@@ -1264,7 +1264,7 @@ static int index_mem(struct index_state *istate,
 			size = nbuf.len;
 		}
 	}
-	if (flags & HASH_FORMAT_CHECK) {
+	if (flags & INDEX_FORMAT_CHECK) {
 		struct fsck_options opts = FSCK_OPTIONS_DEFAULT;
 
 		opts.strict = 1;
@@ -1290,7 +1290,7 @@ static int index_stream_convert_blob(struct index_state *istate,
 				     unsigned flags)
 {
 	int ret = 0;
-	const int write_object = flags & HASH_WRITE_OBJECT;
+	const int write_object = flags & INDEX_WRITE_OBJECT;
 	struct strbuf sbuf = STRBUF_INIT;
 
 	assert(path);
@@ -1422,7 +1422,7 @@ int index_path(struct index_state *istate, struct object_id *oid,
 	case S_IFLNK:
 		if (strbuf_readlink(&sb, path, st->st_size))
 			return error_errno("readlink(\"%s\")", path);
-		if (!(flags & HASH_WRITE_OBJECT))
+		if (!(flags & INDEX_WRITE_OBJECT))
 			hash_object_file(the_hash_algo, sb.buf, sb.len,
 					 OBJ_BLOB, oid);
 		else if (write_object_file(sb.buf, sb.len, OBJ_BLOB, oid))
diff --git a/object-file.h b/object-file.h
index 78c84d970a9..c002fbe2345 100644
--- a/object-file.h
+++ b/object-file.h
@@ -14,10 +14,12 @@ struct index_state;
  */
 extern int fetch_if_missing;
 
-#define HASH_WRITE_OBJECT 1
-#define HASH_FORMAT_CHECK 2
-#define HASH_RENORMALIZE  4
-#define HASH_SILENT 8
+enum {
+	INDEX_WRITE_OBJECT = (1 << 0),
+	INDEX_FORMAT_CHECK = (1 << 1),
+	INDEX_RENORMALIZE  = (1 << 2),
+};
+
 int index_fd(struct index_state *istate, struct object_id *oid, int fd, struct stat *st, enum object_type type, const char *path, unsigned flags);
 int index_path(struct index_state *istate, struct object_id *oid, const char *path, struct stat *st, unsigned flags);
 
@@ -84,6 +86,21 @@ enum unpack_loose_header_result unpack_loose_header(git_zstream *stream,
 struct object_info;
 int parse_loose_header(const char *hdr, struct object_info *oi);
 
+enum {
+	/*
+	 * By default, `write_object_file_literally()` does not actually write
+	 * anything into the object store, but only computes the object ID.
+	 * This flag changes that so that the object will be written as a loose
+	 * object and persisted.
+	 */
+	WRITE_OBJECT_FILE_PERSIST = (1 << 0),
+
+	/*
+	 * Do not print an error in case something gose wrong.
+	 */
+	WRITE_OBJECT_FILE_SILENT = (1 << 1),
+};
+
 int write_object_file_flags(const void *buf, unsigned long len,
 			    enum object_type type, struct object_id *oid,
 			    struct object_id *comapt_oid_in, unsigned flags);
diff --git a/read-cache.c b/read-cache.c
index 2f9e21c897d..23028f43a11 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -706,11 +706,11 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 	int intent_only = flags & ADD_CACHE_INTENT;
 	int add_option = (ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE|
 			  (intent_only ? ADD_CACHE_NEW_ONLY : 0));
-	unsigned hash_flags = pretend ? 0 : HASH_WRITE_OBJECT;
+	unsigned hash_flags = pretend ? 0 : INDEX_WRITE_OBJECT;
 	struct object_id oid;
 
 	if (flags & ADD_CACHE_RENORMALIZE)
-		hash_flags |= HASH_RENORMALIZE;
+		hash_flags |= INDEX_RENORMALIZE;
 
 	if (!S_ISREG(st_mode) && !S_ISLNK(st_mode) && !S_ISDIR(st_mode))
 		return error(_("%s: can only add regular files, symbolic links or git-directories"), path);

-- 
2.49.0.777.g153de2bbd5.dirty

