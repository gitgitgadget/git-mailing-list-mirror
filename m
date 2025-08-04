Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B64247DEA
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 09:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754300789; cv=none; b=Ltl1Acl2u7cbMGdc+JA8vf+fbjKKydARBl3CuT1q5d8mYQkIAstoOVRtn2Lvpmpdtf9Ik+9bJu8SVjKABXSiZjRHhJdv7dz8vKqi0q5UZKEuzwJ0EoDVEj+3ZIEnE1Lu8ywYYFi4rWOURBDEehbJZKclxdvCQNQlT+WZi3S7Zx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754300789; c=relaxed/simple;
	bh=grEefLWm9vU8FLAsloFb1U19QZ5yXCfXuqEys0c092U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TeTNDOzAKjLPo58avUm3qdoxlvakDBlHEfDvqVFgGfM1RZoj9U7tFjUoFgI4EOJcPE3dak4oYX7QgkNOOa65R9/luVlCKuqlUyPt/oOiD1X8K+/mg27UPyW8n0a8UPH9vh8Mn0hP6S7frPtEAbfnJ3CBRxaD3YY3fWvwSG/5mBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GoM1nqn7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UMGb6SwD; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GoM1nqn7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UMGb6SwD"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 111367A00CB;
	Mon,  4 Aug 2025 05:46:27 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 04 Aug 2025 05:46:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754300786;
	 x=1754387186; bh=o8nXnv2sro6Vc/d/r48jC5nxdEFoqcQDKweKTCdaDGs=; b=
	GoM1nqn7BHjTBHDUTmUAmYdDTUswuXMhP+i/Rk+8aguNTRlk1ux86H9ShVguVQ3i
	78zZuHkGsWNwc9ocQoEWPHR4x++Syi2Z/glRHjlK9hHKJJAn93tggqPvCB1I7ZTm
	Qxl3zZ5TgV8tq6b6ou60gbYCc33+U+H7XZ5y4uPJvYbB1RSp8CdYjaeqjiW3p7ft
	8MS+eu5/B4hBYGPyKgAXSGBmLTlfP9E7nmEqQ2rEEUjDSvpV2KSebxbkDWf1pRnW
	+CbX5MP0DyE4CDNm0+HhGLklcdD4ubfCFzhJdBoa2wAP6+wbzItvGjMNbyanf1bb
	sK5jPl6v8Aa1PRfrTyzGkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754300786; x=
	1754387186; bh=o8nXnv2sro6Vc/d/r48jC5nxdEFoqcQDKweKTCdaDGs=; b=U
	MGb6SwD1kkFT82z0uUBSK/ZZ4BfMay9ut7RZl/750otfm358QBNCMqHM29rC1vbk
	yv/rasaknuYVT6QKLx+F148NGWhgupHfPwRhghKHu8YHs5MwBvC51wTlLOUfbd1B
	pD4g7zfl+enF9Obtm7V1ILi65xuU6t1D+FY5FEi7lzGrlOhc7V6l9tq6xatVz8y4
	uAZqFXFr1rN3ssn4iEdWkl03u6IKL5lKTih2LfC8u3S84fvFsFp9VSd42637PBYW
	WbilanFaXxkVF6xpnOb+mtr9uREF8Qff5Xy+mbvwf4XPYw9oIVnmtSMQE1XT75lK
	VgpxDfFaVrlevG3S9S6/A==
X-ME-Sender: <xms:coGQaCSdd441gOer-3onkKNHUMsINkmRRwBhqYhhHCS41AVDkKozhA>
    <xme:coGQaEoVaryijZhkBoWlORXdbQSpGbKdepg0RMyzv16WmWlpoPmPPHP3WMAljjoHL
    ziYDO-svr2Ts9fCVg>
X-ME-Received: <xmr:coGQaPlBEGLYazyL9UEu-Yur2B2U_A4y6LDLBNeWFQL7PkKJptBcQ5Ba3v7TCWshRg97xA5mw2_RAKFZn5sv371e6G58C1FfeHRQ9h80OPc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudduleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhes
    fhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprh
    gtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehsiigv
    uggvrhdruggvvhesghhmrghilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvg
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:coGQaNf8PZ0mwoFrNzHKq4X-KFn5V9vxKEgwJ4iciQVJcJFIKDGt4A>
    <xmx:coGQaLqHYz4z_tWRSSElti8qiPyUItQyZzxl_6jUq51zCwSTFyqEWg>
    <xmx:coGQaHPi0DAXG4ttArH8Z_8ubTGpuYfsqwvEeljt1moAHj3gHXxivA>
    <xmx:coGQaOijM2h1g61tOcGOCEEe3KoP2T575_3r3usooQsC9E-JgDjk-g>
    <xmx:coGQaEkNAspqVdkETRN-bth_Eo_2jfA8g4C64NCDN74IjmEJUdX1ijQY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Aug 2025 05:46:25 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3edafc3e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 4 Aug 2025 09:46:25 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 04 Aug 2025 11:46:05 +0200
Subject: [PATCH v4 5/9] ident: fix type of string length parameter
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-pks-reflog-append-v4-5-13213fef7200@pks.im>
References: <20250804-pks-reflog-append-v4-0-13213fef7200@pks.im>
In-Reply-To: <20250804-pks-reflog-append-v4-0-13213fef7200@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Toon Claes <toon@iotcl.com>, Jeff King <peff@peff.net>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Ben Knoble <ben.knoble@gmail.com>
X-Mailer: b4 0.14.2

The last parameter in `split_ident_line()` is the length of the line
passed in by the caller. As such, most callers pass in either the result
of `strlen()`, `struct strbuf::len` or a pointer diff, all of which
are expected to be positive numbers. Regardless of that, the function
accepts a signed integer, which is somewhat confusing.

Fix the function signature to instead accept a `size_t`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ident.c | 2 +-
 ident.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/ident.c b/ident.c
index 967895d8850..a7a2d132579 100644
--- a/ident.c
+++ b/ident.c
@@ -272,7 +272,7 @@ static void strbuf_addstr_without_crud(struct strbuf *sb, const char *src)
  * can still be NULL if the input line only has the name/email part
  * (e.g. reading from a reflog entry).
  */
-int split_ident_line(struct ident_split *split, const char *line, int len)
+int split_ident_line(struct ident_split *split, const char *line, size_t len)
 {
 	const char *cp;
 	size_t span;
diff --git a/ident.h b/ident.h
index 6a79febba15..3c034038791 100644
--- a/ident.h
+++ b/ident.h
@@ -35,7 +35,7 @@ void reset_ident_date(void);
  * Signals an success with 0, but time part of the result may be NULL
  * if the input lacks timestamp and zone
  */
-int split_ident_line(struct ident_split *, const char *, int);
+int split_ident_line(struct ident_split *, const char *, size_t);
 
 /*
  * Given a commit or tag object buffer and the commit or tag headers, replaces

-- 
2.50.1.723.g3e08bea96f.dirty

