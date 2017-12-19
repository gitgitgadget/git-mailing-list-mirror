Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDCAE1F406
	for <e@80x24.org>; Tue, 19 Dec 2017 22:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753415AbdLSW04 (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Dec 2017 17:26:56 -0500
Received: from mail-io0-f172.google.com ([209.85.223.172]:44378 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753127AbdLSW0x (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Dec 2017 17:26:53 -0500
Received: by mail-io0-f172.google.com with SMTP id w127so15243608iow.11
        for <git@vger.kernel.org>; Tue, 19 Dec 2017 14:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DeLM+1JZgNjJRMQtDA1OpGhZygqPpBl9HVHpW0Pb3bs=;
        b=mXzbGg1qDEBh1kNKtWO9EViYKLUHwJSZO8J2tOZQWW8LlcAdawJuJ2bAQWOLrfaub/
         3zInlyt5C4hXc/hqiSochPK3Ax4gMsD4Uce/yPRcXqIlaQ/AEJ96nXnlx3tzCN3+2Zz3
         002oboG0Ds0XRuONPClsh9A0al9lZHdvxgHbW0iMw0veU8FgR0o5W1Gw3V8Pdipv4MxB
         ABVAvCvm0czFwRWDpjG7+ThnLhejPY2emw13ANEsKl3mncEVMsFIYpShCH8JbksNZx5I
         LlNJZbEMt0DTCT+Tyw/LhhDvPjOFslDoiLUz5vyU/+Hvv+pb8jPINgkjrEcqQ5NWORT3
         C1cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DeLM+1JZgNjJRMQtDA1OpGhZygqPpBl9HVHpW0Pb3bs=;
        b=TocSGPcur5prF6cheB3YPkszLbjKkiyVIWKNWma1yhgjyfwBiFAQ8IvjpDFw1ywjYP
         hz4xBSroOhPMjWLEEC35Bcl03Lp1Vvb/SYlrT4DFqCzX0w7YJmDDUc9ib4T6AAMkqBJl
         heO5R6BeT7z9XfnjZzAjn6xz46Ouf5LpyuEouiQP/9rG7xJW6uIjeyp099sASDoN/tEm
         j00/lZgigUK4D8/PaweYB2lX6GKnJvoO6CK1z/D4Q2wAooMMf5z5hN6zQUPlptO3PPsV
         ksAGj+E5PlO3GDqeEPk0qbJYmx7bwLST0qlrAYNaXT2SnYd24pmelhIlVHK469QKdbQj
         F8qg==
X-Gm-Message-State: AKGB3mIATjuZrNOTgq5xyfwYPFErU2kxY3Ct6kVo76u/PITWNPmcfSQR
        XcKFrQGBufdGY/jLRFUP6emNFZabxhM=
X-Google-Smtp-Source: ACJfBotBHULrtHAMvsq/xoeP5FYA2gpjkVEtyEWoF7lLYCoZVFmeD91HTVxjUHveqJoKeN0+YDGBoQ==
X-Received: by 10.107.114.18 with SMTP id n18mr5934261ioc.240.1513722411886;
        Tue, 19 Dec 2017 14:26:51 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id m63sm1686160itm.12.2017.12.19.14.26.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Dec 2017 14:26:51 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/5] t/lib-submodule-update.sh: add new test for submodule internal change
Date:   Tue, 19 Dec 2017 14:26:34 -0800
Message-Id: <20171219222636.216001-4-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.620.gb9897f4670-goog
In-Reply-To: <20171219222636.216001-1-sbeller@google.com>
References: <20171219222636.216001-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test is marked as a failure as the fix comes in a later patch.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/lib-submodule-update.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index fb0173ea87..15cf3e0b8b 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -1015,4 +1015,15 @@ test_submodule_forced_switch_recursing_with_args () {
 			test_submodule_content sub1 origin/modify_sub1
 		)
 	'
+
+	test_expect_failure "$command: changed submodule worktree is reset" '
+		prolog &&
+		reset_work_tree_to_interested add_sub1 &&
+		(
+			cd submodule_update &&
+			rm sub1/file1 &&
+			$command HEAD &&
+			test_path_is_file sub1/file1
+		)
+	'
 }
-- 
2.15.1.620.gb9897f4670-goog

