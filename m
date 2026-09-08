Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A039D2EEE6E
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 04:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788841026; cv=none; b=PDmVfyACxMnYbPIuGcCvOaErXnQVsi7vNPye0f+7tNq7kPrcD+CT8gwgPoM9hcPCilHfys8ZmnGknR+d98E3M0LblI5ce1DqJ5TuuahVlrzMZo8KpxKlPmltaz3AygsCchthdJ8feWQpwtpIxCMSzLI9dx6BytfJXIo4yeCqHoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788841026; c=relaxed/simple;
	bh=MX02SC6D1SBT/pp7e3EEIZAOM4VqErdK1IrAZjKxBIw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=udDgbOAhgl5k/Uzjc1JvsGgEDItocJ7LDxCqTBaDsyBTa4WRbUwsZTRVvkD0vpE3V7MRfSawA2JA+dMYl1xiOyqodMNRhSG1I8/YUJyY2fkqI4mf/bHGFt0bKUN1Qo0UZ8jn9vPKNPDy6Q/UO/uWzTCfzIZY2pNWH7CP4KW3Ak4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BO3VVq37; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GP386lp9; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BO3VVq37";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GP386lp9"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 435E87A0062;
	Tue,  8 Sep 2026 00:17:03 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 08 Sep 2026 00:17:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788841023; x=1788927423; bh=Dl8pXXBMfb
	FNbIAunKMV2x9Ir0MmGfUhdgdqxXBAIzQ=; b=BO3VVq37prCT4aONOgM7S3wyiU
	OXm+ixcv9Er6eqxBHAugYYRjjrrUD6cXB8pDr59UsFdOd6gKQMKin/dhdzsD0Zzh
	6UfIMC5TTtaJkHh9HqET715mAW1/620ZKvJW1onqcRhCs9hijXT73uVcrC6M+zec
	AvfMq08e/Qy/2KNUX73PLYvGECWw9pTv00Os/wuoTHLFQy4QR2nMdpmnPI3JN0vL
	657TFunaAGFBQImdwCTGZibcG/Q9CpNaPtJ9S/XqQP5OfKXlGGvgEW98bzYn3SkZ
	oAZ7BXzUwyGEkOgiE3EPU58AFFO7ONbfAELjC8fsB7QI3Y1KkuROQ4gGCmDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788841023; x=1788927423; bh=Dl8pXXBMfbFNbIAunKMV2x9Ir0MmGfUhdgd
	qxXBAIzQ=; b=GP386lp9evtRpph4FJJ9kntKIDh+yNOpUTk4tU000KUbDtT2Fz/
	o8KOs/k6xAiKvfoP8jGXhBnN3Rg4O82/ZYjUBGpSvudCqkB5keuCm5VWT+XxUcVJ
	E/IwwGRxb3fTRQHXZHX3jCOfh6tMfNgNUgD84T7kYQ/eKTYikQWutjeCy5t4EwUn
	rKX1uJhEFauVXlS8YSC7U47OD37tMeyxxQumkc8cyhZhkSDssbiZuxTM4iIm5og/
	9eCJFj6nwBhyVSZ3CgkTbuJQvOKOpcz3cePQUbN4GfwWW734PrjjR0exQFnpTsAr
	XIgy5ie1Yu5iAAdHLUbF71dzVxdb6X/psIg==
X-ME-Sender: <xms:PoyfaumCwortN59kg50M9jtjmXHuM9wLxNd49nkZ34ZNdgfxJVj42w>
    <xme:Poyfas3Tafb9lvOgpLa0ywT4FjvCpW1GFv-2Juva2LvfISLsxgd-bZ6QZW9uj5e5k
    3JbESGxTXMq0NSx8-9RjPPR7Tcv-NvtZIJQawU9aGhw-B-qduK2Zg>
X-ME-Received: <xmr:PoyfahpqP3QUwiHDMTg2zU6PCO6A2QoXHSxTgGOWXvj-9USDI17kaVkUhG5B2669omJ_K0eY_zXIaA1A3Pd10E1QWj6j4txaNyYD>
X-ME-Proxy-Cause: dmFkZTFo736QRn8Tarb0EGRmqr2QKbVa0YApezstdwRk40oHPgDaRDOb3y//+v0faSQjYO
    MlNbh61kUJGsR/+UrDI+aMHI5TC3pWX4wEfxsOkGBGLQhBhsf420E3FoVxtXrNq+p6l2Xe
    pxJm750/Loj4KAdQ850GYOwSb8wqa72m5VgpfemIXz0XV4te/yrNvKlFsumBu+ZO6cXpnH
    yx+iQizbr+Nm/tIwJwjzvLdZmJG0mQSrcMo2ZV+0KATJ76GhAi3aUC+767qFHslaq0LaX7
    F77FyrNGgdaCU0HFEK+OjTsnO6SKIiTDoZiDeN0TLqQ2x1XLB6dgIWxyG1nZRCHVvsokij
    sT76g+fJdBFHhgp+7mud7reSrzyemkfkLyCeAWLWpxCWfFcg7J++NwEMAJTLPs0Xbk07Bg
    7iYhS+wPzEyeBZ8DKbJaEWV6w8gk07nGZHCU2Y0rGa04cAaJvUMXdHPka4srGeXipv2sBQ
    t0G6Dms7Z24LWzmXGN//gT8WbpdpAEcMsy4dvArN4z5ybmX92wzSZ6EDiiRTph9wzD/Jz8
    1dx3G7UA/7Xv5TzIj1Q1BLBYIMfVcx8ndVkvInfm7+9xlCSzboPNyipzPVfAqomQDLlpqa
    OOqL0ywSjwLTKjpXUicSnI+4vcVg2ns93maa3VZI71XAb2hUCpP6/royfl7g
X-ME-Proxy: <xmx:PoyfaheXa60yJQFVJOKZUpmaHWmR7g2tNv7wj-qlSRf4anOpQruscg>
    <xmx:P4yfaoo0A2nIOiVDSkqwLlRf_c5fWY_cEkO6gMHGLps4nmgfgVklFA>
    <xmx:P4yfaqGoXwFX64cjoMWm9tOvg0B01oKOnNb4JOu1f2a1t6XMbnsL-g>
    <xmx:P4yfaguGkiGMgkv7Gw7KuNlD5oG3tGft53QB8WJGhH7_BdS05vx19Q>
    <xmx:P4yfakmeueYjugAUd3MvHB0bscD0VDv8UfWUdw0UG6E7TvkDKT8Z9fI8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Sep 2026 00:17:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Beat Bolli <dev+git@drbeat.li>
Cc: git@vger.kernel.org,  Oswald Buddenhagen <ossi@kde.org>
Subject: Re: [PATCH 1/3] imap-send: prepare for OpenSSL 4.1
In-Reply-To: <20260907211210.2621693-2-dev+git@drbeat.li> (Beat Bolli's
	message of "Mon, 7 Sep 2026 23:12:08 +0200")
References: <20260907211210.2621693-1-dev+git@drbeat.li>
	<20260907211210.2621693-2-dev+git@drbeat.li>
Date: Mon, 07 Sep 2026 21:17:01 -0700
Message-ID: <xmqqfqzkz8aq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Beat Bolli <dev+git@drbeat.li> writes:

> OpenSSL master (to be v4.1 after the release) renamed the function
> ASN1_STRING_length() to ASN1_STRING_get_length(). Map the new name to
> the old one if we're compiling with a pre-4.1 version.
>
> Signed-off-by: Beat Bolli <dev+git@drbeat.li>
> ---
>  imap-send.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/imap-send.c b/imap-send.c
> index 0d16d02029..977d78005c 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -219,12 +219,17 @@ static int ssl_socket_connect(struct imap_socket *sock UNUSED,
>  
>  #else
>  
> +#if (OPENSSL_VERSION_NUMBER < 0x40100000L)
> +// map to the pre-4.1 name

Style?

> +#define ASN1_STRING_get_length(s) ASN1_STRING_length(s)
> +#endif
> +
>  static int host_matches(const char *host, const ASN1_STRING *asn1_str)
>  {
>  	const char *pattern = (const char *)ASN1_STRING_get0_data(asn1_str);
>  
>  	/* embedded NUL characters may open a security hole */
> -	if (memchr(pattern, '\0', ASN1_STRING_length(asn1_str)))
> +	if (memchr(pattern, '\0', ASN1_STRING_get_length(asn1_str)))
>  	    return 0;
>  
>  	if (pattern[0] == '*' && pattern[1] == '.') {
