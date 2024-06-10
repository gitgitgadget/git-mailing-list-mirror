Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EE53BBC5
	for <git@vger.kernel.org>; Mon, 10 Jun 2024 08:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718008077; cv=none; b=tgLDoh0KVwUWr36+5RKU30T8X7G7NqXboZEyiNsFk6ezAyB2ED6vaCinZD05HjukI2SwxcdEE3yYMoAKIM2yiy1EtMzPW6cWQ3K6oFsG6B8erD8hOLfv828nHSvCY3oOnlvcdsDAQb9bw5hkXPo5qyQOewnTSDbKiALM2s9s5ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718008077; c=relaxed/simple;
	bh=cxTuSDQ7bYK9kAYtoD0hd05Td3juhbiLeuK9K45APKc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=jlqyD3JlM6KxZwzT0IpLwSVUwvFlkeO2DunYCbgzit5Nhc52weUXtQsOkdnpx9SAdMaHtbAzr3FtCH5hq88IZJuM+TvueWXbhhw4z2J1YLIg4FDsh6qMGnIPve4X8N2hgcNrL2L/gKoOUdV9v8z3sojxeECFq+A9PW/JscJVK+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HdaRphmW; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HdaRphmW"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2e724bc466fso50969291fa.3
        for <git@vger.kernel.org>; Mon, 10 Jun 2024 01:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718008074; x=1718612874; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kYu2t6wfW1KqX2MR/dqULFnWfAHbhMjZWaZmpCEWTrE=;
        b=HdaRphmWG/SWvKRnupUlVuMfR7S3fXcSkNhTS99tdpIaxF6EFxEHNypNTuf8A26rou
         jBlMfU4f0OR/joNfzxqE4+3MyXxCj+dU3wKFTw3VrZoLvgxGv+J523UjR+naK0cSjEfI
         NbPkrlGzlyEZypZ8eTfqOcSF5Jgc7gTOXiCDeI45wPY/6g6J005sCo7iyUfwdvRhaskj
         7mmX6rUhNrX42Fd4n3jnIbKjkLgihHufB42R+n4pA6mYAVsEPHAq8l3fUKBqUktnfPjv
         qxJQRe9U7N5qw7dpejzGAsQO0jSpb28v98rfirvqqznoQN9+S9ub6BiOVE992AJpdJel
         nTyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718008074; x=1718612874;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kYu2t6wfW1KqX2MR/dqULFnWfAHbhMjZWaZmpCEWTrE=;
        b=Qr5o8QrWXD6Mou7pWpUSDf/zUaJINBYsfLNeMWHeLdeQaqnveIxhL9sCYNs25aZr0h
         5OBcLYLC92I7Jhx6evzY1yxI1RgYfMyP+GrOMKEiJu9tU0oQZnOdVDLX/ZZU6hMJvxy2
         fFztfzJD5QI8/WXS2rgA/DyOIygr/ffHyjvlCev5in9MWQyE95xVdeT6g6zmn1FL3iwZ
         TPzNklwUebEOT1Ie2fZhxyrwHGBhnxwbCfUpjzlhcPlJ+Pdl9LkWXGfyKgq2eoTsNCb0
         ecTXi7ZKaomdaFrlWcFDpCUfXZIIKs6FHFBudsn6uDb96d4QC80ukx9RoiRjhpedlXC6
         l4ow==
X-Forwarded-Encrypted: i=1; AJvYcCVgGHPciidjn+gDtgd3z8T+WFj5+EYs+xAilmqopnB+KacWZ8Avp57/trfCdf4zjNeUKmeE5EbaO171Wrvf7REmYsM0
X-Gm-Message-State: AOJu0YyjV+lAVhnpcdK7/TCyXYxs3oed2MstrRTf/PyPCpKUrrM60PC3
	7NdOjf9ExBLHF8Y5lULmr77Qv1YqV70H7BHBOQv/EM3fLkEX1Olg
X-Google-Smtp-Source: AGHT+IGFZpaaDyMunM1OrHZ5lmZ28k4XVCZji0RgWcwCIlYK8JJVv3iPV/BD53bwrQ4gvkXdhb5p1w==
X-Received: by 2002:a2e:9598:0:b0:2eb:e266:f9b0 with SMTP id 38308e7fff4ca-2ebe266fa77mr23507961fa.34.1718008074025;
        Mon, 10 Jun 2024 01:27:54 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:64f:8901:b1e3:645a:b3c0:7476? ([2a0a:ef40:64f:8901:b1e3:645a:b3c0:7476])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4217d7f9a6esm67611345e9.48.2024.06.10.01.27.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 01:27:53 -0700 (PDT)
Message-ID: <1ae0715d-df76-4019-995e-f00f3506f2ac@gmail.com>
Date: Mon, 10 Jun 2024 09:27:49 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 0/6] use the pager in 'add -p'
To: Dragan Simic <dsimic@manjaro.org>, phillip.wood@dunelm.org.uk
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
 =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
 Git List <git@vger.kernel.org>
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
 <199072a9-a3fb-4c8d-b867-b0717a10bacc@gmail.com>
 <b7e24b08-40a1-4b18-89f6-e25ab96facaf@gmail.com>
 <20240604101700.GA1781455@coredump.intra.peff.net>
 <xmqqikyo207f.fsf@gitster.g>
 <20240605090935.GF2345232@coredump.intra.peff.net>
 <6056d585-6380-43e7-adf1-9f9aadd2a7db@gmail.com>
 <a8d3415e3913e3a0798a748ed7f7a093@manjaro.org>
 <a2a59f5e-fd55-41d3-8472-b99256e1f428@gmail.com>
 <d092f5bb1d3bc7b7a821000a3cad8a1e@manjaro.org>
Content-Language: en-US
In-Reply-To: <d092f5bb1d3bc7b7a821000a3cad8a1e@manjaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Dragan

On 09/06/2024 18:20, Dragan Simic wrote:
> On 2024-06-09 16:29, phillip.wood123@gmail.com wrote:
>
>> Having read the message you referenced I'm struggling to understand
>> the use-case for stripping escape codes - what do you want to do with
>> the hunk that means you want to remove the color?
> 
> Let me recap, please.
> [...]
> I hope this makes the whole thing more clear.

It is very clear _how_ you think it should work and I agree that makes 
sense in the context of a generic shell pipeline. What's not clear to me 
is _why_ that is useful in the context of displaying hunks in "git add 
-p". The purpose of "git add -p" is to allow the user to interactively 
stage individual hunks. The "|" command allows the user to display the 
hunk in a way that helps them decide whether to stage that particular 
hunk. Are you able to give a specific example of a command that would 
help you decide whether to stage a particular hunk where you would not 
want to keep the escape codes?

Best Wishes

Phillip
