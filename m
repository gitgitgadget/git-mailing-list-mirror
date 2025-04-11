Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746B42989A8
	for <git@vger.kernel.org>; Fri, 11 Apr 2025 09:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744363808; cv=none; b=E7U5Z75izkDjecG+ruIk+b89ByH8KgKBGHKOQ8hjV/gzB5OsKp7R5xcEJ6buYWuwZZwzkFDZKDvaTpTt8pKB1PrP+8TfMGpQML7Y/5DsjPz+hlVRkwSiR/2Uty+Z3jQnn1ePqVJM2xvZScG3lSD/mWUoHu6DrIru6itZ1PIsZLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744363808; c=relaxed/simple;
	bh=nr7TmsvfQbPAD4y4hFKOvO2SYRXXnJcVsahlFhrAO48=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T8obQNPi/mh0YjSknhmPFT7SjRZ/QXX1e0jSwBf5C+pmEh20x+TuoY85mnoU0zpn1HhAsXgmViko0xsXc5f5fGkgRAWnrSTnyCL4wOB7/16lxO+W+b6IXHwCnNTub/m+3G6knfE3lBQ201IDvHlAGJ/sjfxgUf/nRXuiMiTjkco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jrxrwZ6L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NROGZdpI; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jrxrwZ6L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NROGZdpI"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 71B0C11402CB;
	Fri, 11 Apr 2025 05:30:05 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 11 Apr 2025 05:30:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744363805;
	 x=1744450205; bh=jqFcfpCoE7r14hiCo0rI0qGVRwr5IfvcB+TuV6j81MU=; b=
	jrxrwZ6L9P48XnE0m2zbxzDFuvD/pAx1Z3X5o0Eu7XYRSu/Y0uqAL12QggWnp/Vm
	pbIINU3/3IPu4VqyZRyAOJi1mSHFV05TGK8CNihII8vsLFw+QDj2KosNmXur8UnI
	tFNbg2BawGhcRrpjczvjwmgTMc+ycPe/TMP4u8PmD5E2Oijt7sEeCBTkqTxhQwJu
	imSloBykvu1GbsF9LnE2WTUW9sA+Q643YZtVkweK4yU4s32NOXZKj/Z6+0eHr0ME
	aa4odHOFGE2bK+DLDsPWQ0F8ZWSs5uwHunTp2lA0tYmgctuPtgM7U3yvn4gKoY78
	yV6y2mkDHvWxj42AqVLJzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744363805; x=
	1744450205; bh=jqFcfpCoE7r14hiCo0rI0qGVRwr5IfvcB+TuV6j81MU=; b=N
	ROGZdpIKlcil42doRustziki6UYaHQJhXv6xImDsUsdBvIcKd6H9kEujmzFLvcw0
	ufdjL8TgnnIzmu1xHCRkqTrGmS0kEYzQ1/O3jMNup451euKM0acm9az6PnH9yJ50
	JHkhgtRIwvoS0LP5apSmRo8Y1Mj3iuK8TFMwbyonGnTZGPVjTQWdlpIsH7z9mpIJ
	UA2LIXhnzXI/tDxSFfFNnbdK18vOhekrKbyFx51yOIwjFyt+8X5oTuyTKuNxU6Py
	hmDr3fwii1UjEKuKwVgcxmZLJLC3Y8eCxwg5phSZBTVt/ZRm+hDGSADCPI4gwWgs
	seEhZkIBmPaq9Xk0mUB6A==
X-ME-Sender: <xms:HeH4ZxCDM5tu02wqBCszPSHjfqHThs_n3ul3NNaPK5WKLbpzlfZHEA>
    <xme:HeH4Z_hJZVfPv1-2QAbr1VO3aVXVH7iAsPTRKbLiRB1PXWXBSvIn8JNC1rSrIMqBL
    gLZzbHA7vpODvm5Qg>
X-ME-Received: <xmr:HeH4Z8mmlW6GhsGz04jL0UVrJoEh-dQJuiMyq9XOW00SjYmVJgWFTlojfgkJxYKDi92SUFip8nr85V7G9b-Vgk7YcZ3XrEP_j5TPztwy13HeKrE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvuddugeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:HeH4Z7wFwN2HoAc4_FgjO5xdXDS3Bo7xWCcJEU9Gnk7bhTfxrxksQw>
    <xmx:HeH4Z2QdfX3V8tEeV5yfWIbKnuYRUutROuVjb2_u6C8gGrcXRb1aMw>
    <xmx:HeH4Z-b3wyfM6K2nLzihJBoFvWGf4YNuZLWzLd7qFWUvG4gRg2StzA>
    <xmx:HeH4Z3TCzm2wWS2pcsBxfjD9kMoUAnGTjv_7ElpEVjnuz1X9Q-QSsQ>
    <xmx:HeH4Z7Pb-5fKKTxnspEEWFXgbDke4I_1GKBZiM7o-DXwTzfDHXQrLGoN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Apr 2025 05:30:04 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7f20a569 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 11 Apr 2025 09:30:03 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 11 Apr 2025 11:29:55 +0200
Subject: [PATCH v2 6/9] object-file: split out functions relating to index
 subsystem
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250411-pks-split-object-file-v2-6-2bea0c9033ae@pks.im>
References: <20250411-pks-split-object-file-v2-0-2bea0c9033ae@pks.im>
In-Reply-To: <20250411-pks-split-object-file-v2-0-2bea0c9033ae@pks.im>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Junio C Hamano <gitster@pobox.com>
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
2.49.0.777.g153de2bbd5.dirty

