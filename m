Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EAB2F7CE5
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 18:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751481782; cv=none; b=UJBLpqS7R24Q9RnRMbCwo01Q5IsXceJJkqYwff7p9PetxTvtz8eQArPALarQefhpViK2in0ZTgwKnx4ZRN6/5rUCE1rFkt4TxSdPIpm5mtmGNqYg8KNH34mOGydPvMvPyxx1BG8IXO7QCiFpuiiO8daC5WsomvsUwcg7xzuVKXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751481782; c=relaxed/simple;
	bh=AJU50KUg6iDJjdrduVoJ8lWSI9irIA8dxXw0Lur+JYo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XyJYdjkU85eQmETnjkMt1+GOLPrpAFTWb6KRmvUf10/bp8jS7APcYt9VfQiQPakkpt0MDkr3rC3fnSyFWrmCqCLhykA1ix18DOCLx8n9ICxios42WenA3hwvDc29aO4tTYxkw0V/KgeCVfVeCnSPOXqVv1gqLB7gzfXWv9A5/2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Whtw5KLK; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Whtw5KLK"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-23649faf69fso43740035ad.0
        for <git@vger.kernel.org>; Wed, 02 Jul 2025 11:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751481780; x=1752086580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:sender:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MnzyYzPFHNCUPXtJzrUbBf2G7obY5fgA8kFFoayy/lQ=;
        b=Whtw5KLK5huDW+OXNmUDz2Ct2Vzm989gtilmGT7C4qKxDGAsp0v8SYNZ/8FlEnFxus
         VzM1tO5gBZbc7M2DmS48+pmwUxTGWpm72xjaPEplSAcdH/o0FwnEM846K6CVTJX2scil
         WburHMCg41Vp9rXa1FHn6IKtkudbVwthF+UmSFFy+OjK1R7bYBNiuSJ8V8wD06HmMXbf
         /V7yNDl8YdIRi9ELEq2r/oRU5PQTpGaibNssTeVY/gHbH9fiGaiM3Wt1QhUjggT+aaqc
         1jBzEq7vMoaMFeNfYB6lYVCON4cmzbi2DrUDnTJKNLbX+sUSC4bwDul0p5zS2klHQ4Kd
         GXng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751481780; x=1752086580;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:sender:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MnzyYzPFHNCUPXtJzrUbBf2G7obY5fgA8kFFoayy/lQ=;
        b=ldsukGVAYiwKZDQDqYNSvAsRf7zrL4lvjZWv/4gwdnCRD9bs82VjOxoHdE/uxzI2kV
         2jPJaUxQ0A8d7hi2tLdYKgxjFwjGmcUVDY/6qaYJFMMU/xudAL6TL6cJR6HdhJ7Q64HU
         WykjfRdNxXRIPBSh3P7OERDgJGSOdvmVG0SUYj+coExDMxZheUAq1KC5YQ3BFPU7/K33
         Mspt0XcjW2MAtB5aqMlAxgdVTCxKU3Fv9Izwah8ti/Ty1D6VKG2tb1LWJ5163hWEkO9F
         zIcGmjWWafWxYEengSfpq+1FhcQz30bZQmZf2Q68c95Zit3Yx0v6TpR2J4sz9y6yz210
         Fg1w==
X-Gm-Message-State: AOJu0YwX8AaFg6qjLls+qBTvUYfYxAa59+Mztrb+4zKITVA0mXOcvUGA
	sZcWkstzxAJAHB0PBeEujg0xHSgCwDD44X++zAASMpoMcZDl+OJZBYYDJpxA2A==
X-Gm-Gg: ASbGncuA3MTzeXoYhw6N/U8ZfpQUAS6EzXfiUEX/OyttHX6exHhHyItUugs1YRt+BAn
	LBhWhAWaeMvP1nNGC7oUxPFWDUcNA1PKviRsAb16CrxDldR/n7j5PSz8x8UHDU6/9E3T6kUBjYy
	QaqP79KCLksF78s88XyVfcvAIGkYrY0bpJ6BJ0eYcwMkG1MM0mv7LbMOSz2YKMM/BFQeVrrW2hb
	YeI/HPGgb/Auag5INEllQHIRnvv+j9milw9PkkBIUkhrnf1RK/JUI1dhunCMJ9rXdXKxG4+KgZ/
	TPkHcIr6+kqeLE+rqcLHntx4HBrLu9aIO1tdGD6Wy45FEG6k83Vp0NR5c685jDAhKq9PzjA/quS
	BF6dD8F/wwLzAB1OS1Su6pdFXQ3vz6EbrOo1NeA==
X-Google-Smtp-Source: AGHT+IF1sArSy2/IQTpQWqO3b1PYBjHi/ZjIkWNf1zXOLg2WFseXvQJGkrCDnu/i5RlDw4coGszOPA==
X-Received: by 2002:a17:903:40cf:b0:238:d19:8645 with SMTP id d9443c01a7336-23c6e5844dcmr54614655ad.47.1751481780167;
        Wed, 02 Jul 2025 11:43:00 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23acb3b7abdsm141505545ad.169.2025.07.02.11.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 11:42:59 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc: git@vger.kernel.org,  pclouds@gmail.com,  brad@comstyle.com,
  collin.funk1@gmail.com
Subject: Re: [PATCH v2] builtin/gc: protect against sysctl() failure in
 total_ram
In-Reply-To: <20250702154649.44210-1-carenas@gmail.com> ("Carlo Marcelo
 Arenas
	=?utf-8?Q?Bel=C3=B3n=22's?= message of "Wed, 2 Jul 2025 08:46:49 -0700")
References: <20250702144244.43858-1-carenas@gmail.com>
	<20250702154649.44210-1-carenas@gmail.com>
Date: Wed, 02 Jul 2025 11:42:59 -0700
Message-ID: <xmqqikkacu30.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Carlo Marcelo Arenas Belón <carenas@gmail.com> writes:

> In the unlikely scenario that sysctl() fails, and uninitialized
> value could be returned.
>
> Initialize the variable used and make sure its expected size
> was correct before using it.

Oh, that's interesting.  I wonder if the system returns physical
memory in 32 bits, we would want fall back doing something silly
like

	if (!sysctl(mib, 2, &i64_tmp, &length, NULL, 0)) {
		if (length == sizeof(i64_tmp))
			return i64_tmp;
		else if (length == 4 &&
                	 !sysctl(mib, 2, &i32_tmp, &length, NULL, 0) &&
			length == 4)
			return i32_tmp;
	}

> While at it, add a cast for consistency.

OK, I do not mind being more explicit than necessary, but wouldn't
"return X" take care of casting X to the expected return type of
that function?

Anyway, thanks for improvements.  Will queue.


> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
> V1 would regress FreeBSD, so instead make sure that the obsoleted name isn't
> used in OpenBSD/NetBSD instead
>
>  builtin/gc.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/gc.c b/builtin/gc.c
> index 845876ff02..3958707feb 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -539,7 +539,7 @@ static uint64_t total_ram(void)
>  		return total;
>  	}
>  #elif defined(HAVE_BSD_SYSCTL) && (defined(HW_MEMSIZE) || defined(HW_PHYSMEM) || defined(HW_PHYSMEM64))
> -	int64_t physical_memory;
> +	int64_t physical_memory = 0;
>  	int mib[2];
>  	size_t length;
>  
> @@ -552,8 +552,9 @@ static uint64_t total_ram(void)
>  	mib[1] = HW_PHYSMEM;
>  # endif
>  	length = sizeof(int64_t);
> -	if (!sysctl(mib, 2, &physical_memory, &length, NULL, 0))
> -		return physical_memory;
> +	if (!sysctl(mib, 2, &physical_memory, &length, NULL, 0) &&
> +	    length == sizeof(int64_t))
> +		return (uint64_t)physical_memory;
>  #elif defined(GIT_WINDOWS_NATIVE)
>  	MEMORYSTATUSEX memInfo;
