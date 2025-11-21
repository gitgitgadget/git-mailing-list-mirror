Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4BD337B9A
	for <git@vger.kernel.org>; Fri, 21 Nov 2025 07:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763710872; cv=none; b=fkhMZq3IS634von32YmkIsaCj3OBXJWiKoUqLeC6DccLuRF4O3eophfTA8zrS4wwXbIM4dtLAesd2BFSodrq2kuORE2OVg5dA/aFTyqN09k5vMjgk/qGRCHc6lPEpd6qCDchM3kOn1T1bR/5NukgZ/w5P/fSeIsR90tKsqrxU6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763710872; c=relaxed/simple;
	bh=kIhpmMiGmizMaC9kOb8xLG6gnoWNm8zRGQ4xAC4hgvk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ed9LwKkS80s8xbHEDT8nSliqUadye45Hee8ek+F/nwxiPQbHyERylk7k7d7F6LC2x4dcyuXNYR/oYPpn0XTYFPuHAEOxZ37SiS55aQpUE6+8P9eWqf0hKoQM/cOwL1bkAW6MFpliBwJjmIYWP4CN3ywYoU4amz0oDYx3De76Aio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IEIqjeLh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W1AdnLH9; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IEIqjeLh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W1AdnLH9"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 63D2C7A01AC;
	Fri, 21 Nov 2025 02:41:09 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 21 Nov 2025 02:41:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763710869;
	 x=1763797269; bh=KtxFvH15ohwsI1Zg87ZOOE0laCx8pXjEHXHGEcwLrg8=; b=
	IEIqjeLh8CF+7j56V1iN30p5Au8G2KQIagFmlmEobh3cKGkCvOEUYQ8aU3vUI6KR
	dq/Mdq84vxbrxE9fUQ0u1lo+XG5wzYqmP5xyIA+fgB4rZrTHfushejfS2XV36r13
	w0fohr7j/rabmAArsv2QAf2xIxxiNSrHjQLCqRF7DhwHDYxeOLcdml9K8vJJ0/VT
	DAicODNE+L9wTB06qBRk9obUjdfHf8+GDM9HgwRPEnXoWtizEdGLGPg5XlkFJNZK
	Num66QDsEs7NE9Hf5AXnOatB7ApRFPn4OBhc+cWlAXEarQvCClaAqOZPmCoTT9No
	e5BalHx6dv5OhElkxzS2eg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763710869; x=
	1763797269; bh=KtxFvH15ohwsI1Zg87ZOOE0laCx8pXjEHXHGEcwLrg8=; b=W
	1AdnLH9HtL+c7Jqo7mrpedglYX+ECVd8xo6H7WlOa+BclcwpTFvgvSx9GpdRkzkh
	OMGPg0LUvpUJQmtOFfF4EOvM2FtUrfRm6jgwOXgfQ2t/neXlmboQB+IaXfls5znf
	4bYXJ/YWeNQr5wlOv8TuuZWviz8jh4Au699XV+HkB0qNEYniB0vKgaA7FbBp+ftC
	Ji1z36TdzR76lcXvRerROHfWqbQKhOEkTqK6Q8aC2Uf5/JduqrS7k+4Qt9x7MWlz
	yEW5X2h7n+X1eob8NtCCuv0MT2tktS/VUfdz6kO0WAw3YKZS3Kaz+6EotuB+AlgH
	r57lGtOenBvfvFRqpRzWg==
X-ME-Sender: <xms:lBcgaUYgsiCvzEocTVpANZmL_q0H0FbQgWvgj9fK5N-oqDTaQbxunA>
    <xme:lBcgaW2ZMBv9v1ugFgwByNG2mUzIZf3r8YDdApiWmDgf436aPt024cjJJt_ioqUmA
    IgBtDvpGLD2ZPYFrlW5AD8TRrpgNtjaC4rDLkyKbh4wUQm15AH_Yg>
X-ME-Received: <xmr:lBcgacVJg2iSaAOlyHNLPzri2uGGB_bN7QRW4cDvKzjOWEcof0jTY6qMNpvRwf6g3USZqW7T0hMuPecVKGBZ-_0qORd7UqjbK9qjMOlFh3hv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdelfeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeekieevveegieevieeuveefheffgeeuheetheegffffkeeijedtueefleffvdevleen
    ucffohhmrghinhepphgrtghkvggurdhishenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeef
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:lRcgaYXqkzQ4t_889KqZxb9WISglFrgqklNm8eF-z26RiiXgYg-0CQ>
    <xmx:lRcgaTfUqzp0sK1Qu4FWK1YnsiYTsTwVJZjFBdpwjCQ-iKZ0VickGg>
    <xmx:lRcgaZVGGLtWmtylpA-D3znPp12963na43-1MUESwl59WwhnA4lKcA>
    <xmx:lRcgaUf17i1jJBhdrJn6vkJR9NFzroYWC8gbOQADHnrQJN1V5iwntQ>
    <xmx:lRcgaYSA7yuOKBMugSlkcsvKDQ6MFQmqdjOCyuLaOBOF67_jKBFPFOCf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Nov 2025 02:41:08 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d24a0d3f (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 21 Nov 2025 07:41:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 21 Nov 2025 08:40:47 +0100
Subject: [PATCH v2 02/19] streaming: drop the `open()` callback function
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-b4-pks-odb-read-stream-v2-2-ca8534963150@pks.im>
References: <20251121-b4-pks-odb-read-stream-v2-0-ca8534963150@pks.im>
In-Reply-To: <20251121-b4-pks-odb-read-stream-v2-0-ca8534963150@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.3

When creating a read stream we first populate the structure with the
open callback function and then subsequently call the function. This
layout is somewhat weird though:

  - The structure needs to be allocated and partially populated with the
    open function before we can properly initialize it.

  - We never use the `open()` callback after having opened it initially.

Especially the first point creates a problem for us. In subsequent
commits we'll want to fully move construction of the read source into
the respective object sources. E.g., the loose object source will be the
one that is responsible for creating the structure. But this creates a
problem: if we first need to create the structure so that we can call
the source-specific callback we cannot fully handle creation of the
structure in the source itself.

We could of course work around that and have the loose object source
create the structure and populate its `open()` callback, only. But
this doesn't really buy us anything due to the second bullet point
above.

Instead, drop the callback entirely and refactor `istream_source()` so
that we open the streams immediately. This unblocks a subsequent step,
where we'll also start to allocate the structure in the source-specific
logic.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 streaming.c | 40 +++++++++++++++++-----------------------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/streaming.c b/streaming.c
index 1fb4b7c1c0..5ce6350123 100644
--- a/streaming.c
+++ b/streaming.c
@@ -14,10 +14,6 @@
 #include "replace-object.h"
 #include "packfile.h"
 
-typedef int (*open_istream_fn)(struct odb_read_stream *,
-			       struct repository *,
-			       const struct object_id *,
-			       enum object_type *);
 typedef int (*close_istream_fn)(struct odb_read_stream *);
 typedef ssize_t (*read_istream_fn)(struct odb_read_stream *, char *, size_t);
 
@@ -34,7 +30,6 @@ struct filtered_istream {
 };
 
 struct odb_read_stream {
-	open_istream_fn open;
 	close_istream_fn close;
 	read_istream_fn read;
 
@@ -437,21 +432,25 @@ static int istream_source(struct odb_read_stream *st,
 
 	switch (oi.whence) {
 	case OI_LOOSE:
-		st->open = open_istream_loose;
+		if (open_istream_loose(st, r, oid, type) < 0)
+			break;
 		return 0;
 	case OI_PACKED:
-		if (!oi.u.packed.is_delta &&
-		    repo_settings_get_big_file_threshold(the_repository) < size) {
-			st->u.in_pack.pack = oi.u.packed.pack;
-			st->u.in_pack.pos = oi.u.packed.offset;
-			st->open = open_istream_pack_non_delta;
-			return 0;
-		}
-		/* fallthru */
-	default:
-		st->open = open_istream_incore;
+		if (oi.u.packed.is_delta ||
+		    repo_settings_get_big_file_threshold(the_repository) >= size)
+			break;
+
+		st->u.in_pack.pack = oi.u.packed.pack;
+		st->u.in_pack.pos = oi.u.packed.offset;
+		if (open_istream_pack_non_delta(st, r, oid, type) < 0)
+			break;
+
 		return 0;
+	default:
+		break;
 	}
+
+	return open_istream_incore(st, r, oid, type);
 }
 
 /****************************************************************
@@ -478,19 +477,14 @@ struct odb_read_stream *open_istream(struct repository *r,
 {
 	struct odb_read_stream *st = xmalloc(sizeof(*st));
 	const struct object_id *real = lookup_replace_object(r, oid);
-	int ret = istream_source(st, r, real, type);
+	int ret;
 
+	ret = istream_source(st, r, real, type);
 	if (ret) {
 		free(st);
 		return NULL;
 	}
 
-	if (st->open(st, r, real, type)) {
-		if (open_istream_incore(st, r, real, type)) {
-			free(st);
-			return NULL;
-		}
-	}
 	if (filter) {
 		/* Add "&& !is_null_stream_filter(filter)" for performance */
 		struct odb_read_stream *nst = attach_stream_filter(st, filter);

-- 
2.52.0.rc2.482.gaa765fefd0.dirty

