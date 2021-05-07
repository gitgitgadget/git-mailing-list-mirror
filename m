Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B292C433ED
	for <git@archiver.kernel.org>; Fri,  7 May 2021 17:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3179E6145A
	for <git@archiver.kernel.org>; Fri,  7 May 2021 17:57:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbhEGR6y (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 May 2021 13:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhEGR6x (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 May 2021 13:58:53 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25EEEC061574
        for <git@vger.kernel.org>; Fri,  7 May 2021 10:57:53 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 36-20020a9d0ba70000b02902e0a0a8fe36so2311648oth.8
        for <git@vger.kernel.org>; Fri, 07 May 2021 10:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zv8GtT6C2zJClgajFOBvg0x1ywtmYN3/LcbBvtH3Yi0=;
        b=ILO8SyEI8VQUrZRo8z+lO3XCbHnu981aVYJoUdHLEXnjSS4NEKHh6Rt67xRX2UaSE0
         NYdHjiaPyiwSkqyWvOWnVXyd5kLffAUBkAAcqwtS9e61Jcry92KTb6MXdxRN95lT7voe
         KsOpkUw7f+MKHXiaOUEa4wN+9u4gMO6lBcxEnuN6Jcg599qJQyh1G8uzNct8wi+I0C9p
         tzHvvrIqirjeENNgg8yp8J6NUunQ1BmbJxKCmkJS3eX8UfEipgMzXaYgMdwIMPt9cO5w
         SvA7oxMZV+N+vLZCEEnUW1Hzw/8nziqyOfXOsP3JcNbQJXVFDW1ajOT7vp/BJUlkGrW5
         HLHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zv8GtT6C2zJClgajFOBvg0x1ywtmYN3/LcbBvtH3Yi0=;
        b=BBSwcnFS/SmMOqkbQMnxn3ZqArM8yYxhvubYTS8HITTDyrwRANq69ARX71tJ7t65w3
         iExhVE8mVMQJHf0nGW8FGLaRiOZO11fiNCZNWsnzSLsEvWgfCS6y3Uqey+zrDxqzmwBw
         5OrDjo1ytfLMhz8UXykOXA+jWr9BCJKTV76hxxbfku2s/10s0Ammr9gBEgEOvuwZ7MhJ
         LcInG1/df2m6j7fifaTC4aGaatB6wIn4XIkUoWkWdiisGXMLXWJSH1LIL6f/whAYNPdl
         NrOJ/HMqHWQIr8Vi6fcSgKtUrQ7l2iTn8/QDqbDT/PKqW6SU+s3JdMIcfBQrbiElwPKx
         cMlw==
X-Gm-Message-State: AOAM532K4e5uSK5oqY5YMvuZp3V6helZrIp55WYIObc+wN+k6G4nyKAj
        NQusjW/+wlNpxRr6C9WE8ZqZpZWpGDg90Sb4v60=
X-Google-Smtp-Source: ABdhPJzH50rDrsgOjGtGKthqzA0HgjAsVvJSuemsyHjuXgFdikXNYWI0bcaJk6FXEf32e4nwmjRJ7n9wqdYEqc3H3SE=
X-Received: by 2002:a9d:7096:: with SMTP id l22mr1928444otj.345.1620410272567;
 Fri, 07 May 2021 10:57:52 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1020.git.git.1620360300.gitgitgadget@gmail.com> <3343338e-9262-dfd1-90ef-36908c91dad4@gmail.com>
In-Reply-To: <3343338e-9262-dfd1-90ef-36908c91dad4@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 7 May 2021 10:57:41 -0700
Message-ID: <CABPp-BFudyBP8c_ROmxDEeuu5AfdoyVW8hNPYqVdFPFNofJnCQ@mail.gmail.com>
Subject: Re: [PATCH 6/5] dir: update stale description of treat_directory()
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 7, 2021 at 9:22 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 5/7/2021 12:04 AM, Elijah Newren via GitGitGadget wrote:
> > This patchset fixes a few directory traversal issues, where fill_directory()
> > would traverse into directories that it shouldn't and not traverse into
> > directories that it should. One of these issues was reported recently on
> > this list[1], another was found at $DAYJOB.
> >
> > The fifth patch might have backward compatibility implications, but is easy
> > to review. Even if the logic in dir.c makes your eyes glaze over, at least
> > take a look at the fifth patch.
>
> My eyes were glazing over, so I went to read the whole treat_directory()
> method and its related documentation comment. I found it to be a bit
> confusing that it was referencing names that were deprecated 12 years ago.
>
> Here is a patch that you could add to this series to improve these
> comments.
>
> Thanks,
> -Stolee
>
> -- >8 --
>
> From 587a94ac396c969b6e7734ee46afeac20e87ccb9 Mon Sep 17 00:00:00 2001
> From: Derrick Stolee <dstolee@microsoft.com>
> Date: Fri, 7 May 2021 12:14:13 -0400
> Subject: [PATCH] dir: update stale description of treat_directory()
>
> The documentation comment for treat_directory() was originally written
> in 095952 (Teach directory traversal about subprojects, 2007-04-11)
> which was before the 'struct dir_struct' split its bitfield of named
> options into a 'flags' enum in 7c4c97c0 (Turn the flags in struct
> dir_struct into a single variable, 2009-02-16). When those flags
> changed, the comment became stale, since members like
> 'show_other_directories' transitioned into flags like
> DIR_SHOW_OTHER_DIRECTORIES.
>
> Update the comments for treat_directory() to use these flag names rather
> than the old member names.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  dir.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/dir.c b/dir.c
> index 3beb8e17a83..0a0138bc1aa 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -1749,13 +1749,13 @@ static enum exist_status directory_exists_in_index(struct index_state *istate,
>   * Case 3: if we didn't have it in the index previously, we
>   * have a few sub-cases:
>   *
> - *  (a) if "show_other_directories" is true, we show it as
> - *      just a directory, unless "hide_empty_directories" is
> + *  (a) if DIR_SHOW_OTHER_DIRECTORIES flag is set, we show it as
> + *      just a directory, unless DIR_HIDE_EMPTY_DIRECTORIES is
>   *      also true, in which case we need to check if it contains any
>   *      untracked and / or ignored files.
> - *  (b) if it looks like a git directory, and we don't have
> - *      'no_gitlinks' set we treat it as a gitlink, and show it
> - *      as a directory.
> + *  (b) if it looks like a git directory and we don't have the
> + *      DIR_NO_GITLINKS flag, then we treat it as a gitlink, and
> + *      show it as a directory.
>   *  (c) otherwise, we recurse into it.
>   */
>  static enum path_treatment treat_directory(struct dir_struct *dir,
> @@ -1843,7 +1843,6 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
>                 return path_recurse;
>         }
>
> -       /* This is the "show_other_directories" case */
>         assert(dir->flags & DIR_SHOW_OTHER_DIRECTORIES);
>
>         /*
> @@ -1858,7 +1857,7 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
>         /* Special cases for where this directory is excluded/ignored */
>         if (excluded) {
>                 /*
> -                * In the show_other_directories case, if we're not
> +                * If DIR_SHOW_OTHER_DIRECTORIES is set and we're not
>                  * hiding empty directories, there is no need to
>                  * recurse into an ignored directory.
>                  */
> --
> 2.31.1.vfs.0.0.80.gb082c853c0e

Looks good to me; I'll give it some more time for other comments to
come in, but when I re-roll, I'll include this patch of yours.
