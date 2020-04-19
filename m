Return-Path: <SRS0=ylBF=6D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FAAC54F70
	for <git@archiver.kernel.org>; Sun, 19 Apr 2020 11:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96ABA22202
	for <git@archiver.kernel.org>; Sun, 19 Apr 2020 11:00:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LfZaZH4d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbgDSLAw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Apr 2020 07:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725914AbgDSLAv (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 19 Apr 2020 07:00:51 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7775C061A0C
        for <git@vger.kernel.org>; Sun, 19 Apr 2020 04:00:51 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id nu11so3154742pjb.1
        for <git@vger.kernel.org>; Sun, 19 Apr 2020 04:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u7i9JEcHGbBDQq5uZ2gh7RUXZ1tzWS0caOTUlX5WiNI=;
        b=LfZaZH4d046bkcUTekvWTeu3PMQ20OKuP/qBZ+I/tvkdpI3wxilp8TOf8jqCe5YTYt
         9I1rjVWy48UjFzpPFz9eJuzjXeQOASCKak7PVYDEe0Dx18ipb91oxGaecdx9yP6dTC+v
         ZB2FLaLRwjyOOeOBr5DsL6Jgeg4dP5wt5h1dTQy/niux3SB+j6o651LY1WpeCXK5dtCM
         B3TCpiBQHzxEY6aryL1Cm4dhiO1+p6XIiGRQvx3xvQ9odflxtOJu6aApWQmCGZU8OGmS
         jxmuQgYl9Zm4OUL40bQdqRb8UAdKDvEVRMR3Ybx7aNA11vZK1eePuO5hPGtS6SryleVM
         UBRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u7i9JEcHGbBDQq5uZ2gh7RUXZ1tzWS0caOTUlX5WiNI=;
        b=V25gP1AUo1eMdw4ejyc7QBBmyfisyMolDiguXMb6zZ+R+UHxRqRZ/Y+AdJmXLc0vqn
         w3V6mD9OPnBvj9pGQel0JFZFM7D9+iccgLdr9O13Xwg4F97jP3It2fGYLiatnZej7w1K
         JpTIW94mdk8rvz7XDGPzXaJUKqRex+pfu7djOW08zrtP42F6nq2gIY3Yq57nQ7XnT1KL
         xY6m6Hz8esULy7AVH7cwYrAseLgF7hzNrIwUvo5xmkd5VgkZ1sglsotKJ4PviScqOH5l
         zIkBkYzGqMBZN+Xh7T4AUfE83ZCsPCPHzYjHwF9KEiIBiSsD2watjVC2TprqlquqqyPm
         C73Q==
X-Gm-Message-State: AGi0PuZZnb5A+PGPkrdu2jedgYK3y2bD3D3hGnnGwz8LxzSMO8zDcGlc
        cHa/PJgENeTcUs82PzHKEyRaPUc4
X-Google-Smtp-Source: APiQypInAwMMQZNVjb0DTomORPpQHVbAHuCsuB7Ud72Z0vuYWzXCVbikOxrlotGyPS+orgQYMXhcnA==
X-Received: by 2002:a17:90b:3547:: with SMTP id lt7mr14058654pjb.96.1587294051095;
        Sun, 19 Apr 2020 04:00:51 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6374:5380:b9e1:93e1:68db:b9f6])
        by smtp.gmail.com with ESMTPSA id b20sm361692pff.8.2020.04.19.04.00.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Apr 2020 04:00:50 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v2 1/3] t4254: merge 2 steps of a single test
Date:   Sun, 19 Apr 2020 18:00:40 +0700
Message-Id: <d1bc31e692d08d73bc577f737b0190e163440ee9.1587289680.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb
In-Reply-To: <cover.1587289680.git.congdanhqx@gmail.com>
References: <20200418035449.9450-1-congdanhqx@gmail.com> <cover.1587289680.git.congdanhqx@gmail.com>
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

