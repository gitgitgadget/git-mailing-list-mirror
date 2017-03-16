Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C66D2202C1
	for <e@80x24.org>; Thu, 16 Mar 2017 06:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751182AbdCPGRm (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 02:17:42 -0400
Received: from mail-qt0-f182.google.com ([209.85.216.182]:34686 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751076AbdCPGRl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 02:17:41 -0400
Received: by mail-qt0-f182.google.com with SMTP id n21so30047953qta.1
        for <git@vger.kernel.org>; Wed, 15 Mar 2017 23:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=UqravoJw4hNa8wqEzzOAGOhKL4BTx7qfPlr9GehjD04=;
        b=C20HPLmz5IMX8v3v0+Tvtw/VRIhJG+OoOVUQWIjDJRtLc79u4l1fn+sLIWh1FVOJWd
         8doLpYkgrV28lmAbkql8gGSumeS1co29JAlAcAq57fPaz9tB1PXXBZhewJwM/7i/lJTV
         RGlgutVul1y8+jBJckYxiroQrCXTYB5w3p6afo3L5FVLgxplZxxiSgwVSM8DlkKRfNsI
         qJt1HLiufxMtiPdIUy+s/N8v/MpxuUAeV7HZEdrS2GhcIlPhccRnEJU7iCBlsrxdDNlF
         wFuVQejKIG7TCooy5oOwczymTZ2ol1wCs4LxphVpcfEj41qP82eH6dx9n5gmSNR5wj0Z
         Oclw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=UqravoJw4hNa8wqEzzOAGOhKL4BTx7qfPlr9GehjD04=;
        b=eHIocdQ7k3kdP900vBGiGMs5rLL3uPEJxbuMb7uOnMztucKMRAx0nEzq+SruBBdEBL
         bXxQpUOsmHhs9GYbq6MRw+X+W4EO2TKHmfltA8hBOPBy21zc3fJnNgg001ljHtrLM1Ca
         9GCNhB14AcWaRhAUpFRV2JqsMgA+Nr9fd13l1emLOL7Jxun7fDEooZGXSXtufYZyvXe4
         19T/ooXc3HAq6HpwxK+WBFq2TMhVgIHaBDnDyDPKNIS6S/PoRozsl9Dsbavm7n1GZ4ZG
         TxFglfpT6r5yLhHqq05/QgDZPfvruRnFHEV7ywqb4Sn3xEnFKYzNqb3lAzVmYsAomc4d
         51CQ==
X-Gm-Message-State: AFeK/H1O4SqJfDLPKvL43b8AHwQDiN8M0eVIJNaUAD7183Lipg3MRvlDQ5bo/Lz9FBOY4g==
X-Received: by 10.237.35.83 with SMTP id i19mr6542373qtc.70.1489645060208;
        Wed, 15 Mar 2017 23:17:40 -0700 (PDT)
Received: from mango1.eduroam.cornell.edu (nat-128-84-124-0-52.cit.cornell.edu. [128.84.124.52])
        by smtp.googlemail.com with ESMTPSA id a26sm3004858qtb.28.2017.03.15.23.17.39
        for <git@vger.kernel.org>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 15 Mar 2017 23:17:39 -0700 (PDT)
From:   Devin Lehmacher <lehmacdj@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH] Makefile: escape ' in bin-wrappers rule
Date:   Thu, 16 Mar 2017 02:17:38 -0400
Message-Id: <20170316061738.26760-1-lehmacdj@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If the pwd contains a ' escape it as '\'' so that git will not fail
while building on a path containing '.
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index ed68700ac..5cf5d8537 100644
--- a/Makefile
+++ b/Makefile
@@ -2276,7 +2276,7 @@ all:: $(NO_INSTALL)
 bin-wrappers/%: wrap-for-bin.sh
 	@mkdir -p bin-wrappers
 	$(QUIET_GEN)sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
-	     -e 's|@@BUILD_DIR@@|$(shell pwd)|' \
+	     -e 's|@@BUILD_DIR@@|$(shell pwd | sed -e "s/'/'\\\''/g")|' \
 	     -e 's|@@PROG@@|$(patsubst test-%,t/helper/test-%,$(@F))|' < $< > $@ && \
 	chmod +x $@
 
-- 
2.11.0

