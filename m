Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61AA81F453
	for <e@80x24.org>; Fri, 18 Jan 2019 18:56:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729115AbfARS4K (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 13:56:10 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43968 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729088AbfARS4J (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 13:56:09 -0500
Received: by mail-qt1-f193.google.com with SMTP id i7so16318199qtj.10
        for <git@vger.kernel.org>; Fri, 18 Jan 2019 10:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K3M7soHG9l+dFxdBvMpAoMj20umOY+jhTHwiMCVOOqo=;
        b=A5AUn+YtIOFj+uez19+Zhc2g9t+Kk31PbdggNv3a0QIMaa8SAaORAjNQ7UkyYrWD/d
         Veuk97taWEOinm7VDjF+4HqZArxS2w6v5VAKH9CDQv4CGtvk9zytlwai47eetZoOQUs/
         BOFXTbStoVEqCAW9tzuWzaT9WKCMa6TdF8Idzv4+ScL4ptL6Ihv3nkdZRptyKl5qD9Lg
         taTby5D+hjE4veYn94q9s8K9crfJGKAhV8lWKLJfD9MPi5zSFe330NH4NDzBE5Dnyu8L
         Qm0J/iNWfR3PhifiBbKXKIBCqmN0yqP4x4F62IrS/3AS+F+YcbhJeI4bZG6wzEI9/PeG
         hPdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K3M7soHG9l+dFxdBvMpAoMj20umOY+jhTHwiMCVOOqo=;
        b=X0kWVryrAe0fKf0GeGxsqtUbKGC4qcvNUdBROjvCt19F7CBEpHjbJrZ7+6wVEMFPw2
         XFeKaPfKSiS+uRjvWe05LG6KZk7zHK2gDPo8bUJi1ma2Xz4L6xN8Ro1Y/nddM1nFr2Bk
         XOTRolgi8ScQCyMvBw0KZeka0gBzZtI2YYsJSPx/lYen3pdY7QcJvyL65jobyE0Y677k
         +Es61k1zy8S/PRtIOXOzUo8ee8vV8aJFUfTuecF2CHNothM67sI0/Z8Pwt3031MMOD33
         6lJwlLvUO3xjVJdIGUQ43ZmPB7RtmlVeiSq73pL5dou/hetsoEmii6OJqoGpRRte7bQ4
         YLyw==
X-Gm-Message-State: AJcUukf4QRvMsT/pwoMhiGa8/DxwMmhYhsGRNrJZ/CGx7AFulMm+y6Yl
        G3aNSFRCoqNIgrRtvhvYJzccW1HQ31I=
X-Google-Smtp-Source: ALg8bN42bnXVqOo73I7S7zsy882FxjBZ78NOrdl2/AV5AAHhdSxBfZCnRr+Q81zqWr//tT+5ixFapg==
X-Received: by 2002:a0c:f74c:: with SMTP id e12mr4839278qvo.26.1547837768589;
        Fri, 18 Jan 2019 10:56:08 -0800 (PST)
Received: from localhost.localdomain (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id b20sm70228520qkb.17.2019.01.18.10.56.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 10:56:07 -0800 (PST)
From:   Ben Peart <peartben@gmail.com>
To:     git@vger.kernel.org
Cc:     benpeart@microsoft.com, asottile@umich.edu, pclouds@gmail.com,
        gitster@pobox.com
Subject: [PATCH v1 1/2] checkout: add test to demonstrate regression with checkout -b on initial commit
Date:   Fri, 18 Jan 2019 13:55:57 -0500
Message-Id: <20190118185558.17688-2-peartben@gmail.com>
X-Mailer: git-send-email 2.19.1.gvfs.1.16.g9d1374d
In-Reply-To: <20190118185558.17688-1-peartben@gmail.com>
References: <CA+dzEB=DH0irkFaRzkKERSjdZ=EJ+mG3Ri2Xeobx9Yu_eDd+jg@mail.gmail.com>
 <20190118185558.17688-1-peartben@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Peart <benpeart@microsoft.com>

Commit fa655d8411 checkout: optimize "git checkout -b <new_branch>" introduced
an unintentional change in behavior for 'checkout -b' after doing a
'clone --no-checkout'.  Add a test to demonstrate the changed behavior to be
used in a later patch to verify the fix.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 t/t2018-checkout-branch.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/t/t2018-checkout-branch.sh b/t/t2018-checkout-branch.sh
index 2131fb2a56..35999b3adb 100755
--- a/t/t2018-checkout-branch.sh
+++ b/t/t2018-checkout-branch.sh
@@ -198,4 +198,15 @@ test_expect_success 'checkout -B to the current branch works' '
 	test_dirty_mergeable
 '
 
+test_expect_success 'checkout -b after clone --no-checkout does a checkout of HEAD' '
+	git init src &&
+	echo hi > src/a &&
+	git -C src add . &&
+	git -C src commit -m "initial commit" &&
+	rev="$(git -C src rev-parse HEAD)" &&
+	git clone --no-checkout src dest &&
+	git -C dest checkout "$rev" -b branch &&
+	test_must_fail test -f dest/a
+'
+
 test_done
-- 
2.19.1.gvfs.1.16.g9d1374d

