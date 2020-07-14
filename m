Return-Path: <SRS0=b2TE=AZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4437C433E1
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 20:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76E8E2065F
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 20:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="co0i3V59"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbgGNUaZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jul 2020 16:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgGNUaZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jul 2020 16:30:25 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCE0C061755
        for <git@vger.kernel.org>; Tue, 14 Jul 2020 13:30:24 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id g20so19346965edm.4
        for <git@vger.kernel.org>; Tue, 14 Jul 2020 13:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YWPhIh+YpkIkZ7z+RXNNgxBbkdw4HL/0NBXmiLST9fc=;
        b=co0i3V59PADyRRz31MmJRQbYh3bQBgYQp+VS+/3xYq2Df7uL5Gq4MAiPtdgPNNZi1M
         11vn196M1cG1/3Q2rLWtZgqA0K41eous2LJAtmjBPHbgHiuclGkE7OM3CkjZHqaIRF3h
         4M1yLNLgYv/dRvHvwlgQCk8p6NwOKnW2wWLezw9qHwtsSf56Mds7dYy8l4l4VXY+1ZGt
         ngvDICHuGMQiWmjua386xXj9jv51AoLugs/dbGZXVmZPfB/5rt1/aIL2x5nemyPkK1Ju
         rLZcRqgjL6bIXBzgMSSMXle1sNUTXK05gNq5TIVqbHgVj8fiXiBpwWHhFaKRMFRqb7CM
         cMJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YWPhIh+YpkIkZ7z+RXNNgxBbkdw4HL/0NBXmiLST9fc=;
        b=AwV9EXxH9zYJFarROx0klrKZlB1Dp2pRiEHkwJyIYjVcokIkVOZg/08KUsgs3Yjs5j
         eqyqVKZFC9egGH049cRRVa0m5k8h6iF+A+jnVDno79oK6MntU2ZAl0H5HGqfs0QnhRti
         Vw2DvazXHg/RAcpxSe0OQ7qBEioL2TGtiA9stjY42mw2N8yhQoWc/XMfL+mCVwnTub+r
         LOM7dzC3x3lBNlNP1NIqbMNCO42tUOwPcTAjiiAyb0JFfxa4hFhe5a8Z1NTxqtxz+p2I
         QUg7cZRPvyCiNpxWPPuFVWAYoV3QKfqCPUQJR5rN6MjC2eTH3HGol4hqXqUEF7gGiE3o
         U6Tw==
X-Gm-Message-State: AOAM530q1+w3QbQqhf79RfOtoAJKCpkZlMldxSnjeiSliSCE/PewiAqP
        wlVsKkIvvifRHi0DA5Aovmya66RRPdNIR/6W9ztPfm8=
X-Google-Smtp-Source: ABdhPJyvLXhTVH8jyoCxSLvfjYW21iE7UsJGJJlwEmXtg6036x4Q2hRFyClDz/DK5YfsvNBAtLZefMIBOUBaZVeV9hM=
X-Received: by 2002:a05:6402:1ca8:: with SMTP id cz8mr6151377edb.55.1594758623636;
 Tue, 14 Jul 2020 13:30:23 -0700 (PDT)
MIME-Version: 1.0
References: <CACwCsY7YSn_mbtFv3QjL5dY80G6e_r-gGC3SGo5rO5b8LGXxVA@mail.gmail.com>
 <CACwCsY7P5NiQL5ajHMOWo2EPiQZKUj_m_AVbtGy=z=twChimjw@mail.gmail.com> <CAPx1GvcOpmpuPseAQDYk9pg+hfdF9KJSSSiB0fEHQrnUuPS4CA@mail.gmail.com>
In-Reply-To: <CAPx1GvcOpmpuPseAQDYk9pg+hfdF9KJSSSiB0fEHQrnUuPS4CA@mail.gmail.com>
From:   Larry Martell <larry.martell@gmail.com>
Date:   Tue, 14 Jul 2020 16:29:46 -0400
Message-ID: <CACwCsY4p2LSVYK3iWKes2uA0oHj-HPdo4WS0OPzuxQuG7fDbOw@mail.gmail.com>
Subject: Re: Can't checkout branch
To:     Chris Torek <chris.torek@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 14, 2020 at 2:18 PM Chris Torek <chris.torek@gmail.com> wrote:
>
> On Tue, Jul 14, 2020 at 10:04 AM Larry Martell <larry.martell@gmail.com> wrote:
> [snippage]
> > $ git fetch --all
> > Fetching origin
> >  * [new branch]      deploy     -> origin/deploy
> >
> > $ git checkout deploy
> > $ git branch
> > * master
> >
> > $ git checkout origin/deploy
> > Note: checking out 'origin/deploy'.
> >
> > You are in 'detached HEAD' state.
> >
> > I tried deleting the local repo and recloning, but I got the same
> > results. I see the branch on github. I can checkout other branches,
> > just not this one.
> >
> > What could be going on?
>
> This happens in Git versions prior to 2.23 (what Git version are
> you using?) when there is a *file or directory* named `deploy`.
>
> What is happening is that since there is no *branch* named
> deploy (yet), you can't check it out (yet).  So `git checkout
> deploy` initially fails.  The checkout command then goes on
> to try two alternatives:
>
>  1. Treat this as `git checkout -- deploy`, i.e.,
>     extract the file or subtree named `deploy` from
>     the index (discarding changes to that file or
>     subtree).
>
>  2. Treat this as `git checkout -b deploy origin/deploy`
>     or `git checkout -t origin/deploy`, i.e., create the
>     branch `deploy` from `origin/deploy`.
>
> If *both* of these alternatives work, pre-2.23 Git *assumes* you
> meant alternative number 1.  In 2.23 or later, `git checkout`
> tells you that this is ambiguous and makes you pick which one you
> want.
>
> To work around this in all versions of Git, you can just be
> more explicit.  For instance:
>
>     git checkout deploy --
>
> forces Git to treat it as a branch name.

Thanks for the reply - that was indeed the issue - I had a dir named deploy.
