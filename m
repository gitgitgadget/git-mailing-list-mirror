Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D0E920248
	for <e@80x24.org>; Sun, 10 Mar 2019 08:11:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbfCJILS (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Mar 2019 04:11:18 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43902 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfCJILR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Mar 2019 04:11:17 -0400
Received: by mail-pf1-f193.google.com with SMTP id q17so1367188pfh.10
        for <git@vger.kernel.org>; Sun, 10 Mar 2019 00:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1FigyPNfBPBf2qJH1GufmnClZiLmmEbvSLICtIgnTfY=;
        b=Ob6QsAXn1dt2SZ3vn2LRMMNIbve8e2MDUBAM6fNS0A3IBzBBGD01b4V3PRyrYgBI+J
         0vc7At8P24tUIQs/F5p+vxDGo1XNtqSeDJtPwLXqp7JStJPZl/ijQ0oYQIUmDCisOt9C
         bWWEbMQ2talwWn78LHXRKVRBXSOr06hhq3R7BEaNRRo5yUsQDWsVqAZCOIR2QHGfIKFu
         e0TcYwErioB04SxDKyzoVBRmghs2qmG7f9AqjXN0ocGhPh8anvRNqJYg9A9aRhUG+cuC
         nd4+fWCTimAE8XfeWCbgrzuCRSJMva3A1DHse4Ruj/ZYYBA0EuZDTzzYKYmrejiS3jxW
         bnLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1FigyPNfBPBf2qJH1GufmnClZiLmmEbvSLICtIgnTfY=;
        b=uXcuV39k2FhdO7G0sk4XW/aaPYb8yai+uizaNayLzFHIndrLmY6LlCQIiD22JCFFt4
         O7DGQE9QNVxJJ+UsteIoAdcxmnV4Bg44uresGgaNtQWIXwRQpT67FUK/v2MzaXR/fBkV
         gOxg58Zn09zOyAVKSSMK7cfpNfllIJpwiKRGtt7E1YJ+BcDsbWxe6v5G4kqKkM1nkChD
         Sw494+Mo0Cpimh9czkbFkhcCYRs4DCt5EL7ChAvT70UyqX/Pj3KBxPLu8u0ygrFE+mjA
         YkHDzDZ0efnlVlEprej4eXQkCuXdqGgyjdrniqUH/WWKdMNWsFo9FoY26nbo6GbvnxTk
         m1vQ==
X-Gm-Message-State: APjAAAW8gkPklYIFSMGSrkkOl+K2Zcrbobd47XC6KEviAtrmuwrWd55V
        Ey7EZVGxJ/Ljm3qWasZHbTg=
X-Google-Smtp-Source: APXvYqwu+4JtI1WcWBWBoQA55K38dJZrRWZ7RE0nCv6geDrb7AMcH8F0IsD180vxsK3FOz77weVDDg==
X-Received: by 2002:a62:1382:: with SMTP id 2mr26956131pft.157.1552205477129;
        Sun, 10 Mar 2019 00:11:17 -0800 (PST)
Received: from localhost.localdomain (cloudream.m3.ntu.edu.tw. [140.112.244.5])
        by smtp.gmail.com with ESMTPSA id i13sm3217786pgq.17.2019.03.10.00.11.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 10 Mar 2019 00:11:16 -0800 (PST)
From:   Jonathan Chang <ttjtftx@gmail.com>
Cc:     Jonathan Chang <ttjtftx@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        git <git@vger.kernel.org>
Subject: [GSoC][PATCH v2 5/5] t0000-basic: use test_line_count instead of wc -l
Date:   Sun, 10 Mar 2019 16:11:06 +0800
Message-Id: <20190310081106.64239-1-ttjtftx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190310081023.64186-1-ttjtftx@gmail.com>
References: <20190310081023.64186-1-ttjtftx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jonathan Chang <ttjtftx@gmail.com>

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 47666b013e..aa25694b45 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -1136,8 +1136,8 @@ test_expect_success 'git commit-tree omits duplicated parent in a commit' '
 	parent=$(sed -n -e "s/^parent //p" -e "/^author /q" actual | sort -u) &&
 	test "z$commit0" = "z$parent" &&
 	git show --pretty=raw $commit2 >actual &&
-	numparent=$(sed -n -e "s/^parent //p" -e "/^author /q" actual | wc -l) &&
-	test $numparent = 1
+	sed -n -e "s/^parent //p" -e "/^author /q" actual | wc -l >numparent &&
+	test_line_count = 1 numparent
 '
 
 test_expect_success 'update-index D/F conflict' '
@@ -1146,8 +1146,8 @@ test_expect_success 'update-index D/F conflict' '
 	mv tmp path2 &&
 	git update-index --add --replace path2 path0/file2 &&
 	git ls-files path0 >actual &&
-	numpath0=$(wc -l <actual) &&
-	test $numpath0 = 1
+	wc -l <actual >numpath0 &&
+	test_line_count = 1 numpath0
 '
 
 test_expect_success 'very long name in the index handled sanely' '
-- 
2.21.0

