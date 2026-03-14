Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81F034B19A
	for <git@vger.kernel.org>; Sat, 14 Mar 2026 20:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773518979; cv=none; b=BL9zNl2/GP9OlJcZCwHoPGbtymNpb32qXEZj+IDsEbfkRr9+QXVHHHIFKBTv+wu3YcNGs6sn3KIYcybzbu3PmlPN4DtEJI9fm8nM4MbzJR6YNbxOHqcvikFTMF3q81qa42kQbETnDJk7pyoET1VRip0J10X94F1gIGm22S10wxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773518979; c=relaxed/simple;
	bh=lNkk5dQMIYu286H7fTuaucea+ko0dphdh1dvxRvN0fI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=psByAo/vgwTd9R/jhUf5nVhF5NgdatJ4lomelneV8omynET3T4HsrwkSFBaxv1QBRylFXzbyWt0kwvgVT+Zl5jBUfwO/Dqwkpb+5SVux1sYFfGealS1YpqiAWq4GSrglanxR5I28psLLnFUK0lyTC5vlG8Viy5c+V22+pMrlaHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NFLm8Mg+; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFLm8Mg+"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48534b59cf3so29180855e9.2
        for <git@vger.kernel.org>; Sat, 14 Mar 2026 13:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773518976; x=1774123776; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=80FKicaAoiNNZLgqOA7CWUvKj3Iyso0MYfiPJBFHnwM=;
        b=NFLm8Mg+dRnZpWjOMLl260GF2bz6jWiKTS0omWa1yXpFw9qrZDn+Ee4jhfCbHlrJp5
         2ditlsZUEoP0mIaNCszQtURXvNNz4regbi+av56thYM15cKgiY4hwCylQ30ps2wn2NC8
         cgukrgrrkWSCs2BKJrQ3r5u8I4KoWhdA7xJldWnCfJfsclLE7nWXYvDBmi1MJs4FZLQV
         R8Sz10LPO7kAKAbQXrm8ppKRsf78FcUwAndZ5Zcf1bQeALc2nDUgNt7Ks7M0/yeIdvRh
         YQApJfmM4bPBh5jkhg3BDHdIy0tdGTzZ//TcLHP6EJf44dSdCe2Ws4+QFPP+o6Skaovx
         uxXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773518976; x=1774123776;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=80FKicaAoiNNZLgqOA7CWUvKj3Iyso0MYfiPJBFHnwM=;
        b=evnWxGzNLAuPobl+zKNHOLwsTRUbyvkHn+N1kcYykMnTqlu6nAIx/RgQSqPlJplBLf
         dMfpqUolwHvhZc0FktjUxBVq/9hwiNwoCiQjDF6NE4FcAQhTPYmugV3c33KLCqa8075Y
         fXcJM332dsG3OuqAEtK8DEXb4D81L8zWL3K2bgbCadiwnL21TQUlLIDgoi7ZKjvumjvZ
         c7Icx+KWMbcHapaYppDtPWy00WuIvveWvG+I3Pp1KaJPLT8AH0VfqLmNvN4rUgQPG92d
         9O99MACmQzKaosf8OovDhFGhWt94X2a0o/GWfQya01jB/JMGRFDe0+M2CPRo66lfky5R
         IB4w==
X-Gm-Message-State: AOJu0YwzksF9uSFBq2kCqPNI1DxNnHBSAxw8jJuFqnX8rtUMwCR5Tqho
	DJWhaHxo1fYGDqS0Ax3b/zT9dAIiJIa/G9q/kjIdUXIf0eOEJ++Trpz1hYMv8A==
X-Gm-Gg: ATEYQzy9h0LhvqqaMdCX53qyS9etcW3TBo46eUlHoOrk3cROwFALxDmQgcz4pFe/LC0
	0ZgjJhV210NhUy2WYkqxSVrSVfmoKzzDakrmtutKldiDuuh1Yyj/hYaet+ika2//SBLbTRfTCnD
	HuqUMCxYHtWcDdnb5zwraxGiObI0DpVwNJZVRfqhOnJKhTWPLa7I7W1bcfrHhmQ+Yere69FEVUk
	zCHewADebWeQGN2TxQIDYr3Xn0uvvb0HukeamiJkL/42PFYbnKgXxbW1DZarpzXJXVCzgAxN0OE
	ru+nACY6HPVGsdjHn9Dg7dS3Az2NYsBH2Jqmowek9h4anvUyKEtJOe4lmnvlHnRQi52GLtG8O+2
	ACOmkOH/4hlb54V26HjGeuUh5Dc9kxAKc3/SFhj5ZsGLxtCA/z7+v54A0tNZHiBMFTuLEgHKpaT
	k9LyKsXF8sdnkMIhjkYaQkwXLBYknFduATRoEQQ9wjP+6PCB9RTRNMdezT8B5weebWzIfnOY3Xf
	n/X9Q==
X-Received: by 2002:a05:600c:1d1a:b0:485:3d00:efd with SMTP id 5b1f17b1804b1-485566cfacbmr134708545e9.7.1773518976032;
        Sat, 14 Mar 2026 13:09:36 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1785:c801:9102:504:16e7:c44e? ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe1a76e5sm27566693f8f.12.2026.03.14.13.09.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Mar 2026 13:09:35 -0700 (PDT)
Message-ID: <4649d374-59ad-4019-aacc-259245e18587@gmail.com>
Date: Sat, 14 Mar 2026 20:09:34 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 3/3] worktree: reject NULL worktree in
 get_worktree_git_dir()
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <cover.1773411586.git.phillip.wood@dunelm.org.uk>
 <1151b5b302069b4f3414a37e3be4bdbbc7e40686.1773411586.git.phillip.wood@dunelm.org.uk>
 <xmqqfr632yq8.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqfr632yq8.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/03/2026 21:42, Junio C Hamano wrote:
> 
> <worktree.h> still has
> 
>      /*
>       * Return git dir of the worktree. Note that the path may be relative.
>       * If wt is NULL, git dir of current worktree is returned.
>       */
>      char *get_worktree_git_dir(const struct worktree *wt);

Good catch, I'll fix that and send a re-roll

Thanks

Phillip

