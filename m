Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B142F99AA
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 13:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756992362; cv=none; b=oaXOQqlwnRgPLVcmjJQMqAK3EB5rwKOuIDedjCAaDs5b4q5Vspn0XN7eraHVLA2b0FyV9dHpdtFhS+8J0HQcbIag11BJb9yacuPYD4frVWJMYeMssXah6ZlwMJ4aIYK1Wgs4pqUM01ERM3lc8nK8PnywePEXwwZYdQj8Z0hn96M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756992362; c=relaxed/simple;
	bh=oMYRHyMGjCX+JoPMDK1E8jvHVJjHtN9qp5J1/kT+kxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cBZQfK1IST4xW30r2Nguikt8WgA69HXjNu2TJLgGdFywSSeG12t8p6dzu/6pd9u4+wIaofKGtwFIHb0oXX7/XHQfo6dkEYccRwufHkgBfYB/Zqh7v8xOMrxz87kiNoGODXIC9JP8nXaweNiSNvM7isLsZs6frDsLqVw9UsaZfK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PKV+BA4R; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PKV+BA4R"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45b79ec2fbeso7486765e9.3
        for <git@vger.kernel.org>; Thu, 04 Sep 2025 06:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756992360; x=1757597160; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PRXzhW0KWiHPLk195Wj1HzsGE3ol9CtKOVK21f0vJFI=;
        b=PKV+BA4R0FBWMYKZXYjjTSZRxYrAuj8+sdhSjTvhalL5fE/obXitQtKP+peec1Goxx
         VCECF4qSjIb853TjDu6PLY/v1eBTqMhWh9m2qk28Y7j945dtXe0QFhDtUD/0UDUwZ6Z2
         BZhHj1AlP/O6kZ26wDx4RQE7NECIVg0X09Hf9J3VFklwAdLKJIiMjBT4b0HwziQd9ooY
         z68YG/6udNWg6fQgRnnCjsiZwiytjtnKNx3LUS1CxG7ADRv3e6sDHiUqK2nmP9Ckr1tL
         cxoWs7Dp+gCMIXquiH7WOhne2WTf5qRHOGq5wF48n2Hb7jk4VzQv/++VYvNCuPyE/cpa
         nAYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756992360; x=1757597160;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PRXzhW0KWiHPLk195Wj1HzsGE3ol9CtKOVK21f0vJFI=;
        b=LQFGKfxVB7VCDC/PcOcvJj+W0l6PlrJhOna2346EHjBLqd6xXLpW7Ei8P6Ls1L93dU
         QzA5QQ4gjbUO+Ppopn2Jcpozs46/XnmsDKFqkQqpQm4t/xMb18+j+EUYNzBCDEQxxnMi
         yRu0/QELXl6VVYXlBO6t4Ykq/5TIlk5F7EMjLdWuWFVeFav5rIxAWeTIaL/46K9YBzvd
         HFjY7gFC9LX3TLH9KK0kicGER2CnW8sMFHt+VqNZltmrl5otRcwUvkzEZcEmgins4E6i
         cTEW+8xMB8tvyluZqFYGt0zWE1fbbheWJITMc6MIibAGZBzEsTv9Wilu3spG/Gc4O/eb
         HGbQ==
X-Gm-Message-State: AOJu0YzZqo2LCG0Hv0jlZk+Yao7UQl8SsPlSgeCihVX1phadWmw865+d
	yyVaT2SN+P0xggNwPJVtU7klBs3f99qjOHGHBncm8sZLtv42V5Xw2vD3
X-Gm-Gg: ASbGnctMBE7J2lrYEV3YcuTaRIEnWJ5SaQ3fVxqWTe0SugEYMXykvB8+ZnVacHoXMf/
	XaOO6SswNoYieIq/zD41KnHJO8vlinOhEmU6R0HPedX16USNQbbiRvc4+SJkmCwFO50QzV3E35p
	LpJJpSCLgV+37t5Npe3Vr76hyHF1WxJ2+qlDJFZKV4W5IK1IOW5b7aZe/00HVaQeVf0luwwzru2
	XJSQgryrZbj9MnnplQTmmIRGt1+yciHPSfaTlTI9hZuTWd4Kq2xQUy0IevMbNTmaAgTpZP1a9PT
	0nRiSlsgRPS+WoGrjEbXlBw0J9DlY2QBVb+I//dpqfdFEuunfKx+NEDInZym5ZS4lNiA7gc5IcA
	YEoq2T0Kc95T6Eh+C0a6LadwGr5Ss5nSO2dXrZIMF1guNHB3TLLXrzNmtRHphsXA0kuQ=
X-Google-Smtp-Source: AGHT+IHRPYkc1MlPFGGEAlWretJXF51Al2+6Y0BPwv0qaAGwG2dgoIInaQ2a6vgzFUgFMm90JKV6ag==
X-Received: by 2002:a05:600c:1ca7:b0:45c:b53f:ad9 with SMTP id 5b1f17b1804b1-45cb6fad54dmr42348385e9.33.1756992359303;
        Thu, 04 Sep 2025 06:25:59 -0700 (PDT)
Received: from [192.168.0.4] (ptr-178-51-192-26.dyn.orange.be. [178.51.192.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7eb05fd9sm283480785e9.24.2025.09.04.06.25.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 06:25:58 -0700 (PDT)
Message-ID: <c8137063-c928-45a1-aae5-9de2b35e5150@gmail.com>
Date: Thu, 4 Sep 2025 15:25:57 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] alloc: fix dangling pointer in alloc_state cleanup
To: Junio C Hamano <gitster@pobox.com>,
 =?UTF-8?B?44OO44Km44OpIHwgRmxhcmUgdmlhIEdpdEdpdEdhZGdldA==?=
 <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
References: <pull.2040.v3.git.git.1756472406487.gitgitgadget@gmail.com>
 <pull.2040.v4.git.git.1756941427825.gitgitgadget@gmail.com>
 <xmqqh5xibqvu.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?B?44OO44Km44OpIHwgRmxhcmU=?= <nouraellm@gmail.com>
In-Reply-To: <xmqqh5xibqvu.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

The point of the check was to avoid subtle crashes
aligning with defensive programming requirements.

If you lean more towards strict contract enforcement
Just say the word.

On 04/09/2025 09:47, Junio C Hamano wrote:
> "ノウラ | Flare via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> +void alloc_state_free_and_null(struct alloc_state **s_)
>>   {
>> +	struct alloc_state *s;
>> +
>> +	if (!s_ || !*s_) return;
> I still do not see the point of this check.  If the caller passes a
> NULL pointer, when they are expected to pass the address of a
> pointer variable so that the struct the pointer points at is cleared
> and freed, and the pointer variable is NULLed, it is called a
> programmer error and they deserve a segfault.  Why would it be
> better to sweep such an error under the rug by returning without
> anything?  It would delay discovery of such a bug, but for what
> gain?
>
