Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A92E0C61DA4
	for <git@archiver.kernel.org>; Sun, 22 Jan 2023 06:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjAVGM6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Jan 2023 01:12:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjAVGMu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jan 2023 01:12:50 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D5D1814F
        for <git@vger.kernel.org>; Sat, 21 Jan 2023 22:12:48 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id z5so8116294wrt.6
        for <git@vger.kernel.org>; Sat, 21 Jan 2023 22:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=isyLaI5FrrfbWCFJGdKsB+gKlvvPyuhi6UTOdxtkXCc=;
        b=mpepJos11slS0QKh7uTlnFdTf6NCuEvYOlQYYeIp2LHqzekoc9243lsEzbE7Kqw2R4
         bus4AO1ZyZnZX635hzk+IasENYrmu1jqgrlrdFutmgHddNFsTigSFYq3NaZecO1C55iV
         KY1MvThVPLNS79cYbxGxwVtWTKyQPu9oSC+M7EiUnUA03gWhuK5m9N1eh+g10TxxqS28
         qkRj8g+oWacAL/ljwPqPrAfvByQ/322TiptzJgmqQq26iL0KZ7fk2OtTmfL1rSonUa/H
         NDlr1dcgzlMERnVLMpCGlzPtgpuekcJBL+oa7iJ/tLkro6CVCSDZmaWHpIQ2WmJTQDEd
         MN5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=isyLaI5FrrfbWCFJGdKsB+gKlvvPyuhi6UTOdxtkXCc=;
        b=f+3ZrtYHo2c/+HeHDcwXq9ZXdyNhV2NraThaaFdhKFPu/bqebdSN2o2jgWu6r/hx6N
         mxQ9gLru1EhO7Ihjlx9YWTKnwaV45Szzob28WCGyKHaYiAeJMvb7yrXcKVx/XFmaBmz1
         CPHRBLtOHjrhekqKV6pGzriEeloVThbDu7Caw4prUnC9eVkGA+F18IfKTgLsDt4sGnO9
         XgJXwnwqgDCB8NptM1JsvSbOxC81zzMe8ktjXw9bJEW73uaZcuK8S1zeLWIjgpA2g/io
         5I96OsXIL8INy3gOLyPqhOfhDk046Z9OF/dFNxvxwRxmX0zEXSDgb/sNHeefgsD6FfJy
         zz6Q==
X-Gm-Message-State: AFqh2krB5gi9AlTc+OtBi35hw70t5fHwkmnc5pr6Z8dvKkwBxzt4PhYE
        qiQinBqBTr5KiLjOy2il83ZjIEAmMpc=
X-Google-Smtp-Source: AMrXdXstA3qOGzDcAbLjPkFqtv+37X3R0qFdmnl+XSm3QL00HMT30y9oKKjiKbuNhc2SknqwGfXA0w==
X-Received: by 2002:adf:f4cf:0:b0:2bf:95c0:6b30 with SMTP id h15-20020adff4cf000000b002bf95c06b30mr5342100wrp.31.1674367967227;
        Sat, 21 Jan 2023 22:12:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w7-20020adfd4c7000000b002baa780f0fasm1923835wrk.111.2023.01.21.22.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 22:12:46 -0800 (PST)
Message-Id: <21ae9e053131a9a5f0ddb13fba4bf6502a1d19a6.1674367961.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1466.v4.git.1674367961.gitgitgadget@gmail.com>
References: <pull.1466.v3.git.1674266126.gitgitgadget@gmail.com>
        <pull.1466.v4.git.1674367961.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 22 Jan 2023 06:12:37 +0000
Subject: [PATCH v4 6/9] rebase: clarify the OPT_CMDMODE incompatibilities
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
index 8cb075b2bdb..1ba691e4c5f 100644
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
  * --[no-]reapply-cherry-picks
- * --edit-todo
  * --update-refs
  * --root when used without --onto
 
-- 
gitgitgadget

