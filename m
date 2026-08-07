Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D1D442363
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 13:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786108163; cv=none; b=mMu1cvKO4hwdk1Cfzk84e7jFYgx4H15Qifqqj72ELea67Q5TNtZuY4ibMonHEiD6OA89eS5Mis58ytLNr+L6UmWf4+0Q1VZ8JHu7XaCJLX54ooeN1t/rFYP13KV8E9RLrFC58mpNUmcZixr45yonaXzvErv/x17WosEu1Mihnag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786108163; c=relaxed/simple;
	bh=0NgCo0sIceF5SFepDJvEDjBs+d5fBSyAQe621Mk19Ow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lcASsFw93S4nGn9nRhCgIjRSbqzMN+pNV2SpVRuhRfvcFzHt3v3w/8qL2DaEVhfEFwbKXgAVk/yykVgZO0zcEg9baDptwrziJ1TqS2BBn7jhJOqNljpSKCTxUNrwf/RMOXEvY7/sCDPtKbgP9Qwj7JLmBUdniUGMd/lX9OBGpcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jMBZ8qBq; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jMBZ8qBq"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47ddf7b09e5so3205860f8f.1
        for <git@vger.kernel.org>; Fri, 07 Aug 2026 06:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786108156; x=1786712956; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gfrAsdvb0PzZARfdNiHPDdJZzLgBqCizmNOVRwURCI8=;
        b=jMBZ8qBqJYmQeYcyi2ONn08BoOGZUQDxoWQz4Hg3GO21oBiIdv/+t7YwBeOlirJi2u
         yn5IRZ+MOlO+gyngok/+wLkFBGwwfRE84PTAXc2GkpDwgBH/ryLA5gzOoQc5Mwd+37yh
         8beMSNa2tz+Dz9CRUx7+FbPEoSxvejYM3zRsyulWNG1DTJqtCaxxvbHd+28Y5DQRU/k9
         Xa7+XtS/s4JIvJIU1Ln552PRVZZNgDLY16mf4tVPSx7ZK0i6TRJ/A9qg0ZXqnCyITK6O
         Miw6Z1lPrhlDPvlK+yYHPHoWPVH2lBV8Kl6mtzXGvVVDdtS5iFS4UaejgXPGOzsQMWBs
         lnjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786108156; x=1786712956;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gfrAsdvb0PzZARfdNiHPDdJZzLgBqCizmNOVRwURCI8=;
        b=LlOptTv9YgH1ZtLRyNy2ZrchBPAqag1HTA8YopD62voiRTunfayHDLgrFn4gCBZX3V
         +NaA7uWNPj7vfgr6izgv449JELwMqn+gfy8gDVutphAm58OD/Rd17Nqe2TnDVJvNdp6V
         JjxRimv9mlBlcQfp/N2jBZ7XGQIKaeSJEyRkStNKQENXg2IKdUFsyNEX2x+e4HB80sBn
         Hjqf8YsREnENLbH62AGZnxANhekJsec+KCzJgm0/BuLzdltNqVHi6CAGD2zpr1JPXbjY
         0IlAI2aBB2YOTx1p5v0D0bCHmlSyv6PQscbm4REVRWGjvszifE+rV184DXjlJwGfI+RR
         UJCA==
X-Gm-Message-State: AOJu0Yx1nxFQjhPZyNiHGNp0yTWBQiWcW3JklLLwZYN8Gx9ZTQbd4hD7
	U45PB4mW+OF9tvu96Z/9+IVlh0n94XBExkgbG4ukJOtfm5oVaKJfW4zU
X-Gm-Gg: AR+sD11W8FlDpvcwu6YbjvBl8Z6e7I3QltuNjpQrl3ehd6mHkDkVIuUs3GI/AfIBQN7
	T6riYK2YSciBOiSJNIcMAZfs0MpuYQ9a4aSqY9uJdNtYUCrwXGi4Au8I4ZiUCzUO0JxA9qjLI0R
	SgThEoykKtFEPwPa4VJUZ+/ekmKFy1JlPKjTHXMxHGFGpBMzy0u4btAV+xAh7zYHPAwKo8L4tPp
	1JEyMdCIreehvwQVnRRkOEx8si/tRc6j1EZIIlF+9AN5R4moiZm0WxySPkFYXzp8yYmunQfMm7I
	jL0Ch3P5MUV7EL8nwnzy5+cdYrre+/wZUnPfn1Ed9d2CSAtsQnkJG9t+/qhC7ihR2rqW7YE2MhJ
	e034/WL3ckC4hcunz5bry9puCE24CUuP+/ksAR3Ob0w+9hIdnKTxZos+WyY2Kc07c8lEqY3CBmo
	T7Eyij3nKHxjWizDuBlovbDk8utsLpPtHGMLZ4yoozEt6fQWT3LhQF3dIYmBheyDbx4GSqIIa0Y
	AtXBN0XIoI1GEnwAhI/jYFg7nsCjBWP9Rm4vhgm2Xxy5gdMeSHMG94TKhiXwEmyyg==
X-Received: by 2002:a05:6000:470e:b0:47f:7f95:8a1e with SMTP id ffacd0b85a97d-47ffd203d5amr15826762f8f.5.1786108155471;
        Fri, 07 Aug 2026 06:09:15 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d? ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4800220727bsm5986865f8f.33.2026.08.07.06.09.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2026 06:09:14 -0700 (PDT)
Message-ID: <10b22a6b-e028-469c-a117-8dc2ed5bed3b@gmail.com>
Date: Fri, 7 Aug 2026 14:09:14 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v25 0/7] branch: delete-merged
To: Junio C Hamano <gitster@pobox.com>,
 Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Johannes Sixt <j6t@kdbg.org>, Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2285.git.git.1777671337839.gitgitgadget@gmail.com>
 <pull.2285.v25.git.git.1785939877.gitgitgadget@gmail.com>
 <xmqqcxvvjg5p.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqqcxvvjg5p.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/08/2026 18:46, Junio C Hamano wrote:
> "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> Delete branches that have already been merged on upstream.
>>
>> Changes in v25:
>>
>>   * Wrap long lines in tests.
> 
> The interdiff looks just as expected.
> 
> Shall we mark the topic for 'next' now?

It looks ready to me

Thanks

Phillip

