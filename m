Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6082C289376
	for <git@vger.kernel.org>; Tue, 15 Apr 2025 09:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744709909; cv=none; b=LHycO8KH35fJ3wrUCuq8aEmoETD2EHaIZx3WNYS623LjZ6tGIuZulYfiUQCPpIfIVP0BIPU0MG9M2krmDHdL2y7RXO3GKkHIUBYB6mMmJeqFZhtZwqajnXVYNJtSkCaWF3DkpTtGmCq1KmOLOfMIbqXgprWRXW3XHgPuH/HRrdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744709909; c=relaxed/simple;
	bh=b0T2PBW0g1HfsydOy+xOWBWT6bKAckqBxq84xUEG32Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YovjQ3YYsFMHNz+W/vr36DrjJ5ajTsSZ+CVBpj9i7TcV1O3IRjWO5T7LODPo84muea+kcYU+UMc7UiKEpFbJ8aK1mn6ol6BJvlb1W5eqkeUO9b1+pCbSe75OkYFLy0gB+3BX3LEwC9TliJUqZewVHZAx+w5tRLxJpkjMz8DQC1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iLp1Jzgu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rnAtnVgQ; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iLp1Jzgu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rnAtnVgQ"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id B07531140301;
	Tue, 15 Apr 2025 05:38:25 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 15 Apr 2025 05:38:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744709905;
	 x=1744796305; bh=pLpzG8yzN70w1j67GwH0+DqMNZtZcCNzidqW+TCe5vU=; b=
	iLp1JzguyHLRb9v7uwlU0PUSb2bgw+wGg2RaOWAGqOnGQKoG28uaYmqZUMtL6RIi
	IuyT7sO5aP5kcgzXFuffaD9dpN7F1en2agVzC69q3CQYS10yrvlcgPi/J5bktOuc
	tZZwIskW8Q4wO30ejO7YeCsLn7OXK1XLGh0Zm6mWERKe4YaiR4tBd+v4dzQfFOE9
	CGdXJr2tgiNrjHFI//n7TT5luD516hUIIx2z/T4HBahpEtq0qUcVf47C83s0Otsh
	bg1I8HSdi8WWt4qtRfFeWo7hRUjclGW/QiMWEU31VVIdg0Ih5J5phDLP/MzVhhn9
	R/AIbWLDFVOuUqy1R8Pz8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744709905; x=
	1744796305; bh=pLpzG8yzN70w1j67GwH0+DqMNZtZcCNzidqW+TCe5vU=; b=r
	nAtnVgQn0OImYlxZi1fORcvB+vXqV/2yTusDHhI0KZNo8Sm94QctGGmUaJoCAZdo
	uakivJXsuB0QBBbtT+VxaxkehjOAYvWm4F7ztZf68fTABWKh6oI1zg9ZzrCmgaSc
	ZNdQN4tKy8o/FqzSVfSZpZ+peGmrL9zxAa6/4XrIMhOcil7QFFTp2llUb7PzNUh1
	au9H356IxRi51pb+ytNhBgzKamvSWXMYGQ8TKKzyefQJetx4+pstNnf+PLLu9t9W
	pTAgYUtb0655AojvPFqhqGHGzWgbXpPghPBthKdgIshYYgAd4WVelY18VPZlP6jE
	zC2mrlMasTNgFl5Y3cRhg==
X-ME-Sender: <xms:ESn-Z5JhhThlWwysoPuAoQkoDIZv9kloD8crVVz7FzXyKmmmqHqAng>
    <xme:ESn-Z1LTAb1g21XGrR9LBoM2xl0s6ccg3P9tJuda4svgbIGfM0N5eyHw-yVkfyG6B
    w8kJTgPZs6tz4VG8A>
X-ME-Received: <xmr:ESn-Zxv-mgDQiMqmghdA_m4iJN4fc8DgVF8U77_HXnQ-WtCIGa3z0oGrIsV3Jta46Rw7RX_adfIMF7NINu2j5VbUQW9m5gz2St07JFAgwwP8cg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdefudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtg
    hordgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepnhgvfihrvghnsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ESn-Z6bfEXIrJV2xetsM1MI-anDtgIxH87fReIKvbR5chiaih3V12g>
    <xmx:ESn-ZwYi1_35tRmfs3ruTXXPrW1v121mbpykG0dUEMzIqySkUPOrQQ>
    <xmx:ESn-Z-B8mW-2JVdnlXdjCJj5RkIcSfiuQ5xtbZ5Ur1nreG-uoxE-yA>
    <xmx:ESn-Z-b8qDuKQ7SK321Ah-zO3DzNl3FH47IulhMkwiszaz1TBpYg_A>
    <xmx:ESn-ZwwxS2FO_HrJ6PYlV1qC0Ref7QBwtwTZqf_dg99csRaBfAvc7IBl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Apr 2025 05:38:24 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 605dc758 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 15 Apr 2025 09:38:23 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 15 Apr 2025 11:38:19 +0200
Subject: [PATCH v3 06/10] object-file: split up concerns of `HASH_*` flags
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250415-pks-split-object-file-v3-6-6aa7db7ad7b0@pks.im>
References: <20250415-pks-split-object-file-v3-0-6aa7db7ad7b0@pks.im>
In-Reply-To: <20250415-pks-split-object-file-v3-0-6aa7db7ad7b0@pks.im>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, 
 Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>, 
 Junio C Hamano <gitster@pobox.com>
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
index fce45043655..520b92942cd 100644
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
index baa828822ea..2051991f4de 100644
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
 
@@ -1179,7 +1179,7 @@ int write_object_file_literally(const void *buf, unsigned long len,
 	write_object_file_prepare_literally(the_hash_algo, buf, len, type,
 					    oid, header, &hdrlen);
 
-	if (!(flags & HASH_WRITE_OBJECT))
+	if (!(flags & WRITE_OBJECT_FILE_PERSIST))
 		goto cleanup;
 	if (freshen_packed_object(oid) || freshen_loose_object(oid))
 		goto cleanup;
@@ -1250,7 +1250,7 @@ static int index_mem(struct index_state *istate,
 {
 	struct strbuf nbuf = STRBUF_INIT;
 	int ret = 0;
-	int write_object = flags & HASH_WRITE_OBJECT;
+	int write_object = flags & INDEX_WRITE_OBJECT;
 
 	if (!type)
 		type = OBJ_BLOB;
@@ -1265,7 +1265,7 @@ static int index_mem(struct index_state *istate,
 			size = nbuf.len;
 		}
 	}
-	if (flags & HASH_FORMAT_CHECK) {
+	if (flags & INDEX_FORMAT_CHECK) {
 		struct fsck_options opts = FSCK_OPTIONS_DEFAULT;
 
 		opts.strict = 1;
@@ -1291,7 +1291,7 @@ static int index_stream_convert_blob(struct index_state *istate,
 				     unsigned flags)
 {
 	int ret = 0;
-	const int write_object = flags & HASH_WRITE_OBJECT;
+	const int write_object = flags & INDEX_WRITE_OBJECT;
 	struct strbuf sbuf = STRBUF_INIT;
 
 	assert(path);
@@ -1423,7 +1423,7 @@ int index_path(struct index_state *istate, struct object_id *oid,
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
2.49.0.805.g082f7c87e0.dirty

