Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187F73D4123
	for <git@vger.kernel.org>; Thu, 17 Sep 2026 19:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789673533; cv=none; b=fyOVO8dOVo5oIqZEZDC/9Ex7UZEFpRaR4ngtVyHqkFuz90LAQbpmvRxAWCI+xmLJEC7YJdwuBNBH/4HF6+G9hx7+gto/3AZPntWSzJIsN4jpJR6gwDTbAitU3z4Mhm6XaZN1RSqmEaHXLOV2yRu1MXSoVyoeqtuXwx4mPElOhrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789673533; c=relaxed/simple;
	bh=8lr8pj4N2PunpFSItxVacEhhv7rgX0gNv8LjFqsnIHA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bNR5tqj7Tk8knKOOutIwRzHS13/UYDcQEeCz8Z702G6LiTBVHLqYe20NnPvqy2h+jbgiGu/+2qXXzJ73GZ7xVcjs2jTSSCe4Kc9dM4BMkzJsOg+seeUSM6Z1mJwDhV59e/9dMD/zGK1CSUqBj+63A7nk5wP4faHQ/64hDxBJ32E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BrPmK5l0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FLEFnC0C; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BrPmK5l0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FLEFnC0C"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 10FA47A0125;
	Thu, 17 Sep 2026 15:32:11 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Thu, 17 Sep 2026 15:32:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1789673530; x=1789759930; bh=IzdD3qaPPH
	IAl7azpNYOcmIZpf6Bg7EaoSbc0ptYkLY=; b=BrPmK5l0QjdewuLa/HWAO7bFH8
	apsyBVmz/MIljo/F7iNrNnbMEQrtqPVxRtD1R9nTK4T1jr2F1CiV78Mv39vHwN10
	5/7VZlhHH8VT+dSsONQ6cxRIKfOOJQBYR2EO6cNg/BDyhu1vTgaMFwYWFyhY5ze8
	dBCjTUr3d+Uo7rAsFQ0FPeN2W/SKBlLnEYafjBA3jHwj3UbwXFaZ4GsUvpaviGwc
	xQr78vsuTUT+Z7C7tMLJxi1JjB2zEluojm1M33uM7jiep/gX6gD/o1+fLyaN3R7T
	7hU0q3g+dBV0F8b1N1wg2D1nzxdCdfAl4eLvbTY56obWy6gy9lYBKlSt61+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789673530; x=1789759930; bh=IzdD3qaPPHIAl7azpNYOcmIZpf6Bg7EaoSb
	c0ptYkLY=; b=FLEFnC0CemXL6LocUcqsyiC2euzoCJplEnuptL9qA5I+Lhkevuy
	qOITGvuuXo7O5uGfQhZv6r40z1PaPU8ArQm29L5SNKQJv59xn+bGnhDn1nzkNw0x
	dgJR8y8eLa/LQguRCMuxLrMpzFh3UoCcDb1SsBdClhvoyIEgtvrsIdnC2OK0ekKw
	ufZ8NUQqBW19RIRGFEPAoAPYjDyxHY8XYjaT8Dz0Ff1YjrcEGKyfMjUviqd3ThAd
	1+CMOVPfzsotNnmifSiX+zpuREtdHmUt4478iXdA9HHS84NR0KUjyP2RPi5YSTUH
	xD3Oal6YktBFNiCIfuXuThxw/l7oXFEghFw==
X-ME-Sender: <xms:OkCsauIIv8J4uVYn8kyudPRz8nE44qAMPbtkJXt0CquQ5LbhyW4FRw>
    <xme:OkCsatKU2BwxODkzkR7ADm_Z6bqHh4RgZALsKFolhPZnO69iys4LMWgAjy2Yt1ixt
    1EpZibJ3cN3YO_-M1m-B3wIfQcOyrOEXGfsGkiXowQqSTaLbn16Axs>
X-ME-Received: <xmr:OkCsajsXbpnDJ5-Kx5TKlmxlMBocjyzGzokgGXVD065uSi6lAFv69oT3pWdeAoEhCfgtXRLTGBjmcaLNx_COUGZszMeKs1yfC0Sm>
X-ME-Proxy-Cause: dmFkZTG1LL9zBOd6gGB6YeS7GjChVpRQ272L9+joi9VNYMH4yHVZZNRydMWLXcYYJf9Rvj
    2sjt6Zf8bzuzZGCeKGtuF6JeE4XhEl6QGR41XMdkWT+eeR2KUuChQG2wGcFiPFiz9LVJ5s
    qKv4NbBsaCY+paLQaLWtSp7qoL0y7mR6va9DFU0koeJaYkHZU3uvVOy6WXBm27/U7gBs4E
    EeUV1M4g3Bvnrqgpf2p0w3VNQgBVb48qvKWFDF3nk67+If+qROckyIzR7NjPwR1y+aaSb8
    EvKdrzfNBZF28j5g1HFKPEjPNW8J1WjhmDtl8Cisy80wzd9UOWqQF4Ei9Z/0IzHmzCd5GD
    y0NbvNkjsSrjTm1HYZZ5ak+yWuetFFo5WDuC/u3pPueprrqN4/4W0e7Ahdqx/+s+gKrB5Q
    v1HD1UNdWus1AVuuBghtejm/MkdXg0MpxJXFleOrqVk6f33ceNAUHQMDkZ2SHirWv00bLV
    dwm7QwQFvP7fVavYoSA595bpLFGewU/2kR5SFDLJxRKhvfLs6Zckw7cN3XDhoYdjK+81Xl
    hrOAcG3mbCwI/0lvCGgxfiyNjJGrkPek73ayJ6iy0pN3JkDOr6/dEoU0bIEBgMtVLRw/mO
    rzpWrqOoyfWYUfigo/c1uVudPh1TgAYWNEGb4Ezk7nichQF4e+FEa8cB/ljA
X-ME-Proxy: <xmx:OkCsaiT0QqqOkej97U-A3op7hP9IbiWFgRjB6MS3Kef-rSjgj9t0Mg>
    <xmx:OkCsahOBS5xnnDEQxPNCFTuNWklz0RKcm4DyJjAgFXGpbXQCh-kTvg>
    <xmx:OkCsavZUNyj_TFUCXMhW8Rkv5SwxCSuUTA1MdJrnmjfNd0TCxrUbEw>
    <xmx:OkCsajxElwR846XOL8nHYJTgUeXO8aLgGdYpGVYEE1hhiwMXtkLJpA>
    <xmx:OkCsapHC8VIgsfucMbbALgmgfkQGb06t1miP-3nWSM0BeKPTFxFMNKpC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Sep 2026 15:32:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/7] gpg-interface: make signature-prefix matching
 length-aware
In-Reply-To: <3fc7774ba867a10f35f7a74424baa4527f038232.1789667556.git.gitgitgadget@gmail.com>
	(Johannes Schindelin via GitGitGadget's message of "Thu, 17 Sep 2026
	17:52:31 +0000")
References: <pull.2231.git.1789667556.gitgitgadget@gmail.com>
	<3fc7774ba867a10f35f7a74424baa4527f038232.1789667556.git.gitgitgadget@gmail.com>
Date: Thu, 17 Sep 2026 12:32:09 -0700
Message-ID: <xmqqa4pfu11i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> @@ -669,7 +669,7 @@ int check_signature(struct signature_check *sigc,
>  	sigc->result = 'N';
>  	sigc->trust_level = TRUST_UNDEFINED;
>  
> -	fmt = get_format_by_sig(signature);
> +	fmt = get_format_by_sig(signature, slen);
>  	if (!fmt)
>  		die(_("bad/incompatible signature '%s'"), signature);

All the existing callers of check_signature() pass a NUL-terminated
buffer which is <buf, len> pair of a strbuf.  Another approach that
may be simpler is to drop the slen parameter from check_signature().

