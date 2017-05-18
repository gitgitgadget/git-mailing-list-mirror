Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C004A2023D
	for <e@80x24.org>; Thu, 18 May 2017 08:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754813AbdERIWb (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 04:22:31 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:33436 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754157AbdERIWK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 04:22:10 -0400
Received: by mail-qk0-f196.google.com with SMTP id o85so5043587qkh.0
        for <git@vger.kernel.org>; Thu, 18 May 2017 01:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=k8IZu30aN5XyKOp64tpL4By2wtxxwgQeuZDZTW0IEbI=;
        b=gyrutF5Yo3lwX+8E25cwIeLxN6UjlekPNWfBb37GidiJ0FmAsn1Nh/9UKblSGpwNZW
         bB1cmIcxgH6SpMhhXCLGEuh6YAqYpKgeg3tHHYxjYiSzEHdgOobCSGBvvg77mkf9F/UR
         kgroy+Zi+UgmVW6rxSYmZNE6XKwwFp2zjVqA99w+VSKykH0XY9+YlC19Hnsz5nGt2shp
         Cpv13A8KPVUTchfpqxE4+NzJcLyy3cZqMMS0tv2vyxgZJrGW6w2PzisJrUo5cGj696tT
         kvXUHrCydw39IKWEU+qZxp/JR0cTBTzZLoN/Gi31cOaBx8SO+W8S1wdechntSsBgk+eX
         IQRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=k8IZu30aN5XyKOp64tpL4By2wtxxwgQeuZDZTW0IEbI=;
        b=kOjAZmp8ZBf7++3SNr1KEeoJbizligehRDWBh1UYClCDI5jFU/hhp3O6d6d60TVQva
         olrgNMQRf4FQL9g2UK1D4yGOsUsH8By/VKItzE7NkFhC+pdrU4/d2y0Yjgv1baENyese
         +XQ+h1//BBzyppEBbKhtOzgdcfy0RygNetywuOvr4inrLaS86MIH/u3dRyYYobQZPv+S
         EgDfauCtKWXfFXeQuTlnzJ7BQIIDyny0pz4RF1Xm9uFIk8bFNZkI/pWqHj9WDAyBWsKm
         fVhlG4ijt8/oozQiROCfxIp9SZ5sfvQW0+0/N2Ri5ifOVE8xqzwKrlfZzOjLAcuYxVwG
         c3QA==
X-Gm-Message-State: AODbwcC7tYOairApqLGlXWlHsazsGXVtDz59c1pM7/zIvAqJVTmn5poe
        qH0SqSdCFmr82ajoLkQ=
X-Received: by 10.55.60.67 with SMTP id j64mr2762543qka.316.1495095729061;
        Thu, 18 May 2017 01:22:09 -0700 (PDT)
Received: from localhost.localdomain (cpe-98-14-117-223.nyc.res.rr.com. [98.14.117.223])
        by smtp.gmail.com with ESMTPSA id k36sm2999604qte.65.2017.05.18.01.22.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 May 2017 01:22:08 -0700 (PDT)
From:   Samuel Lijin <sxlijin@gmail.com>
To:     git@vger.kernel.org
Cc:     Samuel Lijin <sxlijin@gmail.com>
Subject: [PATCH v4 2/6] t7061: status --ignored should search untracked dirs
Date:   Thu, 18 May 2017 04:21:50 -0400
Message-Id: <20170518082154.28643-3-sxlijin@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170518082154.28643-1-sxlijin@gmail.com>
References: <20170518082154.28643-1-sxlijin@gmail.com>
In-Reply-To: <20170516073423.25762-1-sxlijin@gmail.com>
References: <20170516073423.25762-1-sxlijin@gmail.com>
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

