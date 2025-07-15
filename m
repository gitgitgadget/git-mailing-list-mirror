Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109B11EF391
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 16:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752598111; cv=none; b=MLaWPud+ABlsjRasb4Ztd97ICgigXSmGF3Pf8DQEpyA0YCGGqvBk6+BAtpEIDFc+wGOPBkl3SdOqZ8nvRAF9HTKLhuK2eF4yyV1hYbAPm/fjeEOIewf2E4TCQxRdBNLP7+9cBh4KexElk8LrDLHfA52I/7T3dSdTxA7grc5vuxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752598111; c=relaxed/simple;
	bh=M5SD5ESv7mtgHBTbQ2FoYwwCbDCT8Qodsj8FUBujsTE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Vg+CwOvyips3dfTnpCSqXUqGsybHvh+5HO8GY3eVNZ059i1qTyitXuAfc2xpjleIIsNg79yXF70uMkRbd+GZfRw83hkeFWauZRAIcJdeHGIsFB6z+r7A4qR2IdhbHLP0LMK4DADPoRE1Yo5wYf2k7sQKrSyruUSS2iY0SD4g+bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=A9+QXR9j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fQJjiSb8; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="A9+QXR9j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fQJjiSb8"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id C7F581D002C1;
	Tue, 15 Jul 2025 12:48:27 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Tue, 15 Jul 2025 12:48:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1752598107;
	 x=1752684507; bh=yWASWCp5Ba6IECJX2FBVtQmOhObMDDPIDxmEZBPQmzM=; b=
	A9+QXR9jFNPrj4UbEXHE5hK2IcdKPlajs1WcQkXG2ZHRG9wB+jhMQD/Wqu33BAZD
	MO4IKnaz8VGf/5iue6GTSNPK1s5vsN919Up272+4IuHgl7Rg/U+wNAKGb4y2dU8x
	S+ptwVL2YR4X30KPdChLWhW9wn3Wxsgn6ysCfyjNqTkqHzCk37OEpIO/lvfCdWuG
	nXvVZtkBZ/uLa+UWGdjEEkp6iCMSW0aU6wbWP3DZ8flO05iQx1BojdRe2GVyTG6A
	FWUQvajx5Oi0HSPy5Yd4EiaivyhuSetsAsRy5qfz+RI5fmBa0ltZMYwuJArSV6fW
	LWSVJeqX+lFljyEE4KWDcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752598107; x=
	1752684507; bh=yWASWCp5Ba6IECJX2FBVtQmOhObMDDPIDxmEZBPQmzM=; b=f
	QJjiSb8n7ZyN5mhuAGWeqoIRungk78+34a6KbavC1YcAAn3PvX5GtUzUGHZkdjLK
	EHTsmZuCOO7vIvNjprgHIEXTIfxa1Q24d3uM6R6uXouz0jlFbtcMilvBTlqZdMXj
	ROx6HGCp3lIcPOggTUXC2O6MryyRiEZh3BBpxPa+I+9j/KgxIINIhU5N0/L4aziL
	CAsoTB4PmdJcWEm0SI2myd6MHpze9BAEHWDISWJrITTUWnO+LpOA/qRqKZ3FGWwV
	lh3I2O6x4IjqTe8PhQMLOjvugusASJi45l9WquhcJme1D3zaAri7Pu7CFAzTjSuk
	zqEucLrCcYeZN2oXl6/kA==
X-ME-Sender: <xms:W4Z2aCONv1l6jj6SWKRrVKux5qihzmIhiJjg1T50oaLv4nBo297xPg>
    <xme:W4Z2aJbkYw4y6l-3F_bnFUCuXpaqoDsSP42xfzLhFDo8eARtagKEN_I79ADdVy2kC
    ONyTmJQ3nG6KWpq7w>
X-ME-Received: <xmr:W4Z2aJuHHJKHCvKTlm9uHDfBQLza_LJaIxSylIwEzZN_vP-fs6SJiqQGI25vEDuvstpKXowUabnIb9GVWohJ5E7HAwW09fTSrSrQkzA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehheefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekofdttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepkefgtdeuvdejfffgheeufeeugefhtdejhffgkefhhfetieffteehleehtdfg
    hedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptggrrhgvnhgrshesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgrnhgu
    rghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepphhsse
    hpkhhsrdhimhdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrghdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:W4Z2aDPOVKtEFSEU57l_2d9quUZ7P1kjrLfCikXUQqA9tpngPvsR-Q>
    <xmx:W4Z2aI68kQSIUeVEut7D_d_-EaWPB9uOljL5xjz5gt4t35ryMbDC8g>
    <xmx:W4Z2aBRTZebHbhvRjMIKZf9iyI4oV-e51W6M_kie2Q6hwPlT8e_ZKQ>
    <xmx:W4Z2aNBbBg-NaZaLHL9Iobyx7-FJ2se548UZntexAGWqit-_1fU5kQ>
    <xmx:W4Z2aKs6yYU3J78pelNVjcULI0NhtCcQlujco-lCIDffhVYuz6fk1NcI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Jul 2025 12:48:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc: git@vger.kernel.org,  sandals@crustytoothpaste.net,  ps@pks.im,
  eschwartz@gentoo.org
Subject: Re: [PATCH v4] meson: woraround broken system PCRE2 dependency in
 macOS
In-Reply-To: <20250715114407.37955-1-carenas@gmail.com> ("Carlo Marcelo
 Arenas
	=?utf-8?Q?Bel=C3=B3n=22's?= message of "Tue, 15 Jul 2025 04:44:07 -0700")
References: <20250713174807.32444-1-carenas@gmail.com>
	<20250715114407.37955-1-carenas@gmail.com>
Date: Tue, 15 Jul 2025 09:48:23 -0700
Message-ID: <xmqqikjtienc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Carlo Marcelo Arenas Belón <carenas@gmail.com> writes:

> macOS provides a PCRE2 library in base that is not usable and not
> configured properly, as it installs a pkgconf module that
> points to a non existent pcre2.h header in /usr/local/include.
>
> Detect that case and allow a fallback to a wrapped submodule
> if the feature is enabled and that is possible, or print a
> warning and disable the feature if the feature was set to "auto".
> which is the new default.
>
> Suggested-by: Eli Schwartz <eschwartz@gentoo.org>
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---

Thanks.  Will queue.




>  meson.build       | 20 +++++++++++++++++++-
>  meson_options.txt |  2 +-
>  2 files changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/meson.build b/meson.build
> index 596f5ac711..0e480e65cf 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1055,7 +1055,25 @@ else
>    build_options_config.set('NO_ICONV', '1')
>  endif
>  
> -pcre2 = dependency('libpcre2-8', required: get_option('pcre2'), default_options: ['default_library=static', 'test=false'])
> +pcre2_feature = get_option('pcre2')
> +pcre2 = dependency('libpcre2-8', required: pcre2_feature, default_options: ['default_library=static', 'test=false'])
> +if pcre2.found() and pcre2.type_name() != 'internal' and host_machine.system() == 'darwin'
> +  # macOS installs a broken system package, double check
> +  if not compiler.has_header('pcre2.h', dependencies: pcre2)
> +    if pcre2_feature.enabled()
> +      # Attempt to fallback
> +      pcre2 = dependency('libpcre2-8', required: true, method: 'builtin', default_options: ['default_library=static', 'test=false'])
> +      if not pcre2.found()
> +        error('only a broken pcre2 install found and pcre2 is required')
> +      endif
> +    elif pcre2_feature.auto()
> +      # Replace with not-found-dependency
> +      pcre2 = dependency('', required: false)
> +      warning('broken pcre2 install found, disabling pcre2 feature')
> +    endif
> +  endif
> +endif
> +
>  if pcre2.found()
>    libgit_dependencies += pcre2
>    libgit_c_args += '-DUSE_LIBPCRE2'
> diff --git a/meson_options.txt b/meson_options.txt
> index e7f768df24..1668f260a1 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -45,7 +45,7 @@ option('gitweb', type: 'feature', value: 'auto',
>    description: 'Build Git web interface. Requires Perl.')
>  option('iconv', type: 'feature', value: 'auto',
>    description: 'Support reencoding strings with different encodings.')
> -option('pcre2', type: 'feature', value: 'enabled',
> +option('pcre2', type: 'feature', value: 'auto',
>    description: 'Support Perl-compatible regular expressions in e.g. git-grep(1).')
>  option('perl', type: 'feature', value: 'auto',
>    description: 'Build tools written in Perl.')
