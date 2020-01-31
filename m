Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD7FC33CB2
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 09:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2BC9206F0
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 09:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cv9FFcbt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbgAaJPk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 04:15:40 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:47068 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728159AbgAaJPk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 04:15:40 -0500
Received: by mail-ed1-f68.google.com with SMTP id m8so6976786edi.13
        for <git@vger.kernel.org>; Fri, 31 Jan 2020 01:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PZZ63G4j1NWbY+162xTSkVAqNCD6M1BTC14eX3vS/hA=;
        b=cv9FFcbtGwmXDErvP3XIJoWn8Z8FvUdeC6EmXfPHxd7seL414wVmxfJlbxpe1xGG2R
         bWE488Wjhcny3xSEOtzmcWCjRoWO90gINyZvWrupjyaCXYKBe03POgv6tVPIwCSS9PTG
         cU9M6LGqnb7BoFWq9ENmwU8LUU+w89BnCHJLI8eCFFnC81SoP+oe/5CMP8ipT/jxqcDO
         xuVT+7QCIS0Uck/zjbBfyq6dpv7Hrj7TU88sR+5/JN7m6XbX3Dem7rHzcdzTNLEh1USD
         sGnbXdgK6588+nEbrJARLqqGXalDy89uwsHMU+N66otrF4n/J+xU422o7ZCNZgb8D54s
         +GZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PZZ63G4j1NWbY+162xTSkVAqNCD6M1BTC14eX3vS/hA=;
        b=sVc41o4xOrV1tlo90TqOxXuvOW9SVVX9PRMh3TTOQhvVWdYOIi6ovPzns11VPD2brE
         YdUyArWwZTF3PDEKHDDzLqS5vJNKnd9046PndpoSISgu1UxsbFntDlE2/psqK96PzVpJ
         0/PPLYvxJAyuN10atFSnnqv9HZAK15TxrODu1SucKJ2AsMQGz/iMvmrhwR5PqQeb51Ba
         hLUMPXjqfRwjQVkyW+Rb6uPrbLh62pgN/QzZ2y4Jrl6ocXXiX3g4DTXTomPog0Vae3eU
         n7wSBJD2mkz75w88g1UKgDE8aicYTw71Z6SC4XuXoNa/hqeWGtK94IQieJNa4ZF4cQyj
         EAJg==
X-Gm-Message-State: APjAAAW2+6IjyP6CrGPBeBGZTkhRxY2E+/wvybrCKlLdZtjzDDfP1Hzo
        6dJFMOR5Ti3yZSlx9gyCaRVTYb/0bGUFx8PaqLo=
X-Google-Smtp-Source: APXvYqzO8nYQRzr/TOJsLsoVuF3Glhgrcl7L7EVjrsaAZEeNtGA+ZaqUJa3EK/bz7ZjiLXu7Kk7R1uv5nc3KGTDiC/M=
X-Received: by 2002:a17:906:8595:: with SMTP id v21mr8054860ejx.28.1580462138122;
 Fri, 31 Jan 2020 01:15:38 -0800 (PST)
MIME-Version: 1.0
References: <20200128144026.53128-1-mirucam@gmail.com> <20200128144026.53128-10-mirucam@gmail.com>
 <nycvar.QRO.7.76.6.2001301341100.46@tvgsbejvaqbjf.bet> <CAP8UFD3mhirdjHnT+XRq1mPzii3O+mtAMrYCy7mf4HKQZo8Acw@mail.gmail.com>
 <nycvar.QRO.7.76.6.2001311006360.46@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2001311006360.46@tvgsbejvaqbjf.bet>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 31 Jan 2020 10:15:25 +0100
Message-ID: <CAP8UFD2Crc2k7vdqxAaAvyLUqz5VdSfL6cfY110LHE2RpPRBKQ@mail.gmail.com>
Subject: Re: [PATCH v2 09/11] bisect: libify `check_good_are_ancestors_of_bad`
 and its dependents
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Miriam Rubio <mirucam@gmail.com>, git <git@vger.kernel.org>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Tanushree Tumane <tanushreetumane@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On Fri, Jan 31, 2020 at 10:07 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> On Thu, 30 Jan 2020, Christian Couder wrote:
>
> > On Thu, Jan 30, 2020 at 2:46 PM Johannes Schindelin
> > <Johannes.Schindelin@gmx.de> wrote:
> > >
> > > On Tue, 28 Jan 2020, Miriam Rubio wrote:
> >
> > > > +             /* Create file BISECT_ANCESTORS_OK. */
> > > > +             fd = open(filename, O_CREAT | O_TRUNC | O_WRONLY, 0600);
> > > > +             if (fd < 0)
> > > > +                     warning_errno(_("could not create file '%s'"),
> > > > +                                   filename);
> > > > +             else
> > > > +                     close(fd);
> > > > +     }
> > >
> > > I wonder whether this would be easier to read:
> > >
> > >         if (res == -11)
> > >                 res = 0;
> > >         else if (res)
> > >                 ; /* error out */
> > >         else if ((fd = open(filename, O_CREAT | O_TRUNC | O_WRONLY, 0600)) < 0)
> > >                 res = warning_errno(_("could not create file '%s'"), filename);
> > >         else
> > >                 close(fd);
> > >
> > > Note: my code explicitly assigns `res = -1` if the file could not be
> > > created, which is technically a change in behavior, but I think it is
> > > actually a bug fix.
> >
> > I don't think so. I think creating the BISECT_ANCESTORS_OK file is not
> > absolutely necessary. If it doesn't exist we will just check if
> > ancestors are ok again at the next bisection step, which will take a
> > bit of time, but which will not make us give any false result, or
> > prevent us from continuing the bisection process.
> >
> > I think that it's also the reason why warning_errno(...) is used in
> > case we could not create the file instead of error_errno(...). We just
> > want to signal with a warning that something might be wrong because we
> > could not create the file, but not stop everything because of that.
>
> Thank you for this explanation, it makes sense to me.
>
> Maybe a code comment would be in order?

Yeah, I agree it would help.

Thanks for your review,
Christian.
