Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4C4481A7
	for <git@vger.kernel.org>; Mon,  5 Feb 2024 18:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707158937; cv=none; b=B3qNDcF2ibGffhveihILyezUAb8tA8gGyzimFWwPLijChDl3VB5u1vMGR+t28Wy5RLJA0ry5R1tfURPm43Yu5FeZ6PjigaD+a31nxMHPckLYCe142od87YTqTFsXS+V/lk1ZKo/e+S60L1c7RBBBKOym/jrv2RstFoiC2o78bcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707158937; c=relaxed/simple;
	bh=GxjJ86S/tppn3Fa9nkIG1rGUsxHDIMHEKlg1bHahIvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iszVTnHu+BOWd7cojTJ8rtNUy1iSc3Ld4lVTkke5+TA/6g8R76dZZPHVJc1UTvwH5sKJ6iJI+8BHGhYBoeG5q4Ky3Va/PUpE6T+nccB4kIva18rtpJkc7Br/4EJHtSc13gw3uGFW2U8n2RkJciXycAkKmKplBENM6E06E2dIlEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GxErZVev; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GxErZVev"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40fe0641bb4so1278445e9.3
        for <git@vger.kernel.org>; Mon, 05 Feb 2024 10:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707158934; x=1707763734; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CFJt6cVyAxjmnOHCRZP3nIvchJbnFs9Z0azOAqZ/F5Y=;
        b=GxErZVev3RDNaadTj/2wzEdVyJnRSUelDw/bixW7xr7Wirp1AkAVDYJh7JoTWlIk52
         swQjlupMNxNxFegs+0QrMLMuPrfnK8hUxucpZNhPsXMgm+60MpwIpjmnVECe3iI6NDdB
         QeK6grznkSAJ8JtwTO7SNdPqwuFCesyXekA42G0bHnw85aqFA3zelPeOgljfxOlcqzNX
         7rsFRAbOAU4kAcs+yeG4oLXOjhZO6FPCuyjyicQ8sPScdxmjzGH7AxMgv5KAueVYBZ7f
         ptXeU6cXMiehR8dpxcmGNOfrOymzrh24Rl2I+yuDDUfM6N6/EiKb0+G6gfzHDtMHcw+/
         HJIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707158934; x=1707763734;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CFJt6cVyAxjmnOHCRZP3nIvchJbnFs9Z0azOAqZ/F5Y=;
        b=QHiKTKOEFq7FbpKppYErcN63Sh0mooJbNGNdsRQt+vpC3Ylt8HQ38FOuKr8C96AKx/
         SFLUp2mX7F4CvY281gPRL9bscjSNr5+NV6V4sTWtmvBm30Xc/sKnvvRKtw8upwOvw1Oa
         JQ0B57harmY9HWQUsL9kbsXwWYs5pkHqC1ZAhpOel1//2UbMzEdqoWszfp6r0W/gRku6
         HuuHzjJpMcq1cwDuVaYuUJs2x4TGe36VxGn7RvQDDfjTSzcA2ELju5yKzqJEiW1UWgJm
         OhRC5chlhriWX7/G0lnYdC7UB5FgEYiPPfPyDfl7auGZGNfiApw+G+ZlnBauwkVDJxUg
         I4Dg==
X-Gm-Message-State: AOJu0YzHgXElhsOzv56ozMkDZPpq6gZHb+zIgNtS5ZZV/lRHIpoWjoMe
	nfET6G3Vz2YzqVR75QvWC03mrm9p2CxkKBfxA1g2bOjbjqEpq1WR
X-Google-Smtp-Source: AGHT+IE5GrT1jZMRYLZ2kmqVcyetOn96PnJTW65GsKa2tosVnePxgjkv0f4vG7nI/brVJ1++ECjEFA==
X-Received: by 2002:a05:600c:294a:b0:40e:fbc8:401 with SMTP id n10-20020a05600c294a00b0040efbc80401mr502186wmd.20.1707158933430;
        Mon, 05 Feb 2024 10:48:53 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU++fpLzbUgJZM1f2A+SW3c5Mz524/DI3/IIgn+ll01mludsysE/vFVEMNe4yqJ+dP6ox5qvF7irqaC7mb3MV54pFy+WftP2b1TgFUnDQY=
Received: from ?IPV6:2a0a:ef40:62e:a901:d2c6:37ff:fef6:7b1? ([2a0a:ef40:62e:a901:d2c6:37ff:fef6:7b1])
        by smtp.googlemail.com with ESMTPSA id i11-20020a05600c354b00b0040fc76ed923sm9474980wmq.6.2024.02.05.10.48.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 10:48:53 -0800 (PST)
Message-ID: <98d79d33-0d7e-4a9c-a6a3-ed9b58cd7445@gmail.com>
Date: Mon, 5 Feb 2024 18:48:52 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 4/4] for-each-ref: avoid filtering on empty pattern
Content-Language: en-US
To: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, ps@pks.im
References: <20240119142705.139374-1-karthik.188@gmail.com>
 <20240129113527.607022-1-karthik.188@gmail.com>
 <20240129113527.607022-5-karthik.188@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20240129113527.607022-5-karthik.188@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Karthik

On 29/01/2024 11:35, Karthik Nayak wrote:
> When the user uses an empty string pattern (""), we don't match any refs
> in git-for-each-ref(1). This is because in git-for-each-ref(1), we use
> path based matching and an empty string doesn't match any path.
>
> In this commit we change this behavior by making empty string pattern
> match all references. This is done by introducing a new flag
> `FILTER_REFS_NO_FILTER` in `ref-filter.c`, which uses the newly
> introduced `refs_for_each_all_refs()` function to iterate over all the
> refs in the repository.

It actually iterates over all the refs in the current worktree, not all 
the refs in the repository. I have to say that I find it extremely 
unintuitive that "" behaves differently to not giving a pattern. I 
wonder if we can find a better UI here - perhaps a command line option 
to include pseudorefs?

> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>   Documentation/git-for-each-ref.txt |  3 ++-
>   builtin/for-each-ref.c             | 21 +++++++++++++++++-
>   ref-filter.c                       | 13 ++++++++++--
>   ref-filter.h                       |  4 +++-
>   t/t6302-for-each-ref-filter.sh     | 34 ++++++++++++++++++++++++++++++
>   5 files changed, 70 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
> index be9543f684..b1cb482bf5 100644
> --- a/Documentation/git-for-each-ref.txt
> +++ b/Documentation/git-for-each-ref.txt
> @@ -32,7 +32,8 @@ OPTIONS
>   	If one or more patterns are given, only refs are shown that
>   	match against at least one pattern, either using fnmatch(3) or
>   	literally, in the latter case matching completely or from the
> -	beginning up to a slash.
> +	beginning up to a slash. If an empty string is provided all refs
> +	are printed, including HEAD and pseudorefs.

I think it would be helpful to clarify that it is all the refs for the 
current worktree that are printed, not all the refs in the repository - 
we still don't have a way to iterate over the per-worktree refs from 
other worktrees

Best Wishes

Phillip

