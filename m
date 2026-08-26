Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6490B23645D
	for <git@vger.kernel.org>; Wed, 26 Aug 2026 10:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787738941; cv=none; b=D+rEGdoiUq3Kh2goQ3BRo42qCyIH7P6VNpmQ7GrfCmiILLAoNn2T/skFjfWrbFcgqFdld6UTkyLm5sxI/aTpzipK78bB+G+WfHbhYDMnh7P5Y8+OIC50i+WDC7VMZk4SZJ3Jwjul7WrGQaeo3iTOUyQsZm5IfTvVhgZe4XF9QdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787738941; c=relaxed/simple;
	bh=Q7h+CEBtq4uFGZmqfnMZRlb9eAQdrmY/1q4at2s0L0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BKfEwDrQ6eZF0BJK/9Q9VRh/z+57YYGMaShQyOQC/vHfNLHvCKbf/M1OWmnA2G+kMoUaMtOxZY2hjsJpDr/VZTDkMzo91zkCR4u7V7VRDnjdcPDUZ1uEFmiTLbkbEcu6YkoWpOwuKb6n/68OXKjGpo0xOm85MgtwvWfatnTbxdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=khZ58e+Z; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khZ58e+Z"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4956869750eso4535785e9.2
        for <git@vger.kernel.org>; Wed, 26 Aug 2026 03:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787738937; x=1788343737; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=34OTB66OheLiOXx8SyLFOdJ9ajjuzYowPnqJOtgn+SM=;
        b=khZ58e+ZUbG/UqwyF0JbpbpA6JTpqwb0GiNqcJqLz7PryalcO6hCkL+ctaDKH/qp7o
         ouMmbm63oHc2+XnPsfCUSO8Jg53aHG97Z6JXHPSFGL3pb+my3BqE3fYW4wPgIKgXEvYn
         5tf1Bvv5zZ6IzvPSxF/y2VBaDRxZWsVPpCvQFrea6HBQzuTrCSDaFuBH4nEONQzWgkd1
         LV0q63hgJP5vfYibsd1D5IQGja/Yu6umZ+SvAKSNbVAhe+WIdABHkCQ7kgSNSNoS49aW
         232UHHM5fHOWJ4KlKNYmmnxk0KSQ06rvKIC5aZbMOtbpTd1JD4aT6FblZFdmBRHhZHxQ
         whuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787738937; x=1788343737;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=34OTB66OheLiOXx8SyLFOdJ9ajjuzYowPnqJOtgn+SM=;
        b=hkN4ungop7/XeVlfwKMalYZbvBZ1dNHpXlQbdgq0weNC/Hh5jZ/43kx9yG5yV2Lh++
         eL2BLJTrEyYIsk9UCXBQfVw44fjXh1hWh/Rnzo/+7lI//7H2xQP2Ob0Z6PeNjRklkbDP
         ZsPvD79fwdmdWAmWuatPqDpQM10Dtz6alrUZRUXnGAgIZcr3HxP9RYv8idbLbdYJMCCi
         gtgi0IzNVaOYaOyloABqeP7nRGXmI4xvL9eDKI3grgNcQDOep5CIVSfT9gCvSti/GUVc
         68okW8b4/1++oD06glG7Wh8aNk8+1bhnT5o3l3g4NTAejN5L8hGhZrvVAoERKVSd93Q6
         uWmw==
X-Gm-Message-State: AFuF++nUAXTKc/iwOdxOGcYGZ5wkZJ72fExOTp/qXSalH74BrdUSbYW+
	4VE49+DfiriYyInU9iGGTt8+YgowVic5LUQuWUvzk5NuLW3uJKmVYM6M
X-Gm-Gg: AR+sD13vSzalgd1QED8Z7FDiPOrMFgKjDAHtS0yv3o7DquWjM0/UtpZn5UaObScSmhS
	LLolIcF7MSPnMhXzv0PagLC4iD0K0tQgWypbzsRhxyG0cKc0ONK2+n49rxE1bph8XAco/M2Ah81
	xfmRny/s2hd6YM8drXuIyY290/CuiZiRxtQtirNVH1E5nhglOQd03e0jpbZDCM9YK4piUGXx8nq
	IULaO6/n/jyfRYZA5JlyXuyAam8U0iuT7zaIzraPgiqc+rarJszdIbvt3uLrXuY9n1UEvtu+uSr
	KgyBnPJdm6A7/tiQAhHbCPDyzrhtSBMcsuxNc7mD6iump+hfU5tfVINRS4qKOPpQ95OSlJ7dHCk
	a2KFn29rP1+R0uwJVFYMQzJYQMgAQc6jaqZbt1hGp1goMX7/Nrz/VKtJeXToP0FhLZCCBMXUxio
	WuTGjhNvE136Ej3zEETjsfTg0lHUqrJKe7xmFnz1RqDvVGTkFRkvLrD2rJQK8esYdzP53ymDoDd
	74eQuDo0YiJh1MHyLBwDp4ls6YlbP67Ms/7YyN+e8Y=
X-Received: by 2002:a05:600c:4514:b0:499:8777:ccba with SMTP id 5b1f17b1804b1-499dc822557mr44672085e9.12.1787738936937;
        Wed, 26 Aug 2026 03:08:56 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d? ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499dc9b83aesm21299115e9.12.2026.08.26.03.08.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2026 03:08:56 -0700 (PDT)
Message-ID: <4c7734f5-2ef4-4bb0-9397-a97cd67a3bd4@gmail.com>
Date: Wed, 26 Aug 2026 11:08:55 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC] stash: let the stash stack live in a configurable ref
To: Vladimir Sitnikov <sitnikov.vladimir@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
References: <CAB=Je-GRbyonmkW4qXCuMRQhWcAZE8zc_Xp32hwC1i61bNnjaw@mail.gmail.com>
 <91feddb6-0d1b-42af-9942-307b98aa747d@gmail.com> <xmqqfr03sgyu.fsf@gitster.g>
 <e3e7d23c-ad66-42de-b959-f9f2fae8d16b@gmail.com> <xmqqecfmm76c.fsf@gitster.g>
 <CAB=Je-GVyfrP=3kW6hRh8aVnzkKg_6yKZW2LCV=Z1XB=T7KxFg@mail.gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <CAB=Je-GVyfrP=3kW6hRh8aVnzkKg_6yKZW2LCV=Z1XB=T7KxFg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Vladimir

On 25/08/2026 19:24, Vladimir Sitnikov wrote:
> Kristoffer Haugsbakk writes:
> 
>> To my uninformed, not-using-agents mind, what agents do with the tool
>> seems like the least concerning thing. They can be non-deterministically
>> instructed to not use the stash.
> [...]
>> And for determinism you can give them a git(1) wrapper that bans
>> git-stash(1).
> 
> A wrapper that bans git-stash(1) misses it, because a command that never
> mentions the stash still writes to refs/stash:
> 
>      git rebase topic --autostash
>      Created autostash: 637ca99
>      Applying autostash resulted in conflicts.
>      Your changes are safe in the stash.
>      You can run "git stash pop" or "git stash drop" at any time.
> 
> The entry sits in refs/stash afterwards, where every worktree sees it.
> rebase.autoStash lives in the shared .git/config, so one worktree can
> turn this on for all of them, and the flag then never appears in any
> command line to ban.
> 
> Having a stash subcommand and forbidding it to execute is fishy.
> Agents might miss the instructions and they might still attempt calling stash.

Right, your wrapper would need to be a bit more complicated. It would 
need to pass "-c rebase.autoStash=false -c merge.autoStash=false -c 
pull.autoStash=false", disallow command-lines containing --autostash and 
probably set GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=true to enforce that.

> Your point about the bar for a configuration option is well taken, and
> so is the one about the framing.  The single confused session justifies
> the option on its own; the agents changed how often it happens, not
> whether it is worth fixing.
> 
> Phillip Wood writes:
> 
>> When I'm not trying to move changes between branches I associate a stash
>> with the branch that's checked out when it is created, not the worktree
>> where that the branch happens to be checked out.  We already record the
>> branch name when creating the stash so perhaps we should add an option
>> to pop the last stash that was created on the current branch.
> 
> That covers more of my case than I expected.  Git refuses to check the
> same branch out in two worktrees, so a per-branch filter separates every
> worktree that sits on a branch, and the entries stay visible to
> `git stash list`, which a private ref gives up.
> 
> The gap is a detached HEAD:
> 
>      git checkout --detach
>      echo v2 >f && git stash push -m "my own text"
>      git stash list
>      stash@{0}: On (no branch): my own text
> 
> Every detached worktree records the same "(no branch)", so a per-branch
> filter groups them together rather than separating them.  That is not a
> corner case for the tools I have in mind: one repository here has 436
> linked worktrees, 23 of them on a detached HEAD, because a worktree
> created to look at someone else's commit has no branch to be on.

When we create a stash entry its first parent is HEAD. So I think you 
can find the last stash that was created in the current worktree by 
using HEAD's reflog and the first parents of the stashes. You want to 
find the most recent stash entry stash@{M} where

     object-id(HEAD@{N}) == object-id(refs/stash@{M}^1) &&
     reflog-date(HEAD@{N}) <= commit-date(refs/stash@{M}) &&
     commit-date(refs/stash@{M}) <= reflog-date{HEAD@{N-1})

that will give you the stash whose first parent is the same commit as 
HEAD in the current worktree when the stash was created.

>> If an agent really needs a private stash it can use "git stash create"
>> and record the oid of the stash under "refs/worktree/".
> 
> That is what I do today, and it works.  It is also what every tool has
> to reimplement, and the ones that skip it produce the failure I opened
> with.
> 
> The two ideas may well be one knob.  If the scope of the stack were
> configurable (the shared ref, the current branch, or a per-worktree
> ref), then "pop what this branch stashed" and "pop what this worktree
> stashed" become two values rather than two features, and a detached
> worktree can choose the one that still separates it.
> 
> I am happy to write the patch for whichever direction you prefer, or to
> test yours.

My preference would be to add options to "git stash pop" to pop the most 
recent stash created on the current branch, or the most recent stash 
created in the current worktree. That keeps the convenience of the 
global store for moving changes between different branches/worktrees 
while making it easy to pop the stash that you intended. It would be 
nice to have options to filter the output of "git stash list" by branch 
or worktree as well but that could be added separately.

I'd be interested to hear what others think

Thanks

Phillip

