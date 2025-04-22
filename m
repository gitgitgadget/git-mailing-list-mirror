Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA571EB1B7
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 07:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745307097; cv=none; b=t6R9+P/ZQq1ijMrNeyqVhD/ZvLYj64DXa6f8qIdjW9MauzI2jwm2OCU5FvY3x6gxt+VfAH7uSbePOS7yzRZu8UWAZxnujVGn0+LXy6r4xQG/W9fOOerYr3acwBuSoyDoCFHrPpwxGbYwUekYxGPFgA9HkfxfpmLA1nJS/q2h5Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745307097; c=relaxed/simple;
	bh=93K0vDHY1uNez2UVPUJfoZ33W1BxYRMcnVljsDaKsOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HvQKiYLwKLLVc9MBtEKlwTb3Oiajk6EXTLSVICowKViFMiFZDOTPE+h5w4G9iVesJ9Y2A587hSgElY8JmMUHXy80aKpwIR6JS2IQ7V1jjOFrxejgNryocjU6StueALSBtiPRtSVfLMqxY2gI9ZHUgrx0+0OUlpSSt3AQaOA7AEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cb1qKS0D; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wod//1/v; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cb1qKS0D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wod//1/v"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 09ABF25401C6;
	Tue, 22 Apr 2025 03:31:35 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 22 Apr 2025 03:31:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1745307094; x=1745393494; bh=ryAhsqI3Op
	G+P+DWenzrIPbKClCVON5+/0UrBmMSEHQ=; b=cb1qKS0DzFRNp+z+YNAThSKCIw
	V8JIFPJVxE2oMPYrAgZDQNrcT7u0hWnrgUHgvuu30cPnuyy7Ih7jJUz3x7Cks13m
	vsONvkAXJXDTdZz6A0EAow3jvEab2Uz3sSg3FhADwgPog6LEtfZO7EYh9Uoj1bIr
	7JiTJHEyb9IcsMQaLAozglB27nSwJdxaUACjFF+u/Kzh6VnxcEid74VLBMmB7rp3
	rnrvoXKLaZqbSK9GdTt8hK7Pv+PGg92fSZWTMhdY4TlgjTx/eulr2v/ypBCHC7R3
	k9syuxG4JYd9/yQd1DHfiCoNOsfq7tiTKSXLP+K/3LaLdCFPo+5eURcu3nhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1745307094; x=1745393494; bh=ryAhsqI3OpG+P+DWenzrIPbKClCVON5+/0U
	rBmMSEHQ=; b=Wod//1/vV0Zr5w7Es8f50hQJHbaUdsMT5EHTApHbIggXnLJUuCI
	ViUFizWzBhpOCJsdVmxZ7yp+mrWAsWtwiiiSGYaMU0dwXmpthWo6wrpuisSYUe+F
	sp5zxZrAriA2r2R7Og4HkPqB8wwFAERGWAaqOqdXX/2Dpuz0V+4ZWwU/cVQVA070
	Ln77t+psNl43Gnh/9hwIJCED9lslK7iH5nRiuDKWaChjg9OmopTbpr39+n3psSzq
	2vfchSpQMy0HZwjSAxURlITyBVJ+IX14YA5k1DvpmmaXUqK1V0o6Wg416O3pTLWT
	jl9wAHYfBY5gHstGoIz6WFouVMWcPz80JeQ==
X-ME-Sender: <xms:1kUHaCKY4PYvKm1izd6n1EMQ63LhVL0o1KnJpB4JDFaC5lkT4La6oA>
    <xme:1kUHaKJunelrCraKUxbAyCB5x396o1oRlxFhB3vUdHCy4_ml534ez87TWmpnGDc9E
    Yo8mO2ydH8mr4BQwQ>
X-ME-Received: <xmr:1kUHaCv_JVoQo7evowly1L8AdtEsif-DPFxe_qzoKsqN8K8SoNq1tTxRR9hzArCGELDwqsJmy1iCh-1QuNwSD9aR1s8UoaLOVXZg1auV_5Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeefudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorh
    hgpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehsrghmsehgvghnthhoohdrohhrgh
X-ME-Proxy: <xmx:1kUHaHaz9U8inJyQ2YlYWsyOPLOzS1lE88EppbPSvZj3ZmFSR6kcuw>
    <xmx:1kUHaJYx5ctkRIlyqEflmr3ocIi5QOI0KgjhzSCI36iJZhg2fPS1cA>
    <xmx:1kUHaDB9UQYE1ljVj6x2yIZMSVY0uf_9u_8hyZ43J9KtJx_vJLfhjw>
    <xmx:1kUHaPb-CGIOysi6d3iNB8EABvxpqdzBztUbXvQkRjZCMbmBTI4Uag>
    <xmx:1kUHaHuX72zz1Cln_JQ-cbLwnaSYvciWdE5soDGwadLot8ZKibu4XM10>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Apr 2025 03:31:33 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fb7297e1 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 22 Apr 2025 07:31:33 +0000 (UTC)
Date: Tue, 22 Apr 2025 09:31:32 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Eli Schwartz <eschwartz@gentoo.org>
Cc: git@vger.kernel.org, Sam James <sam@gentoo.org>
Subject: Re: [PATCH 3/6] meson: do a full usage-based compile check for
 sysinfo
Message-ID: <aAdF1MvGJcqfpI4p@pks.im>
References: <20250421175247.240971-1-eschwartz@gentoo.org>
 <20250421175247.240971-3-eschwartz@gentoo.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250421175247.240971-3-eschwartz@gentoo.org>

On Mon, Apr 21, 2025 at 01:51:47PM -0400, Eli Schwartz wrote:
> diff --git a/meson.build b/meson.build
> index f5d9ffcd7f..8037e536dd 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1058,10 +1058,6 @@ if compiler.has_header('alloca.h')
>    libgit_c_args += '-DHAVE_ALLOCA_H'
>  endif
>  
> -if compiler.has_header('sys/sysinfo.h')
> -  libgit_c_args += '-DHAVE_SYSINFO'
> -endif
> -
>  # Windows has libgen.h and a basename implementation, but we still need our own
>  # implementation to threat things like drive prefixes specially.
>  if host_machine.system() == 'windows' or not compiler.has_header('libgen.h')
> @@ -1272,6 +1268,10 @@ if host_machine.system() != 'windows'
>    endif
>  endif
>  
> +if compiler.has_member('struct sysinfo', 'totalram', prefix: '#include <sys/sysinfo.h>')
> +  libgit_c_args += '-DHAVE_SYSINFO'
> +endif

Makes sense. We do have c9a51775a36 (builtin/gc.c: correct RAM
calculation when using sysinfo, 2025-04-17) in flight which also causes
us to use `struct sysinfo::mem_unit`. But I think it's fine to check for
only one of the members here.

Patrick
