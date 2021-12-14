Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7315C433F5
	for <git@archiver.kernel.org>; Tue, 14 Dec 2021 12:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234048AbhLNMis (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Dec 2021 07:38:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234015AbhLNMir (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Dec 2021 07:38:47 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BFEC061574
        for <git@vger.kernel.org>; Tue, 14 Dec 2021 04:38:47 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id e3so63406365edu.4
        for <git@vger.kernel.org>; Tue, 14 Dec 2021 04:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=GOx7CDzwF70LFZ0nQaS0HXio7C8v9b1I9QfC/tpsPY4=;
        b=mB8Y2f2PVREMa8pFIEUmZmlJu+7yER/Bk3F6ZBrZDSZSlH+XpQ9s83pdm+SufjTnnU
         ZhyWcpsSLaluQsoPIy2JcDnuSQQ2AtEZd5ixFUd3QVgQ/k3VYg2N9G/vUuIBwKTJ2hj+
         7NVHCU/4s1RB2sNUMD9ZZwFIf5ncBobk063iqelQ67dhpB2201DjcoA4PTPaVCittJJF
         auVcf5cP7R2HFqQFm8oYETjwSmiFi0MD94MhzA/1yT90LrjgxrdEIAfZzLKARBcUb7tk
         t9EOAYdPByLikBzFTj7ly3xq18Avpa7fnmfLFHC21IJiLVUN3Qh/5IOjP5IWYhZZXhaT
         j4CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=GOx7CDzwF70LFZ0nQaS0HXio7C8v9b1I9QfC/tpsPY4=;
        b=wrs5hkArPfHwUZYNjDpXzyn6lXqg7KlaC8HWGqg/4ni0FT9AulvfM8DQ9iwl1fhuVm
         L/Yury9qNbVJ04lyzRiWCTrCOzizpOiLQgNph6lQjf4RpgtgdOAw/dkOomlJKz2tHju8
         lWPB2ffRb8E7OfclWdMPSg+bPJFsr2kt09HYCf8CjZlm7YMMbWLCqQIxguXVYBZAxFue
         MsqB34rhhyhS1C5dQXmqF4XlPvoyIV9HOrDi+ZSLvd/2WyHjzV3I1UTcIe9r/J9UJrJC
         YeXBik1ZEH45lOfUTQ0PZ8lHrmVF+kcqTJl+61NAnv8m86dUWNDxkFQkF2pDuuAjvGRn
         HA8A==
X-Gm-Message-State: AOAM533uOyiBGy6snfWXC+s1c1ItYZ45GtUjdGmBqyCJ8REYhK9OQ0eR
        Bhg3/0udD68UYzmfs/Jd2fw=
X-Google-Smtp-Source: ABdhPJyUjxYzX/xvMVHk3hYGstWBo0sR8yvdy7wWh/nLeQbrH+/w08RwHfnGzm50gM9YcGIz8w9oRw==
X-Received: by 2002:a17:907:972a:: with SMTP id jg42mr5607230ejc.398.1639485525684;
        Tue, 14 Dec 2021 04:38:45 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id v30sm1028131ejk.194.2021.12.14.04.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 04:38:45 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mx74u-0008iA-AK;
        Tue, 14 Dec 2021 13:38:44 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>
Subject: Re: [RFC PATCH] t/Makefile: use dependency graph for "check-chainlint"
Date:   Tue, 14 Dec 2021 13:34:53 +0100
References: <20211213063059.19424-6-sunshine@sunshineco.com>
 <RFC-patch-1.1-bb3f1577829-20211213T095456Z-avarab@gmail.com>
 <CAPig+cSFtpt6ExbVDbcx3tZodrKFuM-r2GMW4TQ2tJmLvHBFtQ@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <CAPig+cSFtpt6ExbVDbcx3tZodrKFuM-r2GMW4TQ2tJmLvHBFtQ@mail.gmail.com>
Message-ID: <211214.86tufbbbu3.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 14 2021, Eric Sunshine wrote:

> On Mon, Dec 13, 2021 at 5:09 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> On Mon, Dec 13 2021, Eric Sunshine wrote:
>> > Rather than running `chainlint` and `diff` once per self-test -- which
>> > may become expensive as more tests are added -- instead run `chainlint`
>> > a single time over all tests bodies collectively and compare the result
>> > to the collective "expected" output.
>>
>> I think that "optimizing" things like this is an anti-pattern. I.e. we
>> have N chainlint test files, and N potential outputs from that (ok or
>> not, and with/without error). If one of the chainlint tests changes
>> we'd like to re-run it, if not we can re-use an earlier run.
>
> As mentioned in a reply elsewhere, the commit message sells this as an
> optimization, but that's not the real reason for the change, which is
> that the rewritten `check-chainlint` target for the upcoming new
> chainlint really wants to have a composite file of the "test" input
> and a composite of the "expect" output. I didn't know how to sell that
> change in this preparatory patch series, so I weakly framed it as an
> optimization. The reason for making this a preparatory step is that it
> makes for a less noisy patch later on when the new chainlint is
> actually plugged into the `check-chainlint` target. At least, it was
> less noisy originally... in the final implementation, I think it ends
> up being noisy anyhow. So, maybe it makes sense to drop this patch
> altogether(?).

I think you should do whatever you think makes sense here, I was just
pointing out that alternate Makefile approach in case it was helpful.

>> This is something make's dependency logic is perfectly suited for, and
>> will be faster than any optimization of turning a for-loop into a
>> "sed" command we run every time, since we'll only need to "stat" a few
>> things to see that there's nothing to do.
>>
>> +BUILT_CHAINLINTTESTS =3D $(patsubst %,.build/%.actual,$(CHAINLINTTESTS))
>> +
>> +.build/chainlint:
>> +       mkdir -p $@
>> +
>> +$(BUILT_CHAINLINTTESTS): | .build/chainlint
>> +$(BUILT_CHAINLINTTESTS): .build/%.actual: %
>> +       $(CHAINLINT) <$< | \
>> +       sed -e '/^# LINT: /d' >$@ && \
>> +       diff -u $(basename $<).expect $@
>> +
>> +check-chainlint: $(BUILT_CHAINLINTTESTS)
>
> This sort of optimization makes sense (I think) even with the new
> chainlint preferring to see composite "test" and "expect" files rather
> than the individual files. The individual files would be prerequisites
> of the composite files, thus the composites would only be regenerated
> if the individual files change. And the composite files would be
> prerequisites of the `check-chainlint` target, so it would only run if
> the composite files change (or if chainlint itself changes).
>
> In fact, with the new chainlint checking all tests in all scripts at
> once, this technique should apply nicely to it, as well, since the
> names of test scripts (t????-*.sh) are fed to it as command-line
> arguments. Thus, the t????-*.sh files could be prerequisites of the
> chainlint rule which would use $? to check only test scripts which
> have changed since the previous run.

*nod*

> Having said all that, I don't think think the changes in this series
> or the upcoming new chainlint series make the situation any worse
> (Makefile-wise) than its current state, and the sort of optimizations
> discussed here can easily be made after those series land. (And, as my
> Git time is rather limited these days, I'd really like to focus on
> getting the core components landed.)

Sounds good to me. We have plenty of these "doesn't have deps" targets
(e.g. the check shell syntax one you noted), we can just fix/change them
some other time.
