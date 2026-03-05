Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE322264AB
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 00:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772671929; cv=none; b=NYhGvUVdyz3+xVjiGPiE38SuhPlzvcp861KHiUw2gkORfzOaCimtZp03r6igPFjJTXvIqguxP45dr3CCioS+b1nvJ5JDlj1rwKsWnuxv6CK9SRYnCsnMmih5h4i6V0PNySohYnAio6r0669+tBeK1ojI/a99u1/V+CO9y0wWp/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772671929; c=relaxed/simple;
	bh=JQJPUnNlc88YOZjc+woeZHt0OERzy3a3Bt1KoYQ4zbU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=jBueU6ANzxNFdSjxxiyOcWhLWc3agxsuR4hNvNYjTqxLJiDPjymWNCz0M4e1vJVYq/nPaw+wEbWd3YU5uq050ngpSIq8IEsPAB24KTTJTVnBfCYmRBFd8BLoMrjyNYjyD4tGkgVvYwe3hOO+ShbpQQIDcFjxqdV506JvpM/59tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dmv9IcS1; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmv9IcS1"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-126ea4e9694so3564408c88.1
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 16:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772671927; x=1773276727; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=utSML8XDRWikFjEf8OTnGhOa1Cm1oF1YFZw6B0GetW0=;
        b=dmv9IcS1y3kmVtIyr/dZfdGojsy4nzswCfK4v9j6cZ9ezJwchNl6NeSdIrChpgvR7Q
         +/VyRvE0JE5M0FUIaJoT4mtdonUdw8RjfuHMT+K/ZXuBrIT/E4BMeKxnZbBtlhgODn6p
         pYTpoXTlQQZ5hDWp6sF/J7TkDZZ5qbbj8ey1ts4e4dcvaaQrVZzP1LW6DX6wShcxZWO0
         1kUJSNKDrf6Fz5eJI+l76Zi4d7aGn0VIpJoeBrh+4/XCgCty4Xe5SkxCCCTJfV4qG1Wr
         8TE3ywRFvn3w6vXSSwcKj7hhRxsfnRv8JKuQh+ALcOKKC1oWV/tv2pTnB0wpZ3EjgQ2z
         Z7uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772671927; x=1773276727;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=utSML8XDRWikFjEf8OTnGhOa1Cm1oF1YFZw6B0GetW0=;
        b=w11Ar5m8AI6xh6ORd2Nlz7tnX8mbxe+11SU0oX4LTgmSpnkVx5eFsKTi5K06IuPybJ
         EcRF0bmMhayGV5z+8n8w5daGEp369GwvHF0tmG8p+Y4K7UQCYdhnEq0W8iEF8RZAtjRn
         Xr3wyaLSNw5vMWJlL2YJx3wJYRqZYeESs9MEqEUMtUsXl8vqWROgE2Rq4VsUY4NN8zIw
         iDY+1fQnUQlVhNI0lsHEMOITn7yz51cHPdRTx8uiQ3inoIXjnBKWRI8J2zyleazNp4Ib
         2ExaAl3UfiJV5KBCqTO/oIm14LOLGIUWAuUC5/CuApv73eGM1xsZFsqh+0pN2mdb87MP
         /zsg==
X-Gm-Message-State: AOJu0YxXn7TnDIyI5lns4VfiVsmENNokmg1TS+GRNfqmw/pe8boFgn9l
	/BMgsSu+hQWHGpQA3E0bTvBcjUCbhyNjltvbieXX2Ki+PBTIxtVVDdLVkZNvBA==
X-Gm-Gg: ATEYQzxIhuX6TEyuWilJbJdYQIAdXMog7ISAikXByqBYop7ZYrGnTT1TwLRagH/WBYi
	W5CGlXUpfbRaf4wWR2TSbIkisz2J6P3UziurhTQrvaxOjMBWDnSFE1pChwuG7G3XID4u8XA5PT4
	LZQKs3kDLiGmW4ZB/q5O/KNVQvG7BGtxU1eAYWF8+uwBTNcyk1kh1rLp2nfjJw+ugwOXvo8geCO
	Urix5/LR/9wwrcGoYf5RF1vxKIP+CAkE9ObkSpwl6JtIT/Mk+5mUmkujf0WIuBtbGKbk4/v1kcv
	RP7WuQ/qIEsnvmL6ypQ1yakSE69z78kk0t8q8lhta0KiiDUqhfdC9aMPpn5UD0X//Qfl4DaTudt
	t+cS0gdT+REZssm4uRwx3X4PEvm23DBktBxDx0mbURzspOqjj+jJk8oguIj0XdgV+KmkGDOkvRS
	flapho6MtMIECLuK10Ri1p6rJA
X-Received: by 2002:a05:7022:6ba8:b0:119:e56b:958c with SMTP id a92af1059eb24-128b7093605mr1747221c88.17.1772671927105;
        Wed, 04 Mar 2026 16:52:07 -0800 (PST)
Received: from [127.0.0.1] ([68.220.62.148])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-127899d49ccsm23565828c88.3.2026.03.04.16.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 16:52:06 -0800 (PST)
Message-Id: <44a063074dadc27110e2dd3481756c8c324ed956.1772671920.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v9.git.git.1772671920.gitgitgadget@gmail.com>
References: <pull.2147.v8.git.git.1772648125.gitgitgadget@gmail.com>
	<pull.2147.v9.git.git.1772671920.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 05 Mar 2026 00:51:51 +0000
Subject: [PATCH v9 03/12] compat/win32: add pthread_cond_timedwait
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Paul Tarjan <paul@paultarjan.com>,
    Paul Tarjan <github@paulisageek.com>,
    Paul Tarjan <github@paulisageek.com>

From: Paul Tarjan <github@paulisageek.com>

Add a pthread_cond_timedwait() implementation to the Windows pthread
compatibility layer using SleepConditionVariableCS() with a millisecond
timeout computed from the absolute deadline.

Signed-off-by: Paul Tarjan <github@paulisageek.com>
---
 compat/win32/pthread.c | 26 ++++++++++++++++++++++++++
 compat/win32/pthread.h |  2 ++
 2 files changed, 28 insertions(+)

diff --git a/compat/win32/pthread.c b/compat/win32/pthread.c
index 7e93146963..398caa9602 100644
--- a/compat/win32/pthread.c
+++ b/compat/win32/pthread.c
@@ -66,3 +66,29 @@ int pthread_cond_wait(pthread_cond_t *cond, pthread_mutex_t *mutex)
 		return err_win_to_posix(GetLastError());
 	return 0;
 }
+
+int pthread_cond_timedwait(pthread_cond_t *cond, pthread_mutex_t *mutex,
+			   const struct timespec *abstime)
+{
+	struct timeval now;
+	long long now_ms, deadline_ms;
+	DWORD timeout_ms;
+
+	gettimeofday(&now, NULL);
+	now_ms = (long long)now.tv_sec * 1000 + now.tv_usec / 1000;
+	deadline_ms = (long long)abstime->tv_sec * 1000 +
+		      abstime->tv_nsec / 1000000;
+
+	if (deadline_ms <= now_ms)
+		return ETIMEDOUT;
+	else
+		timeout_ms = (DWORD)(deadline_ms - now_ms);
+
+	if (SleepConditionVariableCS(cond, mutex, timeout_ms) == 0) {
+		DWORD err = GetLastError();
+		if (err == ERROR_TIMEOUT)
+			return ETIMEDOUT;
+		return err_win_to_posix(err);
+	}
+	return 0;
+}
diff --git a/compat/win32/pthread.h b/compat/win32/pthread.h
index ccacc5a53b..d80df8d12a 100644
--- a/compat/win32/pthread.h
+++ b/compat/win32/pthread.h
@@ -64,6 +64,8 @@ int win32_pthread_join(pthread_t *thread, void **value_ptr);
 pthread_t pthread_self(void);
 
 int pthread_cond_wait(pthread_cond_t *cond, pthread_mutex_t *mutex);
+int pthread_cond_timedwait(pthread_cond_t *cond, pthread_mutex_t *mutex,
+			   const struct timespec *abstime);
 
 static inline void NORETURN pthread_exit(void *ret)
 {
-- 
gitgitgadget

