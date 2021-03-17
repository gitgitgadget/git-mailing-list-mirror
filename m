Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA44C433DB
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 21:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E9B064F17
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 21:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbhCQVeV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 17:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbhCQVd6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 17:33:58 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B69DC06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 14:33:57 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id f124so40538756qkj.5
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 14:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DO7vT8XoAyMBmFA4Ym2bFz0lKH7eTWF8CDSxbfD5BEc=;
        b=I8Jenoz3VfhNrdogWlRMs/kiUCAVUq63WqtEsRHhbi1X1a4SzPllTK3MREei76QO+R
         kq/PQErv5OLNq8Vq4vfw+VggqpSLNUifKXlCjlMgBSIm815QuyMKyIT1WYF2sMpk7JYo
         i9rUSh6PopsfxbkaB09jkQ0XDtQdVPj4H8O70ncw3+v3Pr6WgtWk4ToAxalp4gp+r21M
         QxWOtMP3NW41A+iZ/b+2g7QY9se2pHeCOWNamEHWfBv7x0dytixA6Iho5dBltQWpJonj
         xLmKmVzLc1oL6lb+b6ASc5g4Uh9jc5iGzLfcx7BmJ8R0wHYVp0x73tVB09CV1Uvs185R
         +RHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DO7vT8XoAyMBmFA4Ym2bFz0lKH7eTWF8CDSxbfD5BEc=;
        b=XSQOPgleAGFOj8dJNrg7VXRTqQrcWkW991XChh7QMYmz4fDhS/SP48gQ0oLRhyUt4w
         OCqrDso4qZJIBxzqzVTW0hjQcX9DuWlABz/gr0Lm+VpTyDamdGFXe9aqETHsZA3q6l3o
         yy9+NfEMWivBmxOtsyxwJqLJv2BjtfgEeXfUUyMeklwQr8SoMtr1rcWrNCRQp58q0TXv
         Wub2DFSnLv8aMuLoERbHv8MVPbEDoEjXkAHLOndlPFxKAfDi/3JRrSuUIFmgrIME9S47
         YAJ4g5yOVsF4VExP9AYT1DRug6Fgue0WyM0NK+2RfbC+KLUbZkl0fmKYKMQQ1zq1n+HX
         agQA==
X-Gm-Message-State: AOAM533qju5sIoyURQnu2M6ncLNAVwRjUqCwLa+vJKn2/GPPsMnjZRJu
        pmYxN8+vg9zmn1NHsjARdAs=
X-Google-Smtp-Source: ABdhPJy6METlYokBO4G9UW04VZn5rODxJJPSFZM62OIz1UzUCbjDmBSMyAEuCpo81hKadXYOzxgAdA==
X-Received: by 2002:a05:620a:248e:: with SMTP id i14mr1309602qkn.245.1616016836552;
        Wed, 17 Mar 2021 14:33:56 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:5df9:6440:37ca:197f? ([2600:1700:e72:80a0:5df9:6440:37ca:197f])
        by smtp.gmail.com with ESMTPSA id i9sm199067qko.69.2021.03.17.14.33.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Mar 2021 14:33:56 -0700 (PDT)
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
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <5c886fd7-710d-ac4a-c63a-c1d000c29126@gmail.com>
Date:   Wed, 17 Mar 2021 17:33:55 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CABPp-BH-c8gzrkOFFNb=8b8R+X+VRXsziKoE_RtcR4mh6zjR4g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/17/2021 5:10 PM, Elijah Newren wrote:
> On Wed, Mar 17, 2021 at 1:05 PM Derrick Stolee <stolee@gmail.com> wrote:
>>
>> On 3/17/2021 1:50 PM, Elijah Newren wrote:
>>> On Tue, Mar 16, 2021 at 2:17 PM Derrick Stolee via GitGitGadget
>>> <gitgitgadget@gmail.com> wrote:
>>> With the caveat in the commit message, this change looks okay, but
>>> checkout-index may be buggy regardless of the presence of
>>> ensure_full_index().  If ensure_full_index() really is needed here
>>> because it needs to operate on all SKIP_WORKTREE paths and not just
>>> leading directories, that's because it's writing all those
>>> SKIP_WORKTREE entries to the working tree.  When it writes them to the
>>> working tree, is it clearing the SKIP_WORKTREE bit?  If not, we're in
>>> a bit of a pickle...
>>
>> Perhaps I'm unclear in my intentions with this series: _every_
>> insertion of ensure_full_index() is intended to be audited with
>> tests in the future. Some might need behavior change, and others
>> will not. In this series, I'm just putting in the protections so
>> we don't accidentally trigger unexpected behavior.
> 
> I think this may be part of my qualms -- what do you mean by not
> accidentally triggering unexpected behavior?  In particular, does your
> statement imply that whatever behavior you get after putting in
> ensure_full_index() is "expected"?  I think I'm reading that
> implication into it, and objecting that the behavior with the
> ensure_full_index() still isn't expected.  You've only removed a
> certain class of unexpected behavior, namely code that wasn't written
> to expect tree entries that suddenly gets them.  You haven't handled
> the class of "user wants to work with a subset of files, why are all
> these unrelated files being munged/updated/computed/shown/etc."
> unexpected behavior.

My intention is to ensure that (at this moment) choosing to use
the on-disk sparse-index format does not alter Git's end-to-end
behavior.

I want to avoid as much as possible a state where enabling the
sparse-index can start changing how Git commands behave, perhaps
in destructive ways.

By adding these checks, we ensure the in-memory data structure
matches whatever a full index would have created, and then the
behavior matches what Git would do there. It might not be the
"correct" behavior, but it is _consistent_.

> I'm worrying that expectations are being set up such that working with
> just a small section of the code will be unusably hard.  There may be
> several commands/flags where it could make sense to operate on either
> (a) all files in the repo or (b) just on files within your sparse
> paths.  If, though, folks interpret operate-on-all-files as the
> "normal" mode (and history suggests they will), then people start
> adding all kinds of --no-do-this-sparsely flags to each command, and
> then users who want sparse operation have to remember to type such a
> flag with each and every command they ever run -- despite having taken
> at least three steps already to get a sparse-index.
> 
> I believe the extended discussions (for _months_!) on just grep & rm,
> plus watching a --sparse patch being floated just in the last day for
> ls-files suggest to me that this is a _very_ likely outcome and I'm
> worried about it.

It's these behavior changes that I would like to delay as much as
possible and focus on the format and making commands fast that don't
need a change in behavior.

(Yes, there will be exceptions, like when "git add" specifically
adds a file that is in a directory that should be out of the cone,
but the user added it anyway. Atypical behavior like that can be
slow for now.)

>> Since tests take time to write and review, I was hoping that these
>> insertions were minimal enough to get us to a safe place where we
>> can remove the guards carefully.
>>
>> So with that in mind...
>>
>>> Might be nice to add a
>>> /* TODO: audit if this is needed; if it is, we may have other bugs... */
>>> or something like that.  But then again, perhaps you're considering
>>> all uses of ensure_full_index() to be need-to-be-reaudited codepaths?
>>> If so, and we determine we really do need one and want to keep it
>>> indefinitely, will we mark those with a comment about why it's
>>> considered correct?
>>>
>>> I just want a way to know what still needs to be audited and what
>>> doesn't without doing a lot of history spelunking...
>>
>> ...every insertion "needs to be audited" in the future. That's a
>> big part of the next "phases" in the implementation plan.
>>
>> As you suggest, it might be a good idea to add a comment to every
>> insertion, to mark it as un-audited, such as:
>>
>>         /* TODO: test if ensure_full_index() is necessary */
>>
>> We can come back later to delete the comment if it truly is
>> necessary (and add tests to guarantee correct behavior). We can
>> also remove the comment _and_ the call by modifying the loop
>> behavior to do the right thing in some cases.
> 
> If it's "needs to be audited for both performance reasons (can we
> operate on fewer entries as an invisible doesn't-change-results
> optimization) and correctness reasons (should we operate on fewer
> entries and given a modified result within a sparse-index because
> users would expect that, but maybe provide a special flag for the
> users who want to operate on all files in the repo)" and there's also
> an agreement that either audited or unaudited ones will be marked (or
> both), then great, I'm happy.  If not, can we discuss which part of my
> performance/correctness/marking we aren't in agreement on?

I will mark all of the ones I'm inserting. My hope is to eventually
remove it entirely except for when disabling the sparse-index. That
is likely too far out to really hope for, but it is the direction I
am trying to go.

As I indicate that we should carefully test each of these instances
where ensure_full_index() _might_ be necessary before removing them,
it is even more important to test the scenarios where the behavior
changes from a full index with sparse-checkout. Preferably, we just
change the behavior under sparse-checkout and then the sparse-index
can match that (see "test_sparse_match" in t1092).

Thanks,
-Stolee
