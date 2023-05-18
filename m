Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41739C7EE2A
	for <git@archiver.kernel.org>; Thu, 18 May 2023 20:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjERUEV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 May 2023 16:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbjERUDx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2023 16:03:53 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A40EE75
        for <git@vger.kernel.org>; Thu, 18 May 2023 13:03:40 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f427118644so23996615e9.0
        for <git@vger.kernel.org>; Thu, 18 May 2023 13:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684440218; x=1687032218;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0zzhedQPVEvCLK19lp+Wr664ssQJ62Ear/0zHPmrx84=;
        b=Smk6FchNFdN/n2GUdcvoscKrLp0aAEVoPdQc3N0v+y3v9IaJqevipGDmXMloFm+63V
         xL7yzQByCNtiqSP9GkDp+xrRCqlxIBB1AAX0/uC7uV5Rj/gdJgq/HWMIG36lOYA96KzD
         OJVVKKj00hZubfkp46YX6yq6ttOZ+04O+kb6Uw3rJmuFNjGxn/PqyhldUqMLnCggDu+L
         Y9RiVXVbci0V4NswCNgxBwwnxY/ZfZ63afm1NKaLCwqBepzqzdkYB9tAbe2mnSGZHXi3
         UKCAoalskzOAFPK7FdFD0Y3VbcBlyfqpW4vvKsBfnOuZDfxQZDum+ul2jnuGoQ9+QFND
         ZU5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684440218; x=1687032218;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0zzhedQPVEvCLK19lp+Wr664ssQJ62Ear/0zHPmrx84=;
        b=BhaPS8VRHFPgW3Y0fcZW6mu0M2gKRL3xd/aVfeywlHzCKOF2I9w0H4S6Fj6TROEl+T
         TRs3TyLxHJJ7qnQVFAFsMlTkDmvmpHvFyu292KVzP9+bW/Xm523XnL8sGL8qiKoTGhoo
         hy2ke7dJSFNBlEIKybyWw36A/IlNgr22iZomIghSyrYbfCl8PXkUvUFy5IjmKN8H3m4v
         UwRooWEqAAoyXxiRMZug3DDjBH50q8GIXVp9SYcANX39BgkRqSShCZAKnb/McAIwbxBh
         3p/YKYP90OoChdC1coEf/IF7Sge9JAByFKgVMUARBwYaVhOQfVPPYsTsKx05YQaeJ/qK
         vxxQ==
X-Gm-Message-State: AC+VfDwf4k7ZoSQkHfUvsOr2guFbJ41bQDlfJQ+ttaelxsPnPp6kQW2E
        e0E4LCzZ0JKHXKXFDenKOJaxvSRXo84=
X-Google-Smtp-Source: ACHHUZ4Z+HjxfC4GGrl6xIJDk/PS/hw3n7j6NmblFj08IOMr+XZbz40oRBtmbj2r/LZBULik/R3Mmw==
X-Received: by 2002:a05:600c:218f:b0:3f5:9ba:442e with SMTP id e15-20020a05600c218f00b003f509ba442emr2456486wme.10.1684440218531;
        Thu, 18 May 2023 13:03:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k1-20020a7bc301000000b003f42d8dd7ffsm222161wmj.19.2023.05.18.13.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 13:03:38 -0700 (PDT)
Message-Id: <bef72336ae83266ecdd8f61e2715a48dc21214e0.1684440206.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1513.git.git.1684440205.gitgitgadget@gmail.com>
References: <pull.1513.git.git.1684440205.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 18 May 2023 20:03:23 +0000
Subject: [PATCH 18/20] t5306-pack-nobase: modernize test format
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

Some tests still use the old format with four spaces indentation.
Standardize the tests to the new format with tab indentation.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 t/t5306-pack-nobase.sh | 94 ++++++++++++++++++++----------------------
 1 file changed, 45 insertions(+), 49 deletions(-)

diff --git a/t/t5306-pack-nobase.sh b/t/t5306-pack-nobase.sh
index 846c5ca7d34..0d50c6b4bca 100755
--- a/t/t5306-pack-nobase.sh
+++ b/t/t5306-pack-nobase.sh
@@ -12,18 +12,17 @@ TEST_PASSES_SANITIZE_LEAK=true
 
 # Create A-B chain
 #
-test_expect_success \
-    'setup base' \
-    'test_write_lines a b c d e f g h i >text &&
-     echo side >side &&
-     git update-index --add text side &&
-     A=$(echo A | git commit-tree $(git write-tree)) &&
+test_expect_success 'setup base' '
+	test_write_lines a b c d e f g h i >text &&
+	echo side >side &&
+	git update-index --add text side &&
+	A=$(echo A | git commit-tree $(git write-tree)) &&
 
-     echo m >>text &&
-     git update-index text &&
-     B=$(echo B | git commit-tree $(git write-tree) -p $A) &&
-     git update-ref HEAD $B
-    '
+	echo m >>text &&
+	git update-index text &&
+	B=$(echo B | git commit-tree $(git write-tree) -p $A) &&
+	git update-ref HEAD $B
+'
 
 # Create repository with C whose parent is B.
 # Repository contains C, C^{tree}, C:text, B, B^{tree}.
@@ -31,52 +30,49 @@ test_expect_success \
 # Repository is missing A (parent of B).
 # Repository is missing A:side.
 #
-test_expect_success \
-    'setup patch_clone' \
-    'base_objects=$(pwd)/.git/objects &&
-     (mkdir patch_clone &&
-      cd patch_clone &&
-      git init &&
-      echo "$base_objects" >.git/objects/info/alternates &&
-      echo q >>text &&
-      git read-tree $B &&
-      git update-index text &&
-      git update-ref HEAD $(echo C | git commit-tree $(git write-tree) -p $B) &&
-      rm .git/objects/info/alternates &&
+test_expect_success 'setup patch_clone' '
+	base_objects=$(pwd)/.git/objects &&
+	(mkdir patch_clone &&
+	cd patch_clone &&
+	git init &&
+	echo "$base_objects" >.git/objects/info/alternates &&
+	echo q >>text &&
+	git read-tree $B &&
+	git update-index text &&
+	git update-ref HEAD $(echo C | git commit-tree $(git write-tree) -p $B) &&
+	rm .git/objects/info/alternates &&
 
-      git --git-dir=../.git cat-file commit $B |
-      git hash-object -t commit -w --stdin &&
+	git --git-dir=../.git cat-file commit $B |
+	git hash-object -t commit -w --stdin &&
 
-      git --git-dir=../.git cat-file tree "$B^{tree}" |
-      git hash-object -t tree -w --stdin
-     ) &&
-     C=$(git --git-dir=patch_clone/.git rev-parse HEAD)
-    '
+	git --git-dir=../.git cat-file tree "$B^{tree}" |
+	git hash-object -t tree -w --stdin
+	) &&
+	C=$(git --git-dir=patch_clone/.git rev-parse HEAD)
+'
 
 # Clone patch_clone indirectly by cloning base and fetching.
 #
-test_expect_success \
-    'indirectly clone patch_clone' \
-    '(mkdir user_clone &&
-      cd user_clone &&
-      git init &&
-      git pull ../.git &&
-      test $(git rev-parse HEAD) = $B &&
+test_expect_success 'indirectly clone patch_clone' '
+	(mkdir user_clone &&
+	 cd user_clone &&
+	 git init &&
+	 git pull ../.git &&
+	 test $(git rev-parse HEAD) = $B &&
 
-      git pull ../patch_clone/.git &&
-      test $(git rev-parse HEAD) = $C
-     )
-    '
+	 git pull ../patch_clone/.git &&
+	 test $(git rev-parse HEAD) = $C
+	)
+'
 
 # Cloning the patch_clone directly should fail.
 #
-test_expect_success \
-    'clone of patch_clone is incomplete' \
-    '(mkdir user_direct &&
-      cd user_direct &&
-      git init &&
-      test_must_fail git fetch ../patch_clone/.git
-     )
-    '
+test_expect_success 'clone of patch_clone is incomplete' '
+	(mkdir user_direct &&
+	 cd user_direct &&
+	 git init &&
+	 test_must_fail git fetch ../patch_clone/.git
+	)
+'
 
 test_done
-- 
gitgitgadget

