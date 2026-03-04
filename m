Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA963DA5DC
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 18:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772648146; cv=none; b=k5az0w7j+lG3vR1u83IIpZwt3KMOTcUwIWLUPd3w529EnMJuFN0nzGS6KLrX6ABnb6TFH1oNjqDOs9NuwEHF9xjWgZ7OqlRnIImkqZy41rWR4mGCCfRA0lG4LTzsPdmMVsio0drjGkR3XV6CVW7Wv/tRyDndvCKkabV4aiPP1JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772648146; c=relaxed/simple;
	bh=wW4L5f2UPz5JB2XuHq37kfldUvOK8IUq2BxlaQwTYkw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=n4/oOtjq4ibnJOt2f6p/Mk/LvPZOMvOldUQZ7QQi0zK2fOw5yy6z4M8CTwtGk3HeqfvpvpC+GbGjQv3yNtnGNGIzTTk7n3+JjU1nXdZDMisVVseXtFiZzAY5D4eii3ZwJW1QBkAcbye/d4jh+/QX0HhK2dD9Kk2Mw6I6eeST3Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=na3zw348; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="na3zw348"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1275910b930so4455069c88.0
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 10:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772648143; x=1773252943; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C83czoS95l3vv2klvVyic5XtiDMyrhb+y+/EC4Hbov4=;
        b=na3zw348NCGhMzzTN3HUlu3YZenPZzRGlDBiPYJFeCTkqD2/26mud94vqbn7hBjheX
         u/GeJvVgZg85PWWxj8a/5eNQPvn+wHc4BTN9IrOD0SLDYTnjhI8mnpnnCxe6vVHZu3tC
         RUXSGgk6B1o+YwqJcTtwkejP7N031V0Ywoksn7Ucd8lCGg51vHCCEQWrj8q/Tcq9k5kV
         6HOEP6pN9VZFQNJ1n5A4/wEMzGj3CHKSwGjHLXPKRokiy2m0FKkK0k1npFxm31iQkpoF
         UcAxAnx1Xc/qPlpN4is6+kD8PisPR1/WoSbLdpuUpebFOvRDf/cYjttLepRurD65wAil
         DY3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772648143; x=1773252943;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C83czoS95l3vv2klvVyic5XtiDMyrhb+y+/EC4Hbov4=;
        b=IA9rnWVYmoSbopweyNi5B7ZRTRqHzwtcAQJmNZy8DZky3wzQyR7PXTXrIxNzhI9RFV
         6eOH5EGuofSOuSqYkSUC+OY0Ty+jg5FmhC+b6Kog4cwJ3BDL46ekbA26TM04amYvXmPT
         RUnm6046V4M1s5ESkHArBLMo0hjG4Co9YInhiLilB8EvTV/snSgFJYHrApjfZIQBiRe8
         HU1TFhhuwshKEnUfKIAvgBImJQvlEsdoXPh3e6lTXwbTLXboydr71/tzqSDb9Rqii89r
         QXGr1RCslJX96qcSdg/HpGzKmGXd324aaKIBbxX4tTMke5S2obwXQHIlyMbky+O1LTPq
         C/tg==
X-Gm-Message-State: AOJu0Yzb+z4YNZC/DEj/y8DVSxnQwTu5lWbHEZW0TCkD4ISta4Fw+o/b
	BlCVhejJdiUkuFoZQ249vd2Bb28jV+VHns5maIfwxWBm/5BSNmo2ccBUyF86nU2R
X-Gm-Gg: ATEYQzwi1+zGy+7jMJiRWQEQmWro/1XfrXQDOJV6pAYrcvsOP8qoZ7HkaAGbDC+As8V
	zyd6+qRrwHmBNQRiHx9qF5PFW5ZF76hrDRmfpZ0qpDlR1piMLjmqmHAtvCKNQC1PAMCLAU+Kpc/
	aJnsiVpEv/VRsnveHsVeuVGmxnszPDtk+Srh5/3ZFDOxOgfqgSK229pIIk+4lBJELEg3cNjf6LI
	BpDX/7KbuWG5KUcWqu5UMvDN9ZzsBZiDD7HqyGdH9mfR+VEja4RahZ17ZbJQQAQWOuq9me71UGX
	+2f8tVNwc0p3clBE8G/RvzS6gkDQlOuQH0t5s3CHG9yzeka46PburITyY8F3e2BLxnnjaUPaJCP
	tihXdsbeg2DoWn4swNwtunx7vpqr4irizTBMr5cotR/Qr296LfrFKsOZGNLlu4zPQ4xP7QxUdsM
	kzkGyxm3hIgxO4MqlfZMWL7JRYAg==
X-Received: by 2002:a05:7022:4183:b0:127:4da1:ecc0 with SMTP id a92af1059eb24-128b6fd96c5mr1015601c88.11.1772648142778;
        Wed, 04 Mar 2026 10:15:42 -0800 (PST)
Received: from [127.0.0.1] ([57.154.172.168])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128bac04455sm309391c88.1.2026.03.04.10.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 10:15:42 -0800 (PST)
Message-Id: <72125ac20fd0e4d8fdef419feed405c6c45ca0f5.1772648125.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v8.git.git.1772648125.gitgitgadget@gmail.com>
References: <pull.2147.v7.git.git.1772065643.gitgitgadget@gmail.com>
	<pull.2147.v8.git.git.1772648125.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 04 Mar 2026 18:15:23 +0000
Subject: [PATCH v8 10/12] fsmonitor: add timeout to daemon stop command
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

