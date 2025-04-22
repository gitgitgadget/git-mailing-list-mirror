Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A586B1B85FD
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 07:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745307109; cv=none; b=pfEmUWXIlvUEtcbG3iQKFWnRIUM9WvrelrqcyMuyC9rMMPVOEs9GuZ3BnRVHeM/xE823WRaOU8m5M0O8FXSidubTr5jlwNrtHI03RpH5QrANllUW/wFPDtfJfLRiLqfzi8FPNa8LM2F49woyhU4lw5SUEiuJeZmZ9hQ5Ep5bbsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745307109; c=relaxed/simple;
	bh=K1KommVWCpdg6RxC4Y8wb+HsFxckXbFmIBat+HxiObs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=byErogmkkkKm+/QNd2l2vGvHtETiL3NxgNl0GkGxPoeEam64DPzGdkOKpWxGJAFZ8SY3wmTS9HMMhcaf+ugLtLQM3ivV0lWUO2HAfCDJ/OMF1R0UuFC+5+6s6GgnCiOomsR5PkFqK68id4SMr7ac9War17URZPPEQT3Ksg2qjuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Y/pA9PW8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NTBjjTJK; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Y/pA9PW8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NTBjjTJK"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C02A825401BF;
	Tue, 22 Apr 2025 03:31:46 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 22 Apr 2025 03:31:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1745307106; x=1745393506; bh=0v0fxwhu+H
	Wy/gylJnQ00vr/aE5zTC9CGTHOwKc0ILw=; b=Y/pA9PW8YAGXEyI4oFnQ7m57Hq
	47fh6o4b+lU3PTXzByhb12DaknUanNsjYhocUyVrNOPFDsPTzDx29Izql/3Ang/i
	DtXL+lZgIOp4U3wfEqpYgUkY2VJaH+ZT4W5gQJU9jHZuyxZpRjrQDnz6fohQgDa1
	EwxpYEnkRdlZZ2vKR/SKwEeDovjTcbunv0IQ6O/bJKexGO2cwNNPwoyWTx6ehORF
	KKjbsJRhCnv1mSRx4+NMeQT3SBI2u92t664Uu3p7WDTfrjR92bcBy0HXjUfI7zrW
	PqCow/hIjXx0z0jiAMGjXL/ntZdB2uv3Cb6+/I+g97bkSqF1mNmt5huJ4KQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1745307106; x=1745393506; bh=0v0fxwhu+HWy/gylJnQ00vr/aE5zTC9CGTH
	OwKc0ILw=; b=NTBjjTJKvlJy+DvG8WkrWgcKDh6oBjkSyCpSOxoIooo+9JVInCr
	FtYlTu8XIkMEUW1laM5rqxfx2ECm9uCGg+zlVYAJfwZaKaYRNzCUvtJzLnbZNo7Y
	eqJCeGIDwAQbBvyd+ys3UADFUpxkflGkHdZpp+DTQk9hgrVY2f9zG4oaUSKY89ri
	x298VJ45fHq00Q0HS2uEljTtlpMFmoxzkDKaVapZpTdNqvyp7FUAanl49MUCJBXD
	0a5XZhWOLF+kTfWzQJt4gg7sctrxZgl6sFRtFZ9LTIzy1go7metklhHSFhT2kOy2
	JeuSr0r+/ohLyQewhiFg36xjXpXZcHAxaPw==
X-ME-Sender: <xms:4kUHaJ7IYRcRm2ttpYXDmXfaTu75kyAEoW0-2AI7fPLqNF9oLZIa6w>
    <xme:4kUHaG57fgxOykpeeam3VevoGIpkrz9A27bqiBX0DgtM6eo-35IecaVHyIktr4j-G
    uq1gMS1a-mhXv_99w>
X-ME-Received: <xmr:4kUHaAe6hxmamPRmco43nuE1nGD7x_op7CYyLQHDj_wVB4AP2Lr822KGVn_NhIZsXmnESSOApTtUVew0_NpkmoPZmLMQbxVkB3afyVYUIA0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeefudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepshgrmhesghgvnhhtohhordhorhhgpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvshgthhif
    rghrthiisehgvghnthhoohdrohhrgh
X-ME-Proxy: <xmx:4kUHaCLrQ6XKwyUfzpLcEXyMm_DdajH8LzfSdYlNU7tuOm4R7Lj2Lg>
    <xmx:4kUHaNJtx979_Z1v8Zs2o6Bbq95hGzxlodyp45PEQBiWDOv9iKVqvQ>
    <xmx:4kUHaLwKE-I6h9U6UqJgubOZwiwHR5JNvi5iq-swG7twYNu9e8VCUQ>
    <xmx:4kUHaJILrr2pwSs_PmIuDmJpPXrNWSfP7ZLjHFLxJVYp4-Hz8ajcTA>
    <xmx:4kUHaKc7p9OdhE2VUjS7jjLR15YCmOxxuER7gofB7E3mHJw76UO1FEql>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Apr 2025 03:31:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1452d8e4 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 22 Apr 2025 07:31:45 +0000 (UTC)
Date: Tue, 22 Apr 2025 09:31:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Eli Schwartz <eschwartz@gentoo.org>
Cc: git@vger.kernel.org, Sam James <sam@gentoo.org>
Subject: Re: [PATCH 1/6] meson: simplify and parameterize various standard
 function checks
Message-ID: <aAdF4DzFCZ3uOJCx@pks.im>
References: <20250421175247.240971-1-eschwartz@gentoo.org>
 <83d9fda5-8399-47fb-87b2-a8b376cf1625@gentoo.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83d9fda5-8399-47fb-87b2-a8b376cf1625@gentoo.org>

On Mon, Apr 21, 2025 at 04:04:30PM -0400, Eli Schwartz wrote:
> On 4/21/25 1:51 PM, Eli Schwartz wrote:
> > diff --git a/meson.build b/meson.build
> > index c47cb79af0..6c147c22a4 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -1322,45 +1339,15 @@ if not compiler.has_function('strtoumax')
> >    ]
> >  endif
> >  
> > -if not compiler.has_function('strtoull')
> > -  libgit_c_args += '-DNO_STRTOULL'
> > -endif
> > -
> > -if not compiler.has_function('setenv')
> > -  libgit_c_args += '-DNO_SETENV'
> > -  libgit_sources += 'compat/setenv.c'
> > -endif
> > -
> >  if not compiler.has_function('qsort')
> >    libgit_c_args += '-DINTERNAL_QSORT'
> >  endif
> >  libgit_sources += 'compat/qsort_s.c'
> 
> 
> ... for example, the Makefile says here:
> 
> 
> # Define INTERNAL_QSORT to use Git's implementation of qsort(), which
> # is a simplified version of the merge sort used in glibc. This is
> # recommended if Git triggers O(n^2) behavior in your platform's
> # qsort().
> 
> cmake unconditionally defines it (???)

Our CMake build instructions shouldn't be treated as canonical source of
truth. They're good enough for some usecases, but they are not as
feature complete as any of Makefile/autoconf/Meson.

> config.mak.uname says:
> 
> - AIX:
>   INTERNAL_QSORT = UnfortunatelyYes
> 
>   Seems to date back to commit 377d9c409ffe0f0d994b929aeb94716139207b9d.
>   "Unfortunate" indeed.
> 
> 
> - MinGW:
>   INTERNAL_QSORT = YesPlease
> 
>   Windows claims to have a qsort but perhaps it is very slow and bes
>   avoided?
> 
> We should probably stop *checking* for qsort and simply encode the
> platforms we know are slow and automatically skip it there. Can I get
> confirmation regarding Windows? :)

I'd rather prefer to try and detect this generically instead of adding
more platform-specific configuration. It is way simpler to maintain, and
if we ever see that things don't work well on a specific platform we may
still reconsider at that point in time.

> > -# unsetenv is provided by compat/mingw.c.
> > -if host_machine.system() != 'windows' and not compiler.has_function('unsetenv')
> > -  libgit_c_args += '-DNO_UNSETENV'
> > -  libgit_sources += 'compat/unsetenv.c'
> > -endif
> > -
> > -if not compiler.has_function('mkdtemp')
> > -  libgit_c_args += '-DNO_MKDTEMP'
> > -  libgit_sources += 'compat/mkdtemp.c'
> > -endif
> > -
> > -if not compiler.has_function('initgroups')
> > -  libgit_c_args += '-DNO_INITGROUPS'
> > -endif
> > -
> >  if compiler.has_function('getdelim')
> >    libgit_c_args += '-DHAVE_GETDELIM'
> >  endif
> 
> 
> But stuff like this, why isn't it consistent with the other functions?
> What's the difference between HAVE_XXX and NO_XXX?

Inconsistencies like this are what you get in a codebase that is 20
years old. Many things have grown organically, and one hand doesn't
always know what the other hand is doing.

I agree that in the best case we'd unify these. But unfortunately, this
is not trivial because those are part of the build interface for our
Makefiles. People may have `HAVE_GETDELIM = YesPlease` in their
`config.mak` file, and we don't want to break this usecase. So if we
were to change this in the future, we'd have to also introduce shims for
backwards compatibility.

Patrick
