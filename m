Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E9AC07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 16:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57DF961158
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 16:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbhGLQcF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 12:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232710AbhGLQcE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 12:32:04 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134A5C0613DD
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 09:29:15 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id i5so14621393lfe.2
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 09:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=STQ68q86inh7iJZGcfgQPlL9M3Ylcj/zochjn6Gjr/s=;
        b=kP0P1Semxor+PeX5KoiFV04/gooqaV8fEXBlLIxblvgdxYStFvfW2MrbeByBcmJU9N
         L8KY50hR2iVTTVRl/T//T3kI4eiQe+Si42zsenCUJ/v8ptUatsr81ReYxlZBsvYHbdfx
         KQcipLUXwdtT7E7EbIPwZrfZ+QaVGk8lAbHs+FWuDvRWeG/Iq2vrGf5N5ngyHZV6WzgA
         7lTsMeAvfOXUkckQLMic/Qf6JxKdNtt4r78qGIYultGv/zDrO7yB7YP6xHxXmKRQXq2L
         jTQHo6hV2ZPW/bsdrRS+U4RLz3jIbQMrZ1BadU4gjXIZ5sK4JDjSjnN1c74Tke/3V59M
         kfOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=STQ68q86inh7iJZGcfgQPlL9M3Ylcj/zochjn6Gjr/s=;
        b=d5c0dLDDinpdlN5vX9ujodUMC4ug/4RFDO0iNZna687pqMkuvJ7iJnO+7oloOhwUdk
         KAbHP9GTmtot2iDu3zyGmvacLAo9S9+O0euuXZIEgzIeHkGZDW9MKUoGqU+Ygw4Wfrhn
         y/xIQzcCmq66G/Xyivs54Tf3Wndbf23U03mwCopk8tuhMssfyeeDG7otiNbABu9701wR
         +bJuoi5J5B178GOhnhClycU3nspyx8ZuO5EKfqLlblqE9IlQ2HvTtPXd8F/sOqu2Na8G
         58AGEmSzAU4hOUqFDpdH4eu+RctI2QP78a9ffvi+iRA1PXmAOTRWXNwdN9wJSKw9WnDW
         2skw==
X-Gm-Message-State: AOAM532g8qJi3vv1NLmRFfZYqZY19XUMtAxxl6uqMqq3PfvU9wEdfJSw
        kJl6AcSGbZl6yZbXFtX5Bsl7Hy+ttSFLB0Lleqs=
X-Google-Smtp-Source: ABdhPJzUSAFFg17O4hX3pyy3GEAI9/9r/vfE+Qq39rHIjJMSDgC+DZjH8868wJY5BUmfkk8s97Efl88gWhBwG7tW7EM=
X-Received: by 2002:a19:700c:: with SMTP id h12mr41760737lfc.541.1626107353374;
 Mon, 12 Jul 2021 09:29:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210711012604.947321-1-alexhenrie24@gmail.com> <00e246b1-c712-e6a5-5c27-89127d796098@gmail.com>
In-Reply-To: <00e246b1-c712-e6a5-5c27-89127d796098@gmail.com>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Mon, 12 Jul 2021 10:29:02 -0600
Message-ID: <CAMMLpeQYwPDjc8WVFmwVismJPBYAifQS96+R8hDj+pch_db+Qg@mail.gmail.com>
Subject: Re: [PATCH] pull: abort if --ff-only is given and fast-forwarding is impossible
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 12, 2021 at 4:21 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> On 11/07/2021 02:26, Alex Henrie wrote:
> > The warning about pulling without specifying how to reconcile divergent
> > branches says that after setting pull.rebase to true, --ff-only can
> > still be passed on the command line to require a fast-forward. Make that
> > actually work.
>
> Thanks for revising this patch, I like this approach much better. I do
> however have some concerns about the interaction of pull.ff with the
> rebase config and command line options. I'd naively expect the following
> behavior (where rebase can fast-forward if possible)
>
>    pull.ff  pull.rebase  commandline  action
>     only     not false                rebase
>     only     not false   --no-rebase  fast-forward only
>      *       not false    --ff-only   fast-forward only
>     only     not false    --ff        merge --ff
>     only     not false    --no-ff     merge --no-ff
>     only       false                  fast-forward only
>     only       false      --rebase    rebase
>     only       false      --ff        merge --ff
>     only       false      --no-ff     merge --no-ff
>
> I don't think enforcing fast-forward only for rebases makes sense unless
> it is given on the command line. If the user gives `--rebase`
> `--ff-only` on the command line then we should either error out or take
> the last one in which case `pull --rebase --ff-only` would fast-forward
> only but `pull --ff-only --rebase` would rebase. We should also decide
> what to do when the user has pull.ff set to something other than only
> and also has pull.rebase to something other than false set - I'd guess
> we'd want to rebase unless there is a merge option on the command line
> but I haven't thought about those cases.

I was thinking of --rebase and --ff-only as orthogonal variables.
Nevertheless, we could make --rebase imply --ff, which would be pretty
easy to explain in the documentation for the command-line options.
That way, even though pull.rebase=true with pull.ff=only would enforce
fast-forward-only, the user could easily override it with `git pull
-r`. Would you accept that compromise?

-Alex
