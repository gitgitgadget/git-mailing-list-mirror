Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5181C77B73
	for <git@archiver.kernel.org>; Thu, 18 May 2023 20:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjERUDk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 May 2023 16:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjERUDe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2023 16:03:34 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D94E67
        for <git@vger.kernel.org>; Thu, 18 May 2023 13:03:31 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f417ea5252so17266565e9.0
        for <git@vger.kernel.org>; Thu, 18 May 2023 13:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684440209; x=1687032209;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tzV4wVFo//TRu5Plv9svc9Lx25oe/PItemyJ6O+4IuE=;
        b=IMqfckTxreA/p8ey0HeZDtg84XbIgYKGZVX37ywHqKYCu+hwjOVLi+0ra9RADTwIqP
         nbo7k4AmXW9+AnEUNiomrkjKdRUL494dmxeB1eAz2vWYpdgXeCzSV2AaayTa6qRJE2mY
         MSnDCfY2yGqssC2v3gPFwTn4XpaQIfteAPQjnnKbY+Jh4bbxOmSxErTd6PoZnRd45jKG
         HJkafa6rGGBB/5nZGJaV8xXR5v9sTPfFljHpGeC80Zg+6s9+Hj2SHK+Z7eWjLl4P4gTr
         9d31L0+mkfyPRo1U4rXqEz7e1kcK51v9c4Bu/JP87wOB5GfusGcvJjFOGvIfwalL5Ssd
         AR9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684440209; x=1687032209;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tzV4wVFo//TRu5Plv9svc9Lx25oe/PItemyJ6O+4IuE=;
        b=Vw5E9B7/oQpeotxv5etSSy0z8dCd77OqCmOs60f1BSOoRYGDeF67GTnFHjU1FNdtzw
         7uLKi2GH0O87K9rhdo+LN9sxOO4wGK/Kb7wEPW0zfOASE+A4FXzDub8VLjLeLc5zHMfQ
         jsz2hRvts3DGjRjMQ1Js0LDgGchhgHzK+1K23WTigu1mimlTzmyLjJH5Nqx/srMbenMp
         yfB5MuDUsUoznCTm6lHgfvU4A3QHm9Ax7zXi3pk24BL4nwE7GSw+92DURoZ2stl6niQH
         /51HWvFbQ1sApSwNiX9vmKqI7aY4GXHpsrhZkHbW9u8Cmh/T5gIll8viPeg/l6alKSlV
         +muw==
X-Gm-Message-State: AC+VfDxXs5PAlwbUZ1PGv3HuO1tgxSU89245tb7cs76tZdK0mCQXEIQU
        K2NMA3Ux48F1Wj85fdnhcTR4Z3afn9w=
X-Google-Smtp-Source: ACHHUZ4pIEtpnuMYbf2eDtUKwj/G0ScYaQK7fFwa1U50ITKUNeDg5pCJBHGSVrCusaKaEzGORX9jyw==
X-Received: by 2002:a05:600c:21c4:b0:3f5:1241:6cfa with SMTP id x4-20020a05600c21c400b003f512416cfamr2368247wmj.37.1684440209183;
        Thu, 18 May 2023 13:03:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p22-20020a7bcc96000000b003f4b6bcbd8bsm201797wma.31.2023.05.18.13.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 13:03:29 -0700 (PDT)
Message-Id: <4fe5e5cf9e068d20bbec3580df3030cd74ca4122.1684440205.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1513.git.git.1684440205.gitgitgadget@gmail.com>
References: <pull.1513.git.git.1684440205.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 18 May 2023 20:03:08 +0000
Subject: [PATCH 03/20] t3210-pack-refs: modernize test format
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

Some tests in t3210-pack-refs.sh used the older four space indent format.
Update these to use tabs.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 t/t3210-pack-refs.sh | 154 +++++++++++++++++++++----------------------
 1 file changed, 77 insertions(+), 77 deletions(-)

diff --git a/t/t3210-pack-refs.sh b/t/t3210-pack-refs.sh
index 07a0ff93def..4e449ecffc4 100755
--- a/t/t3210-pack-refs.sh
+++ b/t/t3210-pack-refs.sh
@@ -19,101 +19,101 @@ test_expect_success 'enable reflogs' '
 	git config core.logallrefupdates true
 '
 
-test_expect_success \
-    'prepare a trivial repository' \
-    'echo Hello > A &&
-     git update-index --add A &&
-     git commit -m "Initial commit." &&
-     HEAD=$(git rev-parse --verify HEAD)'
+test_expect_success 'prepare a trivial repository' '
+	echo Hello > A &&
+	git update-index --add A &&
+	git commit -m "Initial commit." &&
+	HEAD=$(git rev-parse --verify HEAD)
+'
 
 SHA1=
 
-test_expect_success \
-    'see if git show-ref works as expected' \
-    'git branch a &&
-     SHA1=$(cat .git/refs/heads/a) &&
-     echo "$SHA1 refs/heads/a" >expect &&
-     git show-ref a >result &&
-     test_cmp expect result'
-
-test_expect_success \
-    'see if a branch still exists when packed' \
-    'git branch b &&
-     git pack-refs --all &&
-     rm -f .git/refs/heads/b &&
-     echo "$SHA1 refs/heads/b" >expect &&
-     git show-ref b >result &&
-     test_cmp expect result'
+test_expect_success 'see if git show-ref works as expected' '
+	git branch a &&
+	SHA1=$(cat .git/refs/heads/a) &&
+	echo "$SHA1 refs/heads/a" >expect &&
+	git show-ref a >result &&
+	test_cmp expect result
+'
+
+test_expect_success 'see if a branch still exists when packed' '
+	git branch b &&
+	git pack-refs --all &&
+	rm -f .git/refs/heads/b &&
+	echo "$SHA1 refs/heads/b" >expect &&
+	git show-ref b >result &&
+	test_cmp expect result
+'
 
 test_expect_success 'git branch c/d should barf if branch c exists' '
-     git branch c &&
-     git pack-refs --all &&
-     rm -f .git/refs/heads/c &&
-     test_must_fail git branch c/d
+	git branch c &&
+	git pack-refs --all &&
+	rm -f .git/refs/heads/c &&
+	test_must_fail git branch c/d
 '
 
-test_expect_success \
-    'see if a branch still exists after git pack-refs --prune' \
-    'git branch e &&
-     git pack-refs --all --prune &&
-     echo "$SHA1 refs/heads/e" >expect &&
-     git show-ref e >result &&
-     test_cmp expect result'
+test_expect_success 'see if a branch still exists after git pack-refs --prune' '
+	git branch e &&
+	git pack-refs --all --prune &&
+	echo "$SHA1 refs/heads/e" >expect &&
+	git show-ref e >result &&
+	test_cmp expect result
+'
 
 test_expect_success 'see if git pack-refs --prune remove ref files' '
-     git branch f &&
-     git pack-refs --all --prune &&
-     ! test -f .git/refs/heads/f
+	git branch f &&
+	git pack-refs --all --prune &&
+	! test -f .git/refs/heads/f
 '
 
 test_expect_success 'see if git pack-refs --prune removes empty dirs' '
-     git branch r/s/t &&
-     git pack-refs --all --prune &&
-     ! test -e .git/refs/heads/r
+	git branch r/s/t &&
+	git pack-refs --all --prune &&
+	! test -e .git/refs/heads/r
 '
 
-test_expect_success \
-    'git branch g should work when git branch g/h has been deleted' \
-    'git branch g/h &&
-     git pack-refs --all --prune &&
-     git branch -d g/h &&
-     git branch g &&
-     git pack-refs --all &&
-     git branch -d g'
+test_expect_success 'git branch g should work when git branch g/h has been deleted' '
+	git branch g/h &&
+	git pack-refs --all --prune &&
+	git branch -d g/h &&
+	git branch g &&
+	git pack-refs --all &&
+	git branch -d g
+'
 
 test_expect_success 'git branch i/j/k should barf if branch i exists' '
-     git branch i &&
-     git pack-refs --all --prune &&
-     test_must_fail git branch i/j/k
+	git branch i &&
+	git pack-refs --all --prune &&
+	test_must_fail git branch i/j/k
+'
+
+test_expect_success 'test git branch k after branch k/l/m and k/lm have been deleted' '
+	git branch k/l &&
+	git branch k/lm &&
+	git branch -d k/l &&
+	git branch k/l/m &&
+	git branch -d k/l/m &&
+	git branch -d k/lm &&
+	git branch k
 '
 
-test_expect_success \
-    'test git branch k after branch k/l/m and k/lm have been deleted' \
-    'git branch k/l &&
-     git branch k/lm &&
-     git branch -d k/l &&
-     git branch k/l/m &&
-     git branch -d k/l/m &&
-     git branch -d k/lm &&
-     git branch k'
-
-test_expect_success \
-    'test git branch n after some branch deletion and pruning' \
-    'git branch n/o &&
-     git branch n/op &&
-     git branch -d n/o &&
-     git branch n/o/p &&
-     git branch -d n/op &&
-     git pack-refs --all --prune &&
-     git branch -d n/o/p &&
-     git branch n'
-
-test_expect_success \
-	'see if up-to-date packed refs are preserved' \
-	'git branch q &&
-	 git pack-refs --all --prune &&
-	 git update-ref refs/heads/q refs/heads/q &&
-	 ! test -f .git/refs/heads/q'
+test_expect_success 'test git branch n after some branch deletion and pruning' '
+	git branch n/o &&
+	git branch n/op &&
+	git branch -d n/o &&
+	git branch n/o/p &&
+	git branch -d n/op &&
+	git pack-refs --all --prune &&
+	git branch -d n/o/p &&
+	git branch n
+'
+
+test_expect_success A'see if up-to-date packed refs are preserved' '
+	git branch q &&
+	git pack-refs --all --prune &&
+	git update-ref refs/heads/q refs/heads/q &&
+	! test -f .git/refs/heads/q
+'
 
 test_expect_success 'pack, prune and repack' '
 	git tag foo &&
-- 
gitgitgadget

