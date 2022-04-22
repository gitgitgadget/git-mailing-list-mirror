Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96354C433EF
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 02:32:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443402AbiDVCfp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 22:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443387AbiDVCfg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 22:35:36 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8F54B423
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 19:32:35 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id m15-20020a7bca4f000000b0038fdc1394b1so7047483wml.2
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 19:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Z/qpVU+nW5fs8WHL+S8XH0F0zKjx68eiiAimoVfSsfg=;
        b=UvNHs/fmRNgyqZ2EOW7Kq839z8ZcL5w8jx32Pu30yhY8qJTVsxcHa73E4pW6+2+1jM
         wa1VukNZAk5N9llSBZsIoDlkpXI8vAwib5wGOQgvmt2DcGO6rHyxWXSHs9YBTdNyvU6Y
         n3QclyEe/IZjRW3km5DSb0hWm7q4++ZvR8UXoGzEhnvwjHOoGu14Bo34mD4mPyEpJOYB
         wLgZN4BMtMFaTahO2CWlwpnr041u/0xziIHSyFpROHKZZrI7WapyGZNw7p8mBTHZyQft
         H9A145tV66fQnmMeGrgCEgWvM0uYn3E1EzA6+VEeC3a1Q6osg5at3pyk0eBwvecMJ3zy
         3p2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Z/qpVU+nW5fs8WHL+S8XH0F0zKjx68eiiAimoVfSsfg=;
        b=2czktufJqA0gjAC8XAcqeF8goGIDNKcXojEulTdsRx44HfvqBPHL49vuNkC7dgBA3d
         WT4yPc5/Ft74nPHGyNw4t7wPYsX3uMALxCt2ToZHQlr6cvWtBs2EK+48ucOpGBdFdLlM
         7BWVrFYBAQ+5A+651yoA9kJAahauGdURZD8ptaJuaqO7AUwYrTcxmqzs72Sbyr3Lw9aL
         kcMwVSKyHplsWRue4swul6l8+WFWLRk0Gw/HaNYeFvuw/z37kiXEnFqSpC7Y2aSARbp3
         Jh7jQFtRQTFMeYDPvyu1+/YZK1XO5L9O+SYsdgv/dX8ucXz9Sr5SHs3Fg/33BSAmPUmg
         Ewrw==
X-Gm-Message-State: AOAM532MIwqWiW9KtMqi3f99y03euGvDcTJdPe7WXX5atDuCPRADWZbY
        fxvtAlHaOqDMnfmJFfCXTii/XToPUCk=
X-Google-Smtp-Source: ABdhPJwnHp9qbkKLQBCQb2wuuu7GydFjIrs5k/cCn7wJ6CriBSjBIsIM2ZcMoYU7XhZpvv/Q01RFUQ==
X-Received: by 2002:a1c:3846:0:b0:392:a3e7:3798 with SMTP id f67-20020a1c3846000000b00392a3e73798mr1918762wma.80.1650594753593;
        Thu, 21 Apr 2022 19:32:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n68-20020a1c2747000000b0038e6b4d5395sm550317wmn.16.2022.04.21.19.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 19:32:33 -0700 (PDT)
Message-Id: <eda0f41395b28b309ea15fa2927ac6ad867f97ed.1650594746.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1148.v3.git.1650594746.gitgitgadget@gmail.com>
References: <pull.1148.v2.git.1647054681.gitgitgadget@gmail.com>
        <pull.1148.v3.git.1650594746.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Apr 2022 02:32:22 +0000
Subject: [PATCH v3 5/9] git-sparse-checkout.txt: shuffle some sections and
 mark as internal
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

With cone mode as the default, it makes sense to discuss it before
non-cone mode.  Also, the new default means we can just use directories
in most cases and users do not need to understand patterns or their
meanings.  Let's take advantage of this to mark several sections as
"INTERNALS", notifying the user that they do not need to know all those
details in order to make use of the sparse-checkout command.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-sparse-checkout.txt | 48 +++++++++++++--------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index 8e80d1c7332..2083e6df356 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -73,8 +73,8 @@ to be enabled.
 When `--no-cone` is passed, the input list is considered a list of
 patterns.  This mode is harder to use and less performant, and is thus
 not recommended.  See the "Sparse Checkout" section of
-linkgit:git-read-tree[1] and the "Pattern Set" sections below for more
-details.
+linkgit:git-read-tree[1] and the "Internals...Pattern Set" sections
+below for more details.
 +
 Use the `--[no-]sparse-index` option to use a sparse index (the
 default is to not use it).  A sparse index reduces the size of the
@@ -136,8 +136,8 @@ paths to pass to a subsequent 'set' or 'add' command.  However,
 the disable command, so the easy restore of calling a plain `init`
 decreased in utility.
 
-SPARSE CHECKOUT
----------------
+INTERNALS -- SPARSE CHECKOUT
+----------------------------
 
 "Sparse checkout" allows populating the working directory sparsely.  It
 uses the skip-worktree bit (see linkgit:git-update-index[1]) to tell Git
@@ -161,24 +161,8 @@ To repopulate the working directory with all files, use the
 `git sparse-checkout disable` command.
 
 
-FULL PATTERN SET
-----------------
-
-By default, the sparse-checkout file uses the same syntax as `.gitignore`
-files.
-
-While `$GIT_DIR/info/sparse-checkout` is usually used to specify what
-files are included, you can also specify what files are _not_ included,
-using negative patterns. For example, to remove the file `unwanted`:
-
-----------------
-/*
-!unwanted
-----------------
-
-
-CONE PATTERN SET
-----------------
+INTERNALS -- CONE PATTERN SET
+-----------------------------
 
 The full pattern set allows for arbitrary pattern matches and complicated
 inclusion/exclusion rules. These can result in O(N*M) pattern matches when
@@ -256,8 +240,24 @@ use `git add` and `git commit` to store them, then remove any remaining files
 manually to ensure Git can behave optimally.
 
 
-SUBMODULES
-----------
+INTERNALS -- FULL PATTERN SET
+-----------------------------
+
+By default, the sparse-checkout file uses the same syntax as `.gitignore`
+files.
+
+While `$GIT_DIR/info/sparse-checkout` is usually used to specify what
+files are included, you can also specify what files are _not_ included,
+using negative patterns. For example, to remove the file `unwanted`:
+
+----------------
+/*
+!unwanted
+----------------
+
+
+INTERNALS -- SUBMODULES
+-----------------------
 
 If your repository contains one or more submodules, then submodules
 are populated based on interactions with the `git submodule` command.
-- 
gitgitgadget

