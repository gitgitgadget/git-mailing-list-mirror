Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 199AEC54E94
	for <git@archiver.kernel.org>; Wed, 25 Jan 2023 04:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234572AbjAYEEX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Jan 2023 23:04:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233948AbjAYEEL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2023 23:04:11 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40AA49571
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 20:04:04 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id e19-20020a05600c439300b003db1cac0c1fso375193wmn.5
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 20:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j7RF0qTOfHHMDu60U4Twpx8Fq0h2vhCI+J671zGZT5Y=;
        b=drjZeukjxcYUwNy5Rr3Y3wiLiNmlUJuw4ZME/2je9d6FVJuicAJK3lzXJdg+Hyefc2
         YOlAH2m/K6dWaIFgcQRXu3OG5m+nztZfDKSqDYnZjVctGI64MAzA12E+G4hp0j8D2EF8
         OnV2NiQbM/Wiyfmpcvmc6WiCqO4aqdGrCtrZWfyzHyPy/6uiCybMJTR2qyWUdcUbFMRF
         EY2LZ0VRvel4XK59DBZMXm8cQQoxIYnshs4ovrAQkdmi9X9w8r8ms/7FSFsViyUm6C0b
         B+plJrdKIy3lpyRimRyz5/PQDuvYX4KQJLOasJjjqs0cn/SZk89UWCljCViKuIiVyTmx
         LVJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j7RF0qTOfHHMDu60U4Twpx8Fq0h2vhCI+J671zGZT5Y=;
        b=p1JZzw1Xz/8u92u7unEFO/5Y9CJM4XnTHmwSWjJ9fIKpF/5i0gNN7nQNeeNNRhLCp0
         E7WYer44fpCetewQwPtgbpF4PQAlzaugj2zBPVtfA5XDYGgh1WYmbIG0gsp3hGAmAsTR
         l0vbYxHYqogAkfGUQUtB+HDn6xscwu53QTGGFjKC3WYX5RkDVxmdCzcnSbn/YLF7RBDI
         zlHEqj5YxLmThnnxf0EdeCRwAdtPlBdg0LBYkt84daA2qisLTSFYllCznJA4lgSEvPn5
         d9QwuLrP62ZDgUdr5PBVpsQ5nTaM2CRpicLFZGqsfVIaEuGQyhGPj7RsQdmLTKy/73kj
         pNdQ==
X-Gm-Message-State: AFqh2krQo9Bc46CIGDJk55MbG+LcZyskcFt8g72/D1YjT2MVHninYqlq
        kdtXCyzLa5K7GB3i2gh4jjbGiWdgAt0=
X-Google-Smtp-Source: AMrXdXtEkawgCpfoEdRHp1tZkeR7WRHon/uGaCEXsVArkU2zEjn09wdsgXyh6b+bVutOkz4KDZ29NQ==
X-Received: by 2002:a05:600c:34d0:b0:3db:2647:a012 with SMTP id d16-20020a05600c34d000b003db2647a012mr21270287wmq.40.1674619443347;
        Tue, 24 Jan 2023 20:04:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i11-20020a05600c2d8b00b003db305bece4sm501298wmg.45.2023.01.24.20.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 20:04:03 -0800 (PST)
Message-Id: <0d0541ea243faaf8ae9df80f7caf64a8e7f80292.1674619434.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1466.v5.git.1674619434.gitgitgadget@gmail.com>
References: <pull.1466.v4.git.1674367961.gitgitgadget@gmail.com>
        <pull.1466.v5.git.1674619434.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 25 Jan 2023 04:03:51 +0000
Subject: [PATCH v5 07/10] rebase: clarify the OPT_CMDMODE incompatibilities
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

--edit-todo was documented as being incompatible with any of the options
for the apply backend.  However, it is also incompatible with any of the
options for the merge backend, and is incompatible with any options that
are not backend specific as well.  The same can be said for --continue,
--skip, --abort, --quit, etc.

This is already somewhat implicitly covered by the synopsis, but since
"[<options>]" in the first two variants are vague it might be easy to
miss this.  That might not be a big deal, but since the rebase manpage
has to spend so much verbiage about incompatibility of options, making
a separate section for these options that are incompatible with
everything else seems clearer.  Do that, and remove the needless
inclusion of --edit-todo in the explicit incompatibility list.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-rebase.txt | 61 +++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 28 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 8a09f12d897..d2b731bd605 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -208,6 +208,39 @@ Alternatively, you can undo the 'git rebase' with
 
     git rebase --abort
 
+MODE OPTIONS
+------------
+
+The options in this section cannot be used with any other option,
+including not with each other:
+
+--continue::
+	Restart the rebasing process after having resolved a merge conflict.
+
+--skip::
+	Restart the rebasing process by skipping the current patch.
+
+--abort::
+	Abort the rebase operation and reset HEAD to the original
+	branch. If `<branch>` was provided when the rebase operation was
+	started, then `HEAD` will be reset to `<branch>`. Otherwise `HEAD`
+	will be reset to where it was when the rebase operation was
+	started.
+
+--quit::
+	Abort the rebase operation but `HEAD` is not reset back to the
+	original branch. The index and working tree are also left
+	unchanged as a result. If a temporary stash entry was created
+	using `--autostash`, it will be saved to the stash list.
+
+--edit-todo::
+	Edit the todo list during an interactive rebase.
+
+--show-current-patch::
+	Show the current patch in an interactive rebase or when rebase
+	is stopped because of conflicts. This is the equivalent of
+	`git show REBASE_HEAD`.
+
 OPTIONS
 -------
 --onto <newbase>::
@@ -249,22 +282,6 @@ See also INCOMPATIBLE OPTIONS below.
 <branch>::
 	Working branch; defaults to `HEAD`.
 
---continue::
-	Restart the rebasing process after having resolved a merge conflict.
-
---abort::
-	Abort the rebase operation and reset HEAD to the original
-	branch. If `<branch>` was provided when the rebase operation was
-	started, then `HEAD` will be reset to `<branch>`. Otherwise `HEAD`
-	will be reset to where it was when the rebase operation was
-	started.
-
---quit::
-	Abort the rebase operation but `HEAD` is not reset back to the
-	original branch. The index and working tree are also left
-	unchanged as a result. If a temporary stash entry was created
-	using `--autostash`, it will be saved to the stash list.
-
 --apply::
 	Use applying strategies to rebase (calling `git-am`
 	internally).  This option may become a no-op in the future
@@ -345,17 +362,6 @@ See also INCOMPATIBLE OPTIONS below.
 +
 See also INCOMPATIBLE OPTIONS below.
 
---skip::
-	Restart the rebasing process by skipping the current patch.
-
---edit-todo::
-	Edit the todo list during an interactive rebase.
-
---show-current-patch::
-	Show the current patch in an interactive rebase or when rebase
-	is stopped because of conflicts. This is the equivalent of
-	`git show REBASE_HEAD`.
-
 -m::
 --merge::
 	Using merging strategies to rebase (default).
@@ -651,7 +657,6 @@ are incompatible with the following options:
  * --no-keep-empty
  * --empty=
  * --[no-]reapply-cherry-picks when used without --keep-base
- * --edit-todo
  * --update-refs
  * --root when used without --onto
 
-- 
gitgitgadget

