Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 563EFC433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 451D861242
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:22:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348288AbhIUCXH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 22:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241410AbhIUCBt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 22:01:49 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494A0C034038
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 11:10:51 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 97-20020a9d006a000000b00545420bff9eso17842849ota.8
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 11:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=RvFOHGk8eGAGr9BuWl7tRemnL7rpV12W2IsAQMuSVPI=;
        b=CgDqxarDVL/AMkRNH1iDmPLlv7uC8NQXva0ucK9nTt/md4sft3lQAyNdCWfZLtP8Qa
         uM+IgeiKqrJvpyovAg0/aJHtxydDZ6+CTXshz7xjEsyq37VUZid5E73l2W42SBajrNtT
         +v1ngUbRe81A6zqtvnierHPatuVGWXibUn9rPw8T4kODEB2nK/QAfOgvgn29m/kTHG32
         1OxE741E+h3nGtFyMvRMBEH+5SPq5+hb1mDWLgYmVKnauZT4xdp4iN0DvAYPTuTUHjBn
         FmDD1QzHThrWUbrUnwCdFqa0csHlNLirYRcLoOh1OT08rv7wj1brinb8QwR+tihNob0i
         Jsow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=RvFOHGk8eGAGr9BuWl7tRemnL7rpV12W2IsAQMuSVPI=;
        b=4tTNawbKf1W2glZ7stjHHOp/QajM59J2Id0K26Qln1uMb4uL2sDCRrxuOGpQYCG9sG
         gmSl0j0ULf0jbDxgvsSgKIM133bmtUhROEzzJpjM1JK2jlQWRbJroK2ZWI1djSpbVINW
         Km3Btgtq0dk+7EGzGLVZ2O7MYBRLxh5Ic3Qfhtq5a85UU5hSi/ct3l0x3IdZnrj/3PNn
         DvehPXYUXSDxRZxbOToLKNw09gpk5jMrevkO2BsxfhmR7qlcaW1CpFQNH/EROxZ/Wchq
         jybUXjwYty185/6hFZcxfM4agrQzsS4A9eCsEv8ttFBfuFEgofkWhzP7t4uRXjB0Taz8
         gSAw==
X-Gm-Message-State: AOAM531qYd6r+io4uhG79r2PwC8zlyvc0o9qJehBQC40LCPw9cldj6T3
        I23vHSDWyiRxoxPNaMaPa1gAPUwIrP1BoS2VPafQG+KP/7o=
X-Google-Smtp-Source: ABdhPJzBzgKU42mRPdbGA5+d8gaknfCewvL+AjyhM1ExzNo3SjhJFQgtXEOAaDfwu4p44r2EXQ6k8OpWX8E+uby/wyU=
X-Received: by 2002:a9d:490f:: with SMTP id e15mr22038219otf.340.1632161450134;
 Mon, 20 Sep 2021 11:10:50 -0700 (PDT)
MIME-Version: 1.0
From:   Sergii Shmarkatiuk <sergii.shmarkatiuk@gmail.com>
Date:   Mon, 20 Sep 2021 21:10:39 +0300
Message-ID: <CADzhcq7uoSji_PwTDU1zkgB-xWDSn5mQ+55+3JX_wkOr2s7H9w@mail.gmail.com>
Subject: Git submodule lists reference to a different tag than specified when
 checking out tag for submodule
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi! I want to report an unexpected behavior of the latest version of
git that I faced today.

> What did you do before the bug happened? (Steps to reproduce your issue)

I have initialized two tags Dev/0.x.0 and User/0.x.0 in a repository
that is referenced as a submodule in another repository. Both tags
refer to the latest commit. First I created Dev/0.x.0, then
User/0.x.0:

cd ~/projects/repo1
git tag Dev/0.x.0
git tag User/0.x.0
git push --tags

cd ~/projects/repo2
git submodule add https://path-to-repo1/repo1.git
cd repo1
git checkout User/0.x.0
cd ..
git add repo1
git commit -m "moved repo1 to the tag User/0.x.0"
git push

> What did you expect to happen? (Expected behavior)

After performing all the steps above I expected the output of the 'git
submodule' command to look as follows:
git submodule
 c575d777d33a0f1095875c7b55753eb59a51daba repo1 (User/0.x.0)

> What happened instead? (Actual behavior)

Instead, output looks as follows:

git submodule
 c575d777d33a0f1095875c7b55753eb59a51daba repo1 (Dev/0.x.0)

> What's different between what you expected and what actually happened?

Submodule references different tag than specified in the checkout
command (Dev/0.x.0 instead of User/0.x.0)

[System Info]
git version:
git version 2.33.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.11.0-34-generic #36~20.04.1-Ubuntu SMP Fri Aug 27
08:06:32 UTC 2021 x86_64
compiler info: gnuc: 9.3
libc info: glibc: 2.31
$SHELL (typically, interactive shell): /bin/bash
