Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D832C433EF
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 22:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238427AbiGSWUY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 18:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238218AbiGSWUU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 18:20:20 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90FA33E34
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 15:20:19 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id n12so10775548wrc.8
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 15:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=+HoY6REjmqjQ23ZtU06FxoLLxh2ISOokt5WLae/WNW8=;
        b=meDnL/Mxoa1YCW3eIogOJ3LQwqNJ/pbiXbd2jD42mLzPaPtRpiXNEQuP5DWXKFTlD8
         xvbNVzb3FTL7SFzwTdUPUqoWvrA7O4o+rB/omDfgxyzQMQDyCKyX4kQg7/KjUO6WZ+1/
         T3Y+2/cVNS7Kc/wUHQ4iKMQxgyGc9kjywhPPpg3f0IwxGtHBxh1S1hsTL3zx1zAayAHh
         jjE2qVvD+xX96wsDno7zowsExjqeNEDTCXUTxDS2jNW+VdHt3AvkCn3fdxTuUAMKYvNj
         YtsG2d+PBNnTn6RNgfSARmzCT3ARFWooKxSenDqIryxb1o68PhC1e5+TUIEc/vTFFxP2
         6uow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=+HoY6REjmqjQ23ZtU06FxoLLxh2ISOokt5WLae/WNW8=;
        b=PVVcfenOBZumrG6kSpO+LISaElQC7JNHAbz1DG9NKcP/WhG23U9OgMrV2Ogx0j8VcI
         l31CiXjWTyZ1I8Rkm8Cx6DDIUHwFkDjt7J4NrdplbFa5MR98l3w/zdocomkOvtObEQlr
         NlKQnomRGOYccM2U2VsOFkwTicZuqCh3MujYC3DQd3T7TPr/abVDOv4nvbSpl5QXHdvo
         of/yDikmvYEeoyujo82DjXCv0bMA8BKPssx5j9nQBs7kJvCov9NlYPSiT8/nEzH1VPJT
         AI21sWntsrR1J9z1SR5bmWUohvpIpbPcgqfxhrfaS+ZMA8hxBy2fMSANBuBmoYl3KUmU
         yOyw==
X-Gm-Message-State: AJIora+j77F+if9rlqfeS8W6UcIl3mYycJgPSvvnfmDSw9skKp/cy+iu
        yxjPqcxufEUsY7ECRAagJT3R5Mb9GB9LmiL15pRpoHlPU8o=
X-Google-Smtp-Source: AGRyM1vmbmsXlGPClkSNTQmw4H6GimgRCVlWZT+Xc9mJcySdze5oUxTofNX5GE+FzDmBcMmDIJCoBbCt6yEqOBTOxFA=
X-Received: by 2002:adf:eace:0:b0:21d:6e90:2bf8 with SMTP id
 o14-20020adfeace000000b0021d6e902bf8mr26730963wrn.349.1658269218227; Tue, 19
 Jul 2022 15:20:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAC7ZvybvykKQyMWcZoKXxFDu_amnkxZCDq2C6KHoyhmHN2tcKw@mail.gmail.com>
In-Reply-To: <CAC7ZvybvykKQyMWcZoKXxFDu_amnkxZCDq2C6KHoyhmHN2tcKw@mail.gmail.com>
From:   Kache Hit <kache.hit@gmail.com>
Date:   Tue, 19 Jul 2022 15:20:07 -0700
Message-ID: <CAC7ZvyYGSa-sH1LZ8Lo=NRXbvJsujgFYGPOQR5ZwGHJHZgoDzA@mail.gmail.com>
Subject: Re: BUG: fsmonitor.c:21: fsmonitor_dirty has more entries than the index
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A thought: the 179457 is reminiscent of something else I did just before th=
is:

I was doing some "code archeology" and was headlessly checking out
some old SHAs in this large monorepo.
During checkout, it said it was updating 174823 files in total.

On Tue, Jul 19, 2022 at 2:36 PM Kache Hit <kache.hit@gmail.com> wrote:
>
> Hi. Output of git bugreport:
>
> ---
>
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>
> What did you do before the bug happened? (Steps to reproduce your issue)
>
> Wanted to retain git tree structure when pulling latest and rebasing.
> First indication of error was the `rebase -r` of the merge commit
>
> What did you expect to happen? (Expected behavior)
>
> successful --rebase-merges rebase of my commits on top of master
>
> What happened instead? (Actual behavior)
>
> ```sh
> =E2=9D=AF git rebase -r master
> BUG: fsmonitor.c:21: fsmonitor_dirty has more entries than the index
> (179457 > 1040)
> zsh: abort      git rebase -r master
> ```
>
> What's different between what you expected and what actually happened?
>
> Anything else you want to add:
>
> I'm currently "stuck" in this state, not sure how to recover or repro:
>
> ```sh
> =E2=9D=AF git s
> BUG: fsmonitor.c:21: fsmonitor_dirty has more entries than the index
> (179457 > 1040)
> error: git died of signal 6
>
> =E2=9D=AF git log
>
> =E2=9D=AF git d head~
> error: git died of signal 6
> BUG: fsmonitor.c:21: fsmonitor_dirty has more entries than the index
> (179457 > 1040)
>
> =E2=9D=AF git log # works
>
> =E2=9D=AF git status
> BUG: fsmonitor.c:21: fsmonitor_dirty has more entries than the index
> (179457 > 1040)
> zsh: abort      git status
>
> =E2=9D=AF git commit --amend
> BUG: fsmonitor.c:21: fsmonitor_dirty has more entries than the index
> (179457 > 1040)
> zsh: abort      git commit --amend
>
> =E2=9D=AF git checkout head
> fatal: Unable to create '/Users/XXXXX/YYYYY/.git/index.lock': File exists=
.
>
> Another git process seems to be running in this repository, e.g.  #
> All of this was run while git bugreport was running
> an editor opened by 'git commit'. Please make sure all processes
> are terminated then try again. If it still fails, a git process
> may have crashed in this repository earlier:
> remove the file manually to continue.
>
> =E2=9D=AF rm /Users/XXXXX/YYYYY/.git/index.lock
>
> =E2=9D=AF git checkout head
> BUG: fsmonitor.c:21: fsmonitor_dirty has more entries than the index
> (179457 > 1040)
> zsh: abort      git checkout head
>
> =E2=9D=AF git checkout head
> fatal: Unable to create '/Users/XXXXX/YYYYY/.git/index.lock': File exists=
.
>
> Another git process seems to be running in this repository, e.g.
> an editor opened by 'git commit'. Please make sure all processes
> are terminated then try again. If it still fails, a git process
> may have crashed in this repository earlier:
> remove the file manually to continue.
> ```
>
>
> Please review the rest of the bug report below.
> You can delete any lines you don't wish to share.
>
>
> [System Info]
> git version:
> git version 2.37.1
> cpu: x86_64
> no commit associated with this build
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> feature: fsmonitor--daemon
> uname: Darwin 20.6.0 Darwin Kernel Version 20.6.0: Tue Feb 22 21:10:41
> PST 2022; root:xnu-7195.141.26~1/RELEASE_X86_64 x86_64
> compiler info: clang: 13.0.0 (clang-1300.0.29.30)
> libc info: no libc information available
> $SHELL (typically, interactive shell): /bin/zsh
>
>
> [Enabled Hooks]
> pre-commit
> pre-push
