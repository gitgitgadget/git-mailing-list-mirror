Return-Path: <SRS0=ZiOn=25=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01646C282DD
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 14:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B479820692
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 14:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZvIqL4oC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbgAHO1J (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jan 2020 09:27:09 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35352 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbgAHO1J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jan 2020 09:27:09 -0500
Received: by mail-wm1-f65.google.com with SMTP id p17so2734169wmb.0
        for <git@vger.kernel.org>; Wed, 08 Jan 2020 06:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=T+DVa/mSWghIeRPrBnODEIEOBgDg7ZX6j3p9e6fZoco=;
        b=ZvIqL4oC/TmuwlH05VIs8m2rZpv8sgXkk4VY2YoxzflFDj3eIWOxELxKZNXDw0E440
         VuY7vzk9Ek17FHzAQn2Gz3zzMnl8qbi6FnJcIs9VYnU1rH5m5Hs2mxHvN7ZD5NdGoume
         L0V5KKUisr4KcU3wGPUWwsISf7ukJOhMfy9N/h3AYOKA+ifu208Cf1JzxcZ4yqj3s5qF
         aBzC8TZasGJw+tfMTzI9neqElaSYlJmlRTjuY6Unuj39xznbtThoglkiXGrj8uDbZH0e
         goj9n6QgxP/fHlA3FnIxCX+jTvOU8xAikXnPveiVKvN48OWVaHvoavqbEUkIYFG0p8mq
         Dn1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T+DVa/mSWghIeRPrBnODEIEOBgDg7ZX6j3p9e6fZoco=;
        b=t0JREHFMyDdxuLhyJeWQyedmDYaJq6kiOdu3LYhLYPzBG2QwsfA7fP+kfXcpJ5po0G
         qarPu/YdeyMf4LGlYICl/IMLbBva9JnA91mws4nlz1wnAEGpjNOXBDYNAhn8hPEQ+0Zf
         M/AxAq7sV/PsfjqyHEa/NfSbXYNY6/AO91zmZz8Tz1pW6RnXs5oR4H6hOa8z2pVlniit
         /51PR0TCWthoxKx6QljD3gA39x98kmN82x6alO/mvAtZAb+cQMhojjyca+ltkIepOvfq
         NBCwUcmQ6t/1RgwOAEQlVTcnAJH5J9qp2oTl39TCO+w6vlRNEBLBxGwzG5ees05vt735
         7Dtw==
X-Gm-Message-State: APjAAAUe2kAfBM5LBSi7B0oBz/GbvloUahof7mnEJiouDCPrR8dpmmai
        +UmNdOl576LXjZyMFXCkO58/jqlx
X-Google-Smtp-Source: APXvYqyKzps9YZaxyfCmTMw9FfC7VkGVKoSSxcV+y40iwuSD/qi+9W25QPojgukMtPQdhvQt8o8gJQ==
X-Received: by 2002:a1c:9c4c:: with SMTP id f73mr4419276wme.125.1578493625664;
        Wed, 08 Jan 2020 06:27:05 -0800 (PST)
Received: from [192.168.2.240] (host-92-22-7-145.as13285.net. [92.22.7.145])
        by smtp.gmail.com with ESMTPSA id k13sm4254646wrx.59.2020.01.08.06.27.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2020 06:27:05 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 01/15] rebase: extend the options for handling of empty
 commits
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Denton Liu <liu.denton@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Pavel Roskin <plroskin@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <pull.679.v2.git.git.1577126999.gitgitgadget@gmail.com>
 <pull.679.v3.git.git.1577217299.gitgitgadget@gmail.com>
 <1c2b77e94d63f86590ca934855066eca278f576e.1577217299.git.gitgitgadget@gmail.com>
 <404424d7-f520-8f89-efef-ca03e66fcd43@gmail.com>
 <CABPp-BEH=9qejeqysHYE+AJ+JPaBympZizq-bx_OjArYFa4xUQ@mail.gmail.com>
Message-ID: <d9d3d360-fc45-a716-4b35-4367c017460e@gmail.com>
Date:   Wed, 8 Jan 2020 14:27:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CABPp-BEH=9qejeqysHYE+AJ+JPaBympZizq-bx_OjArYFa4xUQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah

Thanks for such a detailed reply, I'll try and do it justice.

TLDR I like your new proposal

On 07/01/2020 19:15, Elijah Newren wrote:
> Hi Phillip,
> 
> On Tue, Jan 7, 2020 at 6:37 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> Hi Elijah
>>
>> Thanks for working on this series, I think making the sequencer the
>> default backend is a good idea. I have a few reservations about this
>> path though...
> 
> Thanks for the feedback.  You've provided some good food for thought.
> While responding, I came up with an alternate proposal below which I
> think may be more in line with what you want.  Let me know...
> 
>>
>> On 24/12/2019 19:54, Elijah Newren via GitGitGadget wrote:
>>> From: Elijah Newren <newren@gmail.com>
>>>
>>> Extend the interactive machinery with the ability to handle the full
>>> spread of options for how to handle commits that either start or become
>>> empty (by "become empty" I mean the changes in a commit are a subset of
>>> changes that exist upstream, so the net effect of applying the commit is
>>> no changes).  Introduce a new command line flag for selecting the
>>> desired behavior:
>>>     --empty={drop,keep,ask}
>>> with the definitions:
>>>     drop: drop empty commits
>>>     keep: keep empty commits
>>>     ask:  provide the user a chance to interact and pick what to do with
>>>           empty commits on a case-by-case basis
>>
>> I think we want to distinguish between commits that are empty before
>> rebasing and those that become empty when they are rebased. --keep-empty
>> explicily only applies to commits that are already empty. Cherry-pick
> 
> I am open to changing how the empty handling works; I figured it was
> the most likely area people might have feedback about.
> 
> However, I do strongly disagree with the "explicit" claim here.  It is
> possible that --keep-empty was designed to only apply to commits that
> begin empty, but that is not at all explicit.

Maybe explicit wasn't the best choice of words. I was going off the
implementation which takes pains to only allow and empty commit when the
original was empty. This has been the case since the feature was
introduced in 90e1818f9a ("git-rebase: add keep_empty flag",
2012-04-20). I did some digging in the mail archive this morning and
found [1] which seems to confirm the intention was to preserve existing
empty commits, not keep those that become empty. This fits with the
discussion [2] which lead to this feature. The same patch series that
introduced --keep-empty for rebase introduced the two cherry-pick flags
--allow-empty and --keep-redundant-commits to distinguish between the
two cases and used `cherry-pick --allow-empty` to implement `rebase
--keep-empty` (and failed to provide a way to continue after stopping 
for a conflict resolution)

[1] https://lore.kernel.org/git/5006614E.8090601@viscovery.net/
[2]
https://lore.kernel.org/git/20120323185205.GA11916@hmsreliant.think-freely.org/

>  The only place in the
> documentation I could find that mentions the distinction at all was in
> the "Behavioral Differences" section, which was written by me as part
> of commit  0661e49aeb84 ("git-rebase.txt: document behavioral
> differences between modes", 2015-06-27).  Quoting from that commit
> message:
> 
> "(In fact, it's not clear -- to me at least -- that these differences
> were even desirable or intentional.)  Document these differences."
> 
> I cannot find anywhere else making a distinction in either the
> documentation or the commit messages or even any code comments, which
> has left me wondering whether the distinction was intentional at all.
> Things like commit b00bf1c9a8dd ("git-rebase: make
> --allow-empty-message the default", 2018-06-27) give heavy precedence
> to the assumption that git-rebase is often more happenstance than
> design when it comes to edge cases like these.
> 
>> has distinct options for those two cases. If I've explicitly created an
>> empty commit then I want to keep it but I don't want to keep commits
>> that become empty because the changes they contain are already upstream.
>>
>> If we want an option that keeps commits that become empty (Off hand I
>> don't know why we would though) we should consider if that option should
>> disable --cherry-mark when we create the todo list so that it keeps all
>> commits that become empty when they're rebased.
> 
> To answer the particular reason I have seen why folks might want to
> keep both commits that start empty and become empty, but still use
> --cherry-mark to discard commits that are already upstream:
>   * If cherry-mark can determine the commit was "already upstream",
> then because of how cherry-mark works this means the upstream commit
> message was about the *exact* same set of changes.  Thus, the commit
> messages can be assumed to be fully interchangeable (and are in fact
> likely to be completely identical).
>   * If a commit does not start empty, but becomes so because its
> changes were a subset of those upstream, then while there are clearly
> no more changes that need to be applied, the commit messages can be
> expected to differ -- either there will be an upstream commit that
> included a bunch of other changes too, or the commit we are rebasing
> will be spread across multiple upstream commits.  If the project has
> bad commit message hygiene (because e.g. they are using atrocious code
> review tools like GitHub that don't allow you to review them), there's
> a reasonable likelihood that the upstream version only talks about the
> other changes in the commit instead of the fix we are rebasing.  If
> so, there may be useful information in this commit message that we
> want to copy somewhere.

That sounds reasonable, (I'm not sure what one would do with the commit
message though as creating an empty commit wont be any use for blame or
someone looking at the commit that introduced the change upstream. One
could use add a note to the upstream commit but then there's the problem 
of sharing notes)

> It's a somewhat rare usecase involving projects that generally aren't
> careful with commit messages but which has some people working on it
> who are careful.  But even for these projects, the odds that a commit
> message will just get tossed anyway seem fairly high, so I will not
> strongly defend this choice; it just seemed like "--keep-empty" or
> "--empty=keep" should mean "keep empty", not "sometimes keep empty".
> So, if it'd be nice if we could come up with clear wording if we are
> going to implement other possibilities.
> 
> Anyway, am I correctly understanding that you would like to see the
> following matrix of options?
>   * Drop commits that either start or become empty [the current --empty=drop]

Yes please

>   * Pause and ask users whether they want commits that either start or
> become empty [the current --empty=ask]

I'd prefer an option to keep the commits that start empty and ask about
the ones that become empty (just like --keep-empty does now)

>   * Keep commits that start empty, but drop ones that become empty [a
> new option]

Yes please

> and possibly drop the current --empty=keep behavior?

Yes as I'm not sure it's that useful, if users want to keep the
information from the message of a commit that becomes empty I'm not sure
just creating an empty commit is going to be much use in practice.

>>> Note that traditionally, am-based rebases have always dropped commits
>>> that either started or became empty, while interactive-based rebases
>>> have defaulted to ask (and provided an option to keep commits that
>>> started empty).  This difference made sense since users of an am-based
>>> rebase just wanted to quickly batch apply a sequence of commits, while
>>> users editing a todo list will likely want the chance to interact and
>>> handle unusual cases on a case-by-case basis.
>>
>> I don't see why it makes sense to drop an empty commit that I've made
>> just because it is being rebased.
> 
> Are you arguing that keeping commits that started empty should
> actually be the default, i.e. that all three rebase backends have
> traditionally had the wrong default?

Yes, I think rebase should preserve the commits that are being rebased
as far as possible and the current default is probably a historical accident

>> I'm pretty sure the behavor of the
>> am-based rebase is a function of `git am` not being able to create empty
>> commits.
> 
> That may be, but it's not quite clear.  Junio kind of commented on
> this in https://lore.kernel.org/git/xmqqfu1fswdh.fsf@gitster-ct.c.googlers.com/.
> His comments that "lack of --keep-empty on the 'am' side is probably a
> bug that wants to be fixed" might imply that he only sees it as a
> useful option.  If the behavior of the am-based rebase dropping
> commits which started empty was solely a function of git-am not being
> able to create empty commits, then the correct fix would be to make
> keeping the commits which started empty as the default or maybe only
> behavior rather than just making it an option.

Yeah I'm not sure how Junio feels defaulting to keeping commits that
start empty

> I'd actually be open to changing the default here.

I'd be keen to do that but we should try and find out what others think.

>  We have a
> precedent in doing so with commit b00bf1c9a8dd ("git-rebase: make
> --allow-empty-message the default", 2018-06-27) where we stated that
> really rare edge cases (which I think both empty commit messages and
> commits which start empty qualify as) probably have the wrong default
> in rebase.  And changing the default would yield a much easier to
> understand matrix of options:
> 
>   * Drop commits that become empty (modification to --empty=drop in
> that it keeps commits which started empty)
>   * Pause and ask users if commits become empty (modification to
> --empty=ask in that it keeps commits which started empty)
>   * Keep commits that become empty, in addition to those that started
> empty (--empty=keep).

That matrix is easier to understand and covers all the cases I'm 
interested in.

>>> However, not all rebases
>>> using the interactive machinery are explicitly interactive anymore.  In
>>> particular --merge was always meant to behave more like --am: just
>>> rebase a batch of commits without popping up a todo list.
>>>
>>> If the --empty flag is not specified, pick defaults as follows:
>>>     explicitly interactive: ask
>>>     --exec: keep (exec is about checking existing commits, and often
>>>                   used without actually changing the base.  Thus the
>>>                   expectation is that the user doesn't necessarily want
>>>                   anything to change; they just want to test).
>>>     otherwise: drop
>>
>> I'm not sure I like changing the behavior based on --exec, I see what
>> you're getting at but it has the potential to be confusing. What if I
>> want to rearrange the commits without changing the base - why must I
>> specify --empty=keep there but not if I add --exec to the command line?
> 
> This was probably poorly explained and also poorly implemented.  Let
> me try from a slightly different angle, and come to a slightly
> different result than I did previously:
> 
> Quoting from Junio in b00bf1c9a8dd ("git-rebase: make
> --allow-empty-message the default", 2018-06-27),
>    '"am" based rebase is solely to transplant an existing history and
> want to stop much less than "interactive" one whose purpose is to
> polish a series before making it publishable, and asking for
> confirmation ("this has become empty--do you want to drop it?") is
> more appropriate from the workflow point of view'
> 
> I would modify Junio's wording to expand "am based rebase" to say that
> if the user hasn't requested an interactive rebase or otherwise
> explicitly signalled that they want some measure of interactivity
> (e.g. specified --empty=ask), then we should not stop and ask how to
> handle commits which started OR became empty.  In other worse, it's
> not just the am-based rebase that is about transplanting commits but
> any rebase where interactivity isn't requested.  I think the
> traditional --keep-empty is quite broken in this regard since it does
> stop and ask with commits that become empty.  rebase -m, rebase
> --exec, etc. should not stop when a commit becomes empty, there should
> be some default it just uses unless the user also adds
> --interactive/-i/--empty=ask.
> 
> But, if we take your above suggestion to make keeping the commits
> which started empty not only the default but remove it from the
> options, then this becomes much easier.  The choices become (kind of
> repeated from above):
> 
> [Keep the commits that started empty in all three cases, otherwise:]
>   * Drop commits that become empty (--empty=drop)
>   * Pause and ask users if commits become empty (--empty=ask)
>   * Keep commits that become empty (--empty=keep)

That's nice - I like it

> and the defaults are simply:
>    --interactive/-i: --empty=ask
>    everything else: --empty=drop

While I see the point about the difference between -i and the other 
rebase modes any flavor of rebase can stop at any time due to conflicts 
so it can never be fully automatic. Given that commits becoming empty is 
a bit of a corner case I'm not sure the complexity of different defaults 
is justified but I don't feel that strongly about it.

> (And as a bonus, in the thread I've referenced twice above Junio
> mentioned -- in respect to commits that become empty -- that he thinks
> these are the right defaults.  He didn't comment on the behavior of
> commits that start empty, which seems to be your primary concern.)

>>> Also, this commit makes --keep-empty just imply --empty=keep, and hides
>>> it from help so that we aren't confusing users with different ways to do
>>> the same thing.  (I could have added a --drop-empty flag, but then that
>>> invites users to specify both --keep-empty and --drop-empty and we have
>>> to add sanity checking around that; it seems cleaner to have a single
>>> multi-valued option.)  This actually fixes --keep-empty too; previously,
>>> it only meant to sometimes keep empty commits, in particular commits
>>> which started empty would be kept.  But it would still error out and ask
>>> the user what to do with commits that became empty.  Now it keeps empty
>>> commits, as instructed.
>>
>> It certainly changes the behavior of --keep-empty but I'm not sure it
>> "fixes" it. If I have some empty commits I want to keep as placeholders
>> then that's different from wanting to keep commits that become empty
>> because their changes are upstream but --cherry-mark didn't detect them.
>>
>> In summary I'm in favor of making it easier to drop commits that become
>> empty but not tying that to the handling of commits that are empty
>> before they are rebased.
> 
> Sounds like my modified proposal above may be in line with your tastes?

Yes. Keep commits that start empty and have an option to control what 
happens to those that become empty (defaulting to --empty=ask for 
interactive rebases at least).

>> I'm also not happy that the deprecation of --keep-empty suddenly makes
>> --no-keep-empty an error.
> 
> We could translate that to --empty=drop; does that sound reasonable?

translating it to --empty=ask would keep the behavior the same even if 
it sounds a bit odd. I don't think we want to change the behavior of 
--[no-]keep-empty while it is deprecated.

> 
> [...]
>>> @@ -466,7 +494,10 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
>>>       struct option options[] = {
>>>               OPT_NEGBIT(0, "ff", &opts.flags, N_("allow fast-forward"),
>>>                          REBASE_FORCE),
>>> -             OPT_BOOL(0, "keep-empty", &opts.keep_empty, N_("keep empty commits")),
>>> +             { OPTION_CALLBACK, 'k', "keep-empty", &options, NULL,
>>> +                     N_("(DEPRECATED) keep empty commits"),
>>> +                     PARSE_OPT_NOARG | PARSE_OPT_NONEG | PARSE_OPT_HIDDEN,
>>
>> It is all very well deprecating --keep-empty but suddenly making
>> '--no-keep-empty' an error goes beyond deprecation. Also I'm not sure
>> it's worth changing these options as I think the only user is
>> git-rebase--preserve-merges.sh
> 
> Side track: Since git-rebase--preserve-merges.sh is deprecated and we
> want to get rid of it, and rebase-merges exists and is a better
> implementation of the original idea, can we just translate rebase -p
> into rebase -r and delete git-rebase--preserve-merges.sh?  (With a few
> wrinkles, such as telling users in the middle of an existing
> preserve-merges-rebase that they either need to use an old version of
> git to continue their rebase or else abort the rebase?)

dscho posted some patches in November or December moving along this 
path, I'm not sure what the outcome was. It's a bit complicated by the 
different todo list formats between -p and -r but I think the end game 
should be to treat -p as -r as you suggest.

> 
>> Best Wishes
>>
>> Phillip
>>
> [...]
>> This function is used by cherry-pick/revert not rebase do we need to
>> change it?
> 
> Possibly not; I can take a look.  I had quite a difficult time trying
> to figure out how to make sure that --empty options were saved and
> restored across rebase --continue; it's not at all unlikely that I
> modified more than I needed to "for consistency".
> 
> [...]
>>> @@ -3033,9 +3064,15 @@ static int save_opts(struct replay_opts *opts)
>>
>> again this is for cherry-pick/revert
> 
> Okay, will double check this too.
> 
> [...]
> 

