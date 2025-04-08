Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAA22690FE
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 10:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744107862; cv=none; b=ZiwlVZbpxwgO3WoXNXL0eFMY5miq0wAxk8SLKmkbNr+Tx/Fej6DlwzMuXccs568c75F8Q1nw3ZIo5FkhwonVH09YxznjMHeKDVuFB2YbfI3pH1Q25VKtnTyuEZaAl1DXp9M00de5rJJx9Ja+daOABi44fmnEleL8v09bEui7VWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744107862; c=relaxed/simple;
	bh=6QuVBFSHCoLhz96SM9gpIWwkZ+1RMeQbCKqDeuyiOmU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z57PwmYc2Yw+15VGkcoFUXPROeMzXH3MyIZf+rtiUxE3zh3v1qIxTwzeruOdaE8MBVxVIA5Cv386+8rHVgscZvCnWYHbAtKbRBr6VngrdgTFkad4V90ccGjYM4uEZrk/HJY72vRz5AASg4qSt29g3HhAwPiRTHVpzLI5kDPJQ6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=En4GnU9d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=au9Dx9lS; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="En4GnU9d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="au9Dx9lS"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E133711401E7
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 06:24:18 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 08 Apr 2025 06:24:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744107858;
	 x=1744194258; bh=2bC4N96kesFadU9q5vk8Ry3GQ2L/6mo94EGYu9P2Y+E=; b=
	En4GnU9dLFmZmtSKrbXrmPTiHeOerCoByXiREff30w4TFSi5sAIZE11j4R+1W1fj
	yvD7uJJHeL5pZAYh/YmHpiik/z3gXUbDdw+ziEVLSkvGn3Fh6ntPhUDyXC7mqwkX
	BDs5LPLN/clwXaJYe/TAODdVeJ3ievrwHkieQNW3lvT2VAHnktz1ELYjZ33GnRnm
	881z4uklFxjYh28YI7qI4tFJ6Dd/EPl/W/qEhALdRdCBB8BuJeuytEvbUD3VLrYD
	r+VRG62aCFE55PbqrOLUJ9j1+7b9D0YWOS4pl5khbB5IKISJq0rJG9QfaL4y+5YR
	aAro9xPBFO7NP+8eL6gl2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744107858; x=
	1744194258; bh=2bC4N96kesFadU9q5vk8Ry3GQ2L/6mo94EGYu9P2Y+E=; b=a
	u9Dx9lSY4uEmmQcb9/Oo1Wvu0RWwjcdAxmQKLYr1H/4hDYygHmbZ/Q0ksp7kJC8v
	MiwlL3KiDMqi3o6mdiCloqyr0TVP9fTO3w6FAB8T7HIJUIVmM3rHytMBnsUR1LgM
	Y2/migJQEkI40NXcb7sJ9PR+iW4Ay9URfFaw7TPV/TvMDBDlkmcueDXMEr1ekxIw
	gabgKwaQaquJSAkNsLuz2dHQcSgYj6v+3pd9Z2SHaUZTmvxtxedXZGiHrKWxWfeW
	s5ajZ0qXodFQEDw/QV3LxjnLDcsaM1dI8SZV9sQIYXgIfozaq3IBltUcUyVmhrrq
	X/jDify46JQJULjr/MDXA==
X-ME-Sender: <xms:Uvn0Z8Krf7hY-kHo9Bb2z6DPu1_w0IF-M8yPNwLZ27ojIxJRKETqSQ>
    <xme:Uvn0Z8KJeh2zJ1x-AWSPMNh4IuwUq5aKZeEmGMRtuuTnxValnP9IEWATPjO7Avynz
    NEqMhfvtYhxQH1-Ew>
X-ME-Received: <xmr:Uvn0Z8tLKdel0ScPW0HRb47pzXg3WW16qcPQJhjO81EAhrIrpqDxkmfbHJcJFlzujB3ir8FBzYs8RCKLWN9Rd1miw5bhtlFOWEOF6giAyXctHgApWQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtddvkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhff
    fugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufht
    vghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuie
    dujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhs
    thgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
    dpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Uvn0Z5YTteSE23Lw2rL9dhQMqnIf6JIYIXJdkK9YmMsgAOOnZVEIqw>
    <xmx:Uvn0ZzbfPW-FyC46I4OYDBxMnrl6jhaSO06BrFaP0j7RB4VBYD3NGA>
    <xmx:Uvn0Z1AqkQ6vy9pCNNFAynPulaECiHaZ3wGRXD0unP9YoZdVtuZvvA>
    <xmx:Uvn0Z5Z1MHR_JTFLpuDLJnzuaFX-ATvrZNusUjkmawoIaVIwIJqoiA>
    <xmx:Uvn0Z9lFLrmjlzOhVgoORnskZozrZhBH-RzWE-r1Cj_qjQ8nzrONBfXG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 8 Apr 2025 06:24:18 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 04f662f5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 8 Apr 2025 10:24:17 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 08 Apr 2025 12:24:14 +0200
Subject: [PATCH 6/9] object-file: split out functions relating to index
 subsystem
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250408-pks-split-object-file-v1-6-f1fd50191143@pks.im>
References: <20250408-pks-split-object-file-v1-0-f1fd50191143@pks.im>
In-Reply-To: <20250408-pks-split-object-file-v1-0-f1fd50191143@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Split out functions relating to the index subsystem from "object-file.c"
to help us separate concerns.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/difftool.c    |   2 +-
 builtin/hash-object.c |   1 +
 builtin/replace.c     |   1 +
 bulk-checkin.c        |   1 +
 diff.c                |   2 +-
 notes-merge.c         |   1 +
 object-file.c         | 225 --------------------------------------------------
 object-file.h         |  11 ---
 read-cache.c          | 224 +++++++++++++++++++++++++++++++++++++++++++++++++
 read-cache.h          |   9 ++
 10 files changed, 239 insertions(+), 238 deletions(-)

diff --git a/builtin/difftool.c b/builtin/difftool.c
index 41cd00066cc..45d6ea8a801 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -22,7 +22,7 @@
 #include "gettext.h"
 #include "hex.h"
 #include "parse-options.h"
-#include "read-cache-ll.h"
+#include "read-cache.h"
 #include "repository.h"
 #include "sparse-index.h"
 #include "strvec.h"
diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index e7c0d6afdef..7aa889b1b4a 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -15,6 +15,7 @@
 #include "blob.h"
 #include "quote.h"
 #include "parse-options.h"
+#include "read-cache.h"
 #include "setup.h"
 #include "strbuf.h"
 #include "write-or-die.h"
diff --git a/builtin/replace.c b/builtin/replace.c
index 2b4fc9a68b3..ce2948a9b2a 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -20,6 +20,7 @@
 #include "object-file.h"
 #include "object-name.h"
 #include "object-store-ll.h"
+#include "read-cache.h"
 #include "replace-object.h"
 #include "tag.h"
 #include "wildmatch.h"
diff --git a/bulk-checkin.c b/bulk-checkin.c
index 309201a76a6..0b9bad92868 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -11,6 +11,7 @@
 #include "gettext.h"
 #include "hex.h"
 #include "lockfile.h"
+#include "read-cache.h"
 #include "repository.h"
 #include "csum-file.h"
 #include "pack.h"
diff --git a/diff.c b/diff.c
index 3bcf5028831..c361199ab1b 100644
--- a/diff.c
+++ b/diff.c
@@ -42,7 +42,7 @@
 #include "dir.h"
 #include "object-file.h"
 #include "object-name.h"
-#include "read-cache-ll.h"
+#include "read-cache.h"
 #include "setup.h"
 #include "strmap.h"
 #include "ws.h"
diff --git a/notes-merge.c b/notes-merge.c
index d9f2914c819..13750490eff 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -10,6 +10,7 @@
 #include "object-name.h"
 #include "object-store-ll.h"
 #include "path.h"
+#include "read-cache.h"
 #include "repository.h"
 #include "diff.h"
 #include "diffcore.h"
diff --git a/object-file.c b/object-file.c
index dea5a70a331..235d29858ff 100644
--- a/object-file.c
+++ b/object-file.c
@@ -12,9 +12,7 @@
 
 #include "git-compat-util.h"
 #include "bulk-checkin.h"
-#include "convert.h"
 #include "environment.h"
-#include "fsck.h"
 #include "gettext.h"
 #include "hex.h"
 #include "loose.h"
@@ -25,22 +23,11 @@
 #include "pack.h"
 #include "packfile.h"
 #include "path.h"
-#include "setup.h"
 #include "streaming.h"
 
 /* The maximum size for an object header. */
 #define MAX_HEADER_LEN 32
 
-static int get_conv_flags(unsigned flags)
-{
-	if (flags & INDEX_RENORMALIZE)
-		return CONV_EOL_RENORMALIZE;
-	else if (flags & INDEX_WRITE_OBJECT)
-		return global_conv_flags_eol | CONV_WRITE_OBJECT;
-	else
-		return 0;
-}
-
 static void fill_loose_path(struct strbuf *buf, const struct object_id *oid)
 {
 	int i;
@@ -1225,218 +1212,6 @@ int force_object_loose(const struct object_id *oid, time_t mtime)
 	return ret;
 }
 
-/*
- * We can't use the normal fsck_error_function() for index_mem(),
- * because we don't yet have a valid oid for it to report. Instead,
- * report the minimal fsck error here, and rely on the caller to
- * give more context.
- */
-static int hash_format_check_report(struct fsck_options *opts UNUSED,
-				    void *fsck_report UNUSED,
-				    enum fsck_msg_type msg_type UNUSED,
-				    enum fsck_msg_id msg_id UNUSED,
-				    const char *message)
-{
-	error(_("object fails fsck: %s"), message);
-	return 1;
-}
-
-static int index_mem(struct index_state *istate,
-		     struct object_id *oid,
-		     const void *buf, size_t size,
-		     enum object_type type,
-		     const char *path, unsigned flags)
-{
-	struct strbuf nbuf = STRBUF_INIT;
-	int ret = 0;
-	int write_object = flags & INDEX_WRITE_OBJECT;
-
-	if (!type)
-		type = OBJ_BLOB;
-
-	/*
-	 * Convert blobs to git internal format
-	 */
-	if ((type == OBJ_BLOB) && path) {
-		if (convert_to_git(istate, path, buf, size, &nbuf,
-				   get_conv_flags(flags))) {
-			buf = nbuf.buf;
-			size = nbuf.len;
-		}
-	}
-	if (flags & INDEX_FORMAT_CHECK) {
-		struct fsck_options opts = FSCK_OPTIONS_DEFAULT;
-
-		opts.strict = 1;
-		opts.error_func = hash_format_check_report;
-		if (fsck_buffer(null_oid(the_hash_algo), type, buf, size, &opts))
-			die(_("refusing to create malformed object"));
-		fsck_finish(&opts);
-	}
-
-	if (write_object)
-		ret = write_object_file(buf, size, type, oid);
-	else
-		hash_object_file(the_hash_algo, buf, size, type, oid);
-
-	strbuf_release(&nbuf);
-	return ret;
-}
-
-static int index_stream_convert_blob(struct index_state *istate,
-				     struct object_id *oid,
-				     int fd,
-				     const char *path,
-				     unsigned flags)
-{
-	int ret = 0;
-	const int write_object = flags & INDEX_WRITE_OBJECT;
-	struct strbuf sbuf = STRBUF_INIT;
-
-	assert(path);
-	assert(would_convert_to_git_filter_fd(istate, path));
-
-	convert_to_git_filter_fd(istate, path, fd, &sbuf,
-				 get_conv_flags(flags));
-
-	if (write_object)
-		ret = write_object_file(sbuf.buf, sbuf.len, OBJ_BLOB,
-					oid);
-	else
-		hash_object_file(the_hash_algo, sbuf.buf, sbuf.len, OBJ_BLOB,
-				 oid);
-	strbuf_release(&sbuf);
-	return ret;
-}
-
-static int index_pipe(struct index_state *istate, struct object_id *oid,
-		      int fd, enum object_type type,
-		      const char *path, unsigned flags)
-{
-	struct strbuf sbuf = STRBUF_INIT;
-	int ret;
-
-	if (strbuf_read(&sbuf, fd, 4096) >= 0)
-		ret = index_mem(istate, oid, sbuf.buf, sbuf.len, type, path, flags);
-	else
-		ret = -1;
-	strbuf_release(&sbuf);
-	return ret;
-}
-
-#define SMALL_FILE_SIZE (32*1024)
-
-static int index_core(struct index_state *istate,
-		      struct object_id *oid, int fd, size_t size,
-		      enum object_type type, const char *path,
-		      unsigned flags)
-{
-	int ret;
-
-	if (!size) {
-		ret = index_mem(istate, oid, "", size, type, path, flags);
-	} else if (size <= SMALL_FILE_SIZE) {
-		char *buf = xmalloc(size);
-		ssize_t read_result = read_in_full(fd, buf, size);
-		if (read_result < 0)
-			ret = error_errno(_("read error while indexing %s"),
-					  path ? path : "<unknown>");
-		else if (read_result != size)
-			ret = error(_("short read while indexing %s"),
-				    path ? path : "<unknown>");
-		else
-			ret = index_mem(istate, oid, buf, size, type, path, flags);
-		free(buf);
-	} else {
-		void *buf = xmmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
-		ret = index_mem(istate, oid, buf, size, type, path, flags);
-		munmap(buf, size);
-	}
-	return ret;
-}
-
-/*
- * This creates one packfile per large blob unless bulk-checkin
- * machinery is "plugged".
- *
- * This also bypasses the usual "convert-to-git" dance, and that is on
- * purpose. We could write a streaming version of the converting
- * functions and insert that before feeding the data to fast-import
- * (or equivalent in-core API described above). However, that is
- * somewhat complicated, as we do not know the size of the filter
- * result, which we need to know beforehand when writing a git object.
- * Since the primary motivation for trying to stream from the working
- * tree file and to avoid mmaping it in core is to deal with large
- * binary blobs, they generally do not want to get any conversion, and
- * callers should avoid this code path when filters are requested.
- */
-static int index_blob_stream(struct object_id *oid, int fd, size_t size,
-			     const char *path,
-			     unsigned flags)
-{
-	return index_blob_bulk_checkin(oid, fd, size, path, flags);
-}
-
-int index_fd(struct index_state *istate, struct object_id *oid,
-	     int fd, struct stat *st,
-	     enum object_type type, const char *path, unsigned flags)
-{
-	int ret;
-
-	/*
-	 * Call xsize_t() only when needed to avoid potentially unnecessary
-	 * die() for large files.
-	 */
-	if (type == OBJ_BLOB && path && would_convert_to_git_filter_fd(istate, path))
-		ret = index_stream_convert_blob(istate, oid, fd, path, flags);
-	else if (!S_ISREG(st->st_mode))
-		ret = index_pipe(istate, oid, fd, type, path, flags);
-	else if (st->st_size <= repo_settings_get_big_file_threshold(the_repository) ||
-		 type != OBJ_BLOB ||
-		 (path && would_convert_to_git(istate, path)))
-		ret = index_core(istate, oid, fd, xsize_t(st->st_size),
-				 type, path, flags);
-	else
-		ret = index_blob_stream(oid, fd, xsize_t(st->st_size), path,
-					flags);
-	close(fd);
-	return ret;
-}
-
-int index_path(struct index_state *istate, struct object_id *oid,
-	       const char *path, struct stat *st, unsigned flags)
-{
-	int fd;
-	struct strbuf sb = STRBUF_INIT;
-	int rc = 0;
-
-	switch (st->st_mode & S_IFMT) {
-	case S_IFREG:
-		fd = open(path, O_RDONLY);
-		if (fd < 0)
-			return error_errno("open(\"%s\")", path);
-		if (index_fd(istate, oid, fd, st, OBJ_BLOB, path, flags) < 0)
-			return error(_("%s: failed to insert into database"),
-				     path);
-		break;
-	case S_IFLNK:
-		if (strbuf_readlink(&sb, path, st->st_size))
-			return error_errno("readlink(\"%s\")", path);
-		if (!(flags & INDEX_WRITE_OBJECT))
-			hash_object_file(the_hash_algo, sb.buf, sb.len,
-					 OBJ_BLOB, oid);
-		else if (write_object_file(sb.buf, sb.len, OBJ_BLOB, oid))
-			rc = error(_("%s: failed to insert into database"), path);
-		strbuf_release(&sb);
-		break;
-	case S_IFDIR:
-		return repo_resolve_gitlink_ref(the_repository, path, "HEAD", oid);
-	default:
-		return error(_("%s: unsupported file type"), path);
-	}
-	return rc;
-}
-
 int read_pack_header(int fd, struct pack_header *header)
 {
 	if (read_in_full(fd, header, sizeof(*header)) != sizeof(*header))
diff --git a/object-file.h b/object-file.h
index c002fbe2345..7d48994f1b6 100644
--- a/object-file.h
+++ b/object-file.h
@@ -4,8 +4,6 @@
 #include "git-zlib.h"
 #include "object.h"
 
-struct index_state;
-
 /*
  * Set this to 0 to prevent oid_object_info_extended() from fetching missing
  * blobs. This has a difference only if extensions.partialClone is set.
@@ -14,15 +12,6 @@ struct index_state;
  */
 extern int fetch_if_missing;
 
-enum {
-	INDEX_WRITE_OBJECT = (1 << 0),
-	INDEX_FORMAT_CHECK = (1 << 1),
-	INDEX_RENORMALIZE  = (1 << 2),
-};
-
-int index_fd(struct index_state *istate, struct object_id *oid, int fd, struct stat *st, enum object_type type, const char *path, unsigned flags);
-int index_path(struct index_state *istate, struct object_id *oid, const char *path, struct stat *st, unsigned flags);
-
 struct object_directory;
 
 const char *odb_loose_path(struct object_directory *odb,
diff --git a/read-cache.c b/read-cache.c
index 23028f43a11..9909b56902f 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -10,9 +10,11 @@
 #include "git-compat-util.h"
 #include "bulk-checkin.h"
 #include "config.h"
+#include "convert.h"
 #include "date.h"
 #include "diff.h"
 #include "diffcore.h"
+#include "fsck.h"
 #include "hex.h"
 #include "tempfile.h"
 #include "lockfile.h"
@@ -4007,3 +4009,225 @@ int add_files_to_cache(struct repository *repo, const char *prefix,
 	release_revisions(&rev);
 	return !!data.add_errors;
 }
+
+static int get_conv_flags(unsigned flags)
+{
+	if (flags & INDEX_RENORMALIZE)
+		return CONV_EOL_RENORMALIZE;
+	else if (flags & INDEX_WRITE_OBJECT)
+		return global_conv_flags_eol | CONV_WRITE_OBJECT;
+	else
+		return 0;
+}
+
+/*
+ * We can't use the normal fsck_error_function() for index_mem(),
+ * because we don't yet have a valid oid for it to report. Instead,
+ * report the minimal fsck error here, and rely on the caller to
+ * give more context.
+ */
+static int hash_format_check_report(struct fsck_options *opts UNUSED,
+				    void *fsck_report UNUSED,
+				    enum fsck_msg_type msg_type UNUSED,
+				    enum fsck_msg_id msg_id UNUSED,
+				    const char *message)
+{
+	error(_("object fails fsck: %s"), message);
+	return 1;
+}
+
+static int index_mem(struct index_state *istate,
+		     struct object_id *oid,
+		     const void *buf, size_t size,
+		     enum object_type type,
+		     const char *path, unsigned flags)
+{
+	struct strbuf nbuf = STRBUF_INIT;
+	int ret = 0;
+	int write_object = flags & INDEX_WRITE_OBJECT;
+
+	if (!type)
+		type = OBJ_BLOB;
+
+	/*
+	 * Convert blobs to git internal format
+	 */
+	if ((type == OBJ_BLOB) && path) {
+		if (convert_to_git(istate, path, buf, size, &nbuf,
+				   get_conv_flags(flags))) {
+			buf = nbuf.buf;
+			size = nbuf.len;
+		}
+	}
+	if (flags & INDEX_FORMAT_CHECK) {
+		struct fsck_options opts = FSCK_OPTIONS_DEFAULT;
+
+		opts.strict = 1;
+		opts.error_func = hash_format_check_report;
+		if (fsck_buffer(null_oid(the_hash_algo), type, buf, size, &opts))
+			die(_("refusing to create malformed object"));
+		fsck_finish(&opts);
+	}
+
+	if (write_object)
+		ret = write_object_file(buf, size, type, oid);
+	else
+		hash_object_file(the_hash_algo, buf, size, type, oid);
+
+	strbuf_release(&nbuf);
+	return ret;
+}
+
+static int index_stream_convert_blob(struct index_state *istate,
+				     struct object_id *oid,
+				     int fd,
+				     const char *path,
+				     unsigned flags)
+{
+	int ret = 0;
+	const int write_object = flags & INDEX_WRITE_OBJECT;
+	struct strbuf sbuf = STRBUF_INIT;
+
+	assert(path);
+	assert(would_convert_to_git_filter_fd(istate, path));
+
+	convert_to_git_filter_fd(istate, path, fd, &sbuf,
+				 get_conv_flags(flags));
+
+	if (write_object)
+		ret = write_object_file(sbuf.buf, sbuf.len, OBJ_BLOB,
+					oid);
+	else
+		hash_object_file(the_hash_algo, sbuf.buf, sbuf.len, OBJ_BLOB,
+				 oid);
+	strbuf_release(&sbuf);
+	return ret;
+}
+
+static int index_pipe(struct index_state *istate, struct object_id *oid,
+		      int fd, enum object_type type,
+		      const char *path, unsigned flags)
+{
+	struct strbuf sbuf = STRBUF_INIT;
+	int ret;
+
+	if (strbuf_read(&sbuf, fd, 4096) >= 0)
+		ret = index_mem(istate, oid, sbuf.buf, sbuf.len, type, path, flags);
+	else
+		ret = -1;
+	strbuf_release(&sbuf);
+	return ret;
+}
+
+#define SMALL_FILE_SIZE (32*1024)
+
+static int index_core(struct index_state *istate,
+		      struct object_id *oid, int fd, size_t size,
+		      enum object_type type, const char *path,
+		      unsigned flags)
+{
+	int ret;
+
+	if (!size) {
+		ret = index_mem(istate, oid, "", size, type, path, flags);
+	} else if (size <= SMALL_FILE_SIZE) {
+		char *buf = xmalloc(size);
+		ssize_t read_result = read_in_full(fd, buf, size);
+		if (read_result < 0)
+			ret = error_errno(_("read error while indexing %s"),
+					  path ? path : "<unknown>");
+		else if (read_result != size)
+			ret = error(_("short read while indexing %s"),
+				    path ? path : "<unknown>");
+		else
+			ret = index_mem(istate, oid, buf, size, type, path, flags);
+		free(buf);
+	} else {
+		void *buf = xmmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
+		ret = index_mem(istate, oid, buf, size, type, path, flags);
+		munmap(buf, size);
+	}
+	return ret;
+}
+
+/*
+ * This creates one packfile per large blob unless bulk-checkin
+ * machinery is "plugged".
+ *
+ * This also bypasses the usual "convert-to-git" dance, and that is on
+ * purpose. We could write a streaming version of the converting
+ * functions and insert that before feeding the data to fast-import
+ * (or equivalent in-core API described above). However, that is
+ * somewhat complicated, as we do not know the size of the filter
+ * result, which we need to know beforehand when writing a git object.
+ * Since the primary motivation for trying to stream from the working
+ * tree file and to avoid mmaping it in core is to deal with large
+ * binary blobs, they generally do not want to get any conversion, and
+ * callers should avoid this code path when filters are requested.
+ */
+static int index_blob_stream(struct object_id *oid, int fd, size_t size,
+			     const char *path,
+			     unsigned flags)
+{
+	return index_blob_bulk_checkin(oid, fd, size, path, flags);
+}
+
+int index_fd(struct index_state *istate, struct object_id *oid,
+	     int fd, struct stat *st,
+	     enum object_type type, const char *path, unsigned flags)
+{
+	int ret;
+
+	/*
+	 * Call xsize_t() only when needed to avoid potentially unnecessary
+	 * die() for large files.
+	 */
+	if (type == OBJ_BLOB && path && would_convert_to_git_filter_fd(istate, path))
+		ret = index_stream_convert_blob(istate, oid, fd, path, flags);
+	else if (!S_ISREG(st->st_mode))
+		ret = index_pipe(istate, oid, fd, type, path, flags);
+	else if (st->st_size <= repo_settings_get_big_file_threshold(the_repository) ||
+		 type != OBJ_BLOB ||
+		 (path && would_convert_to_git(istate, path)))
+		ret = index_core(istate, oid, fd, xsize_t(st->st_size),
+				 type, path, flags);
+	else
+		ret = index_blob_stream(oid, fd, xsize_t(st->st_size), path,
+					flags);
+	close(fd);
+	return ret;
+}
+
+int index_path(struct index_state *istate, struct object_id *oid,
+	       const char *path, struct stat *st, unsigned flags)
+{
+	int fd;
+	struct strbuf sb = STRBUF_INIT;
+	int rc = 0;
+
+	switch (st->st_mode & S_IFMT) {
+	case S_IFREG:
+		fd = open(path, O_RDONLY);
+		if (fd < 0)
+			return error_errno("open(\"%s\")", path);
+		if (index_fd(istate, oid, fd, st, OBJ_BLOB, path, flags) < 0)
+			return error(_("%s: failed to insert into database"),
+				     path);
+		break;
+	case S_IFLNK:
+		if (strbuf_readlink(&sb, path, st->st_size))
+			return error_errno("readlink(\"%s\")", path);
+		if (!(flags & INDEX_WRITE_OBJECT))
+			hash_object_file(the_hash_algo, sb.buf, sb.len,
+					 OBJ_BLOB, oid);
+		else if (write_object_file(sb.buf, sb.len, OBJ_BLOB, oid))
+			rc = error(_("%s: failed to insert into database"), path);
+		strbuf_release(&sb);
+		break;
+	case S_IFDIR:
+		return repo_resolve_gitlink_ref(the_repository, path, "HEAD", oid);
+	default:
+		return error(_("%s: unsupported file type"), path);
+	}
+	return rc;
+}
diff --git a/read-cache.h b/read-cache.h
index 043da1f1aae..d655eb64bb7 100644
--- a/read-cache.h
+++ b/read-cache.h
@@ -42,4 +42,13 @@ static inline int ce_path_match(struct index_state *istate,
 			      S_ISDIR(ce->ce_mode) || S_ISGITLINK(ce->ce_mode));
 }
 
+enum {
+	INDEX_WRITE_OBJECT = (1 << 0),
+	INDEX_FORMAT_CHECK = (1 << 1),
+	INDEX_RENORMALIZE  = (1 << 2),
+};
+
+int index_fd(struct index_state *istate, struct object_id *oid, int fd, struct stat *st, enum object_type type, const char *path, unsigned flags);
+int index_path(struct index_state *istate, struct object_id *oid, const char *path, struct stat *st, unsigned flags);
+
 #endif /* READ_CACHE_H */

-- 
2.49.0.682.gc9b6a7b2b0.dirty

