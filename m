Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E607E1F4C0
	for <e@80x24.org>; Tue, 22 Oct 2019 23:30:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389693AbfJVXaZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 19:30:25 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43927 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731847AbfJVXaZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 19:30:25 -0400
Received: by mail-wr1-f65.google.com with SMTP id c2so14666891wrr.10
        for <git@vger.kernel.org>; Tue, 22 Oct 2019 16:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=NYkEtQMGzQaGImc7m/LN9UFBvEXl0auGDuAlwDWwUQg=;
        b=WcpHLHxL+N05jD3OPj2YtYlsoHM8mXlvVy+9ejq4b6F8BsP2EvZCaPBkAAR0fJ9F+6
         o+0RghGGPma0wZKNcmqr8RCPa5uEQHyOSnYK/YS2cVZfi8Lyf2mVMcyBmle/X5fvqX8S
         X8FE3sKGm9Aro3QxhnBMHsCXeQ/z5S3GPm5k6LTZjBkQ77tJomsp17Euv5gQTqzMDNXr
         p4w/CFfwkFcNwv2/RCiPO9VqzKY4raN5lJOxP0Yk+LYcnc91Pp8wo10nRuF3STjAHPd3
         /Hew84tXwGdUhQUp09jPxxLoC5TW6XMNNvDkVwVADXfwIJjvv8wdZKfxqYAZiQ2Sb8Sd
         Lk4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NYkEtQMGzQaGImc7m/LN9UFBvEXl0auGDuAlwDWwUQg=;
        b=RJs1yPrP/sEY93SCDc9ZBCLG1HzSN6WWjXko2vFje9wKxqoQV1aM8Qkn0tEk0VF3g/
         +D51iFNqU0RBZ6oDhDRJG0m7bdxjj7+/90jz2QkEUiF3AGiHwt0vgiGHir4STkXHYeQG
         ueduu7BWYDB3I6uSG4bIRfawETLYjPNnjFwGrpKwfz44DxdO83mj6Q+0x84kCAlV3N6l
         kn2fvgJpm7/6RtXqBhMz9EoAHEE7N/J9q69pMuZbQRJwIJ0vDqk8oaI7KpMw8OQHKt+g
         962Qs3XtFuR+88ThaGTuR+OCnOCWl4yIxUxtCJOBNoYFmRz5KbHz3PuuYHulZkjAWPLX
         8UaQ==
X-Gm-Message-State: APjAAAUOpXBpyjnWn0h5TZYCjsxxKw4XhlGn/Mmf+bogAyBRh7j5dmp/
        /0kUpNezC/7wwzVvVI62hXJXAK8A
X-Google-Smtp-Source: APXvYqzKjhO6rOO9m1HMfMYqN7W9N0ngdQJk7yZiedXSUn2K3lVGdjciSndCugpWkTInL01KOBNIag==
X-Received: by 2002:adf:d1aa:: with SMTP id w10mr5311503wrc.127.1571787023554;
        Tue, 22 Oct 2019 16:30:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v16sm19034927wrt.12.2019.10.22.16.30.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Oct 2019 16:30:23 -0700 (PDT)
Message-Id: <pull.417.git.1571787022.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Oct 2019 23:30:19 +0000
Subject: [PATCH 0/3] commit: fix advice for empty commits during rebases
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In dcb500dc16c (cherry-pick/revert: advise using --skip, 2019-07-02), we
introduced a helpful message that suggests to run git cherry-pick --skip 
(instead of the previous message that talked about git reset) when a
cherry-pick failed due to an empty patch.

However, the same message is displayed during a rebase, when the patch
to-be-committed is empty. In this case, git reset would also have worked,
but git cherry-pick --skip does not work. This is a regression introduced in
this cycle.

Let's be more careful here.

Johannes Schindelin (3):
  cherry-pick: add test for `--skip` advice in `git commit`
  sequencer: export the function to get the path of `.git/rebase-merge/`
  commit: give correct advice for empty commit during a rebase

 builtin/commit.c                | 33 ++++++++++++++++++++++++---------
 sequencer.c                     |  4 ++--
 sequencer.h                     |  1 +
 t/t3403-rebase-skip.sh          |  9 +++++++++
 t/t3510-cherry-pick-sequence.sh |  3 ++-
 5 files changed, 38 insertions(+), 12 deletions(-)


base-commit: d966095db01190a2196e31195ea6fa0c722aa732
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-417%2Fdscho%2Ffix-commit-advice-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-417/dscho/fix-commit-advice-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/417
-- 
gitgitgadget
