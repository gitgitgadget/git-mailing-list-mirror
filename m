Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9FDEC433C1
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 21:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94551619B4
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 21:58:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233737AbhCWV6R (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 17:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233651AbhCWV6D (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 17:58:03 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC966C061574
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 14:58:01 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id c13so7192778uao.10
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 14:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1/aKAJkrKiIsN9v2KGVAkkCEa2Ds4IOklAxbGWrCNRI=;
        b=Qts4KCPbtR63esl7NqxDljkJa+PJqDlomvO5dfaozq8YR5gwlwjgdeli5L2w+UnLDr
         3sg/IupBILRr0a1Kx62nHOty1MbCmMfS4aWaqGyL+OFp1ClhbR76BuK54nDLX8dMzJxr
         ULDl72j+zqvOcH8BR7Wnb1hTihzys7UEBIOy040kXssvnEJcS3ngmzrrA9ZtZl3SQd3a
         sHtxtyk64eVRE7dde19sMFVbREEmPRFTzRRhqrKl+iNLi+m6lmBfQciMkWB8O9wslXgD
         jc3Bn8145mii/M9ii7NyJx8lrBbXtZrLAq12v9Kl+o9mcLhT51m5Cg3s+GbYAqDV6yVF
         pQLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1/aKAJkrKiIsN9v2KGVAkkCEa2Ds4IOklAxbGWrCNRI=;
        b=Cjj2m/7AU4sWDaNXTazKA/IzovNtp9UVtxhhM3WLvIgZzwd/b9LIFYqAg473nclvxG
         ysnEOs+eyhVdYxlUDMN7Ds7kEqKJ8ti+eTJn69P80LcPB1iD8BMmJBAyMGUSY7XOE0ao
         hlxFKF2dSxhcdNDfDfXLGgE4Y/fWexIQOwojo2lONKB4YUjIV9BJC1K3DabnZ9E342DX
         GhQNEBGxjuhxccuUm8lEj971kxUjTiDpJhJHs5g4Lb7hNV2P43PGLEbywl7PL1TOUA9G
         GdFweUQI2gVFZjMS+9plAOzF26iftEjL5MKira/ioTmkFryxQ6iZLFX/YjRetJePCyo8
         R0Ug==
X-Gm-Message-State: AOAM531S3JF95s5zhRQXCuSfW2GNjutUUsWh1tLB5GBhnNw859PvIEQA
        1kXpgEZ3y+d8tQ7xST2/KXBtrSSKqIiIjkflo/Hh+bdAIhI=
X-Google-Smtp-Source: ABdhPJx8G/zxMtX4Q2a0KtcxB3eFKmFbONS0sl9pTjNtP/Csem8KTLg+KYVy7Y1KSSuc/DQjrVo61boN4ilDOzHiTFU=
X-Received: by 2002:a9f:3591:: with SMTP id t17mr124034uad.41.1616536680748;
 Tue, 23 Mar 2021 14:58:00 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqk0px3dfu.fsf@gitster.g> <CA+P7+xokjz-2nC5+F9HG0tBqS948uZcuq-1eY9uGuNyzbFGbZQ@mail.gmail.com>
 <xmqqmtut1qyj.fsf@gitster.g>
In-Reply-To: <xmqqmtut1qyj.fsf@gitster.g>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 23 Mar 2021 14:57:50 -0700
Message-ID: <CA+P7+xo9rUYWzCT0YZFU5Nz1ojP1qRt8VfGtK08-LmYV9KK0hw@mail.gmail.com>
Subject: Re: Pass or not to pass config environment down...
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 23, 2021 at 2:48 PM Junio C Hamano <gitster@pobox.com> wrote:
> Many callers do child.env = local_repo_env when spawning a
> subprocess.  The elements of child.env is treated as if each of them
> were passed to setenv() (if there is '=') or unsetenv (otherwise),
> and because local_repo_env[] spells only the variable names, the
> effect is to unexport them.  The helper function shown at the
> beginning of the message you are responding to, which you wrote more
> than 5 years ago, is to exclude GIT_CONFIG_PARAMETERS from that
> treatment.  I.e. the code wants run_command() not to drop that
> particular environment variable when running a subprocess.
>

Ok, right. So the part that was confusing me is that by adding the
value into the local_repo_env, we were telling it to clear the
variables. Yep.

> Removing GIT_CONFIG_PARAMETERS from local_repo_env[] should have the
> same effect, without the helper to special case it in its loop.
> We have been passing GIT_CONFIG_PARAMETERS, and we will keep passing
> it even if we make such a change to remove it from local_repo_env[].
>

Yea, makes sense. I think that's a much better approach than special
casing in a separate function.

> The configuration parameters passed via the newer GIT_CONFIG_COUNT
> mechanism, because local_repo_env[] has it but the above helper does
> not special case it, are dropped and not seen by the subprocess.
> Assuming that it is a bug and we would want to pass them to the
> subprocess the same way as GIT_CONFIG_PARAMETERS environment
> variable, we could tweak the helper function to make it special case
> GIT_CONFIG_COUNT the same way as we've done GIT_CONFIG_PARAMETERS
> for the past 5 years.  But if we suspect that other codepaths (not
> the ones that use the above helper) may be doing it wrong and they
> too should pass the configuration parameters to the subprocess, a
> simpler way would be to remove them from local_repo_env[].
>
> That is the summary of the current status and what would happen if
> we did the attached patch.
>

Thank you for restating and clarifying. I think this is the right
approach, and I agree that GIT_CONFIG_COUNT should be treated in the
same way as GIT_CONFIG_PARAMETERS.

So, I think this direction is good. I imagine a full patch would
include also dropping the specialized helper function that is no
longer needed, and possibly adding new tests for the behavior of
GIT_CONFIG_COUNT?

Thanks,
Jake
