Return-Path: <SRS0=DNff=2R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F602C2D0CE
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 13:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0258F20882
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 13:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WLxPfSOn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfL0NsA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Dec 2019 08:48:00 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:46706 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727092AbfL0Nrt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Dec 2019 08:47:49 -0500
Received: by mail-qv1-f66.google.com with SMTP id u1so9222610qvk.13
        for <git@vger.kernel.org>; Fri, 27 Dec 2019 05:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=aWlBZHdRpXk08WEH4QPYmOi7GcWNXddjtBkRW14UKxQ=;
        b=WLxPfSOnQKUH5qv3w6DSmzOJIoZu585SefWA0YfTTyFozqyNVJL3g1Og24+hvxrF6P
         CiPPCdB2aE0KSfUXM7dUzlkt4BN885dowg7qLmsd3vStq+SJe6uoZlpEyLxk+tV7WkCH
         Xk0c/GNENDuUggqQveHEg5s3FEmhwWFiCp3UoPg35MSa2erPcDt+EgEaW5Lg8IPFTSFX
         FTmjkUjdobspSGXyh6n7b+niS9yd0idXms+X+MsvVtVrN5hIqv5WwBT8tbojfvEpTcgR
         Gpj+oPLAV+epn8AU3SGxdorqQVvTmnUv5cjSNdiLpk3t++Mu0O7qD1jCvLY6xsnM9mIW
         0Cug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aWlBZHdRpXk08WEH4QPYmOi7GcWNXddjtBkRW14UKxQ=;
        b=WVh8CocP2NkRTuLtVDjCTCoI7ML+h6hmSVba06veq8f3Elx1MQhMplaiMVXPlqaKli
         HjGwrmeyYQ1ivNfYpbZ1ZhJ5XH6K9VHB75MM1hjefbwopfCARK+53NyaPTlnEXBoOC3o
         si6mWpp8o2pyXYzSHWRAimyI3uLeupqzW7/rrxw+qvYAh+Ai71Equ2xeqb9zIPVbqVuU
         q2qsklCAgw0Z09c2PSCl7RFsx+grJKMBCvoaI41SSBhF01NYgevge+Our8UFTkLnKbo/
         QIOr1IB+FxCHOy36rrTORCvKMCAQPXQ/8O/LVN9L+Uafx55Z362YrGN1Thwg/8HHPjfZ
         MxfQ==
X-Gm-Message-State: APjAAAXsI64A2Hf8Wa9CgOdF9ROL9q3F/5YkA1n5agJXA6hfBcYmEgBc
        00xWGKhthbXwGwKeLi0i9V5eLvhj
X-Google-Smtp-Source: APXvYqzuv+v9902ypCBK4xN1hR50EKiUh+K0P2U2AcEXIi+qpx4LQH6NF0iwP0kTzUA3zALp3VaJcw==
X-Received: by 2002:a05:6214:1923:: with SMTP id es3mr41147767qvb.49.1577454468326;
        Fri, 27 Dec 2019 05:47:48 -0800 (PST)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id d9sm10510184qth.34.2019.12.27.05.47.47
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2019 05:47:47 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 14/16] t3507: use test_path_is_missing()
Date:   Fri, 27 Dec 2019 08:47:23 -0500
Message-Id: <e885dd9c39e71089e73615a6dc8a60e1439a0284.1577454401.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.1.810.g65a2f617f4
In-Reply-To: <cover.1577454401.git.liu.denton@gmail.com>
References: <cover.1577454401.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test_must_fail() function should only be used for git commands since
we should assume that external commands work sanely. Replace
`test_must_fail test_path_exists` with `test_path_is_missing` since we
expect these paths to not exist.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t3507-cherry-pick-conflict.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
index 2a0d119c8a..9bd482ce3b 100755
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -168,7 +168,7 @@ test_expect_success 'successful final commit clears cherry-pick state' '
 	echo resolved >foo &&
 	test_path_is_file .git/sequencer/todo &&
 	git commit -a &&
-	test_must_fail test_path_exists .git/sequencer
+	test_path_is_missing .git/sequencer
 '
 
 test_expect_success 'reset after final pick clears cherry-pick state' '
@@ -178,7 +178,7 @@ test_expect_success 'reset after final pick clears cherry-pick state' '
 	echo resolved >foo &&
 	test_path_is_file .git/sequencer/todo &&
 	git reset &&
-	test_must_fail test_path_exists .git/sequencer
+	test_path_is_missing .git/sequencer
 '
 
 test_expect_success 'failed cherry-pick produces dirty index' '
@@ -387,7 +387,7 @@ test_expect_success 'successful final commit clears revert state' '
 	echo resolved >foo &&
 	test_path_is_file .git/sequencer/todo &&
 	git commit -a &&
-	test_must_fail test_path_exists .git/sequencer
+	test_path_is_missing .git/sequencer
 '
 
 test_expect_success 'reset after final pick clears revert state' '
@@ -397,7 +397,7 @@ test_expect_success 'reset after final pick clears revert state' '
 	echo resolved >foo &&
 	test_path_is_file .git/sequencer/todo &&
 	git reset &&
-	test_must_fail test_path_exists .git/sequencer
+	test_path_is_missing .git/sequencer
 '
 
 test_expect_success 'revert conflict, diff3 -m style' '
-- 
2.24.1.810.g65a2f617f4

