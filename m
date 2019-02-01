Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72C2E1F453
	for <e@80x24.org>; Fri,  1 Feb 2019 13:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729837AbfBANzu (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 08:55:50 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55891 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729515AbfBANzu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 08:55:50 -0500
Received: by mail-wm1-f68.google.com with SMTP id y139so6159743wmc.5
        for <git@vger.kernel.org>; Fri, 01 Feb 2019 05:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Htb8vi/1dzVrxlNDodFb+ie7e/tCrLWLbxQaFxjdDEw=;
        b=JlSopTnA8Bc8ak9uuz98hcb3yRBeGElgaMbYb56sPgzmD4ysZoU0tzOCjmaVswGt0h
         qrHVXOkTEnyiT/lDChIcwy9QNVWFV3GSIFMTg3GWhXdPVUyxQOI3+lE275Vy4pKG20wq
         1URS7tNYmNet0B5Qux+PTUOG+Z0Y2lGyu7T7/D4vCUzXXEs9JfKV8udUA1bTXbloR9LY
         2A9oonO0G4JadINtI3oSvLdobytBSiPg9FOapWWmgXvs2DeJkXD+eArNG2dE/1RMLCQb
         EmCswZooaCYH0Kbe1DQlgP6DKqEdV3qxhPipyX5pfZySqGvUD325MKNSh3OI65z0sirr
         WJ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Htb8vi/1dzVrxlNDodFb+ie7e/tCrLWLbxQaFxjdDEw=;
        b=lppyiDQkvvvcynsEBZ9/awUraBQPPPegIEWV8LFHl3cJpgve9IsizkLiCeP6pca51w
         a+kTHtlx1zQ70H6lw5c1Wf00BwOjdJD8SANDYznBgiGwtu9BiEc9DNosi0Jru4bZtmhw
         jkUYL2j5NTpve/JhCJaGCgFnrmBVVb2f/6lmqusaUleef5IPPaLDbLvuNqrdaVo0n/Jg
         yfXCoMOXMYiq3hIgXxB8+y6+X28xDMmbMpVCqZKoSzuiGQkqTSyOre3earNdHYOqTMeX
         fXOqGgfOEcufMXaBIaGPKbc6tyMn0epXJAoRCbcQx/ELiVKjmznaXnPhg5CCGFGHbMSN
         t2fQ==
X-Gm-Message-State: AHQUAuZ03L8NPsSPZHetAd3yBd5YeLsViHfOA1UnxZj0sde3YHXXjg0t
        CG8dQG4t/n2xiiVoWtsJKnbBhf8KN8A=
X-Google-Smtp-Source: AHgI3IZoh2zUs1jHA6wXTES6nH9b5CzdFnoG9V7YehzxG7CisfQKcDKd2lJM9rA1Btg8moO2xprphQ==
X-Received: by 2002:a1c:c90b:: with SMTP id f11mr2542332wmb.33.1549029347504;
        Fri, 01 Feb 2019 05:55:47 -0800 (PST)
Received: from localhost.localdomain (ip5b43d796.dynamic.kabel-deutschland.de. [91.67.215.150])
        by smtp.gmail.com with ESMTPSA id f130sm3949513wme.41.2019.02.01.05.55.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 01 Feb 2019 05:55:46 -0800 (PST)
From:   Sebastian Staudt <koraktor@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Sebastian Staudt <koraktor@gmail.com>
Subject: [PATCH v4 2/2] t6120: test for describe with a bare repository
Date:   Fri,  1 Feb 2019 14:55:12 +0100
Message-Id: <20190201135512.68220-2-koraktor@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190201135512.68220-1-koraktor@gmail.com>
References: <20190201135512.68220-1-koraktor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This ensures that nothing breaks the basic functionality of describe for
bare repositories. Please note that --broken and --dirty need a working
tree.

Signed-off-by: Sebastian Staudt <koraktor@gmail.com>
---
 t/t6120-describe.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 7cfed77c52..ea2c3dbe1c 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -418,4 +418,9 @@ test_expect_success 'describe complains about missing object' '
 	test_must_fail git describe $ZERO_OID
 '
 
+test_expect_success 'describe works from outside repo using --git-dir' ' 
+  git clone --bare "$TRASH_DIRECTORY" "$TRASH_DIRECTORY/bare" &&
+  git --git-dir "$TRASH_DIRECTORY/bare" describe
+'
+
 test_done
-- 
2.20.1

