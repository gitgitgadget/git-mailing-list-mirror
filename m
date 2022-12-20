Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1826CC4167B
	for <git@archiver.kernel.org>; Tue, 20 Dec 2022 20:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234112AbiLTUEI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Dec 2022 15:04:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbiLTUEG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2022 15:04:06 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE0B1D653
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 12:04:05 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id h7so12863381wrs.6
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 12:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PpBH+HvKJF/Y9opBrBZcuWNva56y2Q0ejPCkHHJF/ig=;
        b=PHrjC8lmBTgL72JCnDQgtvtNnPQnV800Q5T0j+bKNQQSUYCzUrU43WtCMHnsyUgSPB
         aD0/WAo5KeOP2uUrPRHnb36HuWpVCQEL0TqtGWOj9guWJeppEWOAKiCkcYhTo/Qm8/c3
         SOXpXXlGpqdaIFfP5PZ8pORsBcx5qB8Kg8e+pnr+BCsu3tx8zs0HthSOpgdiR86Typ9b
         9NiQizmN/6hWMkrJZx2YYnL0NC3yGEyGHLbSPrD81ZxnDN+1yY0HGLbSuNi2UeKoL56y
         DgvSrkdPSIsXs2CpSDxqQvCwZeKoqVxoBiFY+HnL0U61194hrsqeNwM0NvPIVU7Y+Xn+
         KWMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PpBH+HvKJF/Y9opBrBZcuWNva56y2Q0ejPCkHHJF/ig=;
        b=yIJzO19P/5Swdo7Uod4OaW7Vcu9eA10+zQjbdFKRnL2qgikAKek4hkxNKTQOzCmcLe
         OxsAcR54GcDP5DBvIrTF5OS6191FXL6YTDHg1pmmgX5WGLZ+hH5L0NR0vROYWIslj2PG
         F4ONGAjui11uR7Fs3MLGe7tNbbLF01yKu1tzXm97g12cPT/URyLba2gouN+BjU2FYz6H
         LtO2sKzZd3xVMHjLsV1+4WI+Hk7nOPk77ldDP13d7NVJMbqNOl4G19FnWc+3YEE5SzmR
         NHCk3nNPGcxCnIguTC6/dgr3aqVsL6ad5LP4Ab+2RPdoJkeFYEiyl/vOZ/rvUcWVr7IB
         7SxQ==
X-Gm-Message-State: AFqh2kqTbZ3GTBrJKqd7pXzS7mBooiQlRL1lGQ0xRS9w/binuUFVQ4Fk
        4XQiDKWMXzCmNaViEt0i0br7qwOvzQw=
X-Google-Smtp-Source: AMrXdXu9gh3X3/ir6OfglNaqqCRkFb2O4MUTSBcHGGTUK+pBlbwSYql55/6gsdtJzZayvQ1XwVcZLQ==
X-Received: by 2002:a5d:66ce:0:b0:242:7c7a:7ee7 with SMTP id k14-20020a5d66ce000000b002427c7a7ee7mr1970197wrw.53.1671566643593;
        Tue, 20 Dec 2022 12:04:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ba18-20020a0560001c1200b002421ce6a275sm13669950wrb.114.2022.12.20.12.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 12:04:02 -0800 (PST)
Message-Id: <526ef7cc339e2832b71715869f08b32d8454d8a2.1671566641.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1406.v4.git.git.1671566641.gitgitgadget@gmail.com>
References: <pull.1406.v3.git.git.1671562845014.gitgitgadget@gmail.com>
        <pull.1406.v4.git.git.1671566641.gitgitgadget@gmail.com>
From:   "Seija Kijin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Dec 2022 20:04:00 +0000
Subject: [PATCH v4 1/2] win32: close handles of threads that have been joined
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

Signed-off-by: Seija Kijin <doremylover123@gmail.com>
---
 compat/win32/pthread.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/compat/win32/pthread.c b/compat/win32/pthread.c
index 2e7eead42cb..89e89c3fe00 100644
--- a/compat/win32/pthread.c
+++ b/compat/win32/pthread.c
@@ -42,10 +42,15 @@ int win32_pthread_join(pthread_t *thread, void **value_ptr)
 		case WAIT_OBJECT_0:
 			if (value_ptr)
 				*value_ptr = thread->arg;
+			/* detach the thread once the join succeeds */
+			CloseHandle(thread->handle);
 			return 0;
 		case WAIT_ABANDONED:
+			/* either thread is not joinable or another thread is
+			 * waiting on this, so do not detatch */
 			return EINVAL;
 		default:
+			/* the function failed, so do not detach */
 			return err_win_to_posix(GetLastError());
 	}
 }
-- 
gitgitgadget

