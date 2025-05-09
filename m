Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7F078F32
	for <git@vger.kernel.org>; Fri,  9 May 2025 08:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746779035; cv=none; b=iKsZM/nyC9h6Tl83EqOb15mY/YyXMTohoZtKtaMfsjVO30uXfleTfLrHc23ztN0B0S2lUlbj4xuPipN6lm+ELvY8SaVgKLINtAtWkBO1ys99+OFIEicsj0jF2ALsSlT/8nkq1mgmZiw8E+Qy7uzJBRq1tIget1T7GuhywVRmxUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746779035; c=relaxed/simple;
	bh=T0VqLKU1588qY+ye/eTh5SkTC/l5RIL2q29lqicJUJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XLWSsQmYOUKgkZHvHv1XmXDQJxomicC0hW5T8pDIVG0ThKHky/ot3ZU3cezy94rEEmjSBagOLEic43JenYeScJIpe35e9OJkfbryci9e7B9gYNUlSCUMrwcu/FjfIjLtgZvV5biCSakffVHnz9JOwBe6jquPx+b5aKTWNizuO6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=U9qe6+HZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SBbuluWC; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="U9qe6+HZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SBbuluWC"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9B0EE11401BE;
	Fri,  9 May 2025 04:23:51 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 09 May 2025 04:23:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1746779031; x=1746865431; bh=uCLYe6chGu
	75irJJnHlJC5mVV9W1Yi5g2I/qNnxqw2c=; b=U9qe6+HZ5YWUDyVHADVOm9Z5d/
	P4REe8xlFDioAhA6/kHBjAdJopsdO5fLbiPm//oEHetIr/jg4FPy/ut2b7W0ucPZ
	S7xmWAkMNn+YKkB9sGsJ2yVuqsVtixLhHnYnAoaA7/RAUMIkdN/Foh7GrQwetteg
	vZU+QfEQKnl9YEjnU8v20JW4HQaPtSqnmdUjyLOAMwadPkbb2Wx2yP043m0w+kll
	AvZ1ZpbQvfaNMnjTgBinUUUHNpKdRI2HuCIbGFa93mwcrZe0M4hyqjsNTdNssUno
	w3TbFzq5cTk9NFJxeQRkdYINDrttqeSLYnrEsKOKz00wFYlrsGKll3TUh90g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746779031; x=1746865431; bh=uCLYe6chGu75irJJnHlJC5mVV9W1Yi5g2I/
	qNnxqw2c=; b=SBbuluWCV2kTOsvSKMh3SfMLh7dNj5k9sy7M1AfwXfHR0pTumPf
	HDYd3FVdZ6HfBu26frHvSNsot5wRALFkdFh3YpIdanTKWhsvXKKQTcBRQc6Uccwo
	h6yyCv7gxR72leJHmeQAyL15lxFJML8i2H1ZZjfv4vlMAv12kVbT0EDsn++sZNsy
	jGPUhtefMFlPBXyhNTlhxuIRzQ0ZS3YM58n6rHZ0HCCPVtMV6bSUa3meytDwlERo
	AucIAf3XCIZkJbRCEi3Ftxnz/T2S59bM/8exjQXHqOTwGCkNi1bdU23mXcn/13hV
	Qd8XhDTvIMolzMmuhz0zdXAsk8ndv36Hu1g==
X-ME-Sender: <xms:lrsdaMOnQNvFSFLmrbqz3c-nNdhfxEO45DYCkTnAXJJxBDrjaGhPzg>
    <xme:lrsdaC-8-nolYCOJAaoZ4wqYHEmipTr3uObKpIUftCTsjHwcrcPmQ63vcf6cdOAG2
    WXri4vKRWOBsEf67A>
X-ME-Received: <xmr:lrsdaDSyiNabm-4--8MFjwNZo3M5Wo-WHPja5qH2yny8P_ehnQna8KryNbvOYzGlE-p5UPdBaCqDPyBTuR3PxkzXiOw62Hi5pmcgmTYrbg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledvudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohephedtvddtvdegfeeftddtheeisehsmhgrihhlrd
    hnjhhurdgvughurdgtnhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtoheplhdrshdrrhesfigvsgdruggv
X-ME-Proxy: <xmx:lrsdaEsEIs291hyDauRW7JER8qEemey2RnjvBxVjshnybfhFCea9Vw>
    <xmx:lrsdaEf6viK8OMtNyEr-YWiMQUygZd7IQd9Y_sQh08BwM38N-UMwig>
    <xmx:lrsdaI32hizCqDkZdRUAJjh2uQyDIlNIo9zcUrvXvBiuBhj_6Z3v6Q>
    <xmx:lrsdaI85kzklrYPmHb7LaztTpQhA-LFzfwLZ7eQMJ-HVVYz3hC140Q>
    <xmx:l7sdaMBVfvClUn7bOMHXSbY8Bjmy5fvmiOETbIxh03m82AnPA6xeKjZf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 May 2025 04:23:49 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 26bab1f4 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 9 May 2025 08:23:48 +0000 (UTC)
Date: Fri, 9 May 2025 10:23:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Lidong Yan <502024330056@smail.nju.edu.cn>
Subject: Re: [PATCH v3] REFTABLE_REALLOC_ARRAY: remove this unsafe yet unused
 macro
Message-ID: <aB27k8DI3BNgiwS-@pks.im>
References: <pull.1955.v2.git.git.1746756263207.gitgitgadget@gmail.com>
 <pull.1955.v3.git.git.1746776686718.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1955.v3.git.git.1746776686718.gitgitgadget@gmail.com>

On Fri, May 09, 2025 at 07:44:46AM +0000, Lidong Yan via GitGitGadget wrote:
> From: Lidong Yan <502024330056@smail.nju.edu.cn>
> 
> REFTABLE_REALLOC_ARRAY will cause memory leak if realloc failed.
> Since it is unused, remove this unsafe macro.

This looks good to me, thanks!

Patrick
