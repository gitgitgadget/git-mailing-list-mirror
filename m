Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93553C4332F
	for <git@archiver.kernel.org>; Sat, 31 Dec 2022 02:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236206AbiLaCU2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Dec 2022 21:20:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236202AbiLaCUZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Dec 2022 21:20:25 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7C413F62
        for <git@vger.kernel.org>; Fri, 30 Dec 2022 18:20:24 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id t15so12621091wro.9
        for <git@vger.kernel.org>; Fri, 30 Dec 2022 18:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DKOk6ZNsCWdk8jo+rwc4LxUwN6v70sLITJC36nH3p2Q=;
        b=N3T3q75E1iCKM1MDkHbQhW2KU4sd5yQY+nMGusQLOwdMOlT4OON+Jo4chkT95+Xwah
         HTC27fdSe+osNp9z931XDvdFTFmt0YrkzAxlj+0G4MZOkwjf7wA5a08T1js+55ksIvzV
         BRyrSE51LRueyixv3CExOjy/ME9TWvsr6P+4GfPyVW1dkduvRqsxepVzWu1M1pqvXcFh
         HbgGLhR9PHA/wRtp79oEAfcyBllSIKJ8Ue1C5Uwr+nLxR9n68tmHiOvHO/TCrRwwPAHP
         MLrqh0GZCA+iXOY7MoUNsHHXP1mZxkCwwfyCzJJd4elGYhlX3tI3I3FBiF2bvnaaogGt
         0ndw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DKOk6ZNsCWdk8jo+rwc4LxUwN6v70sLITJC36nH3p2Q=;
        b=yjBT+vADAi1/NXk8EXFPKwLzrQQZigRkQBM49xCABPwd69nvyh7OUf7F83kJzGtPR5
         bsguSaxbJCq5ulEl4vc9q77j7ry/CCjqoKP+A9TV42/ZU60ROU1Lqn2PporpWqItrqzC
         GmBdzJA3sKsztAz+M8Fr678cFOzsGX/B0L68NuT31NZQfmdxs5Xv8AeAu0HgrZyUtEKa
         ccyhYGaQLKaxLGvW5lB2CNmUt/2Rj7saafDZol/e7VdizvDJAoan1pA+VQVqfPrkg8lW
         zdNH4X7c7f7nATDs3SYZ5daEgU3EvLdtuFPjZ5Sd37ocNYIOHa9kI2LDTQDT4Pk6Fwo+
         zFKA==
X-Gm-Message-State: AFqh2kp4RZKxtIMj77QHh5c+/mnFQQTI6hatRob7D+V5z+jvD9Ux4znx
        NAZO+/FZISn5VgONCIIzlvS+vDzqrQo=
X-Google-Smtp-Source: AMrXdXts33ggtczhM/L1/Xlgre/3b7u2pwg9EDe513dsFSTI0Xjqo2jyC97hZTdBJ5yKVqGsRAEscQ==
X-Received: by 2002:a05:6000:ca:b0:27a:68f1:6bea with SMTP id q10-20020a05600000ca00b0027a68f16beamr8796690wrx.36.1672453222894;
        Fri, 30 Dec 2022 18:20:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t15-20020a5d534f000000b002365254ea42sm22094621wrv.1.2022.12.30.18.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 18:20:22 -0800 (PST)
Message-Id: <pull.1420.git.git.1672453222075.gitgitgadget@gmail.com>
From:   "Rose via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 31 Dec 2022 02:20:21 +0000
Subject: [PATCH] win32: remove return_0 inline function
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

The macro works on its own without the helper function

Signed-off-by: Seija Kijin <doremylover123@gmail.com>
---
    win32: remove return_0 inline function
    
    The macro works on its own without the helper function
    
    Signed-off-by: Seija Kijin doremylover123@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1420%2FAtariDreams%2Fcondition-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1420/AtariDreams/condition-v1
Pull-Request: https://github.com/git/git/pull/1420

 compat/win32/pthread.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/compat/win32/pthread.h b/compat/win32/pthread.h
index 737983d00ba..18aa2e1241d 100644
--- a/compat/win32/pthread.h
+++ b/compat/win32/pthread.h
@@ -18,10 +18,10 @@
  */
 #define pthread_mutex_t CRITICAL_SECTION
 
-static inline int return_0(int i) {
-	return 0;
+static inline int return_i(int i) {
+	return i;
 }
-#define pthread_mutex_init(a,b) return_0((InitializeCriticalSection((a)), 0))
+#define pthread_mutex_init(a,b) return_i((InitializeCriticalSection((a)), 0))
 #define pthread_mutex_destroy(a) DeleteCriticalSection((a))
 #define pthread_mutex_lock EnterCriticalSection
 #define pthread_mutex_unlock LeaveCriticalSection
@@ -36,7 +36,7 @@ typedef int pthread_mutexattr_t;
 
 #define pthread_cond_init(a,b) InitializeConditionVariable((a))
 #define pthread_cond_destroy(a) do {} while (0)
-#define pthread_cond_wait(a,b) return_0(SleepConditionVariableCS((a), (b), INFINITE))
+#define pthread_cond_wait(a,b) SleepConditionVariableCS((a), (b), INFINITE)
 #define pthread_cond_signal WakeConditionVariable
 #define pthread_cond_broadcast WakeAllConditionVariable
 

base-commit: 6bae53b138a1f38d8887f6b46d17661357a1468b
-- 
gitgitgadget
