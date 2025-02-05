Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1C1217663
	for <git@vger.kernel.org>; Wed,  5 Feb 2025 08:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738742607; cv=none; b=Jv1hr0s8FG3ZTEP8hj+bzr2OSIxxcgh41YDUuwVwa+JjAcfgo3jgBtADqqDtcSZNRTdmm2IqB2JGwgGp7b6mkZWifrMXYcmJHrl71Q/Gh5WygS2XCZPdIp3jgjxWOE5flRlDd6PjfJ7EDYsZ6o45cV4cHg3Hax5Cm3iwlBd0PPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738742607; c=relaxed/simple;
	bh=7MPISRPKLdsqShRmOD6gTmJeHSj3FiP2UWnL266fs+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tj0Ezkh6u5Rdq0+VP6S7AmzvYDJGxcxgHFrZjiS5xx+24pjNXLe5VHQSKhrvoL1hwMYynLRcQ/41aiTL3HOKBwYimehLAmr8LzWo4TmUddLcXF6s38KaKC9yg7mH7me4xPX65m/jBbpdCIe1Lq9wlF/Z8+EH/RJnmAk27N9JlPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JE/TonWa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=001bDCIE; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JE/TonWa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="001bDCIE"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id DFE8A13801E6;
	Wed,  5 Feb 2025 03:03:24 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 05 Feb 2025 03:03:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738742604; x=1738829004; bh=ETgMxj8+/0
	FmXvTApzJvSEcjcJSM9Bn2isVMOyIVBlE=; b=JE/TonWaCMf9fAgFwmgw0t6Poh
	qQm9/GWsX4ROKaOjYqyzQ2AD1C6QRPi5ElmQC1R7eIqMi8ZlSSmQvMqn2wXogR9w
	dnM+rGCjObenfs08qS++vlTAAtW2sYn4XkXO0KoIXcv8v2p7gcHMx00WtzrIHX2k
	STmdp9s0zG69PURSBn1qViJFPfYr461e0Q9fkyyKvHmJJBY/w2rtNcjK4Bou54fY
	3ECACJpgGZtvFbKvSFD+cfgd2R7kWSgeI699mqgdeEr4u1lb5KDWNVj3e0+oj1vH
	5ON3oImb74eu9kirJt13khoenCFUIEAh7aDxed39JsFM7OgXAogXFtXuqRaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738742604; x=1738829004; bh=ETgMxj8+/0FmXvTApzJvSEcjcJSM9Bn2isV
	MOyIVBlE=; b=001bDCIE8iyEJzcA6igPbJXYz6fLe8Q3gA5uEixxN2ZptCqG4zm
	ZYoWKO5LAXFjW0Bv+8V+3CtznQHWj6UdCC56rQujb0vt+z3APdCE6lFkoBYSulS2
	Z2dzSlwx/zfCt3HLWNY9i8GIHsELA1MPtE8CjVk+izqWJgbVaUB3AD4zZwWoLw+p
	akCXi9uFZBtHxWWJBGdjEBhNwdvnem8chKQPNDFpSmlOf2bkpBmzfNZd9vtCA06Y
	H0ALbixogYf9b654GFJJ0+W70isgWkUzEujPJhpqUqeiWB/KlngEugXn58xwylvz
	XCnLycYfwaCAYnUSACIEWjOl1t1z2FFLIUA==
X-ME-Sender: <xms:TBujZ40-Hwtx2NmNUxcZou6lCNaxH7WEGjFE_m2-z7C_ZXFQKCa3Vg>
    <xme:TBujZzFscga0r7fNqXFLvWWL8WXIy19abBu_9zsR35tLMObrruJ9X2k0yUixi-KOF
    oiYl9X-DnY2A3y6fw>
X-ME-Received: <xmr:TBujZw5veL6h6B-Erbrot6-yvc8KHoKVnRsUsfYqV_JqwW3tOAbNZBqRU05LewX7cZlJRVKO_2dheqdkI_aURb_jtFccH8cSZZVC7QaQTCZJJw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdeludcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehmshhutghhrghnvghksehsuhhsvgdruggvpdhrtg
    hpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehkrhhishhtohhffhgv
    rhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehtohhonh
    esihhothgtlhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:TBujZx1J2RatWJI-1TY5tm3QXUlpL2o4M6l6xrDG7LxfLrj-D4bCog>
    <xmx:TBujZ7HzM7t3n9Hkw2JEyJH2xy5f-veqQDWAL7AfK6C1LSJUytzyCg>
    <xmx:TBujZ69kIghtbTPDaqrpWyTVRa7gnGhmBNTFw74jL8IHmQqkK3mv-A>
    <xmx:TBujZwmqC2PfcPKQ5xG6mVOiMZDKSvUvJhM-X157bdeCeFIQe3XxLw>
    <xmx:TBujZw5hvfRdpwzmmz3qKZbProhVF07OAVQap_z2iQCeVGpevSykAG-B>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Feb 2025 03:03:23 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 938d3a0d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 5 Feb 2025 08:03:22 +0000 (UTC)
Date: Wed, 5 Feb 2025 09:03:21 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 2/7] clone: make it possible to specify --tags
Message-ID: <Z6MbSXQ3O476bpfZ@pks.im>
References: <20250204-toon-clone-refs-v5-0-37e34af283c8@iotcl.com>
 <20250204-toon-clone-refs-v5-2-37e34af283c8@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204-toon-clone-refs-v5-2-37e34af283c8@iotcl.com>

On Tue, Feb 04, 2025 at 10:34:01PM +0100, Toon Claes wrote:
> diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
> index de8d8f58930ecff305f79480b13ddce10cd96c60..e89ae2e8c664f4d4e15e5f05264c8df988295e3d 100644
> --- a/Documentation/git-clone.txt
> +++ b/Documentation/git-clone.txt
> @@ -273,12 +273,13 @@ corresponding `--mirror` and `--no-tags` options instead.
>  	branch when `--single-branch` clone was made, no remote-tracking
>  	branch is created.
>  
> -`--no-tags`::
> -	Don't clone any tags, and set
> +`--[no-]tags`::
> +	With `--no-tags`, no tags are cloned, and set
>  	`remote.<remote>.tagOpt=--no-tags` in the config, ensuring

This reads a bit awkward now. How about:

    Control whether or not tags will be cloned. When `--no-tags` is
    given, the option will be become permanent by setting the
    `remote.<remote>.tagOpt=--no-tags` configuration. This ensures that
    future `git pull` and `git fetch` won't follow any tags. Subsequent
    explicit tag fetches will still work (see linkgit:git-fetch[1]).

    By default, tags are cloned and passing `--tags` is thus typically a
    no-op, unless it cancels out a previous `--no-tags`.

>  	that future `git pull` and `git fetch` operations won't follow
>  	any tags. Subsequent explicit tag fetches will still work,
>  	(see linkgit:git-fetch[1]).
> +	By default tags are cloned, and passing `--tags` doesn't change that.

I think it would make sense to have an empty line before this addition.

Patrick
