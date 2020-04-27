Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F1AC54FD0
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 17:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9371B206BF
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 17:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="Yf/yJYRI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgD0RPw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 13:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgD0RPw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Apr 2020 13:15:52 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9476AC0610D5
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 10:15:50 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id f18so18422969lja.13
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 10:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wqf++ZATTqa+vmMx1jBLa1pLG9OhHbDEJeQ8OYAPy4E=;
        b=Yf/yJYRIOuCaYbcphO0T+cSlTWEeruRMgWHz6evo5C1WPNMWil5npVT0MUOf2mHpFl
         fH8zO8QGAuxxDJQlm6babxyIGe/gQiVaNnRL0Ti8UdXWp5/eoUkPJlInhmWyamDQmvKs
         RIYske0UQBu/1iK8Iiznp2sbc9CxZGMYDNZJNoNtypMJNtFXTgnAxbg6O/7MVl1Jwgqj
         94yL8g1EQe85morGAvjGTfxCNIqsc1Tx+Dbqd5zn6FH2mp2aotZU2CSxTjSnXgNE0Q09
         DHDmcjv4xSZp9U0IkD1weRxzO346oElvcVJjnQvJb4dlK60GAcztVLbS38ICu+Ru2kuS
         5/7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wqf++ZATTqa+vmMx1jBLa1pLG9OhHbDEJeQ8OYAPy4E=;
        b=QCoVdgFWuJf9FqtEWrg0mmcjLwglfq+0q8a1f2qg39zlDnA+1DtHh/aAg9DTuMaPo4
         Uza5675zLPSG8MnpgTaLBUTfWjcgSJ7LEBjbzDZKzv4KY113HhPSSM7LzaCaDV1iaaXH
         i2Lmz3jPdaqtYzH4eIXWqytQqyUAL9EgtzHnoMdH/1kVZB+ZVBZ1SIrbZvf0ULuXsiV1
         aid6uOASfDSCPvDWCXLCxwllznubtdBnFbi0stLVRtlJA1xiDWSNkOkQS9nDEIfV5zpz
         OKG0JsAzn1qmEfInLYVQVOkD+rDwyWKDs6fBGBuckxLJU0JeNlySFyfG7zWWSka4+1To
         Ecyg==
X-Gm-Message-State: AGi0PubA96WPZAE0ZJJTnm+znitiysEQq9/l3F3DWgzZ0+54EWJ0ZeLJ
        H8ZH+c41+2qh7jCBGAWXMvUSAWbKENR6JDGIMkVk4A==
X-Google-Smtp-Source: APiQypJQll7iuCmvBueJhkmg1AqzrBU0+kDMmbnMr/dQ3foWNuCVyWmZ2Uu1Xk47qnGuqbtOZJEgte9AYmYhuLfG8+g=
X-Received: by 2002:a2e:3009:: with SMTP id w9mr15600444ljw.71.1588007749000;
 Mon, 27 Apr 2020 10:15:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1585027716.git.matheus.bernardino@usp.br>
 <a76242ecfa69cf29995bd859305dc2ab1bc1a221.1585027716.git.matheus.bernardino@usp.br>
 <CABPp-BEbNCYk0pCuEDQ_ViB2=varJPBsVODxNvJs0EVRyBqjBg@mail.gmail.com>
 <xmqq7dz938sc.fsf@gitster.c.googlers.com> <CAHd-oW5qq=dtaSmqcSyxoHd3HPipxjfaiCXtdBQwk9yNVe9okA@mail.gmail.com>
 <CABPp-BE6zW0nJSStcVU=_DoDBnPgLqOR8pkTXK3dW11=T01OhA@mail.gmail.com> <49c1e9a5-b234-1696-03cc-95bf95f4663c@gmail.com>
In-Reply-To: <49c1e9a5-b234-1696-03cc-95bf95f4663c@gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Mon, 27 Apr 2020 14:15:36 -0300
Message-ID: <CAHd-oW4NBEcx4ZHfhTZoWttROmEd9TXQC7kLtXgGATHQY9Gr9w@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] grep: add option to ignore sparsity patterns
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Stolee and Elijah

I think I just finished addressing the comments on patch 2/3 [1]. And
I'm now looking at the ones in 3/3 (this one). Below are some
questions, just to make sure I'm going in the right direction with
this one.

On Tue, Mar 31, 2020 at 5:02 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 3/31/2020 3:12 PM, Elijah Newren wrote:
> >
> > Anyway, maybe it will help if I provide a very rough first draft of
> > what changes we could introduce to Documentation/config/core.txt, and
> > then ask a bunch of my own questions about it below:
> >
> > """
> > core.restrictToSparsePaths::
> >         Only meaningful in conjuntion with core.sparseCheckoutCone.
> >         This option extends sparse checkouts (which limit which paths
> >         are written to the worktree), so that output and operations
> >         are also limited to the sparsity paths where possible and
> >         implemented.  The purpose of this option is to (1) focus
> >         output for the user on the portion of the repository that is
> >         of interest to them, and (2) enable potentially dramatic
> >         performance improvements, especially in conjunction with
> >         partial clones.
...
> > """
> >
> > Several questions here, of course:
> >
> >   * do people like or hate the name?  indifferent?  have alternate ideas?
>
> It's probably time to create a 'sparse-checkout' config space. That
> would allow
>
>         sparse-checkout.restrictGrep = true
>
> as an option. Or a more general
>
>         sparse-checkout.restrictCommands = true
>
> to make it clear that it affects multiple commands.

If we are creating the new namespace, 'core.sparseCheckout' should
also be renamed to something like 'sparse-checkout.enabled', right?
And maybe we could use 'sparsecheckout.*', instead? That seems to be
the convention for settings on hyphenated commands (as in sendemail.*,
uploadpack.* and gitgui.*).

As for compatibility, when running `git sparse-checkout init`, if the
config file already has the core.sparseCheckout setting, should we
remove it? Or just add the new sparsecheckout.enabled config, which
will always be read first?

Also, should we emit a warning about the former being deprecated? The
good thing about deprecation warnings, IMO, is that users will know
the name change faster. But, at least for `git grep <tree>`, where we
read  core.sparseCheckout and core.sparseCheckoutCone for each
submodule and each tree, there would be too much pollution in the
output...

Finally, about restrictCommands, the idea is to have both
sparsecheckout.restrictCommands and `git --restrict-to-sparse-paths`,
right? For now, the option/setting would only affect grep, but support
would be added gradually to other commands in the future. I noticed
git-read-tree already has a --no-sparse-checkout option. Should we
remove this option in favor of the global
--[no]-restrict-to-sparse-paths?

Sorry for too many questions. I just wanted to make sure that I
understood the plan before diving into the implementation, to avoid
going in the wrong direction.

[1]: Here is a sneak peek for v2 of patch 2/3, in case you might want
to take a look:
https://github.com/matheustavares/git/commit/970ef529f1e8f719c4427bd9fea8205ada69d913
