Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778FB29B8E6
	for <git@vger.kernel.org>; Thu, 11 Sep 2025 07:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757576947; cv=none; b=ex2zrkJSCX5d9kXp3onZrBZ8I4a/DGCQt4r2Nxu60496ffJV2a7B8bGYuD+SE9rhiAH//om4Kc9vGWbPEjkmI+9XHrb9XwVvNoqBETe4CKXdhXNDipEw9uzlouHEmQ/QAX4tFXcF1C3fEsRHijTKe1fORh3bgUDu9pHkakVe26Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757576947; c=relaxed/simple;
	bh=T70ZCHPnRwcVZ0ioc/h2EZtwZs5fbF+BS5M7BbObu+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pDVDSSeV5w2EjzI4SBfx+tcTZ+SqRyGAjbLSLa3LSz21LX5PRPQQZnvZ3QvcFP0aB48bT/TNox1tuCHRoi+i2mMF6FH+2aRtIderbEJZhYxogXP1DYMBOTirCKFxTL9Z0fL5VcCWxykL/wEYCw+UVDNJhY2zy78M8Fh5chix/H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Fo7cHkxg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VK17T25x; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Fo7cHkxg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VK17T25x"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 69B9E1D00219;
	Thu, 11 Sep 2025 03:49:04 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 11 Sep 2025 03:49:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757576944;
	 x=1757663344; bh=LLQKjqvdiB/ycpfB3TH/z03VzaLc+/hLTVxMFcC+eYs=; b=
	Fo7cHkxgSrWyQApKv7HvIhiwc930NxhKbSGr6cxVPCFyhEOndj6Ck+RPZdweTikx
	X8UYi04AvfBF4wsAW1Bs0Ev72jwc2ksjX7S/7IfWUaARY83B+xwNlHActtSDqk7r
	dIm1EUjIUP2a76ubkX+ZhPg8in6+w6OrzjUUmD1wLUTUy6rxM/k68me8CzasMvl7
	bOCU8QIY2dggD8GK6cndImEIJn2PGAHEXaj3pXDzd9cY+ceYaXL4NL0i3FfDDe/M
	bifXJrlmUQO8/uwU+2kJebdl4msiZWDrjhvhJfRyzdNrrM2ou0eaP3y+uDo+pcKV
	Um+oDEWMobmhgftEiMPn1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757576944; x=
	1757663344; bh=LLQKjqvdiB/ycpfB3TH/z03VzaLc+/hLTVxMFcC+eYs=; b=V
	K17T25xVuwMZSkxiw+EgnBsUAskRCjFaA1P83VU67vAu07but7lm9uMVriiTCe7w
	44/sdlJSVJSXoUezbwHD7wo3y4ux6yK/CPl0UXzxDsBTbgg6RaISjczqOkNFxcvy
	GdHwJxaiXp0VhoyxrK2Ad/hgLVRgOQIN9vZw/KfewZzL54kMnrEKRfNSUJmyE7AI
	AWnE3m2P8eBs2hKgy9VidW2Dxel30t8+YZ93D6N1o2mu0FA2YbRuAtO+TyMEB0ZL
	M5U/zkLiroJ+ufV/JFI43PiYnz8hO1AQSF/jBhfUK2JfcpwDWy/1FB6Q425pnN5J
	ttb8FpmAs0xfmbUDhmrkg==
X-ME-Sender: <xms:8H7CaPyisHuNawS1CRxBL89jGDK3qwAJWkKWnzH1B3Wg4PhttAY_mg>
    <xme:8H7CaHfDPFkqqlLcPxKvYYayAqAmpJeiXYeuh3GbdXqSdPkI8WGTg_FnsBGBHrgFS
    UiBLQ9rHhSygrU7Cg>
X-ME-Received: <xmr:8H7CaLJsCiLKhpmFLDA-1dHuMdyQ9Vhp3nrdqOfFwBgypQKc9YalUXySu5KtaXga__pn77iDUmSgbRYrnl8mK1FuF_HAsLs8hwp-oYMnSw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvheeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertd
    dttdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeefheffgeeflefgieduleehueeugfeifeevje
    ejveelheetvdegjefgkeeguefgtdenucffohhmrghinhepghhithhhuhgsrdgtohhmnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsiigvuggvrh
    druggvvhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:8H7CaIGx9lVrC5X0wOKdF2UDJ2M7lwQcjgPQrge6LkhcyJ4k_4doTQ>
    <xmx:8H7CaFplB1w7za9J1aPWrVnvFK0mBWvr4vFvMCWU9w5zJ95ylqAfrw>
    <xmx:8H7CaBS2wSp1hoy80tPCi7sbxo7KNEFcpXmiMooL-YYqKJHTyQTAzw>
    <xmx:8H7CaCN2UiK09QsGc4S9qpi0I-ZIgZpG5EZBmiXIiw68qY3IF2VZGg>
    <xmx:8H7CaJD_wU9C9P-50k8qJZUbUyfEwuk_5n5EGgraQdt0Kv59fX79FSGU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Sep 2025 03:49:03 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 76d377f3 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 11 Sep 2025 07:49:01 +0000 (UTC)
Date: Thu, 11 Sep 2025 09:48:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] ci: perform build and smoke tests for Meson docs
Message-ID: <aMJ-5oRFtRKFnQ2s@pks.im>
References: <20250312-b4-pks-ci-meson-docs-v1-1-5e7cf7ac959a@pks.im>
 <aLCf0UaTxy5Nxpv/@szeder.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aLCf0UaTxy5Nxpv/@szeder.dev>

On Thu, Aug 28, 2025 at 08:28:33PM +0200, SZEDER Gábor wrote:
> The documentation CI job should only build the documentation, but
> these meson commands unnecessarily compile git as well:
> 
> https://github.com/git/git/actions/runs/17222438141/job/48860520663#step:4:4679
> 
>   + meson compile -C build-asciidoc
>   ninja: Entering directory `/home/runner/work/git/git/build-asciidoc'
>   [1/1327] Generating hook-list.h with a custom command
>   [2/1327] Generating config-list.h with a custom command
>   [3/1327] Generating GIT-VERSION-FILE with a custom command (wrapped by meson to set env)
>   [4/1327] Generating command-list.h with a custom command
>   [5/1327] Generating version-def.h with a custom command (wrapped by meson to set env)
>   [6/1327] Generating Documentation/asciidoc.conf with a custom command (wrapped by meson to set env)
>   [7/1327] Generating t/clar-decls.h with a custom command
>   [8/1327] Generating Documentation/cmds-ancillaryinterrogators.adoc with a custom command
>   [9/1327] Generating Documentation/mergetools-diff.adoc with a custom command (wrapped by meson to set env)
>   [10/1327] Compiling C object libcommon-main.a.p/common-main.c.o
>   [11/1327] Compiling C object libgit.a.p/alias.c.o
>   [12/1327] Compiling C object libgit.a.p/advice.c.o
>   [13/1327] Compiling C object libgit.a.p/abspath.c.o

Indeed. I'll send a patch for this in a bit. Thanks!

Patrick
