Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9281C677F1
	for <git@archiver.kernel.org>; Thu, 19 Jan 2023 00:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjASAPr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 19:15:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjASAPp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 19:15:45 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9977051430
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 16:15:44 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id s14-20020a17090302ce00b00192d831a155so375115plk.11
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 16:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8vtS886Fszar2DU7yholHk38Y9sSRUXFv531iFW8omY=;
        b=pxcyNfI951ZmcquiNhTIdBiqnqBKLGCzGPMHk/EE9kJ+iXirnJghwmwmVmebkwV7yC
         +3htEECWBmqHFL3LtLwjyWOptcV1SMAKgOahLO+uyElnMz01OTKyIrCZCuFACjm4BwI3
         /QDKECKq/0Gxh6EThgxdVZbOnyQ10Aqi491bc4QD85qWHB3UDN5zjbcTIjBPTW3NYMCI
         tdrN+Q9S9kflc0LNB9YV2dxK2EhkMh92lmjDi0y52zxP98DaaMaXxPgvufXFlX0LaNpL
         5ZRhXHOZuycMzrQMEAOG1+uFcn144asqcGTZFGh4fS7NhJ7zma7h/DF9dhtbgQ8wWNRd
         MqCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8vtS886Fszar2DU7yholHk38Y9sSRUXFv531iFW8omY=;
        b=dzOZEZOBHGJKjsG54jr8612i3sccbi+G/MnYU6uaoNyiOZlmJBy5cSJwluDdh5XFSC
         IYfVIrHdc3vrYSbQGjA9+C/bT3OFSKYtlF7IT0/IlOT3BBnN0GV0120sc4CH+7bvNnao
         AQPjBMG0zFwpka5GGGUeKAL6/YEVtCgHvdMRs2ic/dNzMrIMgkdbSJuFyQhPvfqcrASx
         LBG3oi+xpjQv8iHj6Anc5q99/Hq3v01pk3os1BIvFgLqEKTMOlkGhIBMTT7+pjcvE3Xl
         zdoxK15nf5KTbqWfbmdwlWRm+iwYbLBDmI+gBUcJrGLhcunVutaxBQ4bIddRyA5X5ATW
         +M5g==
X-Gm-Message-State: AFqh2kqgeMDseYu4PTfpTNm2Oa3ll4sT/5P4B8UjlfUTkvaP4bBm9HdU
        tZ3kavHWFsSjhVIZwr6EP1X1Wfb4XaumaA==
X-Google-Smtp-Source: AMrXdXsbwMibme4oN8BRbS38k2UX5OSOKtlGUvokdRcphSsmAl0GfkOkV7BsHRI5/LnCBP5xnDCR0hdA8V6DJA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:1a54:b0:58b:c90f:5f1d with SMTP
 id h20-20020a056a001a5400b0058bc90f5f1dmr853112pfv.31.1674087344025; Wed, 18
 Jan 2023 16:15:44 -0800 (PST)
Date:   Wed, 18 Jan 2023 16:15:42 -0800
In-Reply-To: <patch-v3-2.9-3eb8da6086d-20221125T093159Z-avarab@gmail.com>
Mime-Version: 1.0
References: <cover-v2-0.9-00000000000-20221101T225822Z-avarab@gmail.com>
 <cover-v3-0.9-00000000000-20221125T093158Z-avarab@gmail.com> <patch-v3-2.9-3eb8da6086d-20221125T093159Z-avarab@gmail.com>
Message-ID: <kl6lilh3nzv5.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v3 2/9] config tests: cover blind spots in
 git_die_config() tests
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        "SZEDER =?utf-8?Q?G=C3=A1bor?=" <szeder.dev@gmail.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason         <avarab@gmail.com> writes:

> There were no tests checking for the output of the git_die_config()
> function in the config API, added in 5a80e97c827 (config: add
> `git_die_config()` to the config-set API, 2014-08-07). We only tested
> "test_must_fail", but didn't assert the output.

It wasn't immediately obvious to me why this was relevant to this
series; but reading ahead to 5/9 shows that git_die_config() is a caller
of a *_get_value_multi() function that we are changing, so we want to
assert on the output so that we know that git_die_config() is still
doing the right thing (since test_must_fail alone won't tell us whether
we introduced bugs in git_die_config()).

Might be good to include that extra context, but I don't feel strongly
about it.
