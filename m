Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEDE3FFFB5
	for <git@vger.kernel.org>; Fri,  5 Jun 2026 15:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780672156; cv=none; b=Mt6/3byPwhAUbgXfNzB/M0uSTCcawehH2PuXJnjiPRGirhKUTJdm5AvGSfbzWh4DpqqPhWTNp6W3IkRiH5YKyi0fO+Yo6WknQNl8eLN7tvdA3zniO1Vnbu3WcoheMtp9IRtueWGZSMRpTo7lsP78VjiF8x1Ki7euYWDipn4Z6Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780672156; c=relaxed/simple;
	bh=C3oniZ/yKIJ6cNJImdMMT063om+pdsco2LX8NoQUgAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hy3tTyjGSwq3sfpjgODvIUS27cSG2C2Xv4+OgJbYp4FvNokSEjIooiJcn9l/DcbsOQgvczNJfwXP0V9EWWEFVBxVq5vYz826PJBJ6nPS1j5SramFsLzfkQougdqLQr+FYfySTl1VJXXsqsqLjIxLO/RcGQlC+JCs70E1nktjbfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rqqjjwZQ; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rqqjjwZQ"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-befee9e5ef7so217061866b.0
        for <git@vger.kernel.org>; Fri, 05 Jun 2026 08:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780672153; x=1781276953; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xEMGXyzVIXlgdq2fJ4TaNPHfqMQqYSaothi6X4m5oPo=;
        b=rqqjjwZQDEk5Lib3054bNEvQxYEpdtJcZVq2SyqduEUtlUqKRB6WM2u0ZfoK1OzQit
         tikh1kWGsvbyIZeTUofv48a8VPOKNyWjvWNhwak5cNRP+MvPPYHu3cjsibnKjLHgVR1J
         ay69z2t3Kiiby9h6aGQXJTQbWU8tNMZ7AbmO7DQMt4bbQbZpfQ5iSr4Asg0PQxygxMh0
         hkkkLpJziOzFIkqayO52EaAKamkmEPOxvLHauCnPnaKUUEZCDXV5rX6hXsOwx4mwVqbn
         cn7Tr+hXFMMPd96NhxmF+2oRVLC+nSXorxnoB4/ABxO6HSxwV+mZZQvNTX8I/wnp8xQe
         JRHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780672153; x=1781276953;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xEMGXyzVIXlgdq2fJ4TaNPHfqMQqYSaothi6X4m5oPo=;
        b=MXKND0DPNE/DbKunlAQk6oBW3kvflsj6v5qq8NUX0e7GmIsHdohaMbmJp/qbt5msAg
         5W0epJBiJpfzZQSDmg8mt2Pg7HokzVJeEaIgj+i6e2tCgWAfAb3dfR8YdmkTuIWpqAMg
         rXHXkuEjGHA+N2YTfEqipJjkl9iB5U0TnlgG3nQfsehaQ9Ah1+g2PXB3pj3NJM3/6zC1
         RoDnMU4khUneqN6EA6fPl3TRipMO6q0D3Mwd+KISaD8vK9CnQg0/Z9B5v/wPfcvdZHrW
         SUV7oVCIfgG4CRduWqwW9JKA448YPeO9dMt6RdQ/GOp4Wiy8a+X/ks5HauC0b9AIGlRZ
         +PMg==
X-Forwarded-Encrypted: i=1; AFNElJ+CF4VyIiemMwxWWzdnv2TGojfEN0ztx6j41xJ7b0Gd9EvSGSMk9w79uBaIJln5vE1mJcs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+O2OhyNA3XCPWmOgxlF66hDz8Ac2WD9pH+tBkvkeiEXOcS8W5
	N18vVLRC/x5RBeG+W4ycCmyIF34fEf2/0Hv1aUrsqu4hu9SxcKWsvfsd1dyb2Q==
X-Gm-Gg: Acq92OEULhuQZzQ7doXe7o2J0dn/bjxfJVRL+thmXIhknpxyTznHa8oQLbkSw1JYcep
	HBG/MCiGLYWRnbbVaImqR+xtvo8IjtLSwZ48JZKzsvOKBdbCZmvxkm7kZrIFi3OFnYI6/atYM06
	3HuQbS5bdK3On9s00kSX3h/oJ1eTeP6KtLUmlenZAD7vX5aAhlVApfIEg0NSRpflGQ1CNFHT+Ay
	1R0ppGTuMq7fHO3prH0etSKEntqWkOFY7R/NlN5wqVKG0QcdP1AGac30hvKvrGXM500/MW/UIVx
	6Xkn7yXQbTTJYcZSywchqBBZ5q4dgU9I5AeoDlnSFz6URVJ+DfMWPCRCr2UwzFUJlNzdBxVJ1SH
	J7u6PXc9WHTt/ATqPtYSqFU+tT9BuFab30BLYVRSlW6Zdxvs8pmCbMtDgrStSzh8r19xjVyXqMz
	4qbBl5E0ujUztuRtYNSK5VFrNKsu1VRsyXHUSVeWWSWT0bswYtkTEaD0YrasftiJzXyZy9vrZCo
	/hMjwwTPaL5fg==
X-Received: by 2002:a17:906:4fcd:b0:bec:436f:1857 with SMTP id a640c23a62f3a-bf3702817e4mr211633766b.7.1780672151229;
        Fri, 05 Jun 2026 08:09:11 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:638:c001:a103:efc2:6ce:f580? ([2a0a:ef40:638:c001:a103:efc2:6ce:f580])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf054e03709sm466049466b.30.2026.06.05.08.09.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 08:09:10 -0700 (PDT)
Message-ID: <9e2cb34b-97f6-44f4-be44-60f44760e601@gmail.com>
Date: Fri, 5 Jun 2026 16:08:57 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 3/9] reset: modernize flags passed to `reset_head()`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Pablo Sabater <pabloosabaterr@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
References: <20260603-b4-pks-history-drop-v2-0-742cb5b5176d@pks.im>
 <20260603-b4-pks-history-drop-v2-3-742cb5b5176d@pks.im>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20260603-b4-pks-history-drop-v2-3-742cb5b5176d@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 03/06/2026 17:14, Patrick Steinhardt wrote:

> -/* Update ORIG_HEAD as well as HEAD */
> -#define RESET_ORIG_HEAD (1<<4)
 > [...]> +	/* Update ORIG_HEAD as well as HEAD */
> +	RESET_HEAD_ORIG_HEAD = (1 << 4),

I'm having a hard time parsing this new name, if we must have a 
"RESET_HEAD_" prefix can we call it something like 
RESET_HEAD_UPDATE_ORIG_HEAD?

Thanks

Phillip

> +};
>   
>   struct reset_head_opts {
>   	/*
> @@ -33,7 +39,7 @@ struct reset_head_opts {
>   	/*
>   	 * Flags defined above.
>   	 */
> -	unsigned flags;
> +	enum reset_head_flags flags;
>   	/*
>   	 * Optional reflog message for branch, defaults to head_msg.
>   	 */
> @@ -45,7 +51,7 @@ struct reset_head_opts {
>   	const char *head_msg;
>   	/*
>   	 * Optional reflog message for ORIG_HEAD, if this omitted and flags
> -	 * contains RESET_ORIG_HEAD then default_reflog_action must be given.
> +	 * contains RESET_HEAD_ORIG_HEAD then default_reflog_action must be given.
>   	 */
>   	const char *orig_head_msg;
>   	/*
> diff --git a/sequencer.c b/sequencer.c
> index 1ee4b2875b..0b89a977b0 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -4870,7 +4870,7 @@ static int checkout_onto(struct repository *r, struct replay_opts *opts,
>   	struct reset_head_opts ropts = {
>   		.oid = onto,
>   		.orig_head = orig_head,
> -		.flags = RESET_HEAD_DETACH | RESET_ORIG_HEAD |
> +		.flags = RESET_HEAD_DETACH | RESET_HEAD_ORIG_HEAD |
>   				RESET_HEAD_RUN_POST_CHECKOUT_HOOK,
>   		.head_msg = reflog_message(opts, "start", "checkout %s",
>   					   onto_name),
> 

