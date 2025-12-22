Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150ED50276
	for <git@vger.kernel.org>; Mon, 22 Dec 2025 18:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766428069; cv=none; b=H1fRXDA/+A1IpjJUx9ytQmAzpYuMUJ6BHehfPbP/XKp6qIR5SkcHpjStE1S1g+ySLowtLAt8LoWrp12IPM7D3p8tsnXybbUPuLVMXCGJhMwSnOsiyudZewoTl7Z3aHrrKnztYzy4ydaa02l+rEDxjheLd5GhUWBPnNq85moQdNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766428069; c=relaxed/simple;
	bh=BbPV8X8NZCcBq3DfdKuk1dX/4rw+34LTkubR4Capt0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ECbo34hKmpVzA6y66abcOqzSgzyEG5+aQdXJMcqjzR/Ei6KW+DRQaR3q+baEta5HjlWwYDPkeRwvHDaPszN2u7Plu1vj1mexpoA9kInIVLveqsq+x0Jb1pSOdoxQBqlYBlDyQuzvHkEvphXtQSisTfUt87Ug5c13dy33gEF1ntE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LrRLX5hD; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LrRLX5hD"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b7ffbf4284dso505874766b.3
        for <git@vger.kernel.org>; Mon, 22 Dec 2025 10:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766428066; x=1767032866; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=17ygnN4mgWzFfLjafNewI+SZe+AB2wI68jlzc7ASW7s=;
        b=LrRLX5hDbOOKx98IV6Lp8/VGHE2DwGkDGKzEhp7a3OTPE8DGQyomlD03uvxFi8meu3
         RPQCSmb2S8BVxhdH4SedXLgMA4pCO5bsR2Ej/uzyBl43RtKx4FBCvMoys2a8a+1wUz8g
         eJauNpCcUuXc1u6K5RplO5EYZBB1Be1bQxWkC/0I3pwMBvvNo0sUElln5XHyAnQAyF3X
         DAcLO4l6obVNH7RKLvREAk90ajjPkMwMxf2RujMd3wyycQw3In/ycWp0O4ZH2N4NcSub
         A2N7vX7AAAJHoHcAZJSXaCxoPZBxVzF9iCtuiEhcdiugLLrVbrhAuf0h+hlsfmtqXm4p
         scVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766428066; x=1767032866;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=17ygnN4mgWzFfLjafNewI+SZe+AB2wI68jlzc7ASW7s=;
        b=h82XCCYKxjRylpVscIIg/U8IsQ7rv1gSD2meCPL6olHRBrGSzEf3BB4fNdUdB1RkCj
         BzAX6QhkLl2JUa4v96h+F/gzfekUO1NuKG14IU7EDZ3b6/ojftSd67dZ0X7SQbiTh2yE
         U4dI4I91oJ/IO0zTnXXiRW8ZkCo2uVor7He4bzZsZK2YM/v7+kndIQ/WtPAMCiCVj1t6
         l9qxVcdEy8mtfzTNZ3svqwtITnoqzBLxqf9xjgm5boZxx2bKknEaEWsaB2FeRX4zl4yE
         /1pGbYPfsCS2VimWkEUcb9s69/tLt9HYuwARndeaJfMb6ZeW/x8l0dYzJjs/18cdvZqu
         zKGA==
X-Gm-Message-State: AOJu0YyqCDUFMd/H6tiQcH+Gn+MUU9bPv5Gh5WY2yExL0GZHK1/W1OVp
	d4mIqUfOLlQlcJsWaCDe7c974kPlb/Fk5RK2yZcdzhY/fzofES+ygrIT
X-Gm-Gg: AY/fxX5BeCaJacpAGwSvDGYLR/jANLjnSQ6zdH3TFRhm9VXNOVCQuRvQF9x83wC08qZ
	ZaokmYdCTVM2RT/ctZqccCR9IGjNEgyhRQ/CUEWzT9HplQqTrRiOmDNX610duv+yDweWhqCUf3b
	jHSi/JbX685aD4EbaPSMSRmxNPREper7dh6VSQ7feU0Uy+tjmpLN7Tc8Lcz/QH2xP7bONwEUHRk
	vJ+HJ268ef+Gdcjm72g3DmMmIHKOVIZWHMvoH2y/GVeQnti6AkNOwZtUB8dOWAfQhg0vwn/5EJQ
	3F664h16Z9CmwuOw1UELfanFhp7cuOzc701lJoJC09a0uyjOR9eR/sJ67fFhlturrgWKoCjLQh+
	QIvSmCPCFbMAQKAYHfMvqVR1ulX/CrZ2lv3yb5H4G7qQJQFNAWh5g6KNQRkBsIbZVG1Q7x5Cgc3
	HF5Z64Gsdc5rw9inTxAT66UwJblZD595JExQ==
X-Google-Smtp-Source: AGHT+IHLOgXU6qFalOdJ8yX76SfBbY0hm0fRnJPUMRvJyIdWkmVw5LqE+L+rwgsQSVj4GCaaJ6KEHg==
X-Received: by 2002:a17:907:9713:b0:b73:d7dc:ddc5 with SMTP id a640c23a62f3a-b8036f123e0mr1160865666b.2.1766428066035;
        Mon, 22 Dec 2025 10:27:46 -0800 (PST)
Received: from [192.168.1.134] ([178.224.218.125])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b90f53c51sm11144044a12.3.2025.12.22.10.27.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 10:27:45 -0800 (PST)
Message-ID: <7246f693-2047-4218-8103-8143e01032f0@gmail.com>
Date: Mon, 22 Dec 2025 19:27:44 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] checkout: add remoteBranchTemplate config for DWIM branch
 names
To: Junio C Hamano <gitster@pobox.com>,
 Pasteley Absurda via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
References: <pull.2136.git.git.1766332796836.gitgitgadget@gmail.com>
 <xmqqtsxjruwi.fsf@gitster.g>
Content-Language: en-US
From: pasteley <ceasebeing@gmail.com>
In-Reply-To: <xmqqtsxjruwi.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

You're right that same-named branches are the ideal Git workflow, and I
agree this patch should not encourage drifting away from that model.

The motivation here is for cases where the name mismatch is imposed by
external constraints, not chosen by developers. For example:

1. Server-side policies/hooks that require a namespace on the remote
    (e.g. `team/*`, `users/<id>/*`, `release/*`).
2. Hosting / mirroring setups where remote branches live under a fixed
    prefix for organizational or access-control reasons.
3. Migrations where the remote branch layout is constrained by the
    target system, while local developer workflows assume short names.

In these scenarios developers do not create the problem, they inherit it.
The alternative today is to type the prefixed remote name everywhere and
give up DWIM convenience (e.g. `git checkout foo` no longer does the
"natural" thing).

This remains opt-in via `checkout.remoteBranchTemplate`, so only workflows
that explicitly configure it change behavior; defaults stay unchanged.
Explicit operations still bypass the template (e.g. `-b/-c <name>` and an
explicit push refspec keep full user control).

Git already supports name mismatches in a few places:
* `remote.<name>.fetch` allows arbitrary mappings for remote refs.
* `branch.<name>.merge` can track a differently named remote branch.
* `push.default=upstream` pushes to the configured upstream even if names
   differ.

However, configuring `remote.<name>.push` does not solve the DWIM checkout
problem: users still need to know the full remote branch name to check it
out, and wildcard push refspecs can have surprising scope (they can match
many branches unless the user is always explicit). This patch keeps the
scope narrow: it only affects cases where Git is already "guessing" the
remote side (checkout/switch/worktree --guess-remote, and automatic
upstream setup).

> Once "git checkout foo" is taught to do the same as "git checkout -b
> extra-foo -t origin/foo", it would create:
>
> [branch "extra-foo"]
> remote = origin
> merge = refs/heads/foo

Yes, but only for the DWIM path where Git derives the remote branch. When
the user explicitly names the local branch, we do not apply the template.

> But then what should happen when the user is using "matching push"?

While `push.default=matching` has been deprecated since Git 2.0 (~ 2014),
we still can handle this corner case by detecting the incompatibility
and providing a clear error message.

Thanks for the thorough review,
pasteley

On 22/12/2025 5:40 AM, Junio C Hamano wrote:
> "Pasteley Absurda via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: pasteley <ceasebeing@gmail.com>
>>
>> Add checkout.remoteBranchTemplate to apply a template pattern when
>> searching for remote branches during checkout DWIM and when creating
>> remote branches with push.autoSetupRemote.
>>
>> Template uses printf-style placeholders (%s for branch name). For
>> example, with "feature/%s", checking out "foo"
>> searches for "origin/feature/foo" and creates local "foo"
>> tracking it. Pushing with autoSetupRemote creates "origin/feature/bar"
>> from local "bar".
>>
>> Useful when remote branches use prefixes but local branches don't.
> It fells that this is presented backwards.  The usefulness of the
> layout that names local branches deliberately differently from their
> remote counterparts needs to be justified first.  Only after that,
> we can consider adding extra mechanism to support such a layout.
>
>
> Once "git checkout foo" is taught to do the same as "git checkout -b
> extra-foo -t origin/foo", it would create
>
> 	[branch "extra-foo"]
> 		remote = origin
> 		merge = refs/heads/foo
>
> but the push side would need extra work, and that is why you needed
> to muck with the push refspec.  But then what should happen when the
> user is using "we do not bother remembering what branches to push
> there; the remote repository remembers that for us", aka "matching
> push"?
>
> Most of the problems is what you are creating by using an unusual
> layout to name local branches differently from the remote
> counterpart.  You do not have to, and then all the problems you
> created with that layout goes away, without this patch.
>
> So, I am not sure if this is a good idea to begin with.  At least, I
> am not yet convinced.
>
> Thanks.
>
