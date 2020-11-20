Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1FB4C5519F
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 05:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 661202168B
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 05:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VLbdKQoH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725921AbgKTFX0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Nov 2020 00:23:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbgKTFX0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Nov 2020 00:23:26 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53760C0613CF
        for <git@vger.kernel.org>; Thu, 19 Nov 2020 21:23:24 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id a13so7960476qkl.4
        for <git@vger.kernel.org>; Thu, 19 Nov 2020 21:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8fkB7uqvbTlk7c1V5TyAKZ2q48qHYaovOQ9e3crOQDo=;
        b=VLbdKQoHQXjw++CINsGtLgZGij//ILmPXkfnanVZL90Y+etmE+qNM1ABKA3cL3XcuH
         81HUYsSJp2wSsEQ3Kt/AJaMz38plxTltLzOQ51yWIpHvtxkZlWCGYSpDWOZ6XqGowDyW
         lPt+8u+VGLz/Y2eegZpduTrHYKunYcfLjVcNkIJo1hmNL1E1MGJ0LJ7xKsElXB1pwaSB
         +in/eP01hoh7/RK9GRVboJqracHvFVq3IitxtCz81PLVco4uEI/5gCj+5ekQJRH1yYZy
         8llaNneWdBtteZDtuDj+DhtRRDTPh0WPJ0ZqXiDBtYN0SGLbi50SoQr9ze0NshDgavhG
         KHRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8fkB7uqvbTlk7c1V5TyAKZ2q48qHYaovOQ9e3crOQDo=;
        b=mmvmWeT4wuW2rtyqMsoH8vtBsYMgPUzJtSYduYJxV3UZ68yFmlqPm/qoRYR7+g0hlc
         NGzjNirfmmP9wocjgC0Km4xflRKePKZT1Wi+vejhKKY566IdLyQ/wSu4XGcdi3u9aYsS
         7upy3Ou3sLKTKH2Wr7VsZZHBAx3aMkrWj6frBVu01JZNeP9LBS2jxFslarNb5LOb5880
         +J8EvKS9DRm+gIIbHaYE3SuPnxao0QZ7xzLK8xeYW7j+JV2Mbo03q+Vh+/nvVy4cWBN/
         /8TbPqE/c1N17lhN8b3O4ejnRWDauja3TciTboAALlj9zeKan6dTBfkHPBbUCLgzfUJo
         CV/A==
X-Gm-Message-State: AOAM532Z9iMmO/T4m5gPndon7jTlYv4hx1Jy+lK0NhFAKAerhBfqJuSK
        PI/ofIMYLP+1/3XGr5EiC7BhFKiCPOr/yXTzQ3HwUi20Joaggw==
X-Google-Smtp-Source: ABdhPJxrcy0H4psS3AioDUBfYFB7TB3wuKDUGgB8aQIwe0RV/aBd5Zd26a9ybtClSKmUkeG2Ai/o2Q63kCFZm3qY8/Y=
X-Received: by 2002:a05:620a:cf3:: with SMTP id c19mr10943692qkj.432.1605849803236;
 Thu, 19 Nov 2020 21:23:23 -0800 (PST)
MIME-Version: 1.0
References: <pull.790.v3.git.1605801376577.gitgitgadget@gmail.com>
 <pull.790.v4.git.1605819390.gitgitgadget@gmail.com> <3bd6024a236b061c89bb6b60daf3dc15ef1e32ca.1605819390.git.gitgitgadget@gmail.com>
 <CAPig+cSN=-7KWgDcXM8po44PEKi27U6mJEEL0mj_wrTJBUf=WA@mail.gmail.com>
In-Reply-To: <CAPig+cSN=-7KWgDcXM8po44PEKi27U6mJEEL0mj_wrTJBUf=WA@mail.gmail.com>
From:   Orgad Shaneh <orgads@gmail.com>
Date:   Fri, 20 Nov 2020 07:23:12 +0200
Message-ID: <CAGHpTBKHmdjqrz1ABdGUUz7AwcixU_VBy1DQzybpFizqVo8C7A@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] hooks: allow input from stdin for commit-related hooks
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Orgad Shaneh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 19, 2020 at 11:23 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Thu, Nov 19, 2020 at 3:57 PM Orgad Shaneh via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > Let hooks receive user input if applicable.
> > [...]
> > This allows for example prompting the user to choose an issue
> > in prepare-commit-msg, and add "Fixes #123" to the commit message.
> >
> > Another possible use-case is running sanity test on pre-commit,
> > and having a prompt like "This and that issue were found in your
> > changes. Are you sure you want to commit? [Y/N]".
>
> These use-cases really help readers understand the motivation for this
> change. Good.
>
> > Allow stdin only for commit-related hooks. Some of the other
> > hooks pass their own input to the hook, so don't change them.
> >
> > Note: If pre-commit reads from stdin, and git commit is executed
> > with -F - (read message from stdin), the message is not read
> > correctly. This is fixed in the follow-up commit.
>
> Rather than making such a fundamental change and having to deal with
> the fallout by introducing complexity to handle various special-cases
> which pop up now and in the future, I wonder if it makes more sense to
> instead just update documentation to tell hook authors to read
> explicitly from the console rather than expecting stdin to be
> available (since stdin may already be consumed for other purposes when
> dealing with hooks or commands which invoke the hooks).

On the first revision I had several links in the commit message to
users who solved it this way. This solution however is not optimal.
I have a prepare-commit-msg hook that requires user interaction for
choosing an issue. This hook must work from the terminal and also
from GUI applications like IDE.

Currently the hook always pops a GUI window, but when using it
from the terminal this is inconvenient (and when running over
remote SSH without X forwarding it can't work), so I'd like it to be
usable also from the terminal.

To achieve that, I created 2 classes - one for terminal and one
for GUI, and trying to choose the correct class by checking if
stdin is a tty. The condition looks like this (Ruby):
client = STDIN.tty? ? Terminal.new : GUI.new

At this point I was surprised to discover that Git closes stdin,
so the condition is never satisfied, and I always end up with GUI.

As I mentioned, I need it to work also when executed from
GUI applications, so just reading from the console will not work
in my case. I tried other ways to detect "running from terminal"
without the tty condition, but couldn't. The environment variables
are identical when running in a GUI terminal and in the IDE.

Can you suggest an alternative way to determine if I can accept user
input from the console or not?

- Orgad
