Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE032AD02
	for <git@vger.kernel.org>; Wed, 30 Jul 2025 08:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753865611; cv=none; b=uPZitfxUcnY56vW5w5jLws32SDHiBrP9B5empxpovCXv5fRz+p43+IluHSe1naT1mhafnLWI9naTFQoeypwyI+iX+zHX5DJrqudeM/QLCLlwK35v+eYys9eV+Fs2nhZ/i6wFEJ5WdNImvSIGpnoA51pmWhIjmCEZH/EGeEAxRls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753865611; c=relaxed/simple;
	bh=VgQxMOGndjo4MJqbuibCvllcuDCa3QKHlzgKxVq33iE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a+DY724wGaZlOeLGw/EcqwH4oBrB5DFzkOpvL/nSmTFX4GyJoDj1v942T/CDdUEdawaKXC6IoFgOA3iqsJMSoqZNoCY9WZL+6mHEYByuosr/xBkzCJz5WLT0WrJSvQI7MQOeUiF2SHnd0QGDXqPTqTeIh4iUW3wfDxMagzhh9yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Is8N6+gn; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Is8N6+gn"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3b78315ff04so2701370f8f.0
        for <git@vger.kernel.org>; Wed, 30 Jul 2025 01:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753865608; x=1754470408; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bPCYtgpJAwxVT8AhHF2T5Ep1xUhvbwlehO0mCuuDJ+I=;
        b=Is8N6+gnSofq4I9E/4C2To9/S2tR9ABr2hwiXUQox8qHJ8UFXQxfaW8aiwTASGU5A8
         KqblE76lsA4rBf8i1QI+jDUtoeCpZ4bF4/sy4YpvlsJ1+g0ISrZT5jV9OfC/MVq6gJWe
         j57vScYGco0Ny4pwN0KWHxBzVTI32GhnRC5U2qMqV0OpY/msI0x+nhxh86HA3aEAozft
         wP5yTgfxwBGv+dAlBNSUMBQbxHnqoeoMmNyIR69E+E0OnsJtwM1Ksk0Pl1AjycW+ZAOb
         c/O/ElPWdW3d+wuVeXsoizYF0HTlveVjlb/Km3E7BZ+zIOD0KWPXlbrAeXDNqJBpVN9S
         VJNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753865608; x=1754470408;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bPCYtgpJAwxVT8AhHF2T5Ep1xUhvbwlehO0mCuuDJ+I=;
        b=pVejEAjTlgcdbxLXSM1OOmGSIitoiCNciIWabOZokGSwaHMdN69ArVRtx6xlI5MhQp
         yFvu9NamORCBiNA2zVZc5LyFBqXMNbTPUWq/79yXh8ns6JC6wsoUvrUm6zqV7bTX/Mga
         uWXX6G13H/THTv3OAoG2V7BuRNvK/ddmBNd1D1viswn9drhz8hI+NP0Xob8898RoTb6D
         UKo7n25Ry9ry6bUY9lJK11avuTk0pe/0HXJt8DCvzafXqFApXkoucuMJPDyLNSvJq799
         eDfP8lbhdPukjbbTzbFDacWkCdUdinVawaVK6BpKbEnLRgQjuuC7HL2CTaJ8DDrn28HX
         O4oA==
X-Forwarded-Encrypted: i=1; AJvYcCWdisbFDhjzEQdHMyNxZS/Mi/FWkNpOyH9OhReruwWFpgiZGTSd0O09R1NGBORrMmqukzo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywli6gxydT+322ibT4VTql78a8B6SeX6VNnDPq18q9OGMOp60mS
	jA6Jbzp1X/hlyA1jVYGeuwpF+wPAng04heoaPnlocDiET1ffB5OhfKUg
X-Gm-Gg: ASbGnctGqS+bvy76UO6/lNVoolhXC1EVvGGuB5oLVrykLleDErvQjXiTvsUHvXIXUeL
	vSZv26X2LtdnPVafXU/zpPFUhmx90nhB60B2W7L15lg9X9AeoXlZEY/jMQNujjrRaJTCczlbOdR
	7AC+a8q5LjUAaE7FIM6El1t5hoI7NAfGJuQT0dDhJ4rrbKWgnnknP+y1OefAiFC93+GElPI1V6P
	jvm1hH7dKg2PAR5vHciI68NJbRgKjY6RH6LNZNt6wPDpIK2VadlGFp/VMnsc+1Id4aHh1o3H7Zx
	Z/3Rl1rIAgcQA3WV64HUUsunCFKlQqF8yR9MZMg9QpDfNuEtxj+Zg9TpQcU0WF1m3mRMDNWH+vw
	naOewsqdO17Bmsb5aAqg2m1fjbe8mP+dIlCTTzltoUkJxBCKwxw0ImfzKz4MZnrtU39ykU5lknq
	ym
X-Google-Smtp-Source: AGHT+IHtZDgZDJ4XNP1IYAae/FJoEHNRfhy6VX22GtyHB0Hes/YcUH4Ch2KfC10fGIJR6RL0UHLlnQ==
X-Received: by 2002:a5d:584c:0:b0:3b7:94c3:277d with SMTP id ffacd0b85a97d-3b794ff38a1mr2040648f8f.20.1753865607951;
        Wed, 30 Jul 2025 01:53:27 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c? ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b782b2bca5sm12684321f8f.70.2025.07.30.01.53.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 01:53:27 -0700 (PDT)
Message-ID: <d61c966b-61ae-4ba9-b983-c8dab6e2c292@gmail.com>
Date: Wed, 30 Jul 2025 09:53:21 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [GSOC PATCH v6 0/3] environment: remove sparse-checkout related
 global variables
To: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>,
 Ayush Chandekar <ayu.chandekar@gmail.com>
Cc: christian.couder@gmail.com, git@vger.kernel.org,
 shyamthakkar001@gmail.com, ps@pks.im, ben.knoble@gmail.com
References: <20250603131806.14915-1-ayu.chandekar@gmail.com>
 <cover.1752882401.git.ayu.chandekar@gmail.com> <xmqqcy9qlfm8.fsf@gitster.g>
 <43aaec10-2696-44c9-8728-2045b83dc5d3@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <43aaec10-2696-44c9-8728-2045b83dc5d3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24/07/2025 14:25, Derrick Stolee wrote:
> 
> I think that the core issue here (and probably causing the issues
> that were seen in the user-facing issues) is that the repo settings
> struct was intended as a place to fill config for some one-off
> "feature flags" and not to replace core functionality for a repo.
> 
> There are two ways to change the approach here to fix the problem
> of needing prepare_repo_settings() everyhwere:
> 
>   1. With the idea that these sparse-checkout variables are
>      critical to the functionality of the repo, they should move
>      into the repository struct itself and be initialized along
>      with all other values there. This changes the patches (and my
>      follow-up series) significantly, but mechanically.

Patrick and I had a discussion about calling prepare_repo_settings() 
from repo_read_config() recently [1]. It turned out that does not work 
but I wonder if instead we could change git_default_config() to expect a 
repository pointer as the callback data and use that to initialize 
things. That would mean that we would not need to move code out of 
git_default_config() to remove global variables and we would retain the 
"last one wins" behavior when two or more config keys such are 
"merge.log" and "merge.summary" set the same variable. It would be 
fairly invasive though as we'd need to pass the repository pointer down 
through all the other callbacks that end up calling git_default_config().

Thanks

Phillip

[1] 
https://lore.kernel.org/git/f6479d6a-32a4-4a49-a75c-589978cb9a57@gmail.com/

>   2. If we are going to change the intention of the repo settings
>      struct to move from "optional one-off feature flags" to
>      "important information about the core behavior of a repo"
>      then we should prepare_repo_settings() when initializing the
>      repository struct.
> 
> My preference is (1). The only argument for (2) that I can think
> of is that it is sometimes helpful to share only the settings for
> a repo without sharing the whole repo. But that seems like a weak
> reason right now.
> 
>>> * For 3/3, Phillip told me that it broke user-facing as it will be
>>>    parsed quite late in the callchain and might throw an error mid
>>>    operation which we do not want.
>>
>> So has the behaviour change caused by 3/3 been resolved?
> 
>>   * This throws everything in repo_settings, but these settings are
>>     inherently per repository and they are meaningful only when you
>>     are working with a repository.  What makes us choose to make them
>>     new members in the repo_settings structure, not direct members in
>>     the repository structure?
> 
> (This is the same thought I expressed earlier in this message.)
> 
> Thanks,
> -Stolee
> 
> 

