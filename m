Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8685FC433EF
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 04:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A7AD60FD8
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 04:54:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbhJEEzt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Oct 2021 00:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbhJEEzs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Oct 2021 00:55:48 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D421AC061745
        for <git@vger.kernel.org>; Mon,  4 Oct 2021 21:53:58 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id h9-20020a9d2f09000000b005453f95356cso24403476otb.11
        for <git@vger.kernel.org>; Mon, 04 Oct 2021 21:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=wlFG8x+rJ+50IaN9pexqXr8ju5B/OJZknjMIvj+2F4A=;
        b=b75MRfrOr7Z+09Yx7Bns06FyZuWJR+F1laKW1mdosiNB4yBYEL5bz0LU2TaF+ahoBK
         t/uYOl/eivs32pnXXfBtfXVvgXyqFBKG2rC84qY8tP2o1cnVbSPJ+mkVoqODHXiG+cnj
         3crEEMy6QkNIYSfiHwxgUW5C/5RZOzxYgx7HpCwnS1c7E+z4ON6IAb+W4mQMfDdDIrDD
         ppZNVDpoVhOOjFNJGvlJ/wkqpXl4rNZSJB6zmJMQwftxgg7OcdP9MnIJMIUBXYu0rIBk
         Pg0006Lv2jsYYCvtMHrFMr6v3X9M6yJejgW01bMlc+fzujtPHID/kIGaU7QST2tQTWFb
         B4RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=wlFG8x+rJ+50IaN9pexqXr8ju5B/OJZknjMIvj+2F4A=;
        b=t3rnl8uRe8F8ZxdfiL1CqEuazIDXwOoKvR2ORC0jM4EpIda5GY954G14+TktwGJRmo
         qnTi+V5mVZuVrn9MajoYRKZlWMBY8eJrNS/xgVQKByW3vR3LtmMdikSwGthuwXBQVGAa
         fWQM0uKmMfe6N0Su5EFfVo0jY0/R+h/tUPhMg9Xr+G+22PjkcQKd7rL/yK7z/nuEM+/w
         61rhUM1X0iPoinXp1tGBnFCGWODxFfLj4Sz3ztUY0g8bK5EhbMb0qX3Gkfr60QZymrbL
         RUM5zIkpkOS2PAaowfDQCOEgj5REr4uJiBDULQaU+cPZKlzXjdRGtjaofcFBFcHF7XJs
         KaFA==
X-Gm-Message-State: AOAM5309XdHnR8FbDLLMu6PufXJEwjESwa6AXJHwX9iwHeeoyfzxeWNY
        SrEo1FTNHXRf1ckRiQsAg7fQjTRP3M6sRL4t7Dn2vHd+6QQ=
X-Google-Smtp-Source: ABdhPJyIBx9gcFInQ+XEYnB4kXKyhzU4JTWfpkHg2sBv8+u8Z/1OrVFrz2+fTWGZQlGWE4ZBcjQjX18Rd+BEWLYLhd0=
X-Received: by 2002:a05:6830:18d0:: with SMTP id v16mr12467581ote.177.1633409637988;
 Mon, 04 Oct 2021 21:53:57 -0700 (PDT)
MIME-Version: 1.0
From:   Eddie Ridwan <eddie.ridwan@gmail.com>
Date:   Tue, 5 Oct 2021 15:53:47 +1100
Message-ID: <CANcBuaZstymNMvbPX553kgr=FsrFFcDEivfiDPsPe3uyGLb78g@mail.gmail.com>
Subject: Git push subtree fail unknown revision or path possibly due to
 missing git-subtree-split commit
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
git pull/push subtree as normal, although it is possible that one of
the contributors to the subtree repo may have done a force push.

What did you expect to happen? (Expected behavior)
git push subtree to update the remote subtree repo.

What happened instead? (Actual behavior)
Failed to update the remote subtree repo. Error message:

       fatal: ambiguous argument
'3f44cc87ceb87df1d9171096596a824fc3050a27^{commit}': unknown revision
or path not in the working tree.
    Use '--' to separate paths from revisions, like this:
    'git <command> [<revision>...] -- [<file>...]'
    could not rev-parse split hash
3f44cc87ceb87df1d9171096596a824fc3050a27 from commit
8577911bf6183497cc246aa620e7be1b6becec29

What's different between what you expected and what actually happened?

Failed to update the subtree repo, as expected;

Anything else you want to add:

I am not able to find the commit/hash
3f44cc87ceb87df1d9171096596a824fc3050a27 in the repo. In gitx, I can
see that the commit is a git-subtree-split. But it appears to no
longer exist in the repo.

How can I bypass or recover from this apparent missing commit? Any
help would be greatly appreciated.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.33.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Darwin 19.6.0 Darwin Kernel Version 19.6.0: Tue Jun 22 19:49:55
PDT 2021; root:xnu-6153.141.35~1/RELEASE_X86_64 x86_64
compiler info: clang: 12.0.0 (clang-1200.0.32.29)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]
