Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D834430E822
	for <git@vger.kernel.org>; Fri, 21 Nov 2025 07:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763710912; cv=none; b=bC5/6TRvhpzwP0seWjG1xg7/tySWfNEcxHJjI/p+aXiNyk5BNP78++8fcUMnu0X7L9pOxk4oviND76yiczJjgzTxYTd4UubpMlgQPkE/seSaXPcRvUJabFFI/EmEaFfV7mmtoA5z4JRt70Vrl/G1FjqiwasvZtDvLa3z0/LCIHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763710912; c=relaxed/simple;
	bh=T8YCWXnCNhDDdxwrwdL98P2YyQTPvDQpcqGoWk+k3WI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Os3wP1ql6JS3FQr1yhrzgUbby4DRPfV+q7KnjaRq06i4dc2JnIC7d1NJkX4bCMfwgZrQkB9jpOk0bQ7Jsv3B7WylIwXFuLlwIhcn9X5wrEEdaqBq0qTJiGjJ9IZJ0p86CUBGIwtbJG5413TIOXUBdX9zZXoLCp+CMkmrVl+JvJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=irQY/qco; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ONwubntr; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="irQY/qco";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ONwubntr"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 37D121D0015F;
	Fri, 21 Nov 2025 02:41:50 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 21 Nov 2025 02:41:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763710910;
	 x=1763797310; bh=uizdUQ+qR7UcVXgbkQ/Dl5vaGsD5tXGUhBSsNLWp3ko=; b=
	irQY/qco24+F5Wb58rrUuU1dZDJFOUQRwGdWR2+fv2NUmx30a6h343sH/MzEyGhc
	NNct0ozUOjSW1m0AKsKHReobe+MQkvxYo2hMV7U7Zd+KwQzKZ625ofz5tRoH22ja
	PCeQz1zHmnWPmYIn+8YgI2chY1lk/sIrK56BJnhLycCeJCJjgme97UWn5kEZdwR5
	89+1KVXrmSJc47B4QjyFR2B8wyD2kXYrApqYSivNllo/fpy/i0ydKDI7aTdedq1Y
	YNSiYd/TEZivuiIZv0/b6Xlb/ijG7gZiH26qNNBbEvriWz09bBxNx4s8BZoerZSX
	rnNwcvEHKZh+euCA2bo2iw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763710910; x=
	1763797310; bh=uizdUQ+qR7UcVXgbkQ/Dl5vaGsD5tXGUhBSsNLWp3ko=; b=O
	NwubntreSFuGfNcD0C5vS4Fp0PZdaBotyD343SByNq7s3/7hM49t8AvBvTKbhk7p
	Fitl7TpC27JN8jk/HXBuMpAI75GxcG0XTyZiJ0WARCuxpLZbpgqKLDwR23TgmzmY
	1wQWBqTwDy2KW5iHunyqDUXKmSvaoNhVK1YQJtrn3uf+FQGxtD7XyNnMJqBfL+TZ
	u5rE5zuJ7kwIVnrl9FH0r/tYuBSdsNwEXO5uqyzdwt6q/O1DoimHpwM54Vcr0KvH
	hGacG1Zzdhn81QgQh0op/ayWW4A7lt21TbpG7dygk3AOBLNz2fR5WyPlXi0OcLcd
	Ul2om+t/53k0mLJt5+TiA==
X-ME-Sender: <xms:vRcgaePNEpFTScfmm_C86zOl4J1_QM1LSVBmT-bobBMr4lXxEyx7-A>
    <xme:vRcgaUaTEQOHJVh-VTGfrSZPj6tJscGmfdlCkpqtVdLW5mq8wVYN8NBj8X45kkeXk
    obqMFMhcPqAqQTVLG2Zz-eZJEpBee-Z_K7qZTF00qFUMecXMySzVw>
X-ME-Received: <xmr:vRcgaSqh0sXshUJwIjuII-JgF3Yf7qivYp6WM-Aog3H4pNgcwRs2rFsPew4UxaxeXfIQ2Ki_5UdpuqQEPoduXfNLT8oKDp4s1T4VWNF3gDgc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdelfeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeekieevveegieevieeuveefheffgeeuheetheegffffkeeijedtueefleffvdevleen
    ucffohhmrghinhepphgrtghkvggurdhishenucevlhhushhtvghrufhiiigvpedunecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeef
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:vRcgaYbe_F5lJLvIxQnuzsMkPUYaGqXa73oOO5nsL6ZvUzgboqsBxQ>
    <xmx:vRcgaaSegGMNM4yThsmiMCAlh32qNFV_iRXSBExGcTC5rvbxXXTyag>
    <xmx:vRcgaf5kDG7Y-mFKCkrtzn89zH1Q_-O6Yzupb8A3kYmVAGzOwOiZ4A>
    <xmx:vRcgafw9_slcad70d5yUPnazoBgvLWOhSH7VKdzxKQoYXUBvmwuPog>
    <xmx:vhcgafldgpmJeZsXyL0gizRekIKRN4K4HrEdkSApDzsU1r6cou_z3wuQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Nov 2025 02:41:49 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3210e2a8 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 21 Nov 2025 07:41:48 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 21 Nov 2025 08:40:58 +0100
Subject: [PATCH v2 13/19] streaming: get rid of `the_repository`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-b4-pks-odb-read-stream-v2-13-ca8534963150@pks.im>
References: <20251121-b4-pks-odb-read-stream-v2-0-ca8534963150@pks.im>
In-Reply-To: <20251121-b4-pks-odb-read-stream-v2-0-ca8534963150@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.3

Subsequent commits will move the backend-specific logic of object
streaming into their respective subsystems. These subsystems have gotten
rid of `the_repository` already, but we still use it in two locations in
the streaming subsystem.

Prepare for the move by fixing those two cases. Converting the logic in
`open_istream_pack_non_delta()` is trivial as we already got the object
database as input.

But for `stream_blob_to_fd()` we have to add a new parameter to make it
accessible. So, as we already have to adjust all callers anyway, rename
the function to `odb_stream_blob_to_fd()` to indicate it's part of the
object subsystem.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/cat-file.c  |  2 +-
 builtin/fsck.c      |  3 ++-
 builtin/log.c       |  4 ++--
 entry.c             |  2 +-
 parallel-checkout.c |  3 ++-
 streaming.c         | 13 +++++++------
 streaming.h         | 18 +++++++++++++++++-
 7 files changed, 32 insertions(+), 13 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 983ecec837..120d626d66 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -95,7 +95,7 @@ static int filter_object(const char *path, unsigned mode,
 
 static int stream_blob(const struct object_id *oid)
 {
-	if (stream_blob_to_fd(1, oid, NULL, 0))
+	if (odb_stream_blob_to_fd(the_repository->objects, 1, oid, NULL, 0))
 		die("unable to stream %s to stdout", oid_to_hex(oid));
 	return 0;
 }
diff --git a/builtin/fsck.c b/builtin/fsck.c
index b1a650c673..1a348d43c2 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -340,7 +340,8 @@ static void check_unreachable_object(struct object *obj)
 			}
 			f = xfopen(filename, "w");
 			if (obj->type == OBJ_BLOB) {
-				if (stream_blob_to_fd(fileno(f), &obj->oid, NULL, 1))
+				if (odb_stream_blob_to_fd(the_repository->objects, fileno(f),
+							  &obj->oid, NULL, 1))
 					die_errno(_("could not write '%s'"), filename);
 			} else
 				fprintf(f, "%s\n", describe_object(&obj->oid));
diff --git a/builtin/log.c b/builtin/log.c
index c8319b8af3..e7b83a6e00 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -584,7 +584,7 @@ static int show_blob_object(const struct object_id *oid, struct rev_info *rev, c
 	fflush(rev->diffopt.file);
 	if (!rev->diffopt.flags.textconv_set_via_cmdline ||
 	    !rev->diffopt.flags.allow_textconv)
-		return stream_blob_to_fd(1, oid, NULL, 0);
+		return odb_stream_blob_to_fd(the_repository->objects, 1, oid, NULL, 0);
 
 	if (get_oid_with_context(the_repository, obj_name,
 				 GET_OID_RECORD_PATH,
@@ -594,7 +594,7 @@ static int show_blob_object(const struct object_id *oid, struct rev_info *rev, c
 	    !textconv_object(the_repository, obj_context.path,
 			     obj_context.mode, &oidc, 1, &buf, &size)) {
 		object_context_release(&obj_context);
-		return stream_blob_to_fd(1, oid, NULL, 0);
+		return odb_stream_blob_to_fd(the_repository->objects, 1, oid, NULL, 0);
 	}
 
 	if (!buf)
diff --git a/entry.c b/entry.c
index cae02eb503..38dfe670f7 100644
--- a/entry.c
+++ b/entry.c
@@ -139,7 +139,7 @@ static int streaming_write_entry(const struct cache_entry *ce, char *path,
 	if (fd < 0)
 		return -1;
 
-	result |= stream_blob_to_fd(fd, &ce->oid, filter, 1);
+	result |= odb_stream_blob_to_fd(the_repository->objects, fd, &ce->oid, filter, 1);
 	*fstat_done = fstat_checkout_output(fd, state, statbuf);
 	result |= close(fd);
 
diff --git a/parallel-checkout.c b/parallel-checkout.c
index fba6aa65a6..1cb6701b92 100644
--- a/parallel-checkout.c
+++ b/parallel-checkout.c
@@ -281,7 +281,8 @@ static int write_pc_item_to_fd(struct parallel_checkout_item *pc_item, int fd,
 
 	filter = get_stream_filter_ca(&pc_item->ca, &pc_item->ce->oid);
 	if (filter) {
-		if (stream_blob_to_fd(fd, &pc_item->ce->oid, filter, 1)) {
+		if (odb_stream_blob_to_fd(the_repository->objects, fd,
+					  &pc_item->ce->oid, filter, 1)) {
 			/* On error, reset fd to try writing without streaming */
 			if (reset_fd(fd, path))
 				return -1;
diff --git a/streaming.c b/streaming.c
index fc7d88e313..41c2070941 100644
--- a/streaming.c
+++ b/streaming.c
@@ -2,8 +2,6 @@
  * Copyright (c) 2011, Google Inc.
  */
 
-#define USE_THE_REPOSITORY_VARIABLE
-
 #include "git-compat-util.h"
 #include "convert.h"
 #include "environment.h"
@@ -359,7 +357,7 @@ static int open_istream_pack_non_delta(struct odb_read_stream **out,
 
 	if (packfile_store_read_object_info(odb->packfiles, oid, &oi, 0) ||
 	    oi.u.packed.is_delta ||
-	    repo_settings_get_big_file_threshold(the_repository) >= size)
+	    repo_settings_get_big_file_threshold(odb->repo) >= size)
 		return -1;
 
 	in_pack_type = unpack_object_header(oi.u.packed.pack,
@@ -519,8 +517,11 @@ struct odb_read_stream *open_istream(struct repository *r,
 	return st;
 }
 
-int stream_blob_to_fd(int fd, const struct object_id *oid, struct stream_filter *filter,
-		      int can_seek)
+int odb_stream_blob_to_fd(struct object_database *odb,
+			  int fd,
+			  const struct object_id *oid,
+			  struct stream_filter *filter,
+			  int can_seek)
 {
 	struct odb_read_stream *st;
 	enum object_type type;
@@ -528,7 +529,7 @@ int stream_blob_to_fd(int fd, const struct object_id *oid, struct stream_filter
 	ssize_t kept = 0;
 	int result = -1;
 
-	st = open_istream(the_repository, oid, &type, &sz, filter);
+	st = open_istream(odb->repo, oid, &type, &sz, filter);
 	if (!st) {
 		if (filter)
 			free_stream_filter(filter);
diff --git a/streaming.h b/streaming.h
index f5ff5d7ac9..1a3de6812e 100644
--- a/streaming.h
+++ b/streaming.h
@@ -7,6 +7,7 @@
 #include "object.h"
 
 /* opaque */
+struct object_database;
 struct odb_read_stream;
 struct stream_filter;
 
@@ -16,6 +17,21 @@ struct odb_read_stream *open_istream(struct repository *, const struct object_id
 int close_istream(struct odb_read_stream *);
 ssize_t read_istream(struct odb_read_stream *, void *, size_t);
 
-int stream_blob_to_fd(int fd, const struct object_id *, struct stream_filter *, int can_seek);
+/*
+ * Look up the object by its ID and write the full contents to the file
+ * descriptor. The object must be a blob, or the function will fail. When
+ * provided, the filter is used to transform the blob contents.
+ *
+ * `can_seek` should be set to 1 in case the given file descriptor can be
+ * seek(3p)'d on. This is used to support files with holes in case a
+ * significant portion of the blob contains NUL bytes.
+ *
+ * Returns a negative error code on failure, 0 on success.
+ */
+int odb_stream_blob_to_fd(struct object_database *odb,
+			  int fd,
+			  const struct object_id *oid,
+			  struct stream_filter *filter,
+			  int can_seek);
 
 #endif /* STREAMING_H */

-- 
2.52.0.rc2.482.gaa765fefd0.dirty

