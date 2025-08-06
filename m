Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822192066CF
	for <git@vger.kernel.org>; Wed,  6 Aug 2025 05:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754459682; cv=none; b=qWeLV8rySgJ4hO+rb0O0b8mBJcssdbIG4ISJ6LemSBbf0ZWB1LWJQQt6gJAA4r9Wp/JydaBGw3ltzQEwFxslR+l9Vg2+VSaCob2diE58IdsofPVKjRPByESCUFcynYW3oOkl582j5+n6blF6twsMMZ8iBzc3HE+Eg8NfO8840bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754459682; c=relaxed/simple;
	bh=Mkzv4v63wJXiiTBqSekwc9OhIBQPMBmI8dsyDTbc+yo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WKI3NbPPcobZKvq/72l5UccjTwGbZoLwnOf/vpwnhvp+ihIYLMx8Jm575ZEWe+vSYCeoCuO86z4SbTTm2AogeKJkctJTX2NCKNJy0ZppwjxF1vnPBvwJPODSfgiIkSAYMhpNLedYs444JcsQtdp6MQ3tlwD25XsL1h2yX6w771s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BaLel5fD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V7yAofHD; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BaLel5fD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V7yAofHD"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 638247A015C;
	Wed,  6 Aug 2025 01:54:39 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 06 Aug 2025 01:54:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754459679;
	 x=1754546079; bh=wPRl9cNaDCUZLod+8FA0ikv7dj3goIz9eCnh2cJDV7U=; b=
	BaLel5fDlNsNKHF7HmfmSCkD6rGyuUMEgG+4NBGpBjVeyApju2ROt0YrqXAwNu3X
	3uT6d+XeOwmlF0g7U6O9hFLLnHyNSaJqXkw9N3Oh6ipXvrtXRzG2oRbDJ2dt4Mdc
	a9Fc/vEy7Y/IXG27wpGshAopDF/6TZJDj6MjN20Y8o4nDE0LgxXZI/mntfLYvhrO
	+DvBFHylQX7ECv0BcjrPBqWUm1ks1NtGXOtj0GZd2rblFuwE4BKhoc8c6D4XmOTs
	dblkygB0no5ypIA1wVjBOlr33+uqib2HC2x548oZHUC6NZdzDLylwxMTBFwRwX2L
	eNCKjgyZX+JDPkRLrjWV6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754459679; x=
	1754546079; bh=wPRl9cNaDCUZLod+8FA0ikv7dj3goIz9eCnh2cJDV7U=; b=V
	7yAofHDj5GT4Xh6x4DvwlTrwwa6XerglOkETmIyeXX59lJgcxNtSvVzbIX1Xiqq3
	rFRYLr0LgJ/T/jw3Wvl9YI7++9l0N+Z0tWC1Upjo3bGRA/uBYIVlM8xD9Sy95msn
	Hl7uKGR4jXk6M2eLPh3VFPZEf5gQW2SpbHy2fegAgtZUyR/uqO4WKd0kK/kAy6N1
	Z2SFU0z3swL/DFbLAgIZJVFSXZAe/IfRrdM0cQ8Qh67jKelffIo8/3d00sBF4HTW
	Xuw9OblYbPrzYweH+4NWfOa3Xcl2AJxWyWfbhKzJzDh9ZtEeLguBYk6q1j0HfjYn
	emMlQAlELgNqLUfLLapZQ==
X-ME-Sender: <xms:H-6SaCgiURE5oh3sRulSIM_bYe2ftmo9prHNVptDAFC7Dl6-ZesD1g>
    <xme:H-6SaOuzweQIwNOPWrfdxY5i4fvFNvRj6ZPGSv5hbD8O67gup4kQmn5RCtEuLOIzV
    8LZ6xp4sagspHX97w>
X-ME-Received: <xmr:H-6SaGi-N0X__WoA2xFvmtK5SDyIgBBaiYVued_JK33wIZ90wMizZYkne5pouYscC6cU8s2Jf5a4_Amg0-ETcwX1h1uU0AmLOC83XtvzYg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudejvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtoh
    gslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehsiigvuggvrhdr
    uggvvhesghhmrghilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrg
    hilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohep
    khhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:H-6SaEZay6E6iSfZ99SHKZYvjSGhRF4FaQ3HcuLhWdPyKWbNoFH6HQ>
    <xmx:H-6SaFbLOlxOIl61S7diAFcpeYlKbXeqH4j_EttUBJj1_j4fLuPD4Q>
    <xmx:H-6SaJxAwLK92HXMUhmv6pNlKeTg-7krp2ZmALRjY7hV-1_hN9UL0Q>
    <xmx:H-6SaBe7KXBt2AibGIvTXXdJYt-1P-D6zv8GFAiT_DoSCydw1EB4BA>
    <xmx:H-6SaCOjp-QiXxU3h_5QxeKXDINhTvQ1yWINZygBKwX6yWXZSvYykFrh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Aug 2025 01:54:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cc7911ac (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 6 Aug 2025 05:54:36 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 06 Aug 2025 07:54:16 +0200
Subject: [PATCH v6 5/9] ident: fix type of string length parameter
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250806-pks-reflog-append-v6-5-a50839653766@pks.im>
References: <20250806-pks-reflog-append-v6-0-a50839653766@pks.im>
In-Reply-To: <20250806-pks-reflog-append-v6-0-a50839653766@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Toon Claes <toon@iotcl.com>, Jeff King <peff@peff.net>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Ben Knoble <ben.knoble@gmail.com>, 
 =?utf-8?q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>
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
2.51.0.rc0.215.g125493bb4a.dirty

