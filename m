Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9262036C0C6
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 10:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773397399; cv=none; b=JxmVYka9nSwm4Wi+J1AQ9pxh0smpll/GIuNiEvdzEhozShPdtRPaTD5jHi/XQ+7uB2mkwj+onD9g2sGI+xNXo9nSN1kaOGHOISQYQ6fkz18jYR0y/yYakPsYSi4tYLbMo583Nj0ZTy2uAn32KOPnDY9vHVxISW62FengUmqZbDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773397399; c=relaxed/simple;
	bh=0teB1kQrBXVGLW7r4xxk9kCU5Okf6z/zx/sEmKDQBrM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=E77alIratLKxKJwZ/x4wj3jp3N5jnVnqh5uAi4h/Nx8SPVr/bJC4LCRVPX/HvDUe7+92sXVo0f3pcR3rhraTrgbRosLI4XYwf7Rtj3HlhQc5n4f/AG31ALKUETaqUheoY4Av5W2oaLT6D9DmqTLT8i+8+0u/RKgdA4tAGK03Wjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i9mVMCOb; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9mVMCOb"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48558d6ef83so4536715e9.3
        for <git@vger.kernel.org>; Fri, 13 Mar 2026 03:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773397394; x=1774002194; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GdFOE2reJQVx72hOb9ML5MW/SU5tpdFWtECu6opO6Ps=;
        b=i9mVMCObrYlVCZ95vB2hpDUMILg6TeOad6ilx43b+Qyj+4wTfgCyKNuBPmfwIlLiNV
         2ncLpY64QJhjmJMKj6XtGDUuzfYfo7aEnVOTor3zzpfZIf297IFV41uu9jmjEfISd1mQ
         ythnxuiVQ93k+GXjp9dTvw0+YKuKQKjESFqW6qCOezyG9AhSFjirr9aYJj+KUohUksKK
         zuEG5WMmzMqUTFGlKBtrjQ14Q7JPI9FMr48rP2cluPtf5vzCC0dBmgC/2e1iCTGULQWf
         K68w2Xufd+L/gnzfn86Vm3OMq+ovxTPEigfafLU9egKUQgOVVfvXDq+v7KHZkwVkBhsF
         ogWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773397394; x=1774002194;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GdFOE2reJQVx72hOb9ML5MW/SU5tpdFWtECu6opO6Ps=;
        b=eOxV1FqKnxIUZieJKYUYt9bwjEDhhINkjW4xwrrv6ly+0wNuwFRn3qNeDczLq6U+nX
         /eSghMY0JSU2zRtaXkPihdURms58mMMKjKbV3cWyEJYxNteLXy//Pee3yQVcU4EmSAeT
         fTaT5pa9nL386kigmILa+8FuTucO0eziP7WOnAIjOMm5iNn8RIg9rNiHRru2JVsYKVjK
         Y5dolFW/E8rp+9Otd/lKw6yKCHC4TiOEIUZ0RDhO03gzrfKifze5VGPAvxhNo9+UmKKM
         3CGXoPge9o2XxmO/EMrjVj5mMDkTbHmHh1M35nbJHtGTG46r+QBvTsAScB8q6KCTduA4
         NrmA==
X-Gm-Message-State: AOJu0Yz6CZld+FKM0XlIu7bq0POx/5AScXBu2/f7AqRqodNJSj4KclzD
	YhbYqcNEzTGUsys/YP/aKjnS7zdLhPUiONTMAMuBG9sj7/tmvbHJrQpR
X-Gm-Gg: ATEYQzx3jqAClD046gF1JNXWcZBSf5ztIuuxDlOIEDSDxy3jKf1G6ZJNsZvHFPBg/2/
	xY1xPVUi8NUOl/Fyklp6mMvC71gI4ITR2hp8UeiZ06bmy57kqED5el7Kwh12ksycIhii7pzzfI4
	9OEFDH4v0QvdNpiJWc47yFXHpPODcRzaq+WtZI5cE4ObcQCmOFHFH6CuqOXmMyOMWZNYVyPXw1I
	Emyu6ZHHCE5zDPvNE8Psml2sYbROY0KCuunwxsYWEV+k1lzFB5izXhPH01sXzHFF89IzztCXEsU
	xDgvOQbCiyOeIbiEna/26z4ngbE8ZPZ56cfED6R1YMFtkwfjGCVnVZAwrjZ9UZhfr5RcEPfPKxk
	Gqg7R/m8MZsr5wpWxyAUyvGQk+9Pi3FBT6c0xeyamyHbZeQ7BpJvWawZls/ATNob85qD+CDACam
	SR7llTwWhXqbk7oVzMivEFyIPlv3+/fD7GnEnH5i40tB1E6ROK0UtUeoh5YW0PAdoYGXoW8iLlk
	ZCzdg==
X-Received: by 2002:a05:600c:c4ac:b0:477:7b16:5f9f with SMTP id 5b1f17b1804b1-4855670e7c6mr39749875e9.31.1773397394304;
        Fri, 13 Mar 2026 03:23:14 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1785:c801:9102:504:16e7:c44e? ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b6756e4sm229847265e9.15.2026.03.13.03.23.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2026 03:23:13 -0700 (PDT)
Message-ID: <016df393-a36f-4e5e-ab6a-eb661f5c84cc@gmail.com>
Date: Fri, 13 Mar 2026 10:23:12 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] xdiff: re-diff shifted change groups when using
 histogram algorithm
To: Junio C Hamano <gitster@pobox.com>,
 Yee Cheng Chin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Yee Cheng Chin <ychin.git@gmail.com>
References: <pull.2120.git.git.1765054287938.gitgitgadget@gmail.com>
 <pull.2120.v2.git.git.1772463265865.gitgitgadget@gmail.com>
 <xmqqikb08ax3.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqikb08ax3.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/03/2026 07:07, Junio C Hamano wrote:
> "Yee Cheng Chin via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Yee Cheng Chin <ychin.git@gmail.com>
>>
>> After a diff algorithm has been run, the compaction phase
>> (xdl_change_compact()) shifts and merges change groups to produce a
>> cleaner output. However, this shifting could create a new matched group
>> where both sides now have matching lines. This results in a
>> wrong-looking diff output which contains redundant lines that are the
>> same on both files.
>>
>> Fix this by detecting this situation, and re-diff the texts on each side
>> to find similar lines, using the fall-back Myer's diff. Only do this for
>> histogram diff as it's the only algorithm where this is relevant. Below
>> contains an example, and more details.
>> ...
>> This issue is rare in a normal repository. Below is a table of
>> repositories (`git log --no-merges -p --histogram -1000`), showing how
>> many times a re-diff was done and how many times it resulted in finding
>> matching lines (therefore addressing this issue) with the fix. In
>> general it is fewer than 1% of diff's that exhibit this offending
>> behavior:
>>
>> | Repo (1k commits)  | Re-diff | Found matching lines |
>> |--------------------|---------|----------------------|
>> | llvm-project       |  45     | 11                   |
>> | vim                | 110     |  9                   |
>> | git                |  18     |  2                   |
>> | WebKit             | 168     |  1                   |
>> | ripgrep            |  22     |  1                   |
>> | cpython            |  32     |  0                   |
>> | vscode             |  13     |  0                   |
>>
>> Signed-off-by: Yee Cheng Chin <ychin.git@gmail.com>
>> ---
> 
> Thanks for the updated patch, and sorry for nobody responding to the
> patch for over a week.

Yes, sorry for the slow response. I agree with Junio that this is 
explained well and looks good

Thanks

Phillip

> The detailed explanation of the issue and the inclusion of the
> repository analysis results are very helpful; they clearly show that
> while this is a rare edge case, it significantly improves the
> quality of histogram diffs when it does occur.
> 
>   - The removal of go_orig is correct since g and go are kept in sync
>     throughout the slide loops.
> 
>   - Clearing the algorithm mask while preserving other flags ensures that
>     user-provided options like --ignore-all-space are correctly applied
>     during the re-diff.
> 
>   - While ignore_regex and anchors are not passed to the sub-diff, they
>     aren't currently available to xdl_change_compact anyway. Given that
>     compaction happens before regex filtering in the main pipeline, this
>     is OK, I guess.
> 
> Let me mark the topic for 'next'.
> 

