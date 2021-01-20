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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4CEC433E0
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 18:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9B99233ED
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 18:31:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404522AbhATSag (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 13:30:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404431AbhATSVu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 13:21:50 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E64C061575
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 10:21:09 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id q205so25962338oig.13
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 10:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R6rFV6CjnyGJnHHsDJMzC1SDYWhZwVnmcT0aNrYKey8=;
        b=ZGZCvoDnbfRjk2J2+Aoba2/A5FW+8gCKtb7ylEd8YwEvAexOeFClNeuQLy4MrYOhKb
         w/Hj4JYxNmFysc2yeoRnSkTp9gWfRb6OSbnknOIYrz2uNH5/0ZhDehyR497LqJeH89N/
         9nqWde/n7NlzTTzhYDULYm3OfV5TULbDl4ybyW+Q2hk5q8g+5PNYmVmx4OVts1ADX6+b
         LtPe7WmImGT/CjCuAIlvA7W9SxoGUbQXhSa/+opP8lrMiPtr/ypn8FjimjhSugRWYnhR
         8Mf3Y3C0jF+RFp+SGQiyXtqkYG0iu1awSAeXIu2o3p9x7P6A2RaXVK3uLSUWl9g/dI2N
         ZMsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R6rFV6CjnyGJnHHsDJMzC1SDYWhZwVnmcT0aNrYKey8=;
        b=aG+Y1tbSvxKOlt6cOYvcmt9sMNP3fvQQfussFcylLjiSwzY8qZtDTAGfhhUhy0mqoZ
         P+yGKUlSWjcjiuZ++8wgmqzmm375Yv7NRruRFdN49+3dvbQZcYZDEn94DDFo3dH+LQz0
         CpeHY1IIcew5LhpPB3IBaa8bBlE8zqBI6sWro6VyCACocaoPNdHnJlU0rOYF4eqk1bQ1
         gzgyBRHEm9tmRGdh+yAr2wl49mySS35iJl+opLETX1/BHaP4V1d08e5gObr6YMi9GX8F
         1Tw+aVSOgeMNDeBnDTYwN8v+f3phBSAqzgLqPANh4xXj1nxV7NZCZ+evY/QB4jZEhbC6
         eR0A==
X-Gm-Message-State: AOAM533wUGOnEpBr2RpwsB+P+DiqK2BMDmCTHuFXjfgj+OQcVbqK/0bw
        9yGmKEROG11iSWgOu4mhWP99nUwtdEbiGg5sLsHQXFDyilo=
X-Google-Smtp-Source: ABdhPJyZMiJtpw9jCApWhjp68wWmTRq8KcueJWP5Lws+8Tk+dV2/gAL7u7TyhtH1EUM4icGY7zLdILpmu5tEJBCVwWA=
X-Received: by 2002:aca:4e4f:: with SMTP id c76mr3611773oib.167.1611166869344;
 Wed, 20 Jan 2021 10:21:09 -0800 (PST)
MIME-Version: 1.0
References: <pull.839.git.1611161639.gitgitgadget@gmail.com> <8326a9b5320e1e774caef568fcce2bfd2ec13cb1.1611161639.git.gitgitgadget@gmail.com>
In-Reply-To: <8326a9b5320e1e774caef568fcce2bfd2ec13cb1.1611161639.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 20 Jan 2021 10:20:58 -0800
Message-ID: <CABPp-BGrtcQ1pDCB8_cV77dqxige0v8rk4tqFRXe=HOUsn2DNw@mail.gmail.com>
Subject: Re: [PATCH 8/9] test-lib: test_region looks for trace2 regions
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 20, 2021 at 8:54 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> Most test cases can verify Git's behavior using input/output
> expectations or changes to the .git directory. However, sometimes we
> want to check that Git did or did not run a certain section of code.
> This is particularly important for performance-only features that we
> want to ensure have been enabled in certain cases.
>
> Add a new 'test_region' function that checks if a trace2 region was
> entered and left in a given trace2 event log.

Ooh, others do this too?  Sounds like a helpful function to add, but
just checking for entered and left means that...

>
> There is one existing test (t0500-progress-display.sh) that performs
> this check already, so use the helper function instead. More uses will
> be added in a later change.
>
> t6423-merge-rename-directories.sh also greps for region_enter lines, but
> it verifies the number of such lines, which is not the same as an
> existence check.

...yeah, won't cover the case that I added.  That's fine, since it
appears to be a one-off for now and we don't know of any other cases,
current or planned, that want to do something like that yet.

>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  t/t0500-progress-display.sh |  3 +--
>  t/test-lib-functions.sh     | 40 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 41 insertions(+), 2 deletions(-)
>
> diff --git a/t/t0500-progress-display.sh b/t/t0500-progress-display.sh
> index 1ed1df351cb..c461b89dfaf 100755
> --- a/t/t0500-progress-display.sh
> +++ b/t/t0500-progress-display.sh
> @@ -303,8 +303,7 @@ test_expect_success 'progress generates traces' '
>                 "Working hard" <in 2>stderr &&
>
>         # t0212/parse_events.perl intentionally omits regions and data.
> -       grep -e "region_enter" -e "\"category\":\"progress\"" trace.event &&
> -       grep -e "region_leave" -e "\"category\":\"progress\"" trace.event &&
> +       test_region category progress trace.event &&

Sidenote: Hmm...about 40% of my region labels in merge-ort.c and 90%
in diffcore-rename.c have spaces in them.  This function could still
be used, but I'm curious if I should change the labels (but then
again, they are testing logical regions rather than individual
functions, and the spaces instead of underscores kind of convey
that...)

>         grep "\"key\":\"total_objects\",\"value\":\"40\"" trace.event &&
>         grep "\"key\":\"total_bytes\",\"value\":\"409600\"" trace.event
>  '
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index 999982fe4a9..c878db93013 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -1655,3 +1655,43 @@ test_subcommand () {
>                 grep "\[$expr\]"
>         fi
>  }
> +
> +# Check that the given command was invoked as part of the
> +# trace2-format trace on stdin.
> +#
> +#      test_region [!] <category> <label> git <command> <args>...
> +#
> +# For example, to look for trace2_region_enter("index", "do_read_index", repo)
> +# in an invocation of "git checkout HEAD~1", run
> +#
> +#      GIT_TRACE2_EVENT="$(pwd)/trace.txt" GIT_TRACE2_EVENT_NESTING=10 \
> +#              git checkout HEAD~1 &&
> +#      test_region index do_read_index <trace.txt
> +#
> +# If the first parameter passed is !, this instead checks that
> +# the given region was not entered.
> +#
> +test_region () {
> +       local expect_exit=0
> +       if test "$1" = "!"
> +       then
> +               expect_exit=1
> +               shift
> +       fi
> +
> +       grep -e "region_enter" -e "\"category\":\"$1\",\"label\":\"$2\"" "$3"
> +       exitcode=$?
> +
> +       if test $exitcode != $expect_exit
> +       then
> +               return 1
> +       fi
> +
> +       grep -e "region_leave" -e "\"category\":\"$1\",\"label\":\"$2\"" "$3"
> +       exitcode=$?
> +
> +       if test $exitcode != $expect_exit
> +       then
> +               return 1
> +       fi
> +}
> --
> gitgitgadget

This patch looks good to me.
