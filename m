Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BCD3033EB
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 14:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769007004; cv=none; b=gnHW2fs9nHviVQKkQjs4WQvlM78hO8erbHez/QY1lSPCta+I/qR5EmdgKXYcyUZ2S31yFrKOccm+md0UjvcwzbBglG8ixyUpVyr7bAuam4CGxyR+65d9hV4lCMQtONN/J2NcmnajHD6Wx2IpxAvetMOGY8DDiW1rEYfe47frKtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769007004; c=relaxed/simple;
	bh=8VqLzqinZOyP4f2cnWh+N9ElMjqy+7g9DjwVPydsJ9A=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=pMYjCYFPHVS2IprHUL2l3bQmuyfWZuy92U/YSDFQcTRWNxedQTpAyvHNCT1yRRaCuSBfSaXnLX1nVhFOXlDFoXVmdzxdD02rwUTOstQdXU2tci3FEjgmUMV6GTY0fDCunEdzItAAtAyXEKP1PJwQA1NAu7mhCT/WgJoXOXU2tGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sd/VHwT0; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sd/VHwT0"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-47ff94b46afso9288515e9.1
        for <git@vger.kernel.org>; Wed, 21 Jan 2026 06:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769007000; x=1769611800; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:reply-to:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+7Pb8MvB0ACTKvgPwI7svFWqXxUQvdsh3HYhlPSaDe4=;
        b=Sd/VHwT0wlAEZBUgu5qx+Mg5MWL/BV+PjUnAuia/pTuwvVhhgKgqzBpvbJuFLjTpTX
         2U5G6JH4Dcay0RL+Jwzch3KY7FDpA7oiRSavT2WRQU/jyhWWgOX8vfVs7I4w1OXEccQS
         pI1q6mrPvZeMdPljFnKZvmLa60lQKcZjPaL91bJNbD0uGUMR8laDh5BZvaRL8crMz+Z9
         mMMWdAto5Dv1z+ZEfBzFqP0m+qwlJVnQz0lkHSnlYplgL5kUOCfnvMvQk3e4QHyBNCp3
         ztvYMWye2KTwuZcr9rLatYBb2obZE8F58+/UNoi98C5G86KehCtAineMMiZ76WB7yb0b
         kKWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769007000; x=1769611800;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:reply-to:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+7Pb8MvB0ACTKvgPwI7svFWqXxUQvdsh3HYhlPSaDe4=;
        b=MuKZkuLY5yaV1OMHLp+KcFf26yozMKYjiuhA0ZTAKt0JElbr4l6Ua1x3kT/fn0ooxl
         5MLVo7HNRhlJpK0UdrIIloHUq+Bk2KF1yAOI20vf/FUo71JHnsZmUsWURcjY5Z5LeEkj
         L5lbCXOVGYWO/7rlH0yHyCtq1pjivKwv+hQJSsj0jXSRuYVtVsvh/STDe9cejHShYy5i
         jvV7J1WsW2sAxv2WBJzNKoZ4rfdwFXjtRI8ZaTvEJI2hE35M/q5VrXDtQ1thMqfbs5t8
         EQsqLsx8cWGiDfjsmofxOLeR1vXpJC0yZS6tvPSvsDYrq6i9Rj/Luth5yUJmVLMCIrYQ
         UOkA==
X-Forwarded-Encrypted: i=1; AJvYcCUA5+JCryyoiKkvUQoM9Gm2J0oyaE2JXfWMcRh8vvAwvUOLg359LHNlnKc3xkpW2ZyDDoo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJgCB1yw+ot0uBhH6OPYqIb9iExx1toLJMVhMvrQADCSwhNqeP
	TiSYX6JsJE6mXhjX8xpQi8fYGpDZTuuJ8q/ZCNp/B9Ep/wAlO5neSCq5
X-Gm-Gg: AZuq6aII193PtE3PdQn/7SIM7K74LXo2+nDQAknKgrTEKbWW7JtaZiKeLB310nPkvys
	ZtPya/7KBcXPCJxLjQv6xh8g7oy6F47xXyOG0mKDz78duUzr6jyO4iY8sIpNPcFWn68zSGDBEdT
	M3hXLqOPGf96N9nUVGXhAWwYlwEJsnz0sD4M9P/T7XJfkPwRJDD48hAt/rLiXTRia0yc49IICZp
	zlLozyxtJykszjTHz/MPA1vck/SexLg4pFOcz7cZe4wrsW3xQ3ub1qQGWFgrTpo/qE4iBsbGYyW
	2kJNGhBpAsKnsLfd+POgtft6LfWww0b/ifk1b+OIPgvr7gAMb6S9JEXKyNHZa3hnYOjn405s9ys
	AI7o8LTAdVApjCB9Ds/m+/8ZzcPMPxkqsZkmTULnrEd7+SVafLpBVdgbKTTdgBK/AC4SrLbg1tJ
	4C9RHnEXnXNNhRYyD14qM4lf3uMTPAEjA1jXF6+ixRqemRBne3iMtupDPwFgYZsmOqiGlY+ME5w
	ehr
X-Received: by 2002:a05:600c:638f:b0:479:1348:c63e with SMTP id 5b1f17b1804b1-480418f1128mr62204435e9.9.1769007000080;
        Wed, 21 Jan 2026 06:50:00 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5? ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4802dc90068sm275016385e9.7.2026.01.21.06.49.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jan 2026 06:49:59 -0800 (PST)
Message-ID: <6d533cfd-d308-4004-8d8e-4ae730c76086@gmail.com>
Date: Wed, 21 Jan 2026 14:49:58 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 04/10] xdiff: let patience and histogram benefit from
 xdl_trim_ends()
From: Phillip Wood <phillip.wood123@gmail.com>
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Ezekiel Newren <ezekielnewren@gmail.com>
References: <pull.2156.git.git.1767379944.gitgitgadget@gmail.com>
 <70040ea1351451243be90d59d26cf1a403f3000a.1767379944.git.gitgitgadget@gmail.com>
 <f17adb7a-8776-42b3-b753-f6306145250a@gmail.com>
Content-Language: en-US
In-Reply-To: <f17adb7a-8776-42b3-b753-f6306145250a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 20/01/2026 15:02, Phillip Wood wrote:
> On 02/01/2026 18:52, Ezekiel Newren via GitGitGadget wrote:
>> From: Ezekiel Newren <ezekielnewren@gmail.com>
>>
>> The patience diff is set up the exact same way as histogram, see
>> xdl_do_historgram_diff() in xhistogram.c. xdl_optimize_ctxs() is
>> redundant now, delete it.
> 
> Does this change the output? The patience diff looks for unique context 
> lines and builds the context out from those. For files that look like
> 
> Old    New
> A    A
> B    B
> C    A
> B    B
> A    C
>      B
>      A
> 
> That will give a hunk
> 
> @@ -1,3 +0,5 @@
> +A
> +B
>   A
>   B
>   C
> 
> but trimming the common prefix first would give
> 
> @@ -1,5 +1,7
>   A
>   B
> +A
> +B
>   C
>   B
>   A
> 
> Though it seems like the diff silder causes us to output the same diff 
> in both cases for that simple test so maybe it is not an issue.

It does change larger diffs. If you run

git show --diff-algorithm=patience --diff-merges=first-parent f406b89552

You get a different diff with this series applied.

Thanks

Phillip

> It would 
> certainly be helpful to comment on any possible changes in the commit 
> message as it could have been a deliberate choice not to trim the ends 
> for those algorithms.
> 
>> -static int xdl_optimize_ctxs(xdlclassifier_t *cf, xdfile_t *xdf1, 
>> xdfile_t *xdf2) {
>> -
>> -    if (xdl_trim_ends(xdf1, xdf2) < 0 ||
>> -        xdl_cleanup_records(cf, xdf1, xdf2) < 0) {
>> -
>> -        return -1;
>> -    }
>> -
>> -    return 0;
>> -}
>> -
>>   int xdl_prepare_env(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
>>               xdfenv_t *xe) {
>>       xdlclassifier_t cf;
>> @@ -404,9 +393,10 @@ int xdl_prepare_env(mmfile_t *mf1, mmfile_t *mf2, 
>> xpparam_t const *xpp,
>>           xdl_classify_record(2, &cf, rec);
>>       }
>> +    xdl_trim_ends(&xe->xdf1, &xe->xdf2);
> 
> It would be clear that this was safe if you changed the function 
> signature to return void as the way it is called in xdl_optimize_ctxs() 
> makes it look like it can return an error.
> 
> Thanks
> 
> Phillip
> 
>>       if ((XDF_DIFF_ALG(xpp->flags) != XDF_PATIENCE_DIFF) &&
>>           (XDF_DIFF_ALG(xpp->flags) != XDF_HISTOGRAM_DIFF) &&
>> -        xdl_optimize_ctxs(&cf, &xe->xdf1, &xe->xdf2) < 0) {
>> +        xdl_cleanup_records(&cf, &xe->xdf1, &xe->xdf2) < 0) {
>>           xdl_free_ctx(&xe->xdf2);
>>           xdl_free_ctx(&xe->xdf1);
> 
> 

