Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB853C47080
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 04:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A128861207
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 04:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbhFCE2a (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 00:28:30 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:43641 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbhFCE23 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 00:28:29 -0400
Received: by mail-ot1-f47.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso4567272otu.10
        for <git@vger.kernel.org>; Wed, 02 Jun 2021 21:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6bCky5H4ZcqPBrTNOAe/y8D9rcUA9hxRGNlITIrvFww=;
        b=n7Fpqz4Es+Om6rLYaqF6Yj1NXuDMO4fAAdAaS/n/9pX2IqY+uXk0m3KA0mu4R27URl
         bA9q72hn7vMnOauiMEQ/g0vCvTX/NEuBNg5l/uh3PeHTY/yE1pfVNOkY05hGTKto9U6K
         RTBbMw6ZHb4g8K7DOPyGSc3GJ0cWHoJgF207ypaER0zozGL7UoNwClWETC8FYICr/rnZ
         gXhgyg1KEsdbjlVYIp07MrTvrT9SWK6HicHBG9FIypOsZg0r4HmrOQ9vRW7kbkZ+l961
         f/cM8RYOdL6anVoxrpKI4YfqGTrwGcnlHZPvnGGk/lAi6T4ENuXfJ6qCNF50FKkn0Z1z
         wz5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6bCky5H4ZcqPBrTNOAe/y8D9rcUA9hxRGNlITIrvFww=;
        b=ebABSbZCXx0BtYc9Q0eaAyoDPVvTCmhOjrSb17wlub+h/KDhk1xiQRa3H/OAB34kSt
         Z6Lw7L8kDxMfRaWN4we1YhQBTufLymWEG2RKG6V8iGlo9Ph8s8tKIgeqgel6elluHSVA
         76bIOCDI3RS0pccd77SrVmgjBko77BqdQBMl9bSmAiNeO2KiNVZimatQdxm0dMl3fu2Q
         7vxymey7T8KerB2qN5a+oc6rB2mPmuVfsKY+wIvI/Bf/gIihD9HQVpqCa5wYUgfYFWZS
         CmvH7vSW1qPAZJG+df8lLhRzbmCXIC6zvssqzLfgDaBhrBrgNqQ9lVsTNnAllfzd6zy5
         +SNQ==
X-Gm-Message-State: AOAM53045i2NfYUOWdk5LdfL4SUT8LRLuTQu+trfaxH+/xVlc0hiQ1dH
        3WWyElgyjQvfbp2cEaGP2cQc43aYLgiwJqEZtW8=
X-Google-Smtp-Source: ABdhPJyQDLexvho3HOXJDWIMReUEeed0TMU+nfc1KOGBYPspNFVMX1Jeadj/x02UaAlP6o3BSK/P3U5JV+a0YF7i0O0=
X-Received: by 2002:a9d:7096:: with SMTP id l22mr29014654otj.345.1622694332404;
 Wed, 02 Jun 2021 21:25:32 -0700 (PDT)
MIME-Version: 1.0
References: <60b5d281552d6_e359f20828@natae.notmuch> <87wnrd6wqj.fsf@osv.gnss.ru>
 <CABPp-BH7f+sM_POEsSSvmz_p=oEzHQcvTk_cEhTGeb-yq9fq_A@mail.gmail.com> <60b832316cfa8_187c7d20826@natae.notmuch>
In-Reply-To: <60b832316cfa8_187c7d20826@natae.notmuch>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 2 Jun 2021 21:25:21 -0700
Message-ID: <CABPp-BEwueg9V0PHUZ=ZUrTRpqwqN2b2b3t4owkizr75a+BDUA@mail.gmail.com>
Subject: Re: The git spring cleanup challenge
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Sergey Organov <sorganov@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 2, 2021 at 6:36 PM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> Elijah Newren wrote:
> > On Tue, Jun 1, 2021 at 3:39 PM Sergey Organov <sorganov@gmail.com> wrote:
>
> > > [diff]
> > >         algorithm = patience
> >
> > Any reason for patience vs. histogram?
>
> Is histogram better than default?

Yes, definitely.  I think diff.algorithm should default to histogram,
personally.

See also commits 85551232b56e (perf: compare diff algorithms,
2012-03-06) and c8017176ac8f (merge-ort: use histogram diff,
2020-12-13).

> > > [merge]
> > >         conflictStyle = diff3
> > >
> >
> > Anyway, here's my list to join in on the fun...
> >
> > [branch]
> >         sort = authordate
>
> Nice. I didn't know that existed.
>
> I have `tag.sort = -version:refname`, and after a few days without I'm
> wondering why it isn't the default.
>
> > [alias]
> >         brief = !git log --no-walk --abbrev=12 --pretty=reference
>
> I find it odd that you prefer `git log --no-walk` over
> `git show --quiet`.

Why?  Both log and show require an extra flag, so why should the
choice matter or be surprising?

I happen to use log a lot more than show, so I think in terms of
adding flags to git log rather than the ones I need to add to git
show.  Not a big deal either way, though.

> > [log]
> >         mailmap = true
>
> Another one that I don't see why it isn't the default.

It is the default and has been for a couple years; see f3eda90ffc10
(log: really flip the --mailmap default, 2019-08-01).  I just never
cleaned up my config.
