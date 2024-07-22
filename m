Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD7016EB6E
	for <git@vger.kernel.org>; Mon, 22 Jul 2024 16:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721666712; cv=none; b=RcGaYx7xdiLOfJ5Ipa0zQ1Oqma2vFz2wXbnu/c8jWBCQRxksYOHm6u/LrchTvgRTl7mncCbGbkGmkTUF4G1UN/23i83sRHlTW8YDzGtGwyYIlatA/SoL1r3NBFhHZunlQXnL7nAWLZWUhz35I6YiAMTtjWYJe+iJaGct1UZY1q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721666712; c=relaxed/simple;
	bh=StT5yfz+OGro6HTsAvAL4JT40w26QaESwG6jADQr4/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jQGOvlmexerM+pL43lXECPu9CsMmMQvlQW0I+aP6ubFFV3JCQLkFtNq5q9M42onCbvVBYuy5imV2QyWZIUCi2PvNsErn3QOq+gg0mQkOEDJv15KmF17CA6Q9UP2opA4RKSxXS0tneVWkVIQLcpC3z4AIqKgXm2KOgcrEu77rs4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HSz+Z4Iw; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HSz+Z4Iw"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4266ea6a412so32722125e9.1
        for <git@vger.kernel.org>; Mon, 22 Jul 2024 09:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721666709; x=1722271509; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kTE8XlZvfdraby+WChCTuKIjQ3M31Zrn8j99U7eO/B4=;
        b=HSz+Z4IwjWIWemUwdL004qf+hRoesRdlmMxhIG3iKe8aigh65bZAmzjCU5Sr3YEwEw
         L0ABQtpmIY+p3PoDDTZH877GA2DNZrdcrrwH2PKEUajsp4vRq77B0XY+1iWjHQKuabBQ
         qkSnZKzwd+bsN+pytQd6LtVUjnUopWRdYulQC8QsDn4wdjxGq+gs5BMdd8S3tQ88Jc/A
         vLErjNMDbsIcP5cGXWgd5StCK9fUHVDB1EfYoK0DTX2uNpBJWaAa88aIRHVpA3D+hMCN
         l8sXbGi6g7nL50env+sZscZzp1NCyhWo0xfmpwECZDnIczxjxQfREEo9a+fexi7rSA9f
         FTHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721666709; x=1722271509;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kTE8XlZvfdraby+WChCTuKIjQ3M31Zrn8j99U7eO/B4=;
        b=AVtcAGG1fcUxFv1feFgXSk9c7dOMbG/UOHPmqmWbB7q9/vjYCsIR63+lF3XXLKeHDH
         meQJZwl1c1AtL+9DQw3u/jkunB1cx2DlouXtXowAhX5I7RIK5YRxS/00D5t/kiROrqb0
         Xnn9B7fRASsuipVJwXA3dc7EyqIeILxPGSfc7x1JLAZirULyn0YdOpLK2fJtB9Ndoh5j
         Jj2us7JeAwtwJgd5VZERRN7mPuX6vg8FrSd5XTo1rmckp4vkgkyC7mLmN2ZI4CoQtwJB
         1eAP5LbMot2IJNpLMt1jCdOzKnRtV3aNEkAJn80dY5TlBDZJlq6KVlIlKylat3FlvgYN
         0G9Q==
X-Gm-Message-State: AOJu0YwGEEnBbzKmfq/iLA0jBs+wjLfg8kqm53Q8XNabAaFxmW9/Wgzh
	sydAfpGGXqsBGb6r2ar8qC8LEdvLJqapXZl+qQ1BojiyX/ygvP3Y
X-Google-Smtp-Source: AGHT+IHxNxf6Fp9JnfxFdhMZcxM73NqmYD8j3FtGyzaRd+XsXJy7uBXpwyqeib+Rc2madO5zMKaRLg==
X-Received: by 2002:adf:e30d:0:b0:367:9d05:cf2a with SMTP id ffacd0b85a97d-369dee46159mr292795f8f.42.1721666708427;
        Mon, 22 Jul 2024 09:45:08 -0700 (PDT)
Received: from gmail.com (89.red-88-14-41.dynamicip.rima-tde.net. [88.14.41.89])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a7257esm160172295e9.28.2024.07.22.09.45.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 09:45:08 -0700 (PDT)
Message-ID: <48706007-b387-494f-a104-a8a50128cc67@gmail.com>
Date: Mon, 22 Jul 2024 18:45:07 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] add-patch: render hunks through the pager
To: phillip.wood@dunelm.org.uk
Cc: Git List <git@vger.kernel.org>, Dragan Simic <dsimic@manjaro.org>,
 Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
References: <2653fb37-c8a8-49b1-a804-4be6654a2cad@gmail.com>
 <ebcba08f-3fbb-4130-93eb-d0e62bfe0a8a@gmail.com>
 <efa98aec-f117-4cfe-a7c2-e8c0adbdb399@gmail.com>
 <1dc9ebad-768b-4c1a-8a58-8a7a5d24d49e@gmail.com> <xmqqttgqyzwa.fsf@gitster.g>
 <2b57479c-29c8-4a6e-b7b0-1309395cfbd9@gmail.com>
 <88f9256e-04ba-4799-8048-406863054106@gmail.com>
 <a2ea00e2-08e4-4e6b-b81c-ef3ba02b4b1f@gmail.com>
 <5360ab9d-6d3e-4da0-b1c4-2ff381372c1a@gmail.com>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <5360ab9d-6d3e-4da0-b1c4-2ff381372c1a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Mon, Jul 22, 2024 at 11:18:00AM +0100, Phillip Wood wrote:

> > That's why I thought, aligned with what we are already doing in
> > `wait_for_pager_at_exit()`, that this is a sensible approach:
> 
> That extra information is important. When I said [1]
> 
> > Isn't it a bug to call this with old_fd1 == -1 or have I missed
> > something?
> 
> What I'd missed was that we can return early without executing anything.

Yep, missing that old optimization is easy ;)

> We cannot do
> 
> 	if (!git_pager(asatty(1))
> 		return
> 
> at the beginning of wait_for_pager() because if we're running a pager
> isatty(1) will return false so I think the old_fd as you suggested is the
> easiest fix.

Now that we agree, I'll do it :) 

> The existing callers do not need to know if setup_pager()
> applied the "cat" optimization because they only setup the pager once. For
> "add -p" this no-longer applies so we should think about returning a flag to
> say "there was an error"/"there is no pager or the pager is 'cat'"/"the
> pager has been started"

I'm not sure it would be valuable for us to make the caller aware that
"there is no pager or the pager is 'cat' ... just use stdout". 

However, I do agree that probably in the future, if we finally add the
"|[cmd]" command, we'll need to return some kind of error instead of
`die()`, in setup_pager().
