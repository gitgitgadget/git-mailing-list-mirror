Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF00243378
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 08:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751273981; cv=none; b=J7eEnTCwaoLKB8WShCKf5LeDkvsYRsNQaPaJWzZuKrlDjhoJ4c1YQTqWGn6ZzDbLDn8roAkiZ9YVkWeaV8Czf1RMpgNGy9FSaqdfP9viSX7VWMNXb1ZFsntFQlMW1THFH2wC8h20MvUckE0afodZpxRbtGk88BFMiKwmKZel5aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751273981; c=relaxed/simple;
	bh=V1y1kvqlV+8ROL/Ex5j5gcIjmu1K6aLblb8YIcNDhfU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=tlCXsFcKIsPgYRSvFnDanJCuhGU34bX5vf0m23UQajkDKsxs4sbh8yQx9zvBD3b9tYXRVwEPMfYigFdZLe3akzI/jLsOyS0wwLgFSee9aU6EUhAKbC6gKe1qV+nrAR+nXZai+kq4anpphiv82vkR5LO6bctRZft4qggPbAd2UAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AHbkPMWz; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHbkPMWz"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3ab112dea41so837318f8f.1
        for <git@vger.kernel.org>; Mon, 30 Jun 2025 01:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751273978; x=1751878778; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ute3bz+U58z/ExPPTHQiFzi5kdy9d41j4rGktaDQFFs=;
        b=AHbkPMWzofZ/Lyh4PlVYzwYrUFDPTRATxDfDOT7qCJeiIQk4z6b0y9aSZEC/ok++2b
         Vm3GOZSIILJa8u5Bw4LyaBu7q8ZTqSy2xvjcU+DjwQXmCYyLA4EfdfowPMyZ6TS64DZl
         mElQA/r9VdB/FcSOoLjyuHNQg4OhKmUN44szi1l7o1PShN/GEeMga9I8vRMNgy2pQLV0
         qdw9ainOrUL+0fPe9CAKJLGT6qFRPxqfcITNAY8fbdaqsB5im6ArAtsbf3HA35B2jlSt
         oacovLY/GKC2K3KKCVm7Ho3jTJjsV6C/AboyCknQvGZJaPdykOoJmtNZmUqLUOxSxeH1
         JHAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751273978; x=1751878778;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ute3bz+U58z/ExPPTHQiFzi5kdy9d41j4rGktaDQFFs=;
        b=v/aSI7pCuVdxHFMWUpQBNF4EOBMoUUoRLuIVHRwnLNQi17MPMvOM/wJSRevGkz2vNS
         CJu6SkuDm8tHrewQBfo+JadmAkRsj3XT8MG6IJclU/WCG1clIzP1VW55q2R0GZ8RAptm
         jvmOssso8l6jPosQ4cmnrmN1ij62FBzaWoKjNTSRnknZgzks/w7MUO9ncG/P9EOBFtp4
         vz5T35IN+YflVYuGIoSwf++q5R/t6ciRXFrwKqYIET7fZrIszC2Fus6Pj79Jqr/88wW2
         ShpXdCgNa7lYaDqbcEMzFXkbZ3JC6t30MB27GFBisP5XzqwctmPZOjGWte0IL3w5JhXL
         orpA==
X-Forwarded-Encrypted: i=1; AJvYcCXNz/MXfpE8dPf4HsoXZ79udzuoySoRy4FitFvLYtgIUFhogf/e6UHffH0D2AXr6jSuINA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2/TIWxY7WV7B14n5JxuSYvN5a0Lc3Ym3HYZJBmO8KgU8XJAnG
	C+KfHyFTOo8CpGml0my5Py+oQwAvM3ch5Dc9BasPTq2e6DrJPO2ATjNR
X-Gm-Gg: ASbGncsusNvnYVf09HsMsCzsLKr+wBu0NnosOvdC9sEKPCu03Bczc4gAX5ZPqpVI85U
	LkFOHp3Jc0dQq7bB9I2wRbAzvVCWcZPlwMzB6c2nUsqaPUuW1feD9rq/v/a9ghYFuuASf1a7K+3
	qgyZxF2FPZ2SSPEKedn3ZL3k8m1VdyqVJZZoZd6YgtZjMaxz17W0Rc6zG4fQHOGXPSixREWajba
	PAKGJfIx4yriGrKqgLWPzohvN8sGuWnxqvHZRAsKElrNcQxqckYE//fVR1ij42RnxDZk1Q7fLkL
	xKa0NOqmmTpS+CIk90I8HZb/v24MWix/UgMcuh3CzrFrmySh9T7F7O4XPlerdOCOoZgP3SbO92+
	hrvaAFrJl8loFJlrI0pcH9qtemZiAPVaBn3pz+w==
X-Google-Smtp-Source: AGHT+IFpdxB1qYHo14v/dbAjeyeISnHSBlaL8PyHO2U0Y4AaRTiWYkGQsKNZEjcNPmPw7YXzUElAhg==
X-Received: by 2002:a05:6000:20c4:b0:3aa:c95b:d1d9 with SMTP id ffacd0b85a97d-3aac95bd1ddmr4548720f8f.6.1751273977902;
        Mon, 30 Jun 2025 01:59:37 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e52bbfsm9935442f8f.65.2025.06.30.01.59.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 01:59:37 -0700 (PDT)
Message-ID: <d25bf6c5-e56c-48d4-95b6-c714ee14ab78@gmail.com>
Date: Mon, 30 Jun 2025 09:59:33 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [GSOC PATCH v2] commit: avoid scanning trailing comments when
 'core.commentChar' is "auto"
To: Ayush Chandekar <ayu.chandekar@gmail.com>, phillip.wood@dunelm.org.uk
Cc: Junio C Hamano <gitster@pobox.com>, christian.couder@gmail.com,
 git@vger.kernel.org, shyamthakkar001@gmail.com,
 kristofferhaugsbakk@fastmail.com
References: <20250626132233.414789-1-ayu.chandekar@gmail.com>
 <20250626221631.457725-1-ayu.chandekar@gmail.com>
 <91982162-b138-4bb1-81fd-6f9185801c99@gmail.com> <xmqqms9t8cfd.fsf@gitster.g>
 <f39a3285-574a-45c6-9646-04eb175f4770@gmail.com>
 <CAE7as+aUcd65vPwwRh_C89vQbMjKQh0Y6LF7WDq1Whyj6iYfLg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAE7as+aUcd65vPwwRh_C89vQbMjKQh0Y6LF7WDq1Whyj6iYfLg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ayush

On 28/06/2025 15:33, Ayush Chandekar wrote:
> 
> So, my GSoC project is refactoring in order to reduce the global state
> in Git. I was trying to remove the global variables related to comment
> characters. What I tried is to create one single function which
> returns the comment string, and we could then pass a strbuf in case of
> core.commentString=auto. You can check my attempts on my fork here [2]
> (check repo_get_comment_line_str() in config.c), and also mentioned
> this in my blog [3]. I thought I had it figured out, but turns out I
> failed one test where core.commentString=auto. It was that moment I
> realised that I would need to remember the comment character or the
> strbuf in functions. Just wanted to share this in case anything
> strikes you when looking at the approach.

Thanks for that context. I'm not sure about having a single function 
that handles both cases. There is only one caller that cares about 
"auto" and the support for that has so many corner cases that don't work 
I'm putting a patch together to deprecate it and remove it when Git 3.0 
is released.

Looking at your code it seems to break the "last one wins" between 
core.commentChar and core.commentString. Also deferring the parsing 
until the comment character is used changes the behavior of things like 
"git -c core.commentchar=$'\n' commit -p". Instead of erroring out 
straight away it will let the user carefully select what they want to 
commit and then die which is not very user friendly.

Keeping the current parsing logic and storing the result in struct 
repository might be a better approach though we should think about how 
commands that run without a repository will be able to access the system 
and user config settings.

Thanks

Phillip

