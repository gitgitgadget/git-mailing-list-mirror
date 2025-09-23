Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A6F3191A1
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 08:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758614619; cv=none; b=uV0G1Z+Tc4h5w629Wd41x0/+Or6Iew+QLNlLVxU22m+wjLY/gGTXQgwMcmN/A8JxAhi4xtY8CXOXdzQhTOyTpxIvt/Qun8+Dh05ZnkCSB+Zw1YviikNaJgWwZaYlMk+Oq+847ecXF5XmoKWrOrL+oP7jDXuyP+y00lw/izNcBow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758614619; c=relaxed/simple;
	bh=tUNUssAJ69hXDco93CnQHErZhT6fNT4zd9mmWdrsw78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FMm3m+XL11clObX2Ae0O+78iTd8P+2C3RgO2FyorBoVPJn0KscOwujS48WW0Py8eGtQp3tXpTSnwkVF7e1Dsoodcj9Q6vUNuVse18sWAC2yfrYxuEDtLvtOoOBe4JS2ew8EMaQsvEyCTQ97xGAGRRyV7Q8XCUZBaew5nydc4zT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AsTrPhIa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fyVM9tEr; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AsTrPhIa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fyVM9tEr"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 60B5A1D00077;
	Tue, 23 Sep 2025 04:03:36 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 23 Sep 2025 04:03:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1758614616; x=1758701016; bh=P4mhriCxYH
	acncmrY0AfKq3M84FPpYWFO/M6WBaIPiM=; b=AsTrPhIaDzAiAAmotvp5ALB+g3
	FzYx56jqeVDMbdZSrfNam6WxnqLOjcyAGjNvBcldaVOTESLzcVkphX8qtG8tnYKp
	wbX4oVHepCJFMYxL3hj5vdFnHggheARkUoFooyc/fb/jV5+eYKQXzPWveCXtSpxH
	53rugOLHhGQpz6bLfVYbcy11oOXIxxwHuT8HukeqJfKYEPS+bNeJemqff30yuHYH
	1Eve7fTQWv2rSWeNVGnTWa8gxqis9osKPxqYj3FG3LraRzfhsR1R9I8ZxpB9Xi8i
	tjBxRSk23ySbDORWrPBJ2L3JsQKbzJ5YYHiXScatPeIPDW5RQ4q9ZerPyWLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758614616; x=1758701016; bh=P4mhriCxYHacncmrY0AfKq3M84FPpYWFO/M
	6WBaIPiM=; b=fyVM9tErV3e+JgN5SiW5W7VZPcrRui/D9k0jqP0isYBwjmxkeyQ
	E20DJfjkj3TbY5qVrxFnPO7TU/2swz6fN2J0D6tFn5dsnBbS//uzC9xAykMXdJYi
	81TPHsmSUh5NxJEim0IW8g7IAPeUDjpZWzhRvcehmTyrqBpe80p+kditY+6I080x
	9WqJjEZ7nwApVX6u2Frg+B0x14aLNWd8XxWf8prRUMGI/yJeMhRJqleUCKZuUNMb
	v7/UiIclCCTllePtt1tM7FXxkV/2icHdgPqgreB0S9+8czVgIs00TQ+wHecLmwil
	551B7lzcS9K1JHdn2kRzOLPUGcG/p32LDfg==
X-ME-Sender: <xms:WFTSaHQThoTpiMqYb_g_AGjLEYg9DnMeuJ5MzYLePxRQls_arGgzuQ>
    <xme:WFTSaOwfFELIUJpA8YgxJDoddvdv6E2JU9I9XIKjfsHPs2z4IoipBFRX_0PjniGnd
    9Ot4CG0ECrwwmIUzOGr9HWth_TrsMfDJlU89rV1cvWm5_yi6CNZ>
X-ME-Received: <xmr:WFTSaKeVGIEsQKbIGaIPcfeY9FAoFwebYaGpRIgi-y_AoB_vLY_3tN4QZsmt3qJUVK8Y-tDomHlfrUJIvJg9vcIvyhi8o5KAJ0r10toTlnCU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeitddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhe
    fgueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:WFTSaCILuv1yfACNaPcetvBXLKUcVgX8StORjEDapnQ9M2iKJYLh3w>
    <xmx:WFTSaDHHVdfKVGd7NRGabQJLobK6Subn3MDZfpiH4Ravw_CmtA7BlQ>
    <xmx:WFTSaErBP32KnrtQyiJXI6iyGmXzCv4JHozf3KXW0d5A8IUimeLyjA>
    <xmx:WFTSaER7mtNEwz5nVOtpOO3H3tgI9I8fjqry3a7BONLCKgDJpOTNtg>
    <xmx:WFTSaKrrzXHnAO0A6WPpEIPEVWFRI7TQtmVC4u41PKrcSVtKePeKVT5b>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Sep 2025 04:03:35 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5f179c4f (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 23 Sep 2025 08:03:34 +0000 (UTC)
Date: Tue, 23 Sep 2025 10:03:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [RFC] doc: check-docs and WITH_BREAKING_CHANGES
Message-ID: <aNJUUxfhM7QYDQGj@pks.im>
References: <xmqqjz1u161e.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqjz1u161e.fsf@gitster.g>

On Fri, Sep 19, 2025 at 02:33:33PM -0700, Junio C Hamano wrote:
> Shouldn't we do something like this for breaking builds?
> 
> Documentation/Makefile pays attention to EXCLUDED_PROGRAMS to
> pretend that the git-$deprecated.adoc files do not exist
> 
>     -include GIT-EXCLUDED-PROGRAMS
> 
>     MAN1_TXT += $(filter-out \
>                     $(patsubst %,%.adoc,$(EXCLUDED_PROGRAMS)) \
>                     $(addsuffix .adoc, $(ARTICLES) $(SP_ARTICLES)), \
>                     $(wildcard git-*.adoc))
> 
> but nobody seems to put the removed programs on the list.  
> 
> The dependencies around Documentation/GIT-EXCLUDED-PROGRAMS is still
> screwed up, I think, but this may be a good first step to straighten
> it out.  If "make -C Documentation" runs lint-docs by default, for
> example, we may want to tweak the Makefile down there to make
> link-docs target depend on the GIT-EXCLUDED-PROGRAMS perhaps.
> 
> diff --git i/Makefile w/Makefile
> index 893070be76..711cade8fd 100644
> --- i/Makefile
> +++ w/Makefile

Curious, but what's up with the "i" and "w" prefixes here? :)

> @@ -892,6 +892,8 @@ BUILT_INS += git-switch$X
>  BUILT_INS += git-version$X
>  ifndef WITH_BREAKING_CHANGES
>  BUILT_INS += git-whatchanged$X
> +else
> +EXCLUDED_PROGRAMS += git-whatchanged
>  endif
>  
>  # what 'all' will build but not install in gitexecdir

I think this change makes sense indeed. It means that we stop linting
the docs, which is a bit of a weird side effect that may or may not be
sensible. But in any case, we should probably stop installing these man
pages.

I say "probably" because this got me thinking: we could keep the man
page for a while, but completely replace their its with a notice saying
that the command got removed. Even better, we could even tell users what
the replacement is.

Patrick
