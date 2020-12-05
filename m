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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 867BBC4361A
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 17:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AE1E22EBD
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 17:42:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbgLERlI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Dec 2020 12:41:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbgLERic (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Dec 2020 12:38:32 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98099C094273
        for <git@vger.kernel.org>; Sat,  5 Dec 2020 09:29:13 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id d27so2660873oic.0
        for <git@vger.kernel.org>; Sat, 05 Dec 2020 09:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rxXNa72FTAnvjEdeQ0esPT85M4cjbIiS5pTiTL693Xc=;
        b=KYKv/tM4dL0jS4IReqmFbZLmtUo53FGaBhJUWRHqVCrweU3Kk9p7Yznu03g5ufdOLT
         b8fxvqx4Z69LHv2cf+6YD0jetdaNN0idIUx31jSnvg6gAFEjbSP5+2cHlImmUGOYI2Gu
         6zYdF0/eHOV9ovfQK/9v6vmwkaOJZCRp2crmGRindnONospMzC00By+3gL1d/zXws8Iv
         Hh1PDk9/IrqlTfY2J8pDsTjLx10QwAoCiIUF3yXCInN9ClT9/HOFX7mo4yftjcyBGk5S
         tRHZA03GnVxW6tvr+LqWhhYkLSKt6OeQHX75S5m7/ICxCKNHCuFWuMAKxZeH/lpH3xcf
         GH+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rxXNa72FTAnvjEdeQ0esPT85M4cjbIiS5pTiTL693Xc=;
        b=Z6MuqN6hueKVlhAC1MWHI8eBXhePwKKuOq6PbBZAkE6VPqKI4hPCXXmVg3xKGXEoOx
         wuM6EZ0g5NU8oxYgtcErBwez7RwAu/gw2h8dj4HvadelA8RRNmGR6jyd1spgtKQar8t2
         S3iCpZLVsYG4xgF67YxX3PjP/WzhKYIk/Pb8AXJJsW4+p8dA+5M7xtUI/bty0ZKYMZoV
         EmjY6AiakTzUVzQDaja8vgipHCgnGVd4Q/iFKuAtllpCcaBM2BO5xlHUc+jC7Al5DfNa
         RDJDKaksEqiPoKcMmW1x1+qKFD2a4qchMnp1vVl48KIYIoiVx+e86iZYtwNWShyA6Xo5
         5pdw==
X-Gm-Message-State: AOAM531HgmNvATiccoyMZnZ2D1o3XTuhKJSSLYpFTVlyv0zyE+YvMIEc
        hxEWuXHYpyMkX8H5SAT+ypGLf6uEv9m7TQNWdEWs7JFjhFxh0g==
X-Google-Smtp-Source: ABdhPJwiLJ3JNGqQkizlDmv2/W0QKD6SrqS4nWR/7M1lLPqrSyzAsnUYjUp2nmkl3iTVg/D+kmh9X0TXSCmy87z4JvM=
X-Received: by 2002:a54:480b:: with SMTP id j11mr7123602oij.31.1607189352664;
 Sat, 05 Dec 2020 09:29:12 -0800 (PST)
MIME-Version: 1.0
References: <CAMP44s1wFPQ0mEExYUQfxYx2AjMZS2=zL5ihfjp3qjp+EfNe9Q@mail.gmail.com>
 <20201205040644.1259845-1-felipe.contreras@gmail.com>
In-Reply-To: <20201205040644.1259845-1-felipe.contreras@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 5 Dec 2020 09:29:01 -0800
Message-ID: <CABPp-BE7B5hn3Fc4zD1o+qoqihJqCut=R1TP_fxMXW42+6iL+w@mail.gmail.com>
Subject: Re: [PATCH] experiment: pull: change --ff-only and default mode
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 4, 2020 at 8:06 PM Felipe Contreras
<felipe.contreras@gmail.com> wrote:

This commit message should say something more than just "change x", it
should have some words about what it is change from or to.  I think
the thrust of the patch is allowing --ff-only, --merge, and --rebase
to countermand an earlier otherwise-conflicting option.  Perhaps a
commit message of the form:

In git, we sometimes allow conflicting command line options with the
last one winning, e.g.
  git log --patch --no-patch
  git log --no-patch --patch
other times we just error out when conflicting options are given, e.g.
  git checkout -b --orphan NEWBRANCH
  git checkout --orphan -b NEWBRANCH
Previously, we did neither with --no-ff, --merge, and --rebase.
Change these options to have a last-one-wins behavior.


(Although, after writing this out, I wonder if we want to die with a
conflict message instead of going the route I suggested yesterday.
I'm not certain if one is better than the other, but worth
considering.  Thoughts?)

> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  builtin/pull.c  | 40 ++++++++++++++++++++++++++--------------
>  t/t5520-pull.sh | 23 +++++++++++++++++++++++
>  2 files changed, 49 insertions(+), 14 deletions(-)
>
> diff --git a/builtin/pull.c b/builtin/pull.c
> index e389ffcdc3..95ecbdaad5 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -62,6 +62,7 @@ static int parse_opt_rebase(const struct option *opt, const char *arg, int unset
>                 *value = parse_config_rebase("--rebase", arg, 0);
>         else
>                 *value = unset ? REBASE_FALSE : REBASE_TRUE;
> +       if (*value != REBASE_INVALID) default_mode = 0;
>         return *value == REBASE_INVALID ? -1 : 0;
>  }
>
> @@ -114,6 +115,23 @@ static int opt_show_forced_updates = -1;
>  static char *set_upstream;
>  static struct strvec opt_fetch = STRVEC_INIT;
>
> +static int parse_opt_ff_only(const struct option *opt, const char *arg, int unset)
> +{
> +       char **value = opt->value;
> +       opt_rebase = REBASE_FALSE;
> +       *value = "--ff-only";
> +       return 0;
> +}
> +
> +static int parse_opt_merge(const struct option *opt, const char *arg, int unset)
> +{
> +       char **value = opt->value;
> +       opt_ff = NULL;
> +       *value = REBASE_FALSE;
> +       default_mode = 0;
> +       return 0;
> +}
> +
>  static struct option pull_options[] = {
>         /* Shared options */
>         OPT__VERBOSITY(&opt_verbosity),
> @@ -131,8 +149,9 @@ static struct option pull_options[] = {
>                 "(false|true|merges|preserve|interactive)",
>                 N_("incorporate changes by rebasing rather than merging"),
>                 PARSE_OPT_OPTARG, parse_opt_rebase),
> -       OPT_SET_INT('m', "merge", &opt_rebase,
> -               N_("incorporate changes by merging"), 0),
> +       OPT_CALLBACK_F('m', "merge", &opt_rebase, NULL,
> +               N_("incorporate changes by merging"),
> +               PARSE_OPT_NOARG | PARSE_OPT_NONEG, parse_opt_merge),
>         OPT_PASSTHRU('n', NULL, &opt_diffstat, NULL,
>                 N_("do not show a diffstat at the end of the merge"),
>                 PARSE_OPT_NOARG | PARSE_OPT_NONEG),
> @@ -161,9 +180,9 @@ static struct option pull_options[] = {
>         OPT_PASSTHRU(0, "ff", &opt_ff, NULL,
>                 N_("allow fast-forward"),
>                 PARSE_OPT_NOARG),
> -       OPT_PASSTHRU(0, "ff-only", &opt_ff, NULL,
> +       OPT_CALLBACK_F(0, "ff-only", &opt_ff, NULL,
>                 N_("abort if fast-forward is not possible"),
> -               PARSE_OPT_NOARG | PARSE_OPT_NONEG),
> +               PARSE_OPT_NOARG | PARSE_OPT_NONEG, parse_opt_ff_only),
>         OPT_PASSTHRU(0, "verify-signatures", &opt_verify_signatures, NULL,
>                 N_("verify that the named commit has a valid GPG signature"),
>                 PARSE_OPT_NOARG),
> @@ -924,6 +943,9 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>
>         git_config(git_pull_config, NULL);
>
> +       opt_ff = xstrdup_or_null(config_get_ff());
> +       opt_rebase = config_get_rebase();
> +
>         argc = parse_options(argc, argv, prefix, pull_options, pull_usage, 0);
>
>         if (cleanup_arg)
> @@ -935,12 +957,6 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>
>         parse_repo_refspecs(argc, argv, &repo, &refspecs);
>
> -       if (!opt_ff)
> -               opt_ff = xstrdup_or_null(config_get_ff());
> -
> -       if (opt_rebase < 0)
> -               opt_rebase = config_get_rebase();
> -
>         if (read_cache_unmerged())
>                 die_resolve_conflict("pull");
>
> @@ -1037,10 +1053,6 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>                 }
>         }
>
> -       /* Disable --ff-only when --merge is specified */
> -       if (!can_ff && !default_mode && !opt_rebase && opt_ff && !strcmp(opt_ff, "--ff-only"))
> -               opt_ff = NULL;
> -
>         if (opt_rebase) {
>                 int ret = 0;
>                 if ((recurse_submodules == RECURSE_SUBMODULES_ON ||
> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
> index f48d0f8d50..c0cfde54e1 100755
> --- a/t/t5520-pull.sh
> +++ b/t/t5520-pull.sh
> @@ -881,4 +881,27 @@ test_expect_success 'git pull non-fast-forward error message' '
>         grep -q "The pull was not fast-forward" error
>  '
>
> +test_expect_success 'git pull --merge overrides --ffonly' '

You're missing a hyphen there; it should be --ff-only.

> +       test_when_finished "git checkout master && git branch -D other test" &&
> +       test_config pull.ff only &&
> +       git checkout -b other master^ &&
> +       >new &&
> +       git add new &&
> +       git commit -m new &&
> +       git checkout -b test -t other &&
> +       git reset --hard master &&
> +       git pull --ff-only --merge
> +'
> +
> +test_expect_success 'git pull --ff-only overrides --merge' '
> +       test_when_finished "git checkout master && git branch -D other test" &&
> +       git checkout -b other master^ &&
> +       >new &&
> +       git add new &&
> +       git commit -m new &&
> +       git checkout -b test -t other &&
> +       git reset --hard master &&
> +       test_must_fail git pull --merge --ff-only
> +'

What about --ff-only and --rebase?  Are there already tests for those?
