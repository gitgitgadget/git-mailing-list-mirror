Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0491B85FD
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 07:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745307093; cv=none; b=EUkBMF827EzW1Cm/EpEFd8RtpdSVf9ZlO22KlBd+J9ez+gBZrHCF/SBCnbvqlAfyYQSjHQHOOFl7crXvBEQFxxABQoXzLGxq8A8XMMDFMv5BM3t+K/KKLtk7InyrGDvPqLWurAC9hkU54tmT+vB8w7xk51vxSu6fSqxIdh3wh+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745307093; c=relaxed/simple;
	bh=2xrhcSpr3ETJ8+7vW2Wo8eCL+v+wxBxW8PWGOccbGo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MGtpRBQ5WsHw8pXrp7dQ1QLblZ4Ri5w7GGALgraC/1lmKmEqwil2VsJlAfe3kTLf85R9hhBYPcbuxU5uJeorTvovVa1Fq2Ko7PoRlzjVR0P69QnD6/bvjespdQ+rOEf1FiH0wT8z0qfQ584GK4RwzAgrkdDKj/erpFXDQ7jfFFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DJ+1txQ4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sj4akg6x; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DJ+1txQ4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sj4akg6x"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2F4DD25401BD;
	Tue, 22 Apr 2025 03:31:30 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 22 Apr 2025 03:31:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1745307090; x=1745393490; bh=fqQkJ6G2xI
	BJlFAACv00fjwUoIMzNbzGcVzKn49W7LY=; b=DJ+1txQ4V5YiKh9/JpzNT34JfM
	D11k58iahF2LBoUB/bwx/oeMzNwfKv4RLkBgCT0fG8Vu/U2ffQfQNqc6JKMPHgT5
	+bIoPFhH6AoiN9SAkK6W8fCr7n37xmU3UgMOsHavDYWXY/zzD191n92QiwH4kt59
	+yUFLOqJ1HatW6lOMiyD6XBEhb7LvhTAlHK+XgKTIYBCSzA34SRh8Ohbkvi0YFC3
	31tVF2xC+EMBxD/AIfB5HhEATtl6wfIXQ5RiESv4gETwaoJyeAL4YyYB4XUEVwUW
	KpaMmsdUWmiFWd5Rbfy5VOwVruuPwmnSOAklieV0910JH0MTG+ARqk8o7YXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1745307090; x=1745393490; bh=fqQkJ6G2xIBJlFAACv00fjwUoIMzNbzGcVz
	Kn49W7LY=; b=sj4akg6xWB0+QDhMlc69+zQRjqKg6hUSDQGyKtXTO6nhyvkkwrK
	TAQwNzWzJvUcAgh9WymC5mAtyaUhKa3dFG0AF2aehR6pT+muQj01rhUjS6KvnXPt
	g9+Mx2nPMkTeV39rMkE3VuyO/62FCyQfUwvt4msg1ZvCCWvRi+LrEGu/VGvwvg31
	+m+m/7IIg9szlLJbuPuVkx7C9hoM93t/VhtOWSTyI5xSjyTyTVCipG9ZhVq8tjeo
	BVZM+Zki2k3Ua1X+U84eqbMZTjz3djja55cZd2fAQ2fGO1qMjkTZEgUiIP4ThYRP
	jkiMDJiIim8qFj+YaQgnITvWOw3BemVPrNA==
X-ME-Sender: <xms:0UUHaOLuC_KlBwtTeZFmkR_4FxFxttzXv90FOJSsvHx9St9TKx90gQ>
    <xme:0UUHaGLeAUR1EvpUXvBilyNXe9YTm6PurpQ3q_X7DM8sQk-gr1orS7wRsr-CoNjjR
    iZAvGC8dDh3RHC5Aw>
X-ME-Received: <xmr:0UUHaOsTUJhlAoESuJ_v1EDvjPRD3CP8700m-SqZHyPD70HQFe4w3c4H8A9TpPj6yyBsK-ZQjxrNs1n-zhs8se7dh1awm_8u_6KBOSwWG-M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeefudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepshgrmhesghgvnhhtohhordhorhhgpdhrtghpth
    htohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:0UUHaDYJhTcQh8yDd54fjW6NcmW7MuyVeCTT2-NHARKsm0_AKHX4SQ>
    <xmx:0UUHaFY097e2kPLhPPgfYDBbvSrowdYQ_liVscEYiRLwrB6TY41JWw>
    <xmx:0UUHaPAodcEZqufWfqkvTLPNFcxhs9EyaJ2ShwRRdEgJf5LNfo1s9w>
    <xmx:0UUHaLafh_HEEH0EDGAwvYimCU_lsBB88V0ieJP5ykD5jaAdJ7SFlg>
    <xmx:0kUHaDvVGkSGfT_InJTRodJ6dioNDoKR0XM2Dv84GWYJgdd3vxSW4au_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Apr 2025 03:31:28 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 309fdabf (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 22 Apr 2025 07:31:26 +0000 (UTC)
Date: Tue, 22 Apr 2025 09:31:22 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Eli Schwartz <eschwartz@gentoo.org>
Cc: git@vger.kernel.org, Sam James <sam@gentoo.org>
Subject: Re: [PATCH 1/6] meson: simplify and parameterize various standard
 function checks
Message-ID: <aAdFysi-n_5Aa4Au@pks.im>
References: <20250421175247.240971-1-eschwartz@gentoo.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250421175247.240971-1-eschwartz@gentoo.org>

On Mon, Apr 21, 2025 at 01:51:45PM -0400, Eli Schwartz wrote:
> This is repetitive logic. We either want to use some -lc function, or if
> it is not available we define it as -DNO_XXX and usually (but not
> always) provide some custom compatibility impl instead.
> 
> Checking the intent of each block when reading through the file is slow
> and not very DRY. Switch to taking an array of checkable functions
> instead.
> 
> Not all functions are straightforward to move, since different macro
> prefixes are used.

Yeah, this is somewhat unfortunate indeed. I think in the long term we
might want to unify our approach so that we consistently use e.g.
`HAVE_SOME_FUNCTION` or `NO_SOME_FUNCTION`.

> Signed-off-by: Eli Schwartz <eschwartz@gentoo.org>
> ---
>  meson.build | 73 ++++++++++++++++++++++-------------------------------
>  1 file changed, 30 insertions(+), 43 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index c47cb79af0..6c147c22a4 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1290,23 +1290,40 @@ if not compiler.has_member('struct passwd', 'pw_gecos', prefix: '#include <pwd.h
>    libgit_c_args += '-DNO_GECOS_IN_PWENT'
>  endif
>  
> -if compiler.has_function('sync_file_range')
> -  libgit_c_args += '-DHAVE_SYNC_FILE_RANGE'
> -endif
> +checkfuncs = [
> +  'strcasestr',
> +  'memmem',
> +  'strlcpy',
> +  # no compat
> +  'strtoull',
> +  'setenv',
> +  'mkdtemp',
> +  # no compat
> +  'initgroups',
> +]
>  
> -if not compiler.has_function('strcasestr')
> -  libgit_c_args += '-DNO_STRCASESTR'
> -  libgit_sources += 'compat/strcasestr.c'
> +if host_machine.system() == 'windows'
> +  libgit_c_args += '-DUSE_WIN32_MMAP'
> +else
> +  checkfuncs += [
> +    'mmap',
> +    # unsetenv is provided by compat/mingw.c.
> +    'unsetenv',
> +  ]
>  endif
>  
> -if not compiler.has_function('memmem')
> -  libgit_c_args += '-DNO_MEMMEM'
> -  libgit_sources += 'compat/memmem.c'
> -endif
> +foreach func: checkfuncs

Our current code style puts a space both before and after the colon.

> +  if not compiler.has_function(func)
> +    libgit_c_args += '-DNO_' + func.to_upper()
> +    impl = 'compat/' + func + '.c'
> +    if fs.exists(impl)
> +      libgit_sources += impl
> +    endif

I think this is a bit too magic-y. An alternative might be to have
`checkfuncs` be a dictionary where the value of each function is the
compat sources that we fall back to.

Other than that I really like the simplifications introduced by this
patch, thanks!

Patrick
