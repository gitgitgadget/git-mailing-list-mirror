Return-Path: <SRS0=ZiOn=25=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDFD9C00523
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 09:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE4FD20643
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 09:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZEVIpOPN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbgAHJPt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jan 2020 04:15:49 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:40019 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727205AbgAHJPs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jan 2020 04:15:48 -0500
Received: by mail-il1-f196.google.com with SMTP id c4so2069500ilo.7
        for <git@vger.kernel.org>; Wed, 08 Jan 2020 01:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=zJkUck5OBtyYzp8BDOY5FYHg0XXMnahU2+vhiJCCzbw=;
        b=ZEVIpOPNCNrU+miOqyxc2Kjf1hMkNhe+fRYUGLbknZNKdKrry/vDz8oAZk70K+mrIC
         rvBMmpNasFbxkrQyT3FrYJL3VSf1XenpxW3ORc5/nq8b3Ld71Cpy72XgTeiYPr4yeyqN
         0nFpDeM1lC1mg0yNEnWpwpcUZQ0ENG7DwpRGm7WZREx1hh/YqWGkS77nfepeeWYKPlwG
         8o4nDH19pQh1FrT/m/AFbB3adp2bZDVcb/fY6h06jjTORlGydT0r394DbDh4vB8TduIO
         kRi2NLfllodJyVKSD601zIBfKjvuXh4YScspcdwVgVXqJhdi9r/BXFUK7CQ45VqmGBlR
         vp1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=zJkUck5OBtyYzp8BDOY5FYHg0XXMnahU2+vhiJCCzbw=;
        b=DihFFz8ztAGVIQzRcv5IZUBRQtKuQhZalM1oYy5h7XibOUDaVpkDx3+8ajhgxY/IUL
         Ny30RYDRJtEjyF+mhILyHB0D0lbiYUMyPG5Im89jOEV2XoDopwK5GsZO4bdoXEWptgrj
         d8TfsGWQ+RBaWgVhagOPGeyEIC7UwnVh01NIcg84K1R75Xt7YtqOEzBlnm7YpiD972h9
         1/3Yzv+vYxKK1nDqs3U5RpQWVnQaB00JMPjmgf1RehNC1Mna8AfX6SCiviHfYpR2JWbq
         6jYIq62TNnVyejiORGLjZ7ggC9eHTvpdxXfOtnjm6D4W+SNEisOfsoETrie4+uT+ibZR
         xWTQ==
X-Gm-Message-State: APjAAAVv0mFuVzCXS3hG0SkQ3CPaQ7lYZFr17t6aXqgGCwhZFSq514Ra
        /7Gn1DiCgPUFCeZpCnh6RFVHn2fSSVGE51jiuoA=
X-Google-Smtp-Source: APXvYqyvV2hdVxY+JT12jiCEIfs9+Y/Rwg/LvL3ugB6+MdI+4r/TujZaYUW+j6QQY1DrLwOZUCQfKoLu4MiOaan7gkM=
X-Received: by 2002:a92:9885:: with SMTP id a5mr3056541ill.107.1578474947935;
 Wed, 08 Jan 2020 01:15:47 -0800 (PST)
MIME-Version: 1.0
References: <20200107013640.1821227-1-sandals@crustytoothpaste.net>
 <20200107110145.GA1073219@coredump.intra.peff.net> <20200108024732.GL6570@camp.crustytoothpaste.net>
In-Reply-To: <20200108024732.GL6570@camp.crustytoothpaste.net>
From:   "Miriam R." <mirucam@gmail.com>
Date:   Wed, 8 Jan 2020 10:15:37 +0100
Message-ID: <CAN7CjDCv2uYNaHEtQv6Zco33-Cba1Fn2by87NU_3vwytZHy_WA@mail.gmail.com>
Subject: Re: [PATCH] run-command: avoid undefined behavior in exists_in_PATH
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        "Miriam R." <mirucam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

El mi=C3=A9., 8 ene. 2020 a las 3:47, brian m. carlson
(<sandals@crustytoothpaste.net>) escribi=C3=B3:
>
> On 2020-01-07 at 11:01:45, Jeff King wrote:
> > > Noticed-by: Miriam R. <mirucam@gmail.com>
> > > Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> >
> > I think Miriam actually posted the same patch in her initial email:
> >
> >   https://lore.kernel.org/git/CAN7CjDDBA0ZoCG9aaQf5rg3gxqny=3DEjR6v6jE1=
mnxvUJQSF_0Q@mail.gmail.com/
> >
> > I don't know how we want to handle authorship.
>
> I don't feel strongly about holding authorship; I'm happy to have her
> name on it instead of mine since she did propose a solution.  I just
> care that we fix it.
> --
Hi,
my mentor (Christian Couder <chriscool@tuxfamily.org>) was who
detected the problem and sent me the solution, I only asked the
community. I think his name should be in the patch instead of mine.

Best,
Miriam
> brian m. carlson: Houston, Texas, US
> OpenPGP: https://keybase.io/bk2204
