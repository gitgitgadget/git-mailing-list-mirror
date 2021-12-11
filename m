Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF15AC433F5
	for <git@archiver.kernel.org>; Sat, 11 Dec 2021 02:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236141AbhLKCLn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 21:11:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbhLKCLn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 21:11:43 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6891EC061714
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 18:08:07 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id w1so35059880edc.6
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 18:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skydio.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=nXaclRxb1N+l8LiuxYY5NZCeYLTRHT8nSsK5lb1Wywo=;
        b=RZmuknFYOfCjnzUkjBcrcWXTCe4wWPTNn/iKqsO7ygPuYcwkkfwXczyYnkCfX88mzP
         hrczJY3J+idaJH2JocrjFJtGLFl6toSQviJPmews1TprgxKnm3qsGKE4ieK0I2UgyVwW
         gqx9PlmElQiPd/rrnFZP2H8YxybsOhtMpWz5G/ZPI0DfZcDrY+cbNE31fEAJZfPEmyPi
         cOT2eHupqoWS32zb8qiFLcZ+EeFoJ6k8GV5iegtC/6RXHjNdPPBYOwGdvldi7zfYUf+U
         FiR7rJQzg4aLb+VT/FQSBdx+KG0IcU3BhL8k0stZ5mh1k6E07BXK4N85P7FtCV8l5CqI
         rj8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=nXaclRxb1N+l8LiuxYY5NZCeYLTRHT8nSsK5lb1Wywo=;
        b=w8VkCR+7+FuTkbtigfSjovZKkASDN+qOr8SBcYNDjgyJ+VwWlyeE1gS4XvJl1N0kwe
         vvSCNRYlwY+7cV1lW9cvfASnBXrbBoHZF8rYhaiPmFyFMIYepT/QAtfCac3lEXY5Zfoy
         EQSeTyY2MG4KNA6vW4Rl9ZW27uDbtLt6xqWOlV+jqi+vZnw38MpULIm1XFs+eVFKxcg2
         g9m0HKfRCoSzYaPo9xqIXUSaHp0GkIWYvn2TTMAGBCQ5f01MjmZn9sStD/84hMQ6CxNm
         24BmviIRIVZmHozxH91sAqa42EyCDXqJsSUPkhG8JoJFH4fCfBZMwaA7ydBjB5ODaD9V
         3ZYg==
X-Gm-Message-State: AOAM530/J1xTmosfWRWToqW8X0ZsmztCQ+ICgKb7GueB9cYAOahWVrE1
        EdzNYnyHjF2qIOZfYoGRDJiPbgbaSKHrsDH1SGSkgXFdSKw=
X-Google-Smtp-Source: ABdhPJyTwMEqtThaaNi9rCJtzVWhEBG4IZLk4mC0jNqWGhPh/HqdPmeXhHragO0gqILQJccX3oy4zDTMoD6GNzSqRy8=
X-Received: by 2002:a17:906:31c2:: with SMTP id f2mr28885068ejf.341.1639188485724;
 Fri, 10 Dec 2021 18:08:05 -0800 (PST)
MIME-Version: 1.0
References: <20210427194106.14500-1-jerry@skydio.com> <20210728032230.24611-1-jerry@skydio.com>
In-Reply-To: <20210728032230.24611-1-jerry@skydio.com>
From:   Jerry Zhang <jerry@skydio.com>
Date:   Fri, 10 Dec 2021 18:07:55 -0800
Message-ID: <CAMKO5CvR2m6nvGXfqap=9w07Mw1p2Sgvw39dfhdJVU28K+ZCbg@mail.gmail.com>
Subject: Re: [PATCH V2] git-apply: add --quiet flag
To:     git@vger.kernel.org, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 27, 2021 at 8:22 PM Jerry Zhang <jerry@skydio.com> wrote:
>
> Replace OPT_VERBOSE with OPT_VERBOSITY.
>
> This adds a --quiet flag to "git apply" so
> the user can turn down the verbosity.
>
> Signed-off-by: Jerry Zhang <jerry@skydio.com>
> ---
> V1->V2: rebase on master and rerun tests
>
>  Documentation/git-apply.txt | 7 ++++++-
>  apply.c                     | 2 +-
>  2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
> index aa1ae56a25..a32ad64718 100644
> --- a/Documentation/git-apply.txt
> +++ b/Documentation/git-apply.txt
> @@ -16,7 +16,7 @@ SYNOPSIS
>           [--ignore-space-change | --ignore-whitespace]
>           [--whitespace=(nowarn|warn|fix|error|error-all)]
>           [--exclude=<path>] [--include=<path>] [--directory=<root>]
> -         [--verbose] [--unsafe-paths] [<patch>...]
> +         [--verbose | --quiet] [--unsafe-paths] [<patch>...]
>
>  DESCRIPTION
>  -----------
> @@ -228,6 +228,11 @@ behavior:
>         current patch being applied will be printed. This option will cause
>         additional information to be reported.
>
> +-q::
> +--quiet::
> +       Suppress stderr output. Messages about patch status and progress
> +       will not be printed.
> +
>  --recount::
>         Do not trust the line counts in the hunk headers, but infer them
>         by inspecting the patch (e.g. after editing the patch without
> diff --git a/apply.c b/apply.c
> index fb321c707b..d530c3eb47 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -5051,7 +5051,7 @@ int apply_parse_options(int argc, const char **argv,
>                         N_("leave the rejected hunks in corresponding *.rej files")),
>                 OPT_BOOL(0, "allow-overlap", &state->allow_overlap,
>                         N_("allow overlapping hunks")),
> -               OPT__VERBOSE(&state->apply_verbosity, N_("be verbose")),
> +               OPT__VERBOSITY(&state->apply_verbosity),
>                 OPT_BIT(0, "inaccurate-eof", options,
>                         N_("tolerate incorrectly detected missing new-line at the end of file"),
>                         APPLY_OPT_INACCURATE_EOF),
> --
> 2.32.0.1314.g6ed4fcc4cc
>
Any updates on this patch?
