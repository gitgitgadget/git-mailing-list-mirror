Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC4E8C433F5
	for <git@archiver.kernel.org>; Fri, 31 Dec 2021 23:48:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbhLaXsc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Dec 2021 18:48:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbhLaXsb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Dec 2021 18:48:31 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E54C061574
        for <git@vger.kernel.org>; Fri, 31 Dec 2021 15:48:30 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id x15so113189678edv.1
        for <git@vger.kernel.org>; Fri, 31 Dec 2021 15:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9J0m4vN9ST1zOj7GUvqEZq/5O5cGjbGBQuondS+o4Mw=;
        b=Dp9Cp8c4fXwCCZiog2US7SGDxYWZLdH2FlxGW7IDn0P/LTpKVwrkFov24PkUKdkVXz
         3y2CPRypz4UabfydOr4GGYsNqASGxgrlQrl+W7Y3Wyn2+p5qBrDoG4ylkLq910eOWELI
         MOr61BKMKaZGGs8ENGMvVubDUZlZI32l3qlHzkYL9OAZVLqy/D5ZPDpIGrFv5kYOgkhm
         V4PNO7WKJvXdqmdBFHOt4a/7J2/pqtpQcuNPmBGX7f1n7O2KHo1HF3xNK//XSrXv79xk
         rRdeC5n7qxeHFg0H4S5EJfKkvdeZe+oVo2iNEEWAN4HEqz1gHZJRETS76f6WV8vqU5AN
         UyKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9J0m4vN9ST1zOj7GUvqEZq/5O5cGjbGBQuondS+o4Mw=;
        b=Z2Ykaf+mUStYfo96xFJ9fXxNFUCdGGhbDLWRvxyZ7ZE6hnPhOGWM7AAEcnZkITCQWa
         jbfYMNdRJfPc67DgRKmKdRfSscAT0R/99tiTmT4HzUzTxMEOb85Iy/E7QuIDs5zBPlgu
         CJ0KOL9Q7KV7d9i7w3srKayPM0baojap2QP++rS3CdhhIF1iLn35hub/UHBxBneGhx7K
         GayDcaxCQlvGSFdV8hKNfhHubb/MBmPERAhVhYPX6ruezadZc03F28NMBWCpjgYcgQ0O
         5XqAqBcST5OL4ZA+ivAPdDMieDXjBe3zLGa9drXqIfScHz0Zr3JEC5ZqykqAHa3j1ZOk
         a2ng==
X-Gm-Message-State: AOAM533hPFXI/lt8h5zp7QdrsE8SrCmj5yiQ6LBgtHPMac4T7iYYwPng
        VUWeJI6TdELYDmrSpGV29YwN14YTkp5deeOX/nqW8Jk4ws0=
X-Google-Smtp-Source: ABdhPJwEe9d+zeLX/2EmBoNUle+8GNA4aXZVEdzZRNcIlzU2uj/ezbFVkIrfw/LWmKC1i9c7lx1ZHyRIUUmxC0flbGU=
X-Received: by 2002:a05:6402:2891:: with SMTP id eg17mr36383592edb.33.1640994508994;
 Fri, 31 Dec 2021 15:48:28 -0800 (PST)
MIME-Version: 1.0
References: <61CC2DD2020000A10004691F@gwsmtp.uni-regensburg.de> <CAL3xRKet7KXTx+6ALVZCxeFRkU3guwNc6GtAT1iofB=UKqj2fg@mail.gmail.com>
In-Reply-To: <CAL3xRKet7KXTx+6ALVZCxeFRkU3guwNc6GtAT1iofB=UKqj2fg@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 31 Dec 2021 15:48:17 -0800
Message-ID: <CABPp-BHnpKZ8LJzd_NL_6TGe7U3A2xPDPuvBkDQ68iTH_un6=A@mail.gmail.com>
Subject: Re: Filtering commits after filtering the tree
To:     Son Luong Ngoc <sluongng@gmail.com>
Cc:     Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 31, 2021 at 2:27 AM Son Luong Ngoc <sluongng@gmail.com> wrote:
>
> Hi Ulrich,
>
> On Thu, Dec 30, 2021 at 12:28 PM Ulrich Windl
> <Ulrich.Windl@rz.uni-regensburg.de> wrote:
> >
> > Hi guys!
> >
> >
> > As  I know there are really smart ones around, please don't laugh how I helped myself with this problem:
> > https://stackoverflow.com/q/70505903/6607497
> > I'm sure you wouldn't have wasted hours with rebasing interactively...
> >
> >
> > Feel free to comment either on the list or at SO (comment or improved answer).
>
> You probably want to try git-filter-repo (1)
> while using `--message-callback` as documented in (2)

In particular, you'd get most of the way there with a simple

   git filter-repo --path my-module/

That will remove all files not under my-module/ from the repository,
AND remove all commits that become empty due to removing all the other
files.


If you had commits which both touched my-module/ and also made
reference to other files outside of my-module/, then you may also want
to clean those up.  If that's something you can write code to do
(perhaps because the commit messages were regular, or you are an
expert at parsing and rewriting natural language programatically),
then the --message-callback suggested by Son could help you out.  That
sounds difficult to me, because I don't know how to even identify such
commits without having a human being read every single one.

But it sounded to me like most of the commit messages you didn't want
were ones that just touched paths outside of your selected module, in
which case the simple path filtering I suggested above would clear
those all out for you.
