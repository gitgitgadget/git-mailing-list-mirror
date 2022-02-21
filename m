Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE6A2C433FE
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 19:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbiBUTSk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 14:18:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232864AbiBUTSi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 14:18:38 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D51765BA
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 11:18:14 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id z22so31412617edd.1
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 11:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=QuYz9eI0CN05NZ5Zh5vl6caBzFA5bgma9K5PRAgXr20=;
        b=fR7oX2I+Thvd+rhSM8vYXTNwI8HoLYHuU0WFEXBeqC1ALHOWKC0LGMaB0vs5EGaiUF
         I7QuonbYF8uY5V7DkNcp28GBf3FrEsyVGBihUV8fg8af6ntim0h+rchv61qhDukgSTxW
         j4geqvdfg2ilFEWoRnhsePz9G06Vz0eNv/kGJZMZrhryCtQ6oJziWDHrIFtcAUvYw+T+
         7O9H4LgS77RGKrVc7DWo2JHdkze+k+z2DNqvP5DJT9/xOBkt/apTANxirGqoip4sMBQE
         bJ5TmIeUcXh3AvBEcYW/AOlnmXvvuCYkTqkKSADLdf8awxjLDG2mMcvZr6MTpHadQsa3
         /rvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=QuYz9eI0CN05NZ5Zh5vl6caBzFA5bgma9K5PRAgXr20=;
        b=N0ccHRIY7vKREUEZcJ/NxbOi5GKxrtXJNylMMLf+eZZyvVL8KzCOTBHu8vLVVU06ad
         P44uMF7yQFDxQJ5eNH7S8/+D+QZ/EoF7QhFslg8iNBC3qDQ83EhAup+Tqia1G4jQF7Ok
         0obFtBQ/B52qwNZaRGvSaGRkMXZEcqynuV1/s9YHj0eFkIxoPx371Ul27FiAvSBVi6bv
         ZHka3yt/qPn9TfeavEf7uoOQfzYpLA41UGbArYmDM4uObgfjN33poSeiDkAs5AvcDSGt
         Cg/2xzJ8+Gz4/Ecc2vYKa/MjV7LtQqWhoVAPneiPZwW+/MRvlWocvvdG0tz+cK/IX4OR
         FXhw==
X-Gm-Message-State: AOAM532MdcvKSW5IK5MTGQldE5933PkeKE1R/mn7aQLwVALRW1fiCFLe
        +eraZ/mDeUjB4ob8vwHqsDl6vkrdcFQDAw==
X-Google-Smtp-Source: ABdhPJwLWsDRYgK/HVzpa+YLYByjmKvm/Ft+psJHXtqVWSilEIog83Fl6svUc0ZshFQ0vcxUEPYXBw==
X-Received: by 2002:a05:6402:d08:b0:412:a33e:24fe with SMTP id eb8-20020a0564020d0800b00412a33e24femr23339204edb.281.1645471092413;
        Mon, 21 Feb 2022 11:18:12 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id gq1sm5465139ejb.58.2022.02.21.11.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 11:18:11 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nMECI-005lt7-Lt;
        Mon, 21 Feb 2022 20:18:10 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 4/4] test-lib: add "fast_unwind_on_malloc=0" to
 LSAN_OPTIONS
Date:   Mon, 21 Feb 2022 19:59:45 +0100
References: <cover-v2-0.4-00000000000-20220219T112653Z-avarab@gmail.com>
 <cover-v3-0.4-00000000000-20220221T155656Z-avarab@gmail.com>
 <patch-v3-4.4-d212009e517-20220221T155656Z-avarab@gmail.com>
 <YhPMt3HwSsErvM0l@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <YhPMt3HwSsErvM0l@nand.local>
Message-ID: <220221.864k4sav0t.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Feb 21 2022, Taylor Blau wrote:

> On Mon, Feb 21, 2022 at 04:58:35PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> Add "fast_unwind_on_malloc=3D0" to LSAN_OPTIONS to get more meaningful
>> stack traces from LSAN. This isn't required under ASAN which will emit
>> traces such as this one for a leak in "t/t0006-date.sh":
>>
>>     $ ASAN_OPTIONS=3Ddetect_leaks=3D1 ./t0006-date.sh -vixd
>>     [...]
>>     Direct leak of 3 byte(s) in 1 object(s) allocated from:
>>         #0 0x488b94 in strdup (t/helper/test-tool+0x488b94)
>>         #1 0x9444a4 in xstrdup wrapper.c:29:14
>>         #2 0x5995fa in parse_date_format date.c:991:24
>>         #3 0x4d2056 in show_dates t/helper/test-date.c:39:2
>>         #4 0x4d174a in cmd__date t/helper/test-date.c:116:3
>>         #5 0x4cce89 in cmd_main t/helper/test-tool.c:127:11
>>         #6 0x4cd1e3 in main common-main.c:52:11
>>         #7 0x7fef3c695e49 in __libc_start_main csu/../csu/libc-start.c:3=
14:16
>>         #8 0x422b09 in _start (t/helper/test-tool+0x422b09)
>>
>>     SUMMARY: AddressSanitizer: 3 byte(s) leaked in 1 allocation(s).
>>     Aborted
>>
>> Whereas LSAN would emit this instead:
>>
>>     $ ./t0006-date.sh -vixd
>>     [...]
>>     Direct leak of 3 byte(s) in 1 object(s) allocated from:
>>         #0 0x4323b8 in malloc (t/helper/test-tool+0x4323b8)
>>         #1 0x7f2be1d614aa in strdup string/strdup.c:42:15
>>
>>     SUMMARY: LeakSanitizer: 3 byte(s) leaked in 1 allocation(s).
>>     Aborted
>>
>> Now we'll instead git this sensible stack trace under
>> LSAN. I.e. almost the same one (but starting with "malloc", as is
>> usual for LSAN) as under ASAN:
>>
>>     Direct leak of 3 byte(s) in 1 object(s) allocated from:
>>         #0 0x4323b8 in malloc (t/helper/test-tool+0x4323b8)
>>         #1 0x7f012af5c4aa in strdup string/strdup.c:42:15
>>         #2 0x5cb164 in xstrdup wrapper.c:29:14
>>         #3 0x495ee9 in parse_date_format date.c:991:24
>>         #4 0x453aac in show_dates t/helper/test-date.c:39:2
>>         #5 0x453782 in cmd__date t/helper/test-date.c:116:3
>>         #6 0x451d95 in cmd_main t/helper/test-tool.c:127:11
>>         #7 0x451f1e in main common-main.c:52:11
>>         #8 0x7f012aef5e49 in __libc_start_main csu/../csu/libc-start.c:3=
14:16
>>         #9 0x42e0a9 in _start (t/helper/test-tool+0x42e0a9)
>>
>>     SUMMARY: LeakSanitizer: 3 byte(s) leaked in 1 allocation(s).
>>     Aborted
>
> This is great, by the way. I have often hit that bug in LSan and been
> incredibly frustrated by it. I'm happy to see it getting fixed here,
> thank you.

Cheers!

>> As the option name suggests this does make things slower, e.g. for
>> t0001-init.sh we're around 10% slower:
>>
>>     $ hyperfine -L v 0,1 'LSAN_OPTIONS=3Dfast_unwind_on_malloc=3D{v} mak=
e T=3Dt0001-init.sh' -r 3
>>     Benchmark 1: LSAN_OPTIONS=3Dfast_unwind_on_malloc=3D0 make T=3Dt0001=
-init.sh
>>       Time (mean =C2=B1 =CF=83):      2.135 s =C2=B1  0.015 s    [User: =
1.951 s, System: 0.554 s]
>>       Range (min =E2=80=A6 max):    2.122 s =E2=80=A6  2.152 s    3 runs
>>
>>     Benchmark 2: LSAN_OPTIONS=3Dfast_unwind_on_malloc=3D1 make T=3Dt0001=
-init.sh
>>       Time (mean =C2=B1 =CF=83):      1.981 s =C2=B1  0.055 s    [User: =
1.769 s, System: 0.488 s]
>>       Range (min =E2=80=A6 max):    1.941 s =E2=80=A6  2.044 s    3 runs
>>
>>     Summary
>>       'LSAN_OPTIONS=3Dfast_unwind_on_malloc=3D1 make T=3Dt0001-init.sh' =
ran
>>         1.08 =C2=B1 0.03 times faster than 'LSAN_OPTIONS=3Dfast_unwind_o=
n_malloc=3D0 make T=3Dt0001-init.sh'
>>
>> I think that's more than worth it to get the more meaningful stack
>> traces, we can always provide LSAN_OPTIONS=3Dfast_unwind_on_malloc=3D0 f=
or
>> one-off "fast" runs.
>
> I completely agree. I am almost always run ASan / LSan tests a single
> script at a time (often focusing on just one script that I know
> demonstrates some bug).
>
> At GitHub, we use both a sanitized and un-sanitized build when running
> CI. So we'll probably feel the effects a little more during the "run
> make test under a sanitized build" CI job, but we could easily set
> fast_unwind_on_malloc=3D0 if it becomes too big of a problem for us
> (though I suspect it won't matter in practice).

I suspect you mean SANITIZE=3Daddress not SANITIZE=3Dleak, i.e. ASAN not
LSAN. Note that the performance of the two is often quite different
(with ASAN starting out much slower).

I almost never use ASAN, but I've been using LSAN a lot.

I also haven't been able to have ASAN spew out these worse stack traces,
as noted in the commit message. But in some brief testing now if I were
setting fast_unwind_on_malloc=3D0 it would be around 15% slower:
=20=20=20=20
    $ hyperfine -L v 0,1 'ASAN_OPTIONS=3Dfast_unwind_on_malloc=3D{v} make T=
=3Dt0001-init.sh' -r 5
    Benchmark 1: ASAN_OPTIONS=3Dfast_unwind_on_malloc=3D0 make T=3Dt0001-in=
it.sh
      Time (mean =C2=B1 =CF=83):      3.264 s =C2=B1  0.014 s    [User: 2.4=
56 s, System: 0.927 s]
      Range (min =E2=80=A6 max):    3.249 s =E2=80=A6  3.282 s    5 runs
=20=20=20=20=20
    Benchmark 2: ASAN_OPTIONS=3Dfast_unwind_on_malloc=3D1 make T=3Dt0001-in=
it.sh
      Time (mean =C2=B1 =CF=83):      2.826 s =C2=B1  0.023 s    [User: 2.0=
08 s, System: 0.936 s]
      Range (min =E2=80=A6 max):    2.814 s =E2=80=A6  2.866 s    5 runs
=20=20=20=20=20
    Summary
      'ASAN_OPTIONS=3Dfast_unwind_on_malloc=3D1 make T=3Dt0001-init.sh' ran
        1.15 =C2=B1 0.01 times faster than 'ASAN_OPTIONS=3Dfast_unwind_on_m=
alloc=3D0 make T=3Dt0001-init.sh'

But I don't know in the ASAN case what, if anything, you're getting for
that reduction in performance.
