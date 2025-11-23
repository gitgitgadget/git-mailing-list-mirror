Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69DA2135CE
	for <git@vger.kernel.org>; Sun, 23 Nov 2025 18:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763924398; cv=none; b=quTI12ep9lXXnmfOuGuQNub18DVECFhBxyUrikI4YU96f+BYKZJlV1YSNcOl8VmslqiG/iMGYgu7lH9Ec+pYzWDG5e50YtnJceycr5iF53p2TOfpN2wBbWn4Va/O5dw7ggQecaPNs/HHFac1pADbOSre7iFD9T03Slq0L8AuqZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763924398; c=relaxed/simple;
	bh=tM8dzZ7rocpxLw7ZIQfVVw2o+my9oD9mkbcCrfe8utY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GUvjYE/XwYqwdDdDjIv4V3/Ebawx7cFrls9wMOAh2v76IDfcDg4EiuLPb9vaGUGWwV4u9ldXI64L0qXsIapDUKSYgsWFCeq8TIzkLdF54O1yD+RnX1eHRlDlw3qP+qW06gTPcSbYPVoc46gA5fwaknlTohrU4J84MmP3+nLu4NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IyHTBhlI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IRiIIfa7; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IyHTBhlI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IRiIIfa7"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 204197A0091;
	Sun, 23 Nov 2025 13:59:56 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sun, 23 Nov 2025 13:59:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763924395;
	 x=1764010795; bh=rEAho17yjRzALsHRa/AXArSxX5q5VW4LfJEbcr8watQ=; b=
	IyHTBhlIJ1K6gyF1zQHWd8oT0YYZJbeA8lV1NK3rwBDdcrHgH7WLYts4bBhnkBxo
	t+yPz5RsinJ2HB56pj6qUR/cH1C0M1AV9FEcRhuosWuBe0JUsVKRklfR4tABpRaa
	uES9WkMYa22Byhexl1/tcekz7cnZotUO+XtoNxIqBEWxkBkkNp3B/X2+8l/i+qlq
	HqH4jXYEYTGFglsNzXAue1lOTdZCuNZLhNJYaQZidqEE50bnbn8aG1eVUPe7xLLY
	W7lm0Azim1dzcM26uExsyKvDIQebm6Tw+OovDtYMJncBkRoN75tedKZ15ECFlKva
	KHx3tyOIQFgRZObiJkSlvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763924395; x=
	1764010795; bh=rEAho17yjRzALsHRa/AXArSxX5q5VW4LfJEbcr8watQ=; b=I
	RiIIfa7J4lD/C6V1vQT+tSZpqyinzhcIdgmdf5EqzY7pH6n59C4++PXYauFg+uUE
	6wFVMD3tftiiBkZgDa9ceb/MV3jcm1FI9qzAfIsJYFzpFwijy1LZj3/m1NktnOSG
	M/mZz+wu5tqWDcySZrjomaNDgLH+eksDK39Mt8HnCGiNQ7p/4lQAgOrJQFAhG7dz
	EguB5c0qRuTLUTwJ4lVSNLeTc8W4QKjqvpLUd9oh1lc6W0AFyBnqEXdfWCkai4lx
	3lrGabocqkqQkHw950zL/ADiyfkNklUT2CT/R4RuD8PPYeJ34y6NpxmeYqBxUkvE
	R/N9CGE7VgiQXbzWe6yhA==
X-ME-Sender: <xms:q1kjaRUEMALL81iIMHXKNLwdFFV7AavA3fBH-Bd6J59I-xKIpuiw5w>
    <xme:q1kjaYlbp26DvKMoZR-Bqptq4JfW4Fp-XfVVoQdcOy1OICTaKNXxNtQ1Ki87_fB7-
    BMe_Gv8CErDs_yhZxiWiF0E6yMw6H72daEjwhB87w1JZMzZX-N46g>
X-ME-Received: <xmr:q1kjaSYdtRfWZzNExbuk7D7I4hWQTpxUD6-JKuFTcRnljYKD2Cl-mr-V73azoDWOIkH_D6GYvc2RVCBOQLVOOFUjCvi2SuIMrxkyxMgaEj6MOQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeeihedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:q1kjaTObdXxlRhCOqAHXjSnB5NIRtri3xUqABgwwxJ2z6op7_ivvBA>
    <xmx:q1kjaXYcyKH1KaJG0bSYxKxeCoo5JndNLAbyfqARH7bhyLuabDCNKQ>
    <xmx:q1kjaR1wJIv3YDcrlfzUeVw8HRaXgMxEKP6OPx0Ro8OTQeEyrt-IIQ>
    <xmx:q1kjadfd5AOF7o4IzweyK-qd4sncsYvye1lXaGNCGOHHfa2LykzHaQ>
    <xmx:q1kjad7uC1yg1H05X5GnH4X_uF4MABFOmTfjefyU8zTWLmxjaz6qG_k3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Nov 2025 13:59:54 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 28fff4ee (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Sun, 23 Nov 2025 18:59:54 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Sun, 23 Nov 2025 19:59:28 +0100
Subject: [PATCH v3 03/19] streaming: propagate final object type via the
 stream
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251123-b4-pks-odb-read-stream-v3-3-1a129182822b@pks.im>
References: <20251123-b4-pks-odb-read-stream-v3-0-1a129182822b@pks.im>
In-Reply-To: <20251123-b4-pks-odb-read-stream-v3-0-1a129182822b@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
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
index 1bb3f393b8..665624ddc0 100644
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
@@ -477,7 +476,7 @@ struct odb_read_stream *open_istream(struct repository *r,
 {
 	struct odb_read_stream *st = xmalloc(sizeof(*st));
 	const struct object_id *real = lookup_replace_object(r, oid);
-	int ret = istream_source(st, r, real, type);
+	int ret = istream_source(st, r, real);
 
 	if (ret) {
 		free(st);
@@ -495,6 +494,7 @@ struct odb_read_stream *open_istream(struct repository *r,
 	}
 
 	*size = st->size;
+	*type = st->type;
 	return st;
 }
 

-- 
2.52.0.rc2.482.gaa765fefd0.dirty

