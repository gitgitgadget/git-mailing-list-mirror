Return-Path: <SRS0=o1/V=3D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B60C33C9E
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 19:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A50E24672
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 19:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QiD4rTcY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbgANT0F (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jan 2020 14:26:05 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37780 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbgANT0F (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jan 2020 14:26:05 -0500
Received: by mail-wm1-f66.google.com with SMTP id f129so15109195wmf.2
        for <git@vger.kernel.org>; Tue, 14 Jan 2020 11:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=lxYOga+uhZmhguJjXrXUd7MSSbDxwTv6AtZDFBtAETA=;
        b=QiD4rTcY6K1JEDJKZz1tApcv+VssbxR7Zx4jNGnuob7gX3xV2f0bJ03lJ5sF+WuyGB
         d3lSePdPh/h/xZLs2xnvbDHclz8hvMNNsJa66CwEEmuYd69WFxCUnViZDUdAYRZi/JkR
         QdWo4mTgqaiCdku/yEroGpXxppw/bTUpYPHg42pl56TC016J7Ph61jMVHhI4eLKwnErA
         6n9A3x2oY5K+YRIRbJ3YZ3qA65sSP9eQqfBzC0Ctt8e8Gir3yT7IUK3evduyPXvUD2pT
         MeTHSQCzzbLo/Z/LbhHgomr93nyVau5qvJ/+bMT8SRmOg+4FFWLNNxCGv1nscRvJfu1/
         o+Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lxYOga+uhZmhguJjXrXUd7MSSbDxwTv6AtZDFBtAETA=;
        b=SU78LiNet1xpwYSAUyT0grZCCYxlNigxg/oW4ZyOSv/o9OxF+cYfCQ8518djvTjtQJ
         a5mg4wnAj1kSoct5PFnckctiNL88EapOUSFFufAzalgTCEHKEKGwHu/FQVkO96UfWN5v
         OwhiU3H3X9f98s1Bj68QWrphqFBXWTd4PMgpOpFA4paB53LZHk1q/aPv3ahZjnKmfERM
         aeIUPdhacGiiyrby3Vv6KFU+u95KMo5M7prM83LMkXuzOalz5an6JDNstBfIE07RM5EB
         zZFAWIS/CK8CcguwF8i0kViqbUnjolI2YgpDaHBa4Xh66MU+XSE07AqxkYXk3uGF6iCd
         no/Q==
X-Gm-Message-State: APjAAAVqIGLc7BDCTlypQ/EoBnp9tQGdA71QhunbRRwt32kbX/s7L0Mj
        +7I3As8OrCo2RQ02IpB+w80bluc/
X-Google-Smtp-Source: APXvYqzwvWAqhfynqe9Mi3oizlqmRXNI7lErS2opLW2JSuIIBuOAfZcZ4yhviuxl8vnKkgPT/J46TQ==
X-Received: by 2002:a7b:cb91:: with SMTP id m17mr29278613wmi.146.1579029964077;
        Tue, 14 Jan 2020 11:26:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p18sm20100679wmb.8.2020.01.14.11.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 11:26:03 -0800 (PST)
Message-Id: <pull.513.git.1579029962.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 14 Jan 2020 19:25:54 +0000
Subject: [PATCH 0/8] Harden the sparse-checkout builtin
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, peff@peff.net, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series is based on ds/sparse-list-in-cone-mode.

This series attempts to clean up some rough edges in the sparse-checkout
feature, especially around the cone mode.

Unfortunately, after the v2.25.0 release, we noticed an issue with the "git
clone --sparse" option when using a URL instead of a local path. This is
fixed and properly tested here.

Also, let's improve Git's response to these more complicated scenarios:

 1. Running "git sparse-checkout init" in a worktree would complain because
    the "info" dir doesn't exist.
 2. Tracked paths that include "*" and "" in their filenames.
 3. If a user edits the sparse-checkout file to have non-cone pattern, such
    as "*" anywhere or "" in the wrong place, then we should respond
    appropriately. That is: warn that the patterns are not cone-mode, then
    revert to the old logic.

Thanks, -Stolee

Derrick Stolee (8):
  t1091: use check_files to reduce boilerplate
  sparse-checkout: create leading directories
  clone: fix --sparse option with URLs
  sparse-checkout: cone mode does not recognize "**"
  sparse-checkout: detect short patterns
  sparse-checkout: warn on incorrect '*' in patterns
  sparse-checkout: properly match escaped characters
  sparse-checkout: write escaped patterns in cone mode

 builtin/clone.c                    |   2 +-
 builtin/sparse-checkout.c          |  52 ++++-
 dir.c                              |  69 ++++++-
 dir.h                              |   1 +
 t/t1091-sparse-checkout-builtin.sh | 320 ++++++++++++++++-------------
 5 files changed, 296 insertions(+), 148 deletions(-)


base-commit: 4fd683b6a35eabd23dd5183da7f654a1e1f00325
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-513%2Fderrickstolee%2Fsparse-harden-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-513/derrickstolee/sparse-harden-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/513
-- 
gitgitgadget
