Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1917DC433ED
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 08:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D00516143D
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 08:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237496AbhDUIqo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 04:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237188AbhDUIqo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 04:46:44 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6162C06174A
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 01:46:10 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id x12so41575096ejc.1
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 01:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=uY8kl11lg61hlcao79fJxRk+rNPR5QI+lvfoQMAzGEM=;
        b=fXel8ea1rH4x1uyKCNf9UIAWw5Un6Zz3RU5p8NQwaz/rQHlqvjQ3dnVYNvkbfL6GZy
         GZjiH6MXj0XwZyWyU9W+tAsnoPPgxWBd/Mt9mnsFZn1CEsfxpFDr0TbjF2vmJv/lygxW
         hcWVa+4IyFhTuz9m1U8Oo6DMhioRl+vMXsaUeIXaQC8gMBxyAGAEvyeW5hOjvu7/J8mC
         0wogZpbtITHUs/CWXfGZyjz7dSClKP28sqyz0vxmw8pn6354IVFgK/MacBa0h7qh3tZM
         dABJpiXjYCAJJYcx68OOTMEkvJ+1A3Mkhrr7KHqgwIavJA89uKnkCKeU+mpu/MQtGoFX
         qytQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=uY8kl11lg61hlcao79fJxRk+rNPR5QI+lvfoQMAzGEM=;
        b=DPLl907hqrUKYF1WPWql8T2fhRUBdiF/5d2/5T4ILm4eGLUrUCfFIsXagFNhSbU74m
         RJXn3T14yrSnYMDiTq5lJSnz5dHswY/yTCVa8lCsUpFaz3NM7DRRI9GFQQOaBvR79CsP
         ByrBSdAc/twl6uri/EaZVqGT9IAcmAcRD9d39QaPMoFohmutKre36+SVR1cLqCtbOcty
         HRwPBRbYBK0L5S6zcXOuc2Yp4MwJpu/MhDoNlh7whsGHl7SWzjxTleCcHWOEva7gPrLA
         A/iVrV6xjwRXGuFRzoVp3ChFlpcfPY6lBgu6xSh/6q3of5MomiyflyDUVDBd+//N/WLd
         XwJA==
X-Gm-Message-State: AOAM532Ipbf+z8gXnavcSUoXmNrUbx86b0c8gYlY2PNA2mBNx7oh55V+
        dzQSSBHtwRgx6dIkeTaV2TDmGQHb8S9/Wg==
X-Google-Smtp-Source: ABdhPJx0BOeQ5L0ljnNb34Se7GTIG7J9V90kNKlO8G/lVzSL3QxU0oAjol5OzuPGbTRDyEImdoskPA==
X-Received: by 2002:a17:907:70d3:: with SMTP id yk19mr31502039ejb.108.1618994769395;
        Wed, 21 Apr 2021 01:46:09 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id l9sm1592664ejz.96.2021.04.21.01.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 01:46:08 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBD?= =?utf-8?B?w7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 01/12] check-non-portable-shell: check for "test
 <cond> -a/-o <cond>"
References: <cover-00.12-00000000000-20210417T124424Z-avarab@gmail.com>
 <cover-00.12-0000000000-20210420T121833Z-avarab@gmail.com>
 <patch-01.12-a8b483bc77-20210420T121833Z-avarab@gmail.com>
 <xmqqwnsw3872.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <xmqqwnsw3872.fsf@gitster.g>
Date:   Wed, 21 Apr 2021 10:46:08 +0200
Message-ID: <87r1j42ffz.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Apr 21 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> These will only match the simplistic forms of `test -X blah` (where
>> "-X" is some single letter option), but will miss expressions such as
>> `test "$foo" =3D bar`. We stop at "&" or "|" to try not to overmatch
>> things like:
>>
>>     test whatever && ls -a foo
>>     test whatever && foo -o outfile
>
> I still do not understand why you have to insist on dashed operator
> as the first thing given to "test", like this:
>
>> +	/\btest\s+-[a-z]\s+[^&|]+\s+-a\s+/ and err '"test A && test B" ...
>> +	/\btest\s+-[a-z]\s+[^&|]+\s+-o\s+/ and err '"test A || test B" ...
>
> IOW, what over-matching would we get if we simplified the condition
> like so?
>
>     /\btest\s+[^&|]+\s+-a\s/
>     /\btest\s+[^&|]+\s+-o\s/
>
> The one in the patch would miss things like
>
> 	test "$a" =3D "$b" -o "$a" -lt "$b"
> 	test "$n" -a "$n" -lt 4
>
> but the only thing that we care about is that a command that started
> with "test " has "-a" or "-o" before we see "&" or "|", no?

Applying your suggestion results in these false positives:
=09
	t4038-diff-combined.sh:135: error: "test A && test B" preferred to "test A=
 -a B": git commit -m "test space change" -a &&
	t4038-diff-combined.sh:147: error: "test A && test B" preferred to "test A=
 -a B": git commit -m "test other space changes" -a &&
	t6400-merge-df.sh:89: error: "test A || test B" preferred to "test A -o B"=
: test 0 -eq $(git ls-files -o | wc -l)
	t6400-merge-df.sh:91: error: "test A || test B" preferred to "test A -o B"=
: test 1 -eq $(git ls-files -o | wc -l)
	t6400-merge-df.sh:110: error: "test A || test B" preferred to "test A -o B=
": test 0 -eq $(git ls-files -o | wc -l)
	t6400-merge-df.sh:112: error: "test A || test B" preferred to "test A -o B=
": test 1 -eq $(git ls-files -o | wc -l)
	t6402-merge-rename.sh:639: error: "test A || test B" preferred to "test A =
-o B": test 0 -eq "$(git ls-files -o | wc -l)"
	t6402-merge-rename.sh:646: error: "test A || test B" preferred to "test A =
-o B": test 2 -eq "$(git ls-files -o | wc -l)"
	t6402-merge-rename.sh:686: error: "test A || test B" preferred to "test A =
-o B": test 0 -eq "$(git ls-files -o | wc -l)" &&
	t6402-merge-rename.sh:865: error: "test A || test B" preferred to "test A =
-o B": test 0 -eq $(git ls-files -o | wc -l) &&
	annotate-tests.sh:201: error: "test A && test B" preferred to "test A -a B=
": GIT_AUTHOR_NAME=3D"E" GIT_AUTHOR_EMAIL=3D"E at test dot git" git commit =
-a -m "norobots"

I'll just drop this from the re-roll of this series. Maybe you/someone
has a better suggestion for something that's simple but still catches
these cases, but in any case I'd like to not have this series blocked on
this minor thing (which none of the rest of it needs).
