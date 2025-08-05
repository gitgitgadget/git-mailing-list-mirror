Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5B9279DB7
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 15:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754406723; cv=none; b=tudfZ12pkm9TsIHbR/rbxjkk/Egb3LJ02W9pYeG5cX7+E3wQPY+LDgswJfUFt19rpVDSfGOvtmmtrJMCOt2NoZRqhCAEwsnHeiSGyRpc5x3014+GUFpPiX3/dBOZdZNbnvqUvRCama0ECGrOEcoNVgnBQS1W2kqkd7wHcA6JjHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754406723; c=relaxed/simple;
	bh=grEefLWm9vU8FLAsloFb1U19QZ5yXCfXuqEys0c092U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=phk68Pk3p7/WXjDIt/b9YW3M26B6CPY9hph1E5tInq4Nee2GGt0f+hHY0+oxCS1XjUAllN+EM7UFz5TVzlbn0L6xwXFL18eH1vqMVIiYUjQXycTaph0RUNpilT8LmP1sa/pD+F6tUi/WhD5ASzIL4TE5zcSaKW3iv8hPe3wVDtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AcXYbhG1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XkTeUOvP; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AcXYbhG1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XkTeUOvP"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 7BD2EEC0182;
	Tue,  5 Aug 2025 11:12:00 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 05 Aug 2025 11:12:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754406720;
	 x=1754493120; bh=o8nXnv2sro6Vc/d/r48jC5nxdEFoqcQDKweKTCdaDGs=; b=
	AcXYbhG1co8xR9Q1Jf1vJ9yei3Trpu6LM8D26V+vGAI/zRYDP3Qwpv64f4bj2nzQ
	dNDejg1VyZphFj760+/33I1y7d4KuWkjV9MKYyr+N5qT9TXMqah9wPgDxaRdaEMm
	LDsxV7bDAX6FMSpx3emwrBTst7ZfVtsimox6Zy8d9inoQkY5+omV1oGKYBfyze2B
	JllxCO04EhOk3s3mqi9vLSUip/n9zKgtSERAPrSDnHtDlwvbkrGdS5MxNbnWLSlu
	XiNcbJXDit3muhtie8oui+0WzH0+sOIbIGvpAsyANYy4EED+l+QtIV9U4/SLt9tG
	0RyET1zq+74fWHXcmWOUCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754406720; x=
	1754493120; bh=o8nXnv2sro6Vc/d/r48jC5nxdEFoqcQDKweKTCdaDGs=; b=X
	kTeUOvPMOk30hqgHFt/W37kkJBZrA8tx3eMtPGtqp5mB83Hg154QTaD7Cj6uAgKR
	kVDpA7aNew7eP+Daac0gqvkQ3+lV8e+YlFZDhAA5Q6B1knWKwQ5aHm6JwA0vHjLt
	2iZAAauYVLTgs4fAEW1fnQ10IbdmrJYBZcprRbUfMMyuPk3llhSiuMtpZ0qLSQ+K
	2ZFKAygvZy5Gv75nSdMnQg1g9dfCg5Z1FrI22R+SFkCuDbLjcJW+9vvMf0qcoVc3
	+WuXwoIoqrPUTanjt0Yo0Q9AJicXt4SSZwN/AejRViE+qy08Cd4miQ7BmN8PrFG/
	42XoamFTeMNXmCJqcrjXQ==
X-ME-Sender: <xms:QB-SaD3cmoq2FFQ3shNabYWfjrQ2V5WdxuA9Un9At8QFxOVIhf2k7g>
    <xme:QB-SaO9oKJv0yz5TO5tj47gxjNLX24aAs1qYLK6PUNyR0pX0n8r0OXJHc4w_jw6Pm
    9xI-AzYHdFRGSMPqQ>
X-ME-Received: <xmr:QB-SaDodXGoG0QyBX99OAb3mcgGzoUPekYJZIOKyoo_VUYKtz4jX5_4JI6ICc50QtFEeAC_jTE_bA8_tcleLbnZJ5S-OoSAQ7h6vju_GUA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudehhedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhm
    pdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphht
    thhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepkhgrrhhthhhikhdrudekke
    esghhmrghilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdr
    tghomhdprhgtphhtthhopehsiigvuggvrhdruggvvhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:QB-SaIS9csp-WZddXZvfHGUtejqslEEoZxLJGLHdwgsYYH7aap0BUA>
    <xmx:QB-SaGP_cIhn4sTGQAHlh0uVP1NNDLifXoMXQ2x25nwtC5uBP17MGw>
    <xmx:QB-SaGir2q9KE2IpVXXf9qP3tI_fLBNFdVatsUp6lQJxgQPLd-jcCQ>
    <xmx:QB-SaDlSxgHvh2otAGbrXkhX0d45LTyZDYkGpxZjtdmhTknTj64fMw>
    <xmx:QB-SaBYWCCFkGodBiuD8cKAE1Ix3orCC5w5WHOuRBSkRQG1mZVea7VpU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Aug 2025 11:11:58 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8a18707b (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 5 Aug 2025 15:11:58 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 05 Aug 2025 17:11:35 +0200
Subject: [PATCH v5 5/9] ident: fix type of string length parameter
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250805-pks-reflog-append-v5-5-050997db09d5@pks.im>
References: <20250805-pks-reflog-append-v5-0-050997db09d5@pks.im>
In-Reply-To: <20250805-pks-reflog-append-v5-0-050997db09d5@pks.im>
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

