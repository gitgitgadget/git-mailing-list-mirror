Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AED23DA5B6
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 18:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772648138; cv=none; b=IUNV39yxJdCuma03Jkf6iXAyEThmJhfYye+2wIHfdCbk2Y6gWd/mUDN5he6Upkf0MQ/dmFr+rcJBPuT8xNPLHrfzTCDqDcuAQgN8cTq/uQev+sw5RFSVqa6xx+GExpbSXPuRigbRhj9Rq6VQQTpgMbz/d59tYyWZ6avwQlZ/VmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772648138; c=relaxed/simple;
	bh=bxwAjsX29DnuGrakQVUobpobvvNWpqENpdU8Sgbrc0o=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=bLGwUssS5tfIOvmDhhFqgyLgFDCzM9hWv8o24893prjgYDOARuM8btHc1tUvSpxINiNR9qeVOjUzZLA77/L8Z3VsWsWkuiNgQ7vL/+JvNJkeFHte8hh7JiIq7kq16P3VrdE09VIJ3GYzkfNsRyu9DwVccnjN5dc11iqvTM+knp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QxUV3jS8; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QxUV3jS8"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2be3bdfda8eso16436eec.1
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 10:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772648134; x=1773252934; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jDND2JG26mR2BXpb7lJQM40f5eaB12kTc8+AZM6go+8=;
        b=QxUV3jS81Y0UC1pVRCgTR7O+qie/+ciKb4cAOHY2p+UChWo6DRI3UC0xgOtsYfApGV
         a/j/8iBrc7r7t/xZaU6zcUvkTcwsnKtmIDXEba/EKM4Oe++jEqRo3LMr9UPFGWP/zu/U
         exwGIXdfL5ZtD08PTemx7chyiBgpJKIfTRHHIpnYwIwAzIEUYBaAWwAZmUcGN5ZiThex
         4tWxtGfdy3psMPzgT2bhSs143t9YfFOpjau6zko3kR9bPHSOgbjnvuRKZYRGlZvgzkoy
         1Dw77VmPlHC64O3y7q2hSvGniocwmAjusW9UCYxwY9S7+sgsprBytZlEOALbD86tBNib
         FctQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772648134; x=1773252934;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jDND2JG26mR2BXpb7lJQM40f5eaB12kTc8+AZM6go+8=;
        b=IE1acgDJP3S4Q1cwOtizioqv31Z70w/KtK4TgnxzN7kQauRtxx++waFM7zxYKkIP0v
         RrBFKcGNi3pr5dLL3JM/KRQPoNQB/lTFj/r1k4gkJ0017BIpOR9xwooAwq2/onJys+yn
         Fo9MDNfJsLBHp/D4ENmyUTHkLbP3CS1Qcvtht2zUsEzdGwEZRajrHcYx5O2zAwNTPr1Q
         5vfJqwJKjWuf2FbFJqd29vjsEqdG6SesCJIA+MEWqAGiROX2hf2cuJmOlASuSI8p/Tsr
         PXUiTD66y914A20+Dw6WCtAIncp+7LLaDPpAms4R5BwVXSA6KFEelCZebxxoqJ2szlw6
         92Iw==
X-Gm-Message-State: AOJu0Yx2U3vh/+AXYXZUQMl6DrCxCndUqPhpF7cFaCJS1n7xD0yGqTtB
	ABLdDdJcKD7OQ39tD66/t1hCE/XWgkUYRberDnyDvXclLxaJi1iZnBV3y7LBWfqp
X-Gm-Gg: ATEYQzzPogqzY78w1qa5+Hmq7FwzuV1551GM+FcJvC2TyMQzFFT5b+G8bW0TsfiZFeH
	J7d1hJYSeHyvLO0n+3SAoLhSRcSy3RmskX1+B9kylcHwi2IC0KYBQtzTBCaAMTQG9Rm3SEWJIsL
	HtN2LB0ym8dgypHWq5f2nysleJZ2u7Y7IEMbN98fNVGSCm1WfJWJZGIsR7EPDwd/6+f30Nrznej
	fHVrmI2z+9ZkUsnF+cmQJTxU/q7kLh0XnnHaRZfBIN4MH3yTV51BA/e+xlOUG3u92aM7NXN+fWi
	fxluU4gALDPxJiJebPtfHkEL4q1G10Z2iBVjVMJ3NQvOx901s+2af5IjEcP8oDS6w82O9/vqBhj
	3v6TWrqKQvNeMUEBuku6bP7AoHr3Evrfp9hxIGCfue4Hj0nWKCkKJc/Sym4aQknghz74ocHw1b3
	ny4/aGJ9twXqkZPJivlLBZd8PpUw==
X-Received: by 2002:a05:7300:6423:b0:2b8:4a34:6c39 with SMTP id 5a478bee46e88-2be30fdb77amr1182209eec.16.1772648133556;
        Wed, 04 Mar 2026 10:15:33 -0800 (PST)
Received: from [127.0.0.1] ([57.154.172.168])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdd1f7e955sm15602328eec.32.2026.03.04.10.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 10:15:33 -0800 (PST)
Message-Id: <b1081d1e1370bb9c9755d0635e7c7466c954f046.1772648125.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v8.git.git.1772648125.gitgitgadget@gmail.com>
References: <pull.2147.v7.git.git.1772065643.gitgitgadget@gmail.com>
	<pull.2147.v8.git.git.1772648125.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 04 Mar 2026 18:15:17 +0000
Subject: [PATCH v8 04/12] fsmonitor: use pthread_cond_timedwait for cookie
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

