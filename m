Return-Path: <SRS0=FHek=5A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A685C5ACBF
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 01:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF55B2076A
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 01:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RSVJOmw6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgCOBdd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Mar 2020 21:33:33 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38287 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbgCOBdd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Mar 2020 21:33:33 -0400
Received: by mail-wr1-f67.google.com with SMTP id x11so12125856wrv.5
        for <git@vger.kernel.org>; Sat, 14 Mar 2020 18:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=dEJmTBa2hfJ1n9nK6VBMXyLzxhk/qzIjTHDJ10tJJsg=;
        b=RSVJOmw60e/F/zW9xjxEN7FdiokLpahYxqNarpWn6E2ooZO6Do9BIhXqjqthtaJam8
         /XxT9BJ1bgp3PUPmpx1PzubmasS7m32CE6xDzfui7c5GCAaRdfjct8Tw8Wqoi3YgG/is
         TQ7hGlXNTQg3cihlXXdZjBt1cV5aW5T1Ea9F2e+aHwjFXaIPecaBH26ogf7pecYcDd3o
         cy5htKhq6ohX/vdAXfevI9M76jFjdIfaZIAVd+O2RuIcOhsyfs9Gn1K7NoSYQAu4mHNb
         00k47mpvpWaKCLKj0ZR6rwzfWIC1T+9Ozrf/Ni7iUcpN0EkUWJ1f151o8b84V/+HrhYq
         yvNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dEJmTBa2hfJ1n9nK6VBMXyLzxhk/qzIjTHDJ10tJJsg=;
        b=bElKyv3adSy91/1pCQQygrGoNPMjkhnqQpZN7vmhLEYDZeXMs917z4LPq+Mg2W/XOP
         Ru3rrsrLVHnCiVkpS9GCZc+BnEtMPgLdSqOnAqUr3+Klc9TIoN1nupFC+sitB4vj4lAv
         8mzDSgCFaKrmoltIZcl6RxBvchnt8esD9Ou1lF1oPnTlG+caMWRRHEp8UM2hbSbiDbb7
         06X3LFIiZOYD5sVVy7uDzGEFWJ3v4+O1NAMXquh5i6O23NTjjopt8/nQZ+deanQx1kpF
         lzY3jXPTAs7OiB4fB1Yd8zj0RsasMqvIHChEWzE9ik3A5TIp2BQPNHNYQJMRV67bwOXr
         ieJg==
X-Gm-Message-State: ANhLgQ0ETVFFGx6lSx3zaDaWfjdjIBvA295rRLpEsWJzDUNWUdOeRUyD
        WAOkFX+xRAvlLWDgfoPcgEgjDerA
X-Google-Smtp-Source: ADFU+vvrgPN4lr/zPyIs8CzayE0cTEyqO0QvYmZvWslG3Nu+6nN1FfT6B11gTlwWAU407w6rb0Ac4w==
X-Received: by 2002:a50:951e:: with SMTP id u30mr16876910eda.144.1584169894789;
        Sat, 14 Mar 2020 00:11:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h3sm220288ejy.82.2020.03.14.00.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2020 00:11:34 -0700 (PDT)
Message-Id: <pull.726.git.git.1584169893.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 14 Mar 2020 07:11:26 +0000
Subject: [PATCH 0/7] Sparse checkout improvements -- improved sparsity updating
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series provides a replacement for the git read-tree -mu HEAD-based
sparsity updating used by sparse-checkout, fixing the myriad problems it
causes. The most important bit is patch 5 and its lengthy commit message
explaining the current state and rationale.

Consider the series RFC for now; I probably need to add some tests, get some
people at work who are willing to test it in real cases, and get some
community feedback particularly on the choices/comments highlighted in the
commit message to patch 5. But it's at least basically functional so I
wanted to send it out to the community for feedback.

Elijah Newren (7):
  unpack-trees: fix minor typo in comment
  t1091: make some tests a little more defensive against failures
  unpack-trees: allow check_updates() to work on a different index
  unpack-trees: do not mark a dirty path with SKIP_WORKTREE
  unpack-trees: add a new update_sparsity() function
  sparse-checkout: use new update_sparsity() function
  sparse-checkout: provide a new update subcommand

 Documentation/git-sparse-checkout.txt |  10 +++
 builtin/sparse-checkout.c             |  49 ++++-------
 t/t1091-sparse-checkout-builtin.sh    |  34 ++++++--
 unpack-trees.c                        | 119 ++++++++++++++++++++++++--
 unpack-trees.h                        |   2 +
 5 files changed, 169 insertions(+), 45 deletions(-)


base-commit: 30e9940356dc67959877f4b2417da33ebdefbb79
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-726%2Fnewren%2Fsparse-checkout-improvements-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-726/newren/sparse-checkout-improvements-v1
Pull-Request: https://github.com/git/git/pull/726
-- 
gitgitgadget
