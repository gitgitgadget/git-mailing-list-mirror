Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C96E5C433F5
	for <git@archiver.kernel.org>; Sat,  5 Feb 2022 17:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380515AbiBERAS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Feb 2022 12:00:18 -0500
Received: from mout.web.de ([212.227.15.3]:36805 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239376AbiBERAS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Feb 2022 12:00:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1644080403;
        bh=DwA4QPdB2DXZ3GqEMGmvr8ZJ4Le/FEwPk3/cJHyfNbA=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=ovfCQ+QJBwKaTQ/QPDb+vDY32I8uIf95g5wd/gHrKQo3r/VeXKQC/Pb1b0X/2UBtI
         XfFHmqDTJXT54ZL+aTC9QxEneRmgZuCJMDsRHe8Vr6HjKIHGQu1d//O/JAZfvFIm1E
         USGcXTdHv7uXtx8rVY4sVrDwdZS60956A6ZmXvyc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.22.121]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M1JB0-1nDdWr2OFO-0036DF; Sat, 05
 Feb 2022 18:00:03 +0100
Message-ID: <1425e548-c1bb-3cff-d75d-c3760abb6129@web.de>
Date:   Sat, 5 Feb 2022 18:00:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
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
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <220131.868ruvbovo.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GMHN7klIE0Kr6VZXoWe3xsnTAXyuNsQyUmMxqmgxEG2qJw3FBU6
 AiF4v3NddIOXQ//+FJei+MFNYfr2luyL3IgFcTKdukiEjNHi7GSSRnGXiLrcAU18zT7xemf
 dFwYT140qbEk3B/YFDv0Bjo4MJskN0UFoUoGlbs2K8NeOxZFQXzlB1SLRklsPQDH6qArWGH
 kweQ05z3J8M53QQCzarGg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tzHbJnCXPa8=:J1MQ6nfxgKqoXyPEavsOqA
 MIyv94nB5ERih17KDzfCqBlDS7OFa8gW1DhwkEKfaXUD1jIHFIViCUxvqJeZWuM2GpyPY86ah
 UdfSMB92b4slOB/L5zWKBPLbQDCpjDswJZrofKDnB60smdtgygRAUpzXXLFKNOY3uTDHk2cVN
 /HDzLXU+TB9azIQGIP+effsrvwjZzYiOtwBHHbbMEb3v/iZIX0mytOT/jbZxLhVKeWOtcSXan
 eeEG1OOw5rpalX6wOgFxapqjeijQDwOD903Q53h8SWb7Q8y4scAbwK5EK/Kpsn4IWOI1qPr9+
 ZWri7gw3iIvHpGS3ubaeaM2y2baZ/SbNcceDy6G3qT1l0OAhY/0bScYa4aAnN9LOxqOxw/W0Z
 bsUbMOQ1RGdrGaNB0lUT7tZw7Wkx+MdkRWK9Lf5L3uO01zFfZI2aIdVDQiVaOQyD3kqs8oI1+
 rCSN3mOBHEbyEl/aZx0Nfhi82XihXjo26YVgB1CDmihAmSTLOXDVTmHHUCZ9Mne8aDA3Gjhi5
 jL+tQ+BfJBzKTGF/hyNq/9AC47bsGGMcJU6N04O71i2J87e0fhlHdgbAhEBewQxgrWJlc3jLy
 rWzCZ8M3xwdFt0lcaFaHvLR+HWxVOxsE2mZuULGxWc/YX/TFa0l7zzGy9I7NUG+glce5y2KF/
 yYKyg5byPWTVmCWWW067gZ7TddmGrWvyojl3k8DlU9FLjfp4s5Crfkd4qoF5U972OB7kdCIzu
 tb+P7vHrWwUSQ8LDdM5YdOtVKv8mGpd+uH4KFpRvW8qyBJoWgm/PWJwf52z7WjtJ1TZBU/NZE
 omj84qQ6TNvWsiB5VyBFhKnwCAqna8tYBn50b0Y+abLIogBVrocrXPK4+gk/tGfX1mH6mCSFw
 vP54fqwfs4GR6eQU0tKuyShLjCBHv6EbxEaAKgITwvrtb3dyGpuJE3Mo0RuupBjFCICQHTNAA
 VL7xye+ndmh64BCopscwI4nAT0EkrTd2QX7ebRm98fs7AcMfF/fekbQnUdZFwgXtKVKf1gw/f
 EgvDe+8leq8VulCqPD9K2IUec9gWGhvb+7cOtLoc2ZiLAP0p9Hw6D/TyIvHmOLrK8w==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 31.01.22 um 22:01 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> On Sun, Jan 30 2022, Ren=C3=A9 Scharfe wrote:
>
>> Am 30.01.22 um 10:04 schrieb SZEDER G=C3=A1bor:
>>> On Sun, Jan 30, 2022 at 08:55:02AM +0100, Ren=C3=A9 Scharfe wrote:
>>>> e0c6029 (Fix inifinite loop when a single byte newline is searched in
>>>> JIT., 2020-05-29) [1] sounds like it might have fixed it.  It's part =
of
>>>> version 10.36.
>>>
>>> I saw this hang on two Ubuntu 20.04 based boxes, which predate that
>>> fix you mention only by a month or two, and apparently the almost two
>>> years since then was not enough for this fix to trickle down into
>>> updated 20.04 pcre packages, because:
>>>
>>>> Do you still get the error when you disable JIT, i.e. when you use th=
e
>>>> pattern "(*NO_JIT)^\s" instead?
>>>
>>> No, with this pattern it works as expected.
>>>
>>> So is there a more convenient way to disable PCRE JIT in Git?  FWIW,
>>> (non-git) 'grep -P' works with the same patterns.
>>
>> I don't know a better way.  We could do it automatically, though:
>>
>> --- >8 ---
>> Subject: [PATCH] grep: disable JIT on PCRE2 before 10.36 to avoid endle=
ss loop
>>
>> Commit e0c6029 (Fix inifinite loop when a single byte newline is
>> searched in JIT., 2020-05-29) of PCRE2 adds the following point to its
>> ChangeLog for version 10.36:
>>
>>   2. Fix inifinite loop when a single byte newline is searched in JIT w=
hen
>>   invalid utf8 mode is enabled.
>>
>> Avoid that bug on older versions (which are still reportedly found in
>> the wild) by disabling the JIT when handling UTF-8.
>>
>> Reported-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
>> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>> ---
>> Not sure how to test it.  Killing git grep after a second or so seems a
>> bit clumsy.  timeout(1) from GNU coreutils at least allows doing that
>> from the shell, but it's not a standard tool.  Perhaps we need a new
>> test helper for that purpose?

https://mywiki.wooledge.org/BashFAQ/068 offers a Perl-based Shell
function or aborting a program if it takes too long:

   doalarm() { perl -e 'alarm shift; exec @ARGV' -- "$@"; }

It doesn't waste time when the program finishes faster and seems to work
fine with git grep.

I can't actually test the effectiveness of the patch because PCRE2's
JIT doesn't work on my development machine at all (Apple M1), as I just
discovered. :-/  While we know that disabling JIT helps, we didn't
actually determine, yet, if e0c6029 (Fix inifinite loop when a single
byte newline is searched in JIT., 2020-05-29) really fixes the "^\s"
bug.

So I have to abandon this patch, unfortunately.  Any volunteer to pick
it up?

>>
>>  grep.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/grep.c b/grep.c
>> index 7bb0360869..16629a2301 100644
>> --- a/grep.c
>> +++ b/grep.c
>> @@ -406,6 +406,14 @@ static void compile_pcre2_pattern(struct grep_pat =
*p, const struct grep_opt *opt
>>  	}
>>
>>  	pcre2_config(PCRE2_CONFIG_JIT, &p->pcre2_jit_on);
>> +#ifndef GIT_PCRE2_VERSION_10_36_OR_HIGHER
>> +	/*
>> +	 * Work around the bug fixed by e0c6029 (Fix inifinite loop when a
>
> Better to quote this as PhilipHazel/pcre2@e0c6029 or something, i.e. to
> indicate that it's not git.git's commit.

The context should suffice for a human reader to understand that it's a
PCRE2 about a bug fix, but I can see some program turning hex strings
into repo-local links getting confused.  Is there a standard cross-repo
citation format?  Using a Github link might be the most practical way
for the near term, I suspect.

>
>> +	 * single byte newline is searched in JIT., 2020-05-29).
>> +	 */
>> +	if (options & PCRE2_MATCH_INVALID_UTF)
>> +		p->pcre2_jit_on =3D 0;
>
> It seems rather heavy-hande, but I can't think of a better way to deal
> with this, i.e. if we selectively use JIT on older versions, surely we
> run into the match-bytes-but-want-chars bug you were fixing.
>
>> +#endif
>>  	if (p->pcre2_jit_on) {
>>  		jitret =3D pcre2_jit_compile(p->pcre2_pattern, PCRE2_JIT_COMPLETE);
>>  		if (jitret)
>
