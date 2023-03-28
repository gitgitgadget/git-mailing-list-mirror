Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB3FC76196
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 16:58:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbjC1Q62 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 12:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjC1Q60 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 12:58:26 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEDD1BDF2
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 09:58:25 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id o19-20020a17090ab89300b0023b3a5f0aa3so3483655pjr.9
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 09:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680022705;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JXfvGk9TMBkNKOHw8bvj8pVSmQNtUQsW3yfKe+TkhUs=;
        b=KzHvjSVQfJDi3abmRrFHgq4TizE2j9FEyVgaPNPs6BCkkRC/zhP+PB2UTtMT5DrM4u
         /gZQg0mpMwlRowYKRQIoRp9s4yR7NUmT/ZIyJQuy4a+Ypzs+llr3B/Yin64oD8DGcB9o
         yf0/SbJ3BK7TtvotmXncYKzu4852GzeN/QfI9N2ZuJA5KUvHdSMoFePvPkNhFDLTkACA
         nYWBDePbSA7wsN+X+K730JGXAhn0D40rWCQk6AUzfW6F1lA1CWQdhLEFO8RZnkd4kqbY
         L+5UzjDkdYZ22Yxgoa6JW83UDlN10ZeYWfhLIebHxdZo7ums9AkDDQMAa1uDmoOoVqLd
         qyPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680022705;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JXfvGk9TMBkNKOHw8bvj8pVSmQNtUQsW3yfKe+TkhUs=;
        b=uZVad1R+rLYMhett0V0zPyi4GwLwzKSW4nYAucXzoikiTE6L+NpO3uKeWQEyjlAMiF
         8n4VIZ0fQkXkxa8MlVqt9DfnBDSfnGjE9vk08qEpJiIEhSMmWv78ddGJWRjRPIOtc5dw
         jKQLFRAxghBOVyOKu/LxZhH5ngNJO58pc3IyHM1cq0oL/nNtuPvaf9aNuC7A+b36cuQR
         Ky/AK/Ps2OgB0nvzyAUjvlm8MPCsGEqAVUnSOOXPXGiKmuxj3jTs+i/QKyBvIrAUAXVI
         63MBglA0vYMzJ6LJ59gLZpmv3hHCj5r027rJUh4dEqGK6D1sfnV2i6gy03oCmDSe6aC7
         umwg==
X-Gm-Message-State: AAQBX9f2jR4kGjZrTAX0XZTcfZRcDA7fdYvAV5dagkUqvOqfP3r914s6
        l26MNsNGZyGW1NG9tI1IJw5c6+gPFmqqMA==
X-Google-Smtp-Source: AKy350YpMEMX0GrjjDwC0AuDJ7V5Smbc35vBVQ0B6SaoMAtj4ZvvSkO/OlUkvvzUpE+C7CfakJkITN93hkPSeQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a63:ed09:0:b0:50f:a35d:9dd1 with SMTP id
 d9-20020a63ed09000000b0050fa35d9dd1mr4329417pgi.5.1680022705354; Tue, 28 Mar
 2023 09:58:25 -0700 (PDT)
Date:   Tue, 28 Mar 2023 09:58:23 -0700
In-Reply-To: <cover-v8-0.9-00000000000-20230328T140126Z-avarab@gmail.com>
Mime-Version: 1.0
References: <cover-v7-0.9-00000000000-20230308T090513Z-avarab@gmail.com> <cover-v8-0.9-00000000000-20230328T140126Z-avarab@gmail.com>
Message-ID: <kl6lo7ocdd8w.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v8 0/9] config API: make "multi" safe, fix segfaults,
 propagate "ret"
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

> This series fixes numerous segfaults in config API users, because they
> didn't expect *_get_multi() to hand them a string_list with a NULL in
> it given config like "[a] key" (note, no "=3D"'s).
>
> [..]
>
> * A trivial documentation change to 3/9, to clarify which doc in
>   config.h refer to what. As noted in the v7 discussion I think that
>   config.h could use some larger cleanups in this area, but let's
>   leave that for some future topic.
>
> [...]
>
> Range-diff against v7:
>  1:  9f297a35e14 =3D  1:  b600354c0f6 config tests: cover blind spots in =
git_die_config() tests
>  2:  45d483066ef =3D  2:  49908f0bcf3 config tests: add "NULL" tests for =
*_get_value_multi()
>  3:  a977b7b188f !  3:  d163b3d04ff config API: add and use a "git_config=
_get()" family of functions
>     @@ config.h: void git_configset_clear(struct config_set *cs);
>        * value in the 'dest' pointer.
>        */
>      =20
>     ++/**
>     ++ * git_configset_get() returns negative values on error, see
>     ++ * repo_config_get() below.
>     ++ */
>      +RESULT_MUST_BE_USED
>      +int git_configset_get(struct config_set *cs, const char *key);
>      +

Thanks! I read through config.h to be sure, and the result looks pretty
clear to me.

>  4:  3a5a323cd91 =3D  4:  d7dfedb7225 versioncmp.c: refactor config readi=
ng next commit
>  5:  dced12a40d2 =3D  5:  840fb9d5c74 config API: have *_multi() return a=
n "int" and take a "dest"
>  6:  d910f7e3a27 =3D  6:  75a68b14217 for-each-repo: error on bad --confi=
g
>  7:  57db0fcd91f =3D  7:  a78056e2748 config API users: test for *_get_va=
lue_multi() segfaults
>  8:  b374a716555 =3D  8:  686b512c3df config API: add "string" version of=
 *_value_multi(), fix segfaults
>  9:  6791e1f6f85 =3D  9:  6fce633493b for-each-repo: with bad config, don=
't conflate <path> and <cmd>

Reviewed-by: Glen Choo <chooglen@google.com>
