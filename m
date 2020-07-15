Return-Path: <SRS0=3l3d=A2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F7AC433E1
	for <git@archiver.kernel.org>; Wed, 15 Jul 2020 09:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8F9A20672
	for <git@archiver.kernel.org>; Wed, 15 Jul 2020 09:10:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nemit-fi.20150623.gappssmtp.com header.i=@nemit-fi.20150623.gappssmtp.com header.b="S5GGOmvg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbgGOJKe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jul 2020 05:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728206AbgGOJKd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jul 2020 05:10:33 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5FBC061755
        for <git@vger.kernel.org>; Wed, 15 Jul 2020 02:10:33 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id o3so1320403ilo.12
        for <git@vger.kernel.org>; Wed, 15 Jul 2020 02:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nemit-fi.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=5VA7NsHLBMLrvGe3mYzli62aQnY9bufOA7gnJJqwcpM=;
        b=S5GGOmvgNbwphoJwrsnxWVE7aivGtMdSOAUIQ3YcWmKQPMSBC4V32KdTHYUZasxTXN
         tYU2MxfuXm1Rx2myOgIUkMpz60GzW2dAn12ugacjeo3VsdexURJH39weZEfd2gLIfvUR
         rmMAhXrJnyLq8jEeQ1TxJERFLZNaCbz6Ts/p5Uo15k9ZzuZNpj4eWPN7ZBXYQLEyQP76
         1PBgQBz2T3WqtBLweWJauI4SQGrSoUSZQV/iW7XggiWjegYnY73nIm7I0qnZ4wBqqYpD
         sWOjkfjv9Jgk7YJ5hL1LxNQkWTY75kjY8zULxcn8rq/qjG/zCFeBBReqQlxPL7vDxdWQ
         1y3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=5VA7NsHLBMLrvGe3mYzli62aQnY9bufOA7gnJJqwcpM=;
        b=Ctc8NfmqLz5vPwOHwVGseczge0EWjxwdyNRn6F1x13oLgizgnUVuYtQQtFMo3Bay+e
         CUFvhqSh2yoJsEj6OnxqIMRFtKxjhK6kE+qwgzbA0z4gTg5pVNLxr+fHmV3w8Sm6iRBY
         W8KZHZflHiCPDijS54KEBHWZgL3nAOgk6COTScvycRbaloJydLX/GA7wdphuQC2au9Hl
         8OGZg4XgHl7ZP9w08yHFd+mMWgpNkuon2krUSzEs+dMC4O3YeH8KFWrtO5JqKcaQOyJp
         5CeVCtg1HnJ5f7/UkzCcufAwzCJXodWtDPos+5KaPsrZd57N7JvZ/IId2/3c0zGRk8Eq
         qGqQ==
X-Gm-Message-State: AOAM532lyvJE/Aw0WgqyysyoGE8hzC9wDxd5081gA2wpYPU9dQyj3Fn3
        9Mf1HVSvh0TsC69C9JjEzTBka7ftR7lbHMvD7rrH/qNwmcs=
X-Google-Smtp-Source: ABdhPJwnZqFONIPYDHdk9P1ig+4Sm8kpUPpgzNRpR0jkx/JOTlzSZ1V3JAu34cpNMnCBJJkntciQjZKGKQahRsQl2bE=
X-Received: by 2002:a92:c78d:: with SMTP id c13mr9050254ilk.85.1594804232159;
 Wed, 15 Jul 2020 02:10:32 -0700 (PDT)
MIME-Version: 1.0
From:   Frej Bjon <frej.bjon@nemit.fi>
Date:   Wed, 15 Jul 2020 12:10:21 +0300
Message-ID: <CAP8P1T+JQUTVDXsJbrWkiZ2AWZmoptFSRdKssANYrNSFa+Egmg@mail.gmail.com>
Subject: Cannot delete remote branch with non-ascii name and --force-with-lease
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

What did you do before the bug happened? (Steps to reproduce your issue)
- Create a branch with non-ascii character: testbranch-=C3=A4
- Push to a remote with same name
- Delete branch from remote with --force-with-lease:
  git --force-with-lease --delete origin "testbranch-=C3=A4"

What did you expect to happen? (Expected behavior)
- The branch to be deleted.

What happened instead? (Actual behavior)
- Git fails with an error
  error: cannot parse expected object name
'32e33fb544d7b1147c446c60220f23a5df465eff"'

Anything else you want to add:
- The command works if using only --force and not --force-with-lease
- The command works if there's no non-ascii character, e.g. "testbranch-x"
- Tested with gitlab and github as remotes, with the same error
- My locale in git bash is "en_US.UTF-8"
- The same happens under Ubuntu 20.04 with git 2.25.1


[System Info]
git version: git version 2.27.0.windows.1
cpu: x86_64
built from commit: 907ab1011dce9112700498e034b974ba60f8b407
sizeof-long: 4
sizeof-size_t: 8
uname: Windows 10.0 15063
compiler info: gnuc: 10.1
libc info: no libc information available


[Enabled Hooks]
None

Regards,
Frej Bjon
