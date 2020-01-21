Return-Path: <SRS0=4+BP=3K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2467CC2D0CE
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 10:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E801220882
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 10:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/Hsmmms"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbgAUKAR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jan 2020 05:00:17 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:33615 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728682AbgAUKAQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jan 2020 05:00:16 -0500
Received: by mail-il1-f194.google.com with SMTP id v15so1935852iln.0
        for <git@vger.kernel.org>; Tue, 21 Jan 2020 02:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7FESItikDlO6GAmFxcC7XS9oJ2B160vo1+DvTGEbEmY=;
        b=l/HsmmmsDwtSecaPRaMqlAcQWYQVa9DLhNzbKOmC83XGgjPWZXQzVOOhx64KwZXt1t
         ozoMlnIdyjutzBMIcIzYqd/wkr1s/Mru8uSbnICa1p7IYhpzWm7vpq7XQBndIKLh2N1b
         pojV+uzLTF4aqiuMciWmMJ4HaZ94gekfvw3ee0AsLJv6DxJ23FeK7GqaUDkPoZKOzbQq
         VNOnQzCcP9qBy8Qx3ZkUYgImpq/SxFW8CXgBqHfx0mY2x2sYTft1oriGTfDm+s6v7xjx
         GIGu0zPjCt81WQLay7YXxRQGe1YVjJaJRFcViUt8hnYlXR9zFCMDQxL8tNEGIijuwlzj
         Vw2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7FESItikDlO6GAmFxcC7XS9oJ2B160vo1+DvTGEbEmY=;
        b=VjGNJdi6dwELr12/FX/CAtyk9TIr9gHjRkbJeLqzF1pWbDRdeO7YvNGgibyFC4FNyD
         7ej4sMjZwZ0L0LU4Uj4m5+NohWx9c2FgIVPv9UO7Wukwy5piCykVJgUzlTWgck/bfd19
         V0qPmorQ0ukUfz1TbwGzqLtbUR/3G+st3/6aOdrMIlMn7qA0av4fn3/17Q42kMlVPcak
         rPaEkoxIEmz+gvsOWMGGWPINknYK+paHNqBqs9+M/hvAGIQ9uFv7yn6TzCQeorfVL7df
         zRbg8KHxZosvLM3RjjhWoU4avO7Ex1tCIOq313qsF87pRlPPDemizbdQNq/xvY94aFnB
         rang==
X-Gm-Message-State: APjAAAWO/Jfldf7Zkp6PY7icEMtZ5s7mpKC3Cc3h49M6rBKGzna2vyDK
        6QhyYx2Pl7Z1t1BexWkE2EZpE0cySiaFaqpd/CDV5Xw9
X-Google-Smtp-Source: APXvYqy5DP6cRT4k+GHKfAdFXlqfJDVwYB6+vFuevVTw1WBostr5nPl/PYP5I/OHWB8CsAdl6z3p8/0gNtqM7MHnu5E=
X-Received: by 2002:a92:d801:: with SMTP id y1mr2836540ilm.188.1579600816260;
 Tue, 21 Jan 2020 02:00:16 -0800 (PST)
MIME-Version: 1.0
References: <20200120143800.900-1-mirucam@gmail.com> <20200120143800.900-7-mirucam@gmail.com>
 <nycvar.QRO.7.76.6.2001202253450.46@tvgsbejvaqbjf.bet> <CAP8UFD1T3_1t0Qf3jP1GttNHvaLEWoaeAVeZid6AMH_MAKPjSw@mail.gmail.com>
In-Reply-To: <CAP8UFD1T3_1t0Qf3jP1GttNHvaLEWoaeAVeZid6AMH_MAKPjSw@mail.gmail.com>
From:   "Miriam R." <mirucam@gmail.com>
Date:   Tue, 21 Jan 2020 11:00:05 +0100
Message-ID: <CAN7CjDDZw4e13bJzH3gpitb__=H5VocrEZRY6cBTrCpAJ1q13Q@mail.gmail.com>
Subject: Re: [PATCH 06/29] bisect: libify `exit_if_skipped_commits` to
 `error_if_skipped*` and its dependents
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

El mar., 21 ene. 2020 a las 7:40, Christian Couder
(<christian.couder@gmail.com>) escribi=C3=B3:
>
> Hi Dscho,
>
> On Mon, Jan 20, 2020 at 10:57 PM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Mon, 20 Jan 2020, Miriam Rubio wrote:
>
> > >       printf("There are only 'skip'ped commits left to test.\n"
> > >              "The first %s commit could be any of:\n", term_bad);
> > > @@ -676,7 +676,13 @@ static void exit_if_skipped_commits(struct commi=
t_list *tried,
> > >       if (bad)
> > >               printf("%s\n", oid_to_hex(bad));
> > >       printf(_("We cannot bisect more!\n"));
> > > -     exit(2);
> > > +
> > > +     /*
> > > +      * We don't want to clean the bisection state
> > > +      * as we need to get back to where we started
> > > +      * by using `git bisect reset`.
> > > +      */
> > > +     return -2;
> >
> > This comment is a good indicator that the constant `-2` here is a "magi=
c"
> > number and it would most likely make sense to turn the return type from=
 an
> > `int` into an `enum` instead.
>
> Many functions use `return error(...)` and error codes from these
> functions and from exit_if_skipped_commits() are going to get mixed.
> So I am not sure that using an enum for only some of the error codes
> will make things clearer.
>
> > >  static int is_expected_rev(const struct object_id *oid)
> > > @@ -949,7 +955,7 @@ int bisect_next_all(struct repository *r, const c=
har *prefix, int no_checkout)
> > >  {
> > >       struct rev_info revs;
> > >       struct commit_list *tried;
> > > -     int reaches =3D 0, all =3D 0, nr, steps;
> > > +     int reaches =3D 0, all =3D 0, nr, steps, res;
> > >       struct object_id *bisect_rev;
> > >       char *steps_msg;
> > >
> > > @@ -972,8 +978,9 @@ int bisect_next_all(struct repository *r, const c=
har *prefix, int no_checkout)
> > >                * We should exit here only if the "bad"
> > >                * commit is also a "skip" commit.
> > >                */
> > > -             exit_if_skipped_commits(tried, NULL);
> > > -
> > > +             res =3D error_if_skipped_commits(tried, NULL);
> > > +             if (res)
> > > +                     exit(-res);
> >
> > So we still `exit()` in `libgit.a`? I hoped for a more thorough
> > libification.
>
> The exit() calls are removed in later patches.
>
> > Besides, the `if (res)` probably wants to be an `if (res < 0)`, right?
>
> Yeah, I agree.
>
Noted!
Thank you Johannes and Christian.

> Thanks for your review,
> Christian.
