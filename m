Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C376E2D249E
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 20:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772050646; cv=none; b=sInK52QgygJXDUlv7TQqE89vJAn8edzWM49l/L7U4EmKOGxX6sYyvW2zP3200hYxtj9BKOwJIDHUZOKwYM86Yokyq/aNu5pWjLywlDqXbrEWaireYTR3Swq3/ncz/iKxEkBbwSDg4mkR7Z2u41q1iQgCp2cvOmVA+k2YpX2OxLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772050646; c=relaxed/simple;
	bh=zaes5IizMyYlZoxatMqYL/cZ9eaDhUQDwVCOZWEHwv0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=m1ubHVgGv74fRZnKE8wkJ9VDVl/ssF3Ibgua/CTSNREPKKgl+WnkqtNJDsajM/KCh7P3uq1Nq1wJpfRtmJxmFg5oMeXcVqVJnma48gGLVNbWdpD59wdSMLl7VN5Ehq0nXcQ02t3aZ78mAni1sch5u1U3GPMF4jS1DvedzTwcB8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ULLCeVvJ; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ULLCeVvJ"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-896f4627dffso2203826d6.0
        for <git@vger.kernel.org>; Wed, 25 Feb 2026 12:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772050643; x=1772655443; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y//uGHBfx7icMkFDsVmEedqfYvvQv8028cvQ5KyH5qo=;
        b=ULLCeVvJHdjNTj35kRTMQk9Qcf92vU4QMKy+pc4zYkOMhLxLKTSRJYqnouPdAExo83
         IIYp0gGIkKJXuxKFZbiqgeuq8f4cGhNLXX2tqf2vuO5MmATdVVhU8szGbFP3GIzFITDR
         sX/4c5T/SW3eGic50zfO4XY0XuppthyY5kRhHgGKul7anzkKMZZ8Kq/4MjtT62XiGlxF
         kJKtoChbsjnEypDx1U979GGBwX2I9aVS0/NH2Ra2w5d5hBjkhz/OS64d8S5O3FHHtmv5
         UnD9cvdzTmjSAFWnaubwMxAqUru+dpk/MwctDrHApkphGhSAnAd4k6+woZ9upZHRpMPD
         +ZGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772050643; x=1772655443;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y//uGHBfx7icMkFDsVmEedqfYvvQv8028cvQ5KyH5qo=;
        b=Slw3ABjoeuRzsQqVoonB12fgLmAIJAVut3OAkjvic5yz1KQB5/4kNU6IXAc5/UnWH8
         ZbgdpPlHbysV4hwsfxWa15+Z/xfSd8tyGdASAY/EKJwPL+EbkUwMqL+VSWFCIAufmgtx
         nVNah7Va7c1cbmI6EdMUQYHSm4u5wSFK6NwHJJEYEPmVQ49jTZFRz4mTcm5zvKx08kb7
         l/iGhPL0jjxZi/ONupN0DvqaPtgs7Fvye7qm1lwrcbS1DUT5V+Ak5J7LdFkfqbNY9b8z
         HYt02wLGxVk8PJQzBW8OZXaLgnomOIIDun7resGfYi50iBoIvkEfXw5ekMSI4SIgXBO3
         lbpA==
X-Gm-Message-State: AOJu0YxOXLACeNfTadvJWE3imWFmKk+KvTX3HEn4X9neannsRBVfqjVT
	fyshhT6ZOJkUr9NLgdi88JDEbjfrLh4sAwiruHtsddO2dyL2EH5vXrdEm/PZCg==
X-Gm-Gg: ATEYQzzlim0In5G7VxzGmKd8lv93l2Mj99XhXaCDOUKnbzd+1Nl4H3DcEC8banxgGo8
	TZKLs2jbZVPumBp5na656S77nz/xss5Ou41OGe5OuYcP24kEl0H5ngTVF3BHgktuCZssYfwa5E8
	FMF234FKAm3ENm1OzhnIqq02QmNfUkiGD8HzkwZqPWeVfCxuMiOgRIB7L4yKD8ZjbVJQEOts5XU
	LZtNGq8CYLrfONe32u5//3hZknunVfOINt9L0J3CQ3rRMUI3kiyZ/ERFlkUmdBiFKTinsHEP7pK
	ZYq6TifSRYnumhHxnfsbNBmNJU78U+FUpdKeWgaUpYHj/ifa8b0pKgRydLhuFvGWkoxVyKlabNB
	oS6wDIDZ/u1u+6qvITaY6EHK0ywRvsqYT55S74IHCnn4IKzyaj/gbp6otKohH8RjZkDMoPRmeHN
	xfFKMjS2lMn6895TlwtL5efhUDSA==
X-Received: by 2002:a05:6214:300f:b0:895:d97:a2ba with SMTP id 6a1803df08f44-89979dacf9cmr244166816d6.67.1772050643304;
        Wed, 25 Feb 2026 12:17:23 -0800 (PST)
Received: from [127.0.0.1] ([135.119.235.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf64efafsm16240885a.6.2026.02.25.12.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 12:17:22 -0800 (PST)
Message-Id: <0051a1930349878fd25bb5d2240073beef36da7d.1772050636.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v6.git.git.1772050636.gitgitgadget@gmail.com>
References: <pull.2147.v5.git.git.1771896704209.gitgitgadget@gmail.com>
	<pull.2147.v6.git.git.1772050636.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 25 Feb 2026 20:17:10 +0000
Subject: [PATCH v6 04/10] fsmonitor: use pthread_cond_timedwait for cookie
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
index 4d52622e24..f6c406ff12 100644
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
+	 * Wait for the listener thread to see the cookie file.
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

