Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F83D28D8DA
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 13:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781790543; cv=none; b=V4AuNlpNZF6cxtsG3NaTAVGNEM4tPuKk/5/FCl/mAXeoZ68T4r7Rtrhu+Zvtd8qQO6GGV/wE4mxRsICibvlKxOYA98TytYYWcxMgbik4kAaM09k6CejoFcYZvSTWdQtiJ4sH1hJa5/e8YiPHN3C/9yfULOC9ZEtL2uk3V4dXOvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781790543; c=relaxed/simple;
	bh=BRM8llVGzvJUEWHWIDf1AQnznd1dNdapL1igNNjYfb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gtRYl1GH/2L4zxqDoR2JnrqtXZGwHDLimbabdtGW5Nnmblrdb03cUpbWKxnpT0j3pq3unf/0ZIuARa0+H77hAzLr84aN787mdAFdbN9CGjW2y2kPj6NmEWC54r3y4QrxLx9kuKeY1mACQ+jbmFmLvtEYmfddVel0JTX1josj/WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gc0Yx2YK; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gc0Yx2YK"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-bdb3fd39045so119184966b.3
        for <git@vger.kernel.org>; Thu, 18 Jun 2026 06:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781790541; x=1782395341; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zeQwJmxBOoSl0ofuvCiF30oH2l1xSh6Qih/yN1EUbis=;
        b=gc0Yx2YKFep3YQgMbZ9ev2hHATReZPyLvQDsnMLmKFHs1o/e8wSahfPCfR4aUdZlO5
         SdhK97bCg29bxHdaiWzrVUitcSm+l37MTKhgnRzeCYJMBU/y9Hb9RmtnQQUhqGZLOFJe
         vYqRNNW3VqtM7Ti5jKo7S7hrNQUrOAhdqir+MUQru6DcXFwDjADPrB5l5NbCF78SkpEH
         3DOAbMfHP5jCchR8ldaBqmrQ1lPX27+2rg4OEkAnK0Vu0vu3/s+jXPbVOhjSNUOzMSHS
         xq9jOG/822rC0utNltIOd3IyizAP6TyblTV/x2eJHfg4qjiLLU1sqT1LB0J3LW41q0Me
         mo0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781790541; x=1782395341;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zeQwJmxBOoSl0ofuvCiF30oH2l1xSh6Qih/yN1EUbis=;
        b=Xqn+yL4sTSU5dOrgWFLNskAY90/PBj+09VGgQ8h+mdYfL9H1Z+927VXBa+tKwymSk0
         PH9hIRv5oK67f1/7N84F54metMRkjMEFnmcLIVlRuH1e1GZ5knXVPEP8nRDw+A4poWsd
         rDL4/pPMCN1DBEIvhig+I4vgHGrGUCFG8689rJJu6lojLCduUeKGM7F6SHKSwDrdrPdn
         ws3jzodOwqGO9QmIYCESwCGAlywx7KFRExr4UKG2299DKm+g3WhCZ0C9LpB10X94Ww0o
         nskTpQqa4X/WOkvj2UrmWluOSf1Ye5RdM0k5JCz3ffub8JlJprsXKPDmihPOm0/0n//D
         sSSg==
X-Forwarded-Encrypted: i=1; AFNElJ+QywbDgHk8V1N+5ChLAMW76wAXiH9iGgBpPn36MzTPXnaB5k9WNb7L82A1BlHQ/0Up+24=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT/NzfBySmX1xihAzKa6AhfHpMuRU6X1qkLethwE45s+boWGRk
	lTXNvuG8mwpI01iDkAUxFNhTk6lIPA6T3q+I2PQt1J16iIe9FnWjttty
X-Gm-Gg: AfdE7clrXfhEI5qkP3Coz0ARMXrrSbn1D0Vjek+5x12WTxJ2yOTFwSlmBCTkQOkz1pd
	nbiQaew+C0nXNSX6rHTeUATXa4wptTkNg8h+EjBbU2yRKiY+mfxTTYzthgQsg6QfpCLopQ7wOfC
	ewvVkLyl7BdUarP/Qc+W6boBHXNazJYjR8eKirFQ9vE64bttT3aDpnOF/RSjeljgH5+WWKWAX5T
	Qo0bOSiYOkCUJavdFF0EeKKag1drAWi/nHSMFEMtEbJzK4pAUOdi+Da0xC1XZ93JmMBra60yX0s
	P8wvouMqLWfg+ab8b0wK23VrVghu6JlEslG3AcrUlJDw2QYPm42GLiLhdSCARboY6lINs/zS19i
	N4YouIUqITgyTzJqVMvJrEvFLeG0jL0LMaMCpChRdhl5UzALyJyiI1Brk56u35Sc2wpAjka0qnP
	pMlOB4WDm8eyqqfevoV4X30C3+pwkWO9ksWTG5qSLu05xOt1ZEBJgRX+UFzVBJw3CdyULMVZYGE
	K4W6w==
X-Received: by 2002:a17:907:ab3:b0:bfe:ed16:2841 with SMTP id a640c23a62f3a-c05a9b7753emr409257066b.53.1781790540281;
        Thu, 18 Jun 2026 06:49:00 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69a:b801:201a:26ab:8d41:fb43? ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb4b2276fsm966072666b.17.2026.06.18.06.48.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2026 06:48:59 -0700 (PDT)
Message-ID: <feac3d8b-e291-48e8-ac73-3b1f5321799b@gmail.com>
Date: Thu, 18 Jun 2026 14:48:57 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v15 0/7] branch: delete-merged
To: Harald Nordgren <haraldnordgren@gmail.com>, phillip.wood@dunelm.org.uk
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>, Johannes Sixt <j6t@kdbg.org>
References: <pull.2285.v14.git.git.1780999917.gitgitgadget@gmail.com>
 <pull.2285.v15.git.git.1781542042.gitgitgadget@gmail.com>
 <f68e2a11-02a5-47b9-a01a-458eba821c37@gmail.com>
 <CAHwyqnXRo=P5Zihs6s7Uh8CrYCO7mjyeZ5nAv9JqYbGH0RE72g@mail.gmail.com>
 <5829103e-d357-4880-b295-fa0d9f4a2c62@gmail.com>
 <CAHwyqnWFM2jskm6soEu58tp_TgO3fmuODD-yTiK6-4Hpv8SMLQ@mail.gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <CAHwyqnWFM2jskm6soEu58tp_TgO3fmuODD-yTiK6-4Hpv8SMLQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

On 17/06/2026 20:11, Harald Nordgren wrote:
>> Right but you sent that version a few hours after I'd posted a partial
>> review which concluded by saying I'd finish it the next day. If you send
>> a new version when you are waiting for further comments it clutters the
>> list because you know you're going to have to post another revision when
>> you get the rest of the comments. Anyone reviewing the interim version
>> is wasting their time. When you receive review comments, by all means
>> start thinking about them and updating your local copy but please don't
>> post a new version until the discussion on the previous version has
>> settled down.
> 
> That's fair. Sorry about that.
> 
> Will you let me know when your review here is finished?

I've just sent a mail with another comment but that concudes this round 
unless you have any questions about it.

> 
> I received the same feedback from Junio before, so I'm not unaware of
> this problem. I am trying to slow down. I often prepare the work as
> soon as I get some comments -- I'm on paternity leave so I have a lot
> of time when the baby is sleeping -- 

Congratulations - I hope the baby is sleeping at night as well in the day!

> then I actively hold off on
> sending to not overload the rest of you. But at the same time I think
> it's valuable to keep up a certain pace. It's a balancing act.
It is worth waiting for the discussion to settle on each round, I'll try 
and be clear when I've finished looking at each revision. I'm sure other 
folks would appreciate you looking at their patches and commenting on 
them while you're waiting for feedback on yours, especially the GSoC 
project students.

Thanks

Phillip
