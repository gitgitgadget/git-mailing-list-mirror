Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E8101F453
	for <e@80x24.org>; Mon, 21 Jan 2019 17:59:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbfAUR7v (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Jan 2019 12:59:51 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:44438 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727422AbfAUR7u (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jan 2019 12:59:50 -0500
Received: by mail-vs1-f65.google.com with SMTP id u11so13092639vsp.11
        for <git@vger.kernel.org>; Mon, 21 Jan 2019 09:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bFTr5y90IZDBLtTsNgdQCQ9jGjfMuhzrgOe+SgueSew=;
        b=vVQ7KzP1KlZql1sqXzYTWpb0+wYx1rWg+d3a9SNS7Am8Mg16ceTyWRvStFwP5jzmiS
         kYCpdbXJcI8AcwzTzfqwn0uQ7F4v1dIZopg0yDIQx5inrAKNOzO0cfv+p7p7lrs1o+cq
         PwNt+RaG+sHFm9ISmGOyEO8g7ZYi2oGcoFPQY3Y7e/1NYrQ55Ada16UnRw8GSLKfxL2L
         4xmfIdcrE4JdTEk6lSc8ptwW18+hMeOEddqygbpKCS1c5eh8D1pZlC+8mrYw1fokneUP
         Q8AC1fx8/di3PTyRgfIBssDXpHrdfcwTw+jbaxBNdQFc/zNXJMU4mow4DIDS0sUt4qy1
         i3vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bFTr5y90IZDBLtTsNgdQCQ9jGjfMuhzrgOe+SgueSew=;
        b=UFI/RMkpvilpRvsEiLKf/9U1nHxJB0BDP5Yo4Ped1vfVAPWA7Mf5pOQikYV5oBVAck
         w8IrdlVRBEgpTszGpYdSUJXTbIQPsBkKwOte3uFMOowkfBxmZFGII0Iw03lJlhlrN9WZ
         ZvuCbPI3YwFjLW1i1XT6eZxQh0fQmHRGLOn0DYaIucA8QATQBLP+pxN+fYrArNJllyfI
         Wmphl1vJonvk6/RnfaNOHDgZ1I0GOOCqS5funh8Bv80LWL/3XludlgFpoD1TV9pexelF
         KQ18rnATtESmjpgzBoxJOFVx7iXEPpdkaS0z79HMu1UNLvj7QuHoknx44DqPhMndPBAV
         /Cbg==
X-Gm-Message-State: AJcUukdOGInUFEjUcwN4EEgB7ZrkLoFpLhqLJYg0hOLXAf3Zz/HIuRur
        COpVt0N1fuqneAJ3qbzOVXi0gfSDBWd4oWD3+gI=
X-Google-Smtp-Source: ALg8bN7D3s6LQMI5pxFVjgSXhXWniBvxbqZaznsza0U6fjNRf3kOVfozuqtdUTltpYg85lFCzWQD1/X1Hl5WLtqYiug=
X-Received: by 2002:a67:7657:: with SMTP id r84mr5377136vsc.117.1548093589343;
 Mon, 21 Jan 2019 09:59:49 -0800 (PST)
MIME-Version: 1.0
References: <20181122044841.20993-1-newren@gmail.com> <20181211161139.31686-1-newren@gmail.com>
 <20181211161139.31686-5-newren@gmail.com> <nycvar.QRO.7.76.6.1901211706250.41@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1901211706250.41@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 21 Jan 2019 09:59:37 -0800
Message-ID: <CABPp-BGOPQms5CRvQ_+iMs=8-tgvw=cyJaT1OCKNFHEG+GyAvA@mail.gmail.com>
Subject: Re: [PATCH v4 4/8] am, rebase--merge: do not overlook --skip'ed
 commits with post-rewrite
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Phillip Wood <phillip.wood@talktalk.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On Mon, Jan 21, 2019 at 8:07 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi,
>
> On Tue, 11 Dec 2018, Elijah Newren wrote:
>
> > The post-rewrite hook is supposed to be invoked for each rewritten
> > commit.  The fact that a commit was selected and processed by the rebase
> > operation (even though when we hit an error a user said it had no more
> > useful changes), suggests we should write an entry for it.  In
> > particular, let's treat it as an empty commit trivially squashed into
> > its parent.
> >
> > This brings the rebase--am and rebase--merge backends in sync with the
> > behavior of the interactive rebase backend.
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
>
> This makes sense. I think, though, that we need to be more careful...
>
> > ---
> >  builtin/am.c                 | 9 +++++++++
> >  git-rebase--merge.sh         | 2 ++
> >  t/t5407-post-rewrite-hook.sh | 3 +++
> >  3 files changed, 14 insertions(+)
> >
> > diff --git a/builtin/am.c b/builtin/am.c
> > index 8f27f3375b..af9d034838 100644
> > --- a/builtin/am.c
> > +++ b/builtin/am.c
> > @@ -2000,6 +2000,15 @@ static void am_skip(struct am_state *state)
> >       if (clean_index(&head, &head))
> >               die(_("failed to clean index"));
> >
> > +     if (state->rebasing) {
> > +             FILE *fp = xfopen(am_path(state, "rewritten"), "a");
> > +
> > +             assert(!is_null_oid(&state->orig_commit));
> > +             fprintf(fp, "%s ", oid_to_hex(&state->orig_commit));
>
> ... here. What if `fp == NULL`? (Users do all kinds of interesting
> things...)

This if-block is actually copy-pasted from the end of the do_commit()
function, since the same logic was needed in both places.  The fact
that a `fp == NULL` case never triggered for do_commit() suggests that
the check has never been needed in the wild (or perhaps it just
indicates a latent bug that no one has triggered yet).  However, it
does suggest a code cleanup regardless.  I thought of it as such a
small block that I didn't think to put it in a separate function, but
perhaps I should so that someone spotting the possibility of a NULL fp
could fix it for both callers in a single place.

Should I insert a preliminary change pulling this block out of
do_commit into a separate function, and then modify this patch to just
call this function?  Or perhaps given the length of time it has
already been cooking (and Junio's rerere resolution of our two series
that I don't want to mess up), just do it as a simple post-series
fixup?


Elijah
