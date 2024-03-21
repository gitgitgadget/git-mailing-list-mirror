Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587173A1DE
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 10:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711016887; cv=none; b=PGXgDSmagqoCTNVjKjpnR8WUACprooDM6WCXpn0mhN0aCS55lwRf+0wW95Pb5ZZTGgZ2vdyRR1bTNvIuqNRPZkA894T3OrX8cl3rQSRYpjQ4ZDVWG3HPcyIiw3tVWkJhaJm3iasFA1rYHdhre6x2YpbJQiuocUlzK6O1nhAliv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711016887; c=relaxed/simple;
	bh=2SnbNEOFPcCRhoJEqioLF+SZdljgJhSOnKwK5TTrhpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OhWdLVNCKE32DXrYEm/+ZI24rhN/HJUJveUI447UDoQAqDmqYFVzfWoVQgZ0XtKCLORzazaCAKOBG3mcv2npLCFWKE0dYAm0TK1J4+SaBzG7gBWV4s3KpEkdbt7BbQ8yYGo+eYQ8MbFukpsdOPcbgQT6kQGnFzOXBV8oUbfpCvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C3AIBNrW; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3AIBNrW"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41400a9844aso10982285e9.0
        for <git@vger.kernel.org>; Thu, 21 Mar 2024 03:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711016883; x=1711621683; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x2vNQh+MAMTcefRUIBMU5gpq0g6ykoDPeTiDV2jmNjY=;
        b=C3AIBNrWhGqFEqMhj2hir5s3shpE5tLQhzAaE3i7KqactjfhqDbLIZb/moNLhjxDqC
         IA0VYZp102ljnHwR2uc66pSOHWb0y6UWPpuGENTPSJctokWXC16CU+xxb719wrIALzyS
         +UZ/4lFkthJCicRbSKGdRDPG6JWAB0N0GBlWm+2wWzUbSLFLBzK7N9I6HUARatHy+YQT
         qgnPuBmr1fYVEvP6acHVcwkP+MiEYNcZHnjn4airumOWWiO+3K8v/hX6pXnU6CgfMJ7Y
         hbMgPEJPMTkjhvm2teCVbb6bttcMFKgqXB7viWWqLwI4K4YDCCJoq3m+OXfoxfzda6zs
         pynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711016883; x=1711621683;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x2vNQh+MAMTcefRUIBMU5gpq0g6ykoDPeTiDV2jmNjY=;
        b=b4DtcmBS1p9Xgak8upYmU4laT4RZkSuv2rovrO/XWiC2Brxko5nJDFEJX3+KC4przo
         qE5fwqNMd1SoNp0zws8Bwgln/CpMFLAGPV5fsw+dllaVz+kxC0NNvFLHxTKXxM8dKGaA
         bqMxdXgCrHXYRutx8hOUX82iFXiWydNLeQvQVcfsYpqY+vJVCS1R8r+Jo4U7+V+PYaXI
         /si9QSJS5tsJp4a2niPe2WOqumImMl9jlcBS9wyzkQocf6zM+yfcipTEgA8EkEAnBSxv
         K/VeJ0Ec0c0Lt8bfAITJRNW1JcCot4klnHVcIXkW74Vogr9sHFph0jikC/yhf59CB55O
         rJDw==
X-Forwarded-Encrypted: i=1; AJvYcCUUU6FSeuoBem8PCBneI1ZFZSRaixawxztlqptJeSzfRhsOudPwlUVp/vJItjaUeYDIv6xMqrgK8uB64CiWVXAmp4/p
X-Gm-Message-State: AOJu0YxDC7wmgGftiSjwqNHMSxem3Ul2OGe3IM2oHz/CwWEyLNIOb4qs
	X0+dvavCxwfUtR52dAcAKj6YusofdBKL2XFxxJJa3Y74Bb7KjfHCiX5BQKPQ
X-Google-Smtp-Source: AGHT+IGa51GEwzJ6Pi9lZ7J4dXN76lNB2XXY3evmSCWjjyU1LolHiy8++7eJes/GXOMet2b7Atnf9A==
X-Received: by 2002:a05:600c:1c87:b0:414:5ee1:76f3 with SMTP id k7-20020a05600c1c8700b004145ee176f3mr1939570wms.4.1711016883330;
        Thu, 21 Mar 2024 03:28:03 -0700 (PDT)
Received: from [192.168.3.164] ([92.173.128.58])
        by smtp.googlemail.com with ESMTPSA id t4-20020a0560001a4400b0033e756ed840sm16786225wry.47.2024.03.21.03.28.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Mar 2024 03:28:02 -0700 (PDT)
Message-ID: <519698f1-1daf-4085-9aec-380f44492e72@gmail.com>
Date: Thu, 21 Mar 2024 11:28:01 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc/gitremote-helpers: fix more missing single-quotes
To: Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20240320091748.GA2444639@coredump.intra.peff.net>
From: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <avila.jn@gmail.com>
Content-Language: fr
In-Reply-To: <20240320091748.GA2444639@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 20/03/2024 à 10:17, Jeff King a écrit :
> There are a few cases left in gitremote-helpers.txt that are missing a
> closing quote, so you end up with:
> 
>   'option deepen-since <timestamp>
> 
> with a stray opening quote instead of rendering correctly in italics.
> These should have been part of 51d41dc243 (doc/gitremote-helpers: fix
> missing single-quote, 2024-03-07), but apparently my eyesight is not
> what it once was. Hopefully this is now all of them.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> This should go on top of jk/doc-remote-helpers-markup-fix.
> 
>  Documentation/gitremote-helpers.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/gitremote-helpers.txt b/Documentation/gitremote-helpers.txt
> index 83e99192e1..cd4e16abad 100644
> --- a/Documentation/gitremote-helpers.txt
> +++ b/Documentation/gitremote-helpers.txt
> @@ -470,14 +470,14 @@ set by Git if the remote helper has the 'option' capability.
>  'option depth' <depth>::
>  	Deepens the history of a shallow repository.
>  
> -'option deepen-since <timestamp>::
> +'option deepen-since' <timestamp>::
>  	Deepens the history of a shallow repository based on time.
>  
> -'option deepen-not <ref>::
> +'option deepen-not' <ref>::
>  	Deepens the history of a shallow repository excluding ref.
>  	Multiple options add up.
>  
> -'option deepen-relative {'true'|'false'}::
> +'option deepen-relative' {'true'|'false'}::
>  	Deepens the history of a shallow repository relative to
>  	current boundary. Only valid when used with "option depth".

The syntax for describing alternatives is specified as (true|false).

Also, in my reworks of syntax, I chose to remove all formatting from the
term parts of the description lists.

Thanks

