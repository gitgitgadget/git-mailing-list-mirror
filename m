Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B491A5C8B
	for <git@vger.kernel.org>; Sat,  9 Mar 2024 11:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709983734; cv=none; b=mfd0vN9SlDiXyqO9KclqY3hE8UWc9opTp9Hj07Ies8sTo7Unx1caRwKIlk27/wZ+gmlgQOVJy4pFpZGs7Z/mO+vUfO0c7Gc9r7Yee2v53kyw72QI06rCA8zmcRvvbtpSwoDAylDsm69ZxLKLZl07F8TlcLqtwUKJUCPTHTjMPAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709983734; c=relaxed/simple;
	bh=zCs7Q5PuDItY4ld3WnwtMhunxk32JQ/y+5zGcGVisZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XEhwcEV2akcadc7GHhf0hohofTMwQbU3pxMcfRFsTB0DPbDLyQtzr366nM76EJ0wFY0l3t0TyedrGSd8IDHq3oi6Wr5sLum1VMtmJJO2B6h0KZNVTaVbwT4D0qYP+zmHF9ZpSDE67hwut6D+Qv9xg/m4vVg/tKonTbcmQX8G/sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ln3RcF3f; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ln3RcF3f"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4131804e695so8282915e9.0
        for <git@vger.kernel.org>; Sat, 09 Mar 2024 03:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709983731; x=1710588531; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=L0Uj9WfnbknCcOQItfOYHMOZL0htpIkjDKdS3X56D+0=;
        b=ln3RcF3fs8wit3IY90aIi6Ku6s0nYuruZjASTT4RLsFdJiNyn+bvxzPAXjf1deEO1Q
         WlmsmkZwjdRGBGQd0IDTWAoZy640ShRI3UkTW57sK2H1478c14z+pvAIoChKuh3D1J0a
         k+O4+4qsVEjVzvf4hF3y2dbCQg53ZyeqBxpJ42kZJWyWtqJPr8K6TNtW3gKR0iBJYtDj
         lhNJmuwVD5cukZOMnMWJ4uE1r2/i+jZQ2bLqK4UioaXnSUynrD0enVZe8gX39w+ZNnSr
         MVQNSgr7KGBwOUpWc8vn/+z441yJmo1FBH+LcanJOyts7ljoKuGK6i/XzVpOJtnZWWpb
         qkOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709983731; x=1710588531;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L0Uj9WfnbknCcOQItfOYHMOZL0htpIkjDKdS3X56D+0=;
        b=AopKzl2Qxi70Np2OegqYcULqd7uFWKNEAuoDgwaxBBR/L6szZUaDk94r7BPuo+y78W
         jgOLXG7U+O743CNYNJEtlStJFxZ4lM5qn1cJjfpfbSMuc8Q+PprZuaG2ETI60PdZWCjs
         NS+esq04TAOJr7L7UG3+Bn8aDvtesenbKegAMfCQ+OIniQebRs9qcsNkiVF7G9op3wTD
         90jnSoF2sGxjSYVgPTRfCjBkZ8vCTZHIT8j8tvkJdqzWNkp4oZzGgmWi/QRXu9bkGOL+
         exqGmqOzYfPDk4DYnFl53xEffUvn2SPU6sbwcGHeqjVLWO4Q1ZN8YFKWTpMYfRHEeTQS
         wfdg==
X-Forwarded-Encrypted: i=1; AJvYcCWp/hciFmHyxpslTUoH+TCavJft6oZlNDZh8pMyoUfxnZlzh81TblB2RTG80OiU6n+WDThc87aOaSQulpSjWX9Oi3RU
X-Gm-Message-State: AOJu0YxqPpDidd3BG4csjSlgeR/SFo8slRcOpJz7hGMD8yXLJKTIYJLc
	tdrEABXYDng8fI/M3YpmmjeW7iOIcWpPLHQTWXDfg1aSn/jctCOI
X-Google-Smtp-Source: AGHT+IFgaafUB3MQFQ9ozIIjwx8P3P/kQAkpOJ6IzHqsUem99kfRHzzrcvYtk3p8wy1TWeraNgeuZw==
X-Received: by 2002:a05:600c:4f93:b0:412:e992:6c32 with SMTP id n19-20020a05600c4f9300b00412e9926c32mr1497401wmq.11.1709983730700;
        Sat, 09 Mar 2024 03:28:50 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:6a5:fd01:d2c6:37ff:fef6:7b1? ([2a0a:ef40:6a5:fd01:d2c6:37ff:fef6:7b1])
        by smtp.googlemail.com with ESMTPSA id z11-20020a05600c0a0b00b00412f428aedasm8804855wmp.46.2024.03.09.03.28.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Mar 2024 03:28:50 -0800 (PST)
Message-ID: <4f41f509-1d44-4476-92b0-9bb643f64576@gmail.com>
Date: Sat, 9 Mar 2024 11:28:49 +0000
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

Hi René

On 06/03/2024 18:16, René Scharfe wrote:
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
> an unusual requirement.  I don't see how the added friction would make
> tests any better.  It just requires more boilerplate code and annoying
> repetition.  What kind of changes do you envision that would be
> hindered by allowing statements?

On reflection I don't think I'm objecting to allowing statements, only 
the use of the private functions to do so. If we tweak test__run_begin() 
and test__run_end() so that the description is passed to 
test__run_begin() and we invert the return value of that function to 
match what test__run_end() is expecting then we can have

#define TEST_BEGIN(...)						\
	do {							\
		int run__ = test__run_begin(__VA_ARGS__);	\
		if (run__)

#define TEST_END				\
		test_run_end(run__);		\
	} while (0)

Which allow test authors to write

	TEST_BEGIN("my test") {
		/* test body here */
	} TEST_END;

The macros insulate the test code from having to worry about 
test_skip_all() and the "do { ... } while (0)" means that the compiler 
will complain if the author forgets TEST_END. I'm slightly on the fence 
about including the braces in the macros instead as that would make them 
harder to misuse but it would be less obvious that the test body is run 
in its own block. The compiler will allow the test author to 
accidentally nest two calls to TEST_BEGIN() but there is an assertion in 
test__run_begin() which will catch that at run time.

The slight downside compared to TEST() is that it is harder to return 
early if a check fails - we'd need something like

	TEST_BEGIN("my test") {
		if (!check(0))
			goto fail
		/* more checks */
	 fail:
		;
	} TEST_END;

Also unlike TEST(), TEST_END does not indicate to the caller whether the 
test failed or not but I'm not sure that matters in practice.

What do you think?

Best Wishes

Phillip


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
> 
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

