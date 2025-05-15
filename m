Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837B41AAE13
	for <git@vger.kernel.org>; Thu, 15 May 2025 10:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747304384; cv=none; b=ueE5pu4WSJ6CpYW0REA3jaFXof+xvVFoor6kISzUHJc5jCGe021Qk0tesS8etWWbmw2Rc+YHDmMGcJzskm3633radoWVKTdWXxLfwUx25w2hxaowuOrLCpYycDiK3PDPYIliD6TFivCsVMAMunxOkFTXys/3BoouwRTc9lyat2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747304384; c=relaxed/simple;
	bh=0vBLHaCXQwSh+7LOJnq7U94j1Z/yagcwB2qKxLqRyFM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:Cc:
	 In-Reply-To:Content-Type; b=AfpT8nfLn2zRJOPpc9MRuTngvbHR79stQRMPTSA8mbjLnZwRZBcbqBKPV1eMOiFezJxh+nmQ/wrI/lOLFKwkZN96dCsGX3DQP00gzW1f1ejJJ0E6wNRhd7n2TIFTkO3COAm5VYefK+lMF7NEdQKVQ4/l7xjqMqSQ75Bf3xB7IMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MYk8sBFr; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYk8sBFr"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-442eb5d143eso7660655e9.0
        for <git@vger.kernel.org>; Thu, 15 May 2025 03:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747304380; x=1747909180; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dObi6lHeFhdtethqq2Y2P22KX29HxAKcIarM1Hoq4N4=;
        b=MYk8sBFryVOMNC3Jh5rlg84n/Wv1xlgImfTvjvAiJN4mXRDv2BUIiU/7WJxQ19KCiG
         cAMa+ASCBMJyxlAY/XVIjEPLuopKSIvbg2ZA2XlxfOA5iSktrkDUTguwM5bKPooEotws
         7AYLCzaMmguf3qrLvSeLh0+eKrxw/JyJUEIp9564YSDThvcMIMCYsPNeqmJ9u35//3vK
         rN+5jyvNEZuVDmYItBS94VV6IJmzeA/9yR3PCL9iZhtFDiQrfIse1sX+tbyGuRsUCLDP
         YfqF2iL1Miz+CzW/s5zkE1SLcq34Qlr01IEWJoCUy/HXZSbjwDtm4vLSizYP6RNZ8Bh1
         lD4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747304380; x=1747909180;
        h=content-transfer-encoding:in-reply-to:cc:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dObi6lHeFhdtethqq2Y2P22KX29HxAKcIarM1Hoq4N4=;
        b=gLPDifi6ke3KDKXPc+ScksbjHoseBiKzhfcygJRRVyV9ycLyraz7XOj9OKWsJlx1yd
         cLs64JZodde0N8OTCsaT33/9uuTIyibBxzgqUsMofwUUs1EOY9cw3ZzhMGDo1unk/Dov
         3aSF60sYM3BKCMweRgQVYe3QqTiZwbI2rVpQ9TvJJzws+ABafOej6Y7BHdve5phJRXBu
         a37sMDiBv2nmH6hnoEz5oyVG9dT1oYbr8j+pUjmvYBf12Tk30YwIUjzFtO8vVWjMlb1d
         L7xvheXK+SJZO6IbUflRYHGKCUNU2n+FWAwoipttogLRk/kXS+CsRDsyUfvMkoBieea8
         uenw==
X-Gm-Message-State: AOJu0Yy8JhNser08FjKWAQq09akVF+oI6MwLYrm8h12liPcwSmF4etC9
	Qfqnbde11WDvc/iZij4mZCgW0iEmScoEqr/3sAxQgtOzaDxzI8ezIc210A==
X-Gm-Gg: ASbGnctbaW2T8uSTkhqpoQZ4a5+hZW4LKX9URT/w4JEjLvY5GW1OFTgVCeJTQPR95PT
	qQlrfNDmjaB2TSBrH655/1aNHGtd8D12PpIx0u7pXg3kKbpUDclbCbdQI1IDIbpkPgjZ6bOvkcf
	gw3gBBHw8tul4WNjph6BWOLiSkHUPaVDASPecXG+7lKZlIoeIAqucJ7qZp79hD240rLbUU0GlVr
	2H84s3TMg5zYpJ6rLjEaLTuIPQrcyBh3A/z+/MXgbLMVDA95AMoCdtoy3rLg7BBd9ziyvFX0Ja/
	pYBCs+hIon2bTAzDbf/GadmeeY21B3eJVSxiyAdMK+HSDCWXkEa3kCsWvwEfVLRA0oLWM0BWmJn
	KMkSHvoFERHK3W6OrlbkpDHZVgtlEm1X3vVUT0kknTc43
X-Google-Smtp-Source: AGHT+IFPf2LTRJjJGF4W6Lvdr+mFPw7c2Q6V3mxJlQVt3j+3IcTI6+hj6fQKYV7w96W+7NpF8EZ+Tw==
X-Received: by 2002:a05:6000:1a8d:b0:39e:cbe1:8d68 with SMTP id ffacd0b85a97d-3a349694f45mr6443642f8f.6.1747304379764;
        Thu, 15 May 2025 03:19:39 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:efb:6e00:24f3:2d85? ([2a0a:ef40:700:a501:efb:6e00:24f3:2d85])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58ebe4fsm22652029f8f.39.2025.05.15.03.19.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 May 2025 03:19:39 -0700 (PDT)
Message-ID: <177e43a6-6086-4e20-8ba3-6b84e7025fc2@gmail.com>
Date: Thu, 15 May 2025 11:19:38 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sequencer: make it clearer that commit descriptions are
 just comments
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
References: <pull.1923.git.1747275627422.gitgitgadget@gmail.com>
 <5voz3jolpff7wbs5yg7jvz5dt7omcikhna7j7646veagr63quv@kkxhzxxf4uf2>
 <40c32d33-b170-4319-ba1b-b93dcb2b23cf@crinan.ddns.net>
Content-Language: en-US
Cc: Reto <reto@slightlybroken.com>
In-Reply-To: <40c32d33-b170-4319-ba1b-b93dcb2b23cf@crinan.ddns.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Sorry I forgot to Cc the original author in the message below.

On 15/05/2025 11:16, Phillip Wood wrote:
> Hi Reto
> 
> On 15/05/2025 05:42, Reto wrote:
>> On Thu, May 15, 2025 at 02:20:27AM +0000, Elijah Newren via 
>> GitGitGadget wrote:
>>
>>> It may be difficult to correct users' poor commit messages, but we can
>>> at least try to make it clearer that the commit summaries are not
>>> directives of some sort by inserting a comment character.  Hopefully
>>> that leads to them looking a little further and noticing the hints at
>>> the bottom to use 'reword' or 'edit' directives.
>>
>> For fancy things/editors that recognize comments, this will *dim* the 
>> commit
>> messages, to light grey or such.
>> This is decidedly not what I'd like to happen at least. The commit 
>> messages
>> there are my primary way of navigating the commit, given that I'm not 
>> learning
>> the commit shas by hard ;)
> 
> As the commit message makes clear we already insert a '#' between the 
> parents and subject line of a merge command. We also append '# empty' to 
> empty commits. If there are editors that erroneously treat a '#' 
> anywhere in the line as a comment they're already dimming things they 
> shouldn't. A line in the todo list is only a comment if it starts with 
> core.commentString which defaults to '#'. Editors that unconditionally 
> treat '#' as the start of a comment are buggy.
> 
>> While I appreciate the motivation, I don't think the comment string is a
>> good approach here.
> 
> As the commit message points out strictly speaking we're not using the 
> comment string we using a fixed single character.
> 
> Best Wishes
> 
> Phillip
> 

