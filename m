Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD801C4361B
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 22:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5A4B22CA0
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 22:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbgLGWl3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 17:41:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbgLGWl3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 17:41:29 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1F3C061749
        for <git@vger.kernel.org>; Mon,  7 Dec 2020 14:40:48 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id k2so17297925oic.13
        for <git@vger.kernel.org>; Mon, 07 Dec 2020 14:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ji0ok82AEiGIbJkz3hiEIXrxh6GP2rrkj16Nbb7NHp8=;
        b=fNTeVjUmrP57yoEMjdfh/xqvP1zpaFuFTHBrRi0WtUc+eXOi8Lbl/LiCRRS+OeLvJc
         ehCJAVGKZZGcsoNL1U9D0h9NtsSGumzBo5pobZICSoV6xuEKe9qfTP6c02iWb7xUKQkk
         hbDev3g7m027uQTnQgeRiifeSOZgk/HHkIthCLoiwUMjXzqVV9g1xXD6pPjksbxSFQge
         6rz5PtIK2CIWy985ctWBGzP8v1SsYzt8wphjMan+KizLy32Lj6kakPvsEmwKA/lEXKB6
         sBo5wICQvyH2Jt7OM3McRS17gAWi6KQf6fVIWI6q4x/mcnSjJEimFjGKpG7LTw7Bfje7
         6wgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ji0ok82AEiGIbJkz3hiEIXrxh6GP2rrkj16Nbb7NHp8=;
        b=iZ8HyvbAc96eDSGTgW+RTW6dno5lS5j8Qp9Wu6oDZWdyMLj+0Jb+0A6IRUo/aqAu6b
         NSHJksE03T/PEaSt6pe3GorTtTz3PZ++ji8JObnono9Iyi9zoN8Vx2jLntSZ4EJE/vf4
         Zgm1sV+o3yWzBYyhbwWzhMvfE/Q8vLoUT0o654GbprSXHFbFTG5eW3dfJMrJJjMdF8XB
         P1Xig11lPcqTQ92svq42rLZg9untmr3Y97QpoDSwJIFh9Qdvj7Teuiq5bJU9btHh4bIJ
         PLJ2tCSoN5RReD6UbcbQ7R1ZFtGLH9SPMBF6qvEtKeYFbif2KWQEPYAoED6E2z3AQ9PQ
         ZNJQ==
X-Gm-Message-State: AOAM531/m8HRL2wh8a3cnHC1Af8W3rOL/PQYQILSlGxXawTBZD7A+Kdd
        jyxD0ilRiYJd1LQ3wUa7DWIIBBtfphD0+Iws8mE=
X-Google-Smtp-Source: ABdhPJxn7tvnrA/kODzWgyioBGePhj8oG5zgI8QeJaSeOmWry+7PLzXiZ50wEue+m6SPF2Rv3sLIvS6ExXlwwoi/A9Q=
X-Received: by 2002:a05:6808:991:: with SMTP id a17mr698239oic.167.1607380848318;
 Mon, 07 Dec 2020 14:40:48 -0800 (PST)
MIME-Version: 1.0
References: <20201205195313.1557473-1-felipe.contreras@gmail.com>
 <20201205195313.1557473-2-felipe.contreras@gmail.com> <xmqq8sa99wh3.fsf@gitster.c.googlers.com>
 <CAMP44s1ZDXzGfEqpTeiG=aGAYK40ebnBLQKAbA7KGtcePGARfw@mail.gmail.com>
In-Reply-To: <CAMP44s1ZDXzGfEqpTeiG=aGAYK40ebnBLQKAbA7KGtcePGARfw@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 7 Dec 2020 14:40:37 -0800
Message-ID: <CABPp-BEkKMuZHWJ8mrFUFm3okDDsMHeZZNxtGzgq-RLLddMxdw@mail.gmail.com>
Subject: Re: [PATCH v3 01/16] doc: pull: explain what is a fast-forward
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, Dec 7, 2020 at 2:22 PM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> On Mon, Dec 7, 2020 at 2:45 PM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Felipe Contreras <felipe.contreras@gmail.com> writes:
> >
> > > We want users to know what is a fast-forward in order to understand the
> > > default warning.
> >
> > The intention is very good, but ...
> >
> > > +------------
> > > +       A---B---C master on origin
> > > +      /
> > > +    D---E master
> > > +------------
> > > +
> > > +Then `git pull` will merge in a fast-foward way up to the new master.
> >
> > ... I find the phrase "in a fast-forward way" a bit awkward.
> > Perhaps use the 'fast-forward' as a verb, i.e.
> >
> >         Then `git pull` notices that what is being merged is a
> >         descendant of our current branch, and fast-forwards our
> >         'master' branch to the commit.
> >
> > or something like that?  It should be in line with the spirit in
> > which glossary defines fast-forward, I would think.
>
> The glossary defines a fast-forward as:
>
>   A fast-forward is a special type of `merge`
>
> So, if you consider "merge" a noun, then a fast-forward is an
> adjective. If you consider it a verb, then it's an adverb. But it's
> not a verb.

A square is a special type of a rectangle, but that doesn't make
"square" an adjective; both square and rectangle are nouns.

> If it was a verb, then we should have `git fast-forward`, which may
> not be a terrible idea, but right now a fast-forward is a modifier.
>
> At least that's what I have in my mind, and the glossary seems to agree.

If you read the release notes and even various messages printed by
git, "fast-forwards", "fast-forwarded", "fast-forwarding", and "to
fast-forward" all appear multiple times.  And yes, "fast-forward" also
appears multiple times as a noun in addition to the various uses as a
verb.  So, I'd say the glossary just isn't comprehensive because in
this case we have a word that serves as both a noun and a verb.


Going back to the text Junio highlighted, I agree with him that the
phrase looks really awkward, and much prefer his suggestion
(regardless of whether it aligns with the current glossary).

> > > +
> > > +------------
> > > +    D---E---A---B---C master, origin/master
> > > +------------
> > > +
> > > +However, a non-fast-foward case looks very different.
> >
> > s/foward/forward/ (the same typo exists above);
>
> All right.
>
> --
> Felipe Contreras
