Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96FC6C47247
	for <git@archiver.kernel.org>; Tue,  5 May 2020 04:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B05520721
	for <git@archiver.kernel.org>; Tue,  5 May 2020 04:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCOLQvSN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgEEEQW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 00:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725294AbgEEEQW (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 5 May 2020 00:16:22 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204C5C061A0F
        for <git@vger.kernel.org>; Mon,  4 May 2020 21:16:22 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id w29so963428qtv.3
        for <git@vger.kernel.org>; Mon, 04 May 2020 21:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rdEUdMBKYsAPVFreAXkni0jW6xNOCn2IsIX9/GX2BsM=;
        b=eCOLQvSNQON0EoZ1ryy/67QST8Tb0ug/9SW1BLuMyFZsQkv00VGjf7xhjAw7idghEw
         GCfIlWk8BkFOYOO6x8ZUx5kSK4/ETTonPS4INNTEh1JAFpYhv0qsZGExKO0vaBTDqX9s
         JwHjvay8aHCq9kXcg8rOyjbIUYKaUXaCg4C2LIsFlEU+7ggd7dGjv9MS8IShSBwrY5oH
         8Fru6vGC7SUIogrJbm8cqDfudV5VBDwNcdECRNzUbwiPLQs3N5TIWbwahueJodzceXnz
         XphEVL9bAWnsdptUgKe9QGBUv3vqGm1YB0WSMvxS8w7ne4so+QFlCQaTlwcqSs8Srvkx
         0w6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rdEUdMBKYsAPVFreAXkni0jW6xNOCn2IsIX9/GX2BsM=;
        b=HU4QXraqq8Uirw6I/W2H0OVvU6GCjNx2J45IAO7dxEVUocxl8kMy5WI62uCBhCapT4
         FYwUmOzmg4ul1DWfvq/EaIoV9gIE/d/guTffVAp9ibjGC0uPYPjryUJPn2LxITqw2rll
         hI5HCVVadItljO76b7zt/Ou5qVxGgX998M1ds1tQ7bq7LTgoxOvWU+7fbVWIjP1zh9Jj
         TsF0YgTuLFY+jf6mjyLY7BNDRnNpmn/i6ND9piSDw1V2dTzQ125nFctGyHE3kfYvkyly
         C+YcXKGsqxWQ1KrrZ3Shx+VbXIGzcmxOh34lAN9fRPwDxzzxCiAmRr4VHczW4Xd/iF7D
         caTg==
X-Gm-Message-State: AGi0PuaYTdNBjmcG1QdWsKsnZS30nwFg9VWUxUPAdtAF5XxDXExyQqsY
        TkpwZQUuL+9deJZ8r6kkfjjLWSrhC+Wh/Bhwj1I=
X-Google-Smtp-Source: APiQypKhmNP2Lxos0b6N04g1iMVszs4+InvSe6oJnbozcbk6NdGAiKyTsC2AD3vW2TdMklUgHLQ20skmw1UEKJUE944=
X-Received: by 2002:aed:370a:: with SMTP id i10mr789255qtb.64.1588652181239;
 Mon, 04 May 2020 21:16:21 -0700 (PDT)
MIME-Version: 1.0
References: <pull.614.git.1587700897.gitgitgadget@gmail.com>
 <xmqqv9lod85m.fsf@gitster.c.googlers.com> <CAKiG+9V_nZUXf2a689vZ54rG+xTCFMGcJe_7Av-khaxxuijERg@mail.gmail.com>
 <xmqq8sikblv2.fsf@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2004251354390.18039@tvgsbejvaqbjf.bet>
 <20200427200852.GC1728884@coredump.intra.peff.net> <20200427201228.GD1728884@coredump.intra.peff.net>
 <20200428135222.GB31366@danh.dev> <20200428210750.GE4000@coredump.intra.peff.net>
 <CAKiG+9U2Eg5yvT4XjgpMUXu4OV-8JF9Hp_ou_P6twxfqJ1tEYA@mail.gmail.com>
 <nycvar.QRO.7.76.6.2005012130010.18039@tvgsbejvaqbjf.bet> <CAKiG+9UvnLtF7eS9FsPLyRR4ZPNSnakZwyYy3dO7WoAnRpvoMA@mail.gmail.com>
 <xmqq4ksyl4mz.fsf@gitster.c.googlers.com> <CAKiG+9Vvwz_ajhJ1KPVWtq25UaGtJOH57eXTA=cgm5qzoZCfGw@mail.gmail.com>
 <xmqqsgghhr32.fsf@gitster.c.googlers.com> <689741588534833@mail.yandex.ru>
 <nycvar.QRO.7.76.6.2005041630150.56@tvgsbejvaqbjf.bet> <848941588629532@mail.yandex.ru>
In-Reply-To: <848941588629532@mail.yandex.ru>
From:   Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Date:   Tue, 5 May 2020 09:46:09 +0530
Message-ID: <CAKiG+9Xu+eeET1Y3hFJTSpofxBCWEvwjyaY0cjFbKptzYLACNw@mail.gmail.com>
Subject: Re: [PATCH 0/8] CMake build system for git
To:     Konstantin Tokarev <annulen@yandex.ru>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Danh Doan <congdanhqx@gmail.com>,
        Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 5, 2020 at 3:29 AM Konstantin Tokarev <annulen@yandex.ru> wrote:
>
>
>
> 05.05.2020, 00:32, "Johannes Schindelin" <johannes.schindelin@gmx.de>:
> > Hi Konst,
> >
> > On Sun, 3 May 2020, Konstantin Tokarev wrote:
> >
> >>  03.05.2020, 20:21, "Junio C Hamano" <gitster@pobox.com>:
> >>  > Sibi Siddharthan <sibisiddharthan.github@gmail.com> writes:
> >>  >
> >>  >>>  As you say, an extra instruction in INSTALL file to tell users to
> >>  >>>  copy from contrib/cmake may workable, though it is unsatisfactory.
> >>  >>>  But the other one will not simply work. If we need to have a new
> >>  >>>  file with string "CMake" in its name at the top-level *anyway*, we
> >>  >>>  should have the real thing to reduce one step from those who want to
> >>  >>>  use it. Those who do not want to see "CMake" at the toplevel are
> >>  >>>  already harmed either way, if is a dummy or if it is the real thing.
> >>  >>
> >>  >>  In your opinion, what would be the best way to communicate with users, there is
> >>  >>  an optional CMake build system for git?
> >>  >
> >>  > You do not want to hear my opinion, as my priorities would be
> >>  > different from yours ;-)
> >>  >
> >>  > Given that we all agreed that the only reason we contemplate use of
> >>  > CMake in our project is strictly to help Windows build, i.e. due to
> >>  > the same reason why we have contrib/buildsystems/, it is not one of
> >>  > my goals to communicate with general users about optional CMake
> >>  > support in the first place. It has lower priority than keeping the
> >>  > project tree and the project history less cluttered.
> >>  >
> >>  > So my first preference would be an instruction somewhere in install
> >>  > or readme that tells those who want to build for windows to copy
> >>  > from (or perhaps update cmake to offer the "-f" option and tell it
> >>  > to read from) contrib/cmake/CMakeLists.txt to the toplevel before
> >>  > doing anything [*1*].
> >>
> >>  FWIW, CMakeLists.txt doesn't have to be in the root of source tree in
> >>  order to work. It can perfectly work from contrib/cmake after necessary
> >>  changes in relative paths.
> >
> > Would you have an example handy, or a link to an article describing this?
>
> It's so trivial that I'm not sure what such an article would have to describe.
>
> https://github.com/annulen/cmake-example
>

Yes, this is trivial, but doing so is bad practice in general and
difficult to maintain.
Won't it be better just to copy the CMakeLists.txt to the root
directory for configuring.

Thank You,
Sibi Siddharthan

> --
> Regards,
> Konstantin
>
