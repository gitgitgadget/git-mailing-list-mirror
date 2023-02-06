Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB4CC636D3
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 08:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjBFIb2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 03:31:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjBFIbZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 03:31:25 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D721ABCC
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 00:31:23 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id u8-20020a258408000000b00880a7cc9684so4823386ybk.13
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 00:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=17tQ4a7yIMUB8pUWFa4pSyj3SISoYH0zPzEuM7Yzfk4=;
        b=bKzvc3U3k+vtZBkewLd6eo7QfVRhz3k7w6924Rgb47tJ8Cdnp+oRnWEV77i+R2muIT
         YMkJ7WszQS4WcU0khxx0cE2PvnAatstqkSXk6TX5PcQPmsuAFHPFHPqyNFucdvPnyMK3
         Rgvfftw7dMK3tl1Es0ROzd8Tbugk8hQeh6QV85J0a2twX9H1O4EqXWfr/WPluv+4ojQs
         3WjyNBwEuJirllnWA4HqU8wArbxDqirG1BgzztUiDDpJcEF9bLjIuFgRehoi2nB+13Ta
         Rp9DoBaQoBXi/VfBPGJHK6Qc+qU71J9pBKPDWuf8vTtxmdqvuRDQsWhKylh0y/PHlCSO
         XIrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=17tQ4a7yIMUB8pUWFa4pSyj3SISoYH0zPzEuM7Yzfk4=;
        b=ts5yEPutfvFYIk+pTwucWT23K8j95NwkScSFo/yruuC8nH52F+9IW0sKslI60FuAlc
         J1MxaHX9VNOBvIqVHe20bhuLTIKsVpmLFJ4IrDMGRXl+//8Ww2dTBKF9KQmPHXG6L9AC
         GS15XGSNabte0vIwexTk2DoA6aHsB0V9l2lBwqiRE1BITL7n5j2pMi0l6oxMFfmu9dtD
         HpCSXnXX6PmLNOW0XPGOOlBIlb1KT2kVeLjazjVCHh2imaTcxHAQtpqoYj+F7eYWf68u
         WCBK7jV4m8s/60wXUZFRGfFAeBuP5R5NFQV2FvHOZpXZbfr8gok7ZFHn2dGYyyeznuVE
         eutg==
X-Gm-Message-State: AO0yUKXfBQUQ2KwL4yOJ5UQQgHbWK6Qmp7F0fnddxl6skAXoSFkRaj9r
        g3qsPzC/qqUMWsyOVYNWLG9qkaRyd7Ut4A==
X-Google-Smtp-Source: AK7set+tMtYZYm7og626ZiwYZZUEsXBWgHl5+JhNX6LqqjeV7F7KPMB3bX95kM7TeobapAD/ciZqEYkgTJvtrA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a0d:ef87:0:b0:524:3607:6034 with SMTP id
 y129-20020a0def87000000b0052436076034mr15ywe.7.1675672282450; Mon, 06 Feb
 2023 00:31:22 -0800 (PST)
Date:   Mon, 06 Feb 2023 16:31:13 +0800
In-Reply-To: <patch-v4-1.9-4ae56cab7c7-20230202T131155Z-avarab@gmail.com>
Mime-Version: 1.0
References: <cover-v3-0.9-00000000000-20221125T093158Z-avarab@gmail.com>
 <cover-v4-0.9-00000000000-20230202T131155Z-avarab@gmail.com> <patch-v4-1.9-4ae56cab7c7-20230202T131155Z-avarab@gmail.com>
Message-ID: <kl6l357ji4a6.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v4 1/9] config tests: cover blind spots in
 git_die_config() tests
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        "SZEDER =?utf-8?Q?G=C3=A1b?= =?utf-8?Q?or?=" <szeder.dev@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>, raymond@heliax.dev,
        zweiss@equinix.com,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> We need tests for this because a subsequent commit will alter the
> return value of git_config_get_value_multi(), which is used to get the
> config values in the git_die_config() function. This test coverage
> helps to build confidence in that subsequent change.

In v3, I recall having to read ahead quite far ahead in the series to
understand why we needed this patch. In comparison, this is a lot
clearer :)
