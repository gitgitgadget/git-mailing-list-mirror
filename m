Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC04C433E0
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 01:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4239A64F01
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 01:18:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbhCRBRu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 21:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbhCRBRj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 21:17:39 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E88C06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 18:17:39 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id g8-20020a9d6c480000b02901b65ca2432cso3696961otq.3
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 18:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HzpPnB469Sa+Uo5a0Vs6T8urm7xK81W8xnbqc63XLr4=;
        b=ROrtKMCPlHW5EoX3X0Y2Kscyao+H/MXzFNi1zgkbLhf1tJVPY4mYu/eC2cR4MvKYNO
         APfI62iy3IQZHssfBNHQmVWojakuamnvDxUjFIULRus1z7jTGJWG+h9spFxsOAhUN0kO
         BdYWTiP3DmXSfGWdpqoJ7ZBNt29NGT0K6YCr/SWZQBOQ0NKnUoRKNFg0YoeGek98Yh9c
         kvqgaupIjcR4eq5OjyjyptenNMDpghuVtvTOsoTV1x/Em5y3bQQKHOVf5By+6CJcUggy
         3RTNS6KhXqLKg/u7Q1n5pgfUfiCyn14/hQpObZ8ld+Dg6MG4KViMkFmze554hMHBEGvP
         m0+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HzpPnB469Sa+Uo5a0Vs6T8urm7xK81W8xnbqc63XLr4=;
        b=IONokNNa3Qfjn03pZ93GLuYxerINZfl1UgdhnaeoywlZ306Mi4P+yE+Bv0Ex4e/+Wg
         bXEohP9pFGgJxCKOL6OQdborqHwWmEOeBjqFVi5PXB2sJXIozxrPWTZCkism7V4wCf5w
         FzuW3DjYgL1R0yrggYBFipxZu02nV/vPe7NHrJ9CvnuNRqo7XSa5betzq3myp1ZF7j7G
         i8fqwbV5UdsXoKmNfcprGYp5ingb11Do9NkxOkRKHh1L/EFIcscCabpb85noNs4q8Wzo
         ARRn0PRjAsBZIQ5wbe8wKMhWQAgyEJxAGaKQ0N6Ieqw/0URlkJhWFSqT2c7ipR06dPSK
         WA9g==
X-Gm-Message-State: AOAM530aVpN9ERFPne8yRT/JgI7m3qYP9eQjKxBzl9tHzoeMWzztuAO/
        a0rJKiejkIbgHYG9/HqdYRE=
X-Google-Smtp-Source: ABdhPJyZtU/ScgX+PRYKZgI1Gm0DYUr3qni/2gjaDpbWjX6gyqy/33EspK16wRIzBiU3f/Js7QN0ug==
X-Received: by 2002:a05:6830:140e:: with SMTP id v14mr5630236otp.155.1616030258534;
        Wed, 17 Mar 2021 18:17:38 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:1571:3cc6:32d1:78e8? ([2600:1700:e72:80a0:1571:3cc6:32d1:78e8])
        by smtp.gmail.com with ESMTPSA id h24sm128459otg.20.2021.03.17.18.17.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Mar 2021 18:17:38 -0700 (PDT)
Subject: Re: [PATCH 06/27] checkout-index: ensure full index
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.906.git.1615929435.gitgitgadget@gmail.com>
 <bfa0164cc3c167e383cdb5405526202432ae624e.1615929436.git.gitgitgadget@gmail.com>
 <CABPp-BF=-2qD9YodpnhYP49EnKEV=MOFDMUnB-agd-d69jVeQA@mail.gmail.com>
 <08ffff48-7b9c-7113-1a5a-557f3efff26f@gmail.com>
 <CABPp-BH-c8gzrkOFFNb=8b8R+X+VRXsziKoE_RtcR4mh6zjR4g@mail.gmail.com>
 <5c886fd7-710d-ac4a-c63a-c1d000c29126@gmail.com>
 <CABPp-BFaNOY8xPCTBzU+5p7FtWuC0kazh6DpQ1oKYVJNKw+UXg@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ba59413d-d32e-9e03-6c9e-c4b8a93ad3e5@gmail.com>
Date:   Wed, 17 Mar 2021 21:17:37 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CABPp-BFaNOY8xPCTBzU+5p7FtWuC0kazh6DpQ1oKYVJNKw+UXg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/17/2021 6:36 PM, Elijah Newren wrote:
> On Wed, Mar 17, 2021 at 2:33 PM Derrick Stolee <stolee@gmail.com> wrote:
>>
>> On 3/17/2021 5:10 PM, Elijah Newren wrote:
>>> On Wed, Mar 17, 2021 at 1:05 PM Derrick Stolee <stolee@gmail.com> wrote:
>>>>
>>>> On 3/17/2021 1:50 PM, Elijah Newren wrote:
>>>>> On Tue, Mar 16, 2021 at 2:17 PM Derrick Stolee via GitGitGadget
>>>>> <gitgitgadget@gmail.com> wrote:
>>>>> With the caveat in the commit message, this change looks okay, but
>>>>> checkout-index may be buggy regardless of the presence of
>>>>> ensure_full_index().  If ensure_full_index() really is needed here
>>>>> because it needs to operate on all SKIP_WORKTREE paths and not just
>>>>> leading directories, that's because it's writing all those
>>>>> SKIP_WORKTREE entries to the working tree.  When it writes them to the
>>>>> working tree, is it clearing the SKIP_WORKTREE bit?  If not, we're in
>>>>> a bit of a pickle...
>>>>
>>>> Perhaps I'm unclear in my intentions with this series: _every_
>>>> insertion of ensure_full_index() is intended to be audited with
>>>> tests in the future. Some might need behavior change, and others
>>>> will not. In this series, I'm just putting in the protections so
>>>> we don't accidentally trigger unexpected behavior.
>>>
>>> I think this may be part of my qualms -- what do you mean by not
>>> accidentally triggering unexpected behavior?  In particular, does your
>>> statement imply that whatever behavior you get after putting in
>>> ensure_full_index() is "expected"?  I think I'm reading that
>>> implication into it, and objecting that the behavior with the
>>> ensure_full_index() still isn't expected.  You've only removed a
>>> certain class of unexpected behavior, namely code that wasn't written
>>> to expect tree entries that suddenly gets them.  You haven't handled
>>> the class of "user wants to work with a subset of files, why are all
>>> these unrelated files being munged/updated/computed/shown/etc."
>>> unexpected behavior.
>>
>> My intention is to ensure that (at this moment) choosing to use
>> the on-disk sparse-index format does not alter Git's end-to-end
>> behavior.
>>
>> I want to avoid as much as possible a state where enabling the
>> sparse-index can start changing how Git commands behave, perhaps
>> in destructive ways.
>>
>> By adding these checks, we ensure the in-memory data structure
>> matches whatever a full index would have created, and then the
>> behavior matches what Git would do there. It might not be the
>> "correct" behavior, but it is _consistent_.
> 
> That sounds good.  Could this be included in
> Documentation/technical/sparse-index.txt?  There's only an oblique
> reference to it when talking about grep and rm, which incidentally
> were already updated by Matheus.  Perhaps also a reference to the
> warning in Documentation/git-sparse-checkout.txt would be worthwhile.

As I was thinking about how to make this more clear, I realized
that an update to that doc early in this series would be wise.
Thanks.

>>> I'm worrying that expectations are being set up such that working with
>>> just a small section of the code will be unusably hard.  There may be
>>> several commands/flags where it could make sense to operate on either
>>> (a) all files in the repo or (b) just on files within your sparse
>>> paths.  If, though, folks interpret operate-on-all-files as the
>>> "normal" mode (and history suggests they will), then people start
>>> adding all kinds of --no-do-this-sparsely flags to each command, and
>>> then users who want sparse operation have to remember to type such a
>>> flag with each and every command they ever run -- despite having taken
>>> at least three steps already to get a sparse-index.
>>>
>>> I believe the extended discussions (for _months_!) on just grep & rm,
>>> plus watching a --sparse patch being floated just in the last day for
>>> ls-files suggest to me that this is a _very_ likely outcome and I'm
>>> worried about it.
>>
>> It's these behavior changes that I would like to delay as much as
>> possible and focus on the format and making commands fast that don't
>> need a change in behavior.
> 
> Delaying sounds great, just so long as that delay doesn't also cement
> the behavior and confuse consistency for correctness.
> 
> I still think we don't have correct behavior for sparse-checkouts in
> many cases (I mean, when "git reset --hard" throws errors about not
> removing files and then removes them, we've obviously got some
> problems), but we had a decade long cementing of sorts with
> SKIP_WORKTREE and now a year-or-two long cementing since
> sparse-checkout was introduced and we never went through and cleaned
> up the commands. We should at some point, especially since we put the
> huge scary warning in Documenation/git-sparse-checkout.txt expressly
> for this purpose.
> 
> (I would have started this sooner, but trying to feed merge-ort and
> keep up with patch review already keeps me at less time on non-git
> projects than I think is expected for me.  Once merge-ort is done...)
> 
>> (Yes, there will be exceptions, like when "git add" specifically
>> adds a file that is in a directory that should be out of the cone,
>> but the user added it anyway. Atypical behavior like that can be
>> slow for now.)
> 
> I agree that there will be exceptions where we can't make the behavior
> be fast, but I disagree with that specific example.  "git add" should
> just give a warning message and not add any file outside the cone, for
> both sparse-index and sparse-checkout.  That can be done quickly.

That would be great! I would love behavior changes that make the
performance work I'm interested in easier.

> I know you want to delay the discussion of behavior fixes for specific
> commands somewhat, but this particular discussion has already been
> ongoing for about 4-12 months now (started at [1] and [2]) and it's
> reached a point where I've put my Reviewed-by on it; see [3] for the
> git-add piece specifically.
> 
> [1] https://lore.kernel.org/git/9f2135f90ffea7f4ccb226f506bf554deab324cc.1605205427.git.matheus.bernardino@usp.br/
> [2] https://lore.kernel.org/git/0b9b4c4b414a571877163667694afa3053bf8890.1585027716.git.matheus.bernardino@usp.br/
> [3] https://lore.kernel.org/git/66d5c71182274c78e1fcfe84e77deb17e4f0d7e6.1615588109.git.matheus.bernardino@usp.br/

I'm in full support of these ideas to change the behavior, when
possible. I would love to see that those changes make it really
easy to integrate the sparse-index into the commands.

>>>> Since tests take time to write and review, I was hoping that these
>>>> insertions were minimal enough to get us to a safe place where we
>>>> can remove the guards carefully.
>>>>
>>>> So with that in mind...
>>>>
>>>>> Might be nice to add a
>>>>> /* TODO: audit if this is needed; if it is, we may have other bugs... */
>>>>> or something like that.  But then again, perhaps you're considering
>>>>> all uses of ensure_full_index() to be need-to-be-reaudited codepaths?
>>>>> If so, and we determine we really do need one and want to keep it
>>>>> indefinitely, will we mark those with a comment about why it's
>>>>> considered correct?
>>>>>
>>>>> I just want a way to know what still needs to be audited and what
>>>>> doesn't without doing a lot of history spelunking...
>>>>
>>>> ...every insertion "needs to be audited" in the future. That's a
>>>> big part of the next "phases" in the implementation plan.
>>>>
>>>> As you suggest, it might be a good idea to add a comment to every
>>>> insertion, to mark it as un-audited, such as:
>>>>
>>>>         /* TODO: test if ensure_full_index() is necessary */
>>>>
>>>> We can come back later to delete the comment if it truly is
>>>> necessary (and add tests to guarantee correct behavior). We can
>>>> also remove the comment _and_ the call by modifying the loop
>>>> behavior to do the right thing in some cases.
>>>
>>> If it's "needs to be audited for both performance reasons (can we
>>> operate on fewer entries as an invisible doesn't-change-results
>>> optimization) and correctness reasons (should we operate on fewer
>>> entries and given a modified result within a sparse-index because
>>> users would expect that, but maybe provide a special flag for the
>>> users who want to operate on all files in the repo)" and there's also
>>> an agreement that either audited or unaudited ones will be marked (or
>>> both), then great, I'm happy.  If not, can we discuss which part of my
>>> performance/correctness/marking we aren't in agreement on?
>>
>> I will mark all of the ones I'm inserting. My hope is to eventually
>> remove it entirely except for when disabling the sparse-index. That
>> is likely too far out to really hope for, but it is the direction I
>> am trying to go.
>>
>> As I indicate that we should carefully test each of these instances
>> where ensure_full_index() _might_ be necessary before removing them,
>> it is even more important to test the scenarios where the behavior
>> changes from a full index with sparse-checkout. Preferably, we just
>> change the behavior under sparse-checkout and then the sparse-index
>> can match that (see "test_sparse_match" in t1092).
> 
> Makes sense.  I agree that it'd be nice to have the two generally
> match, though I think we should be open to there being special cases
> that differ.  The only one I can think of right now is `git ls-files`
> (list the entries in the index) -- since there are tree entries in a
> sparse-index, ls-files would naturally show the tree entries.
> However, we can discuss that and any other cases -- if there are any
> -- later.

Here, I at least want to make it very clear that the change is
happening and include updates to the documentation. This is a
case where it is unclear what the "promise" is to _external_
tools that depend on ls-files (somehow). What is their intended
use of ls-files, and how do those expectations change when in a
sparse-checkout?

It's questions like this where I at least want to be making a
clear change that motivates why a change in behavior is merited,
then test that behavior to demonstrate that we expect that to be
the same in perpetuity.

Thanks,
-Stolee
