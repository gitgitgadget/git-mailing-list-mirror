Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ACE7C2D0DB
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 14:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A2022083E
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 14:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTUgKnoE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgA3OFS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 09:05:18 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:37941 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727161AbgA3OFS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 09:05:18 -0500
Received: by mail-il1-f196.google.com with SMTP id f5so3141579ilq.5
        for <git@vger.kernel.org>; Thu, 30 Jan 2020 06:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=jDM03jUlEBV+GCbMzoez3X2+mT0j9S52GWc5yjOkikE=;
        b=mTUgKnoEjjhsh98o05nlvv5NR3vnOf9RukbxPUXph3m2l5Iwbm97sO0skkNJKUFsp/
         pd8wyfShC88BJ4AD+3/WJ4zMKcv7lU/HwqHnsdN7icdN/MIQEC1PJDbKG7aLQmeqhJLC
         4Orh6GXht4SivA7I8n2B8ZAtWicHWSrxyQeuIjUHUwoffsWNJhK6IjmlWKzbttz+Z9JG
         blKXeZ5rf0Iz9fo6f2z3M/PBvVeWhqTHWZkFK9MfMi8PtjCaNIp7ifJ9v+GOhPg5TNV2
         gd2Y5TomR0YNHSywuul0yZ3FDbxodPlPd7ZM+83dO85rJfbiVlT/mwLqxG1e8yt2bhCN
         MYrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=jDM03jUlEBV+GCbMzoez3X2+mT0j9S52GWc5yjOkikE=;
        b=S9/rPcpjISBKPOnB4P/n1X5tN4ULKaWAyktH7YSvZwytWeh61f18V6cUoDuvB2NJEm
         aHANPbwfJXs/oqzFaWmQfq3YFgEWFZEll4+rYAkbnPJO6XMBw41F8jz74JEFEmlzc5we
         n3HZhf5VbPrdzeiGBcEUM6ARzZI20/ZBJuVCmiNJj/WX88EW/heXIj+L//p67GT44KVu
         WhbW7PDWE9nV4fmEjgeLq41jdfHLL9iGYJRYtU6kthg8NuM/m7eWoIyaPKgqyUGMnmTV
         yVRKz84dsnQyW9JARCskrKEjvQ5K+RMD0i8643mSeqY79TZDRIw5kpgIgleariTduy+D
         XP/Q==
X-Gm-Message-State: APjAAAVWfAmaAh7+ZUZVeHphCFBRnPbWPNHkq4hduf+5W+gVpHUQ/Rkj
        G/KMIE2wjYu8aECbgW91SudyE15eth8tmxgkyYHXKA==
X-Google-Smtp-Source: APXvYqxPfC2AaMmcpVeHk1Tpt48D96D4KGTJEr69+O146yiz4vHIuWs+Xqgsr8gRQrOdkI+cG8QOzctsseortzlFbaE=
X-Received: by 2002:a92:9885:: with SMTP id a5mr4610787ill.107.1580393117337;
 Thu, 30 Jan 2020 06:05:17 -0800 (PST)
MIME-Version: 1.0
References: <20200128144026.53128-1-mirucam@gmail.com> <20200128144026.53128-6-mirucam@gmail.com>
 <nycvar.QRO.7.76.6.2001301330070.46@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2001301330070.46@tvgsbejvaqbjf.bet>
From:   "Miriam R." <mirucam@gmail.com>
Date:   Thu, 30 Jan 2020 15:05:06 +0100
Message-ID: <CAN7CjDBjJT30BrpWUnPOe-T7e3FkBohxxSP16PJvOF68quvw8A@mail.gmail.com>
Subject: Re: [PATCH v2 05/11] bisect--helper: introduce new `decide_next()` function
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

El jue., 30 ene. 2020 a las 13:31, Johannes Schindelin
(<Johannes.Schindelin@gmx.de>) escribi=C3=B3:
>
> Hi Miriam,
>
> On Tue, 28 Jan 2020, Miriam Rubio wrote:
>
> > diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> > index 21de5c096c..826fcba2ed 100644
> > --- a/builtin/bisect--helper.c
> > +++ b/builtin/bisect--helper.c
> > @@ -291,26 +291,14 @@ static const char need_bisect_start_warning[] =3D
> >          "You then need to give me at least one %s and %s revision.\n"
> >          "You can use \"git bisect %s\" and \"git bisect %s\" for that.=
");
> >
> > -static int bisect_next_check(const struct bisect_terms *terms,
> > -                          const char *current_term)
> > +static int decide_next(const struct bisect_terms *terms,
> > +                    const char *current_term, int missing_good,
> > +                    int missing_bad)
> >  {
> > -     int missing_good =3D 1, missing_bad =3D 1, res =3D 0;
> > -     const char *bad_ref =3D xstrfmt("refs/bisect/%s", terms->term_bad=
);
> > -     const char *good_glob =3D xstrfmt("%s-*", terms->term_good);
> > -
> > -     if (ref_exists(bad_ref))
> > -             missing_bad =3D 0;
> > -
> > -     for_each_glob_ref_in(mark_good, good_glob, "refs/bisect/",
> > -                          (void *) &missing_good);
> > -
> >       if (!missing_good && !missing_bad)
> > -             goto finish;
> > -
> > -     if (!current_term) {
> > -             res =3D -1;
> > -             goto finish;
> > -     }
> > +             return 0;
> > +     if (!current_term)
> > +             return -1;
> >  [...]
> > +
> > +static int bisect_next_check(const struct bisect_terms *terms,
> > +                          const char *current_term)
> > +{
> > +     int missing_good =3D 1, missing_bad =3D 1;
> > +     const char *bad_ref =3D xstrfmt("refs/bisect/%s", terms->term_bad=
);
> > +     const char *good_glob =3D xstrfmt("%s-*", terms->term_good);
> > +
> > +     if (ref_exists(bad_ref))
> > +             missing_bad =3D 0;
> > +
> > +     for_each_glob_ref_in(mark_good, good_glob, "refs/bisect/",
> > +                          (void *) &missing_good);
> > +
> >       free((void *) good_glob);
> >       free((void *) bad_ref);
>
> I know this is not something you introduced, but while you are already in
> the neighborhood, why not fix the types of `bad_ref` and `good_glob`? The
> `xstrfmt()` function returns `char *` for a reason: so that you do not
> have to cast it when `free()`ing the memory.

Sure! I will fix this.
Thank you for reviewing.
Best,
Miriam

>
> Thanks,
> Dscho
>
> > -     return res;
> > +
> > +     return decide_next(terms, current_term, missing_good, missing_bad=
);
> >  }
> >
> >  static int get_terms(struct bisect_terms *terms)
> > --
> > 2.21.1 (Apple Git-122.3)
> >
> >
