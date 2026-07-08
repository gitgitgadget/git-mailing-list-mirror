Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7C11A682C
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 01:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783473966; cv=none; b=NcJttqmcjO3HkXICeYYLdD8qhFzxDGe6Zh6n69/bV4R6DqZJEaHP8iRhlb0X5oRu5dcB8jjoHD/UCtLA5XnUvB5Tow8uwl78HsDHLxtc7aWy7fw59byr5CAwyNTeXan1qUjfwwTL42kLgyc7+nClWzRL3zU0y8ihAnervtl5Qu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783473966; c=relaxed/simple;
	bh=qCqiZ8D634x3ziLpPHXSRxI7Ner4eQEOa/lfWga8CXw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aAL2RgAJMLB4XvukrBJctlk9p8h1HnCGhkfbAuj6DQ5hc0/tL0bcDAGuEp2m0+4UkZIoUuQ163ksGCLkGjPDdgBwmwQvivhZHG5iY6URZdqSNGYgjXbtgQYzjpv88xzEySnQeJO7Y6d9Ahaj5bl7fqkdSBMDdN6gkVNWgVvPLfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=R8P2vM0O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VgLoxgtb; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="R8P2vM0O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VgLoxgtb"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8EB7F1400073;
	Tue,  7 Jul 2026 21:26:04 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 07 Jul 2026 21:26:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783473964; x=1783560364; bh=Yy9H/AEDh6
	NL3AwnvUwTTsPaf0Kpw2Q1rFJKQozowpc=; b=R8P2vM0O8f5WXCDbccnl0YOZTZ
	pe3fjxn2kH5HNjl8MfbMy8rpm3zr7DVcH7SManheBzePaDkDkvmBvED3sNs6Ckvx
	ZwQgPtYJNOGQ0bua3jhWSdx8QyMw6k1kUZw+2rs0pLjvT3iOVv5WgC4Yms7aMDfe
	MDF+/vlocB8b8LDYW2NWnAbKwc9HwdNHkJbQo/NS6sgyPDaQbBoL+wtvZ6uFMWpW
	qR3NE3sf81Lxea+xtHQ4IFIABUfWbeiLFLh+kr2Ocu/zZFvRcu1FMVZlwFPw2aKZ
	2wwPkSEjhJW+KP5IqgRAw7HrMu8PL48Slv1KsUt0tHCLfbUBwVlD8d9D2Xjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783473964; x=1783560364; bh=Yy9H/AEDh6NL3AwnvUwTTsPaf0Kpw2Q1rFJ
	KQozowpc=; b=VgLoxgtbeZA+s045doIzOx3ZGzDidYBldgREmBo3NI9RU4/RfNo
	6uTOKTKl8s0NMGFlQVANqBpYd9exwpa/GkmEkN5mb4Y/PP5Fy7O42y7qa6EeU+7X
	YehWg00yyfwmto0mic4GSXNFsmZiXxw8RvWtMwoQfX4XxXNHkadGLpD1HCIiKquV
	S5LvMXnXQXs+ybqCd5AoH4T3PAMY3rlJUQKfB4MK8kEoRxY2TLHPDuhNmrqHC1eL
	Of1XAYsVcxpz6Nmx6C1jQXWoR/krhkucZ2iBvlHyNYd+xBuBuHUfrNvvjfzv4mUT
	qc9r74FCQ7B5hVMqypBKmfya/8uLCJ+UMaQ==
X-ME-Sender: <xms:LKdNavlY5d59sauvTHXmS4zdmIegC6-Xb6SyYTVK8M2YEYnOpt3DgQ>
    <xme:LKdNap1YUUwT5QvKY1dLQEC5Q5UdgR6kud8V3D5ufWc0Mes0GZ6mmYgXx2FVYdI-y
    18MphWwyk_DT5AewrqPj24pXscQZnBnwsFHwADC45XeCgdm5rzu8A>
X-ME-Received: <xmr:LKdNaqrW5dhG8UUVMWD9GPNcCE_iodYU2qKxK6uVq5diJWmHmzvnkVR8zw4VzaOfn-U823SAywd-BiocGBxs2553ZPzuGlM9Gk54uIY>
X-ME-Proxy-Cause: dmFkZTEMRoKt32IZoiZBTHAV+ZQtFiKr1InLzWcsnJ5yZZDSdMTbUyD1xB4rYtJ0ndl76z
    nV0xFZ6FlGGVHHUsJ1QuGttuZuq6+QPGt95L8yOOyFw5ffyW6dwnLq2ZUXp6GigjyMbrOQ
    2AHn01fyzOoJGRDY50OuT2RKurgHjKhTBflQe3CSy9c2n8N98SEiadGztZIPWYbSnpsBDh
    0jHLwddLSLJeOuKIWSUJqVtVcl75aGYWz7LotKvUih/gWOCBvHTiZzmJRmkBDMcZ5pjsLk
    6aqAePlumJL5WV4Luqk/ks5P+tA71Jdn39JpvdIIi+9gdxC+2cpanBckl+mPXVne2HIdA6
    Vpi6Gkhwe2sJwaKojuHeMGsCYMwH6YKiur4fgFBNq+K3mAuFwnC2XhzzZU3qyVqi9pEBfZ
    MOk/mQdtT8yZ6VdFLCDuSk0V2NdVIb3v9/US/yBiXTOUcnKCLiujCHQsxsMKyA2G62ERcP
    /xKbYtLgMu96UqToHhWcrnW1C7yXb+JBdp90WDWr+5oytOBvvXhWwUHG16ZUGcPX5GYkZw
    EUuOakXU9tcMEjosOAbdErgo+xhwtIQkZiaE4I6oBdO3nOIkLxtKxM4Gogssq4XPwJggdm
    d8uhpA6WMZAqDC0Vw1uxznSB4QSBvR4rmIxIaq6UKF6E9dL2T0OZD8vGXdfA
X-ME-Proxy: <xmx:LKdNamcwkQIvOCjMO-hjuTOombw2789qxSWIUEJq8_woI-BWvFO3SQ>
    <xmx:LKdNappbgycUuXp5W-Suc19esbmBOvxfifFg6811RzFAVKJLmIuDlw>
    <xmx:LKdNanGqyCO2cdpyLQSWTljOk3ywbPJ1BkUV_pMZ3U906Zyr0_XsEQ>
    <xmx:LKdNapsrqSvJBYbnSEmplJ002jmeRDS9kPOGr0oja2VUKUj6wIX-cg>
    <xmx:LKdNaieCR4ryLqZsEfBw5NsjP0VFVUcUO2vRn5SmnuW1Cu6HJXK7LyZf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jul 2026 21:26:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/4] parse-options: add a separate case for help
 output on error
In-Reply-To: <20260708001557.3581080-3-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Wed, 8 Jul 2026 00:15:55 +0000")
References: <20260701212442.1430084-1-sandals@crustytoothpaste.net>
	<20260708001557.3581080-1-sandals@crustytoothpaste.net>
	<20260708001557.3581080-3-sandals@crustytoothpaste.net>
Date: Tue, 07 Jul 2026 18:26:02 -0700
Message-ID: <xmqqmrw2xoet.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> @@ -1363,7 +1368,7 @@ static enum parse_opt_result usage_with_options_internal(struct parse_opt_ctx_t
>  	parse_options_check_harder(opts);
>  
>  	if (!usagestr)
> -		return PARSE_OPT_HELP;
> +		return err ? PARSE_OPT_HELP_ERROR : PARSE_OPT_HELP;

This part, IIUC, got updated from the previous round.  Looks
sensible.

> @@ -1476,7 +1481,7 @@ static enum parse_opt_result usage_with_options_internal(struct parse_opt_ctx_t
>  	if (!err && ctx && ctx->flags & PARSE_OPT_SHELL_EVAL)
>  		fputs("EOF\n", outfile);
>  
> -	return PARSE_OPT_HELP;
> +	return err ? PARSE_OPT_HELP_ERROR : PARSE_OPT_HELP;
>  }

And the above matches this part, of course.

