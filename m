Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C83A8C433F5
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 13:27:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350808AbiBCN1z (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 08:27:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232730AbiBCN1y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 08:27:54 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40997C061714
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 05:27:54 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id b17-20020a9d4791000000b005a17fc2dfc1so2589029otf.1
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 05:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=delphia.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=CZFGM11ayr929OURPRZR2+0il9YZlYchWm0oOJk5k8M=;
        b=b3qFEkWdJ2qyCxNAZ2dqNt6f1fFJMVJqqdTToLIkyY83GQphnGbMi2TZ9pdz/+KYFL
         fNDrSBS1Mo1sIdMdg8hJvxXFmYZOODVGCjibp0FFTBswb5Cxv/CTLYsyPPC7JWQ01KkV
         iDnNMUxH6QOIl6XFOmuCpfQC5/lPrXFgYdyxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=CZFGM11ayr929OURPRZR2+0il9YZlYchWm0oOJk5k8M=;
        b=WjeZuLWy6CwTesFe6at7686Q0lClf0krGBECZBnrNO6kqANf3W+o3wPgvt/8JEn/e5
         hkv/z2+SVy/raRcYIGFnisu7kI0EtM0HVR7ZBf+VNr8/mExYzT92OLlHcJuu39T0X81I
         2ip1FDiQpcu2pGnx5zMivzekakQoh9lF4aLF6VjhV8X41FFiD82ygXH9cISxWnp54yyh
         sbPAfZw61EAIrIQ/lURJd3uCKLyG7EKghQLdp4ORAgCW7WTMRQ24doqRq6KppQkN+Bzv
         EVCqDuJ7/Hvk7p8eIM1vDJyplTm5EzdgAVN3HWBoL0cKp2tbG3MTBLsihjqNF53kjN7B
         w3Zw==
X-Gm-Message-State: AOAM531rpxlFnoClddC2eSTfXAL2LgvNvsZnJ/8/1AphQBN3x0n5lMNN
        YbB2RbIYk9byo2Y/1XbLslIqDtpMu1AA2JVgCJTWrhqZOg==
X-Google-Smtp-Source: ABdhPJx5XuKsy6LLrunz9blzO9zB2386m6ixWuYlGAUADXHrMxGxxUw/SXVqV1T57vhvIBOTMPu/aC8VODol/EfECc4=
X-Received: by 2002:a9d:7382:: with SMTP id j2mr15880178otk.291.1643894873451;
 Thu, 03 Feb 2022 05:27:53 -0800 (PST)
MIME-Version: 1.0
References: <CA+RO+X6Lat5-AZ+BoHwW8xzhXuNOTjQewyNAvzOjWF_Md0x_yA@mail.gmail.com>
In-Reply-To: <CA+RO+X6Lat5-AZ+BoHwW8xzhXuNOTjQewyNAvzOjWF_Md0x_yA@mail.gmail.com>
From:   Zhuo Cheng Du <zhuo@delphia.com>
Date:   Thu, 3 Feb 2022 08:27:42 -0500
Message-ID: <CA+RO+X4GAXVEA44nqaAKVxAxxzGQkf66kLrwadw3qcsZhULJgQ@mail.gmail.com>
Subject: Re: Git Bug Report: 'git stash pop' always put newly added files into
 staging area
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi there,

Just an update, I have upgraded git to the latest version (2.35.1),
and this bug still exists.

Thanks,
Zhuo

On Wed, Feb 2, 2022 at 1:50 PM Zhuo Cheng Du <zhuo@delphia.com> wrote:
>
> What did you do before the bug happened? (Steps to reproduce your issue)
> 1. Create a brand new file, e.g. 'touch a.py'
> 2. Add it to worktree with 'git add a.py'
> 3. stash the file with 'git stash'
> 4. pop the stashed change with 'git stash pop', WITHOUT the --index option
>
> What did you expect to happen? (Expected behavior)
> I expect the file 'a.py' to be in unstaged area since I did not pass
> the '--index' option to 'git stash pop'
>
> What happened instead? (Actual behavior)
> The file is found in staged are are after 'git stash pop', potentially
> causing merge-conflict in certain scenarios
>
> What's different between what you expected and what actually happened?
> I want the file to be found in unstaged area. The 'git stash
> push'/'git stash pop' combo works as expected if the file is already
> added to worktree prior to this maneuver. I think the behavior should
> be consistent for brand new files as well.
>
> Anything else you want to add:
>
> Please review the rest of the bug report below.
> You can delete any lines you don't wish to share.
>
>
> [System Info]
> git version:
> git version 2.31.0
> cpu: x86_64
> no commit associated with this build
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> uname: Darwin 21.3.0 Darwin Kernel Version 21.3.0: Wed Jan  5 21:37:58
> PST 2022; root:xnu-8019.80.24~20/RELEASE_X86_64 x86_64
> compiler info: clang: 12.0.0 (clang-1200.0.32.29)
> libc info: no libc information available
> $SHELL (typically, interactive shell): /bin/zsh
>
>
> [Enabled Hooks]
