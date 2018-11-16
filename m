Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 785C41F87F
	for <e@80x24.org>; Fri, 16 Nov 2018 19:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbeKQFjg (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Nov 2018 00:39:36 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:54752 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbeKQFjg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Nov 2018 00:39:36 -0500
Received: by mail-it1-f196.google.com with SMTP id a205-v6so30862418itd.4
        for <git@vger.kernel.org>; Fri, 16 Nov 2018 11:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DpPsjpQjb0zUnH76ZDRe5rj937dw8kJdX80StAHuXps=;
        b=BrcfceNlrp9OAx/AUz0LfuLG3HP/1O3m2qY9mSypwMP3mnruTd5P24cu/MeZXTrvuQ
         vwy+GUJgEWHfrJFtL1IINsXO+IpX9ODPSLerYRSFgU0ilSgF5hwISm66IzeJx2sBjE5K
         JSR9RmaODJBXMHDlLXUuQMtsagYyfgMzzqAK7yBCaANt7i+09+5vV8l3XBNgRJeIVx2s
         VJWQy9AgSCORqcX8e7HW3EIZE3xKPiZ+Nd6D0uZ/ElZy4LqS4dNgCY5PW3waAbAKqeSh
         BY6IvfVLxky2qYJnWRSQBlHvXpkVVHKqQILedwgucSIE11gJ5IfXyX98CS037UQ2DHwF
         E0Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DpPsjpQjb0zUnH76ZDRe5rj937dw8kJdX80StAHuXps=;
        b=WQJXEG3kBQaLL3qCh5fnPs7DTsBW7MBTNs0GlcwC+URv14Of4mWvREaa9Ph6gee9L4
         3gAnzZSnFYb4q+jWpa6L8HkPktJ7mPIQkPaQ8LcJDwZ1ZMW4dBWm56+1ZnBEl6r2SjTG
         82k3N8+j3IrATUot0b2rT2jkYis6+vl6zdxu6MVDGzaTexjg4ASa4sdS2JUckoXWYdHO
         eALws761ox9U4oB5Lnb6rZXIFD0HHLPt8y5xyiuBaDtMBhOkYbUSlJOt8H3lapSaQt0q
         HpZ72oapWLxW5yBJlvhqK4uxhhXrfznh/JFDAgAKT/m5NKCzO4KHIUIBCpco/9Zyjo4a
         4Ctw==
X-Gm-Message-State: AGRZ1gI47OTw/WyxqO+CilMm6MHabRSTtRUCPY3M9XNpmVcNIN2ibFhF
        DAVe+E3TCLZt93ioYo7D/KdlJCgQ7VP0wzwBhQfF0j6O
X-Google-Smtp-Source: AJdET5fOmN8HaZBgMQyIekzni08/tt2G17m+PpQQmWNkNx35lfLHTKgaQTOArZtzhTSVXukkr45ThBrMSDBFSx72l+g=
X-Received: by 2002:a02:3003:: with SMTP id q3mr6026034jaq.16.1542396355013;
 Fri, 16 Nov 2018 11:25:55 -0800 (PST)
MIME-Version: 1.0
References: <20181116173105.21784-1-chriscool@tuxfamily.org> <20181116182934.GN30222@szeder.dev>
In-Reply-To: <20181116182934.GN30222@szeder.dev>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 16 Nov 2018 20:25:43 +0100
Message-ID: <CAP8UFD2tC9B_m=NmK4DTCJP=o+L+RKy9C_2ra9fgeNMzOuCZ3A@mail.gmail.com>
Subject: Re: [PATCH v2] read-cache: write all indexes with the same permissions
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 16, 2018 at 7:29 PM SZEDER G=C3=A1bor <szeder.dev@gmail.com> wr=
ote:
>
> On Fri, Nov 16, 2018 at 06:31:05PM +0100, Christian Couder wrote:
> > diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
> > index 2ac47aa0e4..fa1d3d468b 100755
> > --- a/t/t1700-split-index.sh
> > +++ b/t/t1700-split-index.sh
> > @@ -381,6 +381,26 @@ test_expect_success 'check splitIndex.sharedIndexE=
xpire set to "never" and "now"
> >       test $(ls .git/sharedindex.* | wc -l) -le 2
> >  '
> >
> > +test_expect_success POSIXPERM 'same mode for index & split index' '
> > +     git init same-mode &&
> > +     (
> > +             cd same-mode &&
> > +             test_commit A &&
> > +             test_modebits .git/index >index_mode &&
> > +             test_must_fail git config core.sharedRepository &&
> > +             git -c core.splitIndex=3Dtrue status &&
> > +             shared=3D$(ls .git/sharedindex.*) &&
>
> I think the command substitution and 'ls' are unnecessary, and
>
>   shared=3D.git/sharedindex.*
>
> would work as well.

If there is no shared index file with the above we would get:

shared=3D.git/sharedindex.*
$ echo $shared
.git/sharedindex.*

which seems bug prone to me.
