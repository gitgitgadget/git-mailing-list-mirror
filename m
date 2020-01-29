Return-Path: <SRS0=89pV=3S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84284C2D0DB
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 22:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48A8220702
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 22:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WNW+KHeY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgA2WK7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jan 2020 17:10:59 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39999 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgA2WK7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jan 2020 17:10:59 -0500
Received: by mail-oi1-f196.google.com with SMTP id a142so1406185oii.7
        for <git@vger.kernel.org>; Wed, 29 Jan 2020 14:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TqtATff/7ItgyAPc+ks8t9B9HaiP1H7dp0sP65ONiaU=;
        b=WNW+KHeYh4RjhxYH17+Af5gt2kT8Coa//uBzBQ3YIiS6uEHqfa06FGVop+FLvcwZy1
         LMVMrfIKrLanDcCHQNF5gWgqLEeRejepuxJZYU5chqNLpEct+Y7BwgyKNTB9saecdzHZ
         Hd6Ln47ecDhfoJ59fXdhOrQhhFw5zkf/NWvo3bT4VbtHs16z5k5zvafznBkhdjtErsZD
         0UJx3YDlg55jOtOrTsRUmRjD6/yftduFb+5rPkxEJqBmY1PH+xq3orTsVcMxDVNz1lCT
         4oUcyMVKOjQAnnOdNcv5D4Bit3nBYh7PGvpfmmKw+IAVrb01gzZec/MEc0jqq4C4FJn8
         8x6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TqtATff/7ItgyAPc+ks8t9B9HaiP1H7dp0sP65ONiaU=;
        b=ieRAEB5Br6kbtIZ65F1Rb5PY9zUSMjEgX9QW+UWHklhmtIJJ0Ei10ZstRqlJ3H+Qy0
         gwwLFrEGTogl1IysiEvCOjd/gSZnBqcuUp1v6eMXb/zMpEeo/QXyhg/OIbMD1GwoRzLd
         n4EcJpdCPAyN76r7lHMZ53smdhE3g9ElqliRO3PDC4IVbaHo6NKYXvaykjnyLEmux/5c
         3OCrfjJd/2sYflUlnu/jIM6ZH2o3y7GBJhECFekptATDQvrB6GcjIdBmSGO8p54LZQHN
         dmq1ELewAsg1eU18ADiAYEKG7bd6KVTko4Gpubx7FPVON/CQS+czSZTbESBdI+6GJ94b
         ze2A==
X-Gm-Message-State: APjAAAVz0xriNeHUMkkEWyfIAr13s7xsWxR9HX9D01Ec757CWyTdd7B6
        bp864KAaDhkG2rXKC9uhk5VNDLMGzQwKP86xbew=
X-Google-Smtp-Source: APXvYqwE8z1lxA3q5fpWAVw5Dr5AGLefCrwr85hL6Lv10dOoHfEo9zZdHts3lPqqW5vjuDq+g1zsfsXsslU/Dk+9TCQ=
X-Received: by 2002:aca:4e10:: with SMTP id c16mr745739oib.6.1580335858043;
 Wed, 29 Jan 2020 14:10:58 -0800 (PST)
MIME-Version: 1.0
References: <CANt4O2L_DZnMqVxZzTBMvr=BTWqB6L0uyORkoN_yMHLmUX7yHw@mail.gmail.com>
 <20200127120837.GA10482@szeder.dev> <CABPp-BGvU_DHQu66bqPZ+WXg5mL8bCP5Uxp4g5393WnWyO1Dhg@mail.gmail.com>
In-Reply-To: <CABPp-BGvU_DHQu66bqPZ+WXg5mL8bCP5Uxp4g5393WnWyO1Dhg@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 29 Jan 2020 14:10:47 -0800
Message-ID: <CABPp-BGgKZ7+jHEJQzzODSUxYefpvJ86SmV_orA4erVaQscwBw@mail.gmail.com>
Subject: Re: git status --ignored hangs when a deep directory structure
 present in working tree
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Martin Melka <martin.melka@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Samuel Lijin <sxlijin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 27, 2020 at 9:06 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Mon, Jan 27, 2020 at 4:08 AM SZEDER G=C3=A1bor <szeder.dev@gmail.com> =
wrote:
> >
> > On Mon, Jan 27, 2020 at 11:55:01AM +0100, Martin Melka wrote:
> > > Hi all, I have ran across what might be a bug in git. When there is a
> > > deep directory structure (tried on 100+ nested dirs), then git status
> > > --ignored hangs indefinitely.
> > > Discovered this on OSX (Mojave, git 2.20.1 (Apple Git-117)), but it
> > > reproduces in Ubuntu (19.04, git 2.25.0) Docker container on OSX and
> > > also on baremetal Ubuntu server (16.04, git 2.17.1).
> > >
> > > Steps to reproduce:
> > >
> > > 1. Generate the deep dir structure:
> > >
> > >     mkdir gittest; pushd gittest; git init; for i in $(seq 1 120); do
> > > mkdir dir; cd dir; done; touch leaf; popd
> > >
> > > 2. Try to get git status --ignored
> > >
> > >     cd gittest && git status --ignored
> > >
> > >
> > > If there is a dir depth limit, git should probably exit with an error
> > > rather than getting stuck endlessly.
> >
> > This is interesting, thanks for the report.
>
> Agreed.
>
> > There is no such directory depth limit, but the runtime of 'git status
> > --ignored' grows quickly with the depth of the untracked directory.
> > Running this shell loop produces the numbers below:
> >
> > for depth in $(seq 10 30)
> > do
> >         dirs=3D$(for i in $(seq 1 $depth) ; do printf 'dir/' ; done)
> >         rm -rf dir
> >         mkdir -p $dirs
> >         >$dirs/untracked-file
> >         /usr/bin/time --format=3D"$depth: %e" git status --ignored >/de=
v/null
> > done
> >
> > 10: 0.01
> > 11: 0.03
> > 12: 0.05
> > 13: 0.11
> > 14: 0.23
> > 15: 0.47
> > 16: 0.97
> > 17: 1.97
> > 18: 3.88
> > 19: 7.85
> > 20: 16.29
> > 21: 32.92
> > 22: 76.24
>
> Wow.
>
> Really nice testcase, though, thanks.
>
[...]
> We'll see
> if my patch goes anywhere, or if it's just another dead-end among
> many.

Since gitgitgadget doesn't have an in-reply-to capability, for those
wanting to follow along see
https://lore.kernel.org/git/pull.700.git.git.1580335424.gitgitgadget@gmail.=
com/
