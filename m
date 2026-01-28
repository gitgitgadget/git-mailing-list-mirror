Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBF02F5A0D
	for <git@vger.kernel.org>; Wed, 28 Jan 2026 14:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769610573; cv=none; b=hRW7kbWP1Ybsw8+AvEd2htoAA74XaM0c0lceRnts4+MUdzQwgH8Nf6L+XvZ4jYtJFKXFjI+moqfxlP1/KAL1GYQRwQjeQbG18UiLkZSOtgSrzS3OH7UmdXszuukztlPr4uvTz2+iqdCayAgIApJTpQ7dLDfX2QWlR2mUuojBD28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769610573; c=relaxed/simple;
	bh=5G+25yLOq9ZH8tG/XfjkS6y7Y/bGRrxPCHbsk05WOdg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HqQ6LnPXSduYLLJRfAiYH/dvcK2KDND62qz/jZeY8ci9KJH/hzMS2pyHyZsEZxOODPuNCZBlEwu2r3AF3ugAE1Xtj2SepM0At9XLH/rcnCqdv6hRLMwuirxXvHn5JLVv34AoEudBwUb62n6J5Q7OwpBcZ0mQlvDGIzmSffNZhCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bjd1Oh6O; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bjd1Oh6O"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8c70c6b2bcaso173910485a.3
        for <git@vger.kernel.org>; Wed, 28 Jan 2026 06:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769610571; x=1770215371; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t+p0gHSXWwfyg/Ptaq/UurxLULh0U+M+xI+MZX1NDd0=;
        b=Bjd1Oh6OUCZoESWR+6VJX6Ta/Lm37aNPq7DfZc7Apzsx/TqMOxI30qtzvaJBzMiXoQ
         /gOMLGzfZvAqrlX8HbisZNHAqe9RGLP+mmZkLN3+bePkTo/aGA40b5Ja8OwuS7iN3e1S
         FOrkrqzCpJgQN3RQeeKuIXFcayVpPvH1OsLSjdNIEgogN9Obsu1pMC4a6+DPHJ0Vfjxo
         Q8424G1REd5GmofDbgPSB2ckgn3sN9SemHYQWQUYOcFp9evcpQsYuAokfOXY3THssjz6
         AYS2eGx6/xHuEFJq94dOSkcnrYnmGSVnifusXl7orNccctOqJNnfUB0g6xaTsUXsNQxC
         CYwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769610571; x=1770215371;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t+p0gHSXWwfyg/Ptaq/UurxLULh0U+M+xI+MZX1NDd0=;
        b=IL9ko0H1YaWYU4Gf5Ib6LYHvdSQNz/DhUvI/xuMlYoTpanySbLksU1qVWVnwXECKCK
         yCK4LFUMr2+4cVgM5n8nsPQaoFpD/DJ3Wvzw0hOOq62VmJCVX/uyi1K+aGtVQ6PEiz7O
         kSp7r5nyuvxBh02bydRCDaR9S4ARHfKA1RHgINcVJe4aOuT8b2dIIHP3pgL0hq3UZygV
         hMovBpnu2ZU0sdHBf7Os95Ck9Y9a7bZT3MwAuUAx1mrpr6LZphjv01vSpcw7fe6uLh8o
         qzSpzc5bUsfjxV+vehy23QEnbmJWYGReC4D8J014z2egdnA3dN7anPbjMjmgHaMYEagl
         S2Mg==
X-Forwarded-Encrypted: i=1; AJvYcCX7tRZwjdeKQaPDlF8RMtc2sh3hf1cFT3FdGb4hu1+ucXJyTg3PMiry8ewiEJd7fUhBs/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXygkrskjHYeGi1VxTY5Q7t8cAJ8j4eGiAG00AXjjuU3GlCzYu
	i/iEjYBhL7M7Xxgm65iJvntwSa/pik3kBG7aL3vQTeRZsDHu4LSOwHLBpT0OlQ==
X-Gm-Gg: AZuq6aJNekabUDfvBm/sIXXdvhAdp7SEphskWP/7KVVtOPSSrIbhaBUOdEtnm1DlVMf
	30oXm7B72ieNTwCccAmKFTqQYDD7CJpmSKyXgF+L+jKN/iIxmPv8h0c+JUw/VoGyLgxUsOySN9A
	mplTN26+6OcPRvrey3C4ql58/HpgfLOx/uQUe4Q7UVyKK4kyhtV9036OCSUWGEYmIufr8eTjyCk
	qmpYz9XZ5I5pAxnkdhapHl8+BVCbabLjmlIZyOAkPXcCZutUgsVriiHrceMWYK8rx73tyKluws0
	CWNXdxgreQ6Q7FNV+whg2UZ/z2iqXO65ZmfViGaIxHTPMJ+mXSOulvFnGxpLHZXfDOlbQMDPa1b
	YvsjIWbzNekbhrWHp2bqZBllyfn9h96yWBdPG32A0/oDWqWo7LXPVPSBioN8gOGg0VSptZ6//Zb
	RMD5gbXTr1pAwe43X8jvjDqMESUxDt4yqbWdguY5mrLH5F0zfhQakXPt7RbAivwcqJ/VQclKj8N
	AYwTvomwUN70HmK2zV6BJxcuyFGmOMgmSez5SLB/Ca/GNywKw==
X-Received: by 2002:a05:620a:711b:b0:8c0:dc64:bb9f with SMTP id af79cd13be357-8c70b840648mr729812985a.18.1769610570894;
        Wed, 28 Jan 2026 06:29:30 -0800 (PST)
Received: from ?IPV6:2600:1004:b2a2:c7ea:f847:9c11:f011:f40b? ([2600:1004:b2a2:c7ea:f847:9c11:f011:f40b])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c711d5b636sm196186585a.48.2026.01.28.06.29.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jan 2026 06:29:30 -0800 (PST)
Message-ID: <283c6bc4-787d-4035-bc94-a85ca775e8f0@gmail.com>
Date: Wed, 28 Jan 2026 09:29:29 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: ds/revision-maximal-only (was Re: What's cooking in git.git (Jan
 2026, #09))
To: Junio C Hamano <junio@pobox.com>, git@vger.kernel.org, j6t@kdbg.org
References: <xmqqecnbeyvr.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqecnbeyvr.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/27/26 12:42 PM, Junio C Hamano wrote:
> * ds/revision-maximal-only (2026-01-22) 1 commit
>   - revision: add --maximal-only option
> 
>   "git rev-list" and friends learn "--maximal-only" to show only the
>   commits that are not reachable by other commits.
> 
>   Will merge to 'next'?
>   source: <pull.2032.v2.git.1769097958549.gitgitgadget@gmail.com>

I believe that the discussion has landed in a place where this version
is good to merge. Any remaining discussions around using the 'git
merge-base --independent' algorithm when appropriate or adding
'--maximal-only' to other builtins can be delayed to a future
extension, I think.

Thanks,
-Stolee


