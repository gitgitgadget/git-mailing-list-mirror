Return-Path: <SRS0=yx/J=7F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5611BC433E0
	for <git@archiver.kernel.org>; Sat, 23 May 2020 22:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15F40207CB
	for <git@archiver.kernel.org>; Sat, 23 May 2020 22:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="dDWc9sML"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728704AbgEWWZ0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 May 2020 18:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728488AbgEWWZ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 May 2020 18:25:26 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12296C061A0E
        for <git@vger.kernel.org>; Sat, 23 May 2020 15:25:26 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id w64so13391270wmg.4
        for <git@vger.kernel.org>; Sat, 23 May 2020 15:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:from:date:message-id:subject:to;
        bh=w6Xg0EzOKzB5ab0nZrxzH4Iyivspax7dUzsmKuMXo7Q=;
        b=dDWc9sMLSWb880UUlUuUvrMXnyQaM0E4PGGSdUxHxe14vAyM4fSdpiX0C6UvHcPB8p
         n96BlAE104DWMfScgtib6EoRZ6Z6pyx4kEp8aND1o7yZ8o/GH+/BOlHdnXQvg8QNZ2sW
         ZmttL6J9XxEboL1EprfuAAjx0943RjWXq7ewRGxk0Ic32MGl+tTI45/qCtBID+vLncgw
         b/IYUXF7zNvlBLahXmPlefQQdrT9ut8lzS0Bo1HPbveOAuGbvPF475HwyHJ/9qan8J80
         0cK0RRoMWRq+CR1rbyX4cE7qzCrQXcmWYRpnIw90VfwJsASpANlOQeDNNeJEzryq8a8c
         FgCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=w6Xg0EzOKzB5ab0nZrxzH4Iyivspax7dUzsmKuMXo7Q=;
        b=KUZlhs1dFmlgTpBE/LdhPpbqD3lt5iidnh/4utJ7Qwpan4rCYuVLUbklUibxKNLLqq
         tZaGJvmAEZPGKJA9Iv36E857fUPEtZPf8nfKkdEzImPXfMZPtYydycRtrV65xu/v/LP6
         9/1Id2a4sgw8fkoi0ONNxhX4jq2KA42pVL1GSpn/mPoDO8FOAvighsOz6uQ18amBtaNk
         W3wC5jaB0anjdgrRDsowAV9JOqzscp8CnX6jYV6+3v+rfRR6SEhdRFyoydXGoKa0vvs1
         ovznHpgJKsdHeg/SFaoDCZzJZMEj++oMBBJZW8RR3punhJ2aOmgHNUkkOzugJMF0O1Iu
         IPVw==
X-Gm-Message-State: AOAM531D1U6NDYGWHCoeB0FbRxVX0Po5gZgwaPqyStojQEj1ibGellyJ
        sg6LEy9mYL3FSEA7L+krQzmkSUQV7j+nvZN9dCmhnSheDb4=
X-Google-Smtp-Source: ABdhPJwID1U2C9Atw/AeNJAJNPAf6UfApnax1UUj9bs/nkvjgZuD3Oj2C77kf4DiyelbfAOuNPbbEYPTqhoURHYveC8=
X-Received: by 2002:a7b:c353:: with SMTP id l19mr19504374wmj.187.1590272722750;
 Sat, 23 May 2020 15:25:22 -0700 (PDT)
MIME-Version: 1.0
From:   Anthony Sottile <asottile@umich.edu>
Date:   Sat, 23 May 2020 15:25:13 -0700
Message-ID: <CA+dzEBnpheB-ZT5+bajKphux-+7gYFx1Msws7mXM=LOJO7pukw@mail.gmail.com>
Subject: git git<tab> completes non-existent command `git gitk`
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

easiest to reproduce is with docker

```dockerfile
FROM ubuntu:focal
RUN : \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y
--no-install-recommends \
        bash-completion \
        git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
```

```console
$ docker run --rm -ti test bash
root@23e691ecc7ba:/# [ -f /etc/bash_completion ] && . /etc/bash_completion
root@23e691ecc7ba:/# git gitk
```

(I typed git git<tab>)

```console
$ git gitk
git: 'gitk' is not a git command. See 'git --help'.
```

this is a bit annoying because I have some aliases/commands for git-github-*

the git version I have is 2.25.1:

```console
$ git --version
git version 2.25.1
```

Anthony
