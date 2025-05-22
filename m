Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E65F2236E0
	for <git@vger.kernel.org>; Thu, 22 May 2025 13:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747920105; cv=none; b=tHbtPUnAih6adC8SEHrwKH5os5NeB1CLryFSd8q9JBF4icpJhoi4ijDDdob56uIF6tT635X0/YHdZYLIhjcyHxUmdpRtr/BKc3iTOVzV2drw2/Jxir6Vxx+/VOUh2xm7wT44IHHTLMmUfdJCrtk1rnHch61NdQEUYvidxZFMLh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747920105; c=relaxed/simple;
	bh=Mvw0zxsxZieQoc26phMj75kutjg+KPuY5F0dD+ImxV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=jAsaB2kQdb/ygtGOH06ZB+hC2qU6BfOvCWcRLchilYSdO9zz2aiccsgrImLrFVc+6DI18SpQmDE1vb6OxLGYpPMVNCMW+uvEy6bfJ60DX8uYUuNjhkS/qbg9sZR7BwZ7Nmq9ld6NiLlYKOfSP5olCUHR90Sj/oA2EIDQWR0u2DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dsTk8Igk; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dsTk8Igk"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a35b7e60cbso5466868f8f.1
        for <git@vger.kernel.org>; Thu, 22 May 2025 06:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747920102; x=1748524902; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E1mJLv9x0C1VmoFVdzq5GIROGBhFfc11wh+Do5IsGhs=;
        b=dsTk8Igk+4iuUpXlEVek+H6k1Jhh17ar6C4x0KtdWf6ZWmsy+wVSW9v/zJFQPIIYtc
         jATohi6mpFoEjU9k7Vfqzl5StmVu8bloY4/F9TyeevIkKFE2MjFm4KUUJASXIRanAGV9
         J51sv0kUOddeBxiFGDl4GCa0K1ULWXwAHtHwMO9ge/4NzD/h05+ADq6L77tsZ1ly1Zq6
         W2ihxRQSeRQ7xlal3gRx0knNnPtfV//Sf7EZLGzziEhrfAYhLWKtSTS4ZGeZRBnAiW9E
         HxTDY26sU4CkNzX+dMtijQUAeiYKtt/DkfT9ZpqDrzlKuxd7hNSKTuNEd+qOb4W0RM0+
         L10g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747920102; x=1748524902;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E1mJLv9x0C1VmoFVdzq5GIROGBhFfc11wh+Do5IsGhs=;
        b=r7QMfniAWcG2CBMqK1+JfYgxinfB2Qi5rgJm25voaNjkyTlIHBVXaTvH3U6wUaAqC5
         ry+MsLl6BH0TAyBYbzNKliKk0V4MYtTxMn1VJl7ySfgYetHrZ0wZqR4ydw/BwQMZsi9v
         myhlTtFK7NqNo+YU0KCI7/LOGYCbZQkQVEY+odpdWptT9x49Utvegf+j1biLcwFEd3tK
         LP4hQ6e5aELpWt+g3T7ZA93x9R+leVZ7CeN7tee9iCnBNkXa4/GVKlZUDvDizsW5hjtO
         pmZKn7nl4kWIA/VXLDk7Th9CgP+PyPfsVaGY7MbGiwZE5cfAtUPI3vQdHRJLcvn04alg
         Tg3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUA08IPTGB1KLvqgj3eg6ytvdC4DNZoYqul3p3h63lfcgtOVclQArBU2aTYAEGoppbTwyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXJSZwnGQp8vxl7WOBlJKBHhHybRNSeQ5LHGsGCSVVvCRZ/dYF
	HaqQVeIDefuncPtVcahfoMut26V8F7y487wwgdmjqQUK087tk0NWRd9k
X-Gm-Gg: ASbGnctInrEm98P93ty2/3egp5RCjdaIcuujRjCiGVP0sFUDNIhRZTJdc7zJJPiH3Ds
	nqmGgDnLJXThVVk547wh0B5lAmaloxuTvZ2bht5AxQkpCoGW52x+INrGdwsPOyQFEfCZ1MK1cwc
	wl5Mis5ymSNpLv9i5opyF6VvC2vJpNb6Nb22ehGzzmuNu2QmG5Ls4E+mzuXCtreAMgFPJKsgi3X
	53w5jq6pxtPoSD4E6tR+EXs8amHlOB6yavpQoLbRbu7Jjz95oEvosdTMGObNSTUMt7HK6WqxvyT
	rSj6c3+tbV7QOXyFkmMnkA6F0HS+zXOcO/nBaiGsFz+XazdrMZJ2uDx7AeuEk6A8WX04I0kexz4
	VY+OHt3eDNcS0Cw7QpOz8YeQ7BkSqCVj2hg==
X-Google-Smtp-Source: AGHT+IG5v3g80kcl05qOUW/Ji0WgIKVOQ1OZr99dDO8EP/9I5C4BP0oVYxDBcsb8Rjf3W6HxbP/Iew==
X-Received: by 2002:a05:6000:4308:b0:3a3:728b:b8f0 with SMTP id ffacd0b85a97d-3a3728bbaf5mr12997159f8f.8.1747920101932;
        Thu, 22 May 2025 06:21:41 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:efb:6e00:24f3:2d85? ([2a0a:ef40:700:a501:efb:6e00:24f3:2d85])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca5a5b4sm22770676f8f.21.2025.05.22.06.21.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 06:21:41 -0700 (PDT)
Message-ID: <aa1f960a-e7a5-4ada-84c0-fbf86a6c873f@gmail.com>
Date: Thu, 22 May 2025 14:21:38 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Drop git-exec-path from non-Git child programs
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>, git@vger.kernel.org
References: <20250520193506.95199-1-ben.knoble+github@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
In-Reply-To: <20250520193506.95199-1-ben.knoble+github@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ben

On 20/05/2025 20:34, D. Ben Knoble wrote:
> This has caused trouble in the past [1] [2];

Another way of looking at this is that the trouble is caused by a script 
that makes incorrect assumptions about git.

The assumption that the scripts from contrib as installed at a fixed 
location relative to the git binary is false. Where they are installed 
and whether they are installed at all is down to the discretion of the 
distribution that you're using. Looking for "git jump" at a fixed offset 
from the git binary is no more portable than looking for it in a fixed 
location.

I think that the assumption that git should not change the environment 
when it runs the editor is unrealistic. "git commit file" will use a 
temporary index to create the commit and sets GIT_INDEX_FILE when 
running the editor. This means that if the editor wants to display the 
staged changes by running "git diff --cached HEAD" the diff will 
accurately represent the changes being committed. Adding GIT_EXEC_PATH 
to the beginning of PATH ensures that the diff will be created by the 
same version of git the the user ran which avoids subtle bugs where a 
sub-process of git runs a git command using an incompatible version of 
git. There are several other environment variables that may be set when 
running the editor such as GIT_DIR if the command is run from a linked 
wortree.

To create a clean environment when opening a terminal from your editor 
you can add

     PATH="${PATH#$GIT_EXEC_PATH:}"
     unset $(git rev-parse --local-env-vars)

to your shell setup script.

I think the first two patches are very welcome cleanups but I'm not 
convinced by the rationale for patches 3 & 4.

Best Wishes

Phillip

> after attempting to help
> Git-for-Windows avoid that problem in Vim [3] by recommendation [4], it
> was suggested that upstreaming the change instead would be a better
> solution. Indeed, this should work for more uses/editors/etc.
> 
> [1]: https://public-inbox.org/git/CALnO6CDtGRRav8zK2GKi1oHTZWrHFTxZNmnOWu64-ab+oY3_Lw@mail.gmail.com/
> [2]: https://benknoble.github.io/blog/2020/05/22/libexec-git-core-on-path/
> [3]: https://github.com/git-for-windows/build-extra/pull/616
> [4]: https://github.com/benknoble/Dotfiles/issues/143#issuecomment-2869525481
> 
> I haven't managed to test this on Windows, so any extra eyeballs there
> are greatly appreciated. I'd also appreciate suggestions to fix the
> memory leak.
> 
> Structure: patches 1 & 2 are cleanups. In particular, patch 1 is essential to
> the tests in patch 4. I don't think patch 2 is strictly needed. Patch 3
> refactors a little to make patch 4 take effect on all platforms. Patch 4 does
> the real work.
> 
> D. Ben Knoble (4):
>    t7005: sanitize test environment for subsequent tests
>    editor: use standard strvec API to receive environment for external
>      editors
>    run-command: prep_childenv on all platforms
>    drop git_exec_path() from non-Git commands' PATH
> 
>   builtin/commit.c  |  2 +-
>   editor.c          | 10 ++++-----
>   editor.h          |  7 +++---
>   run-command.c     | 55 ++++++++++++++++++++++++++++++++++++++++++-----
>   t/t7005-editor.sh | 18 +++++++++++++---
>   5 files changed, 75 insertions(+), 17 deletions(-)
> 
> 
> base-commit: 7a1d2bd0a596f42a8a7a68d55577967bb454fec0

