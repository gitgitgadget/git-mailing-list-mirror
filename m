Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C31C433FE
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 21:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234554AbhK3V5I (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 16:57:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232274AbhK3V5F (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 16:57:05 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32FD2C061574
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 13:53:45 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id x15so92553860edv.1
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 13:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=kCIrznHaM3IA2GggXdAL38e9foxOqFaTNOht9vDr15s=;
        b=mpcKSUVcNw87ESthkU++b4eWPdGeXVjl6tD4dkxoQuYgucRo8hsLm/m1Xj0o36E6Eb
         tevHXpd/zvMvU4TcZ+WKfzWnJ2GUffh5dFRKrkkqss8OvamoQi58SBmFYTCretiPc+gg
         oEC23q4Epwh/BlPfcqFdcXbxHaMFSJukPa7XUtVaIYIyA3F+XYTD4bWVCZQhmTU7ghm+
         B7i60o9NrI+3ox07hurrNOX9ldpDFmse5QYt8Tk7JN0jczayK4rzLNappd8R3OBIXXmE
         8dsiivYxYUyW+ZcW7Vd3RF3io6ZTm9MqZJFqadFS31sJ2KpsPNMyxnDY34jQXMiJj3W9
         lUDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=kCIrznHaM3IA2GggXdAL38e9foxOqFaTNOht9vDr15s=;
        b=SSoeH0ori2m7nVzU78Gw849rNjeM9m84L8Tz39qXMrnSE7Xc/nU/QMi7DGtZutco4H
         XGxSxQ3HrJXsCfzt/XekPWMtUS3lLTPcG3XXqaLtVPMcGlGkT4hM52B13xr2T+u8L12I
         j40GXXl70zM9iPhP/ZkocoD0DCvrsqEcrbBbKJ8a+jsZAynCTyr2UaBWwQEnxQSJbSec
         32OPNMHmQ1K9AzNpnqvHsVu9tshSzZ1SG+bOUoSSBXepnrBxqDnNMJE/ZDfDJSsz1TFB
         dobfdZaYH7EnDWtsmvkRlWpSNeFWfCgdvpcYyBok78cei4Jkxko3C+eiGlj32P9I8oRx
         z9Yw==
X-Gm-Message-State: AOAM531QTRFuet05j9Fw1Sp+ZxHqpucKjZ6LK0ac8RDkt5qfOjRd4HwC
        gCW+4mhJOVrkNlDQ8VcFEY0=
X-Google-Smtp-Source: ABdhPJzkLb1TsdjgJ89ocMJKnOK1hWp/qMuORjScBk306mZqzzJnwdwiTX7sg3saYdjFopmmUHmTbg==
X-Received: by 2002:a50:fc10:: with SMTP id i16mr2441416edr.84.1638309223615;
        Tue, 30 Nov 2021 13:53:43 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id d1sm12633472edn.56.2021.11.30.13.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 13:53:43 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1msB4I-001AuP-Kk;
        Tue, 30 Nov 2021 22:53:42 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] test-lib.sh: have all tests pass under "-x", remove
 BASH_XTRACEFD
Date:   Tue, 30 Nov 2021 22:50:04 +0100
References: <pull.1085.git.1638193666.gitgitgadget@gmail.com>
 <patch-1.1-9f735bd0d49-20211129T200950Z-avarab@gmail.com>
 <YaaS4Idhdyo2wZ9q@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <YaaS4Idhdyo2wZ9q@coredump.intra.peff.net>
Message-ID: <211130.86y255b995.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 30 2021, Jeff King wrote:

> On Mon, Nov 29, 2021 at 09:13:23PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> Once that's been removed we can dig deeper and see that we only have
>> "BASH_XTRACEFD" due to an earlier attempt to work around the same
>> issue. See d88785e424a (test-lib: set BASH_XTRACEFD automatically,
>> 2016-05-11) and the 90c8a1db9d6 (test-lib: silence "-x" cleanup under
>> bash, 2017-12-08) follow-up.
>>
>> I.e. we had redirection in "test_eval_" to get more relevant trace
>> output under bash, which in turn was only needed because
>> BASH_XTRACEFD=3D1 was set, which in turn was trying to work around test
>> failures under "set -x".
>>=20
>> It's better if our test suite works the same way on all shells, rather
>> than getting a passing run under "bash", only to have it fail with
>> "-x" under say "dash". As the deleted code shows this is much simpler
>> to implement across our supported POSIX shells.
>
> I'm mildly negative on dropping BASH_XTRACEFD. IMHO it is not worth the
> maintenance headache to have to remain vigilant against any shell
> function's stderr being examined, when there is single-line solution
> that fixes everything. Yes, the cost of using bash is high on some
> platforms, but "-x" is an optional feature (though I am sympathetic to
> people who are _surprised_ when "-x" breaks things, because it really is
> a subtle thing, and knowing "you should try using bash" is not
> immediately obvious).
>
> Some folks (like G=C3=A1bor) disagree and have done the work so far to ma=
ke
> sure that we pass even with "-x". But it feels like this is committing
> the whole project to that maintenance. I dunno.

I'd be fine with a hard dependency on bash, but that seems unlikely to
happen, and if that's not the case having these hybrid modes seems like
the worst of both worlds.

We already hard depend on -x working without BASH_XTRACEFD for all tests
except this one test don't we? I.e our CI runs with --verbose-log -x,
and t1510-repo-setup.sh was the only test that was turning it off, and
some of that runs with a /bin/sh of "dash".

Now when that test fails we'll get nice -x output like for every other
test, and AFAICT nothing else is changed by this patch, except the
obvious change of us not having to support these two modes anymore.
