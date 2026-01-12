Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4183D3128A0
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 09:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768208466; cv=none; b=d0q9dPETEYkFP6zLibRtkP/evBTWLXN9hY/0oXHL2Eu98u443b3WB0zfkX6EKCgUDypBp2goQMy9D0S7FYr2mFTh3B0kmDurfgtf9/RHeSFyw+xS4BUO0hLs7iTs40klXNyIRo5Z07CtMi58u3fFch07hRW3lCEytjRiQ7z05cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768208466; c=relaxed/simple;
	bh=/ivDOm8XLZG6/bfJ97LYR/G0f/eq6PvnD+CEb6BT5EU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W8EWj4mGDpuxUEEz5CitNWT/qRWYOVksz5DNbkWI8nDuLxWHgk48YmqSKo1pGtdYhv5BN8oiWfxmQHm1hwdk8BeF/GF7qmxXGkM4AnK8RWh/z2kIuQB1VX+Gh+nnXW5T1wSW/nTHMVv7/NqxlcuTJ/B7XevsxQMrf1QZ1vcQWPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hfttEb2N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IPfVZkNT; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hfttEb2N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IPfVZkNT"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 71E527A0090;
	Mon, 12 Jan 2026 04:01:04 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 12 Jan 2026 04:01:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768208464;
	 x=1768294864; bh=ml6ByHQV1QGbCJlKUKdj3agf8RkviqAVgV5ZGtIEacM=; b=
	hfttEb2NXqP6UE37Mnh2Xs+NS0ZpG1YRX9wMg8RsmB0WW4adoA+jJriVfgBVgVPr
	EYqJz+ujE3yyNrJS09aZIQD90uDXFwjChEk5p88URINv9LZrVo4KVoIWQivFHQt8
	YMcsrClbjWejqzo/vzsb30c8Zt7877+WWgVdr9rJsclPO96zkOoS3Dl1j7XwJlOi
	xxjHxrPKu7qU0Aa1aFZSBte78idqBwkNBe3bsQt+sxpR9eGJrlQlnWHOkBbGDbHq
	aYeXfkduWaBfrdrTpihTxtVwBJCoIH+LaNyROyjxCV/a1Pz1kpjQas/nNFai16K5
	3ZAa4h6FcaCgVwHP53jqJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768208464; x=
	1768294864; bh=ml6ByHQV1QGbCJlKUKdj3agf8RkviqAVgV5ZGtIEacM=; b=I
	PfVZkNTStfsMcamn1khVQlbBH1rspMVfvfrYSzM0cXtLUF94Bpg4WN79KU5vvgEB
	ENgczreAK6/H5p70WaU7yXhzIX7KMQ5vo+dx6eGLq4mpOfo/1irShaIpr9bzL4SN
	f7vI3lhvqFU7atkASw2wclQP98uidjP1yooIF6aKeSG25MKISJJXj4zxLrY9KolC
	GL2yeohvmmxleJ6hI/mQ1V0SBeaMEL2bbC8RiAqHxuu7x7XV6fkDncULgxhh7F77
	TW29qAxizSov21HSJ9tLM/CEC/QJFg7xFxq2bid69bmvrx8wfWLYEsZ3MhCzgJv6
	L7dQ4T47me0kou8WO4jNA==
X-ME-Sender: <xms:ULhkaX2kdgWeHi843Wg3TlEFY-FuVAlqyrahzFCK40ud8O57T-ESxg>
    <xme:ULhkaZyY-evt3S7nRT7kYuv7Xm7IWbmByckPS0Vkf6G08ymw62NTivXyCNmH_1DPY
    4VvwIJSeRGtqhNc-f2oQGBf8TXIg1kl_uZ9HNw82GPATJzw6SjboQ>
X-ME-Received: <xmr:ULhkaRt99fhwLLWJaoDeMDiqERbxN7-iu95bTSsyAIDuCTRZMiO0FE7GP014outmLbUJ-95uWj4IStrX8Ko5dJD_VJixVHRtlgcCKp_Kaw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudejtdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeekieevveegieevieeuveefheffgeeuheetheegffffkeeijedtueefleffvdevleen
    ucffohhmrghinhepphgrtghkvggurdhishenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeei
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrphhlrghtthhnvghrsehnvhhiug
    hirgdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehf
    rghsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgt
    phhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ULhkaTz2vTGHqTevQrWahn6sZCOv8MUhkUB3-zzMAODtNIrjiVs9sQ>
    <xmx:ULhkacCO4UbDJ_JUSkJ4LGm4m581kjmAUTq733Otu5iccCpLpMb3CQ>
    <xmx:ULhkaZdmenwenIjMqA3-Fna84UDpHT3SwLNu-oSQ1bth2NjvITnkuw>
    <xmx:ULhkaenOhYv4PO1m0MjKrjhq--HD02GKOiyP-0s8fn10yE25C4p6Qw>
    <xmx:ULhkaS3YJ59c0FzfTAUGZVaio70qhMcUe07WWwEZJ5jsLLJ0fBGEG99k>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jan 2026 04:01:03 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e2c68cac (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 12 Jan 2026 09:01:02 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 12 Jan 2026 10:00:43 +0100
Subject: [PATCH v5 3/7] packfile: extend `is_delta` field to allow for
 "unknown" state
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-b4-pks-odb-read-object-info-improvements-v5-3-9a6124e95bf2@pks.im>
References: <20260112-b4-pks-odb-read-object-info-improvements-v5-0-9a6124e95bf2@pks.im>
In-Reply-To: <20260112-b4-pks-odb-read-object-info-improvements-v5-0-9a6124e95bf2@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Aaron Plattner <aplattner@nvidia.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Toon Claes <toon@iotcl.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

The `struct object_info::u::packed::is_delta` field determines whether
or not a specific object is stored as a delta. It only stores whether or
not the object is stored as delta, so it is treated as a boolean value.

This boolean is insufficient though: when reading a packed object via
`packfile_store_read_object_info()` we know to skip parsing the actual
object when the user didn't request any object-specific data. In that
case we won't read the object itself, but will only look up its position
in the packfile. Consequently, we do not know whether it is a delta or
not.

This isn't really an issue right now, as the check for an empty request
is broken. But a subsequent commit will fix it, and once we do we will
have the need to also represent an "unknown" delta state.

Prepare for this change by introducing a new enum that encodes the
object type. We don't use the "unknown" state just yet, but will start
to do so in a subsequent commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.h      |  7 ++++++-
 packfile.c | 17 ++++++++++++++---
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/odb.h b/odb.h
index 73b0b87ad5..afae5e5c01 100644
--- a/odb.h
+++ b/odb.h
@@ -343,7 +343,12 @@ struct object_info {
 		struct {
 			struct packed_git *pack;
 			off_t offset;
-			unsigned int is_delta;
+			enum packed_object_type {
+				PACKED_OBJECT_TYPE_UNKNOWN,
+				PACKED_OBJECT_TYPE_FULL,
+				PACKED_OBJECT_TYPE_OFS_DELTA,
+				PACKED_OBJECT_TYPE_REF_DELTA,
+			} type;
 		} packed;
 	} u;
 };
diff --git a/packfile.c b/packfile.c
index b0c6665c87..cc797b2b6a 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2159,8 +2159,18 @@ int packfile_store_read_object_info(struct packfile_store *store,
 	if (oi->whence == OI_PACKED) {
 		oi->u.packed.offset = e.offset;
 		oi->u.packed.pack = e.p;
-		oi->u.packed.is_delta = (rtype == OBJ_REF_DELTA ||
-					 rtype == OBJ_OFS_DELTA);
+
+		switch (rtype) {
+		case OBJ_REF_DELTA:
+			oi->u.packed.type = PACKED_OBJECT_TYPE_REF_DELTA;
+			break;
+		case OBJ_OFS_DELTA:
+			oi->u.packed.type = PACKED_OBJECT_TYPE_OFS_DELTA;
+			break;
+		default:
+			oi->u.packed.type = PACKED_OBJECT_TYPE_FULL;
+			break;
+		}
 	}
 
 	return 0;
@@ -2531,7 +2541,8 @@ int packfile_store_read_object_stream(struct odb_read_stream **out,
 	oi.sizep = &size;
 
 	if (packfile_store_read_object_info(store, oid, &oi, 0) ||
-	    oi.u.packed.is_delta ||
+	    oi.u.packed.type == PACKED_OBJECT_TYPE_REF_DELTA ||
+	    oi.u.packed.type == PACKED_OBJECT_TYPE_OFS_DELTA ||
 	    repo_settings_get_big_file_threshold(store->odb->repo) >= size)
 		return -1;
 

-- 
2.52.0.590.g1f87b77810.dirty

