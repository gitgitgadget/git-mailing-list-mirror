Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1893C38142
	for <git@archiver.kernel.org>; Tue, 31 Jan 2023 14:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbjAaOxs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Jan 2023 09:53:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232165AbjAaOxq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2023 09:53:46 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75D5EC4A
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 06:53:40 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id q10-20020a1cf30a000000b003db0edfdb74so916482wmq.1
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 06:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hES9JFbjUDR8QbowBmtZ1k2P5v62Ded834bcSnkqA20=;
        b=VPwlguce1rgljz8bzHIZB3wwJ5lBrxap44gGfpFs0GtrvaZa/ZxHm+ropziCdg4NTp
         gpMr8bt8ovfB0d8NlIarXiG6gUhwGm3omGkQAvcUaY3Gu7VzGsGHitQxjY7wSbZFlsJ0
         iyhXNE33TpSIvF9JSqXoBa/fEhm37hCvHuVlTCcwgV4V9VTzODGeBXvBYrh4ZSAIEp+w
         dfYpePXhlkK6Yrwo5PzIkWkwXkrYQTWrHeo4s1iTZctUbke1ghs8YfQMlfRpvEUxc1yv
         v1AIX785HtF9RPuxPQjZdZ4s9wN9zrDPwvcbBDns4I0aqvZk2nuiTsigv6lR+5Adn2yS
         MYGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hES9JFbjUDR8QbowBmtZ1k2P5v62Ded834bcSnkqA20=;
        b=11g9buqmiX1P0J72G6Cu+7Xvt3JhHqr7m7Vp7o9YX7De71/hk2kFMMMGDFg64+gt/C
         rLo3NTtenI0OhgiGtB3q7hXMKY0eC5RsLacV2IyK2eZ2K0WP1xv8u5TSThqQn+56bPAp
         IrxFTUM46k6HcqI+fNlB4JxvSYoXqz2NjYqf/FhXHP4a9QCDIAbx9O/Hf5+NV7T8Udul
         pWd3NtxNg6UM47HIr/cVlgPkA6cSNKCv5JT9daALFhX07G1nDKS5QhmBnuYF61FqZEjr
         Ds3D1bkdmVjE9o/zWnZ50B6uL2yMageOvl05T4ZtD/RJ/caT6OJFcUWdqXE5sTLmwrVD
         stYQ==
X-Gm-Message-State: AO0yUKWv9HChomi2wj5Plqa7TiaT9wEI8kFdgHds4a+LxcwMBjmjJDOc
        xYFHEWyp3LaU0SHhztxBI7eWW1Myb0Y=
X-Google-Smtp-Source: AK7set/htybPHfqBDQ3WCNwx1Lr/Vg/MeAbNaTUNfBxj7tdKeDxjG83P5i1/ayplD2l3OwsBLyfEuA==
X-Received: by 2002:a05:600c:511c:b0:3dc:5240:53b6 with SMTP id o28-20020a05600c511c00b003dc524053b6mr10119910wms.6.1675176818955;
        Tue, 31 Jan 2023 06:53:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t19-20020a1c7713000000b003dc48a2f997sm10899037wmi.17.2023.01.31.06.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 06:53:38 -0800 (PST)
Message-Id: <pull.1445.v2.git.git.1675176818033.gitgitgadget@gmail.com>
In-Reply-To: <pull.1445.git.git.1675176581433.gitgitgadget@gmail.com>
References: <pull.1445.git.git.1675176581433.gitgitgadget@gmail.com>
From:   "Rose via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 31 Jan 2023 14:53:37 +0000
Subject: [PATCH v2] win32: check for NULL after creating thread
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Rose <83477269+AtariDreams@users.noreply.github.com>,
        Seija Kijin <doremylover123@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Seija Kijin <doremylover123@gmail.com>

Check for NULL handles, not "INVALID_HANDLE,"
as CreateThread guarantees a valid handle in most cases.

The return value for failed thread creation is NULL,
not INVALID_HANDLE_VALUE, unlike other Windows
API functions.

Signed-off-by: Seija Kijin <doremylover123@gmail.com>
---
    win32: check for NULL after creating thread
    
    Check for NULL handles, not "INVALID_HANDLE," as CreateThread guarantees
    a valid handle in most cases.
    
    The return value for failed thread creation is NULL, not
    INVALID_HANDLE_VALUE, unlike other Windows API functions.
    
    Signed-off-by: Seija Kijin doremylover123@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1445%2FAtariDreams%2FhThread-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1445/AtariDreams/hThread-v2
Pull-Request: https://github.com/git/git/pull/1445

Range-diff vs v1:

 1:  e75d15e42f4 ! 1:  c956cafdec9 win32: check for NULL when creating thread
     @@ Metadata
      Author: Seija Kijin <doremylover123@gmail.com>
      
       ## Commit message ##
     -    win32: check for NULL when creating thread
     +    win32: check for NULL after creating thread
      
          Check for NULL handles, not "INVALID_HANDLE,"
          as CreateThread guarantees a valid handle in most cases.


 compat/winansi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/winansi.c b/compat/winansi.c
index 3abe8dd5a27..f83610f684d 100644
--- a/compat/winansi.c
+++ b/compat/winansi.c
@@ -644,7 +644,7 @@ void winansi_init(void)
 
 	/* start console spool thread on the pipe's read end */
 	hthread = CreateThread(NULL, 0, console_thread, NULL, 0, NULL);
-	if (hthread == INVALID_HANDLE_VALUE)
+	if (!hthread)
 		die_lasterr("CreateThread(console_thread) failed");
 
 	/* schedule cleanup routine */

base-commit: 2fc9e9ca3c7505bc60069f11e7ef09b1aeeee473
-- 
gitgitgadget
