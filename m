Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A42EC53210
	for <git@archiver.kernel.org>; Thu,  5 Jan 2023 15:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234769AbjAEPor (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Jan 2023 10:44:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234696AbjAEPok (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Jan 2023 10:44:40 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DCB05BA3E
        for <git@vger.kernel.org>; Thu,  5 Jan 2023 07:44:39 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id i17-20020a05600c355100b003d99434b1cfso1641295wmq.1
        for <git@vger.kernel.org>; Thu, 05 Jan 2023 07:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LALDJalj/jWAGbQui/a9xb6Cxuxb09zTIcklilPVUu8=;
        b=cO/jA1Atctj04X0MkvRcutXczHR42Ur1aD598IDaJxXYdqqIx8G5V2rX9TOcuErjlH
         ImM4SCzCV7dyL4CsSUEBpvJLd79MxCVq+rXdMm+3aDEZIgt/r6zYNcZtC/Cdjc4cbgaS
         seIkXyQ+xPs0JPuk7B5M4HSjc/zYoTZ9JFxEny0YUNxAUXbAkuUyJ3rOQLadOu7pR6Yi
         VjpruSOu6i3dm8VSt4RzxO+hDaGweasJQPAUGdoibP55moWRlAk5DMeMGqSYLpD1oplG
         +I8sGn+pbVVRVnmdEN+RsVx2raxnf3U+uXCEM1URjSKI0N/6qMkT8GvjsVsXpyNgN1Wz
         izJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LALDJalj/jWAGbQui/a9xb6Cxuxb09zTIcklilPVUu8=;
        b=pUtTLdclrvd+sxkJPQttfzbq8kV536ngrq0BbnLdPJB7GMaep5gd/cGns/ISvfpPvB
         sXf/85Chag0tN3brFiprBjFdU8reRlEHUbN1gQ5hIgeLNyEFHcAxz0vNlxUnLUQsHPKe
         K3Lc7l/ssxwd/FWULGKqPjGYtudIFj3XLNbPCvhqnAU97hehNvCivAdFwT6BS7rQGxPi
         3dXmvS+L6Zad1Mo9QOw5Dk6tkVEPgaIIJSYDJ7CyOLDXJlDF1ij/IZNxAZrZyU+Kow+i
         n5cwdNd4Oj3+ZBjvj16bFDhTqil9Vyz6tRZ3TZb5IURP8D5Qnmb4IKVjJqIBuVw+SB7y
         Vmbw==
X-Gm-Message-State: AFqh2kolQJFeVerPyyWycWM65RHUm7kpYh85CwO4f06VfN50sNtIJ1io
        mvfMceMnFLrvO2VJnr5dtqFTjK8HKuU=
X-Google-Smtp-Source: AMrXdXtZzyohT/1S9ccgzwVYTSrzwjlpJubk3kym75l2pMO2Zi1t3dbRyuzEwe+V5T/63UOufMgAxQ==
X-Received: by 2002:a05:600c:600a:b0:3d1:ed41:57c0 with SMTP id az10-20020a05600c600a00b003d1ed4157c0mr40146784wmb.30.1672933477411;
        Thu, 05 Jan 2023 07:44:37 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q187-20020a1c43c4000000b003c6c182bef9sm3337376wma.36.2023.01.05.07.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 07:44:37 -0800 (PST)
Message-Id: <aa0319bc08e5b05f291fb2b1e9e1b20734f512bf.1672933474.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1406.v14.git.git.1672933474.gitgitgadget@gmail.com>
References: <pull.1406.v13.git.git.1672762819.gitgitgadget@gmail.com>
        <pull.1406.v14.git.git.1672933474.gitgitgadget@gmail.com>
From:   "Seija Kijin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 05 Jan 2023 15:44:34 +0000
Subject: [PATCH v14 2/2] win32: close handles of threads that have been joined
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Rose <83477269+AtariDreams@users.noreply.github.com>,
        Seija Kijin <doremylover123@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Seija Kijin <doremylover123@gmail.com>

After the thread terminates, the handle to the
original thread should be closed.

This change makes win32_pthread_join POSIX compliant.

Signed-off-by: Seija Kijin <doremylover123@gmail.com>
---
 compat/win32/pthread.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/compat/win32/pthread.c b/compat/win32/pthread.c
index cf53bc61d82..85f8f7920ce 100644
--- a/compat/win32/pthread.c
+++ b/compat/win32/pthread.c
@@ -42,10 +42,13 @@ int win32_pthread_join(pthread_t *thread, void **value_ptr)
 	case WAIT_OBJECT_0:
 		if (value_ptr)
 			*value_ptr = thread->arg;
+		CloseHandle(thread->handle);
 		return 0;
 	case WAIT_ABANDONED:
+		CloseHandle(thread->handle);
 		return EINVAL;
 	default:
+		/* the wait failed, so do not detach */
 		return err_win_to_posix(GetLastError());
 	}
 }
-- 
gitgitgadget
