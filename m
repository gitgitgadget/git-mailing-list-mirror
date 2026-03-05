Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB031AA7A6
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 01:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772673390; cv=none; b=lV1/vEzyg8kNZc68xXKpDs17LDSnY/+9uGi/gZB906Hvu/i4a8OFMtiDh7CPkpjNzsh805m9ZBO4iVU6KWiihSg+lLyqiALk9cDRGF8orXiDVhrQZDjcnLhFrqsoT0i77op6YXScg18Gkmy5lhP+awj/rm8gzZ33kmaHsy5+inI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772673390; c=relaxed/simple;
	bh=bxwAjsX29DnuGrakQVUobpobvvNWpqENpdU8Sgbrc0o=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=AjL9C3hLozwE8STB7eg0IJqAmxoF65nHcGfh7TZwe419Xjj3Q64mo07yv9lIh0BunMY/xt697DBEdTKa4pcJ0lAlhjLsYAWAia+q26tFm2ImEzNLQskSOrACj2qJTfDM9PVcYo2ZLw8bhYZKDFZN/Pr/zVD2OOAjzvKhG1SBXZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l0bO4PbD; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0bO4PbD"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-506984b6d83so58685761cf.3
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 17:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772673388; x=1773278188; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jDND2JG26mR2BXpb7lJQM40f5eaB12kTc8+AZM6go+8=;
        b=l0bO4PbDFIxYUicHkIicf/9y5QUW1iepBLhBjVLpD6jEzAHWYaXXtD3dDWGasbXEVS
         y+KTmEHeDD2CTaTw6x/J1jGlLGuSD1ND4cC8ZeHBC5OkSjgLoed5YWFVOcEqz6i0QNFQ
         hJKdw6Nnzf7qIsVl8de64sSp0iiY73Po/b5led3PAQRqQY2+X2ZE9KtHSMehJK5hh4jQ
         pLo29Jjae1sWfPBT14ndVh8DRoog/uajwvY+MlpG2NGJnZcOMrrjiXgesH45R/HyqieP
         tjpg/dpTMrkG0/Vw/3eM+bjupnjPIHP5gZIZsIPXgcP7UzMycwN4Lm1YB/etKMxAUk0h
         Ttkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772673388; x=1773278188;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jDND2JG26mR2BXpb7lJQM40f5eaB12kTc8+AZM6go+8=;
        b=aWhBm8tkxkDNb0sJibV4NKsBm7eG+X1gZBiL5rqGaryOItCvDty7/LyCF9TmRPI2Wc
         11WmojbQF2nZSk16YmD4ZN4VVYaym2weri5wogziCBt4yBfjxTVMZU7ZzyLZ7aAY0VDz
         yiFDwGDiZ6CmqDLSh4YzJqoFWcAr2g2oNKG5POEFJpRNCuVdSwAh4cbGuyn9RPKTmJ3v
         NSoJjsqAU/F5oJ7Tzx3Tu3Sz0bGQNHf+Ip7LM1e1yWLIGPgGl0EQp/h7wEKR5fC9HNwG
         79NQ+qkcvfId2NDqSimgVajhqqPw02jDF3eUZ2ytV3kwCC62ciSHxq+Q1xvh93FMLE3E
         Jetg==
X-Gm-Message-State: AOJu0YxohIu16Sg6eAWy1LKfFbMOE5Ste/Z216+ZAETOn0hPnGDBQ9uP
	QFE1s7jL87fZvLj75XitosmEh1QgLYh/qnSIT6UURmlMqMdS7Uyg1PYOT90Ye4Kz
X-Gm-Gg: ATEYQzxQhheAUp4xNOBO3h+KG5Npq7UN3rlO1CyMNhiBHX7hpqbvOgnYx7PVNzfhOX7
	dL684QMjI9qKWDP7lP9+qVtM3ebjWxBBR6IOGNZaxLnjr+vgL9CIk3RMaNdQrv8M6MwWWtae49A
	5k1qCQhAT2BCkAD0CRFAn9v13WVHNv4QyTtxi59mVsxEuMggZs0xP9qSgx0/bAc5KGjEEIEtwiM
	gWtJ98029K9ygZpI71ETq0Hyd32370qV/+enj61ps2jWkHp52DlDh0DlXBzsOb+KzVZGsgjhD4u
	LFpM3j+S7xPCRNr6tzpweO/wBA+mfTK+kWYwS3Q609LmY0195qQFPMnCzIAMkHIYSwJ2TwsbEAi
	s2EpAmqj6dJuy22ZE7+Fq6lRPKRfm7occBGqrR5MJeYpNfduCA+3vLPuXKw/YBQCtqjXvokfc7Y
	7SE9x8EibpKJu2lk3+GIeHQ0E=
X-Received: by 2002:a05:622a:448:b0:506:9d3e:67ee with SMTP id d75a77b69052e-508db3fb474mr55566481cf.71.1772673388099;
        Wed, 04 Mar 2026 17:16:28 -0800 (PST)
Received: from [127.0.0.1] ([51.8.152.229])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50744af0731sm188423651cf.31.2026.03.04.17.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 17:16:27 -0800 (PST)
Message-Id: <b1081d1e1370bb9c9755d0635e7c7466c954f046.1772673378.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v10.git.git.1772673378.gitgitgadget@gmail.com>
References: <pull.2147.v9.git.git.1772671920.gitgitgadget@gmail.com>
	<pull.2147.v10.git.git.1772673378.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 05 Mar 2026 01:16:10 +0000
Subject: [PATCH v10 04/12] fsmonitor: use pthread_cond_timedwait for cookie
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
    Paul Tarjan <paul@paultarjan.com>,
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
index d8d32b01ef..c8ec7b722e 100644
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

