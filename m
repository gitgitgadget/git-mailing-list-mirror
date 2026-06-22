Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42728367291
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 09:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782119491; cv=none; b=Rdn/FQyJUvTSkiLLeSeV8+At0Bi0VELH+UUjgW1++XkHFD3Zqh/6fSt1lAI9dChCsURkYQmtCcisY+yGOJY9Dafiof9E78HvZc0j78ogPuFPVLTP5lBDHMS5WJuDGQvjdEpnyXD30IDld8GbQfSVe9LKcEZiM6yVZZsxO3WvYu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782119491; c=relaxed/simple;
	bh=byujSvyJVTQjZ/hUcB+wyfw90jANzV0k4MRXuSapHcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EhFDK6yYzJ/atLHx5PbmEQtgdA4SFpvCuQsSLBMU+h4+37nXDzxDh/4N4ZAJQnLhbYjBCGRLtEVLOu49lPblzljnLoICGADUlp+Mb7L93GLo/xRd7slNuYpMh2I2Kljoo3aiVuxSuPngH9g9MJfxxqfOcPHvI7N43PqG24xoq9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=k5R5Iyvi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TDJzoGC8; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="k5R5Iyvi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TDJzoGC8"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 86C411D00023;
	Mon, 22 Jun 2026 05:11:29 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 22 Jun 2026 05:11:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1782119489; x=1782205889; bh=l7Er3nro7S
	aTCeNePTrh8E1BJl6pTUNAuIGDycnmbF4=; b=k5R5IyviTmNc0aBsXxrxfhEryV
	xgp4XDGpQ0TAf7iB0ZPOsx3ukFvQP1i+Y4ZgJG8RgMled78zGhxyZwh9w3E10NRG
	R1CHw7yMhALaxbQuRaXmtt/k1I+D+h9Qwb1CV37TrPXPkBngwdLNO9oAYiEKvJIH
	XeF2zIzR1HaNYC1DmYI+ZPJ97UOPp0byZ6MZ4a8yZn8HP42hSjfI0fRUSLhR9ZWT
	y3FcrAi0455e1zgu6oB+1HXUGaruSj5mKwwduwhJRhiohfYqRLEL01EHpj72FXJ7
	dJgYbdgZBFeS/3L4Phtu+J8NhPs6zP3acoi/pxVYYWScAUrZhI6EBUYO3zGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782119489; x=1782205889; bh=l7Er3nro7SaTCeNePTrh8E1BJl6pTUNAuIG
	DycnmbF4=; b=TDJzoGC8nnPrYiwmUkzAE//Gh0ZaMth26gOa2TmECO8RaQSX/75
	sgWuovh4iqr9Ne/bNGZw7cOPVeAUTub+IvVK5DWhgbWJ//biXryuwUT9MDTwNwKr
	SdfPsp/zGvktw/PDYNRnGKVfHmFGJxvgi0YW71IcSgNYl8Q/df/+tnqnlLjlgp0b
	C4uOtDqoApxFtN907yU/T6a4N8ei6rtaxW4xobHM6WoMt691xB0ReX5282tuvdpv
	3C+almNwir9WZ08XQRV6ehKEVwFKWbHgfm6kYlnJ8PqhpstsWr60g7eVXtqq1XbM
	uTCEOIUiEhghcZT8fDdILZr+Jt6AWXtKHHg==
X-ME-Sender: <xms:Qfw4aoCcTNTVWOhXiTW3VNpFaiscKebpOrSApC-RI41IlrGyHfbISA>
    <xme:Qfw4ah-aCzFD1q7OBDK--RIuTkWtsdsZLfPf3HKRfgN7TMVWEI-WNscJOxl7v6Job
    JLvbecOc72n5up9MAC2Ly9XGUGebAgZjn_OaFVK4Qr4URqNFxiu7A>
X-ME-Received: <xmr:Qfw4ao-BennzI2X5TwmkgQoPeQpM4u1rwmdVw3OjvcmxPHuKvCkb9OM0m53wqxk7N-0biF-tBBSASyvN4HZFB83iFrCCohkzOXBdquxcmA>
X-ME-Proxy-Cause: dmFkZTGI5HXxHouoDT2E21Agx4KuSIoLp/mLmzaHlTzghnASSOz/kUpDE3UwbYcF/T7n8Z
    7UvrWJJkI8hnYJYDzF6LpEhzTSeQ48+eJXjLhmLfCNvXfx9/2Uj80kIvInbCurJN7X3M6T
    2OHIIBA9usNQjvbAscZSKf+gF710vbJ0OXCopQ+LoiFODa+hIPdy6LxNfpL+KfZBBdL/3Z
    SzFWf6FNbeHKjJ+D5yyW36hpdTVSo0CmmNGgLNe211RWxBnIMldNcJIDRYkbeflHUvBbMO
    Wpy+lTABxBOw8y5IvYehTRS7f4IvEdzzNCeYiug9P8Gr7joubH2zURaiYOsMaNWGs7Tytn
    yVqZez+E5+MD3GR5sg4TrQ6xJv5nggM2cTnm8MODZ0JfcaA3/N+RcL5xuRLLQYA9cwkPsc
    1WJ5jCvTx8a7akyVQdTjRlIrxovSjMSd413WPI+k0VUeXzF8zXBExNwuLxECKIqc+5GMO1
    LX9Mu7gt4QNuvDCqBxxojdM/e4BpeEc2c7azf72t2fpkZ0BWKUt6UlRJzN9TM7Cysvnedv
    bYI5Ong/ZvsvscvOwaLtke9XW/dJY/J9W7HJxf4tPxaVSlrQVmfhjROYNJINvtcprLGcQ9
    ObAf+HrP12IPAXLItnqJq5hDKymzcYFw1fdJnzdxNZf69b9bPVjp4lWgnwVg
X-ME-Proxy: <xmx:Qfw4aocnLiT8zXdYvLOVMXEUYku98zl2muZDBBvYKfl4CGS0QPfYGg>
    <xmx:Qfw4ahGa_8twPIK9zbDQA-6iakA-Yse4KnC_IdGv2yUPOLY2vfYKkA>
    <xmx:Qfw4amdgfVBLJkKzUPRrlkQYP3oc0VwIiuQtXXv-_Oe1e2aDFOkQTA>
    <xmx:Qfw4arGfxYhxWGseQVIBjjIvKP2sbPUG_yYw7pe71YoNCL51EiZW6w>
    <xmx:Qfw4aufBqiM3Q5dYBnlxuf7njiYf55spLL2isK6BCHQ070T07bikLUw8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jun 2026 05:11:28 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 64b801e7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 22 Jun 2026 09:11:25 +0000 (UTC)
Date: Mon, 22 Jun 2026 11:11:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] win32: ensure that `localtime_r()` is declared even in
 i686 builds
Message-ID: <ajj8OylK7jIMhFwp@pks.im>
References: <pull.2157.git.1782117847057.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.2157.git.1782117847057.gitgitgadget@gmail.com>

On Mon, Jun 22, 2026 at 08:44:06AM +0000, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> The `__MINGW64__` constant is defined, surprise, surprise, only when
> building for a 64-bit CPU architecture.
> 
> Therefore using it as a guard to define `_POSIX_C_SOURCE` (so that
> `localtime_r()` is declared, among other functions) is not enough, we
> also need to check `__MINGW32__`.
> 
> Technically, the latter constant is defined even for 64-bit builds. But
> let's make things a bit easier to understand by testing for both
> constants.

So it would suffice to use `__MINGW32__`? In any case, I agree that
making this explicit feels sane.

> Making it so fixes this compile warning (turned error in GCC v14.1):
> 
>   archive-zip.c: In function 'dos_time':
>   archive-zip.c:612:9: error: implicit declaration of function 'localtime_r';
>   did you mean 'localtime_s'? [-Wimplicit-function-declaration]
>     612 |         localtime_r(&time, &tm);
>         |         ^~~~~~~~~~~
>         |         localtime_s

Makes sense. The function is available in C23, but we don't use it.
Otherwise, it's enabled with `_POSIX_C_SOURCE` according to [1].

> diff --git a/compat/posix.h b/compat/posix.h
> index 2f01564b0d..e2e794cad7 100644
> --- a/compat/posix.h
> +++ b/compat/posix.h
> @@ -56,7 +56,7 @@
>  # define UNUSED
>  #endif
>  
> -#ifdef __MINGW64__
> +#if defined(__MINGW32__) || defined(__MINGW64__)
>  #define _POSIX_C_SOURCE 1
>  #elif defined(__sun__)
>   /*

This looks nice and simple.

Thanks!

Patrick

[1]: https://man7.org/linux/man-pages/man3/ctime.3.html
