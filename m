Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F37EC433F5
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 05:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01891611BD
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 05:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234039AbhI1FVU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 01:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233290AbhI1FVT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 01:21:19 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40BFC061575
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 22:19:40 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id x33-20020a9d37a4000000b0054733a85462so27489660otb.10
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 22:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IqNyFAIYDWf+cnVZNdpHAhEwepvbnQpJHizZ4OSMhN4=;
        b=hbcq4IpYa4nlOQsTQuJKKC85uqkC4py7YJ6eBo8HK6g4ozeDJELilhWqUsq36NNULr
         VsR7iJWTRpQTMw9s8ntaXfoutTzuMZhZCdAhEXV9Opq1FN5gaZhjm7XeKEmDs3wFajit
         TQrzOTBagX6x+qy/ZXiSsfi1NpUn1Vw6q9Ys7+3bY+gcUEuFE/xW9VfRppCMBymuqiaa
         Q6Q5Nr5EEYwsyvdRMU1XjM1derl8DjrZvAdgOCzEgdWqz2WBt2qLJ0DaobD3K4ZocqP0
         61uzlj4y0Tx/RBDKz2nDNtV+4oigWCgxL4bsf1AzeiDnc+ozTZwoAvBu3YHouVlwmRjK
         phQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IqNyFAIYDWf+cnVZNdpHAhEwepvbnQpJHizZ4OSMhN4=;
        b=IayzMY0PcwAUfq4tROqcVEi42jIksaGszeTXhzmi+bTaPz+mj7zorpQXg1uz96jY5W
         aGC72OdwPy9/hfYJv1KQ9JX8PHeZkVAUL5nHxam6+YU+NzTlVUQ8JYfrhEphRLf2Q1qV
         wEFJXsLP9oXC1/3PIJ40VGJVASkT/xwTGaUk2dhEJVa6vseaXtwwX+UbaZmvVBGcw3rB
         n6qnVKPGSc2YaZv+KZgErus+KOPuN1THceZWRIwa6e5EREjWR5PEoAsN6SRwuSKrw/5o
         uVyszSDSbh6u933XNPhvlrmnRA8aepN4SSSpyWwWU8179AJ9/6CJtvmxXfURuOYIDMEQ
         wVHA==
X-Gm-Message-State: AOAM532dVKIt0m7xYMSA6CWNt1hYJeMJHGXZb7hKD/X3luF+4SXkIG3w
        6PYT5qKGwNt6zCnGyq5SWyXtRC55G/MTu1MlHY4=
X-Google-Smtp-Source: ABdhPJx0Zi/wI58pikhzZguCLvbAduY8Hn8S92VX3FvOZ9PJQrh47gDkMnJdhG3zqWmhK9IP6gqwvsXd0uvLnECokQM=
X-Received: by 2002:a05:6830:2b27:: with SMTP id l39mr3554228otv.25.1632806379919;
 Mon, 27 Sep 2021 22:19:39 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1005.git.1630359290.gitgitgadget@gmail.com> <2cbf0b611133df5fa7eed1bf38460f9d119d2a6e.1630359290.git.gitgitgadget@gmail.com>
In-Reply-To: <2cbf0b611133df5fa7eed1bf38460f9d119d2a6e.1630359290.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 27 Sep 2021 22:19:28 -0700
Message-ID: <CABPp-BH0U9+KEHTuMdfu-jhL+y3eRzjyfuRzWy9-jGxka8PH+Q@mail.gmail.com>
Subject: Re: [PATCH 08/15] scalar: implement the `clone` subcommand
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 30, 2021 at 2:36 PM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
...
>  COMMANDS
>  --------
>
> +Clone
> +~~~~~
> +
> +clone [<options>] <url> [<enlistment>]::
> +    Clones the specified repository, similar to linkgit:git-clone[1]. By
> +    default, only commit and tree objects are cloned. Once finished, the
> +    worktree is located at `<enlistment>/src`.
> ++
> +The sparse-checkout feature is enabled (except when run with `--full-clone`)
> +and the only files present are those in the top-level directory. Use
> +`git sparse-checkout set` to expand the set of directories you want to see,
> +or `git sparse-checkout disable` to expand to all files (see
> +linkgit:git-sparse-checkout[1] for more details). You can explore the
> +subdirectories outside your sparse-checkout by using `git ls-tree HEAD`.

Should this be `git ls-tree [-r] HEAD`?  Do you expect people to just
add directories that are found immediately under the toplevel, rather
than some that are a bit deeper?
