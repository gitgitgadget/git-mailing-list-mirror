Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E26333342A
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 14:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771424400; cv=none; b=kG116tEbfedTpYGbZryV88yCFAYeoMz2Sfpogc61k3UBlc5V3JiNKT+Yio1OTGgvvOZbmc2zPY9y2kNJ4x2IobGr/w1XFot4hbl/njL91LTlgpucqZEa8eu+mI3NMZ/kqnFg7GRb0/5peyq82S+uiFKqUU7mo6Vsj8n28ACx8Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771424400; c=relaxed/simple;
	bh=2bpxqihq2sPj6ha+N29EH/wRbY6Y06/BN4VZ+YuuyPE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=OGQm4ISe+7d3lt0fB5w2dCin/WEP3D+ADFIP1U17VKyQ2WZefEja8Y3lFxg2VE6eb2vpIamZDeRwga5QXvzmmGi7GYyXcOiQbXVty0KGufKaIevJO0Hic1QxxC2sJWg+x94lsBJAqiCS3Dq0fmSDKeHkhj2WBCgE36b7eSXDYjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bmo7Vr0C; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bmo7Vr0C"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-48373a4bca3so29741595e9.0
        for <git@vger.kernel.org>; Wed, 18 Feb 2026 06:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771424398; x=1772029198; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fhvW51sfFXq7t/eI3n2OZ+hZ4W6WI6Iu47q4c6weC+Q=;
        b=bmo7Vr0CZUZ9OqpI4zE7vMcaaZuCqLfQEkcTu4VGRE8Hnb1C8Cd+HNGXvO+fUdCK/C
         VX4beGxSub5Bhoc5MO0Uz4eShA+L8P0imer/uuTRLJ5SMag48pzEdZKwcl6puanEq43n
         HaLbfCxiOF3CgFTRN7K5NKS6vFPUuoMM5WbpantXDWw5TzWuO30poP/hPAakcQrUwaSJ
         93OannPhMR4Se0sOWYexGkLoeTVrwOfpVhywMK/WDJXazRzAYWIVpe8vkttbmQiG+gze
         Liu5UdlsaAqYHSPhHX3ORnHWnTz0+6iloCAiStZW0DMcoIh0/jwp4So/7TIU6n0KzrMU
         Rgqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771424398; x=1772029198;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fhvW51sfFXq7t/eI3n2OZ+hZ4W6WI6Iu47q4c6weC+Q=;
        b=jLqeGQIUl3G0xVPOShJ6c4o40k36VqCADICFRDHsXb5PJVHHr+2kRMWDRMLbEZ9vM1
         1OkqW8ILAdpC8RcDQn5ch1GiqToTFqy3CfIfqVpYKL44jYcNvIqebupr25DztWmZuIGk
         +RtceE2rPUUYsRLb0yg3ilwJ5pDNA+Y/dTUcVQBgzZ5ZB8nQLMbb16DU85DZETgSVkNU
         786eQVCmqc2n0mE/ghuGv/Y5/VgGY+Mg619ujltoBFY3vopka8dzQ1xrSET7/ODnu7Uz
         +zOT2ITieiz6J/slDnaPRU3nFAkK9oW8iTSxEKzWpBYYl8P9RuwaqzNucG7Koy6iOLlk
         6S6w==
X-Forwarded-Encrypted: i=1; AJvYcCVqZW8qV2nX9sv4OYhGpqVznqSuVf2y/rG2vTPtx3CSi9jhQy98FBQvQvC/zZ3q/nBX2y8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIKZXuGC3kB0LAqPZfIFpWRraxSy/EiX/XGZVWLwxo9sKVu4WR
	WIKUeFPAABZPxinD3KziBAvU+KNfKnSWFx+NezkmaQY7maaAxPg6n4ibvkSur031
X-Gm-Gg: AZuq6aLzbNd1s2xpLDAk6/O58bBG2tZ2tf6HGpDo7i8H+UZeLKl08jJhDK7FD2apwQm
	jw8qp+u1l//cLwHQLmUK84dAfypKbfmKOz0vUG+P7TY68EhuLa9roAk4X9ByptiMQuk9cgVTbHi
	ACQxqsiEg/7ONqCXGTu7sdBaT6PcRl/MhqzFvLI9DGg1RI+S734JD/+xl4r/NhklNYqmjCuBa1K
	qLwaMGw+XCOvGlSKhypWWhJ2sZhX3lJHHUkfgkg06sdBV+ElHIPNrZ0huVR7FD9pUot9fFYM1UM
	J0A2cDSNHyoeoPAJERuaMt84R0+qW8CH/KmRUDG81wnOASzGRvMJRW8ZdBky0kqRqXBiMp2xUck
	dnKs+9hwoFqJv52pn2XONN1kLHT/vjpvMMGx9zDRlvX7crxXooQYvWlViClrMOBpvxjMsACZ1vf
	1oZx0LR2q2hro1g/8h10tsaCtYygLdF0EILiKEipkAo8/DEnzbodQhYdvZn1Q7igCeYHq3xd0Fs
	uI3ZQ==
X-Received: by 2002:a05:600c:1912:b0:480:69ae:f0e9 with SMTP id 5b1f17b1804b1-48379ba54aemr264491015e9.16.1771424397427;
        Wed, 18 Feb 2026 06:19:57 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:68d:f601:6840:9d65:3109:8533? ([2a0a:ef40:68d:f601:6840:9d65:3109:8533])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4836cd7af87sm464188015e9.1.2026.02.18.06.19.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Feb 2026 06:19:56 -0800 (PST)
Message-ID: <d881edeb-d73b-43ba-bdb3-1b664e1cb882@gmail.com>
Date: Wed, 18 Feb 2026 14:19:56 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/2] wt-status: avoid passing NULL worktree
To: Karthik Nayak <karthik.188@gmail.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Cc: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>,
 Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>
References: <ebc16a74-0555-4951-8ec6-ff7fce6b6fcc@gmail.com>
 <cover.1771258688.git.phillip.wood@dunelm.org.uk>
 <409871a7d521b76c9eb811d3c49747e04de8defc.1771258688.git.phillip.wood@dunelm.org.uk>
 <CAOLa=ZQKLqFn4w3s7PD87FZ_120gohoqKX5c3uLKo2vASsbxfA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAOLa=ZQKLqFn4w3s7PD87FZ_120gohoqKX5c3uLKo2vASsbxfA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/02/2026 17:46, Karthik Nayak wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> This updates the only callers that pass a NULL worktree to
>> worktree_git_path().
>>
> 
> I was thinking surely there must be other places where we also pass NULL
> for worktree, but doesn't seem like there are any such instances.

Yes, I was pleasantly surprised there weren't more sites to convert.

>> +struct worktree *get_worktree_from_repository(struct repository *repo)
>> +{
>> +	struct worktree *wt = xcalloc(1, sizeof(*wt));
>> +	char *gitdir = absolute_pathdup(repo->gitdir);
>> +	char *commondir = absolute_pathdup(repo->commondir);
>> +
>> +	wt->repo = repo;
>> +	if (repo->worktree)
>> +		wt->path = absolute_pathdup(repo->worktree);
> 
> Shouldn't this always be set? I guess my question is, will
> `repo->worktree` ever be NULL?

Oh, wt->path should never be NULL. repo->worktree is NULL in bare 
repositories but then we should use repo->gitdir as the worktree path.

>> +	wt->is_bare = !!repo->worktree;
>> +	if (fspathcmp(gitdir, commondir))
>> +		wt->id = xstrdup(find_last_dir_sep(commondir) + 1);
> 
> So here we continue to treat NULL as the main worktree. Okay.
> 
>> +	wt->is_current = is_current_worktree(wt);
> 
> Since we're getting the worktree from the repo, shouldn't this be
> 'true'?

That's what I thought initially. However is_current_worktree() compares 
"repo->gitdir" to "the_repository->gitdir" so the "current" worktree is 
the one that the process was started in, which is not necessarily the 
same as the one matching "wt->repo->gitdir". It's possible that we will 
want to change that definition in the future but I opted to make this 
function consistent with the status quo.

>> -/*
>> +/* Construct a struct worktree from a struct repository */
>> +struct worktree *get_worktree_from_repository(struct repository *repo);
>> +
>> + /*
> 
> Nit: extra space?

Good spot I'll fix it

Thanks for the review

Phillip

