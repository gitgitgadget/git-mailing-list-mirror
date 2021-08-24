Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1744C4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 10:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD3E061357
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 10:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236073AbhHXKWc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 06:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236035AbhHXKWb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 06:22:31 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78AD0C061757
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 03:21:47 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id u3so43290780ejz.1
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 03:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=XvZXchfZVaW7UCBFx4LJ39BfPI6M+dwgIg5qgAgmCX4=;
        b=G6M0P9JOA7agKUc0Fki6ZBL00ycbdALt8mXZ0oCb7vpG/EuB6Jece6kzw6fXQ4n24z
         hhcgA0f+aC6RVsWu4j7Gfr37hvow5oWHs9BidXMvuylZ9zwtAibWb0i+jXHrDsy1gXMB
         tPZaIe0A2yKYE4ass5VeaS/UB/1Fb3WLzqutZbL6McwYLt1201dhwhanTls8DMUXMfhO
         WDHlT1z7ZixqSKf6BddD57FaT59Zj2NBqjWyLt/xS88BGqrGUTZFktwfcoitbpz5ooMU
         VRKAKrnH58g6sf1FwIV6Yhi58Gl7nQm0sgfM9Zz9Kji58QfwJ5UDxTood8Z9ihUXUyQZ
         ktsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=XvZXchfZVaW7UCBFx4LJ39BfPI6M+dwgIg5qgAgmCX4=;
        b=SIfLF+1/K0cvAwQ97Mz00J1rkFmORpihKb8ADNR1h7mTqlSx/egsJF82cFfiSiHdm3
         nY3i9d9sXC2jx/3cMScnzFQFvk49KfhhynSLKClvwirWBOgr3OmEgz1PwBEkAAlWNlcp
         gXOn03+/eM7VQsfAu3R1QcPtaA6mVjCgm1VaG8xdTjXRY/htGAGn+O1nQE7q01zppn1+
         lCAs469BzRmH9asyebK2w1eZ2iml0c7fkGkk0foDUuPWaUtzJF8Dz8J1+hWBvZ+S8f4h
         9cicf7ObNVtHwcZ8eV1hR5pIasZ9dQGuGlbNh30WqRBzvZVM5bexvV3nOEgY7o5XV2Fp
         aw7Q==
X-Gm-Message-State: AOAM531vGSr2DnPUA6Sz9xRTiu9V5JT5/47Bleh5fwnRR50d9wXY9R5G
        RWu9UjpBLq3PD0+3pDwIn2A=
X-Google-Smtp-Source: ABdhPJwNJWheCxx+A3Gi2Vo9QMsr7iTjHiUhon87+8u6WJvqMKK44vOW4agsGljbVEq0b9uAfxVIPg==
X-Received: by 2002:a17:906:b18e:: with SMTP id w14mr40305260ejy.63.1629800505981;
        Tue, 24 Aug 2021 03:21:45 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id ay20sm11362094edb.91.2021.08.24.03.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 03:21:45 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        "Ben Boeckel" <mathstuf@gmail.com>
Subject: Re: What's cooking in git.git (Aug 2021, #08; Mon, 23)
Date:   Tue, 24 Aug 2021 12:08:02 +0200
References: <xmqqo89nq1sa.fsf@gitster.g>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <xmqqo89nq1sa.fsf@gitster.g>
Message-ID: <878s0rf8i0.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Aug 23 2021, Junio C Hamano wrote:

Our E-Mails crossed, but on the "update on my topics" front everything I
noted in the reply to the last What's Cooking is stil current, except as
noted below:
https://lore.kernel.org/git/87v93wflm0.fsf@evledraar.gmail.com/

Also this request to pick up 2x missed topics from me:
https://lore.kernel.org/git/87pmu4fh17.fsf@evledraar.gmail.com/

Oh, and a 3rd one I forgot about, Ben Boeckel's advice.c work which I
fixed failures in and re-rolled at:
https://lore.kernel.org/git/cover-v4-0.4-00000000000-20210823T103719Z-avarab@gmail.com/

> The tip of 'next' has been rewound, and the first batch of this
> cycle should be in 'master' in a few days.  As discussed, let's make
> 'ort' the default early in this cycle.

Yay ORT!

> Most notably, since the "errno cleanup around refs API" topics have
> been blocking the "reftable backend" topic, I've reverted the former
> out of 'next' and moved them to near the tip of 'seen', essentially
> giving priority to the latter.  In other words, I'd expect to see
> that the "reftable" topic to move before the "errno cleanup" topic,
> and also expect that any breakage, when both are merged to 'seen',
> would be resolved by adjusting the "errno cleanup" topic.

Per discussion at
https://lore.kernel.org/git/877dgch4rn.fsf@evledraar.gmail.com/ and
https://lore.kernel.org/git/87y28sfokk.fsf@evledraar.gmail.com/ I think
"errno first" makes sense. I re-rolled my two topics, and submitted a
re-rolled hn/reftable at
https://lore.kernel.org/git/cover-v4-00.28-00000000000-20210823T120208Z-avarab@gmail.com/;
which in combination with the earlier two fixes the issues on "seen".

I.e. it's just hn/reftable with 3x fixup patches at the end, will need
to be rolled/squashed into a re-rolled reftable topic, but for now....

> [...]
> * ab/http-drop-old-curl (2021-07-30) 5 commits
> * ab/bundle-doc (2021-08-02) 4 commits
> * ab/pack-stdin-packs-fix (2021-07-09) 2 commits
> * es/config-based-hooks (2021-08-19) 7 commits
> [...]
>  - Merge branch 'ab/config-based-hooks-base' into es/config-based-hooks
>  (this branch uses ab/config-based-hooks-base.)
> [...]
> * ab/lib-subtest (2021-08-05) 11 commits
> * ab/only-single-progress-at-once (2021-07-23) 8 commits
> * ab/progress-users-adjust-counters (2021-08-05) 3 commits
> * ab/make-tags-cleanup (2021-08-05) 5 commits
> * ab/config-based-hooks-base (2021-08-03) 36 commits
> * ab/serve-cleanup (2021-08-05) 10 commits
> * ab/pack-objects-stdin (2021-07-09) 5 commits
> * ab/refs-files-cleanup (2021-08-19) 11 commits

As noted above please see
https://lore.kernel.org/git/87v93wflm0.fsf@evledraar.gmail.com/ for the
up-to-date summary on these.

> * ab/test-tool-cache-cleanup (2021-06-08) 4 commits
>  - read-cache perf: add a perf test for refresh_index()
>  - test-tool: migrate read-cache-again to parse_options()
>  - test-tool: migrate read-cache-perf to parse_options()
>  - test-tool: split up test-tool read-cache
>
>  Test code shuffling.
>
>  Expecting a reroll.

I finally re-rolled this, sorry about the delay:
https://lore.kernel.org/git/cover-v2-0.4-00000000000-20210824T091204Z-avarab@gmail.com/
