Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32D36EB7C
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 19:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725652160; cv=none; b=I71CjcsP2jHOE695R88mHN6kMMSk48kItK1tA0SGD3jkw2cBzr01X1r/qIQPcXQlT4CZEeSaVcKCTso2Ag4fUO/qMJTq/qviAnasQ40CB4valJdO4sgjZVyJuTImxBWL1+rJ3rYxM0MpJW+OEWuLSxpQvWwNL5AZ8rDWDYcRsgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725652160; c=relaxed/simple;
	bh=x6ydcUs0Yx6PmizTtttAgkJ1TBbCq0r4nIcrim756v8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z4Ef/hp5WMNukLUVC2aXst6YNwF60db/2e2MZjE9mG4NwDk/sIomO06GBfu3qiySmLE45v3nscGSsQkmeENnbpxGXEavBrQRN2XITcwsQr8xp1gT8lMCzDatHuq6TkBduwWW6r+p3ZBJ+IyAVZvamM3rw29k9dWXCZWXo+89diM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O8jpaXSn; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8jpaXSn"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-717911ef035so1854210b3a.3
        for <git@vger.kernel.org>; Fri, 06 Sep 2024 12:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725652158; x=1726256958; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Erm89NK7+uIf4n6h1TwfeDD2j3OIE45DH60VvZpSSWM=;
        b=O8jpaXSnFGxOvidrVWsM8II/AfwJVp/XJhbDbfCvLHUdy14oZ7caWIxsUo0re4FoFj
         4kpC3Yd7RyKQQ7xISK5Vxd4utjo4YEtzAk9Hc4Vti/seVadfq2HPxP6x0/0evbFssAnZ
         lB4igpb+0Fg/CAV0+VlezLgWwb5uJfZ41kEDPy0Dy++1lADVfgXp/L/zjpe5gVFDEL2I
         /EPVj2cbjFsJfPZDrIeZv2WOZA26PR+e2oxCsKBHcfr1VcadnXcwAg/cL4EGRxQ5uura
         qJ1Hsi2ntEKGU7vzILAOjN8tHYq+nujW2fnB+P2ZGLmpg1Xx7m8BkBKcF6kXP6e1vGhG
         ZtnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725652158; x=1726256958;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Erm89NK7+uIf4n6h1TwfeDD2j3OIE45DH60VvZpSSWM=;
        b=HzroqzL1bFZG9+P7f0unkasjxXDNutM/IRUiiO8j1tRLSvu0WPklEA6g2NgLdaZu8S
         9sTPNm4HKpO1gIm8/t+quTkBaoN0f3a0DeGwGAYruyZdLhWFCtYXsP7FYWdunoR52SyD
         68KBLs5TPBmSvYFRYJqCtkfPI4T/6obBtZop5UOGFp92zF0zV/4EkW2/6qwJ4teT+6Cs
         wB1uttwWGWtFyJZccgq/rrmNqSdkeR+Lkiz/7vP1jR7H0BPzMInBSawaCM2k8ri0JMCh
         z94pJtGMbJjtthoccWC+aJhfCwLjErOnyimDeEa5k8YgwFQTXVXelwhCYifWBFL8iD/r
         j9EA==
X-Gm-Message-State: AOJu0YzduqIVc6fo7MhtIqExR0/ARNW1vFV/1HuCEl0Er29yutKbIVnb
	MUznNtr4c7zxnBLWNgdbJ12QIDU2Pe0BKvjgA92id8pcHlKoq+e+
X-Google-Smtp-Source: AGHT+IEZIsDP8CspY8TAc8F3v1/hdpX/7JcmeIrwn7BIsd87C3oT3WNDd2unooHRBilVFhau3xelPA==
X-Received: by 2002:a05:6a00:928a:b0:717:9897:1405 with SMTP id d2e1a72fcca58-718d5ee05c1mr4545999b3a.17.1725652158073;
        Fri, 06 Sep 2024 12:49:18 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:a1f3:c77b:6e39:8f9d? ([2600:1700:60ba:9810:a1f3:c77b:6e39:8f9d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71798990249sm2175468b3a.85.2024.09.06.12.49.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 12:49:17 -0700 (PDT)
Message-ID: <da98da07-b2f4-4608-9038-7ce4b8e2d74b@gmail.com>
Date: Fri, 6 Sep 2024 15:49:15 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] advice: recommend GIT_ADVICE=0 for tools
To: Junio C Hamano <gitster@pobox.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de, ps@pks.im,
 james@jamesliu.io, Jeff King <peff@peff.net>,
 Gabor Gombas <gombasgg@gmail.com>
References: <pull.1781.git.1725559154387.gitgitgadget@gmail.com>
 <xmqq4j6t26fs.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqq4j6t26fs.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/5/24 4:26 PM, Junio C Hamano wrote:

> This somehow makes it sounds like it is an "aside, by the way" that
> these trigger by default and that you can selectively disable it by
> setting these variables, but shouldn't the stress be the other way
> around?  Shouldn't the mention of GIT_ADVICE be a side note, leaving
> primary text target human users?
> 
> Perhaps like this?
> 
> Thanks.
> 
>   Documentation/config/advice.txt |  8 +++++++-
>   Documentation/git.txt           | 11 +++++++++++
>   2 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git c/Documentation/config/advice.txt w/Documentation/config/advice.txt
> index 0ba8989820..d749aee7f4 100644
> --- c/Documentation/config/advice.txt
> +++ w/Documentation/config/advice.txt
> @@ -2,7 +2,13 @@ advice.*::
>   	These variables control various optional help messages designed to
>   	aid new users.  When left unconfigured, Git will give the message
>   	alongside instructions on how to squelch it.  You can tell Git
> -	that you do not need the help message by setting these to `false`:
> +	that you have understood the issue and no longer need a specific
> +	help message by setting the corresponding variable to `false`.
> ++
> +As they are intended to help human users, these messages are output
> +to the standard error.  When tools that run Git as a subprocesses
> +find them disruptive, they can set `GIT_ADVICE=0` in the environment
> +to squelch all advice messages.
I like this a lot better. Your careful edit is substantial enough
that I will give you co-authored-by in v2.

Thanks,
-Stolee

