Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8082FC636CC
	for <git@archiver.kernel.org>; Sat, 11 Feb 2023 14:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjBKOMA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Feb 2023 09:12:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjBKOL6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Feb 2023 09:11:58 -0500
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E1E196AC
        for <git@vger.kernel.org>; Sat, 11 Feb 2023 06:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1676124709; bh=7arafviy4Pkz8Mrf8+2ssokiQgAoegH4eP3sD/y2XUU=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=bZP4tTPAlQnwIVucO8IgLZs5VngcbilJKmDuYSFBx1yyM+kvuq27QTcQVfirrSPDi
         zYNhNVv5I35VBCNZwkzjaQ5fynTCqoqsTIR+nHTu56gBF67w8fm2wTHEi4az5+ljtw
         7I4AkdIq+LExw0E9iebJsesTjenBvUMpYyG9q4/XqMe8f26kbtGTL04gDLp430EAth
         svlDGKQO+Pdg60RkR1M+uzg7kq/VPS/C26UkuTx261alVqaRugKttrSOdRXfAV7SVW
         C+MNQVydx8jiyWOl0LlzBN8hk8BgxDvmMyCErKtBU8YsHw+Zf2THffrkLvZAVFZ2n4
         AI3ZZ8itMcOXA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.21.51]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N5UkQ-1oXDqR3Xpq-0170ds; Sat, 11
 Feb 2023 15:11:49 +0100
Message-ID: <ef13e409-aa57-f1c8-d3bf-0b2f1f0ecdc0@web.de>
Date:   Sat, 11 Feb 2023 15:11:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH 1/5] git-compat-util: add isblank() and isgraph()
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
References: <20230210075939.44949-1-masahiroy@kernel.org>
 <20230210075939.44949-2-masahiroy@kernel.org>
 <654092a2-6d3e-7ab4-a747-1ce36daad03d@web.de>
 <CAK7LNATHnjNe0Bagd4HOkNKXS_-5C5oU0cgQ-rFT6sgF33G+1A@mail.gmail.com>
 <b9406c64-5a0e-83ab-7dfa-8effacc2a7e5@web.de>
In-Reply-To: <b9406c64-5a0e-83ab-7dfa-8effacc2a7e5@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aAgYTSh2EM9qXkebX/s9DHra5uUSzvdwQGDgfyRGxoGh29MkFwx
 uGCLugFkRcS0P2HtmnHO4lyq9WidJ6yCG0QTRrEX03xB+tMSdUS50fE15w11d/UKvBo1EiQ
 Hw5iPVlrkwr5AIjIbnbTcz59rxePfJz3o7oqEXdyAObBoBNRBuTH/scaFMgqEI/hY48ArAQ
 +WKeKfYlq/dCDeaUyG5Jg==
UI-OutboundReport: notjunk:1;M01:P0:QkiZC44RvkA=;/kTFyk/8I4263RORgMRXgPujJ/M
 1jsXGz1s6PPacNC06DJ1+jIcTkJ+awc9Uuf4MrpLrMCHlHu65M7lcmMqnExW96IDOag+dR+wv
 rfVAF6cjQUQGVe4f6FJcZ3QsN7YEBEb8PmPqv+Xid4Uq04LDNk9R9lt1uwpLHa07DKK4K0Us+
 Lf2C7iYAoqhToCKQUgq1wW7tS5bMv/MEcXUX8YRLEZR2svaqgp3/J/MZQCY58RnPQ9m7zaAnn
 Smji7FuJIXt7yLtn4IU0P5h7E2BX3pL79dcaddtysZX7EkbuqjBKeTF0iC8TtOzrpiYEt8Xon
 SmUvxZBdm8oorjEww3zhhNyyYsP9VEnQwo/sGA/iRAiacwMgC2bEQdoWmdrHwTZriimWl6pBi
 xMKQJINhwQEELT1s6WD+6VBnrREDHXlyj5DVx5oiuMX3YdJ6gl1yEZv5kJFMviD/AC4gO4WCg
 LhYRZKoih8Rq+okIXB/YNH3C2EZX0eWnCAXaKifjlhSs6nhxQ5SsWdhu6Lb8+MMv09gImktMX
 yiDHoomex+VZ3AdvJMWSkmAltmRyyXXAAF5Cwmgjkl/Vok+6FR3NTnAZgc4CnutGFFntwAGNs
 a1XtkHOh5YWHq2Yy814oKGSlqV2qmgRRb/cXY7IwKfngVkrCbySV/shKTymOhLGOlwGP/TFLH
 OHKyNwJY+NDvc75gTcF+ZgifL3HJfcySrLVWwhILT9N3n9A4+rtWnkJKaQsIns/nqN0bMEv7+
 9G4AKDeztUoEEPnXqBCd6ZccXx1eu+MxoN7/cWl8hKoFTxuR9RUKJEKC2bMbPbS9dcj8BDZL3
 qrG4Fi4CBkWskUb+yp4OIFKcSJJzlVp8E2CQ4Ukpqu3sx3v4WKuPTrOCBPXfQLaTe86JfEakt
 fyVLy/d0MMHAj2fn6g+f6f67udvomgk8PA5yhbCNez/+VGRx9UvEdmBOWa0+CyNp7+NWWqsRa
 gudB4+/jr6tR0p29UzQuMW2eFps=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 11.02.23 um 14:48 schrieb Ren=C3=A9 Scharfe:
> Am 11.02.23 um 08:01 schrieb Masahiro Yamada:
>> On Sat, Feb 11, 2023 at 7:03 AM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>>>
>>> We already use eight bits for the lookup table values in sane_ctype.
>>> Perhaps it's time to move GIT_GLOB_SPECIAL, GIT_REGEX_SPECIAL,
>>> GIT_PATHSPEC_MAGIC and GIT_PUNCT to their own table to make room for
>>> flags for isprint(), isgraph() and isblank().
>>
>>
>>
>> I think that is a good idea.
>>
>> If we can have more room for isupper() and islower(),
>> we will be able to delete sane_iscase().
>>
>>
>> (I was thinking 'unsigned short', but having two tables is OK.)
>>
>>
>>
>> So, how can I proceed with this patchset?
>>
>>
>>
>> [A] After somebody refactors ctype.c table,
>>     I will rebase this series on top of that.
>>
>> [B] keep isblank() and isgraph() local to wildmatch.c
>>     until that happens, so I can proceed without
>>     depending on the ctype.c refactoring.
>>
>>     Apparently, wildmatch.c is not using a pointer
>>     increment with isblank() or isgraph().
>>
>> [C] If 'somebody' in [A] is supposed to me,
>>     my v2 will include ctype refactoring.
>
> [D] We need more tests first. :)  I sent patches to test the current
> classifiers separately.  A similar test for isblank would have helped
> you detect the mismatch quickly.  Full test coverage also gives
> confidence when tinkering with the existing classifiers.
>
> 1c149ab2dd (ctype: support iscntrl, ispunct, isxdigit and isprint,
> 2012-10-15) added an implementation of isprint that evaluated its
> argument only once, by the way, but the one from 0fcec2ce54
> (format-patch: make rfc2047 encoding more strict, 2012-10-18)
> replaced it.
>
> Widening the element type of the lookup table would work, but might
> impact performance.  I guess it would be slower, but perhaps we'd
> have to measure it to be sure.  Splitting the table into unrelated
> subsets would avoid that.
>
> Deciding which flags to move requires knowing the full target set,
> I think.  The punctuation-related flags looked to me like good
> candidates until I saw the original isprint implementation which
> uses them and several of the others.  So I'm not so sure anymore,
> but here's a patch that moves them out:

Perhaps:

[E] Implement isblank and isgraph as inline functions and leave the
lookup table integration for later:

   #undef isblank
   #define isblank(x) sane_isblank(x)
   static inline int sane_isblank(int c) {return c =3D=3D ' ' || c =3D=3D =
'\t';}

   #undef isgraph
   #define isgraph(x) sane_isgraph(x)
   static inline int sane_isgraph(int c) {return isprint(c) && c !=3D ' ';=
}

The Lazy Way=E2=84=A2 ;)

Ren=C3=A9
