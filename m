Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79BAD53B
	for <git@vger.kernel.org>; Wed, 26 Jun 2024 12:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719405735; cv=none; b=hUblhDHgSYSIR7S9ewyyU54i5lkgX2SOh5A9gtsfHxLe93+PxJMec58HLzidDJAJYT87AKzT+MyER4FvGPCaZYIxKtwkjpxDScV3dez2GXFDvkK/gggnLxwqEWoug3ztd/OH65ArUJNuVU5CLtIwcVvEvXmyLx88L/R5p+tTnuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719405735; c=relaxed/simple;
	bh=s4pjhbLZfLHMfjUcswlrP7LupUipcMjaGer4hW8um64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JsxqenI16m02/p3xdzXSkw0z9uVDganYlx5/5HZbM8NumiFHmt55YX65/2+CwJLeZUQGMTcDRaNxZExPWV0X3gEZQsKL4D5QKokaZ4sS7nWikjPkjhDVSgMv43RRsVoBB7FIdQvvs7jP5/ywKx5Pld5gN5DjCczG4JnnHdX5mEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lioXit93; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lioXit93"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-63b3a9ff064so62204117b3.1
        for <git@vger.kernel.org>; Wed, 26 Jun 2024 05:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719405732; x=1720010532; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4N97sW8uv5RsbSB2iElx0l2IXDOJIPyt35akNmy82V8=;
        b=lioXit93E33n3BZpmGE5gnFUCkrozVBL5i0w13uoyDN9ffQrOpgTVlFo8u2FEWJTuw
         kYilEMMbjQ9pWLiwxPUMwM5AyAB7l7u5ZYCdTdBArpva4o4HrsA6hZBPth9jeaS2NhNy
         9ZUV6KDvAzk9xSSAc032zFIvREzG7yW4LDPyHb9vAuKaFr07cJqzRt/QSxZmE1uUF3ME
         0kPEPD7yGTrKDgYkqKxV2Zjy8rOG13Ez90At9NpDAX8bVjrv8OqECaPQrpSZ0G5luOZX
         tRLxN4wKciTDbttdYQmdhVvajUakr5zBzYjiMDvU2dI3hi0AkSRwof/L71DdY2/zMs7i
         qsVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719405732; x=1720010532;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4N97sW8uv5RsbSB2iElx0l2IXDOJIPyt35akNmy82V8=;
        b=fyvGzJK0kfZcSeBjIQ0YgKODt94EgVHjr94sGuagy/u9BoeH6hcSkjaCXigCiyZdfL
         GskxYQZvFMBgmVsZgFxLNa/M7b2r2Dx60xcmDJACZgyFVz8xfMdVTSI90Rf7RJIfJSpO
         +DjC1439/PufubKrEJpBw7VQlokoLndhCu8kk/8TXZMJeUL/VK2UQevIkgqOfuw+JGo4
         Em51Z+VWW1KZhBt7NhjidIOV2B2kSumk2hPyH2sWykTQmF2JF13kqgssQ15mwuDMa5tP
         dp9LdZITG7VOpCysVSkWqg12IA/fQadWMyiHkJYDMEXd+IvgzqhLyQDtlXamIjmF6STD
         dULw==
X-Gm-Message-State: AOJu0YwzcYvgs1qwNU/PEZwh0p8nl2TGlTjbz+0UBYK0m7guUjB3gZTy
	ZgkrP+le8r/qLkUqFEz7YP85VphT7E8AIZX5LPM6sunE3+xqLxk1mdfCWw==
X-Google-Smtp-Source: AGHT+IFTQstUW34/HXb8GhmOEn9wZ/rIg0G0CPjTOcMGCkhvCHnkriN/s7YHQktjUP+WoOArI23Row==
X-Received: by 2002:a81:a20a:0:b0:61b:33c8:7bce with SMTP id 00721157ae682-643aab82cc5mr96150357b3.31.1719405732484;
        Wed, 26 Jun 2024 05:42:12 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:5cca:8078:1e70:3d3c? ([2600:1700:60ba:9810:5cca:8078:1e70:3d3c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-64542cee8dasm17042557b3.132.2024.06.26.05.42.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 05:42:11 -0700 (PDT)
Message-ID: <a4edb8fb-5ed4-401f-819f-4034f67cd27e@gmail.com>
Date: Wed, 26 Jun 2024 08:42:11 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] sparse-index: refactor skip worktree retry logic
To: Elijah Newren <newren@gmail.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, anh@canva.com
References: <pull.1754.git.1718899877.gitgitgadget@gmail.com>
 <ddd8a9a90cea10be47eba4775bb90f01a9b80443.1718899877.git.gitgitgadget@gmail.com>
 <CABPp-BF=8y2yC0WvF7BhNFiyW10A_yKs5s6euEi3FwYSsmHnWg@mail.gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CABPp-BF=8y2yC0WvF7BhNFiyW10A_yKs5s6euEi3FwYSsmHnWg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/24/24 6:12 PM, Elijah Newren wrote:
> On Thu, Jun 20, 2024 at 10:11 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Derrick Stolee <stolee@gmail.com>
>>
>> The clear_skip_worktree_from_present_files() method was introduced in
>> af6a51875a (repo_read_index: clear SKIP_WORKTREE bit from files present
>> in worktree, 2022-01-14) to help cases where the sparse index is enabled
> 
> s/index/checkout/; the code in af6a51875a made no assumptions about
> sparse index being enabled.
> 
>> but some paths outside of the sparse-checkout cone also exist on disk.
> 
> s/cone//; it wasn't specific to cone mode.

Thanks for the context that this is a generic sparse-checkout feature,
and is not limited to the sparse index (which is limited to cone mode).
I made assumptions based on the code's location in sparse-index.c.

> Although I had a few wording quibbles with the commit message, overall
> the commit message was clear about what you were trying to achieve.
> Also, the change in this patch is a straightforward splitting of the
> old function into three new functions (one of which is the overall
> driver calling the other two).

I have reworded locally and will have a v2 later today with a better
message. Thanks for your attention to detail.

Thanks,
-Stolee
