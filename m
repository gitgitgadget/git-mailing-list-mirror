Return-Path: <SRS0=yMBz=Z4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A2EC43603
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 13:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B6E92075C
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 13:08:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fGUuxjuf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbfLFNI3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Dec 2019 08:08:29 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42942 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfLFNI3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Dec 2019 08:08:29 -0500
Received: by mail-wr1-f67.google.com with SMTP id a15so7663191wrf.9
        for <git@vger.kernel.org>; Fri, 06 Dec 2019 05:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=4m4KWrVVS3bAY1qtblxTKaEarB+FdIi8UGxMGzj21QE=;
        b=fGUuxjufbNqMlf9Bl1rQhYF80+DBa8uwZF82hqfcEHUOfY+alt+RdRQZh5TUPSG1Ta
         WGHiQZRIyvV6xNof+RQ3cO66UHW9JtLojuzq4rfwF3UoRT0w0HrbA/e3gaGiu9S1arGj
         uzRMhyrexsLZ0ou8BHRmks+s5JXgBeRxOsG7EkdYxwZ5fMAOdfaLy2AC4eFoV7HXeOYC
         TUfJxodtJyKOHUYkn+HidPJewyF+3zdsOzwLdq1fS56Y3HvQduXYfF+qjBGYd0HWE+ro
         bU0IfMadzY/rmcX/7jJ8yrEEFZK6dPlCyo1O9PdN0hf4Atj5eG0r1GyT3G6hES7g+4Tt
         7NaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4m4KWrVVS3bAY1qtblxTKaEarB+FdIi8UGxMGzj21QE=;
        b=RFlovsKBE1QbFC2NGsajWz98xIZ7eceD/GI5QzsM3q5iYGkG0HxeaKlwxuDzlcs3Da
         TxUMhMlp2pFS7wzRdQjp4ZJZYAxmz11u49PYCmKwfFFnE8CEAocVXlS3Sq1S3udWhmBc
         bJze+QHq521rKM5rIHG2VcygT1K9wzRl7diMssJ4tsLYBQ9cJnLFMC/WVNVGpB8BnqEh
         oU9D0gfeX7q3lsE6L8c1GEzbopSH8iTfB9B51W80HGHmpqKAWsYQrJd8wRe8aMZ1dRMn
         DVYZv0V89Q/r+e1vjpXoAqgVlh1LFe4384bAR+zuB6DXf0I0MZHwOTHbZZUbnkcQZfJv
         TLyg==
X-Gm-Message-State: APjAAAXkPo1UGJsoHVB/h3C+55sU6qFBPgR/XbRECu5cLuENnbDXfLjI
        hzIguD8JZRG8K3sNoojq2rHDfprz
X-Google-Smtp-Source: APXvYqym87xsTN0EfCNSm32JFMTCWY4OBSgpFVkBOMvGtD5wBbtJ/mdyG0meWEO1qaPZBgZ18fp1fA==
X-Received: by 2002:adf:eb48:: with SMTP id u8mr15163925wrn.283.1575637706836;
        Fri, 06 Dec 2019 05:08:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 60sm17250859wrn.86.2019.12.06.05.08.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Dec 2019 05:08:26 -0800 (PST)
Message-Id: <pull.172.git.1575637705.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 06 Dec 2019 13:08:18 +0000
Subject: [PATCH 0/7] add -i: close some regression test gaps
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While re-implementing git add -i and git add -p in C, I tried to make sure
that there is test coverage for all of the features I convert from Perl to
C, to give me some confidence in the correctness from running the test suite
both with GIT_TEST_ADD_I_USE_BUILTIN=true and with 
GIT_TEST_ADD_I_USE_BUILTIN=false.

However, I discovered that there are a couple of gaps. This patch series
intends to close them.

The first patch might actually not be considered a gap by some: it basically
removes the need for the TTY prerequisite in the git add -i tests to verify
that the output is colored all right. This change is rather crucial for me,
though: on Windows, where the conversion to a built-in shows the most
obvious benefits, there are no pseudo terminals (yet), therefore git.exe 
cannot work with them (even if the MSYS2 Perl interpreter used by Git for
Windows knows about some sort of pty emulation). And I really wanted to make
sure that the colors work on Windows, as I personally get a lot out of those
color cues.

The patch series ends by addressing two issues that are not exactly covering
testing gaps:

 * While adding a test case, I noticed that git add -p exited with success 
   when it could not even generate a diff. This is so obviously wrong that I
   had to fix it right away (I noticed, actually, because my in-progress
   built-in git add -p failed, and the Perl version did not), and I used the
   same test case to verify that this is fixed once and for all.
   
   
 * While working on covering those test gaps, I noticed a problem in an
   early version of the built-in version of git add -p where the git apply
   --allow-overlap mode failed to work properly, for little reason, and I
   fixed it real quick.
   
   It would seem that the --allow-overlap function is not only purposefully
   under-documented, but also purposefully under-tested, probably to
   discourage its use. I do not quite understand the aversion to that
   option, but I did not feel like I should put up a battle here, so I did
   not accompany this fix with a new test script.
   
   In the end, the built-in version of git add -p does not use the 
   --allow-overlap function at all, anyway. Which should make everybody a
   lot happier.

Johannes Schindelin (7):
  t3701: add a test for advanced split-hunk editing
  t3701: avoid depending on the TTY prerequisite
  t3701: add a test for the different `add -p` prompts
  t3701: verify the shown messages when nothing can be added
  t3701: verify that the diff.algorithm config setting is handled
  git add -p: use non-zero exit code when the diff generation failed
  apply --allow-overlap: fix a corner case

 apply.c                    | 10 +++++
 git-add--interactive.perl  |  8 ++--
 t/t3701-add-interactive.sh | 90 ++++++++++++++++++++++++++++++++++----
 3 files changed, 97 insertions(+), 11 deletions(-)


base-commit: 2e697ced9d647d6998d70f010d582ba8019fe3af
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-172%2Fdscho%2Fadd-i-fixes-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-172/dscho/add-i-fixes-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/172
-- 
gitgitgadget
