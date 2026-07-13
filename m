Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69B64252D6
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 13:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783948794; cv=none; b=QKu4CHhWKwxT/DXHGvScckzkwymehoikDhCc2GAYiituYFcGefQuMJgcSq5oR6ym6wzXF6lGIPY7wstIPBlntW0297+RykcwqZ7Pl3mJre6xBy2m0KYK9HWX1G4n4AtpxVJAPsW1ChReE1viREe0HcykpobKUa2FAB4qJQO4Euo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783948794; c=relaxed/simple;
	bh=QdyNJ6/0edvZqbXKTF1laXXpub4zjSdg8TQpmFEiD4M=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=bxIpv3OiOAUW4Lf7fS6z1xgRCyDmKS/mfpjtt853fqfo4vyZ6iOPf8/14xtGgJQuqz6rs5qa5SD2ftX83eaHcoMm9UuJ7jK8DsHKWilml9E32LCVex+IESnZwanC24wmk2aQmC70o00NhuCmuAHSnZdyBRnzhJVtnATW20TGUP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l18ud201; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l18ud201"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-493b966dd74so11743905e9.3
        for <git@vger.kernel.org>; Mon, 13 Jul 2026 06:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783948791; x=1784553591; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=agMU9INbrbgeuPwygsHj4kxEKYjRavLMNuxvE6DFn8k=;
        b=l18ud201kjjJdSufd7y5S+qiSwFW7SDsGxejDzhmSE3SlKX8eTJle75Cwz0cOaJhpX
         kA44Zm8TXG9TMAKFIqJkNe06wVngeG4b44uyDYFM4etGmQamnuGMa4ifw5vpEzIqXK51
         SMCtE3Y769QRII80PoTz97XczzpvmDfsKdHk91EH9SbcxwoUZv2BPIDjupYAIvNLrkZd
         huGRyVPYpSgjL3R7VcRMiakmx96/WlXGyuIUsMcte0RLoT9mIGYBSAVX2myJdNST3+53
         XdM0AqZ8dOkKRm8acuF1aPSK9bwZVsJ22iOZhKVdEsP+s9MyEHPidyzlY914370ApJcm
         HxVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783948791; x=1784553591;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=agMU9INbrbgeuPwygsHj4kxEKYjRavLMNuxvE6DFn8k=;
        b=Z/P1HVxJgJYtVjVJRdm+ygi9aEBpTzwn8amPfL3pl5NXO+BdT6Urnl8X0FCP5Pgtsh
         ffsVF3bhvJSt4H4hq5UlPzHGzPs7N4QkXaBDOC9PHJ96ZfA+RrrQ/y0lnkxBvFZBoqgw
         P38vmp11Y1LuV7o3HZan5XuzKH8MSAX4YenH4gp19ILpzXwld6f7cb2cE25Q160NlIeZ
         XISQCzChZBv+67GWDiwxocCBfkyu7LiyiUOmT1Fush4GQJyjnP7wGh+sRRq/BvoToHxB
         ZsGLIMmDCtQwpVe7jv4c+r9wXG3HWlLwfhuEm07wRRo4WiOQgUs04/EI5TfVrJKlGf7l
         zbZw==
X-Gm-Message-State: AOJu0YxySBxQFLuEydbA6TG6kRH6wIqNvOc6o8eAdBA9PFuHzpOKe/Jn
	kUDOlCHkK8OfaHFIJnk+1HenlwPj9rkq4F1TbUJO72/HWClI+UWm/3o/gq8Bsg==
X-Gm-Gg: AfdE7cn/AnzIgN+U843Z7UJFAop+kE7fGClBBcJFX47943c079XN2VYy2H9U/oT4Vvr
	SgGJFQUYdNFIfub38jOaDHsClIc3FwvvSdrQhdWqY2O2ZHtuBSptavOAMXTtKamGDitKKpTmN7e
	CHq7yE/8BHH8ErpOf3W/skAqSK/BQSk9hYN+oXhYo7w7r9rMnUPDvwT1ve16/WtP8v+LuDamTqT
	eAyBR7ql6WuuQEoQNDLUBRjMOqnGJa7bHvYFKu7GDoLmC7NLsLiKhRAHHAN1e65RTlMSWZ1ypDQ
	m98A75nuDbQIMsBIQ9nftsrP1gySCDWGNDyX0EtbAdTHj2aPZyiFR3m2vMUVgJrUcyLYeTtaafT
	dsg93p/P4t6VwUa6hlac4aFVINCs0oVPz8WZQewrNQ0YynAlmYxthZSzOLsI4eg8/68yQ/1xbz2
	sBx9BBB/OePd7fHAgfgu9CtDpsYTsJsGP0EJ5l3BtFNU7Efq4nV8CM7dHAZT3z1oxL/Ec=
X-Received: by 2002:a05:600c:4e88:b0:493:bc4a:d5f5 with SMTP id 5b1f17b1804b1-493f883be51mr95150605e9.39.1783948790983;
        Mon, 13 Jul 2026 06:19:50 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69a:b801:201a:26ab:8d41:fb43? ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f2d97527sm307524635e9.2.2026.07.13.06.19.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 06:19:50 -0700 (PDT)
Message-ID: <04051fe2-c54c-45e9-8773-92d40e84c765@gmail.com>
Date: Mon, 13 Jul 2026 14:19:45 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v1 0/3] worktree: add post-worktree-add and
 post-worktree-remove hooks
To: =?UTF-8?Q?Domen_Ko=C5=BEar?= <domen@cachix.org>,
 phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
 Patrick Steinhardt <ps@pks.im>, =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?=
 =?UTF-8?Q?on?= <avarab@gmail.com>, Caleb White <cdwhite3@pm.me>,
 Junio C Hamano <gitster@pobox.com>
References: <7c8b4673-37ac-45fa-ad8c-a1dc09afe5fe@mtasv.net>
 <0f37a01d-c39e-47b3-b8e9-48cdd42672df@gmail.com>
 <CAMvcdZS=ZYbLmjKaGJvjQ_fWYhVbOzwMvYq+MMENWPYi_RiqvQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAMvcdZS=ZYbLmjKaGJvjQ_fWYhVbOzwMvYq+MMENWPYi_RiqvQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Domen

Unfortunately it doesn't look like your message appeared on the list, 
sadly I'm not sure it accepts multipart/alternative messages even when 
they contain a plain-text version of the message.

On 10/07/2026 18:20, Domen Kožar wrote:
> Hi Phillip,
> 
> thanks for the quick and careful read.
> 
>  > It is useful for copying across untracked files to the new worktree
>  > like "config.mak".
> 
> That is a nice example, and it needs the hook to also fire for
> --no-checkout and --orphan, which post-checkout does not cover.
> 
>  > Looking at the existing code, if the checkout fails then we remove
>  > the worktree because "is_junk == 1" when remove_junk() is called via
>  > atexit() so I think it is correct to skip the new hook in that case.
> 
> Right, when the checkout itself fails the worktree is removed as junk
> and neither hook runs; no disagreement there. The case I was asking
> about is the post-checkout hook itself failing: that runs after
> is_junk is cleared, so the worktree survives, but post-worktree-add
> is currently skipped and tooling that registers worktrees would miss
> one that exists. I kept the skip because a failing post-checkout
> already signals a broken setup, but I am happy to run
> post-worktree-add whenever the worktree was created, regardless of
> the earlier hook's exit status, if that is preferred.

Oh sorry I'd misunderstood the question. I think I'd lean towards 
running the hook anyway because we've still populated a new worktree, 
even if the post-checkout hooks fails.

>  > The new hook is run after the checkout, but before the post-checkout
>  > hook - we should document their relative order.
> 
> Unless I am misreading my own series, it is the other way around:
> add_worktree() invokes post-checkout first and post-worktree-add
> after it, t2400 has a test pinning that order ('"add" runs
> post-worktree-add after post-checkout'), and githooks.adoc says "It
> runs after the post-checkout hook, and is skipped if that hook
> fails." If that did not come across I am happy to reword the
> documentation.

Oops, when I wrote that I was looking at the wrong branch - I had my 
"add-worktree-hook" checked out and confused it with this patch. It's 
great to see that there is a test and documentation for this.

>  > I'm wondering if either of those is useful if we're running the
>  > hook in the new worktree.
> 
> Strictly they are derivable from inside, --show-toplevel for the path
> and the basename of --git-dir for the id.

Isn't the worktree path the current working directory of the hook script?

> I passed them anyway so
> that one script can serve both hooks: post-worktree-remove has to
> receive them as arguments because the worktree is gone by the time it
> runs, and keeping the two signatures identical makes shared hook code
> simpler. I can drop them from post-worktree-add if the symmetry is
> not considered worth it.

Oh right, as a counter argument I wonder if having a different  argument 
count for the two hooks makes it easier for a script that's shared 
between the two hooks to determine which hook has invoked it. Is the 
worktree id useful for anything apart from accessing on worktree's local 
refs from another worktree?

>  > So the hook knows a worktree was removed but not which one?
> 
> It always gets the worktree id as $2; only the path in $1 can be
> empty, and only for entries whose gitdir file is missing or
> unreadable, where git itself no longer knows the path either. Tooling
> that recorded the id at post-worktree-add time can still match the
> removal.

That answers why you want the id.

One thought I had after I wrote my mail was that worktrees can be 
renamed - do we want a hook for that so that external tools can move any 
services they've started and update their id -> path mapping.

Thanks

Phillip

> Thanks,
> Domen
> 
> On Fri, Jul 10, 2026 at 3:34 AM Phillip Wood <phillip.wood123@gmail.com 
> <mailto:phillip.wood123@gmail.com>> wrote:
> 
>     Hi Domen
> 
>     On 10/07/2026 00:36, Domen Kožar wrote:
>      >
>      > Today there is no reliable trigger to set that up when a worktree
>      > appears: post-checkout does not fire for --no-checkout or --orphan
>      > and cannot be told apart from a plain checkout. Nothing at all fires
>      > when a worktree goes away, so stale databases and services pile up
>      > after "git worktree remove" or a manual rm followed by "git worktree
>      > prune". Wrapping the worktree commands only helps when every tool,
>      > human or agent, goes through the wrapper.
> 
>     I agree a hook that's run after the worktree is added is useful (I have
>     a patch for it that I've never got round to cleaning up and sending so
>     thank you for working on this). It is useful for copying across
>     untracked files to the new worktree like "config.mak".
> 
>      > Patch 1 adds a post-worktree-add hook that fires after the working
>      > tree is fully set up. Patch 2 adds post-worktree-remove for "git
>      > worktree remove". Patch 3 extends it to "git worktree prune" so that
>      > manually deleted worktrees are also observed.
> 
>     I don't have a strong opinion on a hook running when a worktree is
>     removed - an IDE that cares about that could set up a filesystem watch
>     on the directory but I guess adding a hook doesn't do any harm.
>      > Two design points I would especially appreciate feedback on:
>      >
>      >   * post-worktree-add runs after post-checkout and is skipped when
>      >     post-checkout fails. An argument could be made that it should run
>      >     whenever the worktree was created, regardless of the earlier
>      >     hook's exit status, since tooling registering worktrees would
>      >     otherwise miss one that does exist.
> 
>     Looking at the existing code, if the checkout fails then we remove the
>     worktree because "is_junk == 1" when remove_junk() is called via
>     atexit() so I think it is correct to skip the new hook in that case.
> 
>     The new hook is run after the checkout, but before the post-checkout
>     hook - we should document their relative order. I see the hook is
>     run in
>     the new worktree and passed the absolute directory and worktree id. I'm
>     wondering if either of those is useful if we're running the hook in the
>     new worktree.
> 
>      >   * for entries pruned because their gitdir file points to a location
>      >     that no longer exists, the hook receives the recorded path; when
>      >     the path cannot be determined at all (missing or corrupt gitdir
>      >     file) it receives an empty string.
> 
>     So the hook knows a worktree was removed but not which one?
> 
>     Thanks
> 
>     Phillip
> 
>      > Thanks,
>      > Domen
>      >
>      > Domen Kožar (3):
>      >    worktree: add post-worktree-add hook
>      >    worktree: add post-worktree-remove hook
>      >    worktree: run post-worktree-remove hook when pruning
>      >
>      >   Documentation/githooks.adoc |  41 +++++++++++++
>      >   builtin/worktree.c          |  73 ++++++++++++++++++-----
>      >   t/t2400-worktree-add.sh     | 113 +++++++++++++++++++++++++++++
>     +++++++
>      >   t/t2401-worktree-prune.sh   |  88 ++++++++++++++++++++++++++++
>      >   t/t2403-worktree-move.sh    |  44 ++++++++++++++
>      >   worktree.c                  |   1 -
>      >   worktree.h                  |   6 +-
>      >   7 files changed, 347 insertions(+), 19 deletions(-)
>      >
>      >
>      > base-commit: f85a7e662054a7b0d9070e432508831afa214b47
> 
> 

