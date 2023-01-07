Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E51FC54EBC
	for <git@archiver.kernel.org>; Sat,  7 Jan 2023 19:37:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjAGT3b (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Jan 2023 14:29:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjAGT32 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jan 2023 14:29:28 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C30C1CFD1
        for <git@vger.kernel.org>; Sat,  7 Jan 2023 11:29:27 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-4a263c4ddbaso64731277b3.0
        for <git@vger.kernel.org>; Sat, 07 Jan 2023 11:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=15wC6+ug0V4NwYY/fpQXjqQvhMUVznC7dS4GKg6kJkE=;
        b=OURWDC1VGGZPqN/BGmyDc0OwTTuL8ftlmovujBgn4hWTqthtnxYnyoIET3CaMk+1RG
         zsz+xTWokJzK1D4965YGcVE8+vhKhWoWLvHrFdYCU4GSOYuguYu2IKEFsY6qKpq9z7qa
         SHo15NG/Pq8uura7rneuDJVMuuuISv1wW6vWHGmdc4XgxL0MsyqYP4AQtkVxqcEmLqc/
         toafmDcFxC4WDOlFJpq1KH7VW2MmSqAj6CLbxzXoCrA+IxZlKFokNs5YvvjxGrHeGiT3
         3hiatXyYR7JV0oVw5PElfedNkHK8ezbUvpOYcJ2GqW02nAs2JowN0KwKGRqtPmHTgfB+
         0daw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=15wC6+ug0V4NwYY/fpQXjqQvhMUVznC7dS4GKg6kJkE=;
        b=hfcJF8obZJyRPMTZDHheuniXMLUSuKqh5qAyeBcHzTr65W/G9J2cqkQPmU7n738W/l
         IkBHByydarQGYyKtzbsevwRFY3Twb42cIGN32/FIIRrAFnY0T1xkaeutK6qxq+IFoyEv
         AlYg+hFQ3Z+5bSu9ofG0QDX5Xe3cpS61Z7thwK6Dyk0jNzAvu28lDZvJ8g3KG6pXd7y+
         OervCFsQiyVf1GVCKvUjWpGwvKlckmDgbVkgkxMW+ifiMT+dfiQyF8biMbWIZK6JJYPw
         Hbu8pq/sJMIR0fkzof7cr4A7X0LiEjWKZtoXjN6SOB3R47SyHf8SBQdia1500rIj4pLy
         aw2w==
X-Gm-Message-State: AFqh2kr9MipjV0DmDCWzAuYuQSALNR8T1LTMkrxYj7YSwwe+xV6pktZH
        4ZcKtIeYUe5L6AiQveZj3Jc6IKzramcxPC+Qdbe+kSYK09I=
X-Google-Smtp-Source: AMrXdXsgum8KPuqRJJyjKbebs/E2nmg3HNBY8f53w3mrmvEzc7j6QnHxYEtWfhJki/Q7PaBEcjAIDtNI/qlEJLt7wiU=
X-Received: by 2002:a81:8354:0:b0:464:d8a5:17ab with SMTP id
 t81-20020a818354000000b00464d8a517abmr451954ywf.85.1673119766027; Sat, 07 Jan
 2023 11:29:26 -0800 (PST)
MIME-Version: 1.0
References: <CAC-j02OVoFDFjeGUjcs0ZMwPSXKLL_GBme2m2-ttzGTbxXNP-w@mail.gmail.com>
In-Reply-To: <CAC-j02OVoFDFjeGUjcs0ZMwPSXKLL_GBme2m2-ttzGTbxXNP-w@mail.gmail.com>
From:   Preston Tunnell Wilson <prestontunnellwilson@gmail.com>
Date:   Sat, 7 Jan 2023 13:29:15 -0600
Message-ID: <CAC-j02OGVx_=0WjHgf3CDSzC0MXYRcfNxf886JK9u7wdg-g8jQ@mail.gmail.com>
Subject: Re: Bug report between git hooks and git worktree
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I tried this out on the `next` branch of `git` and still see the
error. The version I'm using is

```
[System Info]
git version:
git version 2.39.0.246.g2a6d74b583
cpu: aarch64
built from commit: 2a6d74b5839c13a139e2856e92b7bd8110056098
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 6.0.7-301.fc37.aarch64 #1 SMP PREEMPT_DYNAMIC Fri Nov 4 18:13:35 U>
compiler info: gnuc: 12.2
libc info: glibc: 2.36
$SHELL (typically, interactive shell): /bin/bash
```

On Sat, Jan 7, 2023 at 12:59 PM Preston Tunnell Wilson
<prestontunnellwilson@gmail.com> wrote:
>
> Hello!
>
> I ran into a strange issue using git-worktree with git-hooks. I have
> attached the output of `git bugreport` below. More concrete steps to
> reproduce are available in
> https://github.com/prestontw/git_hook-git_worktree-minimal-repo. I've
> run into this both in macOS and Fedora---I've included the system
> information from both of these systems below.
>
> What did you do before the bug happened? (Steps to reproduce your issue)
>
> Add a git hook that executes git commands inside of another folder. Let's
> call this other folder `FolderA`.
> (This might sound weird, but `flutter` distributes itself through a `git`
> folder in some circumstances and uses `git` commands to see which version
> the user has installed, etc.).
>
> Add a git worktree branch/folder, `cd` to it, and commit something there.
> Let's call this git worktree folder `FolderW`.
>
> (Steps are outlined in more detail with an example in
> https://github.com/prestontw/git_hook-git_worktree-minimal-repo.)
>
> What did you expect to happen? (Expected behavior)
>
> The git command would report details from `FolderA`.
>
> What happened instead? (Actual behavior)
>
> The git command outputs details from `FolderW`.
>
> What's different between what you expected and what actually happened?
>
> I would expect the git command to output details from `FolderA`.
> It's confusing to me that there is a difference in behavior between
> the "main" branch and `FolderW` in git hooks.
>
> Anything else you want to add:
>
> I'm seeing this both in macOS and Fedora. I've added that system
> info below.
>
>
> [System Info]
> git version:
> git version 2.32.0 (Apple Git-132)
> cpu: arm64
> no commit associated with this build
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> uname: Darwin 21.4.0 Darwin Kernel Version 21.4.0: Mon Feb 21 20:35:58
> PST 2022; root:xnu-8020.101.4~2/RELEASE_ARM64_T6000 arm64
> compiler info: clang: 13.1.6 (clang-1316.0.21.2)
> libc info: no libc information available
> $SHELL (typically, interactive shell): /bin/zsh
>
>
> [Enabled Hooks]
> pre-commit
>
>
> [System Info]
> git version:
> git version 2.37.3
> cpu: aarch64
> no commit associated with this build
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> uname: Linux 6.0.7-301.fc37.aarch64 #1 SMP PREEMPT_DYNAMIC Fri Nov 4 18:13:35 U>
> compiler info: gnuc: 12.2
> libc info: glibc: 2.36
> $SHELL (typically, interactive shell): /bin/bash
>
>
> [Enabled Hooks]
> pre-commit
