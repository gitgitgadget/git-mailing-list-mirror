Return-Path: <SRS0=ZiOn=25=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82EB0C00523
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 10:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5283A2075D
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 10:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r3OMs8tf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbgAHK3F (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jan 2020 05:29:05 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35771 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbgAHK3F (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jan 2020 05:29:05 -0500
Received: by mail-ed1-f65.google.com with SMTP id f8so2155366edv.2
        for <git@vger.kernel.org>; Wed, 08 Jan 2020 02:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UK46MjMxyt2b/YKUalFJMH4sT+sxziKhiTJ8T5W/JaE=;
        b=r3OMs8tfFNCpx5rXIKVaj/YYMPg0tjD7S95vMpxgNnIyBk7l3yVnakxQO1nVGbRJrC
         sgc5riO8l2NNhr0HCRaZ0Iuy+91NudwyzSGsVx6BXl5hZVnNdzY6aH69Cwtbt/XVNXWe
         Z2XEbqz04KIrkhV6BUGBwmFlZVePx3QmA62K2G3G5qepeknX9HIjk1NSURR1HbgZrQmK
         +hIStIyEpyUHkT/XY/5OJ4dbVV0ILR4DS8t1/sihl8/Q3oDhJly1MhlKi4XqvJFOwFwy
         OPu5o3RDrl2K4M0NcJUzUvKAOUe+Kci4FZGpQyNoqnUuVSyCY4OeFZmZ8LSmIJtGNHCG
         kfWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UK46MjMxyt2b/YKUalFJMH4sT+sxziKhiTJ8T5W/JaE=;
        b=VDZ5xNAQ6iPfx7FardM4RVN0Dy5YTmXvUqSLJ74pvHwdoFef5ZZHBbQ6ZNRVLyvvtv
         F6Tiso1eNgjOmWZPXNZ3koVTPg/2gc5+xVHamC+Zrqv1/22J49o/tP/zdtD4d/E8a1/0
         K0f0F4KoPhlz8sBBrOIrXCGXuPhwV8085c/Mm0L90QvrUJKLzwRvw9CqQzoiQXx5vKQI
         4Gto6eR942UhxCkan6H0eO9wMRYnlpyAle27I5lgpi6R7HMATZcI7+AN894uicfhQtUp
         UnUcc0FqO8IbofYplLOCqkpnqQQwAWBV56vxJQhoQLWDo6iTQ42V/F8aB+qi+IGIk99r
         5f2g==
X-Gm-Message-State: APjAAAXIzBW8NUIKC8X5BJe/tymNE8ftKX5azg0f2EucJd8LZvQ2dlF0
        f5g6uHBE9o0YNckDdp894ojrWqGqElw8Hj/vaM+PnysY
X-Google-Smtp-Source: APXvYqwG7JQE44XesDgYhEDkxVmmV4E3tjJox2xtwtFr2pHHKpZzKEhWzgavCvE4i803+T1DwzPlDRPtN+P13N54TbI=
X-Received: by 2002:a50:a6d9:: with SMTP id f25mr4712113edc.280.1578479343341;
 Wed, 08 Jan 2020 02:29:03 -0800 (PST)
MIME-Version: 1.0
References: <20200107013640.1821227-1-sandals@crustytoothpaste.net>
 <20200107110145.GA1073219@coredump.intra.peff.net> <20200108024732.GL6570@camp.crustytoothpaste.net>
 <CAN7CjDCv2uYNaHEtQv6Zco33-Cba1Fn2by87NU_3vwytZHy_WA@mail.gmail.com>
In-Reply-To: <CAN7CjDCv2uYNaHEtQv6Zco33-Cba1Fn2by87NU_3vwytZHy_WA@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 8 Jan 2020 11:28:51 +0100
Message-ID: <CAP8UFD246PpsysJd8s37g+BjSu4NNerW_ozEMtkP9iGCmUbupQ@mail.gmail.com>
Subject: Re: [PATCH] run-command: avoid undefined behavior in exists_in_PATH
To:     "Miriam R." <mirucam@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 8, 2020 at 10:16 AM Miriam R. <mirucam@gmail.com> wrote:
>
> El mi=C3=A9., 8 ene. 2020 a las 3:47, brian m. carlson
> (<sandals@crustytoothpaste.net>) escribi=C3=B3:

> > > I think Miriam actually posted the same patch in her initial email:
> > >
> > >   https://lore.kernel.org/git/CAN7CjDDBA0ZoCG9aaQf5rg3gxqny=3DEjR6v6j=
E1mnxvUJQSF_0Q@mail.gmail.com/
> > >
> > > I don't know how we want to handle authorship.
> >
> > I don't feel strongly about holding authorship; I'm happy to have her
> > name on it instead of mine since she did propose a solution.  I just
> > care that we fix it.

> my mentor (Christian Couder <chriscool@tuxfamily.org>) was who
> detected the problem and sent me the solution, I only asked the
> community. I think his name should be in the patch instead of mine.

I am ok with not having my name anywhere and leaving the patch as is.
