Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813EC198A24
	for <git@vger.kernel.org>; Thu, 25 Jul 2024 09:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721900718; cv=none; b=Jp+4WeNwEN+yoX2nORXO5dsMoWuU5TYbAVb0sQ3XZvnRECLn21p4gCXwW7sqZ1DZEkR4rbjkO35EkTyFEX2xCL2Ugmkh7IeGonY5neLWzCu2j8y1U+6De4YIk5hl5XTY8EhUJVL9/+Sckhe8h6VRYXOhZShvuNFUzokeGgwd7UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721900718; c=relaxed/simple;
	bh=WndVy9UsmgsZYMcPEXt6yBThRNqfSre8dvmBJxK589Q=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=IGFxwycPgn0qU2nByafE6MJA61eZBUG43HByjvJe3IL/0SDWLKvdZU/oTBL3epFxh4+ayl31Sozvi6OIpJhMY6yGrc53LROe/mzn2xSjxwmMex7Fb7vv5a9cMCERf6CMXwwatY5ikeKpxdoiWgYQtzExx793K55oIPz7n+zFCk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bBKuS83P; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBKuS83P"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-427ffae0b91so7118705e9.0
        for <git@vger.kernel.org>; Thu, 25 Jul 2024 02:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721900715; x=1722505515; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dSA+A7QyyWPrl0L9lalyYVwS1MJ05l2K3F+d3X4c3pQ=;
        b=bBKuS83PCpEqjBmLzmDJ1GYbqs5jWShJnREO1hgqxhxMDhB/oNc7A9gmD6OU6qjUsw
         kIgU3Ze4+KxAWRvvZX3rz2EacBkanMPIEaDvmuXaim5EmzArgdvodMy1qObkd5SXHmj/
         M8YWMM6imD4a+prsqCjloSzBVFXK6+nnNPHTwLMX0tnNl/KkUgL4iaT1SXTVAyQcybBz
         Gwsjq6gQ467P1KerEeOBA8RaT3/0QQxMnfQ+HNZ2rwouOqzTFIAGG6NLdwX4GItDPqiu
         DHc4m+WVY0RK/+4J8SiFldJYUAGf9MeH1pg4cTeEaRb52LNgkcT6vdZso3IfXdy/iVdB
         RuSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721900715; x=1722505515;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dSA+A7QyyWPrl0L9lalyYVwS1MJ05l2K3F+d3X4c3pQ=;
        b=DvUG8XKgJJw+kGujzyYdRGQqwYsKI97qcV7bCM+bsXp12Y5cuX5qY4VfQxeUcUzPJM
         Ky80rrGaQP+R7cKOSFzZa8aNnFgwyYJuLcsoRSAQ9jEBLViUjbk42qd3RVz4RAgviDTs
         mzhnB0zs5vEUUGXpKwfHQUirDTq3VnzpA+pgYPF/39CtpqVtzFwamHW6yRYWeZtPGR61
         6gnCrdqmCWfbFkVQugv911dvKjVGoc6mRh8kk96kASchyBG20hHkebamp0fs8f4KRDQJ
         SMXAzaOkHeS+LPbaS0EFjjBsUkNiKRbCyD+6uWumw5NqRJAaLgizsbuWRCUFsPlwtRil
         sDTw==
X-Gm-Message-State: AOJu0YwYsLYjXppmmKnfR0QvgNWCJn9j4Y2kevB/MWilDA0sJPwgFMzm
	dY/rF5qCyZKHtwDBg0e15YeJ6Yex+ODK5tWooQXAhw0Po9RUFZ3u
X-Google-Smtp-Source: AGHT+IGjMYCfx6y4DA0pc9APw124bpRQc5Wj7IqRUVrcH3JVhp5YScCoyz0dYQBcl2sCWmKYpDradQ==
X-Received: by 2002:a05:600c:5108:b0:426:545b:ec00 with SMTP id 5b1f17b1804b1-42806ba1a38mr12993305e9.19.1721900714594;
        Thu, 25 Jul 2024 02:45:14 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:683:1601:9ca9:646d:b3da:7e1d? ([2a0a:ef40:683:1601:9ca9:646d:b3da:7e1d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42805730e52sm25783985e9.4.2024.07.25.02.45.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 02:45:14 -0700 (PDT)
Message-ID: <c7d280d5-6bc8-41c1-ae85-418e20b38a25@gmail.com>
Date: Thu, 25 Jul 2024 10:45:13 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 2/6] unit-tests: add for_test
Reply-To: phillip.wood@dunelm.org.uk
To: Kyle Lippincott <spectral@google.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?=
 <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>, Phillip Wood
 <phillip.wood@dunelm.org.uk>, Josh Steadmon <steadmon@google.com>,
 Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
 <da7ed537-1c8e-42ec-aa91-49e1319e8c68@web.de>
 <2dff757d-3c5d-4923-97df-26bcb1c21230@web.de>
 <CAO_smVhoobWpsbYHnHJqTj7TJJ1udo_UaGdbOnUqe5jzL+tyaQ@mail.gmail.com>
 <b4cbc8ce-5e39-491d-a6c9-627a7fd97c8f@gmail.com>
Content-Language: en-US
In-Reply-To: <b4cbc8ce-5e39-491d-a6c9-627a7fd97c8f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 23/07/2024 14:24, Phillip Wood wrote:
> On 22/07/2024 20:13, Kyle Lippincott wrote:
>> On Sat, Jul 20, 2024 at 11:22 PM René Scharfe <l.s.r@web.de> wrote:
>>>
>> I think
>> having multiple test functions is generally easier to understand, and
>> the overhead isn't really relevant. It's not _as_ compact in the
>> source file, and requires that we have both the TEST statement and the
>> function (and forgetting the TEST statement means that we won't invoke
>> the function). If that is the main issue we're facing here, I wonder
>> if there's some other way of resolving that (such as unused function
>> detection via some compiler flags; even if it's not detected on all
>> platforms, getting at least one of the CI platforms should be
>> sufficient to prevent the issue [but we should target as many as
>> possible, so it's caught earlier than "I tried to send it to the
>> list"])
> 
> I also have a preference for function based tests but I do think 
> something like for_test() can be useful in certain situations.

I'm no-longer convinced that this is really the case

> For 
> example in test-ctype.c where testing the ctype macros leads to a lot of 
> repetition or a giant macro with a function based approach.

Having re-read the history of t/unit-tests/t-ctype.c I don't think the 
repetition in the original version was really that bad. The objection to 
it seems to have been that one had to write the class name (for example 
isalpha()) twice - once when defining the test function and again when 
calling it. I'm not sure that is really worth worrying about.

> Another example is where we are using a helper function with several 
> inputs and we would prefer to write
> 
> for_test("test 1") {
>      int input[] = ...
>      int expect[] = ...
> 
>      test_helper(input, expect);
> 
> ...
> 
> for_test("test 10") {
>      int input[] = ...
>      int expect[] = ...
> 
>      test_helper(input, expect);
> }

One can use blocks to achieve the same outcome with the TEST() macro

{
       int input[] = ...
       int expect[] = ...

       TEST(test_helper(input, expect), "test 1");
}

So overall I'm less convinced that adding something like for_test() is 
necessary and I'm very convinced that calling it for_test() and using 
"continue" to exit a test early is going to confuse contributors.

Best Wishes

Phillip

> rather then declaring all the input and expect variables up front with
> 
>      int input_1 = ...
>      int input_2 = ...
>      ...
>      int expect_1 = ...
>      int expect_2 = ...
> 
>      TEST(test_helper(input_1, expect_1), "test 1");
>      ...
>      TEST(test_helper(input_10, expect_10), "test 10");

>> If others agree that this is a good simplification for the people
>> reading the test code (and hopefully for the test author), I'm fine
>> with this going in (with a different name). I'm not trying to veto the
>> concept.
> 
> That's my feeling too.
> 
> Best Wishes
> 
> Phillip
> 
>>
>>> +
>>>   /*
>>>    * Print a test plan, should be called before any tests. If the number
>>>    * of tests is not known in advance test_done() will automatically
>>> -- 
>>> 2.45.2
>>>
>>
> 
