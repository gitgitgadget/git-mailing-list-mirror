Return-Path: <SRS0=4+BP=3K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E66EC2D0CE
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 10:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31F9320882
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 10:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dE/1sOTk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbgAUKAd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jan 2020 05:00:33 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:34193 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728682AbgAUKAc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jan 2020 05:00:32 -0500
Received: by mail-io1-f66.google.com with SMTP id z193so2247734iof.1
        for <git@vger.kernel.org>; Tue, 21 Jan 2020 02:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=ZR3C2Rl6GJoljT0/JqkmZbsGzAqxSr4Sy034hSVL+WM=;
        b=dE/1sOTkO3UOt4lOPHZovkTMVSnre2ptK1TPJbV/WeoHtW4sxb9ceBUFR01QAiFdT6
         LRzR9UgAweCRpYhvZxBaie9EBJgcWCna+b9VcF9A26WwHE3YCU+T81IP7B5eToCb6U4+
         q+U/G1+nyu8SmLIlaoqdfOcnb3a9zXawbo6Gb6uaR1qYcsCrAbhpzEgfGVfO7A/cQmqB
         qyyOv3kl+zqvV9haOS9Mx/yguq5beYL3pgT07E8YMDoY/8rJ2LRyn+99AErS/CV/4Xmx
         V9Ahlnv+FzfyARjx30RHVHTmKNl++0IhHGLp1YeUSsVKJSjBAMJhw8fyoCJVhjjlc+Bl
         ud1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=ZR3C2Rl6GJoljT0/JqkmZbsGzAqxSr4Sy034hSVL+WM=;
        b=BQQIDo5eaIuVD8ZfNO04AypKpWO4kFmOM2BKSryIm5cFiNAdi+z22CZtL4JKosJccL
         prZRBoxlz54vmcH2V+XpbMHA971D7CN6ZKaL9p2Ss0ofkSl5Gi6L4IGErBUFX8fVDoog
         mVBQ7B44QN4fftallFv4IS35H6cTPBIacbwJbNsBm/F6oN37FhvAmD3lOfxITYnG1gKY
         Df6GA1DDTpxjnGeO2Zbw8DZrt+NOQs1TWSw1i+sr1LGmPRBKYnFE4HfEBrybMUxMnMkn
         7ixNsxHgY130tlAy+uR4w7y8LghkkM5hOyQNCYTVr0LXfH6mh0dkqH7748gxONa7DqU7
         QYiA==
X-Gm-Message-State: APjAAAXx/ypUyMrWCXUh0PyEhgWKCB2JsVdS17jieFIihW7zVWeedZOI
        hB/dN7UInVqBf3UqFafkWmGIJo0mYCR0bY868P8=
X-Google-Smtp-Source: APXvYqyGjas0xyte+JnmRP973k3bG71fMXCcDTFLQBHIhNoWJ2bBbvmWxwsV2hcPrlWhbozqhb2ymuH7wrKDoo3TZGY=
X-Received: by 2002:a6b:7310:: with SMTP id e16mr2467343ioh.107.1579600832319;
 Tue, 21 Jan 2020 02:00:32 -0800 (PST)
MIME-Version: 1.0
References: <20200120143800.900-1-mirucam@gmail.com> <20200120143800.900-10-mirucam@gmail.com>
 <nycvar.QRO.7.76.6.2001202313130.46@tvgsbejvaqbjf.bet> <CAP8UFD0MO9wEc=ErEAFm4kSabLKUTp1a5VTPxgDS2yqt+rxXag@mail.gmail.com>
In-Reply-To: <CAP8UFD0MO9wEc=ErEAFm4kSabLKUTp1a5VTPxgDS2yqt+rxXag@mail.gmail.com>
From:   "Miriam R." <mirucam@gmail.com>
Date:   Tue, 21 Jan 2020 11:00:21 +0100
Message-ID: <CAN7CjDAb4AxZQ-dU0GBibXhWCwxRDqbbkVaKuNfVJ+8LASr8fQ@mail.gmail.com>
Subject: Re: [PATCH 09/29] bisect: libify `check_good_are_ancestors_of_bad`
 and its dependents
To:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

El mar., 21 ene. 2020 a las 7:59, Christian Couder
(<christian.couder@gmail.com>) escribi=C3=B3:
>
> On Mon, Jan 20, 2020 at 11:20 PM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Mon, 20 Jan 2020, Miriam Rubio wrote:
>
> > > @@ -876,8 +877,15 @@ static void check_good_are_ancestors_of_bad(stru=
ct repository *r,
> > >       int fd, rev_nr, res =3D 0;
> > >       struct commit **rev;
> > >
> > > -     if (!current_bad_oid)
> > > -             die(_("a %s revision is needed"), term_bad);
> > > +     /*
> > > +      * We don't want to clean the bisection state
> > > +      * as we need to get back to where we started
> > > +      * by using `git bisect reset`.
> > > +      */
> > > +     if (!current_bad_oid) {
> > > +             res =3D error(_("a %s revision is needed"), term_bad);
> > > +             goto done;
> > > +     }
> >
> > Why not just return here? Ah, there is a `filename` that was allocated.=
..
> > it is too bad that we have a mailing-list based review, as the hunk
> > context simply cannot be extended in a mail.
> >
> > Personally, I think it would be nicer to split the definition of
> > `filename` from its declaration and move it _after_ this conditional co=
de,
> > so that we can `return` right away.
>
> Yeah, I agree.
Ok. Noted.
>
> > However, there is a more pressing issue than that: `die()` exits with e=
xit
> > code 128, so in keeping with the idea to hand down negative exit codes =
as
> > return values, should we not assign `res =3D -128` here?
>
> I think it has been ok when converting git-bisect.sh to C to just
> convert `die(...)` into `return error(...)`.
>
> > >       /* Check if file BISECT_ANCESTORS_OK exists. */
> > >       if (!stat(filename, &st) && S_ISREG(st.st_mode))
> > > @@ -893,18 +901,20 @@ static void check_good_are_ancestors_of_bad(str=
uct repository *r,
> > >       if (check_ancestors(r, rev_nr, rev, prefix))
> > >               res =3D check_merge_bases(rev_nr, rev, no_checkout);
> > >       free(rev);
> > > -     if(res)
> > > -             exit(res =3D=3D -11 ? 0 : -res);
> > > -
> > > -     /* Create file BISECT_ANCESTORS_OK. */
> > > -     fd =3D open(filename, O_CREAT | O_TRUNC | O_WRONLY, 0600);
> > > -     if (fd < 0)
> > > -             warning_errno(_("could not create file '%s'"),
> > > -                           filename);
> > > -     else
> > > -             close(fd);
> > > +
> > > +     if (!res)
> > > +     {
> >
> > We usually put the `{` on the same line as the `if` condition (like you
> > did in the `if (!current_bad_oid)` line above.
Ok. I will change that.
> >
> > The rest looks reasonable. Thank you,
Great! Thank you for your review!

>
> Thank you for your review,
> Christian.
