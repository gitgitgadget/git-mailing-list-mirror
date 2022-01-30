Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75FDC433EF
	for <git@archiver.kernel.org>; Sun, 30 Jan 2022 13:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354891AbiA3NdQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 Jan 2022 08:33:16 -0500
Received: from mout.web.de ([212.227.15.14]:33317 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354875AbiA3NdO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Jan 2022 08:33:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1643549567;
        bh=bzWC+edEdNe4nhq3rvJbo6HlqORYNxndf1qPB73h3vc=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=QtZopcFGBsBMda29/iddPSS6k4vuAgj+yLkRWGQThm4pBfI856BFfP5DUgBWSQeHm
         kMLSr6Op8gK9nB/qcJuGwqd7f6H/uZ06wbEbmBZtX+UBXjLTIcwQeC/xp7DKY5igOu
         95USJvkjo/xEELHbb6Y2LPH8L2QdKj7CEg/pZnW8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.22.121]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MhFlm-1mZrUD2fX0-00eYe0; Sun, 30
 Jan 2022 14:32:47 +0100
Message-ID: <b74f781c-548b-5254-d3d1-fc1873c70e10@web.de>
Date:   Sun, 30 Jan 2022 14:32:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [v2.35.0 regression] some PCRE hangs under UTF-8 locale (was:
 [PATCH 1/2] grep/pcre2: use PCRE2_UTF even with ASCII patterns)
Content-Language: en-US
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Hamza Mahfooz <someguy@effective-light.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>
References: <5fa6962e-3c1c-6dbc-f6d7-589151a9baec@web.de>
 <20220129172542.GB2581@szeder.dev>
 <dca59178-6e9b-315b-06ee-8e3201aa391c@web.de>
 <20220130090422.GA4769@szeder.dev>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20220130090422.GA4769@szeder.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YEDoKjU2GBQEWtm6hixQaD2o9qhvZorw9xjG5dgq/ul0HFi5dNw
 Hs0kp98WGA635G9PYrW9h/2Lm58bhV/OhwkBrGcA19gPmEQRz933NnA7RgvPXggR0xKW/zR
 467LhfJ9JlvvOXCOYYtZ07YbBY8fhmeaFglj7a0SinhkkLEEKZwfdPFQWr0kC6hcx3iV894
 QycYvlbdJsrS8rcaJ1s2Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/8GgRtyMoDg=:QkkxWh+1ZxiIxiUxThxZrg
 xtAyJL6CktoGNZi92vSZr5TfCFVtcXO6hgpdqRh0cV4ZJp6OW7dKFTSj/qfkXcjtyiZ2Op32z
 Jz+ndVB9NKoYU2sJXyGugIEVS1+lxERf+tmpLRKyriIB5FwHA51pWOrzgvez+AkFsgLUrsZc7
 IsF/O5KiNtfyo1u9VqTi7WGmRU7r+CWWNM2HcjKhjjCHw3LMt1IAUZ2rBd3jy356J6QplZoV/
 PCNKj6SQ2E4YilC8ytjftmbRmCWegXBhzVv7LBNm4Ss0LwS286krRP05b/E3pNDqvGj3+NyTr
 Q9CKv62r51UBnD8iKgpasaraglAzKOKfivxAIjG69gPTQgmhcarvOi49V/IssLXpdYkKUE/ON
 pCQsSIM/Q8emTolxMcvp5KPfqxqMSIkxrbVMHP5uwe2n7PxO6VJP4cW/lt92TO1zWoa+YuxeD
 q3Jl0qDzy56otfzJIYvnnh7UWMxylWqhveeWqSxgCExx0zBoj3oP7tMcOal9OMBleaDxLtNTi
 hCTvx7ZPZr+MJ0Iicljk6numxzD363Lp1GIJaeGx9OX2f8ss/x0nVTt2sFYWiOwcC++Ahp458
 krCabsc112xmc1ZqBYtqcIZx2952cmKEYp6vQHwmsbGCJePjEnfOro+HLmlmam8eOMRWJeOKE
 Z3of7Odhx+q5gYTGsEnfC+9DTqC/NJbRSKaVUy4HZqNi/NVxex5qGXEXppUhRuyMeTHyZqi9u
 rbjaJqRoW0NA7jBE+K84PIUtDJhLUPFJe2oQrX1NzgqnaZUcidfz1C3Do4VVAPlCrijaAKPlL
 m5mbpM00+ea0sg9Q/mWkcrDVe7oBekMSb1nUrO2HloyNUHaMX9h51xzd+ZBXgoGS5TtwaUcJx
 o6iXpXSLneyGNBtjH8oyKerwKmbxjAPCd212YsCFRQhqWgoJOV/v4Y3XIW3KXe3Va2QBwtRaN
 OuSfbQRMAus/4sW17wMfA+CLI9yfEn8RaYA3MnGcXlPrqx3cgKCCnm2x+r0G/+qKCU3KA91e1
 5UIfMyKWpbPdunpMslxkMA6NrWQ1AvgROKqxN7aj8p5Cd6Yjk544I1JjLZoBPzIe0g5nFlDIi
 WeCAoNRyFuYW0A=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 30.01.22 um 10:04 schrieb SZEDER G=C3=A1bor:
> On Sun, Jan 30, 2022 at 08:55:02AM +0100, Ren=C3=A9 Scharfe wrote:
>> e0c6029 (Fix inifinite loop when a single byte newline is searched in
>> JIT., 2020-05-29) [1] sounds like it might have fixed it.  It's part of
>> version 10.36.
>
> I saw this hang on two Ubuntu 20.04 based boxes, which predate that
> fix you mention only by a month or two, and apparently the almost two
> years since then was not enough for this fix to trickle down into
> updated 20.04 pcre packages, because:
>
>> Do you still get the error when you disable JIT, i.e. when you use the
>> pattern "(*NO_JIT)^\s" instead?
>
> No, with this pattern it works as expected.
>
> So is there a more convenient way to disable PCRE JIT in Git?  FWIW,
> (non-git) 'grep -P' works with the same patterns.

I don't know a better way.  We could do it automatically, though:

=2D-- >8 ---
Subject: [PATCH] grep: disable JIT on PCRE2 before 10.36 to avoid endless =
loop

Commit e0c6029 (Fix inifinite loop when a single byte newline is
searched in JIT., 2020-05-29) of PCRE2 adds the following point to its
ChangeLog for version 10.36:

  2. Fix inifinite loop when a single byte newline is searched in JIT when
  invalid utf8 mode is enabled.

Avoid that bug on older versions (which are still reportedly found in
the wild) by disabling the JIT when handling UTF-8.

Reported-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Not sure how to test it.  Killing git grep after a second or so seems a
bit clumsy.  timeout(1) from GNU coreutils at least allows doing that
from the shell, but it's not a standard tool.  Perhaps we need a new
test helper for that purpose?

 grep.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/grep.c b/grep.c
index 7bb0360869..16629a2301 100644
=2D-- a/grep.c
+++ b/grep.c
@@ -406,6 +406,14 @@ static void compile_pcre2_pattern(struct grep_pat *p,=
 const struct grep_opt *opt
 	}

 	pcre2_config(PCRE2_CONFIG_JIT, &p->pcre2_jit_on);
+#ifndef GIT_PCRE2_VERSION_10_36_OR_HIGHER
+	/*
+	 * Work around the bug fixed by e0c6029 (Fix inifinite loop when a
+	 * single byte newline is searched in JIT., 2020-05-29).
+	 */
+	if (options & PCRE2_MATCH_INVALID_UTF)
+		p->pcre2_jit_on =3D 0;
+#endif
 	if (p->pcre2_jit_on) {
 		jitret =3D pcre2_jit_compile(p->pcre2_pattern, PCRE2_JIT_COMPLETE);
 		if (jitret)
=2D-
2.35.0
