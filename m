Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60592DECA8
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 04:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775710786; cv=none; b=k/rcY4zNicQTQvfMa+xWqiuIE+zQYSXUeHwkz+N4JNsIHBGmGAdeMB/3Y9xKyEt9/IcPCjtL2HNtrlFCA2mOUUjz9TzQ/uhCURRs0WRVgZ841hT2KztoqlKHXJXu2uzZMPJK1Ce7wwUoI22ob5N9aI2x8ZeEFLU3PiNfc/+k9Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775710786; c=relaxed/simple;
	bh=bxwAjsX29DnuGrakQVUobpobvvNWpqENpdU8Sgbrc0o=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=qdfkN2CIGb0gL2ByymKQUCI2jxQy3RxpjXXecwspgs4O9acQbB9mW/EyvpCagdu7AvABiOlAy3bCzLsOLKcAO25NDj3kJal4iBNTtSGvmlpqjlkQ3mW+b9qBJCfjh3DC8Vp8i6dDfzwYUmUc+IRd1SnyrA6Cyc2EppZoKZ0woww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TMCPSW6E; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TMCPSW6E"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8d68f702851so54545885a.0
        for <git@vger.kernel.org>; Wed, 08 Apr 2026 21:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775710783; x=1776315583; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jDND2JG26mR2BXpb7lJQM40f5eaB12kTc8+AZM6go+8=;
        b=TMCPSW6EXSVZPtgVOR1m7OIIh0IgU8/kNMixW5xRWdo8Ymvv+F84nif8Cz2x6JoMcO
         LQvlAjBjlnT9l3m9uCoQ2aopWOi1v9gZF3UD0Av9bzmPPccNCLmRT+Z6UndxTC6suuye
         2b78byndPD5wevxXtci/wrMB4m2+WLt9qEQAKba0Je9kFMhup5mrUKH2tF0eVQm4bbDO
         iRC1AO7HGImTwvw1FdfYnXRBXKXfbRDg7DDp8f2wzmCeYdzs8O6dyeiuuNnMj/7J1LT+
         KgEg1j86Z7FOIMhkoxPSEx/m018pymmPeMbnG/ICtSbuBum0jZGmHsViHdJlBodxdmZn
         DMwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775710783; x=1776315583;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jDND2JG26mR2BXpb7lJQM40f5eaB12kTc8+AZM6go+8=;
        b=j8gUkaflySMKu43BcVMfGBSK3+kOrWOyglC6kM3J2eETPN9iCDTWkTUCDlMRZCxueF
         lbhRU5Qd/bDGefPITbgXtyhlDALyqaAsHUYmPb8Dgk+yQxux63qDSfyskFAdMWB8a0lA
         x+nPSDg9E2NjH5DevEWf17bHNjYy7DKR2ruDGg6Ew574ZkCO8seRcNxtnVx5KKG1rSzZ
         p6ldK1ECCl4doMI4FzX1pBZdk85tCcdi8lacdMDO6YIqTCGl4OwxhB+asRPtB2moX5kZ
         m+KDL4GeEIj92ijEmyMzV+Ul71Kqrzl+uRtMRISjRkOJ5lghFzjvF8MzgnkBFFw93rW/
         lgWA==
X-Gm-Message-State: AOJu0YwmMiokC694fI4/VD75BXfDVCnqiIOJXjyqpDqhJB1KyiJ/mK0b
	tdVMfrw77PGtQO1VyTZMAaq/zjhvYG8sXtYbpU6AL6GSW/DaufdHNIIWIb/0ZA==
X-Gm-Gg: AeBDiesWntAYKMLxcxVDzLZIEN2LCL9kr4ZB9qO4CimTBVacevH2Lkq+JG7AaBdx/dK
	iXOsNeZetPXTl1QLok6i1rA3k9Ov9fQqeWooRQe6lN7YXwFdSbB8a1tHPBjICF2EdwHWi3k9bL0
	fNFkihjDr/R0nWMoMbfIVBzfSsGOVRF3K4CTyfgvKO0mdTZxTjWlY+ZGB+PbP4qjgXg1x2NJUP5
	y94fbEEePOsphW9462z+9ReGS6zGmMOYmraupbYQvIk6L7rVOqows0aTEaaNWfTTmio8vUnwQzf
	TcxFPmCrkzBNFm0Biqk844C6to6Ih/xx4diEoFygKfOWPVVgkMpsRw/8fg9caDCnyzht9KEULf4
	QmNtXo4mCv1LkJWOKOskhfGLcX5pgF8X7nVrrzr51Jq0UtanYWX/K/CiV2ucaWq/wCs+Ti2pEIz
	uSlY/HKURylIdXK4MJPcmxSgMYPCY=
X-Received: by 2002:a05:622a:2299:b0:50d:9e8d:9837 with SMTP id d75a77b69052e-50d9e8d9b22mr173748651cf.11.1775710783198;
        Wed, 08 Apr 2026 21:59:43 -0700 (PDT)
Received: from [127.0.0.1] ([172.172.153.36])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac72035009sm19572286d6.21.2026.04.08.21.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 21:59:42 -0700 (PDT)
Message-Id: <7b62c95c44bf1981d576e19aca77d26ce77f57b5.1775710775.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v14.git.git.1775710775.gitgitgadget@gmail.com>
References: <pull.2147.v13.git.git.1775498098.gitgitgadget@gmail.com>
	<pull.2147.v14.git.git.1775710775.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 09 Apr 2026 04:59:27 +0000
Subject: [PATCH v14 05/13] fsmonitor: use pthread_cond_timedwait for cookie
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

