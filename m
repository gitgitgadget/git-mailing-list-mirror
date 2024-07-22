Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA8014B95E
	for <git@vger.kernel.org>; Mon, 22 Jul 2024 10:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721643485; cv=none; b=odHKNVD1q/wpgYyi1Co1Mb0Tz7+RjdriFtC5V2AC0oQFtitFK5yU+ZxLAlCRTNugy//l9mCejjCTFd4PKgXsMV20F6SYQMBcN5I+7E6QVoGO2z0vs9L21Xcxyh48ypt7UomgHl95SLNlwVALhZ6JLAVjYLwZ97Sg+NIBSAgc7wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721643485; c=relaxed/simple;
	bh=aZM++eB5c33miM+QD+BDefy6//a+j6Xb5e+4JXfkJv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hlMoc5DqrFDNiZS8HuoTiQzpIqcfsWhr9OvRBMkRtyUqAkdnsKEc6wN9TTo5r2X9keVgjsUtauPCK2evP4q0lPf09/5j20nplJuS0YvLPlRWJFS7q2yp9vfSc1QWvBg+Mm6WIi0tCSyWQ/5B8IZ+HZQzXONLkzXrNftxYoYL2HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JXNl1hLv; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JXNl1hLv"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a77c1658c68so434504166b.0
        for <git@vger.kernel.org>; Mon, 22 Jul 2024 03:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721643482; x=1722248282; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qJpzlXoCvu2Q6ND0VpJAPJ798QJMaOMuzzd31dbdjHg=;
        b=JXNl1hLvq2PaGWAtPd6yHKYtB93gsb/Vnac1wERb8IGubWdiH4Pztn86fOlyN3Z8hT
         oapRIOAewFB5IariF4hv8p+5mIid4IyEdZTXxA1c4CiT/auAsXamt/fXSfyqWEx/nPDr
         iVwgxMUgV/roH6JHuvlLgdNhuEo9jw82xvzkIUOqEd7+9T5Xq7obdMJuWHVgDiFTFMqy
         9EZ8DAKqEExwAj1qPShMpwuq0Asu03KdHre9KA6Q7MjQpgcXzh409OMz/T0Se2v+AD6P
         lyGE6Fy/ZixTmsupEht9dyyO2uI9AWAr2rOo9q80TFxgmTdZQ9VofZSuMQk3ZA3Gjjxn
         xk2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721643482; x=1722248282;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qJpzlXoCvu2Q6ND0VpJAPJ798QJMaOMuzzd31dbdjHg=;
        b=JOn6P6BcBVl6BOWudlwlz+9mtat2rMR8UR/ZCJ806IX2IA5ggcxmvuoNd6uf/m97jy
         xu7Ww1Cmlo7pX69aauCMwPs+PMXLEAWvn/EP0SUx+7h1iZQIRNLMfDaQGVgNfl1u6TxP
         v4eLHUMNO3IuR6bHCr1Wmds5i84t5UKi05TRZpReoQNZXxBr73y6qrZKBMM8HQfcH1+6
         uplFWj6JMO8Lv7piNkcO9mL1/U5vNM2ZIyPmL8mJI3ViyY0DFQjkLjC+TaNQ2IZxtGwP
         LNXn1hxGN6a2JbOGeqPLFKL2boe5d9FTrF8XWAZJJ1JSG+EZGnIa/Ps2hdgxGBCZYSMv
         5orA==
X-Gm-Message-State: AOJu0YzBTej1AN86X4HgHkoiPiDqzeTxTlcqw/5GkAS2EeRi+YVZgtUO
	wTeVcqzA2rP5B4G+XMFuMt9iASGQpXve7RvCVtPLsMp9Dol5/n9TtiR9tKS8
X-Google-Smtp-Source: AGHT+IFzoWoBT4gBsua7pmBYp+Xy/3ci/vFQobxVYjUzSlGU+xLoR2kMQNzN+9KSYSEemL5Fi3zh0g==
X-Received: by 2002:a17:906:b7d7:b0:a77:bf32:b91e with SMTP id a640c23a62f3a-a7a0133729amr960084766b.49.1721643481427;
        Mon, 22 Jul 2024 03:18:01 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:600:8501:d2c6:37ff:fef6:7b1? ([2a0a:ef40:600:8501:d2c6:37ff:fef6:7b1])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a7a3c7be6edsm405896566b.85.2024.07.22.03.18.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 03:18:01 -0700 (PDT)
Message-ID: <5360ab9d-6d3e-4da0-b1c4-2ff381372c1a@gmail.com>
Date: Mon, 22 Jul 2024 11:18:00 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 4/4] add-patch: render hunks through the pager
To: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
 phillip.wood@dunelm.org.uk, Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>, Dragan Simic <dsimic@manjaro.org>,
 Jeff King <peff@peff.net>
References: <2653fb37-c8a8-49b1-a804-4be6654a2cad@gmail.com>
 <ebcba08f-3fbb-4130-93eb-d0e62bfe0a8a@gmail.com>
 <efa98aec-f117-4cfe-a7c2-e8c0adbdb399@gmail.com>
 <1dc9ebad-768b-4c1a-8a58-8a7a5d24d49e@gmail.com> <xmqqttgqyzwa.fsf@gitster.g>
 <2b57479c-29c8-4a6e-b7b0-1309395cfbd9@gmail.com>
 <88f9256e-04ba-4799-8048-406863054106@gmail.com>
 <a2ea00e2-08e4-4e6b-b81c-ef3ba02b4b1f@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <a2ea00e2-08e4-4e6b-b81c-ef3ba02b4b1f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Rubén

On 20/07/2024 23:29, Rubén Justo wrote:
> On Wed, Jul 17, 2024 at 08:39:12PM +0100, phillip.wood123@gmail.com wrote:
> 
>> On 17/07/2024 18:20, Rubén Justo wrote:
>>
>>> However, this error has exposed a problem: calling `wait_for_pager` if
>>> `setup_pager` hasn't worked is an issue that needs to be addressed in this
>>> series: `setup_pager` should return a result.  I was planning to do that
>>> in a future series, for the other commented command: `|[cmd]`.
>>
>> What was causing setup pager to fail in this test?
> 
> Because GIT_PAGER is not being set correctly in the test,

Oh I see, I had assumed that the shell would report an error if it 
didn't support setting environment variables like this when running a 
function but instead it silently ignored it. This highlights the 
importance of testing the output of "git add -p" in this test so we can 
be sure the pager is doing what we think it should. Using

	GIT_PAGER="sed -e s/^/PAGER\ / -e q"

would make it clear what the pager is printing while also causing SIGPIPE

> "git add -p"
> can use the values defined in the environment where the test is running.
> Usually PAGER is empty or contains "less", but in the environment where
> the fault occurs, it happens to be: "PAGER=cat".
> 
> Since we have an optimization to avoid forking if the pager is "cat",
> courtesy of caef71a535 (Do not fork PAGER=cat, 2006-04-16), then we fail
> in `wait_for_pager()` because we are calling `finish_command()` with an
> uninitialized `pager_process`.
> 
> That's why I thought, aligned with what we are already doing in
> `wait_for_pager_at_exit()`, that this is a sensible approach:

That extra information is important. When I said [1]

 > Isn't it a bug to call this with old_fd1 == -1 or have I missed
 > something?

What I'd missed was that we can return early without executing anything. 
We cannot do

	if (!git_pager(asatty(1))
		return

at the beginning of wait_for_pager() because if we're running a pager 
isatty(1) will return false so I think the old_fd as you suggested is 
the easiest fix. The existing callers do not need to know if 
setup_pager() applied the "cat" optimization because they only setup the 
pager once. For "add -p" this no-longer applies so we should think about 
returning a flag to say "there was an error"/"there is no pager or the 
pager is 'cat'"/"the pager has been started"

Best Wishes

Phillip

[1] 
https://lore.kernel.org/git/3f085795-79bd-4a56-9df8-659e32179925@gmail.com

>>> I'm wondering if the best way to proceed here is to revert to:
>>>
>>> diff --git a/pager.c b/pager.c
>>> index 5f0c1e9cce..5586e751dc 100644
>>> --- a/pager.c
>>> +++ b/pager.c
>>> @@ -46,6 +46,8 @@ static void wait_for_pager_atexit(void)
>>>
>>>    void wait_for_pager(void)
>>>    {
>>> +	if (old_fd1 == -1)
>>> +		return;
>>>    	finish_pager();
>>>    	sigchain_pop_common();
>>>    	unsetenv("GIT_PAGER_IN_USE");
>>>
>>> This was a change already commented here:
>>>
>>> https://lore.kernel.org/git/3f085795-79bd-4a56-9df8-659e32179925@gmail.com/

