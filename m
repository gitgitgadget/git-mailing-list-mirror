Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A755332692B
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 07:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763538490; cv=none; b=AVcznhpHUOKV2RRPyYE7rCp9xt4DMJVuYLwx8rMk8JmbPnRTmSBasbTuzjuWC/oaX1JecbbD3WUbwaFulKfU6Tj+zpoLI84v0Dgbi73OTq/kuFoY7MiNA2+CEW9Q2wsE09+tag+iQ9fvinQB0/zdgvkINNh07xfNom3276bCmd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763538490; c=relaxed/simple;
	bh=0O6h+rusbvZ2m1+mTaf4LkQ5fnTuNq0flsBVSA4ZRuU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eyYijS/0GppXiE0T7yrbVBCw5jr44wLV3Cgyynr0UAiaHpfOkZ0R3BNFl/PVt0ICeMeMy8y/XK8gmMx9pWJp9IzUMzSZ+bAT5xDMRbQOuNyyquljEKunPiITcdGogxOelYqjOREjdRtbWw9NEs4Pw7zz4Qal9eEJRs6OlHNAXO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CnJ+W5ch; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UkWvnwjr; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CnJ+W5ch";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UkWvnwjr"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0BCBC1400218
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 02:48:08 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 19 Nov 2025 02:48:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763538488;
	 x=1763624888; bh=iXgGb+V6PC9XHd3LkscRTeDOq/+xHEac7FRMSSWAab4=; b=
	CnJ+W5chBsJzxWMvNrTiLzzOj28QT6v4ylQbCbC3ZiucgCJdhfaLKnWBNXSdvm+U
	AW3+3goot9safypTwO0Z0hQu6Ap69wTF2jPiJAoXttDV/ZEgX74t/g3CmwX8205O
	y84YJAriCSvILXWvjtmQZldQkqXWDgEStAagy8tYqU0KDTOepVoqqDlffQVG46K8
	sVul2fvj6qibbLNpUkcLKwNgVCxWdfWFQz9Dfsllnc4mowmqz4/o/4/ykKHVahiv
	LL4LTQTWts8cyEQVUCIh+tt0YsTpVO1n+W5zePkrfXlTKqKyW7BGr5DGxAQkV258
	8DS17f41orIthJ1wVo6hoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763538488; x=
	1763624888; bh=iXgGb+V6PC9XHd3LkscRTeDOq/+xHEac7FRMSSWAab4=; b=U
	kWvnwjr3ML9E/Lnzcp8GMoOjFCXM+vjplvGD1lFV7hoGvunYC6fl9m5AagaIZqgU
	7Urx10u74QoZNhXZiqKP+GyGYhS24VHL4EWTqhOSlQcGKRjncOxyvqkitZ+w1B8M
	7BlVBaGsPtvyjVRPxbPZse5UYGE25/xhYF13Pne1M8jmoTPSKagdvc/eIHbxkXmW
	XN5saXWY9vRlKWd/DOhWcNj4FMW9NEA8OyEAPPLxae2d4/cTazGNANP9Gplp5NFC
	oJHfbRvYuvl0qMBUpJ9el5H0B2oshhhyaAV3foCPJsa53PTcjGSu7KVea+eOHSso
	9fPsoxsa148jSuY8YhxIA==
X-ME-Sender: <xms:N3YdaRs86zmTr-IUHPPRWG-MuYwYBzVKEOEnzCY4R6BDqodDD2k4Jg>
    <xme:N3YdaRburHpi6HFwjHxArfdDS6xo2uVnWAbkBPG4Fryx4XoxLl96LpD7eukJmPUfv
    FMjGkKxzDfcw7v12oSccORQdvLdCQoM-HvjzughmWrn5RHubdF9oQ>
X-ME-Received: <xmr:N3YdaaaO86X1cB7q0hev7cQNp5NoYW6Tr3hByNazQcgbBXLmjTKfqx8NV3MvkZpJKJpplfkSn2QA2sTAbdQXZAPZHiLWcMglo5RDfgPxVQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdefieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgovfgvgihtqfhnlhihqddqteefjeefqddtgeculdehtd
    dmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefr
    rghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrg
    htthgvrhhnpeekieevveegieevieeuveefheffgeeuheetheegffffkeeijedtueefleff
    vdevleenucffohhmrghinhepphgrtghkvggurdhishenucevlhhushhtvghrufhiiigvpe
    dunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphht
    thhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:N3YdadVhWli1ngUi8HRrgI9-MwujqlO94ES5ijEu26N9UY9Wi8abkg>
    <xmx:N3YdaR374VnTm4mZ9xZxvKjwHsAU4wG60JIe04GQebuOVeW3sljyzg>
    <xmx:N3YdaUbmOrPiNZ8DIyx915FV5psYi8ha-142Mxh2VGq5Tnzzab0gGA>
    <xmx:N3YdaUr5fUZKG05_rsrinPAMWunMTgdS-hxc2BFjOAfGM7QbA_7Ccw>
    <xmx:OHYdaYfQLrp7NWTyRZ02mhJC2dM_E80Yxodc5HMx6mA0F6CdldQFFcBx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 19 Nov 2025 02:48:07 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 71addee6 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Wed, 19 Nov 2025 07:48:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 19 Nov 2025 08:47:12 +0100
Subject: [PATCH 12/18] streaming: rely on object sources to create object
 stream
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-b4-pks-odb-read-stream-v1-12-adacf03c2ccf@pks.im>
References: <20251119-b4-pks-odb-read-stream-v1-0-adacf03c2ccf@pks.im>
In-Reply-To: <20251119-b4-pks-odb-read-stream-v1-0-adacf03c2ccf@pks.im>
To: git@vger.kernel.org
Cc: 
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

Note that at the current poin in time we aren't full there yet:

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
index 572be98248..bebb434cd1 100644
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
 
@@ -462,30 +460,15 @@ static int istream_source(struct odb_read_stream **out,
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

