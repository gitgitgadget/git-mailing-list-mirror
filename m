Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A7A277C96
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 11:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792064620; cv=none; b=QWyTTrWDNBPvYlWSwghCtSQSm18mg93DfPdBqp+pQO0LWnPzoW9Qc3o70NllEUkH+P97zdDWNUqyfxjZoRLE16phU1rwvMfLqARhwy5BBIx+DogI5u51OaDTsOoQIRgQmFZ/62KRH/htkWIMqFYAarikk7mpouKam5fBBt36BeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792064620; c=relaxed/simple;
	bh=TTdYuQYDOB8xPWzUmX6bhkGEv9c0TzKiWij+8iKEdQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vb6yEskvvZU2h6LA0BbPxQFgQiDIVm0SDscQ14ZTONTSnqcxGIbfS/MqM/mpa2F9Ey4MTeUDOQSbXmwx1+Jve/p/AaAgWPkvJNFpEKwp27TX2e+PXCx3S9S9rY78vdAjiz8NGg/jiiDPOKAgfZg+t5EpJ7dapNvR4o1ISnbGSPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U72J8khV; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U72J8khV"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-3535bf8b3e0so3063560eec.0
        for <git@vger.kernel.org>; Thu, 15 Oct 2026 04:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792064618; x=1792669418; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W0aFcyzav3yRrgdO3t4CV97fWmNujYW0y0Iny723duE=;
        b=U72J8khVZHgyeoU+XQyH8jeGgikaEpEBh7pjJm12P2X+6sWMnSotcnWrH54TM8F2tr
         qRR/X3NDwoWsZmDcJ6ShivzLRSMyWZf2lCdkq1eQUZha4iW7Se1TwYXKesJqIdeYuJ9j
         nN2HvsfEVktJdS7VZ9cl/6y8QDakcxDafup9RS8JRohWBJeB2JPYTeVXvbVb4BG6XYHb
         DH1Lyx0BGxP/VvYxtruFR7+EE7WaThoMzmycha3DgQLzXQEEpZUZfW/6cXIMnrJd0f5m
         cRLpZzaVoHJ+Gtke0tSa1nvXxwgKQJ8jfwhOiv7BQ6AbB88Pfqc8URWSJOD6SmRsSFCk
         O97Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792064618; x=1792669418;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W0aFcyzav3yRrgdO3t4CV97fWmNujYW0y0Iny723duE=;
        b=B+M/nQWWwTOZ1ERdWiwnOCqA+8VGLiWo0P2tA31AzlSUQQ7SsAt9qfLbcNynY6Jh49
         H43iUBenJASpOX1/5Gm3PDT8ND7t3k5UN3Blpg+nPtzjX2x8pFl0Pg4IW46vVnseSdIq
         fMdtmlqWawTypajmp78g6/r6ZAne/yeASuDy79AQZYHduJGvOUwc34g87LXkwwQR0uFq
         Eon+smZDcKYwF5Cx/yTlYDMKbjb2dkr+utqY24LITxHR5N1oTrnlZMl7uAFZ9jkqgsG2
         xWx6cBU/tlftc506ONLX3cmNenTILsbvgkWu3lVSPJ+18qh70Llwmvm2sM7TyXp/wlWk
         vRsA==
X-Forwarded-Encrypted: i=1; AKwUvByBkyc5aJz766c6TtNb+pTPfa1LyWsMelMOatcuoR7RaJN6hvt0r2CqivN2FBwTA7DaXTA=@vger.kernel.org
X-Gm-Message-State: AFq9FYI5krYrtvGPe3Hq/kF5w3EMpA7PJ63P8blLH03Nhp4XPqSsS1GF
	vPw/Fm4b5tjkAakdKRGo6n+dvgB0jhf5cleXhOGDcaa5OrGZMe7kcDS7
X-Gm-Gg: AYBFou1iOP1ZV8i5rUl/qI2+IUZrSV016lzGfW8YTTwyqSCp2gA7+I9Wvozf7BZm+5S
	JZ8q2QenBn54PC7ow92udfi15yxus+VViw+TOZi/l2RrghPQFAiuKeLO11eL6Ewcmj32KT26FC8
	Ea5jOF3Kzc+mAAX02W2wWSZWBHfK/9ZRVgw5h+QafVlML3XdreaYG/6y+iPOrO7SQuG1Tw575zg
	fgoUdkYtkJH6Mcf5mhJcRqMLIqlJguBrWeJ58wCT5KJoeJBvl5PpXoKReWVhqAFEeDYo5jqovU6
	zNaD4ZqvZveY7z66SXsK5Bv9Cz8ZneomWa+4Z2eCHovOFWkb/WkKNc8rjRjZHAQPx7JK0rfz/DA
	9elFS5gjRbXuDLKofx0qU7JUPYz4XOsXYGDJWQ+qaPL4hDNDFpw3xVFAtjJBlHBSKmZJrVfyAYI
	N42kNNEpJz/8iugwZuRJig6o+9UbD3AII6xIdYMmmWzlV/MUF4tzCfTtVCFvCU6jNT0MkXjcAIe
	n5EATGL5XAGZA==
X-Received: by 2002:a05:7301:797:b0:353:7e28:9c58 with SMTP id 5a478bee46e88-3537e289d93mr23541955eec.41.1792064617847;
        Thu, 15 Oct 2026 04:43:37 -0700 (PDT)
Received: from [192.168.25.219] ([115.108.41.154])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cab27d5sm68356023eec.17.2026.10.15.04.43.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 04:43:37 -0700 (PDT)
Message-ID: <9c905a79-22a2-4db2-b434-00ad8a287300@gmail.com>
Date: Thu, 15 Oct 2026 17:13:33 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] t0081: modernize the code testing whether a file exists
To: Junio C Hamano <gitster@pobox.com>,
 Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: Shashank S via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
 Siddharth Asthana <siddharthasthana31@gmail.com>,
 Shashank S <shashu8660@gmail.com>
References: <pull.2254.git.1791962806807.gitgitgadget@gmail.com>
 <CAPSxiM9-F-1XKvWeEnBk=_FyKyev5pfnid4fiN-OjLYLnCTWVw@mail.gmail.com>
 <xmqqzewgosyw.fsf@gitster.g>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <xmqqzewgosyw.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/15/26 03:17, Junio C Hamano wrote:
> Usman Akinyemi <usmanakinyemi202@gmail.com> writes:
> 
>>> From: Shashank <shashu8660@gmail.com>
>>>
>>> Replace the old-style shell `test -f` command with Git's modern
>>> `test_path_is_file`.
>>>
>>> This instance was found using:
>>> `git grep "test -[efd]" t/'
>> This is not necessary, remove it.
> 
> Since many candidates are working on similar microprojects (which is
> fine) and making the same mistakes (which is expected), perhaps mentors
> should tell them to read the review exchanges on other candidates'
> patches and learn from them, instead of or in addition to giving the
> same advice repeatedly.

I agree that it is a good advice to ask candidate to read other 
candidates' patches. We do recommend this in our guide related to 
working on Microprojects:

  
https://git.github.io/General-Microproject-Information/#research-existing-related-work

That said, I just wanted to highlight one thing. In the Microproject 
ideas page[1], we have the following for this specific idea:

   Notes

   - Start small: Pick a test file with just a few instances to convert
   - Run the test suite after your changes to ensure nothing breaks
   - Follow Git’s commit message style
   - Include which command you used to find the instances in your commit
     message

So, we can't really blame the candidates for including the command in 
the commit message. It is our mistake asking them to include it in the 
first place when we don't prefer it to be present there.

I raised a PR to fix that:

   https://github.com/git/git.github.io/pull/875

[1]: https://git.github.io/SoC-2026-Microprojects/

-- 
Sivaraam

