Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACE62F616C
	for <git@vger.kernel.org>; Fri, 21 Nov 2025 07:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763710883; cv=none; b=AVbOgri5moadz/JYcBjQ8TYOM6L+OHonSHvyvE6JT/AUfR78vos/UxCKQh8a/uoFQiowBY9R6mdE+CtdnwLKFKhrb7HKCT6lsCRTysMumb3WQkbJtRUKf1UK9nhmZaJKXYAI4i8wfAXzgZjwbuqa2byNdtlyOHdWfHC6sLs0kI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763710883; c=relaxed/simple;
	bh=O9PGp5EwRFAitj6XX6tL8GXgbIU51FvHM/2wUkSyOrw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oGl0zDHeCQ8tQ/1aTCLRz3D86NetZlvlrMhybuIDg4bYUui8n8CBrS5GJi2h5I0cB/gNR/gwyBn6N9MvnriJmLyEKjQPb1/kkEd5oYkKiAAa1kGet3MXfwJjKZ7B8eexGNtMxpccZ8tGc1ZUw54dgL301mfufsl7MduA/kXDPKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fgJu3AXV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dui46Lc9; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fgJu3AXV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dui46Lc9"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 87B0D1D0016C;
	Fri, 21 Nov 2025 02:41:20 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 21 Nov 2025 02:41:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763710880;
	 x=1763797280; bh=Oc+jwPtx0wxzFS+gcfnm7lnm1bj3jbDSlSVH2CHB2aU=; b=
	fgJu3AXVJo+QiW5DB7bo5OBuXLgZTjvYCJFoZSmXRiG7HmwwLY1c/1nqwjxts9mJ
	1PGm9mqFvML6c1yoLytzwDovw+r6dcs8dHKZxaGApTNpYiviHuOQZ7uCM6nl4wel
	QTEWYFI/aiHPekIQI6AgSbKckMHm8iMHUpURIPquZ7JwT5lRawpOgMkHJkmfKQAq
	o5wi2ABbuaH0kMHmBDsGbXgDgmXtm56yXpLM0g7PazRc9rFEHsB9cOxZ8kNBPq5q
	zojMKXd+9ZDvaEbasCLHgysgNv4+AtbMFC65i/T/JNJe4SrNuumKsyq7gICnK1sW
	cq5DRru8O/+chtz9oZQxOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763710880; x=
	1763797280; bh=Oc+jwPtx0wxzFS+gcfnm7lnm1bj3jbDSlSVH2CHB2aU=; b=d
	ui46Lc9WvajkUw9FNPkkQJo/R4gEak29B51rrgvyCE8l4DpdfOgT5ml/jIcovg5V
	8rEHlqckBvyb3p8CCbuORCzUrVgXRfuMp4j8c0ZqiagK34HUAi0qhPAqVdT2GGb4
	83EPbkbnD+9vcgOpBD+la7KYNi2tzDXQk1UJn3NWDTu9ioZcMkvd4xl+5YbZs6gy
	lRmFAEir1fYCDzz3gJKewb+2OxNIicgvdiPrpRjxg+/uwJxnFmxV1hSDiWchyRvz
	Dx8Cyupjbkc6DbxPDNx3VId26aZsuA8l6JpgT+aOIkVilOMfCcvVd7U1grwiAPb1
	BtBMhQodF1wEdUzXcXbJw==
X-ME-Sender: <xms:oBcgaQmGrKiV5HRKC5KCyGPH7bJDMH_LqaEmfiOQE-eZ31Mu1qOiYA>
    <xme:oBcgaXQf_-FswMnvDN6ixHKaNy2bJe_wemM71fo_oDjB1vPU35h1h0sdz8czGwOVL
    75MvUXTr9oNIBU9HYQJbFfrALxpqvPWPQTfq6kbB7O1aalUmW40>
X-ME-Received: <xmr:oBcgacCkUDubO1KYDqn1RtIDi3mKYHZwQo66tlpYIMHVsT5cVLNQgYUYsdeNUh7LWvvuAIaI2hyQWLG8hFmw6P-4aI1vgFU7a_8255cnDsZi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdelfeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeejtdfhvdefhfdtteetkedugfevteehgedvteetgfegudethfehgeeuueehkeeuteen
    ucffohhmrghinhepihhntghorhgvrdhrvggrugdpphgrtghkvggurdhishenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrg
    hrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtg
    homh
X-ME-Proxy: <xmx:oBcgaWQpJf-Mc6KmC48RtlysRMuvRs7h-sq6yknY7HvV_8Obs0n5rw>
    <xmx:oBcgaSrzk1Aw8sUWCNJcLIKUC5jhAKIlVRWzqwfIBpuLNbqzX3nhMQ>
    <xmx:oBcgaQzGv9yMHgcu8SNFjBKMP8OJsdpqz7Ci6WaDR2iqkYcqcf2fHQ>
    <xmx:oBcgafIkebKmYQwMXWTfgS83BqwfgXLNTtRsOSyNs2PoBqexRVuN8w>
    <xmx:oBcgafvOcNHTktluiyQPuk0ivZ8avfqgO7cNC6rGCtz2kmnu5IpnFCet>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Nov 2025 02:41:19 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id aff96442 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 21 Nov 2025 07:41:18 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 21 Nov 2025 08:40:50 +0100
Subject: [PATCH v2 05/19] streaming: allocate stream inside the
 backend-specific logic
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-b4-pks-odb-read-stream-v2-5-ca8534963150@pks.im>
References: <20251121-b4-pks-odb-read-stream-v2-0-ca8534963150@pks.im>
In-Reply-To: <20251121-b4-pks-odb-read-stream-v2-0-ca8534963150@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>
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
 streaming.c | 99 +++++++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 63 insertions(+), 36 deletions(-)

diff --git a/streaming.c b/streaming.c
index d7db446d25..b8ce82483f 100644
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
+	struct odb_read_stream stream = {
+		.close = close_istream_incore,
+		.read = read_istream_incore,
+	};
+	int ret;
 
-	st->u.incore.read_ptr = 0;
-	st->close = close_istream_incore;
-	st->read = read_istream_incore;
+	oi.typep = &stream.type;
+	oi.sizep = &stream.size;
+	oi.contentp = (void **)&stream.u.incore.buf;
+	ret = odb_read_object_info_extended(r->objects, oid, &oi,
+					    OBJECT_INFO_DIE_IF_CORRUPT);
+	if (ret)
+		return ret;
 
-	oi.typep = &st->type;
-	oi.sizep = &st->size;
-	oi.contentp = (void **)&st->u.incore.buf;
-	return odb_read_object_info_extended(r->objects, oid, &oi,
-					     OBJECT_INFO_DIE_IF_CORRUPT);
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
@@ -474,15 +503,13 @@ struct odb_read_stream *open_istream(struct repository *r,
 				     unsigned long *size,
 				     struct stream_filter *filter)
 {
-	struct odb_read_stream *st = xmalloc(sizeof(*st));
+	struct odb_read_stream *st;
 	const struct object_id *real = lookup_replace_object(r, oid);
 	int ret;
 
-	ret = istream_source(st, r, real);
-	if (ret) {
-		free(st);
+	ret = istream_source(&st, r, real);
+	if (ret)
 		return NULL;
-	}
 
 	if (filter) {
 		/* Add "&& !is_null_stream_filter(filter)" for performance */

-- 
2.52.0.rc2.482.gaa765fefd0.dirty

