Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0422FC3DA78
	for <git@archiver.kernel.org>; Sat, 14 Jan 2023 06:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjANGo0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Jan 2023 01:44:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjANGoX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jan 2023 01:44:23 -0500
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B6846AC
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 22:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1673678647; bh=WtsDtnUO7E0ne2rYMta1WJXX5IvxOfHv/zeM44TKct0=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=CwMtc00QX7edGGi3j2vUGRHCaDE0L3uShE1J4KhgapJ0Ht1fjbLdHTNDohItp2dNG
         uxH8y4uELl6hanbL7+11ujLRwO1KT+gpiNsxNv4TVE5fPu7qUSlwzLl4JUbPPbX9fI
         VbresRFaaFewlGIrWSb38yBzPnKOQaxkgZn0zqXtMRS6XxdNDNnfCHKeZlBCfcjmnU
         C2j3jloM/sJXJFN583zs4lw0+B6j/WByrR0hlhV9uO+Kl4eJrfOyzPCRXPFoymnN4v
         jocqDwDlIda4fANFyPaCYPfilNHSFSSJ91FNxi3jeXpFly2HKmHyQSvQHcR3TxQy1y
         sXyAlJkPDPGWQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.21.69]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MlL9z-1otv1n3fCv-00limW; Sat, 14
 Jan 2023 07:44:06 +0100
Message-ID: <0e25e6b0-2eb8-40ee-7999-f2863a545a15@web.de>
Date:   Sat, 14 Jan 2023 07:44:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: BUG: git grep behave oddly with alternatives
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Marco Nenciarini <marco.nenciarini@enterprisedb.com>,
        git@vger.kernel.org
References: <f82ae28a-fb56-8d1f-96c8-550b61439d3a@enterprisedb.com>
 <634f47a8-b370-81cb-00e7-d93ffc7534a8@web.de>
 <1f61b660-b2d0-ba93-3182-05a9ab97b00e@enterprisedb.com>
 <343a891e-d737-0ace-26a9-3839d3bd5583@web.de>
 <Y7Uu35HwUx2EVfAg@coredump.intra.peff.net>
 <e5165840-331c-e9b6-b45f-62abab860d79@web.de>
 <Y7flVcALZQgz0VPl@coredump.intra.peff.net>
 <26a0d4ca-3d97-ace4-1a1f-92b1ee6715a6@web.de>
 <Y78GXZvyrOrXhe7n@coredump.intra.peff.net>
 <4165031d-e7f1-0477-2245-6a8e312de522@web.de>
 <Y8CBrtmL45tA/N8z@coredump.intra.peff.net>
 <230113.86ilhazved.gmgdl@evledraar.gmail.com> <xmqq5yda5p4l.fsf@gitster.g>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqq5yda5p4l.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EjChn8FEbUMmWOQa7pfhslD0do9cmvNt6awaWsFUENG6fQShe9i
 afVvFnsRPjs00Sb60Hgj8DNfm1mNcz2YUdhV7Ns+X6t7wXcc3UhY3R1ZA8fdzgSnmdsyFPu
 AtLsvQkPj1TJGBBHCuPXfaXUBel0Dixr7J9V3R3VTAEpkoUMsxbbL3n7mPQwoXTToBEkeV/
 R5YFHoJ7cr45DjDeH4tRA==
UI-OutboundReport: notjunk:1;M01:P0:YFMgrdOsLKs=;Yu/jcRdvCgi92O6hbWR2L+TwJLX
 OqBpZRD/kqZ9rwxZALiszOi3MMgst3TngD578wZVXE2cbOyM0rV+XIrJ/vh9y0W7vEy5HxAWs
 fXLRm0oF3OfiQj0O7ofIZEIp+rf5rHXviexBzHegUxz8zvxUw6rm+I6YBqpAD01WtOfSWMnFz
 JdycbfEmihV9TXuCodviJVdO9AGfx2gqOPCDDBEKeN6eX46ZMDrowKYJitI+e4O0O9xIP6ZTi
 bRc5aDgqxdfVnd1xwdsSugP+TgBkwgOrLoKDuIauYEB7zfzii2rxSq/qh8IzzcfGf3bDt0Mb1
 b9+xXv0V4h9hZm4U0z9dEqwmQj5WYmMUWyVMcx+Q1IzYtpiGVleQ4KGLOvA8VB6x/HVYi0GJw
 X6tVWkICAUYSgF4MyWPsIhzZpGij3VfJKyIaYRKjZQkdEH1SmP3g+YYhlhqLeFKvTFWAoP90v
 pzTlJZXQNxabvqitRMNMFZnY7L+B5y67BMBf7qTiCBxRSUGDevdw+tBDX1j+4H+AoAqUTNBen
 P8PLeUds0cwGgWLuudvzhoFacd4KWnlqj0gLMKK5SE/tLD7GkHUM/CeWDbSmlylU7KUwwxIpu
 KZ+ZpxMbPqVo5WYb1BIDpkbRH9ORd2VL4XFCtK+iJ83brdwm2tZBPE7bUIpgON+964xIK288E
 lJtLhhZhP6LWRpXDTx/0fVyU9vtCwf9DG9Ak7fZnBw6J1ErG3xs1SG9gB3/kMHwdYWyhyLmxT
 U1AbuIFQvrqes7bKbj0E9nwgKaLclN+yGZJtjWqT5oxOinHcfwz9K0aK1ssadKH0Fksrsb9+m
 NdKB/ei/G9CwL6URdDAbAdLOBzOE/fNyVR5cq+OiPsl9oILaVzxjKACJCottAKLT+MZDsRHGk
 dG703m7tuvKwd5x6Sjq+ifiC87+bbHEuP+VQ10xr0ollgbhkkpB3OxKuiseY5dcQR+83lXnth
 UsD0RYaHhHB1qRaNEGoSUVwabxE=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 13.01.23 um 18:19 schrieb Junio C Hamano:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> On Thu, Jan 12 2023, Jeff King wrote:
>>
>>> So it does seem like all bets are off for what people can and should
>>> expect here. Which isn't to say we should make things worse. I mostly
>>> wondered if REG_ENHANCED might take us closer to what glibc was doing =
by
>>> default, but it doesn't seem like it.
>
> I thought that Ren=C3=A9's "Use enhanced only when doing BRE" was fairly
> focused, but I am very tempted to accept ...
>
>> There's a couple of ways out of this that I don't see in this thread:
>>
>> - Declare it not a problem: We have -G, -E and -P to map to BRE, ERE an=
d
>>   PCRE. One view is to say the first two must match POSIX, another is
>>   tha whatever the platform thinks they should do is how they should
>>   act.
>
> ... this view.  The story "BRE and ERE work via what system
> libraries provide, and 'git grep' matches what system grep' does" is
> an easy to understand view.

That was my stance in my first reply as well.  But 3632cfc248 (Use
compatibility regex library for OSX/Darwin, 2008-09-07) explicitly
added alternation support for BREs on macOS, and 1819ad327b (grep: fix
multibyte regex handling under macOS, 2022-08-26) removed it seemingly
by accident.  And grep(1) does support them on macOS 13.1:

   $ uname -rs
   Darwin 22.2.0
   $ which grep
   /usr/bin/grep
   $ grep --version
   grep (BSD grep, GNU compatible) 2.6.0-FreeBSD
   $ grep '\(REG_STARTEND\|NeededForASAN\)' Makefile
   # Define NO_REGEX if your C library lacks regex support with REG_STARTE=
ND
   NO_REGEX =3D NeededForASAN

Ren=C3=A9

