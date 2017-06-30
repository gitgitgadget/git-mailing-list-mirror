Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F53D201A0
	for <e@80x24.org>; Fri, 30 Jun 2017 15:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751786AbdF3PnR (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 11:43:17 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35896 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751605AbdF3PnQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 11:43:16 -0400
Received: by mail-pg0-f68.google.com with SMTP id u36so15761908pgn.3
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 08:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=dYMPitwRVSG640+q111OYmWXXmy7fsyWpLHZRHw3hZg=;
        b=C+WdseVL6th7tl09KZnUoMLp4YWufjnrOB+o7NDs4GLM34/fMjUq2gY95VC0F4kyI7
         8Fg7xZ1pY5dPxIzVRei0A+T7VDFFP/BJkzLhecn6ujrSK0VnJeDpeWpm68zitOYi8ED5
         mvASc7YzUaCem77KAWlqf6YwRC7quweakwSJL7Q/yyibudephQcjyy5iTT24bP4I+5aa
         b1/idjLQkhj4RhwFw+6Xb8iJ+TUO5pgiJ8W4/Znff5ioxiCx5+UJmYppP/InR0/C+jR/
         v8YlfRZwLdOleqfUaA0CFT3xrETKElEQgT3P1e26KqeCgD45+TatwN+3+M6SP5WELuxX
         7Seg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dYMPitwRVSG640+q111OYmWXXmy7fsyWpLHZRHw3hZg=;
        b=DetJKU9yYp5bYudjHizHPI6YrRvfSck6DNqWmfXiv8KCU25X+m96/FESwbak6V1B4q
         1QT/YCiqH2rE/8WsxtJxrWktE8EUpzRw12aWkipOu0oyGblbwXsTKIYPQiee21yut5QT
         QxPD2ylzG6yxoDO9sFERb6VIEgNSV+p2h1lm5t5eeDPt3xwcM46dGyXqlzEGRUA+wHMc
         qKuHuaY4b/5/pCKGsQ6i5azuY3d7DiTu1tYXxYHYH5WaBrAs9KGBw8SWWDArAoHAQ3Ru
         dPyamafi21+3YN56CdwCDi4D5k2o9Ie9fy3xaW+TjOH2CRh3lVa7Ie4VXfO9FIccFc2f
         rEVw==
X-Gm-Message-State: AKS2vOwlZ6TqLum/W2Fvari8naUrQDiO3IF2fC8dsKeuULdAQxwwZp2l
        3OZzdmhtvxGbIF3b8pg=
X-Received: by 10.99.113.78 with SMTP id b14mr21999050pgn.229.1498837395710;
        Fri, 30 Jun 2017 08:43:15 -0700 (PDT)
Received: from localhost.localdomain ([42.111.140.60])
        by smtp.gmail.com with ESMTPSA id t23sm15001510pgb.25.2017.06.30.08.43.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Jun 2017 08:43:15 -0700 (PDT)
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
Subject: [PATCH] hooks: add signature to the top of the commit message
Date:   Fri, 30 Jun 2017 21:13:06 +0530
Message-Id: <20170630154306.26993-1-kaarticsivaraam91196@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The sample hook to prepare the commit message before
a commit allows users to opt-in to add the signature
to the commit message. The signature is added at a place
that isn't consistent with the "-s" option of "git commit".
Further, it could go out of view in certain cases.

Add the signature to the top of the commit message as it's
more appropriate and consistent with the "-s" option of git
commit.

Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
---
 The change might seem to be bit of an hack, but it seems
 worth it (at least to me). I hope I haven't used any
 commands that aren't portable.

 templates/hooks--prepare-commit-msg.sample | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/templates/hooks--prepare-commit-msg.sample b/templates/hooks--prepare-commit-msg.sample
index 86b8f227e..3c8f5a53d 100755
--- a/templates/hooks--prepare-commit-msg.sample
+++ b/templates/hooks--prepare-commit-msg.sample
@@ -33,4 +33,7 @@ case "$2,$3" in
 esac
 
 # SOB=$(git var GIT_AUTHOR_IDENT | sed -n 's/^\(.*>\).*$/Signed-off-by: \1/p')
-# grep -qs "^$SOB" "$1" || echo "$SOB" >> "$1"
+# SOB_TO_ADD='
+#
+# '$SOB
+# grep -qs "^$SOB" "$1" || (echo "$SOB_TO_ADD" | cat - "$1" >temp-template && mv temp-template "$1")
-- 
2.11.0

