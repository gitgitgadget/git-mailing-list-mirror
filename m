Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295A642378C
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 09:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784107263; cv=none; b=jZRWq3gyaILGIHwQyX9pSv1ekz9BhGl04t+nL1zGRHoUa8KnPir32WjOk1+9XxOElVhxpJqoXHmervx+HijThLuiuqQcUCFFat4aKE84FMqmw+SqoS2+hcAFXr/PSt7KDhNFq3qHsGSDzc5GWBQPqOMTsfmjYsAe8p2fKRLKn1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784107263; c=relaxed/simple;
	bh=T6ALdVR54/9e05mWuhMt8hlavwB0hXVFoRBmxFHCUHM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=mZUfrnTHEjJEJo+zMglQILUBgSelP8mpiQkRYoIehWb7pY7VH9iCuTGEk/P/BVPPejJlTeiiP041fGa50Dy9UKffoWNywkDI6+BEF8bg6bTa1vMpz3FtQW/rRjKV2p5Oep2Q4FxJqg5l7/DNJRfBUoN/M6PLX2TE+jBKJIrwHsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tGQckHNG; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tGQckHNG"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4758bd3731bso1440103f8f.0
        for <git@vger.kernel.org>; Wed, 15 Jul 2026 02:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784107260; x=1784712060; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/Ak8Kfkhono6xqcM5PFv9YrbdEG26DSrx3DHkwCac3k=;
        b=tGQckHNGuRW3nNeBjvnz3bVh0FlnzeJtDdwdfVt9t5OZpFxwJb1bTmC4okkaobefgC
         ft0EXzYkGbs5caJKVwX19/RR8LvRFbt3OvLHEDeyuwiiehnf2Wb7SSUmXYGZMCI4Klm3
         PnS1jMc/IMJKCn6E7X2QSg4pA7y3Vt7dckh2UKO6SRgQKyzp2UvIcoGC+I+oMwcGAPRk
         BZ/3KvrhG/P1o4GzL17h7n0Y1wNWIObSeoaelElP2HdEXQ4xu/6w6fsuSEnCqy0aLXgL
         p+OC1f831mVJlNRnKX+UjMWg9DbQBi4Hg2PyD+GaGB6uZq4FUNAjS70R/WqjwGwdGJSK
         CU+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784107260; x=1784712060;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/Ak8Kfkhono6xqcM5PFv9YrbdEG26DSrx3DHkwCac3k=;
        b=PD8/prgDXaYWFVgPz8QZSJ12vbdd8pEed6+oZKPSfudGu+r3jMpBZZoIM/vQ6YHIIW
         Q/LkJyhlqoj/pJGJLd6VG0g/sBhHccfZXBkJbMnYqNP3kyU7qv5G8WBmTN2lrpk0IfVp
         jx389dSrs1TFaCccGA9z4/mHmVR/8ZKdYMLLuDJQaP2AcKdKUrRBdGPSqVCvAjv6EAyW
         HtOyKDRyRryWBBzQt5onMDKkNIriRXP/Vyrzka/b/rVGP8O1hfO+AaI6Q3Lgh0dab4Tx
         PvoWIdq3yy2T5aB7NCpULhJFxPoHuirud5VXfjWcXb/XjcTlq2EQbdX2J8j3+d8V8qxb
         JQAA==
X-Gm-Message-State: AOJu0YyUuMGr1iW4LhwEbFs1kR5r+r/WdPqFvDr5Tw9qsHLus5G3gEqr
	vRZDTzBJZa8dB5tVIlxRicMkRf2FO4FiMjeYXZ0o/nJU0gmgykATjZqNGVpblQ==
X-Gm-Gg: AfdE7cmc2Qw8Vzbad26URQFosmFiU+WAand3/jaW3l5vFI0c5ZfJYmbs+r/s8sfq799
	mqRHtxDLjts7Byz07FPs1W3rOvRhm8Weg5vtTvKqTv2zKjeG1w1CB0NyHd1reBHzdhsUx28rEJw
	32VPx5iXDx92nW6fiwqvyalaLBWf6ODVmOkRudxJ+5QsvmTSL60avtQAzAQ/L6dKj3igQ/0qqVp
	jcND88Htu7phZ4O6t5Z4B2CgGWyC0oPiOuboM/0AsRuzz4VVLZsSDR37nvgZ5ETycNjodqY0S3B
	hSTQ9Rb6/WvGlXMXk59DC1YczOQ8TM3UGPuF9twuaG/pXSmL5geUuIWSI9OGVF4i1gC+KBGHklj
	lF01Z6RDCLuG23Sv2FlG7CyDmt4GeNToVxKDSKpoXwD+QpkSSKNgVFChG3oMr6KSV7uB2s+JUmd
	QFCKzBengR9BeruWtp/uIcWsrdy631E6YJrBJbG6uiDXvnCtGOz6mTbSfMRwcmJNpca2Q=
X-Received: by 2002:a05:6000:2081:b0:475:f0c2:75ad with SMTP id ffacd0b85a97d-47f2dccc57emr20527375f8f.24.1784107259990;
        Wed, 15 Jul 2026 02:20:59 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d? ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464c1f84sm15328703f8f.29.2026.07.15.02.20.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2026 02:20:59 -0700 (PDT)
Message-ID: <5c9991e0-81f8-41f8-b78c-b436d4a494b1@gmail.com>
Date: Wed, 15 Jul 2026 10:20:58 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 06/10] sequencer: simplify handing of fixup with
 conflicts
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: git@vger.kernel.org, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>, Junio C Hamano <gitster@pobox.com>,
 Farid Zakaria <farid.m.zakaria@gmail.com>
References: <cover.1782833268.git.phillip.wood@dunelm.org.uk>
 <cover.1783948637.git.phillip.wood@dunelm.org.uk>
 <26dc48951cea663080bacf7d8d4760528125cbf5.1783948637.git.phillip.wood@dunelm.org.uk>
 <alTxn7MmX3aH_7gp@ugly.lan>
Content-Language: en-US
In-Reply-To: <alTxn7MmX3aH_7gp@ugly.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Oswald

On 13/07/2026 15:09, Oswald Buddenhagen wrote:
> On Mon, Jul 13, 2026 at 02:17:23PM +0100, Phillip Wood wrote:
>> Commit e032abd5a0 (rebase: fix rewritten list for failed pick,
>> 2023-09-06) introduced an early return when res == -1, so if we enter
>> this conditional block then res is positive. After the last couple
>> of commits the only possible positive value is 1 so we can simplify
>> the code by removing the conditional call to intend_to_amend() and
> 
>> call it error_with_patch() instead.
>>
> that part makes no sense, 

It should say "call it in error_with_patch() instead"

> subverting the argumentation.
> (as-is, i actually can't follow the logic, but i suppose it would be 
> clear with (much) more diff context. i'm not sure whether the commit 
> message is supposed to substitute for that, or the reviewer is supposed 
> to deal with that on their end.)

Its tricky because error_with_patch() isn't changed at all, we change 
error_failed_squash() to tell error_with_patch() to call 
intend_to_amend(). I've expanded the commit message to explain that better.

Thanks

Phillip

