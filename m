Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF64C54FCB
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 21:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE55B2071E
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 21:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkmjacyP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbgDVVS3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 17:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgDVVS2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Apr 2020 17:18:28 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F135C03C1A9
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 14:18:27 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id u11so4119113iow.4
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 14:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=F1X+IYwPTFx3wv4zCIQp1X8wYLJUabfDK/5/4Oucp9g=;
        b=dkmjacyPMCN5FN51pusnfhAOKtMDH8WiTKhGdSKF2SxguJ1kHLe7wz4dCYXwNVfFR+
         dQxzmRMlWB6i97nCf7FYRbMunJHkkg++KxdYzOyuxP7NirXkQiz2a2MBaWsR5MEgpGWp
         FWuAno01+oPIKBKhE3JRE52RnN9tLflbEngQQad5b9Igw3G3BUd0UWsgw8wLpu7kKGu8
         2Yh0Q50QAFezWE02Mc4+KHjEhNWgFnMH+sZHPVcU+l+S+mG/zzlnoO56YXiPMR/Ewx2o
         QfQ6yCTPyPLw8/QziEBzKrXGWlkiWiUG4o8EX9OwH96IFDNXeEcZnTb/QTpHvFUggOg0
         oSCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=F1X+IYwPTFx3wv4zCIQp1X8wYLJUabfDK/5/4Oucp9g=;
        b=RCk85CYLsChYKpsTgsP9HDKXUtH+uyTdM5PemMlIBiqi6/OuUSo2p7J47zTVM5Ttgh
         ezEGP5nrPiF26JGa72pjoxpcAMm062qzJ8tE0w53boag5gTNSDL5Xq8pbtHQtFHlG0kq
         jlNzL9EhA//eqBgYYEKUMuIkLjN4LezXMS/ZPEpUWHoTaRMmErlrcpXD6UnYQ0jqDg/S
         OPU45zKylo8qOGMSczBApPlsBIDkD5uctZa360nYxJ8BYG/OEmqdhR2cIMHIUxiO6rmq
         mwsRscpY2ftaJ2goQW7aO+DchFOOmHBg8JPaBj2JrUKjjxcW9k25h3w1ovXdsw1Kjhxx
         Qkcw==
X-Gm-Message-State: AGi0PuYnkOyFCr7DM9sPyxpMjqO8AFStC4T36gnY1bIo4I0aUJ5d0z9H
        IHTc6ykorhDQp0wiAnzmtOuhX6VgS4bh5Mjc340=
X-Google-Smtp-Source: APiQypKVNo+XtNnLJr7x85meKEh9HmbwWMyVyLG36KVKAOhLO6UAGEfz7I4zUzDUGW/8QOrYG9DlT8zwlZwkWdoqpFI=
X-Received: by 2002:a05:6602:2cc4:: with SMTP id j4mr737441iow.144.1587590306543;
 Wed, 22 Apr 2020 14:18:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200422153347.40018-1-jrtc27@jrtc27.com> <20200422164150.GA140314@google.com>
 <CA+sFfMfre6W5GcPh1pWcroFD9S9OPj_uLp5CK11yh-UhqgDs2w@mail.gmail.com>
 <CA+sFfMf=NZOV41-4oJTLF34rvELr7EvfEHOr90X_h8pSFC3AJQ@mail.gmail.com> <20200422195839.GE558336@coredump.intra.peff.net>
In-Reply-To: <20200422195839.GE558336@coredump.intra.peff.net>
From:   Brandon Casey <drafnel@gmail.com>
Date:   Wed, 22 Apr 2020 14:18:15 -0700
Message-ID: <CA+sFfMcsiXcEV=oq-cdm1zVm2gvn=Ae1BU264puFU=E2JBQVCw@mail.gmail.com>
Subject: Re: [PATCH] config.mak.uname: Define FREAD_READS_DIRECTORIES for GNU/Hurd
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Jessica Clarke <jrtc27@jrtc27.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 22, 2020 at 12:58 PM Jeff King <peff@peff.net> wrote:
>
> On Wed, Apr 22, 2020 at 12:13:50PM -0700, Brandon Casey wrote:
>
> > On Wed, Apr 22, 2020 at 11:48 AM Brandon Casey <drafnel@gmail.com> wrot=
e:
> > >
> > > I just looked in config.mak.uname, and I'm surprised to see
> > > FREAD_READS_DIRECTORIES set for so many platforms. And it's set for
> > > Linux and Darwin?!?!? Junio added it for Darwin
> > > (8e178ec4d072da4cd8f4449e17aef3aff5b57f6a) and Nguy=E1=BB=85n Th=C3=
=A1i Ng=E1=BB=8Dc Duy
> > > added it for Linux (e2d90fd1c33ae57e4a6da5729ae53876107b3463), but
> > > also seemed to mistake the intention of FREAD_FREADS_DIRECTORIES as
> > > being about the fopen(..., "r") of a directory rather than about an
> > > fread() of a directory.
> > >
> > > I just wrote a test program and tested on Linux, Darwin, and Windows.
> > > Linux and Darwin both succeed to fopen() a directory and fail to
> > > fread() it, as expected. Windows fails to fopen() a directory.
> > >
> > > I notice this earlier commit mentions a failure of t1308
> > > (4e3ecbd43958b1400d6cb85fe5529beda1630e3a). I wonder if this is the
> > > reason FREAD_READS_DIRECTORIES was added to so many platforms?
> >
> > Whoops, I got the order of e2d90fd1c33ae57e4a6da5729ae53876107b3463
> > and 4e3ecbd43958b1400d6cb85fe5529beda1630e3a wrong. Looks like the
> > misunderstanding of FREAD_READS_DIRECTORIES in e2d90fd could have been
> > the cause of all of this. That commit introduced the test t1308 and
> > added FREAD_READS... to Linux, kFreeBSD, and FreeBSD, and the other
> > additions followed shortly after.
>
> I think the code is actually doing the right thing (or at least
> something useful), and the "FREAD" in the name is the confusing part.
> Because there's now code doing:
>
>   fh =3D fopen(fn, "r");
>   if (!fh) {
>     if (errno =3D=3D ENOENT || errno =3D=3D EISDIR) {
>        /* not actually a file; treat as a gentle noop */
>        return 0;
>     } else {
>        die_errno("omg, a real open error");
>     }
>   }
>   if (!fread(..., fh))
>        die_errno("omg, a real read error");
>
> which is exactly what the failing test in t1308 is doing.
>
> I know that wasn't the original intent of the flag, but I think it was a
> conscious decision to build on around the time of e2d90fd1c, when we
> started actually checking fopen() return values (as opposed to just
> segfaulting).

Our policy has always been to check return values hasn't it?

> And in practice, do we really care about cases that can fopen a
> directory but refuse to read from it? It's simpler and more efficient to
> catch this case up front.

I'm not sure I agree that it's simpler and more efficient to catch
this up front. Catching the case where a directory is supplied when
only a file is valid is an error path which we generally do not
optimize for, and it requires us to add an extra stat to every fopen()
call. We should have always been checking both the fopen() and any
reads and handle a failure in either one. So normally we wouldn't have
to do anything special to produce an error for the case of a directory
being supplied.

Now, if you want to ignore when a directory is supplied, and not
produce an error, I would expect the code to actually check for that
explicitly/clearly and not depend on fopen() failing, since that is
not a common behavior.

> So I think the knob has de facto become "do we need to use our compat
> wrapper to make opening a directory fail with EISDIR". And any attempt
> to change that will mean adapting all of the callers to handle that case
> themselves. I think what we have now is the useful knob we want; it's
> just misnamed (and obviously I don't blame your original patch; it was
> adapted over time).

We've generally taken the approach that there is an expected "normal"
behavior for the c library, generally the linux/glibc behavior. Then,
for platforms that behaved differently from what we've defined as
"normal", we'd introduce a compatibility function to make them behave
the way we wanted them to behave, or as close to that as possible. But
what you're suggesting here seems different. You're suggesting that we
should modify the behavior of fopen from what is commonly considered
"normal" so that it behaves in a new uncommon way. That doesn't seem
like the right thing to do.

Instead, I would think it would be better to introduce a new function
that has the behavior we want and to explicitly call that function
instead of pretending that we're calling fopen(). Otherwise it just
leads to confusion since _our_ fopen() doesn't actually work the way
fopen() "normally" works on our common platform.  Maybe call it
fopen_file_only() or something. I've been away from git development
for too long to know whether most fopen callsites would need to use an
fopen_file_only() function or whether it would just be a few special
instances, and the rest could just use a regular fopen().

-Brandon
