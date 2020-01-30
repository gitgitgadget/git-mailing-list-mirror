Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C3E3C33CB2
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 01:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8CAE206A2
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 01:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KgQIOYbr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbgA3BOH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jan 2020 20:14:07 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55397 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbgA3BOG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jan 2020 20:14:06 -0500
Received: by mail-wm1-f68.google.com with SMTP id q9so1865569wmj.5
        for <git@vger.kernel.org>; Wed, 29 Jan 2020 17:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dBHUmExJxpXxduZ051ToZVRmbby+zjSAf+3BnPTfANM=;
        b=KgQIOYbrMKbJ2qMG7jCMysqnmICMo2xtfid2MgSE9HSQa18mWtxmiykh7ejlaInSul
         CeDbP225FXcxcQIvVmQlv0g4xf8ayeQu7T8e5Tj6FfhBx9fa5jh+zHywT5qLeIbYYEPU
         EMGFSFGLmtKs+b3q2zl3HsqqngO5I1V9iNnQAJfN9X3iT+ojYGzv7PbmLxwCQfgmWSmm
         VWKVNWs5u1BMEaVlMyL4N9518jUDcVIutK/N5evNvK+jXPPlKuN+ezM9GrSsHhRbvea1
         4DfFIf6waaeYls0ZFMzjdwohuubOMkFzbII2xBDQK5zTBGznM6nvMMxSWRp4Wmx+ypnj
         CeOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dBHUmExJxpXxduZ051ToZVRmbby+zjSAf+3BnPTfANM=;
        b=aVpwNlKAZydb0+Y34BsUTW4eTQhXJd/QNMb2emTgIQhRBnhOPHn44/Y79braoJRTp7
         akVCvGp8zQWUoA2FtZtPYhhigadyS5wAOrcQmIrr8nwdioc5R/qC36t93kkY7EJP/ck0
         QYElUZ/ae04VF1tR7ktOthCRAtRZMW1e6JnNKZIYVjzjGxHSf6Rj81zrqsslibInmAG/
         XDkMBb/aURrav1k7VaHHD2JUOAOBCqvlftwldBG9taHcU3BIGknFS/lQ41gWxlmTqlhV
         VRkYU3orgDm9MvexDIUcFLhTmzMNHtfzoT5dk2CB7ZjkhmuC/xRVVVgYh8s8vquM3lDN
         gcTw==
X-Gm-Message-State: APjAAAW/kWNrgS9pKEHGjDS0BLs12ixLGA9VYwjobgDOyblRzt/CNEqw
        FsKIMEVo6MjtfeMhwIJ/cArD4pOt
X-Google-Smtp-Source: APXvYqwveYU7eyguHx09kiDm83ocp+TCyeDzisFYWmP3m9HmwautOoY3ySo+mf7U5Mx4XRFUfD+UgQ==
X-Received: by 2002:a1c:80d4:: with SMTP id b203mr2049905wmd.102.1580346842667;
        Wed, 29 Jan 2020 17:14:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u1sm4222429wmc.5.2020.01.29.17.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 17:14:02 -0800 (PST)
Message-Id: <pull.537.v4.git.1580346841614.gitgitgadget@gmail.com>
In-Reply-To: <pull.537.v3.git.1580185440512.gitgitgadget@gmail.com>
References: <pull.537.v3.git.1580185440512.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 30 Jan 2020 01:14:01 +0000
Subject: [PATCH v4] git: update documentation for --git-dir
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
    
    For example, if the user runs git --git-dir=<path> status, git will skip
    the repository discovery algorithm and will assign the work tree to the
    user's current work directory unless otherwise specified. When this
    assignment is wrong, the output will not match the user's expectations.
    
    This patch updates the documentation to make it clearer.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-537%2FHebaWaly%2Fgit_dir_doc-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-537/HebaWaly/git_dir_doc-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/537

Range-diff vs v3:

 1:  2a1404f1b3 ! 1:  e27f150c4b git: update documentation for --git-dir
     @@ -31,18 +31,18 @@
      +	an absolute path or relative path to current working directory.
      ++
      +Specifying the location of the ".git" directory using this
     -+option (or GIT_DIR environment variable) turns off the
     ++option (or `GIT_DIR` environment variable) turns off the
      +repository discovery that tries to find a directory with
      +".git" subdirectory (which is how the repository and the
      +top-level of the working tree are discovered), and tells Git
      +that you are at the top level of the working tree.  If you
      +are not at the top-level directory of the working tree, you
      +should tell Git where the top-level of the working tree is,
     -+with the --work-tree=<path> option (or GIT_WORK_TREE
     ++with the `--work-tree=<path>` option (or `GIT_WORK_TREE`
      +environment variable)
      ++
     -+If you just want to run git as if it was started in <path> then use
     -+git -C.
     ++If you just want to run git as if it was started in `<path>` then use
     ++`git -C <path>`.
       
       --work-tree=<path>::
       	Set the path to the working tree. It can be an absolute path


 Documentation/git.txt | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index b1597ac002..41374f24fa 100644
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
+option (or `GIT_DIR` environment variable) turns off the
+repository discovery that tries to find a directory with
+".git" subdirectory (which is how the repository and the
+top-level of the working tree are discovered), and tells Git
+that you are at the top level of the working tree.  If you
+are not at the top-level directory of the working tree, you
+should tell Git where the top-level of the working tree is,
+with the `--work-tree=<path>` option (or `GIT_WORK_TREE`
+environment variable)
++
+If you just want to run git as if it was started in `<path>` then use
+`git -C <path>`.
 
 --work-tree=<path>::
 	Set the path to the working tree. It can be an absolute path

base-commit: 232378479ee6c66206d47a9be175e3a39682aea6
-- 
gitgitgadget
