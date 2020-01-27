Return-Path: <SRS0=ksp+=3Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BFC5C35240
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 02:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C8B720842
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 02:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PtX964dP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgA0CYT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jan 2020 21:24:19 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41623 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbgA0CYT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Jan 2020 21:24:19 -0500
Received: by mail-wr1-f67.google.com with SMTP id c9so9180756wrw.8
        for <git@vger.kernel.org>; Sun, 26 Jan 2020 18:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bpU6DY2yBf/PhQg/0Yqb8yJvMNlOTGihkhlJ4bzu1D0=;
        b=PtX964dPJcFL/Xua85uhe2SEYuHiviHoQn4CByYmKzYlh/sh06DLm4Sp1xb9BjXsAA
         Pa/n7cg2yy+6nKeTXsXqRP/dnPih/FUF2/5wtXUQI8JgF8bp0xfeMGrDFZpww+8XdxPm
         y8ase8K7r2wXZ62CwUmnOtZ3ox/ko9R4dirvZIo6AEFy4poqcOsQV7CDDLTY5Cqu8YrV
         QO7jZU4DkExbwLRmX1Tys2NTDnmXYNgySSMV9i8aqCDCaBtT5WIO+U0J1RqDNSC2qyqK
         Av3YM5Tdfj/JbP9cTKu3lsB9Rjwz/r7FurGhvvBOFXh6DsigAgGiO3Hhx6JCuMbcoEG/
         jAWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bpU6DY2yBf/PhQg/0Yqb8yJvMNlOTGihkhlJ4bzu1D0=;
        b=OCBe9wrsdohRnHEjn4TTDYGyNmQY9pDSl0AgU4IReyFdl91HalgkxaWCy8TFALRLkg
         leYblReo07L8Xua9wSiymms3ycJLyrSyOYq85+83owDp5WMA1uiyDnR5D3NhJTmSvGbr
         KCbHIUMTKGBgeIyFwGn4mrb+tEottRxgkhH6aHuPTCOjXRIJfFSMbayhmUI9U5Wc+Vz9
         fXRHiVl+wSA8NTPDpM/aiQq3wLJnXh8blW7BcuDqA3SahdbzJNlK42l8TkxzgizOzs/c
         SHSOXBrahi7K7g5zoMtpvajV/qOxL04o8vvvmIotUsKW07zzgMOA5W9nLX8J5fhJCveg
         5hDA==
X-Gm-Message-State: APjAAAXgsOJHL7gPlMoCTPq9jDZwJuvraYSvk5w8iD4erIdNOFDPCtKw
        1EMXK9Z/0MD3oD2JCAEDj+NUaspJ
X-Google-Smtp-Source: APXvYqw47wu/Shg+jkAFGUbvKHyG9/y6EUrECiy0MG67+ea9YLRXTdMMwsO83fUK406Cp9QPq29wTQ==
X-Received: by 2002:adf:eb0a:: with SMTP id s10mr17679086wrn.320.1580091856724;
        Sun, 26 Jan 2020 18:24:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p17sm18335088wrx.20.2020.01.26.18.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2020 18:24:16 -0800 (PST)
Message-Id: <pull.537.v2.git.1580091855792.gitgitgadget@gmail.com>
In-Reply-To: <pull.537.git.1579745811615.gitgitgadget@gmail.com>
References: <pull.537.git.1579745811615.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Jan 2020 02:24:15 +0000
Subject: [PATCH v2] git: update documentation for --git-dir
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Heba Waly <heba.waly@gmail.com>, Heba Waly <heba.waly@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Heba Waly <heba.waly@gmail.com>

git --git-dir <path> is a bit confusing and sometimes doesn't work as
the user would expect it to.

For example, if the user runs `git --git-dir=<path> status`, git
will skip the repository discovery algorithm and will assign the
work tree to the user's current work directory unless otherwise
specified. When this assignment is wrong, the output will not match
the user's expectations.

This patch updates the documentation to make it clearer.

Signed-off-by: Heba Waly <heba.waly@gmail.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
---
    [Outreachy] git: update documentation for --git-dir
    
    git --git-dir is a bit confusing and sometimes doesn't work as the user
    would expect it to.
    
    For example, if the user runs git --git-dir=<path> status, git will not
    be able to figure out the work tree path on its own and will assign the
    work tree to the user's current work directory. When this assignment is
    wrong, then the output will not match the user's expectations.
    
    This patch updates the documentation to make it clearer.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-537%2FHebaWaly%2Fgit_dir_doc-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-537/HebaWaly/git_dir_doc-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/537

Range-diff vs v1:

 1:  3ac4b85cdb ! 1:  8a69eecb97 git: update documentation for --git-dir
     @@ -6,14 +6,15 @@
          the user would expect it to.
      
          For example, if the user runs `git --git-dir=<path> status`, git
     -    will not be able to figure out the work tree path on its own and
     -    will assign the work tree to the user's current work directory.
     -    When this assignment is wrong, then the output will not match the
     -    user's expectations.
     +    will skip the repository discovery algorithm and will assign the
     +    work tree to the user's current work directory unless otherwise
     +    specified. When this assignment is wrong, the output will not match
     +    the user's expectations.
      
          This patch updates the documentation to make it clearer.
      
          Signed-off-by: Heba Waly <heba.waly@gmail.com>
     +    Helped-by: Junio C Hamano <gitster@pobox.com>
      
       diff --git a/Documentation/git.txt b/Documentation/git.txt
       --- a/Documentation/git.txt
     @@ -25,16 +26,23 @@
      -	Set the path to the repository. This can also be controlled by
      -	setting the `GIT_DIR` environment variable. It can be an absolute
      -	path or relative path to current working directory.
     --
     -+	Set the path to the repository (i.e. the .git folder). This can also be
     ++	Set the path to the repository (".git" directory). This can also be
      +	controlled by setting the `GIT_DIR` environment variable. It can be
      +	an absolute path or relative path to current working directory.
      +
     -+	Note that --git-dir=<path> is not the same as -C=<path>.
     -+	It's preferrable to set --work-tree=<path> as well when setting
     -+	--git-dir to make sure Git will run your command across the correct
     -+	work tree.
     -+	
     ++	Specifying the location of the ".git" directory using this
     ++	option (or GIT_DIR environment variable) turns off the
     ++	repository discovery that tries to find a directory with
     ++	".git" subdirectory (which is how the repository and the
     ++	top-level of the working tree are discovered), and tells Git
     ++	that you are at the top level of the working tree.  If you
     ++	are not at the top-level directory of the working tree, you
     ++	should tell Git where the top-level of the working tree is,
     ++	with the --work-tree=<path> option (or GIT_WORK_TREE
     ++	environment variable)
     ++
     ++	If you just want to run git as if it was started in <path> then use
     ++	git -C.
     + 
       --work-tree=<path>::
       	Set the path to the working tree. It can be an absolute path
     - 	or a path relative to the current working directory.


 Documentation/git.txt | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index b1597ac002..cf73f501b6 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -110,9 +110,23 @@ foo.bar= ...`) sets `foo.bar` to the empty string which `git config
 	Do not pipe Git output into a pager.
 
 --git-dir=<path>::
-	Set the path to the repository. This can also be controlled by
-	setting the `GIT_DIR` environment variable. It can be an absolute
-	path or relative path to current working directory.
+	Set the path to the repository (".git" directory). This can also be
+	controlled by setting the `GIT_DIR` environment variable. It can be
+	an absolute path or relative path to current working directory.
+
+	Specifying the location of the ".git" directory using this
+	option (or GIT_DIR environment variable) turns off the
+	repository discovery that tries to find a directory with
+	".git" subdirectory (which is how the repository and the
+	top-level of the working tree are discovered), and tells Git
+	that you are at the top level of the working tree.  If you
+	are not at the top-level directory of the working tree, you
+	should tell Git where the top-level of the working tree is,
+	with the --work-tree=<path> option (or GIT_WORK_TREE
+	environment variable)
+
+	If you just want to run git as if it was started in <path> then use
+	git -C.
 
 --work-tree=<path>::
 	Set the path to the working tree. It can be an absolute path

base-commit: 232378479ee6c66206d47a9be175e3a39682aea6
-- 
gitgitgadget
