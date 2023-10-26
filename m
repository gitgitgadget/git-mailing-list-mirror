Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2843AC35
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 19:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkQhPtGL"
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C3BAC
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 12:17:54 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-4084de32db5so10468835e9.0
        for <git@vger.kernel.org>; Thu, 26 Oct 2023 12:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698347873; x=1698952673; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rt6gZ/A9ipUU5cIeB71aTSDEMGNct1rpJz6r6LCgyqs=;
        b=hkQhPtGLEWok/Hy+4L3Jwq6ncYqf9EK9khDE+pRifQA0glzluKeou3nW+ZmqW1SdvC
         ivdKlmN3t/RGNRd05pinXM7up0m0DioxruAwMhpuq6vY8TWv0FwEStAyXAgJmYTu4uIE
         zXSvy9CO9gHNDjRBSimcEd7eflAmBEqsCKjDLdXKfPCj53uh42t7lFQDbCJWkZVLVl42
         +hUnRyEeZgf3wbC/GcvLhRZ+2UnmBeAjzo5oovPO5oKAFPEcV4xgPxkvS/ZDdlcATHf0
         2SO3pdT3ttg9J1qatCQrAmhAM+H9SpWHJsYfwTXOEaTeELsU/lzDniejtnH70P36IPFW
         +FXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698347873; x=1698952673;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rt6gZ/A9ipUU5cIeB71aTSDEMGNct1rpJz6r6LCgyqs=;
        b=nt1DDBliEKhxBvTp2fciybqA46URVBWZ7RfTlaaU+m/3mty6JQ/Ro409lNFhpRcZGj
         BFb4DE0zvYb+5JGPoT2nd/TtrR1ra5Ko7VPata0isr7L4eGKjQC4cuxkdzLR9QDP8Rrv
         OIIEC1e9ES0mlyJRK8zzxhL5pDmWql+T8Q2hTxpaitUxAF6fjzihEYwv8ns86hQjIQci
         WV/uqNccSlayc5cSHrq2DS1Xvox4nJZ4LXVYXFPyp8hT5EhDFOC2IgRbRtWadGpg0UNv
         HtpGGUOpQau5guPuLTO4C+v9Ue2Sab7w30QxUecsj1VRNaNoLl6+v1m6dwOfYrWRzw4c
         w3ig==
X-Gm-Message-State: AOJu0Yzl5XOLTBaRyPuPQXU8Lz/rjf5gmnAGaEqrS6VmS3kQhVBBlSQG
	1U0DTrL/RXPQzGc5SWyh3Ql1l8PqV8A=
X-Google-Smtp-Source: AGHT+IFVADbRxv3NFF+4vrCWnYSQE/VxkQNyMKHevBFjXZ4uYMvIa21svzozeoJhSUN7LzjwPGCwGA==
X-Received: by 2002:a05:600c:1547:b0:406:81e9:ad0c with SMTP id f7-20020a05600c154700b0040681e9ad0cmr568787wmg.41.1698347872508;
        Thu, 26 Oct 2023 12:17:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c9-20020a7bc849000000b00405d9a950a2sm3250320wml.28.2023.10.26.12.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 12:17:52 -0700 (PDT)
Message-ID: <pull.1587.v4.git.1698347871200.gitgitgadget@gmail.com>
In-Reply-To: <pull.1587.v3.git.1696019580.gitgitgadget@gmail.com>
References: <pull.1587.v3.git.1696019580.gitgitgadget@gmail.com>
From: "Zach FettersMoore via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 26 Oct 2023 19:17:51 +0000
Subject: [PATCH v4] subtree: fix split processing with multiple subtrees
 present
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Zach FettersMoore <zach.fetters@apollographql.com>,
    Zach FettersMoore <zach.fetters@apollographql.com>

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

Added a test to validate that the proposed fix
solves the issue.

The test accomplishes this by checking the output
of the split command to ensure the output from
the progress of 'process_split_commit' function
that represents the 'extracount' of commits
processed does not increment.

This was tested against the original functionality
to show the test failed, and then with this fix
to show the test passes.

This illustrated that when using multiple subtrees,
A and B, when doing a split on subtree B, the
processing does not traverse the entire history
of subtree A which is unnecessary and would cause
the 'extracount' of processed commits to climb
based on the number of commits in the history of
subtree A.

Signed-off-by: Zach FettersMoore <zach.fetters@apollographql.com>
---
    subtree: fix split processing with multiple subtrees present
    
    When there are multiple subtrees in a repo and git subtree split
    --rejoin is being used for the subtrees, the processing of commits for a
    new split can take a significant (and constantly growing) amount of time
    because the split commits from other subtrees cause the processing to
    have to scan the entire history of the other subtree(s). This patch
    filters out the other subtree split commits that are unnecessary for the
    split commit processing.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1587%2FBobaFetters%2Fzf%2Fmulti-subtree-processing-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1587/BobaFetters/zf/multi-subtree-processing-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1587

Range-diff vs v3:

 1:  43175154a82 < -:  ----------- subtree: fix split processing with multiple subtrees present
 2:  d6811daf7cf < -:  ----------- subtree: changing location of commit ignore processing
 3:  eff8bfcc042 ! 1:  353152910eb subtree: adding test to validate fix
     @@ Metadata
      Author: Zach FettersMoore <zach.fetters@apollographql.com>
      
       ## Commit message ##
     -    subtree: adding test to validate fix
     +    subtree: fix split processing with multiple subtrees present
      
     -    Adding a test to validate that the proposed fix
     +    When there are multiple subtrees present in a repository and they are
     +    all using 'git subtree split', the 'split' command can take a
     +    significant (and constantly growing) amount of time to run even when
     +    using the '--rejoin' flag. This is due to the fact that when processing
     +    commits to determine the last known split to start from when looking
     +    for changes, if there has been a split/merge done from another subtree
     +    there will be 2 split commits, one mainline and one subtree, for the
     +    second subtree that are part of the processing. The non-mainline
     +    subtree split commit will cause the processing to always need to search
     +    the entire history of the given subtree as part of its processing even
     +    though those commits are totally irrelevant to the current subtree
     +    split being run.
     +
     +    In the diagram below, 'M' represents the mainline repo branch, 'A'
     +    represents one subtree, and 'B' represents another. M3 and B1 represent
     +    a split commit for subtree B that was created from commit M4. M2 and A1
     +    represent a split commit made from subtree A that was also created
     +    based on changes back to and including M4. M1 represents new changes to
     +    the repo, in this scenario if you try to run a 'git subtree split
     +    --rejoin' for subtree B, commits M1, M2, and A1, will be included in
     +    the processing of changes for the new split commit since the last
     +    split/rejoin for subtree B was at M3. The issue is that by having A1
     +    included in this processing the command ends up needing to processing
     +    every commit down tree A even though none of that is needed or relevant
     +    to the current command and result.
     +
     +    M1
     +     |        \       \
     +    M2         |       |
     +     |        A1       |
     +    M3         |       |
     +     |         |      B1
     +    M4         |       |
     +
     +    So this commit makes a change to the processing of commits for the split
     +    command in order to ignore non-mainline commits from other subtrees such
     +    as A1 in the diagram by adding a new function
     +    'should_ignore_subtree_commit' which is called during
     +    'process_split_commit'. This allows the split/rejoin processing to still
     +    function as expected but removes all of the unnecessary processing that
     +    takes place currently which greatly inflates the processing time.
     +
     +    Added a test to validate that the proposed fix
          solves the issue.
      
          The test accomplishes this by checking the output
     @@ Commit message
      
          Signed-off-by: Zach FettersMoore <zach.fetters@apollographql.com>
      
     + ## contrib/subtree/git-subtree.sh ##
     +@@ contrib/subtree/git-subtree.sh: ensure_valid_ref_format () {
     + 		die "fatal: '$1' does not look like a ref"
     + }
     + 
     ++# Usage: check if a commit from another subtree should be
     ++# ignored from processing for splits
     ++should_ignore_subtree_split_commit () {
     ++  if test -n "$(git log -1 --grep="git-subtree-dir:" $1)"
     ++  then
     ++    if test -z "$(git log -1 --grep="git-subtree-mainline:" $1)" &&
     ++			test -z "$(git log -1 --grep="git-subtree-dir: $arg_prefix$" $1)"
     ++    then
     ++      return 0
     ++    fi
     ++  fi
     ++  return 1
     ++}
     ++
     + # Usage: process_split_commit REV PARENTS
     + process_split_commit () {
     + 	assert test $# = 2
     +@@ contrib/subtree/git-subtree.sh: cmd_split () {
     + 	eval "$grl" |
     + 	while read rev parents
     + 	do
     +-		process_split_commit "$rev" "$parents"
     ++		if should_ignore_subtree_split_commit "$rev"
     ++		then
     ++			continue
     ++		fi
     ++		parsedParents=''
     ++		for parent in $parents
     ++		do
     ++			should_ignore_subtree_split_commit "$parent"
     ++			if test $? -eq 1
     ++			then
     ++				parsedParents+="$parent "
     ++			fi
     ++		done
     ++		process_split_commit "$rev" "$parsedParents"
     + 	done || exit $?
     + 
     + 	latest_new=$(cache_get latest_new) || exit $?
     +
       ## contrib/subtree/t/t7900-subtree.sh ##
      @@ contrib/subtree/t/t7900-subtree.sh: test_expect_success 'split sub dir/ with --rejoin' '
       	)
     @@ contrib/subtree/t/t7900-subtree.sh: test_expect_success 'split sub dir/ with --r
      +	) &&
      +	(
      +		cd "$test_count" &&
     -+		test "$(git subtree split --prefix=subBDir --squash --rejoin -d -m "Sub B Split 1" 2>&1 | grep -w "\[1\]")" = ""
     ++		test "$(git subtree split --prefix=subBDir --squash --rejoin \
     ++		 -d -m "Sub B Split 1" 2>&1 | grep -w "\[1\]")" = ""
      +	)
      +'
      +


 contrib/subtree/git-subtree.sh     | 29 ++++++++++++++++++++-
 contrib/subtree/t/t7900-subtree.sh | 42 ++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+), 1 deletion(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index e0c5d3b0de6..e69991a9d80 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -778,6 +778,20 @@ ensure_valid_ref_format () {
 		die "fatal: '$1' does not look like a ref"
 }
 
+# Usage: check if a commit from another subtree should be
+# ignored from processing for splits
+should_ignore_subtree_split_commit () {
+  if test -n "$(git log -1 --grep="git-subtree-dir:" $1)"
+  then
+    if test -z "$(git log -1 --grep="git-subtree-mainline:" $1)" &&
+			test -z "$(git log -1 --grep="git-subtree-dir: $arg_prefix$" $1)"
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
@@ -963,7 +977,20 @@ cmd_split () {
 	eval "$grl" |
 	while read rev parents
 	do
-		process_split_commit "$rev" "$parents"
+		if should_ignore_subtree_split_commit "$rev"
+		then
+			continue
+		fi
+		parsedParents=''
+		for parent in $parents
+		do
+			should_ignore_subtree_split_commit "$parent"
+			if test $? -eq 1
+			then
+				parsedParents+="$parent "
+			fi
+		done
+		process_split_commit "$rev" "$parsedParents"
 	done || exit $?
 
 	latest_new=$(cache_get latest_new) || exit $?
diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index 49a21dd7c9c..87d59afd761 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -385,6 +385,48 @@ test_expect_success 'split sub dir/ with --rejoin' '
 	)
 '
 
+test_expect_success 'split with multiple subtrees' '
+	subtree_test_create_repo "$test_count" &&
+	subtree_test_create_repo "$test_count/subA" &&
+	subtree_test_create_repo "$test_count/subB" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/subA" subA1 &&
+	test_create_commit "$test_count/subA" subA2 &&
+	test_create_commit "$test_count/subA" subA3 &&
+	test_create_commit "$test_count/subB" subB1 &&
+	(
+		cd "$test_count" &&
+		git fetch ./subA HEAD &&
+		git subtree add --prefix=subADir FETCH_HEAD
+	) &&
+	(
+		cd "$test_count" &&
+		git fetch ./subB HEAD &&
+		git subtree add --prefix=subBDir FETCH_HEAD
+	) &&
+	test_create_commit "$test_count" subADir/main-subA1 &&
+	test_create_commit "$test_count" subBDir/main-subB1 &&
+	(
+		cd "$test_count" &&
+		git subtree split --prefix=subADir --squash --rejoin -m "Sub A Split 1"
+	) &&
+	(
+		cd "$test_count" &&
+		git subtree split --prefix=subBDir --squash --rejoin -m "Sub B Split 1"
+	) &&
+	test_create_commit "$test_count" subADir/main-subA2 &&
+	test_create_commit "$test_count" subBDir/main-subB2 &&
+	(
+		cd "$test_count" &&
+		git subtree split --prefix=subADir --squash --rejoin -m "Sub A Split 2"
+	) &&
+	(
+		cd "$test_count" &&
+		test "$(git subtree split --prefix=subBDir --squash --rejoin \
+		 -d -m "Sub B Split 1" 2>&1 | grep -w "\[1\]")" = ""
+	)
+'
+
 test_expect_success 'split sub dir/ with --rejoin from scratch' '
 	subtree_test_create_repo "$test_count" &&
 	test_create_commit "$test_count" main1 &&

base-commit: bda494f4043963b9ec9a1ecd4b19b7d1cd9a0518
-- 
gitgitgadget
