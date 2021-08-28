Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A61C432BE
	for <git@archiver.kernel.org>; Sat, 28 Aug 2021 07:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85027610A3
	for <git@archiver.kernel.org>; Sat, 28 Aug 2021 07:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233441AbhH1H2n (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Aug 2021 03:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233375AbhH1H2m (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Aug 2021 03:28:42 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2CB2C0613D9
        for <git@vger.kernel.org>; Sat, 28 Aug 2021 00:27:52 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id l7-20020a0568302b0700b0051c0181deebso10951367otv.12
        for <git@vger.kernel.org>; Sat, 28 Aug 2021 00:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OMluLq1IayRcwaue3pNGU2TSY51w4YB2ZJyWSPU9mDo=;
        b=k5r80bdtuxUZI4NcAopPmEPm0VnebEY30Co8F8ImW+tCU8NZdPbJxcKcCuwZjuCuVb
         FIaKT/2DOfAqb5AhB8N91c+/xYzWEdlfBWXVOANH4JPTD70/lDQqy5hR+Tq4zJjEINEN
         +e/s2X0+yi1p6EElzt7jN6vJJuRwrBJDlOVIzHjBTB1YKDg6iYxRC4JZoSW59wwFtrj1
         d/N4vvnbcpGgHrbGRvymuukXOWUbFmRCf2HHftAC5e+b5knZN4jB19dowLswV78Doarx
         Nm3fWDadtd8vwPRDIEslW1xnPa3HEIuG0Fsyz66UCZ2SgUVK+EtjQeGxI61sM0frRv/w
         0/lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OMluLq1IayRcwaue3pNGU2TSY51w4YB2ZJyWSPU9mDo=;
        b=X8NQ7VHqFTY50C55xk5w2LH1tEh8eGj3N3G4IzmwlAX3Fok4+nyIpl7uMnAw4ZhdSJ
         hD9zq1PnJWkUsaBC/+Ov9Sp4sbCKOlmt3NN9pc9IHmSWPw2zE3r8+iHNjMS8gwcowif7
         3x+k6EEHTg1h79QR8v0nelurkQT0TCrpGX6/3HGK9vm9CLPr3coNZH8DAuZ+xsRme28O
         K1YvkLn1P7m0lA76XRrlUszv1DsnkDYqkGli+TFGkaD/jjXBNtYvf5rZqly8nGSDuXJt
         6XozDFwrfZ25xD8qfhaZ5Z1lYRboghgAsDamIHB6w3s69VOHwQ0HCQzEtHVwRaRxRtZr
         OVXg==
X-Gm-Message-State: AOAM532F/K1c9Slty1qWxM9z7NliUjBKNzpBfvCH10rGI+Bwfkha1kQd
        dUYgPahhTAWkXzN5L4mgmVbqaR/HvIiH90AGuMk=
X-Google-Smtp-Source: ABdhPJxL8C98FYr0rjoSs6Pz3qvX6hpa2hu+toFzkOqEhTk24xBfvFzayLA0OxZkgVzjto1LwSut8TZY/6Ge9DjM4J4=
X-Received: by 2002:a9d:630e:: with SMTP id q14mr11195185otk.316.1630135672051;
 Sat, 28 Aug 2021 00:27:52 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1022.git.1629393395.gitgitgadget@gmail.com>
 <pull.1022.v2.git.1630111653.gitgitgadget@gmail.com> <00211457eceab756528abf0ca296af866cda00e7.1630111653.git.gitgitgadget@gmail.com>
In-Reply-To: <00211457eceab756528abf0ca296af866cda00e7.1630111653.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 28 Aug 2021 00:27:41 -0700
Message-ID: <CABPp-BFxDxD0Y5Ru+4VqebAJve4tjZk-4csN3JurC6hmRAUf4A@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] test-lib-functions: optionally keep HOME, TERM and
 SHELL in 'test_pause'
To:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Carlo Arenas <carenas@gmail.com>, Jeff King <peff@peff.net>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 27, 2021 at 5:47 PM Philippe Blain via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Philippe Blain <levraiphilippeblain@gmail.com>
>
> The 'test_pause' function, which is designed to help interactive
> debugging and exploration of tests, currently inherits the value of HOME
> and TERM set by 'test-lib.sh': HOME="$TRASH_DIRECTORY" and TERM=dumb. It
> also invokes the shell defined by TEST_SHELL_PATH, which defaults to
> /bin/sh (through SHELL_PATH).
>
> Changing the value of HOME means that any customization configured in a
> developers' shell startup files and any Git aliases defined in their
> global Git configuration file are not available in the shell invoked by
> 'test_pause'.
>
> Changing the value of TERM to 'dumb' means that colored output
> is disabled for all commands in that shell.
>
> Using /bin/sh as the shell invoked by 'test_pause' is not ideal since
> some platforms (i.e. Debian and derivatives) use Dash as /bin/sh, and
> this shell is usually compiled without readline support, which makes for
> a poor interactive command line experience.
>
> To make the interactive command line experience in the shell invoked by
> 'test_pause' more pleasant, save the values of HOME and TERM in
> USER_HOME and USER_TERM before changing them in test-lib.sh, and add
> options to 'test_pause' to optionally use these variables to invoke the
> shell. Also add an option to invoke SHELL instead of TEST_SHELL_PATH, so
> that developer's interactive shell is used.
>
> We use options instead of changing the behaviour unconditionally since
> these three variables can break test reproducibility. Moreover, using the
> original HOME means tests could overwrite files in a user's home
> directory. Be explicit about these caveats in the new 'Usage' section in
> test-lib-functions.sh.
>
> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
> ---
>  t/test-lib-functions.sh | 37 ++++++++++++++++++++++++++++++++++++-
>  t/test-lib.sh           |  6 ++++--
>  2 files changed, 40 insertions(+), 3 deletions(-)
>
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index 1884177e293..1b775343adc 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -137,9 +137,44 @@ test_tick () {
>  # Stop execution and start a shell. This is useful for debugging tests.
>  #
>  # Be sure to remove all invocations of this command before submitting.
> +#
> +# Usage: test_pause [options]
> +#   -t
> +#      Use your original TERM instead of test-lib.sh's "dumb".
> +#      This usually restores color output in the invoked shell.
> +#      WARNING: this can break test reproducibility.
> +#   -s
> +#      Invoke $SHELL instead of $TEST_SHELL_PATH
> +#      WARNING: this can break test reproducibility.
> +#   -h
> +#      Use your original HOME instead of test-lib.sh's "$TRASH_DIRECTORY".
> +#      This allows you to use your regular shell environment and Git aliases.
> +#      WARNING: this can break test reproducibility.
> +#      CAUTION: this can overwrite files in your HOME.

Do you want to add an option that implies the other three, so that
folks can do something like `test_pause -a` (or some other single
letter) rather than `test_pause -t -s -h`?

>
>  test_pause () {
> -       "$TEST_SHELL_PATH" <&6 >&5 2>&7
> +       PAUSE_TERM=$TERM &&
> +       PAUSE_SHELL=$TEST_SHELL_PATH &&
> +       PAUSE_HOME=$HOME &&
> +       while test $# != 0
> +       do
> +               case "$1" in
> +               -t)
> +                       PAUSE_TERM="$USER_TERM"
> +                       ;;
> +               -s)
> +                       PAUSE_SHELL="$SHELL"
> +                       ;;
> +               -h)
> +                       PAUSE_HOME="$USER_HOME"
> +                       ;;
> +               *)
> +                       break
> +                       ;;
> +               esac
> +               shift
> +       done &&
> +       TERM="$PAUSE_TERM" HOME="$PAUSE_HOME" "$PAUSE_SHELL" <&6 >&5 2>&7
>  }
>
>  # Wrap git with a debugger. Adding this to a command can make it easier
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index abcfbed6d61..132618991e2 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -585,8 +585,9 @@ else
>         }
>  fi
>
> +USER_TERM="$TERM"
>  TERM=dumb
> -export TERM
> +export TERM USER_TERM
>
>  error () {
>         say_color error "error: $*"
> @@ -1380,9 +1381,10 @@ then
>  fi
>
>  # Last-minute variable setup
> +USER_HOME="$HOME"
>  HOME="$TRASH_DIRECTORY"
>  GNUPGHOME="$HOME/gnupg-home-not-used"
> -export HOME GNUPGHOME
> +export HOME GNUPGHOME USER_HOME
>
>  # Test repository
>  rm -fr "$TRASH_DIRECTORY" || {
> --
> gitgitgadget
