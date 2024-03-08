Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F403DBBF
	for <git@vger.kernel.org>; Fri,  8 Mar 2024 14:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709906735; cv=none; b=XsAaOYsnKJWgVxNaoW47PClyuvBRQOlB8E9jXnLkABbJrb37ThwMqBakTi5KaMHDd/jK+3Ph+24FHeundG+3dfu++XtISl1Yvuhmx0bffopyd+DOQ4no9jC9Fl/vLRoMaXqz7SGNeMeoPdLM/hi7mVZbz+eI2G8/+PVQMdkq4t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709906735; c=relaxed/simple;
	bh=hW6Kw6QJgyr1iqit7QhwXXBfmEDu+qxaXD2vnmGIUqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n3pdcY7s38mUonrt9nfO3tYZvBkLzTVx1UMpiJacFFt2QWMK4gK5TSpQsQEX0ns1lsQDiceEPvimJeEf5YpnI8WIHOiap1hJASvQgDohLQpqENHeZZYXdoSvmoYWGLf40/LIWJ4Lx1MdY/Bl2iYb7TxP40fA1VSGtK9IEQuau0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CssPifrO; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CssPifrO"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33e17fc5aceso1855416f8f.0
        for <git@vger.kernel.org>; Fri, 08 Mar 2024 06:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709906731; x=1710511531; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=S7h9Mbd6D+2gV4p4v6CdZmQXQD9Bns8vIXSBDwj1j3E=;
        b=CssPifrO+d3O5IAy9edavYCpmI0mbvQr0GskdluG4KxAqMwbAmdRsbPhpZWyNdN+H6
         tBcmnMLXHQmE6s6u+3FxNgZx28QmxT5J8YhyjunH/6kCHbHJIpUHdQ1De5MDp2lv/x7H
         Hx8bImG+t7qchAYLqs49VAhiEHPGjYvW0dq6s/09Sz2j29XNf5VBW2JlEwM/cN4v3r4v
         IUc6cUNsmdNpw7rbsr28LAOhcnPM3GaKJlxg0R/5mm1LIhiurhxruDeLlqPuubVhNEk5
         +oxAjWiUTRla9vDPoJzOfiEsas/PMf3xrwEwBCtTYktFsVBOBHz3/N/EedvZkM4miA8N
         rnfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709906731; x=1710511531;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S7h9Mbd6D+2gV4p4v6CdZmQXQD9Bns8vIXSBDwj1j3E=;
        b=ASmOAEpZaRHDhfY1UonjkJWoW3ho59zwzeRq+wzq23pV98yM/e0lgdwdQBGAXItbDd
         yoOALJ9ks9RhMN2eCgx1Ex6IKNY31NndKg+1S+lCGJRx8Rf/Ouq0JGz6AT88plJp8V8T
         YwuuW/Hj5pQV0euavs939Su0Igjn3VmDMdrd85PJonfGqNtTJGJEDl+wWNkQ/X4KRtlx
         8Mp+vemGy9xKcn9MYEyN9aGnuyxySVPLSJT1h1+/OiyAx1Nv2EW5P87kyBo1OtuoNGJF
         YosqErn2FAuXzEaiX5PpyxKT42F1Jfng1RbwQfhPntSVjD8Qw1YS1BkO/jbE5WmItWND
         X+dw==
X-Forwarded-Encrypted: i=1; AJvYcCWu/gN2psjN9aZT6moqYOHcinKOK5otLatPh9oDnvGDDcVseb0Tc9/Up3Wp+5akUDW/ygjkkSgzdRAxMaG62EXd9HDe
X-Gm-Message-State: AOJu0YyMuep1VlNyXLK78/RT4ivNeLCKFyvpAZ9pEyKTRQSz34I4s0nG
	SPsDtmDHe5u837YKql4zRoSVOLOZoW6PukiMiCmwgWaHdbFB28pPsCIKIu1VroY=
X-Google-Smtp-Source: AGHT+IExHqkLBcF06ptkcESo/h1IcbpZ8Q7vDGfWXyj3ZDvARsbLbAOD7Tp9jmPm0tOS5+JcgsGlfg==
X-Received: by 2002:a5d:4b06:0:b0:33e:2794:368 with SMTP id v6-20020a5d4b06000000b0033e27940368mr337944wrq.15.1709906731415;
        Fri, 08 Mar 2024 06:05:31 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:6ca:8b01:d2c6:37ff:fef6:7b1? ([2a0a:ef40:6ca:8b01:d2c6:37ff:fef6:7b1])
        by smtp.googlemail.com with ESMTPSA id g25-20020adfa499000000b0033d6c928a95sm23074764wrb.63.2024.03.08.06.05.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Mar 2024 06:05:31 -0800 (PST)
Message-ID: <f2b5914b-e26e-4d92-b119-0e58ce901bb9@gmail.com>
Date: Fri, 8 Mar 2024 14:05:30 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 4/4] t-ctype: avoid duplicating class names
Content-Language: en-US
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, phillip.wood@dunelm.org.uk,
 git@vger.kernel.org
Cc: Josh Steadmon <steadmon@google.com>, Achu Luma <ach.lumap@gmail.com>,
 Christian Couder <christian.couder@gmail.com>
References: <20240225112722.89221-1-l.s.r@web.de>
 <20240303101330.20187-1-l.s.r@web.de> <20240303101330.20187-5-l.s.r@web.de>
 <0947cb09-8b07-4fcd-bbe2-ae37c2cd5ec7@gmail.com>
 <3ef0927f-4d7b-4061-925e-c113d1c8730d@web.de>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <3ef0927f-4d7b-4061-925e-c113d1c8730d@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 06/03/2024 18:16, René Scharfe wrote:

Sorry for the delay I somehow missed your reply

> Hello Phillip,
> 
> Am 04.03.24 um 10:51 schrieb Phillip Wood:
>> On 03/03/2024 10:13, René Scharfe wrote:
>>> TEST_CTYPE_FUNC defines a function for testing a character classifier,
>>> TEST_CHAR_CLASS calls it, causing the class name to be mentioned twice.
>>>
>>> Avoid the need to define a class-specific function by letting
>>> TEST_CHAR_CLASS do all the work.  This is done by using the internal
>>> functions test__run_begin() and test__run_end(), but they do exist to be
>>> used in test macros after all.
>>
>> Those internal functions exist to implement the TEST() macro, they
>> are not really intended for use outside that (which is why they are
>> marked as private in the header file). If we ever want to update the
>> implementation of TEST() it will be a lot harder if we're using the
>> internal implementation directly in test files. Unit tests should be
>> wrapping TEST() if it is appropriate but not the internal
>> implementation directly.
> 
> forcing tests to be expressions and not allow them to use statements is
> an unusual requirement.

I don't think it is that unusual to require tests to be implemented as 
functions which more or less amounts to the same thing.

> I don't see how the added friction would make
> tests any better.  It just requires more boilerplate code and annoying
> repetition.  What kind of changes do you envision that would be
> hindered by allowing statements?

I'm worried about bugs being introduced by the internal functions being 
used incorrectly - it is not a user friendly API because it is designed 
around the limitations of implementing TEST(), not for general 
consumption. The unit test framework is very new so I don't think we can 
be sure that we wont need to change it and that will be more difficult 
if unit tests do not use TEST(). Maybe one of the changes we need is a 
better way of allowing statements?

>> Ideally we wouldn't need TEST_CTYPE_FUNC as there would only be a
>> single function that was passed a ctype predicate, an input array and
>> an array of expected results. Unfortunately I don't think that is
>> possible due the the way the ctype predicates are implemented. Having
>> separate macros to define the test function and to run the test is
>> annoying but I don't think it is really worth exposing the internal
>> implementation just to avoid it.
> 
> The classifiers are currently implemented as macros.  We could turn them
> into inline functions and would then be able to pass them to a test
> function.  Improving testability is a good idea, but also somehow feels
> like the tail wagging the dog.  It would be easy, though, I think.  And
> less gross than:

Making them functions would allow them to be passed as function 
arguments in our code as well, though I don't know if we have much use 
for that. I certainly agree it would be better than the alternative below.

Best Wishes

Phillip

>>> Alternatively we could unroll the loop to provide a very long expression
>>> that tests all 256 characters and EOF and hand that to TEST, but that
>>> seems awkward and hard to read.
> 
> ... which would yield unsightly test macros and huge test binaries.  But
> it would certainly be possible, and keep the definitions of the actual
> tests clean.
> 
> René
> 

