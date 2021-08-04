Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE4DBC4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 00:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B8B060187
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 00:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbhHDAhg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 20:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbhHDAhf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 20:37:35 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5614C06175F
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 17:37:22 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id v9-20020a9d60490000b02904f06fc590dbso183137otj.4
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 17:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LR8yz3WX+qKEQrym/XtxsYB6m74YDPfhoHaHXDI4eyM=;
        b=e7tDXUQIBpS5eBa7dOCSyNQA0aDiKoYkgpa5gwWRRb1OpTodk4XNfv1XH/VUy4dYpm
         vEFf+neYxW4BLv1aiz6jgVrZVGCcFlmaUjvO/10CRxs+4hP3P/uVduXU1pdUXMyOpVD2
         LWTBCpfVAqs8n3YFUZcLZI5XoEwQCANckqX7bF67tAeEdRwXVrFBxYdzD+WRdwKLeu82
         1dz2N+9CWo0s8lBWey5tylMZQ92uhLm3jQDqkgfAvrhSwSZapR9K7rrI+EVZt5f/lyBC
         e/zduszQfC63yMxKbALXHe4lL4wbUWV/cLnrSYRAXAO1BeSh8eY/inwoJw1eVNX98rSo
         xm3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LR8yz3WX+qKEQrym/XtxsYB6m74YDPfhoHaHXDI4eyM=;
        b=BOF8X/CF7hVtrMI/N3FHch/7HJXANsFeA8np6lBmAVtU/c4e02fHE8qDxXwsIBSYaX
         AfqU7rr1wGEKUWnIQgEc9pFVnopKj+lHEB4N92kMz5e42WR5KPDV91i+TL6kA+jXoemV
         MV4F3As2szY1vuHtxzls0vYxK/fLeKCeeEmrt8OLq3+t4eDynhCv99sGI3KWs7dI9LaQ
         t3jYHIV0rN0/6CA9Emar04lR1s6epkO0cZswBIT1QmpN0fp+trJEIhHQvQJBp3dNZqER
         0DEO1lilzD13Yw5o/hOeOSw5FFu+5QhEcLDyq7+hjLuUnsqso9IyGPSl9heJhVoGUV3S
         dDiA==
X-Gm-Message-State: AOAM532w0rtS2lmmCj8rWqNMPSKSVkbMQj3hTP/wt87QvfGulfjBbfmH
        okZxc/pJQVTPcrmow8zuWswckrth8iz5c8fpdXcNx9fSl4c=
X-Google-Smtp-Source: ABdhPJxh12osenKDlQ40O2JbM+fh09qdN3L3fy8IVPSyAr8mhRMas2/ntLEJMTgO3+UHtmL/mmi/MiPt1F7LYLqgV+E=
X-Received: by 2002:a05:6830:1d73:: with SMTP id l19mr16813224oti.316.1628037442123;
 Tue, 03 Aug 2021 17:37:22 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1059.git.git.1628004920.gitgitgadget@gmail.com>
 <3989f194ba91e64852285064b652979861445c03.1628004920.git.gitgitgadget@gmail.com>
 <xmqqmtpyrrhe.fsf@gitster.g>
In-Reply-To: <xmqqmtpyrrhe.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 3 Aug 2021 18:37:11 -0600
Message-ID: <CABPp-BErWux0inUR_FonzVwX0eKxGrjAofo+GYjMNE4FV0qwsQ@mail.gmail.com>
Subject: Re: [PATCH 04/10] merge-strategies.txt: update wording for the
 resolve strategy
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 3, 2021 at 6:19 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > The resolve merge strategy was given prominent positioning in this
> > document, being listed first since it was the default at the time the
> > document was written.  It hasn't been the default since before Git v1.0
> > was released, though.  Move it later in the document, near `octopus` and
> > `ours`.
>
> I think it was listed first because it was written first.

Do you want it to be kept first for that reason as well?  I thought it
made more sense to cover the default strategy first, but I can move it
back if you prefer historical implementation order.

> > Further, the wording for "resolve" claimed that it was "considered
> > generally safe and fast", which implies that the other strategies are
> > not.
>
> I do not think it never implied any such thing; it is good to remove
> it, or add the same to all strategies, though.

I am unsure if your double negatives are intentional
(not..never)...but I think you're saying it's okay to remove this
text.

> > diff --git a/Documentation/merge-strategies.txt b/Documentation/merge-strategies.txt
> > index 5d707e952aa..6b6017e1cc8 100644
> > --- a/Documentation/merge-strategies.txt
> > +++ b/Documentation/merge-strategies.txt
> > @@ -6,13 +6,6 @@ backend 'merge strategies' to be chosen with `-s` option.  Some strategies
> >  can also take their own options, which can be passed by giving `-X<option>`
> >  arguments to `git merge` and/or `git pull`.
> >
> > -resolve::
> > -     This can only resolve two heads (i.e. the current branch
> > -     and another branch you pulled from) using a 3-way merge
> > -     algorithm.  It tries to carefully detect criss-cross
> > -     merge ambiguities and is considered generally safe and
> > -     fast.
> > -
> >  recursive::
> >       This can only resolve two heads using a 3-way merge
> >       algorithm.  When there is more than one common
> > @@ -106,6 +99,13 @@ subtree[=<path>];;
> >       is prefixed (or stripped from the beginning) to make the shape of
> >       two trees to match.
> >
> > +resolve::
> > +     This can only resolve two heads (i.e. the current branch
> > +     and another branch you pulled from) using a 3-way merge
> > +     algorithm.  It tries to carefully detect criss-cross
> > +     merge ambiguities.  It cannot handle renames.  This was
> > +     the default merge algorithm prior to November 2005.
>
> "It does not handle renames"; it wasn't like we wanted to do so and
> cannot---we didn't want to, didn't think it was worth doing, it was
> not part of the design objective to do renames, period.

Right, sorry for the poor wording.  I'll fix it to use your phrase.

> I do not think it is even worth mentioning that it was the default
> in the past.  And I do not think it is worth saying what timeframe
> the recursive was the default, either.

I don't feel strongly about it and I can strike it.  My reasoning was
that providing historical timeframes might help them repeat or
recreate old merges in their own repositories.

However, I agree that the more likely bits of information that will
help users select the strategy they want are the capabilities (e.g.
renames, criss-cross merges, number of heads, etc.).
