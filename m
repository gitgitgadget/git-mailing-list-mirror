Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E511474A6
	for <git@vger.kernel.org>; Fri,  5 Jul 2024 09:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720172554; cv=none; b=YAzo0NhH64tloEFknABY2ytPD7AM/+P0ADMBbJxKrfjtFhZk3XQmGynWJFPBU4Vw13xZKnPRNH4xy+kvxriHRQzZMQvVTA+PA/ViTDE6Rzgu4MXNFqyoNsvoJFaGCF22xxf8L0GtS2gKp6F1JykfeEsQz49qKoRXQF/WVxQCBBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720172554; c=relaxed/simple;
	bh=frzlMofV/lUvxPqEZjRkqlAOMrs9fU775dwZDNHjs9s=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=T4NWLeu0efqMQbX+kL1GAaQzX5XVgEDdrlNw7SURYMKmV4csWkiop4AahX2DOYtLEnGTtIhCGlCkfHIriyKZgn6rE+74OhbfnFJmvO00iFDm+QuBt6SwhXlC8gVn2vZ7iYaEEpvvRev5Ss+AhgCEpYAoftWaZp59gXv6QsZ83cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JWb4ECgl; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JWb4ECgl"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42562a984d3so9623655e9.3
        for <git@vger.kernel.org>; Fri, 05 Jul 2024 02:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720172551; x=1720777351; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ARsazbjpQxbCmQJ5tl6Ref1wBUd+UJ2QImqKHfwKH64=;
        b=JWb4ECglMadf0axrCNUoNkpx7iGvRwOQj7L/l/M95mtjD4DG59ix0z5kPX6jspvDJw
         HizvjX3NOl926LSgYAxflKi8K46Cic9Sqy/KT4sOLl8VPBB5fbpJG/RLP96Y0uNfJvWk
         ii7jZrkf3ahIsa5ENg7mvGcxKkpOt/3YQ2ywDAGwyplZAjX7AkFZJIw3LWSeh6yoiSHV
         /pjw1AzYB7mOalwc/JUJI5HZDAzMxI1ffl7TpWB/Dj/cE+CgC3y71gZeo+IEV9iYejMN
         459wvqJOqcdV13AVyBuY8ZIolyursSX4Vt0bs+RSet/KgpYhQxAzWGbOU8wXpNxiPhuT
         Gifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720172551; x=1720777351;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ARsazbjpQxbCmQJ5tl6Ref1wBUd+UJ2QImqKHfwKH64=;
        b=I4XoCHUIPWwmJ1qQ5csrS+QYVbLvYe1lvkGQrbxdpgXniW8/NEO8QPBre5+CgHtHH5
         tUNXyymMsVntpuURgxfkLtdctb+T/sBc4VYYi4HXKxfLROFjdGC0TWjwcXP/kF/NRaH3
         4Q4KrLsSWw2NtCChCOy1qBMiOHoMCL4DIXziPpGRMIcEHZGABfWVlW76Cnyq+NdrRm/n
         YqKtdpyueSq9xdCQ+Hb2vEXsmJLXyoBpANyITecYAy4f6aZHLqVk4HQf/9DxA0COKOpz
         nXZW5+wHV5pfBb9e0ZpsujSsTATDOsMvMXx7kSWQXXdOFVCWjd2NwLbqu03yFLszG7O0
         xp0A==
X-Forwarded-Encrypted: i=1; AJvYcCUqrXBXpa8CvBrH04cJECNWvTiTD1dsE9mZsVf+Iua4ry5VfxPZrVZAVZVHr3DVxEZ7Y2iwJEN7lIy7tbyuVCVXxiZt
X-Gm-Message-State: AOJu0YzLG6VO/1ILOolE6c6GimVpzvHsUjuZoVMy1eHu4sWE5HQAZylH
	mrnIgLv4BnG7u+ml956V+GNbHw8WKmDsOB/hy8TR4DVFcj0CvDIdsSkjPw==
X-Google-Smtp-Source: AGHT+IGwox9746s3qurEr0/q/X2DsFN/5OWXbcoUDl023TPxzql70NXq6CDA3e23U6PhdLJZyisDXA==
X-Received: by 2002:a05:600c:5127:b0:424:7dae:7d79 with SMTP id 5b1f17b1804b1-4264a3cb48dmr25739245e9.7.1720172550791;
        Fri, 05 Jul 2024 02:42:30 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:61c:a601:7f88:feb2:513a:4c20? ([2a0a:ef40:61c:a601:7f88:feb2:513a:4c20])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a2b4976sm53838565e9.48.2024.07.05.02.42.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jul 2024 02:42:30 -0700 (PDT)
Message-ID: <8802b3ab-9986-47bd-be80-51ac599b2892@gmail.com>
Date: Fri, 5 Jul 2024 10:42:29 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Subject: Re: [PATCH 2/6] unit-tests: add TEST_RUN
Reply-To: phillip.wood@dunelm.org.uk
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, phillip.wood@dunelm.org.uk,
 Git List <git@vger.kernel.org>
Cc: Josh Steadmon <steadmon@google.com>
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
 <8175f239-8d4e-49f7-ae0d-dba7df8c365d@web.de>
 <51ebc0fd-ddae-4bdb-a5d6-c92ce8b1f3e6@gmail.com>
 <97390954-49bc-48c4-bab1-95be10717aca@web.de>
Content-Language: en-US
In-Reply-To: <97390954-49bc-48c4-bab1-95be10717aca@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi René

On 02/07/2024 21:55, René Scharfe wrote:
> Am 02.07.24 um 17:13 schrieb phillip.wood123@gmail.com:
>> On 29/06/2024 16:43, René Scharfe wrote:
>>> The macro TEST only allows defining a test that consists of a
>>> single expression.  Add the new macro, TEST_RUN, which provides a
>>> way to define unit tests that are made up of one or more
>>> statements.  A test started with it implicitly ends when the next
>>> test is started or test_done() is called.
>>>
>>> TEST_RUN allows defining self-contained tests en bloc, a bit like
>>> test_expect_success does for regular tests.  Unlike TEST it does
>>> not require defining wrapper functions for test statements.
>>
>> There are pros and cons to not requiring one function per test. It
>> can be a pain to have to write separate functions but it keeps each
>> test self contained which hopefully makes it harder to have
>> accidental dependencies between tests. Having separate functions for
>> each test makes it easy to initialize and free resources for every
>> test by writing a setup() function that initializes the resources,
>> calls the test function and then frees the resources.
> 
> Right.  We should use TEST and TEST_RUN when appropriate.
> 
>> The changes in patch 6 to use TEST_RUN() mean that each test now has
>> more boilerplate to initialize and free the strbuf. > This makes them more similar to strbuf usage in the wild.  Using
> the API idiomatically just makes more sense to me.

I see what you mean. I think it only looks idiomatic if you're already 
familiar with the api though as the test bodies call wrappers rather 
than using the strbuf api directly. I think that reduces its value as an 
example of idomatic usage for someone who is not familiar with the 
strbuf api.

>  Not hiding
> initialization and release makes the tests visibly independent.
> This is not enforced by TEST_RUN, but made possible by it.
> 
>> Having each test in its own function also makes main() shorter and
>> which means can quickly get an overview of all the test cases from
>> it.
> 
> That's true, now you need to grep for TEST_RUN to get such an
> overview.
> 
> On the other hand I find the start of the description in TEST
> invocations somewhat hard to locate, as they are not vertically
> aligned due to the preceding variable-length function name.  Just
> saying..

Yes I really wanted the first argument of TEST to be the description but 
that isn't easy to do while supporting printf style format strings.

>>> +int test__run(const char *location, const char *format, ...)
>>> +{
>>> +    va_list ap;
>>> +    char *desc;
>>> +
>>> +    test__run_maybe_end();
>>> +
>>> +    va_start(ap, format);
>>> +    desc = xstrvfmt(format, ap);
>>
>> This uses an strbuf under the hood. So far we've avoided doing that
>> as we want to be able to test the strbuf implementation with this
>> test framework. We don't need to support arbitrary length strings
>> here so we could use a fixed array and xsnprinf() instead.
> 
> Fair point.  xsnprinf() might be a bit too strict, as it doesn't
> handle short buffers gracefully.  Perhaps that's OK; a developer
> getting hit by that could simply increase the buffer size.

I think so.

> We could also let xstrvfmt() call vsnprintf(3) directly.  The code
> duplication would be a bit grating, but perhaps there's some good
> base function hidden in there somewhere.

Oh, interesting - maybe something like

char* xstrvfmt(const char *fmt, ...)
{
	va_list ap, aq;

	va_start(ap, fmt);
	va_copy(aq, ap);
	len = vnsprintf(NULL, 0, fmt, ap);
	if (len < 0)
		BUG(...)
	buf = xmalloc(len + 1);
	if (vnsprintf(buf, len + 1, fmt, aq) != len)
		BUG(...)
	va_end(aq);
	va_end(ap);

	return buf;
}

>> Looking ahead the plan seems to be to change most instances of TEST()
>> to TEST_RUN(). If we are going to go that way perhaps we should steal
>> TEST() for this macro and rename the existing TEST() macro.
> 
> Not my plan, at least -- I'm content with just having the *ability*
> to keep all parts of a test together.

That sounds sensible to me

> +	if (TEST_RUN("static initialization works")) {
> +		struct strbuf buf = STRBUF_INIT;
> +		if (!check_uint(buf.len, ==, 0) ||
> +		    !check_uint(buf.alloc, ==, 0) ||
> +		    !check_char(buf.buf[0], ==, '\0'))
> +			test_skip_all("STRBUF_INIT is broken");
> +	}

that's a nice use of test_skip_all()

>> I'm not very enthusiastic about requiring the test author to wrap
>> TEST_RUN() in an if() statement rather than just doing that for them.
>> It makes it explicit but from the test author's point of view it just
>> feels like pointless boilerplate.
> 
> Hmm.  We can add more magic, but I suspect that it might confuse
> developers and editors.

To me its confusing to have to wrap TEST_RUN() in an if() statement 
until one realizes that the test might be skipped. If we document that 
the test body should be enclosed in braces I don't think it should 
confuse developers or editors and will keep the tests a bit cleaner.

Best Wishes

Phillip
