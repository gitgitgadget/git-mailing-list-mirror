Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F2EEC433EF
	for <git@archiver.kernel.org>; Sat,  7 May 2022 02:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445309AbiEGCKw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 May 2022 22:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445301AbiEGCKs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 May 2022 22:10:48 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97BA4B1C5
        for <git@vger.kernel.org>; Fri,  6 May 2022 19:07:02 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id p4so10544513edx.0
        for <git@vger.kernel.org>; Fri, 06 May 2022 19:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+4Gzy2ORIs2k4RHPxjcv+TTrx3mlS0kX6Fd0GlM2Cc4=;
        b=Mv2GhVNnyd06+mAKCusMl2LA1EEYI4C0NKqCOyWpPSF+vYohMYYKZtVorRVl+JFsx1
         JGlKqwEXyamZ0+N0BAbREcqjBx6y1POabLXdEnJmT5W1e2+aaR1HTXYRWxsHQ7g/j1+l
         299DqepzqrkAd1hNrZBwp6CnAamfWnN2U7M8Wex7cncBeW1tWrz3rmo+Yxc9aw/nxyKs
         xGuFFVPXcQq4NVOjc8rBepVapZJTr9+ZNUXvH1xigVmkkmhKOEPt6x/z8yCkTZILlM2g
         VXLAV/jr8xCl2/MdqIpGIeZIrf4ZFpbVi3VxkwRqG2DrIYlp9LX8CBhxjvLk7Ga1QxTA
         e9Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+4Gzy2ORIs2k4RHPxjcv+TTrx3mlS0kX6Fd0GlM2Cc4=;
        b=McEiqkrxrVoDj91WTIy31yBL1GPQQsSsCSQyb+Ag6XI+9clTozM4t+UCzCLNSkg68m
         dd5v7coQG76Q2zSu8L8MYU/6TFJ+AMkgn2byTWAWNEzOFhMY0hAN3fcTRHDhw2cBdntS
         U7Kt0tG5JGkEfY5trOFSCci1Vbe8aq9OG6mDI/B/4491UyW9USsZwB+XMh3XKsw4Gh8A
         RJRTKKnVx21cLbAXThGwDIw6lUHZIafoD28Bc2zKHr9YyjgYYk4EVBFYGYgoD2XccPA0
         JKOU0k5CGOED2d0+xp8euCHbgfNWF3tSkFZ9yms9lCF3FH75HaINbARCNWuo9KomwvLh
         Uk9Q==
X-Gm-Message-State: AOAM533Q3ThFj1XccQ6KIjVpqFUzykfmv+I/zPjz4MmjTu2VjX9ccbC7
        6t4ZK1TDg/ff7yCqHQ6iCnZe3WXvwbBwRq+GrJM=
X-Google-Smtp-Source: ABdhPJxVeHC1giRIi6yWNJZ3qne7IzamoEddCnnSZVBaWMGw1RbPf8CgeMadKZDDdEUZVvTYlvqnN/4duxUYy6Tei2c=
X-Received: by 2002:a05:6402:268e:b0:427:bb19:f889 with SMTP id
 w14-20020a056402268e00b00427bb19f889mr6681274edd.33.1651889221266; Fri, 06
 May 2022 19:07:01 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1128.v2.git.1644187146.gitgitgadget@gmail.com>
 <pull.1128.v3.git.1651677919.gitgitgadget@gmail.com> <ce4b1b680c98d0f55d4d307b8c746a81d90ffa06.1651677919.git.gitgitgadget@gmail.com>
In-Reply-To: <ce4b1b680c98d0f55d4d307b8c746a81d90ffa06.1651677919.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 6 May 2022 19:06:50 -0700
Message-ID: <CABPp-BEpA52Zq=43j3D=io7h4ooSVGd-644iJkGU5+MmsJjDZw@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] archive --add-file-with-contents: allow paths
 containing colons
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 4, 2022 at 8:25 AM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> By allowing the path to be enclosed in double-quotes, we can avoid
> the limitation that paths cannot contain colons.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  Documentation/git-archive.txt | 13 +++++++++----
>  archive.c                     | 34 +++++++++++++++++++++++++++++-----
>  t/t5003-archive-zip.sh        |  8 ++++++++
>  3 files changed, 46 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
> index a0edc9167b2..1789ce4c232 100644
> --- a/Documentation/git-archive.txt
> +++ b/Documentation/git-archive.txt
> @@ -67,10 +67,15 @@ OPTIONS
>         by concatenating the value for `--prefix` (if any) and the
>         basename of <file>.
>  +
> -The `<path>` cannot contain any colon, the file mode is limited to
> -a regular file, and the option may be subject to platform-dependent
> -command-line limits. For non-trivial cases, write an untracked file
> -and use `--add-file` instead.
> +The `<path>` argument can start and end with a literal double-quote
> +character. In this case, the backslash is interpreted as escape
> +character. The path must be quoted if it contains a colon, to avoid
> +the colon from being misinterpreted as the separator between the
> +path and the contents.

The path must also be quoted if it begins or ends with a double-quote, right?

Also, would people want to be able to pass a pathname from the output
of e.g. `git ls-files -o`, which may quote additional characters?

> ++
> +The file mode is limited to a regular file, and the option may be
> +subject to platform-dependent command-line limits. For non-trivial
> +cases, write an untracked file and use `--add-file` instead.
>
>  --worktree-attributes::
>         Look for attributes in .gitattributes files in the working tree
> diff --git a/archive.c b/archive.c
> index d798624cd5f..3b751027143 100644
> --- a/archive.c
> +++ b/archive.c
> @@ -533,13 +533,37 @@ static int add_file_cb(const struct option *opt, const char *arg, int unset)
>                         die(_("Not a regular file: %s"), path);
>                 info->content = NULL; /* read the file later */
>         } else {
> -               const char *colon = strchr(arg, ':');
>                 char *p;
>
> -               if (!colon)
> -                       die(_("missing colon: '%s'"), arg);
> +               if (*arg != '"') {
> +                       const char *colon = strchr(arg, ':');
> +
> +                       if (!colon)
> +                               die(_("missing colon: '%s'"), arg);
> +                       p = xstrndup(arg, colon - arg);
> +                       arg = colon + 1;
> +               } else {
> +                       struct strbuf buf = STRBUF_INIT;
> +                       const char *orig = arg;
> +
> +                       for (;;) {
> +                               if (!*(++arg))
> +                                       die(_("unclosed quote: '%s'"), orig);
> +                               if (*arg == '"')
> +                                       break;
> +                               if (*arg == '\\' && *(++arg) == '\0')
> +                                       die(_("trailing backslash: '%s"), orig);
> +                               else
> +                                       strbuf_addch(&buf, *arg);
> +                       }
> +
> +                       if (*(++arg) != ':')
> +                               die(_("missing colon: '%s'"), orig);
> +
> +                       p = strbuf_detach(&buf, NULL);
> +                       arg++;
> +               }

Should we use unquote_c_style() here instead of rolling another parser
to do unquoting?  That would have the added benefit of allowing people
to use filenames from the output of various git commands that do
special quoting -- such as octal sequences for non-ascii characters.

>
> -               p = xstrndup(arg, colon - arg);
>                 if (!args->prefix)
>                         path = p;
>                 else {
> @@ -548,7 +572,7 @@ static int add_file_cb(const struct option *opt, const char *arg, int unset)
>                 }
>                 memset(&info->stat, 0, sizeof(info->stat));
>                 info->stat.st_mode = S_IFREG | 0644;
> -               info->content = xstrdup(colon + 1);
> +               info->content = xstrdup(arg);
>                 info->stat.st_size = strlen(info->content);
>         }
>         item = string_list_append_nodup(&args->extra_files, path);
> diff --git a/t/t5003-archive-zip.sh b/t/t5003-archive-zip.sh
> index 8ff1257f1a0..5b8bbfc2692 100755
> --- a/t/t5003-archive-zip.sh
> +++ b/t/t5003-archive-zip.sh
> @@ -207,13 +207,21 @@ check_zip with_untracked
>  check_added with_untracked untracked untracked
>
>  test_expect_success UNZIP 'git archive --format=zip --add-file-with-content' '
> +       if test_have_prereq FUNNYNAMES
> +       then
> +               QUOTED=quoted:colon
> +       else
> +               QUOTED=quoted
> +       fi &&
>         git archive --format=zip >with_file_with_content.zip \
> +               --add-file-with-content=\"$QUOTED\": \
>                 --add-file-with-content=hello:world $EMPTY_TREE &&
>         test_when_finished "rm -rf tmp-unpack" &&
>         mkdir tmp-unpack && (
>                 cd tmp-unpack &&
>                 "$GIT_UNZIP" ../with_file_with_content.zip &&
>                 test_path_is_file hello &&
> +               test_path_is_file $QUOTED &&
>                 test world = $(cat hello)
>         )
>  '
> --
> gitgitgadget
