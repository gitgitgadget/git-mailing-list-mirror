Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811EB2690F8
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 10:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744107861; cv=none; b=qWej+HUs6FL3MUNv87P0UutKiSa+8ScFXyLwV+ORPRg1+oBvg8GTWMS3T9Job0J/U5ou//DDQ3BOSjyLsDJ6PaSXUVl+KGShJ76St7nQLFMb0n03A2kp6RilNiIojaIbKpws63DlBL/Z+g5L9MPegFecPqHr1UmAsGOE1k3UQho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744107861; c=relaxed/simple;
	bh=kptPemjWN/fguUigEmQ2XrXy1O3bPDuNEpUYAbqv84U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OLBl8lEfdHXACNr3rtgSuJjVL2onLpZlLIdao2rCmpjHyTe6ga12kyda3CIwKLAYof6XNcY/LOReeA6tkOmeiPQNXq/DWp/8wsR5OtI1hGjWw/by9qzQD8AAdQkGJRsGIKP/Y0uIW5AbRi1xVK4Rv3wTHGjMlYag5M9eDSkmczU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eZ1bSLc/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LqLl0aeI; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eZ1bSLc/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LqLl0aeI"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 733AD138019E
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 06:24:18 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Tue, 08 Apr 2025 06:24:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744107858;
	 x=1744194258; bh=7lImVkEo0V7vFBE+m74sKBTZAk1o811bK/PCNLwEGMQ=; b=
	eZ1bSLc/KtiniFohXefF7HlBYJh8Qe7utFU9voNQwS28nn6X+x1RqVkn1xv6fNpo
	F54jtTBG5QsW1tAOQBjq59/7QZely0WOQXTmWRCBe1MLubkSBsRDAQz53B7GQdoQ
	C7wghgnr0qcDRqVja26uF42mlINwjjdz34GInJ24RZECubwDRIg21eDBUa0Kre0g
	OMYCnlrAMy71dO475re06aiYOnJQqD7YoeFlZy2CeAg+B2okonS7g2vF/XKVMHeu
	0GGA3R1b+CGQCNBqq47iK34usPxofgVvmyu5B2r+od11hpCWOfZRJtOwOsMxryzn
	0t/mdKhBjmMIjOqGkFAnlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744107858; x=
	1744194258; bh=7lImVkEo0V7vFBE+m74sKBTZAk1o811bK/PCNLwEGMQ=; b=L
	qLl0aeI5UjYfgTg9fLteozDhdw0uLmYurZc9XTX3fbTejST0K215BVRPnpKmFOBi
	obW4Cwc4+EAGr0M+aD5LkPUGaabaAearV66APs9B1b6jiPLA7J7Gg9Q82W9/2bJN
	R9w+qabpit3XBwIObzzt6ASjYbv2cwI4TlA+HO2v4egzggdwmTNM0oCqHVKqzaAn
	ogFE/EknZk6B/sqjfDTaBr90HPCaF51/ptVljpJ5NL8A1ZZ67uHUU7NFhxgDxJvb
	sGMtI8V9cT4FVHCgHc4Iou6e3M+IV0HYZ0AciWqDbCgrsO2KeIsJW1RiybehkiPw
	4knnk/+7Qye+ywpzOGkcA==
X-ME-Sender: <xms:Uvn0Z98sp0MKUp5VO-DMN9vJZGoGm3PECtg206FDi0w-trFEh_jzIQ>
    <xme:Uvn0ZxuRCAigKVngUKr3cPny17TIWmwYmr9cGoUxDfMBix2aAWSvfoJsGENTuOooU
    iMPWABnWvOZHcTpEw>
X-ME-Received: <xmr:Uvn0Z7BiSETzASAVpxXSQgijqJQsqq5CJJTFjr29Ov6ygatevw-gHj77QvACljtk_uhk36eBSnE2An4UNRO7MkXovH9W7dFFR3bOoVyCPgWcZ_6txw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtddvkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhff
    fugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufht
    vghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuie
    dujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
    dpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Uvn0ZxeRn_q0C5-7POl3vFm2qZpHTDKNm-azEEVVCJfBdT5fVv3mng>
    <xmx:Uvn0ZyM1wwGUc2BMvHIdcrwB517apAln-kR5h8qSPC6htjTD4LjnpQ>
    <xmx:Uvn0ZzmuBfndTlD_YvNYBPAySB-a1XhCzkfXqNVE4KG_8iIEcfIkHA>
    <xmx:Uvn0Z8v1G59lxvh777jR1u-CDSaBz4by3I9JMwi9yaOQNwsiNOk-YA>
    <xmx:Uvn0Z5olJ12j00GB8iu8-A5H1BaGMu-XlcodJvf7bGmmAuoL1JYTtaaa>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 8 Apr 2025 06:24:17 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d9c2612d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 8 Apr 2025 10:24:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 08 Apr 2025 12:24:13 +0200
Subject: [PATCH 5/9] object-file: split up concerns of `HASH_*` flags
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250408-pks-split-object-file-v1-5-f1fd50191143@pks.im>
References: <20250408-pks-split-object-file-v1-0-f1fd50191143@pks.im>
In-Reply-To: <20250408-pks-split-object-file-v1-0-f1fd50191143@pks.im>
To: git@vger.kernel.org
Cc: 
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
2.49.0.682.gc9b6a7b2b0.dirty

