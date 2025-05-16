Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32195288DA
	for <git@vger.kernel.org>; Fri, 16 May 2025 05:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747374331; cv=none; b=lvV4Oaxj4mrQC1UPLwrHeIpCDkfxLYs5HYQY64HxWjrLPEsqJ0uTxkXVFfi9lInuJXGQJxVKOCP492krsOHy7CCTPK2RDJSzRLMLeUTzHdkFGF2yE1VrU/H69Oy1qll2e2cBo5XQvj6iaQQy6YtHWHf0OVfgA4XP0uhyFE3sj5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747374331; c=relaxed/simple;
	bh=gOaY34EL+tFBhl15mj6G+8iHGzio/xdzQTVGEojNWzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R9cYIieLN1F6Q2GzttAfjo7rrZ01wlMzyfdzdnwBRWSsSmDcN7wsBv22BayQPCUwUV2lVg0R5U7mikQlck3eOfjnrMVueuWXN+qxSyMCMaW/BZMXVTCGuL7XiRh52cfirxR3uM2jfTTAnHaRKgsWxGGZByTo2dm7G7rOSoc9R1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GVG+ZTlT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jaiyPkPy; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GVG+ZTlT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jaiyPkPy"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 3E18D13803DB;
	Fri, 16 May 2025 01:45:28 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 16 May 2025 01:45:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1747374328; x=1747460728; bh=XR/hDrBBrY
	d14WfTAxWGhNxaeH8GZqWg46Ryledkynw=; b=GVG+ZTlTfegTWyy5Wh7GwdSzYo
	XmswlvVcZyaRkLgzGN2HZy6rYLm0+RSwR0XVbr4L2nzldjxlPsqze3NHOn6L50Xn
	dA3L3BswAxWRDuBbiqhYTMElMaBOAC3ynDxlNYxAESJNeOoT2eKAoi+s+gG1ce2v
	zq6znztV+DnmwguPCmIY2g4fIpDHE5El+Gy4+0Eoy2FF7TJfTyQ/fEUJUjQEmDaC
	4D9/Ox/VNLkJ6AJr7+xqSkeLxc5YwljfI2OHJdLncgDA3zhHmFxtMn/5KdJkXPAD
	I9GeXNbbOYWaX3Uslt66qDl3pavNY8PvTziR673+WtzunCrpdV6BYOGP73Ew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747374328; x=1747460728; bh=XR/hDrBBrYd14WfTAxWGhNxaeH8GZqWg46R
	yledkynw=; b=jaiyPkPyr55zdgQ4x3c96U4nzp5XH1Dmr3t0Z7Kq1PAOHfse4N+
	nGrR1ovo1fKvR8IZGYa1lm+PBCq1rnsF8la9W56B55DPf1BKhtrZZzxTolSuXPTh
	JHTxRSafI5ZUbAP5+N9jFrjVNNr6RZ70Q1uVNlDli56uHwtO7WjDn+Cdvaz5Y12X
	zc2ZKwfvUc09QPY/pTjl3+LFPpckPUlS8vhyDkCQkGLHb562fM2UXyt53eoX/m91
	3PTqm2SDPhVCS7Cywt+UmA4yj0nieFePB0zNX3W1ZsUOyQfMnycAbfEr316Rx19E
	v2H7HDxogcquEjk3Myj/JpRSg3Y+Sxyz5/w==
X-ME-Sender: <xms:99AmaFgUeXLKl1FlLkNqnxxsZ0IYVeIOzRgRCvWMYk768Y7PUIyqMA>
    <xme:99AmaKDV6t4MXPspH7grt6d8ufChm3Rocyv_2JdyidKNoSZbaMdwgENjAGZLRVTQq
    q8azy0sPK0aMnEKRA>
X-ME-Received: <xmr:99AmaFENy4wmU_sr12IZ0Kz29tPT11ZHmugxMAiCnWFOthquMu5KkH0dkeWf_OHZRgL2apBJsJQ_LFIRR7TiQYSfYJo5Ig9bHZDP1a6k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefudduleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthho
    pehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthhtoh
    eptghonhhguggrnhhhqhigsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:99AmaKTd-ilUHgw_ABdyg6tXd05MRQVc_7ZGA7R6RxiED2Rs71hxng>
    <xmx:99AmaCx7ZQrr7Zi_CPC4eLrGGnS6fyIiOMy-wzmh88ONqlN5EMGp7A>
    <xmx:99AmaA6WVc88haR_4on63vPkCywlphzZp-BE9D6GiPnbsIAZiaSdEg>
    <xmx:99AmaHwJxxdWgVMQwYCkUz8qT8Gxu9ArPMveBaY4jB57cTDwz0k5Tg>
    <xmx:-NAmaOjmcaYQ7kQMKFijanZffCpPxcfUgHid4PwgYCMmhrRA2HMug55c>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 May 2025 01:45:26 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 709e2643 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 16 May 2025 05:45:25 +0000 (UTC)
Date: Fri, 16 May 2025 07:45:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: 'GIT Mailing-list ' <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Eli Schwartz <eschwartz@gentoo.org>,
	=?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh <congdanhqx@gmail.com>
Subject: Re: [PATCH v2 3/5] meson: correct path to system config/attribute
 files
Message-ID: <aCbQ9OX2vqF82au8@pks.im>
References: <20250508164443.1506440-1-ramsay@ramsayjones.plus.com>
 <20250513191739.1513460-1-ramsay@ramsayjones.plus.com>
 <20250513191739.1513460-4-ramsay@ramsayjones.plus.com>
 <aCQdznsNfaIeSPDI@pks.im>
 <a163d515-2e71-4a42-b843-26d5d2ccdc59@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a163d515-2e71-4a42-b843-26d5d2ccdc59@ramsayjones.plus.com>

On Thu, May 15, 2025 at 05:42:00PM +0100, Ramsay Jones wrote:
> On 14/05/2025 05:36, Patrick Steinhardt wrote:
> > On Tue, May 13, 2025 at 08:17:24PM +0100, Ramsay Jones wrote:
> >> diff --git a/meson.build b/meson.build
> >> index 48f31157a0..7f811030bd 100644
> >> --- a/meson.build
> >> +++ b/meson.build
> >>  editor_opt = get_option('default_editor')
> >>  if editor_opt != '' and editor_opt != 'vi'
> >>    libgit_c_args += '-DDEFAULT_EDITOR="' + editor_opt + '"'
> >> diff --git a/meson_options.txt b/meson_options.txt
> >> index 8547c0eb47..ff877e67ce 100644
> >> --- a/meson_options.txt
> >> +++ b/meson_options.txt
> >> @@ -3,9 +3,9 @@ option('default_pager', type: 'string', value: 'less',
> >>    description: 'Fall-back pager.')
> >>  option('default_editor', type: 'string', value: 'vi',
> >>    description: 'Fall-back editor.')
> >> -option('gitconfig', type: 'string', value: '/etc/gitconfig',
> >> +option('gitconfig', type: 'string', # default 'etc/gitconfig'
> >>    description: 'Path to the global git configuration file.')
> >> -option('gitattributes', type: 'string', value: '/etc/gitattributes',
> >> +option('gitattributes', type: 'string', # default 'etc/gitattributes'
> >>    description: 'Path to the global git attributes file.')
> > 
> > I'd prefer if we documented the default value in the description.
> > Otherwise it is impossible to discover it without having a look at the
> > sources.
> 
> Hmm, but how do you get the description! :)

[snip]

> The only way I have found to display the project options to the user (after
> configuring the project) is using 'meson configure', thus:  
>   

Yup, that's how I typically do it.

[snip]
> Also, looking through that list, other options which are similarly specified
> to gitconfig/gitattributes don't have their 'default' noted in the description.
> Why make an exception for these options?

It's not so much about one being exceptional, it's rather that I didn't
think about it for the other options. Ideally, we'd document the default
for all values where we don't have a hardcoded one.

> Is this what you wanted to see? If so, then I can submit a v3 with the
> above changes. Just let me know.

Yup, the diff you had looks exactly like what I expected. Thanks!

Patrick
