Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D152064F3
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 16:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730909010; cv=none; b=a7aDnYwKoL0VLY8icADBBsr7hO8eYCZ2qubEyxgSRQ4PJOO22Gd1q8MEdh590jtzz+DYm4XG9BlFJQ/r0fauLA5yVLonXYUQ/PK6IIKzd/arN947m8X+Rl4pxfMDqzt7pC6y037vJ3ZxAnj/ItT4mgLfjRosD97nGewvUtv+iVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730909010; c=relaxed/simple;
	bh=M7Lzt8mxxVkUd914dvC+O2GnbXwM8vEK2ZZ1hwr0Ypc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=KInIfZ14f5Wp8jdFYt+UPmWyk6Y0JSUSZoOaQHAzUK2+hN7sBO1Y5WX4gOdhrYutIFyGetLWAjYo14ahFHfL5MQKpwVXW4g1q5Hn6c+PYIGa8C9GuKtidSVnwAheCHB+Zqz5DJgTBR52HuQiGqDjqxOlsvfayCG25+6P7UALbtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ExAxm1JK; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ExAxm1JK"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-431616c23b5so111975e9.0
        for <git@vger.kernel.org>; Wed, 06 Nov 2024 08:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730909007; x=1731513807; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dRQVjRkQvd9jGly0bxBh7rnUlPvXucaWtv7mxNFOGOM=;
        b=ExAxm1JKLiJySrRS0EWZeeULrpzTXhBPHNpox/kz61wply3t3gpABNZlgwO+bmuo9I
         brN7vNRJGKccD++swGJ7bcQatAebpFR4Voabo1S5mI2F8FrthT92JeY0h/zbp5RXJFi4
         5dqm5Zbw2xPjG7AcO5Ll6jNpnUz6QHP/CW/uxQs7dZheNu5jCJaYZgi0syRzXcCZGju7
         koxZ5Pwd+quuGgKaLH++uE87GNlwH2dGV2RIsptbbqdOm4iTxiHosfo03JqXBVxJaFY4
         k7Ga6oV7ySUBJ2Y8U47YFXODLbvO+w4tgpqGkAVLnV93XZOAsDRUBqhmqhZ7lYo5XKdf
         3Wfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730909007; x=1731513807;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dRQVjRkQvd9jGly0bxBh7rnUlPvXucaWtv7mxNFOGOM=;
        b=FKB5SArqX8SdMNroieptkdc4kuqHSjZ54jfRpA2tJ+ywRkBJJnxweQ4JPosM9AQ4gy
         ePDN97QZEhudWk6LPbUMEgvFQZj+yFCR1SGxoIoPoQQvG3Ak1RgnaNbyFMQHfa1Qzu3J
         GCxFYKpHOBT5zweYaRKo+q3/8GRNmF2r8/T+0jNEAMEnDaQZmK6IanD2ryWDAoWvWjwd
         UpE1eXCivsxIuBUY+DNhnBiH1yOdHPQl2RsqexGGYJMMYpVmnfdJG2XXbN0RXgq7NKaW
         y8w0B6HW9P3bLRX++tt5Ln0ox9jEoqbs2JazB9I1pstVAysdrFiGQGYScg+TnYjuHzlX
         938g==
X-Forwarded-Encrypted: i=1; AJvYcCUjnd6fNagAn7Ai77eH4YyfTL2kLLUyPAjgvXNz/gjtYuebWTSIAiGkoM9ZXRSBX6wrRGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPISmS7x+JhPe1Xz9bTcK0Eyl+HrgzZ79SGMLU7Zs/N+ntqTyB
	63frXOAsd0fLJN+2qmOED5W5TlkLsky1SBqYM7/46ACXGhSFqSgR
X-Google-Smtp-Source: AGHT+IEDGjT/6Iv1rodcIxMNZdzti13g8NvBD5GaMlQC+8qYpSheWm7KFsiDi5Rke/4aQd+oE/QhOw==
X-Received: by 2002:a05:600c:468f:b0:431:47e7:9f45 with SMTP id 5b1f17b1804b1-432a9abb8ebmr27625335e9.11.1730909006999;
        Wed, 06 Nov 2024 08:03:26 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:6b0:6601:5a4c:6f5b:4f15:3158? ([2a0a:ef40:6b0:6601:5a4c:6f5b:4f15:3158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10b7d15sm19798118f8f.8.2024.11.06.08.03.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2024 08:03:26 -0800 (PST)
Message-ID: <e996ced2-7c0b-4d58-8318-28db07ac5a29@gmail.com>
Date: Wed, 6 Nov 2024 16:03:25 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 2/3] merge: replace atoi() with strtol_i() for marker
 size validation
To: Usman Akinyemi <usmanakinyemi202@gmail.com>, phillip.wood@dunelm.org.uk
Cc: Patrick Steinhardt <ps@pks.im>,
 Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
References: <pull.1810.git.git.1728774574.gitgitgadget@gmail.com>
 <pull.1810.v2.git.git.1729259580.gitgitgadget@gmail.com>
 <5d58c150efbed1a10e90dba10e18f8641d11a70f.1729259580.git.gitgitgadget@gmail.com>
 <ZxZHH-oHE7g09xIR@pks.im> <e4a70501-af2d-450a-a232-4c7952196a74@gmail.com>
 <CAPSxiM-X3gk4tsVSJ_dFP2EGWX_dvFnqRp0rTYvhPxqYsUeijg@mail.gmail.com>
 <3c081d3c-3f6f-45ff-b254-09f1cd6b7de5@gmail.com>
 <CAPSxiM8u8CdeipatHRJ8Fq_8hKHDqyTm8OCh7sR49_Bh6Ps8uQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAPSxiM8u8CdeipatHRJ8Fq_8hKHDqyTm8OCh7sR49_Bh6Ps8uQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Usman

Sorry for the slow response

On 31/10/2024 12:21, Usman Akinyemi wrote:
> On Thu, Oct 31, 2024 at 9:58 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>> On 30/10/2024 16:19, Usman Akinyemi wrote:
>>
>> If you want to work on this that's great, but please don't feel any
>> obligation to do so.
>>
>>> I also noticed that the test used for testing used a different
>>> approach(test_must_fail) compared to the one I wrote which used
>>> test_grep. Should I change the test also ?
>>
>> I'm not sure which test you are looking at but I assume it is using
>> test_must_fail because the command being tested is expected to die. If
>> we change the code to print a warning instead then we'd need to capture
>> stderr and use test_grep or test_cmp. Note that we only want to print a
>> warning when parsing .gitattributes, the other callers of
>> parse_whitespace_rule() still want to die. Also we should decide what
>> value to use when the user provides both - neither indent-with-non-tab
>> or tab-in-indent are on by default so it's not clear exactly what we
>> should do.
> Hi Philip,
> 
> I understand, we will have to pick one if we are to use a warning in this case,
> indent-with-non-tab seems to be a good candidate as it is not excluded
> by default.

I'm not sure I understand I what you mean by "not excluded by default".

 > We can have something like this>
>      if (rule & WS_TAB_IN_INDENT && rule & WS_INDENT_WITH_NON_TAB) {
>          warning(_("cannot enforce both tab-in-indent and
> indent-with-non-tab, removing tab-in-indent"));
>          rule &= ~WS_TAB_IN_INDENT;
>      }

That sounds reasonable for the cases where we want to warn rather than die.

> and this for default
> #define WS_DEFAULT_RULE (WS_TRAILING_SPACE | WS_SPACE_BEFORE_TAB |
> WS_INDENT_WITH_NON_TAB | 8)
> 
> or just leave the WS_DEFAULT_RULE as it is and remove WS_TAB_IN_INDENT
> in case both are set.

I don't think we want to change the default rule as it could cause 
problems for users who rely on it.

Best Wishes

Phillip

