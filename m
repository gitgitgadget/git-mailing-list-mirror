Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EFC339B5B
	for <git@vger.kernel.org>; Fri, 21 Nov 2025 07:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763710877; cv=none; b=Dwhoy2sv1a1Gq5nqeQhWcS04g4YEHAsnJFpbNoK+RNhwLnCh3E4a2VF3nThjN+DEZAASojfXyxEkqaUvgc4tBEqDfhuLeMYym2I0/raOQMnHTKHx0wBxofr5x8oqJ/PiNTdC3SssePhsqb6luClxlhrySy2qLRH/Kxgj5knEjFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763710877; c=relaxed/simple;
	bh=gVWgLPfkbwxxgcc6fyInKxrs6zBHILqdR7D9PAP41bU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VnmF6WlcBzmzfCW42ufpSw3J36SFPRyJdVcnUuCdMgtkvgezVZFrqHG4/OKz7/PsDsAqcaJLxeCeIDDljR6jhpQxi+lrw57Js/OfBd1tgk2le6PArgxRNQUIRCxhAWdQNDyZRq4lcJUTW0OT8prnfaVhk+w0ecD3KvESQ6UmYCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=S41Devvu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0awEx4oY; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="S41Devvu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0awEx4oY"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C16957A0295;
	Fri, 21 Nov 2025 02:41:12 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 21 Nov 2025 02:41:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763710872;
	 x=1763797272; bh=RwDhGZVsOELNDCLG05K/JupT5q8Fl7NsonQwT6cX1QM=; b=
	S41DevvuUEsCU95LopjnHy5HMl+ge5QLIM2v8DKBHAX8mvhEuhXRvVo69Y3KWSHs
	cZLIk3JNUPTOqTUFlmdRieVy9xE3Nx2aolyjD1Grooo9sJ+lXcRAQLaqwNo+AXec
	EY/wD96B5av0/IlPpyQP1o7P9Lr2WKFXEAq0wW8h0MjDtnLQftMp8TtqNtYYL+2J
	g1I2hvmz6vrOjxaixMTHYcN3ONnihkNKdLG93FlBLCV1ZS1WSx7aJeomzx4OgAbh
	VldzoK+EIvdK70QjVhT/2hHuOfVqbKocFGqS1yJBhmaUIf3ZCsB74xDEq7MT8VLx
	54jOjlH7dAXV8CY3ehJv3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763710872; x=
	1763797272; bh=RwDhGZVsOELNDCLG05K/JupT5q8Fl7NsonQwT6cX1QM=; b=0
	awEx4oYpfPXZrsqqcIEoiBEX6bigqWckmUtkCqeRDoe8Z2MMZG6J+LRKfZyYk7UX
	G2ByzwK2Cn3JuBvZFLklwIQ8XrywyyT1dTKhgX1xLazushgKC1guVi7XGFZW1sMG
	HkRc7REpAmC2XPPhUjF8d5YNiJ7VgJeIYBmNfMPWyATbht71hPyn5AdJp48yKtfL
	H+Mc82UDkXiuZXMGfQfYjrCSKij5yOtz3EAh1RO4NLm6rX/rR7JD8W9R2G26gsQO
	BTpPfSXkfG28njBtUr+yOT6moEdQBFkU48EFtt79hB+XxdsVqP79hTe4EFFNuRvF
	5TGXgDIcWj7x216d/JKTQ==
X-ME-Sender: <xms:mBcgaRWTRZnPuw0yu9Dgh_xqVXhRIgxruY_0xKcFFD_4m7Gr0Tqz9g>
    <xme:mBcgaZB18kN5bcSBLkVMJiLRPvSzcLVBK7TmnPRoU1iA9ijz81-C74iJ2-zWpApWm
    0jHURajB-pWmojJx2zwbLdcph0BICCSwoIH-Ux5q7QSsgUHOzcfbg>
X-ME-Received: <xmr:mBcgaax2GTlH0QoVU2JJQUnLEEcLZ4HfYhX5mndpZfabSMh15vDhll5kpT7RiAm7v4S1YdNQ3ALOr4HPUfKmGwhWICLNATJGR8V6-Z0fpRoa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdelfeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhih
    hkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrgh
X-ME-Proxy: <xmx:mBcgaeCS0KfaYx--nJyvlbHTykJwmKPKUj9nLuHmFH2O10UnxTHmkQ>
    <xmx:mBcgafZEpeh99bnYo0EynOWdO2QiiAarWBL_gd3c52-nranuZlcArg>
    <xmx:mBcgaejhrHvxWAyljRSnGdT1OJmek2beCKVwJtc-RMtDArnR52SQog>
    <xmx:mBcgaZ6pRdvB33AwAfAjb8Sofaa0TzD2q3bZ7Al1MfnZZIMEt3rMrA>
    <xmx:mBcgadcmE7cPbMzIrYKIy8gXUoNMbLDi7pOCZ7mPtAlQtKMSBAVDrmnA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Nov 2025 02:41:11 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0623a1f7 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 21 Nov 2025 07:41:11 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 21 Nov 2025 08:40:48 +0100
Subject: [PATCH v2 03/19] streaming: propagate final object type via the
 stream
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-b4-pks-odb-read-stream-v2-3-ca8534963150@pks.im>
References: <20251121-b4-pks-odb-read-stream-v2-0-ca8534963150@pks.im>
In-Reply-To: <20251121-b4-pks-odb-read-stream-v2-0-ca8534963150@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>
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

