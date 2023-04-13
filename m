Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B98C77B6C
	for <git@archiver.kernel.org>; Thu, 13 Apr 2023 10:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbjDMKfu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Apr 2023 06:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjDMKft (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2023 06:35:49 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB56030C7
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 03:35:47 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id w15-20020a056830410f00b006a386a0568dso14252980ott.4
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 03:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681382147; x=1683974147;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/2iFfS+9i1OQjUmufFes7e8oeza6lMb63CtV0QQNuMo=;
        b=YchwoBkqZCyptk1fLPNjlLzSIZxbfT9M37V/f4r3efcyihD9rdUJXK0iTIxXh5/6xd
         n4VgUvAQqZ2kKMIW5frQnZsmldL8vcOdkT/1yRpvQLQx4Xrfvrg9b/OyJt4fWNDCy5R4
         zP+deCSQ1KwdIF7Amwa/tWGZR4flSzZRH1IOdYW9VlQCQrI6ylF2Tcm//Ih2Xkalm2j3
         qBhvBvWZR2jM6ZV3ixmMdhvSHqcJSALDaqfZjuBmJs6yyslRrQzIHVa9S6JdibvYcE8/
         uOOgNzdUebZMf+jJxNlqUVYfLyR2McG4ypF+9GkxNZhbwWNrvhBDbwvzUdMWOYeXhAsM
         ww3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681382147; x=1683974147;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/2iFfS+9i1OQjUmufFes7e8oeza6lMb63CtV0QQNuMo=;
        b=Hjuk+JgnEk8Vj+SN3dTzFZDsD0g31+wnQdHZNm9TQXjoQ5tPjTjvBVcMXRDhdcAZyO
         npJoc/xHP1PZBmwtO+kNt2QLry5rnKofAAJkBH0z12ea5LV0xbS/nE1HAtuVvY3s88y0
         38crheaNngROiMgE2mZP7gwblEyaofnZiUQUQd9+1ZCacrbSFzf1CZsSrfoK2IuQDgDE
         Ph++xGdYYE/rTqKpViatLKi+PDp39CPJjY4H94c5HAQR7tNfdHFU+frY5fNRIdYWrM50
         gJ0IPD7P4LhoCIpo9QEVnb56L2ZVJ2QI6ycHgLxsH3ngqEmD3QHrr3Ex7aBfTTxm2zgb
         mkEw==
X-Gm-Message-State: AAQBX9eVzGAm4P8pJjpHQXr+54y32v0IkjRchSOu9xnP8nngW0iPjkGz
        3BIKwH/AlcNX/E5Q+pbIgMamUME1ZC29CR526FQ7Afg25wAIxQ==
X-Google-Smtp-Source: AKy350ZaeR5XuV9w3307IEnofuoa0M++Y2YXEocKSCaQD8+NOna8Sm+76k9ZrfaewU95qZA/EqkbvtfxrjTNK904Ylc=
X-Received: by 2002:a05:6830:a:b0:6a3:e43a:c707 with SMTP id
 c10-20020a056830000a00b006a3e43ac707mr430602otp.7.1681382146968; Thu, 13 Apr
 2023 03:35:46 -0700 (PDT)
MIME-Version: 1.0
From:   Ilya Kamenshchikov <ikamenshchikov@gmail.com>
Date:   Thu, 13 Apr 2023 12:35:36 +0200
Message-ID: <CAAp-DqK=CPxpH0ZhA=k8GRFvSz3odoOLhOgAqfYSBpz28JK+hg@mail.gmail.com>
Subject: Git branch capitalisation bug?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

What did you do before the bug happened? (Steps to reproduce your issue)
Created a branch "feature/macos_tests", pushed to remote as
"origin/feature/macos_tests".

What did you expect to happen? (Expected behavior)
remote branch "feature/macos_tests" to be created.

What happened instead? (Actual behavior)
remote branch name is "Feature/macos_tests" (capitalised). This
doesn't play nicely with not case sensitive macos FS.



[System Info]
git version:
git version 2.40.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Darwin 21.6.0 Darwin Kernel Version 21.6.0: Mon Dec 19 20:44:01
PST 2022; root:xnu-8020.240.18~2/RELEASE_X86_64 x86_64
compiler info: clang: 14.0.0 (clang-1400.0.29.202)
libc info: no libc information available
$SHELL (typically, interactive shell): /usr/local/bin/fish


[Enabled Hooks]
pre-push
(remark: reproduced also when uninstalling this hook)

Raw output:

~ $ cd bosch/rlcore                                       (base) 12:11:42
~/b/rlcore (feature/macos_tests|=E2=9C=9A2) $ git push            (base) 12=
:11:49
fatal: The current branch feature/macos_tests has no upstream branch.
To push the current branch and set the remote as upstream, use

    git push --set-upstream origin feature/macos_tests

To have this happen automatically for branches without a tracking
upstream, see 'push.autoSetupRemote' in 'git help config'.

~/b/rlcore (feature/macos_tests|=E2=9C=9A2) [128] $ git push --set-upstream
origin feature/macos_tests
Total 0 (delta 0), reused 0 (delta 0), pack-reused 0
Thank you for filling out a Git bug report!
remote:
remote: Create a pull request for 'feature/macos_tests' on GitHub by visiti=
ng:
remote:      https://github.boschdevcloud.com/CR/rlcore/pull/new/feature/ma=
cos_tests
remote:
To https://github.boschdevcloud.com/CR/rlcore.git
 * [new branch]        feature/macos_tests -> feature/macos_tests
branch 'feature/macos_tests' set up to track 'origin/feature/macos_tests'.
~/b/rlcore (feature/macos_tests|=E2=9C=9A2) $ gl                  (base) 12=
:16:10
c001bc75 2023-04-13 | commit message (#514) (HEAD ->
feature/macos_tests, origin/main, origin/git_problems, origin/HEAD,
origin/Feature/macos_tests) [Rich..]

Best Regards,
--
Ilya Kamen
