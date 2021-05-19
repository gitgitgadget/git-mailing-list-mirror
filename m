Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D2AC433ED
	for <git@archiver.kernel.org>; Wed, 19 May 2021 11:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B5396135B
	for <git@archiver.kernel.org>; Wed, 19 May 2021 11:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351946AbhESLku (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 07:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351960AbhESLkr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 07:40:47 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77FCFC061761
        for <git@vger.kernel.org>; Wed, 19 May 2021 04:39:26 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id a25so14937435edr.12
        for <git@vger.kernel.org>; Wed, 19 May 2021 04:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=RUbBWuHR+flEKgJxYH3y5nIMqssk+rSQG60vUnsFv3M=;
        b=P5RjmrkNUGTgY/j+grtD7EYcMbICYbgBYOrpRjqTHqZj1CQtUjf2g0afPagGV+y+sy
         aiVSTw5ORLkEhdEDYrbNmdNEHT3UKWyb5rTEDWSIyrOmqfM6S6CI5loooI1nWTywauRH
         Ci7vX55auSOP/LuGM+TKcBiCZs/pXqChPn2skASCHr9QshlaGUai0qj3uMy2A0KVHkGy
         l7UYIl6qjeHtBX5E5ZXenN+04wwAq+WBFLP23d5MiOkFXKFB8hHi02qwg/ocBb274FuJ
         lYkLtanhNDuOvaK3c8u3bMS+YxAc6HqllBEmdXbJR0xXdCdo/j3o5+Rmzl47J3VK1JLi
         UdrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=RUbBWuHR+flEKgJxYH3y5nIMqssk+rSQG60vUnsFv3M=;
        b=QWLPGwu3/Ce63HLvUI12xRc3VLjN37W561pI65O/C7VEKCCqTAJ3FfcbC7EtVgC0MH
         D5iFtyvDquUxAbp4Qt2nSR9kkdjU8FCkt1lr8/7FTjff/fOI2P0eJloQdBpFpmXqCcFO
         /JWyBcgWMN6oD0pjTR3hyLc/5BaQMcvEiY1ZkfxLEO41joga9Nz+R6uHZ3/7UTcYBzgC
         x4yS7al64Pfr8cyQbKu2lnVet9Ws6HZ2p2z6ylRGxzoNztQN9Cewuaqg5iKH3zdVdCFP
         Fu9rF5wo/2VUjbVCGkTL2fuqQ//2laF/m7z+CxlnXWlQmKo6A07j8dHefR4lScyUrVs9
         vodA==
X-Gm-Message-State: AOAM531ywkS+DA9PymoJbLW823P9n1u8qNkvW1/q74PIY2Ej3OGY4JZB
        vTmalCd4C7CNpVcVaK7khu0=
X-Google-Smtp-Source: ABdhPJyoW0a1mC2g/37AWwWpvmhf1O0Mpu8dB3mypGrMfbTZdrrhlLmKX0++uxM4FHURkc5ovaG/KA==
X-Received: by 2002:aa7:cb84:: with SMTP id r4mr13834561edt.187.1621424364998;
        Wed, 19 May 2021 04:39:24 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id gl20sm3739556ejb.5.2021.05.19.04.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 04:39:24 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
        Simon Ruderich <simon@ruderich.org>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v8 2/8] config: add new way to pass config via
 `--config-env`
Date:   Wed, 19 May 2021 13:36:17 +0200
References: <cover.1606214397.git.ps@pks.im>
 <cover.1610453228.git.ps@pks.im>
 <470396d36f938f0070b8c849a85b1a30949056e3.1610453228.git.ps@pks.im>
 <87o8eeteyz.fsf@evledraar.gmail.com>
 <YHqeh9MeRDADviU0@coredump.intra.peff.net>
 <87y2dd2pdn.fsf@evledraar.gmail.com>
 <YIKb7qoeLtGjgsHr@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <YIKb7qoeLtGjgsHr@coredump.intra.peff.net>
Message-ID: <87fsyjq7f8.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Apr 23 2021, Jeff King wrote:

> On Tue, Apr 20, 2021 at 12:59:16PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> >> It seems to me that having a skip_prefix_opt() or something would be a
>> >> good fix for this, i.e. a "maybe trim the last '=3D'" version of
>> >> skip_prefix. Then we could just consistently use that.
>> >
>> > There's a similar situation in the revision parser (which does not use
>> > our regular parse-options). There we have a parse_long_opt() helper
>> > which does the right thing. We could use that more widely.
>> >
>> > I also wouldn't be surprised if we could leverage one of the
>> > sub-functions of parse-options, but it might turn into a rabbit hole.
>> > Converting the whole thing to the usual parse_options() might get
>> > awkward, since many of the options operate at time-of-parse, not after
>> > we've seen everything (I suspect many of them don't care either way, b=
ut
>> > you're always risking subtle regressions there).
>>=20
>> So we could use parse_options() and guarantee the existing behavior if
>> they were all OPT_CALLBACK?
>
> I _think_ so, but the result might be quite hard to read (the logic
> would be scattered all over a bunch of tiny callbacks). But it might not
> be too bad. Especially if you figure out which ones actually need the
> time-of-parse logic and use more vanilla OPT_* for the others (that's
> the rabbit hole I alluded to).
>
> I think things like the "--exec-path" behavior that Patrick mentioned
> would still work (I think it's just a stock OPTARG).

[Mostly for my own future reference]: There's also the
parse_options_step() API to process options one at a time, which AFAICT
could be used in this case.

But having glanced at it again (but not come up with a patch) I think it
could be handled with OPT_CALLBACK + not caring about the order,
mostly. The "envchanged" could be passed as a custom flag probably...
