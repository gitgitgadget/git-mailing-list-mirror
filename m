Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D8F13D503
	for <git@vger.kernel.org>; Thu, 26 Jun 2025 15:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750951159; cv=none; b=NvoPjwuB+4m46vphX9ZWkBx45leCVeTWltfTo6t+j7kDPNvXKPF5m7rnvu2Z4uXfYO8gypgIVL26n8TVJR84jLwW6RgfHzLXvjx4nU9UcDH1NisHJuC6jIq3Q6To8GtE06iKUKV+ZzZeZMn7JP20Qb1djEwERtwno6tv3TComjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750951159; c=relaxed/simple;
	bh=AGZgNPlpzXr04pqjaFAxgWthEh8CwHoT0dI0hwIfBhQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=CCT51gLHj+dehYXgEwQhboRgs6UtM1nExxBym2PQZAxPhsXtP1ZCT5bDQSh3r0XENloLuzgfn6yV6VpqBNz54GO6Q/+qu8jkOyGCWKkfN1G6u/+DvT57rpP1pN8ozSE/zG2zNdBUcE3SsNK57GFf/kG4H8znIsOBWEecuu+yec4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gDrZmUoD; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gDrZmUoD"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-450ccda1a6eso7647335e9.2
        for <git@vger.kernel.org>; Thu, 26 Jun 2025 08:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750951156; x=1751555956; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jIqSwcIMBdQDc+V4pdWhHLDrUrs+8Q92x/dlGzmobGg=;
        b=gDrZmUoD4K4ZPuxlvPTedcd47i4vdC5bLYuZSXwR30aMig/U9l1NNphC/ugbZW6TCt
         yHLEgi+NFQoE7j6Z1hxKDMOvJCJ37QSfGdOoXHu0TENvEKB+CgAfsthCx4u/ZvPXdy45
         X7lJf4ZTvFNvSYUjJ5Ht8yCrmOuaVGau+fUbxJszTFj7uhH0BLKN16tQ4p90BkkK/yEs
         B6MiR1Q41r7mrf7+duiLLJUhR4r0hrLsy1HX0MtUXzWrAe13iLOPqRCCOe5ka1gsRlhd
         Lqz/2Zv98OBEOHq4XmMDD3c1KhnSRBS2QtPFQn7eqzWNVlB/0EQg1fzmbzpmn6RzfUHx
         bg9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750951156; x=1751555956;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jIqSwcIMBdQDc+V4pdWhHLDrUrs+8Q92x/dlGzmobGg=;
        b=t5PaySDkqUmS2oIIpRNLSPSkMlvDBbUq22ZkiiiYbn/mX4lKOCPZHFRM5PpTp85tbq
         KC05apE04SuCQ2TBUg9mCCIOZTUa1M64RLOaPYJ9DxGno/ZGpimbtHaKgY3ApOOe1pF8
         K0cLR4j6jm01yfY3yCu0b+sCqNz9hph2J76Sg410Yrp5IpnH2FMx0Okh5gz0AVvwUYCR
         NCRfLzkDNYYzxnInmq5TBIg/mRgTqiWv4zvZzhzGSyItuY9HTh3WpfovdnieoZLmhLAW
         fHJXwQA20/Z+yiCAMqMqCGmCvf0i/plVtl71td6NNm6CrHsarV7VnD+pA4YtuXJwPsjk
         DU1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVuIQhOzSXmyjaPJMasWq+ggZseRQAHNDp8+Xt01D22YiUJVmpp3Ej2v5VVh6OK9+IxZjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHO/E9m6VUuKz+0BufHwzv/JP+SvtA7VNc00crpfYOJ4nGoXV/
	6eJ/XJG6A4GGalTig6MIMHyK0tIHotpJWaBbpfg98AIiIZYXrGniXAk8
X-Gm-Gg: ASbGncsMctK+j3TmXPoJR9H9XbbkziWmhUBOLGAyQlqaBtqVl8C3nH8WPLqxpcaLitV
	0FbwKRhutOIgZjfngDAnc3VR1gNeXYEDeu7gQ34eYDeGgh7yMqDs/Mf4dALnMob3WjLAiDBC2wY
	BOC+4pkAnhHln5PI5yWwRUFEc43jbpALLfEomf/Zwuj/ubPdRb0pW8cw0RGYUU42PCzXzG9/vjo
	XZmA5kOZJ8I/G7t7qE0pDG/IocxXSKpHOcnMBAOUyRbwoYhibGUZ+CRGXL6bkzVglT9Fw1kOCm5
	SIWO8THWF1Fq4jZXd9KEgtBgdH3eHDHMk4lqyD2/0mkxGKqpK53q89i0quLNuD8W5aMFd3/GtRV
	ni9juZ+IQ95Y3irFCPVljLeYhJdS/3dXDiqQ97g==
X-Google-Smtp-Source: AGHT+IFzRexplxjXglrT34vQ+8lmeZNTRuGSsQ8shhJT9YCNSYh7c+ff2OKJZWddudGhQT1jgRIwgw==
X-Received: by 2002:a05:600c:c177:b0:453:aca:4d05 with SMTP id 5b1f17b1804b1-45381af0ae6mr85811555e9.31.1750951155517;
        Thu, 26 Jun 2025 08:19:15 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a4235cbsm23363105e9.38.2025.06.26.08.19.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jun 2025 08:19:14 -0700 (PDT)
Message-ID: <0dd51eab-8869-46be-beca-238a616dd6f3@gmail.com>
Date: Thu, 26 Jun 2025 16:19:11 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 2/4] compat/mingw: allow sigaction(SIGCHLD)
To: =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
 phillip.wood@dunelm.org.uk
Cc: =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n_via_GitGitGadget?=
 <gitgitgadget@gmail.com>, git@vger.kernel.org,
 Chris Torek <chris.torek@gmail.com>, Junio C Hamano <gitster@pobox.com>
References: <pull.2002.v2.git.git.1750836928.gitgitgadget@gmail.com>
 <pull.2002.v3.git.git.1750927988.gitgitgadget@gmail.com>
 <3f63479119ffe6fdcf694dac3cb47cd7838564b7.1750927989.git.gitgitgadget@gmail.com>
 <49cf7749-fc86-4829-8e94-c1f1e87803aa@gmail.com>
 <qizh636elher65bsdzkiqohzyo23tmon7hxcl4jcuftculbtm6@nupmqjy3igja>
 <a1fb8c27-6ddf-42d5-a062-a9710f6cc1cd@gmail.com>
 <o6cihjnfj4q6uiks3syovjun3fcijvsqto444osw7tgtpkttvt@42r37athz2tw>
Content-Language: en-US
In-Reply-To: <o6cihjnfj4q6uiks3syovjun3fcijvsqto444osw7tgtpkttvt@42r37athz2tw>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 26/06/2025 15:58, Carlo Marcelo Arenas Belón wrote:
> On Thu, Jun 26, 2025 at 02:56:22PM -0800, Phillip Wood wrote:
>> On 26/06/2025 14:15, Carlo Marcelo Arenas Belón wrote:
>>> On Thu, Jun 26, 2025 at 01:52:47PM -0800, Phillip Wood wrote:
>>>> On 26/06/2025 09:53, Carlo Marcelo Arenas Belón via GitGitGadget wrote:
>>>>> From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
>>>>>
>>>>> A future change will start using sigaction to setup a SIGCHLD signal
>>>>> handler.
>>>>>
>>>>> The current code uses signal() which returns SIG_ERR (but doesn't
>>>>> seem to set errno) so instruct sigaction() to do the same.
>>>>
>>>> Why are we returning -1 below instead of SIG_ERR if we want the behavior to
>>>> match?
>>>
>>> By "match", I mean that in both cases we will get an error return value
>>> and errno won't be set to EINVAL (which is what POSIX requires)
>>>
>>> In our codebase since we ignore the return code anyway, it wouldn't make
>>> a difference, either way.
>>>
>>> signal() returns a pointer, and sigaction() returns and int,
>>
>> Oh right, I'd forgotten they have different return types. I think we should
>> probably be setting errno = EINVAL before returning -1 to match what this
>> function does with other signals it does not support - just because our
>> current callers ignore the return value doesn't mean that future callers
>> will and they might want check errno if they see the function fail.
> 
> I agree, and indeed had to triple check and change my implementation after I
> confirmed that signal(SIGCHLD) does not change errno on Windows (not our
> version, neither of the windows libc or mingw, even if it is documented[1] to
> do so.
> 
> It might be because the signal number itself is bogus (there is none for
> SIGCHLD in their headers, and git uses their own numbers in compat), but
> either way, I would rather be consistent with signal() at least originally.

I'm not sure I understand - don't we want the sigaction() wrapper to 
behave like sigaction() would?

Thanks

Phillip

> Carlo
> 
> [1] https://learn.microsoft.com/en-us/cpp/c-runtime-library/reference/signal

