Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AEF6C433F5
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 15:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24D6C61A40
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 15:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354943AbhJAPHt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 11:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354849AbhJAPHj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 11:07:39 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1EAC0613E2
        for <git@vger.kernel.org>; Fri,  1 Oct 2021 08:05:49 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id v10so36223637edj.10
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 08:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=58O9e2QFs0rhwf/IjftAShRH6V03p9k9B+YIUgcJogA=;
        b=ERfZihi0keMDHANt8EOq799/cduIskeXA88WpLTErDBnBp+m1oA5cWrQOGmp2jnE1E
         hD6CmniZ11MsO0sqB/nGoSRvkztS+zKmf9fLIuK089CpREVMJDa2eA4ah1Sa/9KmJMHD
         1Xjg/+CyvtMZmP1WxsVOcKoOt59l+9t25TqF0zm3zPZJyjmRCO94uiDL5RItI7zt64G7
         qSZ/RaVBciseZmKuVqxzzDd/b6UH99XsxXcnymdXdYZ/QOgpM8nria7AJbOru3UFEY1E
         XtYbEDCuLEUsWeSgZY2de/b8MuwY14aSNhecMLNhluvwySSVL4EUu743StK9hL5AdeNJ
         msLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=58O9e2QFs0rhwf/IjftAShRH6V03p9k9B+YIUgcJogA=;
        b=auJgRFxcEG3IAOHPfJpg+l1dWeHrC/ch/3owXTew6WKuV8Xt9UZIdVpnpFYRlzYCl9
         hjQiLPcIH+BQDwb+e50Nx8Cl+j546bVIwgDGrGF+dplO6/THdyUJd0LtsRNmw3IgDoLE
         psC1gpaDjFPHyFvivK+8RyTqveyaMRV8ofCyguGJAEXTiH1K3t31+zYatQhUOnLTu1gY
         zYtH1IyNuasUFmArOxc08B8HEzPgn1sq0J2Rge0SLfYzU9nO2IbMGZ6tT/pN7IkiHxSi
         d6SEvdKYGwmPP79jVjdvYuyALM5gWJ3H1AvszmvLE1xDVh2vlp37vgLXSl4L96QaTcOy
         WZCQ==
X-Gm-Message-State: AOAM532H6oj1VDVWw6AMUHIObpzv6xYSaPCJc1YJEyYEkorpoKisJyyQ
        yjotDaBlSv1DbX+i8vuNkSn/BG2uxulbeQ==
X-Google-Smtp-Source: ABdhPJyz6oNTj6aMAqBMlwJi33uBPdApOBsmmku1dWWHotJXIwjtY3vfsaSP+D5HJBSVaEvrR45gLA==
X-Received: by 2002:a17:906:6c83:: with SMTP id s3mr6989247ejr.13.1633100740444;
        Fri, 01 Oct 2021 08:05:40 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id j20sm3026987eje.18.2021.10.01.08.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 08:05:40 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: ab/align-parse-options-help & ab/help-config-vars
Date:   Fri, 01 Oct 2021 17:01:38 +0200
References: <xmqqh7e18soj.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <xmqqh7e18soj.fsf@gitster.g>
Message-ID: <87a6jsrdj0.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 30 2021, Junio C Hamano wrote:

> * ab/align-parse-options-help (2021-09-22) 4 commits
>  - parse-options: properly align continued usage output
>  - git rev-parse --parseopt tests: add more usagestr tests
>  - send-pack: properly use parse_options() API for usage string
>  - parse-options API users: align usage output in C-strings
>
>  When "git cmd -h" shows more than one line of usage text (e.g.
>  the cmd subcommand may take sub-sub-command), parse-options API
>  learned to align these lines, even across i18n/l10n.
>
>  Will merge to 'next'?
>
>
> * ab/help-config-vars (2021-09-23) 9 commits
>  - help: move column config discovery to help.c library
>  - help / completion: make "git help" do the hard work
>  - help tests: test --config-for-completion option & output
>  - help: simplify by moving to OPT_CMDMODE()
>  - help: correct logic error in combining --all and --guides
>  - help: correct logic error in combining --all and --config
>  - help tests: add test for --config output
>  - help: correct usage & behavior of "git help --guides"
>  - help: correct the usage string in -h and documentation
>
>  Teach "git help -c" into helping the command line completion of
>  configuration variables.
>
>  Will merge to 'next'?

I think the v5[1] and v3[2] of these have, respectively, reached an
"addressed all feedback" and "should be good enough". I.e. had some
feedback on [2] that I'm choosing to read as some post-cleanup
suggestions :)

The reason I wanted [2] was for some user-facing documentation query
improvements in "git help", so having it go forward would be
great. Thanks!

1. https://lore.kernel.org/git/cover-v5-0.4-00000000000-20210921T132350Z-avarab@gmail.com/
2. https://lore.kernel.org/git/cover-v3-0.9-00000000000-20210921T223223Z-avarab@gmail.com/
