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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F0C8C433FE
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 23:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCFB422838
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 23:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbgLDX27 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 18:28:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbgLDX27 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 18:28:59 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8006FC061A52
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 15:27:47 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id y74so8058552oia.11
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 15:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gNR/H1aEDKl8tiCDZJJEeR6ciZvc5+EznRW/WLXJ3ZM=;
        b=QPO/MvIjF3WrMmO1mTjbrCcdAqJeQxLTXJbhgEY1j/Zm750y3d+ujsh51L59EJFrQk
         kL8zByeQp08Q/Ina0t/YI3BCRc0D5plKAAGBOoYZEO2TbR58wxIDkHBP+mDJ/VRImPfr
         ybD/rXFu0Lc7ZgRiOXoZfHapWLVktUPZ0UbdRew2B6xZ5hjNrmAByHDWbm/WaxFKhX8t
         TGTTHDJdVxeG4pi5WKD8/BQ8TtHOSXP2E/NXxsyHxZEquM5Y2H0lagZYcpMb5h39h4Ak
         Z6IZ+WX0lTThk1gsN9iO2dKq0U1IXAgCUMEUy6Mtcu81CsN/eruvTx8glkn22JOLQRlw
         pVZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gNR/H1aEDKl8tiCDZJJEeR6ciZvc5+EznRW/WLXJ3ZM=;
        b=LfdhldmQ8X2bq7MhkHVr874IO6ypmEkw3FiFmmuw/Hzbu7UObPQVilV/ImDnSXHnYZ
         Pv2lLem4RFAHOgeyp3vMK6qYtdnPYhwA7SyVCSrNHw/Y4Mz1B8A0nN5jkBSrQQN5F1aQ
         OL0FQ24qMu/EkXc1+Zt6EigqYLds9l8x+6B2pgdh5HxdFgfwqbproRluwPSSI9Lg9oXb
         GjNaj6y8PG4ehvE4pEiKSQCUjMJ9aCGUelXCKkR6LDm587puVfKJ7J+JoPrLc+OyD4rC
         RLDbVBRZvahZoKTtfg4+3X+/Q2k8WLtfpW71yCMeDviKac5hPpMdKYJybVwEbUE+gdUJ
         b0cA==
X-Gm-Message-State: AOAM531FW28eHShe45OnZLK/Si2puRLqgLWKbjD92yAyALp0U/Q2kgI2
        NA+tXaNnQTH/Hq+0pl8+PDR4iGjU9EdoNRO6Vpo=
X-Google-Smtp-Source: ABdhPJxdDuFzZCIIx6GRm0LHw9dEUONLGMq6hujHFfzFtdHehFYvs3qtNF0BGIr8q6CNxwyItvKUo48LqHSlRohYp80=
X-Received: by 2002:a54:4704:: with SMTP id k4mr4850320oik.39.1607124466976;
 Fri, 04 Dec 2020 15:27:46 -0800 (PST)
MIME-Version: 1.0
References: <20201204061623.1170745-1-felipe.contreras@gmail.com> <20201204061623.1170745-10-felipe.contreras@gmail.com>
In-Reply-To: <20201204061623.1170745-10-felipe.contreras@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 4 Dec 2020 15:27:35 -0800
Message-ID: <CABPp-BGndfbF=QcCox13kik4B9F7Bgn7k2ToFRkGsh0dJ4K0HA@mail.gmail.com>
Subject: Re: [PATCH v2 09/14] pull: introduce --merge option
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
> Previously --no-rebase (which still works for backwards compatbility).
>
> Now we can update the default warning, and the git-pull(1) man page to
> use --merge instead of the non-intuitive --no-rebase.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  Documentation/git-pull.txt   | 9 ++++++---
>  builtin/pull.c               | 4 +++-
>  t/t7601-merge-pull-config.sh | 4 ++--
>  3 files changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
> index ad33d2472c..c220da143a 100644
> --- a/Documentation/git-pull.txt
> +++ b/Documentation/git-pull.txt
> @@ -61,7 +61,7 @@ However, a non-fast-foward case looks very different.
>  ------------
>
>  By default `git pull` will warn about these situations, however, most likely
> -you would want to force a merge, which you can do with `git pull --no-rebase`.
> +you would want to force a merge, which you can do with `git pull --merge`.

I'm glad you updated all the references, but as noted earlier in the
series I think this suggestion is problematic.

>
>  Then "`git pull`" will fetch and replay the changes from the remote
>  `master` branch since it diverged from the local `master` (i.e., `E`)
> @@ -148,8 +148,11 @@ It rewrites history, which does not bode well when you
>  published that history already.  Do *not* use this option
>  unless you have read linkgit:git-rebase[1] carefully.
>
> ---no-rebase::
> -       Override earlier --rebase.
> +-m::
> +--merge::
> +       Force a merge.
> ++
> +Previously this was --no-rebase, but that usage has been deprecated.
>
>  Options related to fetching
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~
> diff --git a/builtin/pull.c b/builtin/pull.c
> index b200f7544c..6ea95c9fc9 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -131,6 +131,8 @@ static struct option pull_options[] = {
>                 "(false|true|merges|preserve|interactive)",
>                 N_("incorporate changes by rebasing rather than merging"),
>                 PARSE_OPT_OPTARG, parse_opt_rebase),
> +       OPT_SET_INT('m', "merge", &opt_rebase,
> +               N_("incorporate changes by merging"), 0),
>         OPT_PASSTHRU('n', NULL, &opt_diffstat, NULL,
>                 N_("do not show a diffstat at the end of the merge"),
>                 PARSE_OPT_NOARG | PARSE_OPT_NONEG),
> @@ -1024,7 +1026,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>                         "\n"
>                         "You can replace \"git config\" with \"git config --global\" to set a default\n"
>                         "preference for all repositories.\n"
> -                       "If unsure, run \"git pull --no-rebase\".\n"
> +                       "If unsure, run \"git pull --merge\".\n"

This was the other problematic copy of that suggestion.

>                         "Read \"git pull --help\" for more information."
>                         ));
>         }
> diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
> index 6b4adab8b1..1de64e6cc5 100755
> --- a/t/t7601-merge-pull-config.sh
> +++ b/t/t7601-merge-pull-config.sh
> @@ -69,9 +69,9 @@ test_expect_success 'pull.rebase not set and --rebase given' '
>         test_i18ngrep ! "Pulling without specifying how to reconcile" err
>  '
>
> -test_expect_success 'pull.rebase not set and --no-rebase given' '
> +test_expect_success 'pull.rebase not set and --merge given' '
>         git reset --hard c2 &&
> -       git pull --no-rebase . c1 2>err &&
> +       git pull --merge . c1 2>err &&
>         test_i18ngrep ! "Pulling without specifying how to reconcile" err
>  '
>
> --
> 2.29.2

I very much like the change in this patch, other than the obvious
couple places where you are just tweaking an earlier problematic
suggestion.
