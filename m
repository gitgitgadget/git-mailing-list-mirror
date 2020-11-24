Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D382C56202
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 11:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A5CE2076E
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 11:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tZg8lG1/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733080AbgKXLzB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 06:55:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733076AbgKXLzA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 06:55:00 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FA1C061A4D
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 03:54:59 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id e7so4491612wrv.6
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 03:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WTCa6INZPOFYOAu2Y8zGwOBG2/F9rU7whH24/pkBr9M=;
        b=tZg8lG1/FAIlqY44Bu/+ez5xZgO0B9nVz5VXscl3YyRirVuWsMIBdahJOONB/FGp0L
         ASoQJEELfqn8UuXMnLyJIpfYDpp5f7YcH7P+ec6EQiOt0eiHaDemgX3PN3KPcofTFEb5
         lYlDtSB2r3fakBZkP0R17kUTfMHbYcdY1sFzS+7EAMqHDZ5ERkMKOYC0Q+QgcyC2PSZz
         bSIhvfJjjWVQ/HsbupumT7zmxKb7X9YrtkrPZ4VNFsBAQrFuaXAv9B6P+6j0OI2djLhY
         Wg7Y98bPxifRdfQFloTwVqL099xYiPMy+b+avlw+FGxJwdeuuSx7gcHRXTLZx/qyh3kO
         ycOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WTCa6INZPOFYOAu2Y8zGwOBG2/F9rU7whH24/pkBr9M=;
        b=k3d1WZzr5yVvaD0KHcxsmZSHdlRnjbCnkIOb6/8b2JVx3elP4M3rXWd2TNhGVcuXUi
         qXFdgFzTjhqZsijwdN1/wanREIKyLGUyeL64+3YFyD76l2eJBqPEV5PeBmXN+p5suAiC
         cWTsZ6yVBnfP2Tve7MhDdhjricjC1rzsSFv3ZnMvo2fGJz9w/Taf208H5xDt4YGVaZJX
         xqRpylGt1wSNvD923ACc22btyiul8EHg9fEXxl02OCgokw4r17qbsEQrozpnYDhxo1WU
         xofcu+huP5xHHXNTYiNm+rti0Ou1MUy/3+/hx3czP6G9mjzy6AVMrlF60w12RMOiQQNA
         X2KA==
X-Gm-Message-State: AOAM531mtzzQN39og+TavypwobML9CBvFQmA0bF2K4+fgeGlptvFXTP9
        75F22dEA9X0Aw7nj+t9Rzfk5SK/pXqE=
X-Google-Smtp-Source: ABdhPJx/1V1rrn1YbHlALHVyt21JMOD0eibIGTD4e8rk/7ylwo7fiCdyeqaazoG1/hdPIiWsnO/zdw==
X-Received: by 2002:a5d:4d90:: with SMTP id b16mr1652159wru.304.1606218897607;
        Tue, 24 Nov 2020 03:54:57 -0800 (PST)
Received: from ylate.lan (atoulouse-654-1-307-224.w86-199.abo.wanadoo.fr. [86.199.90.224])
        by smtp.googlemail.com with ESMTPSA id l13sm25893227wrm.24.2020.11.24.03.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 03:54:57 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v6 02/13] t6060: modify multiple files to expose a possible issue with merge-index
Date:   Tue, 24 Nov 2020 12:53:04 +0100
Message-Id: <20201124115315.13311-3-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201124115315.13311-1-alban.gruin@gmail.com>
References: <20201116102158.8365-1-alban.gruin@gmail.com>
 <20201124115315.13311-1-alban.gruin@gmail.com>
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
2.29.2.260.ge31aba42fb

