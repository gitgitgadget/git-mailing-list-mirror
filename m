Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E414EC2BA83
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 14:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B70512187F
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 14:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGtO3VYt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387433AbgBNOoy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Feb 2020 09:44:54 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50253 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727822AbgBNOow (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Feb 2020 09:44:52 -0500
Received: by mail-wm1-f68.google.com with SMTP id a5so10199135wmb.0
        for <git@vger.kernel.org>; Fri, 14 Feb 2020 06:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5kC8PpjlwM8iMZkewDBjrt2v33GjpYgn3pFe6ohOsls=;
        b=YGtO3VYtKzUtEqzW7jD7DHYRHEi/33Mqk6mL4g7Sdy7dKxv5c2YsHZU2eFJtfKXxVB
         T7pgeV6AaO5EH6cQ8A54+3HCJ8hnDWt5C8B0dN57o0kOuuF0cPerUaZZU3RiQRjtflrf
         4EVtUNUDONbFYdc7kM2J5uF07gm0yrf9KuctXplBs0auNC4m/qtylPYJyLb4TJSx7ks/
         BWafpdScVcGhQguvZ6s6fUtAbBv88WXDhp+fR/NaNIEBe2ifnbcfXDU5wQaytPK4/oWH
         fyWbQZSKwXPfQB0HFyeePhB+O4PLD50Soz6OLvszZ6zGOGPC5RG8QX9h6PULmmTqv2+x
         ZBQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5kC8PpjlwM8iMZkewDBjrt2v33GjpYgn3pFe6ohOsls=;
        b=BjEpZozhb17NQK271iCwu97NC+tahxfbWVlyT3BrfdHfou9zVZRp0T77YsDJTQeDK1
         Spm3vHUiuQ+EmYj5dWQwwPDaZWh3bVT3SP+wOz46Jia7k4i8RlVMGtbGEOf3Cdl0KdFU
         /0LndK0Z43nfBN6pskmeuU+Jc3Np36/oF3wDVtlCMZjpKbkhi0+Bn4l3yDyPQ0L2bqgM
         DaDaYXf0tohM+GcQ8IbJ5QQY2G0Sr43UaoebTWkWMcdvimTyFtxVQyNxAv0B9Lnc3N1Z
         ma0Bd+dP9qxvP2LwIiK/swUbV36aiD+iqijB8X8WpTYH3WMGzmlASc8IoRxHJB/G3QSr
         morQ==
X-Gm-Message-State: APjAAAUNrr0aCa33O5cr7DN+KPbjKtcIMps6mt0lRY4mJB4WWD7pMqvC
        cwCG4IOfdnblXkhY0EJZfjGvqWLQ
X-Google-Smtp-Source: APXvYqzI+ZkQUXWfJ7w44X4egRU8HI6KQhISM1LkUGqVlPHGWhNifO+Is5GNInbaxuiLHRukH22YZQ==
X-Received: by 2002:a1c:5445:: with SMTP id p5mr5014531wmi.75.1581691490183;
        Fri, 14 Feb 2020 06:44:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e22sm7852503wme.45.2020.02.14.06.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 06:44:49 -0800 (PST)
Message-Id: <ae1a4614ee4e08704d7731f47311963a4c01e2bd.1581691486.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.698.v6.git.git.1581691486.gitgitgadget@gmail.com>
References: <pull.698.v5.git.git.1581447484.gitgitgadget@gmail.com>
        <pull.698.v6.git.git.1581691486.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 14 Feb 2020 14:44:42 +0000
Subject: [PATCH v6 3/7] git-p4: add p4-pre-submit exit text
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Ben Keene <seraphire@gmail.com>, Ben Keene <seraphire@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Keene <seraphire@gmail.com>

When the p4-pre-submit exits with a non-zero exit code, the application
will abort the process with no additional information presented to the
user. This can be confusing for new users as it may not be clear that
the p4-pre-submit action caused the error.

Add text to explain why the program aborted the submit action.

Signed-off-by: Ben Keene <seraphire@gmail.com>
---
 git-p4.py | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index 4eccea3fa58..b1c86678fc6 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2405,7 +2405,15 @@ def run(self, args):
             sys.exit("number of commits (%d) must match number of shelved changelist (%d)" %
                      (len(commits), num_shelves))
 
-        if not run_git_hook("p4-pre-submit"):
+        try:
+            if not run_git_hook("p4-pre-submit"):
+                print("\nThe p4-pre-submit hook failed, aborting the submit.\n\nYou can skip " \
+                    "this pre-submission check by adding\nthe command line option '--no-verify', " \
+                    "however,\nthis will also skip the p4-changelist hook as well.")
+                sys.exit(1)
+        except Exception as e:
+            print("\nThe p4-pre-submit hook failed, aborting the submit.\n\nThe hook failed "\
+                "with the error '{0}'".format(e.message) )
             sys.exit(1)
 
         #
-- 
gitgitgadget

