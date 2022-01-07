Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A8BC433EF
	for <git@archiver.kernel.org>; Fri,  7 Jan 2022 12:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238235AbiAGM50 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 07:57:26 -0500
Received: from mout.web.de ([217.72.192.78]:53243 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231207AbiAGM5Z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jan 2022 07:57:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1641560238;
        bh=WL+oGI96HTS3LJJ+SaKlfmLmD18U2Y5CMFJqILOSzFQ=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=UPGqItAZGoKdy4Lgl0sNBHgKkXzFicPlFwmyhsxpw6Zw4Lp9vsl45FghEL4g8FueU
         GxI4jokXCq8CsmFcvLAOFCgkyWg4UkOR2YYgT9LULOFbfk9ItBsvOa85sjcSDaIFo1
         suo6NHDlrhqWUuqQ7YSOJWXLhVWhnYhmSW9wnL2s=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.22.121]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MSIEs-1muqSD3ri4-00Sxcw; Fri, 07
 Jan 2022 13:57:17 +0100
Message-ID: <c573cc00-d5b3-9af1-a627-6c2462cae3be@web.de>
Date:   Fri, 7 Jan 2022 13:57:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH 0/2] grep: introduce and use grep_and_expr()
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     gitster@pobox.com
References: <ea01f9b6-2ce3-57e8-533f-4cc29937f700@web.de>
 <cover.1641498525.git.me@ttaylorr.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <cover.1641498525.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UXN6g12sVRgM7bHx1oVQqbrF+uWljOpbF+C5EzPONIoHssfQkK8
 SoPW4qIhW4zb544+Y/UMCYxqOgx0Wk6iLbemtgpS16MG/zrlvSeNQ2XmxplJOhq14jEtfSH
 tUnKE9wHI87Qz7Nf3//jzEjUppok9P8bHiRiJwApLvYbXVflYiWFHPT5S+U4QgQ7sYbAN2g
 JPmos9ypiUEMui5vK5eYQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZGLLH1PYanc=:6Tnxe3FMS8DdKVkeGQ3wDj
 jKOJmn0A4tJqZKfBP+FEGxVxpMK/FWZ7rFDLB8zdlfn0q6yEwXg/KKVnwkgKXYJgBBHUWe9bd
 pHSvY3X6AYNxEYzvSEutNh9UdOoolBTIaxnuwpF7b7I4/I4CqYFo9vaf70ige7P5j7bI0hAUR
 KdSS3/505gp5xy7lMZHhsYULlrkoBt8R9LoZpO2QEpvM3c120+kYj5ri1GkRZ/0/Aiuq7HX0W
 RRkIYxCjAyVsC3v5uDimxRCSHJVzJtHbqf9nE1U+l6nU6LQoyPBZpVDLSYU0xoWSZE4ASPPwj
 7Zo6Hz/QaeSiFpTxtvedbE7dFcLkD005dusm1qsEwtYcJqu57SReXGlNqZz8I0h8hSGRwZDyh
 gZzTkwTGu99QHqAH4Ws2j5qb2g3jiQcnuSv+a9+nn8+/Rz3CkpwxPFr9Df5dGG864fXZRT8jF
 3VOVLA1+rQAwKA7quBhifA9aALRCebr6UgBX6eINoms0Ki7XZxNsfwABTeQowpdZpuYmpqM9b
 gojkvv2Cl+dodHHE9K/ISNgXFkToTQ9/FTawD6yj2oiTef+VcFHUgeRczcG02YsCOnx9sv5Gs
 pnRf6fIYUfjGBx8qhwo3RspY5aWji0Pkj2iT4GeYBK6TgtPZTVysVqq7brhTbASOGUwE40Fwx
 Mos6QFVyVkJ2rzVbJ2JWA4l+wi25jB62++r9ZwFVgz9mkGCExc/x3TkMmVSHI3Yv1mrpW7jC9
 KqXzi9dPShiXzEvuK/ZD5mpWVLrgMW5xDTPXGCFppGtnC8nZosoVhro3vuHEtPGArD6EMrjef
 nehy1AvM3h4c4K87VnY+ETFzjUeAxeB8Tw37CH0hdRyA3Bpwdt9W9CT6R/7e4i4SgvSlg4toS
 u0mlNZgFGez5Vu0hnyyTZybq9K2pBQb0xeFRl2VmmiKuGLHpD9Ll5lM8G6a14A9B6dBUtCiko
 nE5ZpjCG0lL9Dhhi4CR9yjhcwEnMKTbW8Zg+P1l5JVsWfkeIZlYWKfBsEFHW19QQYHCWeCuWJ
 PjTbA42cUl/sPUN/EwH78Ni3oOBozutqlM4cpi9+kPaVBX7wdEWHoZg7dvNshWdxEA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 06.01.22 um 20:50 schrieb Taylor Blau:
> Ren=C3=A9,
>
> Here are a couple of extra patches on top of your series which introduce
> and use a new grep_and_expr() function.
>
> Like the final patch says, this isn't about reducing code duplication,
> but rather about adding visual consistency with the other
> `compile_pattern_xyz()` functions.
>
> Taylor Blau (2):
>   grep: extract grep_binexp() from grep_or_expr()

I considered extracting such a function as well.  I'd have called it
grep_binary_expr(), though, to match the existing names.

I decided against it because it can be misused by passing a non-binary
kind to it.  (That's a weak objection, but the benefit of such a
function was low already in my mind because it doesn't do much.)  You
solve this by keeping grep_or_expr() and adding grep_and_expr(), which
cannot be misused in this way -- OK.

>   grep: use grep_and_expr() in compile_pattern_and()

I think reversing the order of changes would make more sense.  You
wouldn't have to talk about the respective other patch in the commit
messages -- each would stand on their own.  Not worth a reroll, though.

>
>  grep.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
>
> --
> 2.34.1.455.gd6eb6fd089

