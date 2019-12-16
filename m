Return-Path: <SRS0=PvcO=2G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DF1C43603
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 21:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A74221D7D
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 21:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/mU0oJn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfLPVI4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Dec 2019 16:08:56 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36565 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfLPVI4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Dec 2019 16:08:56 -0500
Received: by mail-ot1-f65.google.com with SMTP id i4so10807663otr.3
        for <git@vger.kernel.org>; Mon, 16 Dec 2019 13:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AZ3Sp2haa1cXTXvYlDfU6HR4BLFmMRzDE2tDKg/G9X4=;
        b=j/mU0oJngUZWiKxeby0bTIC8atN9ijMSERgL9A6VHR+aUkBTAol32PX7ayA91ryHyz
         y9KmelbMsNEdM2i5i0Oq47T2TxgTEeeOIiSIeVEEW3hR0A6ymLYYOZOdh7V6ShPT2ihK
         K3p+l98ZC97H283xU7QrA4+/49U5B1fUlM5UCQSXi8+wV9ZDNiLeDArxHlHGSCxKE3hs
         MUSjXllReLRD/SlPyzZuG58ftcQd/KCrwmwegB6pFyqQOnU5LIwas9Fm4Ri1302jA+PG
         HoJETFMN8aaJxgArLIAanSCyEjzs7NHTdHHFxAFDg2LjqdT+RFugwHkMmihelst7vE/V
         6NTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AZ3Sp2haa1cXTXvYlDfU6HR4BLFmMRzDE2tDKg/G9X4=;
        b=EishOvYuzJa7EJ8YbngThO5tcWOJdz+ETlRrWetAo4BYz0Pvxx3lNXY6RBZj6OMVw2
         qcXbQ2/UY8/VTPwx6QksA+ZsXP3VVlnUc25BisH3pV6ASDYf6wY6SIfF0y7ju/d16vqb
         07T+lykYkm09pyof8U3hS8NLjXCxbKos4CWYKpRMkuURJRi8kx4vZ21v+rK+pBxdFwkp
         DFlGzvu2Ew/1uxoJTjFS9Wlek/MXvdhSJ3j9kdkon+HeND0xyLHjlxCYwBAOGklF9wfn
         QkJGrZf62Dq6zlv43RET5BW1iPbTixc5UXWpPU36DzoI5W0Ca7Yia8qWK0tPL5IJ/Ozh
         Pb6A==
X-Gm-Message-State: APjAAAURan4WIPhOXFFiQ2FnhwhupdkMu4g3d1/3zHHDUjrEphUXiw3x
        LdAKNgssGZK1PRqjVss40P0Ya72t8XhB/jursFA=
X-Google-Smtp-Source: APXvYqzyZELxTEUKpF6JM4I7g7o71A4EwMSRtnySo/2+pAXo/hqViwooAicHxy4Je2F7Oi0nVqgXS5lX4nmdgXQMQDI=
X-Received: by 2002:a9d:1b4e:: with SMTP id l72mr34721509otl.345.1576530535059;
 Mon, 16 Dec 2019 13:08:55 -0800 (PST)
MIME-Version: 1.0
References: <pull.676.git.git.1575924465.gitgitgadget@gmail.com>
 <pull.676.v2.git.git.1576008027.gitgitgadget@gmail.com> <9839aca00a10b16d96c47db631ac025281ffc864.1576008027.git.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.1912151126030.46@tvgsbejvaqbjf.bet> <CABPp-BE04=A9wx1VfWsghn6scy8aaVFoENxV6YiW2AxgM2jhjQ@mail.gmail.com>
 <CABPp-BGoC_D6LzzMNyf30wFssTU2WA1kTLmFvJ2Do+Tfg4+YQA@mail.gmail.com> <xmqqwoawjg09.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqwoawjg09.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 16 Dec 2019 13:08:44 -0800
Message-ID: <CABPp-BF2UL5m4_f2tETfZvq=011KsKheGA=axFwYhC+kJXi0JQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] dir: fix checks on common prefix directory
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>, blees@dcon.de,
        Kyle Meyer <kyle@kyleam.com>, Samuel Lijin <sxlijin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 16, 2019 at 10:13 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> >> > > +     memset(&cdir, 0, sizeof(cdir));
> >> > > +     memset(&de, 0, sizeof(de));
> >> > > +     cdir.de = &de;
> >> > > +     de.d_type = DT_DIR;
> >> >
> >> > So here, `de` is zeroed out, and therefore `de.d_name` is `NULL`.
> >>
> >> Um, yeah...didn't I have an allocation of de.d_name here?  It will
> >> always have a subset of path copied into it, so an allocation of len+1
> >> is plenty long enough.
> >
> > Actually, it looks like I looked up the definition of dirent
> > previously and forgot by the time you emailed.  On linux, from
> > /usr/include/bits/dirent.h:
> >
> > struct dirent
> >   {
> >     ....
> >     unsigned char d_type;
> >     char d_name[256];           /* We must not include limits.h! */
> >   };
> >
> > ...
>
> Uh, oh.  The size of "struct dirent" is unspecified and it is asking
> for trouble to allocate one yourself (iow, treat it pretty much as
> something you can only get a pointer to an instance from readdir()).
> For example, a dirent that comes back readdir() may have a lot
> longer name than the sizeof(.d_name[]) above may imply.
>
> Do you really need to manufacture a dirent yourself, or can you use
> a more concrete type you invent yourself?

I need to manufacture a dirent myself; short of that, the most likely
alternative is to drop patches 2 & 5-8 of this series and throw my
hands in the air and give up.  That probably deserves an
explanation...

Years ago someone noticed that if a user ran "git ls-files -o
foo/bar/one foo/bar/two", that we could try to optimize by noticing
that we won't be interested in anything until we get to foo/bar/.  So,
they tried to short-circuit the read_directory_recursive() and
readdir() calls, but couldn't reuse the same treat_path() logic to
check that we should even go into foo/bar/ at all.  So there was some
copy & paste from treat_path() into a new treat_leading_path()...and
that both missed some important parts and the logic further diverged
over time.

This patch was about categorizing the suite of bugs that arose from
not using treat_path() for checks from both codepaths, and tried to
correct those problems.  treat_path() takes a dirent, and several of
the functions it calls all take a dirent.  It'd be an awful lot of
work to rip it out.  So I manufactured a dirent myself so that we
could use the same codepaths and not only fix all these bugs but
prevent future ones as well.  If we can't manufacture a dirent, then
unless someone else has some bright ideas about something clever we
can do, then I think this problem blows up in complexity to a level
where I don't think it's worth addressing.

I almost ripped the optimization out altogether (just how much do we
really save by not looking into the leading two directories?), except
that unpack_trees() calls into the same code with a leading path and I
didn't want to mess with that.

Any bright ideas about what to do here?
