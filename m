Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF15212562
	for <git@vger.kernel.org>; Tue, 28 Oct 2025 19:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761680361; cv=none; b=YJxw06tJgQzHqZQkhEvy5qhanUYz1VlwImLfYdqqWdiFdClIFM0XRXUx/9B/GQZQc/FyVmR20OYNfHVgp0KlbYff59kPEVEbjr/Cj80/XSe1fUyh78FcyZSDf+a8BIIxOe1jpNOXPqyGe0gaAiv4KT9HZI6+PcHguOraI557EB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761680361; c=relaxed/simple;
	bh=AFEQnF3ydW4JHJjGMUdbVsmZoo/QZ06OC66ePQSUXok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LkCvadVDVWK+wyOpY6yeuiR4XGzJS06lUuoTvhMSyBfHXnpr4WWMmbRBemyL2ctL/G3ImL+TkfioYPeKLgGInKdv4khN8bknNylaOvb/EXDepZbt9g5hjkQW3LDCeQAt71feOFnBeWDUJ8mAORiLLyUbo9VOtg63FxPIedBt9sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L6d4HfJY; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6d4HfJY"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-294cc96d187so19009745ad.3
        for <git@vger.kernel.org>; Tue, 28 Oct 2025 12:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761680359; x=1762285159; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=30LkskkLpRZeAwbkVyxnn3pmSA75O07ByZW3JQKQCig=;
        b=L6d4HfJYrqgkhmPzoGjfbqq4exUsQbJae+ydSKIipbJH2BBFw6feFRotf7mi9NNMYC
         tUDUlzDGSxCtDAdCsfKjBiGePVd0LHqRjydvzQmKH+VdofR8umdL5eKe9Zx3oySXfNxo
         W8sxiTM5EMCl63pWFjWeaJnDXuZn3WzoAoCG06foo4g+KdFHORxRKmR6I9zXmZYsU2QK
         gq+iBg9LcRsrWyLM8+B23vQB02In9kLm3EnznWu51q0eNBA34IIFPn9pnU2LrEZSuHwW
         sAjiG6uVJFvXTw8ZcRJHoz+yeMIKEe+bR8lFH2uMk+HnhWbVYjDkZ7VW/fAYUx3+Itxg
         i5ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761680359; x=1762285159;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=30LkskkLpRZeAwbkVyxnn3pmSA75O07ByZW3JQKQCig=;
        b=Em14yCc04kG6UnUgmg8+pxhB/RIFca4KLMzZW7+Ntmw18gwOeDStoDkwsUnqJyKn2l
         tTmtPIcuGNhCRfTaJs51mMHYCOJdwnDLTUffqe+LL+PqA2sX9WKu6p5yT7OYCKhE99Zi
         1ksK6vmvbOIASSkVNcpszB9WybioBcOoFGSy5v7kTRZk8d+EeG1HZT7yJc260reYjEyy
         2e/FagICjujvnjtcbXmUKwHUYHaYNEbjxp10zFopp4HNA+riON9pX5CoOgw3mdOtJsfM
         jjntgq42qgoF0ivlCIP/3Uzx2wRsfBZodss3ViDmaE4A7xT75obqtBbL2CPp8B/mLHBp
         g9RA==
X-Gm-Message-State: AOJu0Yx4Ozfk7cycLPKOzW31yBTemVvUdviruMDUPYKrvKjRWJtIhGbw
	c/pgoaoXsYJeOZjXCUVxHnuIvRYniDOa1bTP6IfM+np+nGk2Kp6E8IEq
X-Gm-Gg: ASbGncu9eBlPv6AG1c2+lklVRBBDfThZxVGxS1zebPn1RbzDDoN3z973KD5foVFh7DL
	J44vWl/hm2GXxMi/aJkz+cQHo2izAuaxzKglMQbh6ATf3IysJmdfJzrTKy7IUIQQ3X+CFCFiK4W
	mB9CcH7xAsoUCp7qtCexvSVcr8kLHtftOrrpoECyVvWmwhINHvj5QtPUvBWnYhiUYeV9uatj5ln
	X5wjexN7AM8IAi05aCXHdTO1Os+X25uDf5lT6xLCcKFSFS1rA2o8kd5CzYLEjpQpiav528i3861
	IOG7fluE2p+X5elsJFutuFg5O5X6plpljn0wcit3iluCBCL0AWGDuAyW9kggw43fsFrJDcfNTUb
	fgX1lfh553SdXG6ovYlV/mJiIL1ys95jHcS1vq2bCVIQcugvCqEHcVm1sMy51b7jqZoFiO01vo4
	cUVuEPoryzcRQQXDy9HnqHnbx7T+mYzIirkab3K+pJrhVFtTiHhsI8qhqgPiHrMZkQvxgeWyCuP
	WDC3pPVmyIjkwikYGxuhMC5IH154GW8J3suv+rGdKNEGHHkXtCXmE8tO9qlf18=
X-Google-Smtp-Source: AGHT+IGjoGa3ghR3hJlC5GEkmBd+3xpbZJHytwPITgvpQUhX6sSj5JnTlmgyvnNYSYqKmUc53Q8Ayw==
X-Received: by 2002:a17:902:d68b:b0:267:af07:6526 with SMTP id d9443c01a7336-294def311bemr2448725ad.55.1761680358496;
        Tue, 28 Oct 2025 12:39:18 -0700 (PDT)
Received: from ?IPV6:2409:40e3:177:42ef:798a:642a:892e:b13? ([2409:40e3:177:42ef:798a:642a:892e:b13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e416a2sm124949795ad.97.2025.10.28.12.39.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 12:39:18 -0700 (PDT)
Message-ID: <0c58d734-d7fe-4b2a-8231-c123b74601d6@gmail.com>
Date: Wed, 29 Oct 2025 01:09:11 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] replay: make atomic ref updates the default
 behavior
Content-Language: en-GB
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, phillip.wood123@gmail.com,
 phillip.wood@dunelm.org.uk, newren@gmail.com, gitster@pobox.com, ps@pks.im,
 karthik.188@gmail.com, code@khaugsbakk.name, rybak.a.v@gmail.com,
 jltobler@gmail.com, toon@iotcl.com, johncai86@gmail.com,
 johannes.schindelin@gmx.de
References: <20251013183311.33329-1-siddharthasthana31@gmail.com>
 <20251022185045.29256-1-siddharthasthana31@gmail.com>
 <20251022185045.29256-3-siddharthasthana31@gmail.com>
 <CAP8UFD00rE7gF+baidmoi7nYwVKa3UDQgj+TB4wJLtjJF7u9gA@mail.gmail.com>
From: Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <CAP8UFD00rE7gF+baidmoi7nYwVKa3UDQgj+TB4wJLtjJF7u9gA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 24/10/25 16:07, Christian Couder wrote:
> On Wed, Oct 22, 2025 at 8:51 PM Siddharth Asthana
> <siddharthasthana31@gmail.com> wrote:
>
> [...]
>
>> However, it should be noted that all three of these are somewhat
>> special cases; users, whether on the client or server side, would
>> almost certainly find it more ergonomical to simply have the updating


Hi Christian,
Thanks for the detailed review! All good points:


> Nit: maybe: s/ergonomical/ergonomic/


Will be fixed in v5!


>> of refs be the default.
> [...]
>
>> Change the default behavior to update refs directly, and atomically (at
>> least to the extent supported by the refs backend in use). This
>> eliminates the process coordination overhead for the common case.
>>
>> For users needing the traditional pipeline workflow, add a new
>> --ref-action=<mode> option that preserves the original behavior:
>>
>>    git replay --ref-action=print --onto main topic1..topic2 | git update-ref --stdin
>>
>> The mode can be:
>>    * update (default): Update refs directly using an atomic transaction
>>    * print: Output update-ref commands for pipeline use
> Nit: maybe it should be mentioned that the command is still
> experimental, so it's OK to change the default like this.


Good point, I will add a note in the commit message that since git-replay is
still experimental, changing the default behavior is acceptable


>
>> +--ref-action[=<mode>]::
>> +       Control how references are updated. The mode can be:
>> ++
>> +--
>> +       * `update` (default): Update refs directly using an atomic transaction.
>> +         All refs are updated or none are (all-or-nothing behavior).
>> +       * `print`: Output update-ref commands for pipeline use. This is the
>> +         traditional behavior where output can be piped to `git update-ref --stdin`.
>> +--
>> ++
>> +The default mode can be configured via `replay.refAction` configuration option.
> Nit: s/via `replay.refAction` configuration option/via the
> `replay.refAction` configuration variable/


Good catch, I will standardize on "configuration variable" throughout.


>
> (It seems that "configuration variable" is used around 6 times more
> than "configuration option", so we may want to standardize this
> wording.)
>
>> @@ -54,8 +68,11 @@ include::rev-list-options.adoc[]
>>   OUTPUT
>>   ------
>>
>> -When there are no conflicts, the output of this command is usable as
>> -input to `git update-ref --stdin`.  It is of the form:
>> +By default (with `--ref-action=update`), this command produces no output on
> Nit: s/By default (with `--ref-action=update`)/By default, or with
> `--ref-action=update`,/


Much clearer wording


>
> I think it's better to be very explicit here, especially as we mention
> `--ref-action=print` below.
>
> [...]
>
>> -       const char * const replay_usage[] = {
>> +       const char *const replay_usage[] = {
> Nit: Not sure this change is worth it, but I understand that it might
> help pass some automated/CI tests, so not a big issue.


Actually, Junio mentioned in another thread that the prevalent style in the
codebase is `const char * const` (space on both sides), so I'll revert this
change in v5.


>
> [...]
>
>> +       /* Default to update mode if not specified */
>> +       if (!ref_action_str)
>> +               ref_action_str = "update";
>> +
>> +       /* Parse ref action mode */
>> +       if (!strcmp(ref_action_str, "update"))
>> +               ref_action = REF_ACTION_UPDATE;
> Nit: maybe:
>
>         if (!ref_action_str || !strcmp(ref_action_str, "update"))
>                 ref_action = REF_ACTION_UPDATE;


That's cleaner - I will combine the logic in v5.


>
>> +       else if (!strcmp(ref_action_str, "print"))
>> +               ref_action = REF_ACTION_PRINT;
>> +       else
>> +               die(_("unknown --ref-action mode '%s'"), ref_action_str);
>> +
> [...]
>
>>   test_expect_success 'using replay on bare repo to rebase multiple divergent branches, including contained ones' '
>> -       git -C bare replay --contained --onto main ^main topic2 topic3 topic4 >result &&
>> +       git -C bare replay --ref-action=print --contained --onto main ^main topic2 topic3 topic4 >result &&
>>
>>          test_line_count = 4 result &&
>>          cut -f 3 -d " " result >new-branch-tips &&
> Are there tests with the new default behavior added? It looks like all
> the changes in the test script are about adding "--ref-action=print"
> to an existing test.


Yes, they're in patch 2 - the atomic behavior tests that verify no 
output and direct
ref updates. I should highlight this better in the commit message since 
they test the
absence of output (the new default).


Thanks,
Siddharth

