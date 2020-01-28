Return-Path: <SRS0=aR3Y=3R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 782ADC33CB3
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 04:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3783E22522
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 04:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jltu0em/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgA1EYE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jan 2020 23:24:04 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50799 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgA1EYE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jan 2020 23:24:04 -0500
Received: by mail-wm1-f65.google.com with SMTP id a5so1016054wmb.0
        for <git@vger.kernel.org>; Mon, 27 Jan 2020 20:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YhQYuJGw1wu9Jhqcq5VsUSfpNdmdBmeWIAKTrW8vJSg=;
        b=Jltu0em/3kHJwFxXCVfLEgb8DrjQgcx5fJOkc4is8PxZw43ARHEenBHMmKCXGoQhOu
         VqVop09zabIkupBzKHcO7zJ1wV27wYuemVTvKPyKfGTuDREs5++XpqFElkxEDEu4lx3+
         85JY+DndYErjL/V+SgAloufi0dTsgUGdHcV8reZEaiECYbYMP6Rs5l4WnkKr8qqQuDFv
         Ltn8BJsLfGKms4Uw679/fIGBpIhcfQMHDPaupHUtlO78f36uApVt1cqCtwSC9mXuT/bY
         kpkIWSJwzvu3A8z65sx35kAYjfs5NvYZurWTgCA+7/6We9ZqtdcEx2aXj/IY2uM3uljP
         kaZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YhQYuJGw1wu9Jhqcq5VsUSfpNdmdBmeWIAKTrW8vJSg=;
        b=B097fr1xTJ7OTARGmeHx75a0Q6G+GC4sIrnDUk+LFiY+4jpeNphfhHTGMcB0zt+mGy
         zXP8u5PpHyfUtQtpxYCK2KojVyTaVzslN2od962iCp5BZQWrpGmrgHtRMnCTj+VLDysf
         GMWYB8g4eFbKKXi6kXjFNt9QgpsurblN+lQxx2CZ5d71+6lgBxDgB082SRwIrP8xwkVT
         XbCq7izl1tsXlMgqhn6jNZdgpr6yjy7BgCZrZ7EATg4QN+Bf9s6gQKoky7Tv10PiqAB8
         CM5KCrIdfmqryG4KlOLCeMzvG2seKVgITtTRk/fBQljTUtH0EB4lOWtV1E519a2PdCxO
         /DuA==
X-Gm-Message-State: APjAAAWkFmEIbf7Irv4gihFD6JiP8S0zUUYspHtB+tn/JarU4vFmVpiJ
        HzLFHlu4P/I3XuANmWxbTZvipnJ1
X-Google-Smtp-Source: APXvYqyIv42sJUpFiyL86F7LLrN6saU9IV8GO/M3iNB0O33FlVAqlU+qNO3jzMEz3Pcdb0qUxiDXwA==
X-Received: by 2002:a1c:80d4:: with SMTP id b203mr2359852wmd.102.1580185441458;
        Mon, 27 Jan 2020 20:24:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5sm24887886wrh.5.2020.01.27.20.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 20:24:01 -0800 (PST)
Message-Id: <pull.537.v3.git.1580185440512.gitgitgadget@gmail.com>
In-Reply-To: <pull.537.v2.git.1580091855792.gitgitgadget@gmail.com>
References: <pull.537.v2.git.1580091855792.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 28 Jan 2020 04:24:00 +0000
Subject: [PATCH v3] git: update documentation for --git-dir
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-537%2FHebaWaly%2Fgit_dir_doc-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-537/HebaWaly/git_dir_doc-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/537

Range-diff vs v2:

 1:  8a69eecb97 ! 1:  2a1404f1b3 git: update documentation for --git-dir
     @@ -29,20 +29,20 @@
      +	Set the path to the repository (".git" directory). This can also be
      +	controlled by setting the `GIT_DIR` environment variable. It can be
      +	an absolute path or relative path to current working directory.
     -+
     -+	Specifying the location of the ".git" directory using this
     -+	option (or GIT_DIR environment variable) turns off the
     -+	repository discovery that tries to find a directory with
     -+	".git" subdirectory (which is how the repository and the
     -+	top-level of the working tree are discovered), and tells Git
     -+	that you are at the top level of the working tree.  If you
     -+	are not at the top-level directory of the working tree, you
     -+	should tell Git where the top-level of the working tree is,
     -+	with the --work-tree=<path> option (or GIT_WORK_TREE
     -+	environment variable)
     -+
     -+	If you just want to run git as if it was started in <path> then use
     -+	git -C.
     +++
     ++Specifying the location of the ".git" directory using this
     ++option (or GIT_DIR environment variable) turns off the
     ++repository discovery that tries to find a directory with
     ++".git" subdirectory (which is how the repository and the
     ++top-level of the working tree are discovered), and tells Git
     ++that you are at the top level of the working tree.  If you
     ++are not at the top-level directory of the working tree, you
     ++should tell Git where the top-level of the working tree is,
     ++with the --work-tree=<path> option (or GIT_WORK_TREE
     ++environment variable)
     +++
     ++If you just want to run git as if it was started in <path> then use
     ++git -C.
       
       --work-tree=<path>::
       	Set the path to the working tree. It can be an absolute path


 Documentation/git.txt | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index b1597ac002..c21e33aa10 100644
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
++
+Specifying the location of the ".git" directory using this
+option (or GIT_DIR environment variable) turns off the
+repository discovery that tries to find a directory with
+".git" subdirectory (which is how the repository and the
+top-level of the working tree are discovered), and tells Git
+that you are at the top level of the working tree.  If you
+are not at the top-level directory of the working tree, you
+should tell Git where the top-level of the working tree is,
+with the --work-tree=<path> option (or GIT_WORK_TREE
+environment variable)
++
+If you just want to run git as if it was started in <path> then use
+git -C.
 
 --work-tree=<path>::
 	Set the path to the working tree. It can be an absolute path

base-commit: 232378479ee6c66206d47a9be175e3a39682aea6
-- 
gitgitgadget
