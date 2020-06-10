Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC10C433DF
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 03:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A6B42072E
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 03:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rbDufp+4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726040AbgFJDVa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Jun 2020 23:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgFJDV3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jun 2020 23:21:29 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F511C05BD1E
        for <git@vger.kernel.org>; Tue,  9 Jun 2020 20:21:29 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id t25so796191oij.7
        for <git@vger.kernel.org>; Tue, 09 Jun 2020 20:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E7HMmEWGqVlbS3k00F7KnTQSYqKrHrRN3IjbCYtC1Ww=;
        b=rbDufp+4TjiFLD/V5D/7LmigkgbcXPpFrhsYls5XY2+ZPfCsjPA/uW+XjGarl1Pv5b
         GnpIpTf//Mq2FlvCV7gw6GN4uIM29/qJOlamgpsF5635lZVWmCo8aLx3t1k8KbZo7gAn
         gpJoD7h13oFqpPQQDdH959bA4hWExgD+IYehfKz27MtChg2Mgg9TneR/Vzj73ybyXwA4
         pzDUn9DkSR116TW9Fsq5tH82YABPG9gHNXhKxQc8+l9kaeujbiA1Jk8J2WTUNZmPQNTm
         5B2bypSOfNN1ed74UDRjkrGb8tIfakvwb1pIgNsf8MOqLReXilNWMeuE67qfqg7xrjSv
         bUHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E7HMmEWGqVlbS3k00F7KnTQSYqKrHrRN3IjbCYtC1Ww=;
        b=FCtHPFNUkEIUuU9g71qXEhBydZJiNWPCZvdcz0PbTcO0lvkvF0hCS+YtxFV8S0kmVm
         YwzEmT3nsxhCSYwhBdCaSrv39Sovl8yi3JFFHcpBhlCw9mlXGT7h0vuR2RwhnXFtBXVR
         ODVewdT/T7T9MTqZFwpQ7ksVpAPbt7VlhHWTgPBiBhy7Oljdm6iHJ4R9fuVSCOrmyBwR
         l7SUgl9ZRZGLpbr511U+SgrDMj9PZco14f7WyDRM8mD9N0HaVdj4IgJvxkgYbrr6V5dX
         61RjRYLsbcHTa4g8ZlBAa5rprsOk4nmMW+oRgfbSQnZTzv/kb3d7O1vOgWDIlc+NClLX
         S9mA==
X-Gm-Message-State: AOAM5300Y7LKHxwp8qXtpFK82afDSyAF2fK7aMoFzBVHOp3lnMrVIbZ4
        Fbmm+Pg0es04Hl+lKPzMeyiRTTwCBni+ED67eqU=
X-Google-Smtp-Source: ABdhPJxUUaB6uTCaaUEvEnEopfnXgbQD7N4VHIiIXE2kepMbTTnOehPRrcbSZqNpgULF9WEJAT+XkcxVJ01shzvkr84=
X-Received: by 2002:a05:6808:4b:: with SMTP id v11mr1026995oic.31.1591759288590;
 Tue, 09 Jun 2020 20:21:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAJB88a39G-GkGu1LuRE8na45Pav_cWb3cJLQFJM+FuW3BnromA@mail.gmail.com>
In-Reply-To: <CAJB88a39G-GkGu1LuRE8na45Pav_cWb3cJLQFJM+FuW3BnromA@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 9 Jun 2020 20:21:17 -0700
Message-ID: <CABPp-BHv+5XSXMpZ=-kM=a3C0Y+v=JY5m11s-QWj_krjCvvO4g@mail.gmail.com>
Subject: Re: git stash --include-untracked walks ignored directories
To:     Brian Malehorn <bmalehorn@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 9, 2020 at 1:39 PM Brian Malehorn <bmalehorn@gmail.com> wrote:
>
> Hi,
>
> Not sure if this is the right place to send this, but I'm here to
> report a performance regression with git stash --include-untracked.
>
> Here's a quick way to reproduce:
>
> 1. make a directory with a lot of ignored files
>
> $ find ignored -type f | wc -l
>    50000
>
> $ cat .gitignore
> ignored
>
> 2. touch foo
>
> 3. time git stash --include-untracked
>
> git version 2.26.0:
> real    0m0.094s
>
> git version 2.27.0.83.g0313f36c6e:
> real    0m1.913s
>
> This is a much bigger pain point on my work repo, which has 1.4
> million ignored files(!). As you can imagine it takes a long time to
> run git stash. While it might be valid to question why anyone would
> need that many files for any purpose, the bottom line is that I told
> git to ignore this directory, and it didn't ignore it.
>
> In the meantime I've reverted to 2.26.0 which doesn't have this
> performance regression. Let me know if you want any other information
> related to this issue.
>
> Thanks,
> Brian

I seem to be missing some important step to reproduce; what else is
needed?  Here's what I see:

<Set path to use git-2.26.0>
$ ./repro.sh
Number of files in ignored before: 50000
Saved working directory and index state WIP on master: e2b0471 initial

real 0m0.029s
user 0m0.014s
sys 0m0.014s
git version 2.26.0
Number of files in ignored after: 50000

<Set path to use git-2.27.0>
$ ./repro.sh
Number of files in ignored before: 50000
Saved working directory and index state WIP on master: 5c596b8 initial

real 0m0.052s
user 0m0.014s
sys 0m0.034s
git version 2.27.0
Number of files in ignored after: 50000


Where repro.sh is:

#!/bin/bash

rm -rf stupid
git init -q stupid
cd stupid

echo ignored >.gitignore
seq 1 10 >numbers-tracked
git add numbers-tracked .gitignore
git commit -q -m initial

seq 11 20 >>numbers-tracked
seq 21 30 >numbers-untracked

mkdir ignored
cd ignored
for i in $(seq 1 50000); do >$i; done
cd ..

echo "Number of files in ignored before: $(find ignored -type f | wc -l)"
time git stash --include-untracked
git --version
echo "Number of files in ignored after: $(find ignored -type f | wc -l)"
