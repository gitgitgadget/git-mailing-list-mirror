Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B1D36655B
	for <git@vger.kernel.org>; Tue, 18 Nov 2025 15:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763480859; cv=none; b=iJFFYXFNe/L5D+FIBphut7rI9xSssxJKOwNZ6LiqrQf+irnMmwuYox90dPxKMWLMvNsdywE5pB4npdwNzNf5kkg1Or54IwxcLhUN8PYvX2lqjDv+z+DbuUCiJ+Fu39aF0Mz4VpR3hLVE03vg7PizXtu0h9p8awXP7AU0gTnXy6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763480859; c=relaxed/simple;
	bh=sAwoUYKuN9oOYKkwQhlEXiYbtfhVwhAWUmIVqojB+EI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=nnRscWcqw9DuwZ28WcJWKaRgfABn1NYL1OEZMi6jmdxcXQdXfTAd9iW/xlPBIcmAKY9o11yWYaV7zV3Q53mMHF8MOzNSz/Hnk+FT7lYzVSj8UU93Lkjs4Xsu20UVy0uB/7VkFTTcDHOaj36dXn7QD03r7+U5A6Wjjkrl5TdxSPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fLfRL43X; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fLfRL43X"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8b2d7c38352so345423285a.0
        for <git@vger.kernel.org>; Tue, 18 Nov 2025 07:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763480856; x=1764085656; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9E0MqbqV+QttaJ8XzXoFcmsbNXmIwqyi1/XUDHUkwOE=;
        b=fLfRL43XhpZZ2fQki57W5BxHaD2DIcSWYkBoJgLtp1HMwW3NTDNI9w/6DYJsjkgHbe
         VcNMX40nXSZOtzqbO3PkNcc/frCs8R8b/jrux62g+PUD05KXmwEvokwZhrsFD6yuEJ37
         5ME8yY+g8FGK4Pf1sWXL/Na3Ba36jf9Y4oBBkyGhZg0/Rk+Q0MIldShPGAXgdkmTfCWs
         YDHa1RkHGQWwM1KUi29iInV/oC+Ovblx4ewtNrDBZmgUmVG03GHkePMhpX9aam7noHz7
         s2k+rVDqmhTLitH3klsFfrSo/bbZVzgcffuSPYy9dp435XV0VerkIj0CA3Vo6bVHuRWA
         zr3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763480856; x=1764085656;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9E0MqbqV+QttaJ8XzXoFcmsbNXmIwqyi1/XUDHUkwOE=;
        b=Vs6NLDsa+PuT2mpfPesluvgbJrnnrRCkjl1CN6k1qBLmDvmVymSFEyhbeFLPkooS7o
         sLHymdy9BI8hO9n/Wyi9KBjsJgjHyS62Ytc87IOFZxkNE46U2bC/ndEznhmdgXW5cFV5
         0qzZsGVuvSaRcxVr/YtmAyO/xZnnY1fi9QFYO4TLPDbiS3JUYjncEsfKKWg2QPaM3v6N
         xnzfMhbfyu8nHoVBdTCYJerE31Thbzu0Q8D9yAv7nlP0IrfesTsLCflVd7aNHDyvTQqn
         0T6QP6DsvlEHv7BJs0gqOqPdXl1mTf3U4qqUBG8sQ/IhfDtN4cOWbdOrNwdkZEaugR1m
         iI/Q==
X-Gm-Message-State: AOJu0YxTw4smXBYG1Ygh82D1VhONKmEZP7JLG2EQvzr4twIqIRwUaO7L
	VvmRkNGF/rs7elKPjSyrMxleh+kajvTI224mUW5Ldy3uLCy98oJOmq2CP8Y4Dw==
X-Gm-Gg: ASbGncvV31FMoQg5fakVYyjAscMQIs/BwOZ0i6CR4op7nde0RGSUkMFwlVL+O66m7tY
	ocYaZ/Soa96YML9shDMoTzDKxgyBi7VD6Kw4vPVBXaYjWOUWpP783COVTVCB8Vx6B4aSIuI3AM6
	IxLb7YBQi73fnVmjpJpHbfSB6pFGonr3J8dNnH+xA+uOlQeqQ7ga889kaPKO+Srq1EoXFgBTc1W
	TvjJeVe25n8OtmiMtjvuMzqhHuMDJaajHGGQ6SoG3fRtPs8ElgfvyyAHajrSmJxdKjuRuylBliz
	dxEnRdHTS4Dbbp+Y/ZqHHzA0p/yGvFVetu2omDjAH5I55cWYdkrv2FwqNfvy1qJANtqd0WraAnW
	D5T0mKdgvj6YvvyYgv1tMhHz8DaEfaMgBBTD/C3ViCPDZ+eoYLDyma2PHyVDkPuDj/zh7V6PZ0r
	M7G+aMpyQPe9QukOI=
X-Google-Smtp-Source: AGHT+IGkKAdLqBjAuwZrHwfMkT5XP+T0VawRu0vKzxO9KXxYtxVivQyo2VV+MJiLxaGvNTbeXcLsTg==
X-Received: by 2002:a05:620a:2688:b0:828:804a:47f2 with SMTP id af79cd13be357-8b300ea7d3amr457584985a.9.1763480855915;
        Tue, 18 Nov 2025 07:47:35 -0800 (PST)
Received: from [127.0.0.1] ([145.132.101.187])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2aeeb1487sm1219085885a.19.2025.11.18.07.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 07:47:34 -0800 (PST)
Message-Id: <pull.2102.v3.git.git.1763480854213.gitgitgadget@gmail.com>
In-Reply-To: <pull.2102.v2.git.git.1763480720264.gitgitgadget@gmail.com>
References: <pull.2102.v2.git.git.1763480720264.gitgitgadget@gmail.com>
From: "AZero13 via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 18 Nov 2025 15:47:34 +0000
Subject: [PATCH v3] win32: remove handling for impossible cases in
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2102%2FAZero13%2Fpatch-1-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2102/AZero13/patch-1-v3
Pull-Request: https://github.com/git/git/pull/2102

Range-diff vs v2:

 1:  e0d6b15093 = 1:  20f943570f win32: remove handling for impossible cases in win32_pthread_join


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
