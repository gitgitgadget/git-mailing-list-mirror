Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211DB28689B
	for <git@vger.kernel.org>; Tue, 29 Jul 2025 08:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753779346; cv=none; b=iNHEpMG9TgNFMOf+TVk+HmnPVdEKLgSvs8UPi7TOENRKSlY6Il3NmtCA8KImBYR2fSe39XYZ0sZn3H7eEJBGNOrQ9uarHEiZgvrT5e8oHNrD+IcTaS6Ojfor0FoJu2fQu8IPuROZbZnqcpnRWhORxD9w//YJVfYEu7N+nyS33HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753779346; c=relaxed/simple;
	bh=lYKzeMQPQw1jYTqgW948L9WXGhpYBswhhHyULhOlIRI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RXyhdfSbvBbtQiaF1etNatiXzfg4H2TBpmEBwNKa68sR7A1jgL9RZltn19qflaJbJEjb/kudstWW4uresuqkum6YxvQc6CJntlNkCj0qcV12C/Hcg5UNZJ+ggtLH1VPAJ1ie/KxZ63eP5gsRcLWhUk/z3EEhcS5BJYVhe8SZLd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PADIAQSP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a3DanWn3; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PADIAQSP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a3DanWn3"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5173F7A0BAE;
	Tue, 29 Jul 2025 04:55:44 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 29 Jul 2025 04:55:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1753779344;
	 x=1753865744; bh=gVOp/rMNZvRTaI6BVoe6PbOaSkxpgxU3DqD9FARRODw=; b=
	PADIAQSPIgy8umuElZ7wGOwwztXt1WedAWl37zJQo/uwcqUXiuG8VNERARKQN+Lp
	Rp/Kpvr29Wvo55D5sa6GkfeEqFsYi0cG7UClh7uM39LOqfoG+efopuzibKY/jjzm
	64vdobRQKcGTYos/mls5iBPG3CLqO1HBby0Vhm96Bfo406nmoFKKJ3bKPx3hrWFa
	eD5kWULYjuh6ixsnQ6SLmMBS0ZpTLMZXjLBIhvzxwwq49bZksn+4j2d6qQkaLfcN
	PGF5NVicuQuIctP4T9EycFyRQk0g2zxiTHkVpx1zalQ3zibbkEeOhkw/ZtV7pSyg
	vLDGK0CbObB+oQQBOS65Jw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1753779344; x=
	1753865744; bh=gVOp/rMNZvRTaI6BVoe6PbOaSkxpgxU3DqD9FARRODw=; b=a
	3DanWn3+QxKqoRqojnKV/3Bo3kZwICqZW46/jy4kQ0xrg7lrtczT3JKErVsyPd9J
	QONKXQ01EdnNfZ47gDxkygTLv8I69S25wUzFmyzALJmYEVfN8xbmZcL0vLQH71dt
	Dg4+Z/4GeSMQhlHSUWKpUvIVUS8kMNY2qZdxfKp0QAYk8olkOkRzdQ8/Q6wzu7sr
	41OoajZJz44FUw7W7P3Yaoif8sef9piLfNelID5HpbuinyUNK0EUhmr/KnshDT2U
	mHsHK1F63SBw+sg7MBPWwJqDRDlQVKMw5bEG/l7J0MFOPqLNe9mklebBh3bn7qcU
	/186JqS1dPKft7MUlWmRQ==
X-ME-Sender: <xms:kIyIaITuYOdK6XB1EMBAh4CLSxdxjprdSGN_UvdMOL7txG2ljnUMRA>
    <xme:kIyIaCr7XXtKsI_sirMISK0EQI5fxBLH9FROFJgHepDe9QgdK5jmvfJbXiOzWBsaT
    aAB2CjiMOU9AfNzdg>
X-ME-Received: <xmr:kIyIaFli8PrtyVuMrwT8hk8qqh9LAAM27J6Fi__-tuOda7aQRUowcVCawoTJb48tViPGqSrfYQNhx2wnGw5f8OuOSudOTU3NYQAWMBRzXcw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelgeeifecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslh
    gvrhesghhmrghilhdrtghomhdprhgtphhtthhopehsiigvuggvrhdruggvvhesghhmrghi
    lhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepth
    hoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhg
    shgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslh
    gvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:kIyIaLcFQipT3qtZkLL1LbtKOWVrJluxRSQQ7Pw7biDaa0zZ2mE3iw>
    <xmx:kIyIaBqPlFfLEYeZO66o7QKn8Pdv2jA_xWvPSlLSM_np4mHt4TYR8A>
    <xmx:kIyIaFNG0QNYnF3MgO18CP8SzsHcPv2u6o-gmRu--21SZ3lRe9OzBQ>
    <xmx:kIyIaEhqmetDDdrfdVSMz8WqgTf9JSed5V5oU1NkqKGYtk597KpgbQ>
    <xmx:kIyIaCkiPgaNdXLxWFT_xq9ppORxAbtkHRkHYRdo_LaAfEMDShdb3pzK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Jul 2025 04:55:42 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c6356f36 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 29 Jul 2025 08:55:41 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 29 Jul 2025 10:55:23 +0200
Subject: [PATCH v3 5/9] ident: fix type of string length parameter
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250729-pks-reflog-append-v3-5-9614d310f073@pks.im>
References: <20250729-pks-reflog-append-v3-0-9614d310f073@pks.im>
In-Reply-To: <20250729-pks-reflog-append-v3-0-9614d310f073@pks.im>
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
2.50.1.619.g074bbf1d35.dirty

