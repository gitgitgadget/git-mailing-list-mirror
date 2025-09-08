Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4049820C001
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 21:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757366484; cv=none; b=YQGMV+xfsXRxVTP+wpy+FZff+Ko1om5LiNydVp8NDbygN7Wg3Fg0qXYp1MX8EzPNH6t6yYPATsczWyhI4BU9jMPLWLC+7sRXWQpXdVNn0fzCJhqRqVQOxgSuF2dh9JhBVUo2NYTdb0XVETWfQH8Clflio1afVXVwOhrCqZFjffs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757366484; c=relaxed/simple;
	bh=7Qr0uY6IgsNrTt/kpq3XDdFtxZSjOJcJXveJwnk5R4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XefkIxxa5iEWCNdtYLfoQk8od8Qs+7kAu9DZcgWSmrkk08k4UBLPvvrC3x3Gfda4XXdmGZMcNuIKXXQwjxmH7j0cBTqRjpwJ5PSu+rtfMq7Pw9u1Rn8Oha7hI7wry05ZwKlJk5yVJd6xuFiAg935RgMlwWeUSSAyDG7NnW6vyzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=MtyMr75s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SsLFus3Q; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="MtyMr75s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SsLFus3Q"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 085E31D00124;
	Mon,  8 Sep 2025 17:21:21 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 08 Sep 2025 17:21:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1757366480; x=
	1757452880; bh=FIRcdYUjeWHF/lHbxKD2KJV2Eo2Z9EWJTdskjdLUb7M=; b=M
	tyMr75stO/wLyZjyAWUNrvWUslo2dlRqVXlKkKtLZm6GWpGs+6kX+69zRXR0SiRy
	y5Vod/gbeojt93JgqKcP4w8UZ0arwjw8PgWkqjCmoKOFqtiWdMcffzxmidDxdZ1O
	/MB5sRJUQuudYUV41ffxo7USRN/fxTJlcPi5dwoTdpSJn36OTVNIvOeE/oTfEScI
	z/cWaJU3yTX/mMumYbQLARD0HgEONHh6VpNmnvq6imGGnG3mjB9wq7LFoEl5LpQV
	xgOlAs9pnklH4DhGIZvD97/4Okl5onmW7OQzxZ9LpXrsfZtuiOFXNSilFEN67BJE
	aW4f/ekub6lMtmInp4Kag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1757366480; x=1757452880; bh=F
	IRcdYUjeWHF/lHbxKD2KJV2Eo2Z9EWJTdskjdLUb7M=; b=SsLFus3QQZ2cxzX72
	ZoyUn7pcKDENFsspNs4NVXvcHYk+Od5pZQQkV46tMd655yrK0AL9ieg737A7Ruxm
	cgSzDvBEwEaBiptipRPFZkd/vJi6cuZtAYv2EJCAeX4MwRgCjdYP1E3Y4XMG5wNH
	rin4jZBoSTaut4YmDIi48WFZOV3ZOj2OvsTFMjUVFTS4VGOncq3yOwasDWiRnDKL
	vQJPhzEyfk5bML/EKkpGUrjF91z6etw3WyflhAWlobZ1PXdIWDgDs+TJSvZJrZY5
	ZmjbZWpSm9Ll5FR5XCYB3MumPuuwiM2R3+1A3xX9uWacmFAb7DJhubNobwUgCVrL
	gS+3w==
X-ME-Sender: <xms:0Ei_aDYb2d4HYDr3AC6486Bq25WQXIHygQnbPr0akC6btD4E5pRK7F4>
    <xme:0Ei_aM8nlUgUw_hBXV06M2Y1UP_r3-4qU0lxiHZUPD1x9aa1zb-FvkSG1ChAG45LP
    hDsavx7W45EXHAnOg>
X-ME-Received: <xmr:0Ei_aCj7OfcyQAAjfQK8_W9UZhclnD13mNvHPi95CbMxqs-Hz4lQ4f6lAKjNA1accFJkHWS2Gzx0Iwi8dBnO43lcVyBfuM-dmkZi1s6pVNGdSxG5_qMHR5rmVg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeeitdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgr
    ihhlrdgtohhmnecuggftrfgrthhtvghrnhepfeehteekfedtieffvdejteeutefhuefgte
    fgtdevhefhveffuefftdehiedtfedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrsh
    htmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoheptghoug
    gvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:0Ei_aMcVd0F2WKPIh3dJmGxdFV-rqWISVU-ro-IW8yKNxAihDJRVew>
    <xmx:0Ei_aJpdT9EOvZP0TylCodgRbcb-daWf0Ek1i5Y7FvgArQ-CPMFGgQ>
    <xmx:0Ei_aBBKxsrCRxg0mQhwIBi_V6jjHmNN4aY7P2G1Brkb7k0hlMkGkg>
    <xmx:0Ei_aGbP5L7kybhc5TWKogn5mjG4-rbbP4Zs5ebVfxoUdcnYreUfJQ>
    <xmx:0Ei_aFEyi2_3rV4DtFLKwEsKq97vrTE36L_A9Dzs6K30e-M3xLB-sGfN>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 17:21:19 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	git@vger.kernel.org,
	peff@peff.net
Subject: [PATCH v2] doc: fast-import: replace literal block with paragraph
Date: Mon,  8 Sep 2025 23:20:54 +0200
Message-ID: <724b975078daf11e17f26472c0da5638a5d1ca86.1757366352.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.51.0.16.gcd94ab5bf81
In-Reply-To: <09aaad696895c18c6d4dda7d6a2f4b77f84f39ba.1757363213.git.code@khaugsbakk.name>
References: <09aaad696895c18c6d4dda7d6a2f4b77f84f39ba.1757363213.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

68061e34702 (fast-import: disallow "feature export-marks" by default,
2019-08-29) added the documentation for this option.  The second
paragraph is a literal block but it looks like it should just be
a regular paragraph.

Acked-by: Jeff King <peff@peff.net>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v1:
    
    > but it looks like it should just be a regular paragraph.
    
    ... unless this is some kind of callout-block style?

 Documentation/git-fast-import.adoc | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-fast-import.adoc b/Documentation/git-fast-import.adoc
index 3144ffcdb68..c3951f5f879 100644
--- a/Documentation/git-fast-import.adoc
+++ b/Documentation/git-fast-import.adoc
@@ -61,10 +61,10 @@ OPTIONS
 	currently impacts only the `export-marks`, `import-marks`, and
 	`import-marks-if-exists` feature commands.
 +
-	Only enable this option if you trust the program generating the
-	fast-import stream! This option is enabled automatically for
-	remote-helpers that use the `import` capability, as they are
-	already trusted to run their own code.
+Only enable this option if you trust the program generating the
+fast-import stream! This option is enabled automatically for
+remote-helpers that use the `import` capability, as they are
+already trusted to run their own code.
 
 Options for Frontends
 ~~~~~~~~~~~~~~~~~~~~~

Range-diff against v1:
1:  09aaad69689 ! 1:  724b975078d doc: fast-import: replace literal block with paragraph
    @@ Commit message
         paragraph is a literal block but it looks like it should just be
         a regular paragraph.
     
    +    Acked-by: Jeff King <peff@peff.net>
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
     
      ## Notes (series) ##
    +    v1:
    +
         > but it looks like it should just be a regular paragraph.
     
         ... unless this is some kind of callout-block style?

base-commit: 2462961280690837670d997bde64bd4ebf8ae66d
-- 
2.51.0.16.gcd94ab5bf81

