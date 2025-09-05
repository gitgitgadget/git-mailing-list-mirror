Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA6B225409
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 10:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757066861; cv=none; b=tpD51LlJ54FbwSRZ+rLnyKzqTfqiTahoWmfpcwpQeuqmUePtav+ak48dfIxm94zba/vWmXZekWskKWJX4HmaCM+8Es1pFQeOo8LGlyca9TMYayAk4LfrnoszqAJQofMX9HdamnLCkpBg6AwMGTwbuyTn3cnE5gCQh4MzqPnceiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757066861; c=relaxed/simple;
	bh=fsg/0zxB5og2Wqvj1Kt+cba1LGyfoSKeiNISf7N1t8M=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=r731ueqgxYQ1At6k4ZtvKpg7C2eV3+ewCDTVmQTb4p1rktfY2f4wFvtb7o8vbp9bFjp3ec/BlyOo9kdYdOgXS1be3BokTGc7+t+wFqN4Wl+VZk1g2GVFUdBqqUEPvtQGSsVrNYdG6H47hfS0cye63bFzogbJauXxmqnsC4QxFFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A0OjuTDg; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0OjuTDg"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45dd513f4ecso8517385e9.3
        for <git@vger.kernel.org>; Fri, 05 Sep 2025 03:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757066858; x=1757671658; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FpPsQa2wCOKV+rh2UIaF19NeRxTGArimF4wdgDGtd9s=;
        b=A0OjuTDgL+C104WpUUHnq4JMK5QwOx+7dLxa2KU8wYw8cKDmoDa26JZYjISwztg0FE
         bjYOsWaTpCXOVznWvjbosLglDXCuW78AIiWGM5fml23ZOXsuuclqU3cLM+KwrlY+HSot
         behBIDZSn7XmOtZV5mSXE0By4G2+umMkCn9fHUIVlIDH0y1dbvhQW6oYvA3b/VDLNlFe
         e+CZ8Bclc2sfUAW/GC/FP+rlFGT8vQUlijf7T9m2WXoYYmeIp/JcZA0d4FdBgBiAQmD/
         gtMqqozp2LItoLJahCocbrRi4P32Qf/Qs5uhpBleII8rDqsM0dxlq1gSMlkyokiQZwaD
         2DpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757066858; x=1757671658;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FpPsQa2wCOKV+rh2UIaF19NeRxTGArimF4wdgDGtd9s=;
        b=oxB/5fH4iZc5GKeMR6hNfxv4MaIWIOJRdV69tbsZpT0JUMf6QRmAxkmvEthkSxMTN+
         nKEWoCuY/m4x/aKMGCd4D8w23FmFm9wEtiVMYu5c/Tu2GkDu+GJwYAGkmhtiQbM9FAAA
         9om60OaFOHgFmbI3r1Gwlszyuy7Obmgdlt2wlOolIEE/ZIOiSB+n8vw73FC1zY35tJ0y
         nRXUrnXtv98yOZXHTQznCJf03tdYISoFWiZmTknQbWHLD7tuqIaBVLGJkTv4krnbgvLe
         Zkur37v6rn/vMjKSusf5MTFTwW7Y+15TrIyveBgnN/Bs7cwVgAinF8rTZTsIz9jBqaX5
         IB4w==
X-Gm-Message-State: AOJu0YzJdFg+D9+SK0UeMcRgZFxmiha5QgiIfwmDFc0ffixrgymCujkV
	1olL4l08frD30V9GNkmPFy2cVciKhJhSAqSWppL24vpQYvBR+/C40oDCkZ964w==
X-Gm-Gg: ASbGncsbqGZiucu2ZQ/QUsa6QRZdRgsVA3bWUiSf1X/r3BVDKPGHJiS0Q6d2grvIiBo
	xz6XTL/dAoDsLp4BqrpsTxKsYpBNZWt7uzQIOttQ8nbBh4GLbHS2LkIZwQ8hktfjIP5JLEC/POt
	lNvFGMyaDANcTK6eMqyE79FLP5nPuP8PPUcrIfEJ0l1Gtqq1VJXSM4u0Fg1BaHV/N8Ale5g1Kmo
	eNgPeqxX7ELlsi7Mgo6u2oKEszNKsn6DXUSOX41URQh7fotaayUN2Ur6RuwVH56mUHLjW7bYH88
	RbzGPfKWnQsTKPHOJhYDneFNA2+WckYdIny6pTkasN2G2g4otUyw1VPVAZPTstTwxb1a+fnpBqa
	ZUh0DaBH5HYcPLULrmO+k/n8h7Milm0xx3y7Gq9Mn9Qsmnc2GNKpV4/Anw5Fv1mMHpT0XrTLGv6
	4FRgFt
X-Google-Smtp-Source: AGHT+IFpbeAAiS15f7+rxMLD5I76RHj0gQo7GMUTKxDOZHhkNgBoz16KP/hCT9C37cLDuCxbtSxUuw==
X-Received: by 2002:a05:600c:3b9b:b0:45d:98be:ee8f with SMTP id 5b1f17b1804b1-45ddbd51396mr5192495e9.26.1757066858033;
        Fri, 05 Sep 2025 03:07:38 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1751:3d01:f738:17c2:c65a:d0dc? ([2a0a:ef40:1751:3d01:f738:17c2:c65a:d0dc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b9bcda91dsm153062325e9.6.2025.09.05.03.07.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 03:07:37 -0700 (PDT)
Message-ID: <5b725ba8-c349-4630-91db-8992d893205e@gmail.com>
Date: Fri, 5 Sep 2025 11:07:34 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 3/4] t9902: switch default branch name to main
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Wing Huang <huangsen365@gmail.com>, Patrick Steinhardt <ps@pks.im>
References: <cover.1756308283.git.phillip.wood@dunelm.org.uk>
 <cover.1756992089.git.phillip.wood@dunelm.org.uk>
 <f1bf01e13226cf3f6ca0e811123278248e4eea6d.1756992089.git.phillip.wood@dunelm.org.uk>
 <xmqqfrd28448.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqfrd28448.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/09/2025 19:27, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> Remove the penultimate use of "GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=
>> main" in our test suite. We have slowly been removing these ever since
> 
> s|main|master|, probably?

Oops, yes

Thanks

Phillip
>> we started to switch the default branch name used in tests to "main".
>>
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
>>   t/t9902-completion.sh | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
>> index 6650d33fba6..964e1f15693 100755
>> --- a/t/t9902-completion.sh
>> +++ b/t/t9902-completion.sh
>> @@ -11,9 +11,9 @@ test_description='test bash completion'
>>   # untraceable with such ancient Bash versions.
>>   test_untraceable=UnfortunatelyYes
>>   
>> -# Override environment and always use master for the default initial branch
>> +# Override environment and always use main for the default initial branch
>>   # name for these tests, so that rev completion candidates are as expected.
>> -GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
>> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
>>   export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>>   
>>   . ./lib-bash.sh
>> @@ -1453,7 +1453,7 @@ test_expect_success 'git bisect - start subcommand arguments before double-dash
>>   		HEAD Z
>>   		final Z
>>   		initial Z
>> -		master Z
>> +		main Z
>>   		EOF
>>   	)
>>   '

