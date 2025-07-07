Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCEB25A322
	for <git@vger.kernel.org>; Mon,  7 Jul 2025 09:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751881238; cv=none; b=g/U4SYeZDSK7yUTIaucPz6bpc8qRWGNcePRUwKIphLb56htnz0MDRxmJkNe43UMRiSdbxIG/gQ5jtqky23a05ghlO6/3YFJAumOUqIhEq5CbJD9+nz3MXDxozMoFwIKGwFdh12dHU/FNYqXtTvkp3l6pFyfhP9yIExOVZgQMNJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751881238; c=relaxed/simple;
	bh=UAvycQFIdIwnRv3jT9vRULtu6qXdEXXtt4jKftRTLUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pr+FzNLNOqLtTwYSShqICAxyvyOuNVl39j2qi0GlqW7r6SYv53BOO43wjf/ApyoeC+JY+cOVzHDJXtB2otY4fg/3RUBjHfoEN6UQhkbo6OJPmT0rkzr+trxissCMI+Ci3xKrk1eTKDdkG50EHoNjeJGpEspZIK36hPoEtNSRRIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mR+Bp2mR; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mR+Bp2mR"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-450cb2ddd46so14132285e9.2
        for <git@vger.kernel.org>; Mon, 07 Jul 2025 02:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751881235; x=1752486035; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DOpNtpGEz+b8HGhf3ZcSjnykvrp0DrJr/5kWe8rI1BM=;
        b=mR+Bp2mRMXA2jkOMowTnZNEi6AZu+XUvlzGnKPWmMcFLeZ/tRIV4ElpUCVWFYARRPr
         2L/j30qQKX6iPA4kkPpidtz+RDHBv0zbp5eDT8Q2t8MZBwk3o+pR93XN54xXy+5ADfic
         O3FTSj/eXTE0NQ6rp5hAp3TmTbxjlBKy3ZVJWZs3fpLt+fjXNYxVT2ceMklV4REzd6gM
         o/nfD6uHR5CCpb/CE/vuD4qaKZyscQISeJ+aZzoE95TrX7uDwysHTuS0eoM0orhpBlYa
         P8W/9M82VIwjNuXcaxqD9HDu2PlBJPfVNL2FYf6u2oc0/4Cexpm/sFNOPB8hM1m6rESn
         vi0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751881235; x=1752486035;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DOpNtpGEz+b8HGhf3ZcSjnykvrp0DrJr/5kWe8rI1BM=;
        b=R+RWnApD9ZoKT5Y/KiUY/LYy+OZxcwm4nrAQiLcr6VQPetlyZ6YTShk3FwLHTf/Py1
         PSGe65RA0K2E6BAzDRdWREtOTMRUMbV/dLMi3syr2j6KrdiHbc2RlOIlHXIgOuhPG8oS
         Ued0a6Y2Ge8SvvOUpwuDtGHHLt6sDWxYEekRK6ylhCLZAnqYVDCn5aOEcpAjrjeFVGpZ
         R3O1qf21rnSOiCZCAW6WSzglFu8YCxXeaDCSl5ezN24bmmvAeaS1/9HWPg6hFMvCVnnP
         l+9KxtyeJOlxgSdSFTlrL8bqDtV/OUGth4IW1bEpKHrjJCaQdTWBwV5hsjyaKlE6buSC
         0Wbw==
X-Forwarded-Encrypted: i=1; AJvYcCUxmG83eyzmZjE7oV2WWEQH54S4lz33g95v3dW2U9X4a4YaDojQHLqtL2qkxoLPNpI8SSc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlEvVkLwrkR62qWD6vB8z5OgcEW5DqmHssADTimioly85kw3qq
	b978SNdyc6o2sjnOWQ+NeWqRC/lI5KzAYgOFRlBUx6YjsclGscMTXxphaDxwlg==
X-Gm-Gg: ASbGncvC6PhoTFlQNjWtrnPlULPsrI2AfiZ3aqApDaw8/Nl67rL8tNloJTaXnev9swQ
	4HBI7XZ73XQUQ0wZDIDPedgDtfCEuSxIacvos2BJa+LnxHurqukD0BY7tm+hlJJunDlLda4fB+0
	Hdn5QCZ+m+CFibEu6W5/jY4LRb6vXlGvD6eNwkoUDtNTepmAxWB/VROS+nEbY1K6AVXFrt1/0UD
	X7+PZi41NNdovcykHuPNX8fZTYL7uhz4gY7724lnQqIEM4AsFdWvQJ8aE3zMjv0wa9JQMLEfMvX
	3P715xq5oG7WWXjOBdgVYYqV6EcemEPeYOsGX6gMs8irnQ0mLWNErJBbXMC9mb1tEePRwRfqQWx
	aEPWsuyM0swVFcAWF3+uSmin9TaGuKtEIKnYDu5OAq83BZ6fE
X-Google-Smtp-Source: AGHT+IEYnlzvdrbfD8ueyu4SWpugjsrVrqyUgnd1WT7zgNMaVtY3LmGvfgE44fyLA4DtEZHAbnDDRA==
X-Received: by 2002:a05:600c:4fc4:b0:442:d9f2:ded8 with SMTP id 5b1f17b1804b1-454bb7d8da8mr85041755e9.15.1751881234960;
        Mon, 07 Jul 2025 02:40:34 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b4708d0beesm9782895f8f.36.2025.07.07.02.40.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jul 2025 02:40:34 -0700 (PDT)
Message-ID: <585bc9d6-1fe5-4a77-b82e-db42175776a6@gmail.com>
Date: Mon, 7 Jul 2025 10:40:33 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] SubmittingPatches: allow non-real name contributions
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
 redoste <redoste@redoste.xyz>
References: <20250706163009.335780-1-sandals@crustytoothpaste.net>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20250706163009.335780-1-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi brian

On 06/07/2025 17:30, brian m. carlson wrote:
> Our submission guidelines require people to use their real name, but
> this is not always suitable for various reasons.
> 
> For people who are transgender or non-binary and are transitioning or
> who think they might want to transition, it can be a major obstacle and
> cause major discomfort to require the use of their real name.  This is
> made worse by the fact that Git provides no way to change names built
> into history, so the use of a deadname is forever.  Our code of conduct
> states that we "pledge to act and interact in ways that contribute to an
> open, welcoming, diverse, inclusive, and healthy community," and
> changing this policy is one way we can improve things for contributors.
> 
> In addition, there are some developers who are so widely known
> pseudonymously that they have a Wikipedia page with their handle and no
> real name.  It would seem silly to reject patches from people who are
> known and respected in their open-source community just because they
> don't wish to share a real name.
> 
> There are also other good reasons why people might operate
> pseudonymously: because they or their family members are well known and
> they wish to protect their privacy, because of current or past
> harassment or retaliation or fear of that happening in the future, or
> because of concerns about unwanted attention from government officials
> or other authority figures.  As much as possible, we want to welcome
> contributions from anyone who is willing to participate positively in
> our community without having them worry about their safety or privacy.

These are all good reasons why someone might not want to contribute 
under their real name and I agree we should accommodate that if we can. 
I do think though that we should run this change past an license 
enforcement expert at Conservancy to check that it does not materially 
alter our ability to enforce the license. Assuming Conservancy are happy 
then I think this change is a good idea.

Thanks

Phillip

> In all of these cases, we should allow people to proceed using a
> preferred name or pseudonymously if, in their best judgment, that's the
> right thing to do.  State that it is common to use a real name but
> explicitly mention that contributors who are not comfortable doing so or
> prefer to operate pseudonymously or under a preferred name can proceed
> otherwise.  Use "some form of your real name" since some current
> contributors use shortened forms of their name or use initials, which
> have always been considered acceptable.


> Retain the prohibition on anonymous contributions that the Linux kernel
> has to ensure that we have some line of provenance to a known (if
> pseudonymous) author who might be able to respond to questions about it.
> 
> This helps guide people who would be fine using their real name but have
> misconfigured `user.name` thinking it is intended to be a username or is
> used for authentication (despite our documentation to the contrary), but
> also allows for a variety of circumstances where the contributor would
> feel more comfortable not doing so.
> 
> Additionally, retain the section header ID for ease of linking across
> versions.
> 
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
> I don't claim that this is the best possible wording and I'm open to
> changing it.   The term "known identity" comes from Linux, but if we
> need to clarify using different language or otherwise change any part of
> this up, we can do so.
> 
>   Documentation/SubmittingPatches | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> index 958e3cc3d5..a4f4ca0205 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -408,8 +408,11 @@ your patch differs from project to project, so it may be different
>   from that of the project you are accustomed to.
>   
>   [[real-name]]
> -Also notice that a real name is used in the `Signed-off-by` trailer. Please
> -don't hide your real name.
> +Please use a known identity in the `Signed-off-by` trailer, since we
> +unfortunately cannot accept anonymous contributions. It is common to use some
> +form of your real name. We realize that some contributors are not comfortable
> +doing so or prefer to contribute under a pseudonym or preferred name and we can
> +accept your patch either way.
>   
>   [[commit-trailers]]
>   If you like, you can put extra trailers at the end:
> 

