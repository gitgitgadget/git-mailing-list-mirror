Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17873274FFA
	for <git@vger.kernel.org>; Tue, 15 Apr 2025 05:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744696789; cv=none; b=qM8WlmdYwY96wta36O2w5wr60g5DVL81xvdnXrsQh4s1lPAiBJLJShVrbrt6zaEX/FtwE8/sxyGwgMW88lP4WFgRlu2sCt0lKjq96iORTNKYpprxXh+frTC2ny3XjcONFHuXc+wjXEx4YZTD1G6PwLo4JX8ZZ7elDKALyXn+RXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744696789; c=relaxed/simple;
	bh=zo4C+0MquJgvCn4mHmQi48G1qviEW8FbJSOwJdjob9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aSRUhNm8kNxhsKIFRo9ZwZBEfqr2KUFHyr5+Fpjz+mJKG1/Zpm+O0Clu4N1ZHtuJiok6XbTuVhNaLRFQyjn0zpRwc5+BJHZ8X8ZZGx4JG422CDsCkyAiz3q1Wg5e82I5FA0fe2B0K3fT/ASnTLz5YLc/uxy3VahXzSTytV9SMcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kbKTESqF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EdHC7sb3; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kbKTESqF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EdHC7sb3"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8D4B911402D2;
	Tue, 15 Apr 2025 01:59:44 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 15 Apr 2025 01:59:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1744696784; x=1744783184; bh=stIoqoxci0
	o9iIQQHjCyc70ZcBlZrHtLcHQwX+2mAnw=; b=kbKTESqFCoukYdU4KtIp1sKUT5
	umBxDoCzziWK/nlxUA3uWBK4LDDlmWmD/gamOuVGpiSf4Am3LoyuLFCUanvbLIli
	uWR39hPnTOA3mNJ3DQIZkx7Ma30Ko+uPf84/TFKBvo5MD4zp10yiqp8HE3yh9DlA
	lPlpfXdQsID+8NZk0FiqCuY3MV+6zoxztCG0LabtXGBZ+Gdxmj2dg4JNDa5c9CU5
	9aMjlWxF3V29D60Nwu3mpxr2W5URopTWgBUH8g1XLIzLSRa337OpUUS47xeb3v08
	NKVigKSy9v94WlAJAglvsKuW+koUgCdtsWidA2giRyYvQI1F/FcHVeaDJSXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744696784; x=1744783184; bh=stIoqoxci0o9iIQQHjCyc70ZcBlZrHtLcHQ
	wX+2mAnw=; b=EdHC7sb3F4MMb1bT+hFx2uHBXIwSxRALGOusbsJ0F2qZYd1kjes
	Uod0zXH/PXFIyOphc1r8yFtrw73VJBWJZBWCyDREfX1BVmlFxN2ZGxUOEbxoHbMM
	ybP0QdndpDIGStlPHJz9AsSXFrrW19Tam9Rsu5I1nDNCMDN4ujOmX+ixfLXYAhE0
	/I9LH9rQjxAZ2gid9G+c3BkvIapKvzBP618syX3c+UmgtT2luLQGNwycp2wVRbIp
	b1aFLOFzTAaNT/DDAs0Cv7R7s8Q3bJLZkHlluZcenvH25x42lC83wAe603yxxgnc
	Phvjt/J0Hq+Mkyi0ClZ5T0+gUxguBVqe8TA==
X-ME-Sender: <xms:z_X9Z_IO1CuAy0GxczUAgWG3mispkRd06ZpLXjQTaQWrZyAuxulV5w>
    <xme:z_X9ZzLlxRmxYhErhXqYOJ2Y_1oRTIhalmY9aNuG0d2IbFiEix7EHPO-cwTqzTCLB
    ZgHFmWWtuoODWM0ow>
X-ME-Received: <xmr:z_X9Z3vapWI28aBQsRmxzKSNdWbGTfcy7rHDC4dbyCxbkA4qzr1LV5C0Mc6wN34Aw6Bv21gaEGgp6sHCJiLzcuCQwHYzFr3KS_PSE11NJPZrNg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvddvieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhr
    tghpthhtohepghhithesughinhifohhoughivgdrohhrghdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:z_X9Z4b0L1vRWKyevj5BLYAXREffd98svuQoS2XNts_mdj47q8UAbA>
    <xmx:z_X9Z2ZF58Rzg2f7uWvy7bP0Zvaa94f07qqdzf3xUTUIbGAptL3Ycg>
    <xmx:z_X9Z8DMwI3MYhRHazskxGtP3yDjlR4X38tabtOWmN1kA00MUuQ1HA>
    <xmx:z_X9Z0Y_qUYNjq5ZIW3Xdp1egVGKvVyk6QncgMCylTHBEpHjk849Ng>
    <xmx:0PX9Z6Tw2uTIJ0-7aepVtclfkSLixRxqIPwFbjpzJGcKICy-4iTYwHZ9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Apr 2025 01:59:42 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1bd08242 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 15 Apr 2025 05:59:40 +0000 (UTC)
Date: Tue, 15 Apr 2025 07:59:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Adam Dinwoodie <git@dinwoodie.org>
Subject: Re: [-SPAM-] Re: [PATCH v2 03/13] meson.build: only set build
 variables for non-default values
Message-ID: <Z_31noB-CAqtYOd2@pks.im>
References: <1c04882b-e518-4272-bd18-ab918774e424@ramsayjones.plus.com>
 <cover.1743859985.git.ramsay@ramsayjones.plus.com>
 <280363cd569a8c6e870107eb219597b42911fed2.1743859985.git.ramsay@ramsayjones.plus.com>
 <a5795bfa-cc02-4c9a-b7d2-4924a94cd0db@ramsayjones.plus.com>
 <Z_y_Tp5pfJ-gZLEF@pks.im>
 <7c5a2998-fe71-495f-8841-64e5b2ad03f2@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c5a2998-fe71-495f-8841-64e5b2ad03f2@ramsayjones.plus.com>

On Mon, Apr 14, 2025 at 08:19:15PM +0100, Ramsay Jones wrote:
> 
> 
> On 14/04/2025 08:54, Patrick Steinhardt wrote:
> > On Sun, Apr 06, 2025 at 08:49:54PM +0100, Ramsay Jones wrote:
> >>
> >>
> >> On 06/04/2025 20:38, Ramsay Jones wrote:
> >> [snip]
> >>> diff --git a/meson.build b/meson.build
> >>> index 88a29fd043..efd0bd3319 100644
> >>> --- a/meson.build
> >>> +++ b/meson.build
> >>> @@ -693,10 +693,8 @@ endif
> >>>  # These variables are used for building libgit.a.
> >>>  libgit_c_args = [
> >>>    '-DBINDIR="' + get_option('bindir') + '"',
> >>> -  '-DDEFAULT_EDITOR="' + get_option('default_editor') + '"',
> >>>    '-DDEFAULT_GIT_TEMPLATE_DIR="' + get_option('datadir') / 'git-core/templates' + '"',
> >>>    '-DDEFAULT_HELP_FORMAT="' + get_option('default_help_format') + '"',
> >>> -  '-DDEFAULT_PAGER="' + get_option('default_pager') + '"',
> >>>    '-DETC_GITATTRIBUTES="' + get_option('gitattributes') + '"',
> >>>    '-DETC_GITCONFIG="' + get_option('gitconfig') + '"',
> >>>    '-DFALLBACK_RUNTIME_PREFIX="' + get_option('prefix') + '"',
> >>> @@ -708,6 +706,17 @@ libgit_c_args = [
> >>>    '-DPAGER_ENV="' + get_option('pager_environment') + '"',
> >>>    '-DSHELL_PATH="' + fs.as_posix(shell.full_path()) + '"',
> >>>  ]
> >>> +
> >>> +editor_opt = get_option('default_editor')
> >>> +if editor_opt != '' and editor_opt != 'vi'
> >>> +  libgit_c_args += '-DDEFAULT_EDITOR="' + editor_opt + '"'
> >>> +endif
> >>> +
> >>> +pager_opt = get_option('default_pager')
> >>> +if pager_opt != '' and pager_opt != 'less'
> >>> +  libgit_c_args += '-DDEFAULT_PAGER="' + pager_opt + '"'
> >>> +endif
> >>> +
> >>>  libgit_include_directories = [ '.' ]
> >>>  libgit_dependencies = [ ]
> >>>  
> >>
> >>
> >> It would be somewhat remiss of me to not mention here that this does not
> >> work for any but the simplest of values! :( If you set a simple single
> >> 'bareword' like 'vim' or 'more' (even '~/bin/vi') then every thing works
> >> just fine. However, if the value contains any of (at least) the following
> >> characters: single quote, double quote or backslash, then things
> >> stop working!
> >>
> >> [I spent one whole evening (and a bit - always something else to 'try')
> >> trying to 'fix' this problem, without success]
> > 
> > Shouldn't it be possible to escape these values via `.replace()` [1]? I
> > suspect that you already tried, but wanted to ask anyway :)
> 
> Yep. :)
> 
> I still haven't studied the meson documentation, but when I searched
> for variations of 'quotes', the results showed that '... if you want
> quotes, you will have to do it yourself ...'. So, I eventually found
> '.replace()' in the 'string operations' section of the docs and tried
> to reproduce what the Makefile does (see #2382):
> 
> 
>   ifdef DEFAULT_EDITOR
>   DEFAULT_EDITOR_CQ = "$(subst ",\",$(subst \,\\,$(DEFAULT_EDITOR)))"
>   DEFAULT_EDITOR_CQ_SQ = $(subst ','\'',$(DEFAULT_EDITOR_CQ))
> 
>   BASIC_CFLAGS += -DDEFAULT_EDITOR='$(DEFAULT_EDITOR_CQ_SQ)'
>   endif
> 
> which I translated into (on top of these patches):
> 
>   diff --git a/meson.build b/meson.build
>   index 8f8a258064..608d665fd3 100644
>   --- a/meson.build
>   +++ b/meson.build
>   @@ -708,7 +708,11 @@ libgit_c_args = [
>  
>    editor_opt = get_option('default_editor')
>    if editor_opt != '' and editor_opt != 'vi'
>   -  libgit_c_args += '-DDEFAULT_EDITOR="' + editor_opt + '"'
>   +  editor_opt = editor_opt.replace('\\', '\\\\')
>   +  editor_opt = editor_opt.replace('"', '\"')
>   +  editor_opt = '"' + editor_opt + '"'
>   +  editor_opt = editor_opt.replace('\'', '\\\'')
>   +  libgit_c_args += '-DDEFAULT_EDITOR=' + editor_opt
>    endif
>  
> [Actually, I think the very first attempt had:
> 
>   libgit_c_args += '-DDEFAULT_EDITOR=\'' + editor_opt + '\''
> 
> but meson, for some reason, adds a set of ' around the whole
> -D argument to gcc, so I got rid of them - but it still didn't
> work!]
> 
> Along with many, many, *many* such permutations! (trying to debug
> this is hard work, with no help from meson).
> 
> So, just a little earlier this evening I read an email from Karthik
> ([PATCH v2 3/4] meson: add support for 'hdr-check') in which he
> mentioned a problem with backslashes and referenced a github issue
> on the mesonbuild repo [0], which is worth a read. ;)
> 
> Sorry I couldn't fix this issue, but it seems to be (in part) an issue
> with meson. (Of course the example I used, which is taken directly
> from the Makefile, happens to be particularly good at demonstrating
> the problem!)

Fair enough. Maybe I'll try to upstream a feature like this into Meson.
It would be nice to have a `.quoted()` method on `str`, and it shouldn't
be hard to do.

> In any event, I think the current patch is a strict improvement, even
> if it may need to be updated at a later date. I hope you agree.

Agreed.

> Thank you for taking the time to review this series. I think this patch
> was the only review comment that required a response - please let me
> know, if that is not the case!

Yup. The only other thing was missing spaces around assignment
operators, but that alone doesn't feel like it's worth a reroll.

Thanks!

Patrick
