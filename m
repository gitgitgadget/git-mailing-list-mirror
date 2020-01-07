Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35B8C33C99
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 04:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70E722073D
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 04:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmpM7Gl+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbgAGEUB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jan 2020 23:20:01 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37450 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727464AbgAGEUB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jan 2020 23:20:01 -0500
Received: by mail-ed1-f65.google.com with SMTP id cy15so49278295edb.4
        for <git@vger.kernel.org>; Mon, 06 Jan 2020 20:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bICEjigafhvil6TPMaprkzy/UchxcNz2mq9adbRkl9U=;
        b=nmpM7Gl+y5b8jR9/UpNz5aazf2V0MWnGeitGX9psAgSx+ln5Px3VMXnsTj954TCwbF
         36TzGiLw/EM3KVFhDfGDhv+TJg0AkFVY6j+IqVgOhIPgHKAVouSA2ouVUY2Zv4yciwk+
         3QW83bdVuipVUc+dY3IlZKbicdMFLasC1BZkm2I0kWe/wOaSRQIpPGnvQ4ZoybYKLDUs
         byTQUo7hoK5AJMGT0My0AuUH8WyNTQcp03WiyAfy63Utn8/FtDG8xYwGtEWGRWOWpg9P
         0y+DFxhT3Cl3SrP6FEER/cRavRlBv1b00pCJ3L3AhJZhmo+NghsNkKg8OB/zFYO2BVK/
         Ao4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bICEjigafhvil6TPMaprkzy/UchxcNz2mq9adbRkl9U=;
        b=CYIYronEgdHsmJVAF1f5Nvmk5ZW0xXIgvHo9yB4YcBaVBnqJR8Abvsn5V+gFVpQjn0
         SNxooEg7tB/hP/0jp7iA/JnKR7x2ExZ+WbUoEqBtKoJSvDglaIS8n79g4eoBYKCIIniK
         W3hA9L/BD6pe55Nh9d0LZPjY+LLromLRpR8pNhuQ/S3k55vzdUE+XvH7ejsFbuW2sWnq
         w3GoMd7R56hOxqtB34hFLHO2jebzz6qTVtKdPdSvDzcFBfjb1gx1dPIOl09reuiCLh7P
         yKhD0QZewq5yhtCB67lEhlgESKFMYuEouQeR/PBPTBxSLIbswrQTUIXJAXaaUPmcaLbi
         Ne+g==
X-Gm-Message-State: APjAAAVEx6aLaH6FvOMJvwYPZKQiXhyvm5RczvMndFygeGThXrwNVSpk
        xqELnKPqBroqj2PQrtOpedWT1rT0ep7tpLjXzxs=
X-Google-Smtp-Source: APXvYqzp5jt19c7LXBfwIbzunXcVc+0l6xvfEMcIg1N6ge75KBDhDVc0rNvDLA4aM0RG8/v/0nkHzryw1qOC5KWtPz0=
X-Received: by 2002:a17:906:6bd5:: with SMTP id t21mr112053043ejs.110.1578370799288;
 Mon, 06 Jan 2020 20:19:59 -0800 (PST)
MIME-Version: 1.0
References: <pull.508.git.1577934241.gitgitgadget@gmail.com>
 <90608636bf184de76f91e4e04d9e796a021775a0.1577934241.git.gitgitgadget@gmail.com>
 <xmqqpng1eisc.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqpng1eisc.fsf@gitster-ct.c.googlers.com>
From:   Heba Waly <heba.waly@gmail.com>
Date:   Tue, 7 Jan 2020 17:19:47 +1300
Message-ID: <CACg5j24jA1G3b2Efths-dOxPjOPJAM3O5yQfm=K5zFZexbk1eQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] add: use advise function to display hints
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 3, 2020 at 8:54 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Heba Waly <heba.waly@gmail.com>
> >
> > Use the advise function in advice.c to display hints to the users, as
> > it provides a neat and a standard format for hint messages, i.e: the
> > text is colored in yellow and the line starts by the word "hint:".
>
> Use of advise() function is good for giving hints not just due to
> its yellow coloring (which by the way I find not very readable,
> perhaps because I use black ink on white paper).  One good thing in
> using the advise() API is that the messages can also be squelched
> with advice.* configuration variables.
>

Got it, thanks.

> And these two hints in "git add" are good chandidates to make
> customizable (perhaps with "advice.addNothing"), so I tend to agree
> with you that it makes sense to move these two messages to advise().
> Unfortunately this patch goes only halfway and stops (see below).
>
> If there are many other places that calls to advise() are made
> without getting guarded by the toggles defined in advice.c, we
> should fix them, I think.
>

Ok, we can address that in a separate patch.

> >
> > Signed-off-by: Heba Waly <heba.waly@gmail.com>
> > ---
> >  builtin/add.c  | 4 ++--
> >  t/t3700-add.sh | 2 +-
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/builtin/add.c b/builtin/add.c
> > index 4c38aff419..eebf8d772b 100644
> > --- a/builtin/add.c
> > +++ b/builtin/add.c
> > @@ -390,7 +390,7 @@ static int add_files(struct dir_struct *dir, int flags)
> >               fprintf(stderr, _(ignore_error));
> >               for (i = 0; i < dir->ignored_nr; i++)
> >                       fprintf(stderr, "%s\n", dir->ignored[i]->name);
> > -             fprintf(stderr, _("Use -f if you really want to add them.\n"));
> > +             advise(_("Use -f if you really want to add them.\n"));
> >               exit_status = 1;
> >       }
> >
> > @@ -480,7 +480,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
> >
> >       if (require_pathspec && pathspec.nr == 0) {
> >               fprintf(stderr, _("Nothing specified, nothing added.\n"));
> > -             fprintf(stderr, _("Maybe you wanted to say 'git add .'?\n"));
> > +             advise( _("Maybe you wanted to say 'git add .'?\n"));
> >               return 0;
> >       }
>
> The final code for the above part would look like:
>
>                 if (advice_add_nothing)
>                         advise(_("Use -f if you really want to add them."));
>                 ...
>                 if (advice_add_nothing)
>                         advise( _("Maybe you wanted to say 'git add .'?"));
>
> and then you would
>
>  * add defn of advice_add_nothing to advice.h
>  * add decl of the same, initialized to 1(true), to advice.c
>  * map "addNothing" to &advice_add_nothing in advice.c::advice_config[]
>
> to complete the other half of this patch, if the config we choose to
> use is named "advice.addNothing".
>

Understood.


> By the way, notice that the single-liner advise() messages do not
> end with LF?  This is another difference between printf() family and
> advise().  advise() cuts its message at LF and prefixes each piece
> with "hint:" but after the final LF there is nothing but NUL, which
> means the final LF is optional.
>
> The warning()/error()/die() family is different from advise() in
> that they do not chop the incoming message at LF.  This behaviour is
> less i18n friendly, and it would be nice to eventually change them
> to behave similarly to advise().
>

Thank you for the extra tip.

> Thanks.
>
>

Heba
