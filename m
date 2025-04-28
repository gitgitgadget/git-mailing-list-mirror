Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A05256D
	for <git@vger.kernel.org>; Mon, 28 Apr 2025 15:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745853738; cv=none; b=LJjTVTWbnllP3To0WHugMSgXHJ0OfwBjlC4D0MN9CF+JEKuWFAMlDd0rOTemi8cTLEUNh4mKsjOZIF6CujRdbmC0O2UJ6XqVtkvKmVlPuAJsKVepOfLrGGMTBPykfw8uRbgh1kLLkA1NXTRuXHykHfoLHacOapfpHHL0fdVe1z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745853738; c=relaxed/simple;
	bh=SFk8v78g7fzynKl8+CjLg6apJSOIe12wDAXwX7f2mR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DE8Yd7oPEl6i2PRN0l/p/hL6S8VIZby4k11JAzB+yH+gsJolSEcKudptpT0USX2o3jbhjT0cWD8043fLCI8j5yxo1AFEOXFv+qM56V/I3amjuobmthEH+IKu2nOkjHSmvraezldyKzmWoJkQ0iiczRwntaAqusTFaIPotwBTDxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VIapObLJ; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VIapObLJ"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6ff37565232so38489277b3.3
        for <git@vger.kernel.org>; Mon, 28 Apr 2025 08:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745853735; x=1746458535; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=guu84NZauHChpFneJ6LDTWjR8/lq4Qpn77kSdP3eshM=;
        b=VIapObLJ/mChwllXLUQqF9oxoIveiSLk9XmMHF0sOQhWwy3aeuGvC8NiCIzj+3QXIF
         rY0sIn+mfqQ4hM7wn3IIVEyWby96xJ0UMXKr2DJRnc/ZkOLFpiO/z9iUeO1yJY5TJjSp
         M69ma/ZQ2JPk4FkDBmNuyaysSlzJDdlzVd2fZc2hOScbQuayySz9tzB0a5O/JMF/hP/u
         3jJ49l7dGCUY9DLTzCDRLtKeZPG79HPvs4FkQBZVLu9kWcgu6H5PGWQe+wAIBdyJQVr1
         thGMut6B4KQdkdHG33ik+rpy3+rw6sWXUHnl6WVfmGC7rRa4c94kokSTEtsJg8UgbWjk
         AiXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745853735; x=1746458535;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=guu84NZauHChpFneJ6LDTWjR8/lq4Qpn77kSdP3eshM=;
        b=bnWtqnCtANldJ5CjGPKCqqFKiXnaMyaHYhIPKE16G2ixNx4DDszmIE++VRy0uJX76V
         idEEoSdfnCoc5wbvu1TgjFReqmJ3/t1MWk0H89wEeKR6LDwieGxgps4iCfE3FxBHUXMU
         TRZA4R5ChvMKunkyGDKKMlP1fR4tLlFmXRaF0AEsDLYfaqvzQWn+LSuh+/ibJ8jrx98y
         4s+k0ysvX4Z1Q+LBBP9TU8VThZ6QT+PnukRBsnwopTTxO/e9x0qLLn5CbckNdo8Ps8r9
         F/JN7hMUF4n527ZDPEL+6UxzVjLZLjCn6S9uy6fwBu0EY2V72zpxKDrq8ysYKh74ALis
         K6KQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkBS0u5G+s/Z2viS9RaFcJwWKolKBD+zLNKa7CxEm3QwkoPz7wUkmgMiLcy4FPy9pVaAk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4S/Yj1tf/hP5R17B4lJ/EGeuhJuIRtty1jeoLTafCRr7sntOs
	XpAXmdx/tpE6lgzRr37V6QYJWXpDIIMWIRJo+qH4FAOidoae9kZX
X-Gm-Gg: ASbGncscm7vm6GREl8PeYfQyvPHXTnmzz1Mzs9pstEVEMwJrUnsrmvsgUc66YIKevpe
	dl8WogfexwPpF6xTLYU+HPjgIJBZw/VuhpKSnYqKZ2bLI1f+M7sGeF4RUJHgDbbff29+EYkyzWU
	THbDHXl5h6S5guHkTjmCNHkBgBKxOZ+0hW2lTyg5U8yldO98Rv/2xM35dLH2SnwfKtL3aaFIvqQ
	8ikpXkU5cIzAEqMsko3ORBG/QeT9D/D8AoK5mTLXVAsmawH/1McNjqrFbPeYkOQ2IBJVM48Uhqe
	nIQ7itHqxjLguS47htHOo6E4+GP2yVGsPx4hpPCZeIEj35JzERF0No6Nu6EGVrP+u8nNIgeBZkJ
	0/agdhHCNtJVkMeei
X-Google-Smtp-Source: AGHT+IE8FSSMwbS6FsOGwFd20cZ+XS+sWdtW1InJzcCCbghg7+h+Llji2kwbSbMdO0PGFc+5orxPYw==
X-Received: by 2002:a05:690c:ed6:b0:703:b30d:3e2b with SMTP id 00721157ae682-70854117711mr164936077b3.20.1745853735200;
        Mon, 28 Apr 2025 08:22:15 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:2567:30ad:ba54:9d4f? ([2600:1700:60ba:9810:2567:30ad:ba54:9d4f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-70841acb31asm24534607b3.69.2025.04.28.08.22.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Apr 2025 08:22:14 -0700 (PDT)
Message-ID: <275808ae-7126-4a24-b5f3-283ea8023f5f@gmail.com>
Date: Mon, 28 Apr 2025 11:22:13 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] test-tool: add pack-deltas helper
To: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, peff@peff.net
References: <pull.1906.git.1745430004.gitgitgadget@gmail.com>
 <5d4beb202d6ed842de72928462a10a4f5faa2718.1745430004.git.gitgitgadget@gmail.com>
 <aAsQwSfr-YvS2Mvh@pks.im> <090ef16f-42a7-8de6-a79e-5a1958e2c103@gmx.de>
 <aAtZuU6Qqfag6OHj@pks.im> <xmqqbjskurz5.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqbjskurz5.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/25/2025 12:27 PM, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
>>>> Is there a reason why we don't use `parse_options()` here? It might make
>>>> this tool easier to use and extend going forward, and we wouldn't have
>>>> to care about invalid arguments. Right now, we silently accept a
>>>> non-integer argument and do the wrong thing.
>>>
>>> I think that `parse_options()` would be overkill here because:
>>>
>>> - This is a _mandatory_ argument, not an optional one.
>>>
>>> - The required data type is `uint32_t`, and `parse_options()` has no
>>>   support for that.
>>
>> Support for that has been merged just this week via 2bc5414c411 (Merge
>> branch 'ps/parse-options-integers', 2025-04-24).

The thing that confused me even with those changes is that this is a
_positional_ argument and we don't have a way to say "parse the 1st
positional argument into an integer".

>>> But you do have a good point in that we may want to validate the data type
>>> (even if technically, this is not a user-facing program, it's a test
>>> helper that is used under tight control by Git's own test suite).
>>>
>>> Consequently, I would suggest this fixup instead:
>>
>> But in any case, I'd be equally fine with your suggestion.
> 
> Yeah, I think we clearly showed our "it's just test helper, whose
> callers are supposed to know what they are doing" attitude, but with
> proper helpers, it is not too much additional effort to do the right
> thing.

But with this philosophy in mind I can change the CLI to be of the form
"--num-objects <n>" to use the parse-options feature. This should make
things more extensible in the future.

Thanks,
-Stolee

