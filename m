Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61607C38159
	for <git@archiver.kernel.org>; Thu, 19 Jan 2023 00:28:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjASA2L (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 19:28:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbjASA2G (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 19:28:06 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2153C62D1F
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 16:28:04 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id m7-20020a170902db0700b00194bd3c810aso373122plx.23
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 16:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FpULzXU/1ijRcHjMaabL8D4bojURsErT0m0F7Hl/9F0=;
        b=ORkTJqx6a/Xt1QpYJ6zG41sNra/J3kyNVtHoZcufVynKtlB3IKbGJGin7HpGG+D+D8
         gntfTl1J7P8GubceQbT8eX/6yrO/d1459EGiRv1JWJPwtQJBozQrXmERElE9P8Qrd+qE
         ebzwy4C7NpD3Or2/C5u1fvz4P6GieqAONLklSh6/YzxSYBzwvMJ+9M4KDYgU+PD2YtC/
         w+D1nxUUQK0BdHj36Fdic48nuZPBaeUCyUxHBPQJIivZRVQ+4GyOhB82BjDFD07ysU4L
         EfUkgn4rlka3a1JyH2RycYZ4eE9lKNCQ83/Bo1x582aS/QNkshs0i5wJNhtvfcGlIXYI
         NyWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FpULzXU/1ijRcHjMaabL8D4bojURsErT0m0F7Hl/9F0=;
        b=Z2PRB3vt2072YS66ZVgzqMBACkN4NvyCHeBnp5Gs5/FJEV/sV117Il6eUdjQlAT3YX
         rUjsyf2D3Cpw5/Ub2c2Ww5/bputjKFM8sSTaB0U9f2iYWJya3J+tXtICbr0R2s0Q+JLp
         fgIzjlPoX5G83A0aun4jpFT2OQBz7AKf/0SG+EZhpjkqpqlD3Si9cMR0q8ff0yvMLung
         VNo7aB5wK1MdtP4bQP8dsHn5idbEMX5DLmWQmq6kBLNQ3FUAnzUcBq4sjGgjyWVxGmKe
         1eF2SnfL1YgJknpTmmz8rJgzJnbhMWguMK/SFU6xIdq5MNSRsoL/fL5fOvdApbZJvaEY
         FFpw==
X-Gm-Message-State: AFqh2kpfMd8srtCOspeIJMo8ljkQmH4f2nqY+ss2YaFXbKWGpKy3gr6W
        QKvNb50Rj4bcBnz+3GxevGekGEJ5IFoX6w==
X-Google-Smtp-Source: AMrXdXtpm8ExM07zxVf2ARIshkXVhhJkWQ3ZWgNTNXsRSjplK49TTEQ+zhK6qcG8Ps19NX3F8OF0WH31SnatPw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:aa7:9727:0:b0:58c:1d0d:f1a6 with SMTP id
 k7-20020aa79727000000b0058c1d0df1a6mr888404pfg.2.1674088083599; Wed, 18 Jan
 2023 16:28:03 -0800 (PST)
Date:   Wed, 18 Jan 2023 16:28:01 -0800
In-Reply-To: <patch-v3-3.9-14b08dfc162-20221125T093159Z-avarab@gmail.com>
Mime-Version: 1.0
References: <cover-v2-0.9-00000000000-20221101T225822Z-avarab@gmail.com>
 <cover-v3-0.9-00000000000-20221125T093158Z-avarab@gmail.com> <patch-v3-3.9-14b08dfc162-20221125T093159Z-avarab@gmail.com>
Message-ID: <kl6lfsc7nzam.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v3 3/9] config tests: add "NULL" tests for *_get_value_multi()
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

> A less well known edge case in the config format is that keys can be
> value-less, a shorthand syntax for "true" boolean keys. I.e. these two
> are equivalent as far as "--type=3Dbool" is concerned:
>
> 	[a]key
> 	[a]key =3D true
>
> But as far as our parser is concerned the values for these two are
> NULL, and "true". I.e. for a sequence like:
>
> 	[a]key=3Dx
> 	[a]key
> 	[a]key=3Dy
>
> We get a "struct string_list" with "string" members with ".string"
> values of:
>
> 	{ "x", NULL, "y" }
>
> This behavior goes back to the initial implementation of
> git_config_bool() in 17712991a59 (Add ".git/config" file parser,
> 2005-10-10).

I didn't know about this behavior before, actually. Thanks for the
explanation.

> When the "t/t1308-config-set.sh" tests were added in [1] only one of
> the three "(NULL)" lines in "t/helper/test-config.c" had any test
> coverage. This change adds tests that stress the remaining two.

I initially read this as testing that t/helper/test-config.c is doing
the right thing, which would be the antipattern of writing tests for our
tests.

During Review Club, you mentioned that the motivation was something
else, which IIRC is closer to exercising the internals of the configset
API, which makes sense to me, thought it would be helpful to clarify
that better in the commit message.

> +test_expect_success 'emit multi values from configset with NULL entry' '
> +	test_when_finished "rm -f my.config" &&
> +	cat >my.config <<-\EOF &&
> +	[a]key=3Dx
> +	[a]key
> +	[a]key=3Dy
> +	EOF
> +	cat >expect <<-\EOF &&
> +	x
> +	(NULL)
> +	y
> +	EOF
> +	test-tool config configset_get_value_multi a.key my.config >actual &&
> +	test_cmp expect actual
> +'

So if this meant to exercise configset_get_value_multi(), maybe it would
be even clearer to just say so in the test name, e.g.
'configset_get_value_multi with NULL entry'.

Side comment: by the end of the series, *_get_value_multi() has no
legitimate callers outside of config.c and the test code, and if we
remove it from config.h, this scenario wouldn't ever bother us in actual
`git` usage, but we probably still want to test for it since we want to
exercise the internals.
