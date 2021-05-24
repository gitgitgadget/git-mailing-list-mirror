Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FE6C2B9F7
	for <git@archiver.kernel.org>; Mon, 24 May 2021 23:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60CBE613D2
	for <git@archiver.kernel.org>; Mon, 24 May 2021 23:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbhEXXCX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 May 2021 19:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhEXXCW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 May 2021 19:02:22 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26904C061574
        for <git@vger.kernel.org>; Mon, 24 May 2021 16:00:53 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id s22so44024396ejv.12
        for <git@vger.kernel.org>; Mon, 24 May 2021 16:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=JXkWCWjvDnKCue786e1JMhRnmaKtpuBHOXnAZHBxqt0=;
        b=GyEwEIo6YD0YFNhHZTgDPjnTSTy7sPvi8Rwy4w+9fAMmj+mz1EXSNJ5+YH9zG/R/8V
         vfA2ezRh0uwjAgXqzYzdSfETOn22i6/V6c6LFxyaFApA+k30sWOm8KqwUPdz6u8Vjcwa
         RzqirUSdx0W4HttjHVwhrluWn4LlEQhgv7ytYKzDZclk3ekg+WH9XU5u8wgstJdxDm4L
         vA3EcmnMrzyUadmnsXzS/vfbYkimy1Tjo2gZKRon1qG9Mqqf6ESNyEbgMU2+XIgIUmTx
         BThvDcbyyg8Biynv27mr685SH9OxAOAd3wvUpvGcLuFFwZ+8sNJJM5yig4uTFaIgVxFC
         dspA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=JXkWCWjvDnKCue786e1JMhRnmaKtpuBHOXnAZHBxqt0=;
        b=bfvY6wJfWHnhdb1kBNjZKkrc1MuabbAX9ubgPZTI362FEsDxzs/MBr/DalT9UJis3m
         9HgucD8R41Al0K8JVeP4pntBC7LUj6QkM+lqqXCY78uutIlAb4CgBdXS1frH2NMX07Xa
         /LOkBaS7vT91Q/+Y/yuRugxJxEEdxqF2hTs/G15zkL5iF4piGPib5+o+mKpURF7Iv3rO
         ypGCkFQWh7tWFlxUqkZ/PCWk/h5RbT/m0hfwNFuCjD8p9pH0SI9t4da91MVVvtGXlxvY
         h2arDKennIeENGVg6MPNZvwsvr0pBafeHkaF0flkhHVOioHQm3E7ejzv8Qmg8VVjVWn0
         S4yw==
X-Gm-Message-State: AOAM533LRNM5MPgVywrS9pnJr7CSw6dCS6be/cd0qCLV5GWc3KKTgv0Y
        UZoN75PuI7h2O2wT6eeRog0=
X-Google-Smtp-Source: ABdhPJwTxNx1SEfy8ehiPP801FJnPLdFQvdr/MnNUiS/A4cUMSuUFNpIE1741G5nfDRH8lP+Yeb5cw==
X-Received: by 2002:a17:906:4341:: with SMTP id z1mr25885393ejm.422.1621897251624;
        Mon, 24 May 2021 16:00:51 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id t14sm1340365edv.27.2021.05.24.16.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 16:00:51 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] t1092: use GIT_PROGRESS_DELAY for consistent results
Date:   Tue, 25 May 2021 00:57:52 +0200
References: <pull.960.git.1621886108515.gitgitgadget@gmail.com>
 <YKwMU13DOtTIgaeP@google.com>
 <e35b5217-362f-fc4f-7396-08218a9abf63@gmail.com>
 <YKwd2e5VxVmU6zqj@nand.local>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <YKwd2e5VxVmU6zqj@nand.local>
Message-ID: <87fsybohy5.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, May 24 2021, Taylor Blau wrote:

> On Mon, May 24, 2021 at 04:38:18PM -0400, Derrick Stolee wrote:
>> On 5/24/21 4:28 PM, Jonathan Nieder wrote:
>> > Hm, I think this test strategy is going to be fundamentally flaky
>> > regardless: Git doesn't intend to guarantee any kind of stability in
>> > the exact stderr output it writes.
>>
>> There are no expectations that stderr is stable across
>> versions of Git. These tests don't add friction to developers
>> making new features or changing the error messages that appear
>> over stderr. It's just that these tests should catch any
>> unintended inconsistency across these modes.
>
> I agree with Stolee that these tests are valuable for asserting that
> output is the consistent whether or not you are using the sparse index.
>
> I find setting GIT_PROGRESS_DELAY to a large number to a be a little
> ugly, but there isn't an apparent better way to accomplish the same
> thing. Of course, it would be nice to have an environment variable to
> specify where progress meters are written to, or a global option to
> disable progress meters altogether.
>
> But I don't think this isolated instance should push in the direction of
> adding support for either of the above, regardless of how easy it might
> be.

I don't see why we wouldn't just tweak GIT_PROGRESS_DELAY to support -1
or something for "inf".

It was added as a one-off (it seems for testing, but made public, so not
in the GIT_TEST_* namespace) in 44a4693bfce (progress: create
GIT_PROGRESS_DELAY, 2019-11-25).

The progress.c API will already nicely deal with this case if something
in start_progress_delay() is made to return NULL if we pass a flag down
to it.

> What would perhaps make more sense is to silence the progress meters
> from the commands themselves. AFAICT the only command called by
> run_on_sparse() which generates a progress meter is 'git checkout',
> 'git merge', and 'git submodule', all of which support '--no-progress'.
> Might it be worth passing that option instead of setting
> GIT_PROGRESS_DELAY to a large value?
>
> (For what it's worth, I have no strong opinion either way, so I would be
> happy to attach my Reviewed-by to even the current version of this patch).
>
> Thanks,
> Taylor

