Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8E96BFCA
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 08:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734079748; cv=none; b=NIwd8byDK4WjUevML7hqJfbiKrqfJb8g6NpCnvX94TfzOzxvB/4Dgk6SchW+cCLaCNxwk/hYZIU1Ec+ZC2lJk6zsEIJu7Y6NiwieSX5v/FcwQD+jaK/FHDGreV5MuzaAY6s++IQQELod6bDtithSY2E0+hY9RVpv23giTT7S9T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734079748; c=relaxed/simple;
	bh=YvS0NwMGKE9dwUWtQQ7pMUyHkUzImm49fXh692I9Sl4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=T/dK424bHifdsFtQtTjLX7yBaE7Ex4quYPbAuUm+kq3/uSIGhg8o9cUOHpm2KFJxjM/iH2U+T8FxM+YxZoTECoMwyLpULTWcnZ+jxD1wVYC8LOqZYPr7migQ5+lVjN47xyRTgfISER8M4SkszEoepaMGtILaXE3vjcDtZbR+cKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CvStX48T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L4f9FnUJ; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CvStX48T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L4f9FnUJ"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id B0B541140201
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 03:49:04 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 13 Dec 2024 03:49:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1734079744; x=1734166144; bh=GeGVbFku3G
	1Qzj1j742kO1DyNOPGbqp5qr3RQC3rwWw=; b=CvStX48TaYEYBuVDXNcDWRk2LB
	jJC5YDXLRtgdZek1v8RuhN4RM221QtWDhwYPTvbD9Y8wEXlBr7txwxmUhrO3T8c9
	wSuHj0r/pfhy+r/KN1mco4jN8PcV5kQS4eA24Xn9QX4FvB20k78LZX+pRtf3rG1v
	keE/HfZ2zDFWSrcU/X7EWWREluouq75G8hNNti/PXpxmTV/VLhoLS3IO67GkXoJD
	FlCoqqX+KVVrVczTzIbHDuh25/uRfgYPSwrA69E9jJvhNmztWVVnRb/uGAbf6jd0
	36oswnZh9mRG3/Dca9B5d0vAqoiPklE6onxlwfQX+UkctglPaeJmFv49xq9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1734079744; x=1734166144; bh=GeGVbFku3G1Qzj1j742kO1DyNOPG
	bqp5qr3RQC3rwWw=; b=L4f9FnUJ+qix14l1uHYX1D6PbTTlj1yv9GEgJXdO07IP
	p3bg+UDlL7tNOesnyC6AMYj/O8PYlGsjLNhEHvVMCYVlkz7tC33qaxZx7oQ4Dsy9
	5F/tgjqNp3td4pc1H/TZqLhSIANkfh3CQG5cuPJOMN8ssJPOGp5MqehGZc5pD0tH
	GsARNMXWsZyM/U619q9QLj+Esq16F7ir0C6lIvnIRgo7eR7rkuRGVOOXfuNP9rEG
	hHSa2LGjNIKi8bOMFDKa+CpHkkWgSEfgSAjiAFOyBd0RC5XW8DGZrT0hGc+IMjAI
	UnyycauN8XvJItm2bBXldXQMvjKD4LYEeR/DW07v9g==
X-ME-Sender: <xms:APVbZwp4jYzWJdUudjuumWwsnH-aHv6F-oKjBVdssNXpy7O3PWriBg>
    <xme:APVbZ2o0Q48LwurpUpzrNkeXqtYCVHQHsbA4ennLrlzXTBTeFvz1m0bxx4jzTRfkP
    lkn_meSvdNPytV2rw>
X-ME-Received: <xmr:APVbZ1PlzJW0oUfxlENGsNxNFBmW9u-ga6U-sD5QO6ZrXY4GEtDu7WXwSCL4nOEHEBhAxRKXHydpIiNkVVkjdoYsEYMm_NoTiJ_WYgJ2JGDeK4A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeeigdduvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucgovfgvgihtqfhnlhihqd
    dqteefjeefqddtgeculdehtddmnecujfgurhephffufffkgggtgffvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeekffevvddvjedvjeeiudfhkefggfefkefhheei
    keffuddttdevtdduueduieelffenucffohhmrghinheptghonhhfrdhinhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:APVbZ36irYVjM3oaSBfU1YELCLHDaS9MLlgFl0ygYEuvUTAZcfzD4Q>
    <xmx:APVbZ_4nVzcb-HjhamTo44ibDCC8f718AN5QZr5bWioqPLpHuf-h7g>
    <xmx:APVbZ3jXGIHEViBfw-tg6vUas5DID4OFtPef1EotWM9tJVPRssgRLw>
    <xmx:APVbZ54fZ24BsBMnLtxFXllJ3YoEAhzGR1tPdoWZM32bIMrr0Us7Yg>
    <xmx:APVbZ5Q_2-wt1-SRmoybkAo0snleZNcX2XKezR0QoTt4wYFPvDarFbpE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 13 Dec 2024 03:49:03 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 00bbfe19 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 13 Dec 2024 08:47:21 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 00/10] meson: wire up missing HTML documentation
Date: Fri, 13 Dec 2024 09:48:29 +0100
Message-Id: <20241213-b4-pks-meson-docs-v1-0-0c7895952cd3@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN30W2cC/x3MMQqAMAxA0atIZgM2lgpeRRysphrEVhoQQby7x
 fEN/z+gnIUV+uqBzJeopFhg6grmbYoroyzFQA1ZQ4bQWzx3xYM1RVzSrEiutT603HXOQunOzEH
 u/zmM7/sBgnhN0GMAAAA=
X-Change-ID: 20241212-b4-pks-meson-docs-2634bf3e7764
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Hi,

this patch series wires up missing HTML-based documentation with Meson.
This includes a couple of missing manpages, the user manual as well as
the random set of articles that we have. It also starts to generate the
indices for API docs and howtos so that the result is a complete set of
HTML docs, same as with our Makefile. It also fixes a couple of smaller
issues I found while working on the series.

Notably missing yet is an integration with CI as well as sanity checks
for any kind of missing docs in Meson. I'll work on this in a separate
patch series once the initial CI integration as well as this patch
series here have landed.

Further missing is the generation of both info pages and a user manual
PDF. I couldn't find any users of these anywhere in downstream distros,
so I decided to not care for now until somebody complains.

The series is built on top of caacdb5dfd (The fifteenth batch,
2024-12-10) with ps/build at 904339edbd (Introduce support for the Meson
build system, 2024-12-06) merged into it.

Thanks!

Patrick

---
Patrick Steinhardt (10):
      meson: wire up support for AsciiDoctor
      meson: properly wire up dependencies for our docs
      meson: fix generation of merge tools
      meson: generate HTML pages for all man page categories
      Documentation: inline user-manual.conf
      meson: generate user manual
      Documentation: refactor "api-index.sh" for out-of-tree builds
      Documentation: refactor "howto-index.sh" for out-of-tree builds
      meson: generate articles
      meson: install static files for HTML documentation

 Documentation/Makefile                   |   8 +-
 Documentation/asciidoc.conf.in           |  10 ++
 Documentation/{ => howto}/howto-index.sh |   2 +-
 Documentation/howto/meson.build          |  62 +++++++++
 Documentation/meson.build                | 221 +++++++++++++++++++++++++------
 Documentation/technical/api-index.sh     |  19 ++-
 Documentation/technical/meson.build      |  66 +++++++++
 Documentation/user-manual.conf           |  11 --
 meson_options.txt                        |   2 +
 9 files changed, 344 insertions(+), 57 deletions(-)


---
base-commit: 0b8924716a9b7975cb21e464917bb475de842a27
change-id: 20241212-b4-pks-meson-docs-2634bf3e7764

