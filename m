Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F26328A40B
	for <git@vger.kernel.org>; Thu, 10 Apr 2025 14:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744296660; cv=none; b=RkcYx7RWGfaIRoZ/afMT+6bkFuTbgdeKjzLxA3x2Qa1CQp3flXDQeWRCWXIRMmUwDR+Z4iDPzp/wHITi1HrmqzTFukFFdL1t6adwfh9a961YAOffWnPxSgb7zyMBNV6137crdfuXiJZ+8jd599AcRExKjyesz8aOxXspLyvQLI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744296660; c=relaxed/simple;
	bh=T6PQGRpSUjjxNmCrRNGUgJkq9uL3/g8Jn7c2TjOtKgs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cHb2jdbU048J1qINIv8PdJ8XIFEr5mzpZOQIQxZS6+BbNohYpU2Ksos/z+I2Ebe8nL2xoA/Tt7CH7z4QF5rQMYjNHn0sNZUUuqq1vyqSAnw3XoFgJHIwXfHrSWbX27uoBeKoo2GlhVKF1HVElOmJxCf2PcA1qPfH3JHbnioIJ3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y913owt3; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y913owt3"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43d04dc73b7so10204005e9.3
        for <git@vger.kernel.org>; Thu, 10 Apr 2025 07:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744296657; x=1744901457; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cMVv6tN3rxv7QMP1Rkcd2U4wnnGKQbhGG6WFQz5dPBI=;
        b=Y913owt3RkeNgLgXxWHxnP82lIVajoZLjA65v7mx68jD21UNUiIVKyp146KVC+yDdo
         X0d53VG+pxDhmbOfbbvHoENOhCPqYB1z6A0rFqjq11/qVOSV0QO8AyMSrtUVHP+KMZ6X
         +sKboJTsLE7x3BRM8PJe3LamxPOo3hUS0UPg6h45GnKqly4fXlt35QQm13i6aGkxNAJL
         Mxv3HIlFduIKtZKFhWXdD38jl5xFJfacxLhzRAKH1r4TKCvW2JJLwZgpKu8qEQX5u9CZ
         yD95tfgixouycVo+0bg3UvvTzFMFJxakLer4nX4XNujPXKiloA22eJqBUTMt6FjppvZ1
         UK9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744296657; x=1744901457;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cMVv6tN3rxv7QMP1Rkcd2U4wnnGKQbhGG6WFQz5dPBI=;
        b=KjcOoApYGBFoJyrwbi21N8p9tXDSYhFZj70CAgm616KnVPEt+3+vPpkzLk5ML6KtvX
         sfjQS8TYdB4WyUdahnQiwfYgpWUr8R1XmcbS2UcY6UdH9pUu4yVdDvVXYTLD+wZlWbbp
         CrE4H12z2CN7NkRK0cOqUkQRJ894nYW5ecA2jCFli8pEnUi4RzLhhd0ahfQojM4m9wLA
         rK1mZ91oi/yZKulIOGRG4Sd6B5GgfaDtE4Nfvw5bVlqwpu44AT/RfIUsu6zgYMrt/Gb6
         skR7p2rUBuZpenQkw9YTUWJ2vZDuhQif3wYS4O4oTPr60o6dEZSCCo2zshEebWwayiVb
         OhAw==
X-Forwarded-Encrypted: i=1; AJvYcCUmDKd2xogmVrQO1TJdHplZxOgOqBXY1Xl4RkGkxkwMZlFZWfb1DkJxzs6jITSnce9kRaE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws24HhZyYlYif9ULDHRnEnI61hg/UoFu0wOcUY+x0npOwVX9kB
	jnKZR6bOI/5451mHRyWNQkptHDIC6Ctogt20tfPAEz0tPaA4hpkJFTi3Yw==
X-Gm-Gg: ASbGnctWFQvju5D2suBN1O9HIvFV1PRnXZ9JiR9n25KA14/XWLVrAR8PkK4UQ13ez3H
	josJ4MQUIzsW3GiQMm6gkg6weG7XgtPGecL6WMbAARixRCnlFEC8YnLraGcd/xhhJGFNNnx97eN
	Bi5AyRdKci8jo2ANH8KqsONR3UA9eKXIvf9lg83gnTjyxUz69q4dVLM79NilYebV9+m5KonJz7W
	C9pRwBdAM9dTnio7f2Q4uX2RMcPPUVTUgiBqDrKi7I1+O3bAeOIfdpA+2eXlCUN7cy9DwJB0aB2
	GqMvPp1mxjRUPzVQQGBALyQc2bYjtKdYmvXrsy0+I0k4bOfuJuO5qcJNRHUd83kTWNJlGV+BHDB
	IIUkTDeWcT4E5yW2w
X-Google-Smtp-Source: AGHT+IEjOyBzJcJWcHLfJq/YOdl37Btn86znxMyd3lVbSinQnorUc3imh7l+Q0fRuXI2BK0dg3H7NA==
X-Received: by 2002:a05:6000:1864:b0:39c:2688:612b with SMTP id ffacd0b85a97d-39d8fd3d4ebmr2659480f8f.7.1744296656650;
        Thu, 10 Apr 2025 07:50:56 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39d893773c1sm4942936f8f.24.2025.04.10.07.50.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Apr 2025 07:50:56 -0700 (PDT)
Message-ID: <7eaa33ca-0ccc-4789-94b5-de1a068e1599@gmail.com>
Date: Thu, 10 Apr 2025 15:50:45 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 4/4] makefile/meson: add 'headers-check' as alias for
 'hdr-check'
To: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Cc: jltobler@gmail.com, toon@iotcl.com
References: <20250410-505-wire-up-sparse-via-meson-v2-0-acb45cc8a2e5@gmail.com>
 <20250410-505-wire-up-sparse-via-meson-v2-4-acb45cc8a2e5@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20250410-505-wire-up-sparse-via-meson-v2-4-acb45cc8a2e5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Karthik

On 10/04/2025 12:30, Karthik Nayak wrote:
> The 'hdr-check' target in meson and makefile is used to check if headers
> can be compiled individually. The naming however isn't readable as 'hdr'
> is not a common shortforme for 'header', neither is it an abbreviation.
> 
> Let's introduce 'headers-check' as an alternative target for 'hdr-check'
> and add a `TODO` to deprecate the latter after 2 releases. Since this
> is an internal tool, we can use a shorter deprecation cycle.

Can we call this "check-headers" to match the other "check-" targets in 
the Makefile please

Thanks

Phillip

> Change existing usage of 'hdr-check' in 'ci/run-static-analysis.sh' to
> also use 'headers-check'.
> 
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>   Makefile                  | 4 +++-
>   ci/run-static-analysis.sh | 2 +-
>   meson.build               | 2 ++
>   3 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index ac32d2d0bd..0ac91e0af1 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -3326,8 +3326,10 @@ HCC = $(HCO:hco=hcc)
>   $(HCO): %.hco: %.hcc $(GENERATED_H) FORCE
>   	$(QUIET_HDR)$(CC) $(ALL_CFLAGS) -o /dev/null -c -xc $<
>   
> -.PHONY: hdr-check $(HCO)
> +# TODO: deprecate 'hdr-check' in lieu of 'headers-check' in Git 2.51+
> +.PHONY: hdr-check headers-check $(HCO)
>   hdr-check: $(HCO)
> +headers-check: hdr-check
>   
>   .PHONY: style
>   style:
> diff --git a/ci/run-static-analysis.sh b/ci/run-static-analysis.sh
> index 0d51e5ce0e..2e51411d6e 100755
> --- a/ci/run-static-analysis.sh
> +++ b/ci/run-static-analysis.sh
> @@ -26,7 +26,7 @@ then
>   	exit 1
>   fi
>   
> -make hdr-check ||
> +make headers-check ||
>   exit 1
>   
>   make check-pot
> diff --git a/meson.build b/meson.build
> index 6fce1aa618..74597283b9 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -2099,7 +2099,9 @@ if headers.length() != 0 and compiler.get_argument_syntax() == 'gcc'
>       hco_targets += hco
>     endforeach
>   
> +  # TODO: deprecate 'hdr-check' in lieu of 'headers-check' in Git 2.51+
>     alias_target('hdr-check', hco_targets)
> +  alias_target('headers-check', hco_targets)
>   endif
>   
>   foreach key, value : {
> 

