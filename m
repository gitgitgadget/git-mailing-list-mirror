Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82838287C
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 12:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720443470; cv=none; b=Xrknzcx+8qoyrRqmQkM3PtZkoGKLN4hAWNFAfHwl0eWQuP6SrZ7s1qyXVbjTMFUuxnTdaYj8b9DfzP8L73RK7E0GWyBSIP9LZ27lTWa4MsRdzF+V+r6oFQuphNYqZYbStFBTieesxvz3rTUZbs988IKmbX7vY90EEt9vqIQP0HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720443470; c=relaxed/simple;
	bh=H+2N4BK5vUdJoLA6rROBChOHDJSgApEX357xELzPBvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KR73ySo8weKwIxgNeKCEHCVcWgKY2CZr96OPCFtN8ZJPBEVl7jJ2/0uBQjpFUN5h8h0og97IiksdsaaIaolQVIBtMp8CAvv23d4I5fiWwwy3V090PxmoA58ivzUAL2ybYXWaUzW6TFwyi4kUehUdUvfMAP4Fd0gwDNZHe2Y3LPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/bZWX8w; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/bZWX8w"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7035d9edcd9so1444623a34.1
        for <git@vger.kernel.org>; Mon, 08 Jul 2024 05:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720443467; x=1721048267; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kaN/HK2O1mk1b94peUgMNpwGZrPCoTlb8V147oaOvzE=;
        b=O/bZWX8w+pEiiAylSpWye3qjSfCg80XyA0DOwRrFO4LFUtJfD9/S61fbvt+g1cS2Ld
         bZoh3DREf0RgFmbUEoJsBmKjIDIDniwtOWrz3GnCCtLN3qyDPBFeKmnFaXGO7ujo6SXQ
         gv/Rn7g1Ef/VwZAqB3ZU2TBPEjFriM6eQS1UY5rtRWUXQP76miFoDW7ed1UhRVbB8+bf
         f6d+8XOIW06rtcNwQ4RfDCKGZYnw7VMSio92yVjul8DIJvl5udTCzfsa/z1VmFKEW1BM
         OENgx9ZWd6ylswBveM7BKhhFnL55Jy63Vmj5pc+VGIud7J+njV4EnhZPBpyCNWVdQJ5A
         CJKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720443467; x=1721048267;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kaN/HK2O1mk1b94peUgMNpwGZrPCoTlb8V147oaOvzE=;
        b=DyqjKd8lKRpdKwdKJ2Bbrb3Mb6WxaDrAwb5ETysuExMlrH8zwSFTinN6BOnkJ8RjOg
         erprDxjQWuXJRAyXkQ8imUwTlK5CbIbmZZtm8gHrRiGUkgkXewfVh8d6dML9s2gltpBL
         gQRJQdcQEIszHJLz4+CkZjUdo3UI0pulxuLfhXMpZWqG6bAmgatjBeBwKQXNcbFGlD3J
         ohk3tJ0U/2eOosJToDK8u3FLHjjJUplIAoMfueCWt+yi8s5Qj+Nf/KWXQwLDtfUvR1ch
         z+WKqNJPnSNfOjMpDjjVelMQMRfEsONuHXL7FzOmQ9snJJUsUUhmdoglqzhAvsuGrK9U
         5YOQ==
X-Gm-Message-State: AOJu0YwLypjEJNLbN/bo+DmsRM1kSKIedp2jAYMbJtH3fZ3TzlEXJKYY
	rzUepR/s/bx22g2SS75ye/MyCccMhR4DQmRVSraNF0Tubh5yRF5k
X-Google-Smtp-Source: AGHT+IE6jU94qZUpYZx9tzt5q72VXYJ8dFC3RxQNic4eI0E44Ld2r3R3C5t03zRYHA3m0cgAN7DwGw==
X-Received: by 2002:a05:6830:1e6f:b0:703:6996:c322 with SMTP id 46e09a7af769-7036996c3f5mr4004826a34.19.1720443467581;
        Mon, 08 Jul 2024 05:57:47 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:600c:8e1d:2ee0:c4a7? ([2600:1700:60ba:9810:600c:8e1d:2ee0:c4a7])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70365785414sm878749a34.47.2024.07.08.05.57.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 05:57:47 -0700 (PDT)
Message-ID: <8a0ea69d-861f-496f-84fd-4d62251c2771@gmail.com>
Date: Mon, 8 Jul 2024 08:57:46 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] advice: warn when sparse index expands
To: Elijah Newren <newren@gmail.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, vdye@github.com
References: <pull.1756.git.1720019679517.gitgitgadget@gmail.com>
 <CABPp-BG_udtdv1aCfJ7T_WmRExdD29ZVXD+cA6xOZYHofHDtTQ@mail.gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CABPp-BG_udtdv1aCfJ7T_WmRExdD29ZVXD+cA6xOZYHofHDtTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/5/24 4:29 PM, Elijah Newren wrote:
> On Wed, Jul 3, 2024 at 8:14 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Derrick Stolee <stolee@gmail.com>
>>
>> Typically, forcing a sparse index to expand to a full index means that
>> Git could not determine the status of a file outside of the
>> sparse-checkout and needed to expand sparse trees into the full list of
>> sparse blobs. This operation can be very slow when the sparse-checkout
>> is much smaller than the full tree at HEAD.
> 
> Yep, I'm with you here.
> 
>> When users are in this state, it is common that 'git status' will report
>> the problem.
> 
> I struggled to understand this sentence in combination with your later
> statements, though that may only be because I had some difficulty with
> later parts of the commit message.  Perhaps addressing the later parts
> will make this sentence fine as-is, but it's possible this sentence
> could do with a bit more detail.

I think also the issue with this sentence is that its thought isn't
complete until also reading the next one. These can be combined to
get to the point faster.

>> Usually there is a modified or untracked file outside of
>> the sparse-checkout mentioned by the 'git status' output. There are a
>> number of reasons why this is insufficient:
> 
> Fair enough; let's focus on why the output of git status is insufficient...
> 
>>   1. Users may not have a full understanding of which files are inside or
>>      outside of their sparse-checkout. This is more common in monorepos
>>      that manage the sparse-checkout using custom tools that map build
>>      dependencies into sparse-checkout definitions.
> 
> Having sparse-checkout patterns managed by custom tools is a really
> good point, but doesn't this statement of yours about needing to know
> particular files or directories suggest that...
>
>> +static int give_advice_on_expansion = 1;
>> +#define ADVICE_MSG \
>> +       "The sparse index is expanding to a full index, a slow operation.\n" \
>> +       "This likely means that you have files in your working directory\n"  \
>> +       "that are outside of your sparse-checkout patterns. Remove them\n"   \
>> +       "to recover performance expectations, such as with 'git clean'."
> 
> ...this is an insufficient solution?
> 
> I was a bit surprised you'd list your first reason for git status
> being insufficient, that users need to know which files/directories
> are the problem and then provide a solution that doesn't attempt to
> identify any files or directories.
> 
>>   2. In some cases, an empty directory could exist outside the
>>      sparse-checkout and these empty directories are not reported by 'git
>>      status' and friends.
> 
> This is a really good point too...but given this point, shouldn't your
> added advice message also mention "directories" instead of just
> mentioning "files" so that users are aware they need to look for those
> too?
> 
>>   3. If the user has '.gitignore' or 'exclude' files, then 'git status'
>>      will squelch the warnings and not demonstrate any problems.
> 
> Your solution does help the user to know that there is a problem (even
> if they don't know which files -- or directories -- are the problem),
> so this patch is making things better.

Thanks for pushing for a more helpful message. I'm currently thinking
that the core issue is that the working directory has contents (files
or directories) that disagree with the sparse-checkout definition. I
will update the language in v2 to point the user in the direction of
comparing the two.

Thanks,
-Stolee
