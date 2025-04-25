Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FFD1F3BB6
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 05:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745558494; cv=none; b=siJcRtES2lhk3Jsq7J63jSLNvBipen2IT0xwFmkU/VGr3iMZDKhWW9MCHUtPMOzD9L00yCrT18ntP4bHEXkhyAznBg+SB33pK6NmqnDqMec8RoOZxAaKDWEHSYHR3UrwzmsX8Hm8tYOAUYxztYTKpEcmaNF0Om4ChDXOkFzyYeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745558494; c=relaxed/simple;
	bh=BWZ6aRSd3C5JJ83GbrMGehoBLT8yQi3jMMr5GJY/hIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U3isVtjcqcYTkxqx08kZ/L7pOaPLxcTMwqyyzb68XgLBCSH3TnkULAH4q/TTO7tIZ3BA5NLrjGgXB5RsC3FR7ixkPVvvKpHCkis38YJ26eCs32akiGPPxnMZcgI6AwGK9luH0XBZoKEe0E5J8QVYa7C6EFZQw9MFzcRDpejJSd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=2n0nyHJt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wsIHznko; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="2n0nyHJt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wsIHznko"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B66C51140169;
	Fri, 25 Apr 2025 01:21:31 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 25 Apr 2025 01:21:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1745558491; x=1745644891; bh=4VHA1rejUd
	u69ifdENEQwoLzgxxo3AvEKL7Ws8XK3Fg=; b=2n0nyHJtOR1d3bnYMsHRKOqX03
	+3HoR9QYxQhWUFYEZTEzBHEfLC9Zzctj/e5hYDJHo6zhTz9lRoSZr11IPn6NboRM
	uw6U7h19lE1zQHew9Jf/AMBawWYZZIfJZznGGsfzafUtOKwqxBWnJwXQYdOH/15x
	neuz755yG+uo9fquj7Jj/OSBoqEV3osolDrVFZPxwKBQy1PvmsPvyDaKI2jlvYcJ
	aMBgKcIeT2XpDBfwdsl7D6ps2SPXctTaFBxK+2lw9JsF9dSgS81LffpxqtT8LS6D
	gWw4g+UPkLANBYBWBtNdY0TXYuwEKZkEm7UFKGm5GgarcUPlACBRMrsIMQbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745558491; x=1745644891; bh=4VHA1rejUdu69ifdENEQwoLzgxxo3AvEKL7
	Ws8XK3Fg=; b=wsIHznkopK+1WDDreo6mtuGLOq/ByzX79qRZnYZzyQ+rnDLeD+I
	XElLZsF6qKxxvWe13oKQ+tsHtGVz4cnJiMbFnzbXCndwdX0fBWeMszoFQ1xwRTUE
	ZrngOXpEz/rQMXmWJH02Fl+SFw8e3ZQPPzlNn2iEjr2B++HUhkQ5c4IxHHrCswzN
	CptIjTqPjW+io6L8IN6QWNjDRMYmu8fVKWD5A3eULXSFc+2XiYaKG5vMoLQJnOwM
	yyuKMETxhx90w77OYe/WXPeyukHtgoIwe7hzaStkOZmjzRU3ri3ipBBLuQeuIF/5
	QdPzhPcVDlxbLz6tcUl5T5K2MIPQRCEzS/A==
X-ME-Sender: <xms:2xsLaOjZLPixTehGxScra_UctvezFe_iomXfdiZ8_jsoyp5oQG3T3w>
    <xme:2xsLaPBTtVCGRMoIhSQXsVN5Fh_Lc_KJyj_CD2xPvygGWZ0GDi9pyaVCXgIBL8X2r
    rkoXx-kr4SkotdROw>
X-ME-Received: <xmr:2xsLaGG1Pr9wzFY9XvhJ9AkZz6tEAuSkMreXRHZpTvbi8WmhhFU9rYYpth92xQMoDsuTHblmfPsLv9t_sUava-WF8qOK_P5NgzlMQa1O>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvhedugeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehpshdrrhgvphhorhhtsehgmhigrdhnvghtpdhrtghpthhtohepjhhl
    thhosghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:2xsLaHTM91zR-lVUWrqbQzaf4BoWe7gKo0GQ0sLSkOcUm-AjAWYDTg>
    <xmx:2xsLaLwJZoaYiaO_DlkSO5OZnoHofWrbPT--ImNOMB1YNckVI8Lk9w>
    <xmx:2xsLaF6pZ2hRwCH_4-jx9_wcNUuYdxOLuhMdFg4DA47oSmzME3c4hQ>
    <xmx:2xsLaIwik695EFtxWCTwMw_sMZ5iPLp9hlBhjecjg4iiGA_yak6Xfw>
    <xmx:2xsLaBMe937SovzLFJNXvQpSQmQsfWr4CgX87_whziuYgKZe4Kb2nqiF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Apr 2025 01:21:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4942d848 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 25 Apr 2025 05:21:30 +0000 (UTC)
Date: Fri, 25 Apr 2025 07:21:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Peter Seiderer <ps.report@gmx.net>
Subject: Re: [PATCH 2/2] meson: prefer POSIX-specified shell path
Message-ID: <aAsb2SEbxatCw9Zs@pks.im>
References: <20250424-pks-meson-posix-shell-v1-0-45e06ee4b6ad@pks.im>
 <20250424-pks-meson-posix-shell-v1-2-45e06ee4b6ad@pks.im>
 <m2egcx4i2nezlwlyioofnz4srjgbyhb4dkyrpi5crnt5uwuvy3@a7tbji5lrnvn>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2egcx4i2nezlwlyioofnz4srjgbyhb4dkyrpi5crnt5uwuvy3@a7tbji5lrnvn>

On Thu, Apr 24, 2025 at 03:18:29PM -0500, Justin Tobler wrote:
> On 25/04/24 03:38PM, Patrick Steinhardt wrote:
> > diff --git a/meson.build b/meson.build
> > index 8f04534c7ff..1db768380bd 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -236,7 +236,7 @@ sed = find_program('sed', dirs: program_path, native: true)
> >  shell = find_program('sh', dirs: program_path, native: true)
> >  tar = find_program('tar', dirs: program_path, native: true)
> >  
> > -target_shell = find_program('sh', dirs: program_path, native: false)
> > +target_shell = find_program('sh', dirs: program_path + [ '/bin' ], native: false)
> 
> It might be nice to leave a comment explaining the ordering intent.

Will do.

Patrick
