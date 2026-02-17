Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5FE27E06C
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 15:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771341784; cv=none; b=jcr5zHRWwUTugnjjjbmoTcePH2NHo6tkyucpiRjKebJehrTg/3R5fHHnLGEOoJTMDWMCupsCejLwlaD3CS0tAylbjTTYCTRlR48CzZ9BXDNYdodi+ct1KXOqppGwCK9B7TNfQlZavG9PxBUBFUBrPzv5qqwd7F8+bWG6q+yr4wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771341784; c=relaxed/simple;
	bh=34TTggst1SKvIkJbSweNY8+Ogu6AOH4yI5OHrxoEBgU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Mv3cWHTwIfi6UAmCtRZdaPXDXwt5IlMyPKmwiI9/6gdsGxV0XPr/Y2imDYbgcsClePNIYrYxV99wqpca22gY6UoX/nvMNIxGQti/WduH13LC4skGraIPNalInYjDSXZSYptmP0xfm9pT8yk0z90rup/sLGXXNXqF0GAbLMASFlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JHJxFjjv; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHJxFjjv"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-43638a33157so4202233f8f.1
        for <git@vger.kernel.org>; Tue, 17 Feb 2026 07:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771341781; x=1771946581; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mZYBmo8uKPwg5fW9MmTR2zHusgfpQ7aQa8rbnva3jso=;
        b=JHJxFjjv/6pWIH1tIMvjKohqQrxvCGsS3Am5glWf6QltADdeElHwdpiR1wQKL+cRQv
         YPHlJNDt8jO3Tde9kPamTW9PCKESE8Bt6FO1a5EDyWAhiWc+wzqHIT6ySNCwVUMxs1EX
         H9GZccUUDOw8qXBx86vXLHd6CdIeKC1J/PUb0VvRjRmFOw79yAxCQTNkwsa2n4FMfhND
         5AC10iPYh8/eWvHrYIhZRLz8/3azKvo4l6Z7LtcBzEiRP0I4G07QDqpc2wsSurnztrnN
         4ck96aFVp3hk8UeqCNKWKv5giFTCCEuTi+Gl6g24PaecrwYoAK1jB+5nxku4W8oHTgWy
         pg0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771341781; x=1771946581;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mZYBmo8uKPwg5fW9MmTR2zHusgfpQ7aQa8rbnva3jso=;
        b=GchyD5GuAqQsUkyBZAhlCCCZVoRmWzPQN4WNsiFwQrF4Ftx31s/ccjRiTvSaovk4Mf
         zaS5KDjhbaQjvv4LJmqzItIPg9Ch1wqoYDyJT7wk57SHq5Tdd9n/fmuBnGnPQQhZwYJa
         aCtNUZ9CWcitXKT1ceL1E5knqoGkXeHLjAle7RkFG8dCcOLJNYFzqCLqpkyEjHNH3fas
         7kixfFEGQ92zSTD0bwJPiHYBmybaSTl9gDZwF8ThTfSczNBJ8tm/gOB2//jQ/eWZ4Upg
         fjRNcmNTnqP5m5Z6aEEsAYvB2MJOw0LejYXVAqTgnsOKOCex6KyubAjqHVq8B2H3S/cM
         2Kgg==
X-Forwarded-Encrypted: i=1; AJvYcCWRWJmTCV4WrDEGqTX84J0UDQTbQmnk4y8KwMagxCkC7bUDSvuXA6/zWp8RbBJNVXRkD8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YygMDTPIEE1ETn6K6rGygyisg0gdmPn9yzq4PC250mxr3M/ppl3
	KRx1xigqxFs4PmLMDkFtP1Bg+7/pahc5TiJuVi+UuD75MS0tdhvKpsUR1C3hFt7h
X-Gm-Gg: AZuq6aIz57GPYi86begOyBwI9x3RyunScwKfEpmBzJ+IhQizIMshx3ij12Mf9rsVfa4
	JYk5EMuK/rSSXRejvOQUGG3c8/BWhtNyoLYv5+N21/tw4thSKnLWtX56Xw9pU/eFhK8U614iXDR
	hHnpe7FH/lUf/8PnEPLt8vRUYSOwZ5nz16R9WzFFr9lHRwxfME37EuP4BK16Nj4nIGZJGWKW5pt
	/Hct8do017m/IwANuOTSusX+eCWCNpWosM8b39DjT1/rXED//ruwsj4HdF7oox83+/5Pxlwz2GW
	qgMvSOUYpSPmEXC7+qfAK8kssiZ6rlFKAJNfKxI/G0z8SV2v6UKXEOMc8RhlQuRqZYYD/LuT59L
	fnPKvfueOpHxTKzt8utFMabZP6UKGqNAblhlvQggmzlzN6BD1wEedwiWiyrAlBYs883Zqn99GAW
	mttsv4oBILDQ2U1CucrNUHnlMaT2O1g7xjgu6h/ltut/NcRDU/ydNURqCHXuFnKhdrfMgC9QxC8
	s99EA==
X-Received: by 2002:a05:6000:603:b0:433:2f55:7cab with SMTP id ffacd0b85a97d-4379791ca61mr25916989f8f.37.1771341780760;
        Tue, 17 Feb 2026 07:23:00 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:68d:f601:6840:9d65:3109:8533? ([2a0a:ef40:68d:f601:6840:9d65:3109:8533])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-437969fd36dsm37093121f8f.0.2026.02.17.07.22.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 07:23:00 -0800 (PST)
Message-ID: <d7fe45b3-4a75-4a28-aa0e-74619fbe6a2f@gmail.com>
Date: Tue, 17 Feb 2026 15:22:59 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/2] worktree_git_path(): remove repository argument
To: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, karthik.188@gmail.com
References: <cover.1771258688.git.phillip.wood@dunelm.org.uk>
 <20260217101242.14688-1-shreyanshpaliwalcmsmn@gmail.com>
Content-Language: en-US
In-Reply-To: <20260217101242.14688-1-shreyanshpaliwalcmsmn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/02/2026 10:12, Shreyansh Paliwal wrote:
>> On 14/02/2026 14:30, Phillip Wood wrote:
>>>
>>> I think that we should add a new function
>>>
>>> struct worktree *get_current_worktree(struct repository*);
>>>
>>> to worktree.c that constructs a struct worktree using repo->gitdir etc.
>>> The worktree id is the last path component of repo->gitdir when the
>>> repo->gitdir and repo->commondir differ, otherwise it is NULL. Then we
>>> can use that function to get the current worktree rather than passing
>>> NULL when we call wt_status_check_{rebase,bisect} from
>>> wt_status_get_state().
>>
>> Here's what that looks like, the first patch adds
>> get_worktree_from_repository() and uses it to avoid passing a NULL
>> worktree to worktree_git_path(). The second patch then removes the
>> repository argument from that function and always uses wt->repo instead.
>>
>> Shreyansh - I think your patches to clean up wt-status.c can probably proceed
>> separately to these if you remove the changes to
>> wt_status_check_{bisect,rebase}().
> 
> Cool. I'll send a revised version on the original thread.

Great, I hope I'm not stepping on your toes posting these patches. By 
the time I'd worked out what was needed and checked all the callers were 
passing a non-NULL worktree argument I had the code changes and commit 
messages so I thought I'd post them.

Thanks

Phillip
