Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F6C322A26
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 07:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763538494; cv=none; b=aZ7/RaBTNFyqvnvYeMubNQqVANT8BzJh43CUl5jR7GPuZgX7fkbvAnIT4NYCJL4WQoNT2F8JKvVCLBZj3/wVbcJj8SOWH0XZwKSU4tSLZGZmlDyJmnzwvQu2Te5s7oNR4Z0S8xzG7Tdq0dKEHBdatQLHVn2P+yHWxpDPN4nIyZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763538494; c=relaxed/simple;
	bh=ga8aBw3d355yeNZEjKeGkDGaBoNd4utFYq4sCEYwhwU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JGl/aNy0z1OG1QdcHDFJqfhXKAQy+IPFL/8lCK4tNelUTMZXedYYLRdoCTRbYYV/lYqS8v5OZj4IZAFQHCaTxVItGER6nF7IxMWfht1BGxWaTAIyYgj+Vh3f/ObEsA/5SzvJKoIh8G+hw/cVhJulTUHhtWmit2RQxcfOSRNJa3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iQt02ztT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Sj5HB+Kk; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iQt02ztT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Sj5HB+Kk"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B9D3314001FA
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 02:48:11 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 19 Nov 2025 02:48:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763538491;
	 x=1763624891; bh=KR3RYOx4yqXsFNrekrZmTArGo4u0CkdzIMn8CkEprjs=; b=
	iQt02ztT5ZTXJ5o2SmbDqniMXI7isxiqvupngbX07HXVRMXsOjtZfJpLL6oUzN67
	zxCZB44FVjz+ZdCNHUP5rE39GxN5aNNGvKIrWgcfHMbRZZaL8c278s46c/qdAUlV
	a3FEMV9jKOxYxjC39Mz0wagCVbEpz9b+zpxZl9XVjIwui2uRu9mX7SikR6kv8hKr
	PLjpCIrovDsNmYtuPB8Mc7qdD7/T5ut/KnS+XiLvNVjn5/6Vk5OncIo2A50GQbq6
	90cgEZV149cIpN4KfqOKgoXW8To/dTT2Fs3atGRuUEfwC5yf85P8LDjfAcevA3pf
	lOZizQYpNdm/OhM/jzxRfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763538491; x=
	1763624891; bh=KR3RYOx4yqXsFNrekrZmTArGo4u0CkdzIMn8CkEprjs=; b=S
	j5HB+Kk4QFNNDe+k8jeIzKEQnYGsF530ttJPxhT2CYGwmhLeSKfbPXnUrFaUuQ8l
	PH0X4Yytq+l2Mw5vRhiOVVuw8Yp9CI2QVt7vAzqNX8QmfSlon5Tw61h1d9FOuty5
	GyQrXXsZagflKMSUVToSlMo053PI18ulpo4dZujjPRHIHvNTy+mEtjPk/zHNtt9w
	4xAGSxNFh1qHzDg3SIWeYn39sjsmiCdhsGh7+t7KwgOp0WiaIkfejzQQQLfi/ytP
	nyN/GASR7DYpZdEVC4m2JXQADNk2PkIg3asxR+5Ko625ZQGpQJRNMf82ueDRDZER
	+DtMHPjM5YIOhaolfPD2Q==
X-ME-Sender: <xms:O3YdaUHOmBjAV1PcId892XYwnj86ll9q_NwgkwxwAdp1LQlSfgRtXQ>
    <xme:O3YdaURM6uqlbEDi9BrYB_bU0lHtsUCVD7-I751v7-uSJEbdk-fVPnexRBFEHzKAK
    9x9TUQz97Nfoav-KI07dowaUEpgcflcy3Y-BnznVi8PRt9jty8ZHg>
X-ME-Received: <xmr:O3YdaTz8GUlARx0fhThXOTYC5BskvmfCIa0lJArwiRgoJzfaDYN0zGW0hOIvcZrcLFzpwlI_mVf5RB23F0OeHMAxfUWdKZEu2GxRE-mO7A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdefieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgovfgvgihtqfhnlhihqddqteefjeefqddtgeculdehtd
    dmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefr
    rghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrg
    htthgvrhhnpeekieevveegieevieeuveefheffgeeuheetheegffffkeeijedtueefleff
    vdevleenucffohhmrghinhepphgrtghkvggurdhishenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphht
    thhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:O3YdabPOc3BaLMq9k25VjAOIW9S-8dKbk6NuUeci1Mbxx0jhBKTunA>
    <xmx:O3YdaaPJLFVbpUj0pzI-r1QogdqRWi5BFxduAI9kIO-_PFZkWWWGlw>
    <xmx:O3YdaVQ5KX9ZkwGPZRq7jDJl3k-6y7ypGFQvBK5MnpGDseYrqt4v3Q>
    <xmx:O3YdaUDqfe471eR60XlAA_cX9zHQa84bf9N_pH8-UQ_U4rdzHGOF5A>
    <xmx:O3YdaeUwFaAiT0aZHXCzWN_E63jyR5pPX8z6cnnDxnTWtyWiZHXF68Ok>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 19 Nov 2025 02:48:11 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b67557fd (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Wed, 19 Nov 2025 07:48:10 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 19 Nov 2025 08:47:13 +0100
Subject: [PATCH 13/18] streaming: get rid of `the_repository`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-b4-pks-odb-read-stream-v1-13-adacf03c2ccf@pks.im>
References: <20251119-b4-pks-odb-read-stream-v1-0-adacf03c2ccf@pks.im>
In-Reply-To: <20251119-b4-pks-odb-read-stream-v1-0-adacf03c2ccf@pks.im>
To: git@vger.kernel.org
Cc: 
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
index bebb434cd1..9e20e9a882 100644
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
index acf4c84338..95c2a434fa 100644
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

