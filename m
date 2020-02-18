Return-Path: <SRS0=PlGQ=4G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E941CC34031
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 20:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA927206F4
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 20:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uCNikcyb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgBRUze (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Feb 2020 15:55:34 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36508 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgBRUze (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Feb 2020 15:55:34 -0500
Received: by mail-wm1-f66.google.com with SMTP id p17so4443832wma.1
        for <git@vger.kernel.org>; Tue, 18 Feb 2020 12:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=29848wnZeaYhrlVfMlpHzNbq5QlSNuDHE6Z/XSNTVO8=;
        b=uCNikcybaHkQfTbbyLcFS3+3zmMXFAGAltlAFOXNxKllZEpvgoXr8q21I32CQSfgUU
         kjc/4Rck3cLc5UuIen8AygqcBL7BWOnzduqO1viVJEzFbr/11wygo9MFYo75f8ncchr2
         pWKiJHKXC7nzHX438ZVezMPnPtTeKim0h0a8Y3ZRvbQH6Xe2t6TwVoymb6yxIvRfpQTO
         iToxCtie1yeS545kusKO9r/qbaPNo3HWoF6KKPdwGgPwCHPjuebg7LBBJzgs1IZ2UGBx
         OrQbX019GXeZsB+JxGw+M9e/qvny+4x+iAkegoCslgMAW5U72YB1mVs8ikNAXSk9b213
         tpTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=29848wnZeaYhrlVfMlpHzNbq5QlSNuDHE6Z/XSNTVO8=;
        b=q0Zz1oPsHzFHXrhhH84K9Qf6K/s1f/B7SHrBCl4aFa/MqFJ4iAYmiLgLVbYF3emWPr
         ncmjC3ocq+jfcnMpMv1KTGynVWOrg6PNXNIhIM+NLDBOBK4VXvlQDBSjQkKNq8ZcvXrm
         mtSjEgEEVLk4z7xT3EBAD/F/53tQUv1KrkBVvTqYxMKbdYhOXPTtYWL+rP0ShnLLpkPC
         NaKCR1DNUEA7u/ji3RivoJ4Y45WjRwsejWhuLTHRoC9R5vink6Sk093IqwgGlEoUx0fW
         4lL7Wk2qPsTvVHC5yrhyMjghbLiNbwUYQPFnksU7bunrihaSMBV0MaBhsh08VFWcQejh
         bNDw==
X-Gm-Message-State: APjAAAWvE3cQtYM2tRsB0hy6su0oMQUG1zqpWl8GPbuJ0LaDDjxo5msF
        ksLfzKdSPWoZkuyIU3WEC+ZY33CV
X-Google-Smtp-Source: APXvYqzTtVqJncS4LUNiO6ufMFq+KSrm2J12lsZBSmsuMgdkSrM4s2v9gJLtS5eDmojCoZNusH9RMw==
X-Received: by 2002:a7b:c119:: with SMTP id w25mr5180074wmi.116.1582059332325;
        Tue, 18 Feb 2020 12:55:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w13sm7710332wru.38.2020.02.18.12.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 12:55:31 -0800 (PST)
Message-Id: <pull.712.v2.git.git.1582059331257.gitgitgadget@gmail.com>
In-Reply-To: <pull.712.git.git.1581959751454.gitgitgadget@gmail.com>
References: <pull.712.git.git.1581959751454.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 18 Feb 2020 20:55:31 +0000
Subject: [PATCH v2] t3424: new rebase testcase documenting a stat-dirty-like
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
    
    Remove extraneous lines and make use of test_ln_s_add to make the test
    work on Windows

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-712%2Fnewren%2Fdocument-rebase-failure-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-712/newren/document-rebase-failure-v2
Pull-Request: https://github.com/git/git/pull/712

Range-diff vs v1:

 1:  ca79ca3ed8a ! 1:  09085292596 t3424: new rebase testcase documenting a stat-dirty-like failure
     @@ -36,9 +36,6 @@
      +. ./test-lib.sh
      +
      +test_expect_success 'setup' '
     -+	rm -rf ../stupid &&
     -+	git init ../stupid &&
     -+	cd ../stupid &&
      +	mkdir DS &&
      +	>DS/whatever &&
      +	git add DS &&
     @@ -49,8 +46,7 @@
      +
      +	git checkout side1 &&
      +	git rm -rf DS &&
     -+	ln -s unrelated DS &&
     -+	git add DS &&
     ++	test_ln_s_add unrelated DS &&
      +	git commit -m side1 &&
      +
      +	git checkout side2 &&


 t/t3424-rebase-across-mode-change.sh | 48 ++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100755 t/t3424-rebase-across-mode-change.sh

diff --git a/t/t3424-rebase-across-mode-change.sh b/t/t3424-rebase-across-mode-change.sh
new file mode 100755
index 00000000000..f11fc35c3ee
--- /dev/null
+++ b/t/t3424-rebase-across-mode-change.sh
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

base-commit: e68e29171cc2d6968902e0654b5687fbe1ccb903
-- 
gitgitgadget
