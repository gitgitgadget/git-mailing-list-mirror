Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87AABC27C76
	for <git@archiver.kernel.org>; Sat, 21 Jan 2023 01:55:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjAUBzr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Jan 2023 20:55:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjAUBzl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2023 20:55:41 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E43F80BA1
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 17:55:34 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id c10-20020a05600c0a4a00b003db0636ff84so4909469wmq.0
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 17:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iU/zm+ehbTRPkGabk6P07mnqrKUVBXehfmYvbw2TnME=;
        b=X5ZyU1e7iYQqFrOCrfVDvrstlj4u+Ko+N+g8h2Gdp/Ohhylq93TQJvp0PeHHPDW2BA
         aSEAVWwJ4jYHbQszCtgeHIEohf4WYDF83vUZ0qH2SwZsE5wgibxMNCFNQb1YGprwKkUj
         lWJisnpye/my0Fsef8r40DPWUyEC6t8P8yqDKEI3CPQC/s/rxt0MCBBPFqHPNDnq7vBq
         g5oteyB7YdpkV7MQT8/IQa+lQnsruoYka/JNlK4beP6PihrLgmZo35jjx1lzWt2SZWJz
         09QVN4AkOGUU9YLK3/LkYGh6N4jlYf21o51ZciURJJ47Yy3bj9lJ2xo3bT1QdcYojN3F
         NLxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iU/zm+ehbTRPkGabk6P07mnqrKUVBXehfmYvbw2TnME=;
        b=3TS1X0p6vGgbNeD7Fayfz+Ohb1LdRDEvwUs9JapEfNOgLzcF95SZzeKxi45gXsH0o5
         rf0eoUgfnfq4vvr3txhXnOvMeo8kTj7NaVwNtFGUC5cYWzg2IKhhRqydzzrOxKXC1oLa
         +0o9XKgS+S6VJOKKv3/0MmdcyyZ8MHA8pooElNzzE0Wt3Ia49ZeS+n7wPyZHWoMf5zwD
         UTX47X/EOQ7OHiP/bbTIesq+beUnyb8dIjOP+R83Cf9JPdwq7HYoFm6q9kR7OvhQxYe1
         Pp8Xt6TrVCKSAixWTIheBHNiUE+ga0q1miCVuMGQboXkiaM8ktX3PHHFUuNF5U/CUmx3
         Y6NQ==
X-Gm-Message-State: AFqh2korB5zXAxxDCORvsajJt6MUu0VG1ylc6NOCapSQ2whuTezb4g12
        HbKNWpOsHV8ukPlltsVguK8s/5NIZXA=
X-Google-Smtp-Source: AMrXdXsJZkPRscTLXHOAB5Fb/7s/ghhYX1gQaKANR+C8cyeP0jqJH9j6xzJxMjcDUPu63+ilHN2UWQ==
X-Received: by 2002:a05:600c:35d4:b0:3db:3694:b93c with SMTP id r20-20020a05600c35d400b003db3694b93cmr3315946wmq.15.1674266132756;
        Fri, 20 Jan 2023 17:55:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o6-20020a05600c378600b003d9fba3c7a4sm3780797wmr.16.2023.01.20.17.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 17:55:32 -0800 (PST)
Message-Id: <8664cce6cf7f42850176d852b5f866bf70e6ce07.1674266126.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1466.v3.git.1674266126.gitgitgadget@gmail.com>
References: <pull.1466.v2.git.1674190573.gitgitgadget@gmail.com>
        <pull.1466.v3.git.1674266126.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 Jan 2023 01:55:25 +0000
Subject: [PATCH v3 6/7] rebase: clarify the OPT_CMDMODE incompatibilities
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
index 3f12d242d83..00a9e22bc32 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -201,6 +201,39 @@ Alternatively, you can undo the 'git rebase' with
 
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
@@ -242,22 +275,6 @@ See also INCOMPATIBLE OPTIONS below.
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
@@ -338,17 +355,6 @@ See also INCOMPATIBLE OPTIONS below.
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
@@ -644,7 +650,6 @@ are incompatible with the following options:
  * --no-keep-empty
  * --empty=
  * --reapply-cherry-picks
- * --edit-todo
  * --update-refs
  * --root when used without --onto
 
-- 
gitgitgadget

