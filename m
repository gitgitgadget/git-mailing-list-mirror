Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 317E3C636CC
	for <git@archiver.kernel.org>; Tue, 31 Jan 2023 14:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbjAaOtu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Jan 2023 09:49:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232019AbjAaOto (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2023 09:49:44 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1FAF8
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 06:49:43 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id hn2-20020a05600ca38200b003dc5cb96d46so3680221wmb.4
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 06:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=k9T/8lrqnYO49oCYPLcaUMj1vCeYXVMM5ULm0QteUt8=;
        b=b/lcAAdXy/LseM3GKtIzYZWwT9lOMAMQheA/2WNumgrsNrX4pCg6HHIsa8xzI+4r27
         aj1NSlQoyAbwQXlp0PvHwzjmEZclHOuFloHhe+WTSFsw95+KRe0rKpJQlF2NUCivOmB5
         Lfy7+LfRoybv6j+qS4EJJN5vLeY8jZecuzvT4NUGhJtH4+MJBLV48pAEkNdju419G4jB
         e/88Zk9QjCzVEO29cY91BY8xg5/uyPRNfuRtUinDHY17LpyPIU3N7DETqk/FXPVHkU8a
         qjU66ys8gleF9CDqonj79da7TTqSj/X2WLPkE2I+p50F4sHkPsRqsHCGVYXLOM4vEXNe
         yC2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k9T/8lrqnYO49oCYPLcaUMj1vCeYXVMM5ULm0QteUt8=;
        b=W49ozWA53TDOzhfdvr3FvPDF2h4tCWim2mUENkpEntrDg6cKgu/fY2aNXW5XRckIIV
         CmpvH+rC4OMnza10vXtIfTymblqljrIR7/s2qrg+eOVEbMCJ07DDKJQxIH9KTZkhn0a/
         LZ0e3nyNy63Wv0XJ2JbJRAJquh9KSi+Tdr1emgllj11GmZ8NFrwSX7aROF6XHa7d7iBU
         VFTvu9rvi2hLZmHC3azgV7GwV0HE8Oyb68pVXg4QXuWpUrbJeFSOFK3QmDQ7brpPU9Og
         rHGuIDbd0VmwUbEIcJJg4E+PomDDw6Cb2A/M2+nb1hPc5AYesxAwVxSXqLj/97eSTyYf
         kdCg==
X-Gm-Message-State: AO0yUKVegLCphuxLm9Xlw3L4Hy+zh9p/5F/ZchUXGpmaJGUx6BCi2J19
        cKYp+juq1TTjrYZ7KJl/r2k3B2Ckaiw=
X-Google-Smtp-Source: AK7set8jJdxofC5HAEm+9B+KPNQmzcpXuOwqHqW5QymKlpei9xFUNeNJKZSSb9PEdFVYx5/CewAjpQ==
X-Received: by 2002:a05:600c:4f43:b0:3dc:4356:533c with SMTP id m3-20020a05600c4f4300b003dc4356533cmr13820766wmq.5.1675176582218;
        Tue, 31 Jan 2023 06:49:42 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k34-20020a05600c1ca200b003ddf2865aeasm56189wms.41.2023.01.31.06.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 06:49:41 -0800 (PST)
Message-Id: <pull.1445.git.git.1675176581433.gitgitgadget@gmail.com>
From:   "Rose via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 31 Jan 2023 14:49:41 +0000
Subject: [PATCH] win32: check for NULL when creating thread
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
    win32: check for NULL when creating thread
    
    Check for NULL handles, not "INVALID_HANDLE," as CreateThread guarantees
    a valid handle in most cases.
    
    The return value for failed thread creation is NULL, not
    INVALID_HANDLE_VALUE, unlike other Windows API functions.
    
    Signed-off-by: Seija Kijin doremylover123@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1445%2FAtariDreams%2FhThread-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1445/AtariDreams/hThread-v1
Pull-Request: https://github.com/git/git/pull/1445

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
