Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03964381C2
	for <git@vger.kernel.org>; Wed, 28 Aug 2024 15:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724858164; cv=none; b=VDsoRFPF7KWUiy1qri9nOtKx7xn6gtN5Hl+aBVu9bCyvNzRjLjhQphTHqKPETeuEpHJQpLIdE/CkPk60thVFscL527WqHJOWcGSpKQ5gfo5fNvUlg+xQy+bftJrVlLvR4Lel7pVG1bN1thaza3cpiFVJigx7cv3jUGxA6NwZZOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724858164; c=relaxed/simple;
	bh=cCsVKCh9/RKHN8hgAbuSZnEYu4ujqqvBhJvCgo7yLQQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=qIZW/flRooqqM8bXmejL35lVnVaXy07AqKKTAQKEG8N173kHPvsaXL3XTIYpmQW0d5FLvBrArS3Cb5pNRweq0lv3GrCwmal8q/yCQIz/mUOsKCV+iT+U2SHuBmYYLqzuKNQfKAX/NfS2z1KItK9M+6mJSo+SUVLUbn2Nz99xDEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fccj4mZ8; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fccj4mZ8"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-533463f6b16so8073014e87.1
        for <git@vger.kernel.org>; Wed, 28 Aug 2024 08:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724858161; x=1725462961; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dEJbQy2M6tPi/Q5a258vkNhrbKxml6a3R8J+hd/tQaE=;
        b=Fccj4mZ8ruqSwzVkAuJgibnK+lPo4i73IdVRs1X9L3t2x1Sz05mHgchbSEVlOaHZKn
         E8a9yuO8C2mApWCKI0GYRgyHT1XtKqwzgjauVpC4T4QUEPLt6/BaEuvKmmtdoFuq25Cq
         9P1ZylU4AcR1lHEWiCK176FC6nF3zl6sL6X80S+fthiATV1FMN3I0kJy1C6TqihS5lud
         wM/IXt0mABQ3VaLSyaV4QOvjMsOYBuRMc4SxyAbH48HMFi7jgtb1XaeciA0DaHIMZAyj
         5Samaw0c5dQxWQn4DsQlCBUHewpJbtJfN0Tq9jx/xNoyTWkttd5MgiDho3beWgWs0Bbe
         Byow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724858161; x=1725462961;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dEJbQy2M6tPi/Q5a258vkNhrbKxml6a3R8J+hd/tQaE=;
        b=GJfKhOHGByyrEZpPce768Fe+akq5Tz1PN0ReOwpHJEcxEblx39tgglU357zyNdtpSk
         bQve6uL3QB9Ibakl4n9ldUlE6u/u/d+FmAsk11hgywy/LF/460iyezJ+PRdMee78z2XA
         7BoNY/0CVCT6ipwFOUulogT2frdz74loIqWM2I0b2Gc9R09xYQcceJlxAAhfF1/KmzyZ
         qxEJzmDxSuPWg3ml7TMcqDY7xFJDHoNtClJD3BTRgWYpuNGvmz7cVXPrpNXdzPSX0nC4
         emV6n6owVau+Ncpdr9YPjm1s7Wf8OfblmXk19Evcj5/5pXcaWQL67T4wY+t+dyW3bcR1
         +ASw==
X-Gm-Message-State: AOJu0YxQcsbrAuo8Bu08ZOdgdUgWLxwHbVuiiBN4yCLM/zR3LQZ/6CGj
	Pta4J/wA7vPRsxm3oEJUScktuRah01+Sg5iOWHPX3bsAfwMe4rSI
X-Google-Smtp-Source: AGHT+IHNrW4cKcd02V8u7mOCdy/736cwAFItnbSKds72PzaJbEQlnxrmYvb1BzaSsdxbTpFtDXUdSg==
X-Received: by 2002:a05:6512:33d0:b0:52e:9b4f:dd8c with SMTP id 2adb3069b0e04-53438785cd9mr12521425e87.35.1724858160287;
        Wed, 28 Aug 2024 08:16:00 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6d3:8001:7151:e3a9:f71b:e7d9? ([2a0a:ef40:6d3:8001:7151:e3a9:f71b:e7d9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e594d9d5sm256214566b.209.2024.08.28.08.15.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2024 08:15:59 -0700 (PDT)
Message-ID: <f22dadee-5431-4184-9f92-9306e9241021@gmail.com>
Date: Wed, 28 Aug 2024 16:15:59 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 0/9] Introduce clar testing framework
To: Patrick Steinhardt <ps@pks.im>, phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 Junio C Hamano <gitster@pobox.com>, Kyle Lippincott <spectral@google.com>,
 Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
 Edward Thomson <ethomson@edwardthomson.com>
References: <cover.1722415748.git.ps@pks.im> <cover.1723791831.git.ps@pks.im>
 <b87700d2-0c9a-4d0c-9ee4-e6a91278d596@gmail.com> <ZsSTOczuGhT5zwoV@tanuki>
Content-Language: en-US
In-Reply-To: <ZsSTOczuGhT5zwoV@tanuki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 20/08/2024 13:59, Patrick Steinhardt wrote:
> On Fri, Aug 16, 2024 at 02:37:34PM +0100, Phillip Wood wrote:
>> Hi Patrick
>>
>> On 16/08/2024 08:04, Patrick Steinhardt wrote:
>>
>>   - As I think you've pointed out elsewhere there are no equivalents
>>     for check_int(a, <|<=|>|>=, b) so we're forced to use cl_assert()
>>     and forego the better diagnostic messages that come from a
>>     dedicated comparison macro. We should fix this as a priority.
> 
> Agreed, this one also feels rather limiting to me. Are you okay with me
> doing this as a follow-up in case this series lands?

Yes

>>   - cl_assert_equal_i() casts its arguments to int whereas check_int()
>>     and check_uint() are careful to avoid truncation and keep the
>>     original signedness (if that's a word). I think that's unlikely to
>>     be a problem with our current test but could trip us up in the
>>     future.
> 
> Yeah. If it ever becomes a problem we can likely just introduce
> something like `cl_assert_equal_u()` to achieve the same for unsigned.
> Both should probably end up casting to `intmax_t` and `uintmax_t`,
> respectively.

Supporting wider arguments would make sense. At the moment 
clar__assert_equal() does not support PRIiMAX, only the non-standard PRIuZ.

>>   - cl_assert_equal_s() prints each argument as-is. This means
>>     that it passes NULL arguments through to snprintf() which is
>>     undefined according to the C standard. Compare this to check_str()
>>     that is NULL safe and is careful to escape control characters and
>>     add delimiters to the beginning and end of the string to make it
>>     obvious when a string contains leading or trailing whitespace.
> 
> Good point indeed, and something I'm happy to fix upstream.

That's great

>>   - The cl_assert_equal_?() macros lack type safety for the arguments
>>     being compared as they are wrappers around a variadic function.
>>     That could be fixed by having each macros wrap a dedicated
>>     function that wraps clar__fail().
> 
> Some of them do indeed, others generate issues. I don't think we have to
> have dedicated functions, but could do something about this with
> `__attribute__((format (printf, ...)))`.

I wondered about suggesting '__attribute__((format (printf, ...)))' but 
we'd need to double up the format argument in order to use it which is 
kind of messy. At the moment we pass "%i" with two integers.

>>   - There is no equivalent of test_todo() to mark assertions that are
>>     expected to fail. We're not using that yet in our tests but our
>>     experience with the integration tests suggests that we are likely
>>     to want this in the future.
> 
> Heh, funny that you mention this. I had this discussion some 6 years ago
> I think, where I also mentioned that this should exist as a feature. In
> any case, I agree.

Excellent!

>>   - To me the "sandbox" feature is mis-named as it does not provide any
>>     confinement. It is instead a useful mechanism for running a test in
>>     a temporary directory created from a template.
> 
> I guess we'll either just have to not use it or ignore that it's named a
> bit awkwardly. Changing this in clar probably wouldn't work well because
> other projects may depend on it.

Yes it's probably too late to rename it. I think being able to create a 
test directory from a template directory could be useful, we just need 
to be mindful that the test code is not confined by a sandbox.

>>   - There are no checks for failing memory allocations - the return
>>     value of calloc() and strdup() are used without checking for NULL.
> 
> I'll commit to fixing this upstream if this lands.

Great

>>   - The use of longjmp is a bit of a double edged sword as it makes it
>>     easy to leak resources on test failures.
> 
> I have to say that this is one of the best features of the clar to me.
> The current test framework we use doesn't, which in theory requires you
> to always `return` whenever there was an error. But that results in code
> that is both awful to read and write, so for most of the tests simply
> don't bother at all. And consequently, the tests are quite likely to
> cause segfaults once one of the checks fails because we didn't abort
> running the testcase, but things are broken.

I thought that the tests took care to bail out early where it made 
sense. Sometimes it is useful to continue for example when checking an 
strbuf we might want to check alloc and len before bailing out. We're 
probably not losing much by not doing that though.

> In practice, I'd claim that you don't typically care all that much about
> memory leaks once your basic assertions start to fail.

I tend to agree. I was thinking more about exhausting fds and cleaning 
up files but that's probably not a big issue in practice.

> So, things that need addressing and that I'm happy to do as follow ups:
> 
>    - Introduce functions that compare integers.
> 
>    - Improve type safety of the `cl_assert_equal_?()` macros.
> 
>    - Adapt `cl_assert_equal_s()` to handle NULL pointers.
> 
>    - Introduce checks for failing memory allocations.
> 
> Nice to have would be support for known-failing tests.

This all sounds good to me

Sorry for missing this mail earlier.

Phillip

> Patrick
