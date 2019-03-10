Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C69D520248
	for <e@80x24.org>; Sun, 10 Mar 2019 08:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbfCJIJl (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Mar 2019 04:09:41 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41336 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfCJIJl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Mar 2019 04:09:41 -0400
Received: by mail-pf1-f194.google.com with SMTP id d25so1370419pfn.8
        for <git@vger.kernel.org>; Sun, 10 Mar 2019 00:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PlrqFritA8++ayU00JnePdrjX0s1qSveLPmobd5KFSQ=;
        b=bUXmG+X/vS0e4HchqyiQiodJ8iyOCrGkLhAxYSe4UO4IAUrlL6kLLC6u/ZP9MFvRub
         LuS6Z0jAImrZnh2Syz9rhm8hDVbMrgTT+5QVjfZvMXwZ+8mwruV8D8QL4i+IYQYwp/R5
         ux7I4KkrDl8IgGMrz1mmBpAXnvM1AmVCpGTeozU0LMhDYbptE9iSN/5bM8tGMkHw/2PC
         GPeRnbknnpU3TATn096f8dE3BeiNZbHdGQPWUdogAvqfSCwFwUcTF4Zj1mUEXGEGQcMv
         vdAY6RACbc2La2hXspbuMSR1UiNUA8/DhHULLCP2Ulw7i5tOFXYyJMSC8PVC2a5LvD4D
         PXvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PlrqFritA8++ayU00JnePdrjX0s1qSveLPmobd5KFSQ=;
        b=o8GdhcXVqyl/nVfzX98KJihKyE1Rh5JzUdNVY9AOv/rXAkXNTp0fp6WunDIs5kGXZe
         V/i2dCCGxjtycCTHQF/e7AfGA17F3UxK9kscCzFppKym5U4qzaZ3Nj7ghRLfuTHq3cm6
         J+kpAb35wttjWKvy7ZAGxqgVbKpjP0UlfRpsS/2cjW8/jwCguCtvaRcMPqmfVsOPq2Vy
         LNGvefQ6OXQ7NfzHPvLI+hWO/f/b2qpv17dXJ0BXHDCGNbVgML2ioa+ekeXaYZ74ebKK
         A7+P3zzbLgoYEJJTV4TpiGoq8ACRIuJSCRNF2Z/Sr2II+2XSx2pC069Fxfyk223Bik86
         wisA==
X-Gm-Message-State: APjAAAU17Pse/oduLVAm6QtuWbKuocLmSYGWvZtPaXRB7Hscr9E0WxMw
        m4KNs3T10TWUsYOOz4YeHLM=
X-Google-Smtp-Source: APXvYqzY4XyjwJK3tVd3fI+/nOG2OiYNFUZfjAD3nmJPnN8NsTo1ep32jtPFytS0m4BB+P1HxHAMeQ==
X-Received: by 2002:a17:902:8e8b:: with SMTP id bg11mr27086778plb.328.1552205380613;
        Sun, 10 Mar 2019 00:09:40 -0800 (PST)
Received: from localhost.localdomain (cloudream.m3.ntu.edu.tw. [140.112.244.5])
        by smtp.gmail.com with ESMTPSA id r28sm3891261pgl.72.2019.03.10.00.09.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 10 Mar 2019 00:09:40 -0800 (PST)
From:   Jonathan Chang <ttjtftx@gmail.com>
Cc:     Jonathan Chang <ttjtftx@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        git <git@vger.kernel.org>
Subject: [GSoC][PATCH v2 3/5] t0003-attributes: avoid using pipes
Date:   Sun, 10 Mar 2019 16:09:31 +0800
Message-Id: <20190310080931.64134-1-ttjtftx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190310080841.64082-1-ttjtftx@gmail.com>
References: <20190310080841.64082-1-ttjtftx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The exit code of the upstream in a pipe is ignored thus we should avoid
using it. By writing out the output of the git command to a file, we can
test the exit codes of both the commands.

Signed-off-by: Jonathan Chang <ttjtftx@gmail.com>

diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index 71e63d8b50..14274f1ced 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -203,15 +203,18 @@ test_expect_success 'attribute test: read paths from stdin' '
 test_expect_success 'attribute test: --all option' '
 	grep -v unspecified <expect-all | sort >specified-all &&
 	sed -e "s/:.*//" <expect-all | uniq >stdin-all &&
-	git check-attr --stdin --all <stdin-all | sort >actual &&
+	git check-attr --stdin --all <stdin-all >actual &&
+	sort -o actual actual &&
 	test_cmp specified-all actual
 '
 
 test_expect_success 'attribute test: --cached option' '
-	git check-attr --cached --stdin --all <stdin-all | sort >actual &&
+	git check-attr --cached --stdin --all <stdin-all >actual &&
+	sort -o actual actual &&
 	test_must_be_empty actual &&
 	git add .gitattributes a/.gitattributes a/b/.gitattributes &&
-	git check-attr --cached --stdin --all <stdin-all | sort >actual &&
+	git check-attr --cached --stdin --all <stdin-all >actual &&
+	sort -o actual actual &&
 	test_cmp specified-all actual
 '
 
@@ -301,8 +304,8 @@ test_expect_success 'bare repository: check that --cached honors index' '
 	(
 		cd bare.git &&
 		GIT_INDEX_FILE=../.git/index \
-		git check-attr --cached --stdin --all <../stdin-all |
-		sort >actual &&
+		git check-attr --cached --stdin --all <../stdin-all >actual &&
+		sort -o actual actual &&
 		test_cmp ../specified-all actual
 	)
 '
-- 
2.21.0

