Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF75DC433F5
	for <git@archiver.kernel.org>; Sat, 12 Mar 2022 03:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbiCLDMs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 22:12:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbiCLDMd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 22:12:33 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31872923FC
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 19:11:27 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 7-20020a05600c228700b00385fd860f49so6413720wmf.0
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 19:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=iNfUFTserT6zohLzadoxjW83Qh8oDm1GULCxdd09RBA=;
        b=lhlPRho+wNCRvsgZhZj76DLpTBdHqXBi8QweMwFQnkuY6LPeqO+DOZeLgoLrcpj7hg
         3etmys8wxD5Xu09d7Ia+3wXMJzC4+67lTlcdoBI+OYl+QkjZRFdW3klUFw3mpcjYhx4M
         kLTn6XLGDeLG3W5vEvPAJqhWcTaHE3A3AgHfsxZ/L7fJfzzPaDaUCqVnaY34aWyoLklG
         WHKAO4lnXhW4uXqCOrxyyqxKK5YRQbPoV/hVIb6/ElXPNnxY6Sl83KsY0GS7EYbSiEz1
         SbG86DtEJvH4xeeToUguM1w9yt2yLk4TF9VY6JidW9ANAXnvU3aIX5e0wqh1SD2Gp7X9
         w2Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=iNfUFTserT6zohLzadoxjW83Qh8oDm1GULCxdd09RBA=;
        b=vLlUUCJJhDLw9Jt54APhqE0Vmxggg1xHDgPLs7kteZQxDF/xlJoyDMVMdMmrcAIoBs
         /NY81bwinNjGgqAxQcAeGfjr8yhp6eynLWK+G4w6JZyjfnD1qHtauutjDxcz5mZd+uuL
         YCDaOgPc0OB4ezLRnKoiGuaPM66wOXqNuSciD5PHROr3E5GZkiHlmKRJy5c3goBlQ2fG
         hRiyWD14K44bqSvJtd19DLWztGMZEWo7Gt4xXBi3ds9TNwfrm5omrMc90DEPFpbWfBJs
         R6nrGZt5vrOi7v3gC8KQNfxRaJizSQJzuxnd5tZXv/yejnjNQiNhCCjWVRj/qx2Mtify
         O6hw==
X-Gm-Message-State: AOAM533G2XCm1iMKgoJqhg0WeqHSIJIYUCEGxJofpn7MCGolX5RQeLcR
        L9spVGbEAGxbkh4qADeIBoVvp/e2MAE=
X-Google-Smtp-Source: ABdhPJyS4jWgQNS7xfFGNfPs7BwEt+r4Snl/37nBpfBDDgBIzLHaY1uHgaYDY6naNZGqI4SoB6ziFQ==
X-Received: by 2002:a7b:c347:0:b0:37e:68e6:d85c with SMTP id l7-20020a7bc347000000b0037e68e6d85cmr18116369wmj.176.1647054686237;
        Fri, 11 Mar 2022 19:11:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n16-20020a5d4010000000b001f07772457csm7699437wrp.101.2022.03.11.19.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 19:11:25 -0800 (PST)
Message-Id: <eb3b318b39ec3eed754eab7d2c9d20198117545b.1647054681.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1148.v2.git.1647054681.gitgitgadget@gmail.com>
References: <pull.1148.git.1646725188.gitgitgadget@gmail.com>
        <pull.1148.v2.git.1647054681.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 12 Mar 2022 03:11:16 +0000
Subject: [PATCH v2 4/9] git-sparse-checkout.txt: update docs for deprecation
 of 'init'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

The 'init' subcommand of sparse-checkout was deprecated in ba2f3f58ac
("git-sparse-checkout.txt: update to document init/set/reapply changes",
2021-12-14), but a couple places in the manual still assumed it was the
primary way to use sparse-checkout.  Correct them.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-sparse-checkout.txt | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index 42a984306bb..b9e44e3dd4c 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -70,11 +70,11 @@ SET' below for more details).  In the past, this was not the default,
 and `--cone` needed to be specified or `core.sparseCheckoutCone` needed
 to be enabled.
 +
-When `--no-cone` is passed or `core.sparseCheckoutCone` is false,
-the input list is considered a list of patterns.  This mode is harder
-to use and less performant, and is thus not recommended.  See the
-"Sparse Checkout" section of linkgit:git-read-tree[1] and the "Pattern
-Set" sections below for more details.
+When `--no-cone` is passed, the input list is considered a list of
+patterns.  This mode is harder to use and less performant, and is thus
+not recommended.  See the "Sparse Checkout" section of
+linkgit:git-read-tree[1] and the "Pattern Set" sections below for more
+details.
 +
 Use the `--[no-]sparse-index` option to use a sparse index (the
 default is to not use it).  A sparse index reduces the size of the
@@ -196,9 +196,9 @@ In addition to the above two patterns, we also expect that all files in the
 root directory are included. If a recursive pattern is added, then all
 leading directories are added as parent patterns.
 
-By default, when running `git sparse-checkout init`, the root directory is
-added as a parent pattern. At this point, the sparse-checkout file contains
-the following patterns:
+By default, when running `git sparse-checkout set` with no directories
+specified, the root directory is added as a parent pattern. At this
+point, the sparse-checkout file contains the following patterns:
 
 ----------------
 /*
-- 
gitgitgadget

