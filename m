Return-Path: <SRS0=wsT/=ED=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F1CC55179
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 22:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51B3724171
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 22:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SW67bX1F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731498AbgJ1WRR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Oct 2020 18:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731492AbgJ1WRR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:17 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9C6C0613CF
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 15:17:16 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id w23so695825wmi.4
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 15:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z+CfMa3aJ+Xl9f/YQzABitecnMXOSPFBfborxxCFsok=;
        b=SW67bX1F6csUdBUrWGypTdBcRyd5rxzap4y7j1KITREYQTIwH0i9eCw8cQk0UQXjtb
         I2O6RSqFRUdHlI3V9v2WY8TrxdePKa/flmR9ZOrcVKGkGZpoil2YiCpG7tETBev1u8Ew
         1ec0yw/lIobjTT9zzcD/2BwnYwptIUF6B/9Rev8FlJND7YKJhS9B84jwG14cM1iP55Eb
         Xl8UNpYnrDfXeMSa7FDF0ezkYGZ8WAt4xIB9Y+0AC/hULtdihwnhjT3QGmOFYIiZ8OSU
         mKxQUfL0tRkNs2EF0b/nq4U9NngjLIpAc/3cuwQ31hVps8l3ldUeA5r6pNJpx4keRrPe
         +nlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z+CfMa3aJ+Xl9f/YQzABitecnMXOSPFBfborxxCFsok=;
        b=kpVsiQSCu83qugCd2MrVAQq34o7rchhkV1vmKHXtgMuv6NwJkj8bz5mkrIn2XFWub0
         BPFbqeaYLaJ/Lhy/l/6E0a00kexzF83hw7gOWUeLjeFTIiH+uSTRFlXfQAl6+HTMELlc
         HrKg/ldOBWgdOTCdna0v/2/rc4mWuj36jRFUnav+XJEeHqZYFset4UC5+3qDY/0g5g2H
         Ljezr4d+kwjxBQ4Ze2HfVj7yEqxOMyOFK0uTlEmQYTK+hCGOf1XS2UxZb7ZDcz16H0Gi
         yQTPM5SD/Arw5ew9+K0advZZWZhQFfrAJxl5x02OGpk6qqg32YpSF1ZCfIe5LBAviBoW
         FByw==
X-Gm-Message-State: AOAM530NZvBgTkBqAq2Yn6m6o15t81jAj3qR07jg7Gul2V3ky3DQjB4p
        gYSmbiRLgxoeFYD3OhLDUx2DvDWEzFNZWcDswxueXEnKic142Q==
X-Google-Smtp-Source: ABdhPJyO32WN58/VzqgoaEax8rMZY4AUrPZdsoMn6uzqxGnyEbl2U4+/EGz5WSok43w+ERhk8zmgtqJEGhG90mZfHOE=
X-Received: by 2002:a7b:c2fa:: with SMTP id e26mr221542wmk.37.1603902677713;
 Wed, 28 Oct 2020 09:31:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190621223107.8022-1-felipe.contreras@gmail.com>
 <xmqqk1cz0zz1.fsf@gitster-ct.c.googlers.com> <CAMP44s3wqxTmgQpMgk2cM33EvtwrvvXYv4_90GKGmHb8yJHAKg@mail.gmail.com>
 <xmqqk0vbbep5.fsf@gitster.c.googlers.com> <CAMP44s13nip2_Z1OOFb9iVcrSxQbyJW4cH86J3Ah1p4SmTQWQQ@mail.gmail.com>
 <xmqqr1pj9rf0.fsf@gitster.c.googlers.com> <CAMP44s0nxQ8jxxw7wSPOMv9Nx1P7ww3S6dGv27xNVQ_aHTaPng@mail.gmail.com>
 <0ec43318-bf83-25c4-a817-a150e2e47546@haller-berlin.de>
In-Reply-To: <0ec43318-bf83-25c4-a817-a150e2e47546@haller-berlin.de>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Wed, 28 Oct 2020 10:31:06 -0600
Message-ID: <CAMP44s0+TMhmPYM7omoFhcebMLhZyh6v77WUFNrscRtPNEDNHQ@mail.gmail.com>
Subject: Re: [PATCH 00/14] completion: a bunch of updates
To:     Stefan Haller <lists@haller-berlin.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 28, 2020 at 3:09 AM Stefan Haller <lists@haller-berlin.de> wrote:
>
> On 28.10.20 1:06, Felipe Contreras wrote:

> > I didn't say the users didn't get the scripts from the distribution, I
> > said I didn't know of anyone that did. I just checked the installation
> > instructions of Homebrew, and they do seem to install the zsh
> > completion from contrib, whoever, by the time I see the bug reports,
> > those users already downloaded the most recent version from GitHub
> > [1].
>
> I might not be the representative zsh user, but just as one data point:
> I have never downloaded the completion scripts from anywhere. I always
> use the one that comes with my "distro" (which is the Mac git installer,
> most of the time, which puts it in /usr/local/git/contrib/completion/).
> I symlink that to ~/.zfunc/_git.

That's interesting. Where did you get the idea to do that?

> > On the other hand my distribution (Arch Linux) does not enable the zsh
> > script by default, it just lies dormant in /usr/share/git/completion,
> > which nobody uses. So users in Arch Linux naturally would download the
> > latest version from GitHub [1] as well.
> >
> > So, which distributions package and enable the zsh script by default? Who knows.
> >
> > I suggested you to graduate those scripts out of contrib so
> > distributions would trust the scripts enough to enable them by
> > default, but you refused.
> >
> > What you do with the scripts is up to you, I only know what would
> > happen depending on what you do. 1) If you leave them as is, some
> > distributions would enable them, others don't, and people will keep
> > downloading the scripts from git's GitHub [1]. 2) If you graduate
> > them, more--if not all--distributions would enable them by default,
> > and less people would download them. 3) If you remove them, people
> > would look for another git repository to download those scripts from.
>
> I don't think it makes a difference whether the scripts live in contrib
> or not. Bash completion is also in contrib, and yet it seems to be
> shipped and enabled by most distros, as far as I can tell.

Apples and oranges.

There is no default completion for git in bash, neither in bash, nor
in bash-completion, so if the distribution doesn't install the
completion in the right place
(/usr/share/bash-completion/completions/git), then the user would have
no git completion.

On zsh the situation is different; zsh by default has a git completion
(/usr/share/zsh/functions/Completion/Unix/_git), and some might argue
it's more complete than git's zsh completion, so why would
distribution maintainers chose the one in 'contrib' (an unofficial
contributed script) over the official one? Indeed they don't, at least
on Arch Linux.

Cheers.

-- 
Felipe Contreras
