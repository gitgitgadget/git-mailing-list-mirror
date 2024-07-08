Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7210813EFF3
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 15:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720451556; cv=none; b=m0EzSxF/wDWIUT7u3PmgPKYli96wjSE/yIEaaqnnZQScITFuN3tT0vgShHyGD/3LvFheB9HUu/OMp8zjyaH7XZfx/1Q9sWetishIbp3ZRqcAlwvzLH94bDn0LS0HG4NCuiXnQaG3NNY543XH1i3P9YsxxUm/FQd6+sJLgYI+LGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720451556; c=relaxed/simple;
	bh=t5YtoH+QGE80HzcDEDC3J1t7VvquTw8SA0/WO2UAGaM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Zef9OuG30E4rVOQan9uNQr1ug3YIScAffhxjqlC+9ikfjWUp86RotoGIPbKqkHjjMC0oy1c5V6NNBKbVbr7hwlyfvov9Un2WMarlPddZgLm+09rjvGbY3c7LLfbZN8X5egLTCAuVAihh2z2EZ6GBkPQvMfqgNk8FoKdsWLM2cXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dzewj0IG; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dzewj0IG"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a7523f0870cso496497666b.3
        for <git@vger.kernel.org>; Mon, 08 Jul 2024 08:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720451553; x=1721056353; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2513k1Eyyr/C3aEvWMD9twCBJ5sjrCdXQdaNnW056Eo=;
        b=dzewj0IGlgcqQqYaV2kGJ1jFTKLxocz2xpvxRMeX5c2W9UniT0bB8UeqR4lsbCWU7J
         kLwSo7qduCyNxCV/ucZd6Ot2FuuiMt84nds65+bcp409FAb67SnUBj1S/+uvtD0FXT9l
         IofVpsbiiNnO6rfGl6v5fseci9GW03kIBM7oIV6Jfr+hm3DcTlD9g6kJvKh6+QsDkhtY
         P0/tNp652gOnxlpjLQfEfJxNgGBiDxxsGdU352KGKb975Zea9mFDtZiadPYZBo9Mql6C
         0w9c/ZlNjIGladppQ/X9oTGnu+wf6bnTEJ/uxtIkJLRuwdVPR24M0kEy5m6mQEhTJk32
         v/tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720451553; x=1721056353;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2513k1Eyyr/C3aEvWMD9twCBJ5sjrCdXQdaNnW056Eo=;
        b=dPazUnTZ7yOPvsuPL9N8xqmWz5KaO9/wtqUCBwZq89mh+ckXOSPpaet6p8Wt60Lx0C
         l9Kc5XGv+5HtygbUNhXh9mLqrYHAaahVdEa7dAx1O4RG/T9ZL1Odq5rDx3jahaCDDpLA
         FT984BJoQw7GMdyXkQAxEmG2IpkqKZv+mnDQM2NrQ61C4P7Rv/HHXzYFlQn/ryfdXj+I
         AwSOiVlHSkLQJEpQ6AWm59UTP1jVlmBX9rvCHR1vdU3EcPKQlLYUuwV0MGOeWRPTKayM
         NFFB4rNdpqrYOfd7CUNJuKAyxgC9AkuAxKG3gkYZZlQqUfWFszbz1ljfaeBt0aYcvkyU
         fPkA==
X-Forwarded-Encrypted: i=1; AJvYcCWiRlDJTWAiAhexN5LFkFrSdJNU41ud1oWpUuOBZpp2kkuhxs+wC4KpLiXMTOlmx1JhBEQpUJ0KOsEQwwgPZZ1yRY7r
X-Gm-Message-State: AOJu0Yzy6GlEEaFqnEGU1aOH5fhw1W7X5Lj3V/235MfAtAxlQW5byVSw
	2/wVuxUYI9Fo+v0dUZYkAy04QMlth4YK8HtxJhEkBMWHyVR48DOgoqZV4w==
X-Google-Smtp-Source: AGHT+IFn97FaVNPjjnTmjWb8rJGjvqwLNicruI+BdvSrpLJoPKF4TZ1Ho5uGWPR4C0u6Qz+2yU5bPw==
X-Received: by 2002:a17:906:396:b0:a77:e2e3:3550 with SMTP id a640c23a62f3a-a77e2e34acfmr412714166b.17.1720451552198;
        Mon, 08 Jul 2024 08:12:32 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:61c:a601:7f88:feb2:513a:4c20? ([2a0a:ef40:61c:a601:7f88:feb2:513a:4c20])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a872e47sm2156166b.218.2024.07.08.08.12.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 08:12:31 -0700 (PDT)
Message-ID: <9f63d125-b1ee-4b07-b0c7-a3c98dd31f90@gmail.com>
Date: Mon, 8 Jul 2024 16:12:34 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/6] unit-tests: add TEST_RUN
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, phillip.wood@dunelm.org.uk,
 Git List <git@vger.kernel.org>
Cc: Josh Steadmon <steadmon@google.com>
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
 <8175f239-8d4e-49f7-ae0d-dba7df8c365d@web.de>
 <51ebc0fd-ddae-4bdb-a5d6-c92ce8b1f3e6@gmail.com>
 <97390954-49bc-48c4-bab1-95be10717aca@web.de>
 <8802b3ab-9986-47bd-be80-51ac599b2892@gmail.com>
 <6c83357a-825f-49d9-8cc2-e81415e8010d@web.de>
Content-Language: en-US
In-Reply-To: <6c83357a-825f-49d9-8cc2-e81415e8010d@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi René

On 05/07/2024 19:01, René Scharfe wrote:
> Am 05.07.24 um 11:42 schrieb phillip.wood123@gmail.com:
>> On 02/07/2024 21:55, René Scharfe wrote:
>>> Am 02.07.24 um 17:13 schrieb phillip.wood123@gmail.com:
>>>
>>>> The changes in patch 6 to use TEST_RUN() mean that each test now has
>>>> more boilerplate to initialize and free the strbuf.
>>>
>>> This makes them more similar to strbuf usage in the wild.  Using
>>> the API idiomatically just makes more sense to me.
>>
>> I see what you mean. I think it only looks idiomatic if you're
>> already familiar with the api though as the test bodies call wrappers
>> rather than using the strbuf api directly. I think that reduces its
>> value as an example of idomatic usage for someone who is not familiar
>> with the strbuf api.
> 
> In early versions I used the original names by adding these just before
> main():
> 
>     #define strbuf_addch(x, y)  t_addch(x, y)
>     #define strbuf_addstr(x, y) t_addstr(x, y)
>     #define strbuf_release(x)   t_release(x)
> 
> This allowed normal looking code to be used in tests, with checks
> injected behind the scenes.  Rejected it for v1 because it offers no
> structural improvements, just optics.  It does allow to forget the
> checked versions when writing tests, though, so perhaps it's still
> worth doing.

It also obscures what the test is doing though. It's nice if unit tests 
show how to use an API but I don't think we should let that be our 
overriding concern.

>>> We could also let xstrvfmt() call vsnprintf(3) directly.  The code
>>> duplication would be a bit grating, but perhaps there's some good
>>> base function hidden in there somewhere.
>>
>> Oh, interesting - maybe something like
>>
>> char* xstrvfmt(const char *fmt, ...)
>> {
>>      va_list ap, aq;
>>
>>      va_start(ap, fmt);
>>      va_copy(aq, ap);
>>      len = vnsprintf(NULL, 0, fmt, ap);
>>      if (len < 0)
>>          BUG(...)
>>      buf = xmalloc(len + 1);
>>      if (vnsprintf(buf, len + 1, fmt, aq) != len)
>>          BUG(...)
>>      va_end(aq);
>>      va_end(ap);
>>
>>      return buf;
>> }
> 
> Yes.  Though the current version allocates 65 bytes in the first try
> and only needs to call vnsprintf(3) once if the output fits in.  No
> longer doing that might affect the performance of some callers in a
> noticeable way.

Good point

>>>> I'm not very enthusiastic about requiring the test author to wrap
>>>> TEST_RUN() in an if() statement rather than just doing that for them.
>>>> It makes it explicit but from the test author's point of view it just
>>>> feels like pointless boilerplate.
>>>
>>> Hmm.  We can add more magic, but I suspect that it might confuse
>>> developers and editors.
>>
>> To me its confusing to have to wrap TEST_RUN() in an if() statement
>> until one realizes that the test might be skipped. If we document
>> that the test body should be enclosed in braces I don't think it
>> should confuse developers or editors and will keep the tests a bit
>> cleaner.
> 
> You don't need braces in either case.  I.e. something like
> 
> 	if (TEST_RUN("foo"))
> 		foo();
> 
> works fine.  And
> 
> 	#define IF_TEST_RUN(...) if (TEST_RUN(__VA_ARGS__))
> 	IF_TEST_RUN("foo")
> 		foo();
> 
> works fine as well.

Indeed. The reason I suggested requiring braces was to help editors 
indent the code correctly and because it gives a nice visual cue to see 
what is in each test.

Best Wishes

Phillip

> The confusion that I'm afraid of is that we'd effectively invent a new
> control flow keyword here, which is unusual.  There are precedents,
> though: foreach macros like for_each_string_list_item.  We tell
> clang-format about them using its option ForEachMacros.  I see it also
> has an option IfMacros since version 13 (unused by us so far).  Hmm.
> 
> René
