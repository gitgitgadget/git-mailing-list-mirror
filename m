Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C18F6C433F5
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 00:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237704AbiBVASn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 19:18:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237645AbiBVASe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 19:18:34 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D242558A
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 16:18:10 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id v12so29795916wrv.2
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 16:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=71IR1ndZ2w2kfNfmiUwb7zLMwy/lMzuRh299O9XMzfI=;
        b=C+v69BSBnju/Xrrt66Y9ayrwDq2X7EKcUQqphhFBfkTs33biwTj+BADr+YAFMMz+Tm
         rP4LUsu5UNI13xuZY5NzHnJ5dRDcUOR4MOBWGArsQnopmBvLlUD7+wk1LSgivGkL+Jfw
         X60yfdCGaqjudswbfd4KyvHfvdJ4HezEDb3zjiItghlGnrjogSJ6ZK6tL1cSSsiok/cb
         xGz5tr2vS97wBHMdci9vnPikEi65S9Yo+kc2LWaZt9+sC5OHOsD0ZdSkuDMgv1TLBw6F
         KhzSvZMeFue+4VpANo42I/baRZ7AW0z5CQF9RwTWxWaqXfvWDps/SzCPdU+wGUZx5UKg
         fSYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=71IR1ndZ2w2kfNfmiUwb7zLMwy/lMzuRh299O9XMzfI=;
        b=tHfe328cEw+44lbbYeE03LfIscBuJPaz/fmcca3f8PdGgZsuRk6mPXYMvOjynDkKVQ
         zcyLGgst/aN/IEsUaaKW8w3m2/mNHgYJD7RDTgb1Rzj93w22vi/fcxGYrI7OTzGelInq
         idbY77mGHD7frLDtfe7Ok10YKoMEaWI6LR8gBDFEg2WPIZB3FOyUMJKAPeiuHANTKDXl
         lM90TWyHJvDzR800DNMwMv7oPkGVmNwe1YRZmWVVL3rLQqQffb/ibJaFqGP2E9jUakCa
         WzngmvkKHRPuOJJf2N7DhcAlzYJ5OQHWd9Zk16w6lMS9Dajc2OKiXQTErHrnNwcBnXsv
         AMhw==
X-Gm-Message-State: AOAM5332vUhH0SIYtM349cfKFldu4+k8CB4M57U1a2nAY1uSvOM/Bg/j
        znLJUZ+ZqAz/Yt+adXWB7sjSAiHaQSg=
X-Google-Smtp-Source: ABdhPJzTYuxLwK6eP5GHekjJSozWkRBtCDgmrStz3KfLCl0s4Rj0s44mw8L9ED+/Cqn8o3CeZyeXcA==
X-Received: by 2002:a5d:628e:0:b0:1e6:9092:a534 with SMTP id k14-20020a5d628e000000b001e69092a534mr16685942wru.1.1645489088937;
        Mon, 21 Feb 2022 16:18:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n15sm23606442wri.33.2022.02.21.16.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 16:18:08 -0800 (PST)
Message-Id: <e8890134fb462bc035231f71a27cf85a5a9e2401.1645489080.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1154.v2.git.1645489080.gitgitgadget@gmail.com>
References: <pull.1154.git.1645379667.gitgitgadget@gmail.com>
        <pull.1154.v2.git.1645489080.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Feb 2022 00:17:58 +0000
Subject: [PATCH v2 09/11] worktree: use 'worktree' over 'working tree'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sunshine@sunshineco.com, gitster@pobox.com, newren@gmail.com,
        jn.avila@free.fr, Taylor Blau <me@ttaylorr.com>,
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

While here, clear up some language to improve readability.

Helped-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/git-worktree.txt | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 41c6d503937..d890221d31f 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -284,13 +284,13 @@ which will handle refs correctly.
 
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
-on the `worktreeConfig` extension, e.g.:
+In order to have worktree-specific configuration, you can turn on the
+`worktreeConfig` extension, e.g.:
 
 ------------
 $ git config extensions.worktreeConfig true
@@ -303,16 +303,16 @@ versions will refuse to access repositories with this extension.
 
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
+ - `core.sparseCheckout` should not be shared, unless you are sure you
+   always use sparse checkout for all worktrees.
 
 See the documentation of `extensions.worktreeConfig` in
 linkgit:git-config[1] for more details.
-- 
gitgitgadget

