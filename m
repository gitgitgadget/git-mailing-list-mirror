Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D28C2E22BD
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 04:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775710784; cv=none; b=PGyedjzim9EvbOemquU83fmqsyIVNbtIVNyz/9lf4aUaAh/auiiGq8UgNZO3KBub18TZulV8HbYtxBkpDTd48bysG/N+3+ZyVHYDRjTisNBh4+dej5iEHaP/F4InxlFpC72VV9MiAWBhp30PPCtyUzy+tAnZgesceGgH2XSDrEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775710784; c=relaxed/simple;
	bh=JQJPUnNlc88YOZjc+woeZHt0OERzy3a3Bt1KoYQ4zbU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Mt9Kar+Ja9WeQ6vQjFIkb4h4BnlSnAl5Z52QYljZ1kXDjx2+CKYDm7facbRt9i0DIhpT8q2Fd3UlT5pm72ULpDdO/s9nGvjyyAX82SVZwJRJZFK5caRM9TCpl0Ip12t5R+X6zx1hIGjWaX/W6kJ8uXHS0k4IMTaE7970JCgErzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K5n0l3aq; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5n0l3aq"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8cfc3ca1922so35127785a.1
        for <git@vger.kernel.org>; Wed, 08 Apr 2026 21:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775710782; x=1776315582; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=utSML8XDRWikFjEf8OTnGhOa1Cm1oF1YFZw6B0GetW0=;
        b=K5n0l3aqin+LwjVsvO6YWxbKZ2taZ3aDu+v6ctokr5+uX7bVfBfSgzIofaTR8vM+5w
         /7t4CrN0nUytlRN234PFCd4LetdCspBj+sVJmvYGf8Q08QGYRxpbpMQ7bvchmlp8ap72
         IqcMn6hXjGikarZsssARtsw9lxxqFUDSW+XAwZpcS5UykgipB4MBnFuaOei2B/FzmWVp
         3RE3UQ9Kp9zkVfBHtmEWm50O22RL19aXqrnYLH9Tgw7bdx4O+PQDPssHfMumJ7ercyQj
         dfBdK0hSxhpfp1Tz7WErllBF/cDzbMbFgZDWUgq4ypOuPT+0ULky51gJX3hgIzbQG2iO
         gmvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775710782; x=1776315582;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=utSML8XDRWikFjEf8OTnGhOa1Cm1oF1YFZw6B0GetW0=;
        b=g42WyUWlA7oyD6VF4aUdiuHHWcjM9I/j4tFqeflu76mtMNXzicSuxTvN8A+aFTp0Ff
         sIHNsPWjfSQAhFtIqjMFtynGi9ZOz3n3Eo03lAS4Bce7/DKzjwxa+SVuy34ADr1N4P69
         w6+pFIIc6AU7CajkHgi+sy/sNiIVAk9mCXIP+07STVOSntmu87QGnR0ahBl0sODV9nzM
         6E6uwqB7q0QTIewwXMNfQndNirL3dBZaGA29ykPH6mCYgLO2PgzEWjliVVKPBNklulED
         /6ihPdt3w4Fkmm9IS9ju3EuBgS4L6AcWnhmUnouJ5t2OxysbOxEfrMmfd4aPfbA5RWDf
         G64Q==
X-Gm-Message-State: AOJu0Ywf6X7mcxdJFwGLQb0S4wmREPSoOhsmZMkCBimMBlI3mVQt/78P
	UrJGa82A07+L3tn0S9IUwU/Xy77mn36VgTdxJZkYevB1Is2IDDEEbFXuGbebEA==
X-Gm-Gg: AeBDieusIyqQjPuoQsaRBtkk5ZAN3MzoBnWI0WOkOYhRIBVlAOXdaPwnyZpENWJtGtl
	8URynrLcd9hL1h9X3c4aF598ffZ9x/kFjIRDiHKaUx/LlSw+rK2iW/Qx1MHBIFXPBT+q/UfDfNz
	X+NpLYXPrS8IXOhCesGmC9th9aSzDKuevtbfwuKPbzEw1TDCpmH74gaiYU/5sv+bznHDJ+aM1vH
	t37Wu9eEaWvOqoiJW//1KiJqlui4m5vNtjcOaupEf1+LxSViDSLZPhZXiP28AiEnN1GEuJSOzVp
	BI+ZrOsh3uJby9ZQ+GlB5R3AhmBZs1tWhhfgxEFlpX7b/Lbckjx7ETN/pYfPyIjsunIL63WSmzd
	Juhp0eS9i+LpQ5jJU5rTGJjNDVJMqRkyfoJirYR8Mw+ZYAW0+XF27VQ0VhMb6ouL9RGMu60krzz
	jt7rAox2yDjLG0dWN8WjCjOcFeVp0=
X-Received: by 2002:ad4:5dc3:0:b0:8a0:7ce5:2696 with SMTP id 6a1803df08f44-8ac745b888emr30832186d6.16.1775710782209;
        Wed, 08 Apr 2026 21:59:42 -0700 (PDT)
Received: from [127.0.0.1] ([172.172.153.36])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a593bf2769sm186046856d6.14.2026.04.08.21.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 21:59:41 -0700 (PDT)
Message-Id: <a0d430c2f46b598f21943cd0ba846f29d6b3c3d6.1775710775.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v14.git.git.1775710775.gitgitgadget@gmail.com>
References: <pull.2147.v13.git.git.1775498098.gitgitgadget@gmail.com>
	<pull.2147.v14.git.git.1775710775.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 09 Apr 2026 04:59:26 +0000
Subject: [PATCH v14 04/13] compat/win32: add pthread_cond_timedwait
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

