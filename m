Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1FA224D7
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 20:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752004931; cv=none; b=loN6tvC2OtLmeGt8pJ2BGF/OKwOS60IjjMauJkeZMd/NMCLzRt8vRavoNDzvwU+5qQaiSZfecCyk+Ppdf9mfm7mR3Jhq5+qY1j3ttmcV181Pk4w1ABx1DP8Fg76u35pqndEI/0O/lVQQK6s3xhTCZodDJuN+dt9knUZSI2izULw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752004931; c=relaxed/simple;
	bh=i1YuFKgL3RDwNXtqfnViraTtZVICv288r0zgxLDIlvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ELfuYIt7k2B3pCA4wG+l2zNmr4CHAVPHUARASWngBAmGuX3PB8xtdUKWeOVITNzUUy1izwqy3LGZ1MexWx+uSv4ruNPBnOvcQAicKIVyWSzpwxW+xGPNBYGgw6lRozkA7JsYXmnrcPnLgTWWaiDmBfeGPf7ZRsbrulW8G+xP2TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XsDwD1D8; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XsDwD1D8"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2ea080f900cso1334191fac.2
        for <git@vger.kernel.org>; Tue, 08 Jul 2025 13:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752004928; x=1752609728; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ukl+FYYT6cG2Z+7NOHkXQAX2HqSMIsXK1BNVj32SvfI=;
        b=XsDwD1D8g0dGR8k6FzlKYV0QK8u5fkq6gJ1n/Lka4UQzfCrRBPDK3o2JexP3O5SGC9
         e8b+5quWm3TMHKmwMJcAvJilp4CLQlaVSRGWb3GoIuq+t9RObxSlLtClwNFV2k8ekWBG
         7Em66rU2//WSL88S1JDlPAUgJBf4Tw77JbnStg7Z+Zadxe+vQwh6LJ1nZRF9NPOEhLhC
         i9Og2OEAe+tNKFSCDIo8nZZoPvLmiVMj6KiRWNseUbIWKowW3+1xzXIIxEZRIjyMU6sl
         Nfv0l1jRJ6OgDzX48BtfoJZX/LsZ/haCw53m+x0aAMGMxIIeH7hcOJZrp0ts7/XvUPyB
         +NGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752004928; x=1752609728;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ukl+FYYT6cG2Z+7NOHkXQAX2HqSMIsXK1BNVj32SvfI=;
        b=Hr+u3cHh1BRdmd+kQ0q6+FwDDo97g8Y2wegYunSdDJVa8GFC6EPHvKN+IM6+S3CQY6
         ubmYtsbxMwnhWtU62hiXrcDo+L02gRV2l5e36XBN5DP35DtHreVvtDOn7T+svP1mHnv5
         WfrYZ3AWi+htn0Y5IuFKAtL8hoXJmGJ2/pXeO2ksqtfv3BTVe+GBjnL4bPENQXY1xTlX
         ky0yWnwHC/OMbmaSdwAQJq0zwSkCVOQyFVY37zOBp0uC9dx1G75VAEbbYSTgShmeTtQH
         W03qO/yu3UwY3tOEmHiDNTOn1+723jxsJoqTucY9z9HLEGYWyoOrxaF/gOmvFv4AyK19
         2i2Q==
X-Gm-Message-State: AOJu0YwIVrmv5kX9X7I7aReyM1Ua77Bd0phepu4887f4wWKheeePjIbv
	0r2EuHHGBFOlWHPdFy9Mt5lkHhSQKPEO0oQCFoCB/vcY4aDsoicscYal0x+tBQ==
X-Gm-Gg: ASbGncu6jfRP/gtG5XAWh2hJj9LfBvm5Sk//80GmywPMfUDrab4yk02y69kwsEpx85f
	gpM0w0YLWVaFPLgloQUY+ZD8HzYRa21e7vKLWUasiInjYiVnUSPmxeWrN+etYTtRLihqaPm3kZB
	65Q2xRJ1iwy5TRxcuecvDdLBn32W8XRJ6Ce8j5mphQHNSDuqcIYPF+cfl2Wr+O930HBnlckqDwc
	X0DVsvfksK7ruHDMhIgA25qXjCGox/W2yDyiiEFjWQxLztWqUaDa35klHKzWYzwLOMGDvA/09/Z
	kjPsB8X0Rn0f2n/HmivIw7Sv+zkUOdPZ/5YftSQdHwvww0AOlIFihX4=
X-Google-Smtp-Source: AGHT+IH7momzzAZEUjkxA6JPPccwTomCKaZMzVx7BaO6bjOUWhgkROhOSmmQp7B2HNMPvjzT207sjw==
X-Received: by 2002:a05:6871:1d1:b0:2d4:ce45:6993 with SMTP id 586e51a60fabf-2f79206502bmr14087847fac.30.1752004927839;
        Tue, 08 Jul 2025 13:02:07 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-73cdfa7844bsm253831a34.57.2025.07.08.13.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 13:02:07 -0700 (PDT)
Date: Tue, 8 Jul 2025 14:56:32 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>, 
	irecca.kun@gmail.com, Eli Schwartz <eschwartz@gentoo.org>
Subject: Re: [PATCH 3/8] meson: improve summary of auto-detected features
Message-ID: <apzpu3ydbiyfxckqewqfsgjqm2kwpisj3gx4q5cb73ntsldxqy@vfzpgnu57rl6>
References: <20250703-b4-pks-meson-cleanups-v1-0-2804c2932abe@pks.im>
 <20250703-b4-pks-meson-cleanups-v1-3-2804c2932abe@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703-b4-pks-meson-cleanups-v1-3-2804c2932abe@pks.im>

On 25/07/03 11:28AM, Patrick Steinhardt wrote:
> The summary of auto-detected features prints a boolean for every option
> to tell the user whether or not the feature has been auto-enabled or
> not. This summary can be improved though, as in some cases this boolean
> is derived from a dependency. So if we pass in the dependency directly,
> then Meson knows to both print a boolean and, if the dependency was
> found, it also prints a version number.
> 
> Adapt the code accordingly and enable `bool_yn` so that actual booleans
> are formatted similarly to dependencies. Before this change:

Ok so without `bool_yn` enabled, only the dependencies listed directly
would say YES/NO and not match the other entries.

>   Auto-detected features
>     benchmarks      : true
>     curl            : true
>     expat           : true
>     gettext         : true
>     gitweb          : true
>     iconv           : true
>     pcre2           : true
>     perl            : true
>     python          : true
> 
> And after this change, we now see the version numbers as expected:
> 
>   Auto-detected features
>     benchmarks      : YES
>     curl            : YES 8.14.1
>     expat           : YES 2.7.1
>     gettext         : YES
>     gitweb          : YES
>     iconv           : YES
>     pcre2           : YES 10.44
>     perl            : YES
>     python          : YES
> 
> Note that this change also enables colorization of the boolean options,
> green for "YES" and red for "NO".

Ok, it looks like colorization it not an explicit option, but comes
automatically with the `bool_yn` and dependency change. Nice.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  meson.build | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index 4e41c3007bb..4f22d72641e 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -2193,15 +2193,15 @@ meson.add_dist_script(
>  
>  summary({
>    'benchmarks': get_option('tests') and perl.found() and time.found(),
> -  'curl': curl.found(),
> -  'expat': expat.found(),
> -  'gettext': intl.found(),
> +  'curl': curl,
> +  'expat': expat,
> +  'gettext': intl,
>    'gitweb': gitweb_option.allowed(),
> -  'iconv': iconv.found(),
> -  'pcre2': pcre2.found(),
> +  'iconv': iconv,
> +  'pcre2': pcre2,
>    'perl': perl_features_enabled,
>    'python': target_python.found(),
> -}, section: 'Auto-detected features')
> +}, section: 'Auto-detected features', bool_yn: true)

Looks good!

-Justin
