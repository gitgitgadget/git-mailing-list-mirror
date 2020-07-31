Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649E6C433E0
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 16:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D2EB2177B
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 16:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mL5ImWLp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732474AbgGaQWI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 12:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730974AbgGaQWH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 12:22:07 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC48C061574
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 09:22:07 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id w9so31958901ejc.8
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 09:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HHYgwFZctJ5lpPwVgKNqNT57Twy5iuuklknEpWg28Mw=;
        b=mL5ImWLpPbFDiY1nmeWGYe8Jxgdq0ehEkuywjv2uz2jYejwjcQTFaR5jCagYcE850S
         ua25tJ6kLAPjWeTRtoVF44bRfxoEBJr39tDlqFVDos8sseK4jue6MOhe4PaIj4qp+AOa
         bPthveIUomILO6cwYdh70w3v+6wC6WTXEzsJ/e1v/j79YRwc5cjrgLdlOLEiuLIWTq9O
         LrooaSQWExn4n/PZOmvN88YrC1uhr2ARfFTgkL5NGkjUH4PNV+upv171GneRHbQCzbH2
         Q54fWnxvIjGIN0FZ89o0PXh+b0Wutx9xlLlmf+YhDWlCUw5bXzHvYJ1uFSs+0uQbS5Sg
         5u6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HHYgwFZctJ5lpPwVgKNqNT57Twy5iuuklknEpWg28Mw=;
        b=E/K4ef7AWayRDp9Sprw1ai5Rv0EMMiNR3+5r5nZVmH4er+/1bUkGJ7hsQ1uy0cniBy
         UL40tToASgtIfJsy+pPLmMFPx0oRJsOTXpt9Of8LAfizaX7PT2lGNYdKpUpLsFtWqheE
         uypRHesSc0LY03vcsn76oBqgiywuuMYHnJmJIpXvWZ7XDNmedoElPto+kE15yarIzrpf
         6lbgK9tUe8u4+bnImPTEXKqHqzb75j1PqB9hEn0cmnA3t4Nd4l4EVUuTv0f2aQmH8+HJ
         LojaXEV0iMZ9XNg8hXTokOdoM6yD1y38jUY+WY+gc3YbFQ+mBXtusiz+kbUKFt6SCy11
         w7vw==
X-Gm-Message-State: AOAM530/bLmrRriOy3i9kL13qf5zo9egyltPg+rUeFM1Zr6mYlwCouXD
        Qzdu3TjdwQHA+JErViu74pjz+Plp6fOe/2DG5JzSWNEGARc=
X-Google-Smtp-Source: ABdhPJwzGobOESc0sJhWFMcjT6Kfu0nZ1bg33tyAUMWxgRPOcBa98pzjiY0z4gr7i784z9G57lOcNmWpHC9hSwxepOs=
X-Received: by 2002:a17:906:38d8:: with SMTP id r24mr4647766ejd.341.1596212526170;
 Fri, 31 Jul 2020 09:22:06 -0700 (PDT)
MIME-Version: 1.0
References: <pull.687.git.1596181765336.gitgitgadget@gmail.com>
In-Reply-To: <pull.687.git.1596181765336.gitgitgadget@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 31 Jul 2020 18:21:54 +0200
Message-ID: <CAP8UFD3QF9P4UvQqaguc0MgNijBvzC4KhF=D_+MN+NjfaR535g@mail.gmail.com>
Subject: Re: [PATCH] commit-graph: add verify changed paths option
To:     Son Luong Ngoc via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>, Son Luong Ngoc <sluongng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 31, 2020 at 9:52 AM Son Luong Ngoc via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Son Luong Ngoc <sluongng@gmail.com>
>
> Add '--has-changed-paths' option to 'git commit-graph verify' subcommand
> to validate whether the commit-graph was written with '--changed-paths'
> option.
>
> Signed-off-by: Son Luong Ngoc <sluongng@gmail.com>

[...]

>     It's probably going to take me a bit more time to write up some tests
>     for this,

It would need some documentation too.

> so I want to send it out first for comments.

[...]

> diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
> index 16c9f6101a..ce8a7cbe90 100644
> --- a/builtin/commit-graph.c
> +++ b/builtin/commit-graph.c
> @@ -18,7 +18,8 @@ static char const * const builtin_commit_graph_usage[] = {
>  };
>
>  static const char * const builtin_commit_graph_verify_usage[] = {
> -       N_("git commit-graph verify [--object-dir <objdir>] [--shallow] [--[no-]progress]"),
> +       N_("git commit-graph verify [--object-dir <objdir>] [--shallow] "
> +           "[--has-changed-paths] [--[no-]progress]"),
>         NULL
>  };
>
> @@ -37,6 +38,7 @@ static struct opts_commit_graph {
>         int append;
>         int split;
>         int shallow;
> +       int has_changed_paths;
>         int progress;
>         int enable_changed_paths;
>  } opts;
> @@ -71,12 +73,14 @@ static int graph_verify(int argc, const char **argv)
>         int open_ok;
>         int fd;
>         struct stat st;
> -       int flags = 0;
> +       enum commit_graph_verify_flags flags = 0;
>
>         static struct option builtin_commit_graph_verify_options[] = {
>                 OPT_STRING(0, "object-dir", &opts.obj_dir,
>                            N_("dir"),
>                            N_("The object directory to store the graph")),
> +               OPT_BOOL(0, "has-changed-paths", &opts.has_changed_paths,
> +                        N_("verify that the commit-graph includes changed paths")),
>                 OPT_BOOL(0, "shallow", &opts.shallow,
>                          N_("if the commit-graph is split, only verify the tip file")),
>                 OPT_BOOL(0, "progress", &opts.progress, N_("force progress reporting")),
> @@ -94,8 +98,10 @@ static int graph_verify(int argc, const char **argv)
>                 opts.obj_dir = get_object_directory();
>         if (opts.shallow)
>                 flags |= COMMIT_GRAPH_VERIFY_SHALLOW;
> +       if (opts.has_changed_paths)
> +               flags |= COMMIT_GRAPH_VERIFY_CHANGED_PATHS;

I wonder if OPT_BIT() could be used instead of OPT_BOOL() above to
directly set the above flag, as the 'has_changed_paths' field in
'struct opts_commit_graph' seems to be used only for the purpose of
setting this flag.

>         if (opts.progress)
> -               flags |= COMMIT_GRAPH_WRITE_PROGRESS;
> +               flags |= COMMIT_GRAPH_VERIFY_PROGRESS;

Does this change belong to this patch? I think it would deserve an
explanation in the commit message if that's the case.

>         odb = find_odb(the_repository, opts.obj_dir);
>         graph_name = get_commit_graph_filename(odb);
> diff --git a/commit-graph.c b/commit-graph.c
> index 1af68c297d..d83f5a2325 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -250,7 +250,7 @@ struct commit_graph *load_commit_graph_one_fd_st(int fd, struct stat *st,
>         return ret;
>  }
>
> -static int verify_commit_graph_lite(struct commit_graph *g)
> +static int verify_commit_graph_lite(struct commit_graph *g, int verify_changed_path)

[...]

> -int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
> +int verify_commit_graph(struct repository *r,
> +                       struct commit_graph *g,
> +                       enum commit_graph_verify_flags flags)

It seems to me that it would be more coherent to have both
verify_commit_graph() and verify_commit_graph_lite() accept an 'enum
commit_graph_verify_flags flags' argument.

Right now the "has_changed_paths" option is first an int, then it's
converted to a flag and then to an int again before being passed to
verify_commit_graph_lite(). It would be simpler if it could be a flag
all along.

Thanks,
Christian.
