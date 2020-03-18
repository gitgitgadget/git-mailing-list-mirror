Return-Path: <SRS0=hWrV=5D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F89AC4332D
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 21:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D6EF20772
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 21:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V1/UTDd6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgCRVS3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Mar 2020 17:18:29 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35010 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgCRVS3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Mar 2020 17:18:29 -0400
Received: by mail-ed1-f67.google.com with SMTP id a20so32757463edj.2
        for <git@vger.kernel.org>; Wed, 18 Mar 2020 14:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=VBkG1uDJcW5fd2xSedN8nz/LgllWMutcl1Ub5saf4FI=;
        b=V1/UTDd64BlQQuffN5t+nkxZPnakkxJN+wYsAuCr0ZqXEZaAykFNK55KiU9EXAk0DE
         JtcDlrbFru9riHyMyt/6UEt+vQ08nweN6VndFIVfpaEPIKQbDh2FJ54FugFlCZbYSgxk
         CzvzBbOixqWwDgj9GYHALCEFIaAqO722rG8o7QKFQUt95op/FqIoeb0zrKzi8DY1vwuu
         wP40SwnbRvXojyk+/fL2sQSMvxNAg0H6Q+WkX++1odDoGn4DIdWIyJLe/DlQxAAL56sS
         MmmvUfEG2N5hcj1eysRtmXxbeMC95tvNHEUh5b5S1/jnmKnTT2+oQMIzWrAJKcqhG7Qe
         7kmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VBkG1uDJcW5fd2xSedN8nz/LgllWMutcl1Ub5saf4FI=;
        b=hDsTrbokkXkMqh+UpjQEeSj9+XYORfQGLXKy9BCGBk6yNZNqOALxiv97PTGytrO/y7
         YgUe4+eS99lVYDAYaWOKTFUV6Forj2E6abAXIhumcLE9qcUCtigWbTXP0/ZwFf2fe08T
         1zGkpeaw/Wr7VGpofcFPVEzPbLgnMEgHphZC8wAhnJWyvANaf1q1B2sCzmmd0qtgsUtB
         nqcUyUOSUzsxu2OvzBSR18D5TyFUGjTnf0K7e/C7yuXMtSHKpVKHo2fGkxHz8+v/On1t
         kkVvMdzdcqaH40qQisJaat5jPP0jCZGlCFXBzE+MESxhG4kmJLh+zUVWXQVTQN7R0nbq
         jalw==
X-Gm-Message-State: ANhLgQ1jMFy6NI666dfIFLS6Q1gq1H62NVsxlm8hOmtmXUkWxIteOnLD
        oacLMdTpOHTnUDdjRAo4QGv7Nart
X-Google-Smtp-Source: ADFU+vvT2IgQoBHbJokvyOWq3DIZEB52LbAme9kRD1xAlXWknAkVkcpl4ycogKiTtLbI3IwO6kYkUQ==
X-Received: by 2002:aa7:c69a:: with SMTP id n26mr6192309edq.136.1584566307262;
        Wed, 18 Mar 2020 14:18:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 91sm1131edq.78.2020.03.18.14.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 14:18:26 -0700 (PDT)
Message-Id: <pull.731.git.git.1584566306427.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 18 Mar 2020 21:18:26 +0000
Subject: [PATCH] RelNotes/2.26.0: fix various typos
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
    RelNotes/2.26.0: fix various typos
    
    gitgitgadget requires a description even though for single-commit series
    it doesn't use it to generate a cover letter. So now there's some
    useless text between the commit message and diff. Sorry.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-731%2Fnewren%2Frelnotes-typos-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-731/newren/relnotes-typos-v1
Pull-Request: https://github.com/git/git/pull/731

 Documentation/RelNotes/2.26.0.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/RelNotes/2.26.0.txt b/Documentation/RelNotes/2.26.0.txt
index 719750dbb5f..3a7a734c269 100644
--- a/Documentation/RelNotes/2.26.0.txt
+++ b/Documentation/RelNotes/2.26.0.txt
@@ -8,7 +8,7 @@ Backward compatibility notes
 
  * "git rebase" uses a different backend that is based on the 'merge'
    machinery by default.  There are a few known differences in the
-   behaviour from the traditional machniery based on patch+apply.
+   behaviour from the traditional machinery based on patch+apply.
 
    If your workflow is negatively affected by this change, please
    report it to git@vger.kernel.org so that we can take a look into
@@ -63,7 +63,7 @@ UI, Workflows & Features
  * "git rm" and "git stash" learns the new "--pathspec-from-file"
    option.
 
- * "git am --short-current-patch" is a way to show the piece of e-mail
+ * "git am --show-current-patch" is a way to show the piece of e-mail
    for the stopped step, which is not suitable to directly feed "git
    apply" (it is designed to be a good "git am" input).  It learned a
    new option to show only the patch part.
@@ -79,7 +79,7 @@ Performance, Internal Implementation, Development Support etc.
    with tabs.
 
  * The test-lint machinery knew to check "VAR=VAL shell_function"
-   construct, but did not check "VAR= shell_funciton", which has been
+   construct, but did not check "VAR= shell_function", which has been
    corrected.
 
  * Replace "git config --bool" calls with "git config --type=bool" in
@@ -229,7 +229,7 @@ Fixes since v2.25
  * Unhelpful warning messages during documentation build have been squelched.
 
  * "git rebase -i" identifies existing commits in its todo file with
-   their abbreviated object name, which could become ambigous as it
+   their abbreviated object name, which could become ambiguous as it
    goes to create new commits, and has a mechanism to avoid ambiguity
    in the main part of its execution.  A few other cases however were
    not covered by the protection against ambiguity, which has been

base-commit: be8661a3286c67a5d4088f4226cbd7f8b76544b0
-- 
gitgitgadget
