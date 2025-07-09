Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A399B2E3AF9
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 14:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752070393; cv=none; b=iy/ZYsU3XFiPwjnZfhW3G2Lmj8YiOInCX+SZCWmdrPQoXOThzA1SRpKpRTd77TvLumJQiveR7at84CMd65bwKPdux5cXW/MMpjyCQpTj2vmfBrSpu6Kn4n6PoPJ430Nhh8gTYnIV9nsXHSn14IF1UVK2BTK/ka/Hdaqdjqx9feU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752070393; c=relaxed/simple;
	bh=A2DuFf9RWBiwck+3TuX8iQ4uVxAVeWdecm9wT93ibV4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=JgAReKkjxla9rJdgvlXZO3D775M3gcqGpDZxSWqxYSHRNoNSl3FGb6yyzi8nJ7QBAgPW0IfIq4f3uFESPKXkI5aX8WG0pgagQYjaTEcZQNoC8PxMbPK19SYS8psFRf6SsRFaqnoje6ezYQUti04amcuOAF5coUjGumFOXY4EaFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C5hvQpqo; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5hvQpqo"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a50fc7ac4dso2475441f8f.0
        for <git@vger.kernel.org>; Wed, 09 Jul 2025 07:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752070390; x=1752675190; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WDROHkrX48OLCbqbatQ2wEFbTQGzS+P96B7hAAiV4rw=;
        b=C5hvQpqobQPNSzEOqlDNadcJjM/xMXmCs9C4uj4snTmG9XV3ENUxKXrggdrGkQ+PUN
         mnsJU7E7wAbz+lmh8zlr5bmNfoCX+OnyamdHksjHgo3lpk6mrYcCA2bovYH4z2R+PJTJ
         pDXx7vGJluuaVqY2TxyHgslDyxEbSolBwLrCXmxSJMk565/QQzJTS2btjlXRuakw13JG
         g8GL2jliT34QqFsOdsy/IQw1dLhDOy0+MIuQkyMz+6bq8Vc4NHGaqBYNCcdJ5iru4QT8
         4C070MSYHDTTDwrx+V/bw2vdVyN0UIKjbs7SSvO9yg0yxN70/Mynj4H8Z2QS5+X3Uh53
         yPsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752070390; x=1752675190;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WDROHkrX48OLCbqbatQ2wEFbTQGzS+P96B7hAAiV4rw=;
        b=TlLjhllzpzlnirD6dFzKzogyQ4AaR1FSPM49zIk9WQ56qXevG/ZgAuUndbIn5rOpiF
         9z2IJoaKQewJOuIlrJN0XhWfh8ICBcNujoy+lN7wO7vuzSOTjdfkjTofDTo7tP0CQZjU
         kroeyT7RGcrXo77Kp9ju97VZk58KtwiiAmrDcRavx246xDuYJU7SX8A9jWcbRZT2L7Bx
         2FUPPtJernNAk/5GuMxXQxMZa6ck4RossY6+6AWbfT1XIHA1cErkB3ZCE7hCQMinsZqF
         n/iZdUtkWJ7lxTZnzSMLQJ0qWiYiRy3DMDODQiGUNG0PFjUlwM8qdaTcsiCMGIdEZRvV
         HiTw==
X-Forwarded-Encrypted: i=1; AJvYcCVU7KHCj6An4dzp0Dl2NRPV3Qh29uNgBgGd+lNM+sVtHyhOiETDSK59PKtry52xvo1HPvg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0nrAb7d6pcn781QrZGthGhfIPSXxiVhjt+BrfAky5t3R6oL/T
	dB6Yodi4vt0DFm3tWUSYty6/8jB+0GSbvZTXQPU67iE/uR0gulh3SiYn
X-Gm-Gg: ASbGncv2aF1qbSPeOdq842a8XFqAo1ikbImWpnGvD56qr6QHbYEPBwUKfVcbmyEjnwA
	orI6ruASIshoQmqWtWsiMCml/PyUdnt5N8BhcAIqpsfZViU4wQO0rEOdXbYzI7J+T28jnOALBuF
	qwBfgDTd6ZzwccRONjXGz9CEtlNwXjnVCcABvRTTqFcFBzAdXiwxbRfT07EPRA62tPhaCTeLBVz
	WGaxkEUvIgIr1XbLCWmdTrTJeowOPftotEJkgncTARLc1VgkavPhSrZqt3XoIoo0MjYcUeVH0f6
	QDTCZ5p0++2JKw0Hzh/OVdw374dEq4yysgBc8a2hUCrnXObvYSE8RhC1CbksnRmOGW3+B4Dl9LA
	9Bdq3Xo50Vzigi/VS2UOil/K+twRdc4sJFtiZWA==
X-Google-Smtp-Source: AGHT+IF2/0jJDqtkUY3rwBCpBN9ucS92BbMR0OkD2xQZ8+lD2lNchy4/MFjYgiXSQDUQe4CX5tzm+Q==
X-Received: by 2002:a05:6000:24c9:b0:3a4:d53d:be20 with SMTP id ffacd0b85a97d-3b5e44eded7mr2193386f8f.18.1752070389835;
        Wed, 09 Jul 2025 07:13:09 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b4708d0959sm15939302f8f.27.2025.07.09.07.13.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jul 2025 07:13:09 -0700 (PDT)
Message-ID: <0931e1f2-6254-474f-be91-664cec9745f5@gmail.com>
Date: Wed, 9 Jul 2025 15:13:06 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 2/4] compat/mingw: allow sigaction(SIGCHLD)
To: =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
 phillip.wood@dunelm.org.uk
Cc: =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n_via_GitGitGadget?=
 <gitgitgadget@gmail.com>, git@vger.kernel.org,
 Chris Torek <chris.torek@gmail.com>, Junio C Hamano <gitster@pobox.com>
References: <pull.2002.v2.git.git.1750836928.gitgitgadget@gmail.com>
 <pull.2002.v3.git.git.1750927988.gitgitgadget@gmail.com>
 <3f63479119ffe6fdcf694dac3cb47cd7838564b7.1750927989.git.gitgitgadget@gmail.com>
 <49cf7749-fc86-4829-8e94-c1f1e87803aa@gmail.com>
 <qizh636elher65bsdzkiqohzyo23tmon7hxcl4jcuftculbtm6@nupmqjy3igja>
 <a1fb8c27-6ddf-42d5-a062-a9710f6cc1cd@gmail.com>
 <o6cihjnfj4q6uiks3syovjun3fcijvsqto444osw7tgtpkttvt@42r37athz2tw>
 <0dd51eab-8869-46be-beca-238a616dd6f3@gmail.com>
 <p6xegxqqq4wzi6gnokypy3k5auxk3d2wxmj4pj45ugfomace3q@y5q3e2al42oj>
Content-Language: en-US
In-Reply-To: <p6xegxqqq4wzi6gnokypy3k5auxk3d2wxmj4pj45ugfomace3q@y5q3e2al42oj>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 26/06/2025 21:09, Carlo Marcelo Arenas Belón wrote:
> On Thu, Jun 26, 2025 at 04:19:11PM -0800, phillip.wood123@gmail.com wrote:
>> On 26/06/2025 15:58, Carlo Marcelo Arenas Belón wrote:
>>> On Thu, Jun 26, 2025 at 02:56:22PM -0800, Phillip Wood wrote:
>>>> On 26/06/2025 14:15, Carlo Marcelo Arenas Belón wrote:
>>>>> On Thu, Jun 26, 2025 at 01:52:47PM -0800, Phillip Wood wrote:
>>>>>> On 26/06/2025 09:53, Carlo Marcelo Arenas Belón via GitGitGadget wrote:
>>>>>>> From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
>>>>>>>
>>>>>>> A future change will start using sigaction to setup a SIGCHLD signal
>>>>>>> handler.
>>>>>>>
>>>>>>> The current code uses signal() which returns SIG_ERR (but doesn't
>>>>>>> seem to set errno) so instruct sigaction() to do the same.
>>>>>>
>>>>>> Why are we returning -1 below instead of SIG_ERR if we want the behavior to
>>>>>> match?
>>>>>
>>>>> By "match", I mean that in both cases we will get an error return value
>>>>> and errno won't be set to EINVAL (which is what POSIX requires)
>>>>>
>>>>> In our codebase since we ignore the return code anyway, it wouldn't make
>>>>> a difference, either way.
>>>>>
>>>>> signal() returns a pointer, and sigaction() returns and int,
>>>>
>>>> Oh right, I'd forgotten they have different return types. I think we should
>>>> probably be setting errno = EINVAL before returning -1 to match what this
>>>> function does with other signals it does not support - just because our
>>>> current callers ignore the return value doesn't mean that future callers
>>>> will and they might want check errno if they see the function fail.
>>>
>>> I agree, and indeed had to triple check and change my implementation after I
>>> confirmed that signal(SIGCHLD) does not change errno on Windows (not our
>>> version, neither of the windows libc or mingw, even if it is documented[1] to
>>> do so.
>>>
>>> It might be because the signal number itself is bogus (there is none for
>>> SIGCHLD in their headers, and git uses their own numbers in compat), but
>>> either way, I would rather be consistent with signal() at least originally.
>>
>> I'm not sure I understand - don't we want the sigaction() wrapper to behave
>> like sigaction() would?
> 
> for at least the first iteration, I would rather have sigaction() behave
> like signal(), so that the change doesn't introduce any regressions.

What regressions are you worried about? We're talking about changing a 
single call from signal() to sigaction(). I'd have thought we're far 
more likely to introduce regressions if we change the behavior of the 
windows implementation of sigaction() to behave like signal() as that 
introduces more variation between different platforms.

> eventually, sigaction() should behave like any other sigaction(), but to
> do so, I suspect the windows emulation might need to change their SIGCHLD
> to match.
> 
> just confirmed with MSVC that if I use 20 instead of 17, errno gets updated
> just like the documentation says it should.

Oh not so setting errno as you want to do would not actually match 
signal() on Windows in that case?

Thanks

Phillip

> Carlo
> 
> PS. Maybe we should get dscho involved?
>>>
>>> [1] https://learn.microsoft.com/en-us/cpp/c-runtime-library/reference/signal

