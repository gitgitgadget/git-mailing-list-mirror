Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BDF1BBBC8
	for <git@vger.kernel.org>; Fri, 27 Sep 2024 10:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727431862; cv=none; b=t2uzRQEZzUuYpGBWEz2ZTtbwlC3/Dymkr95ctXquulDlPUyhOK2xtPJNt/14lSmWMTSFj6E05J6O4RipAycZBAVfz5fJ5v90YqFy+MmU3J/cI9I7lIsETPP1yd5q5ruE5iGduDDrnXdcx8jS+kpdEyto0UAKjCGwtd2vtgqyEB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727431862; c=relaxed/simple;
	bh=6wvzd2G5sQsMUC9ayOH8YxqB/JSQJfLvOIRsa5jxkjI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V0Q9eTN+KNR8HAY0ZFxmFTUIovnzXQWAszBzIrjitqGqirFROZY6cZsbtuwixSgbayzHYPFKTYWgsKzkQq01KrhgSy8WiNU63sBrG8rE5e3mC+HGTy+Kd3AyL1tvslj3+D9Fqkfk1aYqBfzJmHIyrRSIzRkOWQq8aMDQUhkGBDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JPBW229E; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPBW229E"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f753375394so18803421fa.0
        for <git@vger.kernel.org>; Fri, 27 Sep 2024 03:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727431858; x=1728036658; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=m3LpK+uF+rq5WaNSmnyWKANLZtHQgfyFNiXdBw/7868=;
        b=JPBW229EExXDwr/SbGPWKIAr80Lt8669LEYbRHnD9SiFBlqjvhkukSfyxBlwxA0xMU
         CQwCVWhnemzC8ycb/kqmFDME9en3+7FsUWyZgsQgQv7pUTYkxHk53DKwxh7iiWq9PVuy
         zefWe9AaxSo3ueQFfUwMoRLrXmssrr8z5rLKxkWyz8GW9KsCH7PVDN7xQemn83uwfUOB
         dghAw0LI+1gQVpjdD6NTuQPt6Em+aJMVrNMmhTHtyIyPm+Ftc5COMwDszZbfedMHhfkX
         czc1/0k66uHvegKCbIjYSQ5Tth/77lgiSM+zf6KAnBqLyApoKvPqPqbkT8HeEEzpjwvM
         qJBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727431858; x=1728036658;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m3LpK+uF+rq5WaNSmnyWKANLZtHQgfyFNiXdBw/7868=;
        b=ae0A2tHXq5CsC4qT+b3iStI0OJX+PByKKkhNzCC+CqPZtleIs6OpwaQEeCEnQhVTCA
         a5HYUpPCGfOUn2Dn59unC68zXBwnkkv6YS8x+s5aDTMY8cr1vIdp+YRHJ9eL+WRxU6g2
         x/afoZahYpKf23UIhgqThaOiAeCNSLSMU9G3LCmxqOrZJAAh1d60M2oY1Lj0K/26kBa+
         m+SawzKyvEGM+XdvtUR4xQ+g+NOdIrHgLQYvHLo7DmxghhLWmQ6/y8e0aqUfKfv8frwu
         SVPfod5kFo2Opm+Ap85Gf9fC64c7h1iwqCI0ekXqFzhG7/D3rVuDeU04lmd1Nx652ulm
         pG+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVdy7K6Avt7BevK54901RwYwh2vJrQ7qpm33XdOZtv9n97NV28yHzk9tAXzaf7exCeGDs4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbfUIQcLizf2TJsoyIAw0VJtRjN40HEkqwUrXZCuuroWLlvd5f
	1TzPPdIuaMEqxFamdoFwCZWhjL0vkpweGsux1KgdesPw+FR3Wybq
X-Google-Smtp-Source: AGHT+IEFdGVTjC+oxdsPoYdKOFG7axtbBjWcjDDRnMe0hYH70f+AYBDfcR1Ei6odR67gy0Fy+7YMJg==
X-Received: by 2002:a2e:a54f:0:b0:2f6:5c64:ccc3 with SMTP id 38308e7fff4ca-2f9d3e47e6cmr17114641fa.16.1727431858025;
        Fri, 27 Sep 2024 03:10:58 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:61a:f001:1402:4f50:9447:3e15? ([2a0a:ef40:61a:f001:1402:4f50:9447:3e15])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c88240a1cbsm980384a12.26.2024.09.27.03.10.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2024 03:10:57 -0700 (PDT)
Message-ID: <5c3b5fcd-37d8-4b8a-bc88-f606f02f346b@gmail.com>
Date: Fri, 27 Sep 2024 11:10:54 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: ./configure fails to link test program due to missing
 dependencies
To: Patrick Steinhardt <ps@pks.im>, phillip.wood@dunelm.org.uk
Cc: Eli Schwartz <eschwartz@gentoo.org>, Junio C Hamano <gitster@pobox.com>,
 Henrik Holst <henrik.holst@outlook.com>,
 "git@vger.kernel.org" <git@vger.kernel.org>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Jonathan Nieder <jrnieder@gmail.com>
References: <xmqqldzsrhyp.fsf@gitster.g> <ZufjWR6AJM-DIWPR@pks.im>
 <29c5c9c0-aa61-415a-9cfa-d64a6b946a48@gmail.com> <xmqqy13oa8oe.fsf@gitster.g>
 <ZvKsH1Ct-YwBPA_f@pks.im> <b6b131cb-683c-4140-9769-290b622721e1@gentoo.org>
 <ZvOTL0cG8qRY8OXe@pks.im> <1f002f86-9212-4639-8804-898bc62726e5@gentoo.org>
 <ZvOn_wChzEgXtpMd@pks.im> <3a303c6e-35b0-4428-9d23-799b33194330@gmail.com>
 <ZvVpcY5Jgp7BzuRu@pks.im>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <ZvVpcY5Jgp7BzuRu@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 26/09/2024 15:02, Patrick Steinhardt wrote:
> On Thu, Sep 26, 2024 at 02:55:52PM +0100, Phillip Wood wrote:
>> Hi Patrick
>>
>> On 25/09/2024 07:04, Patrick Steinhardt wrote:
>>> On Wed, Sep 25, 2024 at 02:02:34AM -0400, Eli Schwartz wrote:
>>>
>>>> I'm probably biased, but some of these failure modes are *weird*. And
>>>> they basically never require the CMakeLists.txt to do something
>>>> considered non-idiomatic in order to trigger the issue.
>>>
>>> All of this is very valuable data to make my case for Meson instead of
>>> CMake. Appreciated, thanks!
>>
>> One thing to bear in mind is why our CMakeLists.txt was introduced in the
>> first place [1]. Visual Studio's CMake integration means that so long as
>> git-for-windows is installed building git is simply a case of clicking on a
>> button, there is no need to install extra software or plugins. I'm not sure
>> the same is true for meson and I don't think we want to end up supporting
>> both.
>>
>> Best Wishes
>>
>> Phillip
>>
>> [1] https://lore.kernel.org/git/nycvar.QRO.7.76.6.2004251354390.18039@tvgsbejvaqbjf.bet/
> 
> Fair enough. The final discussion about which build system to pick is of
> course still to be had. Having worked with both CMake and Meson quite a
> bit in the past I'm strongly in favor of Meson myself, and so I will try
> to make a strong case for it. But points like this of course need to be
> considered when we have the discussion.

 From what Eli said, we should have a reasonable story for building with 
meson in Visual Studio

> The nice thing is that we'll then have all serious contenders (that I am
> aware of) wired up, even though the level of support will be different
> across them. But it should allow folks to come to a better understanding
> of what they will be signing up for.

Yes, that will be helpful

> In any case, I'm now in a state where the Meson-based build works and
> tests just fine, except for t0200, which requires a bit more plumbing to
> set up xgettext infra. Once I'm done with that I'll go off and test with
> both macOS and Windows to check how the experience is over there. I hope
> to be done with that somewhen next week, at which point I'll send things
> to the mailing list.

It sounds like you're making good progress, I look forward to seeing the 
patches

Best Wishes

Phillip
