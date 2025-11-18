Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBFA366568
	for <git@vger.kernel.org>; Tue, 18 Nov 2025 15:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763480724; cv=none; b=jv5jxo8BzRMm1FcQGwfnefaPUw+uq/0Pve5u7OK4u9M+vOieBdvxsuo4NY2w83GPe0rNfVFxhQ1FypWUWfxLiXLOCGNLbWQGtZo4UGVmm3IeJb821j9iArx7UMb4xzzrqPe8EeR6xsIrYaguP1tVzKUPZn3Ls7X64WpioeDxc+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763480724; c=relaxed/simple;
	bh=a+Z0+uTSYxGrwtPqADq26yjzq+DQHFOpEHVrLTIc5wU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=jCYzxjDbTiHOsTOi09XZ/ODtXdibhl7Xn7qzt6e+s2DC+zOQ5BjwqXLiseN/PQMbJoq2Tm010GTLuRD2hSHdbFZAhTXeTlI0J/fn1/IS3Ba+9iayHnolNfw5eJawgZZBXFPYvEjnXdBXTcqZ7jc4zjUMwboADs8sw53/XX07eGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kk0pHe4L; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kk0pHe4L"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-882451b353fso38236006d6.1
        for <git@vger.kernel.org>; Tue, 18 Nov 2025 07:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763480721; x=1764085521; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8z29RCZuf9G2mn8KT8W4v1TY3wrTOl9JCV431YXkc1E=;
        b=kk0pHe4LJDmws3q6Lroa7YDjec08FlkAw4hecyP2gTiqd3QPvdqM/4doXfVvB3LV0x
         ETt41k3y1s7LKSuTCacx41TXdOIAF3ILkOUVQaxC0W1kj9HrbAwPKczgKtt2TXQ3ESOp
         H++BYoQ/AN4lZDqs5WUqDP2M3lnqpGxqclBYjAWVprkPp+T2hXp26xYpEK4z/JVkFDkR
         hxxZ9KRkVdCLk9NuHXUXMpAgo0Ax1FErojYyZMd/vGknt36h3Vlf3oTXH7k18F39hp16
         zCKDB4UFnWFMr1914DlSt4/NVui5agAVWJGJpr/xFw3/GZTfnrObgaRDZ5BIzAd1Keh0
         t+SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763480721; x=1764085521;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8z29RCZuf9G2mn8KT8W4v1TY3wrTOl9JCV431YXkc1E=;
        b=jMNigm+y6rT/qYosQi1q8CaqxP1iYBfjg4B5Z1DUcXQEge3qymn7bA9TyGRA9hP7C2
         GB8jMzhVMGbe5Tbj/UqSC4nipfRhrwyRveWK5/FUxpV5fyxdOEevrsf2vo7x6Nnl+kx9
         CtC5ZZ5OWmkweRfq8RHre29N6j8BzOznUHhoqWftWPSO1stpQS88RztcWrZfECwDneXK
         o2k30jSNqc205U9R+R9FbKAMaQ2U5RJRPVCIBxHGGajX2V3nTyJjJN5KW04L2uBKNqNO
         +lDVr3dnEkmVPiJo9oobA0mJdljEJhDwfgs5+PjLtuR7HKQ55IklQysoemO1okjGBxyK
         kn7Q==
X-Gm-Message-State: AOJu0YxDulRVo+/USiyVGPK7nfzbS6V9k/2ttwA2R6orHQdny8TkrBKb
	pWVm5g/7Ep4Tpb35KAEMx6YKIPCUgjdVULoGeejHnGPLENkQ0ioop+5brFeAxw==
X-Gm-Gg: ASbGncvaQ3osqyBlxGCcFrbGLdMpjgU80arHtpNIE7SInrriJA+6Bn8gL7NzWTLaYmG
	R6SGVpCM/AXL5MJTZ9d/eizJI6Q/sXG+n8P+jR27Ncwevtaoub7xAuJlY7yDUDqULCF74HDoM1R
	A0HwQBGlMlTMtfy6W8FzvmjAyQf+ohkUDzLvi80524DWcEnskBYpQzS326MLn3tSHiZ7lb+pr5p
	6XQVtxS1wzFvATFbWH3g6YAkF+eIIQqFeDJpRJsmagVpAsrzU/SB0XRFXiWwzCT2QMSxL3Ik+Ef
	R5ZYa4lR2IhA3fJXfaUbyS3VCKg1TfhahrVpFJTgffrUzmKZyFgr0HwjsaREWXra7BESAQmSOi5
	kXKEUZWMm1wFikUziE62qG6DMvfwdwA3I8HQmVjAfTnE/NOoubGpxIDtlU4wSAJ6NyPSliT8k0/
	It1eo=
X-Google-Smtp-Source: AGHT+IHnbdDh3+yQp8Lr8GT7XVeQ5yuH5c/ict3DficBS4Oc1V6Ba5ALIiHlrKJayGT62qneN8Kvmw==
X-Received: by 2002:ad4:5765:0:b0:882:3ecd:20ec with SMTP id 6a1803df08f44-8829270c402mr225163116d6.60.1763480721260;
        Tue, 18 Nov 2025 07:45:21 -0800 (PST)
Received: from [127.0.0.1] ([135.119.239.56])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8828652d94fsm115301286d6.38.2025.11.18.07.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 07:45:20 -0800 (PST)
Message-Id: <pull.2102.v2.git.git.1763480720264.gitgitgadget@gmail.com>
In-Reply-To: <pull.2102.git.git.1763427606138.gitgitgadget@gmail.com>
References: <pull.2102.git.git.1763427606138.gitgitgadget@gmail.com>
From: "AZero13 via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 18 Nov 2025 15:45:20 +0000
Subject: [PATCH v2] win32: remove handling for impossible cases in
 win32_pthread_join
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: AZero13 <gfunni234@gmail.com>,
    Greg Funni <gfunni234@gmail.com>

From: Greg Funni <gfunni234@gmail.com>

WAIT_FAILED is the only real possible error here.

WAIT_TIMEOUT would not be returned as the INFINITE
is given to the call.

WAIT_ABANDONED would be returned if the handle
pointed to a mutex object that was not released
by the thread that owned the mutex object before
the owning thread terminated.

WAIT_IO_COMPLETION would not be returned because
we pass FALSE so the wait is not alertable.

Signed-off-by: Greg Funni <gfunni234@gmail.com>
---
    win32: remove handling for impossible cases in win32_pthread_join
    
    WAIT_FAILED is the only real possible error here.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2102%2FAZero13%2Fpatch-1-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2102/AZero13/patch-1-v2
Pull-Request: https://github.com/git/git/pull/2102

Range-diff vs v1:

 1:  73fae07514 ! 1:  e0d6b15093 win32: remove handling for impossible cases in win32_pthread_join
     @@
       ## Metadata ##
     -Author: AZero13 <gfunni234@gmail.com>
     +Author: Greg Funni <gfunni234@gmail.com>
      
       ## Commit message ##
          win32: remove handling for impossible cases in win32_pthread_join
      
          WAIT_FAILED is the only real possible error here.
      
     +    WAIT_TIMEOUT would not be returned as the INFINITE
     +    is given to the call.
     +
     +    WAIT_ABANDONED would be returned if the handle
     +    pointed to a mutex object that was not released
     +    by the thread that owned the mutex object before
     +    the owning thread terminated.
     +
     +    WAIT_IO_COMPLETION would not be returned because
     +    we pass FALSE so the wait is not alertable.
     +
          Signed-off-by: Greg Funni <gfunni234@gmail.com>
      
       ## compat/win32/pthread.c ##


 compat/win32/pthread.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/compat/win32/pthread.c b/compat/win32/pthread.c
index 58980a529c..54c43b4146 100644
--- a/compat/win32/pthread.c
+++ b/compat/win32/pthread.c
@@ -37,20 +37,14 @@ int pthread_create(pthread_t *thread, const void *attr UNUSED,
 
 int win32_pthread_join(pthread_t *thread, void **value_ptr)
 {
-	DWORD result = WaitForSingleObject(thread->handle, INFINITE);
-	switch (result) {
-	case WAIT_OBJECT_0:
-		if (value_ptr)
-			*value_ptr = thread->arg;
-		CloseHandle(thread->handle);
-		return 0;
-	case WAIT_ABANDONED:
-		CloseHandle(thread->handle);
-		return EINVAL;
-	default:
-		/* the wait failed, so do not detach */
+	if (WaitForSingleObjectEx(thread->handle, INFINITE, FALSE) == WAIT_FAILED)
 		return err_win_to_posix(GetLastError());
-	}
+
+	if (value_ptr)
+		*value_ptr = thread->arg;
+
+	CloseHandle(thread->handle);
+	return 0;
 }
 
 pthread_t pthread_self(void)

base-commit: 9a2fb147f2c61d0cab52c883e7e26f5b7948e3ed
-- 
gitgitgadget
