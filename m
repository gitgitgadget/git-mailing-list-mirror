Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F3D8C433ED
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 07:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B19B61430
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 07:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237202AbhDUHqI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 03:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237138AbhDUHqG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 03:46:06 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99309C06174A
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 00:45:32 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id d21so28071533edv.9
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 00:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=3wQH4720s+ZpDzyS5BPdlrcuPjrsGa97smvPMXL+aqA=;
        b=bJGMYaaV4+te61ZK/pUgNTPp2UO5ef+BOnI8DkkXaWFCflAqWlc1NAkOZ97p3NVaJn
         G0wa+qKodo0by4Zv1CuaW/B1kyvhsnCA+wSpf6PIesLSqyzFl1fExDWusQeSPK4BCmkY
         /1wlXlnn8XUL27rbIum4wqIRAtouz2U1TvrsNeQwhgZiCz5jCDKUd2PQ8qoEH8dr31fn
         POAN+RnM3YFNA9aOxEO/kIDc38UG17mYrxShv9KnThoW55jLlgBEZd1dYKJSmNCPPijB
         xtjno6umxn3sud2cQ2OMV1i2wn3CzwcDQGEb97mgQVBLdAZEOhHbj9MIGNg6L/rTHmub
         Q7Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=3wQH4720s+ZpDzyS5BPdlrcuPjrsGa97smvPMXL+aqA=;
        b=FiUToA1/pEn0Ho84lti+XONsjHs+X/YSdNk1+KR92T9XtUkIs8FIX0CkGbmjYpLMoO
         MZBYdjktZakr6hCMdg8yPLKOg3w4o8R2JYdt+tKLaZSHK1unxxu9TPYfVaFHCKAf43nw
         cHN9V9Y5wRXJ6vhMFmMB7d7QGzwIkDH7ViIDZZZQXkef3gMx6JCLcu6f1C0RWRfalQOv
         LCa57+FmOefLvBWT8ti6RXzSQSNZeNwcjEHLHkZ/MigmT/jwkTXi7N0cNimvDyosfbgl
         7uVqprkDsHc7pnS/iEID5RRXXTvyKNDai6fC3EH2MRaCBxXVigYl8w1zhtHZj15S+lji
         ob1A==
X-Gm-Message-State: AOAM532Fx800Au7JKciI8wNTD0+E1P6VNEu99FdUwa0Xu1cd+8hopPG5
        SrLKVcdYMj1F0UEdLt6pcHGEwMVx+wc6GQ==
X-Google-Smtp-Source: ABdhPJztaeGzxRt4daDlSU1XnB2UXdEvD5bLFv0+47j2sWH2D58L2EtBLRj3rsdMUeG9L3pcc1uEZA==
X-Received: by 2002:aa7:d5da:: with SMTP id d26mr38083165eds.379.1618991131004;
        Wed, 21 Apr 2021 00:45:31 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id e20sm1484180ejy.66.2021.04.21.00.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 00:45:30 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Patrick Steinhardt <ps@pks.im>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Han-Wen Nienhuys g <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v7 00/28] reftable library
References: <pull.847.v6.git.git.1618255552.gitgitgadget@gmail.com>
 <pull.847.v7.git.git.1618832276.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <pull.847.v7.git.git.1618832276.gitgitgadget@gmail.com>
Date:   Wed, 21 Apr 2021 09:45:29 +0200
Message-ID: <878s5c3wti.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Apr 19 2021, Han-Wen Nienhuys via GitGitGadget wrote:

> The commits up to "hash.h: provide constants for the hash IDs" should be
> good to merge to 'next'.

With how Junio queues things up perhaps submitting this as another
"prep" series would be good, to reduce future reviewer fatigue,
i.e. anything we can make land on master makes re-rolls that much
smaller.

> There are several test fixups, but I've put them in another series because
> GGG enforces max 30 commits.

I left a bunch of comments on the test prep series now. Probably good to
have it split up regardless of GGG limits.

Re the comments I left on the test series. I'm very happy to see the
start of addressing the "it must be tested" concerns I had in
https://lore.kernel.org/git/87wnt2th1v.fsf@evledraar.gmail.com/

But running the test suite with GIT_TEST_REFTABLE=true still yields a
wall of failed tests. I tested with a merger of this and
pr-git-1008/hanwen/reffiles-v1, i.e. what's on "seen" currently.

I don't see the point of having re-rolls of this topic while the test
changes topic it's based on hasn't finished
marking/splitting/refactoring the various tests that do and don't depend
on the file backend.

At least when I review it I'm just left with going in circles digging
into one of those failing test, figuring out if it's really
refs/files-backend.c specific or not etc., and as long as we can't turn
on GIT_TEST_REFTABLE=true in CI as part of this series I don't see a
path to making it advance to next->master.

> Due to using uncompress2, this build fails on the Linux32 builder; what is
> the magic incantation to run autoconf?

Doesn't this just need a NO_UNCOMPRESS2 for Linux32 in ci/lib.sh? See
the lines just below that for e.g. NO_REGEX for another CI target.
