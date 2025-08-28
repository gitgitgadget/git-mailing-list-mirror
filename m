Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9032063E7
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 14:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756389616; cv=none; b=GwcyJLDNqn6zdfO/9Zel98R+4Qbyn0TYCwmaKJrsh8JbB2yTcY6G6lNZ0jMYCegWRjl7fs2SkMUGp34byQL1lh5kI/0JeU7qAulmM19hDGdDa7X8O2uOm3jn4CuvbqPu4yqwZTV/5/VujYiA6LtIz0fjPvHcVUenCKoQfDIcOLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756389616; c=relaxed/simple;
	bh=aWLULWpNboz/tXtlJybAve2XCO7no35hOWBVVPcBTMY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=cYbhjgE8NTtRfDBKn4jbFMOUMTXNMZMCdVA/lkeLGsm4TLapjP1Cuh5k0ZLwo2wcTwJr5Si/gcHj9rTyiHaP2lf/EsTyoOUGFsqxwVHchh6ut+6hCFXt0cOR01vW4hmalQDoPCFDI6YyjcRPmoKK8HYiJ+Az+/h5ueWS7+4woC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NM3zw03P; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NM3zw03P"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3c6743a10e3so519126f8f.0
        for <git@vger.kernel.org>; Thu, 28 Aug 2025 07:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756389613; x=1756994413; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qEy95bBTRz6Kw9RLb0T5pzy8/EIE48Ag/iHXz/spP2s=;
        b=NM3zw03PwVguR7Jb5YRh3uDlQJ8UebhEgrz73pDs8uC/D3i3wcISI95Hyiaytk+LMC
         J94Awe0UC87Qxk5FojK4INXOw6+djgCETMSeNoik57avheDF/mR0WTWk+QkG488wAvu6
         DeHaKwWHeQl/cET3QffrFJl54Dzj/APHKj5V8IHxljxmZx0pKHqZTKhzEGpEUBFeD1AN
         S/mheEkZOcdrMYBEUGqU7of0Wl+skBM7kEsZMzK5KngMPFeNuhRveYl4srirAdbE9LM5
         R3OC3HPhJDje49iYRdLE0cn7Jb9ZjKaUq5mu5ufz6dVSKlQZAfqvtILPrn0yJfLjACwA
         ZNlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756389613; x=1756994413;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qEy95bBTRz6Kw9RLb0T5pzy8/EIE48Ag/iHXz/spP2s=;
        b=d1/Dn85RmliHNgXYEpIZTD9WrZPV1gqzWvwPvE/44pEhIbSaXw94rrzTtKd0KoiMjB
         TxDCOX1poXd16Q/VfYORYBeBxhoOCvlm1rKrAj13rQ0pWPdItRz7u5gV5BxQjTQTJyPn
         l/1QRpF0FGd4xzBcAvbGJxsKGjJ0Rro3BxhR3xJpSddxiwYXr8GiZBd3k+UgLqnH9U/p
         NUft0aO2uuHJD89g50s2eMYdWs/uCWbTQ7eW2/t2jeZk2w/UuK5LIS4yoXFAz0j2puV6
         VNI+AQ9XupEiNf1siiM6ijgsjzLKwazwL2KOp9Fmlk531xS/UOhwqfq2o5zLZpUyk5gT
         WM2Q==
X-Gm-Message-State: AOJu0YxCmwABuNDCzxWHHnSIOG2aLG9Xg+AYKgycjp/0T3q4siygZe2j
	F/OjKpF9CyKHnJvi6cKVmZY6S6iPddbq6rTuOoClsjv05rhfIHHozrrJ
X-Gm-Gg: ASbGncupg4QxLH/DJcZ+bo2MTc8MaLTbEzEC/KQ8TUVRcTowiEp4YtIF9pPIgglKB+6
	iw+4APrdqrLaFpKJikQsQEevq35EHBWAuhzh/NSUFxq4sLOgQPcD7nLF/3BVieBk8N5Gra/ENNa
	3E4xCE6cSxxNfQ/AgHwh7bGSDyFKFFStV8MTly+YGflSgaNqUaezmPTG+qhKKeSqJzsaAIIZZxZ
	im3dzJyXERCrd4vADipF49gowvsKYaAD2AX1ulNwcyOgttNXZ4QDsoT6U56i3WssvvzcTVw9Pm6
	YyiOuUCy3szDrj3mos2/etulYkm6PTT+7940PLGJRNIqP++ISHP3qMR2t4C5SmHG0sqk/INBCrc
	BEW33wquEhaCmqL4jTysWECl1sDNcAwEi0Khfzk7QsDXgt+Wxb7iUnKcdwVUQpO3HOQf+eef2jR
	D3vw==
X-Google-Smtp-Source: AGHT+IE2Y7A7y+3lSU2Igt1IEPLJX5PnApX8XtJdnkeZf5H86O+rYx28VU3Z5Gr05ibgboqLjSA1OA==
X-Received: by 2002:a05:6000:4203:b0:3cd:76e8:7e with SMTP id ffacd0b85a97d-3cd76e806a3mr3322842f8f.55.1756389612294;
        Thu, 28 Aug 2025 07:00:12 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c? ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ce87c62433sm1575067f8f.62.2025.08.28.07.00.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 07:00:11 -0700 (PDT)
Message-ID: <b6b60e6b-c06d-4dc6-8722-b53736f8b059@gmail.com>
Date: Thu, 28 Aug 2025 15:00:08 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/6] t0018: switch default branch name to main
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Wing Huang <huangsen365@gmail.com>
References: <cover.1756308283.git.phillip.wood@dunelm.org.uk>
 <7c20f7693f4518ef79be0a2277515bb00d912213.1756308283.git.phillip.wood@dunelm.org.uk>
 <xmqq5xe81y0i.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqq5xe81y0i.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junio

On 27/08/2025 18:21, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> These tests use "trunk" as the default branch name but the exact
>> name of the branch is incidental to testing if the advice message
>> includes it. ...
> 
> Would't we be better prepared for a future where advice messages may
> start including the current branch name, though, if we made sure we
> are on the branch whose name is known?

The advice message does include the current branch name, that's why the 
test needs to be updated when we change that name from "trunk" to 
"main". The sentence above is trying to say that it does not matter what 
that name is, we just need to check it appears in the advice message. I 
could see an argument for the tests not depending on git's default 
branch name if it changed frequently but realistically we're unlikely to 
change in again in the near future. If we did use a different name in 
the tests it is just as likely to cause objections and need to be 
changed as git's default name so I'm not sure it gains us much.
>> ... Git 3.0 will change the default branch name to "main"
>> and remove support for GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME so change
> 
> Will it?  I would have expected and hoped that this support won't be
> ripped out.  The political atomosphere to decide if a name is
> "correct" will change over time.  When somebody comes up with a
> reason to burn 'main', just like everybody moved out of 'master' a
> few years ago, wouldn't we be better off to keep this mechanism?
> 
> If we truly believe that we have chosen the forever-perfect name
> that nobody would ever bring up renaming again, we can rip the
> support out.  But I am not that optimistic.

If it's another 20 years until we change the default branch is it really 
worth supporting this variable until then? I find setting it in tests is 
mostly pointless boilerplate. When the variable was introduced in 
704fed9ea22 (tests: start moving to a different default main branch 
name, 2020-10-23) it was described as "This `GIT_TEST_*` variable is 
meant purely for the transitional period while the entire test suite is 
converted to use `main` as the initial branch name by default." so I was 
hoping we could remove it.
>> these test to use "main" instead of "topic".
> 
> You meant "trunk" here.

Will fix

Thanks

Phillip
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
>>   t/t0018-advice.sh | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/t/t0018-advice.sh b/t/t0018-advice.sh
>> index f68e08d0b14..c695ade4be8 100755
>> --- a/t/t0018-advice.sh
>> +++ b/t/t0018-advice.sh
>> @@ -2,7 +2,7 @@
>>   
>>   test_description='Test advise_if_enabled functionality'
>>   
>> -GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=trunk
>> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
>>   export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>>   
>>   . ./test-lib.sh
>> @@ -33,7 +33,7 @@ test_expect_success 'advice should not be printed when config variable is set to
>>   
>>   test_expect_success 'advice should not be printed when --no-advice is used' '
>>   	q_to_tab >expect <<-\EOF &&
>> -	On branch trunk
>> +	On branch main
>>   
>>   	No commits yet
>>   
>> @@ -55,7 +55,7 @@ test_expect_success 'advice should not be printed when --no-advice is used' '
>>   
>>   test_expect_success 'advice should not be printed when GIT_ADVICE is set to false' '
>>   	q_to_tab >expect <<-\EOF &&
>> -	On branch trunk
>> +	On branch main
>>   
>>   	No commits yet
>>   
>> @@ -77,7 +77,7 @@ test_expect_success 'advice should not be printed when GIT_ADVICE is set to fals
>>   
>>   test_expect_success 'advice should be printed when GIT_ADVICE is set to true' '
>>   	q_to_tab >expect <<-\EOF &&
>> -	On branch trunk
>> +	On branch main
>>   
>>   	No commits yet

