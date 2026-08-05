Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405693E44E4
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 07:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785915912; cv=none; b=lL+H4OM51HxgRxqjr7gaIc2PYNG0L98r+BFOdlj1hnSESucDuq7xXSM6L+8cYkns81fMleI06rEuNDE2Sh7Mlg5Jy03hZPbArqYrm6cGp/akCN/erJk3UlEBqWAMXKAKz30NC0gplK5WIxebmdtpuP7oS4pWd2pInulhzA8OYfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785915912; c=relaxed/simple;
	bh=w/4YWB45f6pW+12LSaDtbBW4rZQIrm/6piZKQTKCOR0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Im5wLwMeOpm1VupFrdDjDYZb0jmaxrwTqynSfEKIl7j4iYTwI5FKjBG3OwsaerRAdOgDtQxGUQW7qLpeTEguWgDfq+ZBTqAhHcGrroWbCuk7IjrZnd/V2t0RCaSGAeAFmLPVRKoyIwTvr3O7i74EmpCZgAOoqqx/Fo8GwfVQhw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=i6YV+55M; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gRbg4s2U; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="i6YV+55M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gRbg4s2U"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 538821400137;
	Wed,  5 Aug 2026 03:45:09 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 05 Aug 2026 03:45:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1785915909;
	 x=1786002309; bh=7MhpC/7cGH6AHui5pXExnY2OahIZ7Xg1dXb3DviKwd0=; b=
	i6YV+55MH9wjAp7n0CcCDSi6V2tyNVI+RYNqY8HLXdSuIwHzMHb4uQ1DYXWcLH7l
	lKoh5h5FR8tIh7zMv/K8Bs1hGDDAP35GCrilLOJFQaumjlCReLkCeOswNpkWJmZw
	26mXbdeBOgupKtcOpF3MLFF9Ec8RvQSryeG8OyTo3TZMuQnHetxpCTUirnk24TO/
	A6Tc4xw8uLxZisWAbb6aErRk/+Z38AyjIOcB5Vp9Ag+ts5re/o/NFtQMNLUwrVrd
	NQVZgxhQKqBOrp31D8pMZ0xqjCngY6K3OzXwaPiZPudED0X6Q94V1nilI7H3nGGb
	7TY3EbbWGAIUSrmcYc+iMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785915909; x=
	1786002309; bh=7MhpC/7cGH6AHui5pXExnY2OahIZ7Xg1dXb3DviKwd0=; b=g
	Rbg4s2UfATWSGJwQmKRcH65Iz1Z/F9j/DGYjJqZ+IiV9LzGZ9nbv4u+ha6WQXPM5
	Byi7P4ZTJ0QgKPGlXbKYv5ws2imLLopzllqSU5dlhRlZhEvaTvnkCjqog0gXT7ZJ
	jD4S1UhxD5dBZdhN/pX14OlQC4na9vsU8IPcp4qi7MgSaTtDHTar8GgNhQn2yA2Q
	VGBFmcqJozh9cEbByi0Q1aBT9TnvRqeBlzzXKuzpCA09hhPwxdEn9WsnwJxIz7Aj
	R/kOCb/0STfeaSMIjotoEDrTUlPCD/IuWe1M39PgAjT+tB8hwGK+WM0N2xS8ySYE
	oAJR/u3QFyKT9Zs6fy4Tw==
X-ME-Sender: <xms:Bepyal2UE7VI840CXy45usCjEra4s3T9YN05J7hyljtAAAxJsfOs3Q>
    <xme:BepyajixL86CjXRTGivxV-E_PMgJyeMX0o_LXa_USqkBaLLXz5GIHpHjpXxfvXivr
    VBqNd13K_Kqo2QhJgj6TxZQcPOrStcXDoy4XfmHrnL9wPVCyF7OsP8>
X-ME-Received: <xmr:BepyajTNpMcOZ9-d6VuU0JaBYPhJ1nQip55sQO8l1YPWxtq2F8pv15-s8m4wSZNS-cHF5MJePvS7los8Hrl-NcEX0duCEXiKfxA1JLtbWQ>
X-ME-Proxy-Cause: dmFkZTGbFAdPF9viVotmQAeejs2iFwYGaIE3Xvu7z2dOFSzpgzu+bJgUZWbJGfroDHLppw
    b2qQI/xK3lI9uqsKuOxDjzNZo+TCP7M0K+Ph7sizlC4tAmJrhNk8fNvKdkaCZsUmShp5GN
    5bfJSaSyQoCY7YPZBigA0vyOzA7y8zOK7vl7kjMapNQEYl1kwhUijEA9ur5nb7erw9/I6d
    MPahvSBJu/fcAWjMAYaeqkIX+4CUcox7IQClhReQnfdsxRh5VaWyrXYzboCISKvMLgLWF0
    ECH77MBkiZofsQvRAVlATkjC1kPlOtDX5vQHSUthS1YV1dYpE7uIkZ+V85StH4Co7hp2sq
    WLmSXrBU5WDTdZa+ghX0p+lKRdvod+FFlT0VzOlwTec/die4Mr1+H9BZGqhHev3JqciTNy
    GK2sdxHQlbASOywLxPhKR+gXPBOtUuLlY5tfP2sDlLwqBR5VeQSbFvvAuxrn/wqoOOjTS8
    RS9BZu/2N14UjwJ6rjvtasBjqvZz13INodmWysXrMUmOSFXNa9eAjvdr9Ajxlv7RmIeK40
    JRxTRB/4UcZoxD+uYwWyu127ml1oBFdLAlGj0+VcXcaYYJ+ugUdJ8+J45SS5n/kkveq6ow
    f1XIXuC9ZKg5sKSd/WISk/EPVImZRnF6hHqTpdDjybFEVIytkbKgEWSk+FUQ
X-ME-Proxy: <xmx:BepyasiaQj40LLmtx7f6sPwDLKmdczn2bO4fn59EgTtKdI1Q3oAYLw>
    <xmx:Bepyar4SLeStDpy7sBiL8rMxySG7LC5AFOyQg3RDxZQtL8_qpGF9Sw>
    <xmx:BepyahAwwbsYcLTBz_SNad6jvyDiXhGfESe2dtRaKFu_71zubuMAqA>
    <xmx:BepyaqbgAh_fTCkl809XX0axwnti_Un_Fq5pu1J7WqyhNS2h2EhUmg>
    <xmx:BepyangROnKg4YppNYQ63UQSS-CgoBfunpstDuK9E7O7C49BLWfZgHTh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Aug 2026 03:45:08 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a4801c47 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 5 Aug 2026 07:45:08 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 05 Aug 2026 09:44:49 +0200
Subject: [PATCH v2 5/8] odb/streaming: consolidate read and write streams
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-pks-odb-stream-unification-v2-5-b8c369564641@pks.im>
References: <20260805-pks-odb-stream-unification-v2-0-b8c369564641@pks.im>
In-Reply-To: <20260805-pks-odb-stream-unification-v2-0-b8c369564641@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

The `struct odb_read_stream` and `struct odb_write_stream` both provide
the same functionality: they allow a caller to read object data from an
arbitrary source. Historically, the only difference was that the read
stream was used to read data out of the object database, whereas the
write stream was used to write data into the object database, but the
interfaces were mostly the same.

Over the preceding commits we have refactored the write stream to have
almost exactly the same interface as the read stream. With these
refactorings we can now easily merge those two streams into a single
interface that's used for both use cases.

While most of the changes are mechanical, there are two sites that need
special mention:

  - "builtin/unpack-objects.c" creates a write stream from compressed
    object data.

  - "odb/streaming.c" creates a write stream from a file descriptor.

Adapting these sites to yield the new stream type requires a couple more
changes. Most importantly, instead of embedding the pointer to the data
in `struct odb_write_stream`, we now allocate a structure that wraps the
new `struct odb_stream` base. Other than that though, the changes are
rather straight forward.

Some of the structures and functions are now somewhat misnamed. These
will be fixed in subsequent commits.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/unpack-objects.c      | 31 ++++++++++++++++---------------
 object-file.c                 | 25 ++++++++++++-------------
 odb.c                         |  2 +-
 odb.h                         |  4 ++--
 odb/source-files.c            |  2 +-
 odb/source-inmemory.c         |  4 ++--
 odb/source-loose.c            |  6 +++---
 odb/source-packed.c           |  2 +-
 odb/source.h                  |  4 ++--
 odb/streaming.c               | 35 ++++++++++++++++-------------------
 odb/streaming.h               | 31 +++----------------------------
 odb/transaction.c             |  2 +-
 odb/transaction.h             |  4 ++--
 t/unit-tests/u-odb-inmemory.c |  6 +++---
 14 files changed, 65 insertions(+), 93 deletions(-)

diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 7439ec53be..05a2d48011 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -359,20 +359,21 @@ static void unpack_non_delta_entry(enum object_type type, unsigned long size,
 }
 
 struct input_zstream_data {
+	struct odb_stream base;
 	git_zstream *zstream;
 	int status;
 };
 
-static ssize_t feed_input_zstream(struct odb_write_stream *in_stream,
-				  unsigned char *buf, size_t buf_len)
+static ssize_t feed_input_zstream(struct odb_stream *in_stream,
+				  char *buf, size_t buf_len)
 {
-	struct input_zstream_data *data = in_stream->data;
+	struct input_zstream_data *data = container_of(in_stream, struct input_zstream_data, base);
 	git_zstream *zstream = data->zstream;
 
 	if (data->status != Z_OK)
 		return 0;
 
-	zstream->next_out = buf;
+	zstream->next_out = (unsigned char *) buf;
 	zstream->avail_out = buf_len;
 
 	while (data->status == Z_OK && zstream->avail_out == buf_len) {
@@ -388,24 +389,24 @@ static ssize_t feed_input_zstream(struct odb_write_stream *in_stream,
 static void stream_blob(unsigned long size, unsigned nr)
 {
 	git_zstream zstream = { 0 };
-	struct input_zstream_data data = { 0 };
-	struct odb_write_stream in_stream = {
-		.read = feed_input_zstream,
-		.data = &data,
-		.size = size,
-		.type = OBJ_BLOB,
+	struct input_zstream_data in_stream = {
+		.base = {
+			.read = feed_input_zstream,
+			.size = size,
+			.type = OBJ_BLOB,
+		},
+		.zstream = &zstream,
+		.status = Z_OK,
 	};
 	struct obj_info *info = &obj_list[nr];
 
-	data.zstream = &zstream;
-	data.status = Z_OK;
 	git_inflate_init(&zstream);
 
-	if (odb_write_object_stream(the_repository->objects, &in_stream, &info->oid))
+	if (odb_write_object_stream(the_repository->objects, &in_stream.base, &info->oid))
 		die(_("failed to write object in stream"));
 
-	if (data.status != Z_STREAM_END)
-		die(_("inflate returned (%d)"), data.status);
+	if (in_stream.status != Z_STREAM_END)
+		die(_("inflate returned (%d)"), in_stream.status);
 	git_inflate_end(&zstream);
 
 	if (strict) {
diff --git a/object-file.c b/object-file.c
index 5f6d584c35..068c6e5672 100644
--- a/object-file.c
+++ b/object-file.c
@@ -702,7 +702,7 @@ static void prepare_packfile_transaction(struct odb_transaction_files *transacti
 		die_errno("unable to write pack header");
 }
 
-static int hash_stream(struct odb_write_stream *stream,
+static int hash_stream(struct odb_stream *stream,
 		       const struct git_hash_algo *hash_algo,
 		       struct object_id *result_oid)
 {
@@ -717,8 +717,8 @@ static int hash_stream(struct odb_write_stream *stream,
 	git_hash_update(&ctx, buf, header_len);
 
 	while (1) {
-		ssize_t read_result = odb_write_stream_read(stream, buf,
-							    sizeof(buf));
+		ssize_t read_result = odb_stream_read(stream, buf,
+						      sizeof(buf));
 		if (read_result < 0)
 			return -1;
 		if (!read_result)
@@ -742,7 +742,7 @@ static int hash_stream(struct odb_write_stream *stream,
  */
 static void stream_to_pack(struct transaction_packfile *state,
 			   struct git_hash_ctx *ctx,
-			   struct odb_write_stream *stream)
+			   struct odb_stream *stream)
 {
 	git_zstream s;
 	unsigned char ibuf[16384];
@@ -761,8 +761,8 @@ static void stream_to_pack(struct transaction_packfile *state,
 
 	while (status != Z_STREAM_END) {
 		if (!is_finished && !s.avail_in) {
-			ssize_t rsize = odb_write_stream_read(stream, ibuf,
-							      sizeof(ibuf));
+			ssize_t rsize = odb_stream_read(stream, ibuf,
+							sizeof(ibuf));
 			if (rsize < 0)
 				die("failed to read object data");
 			if (!rsize)
@@ -872,7 +872,7 @@ static void flush_packfile_transaction(struct odb_transaction_files *transaction
  * callers should avoid this code path when filters are requested.
  */
 static int odb_transaction_files_write_object_stream(struct odb_transaction *base,
-						     struct odb_write_stream *stream,
+						     struct odb_stream *stream,
 						     struct object_id *result_oid)
 {
 	struct odb_transaction_files *transaction = container_of(base,
@@ -952,8 +952,8 @@ int index_fd(struct index_state *istate, struct object_id *oid,
 		ret = index_core(istate, oid, fd, xsize_t(st->st_size),
 				 type, path, flags);
 	} else {
-		struct odb_write_stream stream;
-		odb_write_stream_from_fd(&stream, fd, xsize_t(st->st_size), OBJ_BLOB);
+		struct odb_stream *stream = odb_write_stream_from_fd(fd, xsize_t(st->st_size),
+								     OBJ_BLOB);
 
 		if (flags & INDEX_WRITE_OBJECT) {
 			struct object_database *odb = the_repository->objects;
@@ -963,15 +963,14 @@ int index_fd(struct index_state *istate, struct object_id *oid,
 			if (!inflight)
 				odb_transaction_begin_or_die(odb, &transaction, 0);
 			ret = odb_transaction_write_object_stream(transaction,
-								  &stream,
-								  oid);
+								  stream, oid);
 			if (!inflight)
 				odb_transaction_commit(transaction);
 		} else {
-			ret = hash_stream(&stream, the_repository->hash_algo, oid);
+			ret = hash_stream(stream, the_repository->hash_algo, oid);
 		}
 
-		odb_write_stream_release(&stream);
+		odb_stream_close(stream);
 	}
 
 	close(fd);
diff --git a/odb.c b/odb.c
index 585b2b2965..eec4cc5302 100644
--- a/odb.c
+++ b/odb.c
@@ -1028,7 +1028,7 @@ int odb_write_object_ext(struct object_database *odb,
 }
 
 int odb_write_object_stream(struct object_database *odb,
-			    struct odb_write_stream *stream,
+			    struct odb_stream *stream,
 			    struct object_id *oid)
 {
 	return odb_source_write_object_stream(odb->sources, stream, oid);
diff --git a/odb.h b/odb.h
index 019d3af3e8..fbe75c5a81 100644
--- a/odb.h
+++ b/odb.h
@@ -626,10 +626,10 @@ static inline int odb_write_object(struct object_database *odb,
 	return odb_write_object_ext(odb, buf, len, type, oid, NULL, 0);
 }
 
-struct odb_write_stream;
+struct odb_stream;
 
 int odb_write_object_stream(struct object_database *odb,
-			    struct odb_write_stream *stream,
+			    struct odb_stream *stream,
 			    struct object_id *oid);
 
 void parse_alternates(const char *string,
diff --git a/odb/source-files.c b/odb/source-files.c
index f7b8c76549..6defe5ac4f 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -174,7 +174,7 @@ static int odb_source_files_write_object(struct odb_source *source,
 }
 
 static int odb_source_files_write_object_stream(struct odb_source *source,
-						struct odb_write_stream *stream,
+						struct odb_stream *stream,
 						struct object_id *oid)
 {
 	struct odb_source_files *files = odb_source_files_downcast(source);
diff --git a/odb/source-inmemory.c b/odb/source-inmemory.c
index 485d587036..795672adf2 100644
--- a/odb/source-inmemory.c
+++ b/odb/source-inmemory.c
@@ -256,7 +256,7 @@ static int odb_source_inmemory_write_object(struct odb_source *source,
 }
 
 static int odb_source_inmemory_write_object_stream(struct odb_source *source,
-						   struct odb_write_stream *stream,
+						   struct odb_stream *stream,
 						   struct object_id *oid)
 {
 	char buf[16384];
@@ -268,7 +268,7 @@ static int odb_source_inmemory_write_object_stream(struct odb_source *source,
 	while (1) {
 		ssize_t bytes_read;
 
-		bytes_read = odb_write_stream_read(stream, buf, sizeof(buf));
+		bytes_read = odb_stream_read(stream, buf, sizeof(buf));
 		if (bytes_read < 0) {
 			ret = error("failed to read object stream");
 			goto out;
diff --git a/odb/source-loose.c b/odb/source-loose.c
index 038defd905..ff1bede7fe 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -845,7 +845,7 @@ static int odb_source_loose_write_object(struct odb_source *source,
 }
 
 static int odb_source_loose_write_object_stream(struct odb_source *source,
-						struct odb_write_stream *in_stream,
+						struct odb_stream *in_stream,
 						struct object_id *oid)
 {
 	struct odb_source_loose *loose = odb_source_loose_downcast(source);
@@ -891,8 +891,8 @@ static int odb_source_loose_write_object_stream(struct odb_source *source,
 		unsigned char *in0 = stream.next_in;
 
 		if (!stream.avail_in && !is_finished) {
-			ssize_t read_len = odb_write_stream_read(in_stream, buf,
-								 sizeof(buf));
+			ssize_t read_len = odb_stream_read(in_stream, buf,
+							   sizeof(buf));
 			if (read_len < 0) {
 				close(fd);
 				err = -1;
diff --git a/odb/source-packed.c b/odb/source-packed.c
index b3186ca593..630d955585 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -609,7 +609,7 @@ static int odb_source_packed_write_object(struct odb_source *source UNUSED,
 }
 
 static int odb_source_packed_write_object_stream(struct odb_source *source UNUSED,
-						 struct odb_write_stream *stream UNUSED,
+						 struct odb_stream *stream UNUSED,
 						 struct object_id *oid UNUSED)
 {
 	return error("packed backend cannot write object streams");
diff --git a/odb/source.h b/odb/source.h
index 89b0c39682..0b99c698b5 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -221,7 +221,7 @@ struct odb_source {
 	 * otherwise.
 	 */
 	int (*write_object_stream)(struct odb_source *source,
-				   struct odb_write_stream *stream,
+				   struct odb_stream *stream,
 				   struct object_id *oid);
 
 	/*
@@ -436,7 +436,7 @@ static inline int odb_source_write_object(struct odb_source *source,
  * out pointer for the object ID.
  */
 static inline int odb_source_write_object_stream(struct odb_source *source,
-						 struct odb_write_stream *stream,
+						 struct odb_stream *stream,
 						 struct object_id *oid)
 {
 	return source->write_object_stream(source, stream, oid);
diff --git a/odb/streaming.c b/odb/streaming.c
index 98e2152e36..1a267e6b90 100644
--- a/odb/streaming.c
+++ b/odb/streaming.c
@@ -232,16 +232,6 @@ struct odb_stream *odb_read_stream_open(struct object_database *odb,
 	return st;
 }
 
-ssize_t odb_write_stream_read(struct odb_write_stream *st, void *buf, size_t sz)
-{
-	return st->read(st, buf, sz);
-}
-
-void odb_write_stream_release(struct odb_write_stream *st)
-{
-	free(st->data);
-}
-
 int odb_stream_blob_to_fd(struct object_database *odb,
 			  int fd,
 			  const struct object_id *oid,
@@ -299,14 +289,15 @@ int odb_stream_blob_to_fd(struct object_database *odb,
 }
 
 struct read_object_fd_data {
+	struct odb_stream base;
 	int fd;
 	size_t remaining;
 };
 
-static ssize_t read_object_fd(struct odb_write_stream *stream,
-			      unsigned char *buf, size_t len)
+static ssize_t read_object_fd(struct odb_stream *stream,
+			      char *buf, size_t len)
 {
-	struct read_object_fd_data *data = stream->data;
+	struct read_object_fd_data *data = container_of(stream, struct read_object_fd_data, base);
 	ssize_t read_result;
 	size_t count;
 
@@ -323,17 +314,23 @@ static ssize_t read_object_fd(struct odb_write_stream *stream,
 	return read_result;
 }
 
-void odb_write_stream_from_fd(struct odb_write_stream *stream, int fd,
-			      size_t size, enum object_type type)
+static int close_object_fd(struct odb_stream *stream UNUSED)
+{
+	/* The file descriptor is owned by the caller for now. */
+	return 0;
+}
+
+struct odb_stream *odb_write_stream_from_fd(int fd, size_t size, enum object_type type)
 {
 	struct read_object_fd_data *data;
 
 	CALLOC_ARRAY(data, 1);
+	data->base.read = read_object_fd;
+	data->base.close = close_object_fd;
+	data->base.size = size;
+	data->base.type = type;
 	data->fd = fd;
 	data->remaining = size;
 
-	stream->data = data;
-	stream->read = read_object_fd;
-	stream->size = size;
-	stream->type = type;
+	return &data->base;
 }
diff --git a/odb/streaming.h b/odb/streaming.h
index 037954c231..60b9803190 100644
--- a/odb/streaming.h
+++ b/odb/streaming.h
@@ -15,8 +15,8 @@ typedef int (*odb_stream_close_fn)(struct odb_stream *);
 typedef ssize_t (*odb_stream_read_fn)(struct odb_stream *, char *, size_t);
 
 /*
- * A stream that can be used to read an object from the object database without
- * loading all of it into memory.
+ * A stream that can be used to read an object from or write an object into the
+ * object database without loading all of it into memory.
  */
 struct odb_stream {
 	odb_stream_close_fn close;
@@ -48,30 +48,6 @@ int odb_stream_close(struct odb_stream *stream);
  */
 ssize_t odb_stream_read(struct odb_stream *stream, void *buf, size_t len);
 
-/*
- * A stream that provides an object to be written to the object database without
- * loading all of it into memory.
- */
-struct odb_write_stream {
-	ssize_t (*read)(struct odb_write_stream *, unsigned char *, size_t);
-	void *data;
-	size_t size;
-	enum object_type type;
-};
-
-/*
- * Read data from the stream into the buffer. Returns 0 when finished and the
- * number of bytes read on success. Returns a negative error code in case
- * reading from the stream fails.
- */
-ssize_t odb_write_stream_read(struct odb_write_stream *stream, void *buf,
-			      size_t len);
-
-/*
- * Releases memory allocated for underlying stream data.
- */
-void odb_write_stream_release(struct odb_write_stream *stream);
-
 /*
  * Look up the object by its ID and write the full contents to the file
  * descriptor. The object must be a blob, or the function will fail. When
@@ -92,7 +68,6 @@ int odb_stream_blob_to_fd(struct object_database *odb,
 /*
  * Sets up an ODB write stream that reads from an fd.
  */
-void odb_write_stream_from_fd(struct odb_write_stream *stream, int fd,
-			      size_t size, enum object_type type);
+struct odb_stream *odb_write_stream_from_fd(int fd, size_t size, enum object_type type);
 
 #endif /* STREAMING_H */
diff --git a/odb/transaction.c b/odb/transaction.c
index 6aaf133812..69d71b9e97 100644
--- a/odb/transaction.c
+++ b/odb/transaction.c
@@ -39,7 +39,7 @@ int odb_transaction_commit(struct odb_transaction *transaction)
 }
 
 int odb_transaction_write_object_stream(struct odb_transaction *transaction,
-					struct odb_write_stream *stream,
+					struct odb_stream *stream,
 					struct object_id *oid)
 {
 	return transaction->write_object_stream(transaction, stream, oid);
diff --git a/odb/transaction.h b/odb/transaction.h
index 1eb74664c6..65248a409c 100644
--- a/odb/transaction.h
+++ b/odb/transaction.h
@@ -31,7 +31,7 @@ struct odb_transaction {
 	 * otherwise.
 	 */
 	int (*write_object_stream)(struct odb_transaction *transaction,
-				   struct odb_write_stream *stream,
+				   struct odb_stream *stream,
 				   struct object_id *oid);
 
 	/*
@@ -81,7 +81,7 @@ int odb_transaction_commit(struct odb_transaction *transaction);
  * error code otherwise.
  */
 int odb_transaction_write_object_stream(struct odb_transaction *transaction,
-					struct odb_write_stream *stream,
+					struct odb_stream *stream,
 					struct object_id *oid);
 
 /*
diff --git a/t/unit-tests/u-odb-inmemory.c b/t/unit-tests/u-odb-inmemory.c
index 839a0fd3b7..b8b331b37d 100644
--- a/t/unit-tests/u-odb-inmemory.c
+++ b/t/unit-tests/u-odb-inmemory.c
@@ -266,13 +266,13 @@ void test_odb_inmemory__freshen_object(void)
 }
 
 struct membuf_write_stream {
-	struct odb_write_stream base;
+	struct odb_stream base;
 	const char *buf;
 	size_t offset;
 };
 
-static ssize_t membuf_write_stream_read(struct odb_write_stream *stream,
-					unsigned char *buf, size_t len)
+static ssize_t membuf_write_stream_read(struct odb_stream *stream,
+					char *buf, size_t len)
 {
 	struct membuf_write_stream *s = container_of(stream, struct membuf_write_stream, base);
 	size_t chunk_size = 2;

-- 
2.55.0.679.g6767b8d81c.dirty

