Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F9BE1F454
	for <e@80x24.org>; Thu,  7 Nov 2019 18:51:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728383AbfKGSvz (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 13:51:55 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42600 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728253AbfKGSvz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 13:51:55 -0500
Received: by mail-pg1-f196.google.com with SMTP id q17so2575370pgt.9
        for <git@vger.kernel.org>; Thu, 07 Nov 2019 10:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2BLCzK76FFm+HLc9AK4IO5s/ZrE3apkIVY4M0J3ZR20=;
        b=Ch7edLASZALuDOh92OVkTLNbBvqgGxC+PUA4GyBKUowT/TYSkNoXYxtRJjN2/zC/Q6
         voqhGk1n6AddAxJELXY1cOkdJttX7KlHKFNgcGHpcsb9DQtqHRaZJUV7N0RGHHWAAOkY
         Ye8Iczc1TlHipVxtJzMhRklxw+d8bambLCCDn/KLjtwGXtC3zrMKEm3WWAEnUFKM3SFy
         ekFnbSiZ2R4+5AWB9ldBHWlEhpuXiSiXPynnnOPP/8V4AnsxfUWNR7fXQJQTldiIrhlL
         M78bpxLAnnUnVH7YBQ9wCJkepu/6IQ1KwLjmr8Qu68zJSOtPsxveQPnz2dgCFli/BGJB
         cHdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2BLCzK76FFm+HLc9AK4IO5s/ZrE3apkIVY4M0J3ZR20=;
        b=brNnzeFqtwelsUtYYVX6cPJesX+wcq9ieGU45za3HTSKdD0TBUS1tPUTxH+ewHUxf7
         wW6Xdh4Z54mW0c2TECztsX+4ba4mNi6oQ/Hdd9Rh4xO9M8Pji9RvpAQhCikctQR9+bRs
         TwoRyFq4IbRhUDfae6Ge3hjivNhOktgWs8BkakraxfL1SoR5uN5CszJmQs88x1Z2xjNR
         E6qYIRvV2bNkvnTp1KDkP27gwMgtFNtDKr7DcmtUo6My7IYxsOka5TTzDErvfu4vPHPU
         FRs5SRKSn7H6BEESkg/N2yzpUvG/Va2YpVhnvSriSo02jpJ5sVbeHqhb5cqcG7a0NCGs
         X7EQ==
X-Gm-Message-State: APjAAAXul3EOphfPfP0Ctmxr54lQOGVM6977RiJU2meNpf1rjmMqu4La
        ji9FdiZRyf7HW8AvDqPaS79nLbJN
X-Google-Smtp-Source: APXvYqzLrP0rh+55h477KxhGMu5F5WT46rsjQf9CPvY5CzqUm/XFgOP5J1NrxVyr4TGGHHeUijvo9A==
X-Received: by 2002:a62:545:: with SMTP id 66mr5843600pff.1.1573152714482;
        Thu, 07 Nov 2019 10:51:54 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id y144sm3840747pfb.188.2019.11.07.10.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 10:51:53 -0800 (PST)
Date:   Thu, 7 Nov 2019 10:51:52 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 14/14] t5520: replace `! git` with `test_must_fail git`
Message-ID: <70698bd9020ee896def07c36981767e331d2047a.1573152599.git.liu.denton@gmail.com>
References: <cover.1571739459.git.liu.denton@gmail.com>
 <cover.1573152598.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1573152598.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, if a Git command fails in an unexpected way, such as a
segfault, it will be masked and ignored. Replace the ! with
test_must_fail so that only expected failures pass.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t5520-pull.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index ef3dbc201a..602d996a33 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -537,7 +537,7 @@ test_expect_success 'pull --rebase=i' '
 test_expect_success 'pull.rebase=invalid fails' '
 	git reset --hard before-preserve-rebase &&
 	test_config pull.rebase invalid &&
-	! git pull . copy
+	test_must_fail git pull . copy
 '
 
 test_expect_success '--rebase=false create a new merge commit' '
@@ -572,7 +572,7 @@ test_expect_success REBASE_P \
 
 test_expect_success '--rebase=invalid fails' '
 	git reset --hard before-preserve-rebase &&
-	! git pull --rebase=invalid . copy
+	test_must_fail git pull --rebase=invalid . copy
 '
 
 test_expect_success '--rebase overrides pull.rebase=preserve and flattens keep-merge' '
-- 
2.24.0.rc2.262.g2d07a97ef5

