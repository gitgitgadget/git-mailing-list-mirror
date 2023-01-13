Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68721C54EBD
	for <git@archiver.kernel.org>; Fri, 13 Jan 2023 04:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbjAMEmE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 23:42:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbjAMEl7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 23:41:59 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A1E3B902
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 20:41:58 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id ay40so14516140wmb.2
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 20:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=96Sk0OAcfjNJwx4P2tNxc+jOgawu4jEuKBlAZKgJfnU=;
        b=QP7QSlOpZlUbJTaKiqR72O4EmT0cZRg8Wv/onT/CzukQYlrYxZ6pvKJuWlt8ts9XYl
         J529zgsWjqW6sS0siGJsN0RJnly8ZhbqGajcF2iVNG3Rz3odoEzpDxjZJqZL4I557tNX
         zR6tvGQxjfti1D5W/gSoOmsunu9LFb0qGRpfhphyHJ97cSRBGEafCTBit6jUBOWfODcn
         D7HycyqXvy6KFHi4Ggem70XVFI9wG14ROgawWlc8fMrk9c9CFdoPGuIu5MlOdOH1C4ny
         yoYSsaf5wfy9xJhjutaDvQ0iOSvyYwj1tFDcuUNU8Rwyx5Cs0njwRoN1RRsSXB2qYxco
         tgRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=96Sk0OAcfjNJwx4P2tNxc+jOgawu4jEuKBlAZKgJfnU=;
        b=6jX+tGUglW63PVKo29cRRKy43Axm0cDAXp0kJAvwThATK4vn9g00vLWdJQU1ZkLBpR
         MCxIDenNlCMAPBGwuY1RDwyy0hRzUqipkbDG+hYj9C0x9xEaBCq9SUb0UW3GwQLZLGOH
         v5At3efD168BqQGRiXQzUVzGFzkFPTwV0d4wQc3lCn9zEjBeR5AzbJGtjtlvKulFD+N/
         n8JrLTuhBPZ80D/AFt9N+YPRYbYU/eJjtEmWmvA4wFZdDwpW6eCFrxBJ2ttEp8UTAlHk
         Uoezawi6hYveKimJJIDTO1Nad1uSKWLrkdqHObARJFTSG/9dxmRDwnnRht7z/hkmEea7
         tVPw==
X-Gm-Message-State: AFqh2koQoxQsqt4lsERSR/jjabFfl0OilKvYyAYRt8WDuiS9mdJV48Br
        1uirCfnSJow/TB+/UHvIVCF5+x+lw5A=
X-Google-Smtp-Source: AMrXdXuVe7oymMhXEvEk2aquOrdXs5vzlgNPS+adDx1vC/FkaEl/kyR0q3g2tR69La/ZqCKTovlDBw==
X-Received: by 2002:a05:600c:19cb:b0:3da:db4:6105 with SMTP id u11-20020a05600c19cb00b003da0db46105mr5906699wmq.37.1673584917170;
        Thu, 12 Jan 2023 20:41:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i8-20020a05600c354800b003cf894dbc4fsm25712140wmq.25.2023.01.12.20.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 20:41:56 -0800 (PST)
Message-Id: <1d1330243109d499d1c07f6518265b2e163406ef.1673584914.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1463.git.1673584914.gitgitgadget@gmail.com>
References: <pull.1463.git.1673584914.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 13 Jan 2023 04:41:52 +0000
Subject: [PATCH 2/4] ls-files: clarify descriptions of file selection options
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     ZheNing Hu <adlternative@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

The previous descriptions of the file selection options were very easy
to misunderstand.  For example:

  * "Show cached files in the output"
    This could be interpreted as meaning "show files which have been
    modified and git-add'ed, i.e. files which have cached changes
    relative to HEAD".

  * "Show deleted files"
    This could be interpreted as meaning "for each `git rm $FILE` we
    ran, show me $FILE"

  * "Show modified files"
    This could be interpreted as meaning "show files which have been
    modified and git-add'ed" or as "show me files that differ from HEAD"
    or as "show me undeleted files different from HEAD" (given that
    --deleted is a separate option), none of which are correct.

Further, it's not very clear when some options only modify and/or
override other options, as was the case with --ignored, --directory, and
--unmerged (I've seen folks confused by each of them on the mailing
list, sometimes even fellow git developers.)

Tweak these definitions, and the one for --killed, to try to make them
all a bit more clear.  Finally, also clarify early on that duplicate
reports for paths are often expected (both when (a) there are multiple
entries for the file in the index -- i.e. when there are conflicts, and
also (b) when the user specifies options that might pick the same file
multiple times, such as `git ls-files --cached --deleted --modified`
when there is a file with an unstaged deletion).

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-ls-files.txt | 37 ++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index cb071583f8b..f89ab1bfc98 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -29,21 +29,26 @@ This merges the file listing in the index with the actual working
 directory list, and shows different combinations of the two.
 
 One or more of the options below may be used to determine the files
-shown:
+shown, and each file may be printed multiple times if there are
+multiple entries in the index or multiple statuses are applicable for
+the relevant file selection options.
 
 OPTIONS
 -------
 -c::
 --cached::
-	Show cached files in the output (default)
+	Show all files cached in Git's index, i.e. all tracked files.
+	(This is the default if no -c/-s/-d/-o/-u/-k/-m/--resolve-undo
+	options are specified.)
 
 -d::
 --deleted::
-	Show deleted files in the output
+	Show files with an unstaged deletion
 
 -m::
 --modified::
-	Show modified files in the output
+	Show files with an unstaged modification (note that an unstaged
+	deletion also counts as an unstaged modification)
 
 -o::
 --others::
@@ -51,11 +56,14 @@ OPTIONS
 
 -i::
 --ignored::
-	Show only ignored files in the output. When showing files in the
-	index, print only those matched by an exclude pattern. When
-	showing "other" files, show only those matched by an exclude
-	pattern. Standard ignore rules are not automatically activated,
-	therefore at least one of the `--exclude*` options is required.
+	Show only ignored files in the output.  Must be used with
+	either an explicit '-c' or '-o'.  When showing files in the
+	index (i.e. when used with '-c'), print only those files
+	matching an exclude pattern.  When showing "other" files
+	(i.e. when used with '-o'), show only those matched by an
+	exclude pattern.  Standard ignore rules are not automatically
+	activated, therefore at least one of the `--exclude*` options
+	is required.
 
 -s::
 --stage::
@@ -64,19 +72,22 @@ OPTIONS
 --directory::
 	If a whole directory is classified as "other", show just its
 	name (with a trailing slash) and not its whole contents.
+	Has no effect without -o/--others.
 
 --no-empty-directory::
 	Do not list empty directories. Has no effect without --directory.
 
 -u::
 --unmerged::
-	Show unmerged files in the output (forces --stage)
+	Show information about unmerged files in the output, but do
+	not show any other tracked files (forces --stage, overrides
+	--cached).
 
 -k::
 --killed::
-	Show files on the filesystem that need to be removed due
-	to file/directory conflicts for checkout-index to
-	succeed.
+	Show untracked files on the filesystem that need to be removed
+	due to file/directory conflicts for tracked files to be able to
+	be written to the filesystem.
 
 --resolve-undo::
 	Show files having resolve-undo information in the index
-- 
gitgitgadget

