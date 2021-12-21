Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B5BAC433EF
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 09:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236196AbhLUJNF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 04:13:05 -0500
Received: from mail-io1-f52.google.com ([209.85.166.52]:45624 "EHLO
        mail-io1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236187AbhLUJNC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 04:13:02 -0500
Received: by mail-io1-f52.google.com with SMTP id q72so16756380iod.12
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 01:13:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kNyU7/I9Yk+tVkbvEMCQo9O2BF2BSHowyhHBCl8JHV8=;
        b=fvc3+ycQK04eKuND5IoKWlOopO8kFf9AfzZZhRsw/0btTId9pmkKRnmHs+EOAo96J5
         Er3GiMJ8YCxPrlVZLh8r8Z3Ltqfw7Ue/Tv4+xRzhbIhD2Y4sIkU15lMYWg12y40VeJ9b
         S1/7iNN32+kLuMl9Z1PcB8k9+06zFgfmGs6KXZomzBQ3mSuyZ4r9P1MG3xrU6OCCOhGN
         4znFwMztz0ybgbhlTvZY0ZrEUgdo579qfYPWk6klXM7ULJn/kCUxAC51hgJU727tPEb5
         XzwdkarQc1MmyPup2XQEZZ75HMYXljWJE7g4LidPWkwTmuYbjBsrq84Mnc/q/PFXngai
         Xdvw==
X-Gm-Message-State: AOAM5301cNa7kxWzAYVvxt507WrkQC6Uvjtg6lFjmnXgvK7+AQNjLYsj
        FdT+FsTiCFN6pvxGSHPMKrevBDvbyGJhFKQHobM=
X-Google-Smtp-Source: ABdhPJyc4KGhoTvukHi/+EqCWYaNKayiiho+tUY28A+VTNZvU0PDKxaIOiCntPwzbGC0yMmhgzJQZJ5DeT0fIiW08xw=
X-Received: by 2002:a05:6602:2acc:: with SMTP id m12mr1093131iov.107.1640077981355;
 Tue, 21 Dec 2021 01:13:01 -0800 (PST)
MIME-Version: 1.0
References: <CABceR4ZW4rRWZnH0ZBkWty_H84Z4CmXque_LO+1edETEWrO8PQ@mail.gmail.com>
 <211220.86k0fzwmq2.gmgdl@evledraar.gmail.com> <CA+JQ7M8oxzUAkw-Nv4X+3bJt7cBhsUaqFKd67Y=LNLnv2kgM+Q@mail.gmail.com>
 <YcEJtOknDjSgxK5j@camp.crustytoothpaste.net> <xmqqa6guub9n.fsf@gitster.g>
In-Reply-To: <xmqqa6guub9n.fsf@gitster.g>
From:   Erik Cervin Edin <erik@cervined.in>
Date:   Tue, 21 Dec 2021 10:12:25 +0100
Message-ID: <CA+JQ7M8ofJfnTGn+eFPhW4vL6xi0M7GU-=fvPG2knrvJppU9kQ@mail.gmail.com>
Subject: Re: Custom subcommand help handlers
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Sean Allred <allred.sean@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I should point out that in most cases on Unix, it _is_ expected that you
> install your manual pages into the same place as everyone else, so in
> this case, installing the HTML documentation alongside Git's may be the
> best solution.

I also think this sounds sensible
A hurdle is that while Unix man pages are well established
and I'm not aware of a standard or convention around HTML documentation.

On windows, you can install the HTML pages into
/mingw64/share/doc/git-doc/
the problem is "git for windows" default installs in program files
so admin rights are required.

You can supply a custom path for HTML pages
git -c help.htmlPath=`realpath.exe ~/doc/git/html/` help git-filter-repo
so an option is for user/admins to move/copy
all the help documentation to a different path.

An idea is that if HTML documentation is not found at help.htmlPath
to look for HTML documentation at the path of the command before failing
I don't know if that's a good idea but it sounds simple



On Tue, Dec 21, 2021 at 12:06 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>
> > I should point out that in most cases on Unix, it _is_ expected that you
> > install your manual pages into the same place as everyone else, so in
> > this case, installing the HTML documentation alongside Git's may be the
> > best solution.
>
> Yup, that sounds like the most sensible way to do things.
