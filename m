Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80262459E1
	for <git@vger.kernel.org>; Sun, 23 Nov 2025 19:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763924431; cv=none; b=ZFRcXh7koEPTLHA7YgGWd2h+5KkAUYNlpmyT/VJWzsmhZezsnfibxU6yiwx7LNqfVRLu7hkEC2TLho2cEArRdmZGawFUv5jP9SImUx6Qb5CgjZEBYjA+u7THZqFJ0i3bvjTVbFQQhGZXWEHJmPSyleIZHorqUMeckCVhVedlU1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763924431; c=relaxed/simple;
	bh=MdKNKrlx07oP1WNHprfL2dRRamUCDD8AAT6bNTz/Fa0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KT0EddmVMJqnt4LBWhUrmZRESMXqcg1HVkcFEJ7KyefOo2KKa6D4rLae7IXq1BldAJIqP9b5ZdQRoqZD4jOkWg7PVWmotoCCX4YXCV1qpr9V+kj8WG3ilESv3p9G8na8No9ihCYAWbf6kK42mQAS7rKrgCuAJ2Icaw0XXN1b9EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XUWYLkzF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=u9lb++zy; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XUWYLkzF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="u9lb++zy"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 099387A00EF;
	Sun, 23 Nov 2025 14:00:29 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Sun, 23 Nov 2025 14:00:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763924428;
	 x=1764010828; bh=+W8kTv7k7KkE64VC4oefcVAilCmSOe8I6DwsUvA3HUc=; b=
	XUWYLkzFtRnTBYpg2kaAqrh1iy7BELPprit8+jDGJthor+o29cc7e0TS7s7d9gCs
	4oywm13tuvcd0vsahzhqKV5JQTWWWS8+GqtITVuUg2RLXH2NCJsy8bM2CqXDeXh7
	cpCmdg/Tl4bJA7Sr3bnxOzSp8Us/dfFahwgr3RqEjBOESuOrDBO6ZHkxdApLMHrq
	+O4KbX/Z9p2nIQppOD4XNP7ymA/jWTfhsKx3JrY11uAS/IwuzByh5jHEw/PuwCT+
	fi207Q3zFT7HOqUPO8EG679N/Zd8ZymUu0VuO8eiMxplgeaKuIz0Sd/xN14Mtmlx
	JPJ3IPvodJJvt1yyknWP7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763924428; x=
	1764010828; bh=+W8kTv7k7KkE64VC4oefcVAilCmSOe8I6DwsUvA3HUc=; b=u
	9lb++zyt3bwuocj4u6mEYJfwSiXH6+t0eyV6yk8wqdf122IQQr6JM4X+jS2HBhoA
	EXp+kJ8QS+UWnvd3kL+mBK+ON399ZxGqg3lABQ25wkPAQ9LDTQzmFblRhoDKexNp
	HEPO1Zau/KDci9lydGAYNFZ4Q0dAdG75gKp+SrUBm0n707NYA8dJsVsvfmgTCAez
	eLWdPP/BM6tjaglAfre/Cn8HJKbSWzZ0gZhqk5rwxK4hoqmff765OLLZeqqF9dmA
	AmvlV8JGWPkn6toEDK+bY1e10h4iN4Ber3urAWmGY/MPzvo9d+pt+g2zf+8GKrKk
	8EMsckXnBGSMc45vvcaQQ==
X-ME-Sender: <xms:zFkjaY7l_2W5cM9qMN_k68Uqw7Z7_Us-oHs7MAnR5US8EBMpE-_CvA>
    <xme:zFkjaQ4SSXzlpBCQRrZURwd7aOi1pqbrl3kl8DHYK7XGTaiHDGoZaN0ZInycN9UxS
    XHgPSfI1-Ckd2-D9wRN5c_RycRwgBQm0-OWkk1PoX643_TVx8oXkA>
X-ME-Received: <xmr:zFkjacdRJ8j4D4bbBB6ci1SpaQC1JdhoXH1ViJEiz47KULDFz4gycoRd6r-MKovrjlDrnqtmP5RqYnHbVLeZ6l-ktLkiDhqEBOuOCpEDGWLa2g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeeihedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeekieevveegieevieeuveefheffgeeuheetheegffffkeeijedtueefleffvdevleen
    ucffohhmrghinhepphgrtghkvggurdhishenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeg
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:zFkjacCpylqU_e1eSM5C9nbmVi3jOkMv7koGOpYOGdamksnDB9UMXg>
    <xmx:zFkjaX_8DWdcKmmV5Al5ByLZqs1KWF9TPhRWHlBvIO9UWOSpay9siQ>
    <xmx:zFkjafLpeKdS1v4M6juVrgJJN9WEqVEVQEHjkGOrgEaExEnzdJPcsg>
    <xmx:zFkjaYgbrv_9P4oavGKQOjgI5_N3LWllxzWH6mwnu4zje8vIgvVgNQ>
    <xmx:zFkjab_WUIKeq0RhT1w3MvtUVHXegRDgRRyRHsZdUfvxKC6-kHlhtlZd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Nov 2025 14:00:27 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2f05a85d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Sun, 23 Nov 2025 19:00:27 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Sun, 23 Nov 2025 19:59:38 +0100
Subject: [PATCH v3 13/19] streaming: get rid of `the_repository`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251123-b4-pks-odb-read-stream-v3-13-1a129182822b@pks.im>
References: <20251123-b4-pks-odb-read-stream-v3-0-1a129182822b@pks.im>
In-Reply-To: <20251123-b4-pks-odb-read-stream-v3-0-1a129182822b@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
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
index f0f7d31956..807a6e03a8 100644
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
@@ -518,8 +516,11 @@ struct odb_read_stream *open_istream(struct repository *r,
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
@@ -527,7 +528,7 @@ int stream_blob_to_fd(int fd, const struct object_id *oid, struct stream_filter
 	ssize_t kept = 0;
 	int result = -1;
 
-	st = open_istream(the_repository, oid, &type, &sz, filter);
+	st = open_istream(odb->repo, oid, &type, &sz, filter);
 	if (!st) {
 		if (filter)
 			free_stream_filter(filter);
diff --git a/streaming.h b/streaming.h
index f5ff5d7ac9..148f6b3069 100644
--- a/streaming.h
+++ b/streaming.h
@@ -6,6 +6,7 @@
 
 #include "object.h"
 
+struct object_database;
 /* opaque */
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

