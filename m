Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DA5C433FE
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 23:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3315322B4E
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 23:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgLDXZP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 18:25:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgLDXZO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 18:25:14 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D63DC0613D1
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 15:24:34 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id f12so6876069oto.10
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 15:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6u9ZeLX3b+lNgugu8ow04XQ5MvcbAU2cvHpqEjRmuak=;
        b=FV8wfGfgXACzPrmgh9mtfLGaEKX63nPzz2LyQcNV2cgTQiVFczTXskCL8gFDZz9CAr
         bUdaRjHe2dU2EPt6XsxIDHoZQyiT9pwsW1vGVxdF7n5tEvzDJIYOsdnLo0uTNzpm843l
         DPxoUIQSYKsy4P14by2S0NdW3BDjx5ZijmR3NKuFfaG24vD3TK/Ij0ZI1vmHJtVkrmnj
         FUNVcryito4nNJIZeRTCcn8l4HVDQKQKrhlL9PWWUny/p3kAE0XZjXMmbNozhgit1iM2
         LBcI6gWDOsGynYInQ+cnVfwjILUNalS1FdS6M/i3otJbA3h9dW0oX39OdsHEcTjWnpT/
         WUNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6u9ZeLX3b+lNgugu8ow04XQ5MvcbAU2cvHpqEjRmuak=;
        b=Xprivia5WP0PglKzat2LAAnE5EG8cKEVnam8aupHEPDUkpPvMpcGmKpZvK+dHy598A
         dxaoPgoz4pKIiR0Ss8hBesMa1Br2kKJvzuzOqqpSKs6jL36sIABeYa7YPixG0E7lbfls
         u/8x/lHhK0yhVvF+ORO7qh6hp5wyBYq7WXWkv3Gmaj9UVV1KdvOizfDJirGJ64wMfmwa
         0Aut+vwKEdcIKMFDGzerDqnIZt5cnmSPuu3qhb9fQ02CVvvMBN+klbDpeMCXW0OS14Ld
         I5iTH7aEB9J9r91mNwxDaFdeUNCIswS3912zeX3gW7IlAraPSJhlYDAdXfQxZTSW+h6f
         X4+A==
X-Gm-Message-State: AOAM533f9z9v9SUuTqCF5gP486AY74ItnINSbVUf0v8F/LWD48fNoVFg
        GHWI/s1zne6zqvpPlG9ZJujktesxFFth95aXW3Y=
X-Google-Smtp-Source: ABdhPJwXqy5uP7Xnbi9mb/MprdCtFrH7UTpW1P1m+FS2q2Zji2EQyJXD1hvVA1dhkuqqq9bnRSxai7s1Pvz8hGIKBkI=
X-Received: by 2002:a9d:b8e:: with SMTP id 14mr3437744oth.316.1607124273378;
 Fri, 04 Dec 2020 15:24:33 -0800 (PST)
MIME-Version: 1.0
References: <20201204061623.1170745-1-felipe.contreras@gmail.com> <20201204061623.1170745-8-felipe.contreras@gmail.com>
In-Reply-To: <20201204061623.1170745-8-felipe.contreras@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 4 Dec 2020 15:24:22 -0800
Message-ID: <CABPp-BEdgwcueYC1OWd3LtJaGPLgLcdkezGEqeKo7mVfx=C6Jg@mail.gmail.com>
Subject: Re: [PATCH v2 07/14] pull: display default warning only when non-ff
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jacob Keller <jacob.keller@gmail.com>,
        John Keeping <john@keeping.me.uk>,
        Richard Hansen <rhansen@rhansen.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        "W. Trevor King" <wking@tremily.us>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 3, 2020 at 10:16 PM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> There's no need to display the annoying warning on every pull... only
> the ones that are not fast-forward.

I like this.  :-)

> This requires the tests to pick another base, so the merge is not
> fast-forward.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  Documentation/git-pull.txt   |  3 +++
>  builtin/pull.c               |  2 +-
>  t/t7601-merge-pull-config.sh | 28 +++++++++++++++++-----------
>  3 files changed, 21 insertions(+), 12 deletions(-)
>
> diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
> index dc812139f4..ad33d2472c 100644
> --- a/Documentation/git-pull.txt
> +++ b/Documentation/git-pull.txt
> @@ -60,6 +60,9 @@ However, a non-fast-foward case looks very different.
>         origin/master in your repository
>  ------------
>
> +By default `git pull` will warn about these situations, however, most likely
> +you would want to force a merge, which you can do with `git pull --no-rebase`.
> +

Everything in this sentence after the first comma seems dangerous to
me for a number of workflows.

>  Then "`git pull`" will fetch and replay the changes from the remote
>  `master` branch since it diverged from the local `master` (i.e., `E`)
>  until its current commit (`C`) on top of `master` and record the
> diff --git a/builtin/pull.c b/builtin/pull.c
> index f82e214fc8..f0b1c6bfea 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -1013,7 +1013,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>
>         can_ff = get_can_ff(&orig_head, &merge_heads.oid[0]);
>
> -       if (default_mode && opt_verbosity >= 0 && !opt_ff) {
> +       if (default_mode && !can_ff && opt_verbosity >= 0 && !opt_ff) {
>                 advise(_("Pulling without specifying how to reconcile divergent branches is\n"
>                         "discouraged; you need to specify if you want a merge, or a rebase.\n"
>                         "You can squelch this message by running one of the following commands:\n"
> diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
> index 6774e9d86f..6b4adab8b1 100755
> --- a/t/t7601-merge-pull-config.sh
> +++ b/t/t7601-merge-pull-config.sh
> @@ -28,7 +28,7 @@ test_expect_success 'setup' '
>  '
>
>  test_expect_success 'pull.rebase not set' '
> -       git reset --hard c0 &&
> +       git reset --hard c2 &&
>         git -c color.advice=always pull . c1 2>err &&
>         test_decode_color <err >decoded &&
>         test_i18ngrep "<YELLOW>hint: " decoded &&
> @@ -36,54 +36,60 @@ test_expect_success 'pull.rebase not set' '
>
>  '
>
> -test_expect_success 'pull.rebase not set and pull.ff=true' '
> +test_expect_success 'pull.rebase not set (fast-forward)' '
>         git reset --hard c0 &&
> +       git pull . c1 2>err &&
> +       test_i18ngrep ! "Pulling without specifying how to reconcile" err
> +'
> +
> +test_expect_success 'pull.rebase not set and pull.ff=true' '
> +       git reset --hard c2 &&
>         test_config pull.ff true &&
>         git pull . c1 2>err &&
>         test_i18ngrep ! "Pulling without specifying how to reconcile" err
>  '
>
>  test_expect_success 'pull.rebase not set and pull.ff=false' '
> -       git reset --hard c0 &&
> +       git reset --hard c2 &&
>         test_config pull.ff false &&
>         git pull . c1 2>err &&
>         test_i18ngrep ! "Pulling without specifying how to reconcile" err
>  '
>
>  test_expect_success 'pull.rebase not set and pull.ff=only' '
> -       git reset --hard c0 &&
> +       git reset --hard c2 &&
>         test_config pull.ff only &&
> -       git pull . c1 2>err &&
> +       test_must_fail git pull . c1 2>err &&

It makes sense to me that you'd need test_must_fail here...but why
wasn't it needed before??  How did this test pass without it before
this series?

>         test_i18ngrep ! "Pulling without specifying how to reconcile" err
>  '
>
>  test_expect_success 'pull.rebase not set and --rebase given' '
> -       git reset --hard c0 &&
> +       git reset --hard c2 &&
>         git pull --rebase . c1 2>err &&
>         test_i18ngrep ! "Pulling without specifying how to reconcile" err
>  '
>
>  test_expect_success 'pull.rebase not set and --no-rebase given' '
> -       git reset --hard c0 &&
> +       git reset --hard c2 &&
>         git pull --no-rebase . c1 2>err &&
>         test_i18ngrep ! "Pulling without specifying how to reconcile" err
>  '
>
>  test_expect_success 'pull.rebase not set and --ff given' '
> -       git reset --hard c0 &&
> +       git reset --hard c2 &&
>         git pull --ff . c1 2>err &&
>         test_i18ngrep ! "Pulling without specifying how to reconcile" err
>  '
>
>  test_expect_success 'pull.rebase not set and --no-ff given' '
> -       git reset --hard c0 &&
> +       git reset --hard c2 &&
>         git pull --no-ff . c1 2>err &&
>         test_i18ngrep ! "Pulling without specifying how to reconcile" err
>  '
>
>  test_expect_success 'pull.rebase not set and --ff-only given' '
> -       git reset --hard c0 &&
> -       git pull --ff-only . c1 2>err &&
> +       git reset --hard c2 &&
> +       test_must_fail git pull --ff-only . c1 2>err &&

Same question; how did this test pass before without the test_must_fail??


>         test_i18ngrep ! "Pulling without specifying how to reconcile" err
>  '
>
> --
> 2.29.2
