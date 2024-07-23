Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6CD1527BE
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 13:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721741119; cv=none; b=r8YaH1sEYNlb1igZ7zEsx0fco4tc3xeUFVVjLI17qtuLHwDAG7ZPaI+f2HASjbZI/8fte03y+4kSkKcOKNpZLP1MJ8XOU83K/XsjVT9iukm+kC+SuikgTk0quiHeQHKuX+wHIZIRg8mf+bWofXegcHdXWMoDZ9GT4O275UxyHqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721741119; c=relaxed/simple;
	bh=aur5sZy0cOVyCtE/Y6/frL5GrV/BOyMZ+KNoiBQ3ESI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=VmGB8shkI34Didkdeub8b/vPkzhlXwjia0rdlU/9Tx9vo5kQuiu6d11Je1ZLxlJT3EBEPrxZpG60g7/f1VBje8JBTP1qy32HGDu8P++S+XGZmDukDraeRjc3V8L/T/0ldnYyKzrrKk1MzG7ogSiudwYUd9pwO2FOynUy+dAL3hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h8afq1eM; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h8afq1eM"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3686b285969so2537742f8f.0
        for <git@vger.kernel.org>; Tue, 23 Jul 2024 06:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721741116; x=1722345916; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PQ/ARZzQAvSh4sKCteXYp7UXFtMSZPBTLJJ01uF5PeQ=;
        b=h8afq1eMNIsRFbaoFiu3Xq6Pt6/STAMxHzS9pe/u7d5/p9bHOOtMfRq20SfA58Jtx6
         cT9fQpQdvVSLui/ID2QKAeri3fv8xLa4tDhkT4TY1iCIXQmwGl5xXKqn6NS5pXACFrom
         gcD3eJzrElTpBuUTrYTu8VpZ2bntWzD03V0mAUDStAzg5HSGUJ+p02TALu1xC93wXBah
         ZcrDChep0vSIXl2e4vA6tmSHLF0GhV9j1KWojdePYg8mGUJTXZCnw0W+ryT0B1/20Rys
         LTg4rIPRhE/KzMN0x9oqfPjdAhy37TGPUtrv8nOSiwtJt+UhDppI2NSUWFnpRWnLg0DR
         z3QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721741116; x=1722345916;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PQ/ARZzQAvSh4sKCteXYp7UXFtMSZPBTLJJ01uF5PeQ=;
        b=cFmCLFB9FUkt7suvZbxQ4qtCznu/HKGRm/zMjIdoFRmjGpY1JXbL0m2VHssTl3r7df
         Wn9200TUxE2PR7tR/H/XcR2+Nj5R6C716ZPLqG3NGpk94vrQTDLJoBR3aI9SHIDPPa6g
         5yHc9ww90nqceQn/itsZtpeRVYNu9q6UZuTB/Ai//WHuRXC4HBAUIsDbz+ulhAud4KEc
         l9mSfs9XRpMj5PNjclyfeojJG/bgopZqId5UbnujT38fD0ud25EsLIcq3mfvkd1wcxrI
         JdOoI5jiBmkHXgCCgKbQJWgdH069a77ctgLLFcxT3Y18VohQzs/YSddoOPSTBkvWm+Vy
         ZJbw==
X-Gm-Message-State: AOJu0Yy2VtTdVQWApbhi/o9i+SXDZ3fHNeb90PQGX1I7Z+oezWYAylnW
	VkJnSabP+2M3GdxxlDQMPVAsGQIwQanh5AjSksV88susbvKX+rlkQUZ5P+kR
X-Google-Smtp-Source: AGHT+IFLlxTwVWG6u6AlBtJbVj7fEWqr5M3SwpHTLCe5ocWE6cbN0yEOE7Ot/BIkHfngpTWEQKffRA==
X-Received: by 2002:a05:6000:43:b0:368:36e6:b248 with SMTP id ffacd0b85a97d-369bae35a52mr6415380f8f.23.1721741115933;
        Tue, 23 Jul 2024 06:25:15 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:600:8501:d2c6:37ff:fef6:7b1? ([2a0a:ef40:600:8501:d2c6:37ff:fef6:7b1])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-368787ecec0sm11510400f8f.105.2024.07.23.06.25.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 06:25:15 -0700 (PDT)
Message-ID: <ef7c75d3-ed09-485e-a094-17a74de487d7@gmail.com>
Date: Tue, 23 Jul 2024 14:25:15 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2] unit-tests: show location of checks outside of tests
Reply-To: phillip.wood@dunelm.org.uk
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 Junio C Hamano <gitster@pobox.com>, Kyle Lippincott <spectral@google.com>
Cc: Git List <git@vger.kernel.org>, Phillip Wood
 <phillip.wood@dunelm.org.uk>, Josh Steadmon <steadmon@google.com>
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
 <da7ed537-1c8e-42ec-aa91-49e1319e8c68@web.de>
 <2dff757d-3c5d-4923-97df-26bcb1c21230@web.de>
 <CAO_smVhoobWpsbYHnHJqTj7TJJ1udo_UaGdbOnUqe5jzL+tyaQ@mail.gmail.com>
 <xmqq1q3lb4me.fsf@gitster.g> <be282096-49af-4d83-b5f7-8b4f1b447edb@web.de>
 <d92e5854-e916-49eb-a79e-9dc43778a7ea@web.de>
Content-Language: en-US
In-Reply-To: <d92e5854-e916-49eb-a79e-9dc43778a7ea@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 23/07/2024 07:02, René Scharfe wrote:
> Checks outside of tests are caught at runtime and reported like this:
> 
>   Assertion failed: (ctx.running), function test_assert, file test-lib.c, line 267.
> 
> The assert() call aborts the unit test and doesn't reveal the location
> or even the type of the offending check, as test_assert() is called by
> all of them.
> 
> Handle it like the opposite case, a test without any checks: Don't
> abort, but report the location of the actual check, along with a message
> explaining the situation.  The output for example above becomes:
> 
>   # BUG: check outside of test at t/helper/test-example-tap.c:75
> 
> ... and the unit test program continues and indicates the error in its
> exit code at the end.

This is a nice idea and looks good

Thanks

Phillip

> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
> Changes since v1:
> - Set ctx.failed to report the mistake via exit code as well.
> 
>   t/unit-tests/test-lib.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/t/unit-tests/test-lib.c b/t/unit-tests/test-lib.c
> index 3c513ce59a..989dc758e6 100644
> --- a/t/unit-tests/test-lib.c
> +++ b/t/unit-tests/test-lib.c
> @@ -264,7 +264,12 @@ static void test_todo(void)
> 
>   int test_assert(const char *location, const char *check, int ok)
>   {
> -	assert(ctx.running);
> +	if (!ctx.running) {
> +		test_msg("BUG: check outside of test at %s",
> +			 make_relative(location));
> +		ctx.failed = 1;
> +		return 0;
> +	}
> 
>   	if (ctx.result == RESULT_SKIP) {
>   		test_msg("skipping check '%s' at %s", check,
> --
> 2.45.2
> 

