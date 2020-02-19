Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7D1C34047
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 17:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A895A24656
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 17:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YAgaewvn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgBSREQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 12:04:16 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45179 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbgBSREM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 12:04:12 -0500
Received: by mail-wr1-f66.google.com with SMTP id g3so1360294wrs.12
        for <git@vger.kernel.org>; Wed, 19 Feb 2020 09:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Llr17QW5JJ224Jw94L8+Bl39bNYTQs9W947z5RHGTf4=;
        b=YAgaewvnrm6AIBbrKUk2v/ZEU1lRlkzxl4DACrnCOEzbhc02K8teTveyGd+aKGGh5R
         GjCQfg/IEWxkZQdTXRi4D47eDIbPoqsFgQxM6PWClwSRau1KzI9zgRi5486p0MDZSA50
         urXO7CbVpj1LWnC2DPNXJS0RhdiE90imSkMbC1PknOFAGWWeoL3hRECZl+vnDKCKW884
         uoysYW3PnjZfiaqUvGQhmNSLhEy/MbzP8SsQQOUyQ0HbETrczeml9zFsgVL/u8dVN19+
         ylTDShodfdCtNO9J0eRauJ6GNV6XSgQkfxeKLtBp2F4BoWMouQcWGTu/8mCEfKzhEVCS
         bEmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Llr17QW5JJ224Jw94L8+Bl39bNYTQs9W947z5RHGTf4=;
        b=lBXNzzc0viVhIf6tGR1i/QVfI0ngqDMB+lh3gDnkP1AvcjbVKI9ar4PfukKZsRFFtC
         7+Aw7E+nwELeHKB5n8qcQla+gluBi3dwC3qXeraQ917U1lzShd/oM2xWIL0g4V9qz+uu
         vTU9uKzt1rkN9pPuTBHg7Prl6RBUO8CunpuaMk7w+rBcM+cgyMwi2lvxcTezqWc9FTUT
         2nyu56KtCmaVWCd46WNa3OvhyICV/2+gpkg+NsbqQCccnI3XqGGRft5zAPoCc90I8+xM
         QbkrNY8UedcHDfkcsqDlc6wL2seBs6ej/E2mX1IanfQMC9LNVpgX3J+HkWIkzaz3pDc+
         Jj/A==
X-Gm-Message-State: APjAAAVvsMlO9IxvlhMrDxDWiHLyI6hmnKuf4szWiTLypPcXGFO4Bbk/
        RLgwEz8AqQlC4XP1f172GYaPe2F9
X-Google-Smtp-Source: APXvYqxC4Znt32jHGZlftYlRUvnRN2FxKhhm9EqJvQT9JzNRKJU1bpS0f+SuqVkiphfKXgIf/ukRPw==
X-Received: by 2002:a5d:4d8d:: with SMTP id b13mr37157844wru.6.1582131849948;
        Wed, 19 Feb 2020 09:04:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f127sm569878wma.4.2020.02.19.09.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 09:04:09 -0800 (PST)
Message-Id: <270591cd3be783fd294039281c969a48ee718806.1582131847.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.712.v4.git.git.1582131847.gitgitgadget@gmail.com>
References: <pull.712.v3.git.git.1582064105813.gitgitgadget@gmail.com>
        <pull.712.v4.git.git.1582131847.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 19 Feb 2020 17:04:06 +0000
Subject: [PATCH v4 1/2] t3433: new rebase testcase documenting a
 stat-dirty-like failure
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

A user discovered a case where they had a stack of 20 simple commits to
rebase, and the rebase would succeed in picking the first commit and
then error out with a pair of "Could not execute the todo command" and
"Your local changes to the following files would be overwritten by
merge" messages.

Their steps actually made use of the -i flag, but I switched it over to
-m to make it simpler to trigger the bug.  With that flag, it bisects
back to commit 68aa495b590d (rebase: implement --merge via the
interactive machinery, 2018-12-11), but that's misleading.  If you
change the -m flag to --keep-empty, then the problem persists and will
bisect back to 356ee4659bb5 (sequencer: try to commit without forking
'git commit', 2017-11-24)

After playing with the testcase for a bit, I discovered that added
--exec "sleep 1" to the command line makes the rebase succeed, making me
suspect there is some kind of discard and reloading of caches that lead
us to believe that something is stat dirty, but I didn't succeed in
digging any further than that.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t3433-rebase-across-mode-change.sh | 48 ++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100755 t/t3433-rebase-across-mode-change.sh

diff --git a/t/t3433-rebase-across-mode-change.sh b/t/t3433-rebase-across-mode-change.sh
new file mode 100755
index 00000000000..f11fc35c3ee
--- /dev/null
+++ b/t/t3433-rebase-across-mode-change.sh
@@ -0,0 +1,48 @@
+#!/bin/sh
+
+test_description='git rebase across mode change'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	mkdir DS &&
+	>DS/whatever &&
+	git add DS &&
+	git commit -m base &&
+
+	git branch side1 &&
+	git branch side2 &&
+
+	git checkout side1 &&
+	git rm -rf DS &&
+	test_ln_s_add unrelated DS &&
+	git commit -m side1 &&
+
+	git checkout side2 &&
+	>unrelated &&
+	git add unrelated &&
+	git commit -m commit1 &&
+
+	echo >>unrelated &&
+	git commit -am commit2
+'
+
+test_expect_success 'rebase changes with the apply backend' '
+	test_when_finished "git rebase --abort || true" &&
+	git checkout -b apply-backend side2 &&
+	git rebase side1
+'
+
+test_expect_failure 'rebase changes with the merge backend' '
+	test_when_finished "git rebase --abort || true" &&
+	git checkout -b merge-backend side2 &&
+	git rebase -m side1
+'
+
+test_expect_success 'rebase changes with the merge backend with a delay' '
+	test_when_finished "git rebase --abort || true" &&
+	git checkout -b merge-delay-backend side2 &&
+	git rebase -m --exec "sleep 1" side1
+'
+
+test_done
-- 
gitgitgadget

