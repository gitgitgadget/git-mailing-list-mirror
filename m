Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C89C61DA4
	for <git@archiver.kernel.org>; Thu,  9 Feb 2023 08:24:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjBIIYZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Feb 2023 03:24:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjBIIYY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2023 03:24:24 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E6E37F39
        for <git@vger.kernel.org>; Thu,  9 Feb 2023 00:24:23 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-4cddba76f55so12098877b3.23
        for <git@vger.kernel.org>; Thu, 09 Feb 2023 00:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i1x8T0TzokkgREqSXiL75ScWOzqyXsIIRrVvRLquF0A=;
        b=De4LEXjsok+yGfoXpvIziJExQnFKVQSUw+0p22xvzxl5zyE6JK9MHj99nRRevO7NlS
         3WkgJS7dtCf5IClN1kMEwHE9Whj3FnVUR5hBG1wdb77+KytQr4k5q/uSXLhvzmyXENxL
         AM+QOc4GDXFj6W4q3ba6+AbXc96Aat50wAnskf5qimlJ0LoY6n4jciU+sgh2gYevhD/x
         TCPaJHN0PTpU3q0E7JQFMVJM2rzSzTbCxbEMdEfK4SGVClSPvAQFYCS2liizbuJzn41t
         6mrYpg1fU4+HZOnTope9gE9+Yd892FsgcRMnYKajpu+NLGL8jF9o+Lr5KDp+KeiGDYKq
         fd4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=i1x8T0TzokkgREqSXiL75ScWOzqyXsIIRrVvRLquF0A=;
        b=Amm6QLGw1UsiAXwxybKlKwtNyjWIEdBx6Z8y1fPdMXPiPhYkQSZzw/FhUS+UPvgr2n
         GaqgNANbUPfAMNMNRbUP7js3pYjHLCjNHiRclAbR/OvvVBk8IBdIlzYiX1yRyT6tRGpI
         1Qxkbp0noyDEkVKnrf+ylrOzCInQ4qkmIDx5wfq1IczwWQH54aZmf6kO8lnhg7tf9jDc
         wbtoAJ8LBrlE41AcuiTtizNz6Bg519SO6YzA8k9+h6nRTRbLTkT4Oo9PjI6RZcok3ymL
         f2gZUSxQ2l15xp4edi3dy/YmqCSN6uc8NcOIF/H0V2ODxY7O30yYq0VmdjDsOp0ywfxm
         IuPQ==
X-Gm-Message-State: AO0yUKWXHFLKAnsCI4o7W9PIe249AiN7bzrXSA9zNDsUMWaRre69I7lc
        BxHpj1xSlFB4geJ7jWnyCPct4hizvkrSpA==
X-Google-Smtp-Source: AK7set+KZKiRw1FK3WqJRlzH3KGkffyqwFmMNWWVEG7Cler49Yc69HJlzFtI/D/imOotW75pj1CZc+MC/W38Aw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a05:6902:1c2:b0:89c:b633:73a6 with SMTP
 id u2-20020a05690201c200b0089cb63373a6mr1039484ybh.365.1675931062398; Thu, 09
 Feb 2023 00:24:22 -0800 (PST)
Date:   Thu, 09 Feb 2023 16:24:14 +0800
In-Reply-To: <patch-v5-03.10-4a73151abde-20230207T154000Z-avarab@gmail.com>
Mime-Version: 1.0
References: <cover-v4-0.9-00000000000-20230202T131155Z-avarab@gmail.com>
 <cover-v5-00.10-00000000000-20230207T154000Z-avarab@gmail.com> <patch-v5-03.10-4a73151abde-20230207T154000Z-avarab@gmail.com>
Message-ID: <kl6lttzvw8k1.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v5 03/10] config API: add and use a "git_config_get()"
 family of functions
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

> We could have changed git_configset_get_value_multi() (and then
> git_config_get_value() etc.) to accept a "NULL" as a "dest" for all
> callers, but let's avoid changing the behavior of existing API
> users. Having an "unused" value that we throw away internal to
> config.c is cheap.
>
> A "NULL as optional dest" pattern is also more fragile, as the intent
> of the caller might be misinterpreted if he were to accidentally pass
> "NULL", e.g. when "dest" is passed in from another function.

Okay, I think I can buy this argument. In other words,
git_config_get_value() is only used to put the value in "*dest", so
"dest =3D NULL" is an error. This is by design, because it defends against
callers who are using it wrongly. If it accepted "NULL" to mean 'dest
will be ignored', we're creating possible hard-to-spot bugs because we
no longer error out early.

> This still leaves various inconsistencies and clobbering or ignoring
> of the return value in place. E.g here we're modifying
> configset_add_value(), but ever since it was added in [2] we've been
> ignoring its "int" return value, but as we're changing the
> configset_find_element() it uses, let's have it faithfully ferry that
> "ret" along.
>
> Let's also use the "RESULT_MUST_BE_USED" macro introduced in [3] to
> assert that we're checking the return value of
> configset_find_element().
>
> We're leaving the same change to configset_add_value() for some future
> series. Once we start paying attention to its return value we'd need
> to ferry it up as deep as do_config_from(), and would need to make
> least read_{,very_}early_config() and git_protected_config() return an
> "int" instead of "void". Let's leave that for now, and focus on
> the *_get_*() functions.
>
> In a subsequent commit we'll fix the other *_get_*() functions to so
> that they'll ferry our underlying "ret" along, rather than normalizing
> it to a "return 1". But as an intermediate step to that we'll need to
> fix git_configset_get_value_multi() to return "int", and that change
> itself is smaller because of this change to migrate some callers away
> from the *_value_multi() API.

I haven't read ahead, but on first impression this sounds like it might
be too intrusive for a series whose goal is to clean up
*_get_value_multi().

> diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
> index 4be1ab1147c..7def7053e1c 100755
> --- a/t/t1308-config-set.sh
> +++ b/t/t1308-config-set.sh
> @@ -58,6 +58,8 @@ test_expect_success 'setup default config' '
>  		skin =3D false
>  		nose =3D 1
>  		horns
> +	[value]
> +		less
>  	EOF
>  '
> =20
> @@ -116,6 +118,45 @@ test_expect_success 'find value with the highest pri=
ority' '
>  	check_config get_value case.baz "hask"
>  '
> =20
> +test_expect_success 'return value for an existing key' '
> +	test-tool config get lamb.chop >out 2>err &&
> +	test_must_be_empty out &&
> +	test_must_be_empty err
> +'
> +
> +test_expect_success 'return value for value-less key' '
> +	test-tool config get value.less >out 2>err &&
> +	test_must_be_empty out &&
> +	test_must_be_empty err
> +'
> +
> +test_expect_success 'return value for a missing key' '
> +	cat >expect <<-\EOF &&
> +	Value not found for "missing.key"
> +	EOF
> +	test_expect_code 1 test-tool config get missing.key >actual 2>err &&
> +	test_cmp actual expect &&
> +	test_must_be_empty err
> +'
> +
> +test_expect_success 'return value for a bad key: CONFIG_INVALID_KEY' '
> +	cat >expect <<-\EOF &&
> +	Key "fails.iskeychar.-" is invalid
> +	EOF
> +	test_expect_code 1 test-tool config get fails.iskeychar.- >actual 2>err=
 &&
> +	test_cmp actual expect &&
> +	test_must_be_empty out
> +'
> +
> +test_expect_success 'return value for a bad key: CONFIG_NO_SECTION_OR_NA=
ME' '
> +	cat >expect <<-\EOF &&
> +	Key "keynosection" has no section
> +	EOF
> +	test_expect_code 1 test-tool config get keynosection >actual 2>err &&
> +	test_cmp actual expect &&
> +	test_must_be_empty out
> +'
> +

No real comments on the changes themselves. The added test coverage in
this version is quite nice.
