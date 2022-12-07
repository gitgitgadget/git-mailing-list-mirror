Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B040CC352A1
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 12:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiLGMOI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Dec 2022 07:14:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiLGMOG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2022 07:14:06 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC7F64C2
        for <git@vger.kernel.org>; Wed,  7 Dec 2022 04:14:05 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id r26so24571735edc.10
        for <git@vger.kernel.org>; Wed, 07 Dec 2022 04:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0U4CYvg345TgUwslJjrzla9xZtICdqklhsD+VcNIn3c=;
        b=prqPGShLdB1Eue+yzuRJF5K48Lmvy1MbT83dGY9qYPX4r3E3GqV4FAC+apbkldwnhq
         P0DUbNkt7l1gJl3JA1c3tBp9F3+PHr1B0CE9ojN3Y4e+k+v02arZc0/WV78DoFExgkfE
         vXb6kRKEf/J9aDEz2dXUZjRLQVYsXlb/BPFdXw08nGjf/ol76g8JQUNH3i2VFP6Te4Xi
         CNxfoQBZpYGwr2O9FL1g2HoXnfRij+smhsMNti0LVEGyuXrE3gvMDBIhceudO+A/fqs4
         W70ainiVdyHnC4fN6KSVUSvIxmp7xLZYE1GcTpu3YxmHIPQ9wGsHtujF30c/ygQW3jtx
         ys9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0U4CYvg345TgUwslJjrzla9xZtICdqklhsD+VcNIn3c=;
        b=O2AFjPO6nulsTvIDn5HyDZrGjg0ybsyDQJg8GLu5lJB7cO3AQXbg3h4yLfKszm28/A
         8MzZPSfuBytVVgPkKrgive87yzdPEITgUOIMH2QD8GGFvAI3DJ6zgCUhKGByBAyL6SD4
         2sR3vPQr7LuGVMZ2xgs7ZyiYz03EDWe8qneRVwCbmC60Zu+uWy5dnc73RZCmav11Ec4F
         m65hQt8BNMSeE4xADxlVmpGH8HvhI8oGNNhdY6BfAlaE2kMnnoZJ2otwxGT7/Jyh8M6k
         kuM11B+tn0YaGs9RBDK1ViNmfpPxKoN2pmrFUpoVlSkO53dfdOlpL9Pzst8+vlP/OS0N
         jl5g==
X-Gm-Message-State: ANoB5pkgkaCUgbNec21s5BmvYetvQgQtjXK2eHuW51KLZ2isEZWpJdOQ
        l3y2NAnQg0A3BJcrqu+rP9k=
X-Google-Smtp-Source: AA0mqf6iTjkB3HdTkwwAdvNZlHDmkkSgkSz0IA/0wx4Rw4umbn0D6t5En5ZVqnJgmJmMSYvrSM8RgA==
X-Received: by 2002:aa7:d543:0:b0:46c:d2b3:5fbb with SMTP id u3-20020aa7d543000000b0046cd2b35fbbmr10318884edr.305.1670415243422;
        Wed, 07 Dec 2022 04:14:03 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id ha7-20020a170906a88700b007c0bb571da5sm6684832ejb.41.2022.12.07.04.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 04:14:02 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p2tJK-004Ptg-17;
        Wed, 07 Dec 2022 13:14:02 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Victoria Dye <vdye@github.com>
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 1/3] [RFC] tests: add test_todo() to mark known breakages
Date:   Wed, 07 Dec 2022 13:08:25 +0100
References: <pull.1374.git.1665068476.gitgitgadget@gmail.com>
 <472d05111a38276192e30f454f42aa39df51d604.1665068476.git.gitgitgadget@gmail.com>
 <07d963f0-45f2-ed8e-ea08-bcea14386a4d@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <07d963f0-45f2-ed8e-ea08-bcea14386a4d@github.com>
Message-ID: <221207.86cz8v9zsl.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 06 2022, Victoria Dye wrote:

> Phillip Wood via GitGitGadget wrote:
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>> 
>> test_todo() is intended as a fine grained replacement for
>> test_expect_failure(). Rather than marking the whole test as failing
>> test_todo() is used to mark individual failing commands within a
>> test. This approach to writing failing tests allows us to detect
>> unexpected failures that are hidden by test_expect_failure().
>
> I love this idea! I've nearly been burned a couple of times by the wrong
> line in a 'test_expect_failure' triggering the error (e.g., due to bad
> syntax earlier in the test). The added specificity of 'test_todo' will help
> both reviewers and people fixing the underlying issues demonstrated by
> expected-failing tests.
>
>> 
>> Failing commands are reported by the test harness in the same way as
>> test_expect_failure() so there is no change in output when migrating
>> from test_expect_failure() to test_todo(). If a command marked with
>> test_todo() succeeds then the test will fail. This is designed to make
>> it easier to see when a command starts succeeding in our CI compared
>> to using test_expect_failure() where it is easy to fix a failing test
>> case and not realize it.
>> 
>> test_todo() is built upon test_expect_failure() but accepts commands
>> starting with test_* in addition to git. As our test_* assertions use
>> BUG() to signal usage errors any such error will not be hidden by
>> test_todo().
>
> Should this be so restrictive? I think 'test_todo' would need to handle any
> arbitrary command (mostly because of custom functions like
> 'ensure_not_expanded' in 't1092') to be an easy-to-use drop-in replacement
> for 'test_expect_failure'. 
>
> I see there's some related discussion in another subthread [1], but I don't
> necessarily think removing restrictions (i.e. that the tested command must
> be 'git', 'test_*', etc.) on 'test_todo' requires doing the same for
> 'test_must_fail' et al. to be internally consistent. On one hand,
> 'test_todo' could be interpreted as an assertion (like 'test_must_fail'),
> where we only want to assert on our code - hence the restrictions. From that
> perspective, it would make sense to ease restrictions uniformly on all of
> our assertion helpers. 
>
> On the other hand, I'm interpreting 'test_todo' as
> 'test_expect_failure_on_line_N' - more of a "post-test result interpreter"
> than an assertion helper. So because 'test_expect_failure' doesn't require
> the failing line to come from a particular command, I don't think
> 'test_todo' needs to either. That leaves assertion helpers like
> 'test_must_fail' out of the scope of this change, avoiding any hairiness of
> allowing them to assert on arbitrary code.
>
> What do you think?

Are you saying that for the "test_todo" we shouldn't care whether it
exits with a "normal" non-zero or a segfault, abort() (e.g. BUG()) etc?
That's what the "test_must_fail" v.s. "!" is about.

Even if we erased tat distinction I think such a thing would be a
marginal improvement on "test_expect_failure", as we'd at least mark
what line fails, but like "test_expect_failure" we'd accept segfaults as
failures.

but as noted in the upthread discussions I think we should do better and
still check for segfaults etc. I think we have a couple of
"test_expect_failure" now where we expect a segfault, but for the rest
we'd like to know if they start segfaulting.
