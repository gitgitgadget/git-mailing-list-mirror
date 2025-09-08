Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525F930CD8A
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 14:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757340816; cv=none; b=aL/P6B//TZQKBDBBaP27npMWJzb6c/zg7jSzUwu6GOJQ5AtTYp7KXnMXvI2h3kZ2PdVU4KXZB8oJ7Itxhig9R8ikfrbO6NNFy/jYlyKfWFJiXxLYyUM4h0S3pVkLFPuNyvbGK7wzTRz7OIXk91bUSEyPm5n9R986thjgA1JOqIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757340816; c=relaxed/simple;
	bh=pDMUQSpBS0H+9pZ1db86UuKdkMv2rNKo7qON9a4BFYQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QwKmh6qF33I+9hjCUSTO9iC+44DWI2LZVZ5pT5KC8VlPnvvq13+mqWTYn6WWU+nLbE779AwSsrTtXoPaf5ShQ7WBAvlbWppGvketaZD5p5f0zlZ/uzQZScYjveRv6aZ6j9SGtEvlhOsqG1GpsLTqhNVxkOG93gbeA3wQxeL0tF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DipyRvMv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TBIeSupN; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DipyRvMv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TBIeSupN"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A9A2514000EE;
	Mon,  8 Sep 2025 10:13:33 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 08 Sep 2025 10:13:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757340813;
	 x=1757427213; bh=RR7ivmTBb5KRlAc6HlGNDtt9zK8rtjjcqITzijn+M+c=; b=
	DipyRvMvoTTykxmGGO+bh6Yq3XUUU6kKwxLZOoIvziYJfjiWfzvJOMfFyUG7I5ub
	rj4EcCH935QmQQn2wPP9SyZQ1EyEp89zrQw77ARbVp437L4+R9owAlURK7f3dOPF
	zuhPX4g0uA1zf7ydFqcwRR+OHkvrerwVG80yomFStJ8m7e6MWJh08iTZTKDWHkRS
	MwhAAHLxw8WNaM4OjNhX5UOFjkljTLWYlXEVUrMeDtsIzlL3F0Xdm71tB08hRfC+
	Y2HlHuTnyCPcZ5xROI6BPWBBXlah4/LPPHlD8IRauB5sUN9BtCRx+OeiksxZf2w3
	ZsclLpMR3+psi4Fd4Ivi1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757340813; x=
	1757427213; bh=RR7ivmTBb5KRlAc6HlGNDtt9zK8rtjjcqITzijn+M+c=; b=T
	BIeSupN7qdK4PMC5P42KilYo/F9IoLZ9yG5ygTzDOX1C/LafJ9Uh/0Da9lDZTxjN
	GEmUkQhXcx9Se5GLWE0GCEJliBqJZoQNISaxi8GHll/zvVNA65KM6Dq+qW0lW2YZ
	NP/HG1c8o/GPmKbwx4WJWm8+RkiJTgY7H2N0lxOZQycatA/E75UKf83UfDhsmBuo
	fPDxqles95LH5GtOVkm2QHFZDLee3xSyuhxhhbMj7mYGr+wvuxaGcC+IXVl2u4sS
	F0GNORilSajaQDkdiOmknziqVmcxqsthr3VHOtosl/w5vQcmRpDGDaYMuBW8fdTX
	iWE4EMwFOWZ/iChzx4oMw==
X-ME-Sender: <xms:jeS-aLIDhdxItRXVaCbBGh1a9T2J_G1qPtWS_my6SRxG2my_9JC0Iw>
    <xme:jeS-aPQPyGw_WY762kp9-O6QtK-md2-OZpuFTMxySpXJQ6uK3RER-r3tZgP-5yy0b
    W3UJ6N8rBO_8v6taQ>
X-ME-Received: <xmr:jeS-aLIXqeNU20Y_VIbJRPm9o_CMKmfp3W07pcjDwaFP2hysEKfgASYNyzu60uXQifUYrw_l3sy__ERtwleoEJmU-prolQ8fKmfAqCL6xH9fWw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeejgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepudehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshgrmhesghgvnh
    htohhordhorhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphht
    thhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhivghrrhgv
    qdgvmhhmrghnuhgvlhdrphgrthhrhiesvghmsggvtghoshhmrdgtohhmpdhrtghpthhtoh
    epshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthht
    ohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtoheptgholhhlih
    hnrdhfuhhnkhdusehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:jeS-aK-iJ7uHy23EHiu_-ZjEvOzYKBV7xNooagCyjlVH_C19LbSznA>
    <xmx:jeS-aKKixCI2OyLDwlhdKR3fJaKs_B3mpgeZ_djQZMCLDjGgztKbBw>
    <xmx:jeS-aBHQWXWyFTUw8rr-HBRvPxInHEcMxCGpfTJQhXv2g0GcMi62ew>
    <xmx:jeS-aGxQg2nZYF3nr8tKWK8wEuvI5R1EevQbOcjM4JQVmagRNeybtg>
    <xmx:jeS-aKeBmcI9Cg_fBhyZVqWVXoKZCXqS7apQx739tMIRD6kSCrv-BTd9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 10:13:31 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 78d19ac3 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 8 Sep 2025 14:13:31 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 08 Sep 2025 16:13:11 +0200
Subject: [PATCH RFC v3 4/8] help: report on whether or not Rust is enabled
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-b4-pks-rust-breaking-change-v3-4-1cd7189fed3b@pks.im>
References: <20250908-b4-pks-rust-breaking-change-v3-0-1cd7189fed3b@pks.im>
In-Reply-To: <20250908-b4-pks-rust-breaking-change-v3-0-1cd7189fed3b@pks.im>
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
2.51.0.417.g1ba7204a04.dirty

