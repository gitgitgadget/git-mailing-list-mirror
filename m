Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A8ECC433EF
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 18:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03B7461A64
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 18:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233284AbhKSS3h (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 13:29:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232235AbhKSS3g (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 13:29:36 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19033C061574
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 10:26:35 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id i12so10061629pfd.6
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 10:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9HpGIPorkxWF9I6MF7snu8GH0aMq0dPhSZ9BUpFljDk=;
        b=PLiet6LklPC68LE30R7m5Zv2/CwWmwtqXQ15JOk5C1x82rXYdVbbJqU6mwToG0qX9Y
         xluN/91XQjXtAx1WmMvijSG6FKr5+7A9VU2pbem4SvZpeK+Zq3bIzjnUOgIjRaKw2JQz
         yMUDwqSkeeAiJggiumuXgAYzoJn/GbxJBV3n40ABA2CD4fo5vzucReEGDStJLY8eGv0+
         oDLgErGNGVHZFxQvNLBVXXen2lEJR+/FPDWY1cI9gRV0CraAfS8fKtrWbtCUIImmYIR/
         yGocUssrpZCxEbBmU2WsKQEMIeEZQFh02FuHxiQC6vliaRIQHNFHVGkUntoYQpiq2E15
         PK9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9HpGIPorkxWF9I6MF7snu8GH0aMq0dPhSZ9BUpFljDk=;
        b=AUcG0ZWgVrztwvPLtunayHDCe9+SqB7yQdwzWP2o3XQ5Klsja2D/mslSXUZbOQjxY2
         B/zb3TEWb95u++P7D0YnKuJAvdwDLnySuO4QH3GxxQTDbeCauPHKPoaMflsH6Sna5YHg
         ZYJyMi6GhFmnAw+wHatc/wtkaaxo9x3F9u88JBfTLboiR1qNdGVyFeyig5MUB/+Gp41c
         ua79M88pl0rypS+9wYGPjFXv9hDZAvZuxCZepqp28UjzjtuTfMmLUxSrphgFzLSQ9V7Y
         jD9B6XnMMyXEBnpQtDffIM+SgDmaiSoEpwqs2/F7mIYoFgB/U0bMXR4Evd4rx7Oo4ItK
         XQkw==
X-Gm-Message-State: AOAM531Sk4muI3lyVahqJkcXCMcFmx2PQBeajAi5DFSCd/oCpDQ9iCbI
        Vc2291ztSg2Iw6ZzJkHsbc+b1WC0mqcoQxo0lx1DgfzliUE=
X-Google-Smtp-Source: ABdhPJxBCliELEXUPuO5LW7UfCUolyAYwq+keoGj04URBtzcRhtOCNq+uwmFx5NKzrXEnlMHAjZDOJj4mdzaERRkcO8=
X-Received: by 2002:a63:ff1d:: with SMTP id k29mr18101697pgi.372.1637346394622;
 Fri, 19 Nov 2021 10:26:34 -0800 (PST)
MIME-Version: 1.0
References: <CAMn8hCcFLR-YyLaawtbtjpVUKd45Z4C6t1kWj+-WBZVNtNgozw@mail.gmail.com>
 <20211119090037.m4zfzovaitfj35l3@fs> <CAMn8hCf1ypU4Bwt8bDgai86QFTdORPyaHiE7W+=tx_rKbchz4w@mail.gmail.com>
 <20211119110722.noxoecfk5zk5hssv@fs>
In-Reply-To: <20211119110722.noxoecfk5zk5hssv@fs>
From:   Thor Andreas Rognan <thor.rognan@gmail.com>
Date:   Fri, 19 Nov 2021 19:26:18 +0100
Message-ID: <CAMn8hCeOkGk5TQyzqcjsDhs4UW0QpFzAsz_OM3UZ1ZqYioWnPw@mail.gmail.com>
Subject: Re: Ambiguous verification response when ssh-based signatures
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Fabian,

I upgraded and it works, thank you for your help! :)

Best regards,
Thor

On Fri, 19 Nov 2021 at 12:07, Fabian Stelzer <fs@gigacodes.de> wrote:
>
> On 19.11.2021 11:26, Thor Andreas Rognan wrote:
> >Hi Fabian,
> >
> >Thank you for your quick response! Commands and output below:
> >
> >$ ssh -V
> >OpenSSH_8.1p1, LibreSSL 2.7.3
> >
> >$ GIT_TRACE=1 git commit -m "Trace keygen commands with GIT_TRACE"
> >11:13:49.771601 git.c:455               trace: built-in: git commit -m
> >'Trace keygen commands with GIT_TRACE'
> >11:13:49.776095 run-command.c:668       trace: run_command: ssh-keygen
> >-Y sign -n git -f
> >/var/folders/jj/sfgpggbj5b13gvljxf977zq80000gn/T//.git_signing_key_tmp1FkZ52
> >/var/folders/jj/sfgpggbj5b13gvljxf977zq80000gn/T//.git_signing_buffer_tmpBweN52
> >11:13:49.814072 run-command.c:668       trace: run_command: git
> >maintenance run --auto --no-quiet
> >11:13:49.819952 git.c:455               trace: built-in: git
> >maintenance run --auto --no-quiet
> >[main 633e567] Trace keygen commands with GIT_TRACE
> > 1 file changed, 59 insertions(+)
> > create mode 100644 git-bugreport-2021-11-19-0311.txt
> >
> >$ GIT_TRACE=1 git verify-commit HEAD
> >11:14:40.274423 git.c:455               trace: built-in: git verify-commit HEAD
> >11:14:40.277417 run-command.c:668       trace: run_command: ssh-keygen
> >-Y find-principals -f ~/.config/git/allowed_signers -s
> >/var/folders/jj/sfgpggbj5b13gvljxf977zq80000gn/T//.git_vtag_tmpEI3SAu
> >11:14:40.284075 run-command.c:668       trace: run_command: ssh-keygen
> >-Y check-novalidate -n git -s
> >/var/folders/jj/sfgpggbj5b13gvljxf977zq80000gn/T//.git_vtag_tmpEI3SAu
> >Good "git" signature with ED25519 key
> >SHA256:x3FRAl3XR188M9KR3UE+TuG3jkZzPQMjfBo+ddbM0dk
> >Too few arguments for sign/verify: missing namespace
> >
>
> Ok. OpenSSH 8.1p1 does not have the required functionality for the ssh
> signing feature. Normally a git warning would trigger to notify you
> about this. Unfortunately it seems as openssh introduced the features
> between 8.0 and 8.2 and exactly the 8.1 version has some of them but not
> all and does not produce the expected error for the find-principals call
> :/. I'll check if can do something about this and print the correct
> error.
>
> I'd recommend to upgrade to the latest openssh 8.8. If you don't want to
> upgrade your OS version you can install to another prefix (e.g.: /opt)
> and point git to the newer ssh-keygen command like this:
> `git config --global gpg.ssh.program /opt/openssh/ssh-keygen`.
>
> Fabian
