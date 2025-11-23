Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F30227E83
	for <git@vger.kernel.org>; Sun, 23 Nov 2025 19:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763924410; cv=none; b=hsxUGsOq15XO1SL2VPl7ADO6WYXZ8X4SkU4qOZrUCwDA9g282z81yb2XJd8NvXizVkJiqy+PbIk0TVDOTR7eGGOBAVDkLz9MMBedcNt9/5oSPhhW8rAtMKBDE7KXPUheD4Fc3k2bCA9iSEqGbz/DOjsJipHf0hohrdDivWDrz0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763924410; c=relaxed/simple;
	bh=A4tdFzBVOsyjKduRWErb+2Rt10LkFoha4zCfw+W7j3U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RK5ngrCZMqguuVCKUdP6V4doVe5BkSLbxzhdHRL63Wi4i4vPDBphfD35ITq2YLh57WdCKkRXwt8qDfmM1XZOxTJZjZKfMHm1lbi/vlFjPAsHurBgbJ3dUAJL81ateQKim/cPXCN/DoFrdz1YdrghRslvJTEjfE7KeP7S959LtgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IBsKXWDr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QhsQGH4U; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IBsKXWDr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QhsQGH4U"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 187A17A00B2;
	Sun, 23 Nov 2025 14:00:04 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sun, 23 Nov 2025 14:00:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763924403;
	 x=1764010803; bh=uk4EFOMwgwKG2hV3uYiQIWqi/qcXbk94W9XWH+v3eJ0=; b=
	IBsKXWDrDBDDqSliskEpFx6TCGMIdokdY4fyglRPr+I4SCcNdOqoC6t996c47eLl
	G7I5/rX3tJUFswF9lXXes56rCRvZL7Zv/AvfcszScP3BeTFsGBGrLQnkbX1B1pkP
	G/PhkU9taWWkwfLR9JDtH0RuzPkbLi6GT2slS67jThMOV2v5yBAJjgSOmQIYG4dh
	W7EYMSOSRIKsbTQFQB+lkN2zR4f5EXg13M5osj/t0Lb1vvhSTtxFqWOkzUcgyOo2
	ZEg+Y7Xg5qM313ExB0QTK3f0uSJSnXPJkUODu8ETZscrPpxyKNWFq+n1T836km3G
	tcg2S4cJfn+T2ynbIIVhDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763924403; x=
	1764010803; bh=uk4EFOMwgwKG2hV3uYiQIWqi/qcXbk94W9XWH+v3eJ0=; b=Q
	hsQGH4Uimz3uFh5TyxgSE/oM9EGlOo83O3uLpwp6WSa3yABztmHTSB1OccxBesoo
	g8tOC0ytW9521cw1M3YTInNpp5z3Ny0hKvmULiPBSceQoMl9oQOYM4BHPxoSeDw9
	4ZradhuIW3sCH6p1oec1irIhc11PJzwK2NcFHxMicg+TYW75FRuEH5mr9cn44AVM
	gFSbB6Rue0Qjxm37p7kB/dcVaDXoQiLeTfzS1fzyNvrBVQ9UnS9q9DjkwRibs29D
	nODuhuqXhYNEF7Agi/Sfek7HZHSavI2A5IFAfUw2UvdmonEckTzh8lqZePRBVnze
	Thbdhxy3lOnkRr+jEOaYA==
X-ME-Sender: <xms:s1kjaVys68ZGGnJLBKgx5gzzh13bCYl2EtBCNlsLoS9vF6p_Slk1YQ>
    <xme:s1kjacTLMX-URbjECznStCCkKAEPu7udhzmcgYutw5lqRvnrUevKRK0Cj37h-Oimo
    J3kOYbFDHlrjBqbO0r8SQRyR-MeyrgpFq90wu_ZocN5AcF-ESNq6g>
X-ME-Received: <xmr:s1kjaUXo3yMAMm2SFfK9nS_KxF6MppaOQXdkX1L9N6mQl6yhYEfx79TdJHUyFbW9r6G5Ba-AN5VYGWLcO__6_9xVNKDm66FVtGQY0UbDPupRvg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeeihedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeejtdfhvdefhfdtteetkedugfevteehgedvteetgfegudethfehgeeuueehkeeuteen
    ucffohhmrghinhepihhntghorhgvrdhrvggrugdpphgrtghkvggurdhishenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrg
    hrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:s1kjaWbxvz8-2P2f21xSuCjle6_qTmZ0PhIaGS7GP2qpV1cSXdXX5Q>
    <xmx:s1kjaS2i5EIh97OmKHq_9wIBPXy2ucit5S3zD8attaEQNPUboEhz8g>
    <xmx:s1kjaQjJH7tmPhBDnQK-oPFpmo2g5wH6T4YYn8Lg_-AD8R_FMgcyrA>
    <xmx:s1kjaebbcAYFyyzkU5VJf7AEiOx4arqw08QN3SvNwGhDPlO-_UDPsg>
    <xmx:s1kjab02-aB9Fk3Q6oVvId0--DycS2OTDN2dO-LrC6DBUeuQAnAks6Ix>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Nov 2025 14:00:01 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 24718b19 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Sun, 23 Nov 2025 19:00:01 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Sun, 23 Nov 2025 19:59:30 +0100
Subject: [PATCH v3 05/19] streaming: allocate stream inside the
 backend-specific logic
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251123-b4-pks-odb-read-stream-v3-5-1a129182822b@pks.im>
References: <20251123-b4-pks-odb-read-stream-v3-0-1a129182822b@pks.im>
In-Reply-To: <20251123-b4-pks-odb-read-stream-v3-0-1a129182822b@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.3

When creating a new stream we first allocate it and then call into
backend-specific logic to populate the stream. This design requires that
the stream itself contains a `union` with backend-specific members that
then ultimately get populated by the backend-specific logic.

This works, but it's awkward in the context of pluggable object
databases. Each backend will need its own member in that union, and as
the structure itself is completely opaque (it's only defined in
"streaming.c") it also has the consequence that we must have the logic
that is specific to backends in "streaming.c".

Ideally though, the infrastructure would be reversed: we have a generic
`struct odb_read_stream` and some helper functions in "streaming.c",
whereas the backend-specific logic sits in the backend's subsystem
itself.

This can be realized by using a design that is similar to how we handle
reference databases: instead of having a union of members, we instead
have backend-specific structures with a `struct odb_read_stream base`
as its first member. The backends would thus hand out the pointer to the
base, but internally they know to cast back to the backend-specific
type.

This means though that we need to allocate different structures
depending on the backend. To prepare for this, move allocation of the
structure into the backend-specific functions that open a new stream.
Subsequent commits will then create those new backend-specific structs.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 streaming.c | 103 ++++++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 65 insertions(+), 38 deletions(-)

diff --git a/streaming.c b/streaming.c
index bf277daadd..a2c2d88738 100644
--- a/streaming.c
+++ b/streaming.c
@@ -222,27 +222,34 @@ static int close_istream_loose(struct odb_read_stream *st)
 	return 0;
 }
 
-static int open_istream_loose(struct odb_read_stream *st, struct repository *r,
+static int open_istream_loose(struct odb_read_stream **out,
+			      struct repository *r,
 			      const struct object_id *oid)
 {
 	struct object_info oi = OBJECT_INFO_INIT;
+	struct odb_read_stream *st;
 	struct odb_source *source;
-
-	oi.sizep = &st->size;
-	oi.typep = &st->type;
+	unsigned long mapsize;
+	void *mapped;
 
 	odb_prepare_alternates(r->objects);
 	for (source = r->objects->sources; source; source = source->next) {
-		st->u.loose.mapped = odb_source_loose_map_object(source, oid,
-								 &st->u.loose.mapsize);
-		if (st->u.loose.mapped)
+		mapped = odb_source_loose_map_object(source, oid, &mapsize);
+		if (mapped)
 			break;
 	}
-	if (!st->u.loose.mapped)
+	if (!mapped)
 		return -1;
 
-	switch (unpack_loose_header(&st->z, st->u.loose.mapped,
-				    st->u.loose.mapsize, st->u.loose.hdr,
+	/*
+	 * Note: we must allocate this structure early even though we may still
+	 * fail. This is because we need to initialize the zlib stream, and it
+	 * is not possible to copy the stream around after the fact because it
+	 * has self-referencing pointers.
+	 */
+	CALLOC_ARRAY(st, 1);
+
+	switch (unpack_loose_header(&st->z, mapped, mapsize, st->u.loose.hdr,
 				    sizeof(st->u.loose.hdr))) {
 	case ULHR_OK:
 		break;
@@ -250,19 +257,28 @@ static int open_istream_loose(struct odb_read_stream *st, struct repository *r,
 	case ULHR_TOO_LONG:
 		goto error;
 	}
+
+	oi.sizep = &st->size;
+	oi.typep = &st->type;
+
 	if (parse_loose_header(st->u.loose.hdr, &oi) < 0 || st->type < 0)
 		goto error;
 
+	st->u.loose.mapped = mapped;
+	st->u.loose.mapsize = mapsize;
 	st->u.loose.hdr_used = strlen(st->u.loose.hdr) + 1;
 	st->u.loose.hdr_avail = st->z.total_out;
 	st->z_state = z_used;
 	st->close = close_istream_loose;
 	st->read = read_istream_loose;
 
+	*out = st;
+
 	return 0;
 error:
 	git_inflate_end(&st->z);
 	munmap(st->u.loose.mapped, st->u.loose.mapsize);
+	free(st);
 	return -1;
 }
 
@@ -338,12 +354,16 @@ static int close_istream_pack_non_delta(struct odb_read_stream *st)
 	return 0;
 }
 
-static int open_istream_pack_non_delta(struct odb_read_stream *st,
+static int open_istream_pack_non_delta(struct odb_read_stream **out,
 				       struct repository *r UNUSED,
 				       const struct object_id *oid UNUSED,
 				       struct packed_git *pack,
 				       off_t offset)
 {
+	struct odb_read_stream stream = {
+		.close = close_istream_pack_non_delta,
+		.read = read_istream_pack_non_delta,
+	};
 	struct pack_window *window;
 	enum object_type in_pack_type;
 
@@ -352,7 +372,7 @@ static int open_istream_pack_non_delta(struct odb_read_stream *st,
 	in_pack_type = unpack_object_header(pack,
 					    &window,
 					    &offset,
-					    &st->size);
+					    &stream.size);
 	unuse_pack(&window);
 	switch (in_pack_type) {
 	default:
@@ -363,12 +383,13 @@ static int open_istream_pack_non_delta(struct odb_read_stream *st,
 	case OBJ_TAG:
 		break;
 	}
-	st->type = in_pack_type;
-	st->z_state = z_unused;
-	st->close = close_istream_pack_non_delta;
-	st->read = read_istream_pack_non_delta;
-	st->u.in_pack.pack = pack;
-	st->u.in_pack.pos = offset;
+	stream.type = in_pack_type;
+	stream.z_state = z_unused;
+	stream.u.in_pack.pack = pack;
+	stream.u.in_pack.pos = offset;
+
+	CALLOC_ARRAY(*out, 1);
+	**out = stream;
 
 	return 0;
 }
@@ -400,27 +421,35 @@ static ssize_t read_istream_incore(struct odb_read_stream *st, char *buf, size_t
 	return read_size;
 }
 
-static int open_istream_incore(struct odb_read_stream *st, struct repository *r,
+static int open_istream_incore(struct odb_read_stream **out,
+			       struct repository *r,
 			       const struct object_id *oid)
 {
 	struct object_info oi = OBJECT_INFO_INIT;
-
-	st->u.incore.read_ptr = 0;
-	st->close = close_istream_incore;
-	st->read = read_istream_incore;
-
-	oi.typep = &st->type;
-	oi.sizep = &st->size;
-	oi.contentp = (void **)&st->u.incore.buf;
-	return odb_read_object_info_extended(r->objects, oid, &oi,
-					     OBJECT_INFO_DIE_IF_CORRUPT);
+	struct odb_read_stream stream = {
+		.close = close_istream_incore,
+		.read = read_istream_incore,
+	};
+	int ret;
+
+	oi.typep = &stream.type;
+	oi.sizep = &stream.size;
+	oi.contentp = (void **)&stream.u.incore.buf;
+	ret = odb_read_object_info_extended(r->objects, oid, &oi,
+					    OBJECT_INFO_DIE_IF_CORRUPT);
+	if (ret)
+		return ret;
+
+	CALLOC_ARRAY(*out, 1);
+	**out = stream;
+	return 0;
 }
 
 /*****************************************************************************
  * static helpers variables and functions for users of streaming interface
  *****************************************************************************/
 
-static int istream_source(struct odb_read_stream *st,
+static int istream_source(struct odb_read_stream **out,
 			  struct repository *r,
 			  const struct object_id *oid)
 {
@@ -435,13 +464,13 @@ static int istream_source(struct odb_read_stream *st,
 
 	switch (oi.whence) {
 	case OI_LOOSE:
-		if (open_istream_loose(st, r, oid) < 0)
+		if (open_istream_loose(out, r, oid) < 0)
 			break;
 		return 0;
 	case OI_PACKED:
 		if (oi.u.packed.is_delta ||
 		    repo_settings_get_big_file_threshold(the_repository) >= size ||
-		    open_istream_pack_non_delta(st, r, oid, oi.u.packed.pack,
+		    open_istream_pack_non_delta(out, r, oid, oi.u.packed.pack,
 						oi.u.packed.offset) < 0)
 			break;
 		return 0;
@@ -449,7 +478,7 @@ static int istream_source(struct odb_read_stream *st,
 		break;
 	}
 
-	return open_istream_incore(st, r, oid);
+	return open_istream_incore(out, r, oid);
 }
 
 /****************************************************************
@@ -474,14 +503,12 @@ struct odb_read_stream *open_istream(struct repository *r,
 				     unsigned long *size,
 				     struct stream_filter *filter)
 {
-	struct odb_read_stream *st = xmalloc(sizeof(*st));
+	struct odb_read_stream *st;
 	const struct object_id *real = lookup_replace_object(r, oid);
-	int ret = istream_source(st, r, real);
+	int ret = istream_source(&st, r, real);
 
-	if (ret) {
-		free(st);
+	if (ret)
 		return NULL;
-	}
 
 	if (filter) {
 		/* Add "&& !is_null_stream_filter(filter)" for performance */

-- 
2.52.0.rc2.482.gaa765fefd0.dirty

