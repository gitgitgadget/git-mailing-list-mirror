Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456B1C433EF
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 21:14:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239920AbiBQVO6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 16:14:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234339AbiBQVO5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 16:14:57 -0500
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972A748E46
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 13:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1645132470;
        bh=kYk4k/LiuYFFqZQipofl02/JEM3ypw6L6y16L/LCHvg=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=lXhIji206gpy3w5U1LI9zfI3q2Py3Yf2C+BMDLxHJg2DGcGkvs966PMyuu4yoLHbt
         IPYpj9I7JNYxFElqHHjvyKPYJvQaszC/2zxpcpXmUE/W91cGxEPecL0xFdktN/qRrn
         WCwtcrGPBc7qbSyp3plRFjrvNBDIUt6mcEAqjgUA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.16.203]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mf3ug-1nvUMu2b4U-00gkXc; Thu, 17
 Feb 2022 22:14:30 +0100
Message-ID: <4e391e2e-6561-3c2e-0306-c860a37356bc@web.de>
Date:   Thu, 17 Feb 2022 22:14:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: [v2.35.0 regression] some PCRE hangs under UTF-8 locale (was:
 [PATCH 1/2] grep/pcre2: use PCRE2_UTF even with ASCII patterns)
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>,
        Hamza Mahfooz <someguy@effective-light.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>
References: <5fa6962e-3c1c-6dbc-f6d7-589151a9baec@web.de>
 <20220129172542.GB2581@szeder.dev>
 <dca59178-6e9b-315b-06ee-8e3201aa391c@web.de>
 <20220130090422.GA4769@szeder.dev>
 <b74f781c-548b-5254-d3d1-fc1873c70e10@web.de>
 <220131.868ruvbovo.gmgdl@evledraar.gmail.com>
 <1425e548-c1bb-3cff-d75d-c3760abb6129@web.de>
 <220212.86zgmvx13i.gmgdl@evledraar.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <220212.86zgmvx13i.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vjbPLB4KBxoUaQsEh+xdOBmaFHXd/MT6bGXS+1gQ98zimpTBmtT
 FNjT+x985PGHlc4MO+zBwK/Qg4XgngCr0kcLTiTaRwpBNRVI+2rdeX6moJDSMJbf56+noo8
 K1/X4445ORy7vuaYp7e4AuLgoxxs48cZX+clsHoqdWgpepVtaIPWwm+p04JjGDEKDOx7fN5
 luZ4QsZo4DvWey52yDxKA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lLX15ZQgf8g=:31nT4kapL7eVXRPqcIbWDu
 bf+Ieh4A0nZJ+eDRgL7Pz00pabqDk3tiyztNQORQ5Qg5YfZwWJFuOKWwdf2+7TeUzBOhaBsTO
 YZeDJRnozIMpjijk+eYA+DWlrf4vf7KqH4/eg4ZW2jesQhyvia2TcIFyNj3UKjPLZ0TU9qsuX
 Axh9D4SVlupkF9CldVMn9ExQleMPq9HGntSNgnPuf1Ydfoqt+mavtOr2RPXFUq1CWHdOJSjd/
 G7dTDZaySZ/JvI6Fn5U2R5VITKOX8IK/QkoDxXP/P5VfodlvcccHyOBzfm2uI50eIY+i1HYUJ
 2QPc5Mr7a0JYgyqiX9whKQCWzlkB8VzsIVHr79NUdfsZ4dRv00r7x27/NtN/sDQv8Q28eyzPU
 xXDjZ3r+pK/7uCXxVrL2FKZM5A7GypfIkWC3mvNZxYyyJu2ZuqZlPgHg9WP2cG7UTzVYsN+1k
 ZTHrHelLUrf4NhysCoELZeNvygyJcBggljnhADg4HogESrYFM+4HZmmGI5rJh8JepZ6nyHpmC
 doL9grjIXNi53vjUPScrfL6onzXO7M485W7L4nSHcLyQV6f5T1Azeuu3BUSvdByNG1SVG40VA
 PIZwq/mMk8bLVasOlInQkbT6CqRl+V8ub87EgKTSqmSBsq144qn+amKZJFfkHWxydS/OAOj8L
 hCqmIZjl+dyv0znMF12XCcv2LyeMyEyOAU9+rLw9AylIGw4R2LnzSFGVFcKEDumIrgXBkLYrI
 HtjNqXI/yCFC2dT9fkvU+HGIRpfMx5iGp463EWuLEZN1Bxmz8oR4mXtt1EqWcgEt5zI6ouU5a
 JzKMkTdBRvz9OwA1bLNPHG0bm4ss8RSy8HfHiF0RfFoX8tACSqjtamdkZ6RbEfGUSvF1jDeez
 R3qEJZGSRJfm+4bPrpaaCtiKHZvO/zhk70Ije4UsHi4KHconwDh9XNdcYbzC/YLMrMbMlNlug
 hZpYqA5GdLAMPwsMN2qhU9x99pr08RiwdXzmJWVViL66p/m/1r5QKT2x8U8y1R6cPI0zLjlEf
 SKvJmcvNE/xdzfJSv2S7ykJvByPGqmqS4uZ5VGLKqOcAgEE15gZBkJ07X7Rw1YxUBA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 12.02.22 um 21:46 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> On Sat, Feb 05 2022, Ren=C3=A9 Scharfe wrote:
>
>>
>> I can't actually test the effectiveness of the patch because PCRE2's
>> JIT doesn't work on my development machine at all (Apple M1), as I just
>> discovered. :-/  While we know that disabling JIT helps, we didn't
>> actually determine, yet, if e0c6029 (Fix inifinite loop when a single
>> byte newline is searched in JIT., 2020-05-29) really fixes the "^\s"
>> bug.
>>
>> So I have to abandon this patch, unfortunately.  Any volunteer to pick
>> it up?
>
> We can test it in CI, and have a proposed patch from Hamza Mahfooz to do
> so. See
> https://lore.kernel.org/git/211220.865yrjszg4.gmgdl@evledraar.gmail.com/
>
> There's been some minor changes to the main.yml since then, but I think
> you should be able to just pick that patch up, adjust it, apply whatever
> changes you want to test on top, and push it to github.

Good idea!  Except the "just" is not justified, I feel.  I learned that

  - t7810 fails with PCRE2 built with --disable-unicode because it uses
    \p{...} unconditionally, and that's not supported without Unicode
    support -- no idea how to detect that and skip those tests except
    by trying and maybe looking for the note that "this version of PCRE2
    does not have support for \P, \p, or \X", which somehow feels iffy,

  - PCRE2 10.35 doesn't build on Ubuntu x64 without adding -mshstk to
    CFLAGS, and that's the version I wanted to test,

  - many of the Unicode related tests require Islandic language support,
    and "sudo apt-get -y install `check-language-support -l is`"
    installs it,

  - the condition for our workaround for bug 2642 is reversed,

  - with that fixed I can't trigger the endless loop.

So perhaps that's the only fix we need here -- or perhaps I got
confused by the multitude of options.

=2D-- >8 ---
Subject: [PATCH] grep: fix triggering PCRE2_NO_START_OPTIMIZE workaround

PCRE2 bug 2642 was fixed in version 10.36.  Our 95ca1f987e (grep/pcre2:
better support invalid UTF-8 haystacks, 2021-01-24) worked around it on
older versions by setting the flag PCRE2_NO_START_OPTIMIZE.  797c359978
(grep/pcre2: use compile-time PCREv2 version test, 2021-02-18) switched
it around to set the flag on 10.36 and higher instead, while it claimed
to use "the same test done at compile-time".

Switch the condition back to apply the workaround on PCRE2 versions
_before_ 10.36.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 grep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/grep.c b/grep.c
index 5bec7fd793..ef34d764f9 100644
=2D-- a/grep.c
+++ b/grep.c
@@ -386,7 +386,7 @@ static void compile_pcre2_pattern(struct grep_pat *p, =
const struct grep_opt *opt
 	if (!opt->ignore_locale && is_utf8_locale() && !literal)
 		options |=3D (PCRE2_UTF | PCRE2_MATCH_INVALID_UTF);

-#ifdef GIT_PCRE2_VERSION_10_36_OR_HIGHER
+#ifndef GIT_PCRE2_VERSION_10_36_OR_HIGHER
 	/* Work around https://bugs.exim.org/show_bug.cgi?id=3D2642 fixed in 10.=
36 */
 	if (PCRE2_MATCH_INVALID_UTF && options & (PCRE2_UTF | PCRE2_CASELESS))
 		options |=3D PCRE2_NO_START_OPTIMIZE;
=2D-
2.35.1
