Return-Path: <SRS0=B37d=3G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D594C33CB6
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 12:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42CA42082F
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 12:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X2EwnbDY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgAQMXe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jan 2020 07:23:34 -0500
Received: from mail-wr1-f42.google.com ([209.85.221.42]:34014 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbgAQMXe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jan 2020 07:23:34 -0500
Received: by mail-wr1-f42.google.com with SMTP id t2so22538953wrr.1
        for <git@vger.kernel.org>; Fri, 17 Jan 2020 04:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6PtBOCH3++iVFMvTvJcZuKbnk4q4ZepImhEvYpP1iwU=;
        b=X2EwnbDYghg1aV+tiuJvn9etMdcgrapyahy2F8VnGKK36K6URfesFODaYPH3otLh/t
         FrJYmSjS8VALgkALv1kyObeEZs7fg1cIK8Sbv917Z7qoXTGtdoTSO/Pokq9xl/Kk68pB
         zWDOMYurss5AxLjHQFwDOPVwuDLLWpUZxTcuaMEVdSsb3re+lwaCEw4fT4tQn4t8AWsR
         oz9mhr2Fvs/fD4uXeu+D4+3OSABrFs91PFNZJjL0whv1ICYZPb8YoHHV714CruoeavnU
         H3Z3LAQAwImbL5KFRCDqoG3ELeJ7gfcWIN1U8frBXPuLVmB1cuh0ZESXEfbSv3xMkzfo
         BtPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6PtBOCH3++iVFMvTvJcZuKbnk4q4ZepImhEvYpP1iwU=;
        b=b4DBQbhBEHUK8TgfT4Xe9sYAJ00AiwCDxV5A/ZeX21ZiPWdtTbUKn8F2OAhM7hh4lf
         LwB3M5tJzGC0Lp+QHHqnyTfAvV6ZVeKpn4RXI5UzjiCoPqtPH9BZ3yv0sfUh8byVuBxh
         feYpgA/CB8DVW8vXeKYymRzBw038Aa8NdhR8bwNvar6NAZXeOgNmmiDZjNTdH/2etrzv
         M7+fGIAa6F457/BtLu6LDlffX4TazhpjIDZPivaXK+C6DZQq+93BfIAxypZ+0vScCbzL
         3+JYTjgDQNQQr+sCSUlv/L0H7a47+c3RlVkUsd6Gxu7+NZKPEbVcb4AcXBSRDnCCzEE3
         DdtA==
X-Gm-Message-State: APjAAAUtjHekFbmO+UZYWo35qJYxY1GhA0GWVnWeqO3/V0sJ/4exOEB6
        pPx75rRmixLrptGQPLOnrcNzi9Bo
X-Google-Smtp-Source: APXvYqzhJ8Mv2smkIkca9Myixslz3KF6gNdrtPeqR1HCidcpTXeEZ0Kn622UgojNYM6A41SdD9idSA==
X-Received: by 2002:a5d:4ed0:: with SMTP id s16mr2869084wrv.144.1579263812197;
        Fri, 17 Jan 2020 04:23:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g25sm2872280wmh.3.2020.01.17.04.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 04:23:31 -0800 (PST)
Message-Id: <ff33339690ec167640f989d989cf9b1b14b9e039.1579263809.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.523.git.1579263809.gitgitgadget@gmail.com>
References: <pull.523.git.1579263809.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 17 Jan 2020 12:23:26 +0000
Subject: [PATCH 1/4] t7410: rename to t2405-worktree-submodule.sh
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

This test was added in df56607dff (git-common-dir: make "modules/"
per-working-directory directory, 2014-11-30), back when the 'git worktree' command
did not exist and 'git checkout --to' was used to create supplementary worktrees.

Since this file contains tests for the interaction of 'git worktree' with
submodules, rename it to t2405-worktree-submodule.sh, following the naming scheme for
tests checking the behavior of various commands with submodules.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 ...410-submodule-checkout-to.sh => t2405-worktree-submodule.sh} | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename t/{t7410-submodule-checkout-to.sh => t2405-worktree-submodule.sh} (96%)

diff --git a/t/t7410-submodule-checkout-to.sh b/t/t2405-worktree-submodule.sh
similarity index 96%
rename from t/t7410-submodule-checkout-to.sh
rename to t/t2405-worktree-submodule.sh
index f1b492ebc4..f2eee328cc 100755
--- a/t/t7410-submodule-checkout-to.sh
+++ b/t/t2405-worktree-submodule.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-test_description='Combination of submodules and multiple workdirs'
+test_description='Combination of submodules and multiple worktrees'
 
 . ./test-lib.sh
 
-- 
gitgitgadget

