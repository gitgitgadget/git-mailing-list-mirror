Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4ACEC3DA78
	for <git@archiver.kernel.org>; Fri, 13 Jan 2023 17:37:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjAMRhX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Jan 2023 12:37:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjAMRgx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2023 12:36:53 -0500
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D5FA2AB5
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 09:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1673630685; bh=Zs+CiU4dO8xi+ExUHLwa388LhjsaAoe+fdy0AN/50R4=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=wCfljdLdIJASQaDDKQLz3pr1ZSoCmAU/a9EqVTMw31M2pZCdjBHGAIlC8/LU1JrRG
         VDBpC+MwfpQmckmBDOmbZPdofGA+m9NUAzimezGZCEglix9/zllMZHxGg8YgfbQXyS
         +uNG5C2L0lG6XWFNCCEase1nkT1zumdCIffn4lFIlXPGVG4Agsa3WBGIPNwp1JRjUZ
         1NZcU+KIGJRMti+vSKFdRgARL7xHBNa2HdHNqorus4N7bRTZfEssYyFLG59KmrnU1J
         nOVpY0lJBF61D+fK+q6JxqbOwyr6C/KpXWnXdVzT5fnm02aPW4+Hu41+D+H2Twg/xC
         ExfbfnjT31p7A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.21.69]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MBSB9-1pSnjO3G07-00Cz8w; Fri, 13
 Jan 2023 18:24:45 +0100
Message-ID: <5f6908c8-3f84-92a3-b9d1-8689c500c1e9@web.de>
Date:   Fri, 13 Jan 2023 18:24:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: BUG: git grep behave oddly with alternatives
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>
Cc:     Marco Nenciarini <marco.nenciarini@enterprisedb.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
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
 <230113.86ilhazved.gmgdl@evledraar.gmail.com>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <230113.86ilhazved.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0HdHdIklalJTGEyQJz2nzU0BhOB3iEte5DC0WS6Vc3MMU+IJEKD
 sUTd8FUmQ5ia2xOd6bnw7bs/LhBY0QjAD4AzY27AVLXOpF9sOjDxaBPOqsxiSJ5OK08y85c
 K8y6gMWiGeryYBVASzYbvGHgx7ayuRN2d6C0LrWjnw1PuHJV2ZgTlnTvA1BYarWHJlAdCBT
 c6u7yVZlAI82g5U3a/8oA==
UI-OutboundReport: notjunk:1;M01:P0:rTAwk9q6AX4=;SS5KflllPnKkNQUn40Ock3T/P4P
 4mUq+ya91bGOfSIfSBV6wM9BQLlVSaOg8TDY6MVylMyUcRUj4CdE6eLigzPx104GgvR8zvuLh
 YHA5h8k6sPL+YXN+gxXIVAvWbt+gPku5+ypv+eICQrV/V5zcFr4aSj/3/kRtYCc4eCjlddejB
 ldTZoZLgebJh+qPJVYXbmZTYlQi6+5rnmbj1bVzNe1cSOrLvkEM4gZWeKcjNTrTnxkxp5ch/p
 UACl5Mvpb8DjTdXD0eLsS4biwUCqR+QrvbnSWZhDUkfoJ62/6jqcUZcH5brQ7afXq1ilnHJmI
 9+EyjuSg25nk/HZN+5F0KsT0BR3pJy6EO5vc5/T5y5ZmlzfbcdtXjBbMOrMwfeieJcvJxGWDQ
 /HcTuGm00vBkS9SLOSofwcF5yFR7+ejvWEC6Sy725/q0QQl1wokv+JD31IFHWcXLEyGQJitVV
 ryTuMfF3t3Kg4DS9/3mNXGWfWfPM7PL68Bqxx2jtGpi60k+0plkcAhTql43lrONlBUKWD10nE
 4dNDv8m8GemxCIF52naQYiUAVclS6a5h9SqCIW1+YxXeRsXV5Cq2UwAmeVwEo6EwlN9l6e2TZ
 du/6r0OqhTK57iPNhdZb18IrkKt9ETBGpt/B9nWnkiYdw+7w7F4EoHj+lBsS2DgT9GKLmClEw
 +tqpck3gftAuCrMHhiKsrKlJQ3p5Q/lB8Bo1Yepv/VFYIu4yy1DfRhnnqwblLfqqFOHK+y17B
 zc35IBYrhhx+nVb0jc9rqvZkqRjFflPeNSS29rAJz8yUpYtm2w74WsRiYTAIHzVg+eLlyFOuo
 pfQLfboTgDpvppiE9nXV0ZpKgQtRTsANyMkhrCHLn+IxmlnLC3IuGk1almJfVKXXYWWnYYNuj
 GMRwMXxu9jdMfyd0e0yIm5TZnbVOC16FAQoJn8EfPFKa82zkzRSj279uwjjFBpG6RDLFv2Y/m
 3Tn4wBcpk0XR+Ev+497XewGnB0g=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 13.01.23 um 09:28 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> There's a couple of ways out of this that I don't see in this thread:
>
> - Declare it not a problem: We have -G, -E and -P to map to BRE, ERE and
>   PCRE. One view is to say the first two must match POSIX, another is
>   tha whatever the platform thinks they should do is how they should
>   act.

I like that and it was my first reaction -- alternation is a
non-standard extension to BREs.  But we supported it explicitly since
3632cfc248 (Use compatibility regex library for OSX/Darwin, 2008-09-07),
so not having it anymore is a regression that we should fix, I think.

>   Of course that makes git regex invocations "unportable", but it might
>   be acceptable. People can always use PCRE if they want "portability".
>
> - Just mandate PCRE for Mac OS, then map -E to -P. We could do this with
>   the pcre2convert() API and PCRE2_CONVERT_POSIX_EXTENDED flag,
>   i.e. PCRE's own "translate this to ERE".
>
>   But Perl/PCRE syntax is already a superset of ERE syntax, minus things
>   like (*VERB), (?: etc., which people are unlikely to write without
>   intending to get the PCRE semantics.

PCRE2_CONVERT_POSIX_EXTENDED is a flag for pcre2_pattern_convert(),
which allows converting an ERE into a PCRE2 regex
(https://pcre.org/current/doc/html/pcre2convert.html).  So this feature
allows using PCRE for every kind of regexes, right?

There may be feature differences for EREs between libc on macOS, glibc
and/or GAWK, but I'm not aware of any complaints so far.  So I currently
don't see the need for that.

Ren=C3=A9
