Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AEF2D7DD5
	for <git@vger.kernel.org>; Mon,  8 Dec 2025 08:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765181084; cv=none; b=uA/J5JHAmhyGKrp1Tsh3qdOcgmMR01fRe13x/vU188iYqY+5duK3yjTGCUo8yZIraiuqfSTcTsY2y/cxY5c5tlx3uQ3uqZC6Aa5sc37nipykGfKesv6GPflw08ZGeKJbMEgaL9XKAJLEAAbfZMpsKiVqjG7Zt+GCrV6yvnUkssk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765181084; c=relaxed/simple;
	bh=9PCV+lCNjJJmLpstrwD34+QEUnqEzTOBgMonUHxZ4bw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kBHLQwmXvtu5BEq+Sa5Qp60dxDkihGr79ybt7Iig+F9r69PgvcxpL2YU64O2dKyiEIDeWVtRc2Mx7u8tNq17NY/kJRBNbLqjduD2OuegiGeTKnAQuoy2aX5/TqNJxQEr3/FRsnSQiPLlRr6tiJM7sHXGnhdFtqWs2FCvYOYqSko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iRMymRr8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PF72Y1LM; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iRMymRr8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PF72Y1LM"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D99B27A01EE
	for <git@vger.kernel.org>; Mon,  8 Dec 2025 03:04:41 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 08 Dec 2025 03:04:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1765181081;
	 x=1765267481; bh=2iSYrhfZLu1OOgDpctRtVE982otJj2Se4y7/w0Hm78o=; b=
	iRMymRr83G0YSANAP1UFB1PG6KljeBhIASPMS7lUFFaJ+4D+cWP8RJR5BkyU5xzh
	qBeWVLZFLQ9agrL24q0r3NdFBd44jFwWe6JsURJZsTWxdoGRfk1h4RHVPMZuClgC
	G1O00NCQwEA6Tjf/4VfcNXqNIZFg3dGcMgYKDoDPe0AAiZ3N711eg8fxM1PBee4U
	5QdOCt7M28KgMnRTt0LdzQlqbMqAI247wIMEhwnlyPPPRmy6j65OP5XoTe2qwLgn
	RunRHIgsopvj4xceGx/bfBrK9MB1WN29M90EEAQ8pa1yXW3lehO3mca/sVbCP71E
	pZhiLOjjemgKUweBIlIY1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765181081; x=
	1765267481; bh=2iSYrhfZLu1OOgDpctRtVE982otJj2Se4y7/w0Hm78o=; b=P
	F72Y1LMlLSNsjaffWAHmZ7poi5KBLqEQap4zirrCAm6kHbEyWLGi3PTsvQmhkAbG
	cj8aAeXUYs324sPnfVKcwDQlUDIBEhos3Gun6ofyTbPuI1Myj9uYpg31BUH9SIXP
	4C6ihXwQiS6+2xyITm6mO5X2/hXmBND1CbPyDkLVo3Q64Hh56ETCVXuddkTz5R+n
	KwPlxh29Sg3BwbkM3+CD3He19P4N5PwobrKhSdn+0ktk1Mjye1FMJJA6MmsKpynz
	ypN2A/9FVUVlH5nCvOYTkbhBKPHP0ysqDsveNwgT9kOHx2VQPsZ5CYDIk+OvebXu
	rwd/k1nJaVD3FXiyCnEtQ==
X-ME-Sender: <xms:mYY2adGvu1mJBWbjZ4JgbcUV6S_sLjJczRcmfv5W5qziIbrwjtiyyQ>
    <xme:mYY2aZS2K86idcdK9n8Gx2m_8NRkX8Sz0UHZblW7nPhkWCu9vZqWcBE9-1kl4Htca
    jO_-ohu2Bv5oui6L8-e7Wdd_FGa7MUbgeRWzCEiFYiDciCnXFJJ>
X-ME-Received: <xmr:mYY2aUwgODMe87UFfOlHButmsevl_2U9E-FnflTkQ-m9WiSC708iSrtTtWrNJu-A0AUWYrBEH3b79FOpEZNxg8-ciUR7SDO5sN73BSrlWMw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:mYY2aYOJb1Lk65AYokr3DQO-S7ZHH2ujlKVgfzvwtCUIzI7XPYm13A>
    <xmx:mYY2aTM08k4A5ycBR5vPCDaOaA88-qxI-zVqbmeUiDAi3YG7fbGeIA>
    <xmx:mYY2aaT4tFJ0cpZgu6Fu1dSjtYredcFohsOpXbC-jQ1uCyepXCFM0Q>
    <xmx:mYY2aVA_oEw3ydDRNViHH6Qx1eKjyM0ei592Z06Jrrpbnsfg6e-vtQ>
    <xmx:mYY2abU_tZ6weHqXjWTi1kWgR-6sABjviJ0FDX8sMHO0tj-4iAwYzZM4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 8 Dec 2025 03:04:41 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c55fb4f1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 8 Dec 2025 08:04:40 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 08 Dec 2025 09:04:20 +0100
Subject: [PATCH 3/8] odb: move computation of normalized objdir into
 `alt_odb_usable()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251208-b4-pks-odb-alternates-via-source-v1-3-e7ebb8b18c03@pks.im>
References: <20251208-b4-pks-odb-alternates-via-source-v1-0-e7ebb8b18c03@pks.im>
In-Reply-To: <20251208-b4-pks-odb-alternates-via-source-v1-0-e7ebb8b18c03@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

The function `alt_odb_usable()` receives as input the object database,
the path it's supposed to determine usability for as well as the
normalized path of the main object directory of the repository. The last
part is derived by the function's caller from the object database. As we
already pass the object database to `alt_odb_usable()` it is redundant
information.

Drop the extra parameter and compute the normalized object directory in
the function itself.

While at it, rename the function to `odb_is_source_usable()` to align it
with modern terminology.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/odb.c b/odb.c
index 3ffeece567..2513457a31 100644
--- a/odb.c
+++ b/odb.c
@@ -89,17 +89,20 @@ int odb_mkstemp(struct object_database *odb,
 /*
  * Return non-zero iff the path is usable as an alternate object database.
  */
-static int alt_odb_usable(struct object_database *o, const char *path,
-			  const char *normalized_objdir)
+static bool odb_is_source_usable(struct object_database *o, const char *path)
 {
 	int r;
+	struct strbuf normalized_objdir = STRBUF_INIT;
+	bool usable = false;
+
+	strbuf_realpath(&normalized_objdir, o->sources->path, 1);
 
 	/* Detect cases where alternate disappeared */
 	if (!is_directory(path)) {
 		error(_("object directory %s does not exist; "
 			"check .git/objects/info/alternates"),
 		      path);
-		return 0;
+		goto out;
 	}
 
 	/*
@@ -116,13 +119,17 @@ static int alt_odb_usable(struct object_database *o, const char *path,
 		kh_value(o->source_by_path, p) = o->sources;
 	}
 
-	if (fspatheq(path, normalized_objdir))
-		return 0;
+	if (fspatheq(path, normalized_objdir.buf))
+		goto out;
 
 	if (kh_get_odb_path_map(o->source_by_path, path) < kh_end(o->source_by_path))
-		return 0;
+		goto out;
+
+	usable = true;
 
-	return 1;
+out:
+	strbuf_release(&normalized_objdir);
+	return usable;
 }
 
 /*
@@ -164,13 +171,10 @@ static struct odb_source *odb_add_source(struct object_database *odb,
 					 int depth)
 {
 	struct odb_source *alternate = NULL;
-	struct strbuf tmp = STRBUF_INIT;
 	khiter_t pos;
 	int ret;
 
-	strbuf_realpath(&tmp, odb->sources->path, 1);
-
-	if (!alt_odb_usable(odb, source, tmp.buf))
+	if (!odb_is_source_usable(odb, source))
 		goto error;
 
 	alternate = odb_source_new(odb, source, false);
@@ -188,7 +192,6 @@ static struct odb_source *odb_add_source(struct object_database *odb,
 	read_info_alternates(odb, alternate->path, depth + 1);
 
  error:
-	strbuf_release(&tmp);
 	return alternate;
 }
 

-- 
2.52.0.270.g3f4935d65f.dirty

