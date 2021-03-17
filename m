Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C08C43381
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 20:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8D0F64F40
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 20:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233532AbhCQU5H (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 16:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233501AbhCQU4i (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 16:56:38 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36CB3C06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 13:56:38 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id y124-20020a1c32820000b029010c93864955so4164617wmy.5
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 13:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wRcBNXYW2gw2O82+WA1enNKfsLCGikFYVSt/sUey6j8=;
        b=sAz0zjLEXfT0ZVqELp82GZIQ6WQ+PhWfc8bY6601/OGu9DaSbsKanB3lZmLbIX68Qa
         TteSZV7Nov6hhkpIXkHbzAke0wBVY7zfPUScPZTJ1qvTqmdP1y+pdYZHuuqh2B9KSXlK
         27uOTPv8X5ZkdHwDEO24Xg190rc8I+WQ4dxGgyBLVP8xbI1RF0gp9dD6s/XzVrhEiypv
         20S2xeLdvTtj+0oEKBb7tMyp/HBbnvN+dbXTy/HHrWMPevvc+/ms0zOORHvzA8CygaWL
         MuDCS/h7GleSjB5VnA772Zw6TdE68oGch1gHSLzEKw1Oph0W0jESiKA6426JyXy41Wk0
         bgGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wRcBNXYW2gw2O82+WA1enNKfsLCGikFYVSt/sUey6j8=;
        b=lnrpBMWJxiwqDzOxNGlknEN4eTRkqykaRVk14WZuVEyTIrtceX3SvN3LMnpvzteq5c
         S1CUDP7bvRAmxOpW6Vwnq2jsNJbvzxVBNMbjFBsHMfzsaxUweZhmnpAXANSI6K9ekGYM
         XG+WtxVPVam1F0OWEf3BMiJ2cXnUdhKV57Eg/QwUeAOPZ7iB7V2KMwxPlAXEzxeQGPrz
         iG7Ae1EAe1QW2CgJ2MyceEggrfmJCUNsQRe1AkcdN/ulMIGu7aPt8eMvGWx/eb11CYzK
         arm3QOsb2OpKiOBd4Hut3QC6XuGC1vmbwAqKhY+mCr262zLs3hMFTBn1OJ9UDWHiPUJo
         HZdg==
X-Gm-Message-State: AOAM533SInjRVDe0A4WghpB6b/RQ6mmVf81ZRDunK1ISgf1plrQknHmh
        yMjb/QXoSGSwYKkr3IG+7RvnWkwqLM8=
X-Google-Smtp-Source: ABdhPJyNNIWInqvkxKpAoiJmwb4D8tirM9nkqyxVzN5JC8K0+IikSY3+x/TGzVz0Vf7PR/8ctJ8sBw==
X-Received: by 2002:a7b:cd8f:: with SMTP id y15mr554937wmj.185.1616014596930;
        Wed, 17 Mar 2021 13:56:36 -0700 (PDT)
Received: from ylate.lan (atoulouse-654-1-299-135.w86-199.abo.wanadoo.fr. [86.199.82.135])
        by smtp.googlemail.com with ESMTPSA id g5sm158452wrq.30.2021.03.17.13.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 13:56:36 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v7 02/15] t6060: modify multiple files to expose a possible issue with merge-index
Date:   Wed, 17 Mar 2021 21:49:26 +0100
Message-Id: <20210317204939.17890-3-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210317204939.17890-1-alban.gruin@gmail.com>
References: <20201124115315.13311-1-alban.gruin@gmail.com>
 <20210317204939.17890-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, merge-index iterates over every index entry, skipping stage0
entries.  It will then count how many entries following the current one
have the same name, then fork to do the merge.  It will then increase
the iterator by the number of entries to skip them.  This behaviour is
correct, as even if the subprocess modifies the index, merge-index does
not reload it at all.

But when it will be rewritten to use a function, the index it will use
will be modified and may shrink when a conflict happens or if a file is
removed, so we have to be careful to handle such cases.

Here is an example:

 *    Merge branches, file1 and file2 are trivially mergeable.
 |\
 | *  Modifies file1 and file2.
 * |  Modifies file1 and file2.
 |/
 *    Adds file1 and file2.

When the merge happens, the index will look like that:

 i -> 0. file1 (stage1)
      1. file1 (stage2)
      2. file1 (stage3)
      3. file2 (stage1)
      4. file2 (stage2)
      5. file2 (stage3)

merge-index handles `file1' first.  As it appears 3 times after the
iterator, it is merged.  The index is now stale, `i' is increased by 3,
and the index now looks like this:

      0. file1 (stage1)
      1. file1 (stage2)
      2. file1 (stage3)
 i -> 3. file2 (stage1)
      4. file2 (stage2)
      5. file2 (stage3)

`file2' appears three times too, so it is merged.

With a naive rewrite, the index would look like this:

      0. file1 (stage0)
      1. file2 (stage1)
      2. file2 (stage2)
 i -> 3. file2 (stage3)

`file2' appears once at the iterator or after, so it will be added,
_not_ merged.  Which is wrong.

A naive rewrite would lead to unproperly merged files, or even files not
handled at all.

This changes t6060 to reproduce this case, by creating 2 files instead
of 1, to check the correctness of the soon-to-be-rewritten merge-index.
The files are identical, which is not really important -- the factors
that could trigger this issue are that they should be separated by at
most one entry in the index, and that the first one in the index should
be trivially mergeable.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 t/t6060-merge-index.sh | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/t/t6060-merge-index.sh b/t/t6060-merge-index.sh
index ddf34f0115..9e15ceb957 100755
--- a/t/t6060-merge-index.sh
+++ b/t/t6060-merge-index.sh
@@ -7,16 +7,19 @@ test_expect_success 'setup diverging branches' '
 	for i in 1 2 3 4 5 6 7 8 9 10; do
 		echo $i
 	done >file &&
-	git add file &&
+	cp file file2 &&
+	git add file file2 &&
 	git commit -m base &&
 	git tag base &&
 	sed s/2/two/ <file >tmp &&
 	mv tmp file &&
+	cp file file2 &&
 	git commit -a -m two &&
 	git tag two &&
 	git checkout -b other HEAD^ &&
 	sed s/10/ten/ <file >tmp &&
 	mv tmp file &&
+	cp file file2 &&
 	git commit -a -m ten &&
 	git tag ten
 '
@@ -35,8 +38,11 @@ ten
 EOF
 
 test_expect_success 'read-tree does not resolve content merge' '
+	cat >expect <<-\EOF &&
+	file
+	file2
+	EOF
 	git read-tree -i -m base ten two &&
-	echo file >expect &&
 	git diff-files --name-only --diff-filter=U >unmerged &&
 	test_cmp expect unmerged
 '
-- 
2.31.0

