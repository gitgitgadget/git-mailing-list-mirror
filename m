Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7967C636CC
	for <git@archiver.kernel.org>; Sat,  4 Feb 2023 16:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbjBDQRD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Feb 2023 11:17:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbjBDQRB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Feb 2023 11:17:01 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 533751EBD8
        for <git@vger.kernel.org>; Sat,  4 Feb 2023 08:17:00 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id bh13-20020a05600c3d0d00b003dff6cd8b7eso699316wmb.5
        for <git@vger.kernel.org>; Sat, 04 Feb 2023 08:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jSm+KAWKDn6HaA/qfSt52Xblh2qrzegwubt5etQXxYI=;
        b=Vd7fNnUNwljgbY4awpf/eCIVzy36W60p576bYgT15otWI1a26d1cilwIUHkw1jOkeJ
         2FSGrnMvdXxZVVaCNCNL7+6BB8q2WiIJPIH3+z3ruPo2N21FURcPLr0EIA2g/KSaBecC
         gEZZ5s7QvD8zpg51B58fqz2YqaiVfR8XOiwW8OEWMJPgBQYHRZtUcH7Tk0kLvIBFtK8E
         Ii9/jd2IkPes2IOIIKGK+kr5RaLM/zrGJsBWsKcqhE+uXSQoKrL/I5DECEFoxrKwQEIz
         hTu/YAvBufoNb9rycpTlnAP5AT6X81UBmofPsy52/p96IzbwdCUJueTtAeF+iU0JHsxk
         HI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jSm+KAWKDn6HaA/qfSt52Xblh2qrzegwubt5etQXxYI=;
        b=UnPKYfjVjIrxvVWH2PMS+mg7VpnhMMy/11qradDW8Xgi6XaFXF8qtnhO4W8RxvzjTh
         JsTfgmjEc6NLr81CYb301QWAFU4VJmh90AyKT92cjkJpBMVfqQZBxza5g3sE5RKcb12e
         TIVG4p0NKsSdYEeyP8N0p3aDAP5THPBoLl5qMvJaaKnTTGiY1QfmvuuTBxvDVhTbjgts
         HjuJKFhy6a7qzYXL8LAvFmTSMHCyrwxxFKEFG6l5GPUpW/egp2ySiEWkC04r8OuZPlaz
         sbySf2JoQAcqHSm5MmQj3eFUbheeIpOxjD1sedE7nTy7LGo0zFhc18aSIpnh3u5W6u2w
         L+/g==
X-Gm-Message-State: AO0yUKUYhk1pT2CR5tV7agqQyiHgjwi1WiWxiOLhOEoAx2qIE2yW3k7P
        YqYFcGjBISW3lVjWIQvCBVQrli54dOU=
X-Google-Smtp-Source: AK7set9i000w68Ja5/1ymBBmyB9TER2x7yn1LCNQVFdvnjieOZRLPfpOQY7aTfEfXpsyRxNDpP3rnw==
X-Received: by 2002:a05:600c:354c:b0:3db:1a41:6629 with SMTP id i12-20020a05600c354c00b003db1a416629mr13092198wmq.22.1675527418601;
        Sat, 04 Feb 2023 08:16:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bg21-20020a05600c3c9500b003db06493ee7sm12330755wmb.47.2023.02.04.08.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Feb 2023 08:16:58 -0800 (PST)
Message-Id: <3bdd3ceb16c56587474e110306d473cc0cd7f185.1675527416.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1458.v3.git.1675527416.gitgitgadget@gmail.com>
References: <pull.1458.v2.git.1674149666.gitgitgadget@gmail.com>
        <pull.1458.v3.git.1675527416.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 04 Feb 2023 16:16:55 +0000
Subject: [PATCH v3 1/2] docs: fix sparse-checkout docs link
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
        <pclouds@gmail.com>,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>,
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
 Documentation/technical/sparse-checkout.txt | 55 +++++++++++++--------
 2 files changed, 36 insertions(+), 20 deletions(-)

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
index fa0d01cbda4..15ab4034881 100644
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
 
@@ -922,15 +935,16 @@ operate full-tree.
      commands.  IMPORTANT: make sure diff machinery changes don't mess with
      format-patch, fast-export, etc.
 
-=== Known bugs ===
+Known bugs
+----------
 
 This list used to be a lot longer (see e.g. [1,2,3,4,5,6,7,8,9]), but we've
 been working on it.
 
-0. Behavior A is not well supported in Git.  (Behavior B didn't used to
-   be either, but was the easier of the two to implement.)
+. Behavior A is not well supported in Git.  (Behavior B didn't used to
+be either, but was the easier of the two to implement.)
 
-1. am and apply:
+. am and apply:
 
    apply, without `--index` or `--cached`, relies on files being present
    in the working copy, and also writes to them unconditionally.  As
@@ -950,7 +964,7 @@ been working on it.
    files and then complain that those vivified files would be
    overwritten by merge.
 
-2. reset --hard:
+. reset --hard:
 
    reset --hard provides confusing error message (works correctly, but
    misleads the user into believing it didn't):
@@ -973,13 +987,13 @@ been working on it.
     `git reset --hard` DID remove addme from the index and the working tree, contrary
     to the error message, but in line with how reset --hard should behave.
 
-3. read-tree
+. read-tree
 
    `read-tree` doesn't apply the 'SKIP_WORKTREE' bit to *any* of the
    entries it reads into the index, resulting in all your files suddenly
    appearing to be "deleted".
 
-4. Checkout, restore:
+. Checkout, restore:
 
    These command do not handle path & revision arguments appropriately:
 
@@ -1032,7 +1046,7 @@ been working on it.
     S tracked
     H tracked-but-maybe-skipped
 
-5. checkout and restore --staged, continued:
+. checkout and restore --staged, continued:
 
    These commands do not correctly scope operations to the sparse
    specification, and make it worse by not setting important SKIP_WORKTREE
@@ -1048,11 +1062,12 @@ been working on it.
    the sparse specification, but then it will be important to set the
    SKIP_WORKTREE bits appropriately.
 
-6. Performance issues; see:
+. Performance issues; see:
     https://lore.kernel.org/git/CABPp-BEkJQoKZsQGCYioyga_uoDQ6iBeW+FKr8JhyuuTMK1RDw@mail.gmail.com/
 
 
-=== Reference Emails ===
+Reference Emails
+----------------
 
 Emails that detail various bugs we've had in sparse-checkout:
 
-- 
gitgitgadget

