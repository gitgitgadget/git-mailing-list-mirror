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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10125C433FE
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 23:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C32B122CA0
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 23:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbgLDXl6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 18:41:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbgLDXl6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 18:41:58 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99946C0613D1
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 15:41:32 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id s75so5051683oih.1
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 15:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GfPtkH20GfyK7/JEZ7ODQVQCsTb7QqbeNHfERzjMZs8=;
        b=eAE+pNPjlUFyyO6DpljjwymDaxMrCXs1bEzmcIW2v7TbaYfAKHLUG11bahXYocADAa
         ZJj+qI3/+IHir+opDZpephX/rFpcS/chz6C39ndU4xykGnMST7INn5/pqD/iYOhwyneT
         yU+6fuI3B9uwD7AoyqH4H2X31I/OC+iKas9NXOuD/nsi7tHVHWPiDVynO1xXC9MF22ad
         lS9orVBPjlH2ThJNuSiolFvsmBRKSD2EYtljVaKPU7XbDum8ynacbvtKx0zMI0FKVxTl
         4vMc3UnAQOpOpEMJviJrQV0KD4gSanwD+XzM0kUwb+sqWN1loqgWOJiX5oN8U1le1n/a
         CvdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GfPtkH20GfyK7/JEZ7ODQVQCsTb7QqbeNHfERzjMZs8=;
        b=jzNUdgCJlTZ9LIs+l0Sm1XSJkAuYlie+362W0Gd+GMurBFKFyfmJ9+3aFiCdaIHXk7
         geEjW2YC+80BdSwFdw/uxZyzDJo70062IybSb7/ydZ0ETDJY4PVvJU1536hRxpqJeTBq
         fbq7qf7GgnMTkLF48WnYMGJQSUROHgHQWDwvMZiy/RrAfr1Hl+m2/cSyGZbt/DxVVbB4
         jm4la7MMje+EJqWmXcC5zntqDunMU59NDdubYEvd4EOcgKMN+sfhVlcmFXaJd7f8lXF8
         FLjIrMgkHF4NEt1RfENiIGe2LG1e5zAmf6pMYtkTByqFjQs69OVHrfdQga/KiZsKdWwQ
         1n9A==
X-Gm-Message-State: AOAM531ttk4vFctZk3ll1fpQ7FlQB7/qOTbKsfu3ZBZCHqxiAnKpLsu9
        pQU376XacFGCvU6s4zFvMpBR1YOWNou1fAADJg8=
X-Google-Smtp-Source: ABdhPJwsanCZ/+73Y38gfM3BrGwdXTE3eMswx0mUNJSbpthTmKp4XKTQ9Zo0ScYcyCxN8K7n1MD8xcVaWf1Pw3Xi/Qs=
X-Received: by 2002:a54:480b:: with SMTP id j11mr4949276oij.31.1607125291903;
 Fri, 04 Dec 2020 15:41:31 -0800 (PST)
MIME-Version: 1.0
References: <20201204061623.1170745-1-felipe.contreras@gmail.com> <20201204061623.1170745-13-felipe.contreras@gmail.com>
In-Reply-To: <20201204061623.1170745-13-felipe.contreras@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 4 Dec 2020 15:41:20 -0800
Message-ID: <CABPp-BE5zvCAmfHE_1_D3boMg5rMcU0iyJJp+yiLwSu2DsySLg@mail.gmail.com>
Subject: Re: [PATCH v2 12/14] pull: show warning with --ff
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
> It's unclear why --ff should remove the warning, since:
>
>   git pull --ff
>
> Is implicitly the same as:
>
>   git pull
>
> Unless of course pull.ff is specified otherwise.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  builtin/pull.c               | 2 +-
>  t/t7601-merge-pull-config.sh | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/pull.c b/builtin/pull.c
> index ebf2ac687b..e389ffcdc3 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -1020,7 +1020,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>                         die(_("The pull was not fast-forward, please either merge or rebase.\n"
>                                 "If unsure, run \"git pull --merge\"."));
>                 }
> -               if (opt_verbosity >= 0 && !opt_ff) {
> +               if (opt_verbosity >= 0 && (!opt_ff || !strcmp(opt_ff, "--ff"))) {
>                         advise(_("Pulling without specifying how to reconcile divergent branches is\n"
>                                 "discouraged; you need to specify if you want a merge, or a rebase.\n"
>                                 "You can squelch this message by running one of the following commands:\n"
> diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
> index 1de64e6cc5..d709799f8b 100755
> --- a/t/t7601-merge-pull-config.sh
> +++ b/t/t7601-merge-pull-config.sh
> @@ -46,7 +46,7 @@ test_expect_success 'pull.rebase not set and pull.ff=true' '
>         git reset --hard c2 &&
>         test_config pull.ff true &&
>         git pull . c1 2>err &&
> -       test_i18ngrep ! "Pulling without specifying how to reconcile" err
> +       test_i18ngrep "Pulling without specifying how to reconcile" err
>  '
>
>  test_expect_success 'pull.rebase not set and pull.ff=false' '
> @@ -78,7 +78,7 @@ test_expect_success 'pull.rebase not set and --merge given' '
>  test_expect_success 'pull.rebase not set and --ff given' '
>         git reset --hard c2 &&
>         git pull --ff . c1 2>err &&
> -       test_i18ngrep ! "Pulling without specifying how to reconcile" err
> +       test_i18ngrep "Pulling without specifying how to reconcile" err
>  '
>
>  test_expect_success 'pull.rebase not set and --no-ff given' '
> --
> 2.29.2

Ah, this answers one of my earlier questions.  I'd be tempted to move
this earlier in the series; it seems like an obvious cleanup and helps
explain the "opt_ff" flag that keeps coming up for readers of the
series.
