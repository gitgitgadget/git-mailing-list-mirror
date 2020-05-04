Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D2FCC3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 21:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C6B5206A4
	for <git@archiver.kernel.org>; Mon,  4 May 2020 21:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="hu1Pek91"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbgEDV7x (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 17:59:53 -0400
Received: from forward501p.mail.yandex.net ([77.88.28.111]:56761 "EHLO
        forward501p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726453AbgEDV7x (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 May 2020 17:59:53 -0400
Received: from mxback6g.mail.yandex.net (mxback6g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:167])
        by forward501p.mail.yandex.net (Yandex) with ESMTP id C5E2B3500252;
        Tue,  5 May 2020 00:59:50 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback6g.mail.yandex.net (mxback/Yandex) with ESMTP id 7GMAzR2Vht-xnQGhcbJ;
        Tue, 05 May 2020 00:59:50 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1588629590;
        bh=sU6KEfhHUUuGBnOmiTB2+ytvL0SzTTTSkq7+6g+bxEI=;
        h=Message-Id:Cc:Subject:In-Reply-To:Date:References:To:From;
        b=hu1Pek91DSYmVOxRBWFokjQVzMf/ZG+aDo8zHt6FjpPGab5RXfSaId2zuc46RR2t8
         V7bBKjRiMIhqJnLSttlvy8KAh8kQQ0ou+wSqhOkfw1plbHmWJ/i6DONMs7jfhDV1PU
         6XO45pSTpN9jKYeAxJ/wYqabLKGQP979h5CJLaXU=
Authentication-Results: mxback6g.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by myt5-5e0e3f348369.qloud-c.yandex.net with HTTP;
        Tue, 05 May 2020 00:59:49 +0300
From:   Konstantin Tokarev <annulen@yandex.ru>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        Jeff King <peff@peff.net>, Danh Doan <congdanhqx@gmail.com>,
        Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
In-Reply-To: <nycvar.QRO.7.76.6.2005041630150.56@tvgsbejvaqbjf.bet>
References: <pull.614.git.1587700897.gitgitgadget@gmail.com>         <xmqqv9lod85m.fsf@gitster.c.googlers.com>         <CAKiG+9V_nZUXf2a689vZ54rG+xTCFMGcJe_7Av-khaxxuijERg@mail.gmail.com>         <xmqq8sikblv2.fsf@gitster.c.googlers.com>        
         <nycvar.QRO.7.76.6.2004251354390.18039@tvgsbejvaqbjf.bet>         <20200427200852.GC1728884@coredump.intra.peff.net>         <20200427201228.GD1728884@coredump.intra.peff.net>         <20200428135222.GB31366@danh.dev>         <20200428210750.GE4000@coredump.intra.peff.net>
                 <CAKiG+9U2Eg5yvT4XjgpMUXu4OV-8JF9Hp_ou_P6twxfqJ1tEYA@mail.gmail.com>         <nycvar.QRO.7.76.6.2005012130010.18039@tvgsbejvaqbjf.bet>         <CAKiG+9UvnLtF7eS9FsPLyRR4ZPNSnakZwyYy3dO7WoAnRpvoMA@mail.gmail.com>         <xmqq4ksyl4mz.fsf@gitster.c.googlers.com>
        <CAKiG+9Vvwz_ajhJ1KPVWtq25UaGtJOH57eXTA=cgm5qzoZCfGw@mail.gmail.com> <xmqqsgghhr32.fsf@gitster.c.googlers.com> <689741588534833@mail.yandex.ru> <nycvar.QRO.7.76.6.2005041630150.56@tvgsbejvaqbjf.bet>
Subject: Re: [PATCH 0/8] CMake build system for git
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Tue, 05 May 2020 00:59:49 +0300
Message-Id: <848941588629532@mail.yandex.ru>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



05.05.2020, 00:32, "Johannes Schindelin" <johannes.schindelin@gmx.de>:
> Hi Konst,
>
> On Sun, 3 May 2020, Konstantin Tokarev wrote:
>
>>  03.05.2020, 20:21, "Junio C Hamano" <gitster@pobox.com>:
>>  > Sibi Siddharthan <sibisiddharthan.github@gmail.com> writes:
>>  >
>>  >>>  As you say, an extra instruction in INSTALL file to tell users to
>>  >>>  copy from contrib/cmake may workable, though it is unsatisfactory.
>>  >>>  But the other one will not simply work. If we need to have a new
>>  >>>  file with string "CMake" in its name at the top-level *anyway*, we
>>  >>>  should have the real thing to reduce one step from those who want to
>>  >>>  use it. Those who do not want to see "CMake" at the toplevel are
>>  >>>  already harmed either way, if is a dummy or if it is the real thing.
>>  >>
>>  >>  In your opinion, what would be the best way to communicate with users, there is
>>  >>  an optional CMake build system for git?
>>  >
>>  > You do not want to hear my opinion, as my priorities would be
>>  > different from yours ;-)
>>  >
>>  > Given that we all agreed that the only reason we contemplate use of
>>  > CMake in our project is strictly to help Windows build, i.e. due to
>>  > the same reason why we have contrib/buildsystems/, it is not one of
>>  > my goals to communicate with general users about optional CMake
>>  > support in the first place. It has lower priority than keeping the
>>  > project tree and the project history less cluttered.
>>  >
>>  > So my first preference would be an instruction somewhere in install
>>  > or readme that tells those who want to build for windows to copy
>>  > from (or perhaps update cmake to offer the "-f" option and tell it
>>  > to read from) contrib/cmake/CMakeLists.txt to the toplevel before
>>  > doing anything [*1*].
>>
>>  FWIW, CMakeLists.txt doesn't have to be in the root of source tree in
>>  order to work. It can perfectly work from contrib/cmake after necessary
>>  changes in relative paths.
>
> Would you have an example handy, or a link to an article describing this?

It's so trivial that I'm not sure what such an article would have to describe.

https://github.com/annulen/cmake-example

-- 
Regards,
Konstantin

