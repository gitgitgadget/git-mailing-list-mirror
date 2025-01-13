Received: from mx2.freebsd.org (mx2.freebsd.org [96.47.72.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99ED1BBBF1
	for <git@vger.kernel.org>; Mon, 13 Jan 2025 20:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=96.47.72.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736799480; cv=pass; b=GFFH5grh0DKnSwoZtafDwUVugYQFsNI7DW59LqlbvBz/lNRaNiP6Z4UKJPGBO0KrdhTBxEwYAvDrEyI8Qhn8oZ46YvvKQ3j65Oe4IflHeoYUX4SzQjyQ00M2UiuQI59YmXoSyM25pbfC35uGM3uyaqkDa+FCff94E6pFRSd7DMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736799480; c=relaxed/simple;
	bh=Pas9PgqPImo2ZaIQN8RjM4GGGsx1Riis4+KiUGk9feQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L1rgRLx9u2DUUeTIDGvkiG71bkw31LVbXvoUyidAFxY5mi5BI1bZbEqJOXY/8UgtZ9HemsYmdxa4MOCUPWksrVlCg22acYicEAzq/euLPegJ+rZEpYsG20gDNc4KRk7xHiVf1aKHYI0Rv9z55bH5lOBI+UZr0cfKKH6Bb8qhfNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=FreeBSD.org; spf=pass smtp.mailfrom=FreeBSD.org; dkim=pass (2048-bit key) header.d=freebsd.org header.i=@freebsd.org header.b=bMAF4emu; arc=pass smtp.client-ip=96.47.72.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=FreeBSD.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=FreeBSD.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebsd.org header.i=@freebsd.org header.b="bMAF4emu"
Received: from mx1.freebsd.org (mx1.freebsd.org [IPv6:2610:1c1:1:606c::19:1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits)
	 client-signature RSA-PSS (4096 bits))
	(Client CN "mx1.freebsd.org", Issuer "R10" (verified OK))
	by mx2.freebsd.org (Postfix) with ESMTPS id 4YX3Tw52gmz4MwZ;
	Mon, 13 Jan 2025 20:17:56 +0000 (UTC)
	(envelope-from garga@FreeBSD.org)
Received: from smtp.freebsd.org (smtp.freebsd.org [IPv6:2610:1c1:1:606c::24b:4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "smtp.freebsd.org", Issuer "R10" (verified OK))
	by mx1.freebsd.org (Postfix) with ESMTPS id 4YX3Tw3gVXz3cvT;
	Mon, 13 Jan 2025 20:17:56 +0000 (UTC)
	(envelope-from garga@FreeBSD.org)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org; s=dkim;
	t=1736799476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=v1BH1Co2CDs6wlGa0PUP7ROHY44sZGUr94syBTo+uEs=;
	b=bMAF4emu+WaRYyu6bVwb9Pikw0D/3Emm9lhZ5ay15euI8Zdj4U7BOG9EVTqxxSq6Uwf8vu
	TOAjrlbEX3Qq9kvpFDGN/NiSVTM2JEL+dFTxVORRqL3F/cND9rv5aLfgTvDWUIpHCBSS9A
	lr+vFDUwF3iFoMn4KJNjgEa6whWEU/xTYHI4WRtV0Xt3se88aOlQsEWCZnvP9u6KUIrkbd
	Uc3GVp/Smbv8TgNnCfH+hj7dxtI1JquH/unSYN/+bmOwHLXF7wpZJ3KcTzfnOQEMg+ZC2A
	Rhg9Mb/FKmAoHAd0Bb0nbXV3ycvQz1gvOIlNRyq6res43S7D7Jr1HDQ8V0A0LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org;
	s=dkim; t=1736799476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=v1BH1Co2CDs6wlGa0PUP7ROHY44sZGUr94syBTo+uEs=;
	b=VWBNWU8/1j8qdo3kR70vxkj7pp8Ll+5UgX2DSXAl4Ez5u37ojlNqYuII9Ar5HUGS1fi0BM
	2FCkbRp29FwgR0dxf3OSD0WcIiJpCvumeXQK8J27iava9tktQOxbEW5zTpEXGB8PygIykX
	uKO7jJtlc0QDBocQ3jvvbTUPrNleh5qLpQudGH/k1XgQQ1a+OSbAYA4vUc3j7cG4qUWYGf
	r9WoYlQQLRNcb+BQD1Bpa8B04Sh7Q+2DWp10btHkJo3rOjvG6QK/W89ixAHegdzjvboj8f
	iCqZQYXCiIjNiH4QZ5qA8kUUTCem04JhqzI7GoXq+qHUG75tGMMvHbwg/50GUQ==
ARC-Seal: i=1; s=dkim; d=freebsd.org; t=1736799476; a=rsa-sha256; cv=none;
	b=FnMULSBVzDiEfhSf09C7R/B4C8sTk6IY3L8s+2UgkGmiX1jBkvFu8Eb56At0xx7trBzyoP
	TBneScnS4PqqwQMwd9J+U0srY9cKla14ttwkFIjrhcTLhpgIENKYrjhejrzK29IfRIFAJo
	sN5DYO/9AHCFEqjQY1vbu4yREVVBK4xrfslr6N4h6vKekvs0Xc/alB+HFWb3pRQsYWcgrk
	erB7Jl5bSBJX8sRdwtZcsybL12uoPdDV+2+ZquUWMMdRRfiviEQMdAUM41A7JdqG0TtYL2
	/J0Az5q7CkGxAAxCX/IvO3uBdIBWTc9V3qeZMvzhOQLSxYXSJJp7+VOhxgGSoQ==
ARC-Authentication-Results: i=1;
	mx1.freebsd.org;
	none
Received: from [IPV6:2804:f1c:8d5:8400:ec84:24d8:6841:afc0] (unknown [IPv6:2804:f1c:8d5:8400:ec84:24d8:6841:afc0])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: garga)
	by smtp.freebsd.org (Postfix) with ESMTPSA id 4YX3Tt30q3z4rM;
	Mon, 13 Jan 2025 20:17:54 +0000 (UTC)
	(envelope-from garga@FreeBSD.org)
Message-ID: <8060f2fe-2749-4d31-b913-5453155a8063@FreeBSD.org>
Date: Mon, 13 Jan 2025 17:17:50 -0300
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v9 06/23] Makefile: generate doc versions via
 GIT-VERSION-GEN
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>,
 Eric Sunshine <sunshine@sunshineco.com>,
 Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano
 <gitster@pobox.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
 Taylor Blau <me@ttaylorr.com>, David Aguilar <davvid@gmail.com>,
 Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
 Christian Couder <chriscool@tuxfamily.org>
References: <20241125-pks-meson-v9-0-1c6cf242a5f1@pks.im>
 <20241125-pks-meson-v9-6-1c6cf242a5f1@pks.im>
Content-Language: en-US
From: Renato Botelho <garga@FreeBSD.org>
Autocrypt: addr=garga@FreeBSD.org; keydata=
 xsBNBGStavwBCACjNlp/9+Y+VFe9ieR2h/WWbdvjz4Mb2z/f22bGoaskzCfvVNbo/v3i34I9
 H6OdgZkGqheQEAD2jNfRbmPr4z40xDMUpYGLds+1Mvg7G3Hms3j5Ef8KaLSWUNWIfwKdfSVR
 Qs35ccSJxAdRW5YdI6J3xZgika+3Bc4eJ05YE/nWW+PNTYevt5rqD50N3zybVYIcLoqVPpBi
 AZE/sf5SLiLACIJb1t/s4x+pi8vgWevxVVT9u8V1f8zYErmHSLSqjxii0B3eRZphX9NCJOv9
 +tfFZhnENInhn9gT7H4e2YumUltEy3jacONHJF3CC1pvvWEa6lEyypclMOkHQwNON7DLABEB
 AAHNLFJlbmF0byBCb3RlbGhvIChGcmVlQlNEKSA8Z2FyZ2FARnJlZUJTRC5vcmc+wsCXBBMB
 CgBBAhsDBQkFo5qABQsJCAcDBRUKCQgLBRYDAgEAAh4FAheAFiEERL7Dxegbnh7xTiQ5Ob6P
 xxJcZXoFAmSta78CGQEACgkQOb6PxxJcZXrYlggAgaZmr6c1yIWzN8VksHrHpwt/uxONEP+h
 ljy3yfrMsgfS5wx5Uzgfih1xYZUFC6jiI63CetqBqJpp3g1klRS1UWYKx2NeXphDMYZEdPm/
 a6sXh4bKZbk6IE8Yn0/YiRT57d9DtbvswC7Gn7Igj/MSbhl49TvTGyvuB6juaffVoYZViomx
 5zMoee8Ml2o2qj3MrCJ+/K8GU54RlpOGqGRsqdwVdr9XEWub6fF2YFwR46cjmbiU3P5urFHH
 nkJlBGPIwKxHimTW0lZsdx9aCKRDd/D80/WOEzXmk3k8B9lv/GsvOluHmveLhJG1R1tIJ31I
 f2q8dfTvqsQXnu8CcWRcgc7ATQRkrWr8AQgA1DufoxScA+CWQbUR6zExIu8wXQKrhuRt4DG2
 BgynT7EMUvEBadcbQRZXsBpemNfncc9Axyut/+rWiyKJf9BLQuo/9QYmSRvW1U6+0LJUYmdg
 kMyBeYaPk+vnssv/u9jLuvV7FVgyE0yk1iaWIKOVDD+XrQCOvGw9uSceBrQyCyo3A/eRM/+p
 vnDCaywR63PKE+3axk6lfNdGK3TnaWmS30/ZDCZlNsXuqprqR4JdT5wXids5o36dsuJ5EZ20
 s5hNMD34s4Yr1Y1R9elH6qBsFCpozs0+jwrArxq+UJJCR6hH5W8ZEwJtRC8tzR8mRE1WywzX
 BXYj0YhfGztQIxZckQARAQABwsB8BBgBCgAmFiEERL7Dxegbnh7xTiQ5Ob6PxxJcZXoFAmSt
 avwCGwwFCQWjmoAACgkQOb6PxxJcZXr1vgf/SKXhoZcUU5I7TqcbHg0lJz9tICTupCGHWr/s
 SQgjh9oEM5j1wqW7FlCGP90Tl9K0g3ow9YdbhU7VK470o6pymX9V9eLHzGgkZO/KMEtGBeK1
 u+5ePjCJ/MK5B21KODLSU7WrIL1VN5ceXfQPLYt02LMLtPri+oduHD6RNBeA7US1DUzleq5F
 9NHGbvV2U7BdDUezpiO8NaFjFZVB11I5d99FxUM5XGVstI3VhsRKZxjY0KnqJzaQgTFsPGmv
 AUfZVIN1pXgXiedhPXpr8+Y64jP+pHVwpVmh1zYWL6+q3kqFOUVP6c5iiMeoEXZvgJz7x/AC
 ek3X5gvu8Hpcv+MZIg==
In-Reply-To: <20241125-pks-meson-v9-6-1c6cf242a5f1@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/11/24 06:56, Patrick Steinhardt wrote:
> The documentation we generate embeds information for the exact Git
> version used as well as the date of the commit. This information is
> injected by injecting attributes into the build process via command line
> argument.
> 
> Refactor the logic so that we write the information into "asciidoc.conf"
> and "asciidoctor-extensions.rb" via `GIT-VERSION-GEN` for AsciiDoc and
> AsciiDoctor, respectively.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>   Documentation/.gitignore                            |  2 ++
>   Documentation/Makefile                              | 21 ++++++++++++++-------
>   Documentation/{asciidoc.conf => asciidoc.conf.in}   |  3 +++
>   ...r-extensions.rb => asciidoctor-extensions.rb.in} |  8 ++------
>   GIT-VERSION-GEN                                     |  2 ++
>   5 files changed, 23 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/.gitignore b/Documentation/.gitignore
> index a48448de32f98b1a054b36e886ea920bccebc494..649df89474d357ccc91109b5c35fe2d0910f968a 100644
> --- a/Documentation/.gitignore
> +++ b/Documentation/.gitignore
> @@ -15,3 +15,5 @@ tmp-doc-diff/
>   GIT-ASCIIDOCFLAGS
>   /.build/
>   /GIT-EXCLUDED-PROGRAMS
> +/asciidoc.conf
> +/asciidoctor-extensions.rb
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 0f55baa252fffbcd506f0c6f410b26b37f2e9b11..495c61c85ed18bc9c4643f9e5478e5146bb5f196 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -1,6 +1,8 @@
>   # Import tree-wide shared Makefile behavior and libraries
>   include ../shared.mak
>   
> +.PHONY: FORCE
> +
>   # Guard against environment variables
>   MAN1_TXT =
>   MAN5_TXT =
> @@ -148,16 +150,12 @@ man5dir = $(mandir)/man5
>   man7dir = $(mandir)/man7
>   # DESTDIR =
>   
> -GIT_DATE := $(shell git show --quiet --pretty='%as')
> -
>   ASCIIDOC = asciidoc
>   ASCIIDOC_EXTRA =
>   ASCIIDOC_HTML = xhtml11
>   ASCIIDOC_DOCBOOK = docbook
>   ASCIIDOC_CONF = -f asciidoc.conf
> -ASCIIDOC_COMMON = $(ASCIIDOC) $(ASCIIDOC_EXTRA) $(ASCIIDOC_CONF) \
> -		-amanmanual='Git Manual' -amansource='Git $(GIT_VERSION)' \
> -		-arevdate='$(GIT_DATE)'
> +ASCIIDOC_COMMON = $(ASCIIDOC) $(ASCIIDOC_EXTRA) $(ASCIIDOC_CONF)
>   ASCIIDOC_DEPS = asciidoc.conf GIT-ASCIIDOCFLAGS
>   TXT_TO_HTML = $(ASCIIDOC_COMMON) -b $(ASCIIDOC_HTML)
>   TXT_TO_XML = $(ASCIIDOC_COMMON) -b $(ASCIIDOC_DOCBOOK)
> @@ -210,6 +208,14 @@ ASCIIDOC_DEPS = asciidoctor-extensions.rb GIT-ASCIIDOCFLAGS
>   DBLATEX_COMMON =
>   XMLTO_EXTRA += --skip-validation
>   XMLTO_EXTRA += -x manpage.xsl
> +
> +asciidoctor-extensions.rb: asciidoctor-extensions.rb.in FORCE
> +	$(QUIET_GEN)GIT_USER_AGENT="$(GIT_USER_AGENT)" $(SHELL_PATH) ../GIT-VERSION-GEN "$(shell pwd)/.." $< $@+
> +	@if cmp $@+ $@ >/dev/null 2>&1; then $(RM) $@+; else mv $@+ $@; fi
> +else
> +asciidoc.conf: asciidoc.conf.in FORCE
> +	$(QUIET_GEN)GIT_USER_AGENT="$(GIT_USER_AGENT)" $(SHELL_PATH) ../GIT-VERSION-GEN "$(shell pwd)/.." $< $@+
> +	@if cmp $@+ $@ >/dev/null 2>&1; then $(RM) $@+; else mv $@+ $@; fi
>   endif

Hi Patrick!

contrib/subtree/Makefile rely on asciidoc.conf or 
asciidoctor-extensions.rb to build, it would be nice if it could trigger 
the build of the appropriate file during its build.

-- 
Renato Botelho

