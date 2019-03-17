Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9421B20248
	for <e@80x24.org>; Sun, 17 Mar 2019 15:24:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbfCQPY0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Mar 2019 11:24:26 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40139 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbfCQPY0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Mar 2019 11:24:26 -0400
Received: by mail-pf1-f193.google.com with SMTP id c207so541442pfc.7
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 08:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WftxrZJlWWX6IGEh5qYZ7/wRX4GUg2vW7IpByNgMzHI=;
        b=hNctu+3cUzUexTaRlznndQ8XJHvpv736JBdjrFJCQ68ZkU23IwXKJ+iNLBev1qa2LA
         Mm8FnZkXbN4hxnEFP3Dhy1nTQqxN3QWmVKUEjEVVLSVAn+cXpgeLwPxDX5WeJnzVRcNR
         /WX/uipX8xdW98ezPu2SWzaz9UiD89IVeC4c2oWoKWIpgprMkgoYzghkL+biyGTZnpV7
         v5RzCeA3LanM1I98lpoA5IY9WpzW7FboUNqrmCVCg2MzU5NEehMOG3r/faHiHISmWtFE
         0vgdbfjXBI7ljEZOZT3IEMNEnkkJZb79g1b9b4BUP788Q+heOJ0VEeg+kXs+23r1CtoM
         yfrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WftxrZJlWWX6IGEh5qYZ7/wRX4GUg2vW7IpByNgMzHI=;
        b=lcRAhZlG9xztuM9Z26NSmVVwK6AXZoTclRiOP5Ol3oPL8nRVkWphEtySUG9WngpUtM
         nvZYrQbDSxsJKpXd6FjzPaCUQsjM6p3O3VlNG/yDFL58/7B1crWz+0q21eQbYzf+Z+Up
         WgKUrGjoqlKSorUZlwlFBk77/8zGys740KdyjPjN8oR3X/jKa7v/Sz6BDaDYmTzCIEqF
         aJyiiDS1BV1JO+YW60XGT1AWD2I+NtfhubhKM02BW54KZ7lE4ysnujHclGBiNzfDmqky
         J8y6HkWOQkF+o7GhBHbxepSxxSviOVp46oeZ+/NyDlAQCQU+0SbliG9wZ9ZuQ3PY+Wou
         rHtA==
X-Gm-Message-State: APjAAAUIZCUX+RQmP1blFmYsh5xmduwt3jTL1jBGa/yluRHzPAUH8uJR
        egBtP1M1EyU9NcMlyW5696ouWbVl
X-Google-Smtp-Source: APXvYqxCbyVrxL/Nu/66Yli2fYInNXHZivQ/D1xiC57KigdfiDsA9AzQ7dBtpEa4WTWVTO5P+ZhalA==
X-Received: by 2002:a17:902:1:: with SMTP id 1mr14573898pla.226.1552836265265;
        Sun, 17 Mar 2019 08:24:25 -0700 (PDT)
Received: from localhost.localdomain (cloudream.m3.ntu.edu.tw. [140.112.244.5])
        by smtp.gmail.com with ESMTPSA id z15sm10357978pgc.25.2019.03.17.08.24.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 17 Mar 2019 08:24:24 -0700 (PDT)
From:   Jonathan Chang <ttjtftx@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jonathan Chang <ttjtftx@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [GSoC][PATCH v3 3/3] t0000: use test_line_count instead of wc -l
Date:   Sun, 17 Mar 2019 23:23:38 +0800
Message-Id: <bc3dee82a91592e50fd39c5a332b13b76fefa009.1552835153.git.ttjtftx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1552835153.git.ttjtftx@gmail.com>
References: <cover.1552835153.git.ttjtftx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jonathan Chang <ttjtftx@gmail.com>
---
 t/t0000-basic.sh | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 47666b013e..3de13daabe 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -1136,8 +1136,8 @@ test_expect_success 'git commit-tree omits duplicated parent in a commit' '
 	parent=$(sed -n -e "s/^parent //p" -e "/^author /q" actual | sort -u) &&
 	test "z$commit0" = "z$parent" &&
 	git show --pretty=raw $commit2 >actual &&
-	numparent=$(sed -n -e "s/^parent //p" -e "/^author /q" actual | wc -l) &&
-	test $numparent = 1
+	sed -n -e "s/^parent //p" -e "/^author /q" actual >parents &&
+	test_line_count = 1 parents
 '
 
 test_expect_success 'update-index D/F conflict' '
@@ -1146,8 +1146,7 @@ test_expect_success 'update-index D/F conflict' '
 	mv tmp path2 &&
 	git update-index --add --replace path2 path0/file2 &&
 	git ls-files path0 >actual &&
-	numpath0=$(wc -l <actual) &&
-	test $numpath0 = 1
+	test_line_count = 1 actual
 '
 
 test_expect_success 'very long name in the index handled sanely' '
-- 
2.21.0

