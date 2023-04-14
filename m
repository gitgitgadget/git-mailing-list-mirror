Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECFF8C77B6E
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 13:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjDNN2i (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 09:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjDNN2h (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 09:28:37 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFBE06E87
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 06:28:35 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id c9so6707503ejz.1
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 06:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681478914; x=1684070914;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=joDDWYd132wEy2b/GezPTt5i4CbquUWp4nEecW7epHI=;
        b=IPWmA8Y731bqMEPjSL/M2F4B9rF5NzBaICUTSLLhwr4EPUqZr/0WQn0yq4pJw9i1SG
         HN6xoI9Q/g5ydRhzFniQs5dhc74W7zaFijd0Is5ssk1TNDtUqw1qkHdEtl1yPRhaWcM7
         KJVSmir9uxHfT3qBKCls5BdGowcVKOyUH1FeEnBpf2mGSN3RK0xQHfeVs8GWaJHdgDnl
         UTjnaVPt8FVRRLteABTBjDr2D5P25NoeEtz0mNPUPUpiaJ/GrDbwfyM6eUSO58m5Thw+
         i/QgZ9n7AMBn0uqc2Jb+qps6nSLOrF13ulps6Dnp3yGWQbxINgeZwrel3St7P4yj5JiL
         oNBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681478914; x=1684070914;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=joDDWYd132wEy2b/GezPTt5i4CbquUWp4nEecW7epHI=;
        b=eP92U+GrtoyY7HDXyK4GtuUlJ88monw1ZDfO80zDowV0jVW/qiTIyVaja6f1om8/85
         JqzMhDlRttZPT4Nj8dOHuwAzOyercCfdFOqOmfKkYeH7lTGPr7Gb1XrQcNK2Q1kZFx8g
         t4hJnFxQtU6M4HgQQlKeYbq38u90fmkjvBLmCq6WlPRZx2jzwMHGlp58hA30JrvDdi3c
         ft3FeI/Dj//nyQIknYsPZ12JdJC/O5M0RhJDSHAbJrnqN7Xo81U329eJ8kGjC4pl+mH1
         QnzuW9EcYBKGNjj7VMQlJJoWJgUILoswY7B2DfH7dKnw3Da/LL/cBlc1pbO4R5Ar9Fqg
         vcOQ==
X-Gm-Message-State: AAQBX9cQeQ8ZoTZz5RXRH36RfWr5ct96Yw2W4nK+NG11j/sIm1b7ZQi7
        HuGE1lxDfnV6MxzS9CeJPBk/6RML3CmmswsHO93L1f2h4DiRog==
X-Google-Smtp-Source: AKy350Z5nRN8c59++QEEKoWEw9wdIPGIjc9dC0QuibmGx9wAMtAfZCNmpYaeozi0HB7Gub69MblQrKZ3HPZoppk+2mM=
X-Received: by 2002:a17:906:8597:b0:94e:d1d9:a59c with SMTP id
 v23-20020a170906859700b0094ed1d9a59cmr1618728ejx.13.1681478914085; Fri, 14
 Apr 2023 06:28:34 -0700 (PDT)
MIME-Version: 1.0
References: <7a5de047-3535-3b87-f023-43c400d57131@gmail.com>
 <20230414081352.810296-1-rybak.a.v@gmail.com> <20230414081352.810296-3-rybak.a.v@gmail.com>
In-Reply-To: <20230414081352.810296-3-rybak.a.v@gmail.com>
From:   Andrei Rybak <rybak.a.v@gmail.com>
Date:   Fri, 14 Apr 2023 15:28:17 +0200
Message-ID: <CACayv=jL4t3cUVS=xXQ3fLxF26vDXRJ3khs2y4UjzBw947JVkw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] t1300: check stderr for "ignores pairs" tests
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 14 Apr 2023 at 10:13, Andrei Rybak <rybak.a.v@gmail.com> wrote:
>
> Tests "git config ignores pairs ..." in t1300-config.sh validate that
> "git config" ignores with various kinds of supplied pairs of environment
> variables GIT_CONFIG_KEY_* GIT_CONFIG_VALUE_* that should be ingored.
> By "ignores" here we mean that "git config" doesn't complain about them
> to standard error.

After thinking about this some more, I've realized that this is an
incorrect interpretation
of the titles of these tests. The correct interpretation is more
obvious from another test:

    test_expect_success 'git config ignores pairs exceeding count' '
           GIT_CONFIG_COUNT=3D1 \
                  GIT_CONFIG_KEY_0=3D"pair.one" GIT_CONFIG_VALUE_0=3D"value=
" \
                  GIT_CONFIG_KEY_1=3D"pair.two" GIT_CONFIG_VALUE_1=3D"value=
" \
                  git config --get-regexp "pair.*" >actual &&
           cat >expect <<-EOF &&
           pair.one value
           EOF
           test_cmp expect actual
    '

Key-value pair "pair.two=3Dvalue" is ignored because it's outside of the
range of the
supplied value of GIT_CONFIG_COUNT.  That is, these tests validate that rea=
ding
of these environment variables reads GIT_CONFIG_COUNT first and only loads
GIT_CONFIG_KEY_<n> and GIT_CONFIG_VALUE_<n> that fit in the range.

> This is validated by redirecting the standard error
> to a file called "error" and asserting that it is empty.  However, two
> of these tests incorrectly redirect to standard output while calling the
> file "error", and test 'git config ignores pairs exceeding count'
> doesn't validate standard error at all.
>
> Fix it by redirecting standard error to file "error" and asserting its
> emptiness.
>
> Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
> ---
>  t/t1300-config.sh | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/t/t1300-config.sh b/t/t1300-config.sh
> index 696dca17c6..20a15ede5c 100755
> --- a/t/t1300-config.sh
> +++ b/t/t1300-config.sh
> @@ -1462,24 +1462,25 @@ test_expect_success 'git config ignores pairs exc=
eeding count' '
>         GIT_CONFIG_COUNT=3D1 \
>                 GIT_CONFIG_KEY_0=3D"pair.one" GIT_CONFIG_VALUE_0=3D"value=
" \
>                 GIT_CONFIG_KEY_1=3D"pair.two" GIT_CONFIG_VALUE_1=3D"value=
" \
> -               git config --get-regexp "pair.*" >actual &&
> +               git config --get-regexp "pair.*" >actual 2>error &&
>         cat >expect <<-EOF &&
>         pair.one value
>         EOF
> -       test_cmp expect actual
> +       test_cmp expect actual &&
> +       test_must_be_empty error
>  '
>
>  test_expect_success 'git config ignores pairs with zero count' '
>         test_must_fail env \
>                 GIT_CONFIG_COUNT=3D0 GIT_CONFIG_KEY_0=3D"pair.one" GIT_CO=
NFIG_VALUE_0=3D"value" \
> -               git config pair.one >error &&
> +               git config pair.one 2>error &&
>         test_must_be_empty error
>  '
>
>  test_expect_success 'git config ignores pairs with empty count' '
>         test_must_fail env \
>                 GIT_CONFIG_COUNT=3D GIT_CONFIG_KEY_0=3D"pair.one" GIT_CON=
FIG_VALUE_0=3D"value" \
> -               git config pair.one >error &&
> +               git config pair.one 2>error &&


Same question as in =C3=86var's
https://lore.kernel.org/git/230406.86pm8htnfk.gmgdl@evledraar.gmail.com/
and my reply https://lore.kernel.org/git/c43e6b71-075a-e39a-7351-8595e145da=
cf@gmail.com/
applies here, though.  In tests 'git config ignores pairs with zero count' =
and
 'git config ignores pairs with empty count' test_must_fail already asserts=
 that
"git config" couldn't get the value.  Should we be also inspecting
both stdout and
stderr, as the test  'git config ignores pairs exceeding count' does
(after this patch)?

>         test_must_be_empty error
>  '

>
> --
> 2.40.0
>
