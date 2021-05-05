Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DFA9C433B4
	for <git@archiver.kernel.org>; Wed,  5 May 2021 18:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E7FA61176
	for <git@archiver.kernel.org>; Wed,  5 May 2021 18:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234017AbhEESPL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 14:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbhEESPK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 14:15:10 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349E4C061574
        for <git@vger.kernel.org>; Wed,  5 May 2021 11:14:14 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id n32-20020a9d1ea30000b02902a53d6ad4bdso2531726otn.3
        for <git@vger.kernel.org>; Wed, 05 May 2021 11:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=/Y8NJTMGaEe76VS8DTGlayfwtkHJ1/vhhhLT4TdQkcY=;
        b=Ea4RsKUC0+L+fmO1B0ATBg1u22iLmwnn2L4G9pJX9GW9WcvMbDzJlc7EXZ+LRmp6X/
         YCd1jlAhemnBDlYq2fbOwpDb5p2/hBC9sx2XOj7z4dq+3L9f7ag7Fj8Mz6R43WwuCP2T
         zwL0jP4+oz3MeecKd+Pff4SSW8QJipUAtyFpwYbAZULGUuYItf2TlwCuRDlOaEQ5pttV
         iKzvfrNQDAhQepo6brof5QEvLYiqzzzEdcsdKWYF7rP2CDf3d6p5wk6orkuDRjdA9D8c
         bWwxJN0i8I67YwhtvsyoAz4sskBM5FqfQ5UcJITGpmZdNBFWyJOPr0kOxdM9P8xQUhCy
         0Ozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=/Y8NJTMGaEe76VS8DTGlayfwtkHJ1/vhhhLT4TdQkcY=;
        b=i0YFa/+Po+3hxGzE/t4g27uPxG0eIyJAdqYV2QaojH+aRLxtpwwu+Qa9XA4kEn35y7
         UxXGQMTMS5bSP2skpWqI/6J6PIhnssXDduOUNFvdpqarXJ4j/vqlmpb0/qsLWeSVrdoN
         MLAOYmCFcv+2bwpEODXikU52zj1en2HuC6EAawZCMu9+D9OrMpZ26D1aBib7I7T5z8CQ
         DDglCdSDNo9HpR+RzTqy+9jmP10dLjsxKHMeWiAd7iyYcK3TMv0QRReQ3dzyaOkdAK9z
         n1yfAs/STPJwtaxwvU8s4AwpnjVhpymJfwAQ3Sz0no6kGKAvamdobB5q+Xwu4ENOefGu
         sOqg==
X-Gm-Message-State: AOAM5320v0cVN7Q1wSjVKKKbf+c/7m8NzUUhkVyowYPlBUSAnlz3kbzg
        HZkb+49JSLdnumQq+OLPeNKn+886cY2cTvZy+/ISFXJm9nw=
X-Google-Smtp-Source: ABdhPJxvqOtqFqFzAhMKr2LAa34ETIFUtkCFCEE+pUI3jAu3EOXo9VqpPJ+JibHWnbZVhM1gEJE2d8hA/Fqqx8meDYc=
X-Received: by 2002:a05:6830:30a7:: with SMTP id g7mr13743204ots.27.1620238453523;
 Wed, 05 May 2021 11:14:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAEumJaDRvU8LP=q3PQ1z6-cg75DmbHE_7OXZVA+nm=-77pVLEg@mail.gmail.com>
In-Reply-To: <CAEumJaDRvU8LP=q3PQ1z6-cg75DmbHE_7OXZVA+nm=-77pVLEg@mail.gmail.com>
From:   Theodor Negrescu <theodor.negrescu@gmail.com>
Date:   Wed, 5 May 2021 21:13:58 +0300
Message-ID: <CAEumJaBDqSyqbnvWSeCyXYQJz92dOg+y1pz2JLjPSMRzWxc1aA@mail.gmail.com>
Subject: Re: BUG: Git path --config doesn't work with ~ symbol
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I meant Git config --file!! Sorry, I wrote the wrong thing in the title.

On Wed, May 5, 2021 at 9:06 PM Theodor Negrescu
<theodor.negrescu@gmail.com> wrote:
>
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>
> What did you do before the bug happened? (Steps to reproduce your issue)
>
> I ran the command "git config --file ~/git-settings/.gitconfig -l"
> (git-settings is a repo where I keep my config, the global one is just
> an include)
>
> What did you expect to happen? (Expected behavior)
>
> It would list the settings in the file.
>
> What happened instead? (Actual behavior)
>
> fatal: unable to read config file '~/git-settings/.gitconfig': No such
> file or directory
>
> What's different between what you expected and what actually happened?
>
> The ~ symbol should point to my home folder.
>
> Anything else you want to add:
>
> "git config --file ~/.gitconfig -l" doesn't work either so the ~
> symbol is the problem.
> fatal: unable to read config file '~/.gitconfig': No such file or directory
> "git config --file .gitconfig -l" works when I run it from my home
> folder or from git-settings so the --file argument is working.
>
> [System Info]
> git version:
> git version 2.31.1.windows.1
> cpu: x86_64
> built from commit: c5f0be26a7e3846e3b6268d1c6c4800d838c6bbb
> sizeof-long: 4
> sizeof-size_t: 8
> shell-path: /bin/sh
> feature: fsmonitor--daemon
> uname: Windows 10.0 19042
> compiler info: gnuc: 10.2
> libc info: no libc information available
> $SHELL (typically, interactive shell): <unset>
>
>
> [Enabled Hooks]
> not run from a git repository - no hooks to show
