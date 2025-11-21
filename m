Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC741337BBA
	for <git@vger.kernel.org>; Fri, 21 Nov 2025 07:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763710909; cv=none; b=hyd4KrA2+3M3zurf672rA3krGY/wpxWmnkU9XSBX7kzbDUT+QJxcrfIKTkgBMGBHIEK3DJDqRpylXXYrIoo0MGbUkzRDTviF+aJbgimCPXzQpuNWJV7JkT/7twigFF+hc450pE5CLiMNgKCqN41PNhHKn4wL2h6aW2zd8FTv1aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763710909; c=relaxed/simple;
	bh=WZ0yIJh4kQ421u3pNcFYXctxiN8dU7603zCIRj3JW4s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HjEVD9F6hJUUrOkQk0PrWqx/I+rTbImlXo20DtvRGwjEV83IPPLZZdPmDeREI6ti+/gUjgzURBsVkICsBCwvlKO13QIm+DCKPimccH7aQLcHIhI61eezFRsxls2fArCkXOhjvO6oL/0fXJosMQndpBf6ySK9OpJxYDEf7I3MdJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MZBaagp6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m1nZ3ghI; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MZBaagp6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m1nZ3ghI"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id D7F3E1D00176;
	Fri, 21 Nov 2025 02:41:46 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 21 Nov 2025 02:41:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763710906;
	 x=1763797306; bh=uoo9cHrUo5pKXJ8ud/54OLRa+SFx7iKNVC1BNtgGtFw=; b=
	MZBaagp6try4gsN1aIJVnFZ4b1Uvmy5BIgvF//3fXbRC/Vzsm39JbzRelgf31F0P
	ZCZiFkfODvpOjJdKIdZ4LUN+yS0CcxQRU4G5NmrSzI6P4Z8Farg6jYZj/if6E+ZN
	/HS0GKQ0Gc7Lye0zlcVWErOCnnTmzBOVP2XJJI+bQLQ84hTHDrcnuAc26FYZYgFw
	GhiM6jvZQy3ArD0F1FK0VBdjavUTPGQKCFBZAUwMcdF+bsD6KhzwSmYpi8SaInUk
	8b7/8udvcTS3bEY5G5+o6RWyCYne1WEpwq2HcbPK79FshCC063bThAp03h1hTS/O
	k3V+N/vlr8j9qDFPU8nhHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763710906; x=
	1763797306; bh=uoo9cHrUo5pKXJ8ud/54OLRa+SFx7iKNVC1BNtgGtFw=; b=m
	1nZ3ghI1Su16fYCZZBZMUV7h8/a6P7MkwvKQq4It+Hfz034OJ6TekwDCSM/bQQIH
	Hw+3fHeYv4lu3UimxlXM+JhrjPejBZuBeCG1X28PX07XVgklCSo39k9UIWOiBJZV
	93Rwflk6KLbyTc/yh4T9a+5dRBdz+Ea7EXwefd8y8pdwcM50bzbJpKSxGjaZUM+q
	qRYC9TJWmWXwZXG7ky74ZSacl+Q1Tln052CrV0vPgYPpDov+uv2Eg78dVTNqOvs/
	Xwo8xqRpebjn/HSaWqojlmR9Nhln6dVPB/LGvVnaRrUraIoGPLroSoN0lxoHFZUd
	I+xIPa1TFJy5Hpxm8vWog==
X-ME-Sender: <xms:uhcgaRw_xsDWlA7l1cOg-32tQRksna7_uOUWeUJ20hmz9YM7EkAqdg>
    <xme:uhcgaYv-vVicYQ9J_hDz07_ouukIBBCW6BJL46X9zgLPJK7ndCuGi6wVlCAwGalUb
    3t7KXE9acVv2IDavwyW7DrLndKA4p9dEmYxwQ1qbVa9N2XQKYyK9g>
X-ME-Received: <xmr:uhcgaYtLOOJb6C8qvhnUdheGKId4l2Gm0nG3md0ETHiNKyqszcAuih8XAaYW_a0aq8M4pbXx0evvimN37ib7-Ps9U1zZ7tgcqoUQApghNXq6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdelfeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeekieevveegieevieeuveefheffgeeuheetheegffffkeeijedtueefleffvdevleen
    ucffohhmrghinhepphgrtghkvggurdhishenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeef
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmh
    grihhlrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:uhcgadOPxfyNY8u-KS-GaZ8bY719B_KeKxhsI_wpOzMA9bgoHBjqCg>
    <xmx:uhcgaW1KOxpfXYVG6YDDlxCB40aojdKi3UZGNx9WjaLZl4Tiha9CLw>
    <xmx:uhcgaZMfKp01QcmNEjvbrr_4rwXRKYGUSKnKvnhlhAGXYPizirbVQQ>
    <xmx:uhcgaW2NpMZrR58IQ6IYldwDdJNbLX7EvbsKgslsxW32tXIu1nEUog>
    <xmx:uhcgaYKHBRWt2VoXWiO3wsyrEAdIw8NbQOKkcTxOwjxrphmY9H6zfrY5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Nov 2025 02:41:45 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9c887a43 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 21 Nov 2025 07:41:45 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 21 Nov 2025 08:40:57 +0100
Subject: [PATCH v2 12/19] streaming: rely on object sources to create
 object stream
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-b4-pks-odb-read-stream-v2-12-ca8534963150@pks.im>
References: <20251121-b4-pks-odb-read-stream-v2-0-ca8534963150@pks.im>
In-Reply-To: <20251121-b4-pks-odb-read-stream-v2-0-ca8534963150@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>
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

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 streaming.c | 65 +++++++++++++++++++++++--------------------------------------
 1 file changed, 24 insertions(+), 41 deletions(-)

diff --git a/streaming.c b/streaming.c
index 93fe72182a..fc7d88e313 100644
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

