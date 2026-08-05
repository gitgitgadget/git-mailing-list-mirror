Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737E63E6DC8
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 07:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785915921; cv=none; b=lxWzxBATzGdp3ns+FIDsdN9imlLwvedB7UwDVXs8SsKGdmE5cR9FgrbxrDZRckTVo3GdiYYlb6z3+pIBWLUG2+k1ghZeXKcXEpX1X6y02Roqi8unv2LM2lGesCcUSfQ5GlBlaUEsa8RHhBVMTR1ct9MdactaCdQxg0M/atkR9n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785915921; c=relaxed/simple;
	bh=eDZkau2yyZ47Ps9yxT50Y76FqHhJblfJRh9AT0yIbZo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mhtaQe3TgMMA4qvhlc5SiYNEm303on20QTY4JBnBiDfIqmBH9lbjRjHmOT2KV1PJKFRxhWSBq5P1n3IOSPnQ1YKecbCO2cE4zYFy8YzILyKfr/21TyVUDREMRNz29/3QIaRo8w1TTHeVy0vpt6+MFnba9uqJwL7JSGX+tcU19Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DsE1TV9Z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c/8MexzG; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DsE1TV9Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c/8MexzG"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 95BBDEC00E1;
	Wed,  5 Aug 2026 03:45:18 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 05 Aug 2026 03:45:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1785915918;
	 x=1786002318; bh=c/9XFjvEXOyQyccAm66VM8kbWSTqS0QlAYhDVhQjKYg=; b=
	DsE1TV9Zn72f+344TmUuc4dN8ps4V2kIeI0cAl0nrPHwiiCA6FE4vcST1YnP8En+
	Y4xNpBSQUklERwGaPlAVFdzfePks8+aJrCGyKMyLdtkDTxgOwwliPsl1d/U3wtsa
	9jW2hiigKH6Z9chGIpkdbwa1Qo6KGviR6EN50sO+Q7GEqyCPFOA1T0YzOXPgNL5S
	8vj5WUEMzByT9YWp7M6LVy+c0jVDYvO9JQQmQEQ+Yov5FwURcL+OVh5q9Eiebq34
	D2dcesKV757zeD+Uc8l3ilBdy+KzSxNw0aaR1K3DDeHAJT5iFF3nOl4zdOgyAEwc
	6crNogNPmigFHm/FLbphzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785915918; x=
	1786002318; bh=c/9XFjvEXOyQyccAm66VM8kbWSTqS0QlAYhDVhQjKYg=; b=c
	/8MexzGVO0w8fai3MZSFPStaIot1pSkoW9wy/r57D3roaHyzObr2m3iNqn+59BSb
	Ag/7JiHFA6o/gtQKwCm0bsIF02GNjR5U+yZ/BHaBE92DyRLuHZU/uSnw28U8MQpq
	chYMQonITez+zecIuZtXu9rJMjqGXOWo8Zjo5GokMA5rWhG+iIrIKPJOz8eMbm6q
	5b0Awg+G13xazGRrVJYe0pRRGDfD0UxwpxjTON1OydEUCtESyVl1OcXF3WWC1GG+
	8ajcKMzf9SzdMnw6Y7Spwe69bPYUASiNxt63w4cuCo3VLigKyleXr9ODSISxm66n
	vS8gjgkp1HxCGp7hNmp5A==
X-ME-Sender: <xms:DupyahSEKV1a8NMb5wt_UaIvKCcCWRkqVj0FEiaETCDbSQvMG9GSAQ>
    <xme:DupyaiMsmcNT8wtGCWTVUezaow0LnCO5YzsoUsT01C63evKYKu2bdBIhd-Q5Mst01
    Sz33iXOC3lnKNoe724zUJbdh_dsUumTs4UszKt5JTQozoSWbtp21g>
X-ME-Received: <xmr:DupyakNFoSTFD8Zw5CEPDXOWyfiSeW5dSnXAIksMJBy-P6z9bmmLMlDPN021yzSmX0ggQsw4c4_vnn9acs02QeijuIbxQXRaz08wTSYZGg>
X-ME-Proxy-Cause: dmFkZTGmCW7FS5WU705XWsAUlCL2gb7Dg3VPhOR8EIMEigdVk2tgGbZg8bV7NnSm2EME+B
    6B0IbGHx+c50eWimkZF2a9OcVem+ot5nHi8FpDSM98u39bYEaTXWwt4FuP6kivtt+4/9O5
    /Av2bRjLClE2AgyaNo+c8BMZjn6KfKeheuuTXw+w3HCRQ3Ru8ix6PbDoPBHTmhpj/vIjAY
    VkdEHfFNdXb4/+Y/PZXIOZ2gZwCyuc9LPHTjpWTx96RMhiFZ8IqYxmw6Ibk5gBfMargK6x
    4i+M7wP1gSRi48ogUVpfbe2gUJbsGPWoK1OYF2ZuNQ9C5kiM+cBug8OrRwW40VO7A7sCCe
    8KGQ+1F49eSTUi5J9Pu8K8Ya6zH5HrYkCQIQOe1kUWyFIOwmkc4B7F7GEmNKKI0ji6uWtC
    dYF4S4Ouo5tRmNK13SXv7hfVauMscA04ZLLHZaCaLVPStsnPzeMvTPpJ+OZwm5iz1ZsuME
    xMto62S4QzWd1LLINC1VAZREFtBe/um4f0sXEpQmQN6XKj0iVH9WFfmCYsJOM8RbnCXdq+
    wfl7jEDAhb9kdqvfICzuFY0etdNiu4Odvr7fNNRfxK/fdgjrkdnLMts5IsuWS8Iyz0783y
    C/PAylOmQR6JJ1Iwv4ngQOzhNUwM6piUQ9dwXoSLjiylDG2XNsCaj/dfJjyA
X-ME-Proxy: <xmx:Dupyaiszc1mKGoP_jlgc5zifGzRnYdLxg8rtwWd0VlHmIOnS9kDI8Q>
    <xmx:DupyauXmCnZnOFtm814dV2oXpBYn9kxsgOFk60xRi9BHKVrhkauYbg>
    <xmx:DupyaquOw4kGZCXhD5CY4ydR3jb4KUf-jVim7Zel1abrxJzE6oX0xQ>
    <xmx:DupyaqVq6Jdyoi01S-XhCmHreZ878TqlEVJUnIvaYaaMzOZ_nNdgaQ>
    <xmx:DupyaiNAZ3gBsvxexCFMFk8l0w0CTMv4lEtT7AE514Xf3vtVDQbPlv1f>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Aug 2026 03:45:17 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 98192ce0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 5 Aug 2026 07:45:17 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 05 Aug 2026 09:44:52 +0200
Subject: [PATCH v2 8/8] odb/streaming: unify function names to create new
 streams
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-pks-odb-stream-unification-v2-8-b8c369564641@pks.im>
References: <20260805-pks-odb-stream-unification-v2-0-b8c369564641@pks.im>
In-Reply-To: <20260805-pks-odb-stream-unification-v2-0-b8c369564641@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
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

