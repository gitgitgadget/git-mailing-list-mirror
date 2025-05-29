Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB93B1A314B
	for <git@vger.kernel.org>; Thu, 29 May 2025 13:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748527102; cv=none; b=VBvR97ZMOKfCy8zFp1NscTFl96aJ/qZQC3e5riHYUMk2ApPwSBTtd1PG0aVeuDZVWcZpq/cyqegGtV6xyrbC8cOr83n2dyMP3pyAMJ/XBK23ObSMC1/wMZj+bAuP/0/ZnqQRnBomffW0wBwifjZU4543hXe1wHlNVRnHMAqqh2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748527102; c=relaxed/simple;
	bh=AuUCWe5Hlmm6jznkIRCajAFSPDIRYtVHA9ZnCXr0T8s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D6O9PTciACpyaEaerDOJMxrvVR5D8LDGtOLRw/fuPTORHCYrn862p3lnIeCKjfJGtv7zrayKhe7O1ENIV4rKnpPAa7iDjLGjba2omhzRQFlypbN8pWms6MstR/Bisds8j4aXeBQdUagv2el34ZCW70F0VnmG4QLKcZJ7JyuRi5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dspjIPG+; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dspjIPG+"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-604533a2f62so1654437a12.3
        for <git@vger.kernel.org>; Thu, 29 May 2025 06:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748527099; x=1749131899; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gvYe/8/9ifyFXY/8JRGELcRWADujUVUOBuNeoyifNpU=;
        b=dspjIPG+SsPPjoQcm5dOGazSG+IcpgcDkIQZB+RYKhVZMz7JYPih9oC593Y51frppO
         GNDq4RnLHWTgRtKmHVcHTB+MgB2srnqJ6K6yFJLo0W7LU4aJBuXLL3LxGrOXtfc8Wp6O
         AgH1rv8/vwT1ufQn7ywN+JA2nPfKCU4Pjh9G7HArcNTKUjxpNglXABo8cvqxH+rSQiIm
         iub+mJY9mSSqI9tFNrYRn04IBH86Tk0asaDuwzQMVanWuXZTrhSt2L+J4qsrpI3/cDND
         e3K4PbIUzE3nWpM7b9Ku4eKjSHC3VutpHbGLAkPnIW/QLXBZPXG6vgf4TlifBJxUX9hB
         5HQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748527099; x=1749131899;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gvYe/8/9ifyFXY/8JRGELcRWADujUVUOBuNeoyifNpU=;
        b=HVRHIwGZYtewmTYn8mlGW/I1AH1TmvdZxiCUmmqHVFiHn/hoFfgfdW5vKEMIf+qJER
         r364VuYn5TotnYukUoDnpWwuNlblG+Lfo0jrIU69iYyzryJb0VujiRffB9HN2et0xevu
         XwWPBNOkDskv4SmvcUfVPYTcaJcqe2PyIxidAJFm8zlHOURUWQcSKlTaszapbiPQ1FPj
         xfrdWCPz6AWFzdESgYAxJkjaChGT4KyPZ2UmcYS5IQ8pBzqTmr1SZCybQGqdeUPh8f7T
         SRs4h0yG2eDpeeIPajplDxws3NOpvhrkb2XBHGcCB4L7of5Br5MKTzRgIab0hUavOtQ6
         zbPQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6beSGmDG/haPvIaIDR4fMjFcNZeLIEXgQktTGA52Gp4FSh9KyEQnFyLe/ZzTscFJNAHM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz23ghydJArFfaWyrqPrb94/qsIaaQtFrg6OIYzQc1Y+RqOX4b6
	FIRZy+4B9svEZVSxxsiJ3Be1bcK9BKxYaWyXf3gsbJOrSLlgk/v80O1n
X-Gm-Gg: ASbGncstTz6Why/WEUFteEOhsQgTtQBykzrS9K+xc0D/GqLr6xI8uC3vQfzfLj/Tr9N
	oT7wspzkuf+k3AyGnOey+OfX+hSixlzCZ5b8z0OUcXJ8L5vZqRLEGBww1pEIQARnWVUxr2M7QZB
	1IJG4tzhN2IvnQdNpbPTsHe0aLoGMu6mDkTmh/YCEP7FddsBYyhtyTNlVfUS6kSLweUx2Rv2nqq
	N60xZSRdgOOSV2kZNo6f3wIjFWMecnBaXP3GnOOo8D0OUHHeyFRYutP02wWSoZOTYDoVgLos9hh
	45SKs+V96w42kbn4R2xDl3ILCgSBCbTniV+ZKnMuA5kTkO7PG4HIQmNqm8WXfsfdbMeo856ALVa
	f6b1lakTySa64WNuThhbE1lnIqak=
X-Google-Smtp-Source: AGHT+IFWQ2d+FcXEzE3DNNj8bexsUPgdE1M+Ag5PsbDWp+cUg7iDzTZlA/oonvVGlW7HAx//xxaiYw==
X-Received: by 2002:a05:6402:2354:b0:5ff:9485:1221 with SMTP id 4fb4d7f45d1cf-602da30511fmr18095718a12.24.1748527098943;
        Thu, 29 May 2025 06:58:18 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60566c756f5sm21344a12.45.2025.05.29.06.58.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 May 2025 06:58:18 -0700 (PDT)
Message-ID: <42e07f4d-9888-4a1e-826a-b53b7d84fef6@gmail.com>
Date: Thu, 29 May 2025 14:58:17 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v7 6/9] imap-send: enable user to choose between libcurl
 and openssl using the config
To: Aditya Garg <gargaditya08@live.com>, Junio C Hamano <gitster@pobox.com>,
 git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>, sandals@crustytoothpaste.net,
 Zi Yao <ziyao@disroot.org>, Jeff King <peff@peff.net>,
 Ben Knoble <ben.knoble@gmail.com>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB95979EAD9EEEB3385693EBE7B867A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597B56233DA6815FC7CA96EB867A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <PN3PR01MB9597B56233DA6815FC7CA96EB867A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Aditya

On 28/05/2025 18:17, Aditya Garg wrote:
> Currently, imap-send allows the user to choose between libcurl and
> openssl in case Git is compiled with both libraries only using the
> command line, and no option to set a default using the config is
> available. Add support for the same.

I'm wondering why anyone would want to switch the backend at run-time? 
There has been talk in the past about removing the openssl code [1] and 
just relying on the curl backend. I think that is a worthwhile goal as 
it simplifies the code and means we would avoid having to worry about 
whether we're using openssl correctly [2]. That would be harder to do if 
we add this config setting. If we don't already do so, perhaps we could 
start using libcurl even when openssl is also available though that does 
not need to be part of this patch series.

Best Wishes

Phillip

[1] https://lore.kernel.org/git/Y+LNitGAude1vogv@coredump.intra.peff.net/
[2] 
https://lore.kernel.org/git/pull.1886.git.1742819282360.gitgitgadget@gmail.com/

> Signed-off-by: Aditya Garg <gargaditya08@live.com>
> ---
>   Documentation/config/imap.adoc   | 7 +++++++
>   Documentation/git-imap-send.adoc | 4 ++--
>   imap-send.c                      | 2 ++
>   3 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/config/imap.adoc b/Documentation/config/imap.adoc
> index 829d9e0bac..608c0be7ab 100644
> --- a/Documentation/config/imap.adoc
> +++ b/Documentation/config/imap.adoc
> @@ -25,6 +25,13 @@ imap.port::
>   	Defaults to 143 for imap:// hosts and 993 for imaps:// hosts.
>   	Ignored when imap.tunnel is set.
>   
> +imap.usecurl::
> +	A boolean to choose whether to use libcurl or not to communicate
> +	with the IMAP server.
> +	Ignored if Git was built without `USE_CURL_FOR_IMAP_SEND` option
> +	or with `NO_OPENSSL` option set.
> +	`--[no]-curl` argument will override this option.
> +
>   imap.sslverify::
>   	A boolean to enable/disable verification of the server certificate
>   	used by the SSL/TLS connection. Default is `true`. Ignored when
> diff --git a/Documentation/git-imap-send.adoc b/Documentation/git-imap-send.adoc
> index a35f278baf..cbbe534ec2 100644
> --- a/Documentation/git-imap-send.adoc
> +++ b/Documentation/git-imap-send.adoc
> @@ -46,12 +46,12 @@ OPTIONS
>   
>   --curl::
>   	Use libcurl to communicate with the IMAP server, unless tunneling
> -	into it.  Ignored if Git was built without the USE_CURL_FOR_IMAP_SEND
> +	into it.  Ignored if Git was built without the `USE_CURL_FOR_IMAP_SEND`
>   	option set.
>   
>   --no-curl::
>   	Talk to the IMAP server using git's own IMAP routines instead of
> -	using libcurl.  Ignored if Git was built with the NO_OPENSSL option
> +	using libcurl.  Ignored if Git was built with the `NO_OPENSSL` option
>   	set.
>   
>   
> diff --git a/imap-send.c b/imap-send.c
> index 337f1049ca..b08ec0e1d5 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -1559,6 +1559,8 @@ static int git_imap_config(const char *var, const char *val,
>   		return git_config_string(&cfg->auth_method, var, val);
>   	} else if (!strcmp("imap.port", var)) {
>   		cfg->port = git_config_int(var, val, ctx->kvi);
> +	} else if (!strcmp("imap.usecurl", var)) {
> +		use_curl = git_config_bool(var, val);
>   	} else if (!strcmp("imap.host", var)) {
>   		if (!val) {
>   			return config_error_nonbool(var);

