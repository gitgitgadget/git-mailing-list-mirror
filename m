Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6289C433F5
	for <git@archiver.kernel.org>; Tue, 31 May 2022 08:07:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244704AbiEaIHQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 May 2022 04:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237948AbiEaIHP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 May 2022 04:07:15 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1CA4FC55
        for <git@vger.kernel.org>; Tue, 31 May 2022 01:07:13 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id gi33so25063216ejc.3
        for <git@vger.kernel.org>; Tue, 31 May 2022 01:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=Acr0QYppMT/fQ6WWGet4NWpmnmOl+OI5zfMk8ycbs8A=;
        b=UFsJq/7vsZZhKA/zSSN3Cxn5cg5esGKXT4L/ubJPLg6utoufiiMgehGXu0h74j+Xxo
         aUE6ByWwwPAYG27O1BLAk/AClI9p5+LEjhrtzaHwFPSbnr/iLyCgUk0paOeXCJLMGqLb
         PUky/hopVhDlcmAw7BveBplvvdOJNXZsBfHxyJmS1LDHvbbTe/GEdsi7DjjxzlJC5u37
         ACyf/JHfh/YNwX1tG3XYqNy4RbAVTY3ds3wMHU5xr7n+cWL83Ck8nYlpCIfNtchjZwhW
         w97p2+nWpWIXk7Rof8wu1QU8+BORzzbbVlozFN9IasRyerJR9AR4ti6XODFERwTdRECU
         zJoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=Acr0QYppMT/fQ6WWGet4NWpmnmOl+OI5zfMk8ycbs8A=;
        b=eyrdmIJBH1G7ciPDpL1eLViuf11dxjkjcUEyaR1WwSo4HOEQCTUSga9/PY/ekPohyZ
         6RTKdO8+qK4UFTr4MRKcojgHCV1Zy4NJbqOFKL/U+7pT59i3IIQKp3btQIWlqfDIMfJf
         f47iOqQrLti/8pn1e8SCd8x+taovXPTPNePNDXXXWHDO5D0UaACxRRGATdY8gBiR5VW2
         ljOnJUOg49gPp9PSuHJqP2BMyuAu4+VA5ND0sbmIYMFJhKOY2AhyfhejHrW0vDSa2SJK
         6GR8YD2irgICDwbAdxx5leqQ8PhOHjPY5oPXcBL/ZUqSaHZEI30XWuOWt1Qptlg7SmDQ
         gGjg==
X-Gm-Message-State: AOAM530y4oTaIJOWTKrwYywJkS6r4O4vU+a0AdYh71Gb0VDS0RM2Mk60
        W6zmTsuj49hSiQcKCozI03g=
X-Google-Smtp-Source: ABdhPJyyACxMmArD4xRFfZj52JGZ5Za3RkvtLd1fcEtNEh9HaTy7VzgaVSFKJP5hAJpO8WSzazaL6Q==
X-Received: by 2002:a17:907:3e15:b0:6fe:f10e:6337 with SMTP id hp21-20020a1709073e1500b006fef10e6337mr36010114ejc.209.1653984431866;
        Tue, 31 May 2022 01:07:11 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id h17-20020a05640250d100b0042bd6f745fasm8099867edb.92.2022.05.31.01.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 01:07:11 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nvwuE-000n82-QV;
        Tue, 31 May 2022 10:07:10 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: Side effects in Git's test suite, was Re: [PATCH] revert:
 optionally refer to commit in the "reference" format
Date:   Tue, 31 May 2022 10:03:42 +0200
References: <xmqqsfp2b30k.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2205231507350.352@tvgsbejvaqbjf.bet>
 <xmqq35gzn9vk.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2205301840410.349@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <nycvar.QRO.7.76.6.2205301840410.349@tvgsbejvaqbjf.bet>
Message-ID: <220531.86y1yi15xt.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, May 30 2022, Johannes Schindelin wrote:

> Hi Junio,
>
> On Mon, 23 May 2022, Junio C Hamano wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>
>> >> +test_expect_success 'identification of reverted commit (reference)' '
>> >> +	git checkout --detach to-ident &&
>> >> +	git revert --reference --no-edit HEAD &&
>> >> +	git cat-file commit HEAD >actual.raw &&
>> >> +	grep "^This reverts " actual.raw >actual &&
>> >> +	echo "This reverts commit $(git show -s --pretty=reference HEAD^)." >expect &&
>> >> +	test_cmp expect actual
>> >> +'
>> >
>> > If it was up to me, I would combine these three test cases, if only to
>> > help the `--run=<single-number>` case (the latter two depend on the
>> > side effect of the first one to create a `to-ident` tag).
>>
>> I wonder if our prereq infrastructure is lightweight and scalable enough
>> so that we can easily add a support a pseudo-prerequisite PREVIOUS that
>> lets us say
>>
>> 	test_expect_success PREVIOUS "identification ..." '
>> 		...
>> 	'
>>
>> to mean that this test requires the previous test has not been
>> skipped.
>
> In theory, this sounds good to me.
>
> In practice, however, side effects are awful and make everything harder,
> from developing code to debugging to helping new contributors. I wish we
> would do away with them altogether and have something more akin to the
> before/after constructs known from e.g. TestNG (think `@BeforeTest` and
> `@BeforeClass`).
>
> One option would be to mark `setup` steps completely differently, sort of
> imitating the prereq infrastructure instead of using
> `test_expect_success`. Kind of prereqs, but required to pass.

I've suggested a test_expect_setup before:
https://lore.kernel.org/git/8735vrvg39.fsf@evledraar.gmail.com/;
basically a test_expect_success that ignores GIT_SKIP_TESTS and --run.

I think that even if we could imagine much more complex relationships
(up to and including writing these tests as Makefiles instead) it's
better to just have the simpler "this is a setup".

Then for everything more complex be more eager to split up tests.

> This could potentially allow us to randomize the order in which the test
> cases are run, to identify and fix (unintended) side effects.

Yes, a "chaos monkey" mode similar to --stress would be nice.

> A complication is that we have nothing in the way of `@AfterClass`, i.e.
> we do not have a way to, say, run an Apache instance for the lifecycle of
> a given test script _and tear it down at the end_.

I think this is generally a feature in that if you find yourself needing
this you should split the test up so that the Apache setup is in only
one file.

E.g. in the case of some http tests we have a prereq on something for
git:// and a different thing (apache) for http:// tests, so that
depending on what combination you have we might end up needlessly
skipping tests.

> Another, rather obvious complication is that we have 17 years of commit
> history introducing side effects left and right :laughing:

