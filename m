Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5372C2D0DB
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 14:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 962BB206D3
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 14:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lU3BHDKP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbgA3Oll (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 09:41:41 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:46867 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbgA3Oll (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 09:41:41 -0500
Received: by mail-io1-f66.google.com with SMTP id t26so4200778ioi.13
        for <git@vger.kernel.org>; Thu, 30 Jan 2020 06:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=U6Uu1uYJwf05jTCWZG1rKbthtWxMuMO6VXPSSNR/CTw=;
        b=lU3BHDKPUTPtwn5ZRs5E/jZf+llIo1FxMuY9sHEdJYp+xFdYBWu61hLuZoS5KyMUUf
         3EZam/q77FQarGyBMz1KuG1JZI6n4k2xwCJeWmCNMz+P5YUKwJDtyWR664ih+bRq97Tf
         th5pNnAQL/KtxzM2xgNiEMrmg6UoaS6zvMnYK1Wn1FPYs2UKOR29G+jCTCqS/6yDjXSh
         oBPk3rgSFSqsiXN4Yzn0EM3CfYd8vGUE4XKzwjJpjzkNtIjyLFnfV5A1/iKXEC/3BQ6z
         1gNHXf19NiCdQE7HFgyiis7fCyNt6VQED1bgn+sybtvVhk+NSLAbFJoMF7LheKzD4yfC
         nEHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=U6Uu1uYJwf05jTCWZG1rKbthtWxMuMO6VXPSSNR/CTw=;
        b=Y2S6lzFjgCapGk7aKPIWHzISF+0DmIt4TD566n4vYbcu92lfYrdxQ2UXu+2uI9iU5I
         HjjpozfcP0cnIvOaL8051J2DyMTQIWjaPyHhHHR9tIhyYbxadPVctaPOMnAQodkgGMp6
         B9nr1lNURMKFDhdgheeut1pSeAugUSOZpcowWwFtHHvSK2Nc/Kl7qfnSqMGFEc0Z3Qpi
         9gGHXYQv4nRtd5IddUA2umGrL70BTNfXbaGxKi+LktIujPNIy+R5XXMJMATrn2dod+2+
         LAKd06xZ2zX+n92vacLz07OIHf25Y1FkKjyX+Qcf3jxW4REl3PyUGXJxecpyS5HmIudh
         pzJw==
X-Gm-Message-State: APjAAAWh7hK18ZeMM4Ef4En56ovN/nYXrdWkYanWJLjM4CEK+sb5st4S
        04ptrVPueIBP8LTcJEfUhPQKs+aW0gD3C70gwK25Xg==
X-Google-Smtp-Source: APXvYqwtJJFSZ6MBv14Cdj1viwKfAC4qpZMafHKrzKoAwGUq5IlA+HZzSkhBFJTbcvIDKwgs9mq7hY7PZeEKwLQ8gTI=
X-Received: by 2002:a02:cc7a:: with SMTP id j26mr4168559jaq.79.1580395298985;
 Thu, 30 Jan 2020 06:41:38 -0800 (PST)
MIME-Version: 1.0
References: <20200128144026.53128-1-mirucam@gmail.com> <20200128144026.53128-5-mirucam@gmail.com>
 <nycvar.QRO.7.76.6.2001301332450.46@tvgsbejvaqbjf.bet> <CAN7CjDCiG6KZU+yHGxQ26TESb1yfvc7aWh0EKhE=owSV7D-C0Q@mail.gmail.com>
In-Reply-To: <CAN7CjDCiG6KZU+yHGxQ26TESb1yfvc7aWh0EKhE=owSV7D-C0Q@mail.gmail.com>
From:   "Miriam R." <mirucam@gmail.com>
Date:   Thu, 30 Jan 2020 15:41:27 +0100
Message-ID: <CAN7CjDC+LaZmNUoW=MKHy=08KnCgVtxA3_CXUpNQvqo3_cPcWQ@mail.gmail.com>
Subject: Fwd: [PATCH v2 04/11] run-command: make `exists_in_PATH()` non-static
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

El jue., 30 ene. 2020 a las 13:36, Johannes Schindelin
(<Johannes.Schindelin@gmx.de>) escribi=C3=B3:
>
> Hi Miriam,
>
> On Tue, 28 Jan 2020, Miriam Rubio wrote:
>
> > From: Pranit Bauva <pranit.bauva@gmail.com>
> >
> > Removes the `static` keyword from `exists_in_PATH()` function
> > and declares the function in `run-command.h` file.
> > The function will be used in bisect_visualize() in a later
> > commit.
>
> I inspected the code in `exists_in_PATH()` and in `locate_in_PATH()` and
> it looks as if neither of them depended on file-local variables (which
> would otherwise need to be addressed when exporting the function).
>
> If you contribute another iteration of this patch series, it might make
> sense to mention this in the commit message explicitly.

Ok, I will add the comment in the commit message.
Thank you.

Best,
Miriam

>
> Thanks,
> Dscho
>
> >
> > Mentored by: Christian Couder <chriscool@tuxfamily.org>
> > Mentored by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> > Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
> > Signed-off-by: Miriam Rubio <mirucam@gmail.com>
> > ---
> >  run-command.c |  2 +-
> >  run-command.h | 11 +++++++++++
> >  2 files changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/run-command.c b/run-command.c
> > index f5e1149f9b..4df975178d 100644
> > --- a/run-command.c
> > +++ b/run-command.c
> > @@ -210,7 +210,7 @@ static char *locate_in_PATH(const char *file)
> >       return NULL;
> >  }
> >
> > -static int exists_in_PATH(const char *file)
> > +int exists_in_PATH(const char *file)
> >  {
> >       char *r =3D locate_in_PATH(file);
> >       int found =3D r !=3D NULL;
> > diff --git a/run-command.h b/run-command.h
> > index 592d9dc035..7c8e206d97 100644
> > --- a/run-command.h
> > +++ b/run-command.h
> > @@ -172,6 +172,17 @@ void child_process_clear(struct child_process *);
> >
> >  int is_executable(const char *name);
> >
> > +/**
> > + * Returns if a $PATH given by parameter is found or not (it is NULL).=
 This
> > + * function uses locate_in_PATH() function that emulates the path sear=
ch that
> > + * execvp would perform. Memory used to store the resultant path is fr=
eed by
> > + * the function.
> > + *
> > + * The caller should ensure that $PATH contains no directory
> > + * separators.
> > + */
> > +int exists_in_PATH(const char *);
> > +
> >  /**
> >   * Start a sub-process. Takes a pointer to a `struct child_process`
> >   * that specifies the details and returns pipe FDs (if requested).
> > --
> > 2.21.1 (Apple Git-122.3)
> >
> >
