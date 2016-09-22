Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C49E01F4F8
	for <e@80x24.org>; Thu, 22 Sep 2016 18:38:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034403AbcIVSim (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Sep 2016 14:38:42 -0400
Received: from mout.gmx.net ([212.227.15.18]:64224 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965609AbcIVSiO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2016 14:38:14 -0400
Received: from virtualbox ([108.198.118.51]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0M2cYX-1aviqk2mCj-00sLxW; Thu, 22 Sep 2016 20:38:04
 +0200
Date:   Thu, 22 Sep 2016 20:38:00 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Benjamin Kramer <benny.kra@googlemail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH v4 2/3] regex: add regexec_buf() that can work on a non
 NUL-terminated string
In-Reply-To: <xmqqtwd96p0b.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1609222032330.129229@virtualbox>
References: <cover.1473321437.git.johannes.schindelin@gmx.de>        <cover.1474482164.git.johannes.schindelin@gmx.de>        <270cea11c4d8bfb332a6c014a11673b7f4666ee4.1474482164.git.johannes.schindelin@gmx.de>
 <xmqqtwd96p0b.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:TmD9Vwyje8whQbhl9742Pq/vzEDuThRSpAZ4igm3SwFKaBGYMpi
 CQ2KGmQfd9C1K+I6T+W5VOj88b5dYSFCVLQJq29G6P9o6Hkq/JLHwesj30IcM/x+KhJWfHi
 Sgu0jDck3KPEov+N/nOg35C84RamnGJqsU/06to49Wke5JxWQZUwJ5WBDWo6snHGTZkkveR
 RKCDp/6hYzU13lkADKvaQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:F6VxQtO/TmY=:NwtKgv7s/VvYVOyF0VzbgW
 QS8pM/dDpfUQV9l82Yh5OLkLxvub9vxe10CW9GrsLl8wJWApTgiSVfrD3WB5poCfPK86pSEne
 MCg9qBbgYmQTZjgmmaH5E8QmmFgZXOAXgMb8jzy6uunAI7j/UBSlsjnG0zuoot26GzBSsxojP
 vTFOvyg0/RrqWkGyw9q4cqv9B9Cz5XZ5ZCRtu2JO3rNyc38ucc8Q3m/o2nTkrGHzIhWs/koi7
 gbXIM5LqFfJpxI/7680FVREiBiNwXd1eg1FVqgHnhLiuayXXrNaiX9DK0qaSyB8RTFtTU7seQ
 q0W05rG6rU0D0iMx4/IiSFctsTAJc/0fsHvKAsLb3f7Ml+jkXWOis8fSrRQDEWU4YLxYp8Iag
 6YzwhunnaJKPMykbea3giWM8xfCkdp69SVcgH3Cy6811BaTlnuwfME309sP2gCIoptHUjAKg+
 OmhciDj3pzgibl9R+tZUYdocdVAvYoODwWbyuwoEeDraz/wtFjTTsTtHqx+ygZiT/Oful9ghe
 LsdynYR340EV9M9hTKB7nGaCwnxvdSzvzimgaHC2F1TzTBBiImqTG4Vkl3C3UNwnqjkCNnb9O
 wU4/w0LMvLejCkUSVcNhOIWd+5Os///1oSypP0RM3Dj4Z0goMUiqKZ+AooYEO5OfokFnwJ1Fd
 MILj2bt3Jy+bEgnClliTQJ6zwwk4yHdcGAC8tP6ZmAPE9NAH4tS63OQ6LxddPwqqJftzLWXlS
 U8q1T5mzThWHpHrKTGJ3arQKyY1ThTrv77eifB+hQquGXmsN5/VDs9H5axdpDDQLceO7ZAM9K
 TK4S6V6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 21 Sep 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > ...
> > Happily, there is an extension to regexec() introduced by the NetBSD
> > project and present in all major regex implementation including
> > Linux', MacOSX' and the one Git includes in compat/regex/: by using
> > the (non-POSIX) REG_STARTEND flag, it is possible to tell the
> > regexec() function that it should only look at the offsets between
> > pmatch[0].rm_so and pmatch[0].rm_eo.
> >
> > That is exactly what we need.
> 
> Wonderful.
> 
> > Since support for REG_STARTEND is so widespread by now, let's just
> > introduce a helper function that uses it, and fall back to allocating
> > and constructing a NUL-terminated when REG_STARTEND is not available.
> 
> I'd somehow reword the last paragraph here, though ;-)

Oh drats. I thought I had prepared the fixed commit messages already :-(

What you have in `pu` as of today looks good.

Ciao,
Dscho
