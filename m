Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877E6748E
	for <git@vger.kernel.org>; Fri, 17 May 2024 14:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715956468; cv=none; b=RjYAi5S97jN/It6EjPzC+XROiiuebG1Da/3CyvyV3sCCOklEBx0rMhQRCYqI0k0wTyFUu6hLr63LqJOaTo76tOta/NVeEw4D3j1fYEnEm3/Na4pyzcDzODidsgQ9tL1R4ujnMkF32LkeZ2SADCTJZ3jy+ag9/e4Bd850mqi6g00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715956468; c=relaxed/simple;
	bh=cMMcpcwoDifWNxx5ory2y39HUMrD2LoNWZbFLjV7W+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iU/r1Qck1Ck0Kqg33vbmhhR7y4io9Am6Xo7CJ5Rh6D1Y8O98U4Du9BYv0TX4AmHXuejxjfweSePcsUwuaf+HcOHJhb7k83CGUckk01nLVUsDGYNtrMzzFE3HBKSr5L9MafoEwjNplf9KBvE3vqa0seCzGW5t1fZ4iFftqeaRLIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OUHbPP8x; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OUHbPP8x"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2df83058d48so25173091fa.1
        for <git@vger.kernel.org>; Fri, 17 May 2024 07:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715956465; x=1716561265; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qj79eozQ1OKM3sLcL2kNhyJuHpA9NVxWkt18DFSvOz4=;
        b=OUHbPP8xYkpDCe/jSdrmWyB6bC2lkKC+NKQKBqHxSItAkvBSyM/P3MaB1A0OIXqT+a
         Wb61dmV7BoXZIxwz7hW5fgTCvejxR4XPt/ycY6jJSZQnqRP81QxFIo52/0Id4a9c5j/c
         Wlf1+4FhWkASCI6ifNDH5TJXcd/ymo92NomWP+LabKnI92Q2/sntOOsI4A8wpSngkIrL
         +33Ch60jIRRRK8MexWM06t/QGs/tBrKY4X7D2PAlTTSMXRaacLRaKO8MXDKsjbOkfZ2S
         5rbgRagBkuP+C/UTxbzPaDIt7i2jVacSddChkPqIYhwmMcNWJL75bWe9v9GsUwcUREL7
         BaYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715956465; x=1716561265;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qj79eozQ1OKM3sLcL2kNhyJuHpA9NVxWkt18DFSvOz4=;
        b=nJaw9qCKJ8v4Oo7EiSNJOgIHnUm3ATENarUAumDjyacEZX+2Otf5wbYE4g3YRdMLgB
         KZfDSsyHROnfQDopRPqw0126dauLgZxPmZiaVuUGzvXELBwcfabbPY4y9VmQfnMf3oTo
         rZAjhSAdw/XaPCf1/L+SUisbbN0InLN2FMntS8IvZNErg9Gi5RBI0aH/lj0wsMRNOccW
         h5RZps4jbHsUczGq3uZ2UMxbDdn2xdfNZucc9XSruVAXkReTjliOwXiQVSYOwOrDA3Hc
         e7Fc+LpFeVQUeJ8tnXHKakPBjR/G1i6hGuJlCVso+UCJjR3IkndntjuS6iqw9F2LDTUK
         C4rA==
X-Forwarded-Encrypted: i=1; AJvYcCX+f4gBFNqZkjnQ2M3Syz5+bb6O4rwvWrQ7b8xznNGsDGTsgKJKPmyIBE8JaBeYdwREBwGYDo/aXqJcRWQo9Y7ApMYW
X-Gm-Message-State: AOJu0YwvnaF3oe2Cv/QlVtHYxe6GgwkxXiq0plQlWOA6KnaWXkwl66V9
	h2uRcLWA70hlGoaID39GKfNR7PlQ9HSF1N7W6NcExS96zslzT8MPfniGqQ==
X-Google-Smtp-Source: AGHT+IHSztA48w8HQ5zHg1+4+47FdbRgfrNx6vlX0BP+6Xdq4JT/e6vLXxEycXvKamideyd82IQYLw==
X-Received: by 2002:a05:651c:505:b0:2df:baf3:2ae3 with SMTP id 38308e7fff4ca-2e51ff4d047mr171611801fa.29.1715956464271;
        Fri, 17 May 2024 07:34:24 -0700 (PDT)
Received: from [192.168.42.68] (home.tribuavila.fr. [82.64.51.39])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-41fd491c712sm178022155e9.0.2024.05.17.07.34.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 May 2024 07:34:23 -0700 (PDT)
Message-ID: <be7006b2-b9a8-468c-ab89-76bbd83dade0@gmail.com>
Date: Fri, 17 May 2024 16:34:23 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] SubmittingPatches: advertise git-manpages-l10n project a
 bit
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqv83muc12.fsf@gitster.g>
From: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <avila.jn@gmail.com>
Content-Language: fr
In-Reply-To: <xmqqv83muc12.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 09/05/2024 à 19:32, Junio C Hamano a écrit :
> The project takes our AsciiDoc sources of documentation and actively
> maintains the translations to various languages.
> 
> Let's give them enhanced visibility to help those who want to
> volunteer find them.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/SubmittingPatches | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> index c647c7e1b4..ff31049dce 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -548,6 +548,13 @@ repositories.
>  
>  Patches to these parts should be based on their trees.
>  
> +- The "Git documentation translations" project, led by Jean-Noël
> +  Avila, translates our documentation pages.  Their work products are
> +  maintained separately from this project, not as part of our tree:
> +
> +	https://github.com/jnavila/git-manpages-l10n/
> +
> +
>  [[patch-flow]]
>  == An ideal patch flow
>  

Acked-by: Jean-Noël Avila <jn.avila@free.fr>
