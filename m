Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5601914D439
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 14:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729001407; cv=none; b=Zmema643Zc31XzJij2JjV0SZu18UQh9eJyrUWudPQCVAbyq/2MbL3ZE6h+eoh6kfnJVQtnd3K7aTHupkt4k2bAxhLOaCfofgfI69S4c+r7ZBlUZvUya9d+zMFp7IHBUYpQV2NFstqEdwKTJXjEXa7Txhu/BcYbf7aQB0gOmpOyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729001407; c=relaxed/simple;
	bh=BESwIDkYVdmQHKFuUQhRkvUb7LM4ujDMaOyK4ZoEWeo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I/XE4evNYBGiaSvi/7KtW2EyWe/HB+rFl4JZucjunmq5WgMTfZap0uDchiZlxM5nGzrjVTy/Fm4ZctPwf0VcbBiXwZIVz/Ni5Y83VCAvbPn/TyrazJ/KEdpsvfgiA0Rgvu9R7y2g2Rs7b3JwlAKbYPbblyU8AmPs5bcp3m9A0Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M/005Q0V; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/005Q0V"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4314c452180so324075e9.0
        for <git@vger.kernel.org>; Tue, 15 Oct 2024 07:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729001404; x=1729606204; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SsRyEv7jHGIG2v+G5oEiwySJo8CPwEIBtCYVk2WNkOw=;
        b=M/005Q0V20KmKF9YTP82vNgVOwWoGgY8o+eNasJU/7swj4Of2nrvlAhpNW26D4X/y0
         vvffxZCjoJdqK0hQ2GlXkHau8GAGlWm6awo4u6I/IO7abnWUY0SJW4jenmIq6O02c/r3
         MzauFW+ngDjuq+QOFJGCS3zhLAVrHXBy/oGrwxtgTGY6NehCwGE6Uso/i+xbhpwpHi3R
         ENZ/mzak1qaezv19rFDTmTI660Ax7dW8Ox3jFCp8WPt/P6uPVusHa4OkTmoBxh+t0COE
         nnrBxSNpX25ZMmFIaRyGZnW5HYoqn7WiIyqxO6IlLXtUduCpedx4ARDJwG7xh6N+HCJT
         TLFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729001404; x=1729606204;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SsRyEv7jHGIG2v+G5oEiwySJo8CPwEIBtCYVk2WNkOw=;
        b=Dmisu18bSqLxfByyV69fKZsXD3vhAxEembc/ohk96Mo9s7XLTts5qtPYhe2dIwkbmL
         QHrhdMQmmGXdCza98jHcJdTDJVLdoqX8tvHAzomNBq9OwCmjhP21X+D7+5D0yVLEaRdh
         1r/ABLfVkZnltgS9Lnptie6ntSH0oObfhnPdMQXoBTHa2x5dfBbqKmDH8bYs+4GBvFM0
         wSFM7roF9+7NxnVQEhx27xL+cMDI+/ObaZT4JM6JAocIjiDVth8tBxt2R+LSnGmJCUaG
         73DbjBG6jF5YdIxirg1U8Zfj5qAVQ8vnZCJAxP0tVow+KgiX05KN4fIemy9Z9WF63qTE
         TuEA==
X-Forwarded-Encrypted: i=1; AJvYcCXYu/hlIBsZoE8XvF8uhnUexcQYV+9coZF2mCYchy3XHlq+8yhxSXt9MDtQXZ6S1NWXoc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjoKB6lrCHyz0nws0baQajLR92rzbhHnhBtmNR6KMpgS7ROvsC
	kHVI6ip4AHjfopB7VBg208Aoog6wuawdlSkz/WSnHrl00EzaNP+G
X-Google-Smtp-Source: AGHT+IFXrfQmek+DlXrbyChy0XiQQ1aBfu7zo8taAmH4mwc12Cz4PE3phmQKwlVhBvG4nbXyOHUjSw==
X-Received: by 2002:a05:600c:3509:b0:42c:b54c:a6d7 with SMTP id 5b1f17b1804b1-4314a381fdemr6682445e9.14.1729001403416;
        Tue, 15 Oct 2024 07:10:03 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6ac:1101:589c:aac1:dc59:c13a? ([2a0a:ef40:6ac:1101:589c:aac1:dc59:c13a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4313f55e054sm19376675e9.4.2024.10.15.07.10.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 07:10:03 -0700 (PDT)
Message-ID: <65dd8e08-d8b2-4abb-a141-002d8f0b0401@gmail.com>
Date: Tue, 15 Oct 2024 15:10:02 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v6 3/6] set-head: better output for --auto
To: karthik nayak <karthik.188@gmail.com>,
 Bence Ferdinandy <bence@ferdinandy.com>, git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk, Taylor Blau <me@ttaylorr.com>,
 =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Junio C Hamano <gitster@pobox.com>
References: <xmqqzfndndfm.fsf@gitster.g>
 <20241010133022.1733542-1-bence@ferdinandy.com>
 <20241010133022.1733542-3-bence@ferdinandy.com>
 <CAOLa=ZSV50OkDC2p5AHHW0u+fAtLMcCX36W1SuT8AnTkX7HNZg@mail.gmail.com>
 <D4SUTJDV0Y04.3Q8YED2MVOKBL@ferdinandy.com>
 <CAOLa=ZQY_a_dEZQ2EcLVfE_5Kjy7b2R3OFbQHQbkzH0o9-q1JA@mail.gmail.com>
 <D4U6L3C2GHZG.2SN8P0C7ZH33M@ferdinandy.com>
 <CAOLa=ZRfku-J2HO8MOqu-dZspmCZDV1S56TD1X-zUy5=9+XSUQ@mail.gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CAOLa=ZRfku-J2HO8MOqu-dZspmCZDV1S56TD1X-zUy5=9+XSUQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/10/2024 08:51, karthik nayak wrote:
> "Bence Ferdinandy" <bence@ferdinandy.com> writes:
>> On Fri Oct 11, 2024 at 22:43, karthik nayak <karthik.188@gmail.com> wrote:
>>> "Bence Ferdinandy" <bence@ferdinandy.com> writes:
>>> I mean simply this
>>>
>>>      git remote set-head --auto origin >output &&
>>>      echo "${SQ}origin/HEAD${SQ} is now created and points to
>>> ${SQ}main${SQ}" >expect &&
>>
>> Ah, I see in other tests this is used, but not in this particular test file.
>> It's a bit hard to decide which is more cryptic, but ${SQ} is nicer on the
>> eyes. On the other hand I would either switch the entire file in a separate
>> patch or leave in the '\'' here as well. Or I guess one could go through the
>> entire test base and switch everything to either one or the other for
>> consistency.
> 
> I'm not sure I entirely agree with this sentiment. Consistency is a
> great goal to target, but it shouldn't hinder changes that are
> beneficial.

Exactly - if we wait for an entire test file to be modernized before 
using our modern test idioms in it we'll be waiting forever. It is much 
better to introduce the use of things like ${SQ} that improve 
readability as we add new tests or modify existing ones.

Best Wishes

Phillip

  In our case, if you make the first change, there is now
> reason for upcoming changes to the same file to also use '${SQ}' and
> eventually we can reach consistency of using '${SQ}' throughout the file.
> 
> - Karthik

