Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF69C77B7A
	for <git@archiver.kernel.org>; Sat, 20 May 2023 16:14:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbjETQON (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 May 2023 12:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbjETQOG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2023 12:14:06 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82435125
        for <git@vger.kernel.org>; Sat, 20 May 2023 09:14:05 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-30644c18072so2787600f8f.2
        for <git@vger.kernel.org>; Sat, 20 May 2023 09:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684599244; x=1687191244;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sHwtL0xYMkRMvlNmjMvdbIByoM2zyOmpjE1feWKhVTo=;
        b=HUspz8pQKCPLgOpcyPS+4U396MyIpfLUamCfbMntmDOCIll412i5E+8W3CYpgs8cOE
         bmsX1PAra+N6aLkldIoMfZLoshy8idlwVNGPmNnnyfArHEiDz5uMTDnYsSm5zG/3l4fB
         T2EdmpjvMUYhIYF1YnsMqf2LvKsI0nxGxxzXvMjxVEMZ8ytpS/aW0W3qJ7mfGVnIBja1
         Zul+Or+TLM59FDxPcLhs6SFT8bSJ8DXJB98kyTi23wZytLYcnbc6dsFKOY7yDj/UTWPS
         yxEbqtknHHY2o5qhl1PUS8Ui1C0Ee5wY3pmDR06d37bLZnT+iNp/cjn0Js41uturAqDY
         xayA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684599244; x=1687191244;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sHwtL0xYMkRMvlNmjMvdbIByoM2zyOmpjE1feWKhVTo=;
        b=IQcnLu2HTrKzLibsJxhR0U3Y6ysz748jjXA1PgcWaFZghnpvXrU30UcaKeFDaoU94b
         kIwrpoJ4CB5o2Zk+Cq8EcK/zuAjqGgLRxKjw8uIwh09bnCBgfofLBhni+wmrUMj+qfAv
         m9RE0m4H0dBPazM40Km5E/mjCbVpJHwPv1dnqV6gSrsxm5HxBQpZfMXcOdm+rO1eOFV+
         y6tGNaWG04CxREwRx/j3zC43fEzJ/P+4077X0HR6qgF0kgQAY+Q/Za3jNV6tUOsTsoBl
         DiwUQN2UGCSyq+3b6E2dkJsmBQHFcW6biU1/hnXC1abLU2b0e1j7NhXoKdNl0oqBCucL
         0VRw==
X-Gm-Message-State: AC+VfDxxpEf4z48YQd/jQdVpe5eT5TY3Amq60epfuQjZ5rk6k2OA9WuY
        l002MkX+p0whWllCH4UxPlu6PK2jGiA=
X-Google-Smtp-Source: ACHHUZ7+VK9H7HfmMw9zkXTDfIhkxo92Sucd/fUalUm7WZrmTH9zyOOwu0vt4y7VeNlfwJZek9wQGQ==
X-Received: by 2002:adf:cc87:0:b0:30a:37aa:1fab with SMTP id p7-20020adfcc87000000b0030a37aa1fabmr1244271wrj.6.1684599243760;
        Sat, 20 May 2023 09:14:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l17-20020adfe591000000b003079c402762sm2338576wrm.19.2023.05.20.09.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 May 2023 09:14:03 -0700 (PDT)
Message-Id: <4774e05d099234887acb210af86a7ce484b6def9.1684599239.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1514.git.git.1684599239.gitgitgadget@gmail.com>
References: <pull.1514.git.git.1684599239.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 20 May 2023 16:13:53 +0000
Subject: [PATCH 05/10] t7600-merge: modernize test format
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
 t/t7600-merge.sh | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 060e145957f..fdc607277c2 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -639,41 +639,41 @@ test_expect_success 'merge log message' '
 test_debug 'git log --graph --decorate --oneline --all'
 
 test_expect_success 'merge c1 with c0, c2, c0, and c1' '
-       git reset --hard c1 &&
-       test_tick &&
-       git merge c0 c2 c0 c1 &&
-       verify_merge file result.1-5 &&
-       verify_parents $c1 $c2
+	git reset --hard c1 &&
+	test_tick &&
+	git merge c0 c2 c0 c1 &&
+	verify_merge file result.1-5 &&
+	verify_parents $c1 $c2
 '
 
 test_debug 'git log --graph --decorate --oneline --all'
 
 test_expect_success 'merge c1 with c0, c2, c0, and c1' '
-       git reset --hard c1 &&
-       test_tick &&
-       git merge c0 c2 c0 c1 &&
-       verify_merge file result.1-5 &&
-       verify_parents $c1 $c2
+	git reset --hard c1 &&
+	test_tick &&
+	git merge c0 c2 c0 c1 &&
+	verify_merge file result.1-5 &&
+	verify_parents $c1 $c2
 '
 
 test_debug 'git log --graph --decorate --oneline --all'
 
 test_expect_success 'merge c1 with c1 and c2' '
-       git reset --hard c1 &&
-       test_tick &&
-       git merge c1 c2 &&
-       verify_merge file result.1-5 &&
-       verify_parents $c1 $c2
+	git reset --hard c1 &&
+	test_tick &&
+	git merge c1 c2 &&
+	verify_merge file result.1-5 &&
+	verify_parents $c1 $c2
 '
 
 test_debug 'git log --graph --decorate --oneline --all'
 
 test_expect_success 'merge fast-forward in a dirty tree' '
-       git reset --hard c0 &&
-       mv file file1 &&
-       cat file1 >file &&
-       rm -f file1 &&
-       git merge c2
+	git reset --hard c0 &&
+	mv file file1 &&
+	cat file1 >file &&
+	rm -f file1 &&
+	git merge c2
 '
 
 test_debug 'git log --graph --decorate --oneline --all'
-- 
gitgitgadget

