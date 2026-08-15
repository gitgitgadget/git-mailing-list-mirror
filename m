Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B315126BE1
	for <git@vger.kernel.org>; Sat, 15 Aug 2026 02:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786760259; cv=none; b=toCPkD3kg+LBa74ODhxx/oHqiUvJdMaTGH+mUnxXjjfDGc/mNno7vtKhxRp8l9p8169oB/8VkrCho4R/cLrSFWaWEL7hieHYSUtqCKJw+RkA0fLQHnNT7J/xDtU9alr58ZJNyDAPnN+DMy1gUv1JF/FEzWs6NxAcwYz5lHxUcJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786760259; c=relaxed/simple;
	bh=vBQ7/blEJkaJtvjKH//BslV31njg3mlSbnBy1NhN6LQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ttHUZSJiONdqjKVoaaUHuaZERHEaDoDPmxERaAfs8/DIdSin13SVssXziwRoGzJDVSQ2SVWiYlUmh1CN1ruIo5ZiSnuIAUp0DQevTM0YpXfwxgwstXKSqUcQ+FzewypcDRuHZbl/qmKO9NGiZlLFQiji6linAN1xqZdT5jirbII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hMDpApE3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ObTBa0uv; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hMDpApE3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ObTBa0uv"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CF6C814000C4;
	Fri, 14 Aug 2026 22:17:36 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Fri, 14 Aug 2026 22:17:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786760256; x=1786846656; bh=jhz5W70UgU
	j9XskKO3mufBL2nem0K4u6HTIxpH6NcfQ=; b=hMDpApE3W5yBE+s86mE6alW/Zq
	h5xqo8900edFTf+/M2gON/hfUjl9Bss05B8qByNGHIpW2afjaSf6i4wGF5qUBc+v
	+9FdV7y5D69kMooX9IkiHdR52aqphhIuFCBrVq8g+AyVQBIp54hnle8GXxz/NZBq
	sAhkY94wZbrh2Dzg0AZ+ukSVxOR4IV/zB4asmmxXntZuNGqA/HGS996pXNSHXKHA
	riA0rGIMNZ4kmjsyCh0mxkRWcRiW13HY8EYqWNFwOi300gf8ipNlBPVlH2/3OJ3L
	RlyieroURY9OZt6bkwyREZpyoScIQRuBF5zLfRR0Xm1ei5av054zxA+Y+C7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786760256; x=1786846656; bh=jhz5W70UgUj9XskKO3mufBL2nem0K4u6HTI
	xpH6NcfQ=; b=ObTBa0uv/PxwobnN+5g03zjnwu7p90TbUqWD7NnM+DMIMKfCYyK
	w/x3T30q29svVQJ8/gdwN+6doHra1K0P6SlXAi+XUj5RBox6zLlsEvwCG+PH/6Gb
	QQ0gIo3Yq92DGZNXLLMnMK6A/f1irQ7UXsSA2NK8i8QQgEwSgA1GEz91Wk/Px+Ez
	06NPD5xSSt5wXkBSWkPuLuFynQKiokk5d37NJ8t2VmMy5e6OoqvbHJy6UAnse4Bm
	Vo49HisIjVqyiImbxIkIoa2LGlUZzD2BEnWFmc4YKwsaGkGBZXCGyXPubVfv80ae
	XFv1HyxN3X2TclUh+nfNEpTOgZ+MdYTejtA==
X-ME-Sender: <xms:QMx_akgiYAc58NT_4oJBM_JrrtzToRLNjSyVuXQrP2M-w-01wCTDeA>
    <xme:QMx_akAJSvAu_gBaJKw14UbUZ4Ci0kdAtTbdqG5nNevv-0SJoJygmha2cJ29IxVG5
    3gomQ_qa_E5VffL2SHS3bq92M_w5CouxSZlCcw9b_0BgibO7uKgAos>
X-ME-Received: <xmr:QMx_ahF-v0icy2OSqIDO7ALCxGQIW8Mv2bHD_IcUqVRym9syCrSLEHl-ZBAm3xNqRcwx-iNE9-G9XyyCX-n7y1cJedbiomwYtA>
X-ME-Proxy-Cause: dmFkZTGFukvQVwFyFPWWt4PsP+LVaWftAvEEGAbLrF+nWs872tyz3AFsYMpzMURtW39Itw
    e+jmZ0I0FGgQcxHRLwcxrewvd4ua8688nEnj/YrDmxfhUCPxgZu6UlAXH7kRbmtpcKEWlD
    RXteZslvjsVKx1fQaYko21f59yqsXLX9kmCJ4tRmJJFWFGVzd0F76I4X6zq3U6WmK7YsU5
    pnmp50az8kx8Y0Nt3CsPrQb8JpzkxN+kZsuk/d1j4Dbin5N/5Nzs0powfF99OJccO+APqx
    fjzYrV/QMsNyAwR2uc/eAoYvlW5knTgawSg0ye34fhycCaqIWTDOYgSPlWHqZq0eRyw5l+
    f9VWRNrYlOIRXO0SiuwVhsQRLFfrMxwL+D0+uRnnw8tuUxlTI4lcW7HqDIla8vVwmIrDfM
    eiw0uUx2LCRgUMoZ5bkUEzX2o5C217JYN/2elpaVjBMnxEkYX70RnYBRLIvOzNxkRg/mCw
    P+lOzlYVblAmZCnKG/CTMlMYED+Nn/VSFASSu771PYMnqYPnrej2ieIJIX98FH2pXNDiP3
    qciKUBzD5q1VMiElvmWlOtzDxsLYIAwud315R8jrKNYULwePjdQjnx407Ge5DCknNSGxss
    VKdIlcJe5vN25a/lNvUl546McFZo+xP53okgAXzWJxOkXZqZs1DffTgEsESw
X-ME-Proxy: <xmx:QMx_akIBmNMtunwXNJpnFm-Ju3CbcfsKt05behDg-qv37XmDKBONgA>
    <xmx:QMx_atkK87qlz2MeyCOsh9uFpiyTZMEHiMxv2bvtdE5cHho7z9-zAQ>
    <xmx:QMx_akTi3HE3TPmLAhm0vJu_F5XCMQPLjylAVnIGmoAeAKl-VNTvjQ>
    <xmx:QMx_anKC8AQV4yOSfNLc5WYesKvJyyYpvynHY_x9Mh2Byz8u3r55iA>
    <xmx:QMx_avtO8lsNoTeMeCZaU21Vsj9ZZtzSp1xssDxrLV9Hwr_1BHPa62pv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Aug 2026 22:17:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH 4/4] format-rev: learn --abbrev, --color, and --date
In-Reply-To: <format-rev_three_more_opts.b84@msgid.xyz>
	(kristofferhaugsbakk@fastmail.com's message of "Thu, 13 Aug 2026
	19:24:00 +0200")
References: <CV_format-rev_three_more_opts.b80@msgid.xyz>
	<format-rev_three_more_opts.b84@msgid.xyz>
Date: Fri, 14 Aug 2026 19:17:34 -0700
Message-ID: <xmqqbjb4ktz5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

kristofferhaugsbakk@fastmail.com writes:

> +static int date_cb(const struct option *option,
> +		   const char *arg,
> +		   int unset)
> +{
> +	struct rev_info *data = option->value;
> +	parse_date_format(arg, &data->date_mode);
> +	data->date_mode_explicit = 1;
> +	BUG_ON_OPT_NEG(unset);
> +	return 0;
> +}

This BUG_ON_OPT_NEG(unset) is a bit curious and confusing to me.  If
the caller could pass unset==1 (e.g., "--no-date"), option->value
would be NULL, and we would already have dereferenced data->date_mode
when preparing to call parse_date_format().

On the other hand, ...

> +		OPT_CALLBACK_F(0, "date", &data.rev, N_("date"),
> +			       N_("date format"),
> +			       PARSE_OPT_NONEG, date_cb),

... because we mark the option entry with PARSE_OPT_NONEG,
"--no-date" would not cause date_cb() to be called with unset==1.

I guess, from existing uses of BUG_ON_OPT_NEG() elsewhere (like
apply.c), that the intention is to notice when this callback
function is broken by future changes, i.e., somebody careless makes
the calling parse_options(), or an additional side caller that calls
this callback directly, pass unset==1 and option->value==NULL
combinations.  But then the assertion should come before the first
potentially problematic use, i.e., in this order:

	struct rev_info *data = option->value;

	BUG_ON_OPT_NEG(unset);
	parse_date_format(arg, &data->date_mode);
	data->date_mode_explicit = 1;
	return 0;

or the assertion will not trigger before the code segfaults, no?

Thanks.
