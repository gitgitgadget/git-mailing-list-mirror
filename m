Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF20C433EF
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 21:54:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238863AbiBWVzU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 16:55:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbiBWVzT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 16:55:19 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E948A5045B
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 13:54:50 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id i11so225015eda.9
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 13:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=nTpzkHRZrn94iwphdAYVvw8V9qRGefH+iiUJKylOSsg=;
        b=pdpO4Wm+YgFqkp/0m87wnZL14BnfcnNTLXkVp3kt0xhp6QHC5hcI4GjUxGmLklVy/X
         IDmKdtF096GfI/mxdTUZmYWdK/vsyNlQ9WerIee8f4gwfVaI/XUg38CiiDCIHFTYLTnP
         yNZzAA9WZUCm19IU6tcgqWsm0WzEHuOLIkmAc+8ZfR1akv1wQfaNbeCcBUmBvckesgZi
         cTlWCg47gVMwM9FHcflZtiV6seprM3CoaGrikJGHNQ+WBqqZZ6xhuSjJSmbwZe4w0zH5
         ZLIEhaZlsSoJeMP7toPeXsTh7qXU/uagGtTHL8poq05Yz7dX6TiLjACULbbt2JzUeRgB
         fJMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=nTpzkHRZrn94iwphdAYVvw8V9qRGefH+iiUJKylOSsg=;
        b=omPUbhFojWKRlBrNsOiEAvxwobXYeyQ9u46qSeE5v0eyLEuoxEqeevxDZw2k4TMW13
         BlSqUbnExzoutJ0wyAdgI/w+lvra9+SKi1m5420m0yl+dsWK6xd3vAihnQt7NMtr5Ale
         f/4qhv0eQRCnvwZxzgbQ9mkZsPcCEjgvhMHTWui/l6yM2pHXiFbeNSlK7Gpt24Ljb5Au
         GDg4zKbr788+Ou6GBuHIGrM9YejF4qTTFfehF9bhssuvOSDPcwpIry5etbCY+dhFNmkW
         KLd5pSUf2Syw6p1ubyYJVqg5Ttqpw11+D8jPJVD8SFWv23X3+lsJwzmrM+8ULMuDW/dw
         D5gw==
X-Gm-Message-State: AOAM531Ic0mBJ1G+pqV2Wj1QeX5+AcijQpChwqDAAMAOHnD1nRxIcvEh
        RWtNZ91YFcF5fL922Sic0NA=
X-Google-Smtp-Source: ABdhPJz7ezmRx6/6kThsSHzl+QBd0np7RPFIeKY9n3T/D3VLBk50CI0zPjxjkCqyjIpN1l3Fj0An2g==
X-Received: by 2002:a05:6402:d64:b0:40f:3ef3:a160 with SMTP id ec36-20020a0564020d6400b0040f3ef3a160mr1364746edb.141.1645653289336;
        Wed, 23 Feb 2022 13:54:49 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id n25sm438427eds.89.2022.02.23.13.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 13:54:48 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nMzay-00035T-BP;
        Wed, 23 Feb 2022 22:54:48 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        John Cai <johncai86@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2 1/3] stash: add test to ensure reflog --rewrite
 --updatref behavior
Date:   Wed, 23 Feb 2022 22:50:02 +0100
References: <pull.1218.git.git.1645209647.gitgitgadget@gmail.com>
 <pull.1218.v2.git.git.1645554651.gitgitgadget@gmail.com>
 <6e136b62ca4588cc58f2cb59b635eeaf14e6e20d.1645554652.git.gitgitgadget@gmail.com>
 <220223.864k4q6jpr.gmgdl@evledraar.gmail.com> <xmqq4k4ptgsv.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqq4k4ptgsv.fsf@gitster.g>
Message-ID: <220223.86ley1b653.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 23 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> This test was already a bit broken in needing the preceding tests, but
>> it will break now if REFFILES isn't true, which you can reproduce
>> e.g. with:
>>
>>     ./t3903-stash.sh --run=3D1-16,18-50 -vixd
>>
>> Perhaps the least sucky solution to that is:
>>
>> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
>> index ec9cc5646d6..1d11c9bda20 100755
>> --- a/t/t3903-stash.sh
>> +++ b/t/t3903-stash.sh
>> @@ -205,13 +205,19 @@ test_expect_success 'drop stash reflog updates ref=
s/stash with rewrite' '
>>  	cat >expect <<-EOF &&
>>  	$(test_oid zero) $oid
>>  	EOF
>> -	test_cmp expect actual
>> +	test_cmp expect actual &&
>> +	>dropped-stash
>>  '
>
> If "git stash drop", invoked in earlier part of this test before the
> precontext, fails, then test_cmp would fail and we leave
> dropped-stash untouched, even though we did run "git stash drop"
> already.

Yes, that's an edge case that's exposed here, but which I thought wasn't
worth bothering with. I.e. if you get such a failure on test N getting
N+1 failing as well isn't that big of a deal.

The big deal is rather that we know we're adding a REFFILES dependency
to this, which won't run this at all, which will make the "stash pop"
below fail.

> Why does the next test need to depend on what has happened earlier?

They don't need to, and ideally wouldn't, but most of our test suite has
this issue already. Try e.g. running it with:

    prove t[0-9]*.sh :: --run=3D10-20 --immediate

And for this particular file running e.g. this on master:

    ./t3903-stash.sh --run=3D1-10,30-40

Will fail 7 tests in the 30-40 range.

So while it's ideal that we can combine tests with arbitrary --run
parameters, i.e. all tests would tear down fully, not depend on earlier
tests etc. we're really far from that being the case in practice.

So insisting on some general refactoring of this file as part of this
series seems a bit overzelous, which is why I'm suggesting the bare
minimum to expect and work around the inevitable REFFILES failure, as
Han-Wen is actively working in that area.

>>  test_expect_success 'stash pop' '
>>  	git reset --hard &&
>>  	git stash pop &&
>> -	test 9 =3D $(cat file) &&
>> +	if test -e dropped-stash
>> +	then
>> +		test 9 =3D $(cat file)
>> +	else
>> +		test 3 =3D $(cat file)
>> +	fi &&
>>  	test 1 =3D $(git show :file) &&
>>  	test 1 =3D $(git show HEAD:file) &&
>>  	test 0 =3D $(git stash list | wc -l)

