Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4399523AE62
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 00:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772065655; cv=none; b=UWxdtjRXU/Sd2HKcnlc9vTnW4GeAx22d2V6P8vPoB9xdubhTFZXRb8WH86JUEH/86NfO/QY24yzzhJWj+j2kpeHzYDdLsXECAIrLqGELx57XWX+jC2EdU9ASCxGDEnjOMdrB0kXH+UYqrJm/c5QTg95+MpOkkjq4mQScux94WaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772065655; c=relaxed/simple;
	bh=kNFC8EE1UFnLlKwIAfGGN5ofkrxe4wu+wOxhxyMvmik=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Z4kukfzQL93pxNmqtSS6B28W2vHhMx7+770VRDe+DfYCVHVAYjs+oVrTcGD2xeueAOZkaRsXOVJRR3rJnRZ9eT613o492PMV4P7bGKmhQ9zr7gGg8SCajiLJw3x2mXp6dRf1mdRcyb1pqcJsHtodGlfQiFcSw4hdyBljHF1MkJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BLjbxTMR; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BLjbxTMR"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2b4520f6b32so346117eec.0
        for <git@vger.kernel.org>; Wed, 25 Feb 2026 16:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772065653; x=1772670453; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+TjjV9P6Xuf3j3ghwgMhIPyhncvi97Q2Ji7+AqPh5wk=;
        b=BLjbxTMRVbwBkBIBQEfnW8dj1UjTFTgBjR9sujERKGwaY5R58kuTJVY5qp3YR1xXrJ
         F/61TWuA0XstATXf/KK+mpxF0IIO3SZVVA79Ho2obnKYPHe1TfcnRm7YIpSBSWo4hKX5
         8ktf4B61mDp4yNnqWUtBNfkr9JoVaII3UGN6O0nm1YANZUfuvl8ZZy7C6vD0GCBXw1nA
         l+kr4udcA//cEJVVkYBbJkCtnMhkY4aroasSi992wcrs94Zhof1ceKtiS1Qfwc6C992d
         loAby+7Ro6fvhZBT7cFYFHVdQtFO5jxDJQoiAeVaHMKIkLdh3VcgO+LaPpXQasgmMzm9
         wzDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772065653; x=1772670453;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+TjjV9P6Xuf3j3ghwgMhIPyhncvi97Q2Ji7+AqPh5wk=;
        b=w/43bhSoquL5do6js1X7TC3rPcj4K3DmyRNM2xN2h0iiQypUoJ7LBsK/PpdAL+YpDJ
         B0kPsfiRlarncrzmeMm+53XmwsMGWVdhmXDRGXATfAiMoFB29Th/MUbBkD3u2nOQgaIU
         2VgsZLs75BJWnGUvWNMPpZowtIqMg8nT3pjMCE2VAVpHNkM9WWWIs+Ol42N0V+vLub74
         7a0vOzU5DKJbO367A6q7kryd2CMpRd+tYiKlHg88Y6aAupBNCE4vsQMWZBQ4edssLOoH
         JryXCvUmEKCeK82MkSAjTl51J+pxP10v8Mx+O7ebfemlIox1mxgsLhDcmPz69rpTZ62D
         o2Pg==
X-Gm-Message-State: AOJu0Yx9pYKyUIaUsjJIvuqtvIpDAZBtvT6VGPsxhsZuzZPoUi0v46/4
	3AN4HbFS5xKvrwGgeEmoBR2HpQTYfw8LvAAw4NPGEQu673FUvghyUe7J3XXtiJr1
X-Gm-Gg: ATEYQzxmRJVscPYIzne8u5ugL+bfmu6RJEkI0BmR82gmJWjUixDOSps78ddF3woNtA6
	q79MXnd1CYi8YFedURyPAJ+73yRbg/5s0o8AgSteO3WTJ+uIgpakEHrcZeGVDBgxqd7vS+B1qCs
	foofmzuhwCb9zszUlVgfZ9nFWc4p9D/k2NTcgsdg92pCmoG49jnCs4JPUyVAY72iw7KLbq26b7b
	l9OzR/tMd1ulfvwUevjhb2+I82xCPmOzcUUMiMevSlPtSS2DawPFlPj5+dZPjq8bdCCzLG+XGOH
	Uv6l9mMpnjlytWKo0SVcFn7Q4lwv4wVQzX2Suk6gzLMRPSeiZYqrAMISjDErIib+g6XNdLZU4f2
	in/OzF4udv1ewZ4JhCVN15J2mFptfbpCJONqVhTlykeJHA4OZnpXmrGgsNR10dbUqPqei57RFrd
	NhRGhaafYPhQOCZiJ/5AeszdsWiw==
X-Received: by 2002:a05:7300:641f:b0:2ba:858b:3751 with SMTP id 5a478bee46e88-2bdd2ef8490mr197748eec.3.1772065652942;
        Wed, 25 Feb 2026 16:27:32 -0800 (PST)
Received: from [127.0.0.1] ([52.159.229.150])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdd1f48c77sm603411eec.26.2026.02.25.16.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 16:27:32 -0800 (PST)
Message-Id: <0a586709524f36c189cc32159b643a49abdbd51c.1772065643.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v7.git.git.1772065643.gitgitgadget@gmail.com>
References: <pull.2147.v6.git.git.1772050636.gitgitgadget@gmail.com>
	<pull.2147.v7.git.git.1772065643.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 26 Feb 2026 00:27:17 +0000
Subject: [PATCH v7 04/10] fsmonitor: use pthread_cond_timedwait for cookie
 wait
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
    Paul Tarjan <github@paulisageek.com>,
    Paul Tarjan <github@paulisageek.com>

From: Paul Tarjan <github@paulisageek.com>

The cookie wait in with_lock__wait_for_cookie() uses an infinite
pthread_cond_wait() loop.  The existing comment notes the desire
to switch to pthread_cond_timedwait(), but the routine was not
available in git thread-utils.

On certain container or overlay filesystems, inotify watches may
succeed but events are never delivered.  In this case the daemon
would hang indefinitely waiting for the cookie event, which in
turn causes the client to hang.

Replace the infinite wait with a one-second timeout using
pthread_cond_timedwait().  If the timeout fires, report an
error and let the client proceed with a trivial (full-scan)
response rather than blocking forever.

Signed-off-by: Paul Tarjan <github@paulisageek.com>
---
 builtin/fsmonitor--daemon.c | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 4d52622e24..110fe5fb55 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -197,20 +197,31 @@ static enum fsmonitor_cookie_item_result with_lock__wait_for_cookie(
 	unlink(cookie_pathname.buf);
 
 	/*
-	 * Technically, this is an infinite wait (well, unless another
-	 * thread sends us an abort).  I'd like to change this to
-	 * use `pthread_cond_timedwait()` and return an error/timeout
-	 * and let the caller do the trivial response thing, but we
-	 * don't have that routine in our thread-utils.
-	 *
-	 * After extensive beta testing I'm not really worried about
-	 * this.  Also note that the above open() and unlink() calls
-	 * will cause at least two FS events on that path, so the odds
-	 * of getting stuck are pretty slim.
+	 * Wait for the listener thread to observe the cookie file.
+	 * Time out after a short interval so that the client
+	 * does not hang forever if the filesystem does not deliver
+	 * events (e.g., on certain container/overlay filesystems
+	 * where inotify watches succeed but events never arrive).
 	 */
-	while (cookie->result == FCIR_INIT)
-		pthread_cond_wait(&state->cookies_cond,
-				  &state->main_lock);
+	{
+		struct timeval now;
+		struct timespec ts;
+		int err = 0;
+
+		gettimeofday(&now, NULL);
+		ts.tv_sec = now.tv_sec + 1;
+		ts.tv_nsec = now.tv_usec * 1000;
+
+		while (cookie->result == FCIR_INIT && !err)
+			err = pthread_cond_timedwait(&state->cookies_cond,
+						     &state->main_lock,
+						     &ts);
+		if (err == ETIMEDOUT && cookie->result == FCIR_INIT) {
+			trace_printf_key(&trace_fsmonitor,
+					 "cookie_wait timed out");
+			cookie->result = FCIR_ERROR;
+		}
+	}
 
 done:
 	hashmap_remove(&state->cookies, &cookie->entry, NULL);
-- 
gitgitgadget

