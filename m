Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DD77211B3
	for <e@80x24.org>; Wed,  5 Dec 2018 14:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbeLEOBp (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Dec 2018 09:01:45 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46137 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727182AbeLEOBp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Dec 2018 09:01:45 -0500
Received: by mail-ed1-f65.google.com with SMTP id o10so17069001edt.13
        for <git@vger.kernel.org>; Wed, 05 Dec 2018 06:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=OcUsSAiMclbbNyxPMGPFZrlUd6kSwoIqZ4MiSTDboBk=;
        b=S+JcDVwXaWEnQiee9bUGih4TLNVYeE77MCk1rXscxYgpJLgrTYzxNCtTyLPzbFpuVn
         QvZ39Fcd5NnXqyWBNrxtn8r6JG6/PvnyF7MGj4nhbRJgVoTpbVbcxRGuNOyS/2pM6y4G
         bXacw8swVBe+gUnISvzUXywSZoqh5wVyYZIzdaEEMRHoYtITIhJBnR9XwwlrAY0JYZnT
         ffbEgU2TesPtqGRP/AyteYXVWSuLFSkcx546qOx7yWmvq9TvjFTuBpkmxM35kB79RJfb
         TcmwjJMWoWS9AHKv0VI83WxgbpqyvKqb/GYHJ8856/twqk9wc+1RSkJszP9uvIoA4oGc
         ggWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=OcUsSAiMclbbNyxPMGPFZrlUd6kSwoIqZ4MiSTDboBk=;
        b=ln4KR9tSq3pklS3k16cAqfq6lV+OZB2uaxhvYlwEiUiJf7oRwd6wK0I2ilGXpT92I4
         qVdjQzn0dVcq9lra+X0ywb61f6jN+ot4yLTG8Yd7bEiAuOia/ErGHHdjGHD72mHZ93jT
         Ckl5+aS0sd3jRaCIX0Hwyly108MCAEj6bTaAFvjn5j32LXvhQNpZ6+oxzZTq1r+qZehe
         go/Bk/i1W+LGWB306q+Pul9Mc5W6S+dOd3lai6+Ssu01Ag845850BYCzjh7BazvZcWk2
         y+qhKYKtZ3WW2oH1v3zcltb73kES2ca/mvTIToxgj/l1Z8bsLdc8dxoyn6c2CnxlFY8b
         xjow==
X-Gm-Message-State: AA+aEWaKQCHLbBmKInxF95ihsoTsFbaXtMFPkhrl+GMIK3cEAC3s89qZ
        Ei/x/Hr1L4nw3VcQyahRN7T7lFtQ
X-Google-Smtp-Source: AFSGD/XgcHCt6qcNDx94S+617B2aEqlLZ8mrSAye4i0AptTYQz78RcDjPRJYSDzfaYnYhwfYpuFnRQ==
X-Received: by 2002:a17:906:4e14:: with SMTP id z20-v6mr18218350eju.187.1544018503222;
        Wed, 05 Dec 2018 06:01:43 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id z6-v6sm3186355ejq.63.2018.12.05.06.01.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 06:01:42 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH 3/3] test-lib: add the '--stress' option to run a test repeatedly under load
References: <20181204163457.15717-1-szeder.dev@gmail.com> <20181204163457.15717-4-szeder.dev@gmail.com> <87muplyxfn.fsf@evledraar.gmail.com> <20181205120725.GK30222@szeder.dev>
User-agent: Debian GNU/Linux buster/sid; Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181205120725.GK30222@szeder.dev>
Date:   Wed, 05 Dec 2018 15:01:41 +0100
Message-ID: <87wooof4xm.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Dec 05 2018, SZEDER Gábor wrote:

> On Tue, Dec 04, 2018 at 07:11:08PM +0100, Ævar Arnfjörð Bjarmason wrote:
>> It's a frequent annoyance of mine in the test suite that I'm
>> e.g. running t*.sh with some parallel "prove" in one screen, and then I
>> run tABCD*.sh manually, and get unlucky because they use the same trash
>> dir, and both tests go boom.
>>
>> You can fix that with --root, which is much of what this patch does. My
>> one-liner for doing --stress has been something like:
>>
>>     perl -E 'say ++$_ while 1' | parallel --jobs=100% --halt-on-error soon,fail=1 './t0000-basic.sh --root=trash-{} -v'
>>
>> But it would be great if I didn't have to worry about that and could
>> just run two concurrent:
>>
>>     ./t0000-basic.sh
>>
>> So I think we could just set some env variable where instead of having
>> the predictable trash directory we have a $TRASHDIR.$N as this patch
>> does, except we pick $N by locking some test-runs/tABCD.Nth file with
>> flock() during the run.
>
> Is 'flock' portable?  It doesn't appear so.

Portable enough, and since it's just an alias for "grab lock atomically"
it can devolve into other more basic FS functions on systems that don't
have it.

>> Then a stress mode like this would just be:
>>
>>     GIT_TEST_FLOCKED_TRASH_DIRS=1 perl -E 'say ++$_ while 1' | parallel --jobs=100% --halt-on-error soon,fail=1 './t0000-basic.sh'
>
> This doesn't address the issue of TCP ports for various daemons.

Once we have a test ABCD and slot offset N (for a fixed size of N) we
can pick a port from that.

>> And sure, we could ship a --stress option too, but it wouldn't be
>> magical in any way, just another "spawn N in a loop" implementation, but
>> you could also e.g. use GNU parallel to drive it, and without needing to
>
> GNU 'parallel' may or may not be available on the platform, that's why
> I stuck with the barebones shell-loops-in-the-background approach.

Yes, my point is not that you should drop that part of your patch for
using GNU parallel, but just to demonstrate that we can get pretty close
to this for most tests with an external tool, and that it would make
this sort of thing work for concurrent tests without needing to decide
to concurrently test in advance.

>> decide to stress test in advance, since we'd either flock() the trash
>> dir, or just mktemp(1)-it.
>
> While 'mktemp' seems to be more portable than 'flock', it doesn't seem
> to be portable enough; at least it's not in POSIX.>

We are already relying on stuff like mktemp() being reliable for
e.g. the split index.

> And in general I'd prefer deterministic trash directory names.  If I
> re-run a failed test after fixing the bug, then currently the trash
> directory will be overwritten, and that's good.  With 'mktemp's junk
> in the trash direcory's name it won't be overwritten, and if my bugfix
> doesn't work, then I'll start accumulating trash directories and won't
> even know which one is from the last run.

In general you wouldn't need to set GIT_TEST_FLOCKED_TRASH_DIRS=1 and
would get the same monolithic trash names as now, and for something like
the flock() version it could use a job number as a suffix like your
patch does.
