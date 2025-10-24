Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678E53101C8
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 09:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761299808; cv=none; b=ERIBtxczcofTbsrBx/zSNXjmfTX1ME4SeXoJbaSEG9vkV0GsYjLlZ6qtYfD/8PULxJueUnVC+pRdVIE7Sg+W715lCDYzCZ+uHPa1ihRXllQ9UGFeS/1Me2Z6B/x2dFiu3R//+BeFkD8F/30B0z3z6zFW8BXJCk3+Szt/ludq0oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761299808; c=relaxed/simple;
	bh=e4pTA6YFggbOV18aoUYncqxXkcb4bT0NkrXhfkiUGBA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OmEfOvB+qMUDo9nbYJQdw+j1VQ8OyS2ANXx8laZO0FZo2FpU1GLNfTXCzpQZomfe/DvflP3EBvp6xK13q42cIOXgfUxGYhGA7VYEFctHyepgzFPbGRt7INBplrgPsjgYiYgncaI/zKwkUm+vLg1oKEwJkJhBxp8t1utqhCaMHK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pAkSqVoF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OywZKoNb; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pAkSqVoF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OywZKoNb"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 98A96140016D
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 05:56:45 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 24 Oct 2025 05:56:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761299805;
	 x=1761386205; bh=J4vfNMasM3Y6Rz6N6/2iX29hAv2y9x+LPioK6kGxCpw=; b=
	pAkSqVoF648MdaNEVDFD8TrPRyexjWNlIXd7NBYMiWzpaeadSYXY4PZ22T89MKJc
	aP9WZzi94gClks8rIZjNgK2Bepzpyr2PDSVBPnmAjtc4o4l9OpjOuBOA2yfJVUE6
	SouYZX4SyT1i14u65JxhA7ixcCYyMVxNatJxHDg69es/xKjr98CD1sI2SpRYCWyH
	FWHBsF4Xrjm6ipcOE9xGmPBxfAYdbhn5JDNkpe9KzUzuk3vGZmerV/jSLRYjpSR5
	Gp2TGuEyNmziiwexoel9aWJv2AZwCc2cmZMhgAygkdyN9BRMLDPgzXeX7quefHAx
	fehYL5Lmu7UCW3pxhdK+8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761299805; x=
	1761386205; bh=J4vfNMasM3Y6Rz6N6/2iX29hAv2y9x+LPioK6kGxCpw=; b=O
	ywZKoNbpFFszbpGhzYx5RO82K5/3FvPEzp5nBCaUAwLpbkJl0bnEYCBLf17MgMwI
	DlD0+vydg5CYX5wlXWi9zLzCFct2LRtVRHjsxZVPtbWBe72uXdGaVVhK9sl0jxYd
	bMhpW0Tw8BZJotwM8MJ3/YqQrAWqE7TVr1emw9CQ2PNS/iKa+PicwrG9jbUbse0U
	wMPvRHqLIBxD+mbipMm51JQLHBF+8VLIvtwdmUx0S4HQvzIDZJwQUm4xeNjDJd0N
	NkMqveeLgIy+unf17soV/BgAAWRNmxwjhAOrtgtGbyVB1U25WiGRHdRidLxs+ESm
	n/8h36GGhLFM+XZDgcr/A==
X-ME-Sender: <xms:XU37aNO3Ok8Wd25unM1zQLTXo6FOEgWxWRN_PF_JjWZGBWYJBl1OQw>
    <xme:XU37aG7rS5Qemv1m7qywVkvD4zZrD_SseMOyMJj5Qui0tnkBhfNX5RpJP8g-SyeYw
    VlSno75_g8rqdoNMefTNQJPInGywiF-LWg_--V7Hd4uugKF8-I>
X-ME-Received: <xmr:XU37aB59YkN9BtlIA1uU8ElpVe3bQhx58rF9c4-rOr79OuBLpQjZkiXOyQAm_MQGz8b4fQ4KS7T6_X9ge__FEG-hFqzevdhoXZ_dK4baQQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeeltdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:XU37aO26dfHbPZF5itXGEu28JsUBFlT3hVHXWyKT-B3FgcRxQQ1KMg>
    <xmx:XU37aFV6sg6qq1SD2N3ns1zys6zrZHrYyYkjUq2q4St3Y2dV9N5tgw>
    <xmx:XU37aB5h7dnrPxx0q90X1QIXHaZ99xPHWt3TRbxj6gS6BrGt9I0Cxg>
    <xmx:XU37aEJX-qlsqsqkJRcBSxjcoAQ6GS_-9r1JruX70fMspXIvktccNw>
    <xmx:XU37aJ-fsi-Vn3KuDTcl2HAJlz9qlw6vB_FR6RGwUHr81xMpAO28-uxB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 24 Oct 2025 05:56:44 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1caf0f24 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Fri, 24 Oct 2025 09:56:44 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 24 Oct 2025 11:56:12 +0200
Subject: [PATCH 13/13] object-file: refactor writing objects via a stream
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-b4-pks-odb-loose-backend-v1-13-1a4202273c38@pks.im>
References: <20251024-b4-pks-odb-loose-backend-v1-0-1a4202273c38@pks.im>
In-Reply-To: <20251024-b4-pks-odb-loose-backend-v1-0-1a4202273c38@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

We have two different ways to write an object into the database:

  - We either provide the full buffer and write the object all at once.

  - Or we provide an input stream that has a `read()` function so that
    we can chunk the object.

The latter is especially used for large objects, where it may be too
expensive to hold the complete object in memory all at once.

While we already have `odb_write_object()` at the ODB-layer, we don't
have an equivalent for streaming an object. Introduce a new function
`odb_write_object_stream()` to address this gap so that callers don't
have to be aware of the inner workings of how to stream an object to
disk with a specific object source.

Rename `stream_loose_object()` to `odb_loose_source_write_stream()` to
clarify its scope. This matches our modern best practices around how to
name functions.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/unpack-objects.c |  7 +++----
 object-file.c            |  6 +++---
 object-file.h            | 14 ++++----------
 odb.c                    |  7 +++++++
 odb.h                    | 10 ++++++++++
 5 files changed, 27 insertions(+), 17 deletions(-)

diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index ef79e43715d..6fc64e9e4b8 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -363,7 +363,7 @@ struct input_zstream_data {
 	int status;
 };
 
-static const void *feed_input_zstream(struct input_stream *in_stream,
+static const void *feed_input_zstream(struct odb_write_stream *in_stream,
 				      unsigned long *readlen)
 {
 	struct input_zstream_data *data = in_stream->data;
@@ -393,7 +393,7 @@ static void stream_blob(unsigned long size, unsigned nr)
 {
 	git_zstream zstream = { 0 };
 	struct input_zstream_data data = { 0 };
-	struct input_stream in_stream = {
+	struct odb_write_stream in_stream = {
 		.read = feed_input_zstream,
 		.data = &data,
 	};
@@ -402,8 +402,7 @@ static void stream_blob(unsigned long size, unsigned nr)
 	data.zstream = &zstream;
 	git_inflate_init(&zstream);
 
-	if (stream_loose_object(the_repository->objects->sources,
-				&in_stream, size, &info->oid))
+	if (odb_write_object_stream(the_repository->objects, &in_stream, size, &info->oid))
 		die(_("failed to write object in stream"));
 
 	if (data.status != Z_STREAM_END)
diff --git a/object-file.c b/object-file.c
index 67be5371346..967284c9ee5 100644
--- a/object-file.c
+++ b/object-file.c
@@ -974,9 +974,9 @@ int odb_loose_source_freshen_object(struct odb_source *source,
 	return !!check_and_freshen_source(source, oid, 1);
 }
 
-int stream_loose_object(struct odb_source *source,
-			struct input_stream *in_stream, size_t len,
-			struct object_id *oid)
+int odb_loose_source_write_stream(struct odb_source *source,
+				  struct odb_write_stream *in_stream, size_t len,
+				  struct object_id *oid)
 {
 	const struct git_hash_algo *compat = source->odb->repo->compat_hash_algo;
 	struct object_id compat_oid;
diff --git a/object-file.h b/object-file.h
index 78f0e650d72..905b0f6c9bb 100644
--- a/object-file.h
+++ b/object-file.h
@@ -67,6 +67,10 @@ int odb_loose_source_write_object(struct odb_source *source,
 				  enum object_type type, struct object_id *oid,
 				  struct object_id *compat_oid_in, unsigned flags);
 
+int odb_loose_source_write_stream(struct odb_source *source,
+				  struct odb_write_stream *stream, size_t len,
+				  struct object_id *oid);
+
 /*
  * Populate and return the loose object cache array corresponding to the
  * given object ID.
@@ -173,16 +177,6 @@ enum unpack_loose_header_result unpack_loose_header(git_zstream *stream,
 struct object_info;
 int parse_loose_header(const char *hdr, struct object_info *oi);
 
-struct input_stream {
-	const void *(*read)(struct input_stream *, unsigned long *len);
-	void *data;
-	int is_finished;
-};
-
-int stream_loose_object(struct odb_source *source,
-			struct input_stream *in_stream, size_t len,
-			struct object_id *oid);
-
 int force_object_loose(struct odb_source *source,
 		       const struct object_id *oid, time_t mtime);
 
diff --git a/odb.c b/odb.c
index 432011b4dac..62d65f71a6d 100644
--- a/odb.c
+++ b/odb.c
@@ -1025,6 +1025,13 @@ int odb_write_object_ext(struct object_database *odb,
 					     oid, compat_oid, flags);
 }
 
+int odb_write_object_stream(struct object_database *odb,
+			    struct odb_write_stream *stream, size_t len,
+			    struct object_id *oid)
+{
+	return odb_loose_source_write_stream(odb->sources, stream, len, oid);
+}
+
 struct object_database *odb_new(struct repository *repo)
 {
 	struct object_database *o = xmalloc(sizeof(*o));
diff --git a/odb.h b/odb.h
index 8681b7782b4..92df20417b9 100644
--- a/odb.h
+++ b/odb.h
@@ -492,4 +492,14 @@ static inline int odb_write_object(struct object_database *odb,
 	return odb_write_object_ext(odb, buf, len, type, oid, NULL, 0);
 }
 
+struct odb_write_stream {
+	const void *(*read)(struct odb_write_stream *, unsigned long *len);
+	void *data;
+	int is_finished;
+};
+
+int odb_write_object_stream(struct object_database *odb,
+			    struct odb_write_stream *stream, size_t len,
+			    struct object_id *oid);
+
 #endif /* ODB_H */

-- 
2.51.1.930.gacf6e81ea2.dirty

