Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D2E9CD4845
	for <git@archiver.kernel.org>; Fri, 22 Sep 2023 16:25:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbjIVQZf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Sep 2023 12:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjIVQZc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2023 12:25:32 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC1E139
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 09:25:24 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-4053d53a1bfso10383725e9.1
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 09:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695399922; x=1696004722; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cIKts4cb5kww+LIXIC0MjPHkyCv31eTVCAT99h/vYX8=;
        b=SzyNjSCf7AKsjm791T8bHC0GfFsu0mI9KK59HQA02ZTBS8L8sCZPxroYNwck5K/yZQ
         56hgCwLzgQ0Uj80vOrI4G4mNLvO00lgN5trdqA6GmK+CrwurTba1UAupACpTOBtqxEfX
         RZI+E3z8gK6T9Fp3u2133mado2ovwaNEYwFFwtMUktK7+qeeH34pbKT9el9cntrm56Ll
         5RUuoWxYf9t786wEAOzu6DKXwDdRFnRuVaZ7G6XBKTQCi6GvH2/gCbtqJuGXApcN96Ve
         GgtAWZxCfXrODvqCYBJ1clIQa3kvUAx6skhMH5cdFFl+GyS1QIWdQRVVXUPG1OSaPh4D
         t9Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695399922; x=1696004722;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cIKts4cb5kww+LIXIC0MjPHkyCv31eTVCAT99h/vYX8=;
        b=fLF2R4JY4fa6uPwooqt+p/Uz7DoG4KFIFp9ckF6DZe9xX35yFgH1FVTLXKb7L353LB
         miIhOJZNe7u06+wHyoSMuYWdDf3iNU5PLb9qyEG1W8a48P5DnzB+oB9x7xBIaeufBrpm
         y4Wv1Vy3T3b4ocIb/fTBqN5QVf9RvGYYKgAxsKTNq0jxRCcb32OCH67rlpK72oQp6r+w
         jnA0juhO/PHBiZzUG46j4wHQiITsmmjzCKsGaHGektj2z4nHgT4Te+5shwFgwOyCeqjA
         CceX7ZAS05Bv1xMGFuxajSvJgjBLAuh/vY4NDmiMfqe+Q1R0Jbnd2LUujXDaj14e57vT
         8Lbg==
X-Gm-Message-State: AOJu0YzrpA2KWT1A+tuUO8Ps8ugWoLijlUxpERvbDUS3WTLg4KIkJtr+
        dD92tJIImY/ZcTIBTJxad9H5b6FC3OY=
X-Google-Smtp-Source: AGHT+IFsIKkPieYE7KVfhX6Hv29XaHcFxizcklW2Lk997fpE6DR/uc9YHN5qTFe57f9MS/pkLm2Qxw==
X-Received: by 2002:a05:600c:2245:b0:405:1ba2:4fcb with SMTP id a5-20020a05600c224500b004051ba24fcbmr7983068wmm.16.1695399922235;
        Fri, 22 Sep 2023 09:25:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y21-20020a05600c20d500b00403c8dde953sm7795406wmm.22.2023.09.22.09.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 09:25:22 -0700 (PDT)
Message-ID: <43175154a82ea04eec995f1d47771881a981bda6.1695399920.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1587.v2.git.1695399920.gitgitgadget@gmail.com>
References: <pull.1587.git.1695067516192.gitgitgadget@gmail.com>
        <pull.1587.v2.git.1695399920.gitgitgadget@gmail.com>
From:   "Zach FettersMoore via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Sep 2023 16:25:19 +0000
Subject: [PATCH v2 1/2] subtree: fix split processing with multiple subtrees
 present
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Zach FettersMoore <zach.fetters@apollographql.com>,
        Zach FettersMoore <zach.fetters@apollographql.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Zach FettersMoore <zach.fetters@apollographql.com>

When there are multiple subtrees present in a repository and they are
all using 'git subtree split', the 'split' command can take a
significant (and constantly growing) amount of time to run even when
using the '--rejoin' flag. This is due to the fact that when processing
commits to determine the last known split to start from when looking
for changes, if there has been a split/merge done from another subtree
there will be 2 split commits, one mainline and one subtree, for the
second subtree that are part of the processing. The non-mainline
subtree split commit will cause the processing to always need to search
the entire history of the given subtree as part of its processing even
though those commits are totally irrelevant to the current subtree
split being run.

In the diagram below, 'M' represents the mainline repo branch, 'A'
represents one subtree, and 'B' represents another. M3 and B1 represent
a split commit for subtree B that was created from commit M4. M2 and A1
represent a split commit made from subtree A that was also created
based on changes back to and including M4. M1 represents new changes to
the repo, in this scenario if you try to run a 'git subtree split
--rejoin' for subtree B, commits M1, M2, and A1, will be included in
the processing of changes for the new split commit since the last
split/rejoin for subtree B was at M3. The issue is that by having A1
included in this processing the command ends up needing to processing
every commit down tree A even though none of that is needed or relevant
to the current command and result.

M1
 |	  \	  \
M2	   |	   |
 |     	  A1	   |
M3	   |	   |
 |	   |	  B1
M4	   |	   |

So this commit makes a change to the processing of commits for the split
command in order to ignore non-mainline commits from other subtrees such
as A1 in the diagram by adding a new function
'should_ignore_subtree_commit' which is called during
'process_split_commit'. This allows the split/rejoin processing to still
function as expected but removes all of the unnecessary processing that
takes place currently which greatly inflates the processing time.

Signed-off-by: Zach FettersMoore <zach.fetters@apollographql.com>
---
 contrib/subtree/git-subtree.sh | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index e0c5d3b0de6..e9250dfb019 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -778,12 +778,29 @@ ensure_valid_ref_format () {
 		die "fatal: '$1' does not look like a ref"
 }
 
+# Usage: check if a commit from another subtree should be ignored from processing for splits
+should_ignore_subtree_commit () {
+  if [ "$(git log -1 --grep="git-subtree-dir:" $1)" ]
+  then
+    if [[ -z "$(git log -1 --grep="git-subtree-mainline:" $1)" && -z "$(git log -1 --grep="git-subtree-dir: $dir$" $1)" ]]
+    then
+      return 0
+    fi
+  fi
+  return 1
+}
+
 # Usage: process_split_commit REV PARENTS
 process_split_commit () {
 	assert test $# = 2
 	local rev="$1"
 	local parents="$2"
 
+    if should_ignore_subtree_commit $rev
+    then
+	    return
+    fi
+
 	if test $indent -eq 0
 	then
 		revcount=$(($revcount + 1))
-- 
gitgitgadget

