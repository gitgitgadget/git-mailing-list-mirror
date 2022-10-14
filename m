Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73093C4332F
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 00:08:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiJNAIQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 20:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiJNAIP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 20:08:15 -0400
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FDB1781DF
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 17:08:14 -0700 (PDT)
Received: by mail-io1-f47.google.com with SMTP id e15so2732883iof.2
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 17:08:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/n7B/btd+FyHcn7NlF42yA+RkbPtS16E87hNWUgRXcg=;
        b=3kuG/DP9ca9DVa/1SE0j3CQuW7mPbQJmPH+IRGR4CAdVbQ9FcZcSDut//VA8JKgtKx
         VGduHmGcHNDnyxEubKX12XKAg0AC9gs3Zwasi4bVUp1flvBQyhudcZqpVyI/ZgiSAL9j
         H3W3IJ+/K1F1z+GFsDo91MFiWn611HuZpC4I1whFDIWrPu5XxrrzlR73EDTu1jimmXez
         txt9NzWVKI/6w2e7ZlVMM8VIhUMpWpLTkx0QuP/89wEvLZ+BMQaxdU3hkpq6fBVMG2Xw
         nvhacvJS5pkCae5t+zK54NdWsqqq40DnTTel53b7fR76GPec4kT/FUoKyTaSl4s6VovL
         Mb7g==
X-Gm-Message-State: ACrzQf080q7DQnOUUG9TGf/wy93yAGNg21cswRTqTKOKnmOLFVl8KlvP
        VjqUEA4awIaHg5SmR7rFGbqQ886L7+CPQLGlMpKOj0eQRao=
X-Google-Smtp-Source: AMsMyM4i2VzvV5WuYFx19EqnzUN090aY6mn8fi//23oCqhrkLrq23cq09vskDBSRLuL0pNWLWxvtSY1NJ7WWmZBl9Ro=
X-Received: by 2002:a05:6638:3f0d:b0:363:ba76:7397 with SMTP id
 ck13-20020a0566383f0d00b00363ba767397mr1326466jab.177.1665706093424; Thu, 13
 Oct 2022 17:08:13 -0700 (PDT)
MIME-Version: 1.0
References: <CA+PPyiH0VqXdO1LfXP7CaM=HnBPWqvHd4DTE5EOMEcb58DCPCA@mail.gmail.com>
In-Reply-To: <CA+PPyiH0VqXdO1LfXP7CaM=HnBPWqvHd4DTE5EOMEcb58DCPCA@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 13 Oct 2022 20:08:02 -0400
Message-ID: <CAPig+cQxuWfibPR9O5qZrU4mkuOL48gftRtJ86gzvH0hgJBMOg@mail.gmail.com>
Subject: Re: [outreachy] sent in my first patch
To:     NSENGIYUMVA WILBERFORCE <nsengiyumvawilberforce@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 13, 2022 at 5:46 PM NSENGIYUMVA WILBERFORCE
<nsengiyumvawilberforce@gmail.com> wrote:
> I have been able to submit a patch for a microproject. Many thanks
> Johannes Schindelin for /allow. My CI tests were failing and I had no
> idea why they were failing.
>
> The PR is https://github.com/git/git/pull/1362

It appears that your patch did not get sent to the mailing list
because the patch's commit message failed GitGitGadget's validation
check. In particular, the commit message should start with a summary
line, followed by one blank line, and then the more detailed
description of the change. The summary line should be formatted as
"<area>: <short-description>", where <area> is the bit of code you are
touching. The project also prefers the commit message to be written in
imperative mood, as if the commit message is telling the code in the
project how to change itself. So, you might rewrite the commit message
(by amending the commit) to read something like this:

    [OUTREACHY] t1002: modernize outdated conditional

    Tests in this script use an unusual and hard-to-reason-about
    conditional construct:

        if <condition>; then false; else :; fi

    Change them to use the more idiomatic construct:

        ! <condition>

    to make them easier to understand at a glance.

Then "force push" the revised patch to GitHub. Since this is a
single-patch pull request, you probably also want to edit the
pull-request's description on GitHub to remove all the text except for
the "Cc:" entry or entries.

GitGitGadget also complained that you don't have a public email
address registered with GitHub, so you should address that problem,
too, if you haven't already.

Finally, re-"/submit" the pull request and observe the comments
GitGitGadet adds to the pull request to see if it discovers any
additional issues.
