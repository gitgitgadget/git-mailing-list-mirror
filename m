Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50403C54FCB
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 18:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25BE22076E
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 18:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iTu9dku6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgDVSsi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 14:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbgDVSsh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Apr 2020 14:48:37 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F23C03C1A9
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 11:48:36 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id k6so3593452iob.3
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 11:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6X8RKDt3jhyonE09ow557P6i9f65eKKOV64U4zfs6W0=;
        b=iTu9dku6T2xQbkpg0pPy5eoU+q4+1vYF8M8EpCvUD3f78PatkSaC/a6J11FNYPhgTU
         s61tv8hyA2USE+vNtbnUQqsvpYYNSzFJ1UsNpFyRf5P12KA5JBakTbq+v2JdvR+U0Yku
         tm1JlulxkO4gu26Bj8A2sFMpfZF9nxnWWXDhnYd9BhUsXlIgph/VdUB3qBiD3C68XcMC
         WYtdi+PVml7cAipD9tFRX1V+T+iKpekwFlHBR4sUjZF1CHMUT7pOgLYF+WXbNGoLNZqx
         eweqrbOH8i/6fq8hlcQvhoeucltHC7LRgr6IgJ9Yt7fiRI02n4IP9TYa9Sc4tRn8QkFf
         bDjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6X8RKDt3jhyonE09ow557P6i9f65eKKOV64U4zfs6W0=;
        b=nqHQInFEOB1ruCUDEPnWz6DTRUPHaGOSqdfXIHmDoXAbd0F9JuOv+XgTEdwazbOD8d
         dqcuq0Hx1Cyw7SvrbrX1GwTwX2QX+wyf9jj7qSOAYQqFD6tak7vmf9hYfWpIWNBEY7hi
         Z12GmeNermy21xlijSMglDZDu8YWARL2iQdDEcAYVGvE6czOskCThR6HxyBujjFHDHS7
         4TYaJDTJEoDNxSruIgcjDMEPhbS8+XMLrViL8/g03gLGL5ndFzdNaNMDmg7sly0r0cOX
         u/rePCI0oL0TxsyB1DvpfZ1VTNWWS12vO73IfOGV4RmMmWpkPGwoy7PFzrYrc0rOh4fT
         c9xw==
X-Gm-Message-State: AGi0PuYVcRjt+q6y/wVM6sKAt3uJIQAW9nLAyvzVO5G5jgy2eIeBbAbU
        4j7Uc8P3r00xOtyLGPq+rNNs7MnM4rsLAJ7T6q5qq9/v
X-Google-Smtp-Source: APiQypJWqY1Pk2es0cyzmd676uZZKIUHFXNg+80LwUTPFLdF/0ZS0/eINleqcsdHLqo9PDiCWvhzZMdVdetfRd8121w=
X-Received: by 2002:a05:6602:2cc4:: with SMTP id j4mr127957iow.144.1587581315507;
 Wed, 22 Apr 2020 11:48:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200422153347.40018-1-jrtc27@jrtc27.com> <20200422164150.GA140314@google.com>
In-Reply-To: <20200422164150.GA140314@google.com>
From:   Brandon Casey <drafnel@gmail.com>
Date:   Wed, 22 Apr 2020 11:48:23 -0700
Message-ID: <CA+sFfMfre6W5GcPh1pWcroFD9S9OPj_uLp5CK11yh-UhqgDs2w@mail.gmail.com>
Subject: Re: [PATCH] config.mak.uname: Define FREAD_READS_DIRECTORIES for GNU/Hurd
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jessica Clarke <jrtc27@jrtc27.com>, git <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 22, 2020 at 9:41 AM Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> Jessica Clarke wrote:
>
> > GNU/Hurd is another platform that behaves like this. Set it to
> > UnfortunatelyYes so that config directory files are correctly processed=
.
> > This fixes the corresponding 'proper error on directory "files"' test i=
n
> > t1308-config-set.sh.
> >
> > Thanks-to: Jeff King <peff@peff.net>
> > Signed-off-by: Jessica Clarke <jrtc27@jrtc27.com>
> > ---
> >  config.mak.uname | 1 +
> >  1 file changed, 1 insertion(+)
>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
> Thanks.
>
> > diff --git a/config.mak.uname b/config.mak.uname
> > index 0ab8e00938..3e526f6b9f 100644
> > --- a/config.mak.uname
> > +++ b/config.mak.uname
> > @@ -308,6 +308,7 @@ ifeq ($(uname_S),GNU)
> >       NO_STRLCPY =3D YesPlease
> >       HAVE_PATHS_H =3D YesPlease
> >       LIBC_CONTAINS_LIBINTL =3D YesPlease
> > +     FREAD_READS_DIRECTORIES =3D UnfortunatelyYes
> >  endif
>
> I wonder why we set up this knob this way.  A lot of operating systems
> support fopen(..., "r") of a directory --- wouldn't it make sense for
> FREAD_READS_DIRECTORIES to be the default and for users on stricter
> platforms to be able to set FREAD_DOES_NOT_READ_DIRECTORIES if they
> want to speed Git up by taking advantage of their saner fread?

At the time it was written, the assumption in the code was that an
fread() on a directory would produce a failure, and that that was the
sane and common behavior. fopen(..., "r") on a directory was expected
to be successful on most platforms, but does fail on some. I don't
recall if it failed on any of the platforms I had access to at the
time (Solaris, IRIX), but it does fail on Windows. So I introduced
this feature that would make fopen() fail when opening a directory for
use on the platforms where fread() of a directory did not fail,
instead of trying to wrap fread().

I just looked in config.mak.uname, and I'm surprised to see
FREAD_READS_DIRECTORIES set for so many platforms. And it's set for
Linux and Darwin?!?!? Junio added it for Darwin
(8e178ec4d072da4cd8f4449e17aef3aff5b57f6a) and Nguy=E1=BB=85n Th=C3=A1i Ng=
=E1=BB=8Dc Duy
added it for Linux (e2d90fd1c33ae57e4a6da5729ae53876107b3463), but
also seemed to mistake the intention of FREAD_FREADS_DIRECTORIES as
being about the fopen(..., "r") of a directory rather than about an
fread() of a directory.

I just wrote a test program and tested on Linux, Darwin, and Windows.
Linux and Darwin both succeed to fopen() a directory and fail to
fread() it, as expected. Windows fails to fopen() a directory.

I notice this earlier commit mentions a failure of t1308
(4e3ecbd43958b1400d6cb85fe5529beda1630e3a). I wonder if this is the
reason FREAD_READS_DIRECTORIES was added to so many platforms?

-Brandon
