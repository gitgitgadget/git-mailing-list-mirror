Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AB016DC39
	for <git@vger.kernel.org>; Mon, 22 Jul 2024 14:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721660043; cv=none; b=ExQVvuXkZGdml/PkqKRMIuSLPZ/97PrvfDV6HxqYiSai5x9tQg3NSjzcMCbF/9CDXCpgnPu7Jb+g59MmITYaCcsaN73dtrLR8COCYKiwFNCK7OpfVQJZY5Rc8RRSKJi3IXh+FUCk1DYxnNYj6K6eGmCNPXqgIT+9+UhlsojJ/o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721660043; c=relaxed/simple;
	bh=ygr1DO1DfGBdoQg+8R6QxjdlhiqZLONz4+BkUUkOGbM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eJzVtybkqpJe02nXQ6eAsUD1W9bs7MU4Zhwbu48wOauhxQ7wlRf0iA7o5HLOj+0kyo7mwH+lItvDe84tOWQBh5NYQadWhqqE0EKxkVzBuFcnLvAzdvzE2oB8z01bS0jnMyvD+9UC5Q7JHFU4frtHWZzHdLm78eDK+jHOeeKSkEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c2ApZKNX; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2ApZKNX"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3683329f787so2263015f8f.1
        for <git@vger.kernel.org>; Mon, 22 Jul 2024 07:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721660040; x=1722264840; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zpb4GXNSoj8Evw9zSz7LkfOd9gqBz5w4vXwBOPIoTGo=;
        b=c2ApZKNXC6yzW9ugF7rnfJumJnFhUW9GrlGnT50LXkTaoPtZfrxpDkKBrzIeSaEPLH
         NCFOcLOuLpOxH6++1K+e4wpu96YMoHmnnB14egcABsiuTatGb1xSou01a5hwvc0efXDu
         oCvolmMqxGxvNtBRGHud8AhHvFo5XiP3ladWhUAp4gBYr6XT7LjvHlntnMo8Qyj9KyjV
         3+0BRHVvkX2+Qry+Z7C7DgRvtLWMtwgke7wmC+7nRpDlWCZDrh0vYNn5k1NDpckZc5nI
         ut+88nFGYsLZoC0pZWN/62dNlTdEN4vUM4yBGE1RfdZ41njMrfdxfdy4pANUxLwqQKDy
         0J7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721660040; x=1722264840;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zpb4GXNSoj8Evw9zSz7LkfOd9gqBz5w4vXwBOPIoTGo=;
        b=AWeo3Z667xHBDS8NGaWnD4dxqA33upLrMv67XJGPsNfT4YekZP7OE3jE0+3h6Qk+dJ
         Fu93CqL+DWn/G+wWuzysypbOcfPXyMwISBzOCMVkSs0mJGT9lsOrz1qC5XepQYe9IECc
         ZSiK4VfXu/x3NmJDkij5ewpkfGkf7m4sv6cyeqC8ZSCy2DCjqOTphX5DfxsoThEgmB4x
         JpQiI7r1ar885kucaxUWEekKGPtIZdkBsyoKF7NEZ/1uUsOV1n2lPR/bGyfR+nMx63DZ
         mT9B95W2ktZC/2UeqgBoVgY1E/W4qjfI2Hvz8aFwqJ0syIzt5pZoa6uHUjDZk0XQXsoo
         OB0w==
X-Forwarded-Encrypted: i=1; AJvYcCVTIKL77L6nS4PEZET/mwWy/2BjMCPlfk0egRIt7ntN7Ca+0SZwgMkB2IdGaWuHVerJwkaLB8gsAMfmaio8D/aPvAzG
X-Gm-Message-State: AOJu0Yy/H0+Wop0iX0Tdw5RL9yhiNrNt1YqNxlv1IHapwkSkGOCp/pD0
	tvhWRghvkQ6im1zgDzbCqnGljYTKFesK4UyqiyshULRcQFQ5ZuVW
X-Google-Smtp-Source: AGHT+IE2tZLYUH6ktjIRvxShUSVYHflujM9NirE3o2H7d5wiuTHmYDEkbjh80LLGWRYT0rZJ6rW6Qg==
X-Received: by 2002:adf:f3d2:0:b0:368:37d7:523f with SMTP id ffacd0b85a97d-369bae01c9fmr4475471f8f.13.1721660040483;
        Mon, 22 Jul 2024 07:54:00 -0700 (PDT)
Received: from gmail.com (89.red-88-14-41.dynamicip.rima-tde.net. [88.14.41.89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36878811899sm8682335f8f.116.2024.07.22.07.53.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 07:54:00 -0700 (PDT)
Message-ID: <a0b3fed8-42cf-4e87-bdc2-1f090f3cc2eb@gmail.com>
Date: Mon, 22 Jul 2024 16:53:59 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] add-patch: render hunks through the pager
Content-Language: en-US
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: phillip.wood123@gmail.com, Junio C Hamano <gitster@pobox.com>,
 Git List <git@vger.kernel.org>, Dragan Simic <dsimic@manjaro.org>,
 Jeff King <peff@peff.net>, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <2653fb37-c8a8-49b1-a804-4be6654a2cad@gmail.com>
 <ebcba08f-3fbb-4130-93eb-d0e62bfe0a8a@gmail.com>
 <efa98aec-f117-4cfe-a7c2-e8c0adbdb399@gmail.com>
 <1dc9ebad-768b-4c1a-8a58-8a7a5d24d49e@gmail.com> <xmqqttgqyzwa.fsf@gitster.g>
 <2b57479c-29c8-4a6e-b7b0-1309395cfbd9@gmail.com>
 <88f9256e-04ba-4799-8048-406863054106@gmail.com> <xmqqfrs723bp.fsf@gitster.g>
 <CAPig+cRyj8J7MZEufu34NUzwOL2n=w35nT1Ug7FGRwMC0=Qpwg@mail.gmail.com>
 <bc1b9cce-d04d-4a79-8fab-55ec3c8bae30@gmail.com>
 <CAPig+cR3BHMyuGOMYdbRxvMfNzZBGQjgsrJU4MOx-e67DOTsdQ@mail.gmail.com>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <CAPig+cR3BHMyuGOMYdbRxvMfNzZBGQjgsrJU4MOx-e67DOTsdQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Mon, Jul 22, 2024 at 03:18:07AM -0400, Eric Sunshine wrote:

> I posted a series[2] which addresses this shortcoming by enhancing
> check-non-portable-shell.pl.

I tested this series with them, and it correctly detects the error.

Thanks for sending the improvement so quick! 
