Return-Path: <SRS0=xG8z=6E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9432C54FCC
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 23:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 978A72068F
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 23:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/GQBns5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbgDTXzB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Apr 2020 19:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725988AbgDTXzB (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Apr 2020 19:55:01 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE2FC061A0E
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 16:55:01 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id z6so4556854plk.10
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 16:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u7i9JEcHGbBDQq5uZ2gh7RUXZ1tzWS0caOTUlX5WiNI=;
        b=g/GQBns5yB0cFJ4+xnxX+2dmfgGzqxazpQYwvqUVkeyG8R82WHE7eAfsuxPQvI2jEt
         Z6lZfaic1XBX9pnglT7DM5s9wUJBqe2MTs+4MwQuqsuE7EcOKgdPZ2QKUJFiazHhczmY
         1pQ+ze4pxmymFePkrk6e8XcdUXf6ChfG1iFUPtMDcBleBeu6xeCWwvTu2B0tIcze8U3T
         bw4t7u1eqo95GDfxcqF+MWeCCG1rCqz/l7tb9xOprq/hN/jGuTe5rjOQDPkGedc++SvL
         5NSM7t3hBrPJTbvEKSn4ahKKbLhLh2uU23uLAYOl72OahyFkFOt7Pz9FHTRvx+KYjZlH
         PTHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u7i9JEcHGbBDQq5uZ2gh7RUXZ1tzWS0caOTUlX5WiNI=;
        b=OcJbAtSmMXC0PZ/WPkUmL0zhoMVjf36kX8x3eHdBP6Srq4Bs0+1jJlqM+kcTW8NthO
         I9FtTBYyblL2jMVeVzogMGtrcsTT8TzkkPmiRMIEVT3WxqRkdeStSXjyjwNzJGqWUrSP
         UF0rbzatThVHUjtmTNJ5G6vZueJs/l4SarlIm2eiB15Cukx5z6bp36lv+sIjQGqw09xI
         tzaaSNB/03oJgWOAFggLH2tyXR0c7Ns5lP7Z6FWg/BmsOHCPgnDF5pEgOqU5OiaR+zya
         b3vx7DBP3XJxA5M2LoTtFSQhcgZMjBhsrj9leSqGS6FtXoI7rP93vYVFA+RXUy4zp1AZ
         Md4w==
X-Gm-Message-State: AGi0PuZCWm9gM1horVxz+AQvOtdz1gCmzybH3ym3q1ZjleJj0n3bqk+2
        nqiCBxAr5wOojamY9SAjskbKFr5Y
X-Google-Smtp-Source: APiQypJhvF6lcdaGu9UjHCvmiwp8Xnd2AeCgt34oJOPSsEKWE04z/8G6k8Y/6hv6VkUhkzeW60srig==
X-Received: by 2002:a17:90a:1ae9:: with SMTP id p96mr2168130pjp.75.1587426900125;
        Mon, 20 Apr 2020 16:55:00 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6374:f359:effc:5180:3a91:1887])
        by smtp.gmail.com with ESMTPSA id g14sm609248pfh.49.2020.04.20.16.54.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Apr 2020 16:54:59 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v3 1/3] t4254: merge 2 steps of a single test
Date:   Tue, 21 Apr 2020 06:54:34 +0700
Message-Id: <d1bc31e692d08d73bc577f737b0190e163440ee9.1587426713.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb
In-Reply-To: <cover.1587426713.git.congdanhqx@gmail.com>
References: <20200418035449.9450-1-congdanhqx@gmail.com> <cover.1587426713.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While we are at it, make sure we run a clean up after testing.
In a later patch, we will test for more corrupted patch.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 t/t4254-am-corrupt.sh | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/t/t4254-am-corrupt.sh b/t/t4254-am-corrupt.sh
index fd3bdbfe2c..ddd35498db 100755
--- a/t/t4254-am-corrupt.sh
+++ b/t/t4254-am-corrupt.sh
@@ -25,10 +25,8 @@ test_expect_success setup '
 #   fatal: unable to write file '(null)' mode 100644: Bad address
 # Also, it had the unwanted side-effect of deleting f.
 test_expect_success 'try to apply corrupted patch' '
-	test_must_fail git -c advice.amWorkDir=false am bad-patch.diff 2>actual
-'
-
-test_expect_success 'compare diagnostic; ensure file is still here' '
+	test_when_finished "git am --abort" &&
+	test_must_fail git -c advice.amWorkDir=false am bad-patch.diff 2>actual &&
 	echo "error: git diff header lacks filename information (line 4)" >expected &&
 	test_path_is_file f &&
 	test_i18ncmp expected actual
-- 
2.26.1.301.g55bc3eb7cb

