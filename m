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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0EC8C433E0
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 07:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55EE664E02
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 07:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbhBQHmB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 02:42:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbhBQHjq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 02:39:46 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF70C061788
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 23:38:55 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id g20so6990315plo.2
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 23:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZqyQqnN/r9Yp2nVabx5VAmks8N5fv9M2AVAwzn2f2LI=;
        b=USRAPvUXr5HoDUIxI/nKmr4fZpX9Qhi7bsc5Clea3jGNndjJyu49jrGLumM8TLpY6T
         /Oc+saR4QfllnqNUunDwLH+pxwqItP1FVWxxaBRaeZ5x3Gaw2nZBcK0qXCwECJ8Vt/UN
         L/oWtL2N6bqQjzjtabyY/Yk0Plng07L85yVan/ZeCBuQtmpeVxmiyvAN/Z0RDuOHBJbx
         zvRxYBTClI/AvSl459AZu4o+CIB92CQ+AlOIHyYcM1eLRwszPiOGc3C/rBXezjHInzQP
         2x+cFj5tsZcmQ9GmRqQcrzGgvQFJW48xMhc+Rm+7andQSCOXyrbvJDc2Uy/mBQ3I0Du/
         +G9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZqyQqnN/r9Yp2nVabx5VAmks8N5fv9M2AVAwzn2f2LI=;
        b=GpPbMTiEBYJQTuePIkS9D4U3YrhiD9xjzUx2KQphwV7gCRGE7yT5IjtjWd7inyQhAg
         xrzyh7Vlxu4kHfKAlCDwCFirJBUJcRhKwZDrNqxwf3UU+j/S/ZaubEAI3eb5cAgCblzW
         BZoKXcT7TOFYZ9c1ipcEeD/vaY76e2wPRFIt5thGG/NPh1+htz6FHk82M59fIP0lSbey
         nv/629kin2EK4W16ozAwM5YV8xqGomDL/NQrMZWZX+iBsOq2l8+DXE6KC8TApjSEGzia
         TRWg7qevBqME4LNMP0PQSZGkIHIt+oHcf44qLtqQiTn9QaKENE7jQasA4sojfSbuBJGl
         repw==
X-Gm-Message-State: AOAM5328rbZhns9XwQIZDD69jtyVXv+7BhtaOh+Rf8oYgXP5V6kXtQvx
        evEq2F2tynH/ZYTsx9QEDzD/26KNrRFypg==
X-Google-Smtp-Source: ABdhPJx6+DwJC+6pBfX4OXr0veLUtkCWInyTyAC7Awniw+QChUyk6VYYTbzATrqs0VYxxq89NVU6/g==
X-Received: by 2002:a17:902:d647:b029:e0:8ee:d8ac with SMTP id y7-20020a170902d647b02900e008eed8acmr23441451plh.4.1613547535042;
        Tue, 16 Feb 2021 23:38:55 -0800 (PST)
Received: from localhost.localdomain ([106.201.18.198])
        by smtp.googlemail.com with ESMTPSA id b3sm1352615pgd.48.2021.02.16.23.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 23:38:54 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, phillip.wood123@gmail.com,
        Charvi Mendiratta <charvi077@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 5/6] t3437: use --fixup with options to create amend! commit
Date:   Wed, 17 Feb 2021 13:07:24 +0530
Message-Id: <20210217073725.16656-5-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210217073725.16656-1-charvi077@gmail.com>
References: <20210217072904.16257-1-charvi077@gmail.com>
 <20210217073725.16656-1-charvi077@gmail.com>
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

