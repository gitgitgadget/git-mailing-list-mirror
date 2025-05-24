Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D971E521F
	for <git@vger.kernel.org>; Sat, 24 May 2025 13:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748094819; cv=none; b=PKntvJSJlJt+udxAk9+Yuou+/8wx/1eo7/NKYc1tWFQXI5eLKyjNuM8o8P7vHEhDw7TKEw7ejA0geAXDaGS5zXBrKKA0QrWzA9RefDjFCB5yrHnHlcTAtTT2VOyXt7s95WDOCBUSfq7s1X467MHBN1YZhhVU+KBCeti7U9NcJ6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748094819; c=relaxed/simple;
	bh=2Tw0BJ4W6OHp1xIrVMgRtKMP/8XBwfpFxo3ozhfz4FQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=HFLvPT2ohJWEzpfo3tkoh7zpCJFC/CRjE50debpqm6O0lrOu5icJyJ4QahAfIffJJgC5379idSXe702t9NBpa2YUrPSoakJjcwFNuq0+IvdSSOqfCwCEr02wUzmLzAukCsrPakvl7LG7BNOrF2oRUHvCaDJQrV02uKYkVVX42yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mi0A5DWg; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mi0A5DWg"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-441ab63a415so8049835e9.3
        for <git@vger.kernel.org>; Sat, 24 May 2025 06:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748094815; x=1748699615; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:reply-to:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rdm7104MBIVpXHd9YfNCzpomTbMkSaC+PUVaD7r57bw=;
        b=mi0A5DWg7GCKKP1O2a0/YEYZM0Gyro6CGF4XtlsCzb+TZE0/ube4deQLzhbdXvrckd
         Q7M1oFxfaqrI4r8WaD/UuDZstetL4YR0zicBWTasJkFjN1SM7hnjH9B1Ek1kD+PdYJSK
         Ol9maoURh5BXOujzqJ0VYN5z0+DEaWpHPzeMQUuHwl7Nh6A3gDcNKCwYivOMzQhP7nGP
         8qtD8rizYe77fS4C/TQrVQPmJ+y3zdc5lk81IbjwVbBgDBj7Xy2EaTPcRmDFzyyHaRJF
         xSQTGNV9Sp5J9Mu9FiwB/LByKHy6AwvU3WdutD9skat82Rs74R5X1lefVJ2zGiKhbhD2
         eeAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748094815; x=1748699615;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:reply-to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rdm7104MBIVpXHd9YfNCzpomTbMkSaC+PUVaD7r57bw=;
        b=jktFnQBlGvww5gGnd+AXQ2QHTs1qze4ImHe2hoYApViwHDQ90V7Ptnvn+ftFnhfDVG
         gMVUL3ccC5Wzap8/8jIGOEaIcwYZIF4yBGoH/b39UV0MNv9vQ6jKZPU+3h7PAo0CYHxr
         033dzdGHWrgnMF9SV42lpefiztkX4kexVDTCXIlHvETn9E1peu9wvfMb79st73L/odC6
         HdaVHwXz9E2jgvKVRhPtgvb2QNEdeo1K7fO4hm4ZOeeJH+flo/N4OalZ0459zVxZKKSw
         L/zFSEngihAiWBaWdkyq6arTg5VNTyLQFvDI8wd20oRuVTL27QZzdOkMbbTUt5eJFb0K
         T6/g==
X-Forwarded-Encrypted: i=1; AJvYcCW5F3sMzLvT3pz4oajD7tV3UQD9kDqCi+1iWO4CBeOSvchiVmVxXYe6kR/eyDsPZ277m+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YySUgLUeMGdaD2+DRprTvTNqkhOy4+RisGR5G1IjtmmGJ/utAhE
	5xbUgfJxR8s2JATUkjj66re02OPoA87mc3uCyjT+cHPFUZa9/3I9lu+r
X-Gm-Gg: ASbGncsDkOgDvlydaJZV4eIbgC1J7WN1voU5T0/3IkSn3aRXNZQIkoNKVyA/flNEdR+
	xGZkQYqBZR6uLYAPI3Df1cJA2So8I7vNkKWiQ6q5ybM1TJM2VB8MQZ3f6aq3AkZQQ4gQibzAUMS
	tMy4JN9J8Y3+Xjk7LD5wGm4vkv2T6j40KIV8A9L7Ipc9jbiUfR1qUpJTWK2h/iAAb/adbvyV8/z
	+KGz11SMeBy349yodfTk0401PjMMOW8PIjBgGnezEZvyv4wJSuf+/xPQSpKBR32v/YE2V1j2R57
	nmTbq7dJ9ESPAMK4H0SpkHtu/6eLbLbK0iE9e4b9HQbfCBOZQcmxbT5IK4K2P0ifJOSrJ4fezop
	G9vSCnDjZa8Jj/djJZ+jDqeXOP70=
X-Google-Smtp-Source: AGHT+IEPKo+7ixDCxOnS0rN3+JEJgugsYWtC6OM16wuoJrgKVgIbIl3DLkuNlxnnd0xuFphwIYZUMw==
X-Received: by 2002:a05:600c:1e25:b0:442:f97f:8174 with SMTP id 5b1f17b1804b1-44c921a8f68mr27713465e9.18.1748094815272;
        Sat, 24 May 2025 06:53:35 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca8874bsm30248507f8f.67.2025.05.24.06.53.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 May 2025 06:53:34 -0700 (PDT)
Message-ID: <953dc362-f546-4f49-b580-b48a4a1370e8@gmail.com>
Date: Sat, 24 May 2025 14:53:23 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] Fix buffer underflow in xdl_build_script
From: Phillip Wood <phillip.wood123@gmail.com>
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 Alex via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: Alex <alexguo1023@gmail.com>, jinyaoguo <guo846@purdue.edu>
References: <pull.1976.git.git.1748033500935.gitgitgadget@gmail.com>
 <037b4612-ea92-45bf-bacb-ba66204f941e@web.de>
 <a58bf04a-d9fc-4ecf-96a5-82d31ada510d@web.de>
 <2b9c5e91-67ab-4e46-93c4-15c8b79841be@gmail.com>
Content-Language: en-US
In-Reply-To: <2b9c5e91-67ab-4e46-93c4-15c8b79841be@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24/05/2025 14:38, Phillip Wood wrote:
> On 24/05/2025 10:08, René Scharfe wrote:
>> Am 24.05.25 um 07:57 schrieb RenÃ© Scharfe:
>>> Am 23.05.25 um 22:51 schrieb Alex via GitGitGadget:
>>>> From: jinyaoguo <guo846@purdue.edu>
>>>>
>>>> The loop in xdl_build_script used `i1 >= 0 || i2 >= 0`, causing
>>>> `i1` (or `i2`) to reach 0 and then access `rchg1[i1-1]` (or
>>>> `rchg2[i2-1]`), which underflows the buffer.
>>>> This commit adds explicit `i1 > 0` and `i2 > 0` checks around
>>>> those array accesses to prevent invalid negative indexing.
>>>
>>> xdl_prepare_ctx() in xdiff/xprepare.c allocates an extra entry at both
>>> ends for rchg arrays, so an index of -1 should be within the bounds.
> 
> and rchg[-1] == 0 so i1 and i2 can never drop below -1
> 
>>> i1 and i2 are decreased in lockstep, though, so one of them can become
>>> smaller than -1 if nrec is different between the files.  And that's how
>>> this code run can indeed run off into the weeds.
>>
>> Actually no, i1 can't seem to reach 0 without i2 also being 0 and vice
>> versa.  Or can it?  It makes sense that we reach the start of both
>> buffers at the same time if we walk backwards from the end, don't
>> misstep and have consistent rchg array contents, but I'm not sure.
> The code looks like
> 
>      for (i1 = xe->xdf1.nrec, i2 = xe->xdf2.nrec; i1 >= 0 || i2 >= 0; 
> i1--, i2--)
>          if (rchg1[i1 - 1] || rchg2[i2 - 1]) {
>              for (l1 = i1; rchg1[i1 - 1]; i1--);
>              for (l2 = i2; rchg2[i2 - 1]; i2--);
> 
> I think I've convinced myself that it is safe assuming there are an 
> equal number of unchanged lines in rchg1 and rchg2 and rchg1[-1] == 
> rchg2[-1] == 0. Each iteration consumes any changed lines in the 
> preimage and the postimage plus a single context line from each (apart 
> from the final iteration when the context lines may have been 
> exhausted). At the start of the last iteration there are three 
> possibilities
> 
>   - i1 == -1 && i2 >= 0 => there are insertions as the start of the file.

Sorry that should be i1 == 0 && i2 >= 0

>     As the context lines in the preimage have been exhausted all the
>     remaining rchg2 elements represent added lines and are consumed by
>     for (l2 = i2; rchg2[i2 - 1]; i2--) so at the end of the loop body
>     i2 == 0 and the outer loop will exit.
> 
>   - i1 >= 0 && i2 == -1 => there are deletions at the start of the file.

This one should be i1 >= 0 && i2 == 0

>     As the context lines in the postimage have been exhausted all the
>     remaining rchg1 elements represent deleted lines and are consumed by
>     for (l1 = i1; rchg1[i1 - 1]; i1--) so at the end of the loop body
>     i1 == 0 and the outer loop will exit.
> 
>   - i1 >= 0 && i2 >= 0 => the first line is unchanged or there are
>     insertions and deletions at the beginning of the file. At the end of
>     the loop body i1 == 0 && i2 == 0 and the outer loop will exit.
> 
> We could add
> 
>      if (i1 < -1 || i2 < -1)
>          BUG("mismatched context line count");
> 
> before "if (rchg1[i1 - 1] || rchg2[i2 - 1])" inside the loop if we're 
> worried about bugs that break the assumption that there are equal 
> numbers of context lines on each side. Any such bug would generate 
> invalid diffs. I don't know how likely that is to happen in practice.
> 
> Best Wishes
> 
> Phillip
> 
>>
>> Are you able to demonstrate any out-of-bounds access with e.g.,
>> Valgrind, AddressSanitizer or an assertion?
>>
>>> Curiously, AddressSanitizer doesn't report anything, but if I add the
>>> following line after the outer for, I can trigger it to report a
>>> heap-buffer-overflow with e.g., git show 8613c2bb6c:
>>>
>>>     if (i1 < 0 || i2 < 0) fprintf(stderr, "Oops: %ld %ld\n", i1, i2);
>>
>> That's because I forgot to add braces.  D'oh!  I can't trigger any
>> out-of-bounds access or that Oops with them properly in place.  So I
>> let myself get fooled by a daring coding style. :-|
>>
>>>
>>>>
>>>> Signed-off-by: Alex Guo <alexguo1023@gmail.com>
>>>> ---
>>>>      Fix buffer underflow in xdl_build_script
>>>>
>>>> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr- 
>>>> git-1976%2Fmugitya03%2Fbuf-1-v1
>>>> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr- 
>>>> git-1976/mugitya03/buf-1-v1
>>>> Pull-Request: https://github.com/git/git/pull/1976
>>>>
>>>>   xdiff/xdiffi.c | 7 ++++---
>>>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
>>>> index 5a96e36dfbe..2e983965328 100644
>>>> --- a/xdiff/xdiffi.c
>>>> +++ b/xdiff/xdiffi.c
>>>> @@ -951,9 +951,10 @@ int xdl_build_script(xdfenv_t *xe, xdchange_t 
>>>> **xscr) {
>>>>        * Trivial. Collects "groups" of changes and creates an edit 
>>>> script.
>>
>> Trivial for Davide perhaps (libxdiff author), but not my mushy brain..
>>
>>>>        */
>>>>       for (i1 = xe->xdf1.nrec, i2 = xe->xdf2.nrec; i1 >= 0 || i2 >= 
>>>> 0; i1--, i2--)
>>>
>>> Should the || be a && instead?  From a birds-eye view I would assume we
>>> can stop scanning for changes when we exhaust (reach the top) of either
>>> side.  We just have to make sure everything from the other side is
>>> accounted for in the last added change.
>>>
>>>> -        if (rchg1[i1 - 1] || rchg2[i2 - 1]) {
>>>> -            for (l1 = i1; rchg1[i1 - 1]; i1--);
>>>> -            for (l2 = i2; rchg2[i2 - 1]; i2--);
>>>> +        if ((i1 > 0 && rchg1[i1 - 1]) ||
>>>> +            (i2 > 0 && rchg2[i2 - 1])) {
>>>> +            for (l1 = i1; i1 > 0 && rchg1[i1 - 1]; i1--);
>>>> +            for (l2 = i2; i2 > 0 && rchg2[i2 - 1]; i2--);
>>>
>>> Nit: The indentation of that line is off.
>>>
>>>>               if (!(xch = xdl_add_change(cscr, i1, i2, l1 - i1, l2 - 
>>>> i2))) {
>>>>                   xdl_free_script(cscr);
>>>>
>>>> base-commit: 8613c2bb6cd16ef530dc5dd74d3b818a1ccbf1c0
> 

