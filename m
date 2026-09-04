Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32250441618
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 13:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788530015; cv=none; b=QkoyL6fLW/oRkzJIVWlYiVsrJk00jrSouXIlBOxsonW/4APKkyZRK4FOKUBuNTe3x75CRwwXM8MG1b/plrMLbFwMLW3SmNg3A5Ui7jBl1PGMqNBHaNrrVmNagkSrNcXzbK9nHg/kKkFCa6fuNPyxOwwYdDvRgd5MqiNzqrLB99I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788530015; c=relaxed/simple;
	bh=bYP/Z1NqXPTnpi1D9isaIkDPUSkR2t7N2kMfKGhLTi4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ft/zwI5JC0I2Zg8z/5KyyHN+G51YbwnxIGBLNIU9pT5E/SlWEaSV9N5L1iH2SQv8qUlAyudUDO/goPEk7L1qn6r9iJxH2h+rz2tBP8bft4ymS1cRQ/f5ckD5dGRzkA8IqIjmwAAqLQJjHUhf8zDCMXf5M0lLm+T2iME1ZnPEKcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H8ClVYWJ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8ClVYWJ"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49b965570d7so11624875e9.0
        for <git@vger.kernel.org>; Fri, 04 Sep 2026 06:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788530012; x=1789134812; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uh0QaNCQvNJvAMt9vyrXvzHcJJy9iJfNXg8Kg100R1Q=;
        b=H8ClVYWJwpjVWPo6i37oy24HI25R+UpKeH625g8q1ni5OfPUKeEafWXffIYP8DVbXv
         b2uglMqo9htRKkCRlxWZVXlxdCt5aoARuL4bgKQEEsyk/5LBIv8fEdWoyrsoMUFiujFP
         P8bIdSxHyaEFUeE1EzXhYpePq1C/53JESQRglqWjDo+M320SkHUi39rpYzf1TP6OOKkC
         oBihro/3PuHotQAqveK/3q/UylpbjCd/ZCPdmciW92XmxcY/NmE4TJlvazK3x98QsVuA
         1TZKnvkuX0NAdrO0Jd1Z6w73KZHxK73LyRMqLM4wKXJjZVVY0AraNVPtvPp95w+kb6/a
         xOMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788530012; x=1789134812;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uh0QaNCQvNJvAMt9vyrXvzHcJJy9iJfNXg8Kg100R1Q=;
        b=X9hEHtA4EfaPwt/yX/EN26qPeKIApU8xlWnu3ofMeYNVDq7tn1pflX2IsIBBbU/DEh
         r1rEJ7kKQxPs24T/4HL99Lu/daKpo1rWRiihoxI2NejcZWkaXe6Rqj2zWUVhKgRgOhhk
         Ccr1OtFrK4YeU7UOrZfCna2ZfYiCBNTw8D9m9ukb8SETW27jI+9hfOgJN1sJsMmNiWyP
         R/o0EbdReDTsip2ASinuKFa1Li2oq3c/SPkB9gt0o8YE+S/u8wNbfmtJxmH4gJt0LXUC
         gCtBANWsjeXrdhC/fBbjBfgdEUH6X1QgdwlyRDFKTS2Wcy02WuMVLEvDDef12pFNhKbB
         KmOA==
X-Gm-Message-State: AFuF++nbEV900QoxuLayE7UtDqGkqYGeTqr8zAQNNqzIyczO1Ec8S4ik
	L8umbId8dRIAxyEE4LjxszBDfX53wSFRzuafZbgfJ57DA7Pxod7FXvnA0SCvIw==
X-Gm-Gg: AYBFou2AeJYNc50/+f2/HPBbFwhE34F5pSVT28O3cEPn4UyytId8NRoVPORz/COHaRp
	2sFVDn7luEogil1QP6kGsfXhEi2W3JRK5j5P4DK8ctuxm2d5PEBpDLrqo231IW3yJOpSqqJJ4o1
	8saOi/ivn1L52VUAWoJzR3sKvmPjlwaq+5B4sECzm4Ezq3mJ5wSoD//lSYJ0JtulurLvq6Di3Uc
	Li5LEdlqIIK4nVbMpsFLvnWaLC7Ve/f1az2KZXAhE1wpIsHfWDUXxTpdaSx5p0EcF9BydrRJNSp
	+HdYZ/MJS/se4jp0XWH11ONX0NZuG5lrwr2Q+RYq0yOqCKbxoomrUaaLncnNnlNN277yyqr87zQ
	MCgplO6Ta1nt1QuVmJdlt+zllmh0pbwGGooAnylX6ZZYbwBrkFR7+PgfUomtjSAc6H7L91yHJEd
	+5qolD1WShEhJ5juBYBYVTjE2sw0WgEg/OFrc97LNF0HbA2BXMm0p1FrurYI9yS9zPTwetrnt4V
	kIyC2lIV4ZGNDZxZ58x8h1IXZpvyX5wF9rKvr1PQWM=
X-Received: by 2002:a05:600c:3f0a:b0:49c:e27c:6b10 with SMTP id 5b1f17b1804b1-49cf81e4a10mr65642575e9.3.1788530011855;
        Fri, 04 Sep 2026 06:53:31 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf75ce49esm124043495e9.1.2026.09.04.06.53.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 06:53:31 -0700 (PDT)
Message-ID: <639f29ff-59f3-403d-acbe-e6173a8fbf04@gmail.com>
Date: Fri, 4 Sep 2026 14:53:30 +0100
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
To: Patrick Steinhardt <ps@pks.im>, Aleksei Sviridkin <f@lex.la>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <20260903125524.67889-1-f@lex.la> <xmqq7bl29g2p.fsf@gitster.g>
 <20260903214553.53942-1-f@lex.la> <apqSXT4lT7v0ILjp@pks.im>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <apqSXT4lT7v0ILjp@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/09/2026 10:41, Patrick Steinhardt wrote:
> On Fri, Sep 04, 2026 at 12:45:53AM +0300, Aleksei Sviridkin wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>> It is not apparent what problem, if any, the description
>>> above claims the commit addresses.  Nor is it clear why
>>> checking these combinations is relevant.
>>> [...]
>>> Can you help me understand the above two paragraphs a bit better?
>>
>> The test pins the one combination t3507 did not cover. The file already
>> checks CHERRY_PICK_HEAD after a conflicting pick, after a clean pick, and
>> after a clean pick under --no-commit, but not after a conflicting pick
>> under --no-commit. That is the case a user hits by accident: the pick
>> stops on conflicts, they resolve and run "git commit", and the original
>> author is not restored. --no-commit never wrote the ref, d7e5c0cbfb skips
>> it on purpose. Your reading is right and Gemini's is backwards: under
>> --no-commit we do not want CHERRY_PICK_HEAD, and the test asserts it is
>> absent. Without it, teaching git to write the ref there would leave the
>> whole file green.
> 
> The question is whether it really makes sense to have tests for every
> single edge case. In a perfect world we of course would, but in the real
> world there are a) gazillions of different combinations and b) every
> test brings its own overhead as it increases both wall time and
> maintenance costs.

We should certainly be careful about adding too many tests - I often ask 
for tests to be revised to remove duplicate coverage when reviewing 
patches from enthusiastic contributors. In this case I think it is worth 
checking as we can do it by adding a single call to test_ref_missing to 
an existing test and the logic around when we do and do not write 
CHERRY_PICK_HEAD is a bit tricky.

> That doesn't specifically mean that this one test you add here is not
> useful. But we need to have a better argument than "we didn't have it
> yet". For example we might've seen regressions, the logic is extremely
> fragile or we risk bad consequences like data loss or an unrecoverable
> situation if a property does not hold.

I agree we should have a more substantial justification when adding 
tests. As I said above I think in this case the justification is "the 
logic is tricky" and it is cheap to check it.

> It's a thin line to walk at times, and I usually wouldn't care about
> this too much. But over the last couple weeks we've seen more patch
> series that add random tests to our test case without good reasoning
> just for the sake of adding a test. And that's something that we need to
> contain a bit.

Agreed

Thanks

Phillip

