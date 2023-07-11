Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2553EB64DC
	for <git@archiver.kernel.org>; Tue, 11 Jul 2023 14:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232851AbjGKOtC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jul 2023 10:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232686AbjGKOtA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2023 10:49:00 -0400
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2693F10CA
        for <git@vger.kernel.org>; Tue, 11 Jul 2023 07:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1689086910; x=1689691710; i=l.s.r@web.de;
 bh=RQnOwqRn29tq31OPTH9FJEVj5lMptSHZt7cYwxZj/oI=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=mLu8zhujDcS8ggYQbyhvBjOrC8KDt9c032+UpboP5dy786/gjRUCsdIk9M3TySNnvkpaLZn
 KLnwk1Biq4cInirn6YF3NL7Cu0WbjwrIbPCQSjJ+F3oumVPtgwNpsLX0jFiZCe9xVpRaz37IX
 sBSP3XUSLz9W2MiA/0nj3AqfBzNucEzwclASjgIu0ZtvVGhmTV9VLWAB79uSB94ifb/xBaIFK
 CkJEbNewxtruDwGbSSNys8G7be+JWM+4gZ1Tgus0/eaNqbRkeDeLz737Lo6RUbfveB3UAH9uQ
 FocHuAsa2K+jP3Ip7kXliuFOhUKsA4kAYfcVBjv3Yu8/xAx4TW4Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.149.250]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M28SB-1qGkch38bB-002e7d; Tue, 11
 Jul 2023 16:48:30 +0200
Message-ID: <e77ff965-cad1-dee3-a0a4-aa41249a875d@web.de>
Date:   Tue, 11 Jul 2023 16:48:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] for-each-ref: add --count-matches option
To:     phillip.wood@dunelm.org.uk, Jeff King <peff@peff.net>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        vdye@github.com, me@ttaylorr.com, mjcheetham@outlook.com,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1548.git.1687792197.gitgitgadget@gmail.com>
 <9121e027fb9f157878a9624ce6c834b69cd38472.1687792197.git.gitgitgadget@gmail.com>
 <20230627073007.GD1226768@coredump.intra.peff.net>
 <f6fd39bc-65d4-76e3-94b4-9163194c89dd@gmail.com>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <f6fd39bc-65d4-76e3-94b4-9163194c89dd@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Hb+zLJi/AAjvPFboKvVSVjHCLZ3jV7YPoVDEKmYZJV5A5ttzZ3Q
 GDiN8YPrxlQCcnIf9JtDoSUrbaTEUo5ti2obUtPgJnxjUp7+oilTFqKTUU5sJiCq0YcGS2W
 /sCfwEjrY4viygE4gF+hyDkS84V14L1mSPqwObKGsY23vrDzJ+RJsp6KhqPtt1U2VDBBw8T
 EtilJx6t81Ba9U+zje8jw==
UI-OutboundReport: notjunk:1;M01:P0:5uyqDC0Alwk=;r0YJ/tMY3psEEJhe0HwdUlXX2rU
 xRcRHg8MJKi6rZmY0/5r9elbvliXBYwetIhT/IvWWT7NgXsDA8W9lwtsex1m7gq4jeROkjaxZ
 w+cE9FFj65gTvLbBolhWGaibEvLs9a9JkmqBVAeoyoiiBi45Ie+gihXl1KlV+0t5a3knGTU/c
 ISzKB2HP8wdLJmWNy9/5ZM9OcLfK5bzMp6R3ZmzU1AE9JQi/tNBn0ifQfJYXXW3dkczMlIlRj
 jmQhUohsYLYst4MBKS3Yoq5XPDrrNGb3mjAPC84+NSEq95sEV1KHzCgg4VJ+50NMl/XKMR5ua
 nXMBwd+yH2xVfo6DSiCYv2U9ua74V2ylxzP4rbYWf9kNa/rGGeM2FFgiwmJbylvhRBwPNYudl
 WFbnanfnrIST+RTz58BlGV2Rxra9pPmYHGHkh79ztWETVnNp6DYIALxLJQYqh2JEAly2gGTfC
 1DQH8QVFviGCOf53R2vKyuIujVs3FH5/HMgDGsm0l9BXBSJrWaPK05fcajN/ecXt/UmKOWZnp
 wpa4ba0NCWqDIzxzibKyHDhm7aikbH42YiFWxVkbMcxoS76ZMVKqr4J63xsiy0mJoTYdlx67q
 2JpQeDUwUukXALmIG0JtZ/oR7TxLejc9Z9HllUPFNnJ4YzMdrVJYN1QNYW3geQKOtYDNhXbl2
 uBJutp4jSnbQEwDzbujSWPflHdi3UfIo+LKrhOUbeYhf0gWCfeEBS1665S7kkBfzXjkLQLhuV
 aOKrpegGOkF2fjbUHbldCwtop8ynfmowVYDeLc5fMWnYLvZlZRwr6nRziAFF9Oi/hU/tYLMbG
 hGahX2lXGujOEJlL49nc8akhud9EXc9RmhceChUCkmDyDjLIo1txDk/Jb5biMI0MHZeMyy/rT
 EO04zdBvxw1akq/spmu/VtmzexLKNri+YMKIj3MaA/2bJ+iuZJLCl+nidDz1KYPhI7dRfd/EN
 MjscVirK2BFhot2XneB+apEXNmA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 27.06.23 um 12:05 schrieb Phillip Wood:
> On 27/06/2023 08:30, Jeff King wrote:
>> On Mon, Jun 26, 2023 at 03:09:57PM +0000, Derrick Stolee via GitGitGadg=
et wrote:
>>
>>> +for pattern in "refs/heads/" "refs/tags/" "refs/remotes"
>>> +do
>>> +=C2=A0=C2=A0=C2=A0 test_perf "count $pattern: git for-each-ref | wc -=
l" "
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 git for-each-ref $pattern =
| wc -l
>>> +=C2=A0=C2=A0=C2=A0 "
>>> +
>>> +=C2=A0=C2=A0=C2=A0 test_perf "count $pattern: git for-each-ref --coun=
t-match" "
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 git for-each-ref --count-m=
atches $pattern
>>> +=C2=A0=C2=A0=C2=A0 "
>>> +done
>>
>> I don't think this is a very realistic perf test, because for-each-ref
>> is doing a bunch of work to generate its default format, only to have
>> "wc" throw most of it away. Doing:
>>
>> =C2=A0=C2=A0 git for-each-ref --format=3D'%(refname)' | wc -l
>
> That's a good point. I wondered if using a short fixed format string was=
 even better so I tried
>
> git init test
> cd test
> git commit --allow-empty -m initial
> seq 0 100000 | sed "s:\(.*\):create refs/heads/some-prefix/\1 $(git rev-=
parse HEAD):" | git update-ref --stdin
> git pack-refs --all
> hyperfine -L fmt "","--format=3D%\(refname\)","--format=3Dx" 'git for-ea=
ch-ref {fmt} refs/heads/ | wc -l'
>
> Which gives
>
> Benchmark 1: git for-each-ref=C2=A0 refs/heads/ | wc -l
> =C2=A0 Time (mean =C2=B1 =CF=83):=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.150 s =
=C2=B1=C2=A0 0.010 s=C2=A0=C2=A0=C2=A0 [User: 0.494 s, System: 0.637 s]
> =C2=A0 Range (min =E2=80=A6 max):=C2=A0=C2=A0=C2=A0 1.140 s =E2=80=A6=C2=
=A0 1.170 s=C2=A0=C2=A0=C2=A0 10 runs
>
> Benchmark 2: git for-each-ref --format=3D%\(refname\) refs/heads/ | wc -=
l
> =C2=A0 Time (mean =C2=B1 =CF=83):=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 66.0 ms =
=C2=B1=C2=A0=C2=A0 0.3 ms=C2=A0=C2=A0=C2=A0 [User: 58.9 ms, System: 9.5 ms=
]
> =C2=A0 Range (min =E2=80=A6 max):=C2=A0=C2=A0=C2=A0 65.2 ms =E2=80=A6=C2=
=A0 67.1 ms=C2=A0=C2=A0=C2=A0 43 runs
>
> Benchmark 3: git for-each-ref --format=3Dx refs/heads/ | wc -l
> =C2=A0 Time (mean =C2=B1 =CF=83):=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 63.0 ms =
=C2=B1=C2=A0=C2=A0 0.5 ms=C2=A0=C2=A0=C2=A0 [User: 54.3 ms, System: 9.6 ms=
]
> =C2=A0 Range (min =E2=80=A6 max):=C2=A0=C2=A0=C2=A0 62.3 ms =E2=80=A6=C2=
=A0 65.4 ms=C2=A0=C2=A0=C2=A0 44 runs
>
> Summary
> =C2=A0 git for-each-ref --format=3Dx refs/heads/ | wc -l ran
> =C2=A0=C2=A0=C2=A0 1.05 =C2=B1 0.01 times faster than git for-each-ref -=
-format=3D%\(refname\) refs/heads/ | wc -l
> =C2=A0=C2=A0 18.25 =C2=B1 0.20 times faster than git for-each-ref=C2=A0 =
refs/heads/ | wc -l

You don't need no "x", by the way; using the empty string saves some
cycles for me.  In my Git clone, no special setup, 9931 refs:

Benchmark 1: git for-each-ref --format=3Dx | wc -l
  Time (mean =C2=B1 =CF=83):      25.1 ms =C2=B1   0.1 ms    [User: 8.7 ms=
, System: 16.8 ms]
  Range (min =E2=80=A6 max):    24.9 ms =E2=80=A6  25.6 ms    109 runs

Benchmark 2: git for-each-ref --format=3D | wc -l
  Time (mean =C2=B1 =CF=83):      24.6 ms =C2=B1   0.1 ms    [User: 8.3 ms=
, System: 16.8 ms]
  Range (min =E2=80=A6 max):    24.4 ms =E2=80=A6  25.3 ms    110 runs

Summary
  git for-each-ref --format=3D | wc -l ran
    1.02 =C2=B1 0.01 times faster than git for-each-ref --format=3Dx | wc =
-l

Ren=C3=A9

