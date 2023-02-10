Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D97C05027
	for <git@archiver.kernel.org>; Fri, 10 Feb 2023 15:07:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbjBJPHS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Feb 2023 10:07:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232488AbjBJPHM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2023 10:07:12 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0D634F5A
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 07:07:01 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id r18so4025106wmq.5
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 07:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xw3RBCN7ac/u6g96MWSRfW1NVe/iSo7iWqWz80o+CpQ=;
        b=BlxAoMe2NtxdGO9A6nXv8Cumy+rXD9BE+VDvbW84nyCDQ5o7RfLF+S8XtgjNkkRaV8
         UhV4bW6ZKU7NaeyDF6bSGdUsTtUujDU3yabpZ+wr0yhSaP2bC8Cg1OmjLLc+luV4foxT
         6ZoFvl6opxcbCYv0aLfSKMxsWdm7cU2Qm2TifQvqGMOYOtwQJMx9OEYd8OMNWQU1aY+H
         cvUDWvsrUM0whLr6gpJtBWGCLKHfyAGmBTQbkkaA2uJonT538JMBbrCmtiqxVdhDeEG6
         DxpbLkIYHgzEq/hutlTrmt7OGKVNF4V9on4FHnUsVaC1TK6H5ibvoQD0zO66hkXYdNo6
         d0iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xw3RBCN7ac/u6g96MWSRfW1NVe/iSo7iWqWz80o+CpQ=;
        b=4wEDYvteZl/ZW9GLy3l2A7QXhBbAxoBQIGOIFCa6qJ+rxVhGeDXZewWYNbMfUANQGx
         +R+K6vVix22HQN2I5szI0eIZx062NZIHCLxBfK/+RFZxkm21DPlXi1T19xIdrhYe+Nut
         BvpJklicy+NsWNCwJvSRrRLeQtgJwHsntyS1pD9Fjg4TAGN8vmzsIuEkQVRXZJazEnJq
         7TrKAL2k7VU0OMN3Wee6GE7TlYvQHPpDpppswcDLcOX0DDnPegMAp/fupY7tD/Si2rK9
         pYDxzZSUNimG6YOnCkt3yVuaaZE0U4RFueUOLCvMub8TlqgCyqvdV4W+pF1c/CPms0Yf
         NUcw==
X-Gm-Message-State: AO0yUKXWXgbqW/RK5xk4bQxAlofasHURTiEkWiQgF957ql4vvldW5LYx
        Mkb5HH+NdWxrwjt3SgJqMNtRSqy6/HI=
X-Google-Smtp-Source: AK7set/jNQqh4TSXGx/G0qhGR/18Z7iqitLEmnvDen5D3N2j3t0VnccSpzzvoGxKO401sHFnWx9XgA==
X-Received: by 2002:a05:600c:3788:b0:3df:9858:c039 with SMTP id o8-20020a05600c378800b003df9858c039mr10114856wmr.14.1676041619837;
        Fri, 10 Feb 2023 07:06:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i16-20020a05600c4b1000b003dc4fd6e624sm5039952wmp.19.2023.02.10.07.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 07:06:59 -0800 (PST)
Message-Id: <pull.1440.v7.git.git.1676041618809.gitgitgadget@gmail.com>
In-Reply-To: <pull.1440.v6.git.git.1676041473607.gitgitgadget@gmail.com>
References: <pull.1440.v6.git.git.1676041473607.gitgitgadget@gmail.com>
From:   "Rose via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 10 Feb 2023 15:06:58 +0000
Subject: [PATCH v7] win32: prefer beginthreadex over CreateThread
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Rose <83477269+AtariDreams@users.noreply.github.com>,
        Seija Kijin <doremylover123@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Seija Kijin <doremylover123@gmail.com>

Use _beginthreadex instead of CreateThread
since we use the Windows CRT,
as Microsoft recommends _beginthreadex
over CreateThread for these situations.

Finally, check for NULL handles, not "INVALID_HANDLE,"
as _beginthreadex guarantees a valid handle in most cases

Signed-off-by: Seija Kijin <doremylover123@gmail.com>
---
    win32: prefer beginthreadex over CreateThread
    
    Use pthread_exit instead of async_exit.
    
    This means we do not have to deal with Windows's implementation
    requiring an unsigned exit coded despite the POSIX exit code requiring a
    signed exit code.
    
    Use _beginthreadex instead of CreateThread since we use the Windows CRT.
    
    Finally, check for NULL handles, not "INVALID_HANDLE," as _beginthreadex
    guarantees a valid handle in most cases
    
    Signed-off-by: Seija Kijin doremylover123@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1440%2FAtariDreams%2FCreateThread-v7
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1440/AtariDreams/CreateThread-v7
Pull-Request: https://github.com/git/git/pull/1440

Range-diff vs v6:

 1:  67cef4bd8c9 ! 1:  edee5e78c67 win32: fix thread usage for win32
     @@ Metadata
      Author: Seija Kijin <doremylover123@gmail.com>
      
       ## Commit message ##
     -    win32: fix thread usage for win32
     +    win32: prefer beginthreadex over CreateThread
      
          Use _beginthreadex instead of CreateThread
          since we use the Windows CRT,


 compat/winansi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/compat/winansi.c b/compat/winansi.c
index f83610f684d..be65b27bd75 100644
--- a/compat/winansi.c
+++ b/compat/winansi.c
@@ -340,7 +340,7 @@ enum {
 	TEXT = 0, ESCAPE = 033, BRACKET = '['
 };
 
-static DWORD WINAPI console_thread(LPVOID unused)
+static unsigned int WINAPI console_thread(LPVOID unused)
 {
 	unsigned char buffer[BUFFER_SIZE];
 	DWORD bytes;
@@ -643,9 +643,9 @@ void winansi_init(void)
 		die_lasterr("CreateFile for named pipe failed");
 
 	/* start console spool thread on the pipe's read end */
-	hthread = CreateThread(NULL, 0, console_thread, NULL, 0, NULL);
+	hthread = (HANDLE)_beginthreadex(NULL, 0, console_thread, NULL, 0, NULL);
 	if (!hthread)
-		die_lasterr("CreateThread(console_thread) failed");
+		die_lasterr("_beginthreadex(console_thread) failed");
 
 	/* schedule cleanup routine */
 	if (atexit(winansi_exit))

base-commit: 23c56f7bd5f1667f8b793d796bf30e39545920f6
-- 
gitgitgadget
