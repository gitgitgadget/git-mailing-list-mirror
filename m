Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D78BC433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 12:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 525246109F
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 12:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351674AbhIHMKu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 08:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348035AbhIHMKt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 08:10:49 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5F7C061575
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 05:09:41 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id me10so3680089ejb.11
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 05:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=bWnegdTgL0WPH/el12Bh/PNZUAVTFvd8ng/r/VqT22M=;
        b=jtpC+GR6ZwSqfPgywlUs6Z91Z6faPZMpDv4zBeDP4cyXrnAwAd62RIj02R8sYJkaBr
         iboeciLK74NKMPMX8tID83Sgt0rR+1HI5wVcbLY2uYli3H6L2DQPa8nIUB1JbnL1CrpV
         z+ygjoK04s9xdTU7POmkrrLb+sOQ0Cfis3D7R92yib14gYlpin0VmNMFQCFKGDRTGwnQ
         YJrRJWTt+AWLw1eyFDek+VWjuvTnXKqxFGohu1RB/qtcST2tse6xIw06/7tIQo+++AgV
         2U7XcCTmsCoYdQlAApGocHN0zgAzlGczqgQjE5ItJOtjnWXOOehjX4HiNuD+NShZl01k
         fJUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=bWnegdTgL0WPH/el12Bh/PNZUAVTFvd8ng/r/VqT22M=;
        b=fFHRO1DutSZWRE4AvTX9WGJq6LBfMkPDd5DTnntil0uGyibxuMGTDaZyk57r+KT36f
         +BuBXQg5m1M+LqWMtnxRZUpfNPLMUx9CbMg0b2ZDmmopR2eiX8SL+O9rwpXSWRGYA6rL
         vVnkAcjxx3x9mHkBA7x4OwKH/M5XL2hSx53aFmAJfakd3vUzkY/IEvS0DngfrsqqQx4t
         SfQtZj5oBs2PwX3ou9wxT2ZA/XZP7tZ5h/cb7h9bcPmxCJmy/saMzrckp24T8OtPnjcH
         PF99wrl1umybpvh8xoc8HoFUVWZ7YdwaL7wCyGeNPibfpMwlstJYUpSSOfkZrd/Dk5h+
         0KVQ==
X-Gm-Message-State: AOAM532+2ijE+/aTarjgtPVKK4oqfIoABNYTr7j+Nl01fr1P0H2J18/t
        1diygPdKV+92mE/2QpFE6ak=
X-Google-Smtp-Source: ABdhPJxF2GXvSVve06DN9P+MU5zHcN1fHwBbnfQcFNkPpuM+znZmBR4Yw2UUNjrxzU97wLntAajfsA==
X-Received: by 2002:a17:906:c25a:: with SMTP id bl26mr3736763ejb.345.1631102979525;
        Wed, 08 Sep 2021 05:09:39 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id bj21sm954607ejb.42.2021.09.08.05.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 05:09:38 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Andrzej Hunt <andrzej@ahunt.org>,
        =?utf-8?B?TMOpbmHDr2M=?= Huard <lenaic@lhuard.fr>,
        Derrick Stolee <dstolee@microsoft.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH v5 0/3] add a test mode for SANITIZE=leak, run it in CI
Date:   Wed, 08 Sep 2021 14:03:30 +0200
References: <cover-v4-0.3-00000000000-20210907T151855Z-avarab@gmail.com>
 <cover-v5-0.3-00000000000-20210907T212626Z-avarab@gmail.com>
 <xmqq35qf72jp.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <xmqq35qf72jp.fsf@gitster.g>
Message-ID: <87sfyfgtfh.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 08 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> We can compile git with SANITIZE=3Dleak, and have had various efforts in
>> the past such as 31f9acf9ce2 (Merge branch 'ah/plugleaks', 2021-08-04)
>> to plug memory leaks, but have had no CI testing of it to ensure that
>> we don't get regressions. This series adds a GIT_TEST_* mode for
>> checking those regressions, and runs it in CI.
>>
>> Since I submitted v2 the delta between origin/master..origin/seen
>> broke even t0001-init.sh when run under SANITIZE=3Dleak, so this series
>> will cause test smoke on "seen".
>>
>> That failure is due to a bug in es/config-based-hooks [1] and the
>> hn/reftable topic, i.e. these patches are legitimately catching
>> regressions in "seen" from day 1.
>
> So is there a point in sending this out to the list, before sending
> fixes to these broken topic and making sure they get corrected?
>
> Because the CI does not "bisect" to tell us "ok, up to this point in
> 'seen', all the topics merged play well together", the overall
> effect in the bigger picture is that 'seen' with this series would
> cause CI to stay in failed state.
>
> For now, I'll keep this near the tip of 'seen'.

The breakages with it are in combination with:

    ab/config-based-hooks-base
    es/config-based-hooks
    hn/reftable

You've got v4 of ab/config-based-hooks-base, the v5 is at [1], but we've
been waiting on emily to re-roll hers on top. As noted in that E-Mail
I've got a working re-roll of it as
avar-nasamuffin/config-based-hooks-restart-3 in my repo.

That'll leave hn/reftable, which given [2] I thought you were planning
to eject, and wiht the number of fixups for it / the planned re-doing of
it by Han-Wen[3] maybe it's better to do that now?

What do you think about that plan?

I.e. ejecting hn/reftable while waiting on a re-roll, and either
ejecting es/config-based-hooks while waiting, or I can submit the
avar-nasamuffin/config-based-hooks-restart-3 I've got pending Emily's
own re-roll (which may or may not be different from that).

That along with picking up the v5 of my ab/config-based-hooks-base
should make "seen" pass with SANITIZE=3Dleak on these tests, unless
there's other just-introduced regressions. I tried re-building it a few
days ago, I haven't done that just now.

1. https://lore.kernel.org/git/cover-v5-00.36-00000000000-20210902T125110Z-=
avarab@gmail.com/
2. https://lore.kernel.org/git/xmqq4kaxe5dt.fsf@gitster.g/
3. https://lore.kernel.org/git/CAFQ2z_N8pUsp3cdBpybHBD-V9_1sARCZvSxr0UkMfcw=
CoQfCbw@mail.gmail.com/
