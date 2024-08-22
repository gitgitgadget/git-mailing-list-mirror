Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781381CB13B
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 13:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724333054; cv=none; b=UQcKTz3OD4Lyxn0+UNFjk7xpRg6PofvaeZQniGHDXOUZGqHJmXcMChra/0sQDuvqdKvRp2666BulKwJGNo/2E+w+MxoBAgRf43l1Ypvhy0fBRzowDUUxI4U4tiB8THkgeFkq836b4U7CVWucCpHhUarr4DaUW0lI4vP2IxvoLvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724333054; c=relaxed/simple;
	bh=RgpUXMOW4GhOYNLI6qMqf4oEldY6JoFl+aYi6gQFOug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G33JOgY6WfbxeufiqeYNFJMdNop2YGfWswn7duZlSjCmxRzsNt3Gu6ArCkNUKZzHxnNSPf1kR77MYaYHwmbRMhXc31JCYxPQ7IqvvhyBPOc4kjgFdlpS/WHBN3J8gcQ9lCABH7jE/SQnWYxvCLHZSlMOdG2yR9TjVmy593TgKr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EjC/JOel; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EjC/JOel"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a7d26c2297eso103570266b.2
        for <git@vger.kernel.org>; Thu, 22 Aug 2024 06:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724333051; x=1724937851; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6tYmPYgAwk6rd453a9eiGpMscnJE99UmbQiO4Il9pUg=;
        b=EjC/JOelONrgwBz7tdSSpCBFGMrMyE7n08vt9FGPUxNefdO0O529hN8jOUusYY9oC5
         qflpZFPIbu890pyZawdL19nXHnwq0uIkGbs/vKqAf/3GxNLlJZmJA/MwyLdBhuYiBssS
         9PgHppLkm2B+OJdOQh4ptXjT7Lxb3MxAr4xVZjxaRY6NKYfQakKyInBC/KVTWpJTRXpA
         8pWNQxSZiU1mp31PESoFNubXjJU4fPn2YDkQA1ry9EkWD5qOgKpcmZig5lGVMAQh6QoF
         qgx0j2ZVKaDeD0Z2R55yG9mR92LBUk4Tjbg7odqzGmtrcaKh5srANiIsU0D43JAyo3c9
         rvNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724333051; x=1724937851;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6tYmPYgAwk6rd453a9eiGpMscnJE99UmbQiO4Il9pUg=;
        b=Gkq5BXZ88wdXYMjc0qldiygruhS1P+urC0Lp4/yJ7M33ib9vyj4y1Y3Eb9zXjIEG2L
         sltpEck6GGQwFd059ClNOHU1FK/16GIUuRsTJcFwWHE7q83ccyhsbeUsu0nKoVM9FvWI
         ocDcsVaGT3NJpEAxAbAU3xqQTn9E7NUPNXyFsZ6l1qL/s4FP6X6CPxy/W6v8T4DseZSx
         m8Tf9j6Q84S0PwiIEb771QdDLEARBES+QyXQAVnsASMzLaf7CFZCfoks6m2qitBjfg3/
         z83+ImtBwKJ1u/pKJzP3bL+6dJZdI+jTTE8+Mi98F8nlzjc8ckHPVbUXPLHBoY6UO0EZ
         hn1g==
X-Forwarded-Encrypted: i=1; AJvYcCUqwijE9m21RAgXz+60HflOceN+tjis8DaLRxPfMRU35BFkfuGGAoXy++29efbQzz+Ur9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPBKF/LdIEYhk3fHO7OT8fLMzniKgPIR0kvKSV8TCeDc1tLeHL
	9k0O+FxGqHq1adcXISX0oCbvAqccgGaXpUOL6ue2vKFYISKGwcmd
X-Google-Smtp-Source: AGHT+IENE5CP7GM/caqUq9Taa6oyKbMWQTFI12XDCHB+8pDHEKmtVJgfnOIIP9sZSNZFeUThXnJIgQ==
X-Received: by 2002:a17:907:9620:b0:a86:7ddf:2909 with SMTP id a640c23a62f3a-a867ddf33b7mr381871666b.14.1724333049970;
        Thu, 22 Aug 2024 06:24:09 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6d3:8001:d2c6:37ff:fef6:7b1? ([2a0a:ef40:6d3:8001:d2c6:37ff:fef6:7b1])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a868f43367fsm120485266b.115.2024.08.22.06.24.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 06:24:09 -0700 (PDT)
Message-ID: <27a37848-cdf8-46bb-9764-d8f952504c12@gmail.com>
Date: Thu, 22 Aug 2024 14:24:08 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 5/5] cgit: add higher-level cgit crate
To: Kyle Lippincott <spectral@google.com>, Calvin Wan <calvinwan@google.com>
Cc: Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
 emilyshaffer@google.com, emrass@google.com, rsbecker@nexbridge.com,
 gitster@pobox.com, mh@glandium.org, sandals@crustytoothpaste.net,
 Jason@zx2c4.com, dsimic@manjaro.org
References: <e3f7d292-ee51-4784-8c85-14b5223c380f@gmail.com>
 <20240821184605.341205-1-calvinwan@google.com>
 <CAO_smViznLAxxGH+rfouUquq8tNJn16-CSoLbbGosy3fuYzTgQ@mail.gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <CAO_smViznLAxxGH+rfouUquq8tNJn16-CSoLbbGosy3fuYzTgQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21/08/2024 20:23, Kyle Lippincott wrote:
> On Wed, Aug 21, 2024 at 11:46 AM Calvin Wan <calvinwan@google.com> wrote:
>>
>> Phillip Wood <phillip.wood123@gmail.com> writes:
>>> 
>>> I'm suprised the compiler does not complain that 'struct config_set' is
>>> not declared in this header - I was expecting to see
>>>
>>>        struct config_set;
>>
>> I'm surprised as well actually. Removing the forward declaration of
>> "struct config_set" in repository.h doesn't result in any complaints
>> from the compiler either. Will add it in the reroll, but am curious if
>> anyone has any ideas why the compiler isn't complaining.
> 
> C doesn't require structs be forward declared separately. You can
> change the name to be anything you want, and as long as the forward
> declaration of the function and the function definition agree, you're
> fine.

Oh, TIL. The declaration

     struct foo *f(struct bar*);

declares "struct foo" and "struct bar" as well as function "f". The 
declaration of "struct bar" is scoped to the parameter list and so is 
not visible to the rest of the file. This is why we forward declare 
structs that are used in parameter lists and why the compiler complains 
if we don't. The declaration of "struct foo" does have file scope though 
which explains why the compiler does not complain about 
public_symbol_export.h because "struct config_set" is declared as a 
return value before it is used in any parameter lists.

Thanks

Phillip

> If they don't agree, well, let's hope you don't encounter that
> (it's the same problem as if you have a forward declaration that's
> *not* visible from the definition that disagrees with the definition:
> `void some_func();` vs. `int some_func(int arg) { ... }` -- if the
> forward declaration wasn't made in the same translation unit that
> defines `some_func`, nothing detects this misuse in C).
> 
> For this reason, you should only ever use forward declarations that
> are provided by "the code" that's being forward declared. i.e. if
> you're trying to use a function from foo.c, please forward declare it
> in foo.h, and only there. This way, assuming foo.c includes foo.h,
> you'll detect mismatches.
> 
> [apologies if people got multiple copies of this, I sent with HTML
> mode enabled the first time]
> 
>>
>>> before the function declarations. As I said in my comments on the last
>>> patch I think we'd be better to namespace our types as well as our
>>> functions in this library layer so this can be resued by other language
>>> bindings.
>>
>> Are you suggesting something like "#define libgit_config_set
>> config_set"? I wouldn't be comfortable renaming config_set in git.git
>> just yet until config/config_set can be a standalone library by itself.
>>
>>>
>>>   > [...]
>>>> +    pub fn get_str(&mut self, key: &str) -> Option<CString> {
>>>
>>> If we're adding an ergonomic api then having return CString isn't ideal.
>>> I think the equivalent function in libgit2-rs has variants that return a
>>> String which is convinent if the caller is expecting utf8 values or
>>> Vec<u8> for non-utf8 values.
>>
>> Having both get_cstr() and get_str() makes sense to me.
> 

