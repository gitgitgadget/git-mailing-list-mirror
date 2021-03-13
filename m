Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D3CC433E0
	for <git@archiver.kernel.org>; Sat, 13 Mar 2021 13:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA5A064F18
	for <git@archiver.kernel.org>; Sat, 13 Mar 2021 13:44:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233789AbhCMNna (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Mar 2021 08:43:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233423AbhCMNnA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Mar 2021 08:43:00 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC4CC061574
        for <git@vger.kernel.org>; Sat, 13 Mar 2021 05:43:00 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id ga23-20020a17090b0397b02900c0b81bbcd4so12102014pjb.0
        for <git@vger.kernel.org>; Sat, 13 Mar 2021 05:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZqyQqnN/r9Yp2nVabx5VAmks8N5fv9M2AVAwzn2f2LI=;
        b=L1sJLg2r2ktmgHsA5D1ncw6OgBiP8HrnxGiPYyNZnjFhJMDmKzM9GCkQzr1lRPjbXD
         23LBhW1uiHGMx53gNDMVlHqQbjaJaNwmBGnyzrBbd3lsO7T3enPCynqyK8d0yTy+ZmVc
         3KWSzqbogjUkhFoR9Ja8ynp93cZ3H4CbKofst+3/4lpZuBMjDLBPy3GLsh2z7TvCSKF9
         DHu3oI8H99SrOHXtFYDXv4WXmOL5CHTO7u83AGXJ3VtaI/H+ZzZe76sW7Rdjy8HgQHPo
         6rM65q4zvsNhbajqPehgw7pBErBq1gAR6WX8jVT6VO0ExSFfRx2j/OTOkyX1tnI/MqFJ
         QXUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZqyQqnN/r9Yp2nVabx5VAmks8N5fv9M2AVAwzn2f2LI=;
        b=ANdzaoglz5KffYWH3wAK42yiWkZroythGWZ6r2Rf/iZ3/M8c1EZl8l2VEYwqKZJFBD
         2D/fjNEU6mpcI3ZNAVzPx1ad+9KhDGaWVjtfZrRLiRBrnZcyTpBHR27I2Y3LdL6jOMaH
         K/TuXposx9deIDqOUoZQwOVR5hnTq2koV50g9gVU6lADKxyJTFsJWh0FXGAyc4rga6ZF
         P6tH9twoY1ZJhEmFAePatlysTVWbTt3khLrpEoCvgVvH2teg3llQxKroHxE0b6H5e9B+
         qrSZpv+LHwlPW541/CJgjw6R5V0BTS/bGqil6c5tc9DAWI3tUNfci157jr7uVzDzHxkX
         a1lQ==
X-Gm-Message-State: AOAM532jKaXxaQ1AKzrZSl+AVutR8d9WPhe/ylabGxVX7Ns2EqXSQQ1W
        GQAPMPZeXG7T/GO7vKgIgfQlOSGxmT5HCg==
X-Google-Smtp-Source: ABdhPJyjungInns5v9giWMeXoSoD48btyZOjhytF39KD83b7/bhtLclzmz+1tP9vSloaPVmNk4Bs7w==
X-Received: by 2002:a17:902:eb4a:b029:e5:e7d0:5aa with SMTP id i10-20020a170902eb4ab02900e5e7d005aamr3306518pli.3.1615642979524;
        Sat, 13 Mar 2021 05:42:59 -0800 (PST)
Received: from localhost.localdomain ([2409:4050:2d98:f55e:3466:3377:eaba:8d02])
        by smtp.googlemail.com with ESMTPSA id y20sm8657809pfo.210.2021.03.13.05.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Mar 2021 05:42:59 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com,
        phillip.wood123@gmail.com, sunshine@sunshineco.com,
        Charvi Mendiratta <charvi077@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v5 5/6] t3437: use --fixup with options to create amend! commit
Date:   Sat, 13 Mar 2021 19:10:12 +0530
Message-Id: <20210313134012.20658-6-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210310194306.32565-1-charvi077@gmail.com>
References: <20210310194306.32565-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We taught `git commit --fixup` to create "amend!" commit. Let's also
update the tests and use it to setup the rebase tests.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 t/t3437-rebase-fixup-options.sh | 30 +++---------------------------
 1 file changed, 3 insertions(+), 27 deletions(-)

diff --git a/t/t3437-rebase-fixup-options.sh b/t/t3437-rebase-fixup-options.sh
index a5a20354e3..d0bdc7ed02 100755
--- a/t/t3437-rebase-fixup-options.sh
+++ b/t/t3437-rebase-fixup-options.sh
@@ -72,40 +72,16 @@ test_expect_success 'setup' '
 	git commit --fixup=HEAD -a &&
 	git tag B1 &&
 	test_tick &&
-	git commit --allow-empty -F - <<-EOF &&
-	amend! B
-	$EMPTY
-	B
-	$EMPTY
-	edited 1
-	EOF
+	FAKE_COMMIT_AMEND="edited 1" git commit --fixup=reword:B &&
 	test_tick &&
-	git commit --allow-empty -F - <<-EOF &&
-	amend! amend! B
-	$EMPTY
-	B
-	$EMPTY
-	edited 1
-	$EMPTY
-	edited 2
-	EOF
+	FAKE_COMMIT_AMEND="edited 2" git commit --fixup=reword:HEAD &&
 	echo B2 >B &&
 	test_tick &&
 	FAKE_COMMIT_AMEND="edited squash" git commit --squash=HEAD -a &&
 	git tag B2 &&
 	echo B3 >B &&
 	test_tick &&
-	git commit -a -F - <<-EOF &&
-	amend! amend! amend! B
-	$EMPTY
-	B
-	$EMPTY
-	edited 1
-	$EMPTY
-	edited 2
-	$EMPTY
-	edited 3
-	EOF
+	FAKE_COMMIT_AMEND="edited 3" git commit -a --fixup=amend:HEAD^ &&
 	git tag B3 &&
 
 	GIT_AUTHOR_NAME="Rebase Author" &&
-- 
2.29.0.rc1

