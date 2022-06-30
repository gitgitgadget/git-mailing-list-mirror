Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 007B8C43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 05:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbiF3FGp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 01:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiF3FGn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 01:06:43 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2729F13E8A
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 22:06:42 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id p14so17068904pfh.6
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 22:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=9etSmRtxq4x5JuN7JtbCFhn8yYaVs0sl7lZNBiEV5CE=;
        b=S7USPhdwNZPowg/AmLvzlE8XDJA4f8fhSdnFG9WWxey6phTdG3RAwfjiM/vZGkzC3g
         XnjgX3NsE2aArGY8l1Y5bhJi0D9HMFnGvNBDghXnPuGhmn1VMmvukBm+O5nfPuBy22kU
         kUlJzKEbihROC79I8jKdL+hq8KBQTBVQ7GIg6NV0mKz+lj1RTvQ2poDS4ZNkLAHr8bJP
         Ac9iFwLry1Ih7czW5+RNt1LQohUApULixjt53WsTY06enLPtymk48f5Oz5vA5H0+8vPv
         b03W8T9TQ3WKeL3T5Fq/IrxtMlhiMfiszLQcpFocEVkyBMoZA8bO191bUOWVsWiT62le
         Jk/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9etSmRtxq4x5JuN7JtbCFhn8yYaVs0sl7lZNBiEV5CE=;
        b=fdxMC54aDC8tXHW1hmZZDtR8iF5Cpai4LzV9YT1T+5U5XxLUoMoqTl1TTiHzoFPvGz
         B46tvrOqLhgjPlJagSzp4d5ShnWLW6xuXPZX/cmq4ukhVEw8ZfJAoiIc4xl74taTG2on
         /lRWO23BYskwPH8ADKFIPft0uIcjYT5uMmdhs7o/WDLghKUBvsia9j2BWYKSthJQU779
         Te+9GheTg8APOCU6h/OSlhqlEP6nOVWmRnesnbswLvP2NvQozcWsY6V9rkY4Ms/9VJN9
         VuIhNdA9bnCUpiFdVFJPwEgrkutwiViS16BTLQYQj4l7cuNemgvBU8OPZANDko49ROel
         jQ5A==
X-Gm-Message-State: AJIora9A2N5etEaux5ehzOvuhTEqqXY4eeAIJRfHGdDugDKdsQ6c2UiR
        2SZXNBdwRn69ZFV4hCW5Y7gE
X-Google-Smtp-Source: AGRyM1u8t3ITNHUsgKrpIS+mxitBnWwaAqh/SNeeYxoNYwQI0++qadH/Zvgfhn3kU7yVoYG12c43Og==
X-Received: by 2002:a05:6a00:4107:b0:527:fbd1:ce54 with SMTP id bu7-20020a056a00410700b00527fbd1ce54mr5415423pfb.45.1656565601522;
        Wed, 29 Jun 2022 22:06:41 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id z1-20020a170902d54100b0016b85cdf8d3sm6248534plf.72.2022.06.29.22.06.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 22:06:41 -0700 (PDT)
Message-ID: <c5662c60-4a21-be94-8fe0-13c6730292dd@github.com>
Date:   Wed, 29 Jun 2022 22:06:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: git bug report: 'git add' hangs in a large repo which has
 sparse-checkout file with large number of patterns in it
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>
Cc:     Dian Xu <dianxudev@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>
References: <CAKSRnEzMaQEv=3mkNWRpy6+-c0rz=R191iqheCQ2ptXFs1CQgw@mail.gmail.com>
 <96034b3f-9811-38c1-7afe-c1c9dd243f0e@github.com>
 <CABPp-BHv3TSJhnWSF8AjF_nr72vMnOFXZJKoG0juGwjz13TZ=w@mail.gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <CABPp-BHv3TSJhnWSF8AjF_nr72vMnOFXZJKoG0juGwjz13TZ=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren wrote:
> On Wed, Jun 29, 2022 at 3:04 PM Victoria Dye <vdye@github.com> wrote:
>>
>> Dian Xu wrote:
>>> Dear Git developers,
>>>
>>> Reporting Issue:
>>>               'git add' hangs in a large repo which has
>>> sparse-checkout file with large number of patterns in it
>>>
>>> Found in:
>>>               Git 2.34.3. Issue occurs after 'audit for interaction
>>> with sparse-index' was introduced in add.c
>>>
>>> Reproduction steps:
>>>               1. Clone a repo which has e.g. 2 million plus files
>>>               2. Enable sparse checkout by: git config core.sparsecheckout true
>>>               3. Create a .git/info/sparse-checkout file with a large
>>> number of patterns, e.g. 16k plus lines
>>>               4. Run 'git add', which will hang>
>>> Investigations:
>>>               1. Stack trace:
>>>                        add.c: cmd_add
>>>                   -> add.c: prune_directory
>>>                   -> pathspec.c: add_pathspec_matches_against_index
>>>                   -> dir.c: path_in_sparse_checkout_1
>>>               2. In Git 2.33.3, the loop at pathspec.c line 42 runs
>>> fast, even when istate->cache_nr is at 2 million
>>>               3. Since Git 2.34.3, the newly introduced 'audit for
>>> interaction with sparse-index' (dir.c line 1459:
>>> path_in_sparse_checkout_1) decides to loop through 2 million files and
>>> match each one of them against the sparse-checkout patterns
>>>               4. This hits the O(n^2) problem thus causes 'git add' to
>>> hang (or ~1.5 hours to finish)
>>
>> Thanks for the explanation, it helped me narrow down the source to an exact
>> commit (49fdd51a23 (add: skip tracked paths outside sparse-checkout cone,
>> 2021-09-24)).
>>
>> You're correct that the `path_in_sparse_checkout()` check is slow [1].
>> However, it only runs on files that are not "hidden" with the
>> `SKIP_WORKTREE` flag. Ideally, if you're using sparse-checkout, this will
>> only be a small subset of your 2 million files.
>>
>> In your repro steps, you're adding patterns to a file then immediately
>> running `git add`. If that reflects how you're usually working with
>> sparse-checkout, `SKIP_WORKTREE` likely isn't being applied properly before
>> the `add`. You can check to see whether file(s) have the flag properly
>> applied with `git ls-files -t <file or dir names>` - each `SKIP_WORKTREE`
>> file should have an "S" next to it. "H" indicates that the flag is *not*
>> applied.
>>
>> If you see that most of the files that *should* be sparse don't have
>> `SKIP_WORKTREE` applied, you can run `git sparse-checkout reapply` (make
>> sure you don't have any modified files outside the patterns you're
>> applying!). The downside is that it'll be as slow as what you're reporting
>> for `git add`, but any subsequent `add` (or reset, status, etc.) should be
>> much faster.
>>
>> If you do all of that but things are still slow, then the way we check
>> pathspecs in `git add` would need to change (not trivial, but probably not
>> impossible either). At a cursory glance, I can think of a few options for
>> that:
>>
>> 1. Remove the `path_in_sparse_checkout()` check. It's the simplest solution,
>>    but it means you'd be able to stage files for commit outside the
>>    sparse-checkout patterns without using the '--sparse' option. I don't
>>    personally think that's a huge issue, but given that the implementation
>>    was intentionally changed *away* from this approach, I'd defer to other
>>    contributors to see if that's an okay change to make.
> 
> I'm strongly against this.  This just restores the original bug we
> were trying to fix, attempts to paper over the fact that non-cone mode
> is fundamentally O(N*M) in one small instance, and sets the precedent
> that we can't fix further sparse-checkout-based usability bugs because
> it might add performance bottlenecks in additional places given
> non-cone-mode's fundamental performance design problem.  We should
> instead (in rough priority order)

I'm not sure what the bug was - although I can (and should) read through the
list archive to find out - but the rest of your point is convincing enough
on its own. Even if we sacrificed correctness for performance in this one
case, there are countless other places in the code like it, and changing all
of them could seriously hurt user experience in other ways.

Thanks for your perspective!

> 
> * encourage people to adopt cone mode
> * discourage people still using non-cone mode from having lots of patterns

While I know these are the recommended best practice, I do want to
acknowledge that switching to cone mode in some repositories is a huge lift
or otherwise infeasible [1]. While people make that transition (if they even
can), I don't think it's unreasonable to look for ways to improve
performance in non-cone sparse checkout, especially if those performance
gains can also be realized in cone mode.

[1] https://lore.kernel.org/git/nycvar.QRO.7.76.6.2205212347060.352@tvgsbejvaqbjf.bet/

> * make sure people aren't misusing things (the lack of a `git
> read-tree -mu HEAD` or `git sparse-checkout reapply` seemed very
> suspicious)

A warning if a particular git operation sees a lot of out-of-cone
non-`SKIP_WORKTREE` files might help with this (and would be especially
impactful for someone working with a sparse index). I'm not sure how to
quantify "a lot", though.

> * educate people that non-cone mode is just fundamentally slow, among
> other problems, and that the slowness might appear in additional
> places in the future as we fix various usability issues.
> * provide workarounds users can adopt if they really want to persist
> with non-cone mode with lots of patterns (e.g. add "--sparse" to their
> "git add" commands), though warn them about the possible side effects
> they'll face (the added files can seemingly randomly disappear in the
> working tree with future checkout/pull/merge/rebase/reset/etc commands
> if the added files don't match the sparsity patterns).
> * investigate ways to optimize the code to lower the constant in the
> O(N*M) behavior on a case-by-case basis
> 
> We deprecated non-cone mode in v2.37 in part because of this type of
> issue, and I really don't want the see the deprecated side of things
> dictating how commands work for the now-default mode.
> 
>> 2. After every call to `ce_path_match()`, check if all pathspecs are marked
>>    as `seen` and, if so, return early. This would slow down each individual
>>    file check and wouldn't help you if a pathspec matches nothing, but
>>    prevents checking more files once all pathspecs are matched.
> 
> Might be interesting.  Would need some careful measurements and
> attempts to validate how often all pathspecs are matched early in some
> kind of way, because this would definitely slow down some cases and
> speed others up, but I don't have a good feel for which side happens
> more frequently in practice.
> 
>> 3. Do some heuristic checks on the pathspecs before checking index entries.
>>    For example, exact file or directory matches could be searched in the
>>    index. This would still require falling back on the per-file checks if
>>    not all pathspecs are matched, but makes some typical use-cases much
>>    faster.
> 
> I'm confused.  "before checking index entries", you're checking things
> (namely, exact file or directory matches) "in the index"?

Sorry, I definitely wasn't clear. I mean "perform heuristic checks *per
pathspec item* before iterating *per index entry*." Pathspecs used in `git
add` are (at least in my experience) pretty small, so there could be
performance gains if all the items can be marked `seen` without iterating
over every entry of the index. I was thinking something like
`pathspec_needs_expanded_index()` in `reset` (4d1cfc1351 (reset: make
--mixed sparse-aware, 2021-11-29)), but tailored to this particular case.

> 
>> There are almost certainly other options, and I can dig around `add.c` more
>> to see if there's anything I'm missing (although I'd love to hear other
>> ideas too!).
>>
>> Hopefully this helps!
>> - Victoria
>>
>> [1] `path_in_sparse_checkout()` is significantly faster in cone mode, but
>> with 16k patterns I'm assuming you're not using cone patterns ;)
>>
>>>
>>> Please help us take a look at this issue and let us know if you need
>>> more information.
>>>
>>> Thanks,
>>>
>>> Dian Xu
>>> Mathworks, Inc
>>> 1 Lakeside Campus Drive, Natick, MA 01760
>>> 508-647-3583
>>

