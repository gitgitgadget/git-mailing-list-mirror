Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00760C433ED
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 23:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC7D560FEE
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 23:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234757AbhDPXtE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Apr 2021 19:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbhDPXtD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Apr 2021 19:49:03 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18AF3C061574
        for <git@vger.kernel.org>; Fri, 16 Apr 2021 16:48:38 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id u17so44462630ejk.2
        for <git@vger.kernel.org>; Fri, 16 Apr 2021 16:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=m8H3f4PCDQaomYORuxssOboGui/H6OZHLCFus6egbs4=;
        b=oXbpfZDkYwJc3lE25Gxp/GPO3E4maF7ahhHjLLNHk2QViJXtEHofnRvqYdcvMg0zm5
         q343szatMxbO1QJouey+mXkgwEY+koTbbMy/xRpYwePqf27Hgm7Z+mDvKjF9/k0rYP1O
         +Vtu0Nwbvp7OX8t4+t/XZGj/BhUpcPGKBNpUuYGhqilOKoGxszuNqnbFhZiQzIzoRs6W
         1zPPltS2OGW87uMp+ArXnTXf283/XrnjQpmNQRGFCiwbzMeaUTeYWHlDS7PDoG1+jM4G
         +acFFPiazIpflCHfTil4QE/JTSvqwNJvzQiRU1UFH0J6ogjAh3te07MxTXK5YL7xgMgb
         M0Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=m8H3f4PCDQaomYORuxssOboGui/H6OZHLCFus6egbs4=;
        b=rlNBJ2IIq6v6y4JPVDQxgziyGQYw8vuTrSvynzMQ1NLVM4IYw9POIOOCeibK6qI69m
         IjdAi8jABhG/x1NLcfrxuKL9X/9npqqSQOpazPTbNFB/nESRI0SNVu6hhZ9GtmyNsNeC
         OX9o1YbVkkOeigHK7krrCex4sCzwBIJjeU/lJttESScBhc5D8gzcq4JkNwc7qUri5TV0
         BHDyVfe4B1ZNw0kmO4V2g7b02Uvu1SHS6jgV2K0+drPBUbnYqI1s3jHsKHNC7fI6TBvC
         ltTmYQYVBaagcgAMsURGsZIr0rVjwbfCKnSui0gf6wPZuDjW5ncFxB8J3S5Co6ev2dqi
         xdWQ==
X-Gm-Message-State: AOAM531OiasPeIMCQ+VPhSa7OsAUfYfiK/2tYsZqlB8fD/ULT9YMf6HE
        i1jmzbpEKB4jz0Apl+D7tw4=
X-Google-Smtp-Source: ABdhPJxp9zRSh5cITlh4bViVvLSd2ErHToOpW94a3J7WqQ06m/R05NDCIZOsRU2Jqi5M7TiV3Z+ezw==
X-Received: by 2002:a17:906:b01:: with SMTP id u1mr10936481ejg.310.1618616916800;
        Fri, 16 Apr 2021 16:48:36 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id mj3sm5084724ejb.3.2021.04.16.16.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 16:48:36 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 15/16] Revert and amend "test-lib-functions: assert
 correct parameter count"
References: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com>
 <patch-15.16-0cd511206c4-20210412T110456Z-avarab@gmail.com>
 <20210415220526.GO2947267@szeder.dev>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <20210415220526.GO2947267@szeder.dev>
Date:   Sat, 17 Apr 2021 01:48:35 +0200
Message-ID: <87tuo523l8.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Apr 16 2021, SZEDER G=C3=A1bor wrote:

> On Mon, Apr 12, 2021 at 01:09:04PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> This reverts and amends my my own e7884b353b7 (test-lib-functions:
>> assert correct parameter count, 2021-02-12) in order to improve the -x
>> output.
>>=20
>> When I added these BUG assertions in e7884b353b7 I missed that this
>> made the -x output much more verbose.
>>=20
>> E.g. for each test_cmp invocation we'd now emit:
>>=20
>>     + test_cmp expect actual
>>     + test 2 -ne 2
>>     + eval diff -u "$@"
>>     + diff -u expect actual
>>=20
>> That "test 2 -ne 2" line is new in e7884b353b7. As noted in
>> 45a2686441b (test-lib-functions: remove bug-inducing "diagnostics"
>> helper param, 2021-02-12) we had buggy invocations of some of these
>> functions with too many parameters.
>>=20
>> Let's instead use "$@" instead of "$1" to achieve the same ends with
>> no extra -x output verbosity. The "test" operator will die with an
>> error if given more than one argument in these contexts, so using "$@"
>> achieves the same goal.
>
> I prefer the current check for its explicitness over the implicit and
> somewhat cryptic approach introduced in this patch.

Fair enough, I think it's worth it to have a bit of a non-obvious pattern t=
here for less trace verbosity across the board.

> I hope that sooner or later I'll finish up my patch series to suppress
> '-x' output from test helper functions, and then this issue will
> become moot anyway.

That sounds like an interesting feature for those who want it, but it's
entirely orthagonal to the direction this patch is taking.

I'd like to have trace output for when tests descend into
test-lib-functions.sh and friends, I'd just like the most frequently
used code there to not be needlessly verbose.

That's not the same as wanting to hide it entirely, i.e. treat
test_path_is_file et al as though they were shell built-ins.
