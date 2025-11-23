Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFA42459E1
	for <git@vger.kernel.org>; Sun, 23 Nov 2025 19:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763924427; cv=none; b=sBCcaXTjT4JN6OCeuspCtKoeIvaXTRQmU4Aa01x9x1MAGQoPuHMMaJSQaaSSnYvqxothFvuem0ZVmKajJHFXvvFrwR/DKYJQJOcRcRBhkhm44M3+dt8zevy9Odbz6lhI8RhKooQb4rXqnmQxAGLf1p3mMh07rYxeOILhjtLccbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763924427; c=relaxed/simple;
	bh=MhjsZBlrG+sTqFoXmvhQipSCktvENd5zaBY3GIp07hw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kQRn1TcrkZfmQjpsDxT/vU28EXYdVpVvGEjUeYYAgx8W8q5IAPSvXDi1ZC0uGgkBrF6rSdy2b54GgP3yTnQO3uuQDbM4RQYvhrZqzuhv14VK5oCZbwBzo8N9DVt7ygNhAFyRei785nyTBg97kesDiS8VQcd70/LCfUnIvdECoqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ntJzOb2+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i1cJqC+3; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ntJzOb2+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i1cJqC+3"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 7F6E61D000C3;
	Sun, 23 Nov 2025 14:00:25 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sun, 23 Nov 2025 14:00:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763924425;
	 x=1764010825; bh=WrF7L0/vXGqMiI7+Eb6Y2y0Q+BbVAO4wQ4jdIMx1F6A=; b=
	ntJzOb2+m32GJdua8l+KlAtaTTECuOroDb+ulEiOEvyQ543NQPjfU//PX5Q+zvwP
	1dIIZQsJ2xglL/EqaZs679ODMxatvxrN6DG/5QdP3v9yFRKZ95uEw6rvqPEgs/mq
	qNr0VLkY/xd3pQXbdHv+Fjbv8yXz07cTqXv1qlUkmEPmlKwKMikjQsHhXFDlg0UA
	AWmbkRi/D3SHPcaYs30pzmMfvX3E5T55fCYhJaWNcXyosY10aUQKNErnqj0vLdBa
	m3AubfNFc73OnopH2ZscD9v0FGQVWX1J++3POYvmElg9XIbkVSI9q/7h//Z3xjBo
	5B1cjkZef4ofv7HXN58qOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763924425; x=
	1764010825; bh=WrF7L0/vXGqMiI7+Eb6Y2y0Q+BbVAO4wQ4jdIMx1F6A=; b=i
	1cJqC+3MKGn5zvN1UyjQ5Y5toPRLkfWDaoBwXC0Y/2ZlyXUUulFN7pNp/YxXxS46
	9IMDC5RqldnKXHKWPP5H1uyS90H2acHDKzmzg1hV1KJtZ56AivzQMozqbmIApbRe
	gC98mohbdQzDvFFoi7Lep9BrhvUZjAbF+t4Y2W1MhQrsyZyj6FjRNrQ83n197nTU
	vkzeUNyBjWFAxSjBR1badyrkenFtxe3VdYaUeBkr7rc7gaBXNbym3MXVOB1SXG/c
	+hC+CfndMFd8o3sXqQZ4wRNc+NojY4C8TKoH9moqNXEo2zmjR06InLbYTK9lpYhz
	ZMXtw/TdDp+uRgcZmu9Xg==
X-ME-Sender: <xms:yVkjaUgqyo0RKTtbHBbTE2juCLZqryAp_t1xuP4fJvaGgn_DEQD4cg>
    <xme:yVkjaUBxn86CugBe4xA7AYSE7694VlJPvi5jegMbIeFGZBw7ZF5a89A-TWKvtvt3i
    oK4M0ADc5GxXdcc37hbawPHqty2_rtb0ZC3dZ7pFAjxBA8rr3GleA>
X-ME-Received: <xmr:yVkjaRHGjI6vu8ka6hzfSaRiK_jNmncbcJiKwRg0V91LhJ26fl5BUJ0wLYJIecXcBAQc2kGGG40TpeZRaNUMPcqzM2H-dKFKGDprgEGB_IAuZA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeeihedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeekieevveegieevieeuveefheffgeeuheetheegffffkeeijedtueefleffvdevleen
    ucffohhmrghinhepphgrtghkvggurdhishenucevlhhushhtvghrufhiiigvpedunecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeg
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlth
    hosghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:yVkjaUKpr1p5w5o3N-kQ20PGmRqFnZcVig1MauUYMS9o1P2ZcgH08A>
    <xmx:yVkjadmS9WDkMz1X9fINMLXB6SXt5P3WSg0KNW_ECi8CuLLAOPdnJA>
    <xmx:yVkjaUTKIMekvK21YrWC8tPDd1My8uQjZk8Vy8Fd_o5J_0AA5ownNg>
    <xmx:yVkjaXJKSjXJGFNA2PPoysjC5quEf3uJBJXt_-n8SH2PN2sYd9on3A>
    <xmx:yVkjaYnL7LuFhGtZEl3miI5CThnkevRyJxmjxek_Lm1V6Mg5FrjA6Xa5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Nov 2025 14:00:24 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7ba8bac2 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Sun, 23 Nov 2025 19:00:23 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Sun, 23 Nov 2025 19:59:37 +0100
Subject: [PATCH v3 12/19] streaming: rely on object sources to create
 object stream
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251123-b4-pks-odb-read-stream-v3-12-1a129182822b@pks.im>
References: <20251123-b4-pks-odb-read-stream-v3-0-1a129182822b@pks.im>
In-Reply-To: <20251123-b4-pks-odb-read-stream-v3-0-1a129182822b@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.3

When creating an object stream we first look up the object info and, if
it's present, we call into the respective backend that contains the
object to create a new stream for it.

This has the consequence that, for loose object source, we basically
iterate through the object sources twice: we first discover that the
file exists as a loose object in the first place by iterating through
all sources. And, once we have discovered it, we again walk through all
sources to try and map the object. The same issue will eventually also
surface once the packfile store becomes per-object-source.

Furthermore, it feels rather pointless to first look up the object only
to then try and read it.

Refactor the logic to be centered around sources instead. Instead of
first reading the object, we immediately ask the source to create the
object stream for us. If the object exists we get stream, otherwise
we'll try the next source.

Like this we only have to iterate through sources once. But even more
importantly, this change also helps us to make the whole logic
pluggable. The object read stream subsystem does not need to be aware of
the different source backends anymore, but eventually it'll only have to
call the source's callback function.

Note that at the current point in time we aren't fully there yet:

  - The packfile store still sits on the object database level and is
    thus agnostic of the sources.

  - We still have to call into both the packfile store and the loose
    object source.

But both of these issues will soon be addressed.

This refactoring results in a slight change to semantics: previously, it
was `odb_read_object_info_extended()` that picked the source for us, and
it would have favored packed (non-deltified) objects over loose objects.
And while we still favor packed over loose objects for a single source
with the new logic, we'll now favor a loose object from an earlier
source over a packed object from a later source.

Ultimately this shouldn't matter though: the stream doesn't indicate to
the caller which source it is from and whether it was created from a
packed or loose object, so such details are opaque to the caller. And
other than that we should be able to assume that two objects with the
same object ID should refer to the same content, so the streamed data
would be the same, too.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 streaming.c | 65 +++++++++++++++++++++++--------------------------------------
 1 file changed, 24 insertions(+), 41 deletions(-)

diff --git a/streaming.c b/streaming.c
index 46fddaf2ca..f0f7d31956 100644
--- a/streaming.c
+++ b/streaming.c
@@ -204,21 +204,15 @@ static int close_istream_loose(struct odb_read_stream *_st)
 }
 
 static int open_istream_loose(struct odb_read_stream **out,
-			      struct repository *r,
+			      struct odb_source *source,
 			      const struct object_id *oid)
 {
 	struct object_info oi = OBJECT_INFO_INIT;
 	struct odb_loose_read_stream *st;
-	struct odb_source *source;
 	unsigned long mapsize;
 	void *mapped;
 
-	odb_prepare_alternates(r->objects);
-	for (source = r->objects->sources; source; source = source->next) {
-		mapped = odb_source_loose_map_object(source, oid, &mapsize);
-		if (mapped)
-			break;
-	}
+	mapped = odb_source_loose_map_object(source, oid, &mapsize);
 	if (!mapped)
 		return -1;
 
@@ -352,21 +346,25 @@ static int close_istream_pack_non_delta(struct odb_read_stream *_st)
 }
 
 static int open_istream_pack_non_delta(struct odb_read_stream **out,
-				       struct repository *r UNUSED,
-				       const struct object_id *oid UNUSED,
-				       struct packed_git *pack,
-				       off_t offset)
+				       struct object_database *odb,
+				       const struct object_id *oid)
 {
 	struct odb_packed_read_stream *stream;
-	struct pack_window *window;
+	struct pack_window *window = NULL;
+	struct object_info oi = OBJECT_INFO_INIT;
 	enum object_type in_pack_type;
-	size_t size;
+	unsigned long size;
 
-	window = NULL;
+	oi.sizep = &size;
+
+	if (packfile_store_read_object_info(odb->packfiles, oid, &oi, 0) ||
+	    oi.u.packed.is_delta ||
+	    repo_settings_get_big_file_threshold(the_repository) >= size)
+		return -1;
 
-	in_pack_type = unpack_object_header(pack,
+	in_pack_type = unpack_object_header(oi.u.packed.pack,
 					    &window,
-					    &offset,
+					    &oi.u.packed.offset,
 					    &size);
 	unuse_pack(&window);
 	switch (in_pack_type) {
@@ -385,8 +383,8 @@ static int open_istream_pack_non_delta(struct odb_read_stream **out,
 	stream->base.type = in_pack_type;
 	stream->base.size = size;
 	stream->z_state = ODB_PACKED_READ_STREAM_UNINITIALIZED;
-	stream->pack = pack;
-	stream->pos = offset;
+	stream->pack = oi.u.packed.pack;
+	stream->pos = oi.u.packed.offset;
 
 	*out = &stream->base;
 
@@ -463,30 +461,15 @@ static int istream_source(struct odb_read_stream **out,
 			  struct repository *r,
 			  const struct object_id *oid)
 {
-	unsigned long size;
-	int status;
-	struct object_info oi = OBJECT_INFO_INIT;
-
-	oi.sizep = &size;
-	status = odb_read_object_info_extended(r->objects, oid, &oi, 0);
-	if (status < 0)
-		return status;
+	struct odb_source *source;
 
-	switch (oi.whence) {
-	case OI_LOOSE:
-		if (open_istream_loose(out, r, oid) < 0)
-			break;
-		return 0;
-	case OI_PACKED:
-		if (oi.u.packed.is_delta ||
-		    repo_settings_get_big_file_threshold(the_repository) >= size ||
-		    open_istream_pack_non_delta(out, r, oid, oi.u.packed.pack,
-						oi.u.packed.offset) < 0)
-			break;
+	if (!open_istream_pack_non_delta(out, r->objects, oid))
 		return 0;
-	default:
-		break;
-	}
+
+	odb_prepare_alternates(r->objects);
+	for (source = r->objects->sources; source; source = source->next)
+		if (!open_istream_loose(out, source, oid))
+			return 0;
 
 	return open_istream_incore(out, r, oid);
 }

-- 
2.52.0.rc2.482.gaa765fefd0.dirty

