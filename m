Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C1E0C77B73
	for <git@archiver.kernel.org>; Thu, 20 Apr 2023 13:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbjDTNoR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Apr 2023 09:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbjDTNoP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2023 09:44:15 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94FE5FCA
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 06:44:11 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id t16so2116228ybi.13
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 06:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1681998251; x=1684590251;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9FWwS9bMZ9YXbNBPDV907MOqqmZ64gA36WXnWsJUCAA=;
        b=XBc8FBwTXl5YBxAGZOwNzAFCoSrfzHc2Ac3CxW7gNwNSErFfb/W+/ZiBpAGNIfw0To
         7LHPgL8IVcjJhCxQ8p6qeUk0puym4MoydhbZaNb/T7vQuZ57/9kErYwkWUyQ/0gBlxTJ
         vkfilniIaSYmHx+ihsrvNtqXephwim8rbktVGboM07Jna4ne94SHKyl9Zqz2MK9GYix/
         JETA7Qx7CGHx67lA9d+mwxAxATDO84pdI2IurHaxXiEe//3d4oiilsrzikCMNPE9iW1S
         pdnrsJZZSuBsa9Y3I2ShdZDO2jDH/5ps8T8+urgGX7X5IUApI/VULaDxveTQiSZeeno2
         flNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681998251; x=1684590251;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9FWwS9bMZ9YXbNBPDV907MOqqmZ64gA36WXnWsJUCAA=;
        b=TVdHDytryyjQEWaCD/Ql0PrtVYFPIMwjToGfwt+VZ9s2I/MqvfVXbmXK+miBVYPX4Q
         jlfmd15vxE3h/1H+QTsC7CBn0Om2t7WkqrLAIxupnrMrusSeSfFSJLas6l+6XSBS3ekW
         ymfrPvfWRl20/ad18lsn8xJz621xF729ShZy8WGOhoODRx5u4+SXJF6pGdDMf3OV41Qh
         hBElP0aNfsccwwF1P2lue6GvrJax5F3zeXRNh8idijH2KYWH/y3ZbCY+e+az42upWU7M
         weV3KnK+XWdsjRkmHFb4mrcMhVmchU9j5JzzBjCb9XPklFJ6zBLT6vjHHkbXoGTX6N1C
         VKzg==
X-Gm-Message-State: AAQBX9cRoMRyZuv+mo3zfkkb69groJ5lIcT5AUr3YGmCeNs5nsa/8N/Y
        N1kyNp+3bQKHZKtswWSZTht4
X-Google-Smtp-Source: AKy350ZDBb1vwxOut+I6Tu0uVBGSJR6T0aVdxr0bG0lkED+UrIEO2KZTnHoH0DT9rJEMhhxkz2T+gw==
X-Received: by 2002:a25:d209:0:b0:b92:2e22:aba5 with SMTP id j9-20020a25d209000000b00b922e22aba5mr1375472ybg.11.1681998250748;
        Thu, 20 Apr 2023 06:44:10 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:c9cd:9424:a6a5:5425? ([2600:1700:e72:80a0:c9cd:9424:a6a5:5425])
        by smtp.gmail.com with ESMTPSA id p71-20020a0de64a000000b00545b9498c1asm353402ywe.12.2023.04.20.06.44.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 06:44:10 -0700 (PDT)
Message-ID: <f5dd91a7-ba11-917a-39e2-2737829558cb@github.com>
Date:   Thu, 20 Apr 2023 09:44:08 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 11/14] replay: use standard revision ranges
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        John Cai <johncai86@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
References: <20230407072415.1360068-1-christian.couder@gmail.com>
 <20230407072415.1360068-12-christian.couder@gmail.com>
 <8daf2603-2818-9c9d-7a06-6af2872a045a@github.com>
 <89c78da5-388a-e52b-b20b-e376ac90de14@github.com>
 <CABPp-BGfG3VeY1gOugzig8PLan1AS66BMWnyFSOsLOy-zqLdXw@mail.gmail.com>
 <b9732826-5732-0f87-9527-f49c38514fd7@github.com>
 <CABPp-BG3xNmwbtu+tstLr8bT24rr0gG65ZvD1rEeus_V8OYk=Q@mail.gmail.com>
 <bbdd3697-bc10-f311-dbef-99917603ce4f@github.com>
 <CABPp-BH5rLZyjLD91Bn=xThMXHk=q+kGcqPjPDOT0-N4fHfquA@mail.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <CABPp-BH5rLZyjLD91Bn=xThMXHk=q+kGcqPjPDOT0-N4fHfquA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/20/2023 12:53 AM, Elijah Newren wrote:
> On Tue, Apr 18, 2023 at 6:10 AM Derrick Stolee <derrickstolee@github.com> wrote:
>>
>> On 4/18/2023 1:54 AM, Elijah Newren wrote:
>>> The intention is listed in the subject of the commit message of this
>>> patch.  I've also explicitly stated my desire on this list to make a
>>> tool which replays based on a general range expression multiple
>>> times[2][3][4][5].  And there are tests for general range expressions
>>> in this series being reviewed.  I don't understand why you might think
>>> I didn't intend to use general range expressions.
>>
>> It's one thing to describe commit ranges, and another to include every
>> possible rev-list option.
> 
> Yes, agreed.  So clearly there is room for some middle ground.  :-)
> 
>>> If you want to move git-replay away from setup_revisions(), at a
>>> minimum I think we need a proposal that can be extended to the cases I
>>> highlighted previously:
>>>     * allow specifying several negative revisions (or maybe even zero of them)
>>>     * allow specifying several positive revisions
>>>     * allow standard basic range syntax, i.e. A..B
>>
>> I think supporting these descriptive ranges is nice, but doesn't _need_
>> to be in v1 of the tool. If we need to bake them into the CLI from v1
>> in order to ensure compatibility, then I understand that.
> 
> Wahoo, we're moving towards middle ground.
> 
> I personally think baking them into the CLI in v1 is the easiest way
> to ensure compatibility.  They're part of the long term goal anyway,
> and they are already implemented and tested.  (Well, at least the 2nd
> and 3rd items.  We also have tests with a negative revision, but could
> add ones with more than one.  Having zero negative revisions means
> replaying a root commit onto something else, which the code does not
> yet support.)
> 
>>>     * allow --first-parent
>>>     * allow --ancestry-path[=<commit>]
>>> I think it should also be able to eventually support
>>>     * --branches[=<pattern>]
>>>     * --not
>>>     * --tags[=<pattern>]
>>>     * --remotes[=<pattern>]
>>>     * --glob=<pattern>
>>>     * --exclude=<glob-pattern>
>>>     * --all
>>
>> However, I think very few of these should be generally supported, and
>> if there are reasons to include some then they should be motivated by
>> a specific use case and tested directly.
> 
> None of these need to be in v1.  Some aren't even useful yet without
> other changes that Christian excluded in this initial version.
> 
> But can I take a step back and ask if you are saying few of these
> should be generally supported _in v1_ (which I'm fine with) or _ever_
> (which puts us at total loggerheads)?  It reads to me like you're
> saying the latter, but I can't fathom why.  While I totally understand
> the apprehension with "every possible rev-list option", this is far
> from that extreme and I don't see why flags selecting contiguous
> revision ranges should be of any concern.  They all have usecases, and
> I've even pointed out multiple already.  Going slightly out of order:

(going more out of order)

> * --first-parent:
> 
> This option was already referenced with a usecase in the link "[5]"
> from my last email.  I also listed two other usecases in my
> replay-design-notes file[7].

I agree on this one.

> * --ancestry-path=<commit>:
> 
> I don't see why this option is getting pushback at all.  It was
> invented specifically and almost exclusively for use in git-replay.

(Edited out your explanation.)

I'm still not super convinced that this solves a common user problem,
but you've documented your use case well (in other places). The
problem I see is that the current patch brings it in without having
any of that context.

> * all the others (which can be summarized as shorthands options for
> various sets of multiple positive refs or multiple negative refs):

I think you're over-simplifying here, because...

>> Or, could we extract the portion of setup_revisions() that parses
>> just the revision ranges in to a new setup_revision_ranges() method?
>> It could reject any options that are not directly about revision
>> ranges. This option makes less sense if we are going the allowlist
>> approach.
> 
> However, would the name lead people to think
> that e.g. --reflog, --walk-reflogs, --author, --committer, --grep,
> --min-parents, --max-parents, --cherry-pick are relevant?  Should we
> perhaps use a name like setup_contiguous_revision_ranges() so it's
> clear these flags are disallowed, while things like A, ^B, C..D,
> --first-parent, --ancestry-path, --branches, --remotes, are allowed?

I think one thing that might help bridge the divide here is a
different split when I think of "revision range" and "rev-list options".

We have several categories of rev-list options, and we need to find
the right set to care about and the ones that aren't useful for git-replay:

 1. (What I call revision ranges) a collection of starting revisions,
    each marked as an "include" or "exclude" (A..B includes B,
    excludes A). The --not option helps with defining these starting
    points.

 2. (Walk options) Modifications to how we walk commits, such as
    --first-parent, --ancestry-path. These are so far the kind of
    options you have motivated with use cases.

 3. (Ordering options) Modifications to how those commits are ordered,
    such as --topo-order, --date-order, and --reverse. These seem to
    be overridden by git-replay (although, --reverse probably causes
    some confusion right now).

 4. (Filtering options) A post-walk filter on a per-commit basis.
    This includes --(max|min)-parents, --author, --grep.

note: at this point I'm not sure into which of these categories we
should put time-based options like --since.

My main objection to the generic rev-list options come from allowing
categories (3) and (4), since this is more likely to cause user
confusion rather than actually be of any use to the feature.

While I was not considering (2) to be included in setup_revision_ranges(),
I could see it being valid to include both (1) and (2) in those options.

I would like to see tests for options in category (2) to demonstrate
these use cases and solidify them in our supported scenarios.

> "if we find a motivation"??
> 
> I find this is a bit frustrating.  Several things in the merge-ort
> machinery were designed with these kinds of capabilities in mind.
> git-merge-tree, on my end, was designed, written, submitted, iterated,
> and improved (taking 9+ months) almost solely as a feedback gathering
> mechanism for this tool (it has much simpler design and conflict
> handling needed).  I've been working on the usecases for this tool for
> years, and have put quite a bit of time into this tool already, with
> specific usecases in mind driving how the tool is being written.  And
> I'm specifically motivated by things that rebase cannot do.
> 
> I've linked to several of those usecases multiple times in this thread
> already.  Many were also in the cover letter in this series.  (And
> more are in my replay-design-notes.txt file on my replay branch.)
> 
> I feel like you're brushing aside those repeated attempts to point out
> those usecases as though they don't exist or don't matter, with some
> separate new motivation needed for these options to be allowed?  And
> perhaps saying those usecases should all be *ruled out* apriori,
> because you're concerned the implementation *might* also allow other
> unintended uses?
> 
> Something isn't working here.

I'm trying to read the patches and make sense of what is written there.

The current patch especially is far too lightly documented for what
it is actually implementing.

Even its documentation states this:

+<revision-range>::
+	Range of commits to replay; see "Specifying Ranges" in
+	linkgit:git-rev-parse.

This "Specifying Ranges" section describes exactly category (1) of
what I was talking about, but really the patch enables everything
in "Commit Limiting" from git-rev-list.

Based on what I see in the patch, I can't help but think that the
extra options are an accident.

And _even with the extra context linked elsewhere_ I will still hold
that using something as generic as setup_revisions() isn't a good
practice for software development. It adds too may things that all
at once, some of which I don't think match the purpose of git-replay.
You've convinced me to expand my understanding of what fits in that
category, but I still think we need to test this more. Tests can
demonstrate use cases much better than anything else.

> Is it worth refactoring setup_revision() into more divisible chunks,
> so that callers can make use of just the relevant parts of it?  We
> have numerous other tools looking for revision ranges, which currently
> accept full rev-list options and pass along user-supplied command-line
> arguments to them.  Beyond rev-list/log/shortlog, these seem to
> include at least:
>   * fast-export
>   * blame
>   * cherry-pick
>   * revert
>   * format-patch
>   * bisect (at least the skip subcommand)
>   * stash (at least the show subcommand)
>   * filter-branch (actually, as a horrible shell script, it'll
> continue accepting all rev-list options anyway)
> 
> Some of these could probably get away with non-contiguous revision
> ranges, but most wouldn't find any benefit from:
>   * tree/blob/packing options (e.g. --objects*, --unpacked, --filter*,
> --verify-objects, --in-commit-order)
>   * anything dealing with reflogs (e.g. --reflog, --walk-reflogs)
>   * various forms of history simplification (e.g. --simplify-merges,
> --simplify-by-decoration, --sparse, --show-pulls)
>   * flags related to display (e.g. --pretty, --graph,
> --show-signature, --early-output, --disk-usage, --abbrev-commit,
> --relative-date, --log-size, --left-right, --cherry-mark)
>   * flags related to file contents (e.g. <pathspecs>, --merge,
> --follow, --full-diff, --remove-empty)
> 
> Here's a fun and valid (and innocuous) command.  Guess which flags are
> ignored and which aren't:
> 
>   $ git stash show --graph --relative-date --min-parents=3
> --simplify-merges --cherry --show-pulls --unpacked -v -t -8
> --format=oneline --abbrev=12 --pretty=fuller --show-notes
> --encode-email-headers --always --branches --indexed-objects stash@{0}

This investigation is exactly why I'm concerned about using the
generic setup_revisions(). I've already noticed its use elsewhere
and been disappointed. But I wasn't around when those were written,
so you get the short straw and become the reason I bring it up.

> That all said, while I like the idea of someone dividing
> setup_revisions() into divisible chunks so tools can just use the bits
> that are relevant, and doing so sounds like it'd avoid weird surprises
> from use of unintended flags, I'm surprised that the solution to the
> "setup_revisions() is scary" problem isn't to provide easy-to-use API
> that allows selecting the relevant subsets for each command, but to
> instead expect every one that comes along to do some heavy lifting and
> special whitelisting.  We have half a dozen users in the tree already
> facing these problems, so shouldn't these be fixed and the API made to
> be easy to use more safely so that this problem is solved more
> generally rather than just putting it on each future functionality
> implementor who comes along to work around it in their particular
> situation?

I think a better API is a great idea! Splitting into multiple methods
or providing option flags for "categories" of options allowed would
also work.

But back to my original suggestion: you can also do something simpler
for v1 of git-replay (say, very limited revision parsing such as one A..B
range) so your progress here isn't blocked on refactoring the revisions
API.

Thanks,
-Stolee
