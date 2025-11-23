Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7DB258CD7
	for <git@vger.kernel.org>; Sun, 23 Nov 2025 19:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763924451; cv=none; b=H6coy8AiJZZ+xMhhsaRmfmVr5k380ZAbedaAjaLve+TwhMmgchqQN+fAtJkPODUOWMQtPXzktARZ5EcY8FjxLsLRpPGh1fmBRvJzGh+9wKYJea7FgM1gi3gXebPGjzdCEUB/3UGzEvL9a/dygeYf40eAZmZE7/Ek3R3psHbbMmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763924451; c=relaxed/simple;
	bh=QssWgpIDiAf2188usSrq/DShvB/AhJ7/lbY/jdSJUGY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tyz1bLzF5ufxPr+QW5EJVyrq+zmkExqHmUGTbNImvdcF5ildQkCephds11HOgV10XBkMQ+a9JQznqtZ8Bl72izqrVFwV4V0thk+bxeRzzQ1Ii4lasL7ok26qIpbePzgqCsuzMUOb6vP1YYpjtcyUOZZVR9y9sLiJQ6hVHza+6qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IzJ27vYR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SyWvPPDr; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IzJ27vYR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SyWvPPDr"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 2B0B81D000BF;
	Sun, 23 Nov 2025 14:00:49 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Sun, 23 Nov 2025 14:00:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763924449;
	 x=1764010849; bh=/2BHs8GtZlNkqov4nhQYaj2io6npJ/rZNaZbdR5EzMg=; b=
	IzJ27vYR8u/ke0kGNh5RdcoMa52rwB738/X+CHJe+OTlHr5RNzCCE95al9rHEHij
	AsS7pBbzLW/2ykHFeL1kmj3Yn+WQiko70kbOhblM9OTF2Jk2VV98tqSnjmzFJAOr
	hQa12lSzmmc1myTOXCCX30J8ztSGl94JOIlnRpWrk8Hlra4AmKVYf+bAQvghsBrZ
	zLBX5zRhbxmkT1tYP+cmanu9wOs6+kolKx1zDWCuGGcg3XHpHdmqScAYwMzW4exG
	Oa74cUcdbizPH8zhodkzTzaLWMFOhJ/830W8rqPkvEfhx/smE/7/NIjx46jP396j
	1BHkTPTnyHes7/sVp4QzbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763924449; x=
	1764010849; bh=/2BHs8GtZlNkqov4nhQYaj2io6npJ/rZNaZbdR5EzMg=; b=S
	yWvPPDrrXjOcYJPKH1JmJXQ8SjrzYcZLT5iEIA/575dHxCGVkdnPiZuXzwGiZNHh
	FwY9APe1d5w7uMmryAEiKFVXwY/76nBzaNVUgHDJnET8grXG+PONAJSxfZuhFVYn
	8lD602nUHWG74pEJcrsvORx0Og5sjOVq99MdskSZSVavDxuVpqEnQjmQH5b36UkA
	ieNENZPJTcIumK0hwmhAhEoAIpPl9Hibc5CVt9qcEzI+GjY59nj2rW36WusS4owV
	IKhwVzOsnDKRrZ+I7TscVM3bqZBAgmHtYNWHMZ5NqZ3xKQS5HxfOzZ1q4lVMgcJl
	57IstMnssTs88bU8OM09Q==
X-ME-Sender: <xms:4FkjaVUa9Ncs9Wh9dADscOOhddrz9bvQj1yOSmF3N3b0HupKn5aR6w>
    <xme:4FkjaclUIqK11JwFUpfyct14fOzfKJcFatM2QqlHvuRUCFZhUXUfS0BZLZZM8qUt0
    ahZHotpmoN6LsLzaS93tZmCwcjydKg_5xQsadCTAdOjbBbg1IiTJQ>
X-ME-Received: <xmr:4FkjaWa9AMYyxqa-itB9EXAdjPtOb90Id0H4b2VcdG5KJ_11GRMGCU7NBBIDKZ0s1LUMc4n5tlVQiV8e78Cy1NxaUHKdAWn4xJQaN1Y5NO-eDw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeeihedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghi
    lhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:4FkjaXNWot-XCN8CiMjuhmHuEzLeMhTH2GyKXGpdm-AgzRWdvHthcQ>
    <xmx:4FkjabZWDyuMIAXmZ6spBDGZuLNiVk5nqNpfrblFU-ncX40toOKaDg>
    <xmx:4FkjaV29zS92N1SSoCZTicMLW8iiQpSzVZ6aDSxNxxoKVrfoNd50lw>
    <xmx:4FkjaRdCYvL3SlNN9MApBoS2kjvsMcGZA9tcCV7F1jFlWopi5YemMw>
    <xmx:4VkjaR5fyjieBRzdClS1XyI37ywVfeCgaSGekIIDNMAMbPTlL6DWzXZg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Nov 2025 14:00:47 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6ae6dd6c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Sun, 23 Nov 2025 19:00:47 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Sun, 23 Nov 2025 19:59:44 +0100
Subject: [PATCH v3 19/19] streaming: drop redundant type and size pointers
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251123-b4-pks-odb-read-stream-v3-19-1a129182822b@pks.im>
References: <20251123-b4-pks-odb-read-stream-v3-0-1a129182822b@pks.im>
In-Reply-To: <20251123-b4-pks-odb-read-stream-v3-0-1a129182822b@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.3

In the preceding commits we have turned `struct odb_read_stream` into a
publicly visible structure. Furthermore, this structure now contains the
type and size of the object that we are about to stream. Consequently,
the out-pointers that we used before to propagate the type and size of
the streamed object are now somewhat redundant with the data contained
in the structure itself.

Drop these out-pointers and adapt callers accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 archive-tar.c          |  4 +---
 archive-zip.c          |  5 ++---
 builtin/index-pack.c   |  7 ++-----
 builtin/pack-objects.c |  6 ++++--
 object-file.c          |  6 ++----
 odb/streaming.c        | 10 ++--------
 odb/streaming.h        |  7 ++-----
 7 files changed, 15 insertions(+), 30 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index 494b9f0667..0fc70d13a8 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -130,12 +130,10 @@ static void write_trailer(void)
 static int stream_blocked(struct repository *r, const struct object_id *oid)
 {
 	struct odb_read_stream *st;
-	enum object_type type;
-	unsigned long sz;
 	char buf[BLOCKSIZE];
 	ssize_t readlen;
 
-	st = odb_read_stream_open(r->objects, oid, &type, &sz, NULL);
+	st = odb_read_stream_open(r->objects, oid, NULL);
 	if (!st)
 		return error(_("cannot stream blob %s"), oid_to_hex(oid));
 	for (;;) {
diff --git a/archive-zip.c b/archive-zip.c
index a0bdc2fe3b..97ea8d60d6 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -347,12 +347,11 @@ static int write_zip_entry(struct archiver_args *args,
 			method = ZIP_METHOD_DEFLATE;
 
 		if (!buffer) {
-			enum object_type type;
-			stream = odb_read_stream_open(args->repo->objects, oid,
-						      &type, &size, NULL);
+			stream = odb_read_stream_open(args->repo->objects, oid, NULL);
 			if (!stream)
 				return error(_("cannot stream blob %s"),
 					     oid_to_hex(oid));
+			size = stream->size;
 			flags |= ZIP_STREAM;
 			out = NULL;
 		} else {
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 581023495f..b01cb77f4a 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -798,8 +798,6 @@ static int compare_objects(const unsigned char *buf, unsigned long size,
 static int check_collison(struct object_entry *entry)
 {
 	struct compare_data data;
-	enum object_type type;
-	unsigned long size;
 
 	if (entry->size <= repo_settings_get_big_file_threshold(the_repository) ||
 	    entry->type != OBJ_BLOB)
@@ -807,11 +805,10 @@ static int check_collison(struct object_entry *entry)
 
 	memset(&data, 0, sizeof(data));
 	data.entry = entry;
-	data.st = odb_read_stream_open(the_repository->objects, &entry->idx.oid,
-				       &type, &size, NULL);
+	data.st = odb_read_stream_open(the_repository->objects, &entry->idx.oid, NULL);
 	if (!data.st)
 		return -1;
-	if (size != entry->size || type != entry->type)
+	if (data.st->size != entry->size || data.st->type != entry->type)
 		die(_("SHA1 COLLISION FOUND WITH %s !"),
 		    oid_to_hex(&entry->idx.oid));
 	unpack_data(entry, compare_objects, &data);
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index f109e26786..0d1d6995bf 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -521,9 +521,11 @@ static unsigned long write_no_reuse_object(struct hashfile *f, struct object_ent
 		    oe_size_greater_than(&to_pack, entry,
 					 repo_settings_get_big_file_threshold(the_repository)) &&
 		    (st = odb_read_stream_open(the_repository->objects, &entry->idx.oid,
-					       &type, &size, NULL)) != NULL)
+					       NULL)) != NULL) {
 			buf = NULL;
-		else {
+			type = st->type;
+			size = st->size;
+		} else {
 			buf = odb_read_object(the_repository->objects,
 					      &entry->idx.oid, &type,
 					      &size);
diff --git a/object-file.c b/object-file.c
index 9601fdb12d..12177a7dd7 100644
--- a/object-file.c
+++ b/object-file.c
@@ -132,19 +132,17 @@ int check_object_signature(struct repository *r, const struct object_id *oid,
 int stream_object_signature(struct repository *r, const struct object_id *oid)
 {
 	struct object_id real_oid;
-	unsigned long size;
-	enum object_type obj_type;
 	struct odb_read_stream *st;
 	struct git_hash_ctx c;
 	char hdr[MAX_HEADER_LEN];
 	int hdrlen;
 
-	st = odb_read_stream_open(r->objects, oid, &obj_type, &size, NULL);
+	st = odb_read_stream_open(r->objects, oid, NULL);
 	if (!st)
 		return -1;
 
 	/* Generate the header */
-	hdrlen = format_object_header(hdr, sizeof(hdr), obj_type, size);
+	hdrlen = format_object_header(hdr, sizeof(hdr), st->type, st->size);
 
 	/* Sha1.. */
 	r->hash_algo->init_fn(&c);
diff --git a/odb/streaming.c b/odb/streaming.c
index 7ef58adaa2..745cd486fb 100644
--- a/odb/streaming.c
+++ b/odb/streaming.c
@@ -214,8 +214,6 @@ ssize_t odb_read_stream_read(struct odb_read_stream *st, void *buf, size_t sz)
 
 struct odb_read_stream *odb_read_stream_open(struct object_database *odb,
 					     const struct object_id *oid,
-					     enum object_type *type,
-					     unsigned long *size,
 					     struct stream_filter *filter)
 {
 	struct odb_read_stream *st;
@@ -235,8 +233,6 @@ struct odb_read_stream *odb_read_stream_open(struct object_database *odb,
 		st = nst;
 	}
 
-	*size = st->size;
-	*type = st->type;
 	return st;
 }
 
@@ -247,18 +243,16 @@ int odb_stream_blob_to_fd(struct object_database *odb,
 			  int can_seek)
 {
 	struct odb_read_stream *st;
-	enum object_type type;
-	unsigned long sz;
 	ssize_t kept = 0;
 	int result = -1;
 
-	st = odb_read_stream_open(odb, oid, &type, &sz, filter);
+	st = odb_read_stream_open(odb, oid, filter);
 	if (!st) {
 		if (filter)
 			free_stream_filter(filter);
 		return result;
 	}
-	if (type != OBJ_BLOB)
+	if (st->type != OBJ_BLOB)
 		goto close_and_exit;
 	for (;;) {
 		char buf[1024 * 16];
diff --git a/odb/streaming.h b/odb/streaming.h
index 7cb55213b7..c7861f7e13 100644
--- a/odb/streaming.h
+++ b/odb/streaming.h
@@ -25,16 +25,13 @@ struct odb_read_stream {
 };
 
 /*
- * Create a new object stream for the given object database. Populates the type
- * and size pointers with the object's info. An optional filter can be used to
- * transform the object's content.
+ * Create a new object stream for the given object database. An optional filter
+ * can be used to transform the object's content.
  *
  * Returns the stream on success, a `NULL` pointer otherwise.
  */
 struct odb_read_stream *odb_read_stream_open(struct object_database *odb,
 					     const struct object_id *oid,
-					     enum object_type *type,
-					     unsigned long *size,
 					     struct stream_filter *filter);
 
 /*

-- 
2.52.0.rc2.482.gaa765fefd0.dirty

