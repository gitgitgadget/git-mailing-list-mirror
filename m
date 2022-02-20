Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 942C0C433EF
	for <git@archiver.kernel.org>; Sun, 20 Feb 2022 17:54:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244424AbiBTRzM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Feb 2022 12:55:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243094AbiBTRzA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Feb 2022 12:55:00 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB41527F4
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 09:54:39 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id i14so23240171wrc.10
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 09:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0xrbPnWhZW4u2QEiFDiwjjeWdO8w4GIc7RxbHMBZa+E=;
        b=nCtju7FdI4Aze3yDX2AjvCo2DXg0gkrYvs15jJAECMnPMYoTGuV7U8wSL0HOFc+c81
         9dcYSKsJeuLvjUnEbnLsYmg0wCIgX5GX7wb1iLMHAQ+cCW/JlE3wUSeVs2t7UojxaEbl
         JY5D2HUlorGJlm170m8t8QHoVBgpLrcCZQ3swYLpjFDhNSKWQsX1Uz4xyuOTlSDdYMtg
         rPc5iQRL31mmJp4RugaQqQJEpjoCbmH1FAPW7lHzMp/g+yKysjegWEWNCeIb9+yEzzss
         KIZ9Jzb+mMB75XurpCi8mvirtzNtYeqL+4I7D4D3c0LeFb/CXocfj9WwOyg+ZIMsgp+d
         oi2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0xrbPnWhZW4u2QEiFDiwjjeWdO8w4GIc7RxbHMBZa+E=;
        b=vYm4Aeuj9Id3Jk7TvhHzw25UyLxvK57BlMxIJ1E+plh7LxiDoEdP1ZrXyrO7lf+Weq
         H4y5nhKZrgn4eHWcTSrHVeHZmJh+CY1Rxc4zs8hV/nIdQ5dBcjHUBUSr6ce3FujdtJjJ
         +10JWCGLTD1o6Qkgj3mNyz/eWRUaYEofHJd9L5dQsApLw+IOZz6VCwn5KiIIoEgfhVtd
         sfKuLrJ1mp9qQLy2lOCRUuKaHKxRO9Xz1n7WguJDiQDM5+YkTmt1Fdm+JEEX+QHcl9mY
         Y+Q/X8hu5B1Sa2urCd67jE1WSYBZbABuEBpU0EECQDcNHUYD34O0Y6jE57d1wJvW39co
         Rf2w==
X-Gm-Message-State: AOAM532m8ci+Clrcd/UbLkM+WNCjUR5T12ErgoG2Ogpwe9XF11Li3pBc
        npZ5/R8Cs9nMJaaBUTJeqDxtoEIY2zg=
X-Google-Smtp-Source: ABdhPJwICpAXYlC7UZoG2BED/Azqrin8/0e/Cy89iM2QdTaIiJT84HXFzgQL9oFSqskcbbRRgaN8RQ==
X-Received: by 2002:adf:f1d2:0:b0:1e4:aef2:76a8 with SMTP id z18-20020adff1d2000000b001e4aef276a8mr12671555wro.445.1645379677720;
        Sun, 20 Feb 2022 09:54:37 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n19-20020a05600c4f9300b0037c06fe68casm5504373wmq.44.2022.02.20.09.54.36
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 09:54:37 -0800 (PST)
Message-Id: <23e74c87116175924bfc389eb07fa96b4040fa0d.1645379667.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1154.git.1645379667.gitgitgadget@gmail.com>
References: <pull.1154.git.1645379667.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 20 Feb 2022 17:54:25 +0000
Subject: [PATCH 09/11] worktree: use 'worktree' over 'working tree'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "mailto:sunshine@sunshineco.com" 
        <[sunshine@sunshineco.com]@vger.kernel.org>,
        "mailto:gitster@pobox.com" <[gitster@pobox.com]@vger.kernel.org>,
        "Elijah Newren [ ]" <newren@gmail.com>,
        "=?UTF-8?Q?Jean-No=C3=ABl?= AVILA [ ]" <jn.avila@free.fr>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

It is helpful to distinguish between a 'working tree' and a 'worktree'.
A worktree contains a working tree plus additional metadata. This
metadata includes per-worktree refs and worktree-specific config.

This is the fifth of multiple changes to git-worktree.txt, restricted to
the CONFIGURATION FILE section.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/git-worktree.txt | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 54a2c335fd5..8821e56c6ec 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -283,12 +283,12 @@ which will handle refs correctly.
 
 CONFIGURATION FILE
 ------------------
-By default, the repository `config` file is shared across all working
-trees. If the config variables `core.bare` or `core.worktree` are
-present in the common config file and `extensions.worktreeConfig` is
-disabled, then they will be applied to the main working tree only.
+By default, the repository `config` file is shared across all worktrees.
+If the config variables `core.bare` or `core.worktree` are present in the
+common config file and `extensions.worktreeConfig` is disabled, then they
+will be applied to the main worktree only.
 
-In order to have configuration specific to working trees, you can turn
+In order to have configuration specific to worktrees, you can turn
 on the `worktreeConfig` extension, e.g.:
 
 ------------
@@ -302,16 +302,16 @@ versions will refuse to access repositories with this extension.
 
 Note that in this file, the exception for `core.bare` and `core.worktree`
 is gone. If they exist in `$GIT_DIR/config`, you must move
-them to the `config.worktree` of the main working tree. You may also
-take this opportunity to review and move other configuration that you
-do not want to share to all working trees:
+them to the `config.worktree` of the main worktree. You may also take this
+opportunity to review and move other configuration that you do not want to
+share to all worktrees:
 
  - `core.worktree` should never be shared.
 
  - `core.bare` should not be shared if the value is `core.bare=true`.
 
- - `core.sparseCheckout` is recommended per working tree, unless you
-   are sure you always use sparse checkout for all working trees.
+ - `core.sparseCheckout` is recommended per worktree, unless you are sure
+   you always use sparse checkout for all worktrees.
 
 See the documentation of `extensions.worktreeConfig` in
 linkgit:git-config[1] for more details.
-- 
gitgitgadget

