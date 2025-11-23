Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71774219A8E
	for <git@vger.kernel.org>; Sun, 23 Nov 2025 18:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763924396; cv=none; b=sMVQcnayFlBFUq1oA6GT0hKO6uKAXJJJeZNXDm2PYASd7FUzOdV+WZRZaK3sN0A6Xno+KuNLBgQSx2/xxyOqpwfsjo+oTaPl2TwVs8VvGyaWcKO1p9yyWL0qwJEndcvtvH75r4KABfVny7Aq87UbMxLQKSnXeneU3W+LHxHuTQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763924396; c=relaxed/simple;
	bh=Vhxp1gIsULyhoF2cbnIcN3CPoDhLbw+ufLiaUQYk/nU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lELWflf/Ntt80Efy3oXUrS6myKI/tDP8PifwpCwKMDLME08lATXubCidZGc92lJxLrElCNXZI0V4x0sgNX4QTdmwWJ/Ay7A9lZwcc5T2PJz5JOs80UseznqEmHxVwpajGsmg0WM4MNXosy5EQL3N3tHr9NafkhPKKUjaUWFQiZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lbBXMvpC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mvpkLKE/; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lbBXMvpC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mvpkLKE/"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A07D27A00A4;
	Sun, 23 Nov 2025 13:59:53 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Sun, 23 Nov 2025 13:59:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763924393;
	 x=1764010793; bh=L4TTwAikTDiDHRafvpbTbhZEqS/C1EXwS7ULCFMLfOY=; b=
	lbBXMvpC8U88th7eheEL39+XgHCt0h0a3AmB3t6/uHxdPDm2IYwE94VFa9mtnXg4
	fPSI/hMojcvUrNxXX8CnG0Ho4N0VNUhkN3AnqnyddZ1FSHNG4YQju33joW4nZsLE
	vWyqUM2WpgXbMXK5GqEcpMwpDJdtNhY07P4Df8nFgktvTG/nQU2pMPMeDXmPewxB
	qxSoRSFXcC2iJPsezZmZ149OlLU8Qsmqmdp42ufwA2VRh24+xLdzUnOnivvvwB7z
	mteGI5Pmt0mPg55lz3TJOKV3PcuV1n4an6+N+APxrRt2LM8LzOTlsluiug+YlCZp
	Ivyt6hnKF+aUQy/uwzyYDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763924393; x=
	1764010793; bh=L4TTwAikTDiDHRafvpbTbhZEqS/C1EXwS7ULCFMLfOY=; b=m
	vpkLKE/7SejOsR8v3RGL2vlv90h35nbOafftjc+Fy/BX46dC7g8HsdNdggV+xcu8
	LSF+FiZdw3PBeaklViSuRwtGEPeX4zS9+yc/S/jw2lcAJMqtXp6MrTkUPm1fvz5A
	kuPt/JmCJh++JUzfIi7MWm2/1u2/oSL1/RTv7p174VEFr7aZubJB+FTqO/iBiHvN
	NlvadzmJqMlx6aVNI3k4UCDlGPBKgfTGxP3bv4isMTexFygN/5LMhQjgJsKR2alm
	WbJsfl69HLxPaB5/hz6bcO9zJdOUsLrlP2b1+e0Ny9w2ZOQp1H9iBhU1YmTcFQhR
	o4NstymC0GmbOLkZfuBhA==
X-ME-Sender: <xms:qVkjaY9mJKKypkn9sQ3HZnvBz_O9nEmi-eSlhM9JXgFdZAE61C34Ow>
    <xme:qVkjaXvlpq5r6YLnFBcQti01uCvamvaq47EfjwIYrJzZ2RF2CwCff0esRmlLR6DRM
    PmHEZdzphSxhyJutKX7WGrX_ESFZFGx30vcWPo5Prf3s1I6_76eXQ>
X-ME-Received: <xmr:qVkjaTBFivRfLYTXc77R_E_TtYdYt_bQau1zNX9KlLcCSADSXlfdc9RPXsUti97rT_EAHTQgKIe6eWwSp2m-Z8caZm_Y4rKkuImXc4wLvXxtEw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeeihedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeekieevveegieevieeuveefheffgeeuheetheegffffkeeijedtueefleffvdevleen
    ucffohhmrghinhepphgrtghkvggurdhishenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeg
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlth
    hosghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:qVkjaXWjaJqShnQuAE1Iy7SxWoD0Y_f-16uu-QUM6jzgtVSSkIhRgw>
    <xmx:qVkjaZDshZSVpuMT_lLEB67qc3Y4pFtkmB43wST3LKuMPa9pFxknTQ>
    <xmx:qVkjaS9n5dKKS39_3D2TLDl_MnqR9lvyU3Mf4ZypbUN3CaHTyqRA2A>
    <xmx:qVkjaYE8oE8R1YlzyxZ7hnJ-Q6rFUmfUr2gf1Squ1euDjmWkNI224A>
    <xmx:qVkjaWjHlaUzk4dG0YIA5uLead7iCdUydvk7aDZMB2swgmMuWnmjwp65>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Nov 2025 13:59:52 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 83b6637a (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Sun, 23 Nov 2025 18:59:51 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Sun, 23 Nov 2025 19:59:27 +0100
Subject: [PATCH v3 02/19] streaming: drop the `open()` callback function
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251123-b4-pks-odb-read-stream-v3-2-1a129182822b@pks.im>
References: <20251123-b4-pks-odb-read-stream-v3-0-1a129182822b@pks.im>
In-Reply-To: <20251123-b4-pks-odb-read-stream-v3-0-1a129182822b@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.3

When creating a read stream we first populate the structure with the
open callback function and then subsequently call the function. This
layout is somewhat weird though:

  - The structure needs to be allocated and partially populated with the
    open function before we can properly initialize it.

  - We only ever call the `open()` callback function right after having
    populated the `struct odb_read_stream::open` member, and it's never
    called thereafter again. So it is somewhat pointless to store the
    callback in the first place.

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
 streaming.c | 37 +++++++++++++++----------------------
 1 file changed, 15 insertions(+), 22 deletions(-)

diff --git a/streaming.c b/streaming.c
index 1fb4b7c1c0..1bb3f393b8 100644
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
@@ -485,12 +484,6 @@ struct odb_read_stream *open_istream(struct repository *r,
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

