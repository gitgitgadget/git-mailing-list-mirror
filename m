Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56102F25F4
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 07:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785828370; cv=none; b=PaioyHldWgT62j9571PpzEak62z8HNg9u5U9MoVto+T8VRYX7NceOuqHiQRrvjXiVf+AKsjEjxcDjY2mO3kn2//xY+VLCJD8+bArWTKGSAQYsw9wZZMWCUUk4FilHa+PxqPfwRNAmUEK8/c7S8P5LHYP3IaCXBn6ABb1mEKBJuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785828370; c=relaxed/simple;
	bh=eDZkau2yyZ47Ps9yxT50Y76FqHhJblfJRh9AT0yIbZo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ahz3F55KcTPQrtt3IHk3/t/vQBbimq56CS2qOdqsAnYDRlm6syDqfWkLKalhqkVgYjM4Ah7Ip5Q/4aWWr7Wirh1woNNxavZUusBUsoKPHyUNPf/GIINxj8F0xpT8xd5LVOhOe2u+bzozt9KboaeUUwTUW+BER7NthHbAdxtljos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TTCzcCpA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N90Xa6tx; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TTCzcCpA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N90Xa6tx"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 0E0DA1D001BD
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 03:26:08 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 04 Aug 2026 03:26:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1785828367;
	 x=1785914767; bh=c/9XFjvEXOyQyccAm66VM8kbWSTqS0QlAYhDVhQjKYg=; b=
	TTCzcCpAGyzRsRhUX78C8Xe2NgFA3TiMrGC64HcConcWBKL+wRMT050SCsIceQCl
	VeKA6YBumWHb5/Dfm0xR4pSozN5xjZ9OFXsl5alhM+FeU8xWssAXvGAyGC651WD/
	8Nvn6IaDJmKwq6L3wAZooKbfOSBgSOPBKIGhkx8LSE4atHUvL4naRmeJHkOa64qJ
	gGb57aeW+th+xMkLWJnpZvbuSkMxWa2h1+RUlj95tYI0RzD4o0xGoKgQfBuxL5v1
	cY0Aa879Jm3ud3XY+6hN6cu224S3R9r+8Y45bAwDg1Yzdf6uYfEPfqk4XYJ5TAYY
	FwIFs7+AaZ2N5nsdQ7Zk/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785828367; x=
	1785914767; bh=c/9XFjvEXOyQyccAm66VM8kbWSTqS0QlAYhDVhQjKYg=; b=N
	90Xa6txODeA0Od2k7LUYZ4IucXOiNexktU4E5e9Uzd+0vQBSrozwHzMjLe+zoqWU
	FSCLYCDX8oVVXFUcyAEPY10bASO9BkaCKWvwONKlyrxIETpQ7CpqnUDM4xTHu0yQ
	d5vpXeIIwfPegbLhSJ6+wNjl/PqDmROvfhgDDakscD95nD2dKAIWnyDFtu/WjqqJ
	O7qftHfwpCE/9KCFfYd8w3CF58aDXKN1YphpbTJ+KPYh6A23UOvvTg1NMo+PukVH
	V2wtF6eCsBA+VSEmhtiR2cRfjWuowpocet8ycycU84la1HSWZlDyeOpSTgGQXS6J
	FGZdwKNM3/VXPc9yXU5/A==
X-ME-Sender: <xms:D5RxagUy9DDFutwNBvt5upjCOyGXAUbEMHi0jXRPLg1Rb1pXBRITkQ>
    <xme:D5RxarjeJVYsNwxTLqoJbyA6imYxSDg1SXacBlqZWCKmS_BDLw7d5YY50zDGLsWoY
    -TZDmNzHrBe821AdBNp5jOMIfRZbijJSKg0mu494KA4KK-TKa4yqJw>
X-ME-Received: <xmr:D5RxaqCP-xG1MJ5TLOZFbBz8b8bXrvau3UdTZc56BQ9vwUqw7iKMTJ5cdKmQW0x35pWmP8U3ItGL6nkWiBJ8My7XcdTKQU2ywKFbCZ0U>
X-ME-Proxy-Cause: dmFkZTGJA/hd69o6AiEEnltmxxNPL/iz2JXYj1ZUCV9O8/iM3GIVZKb1NAe3PBzTWzWtB+
    O4CAqSBZES2dh/iHdrp95HkrzL3i2X/F9QiW1doHWb6x6GaLIXzJBuTNRp2y4lqMTv2GPB
    strxDCbZ/EYeXFpjwhGxsag30tHIR0f3Iac3xcq5uCaTWL6TQOZY6GBfzmgt06EFd2/PEV
    tiG3bIE1zpEvoMZ2EaS4OunWnPZ2CH/1Nsq1PgNvH5S47PGjbE4jcG6Ukz0+bMhrbt9Hsg
    HQqHiZld24lnD8uXrgPpPeulB5cTahmBAqH+Z2fisxWNmmWeJQiJh/a7h3YqjBCF/CcKlV
    KwWO1PsPE0IVkK5vmS4SGbRuhYa4rOw/hfRb6S2X381jQ6+gPXZFAyyhtQc12NV5t5Iam7
    qtOeNXSi+YhBo29Yz6QRcMvZs7RIFjOLluF57FTxagPeAGZjh0I7i9NOkPc+DQDTAWpmGg
    siumvojpKMsePH54FNLR7a3GDQPVMawbXUduZK00cNgNK7Kj35sidAOpWYmzOmb8a8NrLG
    lbqJg4pa3nxQwI2s0ro7IpMYvDFVzMM96R2aaJkDQxtKWF6YlVxJV5dZQx+OLgaP9Sg82E
    6LwysX42s8Guq7UwKXK6JaaNLJMeMj7iXrM3BBJFfiCEapi967rl5314glMQ
X-ME-Proxy: <xmx:D5RxakdoGzu8qP4tJW7moP7Xr7sZi-CTGZTWXgGtm1kLCKpzp3hd7Q>
    <xmx:D5Rxaqcl9B74Ek_mWKL6BTyV6u0Spevii2cxAv2N_eF1c2ohxjmtLg>
    <xmx:D5Rxagj_ZtG6uWOSKEBrGjgOX9dCRSLbfb3I7iEcgjPG53m1vO2ykw>
    <xmx:D5RxauTPWsxrqaqp0PFK1XC4uEQQn4rvdg0nvKlo-G_vIXodVZY-1w>
    <xmx:D5RxanlX5nrrWEn2dK46_bPT5PwH01WjzAG--LJDac0Nl3uAg46d1mHd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 4 Aug 2026 03:26:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 101ff84e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 4 Aug 2026 07:26:06 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 04 Aug 2026 09:25:35 +0200
Subject: [PATCH 7/7] odb/streaming: unify function names to create new
 streams
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-pks-odb-stream-unification-v1-7-86d70e82345e@pks.im>
References: <20260804-pks-odb-stream-unification-v1-0-86d70e82345e@pks.im>
In-Reply-To: <20260804-pks-odb-stream-unification-v1-0-86d70e82345e@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Unify the function names to create new streams from different sources so
that they follow a common schema. While at it, document the ownership of
the file descriptor passed to `odb_stream_from_fd()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 archive-tar.c          |  2 +-
 archive-zip.c          |  2 +-
 builtin/index-pack.c   |  2 +-
 builtin/pack-objects.c |  4 ++--
 object-file.c          |  4 ++--
 object.c               |  2 +-
 odb/streaming.c        | 10 +++++-----
 odb/streaming.h        | 23 +++++++++++++----------
 8 files changed, 26 insertions(+), 23 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index df2d7fb8e9..a1c66024d4 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -133,7 +133,7 @@ static int stream_blocked(struct repository *r, const struct object_id *oid)
 	char buf[BLOCKSIZE];
 	ssize_t readlen;
 
-	st = odb_read_stream_open(r->objects, oid, NULL);
+	st = odb_stream_from_object(r->objects, oid, NULL);
 	if (!st)
 		return error(_("cannot stream blob %s"), oid_to_hex(oid));
 	for (;;) {
diff --git a/archive-zip.c b/archive-zip.c
index 8095fd04d5..1a948c2f83 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -347,7 +347,7 @@ static int write_zip_entry(struct archiver_args *args,
 			method = ZIP_METHOD_DEFLATE;
 
 		if (!buffer) {
-			stream = odb_read_stream_open(args->repo->objects, oid, NULL);
+			stream = odb_stream_from_object(args->repo->objects, oid, NULL);
 			if (!stream)
 				return error(_("cannot stream blob %s"),
 					     oid_to_hex(oid));
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 7226da3e65..d1761282db 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -806,7 +806,7 @@ static int check_collison(struct object_entry *entry)
 
 	memset(&data, 0, sizeof(data));
 	data.entry = entry;
-	data.st = odb_read_stream_open(the_repository->objects, &entry->idx.oid, NULL);
+	data.st = odb_stream_from_object(the_repository->objects, &entry->idx.oid, NULL);
 	if (!data.st)
 		return -1;
 	if (data.st->size != entry->size || data.st->type != entry->type)
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 683160c6bb..10d00ca792 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -528,8 +528,8 @@ static unsigned long write_no_reuse_object(struct hashfile *f, struct object_ent
 		if (oe_type(entry) == OBJ_BLOB &&
 		    oe_size_greater_than(&to_pack, entry,
 					 repo_settings_get_big_file_threshold(the_repository)) &&
-		    (st = odb_read_stream_open(the_repository->objects, &entry->idx.oid,
-					       NULL)) != NULL) {
+		    (st = odb_stream_from_object(the_repository->objects, &entry->idx.oid,
+						 NULL)) != NULL) {
 			buf = NULL;
 			type = st->type;
 			size = st->size;
diff --git a/object-file.c b/object-file.c
index 068c6e5672..11d1af342e 100644
--- a/object-file.c
+++ b/object-file.c
@@ -952,8 +952,8 @@ int index_fd(struct index_state *istate, struct object_id *oid,
 		ret = index_core(istate, oid, fd, xsize_t(st->st_size),
 				 type, path, flags);
 	} else {
-		struct odb_stream *stream = odb_write_stream_from_fd(fd, xsize_t(st->st_size),
-								     OBJ_BLOB);
+		struct odb_stream *stream = odb_stream_from_fd(fd, xsize_t(st->st_size),
+							       OBJ_BLOB);
 
 		if (flags & INDEX_WRITE_OBJECT) {
 			struct object_database *odb = the_repository->objects;
diff --git a/object.c b/object.c
index 37e6efee47..97f7fc0e87 100644
--- a/object.c
+++ b/object.c
@@ -345,7 +345,7 @@ struct object *parse_object_with_flags(struct repository *r,
 	if ((!obj || obj->type == OBJ_NONE || obj->type == OBJ_BLOB) &&
 	    odb_read_object_info(r->objects, oid, NULL) == OBJ_BLOB) {
 		if (!skip_hash) {
-			struct odb_stream *stream = odb_read_stream_open(r->objects, oid, NULL);
+			struct odb_stream *stream = odb_stream_from_object(r->objects, oid, NULL);
 
 			if (!stream) {
 				error(_("unable to open object stream for %s"), oid_to_hex(oid));
diff --git a/odb/streaming.c b/odb/streaming.c
index c436b18d39..9c85ec54f5 100644
--- a/odb/streaming.c
+++ b/odb/streaming.c
@@ -208,9 +208,9 @@ ssize_t odb_stream_read(struct odb_stream *st, void *buf, size_t sz)
 	return st->read(st, buf, sz);
 }
 
-struct odb_stream *odb_read_stream_open(struct object_database *odb,
-					const struct object_id *oid,
-					struct stream_filter *filter)
+struct odb_stream *odb_stream_from_object(struct object_database *odb,
+					  const struct object_id *oid,
+					  struct stream_filter *filter)
 {
 	struct odb_stream *st;
 	const struct object_id *real = lookup_replace_object(odb->repo, oid);
@@ -242,7 +242,7 @@ int odb_stream_blob_to_fd(struct object_database *odb,
 	ssize_t kept = 0;
 	int result = -1;
 
-	st = odb_read_stream_open(odb, oid, filter);
+	st = odb_stream_from_object(odb, oid, filter);
 	if (!st) {
 		if (filter)
 			free_stream_filter(filter);
@@ -320,7 +320,7 @@ static int fd_stream_close(struct odb_stream *stream UNUSED)
 	return 0;
 }
 
-struct odb_stream *odb_write_stream_from_fd(int fd, size_t size, enum object_type type)
+struct odb_stream *odb_stream_from_fd(int fd, size_t size, enum object_type type)
 {
 	struct fd_stream *fds;
 
diff --git a/odb/streaming.h b/odb/streaming.h
index 60b9803190..b522ff513f 100644
--- a/odb/streaming.h
+++ b/odb/streaming.h
@@ -26,14 +26,22 @@ struct odb_stream {
 };
 
 /*
- * Create a new object stream for the given object database. An optional filter
- * can be used to transform the object's content.
+ * Create a new object stream for the given object. An optional filter can be
+ * used to transform the object's content.
  *
  * Returns the stream on success, a `NULL` pointer otherwise.
  */
-struct odb_stream *odb_read_stream_open(struct object_database *odb,
-					const struct object_id *oid,
-					struct stream_filter *filter);
+struct odb_stream *odb_stream_from_object(struct object_database *odb,
+					  const struct object_id *oid,
+					  struct stream_filter *filter);
+
+/*
+ * Create a new object stream for the given file descriptor. This can be used
+ * to, for example, stream an object into the object database. This function
+ * does _not_ take ownership of the file descriptor. It's the responsibility of
+ * the caller to close it after the stream has been closed.
+ */
+struct odb_stream *odb_stream_from_fd(int fd, size_t size, enum object_type type);
 
 /*
  * Close the given object stream and release all resources associated with it.
@@ -65,9 +73,4 @@ int odb_stream_blob_to_fd(struct object_database *odb,
 			  struct stream_filter *filter,
 			  int can_seek);
 
-/*
- * Sets up an ODB write stream that reads from an fd.
- */
-struct odb_stream *odb_write_stream_from_fd(int fd, size_t size, enum object_type type);
-
 #endif /* STREAMING_H */

-- 
2.55.0.679.g6767b8d81c.dirty

