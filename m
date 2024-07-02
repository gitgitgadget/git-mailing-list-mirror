Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FED71B51
	for <git@vger.kernel.org>; Tue,  2 Jul 2024 15:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719933243; cv=none; b=lyJV7SvplmNSlQncqvei5kURVpjbNM0bVdSW26DBb2Nv6P4lcfHqFYjA9aVmW+qFp/0IJ8kBExApkeGIPnZU+OI90YWHtFP22fm5uNatYM1z5KEInmIHI1pQXNJ4EOyMwxugHoNXbIm7SVp16i4R1wiwRGHtTEXXEZGia51i8DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719933243; c=relaxed/simple;
	bh=/sFJqTyWIpGP9ShnP9x3ZoqIfTVDeBhK2CzAHe5+7Ps=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=J3BN/GeClL8XfUOTkzUx0ojXO/VoAAKG91mS8xszPbpmy8ynwSg9GhK3z+d2pS/EtUKVpqvOA0kYNCLers7znqTdGnASHT19Vi2Sre42wCYyewnkgfHRJMgpqRBgn0xs7uf+bpZL5XUNT2EJdSUdzjdi8vscnd2CVvqBNiAMRAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S44CyTaL; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S44CyTaL"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3674e1931b7so2947807f8f.2
        for <git@vger.kernel.org>; Tue, 02 Jul 2024 08:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719933240; x=1720538040; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b1dJvovTlzPQXqGuAuigIlccCRPFfUUyNJ7EHKS62dQ=;
        b=S44CyTaL7QO2rHJKhjLSq9FQN7idnbasg9JWL9cjc225SOWGrmk/TB96JPpaEY4u/H
         BQm22L8a71QpKD8SbwzorpGJW0Am89vrHGP8MxBD7KGZzXJ6Y3aE94RxniTKeHB2e5fe
         swmZFlStEgs/plA2FHd5/trz0CuxaMon+95urem/Iue1yj2TzsoRKb0TttO+dVXbOSVI
         BZEzp9VvMP7bUJE/s2UhI3bi1AZsv38n4HLwDb/AS6zHZzRu7hzsKq1a3ZLH1b24nL7+
         4OZBeIKOFm3jaOcCwPUllDzEPCCk8RA7xVbqE2xgm3tkx5V292TAn7ly4FkKeh9mSRz+
         oCVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719933240; x=1720538040;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b1dJvovTlzPQXqGuAuigIlccCRPFfUUyNJ7EHKS62dQ=;
        b=kKAIOyEd/opdudf/fyh982IRiAFIs4wW5Xnx+LoF17EGELWhqDNuvwgtUPCHx2u0GE
         hJ25nghSAHGsbHFIGGvja7Nli4yCR1mfQyY1mIxckmL9HU0dJZLoODMWfn/Q3Y/x4SHJ
         Nge4EUutoEjejqkQcPQKOd4AzDdyK+RWbY+bxCpZdOO1KOrTcw5PtCG9oEpb5Q1LEZkZ
         fCnA3vJxJbvZG0h4MX9x8Jh9Tb2ldXlltrKD1n1I8rYMazIDfjgz6rEnC3bgscT1v0Vv
         qHn52Reo0IixUF6zca3c4yXaT0XgNoU24kA2k5dzx5Wt5uN58cSTyKQoE0o2Gj8v9eWZ
         s5wQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFKBNN58krqkp+8GUN4B5rYj4oFcrqTY5vL+MMNIl+57tBskXpLsg1RAcL2aSeU1yCtfivEc37WdThvD9mBQJ2kkda
X-Gm-Message-State: AOJu0YyP1+rUXGEZmUIFDDaTlPkUoSkMt2U7qCBvVlF/dwAzkFKAtRte
	ibeGdB9ZE2qb4OzFJLxsu1MVODJdkw3OH+9UclI6n3tmZqCB4IHx
X-Google-Smtp-Source: AGHT+IEsIVctAEWi7zDep73qG9EhZQ22E4YsPtkzWmIQVnvRQrTe4JbohbUU/O5VL4I4WlToyKls0A==
X-Received: by 2002:adf:f406:0:b0:365:b695:ef76 with SMTP id ffacd0b85a97d-367756c71eemr6045018f8f.36.1719933239567;
        Tue, 02 Jul 2024 08:13:59 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:64f:8901:b1e3:645a:b3c0:7476? ([2a0a:ef40:64f:8901:b1e3:645a:b3c0:7476])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0e143csm13462598f8f.59.2024.07.02.08.13.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 08:13:59 -0700 (PDT)
Message-ID: <51ebc0fd-ddae-4bdb-a5d6-c92ce8b1f3e6@gmail.com>
Date: Tue, 2 Jul 2024 16:13:58 +0100
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
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 Git List <git@vger.kernel.org>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
 Josh Steadmon <steadmon@google.com>
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
 <8175f239-8d4e-49f7-ae0d-dba7df8c365d@web.de>
Content-Language: en-US
In-Reply-To: <8175f239-8d4e-49f7-ae0d-dba7df8c365d@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi René

On 29/06/2024 16:43, René Scharfe wrote:
> The macro TEST only allows defining a test that consists of a single
> expression.  Add the new macro, TEST_RUN, which provides a way to define
> unit tests that are made up of one or more statements.  A test started
> with it implicitly ends when the next test is started or test_done() is
> called.
> 
> TEST_RUN allows defining self-contained tests en bloc, a bit like
> test_expect_success does for regular tests.  Unlike TEST it does not
> require defining wrapper functions for test statements.

There are pros and cons to not requiring one function per test. It can 
be a pain to have to write separate functions but it keeps each test 
self contained which hopefully makes it harder to have accidental 
dependencies between tests. Having separate functions for each test 
makes it easy to initialize and free resources for every test by writing 
a setup() function that initializes the resources, calls the test 
function and then frees the resources. The changes in patch 6 to use 
TEST_RUN() mean that each test now has more boilerplate to initialize 
and free the strbuf. Having each test in its own function also makes 
main() shorter and which means can quickly get an overview of all the 
test cases from it.

On the other hand having all the tests defined in main() using 
TEST_RUN() means we can just write the test body without having to 
define a separate function and then call it with TEST()

> No public method is provided for ending a test explicitly, yet; let's
> see if we'll ever need one.

This means that we do not error out if there are accidentally nested 
tests. That probably does not matter too much.


> +int test__run(const char *location, const char *format, ...)
> +{
> +	va_list ap;
> +	char *desc;
> +
> +	test__run_maybe_end();
> +
> +	va_start(ap, format);
> +	desc = xstrvfmt(format, ap);

This uses an strbuf under the hood. So far we've avoided doing that as 
we want to be able to test the strbuf implementation with this test 
framework. We don't need to support arbitrary length strings here so we 
could use a fixed array and xsnprinf() instead.

> +/*
> + * Start a test, returns 1 if the test was actually started or 0 if it
> + * was skipped.  The test ends when the next test starts or test_done()
> + * is called.
> + */
> +#define TEST_RUN(...) test__run(TEST_LOCATION(), __VA_ARGS__)

Looking ahead the plan seems to be to change most instances of TEST() to 
TEST_RUN(). If we are going to go that way perhaps we should steal 
TEST() for this macro and rename the existing TEST() macro.

I'm not very enthusiastic about requiring the test author to wrap 
TEST_RUN() in an if() statement rather than just doing that for them. It 
makes it explicit but from the test author's point of view it just feels 
like pointless boilerplate.

>   /*
>    * test_done() must be called at the end of main(). It will print the
>    * plan if plan() was not called at the beginning of the test program
> @@ -156,6 +163,7 @@ extern union test__tmp test__tmp[2];
>   int test__run_begin(void);
>   __attribute__((format (printf, 3, 4)))
>   int test__run_end(int, const char *, const char *, ...);

We should add

     __attribute__((format (printf, 2, 3), warn_unused_result))

here to catch any errors in the format string / arguments and to warn if 
TEST_RUN() isn't wrapped in an if() statement.

Best Wishes

Phillip

> +int test__run(const char *location, const char *format, ...);
>   void test__todo_begin(void);
>   int test__todo_end(const char *, const char *, int);
> 
> --
> 2.45.2
