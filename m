Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C659C433DB
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 11:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CD4E64E42
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 11:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbhBJLnA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 06:43:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbhBJLkV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 06:40:21 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA49C0617A7
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 03:38:36 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id a16so1047380plh.8
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 03:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q5z2MPfcCthKjvrezNJiA/Mtc4HlmEUSJZnTqCnfliE=;
        b=KZwbIaJHbtOTHWFO7oIGNZp9kd93v8vSlo9WO9oXW03sT7kx8pn/rGH1lww2s6L6zJ
         JH3Zu3bgnho/Xbl7xZv8GtMUWafYDIGR0ngpJRfVOMkDEvrcsgannovIiCCp4Z/SbOzX
         n8u0tsyXjkMgJ+kbUIZLdjs0dAZbhyGUf05eYl7PLMCsIDDeHcsiR2Smo+l/GYG2K5cC
         mhy1udRRUp5vp6wBviqCWv0c75KdyAHQnI5QvI6aoqRJJxRDH4b33tcNH0VXzEQ12dD4
         UEz+aPDAkY+jAq2XylnO1vdOERkfXnOyptZxTVx+aKo/g/LLuW+2Bh7DQAVwFC+gD1ob
         dPLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q5z2MPfcCthKjvrezNJiA/Mtc4HlmEUSJZnTqCnfliE=;
        b=CYpUrQDtwfb2sShycKEQrPGNFcmhla4Inwx2GcnkNmr98tWjctr6S2AFdVookKIDyV
         ocwR8H9jy0A3ZrnoAFi3LIXR+JK/J5PsYduJUnXqiyPPC8AQbImUXKN4zx9pFZwLBcsv
         e03oTjJ0QCowFGuZYpagPIhrSt1JVTfz9TFTq7xKQa1VoenjwxjFQtvNDCIsdsMWZ6DN
         0xAQf+IjdFHzVK1JB1DVQIU1P1esYoMuouj+uqEGqjzBwKl4Q79bLAcUe3g4MrLiQ3BQ
         I/01PY215e6d0lWEflapWK1RXGyEtGjUZKn5+gWvK2W3J5MPjTb3yn58ssoBrFoRfllo
         PLUA==
X-Gm-Message-State: AOAM533wJFpekuifWZKalc4j1phsJBMi4tVaGslRQwRUTKjUC7TyQF+B
        otfTSl72xpZDcgvNgE900TJBq+hHt8O+cg==
X-Google-Smtp-Source: ABdhPJy/CKxu+tInAVp+f+rcLWh4TZLw54b3YBCJW9oWvTsGE4FdsJUKoj7tITWlINh1zUa+ScP8MQ==
X-Received: by 2002:a17:90a:2b4a:: with SMTP id y10mr2817083pjc.118.1612957115454;
        Wed, 10 Feb 2021 03:38:35 -0800 (PST)
Received: from localhost.localdomain ([171.76.0.223])
        by smtp.googlemail.com with ESMTPSA id y3sm2123731pfr.125.2021.02.10.03.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 03:38:35 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sunshine@sunshineco.com,
        christian.couder@gmail.com, phillip.wood123@gmail.com,
        Charvi Mendiratta <charvi077@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v3 07/11] t/t3437: check the author date of fixed up commit
Date:   Wed, 10 Feb 2021 17:06:47 +0530
Message-Id: <20210210113650.19715-8-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210207181439.1178-1-charvi077@gmail.com>
References: <20210207181439.1178-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add '%at' format in the get_author() function and update the test to
check that the author date of the fixed up commit is unchanged.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 t/t3437-rebase-fixup-options.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/t3437-rebase-fixup-options.sh b/t/t3437-rebase-fixup-options.sh
index d368ab4d4b..505211a589 100755
--- a/t/t3437-rebase-fixup-options.sh
+++ b/t/t3437-rebase-fixup-options.sh
@@ -33,7 +33,7 @@ test_commit_message () {
 
 get_author () {
 	rev="$1" &&
-	git log -1 --pretty=format:"%an %ae" "$rev"
+	git log -1 --pretty=format:"%an %ae %at" "$rev"
 }
 
 test_expect_success 'setup' '
@@ -196,6 +196,8 @@ test_expect_success 'multiple fixup -c opens editor once' '
 		EXPECT_HEADER_COUNT=4 \
 		git rebase -i $base &&
 	test_cmp_rev $base HEAD^ &&
+	get_author HEAD >actual-author &&
+	test_cmp expected-author actual-author &&
 	test 1 = $(git show | grep Modified-A3 | wc -l)
 '
 
-- 
2.29.0.rc1

