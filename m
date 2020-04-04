Return-Path: <SRS0=+7zH=5U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11044C2BA15
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 14:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D38F0206C3
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 14:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="grafdws5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbgDDOQZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Apr 2020 10:16:25 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45608 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgDDOQZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Apr 2020 10:16:25 -0400
Received: by mail-ed1-f67.google.com with SMTP id dj7so11009249edb.12
        for <git@vger.kernel.org>; Sat, 04 Apr 2020 07:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=b4aA3wDAVJYsJXPUgHUtP+z97LmvP69E2FxXnbgGXIE=;
        b=grafdws56kb3UGQ4B8fIB6bS4bpgwPACL9wtvzWgZ2w8+v5PWKaG47b7wbnRhdFrX7
         4LVDUAeKK3RJpGRd/QqHdpUlj2sY5j72QA9b2GyfkdBVt3jWfDMx4jz6aWM75I/sPGC2
         HRxlcNgpEl0PNJ82C/WF61c6jkrCtSxcIdezhAzfP3O3UWJovEGWMn3by1Hjzxj4Op1Z
         2rf+KHsdcrQUHv5PkxyhOgXHn4esmdzNgRC9CqVpX/bU6dSwggVIinGsGQ5NkNUETATU
         jhU7JQvj10dQ4n5hvyVHMd779VgF+PE+1cvTSKoXScwslwoFlm9VeIN9iep582Mp2R9m
         O1Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=b4aA3wDAVJYsJXPUgHUtP+z97LmvP69E2FxXnbgGXIE=;
        b=EigSNigITwZV5w9PaqFvDt81Ha+HSSDwrESSduIk4zI9/5OYOyZh4tIwPrFrd25XrK
         qbxFxIo7Q3DvI8uq2ov4LmvTTzKOEMxo55znuqERY/cKOzvosJ1u7VXYmCCMz4mY5+iw
         dkdyVZyuo4K8A8YFgsFWWTMMhq33aHmtdVlikmthzm3HncPJMgsUdfqtI+yczIGx44cr
         HgDDOZxLnuBIaKFVNXfGXSlnThzUdlTvZtPQ2+KMfZU7wdLaHMC9qpLe0NsoBHRztyF5
         d3INNBu7QXZxt6oZGDCuKcTR7YEuRmm+hvSecs0BmKYx060eFmv+dLf5MidZuU8b+lm6
         cxOg==
X-Gm-Message-State: AGi0Puboc0waNOeizZ0kqeRxyRwkbQ9EEYW8WKfsMU95KEkhPUkHruMN
        laWQzpb0xV7YTWpMto+Qiye8k3a+
X-Google-Smtp-Source: APiQypJtditGV0nze7XZgDUniyUhG3Dp0vreXxjPhRB75dcgP9f92cS/oiCdauT7ib6/d30M9Kwohw==
X-Received: by 2002:a50:c341:: with SMTP id q1mr12499253edb.247.1586009783129;
        Sat, 04 Apr 2020 07:16:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u20sm2200931eja.36.2020.04.04.07.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2020 07:16:22 -0700 (PDT)
Message-Id: <pull.598.git.1586009782089.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 04 Apr 2020 14:16:21 +0000
Subject: [PATCH] t0007: fix a typo
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    Fix typo "identites"
    
    I am fairly certain that 879ed7539357 (t: add tests for "git var",
    2012-11-28) did not meant to use the French spelling (for which the
    accent would be missing, anyway).

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-598%2Fdscho%2Ftyop-identites-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-598/dscho/tyop-identites-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/598

 t/t0007-git-var.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t0007-git-var.sh b/t/t0007-git-var.sh
index 1f600e2cae5..88b9ae81588 100755
--- a/t/t0007-git-var.sh
+++ b/t/t0007-git-var.sh
@@ -17,7 +17,7 @@ test_expect_success 'get GIT_COMMITTER_IDENT' '
 	test_cmp expect actual
 '
 
-test_expect_success !FAIL_PREREQS,!AUTOIDENT 'requested identites are strict' '
+test_expect_success !FAIL_PREREQS,!AUTOIDENT 'requested identities are strict' '
 	(
 		sane_unset GIT_COMMITTER_NAME &&
 		sane_unset GIT_COMMITTER_EMAIL &&

base-commit: 9fadedd637b312089337d73c3ed8447e9f0aa775
-- 
gitgitgadget
