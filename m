Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F5A322DC5
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 15:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757518573; cv=none; b=XN9Uw6G9AbizWt9d+rgISaeubCq6EhTK9A9zLLbeaFWRIfE19gLvW3chLnDGNPiPVip8eo9oetaQzo9CxDymHNT7otcFrQoqEHKhqA4ZuOkQVeKRGOScCj9o9uZHa/PiuwsUEOX54088v+pnuMSbdcoEQbs26pS9YR3YeY9kNZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757518573; c=relaxed/simple;
	bh=bstXY4IzG1jOVHrKyFhOdiVbgSEr4RdxfhfmrJtSyBw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ExDmubya5DgMX1Z2vt3vfdw1C1iFCv907rn433nJ9Ke+HoIDGODtE8NcJ8/fHlTaD4f4fceyrjSl0va2bU7A7RAn2LujoCu+1R5qNrfXWJO+zkXm4pju+QfGV62mcGiaW/efIg+MWtq3wIsFvaFa7dd5+GOorTYCT/MDrAbdTho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JqjAs6Ft; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fYt6GDdA; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JqjAs6Ft";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fYt6GDdA"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 37BB4EC0454;
	Wed, 10 Sep 2025 11:36:11 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 10 Sep 2025 11:36:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757518571;
	 x=1757604971; bh=w2rBadNyUJqJYOp8S4BEZMS3x9lQcf645ipB+BG2Els=; b=
	JqjAs6Ft1SaTorLE7ki0Z3L9G0fYzA8mbu26cBk1hhVqIzoiVwARt/GXGDBLTniq
	47WeKWBllduLWVgwlPOIboxUxnttKTonc5emmpIIzzgnj57v4+BRNnYHr7d0NIfs
	W66VSZyiVl8UepcyZatq3OC92uobfT5gQhl8rO4zAvxINiMGG20aIUxYcO6AcggY
	rF9ftDZbObT4BNzzbDi01m9Dn3uGlcD30iHYUJM8LqODPAHV1hiHrH4ZBDOuQFrY
	oy0rgUApNIJ1cDyCRGo8Lk3dkt+KPMPMbieT9bR+1xFGWjYC/eDwg4f3A+BEtrUr
	08XTf4nnjSC0p1WhBxGQbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757518571; x=
	1757604971; bh=w2rBadNyUJqJYOp8S4BEZMS3x9lQcf645ipB+BG2Els=; b=f
	Yt6GDdA8T4TeIbCu/jJUeUX6J4D5OgzvXZz44IwGPmYmD14cDxVm1E4eW2z9zmv/
	JWyBRObFuoykiUssWgos9BgLJlDiDmS0MoQT305VovUU4hFiNsMjVaWxKbZAyeCc
	Y5UeU26JVvQsK36MXNGrlWDjouTf+oFOtuQTmo/l3UcaKmSU4uVhv9qA5rNohDBn
	HZmG1dJ/L/SRe1xiqiOVoENEA0eeTYpG6rgLK5IE1XIfkDc55qlE8z3Iu5lKAin7
	3J0M3SeQss+9ylFsFhd1w3feufUprjllR8w/ZCaP0jeF4Go7A2pMgKX4g9K0ZKmx
	fSU88/+ESsY4lVSPUNFRQ==
X-ME-Sender: <xms:6prBaDajDYEonHYU3t7xkpBoRCv4DD63JId3LlRdL9lWPe5o2XzNIQ>
    <xme:6prBaCiT9L8pYqb7ctV6Z-9tn4Bzw333a0izs7KGYBIgJ1gUR7NqlrYQazpDUkLBS
    hmel2uhPKD_2iMyug>
X-ME-Received: <xmr:6prBaNasbVe-L3w9G78uEEhdjGmrHlt4V-cL-zT3oJ3wGj04mxutOfmF9hoSov4dxCXjRarX6dBx0eTZS4je0EQ4rPEXEW7QCcubDYESZnk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeeiiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepudehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepphhivghrrhgvqd
    gvmhhmrghnuhgvlhdrphgrthhrhiesvghmsggvtghoshhmrdgtohhmpdhrtghpthhtohep
    shgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtoh
    epsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvgiivghkihgv
    lhhnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopegtohhllhhinhdrfhhunh
    hkudesghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhm
    pdhrtghpthhtoheptggssedvheeisghithdrohhrghdprhgtphhtthhopegtohhnthgrtg
    htsehhrggtkhhtihhvihhsrdhmvg
X-ME-Proxy: <xmx:65rBaAN7CVnr2TUDKQMhI9BYoK_2bjlINw18HOU3-UWGKzZDIwv6VA>
    <xmx:65rBaGY2uYkjUI9rWBqPVGZqy2UO49CD7J_1XernssvcRrNTdx5aOw>
    <xmx:65rBaIXS7jhUtjN_vflMJGsppIbkasHKflGN-DLr8aJaTHRZ_r9lIQ>
    <xmx:65rBaNCTGWuzL5FE5-yX5c8PnBkaLN1D4jn-OkCNs4_BcnwfOk9WOg>
    <xmx:65rBaHtP2v7IfcPWvlHQl-C8mE-7p6MJErRjYsSZ65tePQLTAj8PUtZo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Sep 2025 11:36:08 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ac98c48b (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 10 Sep 2025 15:36:08 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 10 Sep 2025 17:35:50 +0200
Subject: [PATCH RFC v4 4/9] help: report on whether or not Rust is enabled
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-b4-pks-rust-breaking-change-v4-4-4a63fc69278d@pks.im>
References: <20250910-b4-pks-rust-breaking-change-v4-0-4a63fc69278d@pks.im>
In-Reply-To: <20250910-b4-pks-rust-breaking-change-v4-0-4a63fc69278d@pks.im>
To: git@vger.kernel.org
Cc: "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Ben Knoble <ben.knoble@gmail.com>, Christian Brabandt <cb@256bit.org>, 
 Collin Funk <collin.funk1@gmail.com>, Eli Schwartz <eschwartz@gentoo.org>, 
 Elijah Newren <newren@gmail.com>, Ezekiel Newren <ezekielnewren@gmail.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Junio C Hamano <gitster@pobox.com>, 
 Phillip Wood <phillip.wood123@gmail.com>, 
 Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>, 
 Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>
X-Mailer: b4 0.14.2

We're about to introduce support for Rust into the core of Git, where
some (trivial) subsystems are converted to Rust. These subsystems will
also retain a C implementation though as Rust is not yet mandatory.
Consequently, it now becomes possible for a Git version to have bugs
that are specific to whether or not it is built with Rust support
overall.

Expose information about whether or not Git was built with Rust via our
build info. This means that both `git version --build-options`, but also
`git bugreport` will now expose that bit of information. Hopefully, this
should make it easier for us to discover any Rust-specific issues.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 help.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/help.c b/help.c
index bb20498cfd..5854dd4a7e 100644
--- a/help.c
+++ b/help.c
@@ -791,6 +791,12 @@ void get_version_info(struct strbuf *buf, int show_build_options)
 		strbuf_addf(buf, "shell-path: %s\n", SHELL_PATH);
 		/* NEEDSWORK: also save and output GIT-BUILD_OPTIONS? */
 
+#if defined WITH_RUST
+		strbuf_addstr(buf, "rust: enabled\n");
+#else
+		strbuf_addstr(buf, "rust: disabled\n");
+#endif
+
 		if (fsmonitor_ipc__is_supported())
 			strbuf_addstr(buf, "feature: fsmonitor--daemon\n");
 #if defined LIBCURL_VERSION

-- 
2.51.0.450.g87641ccf93.dirty

