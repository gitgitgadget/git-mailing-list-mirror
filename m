Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC38E728F3
	for <git@archiver.kernel.org>; Fri, 29 Sep 2023 20:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233516AbjI2UdP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Sep 2023 16:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233326AbjI2UdM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2023 16:33:12 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A820E1A7
        for <git@vger.kernel.org>; Fri, 29 Sep 2023 13:33:04 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-313e742a787so698224f8f.1
        for <git@vger.kernel.org>; Fri, 29 Sep 2023 13:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696019583; x=1696624383; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cIKts4cb5kww+LIXIC0MjPHkyCv31eTVCAT99h/vYX8=;
        b=V7ruh0jH9zQRZd6GB1JWL7Im+1kWLdzzhKxfW9SKI8sNcFZl1cyITPsIzSFGzIDncY
         +aFrPN3rfTgi//C0yDr+xvmo3jqLv+q0ysXYIpRKtijfTvfTMArNzZlUz4ly/GICvY3n
         Mg6oHpNpLsAWZAYBCG8bTXAFUjzQyNAVXJ9fJDpxr4egFS9indK8EA5s3q0piR1XXgw+
         syBf+bAVYWm3PolZnJF3vtwUBTI7rp/ZPb1nfNDyCEDf8u0eyea+YONjNzx+R23E2wN7
         kDZcPBtZizU+m9ja//0ftxQZF46Kx/d3z/82OpLNm2ECf+WIzxjnukPC04uYWeVq/+kE
         RnoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696019583; x=1696624383;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cIKts4cb5kww+LIXIC0MjPHkyCv31eTVCAT99h/vYX8=;
        b=ku61ITsqIyYpfhd0d/SMxrk0f+sub4lwAGPa/6/cT/DDAvOUx96jDxd8See+XVEdoC
         HuV0BOIDH8PesuRpSva3pMm8gIGI8TA4dD2saoflJei/eh1+NjFDk8+NH/Zwg92vJd21
         IZmbfAiWESDrhXQFkIz66AaOTOODL1dKHFKHz3I0smJGqcHYC9G6fM+ZyxuyJPF/HKo+
         X8deaX5ItRMdU6Cha40EoVmapvNKedL/wxLZNPmbXyO+zgU9ZC3pTOCDkScga0PBXMtM
         zPuQS1cYsRrOUvUeCp1g1nGcurmyghjZfjALrOmgkLDlpfYUmGM2xumBMxisZVRcpTKN
         ltcw==
X-Gm-Message-State: AOJu0YxWgqH/1XAxXeGxIu2wz2UV9E0U17oNikpOcGATitUpjUP6c643
        Bf0N3T1mYKetG9iqy09sVWA5YyQ2Dz0=
X-Google-Smtp-Source: AGHT+IGfhXmhodzBVJfmMSpuZbANCt0119v9kGWpAVgFvPvfA9o7ucOgKpJXM6Yz3J9GSaBGjYoXVw==
X-Received: by 2002:a5d:67cd:0:b0:31f:d50e:a14f with SMTP id n13-20020a5d67cd000000b0031fd50ea14fmr4508522wrw.10.1696019582631;
        Fri, 29 Sep 2023 13:33:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m4-20020adff384000000b00321673de0d7sm6795482wro.25.2023.09.29.13.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 13:33:02 -0700 (PDT)
Message-ID: <43175154a82ea04eec995f1d47771881a981bda6.1696019580.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1587.v3.git.1696019580.gitgitgadget@gmail.com>
References: <pull.1587.v2.git.1695399920.gitgitgadget@gmail.com>
        <pull.1587.v3.git.1696019580.gitgitgadget@gmail.com>
From:   "Zach FettersMoore via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 29 Sep 2023 20:32:58 +0000
Subject: [PATCH v3 1/3] subtree: fix split processing with multiple subtrees
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

