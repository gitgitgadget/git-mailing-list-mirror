Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4181BC6FD18
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 13:10:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjDRNKN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 09:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjDRNKL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 09:10:11 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC00E1A2
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 06:10:09 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-7606ce89ebcso92470539f.0
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 06:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1681823409; x=1684415409;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gcG4jeO8MdjvgdWTMHOtMvA3FZtrI2y8ViOqATqFNk0=;
        b=VX48xYP1KABOQPw9AR835ioWUWaE6juS+0guqNYTNEPnpAHlrJHU8e6jwmKB0zUkXQ
         BP4BUYuUp65gE/Ccd1G1YwRxhZRBMdyV4Sj+QWektxErUAmtF8DN711gO+BLCT/bavpP
         3zt2KuSWdS7OuQMSZn+1dpn8JcI5+kSMYUvv7lm1EPi5Ffz5P6aI+chhZ+YUpbiwKEEJ
         h3KFrGrjvwJMc+ocOHwNC89YKMSMnZVDWA5uva6JedchPw5v0fKw4DFFXjT4GtHs3Eqo
         AY19/PIOJkL/Fh3LqalteVgJ/YrYZRSoY8nhtrqxMfWhkPK+dTqnWm/a8EhVEi0U2RyY
         BRbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681823409; x=1684415409;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gcG4jeO8MdjvgdWTMHOtMvA3FZtrI2y8ViOqATqFNk0=;
        b=btBE219+tR9pPui/zUmgKOO7qEPEFqWeskxts3lwkA4r60D06Mdr/D8shIT+RDHMT2
         3nyd5VoqdLwXsmc2r+ttlG1vC5hcc5PKX2ZoGeeFUWo9nUwVsNcldQQO1hTLR/p2WxVA
         JpZXB3KfzixCBta8QHNTIkNECmfMsKAA07pM0s3EtzGIZX4toFRyPrL2XhiH8oQEJms1
         UETQewvqQkouHm23qZadnRfXSRXIB69MFjoD6la4lnhvOknilHnsm2+FGJCs6ocjTgLj
         n/EpgKP0TsSxlo4I9LH5x1IxuOhCZ9C9mhhxOE0CEkfUD8++bH+rArgTtuRu4s5dgfpb
         70nA==
X-Gm-Message-State: AAQBX9ehV2Mk8tieeHXqySkYUQE2y1y2u3gW42L4Ri0U6aU1MP2k4gbP
        95aHvQ5d7SSmS1yJWSlm/9MCiDSqOhNE9vafgA==
X-Google-Smtp-Source: AKy350a+OfF/0VG848K9LSxMTDFp9ntHyUuqip8xTY55YJQiNXumr96wd901DrgJTEjAEAwzqmtDqw==
X-Received: by 2002:a05:6602:4214:b0:74c:d67a:6fa0 with SMTP id cb20-20020a056602421400b0074cd67a6fa0mr1638779iob.7.1681823409093;
        Tue, 18 Apr 2023 06:10:09 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id b3-20020a029583000000b0040facd270c3sm1240702jai.44.2023.04.18.06.10.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 06:10:08 -0700 (PDT)
Message-ID: <bbdd3697-bc10-f311-dbef-99917603ce4f@github.com>
Date:   Tue, 18 Apr 2023 09:10:06 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 11/14] replay: use standard revision ranges
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
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <CABPp-BG3xNmwbtu+tstLr8bT24rr0gG65ZvD1rEeus_V8OYk=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/18/2023 1:54 AM, Elijah Newren wrote:
> On Mon, Apr 17, 2023 at 7:05 AM Derrick Stolee <derrickstolee@github.com> wrote:
>>
>> On 4/15/2023 3:07 PM, Elijah Newren wrote:

>>> In short, I don't want another limited rebase; I want a more generic tool.
>>
>> The primary value of git-replay (to me) is that we can do "simple" rebases
>> without a worktree or user interaction. To me, simple rebases mean apply a
>> linear sequence of commits from a single branch onto another branch (and
>> specifying an "old base" is simple enough to include here). It also means
>> that we abort completely if there is a conflict (and handle conflict
>> resolution in later changes).
>>
>> The sooner we can deliver that, the better we can deliver on its potential
>> (and expand its functionality to be more generic).
> 
> Limiting the initial scope of this tool to a smaller set of features
> is okay (and, in fact, Christian has already done that), but we really
> need to avoid painting ourselves into a corner if we change the design
> as part of that limiting.  As I stated previously[1], I'm worried this
> is happening.
> 
> [1] https://lore.kernel.org/git/CABPp-BH7ZPBtV5Hu_-_yVdqVmiydW7_s_LYAtwbPuYSbRQiuQw@mail.gmail.com/,
> under "from my view"
> 
>> And this is generally my preference, but we shouldn't get functionality
>> "by accident"
> 
> All of the specific flags and cases you brought up so far were ones I
> already carefully considered over a year ago, so the "by accident"
> comment seems a little unfair.
> 
>> but instead do it with full intention
> 
> The intention is listed in the subject of the commit message of this
> patch.  I've also explicitly stated my desire on this list to make a
> tool which replays based on a general range expression multiple
> times[2][3][4][5].  And there are tests for general range expressions
> in this series being reviewed.  I don't understand why you might think
> I didn't intend to use general range expressions.

It's one thing to describe commit ranges, and another to include every
possible rev-list option.

> If you want to move git-replay away from setup_revisions(), at a
> minimum I think we need a proposal that can be extended to the cases I
> highlighted previously:
>     * allow specifying several negative revisions (or maybe even zero of them)
>     * allow specifying several positive revisions
>     * allow standard basic range syntax, i.e. A..B

I think supporting these descriptive ranges is nice, but doesn't _need_
to be in v1 of the tool. If we need to bake them into the CLI from v1
in order to ensure compatibility, then I understand that.

>     * allow --first-parent
>     * allow --ancestry-path[=<commit>]
> I think it should also be able to eventually support
>     * --branches[=<pattern>]
>     * --not
>     * --tags[=<pattern>]
>     * --remotes[=<pattern>]
>     * --glob=<pattern>
>     * --exclude=<glob-pattern>
>     * --all

However, I think very few of these should be generally supported, and
if there are reasons to include some then they should be motivated by
a specific use case and tested directly.

As it is, these tags do something in this v1, but we can't really be
sure that they work because we're not testing them. That is my
primary complaint. And testing each individually isn't enough,
because they can combine in all sorts of ways.

> That's a long list of things to parse, which setup_revisions() happens
> to handle nicely.  You are right that setup_revisions() also has lots
> of options for generating non-contiguous history that may make little
> or no sense for replay (and makes no sense for fast-export either).
> So, I am willing to consider other solutions if anyone has one, but
> only alternative solutions which can eventually handle the above
> requirements.  In particular, "three commits as positional arguments"
> (with one implicitly being considered a negative ref) conflicts with
> the first three bullet points above.

The only way I can see using setup_revisions() safely is if you make
sure to reject any arguments that start with "--" (or perhaps "-"
because some of those options may have single-character versions).
This could be extended to an allowlist if we find a motivation to
include other options (I see "--not" as being a likely candidate)
in patches that test that interaction.

Or, could we extract the portion of setup_revisions() that parses
just the revision ranges in to a new setup_revision_ranges() method?
It could reject any options that are not directly about revision
ranges. This option makes less sense if we are going the allowlist
approach.

Thanks,
-Stolee
