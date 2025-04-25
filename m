Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E36234963
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 09:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745574806; cv=none; b=VlT+whR6efYCVR05ZWXeZ7UcOC9kJVJIrmbQmhDgNY1ywSmcdLyhSIR0Of/nhMzd+ggVIZFckxF/7ikZfBFma+BPRGLi2qpS+P5AG2pc11KIcqHVPDgJsegyscIIBYlD0QOIsy9gOdoHRmR+r6YLcIMxVW/LmbXhrLK72GYXPA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745574806; c=relaxed/simple;
	bh=vFemvByYEYt3sCVtVipyBRYZPFafCS7d0Uyc26eeAes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V8K4ngs8Tijy7dbAAbwGmomQV4CprdOT2CUrfhZW55BW3s0/tp3np/2FQ7O38EE9pNeR4eCMkYcKz/kOXWIVMOf//erS6iGgovujkSkxScghn8Vs5UXljkHYD7nNxOM2cp4juRaFTP9gTM0apbviIJjR8yD6NTs8qvXv8VUHALE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=REum3IAw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eeeurN8B; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="REum3IAw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eeeurN8B"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id BC8DB13803EF;
	Fri, 25 Apr 2025 05:53:23 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 25 Apr 2025 05:53:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1745574803; x=1745661203; bh=iruC9GSGVz
	qYi3ER4DkyXPYEzb4kjcoUZWohUhbwYr4=; b=REum3IAw34UGeZ4ATudNQpK015
	Kyt1AMlI3PNFBisYetOD/nHxroA03JXLTXfiFlbfUx0zn7sranwTFvqW434052iC
	xWJCIKubTUy6KThxc2lyuPB2soXxAV6LcZrpVDs2IgwDW2och9jM4X6CyGxEPGph
	7b5WjPGiiqeouC6cs8LRtjq7N7TNjkbUwaXG9r7Aryaq/oCbHTBncUaY0p7wa63P
	qyScRyLbO2HWazlioxIXda6dHMipvVyW0qeKCwrbAI8wtNgzoWt0ofxlhnRJHJkA
	7ytv6ZUayuZ2yW6+MtmF0dWRWbjRI7U0PbGlwlyk9fs50W8VzLiuAlhYV4gQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745574803; x=1745661203; bh=iruC9GSGVzqYi3ER4DkyXPYEzb4kjcoUZWo
	hUhbwYr4=; b=eeeurN8BZ4ZmOmfXLg5joK+aq9J551aqg+xoEp/f81f1xnPwlx6
	gfpWX9vXpfTz23N/hr1QiIaWyZ9fte/TEVIlu32keuS5fnoc2/5f+ldW/pJXtws7
	FA2O55d2kW0P3xDnoqdZ/v0uuK9SSA1d8gcas5etu+vgfzrMzB0C9ONcwDah+PbN
	Y7jneP5dR4JPnG3l3vpP2jhNQAoU+3Xbz81/CERJSnbT0Ldn0Ffdtd6D9e1lNgW2
	X7lqsH9NtOEWDe1NZSGRvGiUaCdpgANkPLBCvYC5/RLIWDg7hOfouG3Xud4gXVJE
	wsnAYFKMnxmKxxvY+imBQdZ2f/W4bKkUJ5A==
X-ME-Sender: <xms:k1sLaCqrnLD__Vw5E9XXdazkgMqnCH0MMj65Q_HLHJ83bhzO7LTOsQ>
    <xme:k1sLaAq5KnOOMJSDU0FMh-9fBt8-lJ3G6Zrz2MmCz495f3v9hCB29JXzhhhfcAwZt
    8g5Ia4aW2Y_XMDVJA>
X-ME-Received: <xmr:k1sLaHMdCKRhzSD6uIdweR7eqIYqCoL7QpFESX0Fns4vhIrD8DE1KnsteGZY-gH38L5n1v1zCHN-pc33CEPKJj-cwOv4ldX2i5k0C4SG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvhedvtdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthho
    pehsrghmsehgvghnthhoohdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhm
X-ME-Proxy: <xmx:k1sLaB5I0UbOVWUDyLeTJlg6C6wOqTc7Kd3SZkK3QDr2o09cfYgwEQ>
    <xmx:k1sLaB5t0uk8pTLyRu64_e_Mwg2lj8iLp_T_07oJVZoZ9TqIWjNxtQ>
    <xmx:k1sLaBgGMLloUeEzx5e1raZuZIBl4ZkLUIEFPi2gpdwrAdp_uaPB-Q>
    <xmx:k1sLaL65qd8GnfB8rNDpIA4DbvMS0R3cAenPi2eH7RmX7Yt5vSIVmw>
    <xmx:k1sLaNHAgCWGk3BH-KRtup5t_byXvcMpMVUGXn3DML9bjB2a2Jv4rEQQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Apr 2025 05:53:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 26c5b2d0 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 25 Apr 2025 09:53:21 +0000 (UTC)
Date: Fri, 25 Apr 2025 11:53:20 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Eli Schwartz <eschwartz@gentoo.org>
Cc: git@vger.kernel.org, Sam James <sam@gentoo.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/6] meson: miscellaneous system detection fixes
Message-ID: <aAtbkJiL9Xp_1Dpr@pks.im>
References: <20250421175247.240971-1-eschwartz@gentoo.org>
 <20250425053345.17288-1-eschwartz@gentoo.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425053345.17288-1-eschwartz@gentoo.org>

On Fri, Apr 25, 2025 at 01:25:39AM -0400, Eli Schwartz wrote:
> Principally motivated to handle an issue where these were failing to
> detect the system properly, on Solaris.
> 
> Changes:
> 
> v2: getpagesize check moved to !windows
> v3: style fixes, pass source files in

This looks as expected to me now. Thanks for working on it!

Patrick
