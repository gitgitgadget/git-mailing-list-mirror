Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D85163B9
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 11:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723720277; cv=none; b=pLp6uLdfwDnYsRJzPkpLgVHlA3WRmYJ3pnHRCULNpNeL5rUlLW7vHCjcXhzsNMKKDOAtY+C5k/LsKWCb97lwYDglMrLh7F/97sga07iGR8G5Ps3pR/PWa36l2udskjFQtAMMPCLdO01g4NIlyAa9wwnVH2lu9EU0aeCIj0DaGLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723720277; c=relaxed/simple;
	bh=nnATf0m4Nm8NSReh3meworZslLWQeao1233vGkjKsvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iSi4FSEvnbQMBJcZV6prZyXG94Q1yD5PuUTxyZp2Uwh5Jc2QbH8TiQ5SNMMCLIYKCJ6Z9TAeyruy9+wuDMlPIuPFwbaro07kHZ+93YxPwIAqbVBG3Bl9u4CZXeXBIbW53c8XX1kgSSdMk+Wc6vcoAP43Klrxs6Ox+ihYHp9GcqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AhMfUNT/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iaiWjWUj; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AhMfUNT/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iaiWjWUj"
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id BF88A138FFE2;
	Thu, 15 Aug 2024 04:18:04 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 15 Aug 2024 04:18:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723709884; x=1723796284; bh=ebBn6etC2v
	Wx1dLUpvPNV5fTnC05Scnr00VtDyzvSYI=; b=AhMfUNT/IoCgYbm7M6vzh39lZv
	zukjLLPEoEbjzVKtw7W59zK6HSKZvdNukLl9mhgfdj8u7e8hmqC7/lOyMxSEPsXk
	WtKxCMZB2ZcUqAqxfT082NbkvA++21pUB31IWtHFXITc1ZOgiTiPBnAzziuzjZ2y
	iXXzHS0F7V2q5MwkVx229K06k+AbB7TlDhsDX1H0jYd/DduC4H5RZ0ZKq5/5Haaq
	OKunCu974OE1KIyAmri4cY8ZxYAWF21MBxcExAqwKdbdtaW5NCQGvTgvLBVGtGor
	GZDNTIDe0LmAR7mx2TRtJfyGxYb4lxBJJcsi2xo8OJwd2bM/XI06XM00qkVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723709884; x=1723796284; bh=ebBn6etC2vWx1dLUpvPNV5fTnC05
	Scnr00VtDyzvSYI=; b=iaiWjWUjbTMkqoP4r73+OBXddcOLXxxoJzzpF+RcHixc
	7ZE576QnRWZQCr2kyEvVCskQkLDH0IUoX168X1Uu9frUmivryT/VKjaI5IUMI2B6
	e0i7ZTObHzjakMm2unzmX+/xQdfh4bQhGZ4ipO84cnELCWkZkGbQA7PfBJshlBOw
	PwxGsLXhlmrjYTR/eJxWrFeo1hhfrMZlsX2pH9QQOnJaKvlrF4r6l2JYH+3Dc8W5
	EZ2BmHryhKiK7vQy+hB3LyQpDxehWn/TYz2B84SAmb749ZrM0XjyVD9wT9fC9F+W
	f2ZVoHNrRIfsKT6HjTTOJRuims2cOQMpcTve85gR5g==
X-ME-Sender: <xms:vLm9ZlRHXUGHo_bU-zczxMQuP-T_nBVmZvLl5RDqkESWDw8qn9iHrQ>
    <xme:vLm9ZuzyMoQ1BgvdgYn22f5csGom6TkMBRRnf2BikY_13_KDDPG1dPW1VTD8L89L7
    ZWGm34s7KQwCi51QQ>
X-ME-Received: <xmr:vLm9Zq3O4aC17Lp1bFIJ6ig7I3l4gk2dnnxXMcDjHtPoPYg9wgfOqQEOt2LhoSQjN9xk_ursFN3RI7xh0D6mPaoLtTuN6oqaOVuUUFc_OgXKww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtiedgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhgrmhgvshesjhgrmhgvshhlihhurdhiohdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:vLm9ZtDZMzKS3rKYJfAPtAHbSKYKYUyQ2Vn_CkQB5f2XJqaJD5J9aQ>
    <xmx:vLm9ZuhhyF3wLfoMhUbIFkon8_Z2e0H8jB0Y1E8yo0ICkD1RjuUw5w>
    <xmx:vLm9Zhq8DukRhRF9Q54yNOJRolTD_d2BVferb_ipjkh0W2EZyZfvTg>
    <xmx:vLm9ZpgE295G_xYpnkyu5H-ROAcYr5X7A6xlNt3A97MSVxe9eQgMbg>
    <xmx:vLm9ZhvE9oajRcSvxQvWrJPNTGJe56s8Tkrc8W8mUGTtaDx5u1t8syBz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Aug 2024 04:18:03 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bfadf5e2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Aug 2024 08:17:43 +0000 (UTC)
Date: Thu, 15 Aug 2024 10:18:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: James Liu <james@jamesliu.io>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/7] builtin/gc: refactor to read config into structure
Message-ID: <Zr25uqmZIHgMBzWC@tanuki>
References: <cover.1723533091.git.ps@pks.im>
 <ff6aa9d7ba0bd67d3682ecb44c024a6d59a7decd.1723533091.git.ps@pks.im>
 <D3G8GP38BNG8.26Y1ZLIUPTWJB@jamesliu.io>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D3G8GP38BNG8.26Y1ZLIUPTWJB@jamesliu.io>

On Thu, Aug 15, 2024 at 03:24:21PM +1000, James Liu wrote:
> On Tue Aug 13, 2024 at 5:17 PM AEST, Patrick Steinhardt wrote:
> > @@ -206,7 +224,7 @@ struct maintenance_run_opts {
> >  	enum schedule_priority schedule;
> >  };
> >  
> > -static int pack_refs_condition(void)
> > +static int pack_refs_condition(UNUSED struct gc_config *cfg)
> >  {
> >  	/*
> >  	 * The auto-repacking logic for refs is handled by the ref backends and
> > @@ -216,7 +234,8 @@ static int pack_refs_condition(void)
> >  	return 1;
> >  }
> >  
> > -static int maintenance_task_pack_refs(MAYBE_UNUSED struct maintenance_run_opts *opts)
> > +static int maintenance_task_pack_refs(MAYBE_UNUSED struct maintenance_run_opts *opts,
> > +				      UNUSED struct gc_config *cfg)
> >  {
> >  	struct child_process cmd = CHILD_PROCESS_INIT;
> >  
> 
> Are we defining *cfg as an unused argument to conform to the
> `maintenance_task_fn` signature?

Yup, that's exactly it.

Patrick
