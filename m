Return-Path: <SRS0=dWK1=36=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5528C352A4
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 14:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE0C320873
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 14:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kFjMqDgu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728888AbgBJOp5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Feb 2020 09:45:57 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39990 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728738AbgBJOpw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Feb 2020 09:45:52 -0500
Received: by mail-wm1-f67.google.com with SMTP id t14so621917wmi.5
        for <git@vger.kernel.org>; Mon, 10 Feb 2020 06:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lWNe8ZOU5ZJwdci14t4PB6WCJ/g25rTTh2vF6pXDOIc=;
        b=kFjMqDguKUun3TRrgjd5KYp1HvHeiZcK+7LlMJTblFtazPwHeOM40+0JegD2rX54rE
         T2piZ/9RnHxKC1iNy8GhIEH1hruvelrMExEFW86dr/98yftYnH8aaECo5+3dnEkxSJL+
         YqACCwsMyrbsEfeo2wX3BQ4j4sIuYYr7u+gheAGs5ecUpQmmjQJJfz/1NSy8ERPZxAbY
         rjs3sjC0d5NoZZ8fCPcTBLlL4ZCJQqJ640IDjLdrvPL2EpfrbVuVZ9KiCJvIvlzab/zh
         S/gRiy5+l68IofuXtjMTrKxVrtMF7rEDkgtDCjgli/rCMt4/udmPVSJnJBOZtoXaOsfC
         2Cpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lWNe8ZOU5ZJwdci14t4PB6WCJ/g25rTTh2vF6pXDOIc=;
        b=QaJfEQXIe0ZGXdJtjl0EPXbECwSsrGIsRu1jJ6IDNiSGXVyABrYmDVlBDeiT4TQglx
         PPShB3JVXhex1pE99+YwooE54lNw3ocptKBTrZBDtr/C+c3QUl03JwgFgBhi4vY5E6Ys
         I82wMkm1KaUzM1N5uIpdhn01fmJGRL7mHguN9jZ9KmoIz2WnnWsHD4viLsL2uXlSH413
         870x9ubv2cnBweWMGgXJnQ69EkZEEzdUVilFjl7qXSaPR5dRmHd/Gn8J5c/JK5WPttQp
         dfDOdBajvVGMiblpI8EemflT1O6af/o3EUbp1AfKTJ2kpWexDXimURHirMJTIP5Ii4mX
         5oyQ==
X-Gm-Message-State: APjAAAWkRjzaAMjXrgSGIuEJjmZC9tEJDOFfExf6D4P/I+BDX8OZqVS7
        re+sRxaNqrAD1UoiZ1H7TrqKhMJb
X-Google-Smtp-Source: APXvYqx3+FuDj21WxM+KjtLXU3sLvGSXFpbx43EVN0LjXRea9zAjwdFkZqSZovIYobXdzdabZ1jFbQ==
X-Received: by 2002:a7b:c1d0:: with SMTP id a16mr15749960wmj.175.1581345950247;
        Mon, 10 Feb 2020 06:45:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e17sm727409wrn.62.2020.02.10.06.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 06:45:49 -0800 (PST)
Message-Id: <2e8c8ad8158aae391b485394868a8c2a48d5118d.1581345948.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.530.v2.git.1581345948.gitgitgadget@gmail.com>
References: <pull.530.git.1579190965.gitgitgadget@gmail.com>
        <pull.530.v2.git.1581345948.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 10 Feb 2020 14:45:40 +0000
Subject: [PATCH v2 1/8] doc: rm: synchronize <pathspec> description
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>

This patch continues the effort that is already applied to
`git commit`, `git reset`, `git checkout` etc.

1) Changed outdated descriptions to mention pathspec instead.
2) Added reference to 'linkgit:gitglossary[7]'.
3) Removed content that merely repeated gitglossary.
4) Merged the remainder of "discussion" into `<patchspec>`.

Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 Documentation/git-rm.txt | 50 +++++++++++++++++-----------------------
 1 file changed, 21 insertions(+), 29 deletions(-)

diff --git a/Documentation/git-rm.txt b/Documentation/git-rm.txt
index b5c46223c4..e02a08e5ef 100644
--- a/Documentation/git-rm.txt
+++ b/Documentation/git-rm.txt
@@ -8,16 +8,16 @@ git-rm - Remove files from the working tree and from the index
 SYNOPSIS
 --------
 [verse]
-'git rm' [-f | --force] [-n] [-r] [--cached] [--ignore-unmatch] [--quiet] [--] <file>...
+'git rm' [-f | --force] [-n] [-r] [--cached] [--ignore-unmatch] [--quiet] [--] <pathspec>...
 
 DESCRIPTION
 -----------
-Remove files from the index, or from the working tree and the index.
-`git rm` will not remove a file from just your working directory.
-(There is no option to remove a file only from the working tree
-and yet keep it in the index; use `/bin/rm` if you want to do that.)
-The files being removed have to be identical to the tip of the branch,
-and no updates to their contents can be staged in the index,
+Remove files matching pathspec from the index, or from the working tree
+and the index. `git rm` will not remove a file from just your working
+directory. (There is no option to remove a file only from the working
+tree and yet keep it in the index; use `/bin/rm` if you want to do
+that.) The files being removed have to be identical to the tip of the
+branch, and no updates to their contents can be staged in the index,
 though that default behavior can be overridden with the `-f` option.
 When `--cached` is given, the staged content has to
 match either the tip of the branch or the file on disk,
@@ -26,15 +26,20 @@ allowing the file to be removed from just the index.
 
 OPTIONS
 -------
-<file>...::
-	Files to remove.  Fileglobs (e.g. `*.c`) can be given to
-	remove all matching files.  If you want Git to expand
-	file glob characters, you may need to shell-escape them.
-	A leading directory name
-	(e.g. `dir` to remove `dir/file1` and `dir/file2`) can be
-	given to remove all files in the directory, and recursively
-	all sub-directories,
-	but this requires the `-r` option to be explicitly given.
+<pathspec>...::
+	Files to remove.  A leading directory name (e.g. `dir` to remove
+	`dir/file1` and `dir/file2`) can be given to remove all files in
+	the directory, and recursively all sub-directories, but this
+	requires the `-r` option to be explicitly given.
++
+The command removes only the paths that are known to Git.
++
+File globbing matches across directory boundaries.  Thus, given two
+directories `d` and `d2`, there is a difference between using
+`git rm 'd*'` and `git rm 'd/*'`, as the former will also remove all
+of directory `d2`.
++
+For more details, see the 'pathspec' entry in linkgit:gitglossary[7].
 
 -f::
 --force::
@@ -69,19 +74,6 @@ OPTIONS
 	for each file removed. This option suppresses that output.
 
 
-DISCUSSION
-----------
-
-The <file> list given to the command can be exact pathnames,
-file glob patterns, or leading directory names.  The command
-removes only the paths that are known to Git.  Giving the name of
-a file that you have not told Git about does not remove that file.
-
-File globbing matches across directory boundaries.  Thus, given
-two directories `d` and `d2`, there is a difference between
-using `git rm 'd*'` and `git rm 'd/*'`, as the former will
-also remove all of directory `d2`.
-
 REMOVING FILES THAT HAVE DISAPPEARED FROM THE FILESYSTEM
 --------------------------------------------------------
 There is no option for `git rm` to remove from the index only
-- 
gitgitgadget

