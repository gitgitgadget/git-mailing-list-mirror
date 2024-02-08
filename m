Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2221078B63
	for <git@vger.kernel.org>; Thu,  8 Feb 2024 14:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707402381; cv=none; b=hEpOhf1vT0i+MtBeig245X8/2p/dv5yN7JL+voW0KUi6MZ5X4n3NoRl0P3F3MZwMtCWVzegJkLq4iQRVXlUYjE0ABV/MoC0vNzdVC6a8GM58KR/fFDxfLGAoOzj33TBOVzc5ntqtKeJhqxNvy6pPFmfpx8z0qc09IryCmVPmhBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707402381; c=relaxed/simple;
	bh=9jDX7GNKCEnIoER4AYNVMU/CSyAJD0gCK9+X0mwJhik=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=amZq/XEz8CxR3Tid52fjn+h3w/g7swFLblJpdKrh6fevTPgKo7oJExzmXT9jqjAIEvn0mPQ10qFkiC+MQ9+KWKZsExjr9iEFUKpN0ev8kjMmMayI/uu3Pai1bbHtnLR7pI50qZ53ll1KY2fHiGYaEduQz9y9fqzi3Ft9KTcXu28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CFUs7uRB; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFUs7uRB"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5116b017503so1738372e87.1
        for <git@vger.kernel.org>; Thu, 08 Feb 2024 06:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707402375; x=1708007175; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ViOxcjZeBeaeO086eCT+YmZYKoY+hF6Ka0dc5QkPfhs=;
        b=CFUs7uRB2SfDYcvaGWesByrL3ea4S2RNIj8Y2PDcFvTEeLLhg8CyB4evFJR3cZYD/S
         xDcltijuvAd7neaV9HHcYfu+mtBxY6+wGCa4Ea/6799OTvDbhwmp5EUU1NyOmNCGEGs+
         2PhjmKTvpYTFk5r7W845X3R9glve0cwXfPRFWiPB5uJc4IQ4TahhNhWBgOLouoEHwCPQ
         nboPAa0q9mO7LS8pAw1OAfXSK0roUZ63mQaRlsj24Tubfj3jSfpvOvuP+ymDYOH3Wj2b
         /niRamrnc3lTurKpE+0svRaf5kBwfY+aJYm07FksT3JENMBEJ1e3F7plLzB3F/akFO5i
         QxtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707402375; x=1708007175;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ViOxcjZeBeaeO086eCT+YmZYKoY+hF6Ka0dc5QkPfhs=;
        b=qD7pjvcYjfx8wsVlBLZ8/rP1oJDRtTv1DLC3/GbRWote1QhWMiTN05NDRbF2IIm5Fn
         SpNyDwPVH9Yy0hi8fmjaQHJh44UqWK4Qd0YEFe8t9uujkd+vPzWeN4Si6MK4UqPpeQ2C
         BAAO0B2lp3O8wRotYxE9Jyds92cT3m4ASG7rjhgGUP3rBz20VMzMYd8vCEW0B9ko2Phd
         tNFLcHDs7+OT5Q3VLqiPjMSvvdzuf/fNQOSytYPSo0MTdT3HNXm6/vpJb0pSdmJy8XwB
         BalRECRaoyBYospkebbj9qjotaIEDy14e+hZEm1raIXyAjVkJs5evGtsLWltAjEst9Mn
         mimA==
X-Gm-Message-State: AOJu0YzMU7WJ1Bl/H6WHwkKzUbgL9LJlzrAXqCoLqSgI3GqJldcg//HY
	9DUponehIZ6Xh3F8cqnv1sDx90LEKsHgMi1+PKK15574ID+allOS
X-Google-Smtp-Source: AGHT+IFkvQWdBDceC8mx9+S6YflP3SNo0u7Xe+NAkV+ddp8YrDfbQVfnr/+VOgxR07kdSh3evARDVQ==
X-Received: by 2002:a05:6512:12c9:b0:511:4e5c:cdab with SMTP id p9-20020a05651212c900b005114e5ccdabmr8428693lfg.5.1707402374766;
        Thu, 08 Feb 2024 06:26:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW0HZOxomU3Qcfv7liAPJc6DNoukSIGE2yLhPgXbFPs07Ez4Kq0cXWPLlTjnbTicAarqYlog145r/lNAFOyRMWS/HrgSG/ZIceb3zx+5AbRsfV2bsTfg1Lfdb1iAiS5PgNtnxBPtu/H3bAW
Received: from ?IPV6:2a0a:ef40:62e:a901:386f:d8d1:628a:e68d? ([2a0a:ef40:62e:a901:386f:d8d1:628a:e68d])
        by smtp.gmail.com with ESMTPSA id g19-20020a05600c4ed300b0040fb783ad93sm1785019wmq.48.2024.02.08.06.26.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 06:26:14 -0800 (PST)
Message-ID: <eaf511ff-f9e0-47ac-ae2e-3de0efa928dd@gmail.com>
Date: Thu, 8 Feb 2024 14:26:11 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/2] sequencer: unset GIT_CHERRY_PICK_HELP for 'exec'
 commands
Content-Language: en-US
To: Vegard Nossum <vegard.nossum@oracle.com>,
 Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>, git@vger.kernel.org,
 Jonathan Nieder <jrnieder@gmail.com>
References: <0adb1068-ef10-44ed-ad1d-e0927a09245d@gmail.com>
 <20240205141335.762947-1-vegard.nossum@oracle.com>
 <ebe188e5-7289-4f7b-b845-d59a47cd06fe@app.fastmail.com>
 <xmqqy1bymru0.fsf@gitster.g>
 <b3ec5d0b-ac17-4d1e-a17d-d5adfbfc6ccf@oracle.com>
 <xmqqcytal01i.fsf@gitster.g> <4e6d503a-8564-4536-82a7-29c489f5fec3@gmail.com>
 <xmqq8r3wcjq2.fsf@gitster.g>
 <ae8d96b7-93b0-4460-b7ed-ffebaddd6f97@oracle.com>
In-Reply-To: <ae8d96b7-93b0-4460-b7ed-ffebaddd6f97@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Vegard

On 08/02/2024 08:48, Vegard Nossum wrote:
> I'm sorry, but I'm confused about what I'm supposed to do now.
> 
> There is now another test case and it sounds like you would prefer that
> one over mine, but I didn't write it and there is no SOB, so I cannot
> submit that with the fix if I were to "squash them together".

Here's my SOB for the diff in 
https://lore.kernel.org/git/4e6d503a-8564-4536-82a7-29c489f5fec3@gmail.com/

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>

I think that typically for small suggestions like that we just add a 
Helped-by: trailer but feel free to add my SOB if you want.

> I am not a regular contributor so I don't have a good grasp on things
> like why you don't want a new test file for this,

I think keeping related tests together helps contributors see which test 
files to run when they're changing code (running the whole suite each 
time is too slow). There is also a (small) setup overhead for each new 
file. For tests like this it is a bit ambiguous whether it belongs with 
the other "rebase --exec" tests or the other "cherry-pick" tests. I 
opted to put it with the other "rebase --exec" tests as I think it is 
really fixing a bug with rebase rather than cherry-pick.

Best Wishes

Phillip
