Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939BB386551
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 06:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774937988; cv=none; b=S+22Mrn4SlkqHnOinWuHJ26bZq7ZHXgkJbX3RPIF6VJJyfcCYuB5NAEAoXrmsw1tvN7nMnph01Vmpx2dHdEnBN/clG13GizgizHXnZLliFqG4jvzbggm0YDlQYwtkIRQLTSBilZ7naQz8WiUMs+wCI3EhxQaDTiCnqeC4/i11h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774937988; c=relaxed/simple;
	bh=wW4L5f2UPz5JB2XuHq37kfldUvOK8IUq2BxlaQwTYkw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=U5mavisOBDQD9rLPK6j0RyfEHLdh1Kcgr5Sqzjt+dZmVSIc6GNxC7DysDu0ltm+cAuxRb0c1s4xCvPUZSkvR3TidV7mQggs9w5oX0dLgkvstwmpgp36aJu66xaYztg2sgcHcb8XShA2ZYkLeJk7VuhEd9Bfgad1dhHUL3KWH2as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=alYsASFW; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="alYsASFW"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-4645dde00a7so4617384b6e.1
        for <git@vger.kernel.org>; Mon, 30 Mar 2026 23:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774937986; x=1775542786; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C83czoS95l3vv2klvVyic5XtiDMyrhb+y+/EC4Hbov4=;
        b=alYsASFWDfuHegH89tdVpMEiOB6ZaO7NuRyPYoMou4iXvUlQTtLQ42k72CK9Z2zwYG
         VsLKjtgmzHE60ip23TvV4f2gJNSdBLYpDuzy0zrc7ImBKbhbWKBoJGu/ZShwfTRtNbZv
         gHmsqBggAdf/w4nkd/GDW6TV175Z2pCA1r2hgQNryHzbKI8wAB7RDb1TfS9MLe7JVRBo
         V9116eHhUfqUf63wGMVnqG8DIJnesT0skBYWa9UWhOq6GkBDtEj1gllZmuOuaODyxqoT
         GK4OD5L6FnjogJBkt3eG2EkuEYqHEN25x6aTO0DUneD331/kg9NICPMsZAclk62gC7vd
         WSYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774937986; x=1775542786;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C83czoS95l3vv2klvVyic5XtiDMyrhb+y+/EC4Hbov4=;
        b=P5ek0EeFN/9V5c46SXUWuE63d0P6yACFK+Fd/xT9+Fz76hgCt5SBJ9MVtq6EaD6Pxr
         MzZKb3eYcS9X86ZUXEBZNe/+5rVbCEhl0O3WCG+hcGIf3ly0Vi9U0Lcne4Jj3Gya+CSm
         c/S0Qer+zRrK1I8Q3Rfw7UpEyg3ajrHVc3D9qGWVa7mav34V7XDPGr3mm3FSHeVSzVjj
         bIj26vMrztM+uC6pf05UGGGTYnwBkl7qVQT4fRibnVxG2IrC5qGqLL1ao8/u1GmsE191
         4+Kf+lFsnNyWLv97GcaYAIcOzu5HSonFFBS9higRVR1qBlA+XwWi4WiIKNUt/OR5RxkK
         SSrA==
X-Gm-Message-State: AOJu0YzxMYvxJ5dwceKTzgMGk9MogGEZiGcn+5OXrxKbu/kUD16367Jw
	7V9gIdoBXodLKiioUPDXV0SxXUa1ofCDPm3HUcDj7+ZanS/UJhCZcYT5HRkLyXRM
X-Gm-Gg: ATEYQzx68haF5VAHspZaOLjTWpgFp5OFdnQacTmTzdMhHc9TSpnmzyz0HJ/ebAXA0cQ
	FLRoFEC12nRi7hVuJTdPAHtQKR03hsIybol65m7UqEPx2DZ7fxo1Kq6futDtyBNzvQf4oUjUaTr
	e8Ic31IY0LNJ0Il4kbQvrGUjcQ0/Ng86kEwbXH7h3UU20I8j3clMV8wM0SwD5uEKKsaodkXXQJX
	Iwx89SoM7IbI/cxv7RrJsIzDcyXk/9uzcY9Bx7JRYAxPKj2g4ZJFNld+Mn2zjFq2hPnSd2ixeJ4
	w86a/wyxvxqkB4Q8b9wbccK+vm6v77jPc0h7F7IhRcrtG9ReG5G27QzAJ6uSfL9xqwMBatEDrp4
	mex0O9w1liknVR+NwHvFdpaz6ip2pgnidZi10NDu+WNM1ty3V6mk7FUmETZegCOdvLS+2/d+KZX
	mzJPVQIKp66SH9d35LC6YZNsaDePM=
X-Received: by 2002:a05:6808:1506:b0:44f:f025:303e with SMTP id 5614622812f47-46acdb2be89mr1330177b6e.6.1774937986235;
        Mon, 30 Mar 2026 23:19:46 -0700 (PDT)
Received: from [127.0.0.1] ([52.165.251.162])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7da0a38a746sm8146712a34.8.2026.03.30.23.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 23:19:45 -0700 (PDT)
Message-Id: <e6bc3bfcb285b48bff804460943aef17f0e00b6d.1774937958.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v12.git.git.1774937958.gitgitgadget@gmail.com>
References: <pull.2147.v11.git.git.1772693712.gitgitgadget@gmail.com>
	<pull.2147.v12.git.git.1774937958.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 31 Mar 2026 06:19:15 +0000
Subject: [PATCH v12 10/13] fsmonitor: add timeout to daemon stop command
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

The "fsmonitor--daemon stop" command polls in a loop waiting for the
daemon to exit after sending a "quit" command over IPC.  If the daemon
fails to shut down (e.g. it is stuck or wedged), this loop spins
forever.

Add a 30-second timeout so the stop command returns an error instead
of blocking indefinitely.

Signed-off-by: Paul Tarjan <github@paulisageek.com>
---
 builtin/fsmonitor--daemon.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index b2a816dc3f..53d8ad1f0d 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -86,6 +86,8 @@ static int do_as_client__send_stop(void)
 {
 	struct strbuf answer = STRBUF_INIT;
 	int ret;
+	int max_wait_ms = 30000;
+	int elapsed_ms = 0;
 
 	ret = fsmonitor_ipc__send_command("quit", &answer);
 
@@ -96,8 +98,16 @@ static int do_as_client__send_stop(void)
 		return ret;
 
 	trace2_region_enter("fsm_client", "polling-for-daemon-exit", NULL);
-	while (fsmonitor_ipc__get_state() == IPC_STATE__LISTENING)
+	while (fsmonitor_ipc__get_state() == IPC_STATE__LISTENING) {
+		if (elapsed_ms >= max_wait_ms) {
+			trace2_region_leave("fsm_client",
+					    "polling-for-daemon-exit", NULL);
+			return error(_("daemon did not stop within %d seconds"),
+				     max_wait_ms / 1000);
+		}
 		sleep_millisec(50);
+		elapsed_ms += 50;
+	}
 	trace2_region_leave("fsm_client", "polling-for-daemon-exit", NULL);
 
 	return 0;
-- 
gitgitgadget

