Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3981C3527E
	for <git@archiver.kernel.org>; Tue,  5 Apr 2022 11:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238716AbiDELfC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Apr 2022 07:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349757AbiDELKE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Apr 2022 07:10:04 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834634A90C
        for <git@vger.kernel.org>; Tue,  5 Apr 2022 03:31:50 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id yy13so25795114ejb.2
        for <git@vger.kernel.org>; Tue, 05 Apr 2022 03:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=9Kb9x82BNpIOlHIVtn9VVu/7UA+TDcLVp5SIwaN8Nlw=;
        b=jpvQPRSZeW1LSxjQjtIWUL4HZC+e4gK7Xfbke+pROy35BlqE9NFAFs5uh+y5SngHPH
         X42QFmDpcE+2++pmOWIFBZLukRpykdAE0C6FPXoHEPBNqP0vqImGDxgxvl+uGZUZPwgz
         xnJtAsQX+8uLbAfVJ9Fy2+SGlz/bE6vluWFF7GcCjLAZCgeam7qO2AALjL43tTB7AhWE
         lvr8vox3rL0BVDj+pQNPq4CwuJyJxF59+fGiZHq+CoPYXbWlzRts2Mskwu06zZUmN+Uk
         7oGpdvuBL185sMAcyTzcsidCQbGeK4LMjSvuefsR43UkTCG0fUKTGcSJd1Z7BqnNUwKH
         CLVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=9Kb9x82BNpIOlHIVtn9VVu/7UA+TDcLVp5SIwaN8Nlw=;
        b=OXixnjYuJsskMSlby5Rli0P6gDcvC/b8Cfqn1ifbJjPjtCcWmP21UrlN1JBWz0icRL
         hgdLzDNgylU5GN1ExBwQHT6izkmPfRp8iLMC2GBidsoF8Y0ts6UZ9Otg1Z9so697L60r
         r0K/QZ/I/5nPoYvywIDDiAz8jwQ1UiygnCcC7Up5i3lYnwkfGbf2F1tVUod8Xw5flAlC
         ve3KTvxtMkBjmEz9xBayiZfxoCQ1jMiLKvHH0c79YM54Su/zlA4xq8WxEnJtZMwaPTFI
         wZY7y3TUvFa99ndkUw+l7z487uvseSXTZUjFsLm38NLi4k4qkoq3kMNVZfBp/p/HoSmK
         wMrA==
X-Gm-Message-State: AOAM532ufab3aQz/1iSJzUa9qadlgT9ta+88u+H0jVmp3K3PjPW2DH6U
        TTZiut0LzBNfkWB8d/geZkqVhIZKtED9CA==
X-Google-Smtp-Source: ABdhPJxSraWfojHnLiEJokXUMSo9KbywdL7IHklPx0NX7gMYbZ3gIiTqeg2+O7hrLf0EVJmrgMjAHw==
X-Received: by 2002:a17:906:69c5:b0:6cf:d164:8b32 with SMTP id g5-20020a17090669c500b006cfd1648b32mr2764814ejs.233.1649154708254;
        Tue, 05 Apr 2022 03:31:48 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id z23-20020a170906435700b006b0e62bee84sm5369889ejm.115.2022.04.05.03.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 03:31:47 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nbgTT-002tmJ-1f;
        Tue, 05 Apr 2022 12:31:47 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org,
        gitster@pobox.com, Eric Sunshine <ericsunshine@gmail.com>
Subject: Making the tests ~2.5x faster (was: [PATCH v3] test-lib.sh: Use
 GLIBC_TUNABLES instead of MALLOC_CHECK_ on glibc >= 2.34)
Date:   Tue, 05 Apr 2022 12:03:46 +0200
References: <20220304133702.26706-1-gitter.spiros@gmail.com>
 <975e203d-6bd3-f5ea-c21b-3e7518a04bb9@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <975e203d-6bd3-f5ea-c21b-3e7518a04bb9@gmail.com>
Message-ID: <220405.86k0c3lt2l.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Apr 04 2022, Phillip Wood wrote:

> On 04/03/2022 13:37, Elia Pinto wrote:
>> In glibc >=3D 2.34 MALLOC_CHECK_ and MALLOC_PERTURB_ environment
>> variables have been replaced by GLIBC_TUNABLES.  Also the new
>> glibc requires that you preload a library called libc_malloc_debug.so
>> to get these features.
>> Using the ordinary glibc system variable detect if this is glibc >=3D
>> 2.34 and
>> use GLIBC_TUNABLES and the new library.
>> This patch was inspired by a Richard W.M. Jones ndbkit patch
>> Helped-by: Junio C Hamano <gitster@pobox.com>
>> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
>> ---
>> This is the third version of the patch.
>> Compared to the second version[1], the code is further simplified,
>> eliminating a case statement and modifying a string statement.
>> [1] https://www.spinics.net/lists/git/msg433917.html
>>   t/test-lib.sh | 16 ++++++++++++++++
>>   1 file changed, 16 insertions(+)
>> diff --git a/t/test-lib.sh b/t/test-lib.sh
>> index 9af5fb7674..4d10646015 100644
>> --- a/t/test-lib.sh
>> +++ b/t/test-lib.sh
>> @@ -550,9 +550,25 @@ else
>>   	setup_malloc_check () {
>>   		MALLOC_CHECK_=3D3	MALLOC_PERTURB_=3D165
>>   		export MALLOC_CHECK_ MALLOC_PERTURB_
>> +		if _GLIBC_VERSION=3D$(getconf GNU_LIBC_VERSION 2>/dev/null) &&
>> +		_GLIBC_VERSION=3D${_GLIBC_VERSION#"glibc "} &&
>> +		expr 2.34 \<=3D "$_GLIBC_VERSION" >/dev/null
>> +		then
>> +			g=3D
>> +			LD_PRELOAD=3D"libc_malloc_debug.so.0"
>
> When compiling with "SANITIZE =3D address,leak" this use of LD_PRELOAD
> makes the tests fail with
>
> =3D=3D9750=3D=3DASan runtime does not come first in initial library list;=
 you
> should either link runtime to your application or manually preload it=20
> with LD_PRELOAD.
>
> because libc_malloc_debug.so is being loaded before libasan.so. If I
> set TEST_NO_MALLOC_CHECK=3D1 when I run the tests then ASAN does not
> complain but it would be nicer if I did not have to do that. I'm
> confused as to why the CI leak tests are running fine - am I missing
> something with my setup?

Perhaps they have an older glibc? They're on Ubunt, and e.g. my Debian
version is on 2.33.

But more generally, I'd somehow managed to not notice for all my time in
hacking on git (including on SANITIZE=3Dleak, another tracing mode!) that
this check was being enabled *by default*, which could have saved me
some time waiting for tests...:
=09
	$ git hyperfine -L rev HEAD~0 -L off yes, -s 'make CFLAGS=3D-O3' '(cd t &&=
 TEST_NO_MALLOC_CHECK=3D{off} ./t3070-wildmatch.sh)' --warmup 1 -r 3
	Benchmark 1: (cd t && TEST_NO_MALLOC_CHECK=3Dyes ./t3070-wildmatch.sh)' in=
 'HEAD~0
	  Time (mean =C2=B1 =CF=83):      4.191 s =C2=B1  0.012 s    [User: 3.600 =
s, System: 0.746 s]
	  Range (min =E2=80=A6 max):    4.181 s =E2=80=A6  4.204 s    3 runs
=09=20
	Benchmark 2: (cd t && TEST_NO_MALLOC_CHECK=3D ./t3070-wildmatch.sh)' in 'H=
EAD~0
	  Time (mean =C2=B1 =CF=83):      5.945 s =C2=B1  0.101 s    [User: 4.989 =
s, System: 1.146 s]
	  Range (min =E2=80=A6 max):    5.878 s =E2=80=A6  6.062 s    3 runs
=09=20
	Summary
	  '(cd t && TEST_NO_MALLOC_CHECK=3Dyes ./t3070-wildmatch.sh)' in 'HEAD~0' =
ran
	    1.42 =C2=B1 0.02 times faster than '(cd t && TEST_NO_MALLOC_CHECK=3D .=
/t3070-wildmatch.sh)' in 'HEAD~0'

I.e. I get that it's catching actual issues, but I was also doing runs
with SANITIZE=3Daddress, which I believe are going to catch a superset of
issues that this check does, so...

Whatever we do with this narrow patch it would be a really nice
improvement if the test-lib.sh could fold all of these
"instrumentations" behind a single flag, and that both it and "make
test" would make it clear that you're testing in a slower "tracing" or
"instrumentation" mode.

Ditto things like chain lint and the bin-wrappers, e.g.:

    $ git hyperfine -L rev HEAD~0 -L off yes, -L cl 0,1 -L nbw --no-bin-wra=
ppers, -s 'make CFLAGS=3D-O3' '(cd t && GIT_TEST_CHAIN_LINT=3D{cl} TEST_NO_=
MALLOC_CHECK=3D{off} ./t3070-wildmatch.sh {nbw})' -r 1
    [...]=09
	Summary
	  '(cd t && GIT_TEST_CHAIN_LINT=3D0 TEST_NO_MALLOC_CHECK=3Dyes ./t3070-wil=
dmatch.sh --no-bin-wrappers)' in 'HEAD~0' ran
	    1.23 times faster than '(cd t && GIT_TEST_CHAIN_LINT=3D0 TEST_NO_MALLO=
C_CHECK=3Dyes ./t3070-wildmatch.sh )' in 'HEAD~0'
	    1.30 times faster than '(cd t && GIT_TEST_CHAIN_LINT=3D1 TEST_NO_MALLO=
C_CHECK=3Dyes ./t3070-wildmatch.sh --no-bin-wrappers)' in 'HEAD~0'
	    1.54 times faster than '(cd t && GIT_TEST_CHAIN_LINT=3D1 TEST_NO_MALLO=
C_CHECK=3Dyes ./t3070-wildmatch.sh )' in 'HEAD~0'
	    1.63 times faster than '(cd t && GIT_TEST_CHAIN_LINT=3D0 TEST_NO_MALLO=
C_CHECK=3D ./t3070-wildmatch.sh --no-bin-wrappers)' in 'HEAD~0'
	    1.87 times faster than '(cd t && GIT_TEST_CHAIN_LINT=3D0 TEST_NO_MALLO=
C_CHECK=3D ./t3070-wildmatch.sh )' in 'HEAD~0'
	    1.92 times faster than '(cd t && GIT_TEST_CHAIN_LINT=3D1 TEST_NO_MALLO=
C_CHECK=3D ./t3070-wildmatch.sh --no-bin-wrappers)' in 'HEAD~0'
	    2.24 times faster than '(cd t && GIT_TEST_CHAIN_LINT=3D1 TEST_NO_MALLO=
C_CHECK=3D ./t3070-wildmatch.sh )' in 'HEAD~0'

I.e. between this, chain lint and bin wrappers we're coming up on our
tests running almost 3x as slow as they otherwise could *by default*.

But right now knowing which things you need to chase around to turn off
if you're just looking to test the semantics of your code without all
this instrumentation is a matter of archane knowledge, I'm not even sure
I remembered all the major ones (I didn't know about this one until
today).
