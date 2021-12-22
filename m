Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22EEAC433EF
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 20:51:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236299AbhLVUvI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 15:51:08 -0500
Received: from mout.gmx.net ([212.227.17.22]:40899 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229548AbhLVUvI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 15:51:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1640206253;
        bh=RDxL53J3yfRFtyyqOX4Qnvvva+fjr6sL0C9vYuY01mM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=QSy2QYP8TYmZvmww7SkNobr6NlP0Ac4Ui/6dD3rbzppARyOrXqSOCR1wDMEmHnVfr
         83ySG/1Nl4obvTSlo0dfQAliX0xAAo+dBMeOZrl7ayY4yjcuOCqFJUkcTkZqlZrKhg
         bv8jA5uoHTNTm/RKelqRL7RWJWhzFyoP1D34ReTQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.29.215.148] ([89.1.215.174]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mw9UK-1mAMpd06dw-00sAEA; Wed, 22
 Dec 2021 21:50:53 +0100
Date:   Wed, 22 Dec 2021 21:50:50 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Philip Oakley <philipoakley@iee.email>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Erik Faye-Lund <kusmabite@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC PATCH 00/10] range-diff: fix segfault due to integer
 overflow
In-Reply-To: <211222.86r1a5plsm.gmgdl@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2112222143080.347@tvgsbejvaqbjf.bet>
References: <RFC-cover-00.10-00000000000-20211209T191653Z-avarab@gmail.com> <nycvar.QRO.7.76.6.2112101528200.90@tvgsbejvaqbjf.bet> <59ec39af-fdb1-a86a-d2be-37e5954e245f@iee.email> <211222.86r1a5plsm.gmgdl@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-507754297-1640206253=:347"
X-Provags-ID: V03:K1:3JbcyJOJyTY5qFT8DzUD3he0rCkSKgxrpsol2Dwm5P7Rr01wRJ4
 gjI30E/pf+SrtLlL1XVqEYQzeMENVXtZrDsTB2g4aqf8cQ0Mq0w9GH4PdRH8p2CK1VfRFFV
 YxHeGLBXmBtJBwscRSHRoEHe0fCLMWJ6LXpARomj8JigQPDXFCWEb+3rHtkHREXWIpd9qrs
 EnSXvU8L3Y3Kjy9E4e/Ng==
X-UI-Out-Filterresults: notjunk:1;V03:K0:h6v5ZUQoQ2c=:puHefFRRVxUZqv6UihJZ21
 UdcGg+dBKwV8B+1SfQtdzqvlAA3sVPXuB/Ju/LeymIbQZZAGhI0RW7sGx0IKwMgb8kbNNQvX8
 hJ7cgN5AIa75SJUDYVQcjdal66R1ql0qdqYiJ0WecZt2QtiUKKduvN6cYpIky0V5+mctQ8Ezk
 ajvxrRUPpCeMqII2oCpBL3WXcOWfq+6t+EtoUf6Q3twkNv0W4Xnrjt4RemP6tRLnajkgKMZej
 iLuJlpu9acypOceGo1G2DJb/3r8onZgT2GNxqSZT5OmccNs27wtnm8a9rlEDN9AYT6VDHSHIp
 mFZniogVkU2XKgtA6ClwH7Rs+5/bc6ZxuXl95kEC4V3thLHRsQqRR4DeAsVDk1SYK7bl4nEwK
 UaGjjED9ab2F81sv8kV9CEQmXUfBorsMAZn6PezLJSxEj4LQd/XNQZYwfjrqJS0vc2OF5IGoS
 gBAFeZKKVUBGWRNtJa3cMarakwkZP1h3rxQH7agxNoJu3TT2Sgfvq5buk1JQo5eDwxnPAkCuk
 ONGpg3Hicfm7tJrW3m8kf7uoFkkVwoB41zy5PERzSG5JOjwnLE0EGkW7Fmcue180+am7lyrhh
 WOHIxZRRwYoBeGUpRz39kXsIlYDrQrK0g46/5AVkw2YSML9eOhwU0NjeLzGQtP5Rw2WtvDITm
 Jkm0CV+946M+/hv4TwczILYnmLYiBTn4qNNMp6iq5wRhBXh1PXIS2v2TRbbMpGXeK+iq6lBur
 jkyEspLVriHR2rm78ROeyz8TKUB69BC6zRd6SCKaI+5AIN3hkdG4jNzRLaYAVfKIRtOrgQTXw
 qkyeBztLZLwBLdwPI/AafEGrgbM/NP6ILLdzMMM4ewSONvmD3UooNZJu3SmO3YuwdCKMFxPbX
 tpQrYpZC5xKym92BhkhoVFUsCFbk2GAoyvm9kyZAquke7dJVbr5uJlpSp5xU3rRl04fVZrQeD
 CVGk06PYIBsMrZgBdRRwY86LUBesR+Gn/zycOFEOJEZtz2cUpYYVOeSYRCcnRO3ctC+AkGF4Q
 DunKOdqJMynodoOWHKymj8kPoTRTihI30AqYbAFe/wZ8siS4EEVJYDht+Dkq6KkpgmeiijMOS
 ueMy6gOzfD1Mc0=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-507754297-1640206253=:347
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Wed, 22 Dec 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Tue, Dec 21 2021, Philip Oakley wrote:
>
> > I fully agree that the range-diff should probably have a patch limit a=
t
> > some sensible value.
>
> Why would it? If I'm willing to spend the CPU to produce a range-diff of
> an absurdly large range and I've got the memory why shouldn't we support
> it?
>
> We don't in cases like xdiff where it's not trivial to just raise the
> limits, but here it seems relatively easy.

To raise the limits you would have to understand the purpose of the
calculations so that you can understand the range their data type needs to
handle. The weights of the Hungarian Algorithm are distinctly _not_
pointers, therefore using `size_t` is most likely the wrong thing to do.

Of course you can glance over the details and try to avoid digging into
the algorithm to understand what it does before changing the data types
and introducing `st_mult()`-like functions and macros, but that only makes
it "relatively easy", at the price of "maybe incorrect". That would be in
line with what I unfortunately have had to come to expect of your patches.

The _actual_ "relatively easy" way is to imitate the limits we use in
xdiff (for similar reasons). As I said before.

Ciao,
Johannes

--8323328-507754297-1640206253=:347--
