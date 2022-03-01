Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC497C433EF
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 19:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237535AbiCATuv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 14:50:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237520AbiCATuT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 14:50:19 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36456E55A
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 11:49:05 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id o18-20020a05600c4fd200b003826701f847so1289480wmq.4
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 11:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1mFg2bjzdPEzCMnLZhFdBC7+b24mMKLFGnbYGnBDYJM=;
        b=kCUU0e13a5f2xQ9WykSg//3W+yIvMFd2h1mEVTEPH/L5VbvJ6bz3tEZ4FJjbdTdfGi
         V31WyNffMykDrGfXx2yiK91P9G4fnYZYLuez+wO/EbnlkDOGgav163ZF0DgU0uoEf31v
         4fGvp5G2EnzE1a7ivB6b7uzb/78XQPdcxBeo+YSBv7q0/v5LG2fA9OrChimF2HTHuRph
         OZ9zNSb4rDQl+fnW6xvP3CHa/KWnrVvgvhEqV8sMeyLJFw9AmN0tBFe27duHqKaeKTZF
         ykdaXNOSuck+9pCVeKbIGxPqJpH3bwLLqxlUMNj/yRhVJk6VG26UUeLpeEkFKjnNIjwB
         vjmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1mFg2bjzdPEzCMnLZhFdBC7+b24mMKLFGnbYGnBDYJM=;
        b=aUjIH0RYQdmFwHySWHm4pF6KT9iTOJifuze3U+q5sYxClSwgsphFN1L9IaTba0TbLG
         IJ5OFRwR3vXZy34cxg8gFlo2hO7TGdqvDZ+QpEIkIyLi34QkS3cq+hBGv2uq8tHz32fj
         dvYOm7ts9tR2ZzhvZUlw6mW+1YSnsbN8aOL4HLvsVA8pUq+a76g4TO2T7KDcJXGOQlxz
         esEQwKgE4CsAcHzN7rx+DDbwnM+kRBwouhiP3Y3QFhQ6vwoB6K7b2Q1rJ4fUTEecHFQU
         UJyDJBYdW9Clonlu8PDO3TIK1PSOaJG30BAz7MCycwkY65LQF6XJDfDSLzlYg8/LwcOk
         ePVA==
X-Gm-Message-State: AOAM530gTb6NjImwxwjNEBOIsIF9zNQ216kKiJgyirhgiI03HvBlW05r
        KB3WujV1ZgUA00VV04NSAnn1Jx6vqqA=
X-Google-Smtp-Source: ABdhPJzscEKwkUYsJFerj/8MtxaiMFkoNkjinHvvcLGXuTNH9vQLahYG24rDOkfsfc6Y12sXtfzyuA==
X-Received: by 2002:a1c:29c3:0:b0:350:9797:b38f with SMTP id p186-20020a1c29c3000000b003509797b38fmr18265874wmp.22.1646164115416;
        Tue, 01 Mar 2022 11:48:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f8-20020a05600c4e8800b00380ee4a78fdsm4339797wmq.4.2022.03.01.11.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 11:48:34 -0800 (PST)
Message-Id: <a90cad8efa5c2f316b6f054153e32e4e94cee025.1646164112.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1163.v3.git.1646164112.gitgitgadget@gmail.com>
References: <pull.1163.v2.git.1646056423.gitgitgadget@gmail.com>
        <pull.1163.v3.git.1646164112.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Mar 2022 19:48:29 +0000
Subject: [PATCH v3 2/5] t5318: extract helpers to lib-commit-graph.sh
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, gitster@pobox.com, abhishekkumar8222@gmail.com,
        avarab@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The graph_git_behavior helper is useful for testing that certain Git
commands behave the same when using the commit-graph and when not using
the commit-graph. Extract it to a new lib-commit-graph.sh file for use
in new test scripts that will split out from t5318.

While doing this extraction, also extract graph_read_expect and the
logic for priming the test_oid_cache.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 t/lib-commit-graph.sh   | 48 +++++++++++++++++++++++++++++++++++++++
 t/t5318-commit-graph.sh | 50 ++---------------------------------------
 2 files changed, 50 insertions(+), 48 deletions(-)
 create mode 100755 t/lib-commit-graph.sh

diff --git a/t/lib-commit-graph.sh b/t/lib-commit-graph.sh
new file mode 100755
index 00000000000..07e12b9d2fe
--- /dev/null
+++ b/t/lib-commit-graph.sh
@@ -0,0 +1,48 @@
+#!/bin/sh
+
+# Helper functions for testing commit-graphs.
+
+# Initialize OID cache with oid_version
+test_oid_cache <<-EOF
+oid_version sha1:1
+oid_version sha256:2
+EOF
+
+graph_git_two_modes() {
+	git -c core.commitGraph=true $1 >output &&
+	git -c core.commitGraph=false $1 >expect &&
+	test_cmp expect output
+}
+
+graph_git_behavior() {
+	MSG=$1
+	DIR=$2
+	BRANCH=$3
+	COMPARE=$4
+	test_expect_success "check normal git operations: $MSG" '
+		cd "$TRASH_DIRECTORY/$DIR" &&
+		graph_git_two_modes "log --oneline $BRANCH" &&
+		graph_git_two_modes "log --topo-order $BRANCH" &&
+		graph_git_two_modes "log --graph $COMPARE..$BRANCH" &&
+		graph_git_two_modes "branch -vv" &&
+		graph_git_two_modes "merge-base -a $BRANCH $COMPARE"
+	'
+}
+
+graph_read_expect() {
+	OPTIONAL=""
+	NUM_CHUNKS=3
+	if test -n "$2"
+	then
+		OPTIONAL=" $2"
+		NUM_CHUNKS=$((3 + $(echo "$2" | wc -w)))
+	fi
+	cat >expect <<- EOF
+	header: 43475048 1 $(test_oid oid_version) $NUM_CHUNKS 0
+	num_commits: $1
+	chunks: oid_fanout oid_lookup commit_metadata$OPTIONAL
+	options:
+	EOF
+	test-tool read-graph >output &&
+	test_cmp expect output
+}
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 2b05026cf6d..9e2b5884dae 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -29,12 +29,7 @@ test_expect_success 'setup full repo' '
 	cd "$TRASH_DIRECTORY/full" &&
 	git init &&
 	git config core.commitGraph true &&
-	objdir=".git/objects" &&
-
-	test_oid_cache <<-EOF
-	oid_version sha1:1
-	oid_version sha256:2
-	EOF
+	objdir=".git/objects"
 '
 
 test_expect_success POSIXPERM 'tweak umask for modebit tests' '
@@ -69,47 +64,10 @@ test_expect_success 'create commits and repack' '
 	git repack
 '
 
-graph_git_two_modes() {
-	git -c core.commitGraph=true $1 >output &&
-	git -c core.commitGraph=false $1 >expect &&
-	test_cmp expect output
-}
-
-graph_git_behavior() {
-	MSG=$1
-	DIR=$2
-	BRANCH=$3
-	COMPARE=$4
-	test_expect_success "check normal git operations: $MSG" '
-		cd "$TRASH_DIRECTORY/$DIR" &&
-		graph_git_two_modes "log --oneline $BRANCH" &&
-		graph_git_two_modes "log --topo-order $BRANCH" &&
-		graph_git_two_modes "log --graph $COMPARE..$BRANCH" &&
-		graph_git_two_modes "branch -vv" &&
-		graph_git_two_modes "merge-base -a $BRANCH $COMPARE"
-	'
-}
+. "$TEST_DIRECTORY"/lib-commit-graph.sh
 
 graph_git_behavior 'no graph' full commits/3 commits/1
 
-graph_read_expect() {
-	OPTIONAL=""
-	NUM_CHUNKS=3
-	if test ! -z "$2"
-	then
-		OPTIONAL=" $2"
-		NUM_CHUNKS=$((3 + $(echo "$2" | wc -w)))
-	fi
-	cat >expect <<- EOF
-	header: 43475048 1 $(test_oid oid_version) $NUM_CHUNKS 0
-	num_commits: $1
-	chunks: oid_fanout oid_lookup commit_metadata$OPTIONAL
-	options:
-	EOF
-	test-tool read-graph >output &&
-	test_cmp expect output
-}
-
 test_expect_success 'exit with correct error on bad input to --stdin-commits' '
 	cd "$TRASH_DIRECTORY/full" &&
 	# invalid, non-hex OID
@@ -826,10 +784,6 @@ test_expect_success 'set up and verify repo with generation data overflow chunk'
 	objdir=".git/objects" &&
 	UNIX_EPOCH_ZERO="@0 +0000" &&
 	FUTURE_DATE="@2147483646 +0000" &&
-	test_oid_cache <<-EOF &&
-	oid_version sha1:1
-	oid_version sha256:2
-	EOF
 	cd "$TRASH_DIRECTORY" &&
 	mkdir repo &&
 	cd repo &&
-- 
gitgitgadget

