Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BDFB208B8
	for <e@80x24.org>; Tue, 15 Aug 2017 14:26:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751744AbdHOO0l (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 10:26:41 -0400
Received: from mail-ua0-f177.google.com ([209.85.217.177]:35131 "EHLO
        mail-ua0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751031AbdHOO0k (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 10:26:40 -0400
Received: by mail-ua0-f177.google.com with SMTP id d29so3489006uai.2
        for <git@vger.kernel.org>; Tue, 15 Aug 2017 07:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=8sfRKKzEK1/mNvQEzg0XRdAkhoX45UwX9nGMlEgor2g=;
        b=mo8NRnv3uMMHIfw+wx5+kOYvG5KYu+/s3nO+p2kF6sGTqJrI+9IDifPbmnKK0RIC1i
         shFg7BqexQu7mKrkKuTGfT5QTCW/W7tMGRoiLFG7i7xth1UFMaigTgtQWbewX5bEpsW1
         JUyYOarrLUZGukXOuyYytO8CtndAU5z+VTCUuQMQGh9iBqNjVfOX3QrM1IyWQepz20nh
         6Dz9B1R98A8agJvd240dtx1PXGCnsAMvlIM3Uis1KYO1MftwIPAWP5gejyMDhrNPDZBg
         oU+icuAh3ib7YagOHBgrSCgjqABKGihqws26vJR/OkSwmHfHdPheq2jsFxSo59wB6Tc7
         Nqfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=8sfRKKzEK1/mNvQEzg0XRdAkhoX45UwX9nGMlEgor2g=;
        b=h6P8R448sf0LxMIr7mKbjOAMSGxCbNBDHpxv4K5o0xUOlO6siJ0Kr2WzHeETp3qIe2
         uaxLKF4h3tRdOnEdOjlaKIlbyE7azs652AqsjBj4K2csJGUJxM7pF3kiRTzd6QvSRcSB
         4K6alHNgkd/sTZuNivQ/j1fwr//iAeDe4EfAXiUYFIHK2yRNtWXRru4i6dQzIW+oTBn4
         VdNQo5/cAnUk44Oa4qllMQWeUkeKADP34q42uA6tt7iKQ4c62/kFMq6iSARm42bjhWsc
         2URy/FI2Gkw6YWiWtuLeEtmyLlP+RXHWQ6moHg1bwaPMiHo+iwYNf3t1pZibIpZiGPQV
         Wjug==
X-Gm-Message-State: AHYfb5gHLH5eh0QjlmMMN2zrOM3NBMBi4ui/+f+Asj0PMagciFAC/0uS
        +G5NNwnwDqPZL7TTwgoq5V7IpOdGOngZMh0=
X-Received: by 10.176.22.76 with SMTP id l12mr19393035uae.65.1502807199713;
 Tue, 15 Aug 2017 07:26:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.148.92 with HTTP; Tue, 15 Aug 2017 07:26:19 -0700 (PDT)
From:   Jason Karns <jason.karns@gmail.com>
Date:   Tue, 15 Aug 2017 10:26:19 -0400
Message-ID: <CAKNmmv3_K4gB6FbcmAjXyviMbU2Ts7Rh7txkOof+-36rF_1+Gw@mail.gmail.com>
Subject: Bug: `git remote show <remote>` reports different HEAD branch than refs/remotes/<remote>/HEAD
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have a git repo that shows a different branch in
`.git/refs/remotes/origin/HEAD` than is reported by `git remote show
origin`.

The branch is `github-rename` in refs/remotes/origin/HEAD, but shows
`master` in output of git-remote-show

```
$ cat .git/refs/remotes/origin/HEAD
ref: refs/remotes/origin/github-rename

$ git remote show origin
* remote origin
  Fetch URL: git@XXXX.git
  Push  URL: git@XXXX.git
  HEAD branch: master
  Remote branches:
    github-rename     tracked
    master            tracked
    qa                tracked
    refactor-test     tracked
  Local branches configured for 'git pull':
    github-rename merges with remote github-rename
    master        merges with remote master
  Local refs configured for 'git push':
    github-rename pushes to github-rename (up to date)
    master        pushes to master        (up to date)
```

git version 2.14.1


Background:

Prior to my repo being cloned, the default branch was configured to be
`some-random-branch` on github. My repo was cloned and the HEAD branch
was set to `some-random-branch` correctly (in `refs/`). However,
git-remote-show reported `master` as the HEAD branch.

Later, `some-random-branch` was deleted from the remote. It _remained_
as the HEAD branch locally according to `refs/`.

In order to test the remote-show command, I changed the HEAD branch to
a branch that actually existed by running `git remote set-head origin
github-rename`. It changed the HEAD branch in `refs/` but remote-show
continues to report `master` as the remote's HEAD.


Thanks,
Jason Karns
