Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6647F7CF29
	for <git@vger.kernel.org>; Thu,  8 Feb 2024 16:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707409140; cv=none; b=LnvR9/XLl8uSintvDXL1/dE6KDWe/3PJa6kvet9QTLi9+jMNF8AOQJnqFv6i0eaNZD+pIDbUYWGEwswKseCwZXHIQWbDXfkFh+i1FVf8WO5HxRr7aNWJKUMmQfjXoxatel4a6zRjuqplU5NvoTX3T953XK2HL4pUhUzMH4r1N/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707409140; c=relaxed/simple;
	bh=uxdomd6Hc79dG/83+Gzr+eg6fVyRxWFJvCVg4nn6xSI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ul6E0oRDE6mttzppnlSnyD9mp0bcKeJxsUpdcUSUFPJ/mRERVfHD4x1SslZhvYvzoWZOE/cp7Lb+2FSnzamiQxsBgQndLy2S/nGVxw6iSXUKzUYjjm+lTTPJg4XOhejaq9PgzTq5cpGaAix0qc0yo6sLWgGC5cpRKgdL2IQoTtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OWEQ9UKh; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWEQ9UKh"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a37721e42feso257923866b.2
        for <git@vger.kernel.org>; Thu, 08 Feb 2024 08:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707409136; x=1708013936; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DdAJnuXYuxbOLpwLmSrmgT1QdFoILSKNwEe1CSkaZy4=;
        b=OWEQ9UKhKRCmu/FbgE4AjDW3PjtzgIELo9nBvr3a7wsEyLFFRU9DBQ5cH52t7ZHggP
         4PARxS0+dVmzSnZOzda0ZQm8DqqB48UT7IUAp6L9ysXZuxtGJMNyQkjRzMnYpywq7hd2
         vRHK9FKK3QTMG42k2zo+RV6IePSniZw+LJc4X6LCzxHePaiVlJL1UirmdZkqcqwZFT1V
         mb4GHGGPH6BorgH+F1rJttakTezgE/9Vk9FnWOVb704rchXiCL3rjfUc4keioO5dP75K
         pGfiAPxvl0BGInEQgZeoJH+7fLyAi1BW9NtF0bdxhI/HzNrSt4A2Wp12+ivkMHfuLH1C
         iFWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707409136; x=1708013936;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DdAJnuXYuxbOLpwLmSrmgT1QdFoILSKNwEe1CSkaZy4=;
        b=RkSY+5SNq3pMK+l/MsHhQpup53vIJMI2EVzrn3sd6PCxfzynPYRVsA7tLXWz0kDFGd
         3hkLJ0lxIb2JH06IomKE/EPMjTKl6YfPSfL7EV3gTYcCmgKsfD+bQK5/roSjQsH1nTDV
         JCY/rRSRiYJWeoMSCBlO3nPKxifap80uDvU07jSaKQUPVTai2kU60FZJT3SVfbxlG4Eu
         S4Ffzg2GVLu/h5cqIFQZXnRhJ4d1dHZGS33W1cQy86XDoK7qsPqV85d1Hlj+Jh4kj3eW
         dQNm1X4SatsT+1QezBcbWj3k3Rapd7VA5umLe7lcxAtOHc77EjKD4whLSqNfMzIQHmKO
         jOwQ==
X-Gm-Message-State: AOJu0YyMusnm6P7guJDf+1rHpTAQs058JuXoyfVZzIWx+XYCnos2N4+4
	G3NJDgvf8MVjzrppHY6ZRhtDj4XNTE0KiQ/mQyNkaDJQxus4EmGngzCb3pWx
X-Google-Smtp-Source: AGHT+IHZbsGjCNwXO8ggK3qgEHH+kNwYX/LTLZDuusGqrJGpLZDMnN6T405/xlluNEZZM1S/rfh+bg==
X-Received: by 2002:a17:906:3281:b0:a38:1522:77eb with SMTP id 1-20020a170906328100b00a38152277ebmr5760030ejw.0.1707409135804;
        Thu, 08 Feb 2024 08:18:55 -0800 (PST)
Received: from [192.168.3.191] ([92.173.128.58])
        by smtp.googlemail.com with ESMTPSA id ga6-20020a170906b84600b00a371c568978sm197389ejb.150.2024.02.08.08.18.55
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 08:18:55 -0800 (PST)
Message-ID: <21ec33d4-4036-4763-9117-fbbdca1e2273@gmail.com>
Date: Thu, 8 Feb 2024 17:18:54 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] bisect: document command line arguments for "bisect
 start"
Content-Language: fr
To: git@vger.kernel.org
References: <24a42fa6-7bc4-4a3b-8bf4-a0ef85dc457a@matthieu-moy.fr>
 <20240207214436.538586-1-gitster@pobox.com>
 <20240207214436.538586-3-gitster@pobox.com>
From: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <avila.jn@gmail.com>
In-Reply-To: <20240207214436.538586-3-gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 07/02/2024 à 22:44, Junio C Hamano a écrit :
> The syntax commonly used for alternatives is --opt-(a|b), not
> --opt-{a,b}.
>
> List bad/new and good/old consistently in this order, to be
> consistent with the description for "git bisect terms".  Clarify
> <term> to either <term-old> or <term-new> to make them consistent
> with the description of "git bisect (good|bad)" subcommands.
>
> Suggested-by: Matthieu Moy <git@matthieu-moy.fr>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>   Documentation/git-bisect.txt | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
> index 3d813f9c77..73f889b97b 100644
> --- a/Documentation/git-bisect.txt
> +++ b/Documentation/git-bisect.txt
> @@ -16,7 +16,7 @@ DESCRIPTION
>   The command takes various subcommands, and different options depending
>   on the subcommand:
>   
> - git bisect start [--term-{new,bad}=<term> --term-{old,good}=<term>]
> + git bisect start [--term-(bad|new)=<term-new> --term-(good|old)=<term-old>]
>   		  [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<paths>...]
>    git bisect (bad|new|<term-new>) [<rev>]
>    git bisect (good|old|<term-old>) [<rev>...]


LGTM

