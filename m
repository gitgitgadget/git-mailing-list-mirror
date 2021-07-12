Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25FE5C07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 18:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 094EF61206
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 18:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234857AbhGLSXI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 14:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbhGLSXE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 14:23:04 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3345C0613DD
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 11:20:14 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id i5so15264260lfe.2
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 11:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=78axntcylKUgi8k8yIJis9kXgdlIYRTqw5h9t2u1T20=;
        b=vFE6AZB1/x9CaPIWWMS9+RqKkjb5lY/XMBI307owas8kQgnifry1u/r3ipoPZwi8yg
         HnOFkj9SiMnqltFiZoOKfq/fZKU8DZd5iiHze8UHi+TgxOPYZ6lQG0rwIQAjdyHAUaDx
         UqOzPo3ctJ85y6r8PILUMCi+jQGA5x64ND6Y54EMrVUZwPvIje5vKPDkRWp1wiyKX/zE
         WxHli+4I9N22robXlvWO+fnzcXOpeT/foDfozAQh2Vjx2DtD+n2GWrI9M1T9+ydWttjG
         ahN+j62Z23lNDd8Ag4cFk7qs7uJg5JCjC3hsfbaCySeQBsG55HTKL25YJZA6h1GL/x5X
         W2lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=78axntcylKUgi8k8yIJis9kXgdlIYRTqw5h9t2u1T20=;
        b=BrVpagKVcGmtC9ff9BmaWFhmrVBurdKeZLpP28xo0k4lxqsT6MyJM0JJ0APUx892i0
         ndD24Pndl2vuv2LvcQ4jP4lmA9ACuPmbKiN0jBby1ClfE1oX9Y5Ud9d6LEwxjlg9P4BH
         DZ+rdeDfzhCpfiOz2gkJDzqSz3e6mydflh2XZl599J6oZWznP8/v0r/vnnOQqEo/n9qE
         rquT2/H5Tglou5mF1LF9G7e7qXv5sJt7QXge+QLKs2Zir/QYclShxKDEaEyM0aq3LJjp
         1rQetT8n+Eb6kxYv6R2knCAp+YRQVQ2AEnjUM5LWRLZRUYbiziog4QlLq77ara+03ghM
         CMmg==
X-Gm-Message-State: AOAM533CCg3vyD2Ta4avd02ggrbXdj8e8OqNqXtd0L1GZDMPMp1l1cLJ
        3baCmh/usUeh2C1spldDoYbwEvI2tpK6LmpgkZM=
X-Google-Smtp-Source: ABdhPJw3xGUrEI5EaccMFHb0q3oL5XGuBe3k/ahZ3h1c5B4K51JfZ1keDyMipWDQr6XrgwqDdU8+8Zq6qAYOuEvzoJw=
X-Received: by 2002:a05:6512:3f9d:: with SMTP id x29mr47700lfa.221.1626114013323;
 Mon, 12 Jul 2021 11:20:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210711012604.947321-1-alexhenrie24@gmail.com>
 <00e246b1-c712-e6a5-5c27-89127d796098@gmail.com> <xmqqpmvn5ukj.fsf@gitster.g> <CABPp-BERS0iiiVhSsSs6dkqzBVTQgwJUjjKaZQEzRDGRUdObcQ@mail.gmail.com>
In-Reply-To: <CABPp-BERS0iiiVhSsSs6dkqzBVTQgwJUjjKaZQEzRDGRUdObcQ@mail.gmail.com>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Mon, 12 Jul 2021 12:20:01 -0600
Message-ID: <CAMMLpeRX3iMwT9NJ+ULHgAhS3A=nAybgDYFHomkY3sif-H+F4g@mail.gmail.com>
Subject: Re: [PATCH] pull: abort if --ff-only is given and fast-forwarding is impossible
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 12, 2021 at 11:51 AM Elijah Newren <newren@gmail.com> wrote:
>
> On Mon, Jul 12, 2021 at 10:08 AM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Phillip Wood <phillip.wood123@gmail.com> writes:
> >
> > > Thanks for revising this patch, I like this approach much better. I do
> > > however have some concerns about the interaction of pull.ff with the
> > > rebase config and command line options. I'd naively expect the
> > > following behavior (where rebase can fast-forward if possible)
> > >
> > >   pull.ff  pull.rebase  commandline  action
> > >    only     not false                rebase
> > >    only     not false   --no-rebase  fast-forward only
> > >     *       not false    --ff-only   fast-forward only
> > >    only     not false    --ff        merge --ff
> > >    only     not false    --no-ff     merge --no-ff
> > >    only       false                  fast-forward only
> > >    only       false      --rebase    rebase
> > >    only       false      --ff        merge --ff
> > >    only       false      --no-ff     merge --no-ff
> >
> > Do you mean by "not false" something other than "true"?  Are you
> > trying to capture what should happen when these configuration
> > options are unspecified as well (and your "not false" is "either set
> > to true or unspecified")?  I ask because the first row does not make
> > any sense to me.  It seems to say
> >
> >     "If pull.ff is set to 'only', pull.rebase is not set to 'false',
> >     and the command line does not say anything, we will rebase".
>
> I think Phillip is trying to answer what to do when pull.ff and
> pull.rebase conflict.  If I read his "not false" means "is set to
> something other than false", then I agree with his table, but I think
> he missed covering some cases.
>
> I think his table says that pull.rebase=false cannot conflict with
> pull.ff settings, but any other value for pull.rebase can.  That makes
> sense to me.
>
> I'd similarly say that pull.ff=true cannot conflict with any
> pull.rebase settings...but that both pull.ff=only AND pull.ff=false
> conflict with pull.rebase={true,merges}.
>
> My opinion would be:
>   * conflicting command line flags results in the last one winning.
>   * --no-rebase makes pull.ff determine the action.
>   * --ff makes pull.rebase determine the action.
>   * any other command line flag (-r|--rebase|--no-ff|--ff-only)
> overrides both pull.ff and pull.rebase
>   * If no command line option is given, and pull.ff and pull.rebase
> conflict, then error out.
>
> I believe my recommendation above is consistent with every entry in
> Phillip's table except the first line (where I suggest erroring out
> instead).

I'm not sure that --no-ff should imply --no-rebase because `git
rebase` actually has a --no-ff option to rewrite commits even when
fast-forwarding is possible. And it's not really necessary to make
--ff-only imply --no-rebase because we're going to make `git pull`
handle --ff-only itself without invoking `git merge`. However, the
rest of this proposal could be implemented in a straightforward manner
by making --rebase on the command line imply --ff, and I think that
would be a fine solution.

-Alex
