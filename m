Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5084C433F5
	for <git@archiver.kernel.org>; Sun, 17 Apr 2022 02:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbiDQCMa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Apr 2022 22:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbiDQCM3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Apr 2022 22:12:29 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE6F13E17
        for <git@vger.kernel.org>; Sat, 16 Apr 2022 19:09:55 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 21so14084187edv.1
        for <git@vger.kernel.org>; Sat, 16 Apr 2022 19:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pz+qSC8OJWFvC0V22hBmcZ/F4wUYfxHkP0dguRmuS8E=;
        b=DAL3VUY6jLLCO90BwhK4hkUX5bZZnmttHmA2jNs3/aAuP4Mi6IdxvFmUF6sobfKizt
         u/vW6kT+HPTWSCsu9yw6US5/xB+UbnsuTvOhBwUOMGP8+yRuk0PP6gclpaawSq77gKcL
         9A+sYgg+k5LEHftDihrkMD7iMrPNQX8LDkzCZlAKL7KFkHyuYXcNUjyOXKWnF1aSO+qd
         D9AMsRw9H00sS7V0z7pIzT4YsYA3+o5XUyHGbFfidL951db1NR0kH6lS8ncsLY8U1sde
         JMoSR0hvMeLfbytmlc7dhoZYs9UhpHjNytX5S5+lGUk+SsaNbrQ5Dpn1tyCc7n+L2xOO
         UJ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pz+qSC8OJWFvC0V22hBmcZ/F4wUYfxHkP0dguRmuS8E=;
        b=TVESOhtvkcByQVNtN7G7iz9zb6NdBcddqiCZKRNCinoD2+Pf/MH1/V8x+fgPzcnHZZ
         HQP8Jh3GLloR5tx++/28rQ1kWdp1Zah146RyTIza/ktEi6Ammu5uaZb/XoXRFms6e0He
         M+yx9SC68ClmsLi9+yCKD3qoElidedO0yiW+wI5IN7w96Xq7BHnawZijpXmrKnNP7kn/
         m+13axm21ficVNBSdkf8pHoQD++9lykwZu+HMol7GBL45SlFDsMWASr3YpmaZnRCQLmQ
         6C7ypO/UkgipDWtBZzcwMjd3r8DrMHkcY9ZwYHRuTIMvK4iTmnSdEO4YxcnZVrlRp4NE
         V4sA==
X-Gm-Message-State: AOAM533T6NlbF7fw3Bm/xisk0myQexaxHW5BwAKziBKsVf6Nb9iGlnb6
        aLdAs90GICI+sLqcdO1xhj41WmvqF7T33eYRbWzDUw7O
X-Google-Smtp-Source: ABdhPJwnB4oGwtZ3QrgYp70MGVA0pCzGVPJ1BZuY1vVBgqG0WzJh8C+tX85DnzNcq6JLSk6u9k8yeAInai1apN1ZcN4=
X-Received: by 2002:a05:6402:2689:b0:422:15c4:e17e with SMTP id
 w9-20020a056402268900b0042215c4e17emr6199863edd.33.1650161393674; Sat, 16 Apr
 2022 19:09:53 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1150.git.1645441854.gitgitgadget@gmail.com>
In-Reply-To: <pull.1150.git.1645441854.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 16 Apr 2022 19:09:41 -0700
Message-ID: <CABPp-BEXqXAje-GmMkhaowbewoPiuFCKZ01g_i+ygN1epT9ByA@mail.gmail.com>
Subject: Re: [PATCH 0/7] rebase: make reflog messages independent of the backend
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 21, 2022 at 9:04 PM Phillip Wood via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> This is a series of rebase reflog related patches with the aim of unifying
> the reflog messages from the two rebase backends.
>
>  * improve rebase reflog test coverage
>  * rebase --merge: fix reflog messages for --continue and --skip
>  * rebase --apply: respect GIT_REFLOG_ACTION
>  * rebase --abort: improve reflog message
>  * unify reflog messages between the two rebase backends
>
> This series is based on pw/use-inprocess-checkout-in-rebase
>
> Phillip Wood (7):
>   rebase --apply: remove duplicated code
>   rebase --merge: fix reflog when continuing
>   rebase --merge: fix reflog message after skipping
>   rebase --apply: respect GIT_REFLOG_ACTION
>   rebase --apply: make reflog messages match rebase --merge
>   rebase --abort: improve reflog message
>   rebase: cleanup action handling
>
>  builtin/rebase.c          | 144 ++++++++++++-----------------
>  sequencer.c               |   5 ++
>  t/t3406-rebase-message.sh | 185 +++++++++++++++++++++++++++++++-------
>  3 files changed, 214 insertions(+), 120 deletions(-)
>
>
> base-commit: 38c541ce94048cf72aa4f465be9314423a57f445
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1150%2Fphillipwood%2Fwip%2Frebase-reflog-fixes-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1150/phillipwood/wip/rebase-reflog-fixes-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1150

I read through the seven patches, then went back and commented on all
of them.  Hard to find problems really, looks nicely written.  I would
second Christian's request to have the second patch split with a
preparatory testcase cleanup, which it appears you already plan to do.
Other than patch, the series looks good to me.
