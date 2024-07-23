Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69468152799
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 13:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721741075; cv=none; b=ITEsP+Bv5XssCeyQcJ7bmmq5NJbKnxC02OdHQ1tq1EKtfqu2S6+Li6Opt/JnrG/yVvtTn89JZh3qlJWAoo9z2KDB1g3nVbYnlnywJky4wWS7P8XPZ01kQTX262Vrjv0LWQ6WoMQjT3rSx2+SQQejQ3KXYfLWgTD1wKf+Fk4yoI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721741075; c=relaxed/simple;
	bh=BgNc8uos9ryn39+eM7xuZtjmqIfAmv4HvBJ19o9Ckp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jn3rlIeA7vmzpBQBUIT5eYTE3+Ymt1uaXvYAlw0VxPFTKjtU6szFdqAL1rsXiTxeAtxF1wQCBOclcJkCuS+H0b5KgpnQPQx7aTeT1idaOqXtKKQhEO7GR2E+B5MHrITm32AxCatqGCIMFbMn3zimvLB09kWVg2dpzG8K/mhy+jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PppvvXCa; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PppvvXCa"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-368557c9e93so2930759f8f.2
        for <git@vger.kernel.org>; Tue, 23 Jul 2024 06:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721741072; x=1722345872; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xLqi7it3EgITQsR3oSlmScHFBBhBFjAc/ZVuRJ4R9So=;
        b=PppvvXCaJJ3MRFcmDjn9nMNKzzfa01wwiqcgK67ARg3TKhIiyJI+DxL/DilCj3+nYA
         ETalARLKL/v3HEt29SnUI6M8br41O/e70RnE2YB86uwu0zet+ly7UO40KORGJ7gkO5Vi
         SpQkGzY5jNuz0gbfHJi6qDtJoASWIbwN4e/C41q/Y6GRGyY0J7Ft2QEN5D6cVzWmLLII
         SsUaLrPpCUyll9Y6TAa4l/5SVvafL/ecoIpFOlCT09iPMInOt0wrmw7Qcb/FiiTyNdgF
         1yBWxqiGXlTTeyjemCPnjg+MVIALjn3BSClDBbYWprmQZ7Pi30Li25hOBqjyvdlt3+uu
         c01g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721741072; x=1722345872;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xLqi7it3EgITQsR3oSlmScHFBBhBFjAc/ZVuRJ4R9So=;
        b=m1exwlPxv175jSW2oeE8id264bwlgdon8Y9dFZq75j2Bee31ZSythCiDd0r5yeBqhH
         d9r2efZ2yyylI1gpX+hA5ozssAb1Akq3kfQyj8nk9vm1uHbeSsa4bOD0OYpMukts/Wnf
         qx+BL1LPjF9FZ+E/3Hr7L7jm9htE9qV7I96EXrrVXLTYbR58YbZt1KG2BWYr9Sr5HSdV
         CPE4xT5WJRbcHNSIiJzXObnVeu/m5Fs/ohVm54VOat0pTTutjwxFMOpHZ8d1oqnW59cB
         7WqwkwGQtR+YS6oLWh6dMJYd5k5qhMeg8ytYz48QP86Dk6XisIAdf7kUcwEtgUEwbrbw
         Z9Zg==
X-Gm-Message-State: AOJu0YxGz0SisPIZMyAYP+vMHEtldW5gdlwcEQHU214h1KJ2s2nsYWwt
	oTuMtV9U4/xo3KGjzZA0ScFkbm89693oRxNMVIi6x2+aSh+Xu8Um
X-Google-Smtp-Source: AGHT+IFjhIXdEo+AQpFUtQEEDJPe5xPqjdckZn//jKsSOgXtsd/tlsp6Ywd6X9jP9/HBL5b59uTFug==
X-Received: by 2002:a5d:58e1:0:b0:368:6ab:ba69 with SMTP id ffacd0b85a97d-369bae13aecmr6551358f8f.28.1721741071518;
        Tue, 23 Jul 2024 06:24:31 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:600:8501:d2c6:37ff:fef6:7b1? ([2a0a:ef40:600:8501:d2c6:37ff:fef6:7b1])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-368787cedabsm11552110f8f.84.2024.07.23.06.24.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 06:24:31 -0700 (PDT)
Message-ID: <b4cbc8ce-5e39-491d-a6c9-627a7fd97c8f@gmail.com>
Date: Tue, 23 Jul 2024 14:24:31 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 2/6] unit-tests: add for_test
To: Kyle Lippincott <spectral@google.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?=
 <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>, Phillip Wood
 <phillip.wood@dunelm.org.uk>, Josh Steadmon <steadmon@google.com>,
 Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
 <da7ed537-1c8e-42ec-aa91-49e1319e8c68@web.de>
 <2dff757d-3c5d-4923-97df-26bcb1c21230@web.de>
 <CAO_smVhoobWpsbYHnHJqTj7TJJ1udo_UaGdbOnUqe5jzL+tyaQ@mail.gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <CAO_smVhoobWpsbYHnHJqTj7TJJ1udo_UaGdbOnUqe5jzL+tyaQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22/07/2024 20:13, Kyle Lippincott wrote:
> On Sat, Jul 20, 2024 at 11:22 PM René Scharfe <l.s.r@web.de> wrote:
>>
>> The macro TEST only allows defining a test that consists of a single
>> expression.  Add a new macro, for_test, which provides a way to define
>> unit tests that are made up of one or more statements.
>>
>> for_test allows defining self-contained tests en bloc, a bit like
>> test_expect_success does for regular tests.  It acts like a for loop
>> that runs at most once; the test body is executed if test_skip_all()
>> had not been called before.
> 
> I can see based on this description where the name came from, but
> without this context, it's not clear when reading a test what it
> actually does. The name comes from an implementation detail, and is
> not describing what it _does_, just _how_ it does it.

That's my feeling too. In fact I think the name "for_test" actually 
works against us by implicitly suggesting that "break" can be used to 
exit the test early when in fact that will not work because we'll skip 
the call to test__run_end()

>> + * Run a test unless test_skip_all() has been called.  Acts like a for
>> + * loop that runs at most once, with the test description between the
>> + * parentheses and the test body as a statement or block after them.
>> + * The description for each test should be unique.  E.g.:
>> + *
>> + *  for_test ("something else %d %d", arg1, arg2) {
>> + *          prepare();
>> + *          test_something_else(arg1, arg2);
>> + *          cleanup();
>> + *  }
>> + */
>> +#define for_test(...)                                                  \
>> +       for (int for_test_running_ = test__run_begin() ?                \
>> +               (test__run_end(0, TEST_LOCATION(), __VA_ARGS__), 0) : 1;\
>> +            for_test_running_;                                         \
>> +            test__run_end(1, TEST_LOCATION(), __VA_ARGS__),            \
>> +               for_test_running_ = 0)
> 
> IMHO: this is borderline "too much magic" for my tastes.

Yes, compared to TEST_RUN() in v1 the magic level has jumped from Muggle 
to Dumbledore. Using a for loop is clever as it ensures test__run_end() 
is called at the end of the test without the need for separate 
TEST_END()[1] macro. The alternative is something like 
test_if_enabled()[2] which was discussed in the last round.

[1] 
https://lore.kernel.org/git/4f41f509-1d44-4476-92b0-9bb643f64576@gmail.com
[2] https://lore.kernel.org/git/xmqqa5iot01s.fsf@gitster.g

> I think
> having multiple test functions is generally easier to understand, and
> the overhead isn't really relevant. It's not _as_ compact in the
> source file, and requires that we have both the TEST statement and the
> function (and forgetting the TEST statement means that we won't invoke
> the function). If that is the main issue we're facing here, I wonder
> if there's some other way of resolving that (such as unused function
> detection via some compiler flags; even if it's not detected on all
> platforms, getting at least one of the CI platforms should be
> sufficient to prevent the issue [but we should target as many as
> possible, so it's caught earlier than "I tried to send it to the
> list"])

I also have a preference for function based tests but I do think 
something like for_test() can be useful in certain situations. For 
example in test-ctype.c where testing the ctype macros leads to a lot of 
repetition or a giant macro with a function based approach. If isalpha() 
and friends were functions instead we could write a single helper 
function which is passed the function under test together with the input 
data and expect result. Because they are macros that approach does not work.

Another example is where we are using a helper function with several 
inputs and we would prefer to write

for_test("test 1") {
	int input[] = ...
	int expect[] = ...

	test_helper(input, expect);

...

for_test("test 10") {
	int input[] = ...
	int expect[] = ...

	test_helper(input, expect);
}

rather then declaring all the input and expect variables up front with

	int input_1 = ...
	int input_2 = ...
	...
	int expect_1 = ...
	int expect_2 = ...

	TEST(test_helper(input_1, expect_1), "test 1");
	...
	TEST(test_helper(input_10, expect_10), "test 10");

> If others agree that this is a good simplification for the people
> reading the test code (and hopefully for the test author), I'm fine
> with this going in (with a different name). I'm not trying to veto the
> concept.

That's my feeling too.

Best Wishes

Phillip

> 
>> +
>>   /*
>>    * Print a test plan, should be called before any tests. If the number
>>    * of tests is not known in advance test_done() will automatically
>> --
>> 2.45.2
>>
> 

