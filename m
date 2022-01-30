Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9BFFC433EF
	for <git@archiver.kernel.org>; Sun, 30 Jan 2022 07:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236235AbiA3HzT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 Jan 2022 02:55:19 -0500
Received: from mout.web.de ([212.227.15.14]:50079 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236082AbiA3HzS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Jan 2022 02:55:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1643529303;
        bh=uFHOqVVSrUpJWighHb34kNl7fSh4a9f8sCV6mxfJwwg=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=WODdVnNqTNxAQQK7rsuDkF+Yv+gm6L3mhbWXUT9ds7k+aSWlkMM56w2Udxel1VxRO
         6hsRlJgjmqryZYnXQAaIXJJeZ2t6y/xJLowRpHrLIKBGlKiJIQRh6BG9ROjuKrRJsx
         OycEULZGoPUaeq0O1uHiuRB5epzQA+HP1HNjfZ7c=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.22.121]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MgAJ8-1mbC7l24Za-00hwdu; Sun, 30
 Jan 2022 08:55:03 +0100
Message-ID: <dca59178-6e9b-315b-06ee-8e3201aa391c@web.de>
Date:   Sun, 30 Jan 2022 08:55:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [v2.35.0 regression] some PCRE hangs under UTF-8 locale (was:
 [PATCH 1/2] grep/pcre2: use PCRE2_UTF even with ASCII patterns)
Content-Language: en-US
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Hamza Mahfooz <someguy@effective-light.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>
References: <5fa6962e-3c1c-6dbc-f6d7-589151a9baec@web.de>
 <20220129172542.GB2581@szeder.dev>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20220129172542.GB2581@szeder.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xrhFPLLzUN/gMxXkOhkpv9jmftjqeilizR1ViV9UKzGXUtKGkws
 uWDFKyVG8JW8KyBpMNyukEF5jwLsiody4DAwQXMCZ52WaPuQ/g+15fI2vSNed7OBR5CrFtS
 aw8UcjT5NcomNgUI54QPDNt09eWpWRTqzdRSyhvW/amzt3MqDbisoQx4IsAstJVjiNcxA/2
 TWkwot4G89vy9zU0yxSbQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:16lS2SqL9cQ=:L8mjN5sng57QW5VqHplqv8
 WY5oY010977jT0b476LXdDmdOCNzUCUPg5tp5uz5aCAj8cT2iMcVVj2nNjcaQ9IijvnDzjBxu
 bSobqVoDnaokU4JYlkb6Ss1ZExyhPexDzSUx8/pg7ZFLuI/MBaDpgz3TVfo/pkKgcUiANMN1i
 0AEO6BKm/e8zDodJLi2+CUT8sEuhhpgbgsekjlbvGPw1tVJp6MJSZ+qslgIQ1QQ8kdBpBh1Dz
 Te4MJNyJK+Oru6PtZ18qHeMSzRVcRcYM4t3K8drX5XwBPsgwDIztT7NxnuSzAdsNuK/xllXcb
 S2l6M7tb66BOk8B6/kxPORJhjeY4GjM1YkNg3rAlS0aNJdBaX74MRQFQJqY0sTN/PLccoz49J
 PYRtk0SPmEH7y/UyM0wEG1MUey8NuKYzTBSYGi3dU9TxD91S8THYy3eXzeVXLr1tYMwixXByZ
 z6bt79DFtgyG1aRocdyv2yraDYeZJWZ4KQoKzMpHUnmxXb4jDtU2EL6N2GFkSrby1zQQjRbYE
 Lam0jhw8u7XtDfcaBfKJvyhzZrdCBYMNTgtp6TgRTk1BQsy7ArkTEuljH8dqxSbXINtOVJy+E
 NqyfKSUIWKnMQdxN9prcG+EZM8e0zk8dX+0g8JbgKphYX04VwqL1TLYbAftQE2gjXJc+KahxA
 q/ZGz/utntyleWLMZGICOlzUeodI+YKfzhc5OTKbXJHTjQhpfoiokv+dijDIXN8Qj7jTLgETv
 5a687/BFGVqOYsMarT2PFeSHpGaZBDdoQrxDTup0OnU8tbpOUWNV4xIwd+tk4tZos6xSdpvCZ
 TaC/sNuKpJvugF6QTOHgnTgrBlMp+Jx3a8eTwCvctOcXd6O514Xyph7lcf+cWQIX8q1Ml0u70
 EVmkUoTiXjPO6lyzifLS10vtT3+kN65edMLbeqkIW6tPozqDcZHnYbs4swrdizb/j+kPCUddd
 8kArbjv14TQedkAEd0fIpHDqyAdPL+yltHApWtSKbRrjVnJMZYI10mv4/Spn+Min6l4DkrSK5
 6UvK32i4MYUpwkT9EiQMup5ZBb63Te250jYbPqRaIrIZGhdboSJ200/Z8wvXCs0FnA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 29.01.22 um 18:25 schrieb SZEDER G=C3=A1bor:
> On Sat, Dec 18, 2021 at 08:50:02PM +0100, Ren=C3=A9 Scharfe wrote:
>> compile_pcre2_pattern() currently uses the option PCRE2_UTF only for
>> patterns with non-ASCII characters.  Patterns with ASCII wildcards can
>> match non-ASCII strings, though.  Without that option PCRE2 mishandles
>> UTF-8 input, though -- it matches parts of multi-byte characters.  Fix
>> that by using PCRE2_UTF even for ASCII-only patterns.
>>
>> This is a remake of the reverted ae39ba431a (grep/pcre2: fix an edge
>> case concerning ascii patterns and UTF-8 data, 2021-10-15).  The change
>> to the condition and the test are simplified and more targeted.
>>
>> Original-patch-by: Hamza Mahfooz <someguy@effective-light.com>
>> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>> ---
>>  grep.c                          | 2 +-
>>  t/t7812-grep-icase-non-ascii.sh | 6 ++++++
>>  2 files changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/grep.c b/grep.c
>> index fe847a0111..5badb6d851 100644
>> --- a/grep.c
>> +++ b/grep.c
>> @@ -382,7 +382,7 @@ static void compile_pcre2_pattern(struct grep_pat *=
p, const struct grep_opt *opt
>>  		}
>>  		options |=3D PCRE2_CASELESS;
>>  	}
>> -	if (!opt->ignore_locale && is_utf8_locale() && has_non_ascii(p->patte=
rn) &&
>> +	if (!opt->ignore_locale && is_utf8_locale() &&
>>  	    !(!opt->ignore_case && (p->fixed || p->is_fixed)))
>>  		options |=3D (PCRE2_UTF | PCRE2_MATCH_INVALID_UTF);
>>
>
> I tried to use 'git grep -P' for the first time ever, and it hung
> right away, spinning all CPUs at 100%.  I could narrow it down, both
> the complexity of the pattern and the size of the input, see the test
> below, and it bisects to this patch.
>
>
>   ---   >8   ---
>
> #!/bin/sh
>
> test_description=3D'test'
>
> . ./test-lib.sh
>
> test_expect_success PCRE 'test' '
> 	# LC_ALL=3DC works
> 	LC_ALL=3Den_US.UTF-8 &&
> 	cat >ascii <<-\EOF &&
> 	foo
> 	 bar
> 	 baz
> 	EOF
> 	cat >utf8 <<-\EOF &&
> 	foo
> 	 bar
> 	 b=C3=A1z
> 	EOF
> 	git add ascii utf8 &&
>
> 	# These all work as expected:
> 	git grep --threads=3D1 -P " " ascii &&
> 	git grep --threads=3D1 -P "^ " ascii &&
> 	git grep --threads=3D1 -P "\s" ascii &&
> 	git grep --threads=3D1 -P "^\s" ascii &&
> 	git grep --threads=3D1 -P " " utf8 &&
> 	git grep --threads=3D1 -P "^ " utf8 &&
> 	git grep --threads=3D1 -P "\s" utf8 &&
>
> 	# This hangs (but it does work with basic and extended regexp):
> 	git grep --threads=3D1 -P "^\s" utf8
> '
>
> test_done

I get the following result and no hang with PCRE2 10.39:

   utf8: bar
   utf8: b=C3=A1z

e0c6029 (Fix inifinite loop when a single byte newline is searched in
JIT., 2020-05-29) [1] sounds like it might have fixed it.  It's part of
version 10.36.

Do you still get the error when you disable JIT, i.e. when you use the
pattern "(*NO_JIT)^\s" instead?

Ren=C3=A9


[1] https://github.com/PhilipHazel/pcre2/commit/e0c6029a62db9c2161941ecdf4=
59205382d4d379
