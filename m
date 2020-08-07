Return-Path: <SRS0=eX0j=BR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87772C433DF
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 21:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60E3122C9F
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 21:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BK835AMe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbgHGV6t (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Aug 2020 17:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbgHGV6s (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Aug 2020 17:58:48 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8E1C061756
        for <git@vger.kernel.org>; Fri,  7 Aug 2020 14:58:48 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id x12so2459845qtp.1
        for <git@vger.kernel.org>; Fri, 07 Aug 2020 14:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FiM6xzrmbmwsJ51v6pIzm1KA06lfExNXXma8m7v+6NY=;
        b=BK835AMedQqEa5jQGwGcW8rMNhlBnzyAI0kvPkP9ZJFAHbRvKJcszdzKwcDX9x9KGh
         u/lbgp86cvlyvADgVfjH9CHm9uzyz/E2KrGe3sFaOKmhSdJ/MifkUgNffotJ6NPELENc
         PO1z7mS9nn5zv4LDd7fzBh34aGe6sF0uTs305Xj3lJ7NXxPt3cQlEDpu2GfU/wmkWry5
         WlAtinWIw35dZ2rzUmDhwkDzhgX5EYVuH8qjEearUBfzfq3eOb420pqBarJwnrepwO+P
         zo4MAToiw3Y/3648BEjOV06mzPpJOoTfqxV0/Ad6ivJ9fzcnAFAVB132zR0wmxd8Tc9r
         9VpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FiM6xzrmbmwsJ51v6pIzm1KA06lfExNXXma8m7v+6NY=;
        b=OdLH/aF6QQ3XGBuLRWms2hSvNxardo9ifSOVRDILZCX086Tf/OFnpkMwe4x4hlh/uw
         Yivcf+sf3SGxSeDc/aoaGUGgpcSAjt6PLsxJEzGkoXoVEJZMlsRADhnpXU+YRUP8vbO+
         3Pd0QN1nQecNrt5Zq+EbYu0T/Vbx3MTLPDmRtkD44Q7gfaQvlINyghoHUi5AdFJTetXG
         4q3qmvIYG6VVKPnRw6XY198dNFEZQNKvmb21UW8vyhFwpfK5V+DWWcW+MX/x1+MLjOyn
         LpoFZo4sMG8fwxj0fjDyczRX28PJNvumFq0//5Fm0z+lyVUqrOxEUv3DSCt3MHj2med2
         wkNw==
X-Gm-Message-State: AOAM531f/kQCdqvV3Wkdrw1Xu+QX5FIxGf3CxfCz2GL55Vsv5qUCa55j
        hMr/XH4w8Ethfg54FrB48xkgl7q6IUQ=
X-Google-Smtp-Source: ABdhPJzmw4U+dEQrow5A+Wtv/g+vqvLNj9xRiPztZZUWzMsKwrVXL5ZW9a7Fu23lDvjEcF4d70Iy6A==
X-Received: by 2002:ac8:6a07:: with SMTP id t7mr16406012qtr.1.1596837527136;
        Fri, 07 Aug 2020 14:58:47 -0700 (PDT)
Received: from localhost.localdomain (c-98-229-3-81.hsd1.vt.comcast.net. [98.229.3.81])
        by smtp.gmail.com with ESMTPSA id 84sm7141579qkl.11.2020.08.07.14.58.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Aug 2020 14:58:46 -0700 (PDT)
From:   Aaron Lipman <alipman88@gmail.com>
To:     git@vger.kernel.org
Cc:     Aaron Lipman <alipman88@gmail.com>
Subject: [PATCH v5 1/5] t6030: modernize "git bisect run" tests
Date:   Fri,  7 Aug 2020 17:58:34 -0400
Message-Id: <20200807215838.19571-2-alipman88@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20200807215838.19571-1-alipman88@gmail.com>
References: <20200804220113.5909-1-alipman88@gmail.com>
 <20200807215838.19571-1-alipman88@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Enforce consistent styling for tests on "git bisect run":
- Use "write_script" to abstract away platform-specific details.
- Favor current whitespace conventions.
- While at it, change "introduced" to "added" in the comments to make
  them read better.

Helped-by: Martin Ågren <martin.agren@gmail.com>
Signed-off-by: Aaron Lipman <alipman88@gmail.com>
---
 t/t6030-bisect-porcelain.sh | 86 ++++++++++++++++---------------------
 1 file changed, 38 insertions(+), 48 deletions(-)

diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 36d9b2b2e4..a66c4b89bc 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -243,32 +243,30 @@ test_expect_success 'bisect skip: with commit both bad and skipped' '
 '
 
 # We want to automatically find the commit that
-# introduced "Another" into hello.
-test_expect_success \
-    '"git bisect run" simple case' \
-    'echo "#"\!"/bin/sh" > test_script.sh &&
-     echo "grep Another hello > /dev/null" >> test_script.sh &&
-     echo "test \$? -ne 0" >> test_script.sh &&
-     chmod +x test_script.sh &&
-     git bisect start &&
-     git bisect good $HASH1 &&
-     git bisect bad $HASH4 &&
-     git bisect run ./test_script.sh > my_bisect_log.txt &&
-     grep "$HASH3 is the first bad commit" my_bisect_log.txt &&
-     git bisect reset'
+# added "Another" into hello.
+test_expect_success '"git bisect run" simple case' '
+	write_script test_script.sh <<-\EOF &&
+	! grep Another hello >/dev/null
+	EOF
+	git bisect start &&
+	git bisect good $HASH1 &&
+	git bisect bad $HASH4 &&
+	git bisect run ./test_script.sh >my_bisect_log.txt &&
+	grep "$HASH3 is the first bad commit" my_bisect_log.txt &&
+	git bisect reset
+'
 
 # We want to automatically find the commit that
-# introduced "Ciao" into hello.
-test_expect_success \
-    '"git bisect run" with more complex "git bisect start"' \
-    'echo "#"\!"/bin/sh" > test_script.sh &&
-     echo "grep Ciao hello > /dev/null" >> test_script.sh &&
-     echo "test \$? -ne 0" >> test_script.sh &&
-     chmod +x test_script.sh &&
-     git bisect start $HASH4 $HASH1 &&
-     git bisect run ./test_script.sh > my_bisect_log.txt &&
-     grep "$HASH4 is the first bad commit" my_bisect_log.txt &&
-     git bisect reset'
+# added "Ciao" into hello.
+test_expect_success '"git bisect run" with more complex "git bisect start"' '
+	write_script test_script.sh <<-\EOF &&
+	! grep Ciao hello >/dev/null
+	EOF
+	git bisect start $HASH4 $HASH1 &&
+	git bisect run ./test_script.sh >my_bisect_log.txt &&
+	grep "$HASH4 is the first bad commit" my_bisect_log.txt &&
+	git bisect reset
+'
 
 # $HASH1 is good, $HASH5 is bad, we skip $HASH3
 # but $HASH4 is good,
@@ -295,24 +293,17 @@ HASH6=
 test_expect_success 'bisect run & skip: cannot tell between 2' '
 	add_line_into_file "6: Yet a line." hello &&
 	HASH6=$(git rev-parse --verify HEAD) &&
-	echo "#"\!"/bin/sh" > test_script.sh &&
-	echo "sed -ne \\\$p hello | grep Ciao > /dev/null && exit 125" >> test_script.sh &&
-	echo "grep line hello > /dev/null" >> test_script.sh &&
-	echo "test \$? -ne 0" >> test_script.sh &&
-	chmod +x test_script.sh &&
+	write_script test_script.sh <<-\EOF &&
+	sed -ne \$p hello | grep Ciao >/dev/null && exit 125
+	! grep line hello >/dev/null
+	EOF
 	git bisect start $HASH6 $HASH1 &&
-	if git bisect run ./test_script.sh > my_bisect_log.txt
-	then
-		echo Oops, should have failed.
-		false
-	else
-		test $? -eq 2 &&
-		grep "first bad commit could be any of" my_bisect_log.txt &&
-		! grep $HASH3 my_bisect_log.txt &&
-		! grep $HASH6 my_bisect_log.txt &&
-		grep $HASH4 my_bisect_log.txt &&
-		grep $HASH5 my_bisect_log.txt
-	fi
+	test_expect_code 2 git bisect run ./test_script.sh >my_bisect_log.txt &&
+	grep "first bad commit could be any of" my_bisect_log.txt &&
+	! grep $HASH3 my_bisect_log.txt &&
+	! grep $HASH6 my_bisect_log.txt &&
+	grep $HASH4 my_bisect_log.txt &&
+	grep $HASH5 my_bisect_log.txt
 '
 
 HASH7=
@@ -320,14 +311,13 @@ test_expect_success 'bisect run & skip: find first bad' '
 	git bisect reset &&
 	add_line_into_file "7: Should be the last line." hello &&
 	HASH7=$(git rev-parse --verify HEAD) &&
-	echo "#"\!"/bin/sh" > test_script.sh &&
-	echo "sed -ne \\\$p hello | grep Ciao > /dev/null && exit 125" >> test_script.sh &&
-	echo "sed -ne \\\$p hello | grep day > /dev/null && exit 125" >> test_script.sh &&
-	echo "grep Yet hello > /dev/null" >> test_script.sh &&
-	echo "test \$? -ne 0" >> test_script.sh &&
-	chmod +x test_script.sh &&
+	write_script test_script.sh <<-\EOF &&
+	sed -ne \$p hello | grep Ciao >/dev/null && exit 125
+	sed -ne \$p hello | grep day >/dev/null && exit 125
+	! grep Yet hello >/dev/null
+	EOF
 	git bisect start $HASH7 $HASH1 &&
-	git bisect run ./test_script.sh > my_bisect_log.txt &&
+	git bisect run ./test_script.sh >my_bisect_log.txt &&
 	grep "$HASH6 is the first bad commit" my_bisect_log.txt
 '
 
-- 
2.24.3 (Apple Git-128)

