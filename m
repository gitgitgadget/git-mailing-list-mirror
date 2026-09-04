Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3553E3CF207
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 09:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788515614; cv=none; b=s/QY1chQNv8jjnJKRSB2gGEytwbW94P0wMtvnF+iNjmRqXr3o+D28qTw58no+ClYtl5zsjSZWgQNr4QFSNhffDzzshBrKHFxbGIROIWWso3L0JrXzPTmiJCBvo0sWqJXuYbxDVj7zgEjQmJMek4k8ZVgZphogWToyQlPWv4Y2qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788515614; c=relaxed/simple;
	bh=hS3WNEfxyY4FCuzk6naMm5+v5mHS+COZY5Tz9xFYV20=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZQaCsAi8qEN6lZy2JHPSuMG38p+MLco8bfMt7Z135l1uVi5su4TtoJMyiSFxXvceoDoVBdySyGKpWiHWSVcT7O3j30+f0weBN2mB+thCSHCa7R78t0BEmddZ6E8MlApqT2PwzWoaifHuJEzVK/6SmgtTplfNkOWSrPTsis4utM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b+co0vxY; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+co0vxY"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so8413095e9.1
        for <git@vger.kernel.org>; Fri, 04 Sep 2026 02:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788515611; x=1789120411; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KxWD0Db1iKs3GD0TM5Cvo22T+i2p/poTYDV6gdoe+ys=;
        b=b+co0vxY8Mf+0QefyrGgZgPwqR/ZqXkpTjrGmyG6oQ7LtcYNv2tM/PUtXOUmR2PJDO
         YtO9ineg7lYDdn+f+XoijECLeZulsY2LCIX45EmQPO32kgqM9yfO8a/a1TxX/DqlWo8K
         yYR++SX6eMrdihtRXp48ZRMY9QHslnWt/K9v1sBh3AMc8Egz/+UdEMWEUIE+orlxpCSx
         C10QhyQ0GSaD7C1M9Od2nnGK+8LPsqjBxdo+okeZxJZFJmRULqGhbCCq5OQIaaMYcXfw
         /x/mkBiT+hotKZIYdulmisd4yGTR6RBWCk1khPIfNWRiILc5xm9t0RRbZzNjrkGEUU+S
         gwnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788515611; x=1789120411;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KxWD0Db1iKs3GD0TM5Cvo22T+i2p/poTYDV6gdoe+ys=;
        b=FECyv5rKkI7xKNaD0ABns6RIgZKmU8Mdk01gFeWfqfbAEjRuHW9Rk87UWTtpNaUEzl
         TknFwerkjWe7pNI80O/5AlnGJgxuP6Bk6H65G9XLIOp07m3pCn6E+HVB2heIwtIoTusl
         0dwadLKVY6TagWlnXE9hC8mUuPSKL4URtg5TFtOWOEYl7BB9M7W6y9QNOQQrjB7wvIdE
         6ZoR1hYpOTj6ZC8gHgdQqMMPzh+nHTYz8iuMAznpovIMW+3JM8+peOSIxVbVtsHobzcd
         aqBu5Emw7H0k5//LOz9uOZ6SEeWHUA61hCcyqWO4qCaaLY/2WA08bB0QDl94dy/vRE07
         JUCA==
X-Gm-Message-State: AFuF++n1NqEvClFhWnuieYeK0+nLnxgYV4m1HmPf/CzLaSs+WQHRV1T0
	LAeMtPeEKRmnaon8wN8/EUAM3EYGLgsvd4hlRnHLnGCGFo9c41jg09ItHVGzPw==
X-Gm-Gg: AYBFou2ss2VoQrlGqgTA34vUMbhlD/a4rKtQG/zzt5Kapvk9n4dju0zvPLOUOsLLE4D
	+T0mVlS8fBwHMo9D4wEGGstMJti0WN9OHsDx3BwxopvJCeXdUwYeJQGwOJjvWscLSg+y7KeTIeI
	jYJhAkKupkaMFpaO+L/+Mup1N030XlWOB6I7t9ogQ8/fPIcGQ/D07e2a3dFasEw1SByOgJ8WUZz
	AimxdVV8sWskZbqrf1QSxjVoqFOkzMQ+TK47GYavG/hH1pYxyqjAw/FlG3eBMWqkdunNW0yw41S
	hplPN1X8jU/or7WmsTtItlxrpY2e/1+r9BfQmk6BebU3wU+BP4YxvgTtlZKzJetzxT98RbBQu2x
	dNCfVgIPVUF6XXvQ9riROZ3etgiBjJ87AvebK9IsaZoBGLmD69Gn4i7vU58u7N9RZEYg2oAdoRO
	yVbWDxCNvw5lmBghFIK6Z1K0oStxloy4hJpEuf5WUs0fbhTP+XZXzsB5y8nqUh4ujzzBEJGbJwy
	NR0DovndlpyodcbylMz8axsok3RGBo/qHMH6c05QCkZAKwL/Xn0UA==
X-Received: by 2002:a05:600c:474a:b0:49c:e42b:a4ac with SMTP id 5b1f17b1804b1-49cf823f60amr44287575e9.11.1788515611066;
        Fri, 04 Sep 2026 02:53:31 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf770fcf5sm54772485e9.6.2026.09.04.02.53.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 02:53:30 -0700 (PDT)
Message-ID: <5a5c7552-8fc8-48be-abf6-063aa31f7711@gmail.com>
Date: Fri, 4 Sep 2026 10:53:29 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/2] t3507: pin CHERRY_PICK_HEAD absence for a conflicting
 --no-commit
To: Junio C Hamano <gitster@pobox.com>, Aleksei Sviridkin <f@lex.la>
Cc: git@vger.kernel.org
References: <20260903125524.67889-1-f@lex.la> <xmqq7bl29g2p.fsf@gitster.g>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqq7bl29g2p.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/09/2026 22:32, Junio C Hamano wrote:
> Aleksei Sviridkin <f@lex.la> writes:
> 
> I shamelessly asked an AI agent I had nearby to guess what your log
> message might have meant and got the following.  I am not sure if
> that matches what you wanted to say, or if it is totally off the
> mark, but at least I can follow what it is trying to say, even
> though I do not think if that matches reality (for example, when
> "--no-commit" is in effect, we probably do not want CHERRY_PICK_HEAD,
> even though the version of the text given by Gemini below claims it
> is needed).
> 
>      When a cherry-pick is run with the --no-commit option and halts
>      due to conflicts, Git must still write the CHERRY_PICK_HEAD ref.

No, with --no-commit it must not write CHERRY_PICK_HEAD. I agree the 
commit message is confusing and could be much shorter.

Thanks

Phillip
  >      This ref is necessary because a subsequent "git commit" relies
>      on it to preserve the authorship metadata of the original
>      commit.
> 
>      Add a new test alongside the existing cherry-pick tests to
>      verify this behavior.  The test suite currently checks for
>      CHERRY_PICK_HEAD after a conflicting pick, after a clean pick,
>      and after a clean pick with --no-commit.  However, it lacks
>      coverage for a conflicting pick with --no-commit.  Indeed, if
>      Git is modified to stop writing the ref in this specific
>      scenario, all existing tests still pass.  This new test closes
>      the coverage gap.
> 
> 
> 
> 
> 
>>
>> Assisted-by: LLM
>> Signed-off-by: Aleksei Sviridkin <f@lex.la>
>> ---
>>   t/t3507-cherry-pick-conflict.sh | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
>> index 44596cb1e8..2ce2e88184 100755
>> --- a/t/t3507-cherry-pick-conflict.sh
>> +++ b/t/t3507-cherry-pick-conflict.sh
>> @@ -100,6 +100,12 @@ test_expect_success 'cherry-pick --no-commit does not set CHERRY_PICK_HEAD' '
>>   	test_must_fail git rev-parse --verify CHERRY_PICK_HEAD
>>   '
>>   
>> +test_expect_success 'failed cherry-pick --no-commit does not set CHERRY_PICK_HEAD' '
>> +	pristine_detach initial &&
>> +	test_must_fail git cherry-pick --no-commit picked &&
>> +	test_must_fail git rev-parse --verify CHERRY_PICK_HEAD
>> +'
>> +
>>   test_expect_success 'cherry-pick w/dirty tree does not set CHERRY_PICK_HEAD' '
>>   	pristine_detach initial &&
>>   	echo foo >foo &&
>>
>> base-commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc
> 

