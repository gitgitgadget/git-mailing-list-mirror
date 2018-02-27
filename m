Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4465B1F404
	for <e@80x24.org>; Tue, 27 Feb 2018 20:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751777AbeB0UP6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 15:15:58 -0500
Received: from mail-yb0-f171.google.com ([209.85.213.171]:45434 "EHLO
        mail-yb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751605AbeB0UP5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 15:15:57 -0500
Received: by mail-yb0-f171.google.com with SMTP id e89-v6so25894ybi.12
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 12:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=joVoW+EcNEbR4iL2+0rQvnah3+c/7c4jXtXkQc96128=;
        b=gam4/Fhrv/Zmu7m3vY0XsSVkkm7e4RuCePFtqkJzIrp7wuzUGU9RUcB1yiZojN+jSD
         2yirjbyneHN6ZGY7+uJQauaFoCup4BygqngLX/7bL53ZKH3eJ/LSsFSdnSBl9vD8uXo7
         C9dmolDM8HBHAOSQ1QcrZnDUN98kDxEbsaDSHUxWJt+qMNfFqqqqGpWEnptFi8qd1DmL
         uwINhHKe3Rr/rmX2gz8Eo4MFeKpXtxdI8BePT078TQgecNEebOpGleHWTU/Uow+5Tc8Z
         97Jj3SUwpikXKz7jfSCsD4dBdMfafRBjd4tZ0bdHGNhzwCXmCKX1cxuDz/yJ7ZSIbRfv
         kXFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=joVoW+EcNEbR4iL2+0rQvnah3+c/7c4jXtXkQc96128=;
        b=I8GcIb2JnZdWg2kpwSJXXeIC644mFtXqrfzhIIPm19snhYWc+7Wj6FFQczBGjctb2G
         Mgd0EPL5QIypVE7yNDRa5c0s8XjJzWc/DvHtwNkG8lAsOsAhy76EO25sPN1J4FtSHxgj
         IMA+0OPSE9xsJFcqyr/6lbS9sI+7lXJxVC/s4/AzSPAQH8XoZR9ckb91MhOm3d2KzrLi
         djNIJrHkDRo5RFmG9uxnd+1Goe45roxulcjx9QmaIZJ21NgVbzKfn9oJ/ZbXbdyQQHyB
         nDz/vSpxhzo0yrR+y20OlDs6cohSfSUKIY0cSjjuKJJ5MiQyDl/NWhCBUdvbPqK67jD6
         abfg==
X-Gm-Message-State: APf1xPAlTH3gHQb/XeVTV+I9z+b0032sQJrJz6p7uiuf8tCnTU4f8QZr
        guUwWpd4CZUc+pCWKiSsJ6xGmtqMDSCgfasAoF6MyA==
X-Google-Smtp-Source: AG47ELuRjN9SwhsJniG3D6X875CsLzWwbP4fmTGsV8VqcfsODwMLPL45YKtyUphcxKrAhLHZMNq/XkxLnuKOce1uYis=
X-Received: by 2002:a25:3781:: with SMTP id e123-v6mr774154yba.247.1519762556456;
 Tue, 27 Feb 2018 12:15:56 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:cfcb:0:0:0:0:0 with HTTP; Tue, 27 Feb 2018 12:15:55
 -0800 (PST)
In-Reply-To: <1519698787-190494-12-git-send-email-dstolee@microsoft.com>
References: <1519698787-190494-1-git-send-email-dstolee@microsoft.com> <1519698787-190494-12-git-send-email-dstolee@microsoft.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 27 Feb 2018 12:15:55 -0800
Message-ID: <CAGZ79kYM0fHiYQ2+k5__A2hY1PeCyigYf3n9ZBJSKH8yJZOF0A@mail.gmail.com>
Subject: Re: [PATCH v5 11/13] commit-graph: read only from specific pack-indexes
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> @@ -76,10 +77,18 @@ static int graph_read(int argc, const char **argv)
>
>  static int graph_write(int argc, const char **argv)
>  {
> +       const char **pack_indexes = NULL;
> +       int packs_nr = 0;
> +       const char **lines = NULL;
> +       int lines_nr = 0;
> +       int lines_alloc = 0;
> +
>         static struct option builtin_commit_graph_write_options[] = {
>                 OPT_STRING(0, "object-dir", &opts.obj_dir,
>                         N_("dir"),
>                         N_("The object directory to store the graph")),
> +               OPT_BOOL(0, "stdin-packs", &opts.stdin_packs,
> +                       N_("scan packfiles listed by stdin for commits")),
>                 OPT_END(),
>         };
>
> @@ -90,7 +99,25 @@ static int graph_write(int argc, const char **argv)
>         if (!opts.obj_dir)
>                 opts.obj_dir = get_object_directory();
>
> -       write_commit_graph(opts.obj_dir);
> +       if (opts.stdin_packs) {
> +               struct strbuf buf = STRBUF_INIT;
> +               lines_nr = 0;
> +               lines_alloc = 128;

both lines_nr as well as lines_alloc are already initialized?
