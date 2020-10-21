Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E9DAC561F8
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 12:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31D552224E
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 12:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YXlP1UcT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442650AbgJUMvK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 08:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2442646AbgJUMvK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 08:51:10 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0099BC0613CE
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 05:51:10 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id c17so270551pjo.5
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 05:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=75002kI6Sz9A1VtaOvJzjIf/HZtevb9xw7ms9rpQt+o=;
        b=YXlP1UcTx6pc0obr1oKGFbs6z8PcRxSQu+07xL+suGb2p8fouMVUwvyaxhL5lSQrCM
         uPJldr4MRP7VDcZlkNHy5CslF9pnQsS30ORaZkn8oBvAw226zr9PtsQBRDihHbwM+4fz
         3OjE1PxuDjIp5WT+71AMrR872lhbclplaJtwcd4t1HfOcQTU4s7pRnKTd60mCvQM6iAx
         l8FpM0uS5Qf3W+LaQRhBwVZAw83fyLZPl35asXkFNnkO/YBM9xBWHkEN4aI0v2xCZyBN
         oLNZYPodQbKPLsIz9iCtYkhLp0vd9Fnc4XuxGPS5b9SWq2+DmhGWWJz9RzHK+U1tAh7U
         q/6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=75002kI6Sz9A1VtaOvJzjIf/HZtevb9xw7ms9rpQt+o=;
        b=ashhWux419OlmEUw3iKNisq7+DFpoTCWAl+YJ5Kndn3fEO7V6nsgzy22FJ1r1Z8S7A
         VCTR1qvcuy99Hja1LVi21e+3dNuFIvr4/H6NQyMpy1K/IQagQ4uGtn6JIr4L0ohskmzT
         zpV5AZRW29lF5oSnFoVkAY4pcFGODaNBOaZs7rGVpGsPHUnJn7qYEvkmyY50xu2PXKU+
         ZnwEeJ369J5oGyTaqfU1aW8HfvTR8zJuPVOGmijssFlBoppUpT6RfgjQFqe+FCnu+T4F
         mPUKZ9rM4EyRtRdnP36fd7hbLu2VjEK3scGkYIKHMqfBw8PAGFS+F9f3ENLvK2805kdS
         iPZg==
X-Gm-Message-State: AOAM530c3fH0br+3Xu+ceXTooCwpQnmpbDBFwxw1kqFBCUgBuDh00d2u
        pJSVTbdnP5CGuqMlkQnlvY+1G9Z7BXxMRA==
X-Google-Smtp-Source: ABdhPJzu4N+v+PH3l5iwIPuBu1SgBha1ETi+pts82euyqKi78emQXAgIK1QrlFGb7bcROb+cKCYhDQ==
X-Received: by 2002:a17:902:26c:b029:d6:83c:9486 with SMTP id 99-20020a170902026cb02900d6083c9486mr395715plc.85.1603284669391;
        Wed, 21 Oct 2020 05:51:09 -0700 (PDT)
Received: from localhost.localdomain ([106.215.55.55])
        by smtp.googlemail.com with ESMTPSA id j24sm2054857pjn.9.2020.10.21.05.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 05:51:08 -0700 (PDT)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com, me@ttaylorr.com,
        phillip.wood123@gmail.com, Charvi Mendiratta <charvi077@gmail.com>
Subject: [PATCH v5 4/5][Outreachy] t7201: use 'git -C' to avoid subshell
Date:   Wed, 21 Oct 2020 18:18:22 +0530
Message-Id: <20201021124823.2217-5-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20201021124823.2217-1-charvi077@gmail.com>
References: <20201020121152.21645-1-charvi077@gmail.com>
 <20201021124823.2217-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 t/t7201-co.sh | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 74553f991b..5898182fd2 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -339,10 +339,7 @@ test_expect_success 'switch branches while in subdirectory' '
 	git checkout master &&
 
 	mkdir subs &&
-	(
-		cd subs &&
-		git checkout side
-	) &&
+	git -C subs checkout side &&
 	! test -f subs/one &&
 	rm -fr subs
 '
@@ -357,10 +354,7 @@ test_expect_success 'checkout specific path while in subdirectory' '
 
 	git checkout master &&
 	mkdir -p subs &&
-	(
-		cd subs &&
-		git checkout side -- bero
-	) &&
+	git -C subs checkout side -- bero &&
 	test -f subs/bero
 '
 
-- 
2.29.0.rc1

