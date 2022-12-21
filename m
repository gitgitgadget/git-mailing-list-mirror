Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA50C3DA7B
	for <git@archiver.kernel.org>; Wed, 21 Dec 2022 04:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234436AbiLUErG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Dec 2022 23:47:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234434AbiLUEq4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2022 23:46:56 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDBAC1B7A3
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 20:46:51 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id m5-20020a7bca45000000b003d2fbab35c6so607462wml.4
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 20:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9mhVgYN4PXguB1g+dFaefuyjmXHDxAgNME2CRqJlChM=;
        b=S68LmmsWz9WX0U4yrE8tcfI0Zug8njM+PfEg7+1XHNCRb6dxMzApVI4fABvkhkZo/E
         r1h8wEBKpqtvtPBROzhxuzJ3Q4dKm3Pj7Sg3K8ZYPnpTMfK7oMioEJs1B2n3yP6P4lUC
         LuHqAZjMsaiimsht9sRRXnMa4OJtmX20SIkU9u2O5NiQyyrfxo1KqcmQS+fq2Uvls6iJ
         a6OSANsyCkfK1mbN53A/Cak3+AwZlIC5QG/rkd5NPHPKW3WmeoER4ykVM76Mz+stHvdW
         KWpS8ibogZneczaDNvDalhaZ7VUoesOr2jrvYIgqQzP2VKXtOrW/bd5D2VBOzf4JH5I/
         qy9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9mhVgYN4PXguB1g+dFaefuyjmXHDxAgNME2CRqJlChM=;
        b=Vx4118NWgW62n7QWxEJTnYfjt2Ap4WRwstVCk+XoB0jfg2zsbZn7gprgKXFKST4ca3
         zPWif8Y6IsryJtnYHB/XPvDC13ftRDhKbzFMeYp8yzRNVmOz7/Ib3vmhQG+FFcHIZfKd
         SMUiJtu9pJmU9WfPJFEJlgnvuP24jlA78BRJTTe/tcsKcBgO0SD+VbldjO6/n9olqmU6
         z5VUZ62c50oM4LNTNFmNpLk5ua/pq5hblyZzH9gQxjuQo0nwwJp0Avsf/O6QDJfJScGs
         OQR7bBlzqBCWa1n0kBV9/pxZrOSO6eRdCNHfLaStAyUp/3GpkaQKUzvcAUao+nM96But
         Celw==
X-Gm-Message-State: AFqh2koMBETh0SBbPMPlvJQVzM4+HAHIR1xNpx0NbQkNo0+HeDCkqfBx
        1KVPh+cBUzEZ3kMuoMCGyzp7d2Yb3NE=
X-Google-Smtp-Source: AMrXdXtmYqB5JJXn9AwvagKPg5v+79Ly77IrcBSPZoyx+FnIAKHbSumTL0TlsBtrAzqFWaS/g1s32w==
X-Received: by 2002:a05:600c:1d98:b0:3d3:3d51:7d4b with SMTP id p24-20020a05600c1d9800b003d33d517d4bmr153887wms.29.1671598010258;
        Tue, 20 Dec 2022 20:46:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g16-20020a05600c4ed000b003a6125562e1sm802842wmq.46.2022.12.20.20.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 20:46:49 -0800 (PST)
Message-Id: <b40287508dfa9dc3013828f011c8729d8f8eb972.1671598008.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1406.v7.git.git.1671598008.gitgitgadget@gmail.com>
References: <pull.1406.v6.git.git.1671597317.gitgitgadget@gmail.com>
        <pull.1406.v7.git.git.1671598008.gitgitgadget@gmail.com>
From:   "Seija Kijin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 21 Dec 2022 04:46:47 +0000
Subject: [PATCH v7 1/2] win32: close handles of threads that have been joined
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

After the thread terminates, the handle to the
original thread should be closed.

This change makes win32_pthread_join POSIX compliant.

Signed-off-by: Seija Kijin <doremylover123@gmail.com>
---
 compat/win32/pthread.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/compat/win32/pthread.c b/compat/win32/pthread.c
index 2e7eead42cb..21c705778b6 100644
--- a/compat/win32/pthread.c
+++ b/compat/win32/pthread.c
@@ -42,10 +42,13 @@ int win32_pthread_join(pthread_t *thread, void **value_ptr)
 		case WAIT_OBJECT_0:
 			if (value_ptr)
 				*value_ptr = thread->arg;
+			CloseHandle(thread->handle);
 			return 0;
 		case WAIT_ABANDONED:
+			CloseHandle(thread->handle);
 			return EINVAL;
 		default:
+			/* the function failed, so do not detach */
 			return err_win_to_posix(GetLastError());
 	}
 }
-- 
gitgitgadget

