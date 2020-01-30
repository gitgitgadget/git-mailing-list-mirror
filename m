Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF976C2D0DB
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 14:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96C4620707
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 14:40:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6boq+yA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbgA3Okk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 09:40:40 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:43994 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbgA3Okk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 09:40:40 -0500
Received: by mail-io1-f66.google.com with SMTP id n21so4214025ioo.10
        for <git@vger.kernel.org>; Thu, 30 Jan 2020 06:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=eVZYlwD74mN/iYN50X7odgEms9D9xZ+fgYqHavFBxAI=;
        b=P6boq+yAUVr41jB/2WNGG/32xtDiH1PxRGmswBw7dKYy0sBrRNBIuVB03xCxAYD4Mj
         dTWejylH3RWXoBM5OUX6Gc1jEp9KHo0uTOMqBwhMRIMZcorR/ZHl5njASNiaAp7kFcte
         tKoASMaM3Gjd65l1DW9cOikKDMZqy7KB7JN2qJ66Tu7PxLXiIgvnWSQenmG13QJqY+ED
         k45C/Y9S2ISFMS2QoZenyoS+RYk7QPC74wY/YfCPMWOZR64lvp21U4dIF5kw4pcznYNE
         ZnneuoK/i711Ax60T8NsgyNJ+sLLrXThOMYVAKXGAK7t6V3ZF4ciXHK4v198yWkXpO+d
         0ixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=eVZYlwD74mN/iYN50X7odgEms9D9xZ+fgYqHavFBxAI=;
        b=JZWR9P8NOLlBEV47YFg/Tuhyvjnd/kwW6nUOIIST2YsPd0EU9WF1EbT4VU+Pha6gLx
         BIXCp8XrYxFxmkdTKlh5Ea0CEJ65BNLtZwgUTlL5X7bmoKDWlycSKvabU5GnvImYcT9n
         KivPQhK+3j0jdV1QfzG6/eGckTUjR5/Xvke5ZLVHNbLqDJuVeDGTUV0OYZoYH2xD2QkI
         VgLWZuJTieiuI+afWTsCP6cKt9bi+nq2o9kbZzOwLQHbZ1EMQT/hnegU5tm4ZPD0quRE
         zYXqcs5yQ7MHQAxdzEJI6Rem5BpTzGwJA3HTpJs0bL09jOASfmzagF6dFde920RvDIJS
         iUZg==
X-Gm-Message-State: APjAAAWOSobiRDIHrxlREmaiCGGccTlu2hbEWIWU+o+HRmkR530R+eeW
        feIvwpLZkdU9KYLye+kn29l1pRbR+YrZCOypooiRBQwo
X-Google-Smtp-Source: APXvYqy26ZpOFxxyuxsBEvY7NLm58PcvYrUhmn7Hh380tRPIh8idtJbIPW4iZ0sWZWeExmbHFdLhK/qnoDaKpNP0MCU=
X-Received: by 2002:a5e:9417:: with SMTP id q23mr4202576ioj.188.1580395239115;
 Thu, 30 Jan 2020 06:40:39 -0800 (PST)
MIME-Version: 1.0
References: <20200128144026.53128-1-mirucam@gmail.com> <20200128144026.53128-10-mirucam@gmail.com>
 <nycvar.QRO.7.76.6.2001301341100.46@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2001301341100.46@tvgsbejvaqbjf.bet>
From:   "Miriam R." <mirucam@gmail.com>
Date:   Thu, 30 Jan 2020 15:40:27 +0100
Message-ID: <CAN7CjDCiP_KVC5Ey6cMuPN17vRNp_s4vy94qsaAKRPG=k3Rj3g@mail.gmail.com>
Subject: Re: [PATCH v2 09/11] bisect: libify `check_good_are_ancestors_of_bad`
 and its dependents
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

El jue., 30 ene. 2020 a las 14:46, Johannes Schindelin
(<Johannes.Schindelin@gmx.de>) escribi=C3=B3:
>
> Hi Miriam,
>
> On Tue, 28 Jan 2020, Miriam Rubio wrote:
>
> > @@ -893,18 +901,20 @@ static void check_good_are_ancestors_of_bad(struc=
t repository *r,
> >       if (check_ancestors(r, rev_nr, rev, prefix))
> >               res =3D check_merge_bases(rev_nr, rev, no_checkout);
> >       free(rev);
> > -     if (res)
> > -             exit(res =3D=3D -11 ? 0 : -res);
> >
> > -     /* Create file BISECT_ANCESTORS_OK. */
> > -     fd =3D open(filename, O_CREAT | O_TRUNC | O_WRONLY, 0600);
> > -     if (fd < 0)
> > -             warning_errno(_("could not create file '%s'"),
> > -                           filename);
> > -     else
> > -             close(fd);
> > +     if (!res)
> > +     {
>
> Please move the opening `{` to the same line as the `if (!res)`.
Noted.
>
> > +             /* Create file BISECT_ANCESTORS_OK. */
> > +             fd =3D open(filename, O_CREAT | O_TRUNC | O_WRONLY, 0600)=
;
> > +             if (fd < 0)
> > +                     warning_errno(_("could not create file '%s'"),
> > +                                   filename);
> > +             else
> > +                     close(fd);
> > +     }
>
> I wonder whether this would be easier to read:
>
>         if (res =3D=3D -11)
>                 res =3D 0;
>         else if (res)
>                 ; /* error out */
>         else if ((fd =3D open(filename, O_CREAT | O_TRUNC | O_WRONLY, 060=
0)) < 0)
>                 res =3D warning_errno(_("could not create file '%s'"), fi=
lename);
>         else
>                 close(fd);
>
Yes, I think it is a good improvement.

> Note: my code explicitly assigns `res =3D -1` if the file could not be
> created, which is technically a change in behavior, but I think it is
> actually a bug fix.

Aha.

If my mentor is ok with this change, I will apply the improvement you
suggested :).

>
> >   done:
> >       free(filename);
> > +     return res;
> >  }
> >
> >  /*
> > @@ -975,7 +985,9 @@ int bisect_next_all(struct repository *r, const cha=
r *prefix, int no_checkout)
> >       if (read_bisect_refs())
> >               die(_("reading bisect refs failed"));
>
> I see that there is still a `die()` here, and you left it alone in this
> patch because at this point, only the callers of
> `check_good_are_ancestors_of_bad()` need to be addressed. Good.
>
> At a later point, this will have to be dealt with, of course.
>
> Another thing will need to be handled, too: while I was looking at the
> code whether any resources need to be released (returning a negative
> integer does not release memory or close file handles, unlike `die()`), I
> stumbled across the fact that `term_bad` and `term_good` are file-local
> variables. They will need to be made attributes of a `struct` and will
> need to be released properly, i.e. the ownership will have to be clarifie=
d
> (is a failed `bisect_next_all()` responsible for releasing the memory it
> allocated via `read_bisect_terms()`, or its caller?).
>
> Just something to keep in mind. Or better: to jot down in a TODO list.

Ok. I will write this down for future improvements. Thank you!
>
> >
> > -     check_good_are_ancestors_of_bad(r, prefix, no_checkout);
> > +     res =3D check_good_are_ancestors_of_bad(r, prefix, no_checkout);
> > +     if (res)
> > +             return res;
> >
> >       bisect_rev_setup(r, &revs, prefix, "%s", "^%s", 1);
> >       revs.limited =3D 1;
> > diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> > index 826fcba2ed..3442bfe2cb 100644
> > --- a/builtin/bisect--helper.c
> > +++ b/builtin/bisect--helper.c
> > @@ -666,7 +666,8 @@ int cmd_bisect__helper(int argc, const char **argv,=
 const char *prefix)
> >
> >       switch (cmdmode) {
> >       case NEXT_ALL:
> > -             return bisect_next_all(the_repository, prefix, no_checkou=
t);
> > +             res =3D bisect_next_all(the_repository, prefix, no_checko=
ut);
> > +             break;
> >       case WRITE_TERMS:
> >               if (argc !=3D 2)
> >                       return error(_("--write-terms requires two argume=
nts"));
> > @@ -713,5 +714,12 @@ int cmd_bisect__helper(int argc, const char **argv=
, const char *prefix)
> >               return error("BUG: unknown subcommand '%d'", cmdmode);
> >       }
> >       free_terms(&terms);
> > -     return !!res;
> > +     /*
> > +      * Handle early success
> > +      * From check_merge_bases > check_good_are_ancestors_of_bad > bis=
ect_next_all
> > +      */
> > +     if (res =3D=3D -11)
> > +             res =3D 0;
>
> Hmm. Is this the correct place, though? Should `bisect_next_all()` not be
> the function that already turns `-11` into `0`? In other words, _which_
> code are we supposed to skip over when `check_good_are_ancestors_of_bad()=
`
> returns `-11`? In other words, where would the `catch` of the
> `try`/`catch` be, if we had portable exceptions in C?

I think there must be a reason to do it there (but I don't know
exactly), because there are some comments in code that say explicitly
that this -11 to 0 is done in cmd_bisect_helper(), when the bisecting
command exits.

>
> > +
> > +     return res < 0 ? -res : res;
>
> This is a change in behavior, though: previously we guaranteed that the
> exit code is either 0 on success or 1 upon failure. I am not quite sure
> that we want to change that behavior.

I think this is because different error codes might enable a bisecting
script calling the bisect command that uses this function to do
different things depending on the exit status of the bisect command.

Thank you for reviewing.
Best,
Miriam.
>
> Ciao,
> Dscho
>
> >  }
> > --
> > 2.21.1 (Apple Git-122.3)
> >
> >
