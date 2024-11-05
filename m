Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310301FEFD2
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 06:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730787474; cv=none; b=KJnvIXcAeQTlTKKrYVeXxko4BIh+1rP9AmgeRJain4wxSs47C1k2hNtTzf9aCdh1e5carmd6ONP76hSi9nYuX6BRb0+aLjKRH+zXHt0UB59y1R0PQpMJFdcRb6bicTLLPXPprbPcLPcybCrQUExbOeJp2S6Y2LLg22c4vbThglg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730787474; c=relaxed/simple;
	bh=1usc/bLUuPOLq1lh2l1Ul04ntJ6LxjLoSM9OpQPZvUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XwvaeGtgV0Dqyskc2T5Alx+4QBggHPEaeLgqCmwcZ1pE7vmr6LaQxVBGkEL1ldXfUXAuHUdJyilM78Fzhkvqaxa/15gyz44VjxR5FWqdJr98MxFIp+Q4kBHsn5zw0j3x9mSW3xqDBNvV4p+g9ROukY1EYcUswN4doZtgASky53U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=wVIfsgWw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ki6hNIHT; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="wVIfsgWw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ki6hNIHT"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5208D254019B;
	Tue,  5 Nov 2024 01:17:52 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 05 Nov 2024 01:17:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730787472; x=1730873872; bh=M6v69QYeSU
	+x9sjR7UAPPh3S/fZIlh+crMNI2TssvYo=; b=wVIfsgWwUTxq4dA6CmgS+dpmR8
	ZtYaq9dJsmukMsKYxphp6UrWejsU/LPmPEDs3qcUAy+zZ6DSPl1caaBqRMb4o0uv
	rFcRdnjjV8NXD8jvRrJLFvhUW1QGWetGkvO4K0KkI9h5NuV6cNJxoPjCVpNp+qZk
	wFVcp02UCtL6IKmlZSMxflH1IloYzQ7AFNIit+Ni2i4bFSIJWzPCrcpdYijb4/XW
	aJaR3Yrt8O7gdERGhk7jm8rQRVRL9ljWPv5irYcl9sJmY9IRBi/umV5c21BbxGzo
	Y8aEqAczjOOpUt5lhD1+RszqGwMIEavND+1l41sCfp0oxYHiyZwiwmQgfCZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730787472; x=1730873872; bh=M6v69QYeSU+x9sjR7UAPPh3S/fZIlh+crMN
	I2TssvYo=; b=Ki6hNIHTpdd6e6FP9y08rt+U0/tCOuU+ct/GjdgfW2x3X+hxoMF
	/1QGxLCRa2d+vSR/JW9zIUlNOSmi6ANkuAATLZqUIom9oEIA2zSjtsgGW6RRI871
	PKDwsFZ5xGdbH0aGHaiaFGZmGPhn9rIY9Wdak3oWELha7++XJoeo6ObvReWc0cZI
	s54zLnyCrrM3im+JgAyJCZtsxVIEG4qN1vPco6NrxjMzt9FOmT0dM87t5dgP+1nK
	rd4SC2yrmitxfY+KN+hfOWewmz6eoRv+nEKsG6qlvDl2tgXEHLlrjd/EKUKSX145
	Na4d8hclSHgGfd1DGnBeqHr12jL+cStilTg==
X-ME-Sender: <xms:j7gpZ33pWOWFDoiRQWqEy6fDm_lDrWxzgv6E8oYK9NI-wlaHhCmeEg>
    <xme:j7gpZ2HU03WdPhPneAVv9oFUa09VrvGUs3x1dvIcRaTJnxPfW96Ok720L-Y0u9nS9
    P8ZwgBbmTbM_vSzSw>
X-ME-Received: <xmr:j7gpZ37rzFqHbCsjupsjzvEOUAEEreDgs5_8sq1pEHHsuqelj8KTOB9_Q7CdNGBEsRV_dkGNplf9fgwwPaQmZ3q1uMnG0-dbQ2lFKO7XPS-tvw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeljedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoh
    epmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkh
    esfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhl
    rdgtohhm
X-ME-Proxy: <xmx:kLgpZ83k3mVSREZvKs9dTTtMPahGyqpY26iFT-lOk0AsRI6bEEZDYA>
    <xmx:kLgpZ6Fdt5BAXqmlt4pB7l1_TbpLpNpfyy0F2K_S6_888BYmYMiU4w>
    <xmx:kLgpZ98fhMs0UZnpOxlbDgp2GiPrEG06y2CQrd_SCPRQTNIkfUNR3g>
    <xmx:kLgpZ3l9FZIk3Rzk64jfQaV5RvK0XycRYwRxto-13sSl69E6Zv2Ssw>
    <xmx:kLgpZ3PM_3fY5ZQpPlLXaOmE_koSux425Gn-1M8Y5v47OKrSYMXzU43d>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Nov 2024 01:17:50 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4af61958 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 5 Nov 2024 06:17:29 +0000 (UTC)
Date: Tue, 5 Nov 2024 07:17:43 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 19/22] t/helper: fix leaking buffer in
 "dump-untracked-cache"
Message-ID: <f056d31ca50a739c64b142f4f0b455326c283c14.1730786196.git.ps@pks.im>
References: <cover.1728624670.git.ps@pks.im>
 <cover.1730786195.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730786195.git.ps@pks.im>

We never release the local `struct strbuf base` buffer, thus leaking
memory. Fix this leak.

This leak is exposed by t7063, but plugging it alone does not make the
whole test suite pass.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/helper/test-dump-untracked-cache.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/helper/test-dump-untracked-cache.c b/t/helper/test-dump-untracked-cache.c
index 4f010d53249..b2e70837a90 100644
--- a/t/helper/test-dump-untracked-cache.c
+++ b/t/helper/test-dump-untracked-cache.c
@@ -68,5 +68,7 @@ int cmd__dump_untracked_cache(int ac UNUSED, const char **av UNUSED)
 	printf("flags %08x\n", uc->dir_flags);
 	if (uc->root)
 		dump(uc->root, &base);
+
+	strbuf_release(&base);
 	return 0;
 }
-- 
2.47.0.229.g8f8d6eee53.dirty

