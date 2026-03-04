Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68C73D3323
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 18:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772648136; cv=none; b=s7EDbJVFoJ0NpqBGjd3j2tyRelXjv4kG3aLh3uNQ6XIEUNgzlQTnx37eUA08I7yt1/BRTvTAhwxrWyolXQUHl6PZ4XdYo2WtwdGNincLi4Wrg9ayKeaYBfMPR+eeLpCdeEuhRHJTruJMpYOMq0G7hiqe9uo/2iP6KMoH95CTnKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772648136; c=relaxed/simple;
	bh=JQJPUnNlc88YOZjc+woeZHt0OERzy3a3Bt1KoYQ4zbU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=BjCsQ1mCfpXyQGS5xvOttUf6P528Ot5ivYpyzuw6m+IdbXtte5IoPEAh7Eo3TV+bkPw0zVQPbewcToylQt7uOHx1p3pMhMS3qf2tnPdFoGhtLpKzYk/QIyiQ3uNNTNZRGPDjGy4qjWluEEEDejVRBD1w4FVjXe1gYhYyrRfQugc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EvX8Zcfv; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EvX8Zcfv"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-126ea4e9694so2812835c88.1
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 10:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772648132; x=1773252932; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=utSML8XDRWikFjEf8OTnGhOa1Cm1oF1YFZw6B0GetW0=;
        b=EvX8Zcfv/ioLuCIUdwWJ0WatWNwP3Egw9Xk+N/WrFuId3XK3m6cW70Uuuqguu+Qg8l
         OU8MZQgziMUSwFiWKZxuhYg1SdVJCn9S6EPyH3ps/scee7TdWxRrSdDBAmgSHkTPdHNY
         eG490HreYknUajyQEyONo52V7RSO5aTv3sDS+6PzBBPgN7ACHbNOkBt7y2huA2IhbBnZ
         ZUz0uECXhKXx52lCru3jmdu6W/7XZM4cxxcDmZum6raHlLGCluN85FR3g3Ce8IJnrYDg
         qyXHZmaYZbBC3FAajaVjb2oCk+qmxPcMO54rXfncNMnbZxdyLfDrG2LZpa44lnzQGql2
         50jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772648132; x=1773252932;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=utSML8XDRWikFjEf8OTnGhOa1Cm1oF1YFZw6B0GetW0=;
        b=r4p9ViHTqsCJMBqZRurHQj/zoabuJn9l8FMn+R6DkX1iPXJ2P/HohAjfobNIadgigg
         d1pGXlLUfoLR6UVDueAFnm9fw1eSNFtGHeezkcx0TnCq74zgGkjGvnlzHr6cAl4folHL
         75kzqwLqsytUh0HeyJZWHVboF3WlD4G2Ibj0lGvpA4ajT7cxapirU94ANAnLMjHts32W
         mLbglw2NCtVCocjLeJ+aJIGfmFSkihLnbOJY0t7yr9NDqOtoULN68YXh9UPzGaDHkxT3
         CR+Xj6MnGO6mOjeeA/s1aQ5oMOOVJCsm+mTMdOhAFu4vYyK70Z57QqMoVk1/M5vG4vmV
         v7BA==
X-Gm-Message-State: AOJu0YyhWmPbkF6cjKYzcsG9CuMyqbVtyTk+8/QvAO8nZ2WBv/z6eZb/
	GizMNxXqbAvkqHd5iYexVcxl4Ox+lLENc/vQBiiQWn4n6NXcYUqsU9aKIehyPDb7
X-Gm-Gg: ATEYQzwiPJyDh4YKnX5lNTiIlh5/azocD2eNEwgbUGiceWa5QWtlP5g8HXJLAbwxSPW
	P574q3QDd6dTDRZIv4fwuNrBRMu/AMzBVxzK9y7nNekpb/aIPfr/OuH8WZXpEcD5oliLiyw6OFm
	1YGJzCT9JRtEjHw//FoFxUa3/VXAqdgoneMyPTBfrEn7IuluIvVejANPvVHEssj42nCNChPqMbU
	B+RkhDg01CcBjy0bqSl8DW97iMQlhS3MpuhGwwOyc320UyRFVtxhlVNfslb1JFTAUW8nzAgqgI/
	7S8ObAPlw3tcNCstfXk0vlJDeHk6ybeeqcJ73TiRxTw4CVixPpFwP7DOyu2Ey4yxyEI5UwfyITN
	Bnkl6MFtvkHQc9a6kMiiS7aLDax6LTGQawL31PPIJMrNcW06baFgZ0WSpa0xerPrpEcZO36cPU7
	8tWh6rpLg4PvdLS771r0hi7TM0Qg==
X-Received: by 2002:a05:7022:324:b0:123:2dd0:10bc with SMTP id a92af1059eb24-128b708553amr1385301c88.10.1772648132023;
        Wed, 04 Mar 2026 10:15:32 -0800 (PST)
Received: from [127.0.0.1] ([57.154.172.168])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128bac04455sm309087c88.1.2026.03.04.10.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 10:15:31 -0800 (PST)
Message-Id: <44a063074dadc27110e2dd3481756c8c324ed956.1772648125.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v8.git.git.1772648125.gitgitgadget@gmail.com>
References: <pull.2147.v7.git.git.1772065643.gitgitgadget@gmail.com>
	<pull.2147.v8.git.git.1772648125.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 04 Mar 2026 18:15:16 +0000
Subject: [PATCH v8 03/12] compat/win32: add pthread_cond_timedwait
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

