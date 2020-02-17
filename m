Return-Path: <SRS0=dbxk=4F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D38FC34024
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 17:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6510F208C4
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 17:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJovBldT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729146AbgBQRPz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Feb 2020 12:15:55 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38184 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbgBQRPy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Feb 2020 12:15:54 -0500
Received: by mail-wm1-f68.google.com with SMTP id a9so91982wmj.3
        for <git@vger.kernel.org>; Mon, 17 Feb 2020 09:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=Kx1lPyhkyg6NIm7XY45aSDxNVxGQVEBK9qq9NxqmhP8=;
        b=IJovBldTkqtygjxcm7Ez1Dzrz8r2n/lQaewYeLkpNW4Dg8dh70fHs5cqres82dO4/3
         4vFRNFOLd/FwEKUaWY2d27TzTJ6Sp3p+bFYWIcvT44gaTmNOGozX77sljTfU8efEZgmy
         oROa1w8YXS4jpv0f+nY+m07xXKGKwLG0eAHEXP7nXco2Lmf1IduDsTFWBcU1CLLl3giw
         gP46xpCOOTnYrXlvQAk0SVyw0pdsN6mDk6thZ6EvfqhbLq9wbvCUsMWq6IYYaQfMEarV
         HxhCDLs3Ogx1IJD8fxtrrod/EfQsi9syQXrkuDLaUQd0oGROtlVLlhI4a+wNJWJXaSAT
         U+MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Kx1lPyhkyg6NIm7XY45aSDxNVxGQVEBK9qq9NxqmhP8=;
        b=UgnnJnjY+M2IWBlB1HUSbAOqoegUy960x0vA/8xySLdNGYhgLW58Cj3Y8FcgwDI99v
         Kd2Q0UGlXp5jtOaDHK8ZwLRhj6B/ud8UrhaJFZat81YqbMbT7Y+KVXV9Gcr+4tfmsbnW
         nlH3zzPVq1pynYBh7QlySfVRAKT/qUEZgpdHRQHdfs1s2G0nt3xOvq1oJE+QluYmiAxR
         AWFAPvgtiPYkEAxB7FOfR+p7wQOZaYWBMvTq/vlsChO0VeT6dq43CQQwL/Vg6dDeL06i
         u2CkPlR7LRh6ntgXRdSuFvmPkodBW/Zb65Yq1uKomqDiG/X4PCW84NAUTIj0OfH1vAYX
         ZwJg==
X-Gm-Message-State: APjAAAXEY/6XylqEw/vOJ8nqVgxR1zYAFHvCl8jTBgsQDtg7b6oCqCay
        iBrZuLC8SCsmPZ0LtFw28Ml03smA
X-Google-Smtp-Source: APXvYqw1114G70WFtmbysazenpa17RSXpw3pitst0gHZGkBzpbDZuhvD71bg44TPtTlXCQoBlbAzlg==
X-Received: by 2002:a1c:4e01:: with SMTP id g1mr76635wmh.12.1581959752464;
        Mon, 17 Feb 2020 09:15:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n3sm1726025wrs.8.2020.02.17.09.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 09:15:52 -0800 (PST)
Message-Id: <pull.712.git.git.1581959751454.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 17 Feb 2020 17:15:51 +0000
Subject: [PATCH] t3424: new rebase testcase documenting a stat-dirty-like
 failure
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
    t3424: new rebase testcase documenting a stat-dirty-like failure
    
    A user discovered a case where they had a stack of 20 simple commits to
    rebase, and the rebase would succeed in picking the first commit and
    then error out with a pair of "Could not execute the todo command" and
    "Your local changes to the following files would be overwritten by
    merge" messages.
    
    Their steps actually made use of the -i flag, but I switched it over to
    -m to make it simpler to trigger the bug. With that flag, it bisects
    back to commit 68aa495b590d (rebase: implement --merge via the
    interactive machinery, 2018-12-11), but that's misleading. If you change
    the -m flag to --keep-empty, then the problem persists and will bisect
    back to 356ee4659bb5 (sequencer: try to commit without forking 'git
    commit', 2017-11-24)
    
    After playing with the testcase for a bit, I discovered that added
    --exec "sleep 1" to the command line makes the rebase succeed, making me
    suspect there is some kind of discard and reloading of caches that lead
    us to believe that something is stat dirty, but I didn't succeed in
    digging any further than that.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-712%2Fnewren%2Fdocument-rebase-failure-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-712/newren/document-rebase-failure-v1
Pull-Request: https://github.com/git/git/pull/712

 t/t3424-rebase-across-mode-change.sh | 52 ++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100755 t/t3424-rebase-across-mode-change.sh

diff --git a/t/t3424-rebase-across-mode-change.sh b/t/t3424-rebase-across-mode-change.sh
new file mode 100755
index 00000000000..4d2eb1dd7c6
--- /dev/null
+++ b/t/t3424-rebase-across-mode-change.sh
@@ -0,0 +1,52 @@
+#!/bin/sh
+
+test_description='git rebase across mode change'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	rm -rf ../stupid &&
+	git init ../stupid &&
+	cd ../stupid &&
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
+	ln -s unrelated DS &&
+	git add DS &&
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

base-commit: e68e29171cc2d6968902e0654b5687fbe1ccb903
-- 
gitgitgadget
