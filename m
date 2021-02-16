Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA40EC433DB
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 12:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93A9064DDA
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 12:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbhBPMFv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 07:05:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbhBPMCy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 07:02:54 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F5AC06178A
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 04:02:13 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id f14so16049391ejc.8
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 04:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=yJwfp06I6TFczKD5F1hbTqq1zjfV6RAE75tsp97vtug=;
        b=OMaNfFaKqi6QH4QRAX2reawsfQQURaFJe916PNy9stW1lETgELbBfEmx6vr45Zj59r
         JsAd7Wpz6pj+cxQzzo/+xnkYQKtxzPjxuT40JKx+Ewtc1+yhCHkDLN7O9TT2zchx2j4R
         fO0N5R3y7PwBrBMXtIXU7Kn3lkuR8HRg3uvVZhBCT9BT4dAwLdlRT5XuHC5Ho0hzvCqp
         rfXSwSPzbYhUJKUKBo/qpywrJS1x48fmKonSef787zwBfuPXxBfd6vKmyCw2D8AtKmQq
         VXAZeEezLbjcd67jn2tbqQsFoM9cANQr+pG12q3/YnGFWIgT19YR5RoPThEkKryPKRqV
         zi9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=yJwfp06I6TFczKD5F1hbTqq1zjfV6RAE75tsp97vtug=;
        b=dCh7wSVcoNBWrrIRyDa1lwCd9yGg5gQlJwtRy02aavEOunxJGkeENo3l6MeYJw5NTE
         ATuKjFaky0n3ohC1lP7TMlU3PpGZeDay4uBClXgimV+uXri78XLpI8Q6WVPM70jixDCA
         ZUsTPGs8CKMzCd2tJS5GlTJFepdleIzh/cNXAxLW8DQxNRT1dwrLP9kKdSDamubkXPtG
         Gr3jkvBDZyme4XG7zt5EFPD06Mzi0epJ6PZ/j094CbvtMq6dIenzBh06GxG4f2cMcmoP
         pnNP5VlF08XD+iDqKQ7quCDPyGYxEXxTykvCaofs8EQZe1KiEPXpJavNHB9QLviWIgHs
         4cAQ==
X-Gm-Message-State: AOAM532QxwkJxQYCdI5dfDOzZWVLXRdrcWzYR852y9gtD9y++GdPsNEF
        E+41cXTPbMBqtK3jG46+bU8RNs0BYP1xQQ==
X-Google-Smtp-Source: ABdhPJxT3hnY3stPvmE6MVT/rR5tR4BDtiC23nlSg/im3OCSOmAJviCxN2wGEa1cNtHOyWneL2TibQ==
X-Received: by 2002:a17:906:17d7:: with SMTP id u23mr20192573eje.390.1613476932674;
        Tue, 16 Feb 2021 04:02:12 -0800 (PST)
Received: from evledraar (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id gg15sm5056527ejb.86.2021.02.16.04.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 04:02:11 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>, dstolee@microsoft.com,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        peff@peff.net
Subject: Re: [PATCH 4/5] commit-graph: refactor dispatch loop for style
References: <87r1lhb6z7.fsf@evledraar.gmail.com>
 <20210215184118.11306-5-avarab@gmail.com> <YCrDGhIq7kU57p1s@nand.local>
 <4d0bd095-5593-33cc-4eec-24f06cc3cf2e@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <4d0bd095-5593-33cc-4eec-24f06cc3cf2e@gmail.com>
Date:   Tue, 16 Feb 2021 13:02:11 +0100
Message-ID: <87sg5w9q64.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 16 2021, Derrick Stolee wrote:

> On 2/15/2021 1:53 PM, Taylor Blau wrote:
>> On Mon, Feb 15, 2021 at 07:41:17PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 B=
jarmason wrote:
>>> I think it's more readable to have one if/elsif/else chain here than
>>> the code this replaces.
>>=20
>> FWIW, I find the pre-image more readable than what you are proposing
>> replacing it with here.
>>=20
>> Of course, I have no doubts about the obvious correctness of this patch;
>> I'm merely suggesting that I wouldn't be sad to see us apply the first
>> three patches, and the fifth patch, but drop this one.
>
> I agree with all of your points here. I think that compared to the
> current code at-rest, the new version might be preferred. It's a little
> dense, which is my only complaint.
>
> The issue comes for the future: what if we need to add a third verb
> to 'git commit-graph'? Then extending this new option looks worse since
> we would check 'argc' three times.
>
> The other patches solve real readability problems or reorganize the code
> to use other concepts within the codebase. This one is much more optional.

What do you think about
https://lore.kernel.org/git/874kidapv7.fsf@evledraar.gmail.com/ ? :)
