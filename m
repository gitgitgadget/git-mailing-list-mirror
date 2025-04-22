Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FF31EB5FF
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 07:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745307106; cv=none; b=EP750cbkwu6BSN5Ag+CfoEn5vTnKsZKmODykBWS0GrFmHPQwtaNgjn5JauloKErAUl3hor9w9d+1BRLzi/uEH8M1jOWRxSeOVHdeBBN/xylm4xzZktDDjQDTwEPyg06TP9Po+PRu7W0FHUntWaMCGthDWVhAOHbRB8NQRx8TA58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745307106; c=relaxed/simple;
	bh=PGLVFWYHNjMluR8PoFm1pKShPwUXmFTjOi+tkwms3No=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uZiEGzDguLb6Z/1WAIidlyGr44tb2107eQu9xiFel+2Vo+lT0ZlPB7c7+RXWTPkVdlUYMc7oN6n7kreY0cV3Omu7J0URHyNdghIUzq96KMOP23qlJxZq846i05ScPP01wly+7a4bVlfKiKaxlElD5jcNNLZ9m21kciWiJrUalM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=H8bYFl1u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QJBc9OJy; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="H8bYFl1u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QJBc9OJy"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 616F625401BF;
	Tue, 22 Apr 2025 03:31:44 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 22 Apr 2025 03:31:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1745307104; x=1745393504; bh=jL85/P5dyp
	OTc+iC4Cgg4RLlZA+ps/xu18we3Udolck=; b=H8bYFl1uB9heTmPqPhrw2crLlP
	gJdrwoiXH56OzTS7y69roZ1cCfNeWRsWt2svnQR9ftyUlzHtTs5bBsI9JHn6AQzV
	E52jYABovyHFeBgj3nR//9+wJku0H8I1ti436apGGzj6ldBZVl+UU9Q7KZYIxsNr
	xssWOofuAJmv3+J2se8ANNLwf7EEnl/5Cvn0jgb7BMwdagjlEwPcA/wUwvqRM5/h
	YGgfQjQBpSGWpTCGSct3d8GqE4IgF93CF9N329tydnGFdcHE4YmEkezgUa6/pKcT
	06AeoF4pp52jrk/QwregetSjDD7EDIUf0jHr4trzrvTM3TtLsmunaPD2XZJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1745307104; x=1745393504; bh=jL85/P5dypOTc+iC4Cgg4RLlZA+ps/xu18w
	e3Udolck=; b=QJBc9OJykWx3zScLLwHqMbdOUSWrHlxzzStjey4SAKw2QQsFdhB
	7b7xu6Yl7OTDUfnCvlCe5O9Oq6fE+n5/Z4zSdz0aUF7dZuueliVLXCbgUkgaZdcP
	UvdgZl5CcTmnaubc4ujDgABqr4gcFWfeSknsj41meAX8jzASfEqko4QAfWmpY/Ks
	5TP2T5wUck1lACsQIqC6zfYXqxxhLwx7DC5rU/GEjA9JWW/pEdbDqwb2x9Z24UDm
	8ftHQ/ZRP8C7j6lBqtspUvGIUb2QS6/cXK8ATpkwNrETSh6nreoBbjwSX5+kmX44
	ICvDi9l0IbLxrAlW9NQDVFQuFH9x1WOTXug==
X-ME-Sender: <xms:4EUHaGozcIuSsduwV7vqMjjn7beYcWK2Kgc2M5L9_VWEmKER0rRbPA>
    <xme:4EUHaEo8pcZOvY4iYuoJ7yy5jODjDg25xu2SiNh2SdBwc2bYf2DS90MjKbxkkC_Dc
    mCaD_BO_4HV82LS6A>
X-ME-Received: <xmr:4EUHaLN_HcDlC94gs2iJoapPfZ5ZUI4uJU5o-AKvFk79qoQAt9xL5ZhL49q5frQn37XUIIBz_N7-3nXxqjDhcbln3PazvmYJnepdIlhzz2o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeefudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepshgrmhesghgvnhhtohhordhorhhgpdhrtghpth
    htohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:4EUHaF6dMYXDxQHmKyEX7vzJYz9ix7jIU4-cMNQ5EbxQYOtn2v8lOA>
    <xmx:4EUHaF45bhwRUeDfVAegzQDfAaKIagRhc4Zy110vHCmnhihBy_EhJQ>
    <xmx:4EUHaFh9BwpFC0Y1nEKyH6kwmbtjgX1bkj5Nq52nnEMbf6cKTivtOw>
    <xmx:4EUHaP7_ik9n89RTHkeAAESYM3HlhfIa4ZVzwbU0cHuvEaanAn2MAA>
    <xmx:4EUHaGNgJVrR4ef-hwkDmtbteJga_gvSwWV6oAhhwEVf8m4UgNNc5BDm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Apr 2025 03:31:43 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7489aec9 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 22 Apr 2025 07:31:42 +0000 (UTC)
Date: Tue, 22 Apr 2025 09:31:41 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Eli Schwartz <eschwartz@gentoo.org>
Cc: git@vger.kernel.org, Sam James <sam@gentoo.org>
Subject: Re: [PATCH 6/6] meson: only check for missing networking syms on
 non-Windows; add compat impls
Message-ID: <aAdF3eu1heCycaLJ@pks.im>
References: <20250421175247.240971-1-eschwartz@gentoo.org>
 <20250421175247.240971-6-eschwartz@gentoo.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250421175247.240971-6-eschwartz@gentoo.org>

On Mon, Apr 21, 2025 at 01:51:50PM -0400, Eli Schwartz wrote:
> These are added in the Makefile, but not in meson. They probably won't
> work well on systems without them.
> 
> CMake adds them, but only on non-Windows. Actually, it only performs
> compiler checks for hstrerror, but excludes that check on Windows with
> the note that it is "incompatible with the Windows build". This seems to
> be misleading -- it is not incompatible, it simply doesn't exist. Still,
> the compat version should not be used.

CMake only checks for `hstrerror()` though -- it doesn't check for the
other functions at all.

> I interpret this cmake logic to mean we shouldn't even be checking for
> symbol availability on Windows. In addition to making it simple to add
> compat definitions, this also probably shaves off a second or two of
> configure time on Windows as no compiler check needs to be performed.

I dunno. In this case I'd lean towards just using the check on Windows,
too. The less platform-specific configuration we do the easier the build
system is to reason about.

> Signed-off-by: Eli Schwartz <eschwartz@gentoo.org>
> ---
>  meson.build | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index 1b7e55756b..24b304fb57 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1088,11 +1088,14 @@ else
>  endif
>  libgit_dependencies += networking_dependencies
>  
> -foreach symbol : ['inet_ntop', 'inet_pton', 'hstrerror']
> -  if not compiler.has_function(symbol, dependencies: networking_dependencies)
> -    libgit_c_args += '-DNO_' + symbol.to_upper()
> -  endif
> -endforeach
> +if host_machine.system() != 'windows'
> +  foreach symbol : ['inet_ntop', 'inet_pton', 'hstrerror']
> +    if not compiler.has_function(symbol, dependencies: networking_dependencies)
> +      libgit_c_args += '-DNO_' + symbol.to_upper()
> +      libgit_sources += 'compat/' + symbol + '.c'
> +    endif
> +  endforeach
> +endif

We do have compat sources for `inet_ntop()` and `inet_pton()` indeed, so
adding those makes sense. But we don't have a replacement for
`hstrerror()`, so if that function wasn't found we would error out
because "compat/hstrerror.c" wasn't found.

Patrick
