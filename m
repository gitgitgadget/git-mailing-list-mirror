Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5937C4332F
	for <git@archiver.kernel.org>; Wed, 21 Dec 2022 04:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234404AbiLUEf1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Dec 2022 23:35:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiLUEfW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2022 23:35:22 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4BB1DA7F
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 20:35:20 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id i187-20020a1c3bc4000000b003d1e906ca23so638106wma.3
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 20:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PEB8449UuUTqlL80vaAh5ZSQwMn+qZ4jCy1BCSlQaMU=;
        b=Kq4CkXTtfP7HWw+x+qSPvDSkxhhJ/jxEaeko9sN8zAQOUM6FDo8aVC2qp286DhphB+
         K+xzrrWaaULRSSH/UHDbk+thCMHSh3TMM2Wy7QgWFOzqxDVQwo5kDS/eb9YbM/Lma9sU
         VXQXJYQDx+ZBGJBZWV5KL915fmJLylCL6Yx04loqNAW4jZaGuoH8tbr4NWjS0oBZkcLy
         5XC1MZiWCPe2t4Eyd6s0DjSDp3vbspSqqKkCOzG9Wp6fhLxkfVdwf9kGehpmStlY6Cwd
         C4se7IEASnhWstoGQ3OftQaz0SFRx7iQHyjY79t2padA92pCHSo1W3GAAmmeknlpFTTj
         S5Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PEB8449UuUTqlL80vaAh5ZSQwMn+qZ4jCy1BCSlQaMU=;
        b=kwSEbDhGkcRe2LCpL7xRjGvHphoVPFKvyUgKTYEzxnlmIzLKIPz6v0A5nqjaxHYHys
         4eIZimRLojt9I86qavnv9gToB6jzDrcMIbVd3MmNlJDi2/4wqUmsmRnYb4UZERWrTGTr
         BV03GbQwGyO4zoOOOBgbtiyURj0DjUA/SAlBCqLNMuwC0r9UetHR5vleqYymyQCiFZ8V
         U9z/Jn4dOWthbp/MsEiOqzi4IFFy/RdKpHM1WTaFkjm12hZ4rckopXOpO+GSAL6F41TM
         J9J7svsOViJsHEn2lZ3N1/V9aDL6407/LCzr+KDKQBS6kgXtrgJ/rRCIGIZQSk3x20QK
         +mRg==
X-Gm-Message-State: AFqh2kodu1hs6/LIvAI5fWQF1jRE8h/sRQZi8Yw1NytDHtY8wy7U/z1c
        ptBNuUd0cdfbQ4UTTjYLkHDa0BCYRzc=
X-Google-Smtp-Source: AMrXdXuB8FxcyKN55KZNuG1KEs4KmkaoFaQaSk5BsyYk41ZMuX7vR9x1jz3jsGD5KBEwEG9TnyPfxQ==
X-Received: by 2002:a05:600c:1c97:b0:3d1:c8e3:2452 with SMTP id k23-20020a05600c1c9700b003d1c8e32452mr620015wms.30.1671597319367;
        Tue, 20 Dec 2022 20:35:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k31-20020a05600c1c9f00b003d22528decesm754677wms.43.2022.12.20.20.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 20:35:18 -0800 (PST)
Message-Id: <0b5afdb93dbf20e8467368be77779b89201a0cad.1671597317.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1406.v6.git.git.1671597317.gitgitgadget@gmail.com>
References: <pull.1406.v5.git.git.1671571084753.gitgitgadget@gmail.com>
        <pull.1406.v6.git.git.1671597317.gitgitgadget@gmail.com>
From:   "Seija Kijin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 21 Dec 2022 04:35:16 +0000
Subject: [PATCH v6 1/2] win32: close handles of threads that have been joined
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Rose <83477269+AtariDreams@users.noreply.github.com>,
        Seija Kijin <doremylover123@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Seija Kijin <doremylover123@gmail.com>

After joining threads, the handle to the original thread
should be closed as it no longer needs to be open.

This change makes the function POSIX compliant.

Signed-off-by: Seija Kijin <doremylover123@gmail.com>
---
 compat/win32/pthread.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/compat/win32/pthread.c b/compat/win32/pthread.c
index 2e7eead42cb..cf94b4491f9 100644
--- a/compat/win32/pthread.c
+++ b/compat/win32/pthread.c
@@ -37,16 +37,18 @@ int pthread_create(pthread_t *thread, const void *unused,
 
 int win32_pthread_join(pthread_t *thread, void **value_ptr)
 {
-	DWORD result = WaitForSingleObject(thread->handle, INFINITE);
-	switch (result) {
-		case WAIT_OBJECT_0:
-			if (value_ptr)
-				*value_ptr = thread->arg;
-			return 0;
-		case WAIT_ABANDONED:
-			return EINVAL;
-		default:
-			return err_win_to_posix(GetLastError());
+	switch (WaitForSingleObject(thread->handle, INFINITE)) {
+	case WAIT_OBJECT_0:
+		if (value_ptr)
+			*value_ptr = thread->arg;
+		CloseHandle(thread->handle);
+		return 0;
+	case WAIT_ABANDONED:
+		CloseHandle(thread->handle);
+		return EINVAL;
+	default:
+		/* the function failed, so do not detach */
+		return err_win_to_posix(GetLastError());
 	}
 }
 
-- 
gitgitgadget

