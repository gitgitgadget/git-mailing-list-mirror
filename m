Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C518FC433F5
	for <git@archiver.kernel.org>; Tue,  5 Apr 2022 21:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384353AbiDEVrJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Apr 2022 17:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345212AbiDEUVw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Apr 2022 16:21:52 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B727F1A383
        for <git@vger.kernel.org>; Tue,  5 Apr 2022 13:04:05 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id bg10so29027675ejb.4
        for <git@vger.kernel.org>; Tue, 05 Apr 2022 13:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Y4WzwX+yYczZvNPLDGsd5+RBWDjzt+yiKaUPGfUmGW4=;
        b=Nxn15sQORLcFBZoSvo+DEGsEudfUFXWfMKFymZwK7kn1MUULOBh15e/MG1HvZrXkN0
         yLcn7RPV/QFXBcHbaiHDlvV9VUB5lVZtbo/1hTP480bbd75P2N2xaRmF97c4kxDlokH5
         2eRQs9/dnpx8W9xYuZ1ZYhFOx8gHp9pFX/I6x3SYmg3rCzSd52Le9ZTajcSvO5RI9br7
         m55k+NYcnEa8PV2yt8HMwuzs1HBWAShB7GSDLEdpsYKMNXJ3EgzW2jrN8hIbrji+2T7i
         GB90Duo+4uZpzI6FU1iquwy1iHBd97RcotxSn9EIhkau3sGKO7rgP8y89ecs+e3c+Q88
         EWOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Y4WzwX+yYczZvNPLDGsd5+RBWDjzt+yiKaUPGfUmGW4=;
        b=dYvjLG8BkzXqsrHqLyc8YHQqfzIigmzh3hTNW+BB5sM+Lo63ZD++PoSTusB71lBxb/
         Y9S3zYwC2rwghlzMCTkFzsIxBYQ3fM2nP22OyvWisfr/PjpNx3UE3ku+lx+J3qWUtrWa
         JiMXgNP8Jhl2OgkTT+rmDHvHaXMQ9WKhBQotlLp2HiSs9pZXOV9HA3C3+UnCb/5Q8X/5
         1vaENsBdr+NT/aLLJHD3jeBedWbaH6GGl6qb0MZjIAQNEXKS2heaNzLBmUBYoGwIuUo7
         KiSJ9GlE2Ov5d3PRFKlnoogP8EEkeiSpTdYy6oELTsu1MQV6JC9guhWl7oNimb4YStL7
         Z39Q==
X-Gm-Message-State: AOAM530hF85uQUfdioFlPXbv3/eR/VbRFfKTULSRswOw1sy7+is679z2
        MxGG9+MKhJi/wjGj4P+kbOnplXIylrS01g==
X-Google-Smtp-Source: ABdhPJwNchnc2GitpW6VZZCNxg1pLa7E0NNPkGCLpL4Ct1uNz9anAQ5COc8Un/v7zqK8+hjPz6mjwg==
X-Received: by 2002:a17:907:1b0e:b0:6da:81ae:a798 with SMTP id mp14-20020a1709071b0e00b006da81aea798mr5177466ejc.699.1649189043867;
        Tue, 05 Apr 2022 13:04:03 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id i11-20020a05640242cb00b0041922d3ce3bsm7188974edc.26.2022.04.05.13.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 13:04:03 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nbpPG-000HE8-Nd;
        Tue, 05 Apr 2022 22:04:02 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org,
        gitster@pobox.com, Eric Sunshine <ericsunshine@gmail.com>
Subject: Re: Making the tests ~2.5x faster (was: [PATCH v3] test-lib.sh: Use
 GLIBC_TUNABLES instead of MALLOC_CHECK_ on glibc >= 2.34)
Date:   Tue, 05 Apr 2022 21:59:53 +0200
References: <20220304133702.26706-1-gitter.spiros@gmail.com>
 <975e203d-6bd3-f5ea-c21b-3e7518a04bb9@gmail.com>
 <220405.86k0c3lt2l.gmgdl@evledraar.gmail.com>
 <57c85e88-93af-acbe-f1ee-22c28dbec602@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <57c85e88-93af-acbe-f1ee-22c28dbec602@gmail.com>
Message-ID: <220405.86ilrnfgb1.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Apr 05 2022, Phillip Wood wrote:

> On 05/04/2022 11:03, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Mon, Apr 04 2022, Phillip Wood wrote:
>>=20
>>> On 04/03/2022 13:37, Elia Pinto wrote:
>>>> In glibc >=3D 2.34 MALLOC_CHECK_ and MALLOC_PERTURB_ environment
>>>> variables have been replaced by GLIBC_TUNABLES.  Also the new
>>>> glibc requires that you preload a library called libc_malloc_debug.so
>>>> to get these features.
>>>> Using the ordinary glibc system variable detect if this is glibc >=3D
>>>> 2.34 and
>>>> use GLIBC_TUNABLES and the new library.
>>>> This patch was inspired by a Richard W.M. Jones ndbkit patch
>>>> Helped-by: Junio C Hamano <gitster@pobox.com>
>>>> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
>>>> ---
>>>> This is the third version of the patch.
>>>> Compared to the second version[1], the code is further simplified,
>>>> eliminating a case statement and modifying a string statement.
>>>> [1] https://www.spinics.net/lists/git/msg433917.html
>>>>    t/test-lib.sh | 16 ++++++++++++++++
>>>>    1 file changed, 16 insertions(+)
>>>> diff --git a/t/test-lib.sh b/t/test-lib.sh
>>>> index 9af5fb7674..4d10646015 100644
>>>> --- a/t/test-lib.sh
>>>> +++ b/t/test-lib.sh
>>>> @@ -550,9 +550,25 @@ else
>>>>    	setup_malloc_check () {
>>>>    		MALLOC_CHECK_=3D3	MALLOC_PERTURB_=3D165
>>>>    		export MALLOC_CHECK_ MALLOC_PERTURB_
>>>> +		if _GLIBC_VERSION=3D$(getconf GNU_LIBC_VERSION 2>/dev/null) &&
>>>> +		_GLIBC_VERSION=3D${_GLIBC_VERSION#"glibc "} &&
>>>> +		expr 2.34 \<=3D "$_GLIBC_VERSION" >/dev/null
>>>> +		then
>>>> +			g=3D
>>>> +			LD_PRELOAD=3D"libc_malloc_debug.so.0"
>>>
>>> When compiling with "SANITIZE =3D address,leak" this use of LD_PRELOAD
>>> makes the tests fail with
>>>
>>> =3D=3D9750=3D=3DASan runtime does not come first in initial library lis=
t; you
>>> should either link runtime to your application or manually preload it
>>> with LD_PRELOAD.
>>>
>>> because libc_malloc_debug.so is being loaded before libasan.so. If I
>>> set TEST_NO_MALLOC_CHECK=3D1 when I run the tests then ASAN does not
>>> complain but it would be nicer if I did not have to do that. I'm
>>> confused as to why the CI leak tests are running fine - am I missing
>>> something with my setup?
>> Perhaps they have an older glibc? They're on Ubunt, and e.g. my
>> Debian
>> version is on 2.33.
>
> Good point, I'd not realized quite how new glibc 2.34 was
>
>> But more generally, I'd somehow managed to not notice for all my time in
>> hacking on git (including on SANITIZE=3Dleak, another tracing mode!) that
>> this check was being enabled *by default*, which could have saved me
>> some time waiting for tests...:
>>=20=09
>> 	$ git hyperfine -L rev HEAD~0 -L off yes, -s 'make CFLAGS=3D-O3' '(cd t=
 && TEST_NO_MALLOC_CHECK=3D{off} ./t3070-wildmatch.sh)' --warmup 1 -r 3
>> 	Benchmark 1: (cd t && TEST_NO_MALLOC_CHECK=3Dyes ./t3070-wildmatch.sh)'=
 in 'HEAD~0
>> 	  Time (mean =C2=B1 =CF=83):      4.191 s =C2=B1  0.012 s    [User: 3.6=
00 s, System: 0.746 s]
>> 	  Range (min =E2=80=A6 max):    4.181 s =E2=80=A6  4.204 s    3 runs
>>=20=09
>> 	Benchmark 2: (cd t && TEST_NO_MALLOC_CHECK=3D ./t3070-wildmatch.sh)' in=
 'HEAD~0
>> 	  Time (mean =C2=B1 =CF=83):      5.945 s =C2=B1  0.101 s    [User: 4.9=
89 s, System: 1.146 s]
>> 	  Range (min =E2=80=A6 max):    5.878 s =E2=80=A6  6.062 s    3 runs
>>=20=09
>> 	Summary
>> 	  '(cd t && TEST_NO_MALLOC_CHECK=3Dyes ./t3070-wildmatch.sh)' in 'HEAD~=
0' ran
>> 	    1.42 =C2=B1 0.02 times faster than '(cd t && TEST_NO_MALLOC_CHECK=
=3D ./t3070-wildmatch.sh)' in 'HEAD~0'
>> I.e. I get that it's catching actual issues, but I was also doing
>> runs
>> with SANITIZE=3Daddress, which I believe are going to catch a superset of
>> issues that this check does, so...
>
> I assumed SANITIZE=3Daddress would catch a superset of issues as well
> but I haven't actually checked the glibc tunables documentation. We
> disable MALLOC_PERTURB_ when running under valgrind so perhaps we
> should do the same when compiling with SANITIZE=3Daddress.

I'm not sure either, but given how exhaustive SANITIZE=3Daddress is I'd be
surprised if not.

> I just noticed that setup_malloc_check() is called by
> test_expect_success() and test_when_finished() so it really should be=20
> caching the result of the check rather than forking getconf and expr
> each time it is called. Overwriting LD_PRELOAD is not very friendly=20
> either, it would be better if it appended the debug library if the
> variable is already set.

We really should just be checking this when building, we even have C
code already that detects glibc and its version, I have some local (but
semi-unrelated) patches. Anyway...

>> Whatever we do with this narrow patch it would be a really nice
>> improvement if the test-lib.sh could fold all of these
>> "instrumentations" behind a single flag, and that both it and "make
>> test" would make it clear that you're testing in a slower "tracing" or
>> "instrumentation" mode.
>> Ditto things like chain lint and the bin-wrappers, e.g.:
>
> I sometimes wish there was a way to only chain lint the tests that
> have changed since the last run.

Mm, perhaps some make-based solution... :)

I had some experiments to go even further, and have "make test" only run
the tests relevant to the code that just changed, which with trace2's
filenames and GCC/clang's -MF option you can bridge that gap.

>>      $ git hyperfine -L rev HEAD~0 -L off yes, -L cl 0,1 -L nbw --no-bin=
-wrappers, -s 'make CFLAGS=3D-O3' '(cd t && GIT_TEST_CHAIN_LINT=3D{cl} TEST=
_NO_MALLOC_CHECK=3D{off} ./t3070-wildmatch.sh {nbw})' -r 1
>>      [...]=09
>> 	Summary
>> 	  '(cd t && GIT_TEST_CHAIN_LINT=3D0 TEST_NO_MALLOC_CHECK=3Dyes ./t3070-=
wildmatch.sh --no-bin-wrappers)' in 'HEAD~0' ran
>> 	    1.23 times faster than '(cd t && GIT_TEST_CHAIN_LINT=3D0 TEST_NO_MA=
LLOC_CHECK=3Dyes ./t3070-wildmatch.sh )' in 'HEAD~0'
>> 	    1.30 times faster than '(cd t && GIT_TEST_CHAIN_LINT=3D1 TEST_NO_MA=
LLOC_CHECK=3Dyes ./t3070-wildmatch.sh --no-bin-wrappers)' in 'HEAD~0'
>> 	    1.54 times faster than '(cd t && GIT_TEST_CHAIN_LINT=3D1 TEST_NO_MA=
LLOC_CHECK=3Dyes ./t3070-wildmatch.sh )' in 'HEAD~0'
>> 	    1.63 times faster than '(cd t && GIT_TEST_CHAIN_LINT=3D0 TEST_NO_MA=
LLOC_CHECK=3D ./t3070-wildmatch.sh --no-bin-wrappers)' in 'HEAD~0'
>> 	    1.87 times faster than '(cd t && GIT_TEST_CHAIN_LINT=3D0 TEST_NO_MA=
LLOC_CHECK=3D ./t3070-wildmatch.sh )' in 'HEAD~0'
>> 	    1.92 times faster than '(cd t && GIT_TEST_CHAIN_LINT=3D1 TEST_NO_MA=
LLOC_CHECK=3D ./t3070-wildmatch.sh --no-bin-wrappers)' in 'HEAD~0'
>> 	    2.24 times faster than '(cd t && GIT_TEST_CHAIN_LINT=3D1 TEST_NO_MA=
LLOC_CHECK=3D ./t3070-wildmatch.sh )' in 'HEAD~0'
>> I.e. between this, chain lint and bin wrappers we're coming up on
>> our
>> tests running almost 3x as slow as they otherwise could *by default*.
>> But right now knowing which things you need to chase around to turn
>> off
>> if you're just looking to test the semantics of your code without all
>> this instrumentation is a matter of archane knowledge, I'm not even sure
>> I remembered all the major ones (I didn't know about this one until
>> today).
>
> That is quite a difference in run time - I wonder how much scope there
> is for optimizing some of these features like the chain-lint vs=20
> disabling them completely.

Per my series at
https://lore.kernel.org/git/cover-v2-00.25-00000000000-20220325T182534Z-ava=
rab@gmail.com/
I'd much rather see us go in the direction of mainly piggy-backing on CI
for such extended testing, and just having easy to use targets for "do
exhaustive tests please".

E.g. so you could run "make test-like-ci" or whatever, and it would do
all the N permutations we do in CI locally.



