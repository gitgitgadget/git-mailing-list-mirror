Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AFE1E520C
	for <git@vger.kernel.org>; Wed, 26 Nov 2025 19:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764185472; cv=none; b=tQ4wIAtHvBgbWhLQFf2cMOqnSSOaRsErsLXbi6a3eHKlNDK7MSmTSBx9PGL4g8DR55kOhBkDMGLTz010dP8RxNoCLxgTN6uWn6msoZxTt8fH6jz4A37oTIFiXmnhe1UuUJECTIJgW6fNzStYKkYoh9Hv/JuQlbY56lbORIfScnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764185472; c=relaxed/simple;
	bh=/Zj+GywGGJx/3crH6g/5jlqoqykfUguH20HLekca1gY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SMwTUo0gg5bRLYZPbLEK+QDxkRPAStQRW57z833Bv1zuUAMqYBaqJBS6N9jg2+nGQ/iB/Rv2+VJwbQ6pY4H3NVuwNlsvAj/5/Fo1piNKCNkDhqu2LefOSN2FCdx8AhVo1Lb9JPMsZlq6GAIN7lbE+MMQ6FC0Gee5hYXjIKsEMVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/3bIrLw; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/3bIrLw"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2984dfae0acso2009535ad.0
        for <git@vger.kernel.org>; Wed, 26 Nov 2025 11:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764185470; x=1764790270; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t4atc9HcJ4OGJ6qn6W8J+CBm9AqG3dfUo9nPbVysxGw=;
        b=J/3bIrLwMx/gG2IWeEcKKcRHm/ITb0SgY02XQYxilF5e5BJcPfnoY6whTB90prRX3E
         EzCgDV1sbjPFva9OZDYaPg+K54Y/XtMa9tcgNuz4+fg1MnBcGrwf7Pa1vGK0rLMrtKYh
         Z3K1/mizRh9q+MiL4v+scq3cUBzZjdVochufnSVLTZ1q9W9y3jau9GqCoKDHtQ4MtrzI
         4wrGX6S5aSEjTA/y3Z33bUZKxDd7hOWdI8FKkxyGt8GTtKiVqNRaJcWcu/Vw18EKSjct
         OsNQnRGVSn8kyU8xI3UnwfcZrfkQXHOVoqjFTJ0oj2+BXk5dxO/XesTdmpm2gaRgV5EF
         1aHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764185470; x=1764790270;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t4atc9HcJ4OGJ6qn6W8J+CBm9AqG3dfUo9nPbVysxGw=;
        b=UZiPnGj9DH6HXTlL8TZ7NC1TWOT1u/jT93mNaSUrA7hu//WSa8CvmsjJTnDA3swlxq
         isV1/ZpI/MD1p2ey2Fp5ltc9eHqMXSY7e9lXlQTYglKf3YUEUVTEGexVFEnhM/I+xhAW
         ZP6WDREvRwHHDJq3yudticNVAop/NQSb7ns8hVi368MfN4AECMLxllGyS9wJGWUfMf4A
         bGfhvbQsloRkBTGBrrfWQima5qLsrG4ZZ/5VXXaRh+P8oqcTEwgO4QLr7mgAgLYEgzay
         Z4YbxqNiTaWsQCaHkmXhpa5tPxyM/q5Ue6A7Tmgf6/ZZjnKjjNL4nrrsbOfy2kpnSwMK
         fGJw==
X-Gm-Message-State: AOJu0YxCGDNIsfDOLgQ0LnBlTZnh4tyFaELcbyh7VwYspRkMHVeup1Zz
	Mknwuzv8o+XAnoQqLTDsTKk1ZsgfwLQP2bECBbLD/I8dLLpXrLWRMgMN
X-Gm-Gg: ASbGncu959SUqShb8LD6oCfyXnk/DHN7v/1MdNzzuol1vzQNaHJeQBBamO9kt12cRoK
	loIq3qJtb0Gm7pb9SSF9cMES4y04TpSbAa4wyYyOMyErAUwAqtwXbr1xsGfCi3e8x8/TDLAoVip
	miZEakiqhgWU6DKR7702jts0pa7Kuj2FwFWV2qh0TlAyTISMTvPHlrO+tNIwsBTK/C8yfGzyRI1
	TRBBDxpMACiSBCF0BPhZBk7qx7JqYzJrC13qkjClQS3r7+PmlkslF+2chOLQ5TsU8E7nofn1ieF
	7XsP3TRAD/7ely3SnkG3IHLu/xMA00QBITUF04k+XF07NgXvh3Q65oj88oTqZdJDsGcvXFSBGKA
	ahY51e9Ek6P0Jr9m6dJkjwt6qngqULfIox4JZy78lYVLTievfATLC8PbsNkM3xT1nEEPLzNQ0eo
	4ujMggMCT11s3jVNZBYwc6liTLe2Kz0PG/zGodFaCz1FWkXF5hqRMjNfuttFqgd6w6WP1yZNFkp
	5NsQ5qFnhKN7OAVlhGcIM4=
X-Google-Smtp-Source: AGHT+IFQVlGZtJUL3/86TeWY3fHNicyRAtqzeplY4DyPeoCMqHHRDp5EGKoVDWP4LUtbESN6ytEj7g==
X-Received: by 2002:a17:90b:1a84:b0:32b:65e6:ec48 with SMTP id 98e67ed59e1d1-3475ebd2f41mr7728548a91.8.1764185470340;
        Wed, 26 Nov 2025 11:31:10 -0800 (PST)
Received: from ?IPV6:2409:40e3:30a4:b776:bc94:4b73:d55a:67b2? ([2409:40e3:30a4:b776:bc94:4b73:d55a:67b2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3476a5c71d7sm3380220a91.15.2025.11.26.11.31.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Nov 2025 11:31:09 -0800 (PST)
Message-ID: <cc5cc77d-5d78-4a16-b4b5-91a903436788@gmail.com>
Date: Thu, 27 Nov 2025 01:01:03 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] replay: add --revert option to reverse commit changes
Content-Language: en-GB
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, ps@pks.im,
 newren@gmail.com, phillip.wood123@gmail.com, phillip.wood@dunelm.org.uk,
 karthik.188@gmail.com, code@khaugsbakk.name, rybak.a.v@gmail.com,
 jltobler@gmail.com, toon@iotcl.com, johncai86@gmail.com,
 johannes.schindelin@gmx.de
References: <20251125170056.34489-1-siddharthasthana31@gmail.com>
 <20251125170056.34489-2-siddharthasthana31@gmail.com>
 <xmqqwm3drk6m.fsf@gitster.g> <xmqqo6oprjti.fsf@gitster.g>
 <xmqqjyzdrjf1.fsf@gitster.g> <xmqqfra1ri5n.fsf@gitster.g>
From: Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <xmqqfra1ri5n.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 26/11/25 01:36, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> By the way, I probably would not be queuing this version today, as
>> this has obvious conflict with a large code movement made by
>> Patrick's "history" series, which itself is expecting a reroll.
>>
>> Perhaps collect review comments on this iteration a bit more and
>> wait for that other topic to be rerolled, and if it turns out to be
>> solid enough, base a v2 of this patch on top of it?
> While I cannot test it with other topics, I had a chance to run
> tests after applying the patch directly on top of 'master':
>
>      $ make CC=clang SANITIZE=address,leak test
>      ...
>      Test Summary Report
>      -------------------
>      t3650-replay-basics.sh                           (Wstat: 256 (exited 1) Tests: 31 Failed: 5)
>        Failed tests:  23-25, 27, 31
>        Non-zero exit status: 1
>
> The first failure was this one
>
>      expecting success of 3650.23 'using replay with --revert to revert a commit':
>              # Revert commits D and E from topic2
>              git replay --revert --onto topic1 topic1..topic2 >result &&
>
>              test_line_count = 1 result &&
>              NEW_TOPIC2=$(cut -f 3 -d " " result) &&
>
>              # Verify the result updates the topic2 branch
>              printf "update refs/heads/topic2 " >expect &&
>              printf "%s " $NEW_TOPIC2 >>expect &&
>              git rev-parse topic2 >>expect &&
>
>              test_cmp expect result &&
>
>              # Verify the commit messages contain "Revert"
>              # topic1..topic2 contains D and E, so we get 2 reverts on top of topic1 (which has F, C, B, A)
>              git log --format=%s $NEW_TOPIC2 >actual &&
>              test_line_count = 6 actual &&
>              head -n 1 actual >first-line &&
>              test_grep "^Revert" first-line
>
>      test_line_count: line count for result != 1
>
> The "result" file has 0 bytes (hence 0 lines).


Ah, this is because my patch was based on a tree that had atomic ref 
updates as the default (REF_ACTION_UPDATE), which produces no stdout 
output. The tests were written for --ref-action=print behavior.

I have fixed the tests to either:
1. Use --ref-action=print explicitly when expecting output, or
2. Check the ref state directly rather than parsing stdout

The test failures you saw should be fixed in v2.

Thanks,
Siddharth


>
> Actually, address or leak sanitizing build is not needed to
> reproduce this problem, it seems.
>
>      $ make CC=clang test
>
> Was sufficient to see the same first failure.
