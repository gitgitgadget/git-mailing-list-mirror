Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37001C433F5
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 20:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 122BF610FC
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 20:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbhJFULS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 16:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbhJFULR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 16:11:17 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A249C061746
        for <git@vger.kernel.org>; Wed,  6 Oct 2021 13:09:24 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id i132so3863072qke.1
        for <git@vger.kernel.org>; Wed, 06 Oct 2021 13:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=Q1Xx68Q7oCCOc+YtOShdmrk+R/tBcphkR8kluE9ReQM=;
        b=QrNbToX4qqYYABnY3Nq8J2DABibH71B2IKWSSLr/JtdwkLK74pm/RKmmUJJjPKinrF
         C5DeYxO/BhKh5wETV6YsoKutpOUnFjxzynt9bf9D3epi89kJWeZHQJnI0GXde5FYiFu/
         EXcH49E4ry/8a4Qv8AIfESopfqS7PdpAOvO7e15jEaH+7fNpPjcku9rllfztdGqqYht4
         4PrHuAw/xN6WSKOyguV3PVUirSOTW/jqOV9l5bfkAT2ABbfmrYw0JQOThL7aKq/OtXdM
         meyrpnxhSIugnSACGZsl1cnjiiP1LbFPuXfQOmKhQNM/qAYPdB2F9XJvTz2UY0Mnyy1j
         ujKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=Q1Xx68Q7oCCOc+YtOShdmrk+R/tBcphkR8kluE9ReQM=;
        b=uxXwF+mAbuu/0/52MCNBS+AyItRIZ3C0Khm32hdl4eqNjaaajIIa9bfgvCa3pAqW5q
         2Y0Tb22mg8WqWbDeuS9gHTnYZN29lt4Os7OTKJzI9MALaAglfw7cL6hOE4ly3LZesVsW
         g62bD16m22gmzowA7HpH/I12n94IKM6TGNG7YhBZAcT75S/99FgBiqMy7WQoJUAN8h2R
         xrZX4ix1UQyXbU+4bD5OGq4olvrikDMvECXKXEbUWH3FiI0gC+uo1vhDmzKp8K825Y54
         U2BBTN4k4Nr1KjGi9gE5wPItj94gLOLZalfDNMHrcNgMaMbC6R9SMdwpB7aZuXodP167
         nOWw==
X-Gm-Message-State: AOAM532pctUizSjsxl5j3pDXu0tpZP4h1P4IgLyFkBcCV0xaFeFnXJGk
        oGTdR4iK6nvS9/4rSu9GOrmS
X-Google-Smtp-Source: ABdhPJxE0EZIbjlgBYYmeJajwRe+KryHcazNSU90fD46I1Tx2ZdRN/OtEPpbN5Sk5EjMDmUruk9sYA==
X-Received: by 2002:a37:a34f:: with SMTP id m76mr133932qke.172.1633550963608;
        Wed, 06 Oct 2021 13:09:23 -0700 (PDT)
Received: from [192.168.0.105] (70.15.20.152.res-cmts.sm.ptd.net. [70.15.20.152])
        by smtp.gmail.com with ESMTPSA id m6sm13453289qti.38.2021.10.06.13.09.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Oct 2021 13:09:22 -0700 (PDT)
Message-ID: <24e500f9-cc63-2288-5be2-ec6ac2104025@github.com>
Date:   Wed, 6 Oct 2021 16:09:21 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.1.2
From:   Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v2 1/7] reset: behave correctly with sparse-checkout
To:     Elijah Newren <newren@gmail.com>,
        Kevin Willford via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Kevin Willford <kewillf@microsoft.com>
References: <pull.1048.git.1633013461.gitgitgadget@gmail.com>
 <pull.1048.v2.git.1633440057.gitgitgadget@gmail.com>
 <22c69bc60308fef13acd7c3aab4e11e175c89440.1633440057.git.gitgitgadget@gmail.com>
 <CABPp-BFFG=puwpB4Gz8nWU=CNMUrLbH7XPTkpSGqWedTK2NWLg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CABPp-BFFG=puwpB4Gz8nWU=CNMUrLbH7XPTkpSGqWedTK2NWLg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren wrote:
>> -               int is_missing = !(one->mode && !is_null_oid(&one->oid));
>> +               struct diff_filespec *two = q->queue[i]->two;
>> +               int is_in_reset_tree = one->mode && !is_null_oid(&one->oid);
> 
> Isn't !is_null_oid(&one->oid) redundant to checking one->mode?  When
> does the diff machinery ever give you a non-zero mode with a null oid?
> 

It looks like this originally only checked the mode, and the extra OID check
was introduced in ff00b682f2 (reset [<commit>] paths...: do not mishandle
unmerged paths, 2011-07-13). I was able to remove `!is_null_oid(&one->oid)`
from the condition and run the `t71*` tests without any failures, but I'm
hesitant to remove it on the off chance that this handles a case I'm not
thinking of.

> Also, is_in_reset_tree == !is_missing; I'll note that below.
> 
>>                 struct cache_entry *ce;
>>
>> +               /*
>> +                * If the file being reset has `skip-worktree` enabled, we need
>> +                * to check it out to prevent the file from being hard reset.
> 
> I don't understand this comment.  If the file wasn't originally in the
> index (is_missing), and is being added to it, and is correctly marked
> as skip_worktree, and the file isn't in the working tree, then it
> sounds like everything is already in a good state.  Files outside the
> sparse checkout are meant to have the skip_worktree bit set and be
> missing from the working tree.
> 
> Also, I don't know what you mean by 'hard reset' here.
> 
>> +                */
>> +               pos = cache_name_pos(two->path, strlen(two->path));
>> +               if (pos >= 0 && ce_skip_worktree(active_cache[pos])) {
>> +                       struct checkout state = CHECKOUT_INIT;
>> +                       state.force = 1;
>> +                       state.refresh_cache = 1;
>> +                       state.istate = &the_index;
>> +
>> +                       checkout_entry(active_cache[pos], &state, NULL, NULL);
> 
> Does this introduce an error in the opposite direction from the one
> stated in the commit message?  Namely we have two things that should
> be in sync: the skip_worktree flag stating whether the file should be
> present in the working directory (skip_worktree), and the question of
> whether the file is actually in the working directory.  In the commit
> message, you pointed out a case where the y were out of sync one way:
> the skip_worktree flag was not set but the file was missing.  Here you
> say the skip_worktree flag is set, but you add it to the working tree
> anyway.
> 
> Or am I misunderstanding the code?
> 

Most of this is addressed in [1], and you're right that what's in this 
patch isn't the right fix for the problem. This patch tried to solve the
issue of "skip-worktree is being ignored and reset files are showing up 
deleted" by continuing to ignore `skip-worktree`, but now checking out the
`skip-worktree` files based on their pre-reset state in the index (unless
they, for some reason, were already present in the worktree). However, that
completely disregards the reasoning for having `skip-worktree` in the first
place (the user wants the file *ignored* in the worktree) and violates the
premise of `git reset --mixed` not modifying the worktree, so the better
solution is to set `skip-worktree` in the resulting index entry and not
check out anything.

[1] https://lore.kernel.org/git/9b99e856-24cc-03fd-7871-de92dc6e39b6@github.com/

>> +               }
>> +
> 
> [I did some slight editing to the diff to make the next two parts
> appear next to each other]
> 
>> -               if (is_missing && !intent_to_add) {
>> +               if (!is_in_reset_tree && !intent_to_add) {
> 
> I thought this was some subtle bugfix or something, and spent a while
> trying to figure it out, before realizing that is_in_reset_tree was
> simply defined as !is_missing (for some reason I was assuming it was
> dealing with two->mode while is_missing was looking at one->mode).  So
> this is a simple variable renaming, which I think is probably good,
> but I'd prefer if this was separated into a different patch to make it
> easier to review.
> 

Good call, I'll include this in V3.
