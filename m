Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D096190071
	for <git@vger.kernel.org>; Wed, 10 Jul 2024 13:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720619374; cv=none; b=sg7DfzmqEi0lbXIpijYANXc7wDmjatUpV0cYSbGffQ+bAHKb6pM7Jc4sgKcSeR6ntWDAYn+QzyTb1roxgKl675vtTLzR8cWEvZNSKUNZfLhe3cbnqE2UN5oQ/AyIS43uzuC+SxJgEyWrcNiG2xL+LL049/iqhNvbWewKuUdstYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720619374; c=relaxed/simple;
	bh=p449kbBiOsspVMmvuMwRo264HUBeANWTB5bCl6pwZ9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VIEEg9zI2yu8uIBzC+a+IbREp3/jOz5LIqvsWCWZOc1rZW5Kf9KPUGnRBs3Ous/olsecCv3u7JP9oR96ZboO8Dm7xaH1N+yfCxN7gmTgrHvyB4W50acO61ybpH5+ahp6cpZkUU3FYsFDZldb/TvYKVU4QUAJKURUVvVHMrWYipg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grsecurity.net; spf=pass smtp.mailfrom=opensrcsec.com; dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b=Q1Ps6yci; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grsecurity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensrcsec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b="Q1Ps6yci"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-58b0dddab8cso9531014a12.0
        for <git@vger.kernel.org>; Wed, 10 Jul 2024 06:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1720619370; x=1721224170; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MEX3dMu7fyPsqkh6W7zzNgdkzVzltzEhYgR6DriAA68=;
        b=Q1Ps6yci1F+pTA1avg+/PZcqRkGBbXSiAQp/np2HnDWHX3GO4u1hQUoBES+I6VQ84u
         vabM/RaZDzxWrR4QI7xwm84t01zIBSmvtyFtawhwT1cQRXakExhwXZvLGL0ncVsI6ctC
         73+GssGWnOxx3hdhvEqFwJe1SnX8aF/Q3ds34hofCiP3o/Gf1474yzm+C/Q2BW0/ccaF
         ikoHo7ujL0ibatCJg/jcPF07YlaAmiA+V3sSJsi8NG7p31XJ+B/L/Wi6SZGIkSTw643F
         ggHq10hpllICi3858aU/P/3rqgNjqmCVSnY4CfNBarUTEV/jn3RkfDJAULdKXqSTTWGw
         /gdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720619370; x=1721224170;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MEX3dMu7fyPsqkh6W7zzNgdkzVzltzEhYgR6DriAA68=;
        b=YvSUnwpNba4JTGKkjvIAP1NsaRYJ2bpyMjgr3pL35GSb6aoUCktTcjSAWQAQOoeNFA
         Iqi1riCwKJqeetEIRWNOUqijt8hTEj2jaKY6QQkbbexn4iJ5Zncah1jqGam3SI3qQThe
         XsfdWY+zbq4Tnng1Bg0GQGOdGOk4ki9POL2eM0QWEtUfmVpYwFok4BHlvo8vasFeQY1V
         2j0CwJjzY7EzRxcrhEol8/KqFGEm4gE8bZrdq35hRx91A3uq/DvwX8krFFyt8bknD/bB
         aJQpM6xQZkYCZsp722KNTPXHHvVN6ihTNMO3ZLYgo0lgPziTQqQJV4wb+IobuPAC9bb5
         xNog==
X-Gm-Message-State: AOJu0Yzfgjd/9+x0r40XllVyQEU5XxY4FqFraStIxaeLJi6PtvR6IF75
	AJJ/cNmi5EyK3ivTOw5NkiJC49YzjK9kwkLm6G7RljBFDkjR6FNLpkV1h4VukaY=
X-Google-Smtp-Source: AGHT+IGPH1Dle0rD9K7Nhvb/JqVTx+OeGe+wooyWdqGJ2JGtD6s5h/4+IssQieXKkpLuefTlEnF45g==
X-Received: by 2002:aa7:da8b:0:b0:57c:5fcf:b570 with SMTP id 4fb4d7f45d1cf-594bc7ca0fbmr3498464a12.32.1720619370118;
        Wed, 10 Jul 2024 06:49:30 -0700 (PDT)
Received: from ?IPV6:2003:f6:af47:d800:31cd:b43d:814:396d? (p200300f6af47d80031cdb43d0814396d.dip0.t-ipconnect.de. [2003:f6:af47:d800:31cd:b43d:814:396d])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-594bc7c8a39sm2263922a12.55.2024.07.10.06.49.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 06:49:29 -0700 (PDT)
Message-ID: <4e2de5cc-e438-4975-9630-a1b40b66ae1a@grsecurity.net>
Date: Wed, 10 Jul 2024 15:49:28 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] grep: default to posix digits with -P
To: Carlo Arenas <carenas@gmail.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?=
 <l.s.r@web.de>
Cc: git@vger.kernel.org
References: <20240101150336.89098-1-carenas@gmail.com>
 <55309061-5996-4f70-8e6b-b341fc632ddf@web.de>
 <CAPUEspgbVx6wbp4UNjjxFO8iNJw3i2FnJxNwn4pk5EbaAP-7gQ@mail.gmail.com>
Content-Language: en-US, de-DE
From: Mathias Krause <minipli@grsecurity.net>
Autocrypt: addr=minipli@grsecurity.net; keydata=
 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
 RzDVkdgPJkL/NFTKZHo5foFXNi89kA==
In-Reply-To: <CAPUEspgbVx6wbp4UNjjxFO8iNJw3i2FnJxNwn4pk5EbaAP-7gQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 02.01.24 20:02, Carlo Arenas wrote:
> On Mon, Jan 1, 2024 at 9:18 AM René Scharfe <l.s.r@web.de> wrote:
>> Am 01.01.24 um 16:03 schrieb Carlo Marcelo Arenas Belón:
>>> @@ -321,17 +327,22 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
>>>               }
>>>               options |= PCRE2_CASELESS;
>>>       }
>>> -     if (!opt->ignore_locale && is_utf8_locale() && !literal)
>>> -             options |= (PCRE2_UTF | PCRE2_UCP | PCRE2_MATCH_INVALID_UTF);
>>> +     if (!opt->ignore_locale && is_utf8_locale() && !literal) {
>>> +             options |= (PCRE2_UTF | PCRE2_MATCH_INVALID_UTF);
>>>
>>> -#ifndef GIT_PCRE2_VERSION_10_35_OR_HIGHER
>>> -     /*
>>> -      * Work around a JIT bug related to invalid Unicode character handling
>>> -      * fixed in 10.35:
>>> -      * https://github.com/PCRE2Project/pcre2/commit/c21bd977547d
>>> -      */
>>> -     options &= ~PCRE2_UCP;
>>> +#ifdef GIT_PCRE2_VERSION_10_35_OR_HIGHER
>>> +             /*
>>> +              * Work around a JIT bug related to invalid Unicode character handling
>>> +              * fixed in 10.35:
>>> +              * https://github.com/PCRE2Project/pcre2/commit/c21bd977547d
>>> +              */
>>> +             options |= PCRE2_UCP;
>>> +#ifdef GIT_PCRE2_VERSION_10_43_OR_HIGHER
>>> +             if (!opt->perl_digit)
>>> +                     xoptions |= (PCRE2_EXTRA_ASCII_BSD | PCRE2_EXTRA_ASCII_DIGIT);
>>>  #endif
>>> +#endif
>>
>> Why do we need that extra level of indentation?
> 
> I was just trying to simplify the code by including all the logic in
> one single set.
> 
> The original lack of indentation that was introduced by later fixes to
> the code was IMHO also misguided since the obvious "objective" as set
> in the original code that added PCRE2_UCP was that it should be used
> whenever UTF was also in use as shown by
> acabd2048ee0ee53728100408970ab45a6dab65e.
> 
> Of course, we soon found out that the original implementation of
> PCRE2_MATCH_INVALID_UTF that came with PCRE2 10.34 was buggy and so an
> exception was introduced in 14b9a044798ebb3858a1f1a1377309a3d6054ac8.

My early fix attempt[1] also had it indented but Junio argued against
it[2]. I see no reason why we should change that now?

[1]
https://lore.kernel.org/git/20230323144000.21146-1-minipli@grsecurity.net/
[2] https://lore.kernel.org/git/xmqq355va1a2.fsf@gitster.g/

> 
> Note that the problematic code is only relevant when JIT is also
> enabled, but JIT is almost always enabled.

Right. But it doesn't hurt to mask a bit that isn't set, the compiler
will figure, I guess.

> 
>> The old code turned PCRE2_UCP on by default and turned it off for older
>> versions. The new code enables PCRE2_UCP only for newer versions.  The
>> result should be the same, no?  So why change that part at all?
> 
> Because it gets us a little closer to the real reason why we need to
> disable UCP for anything older than 10.35, and that is that there is a
> bug there that is ONLY relevant if we are using JIT.
> 
> My hope though is that with the release of 10.43 (currently in RC1),
> 10.34 will become irrelevant soon enough and this whole code could be
> cleaned up further.
> 
>> But the comment is now off, isn't it?  The workaround was turning
>> PCRE2_UCP off for older versions (because those were broken), not
>> turning it on for newer versions (because it would be required by some
>> unfixed regression).
> 
> The comment was never correct, because it was turning it off, because
> the combination of JIT + MATCH_INVALID_UTF (which was released in
> 10.34) + UCP is broken.

And what makes the comment wrong? It's mentioning "JIT", "invalid
Unicode character handling", "bug" and even the URL to the PCRE2 commit
fixing the bug.

Moreover is your proposed change making the comment look wrong as it's
negating the preprocessor test and sets the PCRE2_UCP bit instead of
masking it, suggesting *this* makes it work around the bug, while it's
actually the opposite.

So, yes, IMHO we should leave that part as-is.

> [snip]

Cheers,
Mathias
