Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 630861FF30
	for <e@80x24.org>; Tue, 23 May 2017 09:18:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935464AbdEWJSn (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 May 2017 05:18:43 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:36618 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762274AbdEWJSj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 05:18:39 -0400
Received: by mail-qk0-f193.google.com with SMTP id y128so22154348qka.3
        for <git@vger.kernel.org>; Tue, 23 May 2017 02:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=k8IZu30aN5XyKOp64tpL4By2wtxxwgQeuZDZTW0IEbI=;
        b=iklQgcspu+KHLTNGRzmHEpvV+6EhSjpCX7nEySZWLeKhJ/geY4lGBLrgxm8svecvEb
         sXKbSx3ZQr2fqW7u129TtRTx0soosvB7AMm4YTo7Cii4uhA/GcLhF4THmRgOzEJWOx4f
         rzH43nOW/YPxe4ifGBaTZIeXdlDyMYQmlpFPMBsA79hwbHvOZBkNGe3PVUle6qQ7pAYT
         HwPrG+mScQWvBbSZkQ7SNDMmPIPQ58w+KF2DKoll2CgN9EMuR/znbYB32wnPZLnaDYIE
         yEg+O7D6oLMCDjK+VYPQ2C8rhM5gxHmKnS/WQazqWy72oGU5n2BSm/IDTWTM3vXV8m1n
         O/Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=k8IZu30aN5XyKOp64tpL4By2wtxxwgQeuZDZTW0IEbI=;
        b=jNZ7DXstpyY8Emi1zPKfhNq/jszMf7RzYSLW5lxKG7kX2igkAE8YvcoaZIDmRSPsD4
         7ZmJH8M3d9dvBc64ToxBD7mjXbisktOETwx0TpgRYMyKS8C8zyb25XJu9ZjWERBkEnPE
         IT/rMn6r+3wLH87fWFf6CrS0oSUKdcpdevpuoC2isS1cMQG+8ecBnudDUfaBr2Xe/z4F
         G5m8AVAvoRb+4Vzp/LBBMj0tfpptsc6UpvqHDTe0qsEBr90mscts8v+JBSWUVYZsmuZk
         l6d+RkNcfook1W8X1nHgPCOSB9wzZdMislCtYkSmPW7356DhKW7xLiCwxL4W38X5i14X
         dpkw==
X-Gm-Message-State: AODbwcDC7t3+6R8vbkTXdaX+4c3pdhYx6DYZyXM2iWock6jO34dSBiCw
        8gwAXcnIEW9ASA==
X-Received: by 10.55.98.8 with SMTP id w8mr18847034qkb.124.1495531118211;
        Tue, 23 May 2017 02:18:38 -0700 (PDT)
Received: from localhost.localdomain (cpe-98-14-117-223.nyc.res.rr.com. [98.14.117.223])
        by smtp.gmail.com with ESMTPSA id a45sm83105qta.39.2017.05.23.02.18.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 May 2017 02:18:37 -0700 (PDT)
From:   Samuel Lijin <sxlijin@gmail.com>
To:     git@vger.kernel.org
Cc:     Samuel Lijin <sxlijin@gmail.com>
Subject: [PATCH v5 2/6] t7061: status --ignored should search untracked dirs
Date:   Tue, 23 May 2017 05:18:25 -0400
Message-Id: <20170523091829.1746-3-sxlijin@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170523091829.1746-1-sxlijin@gmail.com>
References: <20170523091829.1746-1-sxlijin@gmail.com>
In-Reply-To: <20170518082154.28643-1-sxlijin@gmail.com>
References: <20170518082154.28643-1-sxlijin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Per eb8c5b87, `status --ignored` by design does not list ignored files
if they are in a directory which contains only ignored and untracked
files (which is itself considered to be untracked) without `-uall`. This
does not make sense for `--ignored`, which claims to "Show ignored files
as well."

Thus we revisit eb8c5b87 and decide that for such directories, `status
--ignored` will list the directory as untracked *and* list all ignored
files within said directory even without `-uall`.

Signed-off-by: Samuel Lijin <sxlijin@gmail.com>
---
 t/t7061-wtstatus-ignore.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/t7061-wtstatus-ignore.sh b/t/t7061-wtstatus-ignore.sh
index cdc0747bf..15e7592b6 100755
--- a/t/t7061-wtstatus-ignore.sh
+++ b/t/t7061-wtstatus-ignore.sh
@@ -9,9 +9,10 @@ cat >expected <<\EOF
 ?? actual
 ?? expected
 ?? untracked/
+!! untracked/ignored
 EOF
 
-test_expect_success 'status untracked directory with --ignored' '
+test_expect_failure 'status untracked directory with --ignored' '
 	echo "ignored" >.gitignore &&
 	mkdir untracked &&
 	: >untracked/ignored &&
@@ -20,7 +21,7 @@ test_expect_success 'status untracked directory with --ignored' '
 	test_cmp expected actual
 '
 
-test_expect_success 'same with gitignore starting with BOM' '
+test_expect_failure 'same with gitignore starting with BOM' '
 	printf "\357\273\277ignored\n" >.gitignore &&
 	mkdir -p untracked &&
 	: >untracked/ignored &&
-- 
2.13.0

