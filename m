Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C40B61F404
	for <e@80x24.org>; Thu, 16 Aug 2018 08:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389955AbeHPLWT convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 16 Aug 2018 07:22:19 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:39074 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbeHPLWT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 07:22:19 -0400
Received: by mail-qt0-f196.google.com with SMTP id q12-v6so4323390qtp.6
        for <git@vger.kernel.org>; Thu, 16 Aug 2018 01:25:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0G6L47RH9MvcnizU3Uy+6cfvGPId/6LKrn4dMfqnmjg=;
        b=rA09aG6yzgqTq30olNxbfKn0E3EJRlJbngJLE4+S/PX8PVGTg1fWFJXFKrY3b6ing1
         hj0/3Jz9Is0MFVzyxPz2YVPNIS/2IWmrSGzYZGmjt0k+N71gxwioEZZNlr2eh03QGQ3/
         mPEytDV+6762OFQBOWWTMHhvi8xH0fBTyjWEVhRk70t6iMRlLmicv5Xi/SiWgGyCshgJ
         08ktTycBjKVbvJTA8oeIJLDNU6eL6PrUFKHlMncxwnCaI2QOiR/nohLSNxSca9/97Yhf
         qeIHjXKXV6jDzy63Kf+xnhFT/kaafn4ZS1g2jw32kUZj2Rws6mF+vvJvGLvlXTd5jKcq
         epHw==
X-Gm-Message-State: AOUpUlHpuwCLOtksE3cO4yEk59nLVJQVSL6AOqB9otapqc/Fsj4jL99w
        KHb0LTQV0wXYYAkyaaaGTfG1N7JgAxbXwm/Gxw4=
X-Google-Smtp-Source: AA+uWPxrxTXM3XHF7llugQK6sbtLAx6lMwaXJoFSYuDJxMofxcooX4PuK37Y+NvscTkzQVPgUlAebaZtuCEniem2prw=
X-Received: by 2002:ac8:5188:: with SMTP id c8-v6mr29675806qtn.35.1534407927865;
 Thu, 16 Aug 2018 01:25:27 -0700 (PDT)
MIME-Version: 1.0
References: <20180815205630.32876-1-gitter.spiros@gmail.com> <CAN0heSrZXjaQ0H1J1Mmqhv9qhiNbRn4fOJ4oO1XrZFEGO4YFug@mail.gmail.com>
In-Reply-To: <CAN0heSrZXjaQ0H1J1Mmqhv9qhiNbRn4fOJ4oO1XrZFEGO4YFug@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 16 Aug 2018 04:25:16 -0400
Message-ID: <CAPig+cR3g8MUt6VAg0RrO3VBgZ4ChsXz1t75xHgT5Q_9_hRzBQ@mail.gmail.com>
Subject: Re: [PATCH v2] worktree: add --quiet option
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Elia Pinto <gitter.spiros@gmail.com>,
        Git List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Karen Arutyunov <karen@codesynthesis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 16, 2018 at 12:41 AM Martin Ågren <martin.agren@gmail.com> wrote:
> On Wed, 15 Aug 2018 at 22:56, Elia Pinto <gitter.spiros@gmail.com> wrote:
> The word "currently" means I can't shake the feeling that Eric has a
> very good point in [1]:
>
>   It might make sense to say instead that this is adding a --quiet
>   option _in general_, rather than doing so specifically for 'add'.
>
> As an example, if `git worktree move` ever learns to produce some sort
> of output, then Eric's approach would mean that such a hypothetical
> `move` is buggy until it learns to respect `--quiet`. With your
> approach, it would mean that we would get feature requests that `move`
> should also respect `--quiet` [...]
>
> Doing such a patch instead would mean tweaking the commit message
> slightly...
>
>   Add the '--quiet' option to git worktree, as for the other git
>   commands. Currently, 'add' is the only command affected by it since
>   all other commands, except 'list' obviously, are already silent by
>   default.
>
> ... and the documentation slightly ...
>
>   Suppress feedback messages.

This is a sensible suggestion for the documentation rather than having
it call out "add" as special (unlike the commit message in which case
it makes sense to mention that only the behavior of "add" is
affected).

> It might make sense adding a comment to the documentation about how this
> currently only affects `add`, but such comments do risk going stale.

Let's not mention "add" or any other command specially since the
option is meant to be general.

> I am on the fence about whether the documentation needs to say something
> about `list` -- who in their right mind would expect `list --quiet` to
> actually suppress the list?

(/me nudges Martin off the fence onto the side of not bothering to
mention the obvious)

> Others might disagree violently with this, but I wonder whether it makes
> sense to add a test to verify that, e.g., `git worktree move --quiet` is
> quiet. Such a test would demonstrate that this is your intention, i.e.,
> anyone digging into a report on "why does git worktree foo not respect
> --quiet?" would be 100% convinced that your intention back in 2018 really
> was to respect it everywhere. It seems wasteful to add such a test for
> all other modes, but maybe you can identify one which you think has a
> higher risk of learning to output some feedback in the future.

My knee-jerk reaction was that such tests seem unnecessary, but I
think you convinced me that they would make sense to avoid future
headaches since --quiet should indeed mean "quiet" generally. (Newly
added worktree commands would not be protected by such tests added
today, so it's not foolproof, but still better than nothing.)

Having said that, though, lack of such tests shouldn't block this
patch from being accepted. They can always be added later if someone
wants to do it.
