Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6300C4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 09:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9F9361372
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 09:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233888AbhHWJr5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 05:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234619AbhHWJry (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 05:47:54 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA48DC061575
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 02:47:11 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id n12so25269639edx.8
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 02:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=wnQ7pNOe0/J8jLLuIUBzgdQF5+PpuvNpGbSXq3V/Iv8=;
        b=FkIBmEUNatmKNJxKs2MN1nYFwrz89FAj8ScFzLro6jprBv5FLYc5lXZCo5h4Qn5gUP
         Z627Lunh+QfR3+eEmLDbGBVmli/UBVZjWeTWIfsWtWoqbTBVjGZQRrFp2ci4Hbgvm2N9
         SwffY0XbNqccDn7oJ2UP/nK7CPc8NJ8BudoVpdhUa+YQLdvVjg/+VEBStu4QuKDXziqH
         QdS8bov4QwSMzQZY59k0FvqYlAJSaRPKT5ZrzpWK6s6WtJIHKXWAIChsAQI+7bISzIyE
         CopH1stGVeVX5GuRRckqT9RJ3wP2IHrhLmteTBxV0tz508jk9R+nnFKqAh6lsP6UfD3K
         rerA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=wnQ7pNOe0/J8jLLuIUBzgdQF5+PpuvNpGbSXq3V/Iv8=;
        b=PZnnQEoZC2+t1pc7IjwtoitGuzYT9C77bbotuXy98FcDBs+YG5aF3RZDXm8+yg1+WR
         YDLV2FeatUYpLObfpIPY8muR1bjA5WK81A0gdoC35iJYJs7RWBBmSS96xH+MFechQj0j
         /6o2pU3wyNoOGeQBaItbnxQ9EYUfvLlCsRpSh422Y4nqbhTi3hDMQ8ysL2w6tuCwpyMt
         E/0miNxQzZGLqSCc4LNZk7up+/AXL7vR2ITxPEwbL+5cDhtYL58Y55wXi1ECeVz4VwDh
         8tLxja0jzPlmho5GU79ZGtlcwbjicjeS30K9n+Q7q4L3amEUqA8JHDeAN6XZkU9kEmbE
         llYg==
X-Gm-Message-State: AOAM532bDX1DliJAnpXwMS4or2nkzA06pDqy+zkEiQASrbzYXw9JMorV
        ITEKzxx0PL0lbXpDjYT1Sdsms4zDX+1fdg==
X-Google-Smtp-Source: ABdhPJzES+wwam4I7rq9vHs5XqY0gD8fVoWwab4pZ6gGEqDolPBcuGu6Shx2I8SQgN8sp62kr6X4pA==
X-Received: by 2002:a05:6402:2810:: with SMTP id h16mr7526233ede.133.1629712029910;
        Mon, 23 Aug 2021 02:47:09 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id n23sm9045968eds.41.2021.08.23.02.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 02:47:09 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 00/25] Support reftable ref backend for Git
Date:   Mon, 23 Aug 2021 11:08:14 +0200
References: <pull.1054.v2.git.git.1629145036.gitgitgadget@gmail.com>
 <pull.1054.v3.git.git.1629207607.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <pull.1054.v3.git.git.1629207607.gitgitgadget@gmail.com>
Message-ID: <877dgch4rn.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Aug 17 2021, Han-Wen Nienhuys via GitGitGadget wrote:

> This continues the work in https://github.com/git/git/pull/847, which the
> gitgitgadget erroneously closed.
>
> Changes relative to last series (version 20 Jul 2021, tip: 4a5891f )
>
>  * fix HTTP serving
>  * fix t1501 (use absolute paths.)
>  * fix git-new-workdir
>  * fixes for FreeBSD (thanks, carenas@gmail.com!)
>

What's the overall status of this topic vis-a-vis whether it's being
proposed to be integrated or is in more RFC form?

Since we discussed the non-working GIT_TEST_REFTABLE=true in [1] & [2]
there's been fixes to the REFFILES for the tests which has already
landed as c9780bb2ca8 (Merge branch 'hn/prep-tests-for-reftable',
2021-07-13).

But e.g. running t1410-reflog.sh reveals an assert failure() in this
library's own code:

    git: reftable/record.c:1075: reftable_record_copy_from: Assertion
    `src->ops->type == rec->ops->type' failed.

(A *lot* of things in the test suite still fail, I didn't look in any
detail. Just highlighting that it's not just remaining failures due to
hardcoding of .git/refs/*).

I took your reply in [2] to mean that you were on board with the plan I
proposed in [1], but aside from the limited REFFILES fixes the structure
of what's here seems relatively unchanged.

So is this series still considered RFC-esque, or what's the plan to move
this forward at this point?

1. https://lore.kernel.org/git/87h7jqz7k5.fsf@evledraar.gmail.com
2. https://lore.kernel.org/git/CAFQ2z_P8vgY0RRT+XSH9K3VDQt39FLqXx6qfeZqaZPkwhq1w+A@mail.gmail.com
