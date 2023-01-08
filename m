Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA0BAC53210
	for <git@archiver.kernel.org>; Sun,  8 Jan 2023 09:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbjAHJ6x (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Jan 2023 04:58:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233035AbjAHJ6s (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jan 2023 04:58:48 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A28B4B5
        for <git@vger.kernel.org>; Sun,  8 Jan 2023 01:58:47 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id j7so325839wrn.9
        for <git@vger.kernel.org>; Sun, 08 Jan 2023 01:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9jpiAshJMwawFQWlAcjvAUPgfrSFdTV/qUt4xh4RNVc=;
        b=N/AXEiO4FQ/S06FObhUQVD+hqAafWIpN/QQ1HENP3Mg1YgMzq8TRShCk9hPXcJYEsl
         oYmYtoPsxlpIAucaSDCCNgMe526PrhV+pbq2jf3gNk+fTQPtfobUuv+sWe2j667kuz5r
         U4A2xKu/Q8GPfJ8EJ0voYebTXP21dgO8PcBxeXcm0jGYpwitESpGg0RXbaEPXVag7l9R
         3ervemvPwkyl5gi9HPm8GCQHTHwbLCNPquoN4AjFdVrPkXqVtOOSFj5SPmizHRqAl1yX
         CKKQJgnhrsEV0J4gNeXcwps517GFp4yfiQ4+Om8wIcqWz5NkW9TnKE31kyopl0LKDjpf
         91Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9jpiAshJMwawFQWlAcjvAUPgfrSFdTV/qUt4xh4RNVc=;
        b=B5Ti+RLh2R1ZO14CnGf4w6dpoRXUsAEwxc5LrTo9BumNhWUg7GJrort4rVpXnzalDZ
         AHlt2HPirb5dloBK9+mV9+YL779GwbxQwyPiT9oRWSeofOUNBf2RIZISMkDT6mRwMAtt
         KdlZpeELqkWsRCLaFoWSbBtQ0C/wuBiUOby9fpDKalROqGR9S6x1BOP39++n3GAnZjpC
         Fvwr2whjthFw3y4WjH/bvg5HD7oXPozm841uWXQYtvmjKTf7oJttwD0eJcP3yZPESLqE
         wGvqa0t8C43p36373F2yoO4eXPt7GAalPe0nd/NdSECxcGEqoqgHC7DaoG3nZWindXd4
         X8sQ==
X-Gm-Message-State: AFqh2kpoQVWlWSve3NyFUdGL3ikgk1lBMMCBluUPJfHHt3+pmgEV59Vt
        vyn+qeRwUA2VUFDw6Gw4PPuNkwB6bwY=
X-Google-Smtp-Source: AMrXdXtvQ1DEWMs4lEkz8i7khKX/YgtFoK6pfmN3KHU8sHS1zBHTZAxc+LSirSurZ8AxwUYZNF0E9Q==
X-Received: by 2002:adf:a2d1:0:b0:2bb:e7ef:ed8a with SMTP id t17-20020adfa2d1000000b002bbe7efed8amr1437271wra.50.1673171925793;
        Sun, 08 Jan 2023 01:58:45 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l8-20020a5d6688000000b0029e1aa67fd2sm5637463wru.115.2023.01.08.01.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 01:58:45 -0800 (PST)
Message-Id: <pull.1457.git.1673171924727.gitgitgadget@gmail.com>
From:   "Eric Sunshine via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 08 Jan 2023 09:58:44 +0000
Subject: [PATCH] githooks: discuss Git operations in foreign repositories
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Preston Tunnell Wilson <prestontunnellwilson@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Eric Sunshine <sunshine@sunshineco.com>

Hook authors are periodically caught off-guard by difficult-to-diagnose
errors when their hook invokes Git commands in a repository other than
the local one. In particular, Git environment variables, such as GIT_DIR
and GIT_WORK_TREE, which reference the local repository cause the Git
commands to operate on the local repository rather than on the
repository which the author intended. This is true whether the
environment variables have been set manually by the user or
automatically by Git itself. The same problem crops up when a hook
invokes Git commands in a different worktree of the same repository, as
well.

Recommended best-practice[1,2,3,4,5,6] for avoiding this problem is for
the hook to ensure that Git variables are unset before invoking Git
commands in foreign repositories or other worktrees:

    unset $(git rev-parse --local-env-vars)

However, this advice is not documented anywhere. Rectify this
shortcoming by mentioning it in githooks.txt documentation.

[1]: https://lore.kernel.org/git/YFuHd1MMlJAvtdzb@coredump.intra.peff.net/
[2]: https://lore.kernel.org/git/20200228190218.GC1408759@coredump.intra.peff.net/
[3]: https://lore.kernel.org/git/20190516221702.GA11784@sigill.intra.peff.net/
[4]: https://lore.kernel.org/git/20190422162127.GC9680@sigill.intra.peff.net/
[5]: https://lore.kernel.org/git/20180716183942.GB22298@sigill.intra.peff.net/
[6]: https://lore.kernel.org/git/20150203163235.GA9325@peff.net/

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
    githooks: discuss Git operations in foreign repositories

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1457%2Fsunshineco%2Fhookenv-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1457/sunshineco/hookenv-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1457

 Documentation/githooks.txt | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index a16e62bc8c8..6e9a5420b7c 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -31,6 +31,17 @@ Hooks can get their arguments via the environment, command-line
 arguments, and stdin. See the documentation for each hook below for
 details.
 
+If your hook needs to invoke Git commands in a foreign repository or in a
+different working tree of the same repository, then it should clear local Git
+environment variables, such as `GIT_DIR`, `GIT_WORK_TREE`, etc., which could
+interfere with Git operations in the foreign repository since those variables
+will be referencing the local repository and working tree. For example:
+
+------------
+local_desc=$(git describe)
+foreign_desc=$(unset $(git rev-parse --local-env-vars); git -C ../foreign-repo describe)
+------------
+
 `git init` may copy hooks to the new repository, depending on its
 configuration. See the "TEMPLATE DIRECTORY" section in
 linkgit:git-init[1] for details. When the rest of this document refers

base-commit: a38d39a4c50d1275833aba54c4dbdfce9e2e9ca1
-- 
gitgitgadget
