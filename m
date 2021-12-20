Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A6E8C433F5
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 17:29:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240207AbhLTR3K (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 12:29:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbhLTR3J (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 12:29:09 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED024C061574
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 09:29:08 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id a11so10004317qkh.13
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 09:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=GX1cpdqIw4YErNeKygiUOu1n1ospWWyEG7wGVI+zhM8=;
        b=SwO7hEeX/Cst930WgvYu0lTLby3p858rMwhHc7W5iwSXpkn6F769egslotSwj/2fgk
         LDoc7BSBec/oXyYf0AtOBD620cJL1TUUtm+TJEgr44sw0u79s79xz7WfBpXo8GWo/1Az
         X09sIMHJCrbUBHmzkqUnkvJxjD/VPp/14bicJSZ700zAjU0mix9THVKygXRRKgINsB04
         ahlu7H5epGukuO23QgoAzeXnA+ORsTksBOu+ftiUDXpcoy4ZJJ+SOXnlMRXTCawVi+u3
         W1Gxz66o7vs3EpwEhCB//3iBv6L2N37f0wOv/Jr/bdE8b7yQZ1CC+2XHc3ZyHAbtHeOX
         9ddA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GX1cpdqIw4YErNeKygiUOu1n1ospWWyEG7wGVI+zhM8=;
        b=4SeGXo0BUR1Yl995zLG10AoJqQobpVQHIu80bxxD0YBuoZZJjb7GZHJvuToPf4pGFG
         VpZCl+nJQ93dR9A0/5Wv6UBV6sOhzSZRExlBJS75IjR+XDfbzLFGS7NUFCa70CkXH/l+
         dLk8zJGmYtc8RfX1i6LAZwyXuBNoU+SCHfeWRI2h6DR2VrWzI22zA5huOyF2Pydi44gk
         s/wOmJv4YKTparzEXciozdYZHdNyKlVRZtp3118kvCEKcmyyJAATt0pqd85p5HKJzWjN
         4Iz4E68i98JLqsSAeZcrElt8V3Mb5G2uj713W38U22jNlrYIvaVbTaq4vrTH/n85IQA+
         Atcg==
X-Gm-Message-State: AOAM530wVuUTHRDbx+pCsFIV0GD4jSrbtfO8F21vNOhNXaxZJ9O0fEy/
        8YszBiyE39Fl6/oyLhnuLpk=
X-Google-Smtp-Source: ABdhPJwEfuLsIMHpkkiskZghNimRFLVog7stShlo4PSiyl8FY7fCcSrTtrkyDyDQpod/wIqC8a8U/g==
X-Received: by 2002:a37:f60a:: with SMTP id y10mr9953264qkj.518.1640021347823;
        Mon, 20 Dec 2021 09:29:07 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:1dd9:8fb3:37da:4055? ([2600:1700:e72:80a0:1dd9:8fb3:37da:4055])
        by smtp.gmail.com with ESMTPSA id q7sm6509629qkl.72.2021.12.20.09.29.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Dec 2021 09:29:07 -0800 (PST)
Message-ID: <0f98d3e5-f2c2-526a-0476-a89778e5b2b5@gmail.com>
Date:   Mon, 20 Dec 2021 12:29:03 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: Bug report - Can create worktrees from bare repo / such worktrees
 can fool is_bare_repository()
Content-Language: en-US
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Sean Allred <allred.sean@gmail.com>,
        Git List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <ttaylorr@github.com>,
        Elijah Newren <newren@gmail.com>
References: <CABceR4bZmtC4rCwgxZ1BBYZP69VOUca1f_moJoP989vTUZWu9Q@mail.gmail.com>
 <e992d4b4-f9e2-a8f9-22da-e9d342c7bede@sunshineco.com>
 <CABceR4YVd4remACJkxwSCTSYB2v3Zn1BsjKHbzeve8uHiZv1pA@mail.gmail.com>
 <CAPig+cQ6U_yFw-X2OWrizB1rbCvc4bNxuSzKFzmoLNnm0GH8Eg@mail.gmail.com>
 <f39af047-d244-14be-4cd8-b6c3199545f3@gmail.com>
 <CAPig+cQPUe9REf+wgVNjyak_nk3V361h-48rTFgk6TGC7vJgOA@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CAPig+cQPUe9REf+wgVNjyak_nk3V361h-48rTFgk6TGC7vJgOA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/20/2021 10:58 AM, Eric Sunshine wrote:
> `On Mon, Dec 20, 2021 at 9:11 AM Derrick Stolee <stolee@gmail.com> wrote:
>> On 12/19/2021 7:58 PM, Eric Sunshine wrote:
>>> On Sun, Dec 19, 2021 at 3:47 PM Sean Allred <allred.sean@gmail.com> wrote:
>>>> I think either the git-sparse-checkout-set command (or the
>>>> git-checkout I ran after) would fail complaining that I was not in a
>>>> worktree.
>>>
>>> It is indeed the `git sparse-checkout set` command which fails.
>>
>> Right, 'init' will set the sparse-checkout information in your worktree
>> config and initialize it as needed, here:
>>
>>         if (upgrade_repository_format(1) < 0)
>>                 die(_("unable to upgrade repository format to enable worktreeConfig"));
>>         if (git_config_set_gently("extensions.worktreeConfig", "true")) {
>>                 error(_("failed to set extensions.worktreeConfig setting"));
>>                 return 1;
>>         }
>>
>> So, we are manually specifying "put this in the config.worktree file"
>> and not going through some "initialize worktree config" helper. Such
>> a helper would be useful to avoid this issue in the future.
> 
> Yes, I was planning to suggest this in a follow-up message.
> Specifically, I think top-level worktree.[hc] (not builtin/worktree.c)
> should publish a function which enables worktree-specific
> configuration _and_ does all the necessary bookkeeping, such as moving
> `core.bare` and `core.worktree` from .git/config to
> .git/worktree.config. That way, not only can git-sparse-checkout take
> advantage of it, but so can any command which needs the functionality
> in the future, as well as the fictitious "git worktree manage" command
> I mentioned earlier if it ever materializes.

Ah. I put my change in config.[hc], but let's discuss that in the
patch series [1].

[1] https://lore.kernel.org/git/pull.1101.git.1640015844.gitgitgadget@gmail.com

>>>> I see two options for when to set `core.bare=false` in
>>>> worktree-specific config:
>>>>
>>>>   1. At git-worktree-add: This is probably the earliest time which
>>>>      makes sense, but may be over-reach.  I'm not up-to-speed on how
>>>>      worktree-specific configs are generally considered on this list.
>>>>      If I were implementing a workaround, though, this is probably
>>>>      where I'd make it.
>>>
>>> My knee-jerk reaction is that applying a "fix" to `git worktree add`
>>> to assign `core.bare=false` in the worktree-specific config may be
>>> misguided, or at least feels too much like a band-aid. Although it's
>>> true that that would address the problem for worktrees created after
>>> `extensions.worktreeconfig=true` is set, it won't help
>>> already-existing worktrees. This reason alone makes me hesitant to
>>> endorse this approach.
>>
>> Yeah, my concern is that it requires the extension and could cause
>> some tools to stop working immediately. If we have the extension
>> already, it might make sense to initialize the file then.
> 
> I'm not following what you're saying. Initialize which file? When?

I mean when initializing the config.worktree file.

> Anyhow, this does bring up a good point and it makes me wonder if
> git-sparse-checkout (or whatever helper function is implemented)
> should warn the user that setting this extension could break foreign
> tools and that the repository format is being upgraded.

Yes, this was a concern when doing this change. I at least have not
seen anyone complain about it. This is not critical to the sparse-checkout
feature, but is currently how the sparse-checkout builtin works, so is
part of the paved path for most users getting started.

>>>>   2. At git-sparse-checkout-init: This is where the problem begins to
>>>>      have an effect, so this might also make sense.
>>>
>>> Yes, if I'm understanding everything correctly, this seems like the
>>> best and most localized place to address the problem at this time. The
>>> simple, but too minimal, approach would be for `git sparse-checkout
>>> init` to simply add `core.bare=false` to the worktree-specific config,
>>> however, this only addresses the immediate problem and still leaves
>>> things broken in general for any non-sparse worktrees.
>>>
>>> So, the better and more correct approach, while still being localized
>>> to `git sparse-checkout init` is for it to respect the documented
>>> requirement and automatically move `core.bare` and `core.worktree`
>>> from .git/config to .git/worktree.config if those keys exist. That
>>> should leave everything in a nice Kosher state for all worktrees,
>>> existing and newly-created.
>>
>> I agree that this is the only place that currently _writes_ to the
>> worktree config. All other code paths that seem to care about the
>> worktree config specifically only read from the config using a
>> modified scope.
>>
>> My thought on the direction to go would be to extract some code
>> from the set_config() in builtin/sparse-checkout.c into a config
>> helper, say "ensure_worktree_config_exists()", that adds the
>> extension, creates the file, and then adds core.bare=false.
>>
>> Even better, we could create a config helper that writes to the
>> worktree config, and _that_ could ensure the config is set
>> correctly before writing the requested value.
> 
> Please do not take the approach of setting `core.bare=false` in the
> worktree-specific config file. As I mentioned in the quoted text just
> above, that only resolves the problem for the worktree in question but
> leaves all other potentially worktrees broken (both existing worktrees
> and all new worktrees which are not being used for sparse checkout).
> The _only_ correct thing to do, as far as I can see, is for the new
> helper function to precisely implement the requirements as laid out by
> git-worktree.txt: specifically, enable
> `extensions.worktreeConfig=true` _and_ relocate `core.bare` and
> `core.worktree` from .git/config to .git/worktree.config.

Sorry I either misread or missed the part about moving core.bare over
to core.worktree.

Putting this in the helper that writes to config.worktree is the best
location, because we don't want to force it during 'git worktree add'
since that would cause compatibility issues for tools that don't
understand extensions.worktreeConfig.

Thanks for diligence in communicating what I missed.

-Stolee
