Return-Path: <SRS0=Fd5/=4D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FAD0C71150
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 21:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 267362086A
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 21:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="obsuf/a+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbgBOVgu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Feb 2020 16:36:50 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53288 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbgBOVgt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Feb 2020 16:36:49 -0500
Received: by mail-wm1-f65.google.com with SMTP id s10so13526151wmh.3
        for <git@vger.kernel.org>; Sat, 15 Feb 2020 13:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dWyXf3d0Hdj/EOckxrWUR/m2FbwnWwiqZhsBgUhNdR4=;
        b=obsuf/a+ztCenzd04T7Tduyk/sxyViekWFa0WOUSZUsFsolHVFnjj9RISvs1aBj7YA
         bTiWXWAsSTb9bWtzK7Il7ljT5b5sPVSyK4PUKju2+Pep5CgBmubsH+EQm2VX+AxwAgK1
         otambjhJlWIdQpsWZMW6Mz5wYIASbrbnafGyvh3Mz/tkNVRPaipbrrC+FioJ9Szjek5S
         1+1gUJn7OWccbmD9v1VbNLK9EkxtTabR+r2rQJhpJTfIF5pDAEeHLqf46Bw2840x/9tc
         miZzDW7zh+POo8hFIAv/9MFwBIfTjesy64pdbblKqLXUCBc0VAKhBiOkYAEVlAE9D/vh
         dNBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dWyXf3d0Hdj/EOckxrWUR/m2FbwnWwiqZhsBgUhNdR4=;
        b=LYgloHTAWgCJFfLieGwb/aU1ZMZtfCy78zGlXYdKGTY0OpBMQmTMZo/u6AXNhnLfc8
         l4/xH5oO6FgM2J58ELxKsJG0PsDQ5050tvf+uWhmx4LBeIQeKlZlmqxT25n2MQ42eo4T
         NUP5nuaa5U/CGno9h17vwIagb5kl7a5Wc1jgsGHQ1bUz/bIr1mBe/Tu8cpBslzGnDEQ+
         cJQYS/Nz5dcFin4/1A+Mjj3bm/HQaw8/EludefzvnYt4BxeD+YLEOvAQCX85OkCSg/Ne
         pde5qInZPi/x28joxWqeJt9cXgiEZ5U8ROrw8bxTdLot6ciTI1G1pOQOIsgzQOCBK6BJ
         eNpg==
X-Gm-Message-State: APjAAAXtOz84EmZ3lxVHc1CYCZiLYsgEMEPlS10CTUBK2gyWXBHBlBUu
        jXhAlvVpn95g1xdnGMxW5c7VHS38
X-Google-Smtp-Source: APXvYqzWkuUBP+R5mnKRf9YY0E6i/mJUr4c3gQvxJicQGIRIicuM8I5O2QRPnYIqHQ4BVgwRn8m6Jw==
X-Received: by 2002:a1c:b789:: with SMTP id h131mr12328723wmf.148.1581802607311;
        Sat, 15 Feb 2020 13:36:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n1sm12927799wrw.52.2020.02.15.13.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2020 13:36:46 -0800 (PST)
Message-Id: <f5170e71510732c5717c9f2d571ebc094890be64.1581802602.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.679.v5.git.git.1581802602.gitgitgadget@gmail.com>
References: <pull.679.v4.git.git.1579155273.gitgitgadget@gmail.com>
        <pull.679.v5.git.git.1581802602.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 15 Feb 2020 21:36:26 +0000
Subject: [PATCH v5 05/20] t3406: simplify an already simple test
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, phillip.wood@dunelm.org.uk,
        liu.denton@gmail.com, gitster@pobox.com, plroskin@gmail.com,
        alban.gruin@gmail.com, szeder.dev@gmail.com, jrnieder@gmail.com,
        emilyshaffer@google.com, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

When the merge backend was re-implemented on top of the interactive
backend, the output of rebase --merge changed a little.  This change
allowed this test to be simplified, though it wasn't noticed until now.
Simplify the testcase a little.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t3406-rebase-message.sh | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
index b393e1e9fee..0c2c569f959 100755
--- a/t/t3406-rebase-message.sh
+++ b/t/t3406-rebase-message.sh
@@ -18,11 +18,8 @@ test_expect_success 'setup' '
 '
 
 test_expect_success 'rebase -m' '
-	git rebase -m master >report &&
-	>expect &&
-	sed -n -e "/^Already applied: /p" \
-		-e "/^Committed: /p" report >actual &&
-	test_cmp expect actual
+	git rebase -m master >actual &&
+	test_must_be_empty actual
 '
 
 test_expect_success 'rebase against master twice' '
-- 
gitgitgadget

