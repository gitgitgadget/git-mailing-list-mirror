Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84FFBC76196
	for <git@archiver.kernel.org>; Sun,  2 Apr 2023 19:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbjDBTS1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Apr 2023 15:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjDBTS0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Apr 2023 15:18:26 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6610D527A
        for <git@vger.kernel.org>; Sun,  2 Apr 2023 12:18:24 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id u11-20020a05600c19cb00b003edcc414997so16850627wmq.3
        for <git@vger.kernel.org>; Sun, 02 Apr 2023 12:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680463102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kng1dj3OD3GwrN64rav04oa27GKWD9CKe/Vim1FKEOo=;
        b=nFmTd1+V6nQdX60ZT8qk+AWh89iRwqAwWdRZmyzYhtEkvljGbzjcx+GC96ScTSB3ry
         IYfJBWtiIgLfYAq5ooOSjH7aljOsaZCgAMYrb4yG39vsYbQGjtuYXjVNX64rC8avBkN3
         WD30fMRnzAJR11ddMtiN8rZzksjLSAhFgWP5N9M29MpDV3ua//QwDRolq8VnWgbcB8a8
         B9jfnSsWcfZnTLOaM7FH2MvplKMGPOsAKT1C3LDzgC7P8MXnNbmUO/fln5GdmGKhkFbK
         uVQ3r2wmbcIM+gFZVXObv4Z9WZk0UFi+m9+pAmwUKvo7BT3icjceDsgNMsH1jEx/cN/6
         Razw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680463102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kng1dj3OD3GwrN64rav04oa27GKWD9CKe/Vim1FKEOo=;
        b=Xx5j8KE49ADO2bZnzI9+aOMUfuiH+x699bw7tZITcwmS0TWpR5nX+INjc55c/MFvFt
         UGdvtFGfz+AJLGw6DOklUh04KElmuHE3jqzvcelfVNb05GqS5NnQzrwoYBThxQIxjCER
         uRM8uSEtVx4mNSFb20fVx3VjnfiH+MF2oTkOrad5HHSWCgwN9ymlVLXc/tTLJ15Lwo+J
         RmHlDG5/SivMs3UHXvL59RwG8n6/90SqjFhHKak4dkolSDgsrelfeEfbC05cggpZXtQi
         GfU4KEoKO+Q9GqAmYfuM4oztOSKv0PQfL29JZ4B3lF67TfN9r3bLWQhCgsA8iZELmdi1
         eh5g==
X-Gm-Message-State: AAQBX9falnm47lBETgo7+nGXW9R/gDLncLXWnn2sD9iyp4aBXK+88vsv
        xAjyAFLP/OdOvM/eor/w20hNOfsfPRrWFj/6
X-Google-Smtp-Source: AKy350ax4bx6Qawic8R2DKDWRosxe0k2SHlJhGMAsdiRp1MomqRrCZwA3GaCpTqNwPz+rHagia5u0A==
X-Received: by 2002:a05:600c:3ba3:b0:3f0:4d9b:7cb2 with SMTP id n35-20020a05600c3ba300b003f04d9b7cb2mr2413461wms.3.1680463102431;
        Sun, 02 Apr 2023 12:18:22 -0700 (PDT)
Received: from localhost.localdomain ([2a0c:5bc0:40:2e25:76c6:3bff:fe8a:46ba])
        by smtp.gmail.com with ESMTPSA id h16-20020a05600c351000b003f046ad52efsm8402508wmq.31.2023.04.02.12.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Apr 2023 12:18:22 -0700 (PDT)
From:   Edwin Fernando <edwinfernando734@gmail.com>
To:     git@vger.kernel.org
Cc:     Edwin Fernando <edwinfernando734@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Andrei Rybak <rybak.a.v@gmail.com>
Subject: [GSOC][PATCH v4] t3701: don't lose "git" exit codes in test scripts
Date:   Sun,  2 Apr 2023 20:17:09 +0100
Message-Id: <20230402191709.19296-1-edwinfernando734@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230402113607.2394-1-edwinfernando734@gmail.com>
References: <20230402113607.2394-1-edwinfernando734@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Exit codes are lost due to piping: "git ... | <command>"
Fix these issues using the intermediate step of writing output to file.

Signed-off-by: Edwin Fernando <edwinfernando734@gmail.com>
---
Apply my changes on top of the latest commit in upstream history.
Test 76 in t3701 fails. This commit breaks the test:
a9f4a01760 (Merge branch 'jk/add-p-unmerged-fix', 2023-03-19)
Identified by checking out commits in:
"git log --oneline -- t/t3701-add-interactive.sh"
I don't know if it is normal to have broken tests in the main repository.

 t/t3701-add-interactive.sh | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 3982b6b49d..b8291206a0 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -286,8 +286,10 @@ test_expect_success FILEMODE 'patch does not affect mode' '
 	echo content >>file &&
 	chmod +x file &&
 	printf "n\\ny\\n" | git add -p &&
-	git show :file | grep content &&
-	git diff file | grep "new mode"
+	git show :file >show &&
+	grep content show &&
+	git diff file >diff &&
+	grep "new mode" diff
 '
 
 test_expect_success FILEMODE 'stage mode but not hunk' '
@@ -295,8 +297,10 @@ test_expect_success FILEMODE 'stage mode but not hunk' '
 	echo content >>file &&
 	chmod +x file &&
 	printf "y\\nn\\n" | git add -p &&
-	git diff --cached file | grep "new mode" &&
-	git diff          file | grep "+content"
+	git diff --cached file >diff &&
+	grep "new mode" diff &&
+	git diff file >diff &&
+	grep "+content" diff
 '
 
 
-- 
2.40.0

