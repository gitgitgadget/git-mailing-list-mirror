Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9EF5C11D00
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 22:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81BA920801
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 22:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=atlassian-com.20150623.gappssmtp.com header.i=@atlassian-com.20150623.gappssmtp.com header.b="SUp2gtwi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729170AbgBTWLK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 17:11:10 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:46063 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727656AbgBTWLK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 17:11:10 -0500
Received: by mail-io1-f66.google.com with SMTP id i11so133657ioi.12
        for <git@vger.kernel.org>; Thu, 20 Feb 2020 14:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=skTQEdAItnWbg8QhkR37HATI/xgDt6mMT4oirxDCGrI=;
        b=SUp2gtwifODzlGoVeiP761z0doresFcqRa8FDg/6AyEcRcaRb1J/OZMzt4qoo4jgAe
         NaMJRva+sW29WhjhDde9uHmAIjBPCvKmeMrGiYsbALu4B9YKRLHhmN5mYp2xf+YIdwrv
         97DqNVxGqaAEgVcyoWJ7m2MZ04WD5s/tK6YP9UQe1DoKeHoPR+PQ+s7/5YeYF31Mi0GL
         LWqamU4FxwZEyyRfdWpdLaDJIa9Yng6NqWC7VYsYCz4ezGbg+0RyRxTOcCLUnPo3sCqk
         NXvZiN+L2mPGIG3OnrC2/7lJCmw2iwxbLh6NLOOWMxvu2IGmsuNjSc5UwrcBAPdWZrL+
         mKNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=skTQEdAItnWbg8QhkR37HATI/xgDt6mMT4oirxDCGrI=;
        b=kcexpUGd7qoVbQFHe3TOqMsXryPgp9qP7dtElWLyNwrg9IJKt7umCk/DH1EQ+4Y4oh
         CJkOPIWjUvRY7Cttmf1G7IFNIBRMSoX/YS3MtL3gemaHi8GXDFvFhjj4xTvica0JWkUi
         lXVc//KRSyScrMY4aYatEC6BIzOKcrtyDBaOKpPbqSLIL2gIFTremr3ayIjziM9qxB4e
         HJ7XoPE9XtaHjbNje9xDOObJ8/iJtzzZ3UMpdajdVdzXPNKM3JVW5uJgpuj9+17r4ttV
         us2frhgMjy3bCVNFrV1sofwmDVETrY6Vnxd9LVUGRDVP02hUtOdrzn3MFZ55hf4zNehi
         g7UA==
X-Gm-Message-State: APjAAAXZrb7rFS5OEpJYKMhtXpXcY09llbRVEhnK/GLjYwQ9cPJRxpLQ
        eBwxo7NnW4oQN04rcxL2/ddeV8oAr0l1iCWiCHgqaY1ZapZ9Jg==
X-Google-Smtp-Source: APXvYqwukKL4wmuROUg6Y4xwZzjKpPy2j15JsuBD8wB6OVFIjjAfyyq1BGBTkHwgR6WA7IGonkWJQRFKIA3A2PTqHMM=
X-Received: by 2002:a6b:7119:: with SMTP id q25mr25042305iog.148.1582236668977;
 Thu, 20 Feb 2020 14:11:08 -0800 (PST)
MIME-Version: 1.0
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
 <pull.497.v2.git.1580943390.gitgitgadget@gmail.com> <3d7ee0c96955dc15c87d04982d8cdec8b62750b2.1580943390.git.gitgitgadget@gmail.com>
In-Reply-To: <3d7ee0c96955dc15c87d04982d8cdec8b62750b2.1580943390.git.gitgitgadget@gmail.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Thu, 20 Feb 2020 14:10:57 -0800
Message-ID: <CAGyf7-FzaG3Jb92JTx1QyADAoLhHCREyadVbTM2vZW-wxK4zEg@mail.gmail.com>
Subject: Re: [PATCH v2 09/11] commit-graph: add --changed-paths option to
 write subcommand
To:     Garima Singh via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Users <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        jeffhost@microsoft.com, me@ttaylorr.com, Jeff King <peff@peff.net>,
        garimasigit@gmail.com, jnareb@gmail.com,
        Christian Couder <christian.couder@gmail.com>,
        emilyshaffer@gmail.com, Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 5, 2020 at 2:56 PM Garima Singh via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Garima Singh <garima.singh@microsoft.com>
>
> Add --changed-paths option to git commit-graph write. This option will
> allow users to compute information about the paths that have changed
> between a commit and its first parent, and write it into the commit graph
> file. If the option is passed to the write subcommand we set the
> COMMIT_GRAPH_WRITE_BLOOM_FILTERS flag and pass it down to the
> commit-graph logic.
>
> Helped-by: Derrick Stolee <dstolee@microsoft.com>
> Signed-off-by: Garima Singh <garima.singh@microsoft.com>
> ---
>  Documentation/git-commit-graph.txt | 5 +++++
>  builtin/commit-graph.c             | 9 +++++++--
>  2 files changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
> index bcd85c1976..907d703b30 100644
> --- a/Documentation/git-commit-graph.txt
> +++ b/Documentation/git-commit-graph.txt
> @@ -54,6 +54,11 @@ or `--stdin-packs`.)
>  With the `--append` option, include all commits that are present in the
>  existing commit-graph file.
>  +
> +With the `--changed-paths` option, compute and write information about the
> +paths changed between a commit and it's first parent. This operation can

"its first parent"

(Pardon the grammar nit from the peanut gallery!)

> +take a while on large repositories. It provides significant performance gains
> +for getting history of a directory or a file with `git log -- <path>`.
> ++
>  With the `--split` option, write the commit-graph as a chain of multiple
>  commit-graph files stored in `<dir>/info/commit-graphs`. The new commits
>  not already in the commit-graph are added in a new "tip" file. This file
> diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
> index e0c6fc4bbf..261dcce091 100644
> --- a/builtin/commit-graph.c
> +++ b/builtin/commit-graph.c
> @@ -9,7 +9,7 @@
>
>  static char const * const builtin_commit_graph_usage[] = {
>         N_("git commit-graph verify [--object-dir <objdir>] [--shallow] [--[no-]progress]"),
> -       N_("git commit-graph write [--object-dir <objdir>] [--append|--split] [--reachable|--stdin-packs|--stdin-commits] [--[no-]progress] <split options>"),
> +       N_("git commit-graph write [--object-dir <objdir>] [--append|--split] [--reachable|--stdin-packs|--stdin-commits] [--changed-paths] [--[no-]progress] <split options>"),
>         NULL
>  };
>
> @@ -19,7 +19,7 @@ static const char * const builtin_commit_graph_verify_usage[] = {
>  };
>
>  static const char * const builtin_commit_graph_write_usage[] = {
> -       N_("git commit-graph write [--object-dir <objdir>] [--append|--split] [--reachable|--stdin-packs|--stdin-commits] [--[no-]progress] <split options>"),
> +       N_("git commit-graph write [--object-dir <objdir>] [--append|--split] [--reachable|--stdin-packs|--stdin-commits] [--changed-paths] [--[no-]progress] <split options>"),
>         NULL
>  };
>
> @@ -32,6 +32,7 @@ static struct opts_commit_graph {
>         int split;
>         int shallow;
>         int progress;
> +       int enable_changed_paths;
>  } opts;
>
>  static int graph_verify(int argc, const char **argv)
> @@ -110,6 +111,8 @@ static int graph_write(int argc, const char **argv)
>                         N_("start walk at commits listed by stdin")),
>                 OPT_BOOL(0, "append", &opts.append,
>                         N_("include all commits already in the commit-graph file")),
> +               OPT_BOOL(0, "changed-paths", &opts.enable_changed_paths,
> +                       N_("enable computation for changed paths")),
>                 OPT_BOOL(0, "progress", &opts.progress, N_("force progress reporting")),
>                 OPT_BOOL(0, "split", &opts.split,
>                         N_("allow writing an incremental commit-graph file")),
> @@ -143,6 +146,8 @@ static int graph_write(int argc, const char **argv)
>                 flags |= COMMIT_GRAPH_WRITE_SPLIT;
>         if (opts.progress)
>                 flags |= COMMIT_GRAPH_WRITE_PROGRESS;
> +       if (opts.enable_changed_paths)
> +               flags |= COMMIT_GRAPH_WRITE_BLOOM_FILTERS;
>
>         read_replace_refs = 0;
>
> --
> gitgitgadget
>
