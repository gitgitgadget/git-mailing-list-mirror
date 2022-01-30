Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C86C433EF
	for <git@archiver.kernel.org>; Sun, 30 Jan 2022 06:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345157AbiA3Gju (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 Jan 2022 01:39:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241248AbiA3Gjt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Jan 2022 01:39:49 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2B4C061714
        for <git@vger.kernel.org>; Sat, 29 Jan 2022 22:39:48 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id s5so32064329ejx.2
        for <git@vger.kernel.org>; Sat, 29 Jan 2022 22:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Aynt1iRVyKoBwT9pc4fFglAAIpNrrd5mSrEK+t+u2Y4=;
        b=LsKVbgtdrja1iv5yqTAGnsMxt9aqwzoyz0atNJoFdnUkpkvB/9I1iYC2yH39ZvtoQU
         W7axKEi+fXuLdHpL4E0mamqAgzzWYXxPs41CAhm/uTpBac7XjA0DeqarAzXGOBoiYH6u
         /m6o8b1gj13EJZufTHIVw0o6FI5RqRY9FyNBOk2+W+lA3jYwhGqryomQPEFBjXngzODK
         2HMs+AcOZFd+YOOWeP198MX3F2zdn9C1yhKhNUBVtgtY81oNMIm1XNkbVmH4RnsGcLuz
         FyMMyNcqQSS0cbXFXKMEU7naf5jGUiSKic3J0J+cyxfAG++p3+RAm6x3/Y5ZwZwwMMu2
         FPuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Aynt1iRVyKoBwT9pc4fFglAAIpNrrd5mSrEK+t+u2Y4=;
        b=tChchymTSYNBojh5vBvkokjZUkeIhfkNIO9hoAuA7ObubuoBxuV3hIAbHkJvJer0NL
         hR/nGlQRSFBPeBAjk03YjuJ1jfxKqavqym8ym0bw4T5eSUrCj0RUJyGqfhaFI1adOxLu
         e5oGfddYIbUhdvJF+2Vt0mKCGtWnsEYDJLl5SC80qQQEYLketeawHYxJIuKd+X6w2JL3
         T5X7D4b1WkRlYAE8hoZ4Bpd8RnLUWKT3MCiqaa1QIzJyh4uZJG/WGCJtFwySiJc0hcyt
         THsB98PqPqxbNhBrpPLzFUvGXAtaIQoVPOMpeb1/EuR5ddBYY2IAuIo9zjemFt9H1G8f
         ELyg==
X-Gm-Message-State: AOAM533UQx6XK7QH3JDU3pRC+D0fAwx/jenfI+jx8J9AbyXAXbd3sQg5
        qmqFPCtWcVxA52+hi87fUA30Lg36SLGq0l8qRAqc4k4P
X-Google-Smtp-Source: ABdhPJyFw2LY7HIOa7NR4UWktbBUBTebW3pt2IJAyd+6lt5PjHL4A9rMpkZ8vMS7hUpFtTYhxjqkxISIk/N7zNjkII4=
X-Received: by 2002:a17:906:4c47:: with SMTP id d7mr5776239ejw.192.1643524786967;
 Sat, 29 Jan 2022 22:39:46 -0800 (PST)
MIME-Version: 1.0
References: <pull.1132.git.1643328752.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.git.1643328752.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 29 Jan 2022 22:39:35 -0800
Message-ID: <CABPp-BHtki3WupjbeyoQu9Li0S0kQV5rXWC0RN8_Pt524iUZOw@mail.gmail.com>
Subject: Re: [PATCH 00/11] Finish converting git bisect into a built-in
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 28, 2022 at 3:08 PM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> After three GSoC/Outreachy students spent an incredible effort on this, it
> is finally time to put a neat little bow on it.
>
> Johannes Schindelin (11):
>   bisect run: fix the error message
>   bisect--helper: retire the --no-log option
>   bisect--helper: really retire --bisect-next-check
>   bisect--helper: really retire `--bisect-autostart`
>   bisect--helper: align the sub-command order with git-bisect.sh
>   bisect--helper: make `--bisect-state` optional
>   bisect: move even the option parsing to `bisect--helper`
>   bisect--helper: using `--bisect-state` without an argument is a bug
>   Turn `git bisect` into a full built-in.
>   bisect: remove Cogito-related code
>   bisect: no longer try to clean up left-over `.git/head-name` files
>
>  Makefile                               |   3 +-
>  bisect.c                               |   3 -
>  builtin.h                              |   2 +-
>  builtin/{bisect--helper.c => bisect.c} | 201 ++++++++++---------------
>  git-bisect.sh                          |  84 -----------
>  git.c                                  |   2 +-
>  t/t6030-bisect-porcelain.sh            |   1 -
>  7 files changed, 84 insertions(+), 212 deletions(-)
>  rename builtin/{bisect--helper.c => bisect.c} (87%)
>  delete mode 100755 git-bisect.sh

I read through the series and couldn't spot any problems.
