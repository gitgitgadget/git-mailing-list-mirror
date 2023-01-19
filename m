Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E142C004D4
	for <git@archiver.kernel.org>; Thu, 19 Jan 2023 17:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjASRee (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Jan 2023 12:34:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjASRea (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2023 12:34:30 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F2B2137
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 09:34:29 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id fl11-20020a05600c0b8b00b003daf72fc844so4107258wmb.0
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 09:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BvjTQMsN1DeH7Uwr283uyqWYtYNqOaCgOSIF09msE0I=;
        b=hK/HqMR9kDgBgnvI/iL2tyu7dSCMBY8XzvNsaGUuxy1qqRjs7y0C7tpxRpSIlzTxrr
         Z1jR1uynyDyVd0tKEm+BAwiWffLx5rvnwqunYJ35HZ0K0XCoj4MFnFy6YF/w1khCPRAv
         2RXkAJJZkn/DpZ3ofF9SUryKq9a8Xc0RgYv9Ojx8JyI2FKeJ2IeRJEfOHo0KxBqsjXtx
         gbVBgIeShCqgPyxPJl9L7K1HBZ7G6EtnWF6OlmjsR86Ziz0OxRuWb8PTaUZlr8g3w1Oq
         qUr1HFycxYIzzJLcDdcC7dZJTjV3PR/+81ZHVMY8P8rYdmMMakIKinyLWDEzlIMO6bNm
         vXDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BvjTQMsN1DeH7Uwr283uyqWYtYNqOaCgOSIF09msE0I=;
        b=mVoGEoPGMa5ryvbMETPYHNxqyswy/oD+axrdv+8DaE8VQ5J0BBVA5A+h8qDOMWDeTy
         TAGeoI6G81zZ3qGNK9cJKhH6LTeDlyCGMbaDwmKg8Oq9qHPdELWJEqJbf/znWvamhSsR
         aJv1lShcrGQAaI1Vzwa/YG7xEdGzCVFSyTUfwK0QycH+hygABP37+BIwJS1CpIX/J6gs
         DmU723lK6nT+EqX4iyraWs0sJ1WGfHnq7YxetBfTUOYzEzbIsAus310l1qm4b2za5h00
         s7uKVHMnDwk6DX8xlaQjUPs+ZvXior4r/h1ZCcPAy88nwRyVAr96+1TdyhqjDlI0rG6/
         aLuQ==
X-Gm-Message-State: AFqh2korDx6PQAZVSCHdixuRNuZIrw/4qFyJ+x6XOopYjQh5K2m68eS+
        uvkfuGaAek6ubatjHzZVwjvdY5GVgSA=
X-Google-Smtp-Source: AMrXdXuUJRIyWT5z7/+oaKCBJw2S3wmQ1Wfaqwors9TvA79fkovCeGxh2fFD0h93rwgMJZermr6f7g==
X-Received: by 2002:a05:600c:4f06:b0:3da:f671:eded with SMTP id l6-20020a05600c4f0600b003daf671ededmr11161465wmq.12.1674149667993;
        Thu, 19 Jan 2023 09:34:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l11-20020a1ced0b000000b003dafb0c8dfbsm6614892wmh.14.2023.01.19.09.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 09:34:27 -0800 (PST)
Message-Id: <cde4827da13a1391501057ee42655836f0ccd337.1674149666.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1458.v2.git.1674149666.gitgitgadget@gmail.com>
References: <pull.1458.git.1673451741587.gitgitgadget@gmail.com>
        <pull.1458.v2.git.1674149666.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 19 Jan 2023 17:34:24 +0000
Subject: [PATCH v2 1/2] docs: fix sparse-checkout docs link
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
        <pclouds@gmail.com>, ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

There is a linking error when other documents want to refer to
technical/sparse-checkout.txt, Also, there is something wrong
with the format of the paragraphs in sparse-checkout.txt, which
makes acsiidoc compile errors.

So fix the format of sparse-checkout.txt, and link it in the
Makefile to correct that.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 Documentation/Makefile                      |  1 +
 Documentation/technical/sparse-checkout.txt | 43 ++++++++++++++-------
 2 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 9c67c3a1c50..7540da27b8c 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -121,6 +121,7 @@ TECH_DOCS += technical/reftable
 TECH_DOCS += technical/scalar
 TECH_DOCS += technical/send-pack-pipeline
 TECH_DOCS += technical/shallow
+TECH_DOCS += technical/sparse-checkout
 TECH_DOCS += technical/trivial-merge
 SP_ARTICLES += $(TECH_DOCS)
 SP_ARTICLES += technical/api-index
diff --git a/Documentation/technical/sparse-checkout.txt b/Documentation/technical/sparse-checkout.txt
index fa0d01cbda4..52e86764a6c 100644
--- a/Documentation/technical/sparse-checkout.txt
+++ b/Documentation/technical/sparse-checkout.txt
@@ -1,3 +1,6 @@
+Sparse Checkout Design Notes
+============================
+
 Table of contents:
 
   * Terminology
@@ -14,7 +17,8 @@ Table of contents:
   * Reference Emails
 
 
-=== Terminology ===
+Terminology
+-----------
 
 cone mode: one of two modes for specifying the desired subset of files
 	in a sparse-checkout.  In cone-mode, the user specifies
@@ -92,7 +96,8 @@ vivifying: When a command restores a tracked file to the working tree (and
 	file), this is referred to as "vivifying" the file.
 
 
-=== Purpose of sparse-checkouts ===
+Purpose of sparse-checkouts
+---------------------------
 
 sparse-checkouts exist to allow users to work with a subset of their
 files.
@@ -255,7 +260,8 @@ will perceive the checkout as dense, and commands should thus behave as if
 all files are present.
 
 
-=== Usecases of primary concern ===
+Usecases of primary concern
+---------------------------
 
 Most of the rest of this document will focus on Behavior A and Behavior
 B.  Some notes about the other two cases and why we are not focusing on
@@ -300,7 +306,8 @@ Behavior C do not assume they are part of the Behavior B camp and propose
 patches that break things for the real Behavior B folks.
 
 
-=== Oversimplified mental models ===
+Oversimplified mental models
+----------------------------
 
 An oversimplification of the differences in the above behaviors is:
 
@@ -313,7 +320,8 @@ An oversimplification of the differences in the above behaviors is:
 	      they can later lazily be populated instead.
 
 
-=== Desired behavior ===
+Desired behavior
+----------------
 
 As noted previously, despite the simple idea of just working with a subset
 of files, there are a range of different behavioral changes that need to be
@@ -544,7 +552,8 @@ understanding these differences can be beneficial.
   * gitk?
 
 
-=== Behavior classes ===
+Behavior classes
+----------------
 
 From the above there are a few classes of behavior:
 
@@ -611,7 +620,8 @@ From the above there are a few classes of behavior:
     specification.
 
 
-=== Subcommand-dependent defaults ===
+Subcommand-dependent defaults
+-----------------------------
 
 Note that we have different defaults depending on the command for the
 desired behavior :
@@ -751,7 +761,8 @@ desired behavior :
     implemented.
 
 
-=== Sparse specification vs. sparsity patterns ===
+Sparse specification vs. sparsity patterns
+------------------------------------------
 
 In a well-behaved situation, the sparse specification is given directly
 by the $GIT_DIR/info/sparse-checkout file.  However, it can transiently
@@ -823,7 +834,8 @@ under behavior B index operations are lumped with history and tend to
 operate full-tree.
 
 
-=== Implementation Questions ===
+Implementation Questions
+------------------------
 
   * Do the options --scope={sparse,all} sound good to others?  Are there better
     options?
@@ -894,7 +906,8 @@ operate full-tree.
     is seamless for them.
 
 
-=== Implementation Goals/Plans ===
+Implementation Goals/Plans
+--------------------------
 
  * Get buy-in on this document in general.
 
@@ -922,13 +935,14 @@ operate full-tree.
      commands.  IMPORTANT: make sure diff machinery changes don't mess with
      format-patch, fast-export, etc.
 
-=== Known bugs ===
+Known bugs
+----------
 
 This list used to be a lot longer (see e.g. [1,2,3,4,5,6,7,8,9]), but we've
 been working on it.
 
-0. Behavior A is not well supported in Git.  (Behavior B didn't used to
-   be either, but was the easier of the two to implement.)
+Behavior A is not well supported in Git.  (Behavior B didn't used to
+be either, but was the easier of the two to implement.)
 
 1. am and apply:
 
@@ -1052,7 +1066,8 @@ been working on it.
     https://lore.kernel.org/git/CABPp-BEkJQoKZsQGCYioyga_uoDQ6iBeW+FKr8JhyuuTMK1RDw@mail.gmail.com/
 
 
-=== Reference Emails ===
+Reference Emails
+----------------
 
 Emails that detail various bugs we've had in sparse-checkout:
 
-- 
gitgitgadget

