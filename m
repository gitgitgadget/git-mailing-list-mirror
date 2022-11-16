Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F31C4332F
	for <git@archiver.kernel.org>; Wed, 16 Nov 2022 14:45:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233583AbiKPOpf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Nov 2022 09:45:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233730AbiKPOpU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2022 09:45:20 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8EEA40461
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 06:45:15 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id fz10so10781372qtb.3
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 06:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Hk4zYmO2YtYrT+35CqZbO+NNejro9uHz/5H+Yid9lw=;
        b=AMhpJcyGfbfTfi86gvw1ZKk4e4KgfjYX+xWnvlh6xvVibZAqzFhbzy14G5mzzEVtf8
         Mm63NMfrWnMlpFzmu/v9w717qH9/9hIyJDiZcoFzIE66ylQ3QXwSuofJ7avsYssWoRLH
         CySEExY3r9WGeES2NodDAkwHWX6mTVmfMpvzgdB2yFl8tV+tl/cwIyJshkj+sMVzchK/
         xOx2wW08ckWp60LwKG02TeO3ppF6tHv5dZF3PRqZg99ILsKMBhQA7MkBa+1xTYsXGc3+
         fe2emNBEC+WJWM8/E+sqUPMC/pfwqOjjpMDgMOLHLpRnraL+mJ+8gKn+H1Z6eR1UFqiO
         UaAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Hk4zYmO2YtYrT+35CqZbO+NNejro9uHz/5H+Yid9lw=;
        b=W3f4yfPhX7bkF6FJcOEWS4S1r+13W7pvy390r/ndzBZjyDGkxjlCbTSN1PBSj4p35E
         Q4bjfoL9qDBzDCYhzvjNrpepJGdVdHU5vgE1cKXA1ChuOfmDNcSBl6Zcf3cfTrZGKhV7
         79cpTey1bdC5E0XNK2xIOmOJE3/oeiXiHz78WyvxLcB5DEzBzQNWup4dPRdFcBlIBYG+
         D0DgNAQZubvejirFr2zSZaAWU7ZE7MzdQB5l8YSx0gkGNHc1pApexruXSVZYgO6rBbhz
         0tbWTg7r8kV6VHg71cAacERt5yBg7hz44wGbR55dhlQRiIVsT1Q0teswyqlVmqbHKMc5
         ihlA==
X-Gm-Message-State: ANoB5pkbXs++SOUB2jX4DaR/v/MjM1yP+q4nIyS8juGtdsG55x9cPZIV
        CmOFiMYsJm83QVxsFWHyK2GlDouM7Nd6
X-Google-Smtp-Source: AA0mqf4aONtge3yza/LPIV+3AEUr/ATeJtZenouUzv1L03L4AZXB8UVVGQFk1Uzs3l2sflYh9Ix2oA==
X-Received: by 2002:ac8:4a07:0:b0:3a4:f467:2a9 with SMTP id x7-20020ac84a07000000b003a4f46702a9mr20687229qtq.611.1668609914594;
        Wed, 16 Nov 2022 06:45:14 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:f553:9f0c:85c5:38e1? ([2600:1700:e72:80a0:f553:9f0c:85c5:38e1])
        by smtp.gmail.com with ESMTPSA id f16-20020a05620a409000b006bb78d095c5sm10228799qko.79.2022.11.16.06.45.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 06:45:14 -0800 (PST)
Message-ID: <01063560-8f57-4e40-5707-f8d8ecfe6cca@github.com>
Date:   Wed, 16 Nov 2022 09:45:13 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH 00/30] [RFC] extensions.refFormat and packed-refs v2 file
 format
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jrnieder@gmail.com
References: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
 <CABPp-BEZK2KJHY+=Ta3VUzNjJKY=evPiAtp5UQFTVLMD0qreVQ@mail.gmail.com>
 <0e156172-0670-2832-78cb-c7dfe2599192@github.com>
 <CABPp-BFNvUQx7exLgqDvzhgn1s=xSFKbJWdr8qfxLTXEFDQQig@mail.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <CABPp-BFNvUQx7exLgqDvzhgn1s=xSFKbJWdr8qfxLTXEFDQQig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/14/22 9:47 PM, Elijah Newren wrote:
> On Sun, Nov 13, 2022 at 4:07 PM Derrick Stolee <derrickstolee@github.com> wrote:
>>
>> On 11/11/22 6:28 PM, Elijah Newren wrote:
>>> On Mon, Nov 7, 2022 at 11:01 AM Derrick Stolee via GitGitGadget
>>> <gitgitgadget@gmail.com> wrote:
>>>>
>>>> Introduction
>>>> ============
>>>>
>>>> I became interested in our packed-ref format based on the asymmetry between
>>>> ref updates and ref deletions: if we delete a packed ref, then the
>>>> packed-refs file needs to be rewritten. Compared to writing a loose ref,
>>>> this is an O(N) cost instead of O(1).
>>>>
>>>> In this way, I set out with some goals:
>>>>
>>>>  * (Primary) Make packed ref deletions be nearly as fast as loose ref
>>>>    updates.
>>>
>>> Performance is always nice.  :-)
>>>
>>>>  * (Secondary) Allow using a packed ref format for all refs, dropping loose
>>>>    refs and creating a clear way to snapshot all refs at a given point in
>>>>    time.
>>>
>>> Is this secondary goal the actual goal you have, or just the
>>> implementation by which you get the real underlying goal?
>>
>> To me, the primary goal takes precedence. It turns out that the best
>> way to solve for that goal happens to also make it possible to store
>> all refs in a packed form, because we can update the packed form
>> much faster than our current setup. There are alternatives that I
>> considered (and prototyped) that were more specific to the deletions
>> case, but they were not actually as fast as the stacked method. Those
>> alternatives also would never help reach the secondary goal, but I
>> probably would have considered them anyway if they were faster, if
>> only for their simplicity.
> 
> That's orthogonal to my question, though.  For your primary goal, you
> stated it in a form where it was obvious what benefit it would provide
> to end users.  Your secondary goal, as stated, didn't list any benefit
> to end users that I could see (update: reading the rest of your
> response it appears I just didn't understand it), so I was trying to
> guess at why your secondary goal might be a goal, i.e. what the real
> secondary goal was.

The reason is in the goal "creating a clear way to snapshot all refs
at a given point in time". This is a server-side benefit with no
visible benefit to users, immediately.

The D/F conflicts and case-sensitive parts that could fall from that
are not included in my goals. Part of that is because we would need a
new reflog format to complete that part. Let's take things one step
at a time and handle reflogs after we have ref update performance
handled.

>>> To me, it appears that such a capability would solve both (a) D/F
>>> conflict problems (i.e. the ability to simultaneously have a
>>> refs/heads/feature and refs/heads/feature/shiny ref), and (b) case
>>> sensitivity issues in refnames (i.e. inability of some users to work
>>> with both a refs/heads/feature and a refs/heads/FeAtUrE, due to
>>> constraints of their filesystem and the loose storage mechanism).  Are
>>> either of those the goal you are trying to achieve (I think both would
>>> be really nice, more so than the performance goal you have), or is
>>> there another?
>>
>> For a Git host provider, these D/F conflict and case-sensitivity
>> situations probably would need to stay as restrictions on the
>> server side for quite some time because we don't want users on
>> older Git clients to be unable to fetch a repository just because
>> we updated our ref storage to allow for such possibilities.
> 
> Okay, but even if not used on the server side, this capability could
> still be used on the client side and provide a big benefit to end
> users.
> 
> But I think there's a minor issue with what you stated; as far as I
> can tell, there is no case-sensitivity restriction on the server side
> for GitHub currently, and users do currently have problems cloning and
> using repositories with branches that differ in case only.  See e.g.
> https://github.com/newren/git-filter-repo/issues/48 and the multiple
> duplicates which reference that issue.  We've also had issues at
> $DAYJOB, though for GHE we added some hooks to deny creating branches
> that differ only in case from another branch to avoid the problem.

Yes, you're right here. We could do better in rejecting case-sensitive
matches upon request.

> Also, D/F restrictions on the server do not stop users from having D/F
> problems when fetching.  If users forget to use `--prune`, then when a
> refs/heads/foo has already been fetched is deleted and replaced by a
> refs/heads/foo/bar, then the user gets errors.  This issue actually
> caused a bit of a fire-drill for us just recently.

And similar to the case-sensitive situation, I'm not sure if we have
checks to avoid D/F conflicts if they happen across the loose/packed
boundary. We might just be using the filesystem as a constraint. I'll
need to dig in more here.

(This is all the more reason why this space is already complicated and
will take some time to unwind.)

> So both kinds of problems already exist, for users with any git client
> version (although the former only for users with unfortunate file
> systems).  And both problems cause pain.  Both issues are caused by
> loose refs, so limiting git storage to packed refs would fix both
> issues.
> 
>> The biggest benefit on the server side is actually for consistency
>> checks. Using a stacked packed-refs (especially with a tip file
>> that describes all of the layers) allows an atomic way to take a
>> snapshot of the refs and run a checksum operation on their values.
>> With loose refs, concurrent updates can modify the checksum during
>> its computation. This is a super niche reason for this, but it's
>> nice that the performance-only focus also ends up with a design
>> that satisfies this goal.
> 
> Ah...so this is the reason for your secondary goal?  Re-reading it
> looks like you did state this, I just missed it without the longer
> explanation.
> 
> Anyway, it might be worth calling out in your cover letter that there
> are (at least) three benefits to this secondary goal of yours -- the
> one you list here, plus the two I list above.

I suppose I assumed that the D/F and case conflicts were a "known"
benefit and a huge motivation of the reftable work. Instead of trying
to solve all of the ref problems at once, I wanted to focus on the
subset that I knew could be solved with a simpler solution, leaving
the full solution to later steps. It would help to be explicit about
how this direction helps solve this problem while also being clear
about how it does not solve it completely.

Thanks,
-Stolee
