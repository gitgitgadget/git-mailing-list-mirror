Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D6B8C4332F
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 15:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbiKDPF6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Nov 2022 11:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbiKDPF5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2022 11:05:57 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B851A4
        for <git@vger.kernel.org>; Fri,  4 Nov 2022 08:05:55 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id m7-20020a05600c090700b003cf8a105d9eso3345199wmp.5
        for <git@vger.kernel.org>; Fri, 04 Nov 2022 08:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zq98j1HMfnr3KozIFCSzzCi/9vZ+1olgqAw1/egw2ec=;
        b=IqQsOz9EDX2f/i1hvzLbmNAHLj7ga7Jx6Vb5ZpTA+g4GPzfhsr538pvc1uxreCH14R
         EkZsbT5g9GBMDFG19zSRWIfU8nm5XJC5jEpzkYW+RK2cothTgrc4rk6dldKLjZegnsg8
         0LcceqFWjX8Toa5ArIsvNb6c7Ma+sskgbunHsirj1yRy/tX89Cyy1UtBkj7VLlE4p/m/
         QGqJE8SJ3t3UjlLkGOQCAAgrf+1bYSVhNc9lHQwTeMMH1UsSs/u/oz9tS+HRLaIkKQ7n
         gxNXgwCMeZYtn5EBDzKLnay6fpNeKvxSSd3W9ejl+ZTgMLqAZrjualS3yvxwjY9DIQmW
         cDeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zq98j1HMfnr3KozIFCSzzCi/9vZ+1olgqAw1/egw2ec=;
        b=LVZvhP+V0qu6utbgQ6g3FqMJix8NE8SmX+koZlk+oimtm7EoHj8ybo0pCL6uRRiApI
         HTWbHekOPVnxwxb23aJPp51BC6UttU7qgEO497QNbgXhHqxcPKnGvDq5lAGdfQQbVOBF
         hl0Pyq5mhCL/LfLVL0M8Chb8WF9LYTTTOX6ky5UkgyGBB1I+RD/IAuz+KNfuRWLxh0k7
         lWKneRn7+EpXc5oTY0P/rVOdeUM93egb1nfvshS1BiceknpLr4EMklGbbDtlxwTE8PS+
         Y5VM6q9K2tB1TbMh0FQBpRRZs8NefwpM/B17bARd9HEOnR78Gdr5/nnUrfAhANUv/BTr
         kUwQ==
X-Gm-Message-State: ACrzQf3WhnrYlSLm/tzLNoXPWhq+SO1yaqiIQ2PFUGPPzYUf+ASmzO1J
        YF1fglesKqfKW7Y5j6cX1EzLcXpfYF4=
X-Google-Smtp-Source: AMsMyM4lReDSsmPYBd3dPPQHRqvZeLTd6GXKeaGivFbdWRlldiyoolegMSeJ2OJevCO0JaSg0Dibaw==
X-Received: by 2002:a1c:acc5:0:b0:3c6:eebf:feee with SMTP id v188-20020a1cacc5000000b003c6eebffeeemr24321885wme.122.1667574353620;
        Fri, 04 Nov 2022 08:05:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bg27-20020a05600c3c9b00b003a5f3f5883dsm3661243wmb.17.2022.11.04.08.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 08:05:53 -0700 (PDT)
Message-Id: <pull.1372.v3.git.git.1667574352244.gitgitgadget@gmail.com>
In-Reply-To: <pull.1372.v2.git.git.1667500788132.gitgitgadget@gmail.com>
References: <pull.1372.v2.git.git.1667500788132.gitgitgadget@gmail.com>
From:   "Debra Obondo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 04 Nov 2022 15:05:52 +0000
Subject: [PATCH v3] t7001-mv.sh: modernizing test script using functions
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Debra Obondo <debraobondo@gmail.com>,
        Debra Obondo <debraobondo@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Debra Obondo <debraobondo@gmail.com>

Test script to verify the presence/absence of files, paths, directories,
symlinks and other features in 'git mv' command are using the command
format:

'test (-e|f|d|h|...)'

Replace them with helper functions of format:

'test_path_is_*'

Replacing idiomatic helper functions:

'! test_path_is_*'

with

'test_path_is_missing'

This uses values of 'test_path_bar' in place of '! test_path_foo' to
bring in the helpful factor of indicating the failure of tests after the
mv command has been used, that is, it echoes if the feature/test_path
exists.

Signed-off-by: Debra Obondo <debraobondo@gmail.com>
---
    [PATCH v3] [OUTREACHY] t7001-mv.sh : Use test_path_is_* functions in
    test script
    
    Changes since prevous 2 versions:
    
    Replacing idiomatic helper functions
    
    '! test_path_is_*'
    
    with
    
    'test_path_is_missing'
    
    This uses values of 'test_path_bar' in place of '! test_path_foo' to
    bring in the helpful factor of indicating the failure of tests after the
    mv command has been used, that is, it echoes if the feature/test_path
    exists .
    
    Older test scripts use the command 'test -' to verify the presence or
    absence of features such as files, directories and symbolic links. This
    however requires slightly complicated uses, such as 'test ! -f '. The
    helper functions 'test_path_is_' located in t/test-lib-functions.sh have
    taken into account all scenarios of the 'test -' to reduce errors. This
    was a microproject to replace them with the helper functions.
    
    Test script to verify the presence/absence of files, paths,
    directories,symboliclinks and many other features in mv command are
    using the command format
    
    'test -(e|f|s|h|...).
    
    Replace them with helper functions of format
    
    'test_path_is_*'
    
    Signed-off-by: Debra Obondo debraobondo@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1372%2Ffobiasic07%2Ft7001-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1372/fobiasic07/t7001-v3
Pull-Request: https://github.com/git/git/pull/1372

Range-diff vs v2:

 1:  c6640ebff66 ! 1:  04176190ffd t7001-mv.sh: modernizing test script using functions
     @@ Commit message
      
          'test_path_is_*'
      
     -    Changes since v1
     -
     -    Replacing idiomatic helper functions
     +    Replacing idiomatic helper functions:
      
          '! test_path_is_*'
      


 t/t7001-mv.sh | 62 +++++++++++++++++++++++++--------------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 8c37bceb336..d72cef88264 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -60,8 +60,8 @@ test_expect_success 'checking the commit' '
 
 test_expect_success 'mv --dry-run does not move file' '
 	git mv -n path0/COPYING MOVED &&
-	test -f path0/COPYING &&
-	test ! -f MOVED
+	test_path_is_file path0/COPYING &&
+	test_path_is_missing MOVED
 '
 
 test_expect_success 'checking -k on non-existing file' '
@@ -71,25 +71,25 @@ test_expect_success 'checking -k on non-existing file' '
 test_expect_success 'checking -k on untracked file' '
 	>untracked1 &&
 	git mv -k untracked1 path0 &&
-	test -f untracked1 &&
-	test ! -f path0/untracked1
+	test_path_is_file untracked1 &&
+	test_path_is_missing path0/untracked1
 '
 
 test_expect_success 'checking -k on multiple untracked files' '
 	>untracked2 &&
 	git mv -k untracked1 untracked2 path0 &&
-	test -f untracked1 &&
-	test -f untracked2 &&
-	test ! -f path0/untracked1 &&
-	test ! -f path0/untracked2
+	test_path_is_file untracked1 &&
+	test_path_is_file untracked2 &&
+	test_path_is_missing path0/untracked1 &&
+	test_path_is_missing path0/untracked2
 '
 
 test_expect_success 'checking -f on untracked file with existing target' '
 	>path0/untracked1 &&
 	test_must_fail git mv -f untracked1 path0 &&
-	test ! -f .git/index.lock &&
-	test -f untracked1 &&
-	test -f path0/untracked1
+	test_path_is_missing .git/index.lock &&
+	test_path_is_file untracked1 &&
+	test_path_is_file path0/untracked1
 '
 
 # clean up the mess in case bad things happen
@@ -215,8 +215,8 @@ test_expect_success 'absolute pathname' '
 		git add sub/file &&
 
 		git mv sub "$(pwd)/in" &&
-		! test -d sub &&
-		test -d in &&
+		test_path_is_missing sub &&
+		test_path_is_dir in &&
 		git ls-files --error-unmatch in/file
 	)
 '
@@ -234,8 +234,8 @@ test_expect_success 'absolute pathname outside should fail' '
 		git add sub/file &&
 
 		test_must_fail git mv sub "$out/out" &&
-		test -d sub &&
-		! test -d ../in &&
+		test_path_is_dir sub &&
+		test_path_is_missing ../in &&
 		git ls-files --error-unmatch sub/file
 	)
 '
@@ -295,8 +295,8 @@ test_expect_success 'git mv should overwrite symlink to a file' '
 	git add moved &&
 	test_must_fail git mv moved symlink &&
 	git mv -f moved symlink &&
-	! test -e moved &&
-	test -f symlink &&
+	test_path_is_missing moved &&
+	test_path_is_file symlink &&
 	test "$(cat symlink)" = 1 &&
 	git update-index --refresh &&
 	git diff-files --quiet
@@ -312,13 +312,13 @@ test_expect_success 'git mv should overwrite file with a symlink' '
 	git add moved &&
 	test_must_fail git mv symlink moved &&
 	git mv -f symlink moved &&
-	! test -e symlink &&
+	test_path_is_missing symlink &&
 	git update-index --refresh &&
 	git diff-files --quiet
 '
 
 test_expect_success SYMLINKS 'check moved symlink' '
-	test -h moved
+	test_path_is_symlink moved
 '
 
 rm -f moved symlink
@@ -352,7 +352,7 @@ test_expect_success 'git mv moves a submodule with a .git directory and no .gitm
 	) &&
 	mkdir mod &&
 	git mv sub mod/sub &&
-	! test -e sub &&
+	test_path_is_missing sub &&
 	test "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" &&
 	git -C mod/sub status &&
 	git update-index --refresh &&
@@ -372,7 +372,7 @@ test_expect_success 'git mv moves a submodule with a .git directory and .gitmodu
 	) &&
 	mkdir mod &&
 	git mv sub mod/sub &&
-	! test -e sub &&
+	test_path_is_missing sub &&
 	test "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" &&
 	git -C mod/sub status &&
 	echo mod/sub >expected &&
@@ -389,7 +389,7 @@ test_expect_success 'git mv moves a submodule with gitfile' '
 	entry="$(git ls-files --stage sub | cut -f 1)" &&
 	mkdir mod &&
 	git -C mod mv ../sub/ . &&
-	! test -e sub &&
+	test_path_is_missing sub &&
 	test "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" &&
 	git -C mod/sub status &&
 	echo mod/sub >expected &&
@@ -408,7 +408,7 @@ test_expect_success 'mv does not complain when no .gitmodules file is found' '
 	mkdir mod &&
 	git mv sub mod/sub 2>actual.err &&
 	test_must_be_empty actual.err &&
-	! test -e sub &&
+	test_path_is_missing sub &&
 	test "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" &&
 	git -C mod/sub status &&
 	git update-index --refresh &&
@@ -423,13 +423,13 @@ test_expect_success 'mv will error out on a modified .gitmodules file unless sta
 	entry="$(git ls-files --stage sub | cut -f 1)" &&
 	mkdir mod &&
 	test_must_fail git mv sub mod/sub 2>actual.err &&
-	test -s actual.err &&
-	test -e sub &&
+	test_file_not_empty actual.err &&
+	test_path_exists sub &&
 	git diff-files --quiet -- sub &&
 	git add .gitmodules &&
 	git mv sub mod/sub 2>actual.err &&
 	test_must_be_empty actual.err &&
-	! test -e sub &&
+	test_path_is_missing sub &&
 	test "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" &&
 	git -C mod/sub status &&
 	git update-index --refresh &&
@@ -447,7 +447,7 @@ test_expect_success 'mv issues a warning when section is not found in .gitmodule
 	mkdir mod &&
 	git mv sub mod/sub 2>actual.err &&
 	test_cmp expect.err actual.err &&
-	! test -e sub &&
+	test_path_is_missing sub &&
 	test "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" &&
 	git -C mod/sub status &&
 	git update-index --refresh &&
@@ -460,7 +460,7 @@ test_expect_success 'mv --dry-run does not touch the submodule or .gitmodules' '
 	git submodule update &&
 	mkdir mod &&
 	git mv -n sub mod/sub 2>actual.err &&
-	test -f sub/.git &&
+	test_path_is_file sub/.git &&
 	git diff-index --exit-code HEAD &&
 	git update-index --refresh &&
 	git diff-files --quiet -- sub .gitmodules
@@ -474,10 +474,10 @@ test_expect_success 'checking out a commit before submodule moved needs manual u
 	git status -s sub2 >actual &&
 	echo "?? sub2/" >expected &&
 	test_cmp expected actual &&
-	! test -f sub/.git &&
-	test -f sub2/.git &&
+	test_path_is_missing sub/.git &&
+	test_path_is_file sub2/.git &&
 	git submodule update &&
-	test -f sub/.git &&
+	test_path_is_file sub/.git &&
 	rm -rf sub2 &&
 	git diff-index --exit-code HEAD &&
 	git update-index --refresh &&

base-commit: 1fc3c0ad407008c2f71dd9ae1241d8b75f8ef886
-- 
gitgitgadget
