Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20F5320CAC
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 07:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763538458; cv=none; b=CNuaK1L/EgRcTJ52WuChqEi0YFZCwUqs25v70F2laVZ0urFRAwgOfeO4nFzUQvdD3Er2zYndU7nQLUOk5fC23jeQsb447GqsdYVUwdNgSxB7Xru8FqXozO1dXdR+l8NMxxMmn7rLaxgQ526az7lR1vSgW7iTXdP3txX1w/fQjIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763538458; c=relaxed/simple;
	bh=gVWgLPfkbwxxgcc6fyInKxrs6zBHILqdR7D9PAP41bU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K7s55dsfUcmqoN99o79Ux7VzrOj/2YLeU2iKTouKxF32i5oZ02T9XwNUWDRXB1LUe1eUQeckB+zGNdFzdQPwEXGN77JsQ5/3UD4eOLxKXdebSaXmywr9wRGTGYt2lGYf6BQsmVPPksKVgv0j3GiK1WmdaMfYyCT79tZR5n+8Bmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DHottaav; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qo9w6Vgt; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DHottaav";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qo9w6Vgt"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id BB8FBEC00B4
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 02:47:35 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Wed, 19 Nov 2025 02:47:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763538455;
	 x=1763624855; bh=RwDhGZVsOELNDCLG05K/JupT5q8Fl7NsonQwT6cX1QM=; b=
	DHottaavHAABHGIlh8f9ch+xgjZGU8MQ+Usq+M0wGMWkK3zVAVRolg/IQ/2+o6Qv
	5ZSyMpqxEyoYLnl/8Rdr2i7Gz1WuWa+HNFM/EK6VomOf55a0g0KWa/iaJYa4RDw4
	2+8cOFg35lvX6ykzEP5QQuf3i+iIUurQj7fXkGLlyGrr3nmLf8KmmmTrI2ETxrE0
	J14P04Rz2UBC/erILQ4EqY65NS7U+LwzZdY9Xx8yuLVyMWqh2plfQXSZbEWBvFAo
	/Y0KXh8BV4YitmTHXGtCfPmB2hQKqDxYZ7XRMAX3i5g9z0j2oCWfNd8eIhCwhsAw
	UiMQ/MZuO0QfdjfxdgHjOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763538455; x=
	1763624855; bh=RwDhGZVsOELNDCLG05K/JupT5q8Fl7NsonQwT6cX1QM=; b=Q
	o9w6VgtqasbZVC9lgOhKFg8+lToRfVzFXrT5t6uqcdKuMe/jMnVk9GTvg1cVWGog
	Iproti+gKCgjjuoWk7bNQcUozPcX743yzOHy7XpWtgzrvG+MXge6Ck2B4mBEHnMI
	1SjVBDUAy97Do62eWiYbXp1OOjcu3z7ZvdaZBuHFowBkO9VTPy4ikH8s7XXSuUci
	/e7QRS16DOgXlOwKFvoEi4g3JFqC4bMkE6cJqMSKUBcy3vrWKbRXHNgU4vIjwi7W
	5Lk4bJKVSIn7QIHIkq+sMR8c81F7rYJpUw0dxvOyX/CA1Cc8w420iTRU2N5JaW54
	y3on0xoCF+G3qAP9dz0DA==
X-ME-Sender: <xms:F3Ydaa-WtTH46_puNVHAVYfypcDW8XEHquwKRvfF7eY9m1zGIP9u8w>
    <xme:F3YdaRp3pqF1VA-ose_PsJI7f-WZDNno5DDh9VbX6Q6jDyyj28g2QLMxiS9UeEo7R
    xO0uj00jB9XYcIxfSrRZDAEoEfp9LC98Y2SXUuf7SisFGcrZWRI2g>
X-ME-Received: <xmr:F3YdaVp9_DZ6djQ0NwYwLUNTNfQ6LM-PxX0sChHjmx_vgPIXmXRB0vzw4zypJR1bvPUfNTGb8tz6MWRLLsp5L4fRFh9XXTOpAH7sCCSHnQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdefieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:F3YdaXm8jUWAupoAe1sYpAB1h6ibThivcYFtMZ396oJiWepmThoskw>
    <xmx:F3YdafHqXkP6KkMxjTvkHBRPjUgKrLSSxTqq-8radN-DJrvQNDkH3w>
    <xmx:F3YdaYp7VUwOiHEzYRrQRGmaj8jfk_rCwluN29qxKj0NNox2T4yUSw>
    <xmx:F3YdaT6fmus-LPtO9Y5ovN6WP6uQdnEdcWgomSQ6X037jBZSqqZ-Zg>
    <xmx:F3YdaSscPu3jWGsN6n4W5ayzWclc_cV-p9pbYJIaBzW-Rbn0gdDMBOVZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 19 Nov 2025 02:47:35 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5b15423a (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Wed, 19 Nov 2025 07:47:34 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 19 Nov 2025 08:47:03 +0100
Subject: [PATCH 03/18] streaming: propagate final object type via the
 stream
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-b4-pks-odb-read-stream-v1-3-adacf03c2ccf@pks.im>
References: <20251119-b4-pks-odb-read-stream-v1-0-adacf03c2ccf@pks.im>
In-Reply-To: <20251119-b4-pks-odb-read-stream-v1-0-adacf03c2ccf@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

When opening the read stream for a specific object the caller is also
expected to pass in a pointer to the object type. This type is passed
down via multiple levels and will eventually be populated with the type
of the looked-up object.

The way we propagate down the pointer though is somewhat non-obvious.
While `istream_source()` still expects the pointer and looks it up via
`odb_read_object_info_extended()`, we also pass it down even further
into the format-specific callbacks that perform another lookup. This is
quite confusing overall.

Refactor the code so that the responsibility to populate the object type
rests solely with the format-specific callbacks. This will allow us to
drop the call to `odb_read_object_info_extended()` in `istream_source()`
entirely in a subsequent patch.

Furthermore, instead of propagating the type via an in-pointer, we now
propagate the type via a new field in the object stream. It already has
a `size` field, so it's only natural to have a second field that
contains the object type.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 streaming.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/streaming.c b/streaming.c
index 5ce6350123..9596a94c58 100644
--- a/streaming.c
+++ b/streaming.c
@@ -33,6 +33,7 @@ struct odb_read_stream {
 	close_istream_fn close;
 	read_istream_fn read;
 
+	enum object_type type;
 	unsigned long size; /* inflated size of full object */
 	git_zstream z;
 	enum { z_unused, z_used, z_done, z_error } z_state;
@@ -159,6 +160,7 @@ static struct odb_read_stream *attach_stream_filter(struct odb_read_stream *st,
 	fs->o_end = fs->o_ptr = 0;
 	fs->input_finished = 0;
 	ifs->size = -1; /* unknown */
+	ifs->type = st->type;
 	return ifs;
 }
 
@@ -221,14 +223,13 @@ static int close_istream_loose(struct odb_read_stream *st)
 }
 
 static int open_istream_loose(struct odb_read_stream *st, struct repository *r,
-			      const struct object_id *oid,
-			      enum object_type *type)
+			      const struct object_id *oid)
 {
 	struct object_info oi = OBJECT_INFO_INIT;
 	struct odb_source *source;
 
 	oi.sizep = &st->size;
-	oi.typep = type;
+	oi.typep = &st->type;
 
 	odb_prepare_alternates(r->objects);
 	for (source = r->objects->sources; source; source = source->next) {
@@ -249,7 +250,7 @@ static int open_istream_loose(struct odb_read_stream *st, struct repository *r,
 	case ULHR_TOO_LONG:
 		goto error;
 	}
-	if (parse_loose_header(st->u.loose.hdr, &oi) < 0 || *type < 0)
+	if (parse_loose_header(st->u.loose.hdr, &oi) < 0 || st->type < 0)
 		goto error;
 
 	st->u.loose.hdr_used = strlen(st->u.loose.hdr) + 1;
@@ -339,8 +340,7 @@ static int close_istream_pack_non_delta(struct odb_read_stream *st)
 
 static int open_istream_pack_non_delta(struct odb_read_stream *st,
 				       struct repository *r UNUSED,
-				       const struct object_id *oid UNUSED,
-				       enum object_type *type UNUSED)
+				       const struct object_id *oid UNUSED)
 {
 	struct pack_window *window;
 	enum object_type in_pack_type;
@@ -361,6 +361,7 @@ static int open_istream_pack_non_delta(struct odb_read_stream *st,
 	case OBJ_TAG:
 		break;
 	}
+	st->type = in_pack_type;
 	st->z_state = z_unused;
 	st->close = close_istream_pack_non_delta;
 	st->read = read_istream_pack_non_delta;
@@ -396,7 +397,7 @@ static ssize_t read_istream_incore(struct odb_read_stream *st, char *buf, size_t
 }
 
 static int open_istream_incore(struct odb_read_stream *st, struct repository *r,
-			       const struct object_id *oid, enum object_type *type)
+			       const struct object_id *oid)
 {
 	struct object_info oi = OBJECT_INFO_INIT;
 
@@ -404,7 +405,7 @@ static int open_istream_incore(struct odb_read_stream *st, struct repository *r,
 	st->close = close_istream_incore;
 	st->read = read_istream_incore;
 
-	oi.typep = type;
+	oi.typep = &st->type;
 	oi.sizep = &st->size;
 	oi.contentp = (void **)&st->u.incore.buf;
 	return odb_read_object_info_extended(r->objects, oid, &oi,
@@ -417,14 +418,12 @@ static int open_istream_incore(struct odb_read_stream *st, struct repository *r,
 
 static int istream_source(struct odb_read_stream *st,
 			  struct repository *r,
-			  const struct object_id *oid,
-			  enum object_type *type)
+			  const struct object_id *oid)
 {
 	unsigned long size;
 	int status;
 	struct object_info oi = OBJECT_INFO_INIT;
 
-	oi.typep = type;
 	oi.sizep = &size;
 	status = odb_read_object_info_extended(r->objects, oid, &oi, 0);
 	if (status < 0)
@@ -432,7 +431,7 @@ static int istream_source(struct odb_read_stream *st,
 
 	switch (oi.whence) {
 	case OI_LOOSE:
-		if (open_istream_loose(st, r, oid, type) < 0)
+		if (open_istream_loose(st, r, oid) < 0)
 			break;
 		return 0;
 	case OI_PACKED:
@@ -442,7 +441,7 @@ static int istream_source(struct odb_read_stream *st,
 
 		st->u.in_pack.pack = oi.u.packed.pack;
 		st->u.in_pack.pos = oi.u.packed.offset;
-		if (open_istream_pack_non_delta(st, r, oid, type) < 0)
+		if (open_istream_pack_non_delta(st, r, oid) < 0)
 			break;
 
 		return 0;
@@ -450,7 +449,7 @@ static int istream_source(struct odb_read_stream *st,
 		break;
 	}
 
-	return open_istream_incore(st, r, oid, type);
+	return open_istream_incore(st, r, oid);
 }
 
 /****************************************************************
@@ -479,7 +478,7 @@ struct odb_read_stream *open_istream(struct repository *r,
 	const struct object_id *real = lookup_replace_object(r, oid);
 	int ret;
 
-	ret = istream_source(st, r, real, type);
+	ret = istream_source(st, r, real);
 	if (ret) {
 		free(st);
 		return NULL;
@@ -496,6 +495,7 @@ struct odb_read_stream *open_istream(struct repository *r,
 	}
 
 	*size = st->size;
+	*type = st->type;
 	return st;
 }
 

-- 
2.52.0.rc2.482.gaa765fefd0.dirty

