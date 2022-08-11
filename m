Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD16C19F2A
	for <git@archiver.kernel.org>; Thu, 11 Aug 2022 17:49:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235445AbiHKRtW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Aug 2022 13:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbiHKRtU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Aug 2022 13:49:20 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F38A025C
        for <git@vger.kernel.org>; Thu, 11 Aug 2022 10:49:19 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a7so34817965ejp.2
        for <git@vger.kernel.org>; Thu, 11 Aug 2022 10:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=kpBQl7JSXBYQujSbLE7mcIAhFpOO+EnkvJF0U/aKxOo=;
        b=Q6Cu4F03xa4lxe0XWQUloOa8gl6uL14z3UQaHRfEZbc9vSpj0CXV51r4gbRxNVlwRV
         yZBR/3t1m10McGbjNh5niwk6YZxqnhD+BdSrXCexqKQgV3nN1RquinhuIwp15FCGKKEA
         suW9IZByuu4iwxVVrXw750XAL+PU8Sow1vdu3Ma9KKFgrLVKMgSrLhtXNqHWCnyy6uDV
         MO0hecQZfvSpg4VMtdhMDeKRGFDOQkbEaK1bbfkrY3/wLZnoQdaySPwpxj57SGeb0egN
         +I9IfXx889/cDaukbQyIk9u5d4san+nMu7iU3OoacrM2LLYtlSjg1McGThLoEQec+yVN
         zpXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=kpBQl7JSXBYQujSbLE7mcIAhFpOO+EnkvJF0U/aKxOo=;
        b=P/pjHLNZPcguFdLSqO5DWGg7gfLNGMYEqA8Ta4VFltDhgcIOpBRNzs12l2X1bFkqKm
         8daX8PTrcGHJ5RXIrQofBo/B9R/8cayYxKk086auZD6UYXcwbdMsuEfGLmwRypC/N4Dl
         U53C03FvdsqljMlJ0D01+Fq67eZvLt89a+QjxrE7UsXfq07mhFy26UI65t07hdMHqrqo
         zZQdY5JqfFdSg+7Ce8I6vX2o6FIfS3NlgmjO3DE4CEMhTCHEYOGPdr6gIeOlmSvI3D5m
         bWIfctGS3pbC7ccX6RQ57bQGWJM7NkblGVWTdeuOgac2djVivttk0xwIhdy5akU6Sq+N
         QE9w==
X-Gm-Message-State: ACgBeo3AYtw3gvUGbPpjd7ntfBCJwxtCh9d6gzn0x8+Ys9UxTYKMsuMi
        jyS2itpna/xqmOp8JdK1i9mHUPQZEzE93almmWU=
X-Google-Smtp-Source: AA6agR4FynzI407+a0NbhGGdOpHyE6rBisKY6A6hFb5bfddJ06Tvxzn+mzL2UUTJ/7eDERg5UOtqxW2PhpkmXVrsCPU=
X-Received: by 2002:a17:907:c0d:b0:730:a85d:8300 with SMTP id
 ga13-20020a1709070c0d00b00730a85d8300mr134973ejc.558.1660240158291; Thu, 11
 Aug 2022 10:49:18 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1317.git.1660067049965.gitgitgadget@gmail.com>
 <pull.1317.v2.git.1660233432.gitgitgadget@gmail.com> <7a071c9e6be68b58306582dbac5952a5b1bcbc6a.1660233432.git.gitgitgadget@gmail.com>
 <xmqqtu6ig1s5.fsf@gitster.g>
In-Reply-To: <xmqqtu6ig1s5.fsf@gitster.g>
From:   Eric D <eric.decosta@gmail.com>
Date:   Thu, 11 Aug 2022 13:49:07 -0400
Message-ID: <CAMxJVdEV=rSXtM-nagvtMPdArkvQgoNauaQb1sk0CL3sPSvKmw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] fsmonitor.allowRemote now overrides default behavior
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric DeCosta <edecosta@mathworks.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Well, needless to say I wasn't expecting GitGitGadget to do what it
did.I had squashed things down to just two commits and forced-pushed
the second commit thinking that just the relevant stuff from the
second commit would show up in the next patch. Obviously that didn't
happen. Sorry about that.

I can certainly squash it down to just one commit and force-push that.

On Thu, Aug 11, 2022 at 1:17 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Eric DeCosta <edecosta@mathworks.com>
> >
> > Reworked the logic around fsmonitor.allowRemote such that if
> > allowRemote is set it will determine if monitoring the remote
> > worktree is allowed.
> >
> > Get remote protocoal information; if this fails report an error else
> > print it if tracing is enabled.
> >
> > Fixed fomratting issues.
>
> The end result (i.e. HEAD^{tree} of the branch you developed these
> two patches on) may be good (I haven't checked), but it is not how
> we fix problems in an earlier attempt in this project by keeping the
> faulty commit(s) on the bottom and piling "oops, that was wrong, and
> here is a fix-up" commit(s) on top.
>
> Once you are happy with the end result, use "rebase -i" to clean-up
> the history leading to that end result.  The goal is to pretend as
> if you were a perfect human, more perfect than your actual self, who
> came up with an ideal patch without making mistakes that need to be
> corrected with "fix-up" commits.  In this particular case, you'd
> most likely want to end up with a single commit, so squashing them
> together and fixing up the log message might be all you need to do.
> When you work on a more elaborate topic, you may also want to split
> or reorder original commits to present a logical progression towards
> the end result.  "rebase -i" is a good tool to help you do so.
>
> I am not a user of GitGitGadget myself, but if I recall correctly,
> you should be able to force-push the result of such a clean-up to
> update the pull-request, to trigger a new iteration to be sent to
> the list.
>
> Thanks.
