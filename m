Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA87C3DA78
	for <git@archiver.kernel.org>; Sat, 14 Jan 2023 18:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjANStw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Jan 2023 13:49:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjANStv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jan 2023 13:49:51 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF72786BA
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 10:49:49 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id k8so9397044wrc.9
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 10:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ySQTtnaB1Jit2q+r091eeZBJCiM4GEV2fU/LrqvN6Nk=;
        b=EB7/rqM5XKSizAQTidjGFbQizgNedEiMHMBrttSRjst38E0qkVvhrAdhksFzaz45P0
         wzEwENyk1aizlkf/LqurnrArMK8t4SWRhBuI7FZvT7TLidN5q/fUoIWMnXlCSTk/RUGl
         VP7LgF3q4PfnLXNczwYpXs5zXF8Dgav2ukV3IFvoAC0I3bO/YIzxKuAVSx+4xYUoOsNm
         P9PpW5POUOPwdjwhfnQNFd9fSryEwFfcxCateUEzZOX1hhOFSOmBQ0bGWmSxkEyQDcEh
         PaLr8EpjDEKPzpaQvpEZGp+fV33cv+svvQX0PYOLML3NG30U+Kumo49yRkNtjWMT20El
         PLpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ySQTtnaB1Jit2q+r091eeZBJCiM4GEV2fU/LrqvN6Nk=;
        b=sa5ewm4VqwftNMZg5MuljmHbOknUXSye4OYeLTH68+EZ12Fq0vHs6g7NT3okoPTTX0
         jL9B97tWObZnpGUeBx3qsdLfgNQ6TukRx/m3vHCESFj6MCGwoifM2wZBybDHIYUDjDdk
         WwKhwR5zLZ6yJuKc7Fhe0ptRQIy9B9khfamGBM3GYqyRUjEGznYNAUSC8b/AAAHCrL4k
         W1hpOHf6M7AjX54UPCE727cFUWP0n9ecAwRumeKgkp4i5YiJ5AJfawNogV7unAeLffQ5
         WcYbiVyIyjr+IAzKkB5W03I+VnRGfnhW2kfqbwdqGk3Q2RvkPXDTHXPA7UiFt+VN6OhV
         R3Yg==
X-Gm-Message-State: AFqh2kpv5BlrlklEOKpTNOXeLKG0M6FydBOAR1Bi/UOlqXlCR/41PL6z
        Mbvy+LMuXzBTB7/dY8zlCxUz6qAjWhI=
X-Google-Smtp-Source: AMrXdXsuU9/bwzzc2IQv53B6mU8Q181nzF2Sc5GXlRbHQHHocUAjHcycqpVOWqcrwv9KylqHwuwpNQ==
X-Received: by 2002:a5d:52c1:0:b0:242:5d8e:6c35 with SMTP id r1-20020a5d52c1000000b002425d8e6c35mr52327062wrv.28.1673722188011;
        Sat, 14 Jan 2023 10:49:48 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g2-20020a5d4882000000b00286ad197346sm22117515wrq.70.2023.01.14.10.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jan 2023 10:49:47 -0800 (PST)
Message-Id: <pull.1462.v2.git.1673722187025.gitgitgadget@gmail.com>
In-Reply-To: <pull.1462.git.1673584084761.gitgitgadget@gmail.com>
References: <pull.1462.git.1673584084761.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 14 Jan 2023 18:49:46 +0000
Subject: [PATCH v2] t6426: fix TODO about making test more comprehensive
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Andrei Rybak <rybak.a.v@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

t6426.7 (a rename/add testcase) long had a TODO/FIXME comment about
how the test could be improved (with some commented out sample code
that had a few small errors), but those improvements were blocked on
other changes still in progress.  The necessary changes were put in
place years ago but the comment was forgotten.  Remove and fix the
commented out code section and finally remove the big TODO/FIXME
comment.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
    t6426: fix TODO about making test more comprehensive
    
    See
    https://lore.kernel.org/git/CABPp-BFxK7SGs3wsOfozSw_Uvr-ynr+x8ciPV2Rmfx6Nr4si6g@mail.gmail.com/
    
    Changes since v1:
    
     * Removed spurious line, rearranged some lines so that checks on file
       "b" come before file "c".

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1462%2Fnewren%2Ft6426-fix-todo-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1462/newren/t6426-fix-todo-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1462

Range-diff vs v1:

 1:  6de47daaeeb ! 1:  68fd28e2547 t6426: fix TODO about making test more comprehensive
     @@ Commit message
      
       ## t/t6426-merge-skip-unneeded-updates.sh ##
      @@ t/t6426-merge-skip-unneeded-updates.sh: test_expect_success '2c: Modify b & add c VS rename b->c' '
     + 		test_i18ngrep "CONFLICT (.*/add):" out &&
     + 		test_must_be_empty err &&
       
     - 		# Make sure c WAS updated
     +-		# Make sure c WAS updated
     ++		git ls-files -s >index_files &&
     ++		test_line_count = 2 index_files &&
     ++
     ++		# Ensure b was removed
     ++		test_path_is_missing b &&
     ++
     ++		# Make sure c WAS updated...
       		test-tool chmtime --get c >new-mtime &&
      -		test $(cat old-mtime) -lt $(cat new-mtime)
      -
     @@ t/t6426-merge-skip-unneeded-updates.sh: test_expect_success '2c: Modify b & add
      -		#test_path_is_missing b
      +		test $(cat old-mtime) -lt $(cat new-mtime) &&
      +
     -+		git ls-files -s >index_files &&
     -+		test_line_count = 2 index_files &&
     -+
     ++		# ...and has correct index entries and working tree contents
      +		git rev-parse >actual :2:c :3:c &&
      +		git rev-parse >expect A:c  A:b  &&
      +		test_cmp expect actual &&
     @@ t/t6426-merge-skip-unneeded-updates.sh: test_expect_success '2c: Modify b & add
      +			-L "" \
      +			-L "B^0" \
      +			merged empty merge-me &&
     -+		sed -e "s/^\([<=>]\)/\1\1\1/" merged >merged-internal &&
     -+
     -+		test_cmp merged c &&
     -+
     -+		test_path_is_missing b
     ++		test_cmp merged c
       	)
       '
       


 t/t6426-merge-skip-unneeded-updates.sh | 58 ++++++++++----------------
 1 file changed, 23 insertions(+), 35 deletions(-)

diff --git a/t/t6426-merge-skip-unneeded-updates.sh b/t/t6426-merge-skip-unneeded-updates.sh
index 2bb8e7f09bb..fd21c1a4863 100755
--- a/t/t6426-merge-skip-unneeded-updates.sh
+++ b/t/t6426-merge-skip-unneeded-updates.sh
@@ -378,42 +378,30 @@ test_expect_success '2c: Modify b & add c VS rename b->c' '
 		test_i18ngrep "CONFLICT (.*/add):" out &&
 		test_must_be_empty err &&
 
-		# Make sure c WAS updated
+		git ls-files -s >index_files &&
+		test_line_count = 2 index_files &&
+
+		# Ensure b was removed
+		test_path_is_missing b &&
+
+		# Make sure c WAS updated...
 		test-tool chmtime --get c >new-mtime &&
-		test $(cat old-mtime) -lt $(cat new-mtime)
-
-		# FIXME: rename/add conflicts are horribly broken right now;
-		# when I get back to my patch series fixing it and
-		# rename/rename(2to1) conflicts to bring them in line with
-		# how add/add conflicts behave, then checks like the below
-		# could be added.  But that patch series is waiting until
-		# the rename-directory-detection series lands, which this
-		# is part of.  And in the mean time, I do not want to further
-		# enforce broken behavior.  So for now, the main test is the
-		# one above that err is an empty file.
-
-		#git ls-files -s >index_files &&
-		#test_line_count = 2 index_files &&
-
-		#git rev-parse >actual :2:c :3:c &&
-		#git rev-parse >expect A:b  A:c  &&
-		#test_cmp expect actual &&
-
-		#git cat-file -p A:b >>merged &&
-		#git cat-file -p A:c >>merge-me &&
-		#>empty &&
-		#test_must_fail git merge-file \
-		#	-L "Temporary merge branch 1" \
-		#	-L "" \
-		#	-L "Temporary merge branch 2" \
-		#	merged empty merge-me &&
-		#sed -e "s/^\([<=>]\)/\1\1\1/" merged >merged-internal &&
-
-		#git hash-object c               >actual &&
-		#git hash-object merged-internal >expect &&
-		#test_cmp expect actual &&
-
-		#test_path_is_missing b
+		test $(cat old-mtime) -lt $(cat new-mtime) &&
+
+		# ...and has correct index entries and working tree contents
+		git rev-parse >actual :2:c :3:c &&
+		git rev-parse >expect A:c  A:b  &&
+		test_cmp expect actual &&
+
+		git cat-file -p A:b >>merge-me &&
+		git cat-file -p A:c >>merged &&
+		>empty &&
+		test_must_fail git merge-file \
+			-L "HEAD" \
+			-L "" \
+			-L "B^0" \
+			merged empty merge-me &&
+		test_cmp merged c
 	)
 '
 

base-commit: 2b4f5a4e4bb102ac8d967cea653ed753b608193c
-- 
gitgitgadget
