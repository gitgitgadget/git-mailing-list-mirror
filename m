Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9098D134BD
	for <git@vger.kernel.org>; Mon, 10 Feb 2025 06:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739170145; cv=none; b=fCAk+XjaSao1xQOm527WxZAv4m2GXvj6syZr9R3tRQ5T6QXfCaB8xUoaYzhFFFH60ufwpKA9VROmdsJOO/LaZi0wvWaueS9uPaBBQmvCeWfW1ImsLpVhbW//TOGk1nwWoGgFSBBOz6FvTrLmtjbgjWAZzrv74El7BN7Ng9nlnCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739170145; c=relaxed/simple;
	bh=8rAscY1gt5z1i5JlZXnorvmRWsgrkiD7z36ZgD9cE5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OVNBSKj2cIG/GGcPa/2NTW37Ulb03cIOTtoaWkhoojgiog/fSZLs8OPB7SyyF15uRHL6z0sP2PQh7tPGjKlkZDYe/4xCpg3VWxrx/dxrAmVFXzqsIAhaFd4jKM+FexPmSRfuOTrOmk4Mosb9jQwy87lJzChThHnjyz8rFPkh+yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=c3U4JLfg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oyeAru1T; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="c3U4JLfg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oyeAru1T"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 55DAF13802DF;
	Mon, 10 Feb 2025 01:49:01 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 10 Feb 2025 01:49:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1739170141; x=1739256541; bh=8rAscY1gt5
	z1i5JlZXnorvmRWsgrkiD7z36ZgD9cE5M=; b=c3U4JLfg/3+TiU6wM37tnn+b4A
	c/6fMyb6es5B2kpPn4BtV4msaqeun0mrCicSC+2ttd7EIBQWLy1j7UIICby4yA5i
	Kt0KeM68ssXeECCSeR10OgIMHW0nbbmZivrSRmzf2jnLJvx2HnySilYHtY9TC4xR
	cxlkpdBmADypUB+EeRPDU8YGEwNj3M+yT94S7EYn6rm/qYG8rEUVpOVQPGWydpLC
	6b6Qyjn6jJ8Lwaar94DxXD5saSpxX4tVJ4HADnGGPG9gav2v1OLBO0aBvIs7hIz4
	MzKC9zZKRcK5Lbv2HE1r1nXQrBuI5It+FyVxC6yeQOZX7uw8PNvkZngEAxtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739170141; x=1739256541; bh=8rAscY1gt5z1i5JlZXnorvmRWsgrkiD7z36
	ZgD9cE5M=; b=oyeAru1Tp6QWXWKgBO9NLKp71gImsORBBCP8He0+kqwa0Bzy+LZ
	ad78ppgq5GAXjM+IsRhCzsbn+rgoqjDqGGlQl6uv2gh+lsi+tgg42DC/LhS9XoCT
	lzKyCfcu2rM4qRjwdbhAIa98ma16f9ME9Ufk4vRdMd4ySaEyvZ8kRar/nTpIiVBe
	VoCzvVln+OibfLXZsljuTQJE+IRl1qLvDnkXHfB1W/uzy7lsjvBwioFadm0OWTcw
	W3Oew+EN8kxh6KbekI6a8yTzp3vlpOjFlcyxITO0naQ72KGT6QLmbcdgrM8Jyn6x
	uN9lUf5ZaWhoXgoZrx8Ov/oc6u6RoltZAcA==
X-ME-Sender: <xms:XKGpZ8hAx3e-N5Pp5htikFd1Ziwbt9Uu1eT6X5GYmBm24MqPXFel7w>
    <xme:XKGpZ1BhYHTjAG0znkF-aG1hVwMgR5UH6Wp6t4s-y6tatdQVy3VkRUQCmBYseBMu_
    WbyZKNc2UKVk_ir-A>
X-ME-Received: <xmr:XKGpZ0GnlzE_lb8kQTiyrAAf06d8wYiZBVcTvm9kQTZmLf22KGWRXJtP2h9XavEeqoYQ6AThXVX2h4BRssSWOkQLVTfJ9_AFoZSiZVYDSROqI7ac>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefjeefjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheplhhutggrshhsvghikhhiohhshhhirhhosehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:XKGpZ9QIpjAxolg7kovwRgzbKb-MSN6nIOg4iStndVDpDA90JH4aGg>
    <xmx:XKGpZ5z-UxooHKxd23dtCsMqRzp6lJHb3pOfrEeJKmQM8862_kxGUw>
    <xmx:XKGpZ74sOi1Sthi6KScmp73se8GwP3q0UDa1xp4LjVjpb9SVgUSjGg>
    <xmx:XKGpZ2xSvftyfH5tuslGj39epfgcsxGCuzmH5iP3maK1EQKRm1zC5w>
    <xmx:XaGpZ0_DTf0y61HjKvp2kIHpfd23NcYoPW6kcP7XoBLXBaPocJOcUEiS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Feb 2025 01:49:00 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ea23e082 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 10 Feb 2025 06:48:56 +0000 (UTC)
Date: Mon, 10 Feb 2025 07:48:51 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Lucas Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [GSoC][PATCH] t7603: replace test -f by test_path_is_file
Message-ID: <Z6mhU50bt5iYVuZ8@pks.im>
References: <20250208165731.78804-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250208165731.78804-1-lucasseikioshiro@gmail.com>

On Sat, Feb 08, 2025 at 01:57:31PM -0300, Lucas Oshiro wrote:
> `test_path_is_file` provides a better output when asserting whether a
> file exists. Replace the occurrences of `test -f` in 7603 by it,

Tiny nit, which probably does not warrant a reroll: it would be nice to
consistently refer to test suites with the "t" prefix, so here you'd say
"t7603" instead of just "7603".

The changes themselv look good to me, thanks!

Patrick
