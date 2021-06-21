Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30355C4743C
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 10:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F5FA611BD
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 10:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbhFUKGJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 06:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbhFUKGI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 06:06:08 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47F3C061574
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 03:03:53 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id y7so18856587wrh.7
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 03:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jm8n2bRoFAr/9OV5y5HSo+QMT+sdT0zT1g8KE52u9Bo=;
        b=NLylKjZ5xQfvOzbVqRE7YHIX8gqMOWa2cI/llckqsKWzSi0M2f20RKVf6Aldgm5JD2
         tp8f3f6rwOrnfCEGnholXxGniH9uN9/J/+/v7dzKQE36DdGsgg7r0Ij7XdyByFT0+36p
         oM1obtmZGKBZZoSVzDeTfPkI0iJn0WLQUn7OBC5G/StKFb0/LdWioIBZ7o+I7BLG2mq/
         FfxaFNtHIEaPydvhlJY5vmiBURBSho3cOdHidtqls6Yi3fm8EAsx5AI4Nq1QIe2G7Vk6
         HMGByqbtgl0tjwG+kFzUMsBNXIBj4t8iRqTnfITascRFyXa66wppSuRE6AhEA3+HXewR
         nXsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jm8n2bRoFAr/9OV5y5HSo+QMT+sdT0zT1g8KE52u9Bo=;
        b=czgYkZYFMOFKal/x5LdrunpT3FVnPBBjM6nNRs9QGcLoSkNqjTjPRz4vmVLdQJkdQb
         cBgNeT0JgGMWcYvy7+b0rFvF+0MrYD7bwjVxwdk8yBz1EVWRil3QznWJXaP34h6wieS4
         MtO1zOKdxn+Mul3r+lY86cDY/MziTnBjBp8Xne1ZucCF2jKq5nAxdiKvywYsYTZUkIHN
         g1iHP2qpG+rn7U4zAZWLsZTFNysXmX8uAgyBilbYEZe3qsjMohO5YgBFXB2xy8y767va
         XMP5mFY3Fy3UIs82hRJ6FIUhgCr0B4wULhYFPMSaNbeH/J8OVSGECp69RDAd96AfrjnC
         3jCw==
X-Gm-Message-State: AOAM530skJZSIkqLPu2wonJ7SZNsxVzleltPzqhUFTzPKrRuTiI6cbNS
        7EEfwS6enR91mPDQ1qzrk4Q=
X-Google-Smtp-Source: ABdhPJy4ZLBpSVgAFmzCExoYvu+m3/cIWIFMqwwkqQaQqxj9e4wUQ8VxSbT/GYi6OI5qGkpyP7UsjQ==
X-Received: by 2002:a5d:6646:: with SMTP id f6mr27323266wrw.399.1624269832239;
        Mon, 21 Jun 2021 03:03:52 -0700 (PDT)
Received: from [192.168.1.201] (11.22.198.146.dyn.plus.net. [146.198.22.11])
        by smtp.googlemail.com with ESMTPSA id q7sm6758644wrw.18.2021.06.21.03.03.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 03:03:51 -0700 (PDT)
Subject: Re: [PATCH 00/10] diff --color-moved[-ws] speedups
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.981.git.1623675888.gitgitgadget@gmail.com>
 <87eed1yjcz.fsf@evledraar.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <094f5e5f-d447-8867-a9a7-be5c8827bba6@gmail.com>
Date:   Mon, 21 Jun 2021 11:03:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87eed1yjcz.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 16/06/2021 15:24, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Jun 14 2021, Phillip Wood via GitGitGadget wrote:
> 
>> The current implementation of diff --color-moved-ws=allow-indentation-change
>> is considerably slower that the implementation of diff --color-moved which
>> is in turn slower than a regular diff. This patch series starts with a
>> couple of bug fixes and then reworks the implementation of diff
>> --color-moved and diff --color-moved-ws=allow-indentation-change to speed
>> them up on large diffs. The time to run git diff --color-moved
>> --no-color-moved-ws v2.28.0 v2.29.0 is reduced by 33% and the time to run
>> git diff --color-moved --color-moved-ws=allow-indentation-change v2.28.0
>> v2.29.0 is reduced by 88%. There is a small slowdown for commit sized diffs
>> with --color-moved - the time to run git log -p --color-moved
>> --no-color-moved-ws --no-merges -n1000 v2.29.0 is increased by 2% on recent
>> processors. On older processors these patches reduce the running time in all
>> cases that I've tested. In general the larger the diff the larger the speed
>> up. As an extreme example the time to run diff --color-moved
>> --color-moved-ws=allow-indentation-change v2.25.0 v2.30.0 goes down from 8
>> minutes to 6 seconds.
>>
>> Phillip Wood (10):
>>    diff --color-moved=zerba: fix alternate coloring
>>    diff --color-moved: avoid false short line matches and bad zerba
>>      coloring
>>    diff: simplify allow-indentation-change delta calculation
>>    diff --color-moved-ws=allow-indentation-change: simplify and optimize
>>    diff --color-moved: call comparison function directly
>>    diff --color-moved: unify moved block growth functions
>>    diff --color-moved: shrink potential moved blocks as we go
>>    diff --color-moved: stop clearing potential moved blocks
>>    diff --color-moved-ws=allow-indentation-change: improve hash lookups
>>    diff --color-moved: intern strings
> 
> Nice to see these land after the earlier on-list reference to them.
> 
> I skimmed these mostly, and am not familiar with this code, but didn't
> see any glaring things missing. There was one existing oddity with
> assigning a 0 to an "enum diff_symbol", don't we want
> DIFF_SYMBOL_BINARY_DIFF_HEADER? In any case, it's just a line you touch
> in 02/10, and pre-dates these changes.

Thanks for taking a look at these patches. I take your point about the 
assignment, I don't think the actual value matters so long as it's not 
DIFF_SYMBOL_PLUS or DIFF_SYMBOL_MINUS.

> One thing I would very much like to see here is a conversion of the
> existing ad-hoc benchmarks you note in commit messages to something that
> lives in t/perf/, it really helps future maintenance of perf-sensitive
> code to be able to re-run those, and I for one find the output much
> easier to read than whatever tool you're using to produce your
> benchmarks.

Adding some perf tests is a good idea, I'll do that when I reroll which 
may take a couple of weeks as I'm going offline for a while at the end 
of the week. The tool I have been using is hyperfine[1], it has been 
used by a few other contributors (see `git log --grep σ` if you're 
interested)

[1] https://github.com/sharkdp/hyperfine

Best Wishes

Phillip

