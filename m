Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B72B4C433FE
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 07:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344663AbiCHHk6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 02:40:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344647AbiCHHkw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 02:40:52 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3B239834
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 23:39:56 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id n31-20020a05600c3b9f00b003898fc06f1eso847292wms.1
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 23:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LBs+toRKrNAeFvILpMVU2ojoAq4HAqoAo1bWvbw2bbg=;
        b=b7lrPVGbk4U0+qFuy2X0smtsy82TjaHrw9fIp1cIUX+n+DQHFxAU7MOrXlG1cEZ7HJ
         EHfin/zPDcqa+9H0NMHem7NlGrmZst+sD6YuxKDWiGRnX+adBrx6mMUinPSfmZDb8fFg
         ui762MBUCwwuoB+QgoVAxcN3cEFgSWw5d8M9iBe/NtoHioLLmjndZSr3Gbt9wZ5QeKiV
         X7/j/kd2Zmcft8c3aZlT3MXRk/QntvmMqnX+iXeXUcBvA9OfEQV+gdR+xKZcw/hr7KFT
         9KIdoB1Hnxud5H+yyTVhdd1KYqHFKDjix+/VcHyNxV8V/9XLT+tZdieckIo8gyyUltMl
         fCBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LBs+toRKrNAeFvILpMVU2ojoAq4HAqoAo1bWvbw2bbg=;
        b=Eq1XYMvM009kAcdWizumo2qo45FPl3Ijq4V7uZWQDCuhGFHJHukShHVZl6himcvKdp
         CHWLHya51Ozf3ZfVdQSySmx5KvXcN0F/v6kl6kr1rKaJwPYVCpNj5xv3LG9bCnBUHiS1
         cSHMJiP3AljiB5zTRDzrDtuupPHM9BLTfkfuASaZyRgM3MUOOi8AJLKnBdaY/icZwdok
         utujrKFuCFZSJSEJ3NftZupv50Pzd1uNO1h66Tmnip/C/AZDofNahCCjbnmjnvfQErnP
         axJSTdvaNWcDsXrewTYst+73Af1niT05PPQgJ6a9TYfdENP/6ntsM2ePhn3N34BUQJXd
         2p9w==
X-Gm-Message-State: AOAM5306BJh+bg9z/L/P/eUDhOBIeaGQJQ+uDgh3F+xsih1NqAntkeV/
        MTflrqsXRLE4d27BmtXvOfcpU7coxoc=
X-Google-Smtp-Source: ABdhPJwsBUg24Y6wDP2bxOhwNpWQ0+mzTQB5VC2eenZxAG9wFnO/BKk7f1FFOKLc9+lDIDQ4gJKBhA==
X-Received: by 2002:a05:600c:2219:b0:389:bc8b:ac48 with SMTP id z25-20020a05600c221900b00389bc8bac48mr2346856wml.14.1646725194726;
        Mon, 07 Mar 2022 23:39:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b10-20020a05600003ca00b001f1f9a83123sm3978348wrg.103.2022.03.07.23.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 23:39:54 -0800 (PST)
Message-Id: <fe37a966699e073543d75e450197e535d021d622.1646725188.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1148.git.1646725188.gitgitgadget@gmail.com>
References: <pull.1148.git.1646725188.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 08 Mar 2022 07:39:44 +0000
Subject: [PATCH 5/9] git-sparse-checkout.txt: shuffle some sections and mark
 as internal
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
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
 Documentation/git-sparse-checkout.txt | 44 +++++++++++++--------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index b9e44e3dd4c..883b7f4c44f 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
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

