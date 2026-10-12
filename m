Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C6C33B970
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 09:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791796415; cv=none; b=oNGA74jS8WLQLM+IET6KsL2bP8ZVBUtnaIwRQkthf9j37HHXvWlOugsJ+bM6J7mtIIEpDzaIsKjGO3npnTHgdem9sKBccBzTG0uiCRH2Sc7Fy40JYA6kLQWcDjCngq67zDxrmu/ctal69hlWmiG0rfFUID5HMz31pRNy4AMsVgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791796415; c=relaxed/simple;
	bh=L8CRvCbDDO+16CNelIVIJ0cy4zfIf/Hr0p22OKmgiCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cfB/EV2WBIKr1yVJ/P8rx2ID/26PXOj+ORJlIRtzWWpMlqctBdC9p2y2vXhkHW6r7wLhQvjKLADxAxdEu+0hZIqhW9v/NNwhJq5oUmrGA5WS8HcCw+gphKAIeMEV2yoVNXxTNEDzmEQOHhJLhVFh4rP8Iayk2KL9Sur6sExt+bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mkdzGyZ3; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkdzGyZ3"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a061a13884so14046445e9.3
        for <git@vger.kernel.org>; Mon, 12 Oct 2026 02:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791796413; x=1792401213; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Po96gaNezYpW98u0cj+VM5FNN11st4EoJjLe5f6Y53Q=;
        b=mkdzGyZ38jfU/1gi7Ey//zvkuDp23W33amQo03679qgFcdp/Qr0/EkYmbhehURFhnh
         K3nwOtDX1O9X2mDFOfT8yTsg2OTmMPuxQ0rW43qmO7AnUbQza1IQWKXN39H0tYEcWLXq
         M/zBO6nWjWnjnl6ogUFIS5hn5eqGqTneKbmmHZgm7fgXpae5DgbpKKOwWCMox9SFuNFk
         Q6Nj9RF2SRjy6Q5f1ZWZ8xzaF5M8GEEWMOkjZIozP3HTOu0oOVGpIiu4FFGgiMZwSLmq
         x9NiDGZ63XV4GPmgVCpnqmo9t0gPFNePxDxx04Wq6PyH/4lZHjpixrQGNfV7e8umKpnL
         bHRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791796413; x=1792401213;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Po96gaNezYpW98u0cj+VM5FNN11st4EoJjLe5f6Y53Q=;
        b=WNUQH9MUlU2Wsk52K/Ba3rDDlJ/JTae73P43AIL4Xe0xogjBGWmRSDs+9n5hHr2Ae7
         tlTYDO4adXBMCVkRO7vfYq7vZumiu3kimhUdgq+V67a1zqooPmF+vCQwOYTqYXVR7DZD
         etOlOTsFGxv3ttCNcYkzgo+lwUd90bvUKiTaI2g1ZysNW0L+3b37uYkgq3htQt08Sm8W
         uX103iwU+3lv1O5MUCpWeDNuRe99rgPRs07QbKbYNVfPGhterNMVUIt93HNbHPn9HnYX
         f0Eqeek2oYTvnfI+Qy1QqWGz5XlSbBpYWE8MdduJ+mUiHxEoQzXgvUSvDV88yor6w770
         +BJQ==
X-Gm-Message-State: AFq9FYLpdkQe+xN4RMR9HwsUu4+6D7xpNwsY8HYeTlm+H1cVx5RZdkb7
	spD4o9JsiomSOVKabo9ya3Inck7gFVmZxaWIiOV6aCRAd4tEyITog4B6
X-Gm-Gg: AYBFou1i+e4yony5WHbd2v71RtIiW5FwIDjTxSc20tsIVMVB9rKrFHCHGWsbecmp+yX
	/4T4ggYfkxBH0wNEjycq8os7e0dWy8CRmMWQTzwMWMzXOmsvjRPZUsOTQJ94X6X0Yq9W4D47Vgz
	XrsoWkHHWh/w83J+PL1RuXzjbhjvxLGigZp6nmOMcXWWFQftEo+iTtkVoLHH8TP9RB27sB4TGXI
	ENAZUbwDDKqhZgIEXfTnffgqWlXRva9s/GOWjdKYSHBenCQ0gfIAPrbdBSvr0PW5vUhtQpsLdSK
	7wmjwo1bZ0DwCfqaFPH+Fd2rA6ODnvjrHJBco32pOnGebnMiGaY2r5QJGadwb/+lUGwXIsJ2dzQ
	EEihRwsz7K6kPL2KPYPP1VcjbUOb+eVPWOeZPcCUj+TMC74HsudrXN8u8AUrFEkFXy6sUM6P8+j
	VSb0nS5/SCXuReWdpJB8znO5mnfZp5LQMZUWXkDLt4yIxnkwC4qdft7e6wfe8WkttAAF2Q3G2R5
	cS23xlwuimJ+Ou2llhZ3w==
X-Received: by 2002:a05:600c:3e14:b0:49e:6c11:c4fc with SMTP id 5b1f17b1804b1-4a18e49316dmr127690085e9.7.1791796412736;
        Mon, 12 Oct 2026 02:13:32 -0700 (PDT)
Received: from [192.168.1.201] ([90.251.190.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bead84esm272225505e9.13.2026.10.12.02.13.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2026 02:13:32 -0700 (PDT)
Message-ID: <5fcd107d-b620-44d1-91b7-e5f9965171cc@gmail.com>
Date: Mon, 12 Oct 2026 10:13:28 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 2/2] blame: ignore revs in HEAD:.git-blame-ignore-revs
To: Junio C Hamano <gitster@pobox.com>, Ravi Mistry <rmistry@google.com>
Cc: git@vger.kernel.org, Ravi Mistry via GitGitGadget
 <gitgitgadget@gmail.com>, Abhijeetsingh Meena <abhijeet040403@gmail.com>,
 Kristoffer Haugsbakk <code@khaugsbakk.name>,
 Phillip Wood <phillip.wood@dunelm.org.uk>,
 Eric Sunshine <sunshine@sunshineco.com>
References: <pull.2224.git.1789169384240.gitgitgadget@gmail.com>
 <pull.2224.v2.git.1791493644.gitgitgadget@gmail.com>
 <35e303d65bc378e733b1e9e8d6908a829352e857.1791493644.git.gitgitgadget@gmail.com>
 <xmqqtsmsdpxz.fsf@gitster.g> <20261011222929.2957901-1-rmistry@google.com>
 <xmqq8q43eszt.fsf@gitster.g>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqq8q43eszt.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/10/2026 00:07, Junio C Hamano wrote:
> Ravi Mistry <rmistry@google.com> writes:
> 
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Since the scoreboard is passed around throughout the subsystem and
>>> has a pointer to the repository it is working with, a new function
>>> like this one does not have to add new references to the_repository.
>>
>> Since there is an ongoing effort to reduce uses of the_repository in
>> the codebase, I went ahead and switched parse_default_ignore_revs_blob()
>> to use sb->repo in v3.
>>
>> Thanks!
> 
> Sounds good, and v3 looks good.  Let me mark the topic ready for
> 'next' unless we hear objections in a few days.

I've left a couple of comments on v3. Ignoring uncommitted changes in 
the file in the working tree seems a bit odd to me and we seem to be 
prepared to load a file of any size from an untrusted source.

Thanks

Phillip

